Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318266AbSHZUDm>; Mon, 26 Aug 2002 16:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318230AbSHZUCQ>; Mon, 26 Aug 2002 16:02:16 -0400
Received: from svr-ganmtc-appserv-mgmt.ncf.coxexpress.com ([24.136.46.5]:10245
	"EHLO svr-ganmtc-appserv-mgmt.ncf.coxexpress.com") by vger.kernel.org
	with ESMTP id <S318242AbSHZUBr>; Mon, 26 Aug 2002 16:01:47 -0400
Subject: [PATCH] make raid5 checksums preempt-safe
From: Robert Love <rml@tech9.net>
To: torvalds@transmeta.com
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 
Date: 26 Aug 2002 16:06:03 -0400
Message-Id: <1030392363.905.418.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The raid5 xor checksums use MMX/SSE state and are not preempt-safe.

Attached patch disables preemption in FPU_SAVE and XMMS_SAVE and
restores it in FPU_RESTORE and XMMS_RESTORE - preventing preemption
while in fp mode.

Please, apply.

	Robert Love

diff -urN linux-2.5.31/include/asm-i386/xor.h linux/include/asm-i386/xor.h
--- linux-2.5.31/include/asm-i386/xor.h	Sat Aug 10 21:41:20 2002
+++ linux/include/asm-i386/xor.h	Sat Aug 24 20:14:43 2002
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
@@ -543,6 +545,7 @@
  */
 
 #define XMMS_SAVE				\
+	preempt_disable();			\
 	__asm__ __volatile__ ( 			\
 		"movl %%cr0,%0		;\n\t"	\
 		"clts			;\n\t"	\
@@ -564,7 +567,8 @@
 		"movl 	%0,%%cr0	;\n\t"	\
 		:				\
 		: "r" (cr0), "r" (xmm_save)	\
-		: "memory")
+		: "memory")			\
+	preempt_enable();
 
 #define ALIGN16 __attribute__((aligned(16)))
 
diff -urN linux-2.5.31/include/asm-x86_64/xor.h linux/include/asm-x86_64/xor.h
--- linux-2.5.31/include/asm-x86_64/xor.h	Sat Aug 10 21:41:23 2002
+++ linux/include/asm-x86_64/xor.h	Sat Aug 24 20:05:41 2002
@@ -38,7 +38,8 @@
 /* Doesn't use gcc to save the XMM registers, because there is no easy way to 
    tell it to do a clts before the register saving. */
 #define XMMS_SAVE				\
-	asm volatile ( 			\
+	preempt_disable();			\
+	asm volatile (				\
 		"movq %%cr0,%0		;\n\t"	\
 		"clts			;\n\t"	\
 		"movups %%xmm0,(%1)	;\n\t"	\
@@ -59,7 +60,8 @@
 		"movq 	%0,%%cr0	;\n\t"	\
 		:				\
 		: "r" (cr0), "r" (xmm_save)	\
-		: "memory")
+		: "memory")			\
+	preempt_enable();
 
 #define OFFS(x)		"16*("#x")"
 #define PF_OFFS(x)	"256+16*("#x")"



