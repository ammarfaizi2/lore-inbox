Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750765AbWINOnJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750765AbWINOnJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 10:43:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750720AbWINOnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 10:43:09 -0400
Received: from nf-out-0910.google.com ([64.233.182.189]:44178 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1750837AbWINOnF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 10:43:05 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:content-type;
        b=E6vW1+0Aw55k5oA4UFNZDyqGAp00bYlaC3XamHbfb/bDj2d/OHWWbyFw38WEk+Zdxhcvv5PAx42yoYYiYKzvcAK9PLcJ/5hTv0YEchwd+Mdc03+fAFnGTsQZbgWcsl1RksIeGkD1XY1Bu4rzGbUjDJUGcQRCTO76zJEJ8Wh9auE=
Message-ID: <45096A7B.2070007@gmail.com>
Date: Thu, 14 Sep 2006 18:43:07 +0400
From: "Eugeny S. Mints" <eugeny.mints@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20060313)
MIME-Version: 1.0
To: pm list <linux-pm@lists.osdl.org>
CC: Matthew Locke <matt@nomadgs.com>, Amit Kucheria <amit.kucheria@nokia.com>,
       Igor Stoppa <igor.stoppa@nokia.com>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: [RFC] CPUFreq PowerOP integratoin, CPUFreq core 1/3
Content-Type: multipart/mixed;
 boundary="------------080003030500000207030709"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080003030500000207030709
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

This patch touches cpufreq.c and freq_tables.c


--------------080003030500000207030709
Content-Type: text/x-patch;
 name="cpufreq.powerop.integration.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="cpufreq.powerop.integration.patch"

diff --git a/drivers/cpufreq/Makefile b/drivers/cpufreq/Makefile
index 71fc3b4..73f2e37 100644
--- a/drivers/cpufreq/Makefile
+++ b/drivers/cpufreq/Makefile
@@ -1,5 +1,5 @@
 # CPUfreq core
-obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o
+obj-$(CONFIG_CPU_FREQ)			+= cpufreq.o freq_helpers.o
 # CPUfreq stats
 obj-$(CONFIG_CPU_FREQ_STAT)             += cpufreq_stats.o
 
@@ -10,6 +10,3 @@ obj-$(CONFIG_CPU_FREQ_GOV_USERSPACE)	+= 
 obj-$(CONFIG_CPU_FREQ_GOV_ONDEMAND)	+= cpufreq_ondemand.o
 obj-$(CONFIG_CPU_FREQ_GOV_CONSERVATIVE)	+= cpufreq_conservative.o
 
-# CPUfreq cross-arch helpers
-obj-$(CONFIG_CPU_FREQ_TABLE)		+= freq_table.o
-
diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index b3df613..28d71f2 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -9,6 +9,13 @@
  *  Feb 2006 - Jacob Shin <jacob.shin@amd.com>
  *	Fix handling for CPU hotplug -- affected CPUs
  *
+ *  Aug 2006 - Eugeny S. Mints <eugeny.@nomad.com>
+ *      splitting original cpufreq code on functional layers, integration with
+ *      PowerOP, got rid of cpufreq driver
+ *  
+ *        
+ *  2006 (C) Nomad Global Solutions, Inc. 
+ *
  * This program is free software; you can redistribute it and/or modify
  * it under the terms of the GNU General Public License version 2 as
  * published by the Free Software Foundation.
@@ -28,17 +35,17 @@ #include <linux/slab.h>
 #include <linux/cpu.h>
 #include <linux/completion.h>
 #include <linux/mutex.h>
+#include <linux/powerop.h>
+
+#include "freq_helpers.h"
 
 #define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, "cpufreq-core", msg)
 
-/**
- * The "cpufreq driver" - the arch- or hardware-dependend low
- * level driver of CPUFreq support, and its spinlock. This lock
- * also protects the cpufreq_cpu_data array.
- */
-static struct cpufreq_driver *cpufreq_driver;
+/* if defined CPUFreq uses set_policy instead of target method */
+static unsigned int smart_cpu = 0;
+
 static struct cpufreq_policy *cpufreq_cpu_data[NR_CPUS];
-static DEFINE_SPINLOCK(cpufreq_driver_lock);
+static DEFINE_SPINLOCK(cpufreq_cpu_data_lock);
 
 /* internal prototypes */
 static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
@@ -67,31 +74,22 @@ struct cpufreq_policy *cpufreq_cpu_get(u
 		goto err_out;
 
 	/* get the cpufreq driver */
-	spin_lock_irqsave(&cpufreq_driver_lock, flags);
-
-	if (!cpufreq_driver)
-		goto err_out_unlock;
-
-	if (!try_module_get(cpufreq_driver->owner))
-		goto err_out_unlock;
-
+	spin_lock_irqsave(&cpufreq_cpu_data_lock, flags);
 
 	/* get the CPU */
 	data = cpufreq_cpu_data[cpu];
 
 	if (!data)
-		goto err_out_put_module;
+		goto err_out_unlock;
 
 	if (!kobject_get(&data->kobj))
-		goto err_out_put_module;
+		goto err_out_unlock;
 
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 	return data;
 
-err_out_put_module:
-	module_put(cpufreq_driver->owner);
 err_out_unlock:
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 err_out:
 	return NULL;
 }
@@ -101,7 +99,6 @@ EXPORT_SYMBOL_GPL(cpufreq_cpu_get);
 void cpufreq_cpu_put(struct cpufreq_policy *data)
 {
 	kobject_put(&data->kobj);
-	module_put(cpufreq_driver->owner);
 }
 EXPORT_SYMBOL_GPL(cpufreq_cpu_put);
 
@@ -241,10 +238,10 @@ void cpufreq_notify_transition(struct cp
 
 	BUG_ON(irqs_disabled());
 
-	freqs->flags = cpufreq_driver->flags;
 	dprintk("notification %u of frequency transition to %u kHz\n",
 		state, freqs->new);
 
+	/* FIXME: don't we need a lock here? */
 	policy = cpufreq_cpu_data[freqs->cpu];
 	switch (state) {
 
@@ -253,14 +250,12 @@ void cpufreq_notify_transition(struct cp
 		 * which is not equal to what the cpufreq core thinks is
 		 * "old frequency".
 		 */
-		if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
-			if ((policy) && (policy->cpu == freqs->cpu) &&
-			    (policy->cur) && (policy->cur != freqs->old)) {
-				dprintk("Warning: CPU frequency is"
-					" %u, cpufreq assumed %u kHz.\n",
-					freqs->old, policy->cur);
-				freqs->old = policy->cur;
-			}
+		if ((policy) && (policy->cpu == freqs->cpu) &&
+		    (policy->cur) && (policy->cur != freqs->old)) {
+			dprintk("Warning: CPU frequency is"
+				" %u, cpufreq assumed %u kHz.\n",
+				freqs->old, policy->cur);
+			freqs->old = policy->cur;
 		}
 		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
 				CPUFREQ_PRECHANGE, freqs);
@@ -303,10 +298,7 @@ static int cpufreq_parse_governor (char 
 {
 	int err = -EINVAL;
 
-	if (!cpufreq_driver)
-		goto out;
-
-	if (cpufreq_driver->setpolicy) {
+	if (smart_cpu) {
 		if (!strnicmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_PERFORMANCE;
 			err = 0;
@@ -314,7 +306,7 @@ static int cpufreq_parse_governor (char 
 			*policy = CPUFREQ_POLICY_POWERSAVE;
 			err = 0;
 		}
-	} else if (cpufreq_driver->target) {
+	} else {
 		struct cpufreq_governor *t;
 
 		mutex_lock(&cpufreq_governor_mutex);
@@ -345,7 +337,6 @@ static int cpufreq_parse_governor (char 
 
 		mutex_unlock(&cpufreq_governor_mutex);
 	}
-  out:
 	return err;
 }
 
@@ -433,6 +424,40 @@ static ssize_t show_scaling_governor (st
 	return -EINVAL;
 }
 
+/**
+ * show_scaling_governor - show the current policy for the specified CPU
+ */
+static ssize_t 
+show_available_freqs(struct cpufreq_policy *policy, char *buf)
+{	
+	int rc = 0;
+	unsigned int i = 0, freq = 0;
+	ssize_t count = 0;
+	char freq_n[CPUFREQ_FREQ_STR_SIZE];
+	char **opt_names_list;
+	int opt_names_list_size;
+
+	CPUFREQ_CPU_N_FREQ(freq_n, policy->cpu);
+
+	rc = powerop_get_registered_opt_names(opt_names_list,
+					      &opt_names_list_size);
+	if (rc != 0)
+		return rc;
+
+	for (i = 0; i < opt_names_list_size; i++) {
+		if (powerop_get_point(opt_names_list[i], freq_n, &freq))
+			continue;
+
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		count += sprintf(&buf[count], "%d ", freq);
+	}
+	powerop_put_registered_opt_names(opt_names_list);
+
+	count += sprintf(&buf[count], "\n");
+
+	return count;
+}
 
 /**
  * store_scaling_governor - store policy for the specified CPU
@@ -472,14 +497,6 @@ static ssize_t store_scaling_governor (s
 }
 
 /**
- * show_scaling_driver - show the cpufreq driver currently loaded
- */
-static ssize_t show_scaling_driver (struct cpufreq_policy * policy, char *buf)
-{
-	return scnprintf(buf, CPUFREQ_NAME_LEN, "%s\n", cpufreq_driver->name);
-}
-
-/**
  * show_scaling_available_governors - show the available CPUfreq governors
  */
 static ssize_t show_scaling_available_governors (struct cpufreq_policy * policy,
@@ -488,7 +505,7 @@ static ssize_t show_scaling_available_go
 	ssize_t i = 0;
 	struct cpufreq_governor *t;
 
-	if (!cpufreq_driver->target) {
+	if (smart_cpu) {
 		i += sprintf(buf, "performance powersave");
 		goto out;
 	}
@@ -538,12 +555,12 @@ define_one_ro0400(cpuinfo_cur_freq);
 define_one_ro(cpuinfo_min_freq);
 define_one_ro(cpuinfo_max_freq);
 define_one_ro(scaling_available_governors);
-define_one_ro(scaling_driver);
 define_one_ro(scaling_cur_freq);
 define_one_ro(affected_cpus);
 define_one_rw(scaling_min_freq);
 define_one_rw(scaling_max_freq);
 define_one_rw(scaling_governor);
+define_one_ro(available_freqs);
 
 static struct attribute * default_attrs[] = {
 	&cpuinfo_min_freq.attr,
@@ -552,8 +569,8 @@ static struct attribute * default_attrs[
 	&scaling_max_freq.attr,
 	&affected_cpus.attr,
 	&scaling_governor.attr,
-	&scaling_driver.attr,
 	&scaling_available_governors.attr,
+	&available_freqs.attr,
 	NULL
 };
 
@@ -605,6 +622,7 @@ static struct kobj_type ktype_cpufreq = 
 	.release	= cpufreq_sysfs_release,
 };
 
+extern cpumask_t arch_get_dependent_cpus_mask(int cpu);
 
 /**
  * cpufreq_add_dev - add a CPU device
@@ -617,10 +635,10 @@ static int cpufreq_add_dev (struct sys_d
 	int ret = 0;
 	struct cpufreq_policy new_policy;
 	struct cpufreq_policy *policy;
-	struct freq_attr **drv_attr;
 	struct sys_device *cpu_sys_dev;
 	unsigned long flags;
 	unsigned int j;
+	char freq_n[CPUFREQ_FREQ_STR_SIZE];
 #ifdef CONFIG_SMP
 	struct cpufreq_policy *managed_policy;
 #endif
@@ -630,7 +648,7 @@ #endif
 
 	cpufreq_debug_disable_ratelimit();
 	dprintk("adding CPU %u\n", cpu);
-
+	
 #ifdef CONFIG_SMP
 	/* check whether a different CPU already registered this
 	 * CPU because it is in the same boat. */
@@ -638,15 +656,9 @@ #ifdef CONFIG_SMP
 	if (unlikely(policy)) {
 		cpufreq_cpu_put(policy);
 		cpufreq_debug_enable_ratelimit();
-		return 0;
+		return ret;
 	}
 #endif
-
-	if (!try_module_get(cpufreq_driver->owner)) {
-		ret = -EINVAL;
-		goto module_out;
-	}
-
 	policy = kzalloc(sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!policy) {
 		ret = -ENOMEM;
@@ -654,23 +666,38 @@ #endif
 	}
 
 	policy->cpu = cpu;
-	policy->cpus = cpumask_of_cpu(cpu);
+
+	/* 
+	 * FIXME: this will go away once notifications moved to lower layers 
+	 * presumably to clock/voltage framework level
+	 */
+	policy->cpus = arch_get_dependent_cpus_mask(cpu);
 
 	mutex_init(&policy->lock);
 	mutex_lock(&policy->lock);
 	init_completion(&policy->kobj_unregister);
 	INIT_WORK(&policy->update, handle_update, (void *)(long)cpu);
 
-	/* call driver. From then on the cpufreq must be able
-	 * to accept all calls to ->verify and ->setpolicy for this CPU
-	 */
-	ret = cpufreq_driver->init(policy);
-	if (ret) {
+	policy->governor = CPUFREQ_DEFAULT_GOVERNOR;
+
+	/* FIXME: soon this will come from PowerOP Core as well */
+	policy->cpuinfo.transition_latency = 10000; /* 10uS latency */
+
+	CPUFREQ_CPU_N_FREQ(freq_n, cpu);	
+	ret = powerop_get_point(NULL, freq_n, &policy->cur);
+	if (ret != 0) {
 		dprintk("initialization failed\n");
 		mutex_unlock(&policy->lock);
 		goto err_out;
 	}
 
+	ret = cpufreq_cpuinfo(policy);
+	if (ret) {
+		dprintk("cpuinfo initialization failed\n");
+		mutex_unlock(&policy->lock);
+		goto err_out;
+	}
+
 #ifdef CONFIG_SMP
 	for_each_cpu_mask(j, policy->cpus) {
 		if (cpu == j)
@@ -681,10 +708,10 @@ #ifdef CONFIG_SMP
 		 */
 		managed_policy = cpufreq_cpu_get(j);
 		if (unlikely(managed_policy)) {
-			spin_lock_irqsave(&cpufreq_driver_lock, flags);
+			spin_lock_irqsave(&cpufreq_cpu_data_lock, flags);
 			managed_policy->cpus = policy->cpus;
 			cpufreq_cpu_data[cpu] = managed_policy;
-			spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+			spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 
 			dprintk("CPU already managed, adding link\n");
 			sysfs_create_link(&sys_dev->kobj,
@@ -692,8 +719,16 @@ #ifdef CONFIG_SMP
 
 			cpufreq_debug_enable_ratelimit();
 			mutex_unlock(&policy->lock);
-			ret = 0;
-			goto err_out_driver_exit; /* call driver->exit() */
+			/* 
+			 * FIXME: interesting... cpufreq handles one policy 
+			 * entry for all affected CPUs... it works since 
+			 * currently same set of freq/voltage pairs are always 
+			 * registered for all CPUs. That bacomes not the case
+			 * with PowerOP approach when we can have different
+			 * set of operating points even for affected CPUs
+			 */ 
+			kfree(policy);
+			return 0;
 		}
 	}
 #endif
@@ -707,23 +742,16 @@ #endif
 	ret = kobject_register(&policy->kobj);
 	if (ret) {
 		mutex_unlock(&policy->lock);
-		goto err_out_driver_exit;
-	}
-	/* set up files for this cpu device */
-	drv_attr = cpufreq_driver->attr;
-	while ((drv_attr) && (*drv_attr)) {
-		sysfs_create_file(&policy->kobj, &((*drv_attr)->attr));
-		drv_attr++;
+		goto err_out;
 	}
-	if (cpufreq_driver->get)
-		sysfs_create_file(&policy->kobj, &cpuinfo_cur_freq.attr);
-	if (cpufreq_driver->target)
-		sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
 
-	spin_lock_irqsave(&cpufreq_driver_lock, flags);
+	sysfs_create_file(&policy->kobj, &cpuinfo_cur_freq.attr);
+	sysfs_create_file(&policy->kobj, &scaling_cur_freq.attr);
+
+	spin_lock_irqsave(&cpufreq_cpu_data_lock, flags);
 	for_each_cpu_mask(j, policy->cpus)
 		cpufreq_cpu_data[j] = policy;
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 
 	/* symlink affected CPUs */
 	for_each_cpu_mask(j, policy->cpus) {
@@ -750,32 +778,25 @@ #endif
 		goto err_out_unregister;
 	}
 
-	module_put(cpufreq_driver->owner);
 	dprintk("initialization complete\n");
 	cpufreq_debug_enable_ratelimit();
 
 	return 0;
 
-
 err_out_unregister:
-	spin_lock_irqsave(&cpufreq_driver_lock, flags);
+	/* FIXME: original CPUFreq bug: sysfs is not cleaned up properly */
+	spin_lock_irqsave(&cpufreq_cpu_data_lock, flags);
 	for_each_cpu_mask(j, policy->cpus)
 		cpufreq_cpu_data[j] = NULL;
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 
 	kobject_unregister(&policy->kobj);
 	wait_for_completion(&policy->kobj_unregister);
 
-err_out_driver_exit:
-	if (cpufreq_driver->exit)
-		cpufreq_driver->exit(policy);
-
 err_out:
 	kfree(policy);
 
 nomem_out:
-	module_put(cpufreq_driver->owner);
-module_out:
 	cpufreq_debug_enable_ratelimit();
 	return ret;
 }
@@ -785,6 +806,11 @@ module_out:
  * cpufreq_remove_dev - remove a CPU device
  *
  * Removes the cpufreq interface for a CPU device.
+ *
+ * FIXME: are sysdev driver/device infrastructure for cpus and hotplug 
+ * notification redundant? It's important question for PowerOP since for a cpu
+ * [core] suspend (which iiuc now is handled via hotplug] we most probably 
+ * don't want unregister operating points
  */
 static int cpufreq_remove_dev (struct sys_device * sys_dev)
 {
@@ -799,11 +825,11 @@ #endif
 	cpufreq_debug_disable_ratelimit();
 	dprintk("unregistering CPU %u\n", cpu);
 
-	spin_lock_irqsave(&cpufreq_driver_lock, flags);
+	spin_lock_irqsave(&cpufreq_cpu_data_lock, flags);
 	data = cpufreq_cpu_data[cpu];
 
 	if (!data) {
-		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+		spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 		cpufreq_debug_enable_ratelimit();
 		return -EINVAL;
 	}
@@ -817,7 +843,7 @@ #ifdef CONFIG_SMP
 	if (unlikely(cpu != data->cpu)) {
 		dprintk("removing link\n");
 		cpu_clear(cpu, data->cpus);
-		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+		spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 		sysfs_remove_link(&sys_dev->kobj, "cpufreq");
 		cpufreq_cpu_put(data);
 		cpufreq_debug_enable_ratelimit();
@@ -825,9 +851,8 @@ #ifdef CONFIG_SMP
 	}
 #endif
 
-
 	if (!kobject_get(&data->kobj)) {
-		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+		spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 		cpufreq_debug_enable_ratelimit();
 		return -EFAULT;
 	}
@@ -842,11 +867,18 @@ #ifdef CONFIG_SMP
 		for_each_cpu_mask(j, data->cpus) {
 			if (j == cpu)
 				continue;
+			/* 
+			 * FIXME: hmm, we "remove" affected CPUs once a 
+			 * "leader" CPU is down...is it hw limitation?
+			 * why not just cpufreq_cpu_data[cpu] = NULL ?
+			 * ...so far unregister operating points for affected
+			 * CPUs
+			 */   
 			cpufreq_cpu_data[j] = NULL;
 		}
 	}
 
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 
 	if (unlikely(cpus_weight(data->cpus) > 1)) {
 		for_each_cpu_mask(j, data->cpus) {
@@ -859,11 +891,11 @@ #ifdef CONFIG_SMP
 		}
 	}
 #else
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
+	spin_unlock_irqrestore(&cpufreq_cpu_data_lock, flags);
 #endif
 
 	mutex_lock(&data->lock);
-	if (cpufreq_driver->target)
+	if (!smart_cpu)
 		__cpufreq_governor(data, CPUFREQ_GOV_STOP);
 	mutex_unlock(&data->lock);
 
@@ -879,11 +911,7 @@ #endif
 	wait_for_completion(&data->kobj_unregister);
 	dprintk("wait complete\n");
 
-	if (cpufreq_driver->exit)
-		cpufreq_driver->exit(data);
-
 	kfree(data);
-
 	cpufreq_debug_enable_ratelimit();
 	return 0;
 }
@@ -944,6 +972,7 @@ unsigned int cpufreq_quick_get(unsigned 
 EXPORT_SYMBOL(cpufreq_quick_get);
 
 
+/* FIXME: REVISIT: this routine returns 0 on error! */
 /**
  * cpufreq_get - get the current CPU frequency (in kHz)
  * @cpu: CPU number
@@ -954,45 +983,52 @@ unsigned int cpufreq_get(unsigned int cp
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
 	unsigned int ret = 0;
+	int clock_freq = 0;
+	char freq_n[CPUFREQ_FREQ_STR_SIZE];
 
 	if (!policy)
 		return 0;
 
-	if (!cpufreq_driver->get)
-		goto out;
-
 	mutex_lock(&policy->lock);
 
-	ret = cpufreq_driver->get(cpu);
+	CPUFREQ_CPU_N_FREQ(freq_n, cpu);	
+	ret = powerop_get_point(NULL, freq_n, &clock_freq);
+	if (ret != 0) {
+		mutex_unlock(&policy->lock);
+		cpufreq_cpu_put(policy);
+		return 0;	
+	}
 
-	if (ret && policy->cur && !(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
-		/* verify no discrepancy between actual and saved value exists */
-		if (unlikely(ret != policy->cur)) {
-			cpufreq_out_of_sync(cpu, policy->cur, ret);
-			schedule_work(&policy->update);
-		}
+	if (clock_freq && policy->cur && unlikely(clock_freq != policy->cur)) {
+		/* 
+		 * verify no discrepancy between actual and saved 
+		 * value exists 
+		 */
+		cpufreq_out_of_sync(cpu, policy->cur, clock_freq);
+		schedule_work(&policy->update);
 	}
 
 	mutex_unlock(&policy->lock);
 
-out:
 	cpufreq_cpu_put(policy);
 
-	return (ret);
+	return clock_freq;
 }
 EXPORT_SYMBOL(cpufreq_get);
 
 
 /**
  *	cpufreq_suspend - let the low level driver prepare for suspend
+ * with PowerOP cpufreq_suspend() handles internal cpufreq core 
+ * needs only. PM Core handles all low layer needs 
  */
 
 static int cpufreq_suspend(struct sys_device * sysdev, pm_message_t pmsg)
 {
 	int cpu = sysdev->id;
-	unsigned int ret = 0;
 	unsigned int cur_freq = 0;
 	struct cpufreq_policy *cpu_policy;
+	char freq_n[CPUFREQ_FREQ_STR_SIZE];
 
 	dprintk("resuming cpu %u\n", cpu);
 
@@ -1014,23 +1050,10 @@ static int cpufreq_suspend(struct sys_de
 		return 0;
 	}
 
-	if (cpufreq_driver->suspend) {
-		ret = cpufreq_driver->suspend(cpu_policy, pmsg);
-		if (ret) {
-			printk(KERN_ERR "cpufreq: suspend failed in ->suspend "
-					"step on CPU %u\n", cpu_policy->cpu);
-			cpufreq_cpu_put(cpu_policy);
-			return ret;
-		}
-	}
-
-
-	if (cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)
+	CPUFREQ_CPU_N_FREQ(freq_n, cpu);
+	if (powerop_get_point(NULL, freq_n, &cur_freq))
 		goto out;
 
-	if (cpufreq_driver->get)
-		cur_freq = cpufreq_driver->get(cpu_policy->cpu);
-
 	if (!cur_freq || !cpu_policy->cur) {
 		printk(KERN_ERR "cpufreq: suspend failed to assert current "
 		       "frequency is what timing core thinks it is.\n");
@@ -1040,10 +1063,9 @@ static int cpufreq_suspend(struct sys_de
 	if (unlikely(cur_freq != cpu_policy->cur)) {
 		struct cpufreq_freqs freqs;
 
-		if (!(cpufreq_driver->flags & CPUFREQ_PM_NO_WARN))
-			dprintk("Warning: CPU frequency is %u, "
-			       "cpufreq assumed %u kHz.\n",
-			       cur_freq, cpu_policy->cur);
+		dprintk("Warning: CPU frequency is %u, "
+		       "cpufreq assumed %u kHz.\n",
+		       cur_freq, cpu_policy->cur);
 
 		freqs.cpu = cpu;
 		freqs.old = cpu_policy->cur;
@@ -1063,8 +1085,9 @@ out:
 
 /**
  *	cpufreq_resume -  restore proper CPU frequency handling after resume
- *
- *	1.) resume CPUfreq hardware support (cpufreq_driver->resume())
+ * 
+ * with PowerOP cpufreq_resume() handles internal cpufreq core 
+ * needs only. PM Core handles all low layer needs 
  *	2.) if ->target and !CPUFREQ_CONST_LOOPS: verify we're in sync
  *	3.) schedule call cpufreq_update_policy() ASAP as interrupts are
  *	    restored.
@@ -1074,6 +1097,9 @@ static int cpufreq_resume(struct sys_dev
 	int cpu = sysdev->id;
 	unsigned int ret = 0;
 	struct cpufreq_policy *cpu_policy;
+	unsigned int cur_freq = 0;
+	char freq_n[CPUFREQ_FREQ_STR_SIZE];
+
 
 	dprintk("resuming cpu %u\n", cpu);
 
@@ -1095,50 +1121,34 @@ static int cpufreq_resume(struct sys_dev
 		return 0;
 	}
 
-	if (cpufreq_driver->resume) {
-		ret = cpufreq_driver->resume(cpu_policy);
-		if (ret) {
-			printk(KERN_ERR "cpufreq: resume failed in ->resume "
-					"step on CPU %u\n", cpu_policy->cpu);
-			cpufreq_cpu_put(cpu_policy);
-			return ret;
-		}
-	}
-
-	if (!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
-		unsigned int cur_freq = 0;
 
-		if (cpufreq_driver->get)
-			cur_freq = cpufreq_driver->get(cpu_policy->cpu);
-
-		if (!cur_freq || !cpu_policy->cur) {
-			printk(KERN_ERR "cpufreq: resume failed to assert "
-					"current frequency is what timing core "
-					"thinks it is.\n");
-			goto out;
-		}
+	CPUFREQ_CPU_N_FREQ(freq_n, cpu);
+	if (powerop_get_point(NULL, freq_n, &cur_freq))
+		goto out;
 
-		if (unlikely(cur_freq != cpu_policy->cur)) {
-			struct cpufreq_freqs freqs;
+	if (!cur_freq || !cpu_policy->cur) {
+		printk(KERN_ERR "cpufreq: resume failed to assert "
+				"current frequency is what timing core "
+				"thinks it is.\n");
+		goto out;
+	}
 
-			if (!(cpufreq_driver->flags & CPUFREQ_PM_NO_WARN))
-				dprintk("Warning: CPU frequency"
-				       "is %u, cpufreq assumed %u kHz.\n",
-				       cur_freq, cpu_policy->cur);
+	if (unlikely(cur_freq != cpu_policy->cur)) {
+		struct cpufreq_freqs freqs;
 
-			freqs.cpu = cpu;
-			freqs.old = cpu_policy->cur;
-			freqs.new = cur_freq;
+		dprintk("Warning: CPU frequency"
+		       "is %u, cpufreq assumed %u kHz.\n",
+		       cur_freq, cpu_policy->cur);
 
-			blocking_notifier_call_chain(
-					&cpufreq_transition_notifier_list,
-					CPUFREQ_RESUMECHANGE, &freqs);
-			adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
+		freqs.cpu = cpu;
+		freqs.old = cpu_policy->cur;
+		freqs.new = cur_freq;
 
-			cpu_policy->cur = cur_freq;
-		}
+		blocking_notifier_call_chain(&cpufreq_transition_notifier_list,
+					     CPUFREQ_RESUMECHANGE, &freqs);
+		adjust_jiffies(CPUFREQ_RESUMECHANGE, &freqs);
+		cpu_policy->cur = cur_freq;
 	}
-
 out:
 	schedule_work(&cpu_policy->update);
 	cpufreq_cpu_put(cpu_policy);
@@ -1238,8 +1248,9 @@ int __cpufreq_driver_target(struct cpufr
 
 	dprintk("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
 		target_freq, relation);
-	if (cpu_online(policy->cpu) && cpufreq_driver->target)
-		retval = cpufreq_driver->target(policy, target_freq, relation);
+	if (cpu_online(policy->cpu))
+		retval = cpufreq_target(policy, target_freq, 
+							relation);
 
 	return retval;
 }
@@ -1377,7 +1388,7 @@ static int __cpufreq_set_policy(struct c
 	}
 
 	/* verify the cpu speed can be set within this limit */
-	ret = cpufreq_driver->verify(policy);
+	ret = cpufreq_verify(policy);
 	if (ret)
 		goto error_out;
 
@@ -1391,7 +1402,7 @@ static int __cpufreq_set_policy(struct c
 
 	/* verify the cpu speed can be set within this limit,
 	   which might be different to the first one */
-	ret = cpufreq_driver->verify(policy);
+	ret = cpufreq_verify(policy);
 	if (ret)
 		goto error_out;
 
@@ -1404,10 +1415,10 @@ static int __cpufreq_set_policy(struct c
 
 	dprintk("new min and max freqs are %u - %u kHz\n", data->min, data->max);
 
-	if (cpufreq_driver->setpolicy) {
+	if (smart_cpu) {
 		data->policy = policy->policy;
 		dprintk("setting range\n");
-		ret = cpufreq_driver->setpolicy(policy);
+		ret = cpufreq_setpolicy(policy);
 	} else {
 		if (policy->governor != data->governor) {
 			/* save old, working values */
@@ -1492,6 +1503,7 @@ int cpufreq_update_policy(unsigned int c
 {
 	struct cpufreq_policy *data = cpufreq_cpu_get(cpu);
 	struct cpufreq_policy policy;
+	char freq_n[CPUFREQ_FREQ_STR_SIZE];
 	int ret = 0;
 
 	if (!data)
@@ -1509,26 +1521,35 @@ int cpufreq_update_policy(unsigned int c
 
 	/* BIOS might change freq behind our back
 	  -> ask driver for current freq and notify governors about a change */
-	if (cpufreq_driver->get) {
-		policy.cur = cpufreq_driver->get(cpu);
-		if (!data->cur) {
-			dprintk("Driver did not initialize current freq");
-			data->cur = policy.cur;
-		} else {
-			if (data->cur != policy.cur)
-				cpufreq_out_of_sync(cpu, data->cur, policy.cur);
-		}
+	CPUFREQ_CPU_N_FREQ(freq_n, cpu);
+	ret = powerop_get_point(NULL, freq_n, &policy.cur);
+	if (ret != 0)
+		goto out_failed;
+
+	if (!data->cur) {
+		dprintk("Driver did not initialize current freq");
+		data->cur = policy.cur;
+	} else {
+		if (data->cur != policy.cur)
+			cpufreq_out_of_sync(cpu, data->cur, policy.cur);
 	}
 
 	ret = __cpufreq_set_policy(data, &policy);
 
+out_failed:
 	mutex_unlock(&data->lock);
 	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 	return ret;
 }
 EXPORT_SYMBOL(cpufreq_update_policy);
-
+/* 
+ * FIXME: why do we need separate hotplug callback and sysdev_driver->add() 
+ * routine is not enough? Doesn't acpi call arch_register_cpu() and trigger
+ * sysdev_driver->add() in case of ACPI is enabled (CONFIG_ACPI_HOTPLUG_CPU)?
+ * Seems hotplug code does not ever (indirectly) call register_cpu() from
+ * drivers/base/cpu.c . Why? Am I missing something?  
+ */ 
 #ifdef CONFIG_HOTPLUG_CPU
 static int cpufreq_cpu_callback(struct notifier_block *nfb,
 					unsigned long action, void *hcpu)
@@ -1551,10 +1572,11 @@ static int cpufreq_cpu_callback(struct n
 			 * hardware-managed P-State to switch other related
 			 * threads to min or higher speeds if possible.
 			 */
+			/* FIXME: no any locking here? */
 			policy = cpufreq_cpu_data[cpu];
 			if (policy) {
-				cpufreq_driver_target(policy, policy->min,
-						CPUFREQ_RELATION_H);
+				cpufreq_target(policy, policy->min,
+					       CPUFREQ_RELATION_H);
 			}
 			break;
 		case CPU_DEAD:
@@ -1571,6 +1593,49 @@ static struct notifier_block __cpuinitda
 };
 #endif /* CONFIG_HOTPLUG_CPU */
 
+static int 
+cpufreq_powerop_callback(struct notifier_block *nfb, unsigned long action, 
+			 void *name)
+{
+	char freq_n[CPUFREQ_FREQ_STR_SIZE];
+	int freq = 0, i, rc = 0;
+	struct cpufreq_policy *policy;
+
+	switch (action) {
+		case POWEROP_REGISTER_EVENT:
+			for (i = 0; i < NR_CPUS; i++) {
+				CPUFREQ_CPU_N_FREQ(freq_n, i);
+				rc = powerop_get_point(name, freq_n, &freq);
+				if (rc != 0)
+					break;
+				if (freq != -1) {
+					policy = cpufreq_cpu_get(i);
+					if (freq < policy->min)
+						policy->min = freq;
+					if (freq > policy->max)
+						policy->max = freq;
+					if (policy->max > 
+					    policy->cpuinfo.max_freq)
+						policy->cpuinfo.max_freq = 
+								   policy->max;
+					if (policy->min < 
+					    policy->cpuinfo.min_freq)
+						policy->cpuinfo.min_freq =
+								   policy->min;
+					schedule_work(&policy->update);
+					cpufreq_cpu_put(policy);
+				}
+			}
+			break;
+	}
+	return NOTIFY_OK;
+}
+
+static struct notifier_block cpufreq_powerop_notifier =
+{
+    .notifier_call = cpufreq_powerop_callback,
+};
+
 /*********************************************************************
  *               REGISTER / UNREGISTER CPUFREQ DRIVER                *
  *********************************************************************/
@@ -1585,89 +1650,36 @@ #endif /* CONFIG_HOTPLUG_CPU */
  * (and isn't unregistered in the meantime).
  *
  */
-int cpufreq_register_driver(struct cpufreq_driver *driver_data)
+int cpufreq_core_init(void)
 {
-	unsigned long flags;
 	int ret;
 
-	if (!driver_data || !driver_data->verify || !driver_data->init ||
-	    ((!driver_data->setpolicy) && (!driver_data->target)))
-		return -EINVAL;
-
-	dprintk("trying to register driver %s\n", driver_data->name);
-
-	if (driver_data->setpolicy)
-		driver_data->flags |= CPUFREQ_CONST_LOOPS;
-
-	spin_lock_irqsave(&cpufreq_driver_lock, flags);
-	if (cpufreq_driver) {
-		spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
-		return -EBUSY;
-	}
-	cpufreq_driver = driver_data;
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
-
 	ret = sysdev_driver_register(&cpu_sysdev_class,&cpufreq_sysdev_driver);
+	if (ret != 0)
+		return ret;
 
-	if ((!ret) && !(cpufreq_driver->flags & CPUFREQ_STICKY)) {
-		int i;
-		ret = -ENODEV;
-
-		/* check for at least one working CPU */
-		for (i=0; i<NR_CPUS; i++)
-			if (cpufreq_cpu_data[i])
-				ret = 0;
-
-		/* if all ->init() calls failed, unregister */
-		if (ret) {
-			dprintk("no CPU initialized for driver %s\n", driver_data->name);
-			sysdev_driver_unregister(&cpu_sysdev_class, &cpufreq_sysdev_driver);
-
-			spin_lock_irqsave(&cpufreq_driver_lock, flags);
-			cpufreq_driver = NULL;
-			spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
-		}
-	}
-
-	if (!ret) {
-		register_hotcpu_notifier(&cpufreq_cpu_notifier);
-		dprintk("driver %s up and running\n", driver_data->name);
-		cpufreq_debug_enable_ratelimit();
-	}
+	powerop_register_notifier(&cpufreq_powerop_notifier);
+	register_hotcpu_notifier(&cpufreq_cpu_notifier);
+	dprintk("driver %s up and running\n", driver_data->name);
+	cpufreq_debug_enable_ratelimit();
 
 	return (ret);
 }
-EXPORT_SYMBOL_GPL(cpufreq_register_driver);
-
 
-/**
- * cpufreq_unregister_driver - unregister the current CPUFreq driver
- *
- *    Unregister the current CPUFreq driver. Only call this if you have
- * the right to do so, i.e. if you have succeeded in initialising before!
- * Returns zero if successful, and -EINVAL if the cpufreq_driver is
- * currently not initialised.
- */
-int cpufreq_unregister_driver(struct cpufreq_driver *driver)
+void
+cpufreq_core_exit(void)
 {
-	unsigned long flags;
-
 	cpufreq_debug_disable_ratelimit();
-
-	if (!cpufreq_driver || (driver != cpufreq_driver)) {
-		cpufreq_debug_enable_ratelimit();
-		return -EINVAL;
-	}
-
 	dprintk("unregistering driver %s\n", driver->name);
 
+	powerop_unregister_notifier(&cpufreq_powerop_notifier);
 	sysdev_driver_unregister(&cpu_sysdev_class, &cpufreq_sysdev_driver);
 	unregister_hotcpu_notifier(&cpufreq_cpu_notifier);
+}
+module_init(cpufreq_core_init);
+module_exit(cpufreq_core_exit);
+
+module_param(smart_cpu, uint, 0644);
+MODULE_PARM_DESC(smart_cpu, "Define if cpu handles frequency intervals insted oftarget frequencies");
 
-	spin_lock_irqsave(&cpufreq_driver_lock, flags);
-	cpufreq_driver = NULL;
-	spin_unlock_irqrestore(&cpufreq_driver_lock, flags);
 
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cpufreq_unregister_driver);
diff --git a/drivers/cpufreq/freq_helpers.c b/drivers/cpufreq/freq_helpers.c
new file mode 100644
index 0000000..3e631f3
--- /dev/null
+++ b/drivers/cpufreq/freq_helpers.c
@@ -0,0 +1,317 @@
+/*
+ * linux/drivers/cpufreq/freq_heplers.c
+ * CPUFreq Core helpers
+ *
+ * Modified for PowerOP by Eugeny S. Mints <eugeny@nomadgs.com>
+ *
+ * Copyright (C) 2006 Nomad Global Solutions, Inc. This file is licensed under
+ * the terms of the GNU General Public License version 2. This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * Based on code by
+ * Copyright (C) 2002 - 2003 Dominik Brodowski
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/cpufreq.h>
+#include <linux/powerop.h>
+#include "freq_helpers.h" 
+
+#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, "freq-table", msg)
+
+/*********************************************************************
+ *                     CPUFREQ HELPERS                               *
+ *********************************************************************/
+
+int cpufreq_cpuinfo(struct cpufreq_policy *policy)
+{
+	int          rc = 0;
+	unsigned int min_freq = ~0;
+	unsigned int max_freq = 0;
+	unsigned int i;
+	unsigned int freq;
+	char         freq_n[CPUFREQ_FREQ_STR_SIZE];
+	char **opt_names_list = NULL;
+	int opt_names_list_size = 0;
+
+	/* 
+	 * generate parameter name we are looking for. For CPU N name is
+	 * "freqN"
+	 */
+	CPUFREQ_CPU_N_FREQ(freq_n, policy->cpu);
+
+	rc = powerop_get_registered_opt_names(opt_names_list,
+					      &opt_names_list_size);
+	if (rc != 0)
+		return rc;
+
+	for (i = 0; i < opt_names_list_size; i++) {
+		rc = powerop_get_point(opt_names_list[i], freq_n, &freq);
+		if (rc != 0) {
+			powerop_put_registered_opt_names(opt_names_list);
+			return rc;
+		}
+	
+		if (freq == CPUFREQ_ENTRY_INVALID) {
+			dprintk("table entry %u is invalid, skipping\n", i);
+			continue;
+		}
+	
+		dprintk("point %s: %u kHz\n", opt_names_list[i], freq);
+		if (freq < min_freq)
+			min_freq = freq;
+		if (freq > max_freq)
+			max_freq = freq;
+	}
+	powerop_put_registered_opt_names(opt_names_list);
+
+	policy->min = policy->cpuinfo.min_freq = min_freq;
+	policy->max = policy->cpuinfo.max_freq = max_freq;
+
+	if (policy->min == ~0)
+		return -EINVAL;
+	else
+		return 0;
+}
+
+
+int cpufreq_verify(struct cpufreq_policy *policy)
+{
+	int          rc = -EINVAL;
+	unsigned int next_larger = ~0;
+	unsigned int i;
+	unsigned int count = 0;
+	unsigned int freq;
+	char         freq_n[CPUFREQ_FREQ_STR_SIZE];
+	char **opt_names_list = NULL;
+	int opt_names_list_size = 0;
+
+
+	CPUFREQ_CPU_N_FREQ(freq_n, policy->cpu);
+
+	dprintk("request for verification of policy (%u - %u kHz) for cpu %u\n", policy->min, policy->max, policy->cpu);
+
+	if (!cpu_online(policy->cpu))
+		return rc;
+
+	cpufreq_verify_within_limits(policy,
+				     policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
+
+	rc = powerop_get_registered_opt_names(opt_names_list, 
+					      &opt_names_list_size);
+	if (rc != 0)
+		return rc;
+
+	for (i = 0; i < opt_names_list_size; i++) {
+		rc = powerop_get_point(opt_names_list[i], freq_n, &freq);
+		if (rc != 0) {
+			powerop_put_registered_opt_names(opt_names_list);
+			return rc;
+		}
+
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if ((freq >= policy->min) && (freq <= policy->max))
+			count++;
+		else if ((next_larger > freq) && (freq > policy->max))
+			next_larger = freq;
+	}
+
+	powerop_put_registered_opt_names(opt_names_list);
+
+	if (!count)
+		policy->max = next_larger;
+
+	cpufreq_verify_within_limits(policy,
+				     policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
+
+	dprintk("verification lead to (%u - %u kHz) for cpu %u\n", policy->min, policy->max, policy->cpu);
+
+	return 0;
+}
+
+
+int 
+cpufreq_target(struct cpufreq_policy *policy,
+	       unsigned int target_freq,
+	       unsigned int relation)
+{
+	/* FIXME: hide 3 fields in a structure */
+	int           rc = -EINVAL;
+	unsigned int  optimal = 0;
+	unsigned int  optimal_found = 0;
+	char         *optimal_name = NULL;
+	unsigned int  suboptimal = 0;
+	unsigned int  suboptimal_found = 0;
+	char         *suboptimal_name = NULL;
+	unsigned int  i, j;
+	char         **opt_names_list = NULL;
+	unsigned int  opt_names_list_size = 0;
+	char         *target_opt_name;
+	char          freq_n[CPUFREQ_FREQ_STR_SIZE];
+	struct cpufreq_freqs freqs;
+	cpumask_t     online_policy_cpus;
+
+	dprintk("request for target %u kHz (relation: %u) for cpu %u\n", target_freq, relation, policy->cpu);
+
+	CPUFREQ_CPU_N_FREQ(freq_n, policy->cpu);
+
+	switch (relation) {
+	case CPUFREQ_RELATION_H:
+		suboptimal = ~0;
+		break;
+	case CPUFREQ_RELATION_L:
+		optimal = ~0;
+		break;
+	}
+
+	if (!cpu_online(policy->cpu))
+		return rc;
+
+	if (powerop_get_registered_opt_names(opt_names_list,
+					     &opt_names_list_size))
+		return rc;
+
+	for (i = 0; i < opt_names_list_size; i++) {
+		unsigned int freq;
+
+		rc = powerop_get_point(opt_names_list[i], freq_n, &freq);
+		if (rc != 0) {
+			powerop_put_registered_opt_names(opt_names_list);
+			return rc;
+		}
+
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+		switch(relation) {
+		case CPUFREQ_RELATION_H:
+			if (freq <= target_freq) {
+				if (freq >= optimal) {
+					optimal = freq;
+					optimal_found = 1;
+					optimal_name = opt_names_list[i];
+				}
+			} else {
+				if (freq <= suboptimal) {
+					suboptimal = freq;
+					suboptimal_found = 1;
+					suboptimal_name = opt_names_list[i];
+				}
+			}
+			break;
+		case CPUFREQ_RELATION_L:
+			if (freq >= target_freq) {
+				if (freq <= optimal) {
+					optimal = freq;
+					optimal_found = 1;
+					optimal_name = opt_names_list[i];
+				}
+			} else {
+				if (freq >= suboptimal) {
+					suboptimal = freq;
+					suboptimal_found = 1;
+					suboptimal_name = opt_names_list[i];
+				}
+			}
+			break;
+		}
+	}
+	powerop_put_registered_opt_names(opt_names_list);
+
+	if (!optimal_found) {
+		if (!suboptimal_found)
+			return -EINVAL;
+		target_opt_name = suboptimal_name;
+	} else
+		target_opt_name = optimal_name;
+
+	rc = powerop_get_point(NULL, freq_n, &freqs.old);
+	if (rc != 0)
+		return rc;
+
+	rc = powerop_get_point(target_opt_name, freq_n, &freqs.new); 
+	if (rc != 0)
+		return rc;
+
+#ifdef CONFIG_HOTPLUG_CPU
+	/* cpufreq holds the hotplug lock, so we are safe from here on */
+	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#else
+	online_policy_cpus = policy->cpus;
+#endif
+
+	for_each_cpu_mask(j, online_policy_cpus) {
+		freqs.cpu = j;
+		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+	}
+
+	rc = powerop_set_point(target_opt_name);
+	if (rc != 0) {
+		int tmp;
+		tmp = freqs.new;
+		freqs.new = freqs.old;
+		freqs.old = tmp;
+		for_each_cpu_mask(j, online_policy_cpus) {
+			freqs.cpu = j;
+			cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
+			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+		}
+	} else {
+		for_each_cpu_mask(j, online_policy_cpus) {
+			freqs.cpu = j;
+			cpufreq_notify_transition(&freqs, CPUFREQ_POSTCHANGE);
+		}
+	}
+
+	return rc;
+}
+
+int 
+cpufreq_setpolicy(struct cpufreq_policy *policy)
+{
+	char lfreq_hfreq[20];
+	int cpu = policy->cpu;
+	int i, rc;
+	char **opt_names_list = NULL;
+	int opt_names_list_size = 0;
+
+	/* 
+	 * FIXME: just reference code
+	 * if you specify smart_cpu cpufreq expects your PM Core
+	 * support the following power parameter names:
+	 * "lfreqN", "hfreqN"
+	 */
+	powerop_get_registered_opt_names(opt_names_list,
+                                             &opt_names_list_size); 
+	sprintf(lfreq_hfreq, "lfreq%d hfreq%d ", cpu, cpu);
+	for (i = 0; i < opt_names_list_size; i++) {
+		unsigned int lfreq, hfreq;
+
+		rc = powerop_get_point(opt_names_list[i], lfreq_hfreq, &lfreq, 
+				       &hfreq);
+		if (rc != 0) {
+			powerop_put_registered_opt_names(opt_names_list);
+			return rc;
+		}
+
+		if ((lfreq == CPUFREQ_ENTRY_INVALID) || 
+		     (hfreq == CPUFREQ_ENTRY_INVALID))
+			continue;
+		if ((lfreq > policy->min) && (hfreq < policy->max)) {
+			/* point fits */
+			powerop_set_point(opt_names_list[i]);
+			break;	
+		}
+	}
+	return 0;
+}
+
+MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
+MODULE_DESCRIPTION ("CPUfreq core helpers");
+MODULE_LICENSE ("GPL");
+
diff --git a/drivers/cpufreq/freq_helpers.h b/drivers/cpufreq/freq_helpers.h
new file mode 100644
index 0000000..78780ef
--- /dev/null
+++ b/drivers/cpufreq/freq_helpers.h
@@ -0,0 +1,22 @@
+/*
+ * cpufreq core helpers
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+#ifndef __LINUX_CPUFREQ_HELPERS_H__
+#define __LINUX_CPUFREQ_HELPERS_H__
+
+#include <linux/cpufreq.h>
+
+#define CPUFREQ_ENTRY_INVALID	~0
+
+int cpufreq_cpuinfo(struct cpufreq_policy *policy);
+int cpufreq_verify(struct cpufreq_policy *policy);
+int cpufreq_target(struct cpufreq_policy *policy, unsigned int target_freq,
+		   unsigned int relation);
+int cpufreq_setpolicy(struct cpufreq_policy *policy);
+
+#endif /* __LINUX_CPUFREQ_POWEROP_H__ */
+
diff --git a/drivers/cpufreq/freq_table.c b/drivers/cpufreq/freq_table.c
deleted file mode 100644
index 551f4cc..0000000
--- a/drivers/cpufreq/freq_table.c
+++ /dev/null
@@ -1,227 +0,0 @@
-/*
- * linux/drivers/cpufreq/freq_table.c
- *
- * Copyright (C) 2002 - 2003 Dominik Brodowski
- */
-
-#include <linux/kernel.h>
-#include <linux/module.h>
-#include <linux/init.h>
-#include <linux/cpufreq.h>
-
-#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, "freq-table", msg)
-
-/*********************************************************************
- *                     FREQUENCY TABLE HELPERS                       *
- *********************************************************************/
-
-int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
-				    struct cpufreq_frequency_table *table)
-{
-	unsigned int min_freq = ~0;
-	unsigned int max_freq = 0;
-	unsigned int i;
-
-	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		unsigned int freq = table[i].frequency;
-		if (freq == CPUFREQ_ENTRY_INVALID) {
-			dprintk("table entry %u is invalid, skipping\n", i);
-
-			continue;
-		}
-		dprintk("table entry %u: %u kHz, %u index\n", i, freq, table[i].index);
-		if (freq < min_freq)
-			min_freq = freq;
-		if (freq > max_freq)
-			max_freq = freq;
-	}
-
-	policy->min = policy->cpuinfo.min_freq = min_freq;
-	policy->max = policy->cpuinfo.max_freq = max_freq;
-
-	if (policy->min == ~0)
-		return -EINVAL;
-	else
-		return 0;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_cpuinfo);
-
-
-int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
-				   struct cpufreq_frequency_table *table)
-{
-	unsigned int next_larger = ~0;
-	unsigned int i;
-	unsigned int count = 0;
-
-	dprintk("request for verification of policy (%u - %u kHz) for cpu %u\n", policy->min, policy->max, policy->cpu);
-
-	if (!cpu_online(policy->cpu))
-		return -EINVAL;
-
-	cpufreq_verify_within_limits(policy,
-				     policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
-
-	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		unsigned int freq = table[i].frequency;
-		if (freq == CPUFREQ_ENTRY_INVALID)
-			continue;
-		if ((freq >= policy->min) && (freq <= policy->max))
-			count++;
-		else if ((next_larger > freq) && (freq > policy->max))
-			next_larger = freq;
-	}
-
-	if (!count)
-		policy->max = next_larger;
-
-	cpufreq_verify_within_limits(policy,
-				     policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
-
-	dprintk("verification lead to (%u - %u kHz) for cpu %u\n", policy->min, policy->max, policy->cpu);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
-
-
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   struct cpufreq_frequency_table *table,
-				   unsigned int target_freq,
-				   unsigned int relation,
-				   unsigned int *index)
-{
-	struct cpufreq_frequency_table optimal = {
-		.index = ~0,
-		.frequency = 0,
-	};
-	struct cpufreq_frequency_table suboptimal = {
-		.index = ~0,
-		.frequency = 0,
-	};
-	unsigned int i;
-
-	dprintk("request for target %u kHz (relation: %u) for cpu %u\n", target_freq, relation, policy->cpu);
-
-	switch (relation) {
-	case CPUFREQ_RELATION_H:
-		suboptimal.frequency = ~0;
-		break;
-	case CPUFREQ_RELATION_L:
-		optimal.frequency = ~0;
-		break;
-	}
-
-	if (!cpu_online(policy->cpu))
-		return -EINVAL;
-
-	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		unsigned int freq = table[i].frequency;
-		if (freq == CPUFREQ_ENTRY_INVALID)
-			continue;
-		if ((freq < policy->min) || (freq > policy->max))
-			continue;
-		switch(relation) {
-		case CPUFREQ_RELATION_H:
-			if (freq <= target_freq) {
-				if (freq >= optimal.frequency) {
-					optimal.frequency = freq;
-					optimal.index = i;
-				}
-			} else {
-				if (freq <= suboptimal.frequency) {
-					suboptimal.frequency = freq;
-					suboptimal.index = i;
-				}
-			}
-			break;
-		case CPUFREQ_RELATION_L:
-			if (freq >= target_freq) {
-				if (freq <= optimal.frequency) {
-					optimal.frequency = freq;
-					optimal.index = i;
-				}
-			} else {
-				if (freq >= suboptimal.frequency) {
-					suboptimal.frequency = freq;
-					suboptimal.index = i;
-				}
-			}
-			break;
-		}
-	}
-	if (optimal.index > i) {
-		if (suboptimal.index > i)
-			return -EINVAL;
-		*index = suboptimal.index;
-	} else
-		*index = optimal.index;
-
-	dprintk("target is %u (%u kHz, %u)\n", *index, table[*index].frequency,
-		table[*index].index);
-
-	return 0;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_target);
-
-static struct cpufreq_frequency_table *show_table[NR_CPUS];
-/**
- * show_scaling_governor - show the current policy for the specified CPU
- */
-static ssize_t show_available_freqs (struct cpufreq_policy *policy, char *buf)
-{
-	unsigned int i = 0;
-	unsigned int cpu = policy->cpu;
-	ssize_t count = 0;
-	struct cpufreq_frequency_table *table;
-
-	if (!show_table[cpu])
-		return -ENODEV;
-
-	table = show_table[cpu];
-
-	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
-		if (table[i].frequency == CPUFREQ_ENTRY_INVALID)
-			continue;
-		count += sprintf(&buf[count], "%d ", table[i].frequency);
-	}
-	count += sprintf(&buf[count], "\n");
-
-	return count;
-
-}
-
-struct freq_attr cpufreq_freq_attr_scaling_available_freqs = {
-	.attr = { .name = "scaling_available_frequencies", .mode = 0444, .owner=THIS_MODULE },
-	.show = show_available_freqs,
-};
-EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
-
-/*
- * if you use these, you must assure that the frequency table is valid
- * all the time between get_attr and put_attr!
- */
-void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table,
-				      unsigned int cpu)
-{
-	dprintk("setting show_table for cpu %u to %p\n", cpu, table);
-	show_table[cpu] = table;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_get_attr);
-
-void cpufreq_frequency_table_put_attr(unsigned int cpu)
-{
-	dprintk("clearing show_table for cpu %u\n", cpu);
-	show_table[cpu] = NULL;
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_table_put_attr);
-
-struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu)
-{
-	return show_table[cpu];
-}
-EXPORT_SYMBOL_GPL(cpufreq_frequency_get_table);
-
-MODULE_AUTHOR ("Dominik Brodowski <linux@brodo.de>");
-MODULE_DESCRIPTION ("CPUfreq frequency table helpers");
-MODULE_LICENSE ("GPL");
diff --git a/include/linux/cpufreq.h b/include/linux/cpufreq.h
index 4ea39fe..6e85cb4 100644
--- a/include/linux/cpufreq.h
+++ b/include/linux/cpufreq.h
@@ -3,7 +3,10 @@
  *
  *  Copyright (C) 2001 Russell King
  *            (C) 2002 - 2003 Dominik Brodowski <linux@brodo.de>
- *            
+ *  
+ *  Eugeny S. Mints <eugeny@nomadgs.com> 
+ *  
+ *  Interface update (get rid of cpufreq driver, integation with PowerOP
  *
  * $Id: cpufreq.h,v 1.36 2003/01/20 17:31:48 db Exp $
  *
@@ -27,7 +30,20 @@ #include <asm/div64.h>
 
 #define CPUFREQ_NAME_LEN 16
 
-
+/*********************************************************************
+ * cpufreq PowerOP glue for multi cpu support 
+ *
+ * cpufreq layer refers to frequency and voltage of cpuN by "vN", "freqN" 
+ * string when calls powerop_regiter/get_point()
+ ********************************************************************/
+/* FIXME: request review */
+#define CPUFREQ_FREQ_STR_SIZE	8
+#define CPUFREQ_FREQ_OP_SIZE	20
+#define CPUFREQ_OP_NAME_SIZE    12
+#define CPUFREQ_CPU_N_FREQ(freq, n) sprintf((freq), "freq%d ", (n))
+#define CPUFREQ_CPU_N_FREQ_V(op, n) sprintf((op), "v%d freq%d ", (n), (n))
+#define CPUFREQ_CPU_N_GNRT_OP_NAME(res, cpu, idx) \
+	sprintf((res), "cpu%d_opt%d", (cpu), (idx))
 /*********************************************************************
  *                     CPUFREQ NOTIFIER INTERFACE                    *
  *********************************************************************/
@@ -100,11 +116,6 @@ #define CPUFREQ_ADJUST		(0)
 #define CPUFREQ_INCOMPATIBLE	(1)
 #define CPUFREQ_NOTIFY		(2)
 
-#define CPUFREQ_SHARED_TYPE_NONE (0) /* None */
-#define CPUFREQ_SHARED_TYPE_HW	 (1) /* HW does needed coordination */
-#define CPUFREQ_SHARED_TYPE_ALL	 (2) /* All dependent CPUs should set freq */
-#define CPUFREQ_SHARED_TYPE_ANY	 (3) /* Freq can be set from any dependent CPU*/
-
 /******************** cpufreq transition notifiers *******************/
 
 #define CPUFREQ_PRECHANGE	(0)
@@ -185,31 +196,6 @@ #define CPUFREQ_RELATION_H 1  /* highest
 
 struct freq_attr;
 
-struct cpufreq_driver {
-	struct module           *owner;
-	char			name[CPUFREQ_NAME_LEN];
-	u8			flags;
-
-	/* needed by all drivers */
-	int	(*init)		(struct cpufreq_policy *policy);
-	int	(*verify)	(struct cpufreq_policy *policy);
-
-	/* define one out of two */
-	int	(*setpolicy)	(struct cpufreq_policy *policy);
-	int	(*target)	(struct cpufreq_policy *policy,
-				 unsigned int target_freq,
-				 unsigned int relation);
-
-	/* should be defined, if possible */
-	unsigned int	(*get)	(unsigned int cpu);
-
-	/* optional */
-	int	(*exit)		(struct cpufreq_policy *policy);
-	int	(*suspend)	(struct cpufreq_policy *policy, pm_message_t pmsg);
-	int	(*resume)	(struct cpufreq_policy *policy);
-	struct freq_attr	**attr;
-};
-
 /* flags */
 
 #define CPUFREQ_STICKY		0x01	/* the driver isn't removed even if 
@@ -220,10 +206,6 @@ #define CPUFREQ_CONST_LOOPS 	0x02	/* loo
 #define CPUFREQ_PM_NO_WARN	0x04	/* don't warn on suspend/resume speed
 					 * mismatches */
 
-int cpufreq_register_driver(struct cpufreq_driver *driver_data);
-int cpufreq_unregister_driver(struct cpufreq_driver *driver_data);
-
-
 void cpufreq_notify_transition(struct cpufreq_freqs *freqs, unsigned int state);
 
 
@@ -284,45 +266,9 @@ #define CPUFREQ_DEFAULT_GOVERNOR	&cpufre
 #endif
 
 
-/*********************************************************************
- *                     FREQUENCY TABLE HELPERS                       *
- *********************************************************************/
-
-#define CPUFREQ_ENTRY_INVALID ~0
-#define CPUFREQ_TABLE_END     ~1
-
-struct cpufreq_frequency_table {
-	unsigned int	index;     /* any */
-	unsigned int	frequency; /* kHz - doesn't need to be in ascending
-				    * order */
-};
-
-int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
-				    struct cpufreq_frequency_table *table);
-
-int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
-				   struct cpufreq_frequency_table *table);
-
-int cpufreq_frequency_table_target(struct cpufreq_policy *policy,
-				   struct cpufreq_frequency_table *table,
-				   unsigned int target_freq,
-				   unsigned int relation,
-				   unsigned int *index);
-
-/* the following 3 funtions are for cpufreq core use only */
-struct cpufreq_frequency_table *cpufreq_frequency_get_table(unsigned int cpu);
 struct cpufreq_policy *cpufreq_cpu_get(unsigned int cpu);
 void   cpufreq_cpu_put (struct cpufreq_policy *data);
 
-/* the following are really really optional */
-extern struct freq_attr cpufreq_freq_attr_scaling_available_freqs;
-
-void cpufreq_frequency_table_get_attr(struct cpufreq_frequency_table *table, 
-				      unsigned int cpu);
-
-void cpufreq_frequency_table_put_attr(unsigned int cpu);
-
-
 /*********************************************************************
  *                     UNIFIED DEBUG HELPERS                         *
  *********************************************************************/


--------------080003030500000207030709--
