Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263040AbUHIKNO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263040AbUHIKNO (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Aug 2004 06:13:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266435AbUHIKNO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Aug 2004 06:13:14 -0400
Received: from aun.it.uu.se ([130.238.12.36]:52426 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S263040AbUHIKNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Aug 2004 06:13:01 -0400
Date: Mon, 9 Aug 2004 12:12:46 +0200 (MEST)
Message-Id: <200408091012.i79ACjjG012582@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc3-mm2] perfctr x86 update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here are some updates to perfctr's x86 low-level driver:
- Use macros to clean up x86 per-cpu cache accesses.
  This also allows me to minimise the differences between the driver
  in the -mm kernel and the driver in the external perfctr-2.6 package
  (perfctr-2.6 supports modular builds and 2.4 kernels).
- Fix x86_tests to handle P4 in 64-bit mode.
  This is needed for the Xeon with EM64T processor (Nocona).

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c       |   23 ++++++++++++-----------
 drivers/perfctr/x86_tests.c |    6 +++---
 2 files changed, 15 insertions(+), 14 deletions(-)

diff -ruN linux-2.6.8-rc3-mm2/drivers/perfctr/x86.c linux-2.6.8-rc3-mm2.perfctr-x86-updates/drivers/perfctr/x86.c
--- linux-2.6.8-rc3-mm2/drivers/perfctr/x86.c	2004-08-09 01:16:38.000000000 +0200
+++ linux-2.6.8-rc3-mm2.perfctr-x86-updates/drivers/perfctr/x86.c	2004-08-09 10:57:36.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: x86.c,v 1.141 2004/05/31 18:13:42 mikpe Exp $
+/* $Id: x86.c,v 1.146 2004/08/02 17:29:23 mikpe Exp $
  * x86/x86_64 performance-monitoring counters driver.
  *
  * Copyright (C) 1999-2004  Mikael Pettersson
@@ -36,6 +36,8 @@
 	} control;
 } ____cacheline_aligned;
 static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
+#define __get_cpu_cache(cpu) (&per_cpu(per_cpu_cache, cpu))
+#define get_cpu_cache() (&__get_cpu_var(per_cpu_cache))
 
 /* Structure for counter snapshots, as 32-bit values. */
 struct perfctr_low_ctrs {
@@ -261,7 +263,7 @@
 	cesr = state->k1.id;
 	if (!cesr)	/* no PMC is on (this test doesn't work on C6) */
 		return;
-	cache = &__get_cpu_var(per_cpu_cache);
+	cache = get_cpu_cache();
 	if (cache->k1.p5_cesr != cesr) {
 		cache->k1.p5_cesr = cesr;
 		wrmsr(MSR_P5_CESR, cesr, 0);
@@ -360,7 +362,7 @@
 
 	if (perfctr_cstatus_nractrs(state->cstatus) == 0) /* no PMC is on */
 		return;
-	cache = &__get_cpu_var(per_cpu_cache);
+	cache = get_cpu_cache();
 	cesr = state->k1.id;
 	if (cache->k1.p5_cesr != cesr) {
 		cache->k1.p5_cesr = cesr;
@@ -453,7 +455,7 @@
 
 	cpu = smp_processor_id();
 	set_isuspend_cpu(state, cpu); /* early to limit cpu's live range */
-	cache = &per_cpu(per_cpu_cache, cpu);
+	cache = __get_cpu_cache(cpu);
 	cstatus = state->cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
@@ -484,7 +486,7 @@
 	int cpu;
 
 	cpu = smp_processor_id();
-	cache = &per_cpu(per_cpu_cache, cpu);
+	cache = __get_cpu_cache(cpu);
 	if (cache->k1.id == state->k1.id) {
 		cache->k1.id = 0; /* force reload of cleared EVNTSELs */
 		if (is_isuspend_cpu(state, cpu))
@@ -527,7 +529,7 @@
 	struct per_cpu_cache *cache;
 	unsigned int nrctrs, i;
 
-	cache = &__get_cpu_var(per_cpu_cache);
+	cache = get_cpu_cache();
 	if (cache->k1.id == state->k1.id)
 		return;
 	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
@@ -826,7 +828,7 @@
 	struct per_cpu_cache *cache;
 	unsigned int nrctrs, i;
 
-	cache = &__get_cpu_var(per_cpu_cache);
+	cache = get_cpu_cache();
 	if (cache->k1.id == state->k1.id)
 		return;
 	nrctrs = perfctr_cstatus_nrctrs(state->cstatus);
@@ -960,7 +962,7 @@
 #ifdef CONFIG_SMP
 	clear_isuspend_cpu(state);
 #else
-	__get_cpu_var(per_cpu_cache).k1.id = 0;
+	get_cpu_cache()->k1.id = 0;
 #endif
 }
 
@@ -1137,7 +1139,7 @@
 	old_mask = perfctr_cpus_forbidden_mask;
 	clear_perfctr_cpus_forbidden_mask();
 
-	cache = &__get_cpu_var(per_cpu_cache);
+	cache = get_cpu_cache();
 	memset(cache, 0, sizeof *cache);
 	memset(&state, 0, sizeof state);
 	state.cstatus =
@@ -1424,8 +1426,7 @@
 	 * All-bits-one works for all currently supported processors.
 	 * The memset also sets the ids to -1, which is intentional.
 	 */
-	memset(&__get_cpu_var(per_cpu_cache), ~0,
-	       sizeof(struct per_cpu_cache));
+	memset(get_cpu_cache(), ~0, sizeof(struct per_cpu_cache));
 }
 
 static void perfctr_cpu_init_one(void *ignore)
diff -ruN linux-2.6.8-rc3-mm2/drivers/perfctr/x86_tests.c linux-2.6.8-rc3-mm2.perfctr-x86-updates/drivers/perfctr/x86_tests.c
--- linux-2.6.8-rc3-mm2/drivers/perfctr/x86_tests.c	2004-08-09 01:16:38.000000000 +0200
+++ linux-2.6.8-rc3-mm2.perfctr-x86-updates/drivers/perfctr/x86_tests.c	2004-08-09 10:57:36.000000000 +0200
@@ -1,4 +1,4 @@
-/* $Id: x86_tests.c,v 1.31 2004/07/26 12:02:32 mikpe Exp $
+/* $Id: x86_tests.c,v 1.34 2004/08/08 19:54:40 mikpe Exp $
  * Performance-monitoring counters driver.
  * Optional x86/x86_64-specific init-time tests.
  *
@@ -252,13 +252,13 @@
 {
 	measure_overheads(MSR_P6_EVNTSEL0+1, VC3_EVNTSEL1_VAL, MSR_P6_PERFCTR0+1, 0, 0);
 }
+#endif /* !__x86_64__ */
 
 static inline void perfctr_p4_init_tests(void)
 {
 	measure_overheads(MSR_P4_CRU_ESCR0, P4_CRU_ESCR0_VAL, MSR_P4_IQ_COUNTER0,
 			  MSR_P4_IQ_CCCR0, P4_IQ_CCCR0_VAL);
 }
-#endif /* !__x86_64__ */
 
 static inline void perfctr_k7_init_tests(void)
 {
@@ -290,10 +290,10 @@
 	case PTT_VC3: /* VIA C3 */
 		perfctr_vc3_init_tests();
 		break;
+#endif /* !__x86_64__ */
 	case PTT_P4: /* Intel P4 */
 		perfctr_p4_init_tests();
 		break;
-#endif /* !__x86_64__ */
 	case PTT_AMD: /* AMD K7, K8 */
 		perfctr_k7_init_tests();
 		break;
