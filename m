Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269245AbUIYFyg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269245AbUIYFyg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Sep 2004 01:54:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269246AbUIYFyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Sep 2004 01:54:36 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:4007 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S269245AbUIYFyb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Sep 2004 01:54:31 -0400
Date: Fri, 24 Sep 2004 22:54:13 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Ulrich Drepper <drepper@redhat.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: [time] add support for CLOCK_THREAD_CPUTIME_ID and
 CLOCK_PROCESS_CPUTIME_ID
In-Reply-To: <4154F349.1090408@redhat.com>
Message-ID: <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Sep 2004, Ulrich Drepper wrote:

> For this I would love to get kernel support and we hopefully have soon a
> patch for this.

Then please sign off on the following patch:

Index: linus/kernel/posix-timers.c
===================================================================
--- linus.orig/kernel/posix-timers.c	2004-09-23 15:12:01.000000000 -0700
+++ linus/kernel/posix-timers.c	2004-09-24 22:51:51.000000000 -0700
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
@@ -1227,6 +1231,19 @@
 	return -EINVAL;
 }

+int do_posix_clock_thread_gettime(struct timespec *tp)
+{
+	jiffies_to_timespec(current->signal->cutime + current->signal->cstime, tp);
+	return 0;
+}
+
+int do_posix_clock_process_gettime(struct timespec *tp)
+{
+	jiffies_to_timespec(current->group_leader->signal->cutime +
+		current->group_leader->signal->cstime, tp);
+	return 0;
+}
+
 asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
 {
