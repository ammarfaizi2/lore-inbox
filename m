Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264826AbUEaW32@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264826AbUEaW32 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 May 2004 18:29:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264830AbUEaW31
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 May 2004 18:29:27 -0400
Received: from aun.it.uu.se ([130.238.12.36]:17341 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264826AbUEaWUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 May 2004 18:20:50 -0400
Date: Tue, 1 Jun 2004 00:20:38 +0200 (MEST)
Message-Id: <200405312220.i4VMKcfX012341@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][4/6] perfctr-2.7.3 for 2.6.7-rc1-mm1: PowerPC
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr-2.7.3 for 2.6.7-rc1-mm1, part 4/6:

- PowerPC driver and arch changes

 arch/ppc/Kconfig            |    2 
 arch/ppc/kernel/misc.S      |    6 
 arch/ppc/kernel/process.c   |    6 
 drivers/perfctr/ppc.c       |  964 ++++++++++++++++++++++++++++++++++++++++++++
 drivers/perfctr/ppc_tests.c |  286 +++++++++++++
 drivers/perfctr/ppc_tests.h |   12 
 include/asm-ppc/perfctr.h   |  170 +++++++
 include/asm-ppc/processor.h |    1 
 include/asm-ppc/reg.h       |   85 +++
 include/asm-ppc/unistd.h    |    8 
 10 files changed, 1524 insertions(+), 16 deletions(-)

diff -ruN linux-2.6.7-rc1-mm1/arch/ppc/Kconfig linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/arch/ppc/Kconfig
--- linux-2.6.7-rc1-mm1/arch/ppc/Kconfig	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/arch/ppc/Kconfig	2004-05-31 23:47:05.422821000 +0200
@@ -214,6 +214,8 @@
 	depends on 4xx || 8xx
 	default y
 
+source "drivers/perfctr/Kconfig"
+
 endmenu
 
 menu "Platform options"
diff -ruN linux-2.6.7-rc1-mm1/arch/ppc/kernel/misc.S linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/arch/ppc/kernel/misc.S
--- linux-2.6.7-rc1-mm1/arch/ppc/kernel/misc.S	2004-05-30 15:59:07.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/arch/ppc/kernel/misc.S	2004-05-31 23:47:05.422821000 +0200
@@ -1398,3 +1398,9 @@
 	.long sys_mq_notify
 	.long sys_mq_getsetattr
 	.long sys_ni_syscall		/* 268 reserved for sys_kexec_load */
+	.long sys_perfctr_info
+	.long sys_vperfctr_open		/* 270 */
+	.long sys_vperfctr_control
+	.long sys_vperfctr_unlink
+	.long sys_vperfctr_iresume
+	.long sys_vperfctr_read
diff -ruN linux-2.6.7-rc1-mm1/arch/ppc/kernel/process.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/arch/ppc/kernel/process.c
--- linux-2.6.7-rc1-mm1/arch/ppc/kernel/process.c	2004-05-30 15:59:30.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/arch/ppc/kernel/process.c	2004-05-31 23:47:05.422821000 +0200
@@ -35,6 +35,7 @@
 #include <linux/init_task.h>
 #include <linux/module.h>
 #include <linux/kallsyms.h>
+#include <linux/perfctr.h>
 #include <linux/mqueue.h>
 
 #include <asm/pgtable.h>
@@ -254,7 +255,9 @@
 		new->thread.regs->msr |= MSR_VEC;
 	new_thread = &new->thread;
 	old_thread = &current->thread;
+	perfctr_suspend_thread(&prev->thread);
 	last = _switch(old_thread, new_thread);
+	perfctr_resume_thread(&current->thread);
 	local_irq_restore(s);
 	return last;
 }
@@ -323,6 +326,7 @@
 		last_task_used_math = NULL;
 	if (last_task_used_altivec == current)
 		last_task_used_altivec = NULL;
+	perfctr_exit_thread(&current->thread);
 }
 
 void flush_thread(void)
@@ -409,6 +413,8 @@
 
 	p->thread.last_syscall = -1;
 
+	perfctr_copy_thread(&p->thread);
+
 	return 0;
 }
 
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/ppc.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/drivers/perfctr/ppc.c
--- linux-2.6.7-rc1-mm1/drivers/perfctr/ppc.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/drivers/perfctr/ppc.c	2004-05-31 23:47:05.422821000 +0200
@@ -0,0 +1,964 @@
+/* $Id: ppc.c,v 1.12 2004/05/31 18:13:42 mikpe Exp $
+ * PPC32 performance-monitoring counters driver.
+ *
+ * Copyright (C) 2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/perfctr.h>
+#include <linux/seq_file.h>
+#include <asm/machdep.h>
+#include <asm/time.h>		/* tb_ticks_per_jiffy, get_tbl() */
+
+#include "ppc_tests.h"
+
+/* Support for lazy evntsel and perfctr SPR updates. */
+struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
+	union {
+		unsigned int id;	/* cache owner id */
+	} k1;
+	/* Physically indexed cache of the MMCRs. */
+	unsigned int ppc_mmcr[3];
+} ____cacheline_aligned;
+static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
+
+/* Structure for counter snapshots, as 32-bit values. */
+struct perfctr_low_ctrs {
+	unsigned int tsc;
+	unsigned int pmc[6];
+};
+
+enum pm_type {
+    PM_604,
+    PM_604e,
+    PM_750,	/* XXX: Minor event set diffs between IBM and Moto. */
+    PM_7400,
+    PM_7450,
+};
+static enum pm_type pm_type;
+
+/* Bits users shouldn't set in control.ppc.mmcr0:
+ * - PMXE because we don't yet support overflow interrupts
+ * - PMC1SEL/PMC2SEL because event selectors are in control.evntsel[]
+ */
+#define MMCR0_RESERVED		(MMCR0_PMXE | MMCR0_PMC1SEL | MMCR0_PMC2SEL)
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
+#if PERFCTR_INTERRUPT_SUPPORT
+static void perfctr_default_ihandler(unsigned long pc)
+{
+}
+
+static perfctr_ihandler_t perfctr_ihandler = perfctr_default_ihandler;
+
+void do_perfctr_interrupt(struct pt_regs *regs)
+{
+	preempt_disable();
+	(*perfctr_ihandler)(regs->nip);
+	preempt_enable_no_resched();
+}
+
+void perfctr_cpu_set_ihandler(perfctr_ihandler_t ihandler)
+{
+	perfctr_ihandler = ihandler ? ihandler : perfctr_default_ihandler;
+}
+
+#else
+#define perfctr_cstatus_has_ictrs(cstatus)	0
+#endif
+
+#if defined(CONFIG_SMP) && PERFCTR_INTERRUPT_SUPPORT
+
+static inline void
+set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu)
+{
+	state->k1.isuspend_cpu = cpu;
+}
+
+static inline int
+is_isuspend_cpu(const struct perfctr_cpu_state *state, int cpu)
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
+static inline void set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu) { }
+static inline int is_isuspend_cpu(const struct perfctr_cpu_state *state, int cpu) { return 1; }
+static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state) { }
+#endif
+
+/****************************************************************
+ *								*
+ * Driver procedures.						*
+ *								*
+ ****************************************************************/
+
+/*
+ * The PowerPC 604/750/74xx family.
+ *
+ * Common features
+ * ---------------
+ * - Per counter event selection data in subfields of control registers.
+ *   MMCR0 contains both global control and PMC1/PMC2 event selectors.
+ * - Overflow interrupt support is present in all processors, but an
+ *   erratum makes it difficult to use in 750/7400/7410 processors.
+ * - There is no concept of per-counter qualifiers:
+ *   - User-mode/supervisor-mode restrictions are global.
+ *   - Two groups of counters, PMC1 and PMC2-PMC<highest>. Each group
+ *     has a single overflow interrupt/event enable/disable flag.
+ * - The instructions used to read (mfspr) and write (mtspr) the control
+ *   and counter registers (SPRs) only support hardcoded register numbers.
+ *   There is no support for accessing an SPR via a runtime value.
+ * - Each counter supports its own unique set of events. However, events
+ *   0-1 are common for PMC1-PMC4, and events 2-4 are common for PMC1-PMC4.
+ * - There is no separate high-resolution core clock counter.
+ *   The time-base counter is available, but it typically runs an order of
+ *   magnitude slower than the core clock.
+ *   Any performance counter can be programmed to count core clocks, but
+ *   doing this (a) reserves one PMC, and (b) needs indirect accesses
+ *   since the SPR number in general isn't known at compile-time.
+ *
+ * Driver notes
+ * ------------
+ * - The driver currently does not support performance monitor interrupts,
+ *   mostly because of the 750/7400/7410 erratum. Working around it would
+ *   require disabling the decrementer interrupt, reserving a performance
+ *   counter and setting it up for TBL bit-flip events, and having the PMI
+ *   handler invoke the decrementer handler.
+ *
+ * 604
+ * ---
+ * 604 has MMCR0, PMC1, PMC2, SIA, and SDA.
+ *
+ * MMCR0[THRESHOLD] is not automatically multiplied.
+ *
+ * On the 604, software must always reset MMCR0[ENINT] after
+ * taking a PMI. This is not the case for the 604e.
+ *
+ * 604e
+ * ----
+ * 604e adds MMCR1, PMC3, and PMC4.
+ * Bus-to-core multiplier is available via HID1[PLL_CFG].
+ *
+ * MMCR0[THRESHOLD] is automatically multiplied by 4.
+ *
+ * When the 604e vectors to the PMI handler, it automatically
+ * clears any pending PMIs. Unlike the 604, the 604e does not
+ * require MMCR0[ENINT] to be cleared (and possibly reset)
+ * before external interrupts can be re-enabled.
+ *
+ * 750
+ * ---
+ * 750 adds user-readable MMCRn/PMCn/SIA registers, and removes SDA.
+ *
+ * MMCR0[THRESHOLD] is not automatically multiplied.
+ *
+ * Motorola MPC750UM.pdf, page C-78, states: "The performance monitor
+ * of the MPC755 functions the same as that of the MPC750, (...), except
+ * that for both the MPC750 and MPC755, no combination of the thermal
+ * assist unit, the decrementer register, and the performance monitor
+ * can be used at any one time. If exceptions for any two of these
+ * functional blocks are enabled together, multiple exceptions caused
+ * by any of these three blocks cause unpredictable results."
+ *
+ * IBM 750CXe_Err_DD2X.pdf, Erratum #13, states that a PMI which
+ * occurs immediately after a delayed decrementer exception can
+ * corrupt SRR0, causing the processor to hang. It also states that
+ * PMIs via TB bit transitions can be used to simulate the decrementer.
+ *
+ * 750FX adds dual-PLL support and programmable core frequency switching.
+ *
+ * 74xx
+ * ----
+ * 7400 adds MMCR2 and BAMR.
+ *
+ * MMCR0[THRESHOLD] is multiplied by 2 or 32, as specified
+ * by MMCR2[THRESHMULT].
+ *
+ * 74xx changes the semantics of several MMCR0 control bits,
+ * compared to 604/750.
+ *
+ * PPC7410 Erratum No. 10: Like the MPC750 TAU/DECR/PMI erratum.
+ * Erratum No. 14 marks TAU as unsupported in 7410, but this leaves
+ * perfmon and decrementer interrupts as being mutually exclusive.
+ * Affects PPC7410 1.0-1.2 (PVR 0x800C1100-0x800C1102). 1.3 and up
+ * (PVR 0x800C1103 up) are Ok.
+ *
+ * 7450 adds PMC5 and PMC6.
+ *
+ * 7455/7445 V3.3 (PVR 80010303) and later use the 7457 PLL table,
+ * earlier revisions use the 7450 PLL table
+ */
+
+static inline unsigned int read_pmc(unsigned int pmc)
+{
+	switch (pmc) {
+	default: /* impossible, but silences gcc warning */
+	case 0:
+		return mfspr(SPRN_PMC1);
+	case 1:
+		return mfspr(SPRN_PMC2);
+	case 2:
+		return mfspr(SPRN_PMC3);
+	case 3:
+		return mfspr(SPRN_PMC4);
+	case 4:
+		return mfspr(SPRN_PMC5);
+	case 5:
+		return mfspr(SPRN_PMC6);
+	}
+}
+
+static void ppc_read_counters(/*const*/ struct perfctr_cpu_state *state,
+			      struct perfctr_low_ctrs *ctrs)
+{
+	unsigned int cstatus, nrctrs, i;
+
+	cstatus = state->cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus))
+		ctrs->tsc = get_tbl();
+	nrctrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		ctrs->pmc[i] = read_pmc(pmc);
+	}
+	/* handle MMCR0 changes due to FCECE or TRIGGER on 74xx */
+	if (state->cstatus & (1<<30)) {
+		unsigned int mmcr0 = mfspr(SPRN_MMCR0);
+		state->ppc_mmcr[0] = mmcr0;
+		__get_cpu_var(per_cpu_cache).ppc_mmcr[0] = mmcr0;
+	}
+}
+
+static unsigned int pmc_max_event(unsigned int pmc)
+{
+	switch (pmc) {
+	default: /* impossible, but silences gcc warning */
+	case 0:
+		return 127;
+	case 1:
+		return 63;
+	case 2:
+		return 31;
+	case 3:
+		return 31;
+	case 4:
+		return 31;
+	case 5:
+		return 63;
+	}
+}
+
+static unsigned int get_nr_pmcs(void)
+{
+	switch (pm_type) {
+	case PM_7450:
+		return 6;
+	case PM_7400:
+	case PM_750:
+	case PM_604e:
+		return 4;
+	default: /* impossible, but silences gcc warning */
+	case PM_604:
+		return 2;
+	}
+}
+
+static int ppc_check_control(struct perfctr_cpu_state *state)
+{
+	unsigned int i, nrctrs, pmc_mask, pmc;
+	unsigned int nr_pmcs, evntsel[6];
+
+	nr_pmcs = get_nr_pmcs();
+	nrctrs = state->control.nractrs;
+	if (state->control.nrictrs || nrctrs > nr_pmcs)
+		return -EINVAL;
+
+	pmc_mask = 0;
+	memset(evntsel, 0, sizeof evntsel);
+	for(i = 0; i < nrctrs; ++i) {
+		pmc = state->control.pmc_map[i];
+		state->pmc[i].map = pmc;
+		if (pmc >= nr_pmcs || (pmc_mask & (1<<pmc)))
+			return -EINVAL;
+		pmc_mask |= (1<<pmc);
+
+		evntsel[pmc] = state->control.evntsel[i];
+		if (evntsel[pmc] > pmc_max_event(pmc))
+			return -EINVAL;
+	}
+
+	switch (pm_type) {
+	case PM_7450:
+		if (state->control.ppc.mmcr2 & MMCR2_RESERVED)
+			return -EINVAL;
+		state->ppc_mmcr[2] = state->control.ppc.mmcr2;
+		break;
+	default:
+		if (state->control.ppc.mmcr2)
+			return -EINVAL;
+		state->ppc_mmcr[2] = 0;
+	}
+
+	if (state->control.ppc.mmcr0 & MMCR0_RESERVED)
+		return -EINVAL;
+	state->ppc_mmcr[0] = (state->control.ppc.mmcr0
+			      | (evntsel[0] << (31-25))
+			      | (evntsel[1] << (31-31)));
+
+	state->ppc_mmcr[1] = ((  evntsel[2] << (31-4))
+			      | (evntsel[3] << (31-9))
+			      | (evntsel[4] << (31-14))
+			      | (evntsel[5] << (31-20)));
+
+	state->k1.id = new_id();
+
+	/*
+	 * MMCR0[FC] and MMCR0[TRIGGER] may change on 74xx if FCECE or
+	 * TRIGGER is set. To avoid undoing those changes, we must read
+	 * MMCR0 back into state->ppc_mmcr[0] and the cache at suspends.
+	 */
+	switch (pm_type) {
+	case PM_7450:
+	case PM_7400:
+		if (state->ppc_mmcr[0] & (MMCR0_FCECE | MMCR0_TRIGGER))
+			state->cstatus |= (1<<30);
+	default:
+		;
+	}
+
+	return 0;
+}
+
+#if PERFCTR_INTERRUPT_SUPPORT
+static void ppc_isuspend(struct perfctr_cpu_state *state)
+{
+	// XXX
+}
+
+static void ppc_iresume(const struct perfctr_cpu_state *state)
+{
+	// XXX
+}
+#endif
+
+static void ppc_write_control(const struct perfctr_cpu_state *state)
+{
+	struct per_cpu_cache *cache;
+	unsigned int value;
+
+	cache = &__get_cpu_var(per_cpu_cache);
+	if (cache->k1.id == state->k1.id)
+		return;
+	/*
+	 * Order matters here: update threshmult and event
+	 * selectors before updating global control, which
+	 * potentially enables PMIs.
+	 *
+	 * Since mtspr doesn't accept a runtime value for the
+	 * SPR number, unroll the loop so each mtspr targets
+	 * a constant SPR.
+	 *
+	 * For processors without MMCR2, we ensure that the
+	 * cache and the state indicate the same value for it,
+	 * preventing any actual mtspr to it. Ditto for MMCR1.
+	 */
+	value = state->ppc_mmcr[2];
+	if (value != cache->ppc_mmcr[2]) {
+		cache->ppc_mmcr[2] = value;
+		mtspr(SPRN_MMCR2, value);
+	}
+	value = state->ppc_mmcr[1];
+	if (value != cache->ppc_mmcr[1]) {
+		cache->ppc_mmcr[1] = value;
+		mtspr(SPRN_MMCR1, value);
+	}
+	value = state->ppc_mmcr[0];
+	if (value != cache->ppc_mmcr[0]) {
+		cache->ppc_mmcr[0] = value;
+		mtspr(SPRN_MMCR0, value);
+	}
+	cache->k1.id = state->k1.id;
+}
+
+static void ppc_clear_counters(void)
+{
+	switch (pm_type) {
+	case PM_7450:
+	case PM_7400:
+		mtspr(SPRN_MMCR2, 0);
+		mtspr(SPRN_BAMR, 0);
+	case PM_750:
+	case PM_604e:
+		mtspr(SPRN_MMCR1, 0);
+	case PM_604:
+		mtspr(SPRN_MMCR0, 0);
+	}
+	switch (pm_type) {
+	case PM_7450:
+		mtspr(SPRN_PMC6, 0);
+		mtspr(SPRN_PMC5, 0);
+	case PM_7400:
+	case PM_750:
+	case PM_604e:
+		mtspr(SPRN_PMC4, 0);
+		mtspr(SPRN_PMC3, 0);
+	case PM_604:
+		mtspr(SPRN_PMC2, 0);
+		mtspr(SPRN_PMC1, 0);
+	}
+}
+
+/*
+ * Driver methods, internal and exported.
+ */
+
+static void perfctr_cpu_write_control(const struct perfctr_cpu_state *state)
+{
+	return ppc_write_control(state);
+}
+
+static void perfctr_cpu_read_counters(/*const*/ struct perfctr_cpu_state *state,
+				      struct perfctr_low_ctrs *ctrs)
+{
+	return ppc_read_counters(state, ctrs);
+}
+
+#if PERFCTR_INTERRUPT_SUPPORT
+static void perfctr_cpu_isuspend(struct perfctr_cpu_state *state)
+{
+	return ppc_isuspend(state);
+}
+
+static void perfctr_cpu_iresume(const struct perfctr_cpu_state *state)
+{
+	return ppc_iresume(state);
+}
+
+/* Call perfctr_cpu_ireload() just before perfctr_cpu_resume() to
+   bypass internal caching and force a reload if the I-mode PMCs. */
+void perfctr_cpu_ireload(struct perfctr_cpu_state *state)
+{
+#ifdef CONFIG_SMP
+	clear_isuspend_cpu(state);
+#else
+	__get_cpu_var(per_cpu_cache).k1.id = 0;
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
+		if ((int)state->pmc[pmc].start < 0) { /* PPC-specific */
+			/* XXX: "+=" to correct for overshots */
+			state->pmc[pmc].start = state->control.ireset[pmc];
+			pmc_mask |= (1 << pmc);
+		}
+	}
+	/* XXX: if pmc_mask == 0, then it must have been a TBL bit flip */
+	/* XXX: HW cleared MMCR0[ENINT]. We presumably cleared the entire
+	   MMCR0, so the re-enable occurs automatically later, no? */
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
+		if (state->control.ireset[i] < 0)	/* PPC-specific */
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
+#else	/* PERFCTR_INTERRUPT_SUPPORT */
+static inline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state) { }
+static inline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state) { }
+static inline int check_ireset(const struct perfctr_cpu_state *state) { return 0; }
+static inline void setup_imode_start_values(struct perfctr_cpu_state *state) { }
+#endif	/* PERFCTR_INTERRUPT_SUPPORT */
+
+static int check_control(struct perfctr_cpu_state *state)
+{
+	return ppc_check_control(state);
+}
+
+int perfctr_cpu_update_control(struct perfctr_cpu_state *state, int is_global)
+{
+	int err;
+
+	clear_isuspend_cpu(state);
+	state->cstatus = 0;
+
+	/* disallow i-mode counters if we cannot catch the interrupts */
+	if (!(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
+	    && state->control.nrictrs)
+		return -EPERM;
+
+	err = check_ireset(state);
+	if (err < 0)
+		return err;
+	err = check_control(state); /* may initialise state->cstatus */
+	if (err < 0)
+		return err;
+	state->cstatus |= perfctr_mk_cstatus(state->control.tsc_on,
+					     state->control.nractrs,
+					     state->control.nrictrs);
+	setup_imode_start_values(state);
+	return 0;
+}
+
+void perfctr_cpu_suspend(struct perfctr_cpu_state *state)
+{
+	unsigned int i, cstatus, nractrs;
+	struct perfctr_low_ctrs now;
+
+	if (perfctr_cstatus_has_ictrs(state->cstatus))
+	    perfctr_cpu_isuspend(state);
+	perfctr_cpu_read_counters(state, &now);
+	cstatus = state->cstatus;
+	if (perfctr_cstatus_has_tsc(cstatus))
+		state->tsc_sum += now.tsc - state->tsc_start;
+	nractrs = perfctr_cstatus_nractrs(cstatus);
+	for(i = 0; i < nractrs; ++i)
+		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
+}
+
+void perfctr_cpu_resume(struct perfctr_cpu_state *state)
+{
+	if (perfctr_cstatus_has_ictrs(state->cstatus))
+	    perfctr_cpu_iresume(state);
+	perfctr_cpu_write_control(state);
+	//perfctr_cpu_read_counters(state, &state->start);
+	{
+		struct perfctr_low_ctrs now;
+		unsigned int i, cstatus, nrctrs;
+		perfctr_cpu_read_counters(state, &now);
+		cstatus = state->cstatus;
+		if (perfctr_cstatus_has_tsc(cstatus))
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
+	if (perfctr_cstatus_has_tsc(cstatus)) {
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
+static void perfctr_cpu_clear_counters(void)
+{
+	struct per_cpu_cache *cache;
+
+	cache = &__get_cpu_var(per_cpu_cache);
+	memset(cache, 0, sizeof *cache);
+	cache->k1.id = -1;
+
+	ppc_clear_counters();
+}
+
+/****************************************************************
+ *								*
+ * Processor detection and initialisation procedures.		*
+ *								*
+ ****************************************************************/
+
+/* Derive CPU core frequency from TB frequency and PLL_CFG. */
+
+enum pll_type {
+	PLL_NONE,	/* for e.g. 604 which has no HID1[PLL_CFG] */
+	PLL_604e,
+	PLL_750,
+	PLL_750FX,
+	PLL_7400,
+	PLL_7450,
+	PLL_7457,
+};
+
+/* These are the known bus-to-core ratios, indexed by PLL_CFG.
+   Multiplied by 2 since half-multiplier steps are present. */
+
+static unsigned char cfg_ratio_604e[16] __initdata = { // *2
+	2, 2, 14, 2, 4, 13, 5, 9,
+	6, 11, 8, 10, 3, 12, 7, 0
+};
+
+static unsigned char cfg_ratio_750[16] __initdata = { // *2
+	5, 15, 14, 2, 4, 13, 20, 9, // 0b0110 is 18 if L1_TSTCLK=0, but that is abnormal
+	6, 11, 8, 10, 16, 12, 7, 0
+};
+
+static unsigned char cfg_ratio_750FX[32] __initdata = { // *2
+	0, 0, 2, 2, 4, 5, 6, 7,
+	8, 9, 10, 11, 12, 13, 14, 15,
+	16, 17, 18, 19, 20, 22, 24, 26,
+	28, 30, 32, 34, 36, 38, 40, 0
+};
+
+static unsigned char cfg_ratio_7400[16] __initdata = { // *2
+	18, 15, 14, 2, 4, 13, 5, 9,
+	6, 11, 8, 10, 16, 12, 7, 0
+};
+
+static unsigned char cfg_ratio_7450[32] __initdata = { // *2
+	1, 0, 15, 30, 14, 0, 2, 0,
+	4, 0, 13, 26, 5, 0, 9, 18,
+	6, 0, 11, 22, 8, 20, 10, 24,
+	16, 28, 12, 32, 7, 0, 0, 0
+};
+
+static unsigned char cfg_ratio_7457[32] __initdata = { // *2
+	23, 34, 15, 30, 14, 36, 2, 40,
+	4, 42, 13, 26, 17, 48, 19, 18,
+	6, 21, 11, 22, 8, 20, 10, 24,
+	16, 28, 12, 32, 27, 56, 0, 25
+};
+
+static unsigned int __init tb_to_core_ratio(enum pll_type pll_type)
+{
+	unsigned char *cfg_ratio;
+	unsigned int shift = 28, mask = 0xF, hid1, pll_cfg, ratio;
+
+	switch (pll_type) {
+	case PLL_604e:
+		cfg_ratio = cfg_ratio_604e;
+		break;
+	case PLL_750:
+		cfg_ratio = cfg_ratio_750;
+		break;
+	case PLL_750FX:
+		cfg_ratio = cfg_ratio_750FX;
+		hid1 = mfspr(SPRN_HID1);
+		switch ((hid1 >> 16) & 0x3) { /* HID1[PI0,PS] */
+		case 0:		/* PLL0 with external config */
+			shift = 31-4;	/* access HID1[PCE] */
+			break;
+		case 2:		/* PLL0 with internal config */
+			shift = 31-20;	/* access HID1[PC0] */
+			break;
+		case 1: case 3:	/* PLL1 */
+			shift = 31-28;	/* access HID1[PC1] */
+			break;
+		}
+		mask = 0x1F;
+		break;
+	case PLL_7400:
+		cfg_ratio = cfg_ratio_7400;
+		break;
+	case PLL_7450:
+		cfg_ratio = cfg_ratio_7450;
+		shift = 12;
+		mask = 0x1F;
+		break;
+	case PLL_7457:
+		cfg_ratio = cfg_ratio_7457;
+		shift = 12;
+		mask = 0x1F;
+		break;
+	default:
+		return 0;
+	}
+	hid1 = mfspr(SPRN_HID1);
+	pll_cfg = (hid1 >> shift) & mask;
+	ratio = cfg_ratio[pll_cfg];
+	if (!ratio)
+		printk(KERN_WARNING "perfctr/%s: unknown PLL_CFG 0x%x\n",
+		       __FILE__, pll_cfg);
+	return (4/2) * ratio;
+}
+
+static unsigned int __init pll_to_core_khz(enum pll_type pll_type)
+{
+	unsigned int tb_to_core = tb_to_core_ratio(pll_type);
+	perfctr_info.tsc_to_cpu_mult = tb_to_core;
+	return tb_ticks_per_jiffy * tb_to_core * (HZ/10) / (1000/10);
+}
+
+/* Extract the CPU clock frequency from /proc/cpuinfo. */
+
+static unsigned int __init parse_clock_khz(struct seq_file *m)
+{
+	/* "/proc/cpuinfo" formats:
+	 *
+	 * "core clock\t: %d MHz\n"	// 8260 (show_percpuinfo)
+	 * "clock\t\t: %ldMHz\n"	// 4xx (show_percpuinfo)
+	 * "clock\t\t: %dMHz\n"		// oak (show_percpuinfo)
+	 * "clock\t\t: %ldMHz\n"	// prep (show_percpuinfo)
+	 * "clock\t\t: %dMHz\n"		// pmac (show_percpuinfo)
+	 * "clock\t\t: %dMHz\n"		// gemini (show_cpuinfo!)
+	 */
+	char *p;
+	unsigned int mhz;
+
+	p = m->buf;
+	p[m->count] = '\0';
+
+	for(;;) {		/* for each line */
+		if (strncmp(p, "core ", 5) == 0)
+			p += 5;
+		do {
+			if (strncmp(p, "clock\t", 6) != 0)
+				break;
+			p += 6;
+			while (*p == '\t')
+				++p;
+			if (*p != ':')
+				break;
+			do {
+				++p;
+			} while (*p == ' ');
+			mhz = simple_strtoul(p, 0, 10);
+			if (mhz)
+				return mhz * 1000;
+		} while (0);
+		for(;;) {	/* skip to next line */
+			switch (*p++) {
+			case '\n':
+				break;
+			case '\0':
+				return 0;
+			default:
+				continue;
+			}
+			break;
+		}
+	}
+}
+
+static unsigned int __init detect_cpu_khz(enum pll_type pll_type)
+{
+	char buf[512];
+	struct seq_file m;
+	unsigned int khz;
+
+	khz = pll_to_core_khz(pll_type);
+	if (khz)
+		return khz;
+
+	memset(&m, 0, sizeof m);
+	m.buf = buf;
+	m.size = (sizeof buf)-1;
+
+	m.count = 0;
+	if (ppc_md.show_percpuinfo != 0 &&
+	    ppc_md.show_percpuinfo(&m, 0) == 0 &&
+	    (khz = parse_clock_khz(&m)) != 0)
+		return khz;
+
+	m.count = 0;
+	if (ppc_md.show_cpuinfo != 0 &&
+	    ppc_md.show_cpuinfo(&m) == 0 &&
+	    (khz = parse_clock_khz(&m)) != 0)
+		return khz;
+
+	printk(KERN_WARNING "perfctr/%s: unable to determine CPU speed\n",
+	       __FILE__);
+	return 0;
+}
+
+static int __init generic_init(void)
+{
+	static char generic_name[] __initdata = "PowerPC 60x/7xx/74xx";
+	unsigned int features;
+	enum pll_type pll_type;
+	unsigned int pvr;
+
+	features = PERFCTR_FEATURE_RDTSC | PERFCTR_FEATURE_RDPMC;
+	pvr = mfspr(SPRN_PVR);
+	switch (PVR_VER(pvr)) {
+	case 0x0004: /* 604 */
+		pm_type = PM_604;
+		pll_type = PLL_NONE;
+		features = PERFCTR_FEATURE_RDTSC;
+		break;
+	case 0x0009: /* 604e;  */
+	case 0x000A: /* 604ev */
+		pm_type = PM_604e;
+		pll_type = PLL_604e;
+		features = PERFCTR_FEATURE_RDTSC;
+		break;
+	case 0x0008: /* 750/740 */
+		pm_type = PM_750;
+		pll_type = PLL_750;
+		break;
+	case 0x7000: case 0x7001: /* IBM750FX */
+	case 0x7002: /* IBM750GX */
+		pm_type = PM_750;
+		pll_type = PLL_750FX;
+		break;
+	case 0x000C: /* 7400 */
+		pm_type = PM_7400;
+		pll_type = PLL_7400;
+		break;
+	case 0x800C: /* 7410 */
+		pm_type = PM_7400;
+		pll_type = PLL_7400;
+		break;
+	case 0x8000: /* 7451/7441 */
+		pm_type = PM_7450;
+		pll_type = PLL_7450;
+		break;
+	case 0x8001: /* 7455/7445 */
+		pm_type = PM_7450;
+		pll_type = ((pvr & 0xFFFF) < 0x0303) ? PLL_7450 : PLL_7457;
+		break;
+	case 0x8002: /* 7457/7447 */
+		pm_type = PM_7450;
+		pll_type = PLL_7457;
+		break;
+	default:
+		printk(KERN_WARNING "perfctr/%s: unknown PowerPC with "
+		       "PVR 0x%08x -- bailing out\n", __FILE__, pvr);
+		return -ENODEV;
+	}
+	perfctr_info.cpu_features = features;
+	perfctr_info.cpu_type = 0; /* user-space should inspect PVR */
+	perfctr_cpu_name = generic_name;
+	perfctr_info.cpu_khz = detect_cpu_khz(pll_type);
+	perfctr_ppc_init_tests();
+	return 0;
+}
+
+static void __init perfctr_cpu_init_one(void *ignore)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	perfctr_cpu_clear_counters();
+}
+
+static void __exit perfctr_cpu_exit_one(void *ignore)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	perfctr_cpu_clear_counters();
+}
+
+static int init_done;
+
+int __init perfctr_cpu_init(void)
+{
+	int err;
+
+	preempt_disable();
+
+	perfctr_info.cpu_features = 0;
+
+	err = generic_init();
+	if (err)
+		goto out;
+
+	perfctr_cpu_init_one(NULL);
+	smp_call_function(perfctr_cpu_init_one, NULL, 1, 1);
+	perfctr_cpu_set_ihandler(NULL);
+	init_done = 1;
+ out:
+	preempt_enable();
+	return err;
+}
+
+void __exit perfctr_cpu_exit(void)
+{
+	preempt_disable();
+	perfctr_cpu_exit_one(NULL);
+	smp_call_function(perfctr_cpu_exit_one, NULL, 1, 1);
+	perfctr_cpu_set_ihandler(NULL);
+	preempt_enable();
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
+	if (!init_done)
+		return "unsupported hardware";
+	down(&mutex);
+	ret = current_service;
+	if (!ret)
+		current_service = service;
+	up(&mutex);
+	return ret;
+}
+
+static void perfctr_cpu_clear_one(void *ignore)
+{
+	/* PREEMPT note: when called via smp_call_function(),
+	   this is in IRQ context with preemption disabled. */
+	perfctr_cpu_clear_counters();
+}
+
+void perfctr_cpu_release(const char *service)
+{
+	down(&mutex);
+	if (service != current_service) {
+		printk(KERN_ERR "%s: attempt by %s to release while reserved by %s\n",
+		       __FUNCTION__, service, current_service);
+	} else {
+		/* power down the counters */
+		on_each_cpu(perfctr_cpu_clear_one, NULL, 1, 1);
+		perfctr_cpu_set_ihandler(NULL);
+		current_service = 0;
+	}
+	up(&mutex);
+}
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/ppc_tests.c linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/drivers/perfctr/ppc_tests.c
--- linux-2.6.7-rc1-mm1/drivers/perfctr/ppc_tests.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/drivers/perfctr/ppc_tests.c	2004-05-31 23:47:05.422821000 +0200
@@ -0,0 +1,286 @@
+/* $Id: ppc_tests.c,v 1.4 2004/05/21 16:57:53 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Optional PPC32-specific init-time tests.
+ *
+ * Copyright (C) 2004  Mikael Pettersson
+ */
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/sched.h>
+#include <linux/fs.h>
+#include <linux/perfctr.h>
+#include <asm/processor.h>
+#include <asm/time.h>	/* for tb_ticks_per_jiffy */
+#include "ppc_tests.h"
+
+#define NITER	256
+#define X2(S)	S"; "S
+#define X8(S)	X2(X2(X2(S)))
+
+static void __init do_read_tbl(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mftbl %0") : "=r"(dummy));
+}
+
+static void __init do_read_pmc1(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_PMC1)) : "=r"(dummy));
+}
+
+static void __init do_read_pmc2(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_PMC2)) : "=r"(dummy));
+}
+
+static void __init do_read_pmc3(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_PMC3)) : "=r"(dummy));
+}
+
+static void __init do_read_pmc4(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_PMC4)) : "=r"(dummy));
+}
+
+static void __init do_read_mmcr0(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_MMCR0)) : "=r"(dummy));
+}
+
+static void __init do_read_mmcr1(unsigned int unused)
+{
+	unsigned int i, dummy;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mfspr %0," __stringify(SPRN_MMCR1)) : "=r"(dummy));
+}
+
+static void __init do_write_pmc2(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_PMC2) ",%0") : : "r"(arg));
+}
+
+static void __init do_write_pmc3(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_PMC3) ",%0") : : "r"(arg));
+}
+
+static void __init do_write_pmc4(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_PMC4) ",%0") : : "r"(arg));
+}
+
+static void __init do_write_mmcr1(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_MMCR1) ",%0") : : "r"(arg));
+}
+
+static void __init do_write_mmcr0(unsigned int arg)
+{
+	unsigned int i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__(X8("mtspr " __stringify(SPRN_MMCR0) ",%0") : : "r"(arg));
+}
+
+static void __init do_empty_loop(unsigned int unused)
+{
+	unsigned i;
+	for(i = 0; i < NITER/8; ++i)
+		__asm__ __volatile__("" : : );
+}
+
+static unsigned __init run(void (*doit)(unsigned int), unsigned int arg)
+{
+	unsigned int start, stop;
+	start = mfspr(SPRN_PMC1);
+	(*doit)(arg);	/* should take < 2^32 cycles to complete */
+	stop = mfspr(SPRN_PMC1);
+	return stop - start;
+}
+
+static void __init init_tests_message(void)
+{
+	unsigned int pvr = mfspr(SPRN_PVR);
+	printk(KERN_INFO "Please email the following PERFCTR INIT lines "
+	       "to mikpe@csd.uu.se\n"
+	       KERN_INFO "To remove this message, rebuild the driver "
+	       "with CONFIG_PERFCTR_INIT_TESTS=n\n");
+	printk(KERN_INFO "PERFCTR INIT: PVR 0x%08x, CPU clock %u kHz, TB clock %u kHz\n",
+	       pvr,
+	       perfctr_info.cpu_khz,
+	       tb_ticks_per_jiffy*(HZ/10)/(1000/10));
+}
+
+static void __init clear(int have_mmcr1)
+{
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_PMC1, 0);
+	mtspr(SPRN_PMC2, 0);
+	if (have_mmcr1) {
+		mtspr(SPRN_MMCR1, 0);
+		mtspr(SPRN_PMC3, 0);
+		mtspr(SPRN_PMC4, 0);
+	}		
+}
+
+static void __init check_fcece(unsigned int pmc1ce)
+{
+	unsigned int mmcr0;
+
+	/*
+	 * This test checks if MMCR0[FC] is set after PMC1 overflows
+	 * when MMCR0[FCECE] is set.
+	 * 74xx documentation states this behaviour, while documentation
+	 * for 604/750 processors doesn't mention this at all.
+	 *
+	 * Also output the value of PMC1 shortly after the overflow.
+	 * This tells us if PMC1 really was frozen. On 604/750, it may not
+	 * freeze since we don't enable PMIs. [No freeze confirmed on 750.]
+	 *
+	 * When pmc1ce == 0, MMCR0[PMC1CE] is zero. It's unclear whether
+	 * this masks all PMC1 overflow events or just PMC1 PMIs.
+	 *
+	 * PMC1 counts processor cycles, with 100 to go before overflowing.
+	 * FCECE is set.
+	 * PMC1CE is clear if !pmc1ce, otherwise set.
+	 */
+	mtspr(SPRN_PMC1, 0x80000000-100);
+	mmcr0 = (1<<(31-6)) | (0x01 << 6);
+	if (pmc1ce)
+		mmcr0 |= (1<<(31-16));
+	mtspr(SPRN_MMCR0, mmcr0);
+	do {
+		do_empty_loop(0);
+	} while (!(mfspr(SPRN_PMC1) & 0x80000000));
+	do_empty_loop(0);
+	printk(KERN_INFO "PERFCTR INIT: %s(%u): MMCR0[FC] is %u, PMC1 is %#x\n",
+	       __FUNCTION__, pmc1ce,
+	       !!(mfspr(SPRN_MMCR0) & (1<<(31-0))), mfspr(SPRN_PMC1));
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_PMC1, 0);
+}
+
+static void __init check_trigger(unsigned int pmc1ce)
+{
+	unsigned int mmcr0;
+
+	/*
+	 * This test checks if MMCR0[TRIGGER] is reset after PMC1 overflows.
+	 * 74xx documentation states this behaviour, while documentation
+	 * for 604/750 processors doesn't mention this at all.
+	 * [No reset confirmed on 750.]
+	 *
+	 * Also output the values of PMC1 and PMC2 shortly after the overflow.
+	 * PMC2 should be equal to PMC1-0x80000000.
+	 *
+	 * When pmc1ce == 0, MMCR0[PMC1CE] is zero. It's unclear whether
+	 * this masks all PMC1 overflow events or just PMC1 PMIs.
+	 *
+	 * PMC1 counts processor cycles, with 100 to go before overflowing.
+	 * PMC2 counts processor cycles, starting from 0.
+	 * TRIGGER is set, so PMC2 doesn't start until PMC1 overflows.
+	 * PMC1CE is clear if !pmc1ce, otherwise set.
+	 */
+	mtspr(SPRN_PMC2, 0);
+	mtspr(SPRN_PMC1, 0x80000000-100);
+	mmcr0 = (1<<(31-18)) | (0x01 << 6) | (0x01 << 0);
+	if (pmc1ce)
+		mmcr0 |= (1<<(31-16));
+	mtspr(SPRN_MMCR0, mmcr0);
+	do {
+		do_empty_loop(0);
+	} while (!(mfspr(SPRN_PMC1) & 0x80000000));
+	do_empty_loop(0);
+	printk(KERN_INFO "PERFCTR INIT: %s(%u): MMCR0[TRIGGER] is %u, PMC1 is %#x, PMC2 is %#x\n",
+	       __FUNCTION__, pmc1ce,
+	       !!(mfspr(SPRN_MMCR0) & (1<<(31-18))), mfspr(SPRN_PMC1), mfspr(SPRN_PMC2));
+	mtspr(SPRN_MMCR0, 0);
+	mtspr(SPRN_PMC1, 0);
+	mtspr(SPRN_PMC2, 0);
+}
+
+static void __init
+measure_overheads(int have_mmcr1)
+{
+	int i;
+	unsigned int mmcr0, loop, ticks[12];
+	const char *name[12];
+
+	clear(have_mmcr1);
+
+	/* PMC1 = "processor cycles",
+	   PMC2 = "completed instructions",
+	   not disabled in any mode,
+	   no interrupts */
+	mmcr0 = (0x01 << 6) | (0x02 << 0);
+	mtspr(SPRN_MMCR0, mmcr0);
+
+	name[0] = "mftbl";
+	ticks[0] = run(do_read_tbl, 0);
+	name[1] = "mfspr (pmc1)";
+	ticks[1] = run(do_read_pmc1, 0);
+	name[2] = "mfspr (pmc2)";
+	ticks[2] = run(do_read_pmc2, 0);
+	name[3] = "mfspr (pmc3)";
+	ticks[3] = have_mmcr1 ? run(do_read_pmc3, 0) : 0;
+	name[4] = "mfspr (pmc4)";
+	ticks[4] = have_mmcr1 ? run(do_read_pmc4, 0) : 0;
+	name[5] = "mfspr (mmcr0)";
+	ticks[5] = run(do_read_mmcr0, 0);
+	name[6] = "mfspr (mmcr1)";
+	ticks[6] = have_mmcr1 ? run(do_read_mmcr1, 0) : 0;
+	name[7] = "mtspr (pmc2)";
+	ticks[7] = run(do_write_pmc2, 0);
+	name[8] = "mtspr (pmc3)";
+	ticks[8] = have_mmcr1 ? run(do_write_pmc3, 0) : 0;
+	name[9] = "mtspr (pmc4)";
+	ticks[9] = have_mmcr1 ? run(do_write_pmc4, 0) : 0;
+	name[10] = "mtspr (mmcr1)";
+	ticks[10] = have_mmcr1 ? run(do_write_mmcr1, 0) : 0;
+	name[11] = "mtspr (mmcr0)";
+	ticks[11] = run(do_write_mmcr0, mmcr0);
+
+	loop = run(do_empty_loop, 0);
+
+	clear(have_mmcr1);
+
+	init_tests_message();
+	printk(KERN_INFO "PERFCTR INIT: NITER == %u\n", NITER);
+	printk(KERN_INFO "PERFCTR INIT: loop overhead is %u cycles\n", loop);
+	for(i = 0; i < ARRAY_SIZE(ticks); ++i) {
+		unsigned int x;
+		if (!ticks[i])
+			continue;
+		x = ((ticks[i] - loop) * 10) / NITER;
+		printk(KERN_INFO "PERFCTR INIT: %s cost is %u.%u cycles (%u total)\n",
+		       name[i], x/10, x%10, ticks[i]);
+	}
+	check_fcece(0);
+	check_fcece(1);
+	check_trigger(0);
+	check_trigger(1);
+}
+
+void __init perfctr_ppc_init_tests(void)
+{
+	measure_overheads(PVR_VER(mfspr(SPRN_PVR)) != 0x0004);
+}
diff -ruN linux-2.6.7-rc1-mm1/drivers/perfctr/ppc_tests.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/drivers/perfctr/ppc_tests.h
--- linux-2.6.7-rc1-mm1/drivers/perfctr/ppc_tests.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/drivers/perfctr/ppc_tests.h	2004-05-31 23:47:05.422821000 +0200
@@ -0,0 +1,12 @@
+/* $Id: ppc_tests.h,v 1.1 2004/01/12 01:59:11 mikpe Exp $
+ * Performance-monitoring counters driver.
+ * Optional PPC32-specific init-time tests.
+ *
+ * Copyright (C) 2004  Mikael Pettersson
+ */
+
+#ifdef CONFIG_PERFCTR_INIT_TESTS
+extern void perfctr_ppc_init_tests(void);
+#else
+#define perfctr_ppc_init_tests()
+#endif
diff -ruN linux-2.6.7-rc1-mm1/include/asm-ppc/perfctr.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/include/asm-ppc/perfctr.h
--- linux-2.6.7-rc1-mm1/include/asm-ppc/perfctr.h	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/include/asm-ppc/perfctr.h	2004-05-31 23:47:05.422821000 +0200
@@ -0,0 +1,170 @@
+/* $Id: perfctr.h,v 1.6 2004/05/30 14:47:34 mikpe Exp $
+ * PPC32 Performance-Monitoring Counters driver
+ *
+ * Copyright (C) 2004  Mikael Pettersson
+ */
+#ifndef _ASM_PPC_PERFCTR_H
+#define _ASM_PPC_PERFCTR_H
+
+/* perfctr_info.cpu_type values */
+#define PERFCTR_PPC_604		1
+#define PERFCTR_PPC_604e	2
+#define PERFCTR_PPC_750		3
+#define PERFCTR_PPC_7400	4
+#define PERFCTR_PPC_7450	5
+
+struct perfctr_sum_ctrs {
+	unsigned long long tsc;
+	unsigned long long pmc[8];
+};
+
+struct perfctr_cpu_control {
+	unsigned int tsc_on;
+	unsigned int nractrs;		/* # of a-mode counters */
+	unsigned int nrictrs;		/* # of i-mode counters */
+	unsigned int pmc_map[8];
+	unsigned int evntsel[8];	/* one per counter, even on P5 */
+	int ireset[8];			/* [0,0x7fffffff], for i-mode counters */
+	struct {
+		unsigned int mmcr0;	/* sans PMC{1,2}SEL */
+		unsigned int mmcr2;	/* only THRESHMULT */
+		/* IABR/DABR/BAMR not supported */
+	} ppc;
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
+	} pmc[8];	/* the size is not part of the user ABI */
+#ifdef __KERNEL__
+	unsigned int ppc_mmcr[3];
+	struct perfctr_cpu_control control;
+#endif
+};
+
+/* cstatus is a re-encoding of control.tsc_on/nractrs/nrictrs
+   which should have less overhead in most cases */
+/* XXX: ppc driver internally also uses cstatus&(1<<30) */
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
+#define PERFCTR_CPU_VERSION	0	/* XXX: not yet cast in stone */
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
+/* XXX: The hardware supports overflow interrupts, but the driver
+   does not yet enable this due to an erratum in 750/7400/7410. */
+//#define PERFCTR_INTERRUPT_SUPPORT 1
+
+#if PERFCTR_INTERRUPT_SUPPORT
+extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
+extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
+extern unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state*);
+#else
+static inline void perfctr_cpu_set_ihandler(perfctr_ihandler_t x) { }
+#endif
+
+#endif	/* CONFIG_PERFCTR */
+
+#endif	/* __KERNEL__ */
+
+#endif	/* _ASM_PPC_PERFCTR_H */
diff -ruN linux-2.6.7-rc1-mm1/include/asm-ppc/processor.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/include/asm-ppc/processor.h
--- linux-2.6.7-rc1-mm1/include/asm-ppc/processor.h	2004-05-10 11:14:37.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/include/asm-ppc/processor.h	2004-05-31 23:47:05.422821000 +0200
@@ -119,6 +119,7 @@
 	unsigned long	vrsave;
 	int		used_vr;	/* set if process has used altivec */
 #endif /* CONFIG_ALTIVEC */
+	struct vperfctr *perfctr;	/* performance counters */
 };
 
 #define ARCH_MIN_TASKALIGN 16
diff -ruN linux-2.6.7-rc1-mm1/include/asm-ppc/reg.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/include/asm-ppc/reg.h
--- linux-2.6.7-rc1-mm1/include/asm-ppc/reg.h	2004-05-30 15:59:08.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/include/asm-ppc/reg.h	2004-05-31 23:47:05.422821000 +0200
@@ -268,22 +268,14 @@
 #define SPRN_LDSTCR	0x3f8	/* Load/Store control register */
 #define SPRN_LDSTDB	0x3f4	/* */
 #define SPRN_LR		0x008	/* Link Register */
-#define SPRN_MMCR0	0x3B8	/* Monitor Mode Control Register 0 */
-#define SPRN_MMCR1	0x3BC	/* Monitor Mode Control Register 1 */
 #ifndef SPRN_PIR
 #define SPRN_PIR	0x3FF	/* Processor Identification Register */
 #endif
-#define SPRN_PMC1	0x3B9	/* Performance Counter Register 1 */
-#define SPRN_PMC2	0x3BA	/* Performance Counter Register 2 */
-#define SPRN_PMC3	0x3BD	/* Performance Counter Register 3 */
-#define SPRN_PMC4	0x3BE	/* Performance Counter Register 4 */
 #define SPRN_PTEHI	0x3D5	/* 981 7450 PTE HI word (S/W TLB load) */
 #define SPRN_PTELO	0x3D6	/* 982 7450 PTE LO word (S/W TLB load) */
 #define SPRN_PVR	0x11F	/* Processor Version Register */
 #define SPRN_RPA	0x3D6	/* Required Physical Address Register */
-#define SPRN_SDA	0x3BF	/* Sampled Data Address Register */
 #define SPRN_SDR1	0x019	/* MMU Hash Base Register */
-#define SPRN_SIA	0x3BB	/* Sampled Instruction Address Register */
 #define SPRN_SPRG0	0x110	/* Special Purpose Register General 0 */
 #define SPRN_SPRG1	0x111	/* Special Purpose Register General 1 */
 #define SPRN_SPRG2	0x112	/* Special Purpose Register General 2 */
@@ -307,16 +299,79 @@
 #define SPRN_THRM3	0x3FE		/* Thermal Management Register 3 */
 #define THRM3_E		(1<<0)
 #define SPRN_TLBMISS	0x3D4		/* 980 7450 TLB Miss Register */
-#define SPRN_UMMCR0	0x3A8	/* User Monitor Mode Control Register 0 */
-#define SPRN_UMMCR1	0x3AC	/* User Monitor Mode Control Register 0 */
-#define SPRN_UPMC1	0x3A9	/* User Performance Counter Register 1 */
-#define SPRN_UPMC2	0x3AA	/* User Performance Counter Register 2 */
-#define SPRN_UPMC3	0x3AD	/* User Performance Counter Register 3 */
-#define SPRN_UPMC4	0x3AE	/* User Performance Counter Register 4 */
-#define SPRN_USIA	0x3AB	/* User Sampled Instruction Address Register */
 #define SPRN_VRSAVE	0x100	/* Vector Register Save Register */
 #define SPRN_XER	0x001	/* Fixed Point Exception Register */
 
+/* Performance-monitoring control and counter registers */
+#define SPRN_MMCR0	0x3B8	/* Monitor Mode Control Register 0 (604 and up) */
+#define SPRN_MMCR1	0x3BC	/* Monitor Mode Control Register 1 (604e and up) */
+#define SPRN_MMCR2	0x3B0	/* Monitor Mode Control Register 2 (7400 and up) */
+#define SPRN_PMC1	0x3B9	/* Performance Counter Register 1 (604 and up) */
+#define SPRN_PMC2	0x3BA	/* Performance Counter Register 2 (604 and up) */
+#define SPRN_PMC3	0x3BD	/* Performance Counter Register 3 (604e and up) */
+#define SPRN_PMC4	0x3BE	/* Performance Counter Register 4 (604e and up) */
+#define SPRN_PMC5	0x3B1	/* Performance Counter Register 5 (7450 and up) */
+#define SPRN_PMC6	0x3B2	/* Performance Counter Register 6 (7450 and up) */
+#define SPRN_SIA	0x3BB	/* Sampled Instruction Address Register (604 and up) */
+#define SPRN_SDA	0x3BF	/* Sampled Data Address Register (604/604e only) */
+#define SPRN_BAMR	0x3B7	/* Breakpoint Address Mask Register (7400 and up) */
+
+#define SPRN_UMMCR0	0x3A8	/* User Monitor Mode Control Register 0 (750 and up) */
+#define SPRN_UMMCR1	0x3AC	/* User Monitor Mode Control Register 0 (750 and up) */
+#define SPRN_UMMCR2	0x3A0	/* User Monitor Mode Control Register 0 (7400 and up) */
+#define SPRN_UPMC1	0x3A9	/* User Performance Counter Register 1 (750 and up) */
+#define SPRN_UPMC2	0x3AA	/* User Performance Counter Register 2 (750 and up) */
+#define SPRN_UPMC3	0x3AD	/* User Performance Counter Register 3 (750 and up) */
+#define SPRN_UPMC4	0x3AE	/* User Performance Counter Register 4 (750 and up) */
+#define SPRN_UPMC5	0x3A1	/* User Performance Counter Register 5 (7450 and up) */
+#define SPRN_UPMC6	0x3A2	/* User Performance Counter Register 5 (7450 and up) */
+#define SPRN_USIA	0x3AB	/* User Sampled Instruction Address Register (750 and up) */
+#define SPRN_UBAMR	0x3A7	/* User Breakpoint Address Mask Register (7400 and up) */
+
+/* MMCR0 layout (74xx terminology) */
+#define MMCR0_FC		0x80000000 /* Freeze counters unconditionally. */
+#define MMCR0_FCS		0x40000000 /* Freeze counters while MSR[PR]=0 (supervisor mode). */
+#define MMCR0_FCP		0x20000000 /* Freeze counters while MSR[PR]=1 (user mode). */
+#define MMCR0_FCM1		0x10000000 /* Freeze counters while MSR[PM]=1. */
+#define MMCR0_FCM0		0x08000000 /* Freeze counters while MSR[PM]=0. */
+#define MMCR0_PMXE		0x04000000 /* Enable performance monitor exceptions.
+					    * Cleared by hardware when a PM exception occurs.
+					    * 604: PMXE is not cleared by hardware.
+					    */
+#define MMCR0_FCECE		0x02000000 /* Freeze counters on enabled condition or event.
+					    * FCECE is treated as 0 if TRIGGER is 1.
+					    * 74xx: FC is set when the event occurs.
+					    * 604/750: ineffective when PMXE=0.
+					    */
+#define MMCR0_TBSEL		0x01800000 /* Time base lower (TBL) bit selector.
+					    * 00: bit 31, 01: bit 23, 10: bit 19, 11: bit 15.
+					    */
+#define MMCR0_TBEE		0x00400000 /* Enable event on TBL bit transition from 0 to 1. */
+#define MMCR0_THRESHOLD		0x003F0000 /* Threshold value for certain events. */
+#define MMCR0_PMC1CE		0x00008000 /* Enable event on PMC1 overflow. */
+#define MMCR0_PMCjCE		0x00004000 /* Enable event on PMC2-PMC6 overflow.
+					    * 604/750: Overrides FCECE (DISCOUNT).
+					    */
+#define MMCR0_TRIGGER		0x00002000 /* Disable PMC2-PMC6 until PMC1 overflow or other event.
+					    * 74xx: cleared by hardware when the event occurs.
+					    */
+#define MMCR0_PMC1SEL		0x00001FB0 /* PMC1 event selector, 7 bits. */
+#define MMCR0_PMC2SEL		0x0000003F /* PMC2 event selector, 6 bits. */
+
+/* MMCR1 layout (604e-7457) */
+#define MMCR1_PMC3SEL		0xF8000000 /* PMC3 event selector, 5 bits. */
+#define MMCR1_PMC4SEL		0x07B00000 /* PMC4 event selector, 5 bits. */
+#define MMCR1_PMC5SEL		0x003E0000 /* PMC5 event selector, 5 bits. (745x only) */
+#define MMCR1_PMC6SEL		0x0001F800 /* PMC6 event selector, 6 bits. (745x only) */
+#define MMCR1__RESERVED		0x000007FF /* should be zero */
+
+/* MMCR2 layout (7400-7457) */
+#define MMCR2_THRESHMULT	0x80000000 /* MMCR0[THRESHOLD] multiplier. */
+#define MMCR2_SMCNTEN		0x40000000 /* 7400/7410 only, should be zero. */
+#define MMCR2_SMINTEN		0x20000000 /* 7400/7410 only, should be zero. */
+#define MMCR2__RESERVED		0x1FFFFFFF /* should be zero */
+#define MMCR2_RESERVED		(MMCR2_SMCNTEN | MMCR2_SMINTEN | MMCR2__RESERVED)
+
 /* Bit definitions for MMCR0 and PMC1 / PMC2. */
 #define MMCR0_PMC1_CYCLES	(1 << 7)
 #define MMCR0_PMC1_ICACHEMISS	(5 << 7)
diff -ruN linux-2.6.7-rc1-mm1/include/asm-ppc/unistd.h linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/include/asm-ppc/unistd.h
--- linux-2.6.7-rc1-mm1/include/asm-ppc/unistd.h	2004-05-30 15:59:08.000000000 +0200
+++ linux-2.6.7-rc1-mm1.perfctr-2.7.3.ppc/include/asm-ppc/unistd.h	2004-05-31 23:47:05.422821000 +0200
@@ -273,8 +273,14 @@
 #define __NR_mq_notify		266
 #define __NR_mq_getsetattr	267
 #define __NR_kexec_load		268
+#define __NR_perfctr_info	269
+#define __NR_vperfctr_open	(__NR_perfctr_info+1)
+#define __NR_vperfctr_control	(__NR_perfctr_info+2)
+#define __NR_vperfctr_unlink	(__NR_perfctr_info+3)
+#define __NR_vperfctr_iresume	(__NR_perfctr_info+4)
+#define __NR_vperfctr_read	(__NR_perfctr_info+5)
 
-#define __NR_syscalls		269
+#define __NR_syscalls		275
 
 #define __NR(n)	#n
 
