Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314278AbSIACHG>; Sat, 31 Aug 2002 22:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315214AbSIACHG>; Sat, 31 Aug 2002 22:07:06 -0400
Received: from dp.samba.org ([66.70.73.150]:13999 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S314278AbSIACHC>;
	Sat, 31 Aug 2002 22:07:02 -0400
Date: Sun, 1 Sep 2002 11:48:42 +1000
From: Rusty Russell <rusty@rustcorp.com.au>
To: Ingo Molnar <mingo@elte.hu>
Cc: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [patch] "fully HT-aware scheduler" support, 2.5.31-BK-curr
Message-Id: <20020901114842.4a03d264.rusty@rustcorp.com.au>
In-Reply-To: <Pine.LNX.4.44.0208270226190.12947-100000@localhost.localdomain>
References: <Pine.LNX.4.44.0208270226190.12947-100000@localhost.localdomain>
X-Mailer: Sylpheed version 0.7.4 (GTK+ 1.2.10; powerpc-debian-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Aug 2002 03:44:23 +0200 (CEST)
Ingo Molnar <mingo@elte.hu> wrote:
> the attached patch (against 2.5.31-BK-curr) implements all the above
> HT-scheduling needs by introducing the concept of a shared runqueue:

Hi Ingo,

	I finally got around to reading your patch properly.  I've combined
it with my earlier (unpublished) patch: my aim was not to have any config
options.  I really don't like overloading the migration thread to do
rebalancing either, but that's a separate problem.

	This patch compiles, but is untested (I'll test it when I get into
work again).  The main difference is that the per-cpu info is the primary
object, the runqueue is derived.  My original version didn't keep sibling
lists, but you use that for HT-aware wakeup stuff, so I've kept that.

Anyway, for your reading pleasure (against your 2.5.32 + your patch):

diff -u working-2.5.32-sched/kernel/sched.c.~1~ working-2.5.32-sched/kernel/sched.c
--- working-2.5.32-sched/kernel/sched.c.~1~	2002-09-01 10:35:10.000000000 +1000
+++ working-2.5.32-sched/kernel/sched.c	2002-09-01 11:39:36.000000000 +1000
@@ -29,6 +29,7 @@
 #include <linux/interrupt.h>
 #include <linux/completion.h>
 #include <linux/kernel_stat.h>
+#include <linux/percpu.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -137,49 +138,7 @@
 };
 
 /*
- * It's possible for two CPUs to share the same runqueue.
- * This makes sense if they eg. share caches.
- *
- * We take the common 1:1 (SMP, UP) case and optimize it,
- * the rest goes via remapping: rq_idx(cpu) gives the
- * runqueue on which a particular cpu is on, cpu_idx(cpu)
- * gives the rq-specific index of the cpu.
- *
- * (Note that the generic scheduler code does not impose any
- *  restrictions on the mappings - there can be 4 CPUs per
- *  runqueue or even assymetric mappings.)
- */
-#if CONFIG_SHARE_RUNQUEUE
-# define MAX_NR_SIBLINGS CONFIG_MAX_NR_SIBLINGS
-  static long __rq_idx[NR_CPUS] __cacheline_aligned;
-  static long __cpu_idx[NR_CPUS] __cacheline_aligned;
-# define rq_idx(cpu) (__rq_idx[(cpu)])
-# define cpu_idx(cpu) (__cpu_idx[(cpu)])
-# define for_each_sibling(idx, rq) \
-		for ((idx) = 0; (idx) < (rq)->nr_cpus; (idx)++)
-# define rq_nr_cpus(rq) ((rq)->nr_cpus)
-# define cpu_active_balance(c) (cpu_rq(c)->cpu[0].active_balance)
-#else
-# define MAX_NR_SIBLINGS 1
-# define rq_idx(cpu) (cpu)
-# define cpu_idx(cpu) 0
-# define for_each_sibling(idx, rq) while (0)
-# define cpu_active_balance(c) 0
-# define do_active_balance(rq, cpu) do { } while (0)
-# define rq_nr_cpus(rq) 1
-  static inline void active_load_balance(runqueue_t *rq, int this_cpu) { }
-#endif
-
-typedef struct cpu_s {
-	task_t *curr, *idle;
-	task_t *migration_thread;
-	list_t migration_queue;
-	int active_balance;
-	int cpu;
-} cpu_t;
-
-/*
- * This is the main, per-CPU runqueue data structure.
+ * This is the main per-runqueue data structure.
  *
  * Locking rule: those places that want to lock multiple runqueues
  * (such as the load balancing or the thread migration code), lock
@@ -190,26 +149,55 @@
 	unsigned long nr_running, nr_switches, expired_timestamp,
 			nr_uninterruptible;
 	prio_array_t *active, *expired, arrays[2];
+	int is_shared; /* Is this runqueue shared by > 1 cpu? */
+	int active_balance;
 	int prev_nr_running[NR_CPUS];
+};
+
+/* one of these for each cpu */
+struct sched_info {
+	task_t *curr, *idle;
+	task_t *migration_thread;
+	list_t migration_queue;
 
-	int nr_cpus;
-	cpu_t cpu[MAX_NR_SIBLINGS];
+	/* Sibling for this CPU (ring list) */
+	unsigned int sibling_cpu;
 
-} ____cacheline_aligned;
+	/* The runqueue for this CPU (normally points to next field) */
+	struct runqueue *rq;
+	struct runqueue runqueue;
+};
 
-static struct runqueue runqueues[NR_CPUS] __cacheline_aligned;
+static DEFINE_PER_CPU(struct sched_info, sched_infos);
 
-#define cpu_rq(cpu)		(runqueues + (rq_idx(cpu)))
-#define cpu_int(c)		((cpu_rq(c))->cpu + cpu_idx(c))
-#define cpu_curr_ptr(cpu)	(cpu_int(cpu)->curr)
-#define cpu_idle_ptr(cpu)	(cpu_int(cpu)->idle)
+#define cpu_info(cpu)		(per_cpu(sched_infos, (cpu)))
+#define cpu_rq(cpu)		(cpu_info(cpu).rq)
+#define cpu_curr_ptr(cpu)	(cpu_info(cpu).curr)
+#define cpu_idle_ptr(cpu)	(cpu_info(cpu).idle)
 
-#define this_rq()		cpu_rq(smp_processor_id())
+#define this_rq()		(__get_cpu_var(sched_infos).rq)
 #define task_rq(p)		cpu_rq(task_cpu(p))
 #define rt_task(p)		((p)->prio < MAX_RT_PRIO)
 
-#define migration_thread(cpu)	(cpu_int(cpu)->migration_thread)
-#define migration_queue(cpu)	(&cpu_int(cpu)->migration_queue)
+#define migration_thread(cpu)	(cpu_info(cpu).migration_thread)
+#define migration_queue(cpu)	(&cpu_info(cpu).migration_queue)
+
+/* It's possible for two CPUs to share the same runqueue.  This makes
+ * sense if they eg. share caches. */
+#if CONFIG_SHARE_RUNQUEUE
+# define for_each_sibling(idx, cpu)		\
+	for (idx = cpu_info(cpu).sibling_cpu;	\
+	     idx != cpu;			\
+	     idx = cpu_info(idx).sibling_cpu)
+# define cpu_active_balance(c) (cpu_rq(c)->active_balance)
+# define rq_shared(rq)	((rq)->rq_shared)
+#else
+# define for_each_sibling(idx, cpu) while (0)
+# define cpu_active_balance(c) 0
+# define do_active_balance(rq, cpu) do { } while (0)
+  static inline void active_load_balance(runqueue_t *rq, int this_cpu) { }
+# define rq_shared(rq)	0
+#endif
 
 #if NR_CPUS > 1
 # define task_allowed(p, cpu)	((p)->cpus_allowed & (1UL << (cpu)))
@@ -435,11 +423,6 @@
 
 #endif
 
-static inline void resched_cpu(int cpu)
-{
-	resched_task(cpu_curr_ptr(cpu));
-}
-
 /*
  * kick_if_running - kick the remote CPU if the task is running currently.
  *
@@ -456,34 +439,28 @@
 		resched_task(p);
 }
 
-static void wake_up_cpu(runqueue_t *rq, int cpu, task_t *p)
+static void wake_up_cpu(int cpu, task_t *p)
 {
-	cpu_t *curr_cpu;
-	task_t *curr;
-	int idx;
-
-	if (idle_cpu(cpu))
-		return resched_cpu(cpu);
-
-	for_each_sibling(idx, rq) {
-		curr_cpu = rq->cpu + idx;
-		if (!task_allowed(p, curr_cpu->cpu))
-			continue;
-		if (curr_cpu->idle == curr_cpu->curr)
-			return resched_cpu(curr_cpu->cpu);
-	}
+	unsigned int idx;
 
-	if (p->prio < cpu_curr_ptr(cpu)->prio)
-		return resched_task(cpu_curr_ptr(cpu));
+	/* First seek idle CPUs */
+	idx = cpu;
+	do {
+		if (!task_allowed(p, idx))
+			continue;
+		if (cpu_idle_ptr(idx) == cpu_curr_ptr(idx))
+			return resched_task(cpu_curr_ptr(idx));
+		idx = cpu_info(idx).sibling_cpu;
+	} while (idx != cpu);
 
-	for_each_sibling(idx, rq) {
-		curr_cpu = rq->cpu + idx;
-		if (!task_allowed(p, curr_cpu->cpu))
+	/* Now seek CPUs running lower priority task */
+	idx = cpu;
+	do {
+		if (!task_allowed(p, idx))
 			continue;
-		curr = curr_cpu->curr;
-		if (p->prio < curr->prio)
-			return resched_task(curr);
-	}
+		if (p->prio < cpu_curr_ptr(idx)->prio)
+			return resched_task(cpu_curr_ptr(idx));
+	} while (idx != cpu);
 }
 
 /***
@@ -526,7 +503,7 @@
 			rq->nr_uninterruptible--;
 		activate_task(p, rq);
 
-		wake_up_cpu(rq, task_cpu(p), p);
+		wake_up_cpu(task_cpu(p), p);
 
 		success = 1;
 	}
@@ -645,9 +622,7 @@
 	unsigned long i, sum = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
-		/* Shared runqueues are counted only once. */
-		if (!cpu_idx(i))
-			sum += cpu_rq(i)->nr_running;
+		sum += cpu_info(i).runqueue.nr_running;
 
 	return sum;
 }
@@ -657,9 +632,7 @@
 	unsigned long i, sum = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
-		/* Shared runqueues are counted only once. */
-		if (!cpu_idx(i))
-			sum += cpu_rq(i)->nr_uninterruptible;
+		sum += cpu_info(i).runqueue.nr_running;
 
 	return sum;
 }
@@ -840,7 +813,7 @@
 	set_task_cpu(p, this_cpu);
 	this_rq->nr_running++;
 	enqueue_task(p, this_rq->active);
-	wake_up_cpu(this_rq, this_cpu, p);
+	wake_up_cpu(this_cpu, p);
 }
 
 /*
@@ -944,20 +917,18 @@
 #if CONFIG_SHARE_RUNQUEUE
 static void active_load_balance(runqueue_t *this_rq, int this_cpu)
 {
-	runqueue_t *rq;
 	int i, idx;
 
 	for (i = 0; i < NR_CPUS; i++) {
 		if (!cpu_online(i))
 			continue;
-		rq = cpu_rq(i);
-		if (rq == this_rq)
+		if (cpu_rq(i) == this_rq)
 			continue;
 		/*
 		 * Any SMT-specific imbalance?
 		 */
-		for_each_sibling(idx, rq)
-			if (rq->cpu[idx].idle == rq->cpu[idx].curr)
+		for_each_sibling(idx, i)
+			if (idle_cpu(idx))
 				goto next_cpu;
 
 		/*
@@ -971,7 +942,7 @@
 		if (!cpu_active_balance(this_cpu)) {
 			cpu_active_balance(this_cpu) = 1;
 			spin_unlock(&this_rq->lock);
-			wake_up_process(rq->cpu[0].migration_thread);
+			wake_up_process(migration_thread(this_cpu));
 			spin_lock(&this_rq->lock);
 		}
 next_cpu:
@@ -991,8 +962,8 @@
 	/*
 	 * Is the imbalance still present?
 	 */
-	for_each_sibling(idx, this_rq)
-		if (this_rq->cpu[idx].idle == this_rq->cpu[idx].curr)
+	for_each_sibling(idx, this_cpu)
+		if (cpu_idle(idx))
 			goto out;
 
 	for (i = 0; i < NR_CPUS; i++) {
@@ -1021,21 +992,23 @@
 }
 
 /*
- * This routine is called to map a CPU into another CPU's runqueue.
+ * This routine is called to make CPU2 use CPU1's runqueue.
  *
  * This must be called during bootup with the merged runqueue having
  * no tasks.
  */
 void sched_map_runqueue(int cpu1, int cpu2)
 {
-	runqueue_t *rq1 = cpu_rq(cpu1);
-	runqueue_t *rq2 = cpu_rq(cpu2);
-	int cpu2_idx_orig = cpu_idx(cpu2), cpu2_idx;
+	struct sched_info *info1 = cpu_info(cpu1), *info2 = cpu_info(cpu2);
 
 	printk("sched_merge_runqueues: CPU#%d <=> CPU#%d, on CPU#%d.\n", cpu1, cpu2, smp_processor_id());
-	if (rq1 == rq2)
+	if (cpu1 == cpu2)
 		BUG();
-	if (rq2->nr_running)
+	if (info2->rq->nr_running)
+		BUG();
+	if (info2->rq->is_shared)
+		BUG();
+	if (info2->rq != &info2->runqueue)
 		BUG();
 	/*
 	 * At this point, we dont have anything in the runqueue yet. So,
@@ -1043,20 +1016,15 @@
 	 * Only, the idle processes should be combined and accessed
 	 * properly.
 	 */
-	cpu2_idx = rq1->nr_cpus++;
+	info1->rq->shared = 1;
+	info2->rq = info1->rq;
 
-	if (rq_idx(cpu1) != cpu1)
-		BUG();
-	rq_idx(cpu2) = cpu1;
-	cpu_idx(cpu2) = cpu2_idx;
-	rq1->cpu[cpu2_idx].cpu = cpu2;
-	rq1->cpu[cpu2_idx].idle = rq2->cpu[cpu2_idx_orig].idle;
-	rq1->cpu[cpu2_idx].curr = rq2->cpu[cpu2_idx_orig].curr;
-	INIT_LIST_HEAD(&rq1->cpu[cpu2_idx].migration_queue);
+	info2->cpu_sibling = info1->cpu_sibling;
+	info1->cpu_sibling = cpu2;
 
 	/* just to be safe: */
-	rq2->cpu[cpu2_idx_orig].idle = NULL;
-	rq2->cpu[cpu2_idx_orig].curr = NULL;
+	info2->runqueue.idle = NULL;
+	info2->runqueue.curr = NULL;
 }
 #endif
 
@@ -1228,7 +1196,7 @@
 	idx = sched_find_first_bit(array->bitmap);
 	queue = array->queue + idx;
 	next = list_entry(queue->next, task_t, run_list);
-	if ((next != prev) && (rq_nr_cpus(rq) > 1)) {
+	if ((next != prev) && rq_shared(rq)) {
 		list_t *tmp = queue->next;
 
 		while (task_running(next) || !task_allowed(next, this_cpu)) {
@@ -2214,7 +2182,7 @@
 	struct sched_param param = { .sched_priority = MAX_RT_PRIO-1 };
 	int cpu = (long) data;
 	runqueue_t *rq;
-	int ret, idx;
+	int ret;
 
 	daemonize();
 	sigfillset(&current->blocked);
@@ -2234,7 +2202,6 @@
 
 	rq = this_rq();
 	migration_thread(cpu) = current;
-	idx = cpu_idx(cpu);
 
 	sprintf(current->comm, "migration_CPU%d", smp_processor_id());
 
@@ -2353,17 +2320,14 @@
 		/*
 		 * Start with a 1:1 mapping between CPUs and runqueues:
 		 */
-#if CONFIG_SHARE_RUNQUEUE
-		rq_idx(i) = i;
-		cpu_idx(i) = 0;
-#endif
+		cpu_info(i).rq = &cpu_info(i).runqueue;
+		cpu_info(i).sibling_cpu = i;
+
 		rq = cpu_rq(i);
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
 		spin_lock_init(&rq->lock);
 		INIT_LIST_HEAD(migration_queue(i));
-		rq->nr_cpus = 1;
-		rq->cpu[cpu_idx(i)].cpu = i;
 
 		for (j = 0; j < 2; j++) {
 			array = rq->arrays + j;

-- 
   there are those who do and those who hang on and you don't see too
   many doers quoting their contemporaries.  -- Larry McVoy
