Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267278AbTABVhj>; Thu, 2 Jan 2003 16:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267266AbTABVgQ>; Thu, 2 Jan 2003 16:36:16 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:49818 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S267284AbTABVf0>; Thu, 2 Jan 2003 16:35:26 -0500
Date: Thu, 2 Jan 2003 22:44:52 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com, andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk,
       acpi-devel@lists.sourceforge.net
Subject: [PATCH 2.5.54] cpufreq: remove deprecated usage of CPUFREQ_ALL_CPUS in ACPI
Message-ID: <20030102214452.GF19479@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As policy->cpu now only points to an existing CPU, some code can 
safely be removed from the ACPI P-States cpufreq driver.

	 Dominik

diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2003-01-02 20:56:57.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-01-02 21:17:34.000000000 +0100
@@ -1669,24 +1669,10 @@
 	if (!policy)
 		return_VALUE(-EINVAL);
 
-	/* get a present, initialized CPU */
-	if (policy->cpu == CPUFREQ_ALL_CPUS)
-	{
-		for (i=0; i<NR_CPUS; i++) {
-			if (processors[i] != NULL) {
-				cpu = i;
-				pr = processors[cpu];
-				break;
-			}
-		}
-	}
-	else
-	{
-		cpu = policy->cpu;
-		pr = processors[cpu];
-		if (!pr)
-			return_VALUE(-EINVAL);
-	}
+	cpu = policy->cpu;
+	pr = processors[cpu];
+	if (!pr)
+		return_VALUE(-EINVAL);
 
 	/* select appropriate P-State */
 	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
@@ -1715,19 +1701,9 @@
 	}
 
 	/* set one or all CPUs to the new state */
-	if (policy->cpu == CPUFREQ_ALL_CPUS) {
-		for (i=0; i<NR_CPUS; i++)
-		{
-			pr = processors[cpu];
-			if (!pr || !cpu_online(cpu))
-				continue;
-			result = acpi_processor_set_performance (pr, next_state);
-		}
-	} else {
-		result = acpi_processor_set_performance (pr, next_state);
-	}
+	result = acpi_processor_set_performance (pr, next_state);
 
-	return_VALUE(0);
+	return_VALUE(result);
 }
 
 
@@ -1746,24 +1722,10 @@
 	if (!policy)
 		return_VALUE(-EINVAL);
 
-	/* get a present, initialized CPU */
-	if (policy->cpu == CPUFREQ_ALL_CPUS)
-	{
-		for (i=0; i<NR_CPUS; i++) {
-			if (processors[i] != NULL) {
-				cpu = i;
-				pr = processors[cpu];
-				break;
-			}
-		}
-	}
-	else
-	{
-		cpu = policy->cpu;
-		pr = processors[cpu];
-		if (!pr)
-			return_VALUE(-EINVAL);
-	}
+	cpu = policy->cpu;
+	pr = processors[cpu];
+	if (!pr)
+		return_VALUE(-EINVAL);
 
 	/* first check if min and max are within valid limits */
 	cpufreq_verify_within_limits(
@@ -1787,6 +1749,11 @@
 		policy->max = pr->performance.states[next_larger_state].core_frequency * 1000;
 	}
 
+	cpufreq_verify_within_limits(
+		policy, 
+		pr->performance.states[pr->performance.state_count - 1].core_frequency * 1000,
+		pr->performance.states[pr->limit.state.px].core_frequency * 1000);
+
 	return_VALUE(0);
 }
 
