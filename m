Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932092AbWCZRAK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932092AbWCZRAK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 12:00:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932095AbWCZRAK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 12:00:10 -0500
Received: from mail.gmx.de ([213.165.64.20]:55168 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S932092AbWCZRAI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 12:00:08 -0500
X-Authenticated: #14349625
Subject: Re: 2.6.16-mm1 grub oddness
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1143364200.8281.6.camel@homer>
References: <20060323014046.2ca1d9df.akpm@osdl.org>
	 <1143201413.7741.53.camel@homer> <20060324102537.1d426594.akpm@osdl.org>
	 <1143262501.7930.4.camel@homer>  <20060324205310.38ce20bf.akpm@osdl.org>
	 <1143263697.7930.24.camel@homer>  <1143290647.7682.5.camel@homer>
	 <1143364200.8281.6.camel@homer>
Content-Type: text/plain
Date: Sun, 26 Mar 2006 18:01:16 +0200
Message-Id: <1143388876.7589.22.camel@homer>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-03-26 at 11:10 +0200, Mike Galbraith wrote:
> On Sat, 2006-03-25 at 13:44 +0100, Mike Galbraith wrote:
> > On Sat, 2006-03-25 at 06:14 +0100, Mike Galbraith wrote:
> > > On Fri, 2006-03-24 at 20:53 -0800, Andrew Morton wrote:
> > > > 
> > > > Did you try disabling fbdev?
> > > > 
> > > 
> > > No, but I will.
> > 
> > No dice, I just had another dead reboot.  Nobody else seems to be seeing
> > this, so maybe my box is going south.  A single bit error the other day,
> > and now this.  Maybe it's not the kernel, just a coincidence that I've
> > only seen it with 2.6.16-mm1.  Maybe I've got dust crawling into memory
> > sockets or whatnot.  Memtest86 time.
> 
> It's apparently not my hardware btw.  If I find out what it is that's
> causing this, I'll holler.

The tentative winner for my reboot (and boot) problems appears to be
frequency scaling changes between 2.6.16-rc6-mm2, which worked fine,
and 2.6.16-mm1.  Disabling frequency scaling appears to fix my troubles.
Caveat emptor: intermittent.

(Difficult for me to believe that having this compiled in could do a
number on my p4.  Reverting the hotplug thingie gave me suspend back and
nothing more [as expected].  Color me befuddled.)

diff -urN linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c linux-2.6.16-mm1/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
--- linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-03-26 12:13:21.000000000 +0200
+++ linux-2.6.16-mm1/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c	2006-03-23 14:58:44.000000000 +0100
@@ -225,9 +225,11 @@
 	freqs.old = data->freq_table[cur_state].frequency;
 	freqs.new = data->freq_table[next_state].frequency;
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#else
+	online_policy_cpus = policy->cpus;
 #endif
 
 	for_each_cpu_mask(j, online_policy_cpus) {
diff -urN linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/powernow-k8.c linux-2.6.16-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
--- linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2006-03-26 12:13:21.000000000 +0200
+++ linux-2.6.16-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c	2006-03-23 14:58:44.000000000 +0100
@@ -55,7 +55,7 @@
 static struct powernow_k8_data *powernow_data[NR_CPUS];
 
 #ifndef CONFIG_SMP
-static cpumask_t cpu_core_map[1];
+static cpumask_t cpu_core_map[1] = { CPU_MASK_ALL };
 #endif
 
 /* Return a frequency in MHz, given an input fid */
@@ -977,7 +977,7 @@
 {
 	struct powernow_k8_data *data;
 	cpumask_t oldmask = CPU_MASK_ALL;
-	int rc;
+	int rc, i;
 
 	if (!cpu_online(pol->cpu))
 		return -ENODEV;
@@ -1063,7 +1063,8 @@
 	printk("cpu_init done, current fid 0x%x, vid 0x%x\n",
 	       data->currfid, data->currvid);
 
-	powernow_data[pol->cpu] = data;
+	for_each_cpu_mask(i, cpu_core_map[pol->cpu])
+		powernow_data[i] = data;
 
 	return 0;
 
diff -urN linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/powernow-k8.h linux-2.6.16-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.h
--- linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2006-03-26 12:13:21.000000000 +0200
+++ linux-2.6.16-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.h	2006-03-23 14:58:44.000000000 +0100
@@ -182,10 +182,6 @@
 
 static void powernow_k8_acpi_pst_values(struct powernow_k8_data *data, unsigned int index);
 
-#ifndef for_each_cpu_mask
-#define for_each_cpu_mask(i,mask) for (i=0;i<1;i++)
-#endif
-
 #ifdef CONFIG_SMP
 static inline void define_siblings(int cpu, cpumask_t cpu_sharedcore_mask[])
 {
diff -urN linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c linux-2.6.16-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
--- linux-2.6.16-rc6-mm2/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-03-26 12:13:21.000000000 +0200
+++ linux-2.6.16-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c	2006-03-23 14:58:44.000000000 +0100
@@ -652,9 +652,11 @@
 		return -EINVAL;
 	}
 
-#ifdef CONFIG_SMP
+#ifdef CONFIG_HOTPLUG_CPU
 	/* cpufreq holds the hotplug lock, so we are safe from here on */
 	cpus_and(online_policy_cpus, cpu_online_map, policy->cpus);
+#else
+	online_policy_cpus = policy->cpus;
 #endif
 
 	saved_mask = current->cpus_allowed;
diff -urN linux-2.6.16-rc6-mm2/drivers/cpufreq/cpufreq_conservative.c linux-2.6.16-mm1/drivers/cpufreq/cpufreq_conservative.c
--- linux-2.6.16-rc6-mm2/drivers/cpufreq/cpufreq_conservative.c	2006-03-26 12:13:02.000000000 +0200
+++ linux-2.6.16-mm1/drivers/cpufreq/cpufreq_conservative.c	2006-03-23 14:58:45.000000000 +0100
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
@@ -66,6 +65,8 @@
 	unsigned int 		prev_cpu_idle_up;
 	unsigned int 		prev_cpu_idle_down;
 	unsigned int 		enable;
+	unsigned int		down_skip;
+	unsigned int		requested_freq;
 };
 static DEFINE_PER_CPU(struct cpu_dbs_info_s, cpu_dbs_info);
 
@@ -136,7 +137,7 @@
 	unsigned int input;
 	int ret;
 	ret = sscanf (buf, "%u", &input);
-	if (ret != 1 )
+	if (ret != 1 || input > MAX_SAMPLING_DOWN_FACTOR || input < 1)
 		return -EINVAL;
 
 	mutex_lock(&dbs_mutex);
@@ -173,8 +174,7 @@
 	ret = sscanf (buf, "%u", &input);
 
 	mutex_lock(&dbs_mutex);
-	if (ret != 1 || input > MAX_FREQUENCY_UP_THRESHOLD || 
-			input < MIN_FREQUENCY_UP_THRESHOLD ||
+	if (ret != 1 || input > 100 || input < 0 ||
 			input <= dbs_tuners_ins.down_threshold) {
 		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
@@ -194,8 +194,7 @@
 	ret = sscanf (buf, "%u", &input);
 
 	mutex_lock(&dbs_mutex);
-	if (ret != 1 || input > MAX_FREQUENCY_DOWN_THRESHOLD || 
-			input < MIN_FREQUENCY_DOWN_THRESHOLD ||
+	if (ret != 1 || input > 100 || input < 0 ||
 			input >= dbs_tuners_ins.up_threshold) {
 		mutex_unlock(&dbs_mutex);
 		return -EINVAL;
@@ -297,31 +296,17 @@
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
+	struct cpu_dbs_info_s *this_dbs_info = &per_cpu(cpu_dbs_info, cpu);
 	struct cpufreq_policy *policy;
-	unsigned int j;
 
-	this_dbs_info = &per_cpu(cpu_dbs_info, cpu);
 	if (!this_dbs_info->enable)
 		return;
 
 	policy = this_dbs_info->cur_policy;
 
-	if ( init_flag == 0 ) {
-		for_each_online_cpu(j) {
-			dbs_info = &per_cpu(cpu_dbs_info, j);
-			requested_freq[j] = dbs_info->cur_policy->cur;
-		}
-		init_flag = 1;
-	}
-	
 	/* 
 	 * The default safe range is 20% to 80% 
 	 * Every sampling_rate, we check
@@ -337,39 +322,29 @@
 	 */
 
 	/* Check for frequency increase */
-
 	idle_ticks = UINT_MAX;
-	for_each_cpu_mask(j, policy->cpus) {
-		unsigned int tmp_idle_ticks, total_idle_ticks;
-		struct cpu_dbs_info_s *j_dbs_info;
 
-		j_dbs_info = &per_cpu(cpu_dbs_info, j);
-		/* Check for frequency increase */
-		total_idle_ticks = get_cpu_idle_time(j);
-		tmp_idle_ticks = total_idle_ticks -
-			j_dbs_info->prev_cpu_idle_up;
-		j_dbs_info->prev_cpu_idle_up = total_idle_ticks;
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
 	up_idle_ticks = (100 - dbs_tuners_ins.up_threshold) *
-		usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
+			usecs_to_jiffies(dbs_tuners_ins.sampling_rate);
 
 	if (idle_ticks < up_idle_ticks) {
-		down_skip[cpu] = 0;
-		for_each_cpu_mask(j, policy->cpus) {
-			struct cpu_dbs_info_s *j_dbs_info;
+		this_dbs_info->down_skip = 0;
+		this_dbs_info->prev_cpu_idle_down =
+			this_dbs_info->prev_cpu_idle_up;
 
-			j_dbs_info = &per_cpu(cpu_dbs_info, j);
-			j_dbs_info->prev_cpu_idle_down = 
-					j_dbs_info->prev_cpu_idle_up;
-		}
 		/* if we are already at full speed then break out early */
-		if (requested_freq[cpu] == policy->max)
+		if (this_dbs_info->requested_freq == policy->max)
 			return;
 		
 		freq_step = (dbs_tuners_ins.freq_step * policy->max) / 100;
@@ -378,49 +353,45 @@
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
 
-	idle_ticks = UINT_MAX;
-	for_each_cpu_mask(j, policy->cpus) {
-		unsigned int tmp_idle_ticks, total_idle_ticks;
-		struct cpu_dbs_info_s *j_dbs_info;
-
-		j_dbs_info = &per_cpu(cpu_dbs_info, j);
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
-	down_skip[cpu] = 0;
+	this_dbs_info->down_skip = 0;
 
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
-		if (requested_freq[cpu] == policy->min
+		 * freq_step to be zero
+		 */
+		if (this_dbs_info->requested_freq == policy->min
 				|| dbs_tuners_ins.freq_step == 0)
 			return;
 
@@ -430,13 +401,12 @@
 		if (unlikely(freq_step == 0))
 			freq_step = 5;
 
-		requested_freq[cpu] -= freq_step;
-		if (requested_freq[cpu] < policy->min)
-			requested_freq[cpu] = policy->min;
+		this_dbs_info->requested_freq -= freq_step;
+		if (this_dbs_info->requested_freq < policy->min)
+			this_dbs_info->requested_freq = policy->min;
 
-		__cpufreq_driver_target(policy,
-			requested_freq[cpu],
-			CPUFREQ_RELATION_H);
+		__cpufreq_driver_target(policy, this_dbs_info->requested_freq,
+				CPUFREQ_RELATION_H);
 		return;
 	}
 }
@@ -493,11 +463,13 @@
 			j_dbs_info = &per_cpu(cpu_dbs_info, j);
 			j_dbs_info->cur_policy = policy;
 		
-			j_dbs_info->prev_cpu_idle_up = get_cpu_idle_time(j);
+			j_dbs_info->prev_cpu_idle_up = get_cpu_idle_time(cpu);
 			j_dbs_info->prev_cpu_idle_down
 				= j_dbs_info->prev_cpu_idle_up;
 		}
 		this_dbs_info->enable = 1;
+		this_dbs_info->down_skip = 0;
+		this_dbs_info->requested_freq = policy->cur;
 		sysfs_create_group(&policy->kobj, &dbs_attr_group);
 		dbs_enable++;
 		/*
@@ -507,13 +479,16 @@
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
+			def_sampling_rate = 10 * latency *
 					DEF_SAMPLING_RATE_LATENCY_MULTIPLIER;
+
+			if (def_sampling_rate < MIN_STAT_SAMPLING_RATE)
+				def_sampling_rate = MIN_STAT_SAMPLING_RATE;
+
 			dbs_tuners_ins.sampling_rate = def_sampling_rate;
 			dbs_tuners_ins.ignore_nice = 0;
 			dbs_tuners_ins.freq_step = 5;


