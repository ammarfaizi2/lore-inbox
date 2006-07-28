Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161206AbWG1R4L@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161206AbWG1R4L (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 13:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161208AbWG1R4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 13:56:11 -0400
Received: from liaag1aa.mx.compuserve.com ([149.174.40.27]:43695 "EHLO
	liaag1aa.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1161206AbWG1R4G (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 13:56:06 -0400
Date: Fri, 28 Jul 2006 13:50:43 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: [patch 2/2] i386: use new CFI macros in entry.S
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       Jan Beulich <jbeulich@novell.com>, Linus Torvalds <torvalds@osdl.org>
Message-ID: <200607281353_MC3-1-C662-536E@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Convert part of i386 entry.S to use macros instead of
open-coding CFI annotations.

Also fixes bug in ret_from_fork where annotation was wrong.

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>

---

 arch/i386/kernel/entry.S |   74 ++++++++++++-----------------------------------
 1 files changed, 20 insertions(+), 54 deletions(-)

--- 2.6.18-rc2-32.orig/arch/i386/kernel/entry.S
+++ 2.6.18-rc2-32/arch/i386/kernel/entry.S
@@ -100,67 +100,35 @@ VM_MASK		= 0x00020000
 
 #define SAVE_ALL \
 	cld; \
-	pushl %es; \
-	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_pushl %es; \
 	/*CFI_REL_OFFSET es, 0;*/\
-	pushl %ds; \
-	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_pushl %ds; \
 	/*CFI_REL_OFFSET ds, 0;*/\
-	pushl %eax; \
-	CFI_ADJUST_CFA_OFFSET 4;\
-	CFI_REL_OFFSET eax, 0;\
-	pushl %ebp; \
-	CFI_ADJUST_CFA_OFFSET 4;\
-	CFI_REL_OFFSET ebp, 0;\
-	pushl %edi; \
-	CFI_ADJUST_CFA_OFFSET 4;\
-	CFI_REL_OFFSET edi, 0;\
-	pushl %esi; \
-	CFI_ADJUST_CFA_OFFSET 4;\
-	CFI_REL_OFFSET esi, 0;\
-	pushl %edx; \
-	CFI_ADJUST_CFA_OFFSET 4;\
-	CFI_REL_OFFSET edx, 0;\
-	pushl %ecx; \
-	CFI_ADJUST_CFA_OFFSET 4;\
-	CFI_REL_OFFSET ecx, 0;\
-	pushl %ebx; \
-	CFI_ADJUST_CFA_OFFSET 4;\
-	CFI_REL_OFFSET ebx, 0;\
+	CFI_pushl_reg eax; \
+	CFI_pushl_reg ebp; \
+	CFI_pushl_reg edi; \
+	CFI_pushl_reg esi; \
+	CFI_pushl_reg edx; \
+	CFI_pushl_reg ecx; \
+	CFI_pushl_reg ebx; \
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es;
 
 #define RESTORE_INT_REGS \
-	popl %ebx;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
-	CFI_RESTORE ebx;\
-	popl %ecx;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
-	CFI_RESTORE ecx;\
-	popl %edx;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
-	CFI_RESTORE edx;\
-	popl %esi;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
-	CFI_RESTORE esi;\
-	popl %edi;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
-	CFI_RESTORE edi;\
-	popl %ebp;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
-	CFI_RESTORE ebp;\
-	popl %eax;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
-	CFI_RESTORE eax
+	CFI_popl_reg ebx;	\
+	CFI_popl_reg ecx;	\
+	CFI_popl_reg edx;	\
+	CFI_popl_reg esi;	\
+	CFI_popl_reg edi;	\
+	CFI_popl_reg ebp;	\
+	CFI_popl_reg eax;	\
 
 #define RESTORE_REGS	\
 	RESTORE_INT_REGS; \
-1:	popl %ds;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
+1:	CFI_popl %ds;	\
 	/*CFI_RESTORE ds;*/\
-2:	popl %es;	\
-	CFI_ADJUST_CFA_OFFSET -4;\
+2:	CFI_popl %es;	\
 	/*CFI_RESTORE es;*/\
 .section .fixup,"ax";	\
 3:	movl $0,(%esp);	\
@@ -203,12 +171,10 @@ VM_MASK		= 0x00020000
 
 ENTRY(ret_from_fork)
 	CFI_STARTPROC
-	pushl %eax
-	CFI_ADJUST_CFA_OFFSET -4
+	CFI_pushl %eax
 	call schedule_tail
 	GET_THREAD_INFO(%ebp)
-	popl %eax
-	CFI_ADJUST_CFA_OFFSET -4
+	CFI_popl %eax
 	jmp syscall_exit
 	CFI_ENDPROC
 
-- 
Chuck
