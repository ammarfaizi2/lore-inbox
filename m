Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261293AbVCNH6d@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261293AbVCNH6d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Mar 2005 02:58:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261330AbVCNH6d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Mar 2005 02:58:33 -0500
Received: from mf01.sitadelle.com ([212.94.174.80]:52825 "EHLO
	smtp.cegetel.net") by vger.kernel.org with ESMTP id S261293AbVCNH6C
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Mar 2005 02:58:02 -0500
Message-ID: <42354400.7070500@tremplin-utc.net>
Date: Mon, 14 Mar 2005 08:57:52 +0100
From: Eric Piel <Eric.Piel@tremplin-utc.net>
User-Agent: Mozilla Thunderbird 1.0 (X11/20050215)
X-Accept-Language: en, fr, ja, es
MIME-Version: 1.0
To: Jan De Luyck <lkml@kcore.org>
Cc: linux-kernel@vger.kernel.org, cpufreq@zenii.linux.org.uk, davej@redhat.com,
       linux@dominikbrodowski.net
Subject: Re: cpufreq on-demand governor up_treshold?
References: <200503140829.04750.lkml@kcore.org>
In-Reply-To: <200503140829.04750.lkml@kcore.org>
Content-Type: multipart/mixed;
 boundary="------------080008090506010309000209"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------080008090506010309000209
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit

Jan De Luyck a écrit :
> Hello lists,
> 
> (please cc me from cpufreq list)
> 
> I've since yesterday started using the ondemand governor. Seems to work fine, 
> tho I can't seem to find a reason why it keeps scaling my processor speed 
> upwards tho the processor use never exceeds 30% (been watching top -d 1). 
:
:
> Any hints?
You can try the three attached patches in the order :
ondemand-cleanup-factorise-idle-measurement-2.6.11.patch
ondemand-save-idle-up-for-all-cpu-2.6.11.patch
ondemand-automatic-downscaling-2.6.11-accepted.patch

They are available on the cpufreq list but as it's difficult to access 
it I'm sending them again, all together. These are the last things that 
Venki and I have been working on. It should solve your problem 
(actually, only the last patch, but it depends on the two previous 
patches). Please, let me know if it works.

BTW, DaveJ, Dominik, I couldn't find them in the daily-snapshot 
available at codemonkey.org.uk. Should I worry, or is it just due to 
some latency between your private trees and the public one?

Eric

--------------080008090506010309000209
Content-Type: text/x-patch;
 name="ondemand-automatic-downscaling-2.6.11-accepted.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ondemand-automatic-downscaling-2.6.11-accepted.patch"

diff -purN linux-2.6.11/drivers/cpufreq/cpufreq_ondemand.c linux-2.6.11-new/drivers/cpufreq/cpufreq_ondemand.c
--- linux-2.6.11/drivers/cpufreq/cpufreq_ondemand.c	2005-03-07 17:57:31.000000000 -0800
+++ linux-2.6.11-new/drivers/cpufreq/cpufreq_ondemand.c	2005-03-07 17:53:17.000000000 -0800
@@ -34,13 +34,9 @@
  */
 
 #define DEF_FREQUENCY_UP_THRESHOLD		(80)
-#define MIN_FREQUENCY_UP_THRESHOLD		(0)
+#define MIN_FREQUENCY_UP_THRESHOLD		(10)
 #define MAX_FREQUENCY_UP_THRESHOLD		(100)
 
-#define DEF_FREQUENCY_DOWN_THRESHOLD		(20)
-#define MIN_FREQUENCY_DOWN_THRESHOLD		(0)
-#define MAX_FREQUENCY_DOWN_THRESHOLD		(100)
-
 /* 
  * The polling frequency of this governor depends on the capability of 
  * the processor. Default polling frequency is 1000 times the transition
@@ -78,12 +74,10 @@ struct dbs_tuners {
 	unsigned int 		sampling_rate;
 	unsigned int		sampling_down_factor;
 	unsigned int		up_threshold;
-	unsigned int		down_threshold;
 };
 
 static struct dbs_tuners dbs_tuners_ins = {
 	.up_threshold 		= DEF_FREQUENCY_UP_THRESHOLD,
-	.down_threshold 	= DEF_FREQUENCY_DOWN_THRESHOLD,
 	.sampling_down_factor 	= DEF_SAMPLING_DOWN_FACTOR,
 };
 
@@ -115,7 +109,6 @@ static ssize_t show_##file_name						\
 show_one(sampling_rate, sampling_rate);
 show_one(sampling_down_factor, sampling_down_factor);
 show_one(up_threshold, up_threshold);
-show_one(down_threshold, down_threshold);
 
 static ssize_t store_sampling_down_factor(struct cpufreq_policy *unused, 
 		const char *buf, size_t count)
@@ -161,8 +154,7 @@ static ssize_t store_up_threshold(struct
 
 	down(&dbs_sem);
 	if (ret != 1 || input > MAX_FREQUENCY_UP_THRESHOLD || 
-			input < MIN_FREQUENCY_UP_THRESHOLD ||
-			input <= dbs_tuners_ins.down_threshold) {
+			input < MIN_FREQUENCY_UP_THRESHOLD) {
 		up(&dbs_sem);
 		return -EINVAL;
 	}
@@ -173,26 +165,6 @@ static ssize_t store_up_threshold(struct
 	return count;
 }
 
-static ssize_t store_down_threshold(struct cpufreq_policy *unused, 
-		const char *buf, size_t count)
-{
-	unsigned int input;
-	int ret;
-	ret = sscanf (buf, "%u", &input);
-
-	down(&dbs_sem);
-	if (ret != 1 || input > MAX_FREQUENCY_DOWN_THRESHOLD || 
-			input < MIN_FREQUENCY_DOWN_THRESHOLD ||
-			input >= dbs_tuners_ins.up_threshold) {
-		up(&dbs_sem);
-		return -EINVAL;
-	}
-
-	dbs_tuners_ins.down_threshold = input;
-	up(&dbs_sem);
-
-	return count;
-}
 
 #define define_one_rw(_name) \
 static struct freq_attr _name = \
@@ -201,7 +173,6 @@ __ATTR(_name, 0644, show_##_name, store_
 define_one_rw(sampling_rate);
 define_one_rw(sampling_down_factor);
 define_one_rw(up_threshold);
-define_one_rw(down_threshold);
 
 static struct attribute * dbs_attributes[] = {
 	&sampling_rate_max.attr,
@@ -209,7 +180,6 @@ static struct attribute * dbs_attributes
 	&sampling_rate.attr,
 	&sampling_down_factor.attr,
 	&up_threshold.attr,
-	&down_threshold.attr,
 	NULL
 };
 
@@ -222,8 +192,8 @@ static struct attribute_group dbs_attr_g
 
 static void dbs_check_cpu(int cpu)
 {
-	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
-	unsigned int freq_down_step;
+	unsigned int idle_ticks, up_idle_ticks, total_ticks;
+	unsigned int freq_next;
 	unsigned int freq_down_sampling_rate;
 	static int down_skip[NR_CPUS];
 	struct cpu_dbs_info_s *this_dbs_info;
@@ -290,7 +260,12 @@ static void dbs_check_cpu(int cpu)
 	down_skip[cpu]++;
 	if (down_skip[cpu] < dbs_tuners_ins.sampling_down_factor)
 		return;
+	down_skip[cpu] = 0;
 
+	/* don't try to decrease the frequency if it's already the min */
+	if (policy->cur == policy->min)
+		return;
+	
 	idle_ticks = UINT_MAX;
 	for_each_cpu_mask(j, policy->cpus) {
 		unsigned int tmp_idle_ticks, total_idle_ticks;
@@ -308,27 +283,23 @@ static void dbs_check_cpu(int cpu)
 			idle_ticks = tmp_idle_ticks;
 	}
 
-	/* Scale idle ticks by 100 and compare with up and down ticks */
-	idle_ticks *= 100;
-	down_skip[cpu] = 0;
-
+	/* Compute how many ticks there are between two measurements */
 	freq_down_sampling_rate = dbs_tuners_ins.sampling_rate *
 		dbs_tuners_ins.sampling_down_factor;
-	down_idle_ticks = (100 - dbs_tuners_ins.down_threshold) *
-			sampling_rate_in_HZ(freq_down_sampling_rate);
-
-	if (idle_ticks > down_idle_ticks) {
-		freq_down_step = (5 * policy->max) / 100;
-
-		/* max freq cannot be less than 100. But who knows.... */
-		if (unlikely(freq_down_step == 0))
-			freq_down_step = 5;
+	total_ticks = sampling_rate_in_HZ(freq_down_sampling_rate);
+	
+	/* 
+	 * The optimal frequency is the frequency that is the lowest that
+	 * can support the current CPU usage without triggering 
+	 * the up policy. To be safe, we focus 10 points under the threshold.
+	 */
+	freq_next = ((total_ticks - idle_ticks) * 100) / total_ticks;
+	freq_next = freq_next * policy->cur / (dbs_tuners_ins.up_threshold-10);
 
+	if (freq_next <= ((policy->cur * 95) / 100))
 		__cpufreq_driver_target(policy,
-			policy->cur - freq_down_step, 
-			CPUFREQ_RELATION_H);
-		return;
-	}
+			freq_next, 
+			CPUFREQ_RELATION_L);
 }
 
 static void do_dbs_timer(void *data)

--------------080008090506010309000209
Content-Type: text/x-patch;
 name="ondemand-cleanup-factorise-idle-measurement-2.6.11.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ondemand-cleanup-factorise-idle-measurement-2.6.11.patch"

--- linux-2.6.11/drivers/cpufreq/cpufreq_ondemand.c.bak	2005-02-06 23:35:41.000000000 +0100
+++ linux-2.6.11/drivers/cpufreq/cpufreq_ondemand.c	2005-03-06 19:04:12.000000000 +0100
@@ -223,7 +223,6 @@ static struct attribute_group dbs_attr_g
 static void dbs_check_cpu(int cpu)
 {
 	unsigned int idle_ticks, up_idle_ticks, down_idle_ticks;
-	unsigned int total_idle_ticks;
 	unsigned int freq_down_step;
 	unsigned int freq_down_sampling_rate;
 	static int down_skip[NR_CPUS];
@@ -252,20 +251,11 @@ static void dbs_check_cpu(int cpu)
 	 */
 
 	/* Check for frequency increase */
-	total_idle_ticks = kstat_cpu(cpu).cpustat.idle +
-		kstat_cpu(cpu).cpustat.iowait;
-	idle_ticks = total_idle_ticks -
-		this_dbs_info->prev_cpu_idle_up;
-	this_dbs_info->prev_cpu_idle_up = total_idle_ticks;
-	
-
+	idle_ticks = UINT_MAX;
 	for_each_cpu_mask(j, policy->cpus) {
-		unsigned int tmp_idle_ticks;
+		unsigned int tmp_idle_ticks, total_idle_ticks;
 		struct cpu_dbs_info_s *j_dbs_info;
 
-		if (j == cpu)
-			continue;
-
 		j_dbs_info = &per_cpu(cpu_dbs_info, j);
 		/* Check for frequency increase */
 		total_idle_ticks = kstat_cpu(j).cpustat.idle +
@@ -287,7 +277,7 @@ static void dbs_check_cpu(int cpu)
 		__cpufreq_driver_target(policy, policy->max, 
 			CPUFREQ_RELATION_H);
 		down_skip[cpu] = 0;
-		this_dbs_info->prev_cpu_idle_down = total_idle_ticks;
+		this_dbs_info->prev_cpu_idle_down = this_dbs_info->prev_cpu_idle_up;
 		return;
 	}
 
@@ -296,19 +286,11 @@ static void dbs_check_cpu(int cpu)
 	if (down_skip[cpu] < dbs_tuners_ins.sampling_down_factor)
 		return;
 
-	total_idle_ticks = kstat_cpu(cpu).cpustat.idle +
-		kstat_cpu(cpu).cpustat.iowait;
-	idle_ticks = total_idle_ticks -
-		this_dbs_info->prev_cpu_idle_down;
-	this_dbs_info->prev_cpu_idle_down = total_idle_ticks;
-
+	idle_ticks = UINT_MAX;
 	for_each_cpu_mask(j, policy->cpus) {
-		unsigned int tmp_idle_ticks;
+		unsigned int tmp_idle_ticks, total_idle_ticks;
 		struct cpu_dbs_info_s *j_dbs_info;
 
-		if (j == cpu)
-			continue;
-
 		j_dbs_info = &per_cpu(cpu_dbs_info, j);
 		/* Check for frequency increase */
 		total_idle_ticks = kstat_cpu(j).cpustat.idle +
@@ -330,7 +312,7 @@ static void dbs_check_cpu(int cpu)
 	down_idle_ticks = (100 - dbs_tuners_ins.down_threshold) *
 			sampling_rate_in_HZ(freq_down_sampling_rate);
 
-	if (idle_ticks > down_idle_ticks ) {
+	if (idle_ticks > down_idle_ticks) {
 		freq_down_step = (5 * policy->max) / 100;
 
 		/* max freq cannot be less than 100. But who knows.... */

--------------080008090506010309000209
Content-Type: text/x-patch;
 name="ondemand-save-idle-up-for-all-cpu-2.6.11.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ondemand-save-idle-up-for-all-cpu-2.6.11.patch"

--- linux-2.6.11/drivers/cpufreq/cpufreq_ondemand.c.clean2	2005-03-06 19:04:12.000000000 +0100
+++ linux-2.6.11/drivers/cpufreq/cpufreq_ondemand.c	2005-03-06 19:09:52.000000000 +0100
@@ -277,7 +277,12 @@
 		__cpufreq_driver_target(policy, policy->max, 
 			CPUFREQ_RELATION_H);
 		down_skip[cpu] = 0;
-		this_dbs_info->prev_cpu_idle_down = this_dbs_info->prev_cpu_idle_up;
+		for_each_cpu_mask(j, policy->cpus) {
+			struct cpu_dbs_info_s *j_dbs_info;
+
+			j_dbs_info = &per_cpu(cpu_dbs_info, j);
+			j_dbs_info->prev_cpu_idle_down = j_dbs_info->prev_cpu_idle_up;
+		}
 		return;
 	}
 

--------------080008090506010309000209--
