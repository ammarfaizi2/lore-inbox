Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261911AbVCRWun@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261911AbVCRWun (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 17:50:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262089AbVCRWum
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 17:50:42 -0500
Received: from zeus.kernel.org ([204.152.189.113]:24536 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id S261911AbVCRWrU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 17:47:20 -0500
Date: Fri, 18 Mar 2005 14:22:30 -0800
From: "Paul E. McKenney" <paulmck@us.ibm.com>
To: Ingo Molnar <mingo@elte.hu>
Cc: dipankar@in.ibm.com, shemminger@osdl.org, akpm@osdl.org, torvalds@osdl.org,
       rusty@au1.ibm.com, tgall@us.ibm.com, jim.houston@comcast.net,
       manfred@colorfullife.com, gh@us.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: Real-Time Preemption and RCU
Message-ID: <20050318222229.GB1303@us.ibm.com>
Reply-To: paulmck@us.ibm.com
References: <20050318002026.GA2693@us.ibm.com> <20050318074903.GA27656@elte.hu> <20050318164351.GE1299@us.ibm.com> <20050318171126.GA30310@elte.hu> <20050318203517.GA1303@us.ibm.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="0ntfKIWw70PvrIHh"
Content-Disposition: inline
In-Reply-To: <20050318203517.GA1303@us.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Mar 18, 2005 at 12:35:17PM -0800, Paul E. McKenney wrote:
> Compiles, probably dies horribly.  "diff" didn't do such a good job
> on this one, so attaching the raw rcupdate.[hc] files as well.

My prediction was all too accurate.  ;-)

The attached patch at least boots on a 1-CPU x86 box.  I added some
interrupt disabling that is a bad idea in real-time preempt kernels,
but necessary for stock kernels to even have a ghost of a chance.

Again, the diff is quite confusing to read (for me, anyway!), so attached
the rcupdate.[hc] files.

Assuming this patch survives the LTP run (hah!!!), next step is a small
SMP system.

						Thanx, Paul

Signed-off-by: <paulmck@us.ibm.com>

diff -urpN -X ../dontdiff linux-2.5/include/linux/rcupdate.h linux-2.5-rtRCU/include/linux/rcupdate.h
--- linux-2.5/include/linux/rcupdate.h	Wed Mar  9 12:37:06 2005
+++ linux-2.5-rtRCU/include/linux/rcupdate.h	Fri Mar 18 11:37:02 2005
@@ -58,169 +58,11 @@ struct rcu_head {
        (ptr)->next = NULL; (ptr)->func = NULL; \
 } while (0)
 
-
-
-/* Global control variables for rcupdate callback mechanism. */
-struct rcu_ctrlblk {
-	long	cur;		/* Current batch number.                      */
-	long	completed;	/* Number of the last completed batch         */
-	int	next_pending;	/* Is the next batch already waiting?         */
-} ____cacheline_maxaligned_in_smp;
-
-/* Is batch a before batch b ? */
-static inline int rcu_batch_before(long a, long b)
-{
-        return (a - b) < 0;
-}
-
-/* Is batch a after batch b ? */
-static inline int rcu_batch_after(long a, long b)
-{
-        return (a - b) > 0;
-}
-
-/*
- * Per-CPU data for Read-Copy UPdate.
- * nxtlist - new callbacks are added here
- * curlist - current batch for which quiescent cycle started if any
- */
-struct rcu_data {
-	/* 1) quiescent state handling : */
-	long		quiescbatch;     /* Batch # for grace period */
-	int		passed_quiesc;	 /* User-mode/idle loop etc. */
-	int		qs_pending;	 /* core waits for quiesc state */
-
-	/* 2) batch handling */
-	long  	       	batch;           /* Batch # for current RCU batch */
-	struct rcu_head *nxtlist;
-	struct rcu_head **nxttail;
-	struct rcu_head *curlist;
-	struct rcu_head **curtail;
-	struct rcu_head *donelist;
-	struct rcu_head **donetail;
-	int cpu;
-};
-
-DECLARE_PER_CPU(struct rcu_data, rcu_data);
-DECLARE_PER_CPU(struct rcu_data, rcu_bh_data);
-extern struct rcu_ctrlblk rcu_ctrlblk;
-extern struct rcu_ctrlblk rcu_bh_ctrlblk;
-
-/*
- * Increment the quiescent state counter.
- * The counter is a bit degenerated: We do not need to know
- * how many quiescent states passed, just if there was at least
- * one since the start of the grace period. Thus just a flag.
- */
-static inline void rcu_qsctr_inc(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	rdp->passed_quiesc = 1;
-}
-static inline void rcu_bh_qsctr_inc(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
-	rdp->passed_quiesc = 1;
-}
-
-static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
-						struct rcu_data *rdp)
-{
-	/* This cpu has pending rcu entries and the grace period
-	 * for them has completed.
-	 */
-	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch))
-		return 1;
-
-	/* This cpu has no pending entries, but there are new entries */
-	if (!rdp->curlist && rdp->nxtlist)
-		return 1;
-
-	/* This cpu has finished callbacks to invoke */
-	if (rdp->donelist)
-		return 1;
-
-	/* The rcu core waits for a quiescent state from the cpu */
-	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
-		return 1;
-
-	/* nothing to do */
-	return 0;
-}
-
-static inline int rcu_pending(int cpu)
-{
-	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
-		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
-}
-
-/**
- * rcu_read_lock - mark the beginning of an RCU read-side critical section.
- *
- * When synchronize_kernel() is invoked on one CPU while other CPUs
- * are within RCU read-side critical sections, then the
- * synchronize_kernel() is guaranteed to block until after all the other
- * CPUs exit their critical sections.  Similarly, if call_rcu() is invoked
- * on one CPU while other CPUs are within RCU read-side critical
- * sections, invocation of the corresponding RCU callback is deferred
- * until after the all the other CPUs exit their critical sections.
- *
- * Note, however, that RCU callbacks are permitted to run concurrently
- * with RCU read-side critical sections.  One way that this can happen
- * is via the following sequence of events: (1) CPU 0 enters an RCU
- * read-side critical section, (2) CPU 1 invokes call_rcu() to register
- * an RCU callback, (3) CPU 0 exits the RCU read-side critical section,
- * (4) CPU 2 enters a RCU read-side critical section, (5) the RCU
- * callback is invoked.  This is legal, because the RCU read-side critical
- * section that was running concurrently with the call_rcu() (and which
- * therefore might be referencing something that the corresponding RCU
- * callback would free up) has completed before the corresponding
- * RCU callback is invoked.
- *
- * RCU read-side critical sections may be nested.  Any deferred actions
- * will be deferred until the outermost RCU read-side critical section
- * completes.
- *
- * It is illegal to block while in an RCU read-side critical section.
- */
-#define rcu_read_lock()		preempt_disable()
-
-/**
- * rcu_read_unlock - marks the end of an RCU read-side critical section.
- *
- * See rcu_read_lock() for more information.
- */
-#define rcu_read_unlock()	preempt_enable()
-
-/*
- * So where is rcu_write_lock()?  It does not exist, as there is no
- * way for writers to lock out RCU readers.  This is a feature, not
- * a bug -- this property is what provides RCU's performance benefits.
- * Of course, writers must coordinate with each other.  The normal
- * spinlock primitives work well for this, but any other technique may be
- * used as well.  RCU does not care how the writers keep out of each
- * others' way, as long as they do so.
- */
-
-/**
- * rcu_read_lock_bh - mark the beginning of a softirq-only RCU critical section
- *
- * This is equivalent of rcu_read_lock(), but to be used when updates
- * are being done using call_rcu_bh(). Since call_rcu_bh() callbacks
- * consider completion of a softirq handler to be a quiescent state,
- * a process in RCU read-side critical section must be protected by
- * disabling softirqs. Read-side critical sections in interrupt context
- * can use just rcu_read_lock().
- *
- */
-#define rcu_read_lock_bh()	local_bh_disable()
-
-/*
- * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
- *
- * See rcu_read_lock_bh() for more information.
- */
-#define rcu_read_unlock_bh()	local_bh_enable()
+#define rcu_read_lock_bh() rcu_read_lock()
+#define rcu_read_unlock_bh() rcu_read_unlock()
+#define call_rcu_bh(head, func) call_rcu(head, func)
+#define rcu_bh_qsctr_inc(cpu)
+#define rcu_qsctr_inc(cpu)
 
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
@@ -257,15 +99,15 @@ static inline int rcu_pending(int cpu)
 					})
 
 extern void rcu_init(void);
-extern void rcu_check_callbacks(int cpu, int user);
-extern void rcu_restart_cpu(int cpu);
 
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
 				void (*func)(struct rcu_head *head)));
-extern void FASTCALL(call_rcu_bh(struct rcu_head *head,
-				void (*func)(struct rcu_head *head)));
+extern void rcu_read_lock(void);
+extern void rcu_read_unlock(void);
 extern void synchronize_kernel(void);
+extern int rcu_pending(int cpu);
+extern void rcu_check_callbacks(int cpu, int user);
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */
diff -urpN -X ../dontdiff linux-2.5/include/linux/sched.h linux-2.5-rtRCU/include/linux/sched.h
--- linux-2.5/include/linux/sched.h	Wed Mar  9 12:37:07 2005
+++ linux-2.5-rtRCU/include/linux/sched.h	Fri Mar 18 11:33:13 2005
@@ -707,6 +707,9 @@ struct task_struct {
   	struct mempolicy *mempolicy;
 	short il_next;
 #endif
+
+	int rcu_read_lock_nesting;
+	rwlock_t *rcu_read_lock_ptr;
 };
 
 static inline pid_t process_group(struct task_struct *tsk)
diff -urpN -X ../dontdiff linux-2.5/kernel/rcupdate.c linux-2.5-rtRCU/kernel/rcupdate.c
--- linux-2.5/kernel/rcupdate.c	Wed Mar  9 12:37:22 2005
+++ linux-2.5-rtRCU/kernel/rcupdate.c	Fri Mar 18 13:21:55 2005
@@ -47,424 +47,173 @@
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
 
-/* Definition for rcupdate control block. */
-struct rcu_ctrlblk rcu_ctrlblk = 
-	{ .cur = -300, .completed = -300 };
-struct rcu_ctrlblk rcu_bh_ctrlblk =
-	{ .cur = -300, .completed = -300 };
-
-/* Bookkeeping of the progress of the grace period */
-struct rcu_state {
-	spinlock_t	lock; /* Guard this struct and writes to rcu_ctrlblk */
-	cpumask_t	cpumask; /* CPUs that need to switch in order    */
-	                              /* for current batch to proceed.        */
+#define GRACE_PERIODS_PER_SEC 10
+
+struct rcu_data {
+	rwlock_t	lock;
+	long		batch;
+	struct rcu_head	*waitlist;
+	struct rcu_head	**waittail;
+	struct rcu_head	*donelist;
+	struct rcu_head	**donetail;
+};
+struct rcu_ctrlblk {
+	long		batch;
+	unsigned long	last_sk;
+};
+DEFINE_PER_CPU(struct rcu_data, rcu_data) = {
+	.lock = RW_LOCK_UNLOCKED,
+	.batch = 0,
+	.waitlist = NULL,
+	.donelist = NULL
+};
+struct rcu_ctrlblk rcu_ctrlblk = {
+	.batch = 0,
 };
 
-static struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
-	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
-static struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp =
-	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
-
-DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
-DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
-
-/* Fake initialization required by compiler */
-static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
-static int maxbatch = 10;
-
-/**
- * call_rcu - Queue an RCU callback for invocation after a grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual update function to be invoked after the grace period
- *
- * The update function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
- * and may be nested.
- */
-void fastcall call_rcu(struct rcu_head *head,
-				void (*func)(struct rcu_head *rcu))
+void rcu_init(void)
 {
-	unsigned long flags;
+	int cpu;
 	struct rcu_data *rdp;
 
-	head->func = func;
-	head->next = NULL;
-	local_irq_save(flags);
-	rdp = &__get_cpu_var(rcu_data);
-	*rdp->nxttail = head;
-	rdp->nxttail = &head->next;
-	local_irq_restore(flags);
+	for_each_cpu(cpu) {
+		rdp = &per_cpu(rcu_data, cpu);
+		rdp->waittail = &rdp->waitlist;
+		rdp->donetail = &rdp->donelist;
+	}
 }
 
-/**
- * call_rcu_bh - Queue an RCU for invocation after a quicker grace period.
- * @head: structure to be used for queueing the RCU updates.
- * @func: actual update function to be invoked after the grace period
- *
- * The update function will be invoked some time after a full grace
- * period elapses, in other words after all currently executing RCU
- * read-side critical sections have completed. call_rcu_bh() assumes
- * that the read-side critical sections end on completion of a softirq
- * handler. This means that read-side critical sections in process
- * context must not be interrupted by softirqs. This interface is to be
- * used when most of the read-side critical sections are in softirq context.
- * RCU read-side critical sections are delimited by rcu_read_lock() and
- * rcu_read_unlock(), * if in interrupt context or rcu_read_lock_bh()
- * and rcu_read_unlock_bh(), if in process context. These may be nested.
- */
-void fastcall call_rcu_bh(struct rcu_head *head,
-				void (*func)(struct rcu_head *rcu))
+void rcu_read_lock(void)
 {
 	unsigned long flags;
-	struct rcu_data *rdp;
 
-	head->func = func;
-	head->next = NULL;
-	local_irq_save(flags);
-	rdp = &__get_cpu_var(rcu_bh_data);
-	*rdp->nxttail = head;
-	rdp->nxttail = &head->next;
+	local_irq_save(flags);  /* allow invocation from OOM handler. */
+	if (current->rcu_read_lock_nesting++ == 0) {
+		current->rcu_read_lock_ptr = &__get_cpu_var(rcu_data).lock;
+		read_lock(current->rcu_read_lock_ptr);
+	}
 	local_irq_restore(flags);
 }
 
-/*
- * Invoke the completed RCU callbacks. They are expected to be in
- * a per-cpu list.
- */
-static void rcu_do_batch(struct rcu_data *rdp)
+void rcu_read_unlock(void)
 {
-	struct rcu_head *next, *list;
-	int count = 0;
+	unsigned long flags;
 
-	list = rdp->donelist;
-	while (list) {
-		next = rdp->donelist = list->next;
-		list->func(list);
-		list = next;
-		if (++count >= maxbatch)
-			break;
+	local_irq_save(flags);  /* allow invocation from OOM handler. */
+	if (--current->rcu_read_lock_nesting == 0) {
+		read_unlock(current->rcu_read_lock_ptr);
 	}
-	if (!rdp->donelist)
-		rdp->donetail = &rdp->donelist;
-	else
-		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
+	local_irq_restore(flags);
 }
 
-/*
- * Grace period handling:
- * The grace period handling consists out of two steps:
- * - A new grace period is started.
- *   This is done by rcu_start_batch. The start is not broadcasted to
- *   all cpus, they must pick this up by comparing rcp->cur with
- *   rdp->quiescbatch. All cpus are recorded  in the
- *   rcu_state.cpumask bitmap.
- * - All cpus must go through a quiescent state.
- *   Since the start of the grace period is not broadcasted, at least two
- *   calls to rcu_check_quiescent_state are required:
- *   The first call just notices that a new grace period is running. The
- *   following calls check if there was a quiescent state since the beginning
- *   of the grace period. If so, it updates rcu_state.cpumask. If
- *   the bitmap is empty, then the grace period is completed.
- *   rcu_check_quiescent_state calls rcu_start_batch(0) to start the next grace
- *   period (if necessary).
- */
-/*
- * Register a new batch of callbacks, and start it up if there is currently no
- * active batch and the batch to be registered has not already occurred.
- * Caller must hold rcu_state.lock.
- */
-static void rcu_start_batch(struct rcu_ctrlblk *rcp, struct rcu_state *rsp,
-				int next_pending)
+void _synchronize_kernel(void)
 {
-	if (next_pending)
-		rcp->next_pending = 1;
+	int cpu;
+	unsigned long flags;
 
-	if (rcp->next_pending &&
-			rcp->completed == rcp->cur) {
-		/* Can't change, since spin lock held. */
-		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
-
-		rcp->next_pending = 0;
-		/* next_pending == 0 must be visible in __rcu_process_callbacks()
-		 * before it can see new value of cur.
-		 */
-		smp_wmb();
-		rcp->cur++;
+	local_irq_save(flags);  /* allow invocation from OOM handler. */
+	for_each_cpu(cpu) {  /* _online() or _present() races with hotplug */
+		write_lock(per_cpu(rcu_data, cpu));
+	}
+	rcu_ctrlblk.batch++;
+	rcu_ctrlblk.last_sk = jiffies;
+	for_each_cpu(cpu) {
+		write_unlock(per_cpu(rcu_data, cpu));
 	}
+	local_irq_restore(flags);
 }
 
-/*
- * cpu went through a quiescent state since the beginning of the grace period.
- * Clear it from the cpu mask and complete the grace period if it was the last
- * cpu. Start another grace period if someone has further entries pending
- */
-static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
+void synchronize_kernel(void)
 {
-	cpu_clear(cpu, rsp->cpumask);
-	if (cpus_empty(rsp->cpumask)) {
-		/* batch completed ! */
-		rcp->completed = rcp->cur;
-		rcu_start_batch(rcp, rsp, 0);
-	}
-}
+	long oldbatch;
 
-/*
- * Check if the cpu has gone through a quiescent state (say context
- * switch). If so and if it already hasn't done so in this RCU
- * quiescent cycle, then indicate that it has done so.
- */
-static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
-			struct rcu_state *rsp, struct rcu_data *rdp)
-{
-	if (rdp->quiescbatch != rcp->cur) {
-		/* start new grace period: */
-		rdp->qs_pending = 1;
-		rdp->passed_quiesc = 0;
-		rdp->quiescbatch = rcp->cur;
-		return;
+	smp_mb();
+	oldbatch = rcu_ctrlblk.batch;
+	schedule_timeout(HZ/GRACE_PERIODS_PER_SEC);
+	if (rcu_ctrlblk.batch == oldbatch) {
+		_synchronize_kernel();
 	}
-
-	/* Grace period already completed for this cpu?
-	 * qs_pending is checked instead of the actual bitmap to avoid
-	 * cacheline trashing.
-	 */
-	if (!rdp->qs_pending)
-		return;
-
-	/* 
-	 * Was there a quiescent state since the beginning of the grace
-	 * period? If no, then exit and wait for the next call.
-	 */
-	if (!rdp->passed_quiesc)
-		return;
-	rdp->qs_pending = 0;
-
-	spin_lock(&rsp->lock);
-	/*
-	 * rdp->quiescbatch/rcp->cur and the cpu bitmap can come out of sync
-	 * during cpu startup. Ignore the quiescent state.
-	 */
-	if (likely(rdp->quiescbatch == rcp->cur))
-		cpu_quiet(rdp->cpu, rcp, rsp);
-
-	spin_unlock(&rsp->lock);
-}
-
-
-#ifdef CONFIG_HOTPLUG_CPU
-
-/* warning! helper for rcu_offline_cpu. do not use elsewhere without reviewing
- * locking requirements, the list it's pulling from has to belong to a cpu
- * which is dead and hence not processing interrupts.
- */
-static void rcu_move_batch(struct rcu_data *this_rdp, struct rcu_head *list,
-				struct rcu_head **tail)
-{
-	local_irq_disable();
-	*this_rdp->nxttail = list;
-	if (list)
-		this_rdp->nxttail = tail;
-	local_irq_enable();
 }
 
-static void __rcu_offline_cpu(struct rcu_data *this_rdp,
-	struct rcu_ctrlblk *rcp, struct rcu_state *rsp, struct rcu_data *rdp)
+void rcu_advance_callbacks(void)
 {
-	/* if the cpu going offline owns the grace period
-	 * we can block indefinitely waiting for it, so flush
-	 * it here
-	 */
-	spin_lock_bh(&rsp->lock);
-	if (rcp->cur != rcp->completed)
-		cpu_quiet(rdp->cpu, rcp, rsp);
-	spin_unlock_bh(&rsp->lock);
-	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
-	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
+	unsigned long flags;
+	struct rcu_data *rdp;
 
+	local_irq_save(flags);  /* allow invocation from OOM handler. */
+	rdp = &__get_cpu_var(rcu_data);
+	smp_mb();	/* prevent sampling batch # before list removal. */
+	if (rdp->batch != rcu_ctrlblk.batch) {
+		*rdp->donetail = rdp->waitlist;
+		rdp->donetail = rdp->waittail;
+		rdp->waitlist = NULL;
+		rdp->waittail = &rdp->waitlist;
+		rdp->batch = rcu_ctrlblk.batch;
+	}
+	local_irq_restore(flags);
 }
-static void rcu_offline_cpu(int cpu)
+
+void call_rcu(struct rcu_head *head,
+	 void (*func)(struct rcu_head *rcu))
 {
-	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
-	struct rcu_data *this_bh_rdp = &get_cpu_var(rcu_bh_data);
+	unsigned long flags;
+	struct rcu_data *rdp;
 
-	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk, &rcu_state,
-					&per_cpu(rcu_data, cpu));
-	__rcu_offline_cpu(this_bh_rdp, &rcu_bh_ctrlblk, &rcu_bh_state,
-					&per_cpu(rcu_bh_data, cpu));
-	put_cpu_var(rcu_data);
-	put_cpu_var(rcu_bh_data);
-	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
+	head->func = func;
+	head->next = NULL;
+	local_irq_save(flags);
+	rcu_advance_callbacks();
+	rdp = &__get_cpu_var(rcu_data);
+	*rdp->waittail = head;
+	rdp->waittail = &head->next;
+	local_irq_restore(flags);
 }
 
-#else
-
-static void rcu_offline_cpu(int cpu)
+void rcu_process_callbacks(void)
 {
-}
-
-#endif
+	unsigned long flags;
+	struct rcu_head *next, *list;
+	struct rcu_data *rdp;
 
-/*
- * This does the RCU processing work from tasklet context. 
- */
-static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
-			struct rcu_state *rsp, struct rcu_data *rdp)
-{
-	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch)) {
-		*rdp->donetail = rdp->curlist;
-		rdp->donetail = rdp->curtail;
-		rdp->curlist = NULL;
-		rdp->curtail = &rdp->curlist;
+	local_irq_save(flags);
+	rdp = &__get_cpu_var(rcu_data);
+	list = rdp->donelist;
+	if (list == NULL) {
+		local_irq_restore(flags);
+		return;
 	}
-
-	local_irq_disable();
-	if (rdp->nxtlist && !rdp->curlist) {
-		rdp->curlist = rdp->nxtlist;
-		rdp->curtail = rdp->nxttail;
-		rdp->nxtlist = NULL;
-		rdp->nxttail = &rdp->nxtlist;
-		local_irq_enable();
-
-		/*
-		 * start the next batch of callbacks
-		 */
-
-		/* determine batch number */
-		rdp->batch = rcp->cur + 1;
-		/* see the comment and corresponding wmb() in
-		 * the rcu_start_batch()
-		 */
-		smp_rmb();
-
-		if (!rcp->next_pending) {
-			/* and start it/schedule start if it's a new batch */
-			spin_lock(&rsp->lock);
-			rcu_start_batch(rcp, rsp, 1);
-			spin_unlock(&rsp->lock);
-		}
-	} else {
-		local_irq_enable();
+	rdp->donelist = NULL;
+	rdp->donetail = &rdp->waitlist;
+	local_irq_restore(flags);
+	while (list) {
+		next = list->next;
+		list->func(list);
+		list = next;
 	}
-	rcu_check_quiescent_state(rcp, rsp, rdp);
-	if (rdp->donelist)
-		rcu_do_batch(rdp);
-}
-
-static void rcu_process_callbacks(unsigned long unused)
-{
-	__rcu_process_callbacks(&rcu_ctrlblk, &rcu_state,
-				&__get_cpu_var(rcu_data));
-	__rcu_process_callbacks(&rcu_bh_ctrlblk, &rcu_bh_state,
-				&__get_cpu_var(rcu_bh_data));
 }
 
 void rcu_check_callbacks(int cpu, int user)
 {
-	if (user || 
-	    (idle_cpu(cpu) && !in_softirq() && 
-				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
-		rcu_qsctr_inc(cpu);
-		rcu_bh_qsctr_inc(cpu);
-	} else if (!in_softirq())
-		rcu_bh_qsctr_inc(cpu);
-	tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
-}
-
-static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp,
-						struct rcu_data *rdp)
-{
-	memset(rdp, 0, sizeof(*rdp));
-	rdp->curtail = &rdp->curlist;
-	rdp->nxttail = &rdp->nxtlist;
-	rdp->donetail = &rdp->donelist;
-	rdp->quiescbatch = rcp->completed;
-	rdp->qs_pending = 0;
-	rdp->cpu = cpu;
-}
-
-static void __devinit rcu_online_cpu(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	struct rcu_data *bh_rdp = &per_cpu(rcu_bh_data, cpu);
-
-	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
-	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
-	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
-}
-
-static int __devinit rcu_cpu_notify(struct notifier_block *self, 
-				unsigned long action, void *hcpu)
-{
-	long cpu = (long)hcpu;
-	switch (action) {
-	case CPU_UP_PREPARE:
-		rcu_online_cpu(cpu);
-		break;
-	case CPU_DEAD:
-		rcu_offline_cpu(cpu);
-		break;
-	default:
-		break;
+	if ((unsigned long)(jiffies - rcu_ctrlblk.last_sk) > 
+	    HZ/GRACE_PERIODS_PER_SEC) {
+		synchronize_kernel();
+		rcu_advance_callbacks();
+		rcu_process_callbacks();
 	}
-	return NOTIFY_OK;
 }
 
-static struct notifier_block __devinitdata rcu_nb = {
-	.notifier_call	= rcu_cpu_notify,
-};
-
-/*
- * Initializes rcu mechanism.  Assumed to be called early.
- * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
- * Note that rcu_qsctr and friends are implicitly
- * initialized due to the choice of ``0'' for RCU_CTR_INVALID.
- */
-void __init rcu_init(void)
+int rcu_pending(int cpu)
 {
-	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
-			(void *)(long)smp_processor_id());
-	/* Register notifier for non-boot CPUs */
-	register_cpu_notifier(&rcu_nb);
-}
-
-struct rcu_synchronize {
-	struct rcu_head head;
-	struct completion completion;
-};
-
-/* Because of FASTCALL declaration of complete, we use this wrapper */
-static void wakeme_after_rcu(struct rcu_head  *head)
-{
-	struct rcu_synchronize *rcu;
-
-	rcu = container_of(head, struct rcu_synchronize, head);
-	complete(&rcu->completion);
-}
-
-/**
- * synchronize_kernel - wait until a grace period has elapsed.
- *
- * Control will return to the caller some time after a full grace
- * period has elapsed, in other words after all currently executing RCU
- * read-side critical sections have completed.  RCU read-side critical
- * sections are delimited by rcu_read_lock() and rcu_read_unlock(),
- * and may be nested.
- */
-void synchronize_kernel(void)
-{
-	struct rcu_synchronize rcu;
-
-	init_completion(&rcu.completion);
-	/* Will wake me after RCU finished */
-	call_rcu(&rcu.head, wakeme_after_rcu);
+	unsigned long flags;
+	struct rcu_data *rdp;
+	int retval;
 
-	/* Wait for it */
-	wait_for_completion(&rcu.completion);
+	local_irq_save(flags);
+	rdp = &__get_cpu_var(rcu_data);
+	retval = (rdp->waitlist || rdp->donelist);
+	local_irq_restore(flags);
+	return (retval);
 }
 
-module_param(maxbatch, int, 0);
 EXPORT_SYMBOL(call_rcu);
-EXPORT_SYMBOL(call_rcu_bh);
 EXPORT_SYMBOL(synchronize_kernel);

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rcupdate.h"

/*
 * Read-Copy Update mechanism for mutual exclusion 
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (C) IBM Corporation, 2001
 *
 * Author: Dipankar Sarma <dipankar@in.ibm.com>
 * 
 * Based on the original work by Paul McKenney <paul.mckenney@us.ibm.com>
 * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
 * Papers:
 * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
 * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
 *
 * For detailed explanation of Read-Copy Update mechanism see -
 * 		http://lse.sourceforge.net/locking/rcupdate.html
 *
 */

#ifndef __LINUX_RCUPDATE_H
#define __LINUX_RCUPDATE_H

#ifdef __KERNEL__

#include <linux/cache.h>
#include <linux/spinlock.h>
#include <linux/threads.h>
#include <linux/percpu.h>
#include <linux/cpumask.h>
#include <linux/seqlock.h>

/**
 * struct rcu_head - callback structure for use with RCU
 * @next: next update requests in a list
 * @func: actual update function to call after the grace period.
 */
struct rcu_head {
	struct rcu_head *next;
	void (*func)(struct rcu_head *head);
};

#define RCU_HEAD_INIT(head) { .next = NULL, .func = NULL }
#define RCU_HEAD(head) struct rcu_head head = RCU_HEAD_INIT(head)
#define INIT_RCU_HEAD(ptr) do { \
       (ptr)->next = NULL; (ptr)->func = NULL; \
} while (0)

#define rcu_read_lock_bh() rcu_read_lock()
#define rcu_read_unlock_bh() rcu_read_unlock()
#define call_rcu_bh(head, func) call_rcu(head, func)
#define rcu_bh_qsctr_inc(cpu)
#define rcu_qsctr_inc(cpu)

/**
 * rcu_dereference - fetch an RCU-protected pointer in an
 * RCU read-side critical section.  This pointer may later
 * be safely dereferenced.
 *
 * Inserts memory barriers on architectures that require them
 * (currently only the Alpha), and, more importantly, documents
 * exactly which pointers are protected by RCU.
 */

#define rcu_dereference(p)     ({ \
				typeof(p) _________p1 = p; \
				smp_read_barrier_depends(); \
				(_________p1); \
				})

/**
 * rcu_assign_pointer - assign (publicize) a pointer to a newly
 * initialized structure that will be dereferenced by RCU read-side
 * critical sections.  Returns the value assigned.
 *
 * Inserts memory barriers on architectures that require them
 * (pretty much all of them other than x86), and also prevents
 * the compiler from reordering the code that initializes the
 * structure after the pointer assignment.  More importantly, this
 * call documents which pointers will be dereferenced by RCU read-side
 * code.
 */

#define rcu_assign_pointer(p, v)	({ \
						smp_wmb(); \
						(p) = (v); \
					})

extern void rcu_init(void);

/* Exported interfaces */
extern void FASTCALL(call_rcu(struct rcu_head *head, 
				void (*func)(struct rcu_head *head)));
extern void rcu_read_lock(void);
extern void rcu_read_unlock(void);
extern void synchronize_kernel(void);
extern int rcu_pending(int cpu);
extern void rcu_check_callbacks(int cpu, int user);

#endif /* __KERNEL__ */
#endif /* __LINUX_RCUPDATE_H */

--0ntfKIWw70PvrIHh
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="rcupdate.c"

/*
 * Read-Copy Update mechanism for mutual exclusion
 *
 * This program is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA.
 *
 * Copyright (C) IBM Corporation, 2001
 *
 * Authors: Dipankar Sarma <dipankar@in.ibm.com>
 *	    Manfred Spraul <manfred@colorfullife.com>
 * 
 * Based on the original work by Paul McKenney <paulmck@us.ibm.com>
 * and inputs from Rusty Russell, Andrea Arcangeli and Andi Kleen.
 * Papers:
 * http://www.rdrop.com/users/paulmck/paper/rclockpdcsproof.pdf
 * http://lse.sourceforge.net/locking/rclock_OLS.2001.05.01c.sc.pdf (OLS2001)
 *
 * For detailed explanation of Read-Copy Update mechanism see -
 * 		http://lse.sourceforge.net/locking/rcupdate.html
 *
 */
#include <linux/types.h>
#include <linux/kernel.h>
#include <linux/init.h>
#include <linux/spinlock.h>
#include <linux/smp.h>
#include <linux/interrupt.h>
#include <linux/sched.h>
#include <asm/atomic.h>
#include <linux/bitops.h>
#include <linux/module.h>
#include <linux/completion.h>
#include <linux/moduleparam.h>
#include <linux/percpu.h>
#include <linux/notifier.h>
#include <linux/rcupdate.h>
#include <linux/cpu.h>

#define GRACE_PERIODS_PER_SEC 10

struct rcu_data {
	rwlock_t	lock;
	long		batch;
	struct rcu_head	*waitlist;
	struct rcu_head	**waittail;
	struct rcu_head	*donelist;
	struct rcu_head	**donetail;
};
struct rcu_ctrlblk {
	long		batch;
	unsigned long	last_sk;
};
DEFINE_PER_CPU(struct rcu_data, rcu_data) = {
	.lock = RW_LOCK_UNLOCKED,
	.batch = 0,
	.waitlist = NULL,
	.donelist = NULL
};
struct rcu_ctrlblk rcu_ctrlblk = {
	.batch = 0,
};

void rcu_init(void)
{
	int cpu;
	struct rcu_data *rdp;

	for_each_cpu(cpu) {
		rdp = &per_cpu(rcu_data, cpu);
		rdp->waittail = &rdp->waitlist;
		rdp->donetail = &rdp->donelist;
	}
}

void rcu_read_lock(void)
{
	unsigned long flags;

	local_irq_save(flags);  /* allow invocation from OOM handler. */
	if (current->rcu_read_lock_nesting++ == 0) {
		current->rcu_read_lock_ptr = &__get_cpu_var(rcu_data).lock;
		read_lock(current->rcu_read_lock_ptr);
	}
	local_irq_restore(flags);
}

void rcu_read_unlock(void)
{
	unsigned long flags;

	local_irq_save(flags);  /* allow invocation from OOM handler. */
	if (--current->rcu_read_lock_nesting == 0) {
		read_unlock(current->rcu_read_lock_ptr);
	}
	local_irq_restore(flags);
}

void _synchronize_kernel(void)
{
	int cpu;
	unsigned long flags;

	local_irq_save(flags);  /* allow invocation from OOM handler. */
	for_each_cpu(cpu) {  /* _online() or _present() races with hotplug */
		write_lock(per_cpu(rcu_data, cpu));
	}
	rcu_ctrlblk.batch++;
	rcu_ctrlblk.last_sk = jiffies;
	for_each_cpu(cpu) {
		write_unlock(per_cpu(rcu_data, cpu));
	}
	local_irq_restore(flags);
}

void synchronize_kernel(void)
{
	long oldbatch;

	smp_mb();
	oldbatch = rcu_ctrlblk.batch;
	schedule_timeout(HZ/GRACE_PERIODS_PER_SEC);
	if (rcu_ctrlblk.batch == oldbatch) {
		_synchronize_kernel();
	}
}

void rcu_advance_callbacks(void)
{
	unsigned long flags;
	struct rcu_data *rdp;

	local_irq_save(flags);  /* allow invocation from OOM handler. */
	rdp = &__get_cpu_var(rcu_data);
	smp_mb();	/* prevent sampling batch # before list removal. */
	if (rdp->batch != rcu_ctrlblk.batch) {
		*rdp->donetail = rdp->waitlist;
		rdp->donetail = rdp->waittail;
		rdp->waitlist = NULL;
		rdp->waittail = &rdp->waitlist;
		rdp->batch = rcu_ctrlblk.batch;
	}
	local_irq_restore(flags);
}

void call_rcu(struct rcu_head *head,
	 void (*func)(struct rcu_head *rcu))
{
	unsigned long flags;
	struct rcu_data *rdp;

	head->func = func;
	head->next = NULL;
	local_irq_save(flags);
	rcu_advance_callbacks();
	rdp = &__get_cpu_var(rcu_data);
	*rdp->waittail = head;
	rdp->waittail = &head->next;
	local_irq_restore(flags);
}

void rcu_process_callbacks(void)
{
	unsigned long flags;
	struct rcu_head *next, *list;
	struct rcu_data *rdp;

	local_irq_save(flags);
	rdp = &__get_cpu_var(rcu_data);
	list = rdp->donelist;
	if (list == NULL) {
		local_irq_restore(flags);
		return;
	}
	rdp->donelist = NULL;
	rdp->donetail = &rdp->waitlist;
	local_irq_restore(flags);
	while (list) {
		next = list->next;
		list->func(list);
		list = next;
	}
}

void rcu_check_callbacks(int cpu, int user)
{
	if ((unsigned long)(jiffies - rcu_ctrlblk.last_sk) > 
	    HZ/GRACE_PERIODS_PER_SEC) {
		synchronize_kernel();
		rcu_advance_callbacks();
		rcu_process_callbacks();
	}
}

int rcu_pending(int cpu)
{
	unsigned long flags;
	struct rcu_data *rdp;
	int retval;

	local_irq_save(flags);
	rdp = &__get_cpu_var(rcu_data);
	retval = (rdp->waitlist || rdp->donelist);
	local_irq_restore(flags);
	return (retval);
}

EXPORT_SYMBOL(call_rcu);
EXPORT_SYMBOL(synchronize_kernel);

--0ntfKIWw70PvrIHh--
