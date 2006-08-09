Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030379AbWHIBSd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030379AbWHIBSd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 21:18:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030393AbWHIBSd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 21:18:33 -0400
Received: from gw.goop.org ([64.81.55.164]:18598 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1030379AbWHIBSc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 21:18:32 -0400
Message-ID: <44D937EE.1020404@goop.org>
Date: Tue, 08 Aug 2006 18:18:38 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.6.18-rc3-mm2] KPROBE_ENTRY ends up putting code into .fixup
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

diff -r 30f9dfcdff81 arch/i386/kernel/entry.S
--- a/arch/i386/kernel/entry.S	Mon Aug 07 16:08:33 2006 -0700
+++ b/arch/i386/kernel/entry.S	Tue Aug 08 17:40:03 2006 -0700
@@ -646,7 +646,7 @@ error_code:
 	call *%edi
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+.popsection
 
 ENTRY(coprocessor_error)
 	RING0_INT_FRAME
@@ -722,7 +722,7 @@ debug_stack_correct:
 	call do_debug
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+.popsection
 
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
@@ -819,7 +819,7 @@ KPROBE_ENTRY(int3)
 	call do_int3
 	jmp ret_from_exception
 	CFI_ENDPROC
-.previous
+.popsection
 
 ENTRY(overflow)
 	RING0_INT_FRAME
@@ -884,7 +884,7 @@ KPROBE_ENTRY(general_protection)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
-.previous
+.popsection
 
 ENTRY(alignment_check)
 	RING0_EC_FRAME
diff -r 30f9dfcdff81 arch/x86_64/kernel/entry.S
--- a/arch/x86_64/kernel/entry.S	Mon Aug 07 16:08:33 2006 -0700
+++ b/arch/x86_64/kernel/entry.S	Tue Aug 08 17:41:13 2006 -0700
@@ -904,7 +904,7 @@ error_kernelspace:
         je   error_swapgs
 	jmp  error_sti
 END(error_entry)
-	.previous
+	.popsection
 	
        /* Reload gs selector with exception handling */
        /* edi:  new selector */ 
@@ -1024,7 +1024,7 @@ KPROBE_ENTRY(page_fault)
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
@@ -1120,7 +1120,7 @@ KPROBE_ENTRY(general_protection)
 KPROBE_ENTRY(general_protection)
 	errorentry do_general_protection
 END(general_protection)
-	.previous
+	.popsection
 
 ENTRY(alignment_check)
 	errorentry do_alignment_check
diff -r 30f9dfcdff81 include/linux/linkage.h
--- a/include/linux/linkage.h	Mon Aug 07 16:08:33 2006 -0700
+++ b/include/linux/linkage.h	Tue Aug 08 17:41:23 2006 -0700
@@ -35,7 +35,7 @@
 #endif
 
 #define KPROBE_ENTRY(name) \
-  .section .kprobes.text, "ax"; \
+  .pushsection .kprobes.text, "ax"; \
   ENTRY(name)
 
 #ifndef END

