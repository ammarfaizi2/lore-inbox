Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751643AbWJ1Cmp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751643AbWJ1Cmp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 22:42:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751256AbWJ1Cmh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 22:42:37 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:47050 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751632AbWJ1Cmd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 22:42:33 -0400
Date: Fri, 27 Oct 2006 19:41:23 -0700 (PDT)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Nick Piggin <nickpiggin@yahoo.com.au>,
       Christoph Lameter <clameter@sgi.com>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>,
       Ingo Molnar <mingo@elte.hu>,
       KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Message-Id: <20061028024123.10809.79441.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
References: <20061028024112.10809.15841.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/7] Disable interrupts for locking in load_balance()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scheduler: Disable interrupts for locking in load_balance()

Interrupts must be disabled for request queue locks if we want
to run load_balance() with interrupts enabled.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc3/kernel/sched.c
===================================================================
--- linux-2.6.19-rc3.orig/kernel/sched.c	2006-10-23 18:02:02.000000000 -0500
+++ linux-2.6.19-rc3/kernel/sched.c	2006-10-25 13:28:12.653874252 -0500
@@ -2529,8 +2529,6 @@ static inline unsigned long minus_1_or_z
 /*
  * Check this_cpu to ensure it is balanced within domain. Attempt to move
  * tasks if there is an imbalance.
- *
- * Called with this_rq unlocked.
  */
 static int load_balance(int this_cpu, struct rq *this_rq,
 			struct sched_domain *sd, enum idle_type idle)
@@ -2540,6 +2538,7 @@ static int load_balance(int this_cpu, st
 	unsigned long imbalance;
 	struct rq *busiest;
 	cpumask_t cpus = CPU_MASK_ALL;
+	unsigned long flags;
 
 	/*
 	 * When power savings policy is enabled for the parent domain, idle
@@ -2579,11 +2578,13 @@ redo:
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
@@ -2600,13 +2601,13 @@ redo:
 
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
@@ -2616,7 +2617,7 @@ redo:
 				busiest->push_cpu = this_cpu;
 				active_balance = 1;
 			}
-			spin_unlock(&busiest->lock);
+			spin_unlock_irqrestore(&busiest->lock, flags);
 			if (active_balance)
 				wake_up_process(busiest->migration_thread);
 
