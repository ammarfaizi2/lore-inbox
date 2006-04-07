Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932419AbWDGKrt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932419AbWDGKrt (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 06:47:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932420AbWDGKrt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 06:47:49 -0400
Received: from mail.renesas.com ([202.234.163.13]:8588 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S932419AbWDGKrt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 06:47:49 -0400
Date: Fri, 07 Apr 2006 19:47:45 +0900 (JST)
Message-Id: <20060407.194745.233672521.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.17-rc1-mm1] m32r: Fix cpu_possible_map and
 cpu_present_map initialization for SMP kernel
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This patch fixes a boot problem of the m32r SMP kernel
2.6.16-rc1-mm3 or later.

In this patch, cpu_possible_map is statically initialized,
and cpu_present_map is also copied from cpu_possible_map in
smp_prepare_cpus(), because the m32r architecture has not
supported CPU hotplug yet.

Signed-off-by: Hayato Fujiwara <fujiwara.hayato@renesas.com>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/setup.c   |   12 +++++-------
 arch/m32r/kernel/smpboot.c |   19 ++++++++++---------
 include/asm-m32r/smp.h     |    3 ++-
 3 files changed, 17 insertions(+), 17 deletions(-)

Index: linux-2.6.17-rc1-mm1/arch/m32r/kernel/setup.c
===================================================================
--- linux-2.6.17-rc1-mm1.orig/arch/m32r/kernel/setup.c	2006-04-07 15:45:16.753827627 +0900
+++ linux-2.6.17-rc1-mm1/arch/m32r/kernel/setup.c	2006-04-07 15:45:46.815091003 +0900
@@ -9,6 +9,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
@@ -219,8 +220,6 @@ static unsigned long __init setup_memory
 extern unsigned long setup_memory(void);
 #endif	/* CONFIG_DISCONTIGMEM */
 
-#define M32R_PCC_PCATCR	0x00ef7014	/* will move to m32r.h */
-
 void __init setup_arch(char **cmdline_p)
 {
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
@@ -269,15 +268,14 @@ void __init setup_arch(char **cmdline_p)
 	paging_init();
 }
 
-static struct cpu cpu[NR_CPUS];
+static struct cpu cpu_devices[NR_CPUS];
 
 static int __init topology_init(void)
 {
-	int cpu_id;
+	int i;
 
-	for (cpu_id = 0; cpu_id < NR_CPUS; cpu_id++)
-		if (cpu_possible(cpu_id))
-			register_cpu(&cpu[cpu_id], cpu_id, NULL);
+	for_each_present_cpu(i)
+		register_cpu(&cpu_devices[i], i, NULL);
 
 	return 0;
 }
Index: linux-2.6.17-rc1-mm1/arch/m32r/kernel/smpboot.c
===================================================================
--- linux-2.6.17-rc1-mm1.orig/arch/m32r/kernel/smpboot.c	2006-04-07 12:12:17.430664372 +0900
+++ linux-2.6.17-rc1-mm1/arch/m32r/kernel/smpboot.c	2006-04-07 15:45:46.822089900 +0900
@@ -39,8 +39,10 @@
  *		Martin J. Bligh	: 	Added support for multi-quad systems
  */
 
+#include <linux/module.h>
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/mm.h>
 #include <linux/smp_lock.h>
 #include <linux/irq.h>
@@ -72,11 +74,15 @@ physid_mask_t phys_cpu_present_map;
 
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map;
+EXPORT_SYMBOL(cpu_online_map);
 
 cpumask_t cpu_bootout_map;
 cpumask_t cpu_bootin_map;
-cpumask_t cpu_callout_map;
 static cpumask_t cpu_callin_map;
+cpumask_t cpu_callout_map;
+EXPORT_SYMBOL(cpu_callout_map);
+cpumask_t cpu_possible_map = CPU_MASK_ALL;
+EXPORT_SYMBOL(cpu_possible_map);
 
 /* Per CPU bogomips and other parameters */
 struct cpuinfo_m32r cpu_data[NR_CPUS] __cacheline_aligned;
@@ -110,7 +116,6 @@ static unsigned int calibration_result;
 
 void smp_prepare_boot_cpu(void);
 void smp_prepare_cpus(unsigned int);
-static void smp_tune_scheduling(void);
 static void init_ipi_lock(void);
 static void do_boot_cpu(int);
 int __cpu_up(unsigned int);
@@ -177,6 +182,9 @@ void __init smp_prepare_cpus(unsigned in
 	}
 	for (phys_id = 0 ; phys_id < nr_cpu ; phys_id++)
 		physid_set(phys_id, phys_cpu_present_map);
+#ifndef CONFIG_HOTPLUG_CPU
+	cpu_present_map = cpu_possible_map;
+#endif
 
 	show_mp_info(nr_cpu);
 
@@ -186,7 +194,6 @@ void __init smp_prepare_cpus(unsigned in
 	 * Setup boot CPU information
 	 */
 	smp_store_cpu_info(0); /* Final full version of the data */
-	smp_tune_scheduling();
 
 	/*
 	 * If SMP should be disabled, then really disable it!
@@ -230,11 +237,6 @@ smp_done:
 	Dprintk("Boot done.\n");
 }
 
-static void __init smp_tune_scheduling(void)
-{
-	/* Nothing to do. */
-}
-
 /*
  * init_ipi_lock : Initialize IPI locks.
  */
@@ -629,4 +631,3 @@ static void __init unmap_cpu_to_physid(i
 	physid_2_cpu[phys_id] = -1;
 	cpu_2_physid[cpu_id] = -1;
 }
-
Index: linux-2.6.17-rc1-mm1/include/asm-m32r/smp.h
===================================================================
--- linux-2.6.17-rc1-mm1.orig/include/asm-m32r/smp.h	2006-04-07 12:16:21.802189429 +0900
+++ linux-2.6.17-rc1-mm1/include/asm-m32r/smp.h	2006-04-07 15:45:46.834088010 +0900
@@ -67,7 +67,8 @@ extern volatile int cpu_2_physid[NR_CPUS
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
-#define cpu_possible_map cpu_callout_map
+extern cpumask_t cpu_possible_map;
+extern cpumask_t cpu_present_map;
 
 static __inline__ int hard_smp_processor_id(void)
 {


--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
