Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318128AbSGWPzY>; Tue, 23 Jul 2002 11:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318117AbSGWPyb>; Tue, 23 Jul 2002 11:54:31 -0400
Received: from server72.aitcom.net ([208.234.0.72]:13469 "EHLO test-area.com")
	by vger.kernel.org with ESMTP id <S318119AbSGWPxO>;
	Tue, 23 Jul 2002 11:53:14 -0400
Message-Id: <200207231556.LAA15086@test-area.com>
Content-Type: text/plain; charset=US-ASCII
From: anton wilson <anton.wilson@camotion.com>
To: Ingo Molnar <mingo@elte.hu>
Subject: Re: [PATCH] RML pre-emptive 2.4.19-ac2 with O(1)
Date: Tue, 23 Jul 2002 11:55:42 -0400
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0207231048180.2980-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.44.0207231048180.2980-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Strangely enough I'm getting processes exiting with preemption count of 1 
when I use my patch.
What causes such a problem?

Anton


=================================================================
diff -ru linux-2.4.19-rc2/kernel/sched.c linux/kernel/sched.c
--- linux-2.4.19-rc2/kernel/sched.c	Mon Jul 22 19:02:43 2002
+++ linux/kernel/sched.c	Tue Jul 23 09:44:54 2002
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
@@ -1096,9 +1111,8 @@
 	case TASK_RUNNING:
 		;
 	}
-#if CONFIG_SMP
+
 pick_next_task:
-#endif
 	if (unlikely(!rq->nr_running)) {
 #if CONFIG_SMP
 		load_balance(rq, 1);
@@ -1151,13 +1165,33 @@
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
- * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small 
+ve
+ * wake everything up.  If it's an exclusive wakeup (nr_exclusive == small
  * number) then we wake all the non-exclusive tasks and one exclusive task.
  *
  * There are circumstances in which we can try to wake a task which has 
already
@@ -1923,6 +1957,11 @@
 	double_rq_unlock(idle_rq, rq);
 	set_tsk_need_resched(idle);
 	__restore_flags(flags);
+
+#if CONFIG_PREEMPT
+       /* Set the preempt count _outside_ the spinlocks! */
+       idle->preempt_count = (idle->lock_depth >= 0);
+#endif
 }
 
 #if CONFIG_SMP
@@ -1968,6 +2007,7 @@
 	if (!new_mask)
 		BUG();
 
+	preempt_disable();
 	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
 	/*
@@ -1995,7 +2035,7 @@
 
 	down(&req.sem);
 out:
-	return;
+	preempt_enable();
 }
 
 static __initdata int master_migration_thread;


=====================================================
On Tuesday 23 July 2002 04:49 am, Ingo Molnar wrote:
> On Mon, 22 Jul 2002, anton wilson wrote:
> > I tried to change the current RML preemptive patch for 2.4.19-rc2 to
> > work with the O(1) scheduler patch applied. The only changes I made were
> > in sched.c - Not sure if this is a correct change:
>
> looks good at first sight.
>
> this one:
> > +
> > +       /* Set the preempt count _outside_ the spinlocks! */
> > +       idle->preempt_count = (idle->lock_depth >= 0);
>
> needs to be #if CONFIG_PREEMPT.
>
> 	Ingo
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
