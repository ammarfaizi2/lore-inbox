Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262016AbVDDCK2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262016AbVDDCK2 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Apr 2005 22:10:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbVDDCJA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Apr 2005 22:09:00 -0400
Received: from fmr17.intel.com ([134.134.136.16]:4227 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S261972AbVDDCI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Apr 2005 22:08:27 -0400
Subject: [RFC 2/6]cpu_sibling_map rework
From: Li Shaohua <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>,
       ACPI-DEV <acpi-devel@lists.sourceforge.net>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>, Len Brown <len.brown@intel.com>,
       Pavel Machek <pavel@suse.cz>
Content-Type: text/plain
Message-Id: <1112580356.4194.338.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Mon, 04 Apr 2005 10:06:05 +0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make sibling map init per-cpu. Hotplug CPU may change the map at runtime.
cpuhotplug semaphore should be used to protect the map.


Thanks,
Shaohua

---

 linux-2.6.11-root/arch/i386/kernel/smpboot.c |   56 +++++++++++++--------------
 1 files changed, 29 insertions(+), 27 deletions(-)

diff -puN arch/i386/kernel/smpboot.c~sibling_map_init_cleanup arch/i386/kernel/smpboot.c
--- linux-2.6.11/arch/i386/kernel/smpboot.c~sibling_map_init_cleanup	2005-03-28 16:29:55.000000000 +0800
+++ linux-2.6.11-root/arch/i386/kernel/smpboot.c	2005-03-31 10:46:51.572700184 +0800
@@ -63,9 +63,12 @@ static int __initdata smp_b_stepping;
 
 /* Number of siblings per CPU package */
 int smp_num_siblings = 1;
-int phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
+/* Package ID of each logical CPU */
+int phys_proc_id[NR_CPUS] = {[0 ... NR_CPUS-1] = BAD_APICID};
 EXPORT_SYMBOL(phys_proc_id);
 
+cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
+
 /* bitmap of online cpus */
 cpumask_t cpu_online_map;
 
@@ -422,6 +425,9 @@ extern void enable_sep_cpu(void *);
  */
 static void __init start_secondary(void *unused)
 {
+	int siblings = 0;
+	int i;
+	int self = smp_processor_id();
 	/*
 	 * Dont put anything before smp_callin(), SMP
 	 * booting is too fragile that we want to limit the
@@ -443,6 +449,27 @@ static void __init start_secondary(void 
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
+
+	/* This must be doen before setting cpu_online_map */
+	if (smp_num_siblings > 1) {
+		for (i = 0; i < NR_CPUS; i++) {
+			if (!cpu_isset(i, cpu_callout_map))
+				continue;
+			if (phys_proc_id[self] == phys_proc_id[i]) {
+				siblings ++;
+				cpu_set(i, cpu_sibling_map[self]);
+				cpu_set(self, cpu_sibling_map[i]);
+			}
+		}
+	} else {
+		siblings ++;
+		cpu_set(self, cpu_sibling_map[self]);
+	}
+
+	if (siblings != smp_num_siblings)
+		printk(KERN_WARNING "WARNING: %d siblings found for CPU%d, should be %d\n", siblings, self, smp_num_siblings);
+	wmb();
+
 	cpu_set(smp_processor_id(), cpu_online_map);
 
 	/* We can take interrupts now: we're officially "up". */
@@ -893,8 +920,6 @@ static int boot_cpu_logical_apicid;
 /* Where the IO area was mapped on multiquad, always 0 otherwise */
 void *xquad_portio;
 
-cpumask_t cpu_sibling_map[NR_CPUS] __cacheline_aligned;
-
 static void __init smp_boot_cpus(unsigned int max_cpus)
 {
 	int apicid, cpu, bit, kicked;
@@ -1049,30 +1074,7 @@ static void __init smp_boot_cpus(unsigne
 	 */
 	for (cpu = 0; cpu < NR_CPUS; cpu++)
 		cpus_clear(cpu_sibling_map[cpu]);
-
-	for (cpu = 0; cpu < NR_CPUS; cpu++) {
-		int siblings = 0;
-		int i;
-		if (!cpu_isset(cpu, cpu_callout_map))
-			continue;
-
-		if (smp_num_siblings > 1) {
-			for (i = 0; i < NR_CPUS; i++) {
-				if (!cpu_isset(i, cpu_callout_map))
-					continue;
-				if (phys_proc_id[cpu] == phys_proc_id[i]) {
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
-	}
+	cpu_set(0, cpu_sibling_map[0]);
 
 	if (nmi_watchdog == NMI_LOCAL_APIC)
 		check_nmi_watchdog();
_


