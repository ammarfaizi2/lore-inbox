Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268282AbUIBMkb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268282AbUIBMkb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Sep 2004 08:40:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268280AbUIBMkb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Sep 2004 08:40:31 -0400
Received: from ozlabs.org ([203.10.76.45]:54929 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S268282AbUIBMj6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Sep 2004 08:39:58 -0400
Date: Thu, 2 Sep 2004 22:37:13 +1000
From: Anton Blanchard <anton@samba.org>
To: akpm@osdl.org
Cc: paulus@samba.org, linux-kernel@vger.kernel.org
Subject: [PATCH] [ppc64] cleanup asm/processor.h
Message-ID: <20040902123713.GD26072@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040803i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Wrap a lot more of processor.h in #ifdef __KERNEL__ / __ASSEMBLY__.
Remove now unised EXC_FRAME_SIZE.

Signed-off-by: Anton Blanchard <anton@samba.org>

===== processor.h 1.51 vs edited =====
--- 1.51/include/asm-ppc64/processor.h	Tue Aug 24 19:08:17 2004
+++ edited/processor.h	Thu Sep  2 22:12:39 2004
@@ -20,12 +20,6 @@
 #include <asm/ptrace.h>
 #include <asm/types.h>
 
-/*
- * Default implementation of macro that returns current
- * instruction pointer ("program counter").
- */
-#define current_text_addr() ({ __label__ _l; _l: &&_l;})
-
 /* Machine State Register (MSR) Fields */
 #define MSR_SF_LG	63              /* Enable 64 bit mode */
 #define MSR_ISF_LG	61              /* Interrupt 64b mode valid on 630 */
@@ -410,6 +404,12 @@
 #define XGLUE(a,b) a##b
 #define GLUE(a,b) XGLUE(a,b)
 
+/* iSeries CTRL register (for runlatch) */
+
+#define CTRLT		0x098
+#define CTRLF		0x088
+#define RUNLATCH	0x0001
+
 #ifdef __ASSEMBLY__
 
 #define _GLOBAL(name) \
@@ -438,8 +438,13 @@
 	.type GLUE(.,name),@function; \
 GLUE(.,name):
 
-#endif /* __ASSEMBLY__ */
+#else /* __ASSEMBLY__ */
 
+/*
+ * Default implementation of macro that returns current
+ * instruction pointer ("program counter").
+ */
+#define current_text_addr() ({ __label__ _l; _l: &&_l;})
 
 /* Macros for setting and retrieving special purpose registers */
 
@@ -461,20 +466,9 @@
 #define mttbl(v)	asm volatile("mttbl %0":: "r"(v))
 #define mttbu(v)	asm volatile("mttbu %0":: "r"(v))
 
-/* iSeries CTRL register (for runlatch) */
-
-#define CTRLT		0x098
-#define CTRLF		0x088
-#define RUNLATCH	0x0001
-
-/* Size of an exception stack frame contained in the paca. */
-#define EXC_FRAME_SIZE 64
-
 #define mfasr()		({unsigned long rval; \
 			asm volatile("mfasr %0" : "=r" (rval)); rval;})
 
-#ifndef __ASSEMBLY__
-
 static inline void set_tb(unsigned int upper, unsigned int lower)
 {
 	mttbl(0);
@@ -485,6 +479,8 @@
 #define __get_SP()	({unsigned long sp; \
 			asm volatile("mr %0,1": "=r" (sp)); sp;})
 
+#ifdef __KERNEL__
+
 extern int have_of;
 
 struct task_struct;
@@ -507,8 +503,6 @@
 extern struct task_struct *last_task_used_math;
 extern struct task_struct *last_task_used_altivec;
 
-
-#ifdef __KERNEL__
 /* 64-bit user address space is 41-bits (2TBs user VM) */
 #define TASK_SIZE_USER64 (0x0000020000000000UL)
 
@@ -520,8 +514,6 @@
 
 #define TASK_SIZE (test_thread_flag(TIF_32BIT) ? \
 		TASK_SIZE_USER32 : TASK_SIZE_USER64)
-#endif /* __KERNEL__ */
-
 
 /* This decides where the kernel will search for a free chunk of vm
  * space during mmap's.
@@ -626,9 +618,11 @@
 
 #define spin_lock_prefetch(x)	prefetchw(x)
 
-#endif /* ASSEMBLY */
-
 #define HAVE_ARCH_PICK_MMAP_LAYOUT
+
+#endif /* __KERNEL__ */
+
+#endif /* __ASSEMBLY__ */
 
 /*
  * Number of entries in the SLB. If this ever changes we should handle
