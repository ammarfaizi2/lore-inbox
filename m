Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264879AbUANIXt (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 03:23:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264919AbUANIXs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 03:23:48 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.106]:20730 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264879AbUANIXf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 03:23:35 -0500
Date: Wed, 14 Jan 2004 13:54:20 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Rusty Russell <rusty@au1.ibm.com>
Cc: Paul McKenney <paul.mckenney@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [patch] RCU for low latency [2/2]
Message-ID: <20040114082420.GA3755@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040108115051.GC5128@in.ibm.com> <20040109000244.8C58D17DDE@ozlabs.au.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040109000244.8C58D17DDE@ozlabs.au.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Rusty,

On Fri, Jan 09, 2004 at 10:43:34AM +1100, Rusty Russell wrote:
> In message <20040108115051.GC5128@in.ibm.com> you write:
> > +	int limit = rcu_limiting_needed(cpu);
> >  
> >  	while (!list_empty(list)) {
> >  		entry = list->next;
> >  		list_del(entry);
> >  		head = list_entry(entry, struct rcu_head, list);
> >  		head->func(head->arg);
> > +		count++;
> > +		if (limit && count > rcu_max_bh_callbacks &&
> > +			rq_has_rt_task(cpu)) {
> 
> Perhaps you should do this the other way:
> 
> static inline unsigned int max_rcu_at_once(int cpu)
> {
> 	if (in_softirq() && RCU_krcud(cpu) && rq_has_rt_task(cpu))
> 		return rcu_max_bh_callbacks;
> 	return (unsigned int)-1;
> }

Done, except that once we reach the callback limit, we need to check
for RT tasks after every callback, instead of at the start of the RCU batch.

> Ideally you'd create a new workqueue for this, or at the very least
> use kthread primitives (once they're in -mm, hopefully soon).

I will use kthread primitives once they are available in mainline.

> 
> > +static int start_krcud(int cpu)
> > +{
> > +	if (rcu_max_bh_callbacks) {
> > +		if (kernel_thread(krcud, (void *)(long)cpu, CLONE_KERNEL) < 0) {
> > +			printk("krcud for %i failed\n", cpu);
> > +			return -1;
> 
> EPERM seems unusual here.  How about:
> 
> 	int pid;
> 	pid = kernel_thread(krcud, (void *)(long)cpu, CLONE_KERNEL);
> 	if (pid < 0) {
> 		printk(printk("krcud for %i failed\n", cpu);
> 		return pid;
> 	}

All these go away with kthreads.

> 
> > +__setup("rcubhlimit=", rcu_bh_limit_setup);
> 
> Please use module_param().  If it's a good name for a variable, it's a
> good name for a parameter.  eg. just call the variable bhlimit, and
> then the boot parameter will be called "rcu.bhlimit" which fits the
> calling conventio we're trying to encourage.

I will clean this up later should we come to a conclusion that
we need the low-latency changes in mainline. I don't see
any non-driver kernel code using module_param() though.

New patch below. Needs rq-has-rt-task.patch I mailed earlier.
There are more issues that need investigations - can we starve
RCU callbacks leading to OOMs, should we compile out krcuds
based on a config option (CONFIG_PREEMPT?). Any suggestions ?

Thanks
Dipankar


Reduce bh processing time of rcu callbacks by using tunable per-cpu
krcud daemeons.


 include/linux/rcupdate.h |    4 +
 kernel/rcupdate.c        |   99 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 101 insertions(+), 2 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-reduce-bh-time include/linux/rcupdate.h
--- linux-2.6.0-smprcu/include/linux/rcupdate.h~rcu-reduce-bh-time	2004-01-08 23:38:36.000000000 +0530
+++ linux-2.6.0-smprcu-dipankar/include/linux/rcupdate.h	2004-01-12 15:18:53.000000000 +0530
@@ -93,9 +93,11 @@ struct rcu_data {
 	long		qsctr;		 /* User-mode/idle loop etc. */
         long            last_qsctr;	 /* value of qsctr at beginning */
                                          /* of rcu grace period */
+	struct task_struct *krcud;
         long  	       	batch;           /* Batch # for current RCU batch */
         struct list_head  nxtlist;
         struct list_head  curlist;
+        struct list_head  rcudlist;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -103,9 +105,11 @@ extern struct rcu_ctrlblk rcu_ctrlblk;
 
 #define RCU_qsctr(cpu) 		(per_cpu(rcu_data, (cpu)).qsctr)
 #define RCU_last_qsctr(cpu) 	(per_cpu(rcu_data, (cpu)).last_qsctr)
+#define RCU_krcud(cpu) 		(per_cpu(rcu_data, (cpu)).krcud)
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
+#define RCU_rcudlist(cpu) 	(per_cpu(rcu_data, (cpu)).rcudlist)
 
 #define RCU_QSCTR_INVALID	0
 
diff -puN kernel/rcupdate.c~rcu-reduce-bh-time kernel/rcupdate.c
--- linux-2.6.0-smprcu/kernel/rcupdate.c~rcu-reduce-bh-time	2004-01-08 23:38:36.000000000 +0530
+++ linux-2.6.0-smprcu-dipankar/kernel/rcupdate.c	2004-01-14 13:37:05.000000000 +0530
@@ -54,6 +54,11 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
+#ifdef CONFIG_PREEMPT
+static int rcu_max_bh_callbacks = 256;
+#else 
+static int rcu_max_bh_callbacks = 0;
+#endif
 
 /**
  * call_rcu - Queue an RCU update request.
@@ -79,6 +84,13 @@ void call_rcu(struct rcu_head *head, voi
 	local_irq_restore(flags);
 }
 
+static inline unsigned int rcu_bh_callback_limit(int cpu)
+{
+	if (in_softirq() && RCU_krcud(cpu))
+		return rcu_max_bh_callbacks;
+	return (unsigned int)-1;
+}
+
 /*
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
@@ -87,13 +99,22 @@ static void rcu_do_batch(struct list_hea
 {
 	struct list_head *entry;
 	struct rcu_head *head;
+	unsigned int count = 0;
+	int cpu = smp_processor_id();
+	unsigned int limit = rcu_bh_callback_limit(cpu);
 
 	while (!list_empty(list)) {
 		entry = list->next;
 		list_del(entry);
 		head = list_entry(entry, struct rcu_head, list);
 		head->func(head->arg);
+		if (++count > limit && rq_has_rt_task(cpu)) {
+			list_splice(list, &RCU_rcudlist(cpu));
+			wake_up_process(RCU_krcud(cpu));
+			break;
+		}
 	}
+
 }
 
 /*
@@ -198,12 +219,67 @@ void rcu_check_callbacks(int cpu, int us
 	tasklet_schedule(&RCU_tasklet(cpu));
 }
 
+static int krcud(void * __bind_cpu)
+{
+	int cpu = (int) (long) __bind_cpu;
+
+	daemonize("krcud/%d", cpu);
+	set_user_nice(current, -19);
+	current->flags |= PF_IOTHREAD;
+
+	/* Migrate to the right CPU */
+	set_cpus_allowed(current, cpumask_of_cpu(cpu));
+	BUG_ON(smp_processor_id() != cpu);
+
+	__set_current_state(TASK_INTERRUPTIBLE);
+	mb();
+
+	RCU_krcud(cpu) = current;
+
+	for (;;) {
+		LIST_HEAD(list);
+
+		if (list_empty(&RCU_rcudlist(cpu)))
+			schedule();
+
+		__set_current_state(TASK_RUNNING);
+
+		local_bh_disable();
+		while (!list_empty(&RCU_rcudlist(cpu))) {
+			list_splice(&RCU_rcudlist(cpu), &list);
+			INIT_LIST_HEAD(&RCU_rcudlist(cpu));
+			local_bh_enable();
+			rcu_do_batch(&list);
+			cond_resched();
+			local_bh_disable();
+		}
+		local_bh_enable();
+
+		__set_current_state(TASK_INTERRUPTIBLE);
+	}
+}
+
+static int start_krcud(int cpu)
+{
+	if (rcu_max_bh_callbacks) {
+		if (kernel_thread(krcud, (void *)(long)cpu, CLONE_KERNEL) < 0) {
+			printk("krcud for %i failed\n", cpu);
+			return -1;
+		}
+
+		while (!RCU_krcud(cpu))
+			yield();
+	}
+	return 0;
+}
+
 static void __devinit rcu_online_cpu(int cpu)
 {
 	memset(&per_cpu(rcu_data, cpu), 0, sizeof(struct rcu_data));
 	tasklet_init(&RCU_tasklet(cpu), rcu_process_callbacks, 0UL);
 	INIT_LIST_HEAD(&RCU_nxtlist(cpu));
 	INIT_LIST_HEAD(&RCU_curlist(cpu));
+	INIT_LIST_HEAD(&RCU_rcudlist(cpu));
 }
 
 static int __devinit rcu_cpu_notify(struct notifier_block *self, 
@@ -214,6 +290,10 @@ static int __devinit rcu_cpu_notify(stru
 	case CPU_UP_PREPARE:
 		rcu_online_cpu(cpu);
 		break;
+	case CPU_ONLINE:
+		if (start_krcud(cpu) != 0)
+			return NOTIFY_BAD;
+		break;
 	/* Space reserved for CPU_OFFLINE :) */
 	default:
 		break;
@@ -233,12 +313,27 @@ static struct notifier_block __devinitda
  */
 void __init rcu_init(void)
 {
-	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
-			(void *)(long)smp_processor_id());
+	rcu_online_cpu(smp_processor_id());
 	/* Register notifier for non-boot CPUs */
 	register_cpu_notifier(&rcu_nb);
 }
 
+static int __init rcu_late_init(void)
+{
+	return start_krcud(smp_processor_id());
+}
+
+__initcall(rcu_late_init);
+
+static int __init rcu_bh_limit_setup(char *str)
+{
+	if (get_option(&str, &rcu_max_bh_callbacks) != 1)
+		BUG();
+	return 0;
+}
+
+__setup("rcubhlimit=", rcu_bh_limit_setup);
+
 
 /* Because of FASTCALL declaration of complete, we use this wrapper */
 static void wakeme_after_rcu(void *completion)

_
