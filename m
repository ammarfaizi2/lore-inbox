Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266285AbTAJVhK>; Fri, 10 Jan 2003 16:37:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbTAJVhK>; Fri, 10 Jan 2003 16:37:10 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:58076 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266285AbTAJVgv>; Fri, 10 Jan 2003 16:36:51 -0500
Date: Fri, 10 Jan 2003 22:45:30 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.56] cpufreq: frequency table helpers
Message-ID: <20030110214530.GA1148@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds "frequency table helpers" to kernel/cpufreq.c and
updates some drivers to use them.

Most CPU frequency scaling methods only support a few static
frequencies. In these drivers a lot of duplicated code existed in the
->setpolicy and ->verify calls.

Please note that this in no way changes the behaviour of cpufreq or of
the ->setpolicy or ->verify calls. These "frequency table helpers"
aren't for drivers which either only support policies (longrun) or
really many frequency states (ARM, gx-suspmod).

       Dominik

 arch/i386/kernel/cpu/cpufreq/elanfreq.c    |   83 ++++++-------------
 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |   97 +++++++----------------
 arch/i386/kernel/cpu/cpufreq/powernow-k6.c |  122 ++++++++---------------------
 arch/i386/kernel/cpu/cpufreq/speedstep.c   |   57 +++++--------
 include/linux/cpufreq.h                    |   23 +++++
 kernel/cpufreq.c                           |  117 +++++++++++++++++++++++++++
6 files changed, 257 insertions(+), 242 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-01-10 21:55:28.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-01-10 22:16:10.000000000 +0100
@@ -61,6 +61,18 @@
 	{99000,	0x01,	0x05}
 };
 
+static struct cpufreq_frequency_table elanfreq_table[] = {
+	{0,	1000},
+	{1,	2000},
+	{2,	4000},
+	{3,	8000},
+	{4,	16000},
+	{5,	33000},
+	{6,	66000},
+	{7,	99000},
+	{0,	CPUFREQ_TABLE_END},
+};
+
 
 /**
  *	elanfreq_get_cpu_frequency: determine current cpu speed
@@ -172,63 +184,17 @@
 
 static int elanfreq_verify (struct cpufreq_policy *policy)
 {
-	unsigned int    number_states = 0;
-	unsigned int    i;
-
-	if (!policy || !max_freq)
-		return -EINVAL;
-
-	policy->cpu = 0;
-
-	cpufreq_verify_within_limits(policy, 1000, max_freq);
-
-	for (i=7; i>=0; i--)
-		if ((elan_multiplier[i].clock >= policy->min) &&
-		    (elan_multiplier[i].clock <= policy->max))
-			number_states++;
-
-	if (number_states)
-		return 0;
-
-	for (i=7; i>=0; i--)
-		if (elan_multiplier[i].clock < policy->max)
-			break;
-
-	policy->max = elan_multiplier[i+1].clock;
-
-	cpufreq_verify_within_limits(policy, 1000, max_freq);
-
-	return 0;
+	return cpufreq_frequency_table_verify(policy, &elanfreq_table[0]);
 }
 
 static int elanfreq_setpolicy (struct cpufreq_policy *policy)
 {
-	unsigned int    i;
-	unsigned int    optimal = 8;
-
-	if (!elanfreq_driver)
-		return -EINVAL;
+	unsigned int    newstate = 0;
 
-	for (i=0; i<8; i++) {
-		if ((elan_multiplier[i].clock > policy->max) ||
-		    (elan_multiplier[i].clock < policy->min))
-			continue;
-		switch(policy->policy) {
-		case CPUFREQ_POLICY_POWERSAVE:
-			if (optimal == 8)
-				optimal = i;
-			break;
-		case CPUFREQ_POLICY_PERFORMANCE:
-			optimal = i;
-			break;
-		default:
-			return -EINVAL;
-		}
-	}
-	if ((optimal == 8) || (elan_multiplier[optimal].clock > max_freq))
+	if (cpufreq_frequency_table_setpolicy(policy, &elanfreq_table[0], &newstate))
 		return -EINVAL;
 
-	elanfreq_set_cpu_state(optimal);
+	elanfreq_set_cpu_state(newstate);
 
 	return 0;
 }
@@ -262,7 +228,7 @@
 {	
 	struct cpuinfo_x86 *c = cpu_data;
 	struct cpufreq_driver *driver;
-	int ret;
+	int ret, i;
 
 	/* Test if we have the right hardware */
 	if ((c->x86_vendor != X86_VENDOR_AMD) ||
@@ -282,6 +248,12 @@
 	if (!max_freq)
 		max_freq = elanfreq_get_cpu_frequency();
 
+	/* table init */
+ 	for (i=0; (elanfreq_table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		if (elanfreq_table[i].frequency > max_freq)
+			elanfreq_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+	}
+
 #ifdef CONFIG_CPU_FREQ_24_API
 	driver->cpu_cur_freq[0] = elanfreq_get_cpu_frequency();
 #endif
@@ -290,11 +262,12 @@
 	driver->setpolicy     = &elanfreq_setpolicy;
 
 	driver->policy[0].cpu    = 0;
-	driver->policy[0].min    = 1000;
-	driver->policy[0].max    = max_freq;
+	ret = cpufreq_frequency_table_cpuinfo(&driver->policy[0], &elanfreq_table[0]);
+	if (ret) {
+		kfree(driver);
+		return ret;
+	}
 	driver->policy[0].policy = CPUFREQ_POLICY_PERFORMANCE;
-	driver->policy[0].cpuinfo.max_freq = max_freq;
-	driver->policy[0].cpuinfo.min_freq = 1000;
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	elanfreq_driver = driver;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-10 21:55:28.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-10 22:16:10.000000000 +0100
@@ -141,39 +141,27 @@
 }
 
 
+static struct cpufreq_frequency_table p4clockmod_table[] = {
+	{DC_RESV, CPUFREQ_ENTRY_INVALID},
+	{DC_DFLT, 0},
+	{DC_25PT, 0},
+	{DC_38PT, 0},
+	{DC_50PT, 0},
+	{DC_64PT, 0},
+	{DC_75PT, 0},
+	{DC_88PT, 0},
+	{DC_DISABLE, 0},
+	{DC_RESV, CPUFREQ_TABLE_END},
+};
+
+
 static int cpufreq_p4_setpolicy(struct cpufreq_policy *policy)
 {
-	unsigned int    i;
-	unsigned int    newstate = 0;
-	unsigned int    number_states = 0;
-	unsigned int    minstate = 1;
+	unsigned int    newstate = DC_RESV;
 
-	if (!cpufreq_p4_driver || !stock_freq || 
-	    !policy || !cpu_online(policy->cpu))
+	if (cpufreq_frequency_table_setpolicy(policy, &p4clockmod_table[0], &newstate))
 		return -EINVAL;
 
-	if (has_N44_O17_errata)
-		minstate = 3;
-
-	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
-	{
-		for (i=8; i>=minstate; i--)
-			if ((policy->min <= ((stock_freq / 8) * i)) &&
-			    (policy->max >= ((stock_freq / 8) * i))) 
-			{
-				newstate = i;
-				number_states++;
-			}
-	} else {
-		for (i=minstate; i<=8; i++)
-			if ((policy->min <= ((stock_freq / 8) * i)) &&
-			    (policy->max >= ((stock_freq / 8) * i))) 
-			{
-				newstate = i;
-				number_states++;
-			}
-	}
-
 	cpufreq_p4_setdc(policy->cpu, newstate);
 
 	return 0;
@@ -182,34 +170,7 @@
 
 static int cpufreq_p4_verify(struct cpufreq_policy *policy)
 {
-	unsigned int    number_states = 0;
-	unsigned int    i = 1;
-
-	if (!cpufreq_p4_driver || !stock_freq || 
-	    !policy || !cpu_online(policy->cpu))
-		return -EINVAL;
-
-	cpufreq_verify_within_limits(policy, 
-				     policy->cpuinfo.min_freq, 
-				     policy->cpuinfo.max_freq);
-
-	if (has_N44_O17_errata)
-		i = 3;
-
-	/* is there at least one state within the limit? */
-	for (; i<=8; i++)
-		if ((policy->min <= ((stock_freq / 8) * i)) &&
-		    (policy->max >= ((stock_freq / 8) * i)))
-			number_states++;
-
-	if (number_states)
-		return 0;
-
-	policy->max = (stock_freq / 8) * (((unsigned int) ((policy->max * 8) / stock_freq)) + 1);
-	cpufreq_verify_within_limits(policy, 
-				     policy->cpuinfo.min_freq, 
-				     policy->cpuinfo.max_freq);
-	return 0;
+	return cpufreq_frequency_table_verify(policy, &p4clockmod_table[0]);
 }
 
 
@@ -262,6 +223,15 @@
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
+	/* table init */
+	for (i=1; (p4clockmod_table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		if ((i<2) && (has_N44_O17_errata))
+			p4clockmod_table[i].frequency = CPUFREQ_ENTRY_INVALID;
+		else
+			p4clockmod_table[i].frequency = (stock_freq * i)/8;
+	}
+	
+
 #ifdef CONFIG_CPU_FREQ_24_API
 	for (i=0;i<NR_CPUS;i++) {
 		driver->cpu_cur_freq[i] = stock_freq;
@@ -272,17 +242,14 @@
 	driver->setpolicy     = &cpufreq_p4_setpolicy;
 
 	for (i=0;i<NR_CPUS;i++) {
-		if (has_N44_O17_errata)
-			driver->policy[i].min    = (stock_freq * 3) / 8;
-		else
-			driver->policy[i].min    = stock_freq / 8;
-		driver->policy[i].max    = stock_freq;
+		driver->policy[i].cpu    = i;
+		ret = cpufreq_frequency_table_cpuinfo(&driver->policy[i], &p4clockmod_table[0]);
+		if (ret) {
+			kfree(driver);
+			return ret;
+		}
 		driver->policy[i].policy = CPUFREQ_POLICY_PERFORMANCE;
-		driver->policy[i].cpuinfo.min_freq  = driver->policy[i].min;
-		driver->policy[i].cpuinfo.max_freq  = stock_freq;
 		driver->policy[i].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
-
-		driver->policy[i].cpu    = i;
 	}
 
 	cpufreq_p4_driver = driver;
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-01-10 21:55:28.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2003-01-10 22:16:10.000000000 +0100
@@ -31,15 +31,16 @@
 
 
 /* Clock ratio multiplied by 10 - see table 27 in AMD#23446 */
-static int clock_ratio[8] = {
-	45,  /* 000 -> 4.5x */
-	50,  /* 001 -> 5.0x */
-	40,  /* 010 -> 4.0x */
-	55,  /* 011 -> 5.5x */
-	20,  /* 100 -> 2.0x */
-	30,  /* 101 -> 3.0x */
-	60,  /* 110 -> 6.0x */
-	35   /* 111 -> 3.5x */
+static struct cpufreq_frequency_table clock_ratio[] = {
+	{45,  /* 000 -> 4.5x */ 0},
+	{50,  /* 001 -> 5.0x */ 0},
+	{40,  /* 010 -> 4.0x */ 0},
+	{55,  /* 011 -> 5.5x */ 0},
+	{20,  /* 100 -> 2.0x */ 0},
+	{30,  /* 101 -> 3.0x */ 0},
+	{60,  /* 110 -> 6.0x */ 0},
+	{35,  /* 111 -> 3.5x */ 0},
+	{0, CPUFREQ_TABLE_END}
 };
 
 
@@ -60,7 +61,7 @@
 	msrval = POWERNOW_IOPORT + 0x0;
 	wrmsr(MSR_K6_EPMR, msrval, 0); /* disable it again */
 
-	return clock_ratio[(invalue >> 5)&7];
+	return clock_ratio[(invalue >> 5)&7].index;
 }
 
 
@@ -82,7 +83,7 @@
 	}
 
 	freqs.old = busfreq * powernow_k6_get_cpu_multiplier();
-	freqs.new = busfreq * clock_ratio[best_i];
+	freqs.new = busfreq * clock_ratio[best_i].index;
 	freqs.cpu = 0; /* powernow-k6.c is UP only driver */
 	
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
@@ -115,39 +116,7 @@
  */
 static int powernow_k6_verify(struct cpufreq_policy *policy)
 {
-	unsigned int    number_states = 0;
-	unsigned int    i, j;
-
-	if (!policy || !busfreq)
-		return -EINVAL;
-
-	policy->cpu = 0;
-	cpufreq_verify_within_limits(policy, (20 * busfreq),
-				     (max_multiplier * busfreq));
-
-	for (i=0; i<8; i++)
-		if ((policy->min <= (busfreq * clock_ratio[i])) &&
-		    (policy->max >= (busfreq * clock_ratio[i])))
-			number_states++;
-
-	if (number_states)
-		return 0;
-
-	/* no state is available within range -- find next larger state */
-
-	j = 6;
-
-	for (i=0; i<8; i++)
-		if (((clock_ratio[i] * busfreq) >= policy->min) &&
-		    (clock_ratio[i] < clock_ratio[j]))
-			j = i;
-
-	policy->max = clock_ratio[j] * busfreq;
-
-	cpufreq_verify_within_limits(policy, (20 * busfreq),
-				     (max_multiplier * busfreq));
-
-	return 0;
+	return cpufreq_frequency_table_verify(policy, &clock_ratio[0]);
 }
 
 
@@ -159,43 +128,12 @@
  */
 static int powernow_k6_setpolicy (struct cpufreq_policy *policy)
 {
-	unsigned int    i;
-	unsigned int    optimal;
+	unsigned int    newstate = 0;
 
-	if (!powernow_driver || !policy || policy->cpu)
+	if (cpufreq_frequency_table_setpolicy(policy, &clock_ratio[0], &newstate))
 		return -EINVAL;
 
-	switch(policy->policy) {
-	case CPUFREQ_POLICY_POWERSAVE:
-		optimal = 6;
-		break;
-	case CPUFREQ_POLICY_PERFORMANCE:
-		optimal = max_multiplier;
-		break;
-	default:
-		return -EINVAL;
-	}
-
-	for (i=0;i<8;i++) {
-		unsigned int freq = busfreq * clock_ratio[i];
-		if (clock_ratio[i] > max_multiplier)
-			continue;
-		if ((freq > policy->max) ||
-		    (freq < policy->min))
-			continue;
-		switch(policy->policy) {
-		case CPUFREQ_POLICY_POWERSAVE:
-			if (freq < (clock_ratio[optimal] * busfreq))
-				optimal = i;
-			break;
-		case CPUFREQ_POLICY_PERFORMANCE:
-			if (freq > (clock_ratio[optimal] * busfreq))
-				optimal = i;
-			break;
-		}
-	}
-
-	powernow_k6_set_state(optimal);
+	powernow_k6_set_state(newstate);
 
 	return 0;
 }
@@ -213,6 +151,7 @@
 	struct cpuinfo_x86      *c = cpu_data;
 	struct cpufreq_driver   *driver;
 	unsigned int            result;
+	unsigned int            i;
 
 	if ((c->x86_vendor != X86_VENDOR_AMD) || (c->x86 != 5) ||
 		((c->x86_model != 12) && (c->x86_model != 13)))
@@ -235,20 +174,29 @@
 	}
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
-#ifdef CONFIG_CPU_FREQ_24_API
-	driver->cpu_cur_freq[0]  = busfreq * max_multiplier;
-#endif
+	/* table init */
+ 	for (i=0; (clock_ratio[i].frequency != CPUFREQ_TABLE_END); i++) {
+		if (clock_ratio[i].index > max_multiplier)
+			clock_ratio[i].frequency = CPUFREQ_ENTRY_INVALID;
+		else
+			clock_ratio[i].frequency = busfreq * clock_ratio[i].index;
+	}
 
 	driver->verify        = &powernow_k6_verify;
 	driver->setpolicy     = &powernow_k6_setpolicy;
 
+	/* cpuinfo and default policy values */
 	driver->policy[0].cpu    = 0;
-	driver->policy[0].min    = busfreq * 20;
-	driver->policy[0].max    = busfreq * max_multiplier;
-	driver->policy[0].policy = CPUFREQ_POLICY_PERFORMANCE;
-	driver->policy[0].cpuinfo.max_freq = busfreq * max_multiplier;
-	driver->policy[0].cpuinfo.min_freq = busfreq * 20;
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
+	driver->policy[0].policy = CPUFREQ_POLICY_PERFORMANCE;
+#ifdef CONFIG_CPU_FREQ_24_API
+	driver->cpu_cur_freq[0]  = busfreq * max_multiplier;
+#endif
+	result = cpufreq_frequency_table_cpuinfo(&driver->policy[0], &clock_ratio[0]);
+	if (result) {
+		kfree(driver);
+		return result;
+	}
 
 	powernow_driver = driver;
 
@@ -274,7 +222,7 @@
 
 	if (powernow_driver) {
 		for (i=0;i<8;i++)
-			if (clock_ratio[i] == max_multiplier)
+			if (clock_ratio[i].index == max_multiplier)
 				powernow_k6_set_state(i);		
 		cpufreq_unregister();
 		kfree(powernow_driver);
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-10 22:15:01.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2003-01-10 22:16:10.000000000 +0100
@@ -58,12 +58,18 @@
  *   There are only two frequency states for each processor. Values
  * are in kHz for the time being.
  */
-static unsigned int                     speedstep_low_freq;
-static unsigned int                     speedstep_high_freq;
-
 #define SPEEDSTEP_HIGH                  0x00000000
 #define SPEEDSTEP_LOW                   0x00000001
 
+static struct cpufreq_frequency_table speedstep_freqs[] = {
+	{SPEEDSTEP_HIGH, 	0},
+	{SPEEDSTEP_LOW,		0},
+	{0,			CPUFREQ_TABLE_END},
+};
+
+#define speedstep_low_freq	speedstep_freqs[SPEEDSTEP_LOW].frequency
+#define speedstep_high_freq	speedstep_freqs[SPEEDSTEP_HIGH].frequency
+
 
 /* DEBUG
  *   Define it if you want verbose debug output, e.g. for bug reporting
@@ -569,22 +575,13 @@
  */
 static int speedstep_setpolicy (struct cpufreq_policy *policy)
 {
-	if (!speedstep_driver || !policy)
+	unsigned int    newstate = 0;
+
+	if (cpufreq_frequency_table_setpolicy(policy, &speedstep_freqs[0], &newstate))
 		return -EINVAL;
 
-	if (policy->min > speedstep_low_freq) 
-		speedstep_set_state(SPEEDSTEP_HIGH, 1);
-	else {
-		if (policy->max < speedstep_high_freq)
-			speedstep_set_state(SPEEDSTEP_LOW, 1);
-		else {
-			/* both frequency states are allowed */
-			if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
-				speedstep_set_state(SPEEDSTEP_LOW, 1);
-			else
-				speedstep_set_state(SPEEDSTEP_HIGH, 1);
-		}
-	}
+	speedstep_set_state(newstate, 1);
+
 	return 0;
 }
 
@@ -598,19 +595,7 @@
  */
 static int speedstep_verify (struct cpufreq_policy *policy)
 {
-	if (!policy || !speedstep_driver || 
-	    !speedstep_low_freq || !speedstep_high_freq)
-		return -EINVAL;
-
-	policy->cpu = 0; /* UP only */
-
-	cpufreq_verify_within_limits(policy, speedstep_low_freq, speedstep_high_freq);
-
-	if ((policy->min > speedstep_low_freq) && 
-	    (policy->max < speedstep_high_freq))
-		policy->max = speedstep_high_freq;
-	
-	return 0;
+	return cpufreq_frequency_table_verify(policy, &speedstep_freqs[0]);
 }
 
 
@@ -692,6 +677,13 @@
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
+	driver->policy[0].cpu    = 0;
+	result = cpufreq_frequency_table_cpuinfo(&driver->policy[0], &speedstep_freqs[0]);
+	if (result) {
+		kfree(driver);
+		return result;
+	}
+
 #ifdef CONFIG_CPU_FREQ_24_API
 	driver->cpu_cur_freq[0] = speed;
 #endif
@@ -699,11 +691,6 @@
 	driver->verify      = &speedstep_verify;
 	driver->setpolicy   = &speedstep_setpolicy;
 
-	driver->policy[0].cpu    = 0;
-	driver->policy[0].min    = speedstep_low_freq;
-	driver->policy[0].max    = speedstep_high_freq;
-	driver->policy[0].cpuinfo.min_freq = speedstep_low_freq;
-	driver->policy[0].cpuinfo.max_freq = speedstep_high_freq;
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	driver->policy[0].policy = (speed == speedstep_low_freq) ? 
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2003-01-10 21:56:23.000000000 +0100
+++ linux/include/linux/cpufreq.h	2003-01-10 22:16:10.000000000 +0100
@@ -241,4 +241,27 @@
 
 #endif /* CONFIG_CPU_FREQ_24_API */
 
+/*********************************************************************
+ *                     FREQUENCY TABLE HELPERS                       *
+ *********************************************************************/
+
+#define CPUFREQ_ENTRY_INVALID ~0
+#define CPUFREQ_TABLE_END     ~1
+
+struct cpufreq_frequency_table {
+	unsigned int	index;     /* any */
+	unsigned int	frequency; /* kHz - doesn't need to be in ascending
+				    * order */
+};
+
+int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
+				    struct cpufreq_frequency_table *table);
+
+int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
+				   struct cpufreq_frequency_table *table);
+
+int cpufreq_frequency_table_setpolicy(struct cpufreq_policy *policy,
+				      struct cpufreq_frequency_table *table,
+				      unsigned int *index);
+
 #endif /* _LINUX_CPUFREQ_H */
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2003-01-10 22:13:42.000000000 +0100
+++ linux/kernel/cpufreq.c	2003-01-10 22:16:10.000000000 +0100
@@ -1134,3 +1134,120 @@
 #define cpufreq_restore() do {} while (0)
 #endif /* CONFIG_PM */
 
+
+/*********************************************************************
+ *                     FREQUENCY TABLE HELPERS                       *
+ *********************************************************************/
+
+int cpufreq_frequency_table_cpuinfo(struct cpufreq_policy *policy,
+				    struct cpufreq_frequency_table *table)
+{
+	unsigned int min_freq = ~0;
+	unsigned int max_freq = 0;
+	unsigned int i = 0;
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		unsigned int freq = table[i].frequency;
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if (freq < min_freq)
+			min_freq = freq;
+		if (freq > max_freq)
+			max_freq = freq;
+	}
+
+	policy->min = policy->cpuinfo.min_freq = min_freq;
+	policy->max = policy->cpuinfo.max_freq = max_freq;
+
+	if (policy->min == ~0)
+		return -EINVAL;
+	else
+		return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_cpuinfo);
+
+
+int cpufreq_frequency_table_verify(struct cpufreq_policy *policy,
+				   struct cpufreq_frequency_table *table)
+{
+	unsigned int next_larger = ~0;
+	unsigned int i = 0;
+	unsigned int count = 0;
+
+	if (!cpu_online(policy->cpu))
+		return -EINVAL;
+
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		unsigned int freq = table[i].frequency;
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if ((freq >= policy->min) && (freq <= policy->max))
+			count++;
+		else if ((next_larger > freq) && (freq > policy->max))
+			next_larger = freq;
+	}
+
+	if (!count)
+		policy->max = next_larger;
+
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_verify);
+
+
+int cpufreq_frequency_table_setpolicy(struct cpufreq_policy *policy,
+				      struct cpufreq_frequency_table *table,
+				      unsigned int *index)
+{
+	struct cpufreq_frequency_table optimal = { .index = ~0, };
+	unsigned int i;
+
+	switch (policy->policy) {
+	case CPUFREQ_POLICY_PERFORMANCE:
+		optimal.frequency = 0;
+		break;
+	case CPUFREQ_POLICY_POWERSAVE:
+		optimal.frequency = ~0;
+		break;
+	}
+
+	if (!cpu_online(policy->cpu))
+		return -EINVAL;
+
+	for (i=0; (table[i].frequency != CPUFREQ_TABLE_END); i++) {
+		unsigned int freq = table[i].frequency;
+		if (freq == CPUFREQ_ENTRY_INVALID)
+			continue;
+		if ((freq < policy->min) || (freq > policy->max))
+			continue;
+		switch(policy->policy) {
+		case CPUFREQ_POLICY_PERFORMANCE:
+			if (optimal.frequency <= freq) {
+				optimal.frequency = freq;
+				optimal.index = i;
+			}
+			break;
+		case CPUFREQ_POLICY_POWERSAVE:
+			if (optimal.frequency >= freq) {
+				optimal.frequency = freq;
+				optimal.index = i;
+			}
+			break;
+		}
+	}
+	if (optimal.index > i)
+		return -EINVAL;
+
+	*index = optimal.index;
+	
+	return 0;
+}
+EXPORT_SYMBOL_GPL(cpufreq_frequency_table_setpolicy);
