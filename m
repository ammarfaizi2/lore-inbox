Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262613AbVCWC6z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262613AbVCWC6z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Mar 2005 21:58:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262735AbVCWC6z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Mar 2005 21:58:55 -0500
Received: from aun.it.uu.se ([130.238.12.36]:65527 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262613AbVCWC6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Mar 2005 21:58:50 -0500
Date: Wed, 23 Mar 2005 03:58:38 +0100 (MET)
Message-Id: <200503230258.j2N2wcwe023559@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc1-mm1 1/3] perfctr: x86 fix and cleanups
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some small fixes and cleanups. The ppc64 code should be next,
but I'm waiting for David Gibson to look over and ACK the API
changes I've inflicted on his code first.

x86 fix and cleanups:
- finalise_backpatching() now exercises all control flow paths,
  to ensure that calls in cloned control flows are backpatched properly.
  This is needed for gcc-4.0.
- Eliminate power-of-two sizeof assumption in access_regs().
- Merge check_ireset() and setup_imode_start_values().

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c |   34 ++++++++++++----------------------
 1 files changed, 12 insertions(+), 22 deletions(-)

diff -rupN linux-2.6.12-rc1-mm1/drivers/perfctr/x86.c linux-2.6.12-rc1-mm1.perfctr-update-x86/drivers/perfctr/x86.c
--- linux-2.6.12-rc1-mm1/drivers/perfctr/x86.c	2005-03-22 21:59:08.000000000 +0100
+++ linux-2.6.12-rc1-mm1.perfctr-update-x86/drivers/perfctr/x86.c	2005-03-23 02:18:14.000000000 +0100
@@ -1018,7 +1018,7 @@ unsigned int perfctr_cpu_identify_overfl
 	return pmc_mask;
 }
 
-static inline int check_ireset(const struct perfctr_cpu_state *state)
+static inline int check_ireset(struct perfctr_cpu_state *state)
 {
 	unsigned int nrctrs, i;
 
@@ -1028,27 +1028,15 @@ static inline int check_ireset(const str
 		unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
 		if ((int)state->control.ireset[pmc] >= 0)
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
-		unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
 		state->pmc[i].start = state->control.ireset[pmc];
 	}
+	return 0;
 }
 
 #else	/* CONFIG_X86_LOCAL_APIC */
 static inline void perfctr_cpu_isuspend(struct perfctr_cpu_state *state) { }
 static inline void perfctr_cpu_iresume(const struct perfctr_cpu_state *state) { }
-static inline int check_ireset(const struct perfctr_cpu_state *state) { return 0; }
-static inline void setup_imode_start_values(struct perfctr_cpu_state *state) { }
+static inline int check_ireset(struct perfctr_cpu_state *state) { return 0; }
 #endif	/* CONFIG_X86_LOCAL_APIC */
 
 static int (*check_control)(struct perfctr_cpu_state*, int);
@@ -1073,7 +1061,6 @@ int perfctr_cpu_update_control(struct pe
 	state->cstatus = perfctr_mk_cstatus(state->control.header.tsc_on,
 					    state->control.header.nractrs,
 					    state->control.header.nrictrs);
-	setup_imode_start_values(state);
 	return 0;
 }
 
@@ -1135,10 +1122,10 @@ static int access_regs(struct perfctr_cp
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
@@ -1264,10 +1251,13 @@ static void __init finalise_backpatching
 	cache = get_cpu_cache();
 	memset(cache, 0, sizeof *cache);
 	memset(&state, 0, sizeof state);
-	state.cstatus =
-		(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
-		? __perfctr_mk_cstatus(0, 1, 0, 0)
-		: 0;
+	if (perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT) {
+		state.cstatus = __perfctr_mk_cstatus(0, 1, 0, 0);
+		perfctr_cpu_sample(&state);
+		perfctr_cpu_resume(&state);
+		perfctr_cpu_suspend(&state);
+	}
+	state.cstatus = 0;
 	perfctr_cpu_sample(&state);
 	perfctr_cpu_resume(&state);
 	perfctr_cpu_suspend(&state);
