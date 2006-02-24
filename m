Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932177AbWBXO0R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932177AbWBXO0R (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Feb 2006 09:26:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932183AbWBXO0R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Feb 2006 09:26:17 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:57041 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S932177AbWBXO0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Feb 2006 09:26:16 -0500
Date: Fri, 24 Feb 2006 14:25:40 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, jun.nakajima@intel.com,
       alex-kernel@digriz.org.uk, akpm@osdl.org
Subject: [patch 1/1] cpufreq_conservative: percpu adjustments
Message-ID: <20060224142540.GC32266@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mvpLiMfbWzRoNl4x"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Big changes here.  I was never comfortable with all those for loops,
especially as the iteration is over the same data again and again for each
CPU you had in a single poll, an O(n^2) outcome to frequency scaling.
Correct me if I'm wrong but the way that do_dbs_timer runs this is exactly
what the outcome is?

Anyway, the approach I use is to assume by default no CPU's exist and it sets
the requested_freq to zero as a kind of flag, the reasoning is in the source
;) If the CPU is queried and requested_freq is zero then it initialises the
variable to current_freq and then continues as if nothing happened which
should be the same net effect as before?

I'm guessing this is going to be the controversial patch but if I'm correct
this sort of thing might want to be applied to ondemand too?

All these changes should make cpufreq_conservative safe in regards to the x86 
for_each_cpu cpumask.h changes and whatnot.

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>




--mvpLiMfbWzRoNl4x
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_cpufreq-percpu.diff"

--- linux-2.6.15/drivers/cpufreq/cpufreq_conservative.c.01	2006-02-09 20:40:04.837038750 +0000
+++ linux-2.6.15/drivers/cpufreq/cpufreq_conservative.c	2006-02-24 11:39:34.287974250 +0000
@@ -297,31 +297,40 @@
 static void dbs_check_cpu(int cpu)
 {
 	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
+	unsigned int tmp_idle_ticks, total_idle_ticks;
 	unsigned int freq_step;
 	unsigned int freq_down_sampling_rate;
-	static int down_skip[NR_CPUS];
-	static int requested_freq[NR_CPUS];
-	static unsigned short init_flag = 0;
-	struct cpu_dbs_info_s *this_dbs_info;
-	struct cpu_dbs_info_s *dbs_info;
-
+	static unsigned short down_skip[NR_CPUS];
+	static unsigned int requested_freq[NR_CPUS];
+	static unsigned int init_flag = NR_CPUS;
+	struct cpu_dbs_info_s *this_dbs_info = &per_cpu(cpu_dbs_info, cpu);
 	struct cpufreq_policy *policy;
-	unsigned int j;
 
-	this_dbs_info = &per_cpu(cpu_dbs_info, cpu);
 	if (!this_dbs_info->enable)
 		return;
 
-	policy = this_dbs_info->cur_policy;
-
-	if ( init_flag == 0 ) {
-		for_each_online_cpu(j) {
-			dbs_info = &per_cpu(cpu_dbs_info, j);
-			requested_freq[j] = dbs_info->cur_policy->cur;
+	if ( init_flag != 0 ) {
+		for_each_cpu(init_flag) {
+			down_skip[init_flag] = 0;
+			/* I doubt a CPU exists with a freq of 0hz :) */
+			requested_freq[init_flag] = 0;
 		}
-		init_flag = 1;
+		init_flag = 0;
 	}
 	
+	/*
+	 * If its a freshly initialised cpu we setup requested_freq.  This
+	 * check could be avoided if we did not care about a first time
+	 * stunted increase in CPU speed when there is a load.  I feel we
+	 * should be initialising this to something.  The removal of a CPU
+	 * is not a problem, after a short time the CPU should settle down
+	 * to a 'natural' frequency.
+	 */
+	if (requested_freq[cpu] == 0)
+		requested_freq[cpu] = this_dbs_info->cur_policy->cur;
+
+	policy = this_dbs_info->cur_policy;
+
 	/* 
 	 * The default safe range is 20% to 80% 
 	 * Every sampling_rate, we check
@@ -338,20 +347,15 @@
 
 	/* Check for frequency increase */
 	idle_ticks = UINT_MAX;
-	for_each_cpu_mask(j, policy->cpus) {
-		unsigned int tmp_idle_ticks, total_idle_ticks;
-		struct cpu_dbs_info_s *j_dbs_info;
-
-		j_dbs_info = &per_cpu(cpu_dbs_info, j);
-		/* Check for frequency increase */
-		total_idle_ticks = get_cpu_idle_time(j);
-		tmp_idle_ticks = total_idle_ticks -
-			j_dbs_info->prev_cpu_idle_up;
-		j_dbs_info->prev_cpu_idle_up = total_idle_ticks;
+		
+	/* Check for frequency increase */
+	total_idle_ticks = get_cpu_idle_time(cpu);
+	tmp_idle_ticks = total_idle_ticks -
+		this_dbs_info->prev_cpu_idle_up;
+	this_dbs_info->prev_cpu_idle_up = total_idle_ticks;
 
-		if (tmp_idle_ticks < idle_ticks)
-			idle_ticks = tmp_idle_ticks;
-	}
+	if (tmp_idle_ticks < idle_ticks)
+		idle_ticks = tmp_idle_ticks;
 
 	/* Scale idle ticks by 100 and compare with up and down ticks */
 	idle_ticks *= 100;
@@ -360,13 +364,9 @@
 
 	if (idle_ticks < up_idle_ticks) {
 		down_skip[cpu] = 0;
-		for_each_cpu_mask(j, policy->cpus) {
-			struct cpu_dbs_info_s *j_dbs_info;
-
-			j_dbs_info = &per_cpu(cpu_dbs_info, j);
-			j_dbs_info->prev_cpu_idle_down = 
-					j_dbs_info->prev_cpu_idle_up;
-		}
+		this_dbs_info->prev_cpu_idle_down = 
+			this_dbs_info->prev_cpu_idle_up;
+		
 		/* if we are already at full speed then break out early */
 		if (requested_freq[cpu] == policy->max)
 			return;
@@ -391,21 +391,14 @@
 	if (down_skip[cpu] < dbs_tuners_ins.sampling_down_factor)
 		return;
 
-	idle_ticks = UINT_MAX;
-	for_each_cpu_mask(j, policy->cpus) {
-		unsigned int tmp_idle_ticks, total_idle_ticks;
-		struct cpu_dbs_info_s *j_dbs_info;
-
-		j_dbs_info = &per_cpu(cpu_dbs_info, j);
-		/* Check for frequency decrease */
-		total_idle_ticks = j_dbs_info->prev_cpu_idle_up;
-		tmp_idle_ticks = total_idle_ticks -
-			j_dbs_info->prev_cpu_idle_down;
-		j_dbs_info->prev_cpu_idle_down = total_idle_ticks;
+	/* Check for frequency decrease */
+	total_idle_ticks = this_dbs_info->prev_cpu_idle_up;
+	tmp_idle_ticks = total_idle_ticks -
+		this_dbs_info->prev_cpu_idle_down;
+	this_dbs_info->prev_cpu_idle_down = total_idle_ticks;
 
-		if (tmp_idle_ticks < idle_ticks)
-			idle_ticks = tmp_idle_ticks;
-	}
+	if (tmp_idle_ticks < idle_ticks)
+		idle_ticks = tmp_idle_ticks;
 
 	/* Scale idle ticks by 100 and compare with up and down ticks */
 	idle_ticks *= 100;
@@ -494,7 +487,7 @@
 			j_dbs_info = &per_cpu(cpu_dbs_info, j);
 			j_dbs_info->cur_policy = policy;
 		
-			j_dbs_info->prev_cpu_idle_up = get_cpu_idle_time(j);
+			j_dbs_info->prev_cpu_idle_up = get_cpu_idle_time(cpu);
 			j_dbs_info->prev_cpu_idle_down
 				= j_dbs_info->prev_cpu_idle_up;
 		}

--mvpLiMfbWzRoNl4x--
