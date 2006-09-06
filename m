Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030247AbWIFXit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030247AbWIFXit (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 19:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030251AbWIFXit
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 19:38:49 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29663 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1030247AbWIFXis (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 19:38:48 -0400
Date: Wed, 6 Sep 2006 16:38:33 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, npiggin@suse.de
Subject: [PATCH] Fix longstanding load balancing bug in the scheduler.
Message-ID: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The scheduler will stop load balancing if the most busy processor
contains processes pinned via processor affinity.

The scheduler currently only does one search for busiest cpu. If it cannot
pull any tasks away from the busiest cpu because they were pinned then the
scheduler goes into a corner and sulks leaving the idle processors idle.

F.e. If one has processor 0 busy running four tasks pinned via
taskset and there are none on processor 1. If one then starts 
two processes on processor 2 then the scheduler will not move one of
the two processes away from processor 2.

This patch fixes that issue by forcing the scheduler to come out of
its corner and retrying the load balancing by considering other
processors for load balancing. Instead of sulking the scheduler will 
simply shun the run queue with the pinned unmovable threads.

This patch was originally developed by John Hawkes and discussed
at http://marc.theaimsgroup.com/?l=linux-kernel&m=113901368523205&w=2.

I have removed extraneous material, simplified it and gone back to 
equipping struct rq with the cpu the queue is associated with since this 
makes the patch much easier and it is likely that others in the future 
will have the same difficulty of figuring out which processor owns which 
runqueue.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/kernel/sched.c	2006-09-06 16:13:40.000000000 -0700
+++ linux-2.6.18-rc5-mm1/kernel/sched.c	2006-09-06 16:13:41.000000000 -0700
@@ -239,6 +239,7 @@
 	/* For active balancing */
 	int active_balance;
 	int push_cpu;
+	int cpu;		/* cpu of this runqueue */
 
 	struct task_struct *migration_thread;
 	struct list_head migration_queue;
@@ -268,6 +269,15 @@
 
 static DEFINE_PER_CPU(struct rq, runqueues);
 
+int cpu_of(struct rq *rq)
+{
+#ifdef CONFIG_SMP
+	return rq->cpu;
+#else
+	return 0;
+#endif
+}
+
 /*
  * The domain tree (rq->sd) is protected by RCU's quiescent state transition.
  * See detach_destroy_domains: synchronize_sched for details.
@@ -2206,7 +2216,8 @@
  */
 static struct sched_group *
 find_busiest_group(struct sched_domain *sd, int this_cpu,
-		   unsigned long *imbalance, enum idle_type idle, int *sd_idle)
+		   unsigned long *imbalance, enum idle_type idle, int *sd_idle,
+		   cpumask_t *cpus)
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
@@ -2243,7 +2254,12 @@
 		sum_weighted_load = sum_nr_running = avg_load = 0;
 
 		for_each_cpu_mask(i, group->cpumask) {
-			struct rq *rq = cpu_rq(i);
+			struct rq *rq;
+
+			if (!cpu_isset(i, *cpus))
+				continue;
+
+			rq = cpu_rq(i);
 
 			if (*sd_idle && !idle_cpu(i))
 				*sd_idle = 0;
@@ -2461,13 +2477,17 @@
  */
 static struct rq *
 find_busiest_queue(struct sched_group *group, enum idle_type idle,
-		   unsigned long imbalance)
+		   unsigned long imbalance, cpumask_t *cpus)
 {
 	struct rq *busiest = NULL, *rq;
 	unsigned long max_load = 0;
 	int i;
 
 	for_each_cpu_mask(i, group->cpumask) {
+
+		if (!cpu_isset(i, *cpus))
+			continue;
+
 		rq = cpu_rq(i);
 
 		if (rq->nr_running == 1 && rq->raw_weighted_load > imbalance)
@@ -2506,6 +2526,7 @@
 	struct sched_group *group;
 	unsigned long imbalance;
 	struct rq *busiest;
+	cpumask_t cpus = cpu_online_map;
 
 	/*
 	 * When power savings policy is enabled for the parent domain, idle
@@ -2519,13 +2540,15 @@
 
 	schedstat_inc(sd, lb_cnt[idle]);
 
-	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle);
+redo:
+	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle,
+							&cpus);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[idle]);
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, idle, imbalance);
+	busiest = find_busiest_queue(group, idle, imbalance, &cpus);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[idle]);
 		goto out_balanced;
@@ -2550,8 +2573,12 @@
 		double_rq_unlock(this_rq, busiest);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
-		if (unlikely(all_pinned))
+		if (unlikely(all_pinned)) {
+			cpu_clear(cpu_of(busiest), cpus);
+			if (!cpus_empty(cpus))
+				goto redo;
 			goto out_balanced;
+		}
 	}
 
 	if (!nr_moved) {
@@ -2640,6 +2667,7 @@
 	unsigned long imbalance;
 	int nr_moved = 0;
 	int sd_idle = 0;
+	cpumask_t cpus = cpu_online_map;
 
 	/*
 	 * When power savings policy is enabled for the parent domain, idle
@@ -2652,13 +2680,16 @@
 		sd_idle = 1;
 
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
-	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE, &sd_idle);
+redo:
+	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE,
+				&sd_idle, &cpus);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out_balanced;
 	}
 
-	busiest = find_busiest_queue(group, NEWLY_IDLE, imbalance);
+	busiest = find_busiest_queue(group, NEWLY_IDLE, imbalance,
+				&cpus);
 	if (!busiest) {
 		schedstat_inc(sd, lb_nobusyq[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2676,6 +2707,12 @@
 					minus_1_or_zero(busiest->nr_running),
 					imbalance, sd, NEWLY_IDLE, NULL);
 		spin_unlock(&busiest->lock);
+
+		if (!nr_moved) {
+			cpu_clear(cpu_of(busiest), cpus);
+			if (!cpus_empty(cpus))
+				goto redo;
+		}
 	}
 
 	if (!nr_moved) {
@@ -6878,6 +6915,7 @@
 			rq->cpu_load[j] = 0;
 		rq->active_balance = 0;
 		rq->push_cpu = 0;
+		rq->cpu = i;
 		rq->migration_thread = NULL;
 		INIT_LIST_HEAD(&rq->migration_queue);
 #endif
