Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbSL1XEy>; Sat, 28 Dec 2002 18:04:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266359AbSL1XEy>; Sat, 28 Dec 2002 18:04:54 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:54516 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266347AbSL1XEm>; Sat, 28 Dec 2002 18:04:42 -0500
Date: Sun, 29 Dec 2002 00:12:33 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, davej@suse.de
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5.53] cpufreq: longhaul cleanup
Message-ID: <20021228231233.GB1310@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Clean up searching code for best frequency and add some safety checks.

diff -ru linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c linux/arch/i386/kernel/cpu/cpufreq/longhaul.c
--- linux-original/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-25 17:45:52.000000000 +0100
+++ linux/arch/i386/kernel/cpu/cpufreq/longhaul.c	2002-12-27 10:49:52.000000000 +0100
@@ -313,6 +313,10 @@
 	if ((!can_scale_fsb) && (newfsb != current_fsb))
 		return;
 
+	if (((clock_ratio[clock_ratio_index] * newfsb * 100) > highest_speed) ||
+	    ((clock_ratio[clock_ratio_index] * newfsb * 100) < lowest_speed))
+		return;
+
 	freqs.old = longhaul_get_cpu_mult() * longhaul_get_cpu_fsb() * 100;
 	freqs.new = clock_ratio[clock_ratio_index] * newfsb * 100;
 	freqs.cpu = 0; /* longhaul.c is UP only driver */
@@ -582,18 +586,68 @@
 
 	policy->max = newmax;
 
+	cpufreq_verify_within_limits(policy, lowest_speed, highest_speed);
+
+	return 0;
+}
+
+
+static int longhaul_get_best_freq_for_fsb(struct cpufreq_policy *policy, 
+					  unsigned int min_mult, 
+					  unsigned int max_mult, 
+					  unsigned int fsb, 
+					  unsigned int *new_mult)
+{
+	unsigned int optimal = 0;
+	unsigned int found_optimal = 0;
+	unsigned int i;
+
+	switch(policy->policy) {
+	case CPUFREQ_POLICY_POWERSAVE:
+		optimal = max_mult;
+		break;
+	case CPUFREQ_POLICY_PERFORMANCE:
+		optimal = min_mult;
+	}
+
+	for(i=0; i<numscales; i++) {
+		unsigned int freq = fsb * clock_ratio[i] * 100;
+		if ((freq > policy->max) ||
+		    (freq < policy->min))
+			continue;
+		switch(policy->policy) {
+		case CPUFREQ_POLICY_POWERSAVE:
+			if (clock_ratio[i] < clock_ratio[optimal]) {
+				found_optimal = 1;
+				optimal = i;
+			}
+			break;
+		case CPUFREQ_POLICY_PERFORMANCE:
+			if (clock_ratio[i] > clock_ratio[optimal]) {
+				found_optimal = 1;
+				optimal = i;
+			}
+			break;
+		}
+	}
+		
+	if (found_optimal) {
+		*new_mult = optimal;
+		return 1;
+	}
 	return 0;
 }
 
 
 static int longhaul_setpolicy (struct cpufreq_policy *policy)
 {
-	unsigned int    number_states = 0;
 	unsigned int    i;
 	unsigned int    fsb_index = 0;
 	unsigned int    new_fsb = 0;
 	unsigned int    new_clock_ratio = 0;
-	unsigned int    best_freq = -1;
+	unsigned int    min_mult = 0;
+	unsigned int    max_mult = 0;
+
 
 	if (!longhaul_driver)
 		return -EINVAL;
@@ -603,103 +657,36 @@
 	else
 		fsb_search_table = power_fsb_table;
 
+	for(i=0;i<numscales;i++) {
+		if (clock_ratio[max_mult] < clock_ratio[i])
+				max_mult = i;
+		else if (clock_ratio[min_mult] > clock_ratio[i])
+				min_mult = i;
+	}
+
 	if (can_scale_fsb==1) {
-		for (fsb_index=0; fsb_search_table[fsb_index]!=-1; fsb_index++) 
+		unsigned int found = 0;
+		for (fsb_index=0; fsb_search_table[fsb_index]!=-1; fsb_index++)
 		{
-			unsigned int tmpcount = longhaul_statecount_fsb(policy, fsb_search_table[fsb_index]);
-			if (tmpcount == 1)
+			if (longhaul_get_best_freq_for_fsb(policy, 
+			              min_mult, max_mult, 
+				      fsb_search_table[fsb_index], 
+				      &new_clock_ratio)) {
 				new_fsb = fsb_search_table[fsb_index];
-			number_states += tmpcount;
+				break;
+			}
 		}
+		if (!found)
+			return -EINVAL;
 	} else {
-		number_states = longhaul_statecount_fsb(policy, current_fsb);
 		new_fsb = current_fsb;
-	}
-
-	if (!number_states)
-		return -EINVAL;
-	else if (number_states == 1) {
-		for(i=0; i<numscales; i++) {
-			if ((clock_ratio[i] != -1) &&
-			    ((clock_ratio[i] * new_fsb * 100) <= policy->max) &&
-			    ((clock_ratio[i] * new_fsb * 100) >= policy->min))
-				new_clock_ratio = i;
-		}
-		longhaul_setstate(new_clock_ratio, new_fsb);
-	}
-
-	switch (policy->policy) {
-	case CPUFREQ_POLICY_POWERSAVE:
-		best_freq = -1;
-		if (can_scale_fsb==1) {
-			for (fsb_index=0; fsb_search_table[fsb_index]!=-1; fsb_index++) 
-			{
-				for(i=0; i<numscales; i++) {
-					unsigned int tmpfreq = fsb_search_table[fsb_index] * clock_ratio[i] * 100;
-					if (clock_ratio[i] == -1)
-						continue;
-
-					if ((tmpfreq >= policy->min) &&
-					    (tmpfreq <= policy->max) &&
-					    (tmpfreq < best_freq)) {
-						new_clock_ratio = i;
-						new_fsb = fsb_search_table[fsb_index];
-					}
-				}
-			}
-		} else {
-			for(i=0; i<numscales; i++) {
-				unsigned int tmpfreq = current_fsb * clock_ratio[i] * 100;
-					if (clock_ratio[i] == -1)
-						continue;
-
-					if ((tmpfreq >= policy->min) &&
-					    (tmpfreq <= policy->max) &&
-					    (tmpfreq < best_freq)) {
-						new_clock_ratio = i;
-						new_fsb = current_fsb;
-					}
-				}
-		}
-		break;
-	case CPUFREQ_POLICY_PERFORMANCE:
-		best_freq = 0;
-		if (can_scale_fsb==1) {
-			for (fsb_index=0; fsb_search_table[fsb_index]!=-1; fsb_index++) 
-			{
-				for(i=0; i<numscales; i++) {
-					unsigned int tmpfreq = fsb_search_table[fsb_index] * clock_ratio[i] * 100;
-					if (clock_ratio[i] == -1)
-						continue;
-
-					if ((tmpfreq >= policy->min) &&
-					    (tmpfreq <= policy->max) &&
-					    (tmpfreq > best_freq)) {
-						new_clock_ratio = i;
-						new_fsb = fsb_search_table[fsb_index];
-					}
-				}
-			}
-		} else {
-			for(i=0; i<numscales; i++) {
-				unsigned int tmpfreq = current_fsb * clock_ratio[i] * 100;
-					if (clock_ratio[i] == -1)
-						continue;
-
-					if ((tmpfreq >= policy->min) &&
-					    (tmpfreq <= policy->max) &&
-					    (tmpfreq > best_freq)) {
-						new_clock_ratio = i;
-						new_fsb = current_fsb;
-					}
-				}
-		}
-		break;
-	default:
-		return -EINVAL;
+		if (!longhaul_get_best_freq_for_fsb(policy, min_mult, 
+			     max_mult, new_fsb, &new_clock_ratio))
+			return -EINVAL;
 	}
 
 	longhaul_setstate(new_clock_ratio, new_fsb);
+
 	return 0;
 }
 
