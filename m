Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262598AbVDLTZU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262598AbVDLTZU (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:25:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262591AbVDLTXJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:23:09 -0400
Received: from fire.osdl.org ([65.172.181.4]:23241 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262200AbVDLKcX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:23 -0400
Message-Id: <200504121032.j3CAWBbI005526@shell0.pdx.osdl.net>
Subject: [patch 098/198] x86_64: Final support for AMD dual core 
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de, rjw@sisk.pl
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:05 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Clean up the code greatly.  Now uses the infrastructure from the Intel dual
core patch Should fix a final bug noticed by Tyan of not detecting the nodes
correctly in some corner cases.

Patch for x86-64 and i386

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/i386/kernel/cpu/amd.c    |   24 ++++++-----
 25-akpm/arch/i386/kernel/cpu/common.c |    2 
 25-akpm/arch/x86_64/kernel/setup.c    |   71 ++++++++++++++++++----------------
 3 files changed, 53 insertions(+), 44 deletions(-)

diff -puN arch/i386/kernel/cpu/amd.c~x86_64-final-support-for-amd-dual-core arch/i386/kernel/cpu/amd.c
--- 25/arch/i386/kernel/cpu/amd.c~x86_64-final-support-for-amd-dual-core	2005-04-12 03:21:26.496108880 -0700
+++ 25-akpm/arch/i386/kernel/cpu/amd.c	2005-04-12 03:21:26.502107968 -0700
@@ -24,6 +24,9 @@ __asm__(".align 4\nvide: ret");
 
 static void __init init_amd(struct cpuinfo_x86 *c)
 {
+#ifdef CONFIG_SMP
+	int cpu = c == &boot_cpu_data ? 0 : c - cpu_data;
+#endif
 	u32 l, h;
 	int mbytes = num_physpages >> (20-PAGE_SHIFT);
 	int r;
@@ -195,16 +198,17 @@ static void __init init_amd(struct cpuin
 			c->x86_num_cores = 1;
 	}
 
-	detect_ht(c);
-
-#ifdef CONFIG_X86_HT
-	/* AMD dual core looks like HT but isn't really. Hide it from the
-	   scheduler. This works around problems with the domain scheduler.
-	   Also probably gives slightly better scheduling and disables
-	   SMT nice which is harmful on dual core.
-	   TBD tune the domain scheduler for dual core. */
-	if (cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		smp_num_siblings = 1;
+#ifdef CONFIG_SMP
+	/*
+	 * On a AMD dual core setup the lower bits of the APIC id
+	 * distingush the cores.  Assumes number of cores is a power
+	 * of two.
+	 */
+	if (c->x86_num_cores > 1) {
+		cpu_core_id[cpu] = cpu >> hweight32(c->x86_num_cores - 1);
+		printk(KERN_INFO "CPU %d(%d) -> Core %d\n",
+		       cpu, c->x86_num_cores, cpu_core_id[cpu]);
+	}
 #endif
 }
 
diff -puN arch/i386/kernel/cpu/common.c~x86_64-final-support-for-amd-dual-core arch/i386/kernel/cpu/common.c
--- 25/arch/i386/kernel/cpu/common.c~x86_64-final-support-for-amd-dual-core	2005-04-12 03:21:26.497108728 -0700
+++ 25-akpm/arch/i386/kernel/cpu/common.c	2005-04-12 03:21:26.503107816 -0700
@@ -437,7 +437,7 @@ void __init detect_ht(struct cpuinfo_x86
 	int 	index_msb, tmp;
 	int 	cpu = smp_processor_id();
 
-	if (!cpu_has(c, X86_FEATURE_HT))
+	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
 		return;
 
 	cpuid(1, &eax, &ebx, &ecx, &edx);
diff -puN arch/x86_64/kernel/setup.c~x86_64-final-support-for-amd-dual-core arch/x86_64/kernel/setup.c
--- 25/arch/x86_64/kernel/setup.c~x86_64-final-support-for-amd-dual-core	2005-04-12 03:21:26.499108424 -0700
+++ 25-akpm/arch/x86_64/kernel/setup.c	2005-04-12 03:21:26.504107664 -0700
@@ -715,14 +715,46 @@ static void __init display_cacheinfo(str
 	}
 }
 
+#ifdef CONFIG_SMP
+/*
+ * On a AMD dual core setup the lower bits of the APIC id distingush the cores.
+ * Assumes number of cores is a power of two.
+ */
+static void __init amd_detect_cmp(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_SMP
+	int cpu = c->x86_apicid;
+	int node = 0;
+	if (c->x86_num_cores == 1)
+		return;
+	cpu_core_id[cpu] = cpu >> hweight32(c->x86_num_cores - 1);
+
+#ifdef CONFIG_NUMA
+	/* When an ACPI SRAT table is available use the mappings from SRAT
+ 	   instead. */
+	if (acpi_numa <= 0) {
+		node = cpu_core_id[cpu];
+		if (!node_online(node))
+			node = first_node(node_online_map);
+		cpu_to_node[cpu] = node;
+	} else {
+		node = cpu_to_node[cpu];
+	}
+#endif
+	printk(KERN_INFO "CPU %d(%d) -> Node %d -> Core %d\n",
+			cpu, c->x86_num_cores, node, cpu_core_id[cpu]);
+#endif
+}
+#else
+static void __init amd_detect_cmp(struct cpuinfo_x86 *c)
+{
+}
+#endif
 
 static int __init init_amd(struct cpuinfo_x86 *c)
 {
 	int r;
 	int level;
-#ifdef CONFIG_NUMA
-	int cpu;
-#endif
 
 	/* Bit 31 in normal CPUID used for nonstandard 3DNow ID;
 	   3DNow is IDd by bit 31 in extended CPUID (1*32+31) anyway */
@@ -750,21 +782,7 @@ static int __init init_amd(struct cpuinf
 		if (c->x86_num_cores & (c->x86_num_cores - 1))
 			c->x86_num_cores = 1;
 
-#ifdef CONFIG_NUMA
-		/* On a dual core setup the lower bits of apic id
-		   distingush the cores. Fix up the CPU<->node mappings
-		   here based on that.
-		   Assumes number of cores is a power of two.
-		   When using SRAT use mapping from SRAT. */
-		cpu = c->x86_apicid;
-		if (acpi_numa <= 0 && c->x86_num_cores > 1) {
-			cpu_to_node[cpu] = cpu >> hweight32(c->x86_num_cores - 1);
-			if (!node_online(cpu_to_node[cpu]))
-				cpu_to_node[cpu] = first_node(node_online_map);
-		}
-		printk(KERN_INFO "CPU %d(%d) -> Node %d\n",
-				cpu, c->x86_num_cores, cpu_to_node[cpu]);
-#endif
+		amd_detect_cmp(c);
 	}
 
 	return r;
@@ -777,7 +795,7 @@ static void __init detect_ht(struct cpui
 	int 	index_msb, tmp;
 	int 	cpu = smp_processor_id();
 	
-	if (!cpu_has(c, X86_FEATURE_HT))
+	if (!cpu_has(c, X86_FEATURE_HT) || cpu_has(c, X86_FEATURE_CMP_LEGACY))
 		return;
 
 	cpuid(1, &eax, &ebx, &ecx, &edx);
@@ -819,6 +837,7 @@ static void __init detect_ht(struct cpui
 		if (smp_num_siblings & (smp_num_siblings - 1))
 			index_msb++;
 
+		/* RED-PEN surely this must run in the non HT case too! -AK */
 		cpu_core_id[cpu] = phys_pkg_id(index_msb);
 
 		if (c->x86_num_cores > 1)
@@ -828,19 +847,6 @@ static void __init detect_ht(struct cpui
 #endif
 }
 
-static void __init sched_cmp_hack(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_SMP
-	/* AMD dual core looks like HT but isn't really. Hide it from the
-	   scheduler. This works around problems with the domain scheduler.
-	   Also probably gives slightly better scheduling and disables
-	   SMT nice which is harmful on dual core.
-	   TBD tune the domain scheduler for dual core. */
-	if (c->x86_vendor == X86_VENDOR_AMD && cpu_has(c, X86_FEATURE_CMP_LEGACY))
-		smp_num_siblings = 1;
-#endif
-}
-
 /*
  * find out the number of processor cores on the die
  */
@@ -1009,7 +1015,6 @@ void __init identify_cpu(struct cpuinfo_
 
 	select_idle_routine(c);
 	detect_ht(c); 
-	sched_cmp_hack(c);
 
 	/*
 	 * On SMP, boot_cpu_data holds the common feature set between
_
