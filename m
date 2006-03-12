Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932077AbWCLKh2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932077AbWCLKh2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Mar 2006 05:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751432AbWCLKg5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Mar 2006 05:36:57 -0500
Received: from 213-239-205-147.clients.your-server.de ([213.239.205.147]:25574
	"EHLO mail.tglx.de") by vger.kernel.org with ESMTP id S1751411AbWCLKgy
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Mar 2006 05:36:54 -0500
Message-Id: <20060312080331.805387000@localhost.localdomain>
References: <20060312080316.826824000@localhost.localdomain>
Date: Sun, 12 Mar 2006 10:37:14 -0000
From: Thomas Gleixner <tglx@linutronix.de>
To: Andrew Morton <akpm@osdl.org>
Cc: LKML <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@elte.hu>,
       Roman Zippel <zippel@linux-m68k.org>
Subject: [patch 2/8] Pass current time to hrtimer_forward()
Content-Disposition: inline; filename=hrtimer-forward-remove-get-time.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Roman Zippel <zippel@linux-m68k.org>

Pass current time to hrtimer_forward(). This allows to use the softirq
time in the timer base when the forward function is called from the
timer callback. Other places pass current time with a call to 
timer->base->get_time().

Signed-off-by: Roman Zippel <zippel@linux-m68k.org>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>

 include/linux/hrtimer.h |    3 ++-
 kernel/hrtimer.c        |    7 +++----
 kernel/itimer.c         |    3 ++-
 kernel/posix-timers.c   |   14 ++++++++++----
 4 files changed, 17 insertions(+), 10 deletions(-)

Index: linux-2.6.16-updates/include/linux/hrtimer.h
===================================================================
--- linux-2.6.16-updates.orig/include/linux/hrtimer.h
+++ linux-2.6.16-updates/include/linux/hrtimer.h
@@ -130,7 +130,8 @@ static inline int hrtimer_active(const s
 }
 
 /* Forward a hrtimer so it expires after now: */
-extern unsigned long hrtimer_forward(struct hrtimer *timer, ktime_t interval);
+extern unsigned long
+hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
 
 /* Precise sleep: */
 extern long hrtimer_nanosleep(struct timespec *rqtp,
Index: linux-2.6.16-updates/kernel/hrtimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/hrtimer.c
+++ linux-2.6.16-updates/kernel/hrtimer.c
@@ -301,18 +301,17 @@ void unlock_hrtimer_base(const struct hr
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
 
Index: linux-2.6.16-updates/kernel/itimer.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/itimer.c
+++ linux-2.6.16-updates/kernel/itimer.c
@@ -136,7 +136,8 @@ int it_real_fn(void *data)
 
 	if (tsk->signal->it_real_incr.tv64 != 0) {
 		hrtimer_forward(&tsk->signal->real_timer,
-			       tsk->signal->it_real_incr);
+				tsk->signal->real_timer.base->softirq_time,
+				tsk->signal->it_real_incr);
 
 		return HRTIMER_RESTART;
 	}
Index: linux-2.6.16-updates/kernel/posix-timers.c
===================================================================
--- linux-2.6.16-updates.orig/kernel/posix-timers.c
+++ linux-2.6.16-updates/kernel/posix-timers.c
@@ -250,15 +250,18 @@ __initcall(init_posix_timers);
 
 static void schedule_next_timer(struct k_itimer *timr)
 {
+	struct hrtimer *timer = &timr->it.real.timer;
+
 	if (timr->it.real.interval.tv64 == 0)
 		return;
 
-	timr->it_overrun += hrtimer_forward(&timr->it.real.timer,
+	timr->it_overrun += hrtimer_forward(timer, timer->base->get_time(),
 					    timr->it.real.interval);
+
 	timr->it_overrun_last = timr->it_overrun;
 	timr->it_overrun = -1;
 	++timr->it_requeue_pending;
-	hrtimer_restart(&timr->it.real.timer);
+	hrtimer_restart(timer);
 }
 
 /*
@@ -333,6 +336,7 @@ EXPORT_SYMBOL_GPL(posix_timer_event);
 static int posix_timer_fn(void *data)
 {
 	struct k_itimer *timr = data;
+	struct hrtimer *timer = &timr->it.real.timer;
 	unsigned long flags;
 	int si_private = 0;
 	int ret = HRTIMER_NORESTART;
@@ -350,7 +354,8 @@ static int posix_timer_fn(void *data)
 		 */
 		if (timr->it.real.interval.tv64 != 0) {
 			timr->it_overrun +=
-				hrtimer_forward(&timr->it.real.timer,
+				hrtimer_forward(timer,
+						timer->base->softirq_time,
 						timr->it.real.interval);
 			ret = HRTIMER_RESTART;
 		}
@@ -621,7 +626,8 @@ common_timer_get(struct k_itimer *timr, 
 	if (timr->it_requeue_pending & REQUEUE_PENDING ||
 	    (timr->it_sigev_notify & ~SIGEV_THREAD_ID) == SIGEV_NONE) {
 		timr->it_overrun +=
-			hrtimer_forward(timer, timr->it.real.interval);
+			hrtimer_forward(timer, timer->base->get_time(),
+					timr->it.real.interval);
 		remaining = hrtimer_get_remaining(timer);
 	}
  calci:

--

