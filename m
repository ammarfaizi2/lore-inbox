Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751151AbWCVJFS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751151AbWCVJFS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:05:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751143AbWCVJEf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:04:35 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:26004 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S1751138AbWCVJEd
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:04:33 -0500
Date: Wed, 22 Mar 2006 09:04:05 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, linux@dominikbrodowski.de, akpm@osdl.org
Subject: [patch 4/4] cpufreq_conservative: update and align of codebase
Message-ID: <20060322090405.GD10689@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ZARJHfwaSJQLOEUz"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Venki, author of cpufreq_ondemand, came up with a neater way to remove the 
initialiser code from the main loop of my code and out to the point when the 
governor is actually initialised.

Not only does it look but it also feels cleaner, plus its simpler to 
understand.  It also saves a bunch of pointless conditional statements in the 
main loop.

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>


--ZARJHfwaSJQLOEUz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="04_rewrite-init.diff"

--- linux-2.6.16/drivers/cpufreq/cpufreq_conservative.c.orig	2006-03-21 21:28:53.969311500 +0000
+++ linux-2.6.16/drivers/cpufreq/cpufreq_conservative.c	2006-03-21 21:29:42.344334750 +0000
@@ -65,6 +65,8 @@
 	unsigned int 		prev_cpu_idle_up;
 	unsigned int 		prev_cpu_idle_down;
 	unsigned int 		enable;
+	unsigned int		down_skip;
+	unsigned int		requested_freq;
 };
 static DEFINE_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
 
@@ -297,35 +299,12 @@
 	unsigned int tmp_idle_ticks, total_idle_ticks;
 	unsigned int freq_step;
 	unsigned int freq_down_sampling_rate;
-	static unsigned short down_skip[NR_CPUS];
-	static unsigned int requested_freq[NR_CPUS];
-	static unsigned int init_flag = NR_CPUS;
 	struct cpu_dbs_info_s *this_dbs_info = &per_cpu(cpu_dbs_info, cpu);
 	struct cpufreq_policy *policy;
 
 	if (!this_dbs_info->enable)
 		return;
 
-	if ( init_flag != 0 ) {
-		for_each_cpu(init_flag) {
-			down_skip[init_flag] = 0;
-			/* I doubt a CPU exists with a freq of 0hz :) */
-			requested_freq[init_flag] = 0;
-		}
-		init_flag = 0;
-	}
-	
-	/*
-	 * If its a freshly initialised cpu we setup requested_freq.  This
-	 * check could be avoided if we did not care about a first time
-	 * stunted increase in CPU speed when there is a load.  I feel we
-	 * should be initialising this to something.  The removal of a CPU
-	 * is not a problem, after a short time the CPU should settle down
-	 * to a 'natural' frequency.
-	 */
-	if (requested_freq[cpu] == 0)
-		requested_freq[cpu] = this_dbs_info->cur_policy->cur;
-
 	policy = this_dbs_info->cur_policy;
 
 	/* 
@@ -360,12 +339,12 @@
 			usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
 
 	if (idle_ticks < up_idle_ticks) {
-		down_skip[cpu] = 0;
+		this_dbs_info->down_skip = 0;
 		this_dbs_info->prev_cpu_idle_down = 
 			this_dbs_info->prev_cpu_idle_up;
 		
 		/* if we are already at full speed then break out early */
-		if (requested_freq[cpu] == policy->max)
+		if (this_dbs_info->requested_freq == policy->max)
 			return;
 		
 		freq_step = (dbs_tuners_ins.freq_step * policy->max) / 100;
@@ -374,18 +353,18 @@
 		if (unlikely(freq_step == 0))
 			freq_step = 5;
 		
-		requested_freq[cpu] += freq_step;
-		if (requested_freq[cpu] > policy->max)
-			requested_freq[cpu] = policy->max;
+		this_dbs_info->requested_freq += freq_step;
+		if (this_dbs_info->requested_freq > policy->max)
+			this_dbs_info->requested_freq = policy->max;
 
-		__cpufreq_driver_target(policy, requested_freq[cpu], 
+		__cpufreq_driver_target(policy, this_dbs_info->requested_freq, 
 			CPUFREQ_RELATION_H);
 		return;
 	}
 
 	/* Check for frequency decrease */
-	down_skip[cpu]++;
-	if (down_skip[cpu] < dbs_tuners_ins.sampling_down_factor)
+	this_dbs_info->down_skip++;
+	if (this_dbs_info->down_skip < dbs_tuners_ins.sampling_down_factor)
 		return;
 
 	/* Check for frequency decrease */
@@ -399,7 +378,7 @@
 
 	/* Scale idle ticks by 100 and compare with up and down ticks */
 	idle_ticks *= 100;
-	down_skip[cpu] = 0;
+	this_dbs_info->down_skip = 0;
 
 	freq_down_sampling_rate = dbs_tuners_ins.sampling_rate *
 		dbs_tuners_ins.sampling_down_factor;
@@ -412,7 +391,7 @@
 		 * or if we 'cannot' reduce the speed as the user might want
 		 * freq_step to be zero
 		 */
-		if (requested_freq[cpu] == policy->min
+		if (this_dbs_info->requested_freq == policy->min
 				|| dbs_tuners_ins.freq_step == 0)
 			return;
 
@@ -422,11 +401,11 @@
 		if (unlikely(freq_step == 0))
 			freq_step = 5;
 
-		requested_freq[cpu] -= freq_step;
-		if (requested_freq[cpu] < policy->min)
-			requested_freq[cpu] = policy->min;
+		this_dbs_info->requested_freq -= freq_step;
+		if (this_dbs_info->requested_freq < policy->min)
+			this_dbs_info->requested_freq = policy->min;
 
-		__cpufreq_driver_target(policy, requested_freq[cpu],
+		__cpufreq_driver_target(policy, this_dbs_info->requested_freq,
 				CPUFREQ_RELATION_H);
 		return;
 	}
@@ -489,6 +468,8 @@
 				= j_dbs_info->prev_cpu_idle_up;
 		}
 		this_dbs_info->enable = 1;
+		this_dbs_info->down_skip = 0;
+		this_dbs_info->requested_freq = policy->cur;
 		sysfs_create_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable++;
 		/*

--ZARJHfwaSJQLOEUz--
