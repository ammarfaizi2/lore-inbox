Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317699AbSGVPyB>; Mon, 22 Jul 2002 11:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317709AbSGVPyB>; Mon, 22 Jul 2002 11:54:01 -0400
Received: from mx1.elte.hu ([157.181.1.137]:36520 "HELO mx1.elte.hu")
	by vger.kernel.org with SMTP id <S317699AbSGVPxj>;
	Mon, 22 Jul 2002 11:53:39 -0400
Date: Mon, 22 Jul 2002 17:55:30 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: linux-kernel@vger.kernel.org
Cc: Linus Torvalds <torvalds@transmeta.com>
Subject: [patch] scheduler bits for 2.5.27, -B3
Message-ID: <Pine.LNX.4.44.0207221732320.12159-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


the attached patch adds my current scheduler changes/fixes, against
2.5.27-BK + cli-sti-cleanup-A2 + remove-irqlock-D9.

Bugfixes:

 - introduce new type of context-switch locking, this is a must-have for
   ia64 and sparc64.

 - load_balance() bug noticed by Scott Rhine and myself: scan the
   whole list to find imbalance number of tasks, not just the tail
   of the list.

 - sched_yield() fix: use current->array not rq->active.

Features:

 - SCHED_BATCH feature.

 - ->first_time_slice to limit the number of timeslices 'won' via child
   exit - this is the logical equivalent of the child-timeslice
   distribution change in Andrea's tree.

 - sched_yield() cleanup and simplification: yielding puts the task
   into the expired queue. This eliminates spurious yields in which
   the same task repeatedly calls into yield() without achieving
   anything. It's also the most logical thing to do - the yielder
   has asked for other tasks to be scheduled first.

Cleanups, smaller changes:

 - simpler locking in schedule_tail().

 - load_balance() cleanup: split up into find_busiest_queue(),
   pull_task() and load_balance() functions.

 - idle_tick() cleanups: use a parameter already existing in the
   calling function.

 - scheduler_tick() cleanups: use more intuitive variable names.

 - remove obsolete comments.

 - clear ->first_time_slice when a new timeslice is calculated.

 - move the sched initialization code to the end of sched.c.

 - no need for nr_uninterruptible to be signed.

the patch can also be downloaded from:

   http://redhat.com/~mingo/O(1)-scheduler/sched-2.5.27-B3

	Ingo

--- linux/arch/i386/kernel/entry.S.orig	Mon Jul 22 16:55:36 2002
+++ linux/arch/i386/kernel/entry.S	Mon Jul 22 17:40:29 2002
@@ -209,7 +209,7 @@
 	movl TI_FLAGS(%ebx), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
-	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (execption path) ?
+	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
 	jz restore_all
 	movl $PREEMPT_ACTIVE,TI_PRE_COUNT(%ebx)
 	sti
@@ -249,7 +249,7 @@
 	testb $_TIF_NEED_RESCHED, %cl
 	jz work_notifysig
 work_resched:
-	call schedule
+	call schedule_userspace
 	cli				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
--- linux/arch/i386/kernel/process.c.orig	Mon Jul 22 14:52:49 2002
+++ linux/arch/i386/kernel/process.c	Mon Jul 22 17:40:29 2002
@@ -481,6 +481,9 @@
 int kernel_thread(int (*fn)(void *), void * arg, unsigned long flags)
 {
 	long retval, d0;
+	unsigned long saved_policy = current->policy;
+
+	current->policy = SCHED_NORMAL;
 
 	__asm__ __volatile__(
 		"movl %%esp,%%esi\n\t"
@@ -501,6 +504,9 @@
 		 "r" (arg), "r" (fn),
 		 "b" (flags | CLONE_VM)
 		: "memory");
+
+	current->policy = saved_policy;
+
 	return retval;
 }
 
--- linux/include/linux/sched.h.orig	Mon Jul 22 14:52:29 2002
+++ linux/include/linux/sched.h	Mon Jul 22 17:40:29 2002
@@ -116,9 +116,10 @@
 /*
  * Scheduling policies
  */
-#define SCHED_OTHER		0
+#define SCHED_NORMAL		0
 #define SCHED_FIFO		1
 #define SCHED_RR		2
+#define SCHED_BATCH		3
 
 struct sched_param {
 	int sched_priority;
@@ -157,6 +158,7 @@
 #define	MAX_SCHEDULE_TIMEOUT	LONG_MAX
 extern signed long FASTCALL(schedule_timeout(signed long timeout));
 asmlinkage void schedule(void);
+asmlinkage void schedule_userspace(void);
 
 extern void flush_scheduled_tasks(void);
 extern int start_context_thread(void);
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
 
@@ -361,6 +363,8 @@
    	u32 self_exec_id;
 /* Protection of (de-)allocation: mm, files, fs, tty */
 	spinlock_t alloc_lock;
+/* context-switch lock */
+	spinlock_t switch_lock;
 
 /* journalling filesystem info */
 	void *journal_info;
@@ -393,6 +397,8 @@
 #define PF_IOTHREAD	0x00020000	/* this thread is needed for doing I/O to swap */
 #define PF_FROZEN	0x00040000	/* frozen for system suspend */
 #define PF_INVALIDATE	0x00080000	/* debug: unmounting an fs. killme. */
+#define PF_BATCH	0x00100000	/* batch-priority process */
+
 /*
  * Ptrace flags
  */
--- linux/include/linux/init_task.h.orig	Sun Jun  9 07:27:21 2002
+++ linux/include/linux/init_task.h	Mon Jul 22 17:40:29 2002
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
 
--- linux/include/asm-x86_64/system.h.orig	Mon Jul 22 15:09:56 2002
+++ linux/include/asm-x86_64/system.h	Mon Jul 22 17:40:29 2002
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
 
--- linux/include/asm-ppc/system.h.orig	Mon Jul 22 15:09:24 2002
+++ linux/include/asm-ppc/system.h	Mon Jul 22 17:40:29 2002
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
--- linux/include/asm-s390x/system.h.orig	Mon Jul 22 15:09:41 2002
+++ linux/include/asm-s390x/system.h	Mon Jul 22 17:40:29 2002
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
--- linux/include/asm-s390/system.h.orig	Mon Jul 22 15:09:31 2002
+++ linux/include/asm-s390/system.h	Mon Jul 22 17:40:29 2002
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
--- linux/include/asm-sparc64/system.h.orig	Mon Jul 22 15:09:52 2002
+++ linux/include/asm-sparc64/system.h	Mon Jul 22 17:40:29 2002
@@ -117,13 +117,17 @@
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
 } while (0)
-#define finish_arch_switch(rq)		irq_on()
+
+#define finish_arch_switch(rq, prev)		\
+do {	spin_unlock_irq(&(prev)->switch_lock);	\
+} while (0)
+
+
 
 #ifndef CONFIG_DEBUG_SPINLOCK
 #define CHECK_LOCKS(PREV)	do { } while(0)
--- linux/include/asm-i386/system.h.orig	Mon Jul 22 15:09:03 2002
+++ linux/include/asm-i386/system.h	Mon Jul 22 17:40:29 2002
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
--- linux/kernel/timer.c.orig	Mon Jul 22 14:52:27 2002
+++ linux/kernel/timer.c	Mon Jul 22 17:40:30 2002
@@ -888,7 +888,7 @@
 
 
 	if (t.tv_sec == 0 && t.tv_nsec <= 2000000L &&
-	    current->policy != SCHED_OTHER)
+	    current->policy != SCHED_NORMAL && current->policy != SCHED_BATCH)
 	{
 		/*
 		 * Short delay requests up to 2 ms will be handled with
--- linux/kernel/fork.c.orig	Mon Jul 22 14:52:50 2002
+++ linux/kernel/fork.c	Mon Jul 22 17:40:30 2002
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
-	irq_save(flags);
 	irq_off();
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
-	irq_restore(flags);
+	irq_on();
 
 	/*
 	 * Ok, add it to the run-queues and make it
--- linux/kernel/sched.c.orig	Mon Jul 22 14:52:50 2002
+++ linux/kernel/sched.c	Mon Jul 22 17:40:30 2002
@@ -102,16 +102,30 @@
 	((p)->prio <= (p)->static_prio - DELTA(p))
 
 /*
- * TASK_TIMESLICE scales user-nice values [ -20 ... 19 ]
+ * BASE_TIMESLICE scales user-nice values [ -20 ... 19 ]
  * to time slice values.
  *
  * The higher a process's priority, the bigger timeslices
  * it gets during one round of execution. But even the lowest
  * priority process gets MIN_TIMESLICE worth of execution time.
+ *
+ * task_timeslice() is the interface that is used by the scheduler.
+ * SCHED_BATCH tasks get longer timeslices to make use of better
+ * caching. They are inherently noninteractive and they are
+ * immediately preempted by SCHED_NORMAL tasks so there is no
+ * downside in using shorter timeslices.
  */
 
-#define TASK_TIMESLICE(p) (MIN_TIMESLICE + \
-	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/39))
+#define BASE_TIMESLICE(p) (MIN_TIMESLICE + \
+	((MAX_TIMESLICE - MIN_TIMESLICE) * (MAX_PRIO-1-(p)->static_prio)/(MAX_USER_PRIO - 1)))
+
+static inline unsigned int task_timeslice(task_t *p)
+{
+	if (p->policy == SCHED_BATCH)
+		return BASE_TIMESLICE(p) * 10;
+	else
+		return BASE_TIMESLICE(p);
+}
 
 /*
  * These are the runqueue data structures:
@@ -136,13 +150,32 @@
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
+	/*
+	 * The batch queue is a secondary ready-queue:
+	 */
+	unsigned long nr_batch;
+	list_t batch_queue;
+
+	/*
+	 * Per-CPU idle CPU time tracking:
+	 *
+	 * - idle_ticks_left counts back from HZ to 0.
+	 * - idle_count is the number of idle ticks in the last second.
+	 * - once it reaches 0, a new idle_avg is calculated.
+	 */
+	#define IDLE_TICKS (HZ)
+
+	unsigned int idle_ticks_left, idle_count, idle_avg;
+
 } ____cacheline_aligned;
 
 static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
@@ -154,6 +187,15 @@
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
@@ -265,6 +307,14 @@
 	rq->nr_running++;
 }
 
+static inline void activate_batch_task(task_t *p, runqueue_t *rq)
+{
+	rq->nr_batch--;
+	list_del(&p->run_list);
+	activate_task(p, rq);
+	p->flags &= ~PF_BATCH;
+}
+
 static inline void deactivate_task(struct task_struct *p, runqueue_t *rq)
 {
 	rq->nr_running--;
@@ -274,6 +324,23 @@
 	p->array = NULL;
 }
 
+static inline void deactivate_batch_task(task_t *p, runqueue_t *rq)
+{
+	prio_array_t *array = p->array;
+
+	deactivate_task(p, rq);
+	rq->nr_batch++;
+	if (array == rq->expired)
+		list_add_tail(&p->run_list, &rq->batch_queue);
+	else
+		list_add(&p->run_list, &rq->batch_queue);
+	/*
+	 * Via this bit we can tell whether a task is in the batchqueue,
+	 * this information is not available in any other cheap way.
+	 */
+	p->flags |= PF_BATCH;
+}
+
 static inline void resched_task(task_t *p)
 {
 #ifdef CONFIG_SMP
@@ -307,7 +374,7 @@
 repeat:
 	preempt_disable();
 	rq = task_rq(p);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(task_running(rq, p))) {
 		cpu_relax();
 		/*
 		 * enable/disable preemption just to make this
@@ -318,7 +385,7 @@
 		goto repeat;
 	}
 	rq = task_rq_lock(p, &flags);
-	if (unlikely(rq->curr == p)) {
+	if (unlikely(task_running(rq, p))) {
 		task_rq_unlock(rq, &flags);
 		preempt_enable();
 		goto repeat;
@@ -326,6 +393,7 @@
 	task_rq_unlock(rq, &flags);
 	preempt_enable();
 }
+#endif
 
 /*
  * Kick the remote CPU if the task is running currently,
@@ -335,13 +403,29 @@
  * (Note that we do this lockless - if the task does anything
  * while the message is in flight then it will notice the
  * sigpending condition anyway.)
+ *
+ * this code also activates batch processes if they get a signal.
  */
 void kick_if_running(task_t * p)
 {
-	if (p == task_rq(p)->curr)
+	if ((task_running(task_rq(p), p)) && (p->thread_info->cpu != smp_processor_id()))
 		resched_task(p);
+	/*
+	 * If batch processes get signals but are not running currently
+	 * then give them a chance to handle the signal. (the kernel
+	 * side signal handling code will run for sure, the userspace
+	 * part depends on system load and might be delayed indefinitely.)
+	 */
+	if (p->policy == SCHED_BATCH) {
+		unsigned long flags;
+		runqueue_t *rq;
+
+		rq = task_rq_lock(p, &flags);
+		if (p->flags & PF_BATCH)
+			activate_batch_task(p, rq);
+		task_rq_unlock(rq, &flags);
+	}
 }
-#endif
 
 /*
  * Wake up a process. Put it on the run-queue if it's not
@@ -350,6 +434,8 @@
  * progress), and as such you're allowed to do the simpler
  * "current->state = TASK_RUNNING" to mark yourself runnable
  * without the overhead of this.
+ *
+ * returns failure only if the task is already active.
  */
 static int try_to_wake_up(task_t * p, int sync)
 {
@@ -366,7 +452,7 @@
 		 * Fast-migrate the task if it's not running or runnable
 		 * currently. Do not violate hard affinity.
 		 */
-		if (unlikely(sync && (rq->curr != p) &&
+		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
 			(p->cpus_allowed & (1UL << smp_processor_id())))) {
 
@@ -377,10 +463,8 @@
 		if (old_state == TASK_UNINTERRUPTIBLE)
 			rq->nr_uninterruptible--;
 		activate_task(p, rq);
-		/*
-		 * If sync is set, a resched_task() is a NOOP
-		 */
-		if (p->prio < rq->curr->prio)
+
+		if (p->prio < rq->curr->prio || rq->curr->policy == SCHED_BATCH)
 			resched_task(rq->curr);
 		success = 1;
 	}
@@ -428,9 +512,11 @@
 void sched_exit(task_t * p)
 {
 	irq_off();
-	current->time_slice += p->time_slice;
-	if (unlikely(current->time_slice > MAX_TIMESLICE))
-		current->time_slice = MAX_TIMESLICE;
+	if (p->first_time_slice) {
+		current->time_slice += p->time_slice;
+		if (unlikely(current->time_slice > MAX_TIMESLICE))
+			current->time_slice = MAX_TIMESLICE;
+	}
 	irq_on();
 	/*
 	 * If the child was a (relative-) CPU hog then decrease
@@ -444,8 +530,7 @@
 #if CONFIG_SMP || CONFIG_PREEMPT
 asmlinkage void schedule_tail(task_t *prev)
 {
-	finish_arch_switch(this_rq());
-	finish_arch_schedule(prev);
+	finish_arch_switch(this_rq(), prev);
 }
 #endif
 
@@ -502,7 +587,122 @@
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
+/*
+ * Batch balancing is much simpler since it's optimized for
+ * CPU-intensive workloads. The balancer keeps the batch-queue
+ * length as close to the average length as possible. It weighs
+ * runqueue distribution based on the idle percentage of each
+ * CPU - this way statistical fairness of timeslice distribution
+ * is preserved, in the long run it does not matter whether a
+ * batch task is queued to a busy CPU or not, it will get an
+ * equal share of all available idle CPU time.
+ *
+ * CPU-intensive SCHED_BATCH processes have a much lower
+ * fork()/exit() flux, so the balancing does not have to
+ * be prepared for high statistical fluctuations in queue
+ * length.
+ */
+static inline void load_balance_batch(runqueue_t *this_rq, int this_cpu)
+{
+	int i, nr_batch, nr_idle, goal, rq_goal;
+	runqueue_t *rq_src;
+
+	/*
+	 * First the unlocked fastpath - is there any work to do?
+	 * fastpath #1: no batch processes in the system,
+	 * fastpath #2: no idle time available in the system.
+	 * fastpath #3: no balancing needed for the current queue.
+	 */
+	nr_batch = 0;
+	nr_idle = 0;
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i))
+			continue;
+
+		nr_batch += cpu_rq(i)->nr_batch;
+		nr_idle += cpu_rq(i)->idle_avg;
+	}
+	if (!nr_batch || !nr_idle)
+		return;
+
+	goal = this_rq->idle_avg * nr_batch / nr_idle;
+	if (this_rq->nr_batch >= goal)
+		return;
+
+	/*
+	 * The slow path - the local batch-queue is too short and
+	 * needs balancing. We unlock the runqueue (but keep
+	 * interrupts disabled) to simplify locking. (It does not
+	 * matter if the runqueues change meanwhile - this is all
+	 * statistical balancing so only the long run effects matter.)
+	 */
+	spin_unlock(&this_rq->lock);
+
+	for (i = 0; i < NR_CPUS; i++) {
+		if (!cpu_online(i) || (i == this_cpu))
+			continue;
+
+		rq_src = cpu_rq(i);
+		double_rq_lock(this_rq, rq_src);
+
+		rq_goal = rq_src->idle_avg * nr_batch / nr_idle;
+
+		if (rq_src->nr_batch > rq_goal) {
+			/*
+			 * Migrate a single batch-process.
+			 */
+			list_t *tmp = rq_src->batch_queue.prev;
+
+			list_del(tmp);
+			list_add_tail(tmp, &this_rq->batch_queue);
+			rq_src->nr_batch--;
+			this_rq->nr_batch++;
+			set_task_cpu(list_entry(tmp, task_t, run_list), this_cpu);
+		}
+
+		double_rq_unlock(this_rq, rq_src);
+		if (this_rq->nr_batch >= goal)
+			break;
+	}
+	spin_lock(&this_rq->lock);
+}
 /*
  * Lock the busiest runqueue as well, this_rq is locked already.
  * Recalculate nr_running if we have to drop the runqueue lock.
@@ -526,22 +726,10 @@
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
@@ -590,21 +778,67 @@
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
+		goto balance_batch;
 
 	/*
 	 * We first consider expired tasks. Those will likely not be
@@ -647,36 +881,28 @@
 
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
+balance_batch:
+	load_balance_batch(this_rq, this_cpu);
 }
 
 /*
@@ -691,13 +917,13 @@
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
@@ -720,26 +946,45 @@
  * This function gets called by the timer code, with HZ frequency.
  * We call it with interrupts disabled.
  */
-void scheduler_tick(int user_tick, int system)
+void scheduler_tick(int user_ticks, int sys_ticks)
 {
 	int cpu = smp_processor_id();
 	runqueue_t *rq = this_rq();
 	task_t *p = current;
 
+#if CONFIG_SMP
+	if (user_ticks || sys_ticks) {
+		/*
+		 * This code is rare, triggered only once per second:
+		 */
+		if (--rq->idle_ticks_left <= 0) {
+			/*
+			 * Maintain a simple running average:
+			 */
+			rq->idle_avg += rq->idle_count;
+			rq->idle_avg >>= 1;
+
+			rq->idle_ticks_left = IDLE_TICKS;
+			rq->idle_count = 0;
+		}
+	}
+	if (p == rq->idle || p->policy == SCHED_BATCH)
+		rq->idle_count++;
+#endif
 	if (p == rq->idle) {
 		/* note: this timer irq context must be accounted for as well */
 		if (preempt_count() >= 2*IRQ_OFFSET)
-			kstat.per_cpu_system[cpu] += system;
+			kstat.per_cpu_system[cpu] += sys_ticks;
 #if CONFIG_SMP
-		idle_tick();
+		idle_tick(rq);
 #endif
 		return;
 	}
-	if (TASK_NICE(p) > 0)
-		kstat.per_cpu_nice[cpu] += user_tick;
+	if (TASK_NICE(p) > 0 || p->policy == SCHED_BATCH)
+		kstat.per_cpu_nice[cpu] += user_ticks;
 	else
-		kstat.per_cpu_user[cpu] += user_tick;
-	kstat.per_cpu_system[cpu] += system;
+		kstat.per_cpu_user[cpu] += user_ticks;
+	kstat.per_cpu_system[cpu] += sys_ticks;
 
 	/* Task might have expired already, but not scheduled off yet */
 	if (p->array != rq->active) {
@@ -753,7 +998,8 @@
 		 * FIFO tasks have no timeslices.
 		 */
 		if ((p->policy == SCHED_RR) && !--p->time_slice) {
-			p->time_slice = TASK_TIMESLICE(p);
+			p->time_slice = task_timeslice(p);
+			p->first_time_slice = 0;
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
@@ -776,7 +1022,8 @@
 		dequeue_task(p, rq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
-		p->time_slice = TASK_TIMESLICE(p);
+		p->time_slice = task_timeslice(p);
+		p->first_time_slice = 0;
 
 		if (!TASK_INTERACTIVE(p) || EXPIRED_STARVING(rq)) {
 			if (!rq->expired_timestamp)
@@ -796,6 +1043,35 @@
 void scheduling_functions_start_here(void) { }
 
 /*
+ * This function is called by the lowlevel kernel entry code if
+ * pure userspace code is preempted. Such processes, if SCHED_BATCH,
+ * are candidates for batch scheduling. Every other process (including
+ * kernel-mode SCHED_BATCH processes) is scheduled in a non-batch way.
+ */
+asmlinkage void schedule_userspace(void)
+{
+	runqueue_t *rq;
+
+	if (current->policy != SCHED_BATCH) {
+		schedule();
+		return;
+	}
+
+	/*
+	 * Only handle batch tasks that are runnable.
+	 */
+	if (current->state == TASK_RUNNING) {
+		rq = this_rq_lock();
+		deactivate_batch_task(current, rq);
+
+		// we can keep irqs disabled:
+		spin_unlock(&rq->lock);
+	}
+
+	schedule();
+}
+
+/*
  * 'schedule()' is the main scheduler function.
  */
 asmlinkage void schedule(void)
@@ -818,7 +1094,6 @@
 	rq = this_rq();
 
 	release_kernel_lock(prev);
-	prepare_arch_schedule(prev);
 	prev->sleep_timestamp = jiffies;
 	spin_lock_irq(&rq->lock);
 
@@ -847,7 +1122,16 @@
 		if (rq->nr_running)
 			goto pick_next_task;
 #endif
-		next = rq->idle;
+		/*
+		 * Pick a task from the batch queue if available.
+		 */
+		if (rq->nr_batch) {
+			list_t *tmp = rq->batch_queue.next;
+
+			next = list_entry(tmp, task_t, run_list);
+			activate_batch_task(next, rq);
+		} else
+			next = rq->idle;
 		rq->expired_timestamp = 0;
 		goto switch_tasks;
 	}
@@ -875,14 +1159,13 @@
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
@@ -1108,7 +1391,8 @@
 		 * If the task is running and lowered its priority,
 		 * or increased its priority then reschedule its CPU:
 		 */
-		if ((NICE_TO_PRIO(nice) < p->static_prio) || (p == rq->curr))
+		if ((NICE_TO_PRIO(nice) < p->static_prio) ||
+							task_running(rq, p))
 			resched_task(rq->curr);
 	}
 out_unlock:
@@ -1222,18 +1506,20 @@
 	else {
 		retval = -EINVAL;
 		if (policy != SCHED_FIFO && policy != SCHED_RR &&
-				policy != SCHED_OTHER)
+				policy != SCHED_NORMAL && policy != SCHED_BATCH)
 			goto out_unlock;
 	}
 
 	/*
 	 * Valid priorities for SCHED_FIFO and SCHED_RR are
-	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_OTHER is 0.
+	 * 1..MAX_USER_RT_PRIO-1, valid priority for SCHED_NORMAL and
+	 * SCHED_BATCH is 0.
 	 */
 	retval = -EINVAL;
 	if (lp.sched_priority < 0 || lp.sched_priority > MAX_USER_RT_PRIO-1)
 		goto out_unlock;
-	if ((policy == SCHED_OTHER) != (lp.sched_priority == 0))
+	if ((policy == SCHED_NORMAL || policy == SCHED_BATCH) !=
+						(lp.sched_priority == 0))
 		goto out_unlock;
 
 	retval = -EPERM;
@@ -1248,13 +1534,15 @@
 	if (retval)
 		goto out_unlock;
 
+	if (p->flags & PF_BATCH)
+		activate_batch_task(p, rq);
 	array = p->array;
 	if (array)
 		deactivate_task(p, task_rq(p));
 	retval = 0;
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
-	if (policy != SCHED_OTHER)
+	if (policy != SCHED_NORMAL && policy != SCHED_BATCH)
 		p->prio = MAX_USER_RT_PRIO-1 - p->rt_priority;
 	else
 		p->prio = p->static_prio;
@@ -1433,39 +1721,18 @@
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
 
@@ -1495,7 +1762,8 @@
 	case SCHED_RR:
 		ret = MAX_USER_RT_PRIO-1;
 		break;
-	case SCHED_OTHER:
+	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 		break;
 	}
@@ -1511,7 +1779,8 @@
 	case SCHED_RR:
 		ret = 1;
 		break;
-	case SCHED_OTHER:
+	case SCHED_NORMAL:
+	case SCHED_BATCH:
 		ret = 0;
 	}
 	return ret;
@@ -1537,7 +1806,7 @@
 		goto out_unlock;
 
 	jiffies_to_timespec(p->policy & SCHED_FIFO ?
-				0 : TASK_TIMESLICE(p), &t);
+				0 : task_timeslice(p), &t);
 	read_unlock(&tasklist_lock);
 	retval = copy_to_user(interval, &t, sizeof(t)) ? -EFAULT : 0;
 out_nounlock:
@@ -1641,40 +1910,6 @@
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
@@ -1700,57 +1935,6 @@
 #endif
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
@@ -1809,7 +1993,7 @@
 	 * If the task is not on a runqueue (and not running), then
 	 * it is sufficient to simply update the task's cpu field.
 	 */
-	if (!p->array && (p != rq->curr)) {
+	if (!p->array && !task_running(rq, p)) {
 		set_task_cpu(p, __ffs(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;
@@ -1927,3 +2111,57 @@
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
+		INIT_LIST_HEAD(&rq->batch_queue);
+		rq->idle_ticks_left = IDLE_TICKS;
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
--- linux/kernel/signal.c.orig	Mon Jul 22 14:52:29 2002
+++ linux/kernel/signal.c	Mon Jul 22 17:40:30 2002
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
--- linux/kernel/exit.c.orig	Mon Jul 22 14:52:36 2002
+++ linux/kernel/exit.c	Mon Jul 22 17:40:30 2002
@@ -184,7 +184,7 @@
 	current->exit_signal = SIGCHLD;
 
 	current->ptrace = 0;
-	if ((current->policy == SCHED_OTHER) && (task_nice(current) < 0))
+	if ((current->policy == SCHED_NORMAL) && (task_nice(current) < 0))
 		set_user_nice(current, 0);
 	/* cpus_allowed? */
 	/* rt_priority? */
--- linux/kernel/kmod.c.orig	Mon Jul 22 14:52:29 2002
+++ linux/kernel/kmod.c	Mon Jul 22 17:40:30 2002
@@ -190,16 +190,19 @@
 	pid_t pid;
 	int waitpid_result;
 	sigset_t tmpsig;
-	int i;
+	int i, ret;
 	static atomic_t kmod_concurrent = ATOMIC_INIT(0);
 #define MAX_KMOD_CONCURRENT 50	/* Completely arbitrary value - KAO */
 	static int kmod_loop_msg;
+	unsigned long saved_policy = current->policy;
 
+	current->policy = SCHED_NORMAL;
 	/* Don't allow request_module() before the root fs is mounted!  */
 	if ( ! current->fs->root ) {
 		printk(KERN_ERR "request_module[%s]: Root fs not mounted\n",
 			module_name);
-		return -EPERM;
+		ret = -EPERM;
+		goto out;
 	}
 
 	/* If modprobe needs a service that is in a module, we get a recursive
@@ -220,14 +223,16 @@
 			printk(KERN_ERR
 			       "kmod: runaway modprobe loop assumed and stopped\n");
 		atomic_dec(&kmod_concurrent);
-		return -ENOMEM;
+		ret = -ENOMEM;
+		goto out;
 	}
 
 	pid = kernel_thread(exec_modprobe, (void*) module_name, 0);
 	if (pid < 0) {
 		printk(KERN_ERR "request_module[%s]: fork failed, errno %d\n", module_name, -pid);
 		atomic_dec(&kmod_concurrent);
-		return pid;
+		ret = pid;
+		goto out;
 	}
 
 	/* Block everything but SIGKILL/SIGSTOP */
@@ -250,7 +255,10 @@
 		printk(KERN_ERR "request_module[%s]: waitpid(%d,...) failed, errno %d\n",
 		       module_name, pid, -waitpid_result);
 	}
-	return 0;
+	ret = 0;
+out:
+	current->policy = saved_policy;
+	return ret;
 }
 #endif /* CONFIG_KMOD */
 

