Return-Path: <linux-kernel-owner+willy=40w.ods.org-S270532AbUJUD5D@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270532AbUJUD5D (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 23:57:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270520AbUJUDwt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 23:52:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:35741 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S270513AbUJUDsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 23:48:31 -0400
Date: Wed, 20 Oct 2004 20:47:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
X-X-Sender: clameter@schroedinger.engr.sgi.com
To: Linus Torvalds <torvalds@osdl.org>
cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Posix layer <-> clock driver API fix
In-Reply-To: <Pine.LNX.4.58.0410201658340.2317@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0410202040240.5906@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.58.0410201022030.2317@ppc970.osdl.org>
 <Pine.LNX.4.58.0410201106580.2240@schroedinger.engr.sgi.com>
 <20041020111218.15643dab.akpm@osdl.org> <Pine.LNX.4.58.0410201117290.2240@schroedinger.engr.sgi.com>
 <20041020114709.770800ca.akpm@osdl.org> <Pine.LNX.4.58.0410201207100.2627@schroedinger.engr.sgi.com>
 <Pine.LNX.4.58.0410201658340.2317@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is needed for an mmtimer driver update that we are currently working
on. The mmtimer driver provides CLOCK_SGI_CYCLE via clock_gettime and
clock_settime.

With this api fix one will be able to use timer_create,
timer_settime and friends from userspace to schedule and receive signals
via timer interrupts of mmtimer.

Changelog
	* Clean up timer api for drivers that use register_posix_clock. Drivers
	  will then be able to use posix timers to schedule interrupts.
	* Change API for posix_clocks[].timer_create to only pass one pointer
	  to a k_itimer structure that is now allocated and managed by the
	  posix layer in the same way as for the other posix timer
	  functions.
	* Isolate a timer_event(timr) function in posix-timers.c that may
	  be called by the interrupt routine of a timer to signal that the
	  scheduled event has taken place.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.9/kernel/posix-timers.c
===================================================================
--- linux-2.6.9.orig/kernel/posix-timers.c	2004-10-20 20:05:52.000000000 -0700
+++ linux-2.6.9/kernel/posix-timers.c	2004-10-20 20:06:44.000000000 -0700
@@ -384,32 +384,10 @@
 		unlock_timer(timr, flags);
 }

-/*
- * Notify the task and set up the timer for the next expiration (if
- * applicable).  This function requires that the k_itimer structure
- * it_lock is taken.  This code will requeue the timer only if we get
- * either an error return or a flag (ret > 0) from send_seg_info
- * indicating that the signal was either not queued or was queued
- * without an info block.  In this case, we will not get a call back to
- * do_schedule_next_timer() so we do it here.  This should be rare...
-
- * An interesting problem can occur if, while a signal, and thus a call
- * back is pending, the timer is rearmed, i.e. stopped and restarted.
- * We then need to sort out the call back and do the right thing.  What
- * we do is to put a counter in the info block and match it with the
- * timers copy on the call back.  If they don't match, we just ignore
- * the call back.  The counter is local to the timer and we use odd to
- * indicate a call back is pending.  Note that we do allow the timer to
- * be deleted while a signal is pending.  The standard says we can
- * allow that signal to be delivered, and we do.
- */
-
-static void timer_notify_task(struct k_itimer *timr)
+int timer_event(struct k_itimer *timr,int si_private)
 {
-	int ret;
-
 	memset(&timr->sigq->info, 0, sizeof(siginfo_t));
-
+	timr->sigq->info.si_sys_private = si_private;
 	/*
 	 * Send signal to the process that owns this timer.

@@ -424,12 +402,6 @@
 	timr->sigq->info.si_code = SI_TIMER;
 	timr->sigq->info.si_tid = timr->it_id;
 	timr->sigq->info.si_value = timr->it_sigev_value;
-	if (timr->it_incr)
-		timr->sigq->info.si_sys_private = ++timr->it_requeue_pending;
-	else {
-		remove_from_abslist(timr);
-	}
-
 	if (timr->it_sigev_notify & SIGEV_THREAD_ID) {
 		if (unlikely(timr->it_process->flags & PF_EXITING)) {
 			timr->it_sigev_notify = SIGEV_SIGNAL;
@@ -437,28 +409,20 @@
 			timr->it_process = timr->it_process->group_leader;
 			goto group;
 		}
-		ret = send_sigqueue(timr->it_sigev_signo, timr->sigq,
+		return send_sigqueue(timr->it_sigev_signo, timr->sigq,
 			timr->it_process);
 	}
 	else {
 	group:
-		ret = send_group_sigqueue(timr->it_sigev_signo, timr->sigq,
+		return send_group_sigqueue(timr->it_sigev_signo, timr->sigq,
 			timr->it_process);
 	}
-	if (ret) {
-		/*
-		 * signal was not sent because of sig_ignor
-		 * we will not get a call back to restart it AND
-		 * it should be restarted.
-		 */
-		schedule_next_timer(timr);
-	}
 }

 /*
  * This function gets called when a POSIX.1b interval timer expires.  It
  * is used as a callback from the kernel internal timer.  The
- * run_timer_list code ALWAYS calls with interrutps on.
+ * run_timer_list code ALWAYS calls with interrupts on.

  * This code is for CLOCK_REALTIME* and CLOCK_MONOTONIC* timers.
  */
@@ -501,8 +465,23 @@
 		spin_unlock(&abs_list.lock);

 	}
-	if (do_notify)
-		timer_notify_task(timr);
+	if (do_notify)  {
+		int si_private=0;
+
+		if (timr->it_incr)
+			si_private = ++timr->it_requeue_pending;
+		else {
+			remove_from_abslist(timr);
+		}
+
+		if (timer_event(timr, si_private))
+			/*
+			 * signal was not sent because of sig_ignor
+			 * we will not get a call back to restart it AND
+			 * it should be restarted.
+			 */
+			schedule_next_timer(timr);
+	}
 	unlock_timer(timr, flags); /* hold thru abs lock to keep irq off */
 }

@@ -585,10 +564,6 @@
 				!posix_clocks[which_clock].res)
 		return -EINVAL;

-	if (posix_clocks[which_clock].timer_create)
-		return posix_clocks[which_clock].timer_create(which_clock,
-				timer_event_spec, created_timer_id);
-
 	new_timer = alloc_posix_timer();
 	if (unlikely(!new_timer))
 		return -EAGAIN;
@@ -620,11 +595,17 @@
 	new_timer->it_clock = which_clock;
 	new_timer->it_incr = 0;
 	new_timer->it_overrun = -1;
-	init_timer(&new_timer->it_timer);
-	new_timer->it_timer.expires = 0;
-	new_timer->it_timer.data = (unsigned long) new_timer;
-	new_timer->it_timer.function = posix_timer_fn;
-	set_timer_inactive(new_timer);
+	if (posix_clocks[which_clock].timer_create) {
+		error =  posix_clocks[which_clock].timer_create(new_timer);
+		if (error)
+			goto out;
+	} else {
+		init_timer(&new_timer->it_timer);
+		new_timer->it_timer.expires = 0;
+		new_timer->it_timer.data = (unsigned long) new_timer;
+		new_timer->it_timer.function = posix_timer_fn;
+		set_timer_inactive(new_timer);
+	}

 	/*
 	 * return the timer_id now.  The next step is hard to
@@ -1239,9 +1220,7 @@
 	return -EINVAL;
 }

-int do_posix_clock_notimer_create(int which_clock,
-		struct sigevent __user *timer_event_spec,
-		timer_t __user *created_timer_id) {
+int do_posix_clock_notimer_create(struct k_itimer *timer) {
 	return -EINVAL;
 }

Index: linux-2.6.9/include/linux/posix-timers.h
===================================================================
--- linux-2.6.9.orig/include/linux/posix-timers.h	2004-10-20 19:38:03.000000000 -0700
+++ linux-2.6.9/include/linux/posix-timers.h	2004-10-20 20:05:57.000000000 -0700
@@ -33,8 +33,7 @@
 	struct k_clock_abs *abs_struct;
 	int (*clock_set) (struct timespec * tp);
 	int (*clock_get) (struct timespec * tp);
-	int (*timer_create) (int which_clock, struct sigevent __user *timer_event_spec,
-			timer_t __user * created_timer_id);
+	int (*timer_create) (struct k_itimer *timer);
 	int (*nsleep) (int which_clock, int flags,
 		       struct timespec * t);
 	int (*timer_set) (struct k_itimer * timr, int flags,
@@ -48,13 +47,13 @@
 void register_posix_clock(int clock_id, struct k_clock *new_clock);

 /* Error handlers for timer_create, nanosleep and settime */
-int do_posix_clock_notimer_create(int which_clock,
-                struct sigevent __user *time_event_spec,
-                timer_t __user *created_timer_id);
-
+int do_posix_clock_notimer_create(struct k_itimer *timer);
 int do_posix_clock_nonanosleep(int which_clock, int flags, struct timespec * t);
 int do_posix_clock_nosettime(struct timespec *tp);

+/* function to call to trigger timer event */
+int timer_event(struct k_itimer *timr, int si_private);
+
 struct now_struct {
 	unsigned long jiffies;
 };
