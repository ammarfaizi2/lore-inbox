Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267380AbUI0VDb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267380AbUI0VDb (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 27 Sep 2004 17:03:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267378AbUI0VC2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 27 Sep 2004 17:02:28 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:57526 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267380AbUI0VAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 27 Sep 2004 17:00:03 -0400
Date: Mon, 27 Sep 2004 13:58:12 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: johnstul@us.ibm.com, Ulrich.Windl@rz.uni-regensburg.de, george@mvista.com,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com
Subject: [RFC] Posix compliant behavior of CLOCK_PROCESS/THREAD_CPUTIME_ID
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Attached follows a patch to implement the POSIX clocks according to the
POSIX standard which states in V3 of the Single Unix Specification:

1. CLOCK_PROCESS_CPUTIME_ID

  Implementations shall also support the special clockid_t value
  CLOCK_PROCESS_CPUTIME_ID, which represents the CPU-time clock of the
  calling process when invoking one of the clock_*() or timer_*()
  functions. For these clock IDs, the values returned by clock_gettime() and specified
  by clock_settime() represent the amount of execution time of the process
  associated with the clock.

2. CLOCK_THREAD_CPUTIME_ID

  Implementations shall also support the special clockid_t value
  CLOCK_THREAD_CPUTIME_ID, which represents the CPU-time clock of the
  calling thread when invoking one of the clock_*() or timer_*()
  functions. For these clock IDs, the values returned by clock_gettime()
  and specified by clock_settime() shall represent the amount of
  execution time of the thread associated with the clock.

These times mentioned are CPU processing times and not the time that has
passed since the startup of a process. Glibc currently provides its own
implementation of these two clocks which is designed to return the time
that passed since the startup of a process or a thread.

Moreover this clock is bound to CPU timers which is problematic when the
frequency of the clock changes or the process is moved to a different
processor whose cpu timer may not be fully synchronized to the cpu timer
of the current CPU.

I would like to have the following patch integrated into the kernel. Glibc
would need to be modified to simply generate a system call for clock_* without
doing its own emulation of a clock. CLOCK_PROCESS_CPUTIME_ID and
CLOCK_THREAD_CPUTIME id were never intended to be used as a means to
access a time stamp counter on a CPU and it may be better to find another
means of accesses the cpu time registerss.

The patch is really quite straighforward and only affects one file...

Index: linus/kernel/posix-timers.c
===================================================================
--- linus.orig/kernel/posix-timers.c	2004-09-23 15:12:01.000000000 -0700
+++ linus/kernel/posix-timers.c	2004-09-27 13:42:40.000000000 -0700
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
@@ -198,6 +194,8 @@
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
 int do_posix_clock_monotonic_settime(struct timespec *tp);
+int do_posix_clock_process_gettime(struct timespec *tp);
+int do_posix_clock_thread_gettime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);

 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -218,6 +216,14 @@
 		.clock_get = do_posix_clock_monotonic_gettime,
 		.clock_set = do_posix_clock_monotonic_settime
 	};
+	struct k_clock clock_thread = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
+		.clock_get = do_posix_clock_thread_gettime
+	};
+	struct k_clock clock_process = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
+		.clock_get = do_posix_clock_process_gettime
+	};

 #ifdef CONFIG_TIME_INTERPOLATION
 	/* Clocks are more accurate with time interpolators */
@@ -226,6 +232,8 @@

 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
 	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
+	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &clock_process);
+	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &clock_thread);

 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, NULL, NULL);
@@ -1227,6 +1235,46 @@
 	return -EINVAL;
 }

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
+int do_posix_clock_thread_gettime(struct timespec *tp)
+{
+	jiffies_to_timespec(current->signal->cutime + current->signal->cstime, tp);
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
+int do_posix_clock_process_gettime(struct timespec *tp)
+{
+	unsigned long ticks = 0;
+	struct task *t;
+
+	/* Add up the cpu time for all the threads of this process */
+	for (t = current; t != current; t = next_thread(p)) {
+		ticks += t->signal->cutime + t->signal->cstime;
+	}
+
+	jiffies_to_timespec(ticks, tp);
+	return 0;
+}
+
 asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
 {
