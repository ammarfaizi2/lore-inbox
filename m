Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964816AbWAQUUp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbWAQUUp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 15:20:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964812AbWAQUUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 15:20:23 -0500
Received: from moutng.kundenserver.de ([212.227.126.186]:13790 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S964786AbWAQUUW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 15:20:22 -0500
From: Arnd Bergmann <arnd@arndb.de>
To: Paul Mackerras <paulus@samba.org>
Subject: [PATCH] powerpc: declare arch syscalls in <asm/syscalls.h>
Date: Tue, 17 Jan 2006 20:32:39 +0100
User-Agent: KMail/1.9.1
Cc: linux-kernel@vger.kernel.org, linuxppc64-dev@ozlabs.org,
       jordi_caubet@es.ibm.com
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601172032.39521.arnd@arndb.de>
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

powerpc currently declares some of its own system calls
in <asm/unistd.h>, but not all of them. That place also
contains remainders of the now almost unused kernel syscall
hack.

 - Add a new <asm/syscalls.h> with clean declarations
 - Include that file from every source that implements one
   of these
 - Get rid of old declarations in <asm/unistd.h>

This patch is required as a base for implementing system
calls from an SPU, but also makes sense as a general
cleanup.

Signed-off-by: Arnd Bergmann <arndb@de.ibm.com>

---

Please apply to the powerpc.git tree if you like it.

Index: linux-2.6.16-rc/include/asm-powerpc/syscalls.h
===================================================================
--- /dev/null
+++ linux-2.6.16-rc/include/asm-powerpc/syscalls.h
@@ -0,0 +1,59 @@
+#ifndef __ASM_POWERPC_SYSCALLS_H
+#define __ASM_POWERPC_SYSCALLS_H
+#ifdef __KERNEL__
+
+#include <linux/compiler.h>
+#include <linux/linkage.h>
+#include <linux/types.h>
+#include <asm/signal.h>
+
+struct new_utsname;
+struct pt_regs;
+struct rtas_args;
+struct sigaction;
+
+asmlinkage unsigned long sys_mmap(unsigned long addr, size_t len,
+		unsigned long prot, unsigned long flags,
+		unsigned long fd, off_t offset);
+asmlinkage unsigned long sys_mmap2(unsigned long addr, size_t len,
+		unsigned long prot, unsigned long flags,
+		unsigned long fd, unsigned long pgoff);
+asmlinkage int sys_execve(unsigned long a0, unsigned long a1,
+		unsigned long a2, unsigned long a3, unsigned long a4,
+		unsigned long a5, struct pt_regs *regs);
+asmlinkage int sys_clone(unsigned long clone_flags, unsigned long usp,
+		int __user *parent_tidp, void __user *child_threadptr,
+		int __user *child_tidp, int p6, struct pt_regs *regs);
+asmlinkage int sys_fork(unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4, unsigned long p5,
+		unsigned long p6, struct pt_regs *regs);
+asmlinkage int sys_vfork(unsigned long p1, unsigned long p2,
+		unsigned long p3, unsigned long p4, unsigned long p5,
+		unsigned long p6, struct pt_regs *regs);
+asmlinkage int sys_pipe(int __user *fildes);
+asmlinkage long sys_rt_sigaction(int sig,
+		const struct sigaction __user *act,
+		struct sigaction __user *oact, size_t sigsetsize);
+asmlinkage int sys_ipc(uint call, int first, unsigned long second,
+		long third, void __user *ptr, long fifth);
+asmlinkage long ppc64_personality(unsigned long personality);
+asmlinkage int ppc_rtas(struct rtas_args __user *uargs);
+asmlinkage time_t sys64_time(time_t __user * tloc);
+asmlinkage long ppc_newuname(struct new_utsname __user * name);
+
+asmlinkage long sys_rt_sigsuspend(sigset_t __user *unewset,
+		size_t sigsetsize, int p3, int p4,
+		int p6, int p7, struct pt_regs *regs);
+
+#ifndef __powerpc64__
+asmlinkage long sys_sigaltstack(const stack_t __user *uss,
+		stack_t __user *uoss, int r5, int r6, int r7, int r8,
+		struct pt_regs *regs);
+#else /* __powerpc64__ */
+asmlinkage long sys_sigaltstack(const stack_t __user *uss,
+		stack_t __user *uoss, unsigned long r5, unsigned long r6,
+		unsigned long r7, unsigned long r8, struct pt_regs *regs);
+#endif /* __powerpc64__ */
+
+#endif /* __KERNEL__ */
+#endif /* __ASM_POWERPC_SYSCALLS_H */
Index: linux-2.6.16-rc/include/asm-powerpc/unistd.h
===================================================================
--- linux-2.6.16-rc.orig/include/asm-powerpc/unistd.h
+++ linux-2.6.16-rc/include/asm-powerpc/unistd.h
@@ -422,6 +422,7 @@ type name(type1 arg1, type2 arg2, type3 
 #include <linux/types.h>
 #include <linux/compiler.h>
 #include <linux/linkage.h>
+#include <asm/syscalls.h>
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
@@ -455,44 +456,10 @@ type name(type1 arg1, type2 arg2, type3 
  * System call prototypes.
  */
 #ifdef __KERNEL_SYSCALLS__
-extern pid_t setsid(void);
-extern int write(int fd, const char *buf, off_t count);
-extern int read(int fd, char *buf, off_t count);
-extern off_t lseek(int fd, off_t offset, int count);
-extern int dup(int fd);
 extern int execve(const char *file, char **argv, char **envp);
-extern int open(const char *file, int flag, int mode);
-extern int close(int fd);
-extern pid_t waitpid(pid_t pid, int *wait_stat, int options);
 #endif /* __KERNEL_SYSCALLS__ */
 
 /*
- * Functions that implement syscalls.
- */
-unsigned long sys_mmap(unsigned long addr, size_t len, unsigned long prot,
-		       unsigned long flags, unsigned long fd, off_t offset);
-unsigned long sys_mmap2(unsigned long addr, size_t len,
-			unsigned long prot, unsigned long flags,
-			unsigned long fd, unsigned long pgoff);
-struct pt_regs;
-int sys_execve(unsigned long a0, unsigned long a1, unsigned long a2,
-		unsigned long a3, unsigned long a4, unsigned long a5,
-		struct pt_regs *regs);
-int sys_clone(unsigned long clone_flags, unsigned long usp,
-		int __user *parent_tidp, void __user *child_threadptr,
-		int __user *child_tidp, int p6, struct pt_regs *regs);
-int sys_fork(unsigned long p1, unsigned long p2, unsigned long p3,
-		unsigned long p4, unsigned long p5, unsigned long p6,
-		struct pt_regs *regs);
-int sys_vfork(unsigned long p1, unsigned long p2, unsigned long p3,
-		unsigned long p4, unsigned long p5, unsigned long p6,
-		struct pt_regs *regs);
-int sys_pipe(int __user *fildes);
-struct sigaction;
-long sys_rt_sigaction(int sig, const struct sigaction __user *act,
-		      struct sigaction __user *oact, size_t sigsetsize);
-
-/*
  * "Conditional" syscalls
  *
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
Index: linux-2.6.16-rc/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/kernel/process.c
+++ linux-2.6.16-rc/arch/powerpc/kernel/process.c
@@ -47,6 +47,7 @@
 #include <asm/mmu.h>
 #include <asm/prom.h>
 #include <asm/machdep.h>
+#include <asm/syscalls.h>
 #ifdef CONFIG_PPC64
 #include <asm/firmware.h>
 #include <asm/time.h>
Index: linux-2.6.16-rc/arch/powerpc/kernel/rtas.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/kernel/rtas.c
+++ linux-2.6.16-rc/arch/powerpc/kernel/rtas.c
@@ -31,6 +31,7 @@
 #include <asm/uaccess.h>
 #include <asm/lmb.h>
 #include <asm/udbg.h>
+#include <asm/syscalls.h>
 
 struct rtas_t rtas = {
 	.lock = SPIN_LOCK_UNLOCKED
Index: linux-2.6.16-rc/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6.16-rc/arch/powerpc/kernel/signal_32.c
@@ -42,6 +42,7 @@
 
 #include <asm/uaccess.h>
 #include <asm/cacheflush.h>
+#include <asm/syscalls.h>
 #include <asm/sigcontext.h>
 #include <asm/vdso.h>
 #ifdef CONFIG_PPC64
Index: linux-2.6.16-rc/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6.16-rc/arch/powerpc/kernel/signal_64.c
@@ -35,6 +35,7 @@
 #include <asm/pgtable.h>
 #include <asm/unistd.h>
 #include <asm/cacheflush.h>
+#include <asm/syscalls.h>
 #include <asm/vdso.h>
 
 #define DEBUG_SIG 0
Index: linux-2.6.16-rc/arch/powerpc/kernel/syscalls.c
===================================================================
--- linux-2.6.16-rc.orig/arch/powerpc/kernel/syscalls.c
+++ linux-2.6.16-rc/arch/powerpc/kernel/syscalls.c
@@ -40,6 +40,7 @@
 #include <asm/uaccess.h>
 #include <asm/ipc.h>
 #include <asm/semaphore.h>
+#include <asm/syscalls.h>
 #include <asm/time.h>
 #include <asm/unistd.h>
 

