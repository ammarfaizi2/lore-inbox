Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751178AbWHPNtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751178AbWHPNtm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 09:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751176AbWHPNtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 09:49:42 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:26559 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751178AbWHPNtl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 09:49:41 -0400
Date: Wed, 16 Aug 2006 19:19:32 +0530
From: "S. P. Prasanna" <prasanna@in.ibm.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Jan Beulich <jbeulich@novell.com>,
       jeremy@goop.org, Andi Kleen <ak@muc.de>, ananth@in.ibm.com,
       anil.s.keshavamurthy@intel.com
Subject: Kprobes - i386 add KPROBE_END macro for .popsection
Message-ID: <20060816134932.GA28965@in.ibm.com>
Reply-To: prasanna@in.ibm.com
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch add a macro KPROBE_END() to add .popsection after each
KPROBE_ENTRY() usage, as suggested by Jan Beulich. This patch also
replace .popsection with the KPROBE_END() macro.
This will be helpful for the conversions like the recent
 .section -> .pushsection and .previous -> .popsection to be
confined to the header defining these macros, without need to touch
any assembly files.

Signed-off-by: Prasanna S. P. <prasanna@in.ibm.com>


 arch/i386/kernel/entry.S |   10 +++++-----
 include/linux/linkage.h  |    4 ++++
 2 files changed, 9 insertions(+), 5 deletions(-)

diff -puN arch/i386/kernel/entry.S~kprobes-add-popsection-macro-for-assembly-stub arch/i386/kernel/entry.S
--- linux-2.6.18-rc4-mm1/arch/i386/kernel/entry.S~kprobes-add-popsection-macro-for-assembly-stub	2006-08-16 18:27:54.000000000 +0530
+++ linux-2.6.18-rc4-mm1-prasanna/arch/i386/kernel/entry.S	2006-08-16 18:32:53.000000000 +0530
@@ -646,7 +646,7 @@ error_code:
 	call *%edi
 	jmp ret_from_exception
 	CFI_ENDPROC
-.popsection
+KPROBE_END(page_fault)
 
 ENTRY(coprocessor_error)
 	RING0_INT_FRAME
@@ -722,7 +722,7 @@ debug_stack_correct:
 	call do_debug
 	jmp ret_from_exception
 	CFI_ENDPROC
-.popsection
+KPROBE_END(debug)
 
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
@@ -807,7 +807,7 @@ nmi_16bit_stack:
 .section __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
-.previous
+KPROBE_END(nmi)
 
 KPROBE_ENTRY(int3)
 	RING0_INT_FRAME
@@ -819,7 +819,7 @@ KPROBE_ENTRY(int3)
 	call do_int3
 	jmp ret_from_exception
 	CFI_ENDPROC
-.popsection
+KPROBE_END(int3)
 
 ENTRY(overflow)
 	RING0_INT_FRAME
@@ -884,7 +884,7 @@ KPROBE_ENTRY(general_protection)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
-.popsection
+KPROBE_END(general_protection)
 
 ENTRY(alignment_check)
 	RING0_EC_FRAME
diff -puN include/linux/linkage.h~kprobes-add-popsection-macro-for-assembly-stub include/linux/linkage.h
--- linux-2.6.18-rc4-mm1/include/linux/linkage.h~kprobes-add-popsection-macro-for-assembly-stub	2006-08-16 18:28:11.000000000 +0530
+++ linux-2.6.18-rc4-mm1-prasanna/include/linux/linkage.h	2006-08-16 18:31:05.000000000 +0530
@@ -43,6 +43,10 @@
   .size name, .-name
 #endif
 
+#define KPROBE_END(name) \
+   END(name); \
+  .popsection
+
 #ifndef ENDPROC
 #define ENDPROC(name) \
   .type name, @function; \

_
-- 
Prasanna S.P.
Linux Technology Center
India Software Labs, IBM Bangalore
Email: prasanna@in.ibm.com
Ph: 91-80-41776329
