Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751386AbWHDFFM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751386AbWHDFFM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 01:05:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751403AbWHDFFM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 01:05:12 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.143]:46472 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751386AbWHDFFI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 01:05:08 -0400
Date: Fri, 4 Aug 2006 10:39:32 +0530
From: Srivatsa Vaddagiri <vatsa@in.ibm.com>
To: Ingo Molnar <mingo@elte.hu>, Nick Piggin <nickpiggin@yahoo.com.au>
Cc: Sam Vilain <sam@vilain.net>, linux-kernel@vger.kernel.org,
       Kirill Korotaev <dev@openvz.org>, Mike Galbraith <efault@gmx.de>,
       Balbir Singh <balbir@in.ibm.com>, sekharan@us.ibm.com,
       Andrew Morton <akpm@osdl.org>, nagar@watson.ibm.com,
       haveblue@us.ibm.com, pj@sgi.com
Subject: [ RFC, PATCH 1/5 ] CPU controller - base changes
Message-ID: <20060804050932.GE27194@in.ibm.com>
Reply-To: vatsa@in.ibm.com
References: <20060804050753.GD27194@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060804050753.GD27194@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch splits the single main runqueue into several runqueues on each CPU.
One (main) runqueue is used to hold task-groups and one runqueue for each
task-group in the system.

Signed-off-by : Srivatsa Vaddagiri <vatsa@in.ibm.com>


 init/Kconfig   |    8 +
 kernel/sched.c |  251 +++++++++++++++++++++++++++++++++++++++++++++++++--------
 2 files changed, 228 insertions(+), 31 deletions(-)

diff -puN kernel/sched.c~cpu_ctlr_base_changes kernel/sched.c
--- linux-2.6.18-rc3/kernel/sched.c~cpu_ctlr_base_changes	2006-08-04 07:56:46.000000000 +0530
+++ linux-2.6.18-rc3-root/kernel/sched.c	2006-08-04 07:56:54.000000000 +0530
@@ -191,10 +191,48 @@ static inline unsigned int task_timeslic
 
 struct prio_array {
 	unsigned int nr_active;
+	int best_static_prio, best_dyn_prio;
 	DECLARE_BITMAP(bitmap, MAX_PRIO+1); /* include 1 bit for delimiter */
 	struct list_head queue[MAX_PRIO];
 };
 
+/* 
+ * Each task belong to some task-group. Task-groups and what tasks they contain 
+ * are defined by the administrator using some suitable interface.
+ * Administrator can also define the CPU bandwidth provided to each task-group.
+ *
+ * Task-groups are given a certain priority to run on every CPU. Currently
+ * task-group priority on a CPU is defined to be the same as that of 
+ * highest-priority runnable task it has on that CPU. Task-groups also
+ * get their own runqueue on every CPU. The main runqueue on each CPU is
+ * used to hold task-groups, rather than tasks.
+ *
+ * Scheduling decision on a CPU is now two-step : first pick highest priority
+ * task-group from the main runqueue and next pick highest priority task from
+ * the runqueue of that group. Both decisions are of O(1) complexity.
+ */
+
+/* runqueue used for every task-group */
+struct task_grp_rq {
+	struct prio_array arrays[2];
+	struct prio_array *active, *expired, *rq_array;
+	unsigned long expired_timestamp;
+	unsigned int ticks;
+	int prio;	/* Priority of the task-group */
+	struct list_head list;
+};
+
+static DEFINE_PER_CPU(struct task_grp_rq, init_tg_rq);
+
+/* task-group object - maintains information about each task-group */
+struct task_grp {
+	int ticks;	/* bandwidth given to the task-group */
+	struct task_grp_rq *rq[NR_CPUS];   /* runqueue pointer for every cpu */
+};
+
+/* The "default" task-group */
+struct task_grp init_task_grp;
+
 /*
  * This is the main, per-CPU runqueue data structure.
  *
@@ -224,12 +262,11 @@ struct rq {
 	 */
 	unsigned long nr_uninterruptible;
 
-	unsigned long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	struct task_struct *curr, *idle;
 	struct mm_struct *prev_mm;
+	/* these arrays hold task-groups */
 	struct prio_array *active, *expired, arrays[2];
-	int best_expired_prio;
 	atomic_t nr_iowait;
 
 #ifdef CONFIG_SMP
@@ -244,6 +281,7 @@ struct rq {
 #endif
 
 #ifdef CONFIG_SCHEDSTATS
+	/* xxx: move these to task-group runqueue */
 	/* latency stats */
 	struct sched_info rq_sched_info;
 
@@ -657,6 +695,63 @@ sched_info_switch(struct task_struct *pr
 #define sched_info_switch(t, next)	do { } while (0)
 #endif /* CONFIG_SCHEDSTATS || CONFIG_TASK_DELAY_ACCT */
 
+static unsigned int task_grp_timeslice(struct task_grp *tg)
+{
+	/* xxx: take into account sleep_avg etc of the group */
+	return tg->ticks;
+}
+
+/* Dequeue task-group object from the main runqueue */
+static void dequeue_task_grp(struct task_grp_rq *tgrq)
+{
+	struct prio_array *array = tgrq->rq_array;
+
+	array->nr_active--;
+	list_del(&tgrq->list);
+	if (list_empty(array->queue + tgrq->prio))
+		__clear_bit(tgrq->prio, array->bitmap);
+	tgrq->rq_array = NULL;
+}
+
+/* Enqueue task-group object on the main runqueue */
+static void enqueue_task_grp(struct task_grp_rq *tgrq, struct prio_array *array,
+				int head)
+{
+	if (!head)
+		list_add_tail(&tgrq->list, array->queue + tgrq->prio);
+	else
+        	list_add(&tgrq->list, array->queue + tgrq->prio);
+        __set_bit(tgrq->prio, array->bitmap);
+        array->nr_active++;
+        tgrq->rq_array = array;
+}
+
+/* return the task-group to which a task belongs */
+static inline struct task_grp *task_grp(struct task_struct *p)
+{
+	return &init_task_grp;
+}
+
+static inline void update_task_grp_prio(struct task_grp_rq *tgrq, struct rq *rq,
+								 int head)
+{
+	int new_prio;
+	struct prio_array *array = tgrq->rq_array;
+
+	new_prio = tgrq->active->best_dyn_prio;
+	if (new_prio == MAX_PRIO)
+		new_prio = tgrq->expired->best_dyn_prio;
+
+	if (array)
+		dequeue_task_grp(tgrq);
+	tgrq->prio = new_prio;
+	if (new_prio != MAX_PRIO) {
+		if (!array)
+			array = rq->active;
+		enqueue_task_grp(tgrq, array, head);
+	}
+}
+
 /*
  * Adding/removing a task to/from a priority array:
  */
@@ -664,8 +759,17 @@ static void dequeue_task(struct task_str
 {
 	array->nr_active--;
 	list_del(&p->run_list);
-	if (list_empty(array->queue + p->prio))
+	if (list_empty(array->queue + p->prio)) {
 		__clear_bit(p->prio, array->bitmap);
+		if (p->prio == array->best_dyn_prio) {
+			struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
+
+			array->best_dyn_prio =
+					sched_find_first_bit(array->bitmap);
+			if (array == tgrq->active || !tgrq->active->nr_active)
+				update_task_grp_prio(tgrq, task_rq(p), 0);
+		}
+	}
 }
 
 static void enqueue_task(struct task_struct *p, struct prio_array *array)
@@ -675,6 +779,14 @@ static void enqueue_task(struct task_str
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
+
+	if (p->prio < array->best_dyn_prio) {
+		struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
+
+		array->best_dyn_prio = p->prio;
+		if (array == tgrq->active || !tgrq->active->nr_active)
+			update_task_grp_prio(tgrq, task_rq(p), 0);
+	}
 }
 
 /*
@@ -693,6 +805,14 @@ enqueue_task_head(struct task_struct *p,
 	__set_bit(p->prio, array->bitmap);
 	array->nr_active++;
 	p->array = array;
+
+	if (p->prio < array->best_dyn_prio) {
+		struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
+
+		array->best_dyn_prio = p->prio;
+		if (array == tgrq->active || !tgrq->active->nr_active)
+			update_task_grp_prio(tgrq, task_rq(p), 1);
+	}
 }
 
 /*
@@ -831,10 +951,11 @@ static int effective_prio(struct task_st
  */
 static void __activate_task(struct task_struct *p, struct rq *rq)
 {
-	struct prio_array *target = rq->active;
+	struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
+	struct prio_array *target = tgrq->active;
 
 	if (batch_task(p))
-		target = rq->expired;
+		target = tgrq->expired;
 	enqueue_task(p, target);
 	inc_nr_running(p, rq);
 }
@@ -844,7 +965,10 @@ static void __activate_task(struct task_
  */
 static inline void __activate_idle_task(struct task_struct *p, struct rq *rq)
 {
-	enqueue_task_head(p, rq->active);
+	struct task_grp_rq *tgrq = task_grp(p)->rq[task_cpu(p)];
+	struct prio_array *target = tgrq->active;
+
+	enqueue_task_head(p, target);
 	inc_nr_running(p, rq);
 }
 
@@ -2077,7 +2201,7 @@ int can_migrate_task(struct task_struct 
 	return 1;
 }
 
-#define rq_best_prio(rq) min((rq)->curr->prio, (rq)->best_expired_prio)
+#define rq_best_prio(rq) min((rq)->curr->prio, (rq)->expired->best_static_prio)
 
 /*
  * move_tasks tries to move up to max_nr_move tasks and max_load_move weighted
@@ -2884,6 +3008,8 @@ unsigned long long current_sched_time(co
 	return ns;
 }
 
+#define nr_tasks(tgrq)	(tgrq->active->nr_active + tgrq->expired->nr_active)
+
 /*
  * We place interactive tasks back into the active array, if possible.
  *
@@ -2894,13 +3020,13 @@ unsigned long long current_sched_time(co
  * increasing number of running tasks. We also ignore the interactivity
  * if a better static_prio task has expired:
  */
-static inline int expired_starving(struct rq *rq)
+static inline int expired_starving(struct task_grp_rq *rq)
 {
-	if (rq->curr->static_prio > rq->best_expired_prio)
+	if (current->static_prio > rq->expired->best_static_prio)
 		return 1;
 	if (!STARVATION_LIMIT || !rq->expired_timestamp)
 		return 0;
-	if (jiffies - rq->expired_timestamp > STARVATION_LIMIT * rq->nr_running)
+	if (jiffies - rq->expired_timestamp > STARVATION_LIMIT * nr_tasks(rq))
 		return 1;
 	return 0;
 }
@@ -2991,6 +3117,7 @@ void scheduler_tick(void)
 	struct task_struct *p = current;
 	int cpu = smp_processor_id();
 	struct rq *rq = cpu_rq(cpu);
+	struct task_grp_rq *tgrq = task_grp(p)->rq[cpu];
 
 	update_cpu_clock(p, rq, now);
 
@@ -3004,7 +3131,7 @@ void scheduler_tick(void)
 	}
 
 	/* Task might have expired already, but not scheduled off yet */
-	if (p->array != rq->active) {
+	if (p->array != tgrq->active) {
 		set_tsk_need_resched(p);
 		goto out;
 	}
@@ -3027,25 +3154,26 @@ void scheduler_tick(void)
 			set_tsk_need_resched(p);
 
 			/* put it at the end of the queue: */
-			requeue_task(p, rq->active);
+			requeue_task(p, tgrq->active);
 		}
 		goto out_unlock;
 	}
 	if (!--p->time_slice) {
-		dequeue_task(p, rq->active);
+		dequeue_task(p, tgrq->active);
 		set_tsk_need_resched(p);
 		p->prio = effective_prio(p);
 		p->time_slice = task_timeslice(p);
 		p->first_time_slice = 0;
 
-		if (!rq->expired_timestamp)
-			rq->expired_timestamp = jiffies;
-		if (!TASK_INTERACTIVE(p) || expired_starving(rq)) {
-			enqueue_task(p, rq->expired);
-			if (p->static_prio < rq->best_expired_prio)
-				rq->best_expired_prio = p->static_prio;
+		if (!tgrq->expired_timestamp)
+			tgrq->expired_timestamp = jiffies;
+		if (!TASK_INTERACTIVE(p) || expired_starving(tgrq)) {
+			enqueue_task(p, tgrq->expired);
+			if (p->static_prio < tgrq->expired->best_static_prio)
+				tgrq->expired->best_static_prio =
+							 p->static_prio;
 		} else
-			enqueue_task(p, rq->active);
+			enqueue_task(p, tgrq->active);
 	} else {
 		/*
 		 * Prevent a too long timeslice allowing a task to monopolize
@@ -3066,12 +3194,21 @@ void scheduler_tick(void)
 		if (TASK_INTERACTIVE(p) && !((task_timeslice(p) -
 			p->time_slice) % TIMESLICE_GRANULARITY(p)) &&
 			(p->time_slice >= TIMESLICE_GRANULARITY(p)) &&
-			(p->array == rq->active)) {
+			(p->array == tgrq->active)) {
 
-			requeue_task(p, rq->active);
+			requeue_task(p, tgrq->active);
 			set_tsk_need_resched(p);
 		}
 	}
+
+	if (!--tgrq->ticks) {
+		/* Move the task group to expired list */
+		dequeue_task_grp(tgrq);
+		tgrq->ticks = task_grp_timeslice(task_grp(p));
+		enqueue_task_grp(tgrq, rq->expired, 0);
+		set_tsk_need_resched(p);
+	}
+
 out_unlock:
 	spin_unlock(&rq->lock);
 out:
@@ -3264,6 +3401,7 @@ asmlinkage void __sched schedule(void)
 	int cpu, idx, new_prio;
 	long *switch_count;
 	struct rq *rq;
+	struct task_grp_rq *next_grp;
 
 	/*
 	 * Test if we are atomic.  Since do_exit() needs to call into
@@ -3332,23 +3470,41 @@ need_resched_nonpreemptible:
 		idle_balance(cpu, rq);
 		if (!rq->nr_running) {
 			next = rq->idle;
-			rq->expired_timestamp = 0;
 			wake_sleeping_dependent(cpu);
 			goto switch_tasks;
 		}
 	}
 
+	/* Pick a task group first */
+#ifdef CONFIG_CPUMETER
 	array = rq->active;
 	if (unlikely(!array->nr_active)) {
 		/*
 		 * Switch the active and expired arrays.
 		 */
-		schedstat_inc(rq, sched_switch);
 		rq->active = rq->expired;
 		rq->expired = array;
 		array = rq->active;
-		rq->expired_timestamp = 0;
-		rq->best_expired_prio = MAX_PRIO;
+	}
+	idx = sched_find_first_bit(array->bitmap);
+	queue = array->queue + idx;
+	next_grp = list_entry(queue->next, struct task_grp_rq, list);
+#else
+	next_grp = init_task_grp.rq[cpu];
+#endif
+
+	/* Pick a task within that group next */
+	array = next_grp->active;
+	if (!array->nr_active) {
+		/*
+		 * Switch the active and expired arrays.
+		 */
+		schedstat_inc(next_grp, sched_switch);
+		next_grp->active = next_grp->expired;
+		next_grp->expired = array;
+		array = next_grp->active;
+		next_grp->expired_timestamp = 0;
+		next_grp->expired->best_static_prio = MAX_PRIO;
 	}
 
 	idx = sched_find_first_bit(array->bitmap);
@@ -4413,7 +4569,8 @@ asmlinkage long sys_sched_getaffinity(pi
 asmlinkage long sys_sched_yield(void)
 {
 	struct rq *rq = this_rq_lock();
-	struct prio_array *array = current->array, *target = rq->expired;
+	struct task_grp_rq *tgrq = task_grp(current)->rq[task_cpu(current)];
+	struct prio_array *array = current->array, *target = tgrq->expired;
 
 	schedstat_inc(rq, yld_cnt);
 	/*
@@ -4424,13 +4581,13 @@ asmlinkage long sys_sched_yield(void)
 	 *  array.)
 	 */
 	if (rt_task(current))
-		target = rq->active;
+		target = tgrq->active;
 
 	if (array->nr_active == 1) {
 		schedstat_inc(rq, yld_act_empty);
-		if (!rq->expired->nr_active)
+		if (!tgrq->expired->nr_active)
 			schedstat_inc(rq, yld_both_empty);
-	} else if (!rq->expired->nr_active)
+	} else if (!tgrq->expired->nr_active)
 		schedstat_inc(rq, yld_exp_empty);
 
 	if (array != target) {
@@ -6722,21 +6879,53 @@ int in_sched_functions(unsigned long add
 		&& addr < (unsigned long)__sched_text_end);
 }
 
+static void task_grp_rq_init(struct task_grp_rq *tgrq, int ticks)
+{
+	int j, k;
+
+	tgrq->active = tgrq->arrays;
+	tgrq->expired = tgrq->arrays + 1;
+	tgrq->rq_array = NULL;
+	tgrq->expired->best_static_prio = MAX_PRIO;
+	tgrq->expired->best_dyn_prio = MAX_PRIO;
+	tgrq->active->best_static_prio = MAX_PRIO;
+	tgrq->active->best_dyn_prio = MAX_PRIO;
+	tgrq->prio = MAX_PRIO;
+	tgrq->ticks = ticks;
+	INIT_LIST_HEAD(&tgrq->list);
+
+	for (j = 0; j < 2; j++) {
+		struct prio_array *array;
+
+		array = tgrq->arrays + j;
+		for (k = 0; k < MAX_PRIO; k++) {
+			INIT_LIST_HEAD(array->queue + k);
+			__clear_bit(k, array->bitmap);
+		}
+		// delimiter for bitsearch
+		__set_bit(MAX_PRIO, array->bitmap);
+	}
+}
+
 void __init sched_init(void)
 {
 	int i, j, k;
 
+	init_task_grp.ticks = -1;     /* Unlimited bandwidth */
+
 	for_each_possible_cpu(i) {
 		struct prio_array *array;
 		struct rq *rq;
+		struct task_grp_rq *tgrq;
 
 		rq = cpu_rq(i);
+		tgrq = init_task_grp.rq[i] = &per_cpu(init_tg_rq, i);
 		spin_lock_init(&rq->lock);
+		task_grp_rq_init(tgrq, init_task_grp.ticks);
 		lockdep_set_class(&rq->lock, &rq->rq_lock_key);
 		rq->nr_running = 0;
 		rq->active = rq->arrays;
 		rq->expired = rq->arrays + 1;
-		rq->best_expired_prio = MAX_PRIO;
 
 #ifdef CONFIG_SMP
 		rq->sd = NULL;
diff -puN init/Kconfig~cpu_ctlr_base_changes init/Kconfig
--- linux-2.6.18-rc3/init/Kconfig~cpu_ctlr_base_changes	2006-08-04 07:56:46.000000000 +0530
+++ linux-2.6.18-rc3-root/init/Kconfig	2006-08-04 07:56:54.000000000 +0530
@@ -248,6 +248,14 @@ config CPUSETS
 
 	  Say N if unsure.
 
+config CPUMETER
+	bool "CPU resource control"
+	depends on CPUSETS
+	help
+	  This options lets you create cpu resource partitions within
+	  cpusets. Each resource partition can be given a different quota
+	  of CPU usage.
+
 config RELAY
 	bool "Kernel->user space relay support (formerly relayfs)"
 	help

_
-- 
Regards,
vatsa
