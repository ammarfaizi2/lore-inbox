Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264775AbUEYFjV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264775AbUEYFjV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:39:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264774AbUEYFjV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:39:21 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:27778 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264776AbUEYFgh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:36:37 -0400
Date: Tue, 25 May 2004 07:35:24 +0200
From: Manfred Spraul <manfred@dbl.q-ag.de>
Message-Id: <200405250535.i4P5ZO7I017623@dbl.q-ag.de>
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [RFC, PATCH] 5/5 rcu lock update: Hierarchical rcu_cpu_mask bitmap
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Step five for reducing cacheline trashing within rcupdate.c,
third step for a hierarchical cpumask bitmap: 

Introduce a new cpu_quiet implementation based on a hierarchical
bitmap, again based on generation numbers.

Each level contains a copy of the generation number. A mismatch means
that the level is not yet initialized.

Most code changes depend on RCU_HUGE, the old (and more efficient)
code remains unchanged and can be used for non-gargantuan systems.

Proof of concept, needs further cleanups and testing.
Does pass reaim on an 8-way Pentium III Xeon.

What do you think?

--
	Manfred

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm4
--- 2.6/kernel/rcupdate.c	2004-05-23 13:30:01.000000000 +0200
+++ build-2.6/kernel/rcupdate.c	2004-05-23 13:31:23.000000000 +0200
@@ -49,14 +49,48 @@
 struct rcu_ctrlblk rcu_ctrlblk = 
 	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
 
+/* XXX Dummy - should belong into arch XXX */
+#define RCU_HUGE
+#define RCU_GROUP_SIZE	2
+/* XXX End of dummy XXX */
+
+#ifdef RCU_HUGE
+
+#define RCU_GROUPCOUNT		((NR_CPUS+RCU_GROUP_SIZE-1)/RCU_GROUP_SIZE)
+#define RCU_GROUP_CPUMASKLEN	((RCU_GROUP_SIZE+BITS_PER_LONG-1)/BITS_PER_LONG)
+#define RCU_GROUPMASKLEN	((NR_CPUS+RCU_GROUP_SIZE*BITS_PER_LONG-1)/(RCU_GROUP_SIZE*BITS_PER_LONG))
+
+struct rcu_group_state {
+	spinlock_t	mutex; /* Guard this struct                           */
+	long batchnum;
+	unsigned long outstanding[RCU_GROUP_CPUMASKLEN];
+} ____cacheline_maxaligned_in_smp;
+
+struct rcu_group_state rcu_groups[RCU_GROUPCOUNT] = 
+	{ [0 ... RCU_GROUPCOUNT-1] =
+		{ .mutex = SPIN_LOCK_UNLOCKED, .batchnum = -400 } };
+
+#endif
+
 /* Bookkeeping of the progress of the grace period */
 struct {
 	spinlock_t	mutex; /* Guard this struct and writes to rcu_ctrlblk */
+#ifdef RCU_HUGE
+	long batchnum;         /* batchnum we are working on. Mismatch with   */
+	                       /* rcu_ctrlblk.cur means restart from scratch  */
+	unsigned long outstanding[RCU_GROUPMASKLEN];
+#else
 	cpumask_t	rcu_cpu_mask; /* CPUs that need to switch in order    */
 	                              /* for current batch to proceed.        */
+#endif
 } rcu_state ____cacheline_maxaligned_in_smp = 
-	  {.mutex = SPIN_LOCK_UNLOCKED, .rcu_cpu_mask = CPU_MASK_NONE };
-
+	  {.mutex = SPIN_LOCK_UNLOCKED,
+#ifdef RCU_HUGE
+		.batchnum = -400,
+#else
+		.rcu_cpu_mask = CPU_MASK_NONE
+#endif
+	  };
 
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
@@ -130,17 +164,23 @@
  */
 static void rcu_start_batch(int next_pending)
 {
-	cpumask_t active;
-
 	if (next_pending)
 		rcu_ctrlblk.next_pending = 1;
 
 	if (rcu_ctrlblk.next_pending &&
 			rcu_ctrlblk.completed == rcu_ctrlblk.cur) {
+#ifdef RCU_HUGE
+		/* Nothing to do: RCU_HUGE uses lazy initialization of the
+		 * outstanding bitmap
+		 */
+#else
+		cpumask_t active;
+
 		/* Can't change, since spin lock held. */
 		active = nohz_cpu_mask;
 		cpus_complement(active);
 		cpus_and(rcu_state.rcu_cpu_mask, cpu_online_map, active);
+#endif
 		write_seqcount_begin(&rcu_ctrlblk.lock);
 		rcu_ctrlblk.next_pending = 0;
 		rcu_ctrlblk.cur++;
@@ -153,6 +193,75 @@
  * Clear it from the cpu mask and complete the grace period if it was the last
  * cpu. Start another grace period if someone has further entries pending
  */
+#ifdef RCU_HUGE
+static void cpu_quiet(int cpu, int force)
+{
+	struct rcu_group_state *rgs;
+	long batch;
+	int i;
+
+	batch = rcu_ctrlblk.cur;
+
+	rgs = &rcu_groups[cpu/RCU_GROUP_SIZE];
+
+	spin_lock(&rgs->mutex);
+	if (rgs->batchnum != batch) {
+		int offset;
+		/* first call for this batch - initialize outstanding */
+		rgs->batchnum = batch;
+		memset(rgs->outstanding, 0, sizeof(rgs->outstanding));
+		offset = (cpu/RCU_GROUP_SIZE)*RCU_GROUP_SIZE;
+		for (i=0;i<RCU_GROUP_SIZE;i++) {
+			if (cpu_online(i+offset) && !cpu_isset(i+offset, nohz_cpu_mask))
+				__set_bit(i, rgs->outstanding);
+		}
+	}
+	if (unlikely(RCU_quiescbatch(cpu) != rgs->batchnum) && likely(!force))
+       		goto out_unlock_group;
+
+	__clear_bit(cpu%RCU_GROUP_SIZE, rgs->outstanding);
+	for (i=0;i<RCU_GROUP_CPUMASKLEN;i++) {
+		if (rgs->outstanding[i])
+			break;
+	}
+	if (i==RCU_GROUP_CPUMASKLEN) {
+		/* group completed, escalate to global level */
+		spin_lock(&rcu_state.mutex);
+
+		if (rcu_state.batchnum != rcu_ctrlblk.cur) {
+			/* first call for this batch - initialize outstanding */
+			rcu_state.batchnum = rcu_ctrlblk.cur;
+			memset(rcu_state.outstanding, 0, sizeof(rcu_state.outstanding));
+
+			for (i=0;i<NR_CPUS;i+=RCU_GROUP_SIZE) {
+				int j;
+				for (j=0;j<RCU_GROUP_SIZE;j++) {
+					if (cpu_online(i+j) && !cpu_isset(i+j, nohz_cpu_mask))
+						break;
+				}
+				if (j != RCU_GROUP_SIZE)
+					__set_bit(i/RCU_GROUP_SIZE, rcu_state.outstanding);
+			}
+		}
+		if (unlikely(rgs->batchnum != rcu_state.batchnum))
+       			goto out_unlock_all;
+		__clear_bit(cpu/RCU_GROUP_SIZE, rcu_state.outstanding);
+		for (i=0;i<RCU_GROUPMASKLEN;i++) {
+			if (rcu_state.outstanding[i])
+				break;
+		}
+		if (i==RCU_GROUPMASKLEN) {
+			/* all groups completed, batch completed */
+			rcu_ctrlblk.completed = rcu_ctrlblk.cur;
+			rcu_start_batch(0);
+		}
+out_unlock_all:
+		spin_unlock(&rcu_state.mutex);
+	}
+out_unlock_group:
+	spin_unlock(&rgs->mutex);
+}
+#else
 static void cpu_quiet(int cpu, int force)
 {
 	spin_lock(&rcu_state.mutex);
@@ -175,6 +284,7 @@
 out_unlock:
 	spin_unlock(&rcu_state.mutex);
 }
+#endif
 
 /*
  * Check if the cpu has gone through a quiescent state (say context
@@ -240,6 +350,7 @@
 	 * we can block indefinitely waiting for it, so flush
 	 * it here
 	 */
+	spin_unlock_wait(&rcu_state.mutex);
 	cpu_quiet(cpu, 1);
 
 	rcu_move_batch(&RCU_curlist(cpu));
@@ -250,11 +361,30 @@
 
 #endif
 
+#ifdef RCU_HUGE
+static void rcu_update_group(int cpu)
+{
+	int i, offset;
+	offset = (cpu/RCU_GROUP_SIZE)*RCU_GROUP_SIZE;
+	for (i=0;i<RCU_GROUP_SIZE;i++) {
+		if (cpu_online(i+offset) && !cpu_isset(i, nohz_cpu_mask))
+			break;
+	}
+	if (i == RCU_GROUP_SIZE) {
+		/* No cpu online from this group. Initialize batchnum. */
+		rcu_groups[cpu/RCU_GROUP_SIZE].batchnum = rcu_ctrlblk.completed;
+	}
+}
+#endif
+
 void rcu_restart_cpu(int cpu)
 {
 	spin_lock_bh(&rcu_state.mutex);
 	RCU_quiescbatch(cpu) = rcu_ctrlblk.completed;
 	RCU_qs_pending(cpu) = 0;
+#ifdef RCU_HUGE
+	rcu_update_group(cpu);
+#endif
 	spin_unlock_bh(&rcu_state.mutex);
 }
 
@@ -315,6 +445,9 @@
 
 static void __devinit rcu_online_cpu(int cpu)
 {
+#ifdef RCU_HUGE
+	rcu_update_group(cpu);
+#endif
 	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
 	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
 	INIT_LIST_HEAD(&RCU_nxtlist(cpu));
