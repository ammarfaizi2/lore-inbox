Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932321AbWEHFsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932321AbWEHFsD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 May 2006 01:48:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932322AbWEHFrc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 May 2006 01:47:32 -0400
Received: from mga02.intel.com ([134.134.136.20]:43637 "EHLO
	orsmga101-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S932321AbWEHFq5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 May 2006 01:46:57 -0400
X-IronPort-AV: i="4.05,99,1146466800"; 
   d="scan'208"; a="32948436:sNHT145480020"
Subject: [PATCH 2/10] make some arch depend routines accept cpumask
From: Shaohua Li <shaohua.li@intel.com>
To: lkml <linux-kernel@vger.kernel.org>
Cc: Zwane Mwaikambo <zwane@linuxpower.ca>,
       Srivatsa Vaddagiri <vatsa@in.ibm.com>, Ashok Raj <ashok.raj@intel.com>,
       Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 08 May 2006 13:45:42 +0800
Message-Id: <1147067142.2760.80.camel@sli10-desk.sh.intel.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.2 (2.2.2-5) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Make __cpu_disable/__cpu_die accept 'cpumask_t' parameter.

Signed-off-by: Ashok Raj <ashok.raj@intel.com> 
Signed-off-by: Shaohua Li <shaohua.li@intel.com>
---

 linux-2.6.17-rc3-root/arch/arm/kernel/smp.c        |    7 +++++--
 linux-2.6.17-rc3-root/arch/i386/kernel/smpboot.c   |   10 ++++++----
 linux-2.6.17-rc3-root/arch/ia64/kernel/smpboot.c   |   10 ++++++----
 linux-2.6.17-rc3-root/arch/powerpc/kernel/smp.c    |    7 +++++--
 linux-2.6.17-rc3-root/arch/s390/kernel/smp.c       |    7 +++++--
 linux-2.6.17-rc3-root/arch/x86_64/kernel/smpboot.c |   10 ++++++----
 linux-2.6.17-rc3-root/include/asm-arm/smp.h        |    4 ++--
 linux-2.6.17-rc3-root/include/asm-i386/smp.h       |    4 ++--
 linux-2.6.17-rc3-root/include/asm-ia64/smp.h       |    4 ++--
 linux-2.6.17-rc3-root/include/asm-powerpc/smp.h    |    4 ++--
 linux-2.6.17-rc3-root/include/asm-s390/smp.h       |    4 ++--
 linux-2.6.17-rc3-root/include/asm-x86_64/smp.h     |    4 ++--
 linux-2.6.17-rc3-root/kernel/cpu.c                 |    4 ++--
 13 files changed, 47 insertions(+), 32 deletions(-)

diff -puN arch/arm/kernel/smp.c~cpu_routines_accept_cpumask arch/arm/kernel/smp.c
--- linux-2.6.17-rc3/arch/arm/kernel/smp.c~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/arm/kernel/smp.c	2006-05-07 07:44:55.000000000 +0800
@@ -163,12 +163,13 @@ int __cpuinit __cpu_up(unsigned int cpu)
 /*
  * __cpu_disable runs on the processor to be shutdown.
  */
-int __cpuexit __cpu_disable(void)
+int __cpuexit __cpu_disable(cpumask_t remove_mask)
 {
 	unsigned int cpu = smp_processor_id();
 	struct task_struct *p;
 	int ret;
 
+	BUG_ON(cpus_weight(remove_mask) != 1);
 	ret = mach_cpu_disable(cpu);
 	if (ret)
 		return ret;
@@ -210,8 +211,10 @@ int __cpuexit __cpu_disable(void)
  * called on the thread which is asking for a CPU to be shutdown -
  * waits until shutdown has completed, or it is timed out.
  */
-void __cpuexit __cpu_die(unsigned int cpu)
+void __cpuexit __cpu_die(cpumask_t remove_mask)
 {
+	int cpu = first_cpu(remove_mask);
+
 	if (!platform_cpu_kill(cpu))
 		printk("CPU%u: unable to kill\n", cpu);
 }
diff -puN arch/i386/kernel/smpboot.c~cpu_routines_accept_cpumask arch/i386/kernel/smpboot.c
--- linux-2.6.17-rc3/arch/i386/kernel/smpboot.c~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/i386/kernel/smpboot.c	2006-05-07 07:44:55.000000000 +0800
@@ -1340,11 +1340,12 @@ remove_siblinginfo(int cpu)
 	cpu_clear(cpu, cpu_sibling_setup_map);
 }
 
-int __cpu_disable(void)
+int __cpu_disable(cpumask_t remove_mask)
 {
 	cpumask_t map = cpu_online_map;
 	int cpu = smp_processor_id();
 
+	BUG_ON(cpus_weight(remove_mask) != 1);
 	/*
 	 * Perhaps use cpufreq to drop frequency, but that could go
 	 * into generic code.
@@ -1371,10 +1372,11 @@ int __cpu_disable(void)
 	return 0;
 }
 
-void __cpu_die(unsigned int cpu)
+void __cpu_die(cpumask_t remove_mask)
 {
 	/* We don't do anything here: idle task is faking death itself. */
 	unsigned int i;
+	int cpu = first_cpu(remove_mask);
 
 	for (i = 0; i < 10; i++) {
 		/* They ack this in play_dead by setting CPU_DEAD */
@@ -1389,12 +1391,12 @@ void __cpu_die(unsigned int cpu)
  	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
 }
 #else /* ... !CONFIG_HOTPLUG_CPU */
-int __cpu_disable(void)
+int __cpu_disable(cpumask_t remove_mask)
 {
 	return -ENOSYS;
 }
 
-void __cpu_die(unsigned int cpu)
+void __cpu_die(cpumask_t remove_mask)
 {
 	/* We said "no" in __cpu_disable */
 	BUG();
diff -puN arch/ia64/kernel/smpboot.c~cpu_routines_accept_cpumask arch/ia64/kernel/smpboot.c
--- linux-2.6.17-rc3/arch/ia64/kernel/smpboot.c~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/ia64/kernel/smpboot.c	2006-05-07 07:44:55.000000000 +0800
@@ -699,10 +699,11 @@ int migrate_platform_irqs(unsigned int c
 }
 
 /* must be called with cpucontrol mutex held */
-int __cpu_disable(void)
+int __cpu_disable(cpumask_t remove_mask)
 {
 	int cpu = smp_processor_id();
 
+	BUG_ON(cpus_weight(remove_mask) != 1);
 	/*
 	 * dont permit boot processor for now
 	 */
@@ -726,9 +727,10 @@ int __cpu_disable(void)
 	return 0;
 }
 
-void __cpu_die(unsigned int cpu)
+void __cpu_die(cpumask_t remove_mask)
 {
 	unsigned int i;
+	int cpu = first_cpu(remove_mask);
 
 	for (i = 0; i < 100; i++) {
 		/* They ack this in play_dead by setting CPU_DEAD */
@@ -742,12 +744,12 @@ void __cpu_die(unsigned int cpu)
  	printk(KERN_ERR "CPU %u didn't die...\n", cpu);
 }
 #else /* !CONFIG_HOTPLUG_CPU */
-int __cpu_disable(void)
+int __cpu_disable(cpumask_t remove_mask)
 {
 	return -ENOSYS;
 }
 
-void __cpu_die(unsigned int cpu)
+void __cpu_die(cpumask_t remove_mask)
 {
 	/* We said "no" in __cpu_disable */
 	BUG();
diff -puN arch/powerpc/kernel/smp.c~cpu_routines_accept_cpumask arch/powerpc/kernel/smp.c
--- linux-2.6.17-rc3/arch/powerpc/kernel/smp.c~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/powerpc/kernel/smp.c	2006-05-07 07:44:55.000000000 +0800
@@ -579,16 +579,19 @@ void __init smp_cpus_done(unsigned int m
 }
 
 #ifdef CONFIG_HOTPLUG_CPU
-int __cpu_disable(void)
+int __cpu_disable(cpumask_t remove_mask)
 {
+	BUG_ON(cpus_weight(remove_mask) != 1);
 	if (smp_ops->cpu_disable)
 		return smp_ops->cpu_disable();
 
 	return -ENOSYS;
 }
 
-void __cpu_die(unsigned int cpu)
+void __cpu_die(cpumask_t remove_mask)
 {
+	int cpu = first_cpu(remove_mask);
+
 	if (smp_ops->cpu_die)
 		smp_ops->cpu_die(cpu);
 }
diff -puN arch/s390/kernel/smp.c~cpu_routines_accept_cpumask arch/s390/kernel/smp.c
--- linux-2.6.17-rc3/arch/s390/kernel/smp.c~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/s390/kernel/smp.c	2006-05-07 07:44:55.000000000 +0800
@@ -713,12 +713,13 @@ static int __init setup_possible_cpus(ch
 early_param("possible_cpus", setup_possible_cpus);
 
 int
-__cpu_disable(void)
+__cpu_disable(cpumask_t remove_mask)
 {
 	unsigned long flags;
 	ec_creg_mask_parms cr_parms;
 	int cpu = smp_processor_id();
 
+	BUG_ON(cpus_weight(remove_mask) != 1);
 	spin_lock_irqsave(&smp_reserve_lock, flags);
 	if (smp_cpu_reserved[cpu] != 0) {
 		spin_unlock_irqrestore(&smp_reserve_lock, flags);
@@ -763,8 +764,10 @@ __cpu_disable(void)
 }
 
 void
-__cpu_die(unsigned int cpu)
+__cpu_die(cpumask_t remove_mask)
 {
+	int cpu = first_cpu(remove_mask);
+
 	/* Wait until target cpu is down */
 	while (!smp_cpu_not_running(cpu))
 		cpu_relax();
diff -puN arch/x86_64/kernel/smpboot.c~cpu_routines_accept_cpumask arch/x86_64/kernel/smpboot.c
--- linux-2.6.17-rc3/arch/x86_64/kernel/smpboot.c~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/arch/x86_64/kernel/smpboot.c	2006-05-07 07:44:55.000000000 +0800
@@ -1214,10 +1214,11 @@ void remove_cpu_from_maps(void)
 	clear_node_cpumask(cpu);
 }
 
-int __cpu_disable(void)
+int __cpu_disable(cpumask_t remove_mask)
 {
 	int cpu = smp_processor_id();
 
+	BUG_ON(cpus_weight(remove_mask) != 1);
 	/*
 	 * Perhaps use cpufreq to drop frequency, but that could go
 	 * into generic code.
@@ -1250,10 +1251,11 @@ int __cpu_disable(void)
 	return 0;
 }
 
-void __cpu_die(unsigned int cpu)
+void __cpu_die(cpumask_t remove_mask)
 {
 	/* We don't do anything here: idle task is faking death itself. */
 	unsigned int i;
+	int cpu = first_cpu(remove_mask);
 
 	for (i = 0; i < 10; i++) {
 		/* They ack this in play_dead by setting CPU_DEAD */
@@ -1274,12 +1276,12 @@ __setup("additional_cpus=", setup_additi
 
 #else /* ... !CONFIG_HOTPLUG_CPU */
 
-int __cpu_disable(void)
+int __cpu_disable(cpumask_t remove_mask)
 {
 	return -ENOSYS;
 }
 
-void __cpu_die(unsigned int cpu)
+void __cpu_die(cpumask_t remove_mask)
 {
 	/* We said "no" in __cpu_disable */
 	BUG();
diff -puN include/asm-arm/smp.h~cpu_routines_accept_cpumask include/asm-arm/smp.h
--- linux-2.6.17-rc3/include/asm-arm/smp.h~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/include/asm-arm/smp.h	2006-05-07 07:44:55.000000000 +0800
@@ -87,10 +87,10 @@ struct secondary_data {
 };
 extern struct secondary_data secondary_data;
 
-extern int __cpu_disable(void);
+extern int __cpu_disable(cpumask_t remove_mask);
 extern int mach_cpu_disable(unsigned int cpu);
 
-extern void __cpu_die(unsigned int cpu);
+extern void __cpu_die(cpumask_t remove_mask);
 extern void cpu_die(void);
 
 extern void platform_cpu_die(unsigned int cpu);
diff -puN include/asm-i386/smp.h~cpu_routines_accept_cpumask include/asm-i386/smp.h
--- linux-2.6.17-rc3/include/asm-i386/smp.h~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/include/asm-i386/smp.h	2006-05-07 07:44:55.000000000 +0800
@@ -90,8 +90,8 @@ static __inline int logical_smp_processo
 
 #endif
 
-extern int __cpu_disable(void);
-extern void __cpu_die(unsigned int cpu);
+extern int __cpu_disable(cpumask_t remove_mask);
+extern void __cpu_die(cpumask_t remove_mask);
 #endif /* !__ASSEMBLY__ */
 
 #else /* CONFIG_SMP */
diff -puN include/asm-ia64/smp.h~cpu_routines_accept_cpumask include/asm-ia64/smp.h
--- linux-2.6.17-rc3/include/asm-ia64/smp.h~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/include/asm-ia64/smp.h	2006-05-07 07:44:55.000000000 +0800
@@ -114,8 +114,8 @@ max_xtp (void)
 #define hard_smp_processor_id()		ia64_get_lid()
 
 /* Upping and downing of CPUs */
-extern int __cpu_disable (void);
-extern void __cpu_die (unsigned int cpu);
+extern int __cpu_disable (cpumask_t remove_mask);
+extern void __cpu_die (cpumask_t remove_mask);
 extern void cpu_die (void) __attribute__ ((noreturn));
 extern int __cpu_up (unsigned int cpu);
 extern void __init smp_build_cpu_map(void);
diff -puN include/asm-powerpc/smp.h~cpu_routines_accept_cpumask include/asm-powerpc/smp.h
--- linux-2.6.17-rc3/include/asm-powerpc/smp.h~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/include/asm-powerpc/smp.h	2006-05-07 07:44:55.000000000 +0800
@@ -79,8 +79,8 @@ void smp_init_pSeries(void);
 void smp_init_cell(void);
 void smp_setup_cpu_maps(void);
 
-extern int __cpu_disable(void);
-extern void __cpu_die(unsigned int cpu);
+extern int __cpu_disable(cpumask_t remove_mask);
+extern void __cpu_die(cpumask_t remove_mask);
 
 #else
 /* for UP */
diff -puN include/asm-s390/smp.h~cpu_routines_accept_cpumask include/asm-s390/smp.h
--- linux-2.6.17-rc3/include/asm-s390/smp.h~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/include/asm-s390/smp.h	2006-05-07 07:44:55.000000000 +0800
@@ -87,8 +87,8 @@ smp_cpu_not_running(int cpu)
 
 #define cpu_logical_map(cpu) (cpu)
 
-extern int __cpu_disable (void);
-extern void __cpu_die (unsigned int cpu);
+extern int __cpu_disable (cpumask_t remove_mask);
+extern void __cpu_die (cpumask_t remove_mask);
 extern void cpu_die (void) __attribute__ ((noreturn));
 extern int __cpu_up (unsigned int cpu);
 
diff -puN include/asm-x86_64/smp.h~cpu_routines_accept_cpumask include/asm-x86_64/smp.h
--- linux-2.6.17-rc3/include/asm-x86_64/smp.h~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/include/asm-x86_64/smp.h	2006-05-07 07:44:55.000000000 +0800
@@ -80,8 +80,8 @@ static inline int hard_smp_processor_id(
 }
 
 extern int safe_smp_processor_id(void);
-extern int __cpu_disable(void);
-extern void __cpu_die(unsigned int cpu);
+extern int __cpu_disable(cpumask_t remove_mask);
+extern void __cpu_die(cpumask_t remove_mask);
 extern void prefill_possible_map(void);
 extern unsigned num_processors;
 extern unsigned disabled_cpus;
diff -puN kernel/cpu.c~cpu_routines_accept_cpumask kernel/cpu.c
--- linux-2.6.17-rc3/kernel/cpu.c~cpu_routines_accept_cpumask	2006-05-07 07:44:55.000000000 +0800
+++ linux-2.6.17-rc3-root/kernel/cpu.c	2006-05-07 07:44:55.000000000 +0800
@@ -104,7 +104,7 @@ static int take_cpu_down(void *unused)
 	int err;
 
 	/* Ensure this CPU doesn't handle any more interrupts. */
-	err = __cpu_disable();
+	err = __cpu_disable(cpumask_of_cpu(raw_smp_processor_id()));
 	if (err < 0)
 		return err;
 
@@ -167,7 +167,7 @@ int cpu_down(unsigned int cpu)
 		yield();
 
 	/* This actually kills the CPU. */
-	__cpu_die(cpu);
+	__cpu_die(cpumask_of_cpu(cpu));
 
 	/* Move it here so it can run. */
 	kthread_bind(p, get_cpu());
_
