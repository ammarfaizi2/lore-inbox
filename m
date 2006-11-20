Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030465AbWKTX3Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030465AbWKTX3Q (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 18:29:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030499AbWKTX3Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 18:29:16 -0500
Received: from mga05.intel.com ([192.55.52.89]:41910 "EHLO
	fmsmga101.fm.intel.com") by vger.kernel.org with ESMTP
	id S1030465AbWKTX3P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 18:29:15 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,440,1157353200"; 
   d="scan'208"; a="18106047:sNHT20624688"
Date: Mon, 20 Nov 2006 14:26:33 -0800
From: "Siddha, Suresh B" <suresh.b.siddha@intel.com>
To: mingo@elte.hu, nickpiggin@yahoo.com.au, clameter@sgi.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com
Subject: [patch] sched: decrease number of load balances
Message-ID: <20061120142633.A17305@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch goes on top of the Christoph's sched patches in -mm. Thanks.
---

Currently at a particular domain, each cpu in the sched group will
do a load balance at the frequency of balance_interval. More the cores and
threads, more the cpus will be in each sched group at SMP and NUMA domain. And
we endup spending quite a bit of time doing load balancing in those domains.

Fix this by making only one cpu(first idle cpu or first cpu in the
group if all the cpus are busy) in the sched group do the load balance at that
particular sched domain and this load will slowly percolate down to the other
cpus with in that group(when they do load balancing at lower domains).

Signed-off-by: Suresh Siddha <suresh.b.siddha@intel.com>
---

diff -pNru linux/include/linux/sched.h linux-mm/include/linux/sched.h
--- linux/include/linux/sched.h	2006-11-20 10:22:31.000000000 -0800
+++ linux-mm/include/linux/sched.h	2006-11-20 10:23:22.000000000 -0800
@@ -706,6 +706,7 @@ struct sched_domain {
 	unsigned long lb_hot_gained[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyg[MAX_IDLE_TYPES];
 	unsigned long lb_nobusyq[MAX_IDLE_TYPES];
+	unsigned long lb_stopbalance[MAX_IDLE_TYPES];
 
 	/* Active load balancing */
 	unsigned long alb_cnt;
diff -pNru linux/kernel/sched.c linux-mm/kernel/sched.c
--- linux/kernel/sched.c	2006-11-20 10:22:31.000000000 -0800
+++ linux-mm/kernel/sched.c	2006-11-20 14:21:56.000000000 -0800
@@ -428,7 +428,7 @@ static inline void task_rq_unlock(struct
  * bump this up when changing the output format or the meaning of an existing
  * format, so that tools can adapt (or abort)
  */
-#define SCHEDSTAT_VERSION 12
+#define SCHEDSTAT_VERSION 13
 
 static int show_schedstat(struct seq_file *seq, void *v)
 {
@@ -467,7 +467,7 @@ static int show_schedstat(struct seq_fil
 			for (itype = SCHED_IDLE; itype < MAX_IDLE_TYPES;
 					itype++) {
 				seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu"
-				    " %lu",
+				    " %lu %lu",
 				    sd->lb_cnt[itype],
 				    sd->lb_balanced[itype],
 				    sd->lb_failed[itype],
@@ -475,7 +475,8 @@ static int show_schedstat(struct seq_fil
 				    sd->lb_gained[itype],
 				    sd->lb_hot_gained[itype],
 				    sd->lb_nobusyq[itype],
-				    sd->lb_nobusyg[itype]);
+				    sd->lb_nobusyg[itype],
+				    sd->lb_stopbalance[itype]);
 			}
 			seq_printf(seq, " %lu %lu %lu %lu %lu %lu %lu %lu %lu"
 			    " %lu %lu %lu\n",
@@ -2248,7 +2249,7 @@ out:
 static struct sched_group *
 find_busiest_group(struct sched_domain *sd, int this_cpu,
 		   unsigned long *imbalance, enum idle_type idle, int *sd_idle,
-		   cpumask_t *cpus)
+		   cpumask_t *cpus, int *balance)
 {
 	struct sched_group *busiest = NULL, *this = NULL, *group = sd->groups;
 	unsigned long max_load, avg_load, total_load, this_load, total_pwr;
@@ -2277,10 +2278,14 @@ find_busiest_group(struct sched_domain *
 		unsigned long load, group_capacity;
 		int local_group;
 		int i;
+		unsigned int balance_cpu = -1, first_idle_cpu = 0;
 		unsigned long sum_nr_running, sum_weighted_load;
 
 		local_group = cpu_isset(this_cpu, group->cpumask);
 
+		if (local_group)
+			balance_cpu = first_cpu(group->cpumask);
+
 		/* Tally up the load of all CPUs in the group */
 		sum_weighted_load = sum_nr_running = avg_load = 0;
 
@@ -2296,9 +2301,14 @@ find_busiest_group(struct sched_domain *
 				*sd_idle = 0;
 
 			/* Bias balancing toward cpus of our domain */
-			if (local_group)
+			if (local_group) {
+				if (idle_cpu(i) && !first_idle_cpu) {
+					first_idle_cpu = 1;
+					balance_cpu = i;
+				}
+
 				load = target_load(i, load_idx);
-			else
+			} else
 				load = source_load(i, load_idx);
 
 			avg_load += load;
@@ -2306,6 +2316,16 @@ find_busiest_group(struct sched_domain *
 			sum_weighted_load += rq->raw_weighted_load;
 		}
 
+		/*
+		 * First idle cpu or the first cpu(busiest) in this sched group
+		 * is eligible for doing load balancing at this and above
+		 * domains.
+		 */
+		if (local_group && balance_cpu != this_cpu && balance) {
+			*balance = 0;
+			goto ret;
+		}
+
 		total_load += avg_load;
 		total_pwr += group->cpu_power;
 
@@ -2500,8 +2520,8 @@ out_balanced:
 		*imbalance = min_load_per_task;
 		return group_min;
 	}
-ret:
 #endif
+ret:
 	*imbalance = 0;
 	return NULL;
 }
@@ -2552,7 +2572,8 @@ static inline unsigned long minus_1_or_z
  * tasks if there is an imbalance.
  */
 static int load_balance(int this_cpu, struct rq *this_rq,
-			struct sched_domain *sd, enum idle_type idle)
+			struct sched_domain *sd, enum idle_type idle,
+			int *balance)
 {
 	int nr_moved, all_pinned = 0, active_balance = 0, sd_idle = 0;
 	struct sched_group *group;
@@ -2575,7 +2596,13 @@ static int load_balance(int this_cpu, st
 
 redo:
 	group = find_busiest_group(sd, this_cpu, &imbalance, idle, &sd_idle,
-							&cpus);
+				   &cpus, balance);
+
+	if (*balance == 0) {
+		schedstat_inc(sd, lb_stopbalance[idle]);
+		goto out_balanced;
+	}
+		
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[idle]);
 		goto out_balanced;
@@ -2717,7 +2744,7 @@ load_balance_newidle(int this_cpu, struc
 	schedstat_inc(sd, lb_cnt[NEWLY_IDLE]);
 redo:
 	group = find_busiest_group(sd, this_cpu, &imbalance, NEWLY_IDLE,
-				&sd_idle, &cpus);
+				   &sd_idle, &cpus, NULL);
 	if (!group) {
 		schedstat_inc(sd, lb_nobusyg[NEWLY_IDLE]);
 		goto out_balanced;
@@ -2887,7 +2914,7 @@ static spinlock_t balancing;
 
 static void run_rebalance_domains(struct softirq_action *h)
 {
-	int this_cpu = smp_processor_id();
+	int this_cpu = smp_processor_id(), balance = 1;
 	struct rq *this_rq = cpu_rq(this_cpu);
 	unsigned long interval;
 	struct sched_domain *sd;
@@ -2919,7 +2946,7 @@ static void run_rebalance_domains(struct
 		}
 
 		if (time_after_eq(jiffies, sd->last_balance + interval)) {
-			if (load_balance(this_cpu, this_rq, sd, idle)) {
+			if (load_balance(this_cpu, this_rq, sd, idle, &balance)) {
 				/*
 				 * We've pulled tasks over so either we're no
 				 * longer idle, or one of our SMT siblings is
@@ -2934,6 +2961,14 @@ static void run_rebalance_domains(struct
 out:
 		if (time_after(next_balance, sd->last_balance + interval))
 			next_balance = sd->last_balance + interval;
+
+		/*
+		 * Stop the load balance at this level. There is another
+		 * CPU in our sched group which is doing load balancing more
+		 * actively.
+		 */
+		if (!balance)
+			break;
 	}
 	this_rq->next_balance = next_balance;
 }
