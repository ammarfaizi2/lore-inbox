Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751490AbWHJTwe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751490AbWHJTwe (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:52:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751494AbWHJTv7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:51:59 -0400
Received: from ns.suse.de ([195.135.220.2]:20625 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932139AbWHJThS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:18 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [118/145] x86_64: Mark error_entry as forbidden to kprobes
Message-Id: <20060810193717.357B613C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:17 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Prasanna S.P. <prasanna@in.ibm.com>

This patch moves the entry.S:error_entry to .kprobes.text section,
since code marked unsafe for kprobes jumps directly to entry.S::error_entry,
that must be marked unsafe as well.
This patch also moves all the ".previous.text" asm directives to ".previous"
for kprobes section.

AK: Following a similar i386 patch from Chuck Ebbert 

Signed-off-by: Prasanna S.P. <prasanna@in.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>


 arch/x86_64/kernel/entry.S |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -819,7 +819,7 @@ paranoid_schedule\trace:
  * Exception entry point. This expects an error code/orig_rax on the stack
  * and the exception handler in %rax.	
  */ 		  				
-ENTRY(error_entry)
+KPROBE_ENTRY(error_entry)
 	_frame RDI
 	/* rdi slot contains rax, oldrax contains error code */
 	cld	
@@ -904,6 +904,7 @@ error_kernelspace:
         je   error_swapgs
 	jmp  error_sti
 END(error_entry)
+	.previous
 	
        /* Reload gs selector with exception handling */
        /* edi:  new selector */ 
@@ -1023,7 +1024,7 @@ ENDPROC(execve)
 KPROBE_ENTRY(page_fault)
 	errorentry do_page_fault
 END(page_fault)
-	.previous .text
+	.previous
 
 ENTRY(coprocessor_error)
 	zeroentry do_coprocessor_error
@@ -1045,7 +1046,7 @@ KPROBE_ENTRY(debug)
 	paranoidentry do_debug, DEBUG_STACK
 	paranoidexit
 END(debug)
-	.previous .text
+	.previous
 
 	/* runs on exception stack */	
 KPROBE_ENTRY(nmi)
@@ -1060,7 +1061,7 @@ KPROBE_ENTRY(nmi)
  	CFI_ENDPROC
 #endif
 END(nmi)
-	.previous .text
+	.previous
 
 KPROBE_ENTRY(int3)
  	INTR_FRAME
@@ -1070,7 +1071,7 @@ KPROBE_ENTRY(int3)
  	jmp paranoid_exit1
  	CFI_ENDPROC
 END(int3)
-	.previous .text
+	.previous
 
 ENTRY(overflow)
 	zeroentry do_overflow
@@ -1119,7 +1120,7 @@ END(stack_segment)
 KPROBE_ENTRY(general_protection)
 	errorentry do_general_protection
 END(general_protection)
-	.previous .text
+	.previous
 
 ENTRY(alignment_check)
 	errorentry do_alignment_check
