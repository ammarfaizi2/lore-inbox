Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264890AbUD2QVg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264890AbUD2QVg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 12:21:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264889AbUD2QVg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 12:21:36 -0400
Received: from fmr03.intel.com ([143.183.121.5]:42417 "EHLO
	hermes.sc.intel.com") by vger.kernel.org with ESMTP id S264887AbUD2QVS
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 12:21:18 -0400
Date: Thu, 29 Apr 2004 09:21:07 -0700
From: Ashok Raj <ashok.raj@intel.com>
To: linux-ia64@vger.kernel.org
Cc: akpm@osdl.org, davidm@hpl.hp.com, rusty@rustycorp.com.au,
       tony.luck@intel.com, rajesh.shah@intel.com,
       linux-kernel@vger.kernel.org
Subject: take3: Updated CPU Hotplug patches for IA64 [just the last patch 7/7]cpu_present_map.patch
Message-ID: <20040429092107.A29687@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew

please replace the last patch cpu_present_map with this attached patch. In the earlier version, i didnt validate with sgi config
that had caused some compile problems with sn2_defconfig that Paul Jackson reported. Iam working with him to clean up the patch
to fit his new cpumask related changes.

we will need to find a new home for the following section that is in asm-ia64/cpumask.h

#ifdef CONFIG_HOTPLUG_CPU
#define ARCH_HAS_CPU_PRESENT_MAP
#endif

Paul is cleaning up this cpumask and explained that it will disapper in his new patch. I will work with him closely to find a new
place, or an equivalent when his patches get released.

thanks to David Mosberger and Paul to help cleanup my patches.

Cheers,
Ashok


Name: cpu_present_map.patch
Author: Ashok Raj (Intel Corporation)
D: This patch adds cpu_present_map, cpu_present() and for_each_cpu_present()
D: to distinguish between possible cpu's in a system and cpu's physically
D: present in a system. Before cpu hotplug was introduced cpu_possible()
D: represented cpu's physically present in the system. With hotplug capable
D: Kernel, there is a requirement to distinguish a cpu as possible verses a 
D: CPU physically present in the system. This is required so thta when
D: smp_init() attempts to start all cpu's it should now only attempt
D: to start cpu's present in the system. When a hotplug cpu is
D: physically inserted cpu_present_map will have bits updated
D: dynamically.


---

 arch/ia64/kernel/smp.c                           |    0 
 linux-2.6.5-lhcs-root/arch/ia64/kernel/smpboot.c |   21 +++++++++++++++++++--
 linux-2.6.5-lhcs-root/fs/proc/proc_misc.c        |    4 ++--
 linux-2.6.5-lhcs-root/include/asm-ia64/cpumask.h |    3 +++
 linux-2.6.5-lhcs-root/include/asm-ia64/smp.h     |    5 +++++
 linux-2.6.5-lhcs-root/include/linux/cpumask.h    |   17 +++++++++++++++++
 linux-2.6.5-lhcs-root/init/main.c                |    4 ++--
 linux-2.6.5-lhcs-root/kernel/cpu.c               |    2 +-
 8 files changed, 49 insertions(+), 7 deletions(-)

diff -puN include/asm-ia64/smp.h~cpu_present include/asm-ia64/smp.h
--- linux-2.6.5-lhcs/include/asm-ia64/smp.h~cpu_present	2004-04-28 16:59:25.614591293 -0700
+++ linux-2.6.5-lhcs-root/include/asm-ia64/smp.h	2004-04-28 16:59:25.626310049 -0700
@@ -48,7 +48,12 @@ extern volatile int ia64_cpu_to_sapicid[
 
 extern unsigned long ap_wakeup_vector;
 
+#ifdef CONFIG_HOTPLUG_CPU
+extern cpumask_t cpu_possible_map;
+#define cpu_present_map phys_cpu_present_map
+#else
 #define cpu_possible_map phys_cpu_present_map
+#endif
 
 /*
  * Function to map hard smp processor id to logical id.  Slow, so don't use this in
diff -puN arch/ia64/kernel/smpboot.c~cpu_present arch/ia64/kernel/smpboot.c
--- linux-2.6.5-lhcs/arch/ia64/kernel/smpboot.c~cpu_present	2004-04-28 16:59:25.616544419 -0700
+++ linux-2.6.5-lhcs-root/arch/ia64/kernel/smpboot.c	2004-04-28 16:59:25.627286612 -0700
@@ -87,9 +87,15 @@ DEFINE_PER_CPU(int, cpu_state);
 /* Bitmask of currently online CPUs */
 cpumask_t cpu_online_map;
 EXPORT_SYMBOL(cpu_online_map);
+
 cpumask_t phys_cpu_present_map;
 EXPORT_SYMBOL(phys_cpu_present_map);
 
+#ifdef CONFIG_HOTPLUG_CPU
+cpumask_t cpu_possible_map;
+EXPORT_SYMBOL(cpu_possible_map);
+#endif
+
 /* which logical CPU number maps to which CPU (physical APIC ID) */
 volatile int ia64_cpu_to_sapicid[NR_CPUS];
 EXPORT_SYMBOL(ia64_cpu_to_sapicid);
@@ -108,6 +114,7 @@ static int __init
 nointroute (char *str)
 {
 	no_int_routing = 1;
+	printk ("no_int_routing on\n");
 	return 1;
 }
 
@@ -472,13 +479,23 @@ smp_build_cpu_map (void)
 	int sapicid, cpu, i;
 	int boot_cpu_id = hard_smp_processor_id();
 
-	for (cpu = 0; cpu < NR_CPUS; cpu++)
+	/*
+	 * Since ACPI does not give us whats MAX cpu's
+	 * possible in the entire platform, we will just have to use
+	 * NR_CPUS set for possible map. cpu_present_map a.k.a
+	 * phys_cpu_present_map can grow based on a new cpu
+	 * becomming available to the system.
+	 */
+	cpus_clear(cpu_possible_map);
+	for (cpu=0; cpu < NR_CPUS; cpu++) {
 		ia64_cpu_to_sapicid[cpu] = -1;
+		cpu_set(cpu, cpu_possible_map);
+	}
 
 	ia64_cpu_to_sapicid[0] = boot_cpu_id;
+
 	cpus_clear(phys_cpu_present_map);
 	cpu_set(0, phys_cpu_present_map);
-
 	for (cpu = 1, i = 0; i < smp_boot_data.cpu_count; i++) {
 		sapicid = smp_boot_data.cpu_phys_id[i];
 		if (sapicid == boot_cpu_id)
diff -puN include/linux/cpumask.h~cpu_present include/linux/cpumask.h
--- linux-2.6.5-lhcs/include/linux/cpumask.h~cpu_present	2004-04-28 16:59:25.618497545 -0700
+++ linux-2.6.5-lhcs-root/include/linux/cpumask.h	2004-04-28 16:59:25.627286612 -0700
@@ -16,6 +16,16 @@ extern cpumask_t cpu_possible_map;
 #define cpu_online(cpu)			cpu_isset(cpu, cpu_online_map)
 #define cpu_possible(cpu)		cpu_isset(cpu, cpu_possible_map)
 
+#ifdef ARCH_HAS_CPU_PRESENT_MAP
+extern cpumask_t cpu_present_map;
+#define cpu_present(cpu)		cpu_isset(cpu, cpu_present_map)
+#define num_present_cpus()		cpus_weight(cpu_present_map)
+#else
+#define cpu_present_map			cpu_possible_map
+#define cpu_present(x)			cpu_possible(x)
+#define num_present_cpus()		num_possible_cpus()
+#endif
+
 #define for_each_cpu_mask(cpu, mask)					\
 	for (cpu = first_cpu_const(mk_cpumask_const(mask));		\
 		cpu < NR_CPUS;						\
@@ -23,16 +33,23 @@ extern cpumask_t cpu_possible_map;
 
 #define for_each_cpu(cpu) for_each_cpu_mask(cpu, cpu_possible_map)
 #define for_each_online_cpu(cpu) for_each_cpu_mask(cpu, cpu_online_map)
+#define for_each_present_cpu(cpu) for_each_cpu_mask(cpu, cpu_present_map)
 #else
 #define	cpu_online_map			cpumask_of_cpu(0)
 #define	cpu_possible_map		cpumask_of_cpu(0)
+#define cpu_present_map			cpumask_of_cpu(0)
+
 #define num_online_cpus()		1
 #define num_possible_cpus()		1
+#define num_present_cpus()		1
+
 #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
+#define cpu_present(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
 #define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
+#define for_each_present_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #endif
 
 #define cpumask_scnprintf(buf, buflen, map)				\
diff -puN init/main.c~cpu_present init/main.c
--- linux-2.6.5-lhcs/init/main.c~cpu_present	2004-04-28 16:59:25.619474108 -0700
+++ linux-2.6.5-lhcs-root/init/main.c	2004-04-28 16:59:25.628263175 -0700
@@ -357,10 +357,10 @@ static void __init smp_init(void)
 	unsigned j = 1;
 
 	/* FIXME: This should be done in userspace --RR */
-	for (i = 0; i < NR_CPUS; i++) {
+	for_each_present_cpu(i) {
 		if (num_online_cpus() >= max_cpus)
 			break;
-		if (cpu_possible(i) && !cpu_online(i)) {
+		if (!cpu_online(i)) {
 			cpu_up(i);
 			j++;
 		}
diff -puN kernel/cpu.c~cpu_present kernel/cpu.c
--- linux-2.6.5-lhcs/kernel/cpu.c~cpu_present	2004-04-28 16:59:25.621427234 -0700
+++ linux-2.6.5-lhcs-root/kernel/cpu.c	2004-04-28 16:59:25.628263175 -0700
@@ -169,7 +169,7 @@ int __devinit cpu_up(unsigned int cpu)
 	if ((ret = down_interruptible(&cpucontrol)) != 0)
 		return ret;
 
-	if (cpu_online(cpu)) {
+	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
 	}
diff -puN arch/ia64/kernel/smp.c~cpu_present arch/ia64/kernel/smp.c
diff -puN fs/proc/proc_misc.c~cpu_present fs/proc/proc_misc.c
--- linux-2.6.5-lhcs/fs/proc/proc_misc.c~cpu_present	2004-04-28 16:59:25.623380360 -0700
+++ linux-2.6.5-lhcs-root/fs/proc/proc_misc.c	2004-04-28 16:59:25.628263175 -0700
@@ -368,7 +368,7 @@ int show_stat(struct seq_file *p, void *
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
 
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		int j;
 
 		user += kstat_cpu(i).cpustat.user;
@@ -390,7 +390,7 @@ int show_stat(struct seq_file *p, void *
 		(unsigned long long)jiffies_64_to_clock_t(iowait),
 		(unsigned long long)jiffies_64_to_clock_t(irq),
 		(unsigned long long)jiffies_64_to_clock_t(softirq));
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user = kstat_cpu(i).cpustat.user;
diff -puN include/asm-ia64/cpumask.h~cpu_present include/asm-ia64/cpumask.h
--- linux-2.6.5-lhcs/include/asm-ia64/cpumask.h~cpu_present	2004-04-28 16:59:25.625333486 -0700
+++ linux-2.6.5-lhcs-root/include/asm-ia64/cpumask.h	2004-04-28 16:59:25.629239738 -0700
@@ -1,6 +1,9 @@
 #ifndef _ASM_IA64_CPUMASK_H
 #define _ASM_IA64_CPUMASK_H
 
+#ifdef CONFIG_HOTPLUG_CPU
+#define ARCH_HAS_CPU_PRESENT_MAP
+#endif
 #include <asm-generic/cpumask.h>
 
 #endif /* _ASM_IA64_CPUMASK_H */

_
