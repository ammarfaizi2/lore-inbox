Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965450AbWIRGc7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965450AbWIRGc7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Sep 2006 02:32:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965474AbWIRGc7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Sep 2006 02:32:59 -0400
Received: from mail.gmx.net ([213.165.64.20]:47754 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S965450AbWIRGc6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Sep 2006 02:32:58 -0400
X-Authenticated: #14349625
Subject: Re: Sysenter crash with Nested Task Bit set
From: Mike Galbraith <efault@gmx.de>
To: Andrew Morton <akpm@osdl.org>
Cc: Chuck Ebbert <76306.1226@compuserve.com>,
       In Cognito <defend.the.world@gmail.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <20060917222537.55241d19.akpm@osdl.org>
References: <200609172354_MC3-1-CB7A-58ED@compuserve.com>
	 <20060917222537.55241d19.akpm@osdl.org>
Content-Type: text/plain
Date: Mon, 18 Sep 2006 08:44:27 +0000
Message-Id: <1158569067.6376.8.camel@Homer.simpson.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.0 
Content-Transfer-Encoding: 7bit
X-Y-GMX-Trusted: 0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2006-09-17 at 22:25 -0700, Andrew Morton wrote:
> On Sun, 17 Sep 2006 23:51:45 -0400
> Chuck Ebbert <76306.1226@compuserve.com> wrote:
> 
> > In-Reply-To: <5a20704e0609171608o7ee45fdbxb94aa897c1776153@mail.gmail.com>
> > 
> > On Sun, 17 Sep 2006 19:08:24 -0400, "In Cognito" wrote:
> > 
> > > Here's a way to heat up your cpu and crash the rest of the system too:
> > >
> > > main(){
> > > asm("pushf\n"
> > >         "popl %eax\n"
> > > /* enable the NT bit */
> > >         "orl $0x4000, %eax\n"
> > >         "pushl %eax\n"
> > >         "popf\n"
> > >
> > >         "sysenter\n"
> > >        );
> > > return 0;
> > > }
> > 
> > I'll take your word that it crashes.
> 
> It doesn't for me - I get a segfault.
> 
> That's on a PIII.  Are recenter CPUs different in this regard?

I guess so.  That proglet does very bad things to my P4/HT.  I too get a
segfault, but then init goes insane and may reap the proglet's parent
shell, but then again, it may decide to reap the shell next door.
Thereafter, init is running/gaga.  (18-rc7)

Chuck's patch did indeed make it stop doing that.

> > 2.6.9 is fine.  I'd guess the iret fixups from 2.6.12 are the problem.
> > 
> > This doesn't crash for me, but it's probably not quite the right fix:
> > 
> > Signed-off-by: Chuck Ebbert <76306.1226@compuserve.com>
> > ---
> >  arch/i386/kernel/traps.c |   12 +++++++++++-
> >  1 files changed, 11 insertions(+), 1 deletion(-)
> > 
> > --- 2.6.18-rc6-nb.orig/arch/i386/kernel/traps.c
> > +++ 2.6.18-rc6-nb/arch/i386/kernel/traps.c
> > @@ -516,6 +516,16 @@ fastcall void do_##name(struct pt_regs *
> >  	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
> >  }
> >  
> > +#define DO_TSS_ERROR(trapnr, signr, str, name) \
> > +fastcall void do_##name(struct pt_regs * regs, long error_code) \
> > +{ \
> > +	if (notify_die(DIE_TRAP, str, regs, error_code, trapnr, signr) \
> > +						== NOTIFY_STOP) \
> > +		return; \
> > +	regs->eflags &= ~X86_EFLAGS_NT; \
> > +	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
> > +}
> > +
> >  #define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
> >  fastcall void do_##name(struct pt_regs * regs, long error_code) \
> >  { \
> > @@ -561,7 +571,7 @@ DO_VM86_ERROR( 4, SIGSEGV, "overflow", o
> >  DO_VM86_ERROR( 5, SIGSEGV, "bounds", bounds)
> >  DO_ERROR_INFO( 6, SIGILL,  "invalid opcode", invalid_op, ILL_ILLOPN, regs->eip)
> >  DO_ERROR( 9, SIGFPE,  "coprocessor segment overrun", coprocessor_segment_overrun)
> > -DO_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
> > +DO_TSS_ERROR(10, SIGSEGV, "invalid TSS", invalid_TSS)
> >  DO_ERROR(11, SIGBUS,  "segment not present", segment_not_present)
> >  DO_ERROR(12, SIGBUS,  "stack segment", stack_segment)
> >  DO_ERROR_INFO(17, SIGBUS, "alignment check", alignment_check, BUS_ADRALN, 0)
> > -- 
> > Chuck
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

