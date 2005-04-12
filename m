Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262182AbVDLTnj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262182AbVDLTnj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 15:43:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262183AbVDLTm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 15:42:59 -0400
Received: from fire.osdl.org ([65.172.181.4]:713 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262182AbVDLKcD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:03 -0400
Message-Id: <200504121031.j3CAVuxc005451@shell0.pdx.osdl.net>
Subject: [patch 081/198] x86_64: Call do_notify_resume unconditionally in entry.S
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, ak@suse.de
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:31:50 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Andi Kleen" <ak@suse.de>

This removes some unnecessary code in the assembly files.

Matches i386 behaviour.

In addition don't clear the work check mask after work has been done.
This fixes some theoretical signal/other event losses.

Signed-off-by: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/arch/x86_64/kernel/entry.S |   26 ++++++++------------------
 1 files changed, 8 insertions(+), 18 deletions(-)

diff -puN arch/x86_64/kernel/entry.S~x86_64-call-do_notify_resume-unconditionally-in-entrys arch/x86_64/kernel/entry.S
--- 25/arch/x86_64/kernel/entry.S~x86_64-call-do_notify_resume-unconditionally-in-entrys	2005-04-12 03:21:22.630696512 -0700
+++ 25-akpm/arch/x86_64/kernel/entry.S	2005-04-12 03:21:22.634695904 -0700
@@ -197,7 +197,7 @@ ENTRY(system_call)
  */		
 	.globl ret_from_sys_call
 ret_from_sys_call:
-	movl $_TIF_WORK_MASK,%edi
+	movl $_TIF_ALLWORK_MASK,%edi
 	/* edi:	flagmask */
 sysret_check:		
 	GET_THREAD_INFO(%rcx)
@@ -223,18 +223,13 @@ sysret_careful:
 	jmp sysret_check
 
 	/* Handle a signal */ 
+	/* edx:	work flags (arg3) */
 sysret_signal:
 	sti
-	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
-	jz    1f
-
-	/* Really a signal */
-	/* edx:	work flags (arg3) */
 	leaq do_notify_resume(%rip),%rax
 	leaq -ARGOFFSET(%rsp),%rdi # &pt_regs -> arg1
 	xorl %esi,%esi # oldset -> arg2
 	call ptregscall_common
-1:	movl $_TIF_NEED_RESCHED,%edi
 	jmp sysret_check
 	
 	/* Do syscall tracing */
@@ -490,8 +485,6 @@ retint_careful:
 	jmp retint_check
 	
 retint_signal:
-	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
-	jz    retint_swapgs
 	sti
 	SAVE_REST
 	movq $-1,ORIG_RAX(%rsp) 			
@@ -500,7 +493,6 @@ retint_signal:
 	call do_notify_resume
 	RESTORE_REST
 	cli
-	movl $_TIF_NEED_RESCHED,%edi
 	GET_THREAD_INFO(%rcx)	
 	jmp retint_check
 
@@ -829,21 +821,19 @@ paranoid_userspace:	
 	cli
 	GET_THREAD_INFO(%rcx)
 	movl threadinfo_flags(%rcx),%edx
+	testl $_TIF_WORK_MASK,%edx
+	jz paranoid_swapgs
 	testl $_TIF_NEED_RESCHED,%edx
 	jnz paranoid_resched
-	testl $(_TIF_SIGPENDING|_TIF_NOTIFY_RESUME|_TIF_SINGLESTEP),%edx
-	jnz paranoid_signal
-	jmp paranoid_swapgs
-paranoid_resched:		
-	sti
-	call schedule
-	jmp paranoid_exit
-paranoid_signal:		
 	sti
 	xorl %esi,%esi /* oldset */
 	movq %rsp,%rdi /* &pt_regs */
 	call do_notify_resume
 	jmp paranoid_exit
+paranoid_resched:
+	sti
+	call schedule
+	jmp paranoid_exit
 	CFI_ENDPROC
 	
 ENTRY(int3)
_
