Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264705AbUD1JeT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264705AbUD1JeT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 05:34:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264710AbUD1JeT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 05:34:19 -0400
Received: from mtvcafw.sgi.com ([192.48.171.6]:18728 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S264705AbUD1Jdz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 05:33:55 -0400
Date: Wed, 28 Apr 2004 02:32:38 -0700
From: Paul Jackson <pj@sgi.com>
To: ashok.raj@intel.com, Rusty Russell <rusty@rustcorp.com.au>,
       Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Concerns with ia64-cpu-hotplug-cpu_present.patch
Message-Id: <20040428023238.76244ed2.pj@sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 0.9.8 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

If it were left up to me, I would back out Ashok Raj's
cpu_present patch, until some of the following concerns are
hashed out, and until it builds.  However, since (1) I have
no insight into the history of this patch, and (2) I don't
understand it very well yet, I may well be off the mark in
saying this.

Rusty,

I added you to the cc list, since this overlaps areas I recall
you working in.

Ashok,

I am unable to make sufficient sense of this patch to adapt it
to my upcoming cpumask changes.

Since I don't see this patch previously posted on lkml, I have
included the original patch of 25 April 2004 which Andrew named
ia64-cpu-hotplug-cpu_present.patch, for the benefit of others,
at the end of this current message.

===

Here are some questions, confusions and concerns that reflect
my current (limited) understanding of this patch:

1) What's the interaction of CONFIG_HOTPLUG_CPU and
   ARCH_HAS_CPU_PRESENT_MAP and SMP, especially as relates
   to the meaning of phys_cpu_present_map, cpu_present_map
   and cpu_possible_map?

2) It doesn't build for me, for arch=ia64, sn2_defconfig,
   which has:

   	CONFIG_SMP=y
	CONFIG_HOTPLUG=y
	ARCH_HAS_CPU_PRESENT_MAP defined in asm-ia64/cpumask.h

   The build fails in the final link, with:
   
	init/built-in.o(.init.text+0x560): In function `smp_init':
	: undefined reference to `cpu_present_map'
	init/built-in.o(.init.text+0x580): In function `smp_init':
	: undefined reference to `cpu_present_map'
	kernel/built-in.o(.text+0x451d0): In function `cpu_up':
	: undefined reference to `cpu_present_map'
	kernel/built-in.o(.text+0x451e1): In function `cpu_up':
	: undefined reference to `cpu_present_map'
	make: *** [.tmp_vmlinux1] Error 1

   If I make the following repair patch, then it builds (though
   I have no clue if this is right):

========================== begin repair patch ==========================
===== smp.h 1.15 vs 1.16 =====
--- 1.15/include/asm-ia64/smp.h Mon Apr 26 00:45:18 2004
+++ 1.16/include/asm-ia64/smp.h Tue Apr 27 23:28:06 2004
@@ -50,10 +50,10 @@

 #ifdef CONFIG_HOTPLUG_CPU
 extern cpumask_t cpu_possible_map;
-#define cpu_present_map phys_cpu_present_map
 #else
 #define cpu_possible_map phys_cpu_present_map
 #endif
+#define cpu_present_map phys_cpu_present_map

 /*
  * Function to map hard smp processor id to logical id.  Slow, so don't use this in
========================== end repair patch ==========================


 3) Note that before the repair patch in (2) above, one half of the
    #ifdef CONFIG_HOTPLUG_CPU defines cpu_present_map, but
    not the other half.  That sort of assymmetry confuses my
    limited brain power.

 4) Why have cpu_present_map, when you already have phys_cpu_present_map,
    to which cpu_present_map define'd?

 5) The changes to smp.c and most of the changes to main.c
    seem to have something to do with KDB interrupts; do they
    belong in a separate patch?

 6) You add num_present_cpus and for_each_present_cpu, but
    nothing uses them.  Are they useful?
    
 7) However, you only add for_each_present_cpu in the SMP case - why
    not in the non-SMP case?
 
 8) The ARCH_HAS_CPU_PRESENT_MAP flag seems confusing.  Can we make
    a change that is consistent for all arch's that reflects what is
    needed, and eliminate this flag?
 
 9) Only the ia64 arch sets ARCH_HAS_CPU_PRESENT_MAP.  Is this
    change really just an ia64 thing, or should it be more general?

10) The mix and interdefining of possible and present cpumasks,
    depending on various defines, also overloads my limited brain power.
    Is there someway to just get the possible/present model the same way,
    for all arch's?

Well .. that's enough for now .. I suspect you get the idea ;).

Thank-you.

===

The rest of this message is a copy of the patch named
ia64-cpu-hotplug-cpu_present.patch, dated 25 April 2004, as
included in Andrew's patch set.

========================== begin original patch ==========================

From: "Ashok Raj" <ashok.raj@intel.com>

This patch adds cpu_present_map, cpu_present() and for_each_cpu_present() to
distinguish between possible cpu's in a system and cpu's physically present in
a system.  Before cpu hotplug was introduced cpu_possible() represented cpu's
physically present in the system.  With hotplug capable Kernel, there is a
requirement to distinguish a cpu as possible verses a CPU physically present
in the system.  This is required so thta when smp_init() attempts to start all
cpu's it should now only attempt to start cpu's present in the system.  When a
hotplug cpu is physically inserted cpu_present_map will have bits updated
dynamically.


---

 25-akpm/arch/ia64/kernel/smp.c     |   24 ++++++++++++++++++++++++
 25-akpm/arch/ia64/kernel/smpboot.c |   21 +++++++++++++++++++--
 25-akpm/fs/proc/proc_misc.c        |    4 ++--
 25-akpm/include/asm-ia64/cpumask.h |    1 +
 25-akpm/include/asm-ia64/smp.h     |    5 +++++
 25-akpm/include/linux/cpumask.h    |   16 ++++++++++++++++
 25-akpm/init/main.c                |   30 +++++++++++++++++++++++++++++-
 25-akpm/kernel/cpu.c               |    2 +-
 8 files changed, 97 insertions(+), 6 deletions(-)

diff -puN arch/ia64/kernel/smpboot.c~ia64-cpu-hotplug-cpu_present arch/ia64/kernel/smpboot.c
--- 25/arch/ia64/kernel/smpboot.c~ia64-cpu-hotplug-cpu_present	2004-04-25 22:29:52.757917144 -0700
+++ 25-akpm/arch/ia64/kernel/smpboot.c	2004-04-25 22:29:52.771915016 -0700
@@ -87,9 +87,15 @@ DEFINE_PER_CPU(int, cpu_state) = { 0 };
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
diff -puN arch/ia64/kernel/smp.c~ia64-cpu-hotplug-cpu_present arch/ia64/kernel/smp.c
--- 25/arch/ia64/kernel/smp.c~ia64-cpu-hotplug-cpu_present	2004-04-25 22:29:52.758916992 -0700
+++ 25-akpm/arch/ia64/kernel/smp.c	2004-04-25 22:29:52.774914560 -0700
@@ -36,6 +36,11 @@
 #include <asm/current.h>
 #include <asm/delay.h>
 #include <asm/machvec.h>
+
+#ifdef	CONFIG_KDB
+#include <linux/kdb.h>
+#endif	/* CONFIG_KDB */
+
 #include <asm/io.h>
 #include <asm/irq.h>
 #include <asm/page.h>
@@ -67,6 +72,9 @@ static volatile struct call_data_struct 
 
 #define IPI_CALL_FUNC		0
 #define IPI_CPU_STOP		1
+#ifdef	CONFIG_KDB
+#define IPI_KDB_INTERRUPT	2
+#endif	/* CONFIG_KDB */
 
 /* This needs to be cacheline aligned because it is written to by *other* CPUs.  */
 static DEFINE_PER_CPU(u64, ipi_operation) ____cacheline_aligned;
@@ -157,6 +165,13 @@ handle_IPI (int irq, void *dev_id, struc
 				stop_this_cpu();
 				break;
 
+#ifdef CONFIG_KDB
+			      case IPI_KDB_INTERRUPT:
+				if (!kdb_ipi(regs, NULL))
+					printk(KERN_ERR "kdb_ipi() rejected IPI_KDB_INTERRUPT\n");
+				break;
+#endif
+
 			      default:
 				printk(KERN_CRIT "Unknown IPI on CPU %d: %lu\n", this_cpu, which);
 				break;
@@ -373,3 +388,12 @@ setup_profiling_timer (unsigned int mult
 {
 	return -EINVAL;
 }
+
+#if defined(CONFIG_KDB)
+void
+smp_kdb_stop(void)
+{
+	if (!KDB_FLAG(NOIPI))
+		send_IPI_allbutself(IPI_KDB_INTERRUPT);
+}
+#endif	/* CONFIG_KDB */
diff -puN fs/proc/proc_misc.c~ia64-cpu-hotplug-cpu_present fs/proc/proc_misc.c
--- 25/fs/proc/proc_misc.c~ia64-cpu-hotplug-cpu_present	2004-04-25 22:29:52.760916688 -0700
+++ 25-akpm/fs/proc/proc_misc.c	2004-04-25 22:29:52.775914408 -0700
@@ -371,7 +371,7 @@ int show_stat(struct seq_file *p, void *
 	if (wall_to_monotonic.tv_nsec)
 		--jif;
 
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 		int j;
 
 		user += kstat_cpu(i).cpustat.user;
@@ -393,7 +393,7 @@ int show_stat(struct seq_file *p, void *
 		(unsigned long long)jiffies_64_to_clock_t(iowait),
 		(unsigned long long)jiffies_64_to_clock_t(irq),
 		(unsigned long long)jiffies_64_to_clock_t(softirq));
-	for_each_cpu(i) {
+	for_each_online_cpu(i) {
 
 		/* Copy values here to work around gcc-2.95.3, gcc-2.96 */
 		user = kstat_cpu(i).cpustat.user;
diff -puN include/asm-ia64/cpumask.h~ia64-cpu-hotplug-cpu_present include/asm-ia64/cpumask.h
--- 25/include/asm-ia64/cpumask.h~ia64-cpu-hotplug-cpu_present	2004-04-25 22:29:52.761916536 -0700
+++ 25-akpm/include/asm-ia64/cpumask.h	2004-04-25 22:29:52.775914408 -0700
@@ -1,6 +1,7 @@
 #ifndef _ASM_IA64_CPUMASK_H
 #define _ASM_IA64_CPUMASK_H
 
+#define ARCH_HAS_CPU_PRESENT_MAP
 #include <asm-generic/cpumask.h>
 
 #endif /* _ASM_IA64_CPUMASK_H */
diff -puN include/asm-ia64/smp.h~ia64-cpu-hotplug-cpu_present include/asm-ia64/smp.h
--- 25/include/asm-ia64/smp.h~ia64-cpu-hotplug-cpu_present	2004-04-25 22:29:52.763916232 -0700
+++ 25-akpm/include/asm-ia64/smp.h	2004-04-25 22:29:52.770915168 -0700
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
diff -puN include/linux/cpumask.h~ia64-cpu-hotplug-cpu_present include/linux/cpumask.h
--- 25/include/linux/cpumask.h~ia64-cpu-hotplug-cpu_present	2004-04-25 22:29:52.764916080 -0700
+++ 25-akpm/include/linux/cpumask.h	2004-04-25 22:29:52.772914864 -0700
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
@@ -23,13 +33,19 @@ extern cpumask_t cpu_possible_map;
 
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
+#define num_present_cpus		1
+
 #define cpu_online(cpu)			({ BUG_ON((cpu) != 0); 1; })
 #define cpu_possible(cpu)		({ BUG_ON((cpu) != 0); 1; })
+#define cpu_present(cpu)		({ BUG_ON((cpu) != 0); 1; })
 
 #define for_each_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
 #define for_each_online_cpu(cpu) for (cpu = 0; cpu < 1; cpu++)
diff -puN init/main.c~ia64-cpu-hotplug-cpu_present init/main.c
--- 25/init/main.c~ia64-cpu-hotplug-cpu_present	2004-04-25 22:29:52.766915776 -0700
+++ 25-akpm/init/main.c	2004-04-25 22:31:11.537940760 -0700
@@ -60,6 +60,10 @@
 #include <asm/smp.h>
 #endif
 
+#ifdef	CONFIG_KDB
+#include <linux/kdb.h>
+#endif	/* CONFIG_KDB */
+
 /*
  * Versions of gcc older than that listed below may actually compile
  * and link okay, but the end product can have subtle run time bugs.
@@ -147,6 +151,24 @@ static const char *panic_later, *panic_p
 
 __setup("profile=", profile_setup);
 
+#ifdef	CONFIG_KDB
+static int __init kdb_setup(char *str)
+{
+	if (strcmp(str, "on") == 0) {
+		kdb_on = 1;
+	} else if (strcmp(str, "off") == 0) {
+		kdb_on = 0;
+	} else if (strcmp(str, "early") == 0) {
+		kdb_on = 1;
+		kdb_flags |= KDB_FLAG_EARLYKDB;
+	} else
+		printk("kdb flag %s not recognised\n", str);
+	return 0;
+}
+
+__setup("kdb=", kdb_setup);
+#endif	/* CONFIG_KDB */
+
 static int __init obsolete_checksetup(char *line)
 {
 	struct obs_kernel_param *p;
@@ -362,7 +384,7 @@ static void __init smp_init(void)
 	for (i = 0; i < NR_CPUS; i++) {
 		if (num_online_cpus() >= max_cpus)
 			break;
-		if (cpu_possible(i) && !cpu_online(i)) {
+		if (cpu_possible(i) && !cpu_online(i) && cpu_present(i)) {
 			cpu_up(i);
 			j++;
 		}
@@ -505,6 +527,12 @@ asmlinkage void __init start_kernel(void
 	if (efi_enabled)
 		efi_enter_virtual_mode();
 #endif
+#ifdef CONFIG_KDB
+	kdb_init();
+	if (KDB_FLAG(EARLYKDB)) {
+		KDB_ENTER();
+	}
+#endif	/* CONFIG_KDB */
 	fork_init(num_physpages);
 	proc_caches_init();
 	buffer_init();
diff -puN kernel/cpu.c~ia64-cpu-hotplug-cpu_present kernel/cpu.c
--- 25/kernel/cpu.c~ia64-cpu-hotplug-cpu_present	2004-04-25 22:29:52.767915624 -0700
+++ 25-akpm/kernel/cpu.c	2004-04-25 22:29:52.773914712 -0700
@@ -169,7 +169,7 @@ int __devinit cpu_up(unsigned int cpu)
 	if ((ret = down_interruptible(&cpucontrol)) != 0)
 		return ret;
 
-	if (cpu_online(cpu)) {
+	if (cpu_online(cpu) || !cpu_present(cpu)) {
 		ret = -EINVAL;
 		goto out;
 	}

========================== end original patch ==========================


-- 
                          I won't rest till it's the best ...
                          Programmer, Linux Scalability
                          Paul Jackson <pj@sgi.com> 1.650.933.1373
