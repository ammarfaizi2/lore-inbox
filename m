Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266646AbUF3MVW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266646AbUF3MVW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jun 2004 08:21:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266652AbUF3MVV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jun 2004 08:21:21 -0400
Received: from aun.it.uu.se ([130.238.12.36]:20895 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266646AbUF3MUE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jun 2004 08:20:04 -0400
Date: Wed, 30 Jun 2004 14:19:52 +0200 (MEST)
Message-Id: <200406301219.i5UCJqvY014078@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm4] perfctr update 2/6: Kconfig-related updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Default CONFIG_PERFCTR_INIT_TESTS to n.
- Change PERFCTR_INTERRUPT_SUPPORT from a conditional #define to a
  Kconfig-derived option. Ditto PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED.
- Add URL and mailing list pointer to Kconfig help text.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

--- linux-2.6.7-mm4/drivers/perfctr/Kconfig.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/Kconfig	2004-06-29 18:01:16.324005000 +0200
@@ -16,9 +16,15 @@
 	  You can safely say Y here, even if you intend to run the kernel
 	  on a processor without performance-monitoring counters.
 
+	  At <http://www.csd.uu.se/~mikpe/linux/perfctr/> you can find
+	  the corresponding user-space components, as well as other
+	  versions of this package. A mailing list is also available, at
+	  <http://lists.sourceforge.net/lists/listinfo/perfctr-devel>.
+
 config PERFCTR_INIT_TESTS
 	bool "Init-time hardware tests"
 	depends on PERFCTR
+	default n
 	help
 	  This option makes the driver perform additional hardware tests
 	  during initialisation, and log their results in the kernel's
@@ -42,4 +48,15 @@
 	  performance measurements by reducing "noise" from other processes.
 
 	  Say Y.
+
+config PERFCTR_INTERRUPT_SUPPORT
+	bool
+	depends on PERFCTR
+	default y if X86_LOCAL_APIC
+
+config PERFCTR_CPUS_FORBIDDEN_MASK
+	bool
+	depends on PERFCTR
+	default y if X86 && SMP
+
 endmenu
--- linux-2.6.7-mm4/drivers/perfctr/cpumask.h.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/cpumask.h	2004-06-29 16:40:02.000000000 +0200
@@ -13,9 +13,10 @@
 #define PERFCTR_CPUMASK_NRLONGS	1
 #endif
 
-/* `perfctr_cpus_forbidden_mask' used to be defined in <asm/perfctr.h>,
-   but cpumask_t compatibility issues forced it to be moved here. */
-#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+/* CPUs in `perfctr_cpus_forbidden_mask' must not use the
+   performance-monitoring counters. TSC use is unrestricted.
+   This is needed to prevent resource conflicts on hyper-threaded P4s. */
+#ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
 extern cpumask_t perfctr_cpus_forbidden_mask;
 #define perfctr_cpu_is_forbidden(cpu)	cpu_isset((cpu), perfctr_cpus_forbidden_mask)
 #else
--- linux-2.6.7-mm4/drivers/perfctr/ppc.c.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/ppc.c	2004-06-29 15:00:50.000000000 +0200
@@ -58,7 +58,7 @@
 	return id;
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 static void perfctr_default_ihandler(unsigned long pc)
 {
 }
@@ -81,7 +81,7 @@
 #define perfctr_cstatus_has_ictrs(cstatus)	0
 #endif
 
-#if defined(CONFIG_SMP) && defined(PERFCTR_INTERRUPT_SUPPORT)
+#if defined(CONFIG_SMP) && defined(CONFIG_PERFCTR_INTERRUPT_SUPPORT)
 
 static inline void
 set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu)
@@ -350,7 +350,7 @@
 	return 0;
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 static void ppc_isuspend(struct perfctr_cpu_state *state)
 {
 	// XXX
@@ -448,7 +448,7 @@
 	return ppc_read_counters(state, ctrs);
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 static void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
 {
 	return ppc_isuspend(state);
@@ -514,12 +514,12 @@
 		state->pmc[i].start = state->control.ireset[i];
 }
 
-#else	/* PERFCTR_INTERRUPT_SUPPORT */
+#else	/* CONFIG_PERFCTR_INTERRUPT_SUPPORT */
 static inline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state) { }
 static inline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state) { }
 static inline int check_ireset(const struct perfctr_cpu_state *state) { return 0; }
 static inline void setup_imode_start_values(struct perfctr_cpu_state *state) { }
-#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+#endif	/* CONFIG_PERFCTR_INTERRUPT_SUPPORT */
 
 static int check_control(struct perfctr_cpu_state *state)
 {
--- linux-2.6.7-mm4/drivers/perfctr/virtual.c.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/virtual.c	2004-06-29 16:36:22.000000000 +0200
@@ -36,16 +36,16 @@
 	/* sampling_timer and bad_cpus_allowed are frequently
 	   accessed, so they get to share a cache line */
 	unsigned int sampling_timer ____cacheline_aligned;
-#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
 	atomic_t bad_cpus_allowed;
 #endif
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 	unsigned int iresume_cstatus;
 #endif
 };
 #define IS_RUNNING(perfctr)	perfctr_cstatus_enabled((perfctr)->cpu_state.cstatus)
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 
 static void vperfctr_ihandler(unsigned long pc);
 
@@ -64,7 +64,7 @@
 static inline void vperfctr_clear_iresume_cstatus(struct vperfctr *perfctr) { }
 #endif
 
-#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
 
 static inline void vperfctr_init_bad_cpus_allowed(struct vperfctr *perfctr)
 {
@@ -85,7 +85,7 @@
 	task_unlock(p);
 }
 
-#else	/* !PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED */
+#else	/* !CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK */
 
 static inline void vperfctr_init_bad_cpus_allowed(struct vperfctr *perfctr) { }
 
@@ -102,7 +102,7 @@
 	preempt_enable();
 }
 
-#endif	/* !PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED */
+#endif	/* !CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK */
 
 /****************************************************************
  *								*
@@ -226,7 +226,7 @@
 	}
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 /* vperfctr interrupt handler (XXX: add buffering support) */
 /* PREEMPT note: called in IRQ context with preemption disabled. */
 static void vperfctr_ihandler(unsigned long pc)
@@ -328,7 +328,7 @@
 void __vperfctr_resume(struct vperfctr *perfctr)
 {
 	if (IS_RUNNING(perfctr)) {
-#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
 		if (unlikely(atomic_read(&perfctr->bad_cpus_allowed)) &&
 		    perfctr_cstatus_nrctrs(perfctr->cpu_state.cstatus)) {
 			perfctr->cpu_state.cstatus = 0;
@@ -355,7 +355,7 @@
 		vperfctr_sample(perfctr);
 }
 
-#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
 /* Called from set_cpus_allowed().
  * PRE: current holds task_lock(owner)
  * PRE: owner->thread.perfctr == perfctr
@@ -454,7 +454,7 @@
 
 static int do_vperfctr_iresume(struct vperfctr *perfctr, const struct task_struct *tsk)
 {
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 	unsigned int iresume_cstatus;
 
 	if (!tsk)
--- linux-2.6.7-mm4/drivers/perfctr/x86.c.~1~	2004-06-29 12:43:27.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/x86.c	2004-06-29 15:25:36.000000000 +0200
@@ -140,7 +140,7 @@
 	return id;
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_X86_LOCAL_APIC
 static void perfctr_default_ihandler(unsigned long pc)
 {
 }
@@ -171,7 +171,7 @@
 #define apic_write(reg,vector)			do{}while(0)
 #endif
 
-#if defined(CONFIG_SMP) && defined(PERFCTR_INTERRUPT_SUPPORT)
+#if defined(CONFIG_SMP)
 
 static inline void
 set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu)
@@ -441,7 +441,7 @@
 	return p6_like_check_control(state, 0);
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_X86_LOCAL_APIC
 /* PRE: perfctr_cstatus_has_ictrs(state->cstatus) != 0 */
 /* shared with K7 and P4 */
 static void p6_like_isuspend(struct perfctr_cpu_state *state,
@@ -518,7 +518,7 @@
 {
 	p6_like_iresume(state, MSR_P6_EVNTSEL0, MSR_P6_PERFCTR0);
 }
-#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+#endif	/* CONFIG_X86_LOCAL_APIC */
 
 /* shared with K7 and VC3 */
 static void p6_like_write_control(const struct perfctr_cpu_state *state,
@@ -576,7 +576,7 @@
 	return p6_like_check_control(state, 1);
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_X86_LOCAL_APIC
 static void k7_isuspend(struct perfctr_cpu_state *state)
 {
 	p6_like_isuspend(state, MSR_K7_EVNTSEL0);
@@ -586,7 +586,7 @@
 {
 	p6_like_iresume(state, MSR_K7_EVNTSEL0, MSR_K7_PERFCTR0);
 }
-#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+#endif	/* CONFIG_X86_LOCAL_APIC */
 
 static void k7_write_control(const struct perfctr_cpu_state *state)
 {
@@ -809,7 +809,7 @@
 	return 0;
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_X86_LOCAL_APIC
 static void p4_isuspend(struct perfctr_cpu_state *state)
 {
 	return p6_like_isuspend(state, MSR_P4_CCCR0);
@@ -819,7 +819,7 @@
 {
 	return p6_like_iresume(state, MSR_P4_CCCR0, MSR_P4_PERFCTR0);
 }
-#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+#endif	/* CONFIG_X86_LOCAL_APIC */
 
 static void p4_write_control(const struct perfctr_cpu_state *state)
 {
@@ -938,7 +938,7 @@
 	return read_counters(state, ctrs);
 }
 
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_X86_LOCAL_APIC
 static void (*cpu_isuspend)(struct perfctr_cpu_state*);
 static noinline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
 {
@@ -1012,12 +1012,12 @@
 		state->pmc[i].start = state->control.ireset[i];
 }
 
-#else	/* PERFCTR_INTERRUPT_SUPPORT */
+#else	/* CONFIG_X86_LOCAL_APIC */
 static inline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state) { }
 static inline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state) { }
 static inline int check_ireset(const struct perfctr_cpu_state *state) { return 0; }
 static inline void setup_imode_start_values(struct perfctr_cpu_state *state) { }
-#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+#endif	/* CONFIG_X86_LOCAL_APIC */
 
 static int (*check_control)(struct perfctr_cpu_state*, int);
 int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global)
@@ -1258,7 +1258,7 @@
 		write_control = p6_write_control;
 		check_control = p6_check_control;
 		clear_counters = p6_clear_counters;
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_X86_LOCAL_APIC
 		if (cpu_has_apic) {
 			perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
 			cpu_isuspend = p6_isuspend;
@@ -1286,7 +1286,7 @@
 		write_control = p4_write_control;
 		check_control = p4_check_control;
 		clear_counters = p4_clear_counters;
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_X86_LOCAL_APIC
 		if (cpu_has_apic) {
 			perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
 			cpu_isuspend = p4_isuspend;
@@ -1318,7 +1318,7 @@
 	write_control = k7_write_control;
 	check_control = k7_check_control;
 	clear_counters = k7_clear_counters;
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_X86_LOCAL_APIC
 	if (cpu_has_apic) {
 		perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
 		cpu_isuspend = k7_isuspend;
--- linux-2.6.7-mm4/drivers/perfctr/x86_tests.c.~1~	2004-06-29 14:02:07.000000000 +0200
+++ linux-2.6.7-mm4/drivers/perfctr/x86_tests.c	2004-06-29 15:10:40.000000000 +0200
@@ -44,7 +44,7 @@
 #define CR4MOV	"movl"
 #endif
 
-#ifndef PERFCTR_INTERRUPT_SUPPORT
+#ifndef CONFIG_X86_LOCAL_APIC
 #undef apic_write
 #define apic_write(reg,vector)			do{}while(0)
 #endif
--- linux-2.6.7-mm4/include/asm-i386/perfctr.h.~1~	2004-06-29 12:43:28.000000000 +0200
+++ linux-2.6.7-mm4/include/asm-i386/perfctr.h	2004-06-29 16:40:34.000000000 +0200
@@ -164,11 +164,8 @@
    It will be called in IRQ context, with preemption disabled. */
 typedef void (*perfctr_ihandler_t)(unsigned long pc);
 
-#if defined(CONFIG_X86_LOCAL_APIC)
-#define PERFCTR_INTERRUPT_SUPPORT 1
-#endif
-
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+/* Operations related to overflow interrupt handling. */
+#ifdef CONFIG_X86_LOCAL_APIC
 extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
 extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
 extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
@@ -176,18 +173,9 @@
 static inline void perfctr_cpu_set_ihandler(perfctr_ihandler_t x) { }
 #endif
 
-#if defined(CONFIG_SMP)
-/* CPUs in `perfctr_cpus_forbidden_mask' must not use the
-   performance-monitoring counters. TSC use is unrestricted.
-   This is needed to prevent resource conflicts on hyper-threaded P4s.
-   The declaration of `perfctr_cpus_forbidden_mask' is in the driver's
-   private compat.h, since it needs to handle cpumask_t incompatibilities. */
-#define PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED 1
-#endif
-
 #endif	/* CONFIG_PERFCTR */
 
-#if defined(CONFIG_PERFCTR) && defined(PERFCTR_INTERRUPT_SUPPORT)
+#if defined(CONFIG_PERFCTR) && defined(CONFIG_X86_LOCAL_APIC)
 asmlinkage void perfctr_interrupt(struct pt_regs*);
 #define perfctr_vector_init()	\
 	set_intr_gate(LOCAL_PERFCTR_VECTOR, perfctr_interrupt)
--- linux-2.6.7-mm4/include/asm-ppc/perfctr.h.~1~	2004-06-29 12:43:28.000000000 +0200
+++ linux-2.6.7-mm4/include/asm-ppc/perfctr.h	2004-06-29 15:06:38.000000000 +0200
@@ -152,11 +152,10 @@
    It will be called in IRQ context, with preemption disabled. */
 typedef void (*perfctr_ihandler_t)(unsigned long pc);
 
-/* XXX: The hardware supports overflow interrupts, but the driver
+/* Operations related to overflow interrupt handling.
+   XXX: The hardware supports overflow interrupts, but the driver
    does not yet enable this due to an erratum in 750/7400/7410. */
-//#define PERFCTR_INTERRUPT_SUPPORT 1
-
-#ifdef PERFCTR_INTERRUPT_SUPPORT
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
 extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
 extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
--- linux-2.6.7-mm4/include/linux/perfctr.h.~1~	2004-06-29 12:43:28.000000000 +0200
+++ linux-2.6.7-mm4/include/linux/perfctr.h	2004-06-29 16:41:18.000000000 +0200
@@ -131,7 +131,7 @@
 
 static inline void perfctr_set_cpus_allowed(struct task_struct *p, cpumask_t new_mask)
 {
-#ifdef PERFCTR_CPUS_FORBIDDEN_MASK_NEEDED
+#ifdef CONFIG_PERFCTR_CPUS_FORBIDDEN_MASK
 	struct vperfctr *perfctr;
 
 	task_lock(p);
