Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752254AbWKAW7t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752254AbWKAW7t (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:59:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752538AbWKAW7t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:59:49 -0500
Received: from mx1.redhat.com ([66.187.233.31]:13497 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1752254AbWKAW7s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:59:48 -0500
Date: Wed, 1 Nov 2006 17:59:25 -0500
From: Dave Jones <davej@redhat.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Subject: Remove hotplug cpu crap from cpufreq.
Message-ID: <20061101225925.GA17363@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linux Kernel <linux-kernel@vger.kernel.org>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've had it with this stuff.  For months, we've had various warnings
popping up from this code (which was clearly half-baked at best when it
went in).

Until someone steps up who actually gives a damn about fixing it, can
we just rip this crap out so I stop getting mails from users who couldn't
care less about CPU hotplug anyway?

		Dave

The hotplug CPU locking in cpufreq is hurrendous.
No-one seems to care enough to fix it, so just remove it
so that the 99.9% of the real world users of this code can
use cpufreq without being bothered by warnings.

Signed-off-by: Dave Jones <davej@redhat.com>

diff --git a/drivers/cpufreq/cpufreq.c b/drivers/cpufreq/cpufreq.c
index 86e69b7..ce99804 100644
--- a/drivers/cpufreq/cpufreq.c
+++ b/drivers/cpufreq/cpufreq.c
@@ -400,12 +400,10 @@ (struct cpufreq_policy * policy, const c
 	if (ret != 1)							\
 		return -EINVAL;						\
 									\
-	lock_cpu_hotplug();						\
 	mutex_lock(&policy->lock);					\
 	ret = __cpufreq_set_policy(policy, &new_policy);		\
 	policy->user_policy.object = policy->object;			\
 	mutex_unlock(&policy->lock);					\
-	unlock_cpu_hotplug();						\
 									\
 	return ret ? ret : count;					\
 }
@@ -461,8 +459,6 @@ static ssize_t store_scaling_governor (s
 	if (cpufreq_parse_governor(str_governor, &new_policy.policy, &new_policy.governor))
 		return -EINVAL;
 
-	lock_cpu_hotplug();
-
 	/* Do not use cpufreq_set_policy here or the user_policy.max
 	   will be wrongly overridden */
 	mutex_lock(&policy->lock);
@@ -472,8 +468,6 @@ static ssize_t store_scaling_governor (s
 	policy->user_policy.governor = policy->governor;
 	mutex_unlock(&policy->lock);
 
-	unlock_cpu_hotplug();
-
 	return ret ? ret : count;
 }
 
@@ -1235,7 +1229,6 @@ EXPORT_SYMBOL(cpufreq_unregister_notifie
  *********************************************************************/
 
 
-/* Must be called with lock_cpu_hotplug held */
 int __cpufreq_driver_target(struct cpufreq_policy *policy,
 			    unsigned int target_freq,
 			    unsigned int relation)
@@ -1261,13 +1254,11 @@ int cpufreq_driver_target(struct cpufreq
 	if (!policy)
 		return -EINVAL;
 
-	lock_cpu_hotplug();
 	mutex_lock(&policy->lock);
 
 	ret = __cpufreq_driver_target(policy, target_freq, relation);
 
 	mutex_unlock(&policy->lock);
-	unlock_cpu_hotplug();
 
 	cpufreq_cpu_put(policy);
 	return ret;
@@ -1275,7 +1266,6 @@ int cpufreq_driver_target(struct cpufreq
 EXPORT_SYMBOL_GPL(cpufreq_driver_target);
 
 /*
- * Locking: Must be called with the lock_cpu_hotplug() lock held
  * when "event" is CPUFREQ_GOV_LIMITS
  */
 
@@ -1364,9 +1354,6 @@ int cpufreq_get_policy(struct cpufreq_po
 EXPORT_SYMBOL(cpufreq_get_policy);
 
 
-/*
- * Locking: Must be called with the lock_cpu_hotplug() lock held
- */
 static int __cpufreq_set_policy(struct cpufreq_policy *data, struct cpufreq_policy *policy)
 {
 	int ret = 0;
@@ -1466,8 +1453,6 @@ int cpufreq_set_policy(struct cpufreq_po
 	if (!data)
 		return -EINVAL;
 
-	lock_cpu_hotplug();
-
 	/* lock this CPU */
 	mutex_lock(&data->lock);
 
@@ -1479,7 +1464,6 @@ int cpufreq_set_policy(struct cpufreq_po
 
 	mutex_unlock(&data->lock);
 
-	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 
 	return ret;
@@ -1503,7 +1487,6 @@ int cpufreq_update_policy(unsigned int c
 	if (!data)
 		return -ENODEV;
 
-	lock_cpu_hotplug();
 	mutex_lock(&data->lock);
 
 	dprintk("updating policy for CPU %u\n", cpu);
@@ -1529,7 +1512,6 @@ int cpufreq_update_policy(unsigned int c
 	ret = __cpufreq_set_policy(data, &policy);
 
 	mutex_unlock(&data->lock);
-	unlock_cpu_hotplug();
 	cpufreq_cpu_put(data);
 	return ret;
 }
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index c4c578d..528d16e 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -423,14 +423,12 @@ static void dbs_check_cpu(int cpu)
 static void do_dbs_timer(void *data)
 { 
 	int i;
-	lock_cpu_hotplug();
 	mutex_lock(&dbs_mutex);
 	for_each_online_cpu(i)
 		dbs_check_cpu(i);
 	schedule_delayed_work(&dbs_work, 
 			usecs_to_jiffies(dbs_tuners_ins.sampling_rate));
 	mutex_unlock(&dbs_mutex);
-	unlock_cpu_hotplug();
 } 
 
 static inline void dbs_timer_init(void)
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index bf8aa45..e3bc0b1 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -424,9 +424,7 @@ static void do_dbs_timer(void *data)
 	INIT_WORK(&dbs_info->work, do_dbs_timer, (void *)DBS_NORMAL_SAMPLE);
 	if (!dbs_tuners_ins.powersave_bias ||
 	    (unsigned long) data == DBS_NORMAL_SAMPLE) {
-		lock_cpu_hotplug();
 		dbs_check_cpu(dbs_info);
-		unlock_cpu_hotplug();
 		if (dbs_info->freq_lo) {
 			/* Setup timer for SUB_SAMPLE */
 			INIT_WORK(&dbs_info->work, do_dbs_timer,
diff --git a/drivers/cpufreq/cpufreq_stats.c b/drivers/cpufreq/cpufreq_stats.c
index c2ecc59..9926997 100644
--- a/drivers/cpufreq/cpufreq_stats.c
+++ b/drivers/cpufreq/cpufreq_stats.c
@@ -366,12 +366,10 @@ __exit cpufreq_stats_exit(void)
 	cpufreq_unregister_notifier(&notifier_trans_block,
 			CPUFREQ_TRANSITION_NOTIFIER);
 	unregister_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
-	lock_cpu_hotplug();
 	for_each_online_cpu(cpu) {
 		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_DEAD,
 			(void *)(long)cpu);
 	}
-	unlock_cpu_hotplug();
 }
 
 MODULE_AUTHOR ("Zou Nan hai <nanhai.zou@intel.com>");
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index a06c204..29ada96 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -71,7 +71,6 @@ static int cpufreq_set(unsigned int freq
 
 	dprintk("cpufreq_set for cpu %u, freq %u kHz\n", policy->cpu, freq);
 
-	lock_cpu_hotplug();
 	mutex_lock(&userspace_mutex);
 	if (!cpu_is_managed[policy->cpu])
 		goto err;
@@ -94,7 +93,6 @@ static int cpufreq_set(unsigned int freq
 
  err:
 	mutex_unlock(&userspace_mutex);
-	unlock_cpu_hotplug();
 	return ret;
 }
 
-- 
http://www.codemonkey.org.uk
