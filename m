Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752808AbWKBXfG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752808AbWKBXfG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Nov 2006 18:35:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752369AbWKBXfG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Nov 2006 18:35:06 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:40320 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1752811AbWKBXfF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Nov 2006 18:35:05 -0500
Date: Thu, 2 Nov 2006 15:34:44 -0800 (PST)
From: Christoph Lameter <clameter@sgi.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
cc: Peter Williams <pwil3058@bigpond.net.au>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>,
       "Siddha, Suresh B" <suresh.b.siddha@intel.com>
Subject: [RFC] Scheduler: Locking Optimization during load balance
Message-ID: <Pine.LNX.4.64.0611021531520.10688@schroedinger.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Optimize locking during load balancing.

Load balancing is run with interrupts disabled or in a tasklet (after applying
my patch for that). It is still a task that should be finished quickly.

Waiting for spinlocks can add significantly delays to load balancing. In
some cases we have seen a large number of processors load balancing at the
same time (likely to happen on a system with 1024 processoirs) and
attempt to move pages away from the same busiest processor. All are
serializing on the request lock of the busiest processor.

This patch avoids that kind of behavior by using a trylock instead
of a waiting lock. We abort the process migration attempt if we fail
to obtain the lock.

There are two components to this:

1. If we cannot obtain the lock for direct migration then we just
   give up.

2. Load balancing may then attempt to make the migration
   task do an active load balance on the node. In order to
   get that done  we have to take the lock for the busiest processor.
   We check first if active balancing is already setup
   for the busiest processor. If so then we can skip
   the lock.

Signed-off-by: Christoph Lameter <clameter@sgi.com>

Index: linux-2.6.19-rc4-mm2/kernel/sched.c
===================================================================
--- linux-2.6.19-rc4-mm2.orig/kernel/sched.c	2006-11-02 14:22:32.888917480 -0600
+++ linux-2.6.19-rc4-mm2/kernel/sched.c	2006-11-02 16:25:16.077846073 -0600
@@ -1933,6 +1933,24 @@ task_hot(struct task_struct *p, unsigned
 }
 
 /*
+ * double_rq_trylock - safely lock two runqueues
+ *
+ * Note this does not disable interrupts like task_rq_lock,
+ * you need to do so manually before calling.
+ */
+static int double_rq_trylock(struct rq *rq1, struct rq *rq2)
+	__acquires(rq1->lock)
+	__acquires(rq2->lock)
+{
+	if (spin_trylock(&rq1->lock)) {
+		if (rq1 == rq2 || spin_trylock(&rq2->lock))
+			return 1;
+		spin_unlock(&rq1->lock);
+	}
+	return 0;
+}
+
+/*
  * double_rq_lock - safely lock two runqueues
  *
  * Note this does not disable interrupts like task_rq_lock,
@@ -2580,11 +2598,12 @@ redo:
 		 * still unbalanced. nr_moved simply stays zero, so it is
 		 * correctly treated as an imbalance.
 		 */
-		double_rq_lock(this_rq, busiest);
-		nr_moved = move_tasks(this_rq, this_cpu, busiest,
+		if (double_rq_trylock(this_rq, busiest)) {
+			nr_moved = move_tasks(this_rq, this_cpu, busiest,
 				      minus_1_or_zero(busiest->nr_running),
 				      imbalance, sd, idle, &all_pinned);
-		double_rq_unlock(this_rq, busiest);
+			double_rq_unlock(this_rq, busiest);
+		}
 
 		/* All tasks on this runqueue were pinned by CPU affinity */
 		if (unlikely(all_pinned)) {
@@ -2601,23 +2620,28 @@ redo:
 
 		if (unlikely(sd->nr_balance_failed > sd->cache_nice_tries+2)) {
 
-			spin_lock(&busiest->lock);
+			if (!busiest->active_balance) {
+				spin_lock(&busiest->lock);
 
-			/* don't kick the migration_thread, if the curr
-			 * task on busiest cpu can't be moved to this_cpu
-			 */
-			if (!cpu_isset(this_cpu, busiest->curr->cpus_allowed)) {
-				spin_unlock(&busiest->lock);
-				all_pinned = 1;
-				goto out_one_pinned;
-			}
+				/*
+				 * Don't kick the migration_thread, if the
+				 * curr task on busiest cpu can't be moved
+				 * to this_cpu
+				 */
+				if (!cpu_isset(this_cpu,
+					    busiest->curr->cpus_allowed)) {
+					spin_unlock(&busiest->lock);
+					all_pinned = 1;
+					goto out_one_pinned;
+				}
 
-			if (!busiest->active_balance) {
-				busiest->active_balance = 1;
-				busiest->push_cpu = this_cpu;
-				active_balance = 1;
+				if (!busiest->active_balance) {
+					busiest->active_balance = 1;
+					busiest->push_cpu = this_cpu;
+					active_balance = 1;
+				}
+				spin_unlock(&busiest->lock);
 			}
-			spin_unlock(&busiest->lock);
 			if (active_balance)
 				wake_up_process(busiest->migration_thread);
 
