Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030230AbWASUCK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030230AbWASUCK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Jan 2006 15:02:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030300AbWASUCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Jan 2006 15:02:10 -0500
Received: from fmr17.intel.com ([134.134.136.16]:37537 "EHLO
	orsfmr002.jf.intel.com") by vger.kernel.org with ESMTP
	id S1030230AbWASUCJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Jan 2006 15:02:09 -0500
Date: Thu, 19 Jan 2006 12:02:01 -0800 (PST)
From: Tong Li <tongli@intel.com>
X-X-Sender: tongli@tongli.jf.intel.com
To: phil.el@wanadoo.fr
cc: linux-kernel@vger.kernel.org, tongli@cs.duke.edu
Subject: [PATCH 1/1] OProfile: fixed x86_64 incorrect kernel call graphs
Message-ID: <Pine.LNX.4.64.0601191122281.4881@tongli.jf.intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Tong Li <tong.n.li@intel.com>

This patch fixes the problem in kernel 2.6.15.1 (and early versions) that 
OProfile on x86_64 does not correctly collect the stack traces for kernel 
functions. The original code in valid_kernel_stack() in 
arch/i386/oprofile/backtrace.c assumes that the frame pointer (headaddr) 
should be greater than stack (i.e., regs). This assumption is wrong for 
x86_64 because NMIs in x86_64 use a seperate stack different from the 
kernel stack. Therefore, the variable stack now points to some location on 
the NMI stack, which turns out to be at a higher address than the frame 
pointer (headaddr) on the kernel stack. The correct comparison here should 
be between headaddr and regs->rsp for x86_64.

Signed-off-by: Tong Li <tong.n.li@intel.com>
---
--- linux-2.6.15.1/arch/i386/oprofile/backtrace.c.orig	2006-01-18 22:29:56.000000000 -0800
+++ linux-2.6.15.1/arch/i386/oprofile/backtrace.c	2006-01-19 09:31:32.000000000 -0800
@@ -49,7 +49,9 @@ dump_backtrace(struct frame_head * head)
   * |    stack    |
   * --------------- saved regs->ebp value if valid (frame_head address)
   * .             .
- * --------------- struct pt_regs stored on stack (struct pt_regs *)
+ * --------------- saved regs->rsp value if x86_64
+ * |             |
+ * --------------- struct pt_regs * stored on stack if 32-bit
   * |             |
   * .             .
   * |             |
@@ -57,13 +59,26 @@ dump_backtrace(struct frame_head * head)
   * |             |
   * |             | \/ Lower addresses
   *
- * Thus, &pt_regs <-> stack base restricts the valid(ish) ebp values
+ * Thus, regs (or regs->rsp for x86_64) <-> stack base restricts the 
+ * valid(ish) ebp values. Note: (1) for x86_64, NMI and several other 
+ * exceptions use special stacks, maintained by the interrupt stack table
+ * (IST). These stacks are set up in trap_init() in
+ * arch/x86_64/kernel/traps.c. Thus, for x86_64, regs now does not point 
+ * to the kernel stack; instead, it points to some location on the NMI 
+ * stack. On the other hand, regs->rsp is the stack pointer saved when the 
+ * NMI occurred. (2) For 32-bit, regs->esp is not valid because the
+ * processor does not save %esp on the kernel stack when interrupts occur 
+ * in the kernel mode.
   */
  #ifdef CONFIG_FRAME_POINTER
  static int valid_kernel_stack(struct frame_head * head, struct pt_regs * regs)
  {
  	unsigned long headaddr = (unsigned long)head;
+#ifdef CONFIG_X86_64
+	unsigned long stack = (unsigned long)regs->rsp;
+#else
  	unsigned long stack = (unsigned long)regs;
+#endif
  	unsigned long stack_base = (stack & ~(THREAD_SIZE - 1)) + THREAD_SIZE;

  	return headaddr > stack && headaddr < stack_base;
