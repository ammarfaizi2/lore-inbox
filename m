Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261184AbUC1Lgi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 06:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261220AbUC1Lff
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 06:35:35 -0500
Received: from ozlabs.org ([203.10.76.45]:48310 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S261168AbUC1LeZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 06:34:25 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16486.42332.441061.377346@cargo.ozlabs.ibm.com>
Date: Sun, 28 Mar 2004 20:13:48 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, anton@samba.org
Subject: [PATCH] signal-race fixes for ppc32 and ppc64
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew,

I see that the patch to fix the race in do_signal is in -mm4.  Here is
a patch to make the corresponding changes for ppc32 and ppc64.

Paul.

diff -urN linux-2.6.5-rc2-mm4.orig/arch/ppc/kernel/signal.c linux-2.6.5-rc2-mm4/arch/ppc/kernel/signal.c
--- linux-2.6.5-rc2-mm4.orig/arch/ppc/kernel/signal.c	2004-03-28 15:46:13.871883656 +1000
+++ linux-2.6.5-rc2-mm4/arch/ppc/kernel/signal.c	2004-03-28 15:59:36.062884112 +1000
@@ -306,7 +306,7 @@
  * (one which gets siginfo).
  */
 static void
-handle_rt_signal(unsigned long sig, struct k_sigaction *ka,
+handle_rt_signal(unsigned long sig, struct k_sigaction *ka_copy,
 		 siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
 		 unsigned long newsp)
 {
@@ -349,7 +349,7 @@
 	regs->gpr[4] = (unsigned long) &rt_sf->info;
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->tramp;
 	regs->trap = 0;
 
@@ -361,7 +361,7 @@
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -461,7 +461,7 @@
  * OK, we're invoking a handler
  */
 static void
-handle_signal(unsigned long sig, struct k_sigaction *ka,
+handle_signal(unsigned long sig, struct k_sigaction *ka_copy,
 	      siginfo_t *info, sigset_t *oldset, struct pt_regs * regs,
 	      unsigned long newsp)
 {
@@ -486,7 +486,7 @@
 #if _NSIG != 64
 #error "Please adjust handle_signal()"
 #endif
-	if (__put_user((unsigned long) ka->sa.sa_handler, &sc->handler)
+	if (__put_user((unsigned long) ka_copy->sa.sa_handler, &sc->handler)
 	    || __put_user(oldset->sig[0], &sc->oldmask)
 	    || __put_user(oldset->sig[1], &sc->_unused[3])
 	    || __put_user((struct pt_regs *)frame, &sc->regs)
@@ -501,7 +501,7 @@
 	regs->gpr[1] = newsp;
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) sc;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->mctx.tramp;
 	regs->trap = 0;
 
@@ -513,7 +513,7 @@
 	       regs, frame, *newspp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -560,18 +560,16 @@
 int do_signal(sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
 	unsigned long frame, newsp;
 	int signr, ret;
+	struct k_sigaction ka_copy;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	newsp = frame = 0;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
-
-	ka = (signr == 0)? NULL: &current->sighand->action[signr-1];
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 
 	if (TRAP(regs) == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
@@ -582,7 +580,7 @@
 		if (signr > 0
 		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
 			|| (ret == ERESTARTSYS
-			    && !(ka->sa.sa_flags & SA_RESTART)))) {
+			    && !(ka_copy.sa.sa_flags & SA_RESTART)))) {
 			/* make the system call return an EINTR error */
 			regs->result = -EINTR;
 			regs->gpr[3] = EINTR;
@@ -601,7 +599,7 @@
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
+	if ((ka_copy.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && !on_sig_stack(regs->gpr[1]))
 		newsp = current->sas_ss_sp + current->sas_ss_size;
 	else
@@ -609,17 +607,18 @@
 	newsp &= ~0xfUL;
 
 	/* Whee!  Actually deliver the signal.  */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		handle_rt_signal(signr, ka, &info, oldset, regs, newsp);
+	if (ka_copy.sa.sa_flags & SA_SIGINFO)
+		handle_rt_signal(signr, &ka_copy, &info, oldset, regs, newsp);
 	else
-		handle_signal(signr, ka, &info, oldset, regs, newsp);
+		handle_signal(signr, &ka_copy, &info, oldset, regs, newsp);
 
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+	if (ka_copy.sa.sa_flags & SA_ONESHOT)
+		ka_copy.sa.sa_handler = SIG_DFL;
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy.sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka_copy.sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
diff -urN linux-2.6.5-rc2-mm4.orig/arch/ppc64/kernel/signal.c linux-2.6.5-rc2-mm4/arch/ppc64/kernel/signal.c
--- linux-2.6.5-rc2-mm4.orig/arch/ppc64/kernel/signal.c	2004-03-28 15:44:32.215895664 +1000
+++ linux-2.6.5-rc2-mm4/arch/ppc64/kernel/signal.c	2004-03-28 14:57:58.000000000 +1000
@@ -216,15 +216,15 @@
 /*
  * Allocate space for the signal frame
  */
-static inline void * get_sigframe(struct k_sigaction *ka, struct pt_regs *regs,
-				  size_t frame_size)
+static inline void * get_sigframe(struct k_sigaction *ka_copy,
+				  struct pt_regs *regs, size_t frame_size)
 {
         unsigned long newsp;
 
         /* Default to using normal stack */
         newsp = regs->gpr[1];
 
-	if (ka->sa.sa_flags & SA_ONSTACK) {
+	if (ka_copy->sa.sa_flags & SA_ONSTACK) {
 		if (! on_sig_stack(regs->gpr[1]))
 			newsp = (current->sas_ss_sp + current->sas_ss_size);
 	}
@@ -361,8 +361,8 @@
 	do_exit(SIGSEGV);
 }
 
-static void setup_rt_frame(int signr, struct k_sigaction *ka, siginfo_t *info,
-		sigset_t *set, struct pt_regs *regs)
+static void setup_rt_frame(int signr, struct k_sigaction *ka_copy,
+		siginfo_t *info, sigset_t *set, struct pt_regs *regs)
 {
 	/* Handler is *really* a pointer to the function descriptor for
 	 * the signal routine.  The first entry in the function
@@ -374,7 +374,7 @@
 	unsigned long newsp = 0;
 	int err = 0;
 
-	frame = get_sigframe(ka, regs, sizeof(*frame));
+	frame = get_sigframe(ka_copy, regs, sizeof(*frame));
 
 	if (verify_area(VERIFY_WRITE, frame, sizeof(*frame)))
 		goto badframe;
@@ -393,7 +393,7 @@
 			  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(current->sas_ss_size, &frame->uc.uc_stack.ss_size);
 	err |= setup_sigcontext(&frame->uc.uc_mcontext, regs, signr, NULL,
-				(unsigned long)ka->sa.sa_handler);
+				(unsigned long)ka_copy->sa.sa_handler);
 	err |= __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set));
 	if (err)
 		goto badframe;
@@ -403,7 +403,7 @@
 	if (err)
 		goto badframe;
 
-	funct_desc_ptr = (func_descr_t *) ka->sa.sa_handler;
+	funct_desc_ptr = (func_descr_t *) ka_copy->sa.sa_handler;
 
 	/* Allocate a dummy caller frame for the signal handler. */
 	newsp = (unsigned long)frame - __SIGNAL_FRAMESIZE;
@@ -415,7 +415,7 @@
 	regs->gpr[1] = newsp;
 	err |= get_user(regs->gpr[2], &funct_desc_ptr->toc);
 	regs->gpr[3] = signr;
-	if (ka->sa.sa_flags & SA_SIGINFO) {
+	if (ka_copy->sa.sa_flags & SA_SIGINFO) {
 		err |= get_user(regs->gpr[4], (unsigned long *)&frame->pinfo);
 		err |= get_user(regs->gpr[5], (unsigned long *)&frame->puc);
 		regs->gpr[6] = (unsigned long) frame;
@@ -432,33 +432,33 @@
 	printk("badframe in setup_rt_frame, regs=%p frame=%p newsp=%lx\n",
 	       regs, frame, newsp);
 #endif
-	do_exit(SIGSEGV);
+	if (signr == SIGSEGV)
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
+	force_sig(SIGSEGV, current);
 }
 
 
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal(unsigned long sig, struct k_sigaction *ka,
-			  siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
+static void handle_signal(unsigned long sig, struct k_sigaction *ka_copy,
+		siginfo_t *info, sigset_t *oldset, struct pt_regs *regs)
 {
 	/* Set up Signal Frame */
-	setup_rt_frame(sig, ka, info, oldset, regs);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+	setup_rt_frame(sig, ka_copy, info, oldset, regs);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy->sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka_copy->sa.sa_mask);
 		sigaddset(&current->blocked,sig);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
 	}
-	return;
 }
 
-static inline void syscall_restart(struct pt_regs *regs, struct k_sigaction *ka)
+static inline void syscall_restart(struct pt_regs *regs,
+				   struct k_sigaction *ka_copy)
 {
 	switch ((int)regs->result) {
 	case -ERESTART_RESTARTBLOCK:
@@ -473,7 +473,7 @@
 		/* ERESTARTSYS means to restart the syscall if there is no
 		 * handler or the handler was registered with SA_RESTART
 		 */
-		if (!(ka->sa.sa_flags & SA_RESTART)) {
+		if (!(ka_copy->sa.sa_flags & SA_RESTART)) {
 			regs->result = -EINTR;
 			break;
 		}
@@ -498,6 +498,7 @@
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka_copy;
 
 	/*
 	 * If the current thread is 32 bit - invoke the
@@ -509,14 +510,12 @@
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 	if (signr > 0) {
-		struct k_sigaction *ka = &current->sighand->action[signr-1];
-
 		/* Whee!  Actually deliver the signal.  */
 		if (regs->trap == 0x0C00)
-			syscall_restart(regs, ka);
-		handle_signal(signr, ka, &info, oldset, regs);
+			syscall_restart(regs, &ka_copy);
+		handle_signal(signr, &ka_copy, &info, oldset, regs);
 		return 1;
 	}
 
diff -urN linux-2.6.5-rc2-mm4.orig/arch/ppc64/kernel/signal32.c linux-2.6.5-rc2-mm4/arch/ppc64/kernel/signal32.c
--- linux-2.6.5-rc2-mm4.orig/arch/ppc64/kernel/signal32.c	2004-03-28 15:45:56.794951080 +1000
+++ linux-2.6.5-rc2-mm4/arch/ppc64/kernel/signal32.c	2004-03-28 14:58:34.000000000 +1000
@@ -657,7 +657,7 @@
  * Set up a signal frame for a "real-time" signal handler
  * (one which gets siginfo).
  */
-static void handle_rt_signal32(unsigned long sig, struct k_sigaction *ka,
+static void handle_rt_signal32(unsigned long sig, struct k_sigaction *ka_copy,
 			       siginfo_t *info, sigset_t *oldset,
 			       struct pt_regs * regs, unsigned long newsp)
 {
@@ -703,7 +703,7 @@
 	regs->gpr[4] = (unsigned long) &rt_sf->info;
 	regs->gpr[5] = (unsigned long) &rt_sf->uc;
 	regs->gpr[6] = (unsigned long) rt_sf;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->tramp;
 	regs->trap = 0;
 
@@ -715,7 +715,7 @@
 	       regs, frame, newsp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -828,7 +828,7 @@
 /*
  * OK, we're invoking a handler
  */
-static void handle_signal32(unsigned long sig, struct k_sigaction *ka,
+static void handle_signal32(unsigned long sig, struct k_sigaction *ka_copy,
 			    siginfo_t *info, sigset_t *oldset,
 			    struct pt_regs * regs, unsigned long newsp)
 {
@@ -853,7 +853,7 @@
 #if _NSIG != 64
 #error "Please adjust handle_signal32()"
 #endif
-	if (__put_user((u32)(u64)ka->sa.sa_handler, &sc->handler)
+	if (__put_user((u32)(u64)ka_copy->sa.sa_handler, &sc->handler)
 	    || __put_user(oldset->sig[0], &sc->oldmask)
 	    || __put_user((oldset->sig[0] >> 32), &sc->_unused[3])
 	    || __put_user((u32)(u64)frame, &sc->regs)
@@ -868,7 +868,7 @@
 	regs->gpr[1] = (unsigned long) newsp;
 	regs->gpr[3] = sig;
 	regs->gpr[4] = (unsigned long) sc;
-	regs->nip = (unsigned long) ka->sa.sa_handler;
+	regs->nip = (unsigned long) ka_copy->sa.sa_handler;
 	regs->link = (unsigned long) frame->mctx.tramp;
 	regs->trap = 0;
 
@@ -880,7 +880,7 @@
 	       regs, frame, *newspp);
 #endif
 	if (sig == SIGSEGV)
-		ka->sa.sa_handler = SIG_DFL;
+		current->sighand->action[SIGSEGV-1].sa.sa_handler = SIG_DFL;
 	force_sig(SIGSEGV, current);
 }
 
@@ -944,18 +944,16 @@
 int do_signal32(sigset_t *oldset, struct pt_regs *regs)
 {
 	siginfo_t info;
-	struct k_sigaction *ka;
 	unsigned int frame, newsp;
 	int signr, ret;
+	struct k_sigaction ka_copy;
 
 	if (!oldset)
 		oldset = &current->blocked;
 
 	newsp = frame = 0;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
-
-	ka = (signr == 0)? NULL: &current->sighand->action[signr-1];
+	signr = get_signal_to_deliver(&info, &ka_copy, regs, NULL);
 
 	if (regs->trap == 0x0C00		/* System Call! */
 	    && regs->ccr & 0x10000000		/* error signalled */
@@ -966,7 +964,7 @@
 		if (signr > 0
 		    && (ret == ERESTARTNOHAND || ret == ERESTART_RESTARTBLOCK
 			|| (ret == ERESTARTSYS
-			    && !(ka->sa.sa_flags & SA_RESTART)))) {
+			    && !(ka_copy.sa.sa_flags & SA_RESTART)))) {
 			/* make the system call return an EINTR error */
 			regs->result = -EINTR;
 			regs->gpr[3] = EINTR;
@@ -985,7 +983,7 @@
 	if (signr == 0)
 		return 0;		/* no signals delivered */
 
-	if ((ka->sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
+	if ((ka_copy.sa.sa_flags & SA_ONSTACK) && current->sas_ss_size
 	    && (!on_sig_stack(regs->gpr[1])))
 		newsp = (current->sas_ss_sp + current->sas_ss_size);
 	else
@@ -993,17 +991,15 @@
 	newsp &= ~0xfUL;
 
 	/* Whee!  Actually deliver the signal.  */
-	if (ka->sa.sa_flags & SA_SIGINFO)
-		handle_rt_signal32(signr, ka, &info, oldset, regs, newsp);
+	if (ka_copy.sa.sa_flags & SA_SIGINFO)
+		handle_rt_signal32(signr, &ka_copy, &info, oldset, regs, newsp);
 	else
-		handle_signal32(signr, ka, &info, oldset, regs, newsp);
-
-	if (ka->sa.sa_flags & SA_ONESHOT)
-		ka->sa.sa_handler = SIG_DFL;
+		handle_signal32(signr, &ka_copy, &info, oldset, regs, newsp);
 
-	if (!(ka->sa.sa_flags & SA_NODEFER)) {
+	if (!(ka_copy.sa.sa_flags & SA_NODEFER)) {
 		spin_lock_irq(&current->sighand->siglock);
-		sigorsets(&current->blocked,&current->blocked,&ka->sa.sa_mask);
+		sigorsets(&current->blocked, &current->blocked,
+			  &ka_copy.sa.sa_mask);
 		sigaddset(&current->blocked, signr);
 		recalc_sigpending();
 		spin_unlock_irq(&current->sighand->siglock);
