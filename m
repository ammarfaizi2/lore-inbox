Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318010AbSGREUC>; Thu, 18 Jul 2002 00:20:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318009AbSGRESz>; Thu, 18 Jul 2002 00:18:55 -0400
Received: from samba.sourceforge.net ([198.186.203.85]:5810 "HELO
	lists.samba.org") by vger.kernel.org with SMTP id <S318005AbSGRESn>;
	Thu, 18 Jul 2002 00:18:43 -0400
From: Rusty Russell <rusty@rustcorp.com.au>
To: linux-kernel@vger.kernel.org, rth@twiddle.net, davidm@hpl.hp.com
Subject: [PATCH] per-cpu patch 3/3
Date: Thu, 18 Jul 2002 13:50:10 +1000
Message-Id: <20020718042221.712C3417B@lists.samba.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

David gets bitten most by this, being the most enthusiastic
per_cpu_data user, but Richard wanted to use __thread for Alpha.

Does everyone like this? (Also see two previous patches this depends
on).  If so I'll send to Linus.

Name: DECLARE_PER_CPU/DEFINE_PER_CPU patch
Author: Rusty Russell
Status: Cleanup
Depends: Misc/get-percpu.patch.gz Misc/percpu-export.patch.gz

D: This old __per_cpu_data define wasn't enough if an arch wants to
D: use the gcc __thread prefix (thread local storage), which needs to
D: go *before* the type in the definition.  So we have to go for a
D: DECLARE macro, and while we're there, separate DECLARE and DEFINE,
D: as definitions of per-cpu data cannot live in modules.  This also
D: means that accidental direct references to per-cpu variables will
D: be caught at compile time.

diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/arch/ia64/kernel/perfmon.c working-2.5.26-percpu/arch/ia64/kernel/perfmon.c
--- working-2.5.26-pre-percpu/arch/ia64/kernel/perfmon.c	Wed Jul 17 20:43:13 2002
+++ working-2.5.26-percpu/arch/ia64/kernel/perfmon.c	Wed Jul 17 16:50:42 2002
@@ -369,8 +369,8 @@ static pmu_config_t	pmu_conf; 	/* PMU co
 static pfm_session_t	pfm_sessions;	/* global sessions information */
 static struct proc_dir_entry *perfmon_dir; /* for debug only */
 static pfm_stats_t	pfm_stats;
-int __per_cpu_data pfm_syst_wide;
-static int __per_cpu_data pfm_dcr_pp;
+DEFINE_PER_CPU(int pfm_syst_wide);
+static DEFINE_PER_CPU(int pfm_dcr_pp);
 
 /* sysctl() controls */
 static pfm_sysctl_t pfm_sysctl;
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/arch/ia64/kernel/setup.c working-2.5.26-percpu/arch/ia64/kernel/setup.c
--- working-2.5.26-pre-percpu/arch/ia64/kernel/setup.c	Thu May 30 10:00:47 2002
+++ working-2.5.26-percpu/arch/ia64/kernel/setup.c	Wed Jul 17 16:51:07 2002
@@ -58,7 +58,7 @@ extern char _end;
 unsigned long __per_cpu_offset[NR_CPUS];
 #endif
 
-struct cpuinfo_ia64 cpu_info __per_cpu_data;
+DECLARE_PER_CPU(struct cpuinfo_ia64 cpu_info);
 
 unsigned long ia64_phys_stacked_size_p8;
 unsigned long ia64_cycles_per_usec;
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/arch/ia64/kernel/smp.c working-2.5.26-percpu/arch/ia64/kernel/smp.c
--- working-2.5.26-pre-percpu/arch/ia64/kernel/smp.c	Wed Jul 17 20:43:13 2002
+++ working-2.5.26-percpu/arch/ia64/kernel/smp.c	Wed Jul 17 16:51:27 2002
@@ -80,7 +80,7 @@ static volatile struct call_data_struct 
 #define IPI_CPU_STOP		1
 
 /* This needs to be cacheline aligned because it is written to by *other* CPUs.  */
-static __u64 ipi_operation __per_cpu_data ____cacheline_aligned;
+static DECLARE_PER_CPU(__u64 ipi_operation) ____cacheline_aligned;
 
 static void
 stop_this_cpu (void)
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/arch/ppc/Makefile working-2.5.26-percpu/arch/ppc/Makefile
--- working-2.5.26-pre-percpu/arch/ppc/Makefile	Sun Jul  7 02:12:18 2002
+++ working-2.5.26-percpu/arch/ppc/Makefile	Wed Jul 17 20:35:26 2002
@@ -127,13 +127,13 @@ else
 NEW_AS	:= 0
 endif
 
-ifneq ($(NEW_AS),0)
-checkbin:
-	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build'
-	@echo 'correctly with old versions of binutils.'
-	@echo '*** Please upgrade your binutils to ${GOODVER} or newer'
-	@false
-else
+# ifneq ($(NEW_AS),0)
+# checkbin:
+# 	@echo -n '*** ${VERSION}.${PATCHLEVEL} kernels no longer build'
+# 	@echo 'correctly with old versions of binutils.'
+# 	@echo '*** Please upgrade your binutils to ${GOODVER} or newer'
+# 	@false
+# else
 checkbin:
 	@true
-endif
+# endif
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/arch/ppc/kernel/asm-offsets.h working-2.5.26-percpu/arch/ppc/kernel/asm-offsets.h
--- working-2.5.26-pre-percpu/arch/ppc/kernel/asm-offsets.h	Thu Jan  1 10:00:00 1970
+++ working-2.5.26-percpu/arch/ppc/kernel/asm-offsets.h	Wed Jul 17 20:37:42 2002
@@ -0,0 +1,69 @@
+/*
+ * WARNING! This file is automatically generated - DO NOT EDIT!
+ */
+#define	THREAD	624
+#define	THREAD_INFO	4
+#define	MM	72
+#define	KSP	0
+#define	PGDIR	12
+#define	LAST_SYSCALL	20
+#define	PT_REGS	4
+#define	THREAD_FPEXC_MODE	16
+#define	THREAD_FPR0	24
+#define	THREAD_FPSCR	284
+#define	STACK_FRAME_OVERHEAD	16
+#define	INT_FRAME_SIZE	192
+#define	GPR0	16
+#define	GPR1	20
+#define	GPR2	24
+#define	GPR3	28
+#define	GPR4	32
+#define	GPR5	36
+#define	GPR6	40
+#define	GPR7	44
+#define	GPR8	48
+#define	GPR9	52
+#define	GPR10	56
+#define	GPR11	60
+#define	GPR12	64
+#define	GPR13	68
+#define	GPR14	72
+#define	GPR15	76
+#define	GPR16	80
+#define	GPR17	84
+#define	GPR18	88
+#define	GPR19	92
+#define	GPR20	96
+#define	GPR21	100
+#define	GPR22	104
+#define	GPR23	108
+#define	GPR24	112
+#define	GPR25	116
+#define	GPR26	120
+#define	GPR27	124
+#define	GPR28	128
+#define	GPR29	132
+#define	GPR30	136
+#define	GPR31	140
+#define	_NIP	144
+#define	_MSR	148
+#define	_CTR	156
+#define	_LINK	160
+#define	_CCR	168
+#define	_MQ	172
+#define	_XER	164
+#define	_DAR	180
+#define	_DSISR	184
+#define	_DEAR	180
+#define	_ESR	184
+#define	ORIG_GPR3	152
+#define	RESULT	188
+#define	TRAP	176
+#define	CLONE_VM	256
+#define	MM_PGD	12
+#define	CPU_SPEC_ENTRY_SIZE	32
+#define	CPU_SPEC_PVR_MASK	0
+#define	CPU_SPEC_PVR_VALUE	4
+#define	CPU_SPEC_FEATURES	12
+#define	CPU_SPEC_SETUP	28
+#define	NUM_USER_SEGMENTS	8
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/include/asm-generic/percpu.h working-2.5.26-percpu/include/asm-generic/percpu.h
--- working-2.5.26-pre-percpu/include/asm-generic/percpu.h	Wed Jul 17 20:43:13 2002
+++ working-2.5.26-percpu/include/asm-generic/percpu.h	Wed Jul 17 16:43:16 2002
@@ -1,13 +1,31 @@
 #ifndef _ASM_GENERIC_PERCPU_H_
 #define _ASM_GENERIC_PERCPU_H_
+#include <linux/compiler.h>
 
 #define __GENERIC_PER_CPU
-#include <linux/compiler.h>
+#ifdef CONFIG_SMP
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
+#ifndef MODULE
+#define DEFINE_PER_CPU(var) var##__percpu __attribute__((section(".data.percpu")))
+#endif
+#define DECLARE_PER_CPU(var) extern var##__percpu
+
 /* var is in discarded region: offset to particular copy we want */
-#define per_cpu(var, cpu) (*RELOC_HIDE(&var, __per_cpu_offset[cpu]))
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__percpu, __per_cpu_offset[cpu]))
 #define __get_cpu_var(var) per_cpu(var, smp_processor_id())
+
+#else /* ! SMP */
+
+/* Can't define per-cpu variables in modules.  Sorry --RR */
+#ifndef MODULE
+#define DEFINE_PER_CPU(var) var##__percpu
+#endif
+#define DECLARE_PER_CPU(var) extern var##__percpu
+
+#define per_cpu(var, cpu)			var##__percpu
+#define __get_cpu_var(var)			var##__percpu
+#endif
 
 #endif /* _ASM_GENERIC_PERCPU_H_ */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/include/asm-ia64/percpu.h working-2.5.26-percpu/include/asm-ia64/percpu.h
--- working-2.5.26-pre-percpu/include/asm-ia64/percpu.h	Wed Jul 17 20:43:13 2002
+++ working-2.5.26-percpu/include/asm-ia64/percpu.h	Wed Jul 17 16:50:21 2002
@@ -16,8 +16,13 @@
 
 extern unsigned long __per_cpu_offset[NR_CPUS];
 
-#define per_cpu(var, cpu)	(*(__typeof__(&(var))) ((void *) &(var) + __per_cpu_offset[cpu]))
-#define __get_cpu_var(var)	(var)
+#ifndef MODULE
+#define DEFINE_PER_CPU(var) var##__percpu __attribute__((section(".data.percpu")))
+#endif
+#define DECLARE_PER_CPU(var) extern var##__percpu
+
+#define per_cpu(var, cpu) (*RELOC_HIDE(&var##__percpu, __per_cpu_offset[cpu]))
+#define __get_cpu_var(var)	(var##__percpu)
 
 #endif /* !__ASSEMBLY__ */
 
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/include/asm-ia64/processor.h working-2.5.26-percpu/include/asm-ia64/processor.h
--- working-2.5.26-pre-percpu/include/asm-ia64/processor.h	Wed Jul 17 20:43:13 2002
+++ working-2.5.26-percpu/include/asm-ia64/processor.h	Wed Jul 17 16:49:56 2002
@@ -134,7 +134,7 @@ struct ia64_psr {
  * CPU type, hardware bug flags, and per-CPU state.  Frequently used
  * state comes earlier:
  */
-extern struct cpuinfo_ia64 {
+DECLARE_PER_CPU(struct cpuinfo_ia64 {
 	/* irq_stat must be 64-bit aligned */
 	union {
 		struct {
@@ -175,7 +175,7 @@ extern struct cpuinfo_ia64 {
 	__u64 prof_counter;
 	__u64 prof_multiplier;
 #endif
-} cpu_info __per_cpu_data;
+} cpu_info);
 
 /*
  * The "local" data pointer.  It points to the per-CPU data of the currently executing
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/include/linux/percpu.h working-2.5.26-percpu/include/linux/percpu.h
--- working-2.5.26-pre-percpu/include/linux/percpu.h	Wed Jul 17 20:43:13 2002
+++ working-2.5.26-percpu/include/linux/percpu.h	Wed Jul 17 16:40:21 2002
@@ -1,16 +1,9 @@
 #ifndef __LINUX_PERCPU_H
 #define __LINUX_PERCPU_H
-#include <linux/config.h>
-
-#ifdef CONFIG_SMP
-#define __per_cpu_data	__attribute__((section(".data.percpu")))
+#include <linux/spinlock.h> /* For preempt_disable() */
 #include <asm/percpu.h>
-#else
-#define __per_cpu_data
-#define per_cpu(var, cpu)			var
-#define __get_cpu_var(var)			var
-#endif
 
 #define get_cpu_var(var) ({ preempt_disable(); __get_cpu_var(var); })
 #define put_cpu_var(var) preempt_enable()
+
 #endif /* __LINUX_PERCPU_H */
diff -urpN -I \$.*\$ --exclude TAGS -X /home/rusty/devel/kernel/kernel-patches/current-dontdiff --minimal working-2.5.26-pre-percpu/kernel/softirq.c working-2.5.26-percpu/kernel/softirq.c
--- working-2.5.26-pre-percpu/kernel/softirq.c	Wed Jul 17 20:43:13 2002
+++ working-2.5.26-percpu/kernel/softirq.c	Wed Jul 17 16:46:06 2002
@@ -154,8 +154,8 @@ struct tasklet_head
 
 /* Some compilers disobey section attribute on statics when not
    initialized -- RR */
-static struct tasklet_head tasklet_vec __per_cpu_data = { NULL };
-static struct tasklet_head tasklet_hi_vec __per_cpu_data = { NULL };
+static DEFINE_PER_CPU(struct tasklet_head tasklet_vec) = { NULL };
+static DEFINE_PER_CPU(struct tasklet_head tasklet_hi_vec) = { NULL };
 
 void __tasklet_schedule(struct tasklet_struct *t)
 {

--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
