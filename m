Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261410AbVFBNBs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261410AbVFBNBs (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Jun 2005 09:01:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbVFBNBr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Jun 2005 09:01:47 -0400
Received: from fmr20.intel.com ([134.134.136.19]:18648 "EHLO
	orsfmr005.jf.intel.com") by vger.kernel.org with ESMTP
	id S261410AbVFBNBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Jun 2005 09:01:15 -0400
Message-Id: <20050602130111.931715000@araj-em64t>
References: <20050602125754.993470000@araj-em64t>
Date: Thu, 02 Jun 2005 05:57:58 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org,
       Rusty Russell <rusty@rustycorp.com.au>,
       Srivattsa Vaddagiri <vatsa@in.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Ashok Raj <ashok.raj@intel.com>
Subject: [patch 3/5] x86_64: CPU hotplug sibling map cleanup
Content-Disposition: inline; filename=x86_64-sibling-map-fixup.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is a minor cleanup to the cpu sibling/core map.
It is required that this setup happens on a per-cpu bringup
time.

Signed-off-by: Ashok Raj <ashok.raj@intel.com>
------------------------------
 arch/x86_64/kernel/smpboot.c |   82 ++++++++++++++++++-------------------------
 1 files changed, 36 insertions(+), 46 deletions(-)

Index: linux-2.6.12-rc5-mm2/arch/x86_64/kernel/smpboot.c
===================================================================
--- linux-2.6.12-rc5-mm2.orig/arch/x86_64/kernel/smpboot.c
+++ linux-2.6.12-rc5-mm2/arch/x86_64/kernel/smpboot.c
@@ -445,6 +445,34 @@ void __cpuinit smp_callin(void)
 	cpu_set(cpuid, cpu_callin_map);
 }
 
+static inline void
+set_cpu_sibling_map(int cpu)
+{
+	int i;
+
+	if (smp_num_siblings > 1) {
+		for_each_cpu(i) {
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
+		for_each_cpu(i) {
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
@@ -475,6 +503,12 @@ void __cpuinit start_secondary(void)
 	enable_APIC_timer();
 
 	/*
+	 * The sibling maps must be set before turing the online map on for
+	 * this cpu
+	 */
+	set_cpu_sibling_map(smp_processor_id());
+
+	/*
 	 * Allow the master to continue.
 	 */
 	lock_ipi_call_lock();
@@ -809,51 +843,6 @@ cycles_t cacheflush_time;
 unsigned long cache_decay_ticks;
 
 /*
- * Construct cpu_sibling_map[], so that we can tell the sibling CPU
- * on SMT systems efficiently.
- */
-static __cpuinit void detect_siblings(void)
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
 static __cpuinit void smp_cleanup_boot(void)
@@ -1040,6 +1029,8 @@ void __init smp_prepare_boot_cpu(void)
 	int me = smp_processor_id();
 	cpu_set(me, cpu_online_map);
 	cpu_set(me, cpu_callout_map);
+	cpu_set(0, cpu_sibling_map[0]);
+	cpu_set(0, cpu_core_map[0]);
 }
 
 /*
@@ -1099,7 +1090,6 @@ void __init smp_cpus_done(unsigned int m
 	setup_ioapic_dest();
 #endif
 
-	detect_siblings();
 	time_init_gtod();
 
 	check_nmi_watchdog();

--

