Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268765AbUHMFNk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268765AbUHMFNk (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 01:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268998AbUHMFNk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 01:13:40 -0400
Received: from ozlabs.org ([203.10.76.45]:16840 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268765AbUHMFNf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 01:13:35 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16668.19927.904866.179732@cargo.ozlabs.ibm.com>
Date: Fri, 13 Aug 2004 15:12:55 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, nathanl@austin.ibm.com, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (4/4) Remove unnecessary cpu maps
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

With cpu_present_map, we don't need these any longer.

Signed-off-by: Nathan Lynch <nathanl@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -ur linux-2.6/arch/ppc64/kernel/prom.c ntl/arch/ppc64/kernel/prom.c
--- linux-2.6/arch/ppc64/kernel/prom.c	2004-08-13 13:30:14.602165960 +1000
+++ ntl/arch/ppc64/kernel/prom.c	2004-08-13 13:30:34.415082968 +1000
@@ -940,9 +940,7 @@
 			lpaca[cpuid].hw_cpu_id = reg;
 
 #ifdef CONFIG_SMP
-			cpu_set(cpuid, RELOC(cpu_available_map));
 			cpu_set(cpuid, RELOC(cpu_possible_map));
-			cpu_set(cpuid, RELOC(cpu_present_at_boot));
 			cpu_set(cpuid, RELOC(cpu_present_map));
 			if (reg == 0)
 				cpu_set(cpuid, RELOC(cpu_online_map));
@@ -1043,9 +1041,7 @@
 #ifdef CONFIG_SMP
 				/* Set the number of active processors. */
 				_systemcfg->processorCount++;
-				cpu_set(cpuid, RELOC(cpu_available_map));
 				cpu_set(cpuid, RELOC(cpu_possible_map));
-				cpu_set(cpuid, RELOC(cpu_present_at_boot));
 				cpu_set(cpuid, RELOC(cpu_present_map));
 #endif
 			} else {
@@ -1055,10 +1051,8 @@
 #ifdef CONFIG_SMP
 		else {
 			prom_printf("%x : booting  cpu %s\n", cpuid, path);
-			cpu_set(cpuid, RELOC(cpu_available_map));
 			cpu_set(cpuid, RELOC(cpu_possible_map));
 			cpu_set(cpuid, RELOC(cpu_online_map));
-			cpu_set(cpuid, RELOC(cpu_present_at_boot));
 			cpu_set(cpuid, RELOC(cpu_present_map));
 		}
 #endif
@@ -1073,8 +1067,6 @@
 			prom_printf("%x : preparing thread ... ",
 				    interrupt_server[i]);
 			if (_naca->smt_state) {
-				cpu_set(cpuid, RELOC(cpu_available_map));
-				cpu_set(cpuid, RELOC(cpu_present_at_boot));
 				cpu_set(cpuid, RELOC(cpu_present_map));
 				cpu_set(cpuid, RELOC(cpu_possible_map));
 				_systemcfg->processorCount++;
diff -ur linux-2.6/arch/ppc64/kernel/smp.c ntl/arch/ppc64/kernel/smp.c
--- linux-2.6/arch/ppc64/kernel/smp.c	2004-08-13 13:30:14.623162768 +1000
+++ ntl/arch/ppc64/kernel/smp.c	2004-08-13 13:30:34.417082664 +1000
@@ -59,8 +59,6 @@
 
 cpumask_t cpu_possible_map = CPU_MASK_NONE;
 cpumask_t cpu_online_map = CPU_MASK_NONE;
-cpumask_t cpu_available_map = CPU_MASK_NONE;
-cpumask_t cpu_present_at_boot = CPU_MASK_NONE;
 
 EXPORT_SYMBOL(cpu_online_map);
 EXPORT_SYMBOL(cpu_possible_map);
@@ -124,9 +122,7 @@
 	np = 0;
         for (i=0; i < NR_CPUS; ++i) {
                 if (paca[i].lppaca.xDynProcStatus < 2) {
-			cpu_set(i, cpu_available_map);
 			cpu_set(i, cpu_possible_map);
-			cpu_set(i, cpu_present_at_boot);
 			cpu_set(i, cpu_present_map);
                         ++np;
                 }
@@ -878,7 +874,7 @@
 	int c;
 
 	/* At boot, don't bother with non-present cpus -JSCHOPP */
-	if (system_state == SYSTEM_BOOTING && !cpu_present_at_boot(cpu))
+	if (system_state == SYSTEM_BOOTING && !cpu_present(cpu))
 		return -ENOENT;
 
 	paca[cpu].prof_counter = 1;
diff -ur linux-2.6/arch/ppc64/kernel/xics.c ntl/arch/ppc64/kernel/xics.c
--- linux-2.6/arch/ppc64/kernel/xics.c	2004-08-08 12:05:16.000000000 +1000
+++ ntl/arch/ppc64/kernel/xics.c	2004-08-13 13:30:34.438079472 +1000
@@ -536,7 +536,7 @@
 #ifdef CONFIG_SMP
 		for_each_cpu(i) {
 			/* FIXME: Do this dynamically! --RR */
-			if (!cpu_present_at_boot(i))
+			if (!cpu_present(i))
 				continue;
 			xics_per_cpu[i] = __ioremap((ulong)inodes[get_hard_smp_processor_id(i)].addr, 
 						    (ulong)inodes[get_hard_smp_processor_id(i)].size,
diff -ur linux-2.6/include/asm-ppc64/smp.h ntl/include/asm-ppc64/smp.h
--- linux-2.6/include/asm-ppc64/smp.h	2004-08-13 13:30:14.635160944 +1000
+++ ntl/include/asm-ppc64/smp.h	2004-08-13 13:30:34.440079168 +1000
@@ -36,23 +36,6 @@
 #define smp_processor_id() (get_paca()->paca_index)
 #define hard_smp_processor_id() (get_paca()->hw_cpu_id)
 
-/*
- * Retrieve the state of a CPU:
- * online:          CPU is in a normal run state
- * possible:        CPU is a candidate to be made online
- * available:       CPU is candidate for the 'possible' pool
- *                  Used to get SMT threads started at boot time.
- * present_at_boot: CPU was available at boot time.  Used in DLPAR
- *                  code to handle special cases for processor start up.
- */
-extern cpumask_t cpu_present_at_boot;
-extern cpumask_t cpu_online_map;
-extern cpumask_t cpu_possible_map;
-extern cpumask_t cpu_available_map;
-
-#define cpu_present_at_boot(cpu) cpu_isset(cpu, cpu_present_at_boot)
-#define cpu_available(cpu)       cpu_isset(cpu, cpu_available_map) 
-
 /* Since OpenPIC has only 4 IPIs, we use slightly different message numbers.
  *
  * Make sure this matches openpic_request_IPIs in open_pic.c, or what shows up
