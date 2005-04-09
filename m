Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261250AbVDINMh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261250AbVDINMh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 09:12:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261340AbVDINMh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 09:12:37 -0400
Received: from aun.it.uu.se ([130.238.12.36]:27091 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261250AbVDINMR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 09:12:17 -0400
Date: Sat, 9 Apr 2005 15:12:08 +0200 (MEST)
Message-Id: <200504091312.j39DC8aW004244@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc2-mm2 2/3] perfctr: ppc32 ABI update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr ppc32 ABI update:
- <asm-ppc/perfctr.h>: In user-visible state, make start fields
  64 bits (for future-proofing the ABI). Remove map field from
  pmc[] array to avoid underutilised cache lines.
- ppc.c: retrieve mapping from ->control.pmc_map[].
- ppc32: Add sampling counter to user-visible state, and
  increment it in perfctr_cpu_resume() and perfctr_cpu_sample().

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c     |   16 ++++++++--------
 include/asm-ppc/perfctr.h |   15 +++++++++------
 2 files changed, 17 insertions(+), 14 deletions(-)

diff -rupN linux-2.6.12-rc2-mm2/drivers/perfctr/ppc.c linux-2.6.12-rc2-mm2.perfctr-ppc32-update/drivers/perfctr/ppc.c
--- linux-2.6.12-rc2-mm2/drivers/perfctr/ppc.c	2005-04-08 13:14:23.000000000 +0200
+++ linux-2.6.12-rc2-mm2.perfctr-ppc32-update/drivers/perfctr/ppc.c	2005-04-09 13:52:34.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: ppc.c,v 1.35 2005/03/17 23:50:05 mikpe Exp $
+/* $Id: ppc.c,v 1.39 2005/04/08 14:36:49 mikpe Exp $
  * PPC32 performance-monitoring counters driver.
  *
  * Copyright (C) 2004-2005  Mikael Pettersson
@@ -237,7 +237,7 @@ static void ppc_read_counters(struct per
 		ctrs->tsc = get_tbl();
 	nrctrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int pmc = state->control.pmc_map[i];
 		ctrs->pmc[i] = read_pmc(pmc);
 	}
 }
@@ -299,7 +299,6 @@ static int ppc_check_control(struct perf
 
 	for(i = 0; i < nrctrs; ++i) {
 		pmc = state->control.pmc_map[i];
-		state->user.pmc[i].map = pmc;
 		if (pmc >= nr_pmcs || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
@@ -380,7 +379,7 @@ static void ppc_isuspend(struct perfctr_
 	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int pmc = state->control.pmc_map[i];
 		unsigned int now = read_pmc(pmc);
 		state->user.pmc[i].sum += now - state->user.pmc[i].start;
 		state->user.pmc[i].start = now;
@@ -420,7 +419,7 @@ static void ppc_iresume(const struct per
 	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
-		pmc[state->user.pmc[i].map] = state->user.pmc[i].start;
+		pmc[state->control.pmc_map[i]] = state->user.pmc[i].start;
 
 	switch (pm_type) {
 	case PM_7450:
@@ -560,7 +559,7 @@ unsigned int perfctr_cpu_identify_overfl
 	pmc_mask = 0;
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
 		if ((int)state->user.pmc[i].start < 0) { /* PPC-specific */
-			unsigned int pmc = state->user.pmc[i].map;
+			unsigned int pmc = state->control.pmc_map[i];
 			/* XXX: "+=" to correct for overshots */
 			state->user.pmc[i].start = state->control.ireset[pmc];
 			pmc_mask |= (1 << i);
@@ -578,7 +577,7 @@ static inline int check_ireset(struct pe
 	i = state->control.header.nractrs;
 	nrctrs = i + state->control.header.nrictrs;
 	for(; i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int pmc = state->control.pmc_map[i];
 		if ((int)state->control.ireset[pmc] < 0) /* PPC-specific */
 			return -EINVAL;
 		state->user.pmc[i].start = state->control.ireset[pmc];
@@ -734,7 +733,7 @@ void perfctr_cpu_resume(struct perfctr_c
 		for(i = 0; i < nrctrs; ++i)
 			state->user.pmc[i].start = now.pmc[i];
 	}
-	/* XXX: if (SMP && start.tsc == now.tsc) ++now.tsc; */
+	++state->user.samplecnt;
 }
 
 void perfctr_cpu_sample(struct perfctr_cpu_state *state)
@@ -753,6 +752,7 @@ void perfctr_cpu_sample(struct perfctr_c
 		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
 		state->user.pmc[i].start = now.pmc[i];
 	}
+	++state->user.samplecnt;
 }
 
 static void perfctr_cpu_clear_counters(void)
diff -rupN linux-2.6.12-rc2-mm2/include/asm-ppc/perfctr.h linux-2.6.12-rc2-mm2.perfctr-ppc32-update/include/asm-ppc/perfctr.h
--- linux-2.6.12-rc2-mm2/include/asm-ppc/perfctr.h	2005-04-08 13:14:24.000000000 +0200
+++ linux-2.6.12-rc2-mm2.perfctr-ppc32-update/include/asm-ppc/perfctr.h	2005-04-09 13:52:34.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: perfctr.h,v 1.16 2005/03/17 23:58:54 mikpe Exp $
+/* $Id: perfctr.h,v 1.19 2005/04/08 14:36:49 mikpe Exp $
  * PPC32 Performance-Monitoring Counters driver
  *
  * Copyright (C) 2004-2005  Mikael Pettersson
@@ -21,13 +21,16 @@ struct perfctr_cpu_control_header {
 
 struct perfctr_cpu_state_user {
 	__u32 cstatus;
-	/* The two tsc fields must be inlined. Placing them in a
-	   sub-struct causes unwanted internal padding on x86-64. */
-	__u32 tsc_start;
+	/* 'samplecnt' is incremented every time the 'start'
+	   fields have been updated by a sampling operation.
+	   Unfortunately the PPC timebase (tsc_start) has too
+	   low frequency for it to be a reliable context-switch
+	   indicator for user-space. */
+	__u32 samplecnt;
+	__u64 tsc_start;
 	__u64 tsc_sum;
 	struct {
-		__u32 map;
-		__u32 start;
+		__u64 start;
 		__u64 sum;
 	} pmc[8];	/* the size is not part of the user ABI */
 };
