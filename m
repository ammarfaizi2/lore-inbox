Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293242AbSCJVIq>; Sun, 10 Mar 2002 16:08:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293238AbSCJVIg>; Sun, 10 Mar 2002 16:08:36 -0500
Received: from as2-1-6.lh.m.bonet.se ([194.236.130.162]:13573 "EHLO alpha")
	by vger.kernel.org with ESMTP id <S293237AbSCJVIV>;
	Sun, 10 Mar 2002 16:08:21 -0500
Date: Sun, 10 Mar 2002 22:08:02 +0100
To: linux-kernel@vger.kernel.org
Subject: directory notifications lost after fork?
Message-ID: <20020310210802.GA1695@oskar>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.27i
From: Oskar Liljeblad <oskar@osk.mine.nu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The code snipper demonstrates what I consider a bug in the
dnotify facilities in the kernel. After a fork, all registered
notifications are lost in the process where they originally
where registered (the parent process). "lost" here means that
the signal specified with F_SETSIG fcntl no longer is delivered
when notified.

How to reproduce (tested with 2.4.17):
  gcc -o dnoticebug dnoticebug.c
  dnoticebug &				# run in background
  cat dnoticebug.c >/dev/null		# "notified" should now be printed
  cat dnoticebug.c >/dev/null		# nothing is printed this time
  
If you comment out the line with fork below, "notified" *will* be
printed every time you cat dnoticebug.c.

I'm not subscribed to the list so I'd appreciate if you CCed me.
(Otherwise I'd have to use the archives :) Thanks.

Oskar Liljeblad (oskar@osk.mine.nu)

===

#define _GNU_SOURCE
#include <fcntl.h>
#include <signal.h>
#include <stdio.h>
#include <unistd.h>

static void handler(int sig, siginfo_t *si, void *data)
{
	printf("notified\n");
}

int main(void)
{
	struct sigaction act;
	int fd;

	act.sa_sigaction = handler;
	sigemptyset(&act.sa_mask);
	act.sa_flags = SA_SIGINFO;
	sigaction(SIGRTMIN, &act, NULL);

	fd = open(".", O_RDONLY);
	fcntl(fd, F_SETSIG, SIGRTMIN);
	fcntl(fd, F_NOTIFY, DN_ACCESS|DN_MULTISHOT);

	while (1) {
		pause();
		if (fork() <= 0) exit(0);
		wait(NULL);
	}
}
