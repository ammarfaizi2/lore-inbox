Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030276AbWBGXee@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030276AbWBGXee (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Feb 2006 18:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030277AbWBGXee
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Feb 2006 18:34:34 -0500
Received: from smtp.osdl.org ([65.172.181.4]:47014 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1030276AbWBGXed (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Feb 2006 18:34:33 -0500
Date: Tue, 7 Feb 2006 15:36:17 -0800
From: Andrew Morton <akpm@osdl.org>
To: Con Kolivas <kernel@kolivas.org>
Cc: npiggin@suse.de, mingo@elte.hu, rostedt@goodmis.org,
       pwil3058@bigpond.net.au, suresh.b.siddha@intel.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [rfc][patch] sched: remove smpnice
Message-Id: <20060207153617.6520f126.akpm@osdl.org>
In-Reply-To: <200602081011.09749.kernel@kolivas.org>
References: <20060207142828.GA20930@wotan.suse.de>
	<200602080157.07823.kernel@kolivas.org>
	<20060207141525.19d2b1be.akpm@osdl.org>
	<200602081011.09749.kernel@kolivas.org>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> > Well was any real-world workload (or benchmark) improved by the smpnice
> > change?
> 
> No benchmark improved but 'nice' handling moved from completely not working on 
> SMP to having quite effective cpu resource modification according to nice. 
> nice 19 vs nice 0 has 5% of the cpu on UP. On SMP machines without smp nice 
> if you have more tasks than cpus (the 5 tasks on 4 cpu example) you often get 
> nice 19 tasks getting more cpu resources than nice 0 tasks; a nice 19 task 
> would get 100% of one cpu and two nice 0 tasks would get 50% of a cpu. With 
> smp nice the nice 19 task received between 5-30% of one cpu depending on 
> their sleep/wake pattern.

Oh, is that why my machine goes paralytic during `nice -19 make -j 128'.

> > Because if we have one workload which slowed and and none which sped up,
> > it's a pretty easy decision..
> 
> The resource allocation fairness was improved with smp nice but no benchmark 
> directly sped up per se.
> 

In that case I think we're better off fixing both problems rather than
fixing neither.

Suresh, Martin, Ingo, Nick and Con: please drop everything, triple-check
and test this:



From: Peter Williams <pwil3058@bigpond.net.au>

This is a modified version of Con Kolivas's patch to add "nice" support to
load balancing across physical CPUs on SMP systems.

The principal modifications to the Con's mechanism are changing
move_tasks() so that it endeavours to move a specified amount of biased
load rather than a specified number of tasks, changing find_busiest_group()
so that the value returned in "imbalance" is in terms of biased load rather
than number of tasks and changing rebalance_tick() to calculate "cpu_load"
for each run queue as biased load rather than plain load.  To be more
precise, because of the special case of active_load_balance() wanting to
move exactly 1 task, move_tasks() actually moves up to a given number of
tasks or up to a given amount of biased load.

Because these changes mean that tasks' biased prio is evaluated much more
often than in the original implementation a "bias_prio" field has been
added to the task structure to hold its value meaning that it only needs to
be calculated when the task's nice or scheduling class is changed.  This
change facilitates considerable simplification of much of the code.

Signed-off-by: Peter Williams <pwil3058@bigpond.net.au>
Acked-by: Ingo Molnar <mingo@elte.hu>
Cc: "Martin J. Bligh" <mbligh@google.com>
Signed-off-by: Con Kolivas <kernel@kolivas.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 include/linux/sched.h |    3 
 kernel/sched.c        |  198 ++++++++++++++++++++++------------------
 2 files changed, 112 insertions(+), 89 deletions(-)

diff -puN include/linux/sched.h~sched-modified-nice-support-for-smp-load-balancing include/linux/sched.h
--- 25/include/linux/sched.h~sched-modified-nice-support-for-smp-load-balancing	Tue Feb  7 15:33:17 2006
+++ 25-akpm/include/linux/sched.h	Tue Feb  7 15:33:29 2006
@@ -704,6 +704,9 @@ struct task_struct {
 #endif
 #endif
 	int prio, static_prio;
+#ifdef CONFIG_SMP
+	int bias_prio;	/* load "weight" factor for load balancing purposes */
+#endif
 	struct list_head run_list;
 	prio_array_t *array;
 
diff -puN kernel/sched.c~sched-modified-nice-support-for-smp-load-balancing kernel/sched.c
--- 25/kernel/sched.c~sched-modified-nice-support-for-smp-load-balancing	Tue Feb  7 15:33:17 2006
+++ 25-akpm/kernel/sched.c	Tue Feb  7 15:33:33 2006
@@ -63,6 +63,14 @@
 #define TASK_NICE(p)		PRIO_TO_NICE((p)->static_prio)
 
 /*
+ * Priority bias for load balancing ranges from 1 (nice==19) to 139 (RT
+ * priority of 100).
+ */
+#define NICE_TO_BIAS_PRIO(nice)	(20 - (nice))
+#define PRIO_TO_BIAS_PRIO(prio)	NICE_TO_BIAS_PRIO(PRIO_TO_NICE(prio))
+#define RTPRIO_TO_BIAS_PRIO(rp)	(40 + (rp))
+
+/*
  * 'User priority' is the nice value converted to something we
  * can work with better when scaling various scheduler parameters,
  * it's a [ 0 ... 39 ] range.
@@ -670,46 +678,72 @@ static int effective_prio(task_t *p)
 }
 
 #ifdef CONFIG_SMP
-static inline void inc_prio_bias(runqueue_t *rq, int prio)
+/*
+ * To aid in avoiding the subversion of "niceness" due to uneven distribution
+ * of tasks with abnormal "nice" values across CPUs the contribution that
+ * each task makes to its run queue's load is weighted according to its
+ * scheduling class and "nice" value.  The bias_prio field holds the value
+ * used to calculate the weight for each task.
+ */
+static inline void set_bias_prio(task_t *p)
+{
+	if (rt_task(p)) {
+		if (p == task_rq(p)->migration_thread)
+			/*
+			 * The migration thread does the actual balancing. Do
+			 * not bias by its priority as the ultra high priority
+			 * will skew balancing adversely.
+			 */
+			p->bias_prio = 0;
+		else
+			p->bias_prio = RTPRIO_TO_BIAS_PRIO(p->rt_priority);
+	} else
+		p->bias_prio = PRIO_TO_BIAS_PRIO(p->static_prio);
+}
+
+static inline void inc_prio_bias(runqueue_t *rq, const task_t *p)
 {
-	rq->prio_bias += MAX_PRIO - prio;
+	rq->prio_bias += p->bias_prio;
 }
 
-static inline void dec_prio_bias(runqueue_t *rq, int prio)
+static inline void dec_prio_bias(runqueue_t *rq, const task_t *p)
 {
-	rq->prio_bias -= MAX_PRIO - prio;
+	rq->prio_bias -= p->bias_prio;
 }
 
 static inline void inc_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running++;
-	if (rt_task(p)) {
-		if (p != rq->migration_thread)
-			/*
-			 * The migration thread does the actual balancing. Do
-			 * not bias by its priority as the ultra high priority
-			 * will skew balancing adversely.
-			 */
-			inc_prio_bias(rq, p->prio);
-	} else
-		inc_prio_bias(rq, p->static_prio);
+	inc_prio_bias(rq, p);
 }
 
 static inline void dec_nr_running(task_t *p, runqueue_t *rq)
 {
 	rq->nr_running--;
-	if (rt_task(p)) {
-		if (p != rq->migration_thread)
-			dec_prio_bias(rq, p->prio);
-	} else
-		dec_prio_bias(rq, p->static_prio);
+	dec_prio_bias(rq, p);
+}
+
+/* convert biased priority to scaled weighted load */
+static inline unsigned long weighted_load(unsigned long bias)
+{
+	return (bias * SCHED_LOAD_SCALE) / NICE_TO_BIAS_PRIO(0);
+}
+
+/* convert scaled weighted load to unscaled biased load */
+static inline unsigned long biased_load(unsigned long wload)
+{
+	return (wload * NICE_TO_BIAS_PRIO(0)) / SCHED_LOAD_SCALE;
 }
 #else
-static inline void inc_prio_bias(runqueue_t *rq, int prio)
+static inline void set_bias_prio(task_t *p)
 {
 }
 
-static inline void dec_prio_bias(runqueue_t *rq, int prio)
+static inline void inc_prio_bias(runqueue_t *rq, const task_t *p)
+{
+}
+
+static inline void dec_prio_bias(runqueue_t *rq, const task_t *p)
 {
 }
 
@@ -1002,66 +1036,36 @@ void kick_process(task_t *p)
 }
 
 /*
- * Return a low guess at the load of a migration-source cpu.
+ * Return a low guess at the load of a migration-source cpu weighted
+ * according to the scheduling class and "nice" value.
  *
  * We want to under-estimate the load of migration sources, to
  * balance conservatively.
  */
-static unsigned long __source_load(int cpu, int type, enum idle_type idle)
+static unsigned long source_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long running = rq->nr_running;
-	unsigned long source_load, cpu_load = rq->cpu_load[type-1],
-		load_now = running * SCHED_LOAD_SCALE;
+	unsigned long load_now = weighted_load(rq->prio_bias);
 
 	if (type == 0)
-		source_load = load_now;
-	else
-		source_load = min(cpu_load, load_now);
+		return load_now;
 
-	if (running > 1 || (idle == NOT_IDLE && running))
-		/*
-		 * If we are busy rebalancing the load is biased by
-		 * priority to create 'nice' support across cpus. When
-		 * idle rebalancing we should only bias the source_load if
-		 * there is more than one task running on that queue to
-		 * prevent idle rebalance from trying to pull tasks from a
-		 * queue with only one running task.
-		 */
-		source_load = source_load * rq->prio_bias / running;
-
-	return source_load;
-}
-
-static inline unsigned long source_load(int cpu, int type)
-{
-	return __source_load(cpu, type, NOT_IDLE);
+	return min(rq->cpu_load[type-1], load_now);
 }
 
 /*
- * Return a high guess at the load of a migration-target cpu
+ * Return a high guess at the load of a migration-target cpu weighted
+ * according to the scheduling class and "nice" value.
  */
-static inline unsigned long __target_load(int cpu, int type, enum idle_type idle)
+static inline unsigned long target_load(int cpu, int type)
 {
 	runqueue_t *rq = cpu_rq(cpu);
-	unsigned long running = rq->nr_running;
-	unsigned long target_load, cpu_load = rq->cpu_load[type-1],
-		load_now = running * SCHED_LOAD_SCALE;
+	unsigned long load_now = weighted_load(rq->prio_bias);
 
 	if (type == 0)
-		target_load = load_now;
-	else
-		target_load = max(cpu_load, load_now);
-
-	if (running > 1 || (idle == NOT_IDLE && running))
-		target_load = target_load * rq->prio_bias / running;
+		return load_now;
 
-	return target_load;
-}
-
-static inline unsigned long target_load(int cpu, int type)
-{
-	return __target_load(cpu, type, NOT_IDLE);
+	return max(rq->cpu_load[type-1], load_now);
 }
 
 /*
@@ -1322,7 +1326,7 @@ static int try_to_wake_up(task_t *p, uns
 			 * of the current CPU:
 			 */
 			if (sync)
-				tl -= SCHED_LOAD_SCALE;
+				tl -= weighted_load(p->bias_prio);
 
 			if ((tl <= load &&
 				tl + target_load(cpu, idx) <= SCHED_LOAD_SCALE) ||
@@ -1925,22 +1929,23 @@ int can_migrate_task(task_t *p, runqueue
 }
 
 /*
- * move_tasks tries to move up to max_nr_move tasks from busiest to this_rq,
- * as part of a balancing operation within "domain". Returns the number of
- * tasks moved.
+ * move_tasks tries to move up to max_nr_move tasks and max_bias_move biased
+ * load from busiest to this_rq, as part of a balancing operation within
+ * "domain". Returns the number of tasks moved.
  *
  * Called with both runqueues locked.
  */
 static int move_tasks(runqueue_t *this_rq, int this_cpu, runqueue_t *busiest,
-		      unsigned long max_nr_move, struct sched_domain *sd,
-		      enum idle_type idle, int *all_pinned)
+		      unsigned long max_nr_move, long max_bias_move,
+		      struct sched_domain *sd, enum idle_type idle,
+		      int *all_pinned)
 {
 	prio_array_t *array, *dst_array;
 	struct list_head *head, *curr;
 	int idx, pulled = 0, pinned = 0;
 	task_t *tmp;
 
-	if (max_nr_move == 0)
+	if (max_nr_move == 0 || max_bias_move == 0)
 		goto out;
 
 	pinned = 1;
@@ -1983,7 +1988,8 @@ skip_queue:
 
 	curr = curr->prev;
 
-	if (!can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
+	if (tmp->bias_prio > max_bias_move ||
+	    !can_migrate_task(tmp, busiest, this_cpu, sd, idle, &pinned)) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -1997,9 +2003,13 @@ skip_queue:
 
 	pull_task(busiest, array, tmp, this_rq, dst_array, this_cpu);
 	pulled++;
+	max_bias_move -= tmp->bias_prio;
 
-	/* We only want to steal up to the prescribed number of tasks. */
-	if (pulled < max_nr_move) {
+	/*
+	 * We only want to steal up to the prescribed number of tasks
+	 * and the prescribed amount of biased load.
+	 */
+	if (pulled < max_nr_move && max_bias_move > 0) {
 		if (curr != head)
 			goto skip_queue;
 		idx++;
@@ -2020,7 +2030,7 @@ out:
 
 /*
  * find_busiest_group finds and returns the busiest CPU group within the
- * domain. It calculates and returns the number of tasks which should be
+ * domain. It calculates and returns the amount of biased load which should be
  * moved to restore balance via the imbalance parameter.
  */
 static struct sched_group *
@@ -2056,9 +2066,9 @@ find_busiest_group(struct sched_domain *
 
 			/* Bias balancing toward cpus of our domain */
 			if (local_group)
-				load = __target_load(i, load_idx, idle);
+				load = target_load(i, load_idx);
 			else
-				load = __source_load(i, load_idx, idle);
+				load = source_load(i, load_idx);
 
 			avg_load += load;
 		}
@@ -2113,7 +2123,7 @@ find_busiest_group(struct sched_domain *
 		unsigned long tmp;
 
 		if (max_load - this_load >= SCHED_LOAD_SCALE*2) {
-			*imbalance = 1;
+			*imbalance = NICE_TO_BIAS_PRIO(0);
 			return busiest;
 		}
 
@@ -2146,12 +2156,15 @@ find_busiest_group(struct sched_domain *
 		if (pwr_move <= pwr_now)
 			goto out_balanced;
 
-		*imbalance = 1;
+		*imbalance = NICE_TO_BIAS_PRIO(0);
 		return busiest;
 	}
 
-	/* Get rid of the scaling factor, rounding down as we divide */
-	*imbalance = *imbalance / SCHED_LOAD_SCALE;
+	/*
+	 * Get rid of the scaling factor, rounding down as we divide and
+	 * converting to biased load for use by move_tasks()
+	 */
+	*imbalance = biased_load(*imbalance);
 	return busiest;
 
 out_balanced:
@@ -2163,15 +2176,14 @@ out_balanced:
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
-static runqueue_t *find_busiest_queue(struct sched_group *group,
-	enum idle_type idle)
+static runqueue_t *find_busiest_queue(struct sched_group *group)
 {
 	unsigned long load, max_load = 0;
 	runqueue_t *busiest = NULL;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
-		load = __source_load(i, 0, idle);
+		load = source_load(i, 0);
 
 		if (load > max_load) {
 			max_load = load;
@@ -2188,6 +2200,7 @@ static runqueue_t *find_busiest_queue(st
  */
 #define MAX_PINNED_INTERVAL	512
 
+#define minus_1_or_zero(n) ((n) > 0 ? (n) - 1 : 0)
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
@@ -2215,7 +2228,7 @@ static int load_balance(int this_cpu, ru
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, idle);
+	busiest = find_busiest_queue(group);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2235,6 +2248,7 @@ static int load_balance(int this_cpu, ru
 		 */
 		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, idle, &all_pinned);
 		double_rq_unlock(this_rq, busiest);
 
@@ -2338,7 +2352,7 @@ static int load_balance_newidle(int this
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, NEWLY_IDLE);
+	busiest = find_busiest_queue(group);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2353,6 +2367,7 @@ static int load_balance_newidle(int this
 		/* Attempt to move tasks */
 		double_lock_balance(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
 	}
@@ -2433,7 +2448,8 @@ static void active_load_balance(runqueue
 
 	schedstat_inc(sd, alb_cnt);
 
-	if (move_tasks(target_rq, target_cpu, busiest_rq, 1, sd, SCHED_IDLE, NULL))
+	if (move_tasks(target_rq, target_cpu, busiest_rq, 1,
+			RTPRIO_TO_BIAS_PRIO(100), sd, SCHED_IDLE, NULL))
 		schedstat_inc(sd, alb_pushed);
 	else
 		schedstat_inc(sd, alb_failed);
@@ -2461,7 +2477,8 @@ static void rebalance_tick(int this_cpu,
 	struct sched_domain *sd;
 	int i;
 
-	this_load = this_rq->nr_running * SCHED_LOAD_SCALE;
+	/* weight load according to scheduling class and "nice" value */
+	this_load = weighted_load(this_rq->prio_bias);
 	/* Update our load */
 	for (i = 0; i < 3; i++) {
 		unsigned long new_load = this_load;
@@ -3573,18 +3590,19 @@ void set_user_nice(task_t *p, long nice)
 	array = p->array;
 	if (array) {
 		dequeue_task(p, array);
-		dec_prio_bias(rq, p->static_prio);
+		dec_prio_bias(rq, p);
 	}
 
 	old_prio = p->prio;
 	new_prio = NICE_TO_PRIO(nice);
 	delta = new_prio - old_prio;
 	p->static_prio = NICE_TO_PRIO(nice);
+	set_bias_prio(p);
 	p->prio += delta;
 
 	if (array) {
 		enqueue_task(p, array);
-		inc_prio_bias(rq, p->static_prio);
+		inc_prio_bias(rq, p);
 		/*
 		 * If the task increased its priority or is running and
 		 * lowered its priority, then reschedule its CPU:
@@ -3720,6 +3738,7 @@ static void __setscheduler(struct task_s
 		if (policy == SCHED_BATCH)
 			p->sleep_avg = 0;
 	}
+	set_bias_prio(p);
 }
 
 /**
@@ -6143,6 +6162,7 @@ void __init sched_init(void)
 		}
 	}
 
+	set_bias_prio(&init_task);
 	/*
 	 * The boot idle thread does lazy MMU switching as well:
 	 */
_

