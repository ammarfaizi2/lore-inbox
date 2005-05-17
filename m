Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261891AbVEQUqK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261891AbVEQUqK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 May 2005 16:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261724AbVEQUqJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 May 2005 16:46:09 -0400
Received: from aun.it.uu.se ([130.238.12.36]:13780 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261891AbVEQUof (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 May 2005 16:44:35 -0400
Date: Tue, 17 May 2005 22:44:22 +0200 (MEST)
Message-Id: <200505172044.j4HKiMTY026776@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH 2.6.12-rc4-mm2] perfctr: x86 update with K8 multicore fixes, take 2
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

Here's an update for perfctr's x86/x86-64 low-level driver
which works around issues with current K8 multicore chips.

Following Andi's comments about the original patch, this
version uses cpu_core_map[] instead of deriving that info
manually.

- Added code to detect multicore K8s and prevent threads in the
  thread-centric API from using northbridge events. This avoids
  resource conflicts, and an erratum in Revision E chips.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c |   59 +++++++++++++++++++++++++++++++++++++++++++++++---
 1 files changed, 56 insertions(+), 3 deletions(-)

diff -rupN linux-2.6.12-rc4-mm2/drivers/perfctr/x86.c linux-2.6.12-rc4-mm2.perfctr-k8-mc-fix/drivers/perfctr/x86.c
--- linux-2.6.12-rc4-mm2/drivers/perfctr/x86.c	2005-05-16 18:20:56.000000000 +0200
+++ linux-2.6.12-rc4-mm2.perfctr-k8-mc-fix/drivers/perfctr/x86.c	2005-05-17 21:47:06.000000000 +0200
@@ -66,6 +66,9 @@ struct perfctr_low_ctrs {
 #define MSR_K7_EVNTSEL0		0xC0010000	/* .. 0xC0010003 */
 #define MSR_K7_PERFCTR0		0xC0010004	/* .. 0xC0010007 */
 
+/* AMD K8 */
+#define IS_K8_NB_EVENT(EVNTSEL)	((((EVNTSEL) >> 5) & 0x7) == 0x7)
+
 /* Intel P4, Intel Pentium M */
 #define MSR_IA32_MISC_ENABLE	0x1A0
 #define MSR_IA32_MISC_ENABLE_PERF_AVAIL (1<<7)	/* read-only status bit */
@@ -398,8 +401,10 @@ static void c6_write_control(const struc
  * - Most events are symmetric, but a few are not.
  */
 
+static int k8_is_multicore;	/* affects northbridge events */
+
 /* shared with K7 */
-static int p6_like_check_control(struct perfctr_cpu_state *state, int is_k7)
+static int p6_like_check_control(struct perfctr_cpu_state *state, int is_k7, int is_global)
 {
 	unsigned int evntsel, i, nractrs, nrctrs, pmc_mask, pmc;
 
@@ -415,6 +420,9 @@ static int p6_like_check_control(struct 
 			return -EINVAL;
 		pmc_mask |= (1<<pmc);
 		evntsel = state->control.evntsel[pmc];
+		/* prevent the K8 multicore NB event clobber erratum */
+		if (!is_global && k8_is_multicore && IS_K8_NB_EVENT(evntsel))
+			return -EPERM;
 		/* protect reserved bits */
 		if (evntsel & P6_EVNTSEL_RESERVED)
 			return -EPERM;
@@ -451,7 +459,7 @@ static int p6_like_check_control(struct 
 
 static int p6_check_control(struct perfctr_cpu_state *state, int is_global)
 {
-	return p6_like_check_control(state, 0);
+	return p6_like_check_control(state, 0, is_global);
 }
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -592,7 +600,7 @@ static void p6_clear_counters(void)
 
 static int k7_check_control(struct perfctr_cpu_state *state, int is_global)
 {
-	return p6_like_check_control(state, 1);
+	return p6_like_check_control(state, 1, is_global);
 }
 
 #ifdef CONFIG_X86_LOCAL_APIC
@@ -1409,6 +1417,49 @@ static int __init intel_init(void)
 	return -ENODEV;
 }
 
+/*
+ * Multicore K8s have issues with northbridge events:
+ * 1. The NB is shared between the cores, so two different cores
+ *    in the same node cannot count NB events simultaneously.
+ *    This can be handled by using perfctr_cpus_forbidden_mask to
+ *    restrict NB-using threads to core0 of all nodes.
+ * 2. The initial multicore chips (Revision E) have an erratum
+ *    which causes the NB counters to be reset when either core
+ *    reprograms its evntsels (even for non-NB events).
+ *    This is only an issue because of scheduling of threads, so
+ *    we restrict NB events to the non thread-centric API.
+ *
+ * For now we only implement the workaround for issue 2, as this
+ * also handles issue 1.
+ *
+ * TODO: Detect post Revision E chips and implement a weaker
+ * workaround for them.
+ */
+#ifdef CONFIG_SMP
+static void __init k8_multicore_init(void)
+{
+	cpumask_t non0cores;
+	int i;
+
+	cpus_clear(non0cores);
+	for(i = 0; i < NR_CPUS; ++i) {
+		cpumask_t cores = cpu_core_map[i];
+		int core0 = first_cpu(cores);
+		if (core0 >= NR_CPUS)
+			continue;
+		cpu_clear(core0, cores);
+		cpus_or(non0cores, non0cores, cores);
+	}
+	if (cpus_empty(non0cores))
+		return;
+	k8_is_multicore = 1;
+	printk(KERN_INFO "perfctr/x86.c: multi-core K8s detected:"
+	       " restricting access to northbridge events\n");
+}
+#else
+#define k8_multicore_init()	do{}while(0)
+#endif
+
 static int __init amd_init(void)
 {
 	static char amd_name[] __initdata = "AMD K7/K8";
@@ -1417,7 +1468,9 @@ static int __init amd_init(void)
 		return -ENODEV;
 	switch (current_cpu_data.x86) {
 	case 6: /* K7 */
+		break;
 	case 15: /* K8. Like a K7 with a different event set. */
+		k8_multicore_init();
 		break;
 	default:
 		return -ENODEV;
