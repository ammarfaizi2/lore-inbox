Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161285AbWBUCak@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161285AbWBUCak (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Feb 2006 21:30:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161287AbWBUCaj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Feb 2006 21:30:39 -0500
Received: from mail.renesas.com ([202.234.163.13]:46735 "EHLO
	mail02.idc.renesas.com") by vger.kernel.org with ESMTP
	id S1161285AbWBUCaj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Feb 2006 21:30:39 -0500
Date: Tue, 21 Feb 2006 11:30:32 +0900 (JST)
Message-Id: <20060221.113032.783375446.takata.hirokazu@renesas.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, fujiwara@linux-m32r.org,
       takata@linux-m32r.org
Subject: [PATCH 2.6.16-rc3] m32r: fix and update for gcc-4.0
From: Hirokazu Takata <takata@linux-m32r.org>
X-Mailer: Mew version 3.3 on XEmacs 21.4.19 (Constant Variable)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix and update for gcc-4.0.

- arch/m32r/kernel/signal.c:
  Change type of the 8th parameter of sys_rt_sigsuspend() from
  'struct pt_regs' to 'struct pt_regs *'.
  This functions make use of the 'regs' parameter to return status value,
  but gcc-4.0 optimizes and removes it as a dead code.
  Functions, sys_sigaltstack() and sys_rt_sigreturn(), have also modified.
  
- arch/m32r/lib/usercopy.c, include/asm-m32r/uaccess.h:
  Add early-clobber constraints('&') to output values of asm statements;
  these constraints seems to be required for gcc-4.0 register assignment.

Signed-off-by: Hayato Fujiwara <fujiwara@linux-m32r.org>
Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/signal.c  |   24 ++++++++++--------------
 arch/m32r/lib/usercopy.c   |    4 ++--
 include/asm-m32r/uaccess.h |    8 ++++----
 3 files changed, 16 insertions(+), 20 deletions(-)

Index: b/arch/m32r/kernel/signal.c
===================================================================
--- b.orig/arch/m32r/kernel/signal.c	2005-11-03 17:16:58.508114928 +0900
+++ b/arch/m32r/kernel/signal.c	2005-11-03 18:57:09.715272536 +0900
@@ -36,7 +36,7 @@ int do_signal(struct pt_regs *, sigset_t
 asmlinkage int
 sys_rt_sigsuspend(sigset_t *unewset, size_t sigsetsize,
 		  unsigned long r2, unsigned long r3, unsigned long r4,
-		  unsigned long r5, unsigned long r6, struct pt_regs regs)
+		  unsigned long r5, unsigned long r6, struct pt_regs *regs)
 {
 	sigset_t saveset, newset;
 
@@ -54,21 +54,21 @@ sys_rt_sigsuspend(sigset_t *unewset, siz
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	regs.r0 = -EINTR;
+	regs->r0 = -EINTR;
 	while (1) {
 		current->state = TASK_INTERRUPTIBLE;
 		schedule();
-		if (do_signal(&regs, &saveset))
-			return regs.r0;
+		if (do_signal(regs, &saveset))
+			return regs->r0;
 	}
 }
 
 asmlinkage int
 sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
 		unsigned long r2, unsigned long r3, unsigned long r4,
-		unsigned long r5, unsigned long r6, struct pt_regs regs)
+		unsigned long r5, unsigned long r6, struct pt_regs *regs)
 {
-	return do_sigaltstack(uss, uoss, regs.spu);
+	return do_sigaltstack(uss, uoss, regs->spu);
 }
 
 
@@ -140,11 +140,10 @@ restore_sigcontext(struct pt_regs *regs,
 asmlinkage int
 sys_rt_sigreturn(unsigned long r0, unsigned long r1,
 		 unsigned long r2, unsigned long r3, unsigned long r4,
-		 unsigned long r5, unsigned long r6, struct pt_regs regs)
+		 unsigned long r5, unsigned long r6, struct pt_regs *regs)
 {
-	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)regs.spu;
+	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)regs->spu;
 	sigset_t set;
-	stack_t st;
 	int result;
 
 	if (!access_ok(VERIFY_READ, frame, sizeof(*frame)))
@@ -158,14 +157,11 @@ sys_rt_sigreturn(unsigned long r0, unsig
 	recalc_sigpending();
 	spin_unlock_irq(&current->sighand->siglock);
 
-	if (restore_sigcontext(&regs, &frame->uc.uc_mcontext, &result))
+	if (restore_sigcontext(regs, &frame->uc.uc_mcontext, &result))
 		goto badframe;
 
-	if (__copy_from_user(&st, &frame->uc.uc_stack, sizeof(st)))
+	if (do_sigaltstack(&frame->uc.uc_stack, NULL, regs->spu) == -EFAULT)
 		goto badframe;
-	/* It is more difficult to avoid calling this function than to
-	   call it and ignore errors.  */
-	do_sigaltstack(&st, NULL, regs.spu);
 
 	return result;
 
Index: b/arch/m32r/lib/usercopy.c
===================================================================
--- b.orig/arch/m32r/lib/usercopy.c	2005-11-03 17:16:58.521112952 +0900
+++ b/arch/m32r/lib/usercopy.c	2005-11-03 18:17:20.707456928 +0900
@@ -64,7 +64,7 @@ do {									\
 		"	.balign 4\n"					\
 		"	.long 0b,3b\n"					\
 		".previous"						\
-		: "=r"(res), "=r"(count), "=&r" (__d0), "=&r" (__d1),	\
+		: "=&r"(res), "=&r"(count), "=&r" (__d0), "=&r" (__d1),	\
 		  "=&r" (__d2)						\
 		: "i"(-EFAULT), "0"(count), "1"(count), "3"(src), 	\
 		  "4"(dst)						\
@@ -101,7 +101,7 @@ do {									\
 		"	.balign 4\n"					\
 		"	.long 0b,3b\n"					\
 		".previous"						\
-		: "=r"(res), "=r"(count), "=&r" (__d0), "=&r" (__d1),	\
+		: "=&r"(res), "=&r"(count), "=&r" (__d0), "=&r" (__d1),	\
 		  "=&r" (__d2)						\
 		: "i"(-EFAULT), "0"(count), "1"(count), "3"(src),	\
 		  "4"(dst)						\
Index: b/include/asm-m32r/uaccess.h
===================================================================
--- b.orig/include/asm-m32r/uaccess.h	2005-11-03 17:16:58.533111128 +0900
+++ b/include/asm-m32r/uaccess.h	2005-11-03 18:17:20.717455408 +0900
@@ -328,7 +328,7 @@ extern void __put_user_bad(void);
                 "       .long 1b,4b\n"                                  \
                 "       .long 2b,4b\n"                                  \
                 ".previous"                                             \
-                : "=r"(err)                                             \
+                : "=&r"(err)                                             \
                 : "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
                 : "r14", "memory")
 
@@ -353,7 +353,7 @@ extern void __put_user_bad(void);
 		"	.long 1b,4b\n"					\
 		"	.long 2b,4b\n"					\
 		".previous"						\
-		: "=r"(err)						\
+		: "=&r"(err)						\
 		: "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
 		: "r14", "memory")
 #else
@@ -398,7 +398,7 @@ struct __large_struct { unsigned long bu
 		"	.balign 4\n"					\
 		"	.long 1b,3b\n"					\
 		".previous"						\
-		: "=r"(err)						\
+		: "=&r"(err)						\
 		: "r"(x), "r"(addr), "i"(-EFAULT), "0"(err)		\
 		: "r14", "memory")
 
@@ -442,7 +442,7 @@ do {									\
 		"	.balign 4\n"					\
 		"	.long 1b,3b\n"					\
 		".previous"						\
-		: "=r"(err), "=&r"(x)					\
+		: "=&r"(err), "=&r"(x)					\
 		: "r"(addr), "i"(-EFAULT), "0"(err)			\
 		: "r14", "memory")
 
--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
