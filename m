Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267505AbSLSC3p>; Wed, 18 Dec 2002 21:29:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267526AbSLSC3p>; Wed, 18 Dec 2002 21:29:45 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:18593 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267505AbSLSC2B>; Wed, 18 Dec 2002 21:28:01 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH] [v850]  Add v850 support for `sys_restart_syscall'
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20021219023359.BF8513703@mcspd15.ucom.lsi.nec.co.jp>
Date: Thu, 19 Dec 2002 11:33:59 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/entry.S arch/v850/kernel/entry.S
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/entry.S	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/kernel/entry.S	2002-12-17 17:23:49.000000000 +0900
@@ -781,7 +781,7 @@
 	
 	.align 4
 C_DATA(sys_call_table):
-	.long CSYM(sys_ni_syscall)	// 0  -  old "setup()" system call
+	.long CSYM(sys_restart_syscall)	// 0
 	.long CSYM(sys_exit)
 	.long sys_fork_wrapper
 	.long CSYM(sys_read)
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/arch/v850/kernel/signal.c arch/v850/kernel/signal.c
--- ../orig/linux-2.5.52-uc0/arch/v850/kernel/signal.c	2002-11-28 10:24:54.000000000 +0900
+++ arch/v850/kernel/signal.c	2002-12-17 17:23:49.000000000 +0900
@@ -440,19 +440,23 @@
 	if (PT_REGS_SYSCALL (regs)) {
 		/* If so, check system call restarting.. */
 		switch (regs->gpr[GPR_RVAL]) {
-			case -ERESTARTNOHAND:
+		case -ERESTART_RESTARTBLOCK:
+			current_thread_info()->restart_block.fn =
+				do_no_restart_syscall;
+			/* fall through */
+		case -ERESTARTNOHAND:
+			regs->gpr[GPR_RVAL] = -EINTR;
+			break;
+
+		case -ERESTARTSYS:
+			if (!(ka->sa.sa_flags & SA_RESTART)) {
 				regs->gpr[GPR_RVAL] = -EINTR;
 				break;
-
-			case -ERESTARTSYS:
-				if (!(ka->sa.sa_flags & SA_RESTART)) {
-					regs->gpr[GPR_RVAL] = -EINTR;
-					break;
-				}
+			}
 			/* fallthrough */
-			case -ERESTARTNOINTR:
-				regs->gpr[12] = PT_REGS_SYSCALL (regs);
-				regs->pc -= 4; /* Size of `trap 0' insn.  */
+		case -ERESTARTNOINTR:
+			regs->gpr[12] = PT_REGS_SYSCALL (regs);
+			regs->pc -= 4; /* Size of `trap 0' insn.  */
 		}
 
 		PT_REGS_SET_SYSCALL (regs, 0);
@@ -511,14 +515,19 @@
 
 	/* Did we come from a system call? */
 	if (PT_REGS_SYSCALL (regs)) {
+		int rval = (int)regs->gpr[GPR_RVAL];
 		/* Restart the system call - no handlers present */
-		if (regs->gpr[GPR_RVAL] == (v850_reg_t)-ERESTARTNOHAND ||
-		    regs->gpr[GPR_RVAL] == (v850_reg_t)-ERESTARTSYS ||
-		    regs->gpr[GPR_RVAL] == (v850_reg_t)-ERESTARTNOINTR)
+		if (rval == -ERESTARTNOHAND
+		    || rval == -ERESTARTSYS
+		    || rval == -ERESTARTNOINTR)
 		{
 			regs->gpr[12] = PT_REGS_SYSCALL (regs);
 			regs->pc -= 4; /* Size of `trap 0' insn.  */
 		}
+		else if (rval == -ERESTART_RESTARTBLOCK) {
+			regs->gpr[12] = __NR_restart_syscall;
+			regs->pc -= 4; /* Size of `trap 0' insn.  */
+		}
 	}
 	return 0;
 }
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/include/asm-v850/current.h include/asm-v850/current.h
--- ../orig/linux-2.5.52-uc0/include/asm-v850/current.h	2002-11-05 11:25:31.000000000 +0900
+++ include/asm-v850/current.h	2002-12-17 17:23:49.000000000 +0900
@@ -14,8 +14,11 @@
 #ifndef __V850_CURRENT_H__
 #define __V850_CURRENT_H__
 
+#ifndef __ASSEMBLY__ /* <linux/thread_info.h> is not asm-safe.  */
+#include <linux/thread_info.h>
+#endif
+
 #include <asm/macrology.h>
-#include <asm/thread_info.h>
 
 
 /* Register used to hold the current task pointer while in the kernel.
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/include/asm-v850/processor.h include/asm-v850/processor.h
--- ../orig/linux-2.5.52-uc0/include/asm-v850/processor.h	2002-11-28 10:25:08.000000000 +0900
+++ include/asm-v850/processor.h	2002-12-17 17:23:49.000000000 +0900
@@ -15,9 +15,11 @@
 #define __V850_PROCESSOR_H__
 
 #include <linux/config.h>
+#ifndef __ASSEMBLY__ /* <linux/thread_info.h> is not asm-safe.  */
+#include <linux/thread_info.h>
+#endif
 
 #include <asm/ptrace.h>
-#include <asm/thread_info.h>
 #include <asm/entry.h>
 
 /* Some code expects `segment' stuff to be defined here.  */
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/include/asm-v850/thread_info.h include/asm-v850/thread_info.h
--- ../orig/linux-2.5.52-uc0/include/asm-v850/thread_info.h	2002-11-05 11:25:32.000000000 +0900
+++ include/asm-v850/thread_info.h	2002-12-17 17:23:49.000000000 +0900
@@ -31,15 +31,19 @@
 	unsigned long		flags;		/* low level flags */
 	int			cpu;		/* cpu we're on */
 	int			preempt_count;
+	struct restart_block	restart_block;
 };
 
-#define INIT_THREAD_INFO(tsk)			\
-{						\
-	.task =		&tsk,			\
-	.exec_domain =	&default_exec_domain,	\
-	.flags =	0,			\
-	.cpu =		0,			\
-	.preempt_count = 1			\
+#define INIT_THREAD_INFO(tsk)						      \
+{									      \
+	.task =		&tsk,						      \
+	.exec_domain =	&default_exec_domain,				      \
+	.flags =	0,						      \
+	.cpu =		0,						      \
+	.preempt_count = 1,						      \
+	.restart_block = {						      \
+		.fn = do_no_restart_syscall,				      \
+	},								      \
 }
 
 #define init_thread_info	(init_thread_union.thread_info)
@@ -67,8 +71,6 @@
 #define TI_FLAGS	8
 #define TI_CPU		12
 #define TI_PREEMPT	16
-#define TI_SOFTIRQ	20
-#define TI_HARDIRQ	24
 
 #define PREEMPT_ACTIVE		0x4000000
 
diff -ruN -X../cludes ../orig/linux-2.5.52-uc0/include/asm-v850/unistd.h include/asm-v850/unistd.h
--- ../orig/linux-2.5.52-uc0/include/asm-v850/unistd.h	2002-11-28 10:25:08.000000000 +0900
+++ include/asm-v850/unistd.h	2002-12-17 17:23:49.000000000 +0900
@@ -16,6 +16,7 @@
 
 #include <asm/clinkage.h>
 
+#define __NR_restart_syscall	  0
 #define __NR_exit		  1
 #define __NR_fork		  2
 #define __NR_read		  3
