Return-Path: <linux-kernel-owner+w=401wt.eu-S1030181AbWL2WDd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030181AbWL2WDd (ORCPT <rfc822;w@1wt.eu>);
	Fri, 29 Dec 2006 17:03:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965221AbWL2WDd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Dec 2006 17:03:33 -0500
Received: from mga06.intel.com ([134.134.136.21]:42352 "EHLO
	orsmga101.jf.intel.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965220AbWL2WDc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Dec 2006 17:03:32 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.12,219,1165219200"; 
   d="scan'208"; a="179800928:sNHT21311850"
Date: Fri, 29 Dec 2006 13:34:50 -0800
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Dave Jones <davej@redhat.com>,
       Dominik Brodowski <linux@dominikbrodowski.net>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Gautham R Shenoy <ego@in.ibm.com>
Subject: [PATCH] ondemand governor restructure the work callback
Message-ID: <20061229133450.B12358@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Restructure the delayed_work callback in ondemand.

This eliminates the need for smp_processor_id in the callback function and also
helps in proper locking and avoiding flush_workqueue when stopping the governor
(done in subsequent patch).

Signed-off-by: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>

Index: linux-2.6.20-rc-mm/drivers/cpufreq/cpufreq_ondemand.c
===================================================================
--- linux-2.6.20-rc-mm.orig/drivers/cpufreq/cpufreq_ondemand.c
+++ linux-2.6.20-rc-mm/drivers/cpufreq/cpufreq_ondemand.c
@@ -52,19 +52,20 @@ static unsigned int def_sampling_rate;
 static void do_dbs_timer(struct work_struct *work);
 
 /* Sampling types */
-enum dbs_sample {DBS_NORMAL_SAMPLE, DBS_SUB_SAMPLE};
+enum {DBS_NORMAL_SAMPLE, DBS_SUB_SAMPLE};
 
 struct cpu_dbs_info_s {
 	cputime64_t prev_cpu_idle;
 	cputime64_t prev_cpu_wall;
 	struct cpufreq_policy *cur_policy;
  	struct delayed_work work;
-	enum dbs_sample sample_type;
-	unsigned int enable;
 	struct cpufreq_frequency_table *freq_table;
 	unsigned int freq_lo;
 	unsigned int freq_lo_jiffies;
 	unsigned int freq_hi_jiffies;
+	int cpu;
+	unsigned int enable:1,
+	             sample_type:1;
 };
 static DEFINE_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
 
@@ -402,7 +403,7 @@ static void dbs_check_cpu(struct cpu_dbs
 	if (load < (dbs_tuners_ins.up_threshold - 10)) {
 		unsigned int freq_next, freq_cur;
 
-		freq_cur = cpufreq_driver_getavg(policy);
+		freq_cur = __cpufreq_driver_getavg(policy);
 		if (!freq_cur)
 			freq_cur = policy->cur;
 
@@ -423,9 +424,11 @@ static void dbs_check_cpu(struct cpu_dbs
 
 static void do_dbs_timer(struct work_struct *work)
 {
-	unsigned int cpu = smp_processor_id();
-	struct cpu_dbs_info_s *dbs_info = &per_cpu(cpu_dbs_info, cpu);
-	enum dbs_sample sample_type = dbs_info->sample_type;
+	struct cpu_dbs_info_s *dbs_info =
+		container_of(work, struct cpu_dbs_info_s, work.work);
+	unsigned int cpu = dbs_info->cpu;
+	int sample_type = dbs_info->sample_type;
+
 	/* We want all CPUs to do sampling nearly on same jiffy */
 	int delay = usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
 
@@ -454,17 +457,17 @@ static void do_dbs_timer(struct work_str
 	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
 }
 
-static inline void dbs_timer_init(unsigned int cpu)
+static inline void dbs_timer_init(struct cpu_dbs_info_s *dbs_info)
 {
-	struct cpu_dbs_info_s *dbs_info = &per_cpu(cpu_dbs_info, cpu);
 	/* We want all CPUs to do sampling nearly on same jiffy */
 	int delay = usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
 	delay -= jiffies % delay;
 
 	ondemand_powersave_bias_init();
-	INIT_DELAYED_WORK_NAR(&dbs_info->work, do_dbs_timer);
 	dbs_info->sample_type = DBS_NORMAL_SAMPLE;
-	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work, delay);
+	INIT_DELAYED_WORK_NAR(&dbs_info->work, do_dbs_timer);
+	queue_delayed_work_on(dbs_info->cpu, kondemand_wq, &dbs_info->work,
+	                      delay);
 }
 
 static inline void dbs_timer_exit(struct cpu_dbs_info_s *dbs_info)
@@ -528,6 +531,7 @@ static int cpufreq_governor_dbs(struct c
 			j_dbs_info->prev_cpu_idle = get_cpu_idle_time(j);
 			j_dbs_info->prev_cpu_wall = get_jiffies_64();
 		}
+		this_dbs_info->cpu = cpu;
 		this_dbs_info->enable = 1;
 		/*
 		 * Start the timerschedule work, when this governor
@@ -548,7 +552,7 @@ static int cpufreq_governor_dbs(struct c
 
 			dbs_tuners_ins.sampling_rate = def_sampling_rate;
 		}
-		dbs_timer_init(policy->cpu);
+		dbs_timer_init(this_dbs_info);
 
 		mutex_unlock(&dbs_mutex);
 		break;
