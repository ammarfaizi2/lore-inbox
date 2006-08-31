Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751577AbWHaCMY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751577AbWHaCMY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 22:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751579AbWHaCMY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 22:12:24 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:55226 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751576AbWHaCMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 22:12:23 -0400
Date: Wed, 30 Aug 2006 22:05:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH][RFC] exception processing in early boot
To: Andi Kleen <ak@suse.de>
Cc: pageexec <pageexec@freemail.hu>,
       linux-kernel <linux-kernel@vger.kernel.org>, Willy Tarreau <w@1wt.eu>
Message-ID: <200608302209_MC3-1-C9E0-28B7@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <200608301830.40994.ak@suse.de>

On Wed, 30 Aug 2006 18:30:40 +0200, Andi Kleen wrote:

> It would be better to separate exceptions from interrupts here.
> A spurious interrupt is not necessarily fatal, just an exception is.
> 
> But I went with the simpler patch with some changes now 
> (added PANIC to the message etc.) 

This is already in -mm:

================================================================================
From: Chuck Ebbert <76306.1226@compuserve.com>

Add early i386 fault handlers with debug information for common faults. 
Handles:

        divide error
        invalid opcode
        protection fault
        page fault

Also adds code to detect early recursive/multiple faults and halt the
system when they happen (taken from x86_64.)

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
Cc: Andi Kleen <ak@muc.de>
Cc: Ingo Molnar <mingo@elte.hu>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/head.S |   67 ++++++++++++++++++++++++++++++++++++++
 1 file changed, 67 insertions(+)

diff -puN arch/i386/kernel/head.S~i386-early-fault-handler arch/i386/kernel/head.S
--- a/arch/i386/kernel/head.S~i386-early-fault-handler
+++ a/arch/i386/kernel/head.S
@@ -371,8 +371,65 @@ rp_sidt:
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
@@ -386,6 +443,9 @@ ignore_int:
 	movl $(__KERNEL_DS),%eax
 	movl %eax,%ds
 	movl %eax,%es
+	cmpl $2,early_recursion_flag
+	je hlt_loop
+	incl early_recursion_flag
 	pushl 16(%esp)
 	pushl 24(%esp)
 	pushl 32(%esp)
@@ -431,9 +491,16 @@ ENTRY(stack_start)
 
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
_
-- 
Chuck
