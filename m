Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261210AbUENOVL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261210AbUENOVL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 10:21:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261358AbUENOU7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 10:20:59 -0400
Received: from aun.it.uu.se ([130.238.12.36]:22505 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261210AbUENOLL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 10:11:11 -0400
Date: Fri, 14 May 2004 16:11:02 +0200 (MEST)
Message-Id: <200405141411.i4EEB2Ep018409@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][3/7] perfctr-2.7.2 for 2.6.6-mm2: x86_64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


perfctr-2.7.2 for 2.6.6-mm2, part 3/7:

- x86_64 driver and arch changes

 arch/x86_64/Kconfig              |    2 
 arch/x86_64/ia32/ia32entry.S     |    2 
 arch/x86_64/kernel/entry.S       |    5 
 arch/x86_64/kernel/i8259.c       |    3 
 arch/x86_64/kernel/process.c     |    8 
 drivers/perfctr/x86_64.c         |  660 +++++++++++++++++++++++++++++++++++++++
 include/asm-x86_64/hw_irq.h      |    5 
 include/asm-x86_64/ia32_unistd.h |    2 
 include/asm-x86_64/irq.h         |    2 
 include/asm-x86_64/perfctr.h     |  166 +++++++++
 include/asm-x86_64/processor.h   |    2 
 include/asm-x86_64/unistd.h      |    4 
 12 files changed, 857 insertions(+), 4 deletions(-)

diff -ruN linux-2.6.6-mm2/arch/x86_64/Kconfig linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/Kconfig
--- linux-2.6.6-mm2/arch/x86_64/Kconfig	2004-05-14 14:02:09.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/Kconfig	2004-05-14 14:45:43.970229684 +0200
@@ -319,6 +319,8 @@
 	bool
 	default y
 
+source "drivers/perfctr/Kconfig"
+
 endmenu
 
 
diff -ruN linux-2.6.6-mm2/arch/x86_64/ia32/ia32entry.S linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/ia32/ia32entry.S
--- linux-2.6.6-mm2/arch/x86_64/ia32/ia32entry.S	2004-05-14 14:02:09.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/ia32/ia32entry.S	2004-05-14 14:45:43.970229684 +0200
@@ -588,6 +588,8 @@
 	.quad compat_sys_mq_timedreceive	/* 280 */
 	.quad compat_sys_mq_notify
 	.quad compat_sys_mq_getsetattr
+	.quad sys_ni_syscall	/* reserved for kexec */
+	.quad sys_perfctr
 	/* don't forget to change IA32_NR_syscalls */
 ia32_syscall_end:		
 	.rept IA32_NR_syscalls-(ia32_syscall_end-ia32_sys_call_table)/8
diff -ruN linux-2.6.6-mm2/arch/x86_64/kernel/entry.S linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/kernel/entry.S
--- linux-2.6.6-mm2/arch/x86_64/kernel/entry.S	2004-05-10 11:14:36.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/kernel/entry.S	2004-05-14 14:45:43.970229684 +0200
@@ -557,6 +557,11 @@
 	apicinterrupt SPURIOUS_APIC_VECTOR,smp_spurious_interrupt
 #endif
 				
+#if defined(CONFIG_X86_LOCAL_APIC) && defined(CONFIG_PERFCTR)
+ENTRY(perfctr_interrupt)
+	apicinterrupt LOCAL_PERFCTR_VECTOR,smp_perfctr_interrupt
+#endif
+ 		
 /*
  * Exception entry points.
  */ 		
diff -ruN linux-2.6.6-mm2/arch/x86_64/kernel/i8259.c linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/kernel/i8259.c
--- linux-2.6.6-mm2/arch/x86_64/kernel/i8259.c	2004-05-10 11:14:36.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/kernel/i8259.c	2004-05-14 14:45:43.980229843 +0200
@@ -24,6 +24,7 @@
 #include <asm/delay.h>
 #include <asm/desc.h>
 #include <asm/apic.h>
+#include <asm/perfctr.h>
 
 #include <linux/irq.h>
 
@@ -485,6 +486,8 @@
 	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
 #endif
 
+	perfctr_vector_init();
+
 	/*
 	 * Set the clock to HZ Hz, we already have a valid
 	 * vector now:
diff -ruN linux-2.6.6-mm2/arch/x86_64/kernel/process.c linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/kernel/process.c
--- linux-2.6.6-mm2/arch/x86_64/kernel/process.c	2004-05-14 14:02:09.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/arch/x86_64/kernel/process.c	2004-05-14 14:45:43.980229843 +0200
@@ -36,6 +36,7 @@
 #include <linux/delay.h>
 #include <linux/irq.h>
 #include <linux/ptrace.h>
+#include <linux/perfctr.h>
 #include <linux/version.h>
 
 #include <asm/uaccess.h>
@@ -266,6 +267,7 @@
 		tss->io_bitmap_base = INVALID_IO_BITMAP_OFFSET;
 		put_cpu();
 	}
+	perfctr_exit_thread(&me->thread);
 }
 
 void flush_thread(void)
@@ -369,6 +371,8 @@
 	asm("movl %%es,%0" : "=m" (p->thread.es));
 	asm("movl %%ds,%0" : "=m" (p->thread.ds));
 
+	perfctr_copy_thread(&p->thread);
+
 	if (unlikely(me->thread.io_bitmap_ptr != NULL)) { 
 		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
 		if (!p->thread.io_bitmap_ptr) 
@@ -415,6 +419,8 @@
 	int cpu = smp_processor_id();  
 	struct tss_struct *tss = init_tss + cpu;
 
+	perfctr_suspend_thread(prev);
+
 	unlazy_fpu(prev_p);
 
 	/*
@@ -518,6 +524,8 @@
 		}
 	}
 
+	perfctr_resume_thread(next);
+
 	return prev_p;
 }
 
diff -ruN linux-2.6.6-mm2/drivers/perfctr/x86_64.c linux-2.6.6-mm2.perfctr-2.7.2.x86_64/drivers/perfctr/x86_64.c
--- linux-2.6.6-mm2/drivers/perfctr/x86_64.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/drivers/perfctr/x86_64.c	2004-05-14 14:45:43.990230001 +0200
@@ -0,0 +1,660 @@
+/* $Id: x86_64.c,v 1.27 2004/05/13 23:32:50 mikpe Exp $
+ * x86_64 performance-monitoring counters driver.
+ *
+ * Copyright (C) 2003-2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <linux/perfctr.h>
+
+#include <asm/msr.h>
+#include <asm/fixmap.h>
+#include <asm/apic.h>
+struct hw_interrupt_type;
+#include <asm/hw_irq.h>
+
+#include "x86_compat.h"
+#include "x86_tests.h"
+
+/* Support for lazy evntsel and perfctr MSR updates. */
+struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
+	union {
+		unsigned int id;	/* cache owner id */
+	} k1;
+	struct {
+		/* NOTE: these caches have physical indices, not virtual */
+		unsigned int evntsel[4];
+	} control;
+} ____cacheline_aligned;
+static struct per_cpu_cache per_cpu_cache[NR_CPUS] __cacheline_aligned;
+
+/* Structure for counter snapshots, as 32-bit values. */
+struct perfctr_low_ctrs {
+	unsigned int tsc;
+	unsigned int pmc[4];
+};
+
+/* AMD K8 */
+#define MSR_K8_EVNTSEL0		0xC0010000	/* .. 0xC0010003 */
+#define MSR_K8_PERFCTR0		0xC0010004	/* .. 0xC0010007 */
+#define K8_EVNTSEL_ENABLE	0x00400000
+#define K8_EVNTSEL_INT		0x00100000
+#define K8_EVNTSEL_CPL		0x00030000
+#define K8_EVNTSEL_RESERVED	0x00280000
+
+#define rdpmc_low(ctr,low) \
+	__asm__ __volatile__("rdpmc" : "=a"(low) : "c"(ctr) : "edx")
+
+static void clear_msr_range(unsigned int base, unsigned int n)
+{
+	unsigned int i;
+
+	for(i = 0; i < n; ++i)
+		wrmsr(base+i, 0, 0);
+}
+
+static inline void set_in_cr4_local(unsigned int mask)
+{
+	write_cr4(read_cr4() | mask);
+}
+
+static inline void clear_in_cr4_local(unsigned int mask)
+{
+	write_cr4(read_cr4() & ~mask);
+}
+
+static unsigned int new_id(void)
+{
+	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static unsigned int counter;
+	int id;
+
+	spin_lock(&lock);
+	id = ++counter;
+	spin_unlock(&lock);
+	return id;
+}
+
+static void perfctr_default_ihandler(unsigned long pc)
+{
+}
+
+static perfctr_ihandler_t perfctr_ihandler = perfctr_default_ihandler;
+
+asmlinkage void smp_perfctr_interrupt(struct pt_regs *regs)
+{
+	/* PREEMPT note: invoked via an interrupt gate, which
+	   masks interrupts. We're still on the originating CPU. */
+	/* XXX: recursive interrupts? delay the ACK, mask LVTPC, or queue? */
+	ack_APIC_irq();
+	irq_enter();
+	(*perfctr_ihandler)(instruction_pointer(regs));
+	irq_exit();
+}
+
+void perfctr_cpu_set_ihandler(perfctr_ihandler_t ihandler)
+{
+	perfctr_ihandler = ihandler ? ihandler : perfctr_default_ihandler;
+}
+
+#if defined(CONFIG_SMP)
+
+static inline void set_isuspend_cpu(struct perfctr_cpu_state *state,
+				    int cpu)
+{
+	state->k1.isuspend_cpu = cpu;
+}
+
+static inline int is_isuspend_cpu(const struct perfctr_cpu_state *state,
+				  int cpu)
+{
+	return state->k1.isuspend_cpu == cpu;
+}
+
+static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state)
+{
+	state->k1.isuspend_cpu = NR_CPUS;
+}
+
+#else
+static inline void set_isuspend_cpu(struct perfctr_cpu_state *state,
+				    int cpu) { }
+static inline int is_isuspend_cpu(const struct perfctr_cpu_state *state,
+				  int cpu) { return 1; }
+static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state) { }
+#endif
+
+/****************************************************************
+ *								*
+ * Driver procedures.						*
+ *								*
+ ****************************************************************/
+
+static void perfctr_cpu_read_counters(const struct perfctr_cpu_state *state,
+				      struct perfctr_low_ctrs *ctrs)
+{
+	unsigned int cstatus, nrctrs, i;
+
+	cstatus = state->cstatus;
+	if( perfctr_cstatus_has_tsc(cstatus) )
+		rdtscl(ctrs->tsc);
+	nrctrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		rdpmc_low(pmc, ctrs->pmc[i]);
+	}
+}
+
+static int k8_check_control(struct perfctr_cpu_state *state)
+{
+	unsigned int evntsel, i, nractrs, nrctrs, pmc_mask, pmc;
+
+	nractrs = state->control.nractrs;
+	nrctrs = nractrs + state->control.nrictrs;
+	if( nrctrs < nractrs || nrctrs > 4 )
+		return -EINVAL;
+
+	pmc_mask = 0;
+	for(i = 0; i < nrctrs; ++i) {
+		pmc = state->control.pmc_map[i];
+		state->pmc[i].map = pmc;
+		if( pmc >= 4 || (pmc_mask & (1<<pmc)) )
+			return -EINVAL;
+		pmc_mask |= (1<<pmc);
+		evntsel = state->control.evntsel[i];
+		/* protect reserved bits */
+		if( evntsel & K8_EVNTSEL_RESERVED )
+			return -EPERM;
+		/* ENable bit must be set in each evntsel */
+		if( !(evntsel & K8_EVNTSEL_ENABLE) )
+			return -EINVAL;
+		/* the CPL field must be non-zero */
+		if( !(evntsel & K8_EVNTSEL_CPL) )
+			return -EINVAL;
+		/* INT bit must be off for a-mode and on for i-mode counters */
+		if( evntsel & K8_EVNTSEL_INT ) {
+			if( i < nractrs )
+				return -EINVAL;
+		} else {
+			if( i >= nractrs )
+				return -EINVAL;
+		}
+	}
+	state->k1.id = new_id();
+	return 0;
+}
+
+static void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned int cstatus, nrctrs, i;
+	int cpu;
+
+	cpu = smp_processor_id();
+	cache = &per_cpu_cache[cpu];
+	cstatus = state->cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		unsigned int pmc, now;
+		pmc = state->pmc[i].map;
+		cache->control.evntsel[pmc] = 0;
+		wrmsr(MSR_K8_EVNTSEL0+pmc, 0, 0);
+		rdpmc_low(pmc, now);
+		state->pmc[i].sum += now - state->pmc[i].start;
+		state->pmc[i].start = now;
+	}
+	/* cache->k1.id is still == state->k1.id */
+	set_isuspend_cpu(state, cpu);
+}
+
+static void perfctr_cpu_iresume(const struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned int cstatus, nrctrs, i;
+	int cpu;
+
+	cpu = smp_processor_id();
+	cache = &per_cpu_cache[cpu];
+	if( cache->k1.id == state->k1.id ) {
+		cache->k1.id = 0; /* force reload of cleared EVNTSELs */
+		if( is_isuspend_cpu(state, cpu) )
+			return; /* skip reload of PERFCTRs */
+	}
+	cstatus = state->cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		/* If the control wasn't ours we must disable the evntsels
+		   before reinitialising the counters, to prevent unexpected
+		   counter increments and missed overflow interrupts. */
+		if( cache->control.evntsel[pmc] ) {
+			cache->control.evntsel[pmc] = 0;
+			wrmsr(MSR_K8_EVNTSEL0+pmc, 0, 0);
+		}
+		wrmsr(MSR_K8_PERFCTR0+pmc, state->pmc[i].start, -1);
+	}
+	/* cache->k1.id remains != state->k1.id */
+}
+
+static void perfctr_cpu_write_control(const struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned int nrctrs, i;
+
+	cache = &per_cpu_cache[smp_processor_id()];
+	if( cache->k1.id == state->k1.id ) {
+		return;
+	}
+	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int evntsel = state->control.evntsel[i];
+		unsigned int pmc = state->pmc[i].map;
+		if( evntsel != cache->control.evntsel[pmc] ) {
+			cache->control.evntsel[pmc] = evntsel;
+			wrmsr(MSR_K8_EVNTSEL0+pmc, evntsel, 0);
+		}
+	}
+	cache->k1.id = state->k1.id;
+}
+
+static void k8_clear_counters(void)
+{
+	clear_msr_range(MSR_K8_EVNTSEL0, 4+4);
+}
+
+/*
+ * Generic driver for any x86-64 with a working TSC.
+ * (Mainly for testing with Screwdriver.)
+ */
+
+static int generic_check_control(struct perfctr_cpu_state *state)
+{
+	if( state->control.nractrs || state->control.nrictrs )
+		return -EINVAL;
+	return 0;
+}
+
+static void generic_clear_counters(void)
+{
+}
+
+/*
+ * Driver methods, internal and exported.
+ */
+
+/* Call perfctr_cpu_ireload() just before perfctr_cpu_resume() to
+   bypass internal caching and force a reload if the I-mode PMCs. */
+void perfctr_cpu_ireload(struct perfctr_cpu_state *state)
+{
+#ifdef CONFIG_SMP
+	clear_isuspend_cpu(state);
+#else
+	per_cpu_cache[smp_processor_id()].k1.id = 0;
+#endif
+}
+
+/* PRE: the counters have been suspended and sampled by perfctr_cpu_suspend() */
+unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state *state)
+{
+	unsigned int cstatus, nrctrs, pmc, pmc_mask;
+
+	cstatus = state->cstatus;
+	pmc = perfctr_cstatus_nractrs(cstatus);
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+
+	for(pmc_mask = 0; pmc < nrctrs; ++pmc) {
+		if( (int)state->pmc[pmc].start >= 0 ) { /* XXX: ">" ? */
+			/* XXX: "+=" to correct for overshots */
+			state->pmc[pmc].start = state->control.ireset[pmc];
+			pmc_mask |= (1 << pmc);
+		}
+	}
+	return pmc_mask;
+}
+
+static inline int check_ireset(const struct perfctr_cpu_state *state)
+{
+	unsigned int nrctrs, i;
+
+	i = state->control.nractrs;
+	nrctrs = i + state->control.nrictrs;
+	for(; i < nrctrs; ++i)
+		if( state->control.ireset[i] >= 0 )
+			return -EINVAL;
+	return 0;
+}
+
+static inline void setup_imode_start_values(struct perfctr_cpu_state *state)
+{
+	unsigned int cstatus, nrctrs, i;
+
+	cstatus = state->cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
+		state->pmc[i].start = state->control.ireset[i];
+}
+
+static int (*check_control)(struct perfctr_cpu_state*);
+int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global)
+{
+	int err;
+
+	clear_isuspend_cpu(state);
+	state->cstatus = 0;
+
+	/* disallow i-mode counters if we cannot catch the interrupts */
+	if( !(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
+	    && state->control.nrictrs )
+		return -EPERM;
+
+	err = check_control(state);
+	if( err < 0 )
+		return err;
+	err = check_ireset(state);
+	if( err < 0 )
+		return err;
+	state->cstatus = perfctr_mk_cstatus(state->control.tsc_on,
+					    state->control.nractrs,
+					    state->control.nrictrs);
+	setup_imode_start_values(state);
+	return 0;
+}
+
+void perfctr_cpu_suspend(struct perfctr_cpu_state *state)
+{
+	unsigned int i, cstatus, nractrs;
+	struct perfctr_low_ctrs now;
+
+	if( perfctr_cstatus_has_ictrs(state->cstatus) )
+	    perfctr_cpu_isuspend(state);
+	perfctr_cpu_read_counters(state, &now);
+	cstatus = state->cstatus;
+	if( perfctr_cstatus_has_tsc(cstatus) )
+		state->tsc_sum += now.tsc - state->tsc_start;
+	nractrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nractrs; ++i)
+		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
+}
+
+void perfctr_cpu_resume(struct perfctr_cpu_state *state)
+{
+	if( perfctr_cstatus_has_ictrs(state->cstatus) )
+	    perfctr_cpu_iresume(state);
+	perfctr_cpu_write_control(state);
+	//perfctr_cpu_read_counters(state, &state->start);
+	{
+		struct perfctr_low_ctrs now;
+		unsigned int i, cstatus, nrctrs;
+		perfctr_cpu_read_counters(state, &now);
+		cstatus = state->cstatus;
+		if( perfctr_cstatus_has_tsc(cstatus) )
+			state->tsc_start = now.tsc;
+		nrctrs = perfctr_cstatus_nractrs(cstatus);
+		for(i = 0; i < nrctrs; ++i)
+			state->pmc[i].start = now.pmc[i];
+	}
+	/* XXX: if (SMP && start.tsc == now.tsc) ++now.tsc; */
+}
+
+void perfctr_cpu_sample(struct perfctr_cpu_state *state)
+{
+	unsigned int i, cstatus, nractrs;
+	struct perfctr_low_ctrs now;
+
+	perfctr_cpu_read_counters(state, &now);
+	cstatus = state->cstatus;
+	if( perfctr_cstatus_has_tsc(cstatus) ) {
+		state->tsc_sum += now.tsc - state->tsc_start;
+		state->tsc_start = now.tsc;
+	}
+	nractrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nractrs; ++i) {
+		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
+		state->pmc[i].start = now.pmc[i];
+	}
+}
+
+static void (*clear_counters)(void);
+static void perfctr_cpu_clear_counters(void)
+{
+	return clear_counters();
+}
+
+/****************************************************************
+ *								*
+ * Processor detection and initialisation procedures.		*
+ *								*
+ ****************************************************************/
+
+static int __init amd_init(void)
+{
+	static char k8_name[] __initdata = "AMD K8";
+	static char k8c_name[] __initdata = "AMD K8C";
+
+	if( !cpu_has_tsc )
+		return -ENODEV;
+	if( boot_cpu_data.x86 != 15 )
+		return -ENODEV;
+	if( (boot_cpu_data.x86_model > 5) ||
+	    (boot_cpu_data.x86_model >= 4 && boot_cpu_data.x86_mask >= 8) ) {
+		perfctr_info.cpu_type = PERFCTR_X86_AMD_K8C;
+		perfctr_cpu_name = k8c_name;
+	} else {
+		perfctr_info.cpu_type = PERFCTR_X86_AMD_K8;
+		perfctr_cpu_name = k8_name;
+	}
+	check_control = k8_check_control;
+	clear_counters = k8_clear_counters;
+	if( cpu_has_apic )
+		perfctr_info.cpu_features |= PERFCTR_FEATURE_PCINT;
+	return 0;
+}
+
+/* For testing on Screwdriver. */
+static int __init generic_init(void)
+{
+	static char generic_name[] __initdata = "Generic x86-64 with TSC";
+	if( !cpu_has_tsc )
+		return -ENODEV;
+	perfctr_info.cpu_features &= ~PERFCTR_FEATURE_RDPMC;
+	perfctr_info.cpu_type = PERFCTR_X86_GENERIC;
+	perfctr_cpu_name = generic_name;
+	check_control = generic_check_control;
+	clear_counters = generic_clear_counters;
+	return 0;
+}
+
+static void perfctr_cpu_init_one(void *ignore)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	perfctr_cpu_clear_counters();
+	if( cpu_has_apic )
+		apic_write(APIC_LVTPC, LOCAL_PERFCTR_VECTOR);
+	if( perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC )
+		set_in_cr4_local(X86_CR4_PCE);
+}
+
+static void perfctr_cpu_exit_one(void *ignore)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	perfctr_cpu_clear_counters();
+	if( cpu_has_apic )
+		apic_write(APIC_LVTPC, APIC_DM_NMI | APIC_LVT_MASKED);
+	if( perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC )
+		clear_in_cr4_local(X86_CR4_PCE);
+}
+
+#if defined(CONFIG_PM)
+
+static void perfctr_pm_suspend(void)
+{
+	/* XXX: clear control registers */
+	printk("perfctr: PM suspend\n");
+}
+
+static void perfctr_pm_resume(void)
+{
+	/* XXX: reload control registers */
+	printk("perfctr: PM resume\n");
+}
+
+#include <linux/sysdev.h>
+
+static int perfctr_device_suspend(struct sys_device *dev, u32 state)
+{
+	perfctr_pm_suspend();
+	return 0;
+}
+
+static int perfctr_device_resume(struct sys_device *dev)
+{
+	perfctr_pm_resume();
+	return 0;
+}
+
+static struct sysdev_class perfctr_sysclass = {
+	set_kset_name("perfctr"),
+	.resume		= perfctr_device_resume,
+	.suspend	= perfctr_device_suspend,
+};
+
+static struct sys_device device_perfctr = {
+	.id	= 0,
+	.cls	= &perfctr_sysclass,
+};
+
+static void x86_pm_init(void)
+{
+	if( sysdev_class_register(&perfctr_sysclass) == 0 )
+		sysdev_register(&device_perfctr);
+}
+
+static void x86_pm_exit(void)
+{
+	sysdev_unregister(&device_perfctr);
+	sysdev_class_unregister(&perfctr_sysclass);
+}
+
+#else
+
+static inline void x86_pm_init(void) { }
+static inline void x86_pm_exit(void) { }
+
+#endif	/* CONFIG_PM */
+
+static void do_init_tests(void)
+{
+#ifdef CONFIG_PERFCTR_INIT_TESTS
+	if( reserve_lapic_nmi() >= 0 ) {
+		perfctr_x86_init_tests();
+		release_lapic_nmi();
+	}
+#endif
+}
+
+static void invalidate_per_cpu_cache(void)
+{
+	/*
+	 * per_cpu_cache[] is initialised to contain "impossible"
+	 * evntsel values guaranteed to differ from anything accepted
+	 * by perfctr_cpu_update_control(). This way, initialisation of
+	 * a CPU's evntsel MSRs will happen automatically the first time
+	 * perfctr_cpu_write_control() executes on it.
+	 * All-bits-one works for all currently supported processors.
+	 * The memset also sets the ids to -1, which is intentional.
+	 */
+	memset(per_cpu_cache, ~0, sizeof per_cpu_cache);
+}
+
+int __init perfctr_cpu_init(void)
+{
+	int err = -ENODEV;
+
+	preempt_disable();
+
+	/* RDPMC and RDTSC are on by default. They will be disabled
+	   by the init procedures if necessary. */
+	perfctr_info.cpu_features = PERFCTR_FEATURE_RDPMC | PERFCTR_FEATURE_RDTSC;
+
+	switch( boot_cpu_data.x86_vendor ) {
+	case X86_VENDOR_AMD:
+		err = amd_init();
+		break;
+	}
+	if( err ) {
+		err = generic_init();	/* last resort */
+		if( err )
+			goto out;
+	}
+	do_init_tests();
+
+	invalidate_per_cpu_cache();
+
+	perfctr_info.cpu_khz = cpu_khz;
+	perfctr_info.tsc_to_cpu_mult = 1;
+
+ out:
+	preempt_enable();
+	return err;
+}
+
+void __exit perfctr_cpu_exit(void)
+{
+}
+
+/****************************************************************
+ *								*
+ * Hardware reservation.					*
+ *								*
+ ****************************************************************/
+
+static DECLARE_MUTEX(mutex);
+static const char *current_service = 0;
+
+const char *perfctr_cpu_reserve(const char *service)
+{
+	const char *ret;
+
+	down(&mutex);
+	ret = current_service;
+	if( ret )
+		goto out_up;
+	ret = "unknown driver (oprofile?)";
+	if( reserve_lapic_nmi() < 0 )
+		goto out_up;
+	current_service = service;
+	if( perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC )
+		mmu_cr4_features |= X86_CR4_PCE;
+	on_each_cpu(perfctr_cpu_init_one, NULL, 1, 1);
+	perfctr_cpu_set_ihandler(NULL);
+	x86_pm_init();
+	ret = NULL;
+ out_up:
+	up(&mutex);
+	return ret;
+}
+
+void perfctr_cpu_release(const char *service)
+{
+	down(&mutex);
+	if( service != current_service ) {
+		printk(KERN_ERR "%s: attempt by %s to release while reserved by %s\n",
+		       __FUNCTION__, service, current_service);
+		goto out_up;
+	}
+	/* power down the counters */
+	invalidate_per_cpu_cache();
+	if( perfctr_info.cpu_features & PERFCTR_FEATURE_RDPMC )
+		mmu_cr4_features &= ~X86_CR4_PCE;
+	on_each_cpu(perfctr_cpu_exit_one, NULL, 1, 1);
+	perfctr_cpu_set_ihandler(NULL);
+	x86_pm_exit();
+	current_service = 0;
+	release_lapic_nmi();
+ out_up:
+	up(&mutex);
+}
diff -ruN linux-2.6.6-mm2/include/asm-x86_64/hw_irq.h linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/hw_irq.h
--- linux-2.6.6-mm2/include/asm-x86_64/hw_irq.h	2004-02-18 11:09:53.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/hw_irq.h	2004-05-14 14:45:43.980229843 +0200
@@ -65,14 +65,15 @@
  * sources per level' errata.
  */
 #define LOCAL_TIMER_VECTOR	0xef
+#define LOCAL_PERFCTR_VECTOR	0xee
 
 /*
- * First APIC vector available to drivers: (vectors 0x30-0xee)
+ * First APIC vector available to drivers: (vectors 0x30-0xed)
  * we start at 0x31 to spread out vectors evenly between priority
  * levels. (0x80 is the syscall vector)
  */
 #define FIRST_DEVICE_VECTOR	0x31
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in irq.h */
 
 
 #ifndef __ASSEMBLY__
diff -ruN linux-2.6.6-mm2/include/asm-x86_64/ia32_unistd.h linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/ia32_unistd.h
--- linux-2.6.6-mm2/include/asm-x86_64/ia32_unistd.h	2004-05-10 11:14:37.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/ia32_unistd.h	2004-05-14 14:45:43.980229843 +0200
@@ -288,6 +288,8 @@
 #define __NR_ia32_mq_timedreceive	(__NR_ia32_mq_open+3)
 #define __NR_ia32_mq_notify		(__NR_ia32_mq_open+4)
 #define __NR_ia32_mq_getsetattr	(__NR_ia32_mq_open+5)
+/* 283: reserved for kexec */
+#define __NR_ia32_perfctr	284
 
 #define IA32_NR_syscalls 285	/* must be > than biggest syscall! */
 
diff -ruN linux-2.6.6-mm2/include/asm-x86_64/irq.h linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/irq.h
--- linux-2.6.6-mm2/include/asm-x86_64/irq.h	2004-05-10 11:14:37.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/irq.h	2004-05-14 14:45:43.980229843 +0200
@@ -29,7 +29,7 @@
  */
 #define NR_VECTORS 256
 
-#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in hw_irq.h */
+#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in hw_irq.h */
 
 #ifdef CONFIG_PCI_USE_VECTOR
 #define NR_IRQS FIRST_SYSTEM_VECTOR
diff -ruN linux-2.6.6-mm2/include/asm-x86_64/perfctr.h linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/perfctr.h
--- linux-2.6.6-mm2/include/asm-x86_64/perfctr.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/perfctr.h	2004-05-14 14:45:43.980229843 +0200
@@ -0,0 +1,166 @@
+/* $Id: perfctr.h,v 1.12 2004/05/12 21:28:27 mikpe Exp $
+ * x86_64 Performance-Monitoring Counters driver
+ *
+ * Based on <asm-i386/perfctr.h>:
+ * - removed P5- and P4-only stuff
+ * - reduced the number of counters from 18 to 4
+ * - PERFCTR_INTERRUPT_SUPPORT is always 1
+ * - perfctr_cpus_forbidden_mask never needed (it's P4-only)
+ *
+ * Copyright (C) 2003-2004  Mikael Pettersson
+ */
+#ifndef _ASM_X86_64_PERFCTR_H
+#define _ASM_X86_64_PERFCTR_H
+
+struct perfctr_sum_ctrs {
+	unsigned long long tsc;
+	unsigned long long pmc[4];
+};
+
+struct perfctr_cpu_control {
+	unsigned int tsc_on;
+	unsigned int nractrs;		/* # of a-mode counters */
+	unsigned int nrictrs;		/* # of i-mode counters */
+	unsigned int pmc_map[4];
+	unsigned int evntsel[4];	/* one per counter, even on P5 */
+	int ireset[4];			/* < 0, for i-mode counters */
+	unsigned int _reserved1;
+	unsigned int _reserved2;
+	unsigned int _reserved3;
+	unsigned int _reserved4;
+};
+
+struct perfctr_cpu_state {
+	unsigned int cstatus;
+	struct {	/* k1 is opaque in the user ABI */
+		unsigned int id;
+		int isuspend_cpu;
+	} k1;
+	/* The two tsc fields must be inlined. Placing them in a
+	   sub-struct causes unwanted internal padding on x86-64. */
+	unsigned int tsc_start;
+	unsigned long long tsc_sum;
+	struct {
+		unsigned int map;
+		unsigned int start;
+		unsigned long long sum;
+	} pmc[4];	/* the size is not part of the user ABI */
+#ifdef __KERNEL__
+	struct perfctr_cpu_control control;
+#endif
+};
+
+/* cstatus is a re-encoding of control.tsc_on/nractrs/nrictrs
+   which should have less overhead in most cases */
+
+static inline
+unsigned int perfctr_mk_cstatus(unsigned int tsc_on, unsigned int nractrs,
+				unsigned int nrictrs)
+{
+	return (tsc_on<<31) | (nrictrs<<16) | ((nractrs+nrictrs)<<8) | nractrs;
+}
+
+static inline unsigned int perfctr_cstatus_enabled(unsigned int cstatus)
+{
+	return cstatus;
+}
+
+static inline int perfctr_cstatus_has_tsc(unsigned int cstatus)
+{
+	return (int)cstatus < 0;	/* test and jump on sign */
+}
+
+static inline unsigned int perfctr_cstatus_nractrs(unsigned int cstatus)
+{
+	return cstatus & 0x7F;		/* and with imm8 */
+}
+
+static inline unsigned int perfctr_cstatus_nrctrs(unsigned int cstatus)
+{
+	return (cstatus >> 8) & 0x7F;
+}
+
+static inline unsigned int perfctr_cstatus_has_ictrs(unsigned int cstatus)
+{
+	return cstatus & (0x7F << 16);
+}
+
+/*
+ * 'struct siginfo' support for perfctr overflow signals.
+ * In unbuffered mode, si_code is set to SI_PMC_OVF and a bitmask
+ * describing which perfctrs overflowed is put in si_pmc_ovf_mask.
+ * A bitmask is used since more than one perfctr can have overflowed
+ * by the time the interrupt handler runs.
+ *
+ * glibc's <signal.h> doesn't seem to define __SI_FAULT or __SI_CODE(),
+ * and including <asm/siginfo.h> as well may cause redefinition errors,
+ * so the user and kernel values are different #defines here.
+ */
+#ifdef __KERNEL__
+#define SI_PMC_OVF	(__SI_FAULT|'P')
+#else
+#define SI_PMC_OVF	('P')
+#endif
+#define si_pmc_ovf_mask	_sifields._pad[0] /* XXX: use an unsigned field later */
+
+/* version number for user-visible CPU-specific data */
+#define PERFCTR_CPU_VERSION	0x0500	/* 5.0 */
+
+#ifdef __KERNEL__
+
+#if defined(CONFIG_PERFCTR)
+
+/* Driver init/exit. */
+extern int perfctr_cpu_init(void);
+extern void perfctr_cpu_exit(void);
+
+/* CPU type name. */
+extern char *perfctr_cpu_name;
+
+/* Hardware reservation. */
+extern const char *perfctr_cpu_reserve(const char *service);
+extern void perfctr_cpu_release(const char *service);
+
+/* PRE: state has no running interrupt-mode counters.
+   Check that the new control data is valid.
+   Update the driver's private control data.
+   Returns a negative error code if the control data is invalid. */
+extern int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global);
+
+/* Read a-mode counters. Subtract from start and accumulate into sums.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_suspend(struct perfctr_cpu_state *state);
+
+/* Write control registers. Read a-mode counters into start.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_resume(struct perfctr_cpu_state *state);
+
+/* Perform an efficient combined suspend/resume operation.
+   Must be called with preemption disabled. */
+extern void perfctr_cpu_sample(struct perfctr_cpu_state *state);
+
+/* The type of a perfctr overflow interrupt handler.
+   It will be called in IRQ context, with preemption disabled. */
+typedef void (*perfctr_ihandler_t)(unsigned long pc);
+
+/* CONFIG_X86_LOCAL_APIC is always defined on x86-64, so overflow
+   interrupt support is always included. */
+#define PERFCTR_INTERRUPT_SUPPORT 1
+
+extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
+extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
+extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
+
+#endif	/* CONFIG_PERFCTR */
+
+#if defined(CONFIG_PERFCTR)
+extern void perfctr_interrupt(void);
+#define perfctr_vector_init()	\
+	set_intr_gate(LOCAL_PERFCTR_VECTOR, perfctr_interrupt)
+#else
+#define perfctr_vector_init()	do{}while(0)
+#endif
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _ASM_X86_64_PERFCTR_H */
diff -ruN linux-2.6.6-mm2/include/asm-x86_64/processor.h linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/processor.h
--- linux-2.6.6-mm2/include/asm-x86_64/processor.h	2004-05-14 14:02:13.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/processor.h	2004-05-14 14:45:43.980229843 +0200
@@ -253,6 +253,8 @@
 	unsigned long	*io_bitmap_ptr;
 /* cached TLS descriptors. */
 	u64 tls_array[GDT_ENTRY_TLS_ENTRIES];
+/* performance counters */
+	struct vperfctr *perfctr;
 };
 
 #define INIT_THREAD  {}
diff -ruN linux-2.6.6-mm2/include/asm-x86_64/unistd.h linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/unistd.h
--- linux-2.6.6-mm2/include/asm-x86_64/unistd.h	2004-05-14 14:02:13.000000000 +0200
+++ linux-2.6.6-mm2.perfctr-2.7.2.x86_64/include/asm-x86_64/unistd.h	2004-05-14 14:45:43.980229843 +0200
@@ -552,8 +552,10 @@
 __SYSCALL(__NR_mq_notify, sys_mq_notify)
 #define __NR_mq_getsetattr 	245
 __SYSCALL(__NR_mq_getsetattr, sys_mq_getsetattr)
+#define __NR_perfctr		246
+__SYSCALL(__NR_perfctr, sys_perfctr)
 
-#define __NR_syscall_max __NR_mq_getsetattr
+#define __NR_syscall_max __NR_perfctr
 #ifndef __NO_STUBS
 
 /* user-visible error numbers are in the range -1 - -4095 */
