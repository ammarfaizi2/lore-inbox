Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWDMSUR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWDMSUR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 14:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964788AbWDMSUR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 14:20:17 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:39832 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S964828AbWDMSUO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 14:20:14 -0400
Message-Id: <200604131721.k3DHLDBs004743@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [RFC] PATCH 4/4 - Time virtualization : UML support
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Apr 2006 13:21:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add UML support for time namespaces.  We call unshare(CLONE_TIME) to create
the new namespace, set gettimeofday to run untraced, and make settimeofday
call the host's settimeofday to update the namespace offset rather than
maintaining the offset locally.

Index: linux-2.6.17-mm-vtime/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/arch/um/os-Linux/skas/process.c	2006-04-13 13:48:01.000000000 -0400
+++ linux-2.6.17-mm-vtime/arch/um/os-Linux/skas/process.c	2006-04-13 13:50:34.000000000 -0400
@@ -17,6 +17,7 @@
 #include <sys/time.h>
 #include <asm/unistd.h>
 #include <asm/types.h>
+#include <asm/bitops.h>
 #include "user.h"
 #include "sysdep/ptrace.h"
 #include "user_util.h"
@@ -209,11 +210,16 @@ static int userspace_tramp(void *stack)
 #define NR_CPUS 1
 int userspace_pid[NR_CPUS];
 
+#ifndef PTRACE_SYSCALL_MASK
+#define PTRACE_SYSCALL_MASK	  27
+#endif
+
 int start_userspace(unsigned long stub_stack)
 {
 	void *stack;
 	unsigned long sp;
 	int pid, status, n, flags;
+	char mask[(KERNEL_NR_SYSCALLS + 7) / 8];
 
 	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
 		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
@@ -242,6 +248,12 @@ int start_userspace(unsigned long stub_s
 		panic("start_userspace : PTRACE_OLDSETOPTIONS failed, errno=%d\n",
 		      errno);
 
+	memset(mask, 0xff, sizeof(mask));
+	clear_bit(__NR_gettimeofday, mask);
+	if(ptrace(PTRACE_SYSCALL_MASK, pid, mask, sizeof(mask)) < 0)
+		panic("start_userspace : PTRACE_SYSCALL_MASK failed, "
+		      "errno = %d\n", errno);
+
 	if(munmap(stack, PAGE_SIZE) < 0)
 		panic("start_userspace : munmap failed, errno = %d\n", errno);
 
@@ -321,6 +333,7 @@ int copy_context_skas0(unsigned long new
 	struct stub_data *child_data = (struct stub_data *) new_stack;
 	__u64 new_offset;
 	int new_fd = phys_mapping(to_phys((void *)new_stack), &new_offset);
+	char mask[(KERNEL_NR_SYSCALLS + 7) / 8];
 
 	/* prepare offset and fd of child's stack as argument for parent's
 	 * and child's mmap2 calls
@@ -377,6 +390,12 @@ int copy_context_skas0(unsigned long new
 		panic("copy_context_skas0 : PTRACE_OLDSETOPTIONS failed, "
 		      "errno = %d\n", errno);
 
+	memset(mask, 0xff, sizeof(mask));
+	clear_bit(__NR_gettimeofday, mask);
+	if(ptrace(PTRACE_SYSCALL_MASK, pid, mask, sizeof(mask)) < 0)
+		panic("start_userspace : PTRACE_SYSCALL_MASK failed, "
+		      "errno = %d\n", errno);
+
 	return pid;
 }
 
@@ -492,11 +511,18 @@ static void (*cb_proc)(void *arg);
 static void *cb_arg;
 static sigjmp_buf *cb_back;
 
+#ifndef CLONE_TIME
+#define CLONE_TIME		0x04000000
+#endif
+
 int start_idle_thread(void *stack, void *switch_buf_ptr, void **fork_buf_ptr)
 {
 	sigjmp_buf **switch_buf = switch_buf_ptr;
-	int n, enable;
+	int n, enable, err;
 
+	err = unshare(CLONE_TIME);
+	if(err)
+		panic("Couldn't create time namespace, err = %d", err);
 	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
 		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
 		    SIGVTALRM, -1);
Index: linux-2.6.17-mm-vtime/arch/um/include/sysdep-i386/kernel-offsets.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/arch/um/include/sysdep-i386/kernel-offsets.h	2006-04-13 13:48:01.000000000 -0400
+++ linux-2.6.17-mm-vtime/arch/um/include/sysdep-i386/kernel-offsets.h	2006-04-13 13:50:34.000000000 -0400
@@ -1,6 +1,7 @@
 #include <linux/stddef.h>
 #include <linux/sched.h>
 #include <linux/elf.h>
+#include <asm/unistd.h>
 
 #define DEFINE(sym, val) \
 	asm volatile("\n->" #sym " %0 " #val : : "i" (val))
@@ -16,6 +17,7 @@
 void foo(void)
 {
 	OFFSET(HOST_TASK_DEBUGREGS, task_struct, thread.arch.debugregs);
+	DEFINE(KERNEL_NR_SYSCALLS, NR_syscalls);
 #ifdef CONFIG_MODE_TT
 	OFFSET(HOST_TASK_EXTERN_PID, task_struct, thread.mode.tt.extern_pid);
 #endif
Index: linux-2.6.17-mm-vtime/arch/um/include/os.h
===================================================================
--- linux-2.6.17-mm-vtime.orig/arch/um/include/os.h	2006-04-13 13:48:01.000000000 -0400
+++ linux-2.6.17-mm-vtime/arch/um/include/os.h	2006-04-13 13:50:34.000000000 -0400
@@ -281,6 +281,7 @@ extern void disable_timer(void);
 extern void user_time_init(void);
 extern void uml_idle_timer(void);
 extern unsigned long long os_nsecs(void);
+extern int os_set_time(unsigned long long nsecs);
 
 /* skas/mem.c */
 extern long run_syscall_stub(struct mm_id * mm_idp,
Index: linux-2.6.17-mm-vtime/arch/um/kernel/time.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/arch/um/kernel/time.c	2006-04-13 13:48:01.000000000 -0400
+++ linux-2.6.17-mm-vtime/arch/um/kernel/time.c	2006-04-13 13:50:50.000000000 -0400
@@ -129,7 +129,7 @@ void do_gettimeofday(struct timeval *tv)
 	clock_was_set();
 }
 
-int do_settimeofday(struct timespec *tv)
+int do_settimeofday()
 {
 	struct timeval now;
 	unsigned long flags;
@@ -138,15 +138,7 @@ int do_settimeofday(struct timespec *tv)
 	if ((unsigned long) tv->tv_nsec >= UM_NSEC_PER_SEC)
 		return -EINVAL;
 
-	tv_in.tv_sec = tv->tv_sec;
-	tv_in.tv_usec = tv->tv_nsec / 1000;
-
-	flags = time_lock();
-	gettimeofday(&now, NULL);
-	timersub(&tv_in, &now, &local_offset);
-	time_unlock(flags);
-
-	return(0);
+	return os_set_time(tv);
 }
 
 void idle_sleep(int secs)
Index: linux-2.6.17-mm-vtime/arch/um/kernel/time_kern.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/arch/um/kernel/time_kern.c	2006-04-13 13:48:01.000000000 -0400
+++ linux-2.6.17-mm-vtime/arch/um/kernel/time_kern.c	2006-04-13 13:50:34.000000000 -0400
@@ -151,19 +151,6 @@ void do_gettimeofday(struct timeval *tv)
 	tv->tv_usec = (unsigned long) nsecs / NSEC_PER_USEC;
 }
 
-static inline void set_time(unsigned long long nsecs)
-{
-	unsigned long long now;
-	unsigned long flags;
-
-	spin_lock_irqsave(&timer_spinlock, flags);
-	now = os_nsecs();
-	local_offset = nsecs - now;
-	spin_unlock_irqrestore(&timer_spinlock, flags);
-
-	clock_was_set();
-}
-
 long um_stime(int __user *tptr)
 {
 	int value;
@@ -171,16 +158,12 @@ long um_stime(int __user *tptr)
 	if (get_user(value, tptr))
                 return -EFAULT;
 
-	set_time((unsigned long long) value * NSEC_PER_SEC);
-
-	return 0;
+	return os_set_time((unsigned long long) value * NSEC_PER_SEC);
 }
 
 int do_settimeofday(struct timespec *tv)
 {
-	set_time((unsigned long long) tv->tv_sec * NSEC_PER_SEC + tv->tv_nsec);
-
-	return 0;
+	return os_set_time((unsigned long long) tv->tv_sec * NSEC_PER_SEC + tv->tv_nsec);
 }
 
 void timer_handler(int sig, union uml_pt_regs *regs)
Index: linux-2.6.17-mm-vtime/arch/um/os-Linux/time.c
===================================================================
--- linux-2.6.17-mm-vtime.orig/arch/um/os-Linux/time.c	2006-04-13 13:48:01.000000000 -0400
+++ linux-2.6.17-mm-vtime/arch/um/os-Linux/time.c	2006-04-13 13:50:34.000000000 -0400
@@ -126,3 +126,21 @@ void user_time_init(void)
 		    SIGVTALRM, SIGUSR2, -1);
 	set_interval(ITIMER_VIRTUAL);
 }
+
+#define NSEC_PER_USEC 1000
+#define NSEC_PER_SEC (1000000 * NSEC_PER_USEC)
+
+int os_set_time(unsigned long long nsecs)
+{
+	struct timeval tv;
+	int err;
+
+	tv.tv_sec = nsecs / NSEC_PER_SEC;
+	nsecs -= tv.tv_sec * NSEC_PER_SEC;
+	tv.tv_usec = (unsigned long) nsecs / NSEC_PER_USEC;
+
+	err = settimeofday(&tv, NULL);
+	if(err)
+		return -errno;
+	return 0;
+}

