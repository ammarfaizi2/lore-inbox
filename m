Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161148AbWJXSbX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161148AbWJXSbX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Oct 2006 14:31:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161153AbWJXSbX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Oct 2006 14:31:23 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:8842 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1161148AbWJXSbW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Oct 2006 14:31:22 -0400
Date: Tue, 24 Oct 2006 11:31:09 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       Dave Chinner <dgc@sgi.com>, Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Message-Id: <20061024183109.4530.3647.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
References: <20061024183104.4530.29183.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 1/5] Disable interrupts for locking in load_balance()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scheduler: Disable interrupts for locking in load_balance()

Interrupts must be disabled for request queue locks if we want
to run load_balance() with interrupts enabled.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc2-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc2-mm2.orig/kernel/sched.c	2006-10-23 19:35:19.615025838 -0500
+++ linux-2.6.19-rc2-mm2/kernel/sched.c	2006-10-23 19:36:26.208865512 -0500
@@ -2530,8 +2530,6 @@ static inline unsigned long minus_1_or_z
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
- *
- * Called with this_rq unlocked.
  */
 static int load_balance(int this_cpu, struct rq *this_rq,
 			struct sched_domain *sd, enum idle_type idle)
@@ -2541,6 +2539,7 @@ static int load_balance(int this_cpu, st
 	unsigned long imbalance;
 	struct rq *busiest;
 	cpumask_t cpus = CPU_MASK_ALL;
+	unsigned long flags;
 
 	/*
 	 * When power savings policy is enabled for the parent domain, idle
@@ -2580,11 +2579,13 @@ redo:
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
@@ -2601,13 +2602,13 @@ redo:
 
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
@@ -2617,7 +2618,7 @@ redo:
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			spin_unlock(&busiest->lock);
+			spin_unlock_irqrestore(&busiest->lock, flags);
 			if (active_balance)
 				wake_up_process(busiest->migration_thread);
 
