FROM ubuntu:16.04

RUN apt-get update; apt-get clean

# Install x11vnc.
RUN apt-get install -y x11vnc

# Install xvfb.
RUN apt-get install -yqq xvfb

# Install fluxbox.
RUN apt-get install -y fluxbox

# Install wget.
RUN apt-get install -y wget

# Install wmctrl.
RUN apt-get install -y wmctrl

# install google chrome
RUN wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
RUN sh -c 'echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list'
RUN apt-get -y update
RUN apt-get install -y google-chrome-stable

# install chromedriver
RUN apt-get install -yqq unzip
RUN wget -O /tmp/chromedriver.zip http://chromedriver.storage.googleapis.com/`curl -sS chromedriver.storage.googleapis.com/LATEST_RELEASE`/chromedriver_linux64.zip
RUN unzip /tmp/chromedriver.zip chromedriver -d /usr/local/bin/

# set display port and dbus env to avoid hanging
ENV DISPLAY=:99
#ENV DBUS_SESSION_BUS_ADDRESS=/dev/null

# Add a user for running applications.
RUN useradd apps
RUN mkdir -p /home/apps && chown apps:apps /home/apps

COPY bootstrap.sh /

CMD '/bootstrap.sh'