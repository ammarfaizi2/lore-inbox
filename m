Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267411AbUIWWfL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267411AbUIWWfL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:35:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267478AbUIWWcP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:32:15 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:37805 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S267411AbUIWWaP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:30:15 -0400
Date: Thu, 23 Sep 2004 15:30:14 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: linux-kernel@vger.kernel.org
Subject: [time] add support for CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID
Message-ID: <Pine.LNX.4.58.0409231519260.1313@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Changelog
	* Add CLOCK_THREAD_CPUTIME_ID and CLOCK_PROCESS_CPUTIME_ID
	* CPU counters currently used by glibc for both clocks are
	  mostly unreliable on SMP systems since processes may be
	  moved to other CPUs. In those cases glibc's emulation of
	  those clocks returns bogus information. The kernel tracks
	  process startup times and has the information available
	  in a reliable way.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linus/kernel/posix-timers.c
===================================================================
--- linus.orig/kernel/posix-timers.c	2004-09-23 15:12:01.000000000 -0700
+++ linus/kernel/posix-timers.c	2004-09-23 15:13:16.000000000 -0700
@@ -133,18 +133,10 @@
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
@@ -162,7 +154,7 @@
  *
  *          At this time all functions EXCEPT clock_nanosleep can be
  *          redirected by the CLOCKS structure.  Clock_nanosleep is in
- *          there, but the code ignors it.
+ *          there, but the code ignores it.
  *
  * Permissions: It is assumed that the clock_settime() function defined
  *	    for each clock will take care of permission checks.	 Some
@@ -198,6 +190,8 @@
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
 int do_posix_clock_monotonic_settime(struct timespec *tp);
+int do_posix_clock_process_gettime(struct timespec *tp);
+int do_posix_clock_thread_gettime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);

 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -218,6 +212,14 @@
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
@@ -226,6 +228,8 @@

 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
 	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
+	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &clock_process);
+	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &clock_thread);

 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, NULL, NULL);
@@ -1227,6 +1231,23 @@
 	return -EINVAL;
 }

+int do_posix_clock_thread_gettime(struct timespec *tp)
+{
+	jiffies_to_timespec(get_jiffies_64()-current->start_time, tp);
+	return 0;
+}
+
+int do_posix_clock_process_gettime(struct timespec *tp)
+{
+	/*
+	 * If there is some way of finding the "process" that this thread
+	 * belongs to then we should find that and use that "process"
+	 * to determine time. Otherwise "process" == thread under linux.
+	 */
+	jiffies_to_timespec(get_jiffies_64()-current->start_time, tp);
+	return 0;
+}
+
 asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
 {
