Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261204AbUCaVt5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 31 Mar 2004 16:49:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261168AbUCaVs7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 31 Mar 2004 16:48:59 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:58622 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S262634AbUCaVpi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 31 Mar 2004 16:45:38 -0500
Date: Thu, 1 Apr 2004 03:13:42 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: Robert Olsson <Robert.Olsson@data.slu.se>,
       "David S. Miller" <davem@redhat.com>, kuznet@ms2.inr.ac.ru,
       linux-kernel@vger.kernel.org, netdev@oss.sgi.com, paulmck@us.ibm.com,
       akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040331214342.GD4543@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040329222926.GF3808@dualathlon.random> <200403302005.AAA00466@yakov.inr.ac.ru> <20040330211450.GI3808@dualathlon.random> <20040330133000.098761e2.davem@redhat.com> <20040330213742.GL3808@dualathlon.random> <20040331171023.GA4543@in.ibm.com> <16491.4593.718724.277551@robur.slu.se> <20040331203750.GB4543@in.ibm.com> <20040331212817.GQ2143@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040331212817.GQ2143@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 31, 2004 at 11:28:17PM +0200, Andrea Arcangeli wrote:
> On Thu, Apr 01, 2004 at 02:07:50AM +0530, Dipankar Sarma wrote:
> > So, NAPI or not we get userland stalls due to packetflooding.
> 
> indeed, the most of the softirq load happens within irqs even with NAPI
> as we were talking about, so Alexey and DaveM were wrong about the
> hardirq load being non significant.
> 
> Maybe the problem is simply that NAPI should be tuned more aggressively,
> it may have to poll for a longer time before giving up.

Perhaps yes, but we still have softirqs from local_bh_enable()s to
deal with.

> > Looking at some of the old patches we discussed privately, it seems
> > this is what was done earlier -
> > 
> > 1. Use rcu-softirq.patch which provides call_rcu_bh() for softirqs
> >    only.
> 
> this is the one I prefer if it performs.

I just tried the attached patch (forward ported and some aggressive
things deleted) and there was no route cache overflow during
pktgen testing. So, this is a good approach, however this is
not going to solve userland stalls. 

Robert, btw, this rcu-softirq patch is slightly different
from the earlier one in the sense that now every softirq
handler completion is a quiescent point. Earlier each iteration
of softirqs was a quiescent point. So this has more quiescent
points.

> 
> > 2. Limit non-ksoftirqd softirqs - get a measure of userland stall (using
> >    an api rcu_grace_period(cpu)) and if it is too long, expire
> >    the timeslice of the current process  and start sending everything to 
> >    ksoftirqd.
> 
> yep, this may be desiderable eventually just to be fair with tasks, but
> I believe it's partly an orthogonal with the rcu grace period length.

Yes, it is. Delaying softirqs will delay RCU grace periods. But it
will also affect i/o throughput. So this is a balancing act anyway.

> > By reducing the softirq time at the back of a hardirq or local_bh_enable(),
> > we should be able to bring a bit more fairness. I am working on the
> > patches, will test and publish later. 
> 
> I consider this as the approch number 2 too.

Well, I don't really have #1 and #2. I think we need to understand
if there are the situations where such stalls are unacceptable
and if so fix softirqs for them. RCU OOMs we can probably work
around anyway.

Thanks
Dipankar



Provide a new call_rcu_bh() interface that can be used in softirq
only situations. Completion of a softirq handler is considered
a quiescent point apart from regular quiescent points. If there
is any read from process context, then it must be protected
by rcu_read_lock/unlock_bh().


 include/linux/rcupdate.h |   40 ++++++---
 kernel/rcupdate.c        |  207 ++++++++++++++++++++++++++++-------------------
 kernel/softirq.c         |   12 ++
 net/decnet/dn_route.c    |    6 -
 net/ipv4/route.c         |   28 +++---
 5 files changed, 183 insertions(+), 110 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-softirq include/linux/rcupdate.h
--- linux-2.6.0-rtcache/include/linux/rcupdate.h~rcu-softirq	2004-04-01 00:07:48.000000000 +0530
+++ linux-2.6.0-rtcache-dipankar/include/linux/rcupdate.h	2004-04-01 02:01:32.000000000 +0530
@@ -99,38 +99,56 @@ struct rcu_data {
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
+DECLARE_PER_CPU(struct rcu_data, rcu_bh_data);
 extern struct rcu_ctrlblk rcu_ctrlblk;
-
+extern struct rcu_ctrlblk rcu_bh_ctrlblk;
+  
 #define RCU_qsctr(cpu) 		(per_cpu(rcu_data, (cpu)).qsctr)
-#define RCU_last_qsctr(cpu) 	(per_cpu(rcu_data, (cpu)).last_qsctr)
-#define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
-#define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
-
+#define RCU_bh_qsctr(cpu) 	(per_cpu(rcu_bh_data, (cpu)).qsctr)
+#define RCU_bh_nxtlist(cpu) 	(per_cpu(rcu_bh_data, (cpu)).nxtlist)
+  
 #define RCU_QSCTR_INVALID	0
 
-static inline int rcu_pending(int cpu) 
+static inline int __rcu_pending(int cpu, struct rcu_ctrlblk *rcp, 
+						struct rcu_data *rdp)
 {
-	if ((!list_empty(&RCU_curlist(cpu)) &&
-	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
-	    (list_empty(&RCU_curlist(cpu)) &&
-			 !list_empty(&RCU_nxtlist(cpu))) ||
-	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
+	if ((!list_empty(&rdp->curlist) &&
+	     rcu_batch_before(rdp->batch, rcp->curbatch)) ||
+	    (list_empty(&rdp->curlist) &&
+			 !list_empty(&rdp->nxtlist)) ||
+	    cpu_isset(cpu, rcp->rcu_cpu_mask))
 		return 1;
 	else
 		return 0;
 }
+static inline int rcu_pending_bh(int cpu)
+{
+	return __rcu_pending(cpu, &rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
+}
+static inline int rcu_pending(int cpu)
+{
+	return __rcu_pending(cpu, &rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
+		__rcu_pending(cpu, &rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
+}
 
 #define rcu_read_lock()		preempt_disable()
 #define rcu_read_unlock()	preempt_enable()
+#define rcu_read_lock_bh()	local_bh_disable()
+#define rcu_read_unlock_bh()	local_bh_enable()
 
 extern void rcu_init(void);
 extern void rcu_check_callbacks(int cpu, int user);
+extern void rcu_process_callbacks_bh(int cpu);
 
 /* Exported interfaces */
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
                           void (*func)(void *arg), void *arg));
+extern void FASTCALL(call_rcu_bh(struct rcu_head *head,
+                          void (*func)(void *arg), void *arg));
 extern void synchronize_kernel(void);
 
+extern struct rcu_ctrlblk rcu_ctrlblk;
+
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */
diff -puN kernel/rcupdate.c~rcu-softirq kernel/rcupdate.c
--- linux-2.6.0-rtcache/kernel/rcupdate.c~rcu-softirq	2004-04-01 00:07:48.000000000 +0530
+++ linux-2.6.0-rtcache-dipankar/kernel/rcupdate.c	2004-04-01 00:53:29.000000000 +0530
@@ -51,6 +51,11 @@ struct rcu_ctrlblk rcu_ctrlblk = 
 	  .maxbatch = 1, .rcu_cpu_mask = CPU_MASK_NONE };
 DEFINE_PER_CPU(struct rcu_data, rcu_data) = { 0L };
 
+struct rcu_ctrlblk rcu_bh_ctrlblk = 
+	{ .mutex = SPIN_LOCK_UNLOCKED, .curbatch = 1, 
+	  .maxbatch = 1, .rcu_cpu_mask = 0 };
+DEFINE_PER_CPU(struct rcu_data, rcu_bh_data) = { 0L };
+
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
@@ -79,6 +84,30 @@ void call_rcu(struct rcu_head *head, voi
 	local_irq_restore(flags);
 }
 
+/**
+ * call_rcu_bh - Queue an RCU update request that is used only from softirqs
+ * @head: structure to be used for queueing the RCU updates.
+ * @func: actual update function to be invoked after the grace period
+ * @arg: argument to be passed to the update function
+ *
+ * The update function will be invoked as soon as all CPUs have performed 
+ * a context switch or been seen in the idle loop or in a user process or
+ * or has exited a softirq handler that it may have been executing.
+ * The read-side of critical section that use call_rcu_bh() for updation must 
+ * be protected by rcu_read_lock()/rcu_read_unlock().
+ */
+void call_rcu_bh(struct rcu_head *head, void (*func)(void *arg), void *arg)
+{
+	int cpu;
+
+	head->func = func;
+	head->arg = arg;
+	local_bh_disable();
+	cpu = smp_processor_id();
+	list_add_tail(&head->list, &RCU_bh_nxtlist(cpu));
+	local_bh_enable();
+}
+
 /*
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
@@ -101,16 +130,16 @@ static void rcu_do_batch(struct list_hea
  * active batch and the batch to be registered has not already occurred.
  * Caller must hold the rcu_ctrlblk lock.
  */
-static void rcu_start_batch(long newbatch)
+static void rcu_start_batch(struct rcu_ctrlblk *rcp, long newbatch)
 {
-	if (rcu_batch_before(rcu_ctrlblk.maxbatch, newbatch)) {
-		rcu_ctrlblk.maxbatch = newbatch;
-	}
-	if (rcu_batch_before(rcu_ctrlblk.maxbatch, rcu_ctrlblk.curbatch) ||
-	    !cpus_empty(rcu_ctrlblk.rcu_cpu_mask)) {
-		return;
-	}
-	rcu_ctrlblk.rcu_cpu_mask = cpu_online_map;
+	if (rcu_batch_before(rcp->maxbatch, newbatch)) {
+		rcp->maxbatch = newbatch;
+  	}
+	if (rcu_batch_before(rcp->maxbatch, rcp->curbatch) ||
+	    !cpus_empty(rcp->rcu_cpu_mask)) {
+  		return;
+  	}
+	rcp->rcu_cpu_mask = cpu_online_map;
 }
 
 /*
@@ -118,41 +147,73 @@ static void rcu_start_batch(long newbatc
  * switch). If so and if it already hasn't done so in this RCU
  * quiescent cycle, then indicate that it has done so.
  */
-static void rcu_check_quiescent_state(void)
+static void rcu_check_quiescent_state(struct rcu_ctrlblk *rcp,
+			struct rcu_data *rdp)
 {
-	int cpu = smp_processor_id();
-
-	if (!cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
-		return;
-
-	/* 
-	 * Races with local timer interrupt - in the worst case
-	 * we may miss one quiescent state of that CPU. That is
-	 * tolerable. So no need to disable interrupts.
-	 */
-	if (RCU_last_qsctr(cpu) == RCU_QSCTR_INVALID) {
-		RCU_last_qsctr(cpu) = RCU_qsctr(cpu);
-		return;
-	}
-	if (RCU_qsctr(cpu) == RCU_last_qsctr(cpu))
-		return;
-
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
-
+  	int cpu = smp_processor_id();
+  
+	if (!cpu_isset(cpu, rcp->rcu_cpu_mask))
+  		return;
+  
+	if (rdp->last_qsctr == RCU_QSCTR_INVALID) {
+		rdp->last_qsctr = rdp->qsctr;
+  		return;
+  	}
+	if (rdp->qsctr == rdp->last_qsctr)
+  		return;
+  
+	spin_lock(&rcp->mutex);
+	if (!cpu_isset(cpu, rcp->rcu_cpu_mask))
+  		goto out_unlock;
+  
+	cpu_clear(cpu, rcp->rcu_cpu_mask);
+	rdp->last_qsctr = RCU_QSCTR_INVALID;
+	if (!cpus_empty(rcp->rcu_cpu_mask))
+  		goto out_unlock;
+  
+	rcp->curbatch++;
+	rcu_start_batch(rcp, rcp->maxbatch);
+  
 out_unlock:
-	spin_unlock(&rcu_ctrlblk.mutex);
+	spin_unlock(&rcp->mutex);
+}
+  
+static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
+					struct rcu_data *rdp)
+{
+  	LIST_HEAD(list);
+  
+	if (!list_empty(&rdp->curlist) &&
+	    rcu_batch_after(rcp->curbatch, rdp->batch)) {
+		list_splice(&rdp->curlist, &list);
+		INIT_LIST_HEAD(&rdp->curlist);
+  	}
+  
+  	local_irq_disable();
+	if (!list_empty(&rdp->nxtlist) && list_empty(&rdp->curlist)) {
+		list_splice(&rdp->nxtlist, &rdp->curlist);
+		INIT_LIST_HEAD(&rdp->nxtlist);
+  		local_irq_enable();
+  
+  		/*
+  		 * start the next batch of callbacks
+  		 */
+		spin_lock(&rcp->mutex);
+		rdp->batch = rcp->curbatch + 1;
+		rcu_start_batch(rcp, rdp->batch);
+		spin_unlock(&rcp->mutex);
+  	} else {
+  		local_irq_enable();
+  	}
+	rcu_check_quiescent_state(rcp, rdp);
+  	if (!list_empty(&list))
+  		rcu_do_batch(&list);
+}
+  
+void rcu_process_callbacks_bh(int cpu)
+{
+	__rcu_process_callbacks(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
-
 
 /*
  * This does the RCU processing work from tasklet context. 
@@ -160,59 +221,38 @@ out_unlock:
 static void rcu_process_callbacks(unsigned long unused)
 {
 	int cpu = smp_processor_id();
-	LIST_HEAD(list);
-
-	if (!list_empty(&RCU_curlist(cpu)) &&
-	    rcu_batch_after(rcu_ctrlblk.curbatch, RCU_batch(cpu))) {
-		list_splice(&RCU_curlist(cpu), &list);
-		INIT_LIST_HEAD(&RCU_curlist(cpu));
-	}
-
-	local_irq_disable();
-	if (!list_empty(&RCU_nxtlist(cpu)) && list_empty(&RCU_curlist(cpu))) {
-		list_splice(&RCU_nxtlist(cpu), &RCU_curlist(cpu));
-		INIT_LIST_HEAD(&RCU_nxtlist(cpu));
-		local_irq_enable();
-
-		/*
-		 * start the next batch of callbacks
-		 */
-		spin_lock(&rcu_ctrlblk.mutex);
-		RCU_batch(cpu) = rcu_ctrlblk.curbatch + 1;
-		rcu_start_batch(RCU_batch(cpu));
-		spin_unlock(&rcu_ctrlblk.mutex);
-	} else {
-		local_irq_enable();
-	}
-	rcu_check_quiescent_state();
-	if (!list_empty(&list))
-		rcu_do_batch(&list);
+	__rcu_process_callbacks(&rcu_ctrlblk, &per_cpu(rcu_data, cpu));
+	__rcu_process_callbacks(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
 
 void rcu_check_callbacks(int cpu, int user)
 {
-	if (user || 
-	    (idle_cpu(cpu) && !in_softirq() && 
-				hardirq_count() <= (1 << HARDIRQ_SHIFT)))
-		RCU_qsctr(cpu)++;
-	tasklet_schedule(&RCU_tasklet(cpu));
-}
-
-static void __devinit rcu_online_cpu(int cpu)
-{
-	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
-	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
-	INIT_LIST_HEAD(&RCU_nxtlist(cpu));
-	INIT_LIST_HEAD(&RCU_curlist(cpu));
+  	if (user || 
+  	    (idle_cpu(cpu) && !in_softirq() && 
+				hardirq_count() <= (1 << HARDIRQ_SHIFT))) {
+  		RCU_qsctr(cpu)++;
+		RCU_bh_qsctr(cpu)++;
+	} else if (!in_softirq())
+		RCU_bh_qsctr(cpu)++;
+  	tasklet_schedule(&RCU_tasklet(cpu));
+}
+  
+static void __devinit rcu_online_cpu(struct rcu_data *rdp)
+{
+	memset(rdp, 0, sizeof(*rdp));
+	INIT_LIST_HEAD(&rdp->nxtlist);
+ 	INIT_LIST_HEAD(&rdp->curlist);
 }
-
+  
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 
 				unsigned long action, void *hcpu)
 {
 	long cpu = (long)hcpu;
 	switch (action) {
 	case CPU_UP_PREPARE:
-		rcu_online_cpu(cpu);
+		rcu_online_cpu(&per_cpu(rcu_data, cpu));
+		rcu_online_cpu(&per_cpu(rcu_bh_data, cpu));
+		tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
 		break;
 	/* Space reserved for CPU_OFFLINE :) */
 	default:
@@ -264,4 +304,5 @@ void synchronize_kernel(void)
 
 
 EXPORT_SYMBOL(call_rcu);
+EXPORT_SYMBOL(call_rcu_bh);
 EXPORT_SYMBOL(synchronize_kernel);
diff -puN kernel/softirq.c~rcu-softirq kernel/softirq.c
--- linux-2.6.0-rtcache/kernel/softirq.c~rcu-softirq	2004-04-01 00:07:48.000000000 +0530
+++ linux-2.6.0-rtcache-dipankar/kernel/softirq.c	2004-04-01 02:19:00.000000000 +0530
@@ -73,6 +73,7 @@ asmlinkage void do_softirq(void)
 	int max_restart = MAX_SOFTIRQ_RESTART;
 	__u32 pending;
 	unsigned long flags;
+	int cpu;
 
 	if (in_interrupt())
 		return;
@@ -85,6 +86,7 @@ asmlinkage void do_softirq(void)
 		struct softirq_action *h;
 
 		local_bh_disable();
+		cpu = smp_processor_id();
 restart:
 		/* Reset the pending bitmask before enabling irqs */
 		local_softirq_pending() = 0;
@@ -94,8 +96,10 @@ restart:
 		h = softirq_vec;
 
 		do {
-			if (pending & 1)
+			if (pending & 1) {
 				h->action(h);
+				RCU_bh_qsctr(cpu)++;
+			}
 			h++;
 			pending >>= 1;
 		} while (pending);
@@ -107,6 +111,7 @@ restart:
 			goto restart;
 		if (pending)
 			wakeup_softirqd();
+
 		__local_bh_enable();
 	}
 
@@ -117,6 +122,11 @@ EXPORT_SYMBOL(do_softirq);
 
 void local_bh_enable(void)
 {
+	int cpu = smp_processor_id();
+
+	if (softirq_count() ==  (1 << SOFTIRQ_SHIFT)) {
+		RCU_bh_qsctr(cpu)++;
+	}
 	__local_bh_enable();
 	WARN_ON(irqs_disabled());
 	if (unlikely(!in_interrupt() &&
diff -puN net/decnet/dn_route.c~rcu-softirq net/decnet/dn_route.c
--- linux-2.6.0-rtcache/net/decnet/dn_route.c~rcu-softirq	2004-04-01 00:07:48.000000000 +0530
+++ linux-2.6.0-rtcache-dipankar/net/decnet/dn_route.c	2004-04-01 00:07:48.000000000 +0530
@@ -146,14 +146,16 @@ static __inline__ unsigned dn_hash(unsig
 
 static inline void dnrt_free(struct dn_route *rt)
 {
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu_bh(&rt->u.dst.rcu_head, (void (*)(void *))dst_free,
+								&rt->u.dst);
 }
 
 static inline void dnrt_drop(struct dn_route *rt)
 {
 	if (rt)
 		dst_release(&rt->u.dst);
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu_bh(&rt->u.dst.rcu_head, (void (*)(void *))dst_free,
+								&rt->u.dst);
 }
 
 static void dn_dst_check_expire(unsigned long dummy)
diff -puN net/ipv4/route.c~rcu-softirq net/ipv4/route.c
--- linux-2.6.0-rtcache/net/ipv4/route.c~rcu-softirq	2004-04-01 00:07:48.000000000 +0530
+++ linux-2.6.0-rtcache-dipankar/net/ipv4/route.c	2004-04-01 02:02:31.000000000 +0530
@@ -224,11 +224,11 @@ static struct rtable *rt_cache_get_first
 	struct rt_cache_iter_state *st = seq->private;
 
 	for (st->bucket = rt_hash_mask; st->bucket >= 0; --st->bucket) {
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		r = rt_hash_table[st->bucket].chain;
 		if (r)
 			break;
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 	return r;
 }
@@ -240,10 +240,10 @@ static struct rtable *rt_cache_get_next(
 	smp_read_barrier_depends();
 	r = r->u.rt_next;
 	while (!r) {
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 		if (--st->bucket < 0)
 			break;
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		r = rt_hash_table[st->bucket].chain;
 	}
 	return r;
@@ -279,7 +279,7 @@ static void *rt_cache_seq_next(struct se
 static void rt_cache_seq_stop(struct seq_file *seq, void *v)
 {
 	if (v && v != SEQ_START_TOKEN)
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 }
 
 static int rt_cache_seq_show(struct seq_file *seq, void *v)
@@ -437,13 +437,15 @@ static struct file_operations rt_cpu_seq
   
 static __inline__ void rt_free(struct rtable *rt)
 {
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu_bh(&rt->u.dst.rcu_head, (void (*)(void *))dst_free,
+								&rt->u.dst);
 }
 
 static __inline__ void rt_drop(struct rtable *rt)
 {
 	ip_rt_put(rt);
-	call_rcu(&rt->u.dst.rcu_head, (void (*)(void *))dst_free, &rt->u.dst);
+	call_rcu_bh(&rt->u.dst.rcu_head, (void (*)(void *))dst_free,
+								&rt->u.dst);
 }
 
 static __inline__ int rt_fast_clean(struct rtable *rth)
@@ -2223,7 +2225,7 @@ int __ip_route_output_key(struct rtable 
 
 	hash = rt_hash_code(flp->fl4_dst, flp->fl4_src ^ (flp->oif << 5), flp->fl4_tos);
 
-	rcu_read_lock();
+	rcu_read_lock_bh();
 	for (rth = rt_hash_table[hash].chain; rth; rth = rth->u.rt_next) {
 		smp_read_barrier_depends();
 		if (rth->fl.fl4_dst == flp->fl4_dst &&
@@ -2239,13 +2241,13 @@ int __ip_route_output_key(struct rtable 
 			dst_hold(&rth->u.dst);
 			rth->u.dst.__use++;
 			RT_CACHE_STAT_INC(out_hit);
-			rcu_read_unlock();
+			rcu_read_unlock_bh();
 			*rp = rth;
 			return 0;
 		}
 		RT_CACHE_STAT_INC(out_hlist_search);
 	}
-	rcu_read_unlock();
+	rcu_read_unlock_bh();
 
 	return ip_route_output_slow(rp, flp);
 }
@@ -2455,7 +2457,7 @@ int ip_rt_dump(struct sk_buff *skb,  str
 		if (h < s_h) continue;
 		if (h > s_h)
 			s_idx = 0;
-		rcu_read_lock();
+		rcu_read_lock_bh();
 		for (rt = rt_hash_table[h].chain, idx = 0; rt;
 		     rt = rt->u.rt_next, idx++) {
 			smp_read_barrier_depends();
@@ -2466,12 +2468,12 @@ int ip_rt_dump(struct sk_buff *skb,  str
 					 cb->nlh->nlmsg_seq,
 					 RTM_NEWROUTE, 1) <= 0) {
 				dst_release(xchg(&skb->dst, NULL));
-				rcu_read_unlock();
+				rcu_read_unlock_bh();
 				goto done;
 			}
 			dst_release(xchg(&skb->dst, NULL));
 		}
-		rcu_read_unlock();
+		rcu_read_unlock_bh();
 	}
 
 done:

_
