Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264881AbUIZXGm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264881AbUIZXGm (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 19:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUIZXGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 19:06:42 -0400
Received: from aun.it.uu.se ([130.238.12.36]:53130 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264881AbUIZXFW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 19:05:22 -0400
Date: Mon, 27 Sep 2004 01:05:09 +0200 (MEST)
Message-Id: <200409262305.i8QN59b4012254@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.9-rc2-mm3] perfctr ppc32 preliminary interrupt support
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch adds preliminary support for performance monitor
interrupts to perfctr's PPC32 low-level driver. It requires
the MMCR0 handling fixes from the previous patch I sent.

PPC arranges the counters in two disjoint groups, and each
group has a single global interrupt enable bit. This is a
problem because the API assumes per-counter control. The
fix is to filter out stray interrupts, but this is not yet
implemented. (On my TODO list.)

Tested on an MPC7455 (G4-type chip). The patch applies cleanly
to and compiles ok in 2.6.9-rc2-mm3, but 2.6.9-rc2-mm3 has
other problems on PPC32 so I tested it with 2.6.9-rc2 vanilla.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 arch/ppc/kernel/head.S    |    4 +
 drivers/perfctr/Kconfig   |    2 
 drivers/perfctr/ppc.c     |  104 +++++++++++++++++++++++++++++++++++++++++-----
 include/asm-ppc/perfctr.h |    4 -
 4 files changed, 99 insertions(+), 15 deletions(-)

diff -ruN linux-2.6.9-rc2.perfctr27-ppc-mmcr0/arch/ppc/kernel/head.S linux-2.6.9-rc2.perfctr27-ppc-pmi/arch/ppc/kernel/head.S
--- linux-2.6.9-rc2.perfctr27-ppc-mmcr0/arch/ppc/kernel/head.S	2004-08-14 13:14:24.000000000 +0200
+++ linux-2.6.9-rc2.perfctr27-ppc-pmi/arch/ppc/kernel/head.S	2004-09-26 23:46:15.000000000 +0200
@@ -502,7 +502,11 @@
 Trap_0f:
 	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+	EXC_XFER_EE(0xf00, do_perfctr_interrupt)
+#else
 	EXC_XFER_EE(0xf00, UnknownException)
+#endif
 
 /*
  * Handle TLB miss for instruction on 603/603e.
diff -ruN linux-2.6.9-rc2.perfctr27-ppc-mmcr0/drivers/perfctr/Kconfig linux-2.6.9-rc2.perfctr27-ppc-pmi/drivers/perfctr/Kconfig
--- linux-2.6.9-rc2.perfctr27-ppc-mmcr0/drivers/perfctr/Kconfig	2004-09-19 21:24:49.000000000 +0200
+++ linux-2.6.9-rc2.perfctr27-ppc-pmi/drivers/perfctr/Kconfig	2004-09-26 23:46:15.000000000 +0200
@@ -51,7 +51,7 @@
 	  Say Y.
 
 config PERFCTR_INTERRUPT_SUPPORT
-	bool
+	bool "Performance counter overflow interrupt support"
 	depends on PERFCTR
 	default y if X86_LOCAL_APIC
 
diff -ruN linux-2.6.9-rc2.perfctr27-ppc-mmcr0/drivers/perfctr/ppc.c linux-2.6.9-rc2.perfctr27-ppc-pmi/drivers/perfctr/ppc.c
--- linux-2.6.9-rc2.perfctr27-ppc-mmcr0/drivers/perfctr/ppc.c	2004-09-26 23:47:15.000000000 +0200
+++ linux-2.6.9-rc2.perfctr27-ppc-pmi/drivers/perfctr/ppc.c	2004-09-26 23:46:15.000000000 +0200
@@ -22,6 +22,7 @@
 	unsigned int ppc_mmcr[3];
 } ____cacheline_aligned;
 static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
+#define __get_cpu_cache(cpu) (&per_cpu(per_cpu_cache, cpu))
 #define get_cpu_cache()	(&__get_cpu_var(per_cpu_cache))
 
 /* Structure for counter snapshots, as 32-bit values. */
@@ -41,10 +42,9 @@
 static enum pm_type pm_type;
 
 /* Bits users shouldn't set in control.ppc.mmcr0:
- * - PMXE because we don't yet support overflow interrupts
  * - PMC1SEL/PMC2SEL because event selectors are in control.evntsel[]
  */
-#define MMCR0_RESERVED		(MMCR0_PMXE | MMCR0_PMC1SEL | MMCR0_PMC2SEL)
+#define MMCR0_RESERVED		(MMCR0_PMC1SEL | MMCR0_PMC2SEL)
 
 static unsigned int new_id(void)
 {
@@ -68,7 +68,7 @@
 void do_perfctr_interrupt(struct pt_regs *regs)
 {
 	preempt_disable();
-	(*perfctr_ihandler)(regs->nip);
+	(*perfctr_ihandler)(instruction_pointer(regs));
 	preempt_enable_no_resched();
 }
 
@@ -292,15 +292,17 @@
 
 static int ppc_check_control(struct perfctr_cpu_state *state)
 {
-	unsigned int i, nrctrs, pmc_mask, pmc;
+	unsigned int i, nractrs, nrctrs, pmc_mask, pmi_mask, pmc;
 	unsigned int nr_pmcs, evntsel[6];
 
 	nr_pmcs = get_nr_pmcs();
-	nrctrs = state->control.nractrs;
-	if (state->control.nrictrs || nrctrs > nr_pmcs)
+	nractrs = state->control.nractrs;
+	nrctrs = nractrs + state->control.nrictrs;
+	if (nrctrs < nractrs || nrctrs > nr_pmcs)
 		return -EINVAL;
 
 	pmc_mask = 0;
+	pmi_mask = 0;
 	memset(evntsel, 0, sizeof evntsel);
 	for(i = 0; i < nrctrs; ++i) {
 		pmc = state->control.pmc_map[i];
@@ -309,11 +311,18 @@
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
 
+		if (i >= nractrs)
+			pmi_mask |= (1<<pmc);
+
 		evntsel[pmc] = state->control.evntsel[i];
 		if (evntsel[pmc] > pmc_max_event(pmc))
 			return -EINVAL;
 	}
 
+	/* XXX: temporary limitation */
+	if ((pmi_mask & ~1) && (pmi_mask & ~1) != (pmc_mask & ~1))
+		return -EINVAL;
+
 	switch (pm_type) {
 	case PM_7450:
 	case PM_7400:
@@ -327,6 +336,10 @@
 		state->ppc_mmcr[2] = 0;
 	}
 
+	/* We do not yet handle TBEE as the only exception cause,
+	   so PMXE requires at least one interrupt-mode counter. */
+	if ((state->control.ppc.mmcr0 & MMCR0_PMXE) && !state->control.nrictrs)
+		return -EINVAL;
 	if (state->control.ppc.mmcr0 & MMCR0_RESERVED)
 		return -EINVAL;
 	state->ppc_mmcr[0] = (state->control.ppc.mmcr0
@@ -355,18 +368,86 @@
 		;
 	}
 
+	/* The MMCR0 handling for FCECE and TRIGGER is also needed for PMXE. */
+	if (state->ppc_mmcr[0] & (MMCR0_PMXE | MMCR0_FCECE | MMCR0_TRIGGER))
+		state->cstatus = perfctr_cstatus_set_mmcr0_quirk(state->cstatus);
+
 	return 0;
 }
 
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+/* PRE: perfctr_cstatus_has_ictrs(state->cstatus) != 0 */
+/* PRE: counters frozen */
 static void ppc_isuspend(struct perfctr_cpu_state *state)
 {
-	// XXX
+	struct per_cpu_cache *cache;
+	unsigned int cstatus, nrctrs, i;
+	int cpu;
+
+	cpu = smp_processor_id();
+	set_isuspend_cpu(state, cpu); /* early to limit cpu's live range */
+	cache = __get_cpu_cache(cpu);
+	cstatus = state->cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		unsigned int now = read_pmc(pmc);
+		state->pmc[i].sum += now - state->pmc[i].start;
+		state->pmc[i].start = now;
+	}
+	/* cache->k1.id is still == state->k1.id */
 }
 
 static void ppc_iresume(const struct perfctr_cpu_state *state)
 {
-	// XXX
+	struct per_cpu_cache *cache;
+	unsigned int cstatus, nrctrs, i;
+	int cpu;
+	unsigned int pmc[6];
+
+	cpu = smp_processor_id();
+	cache = __get_cpu_cache(cpu);
+	if (cache->k1.id == state->k1.id) {
+		/* Clearing cache->k1.id to force write_control()
+		   to unfreeze MMCR0 would be done here, but it
+		   is subsumed by resume()'s MMCR0 reload logic. */
+		if (is_isuspend_cpu(state, cpu))
+			return; /* skip reload of PMCs */
+	}
+	/*
+	 * The CPU state wasn't ours.
+	 *
+	 * The counters must be frozen before being reinitialised,
+	 * to prevent unexpected increments and missed overflows.
+	 *
+	 * All unused counters must be reset to a non-overflow state.
+	 */
+	if (!(cache->ppc_mmcr[0] & MMCR0_FC)) {
+		cache->ppc_mmcr[0] |= MMCR0_FC;
+		mtspr(SPRN_MMCR0, cache->ppc_mmcr[0]);
+	}
+	memset(&pmc[0], 0, sizeof pmc);
+	cstatus = state->cstatus;
+	nrctrs = perfctr_cstatus_nrctrs(cstatus);
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
+		pmc[state->pmc[i].map] = state->pmc[i].start;
+
+	switch (pm_type) {
+	case PM_7450:
+		mtspr(SPRN_PMC6, pmc[6-1]);
+		mtspr(SPRN_PMC5, pmc[5-1]);
+	case PM_7400:
+	case PM_750:
+	case PM_604e:
+		mtspr(SPRN_PMC4, pmc[4-1]);
+		mtspr(SPRN_PMC3, pmc[3-1]);
+	case PM_604:
+		mtspr(SPRN_PMC2, pmc[2-1]);
+		mtspr(SPRN_PMC1, pmc[1-1]);
+	case PM_NONE:
+		;
+	}
+	/* cache->k1.id remains != state->k1.id */
 }
 #endif
 
@@ -471,6 +552,7 @@
    bypass internal caching and force a reload if the I-mode PMCs. */
 void perfctr_cpu_ireload(struct perfctr_cpu_state *state)
 {
+	state->ppc_mmcr[0] |= MMCR0_PMXE;
 #ifdef CONFIG_SMP
 	clear_isuspend_cpu(state);
 #else
@@ -494,9 +576,8 @@
 			pmc_mask |= (1 << pmc);
 		}
 	}
-	/* XXX: if pmc_mask == 0, then it must have been a TBL bit flip */
-	/* XXX: HW cleared MMCR0[ENINT]. We presumably cleared the entire
-	   MMCR0, so the re-enable occurs automatically later, no? */
+	if (!pmc_mask && (state->ppc_mmcr[0] & MMCR0_TBEE))
+		pmc_mask = (1<<8); /* fake TB bit flip indicator */
 	return pmc_mask;
 }
 
@@ -830,6 +911,7 @@
 		pll_type = PLL_7450;
 		break;
 	case 0x8001: /* 7455/7445 */
+		features |= PERFCTR_FEATURE_PCINT;
 		pm_type = PM_7450;
 		pll_type = ((pvr & 0xFFFF) < 0x0303) ? PLL_7450 : PLL_7457;
 		break;
diff -ruN linux-2.6.9-rc2.perfctr27-ppc-mmcr0/include/asm-ppc/perfctr.h linux-2.6.9-rc2.perfctr27-ppc-pmi/include/asm-ppc/perfctr.h
--- linux-2.6.9-rc2.perfctr27-ppc-mmcr0/include/asm-ppc/perfctr.h	2004-06-29 18:12:02.000000000 +0200
+++ linux-2.6.9-rc2.perfctr27-ppc-pmi/include/asm-ppc/perfctr.h	2004-09-26 23:46:28.000000000 +0200
@@ -152,9 +152,7 @@
    It will be called in IRQ context, with preemption disabled. */
 typedef void (*perfctr_ihandler_t)(unsigned long pc);
 
-/* Operations related to overflow interrupt handling.
-   XXX: The hardware supports overflow interrupts, but the driver
-   does not yet enable this due to an erratum in 750/7400/7410. */
+/* Operations related to overflow interrupt handling. */
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 extern void perfctr_cpu_set_ihandler(perfctr_ihandler_t);
 extern void perfctr_cpu_ireload(struct perfctr_cpu_state*);
