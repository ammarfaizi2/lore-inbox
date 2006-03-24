Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751400AbWCXSN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751400AbWCXSN7 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 13:13:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWCXSN5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 13:13:57 -0500
Received: from [198.99.130.12] ([198.99.130.12]:47254 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751372AbWCXSNr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 13:13:47 -0500
Message-Id: <200603241815.k2OIF19g005560@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 13/16] UML - Fix segfault on signal delivery
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 24 Mar 2006 13:15:01 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes a process segfault where a signal was being delivered
such that a new stack page needed to be allocated to hold the signal
frame.  This was tripping some logic in the page fault handler which
wouldn't allocate the page if the faulting address was more that 32
bytes lower than the current stack pointer.  Since a signal frame is
greater than 32 bytes, this exercised that case.
It's fixed by updating the SP in the pt_regs before starting to copy
the signal frame.  Since those are the registers that will be copied
on to the stack, we have to be careful to put the original SP, not
the new one which points to the signal frame, on the stack.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-i386/signal.c	2006-03-23 12:12:36.000000000 -0500
+++ linux-2.6.15/arch/um/sys-i386/signal.c	2006-03-23 12:31:01.000000000 -0500
@@ -58,7 +58,7 @@ static int copy_sc_from_user_skas(struct
 }
 
 int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp,
-                         struct pt_regs *regs)
+                         struct pt_regs *regs, unsigned long sp)
 {
   	struct sigcontext sc;
 	unsigned long fpregs[HOST_FP_SIZE];
@@ -72,7 +72,7 @@ int copy_sc_to_user_skas(struct sigconte
 	sc.edi = REGS_EDI(regs->regs.skas.regs);
 	sc.esi = REGS_ESI(regs->regs.skas.regs);
 	sc.ebp = REGS_EBP(regs->regs.skas.regs);
-	sc.esp = REGS_SP(regs->regs.skas.regs);
+	sc.esp = sp;
 	sc.ebx = REGS_EBX(regs->regs.skas.regs);
 	sc.edx = REGS_EDX(regs->regs.skas.regs);
 	sc.ecx = REGS_ECX(regs->regs.skas.regs);
@@ -132,7 +132,7 @@ int copy_sc_from_user_tt(struct sigconte
 }
 
 int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate *fp,
-		       struct sigcontext *from, int fpsize)
+		       struct sigcontext *from, int fpsize, unsigned long sp)
 {
 	struct _fpstate *to_fp, *from_fp;
 	int err;
@@ -140,11 +140,18 @@ int copy_sc_to_user_tt(struct sigcontext
 	to_fp =	(fp ? fp : (struct _fpstate *) (to + 1));
 	from_fp = from->fpstate;
 	err = copy_to_user(to, from, sizeof(*to));
+
+	/* The SP in the sigcontext is the updated one for the signal
+	 * delivery.  The sp passed in is the original, and this needs
+	 * to be restored, so we stick it in separately.
+	 */
+	err |= copy_to_user(&SC_SP(to), sp, sizeof(sp));
+
 	if(from_fp != NULL){
 		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
 		err |= copy_to_user(to_fp, from_fp, fpsize);
 	}
-	return(err);
+	return err;
 }
 #endif
 
@@ -159,11 +166,11 @@ static int copy_sc_from_user(struct pt_r
 }
 
 static int copy_sc_to_user(struct sigcontext *to, struct _fpstate *fp,
-			   struct pt_regs *from)
+			   struct pt_regs *from, unsigned long sp)
 {
 	return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),
-					      sizeof(*fp)),
-                           copy_sc_to_user_skas(to, fp, from)));
+					      sizeof(*fp), sp),
+                           copy_sc_to_user_skas(to, fp, from, sp)));
 }
 
 static int copy_ucontext_to_user(struct ucontext *uc, struct _fpstate *fp,
@@ -174,7 +181,7 @@ static int copy_ucontext_to_user(struct 
 	err |= put_user(current->sas_ss_sp, &uc->uc_stack.ss_sp);
 	err |= put_user(sas_ss_flags(sp), &uc->uc_stack.ss_flags);
 	err |= put_user(current->sas_ss_size, &uc->uc_stack.ss_size);
-	err |= copy_sc_to_user(&uc->uc_mcontext, fp, &current->thread.regs);
+	err |= copy_sc_to_user(&uc->uc_mcontext, fp, &current->thread.regs, sp);
 	err |= copy_to_user(&uc->uc_sigmask, set, sizeof(*set));
 	return(err);
 }
@@ -207,6 +214,7 @@ int setup_signal_stack_sc(unsigned long 
 {
 	struct sigframe __user *frame;
 	void *restorer;
+	unsigned long save_sp = PT_REGS_SP(regs);
 	int err = 0;
 
 	stack_top &= -8UL;
@@ -218,9 +226,19 @@ int setup_signal_stack_sc(unsigned long 
 	if(ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
+	/* Update SP now because the page fault handler refuses to extend
+	 * the stack if the faulting address is too far below the current
+	 * SP, which frame now certainly is.  If there's an error, the original
+	 * value is restored on the way out.
+	 * When writing the sigcontext to the stack, we have to write the
+	 * original value, so that's passed to copy_sc_to_user, which does
+	 * the right thing with it.
+	 */
+	PT_REGS_SP(regs) = (unsigned long) frame;
+
 	err |= __put_user(restorer, &frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
-	err |= copy_sc_to_user(&frame->sc, NULL, regs);
+	err |= copy_sc_to_user(&frame->sc, NULL, regs, save_sp);
 	err |= __put_user(mask->sig[0], &frame->sc.oldmask);
 	if (_NSIG_WORDS > 1)
 		err |= __copy_to_user(&frame->extramask, &mask->sig[1],
@@ -238,7 +256,7 @@ int setup_signal_stack_sc(unsigned long 
 	err |= __put_user(0x80cd, (short __user *)(frame->retcode+6));
 
 	if(err)
-		return(err);
+		goto err;
 
 	PT_REGS_SP(regs) = (unsigned long) frame;
 	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
@@ -248,7 +266,11 @@ int setup_signal_stack_sc(unsigned long 
 
 	if ((current->ptrace & PT_DTRACE) && (current->ptrace & PT_PTRACED))
 		ptrace_notify(SIGTRAP);
-	return(0);
+	return 0;
+
+err:
+	PT_REGS_SP(regs) = save_sp;
+	return err;
 }
 
 int setup_signal_stack_si(unsigned long stack_top, int sig,
@@ -257,6 +279,7 @@ int setup_signal_stack_si(unsigned long 
 {
 	struct rt_sigframe __user *frame;
 	void *restorer;
+	unsigned long save_sp = PT_REGS_SP(regs);
 	int err = 0;
 
 	stack_top &= -8UL;
@@ -268,13 +291,16 @@ int setup_signal_stack_si(unsigned long 
 	if(ka->sa.sa_flags & SA_RESTORER)
 		restorer = ka->sa.sa_restorer;
 
+	/* See comment above about why this is here */
+	PT_REGS_SP(regs) = (unsigned long) frame;
+
 	err |= __put_user(restorer, &frame->pretcode);
 	err |= __put_user(sig, &frame->sig);
 	err |= __put_user(&frame->info, &frame->pinfo);
 	err |= __put_user(&frame->uc, &frame->puc);
 	err |= copy_siginfo_to_user(&frame->info, info);
 	err |= copy_ucontext_to_user(&frame->uc, &frame->fpstate, mask,
-				     PT_REGS_SP(regs));
+				     save_sp);
 
 	/*
 	 * This is movl $,%eax ; int $0x80
@@ -288,9 +314,8 @@ int setup_signal_stack_si(unsigned long 
 	err |= __put_user(0x80cd, (short __user *)(frame->retcode+5));
 
 	if(err)
-		return(err);
+		goto err;
 
-	PT_REGS_SP(regs) = (unsigned long) frame;
 	PT_REGS_IP(regs) = (unsigned long) ka->sa.sa_handler;
 	PT_REGS_EAX(regs) = (unsigned long) sig;
 	PT_REGS_EDX(regs) = (unsigned long) &frame->info;
@@ -298,7 +323,11 @@ int setup_signal_stack_si(unsigned long 
 
 	if ((current->ptrace & PT_DTRACE) && (current->ptrace & PT_PTRACED))
 		ptrace_notify(SIGTRAP);
-	return(0);
+	return 0;
+
+err:
+	PT_REGS_SP(regs) = save_sp;
+	return err;
 }
 
 long sys_sigreturn(struct pt_regs regs)
Index: linux-2.6.15/arch/um/sys-x86_64/signal.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-x86_64/signal.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/sys-x86_64/signal.c	2006-03-23 12:28:26.000000000 -0500
@@ -55,7 +55,8 @@ static int copy_sc_from_user_skas(struct
 }
 
 int copy_sc_to_user_skas(struct sigcontext *to, struct _fpstate *to_fp,
-                        struct pt_regs *regs, unsigned long mask)
+			 struct pt_regs *regs, unsigned long mask,
+			 unsigned long sp)
 {
         struct faultinfo * fi = &current->thread.arch.faultinfo;
 	int err = 0;
@@ -70,7 +71,11 @@ int copy_sc_to_user_skas(struct sigconte
 	err |= PUTREG(regs, RDI, to, rdi);
 	err |= PUTREG(regs, RSI, to, rsi);
 	err |= PUTREG(regs, RBP, to, rbp);
-	err |= PUTREG(regs, RSP, to, rsp);
+        /* Must use orignal RSP, which is passed in, rather than what's in
+         * the pt_regs, because that's already been updated to point at the
+         * signal frame.
+         */
+	err |= __put_user(sp, &to->rsp);
 	err |= PUTREG(regs, RBX, to, rbx);
 	err |= PUTREG(regs, RDX, to, rdx);
 	err |= PUTREG(regs, RCX, to, rcx);
@@ -102,7 +107,7 @@ int copy_sc_to_user_skas(struct sigconte
 
 #ifdef CONFIG_MODE_TT
 int copy_sc_from_user_tt(struct sigcontext *to, struct sigcontext *from,
-                        int fpsize)
+			 int fpsize)
 {
 	struct _fpstate *to_fp, *from_fp;
 	unsigned long sigs;
@@ -120,7 +125,7 @@ int copy_sc_from_user_tt(struct sigconte
 }
 
 int copy_sc_to_user_tt(struct sigcontext *to, struct _fpstate *fp,
-                      struct sigcontext *from, int fpsize)
+		       struct sigcontext *from, int fpsize, unsigned long sp)
 {
 	struct _fpstate *to_fp, *from_fp;
 	int err;
@@ -128,11 +133,17 @@ int copy_sc_to_user_tt(struct sigcontext
 	to_fp = (fp ? fp : (struct _fpstate *) (to + 1));
 	from_fp = from->fpstate;
 	err = copy_to_user(to, from, sizeof(*to));
+	/* The SP in the sigcontext is the updated one for the signal
+	 * delivery.  The sp passed in is the original, and this needs
+	 * to be restored, so we stick it in separately.
+	 */
+	err |= copy_to_user(&SC_SP(to), sp, sizeof(sp));
+
 	if(from_fp != NULL){
 		err |= copy_to_user(&to->fpstate, &to_fp, sizeof(to->fpstate));
 		err |= copy_to_user(to_fp, from_fp, fpsize);
 	}
-	return(err);
+	return err;
 }
 
 #endif
@@ -148,11 +159,12 @@ static int copy_sc_from_user(struct pt_r
 }
 
 static int copy_sc_to_user(struct sigcontext *to, struct _fpstate *fp,
-                          struct pt_regs *from, unsigned long mask)
+			   struct pt_regs *from, unsigned long mask,
+			   unsigned long sp)
 {
        return(CHOOSE_MODE(copy_sc_to_user_tt(to, fp, UPT_SC(&from->regs),
-                                             sizeof(*fp)),
-                          copy_sc_to_user_skas(to, fp, from, mask)));
+                                             sizeof(*fp), sp),
+                          copy_sc_to_user_skas(to, fp, from, mask, sp)));
 }
 
 struct rt_sigframe
@@ -170,6 +182,7 @@ int setup_signal_stack_si(unsigned long 
 {
 	struct rt_sigframe __user *frame;
 	struct _fpstate __user *fp = NULL;
+	unsigned long save_sp = PT_REGS_RSP(regs);
 	int err = 0;
 	struct task_struct *me = current;
 
@@ -193,14 +206,25 @@ int setup_signal_stack_si(unsigned long 
 			goto out;
 	}
 
+	/* Update SP now because the page fault handler refuses to extend
+	 * the stack if the faulting address is too far below the current
+	 * SP, which frame now certainly is.  If there's an error, the original
+	 * value is restored on the way out.
+	 * When writing the sigcontext to the stack, we have to write the
+	 * original value, so that's passed to copy_sc_to_user, which does
+	 * the right thing with it.
+	 */
+	PT_REGS_RSP(regs) = (unsigned long) frame;
+
 	/* Create the ucontext.  */
 	err |= __put_user(0, &frame->uc.uc_flags);
 	err |= __put_user(0, &frame->uc.uc_link);
 	err |= __put_user(me->sas_ss_sp, &frame->uc.uc_stack.ss_sp);
-	err |= __put_user(sas_ss_flags(PT_REGS_SP(regs)),
+	err |= __put_user(sas_ss_flags(save_sp),
 			  &frame->uc.uc_stack.ss_flags);
 	err |= __put_user(me->sas_ss_size, &frame->uc.uc_stack.ss_size);
-	err |= copy_sc_to_user(&frame->uc.uc_mcontext, fp, regs, set->sig[0]);
+	err |= copy_sc_to_user(&frame->uc.uc_mcontext, fp, regs, set->sig[0],
+		save_sp);
 	err |= __put_user(fp, &frame->uc.uc_mcontext.fpstate);
 	if (sizeof(*set) == 16) {
 		__put_user(set->sig[0], &frame->uc.uc_sigmask.sig[0]);
@@ -217,10 +241,10 @@ int setup_signal_stack_si(unsigned long 
 		err |= __put_user(ka->sa.sa_restorer, &frame->pretcode);
 	else
 		/* could use a vstub here */
-		goto out;
+		goto restore_sp;
 
 	if (err)
-		goto out;
+		goto restore_sp;
 
 	/* Set up registers for signal handler */
 	{
@@ -238,10 +262,12 @@ int setup_signal_stack_si(unsigned long 
 	PT_REGS_RSI(regs) = (unsigned long) &frame->info;
 	PT_REGS_RDX(regs) = (unsigned long) &frame->uc;
 	PT_REGS_RIP(regs) = (unsigned long) ka->sa.sa_handler;
-
-	PT_REGS_RSP(regs) = (unsigned long) frame;
  out:
-	return(err);
+	return err;
+
+restore_sp:
+	PT_REGS_RSP(regs) = save_sp;
+	return err;
 }
 
 long sys_rt_sigreturn(struct pt_regs *regs)

