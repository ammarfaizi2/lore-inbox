Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030280AbWBNKOi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030280AbWBNKOi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 05:14:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030313AbWBNKLU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 05:11:20 -0500
Received: from scrub.xs4all.nl ([194.109.195.176]:34538 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1030300AbWBNKLN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 05:11:13 -0500
Date: Tue, 14 Feb 2006 11:11:09 +0100 (CET)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, mingo@elte.hu
Subject: [PATCH 04/12] hrtimer: avoid get_time() call in hrtimer_forward()
Message-ID: <Pine.LNX.4.61.0602141111001.3711@scrub.home>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hrtimer_forward() calls needlessly get_time(), where the callers already
know how far the timer has to be forwarded. Also cleanup
common_timer_get() a little.

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>

---

 include/linux/hrtimer.h |    2 +-
 kernel/hrtimer.c        |    7 +++----
 kernel/itimer.c         |    1 +
 kernel/posix-timers.c   |   26 +++++++++++++-------------
 4 files changed, 18 insertions(+), 18 deletions(-)

Index: linux-2.6-git/include/linux/hrtimer.h
===================================================================
--- linux-2.6-git.orig/include/linux/hrtimer.h	2006-02-14 01:42:22.000000000 +0100
+++ linux-2.6-git/include/linux/hrtimer.h	2006-02-14 04:51:45.000000000 +0100
@@ -123,7 +123,7 @@ static inline int hrtimer_active(const s
 }
 
 /* Forward a hrtimer so it expires after now: */
-extern unsigned long hrtimer_forward(struct hrtimer *timer, ktime_t interval);
+extern unsigned long hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
 
 /* Precise sleep: */
 extern long hrtimer_nanosleep(struct timespec *rqtp,
Index: linux-2.6-git/kernel/hrtimer.c
===================================================================
--- linux-2.6-git.orig/kernel/hrtimer.c	2006-02-14 01:42:22.000000000 +0100
+++ linux-2.6-git/kernel/hrtimer.c	2006-02-14 04:51:45.000000000 +0100
@@ -281,18 +281,17 @@ void unlock_hrtimer_base(const struct hr
  * hrtimer_forward - forward the timer expiry
  *
  * @timer:	hrtimer to forward
+ * @now:	forward past this time
  * @interval:	the interval to forward
  *
  * Forward the timer expiry so it will expire in the future.
  * Returns the number of overruns.
  */
 unsigned long
-hrtimer_forward(struct hrtimer *timer, ktime_t interval)
+hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval)
 {
 	unsigned long orun = 1;
-	ktime_t delta, now;
-
-	now = timer->base->get_time();
+	ktime_t delta;
 
 	delta = ktime_sub(now, timer->expires);
 
Index: linux-2.6-git/kernel/itimer.c
===================================================================
--- linux-2.6-git.orig/kernel/itimer.c	2006-02-14 01:39:42.000000000 +0100
+++ linux-2.6-git/kernel/itimer.c	2006-02-14 04:51:44.000000000 +0100
@@ -136,6 +136,7 @@ int it_real_fn(void *data)
 
 	if (tsk->signal->it_real_incr.tv64 != 0) {
 		hrtimer_forward(&tsk->signal->real_timer,
+			       tsk->signal->real_timer.base->last_expired,
 			       tsk->signal->it_real_incr);
 
 		return HRTIMER_RESTART;
Index: linux-2.6-git/kernel/posix-timers.c
===================================================================
--- linux-2.6-git.orig/kernel/posix-timers.c	2006-02-14 01:39:42.000000000 +0100
+++ linux-2.6-git/kernel/posix-timers.c	2006-02-14 04:51:44.000000000 +0100
@@ -254,6 +254,7 @@ static void schedule_next_timer(struct k
 		return;
 
 	timr->it_overrun += hrtimer_forward(&timr->it.real.timer,
+					    timr->it.real.timer.base->last_expired,
 					    timr->it.real.interval);
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1;
@@ -351,6 +352,7 @@ static int posix_timer_fn(void *data)
 		if (timr->it.real.interval.tv64 != 0) {
 			timr->it_overrun +=
 				hrtimer_forward(&timr->it.real.timer,
+						timr->it.real.timer.base->last_expired,
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
 		}
@@ -601,18 +603,20 @@ static struct k_itimer * lock_timer(time
 static void
 common_timer_get(struct k_itimer *timr, struct itimerspec *cur_setting)
 {
-	ktime_t remaining;
+	ktime_t remaining, now;
 	struct hrtimer *timer = &timr->it.real.timer;
 
 	memset(cur_setting, 0, sizeof(struct itimerspec));
-	remaining = hrtimer_get_remaining(timer);
 
-	/* Time left ? or timer pending */
-	if (remaining.tv64 > 0 || hrtimer_active(timer))
-		goto calci;
 	/* interval timer ? */
-	if (timr->it.real.interval.tv64 == 0)
+	if (timr->it.real.interval.tv64) {
+		cur_setting->it_interval =
+			ktime_to_timespec(timr->it.real.interval);
+	} else if (!hrtimer_active(timer))
 		return;
+
+	now = timer->base->get_time();
+
 	/*
 	 * When a requeue is pending or this is a SIGEV_NONE timer
 	 * move the expiry time forward by intervals, so expiry is >
@@ -621,15 +625,11 @@ common_timer_get(struct k_itimer *timr, 
 	if (timr->it_requeue_pending & REQUEUE_PENDING ||
 	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
 		timr->it_overrun +=
-			hrtimer_forward(timer, timr->it.real.interval);
-		remaining = hrtimer_get_remaining(timer);
+			hrtimer_forward(timer, now, timr->it.real.interval);
 	}
- calci:
-	/* interval timer ? */
-	if (timr->it.real.interval.tv64 != 0)
-		cur_setting->it_interval =
-			ktime_to_timespec(timr->it.real.interval);
+
 	/* Return 0 only, when the timer is expired and not pending */
+	remaining = ktime_sub(timer->expires, now);
 	if (remaining.tv64 <= 0)
 		cur_setting->it_value.tv_nsec = 1;
 	else
