Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317828AbSGVXd6>; Mon, 22 Jul 2002 19:33:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317857AbSGVXd6>; Mon, 22 Jul 2002 19:33:58 -0400
Received: from server72.aitcom.net ([208.234.0.72]:19270 "EHLO test-area.com")
	by vger.kernel.org with ESMTP id <S317828AbSGVXdw>;
	Mon, 22 Jul 2002 19:33:52 -0400
Message-Id: <200207222337.TAA19236@test-area.com>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH] RML pre-emptive 2.4.19-ac2 with O(1)
Date: Mon, 22 Jul 2002 19:36:16 -0400
X-Mailer: KMail [version 1.3.1]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



I tried to change the current RML preemptive patch for 2.4.19-rc2 to work 
with the O(1) scheduler patch applied. The only changes I made were in 
sched.c - Not sure if this is a correct change:

Anton

=============================================================================



diff -ru linux-2.4.19-rc2/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-rc2/kernel/sched.c	Mon Jul 22 19:02:43 2002
+++ linux/kernel/sched.c	Mon Jul 22 18:52:54 2002
@@ -345,11 +345,13 @@
 #if CONFIG_SMP
 	int need_resched;
 
+      preempt_disable();
 	need_resched = p->need_resched;
 	wmb();
 	set_tsk_need_resched(p);
 	if (!need_resched && (p->cpu != smp_processor_id()))
 		smp_send_reschedule(p->cpu);
+ preempt_enable();
 #else
 	set_tsk_need_resched(p);
 #endif
@@ -367,6 +369,7 @@
 	runqueue_t *rq;
 
 repeat:
+	preempt_disable();
 	rq = task_rq(p);
 	if (unlikely(task_running(rq, p))) {
 		cpu_relax();
@@ -375,14 +378,17 @@
 		 * a preemption point - we are busy-waiting
 		 * anyway.
 		 */
+	        preempt_enable();
 		goto repeat;
 	}
 	rq = task_rq_lock(p, &flags);
 	if (unlikely(task_running(rq, p))) {
 		task_rq_unlock(rq, &flags);
+		preempt_enable();
 		goto repeat;
 	}
 	task_rq_unlock(rq, &flags);
+	preempt_enable();
 }
 #endif
 
@@ -519,7 +525,7 @@
 			p->sleep_avg) / (EXIT_WEIGHT + 1);
 }
 
-#if CONFIG_SMP
+#if CONFIG_SMP  || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
 	finish_arch_switch(this_rq(), prev);
@@ -1078,6 +1084,7 @@
 		BUG();
 
 need_resched:
+	preempt_disable();
 	prev = current;
 	rq = this_rq();
 
@@ -1085,6 +1092,14 @@
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 
+#ifdef CONFIG_PREEMPT
+	/*
+	 * entering from preempt_schedule, off a kernel preemption,
+	 * go straight to picking the next task.
+	 */
+	if (unlikely(preempt_get_count() & PREEMPT_ACTIVE))
+		goto pick_next_task;
+#endif
 	switch (prev->state) {
 	case TASK_INTERRUPTIBLE:
 		if (unlikely(signal_pending(prev))) {
@@ -1096,9 +1111,9 @@
 	case TASK_RUNNING:
 		;
 	}
-#if CONFIG_SMP
+
 pick_next_task:
-#endif
+
 	if (unlikely(!rq->nr_running)) {
 #if CONFIG_SMP
 		load_balance(rq, 1);
@@ -1151,10 +1166,30 @@
 		spin_unlock_irq(&rq->lock);
 
 	reacquire_kernel_lock(current);
+
 	if (need_resched())
 		goto need_resched;
+     	preempt_enable_no_resched();
+
+}
+
+#ifdef CONFIG_PREEMPT
+
+ /*
+  * this is is the entry point to schedule() from in-kernel preemption.
+  */
+ asmlinkage void preempt_schedule(void)
+ {
+       do {
+               current->preempt_count += PREEMPT_ACTIVE;
+               schedule();
+               current->preempt_count -= PREEMPT_ACTIVE;
+               barrier();
+       } while (current->need_resched);
 }
 
+#endif /* CONFIG_PREEMPT */
+
 /*
  * The core wakeup function.  Non-exclusive wakeups (nr_exclusive == 0) just
  * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small 
+ve
@@ -1923,6 +1958,9 @@
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	__restore_flags(flags);
+
+       /* Set the preempt count _outside_ the spinlocks! */
+       idle->preempt_count = (idle->lock_depth >= 0);
 }
 
 #if CONFIG_SMP
@@ -1968,6 +2006,7 @@
 	if (!new_mask)
 		BUG();
 
+	preempt_disable();
 	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
 	/*
@@ -1995,7 +2034,7 @@
 
 	down(&req.sem);
 out:
-	return;
+	preempt_enable();
 }
 
 static __initdata int master_migration_thread;
