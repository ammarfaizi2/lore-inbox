Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264785AbUEYFhb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264785AbUEYFhb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 01:37:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264775AbUEYFgh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 01:36:37 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:25730 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S264774AbUEYFfq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 01:35:46 -0400
Date: Tue, 25 May 2004 07:35:22 +0200
From: Manfred Spraul <manfred@dbl.q-ag.de>
Message-Id: <200405250535.i4P5ZMFt017607@dbl.q-ag.de>
To: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net
Subject: [RFC, PATCH] 3/5 rcu lock update: Code move & cleanup
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Step three for reducing cacheline trashing within rcupdate.c,
first step for a hierarchical cpumask bitmap: 

Cleanup and code move from <linux/rcupdate.h> to kernel/rcupdate.c.

No code changes.

What do you think?

--
	Manfred

// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm4
--- 2.6/kernel/rcupdate.c	2004-05-23 11:54:15.000000000 +0200
+++ build-2.6/kernel/rcupdate.c	2004-05-23 11:55:38.000000000 +0200
@@ -47,8 +47,17 @@
 
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
-	{ .batch = { .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO },
-	  .state = {.mutex = SPIN_LOCK_UNLOCKED, .rcu_cpu_mask = CPU_MASK_NONE } };
+	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
+
+/* Bookkeeping of the progress of the grace period */
+struct {
+	spinlock_t	mutex; /* Guard this struct and writes to rcu_ctrlblk */
+	cpumask_t	rcu_cpu_mask; /* CPUs that need to switch in order    */
+	                              /* for current batch to proceed.        */
+} rcu_state ____cacheline_maxaligned_in_smp = 
+	  {.mutex = SPIN_LOCK_UNLOCKED, .rcu_cpu_mask = CPU_MASK_NONE };
+
+
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
 /* Fake initialization required by compiler */
@@ -101,15 +110,15 @@
  * The grace period handling consists out of two steps:
  * - A new grace period is started.
  *   This is done by rcu_start_batch. The start is not broadcasted to
- *   all cpus, they must pick this up by comparing rcu_ctrlblk.batch.cur with
+ *   all cpus, they must pick this up by comparing rcu_ctrlblk.cur with
  *   RCU_quiescbatch(cpu). All cpus are recorded  in the
- *   rcu_ctrlblk.state.rcu_cpu_mask bitmap.
+ *   rcu_state.rcu_cpu_mask bitmap.
  * - All cpus must go through a quiescent state.
  *   Since the start of the grace period is not broadcasted, at least two
  *   calls to rcu_check_quiescent_state are required:
  *   The first call just notices that a new grace period is running. The
  *   following calls check if there was a quiescent state since the beginning
- *   of the grace period. If so, it updates rcu_ctrlblk.state.rcu_cpu_mask. If
+ *   of the grace period. If so, it updates rcu_state.rcu_cpu_mask. If
  *   the bitmap is empty, then the grace period is completed. 
  *   rcu_check_quiescent_state calls rcu_start_batch(0) to start the next grace
  *   period (if necessary).
@@ -117,25 +126,25 @@
 /*
  * Register a new batch of callbacks, and start it up if there is currently no
  * active batch and the batch to be registered has not already occurred.
- * Caller must hold the rcu_ctrlblk.state lock.
+ * Caller must hold rcu_state.mutex.
  */
 static void rcu_start_batch(int next_pending)
 {
 	cpumask_t active;
 
 	if (next_pending)
-		rcu_ctrlblk.batch.next_pending = 1;
+		rcu_ctrlblk.next_pending = 1;
 
-	if (rcu_ctrlblk.batch.next_pending &&
-			rcu_ctrlblk.batch.completed == rcu_ctrlblk.batch.cur) {
+	if (rcu_ctrlblk.next_pending &&
+			rcu_ctrlblk.completed == rcu_ctrlblk.cur) {
 		/* Can't change, since spin lock held. */
 		active = nohz_cpu_mask;
 		cpus_complement(active);
-		cpus_and(rcu_ctrlblk.state.rcu_cpu_mask, cpu_online_map, active);
-		write_seqcount_begin(&rcu_ctrlblk.batch.lock);
-		rcu_ctrlblk.batch.next_pending = 0;
-		rcu_ctrlblk.batch.cur++;
-		write_seqcount_end(&rcu_ctrlblk.batch.lock);
+		cpus_and(rcu_state.rcu_cpu_mask, cpu_online_map, active);
+		write_seqcount_begin(&rcu_ctrlblk.lock);
+		rcu_ctrlblk.next_pending = 0;
+		rcu_ctrlblk.cur++;
+		write_seqcount_end(&rcu_ctrlblk.lock);
 	}
 }
 
@@ -146,10 +155,10 @@
  */
 static void cpu_quiet(int cpu)
 {
-	cpu_clear(cpu, rcu_ctrlblk.state.rcu_cpu_mask);
-	if (cpus_empty(rcu_ctrlblk.state.rcu_cpu_mask)) {
+	cpu_clear(cpu, rcu_state.rcu_cpu_mask);
+	if (cpus_empty(rcu_state.rcu_cpu_mask)) {
 		/* batch completed ! */
-		rcu_ctrlblk.batch.completed = rcu_ctrlblk.batch.cur;
+		rcu_ctrlblk.completed = rcu_ctrlblk.cur;
 		rcu_start_batch(0);
 	}
 }
@@ -163,11 +172,11 @@
 {
 	int cpu = smp_processor_id();
 
-	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.batch.cur) {
+	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.cur) {
 		/* new grace period: record qsctr value. */
 		RCU_qs_pending(cpu) = 1;
 		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
-		RCU_quiescbatch(cpu) = rcu_ctrlblk.batch.cur;
+		RCU_quiescbatch(cpu) = rcu_ctrlblk.cur;
 		return;
 	}
 
@@ -187,15 +196,15 @@
 		return;
 	RCU_qs_pending(cpu) = 0;
 
-	spin_lock(&rcu_ctrlblk.state.mutex);
+	spin_lock(&rcu_state.mutex);
 	/*
 	 * RCU_quiescbatch/batch.cur and the cpu bitmap can come out of sync
 	 * during cpu startup. Ignore the quiescent state.
 	 */
-	if (likely(RCU_quiescbatch(cpu) == rcu_ctrlblk.batch.cur)) 
+	if (likely(RCU_quiescbatch(cpu) == rcu_ctrlblk.cur)) 
 		cpu_quiet(cpu);
 
-	spin_unlock(&rcu_ctrlblk.state.mutex);
+	spin_unlock(&rcu_state.mutex);
 }
 
 
@@ -225,11 +234,11 @@
 	 * we can block indefinitely waiting for it, so flush
 	 * it here
 	 */
-	spin_lock_bh(&rcu_ctrlblk.state.mutex);
-	if (rcu_ctrlblk.batch.cur != rcu_ctrlblk.batch.completed)
+	spin_lock_bh(&rcu_state.mutex);
+	if (rcu_ctrlblk.cur != rcu_ctrlblk.completed)
 		cpu_quiet(cpu);
 unlock:
-	spin_unlock_bh(&rcu_ctrlblk.state.mutex);
+	spin_unlock_bh(&rcu_state.mutex);
 
 	rcu_move_batch(&RCU_curlist(cpu));
 	rcu_move_batch(&RCU_nxtlist(cpu));
@@ -241,10 +250,10 @@
 
 void rcu_restart_cpu(int cpu)
 {
-	spin_lock_bh(&rcu_ctrlblk.state.mutex);
-	RCU_quiescbatch(cpu) = rcu_ctrlblk.batch.completed;
+	spin_lock_bh(&rcu_state.mutex);
+	RCU_quiescbatch(cpu) = rcu_ctrlblk.completed;
 	RCU_qs_pending(cpu) = 0;
-	spin_unlock_bh(&rcu_ctrlblk.state.mutex);
+	spin_unlock_bh(&rcu_state.mutex);
 }
 
 /*
@@ -256,7 +265,7 @@
 	LIST_HEAD(list);
 
 	if (!list_empty(&RCU_curlist(cpu)) &&
-			!rcu_batch_before(rcu_ctrlblk.batch.completed,RCU_batch(cpu))) {
+			!rcu_batch_before(rcu_ctrlblk.completed,RCU_batch(cpu))) {
 		__list_splice(&RCU_curlist(cpu), &list);
 		INIT_LIST_HEAD(&RCU_curlist(cpu));
 	}
@@ -273,17 +282,17 @@
 		 * start the next batch of callbacks
 		 */
 		do {
-			seq = read_seqcount_begin(&rcu_ctrlblk.batch.lock);
+			seq = read_seqcount_begin(&rcu_ctrlblk.lock);
 			/* determine batch number */
-			RCU_batch(cpu) = rcu_ctrlblk.batch.cur + 1;
-			next_pending = rcu_ctrlblk.batch.next_pending;
-		} while (read_seqcount_retry(&rcu_ctrlblk.batch.lock, seq));
+			RCU_batch(cpu) = rcu_ctrlblk.cur + 1;
+			next_pending = rcu_ctrlblk.next_pending;
+		} while (read_seqcount_retry(&rcu_ctrlblk.lock, seq));
 
 		if (!next_pending) {
 			/* and start it/schedule start if it's a new batch */
-			spin_lock(&rcu_ctrlblk.state.mutex);
+			spin_lock(&rcu_state.mutex);
 			rcu_start_batch(1);
-			spin_unlock(&rcu_ctrlblk.state.mutex);
+			spin_unlock(&rcu_state.mutex);
 		}
 	} else {
 		local_irq_enable();
@@ -308,7 +317,7 @@
 	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
 	INIT_LIST_HEAD(&RCU_nxtlist(cpu));
 	INIT_LIST_HEAD(&RCU_curlist(cpu));
-	RCU_quiescbatch(cpu) = rcu_ctrlblk.batch.completed;
+	RCU_quiescbatch(cpu) = rcu_ctrlblk.completed;
 	RCU_qs_pending(cpu) = 0;
 }
 
--- 2.6/include/linux/rcupdate.h	2004-05-23 11:54:15.000000000 +0200
+++ build-2.6/include/linux/rcupdate.h	2004-05-23 11:54:38.000000000 +0200
@@ -64,24 +64,13 @@
 
 
 
-/* Control variables for rcupdate callback mechanism. */
+/* Global control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
-	/* "const" members: only changed when starting/ending a grace period  */
-	struct {
-		long	cur;		/* Current batch number.	      */
-		long	completed;	/* Number of the last completed batch */
-		int	next_pending;	/* Is the next batch already waiting? */
-		seqcount_t lock;	/* for atomically reading cur and     */
-		                        /* next_pending. Spinlock not used,   */
-		                        /* protected by state.mutex           */
-	} batch ____cacheline_maxaligned_in_smp;
-	/* remaining members: bookkeeping of the progress of the grace period */
-	struct {
-		spinlock_t	mutex;	/* Guard this struct                  */
-		cpumask_t	rcu_cpu_mask; 	/* CPUs that need to switch   */
-				/* in order for current batch to proceed.     */
-	} state ____cacheline_maxaligned_in_smp;
-};
+	long	cur;		/* Current batch number.                      */
+	long	completed;	/* Number of the last completed batch         */
+	int	next_pending;	/* Is the next batch already waiting?         */
+	seqcount_t lock;	/* For atomic reads of cur and next_pending.  */
+} ____cacheline_maxaligned_in_smp;
 
 /* Is batch a before batch b ? */
 static inline int rcu_batch_before(long a, long b)
@@ -131,14 +120,14 @@
 	 * for them has completed.
 	 */
 	if (!list_empty(&RCU_curlist(cpu)) &&
-		  !rcu_batch_before(rcu_ctrlblk.batch.completed,RCU_batch(cpu)))
+		  !rcu_batch_before(rcu_ctrlblk.completed,RCU_batch(cpu)))
 		return 1;
 	/* This cpu has no pending entries, but there are new entries */
 	if (list_empty(&RCU_curlist(cpu)) &&
 			 !list_empty(&RCU_nxtlist(cpu)))
 		return 1;
 	/* The rcu core waits for a quiescent state from the cpu */
-	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.batch.cur || RCU_qs_pending(cpu))
+	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.cur || RCU_qs_pending(cpu))
 		return 1;
 	/* nothing to do */
 	return 0;
