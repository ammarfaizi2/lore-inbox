Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267184AbUIJC1t@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267184AbUIJC1t (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 22:27:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267189AbUIJC1t
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 22:27:49 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:25314 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S267184AbUIJC1q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 22:27:46 -0400
Date: Thu, 9 Sep 2004 22:32:14 -0400 (EDT)
From: Zwane Mwaikambo <zwane@fsmlabs.com>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Cc: Linus Torvalds <torvalds@osdl.org>, Andi Kleen <ak@suse.de>
Subject: [PATCH] lock profiling update for x86_64
Message-ID: <Pine.LNX.4.53.0409091005140.15086@montezuma.fsmlabs.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is based on discussion with Andi regarding the usage of the 
frame pointer or stack pointer when determining the caller of a specific 
lock function.

Tested on emt64

Signed-off-by: Zwane Mwaikambo <zwane@fsmlabs.com>

Index: linux-2.6.9-rc1-mm4-amd64/include/asm-x86_64/ptrace.h
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm4/include/asm-x86_64/ptrace.h,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 ptrace.h
--- linux-2.6.9-rc1-mm4-amd64/include/asm-x86_64/ptrace.h	7 Sep 2004 11:52:00 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm4-amd64/include/asm-x86_64/ptrace.h	9 Sep 2004 13:13:34 -0000
@@ -83,7 +83,7 @@ struct pt_regs {
 #if defined(__KERNEL__) && !defined(__ASSEMBLY__) 
 #define user_mode(regs) (!!((regs)->cs & 3))
 #define instruction_pointer(regs) ((regs)->rip)
-#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
+#ifdef CONFIG_SMP
 extern unsigned long profile_pc(struct pt_regs *regs);
 #else
 #define profile_pc(regs) instruction_pointer(regs)
Index: linux-2.6.9-rc1-mm4-amd64/arch/x86_64/kernel/time.c
===================================================================
RCS file: /home/cvsroot/linux-2.6.9-rc1-mm4/arch/x86_64/kernel/time.c,v
retrieving revision 1.1.1.1
diff -u -p -B -r1.1.1.1 time.c
--- linux-2.6.9-rc1-mm4-amd64/arch/x86_64/kernel/time.c	7 Sep 2004 11:52:00 -0000	1.1.1.1
+++ linux-2.6.9-rc1-mm4-amd64/arch/x86_64/kernel/time.c	9 Sep 2004 14:03:46 -0000
@@ -179,14 +179,14 @@ int do_settimeofday(struct timespec *tv)
 
 EXPORT_SYMBOL(do_settimeofday);
 
-#if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
+#ifdef CONFIG_SMP
 unsigned long profile_pc(struct pt_regs *regs)
 {
 	unsigned long pc = instruction_pointer(regs);
 
 	if (pc >= (unsigned long)&__lock_text_start &&
 	    pc <= (unsigned long)&__lock_text_end)
-		return *(unsigned long *)regs->rbp;
+		return *(unsigned long *)regs->rsp;
 	return pc;
 }
 EXPORT_SYMBOL(profile_pc);
