Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750748AbWAXVic@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750748AbWAXVic (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 24 Jan 2006 16:38:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750747AbWAXVic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 24 Jan 2006 16:38:32 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:59265 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1750748AbWAXVib
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 24 Jan 2006 16:38:31 -0500
Date: Wed, 25 Jan 2006 03:08:02 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Ingo Molnar <mingo@elte.hu>, "Paul E. McKenney" <paulmck@us.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: RCU latency regression in 2.6.16-rc1
Message-ID: <20060124213802.GC7139@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20060124075640.GA24806@elte.hu> <1138089483.2771.81.camel@mindpipe> <20060124080157.GA25855@elte.hu> <1138090078.2771.88.camel@mindpipe> <20060124081301.GC25855@elte.hu> <1138090527.2771.91.camel@mindpipe> <20060124091730.GA31204@us.ibm.com> <20060124092330.GA7060@elte.hu> <1138095856.2771.103.camel@mindpipe> <20060124162846.GA7139@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060124162846.GA7139@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 24, 2006 at 09:58:46PM +0530, Dipankar Sarma wrote:
> On Tue, Jan 24, 2006 at 04:44:15AM -0500, Lee Revell wrote:
> > On Tue, 2006-01-24 at 10:23 +0100, Ingo Molnar wrote:
> > > * Paul E. McKenney <paulmck@us.ibm.com> wrote:
> > > 
> > > > This patch was primarily designed to reduce memory overhead, but given 
> > > > that it tends to reduce batch size, it should also reduce latency.
> > > 
> > > if this solves Lee's problem, i think we should apply this as a fix, and 
> > > get it into v2.6.16. The patch looks straightforward and correct to me.
> > > 
> > 
> > Does not compile:
> > 
> >  CC      kernel/rcupdate.o
> > kernel/rcupdate.c:76: warning: 'struct rcu_state' declared inside parameter list
> 
> My original patch was against a much older kernel.
> I will send out a more uptodate patch as soon as I am done with some
> testing.

Here is an updated version of that patch against 2.6.16-rc1. I have
sanity-tested it on ppc64 and x86_64 using dbench and kernbench.
I have also tested this for OOM situations - open()/close() in
a tight loop in my x86_64 which earlier used to reach file limit
if I set batch limit to 10 and found no problem. This patch does set 
default RCU batch limit to 10 and changes it only when there is an RCU
flood.

Any latency measurement result will be greatly appreciated.

Thanks
Dipankar


This patch adds new tunables for RCU queue and finished batches.
There are two types of controls - number of completed RCU updates
invoked in a batch (blimit) and monitoring for high rate of
incoming RCUs on a cpu (qhimark, qlowmark). By default,
the per-cpu batch limit is set to a small value. If
the input RCU rate exceeds the high watermark, we do two things -
force quiescent state on all cpus and set the batch limit
of the CPU to -1. Setting batch limit to -1 forces all
finished RCUs to be processed in one shot. Once the incoming
queued RCUs fall below the low watermark, the batch limit
is set to the default.

Signed-off-by: Dipankar Sarma <dipankar@in.ibm.com>


 include/linux/rcupdate.h |    6 +++
 kernel/rcupdate.c        |   73 +++++++++++++++++++++++++++++++++++------------
 2 files changed, 60 insertions(+), 19 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-batch-tuning include/linux/rcupdate.h
--- linux-2.6.16-rc1-rcu/include/linux/rcupdate.h~rcu-batch-tuning	2006-01-25 00:09:54.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/include/linux/rcupdate.h	2006-01-25 01:07:39.000000000 +0530
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
--- linux-2.6.16-rc1-rcu/kernel/rcupdate.c~rcu-batch-tuning	2006-01-25 00:09:54.000000000 +0530
+++ linux-2.6.16-rc1-rcu-dipankar/kernel/rcupdate.c	2006-01-25 01:20:55.000000000 +0530
@@ -67,7 +67,36 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
 
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
+static inline void force_quiescent_state(struct rcu_data *rdp,
+			struct rcu_ctrlblk *rcp)
+{
+	int cpu;
+	set_need_resched();
+	if (unlikely(rdp->qlen - rdp->last_rs_qlen > rsinterval)) {
+		rdp->last_rs_qlen = rdp->qlen;
+		for_each_cpu_mask(cpu, rcp->cpumask)
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
@@ -92,17 +121,13 @@ void fastcall call_rcu(struct rcu_head *
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
@@ -131,12 +156,12 @@ void fastcall call_rcu_bh(struct rcu_hea
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
 
@@ -199,10 +224,12 @@ static void rcu_do_batch(struct rcu_data
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
@@ -473,6 +500,11 @@ static void rcu_init_percpu_data(int cpu
 	rdp->quiescbatch = rcp->completed;
 	rdp->qs_pending = 0;
 	rdp->cpu = cpu;
+	rdp->qlen = 0;
+#ifdef CONFIG_SMP
+	rdp->last_rs_qlen = 0;
+#endif
+	rdp->blimit = blimit;
 }
 
 static void __devinit rcu_online_cpu(int cpu)
@@ -567,7 +599,12 @@ void synchronize_kernel(void)
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
