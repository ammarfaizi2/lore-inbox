Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266368AbSL1XDN>; Sat, 28 Dec 2002 18:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266377AbSL1XDN>; Sat, 28 Dec 2002 18:03:13 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:28660 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266368AbSL1XDJ>; Sat, 28 Dec 2002 18:03:09 -0500
Date: Sun, 29 Dec 2002 00:10:59 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.53] cpufreq: deprecated usage of CPUFREQ_ALL_CPUS
Message-ID: <20021228231059.GA1310@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The usage of CPUFREQ_ALL_CPUS is deprecated. Only exception is cpufreq_set,
which needs to iterate over all CPUS now. Also, remove some unneeded code.

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-24 23:19:47.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2002-12-24 23:22:10.000000000 +0100
@@ -124,7 +124,7 @@
 
 	freqs.old = elanfreq_get_cpu_frequency();
 	freqs.new = elan_multiplier[state].clock;
-	freqs.cpu = CPUFREQ_ALL_CPUS; /* elanfreq.c is UP only driver */
+	freqs.cpu = 0; /* elanfreq.c is UP only driver */
 	
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-24 13:37:12.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-24 23:22:10.000000000 +0100
@@ -315,7 +315,7 @@
 
 	freqs.old = longhaul_get_cpu_mult() * longhaul_get_cpu_fsb() * 100;
 	freqs.new = clock_ratio[clock_ratio_index] * newfsb * 100;
-	freqs.cpu = CPUFREQ_ALL_CPUS; /* longhaul.c is UP only driver */
+	freqs.cpu = 0; /* longhaul.c is UP only driver */
 	
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-24 13:37:12.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-24 23:22:10.000000000 +0100
@@ -83,7 +83,7 @@
 
 	freqs.old = busfreq * powernow_k6_get_cpu_multiplier();
 	freqs.new = busfreq * clock_ratio[best_i];
-	freqs.cpu = CPUFREQ_ALL_CPUS; /* powernow-k6.c is UP only driver */
+	freqs.cpu = 0; /* powernow-k6.c is UP only driver */
 	
 	cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
 
diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c linux/arch/i386/kernel/cpu/cpufreq/speedstep.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-12-24 13:37:12.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/speedstep.c	2002-12-24 23:22:10.000000000 +0100
@@ -154,7 +154,7 @@
 
 	freqs.old = (oldstate == SPEEDSTEP_HIGH) ? speedstep_high_freq : speedstep_low_freq;
 	freqs.new = (state == SPEEDSTEP_HIGH) ? speedstep_high_freq : speedstep_low_freq;
-	freqs.cpu = CPUFREQ_ALL_CPUS; /* speedstep.c is UP only driver */
+	freqs.cpu = 0; /* speedstep.c is UP only driver */
 	
 	if (notify)
 		cpufreq_notify_transition(&freqs, CPUFREQ_PRECHANGE);
diff -ruN linux-original/kernel/cpufreq.c linux/kernel/cpufreq.c
--- linux-original/kernel/cpufreq.c	2002-12-24 23:16:19.000000000 +0100
+++ linux/kernel/cpufreq.c	2002-12-24 23:22:01.000000000 +0100
@@ -365,7 +365,7 @@
 {
 	struct cpufreq_policy policy;
 	down(&cpufreq_driver_sem);
-	if (!cpufreq_driver || !cpu_max_freq) {
+	if (!cpufreq_driver || !freq || (cpu > NR_CPUS)) {
 		up(&cpufreq_driver_sem);
 		return -EINVAL;
 	}
@@ -377,7 +377,20 @@
 	
 	up(&cpufreq_driver_sem);
 
-	return cpufreq_set_policy(&policy);
+	if (policy.cpu == CPUFREQ_ALL_CPUS)
+	{
+		unsigned int i;
+		unsigned int ret = 0;
+		for (i=0; i<NR_CPUS; i++) 
+		{
+			policy.cpu = i;
+			if (cpu_online(i))
+				ret |= cpufreq_set_policy(&policy);
+		}
+		return ret;
+	} 
+	else
+		return cpufreq_set_policy(&policy);
 }
 EXPORT_SYMBOL_GPL(cpufreq_set);
 
@@ -842,7 +855,6 @@
  */
 int cpufreq_set_policy(struct cpufreq_policy *policy)
 {
-	unsigned int i;
 	int ret;
 
 	down(&cpufreq_driver_sem);
@@ -889,24 +901,12 @@
 
 	up(&cpufreq_notifier_sem);
 
-	if (policy->cpu == CPUFREQ_ALL_CPUS) {
-		for (i=0;i<NR_CPUS;i++) {
-			cpufreq_driver->policy[i].min    = policy->min;
-			cpufreq_driver->policy[i].max    = policy->max;
-			cpufreq_driver->policy[i].policy = policy->policy;
-		} 
-	} else {
-		cpufreq_driver->policy[policy->cpu].min    = policy->min;
-		cpufreq_driver->policy[policy->cpu].max    = policy->max;
-		cpufreq_driver->policy[policy->cpu].policy = policy->policy;
-	}
+	cpufreq_driver->policy[policy->cpu].min    = policy->min;
+	cpufreq_driver->policy[policy->cpu].max    = policy->max;
+	cpufreq_driver->policy[policy->cpu].policy = policy->policy;
 
 #ifdef CONFIG_CPU_FREQ_24_API
-	if (policy->cpu == CPUFREQ_ALL_CPUS) {
-		for (i=0;i<NR_CPUS;i++)
-			cpu_cur_freq[i] = policy->max;
-	} else
-		cpu_cur_freq[policy->cpu] = policy->max;
+	cpu_cur_freq[policy->cpu] = policy->max;
 #endif
 
 	ret = cpufreq_driver->setpolicy(policy);
@@ -920,15 +920,6 @@
 
 
 /*********************************************************************
- *                    DYNAMIC CPUFREQ SWITCHING                      *
- *********************************************************************/
-#ifdef CONFIG_CPU_FREQ_DYNAMIC
-/* TBD */
-#endif /* CONFIG_CPU_FREQ_DYNAMIC */
-
-
-
-/*********************************************************************
  *            EXTERNALLY AFFECTING FREQUENCY CHANGES                 *
  *********************************************************************/
 
@@ -977,12 +968,7 @@
 		adjust_jiffies(CPUFREQ_POSTCHANGE, freqs);
 		notifier_call_chain(&cpufreq_transition_notifier_list, CPUFREQ_POSTCHANGE, freqs);
 #ifdef CONFIG_CPU_FREQ_24_API
-		if (freqs->cpu == CPUFREQ_ALL_CPUS) {
-			int i;
-			for (i=0;i<NR_CPUS;i++)
-				cpu_cur_freq[i] = freqs->new;
-		} else
-			cpu_cur_freq[freqs->cpu] = freqs->new;
+		cpu_cur_freq[freqs->cpu] = freqs->new;
 #endif
 		break;
 	}
diff -ruN linux-original/include/linux/cpufreq.h linux/include/linux/cpufreq.h
--- linux-original/include/linux/cpufreq.h	2002-12-24 13:38:15.000000000 +0100
+++ linux/include/linux/cpufreq.h	2002-12-24 23:24:03.000000000 +0100
@@ -104,14 +104,6 @@
 
 
 /*********************************************************************
- *                      DYNAMIC CPUFREQ INTERFACE                    *
- *********************************************************************/
-#ifdef CONFIG_CPU_FREQ_DYNAMIC
-/* TBD */
-#endif /* CONFIG_CPU_FREQ_DYNAMIC */
-
-
-/*********************************************************************
  *                      CPUFREQ DRIVER INTERFACE                     *
  *********************************************************************/
 
@@ -122,9 +114,6 @@
 	cpufreq_policy_t        verify;
 	cpufreq_policy_t        setpolicy;
 	struct cpufreq_policy   *policy;
-#ifdef CONFIG_CPU_FREQ_DYNAMIC
-	/* TBD */
-#endif
 	/* 2.4. compatible API */
 #ifdef CONFIG_CPU_FREQ_24_API
 	unsigned int            cpu_cur_freq[NR_CPUS];
