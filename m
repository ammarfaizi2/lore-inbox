Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261521AbTEBEin (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 May 2003 00:38:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261572AbTEBEin
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 May 2003 00:38:43 -0400
Received: from mailhost1-bcvloh.bcvloh.ameritech.net ([66.73.20.42]:5361 "EHLO
	mailhost.bcv1.ameritech.net") by vger.kernel.org with ESMTP
	id S261521AbTEBEii (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 May 2003 00:38:38 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
Date: Thu, 1 May 2003 23:50:58 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Disposition: inline
To: acpi-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] 2.5 ACPI P-states driver crashes
Message-Id: <200305012346.55073.dtor_core@ameritech.net>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have the following problems with ACPI P-States driver:

- It crashes because it tries to switch CPU speed without registering cpufreq 
driver first but acpi_processor_set_performance calls cpufreq_notify_transition.

- When testing for capable CPUs it skips all online ones so for my single CPU
notebook it can't activate at all.

- If a processor does not support throttling then it will say that "limit" 
interface is not supported even after activating performance control.

The patch below should fix these issues. It also adds some info messages since
/proc/acpi/processor/*/performance interface is marked obsolete but i still
would like to see if P-states were recognized during boot.
 
Hopefully my mailer won't mess it...

Dmitry

diff -urN --exclude-from=/usr/src/exclude linux-2.5.68-orig/arch/i386/kernel/cpu/cpufreq/acpi.c linux-2.5.68/arch/i386/kernel/cpu/cpufreq/acpi.c
--- linux-2.5.68-orig/arch/i386/kernel/cpu/cpufreq/acpi.c	2003-04-07 12:30:42.000000000 -0500
+++ linux-2.5.68/arch/i386/kernel/cpu/cpufreq/acpi.c	2003-04-20 01:39:48.000000000 -0500
@@ -553,8 +553,9 @@
 {
 	unsigned int		i;
 	unsigned int		cpu = policy->cpu;
-	struct acpi_processor  *pr = NULL;
+	struct acpi_processor	*pr = NULL;
 	struct acpi_processor_performance *perf = &performance[policy->cpu];
+	struct acpi_device	*device;
 	unsigned int		result = 0;
 
 	ACPI_FUNCTION_TRACE("acpi_cpufreq_cpu_init");
@@ -596,6 +597,17 @@
 
 	acpi_cpufreq_add_file(pr);
 
+	if (acpi_bus_get_device(pr->handle, &device))
+		device = NULL;
+		
+	printk(KERN_INFO "cpufreq: %s - ACPI performance management activated.\n",
+		device ? acpi_device_bid(device) : "CPU??");
+	for (i = 0; i < pr->performance->state_count; i++)
+		printk(KERN_INFO "cpufreq: %cP%d: %d MHz, %d mW, %d uS\n",
+			(i == pr->performance->state?'*':' '), i,
+			(u32) pr->performance->states[i].core_frequency,
+			(u32) pr->performance->states[i].power,
+			(u32) pr->performance->states[i].transition_latency);
 	return_VALUE(result);
 }
 
@@ -658,16 +670,21 @@
 
 	/* test it on one CPU */
 	for (i=0; i<NR_CPUS; i++) {
-		if (cpu_online(i))
+		if (!cpu_online(i))
 			continue;
 		pr = performance[i].pr;
 		if (pr && pr->flags.performance)
 			goto found_capable_cpu;
 	}
 	result = -ENODEV;
-	goto err;
+	goto err0;
 
  found_capable_cpu:
+	
+ 	result = cpufreq_register_driver(&acpi_cpufreq_driver);
+	if (result) 
+		goto err0;
+	
 	perf = pr->performance;
 	current_state = perf->state;
 
@@ -676,7 +693,7 @@
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
 			result = -ENODEV;
-			goto err;
+			goto err1;
 		}
 	}
 
@@ -684,7 +701,7 @@
 	if (result) {
 		ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
 		result = -ENODEV;
-		goto err;
+		goto err1;
 	}
 	
 	if (current_state != 0) {
@@ -692,18 +709,17 @@
 		if (result) {
 			ACPI_DEBUG_PRINT((ACPI_DB_ERROR, "Disabled P-States due to failure while switching.\n"));
 			result = -ENODEV;
-			goto err;
+			goto err1;
 		}
 	}
 
-	result = cpufreq_register_driver(&acpi_cpufreq_driver);
-	if (result)
-		goto err;
-
 	return_VALUE(0);
 
 	/* error handling */
- err:
+ err1:
+	cpufreq_unregister_driver(&acpi_cpufreq_driver);
+	
+ err0:
 	/* unregister struct acpi_processor_performance performance */
 	for (i=0; i<NR_CPUS; i++) {
 		if (performance[i].pr) {
@@ -713,6 +729,8 @@
 		}
 	}
 	kfree(performance);
+	
+	printk(KERN_INFO "cpufreq: No CPUs supporting ACPI performance management found.\n");
 	return_VALUE(result);
 }
 
diff -urN --exclude-from=/usr/src/exclude linux-2.5.68-orig/drivers/acpi/processor.c linux-2.5.68/drivers/acpi/processor.c
--- linux-2.5.68-orig/drivers/acpi/processor.c	2003-05-01 22:45:22.000000000 -0500
+++ linux-2.5.68/drivers/acpi/processor.c	2003-05-01 22:22:13.000000000 -0500
@@ -85,7 +85,7 @@
 static int acpi_processor_throttling_open_fs(struct inode *inode, struct file *file);
 static int acpi_processor_power_open_fs(struct inode *inode, struct file *file);
 static int acpi_processor_limit_open_fs(struct inode *inode, struct file *file);
-
+static int acpi_processor_get_limit_info(struct acpi_processor *pr);
 
 static struct acpi_driver acpi_processor_driver = {
 	.name =		ACPI_PROCESSOR_DRIVER_NAME,
@@ -769,7 +769,9 @@
 	}
 
 	pr->performance_platform_limit = (int) ppc;
-
+	
+	acpi_processor_get_limit_info(pr);
+	
 	return_VALUE(0);
 }
 EXPORT_SYMBOL(acpi_processor_get_platform_limit);
@@ -790,6 +792,7 @@
 		return_VALUE(-EBUSY);
 
 	(*pr)->performance = performance;
+	performance->pr = *pr;
 	return 0;
 }
 EXPORT_SYMBOL(acpi_processor_register_performance);

