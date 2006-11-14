Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966338AbWKNUe4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966338AbWKNUe4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Nov 2006 15:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966337AbWKNUdt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Nov 2006 15:33:49 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58037 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S966332AbWKNUdY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Nov 2006 15:33:24 -0500
Date: Tue, 14 Nov 2006 12:33:11 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061114203311.12761.24057.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
References: <20061114203256.12761.33911.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 3/8] Disable interrupts for locking in load_balance()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scheduler: Disable interrupts for locking in load_balance()

Interrupts must be disabled for request queue locks if we want
to run load_balance() with interrupts enabled.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc5-mm1/kernel/sched.c
===================================================================
--- linux-2.6.19-rc5-mm1.orig/kernel/sched.c	2006-11-10 22:48:09.002647332 -0600
+++ linux-2.6.19-rc5-mm1/kernel/sched.c	2006-11-10 22:48:31.784869982 -0600
@@ -2549,8 +2549,6 @@ static inline unsigned long minus_1_or_z
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
- *
- * Called with this_rq unlocked.
  */
 static int load_balance(int this_cpu, struct rq *this_rq,
 			struct sched_domain *sd, enum idle_type idle)
@@ -2560,6 +2558,7 @@ static int load_balance(int this_cpu, st
 	unsigned long imbalance;
 	struct rq *busiest;
 	cpumask_t cpus = CPU_MASK_ALL;
+	unsigned long flags;
 
 	/*
 	 * When power savings policy is enabled for the parent domain, idle
@@ -2599,11 +2598,13 @@ redo:
 		 * still unbalanced. nr_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
+		local_irq_save(flags);
 		double_rq_lock(this_rq, busiest);
 		nr_moved = move_tasks(this_rq, this_cpu, busiest,
 				      minus_1_or_zero(busiest->nr_running),
 				      imbalance, sd, idle, &all_pinned);
 		double_rq_unlock(this_rq, busiest);
+		local_irq_restore(flags);
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
 		if (unlikely(all_pinned)) {
@@ -2620,13 +2621,13 @@ redo:
 
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
 
-			spin_lock(&busiest->lock);
+			spin_lock_irqsave(&busiest->lock, flags);
 
 			/* don't kick the migration_thread, if the curr
 			 * task on busiest cpu can't be moved to this_cpu
 			 */
 			if (!cpu_isset(this_cpu, busiest->curr->cpus_allowed)) {
-				spin_unlock(&busiest->lock);
+				spin_unlock_irqrestore(&busiest->lock, flags);
 				all_pinned = 1;
 				goto out_one_pinned;
 			}
@@ -2636,7 +2637,7 @@ redo:
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			spin_unlock(&busiest->lock);
+			spin_unlock_irqrestore(&busiest->lock, flags);
 			if (active_balance)
 				wake_up_process(busiest->migration_thread);
 
