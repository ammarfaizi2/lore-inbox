Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262996AbVBDKC3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262996AbVBDKC3 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Feb 2005 05:02:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262554AbVBDKC3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Feb 2005 05:02:29 -0500
Received: from ozlabs.org ([203.10.76.45]:7306 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262768AbVBDKCW (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Feb 2005 05:02:22 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16899.18272.672623.846081@cargo.ozlabs.ibm.com>
Date: Fri, 4 Feb 2005 20:58:56 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: dwmw2@infradead.org, torvalds@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 correct return code in syscall auditing
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from David Woodhouse <dwmw2@infradead.org>.

We were pretending that every syscall returned zero. Don't do that.

Signed-Off-By: David Woodhouse <dwmw2@infradead.org>
Signed-off-by: Paul Mackerras <paulus@samba.org>

===== arch/ppc64/kernel/entry.S 1.51 vs edited =====
--- 1.51/arch/ppc64/kernel/entry.S	Thu Jan 13 09:48:36 2005
+++ edited/arch/ppc64/kernel/entry.S	Thu Jan 20 16:14:50 2005
@@ -231,6 +231,7 @@
 syscall_exit_trace:
 	std	r3,GPR3(r1)
 	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_syscall_trace_leave
 	REST_NVGPRS(r1)
 	ld	r3,GPR3(r1)
@@ -324,6 +325,7 @@
 	ld	r4,TI_FLAGS(r4)
 	andi.	r4,r4,(_TIF_SYSCALL_T_OR_A|_TIF_SINGLESTEP)
 	beq+	81f
+	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.do_syscall_trace_leave
 81:	b	.ret_from_except
 
===== arch/ppc64/kernel/ptrace.c 1.13 vs edited =====
--- 1.13/arch/ppc64/kernel/ptrace.c	Fri Dec 17 08:09:09 2004
+++ edited/arch/ppc64/kernel/ptrace.c	Thu Jan 20 16:24:12 2005
@@ -313,10 +313,10 @@
 		do_syscall_trace();
 }
 
-void do_syscall_trace_leave(void)
+void do_syscall_trace_leave(struct pt_regs *regs)
 {
 	if (unlikely(current->audit_context))
-		audit_syscall_exit(current, 0);	/* FIXME: pass pt_regs */
+		audit_syscall_exit(current, regs->result);
 
 	if ((test_thread_flag(TIF_SYSCALL_TRACE)
 	     || test_thread_flag(TIF_SINGLESTEP))
