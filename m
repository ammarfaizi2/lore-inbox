Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261282AbVEZIbv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261282AbVEZIbv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 04:31:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261290AbVEZI3v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 04:29:51 -0400
Received: from aun.it.uu.se ([130.238.12.36]:21173 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261282AbVEZI2n (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 04:28:43 -0400
Date: Thu, 26 May 2005 10:28:32 +0200 (MEST)
Message-Id: <200505260828.j4Q8SWdo011661@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc5-mm1 4/4] perfctr: seqlocks for mmap:ed state: ppc32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr seqlocks 4/4: ppc32 changes
- use write_perfseq_begin/end in perfctr_cpu_suspend/resume/sample
  to indicate that the state has changed
- in mmap:ed state, redefine samplecnt field as the sequence number

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c     |    8 ++++++--
 include/asm-ppc/perfctr.h |   10 ++++------
 2 files changed, 10 insertions(+), 8 deletions(-)

diff -rupN linux-2.6.12-rc5-mm1/drivers/perfctr/ppc.c linux-2.6.12-rc5-mm1.perfctr-seqlock-ppc32/drivers/perfctr/ppc.c
--- linux-2.6.12-rc5-mm1/drivers/perfctr/ppc.c	2005-05-26 00:24:22.000000000 +0200
+++ linux-2.6.12-rc5-mm1.perfctr-seqlock-ppc32/drivers/perfctr/ppc.c	2005-05-26 03:04:56.000000000 +0200
@@ -697,6 +697,7 @@ void perfctr_cpu_suspend(struct perfctr_
 	unsigned int i, cstatus, nractrs;
 	struct perfctr_low_ctrs now;
 
+	write_perfseq_begin(&state->user.sequence);
 	if (perfctr_cstatus_has_mmcr0_quirk(state->user.cstatus)) {
 		unsigned int mmcr0 = mfspr(SPRN_MMCR0);
 		mtspr(SPRN_MMCR0, mmcr0 | MMCR0_FC);
@@ -712,10 +713,12 @@ void perfctr_cpu_suspend(struct perfctr_
 	nractrs = perfctr_cstatus_nractrs(cstatus);
 	for(i = 0; i < nractrs; ++i)
 		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
+	write_perfseq_end(&state->user.sequence);
 }
 
 void perfctr_cpu_resume(struct perfctr_cpu_state *state)
 {
+	write_perfseq_begin(&state->user.sequence);
 	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
 	    perfctr_cpu_iresume(state);
 	if (perfctr_cstatus_has_mmcr0_quirk(state->user.cstatus))
@@ -733,7 +736,7 @@ void perfctr_cpu_resume(struct perfctr_c
 		for(i = 0; i < nrctrs; ++i)
 			state->user.pmc[i].start = now.pmc[i];
 	}
-	++state->user.samplecnt;
+	write_perfseq_end(&state->user.sequence);
 }
 
 void perfctr_cpu_sample(struct perfctr_cpu_state *state)
@@ -741,6 +744,7 @@ void perfctr_cpu_sample(struct perfctr_c
 	unsigned int i, cstatus, nractrs;
 	struct perfctr_low_ctrs now;
 
+	write_perfseq_begin(&state->user.sequence);
 	perfctr_cpu_read_counters(state, &now);
 	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus)) {
@@ -752,7 +756,7 @@ void perfctr_cpu_sample(struct perfctr_c
 		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
 		state->user.pmc[i].start = now.pmc[i];
 	}
-	++state->user.samplecnt;
+	write_perfseq_end(&state->user.sequence);
 }
 
 static void perfctr_cpu_clear_counters(void)
diff -rupN linux-2.6.12-rc5-mm1/include/asm-ppc/perfctr.h linux-2.6.12-rc5-mm1.perfctr-seqlock-ppc32/include/asm-ppc/perfctr.h
--- linux-2.6.12-rc5-mm1/include/asm-ppc/perfctr.h	2005-05-26 00:24:31.000000000 +0200
+++ linux-2.6.12-rc5-mm1.perfctr-seqlock-ppc32/include/asm-ppc/perfctr.h	2005-05-26 03:04:56.000000000 +0200
@@ -21,12 +21,10 @@ struct perfctr_cpu_control_header {
 
 struct perfctr_cpu_state_user {
 	__u32 cstatus;
-	/* 'samplecnt' is incremented every time the 'start'
-	   fields have been updated by a sampling operation.
-	   Unfortunately the PPC timebase (tsc_start) has too
-	   low frequency for it to be a reliable context-switch
-	   indicator for user-space. */
-	__u32 samplecnt;
+	/* This is a sequence counter to ensure atomic reads by
+	 * userspace.  The mechanism is identical to that used for
+	 * seqcount_t in include/linux/seqlock.h. */
+	__u32 sequence;
 	__u64 tsc_start;
 	__u64 tsc_sum;
 	struct {
