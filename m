Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263361AbUDEVbV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Apr 2004 17:31:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263346AbUDEV3A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Apr 2004 17:29:00 -0400
Received: from e33.co.us.ibm.com ([32.97.110.131]:387 "EHLO e33.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S263361AbUDEVZG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Apr 2004 17:25:06 -0400
Date: Tue, 6 Apr 2004 02:52:20 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Robert Olsson <Robert.Olsson@data.slu.se>
Cc: Andrea Arcangeli <andrea@suse.de>, "David S. Miller" <davem@redhat.com>,
       kuznet@ms2.inr.ac.ru, linux-kernel@vger.kernel.org, netdev@oss.sgi.com,
       paulmck@us.ibm.com, akpm@osdl.org
Subject: Re: route cache DoS testing and softirqs
Message-ID: <20040405212220.GH4003@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <200403302005.AAA00466@yakov.inr.ac.ru> <20040330211450.GI3808@dualathlon.random> <20040330133000.098761e2.davem@redhat.com> <20040330213742.GL3808@dualathlon.random> <20040331171023.GA4543@in.ibm.com> <16491.4593.718724.277551@robur.slu.se> <20040331203750.GB4543@in.ibm.com> <20040331212817.GQ2143@dualathlon.random> <20040331214342.GD4543@in.ibm.com> <16497.37720.607342.193544@robur.slu.se>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16497.37720.607342.193544@robur.slu.se>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 05, 2004 at 07:11:52PM +0200, Robert Olsson wrote:
> 
> Dipankar Sarma writes:
> 
>  > Robert, btw, this rcu-softirq patch is slightly different
>  > from the earlier one in the sense that now every softirq
>  > handler completion is a quiescent point. Earlier each iteration
>  > of softirqs was a quiescent point. So this has more quiescent
>  > points.
> 
> Hello!
> 
> Yes it seems reduce RCU latency in our setup as well. It does not eliminate 
> overflows but reduces with ~50% and increases the throughput a bit. dst cache 
> overflow depends on RCU-delay + gc_min_interval and the number of entries
> freed per sec so this means RCU has improved. Also the user app doing gettimeofday 
> seems to be better scheduled. The worst starvation improved from ~7.5 to ~4.4 sec. 

Looks better atleast. Can you apply the following patch (rs-throttle-rcu)
on top of rcu-softirq.patch in your tree and see if helps a little bit more ?
Please make sure to set the kernel paramenters rcupdate.maxbatch to 4
and rcupdate.plugticks to 0. You can make sure of those parameters
by looking at dmesg (rcu prints them out during boot). I just merged
it, but have not tested this patch yet.

Thanks
Dipankar



Throttle rcu by forcing a limit on how many callbacks per softirq
and also implement a configurable plug. Applies on top of the
rcu-softirq (hence rs-) patch.


 include/linux/list.h     |   21 +++++++++++++++++++++
 include/linux/rcupdate.h |    7 ++++++-
 kernel/rcupdate.c        |   33 +++++++++++++++++++++++++--------
 kernel/sched.c           |    2 ++
 4 files changed, 54 insertions(+), 9 deletions(-)

diff -puN include/linux/list.h~rs-throttle-rcu include/linux/list.h
--- linux-2.6.4-rcu/include/linux/list.h~rs-throttle-rcu	2004-04-06 02:05:13.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/include/linux/list.h	2004-04-06 02:05:13.000000000 +0530
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
diff -puN include/linux/rcupdate.h~rs-throttle-rcu include/linux/rcupdate.h
--- linux-2.6.4-rcu/include/linux/rcupdate.h~rs-throttle-rcu	2004-04-06 02:05:13.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/include/linux/rcupdate.h	2004-04-06 02:27:29.000000000 +0530
@@ -96,10 +96,12 @@ struct rcu_data {
         long  	       	batch;           /* Batch # for current RCU batch */
         struct list_head  nxtlist;
         struct list_head  curlist;
+	struct list_head  donelist;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
 DECLARE_PER_CPU(struct rcu_data, rcu_bh_data);
+DECLARE_PER_CPU(int, rcu_plugticks);
 extern struct rcu_ctrlblk rcu_ctrlblk;
 extern struct rcu_ctrlblk rcu_bh_ctrlblk;
   
@@ -107,6 +109,8 @@ extern struct rcu_ctrlblk rcu_bh_ctrlblk
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_bh_qsctr(cpu) 	(per_cpu(rcu_bh_data, (cpu)).qsctr)
 #define RCU_bh_nxtlist(cpu) 	(per_cpu(rcu_bh_data, (cpu)).nxtlist)
+
+#define RCU_plugticks(cpu) 	(per_cpu(rcu_plugticks, (cpu)))
   
 #define RCU_QSCTR_INVALID	0
 
@@ -117,7 +121,8 @@ static inline int __rcu_pending(int cpu,
 	     rcu_batch_before(rdp->batch, rcp->curbatch)) ||
 	    (list_empty(&rdp->curlist) &&
 			 !list_empty(&rdp->nxtlist)) ||
-	    cpu_isset(cpu, rcp->rcu_cpu_mask))
+	    cpu_isset(cpu, rcp->rcu_cpu_mask) ||
+	    (!list_empty(&rdp->donelist) && RCU_plugticks(cpu) == 0))
 		return 1;
 	else
 		return 0;
diff -puN kernel/rcupdate.c~rs-throttle-rcu kernel/rcupdate.c
--- linux-2.6.4-rcu/kernel/rcupdate.c~rs-throttle-rcu	2004-04-06 02:05:13.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/kernel/rcupdate.c	2004-04-06 02:47:10.000000000 +0530
@@ -39,6 +39,7 @@
 #include <asm/atomic.h>
 #include <asm/bitops.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/completion.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
@@ -59,6 +60,10 @@ DEFINE_PER_CPU(struct rcu_data, rcu_bh_d
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
+DEFINE_PER_CPU(int, rcu_plugticks) = 0;
+
+static int maxbatch = 1000000;
+static int plugticks = 4;
 
 /**
  * call_rcu - Queue an RCU update request.
@@ -112,16 +117,23 @@ void call_rcu_bh(struct rcu_head *head, 
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
+		if (++count >= maxbatch) {
+			RCU_plugticks(cpu) = plugticks;
+			if (!RCU_plugticks(cpu))
+				tasklet_hi_schedule(&RCU_tasklet(cpu));
+			break;
+		}
 	}
 }
 
@@ -178,7 +190,7 @@ out_unlock:
 	spin_unlock(&rcp->mutex);
 }
   
-static void __rcu_process_callbacks(struct rcu_ctrlblk *rcp,
+static void __rcu_process_callbacks(int cpu, struct rcu_ctrlblk *rcp,
 					struct rcu_data *rdp)
 {
   	LIST_HEAD(list);
@@ -186,6 +198,7 @@ static void __rcu_process_callbacks(stru
 	if (!list_empty(&rdp->curlist) &&
 	    rcu_batch_after(rcp->curbatch, rdp->batch)) {
 		list_splice(&rdp->curlist, &list);
+		list_splice_tail(&rdp->curlist, &rdp->donelist);
 		INIT_LIST_HEAD(&rdp->curlist);
   	}
   
@@ -206,13 +219,13 @@ static void __rcu_process_callbacks(stru
   		local_irq_enable();
   	}
 	rcu_check_quiescent_state(rcp, rdp);
-  	if (!list_empty(&list))
-  		rcu_do_batch(&list);
+	if (!list_empty(&rdp->donelist) && !RCU_plugticks(cpu))
+		rcu_do_batch(cpu, &rdp->donelist);
 }
   
 void rcu_process_callbacks_bh(int cpu)
 {
-	__rcu_process_callbacks(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
+	__rcu_process_callbacks(cpu, &rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
 
 /*
@@ -221,8 +234,8 @@ void rcu_process_callbacks_bh(int cpu)
 static void rcu_process_callbacks(unsigned long unused)
 {
 	int cpu = smp_processor_id();
-	__rcu_process_callbacks(&rcu_ctrlblk, &per_cpu(rcu_data, cpu));
-	__rcu_process_callbacks(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
+	__rcu_process_callbacks(cpu, &rcu_ctrlblk, &per_cpu(rcu_data, cpu));
+	__rcu_process_callbacks(cpu, &rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
 
 void rcu_check_callbacks(int cpu, int user)
@@ -234,7 +247,7 @@ void rcu_check_callbacks(int cpu, int us
 		RCU_bh_qsctr(cpu)++;
 	} else if (!in_softirq())
 		RCU_bh_qsctr(cpu)++;
-  	tasklet_schedule(&RCU_tasklet(cpu));
+  	tasklet_hi_schedule(&RCU_tasklet(cpu));
 }
   
 static void __devinit rcu_online_cpu(struct rcu_data *rdp)
@@ -242,6 +255,7 @@ static void __devinit rcu_online_cpu(str
 	memset(rdp, 0, sizeof(*rdp));
 	INIT_LIST_HEAD(&rdp->nxtlist);
  	INIT_LIST_HEAD(&rdp->curlist);
+ 	INIT_LIST_HEAD(&rdp->donelist);
 }
   
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 
@@ -277,6 +291,7 @@ void __init rcu_init(void)
 			(void *)(long)smp_processor_id());
 	/* Register notifier for non-boot CPUs */
 	register_cpu_notifier(&rcu_nb);
+	printk("RCU: maxbatch = %d, plugticks = %d\n", maxbatch, plugticks);
 }
 
 
@@ -302,6 +317,8 @@ void synchronize_kernel(void)
 	wait_for_completion(&completion);
 }
 
+module_param(maxbatch, int, 0);
+module_param(plugticks, int, 0);
 
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(call_rcu_bh);
diff -puN kernel/sched.c~rs-throttle-rcu kernel/sched.c
--- linux-2.6.4-rcu/kernel/sched.c~rs-throttle-rcu	2004-04-06 02:05:13.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/kernel/sched.c	2004-04-06 02:05:13.000000000 +0530
@@ -1486,6 +1486,8 @@ void scheduler_tick(int user_ticks, int 
 
 	if (rcu_pending(cpu))
 		rcu_check_callbacks(cpu, user_ticks);
+	if (RCU_plugticks(cpu))
+		RCU_plugticks(cpu)--;
 
 	/* note: this timer irq context must be accounted for as well */
 	if (hardirq_count() - HARDIRQ_OFFSET) {

_
