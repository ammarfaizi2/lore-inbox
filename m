Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268241AbUHFTWF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268241AbUHFTWF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Aug 2004 15:22:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268237AbUHFTWE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Aug 2004 15:22:04 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:50102 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S268241AbUHFTVE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Aug 2004 15:21:04 -0400
Date: Sun, 8 Aug 2004 00:48:41 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       "Paul E. McKenney" <paulmck@us.ibm.com>, linux-kernel@vger.kernel.org,
       Robert Olsson <Robert.Olsson@data.slu.se>, netdev@oss.sgi.com
Subject: Re: RCU : Introduce call_rcu_bh() [2/5]
Message-ID: <20040807191841.GC3936@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040807191536.GA3936@in.ibm.com> <20040807191729.GB3936@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040807191729.GB3936@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduces call_rcu_bh() to be used when critical sections are
mostly in softirq context.

Thanks
Dipankar


This patch introduces a new api - call_rcu_bh(). This is to be used
for RCU callbacks for whom the critical sections are mostly
in softirq context. These callbacks consider completion of a
softirq handler to be a quiescent state. So, in order to make
reader critical sections safe in process context, rcu_read_lock_bh()
and rcu_read_unlock_bh() must be used. Use of softirq handler
completion as a quiescent state speeds up RCU grace periods
and prevents too many callbacks getting queued up in softirq-heavy
workloads like network stack.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 include/linux/rcupdate.h |   14 +++++++++++-
 kernel/rcupdate.c        |   52 ++++++++++++++++++++++++++++++++++++++++++-----
 kernel/softirq.c         |    7 +++++-
 3 files changed, 66 insertions(+), 7 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-call-rcu-bh include/linux/rcupdate.h
--- linux-2.6.8-rc3-mm1/include/linux/rcupdate.h~rcu-call-rcu-bh	2004-08-07 15:28:51.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/include/linux/rcupdate.h	2004-08-07 15:28:51.000000000 +0530
@@ -105,7 +105,9 @@ struct rcu_data {
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
+DECLARE_PER_CPU(struct rcu_data, rcu_bh_data);
 extern struct rcu_ctrlblk rcu_ctrlblk;
+extern struct rcu_ctrlblk rcu_bh_ctrlblk;
 
 /*
  * Increment the quiscent state counter.
@@ -115,6 +117,11 @@ static inline void rcu_qsctr_inc(int cpu
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
 	rdp->qsctr++;
 }
+static inline void rcu_bh_qsctr_inc(int cpu)
+{
+	struct rcu_data *rdp = &per_cpu(rcu_bh_data, cpu);
+	rdp->qsctr++;
+}
 
 static inline int __rcu_pending(struct rcu_ctrlblk *rcp,
 						struct rcu_data *rdp) 
@@ -143,11 +150,14 @@ static inline int __rcu_pending(struct r
 
 static inline int rcu_pending(int cpu)
 {
-	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu));
+	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
+		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
 
 #define rcu_read_lock()		preempt_disable()
 #define rcu_read_unlock()	preempt_enable()
+#define rcu_read_lock_bh()	local_bh_disable()
+#define rcu_read_unlock_bh()	local_bh_enable()
 
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
@@ -156,6 +166,8 @@ extern void rcu_restart_cpu(int cpu);
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
 				void (*func)(struct rcu_head *head)));
+extern void FASTCALL(call_rcu_bh(struct rcu_head *head, 
+				void (*func)(struct rcu_head *head)));
 extern void synchronize_kernel(void);
 
 #endif /* __KERNEL__ */
diff -puN kernel/rcupdate.c~rcu-call-rcu-bh kernel/rcupdate.c
--- linux-2.6.8-rc3-mm1/kernel/rcupdate.c~rcu-call-rcu-bh	2004-08-07 15:28:51.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/kernel/rcupdate.c	2004-08-07 15:28:51.000000000 +0530
@@ -50,6 +50,8 @@
 /* Definition for rcupdate control block. */
 struct rcu_ctrlblk rcu_ctrlblk = 
 	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
+struct rcu_ctrlblk rcu_bh_ctrlblk = 
+	{ .cur = -300, .completed = -300 , .lock = SEQCNT_ZERO };
 
 /* Bookkeeping of the progress of the grace period */
 struct rcu_state {
@@ -60,9 +62,11 @@ struct rcu_state {
 
 struct rcu_state rcu_state ____cacheline_maxaligned_in_smp =
 	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
-
+struct rcu_state rcu_bh_state ____cacheline_maxaligned_in_smp =
+	  {.lock = SPIN_LOCK_UNLOCKED, .cpumask = CPU_MASK_NONE };
 
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
+DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
 
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
@@ -93,6 +97,34 @@ void fastcall call_rcu(struct rcu_head *
 	local_irq_restore(flags);
 }
 
+/**
+ * call_rcu_bh - Queue an RCU update request for which softirq handler
+ * completion is a quiescent state.
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ *
+ * The update function will be invoked as soon as all CPUs have performed 
+ * a context switch or been seen in the idle loop or in a user process
+ * or has exited a softirq handler that it may have been executing.
+ * The read-side of critical section that use call_rcu_bh() for updation must 
+ * be protected by rcu_read_lock_bh()/rcu_read_unlock_bh() if it is
+ * in process context.
+ */
+void fastcall call_rcu_bh(struct rcu_head *head,
+				void (*func)(struct rcu_head *rcu))
+{
+	unsigned long flags;
+	struct rcu_data *rdp;
+
+	head->func = func;
+	head->next = NULL;
+	local_irq_save(flags);
+	rdp = &__get_cpu_var(rcu_bh_data);
+	*rdp->nxttail = head;
+	rdp->nxttail = &head->next;
+	local_irq_restore(flags);
+}
+
 /*
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
@@ -249,10 +281,14 @@ static void __rcu_offline_cpu(struct rcu
 static void rcu_offline_cpu(int cpu)
 {
 	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
+	struct rcu_data *this_bh_rdp = &get_cpu_var(rcu_bh_data);
 
 	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk, &rcu_state,
 					&per_cpu(rcu_data, cpu));
+	__rcu_offline_cpu(this_rdp, &rcu_bh_ctrlblk, &rcu_bh_state,
+					&per_cpu(rcu_bh_data, cpu));
 	put_cpu_var(rcu_data);
+	put_cpu_var(rcu_bh_data);
 	tasklet_kill_immediate(&per_cpu(rcu_tasklet, cpu), cpu);
 }
 
@@ -315,16 +351,20 @@ static void rcu_process_callbacks(unsign
 {
 	__rcu_process_callbacks(&rcu_ctrlblk, &rcu_state, 
 				&__get_cpu_var(rcu_data));
+	__rcu_process_callbacks(&rcu_bh_ctrlblk, &rcu_bh_state, 
+				&__get_cpu_var(rcu_bh_data));
 }
 
 void rcu_check_callbacks(int cpu, int user)
 {
-	struct rcu_data *rdp = &__get_cpu_var(rcu_data);
 	if (user || 
 	    (idle_cpu(cpu) && !in_softirq() && 
-				hardirq_count() <= (1 << HARDIRQ_SHIFT)))
-		rdp->qsctr++;
-	tasklet_schedule(&per_cpu(rcu_tasklet, rdp->cpu));
+				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
+		rcu_qsctr_inc(cpu);
+		rcu_bh_qsctr_inc(cpu);
+	} else if (!in_softirq())
+		rcu_bh_qsctr_inc(cpu);
+	tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
 }
 
 static void rcu_init_percpu_data(int cpu, struct rcu_ctrlblk *rcp, 
@@ -342,8 +382,10 @@ static void rcu_init_percpu_data(int cpu
 static void __devinit rcu_online_cpu(int cpu)
 {
 	struct rcu_data *rdp = &per_cpu(rcu_data, cpu);
+	struct rcu_data *bh_rdp = &per_cpu(rcu_bh_data, cpu);
 
 	rcu_init_percpu_data(cpu, &rcu_ctrlblk, rdp);
+	rcu_init_percpu_data(cpu, &rcu_bh_ctrlblk, bh_rdp);
 	tasklet_init(&per_cpu(rcu_tasklet, cpu), rcu_process_callbacks, 0UL);
 }
 
diff -puN kernel/softirq.c~rcu-call-rcu-bh kernel/softirq.c
--- linux-2.6.8-rc3-mm1/kernel/softirq.c~rcu-call-rcu-bh	2004-08-07 15:28:51.000000000 +0530
+++ linux-2.6.8-rc3-mm1-dipankar/kernel/softirq.c	2004-08-07 15:28:51.000000000 +0530
@@ -15,6 +15,7 @@
 #include <linux/percpu.h>
 #include <linux/cpu.h>
 #include <linux/kthread.h>
+#include <linux/rcupdate.h>
 
 #include <asm/irq.h>
 /*
@@ -75,10 +76,12 @@ asmlinkage void __do_softirq(void)
 	struct softirq_action *h;
 	__u32 pending;
 	int max_restart = MAX_SOFTIRQ_RESTART;
+	int cpu;
 
 	pending = local_softirq_pending();
 
 	local_bh_disable();
+	cpu = smp_processor_id();
 restart:
 	/* Reset the pending bitmask before enabling irqs */
 	local_softirq_pending() = 0;
@@ -88,8 +91,10 @@ restart:
 	h = softirq_vec;
 
 	do {
-		if (pending & 1)
+		if (pending & 1) {
 			h->action(h);
+			rcu_bh_qsctr_inc(cpu);
+		}
 		h++;
 		pending >>= 1;
 	} while (pending);

_
