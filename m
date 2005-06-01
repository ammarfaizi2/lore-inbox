Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261498AbVFASIz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261498AbVFASIz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Jun 2005 14:08:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261487AbVFASIQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Jun 2005 14:08:16 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:7605 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP id S261528AbVFASEY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Jun 2005 14:04:24 -0400
Date: Wed, 1 Jun 2005 20:04:19 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [patch 9/11] s390: deadlock in appldata.
Message-ID: <20050601180419.GI6418@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[patch 9/11] s390: deadlock in appldata.

From: Gerald Schaefer <geraldsc@de.ibm.com>

The system might hang when using appldata_mem with high I/O traffic and
a large number of devices. The spinlocks bdev_lock and swaplock are
acquired via calls to si_meminfo() and si_swapinfo() from a tasklet,
i.e. interrupt context, which can lead to a deadlock. Replace tasklet
with work queue.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/appldata/appldata_base.c    |   72 +++++++++++++++++++---------------
 arch/s390/appldata/appldata_mem.c     |    2 
 arch/s390/appldata/appldata_net_sum.c |    2 
 arch/s390/appldata/appldata_os.c      |    4 -
 4 files changed, 45 insertions(+), 35 deletions(-)

diff -urpN linux-2.6/arch/s390/appldata/appldata_base.c linux-2.6-patched/arch/s390/appldata/appldata_base.c
--- linux-2.6/arch/s390/appldata/appldata_base.c	2005-03-02 08:38:37.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_base.c	2005-06-01 19:43:20.000000000 +0200
@@ -28,6 +28,7 @@
 //#include <linux/kernel_stat.h>
 #include <linux/notifier.h>
 #include <linux/cpu.h>
+#include <linux/workqueue.h>
 
 #include "appldata.h"
 
@@ -133,9 +134,12 @@ static int appldata_interval = APPLDATA_
 static int appldata_timer_active;
 
 /*
- * Tasklet
+ * Work queue
  */
-static struct tasklet_struct appldata_tasklet_struct;
+static struct workqueue_struct *appldata_wq;
+static void appldata_work_fn(void *data);
+static DECLARE_WORK(appldata_work, appldata_work_fn, NULL);
+
 
 /*
  * Ops list
@@ -144,11 +148,11 @@ static DEFINE_SPINLOCK(appldata_ops_lock
 static LIST_HEAD(appldata_ops_list);
 
 
-/************************* timer, tasklet, DIAG ******************************/
+/*************************** timer, work, DIAG *******************************/
 /*
  * appldata_timer_function()
  *
- * schedule tasklet and reschedule timer
+ * schedule work and reschedule timer
  */
 static void appldata_timer_function(unsigned long data, struct pt_regs *regs)
 {
@@ -157,22 +161,22 @@ static void appldata_timer_function(unsi
 		atomic_read(&appldata_expire_count));
 	if (atomic_dec_and_test(&appldata_expire_count)) {
 		atomic_set(&appldata_expire_count, num_online_cpus());
-		tasklet_schedule((struct tasklet_struct *) data);
+		queue_work(appldata_wq, (struct work_struct *) data);
 	}
 }
 
 /*
- * appldata_tasklet_function()
+ * appldata_work_fn()
  *
  * call data gathering function for each (active) module
  */
-static void appldata_tasklet_function(unsigned long data)
+static void appldata_work_fn(void *data)
 {
 	struct list_head *lh;
 	struct appldata_ops *ops;
 	int i;
 
-	P_DEBUG("  -= Tasklet =-\n");
+	P_DEBUG("  -= Work Queue =-\n");
 	i = 0;
 	spin_lock(&appldata_ops_lock);
 	list_for_each(lh, &appldata_ops_list) {
@@ -231,7 +235,7 @@ static int appldata_diag(char record_nr,
 			: "=d" (ry) : "d" (&(appldata_parameter_list)) : "cc");
 	return (int) ry;
 }
-/********************** timer, tasklet, DIAG <END> ***************************/
+/************************ timer, work, DIAG <END> ****************************/
 
 
 /****************************** /proc stuff **********************************/
@@ -411,7 +415,7 @@ appldata_generic_handler(ctl_table *ctl,
 	struct list_head *lh;
 
 	found = 0;
-	spin_lock_bh(&appldata_ops_lock);
+	spin_lock(&appldata_ops_lock);
 	list_for_each(lh, &appldata_ops_list) {
 		tmp_ops = list_entry(lh, struct appldata_ops, list);
 		if (&tmp_ops->ctl_table[2] == ctl) {
@@ -419,15 +423,15 @@ appldata_generic_handler(ctl_table *ctl,
 		}
 	}
 	if (!found) {
-		spin_unlock_bh(&appldata_ops_lock);
+		spin_unlock(&appldata_ops_lock);
 		return -ENODEV;
 	}
 	ops = ctl->data;
 	if (!try_module_get(ops->owner)) {	// protect this function
-		spin_unlock_bh(&appldata_ops_lock);
+		spin_unlock(&appldata_ops_lock);
 		return -ENODEV;
 	}
-	spin_unlock_bh(&appldata_ops_lock);
+	spin_unlock(&appldata_ops_lock);
 
 	if (!*lenp || *ppos) {
 		*lenp = 0;
@@ -451,10 +455,11 @@ appldata_generic_handler(ctl_table *ctl,
 		return -EFAULT;
 	}
 
-	spin_lock_bh(&appldata_ops_lock);
+	spin_lock(&appldata_ops_lock);
 	if ((buf[0] == '1') && (ops->active == 0)) {
-		if (!try_module_get(ops->owner)) {	// protect tasklet
-			spin_unlock_bh(&appldata_ops_lock);
+		// protect work queue callback
+		if (!try_module_get(ops->owner)) {
+			spin_unlock(&appldata_ops_lock);
 			module_put(ops->owner);
 			return -ENODEV;
 		}
@@ -485,7 +490,7 @@ appldata_generic_handler(ctl_table *ctl,
 		}
 		module_put(ops->owner);
 	}
-	spin_unlock_bh(&appldata_ops_lock);
+	spin_unlock(&appldata_ops_lock);
 out:
 	*lenp = len;
 	*ppos += len;
@@ -529,7 +534,7 @@ int appldata_register_ops(struct appldat
 	}
 	memset(ops->ctl_table, 0, 4*sizeof(struct ctl_table));
 
-	spin_lock_bh(&appldata_ops_lock);
+	spin_lock(&appldata_ops_lock);
 	list_for_each(lh, &appldata_ops_list) {
 		tmp_ops = list_entry(lh, struct appldata_ops, list);
 		P_DEBUG("register_ops loop: %i) name = %s, ctl = %i\n",
@@ -541,18 +546,18 @@ int appldata_register_ops(struct appldat
 				APPLDATA_PROC_NAME_LENGTH) == 0) {
 			P_ERROR("Name \"%s\" already registered!\n", ops->name);
 			kfree(ops->ctl_table);
-			spin_unlock_bh(&appldata_ops_lock);
+			spin_unlock(&appldata_ops_lock);
 			return -EBUSY;
 		}
 		if (tmp_ops->ctl_nr == ops->ctl_nr) {
 			P_ERROR("ctl_nr %i already registered!\n", ops->ctl_nr);
 			kfree(ops->ctl_table);
-			spin_unlock_bh(&appldata_ops_lock);
+			spin_unlock(&appldata_ops_lock);
 			return -EBUSY;
 		}
 	}
 	list_add(&ops->list, &appldata_ops_list);
-	spin_unlock_bh(&appldata_ops_lock);
+	spin_unlock(&appldata_ops_lock);
 
 	ops->ctl_table[0].ctl_name = CTL_APPLDATA;
 	ops->ctl_table[0].procname = appldata_proc_name;
@@ -583,12 +588,12 @@ int appldata_register_ops(struct appldat
  */
 void appldata_unregister_ops(struct appldata_ops *ops)
 {
-	spin_lock_bh(&appldata_ops_lock);
+	spin_lock(&appldata_ops_lock);
 	unregister_sysctl_table(ops->sysctl_header);
 	list_del(&ops->list);
 	kfree(ops->ctl_table);
 	ops->ctl_table = NULL;
-	spin_unlock_bh(&appldata_ops_lock);
+	spin_unlock(&appldata_ops_lock);
 	P_INFO("%s-ops unregistered!\n", ops->name);
 }
 /********************** module-ops management <END> **************************/
@@ -602,7 +607,7 @@ appldata_online_cpu(int cpu)
 	init_virt_timer(&per_cpu(appldata_timer, cpu));
 	per_cpu(appldata_timer, cpu).function = appldata_timer_function;
 	per_cpu(appldata_timer, cpu).data = (unsigned long)
-		&appldata_tasklet_struct;
+		&appldata_work;
 	atomic_inc(&appldata_expire_count);
 	spin_lock(&appldata_timer_lock);
 	__appldata_vtimer_setup(APPLDATA_MOD_TIMER);
@@ -615,7 +620,7 @@ appldata_offline_cpu(int cpu)
 	del_virt_timer(&per_cpu(appldata_timer, cpu));
 	if (atomic_dec_and_test(&appldata_expire_count)) {
 		atomic_set(&appldata_expire_count, num_online_cpus());
-		tasklet_schedule(&appldata_tasklet_struct);
+		queue_work(appldata_wq, &appldata_work);
 	}
 	spin_lock(&appldata_timer_lock);
 	__appldata_vtimer_setup(APPLDATA_MOD_TIMER);
@@ -648,7 +653,7 @@ static struct notifier_block __devinitda
 /*
  * appldata_init()
  *
- * init timer and tasklet, register /proc entries
+ * init timer, register /proc entries
  */
 static int __init appldata_init(void)
 {
@@ -657,6 +662,12 @@ static int __init appldata_init(void)
 	P_DEBUG("sizeof(parameter_list) = %lu\n",
 		sizeof(struct appldata_parameter_list));
 
+	appldata_wq = create_singlethread_workqueue("appldata");
+	if (!appldata_wq) {
+		P_ERROR("Could not create work queue\n");
+		return -ENOMEM;
+	}
+
 	for_each_online_cpu(i)
 		appldata_online_cpu(i);
 
@@ -670,7 +681,6 @@ static int __init appldata_init(void)
 	appldata_table[1].de->owner = THIS_MODULE;
 #endif
 
-	tasklet_init(&appldata_tasklet_struct, appldata_tasklet_function, 0);
 	P_DEBUG("Base interface initialized.\n");
 	return 0;
 }
@@ -678,7 +688,7 @@ static int __init appldata_init(void)
 /*
  * appldata_exit()
  *
- * stop timer and tasklet, unregister /proc entries
+ * stop timer, unregister /proc entries
  */
 static void __exit appldata_exit(void)
 {
@@ -690,7 +700,7 @@ static void __exit appldata_exit(void)
 	/*
 	 * ops list should be empty, but just in case something went wrong...
 	 */
-	spin_lock_bh(&appldata_ops_lock);
+	spin_lock(&appldata_ops_lock);
 	list_for_each(lh, &appldata_ops_list) {
 		ops = list_entry(lh, struct appldata_ops, list);
 		rc = appldata_diag(ops->record_nr, APPLDATA_STOP_REC,
@@ -700,7 +710,7 @@ static void __exit appldata_exit(void)
 				"return code: %d\n", ops->name, rc);
 		}
 	}
-	spin_unlock_bh(&appldata_ops_lock);
+	spin_unlock(&appldata_ops_lock);
 
 	for_each_online_cpu(i)
 		appldata_offline_cpu(i);
@@ -709,7 +719,7 @@ static void __exit appldata_exit(void)
 
 	unregister_sysctl_table(appldata_sysctl_header);
 
-	tasklet_kill(&appldata_tasklet_struct);
+	destroy_workqueue(appldata_wq);
 	P_DEBUG("... module unloaded!\n");
 }
 /**************************** init / exit <END> ******************************/
diff -urpN linux-2.6/arch/s390/appldata/appldata_mem.c linux-2.6-patched/arch/s390/appldata/appldata_mem.c
--- linux-2.6/arch/s390/appldata/appldata_mem.c	2005-03-02 08:37:48.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_mem.c	2005-06-01 19:43:20.000000000 +0200
@@ -68,7 +68,7 @@ struct appldata_mem_data {
 	u64 pgmajfault;		/* page faults (major only) */
 // <-- New in 2.6
 
-} appldata_mem_data;
+} __attribute__((packed)) appldata_mem_data;
 
 
 static inline void appldata_debug_print(struct appldata_mem_data *mem_data)
diff -urpN linux-2.6/arch/s390/appldata/appldata_net_sum.c linux-2.6-patched/arch/s390/appldata/appldata_net_sum.c
--- linux-2.6/arch/s390/appldata/appldata_net_sum.c	2005-03-02 08:38:07.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_net_sum.c	2005-06-01 19:43:20.000000000 +0200
@@ -57,7 +57,7 @@ struct appldata_net_sum_data {
 	u64 rx_dropped;		/* no space in linux buffers     */
 	u64 tx_dropped;		/* no space available in linux   */
 	u64 collisions;		/* collisions while transmitting */
-} appldata_net_sum_data;
+} __attribute__((packed)) appldata_net_sum_data;
 
 
 static inline void appldata_print_debug(struct appldata_net_sum_data *net_data)
diff -urpN linux-2.6/arch/s390/appldata/appldata_os.c linux-2.6-patched/arch/s390/appldata/appldata_os.c
--- linux-2.6/arch/s390/appldata/appldata_os.c	2005-03-02 08:38:33.000000000 +0100
+++ linux-2.6-patched/arch/s390/appldata/appldata_os.c	2005-06-01 19:43:20.000000000 +0200
@@ -49,7 +49,7 @@ struct appldata_os_per_cpu {
 	u32 per_cpu_softirq;	/* ... spent in softirqs            */
 	u32 per_cpu_iowait;	/* ... spent while waiting for I/O  */
 // <-- New in 2.6
-};
+} __attribute__((packed));
 
 struct appldata_os_data {
 	u64 timestamp;
@@ -75,7 +75,7 @@ struct appldata_os_data {
 
 	/* per cpu data */
 	struct appldata_os_per_cpu os_cpu[0];
-};
+} __attribute__((packed));
 
 static struct appldata_os_data *appldata_os_data;
 
