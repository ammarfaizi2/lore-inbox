Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965394AbWIRFZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965394AbWIRFZq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 01:25:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965396AbWIRFZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 01:25:46 -0400
Received: from smtp.osdl.org ([65.172.181.4]:49083 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965394AbWIRFZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 01:25:45 -0400
Date: Sun, 17 Sep 2006 22:25:37 -0700
From: Andrew Morton <akpm@osdl.org>
To: Chuck Ebbert <76306.1226@compuserve.com>
Cc: "In Cognito" <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: Sysenter crash with Nested Task Bit set
Message-Id: <20060917222537.55241d19.akpm@osdl.org>
In-Reply-To: <200609172354_MC3-1-CB7A-58ED@compuserve.com>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.17; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 17 Sep 2006 23:51:45 -0400
Chuck Ebbert <76306.1226@compuserve.com> wrote:

> In-Reply-To: <5a20704e0609171608o7ee45fdbxb94aa897c1776153@mail.gmail.com>
> 
> On Sun, 17 Sep 2006 19:08:24 -0400, "In Cognito" wrote:
> 
> > Here's a way to heat up your cpu and crash the rest of the system too:
> >
> > main(){
> > asm("pushf\n"
> >         "popl %eax\n"
> > /* enable the NT bit */
> >         "orl $0x4000, %eax\n"
> >         "pushl %eax\n"
> >         "popf\n"
> >
> >         "sysenter\n"
> >        );
> > return 0;
> > }
> 
> I'll take your word that it crashes.

It doesn't for me - I get a segfault.

That's on a PIII.  Are recenter CPUs different in this regard?

> 2.6.9 is fine.  I'd guess the iret fixups from 2.6.12 are the problem.
> 
> This doesn't crash for me, but it's probably not quite the right fix:
> 
> Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> ---
>  arch/i386/kernel/traps.c |   12 +++++++++++-
>  1 files changed, 11 insertions(+), 1 deletion(-)
> 
> --- 2.6.18-rc6-nb.orig/arch/i386/kernel/traps.c
> +++ 2.6.18-rc6-nb/arch/i386/kernel/traps.c
> @@ -516,6 +516,16 @@ fastcall void do_##name(struct pt_regs *
>  	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
>  }
>  
> +#define DO_TSS_ERROR(trapnr, signr, str, name) \
> +fastcall void do_##name(struct pt_regs * regs, long error_code) \
> +{ \
> +	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
> +						== NOTIFY_STOP) \
> +		return; \
> +	regs->eflags &= ~X86_EFLAGS_NT; \
> +	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
> +}
> +
>  #define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
>  fastcall void do_##name(struct pt_regs * regs, long error_code) \
>  { \
> @@ -561,7 +571,7 @@ DO_VM86_ERROR( 4, SIGSEGV, "overflow", o
>  DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
>  DO_ERROR_INFO( 6, SIGILL,  "invalid opcode", invalid_op, ILL_ILLOPN, regs->eip)
>  DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)
> -DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
> +DO_TSS_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
>  DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
>  DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
>  DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, 0)
> -- 
> Chuck
