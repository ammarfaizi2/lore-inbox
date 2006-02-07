Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932437AbWBGB1k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932437AbWBGB1k (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 20:27:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932393AbWBGB1k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 20:27:40 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:59840 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S932437AbWBGB1j (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 20:27:39 -0500
From: hawkes@sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>,
       Suresh Siddha <suresh.b.siddha@intel.com>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>
Cc: Jack Steiner <steiner@sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org
Date: Mon, 06 Feb 2006 17:27:29 -0800
Message-Id: <20060207012729.8707.66350.sendpatchset@tomahawk.engr.sgi.com>
Subject: Re: [PATCH] load_balance: "busiest CPU" -> "busier CPUs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Second try, incorporating Suresh Siddha's suggestion to avoid adding
a field to the runqueue struct.

The load_balance algorithm determines a single "busiest CPU" and seeks
to pull tasks from it.  If no migrateable tasks are found, then
load_balance simply gives up.  This algorithm is vulnerable to
workloads where the busiest CPU is filled with non-migratable tasks,
which is commonly the case when a job manager carves up the CPUs into
cpusets and runs different multitasking applications in each cpuset.
In these circumstances, an all-pinned "busiest CPU" will effectively
disable load_balance balancing.

This patch changes the load_balance search into a "busier CPUs"
algorithm.  The find_busiest_group() and find_busiest_queue() are
iteratively called with a constraining cpumask; if the busiest CPU
yields no migrateable task, then that CPU is dropped from the
constraining cpumask and the search repeats until no busier group or
CPU exists.

This constraining cpumask is passed by-reference for performance
reasons, and no cpus_add() is used because that operation has a
higher overhead than using the more simple cpu_isset().

This patch is simple and effective.  A possible enhancement is to
cap the number of iterations, in order to limit exposure to a
denial-of-service attack where a user floods numerous CPUs with
thousands of pinned tasks, thereby slowing down every load_balance
search.  (However, the current "busiest CPU" algorithm is also
vulnerable to a user who pins many thousands of tasks to a single CPU
and slows down load_balance, as well as effectively disabling systemwide
load_balance.)

Signed-off-by: John Hawkes <hawkes@sgi.com>

Index: linux/kernel/sched.c
===================================================================
--- linux.orig/kernel/sched.c	2006-02-06 17:19:15.000000000 -0800
+++ linux/kernel/sched.c	2006-02-06 17:21:09.000000000 -0800
@@ -425,7 +425,7 @@ static int show_schedstat(struct seq_fil
 			seq_printf(seq, "domain%d %s", dcnt++, mask_str);
 			for (itype = SCHED_IDLE; itype < MAX_IDLE_TYPES;
 					itype++) {
-				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu",
+				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu",
 				    sd->lb_cnt[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
@@ -433,7 +433,8 @@ static int show_schedstat(struct seq_fil
 				    sd->lb_gained[itype],
 				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype]);
+				    sd->lb_nobusyg[itype],
+				    sd->lb_retries[itype]);
 			}
 			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
 			    sd->alb_cnt, sd->alb_failed, sd->alb_pushed,
@@ -2025,7 +2026,8 @@ out:
  */
 static struct sched_group *
 find_busiest_group(struct sched_domain *sd, int this_cpu,
-		   unsigned long *imbalance, enum idle_type idle, int *sd_idle)
+		   unsigned long *imbalance, enum idle_type idle, int *sd_idle,
+		   cpumask_t *consider_cpus)
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
@@ -2051,6 +2053,9 @@ find_busiest_group(struct sched_domain *
 		avg_load = 0;
 
 		for_each_cpu_mask(i, group->cpumask) {
+			if (!cpu_isset(i, *consider_cpus))
+				continue;
+
 			if (*sd_idle && !idle_cpu(i))
 				*sd_idle = 0;
 
@@ -2163,19 +2168,22 @@ out_balanced:
 /*
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
-static runqueue_t *find_busiest_queue(struct sched_group *group,
-	enum idle_type idle)
+static int find_busiest_queue(struct sched_group *group, enum idle_type idle,
+			      cpumask_t *consider_cpus)
 {
 	unsigned long load, max_load = 0;
-	runqueue_t *busiest = NULL;
+	int busiest = -1;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
+		if (!cpu_isset(i, *consider_cpus))
+			continue;
+
 		load = __source_load(i, 0, idle);
 
 		if (load > max_load) {
 			max_load = load;
-			busiest = cpu_rq(i);
+			busiest = i;
 		}
 	}
 
@@ -2198,49 +2206,60 @@ static int load_balance(int this_cpu, ru
 			struct sched_domain *sd, enum idle_type idle)
 {
 	struct sched_group *group;
-	runqueue_t *busiest;
+	runqueue_t *busiest_rq;
+	int busiest_cpu;
 	unsigned long imbalance;
 	int nr_moved, all_pinned = 0;
 	int active_balance = 0;
 	int sd_idle = 0;
+	cpumask_t consider_cpus = CPU_MASK_ALL;
 
 	if (idle != NOT_IDLE && sd->flags & SD_SHARE_CPUPOWER)
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[idle]);
 
-	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle);
+try_again:
+	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle,
+				   &consider_cpus);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[idle]);
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, idle);
-	if (!busiest) {
+	busiest_cpu = find_busiest_queue(group, idle, &consider_cpus);
+	if (busiest_cpu < 0) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
-	}
+	} else
+		busiest_rq = cpu_rq(busiest_cpu);
 
-	BUG_ON(busiest == this_rq);
+	BUG_ON(busiest_rq == this_rq);
 
 	schedstat_add(sd, lb_imbalance[idle], imbalance);
 
 	nr_moved = 0;
-	if (busiest->nr_running > 1) {
+	if (busiest_rq->nr_running > 1) {
 		/*
 		 * Attempt to move tasks. If find_busiest_group has found
-		 * an imbalance but busiest->nr_running <= 1, the group is
+		 * an imbalance but busiest_rq->nr_running <= 1, the group is
 		 * still unbalanced. nr_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		double_rq_lock(this_rq, busiest);
-		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+		double_rq_lock(this_rq, busiest_rq);
+		nr_moved = move_tasks(this_rq, this_cpu, busiest_rq,
 					imbalance, sd, idle, &all_pinned);
-		double_rq_unlock(this_rq, busiest);
+		double_rq_unlock(this_rq, busiest_rq);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
-		if (unlikely(all_pinned))
-			goto out_balanced;
+		if (unlikely(all_pinned)) {
+			cpu_clear(busiest_cpu, consider_cpus);
+			if (!cpus_empty(consider_cpus)) {
+				schedstat_inc(sd, lb_retries[idle]);
+				goto try_again;
+			} else
+				goto out_balanced;
+		}
 	}
 
 	if (!nr_moved) {
@@ -2249,25 +2268,25 @@ static int load_balance(int this_cpu, ru
 
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
 
-			spin_lock(&busiest->lock);
+			spin_lock(&busiest_rq->lock);
 
 			/* don't kick the migration_thread, if the curr
 			 * task on busiest cpu can't be moved to this_cpu
 			 */
-			if (!cpu_isset(this_cpu, busiest->curr->cpus_allowed)) {
-				spin_unlock(&busiest->lock);
+			if (!cpu_isset(this_cpu, busiest_rq->curr->cpus_allowed)) {
+				spin_unlock(&busiest_rq->lock);
 				all_pinned = 1;
 				goto out_one_pinned;
 			}
 
-			if (!busiest->active_balance) {
-				busiest->active_balance = 1;
-				busiest->push_cpu = this_cpu;
+			if (!busiest_rq->active_balance) {
+				busiest_rq->active_balance = 1;
+				busiest_rq->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			spin_unlock(&busiest->lock);
+			spin_unlock(&busiest_rq->lock);
 			if (active_balance)
-				wake_up_process(busiest->migration_thread);
+				wake_up_process(busiest_rq->migration_thread);
 
 			/*
 			 * We've kicked active balancing, reset the failure
@@ -2323,38 +2342,51 @@ static int load_balance_newidle(int this
 				struct sched_domain *sd)
 {
 	struct sched_group *group;
-	runqueue_t *busiest = NULL;
+	runqueue_t *busiest_rq = NULL;
+	int busiest_cpu;
 	unsigned long imbalance;
 	int nr_moved = 0;
 	int sd_idle = 0;
+	cpumask_t consider_cpus = CPU_MASK_ALL;
 
 	if (sd->flags & SD_SHARE_CPUPOWER)
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
-	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE, &sd_idle);
+try_again:
+	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE,
+				   &sd_idle, &consider_cpus);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, NEWLY_IDLE);
-	if (!busiest) {
+	busiest_cpu = find_busiest_queue(group, NEWLY_IDLE, &consider_cpus);
+	if (busiest_cpu < 0) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
-	}
+	} else
+		busiest_rq = cpu_rq(busiest_cpu);
 
-	BUG_ON(busiest == this_rq);
+	BUG_ON(busiest_rq == this_rq);
 
 	schedstat_add(sd, lb_imbalance[NEWLY_IDLE], imbalance);
 
 	nr_moved = 0;
-	if (busiest->nr_running > 1) {
+	if (busiest_rq->nr_running > 1) {
 		/* Attempt to move tasks */
-		double_lock_balance(this_rq, busiest);
-		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+		double_lock_balance(this_rq, busiest_rq);
+		nr_moved = move_tasks(this_rq, this_cpu, busiest_rq,
 					imbalance, sd, NEWLY_IDLE, NULL);
-		spin_unlock(&busiest->lock);
+		spin_unlock(&busiest_rq->lock);
+
+		if (!nr_moved) {
+			cpu_clear(busiest_cpu, consider_cpus);
+			if (!cpus_empty(consider_cpus)) {
+				schedstat_inc(sd, lb_retries[NEWLY_IDLE]);
+				goto try_again;
+			}
+		}
 	}
 
 	if (!nr_moved) {
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-02-06 17:19:14.000000000 -0800
+++ linux/include/linux/sched.h	2006-02-06 17:21:09.000000000 -0800
@@ -607,6 +607,7 @@ struct sched_domain {
 	unsigned long lb_hot_gained[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyg[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyq[MAX_IDLE_TYPES];
+	unsigned long lb_retries[MAX_IDLE_TYPES];
 
 	/* Active load balancing */
 	unsigned long alb_cnt;
