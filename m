Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbWIRD5P@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbWIRD5P (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Sep 2006 23:57:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWIRD5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Sep 2006 23:57:15 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:65233 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751401AbWIRD5O (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Sep 2006 23:57:14 -0400
Date: Sun, 17 Sep 2006 23:51:45 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Sysenter crash with Nested Task Bit set
To: "In Cognito" <defend.the.world@gmail.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Message-ID: <200609172354_MC3-1-CB7A-58ED@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <5a20704e0609171608o7ee45fdbxb94aa897c1776153@mail.gmail.com>

On Sun, 17 Sep 2006 19:08:24 -0400, "In Cognito" wrote:

> Here's a way to heat up your cpu and crash the rest of the system too:
>
> main(){
> asm("pushf\n"
>         "popl %eax\n"
> /* enable the NT bit */
>         "orl $0x4000, %eax\n"
>         "pushl %eax\n"
>         "popf\n"
>
>         "sysenter\n"
>        );
> return 0;
> }

I'll take your word that it crashes.

2.6.9 is fine.  I'd guess the iret fixups from 2.6.12 are the problem.

This doesn't crash for me, but it's probably not quite the right fix:

Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
---
 arch/i386/kernel/traps.c |   12 +++++++++++-
 1 files changed, 11 insertions(+), 1 deletion(-)

--- 2.6.18-rc6-nb.orig/arch/i386/kernel/traps.c
+++ 2.6.18-rc6-nb/arch/i386/kernel/traps.c
@@ -516,6 +516,16 @@ fastcall void do_##name(struct pt_regs *
 	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
 }
 
+#define DO_TSS_ERROR(trapnr, signr, str, name) \
+fastcall void do_##name(struct pt_regs * regs, long error_code) \
+{ \
+	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
+						== NOTIFY_STOP) \
+		return; \
+	regs->eflags &= ~X86_EFLAGS_NT; \
+	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
+}
+
 #define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
 fastcall void do_##name(struct pt_regs * regs, long error_code) \
 { \
@@ -561,7 +571,7 @@ DO_VM86_ERROR( 4, SIGSEGV, "overflow", o
 DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
 DO_ERROR_INFO( 6, SIGILL,  "invalid opcode", invalid_op, ILL_ILLOPN, regs->eip)
 DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)
-DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
+DO_TSS_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
 DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
 DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
 DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, 0)
-- 
Chuck
