Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266442AbUFUUPj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266442AbUFUUPj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 21 Jun 2004 16:15:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266447AbUFUUPj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 21 Jun 2004 16:15:39 -0400
Received: from aun.it.uu.se ([130.238.12.36]:42645 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S266442AbUFUUO5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 21 Jun 2004 16:14:57 -0400
Date: Mon, 21 Jun 2004 22:14:47 +0200 (MEST)
Message-Id: <200406212014.i5LKElHD019224@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.7-mm1] perfctr ppc32 update
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

This patch updates the performance-monitoring counters extensions'
ppc32 low-level driver as follows:
- Replace ugly /proc/cpuinfo parsing code (for detecting core
  clock frequency) with code that asks Open Firmware instead.
  This way we also get the important timebase frequency.
- Using new OF interface, detect and support generic chips having
  a timebase register. This is useful because that's enough for
  user-space to implement hrvtime().
- Using new OF interface, finally be able to derive the correct
  timebase-to-core multiplier on old 604 (not 604e) chips.
- Avoid having to do partial processor detection in ppc_tests.c.
- Some code cleanups.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -ruN linux-2.6.7-mm1/drivers/perfctr/ppc.c linux-2.6.7-mm1.perfctr-ppc32-update/drivers/perfctr/ppc.c
--- linux-2.6.7-mm1/drivers/perfctr/ppc.c	2004-06-21 19:33:30.000000000 +0200
+++ linux-2.6.7-mm1.perfctr-ppc32-update/drivers/perfctr/ppc.c	2004-06-21 21:13:57.685020000 +0200
@@ -8,8 +8,7 @@
 #include <linux/sched.h>
 #include <linux/fs.h>
 #include <linux/perfctr.h>
-#include <linux/seq_file.h>
-#include <asm/machdep.h>
+#include <asm/prom.h>
 #include <asm/time.h>		/* tb_ticks_per_jiffy, get_tbl() */
 
 #include "ppc_tests.h"
@@ -23,6 +22,7 @@
 	unsigned int ppc_mmcr[3];
 } ____cacheline_aligned;
 static DEFINE_PER_CPU(struct per_cpu_cache, per_cpu_cache);
+#define get_cpu_cache()	__get_cpu_var(per_cpu_cache)
 
 /* Structure for counter snapshots, as 32-bit values. */
 struct perfctr_low_ctrs {
@@ -31,11 +31,12 @@
 };
 
 enum pm_type {
-    PM_604,
-    PM_604e,
-    PM_750,	/* XXX: Minor event set diffs between IBM and Moto. */
-    PM_7400,
-    PM_7450,
+	PM_NONE,
+	PM_604,
+	PM_604e,
+	PM_750,	/* XXX: Minor event set diffs between IBM and Moto. */
+	PM_7400,
+	PM_7450,
 };
 static enum pm_type pm_type;
 
@@ -244,7 +245,7 @@
 	if (state->cstatus & (1<<30)) {
 		unsigned int mmcr0 = mfspr(SPRN_MMCR0);
 		state->ppc_mmcr[0] = mmcr0;
-		__get_cpu_var(per_cpu_cache).ppc_mmcr[0] = mmcr0;
+		get_cpu_cache().ppc_mmcr[0] = mmcr0;
 	}
 }
 
@@ -276,9 +277,10 @@
 	case PM_750:
 	case PM_604e:
 		return 4;
-	default: /* impossible, but silences gcc warning */
 	case PM_604:
 		return 2;
+	default: /* PM_NONE, but silences gcc warning */
+		return 0;
 	}
 }
 
@@ -365,7 +367,7 @@
 	struct per_cpu_cache *cache;
 	unsigned int value;
 
-	cache = &__get_cpu_var(per_cpu_cache);
+	cache = &get_cpu_cache();
 	if (cache->k1.id == state->k1.id)
 		return;
 	/*
@@ -411,6 +413,8 @@
 		mtspr(SPRN_MMCR1, 0);
 	case PM_604:
 		mtspr(SPRN_MMCR0, 0);
+	case PM_NONE:
+		;
 	}
 	switch (pm_type) {
 	case PM_7450:
@@ -424,6 +428,8 @@
 	case PM_604:
 		mtspr(SPRN_PMC2, 0);
 		mtspr(SPRN_PMC1, 0);
+	case PM_NONE:
+		;
 	}
 }
 
@@ -460,7 +466,7 @@
 #ifdef CONFIG_SMP
 	clear_isuspend_cpu(state);
 #else
-	__get_cpu_var(per_cpu_cache).k1.id = 0;
+	get_cpu_cache().k1.id = 0;
 #endif
 }
 
@@ -603,7 +609,7 @@
 {
 	struct per_cpu_cache *cache;
 
-	cache = &__get_cpu_var(per_cpu_cache);
+	cache = &get_cpu_cache();
 	memset(cache, 0, sizeof *cache);
 	cache->k1.id = -1;
 
@@ -715,8 +721,7 @@
 	pll_cfg = (hid1 >> shift) & mask;
 	ratio = cfg_ratio[pll_cfg];
 	if (!ratio)
-		printk(KERN_WARNING "perfctr/%s: unknown PLL_CFG 0x%x\n",
-		       __FILE__, pll_cfg);
+		printk(KERN_WARNING "perfctr: unknown PLL_CFG 0x%x\n", pll_cfg);
 	return (4/2) * ratio;
 }
 
@@ -727,102 +732,59 @@
 	return tb_ticks_per_jiffy * tb_to_core * (HZ/10) / (1000/10);
 }
 
-/* Extract the CPU clock frequency from /proc/cpuinfo. */
+/* Extract core and timebase frequencies from Open Firmware. */
 
-static unsigned int __init parse_clock_khz(struct seq_file *m)
+static unsigned int __init of_to_core_khz(void)
 {
-	/* "/proc/cpuinfo" formats:
-	 *
-	 * "core clock\t: %d MHz\n"	// 8260 (show_percpuinfo)
-	 * "clock\t\t: %ldMHz\n"	// 4xx (show_percpuinfo)
-	 * "clock\t\t: %dMHz\n"		// oak (show_percpuinfo)
-	 * "clock\t\t: %ldMHz\n"	// prep (show_percpuinfo)
-	 * "clock\t\t: %dMHz\n"		// pmac (show_percpuinfo)
-	 * "clock\t\t: %dMHz\n"		// gemini (show_cpuinfo!)
-	 */
-	char *p;
-	unsigned int mhz;
+	struct device_node *cpu;
+	unsigned int *fp, core, tb;
 
-	p = m->buf;
-	p[m->count] = '\0';
-
-	for(;;) {		/* for each line */
-		if (strncmp(p, "core ", 5) == 0)
-			p += 5;
-		do {
-			if (strncmp(p, "clock\t", 6) != 0)
-				break;
-			p += 6;
-			while (*p == '\t')
-				++p;
-			if (*p != ':')
-				break;
-			do {
-				++p;
-			} while (*p == ' ');
-			mhz = simple_strtoul(p, 0, 10);
-			if (mhz)
-				return mhz * 1000;
-		} while (0);
-		for(;;) {	/* skip to next line */
-			switch (*p++) {
-			case '\n':
-				break;
-			case '\0':
-				return 0;
-			default:
-				continue;
-			}
-			break;
-		}
-	}
+	cpu = find_type_devices("cpu");
+	if (!cpu)
+		return 0;
+	fp = (unsigned int*)get_property(cpu, "clock-frequency", NULL);
+	if (!fp || !(core = *fp))
+		return 0;
+	fp = (unsigned int*)get_property(cpu, "timebase-frequency", NULL);
+	if (!fp || !(tb = *fp))
+		return 0;
+	perfctr_info.tsc_to_cpu_mult = core / tb;
+	return core / 1000;
 }
 
 static unsigned int __init detect_cpu_khz(enum pll_type pll_type)
 {
-	char buf[512];
-	struct seq_file m;
 	unsigned int khz;
 
 	khz = pll_to_core_khz(pll_type);
 	if (khz)
 		return khz;
 
-	memset(&m, 0, sizeof m);
-	m.buf = buf;
-	m.size = (sizeof buf)-1;
-
-	m.count = 0;
-	if (ppc_md.show_percpuinfo != 0 &&
-	    ppc_md.show_percpuinfo(&m, 0) == 0 &&
-	    (khz = parse_clock_khz(&m)) != 0)
-		return khz;
-
-	m.count = 0;
-	if (ppc_md.show_cpuinfo != 0 &&
-	    ppc_md.show_cpuinfo(&m) == 0 &&
-	    (khz = parse_clock_khz(&m)) != 0)
+	khz = of_to_core_khz();
+	if (khz)
 		return khz;
 
-	printk(KERN_WARNING "perfctr/%s: unable to determine CPU speed\n",
-	       __FILE__);
+	printk(KERN_WARNING "perfctr: unable to determine CPU speed\n");
 	return 0;
 }
 
-static int __init generic_init(void)
+static int __init known_init(void)
 {
-	static char generic_name[] __initdata = "PowerPC 60x/7xx/74xx";
+	static char known_name[] __initdata = "PowerPC 60x/7xx/74xx";
 	unsigned int features;
 	enum pll_type pll_type;
 	unsigned int pvr;
+	int have_mmcr1;
 
 	features = PERFCTR_FEATURE_RDTSC | PERFCTR_FEATURE_RDPMC;
+	have_mmcr1 = 1;
 	pvr = mfspr(SPRN_PVR);
 	switch (PVR_VER(pvr)) {
 	case 0x0004: /* 604 */
 		pm_type = PM_604;
 		pll_type = PLL_NONE;
 		features = PERFCTR_FEATURE_RDTSC;
+		have_mmcr1 = 0;
 		break;
 	case 0x0009: /* 604e;  */
 	case 0x000A: /* 604ev */
@@ -860,15 +822,29 @@
 		pll_type = PLL_7457;
 		break;
 	default:
-		printk(KERN_WARNING "perfctr/%s: unknown PowerPC with "
-		       "PVR 0x%08x -- bailing out\n", __FILE__, pvr);
 		return -ENODEV;
 	}
 	perfctr_info.cpu_features = features;
 	perfctr_info.cpu_type = 0; /* user-space should inspect PVR */
-	perfctr_cpu_name = generic_name;
+	perfctr_cpu_name = known_name;
 	perfctr_info.cpu_khz = detect_cpu_khz(pll_type);
-	perfctr_ppc_init_tests();
+	perfctr_ppc_init_tests(have_mmcr1);
+	return 0;
+}
+
+static int __init unknown_init(void)
+{
+	static char unknown_name[] __initdata = "Generic PowerPC with TB";
+	unsigned int khz;
+
+	khz = detect_cpu_khz(PLL_NONE);
+	if (!khz)
+		return -ENODEV;
+	perfctr_info.cpu_features = PERFCTR_FEATURE_RDTSC;
+	perfctr_info.cpu_type = 0;
+	perfctr_cpu_name = unknown_name;
+	perfctr_info.cpu_khz = khz;
+	pm_type = PM_NONE;
 	return 0;
 }
 
@@ -896,9 +872,12 @@
 
 	perfctr_info.cpu_features = 0;
 
-	err = generic_init();
-	if (err)
-		goto out;
+	err = known_init();
+	if (err) {
+		err = unknown_init();
+		if (err)
+			goto out;
+	}
 
 	perfctr_cpu_init_one(NULL);
 	smp_call_function(perfctr_cpu_init_one, NULL, 1, 1);
diff -ruN linux-2.6.7-mm1/drivers/perfctr/ppc_tests.c linux-2.6.7-mm1.perfctr-ppc32-update/drivers/perfctr/ppc_tests.c
--- linux-2.6.7-mm1/drivers/perfctr/ppc_tests.c	2004-06-21 19:33:30.000000000 +0200
+++ linux-2.6.7-mm1.perfctr-ppc32-update/drivers/perfctr/ppc_tests.c	2004-06-21 21:13:54.085020000 +0200
@@ -280,7 +280,7 @@
 	check_trigger(1);
 }
 
-void __init perfctr_ppc_init_tests(void)
+void __init perfctr_ppc_init_tests(int have_mmcr1)
 {
-	measure_overheads(PVR_VER(mfspr(SPRN_PVR)) != 0x0004);
+	measure_overheads(have_mmcr1);
 }
diff -ruN linux-2.6.7-mm1/drivers/perfctr/ppc_tests.h linux-2.6.7-mm1.perfctr-ppc32-update/drivers/perfctr/ppc_tests.h
--- linux-2.6.7-mm1/drivers/perfctr/ppc_tests.h	2004-06-21 19:33:30.000000000 +0200
+++ linux-2.6.7-mm1.perfctr-ppc32-update/drivers/perfctr/ppc_tests.h	2004-06-21 21:13:54.085020000 +0200
@@ -6,7 +6,7 @@
  */
 
 #ifdef CONFIG_PERFCTR_INIT_TESTS
-extern void perfctr_ppc_init_tests(void);
+extern void perfctr_ppc_init_tests(int have_mmcr1);
 #else
-#define perfctr_ppc_init_tests()
+static inline void perfctr_ppc_init_tests(int have_mmcr1) { }
 #endif
diff -ruN linux-2.6.7-mm1/include/asm-ppc/perfctr.h linux-2.6.7-mm1.perfctr-ppc32-update/include/asm-ppc/perfctr.h
--- linux-2.6.7-mm1/include/asm-ppc/perfctr.h	2004-06-21 19:33:30.000000000 +0200
+++ linux-2.6.7-mm1.perfctr-ppc32-update/include/asm-ppc/perfctr.h	2004-06-21 21:13:54.085020000 +0200
@@ -7,6 +7,7 @@
 #define _ASM_PPC_PERFCTR_H
 
 /* perfctr_info.cpu_type values */
+#define PERFCTR_PPC_GENERIC	0
 #define PERFCTR_PPC_604		1
 #define PERFCTR_PPC_604e	2
 #define PERFCTR_PPC_750		3
