Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVDINLs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVDINLs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 09:11:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261250AbVDINLr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 09:11:47 -0400
Received: from aun.it.uu.se ([130.238.12.36]:14035 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261235AbVDINLi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 09:11:38 -0400
Date: Sat, 9 Apr 2005 15:11:24 +0200 (MEST)
Message-Id: <200504091311.j39DBOxi004215@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc2-mm2 1/3] perfctr: x86 ABI update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This 3-part patch set widens the counter 'start' fields in
the mmap()-visible state from 32 to 64 bits, to prepare
for future processors that may need that extra precision.

This would bump the size of the pmc[] array elements to 24 bytes,
of which only 20 would be used, so the 'map' fields in that array
are removed -- the kernel can retrive that data from the control
structure instead, and user-space can also maintain it itself.
This brings the pmc[] array elements down to 16 bytes again,
with 100% utilisation.

The removal of the 'cstatus' field from the user-visible state
that David Gibson proposed has not been done. The problem is that
cstatus also exposes asynchronous state changes (in particular
at overflow interrupts), and I'm not yet convinced that user-space
can handle its removal without undue burden.

perfctr x86 ABI update:
- <asm-i386/perfctr.h>: In user-visible state, make start fields
  64 bits (for future-proofing the ABI). Remove map field from
  pmc[] array to avoid underutilised cache lines.
- x86.c: retrieve mapping from ->control.pmc_map[].

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c      |   24 ++++++++++--------------
 include/asm-i386/perfctr.h |   10 ++++------
 2 files changed, 14 insertions(+), 20 deletions(-)

diff -rupN linux-2.6.12-rc2-mm2/drivers/perfctr/x86.c linux-2.6.12-rc2-mm2.perfctr-x86-update/drivers/perfctr/x86.c
--- linux-2.6.12-rc2-mm2/drivers/perfctr/x86.c	2005-04-08 13:14:23.000000000 +0200
+++ linux-2.6.12-rc2-mm2.perfctr-x86-update/drivers/perfctr/x86.c	2005-04-09 14:06:58.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: x86.c,v 1.155 2005/03/13 13:55:58 mikpe Exp $
+/* $Id: x86.c,v 1.158 2005/04/08 14:36:49 mikpe Exp $
  * x86/x86_64 performance-monitoring counters driver.
  *
  * Copyright (C) 1999-2005  Mikael Pettersson
@@ -242,7 +242,6 @@ static int p5_like_check_control(struct 
 	cesr_half[1] = 0;
 	for(i = 0; i < state->control.header.nractrs; ++i) {
 		pmc = state->control.pmc_map[i];
-		state->user.pmc[i].map = pmc;
 		if (pmc > 1 || cesr_half[pmc] != 0)
 			return -EINVAL;
 		evntsel = state->control.evntsel[0];
@@ -298,7 +297,7 @@ static void p5_read_counters(const struc
 		rdtscl(ctrs->tsc);
 	nrctrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int pmc = state->control.pmc_map[i];
 		rdmsr_low(MSR_P5_CTR0+pmc, ctrs->pmc[i]);
 	}
 }
@@ -314,7 +313,7 @@ static void rdpmc_read_counters(const st
 		rdtscl(ctrs->tsc);
 	nrctrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int pmc = state->control.pmc_map[i];
 		rdpmc_low(pmc, ctrs->pmc[i]);
 	}
 }
@@ -412,7 +411,6 @@ static int p6_like_check_control(struct 
 	pmc_mask = 0;
 	for(i = 0; i < nrctrs; ++i) {
 		pmc = state->control.pmc_map[i];
-		state->user.pmc[i].map = pmc;
 		if (pmc >= (is_k7 ? 4 : 2) || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
@@ -475,7 +473,7 @@ static void p6_like_isuspend(struct perf
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
 		unsigned int pmc_raw, pmc_idx, now;
-		pmc_raw = state->user.pmc[i].map;
+		pmc_raw = state->control.pmc_map[i];
 		/* Note: P4_MASK_FAST_RDPMC is a no-op for P6 and K7.
 		   We don't need to make it into a parameter. */
 		pmc_idx = pmc_raw & P4_MASK_FAST_RDPMC;
@@ -516,7 +514,7 @@ static void p6_like_iresume(const struct
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
 		/* Note: P4_MASK_FAST_RDPMC is a no-op for P6 and K7.
 		   We don't need to make it into a parameter. */
-		unsigned int pmc = state->user.pmc[i].map & P4_MASK_FAST_RDPMC;
+		unsigned int pmc = state->control.pmc_map[i] & P4_MASK_FAST_RDPMC;
 		/* If the control wasn't ours we must disable the evntsels
 		   before reinitialising the counters, to prevent unexpected
 		   counter increments and missed overflow interrupts. */
@@ -525,7 +523,7 @@ static void p6_like_iresume(const struct
 			wrmsr(msr_evntsel0+pmc, 0, 0);
 		}
 		/* P4 erratum N15 does not apply since the CCCR is disabled. */
-		wrmsr(msr_perfctr0+pmc, state->user.pmc[i].start, -1);
+		wrmsr(msr_perfctr0+pmc, (unsigned int)state->user.pmc[i].start, -1);
 	}
 	/* cache->id remains != state->id */
 }
@@ -553,7 +551,7 @@ static void p6_like_write_control(const 
 		return;
 	nrctrs = perfctr_cstatus_nrctrs(state->user.cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int pmc = state->control.pmc_map[i];
 		unsigned int evntsel = state->control.evntsel[pmc];
 		if (evntsel != cache->control.evntsel[pmc]) {
 			cache->control.evntsel[pmc] = evntsel;
@@ -639,7 +637,6 @@ static int vc3_check_control(struct perf
 	if (state->control.header.nractrs == 1) {
 		if (state->control.pmc_map[0] != 1)
 			return -EINVAL;
-		state->user.pmc[0].map = 1;
 		if (state->control.evntsel[1] & VC3_EVNTSEL1_RESERVED)
 			return -EPERM;
 		state->id = state->control.evntsel[1];
@@ -765,7 +762,6 @@ static int p4_check_control(struct perfc
 		   pmc_map[i] is what we pass to RDPMC, the PMC itself
 		   is extracted by masking off the FAST_RDPMC flag */
 		pmc = state->control.pmc_map[i] & ~P4_FAST_RDPMC;
-		state->user.pmc[i].map = state->control.pmc_map[i];
 		if (pmc >= 18 || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
@@ -859,7 +855,7 @@ static void p4_write_control(const struc
 			cache->control.escr[escr_off] = escr_val;
 			wrmsr(MSR_P4_ESCR0+escr_off, escr_val, 0);
 		}
-		pmc = state->user.pmc[i].map & P4_MASK_FAST_RDPMC;
+		pmc = state->control.pmc_map[i] & P4_MASK_FAST_RDPMC;
 		cccr_val = state->control.evntsel[pmc];
 		if (cccr_val != cache->control.evntsel[pmc]) {
 			cache->control.evntsel[pmc] = cccr_val;
@@ -1000,7 +996,7 @@ unsigned int perfctr_cpu_identify_overfl
 	pmc_mask = 0;
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
 		if ((int)state->user.pmc[i].start >= 0) { /* XXX: ">" ? */
-			unsigned int pmc = state->user.pmc[i].map & P4_MASK_FAST_RDPMC;
+			unsigned int pmc = state->control.pmc_map[i] & P4_MASK_FAST_RDPMC;
 			/* XXX: "+=" to correct for overshots */
 			state->user.pmc[i].start = state->control.ireset[pmc];
 			pmc_mask |= (1 << i);
@@ -1022,7 +1018,7 @@ static inline int check_ireset(struct pe
 	i = state->control.header.nractrs;
 	nrctrs = i + state->control.header.nrictrs;
 	for(; i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map & P4_MASK_FAST_RDPMC;
+		unsigned int pmc = state->control.pmc_map[i] & P4_MASK_FAST_RDPMC;
 		if ((int)state->control.ireset[pmc] >= 0)
 			return -EINVAL;
 		state->user.pmc[i].start = state->control.ireset[pmc];
diff -rupN linux-2.6.12-rc2-mm2/include/asm-i386/perfctr.h linux-2.6.12-rc2-mm2.perfctr-x86-update/include/asm-i386/perfctr.h
--- linux-2.6.12-rc2-mm2/include/asm-i386/perfctr.h	2005-04-08 13:14:24.000000000 +0200
+++ linux-2.6.12-rc2-mm2.perfctr-x86-update/include/asm-i386/perfctr.h	2005-04-09 14:06:58.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: perfctr.h,v 1.61 2005/03/17 23:57:10 mikpe Exp $
+/* $Id: perfctr.h,v 1.63 2005/04/08 14:36:49 mikpe Exp $
  * x86/x86_64 Performance-Monitoring Counters driver
  *
  * Copyright (C) 1999-2005  Mikael Pettersson
@@ -21,13 +21,11 @@ struct perfctr_cpu_control_header {
 
 struct perfctr_cpu_state_user {
 	__u32 cstatus;
-	/* The two tsc fields must be inlined. Placing them in a
-	   sub-struct causes unwanted internal padding on x86-64. */
-	__u32 tsc_start;
+	__u32 _filler;
+	__u64 tsc_start;
 	__u64 tsc_sum;
 	struct {
-		__u32 map;
-		__u32 start;
+		__u64 start;
 		__u64 sum;
 	} pmc[18];	/* the size is not part of the user ABI */
 };
