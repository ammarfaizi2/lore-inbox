Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261284AbVEZI2t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261284AbVEZI2t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 04:28:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261286AbVEZI2s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 04:28:48 -0400
Received: from aun.it.uu.se ([130.238.12.36]:39604 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261278AbVEZI1i (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 04:27:38 -0400
Date: Thu, 26 May 2005 10:27:25 +0200 (MEST)
Message-Id: <200505260827.j4Q8RPDB011645@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc5-mm1 2/4] perfctr: seqlocks for mmap:ed state: x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

perfctr seqlocks 2/4: x86 changes
- use write_perfseq_begin/end in perfctr_cpu_suspend/resume/sample
  to indicate that the state has changed
- in mmap:ed state, redefine filler field as the sequence number

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c      |    7 ++++++-
 include/asm-i386/perfctr.h |    5 ++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff -rupN linux-2.6.12-rc5-mm1/drivers/perfctr/x86.c linux-2.6.12-rc5-mm1.perfctr-seqlock-x86/drivers/perfctr/x86.c
--- linux-2.6.12-rc5-mm1/drivers/perfctr/x86.c	2005-05-26 00:24:22.000000000 +0200
+++ linux-2.6.12-rc5-mm1.perfctr-seqlock-x86/drivers/perfctr/x86.c	2005-05-26 02:57:55.000000000 +0200
@@ -1162,6 +1162,7 @@ void perfctr_cpu_suspend(struct perfctr_
 	unsigned int i, cstatus, nractrs;
 	struct perfctr_low_ctrs now;
 
+	write_perfseq_begin(&state->user.sequence);
 	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
 	    perfctr_cpu_isuspend(state);
 	perfctr_cpu_read_counters(state, &now);
@@ -1172,10 +1173,12 @@ void perfctr_cpu_suspend(struct perfctr_
 	for(i = 0; i < nractrs; ++i)
 		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
 	/* perfctr_cpu_disable_rdpmc(); */	/* not for x86 */
+	write_perfseq_end(&state->user.sequence);
 }
 
 void perfctr_cpu_resume(struct perfctr_cpu_state *state)
 {
+	write_perfseq_begin(&state->user.sequence);
 	if (perfctr_cstatus_has_ictrs(state->user.cstatus))
 	    perfctr_cpu_iresume(state);
 	/* perfctr_cpu_enable_rdpmc(); */	/* not for x86 or global-mode */
@@ -1192,7 +1195,7 @@ void perfctr_cpu_resume(struct perfctr_c
 		for(i = 0; i < nrctrs; ++i)
 			state->user.pmc[i].start = now.pmc[i];
 	}
-	/* XXX: if (SMP && start.tsc == now.tsc) ++now.tsc; */
+	write_perfseq_end(&state->user.sequence);
 }
 
 void perfctr_cpu_sample(struct perfctr_cpu_state *state)
@@ -1200,6 +1203,7 @@ void perfctr_cpu_sample(struct perfctr_c
 	unsigned int i, cstatus, nractrs;
 	struct perfctr_low_ctrs now;
 
+	write_perfseq_begin(&state->user.sequence);
 	perfctr_cpu_read_counters(state, &now);
 	cstatus = state->user.cstatus;
 	if (perfctr_cstatus_has_tsc(cstatus)) {
@@ -1211,6 +1215,7 @@ void perfctr_cpu_sample(struct perfctr_c
 		state->user.pmc[i].sum += now.pmc[i] - state->user.pmc[i].start;
 		state->user.pmc[i].start = now.pmc[i];
 	}
+	write_perfseq_end(&state->user.sequence);
 }
 
 static void (*clear_counters)(void);
diff -rupN linux-2.6.12-rc5-mm1/include/asm-i386/perfctr.h linux-2.6.12-rc5-mm1.perfctr-seqlock-x86/include/asm-i386/perfctr.h
--- linux-2.6.12-rc5-mm1/include/asm-i386/perfctr.h	2005-05-26 00:24:23.000000000 +0200
+++ linux-2.6.12-rc5-mm1.perfctr-seqlock-x86/include/asm-i386/perfctr.h	2005-05-26 02:57:55.000000000 +0200
@@ -21,7 +21,10 @@ struct perfctr_cpu_control_header {
 
 struct perfctr_cpu_state_user {
 	__u32 cstatus;
-	__u32 _filler;
+	/* This is a sequence counter to ensure atomic reads by
+	 * userspace.  The mechanism is identical to that used for
+	 * seqcount_t in include/linux/seqlock.h. */
+	__u32 sequence;
 	__u64 tsc_start;
 	__u64 tsc_sum;
 	struct {
