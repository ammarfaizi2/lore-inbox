Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316906AbSGSRnZ>; Fri, 19 Jul 2002 13:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316912AbSGSRnZ>; Fri, 19 Jul 2002 13:43:25 -0400
Received: from mx2.elte.hu ([157.181.151.9]:33448 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S316906AbSGSRm6>;
	Fri, 19 Jul 2002 13:42:58 -0400
Date: Sat, 20 Jul 2002 19:43:38 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Erich Focht <efocht@ess.nec.de>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       linux-ia64 <linux-ia64@linuxia64.org>
Subject: Re: [PATCH]: scheduler complex macros fixes
In-Reply-To: <Pine.LNX.4.44.0207191025410.8500-100000@home.transmeta.com>
Message-ID: <Pine.LNX.4.44.0207201937330.18265-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 19 Jul 2002, Linus Torvalds wrote:

> So I'd rather have the non-batch stuff done first and independently.

sure - all the non-batch bits are attached, against 2.5.26-vanilla. It
compiles & boots just fine on UP & SMP as well.

	Ingo

--- linux/include/linux/sched.h.orig	Fri Jul 19 19:31:31 2002
+++ linux/include/linux/sched.h	Fri Jul 19 19:38:48 2002
@@ -116,10 +116,11 @@
 /*
  * Scheduling policies
  */
-#define SCHED_OTHER		0
+#define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
 
+
 struct sched_param {
 	int sched_priority;
 };
@@ -207,7 +209,7 @@
 
 /*
  * Priority of a process goes from 0..MAX_PRIO-1, valid RT
- * priority is 0..MAX_RT_PRIO-1, and SCHED_OTHER tasks are
+ * priority is 0..MAX_RT_PRIO-1, and SCHED_NORMAL tasks are
  * in the range MAX_RT_PRIO..MAX_PRIO-1. Priority values
  * are inverted: lower p->prio value means higher priority.
  *
@@ -264,7 +266,7 @@
 
 	unsigned long policy;
 	unsigned long cpus_allowed;
-	unsigned int time_slice;
+	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
 
@@ -359,6 +361,8 @@
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+/* context-switch lock */
+	spinlock_t switch_lock;
 
 /* journalling filesystem info */
 	void *journal_info;
@@ -391,6 +395,7 @@
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
 #define PF_FROZEN	0x00040000	/* frozen for system suspend */
 #define PF_INVALIDATE	0x00080000	/* debug: unmounting an fs. killme. */
+
 /*
  * Ptrace flags
  */
--- linux/include/linux/init_task.h.orig	Sun Jun  9 07:27:21 2002
+++ linux/include/linux/init_task.h	Fri Jul 19 19:38:48 2002
@@ -47,7 +47,7 @@
     lock_depth:		-1,						\
     prio:		MAX_PRIO-20,					\
     static_prio:	MAX_PRIO-20,					\
-    policy:		SCHED_OTHER,					\
+    policy:		SCHED_NORMAL,					\
     cpus_allowed:	-1,						\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
@@ -78,6 +78,7 @@
     pending:		{ NULL, &tsk.pending.head, {{0}}},		\
     blocked:		{{0}},						\
     alloc_lock:		SPIN_LOCK_UNLOCKED,				\
+    switch_lock:	SPIN_LOCK_UNLOCKED,				\
     journal_info:	NULL,						\
 }
 
--- linux/include/asm-x86_64/system.h.orig	Fri Jul 19 19:31:28 2002
+++ linux/include/asm-x86_64/system.h	Fri Jul 19 19:38:48 2002
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
 
--- linux/include/asm-ppc/system.h.orig	Fri Jul 19 19:31:30 2002
+++ linux/include/asm-ppc/system.h	Fri Jul 19 19:38:48 2002
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
--- linux/include/asm-s390x/system.h.orig	Fri Jul 19 19:31:28 2002
+++ linux/include/asm-s390x/system.h	Fri Jul 19 19:38:48 2002
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
--- linux/include/asm-s390/system.h.orig	Fri Jul 19 19:31:28 2002
+++ linux/include/asm-s390/system.h	Fri Jul 19 19:38:48 2002
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
--- linux/include/asm-sparc64/system.h.orig	Fri Jul 19 19:31:28 2002
+++ linux/include/asm-sparc64/system.h	Fri Jul 19 19:38:48 2002
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
--- linux/include/asm-i386/system.h.orig	Fri Jul 19 19:31:27 2002
+++ linux/include/asm-i386/system.h	Fri Jul 19 19:38:48 2002
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
--- linux/kernel/timer.c.orig	Fri Jul 19 19:31:30 2002
+++ linux/kernel/timer.c	Fri Jul 19 19:38:48 2002
@@ -888,7 +888,7 @@
 
 
 	if (t.tv_sec == 0 && t.tv_nsec <= 2000000L &&
-	    current->policy != SCHED_OTHER)
+	    current->policy != SCHED_NORMAL)
 	{
 		/*
 		 * Short delay requests up to 2 ms will be handled with
--- linux/kernel/fork.c.orig	Fri Jul 19 19:31:30 2002
+++ linux/kernel/fork.c	Fri Jul 19 19:38:48 2002
@@ -615,7 +615,6 @@
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
@@ -737,9 +737,13 @@
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
@@ -751,7 +755,7 @@
 		scheduler_tick(0, 0);
 	}
 	p->sleep_timestamp = jiffies;
-	__restore_flags(flags);
+	__sti();
 
 	/*
 	 * Ok, add it to the run-queues and make it
--- linux/kernel/sched.c.orig	Fri Jul 19 19:31:31 2002
+++ linux/kernel/sched.c	Fri Jul 19 19:38:48 2002
@@ -101,7 +101,7 @@
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
 /*
- * TASK_TIMESLICE scales user-nice values [ -20 ... 19 ]
+ * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
  *
  * The higher a process's priority, the bigger timeslices
@@ -109,8 +109,13 @@
  * priority process gets MIN_TIMESLICE worth of execution time.
  */
 
-#define TASK_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/39))
+#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
+	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
+
+static inline unsigned int task_timeslice(task_t *p)
+{
+	return BASE_TIMESLICE(p);
+}
 
 /*
  * These are the runqueue data structures:
@@ -135,13 +140,15 @@
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
+
 	task_t *migration_thread;
 	list_t migration_queue;
+
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -153,6 +160,15 @@
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
@@ -306,7 +322,7 @@
 repeat:
 	preempt_disable();
 	rq = task_rq(p);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(task_running(rq, p))) {
 		cpu_relax();
 		/*
 		 * enable/disable preemption just to make this
@@ -317,7 +333,7 @@
 		goto repeat;
 	}
 	rq = task_rq_lock(p, &flags);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(task_running(rq, p))) {
 		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
@@ -325,6 +341,7 @@
 	task_rq_unlock(rq, &flags);
 	preempt_enable();
 }
+#endif
 
 /*
  * Kick the remote CPU if the task is running currently,
@@ -337,10 +354,9 @@
  */
 void kick_if_running(task_t * p)
 {
-	if (p == task_rq(p)->curr)
+	if ((task_running(task_rq(p), p)) && (p->thread_info->cpu != smp_processor_id()))
 		resched_task(p);
 }
-#endif
 
 /*
  * Wake up a process. Put it on the run-queue if it's not
@@ -349,6 +365,8 @@
  * progress), and as such you're allowed to do the simpler
  * "current->state = TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
+ *
+ * returns failure only if the task is already active.
  */
 static int try_to_wake_up(task_t * p, int sync)
 {
@@ -365,7 +383,7 @@
 		 * Fast-migrate the task if it's not running or runnable
 		 * currently. Do not violate hard affinity.
 		 */
-		if (unlikely(sync && (rq->curr != p) &&
+		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
 			(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
@@ -376,9 +394,7 @@
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
@@ -427,9 +443,11 @@
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
@@ -443,8 +461,7 @@
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
-	finish_arch_switch(this_rq());
-	finish_arch_schedule(prev);
+	finish_arch_switch(this_rq(), prev);
 }
 #endif
 
@@ -501,7 +518,42 @@
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
@@ -525,22 +577,10 @@
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
@@ -589,21 +629,67 @@
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
@@ -646,36 +732,27 @@
 
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
 }
 
 /*
@@ -690,13 +767,13 @@
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
@@ -719,7 +796,7 @@
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
-void scheduler_tick(int user_tick, int system)
+void scheduler_tick(int user_ticks, int sys_ticks)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
@@ -727,17 +804,17 @@
 
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
@@ -751,7 +828,8 @@
 		 * FIFO tasks have no timeslices.
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = TASK_TIMESLICE(p);
+			p->time_slice = task_timeslice(p);
+			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -774,7 +852,8 @@
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
-		p->time_slice = TASK_TIMESLICE(p);
+		p->time_slice = task_timeslice(p);
+		p->first_time_slice = 0;
 
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
@@ -816,7 +895,6 @@
 	rq = this_rq();
 
 	release_kernel_lock(prev, smp_processor_id());
-	prepare_arch_schedule(prev);
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 
@@ -873,14 +951,13 @@
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
@@ -1106,7 +1183,8 @@
 		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) || (p == rq->curr))
+		if ((NICE_TO_PRIO(nice) < p->static_prio) ||
+							task_running(rq, p))
 			resched_task(rq->curr);
 	}
 out_unlock:
@@ -1214,18 +1292,18 @@
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_OTHER)
+				policy != SCHED_NORMAL)
 			goto out_unlock;
 	}
 
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_OTHER is 0.
+	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL is 0.
 	 */
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_OTHER) != (lp.sched_priority == 0))
+	if ((policy == SCHED_NORMAL) != (lp.sched_priority == 0))
 		goto out_unlock;
 
 	retval = -EPERM;
@@ -1242,7 +1320,7 @@
 	retval = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
-	if (policy != SCHED_OTHER)
+	if (policy != SCHED_NORMAL)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -1413,39 +1491,18 @@
 	prio_array_t *array = current->array;
 
 	/*
-	 * There are three levels of how a yielding task will give up
-	 * the current CPU:
+	 * We implement yielding by moving the task into the expired
+	 * queue.
 	 *
-	 *  #1 - it decreases its priority by one. This priority loss is
-	 *       temporary, it's recovered once the current timeslice
-	 *       expires.
-	 *
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
 
@@ -1475,7 +1532,7 @@
 	case SCHED_RR:
 		ret = MAX_USER_RT_PRIO-1;
 		break;
-	case SCHED_OTHER:
+	case SCHED_NORMAL:
 		ret = 0;
 		break;
 	}
@@ -1491,7 +1548,7 @@
 	case SCHED_RR:
 		ret = 1;
 		break;
-	case SCHED_OTHER:
+	case SCHED_NORMAL:
 		ret = 0;
 	}
 	return ret;
@@ -1511,7 +1568,7 @@
 	p = find_process_by_pid(pid);
 	if (p)
 		jiffies_to_timespec(p->policy & SCHED_FIFO ?
-					 0 : TASK_TIMESLICE(p), &t);
+					 0 : task_timeslice(p), &t);
 	read_unlock(&tasklist_lock);
 	if (p)
 		retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
@@ -1613,40 +1670,6 @@
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
@@ -1670,57 +1693,6 @@
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
@@ -1779,7 +1751,7 @@
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && (p != rq->curr)) {
+	if (!p->array && !task_running(rq, p)) {
 		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;
@@ -1897,3 +1869,55 @@
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
--- linux/kernel/signal.c.orig	Fri Jul 19 19:31:30 2002
+++ linux/kernel/signal.c	Fri Jul 19 19:38:48 2002
@@ -500,7 +500,6 @@
 {
 	set_tsk_thread_flag(t,TIF_SIGPENDING);
 
-#ifdef CONFIG_SMP
 	/*
 	 * If the task is running on a different CPU 
 	 * force a reschedule on the other CPU to make
@@ -511,9 +510,8 @@
 	 * process of changing - but no harm is done by that
 	 * other than doing an extra (lightweight) IPI interrupt.
 	 */
-	if ((t->state == TASK_RUNNING) && (t->thread_info->cpu != smp_processor_id()))
+	if (t->state == TASK_RUNNING)
 		kick_if_running(t);
-#endif
 	if (t->state & TASK_INTERRUPTIBLE) {
 		wake_up_process(t);
 		return;
--- linux/kernel/exit.c.orig	Fri Jul 19 19:31:30 2002
+++ linux/kernel/exit.c	Fri Jul 19 19:38:48 2002
@@ -182,7 +182,7 @@
 	current->exit_signal = SIGCHLD;
 
 	current->ptrace = 0;
-	if ((current->policy == SCHED_OTHER) && (task_nice(current) < 0))
+	if ((current->policy == SCHED_NORMAL) && (task_nice(current) < 0))
 		set_user_nice(current, 0);
 	/* cpus_allowed? */
 	/* rt_priority? */
 

