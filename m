Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261719AbSJIOAf>; Wed, 9 Oct 2002 10:00:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261723AbSJIOAf>; Wed, 9 Oct 2002 10:00:35 -0400
Received: from 213-187-164-2.dd.nextgentel.com ([213.187.164.2]:24711 "EHLO
	mail.pronto.tv") by vger.kernel.org with ESMTP id <S261719AbSJIOAd>;
	Wed, 9 Oct 2002 10:00:33 -0400
From: Roy Sigurd Karlsbakk <roy@karlsbakk.net>
Organization: ProntoTV AS
To: Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: softdog doesn't work on 2.4.20-pre10?
Date: Wed, 9 Oct 2002 16:07:32 +0200
User-Agent: KMail/1.4.1
MIME-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_KKWPO9AXSX59ZFWUG9RS"
Message-Id: <200210091607.32769.roy@karlsbakk.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--------------Boundary-00=_KKWPO9AXSX59ZFWUG9RS
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: quoted-printable

hi

I have the softdog running on some of my machines, and I noticed it didn'=
t=20
work very well. I've got this little program feeding the dog (attached), =
so=20
if it gets killed, the machine should reboot.

but - this doesn't happen!

can anyone take a look at this?

roy
--=20
Roy Sigurd Karlsbakk, Datavaktmester
ProntoTV AS - http://www.pronto.tv/
Tel: +47 9801 3356

Computers are like air conditioners.
They stop working when you open Windows.

--------------Boundary-00=_KKWPO9AXSX59ZFWUG9RS
Content-Type: text/x-csrc;
  charset="us-ascii";
  name="feedthedog.c"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename="feedthedog.c"

#include <sys/types.h>
#include <sys/stat.h>
#include <sys/ioctl.h>
#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <string.h>
#include <signal.h>
#include <syslog.h>
#include "watchdog.h"

#define TIMEOUT_DEFAULT 60

int fd;

void sig_any() {
	syslog(LOG_EMERG, "feedthedog killed by untrapped signal. System will be rebooted by watchdog.");
	exit(0);
}

void sig_term() {
	syslog(LOG_NOTICE, "Exiting, shutting down watchdog...");
	if (write(fd, "V", 1) == -1) {
		syslog(LOG_NOTICE, "Failed!");
		exit(1);
	}
	if (close(fd) == -1) {
		syslog(LOG_NOTICE, "Failed!");
		exit(1);
	}
	syslog(LOG_NOTICE, "Watchdog successfully shut down!");
	exit(0);
}

void get_info() {
	int timeout;
	struct watchdog_info info;

    ioctl(fd, WDIOC_GETTIMEOUT, &timeout);
    syslog(LOG_INFO, "Watchdog timeout is %d seconds\n", timeout);

	ioctl(fd, WDIOC_GETSUPPORT, &info);
	syslog(LOG_INFO, "Watchdog options: 0x%04x", info.options);
	syslog(LOG_INFO, "Watchdog firmware ver: %d", info.firmware_version);
	syslog(LOG_INFO, "Watchdog type:%s", info.identity);
}

int main() {
	int i,timeout;

	openlog("feedthedog", LOG_PID, LOG_DAEMON);

	if ((fd = open("/dev/watchdog", O_WRONLY)) == -1) {
		perror("open");
		exit(1);
	}

	timeout = atoi(getenv("WATCHDOG_TIMEOUT"));
	if (timeout <= 0) {
		syslog(LOG_WARNING, "Timeout set to %d. Using default.", timeout);
		timeout = TIMEOUT_DEFAULT;
	}

	get_info();
	for (i=1;i<=_NSIG;i++) {
		switch (i) {
			case SIGSTOP:
			case SIGKILL:
				break;
			case SIGTERM:
				signal(SIGTERM, sig_term);
				break;
			default:
				signal(i, sig_any);
				break;
		}
	}

	if (fork())
		exit(0);

	syslog(LOG_INFO, "Watchdog feeder started");

	while (1) {
		write(fd, "\0", 1);
		sleep(10);
	}

	return 0;
}

--------------Boundary-00=_KKWPO9AXSX59ZFWUG9RS--

