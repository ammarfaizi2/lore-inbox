Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262591AbUKXKJm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262591AbUKXKJm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:09:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262594AbUKXKIP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:08:15 -0500
Received: from aun.it.uu.se ([130.238.12.36]:61927 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262587AbUKXKGV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:06:21 -0500
Date: Wed, 24 Nov 2004 11:06:09 +0100 (MET)
Message-Id: <200411241006.iAOA691X022477@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc2-mm3][2/3] perfctr x86 update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 2/3 of perfctr control API changes:
- Switch per-counter control fields from struct-of-arrays
  to array-of-struct layout, placed at the end of the
  perfctr_cpu_control struct for flexibility.
- Drop ____cacheline_aligned from per-cpu cache object.
- In per-cpu cache object, make interrupts_masked flag
  share cache line with the cache id field.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c      |   46 ++++++++++++++++++++++-----------------------
 include/asm-i386/perfctr.h |   12 ++++++-----
 2 files changed, 30 insertions(+), 28 deletions(-)

diff -rupN linux-2.6.10-rc2-mm3/drivers/perfctr/x86.c linux-2.6.10-rc2-mm3.perfctr-x86-update/drivers/perfctr/x86.c
--- linux-2.6.10-rc2-mm3/drivers/perfctr/x86.c	2004-11-24 01:52:30.000000000 +0100
+++ linux-2.6.10-rc2-mm3.perfctr-x86-update/drivers/perfctr/x86.c	2004-11-24 02:10:26.000000000 +0100
@@ -1,4 +1,4 @@
-/* $Id: x86.c,v 1.146 2004/08/02 17:29:23 mikpe Exp $
+/* $Id: x86.c,v 1.151 2004/11/24 00:28:23 mikpe Exp $
  * x86/x86_64 performance-monitoring counters driver.
  *
  * Copyright (C) 1999-2004  Mikael Pettersson
@@ -27,6 +27,9 @@ struct per_cpu_cache {	/* roughly a subs
 		unsigned int p5_cesr;
 		unsigned int id;	/* cache owner id */
 	} k1;
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+	unsigned int interrupts_masked;
+#endif
 	struct {
 		/* NOTE: these caches have physical indices, not virtual */
 		unsigned int evntsel[18];
@@ -34,10 +37,7 @@ struct per_cpu_cache {	/* roughly a subs
 		unsigned int pebs_enable;
 		unsigned int pebs_matrix_vert;
 	} control;
-#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
-	unsigned int interrupts_masked;
-#endif
-} ____cacheline_aligned;
+};
 static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
 #define __get_cpu_cache(cpu) (&per_cpu(per_cpu_cache, cpu))
 #define get_cpu_cache() (&__get_cpu_var(per_cpu_cache))
@@ -247,11 +247,11 @@ static int p5_like_check_control(struct 
 	cesr_half[0] = 0;
 	cesr_half[1] = 0;
 	for(i = 0; i < state->control.nractrs; ++i) {
-		pmc = state->control.pmc_map[i];
+		pmc = state->control.pmc[i].map;
 		state->pmc[i].map = pmc;
 		if (pmc > 1 || cesr_half[pmc] != 0)
 			return -EINVAL;
-		evntsel = state->control.evntsel[i];
+		evntsel = state->control.pmc[i].evntsel;
 		/* protect reserved bits */
 		if ((evntsel & reserved_bits) != 0)
 			return -EPERM;
@@ -413,12 +413,12 @@ static int p6_like_check_control(struct 
 
 	pmc_mask = 0;
 	for(i = 0; i < nrctrs; ++i) {
-		pmc = state->control.pmc_map[i];
+		pmc = state->control.pmc[i].map;
 		state->pmc[i].map = pmc;
 		if (pmc >= (is_k7 ? 4 : 2) || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
-		evntsel = state->control.evntsel[i];
+		evntsel = state->control.pmc[i].evntsel;
 		/* protect reserved bits */
 		if (evntsel & P6_EVNTSEL_RESERVED)
 			return -EPERM;
@@ -555,7 +555,7 @@ static void p6_like_write_control(const 
 		return;
 	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int evntsel = state->control.evntsel[i];
+		unsigned int evntsel = state->control.pmc[i].evntsel;
 		unsigned int pmc = state->pmc[i].map;
 		if (evntsel != cache->control.evntsel[pmc]) {
 			cache->control.evntsel[pmc] = evntsel;
@@ -639,12 +639,12 @@ static int vc3_check_control(struct perf
 	if (state->control.nrictrs || state->control.nractrs > 1)
 		return -EINVAL;
 	if (state->control.nractrs == 1) {
-		if (state->control.pmc_map[0] != 1)
+		if (state->control.pmc[0].map != 1)
 			return -EINVAL;
 		state->pmc[0].map = 1;
-		if (state->control.evntsel[0] & VC3_EVNTSEL1_RESERVED)
+		if (state->control.pmc[0].evntsel & VC3_EVNTSEL1_RESERVED)
 			return -EPERM;
-		state->k1.id = state->control.evntsel[0];
+		state->k1.id = state->control.pmc[0].evntsel;
 	} else
 		state->k1.id = 0;
 	return 0;
@@ -766,13 +766,13 @@ static int p4_check_control(struct perfc
 		/* check that pmc_map[] is well-defined;
 		   pmc_map[i] is what we pass to RDPMC, the PMC itself
 		   is extracted by masking off the FAST_RDPMC flag */
-		pmc = state->control.pmc_map[i] & ~P4_FAST_RDPMC;
-		state->pmc[i].map = state->control.pmc_map[i];
+		pmc = state->control.pmc[i].map & ~P4_FAST_RDPMC;
+		state->pmc[i].map = state->control.pmc[i].map;
 		if (pmc >= 18 || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
 		/* check CCCR contents */
-		cccr_val = state->control.evntsel[i];
+		cccr_val = state->control.pmc[i].evntsel;
 		if (cccr_val & P4_CCCR_RESERVED)
 			return -EPERM;
 		if (cccr_val & P4_CCCR_EXTENDED_CASCADE) {
@@ -789,14 +789,14 @@ static int p4_check_control(struct perfc
 			if (i < nractrs)
 				return -EINVAL;
 			if ((cccr_val & P4_CCCR_FORCE_OVF) &&
-			    state->control.ireset[i] != -1)
+			    state->control.pmc[i].ireset != -1)
 				return -EINVAL;
 		} else {
 			if (i >= nractrs)
 				return -EINVAL;
 		}
 		/* check ESCR contents */
-		escr_val = state->control.p4.escr[i];
+		escr_val = state->control.pmc[i].p4_escr;
 		if (escr_val & P4_ESCR_RESERVED)
 			return -EPERM;
 		if ((escr_val & P4_ESCR_CPL_T1) && (!p4_is_ht || !is_global))
@@ -855,13 +855,13 @@ static void p4_write_control(const struc
 	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
 	for(i = 0; i < nrctrs; ++i) {
 		unsigned int escr_val, escr_off, cccr_val, pmc;
-		escr_val = state->control.p4.escr[i];
+		escr_val = state->control.pmc[i].p4_escr;
 		escr_off = state->p4_escr_map[i];
 		if (escr_val != cache->control.escr[escr_off]) {
 			cache->control.escr[escr_off] = escr_val;
 			wrmsr(MSR_P4_ESCR0+escr_off, escr_val, 0);
 		}
-		cccr_val = state->control.evntsel[i];
+		cccr_val = state->control.pmc[i].evntsel;
 		pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
 		if (cccr_val != cache->control.evntsel[pmc]) {
 			cache->control.evntsel[pmc] = cccr_val;
@@ -1004,7 +1004,7 @@ unsigned int perfctr_cpu_identify_overfl
 	for(pmc_mask = 0; pmc < nrctrs; ++pmc) {
 		if ((int)state->pmc[pmc].start >= 0) { /* XXX: ">" ? */
 			/* XXX: "+=" to correct for overshots */
-			state->pmc[pmc].start = state->control.ireset[pmc];
+			state->pmc[pmc].start = state->control.pmc[pmc].ireset;
 			pmc_mask |= (1 << pmc);
 			/* On a P4 we should now clear the OVF flag in the
 			   counter's CCCR. However, p4_isuspend() already
@@ -1024,7 +1024,7 @@ static inline int check_ireset(const str
 	i = state->control.nractrs;
 	nrctrs = i + state->control.nrictrs;
 	for(; i < nrctrs; ++i)
-		if (state->control.ireset[i] >= 0)
+		if (state->control.pmc[i].ireset >= 0)
 			return -EINVAL;
 	return 0;
 }
@@ -1036,7 +1036,7 @@ static inline void setup_imode_start_val
 	cstatus = state->cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
-		state->pmc[i].start = state->control.ireset[i];
+		state->pmc[i].start = state->control.pmc[i].ireset;
 }
 
 #else	/* CONFIG_X86_LOCAL_APIC */
diff -rupN linux-2.6.10-rc2-mm3/include/asm-i386/perfctr.h linux-2.6.10-rc2-mm3.perfctr-x86-update/include/asm-i386/perfctr.h
--- linux-2.6.10-rc2-mm3/include/asm-i386/perfctr.h	2004-11-24 01:52:32.000000000 +0100
+++ linux-2.6.10-rc2-mm3.perfctr-x86-update/include/asm-i386/perfctr.h	2004-11-24 02:09:57.000000000 +0100
@@ -1,4 +1,4 @@
-/* $Id: perfctr.h,v 1.52 2004/05/23 22:36:34 mikpe Exp $
+/* $Id: perfctr.h,v 1.57 2004/11/24 00:21:20 mikpe Exp $
  * x86/x86_64 Performance-Monitoring Counters driver
  *
  * Copyright (C) 1999-2004  Mikael Pettersson
@@ -34,18 +34,20 @@ struct perfctr_cpu_control {
 	unsigned int tsc_on;
 	unsigned int nractrs;		/* # of a-mode counters */
 	unsigned int nrictrs;		/* # of i-mode counters */
-	unsigned int pmc_map[18];
-	unsigned int evntsel[18];	/* one per counter, even on P5 */
 	struct {
-		unsigned int escr[18];
 		unsigned int pebs_enable;	/* for replay tagging */
 		unsigned int pebs_matrix_vert;	/* for replay tagging */
 	} p4;
-	int ireset[18];			/* < 0, for i-mode counters */
 	unsigned int _reserved1;
 	unsigned int _reserved2;
 	unsigned int _reserved3;
 	unsigned int _reserved4;
+	struct {
+		unsigned int map;	/* for rdpmc */
+		unsigned int evntsel;	/* one per counter, even on P5 */
+		unsigned int p4_escr;
+		int ireset;		/* < 0, for i-mode counters */
+	} pmc[18];
 };
 
 struct perfctr_cpu_state {
