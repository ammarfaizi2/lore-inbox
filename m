Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965035AbWJJHB0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965035AbWJJHB0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 03:01:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965052AbWJJHBZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 03:01:25 -0400
Received: from havoc.gtf.org ([69.61.125.42]:10894 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id S965035AbWJJHBZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 03:01:25 -0400
Date: Tue, 10 Oct 2006 03:01:19 -0400
From: Jeff Garzik <jeff@garzik.org>
To: davej@codemonkey.org.uk, Andrew Morton <akpm@osdl.org>,
       LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] cpufreq: handle sysfs errors
Message-ID: <20061010070119.GA21987@havoc.gtf.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Signed-off-by: Jeff Garzik <jeff@garzik.org>

---

Just in case you don't already have such a patch...

 drivers/cpufreq/cpufreq_conservative.c |   10 +++++++++-
 drivers/cpufreq/cpufreq_ondemand.c     |   12 +++++++++++-
 drivers/cpufreq/cpufreq_userspace.c    |   11 +++++++++--
 3 files changed, 29 insertions(+), 4 deletions(-)

c605ed51e9f1164013f0064ba9ff95775d0b1f60
diff --git a/drivers/cpufreq/cpufreq_conservative.c b/drivers/cpufreq/cpufreq_conservative.c
index c4c578d..8fe13ec 100644
--- a/drivers/cpufreq/cpufreq_conservative.c
+++ b/drivers/cpufreq/cpufreq_conservative.c
@@ -453,6 +453,7 @@ static int cpufreq_governor_dbs(struct c
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info_s *this_dbs_info;
 	unsigned int j;
+	int rc;
 
 	this_dbs_info = &per_cpu(cpu_dbs_info, cpu);
 
@@ -469,6 +470,13 @@ static int cpufreq_governor_dbs(struct c
 			break;
 		 
 		mutex_lock(&dbs_mutex);
+
+		rc = sysfs_create_group(&policy->kobj, &dbs_attr_group);
+		if (rc) {
+			mutex_unlock(&dbs_mutex);
+			return rc;
+		}
+
 		for_each_cpu_mask(j, policy->cpus) {
 			struct cpu_dbs_info_s *j_dbs_info;
 			j_dbs_info = &per_cpu(cpu_dbs_info, j);
@@ -481,7 +489,7 @@ static int cpufreq_governor_dbs(struct c
 		this_dbs_info->enable = 1;
 		this_dbs_info->down_skip = 0;
 		this_dbs_info->requested_freq = policy->cur;
-		sysfs_create_group(&policy->kobj, &dbs_attr_group);
+
 		dbs_enable++;
 		/*
 		 * Start the timerschedule work, when this governor
diff --git a/drivers/cpufreq/cpufreq_ondemand.c b/drivers/cpufreq/cpufreq_ondemand.c
index bf8aa45..9acaf9d 100644
--- a/drivers/cpufreq/cpufreq_ondemand.c
+++ b/drivers/cpufreq/cpufreq_ondemand.c
@@ -466,6 +466,7 @@ static int cpufreq_governor_dbs(struct c
 	unsigned int cpu = policy->cpu;
 	struct cpu_dbs_info_s *this_dbs_info;
 	unsigned int j;
+	int rc;
 
 	this_dbs_info = &per_cpu(cpu_dbs_info, cpu);
 
@@ -494,6 +495,16 @@ static int cpufreq_governor_dbs(struct c
 				return -ENOSPC;
 			}
 		}
+
+		rc = sysfs_create_group(&policy->kobj, &dbs_attr_group);
+		if (rc) {
+			if (dbs_enable == 1)
+				destroy_workqueue(kondemand_wq);
+			dbs_enable--;
+			mutex_unlock(&dbs_mutex);
+			return rc;
+		}
+
 		for_each_cpu_mask(j, policy->cpus) {
 			struct cpu_dbs_info_s *j_dbs_info;
 			j_dbs_info = &per_cpu(cpu_dbs_info, j);
@@ -503,7 +514,6 @@ static int cpufreq_governor_dbs(struct c
 			j_dbs_info->prev_cpu_wall = get_jiffies_64();
 		}
 		this_dbs_info->enable = 1;
-		sysfs_create_group(&policy->kobj, &dbs_attr_group);
 		/*
 		 * Start the timerschedule work, when this governor
 		 * is used for first time
diff --git a/drivers/cpufreq/cpufreq_userspace.c b/drivers/cpufreq/cpufreq_userspace.c
index a06c204..2a4eb0b 100644
--- a/drivers/cpufreq/cpufreq_userspace.c
+++ b/drivers/cpufreq/cpufreq_userspace.c
@@ -131,19 +131,26 @@ static int cpufreq_governor_userspace(st
 				   unsigned int event)
 {
 	unsigned int cpu = policy->cpu;
+	int rc = 0;
+
 	switch (event) {
 	case CPUFREQ_GOV_START:
 		if (!cpu_online(cpu))
 			return -EINVAL;
 		BUG_ON(!policy->cur);
 		mutex_lock(&userspace_mutex);
+		rc = sysfs_create_file (&policy->kobj,
+					&freq_attr_scaling_setspeed.attr);
+		if (rc)
+			goto start_out;
+
 		cpu_is_managed[cpu] = 1;
 		cpu_min_freq[cpu] = policy->min;
 		cpu_max_freq[cpu] = policy->max;
 		cpu_cur_freq[cpu] = policy->cur;
 		cpu_set_freq[cpu] = policy->cur;
-		sysfs_create_file (&policy->kobj, &freq_attr_scaling_setspeed.attr);
 		dprintk("managing cpu %u started (%u - %u kHz, currently %u kHz)\n", cpu, cpu_min_freq[cpu], cpu_max_freq[cpu], cpu_cur_freq[cpu]);
+start_out:
 		mutex_unlock(&userspace_mutex);
 		break;
 	case CPUFREQ_GOV_STOP:
@@ -180,7 +187,7 @@ static int cpufreq_governor_userspace(st
 		mutex_unlock(&userspace_mutex);
 		break;
 	}
-	return 0;
+	return rc;
 }
 
 
