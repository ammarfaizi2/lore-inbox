Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317512AbSGTVKx>; Sat, 20 Jul 2002 17:10:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317517AbSGTVKu>; Sat, 20 Jul 2002 17:10:50 -0400
Received: from mx2.elte.hu ([157.181.151.9]:59306 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S317512AbSGTVKm>;
	Sat, 20 Jul 2002 17:10:42 -0400
Date: Sat, 20 Jul 2002 23:12:28 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: [patch] scheduler bits for 2.5.27
Message-ID: <Pine.LNX.4.44.0207202304070.27008-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


The attached patch is my current 'fixes and cleanups' scheduler tree
against 2.5.27, with the batch-scheduling bits removed for the time being,
until the lowlevel entry.S cleanups are finished. Changelog:

 - introduce the default context-switch locking macros.

 - introduce the task_running() macro which can differ depending on the
   type of context-switch locking.

 - Scott Rhine: add comment to try_to_wake_up.

 - remove obsolete comment.

 - sched_exit() adds timeslices to the parent only if the exiting
   child was still using up its first timeslice.

 - simpler locking in schedule_tail().

 - load_balance() cleanup: split up into find_busiest_queue(),
   pull_task() and load_balance() functions.

 - load_balance() bug noticed by Scott Rhine and myself: scan the
   whole list to find imbalance number of tasks, not just the tail
   of the list.

 - idle_tick() cleanups: use a parameter already existing in the
   calling function.

 - scheduler_tick() cleanups: use more intuitive variable names.

 - clear ->first_time_slice when a new timeslice is calculated.

 - sched_yield() cleanup and simplification: yielding puts the task
   into the expired queue. This eliminates spurious yields in which
   the same task repeatedly calls into yield() without achieving
   anything. It's also the most logical thing to do - the yielder
   has asked for other tasks to be scheduled first.

 - sched_yield() fix: use current->array not rq->active.

 - move the sched initialization code to the end of sched.c.

 - no need for nr_uninterruptible to be signed.

	Ingo

diff -Nru a/include/asm-i386/system.h b/include/asm-i386/system.h
--- a/include/asm-i386/system.h	Sat Jul 20 23:03:53 2002
+++ b/include/asm-i386/system.h	Sat Jul 20 23:03:53 2002
@@ -11,11 +11,6 @@
 struct task_struct;	/* one of the stranger aspects of C forward declarations.. */
 extern void FASTCALL(__switch_to(struct task_struct *prev, struct task_struct *next));
 
-#define prepare_arch_schedule(prev)		do { } while(0)
-#define finish_arch_schedule(prev)		do { } while(0)
-#define prepare_arch_switch(rq)			do { } while(0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
-
 #define switch_to(prev,next,last) do {					\
 	asm volatile("pushl %%esi\n\t"					\
 		     "pushl %%edi\n\t"					\
diff -Nru a/include/asm-ppc/system.h b/include/asm-ppc/system.h
--- a/include/asm-ppc/system.h	Sat Jul 20 23:03:53 2002
+++ b/include/asm-ppc/system.h	Sat Jul 20 23:03:53 2002
@@ -83,11 +83,6 @@
 struct device_node;
 extern void note_scsi_host(struct device_node *, void *);
 
-#define prepare_arch_schedule(prev)		do { } while(0)
-#define finish_arch_schedule(prev)		do { } while(0)
-#define prepare_arch_switch(rq)			do { } while(0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
-
 struct task_struct;
 extern void __switch_to(struct task_struct *, struct task_struct *);
 #define switch_to(prev, next, last)	__switch_to((prev), (next))
diff -Nru a/include/asm-s390/system.h b/include/asm-s390/system.h
--- a/include/asm-s390/system.h	Sat Jul 20 23:03:53 2002
+++ b/include/asm-s390/system.h	Sat Jul 20 23:03:53 2002
@@ -18,11 +18,6 @@
 #endif
 #include <linux/kernel.h>
 
-#define prepare_arch_schedule(prev)		do { } while (0)
-#define finish_arch_schedule(prev)		do { } while (0)
-#define prepare_arch_switch(rq)			do { } while (0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
-
 #define switch_to(prev,next,last) do {					     \
 	if (prev == next)						     \
 		break;							     \
diff -Nru a/include/asm-s390x/system.h b/include/asm-s390x/system.h
--- a/include/asm-s390x/system.h	Sat Jul 20 23:03:53 2002
+++ b/include/asm-s390x/system.h	Sat Jul 20 23:03:53 2002
@@ -18,11 +18,6 @@
 #endif
 #include <linux/kernel.h>
 
-#define prepare_arch_schedule(prev)		do { } while (0)
-#define finish_arch_schedule(prev)		do { } while (0)
-#define prepare_arch_switch(rq)			do { } while (0)
-#define finish_arch_switch(rq)			spin_unlock_irq(&(rq)->lock)
-
 #define switch_to(prev,next),last do {					     \
 	if (prev == next)						     \
 		break;							     \
diff -Nru a/include/asm-sparc64/system.h b/include/asm-sparc64/system.h
--- a/include/asm-sparc64/system.h	Sat Jul 20 23:03:53 2002
+++ b/include/asm-sparc64/system.h	Sat Jul 20 23:03:53 2002
@@ -144,13 +144,15 @@
 #define flush_user_windows flushw_user
 #define flush_register_windows flushw_all
 
-#define prepare_arch_schedule(prev)	task_lock(prev)
-#define finish_arch_schedule(prev)	task_unlock(prev)
-#define prepare_arch_switch(rq)		\
-do {	spin_unlock(&(rq)->lock);	\
-	flushw_all();			\
+#define prepare_arch_switch(rq, next)		\
+do {	spin_lock(&(next)->switch_lock);	\
+	spin_unlock(&(rq)->lock);		\
+	flushw_all();				\
+} while (0)
+
+#define finish_arch_switch(rq, prev)		\
+do {	spin_unlock_irq(&(prev)->switch_lock);	\
 } while (0)
-#define finish_arch_switch(rq)		__sti()
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 #define CHECK_LOCKS(PREV)	do { } while(0)
diff -Nru a/include/asm-x86_64/system.h b/include/asm-x86_64/system.h
--- a/include/asm-x86_64/system.h	Sat Jul 20 23:03:53 2002
+++ b/include/asm-x86_64/system.h	Sat Jul 20 23:03:53 2002
@@ -13,11 +13,6 @@
 #define LOCK_PREFIX ""
 #endif
 
-#define prepare_arch_schedule(prev)            do { } while(0)
-#define finish_arch_schedule(prev)             do { } while(0)
-#define prepare_arch_switch(rq)                        do { } while(0)
-#define finish_arch_switch(rq)                 spin_unlock_irq(&(rq)->lock)
-
 #define __STR(x) #x
 #define STR(x) __STR(x)
 
diff -Nru a/include/linux/init_task.h b/include/linux/init_task.h
--- a/include/linux/init_task.h	Sat Jul 20 23:03:53 2002
+++ b/include/linux/init_task.h	Sat Jul 20 23:03:53 2002
@@ -78,6 +78,7 @@
     pending:		{ NULL, &tsk.pending.head, {{0}}},		\
     blocked:		{{0}},						\
     alloc_lock:		SPIN_LOCK_UNLOCKED,				\
+    switch_lock:	SPIN_LOCK_UNLOCKED,				\
     journal_info:	NULL,						\
 }
 
diff -Nru a/include/linux/sched.h b/include/linux/sched.h
--- a/include/linux/sched.h	Sat Jul 20 23:03:53 2002
+++ b/include/linux/sched.h	Sat Jul 20 23:03:53 2002
@@ -264,7 +264,7 @@
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
-	unsigned int time_slice;
+	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
 
@@ -361,6 +361,8 @@
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+/* context-switch lock */
+	spinlock_t switch_lock;
 
 /* journalling filesystem info */
 	void *journal_info;
diff -Nru a/kernel/fork.c b/kernel/fork.c
--- a/kernel/fork.c	Sat Jul 20 23:03:53 2002
+++ b/kernel/fork.c	Sat Jul 20 23:03:53 2002
@@ -611,7 +611,6 @@
 			    unsigned long stack_size)
 {
 	int retval;
-	unsigned long flags;
 	struct task_struct *p = NULL;
 	struct completion vfork;
 
@@ -675,6 +674,7 @@
 		init_completion(&vfork);
 	}
 	spin_lock_init(&p->alloc_lock);
+	spin_lock_init(&p->switch_lock);
 
 	clear_tsk_thread_flag(p,TIF_SIGPENDING);
 	init_sigpending(&p->pending);
@@ -740,9 +740,13 @@
 	 * total amount of pending timeslices in the system doesnt change,
 	 * resulting in more scheduling fairness.
 	 */
-	__save_flags(flags);
 	__cli();
 	p->time_slice = (current->time_slice + 1) >> 1;
+	/*
+	 * The remainder of the first timeslice might be recovered by
+	 * the parent if the child exits early enough.
+	 */
+	p->first_time_slice = 1;
 	current->time_slice >>= 1;
 	if (!current->time_slice) {
 		/*
@@ -754,7 +758,7 @@
 		scheduler_tick(0, 0);
 	}
 	p->sleep_timestamp = jiffies;
-	__restore_flags(flags);
+	__sti();
 
 	/*
 	 * Ok, add it to the run-queues and make it
diff -Nru a/kernel/sched.c b/kernel/sched.c
--- a/kernel/sched.c	Sat Jul 20 23:03:53 2002
+++ b/kernel/sched.c	Sat Jul 20 23:03:53 2002
@@ -136,8 +136,8 @@
  */
 struct runqueue {
 	spinlock_t lock;
-	unsigned long nr_running, nr_switches, expired_timestamp;
-	signed long nr_uninterruptible;
+	unsigned long nr_running, nr_switches, expired_timestamp,
+			nr_uninterruptible;
 	task_t *curr, *idle;
 	prio_array_t *active, *expired, arrays[2];
 	int prev_nr_running[NR_CPUS];
@@ -154,6 +154,15 @@
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
 /*
+ * Default context-switch locking:
+ */
+#ifndef prepare_arch_switch
+# define prepare_arch_switch(rq, next)	do { } while(0)
+# define finish_arch_switch(rq, next)	spin_unlock_irq(&(rq)->lock)
+# define task_running(rq, p)		((rq)->curr == (p))
+#endif
+
+/*
  * task_rq_lock - lock the runqueue a given task resides on and disable
  * interrupts.  Note the ordering: we can safely lookup the task_rq without
  * explicitly disabling preemption.
@@ -307,7 +316,7 @@
 repeat:
 	preempt_disable();
 	rq = task_rq(p);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(task_running(rq, p))) {
 		cpu_relax();
 		/*
 		 * enable/disable preemption just to make this
@@ -318,7 +327,7 @@
 		goto repeat;
 	}
 	rq = task_rq_lock(p, &flags);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(task_running(rq, p))) {
 		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
@@ -338,7 +347,7 @@
  */
 void kick_if_running(task_t * p)
 {
-	if (p == task_rq(p)->curr)
+	if (task_running(task_rq(p), p))
 		resched_task(p);
 }
 #endif
@@ -350,6 +359,8 @@
  * progress), and as such you're allowed to do the simpler
  * "current->state = TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
+ *
+ * returns failure only if the task is already active.
  */
 static int try_to_wake_up(task_t * p, int sync)
 {
@@ -366,7 +377,7 @@
 		 * Fast-migrate the task if it's not running or runnable
 		 * currently. Do not violate hard affinity.
 		 */
-		if (unlikely(sync && (rq->curr != p) &&
+		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
 			(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
@@ -377,9 +388,7 @@
 		if (old_state == TASK_UNINTERRUPTIBLE)
 			rq->nr_uninterruptible--;
 		activate_task(p, rq);
-		/*
-		 * If sync is set, a resched_task() is a NOOP
-		 */
+
 		if (p->prio < rq->curr->prio)
 			resched_task(rq->curr);
 		success = 1;
@@ -428,9 +437,11 @@
 void sched_exit(task_t * p)
 {
 	__cli();
-	current->time_slice += p->time_slice;
-	if (unlikely(current->time_slice > MAX_TIMESLICE))
-		current->time_slice = MAX_TIMESLICE;
+	if (p->first_time_slice) {
+		current->time_slice += p->time_slice;
+		if (unlikely(current->time_slice > MAX_TIMESLICE))
+			current->time_slice = MAX_TIMESLICE;
+	}
 	__sti();
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
@@ -444,8 +455,7 @@
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
-	finish_arch_switch(this_rq());
-	finish_arch_schedule(prev);
+	finish_arch_switch(this_rq(), prev);
 }
 #endif
 
@@ -502,7 +512,42 @@
 	return sum;
 }
 
+/*
+ * double_rq_lock - safely lock two runqueues
+ *
+ * Note this does not disable interrupts like task_rq_lock,
+ * you need to do so manually before calling.
+ */
+static inline void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
+{
+	if (rq1 == rq2)
+		spin_lock(&rq1->lock);
+	else {
+		if (rq1 < rq2) {
+			spin_lock(&rq1->lock);
+			spin_lock(&rq2->lock);
+		} else {
+			spin_lock(&rq2->lock);
+			spin_lock(&rq1->lock);
+		}
+	}
+}
+
+/*
+ * double_rq_unlock - safely unlock two runqueues
+ *
+ * Note this does not restore interrupts like task_rq_unlock,
+ * you need to do so manually after calling.
+ */
+static inline void double_rq_unlock(runqueue_t *rq1, runqueue_t *rq2)
+{
+	spin_unlock(&rq1->lock);
+	if (rq1 != rq2)
+		spin_unlock(&rq2->lock);
+}
+
 #if CONFIG_SMP
+
 /*
  * Lock the busiest runqueue as well, this_rq is locked already.
  * Recalculate nr_running if we have to drop the runqueue lock.
@@ -526,22 +571,10 @@
 	return nr_running;
 }
 
-/*
- * Current runqueue is empty, or rebalance tick: if there is an
- * inbalance (current runqueue is too short) then pull from
- * busiest runqueue(s).
- *
- * We call this with the current runqueue locked,
- * irqs disabled.
- */
-static void load_balance(runqueue_t *this_rq, int idle)
+static inline runqueue_t *find_busiest_queue(runqueue_t *this_rq, int this_cpu, int idle, int *imbalance)
 {
-	int imbalance, nr_running, load, max_load,
-		idx, i, this_cpu = smp_processor_id();
-	task_t *next = this_rq->idle, *tmp;
+	int nr_running, load, max_load, i;
 	runqueue_t *busiest, *rq_src;
-	prio_array_t *array;
-	list_t *head, *curr;
 
 	/*
 	 * We search all runqueues to find the most busy one.
@@ -590,21 +623,67 @@
 	}
 
 	if (likely(!busiest))
-		return;
+		goto out;
 
-	imbalance = (max_load - nr_running) / 2;
+	*imbalance = (max_load - nr_running) / 2;
 
 	/* It needs an at least ~25% imbalance to trigger balancing. */
-	if (!idle && (imbalance < (max_load + 3)/4))
-		return;
+	if (!idle && (*imbalance < (max_load + 3)/4)) {
+		busiest = NULL;
+		goto out;
+	}
 
 	nr_running = double_lock_balance(this_rq, busiest, this_cpu, idle, nr_running);
 	/*
 	 * Make sure nothing changed since we checked the
 	 * runqueue length.
 	 */
-	if (busiest->nr_running <= nr_running + 1)
-		goto out_unlock;
+	if (busiest->nr_running <= nr_running + 1) {
+		spin_unlock(&busiest->lock);
+		busiest = NULL;
+	}
+out:
+	return busiest;
+}
+
+/*
+ * Move a task from a remote runqueue to the local runqueue.
+ * Both runqueues must be locked.
+ */
+static inline void pull_task(runqueue_t *src_rq, prio_array_t *src_array, task_t *p, runqueue_t *this_rq, int this_cpu)
+{
+	dequeue_task(p, src_array);
+	src_rq->nr_running--;
+	set_task_cpu(p, this_cpu);
+	this_rq->nr_running++;
+	enqueue_task(p, this_rq->active);
+	/*
+	 * Note that idle threads have a prio of MAX_PRIO, for this test
+	 * to be always true for them.
+	 */
+	if (p->prio < this_rq->curr->prio)
+		set_need_resched();
+}
+
+/*
+ * Current runqueue is empty, or rebalance tick: if there is an
+ * inbalance (current runqueue is too short) then pull from
+ * busiest runqueue(s).
+ *
+ * We call this with the current runqueue locked,
+ * irqs disabled.
+ */
+static void load_balance(runqueue_t *this_rq, int idle)
+{
+	int imbalance, idx, this_cpu = smp_processor_id();
+	runqueue_t *busiest;
+	prio_array_t *array;
+	list_t *head, *curr;
+	task_t *tmp;
+
+	busiest = find_busiest_queue(this_rq, this_cpu, idle, &imbalance);
+	if (!busiest)
+		goto out;
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -647,36 +726,28 @@
 
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
-		((p) != (rq)->curr) &&					\
+		!task_running(rq, p) &&					\
 			((p)->cpus_allowed & (1UL << (this_cpu))))
 
+	curr = curr->prev;
+
 	if (!CAN_MIGRATE_TASK(tmp, busiest, this_cpu)) {
-		curr = curr->next;
 		if (curr != head)
 			goto skip_queue;
 		idx++;
 		goto skip_bitmap;
 	}
-	next = tmp;
-	/*
-	 * take the task out of the other runqueue and
-	 * put it into this one:
-	 */
-	dequeue_task(next, array);
-	busiest->nr_running--;
-	set_task_cpu(next, this_cpu);
-	this_rq->nr_running++;
-	enqueue_task(next, this_rq->active);
-	if (next->prio < current->prio)
-		set_need_resched();
+	pull_task(busiest, array, tmp, this_rq, this_cpu);
 	if (!idle && --imbalance) {
-		if (array == busiest->expired) {
-			array = busiest->active;
-			goto new_array;
-		}
+		if (curr != head)
+			goto skip_queue;
+		idx++;
+		goto skip_bitmap;
 	}
 out_unlock:
 	spin_unlock(&busiest->lock);
+out:
+	;
 }
 
 /*
@@ -691,13 +762,13 @@
 #define BUSY_REBALANCE_TICK (HZ/4 ?: 1)
 #define IDLE_REBALANCE_TICK (HZ/1000 ?: 1)
 
-static inline void idle_tick(void)
+static inline void idle_tick(runqueue_t *rq)
 {
 	if (jiffies % IDLE_REBALANCE_TICK)
 		return;
-	spin_lock(&this_rq()->lock);
-	load_balance(this_rq(), 1);
-	spin_unlock(&this_rq()->lock);
+	spin_lock(&rq->lock);
+	load_balance(rq, 1);
+	spin_unlock(&rq->lock);
 }
 
 #endif
@@ -720,7 +791,7 @@
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
-void scheduler_tick(int user_tick, int system)
+void scheduler_tick(int user_ticks, int sys_ticks)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
@@ -728,17 +799,17 @@
 
 	if (p == rq->idle) {
 		if (local_bh_count(cpu) || local_irq_count(cpu) > 1)
-			kstat.per_cpu_system[cpu] += system;
+			kstat.per_cpu_system[cpu] += sys_ticks;
 #if CONFIG_SMP
-		idle_tick();
+		idle_tick(rq);
 #endif
 		return;
 	}
 	if (TASK_NICE(p) > 0)
-		kstat.per_cpu_nice[cpu] += user_tick;
+		kstat.per_cpu_nice[cpu] += user_ticks;
 	else
-		kstat.per_cpu_user[cpu] += user_tick;
-	kstat.per_cpu_system[cpu] += system;
+		kstat.per_cpu_user[cpu] += user_ticks;
+	kstat.per_cpu_system[cpu] += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
@@ -753,6 +824,7 @@
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
 			p->time_slice = TASK_TIMESLICE(p);
+			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -776,6 +848,7 @@
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = TASK_TIMESLICE(p);
+		p->first_time_slice = 0;
 
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
@@ -817,7 +890,6 @@
 	rq = this_rq();
 
 	release_kernel_lock(prev, smp_processor_id());
-	prepare_arch_schedule(prev);
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 
@@ -874,14 +946,13 @@
 		rq->nr_switches++;
 		rq->curr = next;
 	
-		prepare_arch_switch(rq);
+		prepare_arch_switch(rq, next);
 		prev = context_switch(prev, next);
 		barrier();
 		rq = this_rq();
-		finish_arch_switch(rq);
+		finish_arch_switch(rq, prev);
 	} else
 		spin_unlock_irq(&rq->lock);
-	finish_arch_schedule(prev);
 
 	reacquire_kernel_lock(current);
 	preempt_enable_no_resched();
@@ -1107,7 +1178,8 @@
 		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) || (p == rq->curr))
+		if ((NICE_TO_PRIO(nice) < p->static_prio) ||
+							task_running(rq, p))
 			resched_task(rq->curr);
 	}
 out_unlock:
@@ -1432,39 +1504,18 @@
 	prio_array_t *array = current->array;
 
 	/*
-	 * There are three levels of how a yielding task will give up
-	 * the current CPU:
-	 *
-	 *  #1 - it decreases its priority by one. This priority loss is
-	 *       temporary, it's recovered once the current timeslice
-	 *       expires.
+	 * We implement yielding by moving the task into the expired
+	 * queue.
 	 *
-	 *  #2 - once it has reached the lowest priority level,
-	 *       it will give up timeslices one by one. (We do not
-	 *       want to give them up all at once, it's gradual,
-	 *       to protect the casual yield()er.)
-	 *
-	 *  #3 - once all timeslices are gone we put the process into
-	 *       the expired array.
-	 *
-	 *  (special rule: RT tasks do not lose any priority, they just
-	 *  roundrobin on their current priority level.)
+	 * (special rule: RT tasks will just roundrobin in the active
+	 *  array.)
 	 */
-	if (likely(current->prio == MAX_PRIO-1)) {
-		if (current->time_slice <= 1) {
-			dequeue_task(current, rq->active);
-			enqueue_task(current, rq->expired);
-		} else
-			current->time_slice--;
-	} else if (unlikely(rt_task(current))) {
-		list_move_tail(&current->run_list, array->queue + current->prio);
+	if (likely(!rt_task(current))) {
+		dequeue_task(current, array);
+		enqueue_task(current, rq->expired);
 	} else {
 		list_del(&current->run_list);
-		if (list_empty(array->queue + current->prio))
-			__clear_bit(current->prio, array->bitmap);
-		current->prio++;
 		list_add_tail(&current->run_list, array->queue + current->prio);
-		__set_bit(current->prio, array->bitmap);
 	}
 	spin_unlock_no_resched(&rq->lock);
 
@@ -1640,40 +1691,6 @@
 	read_unlock(&tasklist_lock);
 }
 
-/*
- * double_rq_lock - safely lock two runqueues
- *
- * Note this does not disable interrupts like task_rq_lock,
- * you need to do so manually before calling.
- */
-static inline void double_rq_lock(runqueue_t *rq1, runqueue_t *rq2)
-{
-	if (rq1 == rq2)
-		spin_lock(&rq1->lock);
-	else {
-		if (rq1 < rq2) {
-			spin_lock(&rq1->lock);
-			spin_lock(&rq2->lock);
-		} else {
-			spin_lock(&rq2->lock);
-			spin_lock(&rq1->lock);
-		}
-	}
-}
-
-/*
- * double_rq_unlock - safely unlock two runqueues
- *
- * Note this does not restore interrupts like task_rq_unlock,
- * you need to do so manually after calling.
- */
-static inline void double_rq_unlock(runqueue_t *rq1, runqueue_t *rq2)
-{
-	spin_unlock(&rq1->lock);
-	if (rq1 != rq2)
-		spin_unlock(&rq2->lock);
-}
-
 void __init init_idle(task_t *idle, int cpu)
 {
 	runqueue_t *idle_rq = cpu_rq(cpu), *rq = cpu_rq(task_cpu(idle));
@@ -1697,57 +1714,6 @@
 	idle->thread_info->preempt_count = (idle->lock_depth >= 0);
 }
 
-extern void init_timervecs(void);
-extern void timer_bh(void);
-extern void tqueue_bh(void);
-extern void immediate_bh(void);
-
-void __init sched_init(void)
-{
-	runqueue_t *rq;
-	int i, j, k;
-
-	for (i = 0; i < NR_CPUS; i++) {
-		prio_array_t *array;
-
-		rq = cpu_rq(i);
-		rq->active = rq->arrays;
-		rq->expired = rq->arrays + 1;
-		spin_lock_init(&rq->lock);
-		INIT_LIST_HEAD(&rq->migration_queue);
-
-		for (j = 0; j < 2; j++) {
-			array = rq->arrays + j;
-			for (k = 0; k < MAX_PRIO; k++) {
-				INIT_LIST_HEAD(array->queue + k);
-				__clear_bit(k, array->bitmap);
-			}
-			// delimiter for bitsearch
-			__set_bit(MAX_PRIO, array->bitmap);
-		}
-	}
-	/*
-	 * We have to do a little magic to get the first
-	 * process right in SMP mode.
-	 */
-	rq = this_rq();
-	rq->curr = current;
-	rq->idle = current;
-	set_task_cpu(current, smp_processor_id());
-	wake_up_process(current);
-
-	init_timervecs();
-	init_bh(TIMER_BH, timer_bh);
-	init_bh(TQUEUE_BH, tqueue_bh);
-	init_bh(IMMEDIATE_BH, immediate_bh);
-
-	/*
-	 * The boot idle thread does lazy MMU switching as well:
-	 */
-	atomic_inc(&init_mm.mm_count);
-	enter_lazy_tlb(&init_mm, current, smp_processor_id());
-}
-
 #if CONFIG_SMP
 
 /*
@@ -1806,7 +1772,7 @@
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && (p != rq->curr)) {
+	if (!p->array && !task_running(rq, p)) {
 		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;
@@ -1924,3 +1890,55 @@
 	}
 }
 #endif
+
+extern void init_timervecs(void);
+extern void timer_bh(void);
+extern void tqueue_bh(void);
+extern void immediate_bh(void);
+
+void __init sched_init(void)
+{
+	runqueue_t *rq;
+	int i, j, k;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		prio_array_t *array;
+
+		rq = cpu_rq(i);
+		rq->active = rq->arrays;
+		rq->expired = rq->arrays + 1;
+		spin_lock_init(&rq->lock);
+		INIT_LIST_HEAD(&rq->migration_queue);
+
+		for (j = 0; j < 2; j++) {
+			array = rq->arrays + j;
+			for (k = 0; k < MAX_PRIO; k++) {
+				INIT_LIST_HEAD(array->queue + k);
+				__clear_bit(k, array->bitmap);
+			}
+			// delimiter for bitsearch
+			__set_bit(MAX_PRIO, array->bitmap);
+		}
+	}
+	/*
+	 * We have to do a little magic to get the first
+	 * process right in SMP mode.
+	 */
+	rq = this_rq();
+	rq->curr = current;
+	rq->idle = current;
+	set_task_cpu(current, smp_processor_id());
+	wake_up_process(current);
+
+	init_timervecs();
+	init_bh(TIMER_BH, timer_bh);
+	init_bh(TQUEUE_BH, tqueue_bh);
+	init_bh(IMMEDIATE_BH, immediate_bh);
+
+	/*
+	 * The boot idle thread does lazy MMU switching as well:
+	 */
+	atomic_inc(&init_mm.mm_count);
+	enter_lazy_tlb(&init_mm, current, smp_processor_id());
+}
+

