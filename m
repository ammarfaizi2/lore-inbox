Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWCPDbM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWCPDbM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 22:31:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932264AbWCPDbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 22:31:12 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:48068 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S932259AbWCPDbK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 22:31:10 -0500
Date: Thu, 16 Mar 2006 12:29:52 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: LKML <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH] for_each_possible_cpu [9/19] i386
Message-Id: <20060316122952.e19f2726.kamezawa.hiroyu@jp.fujitsu.com>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch replaces for_each_cpu with for_each_possible_cpu.

under arch/i386.
 kernel/acpi/boot.c                      |    2 +-
 kernel/cpu/cpufreq/acpi-cpufreq.c       |    6 +++---
 kernel/cpu/cpufreq/powernow-k8.c        |    2 +-
 kernel/cpu/cpufreq/speedstep-centrino.c |    6 +++---
 kernel/io_apic.c                        |    4 ++--
 kernel/nmi.c                            |    6 +++---
 oprofile/nmi_int.c                      |    8 +++++---

Signed-Off-By: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>

Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/io_apic.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/io_apic.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/io_apic.c
@@ -381,7 +381,7 @@ static void do_irq_balance(void)
 	unsigned long imbalance = 0;
 	cpumask_t allowed_mask, target_cpu_mask, tmp;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		int package_index;
 		CPU_IRQ(i) = 0;
 		if (!cpu_online(i))
@@ -632,7 +632,7 @@ static int __init balanced_irq_init(void
 	else 
 		printk(KERN_ERR "balanced_irq_init: failed to spawn balanced_irq");
 failed:
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		kfree(irq_cpu_data[i].irq_delta);
 		irq_cpu_data[i].irq_delta = NULL;
 		kfree(irq_cpu_data[i].last_irq);
Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/acpi/boot.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/acpi/boot.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/acpi/boot.c
@@ -571,7 +571,7 @@ int acpi_unmap_lsapic(int cpu)
 {
 #ifndef CONFIG_LIMIT_CPUS
 	int i;
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (x86_acpiid_to_apicid[i] == x86_cpu_to_apicid[cpu]) {
 			x86_acpiid_to_apicid[i] = -1;
 			break;
Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/cpu/cpufreq/acpi-cpufreq.c
@@ -370,11 +370,11 @@ static int acpi_cpufreq_early_init_acpi(
 
 	dprintk("acpi_cpufreq_early_init\n");
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		data = kzalloc(sizeof(struct acpi_processor_performance), 
 			GFP_KERNEL);
 		if (!data) {
-			for_each_cpu(j) {
+			for_each_possible_cpu(j) {
 				kfree(acpi_perf_data[j]);
 				acpi_perf_data[j] = NULL;
 			}
@@ -582,7 +582,7 @@ acpi_cpufreq_exit (void)
 
 	cpufreq_unregister_driver(&acpi_cpufreq_driver);
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		kfree(acpi_perf_data[i]);
 		acpi_perf_data[i] = NULL;
 	}
Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/cpu/cpufreq/powernow-k8.c
@@ -1136,7 +1136,7 @@ static int __cpuinit powernowk8_init(voi
 {
 	unsigned int i, supported_cpus = 0;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		if (check_supported_cpu(i))
 			supported_cpus++;
 	}
Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/cpu/cpufreq/speedstep-centrino.c
@@ -365,11 +365,11 @@ static int centrino_cpu_early_init_acpi(
 	unsigned int	i, j;
 	struct acpi_processor_performance	*data;
 
-	for_each_cpu(i) {
+	for_each_possible_cpu(i) {
 		data = kzalloc(sizeof(struct acpi_processor_performance), 
 				GFP_KERNEL);
 		if (!data) {
-			for_each_cpu(j) {
+			for_each_possible_cpu(j) {
 				kfree(acpi_perf_data[j]);
 				acpi_perf_data[j] = NULL;
 			}
@@ -807,7 +807,7 @@ static void __exit centrino_exit(void)
 	cpufreq_unregister_driver(&centrino_driver);
 
 #ifdef CONFIG_X86_SPEEDSTEP_CENTRINO_ACPI
-	for_each_cpu(j) {
+	for_each_possible_cpu(j) {
 		kfree(acpi_perf_data[j]);
 		acpi_perf_data[j] = NULL;
 	}
Index: linux-2.6.16-rc6-mm1/arch/i386/kernel/nmi.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/kernel/nmi.c
+++ linux-2.6.16-rc6-mm1/arch/i386/kernel/nmi.c
@@ -140,12 +140,12 @@ static int __init check_nmi_watchdog(voi
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		smp_call_function(nmi_cpu_busy, (void *)&endflag, 0, 0);
 
-	for_each_cpu(cpu)
+	for_each_possible_cpu(cpu)
 		prev_nmi_count[cpu] = per_cpu(irq_stat, cpu).__nmi_count;
 	local_irq_enable();
 	mdelay((10*1000)/nmi_hz); // wait 10 ticks
 
-	for_each_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 #ifdef CONFIG_SMP
 		/* Check cpu_callin_map here because that is set
 		   after the timer is started. */
@@ -512,7 +512,7 @@ void touch_nmi_watchdog (void)
 	 * Just reset the alert counters, (other CPUs might be
 	 * spinning on locks we hold):
 	 */
-	for_each_cpu(i)
+	for_each_possible_cpu(i)
 		alert_counter[i] = 0;
 
 	/*
Index: linux-2.6.16-rc6-mm1/arch/i386/oprofile/nmi_int.c
===================================================================
--- linux-2.6.16-rc6-mm1.orig/arch/i386/oprofile/nmi_int.c
+++ linux-2.6.16-rc6-mm1/arch/i386/oprofile/nmi_int.c
@@ -122,10 +122,12 @@ static void nmi_save_registers(void * du
 static void free_msrs(void)
 {
 	int i;
-	for_each_cpu(i) {
-		kfree(cpu_msrs[i].counters);
+	for_each_possible_cpu(i) {
+		if (cpu_msrs[i].counters)
+			kfree(cpu_msrs[i].counters);
 		cpu_msrs[i].counters = NULL;
-		kfree(cpu_msrs[i].controls);
+		if (cpu_msrs[i].controls)
+			kfree(cpu_msrs[i].controls);
 		cpu_msrs[i].controls = NULL;
 	}
 }
