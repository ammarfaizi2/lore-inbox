Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270519AbRHHQWw>; Wed, 8 Aug 2001 12:22:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270521AbRHHQWq>; Wed, 8 Aug 2001 12:22:46 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:64459 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S270519AbRHHQWZ>;
	Wed, 8 Aug 2001 12:22:25 -0400
Date: Wed, 8 Aug 2001 09:16:52 -0700
From: Mike Kravetz <mkravetz@sequent.com>
To: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [RFC][PATCH] Scalable Scheduling
Message-ID: <20010808091652.B1088@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been working on scheduler scalability.  Specifically,
the concern is running Linux on bigger machines (higher CPU
count, SMP only for now).  

I am aware of most of the objections to making scheduler
changes.  However, I believe the patch below addresses a
number of these objections.

This patch implements a multi-queue (one runquue per CPU)
scheduler.  Unlike most other multi-queue schedulers that
rely on complicated load balancing schemes, this scheduler
attempts to make global scheduling decisions and emulate
the behavior as the current SMP scheduler.

Performance at the 'low end' (low CPU and thread count)
is comparable to that of the current scheduler.  As the
number of CPUs or threads is increased, performance is
much improved over the current scheduler.  For a more
detailed description as well as benchmark results, please
see: http://lse.sourceforge.net/scheduling/
(OLS paper section).

I would like to get some input as to whether this is an
appropriate direction to take in addressing scalability
limits with the current scheduler.  The general consensus
is that the default scheduler in the kernel should work
well for most cases.  In my opinion, the attached scheduler
implementation accomplishes this by scaling with the
number of CPUs in the system.

Comments/Suggestions/Flames welcome,
-- 
Mike Kravetz                                 mkravetz@sequent.com

diff -Naur linux-2.4.7/arch/i386/kernel/apm.c linux-2.4.7-mq/arch/i386/kernel/apm.c
--- linux-2.4.7/arch/i386/kernel/apm.c	Fri Apr  6 17:42:47 2001
+++ linux-2.4.7-mq/arch/i386/kernel/apm.c	Mon Aug  6 15:59:32 2001
@@ -1092,7 +1092,11 @@
  * decide if we should just power down.
  *
  */
+#ifdef CONFIG_SMP
+#define system_idle() (nr_running() == 1)
+#else
 #define system_idle() (nr_running == 1)
+#endif
 
 static void apm_mainloop(void)
 {
diff -Naur linux-2.4.7/arch/i386/kernel/smpboot.c linux-2.4.7-mq/arch/i386/kernel/smpboot.c
--- linux-2.4.7/arch/i386/kernel/smpboot.c	Tue Feb 13 22:13:43 2001
+++ linux-2.4.7-mq/arch/i386/kernel/smpboot.c	Mon Aug  6 15:59:32 2001
@@ -562,13 +562,18 @@
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);
 
-	idle->processor = cpu;
 	x86_cpu_to_apicid[cpu] = apicid;
 	x86_apicid_to_cpu[apicid] = cpu;
-	idle->has_cpu = 1; /* we schedule the first task manually */
 	idle->thread.eip = (unsigned long) start_secondary;
 
 	del_from_runqueue(idle);
+	/*
+	 * Don't change processor/runqueue of task while it is
+	 * still on runqueue.
+	 */
+	idle->processor = cpu;
+	idle->has_cpu = 1; /* we schedule the first task manually */
+
 	unhash_process(idle);
 	init_tasks[cpu] = idle;
 
diff -Naur linux-2.4.7/fs/proc/proc_misc.c linux-2.4.7-mq/fs/proc/proc_misc.c
--- linux-2.4.7/fs/proc/proc_misc.c	Sat Jul  7 18:43:24 2001
+++ linux-2.4.7-mq/fs/proc/proc_misc.c	Mon Aug  6 15:59:32 2001
@@ -96,7 +96,11 @@
 		LOAD_INT(a), LOAD_FRAC(a),
 		LOAD_INT(b), LOAD_FRAC(b),
 		LOAD_INT(c), LOAD_FRAC(c),
+#ifdef CONFIG_SMP
+		nr_running(), nr_threads, last_pid);
+#else
 		nr_running, nr_threads, last_pid);
+#endif
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
diff -Naur linux-2.4.7/include/linux/sched.h linux-2.4.7-mq/include/linux/sched.h
--- linux-2.4.7/include/linux/sched.h	Fri Jul 20 19:52:18 2001
+++ linux-2.4.7-mq/include/linux/sched.h	Mon Aug  6 22:31:00 2001
@@ -70,9 +70,15 @@
 #define CT_TO_SECS(x)	((x) / HZ)
 #define CT_TO_USECS(x)	(((x) % HZ) * 1000000/HZ)
 
-extern int nr_running, nr_threads;
+extern int nr_threads;
 extern int last_pid;
 
+#ifdef CONFIG_SMP
+extern int nr_running(void);
+#else
+extern int nr_running;
+#endif
+
 #include <linux/fs.h>
 #include <linux/time.h>
 #include <linux/param.h>
@@ -131,13 +137,81 @@
 #include <linux/spinlock.h>
 
 /*
+ * aligned_data
+ *	CPU specific scheduling data.  One data item for each CPU
+ * in the system.  Size should be a multiple of cache line size,
+ * and array of items should start on a cache line boundary.
+ */
+typedef union aligned_data {
+	struct schedule_data {
+		struct task_struct * curr;	/* current task on this CPU */
+		cycles_t last_schedule;		/* time of last scheduling */
+						/* decision                */
+#ifdef CONFIG_SMP
+		int curr_na_goodness;		/* non-affinity goodness */
+						/* value of current task */
+#endif
+	} schedule_data;
+	char __pad [SMP_CACHE_BYTES];
+} aligned_data_t;
+extern aligned_data_t aligned_data[];
+#define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
+#ifdef CONFIG_SMP
+#define curr_na_goodness(cpu) aligned_data[(cpu)].schedule_data.curr_na_goodness
+#endif
+#define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
+
+#ifdef CONFIG_SMP
+/*
+ * runqueue_data
+ * 	One runqueue per CPU in the system, plus one additional runqueue for
+ * realtime tasks.  Size should be a multiple of cache line size, and array
+ * of items should start on a cache line boundary.
+ */
+typedef union runqueue_data {
+	struct rq_data {
+		int nt_running;			/* # of tasks on runqueue */
+		int max_na_goodness;		/* maximum non-affinity */
+						/* goodness value of    */
+						/* 'schedulable' task   */
+						/* on this runqueue     */
+		struct task_struct * max_na_ptr; /* pointer to task which */
+						 /* has max_na_goodness   */
+		unsigned long max_na_cpus_allowed; /* copy of cpus_allowed */
+						   /* field from task with */
+						   /* max_na_goodness      */
+		struct list_head runqueue;	/* list of tasks on runqueue */
+		int running_non_idle;		/* flag to indicate this cpu */
+						/* is running something      */
+						/* besides the idle thread   */
+		spinlock_t runqueue_lock;	/* lock for this runqueue */
+	} rq_data;
+	char __pad [SMP_CACHE_BYTES];
+} runqueue_data_t;
+extern runqueue_data_t runqueue_data[];
+#define runqueue_lock(cpu) runqueue_data[(cpu)].rq_data.runqueue_lock
+#define runqueue(cpu) runqueue_data[(cpu)].rq_data.runqueue
+#define max_na_goodness(cpu) runqueue_data[(cpu)].rq_data.max_na_goodness
+#define max_na_cpus_allowed(cpu) \
+	runqueue_data[(cpu)].rq_data.max_na_cpus_allowed
+#define max_na_ptr(cpu) runqueue_data[(cpu)].rq_data.max_na_ptr
+#define nt_running(cpu) runqueue_data[(cpu)].rq_data.nt_running
+#define running_non_idle(cpu) runqueue_data[(cpu)].rq_data.running_non_idle
+
+#define	REALTIME_RQ	NR_CPUS
+#define NA_GOODNESS_INIT	-10000
+#endif
+
+/*
  * This serializes "schedule()" and also protects
  * the run-queue from deletions/modifications (but
  * _adding_ to the beginning of the run-queue has
  * a separate lock).
  */
 extern rwlock_t tasklist_lock;
+#ifndef CONFIG_SMP
 extern spinlock_t runqueue_lock;
+#endif
 extern spinlock_t mmlist_lock;
 
 extern void sched_init(void);
@@ -436,6 +510,7 @@
 #define DEF_COUNTER	(10*HZ/100)	/* 100 ms time slice */
 #define MAX_COUNTER	(20*HZ/100)
 #define DEF_NICE	(0)
+#define ALL_CPUS_ALLOWED (-1)
 
 /*
  *  INIT_TASK is used to set up the first task table, touch at
@@ -454,7 +529,7 @@
     policy:		SCHED_OTHER,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
-    cpus_allowed:	-1,						\
+    cpus_allowed:	ALL_CPUS_ALLOWED,				\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
@@ -838,18 +913,198 @@
 #define next_thread(p) \
 	list_entry((p)->thread_group.next, struct task_struct, thread_group)
 
-static inline void del_from_runqueue(struct task_struct * p)
+static inline int task_on_runqueue(struct task_struct *p)
 {
-	nr_running--;
+	return (p->run_list.next != NULL);
+}
+
+#ifdef CONFIG_SMP
+/*
+ * This function calculates the non-affinity goodness (na_goodness)
+ * of a task.  This value is stored in the task struct while a task
+ * is on a runqueue.
+ */
+static inline int na_goodness(struct task_struct * p)
+{
+	int weight;
+
+	/*
+	 * select the current process after every other
+	 * runnable process, but before the idle thread.
+	 * Also, dont trigger a counter recalculation.
+	 */
+	weight = -1;
+	if (p->policy & SCHED_YIELD)
+		goto out;
+
+	/*
+	 * Be sure to give sufficiently high boost to realtime tasks
+	 */
+	if ((p->policy & ~SCHED_YIELD) != SCHED_OTHER) {
+		weight = 1000 + p->rt_priority;
+		goto out;
+	}
+
+	/*
+	 * na_goodness is based on the nuber of ticks left.
+	 * Don't do any other calculations if the time slice is
+	 * over..
+	 */
+	weight = p->counter;
+	if (!weight)
+		goto out;
+			
+	/*
+	 * Factor in the nice value
+	 */
+	weight += 20 - p->nice;
+
+out:
+	return weight;
+}
+
+/*
+ * Determine runqueue associated with task
+ */
+static inline int task_to_runqueue(struct task_struct *t)
+{
+	int rq;
+
+	if ((t->policy & ~SCHED_YIELD) != SCHED_OTHER) {
+		rq = REALTIME_RQ;
+	} else {
+		rq = t->processor;
+	}
+
+	return(rq);
+}
+
+/*
+ * Lock runqueue associated with task
+ */
+static inline void lock_task_rq(struct task_struct *t)
+{
+	int rq = task_to_runqueue(t);
+
+	spin_lock(&runqueue_lock(rq));
+	while (task_to_runqueue(t) != rq) {
+		spin_unlock(&runqueue_lock(rq));
+		rq = task_to_runqueue(t);
+		spin_lock(&runqueue_lock(rq));
+	}
+}
+
+/*
+ * Unlock runqueue associated with task
+ */
+static inline void unlock_task_rq(struct task_struct *t)
+{
+	spin_unlock(&runqueue_lock(task_to_runqueue(t)));
+}
+
+/*
+ * Lock runqueue associated with task and disable interrupts
+ */
+static inline void lock_task_rq_irq(struct task_struct *t)
+{
+	int rq = t->processor;
+
+	spin_lock_irq(&runqueue_lock(rq));
+	while (t->processor != rq) {
+		spin_unlock_irq(&runqueue_lock(rq));
+		rq = t->processor;
+		spin_lock_irq(&runqueue_lock(rq));
+	}
+}
+
+/*
+ * Unlock runqueue associated with task and enable interrupts
+ */
+static inline void unlock_task_rq_irq(struct task_struct *t)
+{
+	spin_unlock_irq(&runqueue_lock(t->processor));
+}
+
+/*
+ * Common routine for both flavors of del_from_runqueue.
+ */
+static inline void del_from_runqueue_common(struct task_struct * p, int upd)
+{
+	int rq = task_to_runqueue(p);
+
+	nt_running(rq)--;
 	p->sleep_time = jiffies;
 	list_del(&p->run_list);
 	p->run_list.next = NULL;
+
+	if (max_na_ptr(rq) == p) {
+		if (upd) {
+			/*
+			 * If we want to update max_na_* valies for the
+			 * runqueue, then we scan the queue and look for
+			 * the FIRST schedulable task.  This is a 'good
+			 * enough' approximation.
+			 */
+			struct list_head *tmp;
+			struct task_struct *t, *tmp_task = NULL;
+			int weight, tmp_weight = 0;
+
+			list_for_each(tmp, &runqueue(rq)) {
+				t = list_entry(tmp, struct task_struct,
+								run_list);
+				if (!t->has_cpu) {
+					weight = na_goodness(t);
+					if (weight > tmp_weight) {
+						tmp_weight = weight;
+						tmp_task = t;
+						goto found_one;
+					}
+				}
+			}
+found_one:
+			if (tmp_weight) {
+				max_na_goodness(rq) = tmp_weight;
+				max_na_cpus_allowed(rq) =
+							tmp_task->cpus_allowed;
+				max_na_ptr(rq) = tmp_task;
+			} else {
+				max_na_goodness(rq) = NA_GOODNESS_INIT;
+				max_na_ptr(rq) = NULL;
+			}
+		} else {
+			max_na_goodness(rq) = NA_GOODNESS_INIT;
+			max_na_ptr(rq) = NULL;
+		}
+	}
 }
 
-static inline int task_on_runqueue(struct task_struct *p)
+/*
+ * del_from_runqueue without updating max_na_* values.  Used in
+ * places where we know we will updating these values before
+ * dropping the runqueue lock.
+ */
+static inline void del_from_runqueue(struct task_struct * p)
 {
-	return (p->run_list.next != NULL);
+	del_from_runqueue_common(p, 0);
 }
+
+/*
+ * del_from_runqueue_update will update the max_na_* values
+ * if necessary.
+ */
+static inline void del_from_runqueue_update(struct task_struct * p)
+{
+	del_from_runqueue_common(p, 1);
+}
+#else
+static inline void del_from_runqueue(struct task_struct * p)
+{
+	nr_running--;
+	p->sleep_time = jiffies;
+	list_del(&p->run_list);
+	p->run_list.next = NULL;
+}
+#endif
 
 static inline void unhash_process(struct task_struct *p)
 {
diff -Naur linux-2.4.7/kernel/fork.c linux-2.4.7-mq/kernel/fork.c
--- linux-2.4.7/kernel/fork.c	Wed Jul 18 01:23:28 2001
+++ linux-2.4.7-mq/kernel/fork.c	Mon Aug  6 15:59:32 2001
@@ -27,7 +27,9 @@
 
 /* The idle threads do not count.. */
 int nr_threads;
+#ifndef CONFIG_SMP
 int nr_running;
+#endif
 
 int max_threads;
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
diff -Naur linux-2.4.7/kernel/sched.c linux-2.4.7-mq/kernel/sched.c
--- linux-2.4.7/kernel/sched.c	Wed Jul 18 01:30:50 2001
+++ linux-2.4.7-mq/kernel/sched.c	Mon Aug  6 17:10:18 2001
@@ -78,33 +78,42 @@
 /*
  * The tasklist_lock protects the linked list of processes.
  *
- * The runqueue_lock locks the parts that actually access
- * and change the run-queues, and have to be interrupt-safe.
- *
  * If both locks are to be concurrently held, the runqueue_lock
  * nests inside the tasklist_lock.
  *
  * task->alloc_lock nests inside tasklist_lock.
  */
-spinlock_t runqueue_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;  /* inner */
 rwlock_t tasklist_lock __cacheline_aligned = RW_LOCK_UNLOCKED;	/* outer */
 
+#ifdef CONFIG_SMP
+/*
+ * There are NR_CPUS + 1 run queues.  In addition to CPU specific
+ * runqueues there is a realtime runqueue so that any CPU can easily
+ * schedule realtime tasks.  All CPUs can schedule tasks from the
+ * realtime runqueue (with appropriate locking of course).
+ * Initializatoin is performed in sched_init().
+ */
+runqueue_data_t runqueue_data [NR_CPUS+1] __cacheline_aligned;
+#else
+/*
+ * The run-queue lock locks the parts that actually access
+ * and change the run-queues, and have to be interrupt-safe.
+ */
+spinlock_t runqueue_lock __cacheline_aligned = SPIN_LOCK_UNLOCKED;  /* inner */
 static LIST_HEAD(runqueue_head);
+#endif
 
 /*
  * We align per-CPU scheduling data on cacheline boundaries,
  * to prevent cacheline ping-pong.
  */
-static union {
-	struct schedule_data {
-		struct task_struct * curr;
-		cycles_t last_schedule;
-	} schedule_data;
-	char __pad [SMP_CACHE_BYTES];
-} aligned_data [NR_CPUS] __cacheline_aligned = { {{&init_task,0}}};
-
-#define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
-#define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
+#ifdef CONFIG_SMP
+aligned_data_t aligned_data [NR_CPUS] __cacheline_aligned =
+			{ {{&init_task,NA_GOODNESS_INIT,0}}};
+#else
+aligned_data_t aligned_data [NR_CPUS] __cacheline_aligned =
+			{ {{&init_task,0}}};
+#endif
 
 struct kernel_stat kstat;
 
@@ -113,6 +122,8 @@
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
 #define can_schedule(p,cpu) ((!(p)->has_cpu) && \
 				((p)->cpus_allowed & (1 << cpu)))
+#define local_can_schedule(p) (!(p)->has_cpu)
+#define this_cpu_allowed(ca, tcpu) ((ca) & (1 << tcpu))
 
 #else
 
@@ -123,6 +134,50 @@
 
 void scheduling_functions_start_here(void) { }
 
+#ifdef CONFIG_SMP
+/*
+ * Sum CPU specific nt_running fields to determine how many
+ * runnable tasks there are in the system.  Replacement for
+ * the global nr_running variable.
+ */
+int
+nr_running(void) {
+	int i;
+	int tot=nt_running(REALTIME_RQ);
+
+	for(i=0; i<smp_num_cpus; i++) {
+		tot += nt_running(cpu_logical_map(i));
+	}
+
+	return(tot);
+}
+
+/*
+ * A stripped down version of the goodness routine for use on a CPU
+ * specific runqueue.  This routine does not need to be concerned
+ * with realtime tasks, and does not need to take CPU affinity into
+ * account.
+ */
+static inline int local_goodness(struct task_struct * p, struct mm_struct *this_mm)
+{
+	int weight;
+
+	weight = -1;
+	if (p->policy & SCHED_YIELD)
+		goto local_out;
+
+	weight = p->counter;
+	if (!weight)
+		goto local_out;
+			
+	if (p->mm == this_mm || !p->mm)
+		weight += 1;
+	weight += 20 - p->nice;
+local_out:
+	return weight;
+}
+#endif
+
 /*
  * This is the function that decides how desirable a process is..
  * You can weigh different processes against each other depending
@@ -199,92 +254,213 @@
 }
 
 /*
- * This is ugly, but reschedule_idle() is very timing-critical.
- * We are called with the runqueue spinlock held and we must
- * not claim the tasklist_lock.
+ * Careful!
+ *
+ * This has to add the process to the _beginning_ of the
+ * run-queue, not the end. See the comment about "This is
+ * subtle" in the scheduler proper..
+ */
+static inline void add_to_runqueue(struct task_struct * p)
+{
+#ifdef CONFIG_SMP
+	int rq = task_to_runqueue(p);
+	int tsk_na_goodness = na_goodness(p);
+
+	list_add(&p->run_list, &runqueue(rq));
+
+	if (!p->has_cpu && (tsk_na_goodness > max_na_goodness(rq))) {
+		max_na_goodness(rq) = tsk_na_goodness;
+		max_na_cpus_allowed(rq) = p->cpus_allowed;
+		max_na_ptr(rq) = p;
+	}
+
+	nt_running(rq)++;
+#else
+	list_add(&p->run_list, &runqueue_head);
+	nr_running++;
+#endif
+}
+
+/*
+ * The runqueue lock must be held upon entry to this routine.
  */
 static FASTCALL(void reschedule_idle(struct task_struct * p));
 
 static void reschedule_idle(struct task_struct * p)
 {
 #ifdef CONFIG_SMP
-	int this_cpu = smp_processor_id();
-	struct task_struct *tsk, *target_tsk;
-	int cpu, best_cpu, i, max_prio;
-	cycles_t oldest_idle;
+	struct task_struct *tsk;
+	int target_cpu, this_cpu, tsk_cpu;
+	int i, cpu;
+	int need_resched;
+	cycles_t curr_cycles, tmp_cycles;
+	int stack_list[NR_CPUS];
+	int saved_na_goodness, tmp_min_na_goodness;
+
+	tsk_cpu = p->processor;
+	this_cpu = smp_processor_id();
+	/*
+	 * First check if the task's previous CPU is idle,  use it if it is.
+	 */
+	if (can_schedule(p, tsk_cpu) &&
+	    (cpu_curr(tsk_cpu) == idle_task(tsk_cpu))) {
+		if (!task_on_runqueue(p)) {
+			add_to_runqueue(p);
+		}
+		tsk = cpu_curr(tsk_cpu);
+		need_resched = tsk->need_resched;
+		tsk->need_resched = 1;
+		if ((tsk_cpu != this_cpu) && !need_resched) {
+			smp_send_reschedule(tsk_cpu);
+		}
+		return;
+	}
 
 	/*
-	 * shortcut if the woken up task's last CPU is
-	 * idle now.
-	 */
-	best_cpu = p->processor;
-	if (can_schedule(p, best_cpu)) {
-		tsk = idle_task(best_cpu);
-		if (cpu_curr(best_cpu) == tsk) {
-			int need_resched;
-send_now_idle:
+	 * Create a list of current na_goodness values on our stack.
+	 * Only values less than the non-affinity goodness value of
+	 * p should be considered for preemption.
+	 */
+	saved_na_goodness = na_goodness(p) - 1; /* preemption_goodness() > 1 */
+	tmp_min_na_goodness = saved_na_goodness;
+	curr_cycles = get_cycles();
+	target_cpu = -1;
+	for (i = 0; i < smp_num_cpus; i++) {
+		cpu = cpu_logical_map(i);
+
+		if (!can_schedule(p, cpu)) {
+			stack_list[cpu] = saved_na_goodness;
+			continue;
+		}
+
+		if (curr_na_goodness(cpu) == NA_GOODNESS_INIT) {
 			/*
-			 * If need_resched == -1 then we can skip sending
-			 * the IPI altogether, tsk->need_resched is
-			 * actively watched by the idle thread.
+			 * Indicates an idle task.  For idle tasks, determine
+			 * the amount of time they have been idle.  Use the
+			 * negative of this value in the list.  Hence, we
+			 * first choose the CPU that has been idle the longest.
 			 */
-			need_resched = tsk->need_resched;
-			tsk->need_resched = 1;
-			if ((best_cpu != this_cpu) && !need_resched)
-				smp_send_reschedule(best_cpu);
-			return;
+			tmp_cycles = curr_cycles - last_schedule(cpu);
+			if (tmp_cycles > INT_MAX) {
+				stack_list[cpu] = INT_MIN;
+			} else {
+				stack_list[cpu] = (int)-tmp_cycles;
+			}
+		} else {
+			stack_list[cpu] = curr_na_goodness(cpu);
+			/*
+			 * Add in PROC_CHANGE_PENALTY for remote CPUs
+			 */
+			if (cpu != tsk_cpu) {
+				stack_list[cpu] += PROC_CHANGE_PENALTY;
+			}
+		}
+
+		/*
+		 * Look for the lowest value
+		 */
+		if (stack_list[cpu] < tmp_min_na_goodness) {
+			target_cpu = cpu;
+			tmp_min_na_goodness = stack_list[cpu];
 		}
 	}
 
 	/*
-	 * We know that the preferred CPU has a cache-affine current
-	 * process, lets try to find a new idle CPU for the woken-up
-	 * process. Select the least recently active idle CPU. (that
-	 * one will have the least active cache context.) Also find
-	 * the executing process which has the least priority.
-	 */
-	oldest_idle = (cycles_t) -1;
-	target_tsk = NULL;
-	max_prio = 1;
+	 * We try to add the task to a runqueue starting with the one
+	 * that has the lowest na_goodness value.
+	 */
+	while (target_cpu != -1) {
+		if (target_cpu == tsk_cpu &&
+		    preemption_goodness((tsk = cpu_curr(target_cpu)),
+					p, target_cpu) > 1) {
+			/*
+			 * If target_cpu is tsk_cpu, then no additional
+			 * locking is required (we already have the CPU
+			 * specific runqueue locked).  We also know that
+			 * this CPU can not be idle, otherwise the fast
+			 * path at the beginning of this routine would
+			 * have been executed.  Therefore, simply send
+			 * the IPI if required.
+			 */
+			if (!task_on_runqueue(p)) {
+				add_to_runqueue(p);
+			}
+			tsk = cpu_curr(target_cpu);
+			tsk->need_resched = 1;
+			if (target_cpu != this_cpu) {
+				smp_send_reschedule(target_cpu);
+			}
+			return;
+		}
 
-	for (i = 0; i < smp_num_cpus; i++) {
-		cpu = cpu_logical_map(i);
-		if (!can_schedule(p, cpu))
-			continue;
-		tsk = cpu_curr(cpu);
 		/*
-		 * We use the first available idle CPU. This creates
-		 * a priority list between idle CPUs, but this is not
-		 * a problem.
+		 * Try to lock runqueue and verify na_goodness value.
 		 */
-		if (tsk == idle_task(cpu)) {
-			if (last_schedule(cpu) < oldest_idle) {
-				oldest_idle = last_schedule(cpu);
-				target_tsk = tsk;
-			}
-		} else {
-			if (oldest_idle == -1ULL) {
-				int prio = preemption_goodness(tsk, p, cpu);
+		else if (spin_trylock(&runqueue_lock(target_cpu))) {
+			tsk = cpu_curr(target_cpu);
+			if ((tsk == idle_task(target_cpu)) ||
+			     (preemption_goodness(tsk, p, target_cpu) > 1)) {
+				/*
+				 * Target CPU is idle, or it is running
+				 * a task with lower priority than p.
+				 * Therefore, move p to target runqueue.
+				 */
+				if (task_on_runqueue(p)) {
+					del_from_runqueue_update(p);
+				}
+				p->processor = target_cpu;
+				add_to_runqueue(p);
 
-				if (prio > max_prio) {
-					max_prio = prio;
-					target_tsk = tsk;
+				/*
+				 * Send an IPI to target CPU, unless the
+				 * CPU is idle and the need_resched flag
+				 * has already been set.
+				 */
+				need_resched = tsk->need_resched;
+				tsk->need_resched = 1;
+				if ((target_cpu != this_cpu) &&
+				    ((tsk != idle_task(target_cpu)) ||
+				      !need_resched)){
+					smp_send_reschedule(target_cpu);
 				}
+
+				spin_unlock(&runqueue_lock(target_cpu));
+
+				return;
 			}
+			spin_unlock(&runqueue_lock(target_cpu));
 		}
-	}
-	tsk = target_tsk;
-	if (tsk) {
-		if (oldest_idle != -1ULL) {
-			best_cpu = tsk->processor;
-			goto send_now_idle;
+
+		/*
+		 * Update list value so we don't check this CPU again.
+		 */
+		stack_list[target_cpu] = saved_na_goodness;
+
+		/*
+		 * Find the 'next lowest' cur_na_goodness value.
+		 */
+		target_cpu = -1;
+		tmp_min_na_goodness = saved_na_goodness;
+		for (i = 0; i < smp_num_cpus; i++) {
+			cpu = cpu_logical_map(i);
+			if (stack_list[cpu] < tmp_min_na_goodness) {
+				target_cpu = cpu;
+				tmp_min_na_goodness = stack_list[cpu];
+			}
 		}
-		tsk->need_resched = 1;
-		if (tsk->processor != this_cpu)
-			smp_send_reschedule(tsk->processor);
+	}
+
+	/*
+	 * If we get here, it means that the best place for the task is
+	 * on its currently assigned runqueue.  Also, we know that the
+	 * task currently running on the this tasks runqueue has sufficuent
+	 * priority to prevent preemption.  Hence, we simply ensure the
+	 * task is on the runqueue.
+	 */
+	if (!task_on_runqueue(p)) {
+		add_to_runqueue(p);
 	}
 	return;
-		
 
 #else /* UP */
 	int this_cpu = smp_processor_id();
@@ -296,29 +472,46 @@
 #endif
 }
 
+#ifdef CONFIG_SMP
 /*
- * Careful!
- *
- * This has to add the process to the _beginning_ of the
- * run-queue, not the end. See the comment about "This is
- * subtle" in the scheduler proper..
+ * Lock runqueue associated with task's CPU and save irq state
+ * NOTE that this is different than locking the runqueue associated
+ * with the task (specifically for realtime tasks).
  */
-static inline void add_to_runqueue(struct task_struct * p)
+static inline int lock_task_cpu_rq_irqsave(struct task_struct *t,
+						unsigned long *flags)
 {
-	list_add(&p->run_list, &runqueue_head);
-	nr_running++;
+	int rq = t->processor;
+
+	spin_lock_irqsave(&runqueue_lock(rq), *flags);
+	while (t->processor != rq) {
+		spin_unlock_irqrestore(&runqueue_lock(rq), *flags);
+		rq = t->processor;
+		spin_lock_irqsave(&runqueue_lock(rq), *flags);
+	}
+
+	return(rq);
 }
+#endif
 
 static inline void move_last_runqueue(struct task_struct * p)
 {
 	list_del(&p->run_list);
+#ifdef CONFIG_SMP
+	list_add_tail(&p->run_list, &runqueue(task_to_runqueue(p)));
+#else
 	list_add_tail(&p->run_list, &runqueue_head);
+#endif
 }
 
 static inline void move_first_runqueue(struct task_struct * p)
 {
 	list_del(&p->run_list);
+#ifdef CONFIG_SMP
+	list_add(&p->run_list, &runqueue(task_to_runqueue(p)));
+#else
 	list_add(&p->run_list, &runqueue_head);
+#endif
 }
 
 /*
@@ -333,20 +526,47 @@
 {
 	unsigned long flags;
 	int success = 0;
+#ifdef CONFIG_SMP
+	int rq;
+
+	rq = lock_task_cpu_rq_irqsave(p, &flags);
+	if (task_to_runqueue(p) == REALTIME_RQ) {
+		/*
+		 * Indicates p is a realtime task.  We must
+		 * also lock the realtime runqueue.
+		 */
+		spin_lock(&runqueue_lock(REALTIME_RQ));
+	}
+#else
+	spin_lock_irqsave(&runqueue_lock, flags);
+#endif
 
 	/*
 	 * We want the common case fall through straight, thus the goto.
 	 */
-	spin_lock_irqsave(&runqueue_lock, flags);
 	p->state = TASK_RUNNING;
 	if (task_on_runqueue(p))
 		goto out;
+#ifndef CONFIG_SMP
 	add_to_runqueue(p);
 	if (!synchronous || !(p->cpus_allowed & (1 << smp_processor_id())))
 		reschedule_idle(p);
+#else
+	if (!synchronous || !(p->cpus_allowed & (1 << smp_processor_id())))
+		reschedule_idle(p);
+	else
+		add_to_runqueue(p);
+#endif
 	success = 1;
 out:
+#ifdef CONFIG_SMP
+	if (task_to_runqueue(p) == REALTIME_RQ) {
+		spin_unlock(&runqueue_lock(REALTIME_RQ));
+	}
+	spin_unlock_irqrestore(&runqueue_lock(rq), flags);
+#else
 	spin_unlock_irqrestore(&runqueue_lock, flags);
+#endif
 	return success;
 }
 
@@ -449,6 +669,7 @@
 {
 #ifdef CONFIG_SMP
 	int policy;
+	int rq;
 
 	/*
 	 * prev->policy can be written from here only before `prev'
@@ -501,15 +722,27 @@
 						(policy & SCHED_YIELD))
 			goto out_unlock;
 
-		spin_lock_irqsave(&runqueue_lock, flags);
+		rq = lock_task_cpu_rq_irqsave(prev, &flags);
+		if (task_to_runqueue(prev) == REALTIME_RQ) {
+			/*
+			 * Indicates prev is a realtime task.  We must
+			 * also lock the realtime runqueue.
+			 */
+			spin_lock(&runqueue_lock(REALTIME_RQ));
+		}
+
 		if ((prev->state == TASK_RUNNING) && !prev->has_cpu)
 			reschedule_idle(prev);
-		spin_unlock_irqrestore(&runqueue_lock, flags);
+
+		if (task_to_runqueue(prev) == REALTIME_RQ) {
+			spin_unlock(&runqueue_lock(REALTIME_RQ));
+		}
+		spin_unlock_irqrestore(&runqueue_lock(rq), flags); 
 		goto out_unlock;
 	}
 #else
 	prev->policy &= ~SCHED_YIELD;
-#endif /* CONFIG_SMP */
+#endif
 }
 
 void schedule_tail(struct task_struct *prev)
@@ -518,10 +751,7 @@
 }
 
 /*
- *  'schedule()' is the scheduler function. It's a very simple and nice
- * scheduler: it's not perfect, but certainly works for most things.
- *
- * The goto is "interesting".
+ *  'schedule()' is the scheduler function.
  *
  *   NOTE!!  Task 0 is the 'idle' task, which gets called when no other
  * tasks can run. It can not be killed, and it cannot sleep. The 'state'
@@ -529,28 +759,42 @@
  */
 asmlinkage void schedule(void)
 {
-	struct schedule_data * sched_data;
 	struct task_struct *prev, *next, *p;
 	struct list_head *tmp;
 	int this_cpu, c;
+#ifdef CONFIG_SMP
+	struct task_struct *prev_next;
+	int tmp_na_goodness, prev_next_weight;
+	int prev_rq, rrq, rq, rcpu;
+	int stack_list[NR_CPUS];
+	int premature_idle;
+#endif
 
 	if (!current->active_mm) BUG();
 need_resched_back:
 	prev = current;
 	this_cpu = prev->processor;
+#ifdef CONFIG_SMP
+	prev_rq = task_to_runqueue(prev);
+#endif
 
 	if (in_interrupt())
 		goto scheduling_in_interrupt;
 
 	release_kernel_lock(prev, this_cpu);
 
-	/*
-	 * 'sched_data' is protected by the fact that we can run
-	 * only one process per CPU.
-	 */
-	sched_data = & aligned_data[this_cpu].schedule_data;
-
+#ifdef CONFIG_SMP
+	spin_lock_irq(&runqueue_lock(this_cpu));
+	if (prev_rq != this_cpu) {
+		/*
+		 * Indicates curent is a realtime task.  We must also
+		 * lock the realtime runqueue.
+		 */
+		spin_lock(&runqueue_lock(REALTIME_RQ));
+	}
+#else
 	spin_lock_irq(&runqueue_lock);
+#endif
 
 	/* move an exhausted RR process to be last.. */
 	if (prev->policy == SCHED_RR)
@@ -579,10 +823,15 @@
 	 */
 	next = idle_task(this_cpu);
 	c = -1000;
+#ifdef CONFIG_SMP
+	prev_next = next;
+	prev_next_weight = c;
+#endif
 	if (prev->state == TASK_RUNNING)
 		goto still_running;
 
 still_running_back:
+#ifndef CONFIG_SMP
 	list_for_each(tmp, &runqueue_head) {
 		p = list_entry(tmp, struct task_struct, run_list);
 		if (can_schedule(p, this_cpu)) {
@@ -591,21 +840,212 @@
 				c = weight, next = p;
 		}
 	}
+#else
+	/*
+	 * There exists a separate realtime runqueue for all realtime
+	 * tasks.  Any CPU can schedule a task from the realtime runqueue.
+	 *
+	 * We scan the realtime runqueue if either,
+	 * - The current task is a realtime task. Hence, the realtime
+	 *   run-queue is already locked.
+	 * - There is a task on the realtime runqueue.  In this case we
+	 *   must acquire the realtime runqueue lock here.
+	 * Otherwise, we skip the scan of the realtime runqueue.
+	 */
+	if (prev_rq == REALTIME_RQ || nt_running(REALTIME_RQ)) {
+		goto scan_rt_queue;
+	}
+scan_rt_queue_back:
+
+	/*
+	 * Search CPU specific runqueue
+	 */
+	list_for_each(tmp, &runqueue(this_cpu)) {
+		p = list_entry(tmp, struct task_struct, run_list);
+		if (local_can_schedule(p)) {
+			int weight = local_goodness(p, prev->active_mm);
+			if (weight > c) {
+				if (!next->has_cpu) {
+					/*
+					 * prev_next must point to a
+					 * schedulable task.
+					 */
+					prev_next_weight = c;
+					prev_next = next;
+				}
+				c = weight;
+				next = p;
+			} else if (weight > prev_next_weight) {
+				prev_next_weight = weight;
+				prev_next = p;
+			}
+		}
+	}
+
+	/*
+	 * If next task is realtime, there is no need to look at other
+	 * runqueues.  Simply set max_na_goodness values appropriately.
+	 */
+	if (task_to_runqueue(next) == REALTIME_RQ) {
+		goto set_max_na_goodness;
+	}
+
+	/*
+	 * As calculated above, c does not contain a CPU affinity boost.
+	 * We must add this boost before comparing to tasks on other
+	 * runqueues.  Only add PROC_CHANGE_PENALTY if c is a positive
+	 * goodness value.
+	 */
+	if (c > 0) {
+		c += PROC_CHANGE_PENALTY;
+	}
+
+	/*
+	 * Copy max_na_goodness values from CPU specific runqueue
+	 * structures to the list on our stack.
+	 */
+scan_rmt_queues:
+	premature_idle = 0;
+	rrq = -1;
+	tmp_na_goodness = c;
+	for (rq = 0; rq < smp_num_cpus; rq++) {
+		rcpu = cpu_logical_map(rq);
+		if (rcpu == this_cpu) {
+			stack_list[rcpu] = NA_GOODNESS_INIT;
+			continue;
+		}
+		if (!this_cpu_allowed(max_na_cpus_allowed(rcpu), this_cpu)) {
+			stack_list[rcpu] = NA_GOODNESS_INIT;
+			continue;
+		}
+		if (max_na_goodness(rcpu) <= c) {
+			stack_list[rcpu] = NA_GOODNESS_INIT;
+			continue;
+		}
+
+		stack_list[rcpu] = max_na_goodness(rcpu);
+		if (stack_list[rcpu] > tmp_na_goodness) {
+			rrq = rcpu;
+			tmp_na_goodness = stack_list[rcpu];
+		}
+	}
+
+	/*
+	 * Now use the values from the stack list to search for a
+	 * task to steal.
+	 */
+	while (rrq != -1) {
+		/*
+		 * First try to lock the remote runqueue and verify
+		 * the max_na_goodness value.
+		 */
+		if (spin_trylock(&runqueue_lock(rrq))) {
+			if (max_na_goodness(rrq) > c && 
+			    this_cpu_allowed(max_na_cpus_allowed(rrq),
+								this_cpu)) {
+				/*
+				 * Move a remote task to our runqueue
+				 */
+				if (!next->has_cpu) {
+					prev_next = next;
+				}
+				next = max_na_ptr(rrq);
+				c = max_na_goodness(rrq);
+				del_from_runqueue_update(next);
+				next->processor = this_cpu;
+				add_to_runqueue(next);
+
+				/*
+				 * We have stolen a task from another
+				 * runqueue, quit looking.
+				 */
+				spin_unlock(&runqueue_lock(rrq));
+				break;
+			}
+			spin_unlock(&runqueue_lock(rrq));
+		} else {
+			premature_idle++;
+		}
+
+		/*
+		 * We were either unable to get the remote runqueue lock,
+		 * or the remote runqueue has changed such that it is no
+		 * longer desirable to steal a task from the queue.
+		 *
+		 * Go to the runqueue with the 'next highest' max_na_goodness
+		 * value.
+		 */
+		stack_list[rrq] = NA_GOODNESS_INIT;
+		tmp_na_goodness = c;
+		rrq = -1;
+		for (rq = 0; rq < smp_num_cpus; rq++) {
+			rcpu = cpu_logical_map(rq);
+			if (stack_list[rcpu] > tmp_na_goodness) {
+				rrq = rcpu;
+				tmp_na_goodness = stack_list[rcpu];
+			}
+		}
+	}
+
+	/*
+	 * Check for going idle prematurely.  If this is the case, there
+	 * is a good chance there are schedulable tasks on other runquueues.
+	 */
+	if ((next == idle_task(this_cpu)) && premature_idle) {
+		/*
+		 * Be sure to clear max_na_goodness, otherwise there
+		 * is the potential for deadlock.
+		 */
+		max_na_goodness(this_cpu) = NA_GOODNESS_INIT;
+		goto scan_rmt_queues;
+	}
+#endif
 
 	/* Do we need to re-calculate counters? */
 	if (!c)
 		goto recalculate;
+
+#ifdef CONFIG_SMP
+set_max_na_goodness:
+	/*
+	 * Make sure max_na_* values for runqueue are updated
+	 */
+	if (prev_next != idle_task(this_cpu)) {
+		max_na_goodness(this_cpu) = na_goodness(prev_next);
+		max_na_cpus_allowed(this_cpu) = prev_next->cpus_allowed;
+		max_na_ptr(this_cpu) = prev_next;
+	} else {
+		max_na_goodness(this_cpu) = NA_GOODNESS_INIT;
+		/* max_na_cpus_allowed need not be set */
+		max_na_ptr(this_cpu) = NULL;
+	}
+
+	/*
+	 * Update scheduling fields in next task structure.
+	 */
+ 	next->has_cpu = 1;
+found_next:
+	next->processor = this_cpu;
+
+#endif
 	/*
 	 * from this point on nothing can prevent us from
 	 * switching to the next task, save this fact in
 	 * sched_data.
 	 */
-	sched_data->curr = next;
+	cpu_curr(this_cpu) = next;
 #ifdef CONFIG_SMP
- 	next->has_cpu = 1;
-	next->processor = this_cpu;
-#endif
+	if (next != idle_task(this_cpu)) {
+		curr_na_goodness(this_cpu) = na_goodness(next);
+		running_non_idle(this_cpu) = 1;
+	} else {
+		curr_na_goodness(this_cpu) = NA_GOODNESS_INIT;
+		running_non_idle(this_cpu) = 0;
+	}
+	spin_unlock_irq(&runqueue_lock(this_cpu));
+#else
 	spin_unlock_irq(&runqueue_lock);
+#endif
 
 	if (prev == next) {
 		/* We won't go through the normal tail, so do this by hand */
@@ -621,7 +1061,7 @@
 	 * and it's approximate, so we do not have to maintain
 	 * it while holding the runqueue spinlock.
  	 */
- 	sched_data->last_schedule = get_cycles();
+ 	last_schedule(this_cpu) = get_cycles();
 
 	/*
 	 * We drop the scheduler lock early (it's a global spinlock),
@@ -629,7 +1069,7 @@
 	 * rescheduled during switch_to().
 	 */
 
-#endif /* CONFIG_SMP */
+#endif
 
 	kstat.context_swtch++;
 	/*
@@ -678,18 +1118,42 @@
 recalculate:
 	{
 		struct task_struct *p;
+#ifdef CONFIG_SMP
+		spin_unlock_irq(&runqueue_lock(this_cpu));
+#else
 		spin_unlock_irq(&runqueue_lock);
+#endif
 		read_lock(&tasklist_lock);
 		for_each_task(p)
 			p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
 		read_unlock(&tasklist_lock);
+#ifdef CONFIG_SMP
+		spin_lock_irq(&runqueue_lock(this_cpu));
+#else
 		spin_lock_irq(&runqueue_lock);
+#endif
 	}
 	goto repeat_schedule;
 
 still_running:
-	if (!(prev->cpus_allowed & (1UL << this_cpu)))
+#ifdef CONFIG_SMP
+	if (!(prev->cpus_allowed & (1UL << this_cpu))) {
+		unsigned long allowed = prev->cpus_allowed;
+		/*
+		 * task is no longer runnable on this CPU.  We remove it
+		 * from the runqueue to ensure that it will not be considered
+		 * for scheduling here.  Let schedule_tail take care of
+		 * sending it off to an appropriate CPU.
+		 */
+		del_from_runqueue(prev);
+		prev->processor = 0;
+		while (!(allowed & 1UL)) {
+			prev->processor++;
+			allowed = allowed >> 1;
+		}
 		goto still_running_back;
+	}
+#endif
 	c = goodness(prev, this_cpu, prev->active_mm);
 	next = prev;
 	goto still_running_back;
@@ -701,6 +1165,54 @@
 	}
 	goto move_rr_back;
 
+#ifdef CONFIG_SMP
+scan_rt_queue:
+	if (prev_rq != REALTIME_RQ) {
+		spin_lock(&runqueue_lock(REALTIME_RQ));
+	}
+	/*
+	 * Scan the queue.  Note that there is no need to
+	 * keep track of max_na_goodness values for the
+	 * realtime runqueue, as they are never used in
+	 * scheduling decisions.
+	 */
+	list_for_each(tmp, &runqueue(REALTIME_RQ)) {
+		p = list_entry(tmp, struct task_struct, run_list);
+		if (can_schedule(p, this_cpu)) {
+			int weight = 1000 + p->rt_priority;
+			if (weight > c)
+				c = weight, next = p;
+		}
+	}
+
+	/*
+	 * Unlock the realtime runqueue before continuing.  If we
+	 * selected a realtime task to execute, be sure to make it
+	 * non-schedulable (set has_cpu) before releasing the lock.
+	 * Note that we still hold the CPU specific runqueue lock.
+	 */
+	if (next != idle_task(this_cpu)) {
+		next->has_cpu = 1;
+	}
+	spin_unlock(&runqueue_lock(REALTIME_RQ));
+
+	/*
+	 * If we find a realtime task to schedule we are mostly done.
+	 * However, the max_na_goodness value of this CPU's runqueue
+	 * may need to be set to an appropriate value (so that other
+	 * CPUs can steal tasks while this CPU runs the realtime task).
+	 * If necessary, make a pass through the CPU specific runqueue
+	 * to set the value.
+	 */
+	if ((task_to_runqueue(next) == REALTIME_RQ) &&
+	    ((max_na_goodness(this_cpu) != NA_GOODNESS_INIT) ||
+	     !nt_running(this_cpu)) ) {
+		goto found_next;
+	}
+
+	goto scan_rt_queue_back;
+#endif
+
 scheduling_in_interrupt:
 	printk("Scheduling in interrupt\n");
 	BUG();
@@ -909,6 +1421,8 @@
 	struct sched_param lp;
 	struct task_struct *p;
 	int retval;
+	int lock_rt = 0;
+	int was_on_rq = 0;
 
 	retval = -EINVAL;
 	if (!param || pid < 0)
@@ -918,18 +1432,31 @@
 	if (copy_from_user(&lp, param, sizeof(struct sched_param)))
 		goto out_nounlock;
 
+	retval = -ESRCH;
+#ifdef CONFIG_SMP
+	/*
+	 * Note that here we get the tasklist lock so that we can
+	 * find the task struct.  Not until we have access to the
+	 * task struct can we determine what runqueue to lock.
+	 */
+	read_lock(&tasklist_lock);
+	p = find_process_by_pid(pid);
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		goto out_nounlock;
+	}
+	lock_task_rq_irq(p);
+#else
 	/*
 	 * We play safe to avoid deadlocks.
 	 */
 	read_lock_irq(&tasklist_lock);
 	spin_lock(&runqueue_lock);
-
 	p = find_process_by_pid(pid);
-
-	retval = -ESRCH;
 	if (!p)
 		goto out_unlock;
-			
+#endif
+
 	if (policy < 0)
 		policy = p->policy;
 	else {
@@ -958,16 +1485,49 @@
 		goto out_unlock;
 
 	retval = 0;
+
+#ifdef CONFIG_SMP
+	if ((p->policy != SCHED_OTHER) || (policy != SCHED_OTHER)) {
+		/*
+		 * If changing to/from a realtime policy,  OR simply
+		 * changing the priority of a realtime task, we must
+		 * lock the realtime runqueue.
+		 */
+		spin_lock(&runqueue_lock(REALTIME_RQ));
+		lock_rt = 1;
+	}
+
+	if (task_on_runqueue(p)) {
+		del_from_runqueue_update(p);
+		was_on_rq = 1;
+	}
+	p->policy = policy;
+	p->rt_priority = lp.sched_priority;
+	if (was_on_rq) {
+		add_to_runqueue(p);
+	}
+	current->need_resched = 1;
+
+	if (lock_rt) {
+		spin_unlock(&runqueue_lock(REALTIME_RQ));
+	}
+#else
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
 	if (task_on_runqueue(p))
 		move_first_runqueue(p);
 
 	current->need_resched = 1;
+#endif
 
 out_unlock:
+#ifdef CONFIG_SMP
+	unlock_task_rq_irq(p);
+	read_unlock(&tasklist_lock);
+#else
 	spin_unlock(&runqueue_lock);
 	read_unlock_irq(&tasklist_lock);
+#endif
 
 out_nounlock:
 	return retval;
@@ -1044,19 +1604,18 @@
 	 * to be atomic.) In threaded applications this optimization
 	 * gets triggered quite often.
 	 */
-
-	int nr_pending = nr_running;
-
 #if CONFIG_SMP
+	int nr_pending = nt_running(REALTIME_RQ);
 	int i;
 
 	// Substract non-idle processes running on other CPUs.
 	for (i = 0; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i);
-		if (aligned_data[cpu].schedule_data.curr != idle_task(cpu))
-			nr_pending--;
+		nr_pending += (nt_running(cpu) - running_non_idle(cpu));
 	}
 #else
+	int nr_pending = nr_running;
+
 	// on UP this process is on the runqueue as well
 	nr_pending--;
 #endif
@@ -1270,6 +1829,21 @@
 	 */
 	int cpu = smp_processor_id();
 	int nr;
+
+#ifdef CONFIG_SMP
+	/*
+	 * Initialize the scheduling data structures
+	 */
+	for (nr = 0; nr < NR_CPUS+1; nr++) {
+		runqueue_lock(nr) = SPIN_LOCK_UNLOCKED;
+		INIT_LIST_HEAD(&runqueue(nr));
+		max_na_goodness(nr) = NA_GOODNESS_INIT;
+		/* max_na_cpus_allowed need not be initialized */
+		max_na_ptr(nr) = NULL;
+		nt_running(nr) = 0;
+		running_non_idle(nr) = 0;
+	}
+#endif
 
 	init_task.processor = cpu;
 
diff -Naur linux-2.4.7/kernel/signal.c linux-2.4.7-mq/kernel/signal.c
--- linux-2.4.7/kernel/signal.c	Thu Jan  4 04:45:26 2001
+++ linux-2.4.7-mq/kernel/signal.c	Mon Aug  6 15:59:32 2001
@@ -483,10 +483,10 @@
 	 * process of changing - but no harm is done by that
 	 * other than doing an extra (lightweight) IPI interrupt.
 	 */
-	spin_lock(&runqueue_lock);
+	lock_task_rq(t);
 	if (t->has_cpu && t->processor != smp_processor_id())
 		smp_send_reschedule(t->processor);
-	spin_unlock(&runqueue_lock);
+	unlock_task_rq(t);
 #endif /* CONFIG_SMP */
 }
 
diff -Naur linux-2.4.7/kernel/timer.c linux-2.4.7-mq/kernel/timer.c
--- linux-2.4.7/kernel/timer.c	Tue Jun 12 23:40:11 2001
+++ linux-2.4.7-mq/kernel/timer.c	Mon Aug  6 15:59:32 2001
@@ -587,6 +587,11 @@
 			p->counter = 0;
 			p->need_resched = 1;
 		}
+#ifdef CONFIG_SMP
+		if (curr_na_goodness(cpu) != NA_GOODNESS_INIT) {
+			curr_na_goodness(cpu) = na_goodness(p);
+		}
+#endif
 		if (p->nice > 0)
 			kstat.per_cpu_nice[cpu] += user_tick;
 		else
