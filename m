Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266126AbUHFTVJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266126AbUHFTVJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:21:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268234AbUHFTVI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:21:08 -0400
Received: from e4.ny.us.ibm.com ([32.97.182.104]:30878 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S266126AbUHFTT4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:19:56 -0400
Date: Sun, 8 Aug 2004 00:47:29 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com
Subject: Re: RCU : clean up code [1/5]
Message-ID: <20040807191729.GB3936@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040807191536.GA3936@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807191536.GA3936@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Avoids per_cpu calculations and also prepares for call_rcu_bh().

Thanks
Dipankar


At OLS, Rusty had suggested getting rid of many per_cpu() calculations
in RCU code and making the code simpler. I had already done that for
the rcu-softirq patch earlier, so I am splitting that into two
patch. This first patch cleans up the macros and uses pointers
to the rcu per-cpu data directly to manipulate the callback
queues. This is useful for the call-rcu-bh patch (to follow) which introduces
a new RCU mechanism - call_rcu_bh(). Both generic and softirq rcu
can then use the same code, they work different global and
percpu data.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 include/linux/rcupdate.h |   38 ++++---
 kernel/rcupdate.c        |  229 ++++++++++++++++++++++++-----------------------
 kernel/sched.c           |    2 
 3 files changed, 143 insertions(+), 126 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-code-cleanup include/linux/rcupdate.h
--- linux-2.6.8-rc3-mm1/include/linux/rcupdate.h~rcu-code-cleanup	2004-08-07 15:28:30.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/include/linux/rcupdate.h	2004-08-07 15:28:30.000000000 +0530
@@ -101,47 +101,51 @@ struct rcu_data {
         struct rcu_head **curtail;
         struct rcu_head *donelist;
         struct rcu_head **donetail;
+	int cpu;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
 extern struct rcu_ctrlblk rcu_ctrlblk;
 
-#define RCU_quiescbatch(cpu)	(per_cpu(rcu_data, (cpu)).quiescbatch)
-#define RCU_qsctr(cpu) 		(per_cpu(rcu_data, (cpu)).qsctr)
-#define RCU_last_qsctr(cpu) 	(per_cpu(rcu_data, (cpu)).last_qsctr)
-#define RCU_qs_pending(cpu)	(per_cpu(rcu_data, (cpu)).qs_pending)
-#define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
-#define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
-#define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
-#define RCU_nxttail(cpu) 	(per_cpu(rcu_data, (cpu)).nxttail)
-#define RCU_curtail(cpu) 	(per_cpu(rcu_data, (cpu)).curtail)
-#define RCU_donelist(cpu) 	(per_cpu(rcu_data, (cpu)).donelist)
-#define RCU_donetail(cpu) 	(per_cpu(rcu_data, (cpu)).donetail)
+/*
+ * Increment the quiscent state counter.
+ */
+static inline void rcu_qsctr_inc(int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	rdp->qsctr++;
+}
 
-static inline int rcu_pending(int cpu) 
+static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
+						struct rcu_data *rdp) 
 {
 	/* This cpu has pending rcu entries and the grace period
 	 * for them has completed.
 	 */
-	if (RCU_curlist(cpu) &&
-		  !rcu_batch_before(rcu_ctrlblk.completed,RCU_batch(cpu)))
+	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch))
 		return 1;
 
 	/* This cpu has no pending entries, but there are new entries */
-	if (!RCU_curlist(cpu) && RCU_nxtlist(cpu))
+	if (!rdp->curlist && rdp->nxtlist)
 		return 1;
 
-	if (RCU_donelist(cpu))
+	/* This cpu has finished callbacks to invoke */
+	if (rdp->donelist)
 		return 1;
 
 	/* The rcu core waits for a quiescent state from the cpu */
-	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.cur || RCU_qs_pending(cpu))
+	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
 		return 1;
 
 	/* nothing to do */
 	return 0;
 }
 
+static inline int rcu_pending(int cpu)
+{
+	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu));
+}
+
 #define rcu_read_lock()		preempt_disable()
 #define rcu_read_unlock()	preempt_enable()
 
diff -puN kernel/rcupdate.c~rcu-code-cleanup kernel/rcupdate.c
--- linux-2.6.8-rc3-mm1/kernel/rcupdate.c~rcu-code-cleanup	2004-08-07 15:28:30.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/kernel/rcupdate.c	2004-08-07 15:28:30.000000000 +0530
@@ -17,9 +17,10 @@
  *
  * Copyright (C) IBM Corporation, 2001
  *
- * Author: Dipankar Sarma <dipankar@in.ibm.com>
+ * Authors: Dipankar Sarma <dipankar@in.ibm.com>
+ *	    Manfred Spraul <manfred@colorfullife.com>
  * 
- * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
+ * Based on the original work by Paul McKenney <paulmck@us.ibm.com>
  * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
  * Papers:
  * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
@@ -51,19 +52,20 @@ struct rcu_ctrlblk rcu_ctrlblk = 
 	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
 
 /* Bookkeeping of the progress of the grace period */
-struct {
-	spinlock_t	mutex; /* Guard this struct and writes to rcu_ctrlblk */
-	cpumask_t	rcu_cpu_mask; /* CPUs that need to switch in order    */
+struct rcu_state {
+	spinlock_t	lock; /* Guard this struct and writes to rcu_ctrlblk */
+	cpumask_t	cpumask; /* CPUs that need to switch in order    */
 	                              /* for current batch to proceed.        */
-} rcu_state ____cacheline_maxaligned_in_smp =
-	  {.mutex = SPIN_LOCK_UNLOCKED, .rcu_cpu_mask = CPU_MASK_NONE };
+};
+
+struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
+	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
 
 
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
-#define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
 static int maxbatch = 10;
 
 /**
@@ -79,15 +81,15 @@ static int maxbatch = 10;
 void fastcall call_rcu(struct rcu_head *head,
 				void (*func)(struct rcu_head *rcu))
 {
-	int cpu;
 	unsigned long flags;
+	struct rcu_data *rdp;
 
 	head->func = func;
 	head->next = NULL;
 	local_irq_save(flags);
-	cpu = smp_processor_id();
-	*RCU_nxttail(cpu) = head;
-	RCU_nxttail(cpu) = &head->next;
+	rdp = &__get_cpu_var(rcu_data);
+	*rdp->nxttail = head;
+	rdp->nxttail = &head->next;
 	local_irq_restore(flags);
 }
 
@@ -95,23 +97,23 @@ void fastcall call_rcu(struct rcu_head *
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
  */
-static void rcu_do_batch(int cpu)
+static void rcu_do_batch(struct rcu_data *rdp)
 {
 	struct rcu_head *next, *list;
 	int count = 0;
 
-	list = RCU_donelist(cpu);
+	list = rdp->donelist;
 	while (list) {
-		next = RCU_donelist(cpu) = list->next;
+		next = rdp->donelist = list->next;
 		list->func(list);
 		list = next;
 		if (++count >= maxbatch)
 			break;
 	}
-	if (!RCU_donelist(cpu))
-		RCU_donetail(cpu) = &RCU_donelist(cpu);
+	if (!rdp->donelist)
+		rdp->donetail = &rdp->donelist;
 	else
-		tasklet_schedule(&RCU_tasklet(cpu));
+		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
 }
 
 /*
@@ -119,15 +121,15 @@ static void rcu_do_batch(int cpu)
  * The grace period handling consists out of two steps:
  * - A new grace period is started.
  *   This is done by rcu_start_batch. The start is not broadcasted to
- *   all cpus, they must pick this up by comparing rcu_ctrlblk.cur with
- *   RCU_quiescbatch(cpu). All cpus are recorded  in the
- *   rcu_state.rcu_cpu_mask bitmap.
+ *   all cpus, they must pick this up by comparing rcp->cur with
+ *   rdp->quiescbatch. All cpus are recorded  in the
+ *   rcu_state.cpumask bitmap.
  * - All cpus must go through a quiescent state.
  *   Since the start of the grace period is not broadcasted, at least two
  *   calls to rcu_check_quiescent_state are required:
  *   The first call just notices that a new grace period is running. The
  *   following calls check if there was a quiescent state since the beginning
- *   of the grace period. If so, it updates rcu_state.rcu_cpu_mask. If
+ *   of the grace period. If so, it updates rcu_state.cpumask. If
  *   the bitmap is empty, then the grace period is completed.
  *   rcu_check_quiescent_state calls rcu_start_batch(0) to start the next grace
  *   period (if necessary).
@@ -135,22 +137,22 @@ static void rcu_do_batch(int cpu)
 /*
  * Register a new batch of callbacks, and start it up if there is currently no
  * active batch and the batch to be registered has not already occurred.
- * Caller must hold rcu_state.mutex.
+ * Caller must hold rcu_state.lock.
  */
-static void rcu_start_batch(int next_pending)
+static void rcu_start_batch(struct rcu_ctrlblk *rcp, struct rcu_state *rsp,
+				int next_pending)
 {
 	if (next_pending)
-		rcu_ctrlblk.next_pending = 1;
+		rcp->next_pending = 1;
 
-	if (rcu_ctrlblk.next_pending &&
-			rcu_ctrlblk.completed == rcu_ctrlblk.cur) {
+	if (rcp->next_pending &&
+			rcp->completed == rcp->cur) {
 		/* Can't change, since spin lock held. */
-		cpus_andnot(rcu_state.rcu_cpu_mask, cpu_online_map,
-							nohz_cpu_mask);
-		write_seqcount_begin(&rcu_ctrlblk.lock);
-		rcu_ctrlblk.next_pending = 0;
-		rcu_ctrlblk.cur++;
-		write_seqcount_end(&rcu_ctrlblk.lock);
+		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
+		write_seqcount_begin(&rcp->lock);
+		rcp->next_pending = 0;
+		rcp->cur++;
+		write_seqcount_end(&rcp->lock);
 	}
 }
 
@@ -159,13 +161,13 @@ static void rcu_start_batch(int next_pen
  * Clear it from the cpu mask and complete the grace period if it was the last
  * cpu. Start another grace period if someone has further entries pending
  */
-static void cpu_quiet(int cpu)
+static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
 {
-	cpu_clear(cpu, rcu_state.rcu_cpu_mask);
-	if (cpus_empty(rcu_state.rcu_cpu_mask)) {
+	cpu_clear(cpu, rsp->cpumask);
+	if (cpus_empty(rsp->cpumask)) {
 		/* batch completed ! */
-		rcu_ctrlblk.completed = rcu_ctrlblk.cur;
-		rcu_start_batch(0);
+		rcp->completed = rcp->cur;
+		rcu_start_batch(rcp, rsp, 0);
 	}
 }
 
@@ -174,15 +176,14 @@ static void cpu_quiet(int cpu)
  * switch). If so and if it already hasn't done so in this RCU
  * quiescent cycle, then indicate that it has done so.
  */
-static void rcu_check_quiescent_state(void)
+static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
+			struct rcu_state *rsp, struct rcu_data *rdp)
 {
-	int cpu = smp_processor_id();
-
-	if (RCU_quiescbatch(cpu) != rcu_ctrlblk.cur) {
+	if (rdp->quiescbatch != rcp->cur) {
 		/* new grace period: record qsctr value. */
-		RCU_qs_pending(cpu) = 1;
-		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
-		RCU_quiescbatch(cpu) = rcu_ctrlblk.cur;
+		rdp->qs_pending = 1;
+		rdp->last_qsctr = rdp->qsctr;
+		rdp->quiescbatch = rcp->cur;
 		return;
 	}
 
@@ -190,7 +191,7 @@ static void rcu_check_quiescent_state(vo
 	 * qs_pending is checked instead of the actual bitmap to avoid
 	 * cacheline trashing.
 	 */
-	if (!RCU_qs_pending(cpu))
+	if (!rdp->qs_pending)
 		return;
 
 	/* 
@@ -198,19 +199,19 @@ static void rcu_check_quiescent_state(vo
 	 * we may miss one quiescent state of that CPU. That is
 	 * tolerable. So no need to disable interrupts.
 	 */
-	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu))
+	if (rdp->qsctr == rdp->last_qsctr)
 		return;
-	RCU_qs_pending(cpu) = 0;
+	rdp->qs_pending = 0;
 
-	spin_lock(&rcu_state.mutex);
+	spin_lock(&rsp->lock);
 	/*
-	 * RCU_quiescbatch/batch.cur and the cpu bitmap can come out of sync
+	 * rdp->quiescbatch/rcp->cur and the cpu bitmap can come out of sync
 	 * during cpu startup. Ignore the quiescent state.
 	 */
-	if (likely(RCU_quiescbatch(cpu) == rcu_ctrlblk.cur))
-		cpu_quiet(cpu);
+	if (likely(rdp->quiescbatch == rcp->cur))
+		cpu_quiet(rdp->cpu, rcp, rsp);
 
-	spin_unlock(&rcu_state.mutex);
+	spin_unlock(&rsp->lock);
 }
 
 
@@ -220,33 +221,39 @@ static void rcu_check_quiescent_state(vo
  * locking requirements, the list it's pulling from has to belong to a cpu
  * which is dead and hence not processing interrupts.
  */
-static void rcu_move_batch(struct rcu_head *list, struct rcu_head **tail)
+static void rcu_move_batch(struct rcu_data *this_rdp, struct rcu_head *list, 
+				struct rcu_head **tail)
 {
-	int cpu;
-
 	local_irq_disable();
-	cpu = smp_processor_id();
-	*RCU_nxttail(cpu) = list;
+	*this_rdp->nxttail = list;
 	if (list)
-		RCU_nxttail(cpu) = tail;
+		this_rdp->nxttail = tail;
 	local_irq_enable();
 }
 
-static void rcu_offline_cpu(int cpu)
+static void __rcu_offline_cpu(struct rcu_data *this_rdp, 
+	struct rcu_ctrlblk *rcp, struct rcu_state *rsp, struct rcu_data *rdp)
 {
 	/* if the cpu going offline owns the grace period
 	 * we can block indefinitely waiting for it, so flush
 	 * it here
 	 */
-	spin_lock_bh(&rcu_state.mutex);
-	if (rcu_ctrlblk.cur != rcu_ctrlblk.completed)
-		cpu_quiet(cpu);
-	spin_unlock_bh(&rcu_state.mutex);
+	spin_lock_bh(&rsp->lock);
+	if (rcp->cur != rcp->completed)
+		cpu_quiet(rdp->cpu, rcp, rsp);
+	spin_unlock_bh(&rsp->lock);
+	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
+	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
 
-	rcu_move_batch(RCU_curlist(cpu), RCU_curtail(cpu));
-	rcu_move_batch(RCU_nxtlist(cpu), RCU_nxttail(cpu));
+}
+static void rcu_offline_cpu(int cpu)
+{
+	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
 
-	tasklet_kill_immediate(&RCU_tasklet(cpu), cpu);
+	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk, &rcu_state,
+					&per_cpu(rcu_data, cpu));
+	put_cpu_var(rcu_data);
+	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
 }
 
 #else
@@ -257,81 +264,87 @@ static void rcu_offline_cpu(int cpu)
 
 #endif
 
-void rcu_restart_cpu(int cpu)
-{
-	spin_lock_bh(&rcu_state.mutex);
-	RCU_quiescbatch(cpu) = rcu_ctrlblk.completed;
-	RCU_qs_pending(cpu) = 0;
-	spin_unlock_bh(&rcu_state.mutex);
-}
-
 /*
  * This does the RCU processing work from tasklet context. 
  */
-static void rcu_process_callbacks(unsigned long unused)
+static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp, 
+			struct rcu_state *rsp, struct rcu_data *rdp)
 {
-	int cpu = smp_processor_id();
-
-	if (RCU_curlist(cpu) &&
-	    !rcu_batch_before(rcu_ctrlblk.completed, RCU_batch(cpu))) {
-		*RCU_donetail(cpu) = RCU_curlist(cpu);
-		RCU_donetail(cpu) = RCU_curtail(cpu);
-		RCU_curlist(cpu) = NULL;
-		RCU_curtail(cpu) = &RCU_curlist(cpu);
+	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch)) {
+		*rdp->donetail = rdp->curlist;
+		rdp->donetail = rdp->curtail;
+		rdp->curlist = NULL;
+		rdp->curtail = &rdp->curlist;
 	}
 
 	local_irq_disable();
-	if (RCU_nxtlist(cpu) && !RCU_curlist(cpu)) {
+	if (rdp->nxtlist && !rdp->curlist) {
 		int next_pending, seq;
 
-		RCU_curlist(cpu) = RCU_nxtlist(cpu);
-		RCU_curtail(cpu) = RCU_nxttail(cpu);
-		RCU_nxtlist(cpu) = NULL;
-		RCU_nxttail(cpu) = &RCU_nxtlist(cpu);
+		rdp->curlist = rdp->nxtlist;
+		rdp->curtail = rdp->nxttail;
+		rdp->nxtlist = NULL;
+		rdp->nxttail = &rdp->nxtlist;
 		local_irq_enable();
 
 		/*
 		 * start the next batch of callbacks
 		 */
 		do {
-			seq = read_seqcount_begin(&rcu_ctrlblk.lock);
+			seq = read_seqcount_begin(&rcp->lock);
 			/* determine batch number */
-			RCU_batch(cpu) = rcu_ctrlblk.cur + 1;
-			next_pending = rcu_ctrlblk.next_pending;
-		} while (read_seqcount_retry(&rcu_ctrlblk.lock, seq));
+			rdp->batch = rcp->cur + 1;
+			next_pending = rcp->next_pending;
+		} while (read_seqcount_retry(&rcp->lock, seq));
 
 		if (!next_pending) {
 			/* and start it/schedule start if it's a new batch */
-			spin_lock(&rcu_state.mutex);
-			rcu_start_batch(1);
-			spin_unlock(&rcu_state.mutex);
+			spin_lock(&rsp->lock);
+			rcu_start_batch(rcp, rsp, 1);
+			spin_unlock(&rsp->lock);
 		}
 	} else {
 		local_irq_enable();
 	}
-	rcu_check_quiescent_state();
-	if (RCU_donelist(cpu))
-		rcu_do_batch(cpu);
+	rcu_check_quiescent_state(rcp, rsp, rdp);
+	if (rdp->donelist)
+		rcu_do_batch(rdp);
+}
+
+static void rcu_process_callbacks(unsigned long unused)
+{
+	__rcu_process_callbacks(&rcu_ctrlblk, &rcu_state, 
+				&__get_cpu_var(rcu_data));
 }
 
 void rcu_check_callbacks(int cpu, int user)
 {
+	struct rcu_data *rdp = &__get_cpu_var(rcu_data);
 	if (user || 
 	    (idle_cpu(cpu) && !in_softirq() && 
 				hardirq_count() <= (1 << HARDIRQ_SHIFT)))
-		RCU_qsctr(cpu)++;
-	tasklet_schedule(&RCU_tasklet(cpu));
+		rdp->qsctr++;
+	tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
+}
+
+static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp, 
+						struct rcu_data *rdp)
+{
+	memset(rdp, 0, sizeof(*rdp));
+	rdp->curtail = &rdp->curlist;
+	rdp->nxttail = &rdp->nxtlist;
+	rdp->donetail = &rdp->donelist;
+	rdp->quiescbatch = rcp->completed;
+	rdp->qs_pending = 0;
+	rdp->cpu = cpu;
 }
 
 static void __devinit rcu_online_cpu(int cpu)
 {
-	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
-	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
-	RCU_curtail(cpu) = &RCU_curlist(cpu);
-	RCU_nxttail(cpu) = &RCU_nxtlist(cpu);
-	RCU_donetail(cpu) = &RCU_donelist(cpu);
-	RCU_quiescbatch(cpu) = rcu_ctrlblk.completed;
-	RCU_qs_pending(cpu) = 0;
+	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+
+	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
+	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
 }
 
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 
diff -puN kernel/sched.c~rcu-code-cleanup kernel/sched.c
--- linux-2.6.8-rc3-mm1/kernel/sched.c~rcu-code-cleanup	2004-08-07 15:28:30.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/kernel/sched.c	2004-08-07 15:28:30.000000000 +0530
@@ -2548,7 +2548,7 @@ need_resched:
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
-	RCU_qsctr(task_cpu(prev))++;
+	rcu_qsctr_inc(task_cpu(prev));
 
 	prev->sleep_avg -= run_time;
 	if ((long)prev->sleep_avg <= 0) {

_
