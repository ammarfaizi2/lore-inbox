Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262126AbVC1XkW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262126AbVC1XkW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:40:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262125AbVC1XkL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:40:11 -0500
Received: from aun.it.uu.se ([130.238.12.36]:27643 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262123AbVC1Xg5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:36:57 -0500
Date: Tue, 29 Mar 2005 01:36:50 +0200 (MEST)
Message-Id: <200503282336.j2SNaol2013485@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm3 2/3] perfctr: mapped state cleanup: ppc32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr ppc32 mapped state cleanup:
- Swap cstatus and k1 fields in struct perfctr_cpu_state. Move
  now contiguous user-visible fields to struct perfctr_cpu_state_user.
  Hide kernel-private stuff. Inline now obsolete k1 struct. Cleanups.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c     |  104 ++++++++++++++++++++++------------------------
 include/asm-ppc/perfctr.h |   40 ++++++++---------
 2 files changed, 71 insertions(+), 73 deletions(-)

diff -rupN linux-2.6.12-rc1-mm3/drivers/perfctr/ppc.c linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-ppc32/drivers/perfctr/ppc.c
--- linux-2.6.12-rc1-mm3/drivers/perfctr/ppc.c	2005-03-28 17:26:14.000000000 +0200
+++ linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-ppc32/drivers/perfctr/ppc.c	2005-03-28 23:07:20.000000000 +0200
@@ -15,9 +15,7 @@
 
 /* Support for lazy evntsel and perfctr SPR updates. */
 struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
-	union {
-		unsigned int id;	/* cache owner id */
-	} k1;
+	unsigned int id;	/* cache owner id */
 	/* Physically indexed cache of the MMCRs. */
 	unsigned int ppc_mmcr[3];
 };
@@ -81,18 +79,18 @@ void perfctr_cpu_set_ihandler(perfctr_ih
 static inline void
 set_isuspend_cpu(struct perfctr_cpu_state *state, int cpu)
 {
-	state->k1.isuspend_cpu = cpu;
+	state->isuspend_cpu = cpu;
 }
 
 static inline int
 is_isuspend_cpu(const struct perfctr_cpu_state *state, int cpu)
 {
-	return state->k1.isuspend_cpu == cpu;
+	return state->isuspend_cpu == cpu;
 }
 
 static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state)
 {
-	state->k1.isuspend_cpu = NR_CPUS;
+	state->isuspend_cpu = NR_CPUS;
 }
 
 #else
@@ -234,12 +232,12 @@ static void ppc_read_counters(struct per
 {
 	unsigned int cstatus, nrctrs, i;
 
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus))
 		ctrs->tsc = get_tbl();
 	nrctrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int pmc = state->pmc[i].map;
+		unsigned int pmc = state->user.pmc[i].map;
 		ctrs->pmc[i] = read_pmc(pmc);
 	}
 }
@@ -301,7 +299,7 @@ static int ppc_check_control(struct perf
 
 	for(i = 0; i < nrctrs; ++i) {
 		pmc = state->control.pmc_map[i];
-		state->pmc[i].map = pmc;
+		state->user.pmc[i].map = pmc;
 		if (pmc >= nr_pmcs || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
@@ -343,7 +341,7 @@ static int ppc_check_control(struct perf
 	if ((state->control.mmcr0 & MMCR0_PMXE) && !state->control.header.nrictrs)
 		return -EINVAL;
 
-	state->k1.id = new_id();
+	state->id = new_id();
 
 	/*
 	 * MMCR0[FC] and MMCR0[TRIGGER] may change on 74xx if FCECE or
@@ -355,14 +353,14 @@ static int ppc_check_control(struct perf
 	case PM_7450:
 	case PM_7400:
 		if (state->control.mmcr0 & (MMCR0_FCECE | MMCR0_TRIGGER))
-			state->cstatus = perfctr_cstatus_set_mmcr0_quirk(state->cstatus);
+			state->user.cstatus = perfctr_cstatus_set_mmcr0_quirk(state->user.cstatus);
 	default:
 		;
 	}
 
 	/* The MMCR0 handling for FCECE and TRIGGER is also needed for PMXE. */
 	if (state->control.mmcr0 & (MMCR0_PMXE | MMCR0_FCECE | MMCR0_TRIGGER))
-		state->cstatus = perfctr_cstatus_set_mmcr0_quirk(state->cstatus);
+		state->user.cstatus = perfctr_cstatus_set_mmcr0_quirk(state->user.cstatus);
 
 	return 0;
 }
@@ -379,15 +377,15 @@ static void ppc_isuspend(struct perfctr_
 	cpu = smp_processor_id();
 	set_isuspend_cpu(state, cpu); /* early to limit cpu's live range */
 	cache = __get_cpu_cache(cpu);
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
-		unsigned int pmc = state->pmc[i].map;
+		unsigned int pmc = state->user.pmc[i].map;
 		unsigned int now = read_pmc(pmc);
-		state->pmc[i].sum += now - state->pmc[i].start;
-		state->pmc[i].start = now;
+		state->user.pmc[i].sum += now - state->user.pmc[i].start;
+		state->user.pmc[i].start = now;
 	}
-	/* cache->k1.id is still == state->k1.id */
+	/* cache->id is still == state->id */
 }
 
 static void ppc_iresume(const struct perfctr_cpu_state *state)
@@ -399,8 +397,8 @@ static void ppc_iresume(const struct per
 
 	cpu = smp_processor_id();
 	cache = __get_cpu_cache(cpu);
-	if (cache->k1.id == state->k1.id) {
-		/* Clearing cache->k1.id to force write_control()
+	if (cache->id == state->id) {
+		/* Clearing cache->id to force write_control()
 		   to unfreeze MMCR0 would be done here, but it
 		   is subsumed by resume()'s MMCR0 reload logic. */
 		if (is_isuspend_cpu(state, cpu))
@@ -419,10 +417,10 @@ static void ppc_iresume(const struct per
 		mtspr(SPRN_MMCR0, cache->ppc_mmcr[0]);
 	}
 	memset(&pmc[0], 0, sizeof pmc);
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
-		pmc[state->pmc[i].map] = state->pmc[i].start;
+		pmc[state->user.pmc[i].map] = state->user.pmc[i].start;
 
 	switch (pm_type) {
 	case PM_7450:
@@ -439,7 +437,7 @@ static void ppc_iresume(const struct per
 	case PM_NONE:
 		;
 	}
-	/* cache->k1.id remains != state->k1.id */
+	/* cache->id remains != state->id */
 }
 #endif
 
@@ -449,7 +447,7 @@ static void ppc_write_control(const stru
 	unsigned int value;
 
 	cache = get_cpu_cache();
-	if (cache->k1.id == state->k1.id)
+	if (cache->id == state->id)
 		return;
 	/*
 	 * Order matters here: update threshmult and event
@@ -479,7 +477,7 @@ static void ppc_write_control(const stru
 		cache->ppc_mmcr[0] = value;
 		mtspr(SPRN_MMCR0, value);
 	}
-	cache->k1.id = state->k1.id;
+	cache->id = state->id;
 }
 
 static void ppc_clear_counters(void)
@@ -548,7 +546,7 @@ void perfctr_cpu_ireload(struct perfctr_
 #ifdef CONFIG_SMP
 	clear_isuspend_cpu(state);
 #else
-	get_cpu_cache()->k1.id = 0;
+	get_cpu_cache()->id = 0;
 #endif
 }
 
@@ -557,14 +555,14 @@ unsigned int perfctr_cpu_identify_overfl
 {
 	unsigned int cstatus, nrctrs, i, pmc_mask;
 
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	pmc_mask = 0;
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
-		if ((int)state->pmc[i].start < 0) { /* PPC-specific */
-			unsigned int pmc = state->pmc[i].map;
+		if ((int)state->user.pmc[i].start < 0) { /* PPC-specific */
+			unsigned int pmc = state->user.pmc[i].map;
 			/* XXX: "+=" to correct for overshots */
-			state->pmc[i].start = state->control.ireset[pmc];
+			state->user.pmc[i].start = state->control.ireset[pmc];
 			pmc_mask |= (1 << i);
 		}
 	}
@@ -580,10 +578,10 @@ static inline int check_ireset(struct pe
 	i = state->control.header.nractrs;
 	nrctrs = i + state->control.header.nrictrs;
 	for(; i < nrctrs; ++i) {
-		unsigned int pmc = state->pmc[i].map;
+		unsigned int pmc = state->user.pmc[i].map;
 		if ((int)state->control.ireset[pmc] < 0) /* PPC-specific */
 			return -EINVAL;
-		state->pmc[i].start = state->control.ireset[pmc];
+		state->user.pmc[i].start = state->control.ireset[pmc];
 	}
 	return 0;
 }
@@ -604,7 +602,7 @@ int perfctr_cpu_update_control(struct pe
 	int err;
 
 	clear_isuspend_cpu(state);
-	state->cstatus = 0;
+	state->user.cstatus = 0;
 
 	/* disallow i-mode counters if we cannot catch the interrupts */
 	if (!(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
@@ -616,12 +614,12 @@ int perfctr_cpu_update_control(struct pe
 		return err;
 	err = check_ireset(state);
 	if (err < 0) {
-		state->cstatus = 0;
+		state->user.cstatus = 0;
 		return err;
 	}
-	state->cstatus |= perfctr_mk_cstatus(state->control.header.tsc_on,
-					     state->control.header.nractrs,
-					     state->control.header.nrictrs);
+	state->user.cstatus |= perfctr_mk_cstatus(state->control.header.tsc_on,
+						  state->control.header.nractrs,
+						  state->control.header.nrictrs);
 	return 0;
 }
 
@@ -700,41 +698,41 @@ void perfctr_cpu_suspend(struct perfctr_
 	unsigned int i, cstatus, nractrs;
 	struct perfctr_low_ctrs now;
 
-	if (perfctr_cstatus_has_mmcr0_quirk(state->cstatus)) {
+	if (perfctr_cstatus_has_mmcr0_quirk(state->user.cstatus)) {
 		unsigned int mmcr0 = mfspr(SPRN_MMCR0);
 		mtspr(SPRN_MMCR0, mmcr0 | MMCR0_FC);
 		get_cpu_cache()->ppc_mmcr[0] = mmcr0 | MMCR0_FC;
 		state->control.mmcr0 = mmcr0;
 	}
-	if (perfctr_cstatus_has_ictrs(state->cstatus))
+	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
 		perfctr_cpu_isuspend(state);
 	perfctr_cpu_read_counters(state, &now);
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus))
-		state->tsc_sum += now.tsc - state->tsc_start;
+		state->user.tsc_sum += now.tsc - state->user.tsc_start;
 	nractrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nractrs; ++i)
-		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
+		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
 }
 
 void perfctr_cpu_resume(struct perfctr_cpu_state *state)
 {
-	if (perfctr_cstatus_has_ictrs(state->cstatus))
+	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
 	    perfctr_cpu_iresume(state);
-	if (perfctr_cstatus_has_mmcr0_quirk(state->cstatus))
-		get_cpu_cache()->k1.id = 0; /* force reload of MMCR0 */
+	if (perfctr_cstatus_has_mmcr0_quirk(state->user.cstatus))
+		get_cpu_cache()->id = 0; /* force reload of MMCR0 */
 	perfctr_cpu_write_control(state);
 	//perfctr_cpu_read_counters(state, &state->start);
 	{
 		struct perfctr_low_ctrs now;
 		unsigned int i, cstatus, nrctrs;
 		perfctr_cpu_read_counters(state, &now);
-		cstatus = state->cstatus;
+		cstatus = state->user.cstatus;
 		if (perfctr_cstatus_has_tsc(cstatus))
-			state->tsc_start = now.tsc;
+			state->user.tsc_start = now.tsc;
 		nrctrs = perfctr_cstatus_nractrs(cstatus);
 		for(i = 0; i < nrctrs; ++i)
-			state->pmc[i].start = now.pmc[i];
+			state->user.pmc[i].start = now.pmc[i];
 	}
 	/* XXX: if (SMP && start.tsc == now.tsc) ++now.tsc; */
 }
@@ -745,15 +743,15 @@ void perfctr_cpu_sample(struct perfctr_c
 	struct perfctr_low_ctrs now;
 
 	perfctr_cpu_read_counters(state, &now);
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus)) {
-		state->tsc_sum += now.tsc - state->tsc_start;
-		state->tsc_start = now.tsc;
+		state->user.tsc_sum += now.tsc - state->user.tsc_start;
+		state->user.tsc_start = now.tsc;
 	}
 	nractrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nractrs; ++i) {
-		state->pmc[i].sum += now.pmc[i] - state->pmc[i].start;
-		state->pmc[i].start = now.pmc[i];
+		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
+		state->user.pmc[i].start = now.pmc[i];
 	}
 }
 
@@ -763,7 +761,7 @@ static void perfctr_cpu_clear_counters(v
 
 	cache = get_cpu_cache();
 	memset(cache, 0, sizeof *cache);
-	cache->k1.id = -1;
+	cache->id = -1;
 
 	ppc_clear_counters();
 }
diff -rupN linux-2.6.12-rc1-mm3/include/asm-ppc/perfctr.h linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-ppc32/include/asm-ppc/perfctr.h
--- linux-2.6.12-rc1-mm3/include/asm-ppc/perfctr.h	2005-03-28 17:26:21.000000000 +0200
+++ linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-ppc32/include/asm-ppc/perfctr.h	2005-03-28 23:07:20.000000000 +0200
@@ -19,24 +19,8 @@ struct perfctr_cpu_control_header {
 	__u32 nrictrs;	/* number of interrupt-mode counters */
 };
 
-#ifdef __KERNEL__
-struct perfctr_cpu_control {
-	struct perfctr_cpu_control_header header;
-	unsigned int mmcr0;
-	unsigned int mmcr1;
-	unsigned int mmcr2;
-	/* IABR/DABR/BAMR not supported */
-	unsigned int ireset[8];		/* [0,0x7fffffff], for i-mode counters, physical indices */
-	unsigned int pmc_map[8];	/* virtual to physical index map */
-};
-#endif
-
-struct perfctr_cpu_state {
+struct perfctr_cpu_state_user {
 	__u32 cstatus;
-	struct {	/* k1 is opaque in the user ABI */
-		__u32 id;
-		__s32 isuspend_cpu;
-	} k1;
 	/* The two tsc fields must be inlined. Placing them in a
 	   sub-struct causes unwanted internal padding on x86-64. */
 	__u32 tsc_start;
@@ -46,9 +30,6 @@ struct perfctr_cpu_state {
 		__u32 start;
 		__u64 sum;
 	} pmc[8];	/* the size is not part of the user ABI */
-#ifdef __KERNEL__
-	struct perfctr_cpu_control control;
-#endif
 };
 
 /* cstatus is a re-encoding of control.tsc_on/nractrs/nrictrs
@@ -109,6 +90,25 @@ static inline unsigned int perfctr_cstat
 
 #if defined(CONFIG_PERFCTR)
 
+struct perfctr_cpu_control {
+	struct perfctr_cpu_control_header header;
+	unsigned int mmcr0;
+	unsigned int mmcr1;
+	unsigned int mmcr2;
+	/* IABR/DABR/BAMR not supported */
+	unsigned int ireset[8];		/* [0,0x7fffffff], for i-mode counters, physical indices */
+	unsigned int pmc_map[8];	/* virtual to physical index map */
+};
+
+struct perfctr_cpu_state {
+	/* Don't change field order here without first considering the number
+	   of cache lines touched during sampling and context switching. */
+	unsigned int id;
+	int isuspend_cpu;
+	struct perfctr_cpu_state_user user;
+	struct perfctr_cpu_control control;
+};
+
 /* Driver init/exit. */
 extern int perfctr_cpu_init(void);
 extern void perfctr_cpu_exit(void);
