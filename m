Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262431AbUCWKSw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Mar 2004 05:18:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262434AbUCWKSw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Mar 2004 05:18:52 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:35797 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262431AbUCWKSm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Mar 2004 05:18:42 -0500
Date: Tue, 23 Mar 2004 15:47:55 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: tiwai@suse.de
Cc: Andrea Arcangeli <andrea@suse.de>, Robert Love <rml@ximian.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: [PATCH] RCU for low latency (experimental)
Message-ID: <20040323101755.GC3676@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the RCU patch for low scheduling latency Andrew was talking
about in the other thread. I had done some measurements with
amlat on a 2.4 GHz P4 xeon box with 256MB memory running dbench
and it reduced worst case scheduling latencies from 800 microseconds
to about 400 microseconds.

It uses per-cpu kernel threads to execute excess callbacks and
pretty much relies on preemption. I added a CONFIG_LOW_LATENCY
option to make this conditional. The amount of callbacks to
invoke in softirq before punting to krcud can be set at boot
time using rcupdate.bhlimit parameter. The whole thing is meant
for experimenting only. The negative side of doing RCU this way
is that we may further delay the grace period with the 
RCU kernel thread  and thus there can be OOM situations.

I would be interested in all issues with this patch including 
latencies and OOM situations.

Dipankar



Reduce bh processing time of rcu callbacks by using tunable per-cpu
krcud daemeons.


 include/linux/rcupdate.h |    4 ++
 include/linux/sched.h    |    1 
 init/Kconfig             |    9 ++++
 kernel/rcupdate.c        |   91 +++++++++++++++++++++++++++++++++++++++++++++--
 kernel/sched.c           |    6 +++
 5 files changed, 108 insertions(+), 3 deletions(-)

diff -puN include/linux/rcupdate.h~rcu-low-lat include/linux/rcupdate.h
--- linux-2.6.4-rcu/include/linux/rcupdate.h~rcu-low-lat	2004-03-23 15:20:11.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/include/linux/rcupdate.h	2004-03-23 15:20:11.000000000 +0530
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
 
diff -puN include/linux/sched.h~rcu-low-lat include/linux/sched.h
--- linux-2.6.4-rcu/include/linux/sched.h~rcu-low-lat	2004-03-23 15:20:11.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/include/linux/sched.h	2004-03-23 15:20:12.000000000 +0530
@@ -552,6 +552,7 @@ extern int task_prio(task_t *p);
 extern int task_nice(task_t *p);
 extern int task_curr(task_t *p);
 extern int idle_cpu(int cpu);
+extern int rq_has_rt_task(int cpu);
 
 void yield(void);
 
diff -puN init/Kconfig~rcu-low-lat init/Kconfig
--- linux-2.6.4-rcu/init/Kconfig~rcu-low-lat	2004-03-23 15:20:11.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/init/Kconfig	2004-03-23 15:20:12.000000000 +0530
@@ -156,6 +156,14 @@ config HOTPLUG
 	  agent" (/sbin/hotplug) to load modules and set up software needed
 	  to use devices as you hotplug them.
 
+config LOW_LATENCY
+	 bool "Enable kernel features for low scheduling latency" if EXPERIMENTAL
+	 default n
+	---help---
+	   This option enables various features in the kernel that
+	   help reduce scheduling latency while potentially sacrificing
+	   throughput.
+
 config IKCONFIG
 	bool "Kernel .config support"
 	---help---
@@ -181,7 +189,6 @@ config IKCONFIG_PROC
 	  This option enables access to kernel configuration file and build
 	  information through /proc/config.gz.
 
-
 menuconfig EMBEDDED
 	bool "Remove kernel features (for embedded systems)"
 	help
diff -puN kernel/rcupdate.c~rcu-low-lat kernel/rcupdate.c
--- linux-2.6.4-rcu/kernel/rcupdate.c~rcu-low-lat	2004-03-23 15:20:11.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/kernel/rcupdate.c	2004-03-23 15:21:12.000000000 +0530
@@ -39,6 +39,7 @@
 #include <asm/atomic.h>
 #include <asm/bitops.h>
 #include <linux/module.h>
+#include <linux/moduleparam.h>
 #include <linux/completion.h>
 #include <linux/percpu.h>
 #include <linux/notifier.h>
@@ -54,6 +55,11 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
+#ifdef CONFIG_LOW_LATENCY
+static int bhlimit = 256;
+#else 
+static int bhlimit = 0;
+#endif
 
 /**
  * call_rcu - Queue an RCU update request.
@@ -79,6 +85,13 @@ void fastcall call_rcu(struct rcu_head *
 	local_irq_restore(flags);
 }
 
+static inline unsigned int rcu_bh_callback_limit(int cpu)
+{
+	if (in_softirq() && RCU_krcud(cpu))
+		return bhlimit;
+	return (unsigned int)-1;
+}
+
 /*
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
@@ -87,13 +100,22 @@ static void rcu_do_batch(struct list_hea
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
@@ -198,12 +220,67 @@ void rcu_check_callbacks(int cpu, int us
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
+	if (bhlimit) {
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
@@ -214,6 +291,10 @@ static int __devinit rcu_cpu_notify(stru
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
@@ -233,12 +314,17 @@ static struct notifier_block __devinitda
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
 
 /* Because of FASTCALL declaration of complete, we use this wrapper */
 static void wakeme_after_rcu(void *completion)
@@ -262,6 +348,7 @@ void synchronize_kernel(void)
 	wait_for_completion(&completion);
 }
 
+module_param(bhlimit, int, 0);
 
 EXPORT_SYMBOL(call_rcu);
 EXPORT_SYMBOL(synchronize_kernel);
diff -puN kernel/sched.c~rcu-low-lat kernel/sched.c
--- linux-2.6.4-rcu/kernel/sched.c~rcu-low-lat	2004-03-23 15:20:11.000000000 +0530
+++ linux-2.6.4-rcu-dipankar/kernel/sched.c	2004-03-23 15:20:12.000000000 +0530
@@ -341,6 +341,12 @@ static inline void enqueue_task(struct t
 	p->array = array;
 }
 
+int rq_has_rt_task(int cpu)
+{
+        runqueue_t *rq = cpu_rq(cpu);
+        return (sched_find_first_bit(rq->active->bitmap) < MAX_RT_PRIO);
+}
+
 /*
  * effective_prio - return the priority that is based on the static
  * priority but is modified by bonuses/penalties.

_
