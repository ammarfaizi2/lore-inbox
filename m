Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbULRWDA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbULRWDA (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Dec 2004 17:03:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261232AbULRWCv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Dec 2004 17:02:51 -0500
Received: from mx1.redhat.com ([66.187.233.31]:22922 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261194AbULRWCf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Dec 2004 17:02:35 -0500
Date: Sat, 18 Dec 2004 14:02:27 -0800
Message-Id: <200412182202.iBIM2RaZ030987@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
X-Fcc: ~/Mail/linus
Subject: [PATCH] back out CPU clock additions to posix-timers
In-Reply-To: Andrew Morton's message of  Thursday, 16 December 2004 14:33:12 -0800 <20041216143312.6910521d.akpm@osdl.org>
X-Zippy-Says: This is my WILLIAM BENDIX memorial CORNER where I worship William
   Bendix like a GOD!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Roland McGrath <roland@redhat.com> wrote:
> >
> > I really think we should not let the
> > existing clockid_t encoding change get out in 2.6.10.
> 
> So.. could you please send a patch which disables the userspace-visibility
> of Christoph's changes?

Here you go.  I'm gathering I won't convince you to get the final form of
the new code into 2.6.10, in which case just holding off on the addition by
doing this reversion patch for 2.6.10 and putting the new stuff in 2.6.11
is what I'd like to see.  Cristoph and I will work through the nits and
cleanups the patch I posted needs; I expect we'll have a consensus version
of the patch for you soon.

I ran glibc's clock and timer tests on a vanilla Linus kernel of today plus
this patch, and they behaved properly for a kernel not supporting any
process-CPU clockid_t values.


Thanks,
Roland



[PATCH] back out CPU clock additions to posix-timers

This patch reverts the additions of an ABI supporting thread and process
CPU clocks in the posix-timers code.  This returns us to 2.6.9's condition,
there is no support for any new clockid_t values for process CPU clocks.

This also fixes the return value for clock_nanosleep when unsupported (I
think this is used only by sgi-timer at the moment).  The POSIX-specified
code for valid clocks that don't support the sleep operation is ENOTSUP.
On most architectures the kernel doesn't define ENOTSUP and this name is
defined in userland the same as the kernel's EOPNOTSUPP.

Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/kernel/posix-timers.c
+++ linux-2.6/kernel/posix-timers.c
@@ -10,10 +10,6 @@
  * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
  *			     Copyright (C) 2004 Boris Hu
  *
- * 2004-07-27 Provide POSIX compliant clocks
- *		CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
- *		by Christoph Lameter
- *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or (at
@@ -193,8 +189,6 @@ static int do_posix_gettime(struct k_clo
 static u64 do_posix_clock_monotonic_gettime_parts(
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
-static int do_posix_clock_process_gettime(struct timespec *tp);
-static int do_posix_clock_thread_gettime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
 
 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -215,25 +209,9 @@ static __init int init_posix_timers(void
 		.clock_get = do_posix_clock_monotonic_gettime,
 		.clock_set = do_posix_clock_nosettime
 	};
-	struct k_clock clock_thread = {.res = CLOCK_REALTIME_RES,
-		.abs_struct = NULL,
-		.clock_get = do_posix_clock_thread_gettime,
-		.clock_set = do_posix_clock_nosettime,
-		.timer_create = do_posix_clock_notimer_create,
-		.nsleep = do_posix_clock_nonanosleep
-	};
-	struct k_clock clock_process = {.res = CLOCK_REALTIME_RES,
-		.abs_struct = NULL,
-		.clock_get = do_posix_clock_process_gettime,
-		.clock_set = do_posix_clock_nosettime,
-		.timer_create = do_posix_clock_notimer_create,
-		.nsleep = do_posix_clock_nonanosleep
-	};
 
 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
 	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
-	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &clock_process);
-	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &clock_thread);
 
 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, NULL, NULL);
@@ -1220,69 +1198,18 @@ int do_posix_clock_nosettime(struct time
 	return -EINVAL;
 }
 
-int do_posix_clock_notimer_create(struct k_itimer *timer) {
-	return -EINVAL;
-}
-
-int do_posix_clock_nonanosleep(int which_lock, int flags,struct timespec * t) {
-/* Single Unix specficiation says to return ENOTSUP but we do not have that */
-	return -EINVAL;
-}
-
-static unsigned long process_ticks(task_t *p) {
-	unsigned long ticks;
-	task_t *t;
-
-	spin_lock(&p->sighand->siglock);
-	/* The signal structure is shared between all threads */
-	ticks = p->signal->utime + p->signal->stime;
-
-	/* Add up the cpu time for all the still running threads of this process */
-	t = p;
-	do {
-		ticks += t->utime + t->stime;
-		t = next_thread(t);
-	} while (t != p);
-
-	spin_unlock(&p->sighand->siglock);
-	return ticks;
-}
-
-static inline unsigned long thread_ticks(task_t *p) {
-	return p->utime + current->stime;
-}
-
-/*
- * Single Unix Specification V3:
- *
- * Implementations shall also support the special clockid_t value
- * CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the calling
- * thread when invoking one of the clock_*() or timer_*() functions. For these
- * clock IDs, the values returned by clock_gettime() and specified by
- * clock_settime() shall represent the amount of execution time of the thread
- * associated with the clock.
- */
-static int do_posix_clock_thread_gettime(struct timespec *tp)
+int do_posix_clock_notimer_create(struct k_itimer *timer)
 {
-	jiffies_to_timespec(thread_ticks(current), tp);
-	return 0;
+	return -EINVAL;
 }
 
-/*
- * Single Unix Specification V3:
- *
- * Implementations shall also support the special clockid_t value
- * CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
- * calling process when invoking one of the clock_*() or timer_*() functions.
- * For these clock IDs, the values returned by clock_gettime() and specified
- * by clock_settime() represent the amount of execution time of the process
- * associated with the clock.
- */
-
-static int do_posix_clock_process_gettime(struct timespec *tp)
+int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec *t)
 {
-	jiffies_to_timespec(process_ticks(current), tp);
-	return 0;
+#ifndef ENOTSUP
+	return -EOPNOTSUPP;	/* aka ENOTSUP in userland for POSIX */
+#else  /*  parisc does define it separately.  */
+	return -ENOTSUP;
+#endif
 }
 
 asmlinkage long
@@ -1290,10 +1217,6 @@ sys_clock_settime(clockid_t which_clock,
 {
 	struct timespec new_tp;
 
-	/* Cannot set process specific clocks */
-	if (which_clock<0)
-		return -EINVAL;
-
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
@@ -1307,29 +1230,6 @@ sys_clock_settime(clockid_t which_clock,
 
 static int do_clock_gettime(clockid_t which_clock, struct timespec *tp)
 {
-	/* Process process specific clocks */
-	if (which_clock < 0) {
-		task_t *t;
-		int pid = -which_clock;
-
-		if (pid < PID_MAX_LIMIT) {
-			if ((t = find_task_by_pid(pid))) {
-				jiffies_to_timespec(process_ticks(t), tp);
-				return 0;
-			}
-			return -EINVAL;
-		}
-		if (pid < 2*PID_MAX_LIMIT) {
-			if ((t = find_task_by_pid(pid - PID_MAX_LIMIT))) {
-				jiffies_to_timespec(thread_ticks(t), tp);
-				return 0;
-			}
-			return -EINVAL;
-		}
-		/* More process specific clocks could follow here */
-		return -EINVAL;
-	}
-
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
@@ -1356,9 +1256,6 @@ sys_clock_getres(clockid_t which_clock, 
 {
 	struct timespec rtn_tp;
 
-	/* All process clocks have the resolution of CLOCK_PROCESS_CPUTIME_ID */
-	if (which_clock < 0 ) which_clock = CLOCK_PROCESS_CPUTIME_ID;
-
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
