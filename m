Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262119AbVC1XiW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262119AbVC1XiW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Mar 2005 18:38:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVC1XiV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Mar 2005 18:38:21 -0500
Received: from aun.it.uu.se ([130.238.12.36]:16379 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262119AbVC1XgR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Mar 2005 18:36:17 -0500
Date: Tue, 29 Mar 2005 01:36:09 +0200 (MEST)
Message-Id: <200503282336.j2SNa9md013442@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm3 1/3] perfctr: mapped state cleanup: x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr x86 mapped state cleanup:
- Swap cstatus and k1 fields in struct perfctr_cpu_state. Move
  now contiguous user-visible fields to struct perfctr_cpu_state_user.
  Hide kernel-private stuff. Inline now obsolete k1 struct. Cleanups.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c      |  141 ++++++++++++++++++++++-----------------------
 include/asm-i386/perfctr.h |   52 ++++++++--------
 2 files changed, 95 insertions(+), 98 deletions(-)

diff -rupN linux-2.6.12-rc1-mm3/drivers/perfctr/x86.c linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-x86/drivers/perfctr/x86.c
--- linux-2.6.12-rc1-mm3/drivers/perfctr/x86.c	2005-03-28 17:26:14.000000000 +0200
+++ linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-x86/drivers/perfctr/x86.c	2005-03-28 23:08:09.000000000 +0200
@@ -23,10 +23,7 @@ struct hw_interrupt_type;
 
 /* Support for lazy evntsel and perfctr MSR updates. */
 struct per_cpu_cache {	/* roughly a subset of perfctr_cpu_state */
-	union {
-		unsigned int p5_cesr;
-		unsigned int id;	/* cache owner id */
-	} k1;
+	unsigned int id;	/* cache owner id */
 #ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
 	unsigned int interrupts_masked;
 #endif
@@ -193,18 +190,18 @@ static inline void perfctr_cpu_unmask_in
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
@@ -245,7 +242,7 @@ static int p5_like_check_control(struct 
 	cesr_half[1] = 0;
 	for(i = 0; i < state->control.header.nractrs; ++i) {
 		pmc = state->control.pmc_map[i];
-		state->pmc[i].map = pmc;
+		state->user.pmc[i].map = pmc;
 		if (pmc > 1 || cesr_half[pmc] != 0)
 			return -EINVAL;
 		evntsel = state->control.evntsel[0];
@@ -261,7 +258,7 @@ static int p5_like_check_control(struct 
 			return -EINVAL;
 		cesr_half[pmc] = evntsel;
 	}
-	state->k1.id = (cesr_half[1] << 16) | cesr_half[0];
+	state->id = (cesr_half[1] << 16) | cesr_half[0];
 	return 0;
 }
 
@@ -276,12 +273,12 @@ static void p5_write_control(const struc
 	struct per_cpu_cache *cache;
 	unsigned int cesr;
 
-	cesr = state->k1.id;
+	cesr = state->id;
 	if (!cesr)	/* no PMC is on (this test doesn't work on C6) */
 		return;
 	cache = get_cpu_cache();
-	if (cache->k1.p5_cesr != cesr) {
-		cache->k1.p5_cesr = cesr;
+	if (cache->id != cesr) {
+		cache->id = cesr;
 		wrmsr(MSR_P5_CESR, cesr, 0);
 	}
 }
@@ -296,12 +293,12 @@ static void p5_read_counters(const struc
 	   later in our caller. */
 	asm("" : : "r"(ctrs->tsc));
 
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus))
 		rdtscl(ctrs->tsc);
 	nrctrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int pmc = state->pmc[i].map;
+		unsigned int pmc = state->user.pmc[i].map;
 		rdmsr_low(MSR_P5_CTR0+pmc, ctrs->pmc[i]);
 	}
 }
@@ -312,12 +309,12 @@ static void rdpmc_read_counters(const st
 {
 	unsigned int cstatus, nrctrs, i;
 
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus))
 		rdtscl(ctrs->tsc);
 	nrctrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int pmc = state->pmc[i].map;
+		unsigned int pmc = state->user.pmc[i].map;
 		rdpmc_low(pmc, ctrs->pmc[i]);
 	}
 }
@@ -376,12 +373,12 @@ static void c6_write_control(const struc
 	struct per_cpu_cache *cache;
 	unsigned int cesr;
 
-	if (perfctr_cstatus_nractrs(state->cstatus) == 0) /* no PMC is on */
+	if (perfctr_cstatus_nractrs(state->user.cstatus) == 0) /* no PMC is on */
 		return;
 	cache = get_cpu_cache();
-	cesr = state->k1.id;
-	if (cache->k1.p5_cesr != cesr) {
-		cache->k1.p5_cesr = cesr;
+	cesr = state->id;
+	if (cache->id != cesr) {
+		cache->id = cesr;
 		wrmsr(MSR_P5_CESR, cesr, 0);
 	}
 }
@@ -415,7 +412,7 @@ static int p6_like_check_control(struct 
 	pmc_mask = 0;
 	for(i = 0; i < nrctrs; ++i) {
 		pmc = state->control.pmc_map[i];
-		state->pmc[i].map = pmc;
+		state->user.pmc[i].map = pmc;
 		if (pmc >= (is_k7 ? 4 : 2) || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
@@ -450,7 +447,7 @@ static int p6_like_check_control(struct 
 				return -EINVAL;
 		}
 	}
-	state->k1.id = new_id();
+	state->id = new_id();
 	return 0;
 }
 
@@ -474,11 +471,11 @@ static void p6_like_isuspend(struct perf
 	set_isuspend_cpu(state, cpu); /* early to limit cpu's live range */
 	cache = __get_cpu_cache(cpu);
 	perfctr_cpu_mask_interrupts(cache);
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
 		unsigned int pmc_raw, pmc_idx, now;
-		pmc_raw = state->pmc[i].map;
+		pmc_raw = state->user.pmc[i].map;
 		/* Note: P4_MASK_FAST_RDPMC is a no-op for P6 and K7.
 		   We don't need to make it into a parameter. */
 		pmc_idx = pmc_raw & P4_MASK_FAST_RDPMC;
@@ -487,13 +484,13 @@ static void p6_like_isuspend(struct perf
 		wrmsr(msr_evntsel0+pmc_idx, 0, 0);
 		/* P4 erratum N17 does not apply since we read only low 32 bits. */
 		rdpmc_low(pmc_raw, now);
-		state->pmc[i].sum += now - state->pmc[i].start;
-		state->pmc[i].start = now;
+		state->user.pmc[i].sum += now - state->user.pmc[i].start;
+		state->user.pmc[i].start = now;
 		if ((int)now >= 0)
 			++pending;
 	}
 	state->pending_interrupt = pending;
-	/* cache->k1.id is still == state->k1.id */
+	/* cache->id is still == state->id */
 }
 
 /* PRE: perfctr_cstatus_has_ictrs(state->cstatus) != 0 */
@@ -509,17 +506,17 @@ static void p6_like_iresume(const struct
 	cpu = smp_processor_id();
 	cache = __get_cpu_cache(cpu);
 	perfctr_cpu_unmask_interrupts(cache);
-	if (cache->k1.id == state->k1.id) {
-		cache->k1.id = 0; /* force reload of cleared EVNTSELs */
+	if (cache->id == state->id) {
+		cache->id = 0; /* force reload of cleared EVNTSELs */
 		if (is_isuspend_cpu(state, cpu))
 			return; /* skip reload of PERFCTRs */
 	}
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
 		/* Note: P4_MASK_FAST_RDPMC is a no-op for P6 and K7.
 		   We don't need to make it into a parameter. */
-		unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		unsigned int pmc = state->user.pmc[i].map & P4_MASK_FAST_RDPMC;
 		/* If the control wasn't ours we must disable the evntsels
 		   before reinitialising the counters, to prevent unexpected
 		   counter increments and missed overflow interrupts. */
@@ -528,9 +525,9 @@ static void p6_like_iresume(const struct
 			wrmsr(msr_evntsel0+pmc, 0, 0);
 		}
 		/* P4 erratum N15 does not apply since the CCCR is disabled. */
-		wrmsr(msr_perfctr0+pmc, state->pmc[i].start, -1);
+		wrmsr(msr_perfctr0+pmc, state->user.pmc[i].start, -1);
 	}
-	/* cache->k1.id remains != state->k1.id */
+	/* cache->id remains != state->id */
 }
 
 static void p6_isuspend(struct perfctr_cpu_state *state)
@@ -552,18 +549,18 @@ static void p6_like_write_control(const 
 	unsigned int nrctrs, i;
 
 	cache = get_cpu_cache();
-	if (cache->k1.id == state->k1.id)
+	if (cache->id == state->id)
 		return;
-	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
+	nrctrs = perfctr_cstatus_nrctrs(state->user.cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int pmc = state->pmc[i].map;
+		unsigned int pmc = state->user.pmc[i].map;
 		unsigned int evntsel = state->control.evntsel[pmc];
 		if (evntsel != cache->control.evntsel[pmc]) {
 			cache->control.evntsel[pmc] = evntsel;
 			wrmsr(msr_evntsel0+pmc, evntsel, 0);
 		}
 	}
-	cache->k1.id = state->k1.id;
+	cache->id = state->id;
 }
 
 /* shared with VC3, Generic*/
@@ -642,12 +639,12 @@ static int vc3_check_control(struct perf
 	if (state->control.header.nractrs == 1) {
 		if (state->control.pmc_map[0] != 1)
 			return -EINVAL;
-		state->pmc[0].map = 1;
+		state->user.pmc[0].map = 1;
 		if (state->control.evntsel[1] & VC3_EVNTSEL1_RESERVED)
 			return -EPERM;
-		state->k1.id = state->control.evntsel[1];
+		state->id = state->control.evntsel[1];
 	} else
-		state->k1.id = 0;
+		state->id = 0;
 	return 0;
 }
 
@@ -768,7 +765,7 @@ static int p4_check_control(struct perfc
 		   pmc_map[i] is what we pass to RDPMC, the PMC itself
 		   is extracted by masking off the FAST_RDPMC flag */
 		pmc = state->control.pmc_map[i] & ~P4_FAST_RDPMC;
-		state->pmc[i].map = state->control.pmc_map[i];
+		state->user.pmc[i].map = state->control.pmc_map[i];
 		if (pmc >= 18 || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
@@ -829,7 +826,7 @@ static int p4_check_control(struct perfc
 			return -EINVAL;
 	} else if (state->control.p4.pebs_matrix_vert)
 		return -EPERM;
-	state->k1.id = new_id();
+	state->id = new_id();
 	return 0;
 }
 
@@ -851,9 +848,9 @@ static void p4_write_control(const struc
 	unsigned int nrctrs, i;
 
 	cache = get_cpu_cache();
-	if (cache->k1.id == state->k1.id)
+	if (cache->id == state->id)
 		return;
-	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
+	nrctrs = perfctr_cstatus_nrctrs(state->user.cstatus);
 	for(i = 0; i < nrctrs; ++i) {
 		unsigned int escr_val, escr_off, cccr_val, pmc;
 		escr_off = state->p4_escr_map[i];
@@ -862,7 +859,7 @@ static void p4_write_control(const struc
 			cache->control.escr[escr_off] = escr_val;
 			wrmsr(MSR_P4_ESCR0+escr_off, escr_val, 0);
 		}
-		pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		pmc = state->user.pmc[i].map & P4_MASK_FAST_RDPMC;
 		cccr_val = state->control.evntsel[pmc];
 		if (cccr_val != cache->control.evntsel[pmc]) {
 			cache->control.evntsel[pmc] = cccr_val;
@@ -877,7 +874,7 @@ static void p4_write_control(const struc
 		cache->control.pebs_matrix_vert = state->control.p4.pebs_matrix_vert;
 		wrmsr(MSR_P4_PEBS_MATRIX_VERT, state->control.p4.pebs_matrix_vert, 0);
 	}
-	cache->k1.id = state->k1.id;
+	cache->id = state->id;
 }
 
 static void p4_clear_counters(void)
@@ -987,7 +984,7 @@ void perfctr_cpu_ireload(struct perfctr_
 #ifdef CONFIG_SMP
 	clear_isuspend_cpu(state);
 #else
-	get_cpu_cache()->k1.id = 0;
+	get_cpu_cache()->id = 0;
 #endif
 }
 
@@ -997,15 +994,15 @@ unsigned int perfctr_cpu_identify_overfl
 {
 	unsigned int cstatus, nrctrs, i, pmc_mask;
 
-	cstatus = state->cstatus;
+	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	state->pending_interrupt = 0;
 	pmc_mask = 0;
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
-		if ((int)state->pmc[i].start >= 0) { /* XXX: ">" ? */
-			unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		if ((int)state->user.pmc[i].start >= 0) { /* XXX: ">" ? */
+			unsigned int pmc = state->user.pmc[i].map & P4_MASK_FAST_RDPMC;
 			/* XXX: "+=" to correct for overshots */
-			state->pmc[i].start = state->control.ireset[pmc];
+			state->user.pmc[i].start = state->control.ireset[pmc];
 			pmc_mask |= (1 << i);
 			/* On a P4 we should now clear the OVF flag in the
 			   counter's CCCR. However, p4_isuspend() already
@@ -1025,10 +1022,10 @@ static inline int check_ireset(struct pe
 	i = state->control.header.nractrs;
 	nrctrs = i + state->control.header.nrictrs;
 	for(; i < nrctrs; ++i) {
-		unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		unsigned int pmc = state->user.pmc[i].map & P4_MASK_FAST_RDPMC;
 		if ((int)state->control.ireset[pmc] >= 0)
 			return -EINVAL;
-		state->pmc[i].start = state->control.ireset[pmc];
+		state->user.pmc[i].start = state->control.ireset[pmc];
 	}
 	return 0;
 }
@@ -1045,7 +1042,7 @@ int perfctr_cpu_update_control(struct pe
 	int err;
 
 	clear_isuspend_cpu(state);
-	state->cstatus = 0;
+	state->user.cstatus = 0;
 
 	/* disallow i-mode counters if we cannot catch the interrupts */
 	if (!(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
@@ -1058,9 +1055,9 @@ int perfctr_cpu_update_control(struct pe
 	err = check_ireset(state);
 	if (err < 0)
 		return err;
-	state->cstatus = perfctr_mk_cstatus(state->control.header.tsc_on,
-					    state->control.header.nractrs,
-					    state->control.header.nrictrs);
+	state->user.cstatus = perfctr_mk_cstatus(state->control.header.tsc_on,
+						 state->control.header.nractrs,
+						 state->control.header.nrictrs);
 	return 0;
 }
 
@@ -1161,21 +1158,21 @@ void perfctr_cpu_suspend(struct perfctr_
 	unsigned int i, cstatus, nractrs;
 	struct perfctr_low_ctrs now;
 
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
 	/* perfctr_cpu_disable_rdpmc(); */	/* not for x86 */
 }
 
 void perfctr_cpu_resume(struct perfctr_cpu_state *state)
 {
-	if (perfctr_cstatus_has_ictrs(state->cstatus))
+	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
 	    perfctr_cpu_iresume(state);
 	/* perfctr_cpu_enable_rdpmc(); */	/* not for x86 or global-mode */
 	perfctr_cpu_write_control(state);
@@ -1184,12 +1181,12 @@ void perfctr_cpu_resume(struct perfctr_c
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
@@ -1200,15 +1197,15 @@ void perfctr_cpu_sample(struct perfctr_c
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
 
@@ -1252,12 +1249,12 @@ static void __init finalise_backpatching
 	memset(cache, 0, sizeof *cache);
 	memset(&state, 0, sizeof state);
 	if (perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT) {
-		state.cstatus = __perfctr_mk_cstatus(0, 1, 0, 0);
+		state.user.cstatus = __perfctr_mk_cstatus(0, 1, 0, 0);
 		perfctr_cpu_sample(&state);
 		perfctr_cpu_resume(&state);
 		perfctr_cpu_suspend(&state);
 	}
-	state.cstatus = 0;
+	state.user.cstatus = 0;
 	perfctr_cpu_sample(&state);
 	perfctr_cpu_resume(&state);
 	perfctr_cpu_suspend(&state);
diff -rupN linux-2.6.12-rc1-mm3/include/asm-i386/perfctr.h linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-x86/include/asm-i386/perfctr.h
--- linux-2.6.12-rc1-mm3/include/asm-i386/perfctr.h	2005-03-28 17:26:21.000000000 +0200
+++ linux-2.6.12-rc1-mm3.perfctr-mapped-state-cleanup-x86/include/asm-i386/perfctr.h	2005-03-28 23:08:09.000000000 +0200
@@ -19,26 +19,8 @@ struct perfctr_cpu_control_header {
 	__u32 nrictrs;	/* number of interrupt-mode counters */
 };
 
-#ifdef __KERNEL__
-struct perfctr_cpu_control {
-	struct perfctr_cpu_control_header header;
-	unsigned int evntsel[18];	/* primary control registers, physical indices */
-	unsigned int ireset[18];	/* >= 2^31, for i-mode counters, physical indices */
-	struct {
-		unsigned int escr[0x3E2-0x3A0];	/* secondary controls, physical indices */
-		unsigned int pebs_enable;	/* for replay tagging */
-		unsigned int pebs_matrix_vert;	/* for replay tagging */
-	} p4;
-	unsigned int pmc_map[18];	/* virtual to physical (rdpmc) index map */
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
@@ -48,13 +30,6 @@ struct perfctr_cpu_state {
 		__u32 start;
 		__u64 sum;
 	} pmc[18];	/* the size is not part of the user ABI */
-#ifdef __KERNEL__
-	struct perfctr_cpu_control control;
-	unsigned int p4_escr_map[18];
-#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
-	unsigned int pending_interrupt;
-#endif
-#endif
 };
 
 /* cstatus is a re-encoding of control.tsc_on/nractrs/nrictrs
@@ -121,6 +96,31 @@ static inline unsigned int perfctr_cstat
 
 #if defined(CONFIG_PERFCTR)
 
+struct perfctr_cpu_control {
+	struct perfctr_cpu_control_header header;
+	unsigned int evntsel[18];	/* primary control registers, physical indices */
+	unsigned int ireset[18];	/* >= 2^31, for i-mode counters, physical indices */
+	struct {
+		unsigned int escr[0x3E2-0x3A0];	/* secondary controls, physical indices */
+		unsigned int pebs_enable;	/* for replay tagging */
+		unsigned int pebs_matrix_vert;	/* for replay tagging */
+	} p4;
+	unsigned int pmc_map[18];	/* virtual to physical (rdpmc) index map */
+};
+
+struct perfctr_cpu_state {
+	/* Don't change field order here without first considering the number
+	   of cache lines touched during sampling and context switching. */
+	unsigned int id;
+	int isuspend_cpu;
+	struct perfctr_cpu_state_user user;
+	struct perfctr_cpu_control control;
+	unsigned int p4_escr_map[18];
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+	unsigned int pending_interrupt;
+#endif
+};
+
 /* Driver init/exit. */
 extern int perfctr_cpu_init(void);
 extern void perfctr_cpu_exit(void);
