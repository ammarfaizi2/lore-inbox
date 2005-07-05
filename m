Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261793AbVGEKRe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261793AbVGEKRe (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 06:17:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261789AbVGEKRe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 06:17:34 -0400
Received: from mx1.redhat.com ([66.187.233.31]:24456 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261793AbVGEKQK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 06:16:10 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <200507050931.j659VFEa028271@magilla.sf.frob.com>
Date: Tue, 5 Jul 2005 02:31:15 -0700
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
X-Fcc: ~/Mail/linus
Subject: [PATCH] x86-64: ptrace ia32 BP fix
X-Shopping-List: (1) Ambitious metric attention
   (2) Recoilless putty
   (3) Pubescent ink
   (4) Expectant heretical aggressors
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


When the 32-bit vDSO is used to make a system call, the %ebp register for
the 6th syscall arg has to be loaded from the user stack (where it's pushed
by the vDSO user code).  The native i386 kernel always does this before
stopping for syscall tracing, so %ebp can be seen and modified via ptrace
to access the 6th syscall argument.  The x86-64 kernel fails to do this,
presenting the stack address to ptrace instead.  This makes the %rbp value
seen by 64-bit ptrace of a 32-bit process, and the %ebp value seen by a
32-bit caller of ptrace, both differ from the native i386 behavior.

This patch fixes the problem by putting the word loaded from the user stack
into %rbp before calling syscall_trace_enter, and reloading the 6th syscall
argument from there afterwards (so ptrace can change it).  This makes the
behavior match that of i386 kernels.

Signed-off-by: Roland McGrath <roland@redhat.com>

--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -102,6 +102,7 @@ sysenter_do_call:	
 	.byte	0xf, 0x35
 
 sysenter_tracesys:
+	movl	%r9d,%ebp
 	SAVE_REST
 	CLEAR_RREGS
 	movq	$-ENOSYS,RAX(%rsp)	/* really needed? */
@@ -109,13 +110,7 @@ sysenter_tracesys:
 	call	syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
-	movl	%ebp, %ebp
-	/* no need to do an access_ok check here because rbp has been
-	   32bit zero extended */ 
-1:	movl	(%rbp),%r9d
-	.section __ex_table,"a"
-	.quad 1b,ia32_badarg
-	.previous
+	movl	%ebp,%r9d
 	jmp	sysenter_do_call
 	CFI_ENDPROC
 
@@ -183,6 +178,7 @@ cstar_do_call:	
 	sysretl
 	
 cstar_tracesys:	
+	movl %r9d,%ebp
 	SAVE_REST
 	CLEAR_RREGS
 	movq $-ENOSYS,RAX(%rsp)	/* really needed? */
@@ -191,12 +187,7 @@ cstar_tracesys:	
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
 	movl RSP-ARGOFFSET(%rsp), %r8d
-	/* no need to do an access_ok check here because r8 has been
-	   32bit zero extended */ 
-1:	movl	(%r8),%r9d
-	.section __ex_table,"a"
-	.quad 1b,ia32_badarg
-	.previous
+	movl %ebp,%r9d
 	jmp cstar_do_call
 				
 ia32_badarg:
