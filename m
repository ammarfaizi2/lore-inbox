Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750947AbWH3MzO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750947AbWH3MzO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Aug 2006 08:55:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750945AbWH3MyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Aug 2006 08:54:14 -0400
Received: from moutng.kundenserver.de ([212.227.126.183]:21989 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S1750931AbWH3Mxw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Aug 2006 08:53:52 -0400
Message-Id: <20060830125037.585774000@klappe.arndb.de>
References: <20060830124356.567568000@klappe.arndb.de>
Date: Wed, 30 Aug 2006 14:43:58 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, David Howells <dhowells@redhat.com>,
       Andi Kleen <ak@suse.de>, "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH 2/6] rename the provided execve functions to kernel_execve
Content-Disposition: inline; filename=kernel_execve.diff
X-Provags-ID: kundenserver.de abuse@kundenserver.de login:c48f057754fc1b1a557605ab9fa6da41
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some architectures provide an execve function that does not
set errno, but instead returns the result code directly.
Rename these to kernel_execve to get the right semantics there.
Moreover, there is no reasone for any of these architectures to
still provide __KERNEL_SYSCALLS__ or _syscallN macros, so
remove these right away.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Index: linux-cg/drivers/sbus/char/bbc_envctrl.c
===================================================================
--- linux-cg.orig/drivers/sbus/char/bbc_envctrl.c	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/drivers/sbus/char/bbc_envctrl.c	2006-08-30 14:31:18.000000000 +0200
@@ -4,9 +4,6 @@
  * Copyright (C) 2001 David S. Miller (davem@redhat.com)
  */
 
-#define __KERNEL_SYSCALLS__
-static int errno;
-
 #include <linux/kernel.h>
 #include <linux/kthread.h>
 #include <linux/sched.h>
@@ -200,7 +197,7 @@
 	printk(KERN_CRIT "kenvctrld: Shutting down the system now.\n");
 
 	shutting_down = 1;
-	if (execve("/sbin/shutdown", argv, envp) < 0)
+	if (kernel_execve("/sbin/shutdown", argv, envp) < 0)
 		printk(KERN_CRIT "envctrl: shutdown execution failed\n");
 }
 
Index: linux-cg/drivers/sbus/char/envctrl.c
===================================================================
--- linux-cg.orig/drivers/sbus/char/envctrl.c	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/drivers/sbus/char/envctrl.c	2006-08-30 14:31:18.000000000 +0200
@@ -19,9 +19,6 @@
  *              Daniele Bellucci <bellucda@tiscali.it>
  */
 
-#define __KERNEL_SYSCALLS__
-static int errno;
-
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
@@ -976,13 +973,15 @@
 		"HOME=/", "TERM=linux", "PATH=/sbin:/usr/sbin:/bin:/usr/bin", NULL };
 	char *argv[] = { 
 		"/sbin/shutdown", "-h", "now", NULL };	
+	int ret;
 
 	if (inprog != 0)
 		return;
 
 	inprog = 1;
 	printk(KERN_CRIT "kenvctrld: WARNING: Shutting down the system now.\n");
-	if (0 > execve("/sbin/shutdown", argv, envp)) {
+	ret = kernel_execve("/sbin/shutdown", argv, envp);
+	if (ret < 0) {
 		printk(KERN_CRIT "kenvctrld: WARNING: system shutdown failed!\n"); 
 		inprog = 0;  /* unlikely to succeed, but we could try again */
 	}
Index: linux-cg/arch/alpha/kernel/entry.S
===================================================================
--- linux-cg.orig/arch/alpha/kernel/entry.S	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/alpha/kernel/entry.S	2006-08-30 14:31:18.000000000 +0200
@@ -655,12 +655,12 @@
 .end kernel_thread
 
 /*
- * execve(path, argv, envp)
+ * kernel_execve(path, argv, envp)
  */
 	.align	4
-	.globl	execve
-	.ent	execve
-execve:
+	.globl	kernel_execve
+	.ent	kernel_execve
+kernel_execve:
 	/* We can be called from a module.  */
 	ldgp	$gp, 0($27)
 	lda	$sp, -(32+SIZEOF_PT_REGS+8)($sp)
@@ -704,7 +704,7 @@
 
 1:	lda	$sp, 32+SIZEOF_PT_REGS+8($sp)
 	ret
-.end execve
+.end kernel_execve
 
 
 /*
Index: linux-cg/arch/arm/kernel/sys_arm.c
===================================================================
--- linux-cg.orig/arch/arm/kernel/sys_arm.c	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/arm/kernel/sys_arm.c	2006-08-30 14:31:18.000000000 +0200
@@ -279,7 +279,7 @@
 	return error;
 }
 
-long execve(const char *filename, char **argv, char **envp)
+int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
 {
 	struct pt_regs regs;
 	int ret;
@@ -317,7 +317,7 @@
  out:
 	return ret;
 }
-EXPORT_SYMBOL(execve);
+EXPORT_SYMBOL(kernel_execve);
 
 /*
  * Since loff_t is a 64 bit type we avoid a lot of ABI hastle
Index: linux-cg/arch/arm26/kernel/sys_arm.c
===================================================================
--- linux-cg.orig/arch/arm26/kernel/sys_arm.c	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/arm26/kernel/sys_arm.c	2006-08-30 14:31:18.000000000 +0200
@@ -283,7 +283,7 @@
 }
 
 /* FIXME - see if this is correct for arm26 */
-long execve(const char *filename, char **argv, char **envp)
+int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
 {
 	struct pt_regs regs;
         int ret;
@@ -320,4 +320,4 @@
         return ret;
 }
 
-EXPORT_SYMBOL(execve);
+EXPORT_SYMBOL(kernel_execve);
Index: linux-cg/arch/powerpc/kernel/misc_32.S
===================================================================
--- linux-cg.orig/arch/powerpc/kernel/misc_32.S	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/powerpc/kernel/misc_32.S	2006-08-30 14:31:18.000000000 +0200
@@ -843,7 +843,7 @@
 	addi	r1,r1,16
 	blr
 
-_GLOBAL(execve)
+_GLOBAL(kernel_execve)
 	li	r0,__NR_execve
 	sc
 	bnslr
Index: linux-cg/arch/powerpc/kernel/misc_64.S
===================================================================
--- linux-cg.orig/arch/powerpc/kernel/misc_64.S	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/powerpc/kernel/misc_64.S	2006-08-30 14:31:18.000000000 +0200
@@ -556,7 +556,7 @@
 
 #endif /* CONFIG_ALTIVEC */
 
-_GLOBAL(execve)
+_GLOBAL(kernel_execve)
 	li	r0,__NR_execve
 	sc
 	bnslr
Index: linux-cg/include/asm-alpha/unistd.h
===================================================================
--- linux-cg.orig/include/asm-alpha/unistd.h	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/include/asm-alpha/unistd.h	2006-08-30 14:31:18.000000000 +0200
@@ -580,75 +580,6 @@
 #define __ARCH_WANT_SYS_OLDUMOUNT
 #define __ARCH_WANT_SYS_SIGPENDING
 
-#ifdef __KERNEL_SYSCALLS__
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/string.h>
-#include <linux/signal.h>
-#include <linux/syscalls.h>
-#include <asm/ptrace.h>
-
-static inline long open(const char * name, int mode, int flags)
-{
-	return sys_open(name, mode, flags);
-}
-
-static inline long dup(int fd)
-{
-	return sys_dup(fd);
-}
-
-static inline long close(int fd)
-{
-	return sys_close(fd);
-}
-
-static inline off_t lseek(int fd, off_t off, int whence)
-{
-	return sys_lseek(fd, off, whence);
-}
-
-static inline void _exit(int value)
-{
-	sys_exit(value);
-}
-
-#define exit(x) _exit(x)
-
-static inline long write(int fd, const char * buf, size_t nr)
-{
-	return sys_write(fd, buf, nr);
-}
-
-static inline long read(int fd, char * buf, size_t nr)
-{
-	return sys_read(fd, buf, nr);
-}
-
-extern int execve(char *, char **, char **);
-
-static inline long setsid(void)
-{
-	return sys_setsid();
-}
-
-static inline pid_t waitpid(int pid, int * wait_stat, int flags)
-{
-	return sys_wait4(pid, wait_stat, flags, NULL);
-}
-
-asmlinkage int sys_execve(char *ufilename, char **argv, char **envp,
-			unsigned long a3, unsigned long a4, unsigned long a5,
-			struct pt_regs regs);
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize,
-				void *restorer);
-
-#endif /* __KERNEL_SYSCALLS__ */
-
 /* "Conditional" syscalls.  What we want is
 
 	__attribute__((weak,alias("sys_ni_syscall")))
Index: linux-cg/include/asm-arm/unistd.h
===================================================================
--- linux-cg.orig/include/asm-arm/unistd.h	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/include/asm-arm/unistd.h	2006-08-30 14:31:18.000000000 +0200
@@ -548,30 +548,6 @@
 #define __ARCH_WANT_SYS_SOCKETCALL
 #endif
 
-#ifdef __KERNEL_SYSCALLS__
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/syscalls.h>
-
-extern long execve(const char *file, char **argv, char **envp);
-
-struct pt_regs;
-asmlinkage int sys_execve(char *filenamei, char **argv, char **envp,
-			struct pt_regs *regs);
-asmlinkage int sys_clone(unsigned long clone_flags, unsigned long newsp,
-			struct pt_regs *regs);
-asmlinkage int sys_fork(struct pt_regs *regs);
-asmlinkage int sys_vfork(struct pt_regs *regs);
-asmlinkage int sys_pipe(unsigned long *fildes);
-struct sigaction;
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
-
-#endif /* __KERNEL_SYSCALLS__ */
-
 /*
  * "Conditional" syscalls
  *
Index: linux-cg/include/asm-arm26/unistd.h
===================================================================
--- linux-cg.orig/include/asm-arm26/unistd.h	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/include/asm-arm26/unistd.h	2006-08-30 14:31:18.000000000 +0200
@@ -463,30 +463,6 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
 
-#ifdef __KERNEL_SYSCALLS__
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/syscalls.h>
-
-extern long execve(const char *file, char **argv, char **envp);
-
-struct pt_regs;
-asmlinkage int sys_execve(char *filenamei, char **argv, char **envp,
-			struct pt_regs *regs);
-asmlinkage int sys_clone(unsigned long clone_flags, unsigned long newsp,
-			struct pt_regs *regs);
-asmlinkage int sys_fork(struct pt_regs *regs);
-asmlinkage int sys_vfork(struct pt_regs *regs);
-asmlinkage int sys_pipe(unsigned long *fildes);
-struct sigaction;
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
-
-#endif /* __KERNEL_SYSCALLS__ */
-
 /*
  * "Conditional" syscalls
  *
Index: linux-cg/include/asm-parisc/unistd.h
===================================================================
--- linux-cg.orig/include/asm-parisc/unistd.h	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/include/asm-parisc/unistd.h	2006-08-30 14:31:18.000000000 +0200
@@ -952,92 +952,6 @@
 #define __ARCH_WANT_SYS_SIGPROCMASK
 #define __ARCH_WANT_SYS_RT_SIGACTION
 
-/* mmap & mmap2 take 6 arguments */
-#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5,type6,arg6) \
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5, type6 arg6) \
-{									        \
-    return K_INLINE_SYSCALL(name, 6, arg1, arg2, arg3, arg4, arg5, arg6);	\
-}
-
-#ifdef __KERNEL_SYSCALLS__
-
-#include <asm/current.h>
-#include <linux/compiler.h>
-#include <linux/types.h>
-#include <linux/syscalls.h>
-
-static inline pid_t setsid(void)
-{
-	return sys_setsid();
-}
-
-static inline int write(int fd, const char *buf, off_t count)
-{
-	return sys_write(fd, buf, count);
-}
-
-static inline int read(int fd, char *buf, off_t count)
-{
-	return sys_read(fd, buf, count);
-}
-
-static inline off_t lseek(int fd, off_t offset, int count)
-{
-	return sys_lseek(fd, offset, count);
-}
-
-static inline int dup(int fd)
-{
-	return sys_dup(fd);
-}
-
-static inline int execve(char *filename, char * argv [],
-	char * envp[])
-{
-	extern int __execve(char *, char **, char **, struct task_struct *);
-	return __execve(filename, argv, envp, current);
-}
-
-static inline int open(const char *file, int flag, int mode)
-{
-	return sys_open(file, flag, mode);
-}
-
-static inline int close(int fd)
-{
-	return sys_close(fd);
-}
-
-static inline void _exit(int exitcode)
-{
-	sys_exit(exitcode);
-}
-
-static inline pid_t waitpid(pid_t pid, int *wait_stat, int options)
-{
-	return sys_wait4(pid, wait_stat, options, NULL);
-}
-
-asmlinkage unsigned long sys_mmap(unsigned long addr, unsigned long len,
-				unsigned long prot, unsigned long flags,
-				unsigned long fd, unsigned long offset);
-asmlinkage unsigned long sys_mmap2(unsigned long addr, unsigned long len,
-				unsigned long prot, unsigned long flags,
-				unsigned long fd, unsigned long pgoff);
-struct pt_regs;
-asmlinkage int sys_execve(struct pt_regs *regs);
-int sys_clone(unsigned long clone_flags, unsigned long usp,
-		struct pt_regs *regs);
-int sys_vfork(struct pt_regs *regs);
-int sys_pipe(int *fildes);
-struct sigaction;
-asmlinkage long sys_rt_sigaction(int sig,
-				const struct sigaction __user *act,
-				struct sigaction __user *oact,
-				size_t sigsetsize);
-
-#endif	/* __KERNEL_SYSCALLS__ */
-
 #endif /* __ASSEMBLY__ */
 
 #undef STR
Index: linux-cg/include/asm-powerpc/unistd.h
===================================================================
--- linux-cg.orig/include/asm-powerpc/unistd.h	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/include/asm-powerpc/unistd.h	2006-08-30 14:31:18.000000000 +0200
@@ -479,13 +479,6 @@
 #endif
 
 /*
- * System call prototypes.
- */
-#ifdef __KERNEL_SYSCALLS__
-extern int execve(const char *file, char **argv, char **envp);
-#endif /* __KERNEL_SYSCALLS__ */
-
-/*
  * "Conditional" syscalls
  *
  * What we want is __attribute__((weak,alias("sys_ni_syscall"))),
Index: linux-cg/include/asm-um/unistd.h
===================================================================
--- linux-cg.orig/include/asm-um/unistd.h	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/include/asm-um/unistd.h	2006-08-30 14:31:18.000000000 +0200
@@ -37,34 +37,6 @@
 #define __ARCH_WANT_SYS_RT_SIGSUSPEND
 #endif
 
-#ifdef __KERNEL_SYSCALLS__
-
-#include <linux/compiler.h>
-#include <linux/types.h>
-
-static inline int execve(const char *filename, char *const argv[],
-			 char *const envp[])
-{
-	mm_segment_t fs;
-	int ret;
-
-	fs = get_fs();
-	set_fs(KERNEL_DS);
-	ret = um_execve(filename, argv, envp);
-	set_fs(fs);
-
-	if (ret >= 0)
-		return ret;
-
-	errno = -(long)ret;
-	return -1;
-}
-
-int sys_execve(char *file, char **argv, char **env);
-
-#endif /* __KERNEL_SYSCALLS__ */
-
-#undef __KERNEL_SYSCALLS__
 #include "asm/arch/unistd.h"
 
 #endif /* _UM_UNISTD_H_*/
Index: linux-cg/include/linux/syscalls.h
===================================================================
--- linux-cg.orig/include/linux/syscalls.h	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/include/linux/syscalls.h	2006-08-30 14:31:18.000000000 +0200
@@ -597,4 +597,6 @@
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
+
 #endif
Index: linux-cg/arch/ia64/kernel/entry.S
===================================================================
--- linux-cg.orig/arch/ia64/kernel/entry.S	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/ia64/kernel/entry.S	2006-08-30 14:31:18.000000000 +0200
@@ -492,11 +492,11 @@
 	br.ret.sptk.many rp
 END(prefetch_stack)
 
-GLOBAL_ENTRY(execve)
+GLOBAL_ENTRY(kernel_execve)
 	mov r15=__NR_execve			// put syscall number in place
 	break __BREAK_SYSCALL
 	br.ret.sptk.many rp
-END(execve)
+END(kernel_execve)
 
 GLOBAL_ENTRY(clone)
 	mov r15=__NR_clone			// put syscall number in place
Index: linux-cg/arch/parisc/kernel/process.c
===================================================================
--- linux-cg.orig/arch/parisc/kernel/process.c	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/parisc/kernel/process.c	2006-08-30 14:31:18.000000000 +0200
@@ -368,7 +368,14 @@
 	return error;
 }
 
-unsigned long 
+extern int __execve(const char *filename, char *const argv[],
+		char *const envp[], struct task_struct *task);
+int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
+{
+	return __execve(filename, argv, envp, current);
+}
+
+unsigned long
 get_wchan(struct task_struct *p)
 {
 	struct unwind_frame_info info;
Index: linux-cg/arch/um/kernel/syscall.c
===================================================================
--- linux-cg.orig/arch/um/kernel/syscall.c	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/um/kernel/syscall.c	2006-08-30 14:31:18.000000000 +0200
@@ -164,3 +164,16 @@
 	spin_unlock(&syscall_lock);
 	return(ret);
 }
+
+int kernel_execve(const char *filename, char *const argv[], char *const envp[])
+{
+	mm_segment_t fs;
+	int ret;
+
+	fs = get_fs();
+	set_fs(KERNEL_DS);
+	ret = um_execve(filename, argv, envp);
+	set_fs(fs);
+
+	return ret;
+}
Index: linux-cg/include/asm-ia64/unistd.h
===================================================================
--- linux-cg.orig/include/asm-ia64/unistd.h	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/include/asm-ia64/unistd.h	2006-08-30 14:31:18.000000000 +0200
@@ -319,78 +319,6 @@
 
 extern long __ia64_syscall (long a0, long a1, long a2, long a3, long a4, long nr);
 
-#ifdef __KERNEL_SYSCALLS__
-
-#include <linux/compiler.h>
-#include <linux/string.h>
-#include <linux/signal.h>
-#include <asm/ptrace.h>
-#include <linux/stringify.h>
-#include <linux/syscalls.h>
-
-static inline long
-open (const char * name, int mode, int flags)
-{
-	return sys_open(name, mode, flags);
-}
-
-static inline long
-dup (int fd)
-{
-	return sys_dup(fd);
-}
-
-static inline long
-close (int fd)
-{
-	return sys_close(fd);
-}
-
-static inline off_t
-lseek (int fd, off_t off, int whence)
-{
-	return sys_lseek(fd, off, whence);
-}
-
-static inline void
-_exit (int value)
-{
-	sys_exit(value);
-}
-
-#define exit(x) _exit(x)
-
-static inline long
-write (int fd, const char * buf, size_t nr)
-{
-	return sys_write(fd, buf, nr);
-}
-
-static inline long
-read (int fd, char * buf, size_t nr)
-{
-	return sys_read(fd, buf, nr);
-}
-
-
-static inline long
-setsid (void)
-{
-	return sys_setsid();
-}
-
-static inline pid_t
-waitpid (int pid, int * wait_stat, int flags)
-{
-	return sys_wait4(pid, wait_stat, flags, NULL);
-}
-
-
-extern int execve (const char *filename, char *const av[], char *const ep[]);
-extern pid_t clone (unsigned long flags, void *sp);
-
-#endif /* __KERNEL_SYSCALLS__ */
-
 asmlinkage unsigned long sys_mmap(
 				unsigned long addr, unsigned long len,
 				int prot, int flags,
Index: linux-cg/arch/alpha/kernel/alpha_ksyms.c
===================================================================
--- linux-cg.orig/arch/alpha/kernel/alpha_ksyms.c	2006-08-30 14:31:00.000000000 +0200
+++ linux-cg/arch/alpha/kernel/alpha_ksyms.c	2006-08-30 14:31:18.000000000 +0200
@@ -36,7 +36,6 @@
 #include <asm/cacheflush.h>
 #include <asm/vga.h>
 
-#define __KERNEL_SYSCALLS__
 #include <asm/unistd.h>
 
 extern struct hwrpb_struct *hwrpb;
@@ -116,7 +115,7 @@
 EXPORT_SYMBOL(sys_exit);
 EXPORT_SYMBOL(sys_write);
 EXPORT_SYMBOL(sys_lseek);
-EXPORT_SYMBOL(execve);
+EXPORT_SYMBOL(kernel_execve);
 EXPORT_SYMBOL(sys_setsid);
 EXPORT_SYMBOL(sys_wait4);
 
Index: linux-cg/arch/x86_64/kernel/entry.S
===================================================================
--- linux-cg.orig/arch/x86_64/kernel/entry.S	2006-08-30 14:31:15.000000000 +0200
+++ linux-cg/arch/x86_64/kernel/entry.S	2006-08-30 14:31:22.000000000 +0200
@@ -1000,7 +1000,7 @@
  * do_sys_execve asm fallback arguments:
  *	rdi: name, rsi: argv, rdx: envp, fake frame on the stack
  */
-ENTRY(execve)
+ENTRY(kernel_execve)
 	CFI_STARTPROC
 	FAKE_STACK_FRAME $0
 	SAVE_ALL	
@@ -1013,7 +1013,7 @@
 	UNFAKE_STACK_FRAME
 	ret
 	CFI_ENDPROC
-ENDPROC(execve)
+ENDPROC(kernel_execve)
 
 KPROBE_ENTRY(page_fault)
 	errorentry do_page_fault
Index: linux-cg/include/asm-x86_64/unistd.h
===================================================================
--- linux-cg.orig/include/asm-x86_64/unistd.h	2006-08-30 14:31:15.000000000 +0200
+++ linux-cg/include/asm-x86_64/unistd.h	2006-08-30 14:31:22.000000000 +0200
@@ -661,8 +661,6 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_TIME
 
-#ifndef __KERNEL_SYSCALLS__
-
 #define __syscall "syscall"
 
 #define _syscall0(type,name) \
@@ -744,85 +742,6 @@
 __syscall_return(type,__res); \
 }
 
-#else /* __KERNEL_SYSCALLS__ */
-
-#include <linux/syscalls.h>
-#include <asm/ptrace.h>
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
-#define __NR__exit __NR_exit
-
-static inline pid_t setsid(void)
-{
-	return sys_setsid();
-}
-
-static inline ssize_t write(unsigned int fd, char * buf, size_t count)
-{
-	return sys_write(fd, buf, count);
-}
-
-static inline ssize_t read(unsigned int fd, char * buf, size_t count)
-{
-	return sys_read(fd, buf, count);
-}
-
-static inline off_t lseek(unsigned int fd, off_t offset, unsigned int origin)
-{
-	return sys_lseek(fd, offset, origin);
-}
-
-static inline long dup(unsigned int fd)
-{
-	return sys_dup(fd);
-}
-
-/* implemented in asm in arch/x86_64/kernel/entry.S */
-extern int execve(const char *, char * const *, char * const *);
-
-static inline long open(const char * filename, int flags, int mode)
-{
-	return sys_open(filename, flags, mode);
-}
-
-static inline long close(unsigned int fd)
-{
-	return sys_close(fd);
-}
-
-static inline pid_t waitpid(int pid, int * wait_stat, int flags)
-{
-	return sys_wait4(pid, wait_stat, flags, NULL);
-}
-
-extern long sys_mmap(unsigned long addr, unsigned long len,
-			unsigned long prot, unsigned long flags,
-			unsigned long fd, unsigned long off);
-
-extern int sys_modify_ldt(int func, void *ptr, unsigned long bytecount);
-
-asmlinkage long sys_execve(char *name, char **argv, char **envp,
-			struct pt_regs regs);
-asmlinkage long sys_clone(unsigned long clone_flags, unsigned long newsp,
-			void *parent_tid, void *child_tid,
-			struct pt_regs regs);
-asmlinkage long sys_fork(struct pt_regs regs);
-asmlinkage long sys_vfork(struct pt_regs regs);
-asmlinkage long sys_pipe(int *fildes);
-
-#endif /* __KERNEL_SYSCALLS__ */
-
 #ifndef __ASSEMBLY__
 
 #include <linux/linkage.h>

--

