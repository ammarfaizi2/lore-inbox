Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752129AbWJZJCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752129AbWJZJCZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Oct 2006 05:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752127AbWJZJCZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Oct 2006 05:02:25 -0400
Received: from mtagate3.de.ibm.com ([195.212.29.152]:44797 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1752126AbWJZJCW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Oct 2006 05:02:22 -0400
Date: Thu, 26 Oct 2006 11:02:20 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: linux-kernel@vger.kernel.org, heiko.carstens@de.ibm.com
Subject: [S390] uaccess error handling.
Message-ID: <20061026090220.GC16270@skybase>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Heiko Carstens <heiko.carstens@de.ibm.com>

[S390] uaccess error handling.

Consider return values for all user space access function and
return -EFAULT on error.

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---

 arch/s390/kernel/compat_linux.c  |    4 +++-
 arch/s390/kernel/compat_signal.c |   12 ++++++------
 arch/s390/kernel/signal.c        |   12 ++++++------
 arch/s390/kernel/traps.c         |   20 +++++++++++++-------
 4 files changed, 28 insertions(+), 20 deletions(-)

diff -urpN linux-2.6/arch/s390/kernel/compat_linux.c linux-2.6-patched/arch/s390/kernel/compat_linux.c
--- linux-2.6/arch/s390/kernel/compat_linux.c	2006-10-26 10:43:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_linux.c	2006-10-26 10:44:04.000000000 +0200
@@ -757,7 +757,9 @@ asmlinkage long sys32_sysctl(struct __sy
 			    put_user(oldlen, (u32 __user *)compat_ptr(tmp.oldlenp)))
 				error = -EFAULT;
 		}
-		copy_to_user(args->__unused, tmp.__unused, sizeof(tmp.__unused));
+		if (copy_to_user(args->__unused, tmp.__unused,
+				 sizeof(tmp.__unused)))
+			error = -EFAULT;
 	}
 	return error;
 }
diff -urpN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-patched/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	2006-09-20 05:42:06.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/compat_signal.c	2006-10-26 10:44:04.000000000 +0200
@@ -169,12 +169,12 @@ sys32_sigaction(int sig, const struct ol
 		compat_old_sigset_t mask;
 		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(sa_handler, &act->sa_handler) ||
-		    __get_user(sa_restorer, &act->sa_restorer))
+		    __get_user(sa_restorer, &act->sa_restorer) ||
+		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
+		    __get_user(mask, &act->sa_mask))
 			return -EFAULT;
 		new_ka.sa.sa_handler = (__sighandler_t) sa_handler;
 		new_ka.sa.sa_restorer = (void (*)(void)) sa_restorer;
-		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
-		__get_user(mask, &act->sa_mask);
 		siginitset(&new_ka.sa.sa_mask, mask);
         }
 
@@ -185,10 +185,10 @@ sys32_sigaction(int sig, const struct ol
 		sa_restorer = (unsigned long) old_ka.sa.sa_restorer;
 		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(sa_handler, &oact->sa_handler) ||
-		    __put_user(sa_restorer, &oact->sa_restorer))
+		    __put_user(sa_restorer, &oact->sa_restorer) ||
+		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
+		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
 			return -EFAULT;
-		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
-		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
         }
 
 	return ret;
diff -urpN linux-2.6/arch/s390/kernel/signal.c linux-2.6-patched/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	2006-10-26 10:43:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/signal.c	2006-10-26 10:44:04.000000000 +0200
@@ -80,10 +80,10 @@ sys_sigaction(int sig, const struct old_
 		old_sigset_t mask;
 		if (!access_ok(VERIFY_READ, act, sizeof(*act)) ||
 		    __get_user(new_ka.sa.sa_handler, &act->sa_handler) ||
-		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer))
+		    __get_user(new_ka.sa.sa_restorer, &act->sa_restorer) ||
+		    __get_user(new_ka.sa.sa_flags, &act->sa_flags) ||
+		    __get_user(mask, &act->sa_mask))
 			return -EFAULT;
-		__get_user(new_ka.sa.sa_flags, &act->sa_flags);
-		__get_user(mask, &act->sa_mask);
 		siginitset(&new_ka.sa.sa_mask, mask);
 	}
 
@@ -92,10 +92,10 @@ sys_sigaction(int sig, const struct old_
 	if (!ret && oact) {
 		if (!access_ok(VERIFY_WRITE, oact, sizeof(*oact)) ||
 		    __put_user(old_ka.sa.sa_handler, &oact->sa_handler) ||
-		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer))
+		    __put_user(old_ka.sa.sa_restorer, &oact->sa_restorer) ||
+		    __put_user(old_ka.sa.sa_flags, &oact->sa_flags) ||
+		    __put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask))
 			return -EFAULT;
-		__put_user(old_ka.sa.sa_flags, &oact->sa_flags);
-		__put_user(old_ka.sa.sa_mask.sig[0], &oact->sa_mask);
 	}
 
 	return ret;
diff -urpN linux-2.6/arch/s390/kernel/traps.c linux-2.6-patched/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	2006-10-26 10:43:38.000000000 +0200
+++ linux-2.6-patched/arch/s390/kernel/traps.c	2006-10-26 10:44:04.000000000 +0200
@@ -462,7 +462,8 @@ asmlinkage void illegal_op(struct pt_reg
 		local_irq_enable();
 
 	if (regs->psw.mask & PSW_MASK_PSTATE) {
-		get_user(*((__u16 *) opcode), (__u16 __user *) location);
+		if (get_user(*((__u16 *) opcode), (__u16 __user *) location))
+			return;
 		if (*((__u16 *) opcode) == S390_BREAKPOINT_U16) {
 			if (current->ptrace & PT_PTRACED)
 				force_sig(SIGTRAP, current);
@@ -470,20 +471,25 @@ asmlinkage void illegal_op(struct pt_reg
 				signal = SIGILL;
 #ifdef CONFIG_MATHEMU
 		} else if (opcode[0] == 0xb3) {
-			get_user(*((__u16 *) (opcode+2)), location+1);
+			if (get_user(*((__u16 *) (opcode+2)), location+1))
+				return;
 			signal = math_emu_b3(opcode, regs);
                 } else if (opcode[0] == 0xed) {
-			get_user(*((__u32 *) (opcode+2)),
-				 (__u32 __user *)(location+1));
+			if (get_user(*((__u32 *) (opcode+2)),
+				     (__u32 __user *)(location+1)))
+				return;
 			signal = math_emu_ed(opcode, regs);
 		} else if (*((__u16 *) opcode) == 0xb299) {
-			get_user(*((__u16 *) (opcode+2)), location+1);
+			if (get_user(*((__u16 *) (opcode+2)), location+1))
+				return;
 			signal = math_emu_srnm(opcode, regs);
 		} else if (*((__u16 *) opcode) == 0xb29c) {
-			get_user(*((__u16 *) (opcode+2)), location+1);
+			if (get_user(*((__u16 *) (opcode+2)), location+1))
+				return;
 			signal = math_emu_stfpc(opcode, regs);
 		} else if (*((__u16 *) opcode) == 0xb29d) {
-			get_user(*((__u16 *) (opcode+2)), location+1);
+			if (get_user(*((__u16 *) (opcode+2)), location+1))
+				return;
 			signal = math_emu_lfpc(opcode, regs);
 #endif
 		} else
