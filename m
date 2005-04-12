Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262183AbVDMCZK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262183AbVDMCZK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 22:25:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262179AbVDLToc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:44:32 -0400
Received: from fire.osdl.org ([65.172.181.4]:63944 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262176AbVDLKcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:03 -0400
Message-Id: <200504121031.j3CAVsQc005439@shell0.pdx.osdl.net>
Subject: [patch 078/198] x86_64: Dump stack and prevent recursion on early fault
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:47 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/head.S |    8 ++++++++
 1 files changed, 8 insertions(+)

diff -puN arch/x86_64/kernel/head.S~x86_64-dump-stack-and-prevent-recursion-on-early-fault arch/x86_64/kernel/head.S
--- 25/arch/x86_64/kernel/head.S~x86_64-dump-stack-and-prevent-recursion-on-early-fault	2005-04-12 03:21:22.009790904 -0700
+++ 25-akpm/arch/x86_64/kernel/head.S	2005-04-12 03:21:22.012790448 -0700
@@ -200,14 +200,22 @@ init_rsp:
 	.quad  init_thread_union+THREAD_SIZE-8
 
 ENTRY(early_idt_handler)
+	cmpl $2,early_recursion_flag(%rip)
+	jz  1f
+	incl early_recursion_flag(%rip)
 	xorl %eax,%eax
 	movq 8(%rsp),%rsi	# get rip
 	movq (%rsp),%rdx
 	movq %cr2,%rcx
 	leaq early_idt_msg(%rip),%rdi
 	call early_printk
+	cmpl $2,early_recursion_flag(%rip)
+	jz  1f
+	call dump_stack
 1:	hlt
 	jmp 1b
+early_recursion_flag:
+	.long 0
 
 early_idt_msg:
 	.asciz "PANIC: early exception rip %lx error %lx cr2 %lx\n"
_
