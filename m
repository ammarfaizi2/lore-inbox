Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265249AbUF1WDT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265249AbUF1WDT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 18:03:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265248AbUF1WDS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 18:03:18 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32507 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S265249AbUF1WAr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 18:00:47 -0400
Message-ID: <40E094DB.9000702@mvista.com>
Date: Mon, 28 Jun 2004 14:59:55 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
CC: "Hu, Boris" <boris.hu@intel.com>, drepper@redhat.com,
       "Li, Adam" <adam.li@intel.com>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@digeo.com>
Subject: [PATCH] Bugfix for CLOCK_REALTIME absolute timer.
References: <37FBBA5F3A361C41AB7CE44558C3448E04561419@PDSMSX403.ccr.corp.intel.com>
In-Reply-To: <37FBBA5F3A361C41AB7CE44558C3448E04561419@PDSMSX403.ccr.corp.intel.com>
Content-Type: multipart/mixed;
 boundary="------------080009030705090405000407"
To: unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------080009030705090405000407
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Andrew,

Boris and I have kicked this around enough.  It think it is ready for prime time.

As required by the standard, this patch adds to POSIX ABSOLUTE timers the 
functionality of adjusting the timer when the clock is set so that it still 
expires at the specified time (provided that time has not passed, in which case 
the timer expires immeadiatly).

The standard is, IMNSOHO, a bit vague on just how repeating timers are to be 
handled so I made some choices:

1) If an absolute timer is to expire every N intervals, we assume that the 
expiries should happen at those specified times after clock setting.  I.e. we 
adjust the repeat timer as well as the initial timer.  (The other option would 
be to treat the repeating timers as relative and not to adjust them.)

2) If a clock set moves the the clock prior to the initial expiry time AND that 
time has already passed and been signaled, the current repeat timer is adjusted, 
i.e. we DO NOT go back to the initial time and repeat that.  (The other option 
is to treat this case as a new request with the initial timer parameters (which 
by this time we have lost).)

3) If time is advanced such that it appears that several expiries have been 
missed, the overrun count will reflect the misses.  (The other option is to not 
reflect this in the overrun.)  At the same time, nothing is done to acknowledge, 
to the user, that we are repeating expiries when the clock is retarded.

	Signed-off-by: George Anzinger <george@mvista.com>
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

--------------080009030705090405000407
Content-Type: text/plain;
 name="hrtimer-abs-2.6.6-1.2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="hrtimer-abs-2.6.6-1.2.patch"

diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.6.6-kbdw/include/linux/posix-timers.h linux/include/linux/posix-timers.h
--- linux-2.6.6-kbdw/include/linux/posix-timers.h	2003-11-10 17:09:04.000000000 -0800
+++ linux/include/linux/posix-timers.h	2004-06-18 19:07:59.000000000 -0700
@@ -1,8 +1,16 @@
 #ifndef _linux_POSIX_TIMERS_H
 #define _linux_POSIX_TIMERS_H
 
+#include <linux/spinlock.h>
+#include <linux/list.h>
+
+struct k_clock_abs {
+	struct list_head list;
+	spinlock_t lock;
+};
 struct k_clock {
 	int res;		/* in nano seconds */
+	struct k_clock_abs *abs_struct;
 	int (*clock_set) (struct timespec * tp);
 	int (*clock_get) (struct timespec * tp);
 	int (*nsleep) (int flags,
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.6.6-kbdw/include/linux/sched.h linux/include/linux/sched.h
--- linux-2.6.6-kbdw/include/linux/sched.h	2004-05-11 17:39:10.000000000 -0700
+++ linux/include/linux/sched.h	2004-06-14 17:40:35.000000000 -0700
@@ -342,6 +342,8 @@
 	struct task_struct *it_process;	/* process to send signal to */
 	struct timer_list it_timer;
 	struct sigqueue *sigq;		/* signal queue entry. */
+	struct list_head abs_timer_entry; /* clock abs_timer_list */
+	struct timespec wall_to_prev;   /* wall_to_monotonic used when set */
 };
 
 
diff -urP -I '\$Id:.*Exp \$' -X /usr/src/patch.exclude linux-2.6.6-kbdw/kernel/posix-timers.c linux/kernel/posix-timers.c
--- linux-2.6.6-kbdw/kernel/posix-timers.c	2004-05-11 17:39:11.000000000 -0700
+++ linux/kernel/posix-timers.c	2004-06-25 15:04:47.000000000 -0700
@@ -7,6 +7,9 @@
  *
  *			     Copyright (C) 2002 2003 by MontaVista Software.
  *
+ * 2004-06-01  Fix CLOCK_REALTIME clock/timer TIMER_ABSTIME bug.
+ *			     Copyright (C) 2004 Boris Hu
+ *                            
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License as published by
  * the Free Software Foundation; either version 2 of the License, or (at
@@ -41,6 +44,7 @@
 #include <linux/idr.h>
 #include <linux/posix-timers.h>
 #include <linux/wait.h>
+#include <linux/workqueue.h>
 
 #ifndef div_long_long_rem
 #include <asm/div64.h>
@@ -169,6 +173,12 @@
  */
 
 static struct k_clock posix_clocks[MAX_CLOCKS];
+/*
+ * We only have one real clock that can be set so we need only one abs list,
+ * even if we should want to have several clocks with differing resolutions.
+ */
+static struct k_clock_abs abs_list = {.list = LIST_HEAD_INIT(abs_list.list),
+				      .lock = SPIN_LOCK_UNLOCKED};
 
 #define if_clock_do(clock_fun,alt_fun,parms) \
 		(!clock_fun) ? alt_fun parms : clock_fun parms
@@ -200,8 +210,11 @@
  */
 static __init int init_posix_timers(void)
 {
-	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES };
+	struct k_clock clock_realtime = {.res = CLOCK_REALTIME_RES,
+					 .abs_struct = &abs_list
+	};
 	struct k_clock clock_monotonic = {.res = CLOCK_REALTIME_RES,
+		.abs_struct = NULL,
 		.clock_get = do_posix_clock_monotonic_gettime,
 		.clock_set = do_posix_clock_monotonic_settime
 	};
@@ -212,7 +225,6 @@
 	posix_timers_cache = kmem_cache_create("posix_timers_cache",
 					sizeof (struct k_itimer), 0, 0, 0, 0);
 	idr_init(&posix_timers_id);
-
 	return 0;
 }
 
@@ -239,19 +251,84 @@
 		   (NSEC_JIFFIE_SC - SEC_JIFFIE_SC))) >> SEC_JIFFIE_SC;
 }
 
+/*
+ * This function adjusts the timer as needed as a result of the clock
+ * being set.  It should only be called for absolute timers, and then
+ * under the abs_list lock.  It computes the time difference and sets
+ * the new jiffies value in the timer.  It also updates the timers
+ * reference wall_to_monotonic value.  It is complicated by the fact
+ * that tstojiffies() only handles positive times and it needs to work
+ * with both positive and negative times.  Also, for negative offsets,
+ * we need to defeat the res round up.
+ *
+ * Return is true if there is a new time, else false.
+ */
+static long add_clockset_delta(struct k_itimer *timr,
+			       struct timespec *new_wall_to)
+{
+	struct timespec delta;
+	int sign = 0;
+	u64 exp;
+
+	set_normalized_timespec(&delta, 
+				new_wall_to->tv_sec - 
+				timr->wall_to_prev.tv_sec,
+				new_wall_to->tv_nsec - 
+				timr->wall_to_prev.tv_nsec);
+	if (likely(!(delta.tv_sec | delta.tv_nsec)))
+		return 0;
+	if (delta.tv_sec < 0) {
+		set_normalized_timespec(&delta, 
+					-delta.tv_sec,
+					1 - delta.tv_nsec -
+					posix_clocks[timr->it_clock].res);
+		sign++;
+	}
+	tstojiffie(&delta, posix_clocks[timr->it_clock].res, &exp);
+	timr->wall_to_prev = *new_wall_to;
+	timr->it_timer.expires += (sign ? -exp : exp);
+	return 1;
+}
+
 static void schedule_next_timer(struct k_itimer *timr)
 {
+	struct timespec new_wall_to;
 	struct now_struct now;
+	unsigned long seq;
 
-	/* Set up the timer for the next interval (if there is one) */
+	/* 
+	 * Set up the timer for the next interval (if there is one).
+	 * Note: this code uses the abs_timer_lock to protect
+	 * wall_to_prev and must hold it until exp is set, not exactly
+	 * obvious...
+
+	 * This function is used for CLOCK_REALTIME* and
+	 * CLOCK_MONOTONIC* timers.  If we ever want to handle other
+	 * CLOCKs, the calling code (do_schedule_next_timer) would need
+	 * to pull the "clock" info from the timer and dispatch the
+	 * "other" CLOCKs "next timer" code (which, I suppose should
+	 * also be added to the k_clock structure).
+	 */
 	if (!timr->it_incr) 
 		return;
 
-	posix_get_now(&now);
+	do {
+		seq = read_seqbegin(&xtime_lock);
+		new_wall_to =	wall_to_monotonic;
+		posix_get_now(&now);
+	} while (read_seqretry(&xtime_lock, seq));
+
+	if (!list_empty(&timr->abs_timer_entry)) {
+		spin_lock(&abs_list.lock);
+		add_clockset_delta(timr, &new_wall_to);
+	}
+		    
 	do {
 		posix_bump_timer(timr);
 	}while (posix_time_before(&timr->it_timer, &now));
 
+	if (!list_empty(&timr->abs_timer_entry))
+		spin_unlock(&abs_list.lock);
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1;
 	++timr->it_requeue_pending;
@@ -312,7 +389,15 @@
 
 	memset(&timr->sigq->info, 0, sizeof(siginfo_t));
 
-	/* Send signal to the process that owns this timer. */
+	/* 
+	 * Send signal to the process that owns this timer.
+
+	 * This code assumes that all the possible abs_lists share the
+	 * same lock (there is only one list at this time). If this is
+	 * not the case, the CLOCK info would need to be used to find
+	 * the proper abs list lock.
+	 */
+
 	timr->sigq->info.si_signo = timr->it_sigev_signo;
 	timr->sigq->info.si_errno = 0;
 	timr->sigq->info.si_code = SI_TIMER;
@@ -320,6 +405,11 @@
 	timr->sigq->info.si_value = timr->it_sigev_value;
 	if (timr->it_incr)
 		timr->sigq->info.si_sys_private = ++timr->it_requeue_pending;
+	else if (!list_empty(&timr->abs_timer_entry)) {
+		spin_lock(&abs_list.lock);
+		list_del_init(&timr->abs_timer_entry);
+		spin_unlock(&abs_list.lock);
+	}
 
 	if (timr->it_sigev_notify & SIGEV_THREAD_ID) {
 		if (unlikely(timr->it_process->flags & PF_EXITING)) {
@@ -350,16 +440,51 @@
  * This function gets called when a POSIX.1b interval timer expires.  It
  * is used as a callback from the kernel internal timer.  The
  * run_timer_list code ALWAYS calls with interrutps on.
+
+ * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
  */
 static void posix_timer_fn(unsigned long __data)
 {
 	struct k_itimer *timr = (struct k_itimer *) __data;
 	unsigned long flags;
+	unsigned long seq;
+	struct timespec delta, new_wall_to;
+	u64 exp = 0;
+	int do_notify = 1;
 
 	spin_lock_irqsave(&timr->it_lock, flags);
  	set_timer_inactive(timr);
-	timer_notify_task(timr);
-	unlock_timer(timr, flags);
+	if (!list_empty(&timr->abs_timer_entry)) {
+		spin_lock(&abs_list.lock);
+		do {
+			seq = read_seqbegin(&xtime_lock);
+			new_wall_to =	wall_to_monotonic;
+		} while (read_seqretry(&xtime_lock, seq));
+		set_normalized_timespec(&delta, 
+					new_wall_to.tv_sec - 
+					timr->wall_to_prev.tv_sec,
+					new_wall_to.tv_nsec - 
+					timr->wall_to_prev.tv_nsec);
+		if (likely((delta.tv_sec | delta.tv_nsec ) == 0)) {
+			/* do nothing, timer is on time */
+		} else if (delta.tv_sec < 0) {
+			/* do nothing, timer is already late */
+		} else {
+			/* timer is early due to a clock set */
+			tstojiffie(&delta,
+				   posix_clocks[timr->it_clock].res,
+				   &exp);
+			timr->wall_to_prev = new_wall_to;
+			timr->it_timer.expires += exp; 
+			add_timer(&timr->it_timer);
+			do_notify = 0;
+		}
+		spin_unlock(&abs_list.lock);
+		
+	}        
+	if (do_notify)
+		timer_notify_task(timr);
+	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
 }
 
 
@@ -398,6 +523,7 @@
 		return tmr;
 	memset(tmr, 0, sizeof (struct k_itimer));
 	tmr->it_id = (timer_t)-1;
+        INIT_LIST_HEAD(&tmr->abs_timer_entry);
 	if (unlikely(!(tmr->sigq = sigqueue_alloc()))) {
 		kmem_cache_free(posix_timers_cache, tmr);
 		tmr = 0;
@@ -703,11 +829,10 @@
  * time to it to get the proper time for the timer.
  */
 static int adjust_abs_time(struct k_clock *clock, struct timespec *tp, 
-			   int abs, u64 *exp)
+			   int abs, u64 *exp, struct timespec *wall_to)
 {
 	struct timespec now;
 	struct timespec oc = *tp;
-	struct timespec wall_to_mono;
 	u64 jiffies_64_f;
 	int rtn =0;
 
@@ -715,15 +840,15 @@
 		/*
 		 * The mask pick up the 4 basic clocks 
 		 */
-		if (!(clock - &posix_clocks[0]) & ~CLOCKS_MASK) {
+		if (!((clock - &posix_clocks[0]) & ~CLOCKS_MASK)) {
 			jiffies_64_f = do_posix_clock_monotonic_gettime_parts(
-				&now,  &wall_to_mono);
+				&now,  wall_to);
 			/*
 			 * If we are doing a MONOTONIC clock
 			 */
 			if((clock - &posix_clocks[0]) & CLOCKS_MONO){
-				now.tv_sec += wall_to_mono.tv_sec;
-				now.tv_nsec += wall_to_mono.tv_nsec;
+				now.tv_sec += wall_to->tv_sec;
+				now.tv_nsec += wall_to->tv_nsec;
 			}
 		} else {
 			/*
@@ -813,6 +938,11 @@
 #else
 	del_timer(&timr->it_timer);
 #endif
+	if (!list_empty(&timr->abs_timer_entry)) {
+		spin_lock(&abs_list.lock);
+		list_del_init(&timr->abs_timer_entry);
+		spin_unlock(&abs_list.lock);
+	}
 	timr->it_requeue_pending = (timr->it_requeue_pending + 2) & 
 		~REQUEUE_PENDING;
 	timr->it_overrun_last = 0;
@@ -827,24 +957,25 @@
 
 	if (adjust_abs_time(clock,
 			    &new_setting->it_value, flags & TIMER_ABSTIME, 
-			    &expire_64)) {
+			    &expire_64, &(timr->wall_to_prev))) {
 		return -EINVAL;
 	}
 	timr->it_timer.expires = (unsigned long)expire_64;	
 	tstojiffie(&new_setting->it_interval, clock->res, &expire_64);
 	timr->it_incr = (unsigned long)expire_64;
 
-
 	/*
-	 * For some reason the timer does not fire immediately if expires is
-	 * equal to jiffies, so the timer notify function is called directly.
-	 * We do not even queue SIGEV_NONE timers!
+	 * We do not even queue SIGEV_NONE timers!  But we do put them
+	 * in the abs list so we can do that right.
 	 */
-	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE)) {
-		if (timr->it_timer.expires == jiffies)
-			timer_notify_task(timr);
-		else
-			add_timer(&timr->it_timer);
+	if (((timr->it_sigev_notify & ~SIGEV_THREAD_ID) != SIGEV_NONE))
+		add_timer(&timr->it_timer);
+
+	if (flags & TIMER_ABSTIME && clock->abs_struct) {
+		spin_lock(&clock->abs_struct->lock);
+		list_add_tail(&(timr->abs_timer_entry),
+			      &(clock->abs_struct->list));
+		spin_unlock(&clock->abs_struct->lock);
 	}
 	return 0;
 }
@@ -878,7 +1009,7 @@
 	if (!posix_clocks[timr->it_clock].timer_set)
 		error = do_timer_settime(timr, flags, &new_spec, rtn);
 	else
-		error = posix_clocks[timr->it_clock].timer_set(timr,
+	        error = posix_clocks[timr->it_clock].timer_set(timr,
 							       flags,
 							       &new_spec, rtn);
 	unlock_timer(timr, flag);
@@ -911,6 +1042,11 @@
 #else
 	del_timer(&timer->it_timer);
 #endif
+	if (!list_empty(&timer->abs_timer_entry)) {
+		spin_lock(&abs_list.lock);
+		list_del_init(&timer->abs_timer_entry);
+		spin_unlock(&abs_list.lock);
+	}	 
 	return 0;
 }
 
@@ -1153,13 +1289,96 @@
  * On locking, clock_was_set() is called from update_wall_clock which
  * holds (or has held for it) a write_lock_irq( xtime_lock) and is
  * called from the timer bh code.  Thus we need the irq save locks.
+ *
+ * Also, on the call from update_wall_clock, that is done as part of a
+ * softirq thing.  We don't want to delay the system that much (possibly
+ * long list of timers to fix), so we defer that work to keventd.
  */
 
 static DECLARE_WAIT_QUEUE_HEAD(nanosleep_abs_wqueue);
+static DECLARE_WORK(clock_was_set_work, (void(*)(void*))clock_was_set, NULL);
+
+static DECLARE_MUTEX(clock_was_set_lock);
+#define mutex_enter(x) down(x)
+#define mutex_enter_interruptable(x) down_interruptible(x)
+#define mutex_exit(x) up(x)
 
 void clock_was_set(void)
 {
+	struct k_itimer *timr;
+	struct timespec new_wall_to;
+	LIST_HEAD(cws_list);
+	unsigned long seq;
+
+	
+	if (unlikely(in_interrupt())) {
+		schedule_work(&clock_was_set_work);
+		return;
+	}
 	wake_up_all(&nanosleep_abs_wqueue);
+
+	/*
+	 * Check if there exist TIMER_ABSTIME timers to correct.  
+	 *
+	 * Notes on locking: This code is run in task context with irq
+	 * on.  We CAN be interrupted!  All other usage of the abs list
+	 * lock is under the timer lock which holds the irq lock as
+	 * well.  We REALLY don't want to scan the whole list with the
+	 * interrupt system off, AND we would like a sequence lock on
+	 * this code as well.  Since we assume that the clock will not
+	 * be set often, it seems ok to take and release the irq lock
+	 * for each timer.  In fact add_timer will do this, so this is
+	 * not an issue.  So we know when we are done, we will move the
+	 * whole list to a new location.  Then as we process each entry,
+	 * we will move it to the actual list again.  This way, when our
+	 * copy is empty, we are done.  We are not all that concerned
+	 * about preemption so we will use a semaphore lock to protect
+	 * aginst reentry.  This way we will not stall another
+	 * processor.  It is possible that this may delay some timers
+	 * that should have expired, given the new clock, but even this
+	 * will be minimal as we will always update to the current time,
+	 * even if it was set by a task that is waiting for entry to
+	 * this code.  Timers that expire too early will be caught by
+	 * the expire code and restarted.
+
+	 * Absolute timers that repeat are left in the abs list while
+	 * waiting for the task to pick up the signal.  This means we
+	 * may find timers that are not in the "add_timer" list, but are
+	 * in the abs list.  We do the same thing for these, save
+	 * putting them back in the "add_timer" list.  (Note, these are
+	 * left in the abs list mainly to indicate that they are
+	 * ABSOLUTE timers, a fact that is used by the re-arm code, and
+	 * for which we have no other flag.)
+
+	 */
+
+	mutex_enter(&clock_was_set_lock);
+	spin_lock_irq(&abs_list.lock);
+	list_splice_init(&abs_list.list, &cws_list);
+	spin_unlock_irq(&abs_list.lock);
+	do {
+		do {
+			seq = read_seqbegin(&xtime_lock);
+			new_wall_to =	wall_to_monotonic;
+		} while (read_seqretry(&xtime_lock, seq));
+
+		spin_lock_irq(&abs_list.lock);
+		if (list_empty(&cws_list)) {
+			spin_unlock_irq(&abs_list.lock);
+			break;
+		}
+		timr = list_entry(cws_list.next, struct k_itimer, 
+				   abs_timer_entry);
+		
+		list_del_init(&timr->abs_timer_entry);
+		if (add_clockset_delta(timr, &new_wall_to) &&
+		    del_timer(&timr->it_timer))  /* timer run yet? */
+			add_timer(&timr->it_timer);
+		list_add(&timr->abs_timer_entry, &abs_list.list);
+		spin_unlock_irq(&abs_list.lock);
+	} while (1);
+
+	mutex_exit(&clock_was_set_lock);
 }
 
 long clock_nanosleep_restart(struct restart_block *restart_block);
@@ -1202,7 +1421,7 @@
 long
 do_clock_nanosleep(clockid_t which_clock, int flags, struct timespec *tsave)
 {
-	struct timespec t;
+	struct timespec t, dum;
 	struct timer_list new_timer;
 	DECLARE_WAITQUEUE(abs_wqueue, current);
 	u64 rq_time = (u64)0;
@@ -1242,7 +1461,7 @@
 		t = *tsave;
 		if (abs || !rq_time) {
 			adjust_abs_time(&posix_clocks[which_clock], &t, abs,
-					&rq_time);
+					&rq_time, &dum);
 			rq_time += (t.tv_sec || t.tv_nsec);
 		}
 
Binary files linux-2.6.6-kbdw/scripts/bin2c and linux/scripts/bin2c differ

--------------080009030705090405000407--

