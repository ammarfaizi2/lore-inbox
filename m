Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319153AbSHTDmu>; Mon, 19 Aug 2002 23:42:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319154AbSHTDmu>; Mon, 19 Aug 2002 23:42:50 -0400
Received: from dp.samba.org ([66.70.73.150]:61140 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S319153AbSHTDm2>;
	Mon, 19 Aug 2002 23:42:28 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] re-xmit: arbitrary CPU bitmasks
Date: Tue, 20 Aug 2002 13:43:17 +1000
Message-Id: <20020819224657.8E5A72C0AC@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Requires previous s/bitmap_member/DECLARE_BITMAP/ patch.  Against
bitkeeper tree (thanks dwmw2).

Don't make me beg, that'd just embarrass us all...
Rusty.
--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.

Name: CPU mask patch
Author: Rusty Russell
Status: Tested on 2.5.31-cset-1.494 SMP
Depends: Misc/bitops.patch.gz

D: This patch changes cpu masks to a generic bitmap, and introduces
D: migrate_to_cpu() as a convenience function.

diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/i386/kernel/cpu/proc.c working-2.5.31-1.494-cpumask/arch/i386/kernel/cpu/proc.c
--- working-2.5.31-1.494-bitops/arch/i386/kernel/cpu/proc.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/i386/kernel/cpu/proc.c	2002-08-20 13:37:08.000000000 +1000
@@ -47,7 +47,7 @@ static int show_cpuinfo(struct seq_file 
 	int fpu_exception;
 
 #ifdef CONFIG_SMP
-	if (!(cpu_online_map & (1<<n)))
+	if (!cpu_online(n))
 		return 0;
 #endif
 	seq_printf(m, "processor\t: %d\n"
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/i386/kernel/cpuid.c working-2.5.31-1.494-cpumask/arch/i386/kernel/cpuid.c
--- working-2.5.31-1.494-bitops/arch/i386/kernel/cpuid.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/i386/kernel/cpuid.c	2002-08-20 13:37:08.000000000 +1000
@@ -134,7 +134,7 @@ static int cpuid_open(struct inode *inod
   int cpu = minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
 
-  if ( !(cpu_online_map & (1UL << cpu)) )
+  if ( !cpu_online(cpu) )
     return -ENXIO;		/* No such CPU */
   if ( c->cpuid_level < 0 )
     return -EIO;		/* CPUID not supported */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/i386/kernel/io_apic.c working-2.5.31-1.494-cpumask/arch/i386/kernel/io_apic.c
--- working-2.5.31-1.494-bitops/arch/i386/kernel/io_apic.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/i386/kernel/io_apic.c	2002-08-20 13:37:08.000000000 +1000
@@ -261,7 +261,7 @@ static inline void balance_irq(int irq)
 		rdtscl(random_number);
 		random_number &= 1;
 
-		allowed_mask = cpu_online_map & irq_affinity[irq];
+		allowed_mask = cpu_online_map[0] & irq_affinity[irq];
 		entry->timestamp = now;
 		entry->cpu = move(entry->cpu, allowed_mask, now, random_number);
 		set_ioapic_affinity(irq, 1 << entry->cpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/i386/kernel/irq.c working-2.5.31-1.494-cpumask/arch/i386/kernel/irq.c
--- working-2.5.31-1.494-bitops/arch/i386/kernel/irq.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/i386/kernel/irq.c	2002-08-20 13:37:08.000000000 +1000
@@ -848,7 +848,7 @@ static int irq_affinity_write_proc (stru
 	 * way to make the system unusable accidentally :-) At least
 	 * one online CPU still has to be targeted.
 	 */
-	if (!(new_value & cpu_online_map))
+	if (!(new_value & cpu_online_map[0]))
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/i386/kernel/msr.c working-2.5.31-1.494-cpumask/arch/i386/kernel/msr.c
--- working-2.5.31-1.494-bitops/arch/i386/kernel/msr.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/i386/kernel/msr.c	2002-08-20 13:37:08.000000000 +1000
@@ -234,7 +234,7 @@ static int msr_open(struct inode *inode,
   int cpu = minor(file->f_dentry->d_inode->i_rdev);
   struct cpuinfo_x86 *c = &(cpu_data)[cpu];
   
-  if ( !(cpu_online_map & (1UL << cpu)) )
+  if ( !cpu_online(cpu) )
     return -ENXIO;		/* No such CPU */
   if ( !cpu_has(c, X86_FEATURE_MSR) )
     return -EIO;		/* MSR not supported */
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/i386/kernel/smp.c working-2.5.31-1.494-cpumask/arch/i386/kernel/smp.c
--- working-2.5.31-1.494-bitops/arch/i386/kernel/smp.c	2002-07-27 15:24:35.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/i386/kernel/smp.c	2002-08-20 13:37:09.000000000 +1000
@@ -399,7 +399,7 @@ static void flush_tlb_others (unsigned l
 	 */
 	if (!cpumask)
 		BUG();
-	if ((cpumask & cpu_online_map) != cpumask)
+	if ((cpumask & cpu_online_map[0]) != cpumask)
 		BUG();
 	if (cpumask & (1 << smp_processor_id()))
 		BUG();
@@ -599,7 +599,7 @@ static void stop_this_cpu (void * dummy)
 	/*
 	 * Remove this CPU:
 	 */
-	clear_bit(smp_processor_id(), &cpu_online_map);
+	clear_bit(smp_processor_id(), cpu_online_map);
 	local_irq_disable();
 	disable_local_APIC();
 	if (cpu_data[smp_processor_id()].hlt_works_ok)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/i386/kernel/smpboot.c working-2.5.31-1.494-cpumask/arch/i386/kernel/smpboot.c
--- working-2.5.31-1.494-bitops/arch/i386/kernel/smpboot.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/i386/kernel/smpboot.c	2002-08-20 13:37:09.000000000 +1000
@@ -58,7 +58,7 @@ int smp_num_siblings = 1;
 int __initdata phys_proc_id[NR_CPUS]; /* Package ID of each logical CPU */
 
 /* Bitmask of currently online CPUs */
-unsigned long cpu_online_map;
+unsigned long cpu_online_map[1];
 
 static volatile unsigned long cpu_callin_map;
 volatile unsigned long cpu_callout_map;
@@ -458,7 +458,7 @@ int __init start_secondary(void *unused)
 	 * the local TLBs too.
 	 */
 	local_flush_tlb();
-	set_bit(smp_processor_id(), &cpu_online_map);
+	set_bit(smp_processor_id(), cpu_online_map);
 	wmb();
 	return cpu_idle();
 }
@@ -991,7 +991,7 @@ static void __init smp_boot_cpus(unsigne
 	/*
 	 * We have the boot CPU online for sure.
 	 */
-	set_bit(0, &cpu_online_map);
+	set_bit(0, cpu_online_map);
 	set_bit(0, &cpu_callout_map);
 	boot_cpu_logical_apicid = logical_smp_processor_id();
 	map_cpu_to_boot_apicid(0, boot_cpu_apicid);
@@ -1213,7 +1213,7 @@ int __devinit __cpu_up(unsigned int cpu)
 
 	/* Unleash the CPU! */
 	set_bit(cpu, &smp_commenced_mask);
-	while (!test_bit(cpu, &cpu_online_map))
+	while (!test_bit(cpu, cpu_online_map))
 		mb();
 	return 0;
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ia64/kernel/iosapic.c working-2.5.31-1.494-cpumask/arch/ia64/kernel/iosapic.c
--- working-2.5.31-1.494-bitops/arch/ia64/kernel/iosapic.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ia64/kernel/iosapic.c	2002-08-20 13:37:09.000000000 +1000
@@ -260,7 +260,7 @@ iosapic_set_affinity (unsigned int irq, 
 	char *addr;
 	int redir = (irq & (1<<31)) ? 1 : 0;
 
-	mask &= cpu_online_map;
+	mask &= cpu_online_map[0];
 
 	if (!mask || irq >= IA64_NUM_VECTORS)
 		return;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ia64/kernel/irq.c working-2.5.31-1.494-cpumask/arch/ia64/kernel/irq.c
--- working-2.5.31-1.494-bitops/arch/ia64/kernel/irq.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ia64/kernel/irq.c	2002-08-20 13:37:09.000000000 +1000
@@ -890,7 +890,7 @@ static int irq_affinity_write_proc (stru
 	 * way to make the system unusable accidentally :-) At least
 	 * one online CPU still has to be targeted.
 	 */
-	if (!(new_value & cpu_online_map))
+	if (!(new_value & cpu_online_map[0]))
 		return -EINVAL;
 
 	irq_desc(irq)->handler->set_affinity(irq | (redir?(1<<31):0), new_value);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ia64/kernel/perfmon.c working-2.5.31-1.494-cpumask/arch/ia64/kernel/perfmon.c
--- working-2.5.31-1.494-bitops/arch/ia64/kernel/perfmon.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ia64/kernel/perfmon.c	2002-08-20 13:37:09.000000000 +1000
@@ -107,7 +107,7 @@
 #define PFM_REG_RETFLAG_SET(flags, val)	do { flags &= ~PFM_REG_RETFL_MASK; flags |= (val); } while(0)
 
 #ifdef CONFIG_SMP
-#define cpu_is_online(i) (cpu_online_map & (1UL << i))
+#define cpu_is_online(i) (cpu_online_map[0] & (1UL << i))
 #else
 #define cpu_is_online(i)        (i==0)
 #endif
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ia64/kernel/setup.c working-2.5.31-1.494-cpumask/arch/ia64/kernel/setup.c
--- working-2.5.31-1.494-bitops/arch/ia64/kernel/setup.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ia64/kernel/setup.c	2002-08-20 13:37:09.000000000 +1000
@@ -444,7 +444,7 @@ static void *
 c_start (struct seq_file *m, loff_t *pos)
 {
 #ifdef CONFIG_SMP
-	while (*pos < NR_CPUS && !(cpu_online_map & (1UL << *pos)))
+	while (*pos < NR_CPUS && !(cpu_online(*pos)))
 		++*pos;
 #endif
 	return *pos < NR_CPUS ? cpu_data(*pos) : NULL;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ia64/kernel/smp.c working-2.5.31-1.494-cpumask/arch/ia64/kernel/smp.c
--- working-2.5.31-1.494-bitops/arch/ia64/kernel/smp.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ia64/kernel/smp.c	2002-08-20 13:37:09.000000000 +1000
@@ -89,7 +89,7 @@ stop_this_cpu (void)
 	/*
 	 * Remove this CPU:
 	 */
-	clear_bit(smp_processor_id(), &cpu_online_map);
+	clear_bit(smp_processor_id(), cpu_online_map);
 	max_xtp();
 	local_irq_disable();
 	cpu_halt();
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ia64/kernel/smpboot.c working-2.5.31-1.494-cpumask/arch/ia64/kernel/smpboot.c
--- working-2.5.31-1.494-bitops/arch/ia64/kernel/smpboot.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ia64/kernel/smpboot.c	2002-08-20 13:37:09.000000000 +1000
@@ -78,7 +78,7 @@ int cpucount;
 task_t *task_for_booting_cpu;
 
 /* Bitmask of currently online CPUs */
-volatile unsigned long cpu_online_map;
+volatile unsigned long cpu_online_map[1];
 unsigned long phys_cpu_present_map;
 
 /* which logical CPU number maps to which CPU (physical APIC ID) */
@@ -295,7 +295,7 @@ smp_callin (void)
 	cpuid = smp_processor_id();
 	phys_id = hard_smp_processor_id();
 
-	if (test_and_set_bit(cpuid, &cpu_online_map)) {
+	if (test_and_set_bit(cpuid, cpu_online_map)) {
 		printk("huh, phys CPU#0x%x, CPU#0x%x already present??\n", phys_id, cpuid);
 		BUG();
 	}
@@ -410,7 +410,7 @@ do_boot_cpu (int sapicid, int cpu)
 	} else {
 		printk(KERN_ERR "Processor 0x%x/0x%x is stuck.\n", cpu, sapicid);
 		ia64_cpu_to_sapicid[cpu] = -1;
-		clear_bit(cpu, &cpu_online_map);  /* was set in smp_callin() */
+		clear_bit(cpu, cpu_online_map);  /* was set in smp_callin() */
 		return -EINVAL;
 	}
 	return 0;
@@ -469,7 +469,7 @@ smp_prepare_cpus (unsigned int max_cpus)
 	/*
 	 * We have the boot CPU online for sure.
 	 */
-	set_bit(0, &cpu_online_map);
+	set_bit(0, cpu_online_map);
 	set_bit(0, &cpu_callin_map);
 
 	local_cpu_data->loops_per_jiffy = loops_per_jiffy;
@@ -485,7 +485,7 @@ smp_prepare_cpus (unsigned int max_cpus)
 	 */
 	if (!max_cpus || (max_cpus < -1)) {
 		printk(KERN_INFO "SMP mode deactivated.\n");
-		cpu_online_map = phys_cpu_present_map = 1;
+		cpu_online_map[0] = phys_cpu_present_map = 1;
 		return;
 	}
 }
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ia64/sn/io/sn1/ml_SN_intr.c working-2.5.31-1.494-cpumask/arch/ia64/sn/io/sn1/ml_SN_intr.c
--- working-2.5.31-1.494-bitops/arch/ia64/sn/io/sn1/ml_SN_intr.c	2002-06-20 01:28:47.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ia64/sn/io/sn1/ml_SN_intr.c	2002-08-20 13:37:10.000000000 +1000
@@ -44,7 +44,7 @@ void spldebug_log_event(int);
 #endif
 
 #ifdef CONFIG_SMP
-extern unsigned long cpu_online_map;
+extern unsigned long cpu_online_map[1];
 #endif
 #define cpu_allows_intr(cpu)	(1)
 // If I understand what's going on with this, 32 should work.
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ia64/sn/kernel/sn1/sn1_smp.c working-2.5.31-1.494-cpumask/arch/ia64/sn/kernel/sn1/sn1_smp.c
--- working-2.5.31-1.494-bitops/arch/ia64/sn/kernel/sn1/sn1_smp.c	2002-06-20 01:28:48.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ia64/sn/kernel/sn1/sn1_smp.c	2002-08-20 13:37:10.000000000 +1000
@@ -425,7 +425,7 @@ init_sn1_smp_config(void)
 {
 	if (!ia64_ptc_domain_info)  {
 		printk("SMP: Can't find PTC domain info. Forcing UP mode\n");
-		cpu_online_map = 1;
+		cpu_online_map[0] = 1;
 		return;
 	}
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc/kernel/irq.c working-2.5.31-1.494-cpumask/arch/ppc/kernel/irq.c
--- working-2.5.31-1.494-bitops/arch/ppc/kernel/irq.c	2002-08-11 15:31:31.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc/kernel/irq.c	2002-08-20 13:37:10.000000000 +1000
@@ -647,7 +647,7 @@ static int irq_affinity_write_proc (stru
 	 * are actually logical cpu #'s then we have no problem.
 	 *  -- Cort <cort@fsmlabs.com>
 	 */
-	if (!(new_value & cpu_online_map))
+	if (!(new_value & cpu_online_map[0]))
 		return -EINVAL;
 
 	irq_affinity[irq] = new_value;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc/kernel/setup.c working-2.5.31-1.494-cpumask/arch/ppc/kernel/setup.c
--- working-2.5.31-1.494-bitops/arch/ppc/kernel/setup.c	2002-08-11 15:31:31.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc/kernel/setup.c	2002-08-20 13:37:10.000000000 +1000
@@ -160,7 +160,7 @@ int show_cpuinfo(struct seq_file *m, voi
 	}
 
 #ifdef CONFIG_SMP
-	if (!(cpu_online_map & (1 << i)))
+	if (!cpu_online(i))
 		return 0;
 	pvr = cpu_data[i].pvr;
 	lpj = cpu_data[i].loops_per_jiffy;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc/kernel/smp.c working-2.5.31-1.494-cpumask/arch/ppc/kernel/smp.c
--- working-2.5.31-1.494-bitops/arch/ppc/kernel/smp.c	2002-08-11 15:31:31.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc/kernel/smp.c	2002-08-20 13:37:10.000000000 +1000
@@ -51,7 +51,7 @@ spinlock_t kernel_flag __cacheline_align
 unsigned int prof_multiplier[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
 unsigned int prof_counter[NR_CPUS] = { [1 ... NR_CPUS-1] = 1 };
 unsigned long cache_decay_ticks = HZ/100;
-unsigned long cpu_online_map = 1UL;
+unsigned long cpu_online_map[1] = { 1UL };
 unsigned long cpu_possible_map = 1UL;
 int smp_hw_index[NR_CPUS];
 struct thread_info *secondary_ti;
@@ -433,7 +433,7 @@ int __cpu_up(unsigned int cpu)
 	printk("Processor %d found.\n", cpu);
 
 	smp_ops->give_timebase();
-	set_bit(cpu, &cpu_online_map);
+	set_bit(cpu, cpu_online_map);
 	return 0;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc64/kernel/irq.c working-2.5.31-1.494-cpumask/arch/ppc64/kernel/irq.c
--- working-2.5.31-1.494-bitops/arch/ppc64/kernel/irq.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc64/kernel/irq.c	2002-08-20 13:37:10.000000000 +1000
@@ -457,7 +457,7 @@ static inline void balance_irq(int irq)
 		random_number = mftb();
 		random_number &= 1;
 
-		allowed_mask = cpu_online_map & irq_affinity[irq];
+		allowed_mask = cpu_online_map[0] & irq_affinity[irq];
 		entry->timestamp = now;
 		entry->cpu = move(entry->cpu, allowed_mask, now, random_number);
 		irq_desc[irq].handler->set_affinity(irq, 1 << entry->cpu);
@@ -717,7 +717,7 @@ static int irq_affinity_write_proc (stru
 	 * way to make the system unusable accidentally :-) At least
 	 * one online CPU still has to be targeted.
 	 */
-	if (!(new_value & cpu_online_map))
+	if (!(new_value & cpu_online_map[0]))
 		return -EINVAL;
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc64/kernel/open_pic.c working-2.5.31-1.494-cpumask/arch/ppc64/kernel/open_pic.c
--- working-2.5.31-1.494-bitops/arch/ppc64/kernel/open_pic.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc64/kernel/open_pic.c	2002-08-20 13:37:10.000000000 +1000
@@ -506,7 +506,7 @@ static void openpic_set_spurious(u_int v
 void openpic_init_processor(u_int cpumask)
 {
 	openpic_write(&OpenPIC->Global.Processor_Initialization,
-		      cpumask & cpu_online_map);
+		      cpumask & cpu_online_map[0]);
 }
 
 #ifdef CONFIG_SMP
@@ -540,7 +540,7 @@ void openpic_cause_IPI(u_int ipi, u_int 
 	CHECK_THIS_CPU;
 	check_arg_ipi(ipi);
 	openpic_write(&OpenPIC->THIS_CPU.IPI_Dispatch(ipi),
-		      cpumask & cpu_online_map);
+		      cpumask & cpu_online_map[0]);
 }
 
 void openpic_request_IPIs(void)
@@ -625,7 +625,7 @@ static void __init openpic_maptimer(u_in
 {
 	check_arg_timer(timer);
 	openpic_write(&OpenPIC->Global.Timer[timer].Destination,
-		      cpumask & cpu_online_map);
+		      cpumask & cpu_online_map[0]);
 }
 
 
@@ -748,7 +748,7 @@ static void openpic_end_irq(unsigned int
 
 static void openpic_set_affinity(unsigned int irq_nr, unsigned long cpumask)
 {
-	openpic_mapirq(irq_nr - open_pic_irq_offset, cpumask & cpu_online_map);
+	openpic_mapirq(irq_nr - open_pic_irq_offset, cpumask & cpu_online_map[0]);
 }
 
 #ifdef CONFIG_SMP
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc64/kernel/prom.c working-2.5.31-1.494-cpumask/arch/ppc64/kernel/prom.c
--- working-2.5.31-1.494-bitops/arch/ppc64/kernel/prom.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc64/kernel/prom.c	2002-08-20 13:37:10.000000000 +1000
@@ -1350,7 +1350,7 @@ prom_init(unsigned long r3, unsigned lon
 		&getprop_rval, sizeof(getprop_rval));
 	_prom->cpu = (int)(unsigned long)getprop_rval;
 	_xPaca[_prom->cpu].active = 1;
-	RELOC(cpu_online_map) = 1 << _prom->cpu;
+	RELOC(cpu_online_map[0]) = 1 << _prom->cpu;
 	RELOC(boot_cpuid) = _prom->cpu;
 
 #ifdef DEBUG_PROM
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc64/kernel/setup.c working-2.5.31-1.494-cpumask/arch/ppc64/kernel/setup.c
--- working-2.5.31-1.494-bitops/arch/ppc64/kernel/setup.c	2002-07-25 10:13:04.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc64/kernel/setup.c	2002-08-20 13:37:10.000000000 +1000
@@ -271,7 +271,7 @@ static int show_cpuinfo(struct seq_file 
 		return 0;
 	}
 
-	if (!(cpu_online_map & (1<<cpu_id)))
+	if (!cpu_online(cpu_id))
 		return 0;
 #endif
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc64/kernel/smp.c working-2.5.31-1.494-cpumask/arch/ppc64/kernel/smp.c
--- working-2.5.31-1.494-bitops/arch/ppc64/kernel/smp.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc64/kernel/smp.c	2002-08-20 13:37:10.000000000 +1000
@@ -55,7 +55,7 @@ spinlock_t kernel_flag __cacheline_align
 unsigned long cache_decay_ticks;
 
 /* initialised so it doesnt end up in bss */
-unsigned long cpu_online_map = 0;
+unsigned long cpu_online_map[1] = { 0 };
 int boot_cpuid = 0;
 
 static struct smp_ops_t *smp_ops;
@@ -647,7 +647,7 @@ int __devinit __cpu_up(unsigned int cpu)
 
 	if (smp_ops->give_timebase)
 		smp_ops->give_timebase();
-	set_bit(cpu, &cpu_online_map);
+	set_bit(cpu, cpu_online_map);
 	return 0;
 }
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/ppc64/kernel/xics.c working-2.5.31-1.494-cpumask/arch/ppc64/kernel/xics.c
--- working-2.5.31-1.494-bitops/arch/ppc64/kernel/xics.c	2002-08-20 11:27:06.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/ppc64/kernel/xics.c	2002-08-20 13:37:10.000000000 +1000
@@ -451,7 +451,7 @@ void xics_set_affinity(unsigned int virq
 	if (cpumask == 0xffffffff) {
 		newmask = default_distrib_server;
 	} else {
-		if (!(cpumask & cpu_online_map))
+		if (!(cpumask & cpu_online_map[0]))
 			goto out;
 		newmask = find_first_bit(&cpumask, 32);
 	}
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/sparc64/kernel/irq.c working-2.5.31-1.494-cpumask/arch/sparc64/kernel/irq.c
--- working-2.5.31-1.494-bitops/arch/sparc64/kernel/irq.c	2002-08-11 15:31:33.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/sparc64/kernel/irq.c	2002-08-20 13:37:11.000000000 +1000
@@ -662,9 +662,9 @@ static inline void redirect_intr(int cpu
 	unsigned long cpu_mask = get_smpaff_in_irqaction(ap);
 	unsigned int buddy, ticks;
 
-	cpu_mask &= cpu_online_map;
+	cpu_mask &= cpu_online_map[0];
 	if (cpu_mask == 0)
-		cpu_mask = cpu_online_map;
+		cpu_mask = cpu_online_map[0];
 
 	if (this_is_starfire != 0 ||
 	    bp->pil >= 10 || current->pid == 0)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/arch/sparc64/kernel/smp.c working-2.5.31-1.494-cpumask/arch/sparc64/kernel/smp.c
--- working-2.5.31-1.494-bitops/arch/sparc64/kernel/smp.c	2002-08-11 15:31:33.000000000 +1000
+++ working-2.5.31-1.494-cpumask/arch/sparc64/kernel/smp.c	2002-08-20 13:37:11.000000000 +1000
@@ -50,7 +50,7 @@ static unsigned char boot_cpu_id;
 spinlock_t kernel_flag __cacheline_aligned_in_smp = SPIN_LOCK_UNLOCKED;
 
 atomic_t sparc64_num_cpus_online = ATOMIC_INIT(0);
-unsigned long cpu_online_map = 0;
+unsigned long cpu_online_map[1] = { 0 };
 atomic_t sparc64_num_cpus_possible = ATOMIC_INIT(0);
 unsigned long phys_cpu_present_map = 0;
 static unsigned long smp_commenced_mask;
@@ -202,7 +202,7 @@ void __init smp_callin(void)
 	while (!test_bit(cpuid, &smp_commenced_mask))
 		membar("#LoadLoad");
 
-	set_bit(cpuid, &cpu_online_map);
+	set_bit(cpuid, cpu_online_map);
 	atomic_inc(&sparc64_num_cpus_online);
 }
 
@@ -463,7 +463,7 @@ static void smp_cross_call_masked(unsign
 {
 	u64 data0 = (((u64)ctx)<<32 | (((u64)func) & 0xffffffff));
 
-	mask &= cpu_online_map;
+	mask &= cpu_online_map[0];
 	mask &= ~(1UL<<smp_processor_id());
 
 	if (tlb_type == spitfire)
@@ -475,7 +475,7 @@ static void smp_cross_call_masked(unsign
 
 /* Send cross call to all processors except self. */
 #define smp_cross_call(func, ctx, data1, data2) \
-	smp_cross_call_masked(func, ctx, data1, data2, cpu_online_map)
+	smp_cross_call_masked(func, ctx, data1, data2, cpu_online_map[0])
 
 struct call_data_struct {
 	void (*func) (void *info);
@@ -593,7 +593,7 @@ void smp_flush_dcache_page_impl(struct p
 #endif
 	if (cpu == smp_processor_id()) {
 		__local_flush_dcache_page(page);
-	} else if ((cpu_online_map & mask) != 0) {
+	} else if ((cpu_online_map[0] & mask) != 0) {
 		u64 data0;
 
 		if (tlb_type == spitfire) {
@@ -620,7 +620,7 @@ void smp_flush_dcache_page_impl(struct p
 
 void flush_dcache_page_all(struct mm_struct *mm, struct page *page)
 {
-	unsigned long mask = cpu_online_map & ~(1UL << smp_processor_id());
+	unsigned long mask = cpu_online_map[0] & ~(1UL << smp_processor_id());
 	u64 data0;
 
 #ifdef CONFIG_DEBUG_DCFLUSH
@@ -653,7 +653,7 @@ void smp_receive_signal(int cpu)
 {
 	unsigned long mask = 1UL << cpu;
 
-	if ((cpu_online_map & mask) != 0) {
+	if ((cpu_online_map[0] & mask) != 0) {
 		u64 data0 = (((u64)&xcall_receive_signal) & 0xffffffff);
 
 		if (tlb_type == spitfire)
@@ -1088,7 +1088,7 @@ void __init smp_tick_init(void)
 	}
 
 	atomic_inc(&sparc64_num_cpus_online);
-	set_bit(boot_cpu_id, &cpu_online_map);
+	set_bit(boot_cpu_id, cpu_online_map);
 	prom_cpu_nodes[boot_cpu_id] = linux_cpus[0].prom_node;
 	prof_counter(boot_cpu_id) = prof_multiplier(boot_cpu_id) = 1;
 }
@@ -1251,9 +1251,9 @@ int __devinit __cpu_up(unsigned int cpu)
 
 	if (!ret) {
 		set_bit(cpu, &smp_commenced_mask);
-		while (!test_bit(cpu, &cpu_online_map))
+		while (!test_bit(cpu, cpu_online_map))
 			mb();
-		if (!test_bit(cpu, &cpu_online_map))
+		if (!test_bit(cpu, cpu_online_map))
 			ret = -ENODEV;
 	}
 	return ret;
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/include/asm-i386/smp.h working-2.5.31-1.494-cpumask/include/asm-i386/smp.h
--- working-2.5.31-1.494-bitops/include/asm-i386/smp.h	2002-08-20 11:27:09.000000000 +1000
+++ working-2.5.31-1.494-cpumask/include/asm-i386/smp.h	2002-08-20 13:37:42.000000000 +1000
@@ -26,7 +26,7 @@
 #  define TARGET_CPUS 0xf     /* all CPUs in *THIS* quad */
 #  define INT_DELIVERY_MODE 0     /* physical delivery on LOCAL quad */
 # else
-#  define TARGET_CPUS cpu_online_map
+#  define TARGET_CPUS cpu_online_map[0]
 #  define INT_DELIVERY_MODE 1     /* logical delivery broadcast to all procs */
 # endif
 #else
@@ -53,7 +53,7 @@
  
 extern void smp_alloc_memory(void);
 extern unsigned long phys_cpu_present_map;
-extern unsigned long cpu_online_map;
+extern unsigned long cpu_online_map[1];
 extern volatile unsigned long smp_invalidate_needed;
 extern int pic_mode;
 extern int smp_num_siblings;
@@ -86,20 +86,23 @@ extern volatile int logical_apicid_to_cp
 
 extern volatile unsigned long cpu_callout_map;
 
+#if NR_CPUS > 32
+#error asm/smp.h needs fixing for > 32 CPUS.
+#endif
+
 #define cpu_possible(cpu) (cpu_callout_map & (1<<(cpu)))
-#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+#define cpu_online(cpu) (cpu_online_map[0] & (1<<(cpu)))
 
 extern inline unsigned int num_online_cpus(void)
 {
-	return hweight32(cpu_online_map);
+	return hweight32(cpu_online_map[0]);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+static inline int any_online_cpu(const unsigned long *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-
-	return -1;
+	if ((mask[0] & cpu_online_map[0]) != 0UL)
+		return __ffs(mask[0] & cpu_online_map[0]);
+	return NR_CPUS;
 }
 
 static __inline int hard_smp_processor_id(void)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/include/asm-ia64/smp.h working-2.5.31-1.494-cpumask/include/asm-ia64/smp.h
--- working-2.5.31-1.494-bitops/include/asm-ia64/smp.h	2002-08-20 11:27:09.000000000 +1000
+++ working-2.5.31-1.494-cpumask/include/asm-ia64/smp.h	2002-08-20 13:37:42.000000000 +1000
@@ -38,7 +38,7 @@ extern struct smp_boot_data {
 extern char no_int_routing __initdata;
 
 extern unsigned long phys_cpu_present_map;
-extern volatile unsigned long cpu_online_map;
+extern volatile unsigned long cpu_online_map[1];
 extern unsigned long ipi_base_addr;
 extern unsigned char smp_int_redirect;
 
@@ -47,21 +47,24 @@ extern volatile int ia64_cpu_to_sapicid[
 
 extern unsigned long ap_wakeup_vector;
 
+#if NR_CPUS > 64
+#error asm/smp.h needs fixing for > 64 CPUS.
+#endif
+
 #define cpu_possible(cpu)	(phys_cpu_present_map & (1UL << (cpu)))
-#define cpu_online(cpu)		(cpu_online_map & (1UL << (cpu)))
+#define cpu_online(cpu)		(cpu_online_map[0] & (1UL << (cpu)))
 
 static inline unsigned int
 num_online_cpus (void)
 {
-	return hweight64(cpu_online_map);
+	return hweight64(cpu_online_map[0]);
 }
 
-static inline int
-any_online_cpu (unsigned int mask)
+static inline int any_online_cpu(const unsigned long *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-	return -1;
+	if ((mask[0] & cpu_online_map[0]) != 0UL)
+		return __ffs(mask[0] & cpu_online_map[0]);
+	return NR_CPUS;
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/include/asm-ppc/smp.h working-2.5.31-1.494-cpumask/include/asm-ppc/smp.h
--- working-2.5.31-1.494-bitops/include/asm-ppc/smp.h	2002-07-27 15:24:39.000000000 +1000
+++ working-2.5.31-1.494-cpumask/include/asm-ppc/smp.h	2002-08-20 13:37:42.000000000 +1000
@@ -31,7 +31,7 @@ struct cpuinfo_PPC {
 };
 
 extern struct cpuinfo_PPC cpu_data[];
-extern unsigned long cpu_online_map;
+extern unsigned long cpu_online_map[1];
 extern unsigned long cpu_possible_map;
 extern unsigned long smp_proc_in_lock[];
 extern volatile unsigned long cpu_callin_map[];
@@ -48,20 +48,23 @@ extern void smp_local_timer_interrupt(st
 
 #define smp_processor_id() (current_thread_info()->cpu)
 
-#define cpu_online(cpu) (cpu_online_map & (1<<(cpu)))
+#if NR_CPUS > 32
+#error asm/smp.h needs fixing for > 32 CPUS.
+#endif
+
+#define cpu_online(cpu) (cpu_online_map[0] & (1<<(cpu)))
 #define cpu_possible(cpu) (cpu_possible_map & (1<<(cpu)))
 
 extern inline unsigned int num_online_cpus(void)
 {
-	return hweight32(cpu_online_map);
+	return hweight32(cpu_online_map[0]);
 }
 
-extern inline int any_online_cpu(unsigned int mask)
+static inline int any_online_cpu(const unsigned long *mask)
 {
-	if (mask & cpu_online_map)
-		return __ffs(mask & cpu_online_map);
-
-	return -1;
+	if ((mask[0] & cpu_online_map[0]) != 0UL)
+		return __ffs(mask[0] & cpu_online_map[0]);
+	return NR_CPUS;
 }
 
 extern int __cpu_up(unsigned int cpu);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/include/asm-ppc64/smp.h working-2.5.31-1.494-cpumask/include/asm-ppc64/smp.h
--- working-2.5.31-1.494-bitops/include/asm-ppc64/smp.h	2002-08-20 11:27:09.000000000 +1000
+++ working-2.5.31-1.494-cpumask/include/asm-ppc64/smp.h	2002-08-20 13:37:42.000000000 +1000
@@ -27,7 +27,7 @@
 
 #include <asm/paca.h>
 
-extern unsigned long cpu_online_map;
+extern unsigned long cpu_online_map[1];
 
 extern void smp_message_pass(int target, int msg, unsigned long data, int wait);
 extern void smp_send_tlb_invalidate(int);
@@ -38,7 +38,11 @@ extern void smp_send_reschedule_all(void
 
 #define NO_PROC_ID		0xFF            /* No processor magic marker */
 
-#define cpu_online(cpu)	test_bit((cpu), &cpu_online_map)
+#if NR_CPUS > 64
+#error asm/smp.h needs fixing for > 64 CPUS.
+#endif
+
+#define cpu_online(cpu)	test_bit((cpu), cpu_online_map)
 
 #define cpu_possible(cpu)	paca[cpu].active
 
@@ -47,11 +51,18 @@ static inline int num_online_cpus(void)
 	int i, nr = 0;
 
 	for (i = 0; i < NR_CPUS; i++)
-		nr += test_bit(i, &cpu_online_map);
+		nr += test_bit(i, cpu_online_map);
 
 	return nr;
 }
 
+static inline int any_online_cpu(const unsigned long *mask)
+{
+	if ((mask[0] & cpu_online_map[0]) != 0UL)
+		return __ffs(mask[0] & cpu_online_map[0]);
+	return NR_CPUS;
+}
+
 extern volatile unsigned long cpu_callin_map[NR_CPUS];
 
 #define smp_processor_id() (get_paca()->xPacaIndex)
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/include/asm-sparc64/smp.h working-2.5.31-1.494-cpumask/include/asm-sparc64/smp.h
--- working-2.5.31-1.494-bitops/include/asm-sparc64/smp.h	2002-08-11 15:31:42.000000000 +1000
+++ working-2.5.31-1.494-cpumask/include/asm-sparc64/smp.h	2002-08-20 13:37:43.000000000 +1000
@@ -69,8 +69,8 @@ extern unsigned char boot_cpu_id;
 extern unsigned long phys_cpu_present_map;
 #define cpu_possible(cpu)	(phys_cpu_present_map & (1UL << (cpu)))
 
-extern unsigned long cpu_online_map;
-#define cpu_online(cpu)		(cpu_online_map & (1UL << (cpu)))
+extern unsigned long cpu_online_map[1];
+#define cpu_online(cpu)		(cpu_online_map[0] & (1UL << (cpu)))
 
 extern atomic_t sparc64_num_cpus_online;
 #define num_online_cpus()	(atomic_read(&sparc64_num_cpus_online))
@@ -78,11 +78,11 @@ extern atomic_t sparc64_num_cpus_online;
 extern atomic_t sparc64_num_cpus_possible;
 #define num_possible_cpus()	(atomic_read(&sparc64_num_cpus_possible))
 
-static inline int any_online_cpu(unsigned long mask)
+static inline int any_online_cpu(const unsigned long *mask)
 {
-	if ((mask &= cpu_online_map) != 0UL)
-		return __ffs(mask);
-	return -1;
+	if ((mask[0] & cpu_online_map[0]) != 0UL)
+		return __ffs(mask[0] & cpu_online_map[0]);
+	return NR_CPUS;
 }
 
 /*
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/include/linux/init_task.h working-2.5.31-1.494-cpumask/include/linux/init_task.h
--- working-2.5.31-1.494-bitops/include/linux/init_task.h	2002-08-20 11:27:09.000000000 +1000
+++ working-2.5.31-1.494-cpumask/include/linux/init_task.h	2002-08-20 13:37:46.000000000 +1000
@@ -48,7 +48,7 @@
 	.prio		= MAX_PRIO-20,					\
 	.static_prio	= MAX_PRIO-20,					\
 	.policy		= SCHED_NORMAL,					\
-	.cpus_allowed	= -1,						\
+	.cpus_allowed	= CPU_MASK_ALL,					\
 	.mm		= NULL,						\
 	.active_mm	= &init_mm,					\
 	.run_list	= LIST_HEAD_INIT(tsk.run_list),			\
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/include/linux/sched.h working-2.5.31-1.494-cpumask/include/linux/sched.h
--- working-2.5.31-1.494-bitops/include/linux/sched.h	2002-08-20 11:27:09.000000000 +1000
+++ working-2.5.31-1.494-cpumask/include/linux/sched.h	2002-08-20 13:37:47.000000000 +1000
@@ -14,12 +14,14 @@ extern unsigned long event;
 #include <linux/jiffies.h>
 #include <linux/rbtree.h>
 #include <linux/thread_info.h>
+#include <linux/bitops.h>
 
 #include <asm/system.h>
 #include <asm/semaphore.h>
 #include <asm/page.h>
 #include <asm/ptrace.h>
 #include <asm/mmu.h>
+#include <asm/current.h>
 
 #include <linux/smp.h>
 #include <linux/sem.h>
@@ -266,7 +268,7 @@ struct task_struct {
 	unsigned long sleep_timestamp;
 
 	unsigned long policy;
-	unsigned long cpus_allowed;
+	DECLARE_BITMAP(cpus_allowed, NR_CPUS);
 	unsigned int time_slice, first_time_slice;
 
 	struct list_head tasks;
@@ -417,10 +419,20 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define _STK_LIM	(8*1024*1024)
 
 #if CONFIG_SMP
-extern void set_cpus_allowed(task_t *p, unsigned long new_mask);
+extern void set_cpus_allowed(task_t *p, const unsigned long new_mask[]);
 #else
 # define set_cpus_allowed(p, new_mask) do { } while (0)
 #endif
+#define CPU_MASK_NONE { 0 }
+#define CPU_MASK_ALL { [0 ... BITS_TO_LONG(NR_CPUS)-1] = ~0UL }
+
+static inline void migrate_to_cpu(unsigned int cpu)
+{
+	DECLARE_BITMAP(mask, NR_CPUS) = CPU_MASK_NONE;
+	BUG_ON(!cpu_online(cpu));
+	__set_bit(cpu, mask);
+	set_cpus_allowed(current, mask);
+}
 
 extern void set_user_nice(task_t *p, long nice);
 extern int task_prio(task_t *p);
@@ -485,8 +497,6 @@ static inline struct task_struct *find_t
 extern struct user_struct * alloc_uid(uid_t);
 extern void free_uid(struct user_struct *);
 
-#include <asm/current.h>
-
 extern unsigned long itimer_ticks;
 extern unsigned long itimer_next;
 extern void do_timer(struct pt_regs *);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/include/linux/smp.h working-2.5.31-1.494-cpumask/include/linux/smp.h
--- working-2.5.31-1.494-bitops/include/linux/smp.h	2002-08-20 11:27:09.000000000 +1000
+++ working-2.5.31-1.494-cpumask/include/linux/smp.h	2002-08-20 13:37:47.000000000 +1000
@@ -93,10 +93,11 @@ int cpu_up(unsigned int cpu);
 #define smp_call_function(func,info,retry,wait)	({ 0; })
 static inline void smp_send_reschedule(int cpu) { }
 static inline void smp_send_reschedule_all(void) { }
-#define cpu_online_map				1
+#define cpu_online_map				((unsigned long[1]){ 1 })
 #define cpu_online(cpu)				({ cpu; 1; })
 #define num_online_cpus()			1
 #define num_booting_cpus()			1
+#define any_online_cpu(mask) ((*(mask) & 1) ? 0 : 1)
 
 struct notifier_block;
 
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/kernel/sched.c working-2.5.31-1.494-cpumask/kernel/sched.c
--- working-2.5.31-1.494-bitops/kernel/sched.c	2002-08-20 11:27:09.000000000 +1000
+++ working-2.5.31-1.494-cpumask/kernel/sched.c	2002-08-20 13:37:47.000000000 +1000
@@ -29,6 +29,7 @@
 #include <linux/security.h>
 #include <linux/notifier.h>
 #include <linux/delay.h>
+#include <linux/bitops.h>
 
 /*
  * Convert user-nice values [ -20 ... 0 ... 19 ]
@@ -414,7 +415,7 @@ repeat_lock_task:
 		 */
 		if (unlikely(sync && !task_running(rq, p) &&
 			(task_cpu(p) != smp_processor_id()) &&
-			(p->cpus_allowed & (1UL << smp_processor_id())))) {
+			(test_bit(smp_processor_id(), p->cpus_allowed)))) {
 
 			set_task_cpu(p, smp_processor_id());
 			task_rq_unlock(rq, &flags);
@@ -788,7 +789,7 @@ skip_queue:
 #define CAN_MIGRATE_TASK(p,rq,this_cpu)					\
 	((jiffies - (p)->sleep_timestamp > cache_decay_ticks) &&	\
 		!task_running(rq, p) &&					\
-			((p)->cpus_allowed & (1UL << (this_cpu))))
+			(test_bit(smp_processor_id(), p->cpus_allowed)))
 
 	curr = curr->prev;
 
@@ -1541,7 +1542,7 @@ out_unlock:
 asmlinkage int sys_sched_setaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
-	unsigned long new_mask;
+	DECLARE_BITMAP(new_mask, NR_CPUS);
 	int retval;
 	task_t *p;
 
@@ -1551,8 +1552,7 @@ asmlinkage int sys_sched_setaffinity(pid
 	if (copy_from_user(&new_mask, user_mask_ptr, sizeof(new_mask)))
 		return -EFAULT;
 
-	new_mask &= cpu_online_map;
-	if (!new_mask)
+	if (any_online_cpu(new_mask) == NR_CPUS)
 		return -EINVAL;
 
 	read_lock(&tasklist_lock);
@@ -1593,8 +1593,8 @@ out_unlock:
 asmlinkage int sys_sched_getaffinity(pid_t pid, unsigned int len,
 				      unsigned long *user_mask_ptr)
 {
-	unsigned int real_len;
-	unsigned long mask;
+	unsigned int real_len, i;
+	DECLARE_BITMAP(mask, NR_CPUS);
 	int retval;
 	task_t *p;
 
@@ -1610,7 +1610,8 @@ asmlinkage int sys_sched_getaffinity(pid
 		goto out_unlock;
 
 	retval = 0;
-	mask = p->cpus_allowed & cpu_online_map;
+	for (i = 0; i < ARRAY_SIZE(mask); i++)
+		mask[i] = (p->cpus_allowed[i] & cpu_online_map[i]);
 
 out_unlock:
 	read_unlock(&tasklist_lock);
@@ -1913,7 +1914,7 @@ typedef struct {
  * task must not exit() & deallocate itself prematurely.  The
  * call is not atomic; no spinlocks may be held.
  */
-void set_cpus_allowed(task_t *p, unsigned long new_mask)
+void set_cpus_allowed(task_t *p, const unsigned long new_mask[])
 {
 	unsigned long flags;
 	migration_req_t req;
@@ -1927,12 +1928,12 @@ void set_cpus_allowed(task_t *p, unsigne
 
 	preempt_disable();
 	rq = task_rq_lock(p, &flags);
-	p->cpus_allowed = new_mask;
+	memcpy(p->cpus_allowed, new_mask, sizeof(p->cpus_allowed));
 	/*
 	 * Can the task run on the task's current CPU? If not then
 	 * migrate the thread off to a proper CPU.
 	 */
-	if (new_mask & (1UL << task_cpu(p))) {
+	if (test_bit(task_cpu(p), new_mask)) {
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1941,7 +1942,7 @@ void set_cpus_allowed(task_t *p, unsigne
 	 * it is sufficient to simply update the task's cpu field.
 	 */
 	if (!p->array && !task_running(rq, p)) {
-		set_task_cpu(p, __ffs(p->cpus_allowed));
+		set_task_cpu(p, any_online_cpu(p->cpus_allowed));
 		task_rq_unlock(rq, &flags);
 		goto out;
 	}
@@ -1971,7 +1972,7 @@ static int migration_thread(void * data)
 	sigfillset(&current->blocked);
 	set_fs(KERNEL_DS);
 
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 
 	/*
 	 * Migration can happen without a migration thread on the
@@ -2009,7 +2010,7 @@ static int migration_thread(void * data)
 		spin_unlock_irqrestore(&rq->lock, flags);
 
 		p = req->task;
-		cpu_dest = __ffs(p->cpus_allowed);
+		cpu_dest = any_online_cpu(p->cpus_allowed);
 		rq_dest = cpu_rq(cpu_dest);
 repeat:
 		cpu_src = task_cpu(p);
diff -urpN --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.31-1.494-bitops/kernel/softirq.c working-2.5.31-1.494-cpumask/kernel/softirq.c
--- working-2.5.31-1.494-bitops/kernel/softirq.c	2002-08-20 11:27:09.000000000 +1000
+++ working-2.5.31-1.494-cpumask/kernel/softirq.c	2002-08-20 13:37:47.000000000 +1000
@@ -361,8 +361,7 @@ static int ksoftirqd(void * __bind_cpu)
 	current->flags |= PF_IOTHREAD;
 	sigfillset(&current->blocked);
 
-	/* Migrate to the right CPU */
-	set_cpus_allowed(current, 1UL << cpu);
+	migrate_to_cpu(cpu);
 	if (smp_processor_id() != cpu)
 		BUG();
 
