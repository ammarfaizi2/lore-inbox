Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262584AbUKXKGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262584AbUKXKGJ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 05:06:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262587AbUKXKGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 05:06:09 -0500
Received: from aun.it.uu.se ([130.238.12.36]:42471 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262584AbUKXKFw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 05:05:52 -0500
Date: Wed, 24 Nov 2004 11:05:41 +0100 (MET)
Message-Id: <200411241005.iAOA5f6w022469@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc2-mm3][1/3] perfctr ppc32 update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 1/3 of perfctr control API changes:
- Switch per-counter control fields from struct-of-arrays
  to array-of-struct layout, placed at the end of the
  perfctr_cpu_control struct for flexibility.
- Drop ____cacheline_aligned from per-cpu cache object.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c     |   14 +++++++-------
 include/asm-ppc/perfctr.h |   10 ++++++----
 2 files changed, 13 insertions(+), 11 deletions(-)

diff -rupN linux-2.6.10-rc2-mm3/drivers/perfctr/ppc.c linux-2.6.10-rc2-mm3.perfctr-ppc32-update/drivers/perfctr/ppc.c
--- linux-2.6.10-rc2-mm3/drivers/perfctr/ppc.c	2004-11-24 01:52:30.000000000 +0100
+++ linux-2.6.10-rc2-mm3.perfctr-ppc32-update/drivers/perfctr/ppc.c	2004-11-24 02:06:12.672973000 +0100
@@ -1,4 +1,4 @@
-/* $Id: ppc.c,v 1.27 2004/10/24 00:07:44 mikpe Exp $
+/* $Id: ppc.c,v 1.30 2004/11/24 00:23:27 mikpe Exp $
  * PPC32 performance-monitoring counters driver.
  *
  * Copyright (C) 2004  Mikael Pettersson
@@ -20,7 +20,7 @@ struct per_cpu_cache {	/* roughly a subs
 	} k1;
 	/* Physically indexed cache of the MMCRs. */
 	unsigned int ppc_mmcr[3];
-} ____cacheline_aligned;
+};
 static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
 #define __get_cpu_cache(cpu) (&per_cpu(per_cpu_cache, cpu))
 #define get_cpu_cache()	(&__get_cpu_var(per_cpu_cache))
@@ -299,7 +299,7 @@ static int ppc_check_control(struct perf
 	pmi_mask = 0;
 	memset(evntsel, 0, sizeof evntsel);
 	for(i = 0; i < nrctrs; ++i) {
-		pmc = state->control.pmc_map[i];
+		pmc = state->control.pmc[i].map;
 		state->pmc[i].map = pmc;
 		if (pmc >= nr_pmcs || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
@@ -308,7 +308,7 @@ static int ppc_check_control(struct perf
 		if (i >= nractrs)
 			pmi_mask |= (1<<pmc);
 
-		evntsel[pmc] = state->control.evntsel[i];
+		evntsel[pmc] = state->control.pmc[i].evntsel;
 		if (evntsel[pmc] > pmc_max_event(pmc))
 			return -EINVAL;
 	}
@@ -566,7 +566,7 @@ unsigned int perfctr_cpu_identify_overfl
 	for(pmc_mask = 0; pmc < nrctrs; ++pmc) {
 		if ((int)state->pmc[pmc].start < 0) { /* PPC-specific */
 			/* XXX: "+=" to correct for overshots */
-			state->pmc[pmc].start = state->control.ireset[pmc];
+			state->pmc[pmc].start = state->control.pmc[pmc].ireset;
 			pmc_mask |= (1 << pmc);
 		}
 	}
@@ -582,7 +582,7 @@ static inline int check_ireset(const str
 	i = state->control.nractrs;
 	nrctrs = i + state->control.nrictrs;
 	for(; i < nrctrs; ++i)
-		if (state->control.ireset[i] < 0)	/* PPC-specific */
+		if (state->control.pmc[i].ireset < 0)	/* PPC-specific */
 			return -EINVAL;
 	return 0;
 }
@@ -594,7 +594,7 @@ static inline void setup_imode_start_val
 	cstatus = state->cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i)
-		state->pmc[i].start = state->control.ireset[i];
+		state->pmc[i].start = state->control.pmc[i].ireset;
 }
 
 #else	/* CONFIG_PERFCTR_INTERRUPT_SUPPORT */
diff -rupN linux-2.6.10-rc2-mm3/include/asm-ppc/perfctr.h linux-2.6.10-rc2-mm3.perfctr-ppc32-update/include/asm-ppc/perfctr.h
--- linux-2.6.10-rc2-mm3/include/asm-ppc/perfctr.h	2004-11-24 01:52:32.000000000 +0100
+++ linux-2.6.10-rc2-mm3.perfctr-ppc32-update/include/asm-ppc/perfctr.h	2004-11-24 02:06:59.000000000 +0100
@@ -1,4 +1,4 @@
-/* $Id: perfctr.h,v 1.6 2004/05/30 14:47:34 mikpe Exp $
+/* $Id: perfctr.h,v 1.12 2004/11/24 00:20:57 mikpe Exp $
  * PPC32 Performance-Monitoring Counters driver
  *
  * Copyright (C) 2004  Mikael Pettersson
@@ -23,9 +23,6 @@ struct perfctr_cpu_control {
 	unsigned int tsc_on;
 	unsigned int nractrs;		/* # of a-mode counters */
 	unsigned int nrictrs;		/* # of i-mode counters */
-	unsigned int pmc_map[8];
-	unsigned int evntsel[8];	/* one per counter, even on P5 */
-	int ireset[8];			/* [0,0x7fffffff], for i-mode counters */
 	struct {
 		unsigned int mmcr0;	/* sans PMC{1,2}SEL */
 		unsigned int mmcr2;	/* only THRESHMULT */
@@ -35,6 +32,11 @@ struct perfctr_cpu_control {
 	unsigned int _reserved2;
 	unsigned int _reserved3;
 	unsigned int _reserved4;
+	struct {
+		unsigned int map;	/* physical counter to use */
+		unsigned int evntsel;
+		int ireset;		/* [0,0x7fffffff], for i-mode counters */
+	} pmc[8];
 };
 
 struct perfctr_cpu_state {
