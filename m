Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751529AbWHADoZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751529AbWHADoZ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 23:44:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751560AbWHADoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 23:44:25 -0400
Received: from ns2.suse.de ([195.135.220.15]:52681 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751529AbWHADoY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 23:44:24 -0400
Date: Tue, 01 Aug 2006 05:44:23 +0200
From: "Andi Kleen" <ak@suse.de>
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, discuss@x86-64.org, jbeulich@novell.com
Subject: [PATCH] [1/2] x86_64: Fix backtracing for interrupt stacks
Message-ID: <44cece17.kANEA6Z0OVQWh/fc%ak@suse.de>
User-Agent: nail 11.25 7/29/05
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Readd backlink for old style unwinder to stack switching.
Add proper stack frame and CFI annotations to call_softirq

This prevents a oops when backtracing with fallback through
the interrupt stack top.

Suggested by Jan Beulich and Herbert Xu wanted it in 2.6.18.

Cc: jbeulich@novell.com

Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/entry.S |   18 +++++++++++-------
 1 files changed, 11 insertions(+), 7 deletions(-)

Index: linux-2.6.18-rc3/arch/x86_64/kernel/entry.S
===================================================================
--- linux-2.6.18-rc3.orig/arch/x86_64/kernel/entry.S
+++ linux-2.6.18-rc3/arch/x86_64/kernel/entry.S
@@ -513,6 +513,7 @@ END(stub_rt_sigreturn)
 	swapgs	
 1:	incl	%gs:pda_irqcount	# RED-PEN should check preempt count
 	cmoveq %gs:pda_irqstackptr,%rsp
+	push    %rbp			# backlink for old unwinder
 	/*
 	 * We entered an interrupt context - irqs are off:
 	 */
@@ -1139,18 +1140,21 @@ ENTRY(machine_check)
 END(machine_check)
 #endif
 
+/* Call softirq on interrupt stack. Interrupts are off. */
 ENTRY(call_softirq)
 	CFI_STARTPROC
-	movq %gs:pda_irqstackptr,%rax
-	movq %rsp,%rdx
-	CFI_DEF_CFA_REGISTER	rdx
+	push %rbp
+	CFI_ADJUST_CFA_OFFSET	8
+	CFI_REL_OFFSET rbp,0
+	mov  %rsp,%rbp
+	CFI_DEF_CFA_REGISTER rbp
 	incl %gs:pda_irqcount
-	cmove %rax,%rsp
-	pushq %rdx
-	/*todo CFI_DEF_CFA_EXPRESSION ...*/
+	cmove %gs:pda_irqstackptr,%rsp
+	push  %rbp			# backlink for old unwinder
 	call __do_softirq
-	popq %rsp
+	leaveq
 	CFI_DEF_CFA_REGISTER	rsp
+	CFI_ADJUST_CFA_OFFSET   -8
 	decl %gs:pda_irqcount
 	ret
 	CFI_ENDPROC
