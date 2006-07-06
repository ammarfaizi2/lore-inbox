Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965085AbWGFANN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965085AbWGFANN (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 20:13:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965087AbWGFANN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 20:13:13 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:50642 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S965085AbWGFANM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 20:13:12 -0400
Date: Wed, 5 Jul 2006 20:10:21 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: early fault handler
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607052011_MC3-1-C43E-CE64@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add early i386 fault handlers with debug information for common
faults. Handles:

        divide error
        invalid opcode
        protection fault
        page fault

Also adds code to detect early recursive/multiple faults and halt
the system when they happen (taken from x86_64.)

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/head.S |   67 ++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 67 insertions(+)

--- 2.6.17-nb.orig/arch/i386/kernel/head.S
+++ 2.6.17-nb/arch/i386/kernel/head.S
@@ -378,8 +378,65 @@ rp_sidt:
 	addl $8,%edi
 	dec %ecx
 	jne rp_sidt
+
+.macro	set_early_handler handler,trapno
+	lea \handler,%edx
+	movl $(__KERNEL_CS << 16),%eax
+	movw %dx,%ax
+	movw $0x8E00,%dx	/* interrupt gate - dpl=0, present */
+	lea idt_table,%edi
+	movl %eax,8*\trapno(%edi)
+	movl %edx,8*\trapno+4(%edi)
+.endm
+
+	set_early_handler handler=early_divide_err,trapno=0
+	set_early_handler handler=early_illegal_opcode,trapno=6
+	set_early_handler handler=early_protection_fault,trapno=13
+	set_early_handler handler=early_page_fault,trapno=14
+
 	ret
 
+early_divide_err:
+	xor %edx,%edx
+	pushl $0	/* fake errcode */
+	jmp early_fault
+
+early_illegal_opcode:
+	movl $6,%edx
+	pushl $0	/* fake errcode */
+	jmp early_fault
+
+early_protection_fault:
+	movl $13,%edx
+	jmp early_fault
+
+early_page_fault:
+	movl $14,%edx
+	jmp early_fault
+
+early_fault:
+	cld
+#ifdef CONFIG_PRINTK
+	movl $(__KERNEL_DS),%eax
+	movl %eax,%ds
+	movl %eax,%es
+	cmpl $2,early_recursion_flag
+	je hlt_loop
+	incl early_recursion_flag
+	movl %cr2,%eax
+	pushl %eax
+	pushl %edx		/* trapno */
+	pushl $fault_msg
+#ifdef CONFIG_EARLY_PRINTK
+	call early_printk
+#else
+	call printk
+#endif
+#endif
+hlt_loop:
+	hlt
+	jmp hlt_loop
+
 /* This is the default interrupt "handler" :-) */
 	ALIGN
 ignore_int:
@@ -393,6 +450,9 @@ ignore_int:
 	movl $(__KERNEL_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
+	cmpl $2,early_recursion_flag
+	je hlt_loop
+	incl early_recursion_flag
 	pushl 16(%esp)
 	pushl 24(%esp)
 	pushl 32(%esp)
@@ -438,9 +498,16 @@ ENTRY(stack_start)
 
 ready:	.byte 0
 
+early_recursion_flag:
+	.long 0
+
 int_msg:
 	.asciz "Unknown interrupt or fault at EIP %p %p %p\n"
 
+fault_msg:
+	.ascii "Int %d: CR2 %p  err %p  EIP %p  CS %p  flags %p\n"
+	.asciz "Stack: %p %p %p %p %p %p %p %p\n"
+
 /*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
  * only used by the lidt and lgdt instructions. They are not
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
