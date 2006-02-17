Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964913AbWBQQNr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964913AbWBQQNr (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:13:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964921AbWBQQNr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:13:47 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:55965 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S964913AbWBQQNq
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:13:46 -0500
Date: Fri, 17 Feb 2006 21:13:37 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, "Paul E.McKenney" <paulmck@us.ibm.com>
Subject: Re: [PATCH 1/2] rcu batch tuning
Message-ID: <20060217154337.GM29846@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060217154147.GL29846@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217154147.GL29846@in.ibm.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This patch adds new tunables for RCU queue and finished batches.
There are two types of controls - number of completed RCU updates
invoked in a batch (blimit) and monitoring for high rate of
incoming RCUs on a cpu (qhimark, qlowmark). By default,
the per-cpu batch limit is set to a small value. If
the input RCU rate exceeds the high watermark, we do two things -
force quiescent state on all cpus and set the batch limit
of the CPU to INTMAX. Setting batch limit to INTMAX forces all
finished RCUs to be processed in one shot. If we have more than
INTMAX RCUs queued up, then we have bigger problems anyway.
Once the incoming queued RCUs fall below the low watermark, the batch limit
is set to the default.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>
---


 include/linux/rcupdate.h |    6 +++
 kernel/rcupdate.c        |   76 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 63 insertions(+), 19 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-batch-tuning include/linux/rcupdate.h
--- linux-2.6.16-rc3-rcu/include/linux/rcupdate.h~rcu-batch-tuning	2006-02-15 16:00:02.000000000 +0530
+++ linux-2.6.16-rc3-rcu-dipankar/include/linux/rcupdate.h	2006-02-15 16:00:02.000000000 +0530
@@ -98,13 +98,17 @@ struct rcu_data {
 	long  	       	batch;           /* Batch # for current RCU batch */
 	struct rcu_head *nxtlist;
 	struct rcu_head **nxttail;
-	long            count; /* # of queued items */
+	long            qlen; 	 	 /* # of queued callbacks */
 	struct rcu_head *curlist;
 	struct rcu_head **curtail;
 	struct rcu_head *donelist;
 	struct rcu_head **donetail;
+	long		blimit;		 /* Upper limit on a processed batch */
 	int cpu;
 	struct rcu_head barrier;
+#ifdef CONFIG_SMP
+	long		last_rs_qlen;	 /* qlen during the last resched */
+#endif
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
diff -puN kernel/rcupdate.c~rcu-batch-tuning kernel/rcupdate.c
--- linux-2.6.16-rc3-rcu/kernel/rcupdate.c~rcu-batch-tuning	2006-02-15 16:00:02.000000000 +0530
+++ linux-2.6.16-rc3-rcu-dipankar/kernel/rcupdate.c	2006-02-15 16:00:02.000000000 +0530
@@ -67,7 +67,43 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
 
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
-static int maxbatch = 10000;
+static int blimit = 10;
+static int qhimark = 10000;
+static int qlowmark = 100;
+#ifdef CONFIG_SMP
+static int rsinterval = 1000;
+#endif
+
+static atomic_t rcu_barrier_cpu_count;
+static struct semaphore rcu_barrier_sema;
+static struct completion rcu_barrier_completion;
+
+#ifdef CONFIG_SMP
+static void force_quiescent_state(struct rcu_data *rdp,
+			struct rcu_ctrlblk *rcp)
+{
+	int cpu;
+	cpumask_t cpumask;
+	set_need_resched();
+	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
+		rdp->last_rs_qlen = rdp->qlen;
+		/*
+		 * Don't send IPI to itself. With irqs disabled,
+		 * rdp->cpu is the current cpu.
+		 */
+		cpumask = rcp->cpumask;
+		cpu_clear(rdp->cpu, cpumask);
+		for_each_cpu_mask(cpu, cpumask)
+			smp_send_reschedule(cpu);
+	}
+}
+#else 
+static inline void force_quiescent_state(struct rcu_data *rdp,
+			struct rcu_ctrlblk *rcp)
+{
+	set_need_resched();
+}
+#endif
 
 /**
  * call_rcu - Queue an RCU callback for invocation after a grace period.
@@ -92,17 +128,13 @@ void fastcall call_rcu(struct rcu_head *
 	rdp = &__get_cpu_var(rcu_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
-
-	if (unlikely(++rdp->count > 10000))
-		set_need_resched();
-
+	if (unlikely(++rdp->qlen > qhimark)) {
+		rdp->blimit = INT_MAX;
+		force_quiescent_state(rdp, &rcu_ctrlblk);
+	}
 	local_irq_restore(flags);
 }
 
-static atomic_t rcu_barrier_cpu_count;
-static struct semaphore rcu_barrier_sema;
-static struct completion rcu_barrier_completion;
-
 /**
  * call_rcu_bh - Queue an RCU for invocation after a quicker grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -131,12 +163,12 @@ void fastcall call_rcu_bh(struct rcu_hea
 	rdp = &__get_cpu_var(rcu_bh_data);
 	*rdp->nxttail = head;
 	rdp->nxttail = &head->next;
-	rdp->count++;
-/*
- *  Should we directly call rcu_do_batch() here ?
- *  if (unlikely(rdp->count > 10000))
- *      rcu_do_batch(rdp);
- */
+
+	if (unlikely(++rdp->qlen > qhimark)) {
+		rdp->blimit = INT_MAX;
+		force_quiescent_state(rdp, &rcu_bh_ctrlblk);
+	}
+
 	local_irq_restore(flags);
 }
 
@@ -199,10 +231,12 @@ static void rcu_do_batch(struct rcu_data
 		next = rdp->donelist = list->next;
 		list->func(list);
 		list = next;
-		rdp->count--;
-		if (++count >= maxbatch)
+		rdp->qlen--;
+		if (++count >= rdp->blimit)
 			break;
 	}
+	if (rdp->blimit == INT_MAX && rdp->qlen <= qlowmark)
+		rdp->blimit = blimit;
 	if (!rdp->donelist)
 		rdp->donetail = &rdp->donelist;
 	else
@@ -473,6 +507,7 @@ static void rcu_init_percpu_data(int cpu
 	rdp->quiescbatch = rcp->completed;
 	rdp->qs_pending = 0;
 	rdp->cpu = cpu;
+	rdp->blimit = blimit;
 }
 
 static void __devinit rcu_online_cpu(int cpu)
@@ -567,7 +602,12 @@ void synchronize_kernel(void)
 	synchronize_rcu();
 }
 
-module_param(maxbatch, int, 0);
+module_param(blimit, int, 0);
+module_param(qhimark, int, 0);
+module_param(qlowmark, int, 0);
+#ifdef CONFIG_SMP
+module_param(rsinterval, int, 0);
+#endif
 EXPORT_SYMBOL_GPL(rcu_batches_completed);
 EXPORT_SYMBOL(call_rcu);  /* WARNING: GPL-only in April 2006. */
 EXPORT_SYMBOL(call_rcu_bh);  /* WARNING: GPL-only in April 2006. */

_
