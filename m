Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbWKCUrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbWKCUrQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 15:47:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbWKCUrH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 15:47:07 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:58293 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1753528AbWKCUqt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 15:46:49 -0500
Date: Fri, 3 Nov 2006 12:46:46 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: akpm@osdl.org
Cc: Christoph Lameter <clameter@sgi.com>, linux-kernel@vger.kernel.org
Message-Id: <20061103204646.15739.24023.sendpatchset@schroedinger.engr.sgi.com>
In-Reply-To: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
References: <20061103204636.15739.74831.sendpatchset@schroedinger.engr.sgi.com>
Subject: [PATCH 2/7] Disable interrupts for locking in load_balance()
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

scheduler: Disable interrupts for locking in load_balance()

Interrupts must be disabled for request queue locks if we want
to run load_balance() with interrupts enabled.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc4-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sched.c	2006-11-03 12:51:15.281805162 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sched.c	2006-11-03 12:51:28.772236385 -0600
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
 
