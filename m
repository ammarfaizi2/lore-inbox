Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751007AbWGVTkY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751007AbWGVTkY (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 22 Jul 2006 15:40:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751010AbWGVTkY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 22 Jul 2006 15:40:24 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33195 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751006AbWGVTkY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 22 Jul 2006 15:40:24 -0400
Date: Sat, 22 Jul 2006 15:40:18 -0400
From: Dave Jones <davej@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, Linux Kernel <linux-kernel@vger.kernel.org>
Subject: remove cpu hotplug bustification in cpufreq.
Message-ID: <20060722194018.GA28924@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>,
	Linux Kernel <linux-kernel@vger.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This stuff makes my head hurt. Someone who is motivated
enough to fix up hotplug-cpu can fix this up later.
In the meantime, this patch should cure the lockdep
warnings that seem to trigger very easily.

Signed-off-by: Dave Jones <davej@redhat.com>

--- linux-2.6.17.noarch/drivers/cpufreq/cpufreq_ondemand.c~	2006-07-22 15:35:04.000000000 -0400
+++ linux-2.6.17.noarch/drivers/cpufreq/cpufreq_ondemand.c	2006-07-22 15:35:16.000000000 -0400
@@ -408,7 +408,6 @@ static int cpufreq_governor_dbs(struct c
 		break;
 
 	case CPUFREQ_GOV_LIMITS:
-		lock_cpu_hotplug();
 		mutex_lock(&dbs_mutex);
 		if (policy->max < this_dbs_info->cur_policy->cur)
 			__cpufreq_driver_target(this_dbs_info->cur_policy,
@@ -419,7 +418,6 @@ static int cpufreq_governor_dbs(struct c
 			                        policy->min,
 			                        CPUFREQ_RELATION_L);
 		mutex_unlock(&dbs_mutex);
-		unlock_cpu_hotplug();
 		break;
 	}
 	return 0;
--- linux-2.6.17.noarch/drivers/cpufreq/cpufreq_stats.c~	2006-07-22 15:35:40.000000000 -0400
+++ linux-2.6.17.noarch/drivers/cpufreq/cpufreq_stats.c	2006-07-22 15:35:54.000000000 -0400
@@ -350,12 +350,10 @@ __init cpufreq_stats_init(void)
 	}
 
 	register_hotcpu_notifier(&cpufreq_stat_cpu_notifier);
-	lock_cpu_hotplug();
 	for_each_online_cpu(cpu) {
 		cpufreq_stat_cpu_callback(&cpufreq_stat_cpu_notifier, CPU_ONLINE,
 			(void *)(long)cpu);
 	}
-	unlock_cpu_hotplug();
 	return 0;
 }
 static void
@@ -368,12 +366,10 @@ __exit cpufreq_stats_exit(void)
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
--- linux-2.6.17.noarch/drivers/cpufreq/cpufreq.c~	2006-07-22 15:36:05.000000000 -0400
+++ linux-2.6.17.noarch/drivers/cpufreq/cpufreq.c	2006-07-22 15:36:20.000000000 -0400
@@ -423,8 +423,6 @@ static ssize_t store_scaling_governor (s
 	if (cpufreq_parse_governor(str_governor, &new_policy.policy, &new_policy.governor))
 		return -EINVAL;
 
-	lock_cpu_hotplug();
-
 	/* Do not use cpufreq_set_policy here or the user_policy.max
 	   will be wrongly overridden */
 	mutex_lock(&policy->lock);
@@ -434,8 +432,6 @@ static ssize_t store_scaling_governor (s
 	policy->user_policy.governor = policy->governor;
 	mutex_unlock(&policy->lock);
 
-	unlock_cpu_hotplug();
-
 	return ret ? ret : count;
 }
 
@@ -1203,14 +1199,11 @@ int __cpufreq_driver_target(struct cpufr
 {
 	int retval = -EINVAL;
 
-	lock_cpu_hotplug();
 	dprintk("target for CPU %u: %u kHz, relation %u\n", policy->cpu,
 		target_freq, relation);
 	if (cpu_online(policy->cpu) && cpufreq_driver->target)
 		retval = cpufreq_driver->target(policy, target_freq, relation);
 
-	unlock_cpu_hotplug();
-
 	return retval;
 }
 EXPORT_SYMBOL_GPL(__cpufreq_driver_target);
--- linux-2.6.17.noarch/drivers/cpufreq/cpufreq_conservative.c~	2006-07-22 15:36:46.000000000 -0400
+++ linux-2.6.17.noarch/drivers/cpufreq/cpufreq_conservative.c	2006-07-22 15:36:57.000000000 -0400
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
@@ -525,7 +523,6 @@ static int cpufreq_governor_dbs(struct c
 		break;
 
 	case CPUFREQ_GOV_LIMITS:
-		lock_cpu_hotplug();
 		mutex_lock(&dbs_mutex);
 		if (policy->max < this_dbs_info->cur_policy->cur)
 			__cpufreq_driver_target(
@@ -536,7 +533,6 @@ static int cpufreq_governor_dbs(struct c
 					this_dbs_info->cur_policy,
 				       	policy->min, CPUFREQ_RELATION_L);
 		mutex_unlock(&dbs_mutex);
-		unlock_cpu_hotplug();
 		break;
 	}
 	return 0;

-- 
http://www.codemonkey.org.uk
