Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292135AbSBTR5z>; Wed, 20 Feb 2002 12:57:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292133AbSBTR5r>; Wed, 20 Feb 2002 12:57:47 -0500
Received: from artemis.rus.uni-stuttgart.de ([129.69.1.28]:31679 "EHLO
	artemis.rus.uni-stuttgart.de") by vger.kernel.org with ESMTP
	id <S292135AbSBTR5a>; Wed, 20 Feb 2002 12:57:30 -0500
Date: Wed, 20 Feb 2002 18:57:05 +0100 (MET)
From: Erich Focht <efocht@ess.nec.de>
To: linux-kernel <linux-kernel@vger.kernel.org>
cc: Ingo Molnar <mingo@elte.hu>, Paul Jackson <pj@engr.sgi.com>,
        Matthew Dobson <colpatch@us.ibm.com>, lse-tech@lists.sourceforge.net
Subject: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
Message-ID: <Pine.LNX.4.21.0202201826120.7476-100000@sx6.ess.nec.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

this is another attempt to overcome a limitation of the
O(1) scheduler: set_cpus_allowed() can only be called for current
processes.

There are several patches around which need to be able to set the
cpus_allowed mask of an arbitrary process. They are mostly meant as
interfaces to external (user-level) load-balancers which restrict
processes to run only on particular CPUs.

The appended patch contains following changes:
- set_cpus_allowed treats tasks to be moved depending on their state:
  - for tasks currently running on a foreign CPU:
       an IPI is sent to their CPU,
       the tasks are forced to unschedule,
       an IPI is sent to the target CPU where the interrupt handler waits
       for the task to unschedule and activates the task on its new runqueue.
  - for tasks not running currently:
       if the task is enqueued: deactivate from old RQ, activate on new RQ,
       if the task is not enqueued: just change its cpu.
  - if trying to move "current": same treatment as before.
- multiple simultaneous calls to set_cpus_allowed() are possible, the one
  lock has been extended to an array of size NR_CPUS.
- the cpu of a forked task is chosen in do_fork() and not in
  wake_up_forked_process(). This avoids problems with children forked
  shortly after the cpus_allowed mask has been set (and the parent task
  wasn't moved yet).

The patch is for 2.5.4-K3. I'm actually developing on IA-64 and tested it
on Itanium systems based on 2.4.17 kernels where it survived my
tests. I hope this works for i386 and is helpful to someone.

Best regards,

Erich Focht

diff -ur linux-2.5.4/arch/i386/kernel/smp.c linux-2.5.4-sca/arch/i386/kernel/smp.c
--- linux-2.5.4/arch/i386/kernel/smp.c	Mon Feb 11 02:50:09 2002
+++ linux-2.5.4-sca/arch/i386/kernel/smp.c	Wed Feb 20 18:48:01 2002
@@ -485,8 +485,9 @@
 	do_flush_tlb_all_local();
 }
 
-static spinlock_t migration_lock = SPIN_LOCK_UNLOCKED;
-static task_t *new_task;
+static spinlock_t migration_lock[NR_CPUS] = { [0 ... NR_CPUS-1] = SPIN_LOCK_UNLOCKED};
+static task_t *new_task[NR_CPUS] = { [0 ... NR_CPUS-1] = NULL};
+static long migration_state[NR_CPUS];
 
 /*
  * This function sends a 'task migration' IPI to another CPU.
@@ -497,23 +498,65 @@
 	/*
 	 * The target CPU will unlock the migration spinlock:
 	 */
-	_raw_spin_lock(&migration_lock);
-	new_task = p;
+	_raw_spin_lock(&migration_lock[cpu]);
+	new_task[cpu] = p;
+	if (p->cpus_allowed & (1UL<<cpu)) {
+		/*
+		 * if sending IPI to target CPU: remember state
+		 * (only called if migrating current)
+		 */
+		migration_state[cpu] = p->state;
+		p->state = TASK_UNINTERRUPTIBLE;
+	}
 	send_IPI_mask(1 << cpu, TASK_MIGRATION_VECTOR);
 }
 
 /*
  * Task migration callback.
+ * If the task is currently running, its CPU gets the interrupt. The task is
+ * forced to unschedule and an interrupt is sent to the target CPU. On the
+ * target CPU we wait for the task to unschedule, restore its old state and
+ * activate it.
  */
 asmlinkage void smp_task_migration_interrupt(void)
 {
-	task_t *p;
+	int this_cpu = smp_processor_id();
+	task_t *p = new_task[this_cpu];
+	long state = migration_state[this_cpu];
 
 	ack_APIC_irq();
-	p = new_task;
-	_raw_spin_unlock(&migration_lock);
-	sched_task_migrated(p);
+
+	_raw_spin_unlock(&migration_lock[this_cpu]);
+
+	if (p->cpus_allowed & (1UL<<this_cpu)) {
+		/*
+		 * on target CPU
+		 */
+		sched_task_migrated(p, state);
+	} else {
+		/*
+		 * on source CPU,
+		 */
+		int tgt_cpu = __ffs(p->cpus_allowed);
+
+		_raw_spin_lock(&migration_lock[tgt_cpu]);
+		if (p == current) {
+			migration_state[tgt_cpu] = p->state;
+			new_task[tgt_cpu] = p;
+			p->state = TASK_UNINTERRUPTIBLE;
+			current->need_resched = 1;
+			send_IPI_mask(1 << tgt_cpu, TASK_MIGRATION_VECTOR);
+		} else {	                   /* task meanwhile off CPU */
+			_raw_spin_unlock(&migration_lock[tgt_cpu]);
+			/*
+			 * following function fails only if p==current or p has 
+			 * migrated to another CPU (which must be a valid one).
+			 */
+			sched_move_task(p, p->thread_info->cpu, tgt_cpu);
+		}
+	}
 }
+
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing
diff -ur linux-2.5.4/include/linux/sched.h linux-2.5.4-sca/include/linux/sched.h
--- linux-2.5.4/include/linux/sched.h	Wed Feb 20 18:09:02 2002
+++ linux-2.5.4-sca/include/linux/sched.h	Wed Feb 20 18:49:12 2002
@@ -151,7 +151,8 @@
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
-extern void sched_task_migrated(struct task_struct *p);
+extern void sched_task_migrated(struct task_struct *p, long state);
+extern int sched_move_task(task_t *p, int src_cpu, int tgt_cpu);
 extern void smp_migrate_task(int cpu, task_t *task);
 extern unsigned long cache_decay_ticks;
 
diff -ur linux-2.5.4/kernel/fork.c linux-2.5.4-sca/kernel/fork.c
--- linux-2.5.4/kernel/fork.c	Wed Feb 20 18:09:02 2002
+++ linux-2.5.4-sca/kernel/fork.c	Wed Feb 20 18:37:22 2002
@@ -693,6 +693,10 @@
 	{
 		int i;
 
+		if (likely(p->cpus_allowed & (1UL<<smp_processor_id())))
+			p->thread_info->cpu = smp_processor_id();
+		else
+			p->thread_info->cpu = __ffs(p->cpus_allowed);
 		/* ?? should we just memset this ?? */
 		for(i = 0; i < smp_num_cpus; i++)
 			p->per_cpu_utime[cpu_logical_map(i)] =
diff -ur linux-2.5.4/kernel/sched.c linux-2.5.4-sca/kernel/sched.c
--- linux-2.5.4/kernel/sched.c	Wed Feb 20 18:09:02 2002
+++ linux-2.5.4-sca/kernel/sched.c	Wed Feb 20 18:54:57 2002
@@ -305,11 +305,21 @@
  *
  * This function must be called with interrupts disabled.
  */
-void sched_task_migrated(task_t *new_task)
+void sched_task_migrated(task_t *p, long state)
 {
-	wait_task_inactive(new_task);
-	new_task->thread_info->cpu = smp_processor_id();
-	wake_up_process(new_task);
+	runqueue_t *rq;
+	unsigned long flags;
+
+	wait_task_inactive(p);
+	p->thread_info->cpu = smp_processor_id();
+	rq = lock_task_rq(p, &flags);
+	p->state = state;
+	if (!p->array) {
+		activate_task(p, rq);
+		if ((rq->curr == rq->idle) || (p->prio < rq->curr->prio))
+			resched_task(rq->curr);
+	}
+	unlock_task_rq(rq, &flags);
 }
 
 /*
@@ -364,7 +374,7 @@
 	runqueue_t *rq;
 
 	preempt_disable();
-	rq = this_rq();
+	rq = task_rq(p);
 
 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
@@ -378,7 +388,7 @@
 		p->prio = effective_prio(p);
 	}
 	spin_lock_irq(&rq->lock);
-	p->thread_info->cpu = smp_processor_id();
+	//p->thread_info->cpu = smp_processor_id();
 	activate_task(p, rq);
 	spin_unlock_irq(&rq->lock);
 	preempt_enable();
@@ -1017,8 +1027,6 @@
 	new_mask &= cpu_online_map;
 	if (!new_mask)
 		BUG();
-	if (p != current)
-		BUG();
 
 	p->cpus_allowed = new_mask;
 	/*
@@ -1028,10 +1036,28 @@
 	if (new_mask & (1UL << smp_processor_id()))
 		return;
 #if CONFIG_SMP
-	current->state = TASK_UNINTERRUPTIBLE;
-	smp_migrate_task(__ffs(new_mask), current);
+	{
+		int tgt_cpu = __ffs(p->cpus_allowed);
 
-	schedule();
+ retry:
+		if (p == current) {
+			smp_migrate_task(tgt_cpu, p);
+			schedule();
+		} else {
+			if (p != task_rq(p)->curr) {
+				/*
+				 * Task is not running currently
+				 */
+				if (!sched_move_task(p, p->thread_info->cpu, tgt_cpu))
+					goto retry;
+			} else {
+				/*
+				 * task is currently running on another CPU
+				 */
+				smp_migrate_task(p->thread_info->cpu, p);
+			}
+		}
+	}
 #endif
 }
 
@@ -1488,6 +1514,36 @@
 		spin_unlock(&rq2->lock);
 }
 
+/*
+ * Move a task from src_cpu to tgt_cpu.
+ * Return 0 if task is not on src_cpu or task is currently running.
+ * Return 1 if task was not running currently and moved successfully.
+ */
+int sched_move_task(task_t *p, int src_cpu, int tgt_cpu)
+{
+	int res = 0;
+	unsigned long flags;
+	runqueue_t *src = cpu_rq(src_cpu);
+	runqueue_t *tgt = cpu_rq(tgt_cpu);
+
+	local_irq_save(flags);
+	double_rq_lock(src, tgt);
+	if (task_rq(p) != src || p == src->curr)
+		goto out;
+	if (p->thread_info->cpu != tgt_cpu) {
+		p->thread_info->cpu = tgt_cpu;
+		if (p->array) {
+			deactivate_task(p, src);
+			activate_task(p, tgt);
+		}
+	}
+	res = 1;
+ out:
+	double_rq_unlock(src, tgt);
+	local_irq_restore(flags);
+	return res;
+}
+
 void __init init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = idle->array->rq;
    


