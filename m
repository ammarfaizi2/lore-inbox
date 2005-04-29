Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262827AbVD2QoC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262827AbVD2QoC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Apr 2005 12:44:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262826AbVD2QnN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Apr 2005 12:43:13 -0400
Received: from fire.osdl.org ([65.172.181.4]:63670 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262827AbVD2Qmk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Apr 2005 12:42:40 -0400
Date: Fri, 29 Apr 2005 09:44:28 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Roland McGrath <roland@redhat.com>
cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] i386: handle iret faults better
In-Reply-To: <200504290340.j3T3eCcO032218@magilla.sf.frob.com>
Message-ID: <Pine.LNX.4.58.0504290941250.18901@ppc970.osdl.org>
References: <200504290340.j3T3eCcO032218@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 28 Apr 2005, Roland McGrath wrote:
>
> I was never very happy with the special-case check for iret_exc either.
> But for the first crack, I went for the fix that didn't touch other
> infrastructure code.
> 
> The fault.c changes here are really not necessary for the bug fix at all,
> it will never be used there.  But to make it a clean infrastructure
> upgrade, I made every caller of fixup_exception consistently pass in the
> complete info it uses for signals in the user-mode case.

I really ended up deciding that we can fix it with a simple one-liner 
instead, which actually simplifies and cleans up the code, instead of 
adding new special cases.

I just committed the appended, which actually removes one line more than 
it adds.

		Linus
-----
commit a879cbbb34cbecfa9707fbb6e5a00c503ac1ecb9
tree fdf247f8dedea8f04d0989aeab6922ed073eee11
parent c06fec5022ebe014af876da2df4a0eee836e97c8
author Linus Torvalds <torvalds@ppc970.osdl.org> Fri, 29 Apr 2005 09:38:44 -0700
committer Linus Torvalds <torvalds@ppc970.osdl.org> Fri, 29 Apr 2005 09:38:44 -0700

    x86: make traps on 'iret' be debuggable in user space

    This makes a trap on the 'iret' that returns us to user space
    cause a nice clean SIGSEGV, instead of just a hard (and silent)
    exit.

    That way a debugger can actually try to see what happened, and
    we also properly notify everybody who might be interested about
    us being gone.

    This loses the error code, but tells the debugger what happened
    with ILL_BADSTK in the siginfo.

--- k/arch/i386/kernel/entry.S  (mode:100644)
+++ l/arch/i386/kernel/entry.S  (mode:100644)
@@ -260,11 +260,9 @@ restore_nocheck:
 .section .fixup,"ax"
 iret_exc:
 	sti
-	movl $__USER_DS, %edx
-	movl %edx, %ds
-	movl %edx, %es
-	movl $11,%eax
-	call do_exit
+	pushl $0			# no error code
+	pushl $do_iret_error
+	jmp error_code
 .previous
 .section __ex_table,"a"
 	.align 4
--- k/arch/i386/kernel/traps.c  (mode:100644)
+++ l/arch/i386/kernel/traps.c  (mode:100644)
@@ -451,6 +451,7 @@ DO_ERROR(10, SIGSEGV, "invalid TSS", inv
 DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, 0)
+DO_ERROR_INFO(32, SIGSEGV, "iret exception", iret_error, ILL_BADSTK, 0)
 
 fastcall void do_general_protection(struct pt_regs * regs, long error_code)
 {
