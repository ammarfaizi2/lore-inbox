Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268310AbUIKUwD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268310AbUIKUwD (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 11 Sep 2004 16:52:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268316AbUIKUwD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 11 Sep 2004 16:52:03 -0400
Received: from hcc022004.bai.ne.jp ([210.171.22.4]:41097 "HELO
	tigger.internet.email.ne.jp") by vger.kernel.org with SMTP
	id S268310AbUIKUvH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 11 Sep 2004 16:51:07 -0400
Date: Sun, 12 Sep 2004 05:51:06 +0900 (JST)
Message-Id: <20040912.055106.640900214.takata@linux-m32r.org>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2.6.9-rc1-mm4 3/6] [m32r] Update to fix compile errors
From: Hirokazu Takata <takata@linux-m32r.org>
Cc: linux-kernel@vger.kernel.org, takata@linux-m32r.org
In-Reply-To: <20040912.052403.730551818.takata@linux-m32r.org>
References: <20040912.052403.730551818.takata@linux-m32r.org>Fcc: +backup
X-Mailer: Mew version 3.3 on XEmacs 21.4.15 (Security Through Obscurity)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH 2.6.9-rc1-mm4 3/6] [m32r] Update to fix compile errors
  This patch updates code to fix compile errors, and so on.

	* arch/m32r/kernel/Makefile:
	Change linker script's name from vmlinux.lds.s to vmlinux.lds.

	* arch/m32r/kernel/process.c (sys_clone):
	Fix the first parameter of do_fork() call.

	* arch/m32r/kernel/signal.c: 
	(handle_signal): Add a new second argument, struct k_sigaction *ka.
	(do_signal): Change get_signal_to_deliver() interface.

	* include/asm-m32r/hardirq.h:
	Some declarations are moved to linux/hardirq.h.

	* include/asm-m32r/page.h:
	Add devmem_is_allowed() macro.

Signed-off-by: Hirokazu Takata <takata@linux-m32r.org>
---

 arch/m32r/kernel/Makefile  |    2 -
 arch/m32r/kernel/process.c |    5 +--
 arch/m32r/kernel/signal.c  |   68 +++++++++++++++++++++++++--------------------
 include/asm-m32r/hardirq.h |   18 -----------
 include/asm-m32r/page.h    |    4 +-
 5 files changed, 43 insertions(+), 54 deletions(-)


diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/Makefile linux-2.6.9-rc1-mm4/arch/m32r/kernel/Makefile
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/Makefile	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/kernel/Makefile	2004-09-09 01:39:58.000000000 +0900
@@ -2,7 +2,7 @@
 # Makefile for the Linux/M32R kernel.
 #
 
-extra-y	:= head.o init_task.o vmlinux.lds.s
+extra-y	:= head.o init_task.o vmlinux.lds
 
 obj-y	:= process.o entry.o traps.o align.o irq.o setup.o time.o \
 	m32r_ksyms.o sys_m32r.o semaphore.o signal.o ptrace.o
diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/process.c linux-2.6.9-rc1-mm4/arch/m32r/kernel/process.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/process.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/kernel/process.c	2004-09-09 01:39:58.000000000 +0900
@@ -27,8 +27,8 @@
 #include <linux/ptrace.h>
 #include <linux/unistd.h>
 #include <linux/slab.h>
+#include <linux/hardirq.h>
 
-#include <asm/hardirq.h>
 #include <asm/io.h>
 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -298,8 +298,7 @@ asmlinkage int sys_clone(unsigned long c
 	if (!newsp)
 		newsp = regs.spu;
 
-	return do_fork(clone_flags & ~CLONE_IDLETASK, newsp, &regs, 0, NULL,
-			NULL);
+	return do_fork(clone_flags, newsp, &regs, 0, NULL, NULL);
 }
 
 /*
diff -ruNp linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/signal.c linux-2.6.9-rc1-mm4/arch/m32r/kernel/signal.c
--- linux-2.6.9-rc1-mm4.orig/arch/m32r/kernel/signal.c	2004-09-08 08:14:03.000000000 +0900
+++ linux-2.6.9-rc1-mm4/arch/m32r/kernel/signal.c	2004-09-09 01:39:58.000000000 +0900
@@ -1,6 +1,5 @@
 /*
  *  linux/arch/m32r/kernel/signal.c
- *    orig : i386 2.5.67
  *
  *  Copyright (c) 2003  Hitoshi Yamamoto
  *
@@ -37,9 +36,10 @@ int do_signal(struct pt_regs *, sigset_t
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-asmlinkage int sys_sigsuspend(old_sigset_t mask, unsigned long r1,
-	unsigned long r2, unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, struct pt_regs regs)
+asmlinkage int
+sys_sigsuspend(old_sigset_t mask, unsigned long r1,
+	       unsigned long r2, unsigned long r3, unsigned long r4,
+	       unsigned long r5, unsigned long r6, struct pt_regs regs)
 {
 	sigset_t saveset;
 
@@ -59,9 +59,10 @@ asmlinkage int sys_sigsuspend(old_sigset
 	}
 }
 
-asmlinkage int sys_rt_sigsuspend(sigset_t *unewset, size_t sigsetsize,
-	unsigned long r2, unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, struct pt_regs regs)
+asmlinkage int
+sys_rt_sigsuspend(sigset_t *unewset, size_t sigsetsize,
+		  unsigned long r2, unsigned long r3, unsigned long r4,
+		  unsigned long r5, unsigned long r6, struct pt_regs regs)
 {
 	sigset_t saveset, newset;
 
@@ -88,7 +89,8 @@ asmlinkage int sys_rt_sigsuspend(sigset_
 	}
 }
 
-asmlinkage int sys_sigaction(int sig, const struct old_sigaction __user *act,
+asmlinkage int
+sys_sigaction(int sig, const struct old_sigaction __user *act,
 	      struct old_sigaction __user *oact)
 {
 	struct k_sigaction new_ka, old_ka;
@@ -119,9 +121,10 @@ asmlinkage int sys_sigaction(int sig, co
 	return ret;
 }
 
-asmlinkage int sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
-	unsigned long r2, unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, struct pt_regs regs)
+asmlinkage int
+sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
+		unsigned long r2, unsigned long r3, unsigned long r4,
+		unsigned long r5, unsigned long r6, struct pt_regs regs)
 {
 	return do_sigaltstack(uss, uoss, regs.spu);
 }
@@ -153,8 +156,9 @@ struct rt_sigframe
 	char retcode[8];
 };
 
-static int restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
-	int *r0_p)
+static int
+restore_sigcontext(struct pt_regs *regs, struct sigcontext __user *sc,
+		   int *r0_p)
 {
 	unsigned int err = 0;
 
@@ -203,9 +207,10 @@ static int restore_sigcontext(struct pt_
 	return err;
 }
 
-asmlinkage int sys_sigreturn(unsigned long r0, unsigned long r1,
-	unsigned long r2, unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, struct pt_regs regs)
+asmlinkage int
+sys_sigreturn(unsigned long r0, unsigned long r1,
+	      unsigned long r2, unsigned long r3, unsigned long r4,
+	      unsigned long r5, unsigned long r6, struct pt_regs regs)
 {
 	struct sigframe __user *frame = (struct sigframe __user *)regs.spu;
 	sigset_t set;
@@ -234,9 +239,10 @@ badframe:
 	return 0;
 }
 
-asmlinkage int sys_rt_sigreturn(unsigned long r0, unsigned long r1,
-	unsigned long r2, unsigned long r3, unsigned long r4,
-	unsigned long r5, unsigned long r6, struct pt_regs regs)
+asmlinkage int
+sys_rt_sigreturn(unsigned long r0, unsigned long r1,
+		 unsigned long r2, unsigned long r3, unsigned long r4,
+		 unsigned long r5, unsigned long r6, struct pt_regs regs)
 {
 	struct rt_sigframe __user *frame = (struct rt_sigframe __user *)regs.spu;
 	sigset_t set;
@@ -274,8 +280,9 @@ badframe:
  * Set up a signal frame.
  */
 
-static int setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
-	unsigned long mask)
+static int
+setup_sigcontext(struct sigcontext __user *sc, struct pt_regs *regs,
+	         unsigned long mask)
 {
 	int err = 0;
 
@@ -323,8 +330,8 @@ static int setup_sigcontext(struct sigco
 /*
  * Determine which stack to use..
  */
-static __inline__ void __user *get_sigframe(struct k_sigaction *ka, unsigned long sp,
-	size_t frame_size)
+static inline void __user *
+get_sigframe(struct k_sigaction *ka, unsigned long sp, size_t frame_size)
 {
 	/* This is the X/Open sanctioned signal stack switching.  */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
@@ -336,7 +343,7 @@ static __inline__ void __user *get_sigfr
 }
 
 static void setup_frame(int sig, struct k_sigaction *ka,
-	sigset_t *set, struct pt_regs *regs)
+			sigset_t *set, struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
 	int err = 0;
@@ -403,7 +410,7 @@ give_sigsegv:
 }
 
 static void setup_rt_frame(int sig, struct k_sigaction *ka, siginfo_t *info,
-	sigset_t *set, struct pt_regs *regs)
+			   sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	int err = 0;
@@ -484,10 +491,10 @@ give_sigsegv:
  * OK, we're invoking a handler
  */
 
-static void handle_signal(unsigned long sig, siginfo_t *info, sigset_t *oldset,
-	struct pt_regs *regs)
+static void
+handle_signal(unsigned long sig, struct k_sigaction *ka, siginfo_t *info,
+	      sigset_t *oldset, struct pt_regs *regs)
 {
-	struct k_sigaction *ka = &current->sighand->action[sig-1];
 	unsigned short inst;
 
 	/* Are we from a system call? */
@@ -542,6 +549,7 @@ int do_signal(struct pt_regs *regs, sigs
 {
 	siginfo_t info;
 	int signr;
+	struct k_sigaction ka;
 	unsigned short inst;
 
 	/*
@@ -561,7 +569,7 @@ int do_signal(struct pt_regs *regs, sigs
 	if (!oldset)
 		oldset = &current->blocked;
 
-	signr = get_signal_to_deliver(&info, regs, NULL);
+	signr = get_signal_to_deliver(&info, &ka, regs, NULL);
 	if (signr > 0) {
 		/* Reenable any watchpoints before delivering the
 		 * signal to user space. The processor register will
@@ -570,7 +578,7 @@ int do_signal(struct pt_regs *regs, sigs
 		 */
 
 		/* Whee!  Actually deliver the signal.  */
-		handle_signal(signr, &info, oldset, regs);
+		handle_signal(signr, &ka, &info, oldset, regs);
 		return 1;
 	}
 
diff -ruNp linux-2.6.9-rc1-mm4.orig/include/asm-m32r/hardirq.h linux-2.6.9-rc1-mm4/include/asm-m32r/hardirq.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/hardirq.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4/include/asm-m32r/hardirq.h	2004-09-12 04:33:43.000000000 +0900
@@ -1,10 +1,6 @@
 #ifndef __ASM_HARDIRQ_H
 #define __ASM_HARDIRQ_H
 
-/* $Id$ */
-
-/* orig : i386 2.5.67 */
-
 #include <linux/config.h>
 #include <linux/threads.h>
 #include <linux/irq.h>
@@ -40,20 +36,6 @@ typedef struct {
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
 #define HARDIRQ_SHIFT	(SOFTIRQ_SHIFT + SOFTIRQ_BITS)
 
-#define __MASK(x)	((1UL << (x))-1)
-
-#define PREEMPT_MASK	(__MASK(PREEMPT_BITS) << PREEMPT_SHIFT)
-#define HARDIRQ_MASK	(__MASK(HARDIRQ_BITS) << HARDIRQ_SHIFT)
-#define SOFTIRQ_MASK	(__MASK(SOFTIRQ_BITS) << SOFTIRQ_SHIFT)
-
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
-#define softirq_count()	(preempt_count() & SOFTIRQ_MASK)
-#define irq_count()	(preempt_count() & (HARDIRQ_MASK | SOFTIRQ_MASK))
-
-#define PREEMPT_OFFSET	(1UL << PREEMPT_SHIFT)
-#define SOFTIRQ_OFFSET	(1UL << SOFTIRQ_SHIFT)
-#define HARDIRQ_OFFSET	(1UL << HARDIRQ_SHIFT)
-
 /*
  * The hardirq mask has to be large enough to have
  * space for potentially all IRQ sources in the system
diff -ruNp linux-2.6.9-rc1-mm4.orig/include/asm-m32r/page.h linux-2.6.9-rc1-mm4/include/asm-m32r/page.h
--- linux-2.6.9-rc1-mm4.orig/include/asm-m32r/page.h	2004-09-08 08:14:17.000000000 +0900
+++ linux-2.6.9-rc1-mm4/include/asm-m32r/page.h	2004-09-12 04:34:07.000000000 +0900
@@ -1,8 +1,6 @@
 #ifndef _ASM_M32R_PAGE_H
 #define _ASM_M32R_PAGE_H
 
-/* $Id$ */
-
 #include <linux/config.h>
 
 /* PAGE_SHIFT determines the page size */
@@ -106,6 +104,8 @@ static __inline__ int get_order(unsigned
 #define VM_DATA_DEFAULT_FLAGS	(VM_READ | VM_WRITE | VM_EXEC | \
 				 VM_MAYREAD | VM_MAYWRITE | VM_MAYEXEC )
 
+#define devmem_is_allowed(x) 1
+
 #endif /* __KERNEL__ */
 
 #endif /* _ASM_M32R_PAGE_H */

--
Hirokazu Takata <takata@linux-m32r.org>
Linux/M32R Project:  http://www.linux-m32r.org/
