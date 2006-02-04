Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946141AbWBDAiR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946141AbWBDAiR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 19:38:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946142AbWBDAiR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 19:38:17 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:18657 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1946141AbWBDAiR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 19:38:17 -0500
From: hawkes@sgi.com
To: Nick Piggin <nickpiggin@yahoo.com.au>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>
Cc: Jack Steiner <steiner@sgi.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org
Date: Fri, 03 Feb 2006 16:38:07 -0800
Message-Id: <20060204003807.28210.77735.sendpatchset@tomahawk.engr.sgi.com>
Subject: [PATCH] load_balance: "busiest CPU" -> "busier CPUs"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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
--- linux.orig/kernel/sched.c	2006-01-30 13:57:32.000000000 -0800
+++ linux/kernel/sched.c	2006-02-01 11:17:01.000000000 -0800
@@ -243,6 +243,8 @@ struct runqueue {
 	int active_balance;
 	int push_cpu;
 
+	int cpuid;			/* of this runqueue */
+
 	task_t *migration_thread;
 	struct list_head migration_queue;
 #endif
@@ -425,7 +427,7 @@ static int show_schedstat(struct seq_fil
 			seq_printf(seq, "domain%d %s", dcnt++, mask_str);
 			for (itype = SCHED_IDLE; itype < MAX_IDLE_TYPES;
 					itype++) {
-				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu",
+				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu",
 				    sd->lb_cnt[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
@@ -433,7 +435,8 @@ static int show_schedstat(struct seq_fil
 				    sd->lb_gained[itype],
 				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype]);
+				    sd->lb_nobusyg[itype],
+				    sd->lb_retries[itype]);
 			}
 			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu %lu\n",
 			    sd->alb_cnt, sd->alb_failed, sd->alb_pushed,
@@ -2025,7 +2028,8 @@ out:
  */
 static struct sched_group *
 find_busiest_group(struct sched_domain *sd, int this_cpu,
-		   unsigned long *imbalance, enum idle_type idle, int *sd_idle)
+		   unsigned long *imbalance, enum idle_type idle, int *sd_idle,
+		   cpumask_t *consider_cpus)
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
@@ -2051,6 +2055,9 @@ find_busiest_group(struct sched_domain *
 		avg_load = 0;
 
 		for_each_cpu_mask(i, group->cpumask) {
+			if (!cpu_isset(i, *consider_cpus))
+				continue;
+
 			if (*sd_idle && !idle_cpu(i))
 				*sd_idle = 0;
 
@@ -2164,13 +2171,16 @@ out_balanced:
  * find_busiest_queue - find the busiest runqueue among the cpus in group.
  */
 static runqueue_t *find_busiest_queue(struct sched_group *group,
-	enum idle_type idle)
+	enum idle_type idle, cpumask_t *consider_cpus)
 {
 	unsigned long load, max_load = 0;
 	runqueue_t *busiest = NULL;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
+		if (!cpu_isset(i, *consider_cpus))
+			continue;
+
 		load = __source_load(i, 0, idle);
 
 		if (load > max_load) {
@@ -2203,19 +2213,22 @@ static int load_balance(int this_cpu, ru
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
+	busiest = find_busiest_queue(group, idle, &consider_cpus);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2239,8 +2252,14 @@ static int load_balance(int this_cpu, ru
 		double_rq_unlock(this_rq, busiest);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
-		if (unlikely(all_pinned))
-			goto out_balanced;
+		if (unlikely(all_pinned)) {
+			cpu_clear(busiest->cpuid, consider_cpus);
+			if (!cpus_empty(consider_cpus)) {
+				schedstat_inc(sd, lb_retries[idle]);
+				goto try_again;
+			} else
+				goto out_balanced;
+		}
 	}
 
 	if (!nr_moved) {
@@ -2327,18 +2346,21 @@ static int load_balance_newidle(int this
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
+	busiest = find_busiest_queue(group, NEWLY_IDLE, &consider_cpus);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2355,6 +2377,14 @@ static int load_balance_newidle(int this
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
+
+		if (!nr_moved) {
+			cpu_clear(busiest->cpuid, consider_cpus);
+			if (!cpus_empty(consider_cpus)) {
+				schedstat_inc(sd, lb_retries[NEWLY_IDLE]);
+				goto try_again;
+			}
+		}
 	}
 
 	if (!nr_moved) {
@@ -6121,6 +6151,7 @@ void __init sched_init(void)
 			rq->cpu_load[j] = 0;
 		rq->active_balance = 0;
 		rq->push_cpu = 0;
+		rq->cpuid = i;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
 #endif
Index: linux/include/linux/sched.h
===================================================================
--- linux.orig/include/linux/sched.h	2006-01-30 13:57:30.000000000 -0800
+++ linux/include/linux/sched.h	2006-01-30 16:54:05.000000000 -0800
@@ -607,6 +607,7 @@ struct sched_domain {
 	unsigned long lb_hot_gained[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyg[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyq[MAX_IDLE_TYPES];
+	unsigned long lb_retries[MAX_IDLE_TYPES];
 
 	/* Active load balancing */
 	unsigned long alb_cnt;
