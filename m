Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932666AbWHJTit@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932666AbWHJTit (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 15:38:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932689AbWHJTic
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:38:32 -0400
Received: from ns2.suse.de ([195.135.220.15]:21996 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932666AbWHJThi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:37:38 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [137/145] i386: KPROBE_ENTRY ends up putting code into .fixup
Message-Id: <20060810193737.62EA113C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:37:37 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Jeremy Fitzhardinge <jeremy@goop.org>

KPROBE_ENTRY does a .section .kprobes.text, and expects its users to
do a .previous at the end of the function.

Unfortunately, if any code within the function switches sections, for
example .fixup, then the .previous ends up putting all subsequent code
into .fixup.  Worse, any subsequent .fixup code gets intermingled with
the code its supposed to be fixing (which is also in .fixup).  It's
surprising this didn't cause more havok.

The fix is to use .pushsection/.popsection, so this stuff nests
properly.  A further cleanup would be to get rid of all
.section/.previous pairs, since they're inherently fragile.

Signed-off-by: Jeremy Fitzhardinge <jeremy@goop.org>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/i386/kernel/entry.S   |    8 ++++----
 arch/x86_64/kernel/entry.S |   12 ++++++------
 include/linux/linkage.h    |    2 +-
 3 files changed, 11 insertions(+), 11 deletions(-)

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -639,7 +639,7 @@ error_code:
 	call *%edi
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+.popsection
 
 ENTRY(coprocessor_error)
 	RING0_INT_FRAME
@@ -715,7 +715,7 @@ debug_stack_correct:
 	call do_debug
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+.popsection
 
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
@@ -812,7 +812,7 @@ KPROBE_ENTRY(int3)
 	call do_int3
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+.popsection
 
 ENTRY(overflow)
 	RING0_INT_FRAME
@@ -877,7 +877,7 @@ KPROBE_ENTRY(general_protection)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
-.previous
+.popsection
 
 ENTRY(alignment_check)
 	RING0_EC_FRAME
Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -904,7 +904,7 @@ error_kernelspace:
         je   error_swapgs
 	jmp  error_sti
 END(error_entry)
-	.previous
+	.popsection
 	
        /* Reload gs selector with exception handling */
        /* edi:  new selector */ 
@@ -1024,7 +1024,7 @@ ENDPROC(execve)
 KPROBE_ENTRY(page_fault)
 	errorentry do_page_fault
 END(page_fault)
-	.previous
+	.popsection
 
 ENTRY(coprocessor_error)
 	zeroentry do_coprocessor_error
@@ -1046,7 +1046,7 @@ KPROBE_ENTRY(debug)
 	paranoidentry do_debug, DEBUG_STACK
 	paranoidexit
 END(debug)
-	.previous
+	.popsection
 
 	/* runs on exception stack */	
 KPROBE_ENTRY(nmi)
@@ -1061,7 +1061,7 @@ KPROBE_ENTRY(nmi)
  	CFI_ENDPROC
 #endif
 END(nmi)
-	.previous
+	.popsection
 
 KPROBE_ENTRY(int3)
  	INTR_FRAME
@@ -1071,7 +1071,7 @@ KPROBE_ENTRY(int3)
  	jmp paranoid_exit1
  	CFI_ENDPROC
 END(int3)
-	.previous
+	.popsection
 
 ENTRY(overflow)
 	zeroentry do_overflow
@@ -1120,7 +1120,7 @@ END(stack_segment)
 KPROBE_ENTRY(general_protection)
 	errorentry do_general_protection
 END(general_protection)
-	.previous
+	.popsection
 
 ENTRY(alignment_check)
 	errorentry do_alignment_check
Index: linux/include/linux/linkage.h
===================================================================
--- linux.orig/include/linux/linkage.h
+++ linux/include/linux/linkage.h
@@ -35,7 +35,7 @@
 #endif
 
 #define KPROBE_ENTRY(name) \
-  .section .kprobes.text, "ax"; \
+  .pushsection .kprobes.text, "ax"; \
   ENTRY(name)
 
 #ifndef END
