Return-Path: <linux-kernel-owner+w=401wt.eu-S1030182AbWL2WEZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030182AbWL2WEZ (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:04:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030189AbWL2WEY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:04:24 -0500
Received: from mga06.intel.com ([134.134.136.21]:30737 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1030182AbWL2WEY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:04:24 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,219,1165219200"; 
   d="scan'208"; a="179801102:sNHT21700819"
Date: Fri, 29 Dec 2006 13:35:43 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Dave Jones <davej@redhat.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Gautham R Shenoy <ego@in.ibm.com>
Subject: [PATCH] ondemand governor use new cpufreq rwsem locking in work callback
Message-ID: <20061229133543.C12358@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Eliminate flush_workqueue in cpufreq_governor(STOP) callpath. Using flush
there has a deadlock potential as in 

http://uwsg.iu.edu/hypermail/linux/kernel/0611.3/1223.html

Also, cleanup the locking issues with do_dbs_timer delayed_work callback.
As it changes the CPU frequency using __cpufreq_target, it needs to have
policy_rwsem in write mode, which also protects it from hot plug.

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.20-rc-mm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-2.6.20-rc-mm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-2.6.20-rc-mm/drivers/cpufreq/cpufreq_ondemand.c
@@ -437,8 +437,14 @@ static void do_dbs_timer(struct work_str
 
 	delay -= jiffies % delay;
 
-	if (!dbs_info->enable)
+	if (lock_policy_rwsem_write(cpu) < 0)
 		return;
+
+	if (!dbs_info->enable) {
+		unlock_policy_rwsem_write(cpu);
+		return;
+	}
+
 	/* Common NORMAL_SAMPLE setup */
 	dbs_info->sample_type = DBS_NORMAL_SAMPLE;
 	if (!dbs_tuners_ins.powersave_bias ||
@@ -455,6 +461,7 @@ static void do_dbs_timer(struct work_str
 	                        	CPUFREQ_RELATION_H);
 	}
 	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
+	unlock_policy_rwsem_write(cpu);
 }
 
 static inline void dbs_timer_init(struct cpu_dbs_info_s *dbs_info)
@@ -463,6 +470,7 @@ static inline void dbs_timer_init(struct
 	int delay = usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
 	delay -= jiffies % delay;
 
+ 	dbs_info->enable = 1;
 	ondemand_powersave_bias_init();
 	dbs_info->sample_type = DBS_NORMAL_SAMPLE;
 	INIT_DELAYED_WORK_NAR(&dbs_info->work, do_dbs_timer);
@@ -474,7 +482,6 @@ static inline void dbs_timer_exit(struct
 {
 	dbs_info->enable = 0;
 	cancel_delayed_work(&dbs_info->work);
-	flush_workqueue(kondemand_wq);
 }
 
 static int cpufreq_governor_dbs(struct cpufreq_policy *policy,
@@ -503,21 +510,9 @@ static int cpufreq_governor_dbs(struct c
 
 		mutex_lock(&dbs_mutex);
 		dbs_enable++;
-		if (dbs_enable == 1) {
-			kondemand_wq = create_workqueue("kondemand");
-			if (!kondemand_wq) {
-				printk(KERN_ERR
-					 "Creation of kondemand failed\n");
-				dbs_enable--;
-				mutex_unlock(&dbs_mutex);
-				return -ENOSPC;
-			}
-		}
 
 		rc = sysfs_create_group(&policy->kobj, &dbs_attr_group);
 		if (rc) {
-			if (dbs_enable == 1)
-				destroy_workqueue(kondemand_wq);
 			dbs_enable--;
 			mutex_unlock(&dbs_mutex);
 			return rc;
@@ -532,7 +527,6 @@ static int cpufreq_governor_dbs(struct c
 			j_dbs_info->prev_cpu_wall = get_jiffies_64();
 		}
 		this_dbs_info->cpu = cpu;
-		this_dbs_info->enable = 1;
 		/*
 		 * Start the timerschedule work, when this governor
 		 * is used for first time
@@ -562,9 +556,6 @@ static int cpufreq_governor_dbs(struct c
 		dbs_timer_exit(this_dbs_info);
 		sysfs_remove_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable--;
-		if (dbs_enable == 0)
-			destroy_workqueue(kondemand_wq);
-
 		mutex_unlock(&dbs_mutex);
 
 		break;
@@ -593,12 +584,18 @@ static struct cpufreq_governor cpufreq_g
 
 static int __init cpufreq_gov_dbs_init(void)
 {
+	kondemand_wq = create_workqueue("kondemand");
+	if (!kondemand_wq) {
+		printk(KERN_ERR "Creation of kondemand failed\n");
+		return -EFAULT;
+	}
 	return cpufreq_register_governor(&cpufreq_gov_dbs);
 }
 
 static void __exit cpufreq_gov_dbs_exit(void)
 {
 	cpufreq_unregister_governor(&cpufreq_gov_dbs);
+	destroy_workqueue(kondemand_wq);
 }
 
 
@@ -610,3 +607,4 @@ MODULE_LICENSE("GPL");
 
 module_init(cpufreq_gov_dbs_init);
 module_exit(cpufreq_gov_dbs_exit);
+
