Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263450AbVCMI25@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263450AbVCMI25 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Mar 2005 03:28:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263452AbVCMI25
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Mar 2005 03:28:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:19947 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S263450AbVCMI2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Mar 2005 03:28:04 -0500
Date: Sun, 13 Mar 2005 00:27:58 -0800
Message-Id: <200503130827.j2D8RwBn025542@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Daniel Jacobowitz <dan@debian.org>
X-Fcc: ~/Mail/linus
Cc: Linus Torvalds <torvalds@osdl.org>,
       "Andrew Morton <akpm@osdl.org> Kernel Mailing List" 
	<linux-kernel@vger.kernel.org>
Subject: Re: More trouble with i386 EFLAGS and ptrace
In-Reply-To: Daniel Jacobowitz's message of  Tuesday, 8 March 2005 19:12:55 -0500 <20050309001254.GA1496@nevyn.them.org>
Emacs: resistance is futile; you will be assimilated and byte-compiled.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch further cleans up the appearance of TF in eflags when ptrace is
involved.  With this, PTRACE_SINGLESTEP will not cause TF to appear in
eflags as seen by PTRACE_GETREGS and the like, when the instruction faulted
for some reason other than the single-step trap.

This moves the check added by Dan's patch from setup_sigcontext to
handle_signal.  This is a cosmetic difference, but I think it makes more
sense to consolidate all the "reset registers to canonical state" work in
the same place (i.e. put it with the syscall rollback code), separate from
the signal handler setup.  The change that matters is moving the similar
check out of do_debug, where it only covers the case of a single-step trap.
Instead, it goes into the ptrace_signal_deliver macro, which is called
before the ptrace stop for whatever signal results from whatever kind of
fault in that instruction (or asynchronous signal).  With that, the
handle_signal check is still needed only for the case of PTRACE_SINGLESTEP
with a handled signal.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/i386/kernel/signal.c
+++ linux-2.6/arch/i386/kernel/signal.c
@@ -277,18 +277,6 @@ setup_sigcontext(struct sigcontext __use
 {
 	int tmp, err = 0;
 
-	/*
-	 * If TF is set due to a debugger (PT_DTRACE), clear the TF
-	 * flag so that register information in the sigcontext is
-	 * correct.
-	 */
-	if (unlikely(regs->eflags & TF_MASK)) {
-		if (likely(current->ptrace & PT_DTRACE)) {
-			current->ptrace &= ~PT_DTRACE;
-			regs->eflags &= ~TF_MASK;
-		}
-	}
-
 	tmp = 0;
 	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
 	err |= __put_user(tmp, (unsigned int __user *)&sc->gs);
@@ -569,6 +557,16 @@ handle_signal(unsigned long sig, siginfo
 		}
 	}
 
+	/*
+	 * If TF is set due to a debugger (PT_DTRACE), clear the TF flag so
+	 * that register information in the sigcontext is correct.
+	 */
+	if (unlikely(regs->eflags & TF_MASK)
+	    && likely(current->ptrace & PT_DTRACE)) {
+		current->ptrace &= ~PT_DTRACE;
+		regs->eflags &= ~TF_MASK;
+	}
+
 	/* Set up the stack frame */
 	if (ka->sa.sa_flags & SA_SIGINFO)
 		setup_rt_frame(sig, ka, info, oldset, regs);
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
 
