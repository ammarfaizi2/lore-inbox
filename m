Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbUKLXxH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbUKLXxH (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Nov 2004 18:53:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262722AbUKLXwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Nov 2004 18:52:47 -0500
Received: from pool-151-203-245-3.bos.east.verizon.net ([151.203.245.3]:19204
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262714AbUKLXro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Nov 2004 18:47:44 -0500
Message-Id: <200411130200.iAD20dpT005849@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade_spam@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 1/11] - UML 64-bit cleanups in the system calls
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 12 Nov 2004 21:00:39 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[ The beginning of a series of 11 patches, the signal ones bang heavily on
the same code, so merging will be much more pleasant if they are applied in
order ]

64-bit cleanup - this fixes the return values of the system calls to
be longs.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.9/arch/um/include/syscall_user.h
===================================================================
--- 2.6.9.orig/arch/um/include/syscall_user.h	2004-11-08 19:14:45.000000000 -0500
+++ 2.6.9/arch/um/include/syscall_user.h	2004-11-12 13:31:46.000000000 -0500
@@ -7,7 +7,7 @@
 #define __SYSCALL_USER_H
 
 extern int record_syscall_start(int syscall);
-extern void record_syscall_end(int index, int result);
+extern void record_syscall_end(int index, long result);
 
 #endif
 
Index: 2.6.9/arch/um/kernel/exec_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/exec_kern.c	2004-11-08 19:14:45.000000000 -0500
+++ 2.6.9/arch/um/kernel/exec_kern.c	2004-11-12 13:31:46.000000000 -0500
@@ -34,9 +34,9 @@
 
 extern void log_exec(char **argv, void *tty);
 
-static int execve1(char *file, char **argv, char **env)
+static long execve1(char *file, char **argv, char **env)
 {
-        int error;
+        long error;
 
 #ifdef CONFIG_TTY_LOG
 	log_exec(argv, current->tty);
@@ -51,19 +51,19 @@
         return(error);
 }
 
-int um_execve(char *file, char **argv, char **env)
+long um_execve(char *file, char **argv, char **env)
 {
-	int err;
-
+	long err;
+	
 	err = execve1(file, argv, env);
-	if(!err) 
+	if(!err)
 		do_longjmp(current->thread.exec_buf, 1);
 	return(err);
 }
 
-int sys_execve(char *file, char **argv, char **env)
+long sys_execve(char *file, char **argv, char **env)
 {
-	int error;
+	long error;
 	char *filename;
 
 	lock_kernel();
Index: 2.6.9/arch/um/kernel/ptrace.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/ptrace.c	2004-11-12 13:24:54.000000000 -0500
+++ 2.6.9/arch/um/kernel/ptrace.c	2004-11-12 13:31:46.000000000 -0500
@@ -26,7 +26,7 @@
 	child->thread.singlestep_syscall = 0;
 }
 
-int sys_ptrace(long request, long pid, long addr, long data)
+long sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
 	int i, ret;
Index: 2.6.9/arch/um/kernel/signal_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/signal_kern.c	2004-11-12 13:26:07.000000000 -0500
+++ 2.6.9/arch/um/kernel/signal_kern.c	2004-11-12 18:05:29.000000000 -0500
@@ -167,7 +167,7 @@
 /*
  * Atomically swap in the new signal mask, and wait for a signal.
  */
-int sys_sigsuspend(int history0, int history1, old_sigset_t mask)
+long sys_sigsuspend(int history0, int history1, old_sigset_t mask)
 {
 	sigset_t saveset;
 
@@ -187,7 +187,7 @@
 	}
 }
 
-int sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
+long sys_rt_sigsuspend(sigset_t __user *unewset, size_t sigsetsize)
 {
 	sigset_t saveset, newset;
 
@@ -245,7 +245,7 @@
 	return ret;
 }
 
-int sys_sigaltstack(const stack_t *uss, stack_t *uoss)
+long sys_sigaltstack(const stack_t *uss, stack_t *uoss)
 {
 	return(do_sigaltstack(uss, uoss, PT_REGS_SP(&current->thread.regs)));
 }
@@ -263,7 +263,7 @@
 	return(ret);
 }
 
-int sys_sigreturn(struct pt_regs regs)
+long sys_sigreturn(struct pt_regs regs)
 {
 	void __user *sc = sp_to_sc(PT_REGS_SP(&current->thread.regs));
 	void __user *mask = sp_to_mask(PT_REGS_SP(&current->thread.regs));
@@ -281,7 +281,7 @@
 	return(PT_REGS_SYSCALL_RET(&current->thread.regs));
 }
 
-int sys_rt_sigreturn(struct pt_regs regs)
+long sys_rt_sigreturn(struct pt_regs regs)
 {
 	unsigned long sp = PT_REGS_SP(&current->thread.regs);
 	struct ucontext __user *uc = sp_to_uc(sp);
Index: 2.6.9/arch/um/kernel/syscall_kern.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/syscall_kern.c	2004-11-08 19:14:45.000000000 -0500
+++ 2.6.9/arch/um/kernel/syscall_kern.c	2004-11-12 13:31:46.000000000 -0500
@@ -104,11 +104,11 @@
 	unsigned long offset;
 };
 
-int old_mmap(unsigned long addr, unsigned long len,
+long old_mmap(unsigned long addr, unsigned long len,
 	     unsigned long prot, unsigned long flags,
 	     unsigned long fd, unsigned long offset)
 {
-	int err = -EINVAL;
+	long err = -EINVAL;
 	if (offset & ~PAGE_MASK)
 		goto out;
 
@@ -120,10 +120,10 @@
  * sys_pipe() is the normal C calling standard for creating
  * a pipe. It's not the way unix traditionally does this, though.
  */
-int sys_pipe(unsigned long * fildes)
+long sys_pipe(unsigned long * fildes)
 {
         int fd[2];
-        int error;
+        long error;
 
         error = do_pipe(fd);
         if (!error) {
@@ -218,9 +218,9 @@
 	}
 }
 
-int sys_uname(struct old_utsname * name)
+long sys_uname(struct old_utsname * name)
 {
-	int err;
+	long err;
 	if (!name)
 		return -EFAULT;
 	down_read(&uts_sem);
@@ -229,9 +229,9 @@
 	return err?-EFAULT:0;
 }
 
-int sys_olduname(struct oldold_utsname * name)
+long sys_olduname(struct oldold_utsname * name)
 {
-	int error;
+	long error;
 
 	if (!name)
 		return -EFAULT;
Index: 2.6.9/arch/um/kernel/syscall_user.c
===================================================================
--- 2.6.9.orig/arch/um/kernel/syscall_user.c	2004-11-08 19:14:45.000000000 -0500
+++ 2.6.9/arch/um/kernel/syscall_user.c	2004-11-12 13:31:46.000000000 -0500
@@ -11,7 +11,7 @@
 struct {
 	int syscall;
 	int pid;
-	int result;
+	long result;
 	struct timeval start;
 	struct timeval end;
 } syscall_record[1024];
@@ -30,7 +30,7 @@
 	return(index);
 }
 
-void record_syscall_end(int index, int result)
+void record_syscall_end(int index, long result)
 {
 	syscall_record[index].result = result;
 	gettimeofday(&syscall_record[index].end, NULL);
Index: 2.6.9/include/asm-um/unistd.h
===================================================================
--- 2.6.9.orig/include/asm-um/unistd.h	2004-11-08 19:14:45.000000000 -0500
+++ 2.6.9/include/asm-um/unistd.h	2004-11-12 13:31:46.000000000 -0500
@@ -84,7 +84,7 @@
 	KERNEL_CALL(pid_t, sys_setsid)
 }
 
-static inline long lseek(unsigned int fd, off_t offset, unsigned int whence)
+static inline off_t lseek(unsigned int fd, off_t offset, unsigned int whence)
 {
 	KERNEL_CALL(long, sys_lseek, fd, offset, whence)
 }
@@ -102,13 +102,12 @@
 long sys_mmap2(unsigned long addr, unsigned long len,
 		unsigned long prot, unsigned long flags,
 		unsigned long fd, unsigned long pgoff);
-int sys_execve(char *file, char **argv, char **env);
+long sys_execve(char *file, char **argv, char **env);
 long sys_clone(unsigned long clone_flags, unsigned long newsp,
 		int *parent_tid, int *child_tid);
 long sys_fork(void);
 long sys_vfork(void);
-int sys_pipe(unsigned long *fildes);
-int sys_ptrace(long request, long pid, long addr, long data);
+long sys_pipe(unsigned long *fildes);
 struct sigaction;
 asmlinkage long sys_rt_sigaction(int sig,
 				const struct sigaction __user *act,

