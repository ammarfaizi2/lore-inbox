Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265232AbUBEN1w (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 08:27:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265233AbUBEN1w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 08:27:52 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:33771 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S265232AbUBEN1r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 08:27:47 -0500
Date: Thu, 5 Feb 2004 18:58:09 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: linux-kernel@vger.kernel.org
Cc: Nikita Danilov <Nikita@Namesys.COM>
Subject: [PATCH] RCU barrier
Message-ID: <20040205132809.GE3703@in.ibm.com>
Reply-To: dipankar@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch introduces a new interface - rcu_barrier() which waits
until all the RCUs queued until this call have been completed.
Nikita asked for this quite a while ago for reiser4 jnodes.
Sorry Nikita, if you are still using RCU in new reiserfs, 
you don't need to use your own logic for this now. Just	
call rcu_barrier() during umount.

If Nikita or other users use it, then I would like to push for
including this.

Thanks
Dipankar


Implements an RCU barrier that waits for all the in-flight RCUs to
complete.


 include/linux/rcupdate.h |    3 +++
 kernel/rcupdate.c        |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 40 insertions(+)

diff -puN include/linux/rcupdate.h~rcu-barrier include/linux/rcupdate.h
--- linux-2.6.2-rcu/include/linux/rcupdate.h~rcu-barrier	2004-02-05 16:21:07.000000000 +0530
+++ linux-2.6.2-rcu-dipankar/include/linux/rcupdate.h	2004-02-05 16:24:49.000000000 +0530
@@ -96,6 +96,7 @@ struct rcu_data {
         long  	       	batch;           /* Batch # for current RCU batch */
         struct list_head  nxtlist;
         struct list_head  curlist;
+	struct rcu_head barrier;
 };
 
 DECLARE_PER_CPU(struct rcu_data, rcu_data);
@@ -106,6 +107,7 @@ extern struct rcu_ctrlblk rcu_ctrlblk;
 #define RCU_batch(cpu) 		(per_cpu(rcu_data, (cpu)).batch)
 #define RCU_nxtlist(cpu) 	(per_cpu(rcu_data, (cpu)).nxtlist)
 #define RCU_curlist(cpu) 	(per_cpu(rcu_data, (cpu)).curlist)
+#define RCU_barrier(cpu) 	(per_cpu(rcu_data, (cpu)).barrier)
 
 #define RCU_QSCTR_INVALID	0
 
@@ -131,6 +133,7 @@ extern void rcu_check_callbacks(int cpu,
 extern void FASTCALL(call_rcu(struct rcu_head *head, 
                           void (*func)(void *arg), void *arg));
 extern void synchronize_kernel(void);
+extern void rcu_barrier(void);
 
 #endif /* __KERNEL__ */
 #endif /* __LINUX_RCUPDATE_H */
diff -puN kernel/rcupdate.c~rcu-barrier kernel/rcupdate.c
--- linux-2.6.2-rcu/kernel/rcupdate.c~rcu-barrier	2004-02-05 16:21:07.000000000 +0530
+++ linux-2.6.2-rcu-dipankar/kernel/rcupdate.c	2004-02-05 17:04:23.000000000 +0530
@@ -54,6 +54,9 @@ DEFINE_PER_CPU(struct rcu_data, rcu_data
 /* Fake initialization required by compiler */
 static DEFINE_PER_CPU(struct tasklet_struct, rcu_tasklet) = {NULL};
 #define RCU_tasklet(cpu) (per_cpu(rcu_tasklet, cpu))
+static atomic_t rcu_barrier_cpu_count;
+static struct semaphore rcu_barrier_sema;
+static struct completion rcu_barrier_completion;
 
 /**
  * call_rcu - Queue an RCU update request.
@@ -79,6 +82,39 @@ void call_rcu(struct rcu_head *head, voi
 	local_irq_restore(flags);
 }
 
+static void rcu_barrier_callback(void *notused)
+{
+	if (atomic_dec_and_test(&rcu_barrier_cpu_count))
+		complete(&rcu_barrier_completion);
+}
+
+static void rcu_barrier_func(void *notused)
+{
+	int cpu = get_cpu();
+	struct rcu_head *head;
+
+	head = &RCU_barrier(cpu);
+	atomic_inc(&rcu_barrier_cpu_count);
+	call_rcu(head, rcu_barrier_callback, NULL);
+	put_cpu_no_resched();
+}
+
+/**
+ * rcu_barrier - Wait until all the in-flight RCUs are complete.
+ */
+void rcu_barrier(void)
+{
+	BUG_ON(in_interrupt());
+	/* Take cpucontrol semaphore to protect against CPU hotplug */
+	down(&rcu_barrier_sema);
+	init_completion(&rcu_barrier_completion);
+	atomic_set(&rcu_barrier_cpu_count, 0);
+	rcu_barrier_func(NULL);
+	smp_call_function(rcu_barrier_func, NULL, 0, 1);
+	wait_for_completion(&rcu_barrier_completion);
+	up(&rcu_barrier_sema);
+}
+	
 /*
  * Invoke the completed RCU callbacks. They are expected to be in
  * a per-cpu list.
@@ -233,6 +269,7 @@ static struct notifier_block __devinitda
  */
 void __init rcu_init(void)
 {
+	sema_init(&rcu_barrier_sema, 1);
 	rcu_cpu_notify(&rcu_nb, CPU_UP_PREPARE,
 			(void *)(long)smp_processor_id());
 	/* Register notifier for non-boot CPUs */

_
