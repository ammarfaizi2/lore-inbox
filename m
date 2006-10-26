Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423240AbWJZKue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423240AbWJZKue (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 06:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423233AbWJZKue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 06:50:34 -0400
Received: from ausmtp04.au.ibm.com ([202.81.18.152]:51914 "EHLO
	ausmtp04.au.ibm.com") by vger.kernel.org with ESMTP
	id S1423240AbWJZKud (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 06:50:33 -0400
Date: Thu, 26 Oct 2006 16:20:58 +0530
From: Gautham R Shenoy <ego@in.ibm.com>
To: Gautham R Shenoy <ego@in.ibm.com>
Cc: rusty@rustcorp.com.au, torvalds@osdl.org, mingo@elte.hu, akpm@osdl.org,
       linux-kernel@vger.kernel.org, paulmck@us.ibm.com, vatsa@in.ibm.com,
       dipankar@in.ibm.com, gaughen@us.ibm.com, arjan@linux.intel.org,
       davej@redhat.com, venkatesh.pallipadi@intel.com, kiran@scalex86.org
Subject: [PATCH 1/5] lock_cpu_hotplug:Redesign - Fix coding style issues in cpufreq.
Message-ID: <20061026105058.GB11803@in.ibm.com>
Reply-To: ego@in.ibm.com
References: <20061026104858.GA11803@in.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061026104858.GA11803@in.ibm.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up cpufreq subsystem to fix coding style issues and to improve
the readability.

Signed-off-by: Gautham R Shenoy <ego@in.ibm.com>
---
 drivers/cpufreq/cpufreq.c              |  136 ++++++++++++++++++++++-----------
 drivers/cpufreq/cpufreq_conservative.c |   23 +++--
 drivers/cpufreq/cpufreq_ondemand.c     |   12 +-
 drivers/cpufreq/cpufreq_performance.c  |    9 +-
 drivers/cpufreq/cpufreq_powersave.c    |    9 +-
 drivers/cpufreq/cpufreq_stats.c        |   11 +-
 drivers/cpufreq/freq_table.c           |   28 ++++--
 7 files changed, 150 insertions(+), 78 deletions(-)

Index: hotplug/drivers/cpufreq/cpufreq.c
===================================================================
--- hotplug.orig/drivers/cpufreq/cpufreq.c
+++ hotplug/drivers/cpufreq/cpufreq.c
@@ -29,7 +29,8 @@
 #include <linux/completion.h>
 #include <linux/mutex.h>
 
-#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, "cpufreq-core", msg)
+#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, \
+						"cpufreq-core", msg)
 
 /**
  * The "cpufreq driver" - the arch- or hardware-dependent low
@@ -41,7 +42,8 @@ static struct cpufreq_policy *cpufreq_cp
 static DEFINE_SPINLOCK(cpufreq_driver_lock);
 
 /* internal prototypes */
-static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event);
+static int __cpufreq_governor(struct cpufreq_policy *policy,
+						unsigned int event);
 static void handle_update(void *data);
 
 /**
@@ -151,7 +153,8 @@ static void cpufreq_debug_disable_rateli
 	spin_unlock_irqrestore(&disable_ratelimit_lock, flags);
 }
 
-void cpufreq_debug_printk(unsigned int type, const char *prefix, const char *fmt, ...)
+void cpufreq_debug_printk(unsigned int type, const char *prefix,
+							const char *fmt, ...)
 {
 	char s[256];
 	va_list args;
@@ -161,7 +164,8 @@ void cpufreq_debug_printk(unsigned int t
 	WARN_ON(!prefix);
 	if (type & debug) {
 		spin_lock_irqsave(&disable_ratelimit_lock, flags);
-		if (!disable_ratelimit && debug_ratelimit && !printk_ratelimit()) {
+		if (!disable_ratelimit && debug_ratelimit
+					&& !printk_ratelimit()) {
 			spin_unlock_irqrestore(&disable_ratelimit_lock, flags);
 			return;
 		}
@@ -182,10 +186,12 @@ EXPORT_SYMBOL(cpufreq_debug_printk);
 
 
 module_param(debug, uint, 0644);
-MODULE_PARM_DESC(debug, "CPUfreq debugging: add 1 to debug core, 2 to debug drivers, and 4 to debug governors.");
+MODULE_PARM_DESC(debug, "CPUfreq debugging: add 1 to debug core,"
+			" 2 to debug drivers, and 4 to debug governors.");
 
 module_param(debug_ratelimit, uint, 0644);
-MODULE_PARM_DESC(debug_ratelimit, "CPUfreq debugging: set to 0 to disable ratelimiting.");
+MODULE_PARM_DESC(debug_ratelimit, "CPUfreq debugging:"
+					" set to 0 to disable ratelimiting.");
 
 #else /* !CONFIG_CPU_FREQ_DEBUG */
 
@@ -219,17 +225,23 @@ static void adjust_jiffies(unsigned long
 	if (!l_p_j_ref_freq) {
 		l_p_j_ref = loops_per_jiffy;
 		l_p_j_ref_freq = ci->old;
-		dprintk("saving %lu as reference value for loops_per_jiffy; freq is %u kHz\n", l_p_j_ref, l_p_j_ref_freq);
+		dprintk("saving %lu as reference value for loops_per_jiffy;"
+			"freq is %u kHz\n", l_p_j_ref, l_p_j_ref_freq);
 	}
 	if ((val == CPUFREQ_PRECHANGE  && ci->old < ci->new) ||
 	    (val == CPUFREQ_POSTCHANGE && ci->old > ci->new) ||
 	    (val == CPUFREQ_RESUMECHANGE || val == CPUFREQ_SUSPENDCHANGE)) {
-		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq, ci->new);
-		dprintk("scaling loops_per_jiffy to %lu for frequency %u kHz\n", loops_per_jiffy, ci->new);
+		loops_per_jiffy = cpufreq_scale(l_p_j_ref, l_p_j_ref_freq,
+								ci->new);
+		dprintk("scaling loops_per_jiffy to %lu"
+			"for frequency %u kHz\n", loops_per_jiffy, ci->new);
 	}
 }
 #else
-static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci) { return; }
+static inline void adjust_jiffies(unsigned long val, struct cpufreq_freqs *ci)
+{
+	return;
+}
 #endif
 
 
@@ -316,7 +328,8 @@ static int cpufreq_parse_governor (char 
 		if (!strnicmp(str_governor, "performance", CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_PERFORMANCE;
 			err = 0;
-		} else if (!strnicmp(str_governor, "powersave", CPUFREQ_NAME_LEN)) {
+		} else if (!strnicmp(str_governor, "powersave",
+						CPUFREQ_NAME_LEN)) {
 			*policy = CPUFREQ_POLICY_POWERSAVE;
 			err = 0;
 		}
@@ -328,7 +341,8 @@ static int cpufreq_parse_governor (char 
 		t = __find_governor(str_governor);
 
 		if (t == NULL) {
-			char *name = kasprintf(GFP_KERNEL, "cpufreq_%s", str_governor);
+			char *name = kasprintf(GFP_KERNEL, "cpufreq_%s",
+								str_governor);
 
 			if (name) {
 				int ret;
@@ -361,7 +375,8 @@ extern struct sysdev_class cpu_sysdev_cl
 
 
 /**
- * cpufreq_per_cpu_attr_read() / show_##file_name() - print out cpufreq information
+ * cpufreq_per_cpu_attr_read() / show_##file_name() -
+ * print out cpufreq information
  *
  * Write out information from cpufreq_driver->policy[cpu]; object must be
  * "unsigned int".
@@ -380,7 +395,8 @@ show_one(scaling_min_freq, min);
 show_one(scaling_max_freq, max);
 show_one(scaling_cur_freq, cur);
 
-static int __cpufreq_set_policy(struct cpufreq_policy *data, struct cpufreq_policy *policy);
+static int __cpufreq_set_policy(struct cpufreq_policy *data,
+				struct cpufreq_policy *policy);
 
 /**
  * cpufreq_per_cpu_attr_write() / store_##file_name() - sysfs write access
@@ -416,7 +432,8 @@ store_one(scaling_max_freq,max);
 /**
  * show_cpuinfo_cur_freq - current CPU frequency as detected by hardware
  */
-static ssize_t show_cpuinfo_cur_freq (struct cpufreq_policy * policy, char *buf)
+static ssize_t show_cpuinfo_cur_freq (struct cpufreq_policy * policy,
+							char *buf)
 {
 	unsigned int cur_freq = cpufreq_get(policy->cpu);
 	if (!cur_freq)
@@ -428,7 +445,8 @@ static ssize_t show_cpuinfo_cur_freq (st
 /**
  * show_scaling_governor - show the current policy for the specified CPU
  */
-static ssize_t show_scaling_governor (struct cpufreq_policy * policy, char *buf)
+static ssize_t show_scaling_governor (struct cpufreq_policy * policy,
+							char *buf)
 {
 	if(policy->policy == CPUFREQ_POLICY_POWERSAVE)
 		return sprintf(buf, "powersave\n");
@@ -458,7 +476,8 @@ static ssize_t store_scaling_governor (s
 	if (ret != 1)
 		return -EINVAL;
 
-	if (cpufreq_parse_governor(str_governor, &new_policy.policy, &new_policy.governor))
+	if (cpufreq_parse_governor(str_governor, &new_policy.policy,
+						&new_policy.governor))
 		return -EINVAL;
 
 	lock_cpu_hotplug();
@@ -474,7 +493,10 @@ static ssize_t store_scaling_governor (s
 
 	unlock_cpu_hotplug();
 
-	return ret ? ret : count;
+	if (ret)
+		return ret;
+	else
+		return count;
 }
 
 /**
@@ -488,7 +510,7 @@ static ssize_t show_scaling_driver (stru
 /**
  * show_scaling_available_governors - show the available CPUfreq governors
  */
-static ssize_t show_scaling_available_governors (struct cpufreq_policy * policy,
+static ssize_t show_scaling_available_governors (struct cpufreq_policy *policy,
 				char *buf)
 {
 	ssize_t i = 0;
@@ -574,7 +596,11 @@ static ssize_t show(struct kobject * kob
 	policy = cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
-	ret = fattr->show ? fattr->show(policy,buf) : -EIO;
+	if (fattr->show)
+		ret = fattr->show(policy, buf);
+	else
+		ret = -EIO;
+
 	cpufreq_cpu_put(policy);
 	return ret;
 }
@@ -588,7 +614,11 @@ static ssize_t store(struct kobject * ko
 	policy = cpufreq_cpu_get(policy->cpu);
 	if (!policy)
 		return -EINVAL;
-	ret = fattr->store ? fattr->store(policy,buf,count) : -EIO;
+	if (fattr->store)
+		ret = fattr->store(policy, buf, count);
+	else
+		ret = -EIO;
+
 	cpufreq_cpu_put(policy);
 	return ret;
 }
@@ -911,7 +941,8 @@ static void handle_update(void *data)
  *	We adjust to current frequency first, and need to clean up later. So either call
  *	to cpufreq_update_policy() or schedule handle_update()).
  */
-static void cpufreq_out_of_sync(unsigned int cpu, unsigned int old_freq, unsigned int new_freq)
+static void cpufreq_out_of_sync(unsigned int cpu, unsigned int old_freq,
+				unsigned int new_freq)
 {
 	struct cpufreq_freqs freqs;
 
@@ -936,16 +967,16 @@ static void cpufreq_out_of_sync(unsigned
 unsigned int cpufreq_quick_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	unsigned int ret = 0;
+	unsigned int ret_freq = 0;
 
 	if (policy) {
 		mutex_lock(&policy->lock);
-		ret = policy->cur;
+		ret_freq = policy->cur;
 		mutex_unlock(&policy->lock);
 		cpufreq_cpu_put(policy);
 	}
 
-	return (ret);
+	return (ret_freq);
 }
 EXPORT_SYMBOL(cpufreq_quick_get);
 
@@ -959,7 +990,7 @@ EXPORT_SYMBOL(cpufreq_quick_get);
 unsigned int cpufreq_get(unsigned int cpu)
 {
 	struct cpufreq_policy *policy = cpufreq_cpu_get(cpu);
-	unsigned int ret = 0;
+	unsigned int ret_freq = 0;
 
 	if (!policy)
 		return 0;
@@ -969,12 +1000,14 @@ unsigned int cpufreq_get(unsigned int cp
 
 	mutex_lock(&policy->lock);
 
-	ret = cpufreq_driver->get(cpu);
+	ret_freq = cpufreq_driver->get(cpu);
 
-	if (ret && policy->cur && !(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
-		/* verify no discrepancy between actual and saved value exists */
-		if (unlikely(ret != policy->cur)) {
-			cpufreq_out_of_sync(cpu, policy->cur, ret);
+	if (ret_freq && policy->cur &&
+		!(cpufreq_driver->flags & CPUFREQ_CONST_LOOPS)) {
+		/* verify no discrepancy between actual and
+					saved value exists */
+		if (unlikely(ret_freq != policy->cur)) {
+			cpufreq_out_of_sync(cpu, policy->cur, ret_freq);
 			schedule_work(&policy->update);
 		}
 	}
@@ -984,7 +1017,7 @@ unsigned int cpufreq_get(unsigned int cp
 out:
 	cpufreq_cpu_put(policy);
 
-	return (ret);
+	return (ret_freq);
 }
 EXPORT_SYMBOL(cpufreq_get);
 
@@ -996,7 +1029,7 @@ EXPORT_SYMBOL(cpufreq_get);
 static int cpufreq_suspend(struct sys_device * sysdev, pm_message_t pmsg)
 {
 	int cpu = sysdev->id;
-	unsigned int ret = 0;
+	int ret = 0;
 	unsigned int cur_freq = 0;
 	struct cpufreq_policy *cpu_policy;
 
@@ -1078,7 +1111,7 @@ out:
 static int cpufreq_resume(struct sys_device * sysdev)
 {
 	int cpu = sysdev->id;
-	unsigned int ret = 0;
+	int ret = 0;
 	struct cpufreq_policy *cpu_policy;
 
 	dprintk("resuming cpu %u\n", cpu);
@@ -1299,17 +1332,20 @@ EXPORT_SYMBOL_GPL(cpufreq_driver_getavg)
  * when "event" is CPUFREQ_GOV_LIMITS
  */
 
-static int __cpufreq_governor(struct cpufreq_policy *policy, unsigned int event)
+static int __cpufreq_governor(struct cpufreq_policy *policy,
+					unsigned int event)
 {
 	int ret;
 
 	if (!try_module_get(policy->governor->owner))
 		return -EINVAL;
 
-	dprintk("__cpufreq_governor for CPU %u, event %u\n", policy->cpu, event);
+	dprintk("__cpufreq_governor for CPU %u, event %u\n",
+						policy->cpu, event);
 	ret = policy->governor->governor(policy, event);
 
-	/* we keep one module reference alive for each CPU governed by this CPU */
+	/* we keep one module reference alive for
+			each CPU governed by this CPU */
 	if ((event != CPUFREQ_GOV_START) || ret)
 		module_put(policy->governor->owner);
 	if ((event == CPUFREQ_GOV_STOP) && !ret)
@@ -1385,9 +1421,12 @@ EXPORT_SYMBOL(cpufreq_get_policy);
 
 
 /*
+ * data   : current policy.
+ * policy : policy to be set.
  * Locking: Must be called with the lock_cpu_hotplug() lock held
  */
-static int __cpufreq_set_policy(struct cpufreq_policy *data, struct cpufreq_policy *policy)
+static int __cpufreq_set_policy(struct cpufreq_policy *data,
+				struct cpufreq_policy *policy)
 {
 	int ret = 0;
 
@@ -1395,7 +1434,8 @@ static int __cpufreq_set_policy(struct c
 	dprintk("setting new policy for CPU %u: %u - %u kHz\n", policy->cpu,
 		policy->min, policy->max);
 
-	memcpy(&policy->cpuinfo, &data->cpuinfo, sizeof(struct cpufreq_cpuinfo));
+	memcpy(&policy->cpuinfo, &data->cpuinfo,
+				sizeof(struct cpufreq_cpuinfo));
 
 	if (policy->min > data->min && policy->min > policy->max) {
 		ret = -EINVAL;
@@ -1428,7 +1468,8 @@ static int __cpufreq_set_policy(struct c
 	data->min = policy->min;
 	data->max = policy->max;
 
-	dprintk("new min and max freqs are %u - %u kHz\n", data->min, data->max);
+	dprintk("new min and max freqs are %u - %u kHz\n",
+					data->min, data->max);
 
 	if (cpufreq_driver->setpolicy) {
 		data->policy = policy->policy;
@@ -1449,10 +1490,12 @@ static int __cpufreq_set_policy(struct c
 			data->governor = policy->governor;
 			if (__cpufreq_governor(data, CPUFREQ_GOV_START)) {
 				/* new governor failed, so re-start old one */
-				dprintk("starting governor %s failed\n", data->governor->name);
+				dprintk("starting governor %s failed\n",
+							data->governor->name);
 				if (old_gov) {
 					data->governor = old_gov;
-					__cpufreq_governor(data, CPUFREQ_GOV_START);
+					__cpufreq_governor(data,
+							   CPUFREQ_GOV_START);
 				}
 				ret = -EINVAL;
 				goto error_out;
@@ -1542,7 +1585,8 @@ int cpufreq_update_policy(unsigned int c
 			data->cur = policy.cur;
 		} else {
 			if (data->cur != policy.cur)
-				cpufreq_out_of_sync(cpu, data->cur, policy.cur);
+				cpufreq_out_of_sync(cpu, data->cur,
+								policy.cur);
 		}
 	}
 
@@ -1646,8 +1690,10 @@ int cpufreq_register_driver(struct cpufr
 
 		/* if all ->init() calls failed, unregister */
 		if (ret) {
-			dprintk("no CPU initialized for driver %s\n", driver_data->name);
-			sysdev_driver_unregister(&cpu_sysdev_class, &cpufreq_sysdev_driver);
+			dprintk("no CPU initialized for driver %s\n",
+							driver_data->name);
+			sysdev_driver_unregister(&cpu_sysdev_class,
+						&cpufreq_sysdev_driver);
 
 			spin_lock_irqsave(&cpufreq_driver_lock, flags);
 			cpufreq_driver = NULL;
Index: hotplug/drivers/cpufreq/cpufreq_performance.c
===================================================================
--- hotplug.orig/drivers/cpufreq/cpufreq_performance.c
+++ hotplug/drivers/cpufreq/cpufreq_performance.c
@@ -15,7 +15,8 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 
-#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_GOVERNOR, "performance", msg)
+#define dprintk(msg...) \
+	cpufreq_debug_printk(CPUFREQ_DEBUG_GOVERNOR, "performance", msg)
 
 
 static int cpufreq_governor_performance(struct cpufreq_policy *policy,
@@ -24,8 +25,10 @@ static int cpufreq_governor_performance(
 	switch (event) {
 	case CPUFREQ_GOV_START:
 	case CPUFREQ_GOV_LIMITS:
-		dprintk("setting to %u kHz because of event %u\n", policy->max, event);
-		__cpufreq_driver_target(policy, policy->max, CPUFREQ_RELATION_H);
+		dprintk("setting to %u kHz because of event %u\n",
+						policy->max, event);
+		__cpufreq_driver_target(policy, policy->max,
+						CPUFREQ_RELATION_H);
 		break;
 	default:
 		break;
Index: hotplug/drivers/cpufreq/cpufreq_powersave.c
===================================================================
--- hotplug.orig/drivers/cpufreq/cpufreq_powersave.c
+++ hotplug/drivers/cpufreq/cpufreq_powersave.c
@@ -15,7 +15,8 @@
 #include <linux/cpufreq.h>
 #include <linux/init.h>
 
-#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_GOVERNOR, "powersave", msg)
+#define dprintk(msg...) \
+	cpufreq_debug_printk(CPUFREQ_DEBUG_GOVERNOR, "powersave", msg)
 
 static int cpufreq_governor_powersave(struct cpufreq_policy *policy,
 					unsigned int event)
@@ -23,8 +24,10 @@ static int cpufreq_governor_powersave(st
 	switch (event) {
 	case CPUFREQ_GOV_START:
 	case CPUFREQ_GOV_LIMITS:
-		dprintk("setting to %u kHz because of event %u\n", policy->min, event);
-		__cpufreq_driver_target(policy, policy->min, CPUFREQ_RELATION_L);
+		dprintk("setting to %u kHz because of event %u\n",
+							policy->min, event);
+		__cpufreq_driver_target(policy, policy->min,
+						CPUFREQ_RELATION_L);
 		break;
 	default:
 		break;
Index: hotplug/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- hotplug.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ hotplug/drivers/cpufreq/cpufreq_ondemand.c
@@ -41,8 +41,10 @@
 static unsigned int def_sampling_rate;
 #define MIN_SAMPLING_RATE_RATIO			(2)
 /* for correct statistics, we need at least 10 ticks between each measure */
-#define MIN_STAT_SAMPLING_RATE			(MIN_SAMPLING_RATE_RATIO * jiffies_to_usecs(10))
-#define MIN_SAMPLING_RATE			(def_sampling_rate / MIN_SAMPLING_RATE_RATIO)
+#define MIN_STAT_SAMPLING_RATE 			\
+			(MIN_SAMPLING_RATE_RATIO * jiffies_to_usecs(10))
+#define MIN_SAMPLING_RATE			\
+			(def_sampling_rate / MIN_SAMPLING_RATE_RATIO)
 #define MAX_SAMPLING_RATE			(500 * def_sampling_rate)
 #define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(1000)
 #define TRANSITION_LATENCY_LIMIT		(10 * 1000)
@@ -202,7 +204,8 @@ static ssize_t store_sampling_rate(struc
 	ret = sscanf(buf, "%u", &input);
 
 	mutex_lock(&dbs_mutex);
-	if (ret != 1 || input > MAX_SAMPLING_RATE || input < MIN_SAMPLING_RATE) {
+	if (ret != 1 || input > MAX_SAMPLING_RATE
+		     || input < MIN_SAMPLING_RATE) {
 		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
 	}
@@ -496,7 +499,8 @@ static int cpufreq_governor_dbs(struct c
 		if (dbs_enable == 1) {
 			kondemand_wq = create_workqueue("kondemand");
 			if (!kondemand_wq) {
-				printk(KERN_ERR "Creation of kondemand failed\n");
+				printk(KERN_ERR
+					 "Creation of kondemand failed\n");
 				dbs_enable--;
 				mutex_unlock(&dbs_mutex);
 				return -ENOSPC;
Index: hotplug/drivers/cpufreq/cpufreq_conservative.c
===================================================================
--- hotplug.orig/drivers/cpufreq/cpufreq_conservative.c
+++ hotplug/drivers/cpufreq/cpufreq_conservative.c
@@ -44,15 +44,17 @@
  * latency of the processor. The governor will work on any processor with 
  * transition latency <= 10mS, using appropriate sampling 
  * rate.
- * For CPUs with transition latency > 10mS (mostly drivers with CPUFREQ_ETERNAL)
- * this governor will not work.
+ * For CPUs with transition latency > 10mS (mostly drivers
+ * with CPUFREQ_ETERNAL), this governor will not work.
  * All times here are in uS.
  */
 static unsigned int 				def_sampling_rate;
 #define MIN_SAMPLING_RATE_RATIO			(2)
 /* for correct statistics, we need at least 10 ticks between each measure */
-#define MIN_STAT_SAMPLING_RATE			(MIN_SAMPLING_RATE_RATIO * jiffies_to_usecs(10))
-#define MIN_SAMPLING_RATE			(def_sampling_rate / MIN_SAMPLING_RATE_RATIO)
+#define MIN_STAT_SAMPLING_RATE			\
+			(MIN_SAMPLING_RATE_RATIO * jiffies_to_usecs(10))
+#define MIN_SAMPLING_RATE			\
+			(def_sampling_rate / MIN_SAMPLING_RATE_RATIO)
 #define MAX_SAMPLING_RATE			(500 * def_sampling_rate)
 #define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(1000)
 #define DEF_SAMPLING_DOWN_FACTOR		(1)
@@ -103,11 +105,16 @@ static struct dbs_tuners dbs_tuners_ins 
 
 static inline unsigned int get_cpu_idle_time(unsigned int cpu)
 {
-	return	kstat_cpu(cpu).cpustat.idle +
+	unsigned int add_nice = 0, ret;
+
+	if (dbs_tuners_ins.ignore_nice)
+		add_nice = kstat_cpu(cpu).cpustat.nice;
+
+	ret = 	kstat_cpu(cpu).cpustat.idle +
 		kstat_cpu(cpu).cpustat.iowait +
-		( dbs_tuners_ins.ignore_nice ?
-		  kstat_cpu(cpu).cpustat.nice :
-		  0);
+		add_nice;
+
+	return ret;
 }
 
 /************************** sysfs interface ************************/
Index: hotplug/drivers/cpufreq/cpufreq_stats.c
===================================================================
--- hotplug.orig/drivers/cpufreq/cpufreq_stats.c
+++ hotplug/drivers/cpufreq/cpufreq_stats.c
@@ -351,8 +351,8 @@ __init cpufreq_stats_init(void)
 
 	register_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
 	for_each_online_cpu(cpu) {
-		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_ONLINE,
-			(void *)(long)cpu);
+		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier,
+				CPU_ONLINE, (void *)(long)cpu);
 	}
 	return 0;
 }
@@ -368,14 +368,15 @@ __exit cpufreq_stats_exit(void)
 	unregister_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
 	lock_cpu_hotplug();
 	for_each_online_cpu(cpu) {
-		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_DEAD,
-			(void *)(long)cpu);
+		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier,
+						CPU_DEAD, (void *)(long)cpu);
 	}
 	unlock_cpu_hotplug();
 }
 
 MODULE_AUTHOR ("Zou Nan hai <nanhai.zou@intel.com>");
-MODULE_DESCRIPTION ("'cpufreq_stats' - A driver to export cpufreq stats through sysfs filesystem");
+MODULE_DESCRIPTION ("'cpufreq_stats' - A driver to export cpufreq stats"
+				"through sysfs filesystem");
 MODULE_LICENSE ("GPL");
 
 module_init(cpufreq_stats_init);
Index: hotplug/drivers/cpufreq/freq_table.c
===================================================================
--- hotplug.orig/drivers/cpufreq/freq_table.c
+++ hotplug/drivers/cpufreq/freq_table.c
@@ -9,7 +9,8 @@
 #include <linux/init.h>
 #include <linux/cpufreq.h>
 
-#define dprintk(msg...) cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, "freq-table", msg)
+#define dprintk(msg...) \
+	cpufreq_debug_printk(CPUFREQ_DEBUG_CORE, "freq-table", msg)
 
 /*********************************************************************
  *                     FREQUENCY TABLE HELPERS                       *
@@ -29,7 +30,8 @@ int cpufreq_frequency_table_cpuinfo(stru
 
 			continue;
 		}
-		dprintk("table entry %u: %u kHz, %u index\n", i, freq, table[i].index);
+		dprintk("table entry %u: %u kHz, %u index\n",
+					i, freq, table[i].index);
 		if (freq < min_freq)
 			min_freq = freq;
 		if (freq > max_freq)
@@ -54,13 +56,14 @@ int cpufreq_frequency_table_verify(struc
 	unsigned int i;
 	unsigned int count = 0;
 
-	dprintk("request for verification of policy (%u - %u kHz) for cpu %u\n", policy->min, policy->max, policy->cpu);
+	dprintk("request for verification of policy (%u - %u kHz) for cpu %u\n",
+					policy->min, policy->max, policy->cpu);
 
 	if (!cpu_online(policy->cpu))
 		return -EINVAL;
 
-	cpufreq_verify_within_limits(policy,
-				     policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+				     policy->cpuinfo.max_freq);
 
 	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
 		unsigned int freq = table[i].frequency;
@@ -75,10 +78,11 @@ int cpufreq_frequency_table_verify(struc
 	if (!count)
 		policy->max = next_larger;
 
-	cpufreq_verify_within_limits(policy,
-				     policy->cpuinfo.min_freq, policy->cpuinfo.max_freq);
+	cpufreq_verify_within_limits(policy, policy->cpuinfo.min_freq,
+				     policy->cpuinfo.max_freq);
 
-	dprintk("verification lead to (%u - %u kHz) for cpu %u\n", policy->min, policy->max, policy->cpu);
+	dprintk("verification lead to (%u - %u kHz) for cpu %u\n",
+				policy->min, policy->max, policy->cpu);
 
 	return 0;
 }
@@ -101,7 +105,8 @@ int cpufreq_frequency_table_target(struc
 	};
 	unsigned int i;
 
-	dprintk("request for target %u kHz (relation: %u) for cpu %u\n", target_freq, relation, policy->cpu);
+	dprintk("request for target %u kHz (relation: %u) for cpu %u\n",
+					target_freq, relation, policy->cpu);
 
 	switch (relation) {
 	case CPUFREQ_RELATION_H:
@@ -192,7 +197,10 @@ static ssize_t show_available_freqs (str
 }
 
 struct freq_attr cpufreq_freq_attr_scaling_available_freqs = {
-	.attr = { .name = "scaling_available_frequencies", .mode = 0444, .owner=THIS_MODULE },
+	.attr = { .name = "scaling_available_frequencies",
+		  .mode = 0444,
+		  .owner=THIS_MODULE
+		},
 	.show = show_available_freqs,
 };
 EXPORT_SYMBOL_GPL(cpufreq_freq_attr_scaling_available_freqs);
-- 
Gautham R Shenoy
Linux Technology Center
IBM India.
"Freedom comes with a price tag of responsibility, which is still a bargain,
because Freedom is priceless!"
