Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266357AbUJAUEw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266357AbUJAUEw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Oct 2004 16:04:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266341AbUJAUET
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Oct 2004 16:04:19 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:1705 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S266245AbUJAUBN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Oct 2004 16:01:13 -0400
Date: Fri, 1 Oct 2004 12:59:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: Posix compliant cpu clocks V6 [1/3]: Generic Kernel patch
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0410011257510.18738@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Add CLOCK_THREAD_CPUTIME and CLOCK_PROCESS_CPUTIME_ID processing
	* Add timer_create override for posix clocks
	* Complete implementation of nanosleep overrride for posix clocks
	* export posix clock registration in include/linux/posix-timers.h
	* Allow up to 16 posix clocks

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9-rc3/kernel/posix-timers.c
===================================================================
--- linux-2.6.9-rc3.orig/kernel/posix-timers.c	2004-09-29 20:04:47.000000000 -0700
+++ linux-2.6.9-rc3/kernel/posix-timers.c	2004-10-01 12:48:55.000000000 -0700
@@ -10,6 +10,10 @@
  * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
  *			     Copyright (C) 2004 Boris Hu
  *
+ * 2004-07-27 Provide POSIX compliant clocks
+ *		CLOCK_PROCESS_CPUTIME_ID and CLOCK_THREAD_CPUTIME_ID.
+ *		by Christoph Lameter
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or (at
@@ -133,18 +137,10 @@
  *	    resolution.	 Here we define the standard CLOCK_REALTIME as a
  *	    1/HZ resolution clock.
  *
- * CPUTIME & THREAD_CPUTIME: We are not, at this time, definding these
- *	    two clocks (and the other process related clocks (Std
- *	    1003.1d-1999).  The way these should be supported, we think,
- *	    is to use large negative numbers for the two clocks that are
- *	    pinned to the executing process and to use -pid for clocks
- *	    pinned to particular pids.	Calls which supported these clock
- *	    ids would split early in the function.
- *
  * RESOLUTION: Clock resolution is used to round up timer and interval
  *	    times, NOT to report clock times, which are reported with as
  *	    much resolution as the system can muster.  In some cases this
- *	    resolution may depend on the underlaying clock hardware and
+ *	    resolution may depend on the underlying clock hardware and
  *	    may not be quantifiable until run time, and only then is the
  *	    necessary code is written.	The standard says we should say
  *	    something about this issue in the documentation...
@@ -162,7 +158,7 @@
  *
  *          At this time all functions EXCEPT clock_nanosleep can be
  *          redirected by the CLOCKS structure.  Clock_nanosleep is in
- *          there, but the code ignors it.
+ *          there, but the code ignores it.
  *
  * Permissions: It is assumed that the clock_settime() function defined
  *	    for each clock will take care of permission checks.	 Some
@@ -197,8 +193,16 @@
 static u64 do_posix_clock_monotonic_gettime_parts(
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
-int do_posix_clock_monotonic_settime(struct timespec *tp);
+static int do_posix_clock_monotonic_settime(struct timespec *tp);
+static int do_posix_clock_process_gettime(struct timespec *tp);
+static int do_posix_clock_process_settime(struct timespec *tp);
+static int do_posix_clock_thread_gettime(struct timespec *tp);
+static int do_posix_clock_thread_settime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);
+int do_posix_clock_notimer_create(int which_clock,
+		struct sigevent __user *time_event_spec,
+		timer_t __user *created_timer_id);
+int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec * t);

 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
 {
@@ -218,6 +222,20 @@
 		.clock_get = do_posix_clock_monotonic_gettime,
 		.clock_set = do_posix_clock_monotonic_settime
 	};
+	struct k_clock clock_thread = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
+		.clock_get = do_posix_clock_thread_gettime,
+		.clock_set = do_posix_clock_thread_settime,
+		.timer_create = do_posix_clock_notimer_create,
+		.nsleep = do_posix_clock_nonanosleep
+	};
+	struct k_clock clock_process = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
+		.clock_get = do_posix_clock_process_gettime,
+		.clock_set = do_posix_clock_process_settime,
+		.timer_create = do_posix_clock_notimer_create,
+		.nsleep = do_posix_clock_nonanosleep
+	};

 #ifdef CONFIG_TIME_INTERPOLATION
 	/* Clocks are more accurate with time interpolators */
@@ -226,6 +244,8 @@

 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
 	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
+	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &clock_process);
+	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &clock_thread);

 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, NULL, NULL);
@@ -577,6 +597,10 @@
 				!posix_clocks[which_clock].res)
 		return -EINVAL;

+	if (posix_clocks[which_clock].timer_create)
+		return posix_clocks[which_clock].timer_create(which_clock,
+				timer_event_spec, created_timer_id);
+
 	new_timer = alloc_posix_timer();
 	if (unlikely(!new_timer))
 		return -EAGAIN;
@@ -1222,11 +1246,88 @@
 	return 0;
 }

-int do_posix_clock_monotonic_settime(struct timespec *tp)
+static int do_posix_clock_monotonic_settime(struct timespec *tp)
 {
 	return -EINVAL;
 }

+int do_posix_clock_notimer_create(int which_clock,
+		struct sigevent __user *timer_event_spec,
+		timer_t __user *created_timer_id) {
+	return -EINVAL;
+}
+
+int do_posix_clock_nonanosleep(int which_lock, int flags,struct timespec * t) {
+/* Single Unix specficiation says to return ENOTSUP but we do not have that */
+	return -EINVAL;
+}
+
+/*
+ * Single Unix Specification V3:
+ *
+ * Implementations shall also support the special clockid_t value
+ * CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the calling
+ * thread when invoking one of the clock_*() or timer_*() functions. For these
+ * clock IDs, the values returned by clock_gettime() and specified by
+ * clock_settime() shall represent the amount of execution time of the thread
+ * associated with the clock.
+ */
+static int do_posix_clock_thread_gettime(struct timespec *tp)
+{
+	jiffies_to_timespec(current->utime + current->stime
+			+ current->thread_clock_offset, tp);
+	return 0;
+}
+
+static int do_posix_clock_thread_settime(struct timespec *tp)
+{
+	current->thread_clock_offset = timespec_to_jiffies(tp)
+		- current->utime - current->stime;
+	return 0;
+}
+
+/*
+ * Single Unix Specification V3:
+ *
+ * Implementations shall also support the special clockid_t value
+ * CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
+ * calling process when invoking one of the clock_*() or timer_*() functions.
+ * For these clock IDs, the values returned by clock_gettime() and specified
+ * by clock_settime() represent the amount of execution time of the process
+ * associated with the clock.
+ */
+
+static unsigned long process_ticks(void) {
+	unsigned long ticks;
+	task_t *t;
+
+	spin_lock(&current->sighand->siglock);
+	/* The signal structure is shared between all threads */
+	ticks = current->signal->utime + current->signal->stime;
+
+	/* Add up the cpu time for all the still running threads of this process */
+	t = current;
+	do {
+		ticks += t->utime + t->stime;
+		t = next_thread(t);
+	} while (t != current);
+
+	spin_unlock(&current->sighand->siglock);
+	return ticks;
+}
+
+static int do_posix_clock_process_gettime(struct timespec *tp)
+{
+	jiffies_to_timespec(current->signal->process_clock_offset + process_ticks(), tp);
+	return 0;
+}
+
+static int do_posix_clock_process_settime(struct timespec *tp)
+{
+	current->signal->process_clock_offset = timespec_to_jiffies(tp) - process_ticks();
+	return 0;
+}
+
 asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
 {
@@ -1413,7 +1514,10 @@
 	if ((unsigned) t.tv_nsec >= NSEC_PER_SEC || t.tv_sec < 0)
 		return -EINVAL;

-	ret = do_clock_nanosleep(which_clock, flags, &t);
+	if (posix_clocks[which_clock].nsleep)
+		ret = posix_clocks[which_clock].nsleep(which_clock, flags, &t);
+	else
+		ret = do_clock_nanosleep(which_clock, flags, &t);
 	/*
 	 * Do this here as do_clock_nanosleep does not have the real address
 	 */
Index: linux-2.6.9-rc3/include/linux/sched.h
===================================================================
--- linux-2.6.9-rc3.orig/include/linux/sched.h	2004-09-29 20:03:54.000000000 -0700
+++ linux-2.6.9-rc3/include/linux/sched.h	2004-10-01 08:40:30.000000000 -0700
@@ -293,6 +293,7 @@

 	/* POSIX.1b Interval Timers */
 	struct list_head posix_timers;
+	int			process_clock_offset;	/* for CLOCK_PROCESS_CPUTIME_ID */

 	/* job control IDs */
 	pid_t pgrp;
@@ -509,6 +510,7 @@
 	unsigned long utime, stime;
 	unsigned long nvcsw, nivcsw; /* context switch counts */
 	u64 start_time;
+	int thread_clock_offset;	/* offset to thread_clock for CLOCK_THREAD_CPUTIME_ID */
 /* mm fault and swap info: this can arguably be seen as either mm-specific or thread-specific */
 	unsigned long min_flt, maj_flt;
 /* process credentials */
Index: linux-2.6.9-rc3/include/linux/posix-timers.h
===================================================================
--- linux-2.6.9-rc3.orig/include/linux/posix-timers.h	2004-09-29 20:04:46.000000000 -0700
+++ linux-2.6.9-rc3/include/linux/posix-timers.h	2004-10-01 08:40:30.000000000 -0700
@@ -13,9 +13,10 @@
 	struct k_clock_abs *abs_struct;
 	int (*clock_set) (struct timespec * tp);
 	int (*clock_get) (struct timespec * tp);
-	int (*nsleep) (int flags,
-		       struct timespec * new_setting,
-		       struct itimerspec * old_setting);
+	int (*timer_create) (int which_clock, struct sigevent __user *timer_event_spec,
+			timer_t __user * created_timer_id);
+	int (*nsleep) (int which_clock, int flags,
+		       struct timespec * t);
 	int (*timer_set) (struct k_itimer * timr, int flags,
 			  struct itimerspec * new_setting,
 			  struct itimerspec * old_setting);
@@ -23,6 +24,16 @@
 	void (*timer_get) (struct k_itimer * timr,
 			   struct itimerspec * cur_setting);
 };
+
+void register_posix_clock(int clock_id, struct k_clock *new_clock);
+
+/* Error handlers for timer_create and nanosleep */
+int do_posix_clock_notimer_create(int which_clock,
+                struct sigevent __user *time_event_spec,
+                timer_t __user *created_timer_id);
+
+int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec * t);
+
 struct now_struct {
 	unsigned long jiffies;
 };
@@ -42,3 +53,4 @@
               }								\
             }while (0)
 #endif
+
Index: linux-2.6.9-rc3/include/linux/time.h
===================================================================
--- linux-2.6.9-rc3.orig/include/linux/time.h	2004-09-29 20:05:18.000000000 -0700
+++ linux-2.6.9-rc3/include/linux/time.h	2004-10-01 08:40:30.000000000 -0700
@@ -413,7 +413,12 @@
 #define CLOCK_REALTIME_HR	 4
 #define CLOCK_MONOTONIC_HR	  5

-#define MAX_CLOCKS 6
+/*
+ * The IDs of various hardware clocks
+ */
+
+
+#define MAX_CLOCKS 16
 #define CLOCKS_MASK  (CLOCK_REALTIME | CLOCK_MONOTONIC | \
                      CLOCK_REALTIME_HR | CLOCK_MONOTONIC_HR)
 #define CLOCKS_MONO (CLOCK_MONOTONIC & CLOCK_MONOTONIC_HR)
