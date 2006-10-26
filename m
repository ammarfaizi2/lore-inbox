Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423245AbWJZKxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423245AbWJZKxH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:53:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423246AbWJZKxG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:53:06 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:38350 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423245AbWJZKxD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:53:03 -0400
Date: Thu, 26 Oct 2006 16:23:42 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, gaughen@us.ibm.com, arjan@linux.intel.org,
       davej@redhat.com, venkatesh.pallipadi@intel.com, kiran@scalex86.org
Subject: [PATCH 2/5] lock_cpu_hotplug:Redesign - remove lock_cpu_hotplug from hot-cpu_callback path in cpufreq. 
Message-ID: <20061026105342.GC11803@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061026104858.GA11803@in.ibm.com> <20061026105058.GB11803@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026105058.GB11803@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ensure that the hot-cpu-callback path in cpufreq is free from any  
(un)lock_cpu_hotplug calls.

Signed-off-by : Gautham R Shenoy <ego@in.ibm.com>
---
 drivers/cpufreq/cpufreq.c       |   83 +++++++++++++++++++++++++++-------------
 drivers/cpufreq/cpufreq_stats.c |    4 +
 include/linux/cpufreq.h         |    1 
 3 files changed, 61 insertions(+), 27 deletions(-)

Index: hotplug/drivers/cpufreq/cpufreq.c
===================================================================
--- hotplug.orig/drivers/cpufreq/cpufreq.c
+++ hotplug/drivers/cpufreq/cpufreq.c
@@ -642,6 +642,7 @@ static struct kobj_type ktype_cpufreq = 
 };
 
 
+int _cpufreq_set_policy(struct cpufreq_policy *);
 /**
  * cpufreq_add_dev - add a CPU device
  *
@@ -776,11 +777,11 @@ static int cpufreq_add_dev (struct sys_d
 	}
 
 	policy->governor = NULL; /* to assure that the starting sequence is
-				  * run in cpufreq_set_policy */
+				  * run in _cpufreq_set_policy */
 	mutex_unlock(&policy->lock);
 
 	/* set default policy */
-	ret = cpufreq_set_policy(&new_policy);
+	ret = _cpufreq_set_policy(&new_policy);
 	if (ret) {
 		dprintk("setting policy failed\n");
 		goto err_out_unregister;
@@ -1284,7 +1285,9 @@ int __cpufreq_driver_target(struct cpufr
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
-int cpufreq_driver_target(struct cpufreq_policy *policy,
+/*Locking: Must be called with lock_cpu_hotplug held, except from the
+hotcpu callback path */
+int _cpufreq_driver_target(struct cpufreq_policy *policy,
 			  unsigned int target_freq,
 			  unsigned int relation)
 {
@@ -1294,17 +1297,27 @@ int cpufreq_driver_target(struct cpufreq
 	if (!policy)
 		return -EINVAL;
 
-	lock_cpu_hotplug();
 	mutex_lock(&policy->lock);
 
 	ret = __cpufreq_driver_target(policy, target_freq, relation);
 
 	mutex_unlock(&policy->lock);
-	unlock_cpu_hotplug();
 
 	cpufreq_cpu_put(policy);
 	return ret;
 }
+int cpufreq_driver_target(struct cpufreq_policy *policy,
+			  unsigned int target_freq,
+			  unsigned int relation)
+{
+	int ret;
+
+	lock_cpu_hotplug();
+	ret = _cpufreq_driver_target(policy, target_freq, relation);
+	unlock_cpu_hotplug();
+
+	return ret;
+}
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 
 int cpufreq_driver_getavg(struct cpufreq_policy *policy)
@@ -1511,13 +1524,8 @@ error_out:
 	return ret;
 }
 
-/**
- *	cpufreq_set_policy - set a new CPUFreq policy
- *	@policy: policy to be set.
- *
- *	Sets a new CPU frequency and voltage scaling policy.
- */
-int cpufreq_set_policy(struct cpufreq_policy *policy)
+/* Locking: To be called with lock_cpu_hotplug held. */
+int _cpufreq_set_policy(struct cpufreq_policy *policy)
 {
 	int ret = 0;
 	struct cpufreq_policy *data;
@@ -1529,8 +1537,6 @@ int cpufreq_set_policy(struct cpufreq_po
 	if (!data)
 		return -EINVAL;
 
-	lock_cpu_hotplug();
-
 	/* lock this CPU */
 	mutex_lock(&data->lock);
 
@@ -1541,23 +1547,32 @@ int cpufreq_set_policy(struct cpufreq_po
 	data->user_policy.governor = data->governor;
 
 	mutex_unlock(&data->lock);
-
-	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 
 	return ret;
 }
-EXPORT_SYMBOL(cpufreq_set_policy);
-
 
 /**
- *	cpufreq_update_policy - re-evaluate an existing cpufreq policy
- *	@cpu: CPU which shall be re-evaluated
+ *	cpufreq_set_policy - set a new CPUFreq policy
+ *	@policy: policy to be set.
  *
- *	Usefull for policy notifiers which have different necessities
- *	at different times.
+ *	Sets a new CPU frequency and voltage scaling policy.
  */
-int cpufreq_update_policy(unsigned int cpu)
+int cpufreq_set_policy(struct cpufreq_policy *policy)
+{
+	int ret;
+
+	lock_cpu_hotplug();
+	ret = _cpufreq_set_policy(policy);
+	unlock_cpu_hotplug();
+
+	return ret;
+}
+EXPORT_SYMBOL(cpufreq_set_policy);
+
+
+/* Locking: to be called with lock_cpu_hotplug held. */
+int __cpufreq_update_policy(unsigned int cpu)
 {
 	struct cpufreq_policy *data = cpufreq_cpu_get(cpu);
 	struct cpufreq_policy policy;
@@ -1566,7 +1581,6 @@ int cpufreq_update_policy(unsigned int c
 	if (!data)
 		return -ENODEV;
 
-	lock_cpu_hotplug();
 	mutex_lock(&data->lock);
 
 	dprintk("updating policy for CPU %u\n", cpu);
@@ -1593,10 +1607,27 @@ int cpufreq_update_policy(unsigned int c
 	ret = __cpufreq_set_policy(data, &policy);
 
 	mutex_unlock(&data->lock);
-	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 	return ret;
 }
+
+/**
+ *	cpufreq_update_policy - re-evaluate an existing cpufreq policy
+ *	@cpu: CPU which shall be re-evaluated
+ *
+ *	Usefull for policy notifiers which have different necessities
+ *	at different times.
+ */
+int cpufreq_update_policy(unsigned int cpu)
+{
+	int ret;
+
+	lock_cpu_hotplug();
+	ret = __cpufreq_update_policy(cpu);
+	unlock_cpu_hotplug();
+
+	return ret;
+}
 EXPORT_SYMBOL(cpufreq_update_policy);
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1623,7 +1654,7 @@ static int cpufreq_cpu_callback(struct n
 			 */
 			policy = cpufreq_cpu_data[cpu];
 			if (policy) {
-				cpufreq_driver_target(policy, policy->min,
+				_cpufreq_driver_target(policy, policy->min,
 						CPUFREQ_RELATION_H);
 			}
 			break;
Index: hotplug/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- hotplug.orig/drivers/cpufreq/cpufreq_stats.c
+++ hotplug/drivers/cpufreq/cpufreq_stats.c
@@ -309,7 +309,7 @@ static int cpufreq_stat_cpu_callback(str
 
 	switch (action) {
 	case CPU_ONLINE:
-		cpufreq_update_policy(cpu);
+		__cpufreq_update_policy(cpu);
 		break;
 	case CPU_DEAD:
 		cpufreq_stats_free_table(cpu);
@@ -350,10 +350,12 @@ __init cpufreq_stats_init(void)
 	}
 
 	register_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
+	lock_cpu_hotplug();
 	for_each_online_cpu(cpu) {
 		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier,
 				CPU_ONLINE, (void *)(long)cpu);
 	}
+	unlock_cpu_hotplug();
 	return 0;
 }
 static void
Index: hotplug/include/linux/cpufreq.h
===================================================================
--- hotplug.orig/include/linux/cpufreq.h
+++ hotplug/include/linux/cpufreq.h
@@ -258,6 +258,7 @@ struct freq_attr {
 int cpufreq_set_policy(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 int cpufreq_update_policy(unsigned int cpu);
+int __cpufreq_update_policy(unsigned int cpu);
 
 /* query the current CPU frequency (in kHz). If zero, cpufreq couldn't detect it */
 unsigned int cpufreq_get(unsigned int cpu);
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
