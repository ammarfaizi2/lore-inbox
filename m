Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268079AbUH3Nq4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268079AbUH3Nq4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Aug 2004 09:46:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268061AbUH3Nq4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Aug 2004 09:46:56 -0400
Received: from users.ccur.com ([208.248.32.211]:22893 "EHLO mig.iccur.com")
	by vger.kernel.org with ESMTP id S268079AbUH3NnU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Aug 2004 09:43:20 -0400
Subject: [RFC&PATCH] Alternative RCU implementation]
From: Jim Houston <jim.houston@ccur.com>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Organization: Concurrent Computer Corp.
Message-Id: <1093873222.984.12.camel@new.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-4) 
Date: 30 Aug 2004 09:40:24 -0400
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Aug 2004 13:43:17.0541 (UTC) FILETIME=[4E241550:01C48E97]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Everyone,

I sent this to the LKML on Friday, but it seems to have been
lost so I'm sending it again.

The attached patch against linux-2.6.8.1-mm4 is an experimental
implementation of RCU.

It uses an active synchronization between the rcu_read_lock(),
rcu_read_unlock(), and the code which starts a new RCU batch.  A RCU
batch can be started at an arbitrary point, and it will complete without
waiting for a timer driven poll.  This should help avoid large batches
and their adverse cache and latency effects.

I did this work because Concurrent encourages its customers to 
isolate critical realtime processes to their own cpu and shield
them from other processes and interrupts.  This includes disabling
the local timer interrupt.  The current RCU code relies on the local
timer to recognize quiescent states.  If it is disabled on any cpu,
RCU callbacks are never called and the system bleeds memory and hangs
on calls to synchronize_kernel().

The main idea from the patch is to synchronize between the
read-side critical section and the code that starts an rcu batch.
Any code which is not protected by rcu_read_lock()/rcu_read_unlock()
is assumed to be a quiescent state.

Here is a slightly simplified version of the code:

static inline void rcu_read_lock(void)
{
	...
	r->flags = IN_RCU_READ_LOCK;
}

static inline void rcu_read_unlock(void)
{
	...
	flags = xchg(&r->flags, 0);
	if (flags & DO_RCU_COMPLETION)
		rcu_quiescent(cpu);
	...
}

void rcu_poll_other_cpus(void)
{
	for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; 
		cpu = next_cpu(cpu, cpu_online_map)) {
		r = &per_cpu(rcu_data, cpu);
		flags = cmpxchg(&r->flags, IN_RCU_READ_LOCK, 
				IN_RCU_READ_LOCK | DO_RCU_COMPLETION);
		if (!flags)
			cpu_clear(cpu, rcu_state.rcu_cpu_mask);
	}
	if (cpus_empty(rcu_state.rcu_cpu_mask))
		rcu_grace_period_complete();
}

I move the work normally done by the local timer to the code which
starts the RCU batch and to the rcu_read_unlock().  I added code to
rcu_call to maintain a count of callbacks queued in the nxtlist and
to start a new batch when the count exceeds a limit.

The patch borrows the krcud daemon which Dipankar proposed earlier
this year.  This is useful because I don't want to poll for the
RCU batch completions.  I may recognize that a grace period has
completed in either the code which starts the batch called from
call_rcu() or in rcu_quiescent() called from rcu_read_unlock().
Since I want to avoid timer based polling to recognize RCU batch
completions, I have the processor which completes the grace period
call rcu_wake_daemon() for each processor which has callbacks queued. 

I expect the current patch to scale reasonably well.  The
code in rcu_poll_other_cpus() does a cmpxchg() to determine
if each of the other cpus is in the read side critical section.
If they are, it exchanges in a value which requests that the
rcu_read_unlock() call rcu_quiescent() to help complete the grace
period.  Only processors caught in the read-side critical section
need to participate in the rendezvous.  Currently rcu_poll_other_cpus()
clears the rcu_cpu_mask bits as it finds cpus not in the read-side
critical section.  This could be optimized to reduce cache line 
bouncing by saving this state in a local bitmap.  To do this cleanly
would require an atomic cpu_and operation.  It would only need to be
atomic on a word by word basis. 

The fraction of time that a processor spends in the read-side critical
section effects the overhead of starting a batch.  In the case where 
rcu_poll_other_cpus() finds the other processor is not in the read-side
critical section the overhead is a single cache miss.  If the other
processor is in the critical section, there will be 3-4 cache misses.
One for the rcu_poll_other_cpus() read and cmpxchg(), one for
rcu_read_unlock() to reread its rcu_data structure, and one to update
the rcu_cpu_mask.  

I just started testing and so far only on a dual processor Opteron.
The early results are encouraging.  I wrote a couple quick tests
which exercise the dcache paths.  One simply loops doing 60 million
opens and closes.  The second creates a file and then renames it
10 million times.  There isn't a noticeable difference running these
programs on the standard kernel or with my changes.  Running the
tests with Oprofile shows that rcu_read_lock() and rcu_read_unlock()
combined used about 1% of the cpu.

Jim Houston - Concurrent Computer Corp.

--

diff -urN -X dontdiff linux-2.6.8.1-mm4.orig/include/linux/rcupdate.h linux-2.6.8.1-mm4/include/linux/rcupdate.h
--- linux-2.6.8.1-mm4.orig/include/linux/rcupdate.h	2004-08-25 10:14:31.000000000 -0400
+++ linux-2.6.8.1-mm4/include/linux/rcupdate.h	2004-08-26 17:13:22.000000000 -0400
@@ -40,7 +40,7 @@
 #include <linux/threads.h>
 #include <linux/percpu.h>
 #include <linux/cpumask.h>
-#include <linux/seqlock.h>
+#include <linux/interrupt.h>
 
 /**
  * struct rcu_head - callback structure for use with RCU
@@ -58,15 +58,18 @@
        (ptr)->next = NULL; (ptr)->func = NULL; \
 } while (0)
 
-
-
-/* Global control variables for rcupdate callback mechanism. */
-struct rcu_ctrlblk {
-	long	cur;		/* Current batch number.                      */
-	long	completed;	/* Number of the last completed batch         */
-	int	next_pending;	/* Is the next batch already waiting?         */
-	seqcount_t lock;	/* For atomic reads of cur and next_pending.  */
-} ____cacheline_maxaligned_in_smp;
+/*
+ * The rcu_batch variable contains the current batch number
+ * and the following flags.  The RCU_NEXT_PENDING bit requests that
+ * a new batch should start when the current batch completes.  The
+ * RCU_COMPLETE bit indicates that the most recent batch has completed
+ * and RCU processing has stopped.
+ */
+extern long rcu_batch;
+#define RCU_BATCH_MASK		(~3)
+#define RCU_INCREMENT		4
+#define RCU_COMPLETE		2
+#define RCU_NEXT_PENDING	1
 
 /* Is batch a before batch b ? */
 static inline int rcu_batch_before(long a, long b)
@@ -80,81 +83,85 @@
         return (a - b) > 0;
 }
 
+static inline int rcu_batch_complete(long batch)
+{
+	return(!rcu_batch_before((rcu_batch&~RCU_NEXT_PENDING), batch));
+}
+
+struct rcu_list {
+	struct rcu_head *head;
+	struct rcu_head **tail;
+};
+
+static inline void rcu_list_init(struct rcu_list *l)
+{
+	l->head = NULL;
+	l->tail = &l->head;
+}
+
+static inline void rcu_list_add(struct rcu_list *l, struct rcu_head *h)
+{
+	*l->tail = h;
+	l->tail = &h->next;
+}
+
+static inline void rcu_list_move(struct rcu_list *to, struct rcu_list *from)
+{
+	if (from->head) {
+		*to->tail = from->head;
+		to->tail = from->tail;
+		rcu_list_init(from);
+	}
+}
+
 /*
  * Per-CPU data for Read-Copy UPdate.
  * nxtlist - new callbacks are added here
  * curlist - current batch for which quiescent cycle started if any
  */
 struct rcu_data {
-	/* 1) quiescent state handling : */
-	long		quiescbatch;     /* Batch # for grace period */
-	long		qsctr;		 /* User-mode/idle loop etc. */
-	long            last_qsctr;	 /* value of qsctr at beginning */
-					 /* of rcu grace period */
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
+	/* 1) batch handling */
+	long  	       	batch;		/* batch # for current RCU batch */
+	unsigned long	nxtbatch;	/* batch # for next queue */
+	struct rcu_list nxt;
+	struct rcu_list cur;
+	struct rcu_list done;
+	long		nxtcount;	/* number of callbacks queued */
+	struct task_struct *krcud;
+
+	/* 2) synchronization between rcu_read_lock and rcu_start_batch. */
+	int		nest_count;	/* count of rcu_read_lock nesting */
+	int		flags;
 	struct rcu_head barrier;
 };
 
-DECLARE_PER_CPU(struct rcu_data, rcu_data);
-DECLARE_PER_CPU(struct rcu_data, rcu_bh_data);
-extern struct rcu_ctrlblk rcu_ctrlblk;
-extern struct rcu_ctrlblk rcu_bh_ctrlblk;
-
 /*
- * Increment the quiscent state counter.
+ * Flags values used to synchronize between rcu_read_lock/rcu_read_unlock
+ * and the rcu_start_batch.  Only processors executing rcu_read_lock
+ * protected code get invited to the rendezvous.
  */
-static inline void rcu_qsctr_inc(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	rdp->qsctr++;
-}
-static inline void rcu_bh_qsctr_inc(int cpu)
-{
-	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
-	rdp->qsctr++;
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
+#define	IN_RCU_READ_LOCK	1
+#define	DO_RCU_COMPLETION	2
 
-	/* This cpu has finished callbacks to invoke */
-	if (rdp->donelist)
-		return 1;
+DECLARE_PER_CPU(struct rcu_data, rcu_data);
 
-	/* The rcu core waits for a quiescent state from the cpu */
-	if (rdp->quiescbatch != rcp->cur || rdp->qs_pending)
-		return 1;
+extern void rcu_init(void);
+extern void rcu_restart_cpu(int cpu);
+extern void rcu_quiescent(int cpu);
+extern void rcu_poll(int cpu);
 
-	/* nothing to do */
-	return 0;
-}
-
-static inline int rcu_pending(int cpu)
-{
-	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
-		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
-}
+#undef INLINE
+#if INLINE_RCU_READ_LOCK
+#define INLINE static inline
+#else
+#ifdef RCUPDATE_C
+#define INLINE
+#endif
+extern void rcu_read_lock(void);
+extern void rcu_read_unlock(void);
+#endif
 
+#ifdef INLINE
 /**
  * rcu_read_lock - mark the beginning of an RCU read-side critical section.
  *
@@ -184,14 +191,38 @@
  *
  * It is illegal to block while in an RCU read-side critical section.
  */
-#define rcu_read_lock()		preempt_disable()
+INLINE void rcu_read_lock(void)
+{
+	struct rcu_data *r;
+
+	preempt_disable();
+	r = &per_cpu(rcu_data, smp_processor_id());
+	if (r->nest_count++ == 0)
+		r->flags = IN_RCU_READ_LOCK;
+}
 
 /**
  * rcu_read_unlock - marks the end of an RCU read-side critical section.
+ * Check if a RCU batch was started while we were in the critical
+ * section.  If so, call rcu_quiescent() join the rendezvous.
  *
  * See rcu_read_lock() for more information.
  */
-#define rcu_read_unlock()	preempt_enable()
+INLINE void rcu_read_unlock(void)
+{
+	struct rcu_data *r;
+	int	cpu, flags;
+
+	cpu = smp_processor_id();
+	r = &per_cpu(rcu_data, cpu);
+	if (--r->nest_count == 0) {
+		flags = xchg(&r->flags, 0);
+		if (flags & DO_RCU_COMPLETION)
+			rcu_quiescent(cpu);
+	}
+	preempt_enable();
+}
+#endif
 
 /*
  * So where is rcu_write_lock()?  It does not exist, as there is no
@@ -213,15 +244,17 @@
  * disabling softirqs. Read-side critical sections in interrupt context
  * can use just rcu_read_lock().
  *
+ * Hack alert.  I'm not sure if I understand the reason this interface
+ * is needed and if it is still needed with my implementation of RCU.
  */
-#define rcu_read_lock_bh()	local_bh_disable()
+#define rcu_read_lock_bh()	rcu_read_lock()
 
 /*
  * rcu_read_unlock_bh - marks the end of a softirq-only RCU critical section
  *
  * See rcu_read_lock_bh() for more information.
  */
-#define rcu_read_unlock_bh()	local_bh_enable()
+#define rcu_read_unlock_bh()	rcu_read_unlock()
 
 /**
  * rcu_dereference - fetch an RCU-protected pointer in an
@@ -239,10 +272,6 @@
 				(_________p1); \
 				})
 
-extern void rcu_init(void);
-extern void rcu_check_callbacks(int cpu, int user);
-extern void rcu_restart_cpu(int cpu);
-
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
 				void (*func)(struct rcu_head *head)));
diff -urN -X dontdiff linux-2.6.8.1-mm4.orig/init/main.c linux-2.6.8.1-mm4/init/main.c
--- linux-2.6.8.1-mm4.orig/init/main.c	2004-08-25 10:14:31.000000000 -0400
+++ linux-2.6.8.1-mm4/init/main.c	2004-08-27 08:49:46.000000000 -0400
@@ -510,10 +510,10 @@
 		   __stop___param - __start___param,
 		   &unknown_bootoption);
 	sort_main_extable();
-	rcu_init();
 	init_IRQ();
 	pidhash_init();
 	init_timers();
+	rcu_init();
 	softirq_init();
 	time_init();
 
@@ -648,12 +648,14 @@
 
 static void do_pre_smp_initcalls(void)
 {
+	extern int spawn_krcud(void);
 	extern int spawn_ksoftirqd(void);
 #ifdef CONFIG_SMP
 	extern int migration_init(void);
 
 	migration_init();
 #endif
+	spawn_krcud();
 	spawn_ksoftirqd();
 }
 
Binary files linux-2.6.8.1-mm4.orig/kernel/config_data.gz and linux-2.6.8.1-mm4/kernel/config_data.gz differ
diff -urN -X dontdiff linux-2.6.8.1-mm4.orig/kernel/rcupdate.c linux-2.6.8.1-mm4/kernel/rcupdate.c
--- linux-2.6.8.1-mm4.orig/kernel/rcupdate.c	2004-08-25 10:14:32.000000000 -0400
+++ linux-2.6.8.1-mm4/kernel/rcupdate.c	2004-08-27 08:51:29.000000000 -0400
@@ -29,6 +29,11 @@
  * For detailed explanation of Read-Copy Update mechanism see -
  * 		http://lse.sourceforge.net/locking/rcupdate.html
  *
+ * Modified by:  Jim Houston <jim.houston@ccur.com>
+ * 	This is a experimental version which uses explicit synchronization
+ *	between rcu_read_lock/rcu_read_unlock and rcu_poll_other_cpus()
+ *	to complete RCU batches without relying on timer based polling.
+ *
  */
 #include <linux/types.h>
 #include <linux/kernel.h>
@@ -44,38 +49,114 @@
 #include <linux/moduleparam.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
+#define RCUPDATE_C
 #include <linux/rcupdate.h>
 #include <linux/cpu.h>
+#include <linux/jiffies.h>
+#include <linux/kthread.h>
 
-/* Definition for rcupdate control block. */
-struct rcu_ctrlblk rcu_ctrlblk = 
-	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
-struct rcu_ctrlblk rcu_bh_ctrlblk =
-	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
+/*
+ * Definition for rcu_batch.  This variable includes the flags:
+ *	RCU_NEXT_PENDING 
+ * 		used to request that another batch should be 
+ *		started when the current batch completes.
+ *	RCU_COMPLETE
+ *		which indicates that the last batch completed and
+ *		that rcu callback processing is stopped.
+ *
+ * Combinning this state in a single word allows them to be maintained
+ * using an atomic exchange.
+ */
+long rcu_batch = (-300*RCU_INCREMENT)+RCU_COMPLETE;
+unsigned long rcu_timestamp;
 
 /* Bookkeeping of the progress of the grace period */
-struct rcu_state {
-	spinlock_t	lock; /* Guard this struct and writes to rcu_ctrlblk */
-	cpumask_t	cpumask; /* CPUs that need to switch in order    */
+struct {
+	cpumask_t	rcu_cpu_mask; /* CPUs that need to switch in order    */
 	                              /* for current batch to proceed.        */
-};
+} rcu_state ____cacheline_maxaligned_in_smp =
+	  { .rcu_cpu_mask = CPU_MASK_NONE };
 
-struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
-	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
-struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp =
-	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
 
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
-DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
 
-/* Fake initialization required by compiler */
-static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
-static int maxbatch = 10;
+/*
+ * Limits to control when new batchs of RCU callbacks are started.
+ */
+long rcu_max_count = 256;	
+unsigned long rcu_max_time = HZ/10;
+
+static void rcu_start_batch(void);
+
+/*
+ * rcu_set_state maintains the RCU_COMPLETE and RCU_NEXT_PENDING
+ * bits in rcu_batch.  Multiple processors might try to mark the
+ * current batch as complete, or start a new batch at the same time.
+ * The cmpxchg() makes the state transition atomic. rcu_set_state()
+ * returns the previous state.  This allows the caller to tell if
+ * it caused the state transition.
+ */
+
+int rcu_set_state(long state)
+{
+	long	batch, new, last;
+	do {
+		batch = rcu_batch;
+		if (batch & state)
+			return(batch & (RCU_COMPLETE|RCU_NEXT_PENDING));
+		new = batch | state;
+		last = cmpxchg(&rcu_batch, batch, new);
+	} while (unlikely(last != batch));
+	return(last & (RCU_COMPLETE|RCU_NEXT_PENDING));
+}
+
 
 static atomic_t rcu_barrier_cpu_count;
 static struct semaphore rcu_barrier_sema;
 static struct completion rcu_barrier_completion;
 
+/*
+ * If the batch in the nxt list or cur list has completed move it to the
+ * done list.  If its grace period for the nxt list has begun
+ * move the contents to the cur list.
+ */
+static int rcu_move_if_done(struct rcu_data *r)
+{
+	int done = 0;
+
+	if (r->cur.head && rcu_batch_complete(r->batch)) {
+		rcu_list_move(&r->done, &r->cur);
+		done = 1;
+	}
+	if (r->nxt.head) {
+		if (rcu_batch_complete(r->nxtbatch)) {
+			rcu_list_move(&r->done, &r->nxt);
+			r->nxtcount = 0;
+			done = 1;
+		} else if (r->nxtbatch == rcu_batch) {
+			/*
+			 * The grace period for the nxt list has started
+			 * move its content to the cur list.
+			 */
+			rcu_list_move(&r->cur, &r->nxt);
+			r->batch = r->nxtbatch;
+			r->nxtcount = 0;
+		}
+	}
+	return done;
+}
+
+/*
+ * Wake rcu daemon if it is not already running.
+ */
+void rcu_wake_daemon(struct rcu_data *r)
+{
+	struct task_struct *p = r->krcud;
+
+	if (p && p->state != TASK_RUNNING)
+		wake_up_process(p);
+}
+
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -90,47 +171,46 @@
 void fastcall call_rcu(struct rcu_head *head,
 				void (*func)(struct rcu_head *rcu))
 {
+	struct rcu_data *r;
 	unsigned long flags;
-	struct rcu_data *rdp;
+	int cpu;
 
 	head->func = func;
 	head->next = NULL;
 	local_irq_save(flags);
-	rdp = &__get_cpu_var(rcu_data);
-	*rdp->nxttail = head;
-	rdp->nxttail = &head->next;
+	cpu = smp_processor_id();
+	r = &per_cpu(rcu_data, cpu);
+	/*
+	 * Avoid mixing new entries with batches which have already
+	 * completed or have a grace period in progress.
+	 */
+	if (r->nxt.head && rcu_move_if_done(r))
+		rcu_wake_daemon(r);
+
+	rcu_list_add(&r->nxt, head);
+	if (r->nxtcount++ == 0) {
+		r->nxtbatch = (rcu_batch & RCU_BATCH_MASK) + RCU_INCREMENT;
+		barrier();
+		if (!rcu_timestamp)
+			rcu_timestamp = jiffies ?: 1;
+	}
+	/* If we reach the limit start a batch. */
+	if (r->nxtcount > rcu_max_count) {
+		if (rcu_set_state(RCU_NEXT_PENDING) == RCU_COMPLETE) 
+			rcu_start_batch();
+	}
 	local_irq_restore(flags);
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
+/*
+ * Revisit - my patch treats any code not protected by rcu_read_lock(),
+ * rcu_read_unlock() as a quiescent state.  I suspect that the call_rcu_bh()
+ * interface is not needed.
  */
 void fastcall call_rcu_bh(struct rcu_head *head,
 				void (*func)(struct rcu_head *rcu))
 {
-	unsigned long flags;
-	struct rcu_data *rdp;
-
-	head->func = func;
-	head->next = NULL;
-	local_irq_save(flags);
-	rdp = &__get_cpu_var(rcu_bh_data);
-	*rdp->nxttail = head;
-	rdp->nxttail = &head->next;
-	local_irq_restore(flags);
+	call_rcu(head, func);
 }
 
 static void rcu_barrier_callback(struct rcu_head *notused)
@@ -169,171 +249,160 @@
 }
 EXPORT_SYMBOL(rcu_barrier);
 
+
 /*
- * Invoke the completed RCU callbacks. They are expected to be in
- * a per-cpu list.
+ * cpu went through a quiescent state since the beginning of the grace period.
+ * Clear it from the cpu mask and complete the grace period if it was the last
+ * cpu. Start another grace period if someone has further entries pending
  */
-static void rcu_do_batch(struct rcu_data *rdp)
-{
-	struct rcu_head *next, *list;
-	int count = 0;
 
-	list = rdp->donelist;
-	while (list) {
-		next = rdp->donelist = list->next;
-		list->func(list);
-		list = next;
-		if (++count >= maxbatch)
-			break;
-	}
-	if (!rdp->donelist)
-		rdp->donetail = &rdp->donelist;
-	else
-		tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
-}
+static void rcu_grace_period_complete(void)
+{
+	struct rcu_data *r;
+	int cpu, last;
 
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
-{
-	if (next_pending)
-		rcp->next_pending = 1;
-
-	if (rcp->next_pending &&
-			rcp->completed == rcp->cur) {
-		/* Can't change, since spin lock held. */
-		cpus_andnot(rsp->cpumask, cpu_online_map, nohz_cpu_mask);
-		write_seqcount_begin(&rcp->lock);
-		rcp->next_pending = 0;
-		rcp->cur++;
-		write_seqcount_end(&rcp->lock);
+	/*
+	 * Mark the batch as complete.  If RCU_COMPLETE was
+	 * already set we raced with another processor
+	 * and it will finish the completion processing.
+	 */
+	last = rcu_set_state(RCU_COMPLETE);
+	if (last & RCU_COMPLETE)
+		return;
+	/*
+	 * If RCU_NEXT_PENDING is set, start the new batch.
+	 */
+	if (last & RCU_NEXT_PENDING)
+		rcu_start_batch();
+	/*
+	 * Wake the krcud for any cpu which has requests queued.
+	 */
+	for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; 
+		cpu = next_cpu(cpu, cpu_online_map)) {
+		r = &per_cpu(rcu_data, cpu);
+		if (r->nxt.head || r->cur.head || r->done.head)
+			rcu_wake_daemon(r);
 	}
 }
 
 /*
- * cpu went through a quiescent state since the beginning of the grace period.
- * Clear it from the cpu mask and complete the grace period if it was the last
- * cpu. Start another grace period if someone has further entries pending
+ * rcu_quiescent() is called from rcu_read_unlock() when a 
+ * RCU batch was started while the rcu_read_lock/rcu_read_unlock
+ * critical section was executing.
  */
-static void cpu_quiet(int cpu, struct rcu_ctrlblk *rcp, struct rcu_state *rsp)
+
+void rcu_quiescent(int cpu)
 {
-	cpu_clear(cpu, rsp->cpumask);
-	if (cpus_empty(rsp->cpumask)) {
-		/* batch completed ! */
-		rcp->completed = rcp->cur;
-		rcu_start_batch(rcp, rsp, 0);
-	}
+	cpu_clear(cpu, rcu_state.rcu_cpu_mask);
+	if (cpus_empty(rcu_state.rcu_cpu_mask))
+		rcu_grace_period_complete();
 }
 
 /*
- * Check if the cpu has gone through a quiescent state (say context
- * switch). If so and if it already hasn't done so in this RCU
- * quiescent cycle, then indicate that it has done so.
- */
-static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
-			struct rcu_state *rsp, struct rcu_data *rdp)
-{
-	if (rdp->quiescbatch != rcp->cur) {
-		/* new grace period: record qsctr value. */
-		rdp->qs_pending = 1;
-		rdp->last_qsctr = rdp->qsctr;
-		rdp->quiescbatch = rcp->cur;
-		return;
+ * Check if the other cpus are in rcu_read_lock/rcu_read_unlock protected code.
+ * If not they are assumed to be quiescent and we can clear the bit in
+ * bitmap.  If not set DO_RCU_COMPLETION to request a quiescent point on
+ * the rcu_read_unlock.
+ */ 
+void rcu_poll_other_cpus(void)
+{
+	struct rcu_data *r;
+	int cpu, flags;
+
+	for (cpu = first_cpu(cpu_online_map); cpu < NR_CPUS; 
+		cpu = next_cpu(cpu, cpu_online_map)) {
+		r = &per_cpu(rcu_data, cpu);
+		/*
+		 * We could just do the cmpxchg() without checking
+		 * the flags value.  Using the if adds an extra bus
+		 * reference here but avoids invalidating the other
+		 * processors cache if the cmpxchg is not needed.
+		 */ 
+		if ((flags = r->flags) == IN_RCU_READ_LOCK)
+			flags = cmpxchg(&r->flags, IN_RCU_READ_LOCK, 
+				IN_RCU_READ_LOCK | DO_RCU_COMPLETION);
+		if (!flags)
+			cpu_clear(cpu, rcu_state.rcu_cpu_mask);
 	}
+	if (cpus_empty(rcu_state.rcu_cpu_mask))
+		rcu_grace_period_complete();
+}
 
-	/* Grace period already completed for this cpu?
-	 * qs_pending is checked instead of the actual bitmap to avoid
-	 * cacheline trashing.
-	 */
-	if (!rdp->qs_pending)
-		return;
-
-	/* 
-	 * Races with local timer interrupt - in the worst case
-	 * we may miss one quiescent state of that CPU. That is
-	 * tolerable. So no need to disable interrupts.
-	 */
-	if (rdp->qsctr == rdp->last_qsctr)
-		return;
-	rdp->qs_pending = 0;
-
-	spin_lock(&rsp->lock);
+/*
+ * Grace period handling:
+ * The grace period handling consists out of two steps:
+ * - A new grace period is started.
+ *   This is done by rcu_start_batch. The rcu_poll_other_cpus()
+ *   call drives the synchronization.  It loops checking if each
+ *   of the other cpus are executing in a rcu_read_lock/rcu_read_unlock
+ *   critical section.  The flags word for the cpus it finds in a
+ *   rcu_read_lock/rcu_read_unlock critical section will be updated to
+ *   request a rcu_quiescent() call.
+ * - Each of the cpus which were in the rcu_read_lock/rcu_read_unlock
+ *   critical section will eventually call rcu_quiescent() and clear
+ *   the bit corresponding to their cpu in rcu_state.rcu_cpu_mask.
+ * - The processor which clears the last bit wakes the krcud for
+ *   the cpus which have rcu callback requests queued.
+ *
+ * The process of starting a batch is arbitrated with the RCU_COMPLETE &
+ * RCU_NEXT_PENDING bits. These bits can be set in either order but the
+ * thread which sets the second bit must call rcu_start_batch().  
+ * Multiple processors might try to set these bits at the same time.
+ * By using cmpxchg() we can determine which processor actually set
+ * the bit and be sure that only a single thread trys to start the batch.
+ * 
+ */
+static void rcu_start_batch(void)
+{
+	long batch, new;
+
+	batch = rcu_batch;
+	BUG_ON((batch & (RCU_COMPLETE|RCU_NEXT_PENDING)) !=
+		(RCU_COMPLETE|RCU_NEXT_PENDING));
+	rcu_timestamp = 0;
+	barrier();
 	/*
-	 * rdp->quiescbatch/rcp->cur and the cpu bitmap can come out of sync
-	 * during cpu startup. Ignore the quiescent state.
+	 * nohz_cpu_mask can go away because only cpus executing
+	 * rcu_read_lock/rcu_read_unlock critical sections need to 
+	 * participate in the rendezvous.
 	 */
-	if (likely(rdp->quiescbatch == rcp->cur))
-		cpu_quiet(rdp->cpu, rcp, rsp);
-
-	spin_unlock(&rsp->lock);
+	cpus_andnot(rcu_state.rcu_cpu_mask, cpu_online_map, nohz_cpu_mask);
+	new = (batch & RCU_BATCH_MASK) + RCU_INCREMENT;
+	rcu_batch = new;
+	rcu_poll_other_cpus();
 }
 

+
 #ifdef CONFIG_HOTPLUG_CPU
 
-/* warning! helper for rcu_offline_cpu. do not use elsewhere without reviewing
- * locking requirements, the list it's pulling from has to belong to a cpu
- * which is dead and hence not processing interrupts.
- */
-static void rcu_move_batch(struct rcu_data *this_rdp, struct rcu_head *list,
-				struct rcu_head **tail)
+static void rcu_offline_cpu(int cpu)
 {
-	local_irq_disable();
-	*this_rdp->nxttail = list;
-	if (list)
-		this_rdp->nxttail = tail;
-	local_irq_enable();
-}
+	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
 
-static void __rcu_offline_cpu(struct rcu_data *this_rdp,
-	struct rcu_ctrlblk *rcp, struct rcu_state *rsp, struct rcu_data *rdp)
-{
+#if 0
+	/*
+	 * The cpu should not have been in a read side critical
+	 * section when it was removed.  So this code is not needed.
+	 */
 	/* if the cpu going offline owns the grace period
 	 * we can block indefinitely waiting for it, so flush
 	 * it here
 	 */
-	spin_lock_bh(&rsp->lock);
-	if (rcp->cur != rcp->completed)
-		cpu_quiet(rdp->cpu, rcp, rsp);
-	spin_unlock_bh(&rsp->lock);
-	rcu_move_batch(this_rdp, rdp->curlist, rdp->curtail);
-	rcu_move_batch(this_rdp, rdp->nxtlist, rdp->nxttail);
-
-}
-static void rcu_offline_cpu(int cpu)
-{
-	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
-	struct rcu_data *this_bh_rdp = &get_cpu_var(rcu_bh_data);
-
-	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk, &rcu_state,
-					&per_cpu(rcu_data, cpu));
-	__rcu_offline_cpu(this_bh_rdp, &rcu_bh_ctrlblk, &rcu_bh_state,
-					&per_cpu(rcu_bh_data, cpu));
+	if (!(rcu_batch & RCU_COMPLETE))
+		rcu_quiescent(cpu);
+#endif
+	local_irq_disable();
+	/*
+	 * The rcu lists are per-cpu private data only protected by
+	 * disabling interrupts.  Since we know the other cpu is dead
+	 * it should not be manipulating these lists.
+	 */
+	rcu_list_move(&this_rdp->nxt, &rdp->cur);
+	rcu_list_move(&this_rdp->nxt, &rdp->nxt);
+	r->nxtbatch = (rcu_batch & RCU_BATCH_MASK) + RCU_INCREMENT;
+	local_irq_enable();
 	put_cpu_var(rcu_data);
-	put_cpu_var(rcu_bh_data);
-	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
 }
 
 #else
@@ -345,108 +414,139 @@
 #endif
 
 /*
- * This does the RCU processing work from tasklet context. 
+ * Process the completed RCU callbacks.
  */
-static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
-			struct rcu_state *rsp, struct rcu_data *rdp)
+static void rcu_process_callbacks(struct rcu_data *r)
 {
-	if (rdp->curlist && !rcu_batch_before(rcp->completed, rdp->batch)) {
-		*rdp->donetail = rdp->curlist;
-		rdp->donetail = rdp->curtail;
-		rdp->curlist = NULL;
-		rdp->curtail = &rdp->curlist;
-	}
-
+	struct rcu_head *list, *next;
+	
 	local_irq_disable();
-	if (rdp->nxtlist && !rdp->curlist) {
-		int next_pending, seq;
-
-		rdp->curlist = rdp->nxtlist;
-		rdp->curtail = rdp->nxttail;
-		rdp->nxtlist = NULL;
-		rdp->nxttail = &rdp->nxtlist;
-		local_irq_enable();
+	rcu_move_if_done(r);
+	list = r->done.head;
+	rcu_list_init(&r->done);
+	local_irq_enable();
 
-		/*
-		 * start the next batch of callbacks
-		 */
-		do {
-			seq = read_seqcount_begin(&rcp->lock);
-			/* determine batch number */
-			rdp->batch = rcp->cur + 1;
-			next_pending = rcp->next_pending;
-		} while (read_seqcount_retry(&rcp->lock, seq));
-
-		if (!next_pending) {
-			/* and start it/schedule start if it's a new batch */
-			spin_lock(&rsp->lock);
-			rcu_start_batch(rcp, rsp, 1);
-			spin_unlock(&rsp->lock);
-		}
-	} else {
-		local_irq_enable();
+	while (list) {
+		next = list->next;
+		list->func(list);
+		list = next;
 	}
-	rcu_check_quiescent_state(rcp, rsp, rdp);
-	if (rdp->donelist)
-		rcu_do_batch(rdp);
 }
 
-static void rcu_process_callbacks(unsigned long unused)
+/*
+ * Poll rcu_timestamp to start a RCU batch if there are 
+ * any pending request which have been waiting longer
+ * than rcu_max_time.
+ */
+struct timer_list rcu_timer;
+
+void rcu_timeout(unsigned long unused)
 {
-	__rcu_process_callbacks(&rcu_ctrlblk, &rcu_state,
-				&__get_cpu_var(rcu_data));
-	__rcu_process_callbacks(&rcu_bh_ctrlblk, &rcu_bh_state,
-				&__get_cpu_var(rcu_bh_data));
+	if (rcu_timestamp && time_after(jiffies,(rcu_timestamp+rcu_max_time))) {
+		if (rcu_set_state(RCU_NEXT_PENDING) == RCU_COMPLETE) 
+			rcu_start_batch();
+	}
+	init_timer(&rcu_timer);
+	rcu_timer.expires = jiffies + (rcu_max_time/2?:1);
+	add_timer(&rcu_timer);
 }
 
-void rcu_check_callbacks(int cpu, int user)
+static void __devinit rcu_online_cpu(int cpu)
 {
-	if (user || 
-	    (idle_cpu(cpu) && !in_softirq() && 
-				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
-		rcu_qsctr_inc(cpu);
-		rcu_bh_qsctr_inc(cpu);
-	} else if (!in_softirq())
-		rcu_bh_qsctr_inc(cpu);
-	tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
+	struct rcu_data *r = &per_cpu(rcu_data, cpu);
+
+	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
+	rcu_list_init(&r->nxt);
+	rcu_list_init(&r->cur);
+	rcu_list_init(&r->done);
 }
 
-static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp,
-						struct rcu_data *rdp)
+static int rcu_pending(struct rcu_data *r)
 {
-	memset(rdp, 0, sizeof(*rdp));
-	rdp->curtail = &rdp->curlist;
-	rdp->nxttail = &rdp->nxtlist;
-	rdp->donetail = &rdp->donelist;
-	rdp->quiescbatch = rcp->completed;
-	rdp->qs_pending = 0;
-	rdp->cpu = cpu;
+	return(r->done.head || 
+		(r->cur.head && rcu_batch_complete(r->batch)) ||
+		(r->nxt.head && rcu_batch_complete(r->nxtbatch)));
 }
 
-static void __devinit rcu_online_cpu(int cpu)
+static int krcud(void * __bind_cpu)
 {
-	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
-	struct rcu_data *bh_rdp = &per_cpu(rcu_bh_data, cpu);
+	int cpu = (int)(long) __bind_cpu;
+	struct rcu_data *r = &per_cpu(rcu_data, cpu);
+
+	set_user_nice(current, 19);
+	current->flags |= PF_NOFREEZE;
+
+	set_current_state(TASK_INTERRUPTIBLE);
+
+	while (!kthread_should_stop()) {
+		if (!rcu_pending(r))
+			schedule();
 
-	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
-	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
-	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
+		__set_current_state(TASK_RUNNING);
+
+		while (rcu_pending(r)) {
+			/* Preempt disable stops cpu going offline.
+			   If already offline, we'll be on wrong CPU:
+			   don't process */
+			preempt_disable();
+			if (cpu_is_offline((long)__bind_cpu))
+				goto wait_to_die;
+			rcu_process_callbacks(r);
+			preempt_enable();
+			cond_resched();
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
+
+wait_to_die:
+	preempt_enable();
+	/* Wait for kthread_stop */
+	set_current_state(TASK_INTERRUPTIBLE);
+	while (!kthread_should_stop()) {
+		schedule();
+		set_current_state(TASK_INTERRUPTIBLE);
+	}
+	__set_current_state(TASK_RUNNING);
+	return 0;
 }
 
-static int __devinit rcu_cpu_notify(struct notifier_block *self, 
-				unsigned long action, void *hcpu)
+static int __devinit rcu_cpu_notify(struct notifier_block *nfb,
+				  unsigned long action,
+				  void *hcpu)
 {
-	long cpu = (long)hcpu;
+	int cpu = (unsigned long)hcpu;
+	struct rcu_data *r = &per_cpu(rcu_data, cpu);
+	struct task_struct *p;
+
 	switch (action) {
 	case CPU_UP_PREPARE:
 		rcu_online_cpu(cpu);
+		p = kthread_create(krcud, hcpu, "krcud/%d", cpu);
+		if (IS_ERR(p)) {
+			printk("krcud for %i failed\n", cpu);
+			return NOTIFY_BAD;
+		}
+		kthread_bind(p, cpu);
+  		r->krcud = p;
+ 		break;
+	case CPU_ONLINE:
+		wake_up_process(r->krcud);
 		break;
+#ifdef CONFIG_HOTPLUG_CPU
+	case CPU_UP_CANCELED:
+		/* Unbind so it can run.  Fall thru. */
+		kthread_bind(r->krcud, smp_processor_id());
 	case CPU_DEAD:
+		p = r->krcud;
+		r->krcud = NULL;
+		kthread_stop(p);
 		rcu_offline_cpu(cpu);
 		break;
-	default:
-		break;
-	}
+#endif /* CONFIG_HOTPLUG_CPU */
+ 	}
 	return NOTIFY_OK;
 }
 
@@ -454,6 +554,14 @@
 	.notifier_call	= rcu_cpu_notify,
 };
 
+__init int spawn_krcud(void)
+{
+	void *cpu = (void *)(long)smp_processor_id();
+	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE, cpu);
+	rcu_cpu_notify(&rcu_nb, CPU_ONLINE, cpu);
+	register_cpu_notifier(&rcu_nb);
+	return 0;
+}
 /*
  * Initializes rcu mechanism.  Assumed to be called early.
  * That is before local timer(SMP) or jiffie timer (uniproc) is setup.
@@ -463,12 +571,18 @@
 void __init rcu_init(void)
 {
 	sema_init(&rcu_barrier_sema, 1);
-	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
-			(void *)(long)smp_processor_id());
-	/* Register notifier for non-boot CPUs */
-	register_cpu_notifier(&rcu_nb);
+	rcu_online_cpu(smp_processor_id());
+	/*
+	 * Use a timer to catch the elephants which would otherwise
+	 * fall throught the cracks on local timer shielded cpus.
+	 */
+	init_timer(&rcu_timer);
+	rcu_timer.function = rcu_timeout;
+	rcu_timer.expires = jiffies + (rcu_max_time/2?:1);
+	add_timer(&rcu_timer);
 }
 
+
 struct rcu_synchronize {
 	struct rcu_head head;
 	struct completion completion;
@@ -504,7 +618,8 @@
 	wait_for_completion(&rcu.completion);
 }
 
-module_param(maxbatch, int, 0);
+module_param(rcu_max_count, long, 0644);
+module_param(rcu_max_time, long, 0644);
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(call_rcu_bh);
 EXPORT_SYMBOL(synchronize_kernel);
diff -urN -X dontdiff linux-2.6.8.1-mm4.orig/kernel/sched.c linux-2.6.8.1-mm4/kernel/sched.c
--- linux-2.6.8.1-mm4.orig/kernel/sched.c	2004-08-25 10:14:32.000000000 -0400
+++ linux-2.6.8.1-mm4/kernel/sched.c	2004-08-25 10:18:08.000000000 -0400
@@ -36,7 +36,9 @@
 #include <linux/delay.h>
 #include <linux/smp.h>
 #include <linux/timer.h>
+#if 0
 #include <linux/rcupdate.h>
+#endif
 #include <linux/cpu.h>
 #include <linux/cpuset.h>
 #include <linux/percpu.h>
@@ -2270,8 +2272,10 @@
 	rq->timestamp_last_tick = clock_us();
 #endif
 
+#if 0
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
+#endif
 
 	/* note: this timer irq context must be accounted for as well */
 	if (hardirq_count() - HARDIRQ_OFFSET) {
@@ -2583,7 +2587,9 @@
 switch_tasks:
 	prefetch(next);
 	clear_tsk_need_resched(prev);
+#if 0
 	rcu_qsctr_inc(task_cpu(prev));
+#endif
 
 	sched_info_switch(prev, next);
 	if (likely(prev != next)) {
diff -urN -X dontdiff linux-2.6.8.1-mm4.orig/kernel/softirq.c linux-2.6.8.1-mm4/kernel/softirq.c
--- linux-2.6.8.1-mm4.orig/kernel/softirq.c	2004-08-25 10:14:32.000000000 -0400
+++ linux-2.6.8.1-mm4/kernel/softirq.c	2004-08-25 10:18:08.000000000 -0400
@@ -93,7 +93,9 @@
 	do {
 		if (pending & 1) {
 			h->action(h);
+#if 0
 			rcu_bh_qsctr_inc(cpu);
+#endif
 		}
 		h++;
 		pending >>= 1;

