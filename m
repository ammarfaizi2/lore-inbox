Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292394AbSBUOev>; Thu, 21 Feb 2002 09:34:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292396AbSBUOei>; Thu, 21 Feb 2002 09:34:38 -0500
Received: from mx2.elte.hu ([157.181.151.9]:62621 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S292394AbSBUOeL>;
	Thu, 21 Feb 2002 09:34:11 -0500
Date: Thu, 21 Feb 2002 17:32:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Erich Focht <efocht@ess.nec.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
        Paul Jackson <pj@engr.sgi.com>, Matthew Dobson <colpatch@us.ibm.com>,
        lse-tech <lse-tech@lists.sourceforge.net>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [PATCH] O(1) scheduler set_cpus_allowed for non-current tasks
In-Reply-To: <Pine.LNX.4.21.0202201826120.7476-100000@sx6.ess.nec.de>
Message-ID: <Pine.LNX.4.33.0202211723520.14005-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 20 Feb 2002, Erich Focht wrote:

> The appended patch contains following changes:
> - set_cpus_allowed treats tasks to be moved depending on their state:
>   - for tasks currently running on a foreign CPU:
>        an IPI is sent to their CPU,
>        the tasks are forced to unschedule,
>        an IPI is sent to the target CPU where the interrupt handler waits
>        for the task to unschedule and activates the task on its new runqueue.
>   - for tasks not running currently:
>        if the task is enqueued: deactivate from old RQ, activate on new RQ,
>        if the task is not enqueued: just change its cpu.
>   - if trying to move "current": same treatment as before.
> - multiple simultaneous calls to set_cpus_allowed() are possible, the one
>   lock has been extended to an array of size NR_CPUS.
> - the cpu of a forked task is chosen in do_fork() and not in
>   wake_up_forked_process(). This avoids problems with children forked
>   shortly after the cpus_allowed mask has been set (and the parent task
>   wasn't moved yet).

the problem is, the migration interrupt concept is fundamentally unrobust.
It involves 'waiting' for a task to unschedule in IRQ context - this is
problematic. What happens if the involuntarily migrated task is looping in
a spin_lock(), which lock is held by a task on the target CPU, which task
is hit by the migration interrupt? Deadlock.

to solve this i had to get rid of the migration interrupt completely. (see
the attached patch, against 2.5.5) The concept is the following: there are
new per-CPU system threads (so-called migration threads) that handle a
per-runqueue 'migration queue'. set_cpus_allowed() registers tasks in the
target CPU's migration queue, kicks the migrating thread and wakes up the
migration thread. The migrating thread unschedules on its source CPU, at
which point the migration thread picks the task up and puts it into the
local runqueue.

this solution also makes it easier to support migration on non-x86
architectures: no arch-specific functionality is needed.

i've tested forced migration (by adding a syscall that allows users to
change the affinity of processes), and it works just fine under various
situations.

(the patch also includes a number of other pending scheduler cleanups and
small speedups, such as the removal of sync wakeups - cache-affine load
balancing solves the sync wakeup problem already.)

	Ingo

--- linux/fs/pipe.c.orig	Thu Feb 21 10:23:45 2002
+++ linux/fs/pipe.c	Thu Feb 21 10:25:00 2002
@@ -116,7 +116,7 @@
 		 * writers synchronously that there is more
 		 * room.
 		 */
-		wake_up_interruptible_sync(PIPE_WAIT(*inode));
+		wake_up_interruptible(PIPE_WAIT(*inode));
 		if (!PIPE_EMPTY(*inode))
 			BUG();
 		goto do_more_read;
@@ -214,7 +214,7 @@
 			 * is going to give up this CPU, so it doesnt have
 			 * to do idle reschedules.
 			 */
-			wake_up_interruptible_sync(PIPE_WAIT(*inode));
+			wake_up_interruptible(PIPE_WAIT(*inode));
 			PIPE_WAITING_WRITERS(*inode)++;
 			pipe_wait(inode);
 			PIPE_WAITING_WRITERS(*inode)--;
--- linux/init/main.c.orig	Thu Feb 21 11:45:22 2002
+++ linux/init/main.c	Thu Feb 21 13:23:05 2002
@@ -413,7 +413,12 @@
  */
 static void __init do_basic_setup(void)
 {
-
+	/*
+	 * Let the per-CPU migration threads start up:
+	 */
+#if CONFIG_SMP
+	migration_init();
+#endif
 	/*
 	 * Tell the world that we're going to be the grim
 	 * reaper of innocent orphaned children.
--- linux/kernel/sched.c.orig	Thu Feb 21 10:23:49 2002
+++ linux/kernel/sched.c	Thu Feb 21 14:33:51 2002
@@ -16,12 +16,12 @@
 #include <linux/nmi.h>
 #include <linux/init.h>
 #include <asm/uaccess.h>
+#include <linux/highmem.h>
 #include <linux/smp_lock.h>
+#include <asm/mmu_context.h>
 #include <linux/interrupt.h>
 #include <linux/completion.h>
-#include <asm/mmu_context.h>
 #include <linux/kernel_stat.h>
-#include <linux/highmem.h>

 /*
  * Priority of a process goes from 0 to 139. The 0-99
@@ -127,8 +127,6 @@

 struct prio_array {
 	int nr_active;
-	spinlock_t *lock;
-	runqueue_t *rq;
 	unsigned long bitmap[BITMAP_SIZE];
 	list_t queue[MAX_PRIO];
 };
@@ -146,6 +144,8 @@
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
+	task_t *migration_thread;
+	list_t migration_queue;
 } ____cacheline_aligned;

 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -156,23 +156,23 @@
 #define cpu_curr(cpu)		(cpu_rq(cpu)->curr)
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)

-static inline runqueue_t *lock_task_rq(task_t *p, unsigned long *flags)
+static inline runqueue_t *task_rq_lock(task_t *p, unsigned long *flags)
 {
-	struct runqueue *__rq;
+	struct runqueue *rq;

 repeat_lock_task:
 	preempt_disable();
-	__rq = task_rq(p);
-	spin_lock_irqsave(&__rq->lock, *flags);
-	if (unlikely(__rq != task_rq(p))) {
-		spin_unlock_irqrestore(&__rq->lock, *flags);
+	rq = task_rq(p);
+	spin_lock_irqsave(&rq->lock, *flags);
+	if (unlikely(rq != task_rq(p))) {
+		spin_unlock_irqrestore(&rq->lock, *flags);
 		preempt_enable();
 		goto repeat_lock_task;
 	}
-	return __rq;
+	return rq;
 }

-static inline void unlock_task_rq(runqueue_t *rq, unsigned long *flags)
+static inline void task_rq_unlock(runqueue_t *rq, unsigned long *flags)
 {
 	spin_unlock_irqrestore(&rq->lock, *flags);
 	preempt_enable();
@@ -184,7 +184,7 @@
 static inline void dequeue_task(struct task_struct *p, prio_array_t *array)
 {
 	array->nr_active--;
-	list_del_init(&p->run_list);
+	list_del(&p->run_list);
 	if (list_empty(array->queue + p->prio))
 		__clear_bit(p->prio, array->bitmap);
 }
@@ -289,31 +289,17 @@
 		cpu_relax();
 		barrier();
 	}
-	rq = lock_task_rq(p, &flags);
+	rq = task_rq_lock(p, &flags);
 	if (unlikely(rq->curr == p)) {
-		unlock_task_rq(rq, &flags);
+		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
 	}
-	unlock_task_rq(rq, &flags);
+	task_rq_unlock(rq, &flags);
 	preempt_enable();
 }

 /*
- * The SMP message passing code calls this function whenever
- * the new task has arrived at the target CPU. We move the
- * new task into the local runqueue.
- *
- * This function must be called with interrupts disabled.
- */
-void sched_task_migrated(task_t *new_task)
-{
-	wait_task_inactive(new_task);
-	new_task->thread_info->cpu = smp_processor_id();
-	wake_up_process(new_task);
-}
-
-/*
  * Kick the remote CPU if the task is running currently,
  * this code is used by the signal code to signal tasks
  * which are in user-mode as quickly as possible.
@@ -337,27 +323,27 @@
  * "current->state = TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
  */
-static int try_to_wake_up(task_t * p, int synchronous)
+static int try_to_wake_up(task_t * p)
 {
 	unsigned long flags;
 	int success = 0;
 	runqueue_t *rq;

-	rq = lock_task_rq(p, &flags);
+	rq = task_rq_lock(p, &flags);
 	p->state = TASK_RUNNING;
 	if (!p->array) {
 		activate_task(p, rq);
-		if ((rq->curr == rq->idle) || (p->prio < rq->curr->prio))
+		if (p->prio < rq->curr->prio)
 			resched_task(rq->curr);
 		success = 1;
 	}
-	unlock_task_rq(rq, &flags);
+	task_rq_unlock(rq, &flags);
 	return success;
 }

 int wake_up_process(task_t * p)
 {
-	return try_to_wake_up(p, 0);
+	return try_to_wake_up(p);
 }

 void wake_up_forked_process(task_t * p)
@@ -366,6 +352,7 @@

 	preempt_disable();
 	rq = this_rq();
+	spin_lock_irq(&rq->lock);

 	p->state = TASK_RUNNING;
 	if (!rt_task(p)) {
@@ -378,10 +365,12 @@
 		p->sleep_avg = p->sleep_avg * CHILD_PENALTY / 100;
 		p->prio = effective_prio(p);
 	}
-	spin_lock_irq(&rq->lock);
+	INIT_LIST_HEAD(&p->migration_list);
 	p->thread_info->cpu = smp_processor_id();
 	activate_task(p, rq);
+
 	spin_unlock_irq(&rq->lock);
+	init_MUTEX(&p->migration_sem);
 	preempt_enable();
 }

@@ -861,44 +850,33 @@
  * started to run but is not in state TASK_RUNNING.  try_to_wake_up() returns
  * zero in this (rare) case, and we handle it by continuing to scan the queue.
  */
-static inline void __wake_up_common (wait_queue_head_t *q, unsigned int mode,
-			 	     int nr_exclusive, const int sync)
+static inline void __wake_up_common(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
 	struct list_head *tmp;
+	unsigned int state;
+	wait_queue_t *curr;
 	task_t *p;

-	list_for_each(tmp,&q->task_list) {
-		unsigned int state;
-		wait_queue_t *curr = list_entry(tmp, wait_queue_t, task_list);
-
+	list_for_each(tmp, &q->task_list) {
+		curr = list_entry(tmp, wait_queue_t, task_list);
 		p = curr->task;
 		state = p->state;
-		if ((state & mode) &&
-				try_to_wake_up(p, sync) &&
-				((curr->flags & WQ_FLAG_EXCLUSIVE) &&
-					!--nr_exclusive))
-			break;
+		if ((state & mode) && try_to_wake_up(p) &&
+			((curr->flags & WQ_FLAG_EXCLUSIVE) && !--nr_exclusive))
+				break;
 	}
 }

-void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr)
+void __wake_up(wait_queue_head_t *q, unsigned int mode, int nr_exclusive)
 {
-	if (q) {
-		unsigned long flags;
-		wq_read_lock_irqsave(&q->lock, flags);
-		__wake_up_common(q, mode, nr, 0);
-		wq_read_unlock_irqrestore(&q->lock, flags);
-	}
-}
+	unsigned long flags;

-void __wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr)
-{
-	if (q) {
-		unsigned long flags;
-		wq_read_lock_irqsave(&q->lock, flags);
-		__wake_up_common(q, mode, nr, 1);
-		wq_read_unlock_irqrestore(&q->lock, flags);
-	}
+	if (unlikely(!q))
+		return;
+
+	wq_read_lock_irqsave(&q->lock, flags);
+	__wake_up_common(q, mode, nr_exclusive);
+	wq_read_unlock_irqrestore(&q->lock, flags);
 }

 void complete(struct completion *x)
@@ -907,7 +885,7 @@

 	spin_lock_irqsave(&x->wait.lock, flags);
 	x->done++;
-	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1, 0);
+	__wake_up_common(&x->wait, TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1);
 	spin_unlock_irqrestore(&x->wait.lock, flags);
 }

@@ -994,35 +972,66 @@
 	return timeout;
 }

+void scheduling_functions_end_here(void) { }
+
+#if CONFIG_SMP
+
 /*
- * Change the current task's CPU affinity. Migrate the process to a
- * proper CPU and schedule away if the current CPU is removed from
- * the allowed bitmask.
+ * Change a given task's CPU affinity. Migrate the process to a
+ * proper CPU and schedule it away if the current CPU is removed
+ * from the allowed bitmask.
  */
 void set_cpus_allowed(task_t *p, unsigned long new_mask)
 {
+	unsigned long flags;
+	runqueue_t *rq;
+	int dest_cpu;
+
+	down(&p->migration_sem);
+	if (!list_empty(&p->migration_list))
+		BUG();
+
 	new_mask &= cpu_online_map;
 	if (!new_mask)
 		BUG();
-	if (p != current)
-		BUG();

+	rq = task_rq_lock(p, &flags);
 	p->cpus_allowed = new_mask;
 	/*
-	 * Can the task run on the current CPU? If not then
+	 * Can the task run on the task's current CPU? If not then
 	 * migrate the process off to a proper CPU.
 	 */
-	if (new_mask & (1UL << smp_processor_id()))
-		return;
-#if CONFIG_SMP
-	current->state = TASK_UNINTERRUPTIBLE;
-	smp_migrate_task(__ffs(new_mask), current);
+	if (new_mask & (1UL << p->thread_info->cpu)) {
+		task_rq_unlock(rq, &flags);
+		goto out;
+	}
+	/*
+	 * We mark the process as nonrunnable, and kick it to
+	 * schedule away from its current CPU. We also add
+	 * the task to the migration queue and wake up the
+	 * target CPU's migration thread, so that it can pick
+	 * up this task and insert it into the local runqueue.
+	 */
+	p->state = TASK_UNINTERRUPTIBLE;
+	kick_if_running(p);
+	task_rq_unlock(rq, &flags);

-	schedule();
-#endif
+	dest_cpu = __ffs(new_mask);
+	rq = cpu_rq(dest_cpu);
+
+	spin_lock_irq(&rq->lock);
+	list_add(&p->migration_list, &rq->migration_queue);
+	spin_unlock_irq(&rq->lock);
+	wake_up_process(rq->migration_thread);
+
+	while (!((1UL << p->thread_info->cpu) & p->cpus_allowed) &&
+			(p->state != TASK_ZOMBIE))
+		yield();
+out:
+	up(&p->migration_sem);
 }

-void scheduling_functions_end_here(void) { }
+#endif

 void set_user_nice(task_t *p, long nice)
 {
@@ -1036,7 +1045,7 @@
 	 * We have to be careful, if called from sys_setpriority(),
 	 * the task might be in the middle of scheduling on another CPU.
 	 */
-	rq = lock_task_rq(p, &flags);
+	rq = task_rq_lock(p, &flags);
 	if (rt_task(p)) {
 		p->static_prio = NICE_TO_PRIO(nice);
 		goto out_unlock;
@@ -1056,7 +1065,7 @@
 			resched_task(rq->curr);
 	}
 out_unlock:
-	unlock_task_rq(rq, &flags);
+	task_rq_unlock(rq, &flags);
 }

 #ifndef __alpha__
@@ -1154,7 +1163,7 @@
 	 * To be able to change p->policy safely, the apropriate
 	 * runqueue lock must be held.
 	 */
-	rq = lock_task_rq(p, &flags);
+	rq = task_rq_lock(p, &flags);

 	if (policy < 0)
 		policy = p->policy;
@@ -1197,7 +1206,7 @@
 		activate_task(p, task_rq(p));

 out_unlock:
-	unlock_task_rq(rq, &flags);
+	task_rq_unlock(rq, &flags);
 out_unlock_tasklist:
 	read_unlock_irq(&tasklist_lock);

@@ -1477,7 +1486,7 @@

 void __init init_idle(task_t *idle, int cpu)
 {
-	runqueue_t *idle_rq = cpu_rq(cpu), *rq = idle->array->rq;
+	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(idle->thread_info->cpu);
 	unsigned long flags;

 	__save_flags(flags);
@@ -1509,14 +1518,13 @@
 		runqueue_t *rq = cpu_rq(i);
 		prio_array_t *array;

-		rq->active = rq->arrays + 0;
+		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
+		INIT_LIST_HEAD(&rq->migration_queue);

 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;
-			array->rq = rq;
-			array->lock = &rq->lock;
 			for (k = 0; k < MAX_PRIO; k++) {
 				INIT_LIST_HEAD(array->queue + k);
 				__clear_bit(k, array->bitmap);
@@ -1545,3 +1553,104 @@
 	atomic_inc(&init_mm.mm_count);
 	enter_lazy_tlb(&init_mm, current, smp_processor_id());
 }
+
+#if CONFIG_SMP
+
+static volatile unsigned long migration_mask;
+
+static int migration_thread(void * unused)
+{
+	runqueue_t *rq;
+
+	daemonize();
+	sigfillset(&current->blocked);
+	set_user_nice(current, -20);
+
+	/*
+	 * We have to migrate manually - there is no migration thread
+	 * to do this for us yet :-)
+	 *
+	 * We use the following property of the Linux scheduler. At
+	 * this point no other task is running, so by keeping all
+	 * migration threads running, the load-balancer will distribute
+	 * them between all CPUs equally. At that point every migration
+	 * task binds itself to the current CPU.
+	 */
+
+	/* wait for all migration threads to start up. */
+	while (!migration_mask)
+		yield();
+
+	for (;;) {
+		preempt_disable();
+		if (test_and_clear_bit(smp_processor_id(), &migration_mask))
+			current->cpus_allowed = 1 << smp_processor_id();
+		if (test_thread_flag(TIF_NEED_RESCHED))
+			schedule();
+		if (!migration_mask)
+			break;
+		preempt_enable();
+	}
+	rq = this_rq();
+	rq->migration_thread = current;
+	preempt_enable();
+
+	sprintf(current->comm, "migration_CPU%d", smp_processor_id());
+
+	for (;;) {
+		struct list_head *head;
+		unsigned long flags;
+		task_t *p = NULL;
+
+		spin_lock_irqsave(&rq->lock, flags);
+		head = &rq->migration_queue;
+		if (list_empty(head)) {
+			current->state = TASK_UNINTERRUPTIBLE;
+			spin_unlock_irqrestore(&rq->lock, flags);
+			schedule();
+			continue;
+		}
+		p = list_entry(head->next, task_t, migration_list);
+		list_del_init(head->next);
+		spin_unlock_irqrestore(&rq->lock, flags);
+
+		for (;;) {
+			runqueue_t *rq2 = task_rq_lock(p, &flags);
+
+			if (!p->array) {
+				p->thread_info->cpu = smp_processor_id();
+				task_rq_unlock(rq2, &flags);
+				wake_up_process(p);
+				break;
+			}
+			if (p->state != TASK_UNINTERRUPTIBLE) {
+				p->state = TASK_UNINTERRUPTIBLE;
+				kick_if_running(p);
+			}
+			task_rq_unlock(rq2, &flags);
+			while ((p->state == TASK_UNINTERRUPTIBLE) && p->array) {
+				cpu_relax();
+				barrier();
+			}
+		}
+	}
+}
+
+void __init migration_init(void)
+{
+	int cpu;
+
+	for (cpu = 0; cpu < smp_num_cpus; cpu++)
+		if (kernel_thread(migration_thread, NULL,
+				CLONE_FS | CLONE_FILES | CLONE_SIGNAL) < 0)
+			BUG();
+
+	migration_mask = (1 << smp_num_cpus) -1;
+
+	for (cpu = 0; cpu < smp_num_cpus; cpu++)
+		while (!cpu_rq(cpu)->migration_thread)
+			yield();
+	if (migration_mask)
+		BUG();
+}
+#endif
--- linux/kernel/ksyms.c.orig	Thu Feb 21 10:24:02 2002
+++ linux/kernel/ksyms.c	Thu Feb 21 14:54:32 2002
@@ -443,7 +443,6 @@
 /* process management */
 EXPORT_SYMBOL(complete_and_exit);
 EXPORT_SYMBOL(__wake_up);
-EXPORT_SYMBOL(__wake_up_sync);
 EXPORT_SYMBOL(wake_up_process);
 EXPORT_SYMBOL(sleep_on);
 EXPORT_SYMBOL(sleep_on_timeout);
@@ -458,6 +457,9 @@
 EXPORT_SYMBOL(set_user_nice);
 EXPORT_SYMBOL(task_nice);
 EXPORT_SYMBOL_GPL(idle_cpu);
+#ifdef CONFIG_SMP
+EXPORT_SYMBOL_GPL(set_cpus_allowed);
+#endif
 EXPORT_SYMBOL(jiffies);
 EXPORT_SYMBOL(xtime);
 EXPORT_SYMBOL(do_gettimeofday);
--- linux/include/linux/sched.h.orig	Thu Feb 21 10:23:49 2002
+++ linux/include/linux/sched.h	Thu Feb 21 14:51:25 2002
@@ -150,8 +150,7 @@
 extern void update_one_process(struct task_struct *p, unsigned long user,
 			       unsigned long system, int cpu);
 extern void scheduler_tick(int user_tick, int system);
-extern void sched_task_migrated(struct task_struct *p);
-extern void smp_migrate_task(int cpu, task_t *task);
+extern void migration_init(void);
 extern unsigned long cache_decay_ticks;


@@ -286,6 +285,10 @@

 	wait_queue_head_t wait_chldexit;	/* for wait4() */
 	struct completion *vfork_done;		/* for vfork() */
+
+	list_t migration_list;
+	struct semaphore migration_sem;
+
 	unsigned long rt_priority;
 	unsigned long it_real_value, it_prof_value, it_virt_value;
 	unsigned long it_real_incr, it_prof_incr, it_virt_incr;
@@ -382,7 +385,12 @@
  */
 #define _STK_LIM	(8*1024*1024)

+#if CONFIG_SMP
 extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+#else
+# define set_cpus_allowed(p, new_mask) do { } while (0)
+#endif
+
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
@@ -460,7 +468,6 @@
 extern unsigned long prof_shift;

 extern void FASTCALL(__wake_up(wait_queue_head_t *q, unsigned int mode, int nr));
-extern void FASTCALL(__wake_up_sync(wait_queue_head_t *q, unsigned int mode, int nr));
 extern void FASTCALL(sleep_on(wait_queue_head_t *q));
 extern long FASTCALL(sleep_on_timeout(wait_queue_head_t *q,
 				      signed long timeout));
@@ -474,13 +481,9 @@
 #define wake_up(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
 #define wake_up_nr(x, nr)		__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
 #define wake_up_all(x)			__wake_up((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 0)
-#define wake_up_sync(x)			__wake_up_sync((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, 1)
-#define wake_up_sync_nr(x, nr)		__wake_up_sync((x),TASK_UNINTERRUPTIBLE | TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible(x)	__wake_up((x),TASK_INTERRUPTIBLE, 1)
 #define wake_up_interruptible_nr(x, nr)	__wake_up((x),TASK_INTERRUPTIBLE, nr)
 #define wake_up_interruptible_all(x)	__wake_up((x),TASK_INTERRUPTIBLE, 0)
-#define wake_up_interruptible_sync(x)	__wake_up_sync((x),TASK_INTERRUPTIBLE, 1)
-#define wake_up_interruptible_sync_nr(x) __wake_up_sync((x),TASK_INTERRUPTIBLE,  nr)
 asmlinkage long sys_wait4(pid_t pid,unsigned int * stat_addr, int options, struct rusage * ru);

 extern int in_group_p(gid_t);
--- linux/include/linux/init_task.h.orig	Thu Feb 21 11:52:54 2002
+++ linux/include/linux/init_task.h	Thu Feb 21 14:51:35 2002
@@ -52,6 +52,8 @@
     mm:			NULL,						\
     active_mm:		&init_mm,					\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
+    migration_list:	LIST_HEAD_INIT(tsk.migration_list),		\
+    migration_sem:	__MUTEX_INITIALIZER(tsk.migration_sem),		\
     time_slice:		HZ,						\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
--- linux/include/asm-i386/hw_irq.h.orig	Thu Feb 21 13:18:29 2002
+++ linux/include/asm-i386/hw_irq.h	Thu Feb 21 14:51:25 2002
@@ -35,14 +35,13 @@
  *  into a single vector (CALL_FUNCTION_VECTOR) to save vector space.
  *  TLB, reschedule and local APIC vectors are performance-critical.
  *
- *  Vectors 0xf0-0xf9 are free (reserved for future Linux use).
+ *  Vectors 0xf0-0xfa are free (reserved for future Linux use).
  */
 #define SPURIOUS_APIC_VECTOR	0xff
 #define ERROR_APIC_VECTOR	0xfe
 #define INVALIDATE_TLB_VECTOR	0xfd
 #define RESCHEDULE_VECTOR	0xfc
-#define TASK_MIGRATION_VECTOR	0xfb
-#define CALL_FUNCTION_VECTOR	0xfa
+#define CALL_FUNCTION_VECTOR	0xfb

 /*
  * Local APIC timer IRQ vector is on a different priority level,
--- linux/arch/i386/kernel/i8259.c.orig	Thu Feb 21 13:18:08 2002
+++ linux/arch/i386/kernel/i8259.c	Thu Feb 21 13:18:16 2002
@@ -79,7 +79,6 @@
  * through the ICC by us (IPIs)
  */
 #ifdef CONFIG_SMP
-BUILD_SMP_INTERRUPT(task_migration_interrupt,TASK_MIGRATION_VECTOR)
 BUILD_SMP_INTERRUPT(reschedule_interrupt,RESCHEDULE_VECTOR)
 BUILD_SMP_INTERRUPT(invalidate_interrupt,INVALIDATE_TLB_VECTOR)
 BUILD_SMP_INTERRUPT(call_function_interrupt,CALL_FUNCTION_VECTOR)
@@ -473,9 +472,6 @@
 	 * IPI, driven by wakeup.
 	 */
 	set_intr_gate(RESCHEDULE_VECTOR, reschedule_interrupt);
-
-	/* IPI for task migration */
-	set_intr_gate(TASK_MIGRATION_VECTOR, task_migration_interrupt);

 	/* IPI for invalidation */
 	set_intr_gate(INVALIDATE_TLB_VECTOR, invalidate_interrupt);
--- linux/arch/i386/kernel/smp.c.orig	Thu Feb 21 13:17:50 2002
+++ linux/arch/i386/kernel/smp.c	Thu Feb 21 13:18:01 2002
@@ -485,35 +485,6 @@
 	do_flush_tlb_all_local();
 }

-static spinlock_t migration_lock = SPIN_LOCK_UNLOCKED;
-static task_t *new_task;
-
-/*
- * This function sends a 'task migration' IPI to another CPU.
- * Must be called from syscall contexts, with interrupts *enabled*.
- */
-void smp_migrate_task(int cpu, task_t *p)
-{
-	/*
-	 * The target CPU will unlock the migration spinlock:
-	 */
-	_raw_spin_lock(&migration_lock);
-	new_task = p;
-	send_IPI_mask(1 << cpu, TASK_MIGRATION_VECTOR);
-}
-
-/*
- * Task migration callback.
- */
-asmlinkage void smp_task_migration_interrupt(void)
-{
-	task_t *p;
-
-	ack_APIC_irq();
-	p = new_task;
-	_raw_spin_unlock(&migration_lock);
-	sched_task_migrated(p);
-}
 /*
  * this function sends a 'reschedule' IPI to another CPU.
  * it goes straight through and wastes no time serializing

