Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932142AbWBFOvz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932142AbWBFOvz (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Feb 2006 09:51:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWBFOvz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Feb 2006 09:51:55 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:51652 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932134AbWBFOvy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Feb 2006 09:51:54 -0500
Date: Mon, 6 Feb 2006 08:51:37 -0600
From: Dimitri Sivanich <sivanich@sgi.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       "Paul E. McKenney" <paulmck@us.ibm.com>,
       Dipankar Sarma <dipankar@in.ibm.com>, mason@suse.de, okir@suse.de
Subject: [PATCH] Enable remote RCU callback processing on SMP systems
Message-ID: <20060206145137.GA30059@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Reposting this patch that I'd submitted back on 1/26.  Any thoughts on
the basic approach in addition to the code itself?  Is it possible to
get this applied?  Note that this should have negligible effect on
those not configuring remote rcu callback processing.


The purpose of the patch I'm proposing is to reduce unexpected rcu
callback latencies on selected cpus.  Latencies caused by processing
certain rcu callbacks can be quite substantial, such as those
concerning file_free_rcu() for example.  This was previously mentioned
in the following posts:

	lkml/2005/10/20/62
	lkml/2005/12/20/93


This patch enables specified cpus to be setup for remote rcu callback
processing.  This can be done either at boot time or dynamically.

The cpus setup for remote callback processing do not process their own
rcu callbacks, but do go through the normal quiescent state processing.
There is no locking being added for the remote callback cpus.  The cpus
not setup as remote callback cpus pull the donelists of callbacks from
the next remote callback cpu and process the list.

Signed-off-by: Dimitri Sivanich <sivanich@sgi.com>

Index: linux/kernel/rcupdate.c
===================================================================
--- linux.orig/kernel/rcupdate.c	2006-01-26 11:42:39.057950013 -0600
+++ linux/kernel/rcupdate.c	2006-01-26 11:42:55.847318916 -0600
@@ -103,6 +103,91 @@ static atomic_t rcu_barrier_cpu_count;
 static struct semaphore rcu_barrier_sema;
 static struct completion rcu_barrier_completion;
 
+/*
+ * Routines for setting up cpus for remote callback processing.
+ * This is done to improve determinism on specified cpus.
+ */
+#define rcu_remote_online_cpus(_m_) \
+	cpus_and((_m_), cpu_remotercu_map, cpu_online_map)
+
+static int cpu_remotercu_next = -1;
+static cpumask_t cpu_remotercu_map = CPU_MASK_NONE;
+static spinlock_t cpu_remotercu_lock = SPIN_LOCK_UNLOCKED;
+
+static inline int is_remote_rcu(void) {
+	cpumask_t mask;
+
+	rcu_remote_online_cpus(mask);
+	return cpu_isset(smp_processor_id(), mask);
+}
+
+static inline int rcu_remote_rcus(void)
+{
+	cpumask_t mask;
+
+	rcu_remote_online_cpus(mask);
+	return !cpus_empty(mask);
+}
+
+/* Get the next cpu to do remote callback processing on */
+static inline int rcu_next_remotercu(void)
+{
+	cpumask_t mask;
+	unsigned long flags;
+	int cpu;
+
+	rcu_remote_online_cpus(mask);
+	if (cpus_empty(mask))
+		return -1;
+	spin_lock_irqsave(&cpu_remotercu_lock, flags);
+	cpu_remotercu_next=next_cpu(cpu_remotercu_next, mask);
+	if (cpu_remotercu_next >= NR_CPUS) {
+		cpu_remotercu_next = first_cpu(mask);
+	}
+	cpu = cpu_remotercu_next;
+	spin_unlock_irqrestore(&cpu_remotercu_lock, flags);
+
+	return cpu;
+}
+
+int rcu_set_remote_rcu(int cpu) {
+	unsigned long flags;
+
+	if (cpu < NR_CPUS) {
+		spin_lock_irqsave(&cpu_remotercu_lock, flags);
+		cpu_set(cpu, cpu_remotercu_map);
+		spin_unlock_irqrestore(&cpu_remotercu_lock, flags);
+		return 0;
+	} else
+		return 1;
+}
+EXPORT_SYMBOL(rcu_set_remote_rcu);
+
+void rcu_clear_remote_rcu(int cpu) {
+	unsigned long flags;
+
+	if (cpu < NR_CPUS) {
+		spin_lock_irqsave(&cpu_remotercu_lock, flags);
+		cpu_clear(cpu, cpu_remotercu_map);
+		spin_unlock_irqrestore(&cpu_remotercu_lock, flags);
+	}
+}
+EXPORT_SYMBOL(rcu_clear_remote_rcu);
+
+/* Setup the mask of cpus configured for remote callback processing */
+static int __init rcu_remotercu_cpu_setup(char *str)
+{
+	int cpus[NR_CPUS], i;
+
+	str = get_options(str, ARRAY_SIZE(cpus), cpus);
+	cpus_clear(cpu_remotercu_map);
+	for (i = 1; i <= cpus[0]; i++)
+		rcu_set_remote_rcu(cpus[i]);
+	cpu_remotercu_next = first_cpu(cpu_remotercu_map);
+	return 1;
+}
+
+__setup ("remotercu=", rcu_remotercu_cpu_setup);
 /**
  * call_rcu_bh - Queue an RCU for invocation after a quicker grace period.
  * @head: structure to be used for queueing the RCU updates.
@@ -351,6 +436,8 @@ static void rcu_offline_cpu(int cpu)
 	struct rcu_data *this_rdp = &get_cpu_var(rcu_data);
 	struct rcu_data *this_bh_rdp = &get_cpu_var(rcu_bh_data);
 
+	rcu_clear_remote_rcu(cpu);
+
 	__rcu_offline_cpu(this_rdp, &rcu_ctrlblk,
 					&per_cpu(rcu_data, cpu));
 	__rcu_offline_cpu(this_bh_rdp, &rcu_bh_ctrlblk,
@@ -411,14 +498,62 @@ static void __rcu_process_callbacks(stru
 		local_irq_enable();
 	}
 	rcu_check_quiescent_state(rcp, rdp);
-	if (rdp->donelist)
+	/* Prevent remote cpu's from accessing donelist */
+	if (likely(!is_remote_rcu()))
+		rdp->doneself = 0;
+	if (rdp->donelist && !is_remote_rcu()) {
 		rcu_do_batch(rdp);
+	}
+	if (unlikely(is_remote_rcu()))
+		rdp->doneself = 1;
+}
+
+static inline void __rcu_process_remote_callbacks(void)
+{
+	struct rcu_data *rdp;
+	struct rcu_head * list = NULL;
+	struct rcu_head * list_bh = NULL;
+	int cpu;
+
+
+	if (likely(!rcu_remote_rcus() || is_remote_rcu())) {
+		return;
+	}
+	cpu = rcu_next_remotercu();
+	/* Just in case.. */
+	if (unlikely(cpu == -1)) {
+		return;
+	}
+	rdp = &per_cpu(rcu_data, cpu);
+	/*
+	 * The xchg prevents multiple cpus from processing the same
+	 * list simulataneously.
+	 */
+	if (rdp->doneself && (list = xchg(&rdp->donelist, NULL))!=NULL) {
+		rdp->count = 0;
+		rdp->donetail = &rdp->donelist;
+	}
+	rdp = &per_cpu(rcu_bh_data, cpu);
+	if (rdp->doneself && (list_bh = xchg(&rdp->donelist, NULL))!=NULL) {
+		rdp->count = 0;
+		rdp->donetail = &rdp->donelist;
+	}
+
+	while (list) {
+		list->func(list);
+		list = list->next;
+	}
+	while (list_bh) {
+		list_bh->func(list_bh);
+		list_bh = list_bh->next;
+	}
 }
 
 static void rcu_process_callbacks(unsigned long unused)
 {
 	__rcu_process_callbacks(&rcu_ctrlblk, &__get_cpu_var(rcu_data));
 	__rcu_process_callbacks(&rcu_bh_ctrlblk, &__get_cpu_var(rcu_bh_data));
+	__rcu_process_remote_callbacks();
 }
 
 static int __rcu_pending(struct rcu_ctrlblk *rcp, struct rcu_data *rdp)
@@ -447,6 +582,9 @@ static int __rcu_pending(struct rcu_ctrl
 
 int rcu_pending(int cpu)
 {
+	/* If any cpus setup for remote callbacks, schedule tasklet anyway. */
+	if (unlikely(rcu_remote_rcus()) && !is_remote_rcu())
+		tasklet_schedule(&per_cpu(rcu_tasklet, cpu));
 	return __rcu_pending(&rcu_ctrlblk, &per_cpu(rcu_data, cpu)) ||
 		__rcu_pending(&rcu_bh_ctrlblk, &per_cpu(rcu_bh_data, cpu));
 }
Index: linux/include/linux/rcupdate.h
===================================================================
--- linux.orig/include/linux/rcupdate.h	2006-01-26 11:42:39.065761747 -0600
+++ linux/include/linux/rcupdate.h	2006-01-26 11:42:55.863918850 -0600
@@ -103,6 +103,7 @@ struct rcu_data {
 	struct rcu_head **curtail;
 	struct rcu_head *donelist;
 	struct rcu_head **donetail;
+	int doneself;
 	int cpu;
 	struct rcu_head barrier;
 };

