Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261765AbULUOna@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261765AbULUOna (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Dec 2004 09:43:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbULUOna
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Dec 2004 09:43:30 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20938 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S261765AbULUOkw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Dec 2004 09:40:52 -0500
Date: Tue, 21 Dec 2004 15:40:50 +0100
From: Jens Axboe <axboe@suse.de>
To: linux-kernel@vger.kernel.org
Subject: [PATCH][CFT] time sliced cfq ver18
Message-ID: <20041221144046.GN2773@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="tThc/1wpZn/ma/RB"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I've finished version 18 of the time sliced cfq io scheduler. The
highlights of this io scheduler are (in no particular order):

- It gives each process doing io access to the disk exclusively for a
  defined period of time. This is known as the disk slice, hence the
  name time sliced cfq. Most processes have at least some locality on
  disk, so this concept works quite well in practice to maintain almost
  full disk bandwidth even with many processes fighting for the disk.
  If it is deemed useful based on prio process statistics, a process can
  idle for short periods of time if its slice has not expired before
  being preempted by a new process. This is similar to the anticipation
  of the AS io scheduler, or at least the effect is the same.

- It is fair between processes by design. No one single process can hog
  the disk bandwidth for a long period of time.

- It supports io priority classes:

  There is an idle scheduling class, which only runs when nothing else
  is using the disk. A grace period is defined for which idle has to
  wait before getting disk access when other io has run. This defaults
  to 250ms currently. If a process is doing idle io and happens to hold
  fs exclusive resources, it gets a temporary priority boost to avoid
  starvation of other processes running at a higher priority. File
  systems should call get_fs_excl() and put_fs_excl() in critical
  regions to pass this hint down to the io scheduler. Only reiserfs does
  this for now. Idle io doesn't take a priority, idle is idle :-)

  There is a best effort scheduling class, divided into 8 priority
  levels - 0 is the highest, 7 is the lowest. The higher the priority,
  the longer the disk slice the process gets. This is the default
  scheduling class for all processes. A process which hasn't set a
  specific io priority, gets one assigned according to its CPU nice
  level.

  Finally, there is a real time scheduling class. The plan is to make it
  support bandwidth allocation, right now it's just divided into 8
  priority levels like the BE class. A process running with real time io
  scheduling always gets disk time in each round of service. You must
  have CAP_SYS_ADMIN privileges to set realtime access to the disk.

That is the executive summary, tomorrow I'll post some graphs of io
performance compared to deadline and AS.

I've attached ionice.c that sets the priority of a process (which is
inherited across fork). It has two parameters - c for scheduling class,
p for priority. The classes are as follows:

1	realtime

2	best effort

3	idle

The default policy for applications is best-effort at prio 4, if nothing
has been set. So to run 'ls' at best effort priority 0, you would do:

# ionice -c2 -p0 ls

or to run dbench at idle priority, you would do:

# ionice -c3 dbench

and so on. Note: you still need to adjust the syscall numbers for the
-mm kernel. Look in include/asm-<arch>/unistd.h to find your syscall
numbers. ionice works out of the box on the Linus kernels.

To test this io scheduler, you either need to boot with elevator=cfq as
a kernel parameter, or switch your hard drives to cfq after boot. For
hda, you would do:

# echo cfq > /sys/block/hda/queue/scheduler

to switch on the fly.

Changes in this release:

- Drop the CPU scheduler 'task_will_schedule_at' optimization, it did
  more harm than good.

- Add support for idle io.

- Add support for realtime io.

- Lots of little cleanups and fixes.

2.6.10-rc3-mm1 patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3-mm1/cfq-time-slices-18-2.6.10-rc3-mm1.gz

2.6-BK patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc3/cfq-time-slices-18.gz

-- 
Jens Axboe


--tThc/1wpZn/ma/RB
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ionice.c"

#include <stdio.h>
#include <stdlib.h>
#include <errno.h>
#include <getopt.h>
#include <unistd.h>
#include <sys/ptrace.h>
#include <asm/unistd.h>

extern int sys_ioprio_set(int);
extern int sys_ioprio_get(void);

#if defined(__i386__)
#define __NR_ioprio_set		289
#define __NR_ioprio_get		290
#elif defined(__ppc__)
#define __NR_ioprio_set		272
#define __NR_ioprio_get		273
#elif defined(__x86_64__)
#define __NR_ioprio_set		248
#define __NR_ioprio_get		249
#elif defined(__ia64__)
#define __NR_ioprio_set		1274
#define __NR_ioprio_get		1275
#else
#error "Unsupported arch"
#endif

_syscall1(int, ioprio_set, int, ioprio);
_syscall0(int, ioprio_get);

enum {
	IOPRIO_CLASS_NONE,
	IOPRIO_CLASS_RT,
	IOPRIO_CLASS_BE,
	IOPRIO_CLASS_IDLE,
};

const char *to_prio[] = { "none", "realtime", "best-effort", "idle", };

int main(int argc, char *argv[])
{
	int ioprio = 4, set = 0, ioprio_class = IOPRIO_CLASS_BE;
	int c;

	while ((c = getopt(argc, argv, "+n:c:")) != EOF) {
		switch (c) {
		case 'n':
			ioprio = strtol(optarg, NULL, 10);
			set = 1;
			break;
		case 'c':
			ioprio_class = strtol(optarg, NULL, 10);
			set = 1;
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
		ioprio = ioprio_get();

		if (ioprio == -1)
			perror("ioprio_get");
		else {
			ioprio_class = ioprio >> 24;
			ioprio = ioprio & 0xff;
			printf("%s: prio %d\n", to_prio[ioprio_class], ioprio);
		}
	} else if (argv[optind]) {
		printf("%s: prio %d\n", to_prio[ioprio_class], ioprio);
		if (ioprio_set(ioprio | ioprio_class << 24) == -1) {
			perror("ioprio_set");
			return 1;
		}
		execvp(argv[optind], &argv[optind]);
	}

	return 0;
}

--tThc/1wpZn/ma/RB--
