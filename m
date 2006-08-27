Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932315AbWH0X7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932315AbWH0X7M (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 27 Aug 2006 19:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932314AbWH0X6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 27 Aug 2006 19:58:50 -0400
Received: from moutng.kundenserver.de ([212.227.126.187]:23280 "EHLO
	moutng.kundenserver.de") by vger.kernel.org with ESMTP
	id S932310AbWH0X6o (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 27 Aug 2006 19:58:44 -0400
Message-Id: <20060827215636.091665000@klappe.arndb.de>
References: <20060827214734.252316000@klappe.arndb.de>
Date: Sun, 27 Aug 2006 23:47:36 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: linux-kernel@vger.kernel.org
Cc: linux-arch@vger.kernel.org, Jeff Dike <jdike@addtoit.com>,
       Bjoern Steinbrink <B.Steinbrink@gmx.de>,
       Arjan van de Ven <arjan@infradead.org>,
       Chase Venters <chase.venters@clientec.com>,
       Andrew Morton <akpm@osdl.org>, Russell King <rmk+lkml@arm.linux.org.uk>,
       rusty@rustcorp.com.au
Subject: [PATCH 2/7] rename the provided execve functions to kernel_execve
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
Index: linux-cg/arch/x86_64/kernel/entry.S
===================================================================
--- linux-cg.orig/arch/x86_64/kernel/entry.S	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/x86_64/kernel/entry.S	2006-08-27 23:36:42.000000000 +0200
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
Index: linux-cg/drivers/sbus/char/bbc_envctrl.c
===================================================================
--- linux-cg.orig/drivers/sbus/char/bbc_envctrl.c	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/drivers/sbus/char/bbc_envctrl.c	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/drivers/sbus/char/envctrl.c	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/drivers/sbus/char/envctrl.c	2006-08-27 23:36:42.000000000 +0200
@@ -19,9 +19,6 @@
  *              Daniele Bellucci <bellucda@tiscali.it>
  */
 
-#define __KERNEL_SYSCALLS__
-static int errno;
-
 #include <linux/module.h>
 #include <linux/sched.h>
 #include <linux/kthread.h>
@@ -982,7 +979,7 @@
 
 	inprog = 1;
 	printk(KERN_CRIT "kenvctrld: WARNING: Shutting down the system now.\n");
-	if (0 > execve("/sbin/shutdown", argv, envp)) {
+	if (0 > kernel_execve("/sbin/shutdown", argv, envp)) {
 		printk(KERN_CRIT "kenvctrld: WARNING: system shutdown failed!\n"); 
 		inprog = 0;  /* unlikely to succeed, but we could try again */
 	}
Index: linux-cg/include/asm-x86_64/unistd.h
===================================================================
--- linux-cg.orig/include/asm-x86_64/unistd.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/asm-x86_64/unistd.h	2006-08-27 23:36:42.000000000 +0200
@@ -626,19 +626,6 @@
 
 #ifndef __NO_STUBS
 
-/* user-visible error numbers are in the range -1 - -4095 */
-
-#define __syscall_clobber "r11","rcx","memory" 
-
-#define __syscall_return(type, res) \
-do { \
-	if ((unsigned long)(res) >= (unsigned long)(-127)) { \
-		errno = -(res); \
-		res = -1; \
-	} \
-	return (type) (res); \
-} while (0)
-
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_OLD_STAT
 #define __ARCH_WANT_SYS_ALARM
@@ -661,168 +648,6 @@
 #define __ARCH_WANT_SYS_TIME
 #define __ARCH_WANT_COMPAT_SYS_TIME
 
-#ifndef __KERNEL_SYSCALLS__
-
-#define __syscall "syscall"
-
-#define _syscall0(type,name) \
-type name(void) \
-{ \
-long __res; \
-__asm__ volatile (__syscall \
-	: "=a" (__res) \
-	: "0" (__NR_##name) : __syscall_clobber ); \
-__syscall_return(type,__res); \
-}
-
-#define _syscall1(type,name,type1,arg1) \
-type name(type1 arg1) \
-{ \
-long __res; \
-__asm__ volatile (__syscall \
-	: "=a" (__res) \
-	: "0" (__NR_##name),"D" ((long)(arg1)) : __syscall_clobber ); \
-__syscall_return(type,__res); \
-}
-
-#define _syscall2(type,name,type1,arg1,type2,arg2) \
-type name(type1 arg1,type2 arg2) \
-{ \
-long __res; \
-__asm__ volatile (__syscall \
-	: "=a" (__res) \
-	: "0" (__NR_##name),"D" ((long)(arg1)),"S" ((long)(arg2)) : __syscall_clobber ); \
-__syscall_return(type,__res); \
-}
-
-#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3) \
-type name(type1 arg1,type2 arg2,type3 arg3) \
-{ \
-long __res; \
-__asm__ volatile (__syscall \
-	: "=a" (__res) \
-	: "0" (__NR_##name),"D" ((long)(arg1)),"S" ((long)(arg2)), \
-		  "d" ((long)(arg3)) : __syscall_clobber); \
-__syscall_return(type,__res); \
-}
-
-#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
-type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4) \
-{ \
-long __res; \
-__asm__ volatile ("movq %5,%%r10 ;" __syscall \
-	: "=a" (__res) \
-	: "0" (__NR_##name),"D" ((long)(arg1)),"S" ((long)(arg2)), \
-	  "d" ((long)(arg3)),"g" ((long)(arg4)) : __syscall_clobber,"r10" ); \
-__syscall_return(type,__res); \
-} 
-
-#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
-	  type5,arg5) \
-type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5) \
-{ \
-long __res; \
-__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; " __syscall \
-	: "=a" (__res) \
-	: "0" (__NR_##name),"D" ((long)(arg1)),"S" ((long)(arg2)), \
-	  "d" ((long)(arg3)),"g" ((long)(arg4)),"g" ((long)(arg5)) : \
-	__syscall_clobber,"r8","r10" ); \
-__syscall_return(type,__res); \
-}
-
-#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
-	  type5,arg5,type6,arg6) \
-type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5,type6 arg6) \
-{ \
-long __res; \
-__asm__ volatile ("movq %5,%%r10 ; movq %6,%%r8 ; movq %7,%%r9 ; " __syscall \
-	: "=a" (__res) \
-	: "0" (__NR_##name),"D" ((long)(arg1)),"S" ((long)(arg2)), \
-	  "d" ((long)(arg3)), "g" ((long)(arg4)), "g" ((long)(arg5)), \
-	  "g" ((long)(arg6)) : \
-	__syscall_clobber,"r8","r10","r9" ); \
-__syscall_return(type,__res); \
-}
-
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
Index: linux-cg/arch/alpha/kernel/entry.S
===================================================================
--- linux-cg.orig/arch/alpha/kernel/entry.S	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/alpha/kernel/entry.S	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/arch/arm/kernel/sys_arm.c	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/arm/kernel/sys_arm.c	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/arch/arm26/kernel/sys_arm.c	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/arm26/kernel/sys_arm.c	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/arch/powerpc/kernel/misc_32.S	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/powerpc/kernel/misc_32.S	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/arch/powerpc/kernel/misc_64.S	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/powerpc/kernel/misc_64.S	2006-08-27 23:36:42.000000000 +0200
@@ -556,7 +556,7 @@
 
 #endif /* CONFIG_ALTIVEC */
 
-_GLOBAL(execve)
+_GLOBAL(kernel_execve)
 	li	r0,__NR_execve
 	sc
 	bnslr
Index: linux-cg/include/asm-alpha/unistd.h
===================================================================
--- linux-cg.orig/include/asm-alpha/unistd.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/asm-alpha/unistd.h	2006-08-27 23:36:42.000000000 +0200
@@ -387,188 +387,6 @@
 
 #define NR_SYSCALLS			447
 
-#if defined(__GNUC__)
-
-#define _syscall_return(type)						\
-	return (_sc_err ? errno = _sc_ret, _sc_ret = -1L : 0), (type) _sc_ret
-
-#define _syscall_clobbers						\
-	"$1", "$2", "$3", "$4", "$5", "$6", "$7", "$8",			\
-	"$22", "$23", "$24", "$25", "$27", "$28" 			\
-
-#define _syscall0(type, name)						\
-type name(void)								\
-{									\
-	long _sc_ret, _sc_err;						\
-	{								\
-		register long _sc_0 __asm__("$0");			\
-		register long _sc_19 __asm__("$19");			\
-									\
-		_sc_0 = __NR_##name;					\
-		__asm__("callsys # %0 %1 %2"				\
-			: "=r"(_sc_0), "=r"(_sc_19)			\
-			: "0"(_sc_0)					\
-			: _syscall_clobbers);				\
-		_sc_ret = _sc_0, _sc_err = _sc_19;			\
-	}								\
-	_syscall_return(type);						\
-}
-
-#define _syscall1(type,name,type1,arg1)					\
-type name(type1 arg1)							\
-{									\
-	long _sc_ret, _sc_err;						\
-	{								\
-		register long _sc_0 __asm__("$0");			\
-		register long _sc_16 __asm__("$16");			\
-		register long _sc_19 __asm__("$19");			\
-									\
-		_sc_0 = __NR_##name;					\
-		_sc_16 = (long) (arg1);					\
-		__asm__("callsys # %0 %1 %2 %3"				\
-			: "=r"(_sc_0), "=r"(_sc_19)			\
-			: "0"(_sc_0), "r"(_sc_16)			\
-			: _syscall_clobbers);				\
-		_sc_ret = _sc_0, _sc_err = _sc_19;			\
-	}								\
-	_syscall_return(type);						\
-}
-
-#define _syscall2(type,name,type1,arg1,type2,arg2)			\
-type name(type1 arg1,type2 arg2)					\
-{									\
-	long _sc_ret, _sc_err;						\
-	{								\
-		register long _sc_0 __asm__("$0");			\
-		register long _sc_16 __asm__("$16");			\
-		register long _sc_17 __asm__("$17");			\
-		register long _sc_19 __asm__("$19");			\
-									\
-		_sc_0 = __NR_##name;					\
-		_sc_16 = (long) (arg1);					\
-		_sc_17 = (long) (arg2);					\
-		__asm__("callsys # %0 %1 %2 %3 %4"			\
-			: "=r"(_sc_0), "=r"(_sc_19)			\
-			: "0"(_sc_0), "r"(_sc_16), "r"(_sc_17)		\
-			: _syscall_clobbers);				\
-		_sc_ret = _sc_0, _sc_err = _sc_19;			\
-	}								\
-	_syscall_return(type);						\
-}
-
-#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)		\
-type name(type1 arg1,type2 arg2,type3 arg3)				\
-{									\
-	long _sc_ret, _sc_err;						\
-	{								\
-		register long _sc_0 __asm__("$0");			\
-		register long _sc_16 __asm__("$16");			\
-		register long _sc_17 __asm__("$17");			\
-		register long _sc_18 __asm__("$18");			\
-		register long _sc_19 __asm__("$19");			\
-									\
-		_sc_0 = __NR_##name;					\
-		_sc_16 = (long) (arg1);					\
-		_sc_17 = (long) (arg2);					\
-		_sc_18 = (long) (arg3);					\
-		__asm__("callsys # %0 %1 %2 %3 %4 %5"			\
-			: "=r"(_sc_0), "=r"(_sc_19)			\
-			: "0"(_sc_0), "r"(_sc_16), "r"(_sc_17),		\
-			  "r"(_sc_18)					\
-			: _syscall_clobbers);				\
-		_sc_ret = _sc_0, _sc_err = _sc_19;			\
-	}								\
-	_syscall_return(type);						\
-}
-
-#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
-type name (type1 arg1, type2 arg2, type3 arg3, type4 arg4)		 \
-{									 \
-	long _sc_ret, _sc_err;						\
-	{								\
-		register long _sc_0 __asm__("$0");			\
-		register long _sc_16 __asm__("$16");			\
-		register long _sc_17 __asm__("$17");			\
-		register long _sc_18 __asm__("$18");			\
-		register long _sc_19 __asm__("$19");			\
-									\
-		_sc_0 = __NR_##name;					\
-		_sc_16 = (long) (arg1);					\
-		_sc_17 = (long) (arg2);					\
-		_sc_18 = (long) (arg3);					\
-		_sc_19 = (long) (arg4);					\
-		__asm__("callsys # %0 %1 %2 %3 %4 %5 %6"		\
-			: "=r"(_sc_0), "=r"(_sc_19)			\
-			: "0"(_sc_0), "r"(_sc_16), "r"(_sc_17),		\
-			  "r"(_sc_18), "1"(_sc_19)			\
-			: _syscall_clobbers);				\
-		_sc_ret = _sc_0, _sc_err = _sc_19;			\
-	}								\
-	_syscall_return(type);						\
-} 
-
-#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
-	  type5,arg5)							 \
-type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5)	\
-{									\
-	long _sc_ret, _sc_err;						\
-	{								\
-		register long _sc_0 __asm__("$0");			\
-		register long _sc_16 __asm__("$16");			\
-		register long _sc_17 __asm__("$17");			\
-		register long _sc_18 __asm__("$18");			\
-		register long _sc_19 __asm__("$19");			\
-		register long _sc_20 __asm__("$20");			\
-									\
-		_sc_0 = __NR_##name;					\
-		_sc_16 = (long) (arg1);					\
-		_sc_17 = (long) (arg2);					\
-		_sc_18 = (long) (arg3);					\
-		_sc_19 = (long) (arg4);					\
-		_sc_20 = (long) (arg5);					\
-		__asm__("callsys # %0 %1 %2 %3 %4 %5 %6 %7"		\
-			: "=r"(_sc_0), "=r"(_sc_19)			\
-			: "0"(_sc_0), "r"(_sc_16), "r"(_sc_17),		\
-			  "r"(_sc_18), "1"(_sc_19), "r"(_sc_20)		\
-			: _syscall_clobbers);				\
-		_sc_ret = _sc_0, _sc_err = _sc_19;			\
-	}								\
-	_syscall_return(type);						\
-}
-
-#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4, \
-	  type5,arg5,type6,arg6)					 \
-type name (type1 arg1,type2 arg2,type3 arg3,type4 arg4,type5 arg5, type6 arg6)\
-{									\
-	long _sc_ret, _sc_err;						\
-	{								\
-		register long _sc_0 __asm__("$0");			\
-		register long _sc_16 __asm__("$16");			\
-		register long _sc_17 __asm__("$17");			\
-		register long _sc_18 __asm__("$18");			\
-		register long _sc_19 __asm__("$19");			\
-		register long _sc_20 __asm__("$20");			\
-		register long _sc_21 __asm__("$21");			\
-									\
-		_sc_0 = __NR_##name;					\
-		_sc_16 = (long) (arg1);					\
-		_sc_17 = (long) (arg2);					\
-		_sc_18 = (long) (arg3);					\
-		_sc_19 = (long) (arg4);					\
-		_sc_20 = (long) (arg5);					\
-		_sc_21 = (long) (arg6);					\
-		__asm__("callsys # %0 %1 %2 %3 %4 %5 %6 %7 %8"		\
-			: "=r"(_sc_0), "=r"(_sc_19)			\
-			: "0"(_sc_0), "r"(_sc_16), "r"(_sc_17),		\
-			  "r"(_sc_18), "1"(_sc_19), "r"(_sc_20), "r"(_sc_21) \
-			: _syscall_clobbers);				\
-		_sc_ret = _sc_0, _sc_err = _sc_19;			\
-	}								\
-	_syscall_return(type);						\
-}
-
-#endif /* __GNUC__ */
-
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
@@ -580,75 +398,6 @@
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
--- linux-cg.orig/include/asm-arm/unistd.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/asm-arm/unistd.h	2006-08-27 23:36:42.000000000 +0200
@@ -377,155 +377,6 @@
 #endif
 
 #ifdef __KERNEL__
-#include <linux/linkage.h>
-
-#define __sys2(x) #x
-#define __sys1(x) __sys2(x)
-
-#ifndef __syscall
-#if defined(__thumb__) || defined(__ARM_EABI__)
-#define __SYS_REG(name) register long __sysreg __asm__("r7") = __NR_##name;
-#define __SYS_REG_LIST(regs...) "r" (__sysreg) , ##regs
-#define __syscall(name) "swi\t0"
-#else
-#define __SYS_REG(name)
-#define __SYS_REG_LIST(regs...) regs
-#define __syscall(name) "swi\t" __sys1(__NR_##name) ""
-#endif
-#endif
-
-#define __syscall_return(type, res)					\
-do {									\
-	if ((unsigned long)(res) >= (unsigned long)(-129)) {		\
-		errno = -(res);						\
-		res = -1;						\
-	}								\
-	return (type) (res);						\
-} while (0)
-
-#define _syscall0(type,name)						\
-type name(void) {							\
-  __SYS_REG(name)							\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: __SYS_REG_LIST()						\
-	: "memory" );							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-#define _syscall1(type,name,type1,arg1) 				\
-type name(type1 arg1) { 						\
-  __SYS_REG(name)							\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: __SYS_REG_LIST( "0" (__r0) )					\
-	: "memory" );							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-#define _syscall2(type,name,type1,arg1,type2,arg2)			\
-type name(type1 arg1,type2 arg2) {					\
-  __SYS_REG(name)							\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: __SYS_REG_LIST( "0" (__r0), "r" (__r1) )			\
-	: "memory" );							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-
-#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)		\
-type name(type1 arg1,type2 arg2,type3 arg3) {				\
-  __SYS_REG(name)							\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __r2 __asm__("r2") = (long)arg3;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: __SYS_REG_LIST( "0" (__r0), "r" (__r1), "r" (__r2) )		\
-	: "memory" );							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-
-#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4)\
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) {		\
-  __SYS_REG(name)							\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __r2 __asm__("r2") = (long)arg3;			\
-  register long __r3 __asm__("r3") = (long)arg4;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: __SYS_REG_LIST( "0" (__r0), "r" (__r1), "r" (__r2), "r" (__r3) ) \
-	: "memory" );							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-  
-
-#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5)	\
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5) {	\
-  __SYS_REG(name)							\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __r2 __asm__("r2") = (long)arg3;			\
-  register long __r3 __asm__("r3") = (long)arg4;			\
-  register long __r4 __asm__("r4") = (long)arg5;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: __SYS_REG_LIST( "0" (__r0), "r" (__r1), "r" (__r2),		\
-			  "r" (__r3), "r" (__r4) )			\
-	: "memory" );							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5,type6,arg6)	\
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5, type6 arg6) {	\
-  __SYS_REG(name)							\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __r2 __asm__("r2") = (long)arg3;			\
-  register long __r3 __asm__("r3") = (long)arg4;			\
-  register long __r4 __asm__("r4") = (long)arg5;			\
-  register long __r5 __asm__("r5") = (long)arg6;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: __SYS_REG_LIST( "0" (__r0), "r" (__r1), "r" (__r2),		\
-			  "r" (__r3), "r" (__r4), "r" (__r5) )		\
-	: "memory" );							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_STAT64
@@ -548,30 +399,6 @@
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
--- linux-cg.orig/include/asm-arm26/unistd.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/asm-arm26/unistd.h	2006-08-27 23:36:42.000000000 +0200
@@ -311,138 +311,6 @@
 #define __ARM_NR_usr26			(__ARM_NR_BASE+3)
 
 #ifdef __KERNEL__
-#include <linux/linkage.h>
-
-#define __sys2(x) #x
-#define __sys1(x) __sys2(x)
-
-#ifndef __syscall
-#define __syscall(name) "swi\t" __sys1(__NR_##name) ""
-#endif
-
-#define __syscall_return(type, res)					\
-do {									\
-	if ((unsigned long)(res) >= (unsigned long)(-125)) {		\
-		errno = -(res);						\
-		res = -1;						\
-	}								\
-	return (type) (res);						\
-} while (0)
-
-#define _syscall0(type,name)						\
-type name(void) {							\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	:								\
-	: "lr");							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-#define _syscall1(type,name,type1,arg1) 				\
-type name(type1 arg1) { 						\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: "r" (__r0)							\
-	: "lr");							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-#define _syscall2(type,name,type1,arg1,type2,arg2)			\
-type name(type1 arg1,type2 arg2) {					\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: "r" (__r0),"r" (__r1) 					\
-	: "lr");							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-
-#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)		\
-type name(type1 arg1,type2 arg2,type3 arg3) {				\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __r2 __asm__("r2") = (long)arg3;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: "r" (__r0),"r" (__r1),"r" (__r2)				\
-	: "lr");							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-
-#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4)\
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4) {		\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __r2 __asm__("r2") = (long)arg3;			\
-  register long __r3 __asm__("r3") = (long)arg4;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: "r" (__r0),"r" (__r1),"r" (__r2),"r" (__r3)			\
-	: "lr");							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-  
-
-#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5)	\
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5) {	\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __r2 __asm__("r2") = (long)arg3;			\
-  register long __r3 __asm__("r3") = (long)arg4;			\
-  register long __r4 __asm__("r4") = (long)arg5;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: "r" (__r0),"r" (__r1),"r" (__r2),"r" (__r3),"r" (__r4)	\
-	: "lr");							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
-
-#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5,type6,arg6)	\
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5, type6 arg6) {	\
-  register long __r0 __asm__("r0") = (long)arg1;			\
-  register long __r1 __asm__("r1") = (long)arg2;			\
-  register long __r2 __asm__("r2") = (long)arg3;			\
-  register long __r3 __asm__("r3") = (long)arg4;			\
-  register long __r4 __asm__("r4") = (long)arg5;			\
-  register long __r5 __asm__("r5") = (long)arg6;			\
-  register long __res_r0 __asm__("r0");					\
-  long __res;								\
-  __asm__ __volatile__ (						\
-  __syscall(name)							\
-	: "=r" (__res_r0)						\
-	: "r" (__r0),"r" (__r1),"r" (__r2),"r" (__r3), "r" (__r4),"r" (__r5)		\
-	: "lr");							\
-  __res = __res_r0;							\
-  __syscall_return(type,__res);						\
-}
 
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
@@ -463,30 +331,6 @@
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
--- linux-cg.orig/include/asm-parisc/unistd.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/asm-parisc/unistd.h	2006-08-27 23:36:42.000000000 +0200
@@ -795,141 +795,6 @@
 #ifdef __KERNEL__
 #ifndef __ASSEMBLY__
 
-#define SYS_ify(syscall_name)   __NR_##syscall_name
-
-#ifndef ASM_LINE_SEP
-# define ASM_LINE_SEP ;
-#endif
-
-/* Definition taken from glibc 2.3.3
- * sysdeps/unix/sysv/linux/hppa/sysdep.h
- */
-
-#ifdef PIC
-/* WARNING: CANNOT BE USED IN A NOP! */
-# define K_STW_ASM_PIC	"       copy %%r19, %%r4\n"
-# define K_LDW_ASM_PIC	"       copy %%r4, %%r19\n"
-# define K_USING_GR4	"%r4",
-#else
-# define K_STW_ASM_PIC	" \n"
-# define K_LDW_ASM_PIC	" \n"
-# define K_USING_GR4
-#endif
-
-/* GCC has to be warned that a syscall may clobber all the ABI
-   registers listed as "caller-saves", see page 8, Table 2
-   in section 2.2.6 of the PA-RISC RUN-TIME architecture
-   document. However! r28 is the result and will conflict with
-   the clobber list so it is left out. Also the input arguments
-   registers r20 -> r26 will conflict with the list so they
-   are treated specially. Although r19 is clobbered by the syscall
-   we cannot say this because it would violate ABI, thus we say
-   r4 is clobbered and use that register to save/restore r19
-   across the syscall. */
-
-#define K_CALL_CLOB_REGS "%r1", "%r2", K_USING_GR4 \
-	        	 "%r20", "%r29", "%r31"
-
-#undef K_INLINE_SYSCALL
-#define K_INLINE_SYSCALL(name, nr, args...)	({			\
-	long __sys_res;							\
-	{								\
-		register unsigned long __res __asm__("r28");		\
-		K_LOAD_ARGS_##nr(args)					\
-		/* FIXME: HACK stw/ldw r19 around syscall */		\
-		__asm__ volatile(					\
-			K_STW_ASM_PIC					\
-			"	ble  0x100(%%sr2, %%r0)\n"		\
-			"	ldi %1, %%r20\n"			\
-			K_LDW_ASM_PIC					\
-			: "=r" (__res)					\
-			: "i" (SYS_ify(name)) K_ASM_ARGS_##nr   	\
-			: "memory", K_CALL_CLOB_REGS K_CLOB_ARGS_##nr	\
-		);							\
-		__sys_res = (long)__res;				\
-	}								\
-	if ( (unsigned long)__sys_res >= (unsigned long)-4095 ){	\
-		errno = -__sys_res;		        		\
-		__sys_res = -1;						\
-	}								\
-	__sys_res;							\
-})
-
-#define K_LOAD_ARGS_0()
-#define K_LOAD_ARGS_1(r26)					\
-	register unsigned long __r26 __asm__("r26") = (unsigned long)(r26);   \
-	K_LOAD_ARGS_0()
-#define K_LOAD_ARGS_2(r26,r25)					\
-	register unsigned long __r25 __asm__("r25") = (unsigned long)(r25);   \
-	K_LOAD_ARGS_1(r26)
-#define K_LOAD_ARGS_3(r26,r25,r24)				\
-	register unsigned long __r24 __asm__("r24") = (unsigned long)(r24);   \
-	K_LOAD_ARGS_2(r26,r25)
-#define K_LOAD_ARGS_4(r26,r25,r24,r23)				\
-	register unsigned long __r23 __asm__("r23") = (unsigned long)(r23);   \
-	K_LOAD_ARGS_3(r26,r25,r24)
-#define K_LOAD_ARGS_5(r26,r25,r24,r23,r22)			\
-	register unsigned long __r22 __asm__("r22") = (unsigned long)(r22);   \
-	K_LOAD_ARGS_4(r26,r25,r24,r23)
-#define K_LOAD_ARGS_6(r26,r25,r24,r23,r22,r21)			\
-	register unsigned long __r21 __asm__("r21") = (unsigned long)(r21);   \
-	K_LOAD_ARGS_5(r26,r25,r24,r23,r22)
-
-/* Even with zero args we use r20 for the syscall number */
-#define K_ASM_ARGS_0
-#define K_ASM_ARGS_1 K_ASM_ARGS_0, "r" (__r26)
-#define K_ASM_ARGS_2 K_ASM_ARGS_1, "r" (__r25)
-#define K_ASM_ARGS_3 K_ASM_ARGS_2, "r" (__r24)
-#define K_ASM_ARGS_4 K_ASM_ARGS_3, "r" (__r23)
-#define K_ASM_ARGS_5 K_ASM_ARGS_4, "r" (__r22)
-#define K_ASM_ARGS_6 K_ASM_ARGS_5, "r" (__r21)
-
-/* The registers not listed as inputs but clobbered */
-#define K_CLOB_ARGS_6
-#define K_CLOB_ARGS_5 K_CLOB_ARGS_6, "%r21"
-#define K_CLOB_ARGS_4 K_CLOB_ARGS_5, "%r22"
-#define K_CLOB_ARGS_3 K_CLOB_ARGS_4, "%r23"
-#define K_CLOB_ARGS_2 K_CLOB_ARGS_3, "%r24"
-#define K_CLOB_ARGS_1 K_CLOB_ARGS_2, "%r25"
-#define K_CLOB_ARGS_0 K_CLOB_ARGS_1, "%r26"
-
-#define _syscall0(type,name)						\
-type name(void)								\
-{									\
-    return K_INLINE_SYSCALL(name, 0);	                                \
-}
-
-#define _syscall1(type,name,type1,arg1)					\
-type name(type1 arg1)							\
-{									\
-    return K_INLINE_SYSCALL(name, 1, arg1);	                        \
-}
-
-#define _syscall2(type,name,type1,arg1,type2,arg2)			\
-type name(type1 arg1, type2 arg2)					\
-{									\
-    return K_INLINE_SYSCALL(name, 2, arg1, arg2);	                \
-}
-
-#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)		\
-type name(type1 arg1, type2 arg2, type3 arg3)				\
-{									\
-    return K_INLINE_SYSCALL(name, 3, arg1, arg2, arg3);	                \
-}
-
-#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4)		\
-{									\
-    return K_INLINE_SYSCALL(name, 4, arg1, arg2, arg3, arg4);	        \
-}
-
-/* select takes 5 arguments */
-#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5) \
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
-{									\
-    return K_INLINE_SYSCALL(name, 5, arg1, arg2, arg3, arg4, arg5);	\
-}
-
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
 #define __ARCH_WANT_SYS_ALARM
@@ -952,92 +817,6 @@
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
--- linux-cg.orig/include/asm-powerpc/unistd.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/asm-powerpc/unistd.h	2006-08-27 23:36:42.000000000 +0200
@@ -333,120 +333,6 @@
 
 #ifndef __ASSEMBLY__
 
-/* On powerpc a system call basically clobbers the same registers like a
- * function call, with the exception of LR (which is needed for the
- * "sc; bnslr" sequence) and CR (where only CR0.SO is clobbered to signal
- * an error return status).
- */
-
-#define __syscall_nr(nr, type, name, args...)				\
-	unsigned long __sc_ret, __sc_err;				\
-	{								\
-		register unsigned long __sc_0  __asm__ ("r0");		\
-		register unsigned long __sc_3  __asm__ ("r3");		\
-		register unsigned long __sc_4  __asm__ ("r4");		\
-		register unsigned long __sc_5  __asm__ ("r5");		\
-		register unsigned long __sc_6  __asm__ ("r6");		\
-		register unsigned long __sc_7  __asm__ ("r7");		\
-		register unsigned long __sc_8  __asm__ ("r8");		\
-									\
-		__sc_loadargs_##nr(name, args);				\
-		__asm__ __volatile__					\
-			("sc           \n\t"				\
-			 "mfcr %0      "				\
-			: "=&r" (__sc_0),				\
-			  "=&r" (__sc_3),  "=&r" (__sc_4),		\
-			  "=&r" (__sc_5),  "=&r" (__sc_6),		\
-			  "=&r" (__sc_7),  "=&r" (__sc_8)		\
-			: __sc_asm_input_##nr				\
-			: "cr0", "ctr", "memory",			\
-			  "r9", "r10","r11", "r12");			\
-		__sc_ret = __sc_3;					\
-		__sc_err = __sc_0;					\
-	}								\
-	if (__sc_err & 0x10000000)					\
-	{								\
-		errno = __sc_ret;					\
-		__sc_ret = -1;						\
-	}								\
-	return (type) __sc_ret
-
-#define __sc_loadargs_0(name, dummy...)					\
-	__sc_0 = __NR_##name
-#define __sc_loadargs_1(name, arg1)					\
-	__sc_loadargs_0(name);						\
-	__sc_3 = (unsigned long) (arg1)
-#define __sc_loadargs_2(name, arg1, arg2)				\
-	__sc_loadargs_1(name, arg1);					\
-	__sc_4 = (unsigned long) (arg2)
-#define __sc_loadargs_3(name, arg1, arg2, arg3)				\
-	__sc_loadargs_2(name, arg1, arg2);				\
-	__sc_5 = (unsigned long) (arg3)
-#define __sc_loadargs_4(name, arg1, arg2, arg3, arg4)			\
-	__sc_loadargs_3(name, arg1, arg2, arg3);			\
-	__sc_6 = (unsigned long) (arg4)
-#define __sc_loadargs_5(name, arg1, arg2, arg3, arg4, arg5)		\
-	__sc_loadargs_4(name, arg1, arg2, arg3, arg4);			\
-	__sc_7 = (unsigned long) (arg5)
-#define __sc_loadargs_6(name, arg1, arg2, arg3, arg4, arg5, arg6)	\
-	__sc_loadargs_5(name, arg1, arg2, arg3, arg4, arg5);		\
-	__sc_8 = (unsigned long) (arg6)
-
-#define __sc_asm_input_0 "0" (__sc_0)
-#define __sc_asm_input_1 __sc_asm_input_0, "1" (__sc_3)
-#define __sc_asm_input_2 __sc_asm_input_1, "2" (__sc_4)
-#define __sc_asm_input_3 __sc_asm_input_2, "3" (__sc_5)
-#define __sc_asm_input_4 __sc_asm_input_3, "4" (__sc_6)
-#define __sc_asm_input_5 __sc_asm_input_4, "5" (__sc_7)
-#define __sc_asm_input_6 __sc_asm_input_5, "6" (__sc_8)
-
-#define _syscall0(type,name)						\
-type name(void)								\
-{									\
-	__syscall_nr(0, type, name);					\
-}
-
-#define _syscall1(type,name,type1,arg1)					\
-type name(type1 arg1)							\
-{									\
-	__syscall_nr(1, type, name, arg1);				\
-}
-
-#define _syscall2(type,name,type1,arg1,type2,arg2)			\
-type name(type1 arg1, type2 arg2)					\
-{									\
-	__syscall_nr(2, type, name, arg1, arg2);			\
-}
-
-#define _syscall3(type,name,type1,arg1,type2,arg2,type3,arg3)		\
-type name(type1 arg1, type2 arg2, type3 arg3)				\
-{									\
-	__syscall_nr(3, type, name, arg1, arg2, arg3);			\
-}
-
-#define _syscall4(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4) \
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4)		\
-{									\
-	__syscall_nr(4, type, name, arg1, arg2, arg3, arg4);		\
-}
-
-#define _syscall5(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5) \
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5)	\
-{									\
-	__syscall_nr(5, type, name, arg1, arg2, arg3, arg4, arg5);	\
-}
-#define _syscall6(type,name,type1,arg1,type2,arg2,type3,arg3,type4,arg4,type5,arg5,type6,arg6) \
-type name(type1 arg1, type2 arg2, type3 arg3, type4 arg4, type5 arg5, type6 arg6) \
-{									\
-	__syscall_nr(6, type, name, arg1, arg2, arg3, arg4, arg5, arg6); \
-}
-
-
-#include <linux/types.h>
-#include <linux/compiler.h>
-#include <linux/linkage.h>
-#include <asm/syscalls.h>
-
 #define __ARCH_WANT_IPC_PARSE_VERSION
 #define __ARCH_WANT_OLD_READDIR
 #define __ARCH_WANT_STAT64
@@ -479,13 +365,6 @@
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
--- linux-cg.orig/include/asm-um/unistd.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/asm-um/unistd.h	2006-08-27 23:41:32.000000000 +0200
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
--- linux-cg.orig/include/linux/syscalls.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/linux/syscalls.h	2006-08-27 23:36:42.000000000 +0200
@@ -597,4 +597,6 @@
 asmlinkage long sys_set_robust_list(struct robust_list_head __user *head,
 				    size_t len);
 
+int kernel_execve(const char *filename, char *const argv[], char *const envp[]);
+
 #endif
Index: linux-cg/arch/ia64/kernel/entry.S
===================================================================
--- linux-cg.orig/arch/ia64/kernel/entry.S	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/ia64/kernel/entry.S	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/arch/parisc/kernel/process.c	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/parisc/kernel/process.c	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/arch/um/kernel/syscall.c	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/um/kernel/syscall.c	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/include/asm-ia64/unistd.h	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/include/asm-ia64/unistd.h	2006-08-27 23:36:42.000000000 +0200
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
--- linux-cg.orig/arch/alpha/kernel/alpha_ksyms.c	2006-08-27 23:36:36.000000000 +0200
+++ linux-cg/arch/alpha/kernel/alpha_ksyms.c	2006-08-27 23:38:19.000000000 +0200
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
 

--

