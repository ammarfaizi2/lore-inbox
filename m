Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262064AbVCLXVo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262064AbVCLXVo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:21:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVCLXVn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:21:43 -0500
Received: from aun.it.uu.se ([130.238.12.36]:43977 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262064AbVCLXS5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:18:57 -0500
Date: Sun, 13 Mar 2005 00:18:50 +0100 (MET)
Message-Id: <200503122318.j2CNIome028876@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 2/9: physical indexing, ppc32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Switch ppc32 driver to use physically-indexed control data.
- Rearrange struct perfctr_cpu_control. Remove _reserved fields.
- ppc_mmcr[] array in struct perfctr_cpu_state is no longer needed.
- In perfctr_cpu_update_control, call check_ireset after check_control,
  since check_ireset now needs to use the virtual-to-physical map.
- Users must now format the 2-6 event selector values into the
  MMCR0/MMCR1 images.
- Verify that unused/non-existent parts of MMCR images are zero.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 drivers/perfctr/ppc.c     |   90 +++++++++++++++++++++++-----------------------
 include/asm-ppc/perfctr.h |   21 +++-------
 2 files changed, 52 insertions(+), 59 deletions(-)

diff -rupN linux-2.6.11-mm3/drivers/perfctr/ppc.c linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/ppc.c
--- linux-2.6.11-mm3/drivers/perfctr/ppc.c	2005-03-12 19:26:25.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/ppc.c	2005-03-12 19:55:49.000000000 +0100
@@ -41,11 +41,6 @@ enum pm_type {
 };
 static enum pm_type pm_type;
 
-/* Bits users shouldn't set in control.ppc.mmcr0:
- * - PMC1SEL/PMC2SEL because event selectors are in control.evntsel[]
- */
-#define MMCR0_RESERVED		(MMCR0_PMC1SEL | MMCR0_PMC2SEL)
-
 static unsigned int new_id(void)
 {
 	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
@@ -297,9 +292,15 @@ static int ppc_check_control(struct perf
 
 	pmc_mask = 0;
 	pmi_mask = 0;
-	memset(evntsel, 0, sizeof evntsel);
+	evntsel[1-1] = (state->control.mmcr0 >> (31-25)) & 0x7F;
+	evntsel[2-1] = (state->control.mmcr0 >> (31-31)) & 0x3F;
+	evntsel[3-1] = (state->control.mmcr1 >> (31- 4)) & 0x1F;
+	evntsel[4-1] = (state->control.mmcr1 >> (31- 9)) & 0x1F;
+	evntsel[5-1] = (state->control.mmcr1 >> (31-14)) & 0x1F;
+	evntsel[6-1] = (state->control.mmcr1 >> (31-20)) & 0x3F;
+
 	for(i = 0; i < nrctrs; ++i) {
-		pmc = state->control.pmc[i].map;
+		pmc = state->control.pmc_map[i];
 		state->pmc[i].map = pmc;
 		if (pmc >= nr_pmcs || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
@@ -308,11 +309,15 @@ static int ppc_check_control(struct perf
 		if (i >= nractrs)
 			pmi_mask |= (1<<pmc);
 
-		evntsel[pmc] = state->control.pmc[i].evntsel;
 		if (evntsel[pmc] > pmc_max_event(pmc))
 			return -EINVAL;
 	}
 
+	/* unused event selectors must be zero */
+	for(i = 0; i < ARRAY_SIZE(evntsel); ++i)
+		if (!(pmc_mask & (1<<i)) && evntsel[i] != 0)
+			return -EINVAL;
+
 	/* XXX: temporary limitation */
 	if ((pmi_mask & ~1) && (pmi_mask & ~1) != (pmc_mask & ~1))
 		return -EINVAL;
@@ -320,30 +325,23 @@ static int ppc_check_control(struct perf
 	switch (pm_type) {
 	case PM_7450:
 	case PM_7400:
-		if (state->control.ppc.mmcr2 & MMCR2_RESERVED)
+		if (state->control.mmcr2 & MMCR2_RESERVED)
 			return -EINVAL;
-		state->ppc_mmcr[2] = state->control.ppc.mmcr2;
 		break;
 	default:
-		if (state->control.ppc.mmcr2)
+		if (state->control.mmcr2)
 			return -EINVAL;
-		state->ppc_mmcr[2] = 0;
 	}
 
+	/* check MMCR1; non-existent event selectors are taken care of
+	   by the "unused event selectors must be zero" check above */
+	if (state->control.mmcr1 & MMCR1__RESERVED)
+		return -EINVAL;
+
 	/* We do not yet handle TBEE as the only exception cause,
 	   so PMXE requires at least one interrupt-mode counter. */
-	if ((state->control.ppc.mmcr0 & MMCR0_PMXE) && !state->control.nrictrs)
-		return -EINVAL;
-	if (state->control.ppc.mmcr0 & MMCR0_RESERVED)
+	if ((state->control.mmcr0 & MMCR0_PMXE) && !state->control.nrictrs)
 		return -EINVAL;
-	state->ppc_mmcr[0] = (state->control.ppc.mmcr0
-			      | (evntsel[0] << (31-25))
-			      | (evntsel[1] << (31-31)));
-
-	state->ppc_mmcr[1] = ((  evntsel[2] << (31-4))
-			      | (evntsel[3] << (31-9))
-			      | (evntsel[4] << (31-14))
-			      | (evntsel[5] << (31-20)));
 
 	state->k1.id = new_id();
 
@@ -356,14 +354,14 @@ static int ppc_check_control(struct perf
 	switch (pm_type) {
 	case PM_7450:
 	case PM_7400:
-		if (state->ppc_mmcr[0] & (MMCR0_FCECE | MMCR0_TRIGGER))
+		if (state->control.mmcr0 & (MMCR0_FCECE | MMCR0_TRIGGER))
 			state->cstatus = perfctr_cstatus_set_mmcr0_quirk(state->cstatus);
 	default:
 		;
 	}
 
 	/* The MMCR0 handling for FCECE and TRIGGER is also needed for PMXE. */
-	if (state->ppc_mmcr[0] & (MMCR0_PMXE | MMCR0_FCECE | MMCR0_TRIGGER))
+	if (state->control.mmcr0 & (MMCR0_PMXE | MMCR0_FCECE | MMCR0_TRIGGER))
 		state->cstatus = perfctr_cstatus_set_mmcr0_quirk(state->cstatus);
 
 	return 0;
@@ -466,17 +464,17 @@ static void ppc_write_control(const stru
 	 * cache and the state indicate the same value for it,
 	 * preventing any actual mtspr to it. Ditto for MMCR1.
 	 */
-	value = state->ppc_mmcr[2];
+	value = state->control.mmcr2;
 	if (value != cache->ppc_mmcr[2]) {
 		cache->ppc_mmcr[2] = value;
 		mtspr(SPRN_MMCR2, value);
 	}
-	value = state->ppc_mmcr[1];
+	value = state->control.mmcr1;
 	if (value != cache->ppc_mmcr[1]) {
 		cache->ppc_mmcr[1] = value;
 		mtspr(SPRN_MMCR1, value);
 	}
-	value = state->ppc_mmcr[0];
+	value = state->control.mmcr0;
 	if (value != cache->ppc_mmcr[0]) {
 		cache->ppc_mmcr[0] = value;
 		mtspr(SPRN_MMCR0, value);
@@ -546,7 +544,7 @@ static void perfctr_cpu_iresume(const st
    bypass internal caching and force a reload if the I-mode PMCs. */
 void perfctr_cpu_ireload(struct perfctr_cpu_state *state)
 {
-	state->ppc_mmcr[0] |= MMCR0_PMXE;
+	state->control.mmcr0 |= MMCR0_PMXE;
 #ifdef CONFIG_SMP
 	clear_isuspend_cpu(state);
 #else
@@ -557,20 +555,20 @@ void perfctr_cpu_ireload(struct perfctr_
 /* PRE: the counters have been suspended and sampled by perfctr_cpu_suspend() */
 unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state *state)
 {
-	unsigned int cstatus, nrctrs, pmc, pmc_mask;
+	unsigned int cstatus, nrctrs, i, pmc_mask;
 
 	cstatus = state->cstatus;
-	pmc = perfctr_cstatus_nractrs(cstatus);
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
-
-	for(pmc_mask = 0; pmc < nrctrs; ++pmc) {
-		if ((int)state->pmc[pmc].start < 0) { /* PPC-specific */
+	pmc_mask = 0;
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		if ((int)state->pmc[i].start < 0) { /* PPC-specific */
+			unsigned int pmc = state->pmc[i].map;
 			/* XXX: "+=" to correct for overshots */
-			state->pmc[pmc].start = state->control.pmc[pmc].ireset;
-			pmc_mask |= (1 << pmc);
+			state->pmc[i].start = state->control.ireset[pmc];
+			pmc_mask |= (1 << i);
 		}
 	}
-	if (!pmc_mask && (state->ppc_mmcr[0] & MMCR0_TBEE))
+	if (!pmc_mask && (state->control.mmcr0 & MMCR0_TBEE))
 		pmc_mask = (1<<8); /* fake TB bit flip indicator */
 	return pmc_mask;
 }
@@ -581,9 +579,11 @@ static inline int check_ireset(const str
 
 	i = state->control.nractrs;
 	nrctrs = i + state->control.nrictrs;
-	for(; i < nrctrs; ++i)
-		if (state->control.pmc[i].ireset < 0)	/* PPC-specific */
+	for(; i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		if ((int)state->control.ireset[pmc] < 0) /* PPC-specific */
 			return -EINVAL;
+	}
 	return 0;
 }
 
@@ -593,8 +593,10 @@ static inline void setup_imode_start_val
 
 	cstatus = state->cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
-	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
-		state->pmc[i].start = state->control.pmc[i].ireset;
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map;
+		state->pmc[i].start = state->control.ireset[pmc];
+	}
 }
 
 #else	/* CONFIG_PERFCTR_INTERRUPT_SUPPORT */
@@ -621,10 +623,10 @@ int perfctr_cpu_update_control(struct pe
 	    && state->control.nrictrs)
 		return -EPERM;
 
-	err = check_ireset(state);
+	err = check_control(state); /* may initialise state->cstatus */
 	if (err < 0)
 		return err;
-	err = check_control(state); /* may initialise state->cstatus */
+	err = check_ireset(state);
 	if (err < 0)
 		return err;
 	state->cstatus |= perfctr_mk_cstatus(state->control.tsc_on,
@@ -643,7 +645,7 @@ void perfctr_cpu_suspend(struct perfctr_
 		unsigned int mmcr0 = mfspr(SPRN_MMCR0);
 		mtspr(SPRN_MMCR0, mmcr0 | MMCR0_FC);
 		get_cpu_cache()->ppc_mmcr[0] = mmcr0 | MMCR0_FC;
-		state->ppc_mmcr[0] = mmcr0;
+		state->control.mmcr0 = mmcr0;
 	}
 	if (perfctr_cstatus_has_ictrs(state->cstatus))
 		perfctr_cpu_isuspend(state);
diff -rupN linux-2.6.11-mm3/include/asm-ppc/perfctr.h linux-2.6.11-mm3.perfctr-physical-indexing/include/asm-ppc/perfctr.h
--- linux-2.6.11-mm3/include/asm-ppc/perfctr.h	2005-03-12 19:26:26.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-physical-indexing/include/asm-ppc/perfctr.h	2005-03-12 19:55:49.000000000 +0100
@@ -23,20 +23,12 @@ struct perfctr_cpu_control {
 	unsigned int tsc_on;
 	unsigned int nractrs;		/* # of a-mode counters */
 	unsigned int nrictrs;		/* # of i-mode counters */
-	struct {
-		unsigned int mmcr0;	/* sans PMC{1,2}SEL */
-		unsigned int mmcr2;	/* only THRESHMULT */
-		/* IABR/DABR/BAMR not supported */
-	} ppc;
-	unsigned int _reserved1;
-	unsigned int _reserved2;
-	unsigned int _reserved3;
-	unsigned int _reserved4;
-	struct {
-		unsigned int map;	/* physical counter to use */
-		unsigned int evntsel;
-		int ireset;		/* [0,0x7fffffff], for i-mode counters */
-	} pmc[8];
+	unsigned int mmcr0;
+	unsigned int mmcr1;
+	unsigned int mmcr2;
+	/* IABR/DABR/BAMR not supported */
+	unsigned int ireset[8];		/* [0,0x7fffffff], for i-mode counters, physical indices */
+	unsigned int pmc_map[8];	/* virtual to physical index map */
 };
 
 struct perfctr_cpu_state {
@@ -55,7 +47,6 @@ struct perfctr_cpu_state {
 		unsigned long long sum;
 	} pmc[8];	/* the size is not part of the user ABI */
 #ifdef __KERNEL__
-	unsigned int ppc_mmcr[3];
 	struct perfctr_cpu_control control;
 #endif
 };
