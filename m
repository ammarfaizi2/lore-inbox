Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262250AbULMMxF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262250AbULMMxF (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Dec 2004 07:53:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262240AbULMMxD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Dec 2004 07:53:03 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:12162 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S262253AbULMMva (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Dec 2004 07:51:30 -0500
Date: Mon, 13 Dec 2004 13:50:46 +0100
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] Time sliced cfq with basic io priorities
Message-ID: <20041213125046.GG3033@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="a8Wt8u1KmwUX3Y2C"
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--a8Wt8u1KmwUX3Y2C
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

I added basic io priority support to the time sliced cfq base. Right now
this is just proof of concept, the interface for setting/querying io
prio will change. There are 8 basic io priorities now, 0 being highest
prio and 7 the lowest. The scheduling type is best effort, in the future
there will be a realtime class as well (and hence the need to change
sys_ioprio_set etc). If a process hasn't set its io priority explicitly,
io priority is determined from the process nice level. CPU nice level of
0 yields io priority 4, cpu nice -20 gives you 0, and finally cpu nice
19 will give you an io priority of 7. Values in-between are
appropriately scaled. If a process sets its io priority explicitly, that
value is used from then on.

A test run with 7 readers are various priorities:

thread1 (read): err=0, prio=0 maxl=634msec, run=30012msec, bw=5884KiB/sec
thread2 (read): err=0, prio=1 maxl=650msec, run=30041msec, bw=5102KiB/sec
thread3 (read): err=0, prio=1 maxl=646msec, run=30057msec, bw=5062KiB/sec
thread4 (read): err=0, prio=3 maxl=687msec, run=30079msec, bw=3551KiB/sec
thread5 (read): err=0, prio=6 maxl=750msec, run=30208msec, bw=1253KiB/sec
thread6 (read): err=0, prio=3 maxl=690msec, run=30100msec, bw=3562KiB/sec
thread7 (read): err=0, prio=4 maxl=758msec, run=30181msec, bw=2631KiB/sec
Run status:
   READ: io=775MiB, aggrb=26927, minl=634, maxl=758, minb=1253, maxb=5884, mint=30012msec, maxt=30208msec

Note that aggregate bandwidth stays the same as without io priorities.
Only io scheduling cares about the io priority currently, request
allocation policy, queue congestion etc doesn't yet.

I have attached a sample ionice.c file, so that you can do:

# ionice -n3 some_process

which will run that process at io priority 3.

Other changes:

- Disable TCQ in the hardware/driver by default. Can be changed (as
  always) with the max_depth setting. If you do that, don't expect
  fairness or priorities to work as well.

- Import thinktime stats from AS. We use this to determine when to
  preempt a queue during its idle window.

- Kill find_best_crq setting. It was on by default before, and it would
  be a bug if it didn't work well.

- Add ability for a given process to preempt another process slice.

- Allow idle window to slide, if there are no other potential queues we
  could service requests from.

- Various little cleanups and optimizations.

2.6.10-rc2-mm4 patch:

http://www.kernel.org/pub/linux/kernel/people/axboe/patches/v2.6/2.6.10-rc2-mm4/cfq-time-slices-10-2.6.10-rc2-mm4.gz

-- 
Jens Axboe


--a8Wt8u1KmwUX3Y2C
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
#define __NR_ioprio_set		295
#define __NR_ioprio_get		296
#elif defined(__ppc__)
#define __NR_ioprio_set		278
#define __NR_ioprio_get		279
#elif defined(__x86_64__)
#define __NR_ioprio_set		254
#define __NR_ioprio_get		255
#elif defined(__ia64__)
#define __NR_ioprio_set		1274
#define __NR_ioprio_get		1275
#else
#error "Unsupported arch"
#endif

_syscall1(int, ioprio_set, int, ioprio);
_syscall0(int, ioprio_get);

int main(int argc, char *argv[])
{
	int ioprio = 2, set = 0;
	int c;

	while ((c = getopt(argc, argv, "+n:")) != EOF) {
		switch (c) {
		case 'n':
			ioprio = strtol(optarg, NULL, 10);
			set = 1;
			break;
		}
	}

	if (!set) {
		int ioprio = ioprio_get();
		if (ioprio == -1)
			perror("ioprio_get");
		else
			printf("%d\n", ioprio_get());
	} else if (argv[optind]) {
		if (ioprio_set(ioprio) == -1) {
			perror("ioprio_set");
			return 1;
		}
		execvp(argv[optind], &argv[optind]);
	}

	return 0;
}

--a8Wt8u1KmwUX3Y2C--
