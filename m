Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVEITyv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVEITyv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 May 2005 15:54:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261415AbVEITyv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 May 2005 15:54:51 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:49146 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261389AbVEITy0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 May 2005 15:54:26 -0400
Message-ID: <427FBFE1.5020204@mvista.com>
Date: Mon, 09 May 2005 12:54:09 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: linux-kernel@vger.kernel.org, dwalker@mvista.com
Subject: Re: [patch] Real-Time Preemption, -RT-2.6.12-rc4-V0.7.47-00
References: <20050509073702.GA13615@elte.hu>
In-Reply-To: <20050509073702.GA13615@elte.hu>
Content-Type: multipart/mixed;
 boundary="------------060407090404020805080505"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This is a multi-part message in MIME format.
--------------060407090404020805080505
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Ingo,

Could you add the attached patch to the RT patch.  It fixes the memory 
corruption issue with the 2timer_test that we have been tracking down.

Also, I think that del_timer_sync and friends need to be turned on if soft_irq 
is preemptable.

Comments?
-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

--------------060407090404020805080505
Content-Type: text/plain;
 name="rt-timers-fix.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="rt-timers-fix.patch"

Source: MontaVista Software, Inc.  George Anzinger<george@mvista.com>
MR: 11506
Type: Defect Fix 
Disposition:  needs submitting to RT community patch
Keywords:
Signed-off-by: George Anzinger<george@mvista.com>
Description:

This change adds code to protect timers while they are being accesed by
the timer call back code.  This is now needed because the call back code
is preemptable when ever softirqs are preemptable.  In the past this was
needed only for SMP systems and it is that code which is expanded and
enhanced to account for the possiblility that the timer call back may be
preempted for some period of time.  (In the SMP case this time was
rather short so a spin was accetable.)

 posix-timers.c |   82 ++++++++++++++++++++++++++++++++++++++++-----------------
 1 files changed, 58 insertions(+), 24 deletions(-)

Index: linux-2.6.10/kernel/posix-timers.c
===================================================================
--- linux-2.6.10.orig/kernel/posix-timers.c
+++ linux-2.6.10/kernel/posix-timers.c
@@ -94,7 +94,7 @@ static DEFINE_SPINLOCK(idr_lock);
 #define TIMER_INACTIVE 1
 #define TIMER_RETRY 1
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
 # define timer_active(tmr) \
 		((tmr)->it_timer.entry.prev != (void *)TIMER_INACTIVE)
 # define set_timer_inactive(tmr) \
@@ -102,10 +102,28 @@ static DEFINE_SPINLOCK(idr_lock);
 			(tmr)->it_timer.entry.prev = (void *)TIMER_INACTIVE; \
 		} while (0)
 #else
-# define timer_active(tmr) BARFY	// error to use outside of SMP
+# define timer_active(tmr) BARFY   /* error to use outside of SMP | RT */
 # define set_timer_inactive(tmr) do { } while (0)
 #endif
 /*
+ * For RT the timer call backs are preemptable.  This means that folks
+ * trying to delete timers may run into timers that are "active" for
+ * long times.  To help out with this we provide a wake up function to
+ * wake up a caller who wants waking when a timer clears the call back.
+ * This is the same sort of thing that the del_timer_sync does, but we
+ * need (in the HRT case) to cover two lists and not just the one.
+ */
+#ifdef CONFIG_PREEMPT_SOFTIRQS
+#include <linux/wait.h>
+static DECLARE_WAIT_QUEUE_HEAD(timer_wake_queue);
+#define wake_timer_waiters() wake_up(&timer_wake_queue)
+#define wait_for_timer(timer) wait_event(timer_wake_queue, !timer_active(timer))
+
+#else
+#define wake_timer_waiters()
+#define wait_for_timer(timer)
+#endif
+/*
  * we assume that the new SIGEV_THREAD_ID shares no bits with the other
  * SIGEV values.  Here we put out an error if this assumption fails.
  */
@@ -461,6 +479,7 @@ static void posix_timer_fn(unsigned long
 			schedule_next_timer(timr);
 	}
 	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
+	wake_timer_waiters();
 }
 
 
@@ -922,18 +941,20 @@ do_timer_settime(struct k_itimer *timr, 
 	 * careful here.  If smp we could be in the "fire" routine which will
 	 * be spinning as we hold the lock.  But this is ONLY an SMP issue.
 	 */
-#ifdef CONFIG_SMP
-	if (timer_active(timr) && !del_timer(&timr->it_timer))
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
+	if (timer_active(timr) && !del_timer(&timr->it_timer)) {
 		/*
-		 * It can only be active if on an other cpu.  Since
-		 * we have cleared the interval stuff above, it should
-		 * clear once we release the spin lock.  Of course once
-		 * we do that anything could happen, including the
-		 * complete melt down of the timer.  So return with
-		 * a "retry" exit status.
+		 * It can only be active if on an other cpu (unless RT).
+		 * Since we have cleared the interval stuff above, it
+		 * should clear once we release the spin lock.  Of
+		 * course once we do that anything could happen,
+		 * including the complete melt down of the timer.  So
+		 * return with a "retry" exit status.  If RT we do a
+		 * formal wait as the function code is fully
+		 * preemptable...
 		 */
 		return TIMER_RETRY;
-
+	}
 	set_timer_inactive(timr);
 #else
 	del_timer(&timr->it_timer);
@@ -1011,7 +1032,8 @@ retry:
 							       &new_spec, rtn);
 	unlock_timer(timr, flag);
 	if (error == TIMER_RETRY) {
-		rtn = NULL;	// We already got the old time...
+		wait_for_timer(timr);
+		rtn = NULL;	/* We already got the old time... */
 		goto retry;
 	}
 
@@ -1025,17 +1047,19 @@ retry:
 static inline int do_timer_delete(struct k_itimer *timer)
 {
 	timer->it_incr = 0;
-#ifdef CONFIG_SMP
-	if (timer_active(timer) && !del_timer(&timer->it_timer))
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
+	if (timer_active(timer) && !del_timer(&timer->it_timer)) {
 		/*
-		 * It can only be active if on an other cpu.  Since
-		 * we have cleared the interval stuff above, it should
-		 * clear once we release the spin lock.  Of course once
-		 * we do that anything could happen, including the
-		 * complete melt down of the timer.  So return with
-		 * a "retry" exit status.
+		 * It can only be active if on an other cpu (unless RT).
+		 * Since we have cleared the interval stuff above, it
+		 * should clear once we release the spin lock.  Of
+		 * course once we do that anything could happen,
+		 * including the complete melt down of the timer.  So
+		 * return with a "retry" exit status.  For RT we do a
+		 * formal wait as it could take a while.
 		 */
 		return TIMER_RETRY;
+	}
 #else
 	del_timer(&timer->it_timer);
 #endif
@@ -1051,7 +1075,7 @@ sys_timer_delete(timer_t timer_id)
 	struct k_itimer *timer;
 	long flags;
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
 	int error;
 retry_delete:
 #endif
@@ -1059,11 +1083,12 @@ retry_delete:
 	if (!timer)
 		return -EINVAL;
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
 	error = p_timer_del(&posix_clocks[timer->it_clock], timer);
 
 	if (error == TIMER_RETRY) {
 		unlock_timer(timer, flags);
+		wait_for_timer(timer);
 		goto retry_delete;
 	}
 #else
@@ -1092,17 +1117,18 @@ static inline void itimer_delete(struct 
 {
 	unsigned long flags;
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
 	int error;
 retry_delete:
 #endif
 	spin_lock_irqsave(&timer->it_lock, flags);
 
-#ifdef CONFIG_SMP
+#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_SOFTIRQS)
 	error = p_timer_del(&posix_clocks[timer->it_clock], timer);
 
 	if (error == TIMER_RETRY) {
 		unlock_timer(timer, flags);
+		wait_for_timer(timer);
 		goto retry_delete;
 	}
 #else
@@ -1369,6 +1395,14 @@ void clock_was_set(void)
 		list_del_init(&timr->abs_timer_entry);
 		if (add_clockset_delta(timr, &new_wall_to) &&
 		    del_timer(&timr->it_timer))  /* timer run yet? */
+			/*
+			 * Note that we only do this if the timer is/was
+			 * in the list.  If it happens to be active an
+			 * not in the timer list, it must be in the call
+			 * back function, we leave it to that code to do
+			 * the right thing.  I.e we do NOT need
+			 * del_timer_sync()
+			 */
 			add_timer(&timr->it_timer);
 		list_add(&timr->abs_timer_entry, &abs_list.list);
 		spin_unlock_irq(&abs_list.lock);

--------------060407090404020805080505--
