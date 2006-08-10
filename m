Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932703AbWHJTnq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932703AbWHJTnq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:43:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932685AbWHJTnQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:43:16 -0400
Received: from cantor2.suse.de ([195.135.220.15]:13036 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932683AbWHJTh2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:28 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [127/145] i386: move kernel_thread_helper into entry.S
Message-Id: <20060810193726.C133F13B8E@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:26 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

And add proper CFI annotation to it which was previously
impossible. This prevents "stuck" messages by the dwarf2 unwinder
when reaching the top of a kernel stack.

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/entry.S   |   15 +++++++++++++++
 arch/i386/kernel/process.c |    9 ---------
 2 files changed, 15 insertions(+), 9 deletions(-)

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -946,6 +946,21 @@ ENTRY(arch_unwind_init_running)
 ENDPROC(arch_unwind_init_running)
 #endif
 
+ENTRY(kernel_thread_helper)
+	CFI_STARTPROC
+	movl %edx,%eax
+	CFI_REGISTER edx,eax
+	push %edx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET edx,0
+	call *%ebx
+	push %eax
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET eax,0
+	call do_exit
+	CFI_ENDPROC
+ENDPROC(kernel_thread_helper)
+
 .section .rodata,"a"
 #include "syscall_table.S"
 
Index: linux/arch/i386/kernel/process.c
===================================================================
--- linux.orig/arch/i386/kernel/process.c
+++ linux/arch/i386/kernel/process.c
@@ -321,15 +321,6 @@ void show_regs(struct pt_regs * regs)
  * the "args".
  */
 extern void kernel_thread_helper(void);
-__asm__(".section .text\n"
-	".align 4\n"
-	"kernel_thread_helper:\n\t"
-	"movl %edx,%eax\n\t"
-	"pushl %edx\n\t"
-	"call *%ebx\n\t"
-	"pushl %eax\n\t"
-	"call do_exit\n"
-	".previous");
 
 /*
  * Create a kernel thread
