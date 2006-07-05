Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964824AbWGELs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964824AbWGELs6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jul 2006 07:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964825AbWGELs6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jul 2006 07:48:58 -0400
Received: from liaag1ag.mx.compuserve.com ([149.174.40.33]:42402 "EHLO
	liaag1ag.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S964824AbWGELs5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jul 2006 07:48:57 -0400
Date: Wed, 5 Jul 2006 07:44:53 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: early pagefault handler
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607050745_MC3-1-C42B-9937@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Page faults during kernel initialization can be hard to diagnose.

Add a handler that prints the fault address, EIP and top of stack
when an early page fault happens.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

 arch/i386/kernel/head.S |   37 +++++++++++++++++++++++++++++++++++++
 1 files changed, 37 insertions(+)

--- 2.6.17-nb.orig/arch/i386/kernel/head.S
+++ 2.6.17-nb/arch/i386/kernel/head.S
@@ -378,8 +378,41 @@ rp_sidt:
 	addl $8,%edi
 	dec %ecx
 	jne rp_sidt
+
+	lea page_fault,%edi	/* early page fault handler */
+	movw %di,%ax
+	andl $0x0000ffff,%edx
+	andl $0xffff0000,%edi
+	orl %edi,%edx
+	lea idt_table,%edi
+	movl %eax,8*14(%edi)
+	movl %edx,8*14+4(%edi)
+
 	ret
 
+/* This is the early page fault handler */
+	ALIGN
+page_fault:
+	cld
+#ifdef CONFIG_PRINTK
+	movl $(__KERNEL_DS),%eax
+	movl %eax,%ds
+	movl %eax,%es
+	movl %cr2,%eax
+	pushl %eax
+	pushl $pf_msg
+#ifdef CONFIG_EARLY_PRINTK
+	call early_printk
+#else
+	call printk
+#endif
+#endif
+hlt_loop:
+	hlt
+1:
+	rep ; nop
+	jmp 1b
+
 /* This is the default interrupt "handler" :-) */
 	ALIGN
 ignore_int:
@@ -441,6 +474,10 @@ ready:	.byte 0
 int_msg:
 	.asciz "Unknown interrupt or fault at EIP %p %p %p\n"
 
+pf_msg:
+	.ascii "Pg flt: CR2 %p  err %p  EIP %p  CS %p  flags %p\n"
+	.asciz "   Stk: %p %p %p %p %p %p %p %p\n"
+
 /*
  * The IDT and GDT 'descriptors' are a strange 48-bit object
  * only used by the lidt and lgdt instructions. They are not
-- 
Chuck
 "You can't read a newspaper if you can't read."  --George W. Bush
