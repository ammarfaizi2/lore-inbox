Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261617AbVETWnN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261617AbVETWnN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 May 2005 18:43:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261467AbVETWkq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 May 2005 18:40:46 -0400
Received: from fmr20.intel.com ([134.134.136.19]:18062 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261437AbVETWjv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 May 2005 18:39:51 -0400
Message-Id: <20050520223417.873920000@csdlinux-2.jf.intel.com>
References: <20050520221622.124069000@csdlinux-2.jf.intel.com>
Date: Fri, 20 May 2005 15:16:25 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: ak@muc.de
Cc: zwane@arm.linux.org.uk, discuss@x86-64.org, shaohua.li@intel.com,
       linux-kernel@vger.kernel.org
Subject: [patch 3/4] CPU hot-plug support for x86_64
Content-Disposition: inline; filename=x86_64-sibling-map-fixup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a minor cleanup to the cpu sibling/core map.
It is required that this setup happens on a per-cpu bringup
time.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>

------------------------------
 smpboot.c |   89 ++++++++++++++++++++++++++++----------------------------------
 1 files changed, 41 insertions(+), 48 deletions(-)

Index: linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc4-mm2.orig/arch/x86_64/kernel/smpboot.c	2005-05-20 13:39:03.000000000 -0700
+++ linux-2.6.12-rc4-mm2/arch/x86_64/kernel/smpboot.c	2005-05-20 13:39:05.000000000 -0700
@@ -62,9 +62,12 @@
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
 /* Package ID of each logical CPU */
-u8 phys_proc_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
-u8 cpu_core_id[NR_CPUS] = { [0 ... NR_CPUS-1] = BAD_APICID };
+u8 phys_proc_id[NR_CPUS] __cacheline_aligned = 
+	{ [0 ... NR_CPUS-1] = BAD_APICID };
 EXPORT_SYMBOL(phys_proc_id);
+
+u8 cpu_core_id[NR_CPUS] __cacheline_aligned = 
+	{ [0 ... NR_CPUS-1] = BAD_APICID };
 EXPORT_SYMBOL(cpu_core_id);
 
 /* Bitmask of currently online CPUs */
@@ -434,6 +437,34 @@
 	local_flush_tlb();
 }
 
+static inline void
+set_cpu_sibling_map(int cpu)
+{
+	int i;
+
+	if (smp_num_siblings > 1) {
+		for_each_online_cpu(i) {
+			if (cpu_core_id[cpu] == cpu_core_id[i]) {
+				cpu_set(i, cpu_sibling_map[cpu]);
+				cpu_set(cpu, cpu_sibling_map[i]);
+			}
+		}
+	} else {
+		cpu_set(cpu, cpu_sibling_map[cpu]);
+	}
+
+	if (current_cpu_data.x86_num_cores > 1) {
+		for_each_online_cpu(i) {
+			if (phys_proc_id[cpu] == phys_proc_id[i]) {
+				cpu_set(i, cpu_core_map[cpu]);
+				cpu_set(cpu, cpu_core_map[i]);
+			}
+		}
+	} else {
+		cpu_core_map[cpu] = cpu_sibling_map[cpu];
+	}
+}
+
 /*
  * Setup code on secondary processor (after comming out of the trampoline)
  */
@@ -463,6 +494,12 @@
 
 	enable_APIC_timer();
 
+	/* 
+	 * The sibling maps must be set before turing the online map on for 
+	 * this cpu 
+	 */
+	set_cpu_sibling_map(smp_processor_id());
+
 	/*
 	 * Allow the master to continue.
 	 */
@@ -797,51 +834,6 @@
 unsigned long cache_decay_ticks;
 
 /*
- * Construct cpu_sibling_map[], so that we can tell the sibling CPU
- * on SMT systems efficiently.
- */
-static __devinit void detect_siblings(void)
-{
-	int cpu;
-
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		cpus_clear(cpu_sibling_map[cpu]);
-		cpus_clear(cpu_core_map[cpu]);
-	}
-
-	for_each_online_cpu (cpu) {
-		struct cpuinfo_x86 *c = cpu_data + cpu;
-		int siblings = 0;
-		int i;
-		if (smp_num_siblings > 1) {
-			for_each_online_cpu (i) {
-				if (cpu_core_id[cpu] == cpu_core_id[i]) {
-					siblings++;
-					cpu_set(i, cpu_sibling_map[cpu]);
-				}
-			}
-		} else {
-			siblings++;
-			cpu_set(cpu, cpu_sibling_map[cpu]);
-		}
-
-		if (siblings != smp_num_siblings) {
-			printk(KERN_WARNING
-	       "WARNING: %d siblings found for CPU%d, should be %d\n",
-			       siblings, cpu, smp_num_siblings);
-			smp_num_siblings = siblings;
-		}
-		if (c->x86_num_cores > 1) {
-			for_each_online_cpu(i) {
-				if (phys_proc_id[cpu] == phys_proc_id[i])
-					cpu_set(i, cpu_core_map[cpu]);
-			}
-		} else
-			cpu_core_map[cpu] = cpu_sibling_map[cpu];
-	}
-}
-
-/*
  * Cleanup possible dangling ends...
  */
 static __devinit void smp_cleanup_boot(void)
@@ -1035,6 +1027,8 @@
 	int me = smp_processor_id();
 	cpu_set(me, cpu_online_map);
 	cpu_set(me, cpu_callout_map);
+	cpu_set(0, cpu_sibling_map[0]);
+	cpu_set(0, cpu_core_map[0]);
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
@@ -1122,7 +1116,6 @@
 	setup_ioapic_dest();
 #endif
 
-	detect_siblings();
 	time_init_gtod();
 
 	check_nmi_watchdog();

--
