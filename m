Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964881AbWILDb3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964881AbWILDb3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 23:31:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964894AbWILDb3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 23:31:29 -0400
Received: from mta2.srv.hcvlny.cv.net ([167.206.4.197]:53876 "EHLO
	mta2.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S964881AbWILDb2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 23:31:28 -0400
Date: Mon, 11 Sep 2006 23:31:26 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: [PATCH 2.6.18-rc6-mm1 2/2] cpufreq: make it harder for cpu to
 leave "hot" mode
In-reply-to: <20060912032924.GA3677@nickolas.homeunix.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk
Cc: Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>
Mail-followup-to: linux-kernel <linux-kernel@vger.kernel.org>,
 cpufreq@lists.linux.org.uk, Andrew Morton <akpm@osdl.org>,
 Dave Jones <davej@codemonkey.org.uk>
Message-id: <20060912033126.GC3677@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060912032924.GA3677@nickolas.homeunix.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Nick Orlov <bugfixer@list.ru>

Increase sampling period if cpu is running in "hot" mode.
Expose corresponding knob through sysfs.

Signed-off-by: Nick Orlov <bugfixer@list.ru>

--- linux-2.6.18-rc6/drivers/cpufreq/cpufreq_ondemand.c	2006-09-11 21:22:50.000000000 -0400
+++ linux-2.6.18-rc6-mm1-5.swp/drivers/cpufreq/cpufreq_ondemand.c	2006-09-11 20:49:10.000000000 -0400
@@ -39,6 +39,7 @@
  * All times here are in uS.
  */
 static unsigned int def_sampling_rate;
+static unsigned int def_sampling_rate_hot;
 #define MIN_SAMPLING_RATE_RATIO			(2)
 /* for correct statistics, we need at least 10 ticks between each measure */
 #define MIN_STAT_SAMPLING_RATE			(MIN_SAMPLING_RATE_RATIO * jiffies_to_usecs(10))
@@ -46,6 +47,7 @@
 #define MAX_SAMPLING_RATE			(500 * def_sampling_rate)
 #define DEF_SAMPLING_RATE_LATENCY_MULTIPLIER	(1000)
 #define TRANSITION_LATENCY_LIMIT		(10 * 1000)
+#define DEF_SAMPLING_RATE_HOT_MULTIPLIER	(10)
 
 static void do_dbs_timer(void *data);
 
@@ -74,6 +76,7 @@
 
 struct dbs_tuners {
 	unsigned int sampling_rate;
+	unsigned int sampling_rate_hot;
 	unsigned int up_threshold;
 	unsigned int ignore_nice;
 };
@@ -122,6 +125,7 @@
 	return sprintf(buf, "%u\n", dbs_tuners_ins.object);		\
 }
 show_one(sampling_rate, sampling_rate);
+show_one(sampling_rate_hot, sampling_rate_hot);
 show_one(up_threshold, up_threshold);
 show_one(ignore_nice_load, ignore_nice);
 
@@ -144,6 +148,25 @@
 	return count;
 }
 
+static ssize_t store_sampling_rate_hot(struct cpufreq_policy *unused,
+		const char *buf, size_t count)
+{
+	unsigned int input;
+	int ret;
+	ret = sscanf(buf, "%u", &input);
+
+	mutex_lock(&dbs_mutex);
+	if (ret != 1 || input > MAX_SAMPLING_RATE || input < MIN_SAMPLING_RATE) {
+		mutex_unlock(&dbs_mutex);
+		return -EINVAL;
+	}
+
+	dbs_tuners_ins.sampling_rate_hot = input;
+	mutex_unlock(&dbs_mutex);
+
+	return count;
+}
+
 static ssize_t store_up_threshold(struct cpufreq_policy *unused,
 		const char *buf, size_t count)
 {
@@ -203,6 +226,7 @@
 __ATTR(_name, 0644, show_##_name, store_##_name)
 
 define_one_rw(sampling_rate);
+define_one_rw(sampling_rate_hot);
 define_one_rw(up_threshold);
 define_one_rw(ignore_nice_load);
 
@@ -210,6 +234,7 @@
 	&sampling_rate_max.attr,
 	&sampling_rate_min.attr,
 	&sampling_rate.attr,
+	&sampling_rate_hot.attr,
 	&up_threshold.attr,
 	&ignore_nice_load.attr,
 	NULL
@@ -305,6 +330,8 @@
 {
 	unsigned int cpu = smp_processor_id();
 	struct cpu_dbs_info_s *dbs_info = &per_cpu(cpu_dbs_info, cpu);
+	struct cpufreq_policy *policy;
+	unsigned int sampling_rate;
 
 	if (!dbs_info->enable)
 		return;
@@ -312,8 +339,14 @@
 	lock_cpu_hotplug();
 	dbs_check_cpu(dbs_info);
 	unlock_cpu_hotplug();
+
+	policy = dbs_info->cur_policy;
+	sampling_rate = (policy->cur == policy->max)
+			? dbs_tuners_ins.sampling_rate_hot
+			: dbs_tuners_ins.sampling_rate;
+
 	queue_delayed_work_on(cpu, kondemand_wq, &dbs_info->work,
-			usecs_to_jiffies(dbs_tuners_ins.sampling_rate));
+			usecs_to_jiffies(sampling_rate));
 }
 
 static inline void dbs_timer_init(unsigned int cpu)
@@ -394,7 +427,14 @@
 			if (def_sampling_rate < MIN_STAT_SAMPLING_RATE)
 				def_sampling_rate = MIN_STAT_SAMPLING_RATE;
 
+			def_sampling_rate_hot = def_sampling_rate *
+					DEF_SAMPLING_RATE_HOT_MULTIPLIER;
+
+			WARN_ON(def_sampling_rate_hot > MAX_SAMPLING_RATE);
+
 			dbs_tuners_ins.sampling_rate = def_sampling_rate;
+			dbs_tuners_ins.sampling_rate_hot =
+						def_sampling_rate_hot;
 		}
 		dbs_timer_init(policy->cpu);
 
_
-- 
With best wishes,
	Nick Orlov.

