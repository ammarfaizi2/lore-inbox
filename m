Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVEZIc3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVEZIc3 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 04:32:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261278AbVEZI33
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 04:29:29 -0400
Received: from aun.it.uu.se ([130.238.12.36]:61364 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261279AbVEZI2K (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 04:28:10 -0400
Date: Thu, 26 May 2005 10:27:58 +0200 (MEST)
Message-Id: <200505260827.j4Q8Rw0G011653@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc5-mm1 3/4] perfctr: seqlocks for mmap:ed state: ppc64
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr seqlocks 3/4: ppc64 changes
- use write_perfseq_begin/end in perfctr_cpu_suspend/resume/sample
  to indicate that the state has changed
- in mmap:ed state, redefine samplecnt field as the sequence number

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc64.c     |   10 ++++++++--
 include/asm-ppc64/perfctr.h |   10 ++++------
 2 files changed, 12 insertions(+), 8 deletions(-)

diff -rupN linux-2.6.12-rc5-mm1/drivers/perfctr/ppc64.c linux-2.6.12-rc5-mm1.perfctr-seqlock-ppc64/drivers/perfctr/ppc64.c
--- linux-2.6.12-rc5-mm1/drivers/perfctr/ppc64.c	2005-05-26 00:24:22.000000000 +0200
+++ linux-2.6.12-rc5-mm1.perfctr-seqlock-ppc64/drivers/perfctr/ppc64.c	2005-05-26 03:01:37.000000000 +0200
@@ -537,6 +537,8 @@ void perfctr_cpu_suspend(struct perfctr_
 	unsigned int i, cstatus;
 	struct perfctr_low_ctrs now;
 
+	write_perfseq_begin(&state->user.sequence);
+
 	/* quiesce the counters */
 	mtspr(SPRN_MMCR0, MMCR0_FC);
 	get_cpu_cache()->ppc64_mmcr0 = MMCR0_FC;
@@ -551,6 +553,8 @@ void perfctr_cpu_suspend(struct perfctr_
 
 	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i)
 		state->user.pmc[i].sum += (u32)(now.pmc[i]-state->user.pmc[i].start);
+
+	write_perfseq_end(&state->user.sequence);
 }
 
 void perfctr_cpu_resume(struct perfctr_cpu_state *state)
@@ -558,6 +562,7 @@ void perfctr_cpu_resume(struct perfctr_c
 	struct perfctr_low_ctrs now;
 	unsigned int i, cstatus;
 
+	write_perfseq_begin(&state->user.sequence);
 	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
 	    perfctr_cpu_iresume(state);
 	perfctr_cpu_write_control(state);
@@ -570,7 +575,7 @@ void perfctr_cpu_resume(struct perfctr_c
 	for (i = 0; i < perfctr_cstatus_nractrs(cstatus); ++i)
 		state->user.pmc[i].start = now.pmc[i];
 
-	++state->user.samplecnt;
+	write_perfseq_end(&state->user.sequence);
 }
 
 void perfctr_cpu_sample(struct perfctr_cpu_state *state)
@@ -578,6 +583,7 @@ void perfctr_cpu_sample(struct perfctr_c
 	unsigned int i, cstatus, nractrs;
 	struct perfctr_low_ctrs now;
 
+	write_perfseq_begin(&state->user.sequence);
 	perfctr_cpu_read_counters(state, &now);
 	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus)) {
@@ -589,7 +595,7 @@ void perfctr_cpu_sample(struct perfctr_c
 		state->user.pmc[i].sum += (u32)(now.pmc[i]-state->user.pmc[i].start);
 		state->user.pmc[i].start = now.pmc[i];
 	}
-	++state->user.samplecnt;
+	write_perfseq_end(&state->user.sequence);
 }
 
 static void perfctr_cpu_clear_counters(void)
diff -rupN linux-2.6.12-rc5-mm1/include/asm-ppc64/perfctr.h linux-2.6.12-rc5-mm1.perfctr-seqlock-ppc64/include/asm-ppc64/perfctr.h
--- linux-2.6.12-rc5-mm1/include/asm-ppc64/perfctr.h	2005-05-26 00:24:23.000000000 +0200
+++ linux-2.6.12-rc5-mm1.perfctr-seqlock-ppc64/include/asm-ppc64/perfctr.h	2005-05-26 03:01:37.000000000 +0200
@@ -22,12 +22,10 @@ struct perfctr_cpu_control_header {
 
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
