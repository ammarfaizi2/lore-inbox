Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264772AbUEYFft@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264772AbUEYFft (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:35:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUEYFft
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:35:49 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:25218 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264772AbUEYFfp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:35:45 -0400
Date: Tue, 25 May 2004 07:35:23 +0200
From: Manfred Spraul <manfred@dbl.q-ag.de>
Message-Id: <200405250535.i4P5ZN6g017615@dbl.q-ag.de>
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [RFC, PATCH] 4/5 rcu lock update: Hide locking details
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Step four for reducing cacheline trashing within rcupdate.c,
second step for a hierarchical cpumask bitmap: 

Move the locking calls that protect rcu_cpu_mask into cpu_quiet.

What do you think?

--
	Manfred

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm4
--- 2.6/kernel/rcupdate.c	2004-05-23 11:57:48.000000000 +0200
+++ build-2.6/kernel/rcupdate.c	2004-05-23 11:56:32.000000000 +0200
@@ -153,14 +153,27 @@
  * Clear it from the cpu mask and complete the grace period if it was the last
  * cpu. Start another grace period if someone has further entries pending
  */
-static void cpu_quiet(int cpu)
+static void cpu_quiet(int cpu, int force)
 {
+	spin_lock(&rcu_state.mutex);
+
+	if (unlikely(rcu_ctrlblk.completed == rcu_ctrlblk.cur))
+		goto out_unlock;
+	/*
+	 * RCU_quiescbatch/batch.cur and the cpu bitmap can come out of sync
+	 * during cpu startup. Ignore the quiescent state.
+	 */
+	if (unlikely(RCU_quiescbatch(cpu) != rcu_ctrlblk.cur) && likely(!force))
+       		goto out_unlock;
+
 	cpu_clear(cpu, rcu_state.rcu_cpu_mask);
 	if (cpus_empty(rcu_state.rcu_cpu_mask)) {
 		/* batch completed ! */
 		rcu_ctrlblk.completed = rcu_ctrlblk.cur;
 		rcu_start_batch(0);
 	}
+out_unlock:
+	spin_unlock(&rcu_state.mutex);
 }
 
 /*
@@ -196,15 +209,8 @@
 		return;
 	RCU_qs_pending(cpu) = 0;
 
-	spin_lock(&rcu_state.mutex);
-	/*
-	 * RCU_quiescbatch/batch.cur and the cpu bitmap can come out of sync
-	 * during cpu startup. Ignore the quiescent state.
-	 */
-	if (likely(RCU_quiescbatch(cpu) == rcu_ctrlblk.cur)) 
-		cpu_quiet(cpu);
+	cpu_quiet(cpu, 0);
 
-	spin_unlock(&rcu_state.mutex);
 }
 
 
@@ -234,11 +240,7 @@
 	 * we can block indefinitely waiting for it, so flush
 	 * it here
 	 */
-	spin_lock_bh(&rcu_state.mutex);
-	if (rcu_ctrlblk.cur != rcu_ctrlblk.completed)
-		cpu_quiet(cpu);
-unlock:
-	spin_unlock_bh(&rcu_state.mutex);
+	cpu_quiet(cpu, 1);
 
 	rcu_move_batch(&RCU_curlist(cpu));
 	rcu_move_batch(&RCU_nxtlist(cpu));
