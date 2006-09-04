Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932132AbWIDLFY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932132AbWIDLFY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 07:05:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932141AbWIDLFY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 07:05:24 -0400
Received: from nat-132.atmel.no ([80.232.32.132]:61907 "EHLO relay.atmel.no")
	by vger.kernel.org with ESMTP id S932132AbWIDLFX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 07:05:23 -0400
Date: Mon, 4 Sep 2006 13:05:08 +0200
From: Haavard Skinnemoen <hskinnemoen@atmel.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>
Subject: [-mm patch] AVR32: Implement kernel_execve
Message-ID: <20060904130508.05ea3a4e@cad-250-152.norway.atmel.com>
Organization: Atmel Norway
X-Mailer: Sylpheed-Claws 2.4.0 (GTK+ 2.8.18; i486-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Move execve() into arch/avr32/kernel/sys_avr32.c, rename it to
kernel_execve() and return the syscall return value directly without
setting errno.

This also gets rid of the __KERNEL_SYSCALLS__ stuff from unistd.h
and expands #ifdef __KERNEL__ to cover everything in unistd.h except
the __NR_foo definitions.

Signed-off-by: Haavard Skinnemoen <hskinnemoen@atmel.com>

---
 arch/avr32/kernel/sys_avr32.c |   14 +++++++
 include/asm-avr32/unistd.h    |   80 +-----------------------------------------
 2 files changed, 17 insertions(+), 77 deletions(-)

Index: linux-2.6.18-rc5-mm1/arch/avr32/kernel/sys_avr32.c
===================================================================
--- linux-2.6.18-rc5-mm1.orig/arch/avr32/kernel/sys_avr32.c	2006-09-04 11:34:13.000000000 +0200
+++ linux-2.6.18-rc5-mm1/arch/avr32/kernel/sys_avr32.c	2006-09-04 12:57:34.000000000 +0200
@@ -49,3 +49,17 @@ asmlinkage long sys_mmap2(unsigned long 
 		fput(file);
 	return error;
 }
+
+int kernel_execve(const char *file, char **argv, char **envp)
+{
+	register long scno asm("r8") = __NR_execve;
+	register long sc1 asm("r12") = (long)file;
+	register long sc2 asm("r11") = (long)argv;
+	register long sc3 asm("r10") = (long)envp;
+
+	asm volatile("scall"
+		     : "=r"(sc1)
+		     : "r"(scno), "0"(sc1), "r"(sc2), "r"(sc3)
+		     : "cc", "memory");
+	return sc1;
+}
Index: linux-2.6.18-rc5-mm1/include/asm-avr32/unistd.h
===================================================================
--- linux-2.6.18-rc5-mm1.orig/include/asm-avr32/unistd.h	2006-09-04 11:21:48.000000000 +0200
+++ linux-2.6.18-rc5-mm1/include/asm-avr32/unistd.h	2006-09-04 11:39:26.000000000 +0200
@@ -281,30 +281,10 @@
 #define __NR_tee		263
 #define __NR_vmsplice		264
 
+#ifdef __KERNEL__
 #define NR_syscalls		265
 
 
-/*
- * AVR32 calling convention for system calls:
- *   - System call number in r8
- *   - Parameters in r12 and downwards to r9 as well as r6 and r5.
- *   - Return value in r12
- */
-
-/*
- * user-visible error numbers are in the range -1 - -124: see
- * <asm-generic/errno.h>
- */
-
-#define __syscall_return(type, res) do {				\
-		if ((unsigned long)(res) >= (unsigned long)(-125)) {	\
-			errno = -(res);					\
-			res = -1;					\
-		}							\
-		return (type) (res);					\
-	} while (0)
-
-#ifdef __KERNEL__
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
@@ -319,62 +299,6 @@
 #define __ARCH_WANT_SYS_GETPGRP
 #define __ARCH_WANT_SYS_RT_SIGACTION
 #define __ARCH_WANT_SYS_RT_SIGSUSPEND
-#endif
-
-#if defined(__KERNEL_SYSCALLS__) || defined(__CHECKER__)
-
-#include <linux/types.h>
-#include <linux/linkage.h>
-#include <asm/signal.h>
-
-struct pt_regs;
-
-/*
- * we need this inline - forking from kernel space will result
- * in NO COPY ON WRITE (!!!), until an execve is executed. This
- * is no problem, but for the stack. This is handled by not letting
- * main() use the stack at all after fork(). Thus, no function
- * calls - which means inline code for fork too, as otherwise we
- * would use the stack upon exit from 'fork()'.
- *
- * Actually only pause and fork are needed inline, so that there
- * won't be any messing with the stack from main(), but we define
- * some others too.
- */
-static inline int execve(const char *file, char **argv, char **envp)
-{
-	register long scno asm("r8") = __NR_execve;
-	register long sc1 asm("r12") = (long)file;
-	register long sc2 asm("r11") = (long)argv;
-	register long sc3 asm("r10") = (long)envp;
-	int res;
-
-	asm volatile("scall"
-		     : "=r"(sc1)
-		     : "r"(scno), "0"(sc1), "r"(sc2), "r"(sc3)
-		     : "lr", "memory");
-	res = sc1;
-	__syscall_return(int, res);
-}
-
-asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize);
-asmlinkage int sys_sigaltstack(const stack_t __user *uss, stack_t __user *uoss,
-			       struct pt_regs *regs);
-asmlinkage int sys_rt_sigreturn(struct pt_regs *regs);
-asmlinkage int sys_pipe(unsigned long __user *filedes);
-asmlinkage long sys_mmap2(unsigned long addr, unsigned long len,
-			  unsigned long prot, unsigned long flags,
-			  unsigned long fd, off_t offset);
-asmlinkage int sys_cacheflush(int operation, void __user *addr, size_t len);
-asmlinkage int sys_fork(struct pt_regs *regs);
-asmlinkage int sys_clone(unsigned long clone_flags, unsigned long newsp,
-			 unsigned long parent_tidptr,
-			 unsigned long child_tidptr, struct pt_regs *regs);
-asmlinkage int sys_vfork(struct pt_regs *regs);
-asmlinkage int sys_execve(char __user *ufilename, char __user *__user *uargv,
-			  char __user *__user *uenvp, struct pt_regs *regs);
-
-#endif
 
 /*
  * "Conditional" syscalls
@@ -384,4 +308,6 @@ asmlinkage int sys_execve(char __user *u
  */
 #define cond_syscall(x) asm(".weak\t" #x "\n\t.set\t" #x ",sys_ni_syscall");
 
+#endif /* __KERNEL__ */
+
 #endif /* __ASM_AVR32_UNISTD_H */

-- 
VGER BF report: U 0.500178
