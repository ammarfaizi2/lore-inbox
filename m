Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262201AbUKKJnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262201AbUKKJnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Nov 2004 04:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262207AbUKKJkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Nov 2004 04:40:31 -0500
Received: from aun.it.uu.se ([130.238.12.36]:63139 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S262199AbUKKJhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Nov 2004 04:37:14 -0500
Date: Thu, 11 Nov 2004 10:37:07 +0100 (MET)
Message-Id: <200411110937.iAB9b7Ir028763@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.10-rc1-mm4][3/4] perfctr x86 driver updates
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Part 3/4 of the perfctr interrupt fixes:
- Add facility for masking perfctr interrupts. To reduce
  overheads, this is done in software via a per-cpu mask
  instead of writing to the local APIC.
- Mask interrupts when interrupt-mode counters are suspended,
  and unmask when they are resumed. Prevents delayed interrupts
  (due to HW quirk) from being delivered to the wrong tasks.
- Suspend path records if any interrupt-mode counters are
  in overflow state. This informs the higher levels that a
  pending interrupt (now masked) must be simulated.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c      |   22 ++++++++++++++++++++++
 include/asm-i386/perfctr.h |    3 +++
 2 files changed, 25 insertions(+)

diff -rupN linux-2.6.10-rc1-mm4/drivers/perfctr/x86.c linux-2.6.10-rc1-mm4.perfctr-x86-driver-update/drivers/perfctr/x86.c
--- linux-2.6.10-rc1-mm4/drivers/perfctr/x86.c	2004-11-10 18:02:56.000000000 +0100
+++ linux-2.6.10-rc1-mm4.perfctr-x86-driver-update/drivers/perfctr/x86.c	2004-11-11 00:26:46.000000000 +0100
@@ -34,6 +34,9 @@ struct per_cpu_cache {	/* roughly a subs
 		unsigned int pebs_enable;
 		unsigned int pebs_matrix_vert;
 	} control;
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+	unsigned int interrupts_masked;
+#endif
 } ____cacheline_aligned;
 static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
 #define __get_cpu_cache(cpu) (&per_cpu(per_cpu_cache, cpu))
@@ -155,6 +158,8 @@ asmlinkage void smp_perfctr_interrupt(st
 	   masks interrupts. We're still on the originating CPU. */
 	/* XXX: recursive interrupts? delay the ACK, mask LVTPC, or queue? */
 	ack_APIC_irq();
+	if (get_cpu_cache()->interrupts_masked)
+		return;
 	irq_enter();
 	(*perfctr_ihandler)(instruction_pointer(regs));
 	irq_exit();
@@ -165,6 +170,16 @@ void perfctr_cpu_set_ihandler(perfctr_ih
 	perfctr_ihandler = ihandler ? ihandler : perfctr_default_ihandler;
 }
 
+static inline void perfctr_cpu_mask_interrupts(struct per_cpu_cache *cache)
+{
+	cache->interrupts_masked = 1;
+}
+
+static inline void perfctr_cpu_unmask_interrupts(struct per_cpu_cache *cache)
+{
+	cache->interrupts_masked = 0;
+}
+
 #else
 #define perfctr_cstatus_has_ictrs(cstatus)	0
 #undef cpu_has_apic
@@ -452,10 +467,12 @@ static void p6_like_isuspend(struct perf
 	struct per_cpu_cache *cache;
 	unsigned int cstatus, nrctrs, i;
 	int cpu;
+	unsigned int pending = 0;
 
 	cpu = smp_processor_id();
 	set_isuspend_cpu(state, cpu); /* early to limit cpu's live range */
 	cache = __get_cpu_cache(cpu);
+	perfctr_cpu_mask_interrupts(cache);
 	cstatus = state->cstatus;
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 	for(i = perfctr_cstatus_nractrs(cstatus); i < nrctrs; ++i) {
@@ -471,7 +488,10 @@ static void p6_like_isuspend(struct perf
 		rdpmc_low(pmc_raw, now);
 		state->pmc[i].sum += now - state->pmc[i].start;
 		state->pmc[i].start = now;
+		if ((int)now >= 0)
+			++pending;
 	}
+	state->pending_interrupt = pending;
 	/* cache->k1.id is still == state->k1.id */
 }
 
@@ -487,6 +507,7 @@ static void p6_like_iresume(const struct
 
 	cpu = smp_processor_id();
 	cache = __get_cpu_cache(cpu);
+	perfctr_cpu_unmask_interrupts(cache);
 	if (cache->k1.id == state->k1.id) {
 		cache->k1.id = 0; /* force reload of cleared EVNTSELs */
 		if (is_isuspend_cpu(state, cpu))
@@ -979,6 +1000,7 @@ unsigned int perfctr_cpu_identify_overfl
 	pmc = perfctr_cstatus_nractrs(cstatus);
 	nrctrs = perfctr_cstatus_nrctrs(cstatus);
 
+	state->pending_interrupt = 0;
 	for(pmc_mask = 0; pmc < nrctrs; ++pmc) {
 		if ((int)state->pmc[pmc].start >= 0) { /* XXX: ">" ? */
 			/* XXX: "+=" to correct for overshots */
diff -rupN linux-2.6.10-rc1-mm4/include/asm-i386/perfctr.h linux-2.6.10-rc1-mm4.perfctr-x86-driver-update/include/asm-i386/perfctr.h
--- linux-2.6.10-rc1-mm4/include/asm-i386/perfctr.h	2004-11-10 18:03:00.000000000 +0100
+++ linux-2.6.10-rc1-mm4.perfctr-x86-driver-update/include/asm-i386/perfctr.h	2004-11-11 00:26:58.000000000 +0100
@@ -66,6 +66,9 @@ struct perfctr_cpu_state {
 #ifdef __KERNEL__
 	struct perfctr_cpu_control control;
 	unsigned int p4_escr_map[18];
+#ifdef CONFIG_PERFCTR_INTERRUPT_SUPPORT
+	unsigned int pending_interrupt;
+#endif
 #endif
 };
 
