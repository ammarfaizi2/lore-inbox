Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318702AbSHEQnP>; Mon, 5 Aug 2002 12:43:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318712AbSHEQnP>; Mon, 5 Aug 2002 12:43:15 -0400
Received: from ns.suse.de ([213.95.15.193]:21768 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id <S318702AbSHEQnD>;
	Mon, 5 Aug 2002 12:43:03 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: context switch vs. signal delivery [was: Re: Accelerating user  mode linux]
References: <20020805163910.C7130@kushida.apsleyroad.org.suse.lists.linux.kernel> <Pine.LNX.4.44.0208050922570.1753-100000@home.transmeta.com.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 05 Aug 2002 18:46:38 +0200
In-Reply-To: Linus Torvalds's message of "5 Aug 2002 18:43:15 +0200"
Message-ID: <p73znw1i781.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@transmeta.com> writes:
> 
> So it would have to be explicitly enabled with a SA_NOFPSIGHANDLER flag or 
> something.

That is all what my patch was doing. It added a SA_NOFP, with default
to off.
Nothing about enabling it by default. The first hunk is an minor optimization.

-Andi

I attached the old patch for 2.4.9 for reference. If you think it is ok
I can submit it for 2.5

--- linux-work/arch/i386/kernel/signal.c-NOFP	Fri Aug 24 16:36:14 2001
+++ linux-work/arch/i386/kernel/signal.c	Fri Aug 31 00:04:24 2001
@@ -322,15 +322,15 @@
 
 static int
 setup_sigcontext(struct sigcontext *sc, struct _fpstate *fpstate,
-		 struct pt_regs *regs, unsigned long mask)
+		 struct pt_regs *regs, unsigned long mask, int fp)
 {
-	int tmp, err = 0;
+	int err = 0;
+	int tmp;
 
-	tmp = 0;
-	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
-	err |= __put_user(tmp, (unsigned int *)&sc->gs);
-	__asm__("movl %%fs,%0" : "=r"(tmp): "0"(tmp));
-	err |= __put_user(tmp, (unsigned int *)&sc->fs);
+	__asm__("movl %%gs,%0" : "=r"(tmp));
+	err |= __put_user(tmp & 0xffff, (unsigned int *)&sc->gs);
+	__asm__("movl %%fs,%0" : "=r"(tmp));
+	err |= __put_user(tmp & 0xffff, (unsigned int *)&sc->fs);
 
 	err |= __put_user(regs->xes, (unsigned int *)&sc->es);
 	err |= __put_user(regs->xds, (unsigned int *)&sc->ds);
@@ -350,11 +350,12 @@
 	err |= __put_user(regs->esp, &sc->esp_at_signal);
 	err |= __put_user(regs->xss, (unsigned int *)&sc->ss);
 
-	tmp = save_i387(fpstate);
-	if (tmp < 0)
+	if (fp)
+	  fp = save_i387(fpstate);
+	if (fp < 0)
 	  err = 1;
 	else
-	  err |= __put_user(tmp ? fpstate : NULL, &sc->fpstate);
+	  err |= __put_user(fp ? fpstate : NULL, &sc->fpstate);
 
 	/* non-iBCS2 extensions.. */
 	err |= __put_user(mask, &sc->oldmask);
@@ -410,7 +411,8 @@
 	if (err)
 		goto give_sigsegv;
 
-	err |= setup_sigcontext(&frame->sc, &frame->fpstate, regs, set->sig[0]);
+	err |= setup_sigcontext(&frame->sc, &frame->fpstate, regs, set->sig[0], 
+				(ka->sa.sa_flags&SA_NOFP));
 	if (err)
 		goto give_sigsegv;
 
@@ -491,7 +493,7 @@
 			  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, &frame->fpstate,
-			        regs, set->sig[0]);
+			        regs, set->sig[0], !!(ka->sa.sa_flags&SA_NOFP));
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
 		goto give_sigsegv;
--- linux-work/arch/i386/kernel/i387.c-NOFP	Fri Feb 23 19:09:08 2001
+++ linux-work/arch/i386/kernel/i387.c	Fri Aug 31 00:01:52 2001
@@ -323,11 +323,6 @@
 	if ( !current->used_math )
 		return 0;
 
-	/* This will cause a "finit" to be triggered by the next
-	 * attempted FPU operation by the 'current' process.
-	 */
-	current->used_math = 0;
-
 	if ( HAVE_HWFP ) {
 		if ( cpu_has_fxsr ) {
 			return save_i387_fxsave( buf );
@@ -335,6 +330,11 @@
 			return save_i387_fsave( buf );
 		}
 	} else {
+		/* This will cause a "finit" to be triggered by the next
+		 * attempted FPU operation by the 'current' process.
+		 */
+		current->used_math = 0;
+       
 		return save_i387_soft( &current->thread.i387.soft, buf );
 	}
 }
--- linux-work/include/asm-i386/signal.h-NOFP	Thu Sep 13 22:27:41 2001
+++ linux-work/include/asm-i386/signal.h	Thu Oct 18 18:31:29 2001
@@ -80,6 +80,7 @@
  * SA_RESETHAND clears the handler when the signal is delivered.
  * SA_NOCLDWAIT flag on SIGCHLD to inhibit zombies.
  * SA_NODEFER prevents the current signal from being masked in the handler.
+ * SA_NOFP    Don't save FP state.	
  *
  * SA_ONESHOT and SA_NOMASK are the historical Linux names for the Single
  * Unix names RESETHAND and NODEFER respectively.
@@ -97,6 +98,7 @@
 #define SA_INTERRUPT	0x20000000 /* dummy -- ignored */
 
 #define SA_RESTORER	0x04000000
+#define SA_NOFP		0x02000000
 
 /* 
  * sigaltstack controls
