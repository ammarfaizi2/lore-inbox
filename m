Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264795AbUIZXES@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264795AbUIZXES (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Sep 2004 19:04:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbUIZXEJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Sep 2004 19:04:09 -0400
Received: from aun.it.uu.se ([130.238.12.36]:19850 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264795AbUIZXD5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Sep 2004 19:03:57 -0400
Date: Mon, 27 Sep 2004 01:03:44 +0200 (MEST)
Message-Id: <200409262303.i8QN3i2r012248@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.9-rc2-mm3] perfctr ppc32 MMCR0 handling fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch is a cleanup and correction to perfctr's
PPC32 low-level driver. This is a prerequisite for the
next patch which enables performance monitor interrupts.

Details from my RELEASE-NOTES entry:
- PPC32: Correct MMCR0 handling for FCECE/TRIGGER. Read
  MMCR0 at suspend and then freeze the counters. Move
  this code from read_counters() to suspend(). At resume,
  reload MMCR0 to unfreeze the counters. Clean up the
  cstatus checks controlling this behaviour.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff -ruN linux-2.6.9-rc2.perfctr27-vanilla/drivers/perfctr/ppc.c linux-2.6.9-rc2.perfctr27-ppc-mmcr0/drivers/perfctr/ppc.c
--- linux-2.6.9-rc2.perfctr27-vanilla/drivers/perfctr/ppc.c	2004-07-02 20:55:16.000000000 +0200
+++ linux-2.6.9-rc2.perfctr27-ppc-mmcr0/drivers/perfctr/ppc.c	2004-09-26 23:20:32.000000000 +0200
@@ -106,6 +106,18 @@
 static inline void clear_isuspend_cpu(struct perfctr_cpu_state *state) { }
 #endif
 
+/* The ppc driver internally uses cstatus & (1<<30) to record that
+   a context has an asynchronously changing MMCR0. */
+static inline unsigned int perfctr_cstatus_set_mmcr0_quirk(unsigned int cstatus)
+{
+	return cstatus | (1 << 30);
+}
+
+static inline int perfctr_cstatus_has_mmcr0_quirk(unsigned int cstatus)
+{
+	return cstatus & (1 << 30);
+}
+
 /****************************************************************
  *								*
  * Driver procedures.						*
@@ -228,7 +240,7 @@
 	}
 }
 
-static void ppc_read_counters(/*const*/ struct perfctr_cpu_state *state,
+static void ppc_read_counters(struct perfctr_cpu_state *state,
 			      struct perfctr_low_ctrs *ctrs)
 {
 	unsigned int cstatus, nrctrs, i;
@@ -241,12 +253,6 @@
 		unsigned int pmc = state->pmc[i].map;
 		ctrs->pmc[i] = read_pmc(pmc);
 	}
-	/* handle MMCR0 changes due to FCECE or TRIGGER on 74xx */
-	if (state->cstatus & (1<<30)) {
-		unsigned int mmcr0 = mfspr(SPRN_MMCR0);
-		state->ppc_mmcr[0] = mmcr0;
-		get_cpu_cache()->ppc_mmcr[0] = mmcr0;
-	}
 }
 
 static unsigned int pmc_max_event(unsigned int pmc)
@@ -336,14 +342,15 @@
 
 	/*
 	 * MMCR0[FC] and MMCR0[TRIGGER] may change on 74xx if FCECE or
-	 * TRIGGER is set. To avoid undoing those changes, we must read
-	 * MMCR0 back into state->ppc_mmcr[0] and the cache at suspends.
+	 * TRIGGER is set. At suspends we must read MMCR0 back into
+	 * the state and the cache and then freeze the counters, and
+	 * at resumes we must unfreeze the counters and reload MMCR0.
 	 */
 	switch (pm_type) {
 	case PM_7450:
 	case PM_7400:
 		if (state->ppc_mmcr[0] & (MMCR0_FCECE | MMCR0_TRIGGER))
-			state->cstatus |= (1<<30);
+			state->cstatus = perfctr_cstatus_set_mmcr0_quirk(state->cstatus);
 	default:
 		;
 	}
@@ -443,7 +450,7 @@
 	return ppc_write_control(state);
 }
 
-static void perfctr_cpu_read_counters(/*const*/ struct perfctr_cpu_state *state,
+static void perfctr_cpu_read_counters(struct perfctr_cpu_state *state,
 				      struct perfctr_low_ctrs *ctrs)
 {
 	return ppc_read_counters(state, ctrs);
@@ -557,6 +564,12 @@
 	unsigned int i, cstatus, nractrs;
 	struct perfctr_low_ctrs now;
 
+	if (perfctr_cstatus_has_mmcr0_quirk(state->cstatus)) {
+		unsigned int mmcr0 = mfspr(SPRN_MMCR0);
+		mtspr(SPRN_MMCR0, mmcr0 | MMCR0_FC);
+		get_cpu_cache()->ppc_mmcr[0] = mmcr0 | MMCR0_FC;
+		state->ppc_mmcr[0] = mmcr0;
+	}
 	if (perfctr_cstatus_has_ictrs(state->cstatus))
 		perfctr_cpu_isuspend(state);
 	perfctr_cpu_read_counters(state, &now);
@@ -572,6 +585,8 @@
 {
 	if (perfctr_cstatus_has_ictrs(state->cstatus))
 	    perfctr_cpu_iresume(state);
+	if (perfctr_cstatus_has_mmcr0_quirk(state->cstatus))
+		get_cpu_cache()->k1.id = 0; /* force reload of MMCR0 */
 	perfctr_cpu_write_control(state);
 	//perfctr_cpu_read_counters(state, &state->start);
 	{
