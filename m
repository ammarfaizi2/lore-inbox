Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268305AbUIKUoc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268305AbUIKUoc (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268114AbUIKUoc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:44:32 -0400
Received: from hcc022004.bai.ne.jp ([210.171.22.4]:35209 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S268305AbUIKUnw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:43:52 -0400
Date: Sun, 12 Sep 2004 05:43:50 +0900 (JST)
Message-Id: <20040912.054350.846936276.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm4 1/6] [m32r] Update for profiling
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
In-Reply-To: <20040912.052403.730551818.takata@linux-m32r.org>
References: <20040912.052403.730551818.takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc1-mm4 1/6] [m32r] Update for profiling
  This patch is for profiling support. 
  profile_tick() is used instead of m32r_do_profile().

	* arch/m32r/kernel/smp.c
	(smp_local_timer_interrupt): Change profile API, use profile_tick()
	instead of m32r_do_profile().

	* arch/m32r/kernel/time.c: ditto.

	* include/asm-m32r/hw_irq.h (m32r_do_profile): Removed.

	* include/asm-m32r/ptrace.h (profile_pc): Add profile_pc() macro.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/smp.c    |   10 ++++------
 arch/m32r/kernel/time.c   |    5 ++---
 include/asm-m32r/hw_irq.h |   33 +--------------------------------
 include/asm-m32r/ptrace.h |   14 ++++++++------
 4 files changed, 15 insertions(+), 47 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/smp.c linux-2.6.9-rc1-mm4/arch/m32r/kernel/smp.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/smp.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/kernel/smp.c	2004-09-09 23:07:43.000000000 +0900
@@ -1,8 +1,7 @@
 /*
  *  linux/arch/m32r/kernel/smp.c
- *    orig : i386 2.4.10
  *
- *  MITSUBISHI M32R SMP support routines.
+ *  M32R SMP support routines.
  *
  *  Copyright (c) 2001, 2002  Hitoshi Yamamoto
  *
@@ -14,8 +13,6 @@
  *  later.
  */
 
-/* $Id$ */
-
 #undef DEBUG_SMP
 
 #include <linux/irq.h>
@@ -23,6 +20,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/smp.h>
+#include <linux/profile.h>
 
 #include <asm/cacheflush.h>
 #include <asm/pgalloc.h>
@@ -109,7 +107,7 @@ static void send_IPI_mask(cpumask_t, int
 unsigned long send_IPI_mask_phys(cpumask_t, int, int);
 
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
-/* Rescheduling request Routins                                              */
+/* Rescheduling request Routines                                             */
 /*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*=*/
 
 /*==========================================================================*
@@ -762,7 +760,7 @@ void smp_local_timer_interrupt(struct pt
 	 * useful with a profiling multiplier != 1
 	 */
 
-	m32r_do_profile(regs);
+	profile_tick(CPU_PROFILING, regs);
 
 	if (--per_cpu(prof_counter, cpu_id) <= 0) {
 		/*
diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/time.c linux-2.6.9-rc1-mm4/arch/m32r/kernel/time.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/time.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/kernel/time.c	2004-09-09 23:07:56.000000000 +0900
@@ -15,8 +15,6 @@
  *    Copyright (C) 2000  Philipp Rumpf <prumpf@tux.org>
  */
 
-/* $Id$ */
-
 #undef  DEBUG_TIMER
 
 #include <linux/config.h>
@@ -29,6 +27,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <linux/interrupt.h>
+#include <linux/profile.h>
 
 #include <asm/io.h>
 #include <asm/m32r.h>
@@ -243,7 +242,7 @@ irqreturn_t timer_interrupt(int irq, voi
 	write_sequnlock(&xtime_lock);
 
 #ifndef CONFIG_SMP
-	m32r_do_profile(regs);
+	profile_tick(CPU_PROFILING, regs);
 #endif
 
 	return IRQ_HANDLED;
diff -ruNp linux-2.6.9-rc1-mm4.orig/include/asm-m32r/hw_irq.h linux-2.6.9-rc1-mm4/include/asm-m32r/hw_irq.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/hw_irq.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4/include/asm-m32r/hw_irq.h	2004-09-09 21:10:28.000000000 +0900
@@ -1,40 +1,9 @@
 #ifndef _ASM_M32R_HW_IRQ_H
 #define _ASM_M32R_HW_IRQ_H
 
-/* $Id$ */
-
-#include <linux/profile.h>
-#include <linux/sched.h>
-#include <asm/sections.h>
-
-static __inline__ void hw_resend_irq(struct hw_interrupt_type *h,
-				     unsigned int i)
+static inline void hw_resend_irq(struct hw_interrupt_type *h, unsigned int i)
 {
 	/* Nothing to do */
 }
 
-static __inline__ void m32r_do_profile (struct pt_regs *regs)
-{
-        unsigned long pc = regs->bpc;
-
-        profile_hook(regs);
-
-        if (user_mode(regs))
-                return;
-
-        if (!prof_buffer)
-                return;
-
-        pc -= (unsigned long) &_stext;
-        pc >>= prof_shift;
-        /*
-         * Don't ignore out-of-bounds PC values silently,
-         * put them into the last histogram slot, so if
-         * present, they will show up as a sharp peak.
-         */
-        if (pc > prof_len - 1)
-                pc = prof_len - 1;
-        atomic_inc((atomic_t *)&prof_buffer[pc]);
-}
-
 #endif /* _ASM_M32R_HW_IRQ_H */
diff -ruNp linux-2.6.9-rc1-mm4.orig/include/asm-m32r/ptrace.h linux-2.6.9-rc1-mm4/include/asm-m32r/ptrace.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/ptrace.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4/include/asm-m32r/ptrace.h	2004-09-12 04:41:01.000000000 +0900
@@ -1,14 +1,15 @@
-#ifndef _M32R_PTRACE_H
-#define _M32R_PTRACE_H
-
-/* $Id$ */
+#ifndef _ASM_M32R_PTRACE_H
+#define _ASM_M32R_PTRACE_H
 
 /*
+ * linux/include/asm-m32r/ptrace.h
+ *
  * This file is subject to the terms and conditions of the GNU General Public
  * License.  See the file "COPYING" in the main directory of this archive
  * for more details.
  *
- * Copyright (C) 2001, 2002, 2004  Hirokazu Takata
+ * M32R version:
+ *   Copyright (C) 2001-2002, 2004  Hirokazu Takata <takata at linux-m32r.org>
  */
 
 #include <linux/config.h>
@@ -153,6 +154,7 @@ struct pt_regs {
 #endif
 
 #define instruction_pointer(regs) ((regs)->bpc)
+#define profile_pc(regs) instruction_pointer(regs)
 
 extern void show_regs(struct pt_regs *);
 
@@ -160,4 +162,4 @@ extern void withdraw_debug_trap(struct p
 
 #endif /* __KERNEL */
 
-#endif /* _M32R_PTRACE_H */
+#endif /* _ASM_M32R_PTRACE_H */
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
