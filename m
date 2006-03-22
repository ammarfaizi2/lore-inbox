Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751172AbWCVJyN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751172AbWCVJyN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 04:54:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751173AbWCVJyN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 04:54:13 -0500
Received: from mrelay2.soas.ac.uk ([212.219.139.201]:40857 "EHLO
	mrelay2.soas.ac.uk") by vger.kernel.org with ESMTP id S1751172AbWCVJyN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 04:54:13 -0500
Date: Wed, 22 Mar 2006 09:54:10 +0000
From: Alexander Clouter <alex@digriz.org.uk>
To: cpufreq@lists.linux.org.uk, linux-kernel@vger.kernel.org
Cc: venkatesh.pallipadi@intel.com, linux@dominikbrodowski.de, akpm@osdl.org
Subject: [patch 1/4 MKII] cpufreq_conservative: aligning of codebase with ondemand
Message-ID: <20060322095409.GA3378@inskipp.digriz.org.uk>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
Organization: diGriz
X-URL: http://www.digriz.org.uk/
User-Agent: Mutt/1.5.11+cvs20060126
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Since the conservative govenor was released its codebase has drifted from the 
the direction and updates that have been applied to the ondemand govornor.

This patch addresses the lack of updates in that period and brings 
conservative back up to date.  The resulting diff file between 
cpufreq_ondemand.c and cpufreq_conservative.c is now much smaller and shows 
more clearly the differences between the two.

Another reason to do this is ages ago, knowingly, I did a piss poor attempt
at making conservative less responsive by knocking up
DEF_SAMPLING_RATE_LATENCY_MULTIPLIER by two orders of magnitude.  I did fix
this ages ago but in my dis-organisation I must have toasted the diff and
left it the way it was.  About two weeks ago a user contacted me saying he
was having problems with the conservative governor with his AMD Athlon XP-M
2800+ as /sys/devices/system/cpu/cpu0/cpufreq/conservative showed
  sampling_rate_min   9950000
  sampling_rate_max   1360065408

Nine seconds to decide about changing the frequency....not too responsive :)

Signed-off-by: Alexander Clouter <alex-kernel@digriz.org.uk>


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="01_cpufreq-update.diff"

--- linux-2.6.16/drivers/cpufreq/cpufreq_conservative.c.orig	2006-03-21 21:18:51.539662000 +0000
+++ linux-2.6.16/drivers/cpufreq/cpufreq_conservative.c	2006-03-21 21:26:18.631603500 +0000
@@ -35,12 +35,7 @@
  */
 
 #define DEF_FREQUENCY_UP_THRESHOLD		(80)
-#define MIN_FREQUENCY_UP_THRESHOLD		(0)
-#define MAX_FREQUENCY_UP_THRESHOLD		(100)
-
 #define DEF_FREQUENCY_DOWN_THRESHOLD		(20)
-#define MIN_FREQUENCY_DOWN_THRESHOLD		(0)
-#define MAX_FREQUENCY_DOWN_THRESHOLD		(100)
 
 /* 
  * The polling frequency of this governor depends on the capability of 
@@ -53,10 +48,14 @@
  * All times here are in uS.
  */
 static unsigned int 				def_sampling_rate;
-#define MIN_SAMPLING_RATE			(def_sampling_rate / 2)
+#define MIN_SAMPLING_RATE_RATIO			(2)
+/* for correct statistics, we need at least 10 ticks between each measure */
+#define MIN_STAT_SAMPLING_RATE			(MIN_SAMPLING_RATE_RATIO * jiffies_to_usecs(10))
+#define MIN_SAMPLING_RATE			(def_sampling_rate / MIN_SAMPLING_RATE_RATIO)
 #define MAX_SAMPLING_RATE			(500 * def_sampling_rate)
-#define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(100000)
-#define DEF_SAMPLING_DOWN_FACTOR		(5)
+#define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(1000)
+#define DEF_SAMPLING_DOWN_FACTOR		(1)
+#define MAX_SAMPLING_DOWN_FACTOR		(10)
 #define TRANSITION_LATENCY_LIMIT		(10 * 1000)
 
 static void do_dbs_timer(void *data);
@@ -136,7 +135,7 @@
 	unsigned int input;
 	int ret;
 	ret = sscanf (buf, "%u", &input);
-	if (ret != 1 )
+	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
 		return -EINVAL;
 
 	mutex_lock(&dbs_mutex);
@@ -173,8 +172,7 @@
 	ret = sscanf (buf, "%u", &input);
 
 	mutex_lock(&dbs_mutex);
-	if (ret != 1 || input > MAX_FREQUENCY_UP_THRESHOLD || 
-			input < MIN_FREQUENCY_UP_THRESHOLD ||
+	if (ret != 1 || input > 100 || input < 0 ||
 			input <= dbs_tuners_ins.down_threshold) {
 		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
@@ -194,8 +192,7 @@
 	ret = sscanf (buf, "%u", &input);
 
 	mutex_lock(&dbs_mutex);
-	if (ret != 1 || input > MAX_FREQUENCY_DOWN_THRESHOLD || 
-			input < MIN_FREQUENCY_DOWN_THRESHOLD ||
+	if (ret != 1 || input > 100 || input < 0 ||
 			input >= dbs_tuners_ins.up_threshold) {
 		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
@@ -337,7 +334,6 @@
 	 */
 
 	/* Check for frequency increase */
-
 	idle_ticks = UINT_MAX;
 	for_each_cpu_mask(j, policy->cpus) {
 		unsigned int tmp_idle_ticks, total_idle_ticks;
@@ -357,7 +353,7 @@
 	/* Scale idle ticks by 100 and compare with up and down ticks */
 	idle_ticks *= 100;
 	up_idle_ticks = (100 - dbs_tuners_ins.up_threshold) *
-		usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
+			usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
 
 	if (idle_ticks < up_idle_ticks) {
 		down_skip[cpu] = 0;
@@ -398,6 +394,7 @@
 		struct cpu_dbs_info_s *j_dbs_info;
 
 		j_dbs_info = &per_cpu(cpu_dbs_info, j);
+		/* Check for frequency decrease */
 		total_idle_ticks = j_dbs_info->prev_cpu_idle_up;
 		tmp_idle_ticks = total_idle_ticks -
 			j_dbs_info->prev_cpu_idle_down;
@@ -414,12 +411,14 @@
 	freq_down_sampling_rate = dbs_tuners_ins.sampling_rate *
 		dbs_tuners_ins.sampling_down_factor;
 	down_idle_ticks = (100 - dbs_tuners_ins.down_threshold) *
-			usecs_to_jiffies(freq_down_sampling_rate);
+		usecs_to_jiffies(freq_down_sampling_rate);
 
 	if (idle_ticks > down_idle_ticks) {
-		/* if we are already at the lowest speed then break out early
+		/*
+		 * if we are already at the lowest speed then break out early
 		 * or if we 'cannot' reduce the speed as the user might want
-		 * freq_step to be zero */
+		 * freq_step to be zero
+		 */
 		if (requested_freq[cpu] == policy->min
 				|| dbs_tuners_ins.freq_step == 0)
 			return;
@@ -434,9 +433,8 @@
 		if (requested_freq[cpu] < policy->min)
 			requested_freq[cpu] = policy->min;
 
-		__cpufreq_driver_target(policy,
-			requested_freq[cpu],
-			CPUFREQ_RELATION_H);
+		__cpufreq_driver_target(policy, requested_freq[cpu],
+				CPUFREQ_RELATION_H);
 		return;
 	}
 }
@@ -507,13 +505,16 @@
 		if (dbs_enable == 1) {
 			unsigned int latency;
 			/* policy latency is in nS. Convert it to uS first */
+			latency = policy->cpuinfo.transition_latency / 1000;
+			if (latency == 0)
+				latency = 1;
 
-			latency = policy->cpuinfo.transition_latency;
-			if (latency < 1000)
-				latency = 1000;
-
-			def_sampling_rate = (latency / 1000) *
+			def_sampling_rate = latency *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
+
+			if (def_sampling_rate < MIN_STAT_SAMPLING_RATE)
+				def_sampling_rate = MIN_STAT_SAMPLING_RATE;
+
 			dbs_tuners_ins.sampling_rate = def_sampling_rate;
 			dbs_tuners_ins.ignore_nice = 0;
 			dbs_tuners_ins.freq_step = 5;

--WIyZ46R2i8wDzkSu--
