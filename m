Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932414AbVHWVrV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbVHWVrV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 17:47:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932448AbVHWVrU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 17:47:20 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18614 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S932443AbVHWVot (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 17:44:49 -0400
To: torvalds@osdl.org
Subject: [PATCH] (37/43) qualifiers in return types - easy cases
Cc: linux-kernel@vger.kernel.org
Message-Id: <E1E7gca-0007Em-Da@parcelfarce.linux.theplanet.co.uk>
From: Al Viro <viro@www.linux.org.uk>
Date: Tue, 23 Aug 2005 22:47:52 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

a bunch of functions switched from volatile to __attribute__((noreturn)) and
from const to __attribute_pure__

Signed-off-by: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
----
diff -urN RC13-rc6-git13-qdio_get_indicator/arch/arm/kernel/traps.c RC13-rc6-git13-attr/arch/arm/kernel/traps.c
--- RC13-rc6-git13-qdio_get_indicator/arch/arm/kernel/traps.c	2005-08-10 10:37:45.000000000 -0400
+++ RC13-rc6-git13-attr/arch/arm/kernel/traps.c	2005-08-21 13:17:19.000000000 -0400
@@ -617,7 +617,7 @@
 	notify_die("unknown data abort code", regs, &info, instr, 0);
 }
 
-volatile void __bug(const char *file, int line, void *data)
+void __attribute__((noreturn)) __bug(const char *file, int line, void *data)
 {
 	printk(KERN_CRIT"kernel BUG at %s:%d!", file, line);
 	if (data)
diff -urN RC13-rc6-git13-qdio_get_indicator/arch/arm/nwfpe/fpopcode.h RC13-rc6-git13-attr/arch/arm/nwfpe/fpopcode.h
--- RC13-rc6-git13-qdio_get_indicator/arch/arm/nwfpe/fpopcode.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-attr/arch/arm/nwfpe/fpopcode.h	2005-08-21 13:17:19.000000000 -0400
@@ -370,20 +370,20 @@
 #define getRoundingMode(opcode)		((opcode & MASK_ROUNDING_MODE) >> 5)
 
 #ifdef CONFIG_FPE_NWFPE_XP
-static inline const floatx80 getExtendedConstant(const unsigned int nIndex)
+static inline __attribute_pure__ floatx80 getExtendedConstant(const unsigned int nIndex)
 {
 	extern const floatx80 floatx80Constant[];
 	return floatx80Constant[nIndex];
 }
 #endif
 
-static inline const float64 getDoubleConstant(const unsigned int nIndex)
+static inline __attribute_pure__ float64 getDoubleConstant(const unsigned int nIndex)
 {
 	extern const float64 float64Constant[];
 	return float64Constant[nIndex];
 }
 
-static inline const float32 getSingleConstant(const unsigned int nIndex)
+static inline __attribute_pure__ float32 getSingleConstant(const unsigned int nIndex)
 {
 	extern const float32 float32Constant[];
 	return float32Constant[nIndex];
diff -urN RC13-rc6-git13-qdio_get_indicator/include/asm-arm/bug.h RC13-rc6-git13-attr/include/asm-arm/bug.h
--- RC13-rc6-git13-qdio_get_indicator/include/asm-arm/bug.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-attr/include/asm-arm/bug.h	2005-08-21 13:17:19.000000000 -0400
@@ -5,7 +5,7 @@
 
 #ifdef CONFIG_BUG
 #ifdef CONFIG_DEBUG_BUGVERBOSE
-extern volatile void __bug(const char *file, int line, void *data);
+extern void __bug(const char *file, int line, void *data) __attribute__((noreturn));
 
 /* give file/line information */
 #define BUG()		__bug(__FILE__, __LINE__, NULL)
diff -urN RC13-rc6-git13-qdio_get_indicator/include/asm-arm/cpu-multi32.h RC13-rc6-git13-attr/include/asm-arm/cpu-multi32.h
--- RC13-rc6-git13-qdio_get_indicator/include/asm-arm/cpu-multi32.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-attr/include/asm-arm/cpu-multi32.h	2005-08-21 13:17:19.000000000 -0400
@@ -31,7 +31,7 @@
 	/*
 	 * Special stuff for a reset
 	 */
-	volatile void (*reset)(unsigned long addr);
+	void (*reset)(unsigned long addr) __attribute__((noreturn));
 	/*
 	 * Idle the processor
 	 */
diff -urN RC13-rc6-git13-qdio_get_indicator/include/asm-arm/cpu-single.h RC13-rc6-git13-attr/include/asm-arm/cpu-single.h
--- RC13-rc6-git13-qdio_get_indicator/include/asm-arm/cpu-single.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-attr/include/asm-arm/cpu-single.h	2005-08-21 13:17:19.000000000 -0400
@@ -41,4 +41,4 @@
 extern void cpu_dcache_clean_area(void *, int);
 extern void cpu_do_switch_mm(unsigned long pgd_phys, struct mm_struct *mm);
 extern void cpu_set_pte(pte_t *ptep, pte_t pte);
-extern volatile void cpu_reset(unsigned long addr);
+extern void cpu_reset(unsigned long addr) __attribute__((noreturn));
diff -urN RC13-rc6-git13-qdio_get_indicator/include/asm-ppc/time.h RC13-rc6-git13-attr/include/asm-ppc/time.h
--- RC13-rc6-git13-qdio_get_indicator/include/asm-ppc/time.h	2005-06-17 15:48:29.000000000 -0400
+++ RC13-rc6-git13-attr/include/asm-ppc/time.h	2005-08-21 13:17:19.000000000 -0400
@@ -58,7 +58,7 @@
 /* Accessor functions for the timebase (RTC on 601) registers. */
 /* If one day CONFIG_POWER is added just define __USE_RTC as 1 */
 #ifdef CONFIG_6xx
-extern __inline__ int const __USE_RTC(void) {
+extern __inline__ int __attribute_pure__ __USE_RTC(void) {
 	return (mfspr(SPRN_PVR)>>16) == 1;
 }
 #else
