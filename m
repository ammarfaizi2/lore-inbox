Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261875AbUEVTxw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261875AbUEVTxw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 May 2004 15:53:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261879AbUEVTxw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 May 2004 15:53:52 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:36818 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S261875AbUEVTxi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 May 2004 15:53:38 -0400
Date: Sat, 22 May 2004 21:52:04 +0200 (CEST)
From: Manfred Spraul <manfred@colorfullife.com>
X-X-Sender: manfred@dbl.q-ag.de
To: linux-kernel@vger.kernel.org
cc: lse-tech@lists.sourceforge.net, <steiner@sgi.com>
Subject: [RFC, PATCH] rcu scalability proposal
Message-ID: <Pine.LNX.4.44.0405222141260.11106-100000@dbl.q-ag.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've cleaned up my proposal to use integers to check if a cpu must do
something in the current grace period and tested it on an 8-way
Pentium III with reaim:

oprofile hits:
Reference: http://khack.osdl.org/stp/293075/
Hits	   %
23741     0.0994  rcu_pending
19057     0.0798  rcu_check_quiescent_state
6530      0.0273  rcu_check_callbacks

Patched: http://khack.osdl.org/stp/293076/
8291      0.0579  rcu_pending
5475      0.0382  rcu_check_quiescent_state
3604      0.0252  rcu_check_callbacks

The total runtime differs between both runs, thus the % number must
be compared: Around 50% faster. I've uninlined rcu_pending for the
test.

It should cut down the cache line trashing without any disadvantage
regarding the speed of memory recovery from rcu. I expect that 3/4
of the accesses to rcu_cpu_mask are avoided, probably not enough
for 512p, but it's a start.

What do you think? Any objections against sending it to Andrew?
It passes reaim and kernbench.

Description:
- per-cpu quiescbatch and qs_pending fields introduced:
  quiescbatch contains the number of the last quiescent period that
  the cpu has seen and qs_pending is set if the cpu has not yet
  reported the quiescent state for the current period. With
  these two fields a cpu can test if it should report a quiescent
  state without having to look at the frequently written rcu_cpu_mask
  bitmap.

- curbatch split into two fields: rcu_ctrlblk.batch.completed and
  rcu_ctrlblk.batch.cur. This makes it possible to figure out if
  a grace period is running (completed != cur) without accessing
  the rcu_cpu_mask bitmap.

- rcu_ctrlblk.maxbatch removed and replaced with a true/false
  next_pending flag: next_pending=1 means that another grace period
  should be started immediately after the end of the current period.
  Previously, this was achieved by maxbatch: curbatch==maxbatch means
  don't start, curbatch!= maxbatch means start.
  A flag improves the readability: The only possible values for
  maxbatch were curbatch and curbatch+1.

- rcu_ctrlblk split into two cachelines for better performance.

- common code from rcu_offline_cpu and rcu_check_quiescent_state merged
  into cpu_quiet, also used for rcu_restart_cpu

- rcu_offline_cpu: replace spin_lock_irq with spin_lock_bh, there are
  no accesses from irq context (and there are accesses to the spinlock
  with enabled interrupts from tasklet context).

- rcu_restart_cpu introduced, s390 should call it after changing nohz:
  Theoretically the global batch counter could wrap around and end up
  at RCU_quiescbatch(cpu). Then the cpu would not look for a quiescent
  state and rcu would lock up.

Btw, the code generated for rcu_pending() is incredibly bad: the
address of the per-cpu rcu_data is recalculated for every access.

--
	Manfred

<<<
// $Header$
// Kernel Version:
//  VERSION = 2
//  PATCHLEVEL = 6
//  SUBLEVEL = 6
//  EXTRAVERSION = -mm4
--- 2.6/kernel/rcupdate.c	2004-05-20 16:57:36.000000000 +0200
+++ build-2.6/kernel/rcupdate.c	2004-05-22 16:28:10.000000000 +0200
@@ -47,8 +47,8 @@

 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk =
-	{ .mutex = SPIN_LOCK_UNLOCKED, .curbatch = 1,
-	  .maxbatch = 1, .rcu_cpu_mask = CPU_MASK_NONE };
+	{ .batch = { .cur = -300, .completed = -300 },
+	  .state = {.mutex = SPIN_LOCK_UNLOCKED, .rcu_cpu_mask = CPU_MASK_NONE } };
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };

 /* Fake initialization required by compiler */
@@ -97,25 +97,59 @@
 }

 /*
+ * Grace period handling:
+ * The grace period handling consists out of two steps:
+ * - A new grace period is started.
+ *   This is done by rcu_start_batch. The start is not broadcasted to
+ *   all cpus, they must pick this up by comparing rcu_ctrlblk.batch.cur with
+ *   RCU_quiescbatch(cpu). All cpus are recorded  in the
+ *   rcu_ctrlblk.state.rcu_cpu_mask bitmap.
+ * - All cpus must go through a quiescent state.
+ *   Since the start of the grace period is not broadcasted, at least two
+ *   calls to rcu_check_quiescent_state are required:
+ *   The first call just notices that a new grace period is running. The
+ *   following calls check if there was a quiescent state since the beginning
+ *   of the grace period. If so, it updates rcu_ctrlblk.state.rcu_cpu_mask. If
+ *   the bitmap is empty, then the grace period is completed.
+ *   rcu_check_quiescent_state calls rcu_start_batch(0) to start the next grace
+ *   period (if necessary).
+ */
+/*
  * Register a new batch of callbacks, and start it up if there is currently no
  * active batch and the batch to be registered has not already occurred.
- * Caller must hold the rcu_ctrlblk lock.
+ * Caller must hold the rcu_ctrlblk.state lock.
  */
-static void rcu_start_batch(long newbatch)
+static void rcu_start_batch(int next_pending)
 {
 	cpumask_t active;

-	if (rcu_batch_before(rcu_ctrlblk.maxbatch, newbatch)) {
-		rcu_ctrlblk.maxbatch = newbatch;
+	if (next_pending)
+		rcu_ctrlblk.state.next_pending = 1;
+
+	if (rcu_ctrlblk.state.next_pending &&
+			rcu_ctrlblk.batch.completed == rcu_ctrlblk.batch.cur) {
+		rcu_ctrlblk.state.next_pending = 0;
+		/* Can't change, since spin lock held. */
+		active = nohz_cpu_mask;
+		cpus_complement(active);
+		cpus_and(rcu_ctrlblk.state.rcu_cpu_mask, cpu_online_map, active);
+		rcu_ctrlblk.batch.cur++;
 	}
-	if (rcu_batch_before(rcu_ctrlblk.maxbatch, rcu_ctrlblk.curbatch) ||
-	    !cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
-		return;
+}
+
+/*
+ * cpu went through a quiescent state since the beginning of the grace period.
+ * Clear it from the cpu mask and complete the grace period if it was the last
+ * cpu. Start another grace period if someone has further entries pending
+ */
+static void cpu_quiet(int cpu)
+{
+	cpu_clear(cpu, rcu_ctrlblk.state.rcu_cpu_mask);
+	if (cpus_empty(rcu_ctrlblk.state.rcu_cpu_mask)) {
+		/* batch completed ! */
+		rcu_ctrlblk.batch.completed = rcu_ctrlblk.batch.cur;
+		rcu_start_batch(0);
 	}
-	/* Can't change, since spin lock held. */
-	active = nohz_cpu_mask;
-	cpus_complement(active);
-	cpus_and(rcu_ctrlblk.rcu_cpu_mask, cpu_online_map, active);
 }

 /*
@@ -127,7 +161,19 @@
 {
 	int cpu = smp_processor_id();

-	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
+	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.batch.cur) {
+		/* new grace period: record qsctr value. */
+		RCU_qs_pending(cpu) = 1;
+		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
+		RCU_quiescbatch(cpu) = rcu_ctrlblk.batch.cur;
+		return;
+	}
+
+	/* Grace period already completed for this cpu?
+	 * qs_pending is checked instead of the actual bitmap to avoid
+	 * cacheline trashing.
+	 */
+	if (!RCU_qs_pending(cpu))
 		return;

 	/*
@@ -135,27 +181,19 @@
 	 * we may miss one quiescent state of that CPU. That is
 	 * tolerable. So no need to disable interrupts.
 	 */
-	if (RCU_last_qsctr(cpu) == RCU_QSCTR_INVALID) {
-		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
-		return;
-	}
 	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu))
 		return;
+	RCU_qs_pending(cpu) = 0;

-	spin_lock(&rcu_ctrlblk.mutex);
-	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
-		goto out_unlock;
-
-	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask);
-	RCU_last_qsctr(cpu) = RCU_QSCTR_INVALID;
-	if (!cpus_empty(rcu_ctrlblk.rcu_cpu_mask))
-		goto out_unlock;
-
-	rcu_ctrlblk.curbatch++;
-	rcu_start_batch(rcu_ctrlblk.maxbatch);
+	spin_lock(&rcu_ctrlblk.state.mutex);
+	/*
+	 * RCU_quiescbatch/batch.cur and the cpu bitmap can come out of sync
+	 * during cpu startup. Ignore the quiescent state.
+	 */
+	if (likely(RCU_quiescbatch(cpu) == rcu_ctrlblk.batch.cur))
+		cpu_quiet(cpu);

-out_unlock:
-	spin_unlock(&rcu_ctrlblk.mutex);
+	spin_unlock(&rcu_ctrlblk.state.mutex);
 }


@@ -185,25 +223,11 @@
 	 * we can block indefinitely waiting for it, so flush
 	 * it here
 	 */
-	spin_lock_irq(&rcu_ctrlblk.mutex);
-	if (cpus_empty(rcu_ctrlblk.rcu_cpu_mask))
-		goto unlock;
-
-	cpu_clear(cpu, rcu_ctrlblk.rcu_cpu_mask);
-	if (cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
-		rcu_ctrlblk.curbatch++;
-		/* We may avoid calling start batch if
-		 * we are starting the batch only
-		 * because of the DEAD CPU (the current
-		 * CPU will start a new batch anyway for
-		 * the callbacks we will move to current CPU).
-		 * However, we will avoid this optimisation
-		 * for now.
-		 */
-		rcu_start_batch(rcu_ctrlblk.maxbatch);
-	}
+	spin_lock_bh(&rcu_ctrlblk.state.mutex);
+	if (rcu_ctrlblk.batch.cur != rcu_ctrlblk.batch.completed)
+		cpu_quiet(cpu);
 unlock:
-	spin_unlock_irq(&rcu_ctrlblk.mutex);
+	spin_unlock_bh(&rcu_ctrlblk.state.mutex);

 	rcu_move_batch(&RCU_curlist(cpu));
 	rcu_move_batch(&RCU_nxtlist(cpu));
@@ -213,6 +237,16 @@

 #endif

+void rcu_restart_cpu(int cpu)
+{
+	spin_lock_bh(&rcu_ctrlblk.state.mutex);
+	if (rcu_ctrlblk.batch.cur != rcu_ctrlblk.batch.completed)
+		cpu_quiet(cpu);
+	RCU_quiescbatch(cpu) = rcu_ctrlblk.batch.cur;
+	RCU_qs_pending(cpu) = 0;
+	spin_unlock_bh(&rcu_ctrlblk.state.mutex);
+}
+
 /*
  * This does the RCU processing work from tasklet context.
  */
@@ -222,7 +256,7 @@
 	LIST_HEAD(list);

 	if (!list_empty(&RCU_curlist(cpu)) &&
-	    rcu_batch_after(rcu_ctrlblk.curbatch, RCU_batch(cpu))) {
+			!rcu_batch_before(rcu_ctrlblk.batch.completed,RCU_batch(cpu))) {
 		__list_splice(&RCU_curlist(cpu), &list);
 		INIT_LIST_HEAD(&RCU_curlist(cpu));
 	}
@@ -236,10 +270,10 @@
 		/*
 		 * start the next batch of callbacks
 		 */
-		spin_lock(&rcu_ctrlblk.mutex);
-		RCU_batch(cpu) = rcu_ctrlblk.curbatch + 1;
-		rcu_start_batch(RCU_batch(cpu));
-		spin_unlock(&rcu_ctrlblk.mutex);
+		spin_lock(&rcu_ctrlblk.state.mutex);
+		RCU_batch(cpu) = rcu_ctrlblk.batch.cur + 1;
+		rcu_start_batch(1);
+		spin_unlock(&rcu_ctrlblk.state.mutex);
 	} else {
 		local_irq_enable();
 	}
--- 2.6/include/linux/rcupdate.h	2004-05-20 16:57:36.000000000 +0200
+++ build-2.6/include/linux/rcupdate.h	2004-05-22 15:36:11.000000000 +0200
@@ -65,11 +65,18 @@

 /* Control variables for rcupdate callback mechanism. */
 struct rcu_ctrlblk {
-	spinlock_t	mutex;		/* Guard this struct                  */
-	long		curbatch;	/* Current batch number.	      */
-	long		maxbatch;	/* Max requested batch number.        */
-	cpumask_t	rcu_cpu_mask; 	/* CPUs that need to switch in order  */
-					/* for current batch to proceed.      */
+	/* "const" members: only changed when starting/ending a grace period  */
+	struct {
+		long	cur;		/* Current batch number.	      */
+		long	completed;	/* Number of the last completed batch */
+	} batch ____cacheline_maxaligned_in_smp;
+	/* remaining members: bookkeeping of the progress of the grace period */
+	struct {
+		spinlock_t	mutex;	/* Guard this struct                  */
+		int	next_pending;	/* Is the next batch already waiting? */
+		cpumask_t	rcu_cpu_mask; 	/* CPUs that need to switch   */
+				/* in order for current batch to proceed.     */
+	} state ____cacheline_maxaligned_in_smp;
 };

 /* Is batch a before batch b ? */
@@ -90,9 +97,14 @@
  * curlist - current batch for which quiescent cycle started if any
  */
 struct rcu_data {
+	/* 1) quiescent state handling : */
+        long		quiescbatch;     /* Batch # for grace period */
 	long		qsctr;		 /* User-mode/idle loop etc. */
         long            last_qsctr;	 /* value of qsctr at beginning */
                                          /* of rcu grace period */
+	int		qs_pending;	 /* core waits for quiesc state */
+
+	/* 2) batch handling */
         long  	       	batch;           /* Batch # for current RCU batch */
         struct list_head  nxtlist;
         struct list_head  curlist;
@@ -101,24 +113,31 @@
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
 extern struct rcu_ctrlblk rcu_ctrlblk;

+#define RCU_quiescbatch(cpu)	(per_cpu(rcu_data, (cpu)).quiescbatch)
 #define RCU_qsctr(cpu) 		(per_cpu(rcu_data, (cpu)).qsctr)
 #define RCU_last_qsctr(cpu) 	(per_cpu(rcu_data, (cpu)).last_qsctr)
+#define RCU_qs_pending(cpu)	(per_cpu(rcu_data, (cpu)).qs_pending)
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)

-#define RCU_QSCTR_INVALID	0
-
 static inline int rcu_pending(int cpu)
 {
-	if ((!list_empty(&RCU_curlist(cpu)) &&
-	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
-	    (list_empty(&RCU_curlist(cpu)) &&
-			 !list_empty(&RCU_nxtlist(cpu))) ||
-	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
+	/* This cpu has pending rcu entries and the grace period
+	 * for them has completed.
+	 */
+	if (!list_empty(&RCU_curlist(cpu)) &&
+		  !rcu_batch_before(rcu_ctrlblk.batch.completed,RCU_batch(cpu)))
+		return 1;
+	/* This cpu has no pending entries, but there are new entries */
+	if (list_empty(&RCU_curlist(cpu)) &&
+			 !list_empty(&RCU_nxtlist(cpu)))
+		return 1;
+	/* The rcu core waits for a quiescent state from the cpu */
+	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.batch.cur || RCU_qs_pending(cpu))
 		return 1;
-	else
-		return 0;
+	/* nothing to do */
+	return 0;
 }

 #define rcu_read_lock()		preempt_disable()
@@ -126,6 +145,7 @@

 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
+extern void rcu_restart_cpu(int cpu);

 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head,

>>>>>>>

