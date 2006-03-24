Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWCXO7X@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWCXO7X (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 09:59:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932493AbWCXO7X
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 09:59:23 -0500
Received: from smtpauth04.mail.atl.earthlink.net ([209.86.89.64]:21437 "EHLO
	smtpauth04.mail.atl.earthlink.net") by vger.kernel.org with ESMTP
	id S932177AbWCXO7W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 09:59:22 -0500
To: linux-kernel@vger.kernel.org
Subject: [cfq] sched_idle process stalled for 1 minute; strange ioprio too
X-Mailer: MH-E 7.91; nmh 1.1; GNU Emacs 21.4.1
Date: Fri, 24 Mar 2006 09:59:14 -0500
From: Sanjoy Mahajan <sanjoy@mrao.cam.ac.uk>
Message-Id: <E1FMnkx-0003aE-08@approximate.corpus.cam.ac.uk>
X-ELNK-Trace: dcd19350f30646cc26f3bd1b5f75c9f474bf435c0eb9d478a122c03f3aaf2a203823c84ab7bcd28816188b77fa99435e350badd9bab72f9c350badd9bab72f9c
X-Originating-IP: 24.41.6.91
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm trying the cfq io scheduler (in vanilla 2.6.16-rc5, TP 600X, Debian
testing/unstable) and noticed that a massive 'apt-get upgrade' (300MB
downloaded, 266 packages to upgrade) stalled at the 'Setting up sed'
line below, for about 1 minute.  The machine was otherwise idle (top
showed no processes chewing CPU), and no disk activity was going on --
strange since an 'apt-get upgrade' usually makes 'dpkg' chew on the
disk.

<snip>
(Reading database ... 184123 files and directories currently installed.)
Preparing to replace sed 4.1.2-8 (using .../archives/sed_4.1.4-5_i386.deb) ...
Unpacking replacement sed ...
Setting up sed (4.1.4-5) ...
<stalls here for about 1 minute>
<snip>

I had ioniced the shell to SCHED_IDLE with

  ionice -p$$ -c3

Then I ran the 'apt-get upgrade' so that the setting would be inherited.
After the minute-long stall, it continued as if nothing had gone wrong.
Maybe nothing is wrong, and it's something strange about dpkg needing a
lock and having too low a priority to get one (but who would it fight
with)?

While the dpkg was stalled, I did 'ps x' in another root window and
these were the interesting ones:

 4823 pts/7    S+     0:04 apt-get upgrade
 5228 ?        D      0:00 [pdflush]
 5261 pts/7    S+     0:01 /usr/bin/dpkg --status-fd 29 --unpack /var/cache/apt/
 5267 ?        S      0:00 [pdflush]
 5268 pts/7    D+     0:00 /usr/bin/dpkg --status-fd 29 --unpack /var/cache/apt/
The ionice.c utility, with

  for n in `ps x|tail +2 | awk '{print $1}' ` ; do 
    ionice -p$n ; echo
  done

produced these entries for some of the processes above:

  pid=4733, 24583
  idle: prio 7

  pid=4823, 24583
  idle: prio 7

  pid=5228, 0
  none: prio 0

  pid=5261, 24583
  idle: prio 7

  pid=5268, 24583
  idle: prio 7

I don't understand the ", 24583" in the pid lines.  In ionice.c it comes
from this code:

		ioprio = ioprio_get(IOPRIO_WHO_PROCESS, pid);
		printf("pid=%d, %d\n", pid, ioprio);

So ioprio_get is returning a strange value -- or is 24583 correct?
Perhaps I should have set the priority explicitly with "-n" when I did
"ionice -p$$ -c3", but I thought IOPRIO_SCHED_IDLE didn't need one since
there was only one idle class.

Here is the full ionice.c (unmodified by me -- I'm pretty sure I got it
from lkml):

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <getopt.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <asm/unistd.h>

extern int sys_ioprio_set(int, int, int);
extern int sys_ioprio_get(int, int);

#if defined(__i386__)
#define __NR_ioprio_set		289
#define __NR_ioprio_get		290
#elif defined(__ppc__)
#define __NR_ioprio_set		273
#define __NR_ioprio_get		274
#elif defined(__x86_64__)
#define __NR_ioprio_set		251
#define __NR_ioprio_get		252
#elif defined(__ia64__)
#define __NR_ioprio_set		1274
#define __NR_ioprio_get		1275
#else
#error "Unsupported arch"
#endif

_syscall3(int, ioprio_set, int, which, int, who, int, ioprio);
_syscall2(int, ioprio_get, int, which, int, who);

enum {
	IOPRIO_CLASS_NONE,
	IOPRIO_CLASS_RT,
	IOPRIO_CLASS_BE,
	IOPRIO_CLASS_IDLE,
};

enum {
	IOPRIO_WHO_PROCESS = 1,
	IOPRIO_WHO_PGRP,
	IOPRIO_WHO_USER,
};

#define IOPRIO_CLASS_SHIFT	13

const char *to_prio[] = { "none", "realtime", "best-effort", "idle", };

int main(int argc, char *argv[])
{
	int ioprio = 4, set = 0, ioprio_class = IOPRIO_CLASS_BE;
	int c, pid = 0;

	while ((c = getopt(argc, argv, "+n:c:p:")) != EOF) {
		switch (c) {
		case 'n':
			ioprio = strtol(optarg, NULL, 10);
			set = 1;
			break;
		case 'c':
			ioprio_class = strtol(optarg, NULL, 10);
			set = 1;
			break;
		case 'p':
			pid = strtol(optarg, NULL, 10);
			break;
		}
	}

	switch (ioprio_class) {
		case IOPRIO_CLASS_NONE:
			ioprio_class = IOPRIO_CLASS_BE;
			break;
		case IOPRIO_CLASS_RT:
		case IOPRIO_CLASS_BE:
			break;
		case IOPRIO_CLASS_IDLE:
			ioprio = 7;
			break;
		default:
			printf("bad prio class %d\n", ioprio_class);
			return 1;
	}

	if (!set) {
		if (!pid && argv[optind])
			pid = strtol(argv[optind], NULL, 10);

		ioprio = ioprio_get(IOPRIO_WHO_PROCESS, pid);

		printf("pid=%d, %d\n", pid, ioprio);

		if (ioprio == -1)
			perror("ioprio_get");
		else {
			ioprio_class = ioprio >> IOPRIO_CLASS_SHIFT;
			ioprio = ioprio & 0xff;
			printf("%s: prio %d\n", to_prio[ioprio_class], ioprio);
		}
	} else {
		if (ioprio_set(IOPRIO_WHO_PROCESS, pid, ioprio | ioprio_class << IOPRIO_CLASS_SHIFT) == -1) {
			perror("ioprio_set");
			return 1;
		}

		if (argv[optind])
			execvp(argv[optind], &argv[optind]);
	}

	return 0;
}
