Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278685AbRKOAHI>; Wed, 14 Nov 2001 19:07:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278722AbRKOAG7>; Wed, 14 Nov 2001 19:06:59 -0500
Received: from e31.co.us.ibm.com ([32.97.110.129]:15828 "EHLO
	e31.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S278714AbRKOAGf>; Wed, 14 Nov 2001 19:06:35 -0500
Date: Wed, 14 Nov 2001 16:06:30 -0800
From: Mike Kravetz <kravetz@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: [RFC][PATCH]Scalable Scheduling again
Message-ID: <20011114160630.D1112@w-mikek2.des.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since everyone else is throwing out scheduler patches, here is
another copy of our Multi-Queue scheduler for 2.4.14.  This version
has the code cleaned up to eliminate most (if not all) of the
offending #ifdefs.

One important aspect of this work is that it attempts to preserve
the behavior of the current Linux scheduler.  In other words, it
tries very hard (and goes to great pains) to make the same global
scheduling decisions as the current scheduler.  This is unlike a
traditional Multi-Queue scheduler which makes local decisions and
employs a global load balancing scheme. 

If nothing else, I would like to kick off a discussion of what
direction should be taken with respect to Scalable Scheduling.
Alan has already expressed some concerns with the scheduler, and
these seem to be addressed by Ingo's latest patch.  The patch
below does a good of handling an increasing number of CPUs and
tasks.  However, I'm sure it doesn't address everyones issues or
concerns.  I would especially appreciate any comments from Linus
on future direction in the area of the scheduler.

Some benchmark results for this patch are available at,
http://lse.sourceforge.net/scheduling/2.4.14.results
A 'wordy' description of the patch is located at,
http://lse.sourceforge.net/scheduling/mq1.html

-- 
Mike


diff -Naur linux-2.4.14/arch/i386/kernel/apm.c linux-2.4.14-mq/arch/i386/kernel/apm.c
--- linux-2.4.14/arch/i386/kernel/apm.c	Fri Oct 19 15:32:28 2001
+++ linux-2.4.14-mq/arch/i386/kernel/apm.c	Tue Nov  6 22:19:27 2001
@@ -1342,7 +1342,7 @@
  * decide if we should just power down.
  *
  */
-#define system_idle() (nr_running == 1)
+#define system_idle() (nr_running() == 1)
 
 static void apm_mainloop(void)
 {
diff -Naur linux-2.4.14/arch/i386/kernel/smpboot.c linux-2.4.14-mq/arch/i386/kernel/smpboot.c
--- linux-2.4.14/arch/i386/kernel/smpboot.c	Fri Oct  5 01:42:54 2001
+++ linux-2.4.14-mq/arch/i386/kernel/smpboot.c	Tue Nov  6 22:19:27 2001
@@ -799,14 +799,19 @@
 	if (!idle)
 		panic("No idle process for CPU %d", cpu);
 
-	idle->processor = cpu;
 
 	map_cpu_to_boot_apicid(cpu, apicid);
 
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
 
diff -Naur linux-2.4.14/fs/proc/proc_misc.c linux-2.4.14-mq/fs/proc/proc_misc.c
--- linux-2.4.14/fs/proc/proc_misc.c	Thu Oct 11 17:46:57 2001
+++ linux-2.4.14-mq/fs/proc/proc_misc.c	Tue Nov  6 22:19:27 2001
@@ -96,7 +96,7 @@
 		LOAD_INT(a), LOAD_FRAC(a),
 		LOAD_INT(b), LOAD_FRAC(b),
 		LOAD_INT(c), LOAD_FRAC(c),
-		nr_running, nr_threads, last_pid);
+		nr_running(), nr_threads, last_pid);
 	return proc_calc_metrics(page, start, off, count, eof, len);
 }
 
diff -Naur linux-2.4.14/include/linux/sched.h linux-2.4.14-mq/include/linux/sched.h
--- linux-2.4.14/include/linux/sched.h	Mon Nov  5 20:42:14 2001
+++ linux-2.4.14-mq/include/linux/sched.h	Tue Nov  6 22:46:17 2001
@@ -72,7 +72,7 @@
 #define CT_TO_SECS(x)	((x) / HZ)
 #define CT_TO_USECS(x)	(((x) % HZ) * 1000000/HZ)
 
-extern int nr_running, nr_threads;
+extern int nr_threads;
 extern int last_pid;
 
 #include <linux/fs.h>
@@ -132,14 +132,8 @@
 
 #include <linux/spinlock.h>
 
-/*
- * This serializes "schedule()" and also protects
- * the run-queue from deletions/modifications (but
- * _adding_ to the beginning of the run-queue has
- * a separate lock).
- */
+
 extern rwlock_t tasklist_lock;
-extern spinlock_t runqueue_lock;
 extern spinlock_t mmlist_lock;
 
 extern void sched_init(void);
@@ -437,6 +431,7 @@
 #define DEF_COUNTER	(10*HZ/100)	/* 100 ms time slice */
 #define MAX_COUNTER	(20*HZ/100)
 #define DEF_NICE	(0)
+#define ALL_CPUS_ALLOWED (-1)
 
 
 /*
@@ -461,7 +456,7 @@
     policy:		SCHED_OTHER,					\
     mm:			NULL,						\
     active_mm:		&init_mm,					\
-    cpus_allowed:	-1,						\
+    cpus_allowed:	ALL_CPUS_ALLOWED,				\
     run_list:		LIST_HEAD_INIT(tsk.run_list),			\
     next_task:		&tsk,						\
     prev_task:		&tsk,						\
@@ -846,18 +841,497 @@
 #define next_thread(p) \
 	list_entry((p)->thread_group.next, struct task_struct, thread_group)
 
-static inline void del_from_runqueue(struct task_struct * p)
+static inline int task_on_runqueue(struct task_struct *p)
+{
+	return (p->run_list.next != NULL);
+}
+
+/*
+ * runqueue_data
+ * 	One runqueue per CPU in the system, plus one additional runqueue for
+ * realtime tasks.  Size should be a multiple of cache line size, and array
+ * of items should start on a cache line boundary.
+ */
+typedef union runqueue_data {
+	struct rq_data {
+		int nt_running;			/* # of tasks on runqueue */
+#ifdef CONFIG_SMP
+		int max_na_goodness;		/* maximum non-affinity */
+						/* goodness value of    */
+						/* 'schedulable' task   */
+						/* on this runqueue     */
+		struct task_struct * max_na_ptr; /* pointer to task which */
+						 /* has max_na_goodness   */
+		unsigned long max_na_cpus_allowed; /* copy of cpus_allowed */
+						   /* field from task with */
+						   /* max_na_goodness      */
+#endif
+		struct list_head runqueue;	/* list of tasks on runqueue */
+#ifdef CONFIG_SMP
+		int running_non_idle;		/* flag to indicate this cpu */
+						/* is running something      */
+						/* besides the idle thread   */
+#endif
+		spinlock_t runqueue_lock;	/* lock for this runqueue */
+	} rq_data;
+	char __pad [SMP_CACHE_BYTES];
+} runqueue_data_t;
+#define nt_running(cpu) runqueue_data[(cpu)].rq_data.nt_running
+#ifdef CONFIG_SMP
+#define max_na_goodness(cpu) runqueue_data[(cpu)].rq_data.max_na_goodness
+#define max_na_ptr(cpu) runqueue_data[(cpu)].rq_data.max_na_ptr
+#define max_na_cpus_allowed(cpu) \
+	runqueue_data[(cpu)].rq_data.max_na_cpus_allowed
+#endif
+#define runqueue(cpu) runqueue_data[(cpu)].rq_data.runqueue
+#define runqueue_lock(cpu) runqueue_data[(cpu)].rq_data.runqueue_lock
+#ifdef CONFIG_SMP
+#define running_non_idle(cpu) runqueue_data[(cpu)].rq_data.running_non_idle
+#endif
+extern runqueue_data_t runqueue_data[];
+
+#ifdef CONFIG_SMP
+#define INIT_RUNQUEUE_DATA_SMP(n) {				\
+	max_na_goodness((n)) = MIN_GOODNESS;		\
+	max_na_ptr((n)) = NULL;					\
+	/* max_na_cpus_allowed need not be initialized */	\
+	running_non_idle((n)) = 0;				\
+}
+#else
+#define INIT_RUNQUEUE_DATA_SMP(n) 	/* NOOP */
+#endif
+#define INIT_RUNQUEUE_DATA(n) {					\
+	nt_running((n)) = 0;					\
+	INIT_LIST_HEAD(&runqueue((n)));				\
+	runqueue_lock((n)) = SPIN_LOCK_UNLOCKED;		\
+	INIT_RUNQUEUE_DATA_SMP((n));				\
+}
+#define N_RUNQUEUES		(NR_CPUS + 1)
+#define N_ALIGNED_DATA		NR_CPUS
+#define	REALTIME_RQ_ID		NR_CPUS
+#define MIN_GOODNESS		-1000
+#ifndef CONFIG_SMP
+#define	UP_RQ_LOCK_ID		0
+#endif
+
+/*
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
+#define cpu_curr(cpu) aligned_data[(cpu)].schedule_data.curr
+#ifdef CONFIG_SMP
+#define curr_na_goodness(cpu) aligned_data[(cpu)].schedule_data.curr_na_goodness
+#endif
+#define last_schedule(cpu) aligned_data[(cpu)].schedule_data.last_schedule
+extern aligned_data_t aligned_data[];
+
+#ifdef CONFIG_SMP
+#define INIT_ALIGNED_DATA_SMP(n) {			\
+	curr_na_goodness((n)) = MIN_GOODNESS;	\
+}
+#else
+#define INIT_ALIGNED_DATA_SMP(n) 	/* NOOP */
+#endif
+#define INIT_ALIGNED_DATA(n) {				\
+	cpu_curr((n)) = &init_task;			\
+	last_schedule((n)) = 0;				\
+	INIT_ALIGNED_DATA_SMP((n));			\
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
+		rq = REALTIME_RQ_ID;
+	} else {
+		rq = t->processor;
+	}
+
+	return(rq);
+}
+#define TASK_RQ(t)	runqueue(task_to_runqueue((t)))
+
+/*
+ * Sum CPU specific nt_running fields to determine how many
+ * runnable tasks there are in the system.
+ */
+static inline int nr_running(void)
+{
+	int i;
+	int tot=nt_running(REALTIME_RQ_ID);
+
+	for(i=0; i<smp_num_cpus; i++) {
+		tot += nt_running(cpu_logical_map(i));
+	}
+
+	return(tot);
+}
+
+/*
+ * The following macros and the base_goodness() routine contain common
+ * code for the 'exported' goodness routines which follow.
+ */
+#define RT_GOODNESS_MIN	1000
+#define RT_GOODNESS(t) (RT_GOODNESS_MIN + (t)->rt_priority)
+#define MM_GOODNESS(t, this_mm)	((t)->mm == (this_mm) ? 1 : 0)
+#define CPU_GOODNESS(t, this_cpu) ((t)->processor == (this_cpu) ? \
+					PROC_CHANGE_PENALTY : 0)
+static inline int base_goodness(struct task_struct * t)
+{
+	int weight;
+
+	weight = -1;
+	if (t->policy & SCHED_YIELD)
+		goto out;
+
+	/*
+	 * base_goodness is based on the nuber of ticks left.
+	 * Don't do any other calculations if the time slice is
+	 * over..
+	 */
+	weight = t->counter;
+	if (!weight)
+		goto out;
+			
+	/*
+	 * Factor in the nice value
+	 */
+	weight += 20 - t->nice;
+
+out:
+	return weight;
+}
+
+/*
+ * non-affinity goodness value of a task.  MM and CPU affinity are not
+ * taken into account.
+ */
+static inline int na_goodness(struct task_struct * t)
+{
+	/*
+	 * Normal tasks first
+	 */
+	if ((t->policy & ~SCHED_YIELD) == SCHED_OTHER) {
+		return (base_goodness(t));
+	}
+
+	/*
+	 * Realtime task
+	 */
+	return (RT_GOODNESS(t));
+}
+
+/*
+ * Stripped down version of goodness routine to be used on a CPU
+ * specific (local) runqueue.  This routine does not need to be
+ * concerned with realtime tasks, and does not need to take CPU
+ * affinity into account.
+ */
+static inline int local_goodness(struct task_struct * t,
+						struct mm_struct *this_mm)
+{
+	int weight = base_goodness(t);
+
+	if (weight > 0) {
+		weight += MM_GOODNESS(t, this_mm);
+	}
+
+	return(weight);
+}
+
+/*
+ * Full Blown goodness function, this is the function that decides how
+ * desirable a process is.  You can weigh different processes against
+ * each other depending on what CPU they've run on lately etc to try to
+ * handle cache and TLB miss penalties.
+ *
+ * Return values:
+ *               <0: dont select this one
+ *                0: out of time, recalculate counters (but it might still be
+ *                   selected)
+ *              +ve: "goodness" value (the larger, the better)
+ * +RT_GOODNESS_MIN: realtime process, select this.
+ */
+static inline int goodness(struct task_struct * t, int this_cpu,
+						struct mm_struct *this_mm)
 {
-	nr_running--;
+	int weight;
+
+	/*
+	 * Normal tasks first
+	 */
+	if ((t->policy & ~SCHED_YIELD) == SCHED_OTHER) {
+		weight = base_goodness(t);
+		if (weight > 0) {
+			weight += MM_GOODNESS(t, this_mm);
+#ifdef CONFIG_SMP
+			weight += CPU_GOODNESS(t, this_cpu);
+#endif
+		}
+		return(weight);
+	}
+
+	/*
+	 * Realtime task
+	 */
+	return (RT_GOODNESS(t));
+}
+
+/*
+ * Common code for add to runqueue.  In SMP update max_na_* values
+ * for runquue if appropriate.
+ */
+static inline void add_to_runqueue_common(struct task_struct * p, int upd)
+{
+	int rq = task_to_runqueue(p);
+#ifdef CONFIG_SMP
+	int tsk_na_goodness = na_goodness(p);
+
+	if (upd &&
+	    !p->has_cpu && (tsk_na_goodness > max_na_goodness(rq))) {
+		max_na_goodness(rq) = tsk_na_goodness;
+		max_na_cpus_allowed(rq) = p->cpus_allowed;
+		max_na_ptr(rq) = p;
+	}
+#endif
+	list_add(&p->run_list, &runqueue(rq));
+	nt_running(rq)++;
+}
+static inline void add_to_runqueue(struct task_struct * p)
+{
+	add_to_runqueue_common(p, 1);
+}
+static inline void add_to_runqueue_noupd(struct task_struct * p)
+{
+	add_to_runqueue_common(p, 0);
+}
+
+/*
+ * Common routine for both flavors of del_from_runqueue.  Expensive scan
+ * of runqueue only happens in SMP is explicitly requested.
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
+#ifdef CONFIG_SMP
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
+				max_na_goodness(rq) = MIN_GOODNESS;
+				max_na_ptr(rq) = NULL;
+			}
+		} else {
+			max_na_goodness(rq) = MIN_GOODNESS;
+			max_na_ptr(rq) = NULL;
+		}
+	}
+#endif
+}
+/*
+ * del_from_runqueue without updating max_na_* values.  Used in
+ * places where we know we will updating these values before
+ * dropping the runqueue lock.
+ */
+static inline void del_from_runqueue(struct task_struct * p)
+{
+	del_from_runqueue_common(p, 0);
+}
+/*
+ * del_from_runqueue_update will update the max_na_* values
+ * if necessary.
+ */
+static inline void del_from_runqueue_update(struct task_struct * p)
+{
+	del_from_runqueue_common(p, 1);
 }
 
-static inline int task_on_runqueue(struct task_struct *p)
+/*
+ * Macros to call runqueue locking routines
+ */
+#ifdef CONFIG_SMP
+#define LOCK_REALTIME_RQ()					\
+		spin_lock(&runqueue_lock(REALTIME_RQ_ID));
+#define UNLOCK_REALTIME_RQ()					\
+		spin_unlock(&runqueue_lock(REALTIME_RQ_ID));
+#else
+#define LOCK_REALTIME_RQ()		/* NOOP */
+#define UNLOCK_REALTIME_RQ()		/* NOOP */
+#endif
+#define LOCK_TASK_CPU_RQ_IRQ(t)					\
+		lock_task_cpu_rq_irq(t)
+#define UNLOCK_TASK_CPU_RQ_IRQ(t)				\
+		unlock_task_cpu_rq_irq(t)
+#define LOCK_TASK_RQ_VERIFY(t)					\
+		lock_task_rq_verify(t)
+#ifdef CONFIG_SMP
+#define UNLOCK_TASK_RQ(t)					\
+		spin_unlock(&runqueue_lock(task_to_runqueue((t))));
+#else
+#define UNLOCK_TASK_RQ(t)					\
+		spin_unlock(&runqueue_lock(UP_RQ_LOCK_ID));
+#endif
+#define LOCK_TASK_CPU_RQ_IRQSAVE_VERIFY(t, flags)		\
+		lock_task_cpu_rq_irqsave_verify(t, flags)
+#define UNLOCK_TASK_CPU_RQ_IRQSAVE(cpu_rq, t, flags)		\
+		unlock_task_cpu_rq_irqsave(cpu_rq, t, flags)
+#define LOCK_TASK_CPU_RQ_IRQ_VERIFY(t)				\
+		lock_task_cpu_rq_irq_verify(t)
+
+static inline void lock_task_cpu_rq_irq(struct task_struct *t)
 {
-	return (p->run_list.next != NULL);
+#ifdef CONFIG_SMP
+	spin_lock_irq(&runqueue_lock(t->processor));
+	if (task_to_runqueue(t) == REALTIME_RQ_ID) {
+		LOCK_REALTIME_RQ();
+	}
+#else
+	spin_lock_irq(&runqueue_lock(UP_RQ_LOCK_ID));
+#endif
+}
+
+static inline void unlock_task_cpu_rq_irq(struct task_struct *t)
+{
+#ifdef CONFIG_SMP
+	if (task_to_runqueue(t) == REALTIME_RQ_ID) {
+		UNLOCK_REALTIME_RQ();
+	}
+	spin_unlock_irq(&runqueue_lock(t->processor));
+#else
+	spin_unlock_irq(&runqueue_lock(UP_RQ_LOCK_ID));
+#endif
+}
+
+static inline void lock_task_rq_verify(struct task_struct *t)
+{
+#ifdef CONFIG_SMP
+	int rq = task_to_runqueue(t);
+
+	spin_lock(&runqueue_lock(rq));
+	while (rq != task_to_runqueue(t)) {
+		spin_unlock(&runqueue_lock(rq));
+		rq = task_to_runqueue(t);
+		spin_lock(&runqueue_lock(rq));
+	}
+#else
+	spin_lock(&runqueue_lock(UP_RQ_LOCK_ID));
+#endif
 }
+
+static inline int lock_task_cpu_rq_irqsave_verify(struct task_struct *t,
+						unsigned long *flags)
+{
+#ifdef CONFIG_SMP
+	int rq = t->processor;
+
+	spin_lock_irqsave(&runqueue_lock(rq), *flags);
+	while (t->processor != rq) {
+		spin_unlock_irqrestore(&runqueue_lock(rq), *flags);
+		rq = t->processor;
+		spin_lock_irqsave(&runqueue_lock(rq), *flags);
+	}
+	if (task_to_runqueue(t) == REALTIME_RQ_ID) {
+		LOCK_REALTIME_RQ();
+	}
+	return(rq);
+#else
+	spin_lock_irqsave(&runqueue_lock(UP_RQ_LOCK_ID), *flags);
+	return(UP_RQ_LOCK_ID);
+#endif
+}
+
+static inline void unlock_task_cpu_rq_irqsave(int cpu_rq, struct task_struct *t,
+						unsigned long flags)
+{
+#ifdef CONFIG_SMP
+	int rq = task_to_runqueue(t);
+
+	if (rq == REALTIME_RQ_ID) {
+		UNLOCK_REALTIME_RQ();
+	}
+	spin_unlock_irqrestore(&runqueue_lock(cpu_rq), flags);
+#else
+	spin_unlock_irqrestore(&runqueue_lock(UP_RQ_LOCK_ID), flags);
+#endif
+}
+
+static inline void lock_task_cpu_rq_irq_verify(struct task_struct *t)
+{
+#ifdef CONFIG_SMP
+	int rq = t->processor;
+
+	spin_lock_irq(&runqueue_lock(rq));
+	while (t->processor != rq) {
+		spin_unlock_irq(&runqueue_lock(rq));
+		rq = t->processor;
+		spin_lock_irq(&runqueue_lock(rq));
+	}
+	if (task_to_runqueue(t) == REALTIME_RQ_ID) {
+		LOCK_REALTIME_RQ();
+	}
+#else
+	spin_lock_irq(&runqueue_lock(UP_RQ_LOCK_ID));
+#endif
+}
+
+#ifdef CONFIG_SMP
+#define UPDATE_SCHED_DATA(tc, next)	update_sched_data(tc, next)
+#define EXAMINE_RMT_RQS(tc, c, p, n)	examine_rmt_rqs(tc, c, p, n)
+#else
+#define UPDATE_SCHED_DATA(tc, next)	/* NOOP */
+#define EXAMINE_RMT_RQS(tc, c, p, n)	(n)
+#endif
 
 static inline void unhash_process(struct task_struct *p)
 {
diff -Naur linux-2.4.14/kernel/fork.c linux-2.4.14-mq/kernel/fork.c
--- linux-2.4.14/kernel/fork.c	Wed Oct 24 00:44:15 2001
+++ linux-2.4.14-mq/kernel/fork.c	Tue Nov  6 22:19:27 2001
@@ -28,7 +28,6 @@
 
 /* The idle threads do not count.. */
 int nr_threads;
-int nr_running;
 
 int max_threads;
 unsigned long total_forks;	/* Handle normal Linux uptimes. */
diff -Naur linux-2.4.14/kernel/sched.c linux-2.4.14-mq/kernel/sched.c
--- linux-2.4.14/kernel/sched.c	Wed Oct 17 21:14:37 2001
+++ linux-2.4.14-mq/kernel/sched.c	Tue Nov  6 22:19:27 2001
@@ -80,33 +80,20 @@
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
 
-static LIST_HEAD(runqueue_head);
-
 /*
- * We align per-CPU scheduling data on cacheline boundaries,
- * to prevent cacheline ping-pong.
+ * runqueue_data and aligned_data contain CPU specific scheduling data.
+ * There is one runqueue per CPU in the system, and SMP kernels also
+ * contain a realtime runquue.  Initialization is performed in sched_init().
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
+runqueue_data_t runqueue_data [N_RUNQUEUES] __cacheline_aligned;
+aligned_data_t aligned_data [N_ALIGNED_DATA] __cacheline_aligned;
 
 struct kernel_stat kstat;
 extern struct task_struct *child_reaper;
@@ -116,6 +103,8 @@
 #define idle_task(cpu) (init_tasks[cpu_number_map(cpu)])
 #define can_schedule(p,cpu) ((!(p)->has_cpu) && \
 				((p)->cpus_allowed & (1 << cpu)))
+#define local_can_schedule(p) (!(p)->has_cpu)
+#define this_cpu_allowed(ca, tcpu) ((ca) & (1 << tcpu))
 
 #else
 
@@ -127,72 +116,6 @@
 void scheduling_functions_start_here(void) { }
 
 /*
- * This is the function that decides how desirable a process is..
- * You can weigh different processes against each other depending
- * on what CPU they've run on lately etc to try to handle cache
- * and TLB miss penalties.
- *
- * Return values:
- *	 -1000: never select this
- *	     0: out of time, recalculate counters (but it might still be
- *		selected)
- *	   +ve: "goodness" value (the larger, the better)
- *	 +1000: realtime process, select this.
- */
-
-static inline int goodness(struct task_struct * p, int this_cpu, struct mm_struct *this_mm)
-{
-	int weight;
-
-	/*
-	 * select the current process after every other
-	 * runnable process, but before the idle thread.
-	 * Also, dont trigger a counter recalculation.
-	 */
-	weight = -1;
-	if (p->policy & SCHED_YIELD)
-		goto out;
-
-	/*
-	 * Non-RT process - normal case first.
-	 */
-	if (p->policy == SCHED_OTHER) {
-		/*
-		 * Give the process a first-approximation goodness value
-		 * according to the number of clock-ticks it has left.
-		 *
-		 * Don't do any other calculations if the time slice is
-		 * over..
-		 */
-		weight = p->counter;
-		if (!weight)
-			goto out;
-			
-#ifdef CONFIG_SMP
-		/* Give a largish advantage to the same processor...   */
-		/* (this is equivalent to penalizing other processors) */
-		if (p->processor == this_cpu)
-			weight += PROC_CHANGE_PENALTY;
-#endif
-
-		/* .. and a slight advantage to the current MM */
-		if (p->mm == this_mm || !p->mm)
-			weight += 1;
-		weight += 20 - p->nice;
-		goto out;
-	}
-
-	/*
-	 * Realtime process, select the first one on the
-	 * runqueue (taking priorities within processes
-	 * into account).
-	 */
-	weight = 1000 + p->rt_priority;
-out:
-	return weight;
-}
-
-/*
  * the 'goodness value' of replacing a process on a given CPU.
  * positive value means 'replace', zero or negative means 'dont'.
  */
@@ -202,126 +125,212 @@
 }
 
 /*
- * This is ugly, but reschedule_idle() is very timing-critical.
- * We are called with the runqueue spinlock held and we must
- * not claim the tasklist_lock.
+ * reschedule_idle - Determine which CPU the specified task should
+ * should run on.  The runqueue lock must be held upon entry to this
+ * routine.
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
+	saved_na_goodness = na_goodness(p); /* preemption_goodness() > 0 */
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
+		if (curr_na_goodness(cpu) == MIN_GOODNESS) {
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
-	max_prio = 0;
+	 * We try to add the task to a runqueue starting with the one
+	 * that has the lowest na_goodness value.
+	 */
+	while (target_cpu != -1) {
+		if (target_cpu == tsk_cpu &&
+		    preemption_goodness((tsk = cpu_curr(target_cpu)),
+					p, target_cpu) > 0) {
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
+			     (preemption_goodness(tsk, p, target_cpu) > 0)) {
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
+	 * task currently running on this task's runqueue has sufficuent
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
 	struct task_struct *tsk;
 
 	tsk = cpu_curr(this_cpu);
-	if (preemption_goodness(tsk, p, this_cpu) > 0)
+	if (preemption_goodness(tsk, p, this_cpu) > 0) {
 		tsk->need_resched = 1;
+	}
+	if (!task_on_runqueue(p)) {
+		add_to_runqueue(p);
+	}
 #endif
 }
 
-/*
- * Careful!
- *
- * This has to add the process to the _beginning_ of the
- * run-queue, not the end. See the comment about "This is
- * subtle" in the scheduler proper..
- */
-static inline void add_to_runqueue(struct task_struct * p)
-{
-	list_add(&p->run_list, &runqueue_head);
-	nr_running++;
-}
-
 static inline void move_last_runqueue(struct task_struct * p)
 {
 	list_del(&p->run_list);
-	list_add_tail(&p->run_list, &runqueue_head);
+	list_add_tail(&p->run_list, &TASK_RQ(p));
 }
 
 static inline void move_first_runqueue(struct task_struct * p)
 {
 	list_del(&p->run_list);
-	list_add(&p->run_list, &runqueue_head);
+	list_add(&p->run_list, &TASK_RQ(p));
 }
 
 /*
@@ -336,20 +345,24 @@
 {
 	unsigned long flags;
 	int success = 0;
+	int cpu_rq;
+
+	cpu_rq = LOCK_TASK_CPU_RQ_IRQSAVE_VERIFY(p, &flags);
 
 	/*
 	 * We want the common case fall through straight, thus the goto.
 	 */
-	spin_lock_irqsave(&runqueue_lock, flags);
 	p->state = TASK_RUNNING;
 	if (task_on_runqueue(p))
 		goto out;
-	add_to_runqueue(p);
+
 	if (!synchronous || !(p->cpus_allowed & (1 << smp_processor_id())))
 		reschedule_idle(p);
+	else
+		add_to_runqueue(p);
 	success = 1;
 out:
-	spin_unlock_irqrestore(&runqueue_lock, flags);
+	UNLOCK_TASK_CPU_RQ_IRQSAVE(cpu_rq, p, flags);
 	return success;
 }
 
@@ -495,6 +508,7 @@
 needs_resched:
 	{
 		unsigned long flags;
+		int cpu_rq;
 
 		/*
 		 * Avoid taking the runqueue lock in cases where
@@ -504,15 +518,17 @@
 						(policy & SCHED_YIELD))
 			goto out_unlock;
 
-		spin_lock_irqsave(&runqueue_lock, flags);
+		cpu_rq = LOCK_TASK_CPU_RQ_IRQSAVE_VERIFY(prev, &flags);
+
 		if ((prev->state == TASK_RUNNING) && !prev->has_cpu)
 			reschedule_idle(prev);
-		spin_unlock_irqrestore(&runqueue_lock, flags);
+
+		UNLOCK_TASK_CPU_RQ_IRQSAVE(cpu_rq, prev, flags);
 		goto out_unlock;
 	}
 #else
 	prev->policy &= ~SCHED_YIELD;
-#endif /* CONFIG_SMP */
+#endif
 }
 
 void schedule_tail(struct task_struct *prev)
@@ -520,11 +536,322 @@
 	__schedule_tail(prev);
 }
 
+#ifdef CONFIG_SMP
 /*
- *  'schedule()' is the scheduler function. It's a very simple and nice
- * scheduler: it's not perfect, but certainly works for most things.
- *
- * The goto is "interesting".
+ * Examine remote runqueues and look for a task which is more desirable
+ * to run than 'next'.
+ */
+static FASTCALL(struct task_struct *examine_rmt_rqs(int this_cpu, int *cg,
+					struct task_struct *prev,
+					struct task_struct *next));
+static struct task_struct *examine_rmt_rqs(int this_cpu, int *cg,
+					struct task_struct *prev,
+					struct task_struct *next)
+{
+	int premature_idle;
+	int rrq;
+	int tmp_na_goodness;
+	int rq;
+	int rcpu;
+	int retry;
+	int stack_list[NR_CPUS];
+
+	/*
+	 * cg (current goodness) does not contain a CPU affinity boost.
+	 * We must add this boost before comparing to tasks on other
+	 * runqueues.  Only add PROC_CHANGE_PENALTY if c is a positive
+	 * goodness value.
+	 */
+	if (*cg > 0) {
+		*cg += PROC_CHANGE_PENALTY;
+	}
+
+	/*
+	 * Copy max_na_goodness values from CPU specific runqueue
+	 * structures to the list on our stack.
+	 */
+scan_again:
+	premature_idle = 0;
+	rrq = -1;
+	tmp_na_goodness = *cg;
+	for (rq = 0; rq < smp_num_cpus; rq++) {
+		rcpu = cpu_logical_map(rq);
+		if (rcpu == this_cpu) {
+			stack_list[rcpu] = MIN_GOODNESS;
+			continue;
+		}
+		if (!this_cpu_allowed(max_na_cpus_allowed(rcpu), this_cpu)) {
+			stack_list[rcpu] = MIN_GOODNESS;
+			continue;
+		}
+		if (max_na_goodness(rcpu) <= *cg) {
+			stack_list[rcpu] = MIN_GOODNESS;
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
+			if (max_na_goodness(rrq) > *cg && 
+			    this_cpu_allowed(max_na_cpus_allowed(rrq),
+								this_cpu)) {
+				/*
+				 * Move a remote task to our runqueue,
+				 * don't forget to update max_na_values
+				 * for our queue.
+				 */
+				if (!next->has_cpu && 
+				    next != idle_task(this_cpu)) {
+					max_na_goodness(this_cpu) =
+							na_goodness(next);
+					max_na_cpus_allowed(this_cpu) =
+							next->cpus_allowed;
+					max_na_ptr(this_cpu) = next;
+				}
+				next = max_na_ptr(rrq);;
+				*cg = max_na_goodness(rrq);
+				del_from_runqueue_update(next);
+				next->processor = this_cpu;
+				add_to_runqueue_noupd(next);
+
+				/*
+				 * We have stolen a task from another
+				 * runqueue, quit looking.
+				 */
+				spin_unlock(&runqueue_lock(rrq));
+					
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
+		stack_list[rrq] = MIN_GOODNESS;
+		tmp_na_goodness = *cg;
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
+	retry = (next == idle_task(this_cpu)) &&
+		(task_to_runqueue(prev) != REALTIME_RQ_ID);
+	if (retry && premature_idle) {
+		/*
+		 * Be sure to clear max_na_goodness, otherwise there
+		 * is the potential for deadlock.
+		 */
+		max_na_goodness(this_cpu) = MIN_GOODNESS;
+		goto scan_again;
+	}
+
+	return(next);
+}
+
+/*
+ * Find next best schedulable task on runqueue. In addition, while scanning
+ * the queue keep track of the 'second best' schedulable task and update
+ * runquue max_na_* values accordingly.
+ */
+static FASTCALL(struct task_struct *scan_runqueue(struct task_struct *prev,
+		int *cg, struct task_struct *next));
+static struct task_struct *scan_runqueue(struct task_struct *prev, int *cg,
+		struct task_struct *next)
+{
+	struct task_struct *p;
+	struct list_head *tmp;
+	int prev_next_weight;
+	struct task_struct *prev_next;
+	int rq = prev->processor;
+
+	prev_next = idle_task(rq);
+	prev_next_weight = MIN_GOODNESS;
+	/*
+	 * Search local (CPU specific) runqueue
+	 */
+	list_for_each(tmp, &runqueue(rq)) {
+		p = list_entry(tmp, struct task_struct, run_list);
+		if (local_can_schedule(p)) {
+			int weight = local_goodness(p, prev->active_mm);
+			if (weight > *cg) {
+				if (!next->has_cpu) {
+					/*
+					 * prev_next must point to a
+					 * schedulable task.
+					 */
+					prev_next_weight = *cg;
+					prev_next = next;
+				}
+				*cg = weight;
+				next = p;
+			} else if (weight > prev_next_weight) {
+				prev_next_weight = weight;
+				prev_next = p;
+			}
+		}
+	}
+
+	/*
+	 * Update max_na_* values for this runqueue
+	 */
+	if (prev_next != idle_task(rq)) {
+		max_na_goodness(rq) = na_goodness(prev_next);
+		max_na_cpus_allowed(rq) = prev_next->cpus_allowed;
+		max_na_ptr(rq) = prev_next;
+	} else {
+		max_na_goodness(rq) = MIN_GOODNESS;
+		/* max_na_cpus_allowed need not be set */
+		max_na_ptr(rq) = NULL;
+	}
+
+	return(next);
+}
+
+static FASTCALL(struct task_struct * scan_rt_runqueue(struct task_struct *prev,
+					int *cg, struct task_struct *next));
+static struct task_struct * scan_rt_runqueue(struct task_struct *prev,
+					int *cg, struct task_struct *next)
+{
+	struct list_head *tmp;
+	struct task_struct *p;
+	int this_cpu = prev->processor;
+
+	if (task_to_runqueue(prev) != REALTIME_RQ_ID) {
+		LOCK_REALTIME_RQ();
+	}
+
+	/*
+	 * Scan the queue.  Note that there is no need to
+	 * keep track of max_na_goodness values for the
+	 * realtime runqueue, as they are never used in
+	 * scheduling decisions.
+	 */
+	list_for_each(tmp, &runqueue(REALTIME_RQ_ID)) {
+		p = list_entry(tmp, struct task_struct, run_list);
+		if (can_schedule(p, this_cpu)) {
+			int weight = RT_GOODNESS(p);
+			if (weight > *cg)
+				*cg = weight, next = p;
+		}
+	}
+
+	/*
+	 * If we found a realtime task, make it non-schedulable (set
+	 * has_cpu) before potentially releasing the queue's lock.
+	 * This prevents other CPUs from trying to steal the task
+	 * before we can switch to it.
+	 * Note that we still hold the CPU specific runqueue lock.
+	 */
+	if (task_to_runqueue(next) == REALTIME_RQ_ID) {
+		next->has_cpu = 1;
+	}
+	if (task_to_runqueue(prev) != REALTIME_RQ_ID) {
+		UNLOCK_REALTIME_RQ();
+	}
+
+	return(next);
+}
+
+static inline void update_sched_data(int this_cpu, struct task_struct *next)
+{
+	/*
+	 * Update values in aligned_data
+	 */
+	if (next != idle_task(this_cpu)) {
+		curr_na_goodness(this_cpu) = na_goodness(next);
+		running_non_idle(this_cpu) = 1;
+	} else {
+		curr_na_goodness(this_cpu) = MIN_GOODNESS;
+		running_non_idle(this_cpu) = 0;
+	}
+
+}
+#else
+
+/*
+ * Scan local runqueue UP version, unnecessary searches/updates removed
+ */
+static inline struct task_struct *scan_runqueue(struct task_struct *prev,
+	int *cg, struct task_struct *next)
+{
+	struct task_struct *p;
+	struct list_head *tmp;
+	int this_cpu = prev->processor;
+	int weight;
+
+	/*
+	 * Search local (CPU specific) runqueue
+	 */
+	list_for_each(tmp, &runqueue(this_cpu)) {
+		p = list_entry(tmp, struct task_struct, run_list);
+		weight = local_goodness(p, prev->active_mm);
+		if (weight > *cg)
+			*cg = weight, next = p;
+	}
+
+	return(next);
+}
+
+/*
+ * Scan RT runqueue UP version with unnecessary locking removed
+ */
+static inline struct task_struct * scan_rt_runqueue(struct task_struct *prev,
+					int *cg, struct task_struct *next)
+{
+	struct list_head *tmp;
+	struct task_struct *p;
+	int weight;
+
+	/*
+	 * Scan the queue.  Note that there is no need to
+	 * keep track of max_na_goodness values for the
+	 * realtime runqueue, as they are never used in
+	 * scheduling decisions.
+	 */
+	list_for_each(tmp, &runqueue(REALTIME_RQ_ID)) {
+		p = list_entry(tmp, struct task_struct, run_list);
+		weight = RT_GOODNESS(p);
+		if (weight > *cg)
+			*cg = weight, next = p;
+	}
+
+	return(next);
+}
+#endif
+
+/*
+ *  'schedule()' is the scheduler function.
  *
  *   NOTE!!  Task 0 is the 'idle' task, which gets called when no other
  * tasks can run. It can not be killed, and it cannot sleep. The 'state'
@@ -532,13 +859,11 @@
  */
 asmlinkage void schedule(void)
 {
-	struct schedule_data * sched_data;
-	struct task_struct *prev, *next, *p;
-	struct list_head *tmp;
+	struct task_struct *prev, *next;
 	int this_cpu, c;
+	int update_prev_processor = 0;
 
-
-	spin_lock_prefetch(&runqueue_lock);
+	spin_lock_prefetch(&runqueue_lock(current->processor));
 
 	if (!current->active_mm) BUG();
 need_resched_back:
@@ -551,12 +876,9 @@
 	release_kernel_lock(prev, this_cpu);
 
 	/*
-	 * 'sched_data' is protected by the fact that we can run
-	 * only one process per CPU.
+	 * Lock runqueue(s) associated with task
 	 */
-	sched_data = & aligned_data[this_cpu].schedule_data;
-
-	spin_lock_irq(&runqueue_lock);
+	LOCK_TASK_CPU_RQ_IRQ(prev);
 
 	/* move an exhausted RR process to be last.. */
 	if (prev->policy == SCHED_RR)
@@ -584,34 +906,69 @@
 	 * Default process to select..
 	 */
 	next = idle_task(this_cpu);
-	c = -1000;
+	c = MIN_GOODNESS;
 	if (prev->state == TASK_RUNNING)
 		goto still_running;
 
 still_running_back:
-	list_for_each(tmp, &runqueue_head) {
-		p = list_entry(tmp, struct task_struct, run_list);
-		if (can_schedule(p, this_cpu)) {
-			int weight = goodness(p, this_cpu, prev->active_mm);
-			if (weight > c)
-				c = weight, next = p;
+	/*
+	 * First check the realtime runqueue
+	 */
+	if (nt_running(REALTIME_RQ_ID)) {
+		next = scan_rt_runqueue(prev, &c, next);
+		if (task_to_runqueue(next) == REALTIME_RQ_ID) {
+			 /* Found a RT task, no need to look elsewhere */
+			goto set_sched_data;
 		}
 	}
 
-	/* Do we need to re-calculate counters? */
+	/*
+	 * Search CPU specific runqueue
+	 */
+	next = scan_runqueue(prev, &c, next);
+
+	/*
+	 * Take a look at the remote runqueues
+	 */
+	next = EXAMINE_RMT_RQS(this_cpu, &c, prev, next);
+
+	/* Do we need to re-calculate counters for ALL tasks? */
 	if (!c)
 		goto recalculate;
+
+set_sched_data:
+	/*
+	 * Update scheduler data
+	 */
+	UPDATE_SCHED_DATA(this_cpu, next);
+
+	/*
+	 * Update scheduling fields in next task structure.
+	 */
+ 	next->has_cpu = 1;
+	next->processor = this_cpu;
+
 	/*
 	 * from this point on nothing can prevent us from
 	 * switching to the next task, save this fact in
 	 * sched_data.
 	 */
-	sched_data->curr = next;
-#ifdef CONFIG_SMP
- 	next->has_cpu = 1;
-	next->processor = this_cpu;
-#endif
-	spin_unlock_irq(&runqueue_lock);
+	cpu_curr(this_cpu) = next;
+
+	UNLOCK_TASK_CPU_RQ_IRQ(prev);
+
+	if (update_prev_processor) {
+		unsigned long allowed = prev->cpus_allowed;
+		/*
+		 * current task (prev) has had its processor field
+		 * updated and should no longer run on this CPU.
+		 */
+		prev->processor = 0;
+		while (!(allowed & 1UL)) {
+			prev->processor++;
+			allowed = allowed >> 1;
+		}
+	}
 
 	if (prev == next) {
 		/* We won't go through the normal tail, so do this by hand */
@@ -627,15 +984,14 @@
 	 * and it's approximate, so we do not have to maintain
 	 * it while holding the runqueue spinlock.
  	 */
- 	sched_data->last_schedule = get_cycles();
+ 	last_schedule(this_cpu) = get_cycles();
 
 	/*
 	 * We drop the scheduler lock early (it's a global spinlock),
 	 * thus we have to lock the previous process from getting
 	 * rescheduled during switch_to().
 	 */
-
-#endif /* CONFIG_SMP */
+#endif
 
 	kstat.context_swtch++;
 	/*
@@ -684,18 +1040,29 @@
 recalculate:
 	{
 		struct task_struct *p;
-		spin_unlock_irq(&runqueue_lock);
+		UNLOCK_TASK_CPU_RQ_IRQ(prev);
 		read_lock(&tasklist_lock);
 		for_each_task(p)
 			p->counter = (p->counter >> 1) + NICE_TO_TICKS(p->nice);
 		read_unlock(&tasklist_lock);
-		spin_lock_irq(&runqueue_lock);
+		LOCK_TASK_CPU_RQ_IRQ(prev);
 	}
 	goto repeat_schedule;
 
 still_running:
-	if (!(prev->cpus_allowed & (1UL << this_cpu)))
+	if (!(prev->cpus_allowed & (1UL << this_cpu))) {
+		/*
+		 * task is no longer runnable on this CPU.  We remove it
+		 * from the runqueue to ensure that it will not be considered
+		 * for scheduling here.  Let schedule_tail take care of
+		 * sending it off to an appropriate CPU.
+		 */
+		if (!update_prev_processor) {
+			del_from_runqueue(prev);
+			update_prev_processor++;
+		}
 		goto still_running_back;
+	}
 	c = goodness(prev, this_cpu, prev->active_mm);
 	next = prev;
 	goto still_running_back;
@@ -913,6 +1280,7 @@
 	struct sched_param lp;
 	struct task_struct *p;
 	int retval;
+	int was_on_rq = 0;
 
 	retval = -EINVAL;
 	if (!param || pid < 0)
@@ -922,18 +1290,20 @@
 	if (copy_from_user(&lp, param, sizeof(struct sched_param)))
 		goto out_nounlock;
 
+	retval = -ESRCH;
 	/*
-	 * We play safe to avoid deadlocks.
+	 * Note that here we get the tasklist lock so that we can
+	 * find the task struct.  Not until we have access to the
+	 * task struct can we determine what runqueue to lock.
 	 */
-	read_lock_irq(&tasklist_lock);
-	spin_lock(&runqueue_lock);
-
+	read_lock(&tasklist_lock);
 	p = find_process_by_pid(pid);
+	if (!p) {
+		read_unlock(&tasklist_lock);
+		goto out_nounlock;
+	}
+	LOCK_TASK_CPU_RQ_IRQ_VERIFY(p);
 
-	retval = -ESRCH;
-	if (!p)
-		goto out_unlock;
-			
 	if (policy < 0)
 		policy = p->policy;
 	else {
@@ -962,16 +1332,35 @@
 		goto out_unlock;
 
 	retval = 0;
+
+	if ((p->policy == SCHED_OTHER) && (policy != SCHED_OTHER)) {
+		/*
+		 * If changing to a realtime policy, we lock the
+		 * realtime runqueue so that we can (potentially)
+		 * move p to it.
+		 *
+		 * Note: If we lock the realtime runqueue here, it
+		 * means that p is becoming a realtime task, and
+		 * UNLOCK_TASK_CPU_RQ_IRQ() will take care of unlocking
+		 * the realtime runqueue.
+		 */
+		LOCK_REALTIME_RQ();
+	}
+
+	if (task_on_runqueue(p)) {
+		del_from_runqueue_update(p);
+		was_on_rq = 1;
+	}
 	p->policy = policy;
 	p->rt_priority = lp.sched_priority;
-	if (task_on_runqueue(p))
-		move_first_runqueue(p);
-
+	if (was_on_rq) {
+		add_to_runqueue(p);
+	}
 	current->need_resched = 1;
 
 out_unlock:
-	spin_unlock(&runqueue_lock);
-	read_unlock_irq(&tasklist_lock);
+	UNLOCK_TASK_CPU_RQ_IRQ(p);
+	read_unlock(&tasklist_lock);
 
 out_nounlock:
 	return retval;
@@ -1048,19 +1437,18 @@
 	 * to be atomic.) In threaded applications this optimization
 	 * gets triggered quite often.
 	 */
-
-	int nr_pending = nr_running;
-
 #if CONFIG_SMP
+	int nr_pending = nt_running(REALTIME_RQ_ID);
 	int i;
 
-	// Subtract non-idle processes running on other CPUs.
+	// Substract non-idle processes running on other CPUs.
 	for (i = 0; i < smp_num_cpus; i++) {
 		int cpu = cpu_logical_map(i);
-		if (aligned_data[cpu].schedule_data.curr != idle_task(cpu))
-			nr_pending--;
+		nr_pending += (nt_running(cpu) - running_non_idle(cpu));
 	}
 #else
+	int nr_pending = nr_running();
+
 	// on UP this process is on the runqueue as well
 	nr_pending--;
 #endif
@@ -1240,6 +1628,7 @@
 void reparent_to_init(void)
 {
 	struct task_struct *this_task = current;
+	unsigned long old_policy;
 
 	write_lock_irq(&tasklist_lock);
 
@@ -1259,11 +1648,23 @@
 
 	/* We also take the runqueue_lock while altering task fields
 	 * which affect scheduling decisions */
-	spin_lock(&runqueue_lock);
+	LOCK_TASK_RQ_VERIFY(this_task);
 
 	this_task->ptrace = 0;
+	/*
+	 * If this is a RT task, we must move it off the
+	 * RT runqueue (and onto a CPU specific queue).
+	 */
+	old_policy = this_task->policy;
+	if (old_policy != SCHED_OTHER) {
+		del_from_runqueue(this_task);
+	}
 	this_task->nice = DEF_NICE;
 	this_task->policy = SCHED_OTHER;
+	if (old_policy != SCHED_OTHER) {
+		add_to_runqueue(this_task);
+	}
+
 	/* cpus_allowed? */
 	/* rt_priority? */
 	/* signals? */
@@ -1274,7 +1675,7 @@
 	memcpy(this_task->rlim, init_task.rlim, sizeof(*(this_task->rlim)));
 	this_task->user = INIT_USER;
 
-	spin_unlock(&runqueue_lock);
+	UNLOCK_TASK_RQ(this_task);
 	write_unlock_irq(&tasklist_lock);
 }
 
@@ -1337,6 +1738,14 @@
 	 */
 	int cpu = smp_processor_id();
 	int nr;
+
+	/*
+	 * Initialize the scheduling data structures
+	 */
+	for (nr = 0; nr < N_RUNQUEUES; nr++)
+		INIT_RUNQUEUE_DATA(nr);
+	for (nr = 0; nr < N_ALIGNED_DATA; nr++)
+		INIT_ALIGNED_DATA(nr);
 
 	init_task.processor = cpu;
 
diff -Naur linux-2.4.14/kernel/signal.c linux-2.4.14-mq/kernel/signal.c
--- linux-2.4.14/kernel/signal.c	Mon Sep 17 23:40:01 2001
+++ linux-2.4.14-mq/kernel/signal.c	Tue Nov  6 22:19:27 2001
@@ -478,10 +478,10 @@
 	 * process of changing - but no harm is done by that
 	 * other than doing an extra (lightweight) IPI interrupt.
 	 */
-	spin_lock(&runqueue_lock);
+	LOCK_TASK_RQ_VERIFY(t);
 	if (t->has_cpu && t->processor != smp_processor_id())
 		smp_send_reschedule(t->processor);
-	spin_unlock(&runqueue_lock);
+	UNLOCK_TASK_RQ(t);
 #endif /* CONFIG_SMP */
 
 	if (t->state & TASK_INTERRUPTIBLE) {
diff -Naur linux-2.4.14/kernel/timer.c linux-2.4.14-mq/kernel/timer.c
--- linux-2.4.14/kernel/timer.c	Mon Oct  8 17:41:41 2001
+++ linux-2.4.14-mq/kernel/timer.c	Tue Nov  6 22:19:27 2001
@@ -587,6 +587,11 @@
 			p->counter = 0;
 			p->need_resched = 1;
 		}
+#ifdef CONFIG_SMP
+		if (curr_na_goodness(cpu) != MIN_GOODNESS) {
+			curr_na_goodness(cpu) = na_goodness(p);
+		}
+#endif
 		if (p->nice > 0)
 			kstat.per_cpu_nice[cpu] += user_tick;
 		else
