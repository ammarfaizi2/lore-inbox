Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264363AbUAHLwJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 06:52:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264340AbUAHLuj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 06:50:39 -0500
Received: from e3.ny.us.ibm.com ([32.97.182.103]:37520 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S264358AbUAHLuA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 06:50:00 -0500
Date: Thu, 8 Jan 2004 17:20:51 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Rusty Russell <rusty@rustcorp.com.au>,
       Paul McKenney <paul.mckenney@us.ibm.com>
Subject: Re: [patch] RCU for low latency [2/2]
Message-ID: <20040108115051.GC5128@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <20040108114851.GA5128@in.ibm.com> <20040108114958.GB5128@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108114958.GB5128@in.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Reduce bh processing time of rcu callbacks by using tunable per-cpu
krcud daemeons.


 include/linux/rcupdate.h |    4 +
 kernel/rcupdate.c        |  101 ++++++++++++++++++++++++++++++++++++++++++++++-
 2 files changed, 103 insertions(+), 2 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-reduce-bh-time include/linux/rcupdate.h
--- linux-2.6.0-test8-smprcu/include/linux/rcupdate.h~rcu-reduce-bh-time	2003-12-29 22:50:32.000000000 +0530
+++ linux-2.6.0-test8-smprcu-dipankar/include/linux/rcupdate.h	2003-12-29 22:50:32.000000000 +0530
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
--- linux-2.6.0-test8-smprcu/kernel/rcupdate.c~rcu-reduce-bh-time	2003-12-29 22:50:32.000000000 +0530
+++ linux-2.6.0-test8-smprcu-dipankar/kernel/rcupdate.c	2003-12-29 22:50:32.000000000 +0530
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
 
+static inline int rcu_limiting_needed(int cpu)
+{
+	if (in_softirq() && RCU_krcud(cpu))
+		return 1;
+	return 0;
+}
+
 /*
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
@@ -87,13 +99,24 @@ static void rcu_do_batch(struct list_hea
 {
 	struct list_head *entry;
 	struct rcu_head *head;
+	int count = 0;
+	int cpu = smp_processor_id();
+	int limit = rcu_limiting_needed(cpu);
 
 	while (!list_empty(list)) {
 		entry = list->next;
 		list_del(entry);
 		head = list_entry(entry, struct rcu_head, list);
 		head->func(head->arg);
+		count++;
+		if (limit && count > rcu_max_bh_callbacks &&
+			rq_has_rt_task(cpu)) {
+			list_splice(list, &RCU_rcudlist(cpu));
+			wake_up_process(RCU_krcud(cpu));
+			break;
+		}
 	}
+
 }
 
 /*
@@ -198,12 +221,67 @@ void rcu_check_callbacks(int cpu, int us
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
@@ -214,6 +292,10 @@ static int __devinit rcu_cpu_notify(stru
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
@@ -233,12 +315,27 @@ static struct notifier_block __devinitda
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
