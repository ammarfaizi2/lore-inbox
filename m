Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262069AbVDLGDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262069AbVDLGDG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 02:03:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262060AbVDLFqr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 01:46:47 -0400
Received: from fmr17.intel.com ([134.134.136.16]:9392 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S262033AbVDLFda (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 01:33:30 -0400
Subject: [PATCH 2/6]sibling map initializing rework
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Len Brown <len.brown@intel.com>, Pavel Machek <pavel@suse.cz>,
       Zwane Mwaikambo <zwane@linuxpower.ca>, Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Message-Id: <1113283852.27646.426.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Tue, 12 Apr 2005 13:30:56 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make sibling map init per-cpu. Hotplug CPU may change the map at
runtime.

Signed-off-by: Li Shaohua<shaohua.li@intel.com>

---

 linux-2.6.11-root/arch/i386/kernel/smpboot.c |   86 ++++++++++++++-------------
 1 files changed, 45 insertions(+), 41 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~sibling_map_init_cleanup arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~sibling_map_init_cleanup	2005-04-12 10:36:34.283984464 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-04-12 10:36:34.287983856 +0800
@@ -63,11 +63,16 @@ static int __initdata smp_b_stepping;
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
-int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
+/* Package ID of each logical CPU */
+int phys_proc_id[NR_CPUS] = {[0 ... NR_CPUS-1] = BAD_APICID};
 EXPORT_SYMBOL(phys_proc_id);
-int cpu_core_id[NR_CPUS]; /* Core ID of each logical CPU */
+/* Core ID of each logical CPU */
+int cpu_core_id[NR_CPUS] = {[0 ... NR_CPUS-1] = BAD_APICID};
 EXPORT_SYMBOL(cpu_core_id);
 
+cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
+
 /* bitmap of online cpus */
 cpumask_t cpu_online_map __cacheline_aligned;
 
@@ -417,6 +422,38 @@ static void __init smp_callin(void)
 
 static int cpucount;
 
+static inline void
+set_cpu_sibling_map(int cpu)
+{
+	int i;
+
+	if (smp_num_siblings > 1) {
+		for (i = 0; i < NR_CPUS; i++) {
+			if (!cpu_isset(i, cpu_callout_map))
+				continue;
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
+		for (i = 0; i < NR_CPUS; i++) {
+			if (!cpu_isset(i, cpu_callout_map))
+				continue;
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
  * Activate a secondary processor.
  */
@@ -444,6 +481,10 @@ static void __init start_secondary(void 
 	 */
 	local_flush_tlb();
 
+	/* This must be done before setting cpu_online_map */
+	set_cpu_sibling_map(_smp_processor_id());
+	wmb();
+
 	/* Note: this must be done before __cpu_up finish */
 	enable_sep_cpu();
 	cpu_set(smp_processor_id(), cpu_online_map);
@@ -896,8 +937,6 @@ static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
 
-cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
-cpumask_t cpu_core_map[NR_CPUS] __cacheline_aligned;
 
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
@@ -1064,43 +1103,8 @@ static void __init smp_boot_cpus(unsigne
 		cpus_clear(cpu_sibling_map[cpu]);
 		cpus_clear(cpu_core_map[cpu]);
 	}
-
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		struct cpuinfo_x86 *c = cpu_data + cpu;
-		int siblings = 0;
-		int i;
-		if (!cpu_isset(cpu, cpu_callout_map))
-			continue;
-
-		if (smp_num_siblings > 1) {
-			for (i = 0; i < NR_CPUS; i++) {
-				if (!cpu_isset(i, cpu_callout_map))
-					continue;
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
-		if (siblings != smp_num_siblings)
-			printk(KERN_WARNING "WARNING: %d siblings found for CPU%d, should be %d\n", siblings, cpu, smp_num_siblings);
-
-		if (c->x86_num_cores > 1) {
-			for (i = 0; i < NR_CPUS; i++) {
-				if (!cpu_isset(i, cpu_callout_map))
-					continue;
-				if (phys_proc_id[cpu] == phys_proc_id[i]) {
-					cpu_set(i, cpu_core_map[cpu]);
-				}
-			}
-		} else {
-			cpu_core_map[cpu] = cpu_sibling_map[cpu];
-		}
-	}
+	cpu_set(0, cpu_sibling_map[0]);
+	cpu_set(0, cpu_core_map[0]);
 
 	smpboot_setup_io_apic();
 
_


