Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262052AbVCLXSu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262052AbVCLXSu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:18:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262064AbVCLXSu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:18:50 -0500
Received: from aun.it.uu.se ([130.238.12.36]:38857 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262052AbVCLXSC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:18:02 -0500
Date: Sun, 13 Mar 2005 00:17:55 +0100 (MET)
Message-Id: <200503122317.j2CNHtU3028784@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 1/9: physical indexing, x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Switch x86 driver to use physically-indexed control data.
- Rearrange struct perfctr_cpu_control. Remove _reserved fields.
- On P5 and P5 clones users must now format the two counters'
  control data into a single CESR image.
- On P4 check ESCR value after retrieving the counter's ESCR number.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 drivers/perfctr/x86.c      |   73 ++++++++++++++++++++++++---------------------
 include/asm-i386/perfctr.h |   14 ++------
 2 files changed, 43 insertions(+), 44 deletions(-)

diff -rupN linux-2.6.11-mm3/drivers/perfctr/x86.c linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/x86.c
--- linux-2.6.11-mm3/drivers/perfctr/x86.c	2005-03-12 19:26:25.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/x86.c	2005-03-12 19:55:52.000000000 +0100
@@ -224,9 +224,6 @@ static inline void clear_isuspend_cpu(st
  * - One TSC and two 40-bit PMCs.
  * - A single 32-bit CESR (MSR 0x11) controls both PMCs.
  *   CESR has two halves, each controlling one PMC.
- *   To keep the API reasonably clean, the user puts 16 bits of
- *   control data in each counter's evntsel; the driver combines
- *   these to a single 32-bit CESR value.
  * - Overflow interrupts are not available.
  * - Pentium MMX added the RDPMC instruction. RDPMC has lower
  *   overhead than RDMSR and it can be used in user-mode code.
@@ -247,11 +244,15 @@ static int p5_like_check_control(struct 
 	cesr_half[0] = 0;
 	cesr_half[1] = 0;
 	for(i = 0; i < state->control.nractrs; ++i) {
-		pmc = state->control.pmc[i].map;
+		pmc = state->control.pmc_map[i];
 		state->pmc[i].map = pmc;
 		if (pmc > 1 || cesr_half[pmc] != 0)
 			return -EINVAL;
-		evntsel = state->control.pmc[i].evntsel;
+		evntsel = state->control.evntsel[0];
+		if (pmc == 0)
+			evntsel &= 0xffff;
+		else
+			evntsel >>= 16;
 		/* protect reserved bits */
 		if ((evntsel & reserved_bits) != 0)
 			return -EPERM;
@@ -413,12 +414,12 @@ static int p6_like_check_control(struct 
 
 	pmc_mask = 0;
 	for(i = 0; i < nrctrs; ++i) {
-		pmc = state->control.pmc[i].map;
+		pmc = state->control.pmc_map[i];
 		state->pmc[i].map = pmc;
 		if (pmc >= (is_k7 ? 4 : 2) || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
-		evntsel = state->control.pmc[i].evntsel;
+		evntsel = state->control.evntsel[pmc];
 		/* protect reserved bits */
 		if (evntsel & P6_EVNTSEL_RESERVED)
 			return -EPERM;
@@ -555,8 +556,8 @@ static void p6_like_write_control(const 
 		return;
 	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int evntsel = state->control.pmc[i].evntsel;
 		unsigned int pmc = state->pmc[i].map;
+		unsigned int evntsel = state->control.evntsel[pmc];
 		if (evntsel != cache->control.evntsel[pmc]) {
 			cache->control.evntsel[pmc] = evntsel;
 			wrmsr(msr_evntsel0+pmc, evntsel, 0);
@@ -639,12 +640,12 @@ static int vc3_check_control(struct perf
 	if (state->control.nrictrs || state->control.nractrs > 1)
 		return -EINVAL;
 	if (state->control.nractrs == 1) {
-		if (state->control.pmc[0].map != 1)
+		if (state->control.pmc_map[0] != 1)
 			return -EINVAL;
 		state->pmc[0].map = 1;
-		if (state->control.pmc[0].evntsel & VC3_EVNTSEL1_RESERVED)
+		if (state->control.evntsel[1] & VC3_EVNTSEL1_RESERVED)
 			return -EPERM;
-		state->k1.id = state->control.pmc[0].evntsel;
+		state->k1.id = state->control.evntsel[1];
 	} else
 		state->k1.id = 0;
 	return 0;
@@ -766,13 +767,13 @@ static int p4_check_control(struct perfc
 		/* check that pmc_map[] is well-defined;
 		   pmc_map[i] is what we pass to RDPMC, the PMC itself
 		   is extracted by masking off the FAST_RDPMC flag */
-		pmc = state->control.pmc[i].map & ~P4_FAST_RDPMC;
-		state->pmc[i].map = state->control.pmc[i].map;
+		pmc = state->control.pmc_map[i] & ~P4_FAST_RDPMC;
+		state->pmc[i].map = state->control.pmc_map[i];
 		if (pmc >= 18 || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
 		/* check CCCR contents */
-		cccr_val = state->control.pmc[i].evntsel;
+		cccr_val = state->control.evntsel[pmc];
 		if (cccr_val & P4_CCCR_RESERVED)
 			return -EPERM;
 		if (cccr_val & P4_CCCR_EXTENDED_CASCADE) {
@@ -789,18 +790,12 @@ static int p4_check_control(struct perfc
 			if (i < nractrs)
 				return -EINVAL;
 			if ((cccr_val & P4_CCCR_FORCE_OVF) &&
-			    state->control.pmc[i].ireset != -1)
+			    state->control.ireset[pmc] != -1)
 				return -EINVAL;
 		} else {
 			if (i >= nractrs)
 				return -EINVAL;
 		}
-		/* check ESCR contents */
-		escr_val = state->control.pmc[i].p4_escr;
-		if (escr_val & P4_ESCR_RESERVED)
-			return -EPERM;
-		if ((escr_val & P4_ESCR_CPL_T1) && (!p4_is_ht || !is_global))
-			return -EINVAL;
 		/* compute and cache ESCR address */
 		escr_addr = p4_escr_addr(pmc, cccr_val);
 		if (!escr_addr)
@@ -811,6 +806,12 @@ static int p4_check_control(struct perfc
 		/* XXX: Two counters could map to the same ESCR. Should we
 		   check that they use the same ESCR value? */
 		state->p4_escr_map[i] = escr_addr - MSR_P4_ESCR0;
+		/* check ESCR contents */
+		escr_val = state->control.p4.escr[escr_addr - MSR_P4_ESCR0];
+		if (escr_val & P4_ESCR_RESERVED)
+			return -EPERM;
+		if ((escr_val & P4_ESCR_CPL_T1) && (!p4_is_ht || !is_global))
+			return -EINVAL;
 	}
 	/* check ReplayTagging control (PEBS_ENABLE and PEBS_MATRIX_VERT) */
 	if (state->control.p4.pebs_enable) {
@@ -855,14 +856,14 @@ static void p4_write_control(const struc
 	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
 	for(i = 0; i < nrctrs; ++i) {
 		unsigned int escr_val, escr_off, cccr_val, pmc;
-		escr_val = state->control.pmc[i].p4_escr;
 		escr_off = state->p4_escr_map[i];
+		escr_val = state->control.p4.escr[escr_off];
 		if (escr_val != cache->control.escr[escr_off]) {
 			cache->control.escr[escr_off] = escr_val;
 			wrmsr(MSR_P4_ESCR0+escr_off, escr_val, 0);
 		}
-		cccr_val = state->control.pmc[i].evntsel;
 		pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		cccr_val = state->control.evntsel[pmc];
 		if (cccr_val != cache->control.evntsel[pmc]) {
 			cache->control.evntsel[pmc] = cccr_val;
 			wrmsr(MSR_P4_CCCR0+pmc, cccr_val, 0);
@@ -994,18 +995,18 @@ void perfctr_cpu_ireload(struct perfctr_
 static int lvtpc_reinit_needed;
 unsigned int perfctr_cpu_identify_overflow(struct perfctr_cpu_state *state)
 {
-	unsigned int cstatus, nrctrs, pmc, pmc_mask;
+	unsigned int cstatus, nrctrs, i, pmc_mask;
 
 	cstatus = state->cstatus;
-	pmc = perfctr_cstatus_nractrs(cstatus);
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
-
 	state->pending_interrupt = 0;
-	for(pmc_mask = 0; pmc < nrctrs; ++pmc) {
-		if ((int)state->pmc[pmc].start >= 0) { /* XXX: ">" ? */
+	pmc_mask = 0;
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		if ((int)state->pmc[i].start >= 0) { /* XXX: ">" ? */
+			unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
 			/* XXX: "+=" to correct for overshots */
-			state->pmc[pmc].start = state->control.pmc[pmc].ireset;
-			pmc_mask |= (1 << pmc);
+			state->pmc[i].start = state->control.ireset[pmc];
+			pmc_mask |= (1 << i);
 			/* On a P4 we should now clear the OVF flag in the
 			   counter's CCCR. However, p4_isuspend() already
 			   did that as a side-effect of clearing the CCCR
@@ -1023,9 +1024,11 @@ static inline int check_ireset(const str
 
 	i = state->control.nractrs;
 	nrctrs = i + state->control.nrictrs;
-	for(; i < nrctrs; ++i)
-		if (state->control.pmc[i].ireset >= 0)
+	for(; i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		if ((int)state->control.ireset[pmc] >= 0)
 			return -EINVAL;
+	}
 	return 0;
 }
 
@@ -1035,8 +1038,10 @@ static inline void setup_imode_start_val
 
 	cstatus = state->cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
-	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
-		state->pmc[i].start = state->control.pmc[i].ireset;
+	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
+		unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
+		state->pmc[i].start = state->control.ireset[pmc];
+	}
 }
 
 #else	/* CONFIG_X86_LOCAL_APIC */
diff -rupN linux-2.6.11-mm3/include/asm-i386/perfctr.h linux-2.6.11-mm3.perfctr-physical-indexing/include/asm-i386/perfctr.h
--- linux-2.6.11-mm3/include/asm-i386/perfctr.h	2005-03-12 19:26:26.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-physical-indexing/include/asm-i386/perfctr.h	2005-03-12 19:55:52.000000000 +0100
@@ -34,20 +34,14 @@ struct perfctr_cpu_control {
 	unsigned int tsc_on;
 	unsigned int nractrs;		/* # of a-mode counters */
 	unsigned int nrictrs;		/* # of i-mode counters */
+	unsigned int evntsel[18];	/* primary control registers, physical indices */
+	unsigned int ireset[18];	/* >= 2^31, for i-mode counters, physical indices */
 	struct {
+		unsigned int escr[0x3E2-0x3A0];	/* secondary controls, physical indices */
 		unsigned int pebs_enable;	/* for replay tagging */
 		unsigned int pebs_matrix_vert;	/* for replay tagging */
 	} p4;
-	unsigned int _reserved1;
-	unsigned int _reserved2;
-	unsigned int _reserved3;
-	unsigned int _reserved4;
-	struct {
-		unsigned int map;	/* for rdpmc */
-		unsigned int evntsel;	/* one per counter, even on P5 */
-		unsigned int p4_escr;
-		int ireset;		/* < 0, for i-mode counters */
-	} pmc[18];
+	unsigned int pmc_map[18];	/* virtual to physical (rdpmc) index map */
 };
 
 struct perfctr_cpu_state {
