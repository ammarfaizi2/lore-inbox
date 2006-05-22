Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750809AbWEVNQw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750809AbWEVNQw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750818AbWEVNQv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:16:51 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:2335
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750809AbWEVNQv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:16:51 -0400
Message-Id: <4471D60F.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Mon, 22 May 2006 15:17:35 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: [PATCH 3/6] reliable stack trace support (x86-64 IRQ stack
	adjustment)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the switching to/from the IRQ stack so that unwind annotations can
be added for it without requiring CFA expressions.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: unwind-2.6.17-rc4/arch/x86_64/kernel/entry.S
===================================================================
--- unwind-2.6.17-rc4.orig/arch/x86_64/kernel/entry.S	2006-05-22 15:01:04.000000000 +0200
+++ unwind-2.6.17-rc4/arch/x86_64/kernel/entry.S	2006-05-22 15:01:07.000000000 +0200
@@ -483,16 +483,21 @@ ENTRY(stub_rt_sigreturn)
 #else		
 	SAVE_ARGS
 	leaq -ARGOFFSET(%rsp),%rdi	# arg1 for handler
-#endif	
+#ifdef CONFIG_UNWIND_INFO
+	pushq %rbp
+	CFI_ADJUST_CFA_OFFSET	8
+	CFI_REL_OFFSET		rbp, 0
+	movq %rsp,%rbp
+	CFI_DEF_CFA_REGISTER	rbp
+#endif
+#endif
 	testl $3,CS(%rdi)
 	je 1f
 	swapgs	
 1:	incl	%gs:pda_irqcount	# RED-PEN should check preempt count
-	movq %gs:pda_irqstackptr,%rax
-	cmoveq %rax,%rsp /*todo This needs CFI annotation! */
+	cmoveq %gs:pda_irqstackptr,%rsp
+#if !defined(CONFIG_DEBUG_INFO) && !defined(CONFIG_UNWIND_INFO)
 	pushq %rdi			# save old stack	
-#ifndef CONFIG_DEBUG_INFO
-	CFI_ADJUST_CFA_OFFSET	8
 #endif
 	call \func
 	.endm
@@ -502,17 +507,24 @@ ENTRY(common_interrupt)
 	interrupt do_IRQ
 	/* 0(%rsp): oldrsp-ARGOFFSET */
 ret_from_intr:
+#if !defined(CONFIG_DEBUG_INFO) && !defined(CONFIG_UNWIND_INFO)
 	popq  %rdi
-#ifndef CONFIG_DEBUG_INFO
-	CFI_ADJUST_CFA_OFFSET	-8
 #endif
 	cli	
 	decl %gs:pda_irqcount
 #ifdef CONFIG_DEBUG_INFO
-	movq RBP(%rdi),%rbp
+	movq %rbp, %rsp
 	CFI_DEF_CFA_REGISTER	rsp
+	movq RBP(%rsp),%rbp
+	addq $ARG_OFFSET, %rsp
+	CFI_ADJUST_CFA_OFFSET	-ARG_OFFSET
+#elif defined(CONFIG_UNWIND_INFO)
+	leaveq
+	CFI_DEF_CFA_REGISTER	rsp
+	CFI_ADJUST_CFA_OFFSET	-8
+#else
+	leaq ARGOFFSET(%rdi),%rsp
 #endif
-	leaq ARGOFFSET(%rdi),%rsp /*todo This needs CFI annotation! */
 exit_intr:
 	GET_THREAD_INFO(%rcx)
 	testl $3,CS-ARGOFFSET(%rsp)


