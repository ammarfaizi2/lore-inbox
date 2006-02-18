Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750821AbWBRFds@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750821AbWBRFds (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 18 Feb 2006 00:33:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWBRFds
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 18 Feb 2006 00:33:48 -0500
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:5058 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1750821AbWBRFdr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 18 Feb 2006 00:33:47 -0500
Date: Sat, 18 Feb 2006 00:29:54 -0500
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [patch] i386: another possible singlestep fix
To: Linus Torvalds <torvalds@osdl.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200602180031_MC3-1-B8B2-E328@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <Pine.LNX.4.64.0602171412210.916@g5.osdl.org>

On Fri, 17 Feb 2006 at 14:14:06 -0800, Linus Torvalds wrote:

> On Fri, 17 Feb 2006, Chuck Ebbert wrote:
> >
> > When entering kernel via int80, TIF_SINGLESTEP is not set
> > when TF has been set in eflags by the user.  This patch
> > does that.
> ...
> So afaik, this won't actually do anything (except make _the_ most 
> timing-critical path in the kernel slower). Have you actually seen any 
> effects of it?

No, because every time I try to write a test program I find new things
that keep me from testing what I started out to test.  (Last time it was
syscalls turning off singlestep.)

Now I'm using PTRACE_SINGLESTEP to trace a program that is setting
TF while being traced.  This works; TF starts showing as set after
the popf that sets it but then I tried to forward the SIGTRAP on
to the child so its signal handler could run when TF was set:

        waitpid(child, &status, 0);
        if (WIFSTOPPED(status)) {
                int signo = WSTOPSIG(status);
                ptrace(PTRACE_GETREGS, child, 0, &regs);
                if (signo !=5 || !(regs.eflags & TF_MASK))
                        signo = 0
                ptrace(PTRACE_SINGLESTEP, child, NULL, (void *)signo);
        }

Now I can trace the signal handler, but when it returns TF is never
again seen as set in the child program when the tracer gets control.
This kernel patch fixes that (but doesn't handle errors properly):

--- 2.6.16-rc3-nb.orig/arch/i386/kernel/signal.c
+++ 2.6.16-rc3-nb/arch/i386/kernel/signal.c
@@ -145,6 +145,9 @@ restore_sigcontext(struct pt_regs *regs,
 	{
 		unsigned int tmpflags;
 		err |= __get_user(tmpflags, &sc->eflags);
+		/* user setting TF? */
+		if (tmpflags & X86_EFLAGS_TF)
+			current->ptrace &= ~PT_DTRACE;
 		regs->eflags = (regs->eflags & ~FIX_EFLAGS) | (tmpflags & FIX_EFLAGS);
 		regs->orig_eax = -1;		/* disable syscall checks */
 	}


But now the program goes into an infinite loop because the same trap
keeps getting delivered over and over.  It's almost like after the
child actually handles the signal it gets recycled somehow, the tracer
gets it, sends it to the child again and so on...  So I modified the
test program to only start forwarding SIGTRAP after two in a row with
TF set have been delivered, but that shouldn't be necessary, should it?

-- 
Chuck
"Equations are the Devil's sentences."  --Stephen Colbert
