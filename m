Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752073AbWHNVAs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752073AbWHNVAs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Aug 2006 17:00:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752066AbWHNVAs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Aug 2006 17:00:48 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:3237 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1752073AbWHNVAr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Aug 2006 17:00:47 -0400
Date: Mon, 14 Aug 2006 16:56:46 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch] i386: annotate FIX_STACK() and the rest of nmi()
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>
Message-ID: <200608141658_MC3-1-C818-892D@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In i386's entry.S, FIX_STACK() needs annotation because it
replaces the stack pointer.  And the rest of nmi() needs
annotation in order to compile with these new annotations.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---

 arch/i386/kernel/entry.S  |   18 +++++++++++++++---
 include/asm-i386/dwarf2.h |    2 ++
 2 files changed, 17 insertions(+), 3 deletions(-)

--- 2.6.18-rc4-nb.orig/arch/i386/kernel/entry.S
+++ 2.6.18-rc4-nb/arch/i386/kernel/entry.S
@@ -698,9 +698,15 @@ device_not_available_emulate:
 	jne ok;					\
 label:						\
 	movl TSS_sysenter_esp0+offset(%esp),%esp;	\
+	CFI_DEF_CFA esp, 0;			\
+	CFI_UNDEFINED eip;			\
 	pushfl;					\
+	CFI_ADJUST_CFA_OFFSET 4;		\
 	pushl $__KERNEL_CS;			\
-	pushl $sysenter_past_esp
+	CFI_ADJUST_CFA_OFFSET 4;		\
+	pushl $sysenter_past_esp;		\
+	CFI_ADJUST_CFA_OFFSET 4;		\
+	CFI_REL_OFFSET eip, 0
 
 KPROBE_ENTRY(debug)
 	RING0_INT_FRAME
@@ -750,6 +756,7 @@ ENTRY(nmi)
 	cmpl $sysenter_entry,12(%esp)
 	je nmi_debug_stack_check
 nmi_stack_correct:
+	/* We have a RING0_INT_FRAME here */
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
@@ -760,9 +767,12 @@ nmi_stack_correct:
 	CFI_ENDPROC
 
 nmi_stack_fixup:
+	RING0_INT_FRAME
 	FIX_STACK(12,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
+
 nmi_debug_stack_check:
+	/* We have a RING0_INT_FRAME here */
 	cmpw $__KERNEL_CS,16(%esp)
 	jne nmi_stack_correct
 	cmpl $debug,(%esp)
@@ -773,8 +783,10 @@ nmi_debug_stack_check:
 	jmp nmi_stack_correct
 
 nmi_16bit_stack:
-	RING0_INT_FRAME
-	/* create the pointer to lss back */
+	/* We have a RING0_INT_FRAME here.
+	 *
+	 * create the pointer to lss back
+	 */
 	pushl %ss
 	CFI_ADJUST_CFA_OFFSET 4
 	pushl %esp
--- 2.6.18-rc4-nb.orig/include/asm-i386/dwarf2.h
+++ 2.6.18-rc4-nb/include/asm-i386/dwarf2.h
@@ -28,6 +28,7 @@
 #define CFI_RESTORE .cfi_restore
 #define CFI_REMEMBER_STATE .cfi_remember_state
 #define CFI_RESTORE_STATE .cfi_restore_state
+#define CFI_UNDEFINED .cfi_undefined
 
 #else
 
@@ -48,6 +49,7 @@
 #define CFI_RESTORE	ignore
 #define CFI_REMEMBER_STATE ignore
 #define CFI_RESTORE_STATE ignore
+#define CFI_UNDEFINED ignore
 
 #endif
 
-- 
Chuck
