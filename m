Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264773AbUEYFf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264773AbUEYFf7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUEYFf6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:35:58 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:25474 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264773AbUEYFfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:35:46 -0400
Date: Tue, 25 May 2004 07:35:21 +0200
From: Manfred Spraul <manfred@dbl.q-ag.de>
Message-Id: <200405250535.i4P5ZLiR017599@dbl.q-ag.de>
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [RFC, PATCH] 2/5 rcu lock update: Use a sequence lock for starting batches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Step two for reducing cacheline trashing within rcupdate.c:

rcu_process_callbacks always acquires rcu_ctrlblk.state.mutex and
calls rcu_start_batch, even if the batch is already running or already
scheduled to run.
This can be avoided with a sequence lock: A sequence lock allows
to read the current batch number and next_pending atomically. If
next_pending is already set, then there is no need to acquire the
global mutex.

This means that for each grace period, there will be

- one write access to the rcu_ctrlblk.batch cacheline
- lots of read accesses to rcu_ctrlblk.batch (3-10*cpus_online(),
  perhaps even more).
  
  Behavior similar to the jiffies cacheline, shouldn't be a problem.
  
- cpus_online()+1 write accesses to rcu_ctrlblk.state, all of them
  starting with spin_lock(&rcu_ctrlblk.state.mutex).

  For large enough cpus_online() this will be a problem, but all
  except two of the spin_lock calls only protect the rcu_cpu_mask
  bitmap, thus a hierarchical bitmap would allow to split the write
  accesses to multiple cachelines.

Tested on an 8-way with reaim. Unfortunately it probably won't help
with Jack Steiner's 'ls' test since in this test only one cpu
generates rcu entries.

What do you think?

--
	Manfred

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm4
--- 2.6/kernel/rcupdate.c	2004-05-23 11:53:46.000000000 +0200
+++ build-2.6/kernel/rcupdate.c	2004-05-23 11:53:52.000000000 +0200
@@ -47,7 +47,7 @@
 
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
-	{ .batch = { .cur = -300, .completed = -300 },
+	{ .batch = { .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO },
 	  .state = {.mutex = SPIN_LOCK_UNLOCKED, .rcu_cpu_mask = CPU_MASK_NONE } };
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
@@ -124,16 +124,18 @@
 	cpumask_t active;
 
 	if (next_pending)
-		rcu_ctrlblk.state.next_pending = 1;
+		rcu_ctrlblk.batch.next_pending = 1;
 
-	if (rcu_ctrlblk.state.next_pending &&
+	if (rcu_ctrlblk.batch.next_pending &&
 			rcu_ctrlblk.batch.completed == rcu_ctrlblk.batch.cur) {
-		rcu_ctrlblk.state.next_pending = 0;
 		/* Can't change, since spin lock held. */
 		active = nohz_cpu_mask;
 		cpus_complement(active);
 		cpus_and(rcu_ctrlblk.state.rcu_cpu_mask, cpu_online_map, active);
+		write_seqcount_begin(&rcu_ctrlblk.batch.lock);
+		rcu_ctrlblk.batch.next_pending = 0;
 		rcu_ctrlblk.batch.cur++;
+		write_seqcount_end(&rcu_ctrlblk.batch.lock);
 	}
 }
 
@@ -261,6 +263,8 @@
 
 	local_irq_disable();
 	if (!list_empty(&RCU_nxtlist(cpu)) && list_empty(&RCU_curlist(cpu))) {
+		int next_pending, seq;
+
 		__list_splice(&RCU_nxtlist(cpu), &RCU_curlist(cpu));
 		INIT_LIST_HEAD(&RCU_nxtlist(cpu));
 		local_irq_enable();
@@ -268,10 +272,19 @@
 		/*
 		 * start the next batch of callbacks
 		 */
-		spin_lock(&rcu_ctrlblk.state.mutex);
-		RCU_batch(cpu) = rcu_ctrlblk.batch.cur + 1;
-		rcu_start_batch(1);
-		spin_unlock(&rcu_ctrlblk.state.mutex);
+		do {
+			seq = read_seqcount_begin(&rcu_ctrlblk.batch.lock);
+			/* determine batch number */
+			RCU_batch(cpu) = rcu_ctrlblk.batch.cur + 1;
+			next_pending = rcu_ctrlblk.batch.next_pending;
+		} while (read_seqcount_retry(&rcu_ctrlblk.batch.lock, seq));
+
+		if (!next_pending) {
+			/* and start it/schedule start if it's a new batch */
+			spin_lock(&rcu_ctrlblk.state.mutex);
+			rcu_start_batch(1);
+			spin_unlock(&rcu_ctrlblk.state.mutex);
+		}
 	} else {
 		local_irq_enable();
 	}
--- 2.6/include/linux/rcupdate.h	2004-05-23 11:53:46.000000000 +0200
+++ build-2.6/include/linux/rcupdate.h	2004-05-23 11:53:52.000000000 +0200
@@ -41,6 +41,7 @@
 #include <linux/threads.h>
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
+#include <linux/seqlock.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -69,11 +70,14 @@
 	struct {
 		long	cur;		/* Current batch number.	      */
 		long	completed;	/* Number of the last completed batch */
+		int	next_pending;	/* Is the next batch already waiting? */
+		seqcount_t lock;	/* for atomically reading cur and     */
+		                        /* next_pending. Spinlock not used,   */
+		                        /* protected by state.mutex           */
 	} batch ____cacheline_maxaligned_in_smp;
 	/* remaining members: bookkeeping of the progress of the grace period */
 	struct {
 		spinlock_t	mutex;	/* Guard this struct                  */
-		int	next_pending;	/* Is the next batch already waiting? */
 		cpumask_t	rcu_cpu_mask; 	/* CPUs that need to switch   */
 				/* in order for current batch to proceed.     */
 	} state ____cacheline_maxaligned_in_smp;
