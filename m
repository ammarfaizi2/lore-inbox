Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965065AbWDNERU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965065AbWDNERU (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 00:17:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751215AbWDNERU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 00:17:20 -0400
Received: from mail.renesas.com ([202.234.163.13]:55022 "EHLO
	mail04.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1751110AbWDNERT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 00:17:19 -0400
Date: Fri, 14 Apr 2006 13:17:15 +0900 (JST)
Message-Id: <20060414.131715.1025223376.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, gniibe@fsij.org, takata@linux-m32r.org
Subject: [PATCH 2.6.17-rc1-mm2] m32r: update switch_to macro for tuning
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch updates include/asm-m32r/system.h.
- Remove unnecessary push/pop's of the switch_to() macro
  for performance tuning.
- Cosmetic updates: change __inline__ to inline, etc.

Please apply.

Thanks,

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
Cc: NIIBE Yutaka <gniibe@fsij.org>
---

 arch/m32r/kernel/entry.S  |    6 ++--
 include/asm-m32r/system.h |   67 +++++++++++++++-------------------------------
 2 files changed, 26 insertions(+), 47 deletions(-)

Index: linux-2.6.17-rc1-mm2/include/asm-m32r/system.h
===================================================================
--- linux-2.6.17-rc1-mm2.orig/include/asm-m32r/system.h	2006-04-13 19:21:47.790810529 +0900
+++ linux-2.6.17-rc1-mm2/include/asm-m32r/system.h	2006-04-13 19:25:46.501136175 +0900
@@ -6,8 +6,8 @@
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001  by Hiroyuki Kondo, Hirokazu Takata, and Hitoshi Yamamoto
- * Copyright (C) 2004  Hirokazu Takata <takata at linux-m32r.org>
+ * Copyright (C) 2001  Hiroyuki Kondo, Hirokazu Takata, and Hitoshi Yamamoto
+ * Copyright (C) 2004, 2006  Hirokazu Takata <takata at linux-m32r.org>
  */
 
 #include <linux/config.h>
@@ -19,49 +19,28 @@
  * switch_to(prev, next) should switch from task `prev' to `next'
  * `prev' will never be the same as `next'.
  *
- * `next' and `prev' should be struct task_struct, but it isn't always defined
+ * `next' and `prev' should be task_t, but it isn't always defined
  */
 
 #define switch_to(prev, next, last)  do { \
-	register unsigned long  arg0 __asm__ ("r0") = (unsigned long)prev; \
-	register unsigned long  arg1 __asm__ ("r1") = (unsigned long)next; \
-	register unsigned long  *oldsp __asm__ ("r2") = &(prev->thread.sp); \
-	register unsigned long  *newsp __asm__ ("r3") = &(next->thread.sp); \
-	register unsigned long  *oldlr __asm__ ("r4") = &(prev->thread.lr); \
-	register unsigned long  *newlr __asm__ ("r5") = &(next->thread.lr); \
-	register struct task_struct  *__last __asm__ ("r6"); \
 	__asm__ __volatile__ ( \
-		"st     r8, @-r15                                 \n\t" \
-		"st     r9, @-r15                                 \n\t" \
-		"st    r10, @-r15                                 \n\t" \
-		"st    r11, @-r15                                 \n\t" \
-		"st    r12, @-r15                                 \n\t" \
-		"st    r13, @-r15                                 \n\t" \
-		"st    r14, @-r15                                 \n\t" \
-		"seth  r14, #high(1f)                             \n\t" \
-		"or3   r14, r14, #low(1f)                         \n\t" \
-		"st    r14, @r4    ; store old LR                 \n\t" \
-		"st    r15, @r2    ; store old SP                 \n\t" \
-		"ld    r15, @r3    ; load new SP                  \n\t" \
-		"st     r0, @-r15  ; store 'prev' onto new stack  \n\t" \
-		"ld    r14, @r5    ; load new LR                  \n\t" \
-		"jmp   r14                                        \n\t" \
-		".fillinsn                                        \n  " \
-		"1:                                               \n\t" \
-		"ld     r6, @r15+  ; load 'prev' from new stack   \n\t" \
-		"ld    r14, @r15+                                 \n\t" \
-		"ld    r13, @r15+                                 \n\t" \
-		"ld    r12, @r15+                                 \n\t" \
-		"ld    r11, @r15+                                 \n\t" \
-		"ld    r10, @r15+                                 \n\t" \
-		"ld     r9, @r15+                                 \n\t" \
-		"ld     r8, @r15+                                 \n\t" \
-		: "=&r" (__last) \
-		: "r" (arg0), "r" (arg1), "r" (oldsp), "r" (newsp), \
-		  "r" (oldlr), "r" (newlr) \
-		: "memory" \
+		"	seth	lr, #high(1f)				\n" \
+		"	or3	lr, lr, #low(1f)			\n" \
+		"	st	lr, @%4  ; store old LR			\n" \
+		"	ld	lr, @%5  ; load new LR			\n" \
+		"	st	sp, @%2  ; store old SP			\n" \
+		"	ld	sp, @%3  ; load new SP			\n" \
+		"	push	%1  ; store `prev' on new stack		\n" \
+		"	jmp	lr					\n" \
+		"	.fillinsn					\n" \
+		"1:							\n" \
+		"	pop	%0  ; restore `__last' from new stack	\n" \
+		: "=r" (last) \
+		: "0" (prev), \
+		  "r" (&(prev->thread.sp)), "r" (&(next->thread.sp)), \
+		  "r" (&(prev->thread.lr)), "r" (&(next->thread.lr)) \
+		: "memory", "lr" \
 	); \
-	last = __last; \
 } while(0)
 
 /*
@@ -167,8 +146,8 @@ extern void  __xchg_called_with_bad_poin
 #define DCACHE_CLEAR(reg0, reg1, addr)
 #endif	/* CONFIG_CHIP_M32700_TS1 */
 
-static __inline__ unsigned long __xchg(unsigned long x, volatile void * ptr,
-	int size)
+static inline unsigned long
+__xchg(unsigned long x, volatile void * ptr, int size)
 {
 	unsigned long flags;
 	unsigned long tmp = 0;
@@ -220,7 +199,7 @@ static __inline__ unsigned long __xchg(u
 
 #define __HAVE_ARCH_CMPXCHG	1
 
-static __inline__ unsigned long
+static inline unsigned long
 __cmpxchg_u32(volatile unsigned int *p, unsigned int old, unsigned int new)
 {
 	unsigned long flags;
@@ -254,7 +233,7 @@ __cmpxchg_u32(volatile unsigned int *p, 
    if something tries to do an invalid cmpxchg().  */
 extern void __cmpxchg_called_with_bad_pointer(void);
 
-static __inline__ unsigned long
+static inline unsigned long
 __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
 {
 	switch (size) {
Index: linux-2.6.17-rc1-mm2/arch/m32r/kernel/entry.S
===================================================================
--- linux-2.6.17-rc1-mm2.orig/arch/m32r/kernel/entry.S	2006-04-13 19:21:47.804808319 +0900
+++ linux-2.6.17-rc1-mm2/arch/m32r/kernel/entry.S	2006-04-13 19:22:52.901534071 +0900
@@ -132,7 +132,7 @@ VM_MASK		= 0x00020000
 #endif
 
 ENTRY(ret_from_fork)
-	ld	r0, @sp+
+	pop	r0
 	bl	schedule_tail
 	GET_THREAD_INFO(r8)
 	bra	syscall_exit
@@ -310,7 +310,7 @@ ENTRY(ei_handler)
 ;    GET_ICU_STATUS;
 	seth	r0, #shigh(M32R_ICU_ISTS_ADDR)
 	ld	r0, @(low(M32R_ICU_ISTS_ADDR),r0)
-	st	r0, @-sp
+	push	r0
 #if defined(CONFIG_SMP)
 	/*
 	 * If IRQ == 0      --> Nothing to do,  Not write IMASK
@@ -547,7 +547,7 @@ check_end:
 #endif  /* CONFIG_PLAT_M32104UT */
 	bl	do_IRQ
 #endif  /* CONFIG_SMP */
-	ld	r14, @sp+
+	pop	r14
 	seth	r0, #shigh(M32R_ICU_IMASK_ADDR)
 	st	r14, @(low(M32R_ICU_IMASK_ADDR),r0)
 #else

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
