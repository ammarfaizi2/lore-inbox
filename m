Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319231AbSH2P20>; Thu, 29 Aug 2002 11:28:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319233AbSH2P20>; Thu, 29 Aug 2002 11:28:26 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:55303
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S319231AbSH2P2O>; Thu, 29 Aug 2002 11:28:14 -0400
Subject: [PATCH] make raid5 checksums preempt-safe, take two
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 29 Aug 2002 11:32:31 -0400
Message-Id: <1030635151.939.2555.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The raid5 xor checksums use MMX/SSE state and are not preempt-safe.

Attached patch disables preemption in FPU_SAVE and XMMS_SAVE and
restores it in FPU_RESTORE and XMMS_RESTORE - preventing preemption
while in fp mode.

I fixed the silly errors in the previous patch; this ought to be right.

Patch is against 2.5.32-bk.  Please, apply.

        Robert Love

diff -urN linux-2.5.32/include/asm-i386/xor.h linux/include/asm-i386/xor.h
--- linux-2.5.32/include/asm-i386/xor.h	Tue Aug 27 15:26:34 2002
+++ linux/include/asm-i386/xor.h	Wed Aug 28 17:17:51 2002
@@ -20,6 +20,7 @@
 
 #define FPU_SAVE							\
   do {									\
+	preempt_disable();						\
 	if (!test_thread_flag(TIF_USEDFPU))				\
 		__asm__ __volatile__ (" clts;\n");			\
 	__asm__ __volatile__ ("fsave %0; fwait": "=m"(fpu_save[0]));	\
@@ -30,6 +31,7 @@
 	__asm__ __volatile__ ("frstor %0": : "m"(fpu_save[0]));		\
 	if (!test_thread_flag(TIF_USEDFPU))				\
 		stts();							\
+	preempt_enable();						\
   } while (0)
 
 #define LD(x,y)		"       movq   8*("#x")(%1), %%mm"#y"   ;\n"
@@ -542,7 +544,8 @@
  * Copyright (C) 1999 Zach Brown (with obvious credit due Ingo)
  */
 
-#define XMMS_SAVE				\
+#define XMMS_SAVE do {				\
+	preempt_disable();			\
 	__asm__ __volatile__ ( 			\
 		"movl %%cr0,%0		;\n\t"	\
 		"clts			;\n\t"	\
@@ -552,9 +555,10 @@
 		"movups %%xmm3,0x30(%1)	;\n\t"	\
 		: "=&r" (cr0)			\
 		: "r" (xmm_save) 		\
-		: "memory")
+		: "memory");			\
+} while(0)
 
-#define XMMS_RESTORE				\
+#define XMMS_RESTORE do {			\
 	__asm__ __volatile__ ( 			\
 		"sfence			;\n\t"	\
 		"movups (%1),%%xmm0	;\n\t"	\
@@ -564,7 +568,9 @@
 		"movl 	%0,%%cr0	;\n\t"	\
 		:				\
 		: "r" (cr0), "r" (xmm_save)	\
-		: "memory")
+		: "memory");			\
+	preempt_enable();			\
+} while(0)
 
 #define ALIGN16 __attribute__((aligned(16)))
 
diff -urN linux-2.5.32/include/asm-x86_64/xor.h linux/include/asm-x86_64/xor.h
--- linux-2.5.32/include/asm-x86_64/xor.h	Tue Aug 27 15:26:36 2002
+++ linux/include/asm-x86_64/xor.h	Wed Aug 28 17:19:07 2002
@@ -37,8 +37,9 @@
 
 /* Doesn't use gcc to save the XMM registers, because there is no easy way to 
    tell it to do a clts before the register saving. */
-#define XMMS_SAVE				\
-	asm volatile ( 			\
+#define XMMS_SAVE do {				\
+	preempt_disable();			\
+	asm volatile (				\
 		"movq %%cr0,%0		;\n\t"	\
 		"clts			;\n\t"	\
 		"movups %%xmm0,(%1)	;\n\t"	\
@@ -47,10 +48,11 @@
 		"movups %%xmm3,0x30(%1)	;\n\t"	\
 		: "=r" (cr0)			\
 		: "r" (xmm_save) 		\
-		: "memory")
+		: "memory");			\
+} while(0)
 
 #define XMMS_RESTORE				\
-	asm volatile ( 			\
+	asm volatile (				\
 		"sfence			;\n\t"	\
 		"movups (%1),%%xmm0	;\n\t"	\
 		"movups 0x10(%1),%%xmm1	;\n\t"	\
@@ -59,7 +61,9 @@
 		"movq 	%0,%%cr0	;\n\t"	\
 		:				\
 		: "r" (cr0), "r" (xmm_save)	\
-		: "memory")
+		: "memory");			\
+	preempt_enable();			\
+} while(0)
 
 #define OFFS(x)		"16*("#x")"
 #define PF_OFFS(x)	"256+16*("#x")"

