Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266640AbTAFNkj>; Mon, 6 Jan 2003 08:40:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266645AbTAFNki>; Mon, 6 Jan 2003 08:40:38 -0500
Received: from natsmtp01.webmailer.de ([192.67.198.81]:17027 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP
	id <S266640AbTAFNkf>; Mon, 6 Jan 2003 08:40:35 -0500
Date: Mon, 6 Jan 2003 14:48:37 +0100
From: Dominik Brodowski <linux@brodo.de>
To: andrew.grover@intel.com
Cc: linux-kernel@vger.kernel.org, cpufreq@www.linux.org.uk,
       acpi-devel@lists.sourceforge.net
Subject: [PATCH 2.5.54] cpufreq-ACPI: deprecated usage of CPUFREQ_ALL_CPUS
Message-ID: <20030106134837.GA1264@brodo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Deprecated usage of CPUFREQ_ALL_CPUS: as policy->cpu now only points
to an existing CPU, some code can safely be removed from the ACPI
P-States cpufreq driver.

	 Dominik

 drivers/acpi/processor.c |   63 +++++++++--------------------------------------
 1 files changed, 13 insertions(+), 50 deletions(-)

diff -ruN linux-original/drivers/acpi/processor.c linux/drivers/acpi/processor.c
--- linux-original/drivers/acpi/processor.c	2003-01-06 12:55:39.000000000 +0100
+++ linux/drivers/acpi/processor.c	2003-01-06 13:44:35.000000000 +0100
@@ -1658,7 +1658,6 @@
 acpi_cpufreq_setpolicy (
 	struct cpufreq_policy   *policy)
 {
-	unsigned int cpu = 0;
 	unsigned int i = 0;
 	struct acpi_processor *pr = NULL;
 	unsigned int next_state = 0;
@@ -1669,24 +1668,9 @@
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
+	pr = processors[policy->cpu];
+	if (!pr)
+		return_VALUE(-EINVAL);
 
 	/* select appropriate P-State */
 	if (policy->policy == CPUFREQ_POLICY_POWERSAVE)
@@ -1715,19 +1699,9 @@
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
 
 
@@ -1735,7 +1709,6 @@
 acpi_cpufreq_verify (
 	struct cpufreq_policy   *policy)
 {
-	unsigned int cpu = 0;
 	unsigned int i = 0;
 	struct acpi_processor *pr = NULL;
 	unsigned int number_states = 0;
@@ -1746,24 +1719,9 @@
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
+	pr = processors[policy->cpu];
+	if (!pr)
+		return_VALUE(-EINVAL);
 
 	/* first check if min and max are within valid limits */
 	cpufreq_verify_within_limits(
@@ -1787,6 +1745,11 @@
 		policy->max = pr->performance.states[next_larger_state].core_frequency * 1000;
 	}
 
+	cpufreq_verify_within_limits(
+		policy, 
+		pr->performance.states[pr->performance.state_count - 1].core_frequency * 1000,
+		pr->performance.states[pr->limit.state.px].core_frequency * 1000);
+
 	return_VALUE(0);
 }
 
