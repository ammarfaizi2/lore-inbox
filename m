Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751037AbWHXK1W@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751037AbWHXK1W (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Aug 2006 06:27:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751040AbWHXK1W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Aug 2006 06:27:22 -0400
Received: from ausmtp06.au.ibm.com ([202.81.18.155]:26307 "EHLO
	ausmtp06.au.ibm.com") by vger.kernel.org with ESMTP
	id S1751030AbWHXK1V (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Aug 2006 06:27:21 -0400
Date: Thu, 24 Aug 2006 15:58:22 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: rusty@rustcorp.com.au, torvalds@osdl.org, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, arjan@intel.linux.com, mingo@elte.hu,
       davej@redhat.com, vatsa@in.ibm.com, dipankar@in.ibm.com,
       ashok.raj@intel.com
Subject: [RFC][PATCH 1/4] Clean up cpufreq hot-cpu callback.
Message-ID: <20060824102822.GB2395@in.ibm.com>
Reply-To: ego@in.ibm.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="+QahgC5+KEYLbs62"
Content-Disposition: inline
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline


-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"

--+QahgC5+KEYLbs62
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="1of4.patch"

This patch cleans up the hot-cpu callback interface of cpufreq so that
lock_cpu_hotplug won't be called from a cpu_up or a cpu_down.

Signed-off-by : Gautham R Shenoy <ego@in.ibm.com>

Index: current/include/linux/cpufreq.h
===================================================================
--- current.orig/include/linux/cpufreq.h	2006-08-06 23:50:11.000000000 +0530
+++ current/include/linux/cpufreq.h	2006-08-24 14:59:59.000000000 +0530
@@ -164,6 +164,9 @@ struct cpufreq_governor {
 
 /* pass a target to the cpufreq driver 
  */
+extern int cpufreq_driver_target_cpulocked(struct cpufreq_policy *policy,
+				 unsigned int target_freq,
+				 unsigned int relation);
 extern int cpufreq_driver_target(struct cpufreq_policy *policy,
 				 unsigned int target_freq,
 				 unsigned int relation);
@@ -253,8 +256,10 @@ struct freq_attr {
  *                        CPUFREQ 2.6. INTERFACE                     *
  *********************************************************************/
 int cpufreq_set_policy(struct cpufreq_policy *policy);
+int cpufreq_set_policy_cpulocked(struct cpufreq_policy *policy);
 int cpufreq_get_policy(struct cpufreq_policy *policy, unsigned int cpu);
 int cpufreq_update_policy(unsigned int cpu);
+int cpufreq_update_policy_cpulocked(unsigned int cpu);
 
 /* query the current CPU frequency (in kHz). If zero, cpufreq couldn't detect it */
 unsigned int cpufreq_get(unsigned int cpu);
Index: current/drivers/cpufreq/cpufreq.c
===================================================================
--- current.orig/drivers/cpufreq/cpufreq.c	2006-08-06 23:50:11.000000000 +0530
+++ current/drivers/cpufreq/cpufreq.c	2006-08-24 14:59:59.000000000 +0530
@@ -744,7 +744,7 @@ static int cpufreq_add_dev (struct sys_d
 	mutex_unlock(&policy->lock);
 
 	/* set default policy */
-	ret = cpufreq_set_policy(&new_policy);
+	ret = cpufreq_set_policy_cpulocked(&new_policy);
 	if (ret) {
 		dprintk("setting policy failed\n");
 		goto err_out_unregister;
@@ -1246,27 +1246,37 @@ int __cpufreq_driver_target(struct cpufr
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
 
 int cpufreq_driver_target(struct cpufreq_policy *policy,
+				    unsigned int target_freq,
+				    unsigned int relation)
+{
+	int ret=0;
+	lock_cpu_hotplug();
+	ret= cpufreq_driver_target_cpulocked(policy,target_freq,relation);
+	unlock_cpu_hotplug();
+	return ret;
+}
+EXPORT_SYMBOL_GPL(cpufreq_driver_target);
+
+int cpufreq_driver_target_cpulocked(struct cpufreq_policy *policy,
 			  unsigned int target_freq,
 			  unsigned int relation)
 {
-	int ret;
+	int ret=0;
 
 	policy = cpufreq_cpu_get(policy->cpu);
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
-EXPORT_SYMBOL_GPL(cpufreq_driver_target);
+EXPORT_SYMBOL_GPL(cpufreq_driver_target_cpulocked);
 
 /*
  * Locking: Must be called with the lock_cpu_hotplug() lock held
@@ -1450,6 +1460,15 @@ error_out:
  */
 int cpufreq_set_policy(struct cpufreq_policy *policy)
 {
+	int ret=0;
+	lock_cpu_hotplug();
+	ret = cpufreq_set_policy_cpulocked(policy);
+	unlock_cpu_hotplug();
+	return ret;
+}
+
+int cpufreq_set_policy_cpulocked(struct cpufreq_policy *policy)
+{
 	int ret = 0;
 	struct cpufreq_policy *data;
 
@@ -1460,7 +1479,6 @@ int cpufreq_set_policy(struct cpufreq_po
 	if (!data)
 		return -EINVAL;
 
-	lock_cpu_hotplug();
 
 	/* lock this CPU */
 	mutex_lock(&data->lock);
@@ -1473,7 +1491,6 @@ int cpufreq_set_policy(struct cpufreq_po
 
 	mutex_unlock(&data->lock);
 
-	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 
 	return ret;
@@ -1482,13 +1499,15 @@ EXPORT_SYMBOL(cpufreq_set_policy);
 
 
 /**
- *	cpufreq_update_policy - re-evaluate an existing cpufreq policy
+ *	cpufreq_update_policy_cpulocked - re-evaluate an existing cpufreq
+ *	policy.
+ *	To be called with lock_cpu_hotplug() held.
  *	@cpu: CPU which shall be re-evaluated
  *
  *	Usefull for policy notifiers which have different necessities
  *	at different times.
  */
-int cpufreq_update_policy(unsigned int cpu)
+int cpufreq_update_policy_cpulocked(unsigned int cpu)
 {
 	struct cpufreq_policy *data = cpufreq_cpu_get(cpu);
 	struct cpufreq_policy policy;
@@ -1497,7 +1516,6 @@ int cpufreq_update_policy(unsigned int c
 	if (!data)
 		return -ENODEV;
 
-	lock_cpu_hotplug();
 	mutex_lock(&data->lock);
 
 	dprintk("updating policy for CPU %u\n", cpu);
@@ -1523,10 +1541,28 @@ int cpufreq_update_policy(unsigned int c
 	ret = __cpufreq_set_policy(data, &policy);
 
 	mutex_unlock(&data->lock);
-	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 	return ret;
 }
+EXPORT_SYMBOL(cpufreq_update_policy_cpulocked);
+
+/**
+ *	cpufreq_update_policy - re-evaluate an existing cpufreq
+ *	policy.
+ *	Must be called with lock_cpu_hotplug() *not* being held.
+ *	@cpu: CPU which shall be re-evaluated
+ *
+ *	Usefull for policy notifiers which have different necessities
+ *	at different times.
+ */
+int cpufreq_update_policy(unsigned int cpu)
+{
+	int ret=0;
+	lock_cpu_hotplug();
+	cpufreq_update_policy_cpulocked(cpu);
+	unlock_cpu_hotplug();
+	return ret;
+}
 EXPORT_SYMBOL(cpufreq_update_policy);
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1553,8 +1589,8 @@ static int cpufreq_cpu_callback(struct n
 			 */
 			policy = cpufreq_cpu_data[cpu];
 			if (policy) {
-				cpufreq_driver_target(policy, policy->min,
-						CPUFREQ_RELATION_H);
+				cpufreq_driver_target_cpulocked(policy,
+					policy->min, CPUFREQ_RELATION_H);
 			}
 			break;
 		case CPU_DEAD:
Index: current/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- current.orig/drivers/cpufreq/cpufreq_stats.c	2006-08-06 23:50:11.000000000 +0530
+++ current/drivers/cpufreq/cpufreq_stats.c	2006-08-24 14:59:59.000000000 +0530
@@ -309,7 +309,7 @@ static int cpufreq_stat_cpu_callback(str
 
 	switch (action) {
 	case CPU_ONLINE:
-		cpufreq_update_policy(cpu);
+		cpufreq_update_policy_cpulocked(cpu);
 		break;
 	case CPU_DEAD:
 		cpufreq_stats_free_table(cpu);

--+QahgC5+KEYLbs62--
