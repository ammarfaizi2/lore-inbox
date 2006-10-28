Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751638AbWJ1CmR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751638AbWJ1CmR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 22:42:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751635AbWJ1CmQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 22:42:16 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:42442 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751624AbWJ1Cly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 22:41:54 -0400
Date: Fri, 27 Oct 2006 19:41:43 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061028024143.10809.72940.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
References: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 6/7] Use tasklet to call balancing
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Use tasklet to balance sched domains.

Call rebalance_tick (renamed to rebalance_domains) from a tasklet.

We calculate the earliest time for each layer of sched domains to be
rescanned (this is the rescan time for idle) and use the earliest
of those to schedule the tasklet again via a new field "next_balance"
added to struct rq.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-27 15:45:30.000000000 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-27 20:12:42.225666940 -0500
@@ -227,6 +227,7 @@ struct rq {
 	unsigned long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	struct task_struct *curr, *idle;
+	unsigned long next_balance;
 	struct mm_struct *prev_mm;
 	struct prio_array *active, *expired, arrays[2];
 	int best_expired_prio;
@@ -2841,16 +2842,18 @@ static void update_load(struct rq *this_
 }
 
 /*
- * rebalance_tick will get called every timer tick, on every CPU.
+ * rebalance_domains is triggered when needed via a tasklet from the
+ * scheduler tick.
  *
  * It checks each scheduling domain to see if it is due to be balanced,
  * and initiates a balancing operation if so.
  *
  * Balancing parameters are set up in arch_init_sched_domains.
  */
-static void
-rebalance_tick(int this_cpu, struct rq *this_rq)
+static void rebalance_domains(unsigned long dummy)
 {
+	int this_cpu = smp_processor_id();
+	struct rq *this_rq = cpu_rq(this_cpu);
 	unsigned long interval;
 	struct sched_domain *sd;
 	/*
@@ -2859,6 +2862,8 @@ rebalance_tick(int this_cpu, struct rq *
 	 */
 	enum idle_type idle = (this_rq->idle && !this_rq->nr_running) ?
 				SCHED_IDLE : NOT_IDLE;
+	/* Earliest time when we have to call rebalance_domains again */
+	unsigned long next_balance = jiffies + 60*HZ;
 
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -2884,8 +2889,13 @@ rebalance_tick(int this_cpu, struct rq *
 			}
 			sd->last_balance += interval;
 		}
+		next_balance = min(next_balance,
+				sd->last_balance + sd->balance_interval);
 	}
+	this_rq->next_balance = next_balance;
 }
+
+DECLARE_TASKLET(rebalance, &rebalance_domains, 0L);
 #else
 /*
  * on UP we do not need to balance between CPUs:
@@ -3137,7 +3147,8 @@ void scheduler_tick(void)
 		task_running_tick(rq, p);
 #ifdef CONFIG_SMP
 	update_load(rq);
-	rebalance_tick(cpu, rq);
+	if (jiffies >= rq->next_balance)
+		tasklet_schedule(&rebalance);
 #endif
 }
 
