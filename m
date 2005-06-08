Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262174AbVFHLbC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262174AbVFHLbC (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Jun 2005 07:31:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262176AbVFHLbB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Jun 2005 07:31:01 -0400
Received: from mx2.elte.hu ([157.181.151.9]:7363 "EHLO mx2.elte.hu")
	by vger.kernel.org with ESMTP id S262174AbVFHLYl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Jun 2005 07:24:41 -0400
Date: Wed, 8 Jun 2005 13:21:19 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Daniel Walker <dwalker@mvista.com>
Cc: linux-kernel@vger.kernel.org, sdietrich@mvista.com
Subject: Re: [PATCH] local_irq_disable removal
Message-ID: <20050608112119.GA28703@elte.hu>
References: <1118214519.4759.17.camel@dhcp153.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118214519.4759.17.camel@dhcp153.mvista.com>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamVersion: MailScanner 4.31.6-itk1 (ELTE 1.2) SpamAssassin 2.63 ClamAV 0.73
X-ELTE-VirusStatus: clean
X-ELTE-SpamCheck: no
X-ELTE-SpamCheck-Details: score=-4.9, required 5.9,
	BAYES_00 -4.90
X-ELTE-SpamLevel: 
X-ELTE-SpamScore: -4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Daniel Walker <dwalker@mvista.com> wrote:

> Implementation:
> 
>         I've written code that removes 70% all interrupt disable 
> sections in the current real time kernel. These interrupt disable 
> sections are replaced with a special preempt disable section. Since an 
> interrupt disable section implicitly disables preemption, there should 
> be no increase in preemption latency due to this change.

great. I've applied a cleaned up / fixed version of this and have 
released it as part of the -48-00 patch, which is available at the usual 
place:

    http://redhat.com/~mingo/realtime-preempt/

i've attached below the delta relative to your patch. The changes are:

 - fixed a soft-local_irq_restore() bug: it didnt re-disable the IRQ 
   flag if the flags passed in had it set.

 - fixed SMP support - both the scheduler and the lowlevel SMP code was 
   not fully converted to the soft flag assumptions. The PREEMPT_RT 
   kernel now boots fine on a 2-way/4-way x86 box.

 - fixed the APIC code

 - fixed irq-latency tracing and other tracing assumptions

 - fixed DEBUG_RT_DEADLOCK_DETECT - we checked for the wrong irq flags

 - added debug code to find IRQ flag mismatches: mixing the CPU and soft 
   flags is lethal, but detectable.

 - simplified the code which should thus also be faster: introduced the
   mask_preempt_count/unmask_preempt_count primitives and made the 
   soft-flag code use it.

 - cleaned up the interdependencies of the soft-flag functions - they 
   now dont call each other anymore, they all use inlined code for 
   maximum performance.

 - made the soft IRQ flag an unconditional feature of PREEMPT_RT: once 
   it works properly there's no reason to ever disable it under 
   PREEMPT_RT.

 - renamed hard_ to raw_, to bring it in line with other constructs in 
   PREEMPT_RT.

 - cleaned up the system.h impact by creating linux/rt_irq.h. Made the 
   naming consistent all across.

 - cleaned up the preempt.h impact and updated the comments.

 - fixed smp_processor_id() debugging: we have to check for the CPU irq 
   flag too.

	Ingo

--- kernel/rt.c.orig
+++ kernel/rt.c
@@ -80,7 +80,7 @@ void deadlock_trace_off(void)
 
 #define trace_lock_irq(lock)			\
 	do {					\
-		local_irq_disable();		\
+		raw_local_irq_disable();	\
 		if (trace_on)			\
 			spin_lock(lock);	\
 	} while (0)
@@ -95,13 +95,13 @@ void deadlock_trace_off(void)
 	do {					\
 		if (trace_on)			\
 			spin_unlock(lock);	\
-		local_irq_enable();		\
+		raw_local_irq_enable();		\
 		preempt_check_resched();	\
 	} while (0)
 
 #define trace_lock_irqsave(lock, flags)		\
 	do {					\
-		local_irq_save(flags);		\
+		raw_local_irq_save(flags);	\
 		if (trace_on)			\
 			spin_lock(lock);	\
 	} while (0)
@@ -110,7 +110,7 @@ void deadlock_trace_off(void)
 	do {					\
 		if (trace_on)			\
 			spin_unlock(lock);	\
-		local_irq_restore(flags);	\
+		raw_local_irq_restore(flags);	\
 		preempt_check_resched();	\
 	} while (0)
 
@@ -137,9 +137,9 @@ do {						\
 	}					\
 } while (0)
 
-# define trace_local_irq_disable()		local_irq_disable()
-# define trace_local_irq_enable()		local_irq_enable()
-# define trace_local_irq_restore(flags)		local_irq_restore(flags)
+# define trace_local_irq_disable()		raw_local_irq_disable()
+# define trace_local_irq_enable()		raw_local_irq_enable()
+# define trace_local_irq_restore(flags)		raw_local_irq_restore(flags)
 # define TRACE_BUG_ON(c)			do { if (c) TRACE_BUG(); } while (0)
 #else
 # define trace_lock_irq(lock)			preempt_disable()
@@ -928,7 +928,7 @@ static void __sched __down(struct rt_mut
 	struct rt_mutex_waiter waiter;
 
 	trace_lock_irqsave(&trace_lock, flags);
-	TRACE_BUG_ON(!irqs_disabled());
+	TRACE_BUG_ON(!raw_irqs_disabled());
 	spin_lock(&lock->wait_lock);
 
 	init_lists(lock);
@@ -951,7 +951,7 @@ static void __sched __down(struct rt_mut
 	plist_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
-	TRACE_BUG_ON(!irqs_disabled());
+	TRACE_BUG_ON(!raw_irqs_disabled());
 	/* we don't need to touch the lock struct anymore */
 	spin_unlock(&lock->wait_lock);
 	trace_unlock_irqrestore(&trace_lock, flags);
@@ -1025,7 +1025,7 @@ static void __sched __down_mutex(struct 
 	int got_wakeup = 0;
 
 	trace_lock_irqsave(&trace_lock, flags);
-	TRACE_BUG_ON(!irqs_disabled());
+	TRACE_BUG_ON(!raw_irqs_disabled());
 	__raw_spin_lock(&lock->wait_lock);
 
 	init_lists(lock);
@@ -1046,7 +1046,7 @@ static void __sched __down_mutex(struct 
 	plist_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
-	TRACE_BUG_ON(!irqs_disabled());
+	TRACE_BUG_ON(!raw_irqs_disabled());
 	/*
 	 * Here we save whatever state the task was in originally,
 	 * we'll restore it at the end of the function and we'll
@@ -1165,7 +1165,7 @@ static int __sched __down_interruptible(
 	int ret;
 
 	trace_lock_irqsave(&trace_lock, flags);
-	TRACE_BUG_ON(!irqs_disabled());
+	TRACE_BUG_ON(!raw_irqs_disabled());
 	spin_lock(&lock->wait_lock);
 
 	init_lists(lock);
@@ -1188,7 +1188,7 @@ static int __sched __down_interruptible(
 	plist_init(&waiter.list, task->prio);
 	task_blocks_on_lock(&waiter, task, lock, eip);
 
-	TRACE_BUG_ON(!irqs_disabled());
+	TRACE_BUG_ON(!raw_irqs_disabled());
 	/* we don't need to touch the lock struct anymore */
 	spin_unlock(&lock->wait_lock);
 	trace_unlock_irqrestore(&trace_lock, flags);
@@ -1258,7 +1258,7 @@ static int __down_trylock(struct rt_mute
 	int ret = 0;
 
 	trace_lock_irqsave(&trace_lock, flags);
-	TRACE_BUG_ON(!irqs_disabled());
+	TRACE_BUG_ON(!raw_irqs_disabled());
 	spin_lock(&lock->wait_lock);
 
 	init_lists(lock);
@@ -1331,7 +1331,7 @@ static void __up_mutex(struct rt_mutex *
 	TRACE_WARN_ON(save_state != lock->save_state);
 
 	trace_lock_irqsave(&trace_lock, flags);
-	TRACE_BUG_ON(!irqs_disabled());
+	TRACE_BUG_ON(!raw_irqs_disabled());
 	__raw_spin_lock(&lock->wait_lock);
 	TRACE_BUG_ON(!lock->wait_list.dp_node.prev && !lock->wait_list.dp_node.next);
 
@@ -1392,7 +1392,7 @@ static void __up_mutex(struct rt_mutex *
 	 * reschedule then do it here without enabling interrupts
 	 * again (and lengthening latency):
 	 */
-	if (need_resched() && !irqs_disabled_flags(flags) && !preempt_count())
+	if (need_resched() && !raw_irqs_disabled_flags(flags) && !preempt_count())
 		preempt_schedule_irq();
 	trace_local_irq_restore(flags);
 #else
@@ -1997,3 +1997,83 @@ int _write_can_lock(rwlock_t *rwlock)
 }
 EXPORT_SYMBOL(_write_can_lock);
 
+/*
+ * Soft irq-flag support:
+ */
+
+#ifdef CONFIG_DEBUG_PREEMPT
+static void check_soft_flags(unsigned long flags)
+{
+	if (flags & ~IRQSOFF_MASK) {
+		static int print_once = 1;
+		if (print_once) {
+			print_once = 0;
+			printk("BUG: bad soft irq-flag value %08lx, %s/%d!\n",
+				flags, current->comm, current->pid);
+			dump_stack();
+		}
+	}
+}
+#else
+static inline void check_soft_flags(unsigned long flags)
+{
+}
+#endif
+
+void local_irq_enable_noresched(void)
+{
+	unmask_preempt_count(IRQSOFF_MASK);
+}
+EXPORT_SYMBOL(local_irq_enable_noresched);
+
+void local_irq_enable(void)
+{
+	unmask_preempt_count(IRQSOFF_MASK);
+	preempt_check_resched();
+}
+EXPORT_SYMBOL(local_irq_enable);
+
+void local_irq_disable(void)
+{
+	mask_preempt_count(IRQSOFF_MASK);
+}
+EXPORT_SYMBOL(local_irq_disable);
+
+int irqs_disabled_flags(unsigned long flags)
+{
+	check_soft_flags(flags);
+
+	return (flags & IRQSOFF_MASK);
+}
+EXPORT_SYMBOL(irqs_disabled_flags);
+
+void __local_save_flags(unsigned long *flags)
+{
+	*flags = irqs_off();
+}
+EXPORT_SYMBOL(__local_save_flags);
+
+void __local_irq_save(unsigned long *flags)
+{
+	*flags = irqs_off();
+	mask_preempt_count(IRQSOFF_MASK);
+}
+EXPORT_SYMBOL(__local_irq_save);
+
+void local_irq_restore(unsigned long flags)
+{
+	check_soft_flags(flags);
+	if (flags)
+		mask_preempt_count(IRQSOFF_MASK);
+	else {
+		unmask_preempt_count(IRQSOFF_MASK);
+		preempt_check_resched();
+	}
+}
+EXPORT_SYMBOL(local_irq_restore);
+
+int irqs_disabled(void)
+{
+	return irqs_off();
+}
+EXPORT_SYMBOL(irqs_disabled);
--- kernel/exit.c.orig
+++ kernel/exit.c
@@ -844,7 +844,7 @@ fastcall NORET_TYPE void do_exit(long co
 	check_no_held_locks(tsk);
 	/* PF_DEAD causes final put_task_struct after we schedule. */
 again:
-	hard_local_irq_disable();
+	raw_local_irq_disable();
 	tsk->flags |= PF_DEAD;
 	__schedule();
 	printk(KERN_ERR "BUG: dead task %s:%d back from the grave!\n",
--- kernel/printk.c.orig
+++ kernel/printk.c
@@ -529,8 +529,7 @@ asmlinkage int vprintk(const char *fmt, 
 		zap_locks();
 
 	/* This stops the holder of console_sem just where we want him */
-	local_irq_save(flags);
-	spin_lock(&logbuf_lock);
+	spin_lock_irqsave(&logbuf_lock, flags);
 
 	/* Emit the output into the temporary buffer */
 	printed_len = vscnprintf(printk_buf, sizeof(printk_buf), fmt, args);
@@ -600,18 +599,16 @@ asmlinkage int vprintk(const char *fmt, 
 		 * CPU until it is officially up.  We shouldn't be calling into
 		 * random console drivers on a CPU which doesn't exist yet..
 		 */
-		spin_unlock(&logbuf_lock);
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&logbuf_lock, flags);
 		goto out;
 	}
-	if (!in_interrupt() && !down_trylock(&console_sem)) {
+	if (!down_trylock(&console_sem)) {
 		console_locked = 1;
 		/*
 		 * We own the drivers.  We can drop the spinlock and let
 		 * release_console_sem() print the text
 		 */
-		spin_unlock(&logbuf_lock);
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&logbuf_lock, flags);
 		console_may_schedule = 0;
 		release_console_sem();
 	} else {
@@ -620,8 +617,7 @@ asmlinkage int vprintk(const char *fmt, 
 		 * allows the semaphore holder to proceed and to call the
 		 * console drivers with the output which we just produced.
 		 */
-		spin_unlock(&logbuf_lock);
-		local_irq_restore(flags);
+		spin_unlock_irqrestore(&logbuf_lock, flags);
 	}
 out:
 	return printed_len;
@@ -754,7 +750,7 @@ void release_console_sem(void)
 	 * case only.
 	 */
 #ifdef CONFIG_PREEMPT_RT
-	if (!in_atomic() && !irqs_disabled() && !hard_irqs_disabled())
+	if (!in_atomic() && !irqs_disabled() && !raw_irqs_disabled())
 #endif
 	if (wake_klogd && !oops_in_progress && waitqueue_active(&log_wait))
 		wake_up_interruptible(&log_wait);
--- kernel/sched.c.orig
+++ kernel/sched.c
@@ -307,12 +307,12 @@ static inline runqueue_t *task_rq_lock(t
 	struct runqueue *rq;
 
 repeat_lock_task:
-	hard_local_irq_save(*flags);
+	raw_local_irq_save(*flags);
 	rq = task_rq(p);
 	spin_lock(&rq->lock);
 	if (unlikely(rq != task_rq(p))) {
 		spin_unlock(&rq->lock);
-		hard_local_irq_restore(*flags);
+		raw_local_irq_restore(*flags);
 		goto repeat_lock_task;
 	}
 	return rq;
@@ -322,7 +322,7 @@ static inline void task_rq_unlock(runque
 	__releases(rq->lock)
 {
 	spin_unlock(&rq->lock);
-	hard_local_irq_restore(*flags);
+	raw_local_irq_restore(*flags);
 }
 
 #ifdef CONFIG_SCHEDSTATS
@@ -428,7 +428,7 @@ static inline runqueue_t *this_rq_lock(v
 {
 	runqueue_t *rq;
 
-	hard_local_irq_disable();
+	raw_local_irq_disable();
 	rq = this_rq();
 	spin_lock(&rq->lock);
 
@@ -1223,10 +1223,10 @@ out:
 	 */
 	if (_need_resched() && !irqs_disabled_flags(flags) && !preempt_count())
 		preempt_schedule_irq();
-	hard_local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 #else
 	spin_unlock(&rq->lock);
-	hard_local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 #endif
 	/* no need to check for preempt here - we just handled it */
 
@@ -1300,7 +1300,7 @@ void fastcall sched_fork(task_t *p)
 	 * total amount of pending timeslices in the system doesn't change,
 	 * resulting in more scheduling fairness.
 	 */
-	hard_local_irq_disable();
+	raw_local_irq_disable();
 	p->time_slice = (current->time_slice + 1) >> 1;
 	/*
 	 * The remainder of the first timeslice might be recovered by
@@ -1318,10 +1318,10 @@ void fastcall sched_fork(task_t *p)
 		current->time_slice = 1;
 		preempt_disable();
 		scheduler_tick();
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 		preempt_enable();
 	} else
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 }
 
 /*
@@ -1507,7 +1507,7 @@ asmlinkage void schedule_tail(task_t *pr
 	preempt_disable(); // TODO: move this to fork setup
 	finish_task_switch(prev);
 	__preempt_enable_no_resched();
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 	preempt_check_resched();
 
 	if (current->set_child_tid)
@@ -2522,10 +2522,11 @@ unsigned long long current_sched_time(co
 {
 	unsigned long long ns;
 	unsigned long flags;
-	local_irq_save(flags);
+
+	raw_local_irq_save(flags);
 	ns = max(tsk->timestamp, task_rq(tsk)->timestamp_last_tick);
 	ns = tsk->sched_time + (sched_clock() - ns);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 	return ns;
 }
 
@@ -2634,7 +2635,7 @@ void scheduler_tick(void)
 	task_t *p = current;
 	unsigned long long now = sched_clock();
 
-	BUG_ON(!hard_irqs_disabled());
+	BUG_ON(!raw_irqs_disabled());
 
 	update_cpu_clock(p, rq, now);
 
@@ -2949,7 +2950,7 @@ void __sched __schedule(void)
 	run_time /= (CURRENT_BONUS(prev) ? : 1);
 
 	cpu = smp_processor_id();
-	hard_local_irq_disable();
+	raw_local_irq_disable();
 	spin_lock(&rq->lock);
 
 	switch_count = &prev->nvcsw; // TODO: temporary - to see it in vmstat
@@ -3091,7 +3092,7 @@ asmlinkage void __sched schedule(void)
 	/*
 	 * Test if we have interrupts disabled.
 	 */
-	if (unlikely(irqs_disabled() || hard_irqs_disabled())) {
+	if (unlikely(irqs_disabled() || raw_irqs_disabled())) {
 		stop_trace();
 		printk(KERN_ERR "BUG: scheduling with irqs disabled: "
 			"%s/0x%08x/%d\n",
@@ -3109,7 +3110,7 @@ asmlinkage void __sched schedule(void)
 	do {
 		__schedule();
 	} while (unlikely(test_thread_flag(TIF_NEED_RESCHED)));
-	hard_local_irq_enable(); // TODO: do sti; ret
+	raw_local_irq_enable(); // TODO: do sti; ret
 }
 
 EXPORT_SYMBOL(schedule);
@@ -3179,11 +3180,11 @@ asmlinkage void __sched preempt_schedule
 	 * If there is a non-zero preempt_count or interrupts are disabled,
 	 * we do not want to preempt the current task.  Just return..
 	 */
-	if (unlikely(ti->preempt_count || irqs_disabled() || hard_irqs_disabled()))
+	if (unlikely(ti->preempt_count || irqs_disabled() || raw_irqs_disabled()))
 		return;
 
 need_resched:
-	hard_local_irq_disable();
+	raw_local_irq_disable();
 	add_preempt_count(PREEMPT_ACTIVE);
 	/*
 	 * We keep the big kernel semaphore locked, but we
@@ -3202,7 +3203,7 @@ need_resched:
 	barrier();
 	if (unlikely(test_thread_flag(TIF_NEED_RESCHED)))
 		goto need_resched;
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 }
 
 EXPORT_SYMBOL(preempt_schedule);
@@ -3230,9 +3231,7 @@ asmlinkage void __sched preempt_schedule
 		return;
 
 need_resched:
-#ifdef CONFIG_RT_IRQ_DISABLE
-	hard_local_irq_disable();
-#endif
+	raw_local_irq_disable();
 	add_preempt_count(PREEMPT_ACTIVE);
 	/*
 	 * We keep the big kernel semaphore locked, but we
@@ -3245,10 +3244,8 @@ need_resched:
 #endif
 	__schedule();
 
-	_hard_local_irq_disable();
-#ifdef CONFIG_RT_IRQ_DISABLE
+	raw_local_irq_disable();
 	local_irq_enable_noresched();
-#endif
 
 #ifdef CONFIG_PREEMPT_BKL
 	task->lock_depth = saved_lock_depth;
@@ -4182,7 +4179,7 @@ asmlinkage long sys_sched_yield(void)
 	__preempt_enable_no_resched();
 
 	__schedule();
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 	preempt_check_resched();
 
 	return 0;
@@ -4195,11 +4192,11 @@ static void __cond_resched(void)
 	if (preempt_count() & PREEMPT_ACTIVE)
 		return;
 	do {
-		hard_local_irq_disable();
+		raw_local_irq_disable();
 		add_preempt_count(PREEMPT_ACTIVE);
 		__schedule();
 	} while (need_resched());
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 }
 
 int __sched cond_resched(void)
@@ -4609,10 +4606,12 @@ void __devinit init_idle(task_t *idle, i
 	idle->cpus_allowed = cpumask_of_cpu(cpu);
 	set_task_cpu(idle, cpu);
 
-	spin_lock_irqsave(&rq->lock, flags);
+	raw_local_irq_save(flags);
+	spin_lock(&rq->lock);
 	rq->curr = rq->idle = idle;
 	set_tsk_need_resched(idle);
-	spin_unlock_irqrestore(&rq->lock, flags);
+	spin_unlock(&rq->lock);
+	raw_local_irq_restore(flags);
 
 	/* Set the preempt count _outside_ the spinlocks! */
 #if defined(CONFIG_PREEMPT) && \
@@ -4766,10 +4765,12 @@ static int migration_thread(void * data)
 		if (current->flags & PF_FREEZE)
 			refrigerator(PF_FREEZE);
 
-		spin_lock_irq(&rq->lock);
+		raw_local_irq_disable();
+		spin_lock(&rq->lock);
 
 		if (cpu_is_offline(cpu)) {
-			spin_unlock_irq(&rq->lock);
+			spin_unlock(&rq->lock);
+			raw_local_irq_enable();
 			goto wait_to_die;
 		}
 
@@ -4781,7 +4782,8 @@ static int migration_thread(void * data)
 		head = &rq->migration_queue;
 
 		if (list_empty(head)) {
-			spin_unlock_irq(&rq->lock);
+			spin_unlock(&rq->lock);
+			raw_local_irq_enable();
 			schedule();
 			set_current_state(TASK_INTERRUPTIBLE);
 			continue;
@@ -4792,12 +4794,14 @@ static int migration_thread(void * data)
 		if (req->type == REQ_MOVE_TASK) {
 			spin_unlock(&rq->lock);
 			__migrate_task(req->task, cpu, req->dest_cpu);
-			local_irq_enable();
+			raw_local_irq_enable();
 		} else if (req->type == REQ_SET_DOMAIN) {
 			rq->sd = req->sd;
-			spin_unlock_irq(&rq->lock);
+			spin_unlock(&rq->lock);
+			raw_local_irq_enable();
 		} else {
-			spin_unlock_irq(&rq->lock);
+			spin_unlock(&rq->lock);
+			raw_local_irq_enable();
 			WARN_ON(1);
 		}
 
@@ -4863,12 +4867,12 @@ static void migrate_nr_uninterruptible(r
 	runqueue_t *rq_dest = cpu_rq(any_online_cpu(CPU_MASK_ALL));
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	double_rq_lock(rq_src, rq_dest);
 	rq_dest->nr_uninterruptible += rq_src->nr_uninterruptible;
 	rq_src->nr_uninterruptible = 0;
 	double_rq_unlock(rq_src, rq_dest);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 /* Run through task list and migrate tasks from the dead cpu. */
@@ -4906,13 +4910,15 @@ void sched_idle_next(void)
 	/* Strictly not necessary since rest of the CPUs are stopped by now
 	 * and interrupts disabled on current cpu.
 	 */
-	spin_lock_irqsave(&rq->lock, flags);
+	raw_local_irq_save(flags);
+	spin_lock(&rq->lock);
 
 	__setscheduler(p, SCHED_FIFO, MAX_RT_PRIO-1);
 	/* Add idle task to _front_ of it's priority queue */
 	__activate_idle_task(p, rq);
 
-	spin_unlock_irqrestore(&rq->lock, flags);
+	spin_unlock(&rq->lock);
+	raw_local_irq_restore(flags);
 }
 
 /* Ensures that the idle task is using init_mm right before its cpu goes
@@ -4946,9 +4952,11 @@ static void migrate_dead(unsigned int de
 	 * that's OK.  No task can be added to this CPU, so iteration is
 	 * fine.
 	 */
-	spin_unlock_irq(&rq->lock);
+	raw_local_irq_disable();
+	spin_lock(&rq->lock);
 	move_task_off_dead_cpu(dead_cpu, tsk);
-	spin_lock_irq(&rq->lock);
+	spin_unlock(&rq->lock);
+	raw_local_irq_enable();
 
 	put_task_struct(tsk);
 }
@@ -5025,7 +5033,8 @@ static int migration_call(struct notifie
 		/* No need to migrate the tasks: it was best-effort if
 		 * they didn't do lock_cpu_hotplug().  Just wake up
 		 * the requestors. */
-		spin_lock_irq(&rq->lock);
+		raw_local_irq_disable();
+		spin_lock(&rq->lock);
 		while (!list_empty(&rq->migration_queue)) {
 			migration_req_t *req;
 			req = list_entry(rq->migration_queue.next,
@@ -5034,7 +5043,8 @@ static int migration_call(struct notifie
 			list_del_init(&req->list);
 			complete(&req->done);
 		}
-		spin_unlock_irq(&rq->lock);
+		spin_unlock(&rq->lock);
+		raw_local_irq_enable();
 		break;
 #endif
 	}
@@ -5162,7 +5172,8 @@ void __devinit cpu_attach_domain(struct 
 
 	sched_domain_debug(sd, cpu);
 
-	spin_lock_irqsave(&rq->lock, flags);
+	raw_local_irq_save(flags);
+	spin_lock(&rq->lock);
 
 	if (cpu == smp_processor_id() || !cpu_online(cpu)) {
 		rq->sd = sd;
@@ -5174,7 +5185,8 @@ void __devinit cpu_attach_domain(struct 
 		local = 0;
 	}
 
-	spin_unlock_irqrestore(&rq->lock, flags);
+	spin_unlock(&rq->lock);
+	raw_local_irq_restore(flags);
 
 	if (!local) {
 		wake_up_process(rq->migration_thread);
--- kernel/irq/manage.c.orig
+++ kernel/irq/manage.c
@@ -60,14 +60,14 @@ void disable_irq_nosync(unsigned int irq
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 	
-	_hard_local_irq_save(flags);
+	__raw_local_irq_save(flags);
 	spin_lock(&desc->lock);
 	if (!desc->depth++) {
 		desc->status |= IRQ_DISABLED;
 		desc->handler->disable(irq);
 	}
 	spin_unlock(&desc->lock);
-	_hard_local_irq_restore(flags);
+	__raw_local_irq_restore(flags);
 }
 
 EXPORT_SYMBOL(disable_irq_nosync);
@@ -110,7 +110,7 @@ void enable_irq(unsigned int irq)
 	irq_desc_t *desc = irq_desc + irq;
 	unsigned long flags;
 
-	_hard_local_irq_save(flags);
+	__raw_local_irq_save(flags);
 	spin_lock(&desc->lock);
 	switch (desc->depth) {
 	case 0:
@@ -131,7 +131,7 @@ void enable_irq(unsigned int irq)
 		desc->depth--;
 	}
 	spin_unlock(&desc->lock);
-	_hard_local_irq_restore(flags);
+	__raw_local_irq_restore(flags);
 }
 
 EXPORT_SYMBOL(enable_irq);
@@ -207,7 +207,7 @@ int setup_irq(unsigned int irq, struct i
 	/*
 	 * The following block of code has to be executed atomically
 	 */
-	_hard_local_irq_save(flags);
+	__raw_local_irq_save(flags);
 	spin_lock(&desc->lock);
 	p = &desc->action;
 	if ((old = *p) != NULL) {
@@ -242,7 +242,7 @@ int setup_irq(unsigned int irq, struct i
 			desc->handler->enable(irq);
 	}
 	spin_unlock(&desc->lock);
-	_hard_local_irq_restore(flags);
+	__raw_local_irq_restore(flags);
 
 	new->irq = irq;
 	register_irq_proc(irq);
@@ -276,7 +276,7 @@ void free_irq(unsigned int irq, void *de
 		return;
 
 	desc = irq_desc + irq;
-	_hard_local_irq_save(flags);
+	__raw_local_irq_save(flags);
 	spin_lock(&desc->lock);
 	p = &desc->action;
 	for (;;) {
@@ -300,7 +300,7 @@ void free_irq(unsigned int irq, void *de
 			}
 			recalculate_desc_flags(desc);
 			spin_unlock(&desc->lock);
-			_hard_local_irq_restore(flags);
+			__raw_local_irq_restore(flags);
 			unregister_handler_proc(irq, action);
 
 			/* Make sure it's not being used on another CPU */
@@ -310,7 +310,7 @@ void free_irq(unsigned int irq, void *de
 		}
 		printk(KERN_ERR "Trying to free free IRQ%d\n",irq);
 		spin_unlock(&desc->lock);
-		_hard_local_irq_restore(flags);
+		__raw_local_irq_restore(flags);
 		return;
 	}
 }
@@ -418,7 +418,7 @@ static void do_hardirq(struct irq_desc *
 	struct irqaction * action;
 	unsigned int irq = desc - irq_desc;
 
-	hard_local_irq_disable();
+	raw_local_irq_disable();
 
 	if (desc->status & IRQ_INPROGRESS) {
 		action = desc->action;
@@ -429,9 +429,9 @@ static void do_hardirq(struct irq_desc *
 			if (action) {
 				spin_unlock(&desc->lock);
 				action_ret = handle_IRQ_event(irq, NULL,action);
-				hard_local_irq_enable();
+				raw_local_irq_enable();
 				cond_resched_all();
-				hard_local_irq_disable();
+				raw_local_irq_disable();
 				spin_lock(&desc->lock);
 			}
 			if (!noirqdebug)
@@ -448,7 +448,7 @@ static void do_hardirq(struct irq_desc *
 		desc->handler->end(irq);
 		spin_unlock(&desc->lock);
 	}
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 	if (waitqueue_active(&desc->wait_for_handler))
 		wake_up(&desc->wait_for_handler);
 }
@@ -484,7 +484,7 @@ static int do_irqd(void * __desc)
 		do_hardirq(desc);
 		cond_resched_all();
 		__do_softirq();
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 #ifdef CONFIG_SMP
 		/*
 		 * Did IRQ affinities change?
--- kernel/irq/handle.c.orig
+++ kernel/irq/handle.c
@@ -113,7 +113,7 @@ fastcall int handle_IRQ_event(unsigned i
 	 * IRQ handlers:
 	 */
 	if (!hardirq_count() || !(action->flags & SA_INTERRUPT))
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 
 	do {
 		unsigned int preempt_count = preempt_count();
@@ -133,10 +133,10 @@ fastcall int handle_IRQ_event(unsigned i
 	} while (action);
 
 	if (status & SA_SAMPLE_RANDOM) {
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 		add_interrupt_randomness(irq);
 	}
-	hard_local_irq_disable();
+	raw_local_irq_disable();
 
 	return retval;
 }
@@ -156,9 +156,12 @@ fastcall notrace unsigned int __do_IRQ(u
 	irq_desc_t *desc = irq_desc + irq;
 	struct irqaction * action;
 	unsigned int status;
-
-#ifdef CONFIG_RT_IRQ_DISABLE
+#ifdef CONFIG_PREEMPT_RT
 	unsigned long flags;
+
+	/*
+	 * Disable the soft-irq-flag:
+	 */
 	local_irq_save(flags);
 #endif
 	kstat_this_cpu.irqs[irq]++;
@@ -245,7 +248,7 @@ out:
 out_no_end:
 	spin_unlock(&desc->lock);
 
-#ifdef CONFIG_RT_IRQ_DISABLE
+#ifdef CONFIG_PREEMPT_RT
 	local_irq_restore(flags);
 #endif
 	return 1;
--- kernel/irq/autoprobe.c.orig
+++ kernel/irq/autoprobe.c
@@ -39,12 +39,12 @@ unsigned long probe_irq_on(void)
 	for (i = NR_IRQS-1; i > 0; i--) {
 		desc = irq_desc + i;
 
-		hard_local_irq_disable();
+		raw_local_irq_disable();
 		spin_lock(&desc->lock);
 		if (!irq_desc[i].action)
 			irq_desc[i].handler->startup(i);
 		spin_unlock(&desc->lock);
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 	}
 
 	/*
@@ -60,7 +60,7 @@ unsigned long probe_irq_on(void)
 	for (i = NR_IRQS-1; i > 0; i--) {
 		desc = irq_desc + i;
 
-		hard_local_irq_disable();
+		raw_local_irq_disable();
 		spin_lock(&desc->lock);
 		if (!desc->action) {
 			desc->status |= IRQ_AUTODETECT | IRQ_WAITING;
@@ -68,7 +68,7 @@ unsigned long probe_irq_on(void)
 				desc->status |= IRQ_PENDING;
 		}
 		spin_unlock(&desc->lock);
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 	}
 
 	/*
@@ -84,7 +84,7 @@ unsigned long probe_irq_on(void)
 		irq_desc_t *desc = irq_desc + i;
 		unsigned int status;
 
-		hard_local_irq_disable();
+		raw_local_irq_disable();
 		spin_lock(&desc->lock);
 		status = desc->status;
 
@@ -98,7 +98,7 @@ unsigned long probe_irq_on(void)
 					val |= 1 << i;
 		}
 		spin_unlock(&desc->lock);
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 	}
 
 	return val;
@@ -128,7 +128,7 @@ unsigned int probe_irq_mask(unsigned lon
 		irq_desc_t *desc = irq_desc + i;
 		unsigned int status;
 
-		hard_local_irq_disable();
+		raw_local_irq_disable();
 		spin_lock(&desc->lock);
 		status = desc->status;
 
@@ -140,7 +140,7 @@ unsigned int probe_irq_mask(unsigned lon
 			desc->handler->shutdown(i);
 		}
 		spin_unlock(&desc->lock);
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 	}
 	up(&probe_sem);
 
@@ -173,7 +173,7 @@ int probe_irq_off(unsigned long val)
 		irq_desc_t *desc = irq_desc + i;
 		unsigned int status;
 
-		hard_local_irq_disable();
+		raw_local_irq_disable();
 		spin_lock(&desc->lock);
 		status = desc->status;
 
@@ -187,7 +187,7 @@ int probe_irq_off(unsigned long val)
 			desc->handler->shutdown(i);
 		}
 		spin_unlock(&desc->lock);
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 	}
 	up(&probe_sem);
 
--- kernel/Makefile.orig
+++ kernel/Makefile
@@ -10,7 +10,6 @@ obj-y     = sched.o fork.o exec_domain.o
 	    kthread.o wait.o kfifo.o sys_ni.o posix-cpu-timers.o
 
 obj-$(CONFIG_PREEMPT_RT) += rt.o
-obj-$(CONFIG_RT_IRQ_DISABLE) += irqs-off.o
 
 obj-$(CONFIG_DEBUG_PREEMPT) += latency.o
 obj-$(CONFIG_LATENCY_TIMING) += latency.o
--- kernel/irqs-off.c.orig
+++ kernel/irqs-off.c
@@ -1,99 +0,0 @@
-/*
- * kernel/irqs-off.c 
- *
- * IRQ soft state managment 
- *
- * Author: Daniel Walker <dwalker@mvista.com>
- *
- * 2005 (c) MontaVista Software, Inc. This file is licensed under
- * the terms of the GNU General Public License version 2. This program
- * is licensed "as is" without any warranty of any kind, whether express
- * or implied.
- */
-
-#include <linux/hardirq.h>
-#include <linux/preempt.h>
-#include <linux/kallsyms.h>
-
-#include <linux/module.h>
-#include <asm/system.h>
-
-static int irq_trace;
-
-void irq_trace_enable(void) { irq_trace = 1; }
-void irq_trace_disable(void) { irq_trace = 0; }
-
-unsigned int ___local_save_flags()
-{
-	return irqs_off();
-}                                                                                                                        
-EXPORT_SYMBOL(___local_save_flags);
-
-void local_irq_enable_noresched(void)
-{
-	if (irq_trace) {
-		current->last_irq_enable[0] = (unsigned long)__builtin_return_address(0);
-		//current->last_irq_enable[1] = (unsigned long)__builtin_return_address(1);
-	}
-
-	if (irqs_off()) sub_preempt_count(IRQSOFF_OFFSET);
-}
-EXPORT_SYMBOL(local_irq_enable_noresched);
-
-void local_irq_enable(void)
-{
-	if (irq_trace) {
-		current->last_irq_enable[0] = (unsigned long)__builtin_return_address(0);
-		//current->last_irq_enable[1] = (unsigned long)__builtin_return_address(1);
-	}
-	if (irqs_off()) sub_preempt_count(IRQSOFF_OFFSET);
-
-	//local_irq_enable_noresched();
-	preempt_check_resched(); 
-}
-EXPORT_SYMBOL(local_irq_enable);
-
-void local_irq_disable(void) 
-{
-	if (irq_trace) {
-		current->last_irq_disable[0] = (unsigned long)__builtin_return_address(0);
-		//current->last_irq_disable[1] = (unsigned long)__builtin_return_address(1);
-	}
-	if (!irqs_off()) add_preempt_count(IRQSOFF_OFFSET);
-}
-EXPORT_SYMBOL(local_irq_disable);
-
-unsigned long irqs_disabled_flags(unsigned long flags)
-{
-	return (flags & IRQSOFF_MASK);	
-}
-EXPORT_SYMBOL(irqs_disabled_flags);
-
-void local_irq_restore(unsigned long flags)
-{
-	if (!irqs_disabled_flags(flags)) local_irq_enable();
-}
-EXPORT_SYMBOL(local_irq_restore);
-
-unsigned long irqs_disabled(void)
-{
-	return irqs_off();
-}
-EXPORT_SYMBOL(irqs_disabled);
-
-void print_irq_traces(struct task_struct *task)
-{
-	printk("Soft state access: (%s)\n", (hard_irqs_disabled()) ? "Hard disabled" : "Not disabled");
-	printk(".. [<%08lx>] .... ", task->last_irq_disable[0]);
-	print_symbol("%s\n", task->last_irq_disable[0]);
-	printk(".....[<%08lx>] ..   ( <= ",
-				task->last_irq_disable[1]);
-	print_symbol("%s)\n", task->last_irq_disable[1]);
-
-	printk(".. [<%08lx>] .... ", task->last_irq_enable[0]);
-	print_symbol("%s\n", task->last_irq_enable[0]);
-	printk(".....[<%08lx>] ..   ( <= ",
-				task->last_irq_enable[1]);
-	print_symbol("%s)\n", task->last_irq_enable[1]);
-	printk("\n");
-}
--- kernel/latency.c.orig
+++ kernel/latency.c
@@ -108,15 +108,13 @@ enum trace_flag_type
 	TRACE_FLAG_NEED_RESCHED		= 0x02,
 	TRACE_FLAG_HARDIRQ		= 0x04,
 	TRACE_FLAG_SOFTIRQ		= 0x08,
-#ifdef CONFIG_RT_IRQ_DISABLE
 	TRACE_FLAG_IRQS_HARD_OFF	= 0x16,
-#endif
 };
 
 
 #ifdef CONFIG_LATENCY_TRACE
 
-#define MAX_TRACE (unsigned long)(8192-1)
+#define MAX_TRACE (unsigned long)(4096-1)
 
 #define CMDLINE_BYTES 16
 
@@ -266,9 +264,9 @@ ____trace(int cpu, enum trace_type type,
 		entry->cpu = cpu;
 #endif
 		entry->flags = (irqs_disabled() ? TRACE_FLAG_IRQS_OFF : 0) |
-#ifdef CONFIG_RT_IRQ_DISABLE
-			(hard_irqs_disabled() ? TRACE_FLAG_IRQS_HARD_OFF : 0)|
-#endif
+
+			(raw_irqs_disabled() ? TRACE_FLAG_IRQS_HARD_OFF : 0)|
+
 			((pc & HARDIRQ_MASK) ? TRACE_FLAG_HARDIRQ : 0) |
 			((pc & SOFTIRQ_MASK) ? TRACE_FLAG_SOFTIRQ : 0) |
 			(_need_resched() ? TRACE_FLAG_NEED_RESCHED : 0);
@@ -731,11 +729,7 @@ print_generic(struct seq_file *m, struct
 	seq_printf(m, "%d", entry->cpu);
 	seq_printf(m, "%c%c",
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
-#ifdef CONFIG_RT_IRQ_DISABLE
 		(entry->flags & TRACE_FLAG_IRQS_HARD_OFF) ? 'D' : '.',
-#else
-		'.',
-#endif
 		(entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'n' : '.');
 
 	hardirq = entry->flags & TRACE_FLAG_HARDIRQ;
@@ -1223,9 +1217,9 @@ void notrace trace_irqs_off_lowlevel(voi
 {
 	unsigned long flags;
 
-	hard_local_save_flags(flags);
+	raw_local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && hard_irqs_disabled_flags(flags))
+	if (!irqs_off_preempt_count() && raw_irqs_disabled_flags(flags))
 		__start_critical_timing(CALLER_ADDR0, 0);
 }
 
@@ -1233,9 +1227,9 @@ void notrace trace_irqs_off(void)
 {
 	unsigned long flags;
 
-	hard_local_save_flags(flags);
+	raw_local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && hard_irqs_disabled_flags(flags))
+	if (!irqs_off_preempt_count() && raw_irqs_disabled_flags(flags))
 		__start_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 
@@ -1245,9 +1239,9 @@ void notrace trace_irqs_on(void)
 {
 	unsigned long flags;
 
-	hard_local_save_flags(flags);
+	raw_local_save_flags(flags);
 
-	if (!irqs_off_preempt_count() && hard_irqs_disabled_flags(flags))
+	if (!irqs_off_preempt_count() && raw_irqs_disabled_flags(flags))
 		__stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
 }
 
@@ -1259,7 +1253,7 @@ EXPORT_SYMBOL(trace_irqs_on);
 
 #if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_CRITICAL_TIMING)
 
-void notrace add_preempt_count(int val)
+void notrace add_preempt_count(unsigned int val)
 {
 	unsigned long eip = CALLER_ADDR0;
 	unsigned long parent_eip = CALLER_ADDR1;
@@ -1290,9 +1284,9 @@ void notrace add_preempt_count(int val)
 #ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
 		unsigned long flags;
 
-		local_save_flags(flags);
+		raw_local_save_flags(flags);
 
-		if (!irqs_disabled_flags(flags))
+		if (!raw_irqs_disabled_flags(flags))
 #endif
 			if (preempt_count() == val)
 				__start_critical_timing(eip, parent_eip);
@@ -1302,7 +1296,7 @@ void notrace add_preempt_count(int val)
 }
 EXPORT_SYMBOL(add_preempt_count);
 
-void notrace sub_preempt_count(int val)
+void notrace sub_preempt_count(unsigned int val)
 {
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
@@ -1321,9 +1315,9 @@ void notrace sub_preempt_count(int val)
 #ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
 		unsigned long flags;
 
-		local_save_flags(flags);
+		raw_local_save_flags(flags);
 
-		if (!irqs_disabled_flags(flags))
+		if (!raw_irqs_disabled_flags(flags))
 #endif
 			if (preempt_count() == val)
 				__stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
@@ -1334,6 +1328,50 @@ void notrace sub_preempt_count(int val)
 
 EXPORT_SYMBOL(sub_preempt_count);
 
+void notrace mask_preempt_count(unsigned int mask)
+{
+	unsigned long eip = CALLER_ADDR0;
+	unsigned long parent_eip = CALLER_ADDR1;
+
+	preempt_count() |= mask;
+
+#ifdef CONFIG_CRITICAL_PREEMPT_TIMING
+	{
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+		unsigned long flags;
+
+		raw_local_save_flags(flags);
+
+		if (!raw_irqs_disabled_flags(flags))
+#endif
+			if (preempt_count() == mask)
+				__start_critical_timing(eip, parent_eip);
+	}
+#endif
+	(void) eip, (void) parent_eip;
+}
+EXPORT_SYMBOL(mask_preempt_count);
+
+void notrace unmask_preempt_count(unsigned int mask)
+{
+#ifdef CONFIG_CRITICAL_PREEMPT_TIMING
+	{
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+		unsigned long flags;
+
+		raw_local_save_flags(flags);
+
+		if (!raw_irqs_disabled_flags(flags))
+#endif
+			if (preempt_count() == mask)
+				__stop_critical_timing(CALLER_ADDR0, CALLER_ADDR1);
+	}
+#endif
+	preempt_count() &= ~mask;
+}
+EXPORT_SYMBOL(unmask_preempt_count);
+
+
 #endif
 
 /*
@@ -1457,7 +1495,8 @@ void trace_stop_sched_switched(struct ta
 
 	trace_special_pid(p->pid, p->prio, 0);
 
-	spin_lock_irqsave(&sch.trace_lock, flags);
+	raw_local_irq_save(flags);
+	spin_lock(&sch.trace_lock);
 	if (p == sch.task) {
 		sch.task = NULL;
 		tr = sch.tr;
@@ -1472,14 +1511,14 @@ void trace_stop_sched_switched(struct ta
 		spin_unlock(&sch.trace_lock);
 		check_wakeup_timing(tr, CALLER_ADDR0);
 //		atomic_dec(&tr->disabled);
-		local_irq_restore(flags);
 	} else {
 		if (sch.task)
 			trace_special_pid(sch.task->pid, sch.task->prio, p->prio);
 		if (sch.task && (sch.task->prio >= p->prio))
 			sch.task = NULL;
-		spin_unlock_irqrestore(&sch.trace_lock, flags);
+		spin_unlock(&sch.trace_lock);
 	}
+	raw_local_irq_restore(flags);
 }
 
 void trace_change_sched_cpu(struct task_struct *p, int new_cpu)
@@ -1490,12 +1529,14 @@ void trace_change_sched_cpu(struct task_
 		return;
 
 	trace_special(task_cpu(p), task_cpu(p), new_cpu);
-	spin_lock_irqsave(&sch.trace_lock, flags);
+	raw_local_irq_save(flags);
+	spin_lock(&sch.trace_lock);
 	if (p == sch.task && task_cpu(p) != new_cpu) {
 		sch.cpu = new_cpu;
 		trace_special(task_cpu(p), new_cpu, 0);
 	}
-	spin_unlock_irqrestore(&sch.trace_lock, flags);
+	spin_unlock(&sch.trace_lock);
+	raw_local_irq_restore(flags);
 }
 
 #endif
@@ -1520,11 +1561,13 @@ long user_trace_start(void)
 	if (wakeup_timing) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&sch.trace_lock, flags);
+		raw_local_irq_save(flags);
+		spin_lock(&sch.trace_lock);
 		sch.task = current;
 		sch.cpu = smp_processor_id();
 		sch.tr = tr;
-		spin_unlock_irqrestore(&sch.trace_lock, flags);
+		spin_unlock(&sch.trace_lock);
+		raw_local_irq_restore(flags);
 	}
 #endif
 	if (trace_all_cpus)
@@ -1560,16 +1603,19 @@ long user_trace_stop(void)
 	if (wakeup_timing) {
 		unsigned long flags;
 
-		spin_lock_irqsave(&sch.trace_lock, flags);
+		raw_local_irq_save(flags);
+		spin_lock(&sch.trace_lock);
 		if (current != sch.task) {
-			spin_unlock_irqrestore(&sch.trace_lock, flags);
+			spin_unlock(&sch.trace_lock);
+			raw_local_irq_restore(flags);
 			preempt_enable();
 			return -EINVAL;
 		}
 		sch.task = NULL;
 		tr = sch.tr;
 		sch.tr = NULL;
-		spin_unlock_irqrestore(&sch.trace_lock, flags);
+		spin_unlock(&sch.trace_lock);
+		raw_local_irq_restore(flags);
 	} else
 #endif
 		tr = cpu_traces + smp_processor_id();
@@ -1645,11 +1691,7 @@ static void print_entry(struct trace_ent
 
 	printk("%c%c",
 		(entry->flags & TRACE_FLAG_IRQS_OFF) ? 'd' :
-#ifdef CONFIG_RT_IRQ_DISABLE
 		(entry->flags & TRACE_FLAG_IRQS_HARD_OFF) ? 'D' : '.',
-#else
-		'.',
-#endif
  		(entry->flags & TRACE_FLAG_NEED_RESCHED) ? 'n' : '.');
 
 	hardirq = entry->flags & TRACE_FLAG_HARDIRQ;
--- init/main.c.orig
+++ init/main.c
@@ -428,7 +428,7 @@ asmlinkage void __init start_kernel(void
 {
 	char * command_line;
 	extern struct kernel_param __start___param[], __stop___param[];
-#ifdef CONFIG_RT_IRQ_DISABLE
+#ifdef CONFIG_PREEMPT_RT
 	/* 
  	 * Force the soft IRQ state to mimic the hard state until
 	 * we finish boot-up.
@@ -464,7 +464,7 @@ asmlinkage void __init start_kernel(void
 	 * fragile until we cpu_idle() for the first time.
 	 */
 	preempt_disable();
-#ifdef CONFIG_RT_IRQ_DISABLE
+#ifdef CONFIG_PREEMPT_RT
 	/*
 	 * Reset the irqs off flag after sched_init resets the preempt_count.
 	 */
@@ -501,7 +501,7 @@ asmlinkage void __init start_kernel(void
 	/*
 	 * Soft IRQ state will be enabled with the hard state.
 	 */
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 
 #ifdef CONFIG_BLK_DEV_INITRD
 	if (initrd_start && !initrd_below_start_ok &&
@@ -546,8 +546,8 @@ asmlinkage void __init start_kernel(void
 
 	acpi_early_init(); /* before LAPIC and SMP init */
 
-#ifdef CONFIG_RT_IRQ_DISABLE
-	WARN_ON(hard_irqs_disabled());
+#ifdef CONFIG_PREEMPT_RT
+	WARN_ON(raw_irqs_disabled());
 #endif
 	/* Do the rest non-__init'ed, we're now alive */
 	rest_init();
@@ -591,10 +591,10 @@ static void __init do_initcalls(void)
 			msg = "disabled interrupts";
 			local_irq_enable();
 		}
-#ifdef CONFIG_RT_IRQ_DISABLE
-		if (hard_irqs_disabled()) {
+#ifdef CONFIG_PREEMPT_RT
+		if (raw_irqs_disabled()) {
 			msg = "disabled hard interrupts";
-			hard_local_irq_enable();
+			raw_local_irq_enable();
 		}
 #endif
 		if (msg) {
@@ -737,8 +737,8 @@ static int init(void * unused)
 	 * The Bourne shell can be used instead of init if we are 
 	 * trying to recover a really broken machine.
 	 */
-#ifdef CONFIG_RT_IRQ_DISABLE
-	WARN_ON(hard_irqs_disabled());
+#ifdef CONFIG_PREEMPT_RT
+	WARN_ON(raw_irqs_disabled());
 #endif
 
 	if (execute_command)
--- arch/i386/mm/fault.c.orig
+++ arch/i386/mm/fault.c
@@ -232,7 +232,7 @@ fastcall notrace void do_page_fault(stru
 		return;
 	/* It's safe to allow irq's after cr2 has been saved */
 	if (regs->eflags & (X86_EFLAGS_IF|VM_MASK))
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 
 	tsk = current;
 
--- arch/i386/kernel/apic.c.orig
+++ arch/i386/kernel/apic.c
@@ -524,9 +524,9 @@ void lapic_shutdown(void)
 	if (!cpu_has_apic || !enabled_via_apicbase)
 		return;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	disable_local_APIC();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 #ifdef CONFIG_PM
@@ -570,9 +570,9 @@ static int lapic_suspend(struct sys_devi
 	apic_pm_state.apic_tdcr = apic_read(APIC_TDCR);
 	apic_pm_state.apic_thmr = apic_read(APIC_LVTTHMR);
 	
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 	disable_local_APIC();
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 	return 0;
 }
 
@@ -584,7 +584,7 @@ static int lapic_resume(struct sys_devic
 	if (!apic_pm_state.active)
 		return 0;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	/*
 	 * Make sure the APICBASE points to the right address
@@ -615,7 +615,7 @@ static int lapic_resume(struct sys_devic
 	apic_write(APIC_LVTERR, apic_pm_state.apic_lvterr);
 	apic_write(APIC_ESR, 0);
 	apic_read(APIC_ESR);
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 	return 0;
 }
 
@@ -934,7 +934,7 @@ static void __init setup_APIC_timer(unsi
 {
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	/*
 	 * Wait for IRQ0's slice:
@@ -943,7 +943,7 @@ static void __init setup_APIC_timer(unsi
 
 	__setup_APIC_LVTT(clocks);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 /*
@@ -1032,7 +1032,7 @@ void __init setup_boot_APIC_clock(void)
 	apic_printk(APIC_VERBOSE, "Using local APIC timer interrupts.\n");
 	using_apic_timer = 1;
 
-	local_irq_disable();
+	raw_local_irq_disable();
 
 	calibration_result = calibrate_APIC_clock();
 	/*
@@ -1040,7 +1040,7 @@ void __init setup_boot_APIC_clock(void)
 	 */
 	setup_APIC_timer(calibration_result);
 
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 void __init setup_secondary_APIC_clock(void)
--- arch/i386/kernel/smpboot.c.orig
+++ arch/i386/kernel/smpboot.c
@@ -440,7 +440,7 @@ static void __init start_secondary(void 
 	cpu_set(smp_processor_id(), cpu_online_map);
 
 	/* We can take interrupts now: we're officially "up". */
-	local_irq_enable();
+	raw_local_irq_enable();
 
 	wmb();
 	cpu_idle();
@@ -1120,17 +1120,17 @@ int __devinit __cpu_up(unsigned int cpu)
 {
 	/* This only works at boot for x86.  See "rewrite" above. */
 	if (cpu_isset(cpu, smp_commenced_mask)) {
-		local_irq_enable();
+		raw_local_irq_enable();
 		return -ENOSYS;
 	}
 
 	/* In case one didn't come up */
 	if (!cpu_isset(cpu, cpu_callin_map)) {
-		local_irq_enable();
+		raw_local_irq_enable();
 		return -EIO;
 	}
 
-	local_irq_enable();
+	raw_local_irq_enable();
 	/* Unleash the CPU! */
 	cpu_set(cpu, smp_commenced_mask);
 	while (!cpu_isset(cpu, cpu_online_map))
--- arch/i386/kernel/signal.c.orig
+++ arch/i386/kernel/signal.c
@@ -597,7 +597,7 @@ int fastcall do_signal(struct pt_regs *r
 	/*
 	 * Fully-preemptible kernel does not need interrupts disabled:
 	 */
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 	preempt_check_resched();
 #endif
 	/*
--- arch/i386/kernel/nmi.c.orig
+++ arch/i386/kernel/nmi.c
@@ -513,6 +513,7 @@ void notrace nmi_watchdog_tick (struct p
 	if (nmi_show_regs[cpu]) {
 		nmi_show_regs[cpu] = 0;
 		spin_lock(&nmi_print_lock);
+		printk("NMI show regs on CPU#%d:\n", cpu);
 		show_regs(regs);
 		spin_unlock(&nmi_print_lock);
 	}
@@ -523,15 +524,24 @@ void notrace nmi_watchdog_tick (struct p
 		 * wait a few IRQs (5 seconds) before doing the oops ...
 		 */
 		alert_counter[cpu]++;
-		if (alert_counter[cpu] == 5*nmi_hz) {
+		if (alert_counter[cpu] && !(alert_counter[cpu] % (5*nmi_hz))) {
 			int i;
 
 			bust_spinlocks(1);
-			for (i = 0; i < NR_CPUS; i++)
-				nmi_show_regs[i] = 1;
-		}
-		if (alert_counter[cpu] == 5*nmi_hz)
+			spin_lock(&nmi_print_lock);
+			printk("NMI watchdog detected lockup on CPU#%d (%d/%d)\n", cpu, alert_counter[cpu], 5*nmi_hz);
+			show_regs(regs);
+			spin_unlock(&nmi_print_lock);
+
+			for_each_online_cpu(i)
+				if (i != cpu)
+					nmi_show_regs[i] = 1;
+			for_each_online_cpu(i)
+				while (nmi_show_regs[i] == 1)
+					barrier();
+
 			die_nmi(regs, "NMI Watchdog detected LOCKUP");
+		}
 	} else {
 		last_irq_sums[cpu] = sum;
 		alert_counter[cpu] = 0;
--- arch/i386/kernel/entry.S.orig
+++ arch/i386/kernel/entry.S
@@ -76,10 +76,10 @@ NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli
+# define preempt_stop		cli
 #else
-#define preempt_stop
-#define resume_kernel		restore_nocheck
+# define preempt_stop
+# define resume_kernel		restore_nocheck
 #endif
 
 #define SAVE_ALL \
@@ -331,7 +331,7 @@ work_pending:
 work_resched:
 	cli
 	call __schedule
-#ifdef CONFIG_RT_IRQ_DISABLE
+#ifdef CONFIG_PREEMPT_RT
 	call local_irq_enable_noresched
 #endif
 					# make sure we don't miss an interrupt
--- arch/i386/kernel/process.c.orig
+++ arch/i386/kernel/process.c
@@ -96,13 +96,13 @@ EXPORT_SYMBOL(enable_hlt);
 void default_idle(void)
 {
 	if (!hlt_counter && boot_cpu_data.hlt_works_ok) {
-		hard_local_irq_disable();
+		raw_local_irq_disable();
 		if (!need_resched())
-			hard_safe_halt();
+			raw_safe_halt();
 		else
-			hard_local_irq_enable();
+			raw_local_irq_enable();
 	} else {
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 		cpu_relax();
 	}
 }
@@ -149,9 +149,8 @@ void cpu_idle (void)
 {
 	/* endless idle loop with no priority at all */
 	while (1) {
-#ifdef CONFIG_RT_IRQ_DISABLE
-			BUG_ON(hard_irqs_disabled());
-#endif
+		BUG_ON(raw_irqs_disabled());
+
 		while (!need_resched()) {
 			void (*idle)(void);
 
@@ -169,9 +168,9 @@ void cpu_idle (void)
 			propagate_preempt_locks_value();
 			idle();
 		}
-		hard_local_irq_disable();
+		raw_local_irq_disable();
 		__schedule();
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 	}
 }
 
--- arch/i386/kernel/traps.c.orig
+++ arch/i386/kernel/traps.c
@@ -376,7 +376,7 @@ static void do_trap(int trapnr, int sign
 		goto kernel_trap;
 
 #ifdef CONFIG_PREEMPT_RT
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 	preempt_check_resched();
 #endif
 
@@ -508,7 +508,7 @@ fastcall void do_general_protection(stru
 	return;
 
 gp_in_vm86:
-	hard_local_irq_enable();
+	raw_local_irq_enable();
 	handle_vm86_fault((struct kernel_vm86_regs *) regs, error_code);
 	return;
 
@@ -705,7 +705,7 @@ fastcall void do_debug(struct pt_regs * 
 		return;
 	/* It's safe to allow irq's after DR6 has been saved */
 	if (regs->eflags & X86_EFLAGS_IF)
-		hard_local_irq_enable();
+		raw_local_irq_enable();
 
 	/* Mask out spurious debug traps due to lazy DR7 setting */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
--- arch/i386/kernel/smp.c.orig
+++ arch/i386/kernel/smp.c
@@ -162,7 +162,7 @@ void send_IPI_mask_bitmask(cpumask_t cpu
 	unsigned long cfg;
 	unsigned long flags;
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 		
 	/*
 	 * Wait for idle.
@@ -185,7 +185,7 @@ void send_IPI_mask_bitmask(cpumask_t cpu
 	 */
 	apic_write_around(APIC_ICR, cfg);
 
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 void send_IPI_mask_sequence(cpumask_t mask, int vector)
@@ -199,7 +199,7 @@ void send_IPI_mask_sequence(cpumask_t ma
 	 * should be modified to do 1 message per cluster ID - mbligh
 	 */ 
 
-	local_irq_save(flags);
+	raw_local_irq_save(flags);
 
 	for (query_cpu = 0; query_cpu < NR_CPUS; ++query_cpu) {
 		if (cpu_isset(query_cpu, mask)) {
@@ -226,7 +226,7 @@ void send_IPI_mask_sequence(cpumask_t ma
 			apic_write_around(APIC_ICR, cfg);
 		}
 	}
-	local_irq_restore(flags);
+	raw_local_irq_restore(flags);
 }
 
 #include <mach_ipi.h> /* must come after the send_IPI functions above for inlining */
@@ -530,7 +530,7 @@ int smp_call_function (void (*func) (voi
 		return 0;
 
 	/* Can deadlock when called with interrupts disabled */
-	WARN_ON(irqs_disabled());
+	WARN_ON(raw_irqs_disabled());
 
 	data.func = func;
 	data.info = info;
@@ -564,7 +564,7 @@ static void stop_this_cpu (void * dummy)
 	 * Remove this CPU:
 	 */
 	cpu_clear(smp_processor_id(), cpu_online_map);
-	local_irq_disable();
+	raw_local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
 		for(;;) __asm__("hlt");
@@ -579,9 +579,9 @@ void smp_send_stop(void)
 {
 	smp_call_function(stop_this_cpu, NULL, 1, 0);
 
-	local_irq_disable();
+	raw_local_irq_disable();
 	disable_local_APIC();
-	local_irq_enable();
+	raw_local_irq_enable();
 }
 
 /*
--- arch/i386/kernel/irq.c.orig
+++ arch/i386/kernel/irq.c
@@ -218,7 +218,8 @@ int show_interrupts(struct seq_file *p, 
 	}
 
 	if (i < NR_IRQS) {
-		spin_lock_irqsave(&irq_desc[i].lock, flags);
+		raw_local_irq_save(flags);
+		spin_lock(&irq_desc[i].lock);
 		action = irq_desc[i].action;
 		if (!action)
 			goto skip;
@@ -239,7 +240,8 @@ int show_interrupts(struct seq_file *p, 
 
 		seq_putc(p, '\n');
 skip:
-		spin_unlock_irqrestore(&irq_desc[i].lock, flags);
+		spin_unlock(&irq_desc[i].lock);
+		raw_local_irq_restore(flags);
 	} else if (i == NR_IRQS) {
 		seq_printf(p, "NMI: ");
 		for (j = 0; j < NR_CPUS; j++)
--- drivers/usb/net/usbnet.c.orig
+++ drivers/usb/net/usbnet.c
@@ -3490,6 +3490,8 @@ static void tx_complete (struct urb *urb
 
 	urb->dev = NULL;
 	entry->state = tx_done;
+	spin_lock_rt(&dev->txq.lock);
+	spin_unlock_rt(&dev->txq.lock);
 	defer_bh (dev, skb);
 }
 
--- include/linux/seqlock.h.orig
+++ include/linux/seqlock.h
@@ -305,26 +305,26 @@ do {								\
  * Possible sw/hw IRQ protected versions of the interfaces.
  */
 #define write_seqlock_irqsave(lock, flags)				\
-	do { PICK_IRQOP2(hard_local_irq_save, flags, lock); write_seqlock(lock); } while (0)
+	do { PICK_IRQOP2(raw_local_irq_save, flags, lock); write_seqlock(lock); } while (0)
 #define write_seqlock_irq(lock)						\
-	do { PICK_IRQOP(hard_local_irq_disable, lock); write_seqlock(lock); } while (0)
+	do { PICK_IRQOP(raw_local_irq_disable, lock); write_seqlock(lock); } while (0)
 #define write_seqlock_bh(lock)						\
         do { PICK_IRQOP(local_bh_disable, lock); write_seqlock(lock); } while (0)
 
 #define write_sequnlock_irqrestore(lock, flags)				\
-	do { write_sequnlock(lock); PICK_IRQOP2(hard_local_irq_restore, flags, lock); preempt_check_resched(); } while(0)
+	do { write_sequnlock(lock); PICK_IRQOP2(raw_local_irq_restore, flags, lock); preempt_check_resched(); } while(0)
 #define write_sequnlock_irq(lock)					\
-	do { write_sequnlock(lock); PICK_IRQOP(hard_local_irq_enable, lock); preempt_check_resched(); } while(0)
+	do { write_sequnlock(lock); PICK_IRQOP(raw_local_irq_enable, lock); preempt_check_resched(); } while(0)
 #define write_sequnlock_bh(lock)					\
 	do { write_sequnlock(lock); PICK_IRQOP(local_bh_enable, lock); } while(0)
 
 #define read_seqbegin_irqsave(lock, flags)				\
-	({ PICK_IRQOP2(hard_local_irq_save, flags, lock); read_seqbegin(lock); })
+	({ PICK_IRQOP2(raw_local_irq_save, flags, lock); read_seqbegin(lock); })
 
 #define read_seqretry_irqrestore(lock, iv, flags)			\
 	({								\
 		int ret = read_seqretry(lock, iv);			\
-		PICK_IRQOP2(hard_local_irq_restore, flags, lock);		\
+		PICK_IRQOP2(raw_local_irq_restore, flags, lock);		\
 		preempt_check_resched(); 				\
 		ret;							\
 	})
--- include/linux/rt_irq.h.orig
+++ include/linux/rt_irq.h
@@ -0,0 +1,69 @@
+#ifndef __LINUX_RT_IRQ_H
+#define __LINUX_RT_IRQ_H
+
+/*
+ * Soft IRQ flag support on PREEMPT_RT kernels:
+ */
+#ifdef CONFIG_PREEMPT_RT
+
+extern void local_irq_enable(void);
+extern void local_irq_enable_noresched(void);
+extern void local_irq_disable(void);
+extern void local_irq_restore(unsigned long flags);
+extern void __local_save_flags(unsigned long *flags);
+extern void __local_irq_save(unsigned long *flags);
+extern int irqs_disabled(void);
+extern int irqs_disabled_flags(unsigned long flags);
+
+#define local_save_flags(flags)		__local_save_flags(&(flags))
+#define local_irq_save(flags)		__local_irq_save(&(flags))
+
+/* Force the soft state to follow the hard state */
+#define raw_local_save_flags(flags)	__raw_local_save_flags(flags)
+
+#define raw_local_irq_enable() \
+		do { \
+			local_irq_enable_noresched(); \
+			__raw_local_irq_enable(); \
+		} while (0)
+
+#define raw_local_irq_disable() \
+		do { __raw_local_irq_disable(); local_irq_disable(); } while (0)
+#define raw_local_irq_save(x) \
+		do { __raw_local_irq_save(x); } while (0)
+#define raw_local_irq_restore(x) \
+		do { __raw_local_irq_restore(x); } while (0)
+#define raw_safe_halt() \
+		do { local_irq_enable(); __raw_safe_halt(); } while (0)
+#else
+# define raw_local_save_flags		__raw_local_save_flags
+# define raw_local_irq_enable		__raw_local_irq_enable
+# define raw_local_irq_disable		__raw_local_irq_disable
+# define raw_local_irq_save		__raw_local_irq_save
+# define raw_local_irq_restore		__raw_local_irq_restore
+# define raw_safe_halt			__raw_safe_halt
+# define local_irq_enable_noresched	__raw_local_irq_enable
+# define local_save_flags		__raw_local_save_flags
+# define local_irq_enable		__raw_local_irq_enable 
+# define local_irq_disable		__raw_local_irq_disable 
+# define local_irq_save			__raw_local_irq_save
+# define local_irq_restore		__raw_local_irq_restore
+# define irqs_disabled			__raw_irqs_disabled
+# define irqs_disabled_flags		__raw_irqs_disabled_flags
+# define safe_halt			raw_safe_halt
+#endif
+
+#define raw_irqs_disabled		__raw_irqs_disabled
+#define raw_irqs_disabled_flags		__raw_irqs_disabled_flags
+
+#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
+  extern void notrace trace_irqs_off_lowlevel(void);
+  extern void notrace trace_irqs_off(void);
+  extern void notrace trace_irqs_on(void);
+#else
+# define trace_irqs_off_lowlevel()	do { } while (0)
+# define trace_irqs_off()		do { } while (0)
+# define trace_irqs_on()		do { } while (0)
+#endif
+
+#endif /* __LINUX_RT_IRQ_H */
--- include/linux/hardirq.h.orig
+++ include/linux/hardirq.h
@@ -16,20 +16,22 @@
  * The hardirq count can be overridden per architecture, the default is:
  *
  * - bits 16-27 are the hardirq count (max # of hardirqs: 4096)
- * - ( bit 28 is the PREEMPT_ACTIVE flag. )
+ * - bit 28 is the PREEMPT_ACTIVE flag
+ * - bit 29 is the soft irq-disable flag, IRQSOFF
  *
- * PREEMPT_MASK: 0x000000ff
- * SOFTIRQ_MASK: 0x0000ff00
- * HARDIRQ_MASK: 0x0fff0000
+ * PREEMPT_MASK:         0x000000ff
+ * SOFTIRQ_MASK:         0x0000ff00
+ * HARDIRQ_MASK:         0x0fff0000
+ * PREEMPT_ACTIVE_MASK:  0x10000000
+ * IRQSOFF_MASK:         0x20000000
  */
-#define PREEMPT_BITS	8
-#define SOFTIRQ_BITS	8
-
-#define IRQSOFF_BITS	1 
-#define PREEMPTACTIVE_BITS	1 
-
+#define PREEMPT_BITS		8
+#define SOFTIRQ_BITS		8
 #ifndef HARDIRQ_BITS
-#define HARDIRQ_BITS	12
+#define HARDIRQ_BITS		12
+#define PREEMPT_ACTIVE_BITS	1
+#define IRQSOFF_BITS		1
+
 /*
  * The hardirq mask has to be large enough to have space for potentially
  * all IRQ sources in the system nesting on a single CPU.
@@ -39,34 +41,31 @@
 #endif
 #endif
 
-#define PREEMPT_SHIFT	0
-#define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
-#define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
-
-#define PREEMPTACTIVE_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
-#define IRQSOFF_SHIFT 		(PREEMPTACTIVE_SHIFT + PREEMPTACTIVE_BITS)
-
-#define __IRQ_MASK(x)	((1UL << (x))-1)
+#define PREEMPT_SHIFT		0
+#define SOFTIRQ_SHIFT		(PREEMPT_SHIFT + PREEMPT_BITS)
+#define HARDIRQ_SHIFT		(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
+#define PREEMPT_ACTIVE_SHIFT	(HARDIRQ_SHIFT + HARDIRQ_BITS)
+#define IRQSOFF_SHIFT 		(PREEMPT_ACTIVE_SHIFT + PREEMPT_ACTIVE_BITS)
+
+#define __IRQ_MASK(x)		((1UL << (x))-1)
+
+#define PREEMPT_MASK		(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
+#define SOFTIRQ_MASK		(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
+#define HARDIRQ_MASK		(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
+#define IRQSOFF_MASK		(__IRQ_MASK(IRQSOFF_BITS) << IRQSOFF_SHIFT)
+
+#define PREEMPT_OFFSET		(1UL << PREEMPT_SHIFT)
+#define SOFTIRQ_OFFSET		(1UL << SOFTIRQ_SHIFT)
+#define HARDIRQ_OFFSET		(1UL << HARDIRQ_SHIFT)
+#define IRQSOFF_OFFSET		(1UL << IRQSOFF_SHIFT)
 
-#define PREEMPT_MASK	(__IRQ_MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define SOFTIRQ_MASK	(__IRQ_MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-#define HARDIRQ_MASK	(__IRQ_MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-
-#define IRQSOFF_MASK	(__IRQ_MASK(IRQSOFF_BITS) << IRQSOFF_SHIFT)
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
-#define IRQSOFF_OFFSET        (1UL << IRQSOFF_SHIFT)
 #if PREEMPT_ACTIVE < (1 << (HARDIRQ_SHIFT + HARDIRQ_BITS))
-#error PREEMPT_ACTIVE is too low!
+# error PREEMPT_ACTIVE is too low!
 #endif
 
 #define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
 #define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
 #define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
 #define irqs_off()	(preempt_count() & IRQSOFF_MASK)
 
 /*
@@ -80,9 +79,9 @@
 #if defined(CONFIG_PREEMPT) && \
 	!defined(CONFIG_PREEMPT_BKL) && \
 		!defined(CONFIG_PREEMPT_RT)
-# define in_atomic()	((preempt_count() & ~(PREEMPT_ACTIVE|IRQSOFF_OFFSET)) != kernel_locked())
+# define in_atomic()	((preempt_count() & ~(PREEMPT_ACTIVE|IRQSOFF_MASK)) != kernel_locked())
 #else
-# define in_atomic()	((preempt_count() & ~(PREEMPT_ACTIVE|IRQSOFF_OFFSET)) != 0)
+# define in_atomic()	((preempt_count() & ~(PREEMPT_ACTIVE|IRQSOFF_MASK)) != 0)
 #endif
 
 #ifdef CONFIG_PREEMPT
--- include/linux/preempt.h.orig
+++ include/linux/preempt.h
@@ -10,11 +10,17 @@
 #include <linux/linkage.h>
 
 #if defined(CONFIG_DEBUG_PREEMPT) || defined(CONFIG_CRITICAL_TIMING)
-  extern void notrace add_preempt_count(int val);
-  extern void notrace sub_preempt_count(int val);
+  extern void notrace add_preempt_count(unsigned int val);
+  extern void notrace sub_preempt_count(unsigned int val);
+  extern void notrace mask_preempt_count(unsigned int mask);
+  extern void notrace unmask_preempt_count(unsigned int mask);
 #else
 # define add_preempt_count(val)	do { preempt_count() += (val); } while (0)
 # define sub_preempt_count(val)	do { preempt_count() -= (val); } while (0)
+# define mask_preempt_count(mask) \
+		do { preempt_count() |= (mask); } while (0)
+# define unmask_preempt_count(mask) \
+		do { preempt_count() &= ~(mask); } while (0)
 #endif
 
 #ifdef CONFIG_CRITICAL_TIMING
--- include/asm-i386/system.h.orig
+++ include/asm-i386/system.h
@@ -440,80 +440,32 @@ struct alt_instr { 
 
 #define set_wmb(var, value) do { var = value; wmb(); } while (0)
 
-#ifdef CONFIG_CRITICAL_IRQSOFF_TIMING
-  extern void notrace trace_irqs_off_lowlevel(void);
-  extern void notrace trace_irqs_off(void);
-  extern void notrace trace_irqs_on(void);
-#else
-# define trace_irqs_off_lowlevel()	do { } while (0)
-# define trace_irqs_off()		do { } while (0)
-# define trace_irqs_on()		do { } while (0)
-#endif
-
-#ifdef CONFIG_RT_IRQ_DISABLE
-extern void local_irq_enable(void);
-extern void local_irq_enable_noresched(void);
-extern void local_irq_disable(void);
-extern void local_irq_restore(unsigned long);
-extern unsigned long irqs_disabled(void);
-extern unsigned long irqs_disabled_flags(unsigned long);
-extern unsigned int ___local_save_flags(void);
-extern void irq_trace_enable(void);
-extern void irq_trace_disable(void);
-
-#define local_save_flags(x) ({ x = ___local_save_flags(); x;})
-#define local_irq_save(x) ({ local_save_flags(x); local_irq_disable(); x;})
-#define safe_halt()	do { local_irq_enable(); __asm__ __volatile__("hlt": : :"memory"); } while (0)
-
-/* Force the softstate to follow the hard state */
-#define hard_local_save_flags(x)	_hard_local_save_flags(x)
-#define hard_local_irq_enable()		do { local_irq_enable_noresched(); _hard_local_irq_enable(); } while(0)
-#define hard_local_irq_disable()	do { _hard_local_irq_disable(); local_irq_disable(); } while(0)
-#define hard_local_irq_save(x)		do { _hard_local_irq_save(x); } while(0)
-#define hard_local_irq_restore(x)		do { _hard_local_irq_restore(x); } while (0)
-#define hard_safe_halt()			do { local_irq_enable(); _hard_safe_halt(); } while (0)
-#else
-
-#define hard_local_save_flags		_hard_local_save_flags
-#define hard_local_irq_enable		_hard_local_irq_enable
-#define hard_local_irq_disable		_hard_local_irq_disable
-#define hard_local_irq_save		_hard_local_irq_save
-#define hard_local_irq_restore		_hard_local_irq_restore
-#define hard_safe_halt			_hard_safe_halt
-
-#define local_irq_enable_noresched _hard_local_irq_enable
-#define local_save_flags	_hard_local_save_flags
-#define local_irq_enable	_hard_local_irq_enable 
-#define local_irq_disable	_hard_local_irq_disable 
-#define local_irq_save		_hard_local_irq_save
-#define local_irq_restore	_hard_local_irq_restore
-#define irqs_disabled		hard_irqs_disabled
-#define irqs_disabled_flags	hard_irqs_disabled_flags
-#define safe_halt		hard_safe_halt
-#endif
-
 /* interrupt control.. */
-#define _hard_local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
-#define _hard_local_irq_restore(x) 	do { typecheck(unsigned long,x); if (hard_irqs_disabled_flags(x)) trace_irqs_on(); else trace_irqs_on(); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
-#define _hard_local_irq_disable() 	do { __asm__ __volatile__("cli": : :"memory"); trace_irqs_off(); } while (0)
-#define _hard_local_irq_enable()	do { trace_irqs_on(); __asm__ __volatile__("sti": : :"memory"); } while (0)
+#define __raw_local_save_flags(x)	do { typecheck(unsigned long,x); __asm__ __volatile__("pushfl ; popl %0":"=g" (x): /* no input */); } while (0)
+#define __raw_local_irq_restore(x) 	do { typecheck(unsigned long,x); if (raw_irqs_disabled_flags(x)) trace_irqs_on(); else trace_irqs_on(); __asm__ __volatile__("pushl %0 ; popfl": /* no output */ :"g" (x):"memory", "cc"); } while (0)
+#define __raw_local_irq_disable() 	do { __asm__ __volatile__("cli": : :"memory"); trace_irqs_off(); } while (0)
+#define __raw_local_irq_enable()	do { trace_irqs_on(); __asm__ __volatile__("sti": : :"memory"); } while (0)
 /* used in the idle loop; sti takes one instruction cycle to complete */
-#define _hard_safe_halt()		do { trace_irqs_on(); __asm__ __volatile__("sti; hlt": : :"memory"); } while (0)
+#define __raw_safe_halt()		do { trace_irqs_on(); __asm__ __volatile__("sti; hlt": : :"memory"); } while (0)
 
-#define hard_irqs_disabled_flags(flags)	\
-({					\
-	!(flags & (1<<9));		\
+#define __raw_irqs_disabled_flags(flags)	\
+({						\
+	!(flags & (1<<9));			\
 })
 
-#define hard_irqs_disabled()			\
-({					\
-	unsigned long flags;		\
-	hard_local_save_flags(flags);	\
-	hard_irqs_disabled_flags(flags);	\
+#define __raw_irqs_disabled()			\
+({						\
+	unsigned long flags;			\
+	__raw_local_save_flags(flags);		\
+	__raw_irqs_disabled_flags(flags);	\
 })
 
 /* For spinlocks etc */
-#define _hard_local_irq_save(x)	do { __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory"); trace_irqs_off(); } while (0)
+#define __raw_local_irq_save(x)	do { __asm__ __volatile__("pushfl ; popl %0 ; cli":"=g" (x): /* no input */ :"memory"); trace_irqs_off(); } while (0)
+
+#include <linux/rt_irq.h>
+
+#define safe_halt()	do { local_irq_enable(); __asm__ __volatile__("hlt": : :"memory"); } while (0)
 
 /*
  * disable hlt during certain critical i/o operations
--- Makefile.orig
+++ Makefile
@@ -1,7 +1,7 @@
 VERSION = 2
 PATCHLEVEL = 6
 SUBLEVEL = 12
-EXTRAVERSION =-rc6-RT-V0.7.47-30
+EXTRAVERSION =-rc6-RT-V0.7.48-00
 NAME=Woozy Numbat
 
 # *DOCUMENTATION*
--- lib/kernel_lock.c.orig
+++ lib/kernel_lock.c
@@ -24,7 +24,7 @@ unsigned int notrace smp_processor_id(vo
 	if (likely(preempt_count))
 		goto out;
 
-	if (irqs_disabled())
+	if (irqs_disabled() || raw_irqs_disabled())
 		goto out;
 
 	/*
@@ -50,7 +50,7 @@ unsigned int notrace smp_processor_id(vo
 	if (!printk_ratelimit())
 		goto out_enable;
 
-	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count(), current->comm, current->pid);
+	printk(KERN_ERR "BUG: using smp_processor_id() in preemptible [%08x] code: %s/%d\n", preempt_count()-1, current->comm, current->pid);
 	print_symbol("caller is %s\n", (long)__builtin_return_address(0));
 	dump_stack();
 
@@ -98,8 +98,7 @@ int __lockfunc __reacquire_kernel_lock(v
 	struct task_struct *task = current;
 	int saved_lock_depth = task->lock_depth;
 
-	hard_local_irq_enable();
-
+	raw_local_irq_enable();
 	BUG_ON(saved_lock_depth < 0);
 
 	task->lock_depth = -1;
@@ -108,8 +107,8 @@ int __lockfunc __reacquire_kernel_lock(v
 
 	task->lock_depth = saved_lock_depth;
 
-	hard_local_irq_disable();
-	
+	raw_local_irq_disable();
+
 	return 0;
 }
 
--- lib/Kconfig.RT.orig
+++ lib/Kconfig.RT
@@ -81,25 +81,6 @@ config PREEMPT_RT
 
 endchoice
 
-config RT_IRQ_DISABLE
-	bool "Real-Time IRQ Disable"
-	default y
-	depends on PREEMPT_RT
-	help
-	  This option will remove all local_irq_enable() and
-	  local_irq_disable() calls and replace them with soft
-	  versions. This will decrease the frequency that
-	  interrupt are disabled.
-
-	  All interrupts that are flagged with SA_NODELAY are
-	  considered hard interrupts. This option will force
-	  SA_NODELAY interrupts to run even when they normally
-	  wouldn't be enabled.
-
-	  Select this if you plan to use Linux in an 
-	  embedded enviorment that needs low interrupt
-	  latency.
-
 config PREEMPT
 	bool
 	default y
