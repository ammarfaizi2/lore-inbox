Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262460AbVCLXY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262460AbVCLXY1 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262462AbVCLXXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:23:13 -0500
Received: from aun.it.uu.se ([130.238.12.36]:58313 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262388AbVCLXUu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:20:50 -0500
Date: Sun, 13 Mar 2005 00:20:29 +0100 (MET)
Message-Id: <200503122320.j2CNKTDc028945@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 4/9: cpu_control_header, ppc32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Move tsc_on/nractrs/nrictrs control fields to new struct cpu_control_header.

This depends on the physical-indexing patch for ppc32.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 drivers/perfctr/ppc.c     |   18 +++++++++---------
 include/asm-ppc/perfctr.h |    6 +++++-
 2 files changed, 14 insertions(+), 10 deletions(-)

diff -rupN linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/ppc.c linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/ppc.c
--- linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/ppc.c	2005-03-12 19:58:42.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/ppc.c	2005-03-12 19:58:15.000000000 +0100
@@ -285,8 +285,8 @@ static int ppc_check_control(struct perf
 	unsigned int nr_pmcs, evntsel[6];
 
 	nr_pmcs = get_nr_pmcs();
-	nractrs = state->control.nractrs;
-	nrctrs = nractrs + state->control.nrictrs;
+	nractrs = state->control.header.nractrs;
+	nrctrs = nractrs + state->control.header.nrictrs;
 	if (nrctrs < nractrs || nrctrs > nr_pmcs)
 		return -EINVAL;
 
@@ -340,7 +340,7 @@ static int ppc_check_control(struct perf
 
 	/* We do not yet handle TBEE as the only exception cause,
 	   so PMXE requires at least one interrupt-mode counter. */
-	if ((state->control.mmcr0 & MMCR0_PMXE) && !state->control.nrictrs)
+	if ((state->control.mmcr0 & MMCR0_PMXE) && !state->control.header.nrictrs)
 		return -EINVAL;
 
 	state->k1.id = new_id();
@@ -577,8 +577,8 @@ static inline int check_ireset(const str
 {
 	unsigned int nrctrs, i;
 
-	i = state->control.nractrs;
-	nrctrs = i + state->control.nrictrs;
+	i = state->control.header.nractrs;
+	nrctrs = i + state->control.header.nrictrs;
 	for(; i < nrctrs; ++i) {
 		unsigned int pmc = state->pmc[i].map;
 		if ((int)state->control.ireset[pmc] < 0) /* PPC-specific */
@@ -620,7 +620,7 @@ int perfctr_cpu_update_control(struct pe
 
 	/* disallow i-mode counters if we cannot catch the interrupts */
 	if (!(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
-	    && state->control.nrictrs)
+	    && state->control.header.nrictrs)
 		return -EPERM;
 
 	err = check_control(state); /* may initialise state->cstatus */
@@ -629,9 +629,9 @@ int perfctr_cpu_update_control(struct pe
 	err = check_ireset(state);
 	if (err < 0)
 		return err;
-	state->cstatus |= perfctr_mk_cstatus(state->control.tsc_on,
-					     state->control.nractrs,
-					     state->control.nrictrs);
+	state->cstatus |= perfctr_mk_cstatus(state->control.header.tsc_on,
+					     state->control.header.nractrs,
+					     state->control.header.nrictrs);
 	setup_imode_start_values(state);
 	return 0;
 }
diff -rupN linux-2.6.11-mm3.perfctr-physical-indexing/include/asm-ppc/perfctr.h linux-2.6.11-mm3.perfctr-cpu_control_header/include/asm-ppc/perfctr.h
--- linux-2.6.11-mm3.perfctr-physical-indexing/include/asm-ppc/perfctr.h	2005-03-12 19:58:42.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control_header/include/asm-ppc/perfctr.h	2005-03-12 19:58:15.000000000 +0100
@@ -19,10 +19,14 @@ struct perfctr_sum_ctrs {
 	unsigned long long pmc[8];
 };
 
-struct perfctr_cpu_control {
+struct perfctr_cpu_control_header {
 	unsigned int tsc_on;
 	unsigned int nractrs;		/* # of a-mode counters */
 	unsigned int nrictrs;		/* # of i-mode counters */
+};
+
+struct perfctr_cpu_control {
+	struct perfctr_cpu_control_header header;
 	unsigned int mmcr0;
 	unsigned int mmcr1;
 	unsigned int mmcr2;
