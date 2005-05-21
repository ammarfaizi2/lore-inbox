Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261610AbVEUV1z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261610AbVEUV1z (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 May 2005 17:27:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261629AbVEUV1z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 May 2005 17:27:55 -0400
Received: from wildsau.idv.uni.linz.at ([193.170.194.34]:2433 "EHLO
	wildsau.enemy.org") by vger.kernel.org with ESMTP id S261610AbVEUVZL
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 May 2005 17:25:11 -0400
From: Herbert Rosmanith <kernel@wildsau.enemy.org>
Message-Id: <200505212125.j4LLP3s2017196@wildsau.enemy.org>
Subject: [PATCH] binutils-2.16 & kernel-2.6.11.10
To: linux-kernel@vger.kernel.org
Date: Sat, 21 May 2005 23:25:03 +0200 (MET DST)
CC: Herbert Rosmanith <kernel@wildsau.enemy.org>
X-Mailer: ELM [version 2.4ME+ PL100 (25)]
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi,

the "not being able to compile kernel with latest binutils" problem is also
present in 2.6.11.10, at least in:

arch/i386/kernel/process.c
arch/i386/kernel/vm86.c
include/asm-i386/system.h

substituting movl with movw for segreg moves will make it work again,
but I don't know if these are the only files which are probably affected, too.

(by the way - I once found an webpage which allowed viewing LKML in
"realtime", but I've lost the adress - would anyone be so kind and tell
me where I can find this?)


please find the patches below:

--- linux-2.6.11.10.orig/arch/i386/kernel/process.c     2005-05-16 19:50:30.000000000 +0200
+++ linux-2.6.11.10/arch/i386/kernel/process.c  2005-05-21 23:20:44.000000000 +0200
@@ -5,6 +5,9 @@
  *
  *  Pentium III FXSR, SSE support
  *     Gareth Hughes <gareth@valinux.com>, May 2000
+ *
+ * Sat May 21 22:11:22 MEST 2005 herp - Herbert Rosmanith
+ *      minor fixes for as from binutils-2.16
  */
 
 /*
@@ -596,8 +599,8 @@
         * Save away %fs and %gs. No need to save %es and %ds, as
         * those are always kernel segments while inside the kernel.
         */
-       asm volatile("movl %%fs,%0":"=m" (*(int *)&prev->fs));
-       asm volatile("movl %%gs,%0":"=m" (*(int *)&prev->gs));
+       asm volatile("movw %%fs,%0":"=m" (*(int *)&prev->fs));
+       asm volatile("movw %%gs,%0":"=m" (*(int *)&prev->gs));
 
        /*
         * Restore %fs and %gs if needed.
--- linux-2.6.11.10.orig/arch/i386/kernel/vm86.c        2005-05-16 19:50:30.000000000 +0200
+++ linux-2.6.11.10/arch/i386/kernel/vm86.c     2005-05-21 23:10:13.000000000 +0200
@@ -3,6 +3,9 @@
  *
  *  Copyright (C) 1994  Linus Torvalds
  *
+ *  21 may 2005 - make it compile with binutils-2.16.90
+ *                Herbert Rosmanith
+ *
  *  29 dec 2001 - Fixed oopses caused by unchecked access to the vm86
  *                stack - Manfred Spraul <manfreds@colorfullife.com>
  *
@@ -309,8 +312,8 @@
  */
        info->regs32->eax = 0;
        tsk->thread.saved_esp0 = tsk->thread.esp0;
-       asm volatile("movl %%fs,%0":"=m" (tsk->thread.saved_fs));
-       asm volatile("movl %%gs,%0":"=m" (tsk->thread.saved_gs));
+       asm volatile("movw %%fs,%0":"=m" (tsk->thread.saved_fs));
+       asm volatile("movw %%gs,%0":"=m" (tsk->thread.saved_gs));
 
        tss = &per_cpu(init_tss, get_cpu());
        tsk->thread.esp0 = (unsigned long) &info->VM86_TSS_ESP0;
--- linux-2.6.11.10.orig/include/asm-i386/system.h      2005-05-16 19:51:12.000000000 +0200
+++ linux-2.6.11.10/include/asm/system.h        2005-05-21 22:48:48.000000000 +0200
@@ -81,7 +81,7 @@
 #define loadsegment(seg,value)                 \
        asm volatile("\n"                       \
                "1:\t"                          \
-               "movl %0,%%" #seg "\n"          \
+               "movw %0,%%" #seg "\n"          \
                "2:\n"                          \
                ".section .fixup,\"ax\"\n"      \
                "3:\t"                          \
@@ -99,7 +99,7 @@
  * Save a segment register away
  */
 #define savesegment(seg, value) \
-       asm volatile("movl %%" #seg ",%0":"=m" (*(int *)&(value)))
+       asm volatile("movw %%" #seg ",%0":"=m" (*(int *)&(value)))
 
 /*
  * Clear and set 'TS' bit respectively

