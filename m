Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264903AbSLVKQJ>; Sun, 22 Dec 2002 05:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264925AbSLVKQJ>; Sun, 22 Dec 2002 05:16:09 -0500
Received: from natsmtp00.webmailer.de ([192.67.198.74]:6795 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S264903AbSLVKQI>; Sun, 22 Dec 2002 05:16:08 -0500
Date: Sun, 22 Dec 2002 11:22:08 +0100
From: Dominik Brodowski <linux@brodo.de>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk
Subject: [PATCH 2.5] cpufreq: deprecated use of CPUFREQ_ALL_CPUS (ACPI)
Message-ID: <20021222102208.GB3222@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

CPUFREQ_ALL_CPUS isn't a valid argument for the cpufreq_driver->setpolicy
call - so some code paths can be removed.

	Dominik

diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2002-12-21 14:53:47.000000000 +0100
+++ linux/drivers/acpi/processor.c	2002-12-22 11:01:51.000000000 +0100
@@ -1670,23 +1670,10 @@
 		return_VALUE(-EINVAL);
 
 	/* get a present, initialized CPU */
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
@@ -1715,19 +1702,9 @@
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
 
 
@@ -1747,23 +1724,10 @@
 		return_VALUE(-EINVAL);
 
 	/* get a present, initialized CPU */
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
