Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266408AbSL1XHH>; Sat, 28 Dec 2002 18:07:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266425AbSL1XHH>; Sat, 28 Dec 2002 18:07:07 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:19445 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266408AbSL1XGd>; Sat, 28 Dec 2002 18:06:33 -0500
Date: Sun, 29 Dec 2002 00:14:34 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.53] cpufreq: powernow-k6 cleanup
Message-ID: <20021228231434.GC1310@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up searching for best frequency, and add one safety check.

diff -ru linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-25 17:45:52.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/powernow-k6.c	2002-12-27 11:32:21.000000000 +0100
@@ -144,6 +144,9 @@
 
 	policy->max = clock_ratio[j] * busfreq;
 
+	cpufreq_verify_within_limits(policy, (20 * busfreq),
+				     (max_multiplier * busfreq));
+
 	return 0;
 }
 
@@ -156,53 +159,44 @@
  */
 static int powernow_k6_setpolicy (struct cpufreq_policy *policy)
 {
-	unsigned int    number_states = 0;
-	unsigned int    i, j=4;
+	unsigned int    i;
+	unsigned int    optimal;
 
-	if (!powernow_driver)
+	if (!powernow_driver || !policy || policy->cpu)
 		return -EINVAL;
 
-	for (i=0; i<8; i++)
-		if ((policy->min <= (busfreq * clock_ratio[i])) &&
-		    (policy->max >= (busfreq * clock_ratio[i])))
-		{
-			number_states++;
-			j = i;
-		}
-
-	if (number_states == 1) {
-		/* if only one state is within the limit borders, it
-		   is easily detected and set */
-		powernow_k6_set_state(j);
-		return 0;
-	}
-
-	/* more than one state within limit */
-	switch (policy->policy) {
+	switch(policy->policy) {
 	case CPUFREQ_POLICY_POWERSAVE:
-		j = 6;
-		for (i=0; i<8; i++)
-		if ((policy->min <= (busfreq * clock_ratio[i])) &&
-		    (policy->max >= (busfreq * clock_ratio[i])) &&
-			    (clock_ratio[i] < clock_ratio[j]))
-				j = i;
+		optimal = 6;
 		break;
 	case CPUFREQ_POLICY_PERFORMANCE:
-		j = 4;
-		for (i=0; i<8; i++)
-		if ((policy->min <= (busfreq * clock_ratio[i])) &&
-		    (policy->max >= (busfreq * clock_ratio[i])) &&
-			    (clock_ratio[i] > clock_ratio[j]))
-				j = i;
+		optimal = max_multiplier;
 		break;
 	default:
 		return -EINVAL;
 	}
 
-	if (clock_ratio[i] > max_multiplier)
-		return -EINVAL;
+	for (i=0;i<8;i++) {
+		unsigned int freq = busfreq * clock_ratio[i];
+		if (clock_ratio[i] > max_multiplier)
+			continue;
+		if ((freq > policy->max) ||
+		    (freq < policy->min))
+			continue;
+		switch(policy->policy) {
+		case CPUFREQ_POLICY_POWERSAVE:
+			if (freq < (clock_ratio[optimal] * busfreq))
+				optimal = i;
+			break;
+		case CPUFREQ_POLICY_PERFORMANCE:
+			if (freq > (clock_ratio[optimal] * busfreq))
+				optimal = i;
+			break;
+		}
+	}
+
+	powernow_k6_set_state(optimal);
 
-	powernow_k6_set_state(j);
 	return 0;
 }
 
