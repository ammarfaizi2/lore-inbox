Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261513AbVCRIxh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261513AbVCRIxh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Mar 2005 03:53:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261508AbVCRIxh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Mar 2005 03:53:37 -0500
Received: from aun.it.uu.se ([130.238.12.36]:19961 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S261501AbVCRIv4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Mar 2005 03:51:56 -0500
Date: Fri, 18 Mar 2005 09:51:49 +0100 (MET)
Message-Id: <200503180851.j2I8pnte021596@alkaid.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.11-mm4] perfctr cleanups 3/3: x86
Cc: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

x86-specific cleanups for perfctr:
- x86.c: use DEFINE_SPINLOCK().
- <asm-i386/perfctr.h>: remove cpu_type constants and
  PERFCTR_CPU_VERSION unused in the kernel, use
  explicitly-sized integers in user-visible types, make
  perfctr_cpu_control kernel-private.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

 drivers/perfctr/x86.c      |    6 ++---
 include/asm-i386/perfctr.h |   54 +++++++++++++++------------------------------
 2 files changed, 21 insertions(+), 39 deletions(-)

diff -rupN linux-2.6.11-mm4/drivers/perfctr/x86.c linux-2.6.11-mm4.perfctr-2.7.12/drivers/perfctr/x86.c
--- linux-2.6.11-mm4/drivers/perfctr/x86.c	2005-03-17 19:39:42.000000000 +0100
+++ linux-2.6.11-mm4.perfctr-2.7.12/drivers/perfctr/x86.c	2005-03-13 14:55:58.000000000 +0100
@@ -1,7 +1,7 @@
-/* $Id: x86.c,v 1.151 2004/11/24 00:28:23 mikpe Exp $
+/* $Id: x86.c,v 1.155 2005/03/13 13:55:58 mikpe Exp $
  * x86/x86_64 performance-monitoring counters driver.
  *
- * Copyright (C) 1999-2004  Mikael Pettersson
+ * Copyright (C) 1999-2005  Mikael Pettersson
  */
 #include <linux/config.h>
 #include <linux/init.h>
@@ -135,7 +135,7 @@ static inline void clear_in_cr4_local(un
 
 static unsigned int new_id(void)
 {
-	static spinlock_t lock = SPIN_LOCK_UNLOCKED;
+	static DEFINE_SPINLOCK(lock);
 	static unsigned int counter;
 	int id;
 
diff -rupN linux-2.6.11-mm4/include/asm-i386/perfctr.h linux-2.6.11-mm4.perfctr-2.7.12/include/asm-i386/perfctr.h
--- linux-2.6.11-mm4/include/asm-i386/perfctr.h	2005-03-17 19:39:43.000000000 +0100
+++ linux-2.6.11-mm4.perfctr-2.7.12/include/asm-i386/perfctr.h	2005-03-18 00:57:10.000000000 +0100
@@ -1,41 +1,25 @@
-/* $Id: perfctr.h,v 1.57 2004/11/24 00:21:20 mikpe Exp $
+/* $Id: perfctr.h,v 1.61 2005/03/17 23:57:10 mikpe Exp $
  * x86/x86_64 Performance-Monitoring Counters driver
  *
- * Copyright (C) 1999-2004  Mikael Pettersson
+ * Copyright (C) 1999-2005  Mikael Pettersson
  */
 #ifndef _ASM_I386_PERFCTR_H
 #define _ASM_I386_PERFCTR_H
 
-/* cpu_type values */
-#define PERFCTR_X86_GENERIC	0	/* any x86 with rdtsc */
-#define PERFCTR_X86_INTEL_P5	1	/* no rdpmc */
-#define PERFCTR_X86_INTEL_P5MMX	2
-#define PERFCTR_X86_INTEL_P6	3
-#define PERFCTR_X86_INTEL_PII	4
-#define PERFCTR_X86_INTEL_PIII	5
-#define PERFCTR_X86_CYRIX_MII	6
-#define PERFCTR_X86_WINCHIP_C6	7	/* no rdtsc */
-#define PERFCTR_X86_WINCHIP_2	8	/* no rdtsc */
-#define PERFCTR_X86_AMD_K7	9
-#define PERFCTR_X86_VIA_C3	10	/* no pmc0 */
-#define PERFCTR_X86_INTEL_P4	11	/* model 0 and 1 */
-#define PERFCTR_X86_INTEL_P4M2	12	/* model 2 */
-#define PERFCTR_X86_AMD_K8	13
-#define PERFCTR_X86_INTEL_PENTM	14	/* Pentium M */
-#define PERFCTR_X86_AMD_K8C	15	/* Revision C */
-#define PERFCTR_X86_INTEL_P4M3	16	/* model 3 and above */
+#include <asm/types.h>
 
 struct perfctr_sum_ctrs {
-	unsigned long long tsc;
-	unsigned long long pmc[18];
+	__u64 tsc;
+	__u64 pmc[18];	/* the size is not part of the user ABI */
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
 	unsigned int evntsel[18];	/* primary control registers, physical indices */
@@ -47,21 +31,22 @@ struct perfctr_cpu_control {
 	} p4;
 	unsigned int pmc_map[18];	/* virtual to physical (rdpmc) index map */
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
 	} pmc[18];	/* the size is not part of the user ABI */
 #ifdef __KERNEL__
 	struct perfctr_cpu_control control;
@@ -132,9 +117,6 @@ static inline unsigned int perfctr_cstat
 #endif
 #define si_pmc_ovf_mask	_sifields._pad[0] /* XXX: use an unsigned field later */
 
-/* version number for user-visible CPU-specific data */
-#define PERFCTR_CPU_VERSION	0x0500	/* 5.0 */
-
 #ifdef __KERNEL__
 
 #if defined(CONFIG_PERFCTR)
