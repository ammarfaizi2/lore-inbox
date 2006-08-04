Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161228AbWHDOme@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161228AbWHDOme (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 4 Aug 2006 10:42:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161236AbWHDOme
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 4 Aug 2006 10:42:34 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:934 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S1161228AbWHDOmd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Aug 2006 10:42:33 -0400
Date: Sat, 5 Aug 2006 01:42:00 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com, prasanna@in.ibm.com
Subject: [patch] kprobes-x86_64 : entry.s::error_entry is not safe for kprobes
Message-ID: <20060804201200.GA14739@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the entry.S:error_entry to .kprobes.text section,
since code marked unsafe for kprobes jumps directly to entry.S::error_entry,
that must be marked unsafe as Chuck Ebbert suggested.
This patch also moves all the ".previous.text" asm directives to ".previous"
for kprobes section.

Signed-off-by: Prasanna S.P. <prasanna@in.ibm.com>


 arch/x86_64/kernel/entry.S |   13 +++++++------
 1 files changed, 7 insertions(+), 6 deletions(-)

diff -puN arch/x86_64/kernel/entry.S~kprobes-x86_64-move-error_code-to-kprobes-text-section arch/x86_64/kernel/entry.S
--- linux-2.6.18-rc3/arch/x86_64/kernel/entry.S~kprobes-x86_64-move-error_code-to-kprobes-text-section	2006-08-04 17:09:55.000000000 +0530
+++ linux-2.6.18-rc3-prasanna/arch/x86_64/kernel/entry.S	2006-08-04 17:14:21.000000000 +0530
@@ -813,7 +813,7 @@ paranoid_schedule\trace:
  * Exception entry point. This expects an error code/orig_rax on the stack
  * and the exception handler in %rax.	
  */ 		  				
-ENTRY(error_entry)
+KPROBE_ENTRY(error_entry)
 	_frame RDI
 	/* rdi slot contains rax, oldrax contains error code */
 	cld	
@@ -898,6 +898,7 @@ error_kernelspace:
         je   error_swapgs
 	jmp  error_sti
 END(error_entry)
+	.previous
 	
        /* Reload gs selector with exception handling */
        /* edi:  new selector */ 
@@ -1017,7 +1018,7 @@ ENDPROC(execve)
 KPROBE_ENTRY(page_fault)
 	errorentry do_page_fault
 END(page_fault)
-	.previous .text
+	.previous
 
 ENTRY(coprocessor_error)
 	zeroentry do_coprocessor_error
@@ -1039,7 +1040,7 @@ KPROBE_ENTRY(debug)
 	paranoidentry do_debug, DEBUG_STACK
 	paranoidexit
 END(debug)
-	.previous .text
+	.previous
 
 	/* runs on exception stack */	
 KPROBE_ENTRY(nmi)
@@ -1054,7 +1055,7 @@ KPROBE_ENTRY(nmi)
  	CFI_ENDPROC
 #endif
 END(nmi)
-	.previous .text
+	.previous
 
 KPROBE_ENTRY(int3)
  	INTR_FRAME
@@ -1064,7 +1065,7 @@ KPROBE_ENTRY(int3)
  	jmp paranoid_exit1
  	CFI_ENDPROC
 END(int3)
-	.previous .text
+	.previous
 
 ENTRY(overflow)
 	zeroentry do_overflow
@@ -1113,7 +1114,7 @@ END(stack_segment)
 KPROBE_ENTRY(general_protection)
 	errorentry do_general_protection
 END(general_protection)
-	.previous .text
+	.previous
 
 ENTRY(alignment_check)
 	errorentry do_alignment_check

_
-- 
S.P. Prasanna
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
