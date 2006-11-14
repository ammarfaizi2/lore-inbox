Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966336AbWKNUdq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966336AbWKNUdq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966340AbWKNUdp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:33:45 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:64673 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S966336AbWKNUdi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:33:38 -0500
Date: Tue, 14 Nov 2006 12:33:27 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061114203327.12761.54376.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 6/8] Use softirq for load balancing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use softirq to balance sched domains.

Call rebalance_tick (renamed to run_rebalance_domains) from a newly introduced
softirq.

We calculate the earliest time for each layer of sched domains to be
rescanned (this is the rescan time for idle) and use the earliest
of those to schedule the softirq via a new field "next_balance"
added to struct rq.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-14 14:02:13.045549034 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-14 14:02:54.254194569 -0600
@@ -228,6 +228,7 @@ struct rq {
 	unsigned long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	struct task_struct *curr, *idle;
+	unsigned long next_balance;
 	struct mm_struct *prev_mm;
 	struct prio_array *active, *expired, arrays[2];
 	int best_expired_prio;
@@ -2861,7 +2862,7 @@ static void update_load(struct rq *this_
 }
 
 /*
- * rebalance_tick will get called every timer tick, on every CPU.
+ * run_rebalance_domains is triggered when needed from the scheduler tick.
  *
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
@@ -2869,9 +2870,10 @@ static void update_load(struct rq *this_
  * Balancing parameters are set up in arch_init_sched_domains.
  */
 
-static void
-rebalance_tick(int this_cpu, struct rq *this_rq)
+static void run_rebalance_domains(struct softirq_action *h)
 {
+	int this_cpu = smp_processor_id();
+	struct rq *this_rq = cpu_rq(this_cpu);
 	unsigned long interval;
 	struct sched_domain *sd;
 	/*
@@ -2880,6 +2882,8 @@ rebalance_tick(int this_cpu, struct rq *
 	 */
 	enum idle_type idle = !this_rq->nr_running ?
 				SCHED_IDLE : NOT_IDLE;
+	/* Earliest time when we have to call run_rebalance_domains again */
+	unsigned long next_balance = jiffies + 60*HZ;
 
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -2894,7 +2898,7 @@ rebalance_tick(int this_cpu, struct rq *
 		if (unlikely(!interval))
 			interval = 1;
 
-		if (jiffies - sd->last_balance >= interval) {
+		if (time_after_eq(jiffies, sd->last_balance + interval)) {
 			if (load_balance(this_cpu, this_rq, sd, idle)) {
 				/*
 				 * We've pulled tasks over so either we're no
@@ -2905,7 +2909,10 @@ rebalance_tick(int this_cpu, struct rq *
 			}
 			sd->last_balance += interval;
 		}
+		if (time_after(next_balance, sd->last_balance + interval))
+			next_balance = sd->last_balance + interval;
 	}
+	this_rq->next_balance = next_balance;
 }
 #else
 /*
@@ -3158,7 +3165,8 @@ void scheduler_tick(void)
 		task_running_tick(rq, p);
 #ifdef CONFIG_SMP
 	update_load(rq);
-	rebalance_tick(cpu, rq);
+	if (time_after_eq(jiffies, rq->next_balance))
+		raise_softirq(SCHED_SOFTIRQ);
 #endif
 }
 
@@ -6959,6 +6966,10 @@ void __init sched_init(void)
 
 	set_load_weight(&init_task);
 
+#ifdef CONFIG_SMP
+	open_softirq(SCHED_SOFTIRQ, run_rebalance_domains, NULL);
+#endif
+
 #ifdef CONFIG_RT_MUTEXES
 	plist_head_init(&init_task.pi_waiters, &init_task.pi_lock);
 #endif
Index: linux-2.6.19-rc5-mm1/include/linux/interrupt.h
===================================================================
--- linux-2.6.19-rc5-mm1.orig/include/linux/interrupt.h	2006-11-14 14:02:13.059221756 -0600
+++ linux-2.6.19-rc5-mm1/include/linux/interrupt.h	2006-11-14 14:02:15.109153475 -0600
@@ -237,6 +237,7 @@ enum
 	NET_RX_SOFTIRQ,
 	BLOCK_SOFTIRQ,
 	TASKLET_SOFTIRQ,
+	SCHED_SOFTIRQ,
 #ifdef CONFIG_HIGH_RES_TIMERS
 	HRTIMER_SOFTIRQ,
 #endif
