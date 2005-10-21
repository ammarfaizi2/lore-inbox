Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751217AbVJXSCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751217AbVJXSCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Oct 2005 14:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751214AbVJXSCn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Oct 2005 14:02:43 -0400
Received: from fmr24.intel.com ([143.183.121.16]:10672 "EHLO
	scsfmr004.sc.intel.com") by vger.kernel.org with ESMTP
	id S1751212AbVJXSCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Oct 2005 14:02:22 -0400
Message-Id: <20051021204327.843400000@araj-sfield>
References: <20051021203818.753754000@araj-sfield>
Date: Fri, 21 Oct 2005 13:38:22 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: akpm@osdl.org, linux@brodo.de
Cc: davej@redhat.com, zwane@arm.linux.org.uk, linux-kernel@vger.kernel.org,
       Ashok Raj <ashok.raj@intel.com>,
       Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Subject: [patch 4/4] create and destroy cpufreq sysfs entries based on cpu notifiers.
Content-Disposition: inline; filename=dynamic-sysfs-cpufreq
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

cpufreq entries in sysfs should only be populated when CPU is online state.
When we either boot with maxcpus=x and then boot the other cpus by 
echoing to sysfs online file, these entries should be created and destroyed
when CPU_DEAD is notified. Same treatement as cache entries under sysfs.

We place the processor in the lowest frequency, so hw managed P-State 
transitions can still work on the other threads to save power.

Primary goal was to just make these directories appear/disapper dynamically.

There is one in this patch i had to do, which i really dont like myself
but probably best if someone handling the cpufreq infrastructure could give
this code right treatment if this is not acceptable. I guess its probably
good for the first cut.

- Converting lock_cpu_hotplug()/unlock_cpu_hotplug() to disable/enable preempt.
  The locking was smack in the middle of the notification path, when the
  hotplug is already holding the lock. I tried another solution to avoid this
  so avoid taking locks if we know we are from notification path. The solution
  was getting very ugly and i decided this was probably good for this iteration
  until someone who understands cpufreq could do a better job than me.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

----------------------------------------------------------
 drivers/cpufreq/cpufreq.c       |   68 +++++++++++++++++++++++++++++++++++++---
 drivers/cpufreq/cpufreq_stats.c |   42 ++++++++++++++++++++++--
 2 files changed, 102 insertions(+), 8 deletions(-)

Index: linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/drivers/cpufreq/cpufreq.c
+++ linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq.c
@@ -3,6 +3,9 @@
  *
  *  Copyright (C) 2001 Russell King
  *            (C) 2002 - 2003 Dominik Brodowski <linux@brodo.de>
+ *
+ *  Oct 2005 - Ashok Raj <ashok.raj@intel.com>
+ *         		Added handling for CPU hotplug
  *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
@@ -567,6 +570,9 @@ static int cpufreq_add_dev (struct sys_d
 	unsigned long flags;
 	unsigned int j;
 
+	if (cpu_is_offline(cpu))
+		return 0;
+
 	cpufreq_debug_disable_ratelimit();
 	dprintk("adding CPU %u\n", cpu);
 
@@ -672,7 +678,7 @@ err_out:
 
 nomem_out:
 	module_put(cpufreq_driver->owner);
- module_out:
+module_out:
 	cpufreq_debug_enable_ratelimit();
 	return ret;
 }
@@ -761,7 +767,6 @@ static int cpufreq_remove_dev (struct sy
 	down(&data->lock);
 	if (cpufreq_driver->target)
 		__cpufreq_governor(data, CPUFREQ_GOV_STOP);
-	cpufreq_driver->target = NULL;
 	up(&data->lock);
 
 	kobject_unregister(&data->kobj);
@@ -1108,12 +1113,26 @@ int __cpufreq_driver_target(struct cpufr
 			    unsigned int relation)
 {
 	int retval = -EINVAL;
-	lock_cpu_hotplug();
+
+	/*
+	 * Converted the lock_cpu_hotplug to preempt_disable()
+	 * and preempt enable. This is a bit kludgy and relies on
+	 * how cpu hotplug works. All we need is a gaurantee that cpu hotplug
+	 * wont make progress on any cpu. Once we do preempt_disable(), this
+	 * would ensure hotplug threads dont get on this cpu, thereby delaying
+	 * the cpu remove process.
+	 *
+	 * we removed the lock_cpu_hotplug since we need to call this function via
+	 * cpu hotplug callbacks, which result in locking the cpu hotplug
+	 * thread itself. Agree this is not very clean, cpufreq community
+	 * could improve this if required. - Ashok Raj <ashok.raj@intel.com>
+	 */
+	preempt_disable();
 	dprintk("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
 		target_freq, relation);
 	if (cpu_online(policy->cpu) && cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
-	unlock_cpu_hotplug();
+	preempt_enable();
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
@@ -1405,6 +1424,45 @@ int cpufreq_update_policy(unsigned int c
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
 
+static int __cpuinit cpufreq_cpu_callback(struct notifier_block *nfb,
+						unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+	struct cpufreq_policy *policy;
+	struct sys_device *sys_dev;
+
+	sys_dev = get_cpu_sysdev(cpu);
+
+	if (sys_dev) {
+		switch (action) {
+			case CPU_ONLINE:
+				(void) cpufreq_add_dev(sys_dev);
+				break;
+			case CPU_DOWN_PREPARE:
+				/*
+				 * We attempt to put this cpu in lowest frequency possible
+				 * before going down. This will permit hardware managed
+				 * P-State to switch other related threads to min or
+				 * higher speeds if possible.
+				 */
+				policy = cpufreq_cpu_data[cpu];
+				if (policy) {
+					cpufreq_driver_target(policy, policy->min,
+							CPUFREQ_RELATION_H);
+				}
+				break;
+			case CPU_DEAD:
+				(void) cpufreq_remove_dev(sys_dev);
+				break;
+		}
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpufreq_cpu_notifier =
+{
+    .notifier_call = cpufreq_cpu_callback,
+};
 
 /*********************************************************************
  *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
@@ -1465,6 +1523,7 @@ int cpufreq_register_driver(struct cpufr
 	}
 
 	if (!ret) {
+		register_cpu_notifier(&cpufreq_cpu_notifier);
 		dprintk("driver %s up and running\n", driver_data->name);
 		cpufreq_debug_enable_ratelimit();
 	}
@@ -1496,6 +1555,7 @@ int cpufreq_unregister_driver(struct cpu
 	dprintk("unregistering driver %s\n", driver->name);
 
 	sysdev_driver_unregister(&cpu_sysdev_class, &cpufreq_sysdev_driver);
+	unregister_cpu_notifier(&cpufreq_cpu_notifier);
 
 	spin_lock_irqsave(&cpufreq_driver_lock, flags);
 	cpufreq_driver = NULL;
Index: linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- linux-2.6.14-rc4-mm1.orig/drivers/cpufreq/cpufreq_stats.c
+++ linux-2.6.14-rc4-mm1/drivers/cpufreq/cpufreq_stats.c
@@ -19,6 +19,7 @@
 #include <linux/percpu.h>
 #include <linux/kobject.h>
 #include <linux/spinlock.h>
+#include <linux/notifier.h>
 #include <asm/cputime.h>
 
 static spinlock_t cpufreq_stats_lock;
@@ -296,6 +297,27 @@ cpufreq_stat_notifier_trans (struct noti
 	return 0;
 }
 
+static int __cpuinit cpufreq_stat_cpu_callback(struct notifier_block *nfb,
+						unsigned long action, void *hcpu)
+{
+	unsigned int cpu = (unsigned long)hcpu;
+
+	switch (action) {
+		case CPU_ONLINE:
+			cpufreq_update_policy(cpu);
+			break;
+		case CPU_DEAD:
+			cpufreq_stats_free_table(cpu);
+			break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpufreq_stat_cpu_notifier =
+{
+    .notifier_call = cpufreq_stat_cpu_callback,
+};
+
 static struct notifier_block notifier_policy_block = {
 	.notifier_call = cpufreq_stat_notifier_policy
 };
@@ -309,6 +331,7 @@ __init cpufreq_stats_init(void)
 {
 	int ret;
 	unsigned int cpu;
+
 	spin_lock_init(&cpufreq_stats_lock);
 	if ((ret = cpufreq_register_notifier(&notifier_policy_block,
 				CPUFREQ_POLICY_NOTIFIER)))
@@ -321,20 +344,31 @@ __init cpufreq_stats_init(void)
 		return ret;
 	}
 
-	for_each_cpu(cpu)
-		cpufreq_update_policy(cpu);
+	register_cpu_notifier(&cpufreq_stat_cpu_notifier);
+	lock_cpu_hotplug();
+	for_each_online_cpu(cpu) {
+		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_ONLINE,
+			(void *)(long)cpu);
+	}
+	unlock_cpu_hotplug();
 	return 0;
 }
 static void
 __exit cpufreq_stats_exit(void)
 {
 	unsigned int cpu;
+
 	cpufreq_unregister_notifier(&notifier_policy_block,
 			CPUFREQ_POLICY_NOTIFIER);
 	cpufreq_unregister_notifier(&notifier_trans_block,
 			CPUFREQ_TRANSITION_NOTIFIER);
-	for_each_cpu(cpu)
-		cpufreq_stats_free_table(cpu);
+	unregister_cpu_notifier(&cpufreq_stat_cpu_notifier);
+	lock_cpu_hotplug();
+	for_each_online_cpu(cpu) {
+		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_DEAD,
+			(void *)(long)cpu);
+	}
+	unlock_cpu_hotplug();
 }
 
 MODULE_AUTHOR ("Zou Nan hai <nanhai.zou@intel.com>");

--

