Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262022AbUCXVmJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Mar 2004 16:42:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262007AbUCXVmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Mar 2004 16:42:09 -0500
Received: from e1.ny.us.ibm.com ([32.97.182.101]:40958 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262029AbUCXVkr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Mar 2004 16:40:47 -0500
Date: Thu, 25 Mar 2004 03:09:15 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Paul E. McKenney" <paulmck@us.ibm.com>,
       Arjan van de Ven <arjanv@redhat.com>, tiwai@suse.de,
       Robert Love <rml@ximian.com>, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RCU for low latency (experimental)
Message-ID: <20040324213914.GD4539@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040323101755.GC3676@in.ibm.com> <1080038105.5296.8.camel@laptop.fenrus.com> <20040323123105.GI22639@dualathlon.random> <20040323124002.GH3676@in.ibm.com> <20040323125044.GL22639@dualathlon.random> <20040324172657.GA1303@us.ibm.com> <20040324175142.GW2065@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040324175142.GW2065@dualathlon.random>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 24, 2004 at 06:51:42PM +0100, Andrea Arcangeli wrote:
> On Wed, Mar 24, 2004 at 09:26:57AM -0800, Paul E. McKenney wrote:
> running 1 callback per softirq (and in turn 10 callbacks per hardware
> irq) shouldn't be measurable compared to the cost of the hardware
> handling, skb memory allocation, iommu mapping etc... 
> 
> why do you care about this specific irq-flood corner case where the load
> is lost in the noise and there's no way to make it scheduler-friendy
> either since hardware irqs are involved?

We are looking at two different problems. Scheduling latency and
DoS on route cache that results in dst cache overflows. The second
one is an irq-flood, but latency is the least of the problems there.


> > > > In my DoS testing setup, I see that limiting RCU softirqs 
> > > > and re-arming tasklets has no effect on user process starvation.
> > > 
> > > in an irq flood load that stalls userspace anyways it's ok to spread the
> > > callback load into the irqs, 10 tasklets and in turn 10 callbacks per
> > > irqs or so. That load isn't scheduler friendly anyways.
> > 
> > The goal is to run reasonably, even under this workload, which, as you
> > say is not scheduler friendly.  Scheduler hostile, in fact.  ;-)
> 
> Indeed it is, and I'm simply expecting not any real difference by
> running 10 callbacks per hardware irq, so I find it a non very
> interesting workload to choose between a softirq or the kernel thread,
> but maybe I'm overlooking something.

The difference here is that during the callbacks in the kernel thread, 
I don't disable softirqs unlike ksoftirqd thus giving it more opportunity for
preemption.


> > The problem is that some of the workloads generate thousands of
> > RCU callbacks per grace period.  If we are going to provide
> > realtime scheduling latencies in the hundreds of microseconds, we
> > probably aren't going to get away with executing all of these
> > callbacks in softirq context.
> 
> it should, you just need to run 1 callback per re-arming tasklet (then
> after the list is empty you stop re-arming), the softirq code will do
> the rest for you offloading it immediatly to ksoftirqd after 10
> callbacks, and ksoftirqd will reschedule explicitly once every 10
> callbacks too. The whole point of ksoftirqd is to make re-arming
> tasklets irq-friendy. Though there's a cost in offloading the work to a
> daemon, so we must not do it too frequently, so we retry 10 times before
> giving up and claiming the tasklet re-entrant.

I had already been testing this for the DoS issue, but I tried it
with amlat on a 2.4 GHz (UP) P4 xeon with 256MB ram and dbench 32 in a
loop. Here are the results (CONFIG_PREEMPT = y) -

2.6.0 vanilla 		- 711 microseconds
2.6.0 + throttle-rcu 	- 439 microseconds
2.6.0 + rcu-low-lat 	- 413 microseconds

So under dbench workload atleast, throttling RCU works just as
good as offloading them to a kernel thread (krcud) as rcu-low-lat
does.

I used the following throttle-rcu patch with rcupdate.rcumaxbatch
set to 16 and rcupdate.rcuplugticks set to 0. That is essentially
equvalent to Andrea's earler suggestion. I have so many knobs in
the patch because I had written it earlier for other experiments.
Anyway, if throttling works as well as this in terms of latency
for other workloads as well and there isn't any OOM situations,
it is preferable to creating another per-cpu thread.

Thanks
Dipankar


Throttle rcu by forcing a limit on how many callbacks per softirq
and also implement a configurable plug.


 include/linux/list.h     |   21 +++++++++++++++++++++
 include/linux/rcupdate.h |    7 ++++++-
 kernel/rcupdate.c        |   26 +++++++++++++++++++-------
 kernel/sched.c           |    2 ++
 4 files changed, 48 insertions(+), 8 deletions(-)

diff -puN include/linux/list.h~throttle-rcu include/linux/list.h
--- linux-2.6.4-rcu/include/linux/list.h~throttle-rcu	2004-03-25 02:48:10.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/include/linux/list.h	2004-03-25 02:48:10.000000000 +0530
@@ -251,6 +251,27 @@ static inline void list_splice(struct li
 		__list_splice(list, head);
 }
 
+static inline void __list_splice_tail(struct list_head *list,
+			struct list_head *head)
+{
+	struct list_head *first = list->next;
+	struct list_head *last = list->prev;
+	struct list_head *at = head->prev;
+
+	first->prev = at;
+	at->next = first;
+	head->prev = last;
+	last->next = head;
+}
+
+
+static inline void list_splice_tail(struct list_head *list, 
+			struct list_head *head)
+{
+	if (!list_empty(list))
+		__list_splice_tail(list, head);
+}
+
 /**
  * list_splice_init - join two lists and reinitialise the emptied list.
  * @list: the new list to add.
diff -puN include/linux/rcupdate.h~throttle-rcu include/linux/rcupdate.h
--- linux-2.6.4-rcu/include/linux/rcupdate.h~throttle-rcu	2004-03-25 02:48:10.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/include/linux/rcupdate.h	2004-03-25 02:49:17.000000000 +0530
@@ -96,6 +96,8 @@ struct rcu_data {
         long  	       	batch;           /* Batch # for current RCU batch */
         struct list_head  nxtlist;
         struct list_head  curlist;
+	struct list_head  donelist;
+	int		plugticks;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -106,6 +108,8 @@ extern struct rcu_ctrlblk rcu_ctrlblk;
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
+#define RCU_donelist(cpu) 	(per_cpu(rcu_data, (cpu)).donelist)
+#define RCU_plugticks(cpu) 	(per_cpu(rcu_data, (cpu)).plugticks)
 
 #define RCU_QSCTR_INVALID	0
 
@@ -115,7 +119,8 @@ static inline int rcu_pending(int cpu) 
 	     rcu_batch_before(RCU_batch(cpu), rcu_ctrlblk.curbatch)) ||
 	    (list_empty(&RCU_curlist(cpu)) &&
 			 !list_empty(&RCU_nxtlist(cpu))) ||
-	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask))
+	    cpu_isset(cpu, rcu_ctrlblk.rcu_cpu_mask) ||
+	    (!list_empty(&RCU_donelist(cpu)) && RCU_plugticks(cpu) == 0))
 		return 1;
 	else
 		return 0;
diff -puN kernel/rcupdate.c~throttle-rcu kernel/rcupdate.c
--- linux-2.6.4-rcu/kernel/rcupdate.c~throttle-rcu	2004-03-25 02:48:10.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/kernel/rcupdate.c	2004-03-25 02:56:11.000000000 +0530
@@ -39,6 +39,7 @@
 #include <asm/atomic.h>
 #include <asm/bitops.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/completion.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
@@ -54,6 +55,8 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
+static int rcumaxbatch = 1000000;
+static int rcuplugticks = 4;
 
 /**
  * call_rcu - Queue an RCU update request.
@@ -83,16 +86,23 @@ void fastcall call_rcu(struct rcu_head *
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
  */
-static void rcu_do_batch(struct list_head *list)
+static void rcu_do_batch(int cpu, struct list_head *list)
 {
 	struct list_head *entry;
 	struct rcu_head *head;
+	int count = 0;
 
 	while (!list_empty(list)) {
 		entry = list->next;
 		list_del(entry);
 		head = list_entry(entry, struct rcu_head, list);
 		head->func(head->arg);
+		if (count >= rcumaxbatch) {
+			RCU_plugticks(cpu) = rcuplugticks;
+			if (!RCU_plugticks(cpu))
+				tasklet_hi_schedule(&RCU_tasklet(cpu));
+			break;
+		}
 	}
 }
 
@@ -153,18 +163,16 @@ out_unlock:
 	spin_unlock(&rcu_ctrlblk.mutex);
 }
 
-
 /*
  * This does the RCU processing work from tasklet context. 
  */
 static void rcu_process_callbacks(unsigned long unused)
 {
 	int cpu = smp_processor_id();
-	LIST_HEAD(list);
 
 	if (!list_empty(&RCU_curlist(cpu)) &&
 	    rcu_batch_after(rcu_ctrlblk.curbatch, RCU_batch(cpu))) {
-		list_splice(&RCU_curlist(cpu), &list);
+		list_splice_tail(&RCU_curlist(cpu), &RCU_donelist(cpu));
 		INIT_LIST_HEAD(&RCU_curlist(cpu));
 	}
 
@@ -185,8 +193,8 @@ static void rcu_process_callbacks(unsign
 		local_irq_enable();
 	}
 	rcu_check_quiescent_state();
-	if (!list_empty(&list))
-		rcu_do_batch(&list);
+	if (!list_empty(&RCU_donelist(cpu)) && !RCU_plugticks(cpu))
+		rcu_do_batch(cpu, &RCU_donelist(cpu));
 }
 
 void rcu_check_callbacks(int cpu, int user)
@@ -195,7 +203,7 @@ void rcu_check_callbacks(int cpu, int us
 	    (idle_cpu(cpu) && !in_softirq() && 
 				hardirq_count() <= (1 << HARDIRQ_SHIFT)))
 		RCU_qsctr(cpu)++;
-	tasklet_schedule(&RCU_tasklet(cpu));
+	tasklet_hi_schedule(&RCU_tasklet(cpu));
 }
 
 static void __devinit rcu_online_cpu(int cpu)
@@ -204,6 +212,7 @@ static void __devinit rcu_online_cpu(int
 	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
 	INIT_LIST_HEAD(&RCU_nxtlist(cpu));
 	INIT_LIST_HEAD(&RCU_curlist(cpu));
+	INIT_LIST_HEAD(&RCU_donelist(cpu));
 }
 
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 
@@ -237,6 +246,7 @@ void __init rcu_init(void)
 			(void *)(long)smp_processor_id());
 	/* Register notifier for non-boot CPUs */
 	register_cpu_notifier(&rcu_nb);
+	printk("RCU: rcumaxbatch = %d, rcuplugticks = %d\n", rcumaxbatch, rcuplugticks);
 }
 
 
@@ -262,6 +272,8 @@ void synchronize_kernel(void)
 	wait_for_completion(&completion);
 }
 
+module_param(rcumaxbatch, int, 0);
+module_param(rcuplugticks, int, 0);
 
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(synchronize_kernel);
diff -puN kernel/sched.c~throttle-rcu kernel/sched.c
--- linux-2.6.4-rcu/kernel/sched.c~throttle-rcu	2004-03-25 02:48:10.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/kernel/sched.c	2004-03-25 02:48:10.000000000 +0530
@@ -1486,6 +1486,8 @@ void scheduler_tick(int user_ticks, int 
 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
+	if (RCU_plugticks(cpu))
+		RCU_plugticks(cpu)--;
 
 	/* note: this timer irq context must be accounted for as well */
 	if (hardirq_count() - HARDIRQ_OFFSET) {

_
