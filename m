Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbVARBjv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbVARBjv (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jan 2005 20:39:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261173AbVARBhJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jan 2005 20:37:09 -0500
Received: from mail.dif.dk ([193.138.115.101]:57527 "EHLO mail.dif.dk")
	by vger.kernel.org with ESMTP id S262879AbVARBT7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jan 2005 20:19:59 -0500
Date: Tue, 18 Jan 2005 02:22:48 +0100 (CET)
From: Jesper Juhl <juhl-lkml@dif.dk>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 07/11] Get rid of verify_area() - arch/sparc/ and arch/sparc64/.
Message-ID: <Pine.LNX.4.61.0501180151370.2730@dragon.hygekrogen.localhost>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Convert a bunch of verify_area()'s to access_ok().
arch/sparc/ and arch/sparc64/.


Signed-off-by: Jesper Juhl <juhl-lkml@dif.dk>

diff -urp linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/ptrace.c linux-2.6.11-rc1-bk4/arch/sparc/kernel/ptrace.c
--- linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/ptrace.c	2004-12-24 22:35:40.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sparc/kernel/ptrace.c	2005-01-17 00:42:06.000000000 +0100
@@ -374,8 +374,8 @@ asmlinkage void do_ptrace(struct pt_regs
 		struct pt_regs *cregs = child->thread.kregs;
 		int rval;
 
-		rval = verify_area(VERIFY_WRITE, pregs, sizeof(struct pt_regs));
-		if(rval) {
+		if (!access_ok(VERIFY_WRITE, pregs, sizeof(struct pt_regs))) {
+			rval = -EFAULT;
 			pt_error_return(regs, -rval);
 			goto out_tsk;
 		}
@@ -401,8 +401,8 @@ asmlinkage void do_ptrace(struct pt_regs
 		/* Must be careful, tracing process can only set certain
 		 * bits in the psr.
 		 */
-		i = verify_area(VERIFY_READ, pregs, sizeof(struct pt_regs));
-		if(i) {
+		if (!access_ok(VERIFY_READ, pregs, sizeof(struct pt_regs))) {
+			i = -EFAULT;
 			pt_error_return(regs, -i);
 			goto out_tsk;
 		}
@@ -439,8 +439,8 @@ asmlinkage void do_ptrace(struct pt_regs
 		struct fps __user *fps = (struct fps __user *) addr;
 		int i;
 
-		i = verify_area(VERIFY_WRITE, fps, sizeof(struct fps));
-		if(i) {
+		if (!access_ok(VERIFY_WRITE, fps, sizeof(struct fps))) {
+			i = -EFAULT;
 			pt_error_return(regs, -i);
 			goto out_tsk;
 		}
@@ -474,8 +474,8 @@ asmlinkage void do_ptrace(struct pt_regs
 		struct fps __user *fps = (struct fps __user *) addr;
 		int i;
 
-		i = verify_area(VERIFY_READ, fps, sizeof(struct fps));
-		if(i) {
+		if (!access_ok(VERIFY_READ, fps, sizeof(struct fps))) {
+			i = -EFAULT;
 			pt_error_return(regs, -i);
 			goto out_tsk;
 		}
diff -urp linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/signal.c linux-2.6.11-rc1-bk4/arch/sparc/kernel/signal.c
--- linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/signal.c	2005-01-12 23:26:03.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sparc/kernel/signal.c	2005-01-17 00:42:47.000000000 +0100
@@ -205,7 +205,7 @@ restore_fpu_state(struct pt_regs *regs, 
 	current->used_math = 1;
 	clear_tsk_thread_flag(current, TIF_USEDFPU);
 
-	if (verify_area(VERIFY_READ, fpu, sizeof(*fpu)))
+	if (!access_ok(VERIFY_READ, fpu, sizeof(*fpu)))
 		return -EFAULT;
 
 	err = __copy_from_user(&current->thread.float_regs[0], &fpu->si_float_regs[0],
@@ -231,7 +231,7 @@ static inline void do_new_sigreturn (str
 	sf = (struct new_signal_frame __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (verify_area(VERIFY_READ, sf, sizeof(*sf)))
+	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)))
 		goto segv_and_exit;
 
 	if (((unsigned long) sf) & 3)
@@ -297,7 +297,7 @@ asmlinkage void do_sigreturn(struct pt_r
 	scptr = (struct sigcontext __user *) regs->u_regs[UREG_I0];
 
 	/* Check sanity of the user arg. */
-	if (verify_area(VERIFY_READ, scptr, sizeof(struct sigcontext)) ||
+	if (!access_ok(VERIFY_READ, scptr, sizeof(struct sigcontext)) ||
 	    (((unsigned long) scptr) & 3))
 		goto segv_and_exit;
 
@@ -356,7 +356,7 @@ asmlinkage void do_rt_sigreturn(struct p
 
 	synchronize_user_stack();
 	sf = (struct rt_signal_frame __user *) regs->u_regs[UREG_FP];
-	if (verify_area(VERIFY_READ, sf, sizeof(*sf)) ||
+	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)) ||
 	    (((unsigned long) sf) & 0x03))
 		goto segv;
 
diff -urp linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/sys_sparc.c linux-2.6.11-rc1-bk4/arch/sparc/kernel/sys_sparc.c
--- linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/sys_sparc.c	2004-12-24 22:34:31.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sparc/kernel/sys_sparc.c	2005-01-17 00:38:10.000000000 +0100
@@ -400,7 +400,7 @@ sparc_sigaction (int sig, const struct o
 	if (act) {
 		unsigned long mask;
 
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
 			return -EFAULT;
@@ -418,7 +418,7 @@ sparc_sigaction (int sig, const struct o
 		 * deadlock us if we held the signal lock on SMP.  So for
 		 * now I take the easy way out and do no locking.
 		 */
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
 			return -EFAULT;
diff -urp linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/sys_sunos.c linux-2.6.11-rc1-bk4/arch/sparc/kernel/sys_sunos.c
--- linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/sys_sunos.c	2004-12-24 22:34:32.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sparc/kernel/sys_sunos.c	2005-01-17 00:43:13.000000000 +0100
@@ -1131,7 +1131,7 @@ sunos_sigaction(int sig, const struct ol
 	if (act) {
 		old_sigset_t mask;
 
-		if (verify_area(VERIFY_READ, act, sizeof(*act)) ||
+		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
 		    __get_user(new_ka.sa.sa_flags, &act->sa_flags))
 			return -EFAULT;
@@ -1152,7 +1152,7 @@ sunos_sigaction(int sig, const struct ol
 		 * But then again we don't support SunOS lwp's anyways ;-)
 		 */
 		old_ka.sa.sa_flags ^= SUNOS_SV_INTERRUPT;
-		if (verify_area(VERIFY_WRITE, oact, sizeof(*oact)) ||
+		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
 		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags))
 			 return -EFAULT;
diff -urp linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/unaligned.c linux-2.6.11-rc1-bk4/arch/sparc/kernel/unaligned.c
--- linux-2.6.11-rc1-bk4-orig/arch/sparc/kernel/unaligned.c	2004-12-24 22:35:24.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sparc/kernel/unaligned.c	2005-01-17 00:47:02.000000000 +0100
@@ -428,40 +428,35 @@ static inline int ok_for_user(struct pt_
 			      enum direction dir)
 {
 	unsigned int reg;
-	int retval, check = (dir == load) ? VERIFY_READ : VERIFY_WRITE;
+	int check = (dir == load) ? VERIFY_READ : VERIFY_WRITE;
 	int size = ((insn >> 19) & 3) == 3 ? 8 : 4;
 
 	if ((regs->pc | regs->npc) & 3)
 		return 0;
 
-	/* Must verify_area() in all the necessary places. */
+	/* Must access_ok() in all the necessary places. */
 #define WINREG_ADDR(regnum) \
 	((void __user *)(((unsigned long *)regs->u_regs[UREG_FP])+(regnum)))
 
-	retval = 0;
 	reg = (insn >> 25) & 0x1f;
 	if (reg >= 16) {
-		retval = verify_area(check, WINREG_ADDR(reg - 16), size);
-		if (retval)
-			return retval;
+		if (!access_ok(check, WINREG_ADDR(reg - 16), size))
+			return -EFAULT;
 	}
 	reg = (insn >> 14) & 0x1f;
 	if (reg >= 16) {
-		retval = verify_area(check, WINREG_ADDR(reg - 16), size);
-		if (retval)
-			return retval;
+		if (!access_ok(check, WINREG_ADDR(reg - 16), size))
+			return -EFAULT;
 	}
 	if (!(insn & 0x2000)) {
 		reg = (insn & 0x1f);
 		if (reg >= 16) {
-			retval = verify_area(check, WINREG_ADDR(reg - 16),
-					     size);
-			if (retval)
-				return retval;
+			if (!access_ok(check, WINREG_ADDR(reg - 16), size))
+				return -EFAULT;
 		}
 	}
-	return retval;
 #undef WINREG_ADDR
+	return 0;
 }
 
 void user_mna_trap_fault(struct pt_regs *regs, unsigned int insn) __asm__ ("user_mna_trap_fault");
diff -urp linux-2.6.11-rc1-bk4-orig/arch/sparc64/kernel/binfmt_aout32.c linux-2.6.11-rc1-bk4/arch/sparc64/kernel/binfmt_aout32.c
--- linux-2.6.11-rc1-bk4-orig/arch/sparc64/kernel/binfmt_aout32.c	2005-01-16 21:27:11.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sparc64/kernel/binfmt_aout32.c	2005-01-17 00:47:27.000000000 +0100
@@ -114,9 +114,9 @@ static int aout32_core_dump(long signr, 
 
 /* make sure we actually have a data and stack area to dump */
 	set_fs(USER_DS);
-	if (verify_area(VERIFY_READ, (void __user *) START_DATA(dump), dump.u_dsize))
+	if (!access_ok(VERIFY_READ, (void __user *) START_DATA(dump), dump.u_dsize))
 		dump.u_dsize = 0;
-	if (verify_area(VERIFY_READ, (void __user *) START_STACK(dump), dump.u_ssize))
+	if (!access_ok(VERIFY_READ, (void __user *) START_STACK(dump), dump.u_ssize))
 		dump.u_ssize = 0;
 
 	set_fs(KERNEL_DS);
diff -urp linux-2.6.11-rc1-bk4-orig/arch/sparc64/kernel/signal32.c linux-2.6.11-rc1-bk4/arch/sparc64/kernel/signal32.c
--- linux-2.6.11-rc1-bk4-orig/arch/sparc64/kernel/signal32.c	2005-01-12 23:26:03.000000000 +0100
+++ linux-2.6.11-rc1-bk4/arch/sparc64/kernel/signal32.c	2005-01-17 00:48:26.000000000 +0100
@@ -351,7 +351,7 @@ void do_new_sigreturn32(struct pt_regs *
 	sf = (struct new_signal_frame32 __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (verify_area(VERIFY_READ, sf, sizeof(*sf))	||
+	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)) ||
 	    (((unsigned long) sf) & 3))
 		goto segv;
 
@@ -436,7 +436,7 @@ asmlinkage void do_sigreturn32(struct pt
 	scptr = (struct sigcontext32 __user *)
 		(regs->u_regs[UREG_I0] & 0x00000000ffffffffUL);
 	/* Check sanity of the user arg. */
-	if (verify_area(VERIFY_READ, scptr, sizeof(struct sigcontext32)) ||
+	if (!access_ok(VERIFY_READ, scptr, sizeof(struct sigcontext32)) ||
 	    (((unsigned long) scptr) & 3))
 		goto segv;
 
@@ -504,7 +504,7 @@ asmlinkage void do_rt_sigreturn32(struct
 	sf = (struct rt_signal_frame32 __user *) regs->u_regs[UREG_FP];
 
 	/* 1. Make sure we are not getting garbage from the user */
-	if (verify_area(VERIFY_READ, sf, sizeof(*sf))	||
+	if (!access_ok(VERIFY_READ, sf, sizeof(*sf)) ||
 	    (((unsigned long) sf) & 3))
 		goto segv;
 



