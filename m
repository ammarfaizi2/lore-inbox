Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269692AbUJGFBj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269692AbUJGFBj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 01:01:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269693AbUJGFBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 01:01:38 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:63388 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S269692AbUJGFAD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 01:00:03 -0400
Date: Wed, 6 Oct 2004 21:57:56 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: George Anzinger <george@mvista.com>
cc: Ulrich Drepper <drepper@redhat.com>, johnstul@us.ibm.com,
       Ulrich.Windl@rz.uni-regensburg.de, jbarnes@sgi.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org, libc-alpha@sources.redhat.com,
       nickpiggin@yahoo.com.au, roland@redhat.com
Subject: Posix compliant cpu clocks V7 [1/2]: Kernel Patch
In-Reply-To: <B6E8046E1E28D34EB815A11AC8CA31290322B331@mtv-atc-605e--n.corp.sgi.com>
Message-ID: <Pine.LNX.4.58.0410062156490.18565@schroedinger.engr.sgi.com>
References: <B6E8046E1E28D34EB815A11AC8CA312902CD3264@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409240508560.5706@schroedinger.engr.sgi.com>
 <4154F349.1090408@redhat.com> <Pine.LNX.4.58.0409242253080.13099@schroedinger.engr.sgi.com>
 <41550B77.1070604@redhat.com> <B6E8046E1E28D34EB815A11AC8CA312902CD327E@mtv-atc-605e--n.corp.sgi.com>
 <Pine.LNX.4.58.0409271344220.32308@schroedinger.engr.sgi.com>
 <4159B920.3040802@redhat.com> <Pine.LNX.4.58.0409282017340.18604@schroedinger.engr.sgi.com>
 <415AF4C3.1040808@mvista.com> <B6E8046E1E28D34EB815A11AC8CA31290322B307@mtv-atc-605e--n.corp.sgi.com>
 <B6E8046E1E28D34EB815A11AC8CA31290322B331@mtv-atc-605e--n.corp.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Index: linux-2.6.9-rc3/kernel/posix-timers.c
===================================================================
--- linux-2.6.9-rc3.orig/kernel/posix-timers.c	2004-09-29 20:04:47.000000000 -0700
+++ linux-2.6.9-rc3/kernel/posix-timers.c	2004-10-06 10:39:52.000000000 -0700
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
@@ -192,12 +188,13 @@
 #define p_timer_del(clock,a) \
 		if_clock_do((clock)->timer_del, do_timer_delete, (a))

-void register_posix_clock(int clock_id, struct k_clock *new_clock);
 static int do_posix_gettime(struct k_clock *clock, struct timespec *tp);
 static u64 do_posix_clock_monotonic_gettime_parts(
 	struct timespec *tp, struct timespec *mo);
 int do_posix_clock_monotonic_gettime(struct timespec *tp);
-int do_posix_clock_monotonic_settime(struct timespec *tp);
+static int do_posix_clock_monotonic_settime(struct timespec *tp);
+static int do_posix_clock_process_gettime(struct timespec *tp);
+static int do_posix_clock_thread_gettime(struct timespec *tp);
 static struct k_itimer *lock_timer(timer_t timer_id, unsigned long *flags);

 static inline void unlock_timer(struct k_itimer *timr, unsigned long flags)
@@ -216,7 +213,21 @@
 	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
 		.abs_struct = NULL,
 		.clock_get = do_posix_clock_monotonic_gettime,
-		.clock_set = do_posix_clock_monotonic_settime
+		.clock_set = do_posix_clock_nosettime
+	};
+	struct k_clock clock_thread = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
+		.clock_get = do_posix_clock_thread_gettime,
+		.clock_set = do_posix_clock_nosettime,
+		.timer_create = do_posix_clock_notimer_create,
+		.nsleep = do_posix_clock_nonanosleep
+	};
+	struct k_clock clock_process = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
+		.clock_get = do_posix_clock_process_gettime,
+		.clock_set = do_posix_clock_nosettime,
+		.timer_create = do_posix_clock_notimer_create,
+		.nsleep = do_posix_clock_nonanosleep
 	};

 #ifdef CONFIG_TIME_INTERPOLATION
@@ -226,6 +237,8 @@

 	register_posix_clock(CLOCK_REALTIME, &clock_realtime);
 	register_posix_clock(CLOCK_MONOTONIC, &clock_monotonic);
+	register_posix_clock(CLOCK_PROCESS_CPUTIME_ID, &clock_process);
+	register_posix_clock(CLOCK_THREAD_CPUTIME_ID, &clock_thread);

 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, NULL, NULL);
@@ -577,6 +590,10 @@
 				!posix_clocks[which_clock].res)
 		return -EINVAL;

+	if (posix_clocks[which_clock].timer_create)
+		return posix_clocks[which_clock].timer_create(which_clock,
+				timer_event_spec, created_timer_id);
+
 	new_timer = alloc_posix_timer();
 	if (unlikely(!new_timer))
 		return -EAGAIN;
@@ -1222,16 +1239,87 @@
 	return 0;
 }

-int do_posix_clock_monotonic_settime(struct timespec *tp)
+int do_posix_clock_nosettime(struct timespec *tp)
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
+static unsigned long process_ticks(task_t *p) {
+	unsigned long ticks;
+	task_t *t;
+
+	spin_lock(&p->sighand->siglock);
+	/* The signal structure is shared between all threads */
+	ticks = p->signal->utime + p->signal->stime;
+
+	/* Add up the cpu time for all the still running threads of this process */
+	t = p;
+	do {
+		ticks += t->utime + t->stime;
+		t = next_thread(t);
+	} while (t != p);
+
+	spin_unlock(&p->sighand->siglock);
+	return ticks;
+}
+
+static inline unsigned long thread_ticks(task_t *p) {
+	return p->utime + current->stime;
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
+	jiffies_to_timespec(thread_ticks(current), tp);
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
+static int do_posix_clock_process_gettime(struct timespec *tp)
+{
+	jiffies_to_timespec(process_ticks(current), tp);
+	return 0;
+}
+
 asmlinkage long
 sys_clock_settime(clockid_t which_clock, const struct timespec __user *tp)
 {
 	struct timespec new_tp;

+	/* Cannot set process specific clocks */
+	if (which_clock<0)
+		return -EINVAL;
+
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
@@ -1249,6 +1337,29 @@
 	struct timespec rtn_tp;
 	int error = 0;

+	/* Process process specific clocks */
+	if (which_clock < 0) {
+		task_t *t;
+		int pid = -which_clock;
+
+		if (pid < PID_MAX_LIMIT) {
+			if (t = find_task_by_pid(pid)) {
+				jiffies_to_timespec(process_ticks(t), tp);
+				return 0;
+			}
+			return -EINVAL;
+		}
+		if (pid < 2*PID_MAX_LIMIT) {
+			if (t = find_task_by_pid(pid - PID_MAX_LIMIT)) {
+				jiffies_to_timespec(thread_ticks(t), tp);
+				return 0;
+			}
+			return -EINVAL;
+		}
+		/* More process specific clocks could follow here */
+		return -EINVAL;
+	}
+
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
@@ -1267,6 +1378,9 @@
 {
 	struct timespec rtn_tp;

+	/* All process clocks have the resolution of CLOCK_PROCESS_CPUTIME_ID */
+	if (which_clock < 0 ) which_clock = CLOCK_PROCESS_CPUTIME_ID;
+
 	if ((unsigned) which_clock >= MAX_CLOCKS ||
 					!posix_clocks[which_clock].res)
 		return -EINVAL;
@@ -1413,7 +1527,10 @@
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
Index: linux-2.6.9-rc3/include/linux/posix-timers.h
===================================================================
--- linux-2.6.9-rc3.orig/include/linux/posix-timers.h	2004-09-29 20:04:46.000000000 -0700
+++ linux-2.6.9-rc3/include/linux/posix-timers.h	2004-10-06 10:33:52.000000000 -0700
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
@@ -23,6 +24,17 @@
 	void (*timer_get) (struct k_itimer * timr,
 			   struct itimerspec * cur_setting);
 };
+
+void register_posix_clock(int clock_id, struct k_clock *new_clock);
+
+/* Error handlers for timer_create, nanosleep and settime */
+int do_posix_clock_notimer_create(int which_clock,
+                struct sigevent __user *time_event_spec,
+                timer_t __user *created_timer_id);
+
+int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec * t);
+int do_posix_clock_nosettime(struct timespec *tp);
+
 struct now_struct {
 	unsigned long jiffies;
 };
@@ -42,3 +54,4 @@
               }								\
             }while (0)
 #endif
+
Index: linux-2.6.9-rc3/include/linux/time.h
===================================================================
--- linux-2.6.9-rc3.orig/include/linux/time.h	2004-09-29 20:05:18.000000000 -0700
+++ linux-2.6.9-rc3/include/linux/time.h	2004-10-06 10:33:52.000000000 -0700
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
