Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268197AbUHTUVC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268197AbUHTUVC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Aug 2004 16:21:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266334AbUHTUVB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Aug 2004 16:21:01 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:16313 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S268723AbUHTUQT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Aug 2004 16:16:19 -0400
Message-ID: <41265CCE.3070808@colorfullife.com>
Date: Fri, 20 Aug 2004 22:19:26 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.2) Gecko/20040803
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Barnes <jbarnes@engr.sgi.com>
CC: paulmck@us.ibm.com, "Martin J. Bligh" <mbligh@aracnet.com>, hawkes@sgi.com,
       linux-kernel@vger.kernel.org, wli@holomorphy.com
Subject: Re: kernbench on 512p
References: <200408191216.33667.jbarnes@engr.sgi.com> <200408192016.10064.jbarnes@engr.sgi.com> <20040820155717.GF1243@us.ibm.com> <200408201324.32464.jbarnes@engr.sgi.com>
In-Reply-To: <200408201324.32464.jbarnes@engr.sgi.com>
Content-Type: multipart/mixed;
 boundary="------------020804040008090304010607"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------020804040008090304010607
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

Jesse Barnes wrote:

>Looks like a bit more context has changed.  Manfred, care to respin against 
>-mm3 so I can test?
>
>  
>
The patches are attached. Just boot-tested on a single-cpu system.

Three  changes:
- I've placed the per-group structure into rcu_state. That's simpler but 
wrong: the state should be allocated from node-local memory, not a big 
global array.
- I found a bug/race in the cpu_offline path: When the last cpu of a 
group goes offline then the group must be forced into quiescent state. 
The "&& (!forced)" was missing.
- I've removed the spin_unlock_wait(). It was intended to synchronize 
cpu_online_mask changes with the calculation of ->outstanding. Paul 
convinced me that this is not necessary.

--
    Manfred

--------------020804040008090304010607
Content-Type: text/plain;
 name="patch-rcu268-01-locking"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-rcu268-01-locking"

--- 2.6/kernel/rcupdate.c	2004-08-20 19:59:22.000000000 +0200
+++ build-2.6/kernel/rcupdate.c	2004-08-20 20:46:35.952639280 +0200
@@ -237,14 +237,29 @@
  * Clear it from the cpu mask and complete the grace period if it was the last
  * cpu. Start another grace period if someone has further entries pending
  */
-static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
+static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp,
+			struct rcu_data *rdp, int force)
 {
+	spin_lock(&rsp->lock);
+
+	if (unlikely(rcp->completed == rcp->cur))
+		goto out_unlock;
+	/*
+	 * RCU_quiescbatch/batch.cur and the cpu bitmap can come out of sync
+	 * during cpu startup. Ignore the quiescent state if that happened.
+	 */
+	if (unlikely(rdp->quiescbatch != rcp->cur) && likely(!force))
+		goto out_unlock;
+
 	cpu_clear(cpu, rsp->cpumask);
 	if (cpus_empty(rsp->cpumask)) {
 		/* batch completed ! */
 		rcp->completed = rcp->cur;
 		rcu_start_batch(rcp, rsp, 0);
 	}
+out_unlock:
+	spin_unlock(&rsp->lock);
+
 }
 
 /*
@@ -279,15 +294,7 @@
 		return;
 	rdp->qs_pending = 0;
 
-	spin_lock(&rsp->lock);
-	/*
-	 * rdp->quiescbatch/rcp->cur and the cpu bitmap can come out of sync
-	 * during cpu startup. Ignore the quiescent state.
-	 */
-	if (likely(rdp->quiescbatch == rcp->cur))
-		cpu_quiet(rdp->cpu, rcp, rsp);
-
-	spin_unlock(&rsp->lock);
+	cpu_quiet(rdp->cpu, rcp, rsp, rdp, 0);
 }
 
 
@@ -314,10 +321,10 @@
 	 * we can block indefinitely waiting for it, so flush
 	 * it here
 	 */
-	spin_lock_bh(&rsp->lock);
-	if (rcp->cur != rcp->completed)
-		cpu_quiet(rdp->cpu, rcp, rsp);
-	spin_unlock_bh(&rsp->lock);
+	local_bh_disable();
+	cpu_quiet(rdp->cpu, rcp, rsp, rdp, 1);
+	local_bh_enable();
+
 	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
 	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
 

--------------020804040008090304010607
Content-Type: text/plain;
 name="patch-rcu268-02-groups"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="patch-rcu268-02-groups"

--- 2.6/kernel/rcupdate.c	2004-08-20 21:52:45.272210984 +0200
+++ build-2.6/kernel/rcupdate.c	2004-08-20 21:52:24.664343856 +0200
@@ -53,17 +53,59 @@
 struct rcu_ctrlblk rcu_bh_ctrlblk =
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
+	spinlock_t	lock; /* Guard this struct */
+	long batchnum;	/* batchnum this group is working on. Mitmatch with
+			 * ctrlblk->cur means reinitialize outstanding to
+			 * all active cpus in this group.
+			 */
+	unsigned long outstanding[RCU_GROUP_CPUMASKLEN];
+} ____cacheline_maxaligned_in_smp;
+
+#endif
+
 /* Bookkeeping of the progress of the grace period */
 struct rcu_state {
 	spinlock_t	lock; /* Guard this struct and writes to rcu_ctrlblk */
+#ifdef RCU_HUGE
+	long batchnum;         /* batchnum the system is working on. Mismatch
+				* with rcu_ctrlblk.cur means reinitialize
+				* outstanding to all groups with active cpus
+				*/
+	unsigned long outstanding[RCU_GROUPMASKLEN];
+	struct rcu_group_state groups[RCU_GROUPCOUNT];
+#else
 	cpumask_t	cpumask; /* CPUs that need to switch in order    */
 	                              /* for current batch to proceed.        */
+#endif
 };
 
-struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
-	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
-struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp =
-	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
+#ifdef RCU_HUGE
+#define RCU_STATE_INITIALIZER 	\
+		{ \
+			.lock = SPIN_LOCK_UNLOCKED, \
+			.batchnum = -400, \
+			.groups = { [0 ... RCU_GROUPCOUNT-1] = \
+					{ .lock = SPIN_LOCK_UNLOCKED, .batchnum = -400 } } \
+		}
+
+#else
+#define RCU_STATE_INITIALIZER 	{.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE }
+#endif
+
+struct rcu_state rcu_state ____cacheline_maxaligned_in_smp = RCU_STATE_INITIALIZER;
+struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp = RCU_STATE_INITIALIZER;
 
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
@@ -223,8 +265,15 @@
 
 	if (rcp->next_pending &&
 			rcp->completed == rcp->cur) {
+#ifdef RCU_HUGE
+		/* Nothing to do: RCU_HUGE uses lazy initialization of the
+		 * outstanding bitmap
+		 */
+#else
+		/* FIXME: what does this comment mean? */
 		/* Can't change, since spin lock held. */
 		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
+#endif
 		write_seqcount_begin(&rcp->lock);
 		rcp->next_pending = 0;
 		rcp->cur++;
@@ -237,6 +286,76 @@
  * Clear it from the cpu mask and complete the grace period if it was the last
  * cpu. Start another grace period if someone has further entries pending
  */
+#ifdef RCU_HUGE
+static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp,
+			struct rcu_data *rdp, int force)
+{
+	struct rcu_group_state *rgs;
+	long batch;
+	int i;
+
+	batch = rcp->cur;
+
+	rgs = &rsp->groups[cpu/RCU_GROUP_SIZE];
+
+	spin_lock(&rgs->lock);
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
+	if (unlikely(rdp->quiescbatch != rgs->batchnum) && likely(!force))
+       		goto out_unlock_group;
+
+	__clear_bit(cpu%RCU_GROUP_SIZE, rgs->outstanding);
+	for (i=0;i<RCU_GROUP_CPUMASKLEN;i++) {
+		if (rgs->outstanding[i])
+			break;
+	}
+	if (i==RCU_GROUP_CPUMASKLEN) {
+		/* group completed, escalate to global level */
+		spin_lock(&rsp->lock);
+
+		if (rsp->batchnum != rcp->cur) {
+			/* first call for this batch - initialize outstanding */
+			rsp->batchnum = rcp->cur;
+			memset(rsp->outstanding, 0, sizeof(rsp->outstanding));
+
+			for (i=0;i<NR_CPUS;i+=RCU_GROUP_SIZE) {
+				int j;
+				for (j=0;j<RCU_GROUP_SIZE;j++) {
+					if (cpu_online(i+j) && !cpu_isset(i+j, nohz_cpu_mask))
+						break;
+				}
+				if (j != RCU_GROUP_SIZE)
+					__set_bit(i/RCU_GROUP_SIZE, rsp->outstanding);
+			}
+		}
+		if (unlikely(rgs->batchnum != rsp->batchnum) && likely(!force))
+       			goto out_unlock_all;
+		__clear_bit(cpu/RCU_GROUP_SIZE, rsp->outstanding);
+		for (i=0;i<RCU_GROUPMASKLEN;i++) {
+			if (rsp->outstanding[i])
+				break;
+		}
+		if (i==RCU_GROUPMASKLEN) {
+			/* all groups completed, batch completed */
+			rcp->completed = rcp->cur;
+			rcu_start_batch(rcp, rsp, 0);
+		}
+out_unlock_all:
+		spin_unlock(&rcu_state.lock);
+	}
+out_unlock_group:
+	spin_unlock(&rgs->lock);
+}
+#else
 static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp,
 			struct rcu_data *rdp, int force)
 {
@@ -261,6 +380,7 @@
 	spin_unlock(&rsp->lock);
 
 }
+#endif
 
 /*
  * Check if the cpu has gone through a quiescent state (say context
@@ -418,8 +538,25 @@
 	tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
 }
 
+#ifdef RCU_HUGE
+static void rcu_update_group(int cpu, struct rcu_ctrlblk *rcp,
+						struct rcu_state *rsp)
+{
+	int i, offset;
+	offset = (cpu/RCU_GROUP_SIZE)*RCU_GROUP_SIZE;
+	for (i=0;i<RCU_GROUP_SIZE;i++) {
+		if (cpu_online(i+offset) && !cpu_isset(i, nohz_cpu_mask))
+			break;
+	}
+	if (i == RCU_GROUP_SIZE) {
+		/* No cpu online from this group. Initialize batchnum. */
+		rsp->groups[cpu/RCU_GROUP_SIZE].batchnum = rcp->completed;
+	}
+}
+#endif
+
 static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp,
-						struct rcu_data *rdp)
+		       		struct rcu_state *rsp, struct rcu_data *rdp)
 {
 	memset(rdp, 0, sizeof(*rdp));
 	rdp->curtail = &rdp->curlist;
@@ -428,6 +565,9 @@
 	rdp->quiescbatch = rcp->completed;
 	rdp->qs_pending = 0;
 	rdp->cpu = cpu;
+#ifdef RCU_HUGE
+	rcu_update_group(cpu, rcp, rsp);
+#endif
 }
 
 static void __devinit rcu_online_cpu(int cpu)
@@ -435,8 +575,8 @@
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
 	struct rcu_data *bh_rdp = &per_cpu(rcu_bh_data, cpu);
 
-	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
-	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
+	rcu_init_percpu_data(cpu, &rcu_ctrlblk, &rcu_state, rdp);
+	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, &rcu_bh_state, bh_rdp);
 	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
 }
 

--------------020804040008090304010607--
