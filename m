Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267266AbTABVhj>; Thu, 2 Jan 2003 16:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267284AbTABVgb>; Thu, 2 Jan 2003 16:36:31 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:38042 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267254AbTABVfQ>; Thu, 2 Jan 2003 16:35:16 -0500
Date: Thu, 2 Jan 2003 22:43:33 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.54] cpufreq: p4-clockmod bugfixes
Message-ID: <20030102214333.GD19479@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The "get current state" algorithm wasn't aware of the disable/enable bit,
and the policy verification function wasn't aware of the N44 / O17 bug.
Also, some unused code is removed.

	Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-02 20:56:45.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/p4-clockmod.c	2003-01-02 20:58:34.000000000 +0100
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
+
+	if (has_N44_O17_errata)
+		i = 3;
 
-	/* is there at least one state within limit? */
-	for (i=1; i<=8; i++)
+	/* is there at least one state within the limit? */
+	for (; i<=8; i++)
 		if ((policy->min <= ((stock_freq / 8) * i)) &&
 		    (policy->max >= ((stock_freq / 8) * i)))
 			number_states++;
@@ -209,6 +206,9 @@
 		return 0;
 
 	policy->max = (stock_freq / 8) * (((unsigned int) ((policy->max * 8) / stock_freq)) + 1);
+	cpufreq_verify_within_limits(policy, 
+				     policy->cpuinfo.min_freq, 
+				     policy->cpuinfo.max_freq);
 	return 0;
 }
 
@@ -292,13 +292,14 @@
 
 void __exit cpufreq_p4_exit(void)
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
