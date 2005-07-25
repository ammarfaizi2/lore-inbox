Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261235AbVGYXDy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261235AbVGYXDy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Jul 2005 19:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261212AbVGYXDu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Jul 2005 19:03:50 -0400
Received: from siaag1af.compuserve.com ([149.174.40.8]:2744 "EHLO
	siaag1af.compuserve.com") by vger.kernel.org with ESMTP
	id S261235AbVGYXC3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Jul 2005 19:02:29 -0400
Date: Mon, 25 Jul 2005 18:59:19 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2.6.13-rc3] i386: clean up user_mode macros
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Vincent Hanquez <vincent.hanquez@cl.cam.ac.uk>, Andi Kleen <ak@suse.de>
Message-ID: <200507251901_MC3-1-A589-A433@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Recent patches from the Xen group changed the X86 user_mode macros.

This patch does the following:

        1. Makes the new user_mode() return 0 or 1 (same as x86_64)

        2. Removes conditional jump from user_mode_vm()
           (it's called every timer tick on each CPU on SMP)

I've been running this patch for a while now.  Please apply.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

Index: 2.6.13-rc3a/include/asm-i386/ptrace.h
===================================================================
--- 2.6.13-rc3a.orig/include/asm-i386/ptrace.h	2005-07-13 16:20:26.000000000 -0400
+++ 2.6.13-rc3a/include/asm-i386/ptrace.h	2005-07-14 02:47:51.000000000 -0400
@@ -57,8 +57,8 @@
 #ifdef __KERNEL__
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
-#define user_mode(regs)		(3 & (regs)->xcs)
-#define user_mode_vm(regs)	((VM_MASK & (regs)->eflags) || user_mode(regs))
+#define user_mode(regs)		(!!(3 & (regs)->xcs))
+#define user_mode_vm(regs)	(!!((VM_MASK & (regs)->eflags) | (3 & (regs)->xcs)))
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
 extern unsigned long profile_pc(struct pt_regs *regs);
__
Chuck
