Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313190AbSDOT6W>; Mon, 15 Apr 2002 15:58:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313194AbSDOT6W>; Mon, 15 Apr 2002 15:58:22 -0400
Received: from zero.tech9.net ([209.61.188.187]:61968 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S313190AbSDOT6U>;
	Mon, 15 Apr 2002 15:58:20 -0400
Subject: [PATCH] 2.5: don't miss a preemption
From: Robert Love <rml@tech9.net>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.3 
Date: 15 Apr 2002 15:58:24 -0400
Message-Id: <1018900705.857.26.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Current kernel preemption code opens a small window between the check
for need_resched in schedule and the setting of preempt_count to zero in
preempt_schedule.  While this window is generally short (a few cycles)
the resulting period of non-preemptibility could be as long as the next
timer tick - much longer, in fact, if a lock is obtained in the interim.

This patch checks for need_resched in preempt_schedule after setting
preempt_count back to zero, before returning.  The overhead is
negligible and it is crucial to never miss a preemption opportunity.

Also fixes/clarifies some comments.  Patch is against 2.5.8 ... enjoy,

	Robert Love

diff -urN linux-2.5.8/kernel/sched.c linux/kernel/sched.c
--- linux-2.5.8/kernel/sched.c	Sun Apr 14 15:18:47 2002
+++ linux/kernel/sched.c	Mon Apr 15 15:49:44 2002
@@ -765,8 +765,8 @@
 	spin_lock_irq(&rq->lock);
 
 	/*
-	 * if entering from preempt_schedule, off a kernel preemption,
-	 * go straight to picking the next task.
+	 * if entering off of a kernel preemption go
+	 * straight to picking the next task.
 	 */
 	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
 		goto pick_next_task;
@@ -842,7 +842,9 @@
 
 #ifdef CONFIG_PREEMPT
 /*
- * this is is the entry point to schedule() from in-kernel preemption.
+ * this is is the entry point to schedule() from in-kernel preemption
+ * off of preempt_enable.  Preemptions off return-from-interrupt are
+ * handled directly in that codepath.
  */
 asmlinkage void preempt_schedule(void)
 {
@@ -851,10 +853,15 @@
 	if (unlikely(ti->preempt_count))
 		return;
 
+need_resched:
 	ti->preempt_count = PREEMPT_ACTIVE;
 	schedule();
 	ti->preempt_count = 0;
 	barrier();
+
+	/* we could miss a preemption between schedule() and now */
+	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
+		goto need_resched;
 }
 #endif /* CONFIG_PREEMPT */
 


