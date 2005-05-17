Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261942AbVEQUqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261942AbVEQUqg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEQUqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:46:36 -0400
Received: from aun.it.uu.se ([130.238.12.36]:32212 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261942AbVEQUpV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:45:21 -0400
Date: Tue, 17 May 2005 22:45:10 +0200 (MEST)
Message-Id: <200505172045.j4HKjA0X026784@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc4-mm2] perfctr: ppc64 wraparound fixes
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here's an update for perfctr's ppc64 low-level driver
which fixes counter wraparound issues in the driver.

This patch was written by David Gibson; here's his description:

"Problem was that with the conversion of the perfctr state
"start" values from 32 to 64 bits, my typing/sign-extension was no
longer correct, leading to overflows if the hardware counter rolled
over during a run.  With this patch the PAPI testcase failures appear
to be back down to the two that we know about."

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc64.c |   28 ++++++++++++++--------------
 1 files changed, 14 insertions(+), 14 deletions(-)

diff -rupN linux-2.6.12-rc4-mm2/drivers/perfctr/ppc64.c linux-2.6.12-rc4-mm2.perfctr-ppc64-wrap-fix/drivers/perfctr/ppc64.c
--- linux-2.6.12-rc4-mm2/drivers/perfctr/ppc64.c	2005-05-16 18:20:56.000000000 +0200
+++ linux-2.6.12-rc4-mm2.perfctr-ppc64-wrap-fix/drivers/perfctr/ppc64.c	2005-05-17 22:10:22.000000000 +0200
@@ -32,8 +32,8 @@ static DEFINE_PER_CPU(struct per_cpu_cac
 
 /* Structure for counter snapshots, as 32-bit values. */
 struct perfctr_low_ctrs {
-	unsigned int tsc;
-	unsigned int pmc[8];
+	u64 tsc;
+	u32 pmc[8];
 };
 
 static unsigned int new_id(void)
@@ -48,7 +48,7 @@ static unsigned int new_id(void)
 	return id;
 }
 
-static inline unsigned int read_pmc(unsigned int pmc)
+static inline u32 read_pmc(int pmc)
 {
 	switch (pmc) {
 	case 0:
@@ -81,7 +81,7 @@ static inline unsigned int read_pmc(unsi
 	}
 }
 
-static inline void write_pmc(int pmc, s32 val)
+static inline void write_pmc(int pmc, u32 val)
 {
 	switch (pmc) {
 	case 0:
@@ -241,7 +241,7 @@ static void perfctr_cpu_read_counters(st
 
 	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus))
-		ctrs->tsc = mftb() & 0xffffffff;
+		ctrs->tsc = mftb();
 
 	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i) {
 		pmc = state->control.pmc_map[i];
@@ -260,10 +260,10 @@ static void perfctr_cpu_isuspend(struct 
 	cstatus = state->user.cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for (i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
-		unsigned int pmc = state->control.pmc_map[i];
-		unsigned int now = read_pmc(pmc);
+		int pmc = state->control.pmc_map[i];
+		u32 now = read_pmc(pmc);
 
-		state->user.pmc[i].sum += now - state->user.pmc[i].start;
+		state->user.pmc[i].sum += (u32)(now-state->user.pmc[i].start);
 		state->user.pmc[i].start = now;
 	}
 }
@@ -335,18 +335,18 @@ unsigned int perfctr_cpu_identify_overfl
 	 * about. */
 	for (i = 0; i < nractrs; ++i) {
 		int pmc = state->control.pmc_map[i];
-		unsigned int val = read_pmc(pmc);
+		u32 val = read_pmc(pmc);
 
 		/* For actrs, force a sample if they overflowed */
 
-		if ((int)val < 0) {
-			state->user.pmc[i].sum += val - state->user.pmc[i].start;
+		if ((s32)val < 0) {
+			state->user.pmc[i].sum += (u32)(val - state->user.pmc[i].start);
 			state->user.pmc[i].start = 0;
 			write_pmc(pmc, 0);
 		}
 	}
 	for (; i < nrctrs; ++i) {
-		if ((int)state->user.pmc[i].start < 0) { /* PPC64-specific */
+		if ((s32)state->user.pmc[i].start < 0) { /* PPC64-specific */
 			int pmc = state->control.pmc_map[i];
 			/* XXX: "+=" to correct for overshots */
 			state->user.pmc[i].start = state->control.ireset[pmc];
@@ -550,7 +550,7 @@ void perfctr_cpu_suspend(struct perfctr_
 		state->user.tsc_sum += now.tsc - state->user.tsc_start;
 
 	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i)
-		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
+		state->user.pmc[i].sum += (u32)(now.pmc[i]-state->user.pmc[i].start);
 }
 
 void perfctr_cpu_resume(struct perfctr_cpu_state *state)
@@ -586,7 +586,7 @@ void perfctr_cpu_sample(struct perfctr_c
 	}
 	nractrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nractrs; ++i) {
-		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
+		state->user.pmc[i].sum += (u32)(now.pmc[i]-state->user.pmc[i].start);
 		state->user.pmc[i].start = now.pmc[i];
 	}
 	++state->user.samplecnt;
