Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262735AbVCWC7i@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262735AbVCWC7i (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:59:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262740AbVCWC7i
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:59:38 -0500
Received: from aun.it.uu.se ([130.238.12.36]:29944 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262735AbVCWC7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:59:24 -0500
Date: Wed, 23 Mar 2005 03:59:18 +0100 (MET)
Message-Id: <200503230259.j2N2xI6J023621@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm1 2/3] perfctr: ppc32 fix and cleanups
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc32 fix and cleanups:
- If check_ireset() fails, clear state->cstatus to undo any
  settings check_control() may have left there.
- Eliminate power-of-two sizeof assumption in access_regs().
- Merge check_ireset() and setup_imode_start_values().

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c |   27 ++++++++-------------------
 1 files changed, 8 insertions(+), 19 deletions(-)

diff -rupN linux-2.6.12-rc1-mm1/drivers/perfctr/ppc.c linux-2.6.12-rc1-mm1.perfctr-update-ppc/drivers/perfctr/ppc.c
--- linux-2.6.12-rc1-mm1/drivers/perfctr/ppc.c	2005-03-22 21:59:08.000000000 +0100
+++ linux-2.6.12-rc1-mm1.perfctr-update-ppc/drivers/perfctr/ppc.c	2005-03-23 02:16:26.000000000 +0100
@@ -573,7 +573,7 @@ unsigned int perfctr_cpu_identify_overfl
 	return pmc_mask;
 }
 
-static inline int check_ireset(const struct perfctr_cpu_state *state)
+static inline int check_ireset(struct perfctr_cpu_state *state)
 {
 	unsigned int nrctrs, i;
 
@@ -583,27 +583,15 @@ static inline int check_ireset(const str
 		unsigned int pmc = state->pmc[i].map;
 		if ((int)state->control.ireset[pmc] < 0) /* PPC-specific */
 			return -EINVAL;
-	}
-	return 0;
-}
-
-static inline void setup_imode_start_values(struct perfctr_cpu_state *state)
-{
-	unsigned int cstatus, nrctrs, i;
-
-	cstatus = state->cstatus;
-	nrctrs = perfctr_cstatus_nrctrs(cstatus);
-	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
-		unsigned int pmc = state->pmc[i].map;
 		state->pmc[i].start = state->control.ireset[pmc];
 	}
+	return 0;
 }
 
 #else	/* CONFIG_PERFCTR_INTERRUPT_SUPPORT */
 static inline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state) { }
 static inline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state) { }
-static inline int check_ireset(const struct perfctr_cpu_state *state) { return 0; }
-static inline void setup_imode_start_values(struct perfctr_cpu_state *state) { }
+static inline int check_ireset(struct perfctr_cpu_state *state) { return 0; }
 #endif	/* CONFIG_PERFCTR_INTERRUPT_SUPPORT */
 
 static int check_control(struct perfctr_cpu_state *state)
@@ -627,12 +615,13 @@ int perfctr_cpu_update_control(struct pe
 	if (err < 0)
 		return err;
 	err = check_ireset(state);
-	if (err < 0)
+	if (err < 0) {
+		state->cstatus = 0;
 		return err;
+	}
 	state->cstatus |= perfctr_mk_cstatus(state->control.header.tsc_on,
 					     state->control.header.nractrs,
 					     state->control.header.nrictrs);
-	setup_imode_start_values(state);
 	return 0;
 }
 
@@ -672,10 +661,10 @@ static int access_regs(struct perfctr_cp
 	unsigned int i, nr_regs, *where;
 	int offset;
 
-	if (argbytes & (sizeof(struct perfctr_cpu_reg) - 1))
+	nr_regs = argbytes / sizeof(struct perfctr_cpu_reg);
+	if (nr_regs * sizeof(struct perfctr_cpu_reg) != argbytes)
 		return -EINVAL;
 	regs = (struct perfctr_cpu_reg*)argp;
-	nr_regs = argbytes / sizeof(struct perfctr_cpu_reg);
 
 	for(i = 0; i < nr_regs; ++i) {
 		offset = get_reg_offset(regs[i].nr);
