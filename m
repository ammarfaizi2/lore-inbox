Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261514AbVCFVXc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261514AbVCFVXc (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Mar 2005 16:23:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261509AbVCFVWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Mar 2005 16:22:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:33738 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261508AbVCFVWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Mar 2005 16:22:31 -0500
Date: Sun, 6 Mar 2005 13:22:25 -0800
Message-Id: <200503062122.j26LMP5F021846@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Daniel Jacobowitz <dan@debian.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Cagney <cagney@redhat.com>
Subject: Re: More trouble with i386 EFLAGS and ptrace
In-Reply-To: Linus Torvalds's message of  Sunday, 6 March 2005 12:03:22 -0800 <Pine.LNX.4.58.0503061155280.2304@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
Emacs: where editing text is like playing Paganini on a glass harmonica.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I _think_ your test-case would work right if you just moved that code from
> the special-case in do_debug(), and moved it to the top of
> setup_sigcontext() instead. I've not tested it, though, and haven't really 
> given it any "deep thought". Maybe somebody smarter can say "yeah, that's 
> obviously the right thing to do" or "no, that won't work because.."

Indeed, this is what my original changes for this did, before you started
cleaning things up to be nice to TF users other than PTRACE_SINGLESTEP. 

I note, btw, that the x86_64 code is still at that prior stage.  So I think
it doesn't have this new wrinkle, but it also doesn't have the advantages
of the more recent i386 changes.  Once we're sure about the i386 state, we
should update the x86_64 code to match.

I'm not sure what kind of smart this makes me, but I'll say that your plan
would work and no, it's obviously not the right thing to do. ;-) I haven't
tested the following, not having tracked down the specific problem case you
folks are talking about.  But I think this is the right solution.  The
difference is that when we stop for some signal and report to the debugger,
the debugger looking at our registers will see TF clear instead of set,
before it decides whether to continue us with the signal or what to do.
With the change yo suggested, (I think) if the debugger decides to eat the
signal and resume, we would get a spurious single-step trap after executing
the next instruction, instead of resuming normally as requested.

Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/include/asm-i386/signal.h
+++ linux-2.6/include/asm-i386/signal.h
@@ -223,7 +223,14 @@ static __inline__ int sigfindinword(unsi
 
 struct pt_regs;
 extern int FASTCALL(do_signal(struct pt_regs *regs, sigset_t *oldset));
-#define ptrace_signal_deliver(regs, cookie) do { } while (0)
+
+#define ptrace_signal_deliver(regs, cookie)		\
+	do {						\
+		if (current->ptrace & PT_DTRACE) {	\
+			current->ptrace &= ~PT_DTRACE;	\
+			(regs)->eflags &= ~TF_MASK;	\
+		}					\
+	} while (0)
 
 #endif /* __KERNEL__ */
 
--- linux-2.6/arch/i386/kernel/traps.c
+++ linux-2.6/arch/i386/kernel/traps.c
@@ -707,8 +707,6 @@ fastcall void do_debug(struct pt_regs * 
 	/*
 	 * Single-stepping through TF: make sure we ignore any events in
 	 * kernel space (but re-enable TF when returning to user mode).
-	 * And if the event was due to a debugger (PT_DTRACE), clear the
-	 * TF flag so that register information is correct.
 	 */
 	if (condition & DR_STEP) {
 		/*
@@ -718,11 +716,6 @@ fastcall void do_debug(struct pt_regs * 
 		 */
 		if ((regs->xcs & 3) == 0)
 			goto clear_TF_reenable;
-
-		if (likely(tsk->ptrace & PT_DTRACE)) {
-			tsk->ptrace &= ~PT_DTRACE;
-			regs->eflags &= ~TF_MASK;
-		}
 	}
 
 	/* Ok, finally something we can handle */
