Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932106AbWKCUsg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932106AbWKCUsg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:48:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932128AbWKCUrT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:47:19 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:61621 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932122AbWKCUrK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:47:10 -0500
Date: Fri, 3 Nov 2006 12:47:07 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20061103204707.15739.70669.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
References: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
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

Index: linux-2.6.19-rc4-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sched.c	2006-11-03 12:54:30.683565162 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sched.c	2006-11-03 12:58:39.263918629 -0600
@@ -228,6 +228,7 @@ struct rq {
 	unsigned long expired_timestamp;
 	unsigned long long timestamp_last_tick;
 	struct task_struct *curr, *idle;
+	unsigned long next_balance;
 	struct mm_struct *prev_mm;
 	struct prio_array *active, *expired, arrays[2];
 	int best_expired_prio;
@@ -2842,16 +2843,18 @@ static void update_load(struct rq *this_
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
@@ -2860,6 +2863,8 @@ rebalance_tick(int this_cpu, struct rq *
 	 */
 	enum idle_type idle = !this_rq->nr_running ?
 				SCHED_IDLE : NOT_IDLE;
+	/* Earliest time when we have to call rebalance_domains again */
+	unsigned long next_balance = jiffies + 60*HZ;
 
 	for_each_domain(this_cpu, sd) {
 		if (!(sd->flags & SD_LOAD_BALANCE))
@@ -2885,8 +2890,13 @@ rebalance_tick(int this_cpu, struct rq *
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
@@ -3138,7 +3148,8 @@ void scheduler_tick(void)
 		task_running_tick(rq, p);
 #ifdef CONFIG_SMP
 	update_load(rq);
-	rebalance_tick(cpu, rq);
+	if (jiffies >= rq->next_balance)
+		tasklet_schedule(&rebalance);
 #endif
 }
 
