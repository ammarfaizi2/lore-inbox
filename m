Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030263AbWILSiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030263AbWILSiW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 14:38:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030354AbWILSiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 14:38:21 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:36522 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1030263AbWILSiU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 14:38:20 -0400
Date: Tue, 12 Sep 2006 11:37:55 -0700 (PDT)
From: Christoph Lameter <christoph@sgi.com>
X-X-Sender: christoph@schroedinger.engr.sgi.com
To: akpm@osdl.org
cc: Nick Piggin <npiggin@suse.de>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       linux-kernel@vger.kernel.org, mingo@elte.hu
Subject: Re: [PATCH] Fix longstanding load balancing bug in the scheduler V2
In-Reply-To: <20060911083734.GA25953@wotan.suse.de>
Message-ID: <Pine.LNX.4.64.0609121135590.12100@schroedinger.engr.sgi.com>
References: <Pine.LNX.4.64.0609061634240.13322@schroedinger.engr.sgi.com>
 <20060908103529.A9121@unix-os.sc.intel.com>
 <Pine.LNX.4.64.0609081135590.23089@schroedinger.engr.sgi.com>
 <20060908130028.A9446@unix-os.sc.intel.com>
 <Pine.LNX.4.64.0609081316580.24016@schroedinger.engr.sgi.com>
 <20060908170352.C9446@unix-os.sc.intel.com>
 <Pine.LNX.4.64.0609082222330.25269@schroedinger.engr.sgi.com>
 <Pine.LNX.4.64.0609091252070.26746@schroedinger.engr.sgi.com>
 <20060911083734.GA25953@wotan.suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix longstanding load balancing bug in the scheduler V2.

AFAIK this is an important scheduler bug that needs to go 
into 2.6.18 and all stable release since the issue can stall the 
scheduler for good.


The scheduler will stop load balancing if the most busy processor
contains processes pinned via processor affinity.

The scheduler currently only does one search for busiest cpu. If it cannot
pull any tasks away from the busiest cpu because they were pinned then the
scheduler goes into a corner and sulks leaving the idle processors idle.

F.e. If you have processor 0 busy running four tasks pinned via
taskset, there are none on processor 1 and one just started two
processes on processor 2 then the scheduler will not move one of
the two processes away from processor 2.

This patch fixes that issue by forcing the scheduler to come out of
its corner and retrying the load balancing by considering other
processors for load balancing.

This patch was originally developed by John Hawkes and discussed
at http://marc.theaimsgroup.com/?l=linux-kernel&m=113901368523205&w=2.

I have removed extraneous material and gone back to equipping
struct rq with the cpu the queue is associated with since this
makes the patch much easier and it is likely that others in the
future will have the same difficulty of figuring out which
processor owns which runqueue.

The overhead added through these patches is a single word on the stack if
the kernel is configured to support 32 cpus or less (32 bit). For 32 bit
environments the maximum number of cpus that can be configued is 255 which
would result in the use of 32 bytes additional on the stack. On IA64 up to
1k cpus can be configured which will result in the use of 128 additional
bytes on the stack. The maximum additional cache footprint is one cacheline.
Typically memory use will be much less than a cacheline and the additional
cpumask will be placed on the stack in a cacheline that already contains
other local variable.

V1->V2:
- Add static inline to cpu_of() (Thanks, Suresh)
- Use CPU_MASK_ALL instead of cpu_online_map since sched domain only
  include active processors (Thanks, Nick).
- Add discussion of performance impact

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.18-rc6-mm1/kernel/sched.c
===================================================================
--- linux-2.6.18-rc6-mm1.orig/kernel/sched.c	2006-09-12 13:25:17.510076005 -0500
+++ linux-2.6.18-rc6-mm1/kernel/sched.c	2006-09-12 13:26:33.391524056 -0500
@@ -239,6 +239,7 @@
 	/* For active balancing */
 	int active_balance;
 	int push_cpu;
+	int cpu;		/* cpu of this runqueue */
 
 	struct task_struct *migration_thread;
 	struct list_head migration_queue;
@@ -268,6 +269,15 @@
 
 static DEFINE_PER_CPU(struct rq, runqueues);
 
+static inline int cpu_of(struct rq *rq)
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
+	cpumask_t cpus = CPU_MASK_ALL;
 
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
+	cpumask_t cpus = CPU_MASK_ALL;
 
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
