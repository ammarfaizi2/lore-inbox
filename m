Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVCRIvY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVCRIvY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:51:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261501AbVCRIvY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:51:24 -0500
Received: from aun.it.uu.se ([130.238.12.36]:64760 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261507AbVCRIu5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:50:57 -0500
Date: Fri, 18 Mar 2005 09:50:50 +0100 (MET)
Message-Id: <200503180850.j2I8oo3T021588@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm4] perfctr cleanups 2/3: ppc32
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ppc32-specific cleanups for perfctr:
- ppc.c: don't initialise obsolete perfctr_info.cpu_type,
  use DEFINE_SPINLOCK().
- <asm-ppc/perfctr.h>: remove cpu_type constants and
  PERFCTR_CPU_VERSION unused in the kernel, use
  explicitly-sized integers in user-visible types, make
  perfctr_cpu_control kernel-private.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/ppc.c     |    8 +++-----
 include/asm-ppc/perfctr.h |   43 ++++++++++++++++++-------------------------
 2 files changed, 21 insertions(+), 30 deletions(-)

diff -rupN linux-2.6.11-mm4/drivers/perfctr/ppc.c linux-2.6.11-mm4.perfctr-2.7.12/drivers/perfctr/ppc.c
--- linux-2.6.11-mm4/drivers/perfctr/ppc.c	2005-03-17 19:39:42.000000000 +0100
+++ linux-2.6.11-mm4.perfctr-2.7.12/drivers/perfctr/ppc.c	2005-03-18 00:50:05.000000000 +0100
@@ -1,7 +1,7 @@
-/* $Id: ppc.c,v 1.30 2004/11/24 00:23:27 mikpe Exp $
+/* $Id: ppc.c,v 1.35 2005/03/17 23:50:05 mikpe Exp $
  * PPC32 performance-monitoring counters driver.
  *
- * Copyright (C) 2004  Mikael Pettersson
+ * Copyright (C) 2004-2005  Mikael Pettersson
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -43,7 +43,7 @@ static enum pm_type pm_type;
 
 static unsigned int new_id(void)
 {
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(lock);
 	static unsigned int counter;
 	int id;
 
@@ -1005,7 +1005,6 @@ static int __init known_init(void)
 		return -ENODEV;
 	}
 	perfctr_info.cpu_features = features;
-	perfctr_info.cpu_type = 0; /* user-space should inspect PVR */
 	perfctr_cpu_name = known_name;
 	perfctr_info.cpu_khz = detect_cpu_khz(pll_type);
 	perfctr_ppc_init_tests(have_mmcr1);
@@ -1021,7 +1020,6 @@ static int __init unknown_init(void)
 	if (!khz)
 		return -ENODEV;
 	perfctr_info.cpu_features = PERFCTR_FEATURE_RDTSC;
-	perfctr_info.cpu_type = 0;
 	perfctr_cpu_name = unknown_name;
 	perfctr_info.cpu_khz = khz;
 	pm_type = PM_NONE;
diff -rupN linux-2.6.11-mm4/include/asm-ppc/perfctr.h linux-2.6.11-mm4.perfctr-2.7.12/include/asm-ppc/perfctr.h
--- linux-2.6.11-mm4/include/asm-ppc/perfctr.h	2005-03-17 19:39:43.000000000 +0100
+++ linux-2.6.11-mm4.perfctr-2.7.12/include/asm-ppc/perfctr.h	2005-03-18 00:58:54.000000000 +0100
@@ -1,30 +1,25 @@
-/* $Id: perfctr.h,v 1.12 2004/11/24 00:20:57 mikpe Exp $
+/* $Id: perfctr.h,v 1.16 2005/03/17 23:58:54 mikpe Exp $
  * PPC32 Performance-Monitoring Counters driver
  *
- * Copyright (C) 2004  Mikael Pettersson
+ * Copyright (C) 2004-2005  Mikael Pettersson
  */
 #ifndef _ASM_PPC_PERFCTR_H
 #define _ASM_PPC_PERFCTR_H
 
-/* perfctr_info.cpu_type values */
-#define PERFCTR_PPC_GENERIC	0
-#define PERFCTR_PPC_604		1
-#define PERFCTR_PPC_604e	2
-#define PERFCTR_PPC_750		3
-#define PERFCTR_PPC_7400	4
-#define PERFCTR_PPC_7450	5
+#include <asm/types.h>
 
 struct perfctr_sum_ctrs {
-	unsigned long long tsc;
-	unsigned long long pmc[8];
+	__u64 tsc;
+	__u64 pmc[8];	/* the size is not part of the user ABI */
 };
 
 struct perfctr_cpu_control_header {
-	unsigned int tsc_on;
-	unsigned int nractrs;		/* # of a-mode counters */
-	unsigned int nrictrs;		/* # of i-mode counters */
+	__u32 tsc_on;
+	__u32 nractrs;	/* number of accumulation-mode counters */
+	__u32 nrictrs;	/* number of interrupt-mode counters */
 };
 
+#ifdef __KERNEL__
 struct perfctr_cpu_control {
 	struct perfctr_cpu_control_header header;
 	unsigned int mmcr0;
@@ -34,21 +29,22 @@ struct perfctr_cpu_control {
 	unsigned int ireset[8];		/* [0,0x7fffffff], for i-mode counters, physical indices */
 	unsigned int pmc_map[8];	/* virtual to physical index map */
 };
+#endif
 
 struct perfctr_cpu_state {
-	unsigned int cstatus;
+	__u32 cstatus;
 	struct {	/* k1 is opaque in the user ABI */
-		unsigned int id;
-		int isuspend_cpu;
+		__u32 id;
+		__s32 isuspend_cpu;
 	} k1;
 	/* The two tsc fields must be inlined. Placing them in a
 	   sub-struct causes unwanted internal padding on x86-64. */
-	unsigned int tsc_start;
-	unsigned long long tsc_sum;
+	__u32 tsc_start;
+	__u64 tsc_sum;
 	struct {
-		unsigned int map;
-		unsigned int start;
-		unsigned long long sum;
+		__u32 map;
+		__u32 start;
+		__u64 sum;
 	} pmc[8];	/* the size is not part of the user ABI */
 #ifdef __KERNEL__
 	struct perfctr_cpu_control control;
@@ -109,9 +105,6 @@ static inline unsigned int perfctr_cstat
 #endif
 #define si_pmc_ovf_mask	_sifields._pad[0] /* XXX: use an unsigned field later */
 
-/* version number for user-visible CPU-specific data */
-#define PERFCTR_CPU_VERSION	0	/* XXX: not yet cast in stone */
-
 #ifdef __KERNEL__
 
 #if defined(CONFIG_PERFCTR)
