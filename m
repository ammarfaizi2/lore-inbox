Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262504AbVCLXYW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262504AbVCLXYW (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Mar 2005 18:24:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262460AbVCLXWt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Mar 2005 18:22:49 -0500
Received: from aun.it.uu.se ([130.238.12.36]:50121 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262244AbVCLXTy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Mar 2005 18:19:54 -0500
Date: Sun, 13 Mar 2005 00:19:45 +0100 (MET)
Message-Id: <200503122319.j2CNJjCM028889@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm3] perfctr API update 3/9: cpu_control_header, x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Move tsc_on/nractrs/nrictrs control fields to new struct cpu_control_header.

This depends on the physical-indexing patch for x86.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

/Mikael

 drivers/perfctr/x86.c      |   32 ++++++++++++++++----------------
 include/asm-i386/perfctr.h |    6 +++++-
 2 files changed, 21 insertions(+), 17 deletions(-)

diff -rupN linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/x86.c linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/x86.c
--- linux-2.6.11-mm3.perfctr-physical-indexing/drivers/perfctr/x86.c	2005-03-12 19:58:42.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control_header/drivers/perfctr/x86.c	2005-03-12 19:58:15.000000000 +0100
@@ -239,11 +239,11 @@ static int p5_like_check_control(struct 
 	unsigned short cesr_half[2];
 	unsigned int pmc, evntsel, i;
 
-	if (state->control.nrictrs != 0 || state->control.nractrs > 2)
+	if (state->control.header.nrictrs != 0 || state->control.header.nractrs > 2)
 		return -EINVAL;
 	cesr_half[0] = 0;
 	cesr_half[1] = 0;
-	for(i = 0; i < state->control.nractrs; ++i) {
+	for(i = 0; i < state->control.header.nractrs; ++i) {
 		pmc = state->control.pmc_map[i];
 		state->pmc[i].map = pmc;
 		if (pmc > 1 || cesr_half[pmc] != 0)
@@ -366,7 +366,7 @@ static int mii_check_control(struct perf
 #if !defined(CONFIG_X86_TSC)
 static int c6_check_control(struct perfctr_cpu_state *state, int is_global)
 {
-	if (state->control.tsc_on)
+	if (state->control.header.tsc_on)
 		return -EINVAL;
 	return p5_like_check_control(state, C6_CESR_RESERVED, 1);
 }
@@ -407,8 +407,8 @@ static int p6_like_check_control(struct 
 {
 	unsigned int evntsel, i, nractrs, nrctrs, pmc_mask, pmc;
 
-	nractrs = state->control.nractrs;
-	nrctrs = nractrs + state->control.nrictrs;
+	nractrs = state->control.header.nractrs;
+	nrctrs = nractrs + state->control.header.nrictrs;
 	if (nrctrs < nractrs || nrctrs > (is_k7 ? 4 : 2))
 		return -EINVAL;
 
@@ -637,9 +637,9 @@ static void k7_clear_counters(void)
  */
 static int vc3_check_control(struct perfctr_cpu_state *state, int is_global)
 {
-	if (state->control.nrictrs || state->control.nractrs > 1)
+	if (state->control.header.nrictrs || state->control.header.nractrs > 1)
 		return -EINVAL;
-	if (state->control.nractrs == 1) {
+	if (state->control.header.nractrs == 1) {
 		if (state->control.pmc_map[0] != 1)
 			return -EINVAL;
 		state->pmc[0].map = 1;
@@ -756,8 +756,8 @@ static int p4_check_control(struct perfc
 {
 	unsigned int i, nractrs, nrctrs, pmc_mask;
 
-	nractrs = state->control.nractrs;
-	nrctrs = nractrs + state->control.nrictrs;
+	nractrs = state->control.header.nractrs;
+	nrctrs = nractrs + state->control.header.nrictrs;
 	if (nrctrs < nractrs || nrctrs > 18)
 		return -EINVAL;
 
@@ -904,7 +904,7 @@ static void p4_clear_counters(void)
 
 static int generic_check_control(struct perfctr_cpu_state *state, int is_global)
 {
-	if (state->control.nractrs || state->control.nrictrs)
+	if (state->control.header.nractrs || state->control.header.nrictrs)
 		return -EINVAL;
 	return 0;
 }
@@ -1022,8 +1022,8 @@ static inline int check_ireset(const str
 {
 	unsigned int nrctrs, i;
 
-	i = state->control.nractrs;
-	nrctrs = i + state->control.nrictrs;
+	i = state->control.header.nractrs;
+	nrctrs = i + state->control.header.nrictrs;
 	for(; i < nrctrs; ++i) {
 		unsigned int pmc = state->pmc[i].map & P4_MASK_FAST_RDPMC;
 		if ((int)state->control.ireset[pmc] >= 0)
@@ -1061,7 +1061,7 @@ int perfctr_cpu_update_control(struct pe
 
 	/* disallow i-mode counters if we cannot catch the interrupts */
 	if (!(perfctr_info.cpu_features & PERFCTR_FEATURE_PCINT)
-	    && state->control.nrictrs)
+	    && state->control.header.nrictrs)
 		return -EPERM;
 
 	err = check_control(state, is_global);
@@ -1070,9 +1070,9 @@ int perfctr_cpu_update_control(struct pe
 	err = check_ireset(state);
 	if (err < 0)
 		return err;
-	state->cstatus = perfctr_mk_cstatus(state->control.tsc_on,
-					    state->control.nractrs,
-					    state->control.nrictrs);
+	state->cstatus = perfctr_mk_cstatus(state->control.header.tsc_on,
+					    state->control.header.nractrs,
+					    state->control.header.nrictrs);
 	setup_imode_start_values(state);
 	return 0;
 }
diff -rupN linux-2.6.11-mm3.perfctr-physical-indexing/include/asm-i386/perfctr.h linux-2.6.11-mm3.perfctr-cpu_control_header/include/asm-i386/perfctr.h
--- linux-2.6.11-mm3.perfctr-physical-indexing/include/asm-i386/perfctr.h	2005-03-12 19:58:42.000000000 +0100
+++ linux-2.6.11-mm3.perfctr-cpu_control_header/include/asm-i386/perfctr.h	2005-03-12 19:58:15.000000000 +0100
@@ -30,10 +30,14 @@ struct perfctr_sum_ctrs {
 	unsigned long long pmc[18];
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
 	unsigned int evntsel[18];	/* primary control registers, physical indices */
 	unsigned int ireset[18];	/* >= 2^31, for i-mode counters, physical indices */
 	struct {
