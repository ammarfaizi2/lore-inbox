Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267254AbTABVhk>; Thu, 2 Jan 2003 16:37:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267279AbTABVg5>; Thu, 2 Jan 2003 16:36:57 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:40346 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267280AbTABVfR>; Thu, 2 Jan 2003 16:35:17 -0500
Date: Thu, 2 Jan 2003 22:43:46 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.54] cpufreq: elanfreq cleanup and compile fix
Message-ID: <20030102214346.GE19479@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up searching code for best frequency multiplier, and add a
safety check.

       Dominik

diff -ruN linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-01-02 20:56:45.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/elanfreq.c	2003-01-02 20:59:57.000000000 +0100
@@ -184,7 +184,7 @@
 
 	cpufreq_verify_within_limits(policy, 1000, max_freq);
 
-	for (i=(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); i>=0; i--)
+	for (i=7; i>=0; i--)
 		if ((elan_multiplier[i].clock >= policy->min) &&
 		    (elan_multiplier[i].clock <= policy->max))
 			number_states++;
@@ -192,57 +192,46 @@
 	if (number_states)
 		return 0;
 
-	for (i=(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); i>=0; i--)
+	for (i=7; i>=0; i--)
 		if (elan_multiplier[i].clock < policy->max)
 			break;
 
 	policy->max = elan_multiplier[i+1].clock;
 
+	cpufreq_verify_within_limits(policy, 1000, max_freq);
+
 	return 0;
 }
 
 static int elanfreq_setpolicy (struct cpufreq_policy *policy)
 {
-	unsigned int    number_states = 0;
-	unsigned int    i, j=4;
+	unsigned int    i;
+	unsigned int    optimal = 8;
 
 	if (!elanfreq_driver)
 		return -EINVAL;
 
-	for (i=(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); i>=0; i--)
-		if ((elan_multiplier[i].clock >= policy->min) &&
-		    (elan_multiplier[i].clock <= policy->max))
-		{
-			number_states++;
-			j = i;
+	for (i=0; i<8; i++) {
+		if ((elan_multiplier[i].clock > policy->max) ||
+		    (elan_multiplier[i].clock < policy->min))
+			continue;
+		switch(policy->policy) {
+		case CPUFREQ_POLICY_POWERSAVE:
+			if (optimal == 8)
+				optimal = i;
+			break;
+		case CPUFREQ_POLICY_PERFORMANCE:
+			optimal = i;
+			break;
+		default:
+			return -EINVAL;
 		}
-
-	if (number_states == 1) {
-		elanfreq_set_cpu_state(j);
-		return 0;
 	}
-
-	switch (policy->policy) {
-	case CPUFREQ_POLICY_POWERSAVE:
-		for (i=(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); i>=0; i--)
-			if ((elan_multiplier[i].clock >= policy->min) &&
-			    (elan_multiplier[i].clock <= policy->max))
-				j = i;
-		break;
-	case CPUFREQ_POLICY_PERFORMANCE:
-		for (i=0; i<(sizeof(elan_multiplier)/sizeof(struct s_elan_multiplier) - 1); i++)
-			if ((elan_multiplier[i].clock >= policy->min) &&
-			    (elan_multiplier[i].clock <= policy->max))
-				j = i;
-		break;
-	default:
+	if ((optimal == 8) || (elan_multiplier[optimal].clock > max_freq))
 		return -EINVAL;
-	}
 
-	if (elan_multiplier[j].clock > max_freq)
-		return -EINVAL;
+	elanfreq_set_cpu_state(optimal);
 
-	elanfreq_set_cpu_state(j);
 	return 0;
 }
 
@@ -307,7 +296,7 @@
 	driver->policy[0].max    = max_freq;
 	driver->policy[0].policy = CPUFREQ_POLICY_PERFORMANCE;
 	driver->policy[0].cpuinfo.max_freq = max_freq;
-	driver->policy[0].cpuinfo.min_freq = min_freq;
+	driver->policy[0].cpuinfo.min_freq = 1000;
 	driver->policy[0].cpuinfo.transition_latency = CPUFREQ_ETERNAL;
 
 	elanfreq_driver = driver;
