Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261577AbVGAVk2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261577AbVGAVk2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Jul 2005 17:40:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262277AbVGAVk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Jul 2005 17:40:28 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:17424 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S261577AbVGAVhe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Jul 2005 17:37:34 -0400
Message-Id: <200507012131.j61LVFAQ027281@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       bstroesser@fujitsu-siemens.com
Subject: [PATCH 2/2] UML - Proper clone support for skas0
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Jul 2005 17:31:15 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

This patch implements the clone-stub mechanism, which
allows skas0 to run with proc_mm==0, even if the clib in
UML uses modify_ldt.
Note: There is a bug in skas3.v7 host patch, that
avoids UML-skas from running properly on a SMP-box.
In full skas3, I never really saw problems, but in skas0
they showed up.

More commentary by jdike - What this patch does is makes sure that the host
parent of each new host process matches the UML parent of the corresponding
UML process.  This ensures that any changed LDTs are inherited.  This is done
by having clone actually called by the UML process from its stub, rather than
by the kernel.  We have special syscall stubs that are loaded onto the stub
code page because that code must be completely self-contained.  These stubs
are given C interfaces, and used like normal C functions, but there are
subtleties.  Principally, we have to be careful about stack variables in
stub_clone_handler after the clone.  The code is written so that there aren't
any - everything boils down to a fixed address.  If there were any locals,
references to them after the clone would be wrong because the stack just
changed.

Signed-off-by: Bodo Stroesser <bstroesser@fujitsu-siemens.com>

Index: linux-2.6.12/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/sysdep-i386/stub.h	2005-07-01 00:54:14.000000000 -0400
+++ linux-2.6.12/arch/um/include/sysdep-i386/stub.h	2005-07-01 00:54:31.000000000 -0400
@@ -10,9 +10,56 @@
 #include <asm/unistd.h>
 
 extern void stub_segv_handler(int sig);
+extern void stub_clone_handler(void);
 
 #define STUB_SYSCALL_RET EAX
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
 
+static inline long stub_syscall2(long syscall, long arg1, long arg2)
+{
+	long ret;
+
+	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
+	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
+	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
+	__asm__("int $0x80;" : : : "%eax");
+	__asm__ __volatile__("movl %%eax, %0; " : "=g" (ret) :);
+	return(ret);
+}
+
+static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
+{
+	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
+	return(stub_syscall2(syscall, arg1, arg2));
+}
+
+static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
+				 long arg4)
+{
+	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
+	return(stub_syscall3(syscall, arg1, arg2, arg3));
+}
+
+static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
+				 long arg4, long arg5, long arg6)
+{
+	long ret;
+	__asm__("movl %0, %%eax; " : : "g" (syscall) : "%eax");
+	__asm__("movl %0, %%ebx; " : : "g" (arg1) : "%ebx");
+	__asm__("movl %0, %%ecx; " : : "g" (arg2) : "%ecx");
+	__asm__("movl %0, %%edx; " : : "g" (arg3) : "%edx");
+	__asm__("movl %0, %%esi; " : : "g" (arg4) : "%esi");
+	__asm__("movl %0, %%edi; " : : "g" (arg5) : "%edi");
+	__asm__ __volatile__("pushl %%ebp ; movl %1, %%ebp; "
+		"int $0x80; popl %%ebp ; "
+		"movl %%eax, %0; " : "=g" (ret) : "g" (arg6) : "%eax");
+	return(ret);
+}
+
+static inline void trap_myself(void)
+{
+	__asm("int3");
+}
+
 #endif
Index: linux-2.6.12/arch/um/include/sysdep-x86_64/stub.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/sysdep-x86_64/stub.h	2005-07-01 00:54:14.000000000 -0400
+++ linux-2.6.12/arch/um/include/sysdep-x86_64/stub.h	2005-07-01 00:54:31.000000000 -0400
@@ -11,9 +11,48 @@
 #include <sysdep/ptrace_user.h>
 
 extern void stub_segv_handler(int sig);
+extern void stub_clone_handler(void);
 
 #define STUB_SYSCALL_RET PT_INDEX(RAX)
 #define STUB_MMAP_NR __NR_mmap
 #define MMAP_OFFSET(o) (o)
 
+static inline long stub_syscall2(long syscall, long arg1, long arg2)
+{
+	long ret;
+
+	__asm__("movq %0, %%rsi; " : : "g" (arg2) : "%rsi");
+	__asm__("movq %0, %%rdi; " : : "g" (arg1) : "%rdi");
+	__asm__("movq %0, %%rax; " : : "g" (syscall) : "%rax");
+	__asm__("syscall;" : : : "%rax", "%r11", "%rcx");
+	__asm__ __volatile__("movq %%rax, %0; " : "=g" (ret) :);
+	return(ret);
+}
+
+static inline long stub_syscall3(long syscall, long arg1, long arg2, long arg3)
+{
+	__asm__("movq %0, %%rdx; " : : "g" (arg3) : "%rdx");
+	return(stub_syscall2(syscall, arg1, arg2));
+}
+
+static inline long stub_syscall4(long syscall, long arg1, long arg2, long arg3,
+				 long arg4)
+{
+	__asm__("movq %0, %%r10; " : : "g" (arg4) : "%r10");
+	return(stub_syscall3(syscall, arg1, arg2, arg3));
+}
+
+static inline long stub_syscall6(long syscall, long arg1, long arg2, long arg3,
+				 long arg4, long arg5, long arg6)
+{
+	__asm__("movq %0, %%r9; " : : "g" (arg6) : "%r9");
+	__asm__("movq %0, %%r8; " : : "g" (arg5) : "%r8");
+	return(stub_syscall4(syscall, arg1, arg2, arg3, arg4));
+}
+
+static inline void trap_myself(void)
+{
+	__asm("int3");
+}
+
 #endif
Index: linux-2.6.12/arch/um/include/time_user.h
===================================================================
--- linux-2.6.12.orig/arch/um/include/time_user.h	2005-07-01 00:54:14.000000000 -0400
+++ linux-2.6.12/arch/um/include/time_user.h	2005-07-01 00:54:31.000000000 -0400
@@ -10,6 +10,7 @@ extern void timer(void);
 extern void switch_timers(int to_real);
 extern void idle_sleep(int secs);
 extern void enable_timer(void);
+extern void prepare_timer(void * ptr);
 extern void disable_timer(void);
 extern unsigned long time_lock(void);
 extern void time_unlock(unsigned long);
Index: linux-2.6.12/arch/um/kernel/skas/Makefile
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/Makefile	2005-07-01 00:54:15.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/Makefile	2005-07-01 00:54:31.000000000 -0400
@@ -3,11 +3,14 @@
 # Licensed under the GPL
 #
 
-obj-y := exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
+obj-y := clone.o exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
 	syscall_kern.o syscall_user.o tlb.o trap_user.o uaccess.o \
 
 subdir- := util
 
-USER_OBJS := process.o
+USER_OBJS := process.o clone.o
 
 include arch/um/scripts/Makefile.rules
+
+# clone.o is in the stub, so it can't be built with profiling
+$(obj)/clone.o : c_flags = -Wp,-MD,$(depfile) $(call unprofile,$(USER_CFLAGS))
Index: linux-2.6.12/arch/um/kernel/skas/clone.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/clone.c	2005-06-30 06:09:46.219643400 -0400
+++ linux-2.6.12/arch/um/kernel/skas/clone.c	2005-07-01 00:54:31.000000000 -0400
@@ -0,0 +1,44 @@
+#include <sched.h>
+#include <signal.h>
+#include <sys/mman.h>
+#include <sys/time.h>
+#include <asm/unistd.h>
+#include <asm/page.h>
+#include "ptrace_user.h"
+#include "skas.h"
+#include "stub-data.h"
+#include "uml-config.h"
+#include "sysdep/stub.h"
+
+/* This is in a separate file because it needs to be compiled with any
+ * extraneous gcc flags (-pg, -fprofile-arcs, -ftest-coverage) disabled
+ */
+void __attribute__ ((__section__ (".__syscall_stub")))
+stub_clone_handler(void)
+{
+	long err;
+	struct stub_data *from = (struct stub_data *) UML_CONFIG_STUB_DATA;
+
+	err = stub_syscall2(__NR_clone, CLONE_PARENT | CLONE_FILES | SIGCHLD, 
+			    UML_CONFIG_STUB_DATA + PAGE_SIZE / 2 - 
+			    sizeof(void *));
+	if(err != 0) 
+		goto out;
+
+	err = stub_syscall4(__NR_ptrace, PTRACE_TRACEME, 0, 0, 0);
+	if(err)
+		goto out;
+	
+	err = stub_syscall3(__NR_setitimer, ITIMER_VIRTUAL, 
+			    (long) &from->timer, 0);
+	if(err)
+		goto out;
+
+	err = stub_syscall6(STUB_MMAP_NR, UML_CONFIG_STUB_DATA, PAGE_SIZE,
+			    PROT_READ | PROT_WRITE, MAP_FIXED | MAP_SHARED,
+			    from->fd, from->offset);
+ out:
+	/* save current result. Parent: pid; child: retcode of mmap */
+	from->err = err;
+	trap_myself();
+}
Index: linux-2.6.12/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/include/skas.h	2005-07-01 00:54:15.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/include/skas.h	2005-07-01 00:54:31.000000000 -0400
@@ -32,6 +32,7 @@ extern int protect(struct mm_id * mm_idp
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 extern int new_mm(int from);
 extern int start_userspace(unsigned long stub_stack);
+extern int copy_context_skas0(unsigned long stack, int pid);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
Index: linux-2.6.12/arch/um/kernel/skas/include/stub-data.h
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/include/stub-data.h	2005-06-30 06:09:46.219643400 -0400
+++ linux-2.6.12/arch/um/kernel/skas/include/stub-data.h	2005-07-01 00:54:31.000000000 -0400
@@ -0,0 +1,18 @@
+/* 
+ * Copyright (C) 2005 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#ifndef __STUB_DATA_H
+#define __STUB_DATA_H
+
+#include <sys/time.h>
+
+struct stub_data {
+	long offset;
+	int fd;
+	struct itimerval timer;
+	long err;
+};
+
+#endif
Index: linux-2.6.12/arch/um/kernel/skas/mmu.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/mmu.c	2005-07-01 00:54:23.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/mmu.c	2005-07-01 00:54:31.000000000 -0400
@@ -75,6 +75,7 @@ static int init_stub_pte(struct mm_struc
 int init_new_context_skas(struct task_struct *task, struct mm_struct *mm)
 {
 	struct mm_struct *cur_mm = current->mm;
+	struct mm_id *cur_mm_id = &cur_mm->context.skas.id;
 	struct mm_id *mm_id = &mm->context.skas.id;
 	unsigned long stack;
 	int from, ret;
@@ -115,7 +116,11 @@ int init_new_context_skas(struct task_st
 			goto out_free;
 
 		mm->nr_ptes--;
-		mm_id->u.pid = start_userspace(stack);
+
+		if((cur_mm != NULL) && (cur_mm != &init_mm))
+			mm_id->u.pid = copy_context_skas0(stack, 
+							  cur_mm_id->u.pid);
+		else mm_id->u.pid = start_userspace(stack);
 	}
 
 	return 0;
Index: linux-2.6.12/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/skas/process.c	2005-07-01 00:54:15.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/skas/process.c	2005-07-01 00:54:31.000000000 -0400
@@ -13,6 +13,7 @@
 #include <sys/wait.h>
 #include <sys/mman.h>
 #include <sys/user.h>
+#include <sys/time.h>
 #include <asm/unistd.h>
 #include <asm/types.h>
 #include "user.h"
@@ -22,6 +23,7 @@
 #include "user_util.h"
 #include "kern_util.h"
 #include "skas.h"
+#include "stub-data.h"
 #include "mm_id.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/stub.h"
@@ -296,6 +298,67 @@ void userspace(union uml_pt_regs *regs)
 #define INIT_JMP_HALT 3
 #define INIT_JMP_REBOOT 4
 
+
+int copy_context_skas0(unsigned long new_stack, int pid)
+{
+	int err;
+	unsigned long regs[MAX_REG_NR];
+	unsigned long current_stack = current_stub_stack();
+	struct stub_data *data = (struct stub_data *) current_stack;
+	struct stub_data *child_data = (struct stub_data *) new_stack;
+	__u64 new_offset;
+	int new_fd = phys_mapping(to_phys((void *)new_stack), &new_offset);
+
+	/* prepare offset and fd of child's stack as argument for parent's
+	 * and child's mmap2 calls
+	 */
+	*data = ((struct stub_data) { .offset	= MMAP_OFFSET(new_offset),
+				      .fd	= new_fd,
+				      .timer	= ((struct itimerval) 
+					           { { 0, 1000000 / hz() },
+						     { 0, 1000000 / hz() }})});
+	get_safe_registers(regs);
+
+	/* Set parent's instruction pointer to start of clone-stub */
+	regs[REGS_IP_INDEX] = UML_CONFIG_STUB_CODE +
+				(unsigned long) stub_clone_handler -
+				(unsigned long) &__syscall_stub_start;
+	regs[REGS_SP_INDEX] = UML_CONFIG_STUB_DATA + PAGE_SIZE - 
+		sizeof(void *);
+	err = ptrace_setregs(pid, regs);
+	if(err < 0)
+		panic("copy_context_skas0 : PTRACE_SETREGS failed, "
+		      "pid = %d, errno = %d\n", pid, errno);
+
+	/* set a well known return code for detection of child write failure */
+	child_data->err = 12345678;
+
+	/* Wait, until parent has finished its work: read child's pid from
+	 * parent's stack, and check, if bad result.
+	 */
+	wait_stub_done(pid, 0, "copy_context_skas0");
+
+	pid = data->err;
+	if(pid < 0)
+		panic("copy_context_skas0 - stub-parent reports error %d\n",
+		      pid);
+
+	/* Wait, until child has finished too: read child's result from
+	 * child's stack and check it.
+	 */
+	wait_stub_done(pid, -1, "copy_context_skas0");
+	if (child_data->err != UML_CONFIG_STUB_DATA)
+		panic("copy_context_skas0 - stub-child reports error %d\n",
+		      child_data->err);
+
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL, 
+		   (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("copy_context_skas0 : PTRACE_SETOPTIONS failed, "
+		      "errno = %d\n", errno);
+
+	return pid;
+}
+
 void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
 		void (*handler)(int))
 {
Index: linux-2.6.12/arch/um/kernel/time.c
===================================================================
--- linux-2.6.12.orig/arch/um/kernel/time.c	2005-07-01 00:54:15.000000000 -0400
+++ linux-2.6.12/arch/um/kernel/time.c	2005-07-01 00:54:31.000000000 -0400
@@ -48,6 +48,13 @@ void enable_timer(void)
 	set_interval(ITIMER_VIRTUAL);
 }
 
+void prepare_timer(void * ptr)
+{
+	int usec = 1000000/hz();
+	*(struct itimerval *)ptr = ((struct itimerval) { { 0, usec },
+							 { 0, usec }});
+}
+
 void disable_timer(void)
 {
 	struct itimerval disable = ((struct itimerval) { { 0, 0 }, { 0, 0 }});
@@ -154,11 +161,11 @@ void idle_sleep(int secs)
 
 void user_time_init(void)
 {
-	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
+	set_handler(SIGVTALRM, (__sighandler_t) alarm_handler, 
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, 
 		    SIGALRM, SIGUSR2, -1);
-	set_handler(SIGALRM, (__sighandler_t) alarm_handler,
-		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH,
+	set_handler(SIGALRM, (__sighandler_t) alarm_handler, 
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGWINCH, 
 		    SIGVTALRM, SIGUSR2, -1);
 	set_interval(ITIMER_VIRTUAL);
 }

