Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965013AbWDMXJ5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965013AbWDMXJ5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 19:09:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965010AbWDMXJX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 19:09:23 -0400
Received: from ns2.suse.de ([195.135.220.15]:33998 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964998AbWDMXIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 19:08:52 -0400
Date: Thu, 13 Apr 2006 16:07:43 -0700
From: Greg KH <gregkh@suse.de>
To: linux-kernel@vger.kernel.org, stable@kernel.org, torvalds@osdl.org
Cc: Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, Randy Dunlap <rdunlap@xenotime.net>,
       Dave Jones <davej@redhat.com>, Chuck Wolber <chuckw@quantumlinux.com>,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk, takata@linux-m32r.org,
       fujiwara.hayato@renesas.com, Greg Kroah-Hartman <gregkh@suse.de>
Subject: [patch 08/22] m32r: Fix cpu_possible_map and cpu_present_map initialization for SMP kernel
Message-ID: <20060413230743.GI5613@kroah.com>
References: <20060413230141.330705000@quad.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="m32r-fix-cpu_possible_map-and-cpu_present_map-initialization-for-smp-kernel.patch"
In-Reply-To: <20060413230637.GA5613@kroah.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

From: Hirokazu Takata <takata@linux-m32r.org>

This patch fixes a boot problem of the m32r SMP kernel 2.6.16-rc1-mm3 or
later.

In this patch, cpu_possible_map is statically initialized, and cpu_present_map
is also copied from cpu_possible_map in smp_prepare_cpus(), because the m32r
architecture has not supported CPU hotplug yet.

Signed-off-by: Hayato Fujiwara <fujiwara.hayato@renesas.com>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Signed-off-by: Andrew Morton <akpm@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 arch/m32r/kernel/setup.c   |   12 +++++-------
 arch/m32r/kernel/smpboot.c |   19 ++++++++++---------
 include/asm-m32r/smp.h     |    3 ++-
 3 files changed, 17 insertions(+), 17 deletions(-)

--- linux-2.6.16.5.orig/arch/m32r/kernel/setup.c
+++ linux-2.6.16.5/arch/m32r/kernel/setup.c
@@ -9,6 +9,7 @@
 
 #include <linux/config.h>
 #include <linux/init.h>
+#include <linux/kernel.h>
 #include <linux/stddef.h>
 #include <linux/fs.h>
 #include <linux/sched.h>
@@ -218,8 +219,6 @@ static unsigned long __init setup_memory
 extern unsigned long setup_memory(void);
 #endif	/* CONFIG_DISCONTIGMEM */
 
-#define M32R_PCC_PCATCR	0x00ef7014	/* will move to m32r.h */
-
 void __init setup_arch(char **cmdline_p)
 {
 	ROOT_DEV = old_decode_dev(ORIG_ROOT_DEV);
@@ -268,15 +267,14 @@ void __init setup_arch(char **cmdline_p)
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
--- linux-2.6.16.5.orig/arch/m32r/kernel/smpboot.c
+++ linux-2.6.16.5/arch/m32r/kernel/smpboot.c
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
--- linux-2.6.16.5.orig/include/asm-m32r/smp.h
+++ linux-2.6.16.5/include/asm-m32r/smp.h
@@ -67,7 +67,8 @@ extern volatile int cpu_2_physid[NR_CPUS
 #define raw_smp_processor_id()	(current_thread_info()->cpu)
 
 extern cpumask_t cpu_callout_map;
-#define cpu_possible_map cpu_callout_map
+extern cpumask_t cpu_possible_map;
+extern cpumask_t cpu_present_map;
 
 static __inline__ int hard_smp_processor_id(void)
 {

--
