Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264884AbUG1Vts@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264884AbUG1Vts (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jul 2004 17:49:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263772AbUG1Vts
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jul 2004 17:49:48 -0400
Received: from aun.it.uu.se ([130.238.12.36]:41861 "EHLO aun.it.uu.se")
	by vger.kernel.org with ESMTP id S264884AbUG1VtV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jul 2004 17:49:21 -0400
Date: Wed, 28 Jul 2004 23:49:08 +0200 (MEST)
Message-Id: <200407282149.i6SLn8Oi016085@harpo.it.uu.se>
From: Mikael Pettersson <mikpe@csd.uu.se>
To: akpm@osdl.org
Subject: [PATCH][2.6.8-rc2-mm1] ppc signal handling fixes
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.linuxppc.org,
       paulus@samba.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

2.6.8-rc2-mm1 reintroduced the signal-race-fixes patch
for i386, x86_64, s390, and ia64, breaking all other archs.

The patch below updates ppc, following the pattern of i386.
Compiled & runtime tested. No observable breakage.

Signed-off-by: Mikael Pettersson <mikpe@csd.uu.se>

diff -rupN linux-2.6.8-rc2-mm1/arch/ppc/kernel/signal.c linux-2.6.8-rc2-mm1.ppc-signal-fixes/arch/ppc/kernel/signal.c
--- linux-2.6.8-rc2-mm1/arch/ppc/kernel/signal.c	2004-07-28 18:51:59.000000000 +0200
+++ linux-2.6.8-rc2-mm1.ppc-signal-fixes/arch/ppc/kernel/signal.c	2004-07-28 23:39:34.441346296 +0200
@@ -350,7 +350,7 @@ restore_sigmask(sigset_t *set)
  * (one which gets siginfo).
  */
 static void
-handle_rt_signal(unsigned long sig, struct k_sigaction *ka,
+handle_rt_signal(unsigned long sig, struct k_sigaction *ka_copy,
 		 siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
 		 unsigned long newsp)
 {
@@ -393,7 +393,7 @@ handle_rt_signal(unsigned long sig, stru
 	regs->gpr[4] = (unsigned long) &rt_sf->info;
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->tramp;
 	regs->trap = 0;
 
@@ -405,7 +405,7 @@ badframe:
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -505,7 +505,7 @@ int sys_rt_sigreturn(int r3, int r4, int
  * OK, we're invoking a handler
  */
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
+handle_signal(unsigned long sig, struct k_sigaction *ka_copy,
 	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
 	      unsigned long newsp)
 {
@@ -530,7 +530,7 @@ handle_signal(unsigned long sig, struct 
 #if _NSIG != 64
 #error "Please adjust handle_signal()"
 #endif
-	if (__put_user((unsigned long) ka->sa.sa_handler, &sc->handler)
+	if (__put_user((unsigned long) ka_copy->sa.sa_handler, &sc->handler)
 	    || __put_user(oldset->sig[0], &sc->oldmask)
 	    || __put_user(oldset->sig[1], &sc->_unused[3])
 	    || __put_user((struct pt_regs *)frame, &sc->regs)
@@ -545,7 +545,7 @@ handle_signal(unsigned long sig, struct 
 	regs->gpr[1] = newsp;
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) sc;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->mctx.tramp;
 	regs->trap = 0;
 
@@ -557,7 +557,7 @@ badframe:
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[sig-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -604,7 +604,7 @@ badframe:
 int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
+	struct k_sigaction ka_copy;
 	unsigned long frame, newsp;
 	int signr, ret;
 
@@ -613,9 +613,7 @@ int do_signal(sigset_t *oldset, struct p
 
 	newsp = frame = 0;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
-
-	ka = (signr == 0)? NULL: &current->sighand->action[signr-1];
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 
 	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
@@ -626,7 +624,7 @@ int do_signal(sigset_t *oldset, struct p
 		if (signr > 0
 		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
 			|| (ret == ERESTARTSYS
-			    && !(ka->sa.sa_flags & SA_RESTART)))) {
+			    && !(ka_copy.sa.sa_flags & SA_RESTART)))) {
 			/* make the system call return an EINTR error */
 			regs->result = -EINTR;
 			regs->gpr[3] = EINTR;
@@ -645,7 +643,7 @@ int do_signal(sigset_t *oldset, struct p
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
+	if ((ka_copy.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && !on_sig_stack(regs->gpr[1]))
 		newsp = current->sas_ss_sp + current->sas_ss_size;
 	else
@@ -653,17 +651,14 @@ int do_signal(sigset_t *oldset, struct p
 	newsp &= ~0xfUL;
 
 	/* Whee!  Actually deliver the signal.  */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		handle_rt_signal(signr, ka, &info, oldset, regs, newsp);
+	if (ka_copy.sa.sa_flags & SA_SIGINFO)
+		handle_rt_signal(signr, &ka_copy, &info, oldset, regs, newsp);
 	else
-		handle_signal(signr, ka, &info, oldset, regs, newsp);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+		handle_signal(signr, &ka_copy, &info, oldset, regs, newsp);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy.sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked,&current->blocked,&ka_copy.sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
