Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266638AbTAFNke>; Mon, 6 Jan 2003 08:40:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266640AbTAFNke>; Mon, 6 Jan 2003 08:40:34 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:10371 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266638AbTAFNkb>; Mon, 6 Jan 2003 08:40:31 -0500
Date: Mon, 6 Jan 2003 14:49:35 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.54] cpufreq: p4-clockmod bugfixes
Message-ID: <20030106134935.GA1307@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "get current speed" algorithm wasn't aware of the disable/enable bit,
and the policy verification function wasn't aware of the N44 / O17
bug. Also, some unused code is removed.

 arch/i386/kernel/cpu/cpufreq/p4-clockmod.c |   90 +++++++++++++++--------------
 1 files changed, 49 insertions(+), 41 deletions(-)

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-06 12:55:49.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-06 13:13:19.000000000 +0100
@@ -82,12 +82,17 @@
 
 	/* get current state */
 	rdmsr(MSR_IA32_THERM_CONTROL, l, h);
-	l = l >> 1;
-	l &= 0x7;
-
+	if (l & 0x10) {
+		l = l >> 1;
+		l &= 0x7;
+	} else
+		l = DC_DISABLE;
+	
 	if (l == newstate) {
 		set_cpus_allowed(current, cpus_allowed);
 		return 0;
+	} else if (l == DC_RESV) {
+		printk(KERN_ERR PFX "BIG FAT WARNING: currently in invalid setting\n");
 	}
 
 	/* notifiers */
@@ -141,13 +146,18 @@
 	unsigned int    i;
 	unsigned int    newstate = 0;
 	unsigned int    number_states = 0;
+	unsigned int    minstate = 1;
 
-	if (!cpufreq_p4_driver || !stock_freq || !policy)
+	if (!cpufreq_p4_driver || !stock_freq || 
+	    !policy || !cpu_online(policy->cpu))
 		return -EINVAL;
 
+	if (has_N44_O17_errata)
+		minstate = 3;
+
 	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
 	{
-		for (i=8; i>0; i--)
+		for (i=8; i>=minstate; i--)
 			if ((policy->min <= ((stock_freq / 8) * i)) &&
 			    (policy->max >= ((stock_freq / 8) * i))) 
 			{
@@ -155,7 +165,7 @@
 				number_states++;
 			}
 	} else {
-		for (i=1; i<=8; i++)
+		for (i=minstate; i<=8; i++)
 			if ((policy->min <= ((stock_freq / 8) * i)) &&
 			    (policy->max >= ((stock_freq / 8) * i))) 
 			{
@@ -164,25 +174,8 @@
 			}
 	}
 
-	/* if (number_states == 1) */
-	{
-		if (policy->cpu == CPUFREQ_ALL_CPUS) {
-			for (i=0; i<NR_CPUS; i++)
-				if (cpu_online(i))
-					cpufreq_p4_setdc(i, newstate);
-		} else {
-			cpufreq_p4_setdc(policy->cpu, newstate);
-		}
-	}
-	/* else {
-		if (policy->policy == CPUFREQ_POLICY_POWERSAVE) {
-			min_state = newstate;
-			max_state = newstate + (number_states - 1);
-		} else {
-			max_state = newstate;
-			min_state = newstate - (number_states - 1);
-		}
-	} */
+	cpufreq_p4_setdc(policy->cpu, newstate);
+
 	return 0;
 }
 
@@ -190,17 +183,21 @@
 static int cpufreq_p4_verify(struct cpufreq_policy *policy)
 {
 	unsigned int    number_states = 0;
-	unsigned int    i;
+	unsigned int    i = 1;
 
-	if (!cpufreq_p4_driver || !stock_freq || !policy)
+	if (!cpufreq_p4_driver || !stock_freq || 
+	    !policy || !cpu_online(policy->cpu))
 		return -EINVAL;
 
-	if (!cpu_online(policy->cpu))
-		policy->cpu = CPUFREQ_ALL_CPUS;
-	cpufreq_verify_within_limits(policy, (stock_freq / 8), stock_freq);
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
 
-	/* is there at least one state within limit? */
-	for (i=1; i<=8; i++)
+	if (has_N44_O17_errata)
+		i = 3;
+
+	/* is there at least one state within the limit? */
+	for (; i<=8; i++)
 		if ((policy->min <= ((stock_freq / 8) * i)) &&
 		    (policy->max >= ((stock_freq / 8) * i)))
 			number_states++;
@@ -209,11 +206,14 @@
 		return 0;
 
 	policy->max = (stock_freq / 8) * (((unsigned int) ((policy->max * 8) / stock_freq)) + 1);
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
 	return 0;
 }
 
 
-int __init cpufreq_p4_init(void)
+static int __init cpufreq_p4_init(void)
 {	
 	struct cpuinfo_x86 *c = cpu_data;
 	int cpuid;
@@ -245,6 +245,16 @@
 	}
 
 	printk(KERN_INFO PFX "P4/Xeon(TM) CPU On-Demand Clock Modulation available\n");
+
+	if (!stock_freq) {
+		if (cpu_khz)
+			stock_freq = cpu_khz;
+		else {
+			printk(KERN_INFO PFX "unknown core frequency - please use module parameter 'stock_freq'\n");
+			return -EINVAL;
+		}
+	}
+
 	driver = kmalloc(sizeof(struct cpufreq_driver) +
 			 NR_CPUS * sizeof(struct cpufreq_policy), GFP_KERNEL);
 	if (!driver)
@@ -252,9 +262,6 @@
 
 	driver->policy = (struct cpufreq_policy *) (driver + 1);
 
-	if (!stock_freq)
-		stock_freq = cpu_khz;
-
 #ifdef CONFIG_CPU_FREQ_24_API
 	for (i=0;i<NR_CPUS;i++) {
 		driver->cpu_cur_freq[i] = stock_freq;
@@ -290,15 +297,16 @@
 }
 
 
-void __exit cpufreq_p4_exit(void)
+static void __exit cpufreq_p4_exit(void)
 {
-	u32 l, h;
+	unsigned int i;
 
 	if (cpufreq_p4_driver) {
+		for (i=0; i<NR_CPUS; i++) {
+			if (cpu_online(i)) 
+				cpufreq_p4_setdc(i, DC_DISABLE);
+		}
 		cpufreq_unregister();
-		/* return back to a non modulated state */
-		rdmsr(MSR_IA32_THERM_CONTROL, l, h);
-		wrmsr(MSR_IA32_THERM_CONTROL, l & ~(1<<4), h);
 		kfree(cpufreq_p4_driver);
 	}
 }
