Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261341AbVDINPb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261341AbVDINPb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Apr 2005 09:15:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261344AbVDINOT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Apr 2005 09:14:19 -0400
Received: from aun.it.uu.se ([130.238.12.36]:39379 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261341AbVDINNB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Apr 2005 09:13:01 -0400
Date: Sat, 9 Apr 2005 15:12:48 +0200 (MEST)
Message-Id: <200504091312.j39DCmgY004265@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc2-mm2 3/3] perfctr: ppc64 ABI update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr ppc64 ABI update:
- <asm-ppc64/perfctr.h>: In user-visible state, make start fields
  64 bits (for future-proofing the ABI). Remove map field from
  pmc[] array to avoid underutilised cache lines.
- ppc64.c: retrieve mapping from ->control.pmc_map[].
- ppc64: Add sampling counter to user-visible state, and
  increment it in perfctr_cpu_resume() and perfctr_cpu_sample().

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc64.c     |   16 ++++++++--------
 include/asm-ppc64/perfctr.h |   13 ++++++++-----
 2 files changed, 16 insertions(+), 13 deletions(-)

diff -rupN linux-2.6.12-rc2-mm2/drivers/perfctr/ppc64.c linux-2.6.12-rc2-mm2.perfctr-ppc64-update/drivers/perfctr/ppc64.c
--- linux-2.6.12-rc2-mm2/drivers/perfctr/ppc64.c	2005-04-08 13:14:23.000000000 +0200
+++ linux-2.6.12-rc2-mm2.perfctr-ppc64-update/drivers/perfctr/ppc64.c	2005-04-09 14:04:32.000000000 +0200
@@ -244,7 +244,7 @@ static void perfctr_cpu_read_counters(st
 		ctrs->tsc = mftb() & 0xffffffff;
 
 	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i) {
-		pmc = state->user.pmc[i].map;
+		pmc = state->control.pmc_map[i];
 		ctrs->pmc[i] = read_pmc(pmc);
 	}
 }
@@ -260,7 +260,7 @@ static void perfctr_cpu_isuspend(struct 
 	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for (i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int pmc = state->control.pmc_map[i];
 		unsigned int now = read_pmc(pmc);
 
 		state->user.pmc[i].sum += now - state->user.pmc[i].start;
@@ -299,7 +299,7 @@ static void perfctr_cpu_iresume(const st
 	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for (i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
-		write_pmc(state->user.pmc[i].map, state->user.pmc[i].start);
+		write_pmc(state->control.pmc_map[i], state->user.pmc[i].start);
 	}
 }
 
@@ -334,7 +334,7 @@ unsigned int perfctr_cpu_identify_overfl
 	 * amd unused PMCs as well as the ones we actually care
 	 * about. */
 	for (i = 0; i < nractrs; ++i) {
-		int pmc = state->user.pmc[i].map;
+		int pmc = state->control.pmc_map[i];
 		unsigned int val = read_pmc(pmc);
 
 		/* For actrs, force a sample if they overflowed */
@@ -347,7 +347,7 @@ unsigned int perfctr_cpu_identify_overfl
 	}
 	for (; i < nrctrs; ++i) {
 		if ((int)state->user.pmc[i].start < 0) { /* PPC64-specific */
-			int pmc = state->user.pmc[i].map;
+			int pmc = state->control.pmc_map[i];
 			/* XXX: "+=" to correct for overshots */
 			state->user.pmc[i].start = state->control.ireset[pmc];
 			pmc_mask |= (1 << i);
@@ -376,7 +376,7 @@ static inline int check_ireset(struct pe
 	i = state->control.header.nractrs;
 	nrctrs = i + state->control.header.nrictrs;
 	for(; i < nrctrs; ++i) {
-		unsigned int pmc = state->user.pmc[i].map;
+		unsigned int pmc = state->control.pmc_map[i];
 		if ((int)state->control.ireset[pmc] < 0) /* PPC64-specific */
 			return -EINVAL;
 		state->user.pmc[i].start = state->control.ireset[pmc];
@@ -406,7 +406,6 @@ static int check_control(struct perfctr_
 	pmc_mask = 0;
 	for (i = 0; i < nrctrs; ++i) {
 		pmc = state->control.pmc_map[i];
-		state->user.pmc[i].map = pmc;
 		if (pmc >= nr_pmcs || (pmc_mask & (1<<pmc)))
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
@@ -571,7 +570,7 @@ void perfctr_cpu_resume(struct perfctr_c
 	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i)
 		state->user.pmc[i].start = now.pmc[i];
 
-	/* XXX: if (SMP && start.tsc == now.tsc) ++now.tsc; */
+	++state->user.samplecnt;
 }
 
 void perfctr_cpu_sample(struct perfctr_cpu_state *state)
@@ -590,6 +589,7 @@ void perfctr_cpu_sample(struct perfctr_c
 		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
 		state->user.pmc[i].start = now.pmc[i];
 	}
+	++state->user.samplecnt;
 }
 
 static void perfctr_cpu_clear_counters(void)
diff -rupN linux-2.6.12-rc2-mm2/include/asm-ppc64/perfctr.h linux-2.6.12-rc2-mm2.perfctr-ppc64-update/include/asm-ppc64/perfctr.h
--- linux-2.6.12-rc2-mm2/include/asm-ppc64/perfctr.h	2005-04-08 13:14:24.000000000 +0200
+++ linux-2.6.12-rc2-mm2.perfctr-ppc64-update/include/asm-ppc64/perfctr.h	2005-04-09 14:04:32.000000000 +0200
@@ -22,13 +22,16 @@ struct perfctr_cpu_control_header {
 
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
