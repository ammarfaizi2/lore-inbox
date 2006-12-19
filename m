Return-Path: <linux-kernel-owner+w=401wt.eu-S933005AbWLSVTP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933005AbWLSVTP (ORCPT <rfc822;w@1wt.eu>);
	Tue, 19 Dec 2006 16:19:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933011AbWLSVTO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 19 Dec 2006 16:19:14 -0500
Received: from mx2.mail.elte.hu ([157.181.151.9]:41888 "EHLO mx2.mail.elte.hu"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933007AbWLSVTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 19 Dec 2006 16:19:12 -0500
Date: Tue, 19 Dec 2006 22:16:29 +0100
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
Subject: [patch] high-res timers: core, do itimer rearming in process context, fix
Message-ID: <20061219211629.GA10586@elte.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
X-ELTE-VirusStatus: clean
X-ELTE-SpamScore: -5.9
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=-5.9 required=5.9 tests=ALL_TRUSTED,BAYES_00 autolearn=no SpamAssassin version=3.0.3
	-3.3 ALL_TRUSTED            Did not pass through any untrusted hosts
	-2.6 BAYES_00               BODY: Bayesian spam probability is 0 to 1%
	[score: 0.0000]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Subject: [patch] high-res timers: core, do itimer rearming in process context, fix
From: Ingo Molnar <mingo@elte.hu>

restart itimers when they are not queued. (a non-queued hrtimer might
be callback-pending - but in that case we already missed the rearming
so the SIGALRM branch has to rearm.)

this fixes a threaded itimers stress-test hang.

Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 include/linux/hrtimer.h |    9 +++++++++
 kernel/hrtimer.c        |    9 ---------
 kernel/signal.c         |    2 +-
 3 files changed, 10 insertions(+), 10 deletions(-)

Index: linux/include/linux/hrtimer.h
===================================================================
--- linux.orig/include/linux/hrtimer.h
+++ linux/include/linux/hrtimer.h
@@ -309,6 +309,15 @@ static inline int hrtimer_active(const s
 	return timer->state != HRTIMER_STATE_INACTIVE;
 }
 
+/*
+ * Helper function to check, whether the timer is on one of the queues
+ */
+static inline int hrtimer_is_queued(struct hrtimer *timer)
+{
+	return timer->state &
+		(HRTIMER_STATE_ENQUEUED | HRTIMER_STATE_PENDING);
+}
+
 /* Forward a hrtimer so it expires after now: */
 extern unsigned long
 hrtimer_forward(struct hrtimer *timer, ktime_t now, ktime_t interval);
Index: linux/kernel/hrtimer.c
===================================================================
--- linux.orig/kernel/hrtimer.c
+++ linux/kernel/hrtimer.c
@@ -152,15 +152,6 @@ static void hrtimer_get_softirq_time(str
 }
 
 /*
- * Helper function to check, whether the timer is on one of the queues
- */
-static inline int hrtimer_is_queued(struct hrtimer *timer)
-{
-	return timer->state &
-		(HRTIMER_STATE_ENQUEUED | HRTIMER_STATE_PENDING);
-}
-
-/*
  * Helper function to check, whether the timer is running the callback
  * function
  */
Index: linux/kernel/signal.c
===================================================================
--- linux.orig/kernel/signal.c
+++ linux/kernel/signal.c
@@ -475,7 +475,7 @@ int dequeue_signal(struct task_struct *t
 		if (unlikely(signr == SIGALRM)) {
 			struct hrtimer *tmr = &tsk->signal->real_timer;
 
-			if (!hrtimer_active(tmr) &&
+			if (!hrtimer_is_queued(tmr) &&
 			    tsk->signal->it_real_incr.tv64 != 0) {
 				hrtimer_forward(tmr, hrtimer_cb_get_time(tmr),
 						tsk->signal->it_real_incr);
