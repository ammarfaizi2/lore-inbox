Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750786AbWAOUsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750786AbWAOUsJ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 15 Jan 2006 15:48:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750802AbWAOUsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 15 Jan 2006 15:48:06 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:30883 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1750777AbWAOUrw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 15 Jan 2006 15:47:52 -0500
Message-Id: <200601152139.k0FLdkUq027737@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 7/11] UML - Move libc-dependent skas process handling
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 15 Jan 2006 16:39:46 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel/skas dir).

This moves all systemcalls from skas/process.c file under
os-Linux dir and join skas/process.c and skas/process_kern.c files.

Signed-off-by: Gennady Sharapov <gennady.v.sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/os.h	2006-01-09 11:30:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/os.h	2006-01-09 11:35:10.000000000 -0500
@@ -232,6 +232,7 @@ extern void block_signals(void);
 extern void unblock_signals(void);
 extern int get_signals(void);
 extern int set_signals(int enable);
+extern void os_usr1_signal(int on);
 
 /* trap.c */
 extern void os_fill_handlinfo(struct kern_handlers h);
@@ -272,4 +273,22 @@ extern int protect(struct mm_id * mm_idp
 		   unsigned long len, int r, int w, int x, int done,
 		   void **data);
 
+/* skas/process.c */
+extern int is_skas_winch(int pid, int fd, void *data);
+extern int start_userspace(unsigned long stub_stack);
+extern int copy_context_skas0(unsigned long stack, int pid);
+extern void userspace(union uml_pt_regs *regs);
+extern void map_stub_pages(int fd, unsigned long code,
+			   unsigned long data, unsigned long stack);
+extern void new_thread(void *stack, void **switch_buf_ptr,
+			 void **fork_buf_ptr, void (*handler)(int));
+extern void thread_wait(void *sw, void *fb);
+extern void switch_threads(void *me, void *next);
+extern int start_idle_thread(void *stack, void *switch_buf_ptr,
+			     void **fork_buf_ptr);
+extern void initial_thread_cb_skas(void (*proc)(void *),
+				 void *arg);
+extern void halt_skas(void);
+extern void reboot_skas(void);
+
 #endif
Index: linux-2.6.15-mm/arch/um/include/skas/mode-skas.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/skas/mode-skas.h	2006-01-09 11:26:24.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/skas/mode-skas.h	2006-01-09 11:35:10.000000000 -0500
@@ -14,9 +14,6 @@ extern unsigned long exec_fpx_regs[];
 extern int have_fpx_regs;
 
 extern void sig_handler_common_skas(int sig, void *sc_ptr);
-extern void halt_skas(void);
-extern void reboot_skas(void);
 extern void kill_off_processes_skas(void);
-extern int is_skas_winch(int pid, int fd, void *data);
 
 #endif
Index: linux-2.6.15-mm/arch/um/include/skas/mode_kern_skas.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/skas/mode_kern_skas.h	2006-01-09 11:26:24.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/skas/mode_kern_skas.h	2006-01-09 11:35:10.000000000 -0500
@@ -18,7 +18,6 @@ extern int copy_thread_skas(int nr, unsi
 			    unsigned long sp, unsigned long stack_top,
 			    struct task_struct *p, struct pt_regs *regs);
 extern void release_thread_skas(struct task_struct *task);
-extern void initial_thread_cb_skas(void (*proc)(void *), void *arg);
 extern void init_idle_skas(void);
 extern void flush_tlb_kernel_range_skas(unsigned long start,
 					unsigned long end);
Index: linux-2.6.15-mm/arch/um/include/skas/skas.h
===================================================================
--- linux-2.6.15-mm.orig/arch/um/include/skas/skas.h	2006-01-09 11:30:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/include/skas/skas.h	2006-01-09 11:35:37.000000000 -0500
@@ -13,21 +13,12 @@ extern int userspace_pid[];
 extern int proc_mm, ptrace_faultinfo, ptrace_ldt;
 extern int skas_needs_stub;
 
-extern void switch_threads(void *me, void *next);
-extern void thread_wait(void *sw, void *fb);
-extern void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
-		       void (*handler)(int));
-extern int start_idle_thread(void *stack, void *switch_buf_ptr,
-			     void **fork_buf_ptr);
 extern int user_thread(unsigned long stack, int flags);
-extern void userspace(union uml_pt_regs *regs);
 extern void new_thread_proc(void *stack, void (*handler)(int sig));
 extern void new_thread_handler(int sig);
 extern void handle_syscall(union uml_pt_regs *regs);
 extern void user_signal(int sig, union uml_pt_regs *regs, int pid);
 extern int new_mm(unsigned long stack);
-extern int start_userspace(unsigned long stub_stack);
-extern int copy_context_skas0(unsigned long stack, int pid);
 extern void get_skas_faultinfo(int pid, struct faultinfo * fi);
 extern long execute_syscall_skas(void *r);
 extern unsigned long current_stub_stack(void);
Index: linux-2.6.15-mm/arch/um/kernel/skas/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/Makefile	2006-01-09 11:30:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/skas/Makefile	2006-01-09 11:35:10.000000000 -0500
@@ -3,10 +3,10 @@
 # Licensed under the GPL
 #
 
-obj-y := clone.o exec_kern.o mem.o mmu.o process.o process_kern.o \
+obj-y := clone.o exec_kern.o mem.o mmu.o process_kern.o \
 	syscall.o tlb.o uaccess.o
 
-USER_OBJS := process.o clone.o
+USER_OBJS := clone.o
 
 include arch/um/scripts/Makefile.rules
 
Index: linux-2.6.15-mm/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/kernel/skas/process_kern.c	2006-01-09 11:26:24.000000000 -0500
+++ linux-2.6.15-mm/arch/um/kernel/skas/process_kern.c	2006-01-09 11:40:19.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -32,7 +32,7 @@ void switch_to_skas(void *prev, void *ne
 	if(current->pid == 0)
 		switch_timers(0);
 
-	switch_threads(&from->thread.mode.skas.switch_buf, 
+	switch_threads(&from->thread.mode.skas.switch_buf,
 		       to->thread.mode.skas.switch_buf);
 
 	if(current->pid == 0)
@@ -48,8 +48,8 @@ void new_thread_handler(int sig)
 
 	fn = current->thread.request.u.thread.proc;
 	arg = current->thread.request.u.thread.arg;
-	change_sig(SIGUSR1, 1);
-	thread_wait(&current->thread.mode.skas.switch_buf, 
+	os_usr1_signal(1);
+	thread_wait(&current->thread.mode.skas.switch_buf,
 		    current->thread.mode.skas.fork_buf);
 
 	if(current->thread.prev_sched != NULL)
@@ -80,8 +80,8 @@ void release_thread_skas(struct task_str
 
 void fork_handler(int sig)
 {
-        change_sig(SIGUSR1, 1);
- 	thread_wait(&current->thread.mode.skas.switch_buf, 
+	os_usr1_signal(1);
+	thread_wait(&current->thread.mode.skas.switch_buf,
 		    current->thread.mode.skas.fork_buf);
   	
 	force_flush_all();
@@ -91,13 +91,13 @@ void fork_handler(int sig)
 	schedule_tail(current->thread.prev_sched);
 	current->thread.prev_sched = NULL;
 
-	/* Handle any immediate reschedules or signals */
+/* Handle any immediate reschedules or signals */
 	interrupt_end();
 	userspace(&current->thread.regs.regs);
 }
 
 int copy_thread_skas(int nr, unsigned long clone_flags, unsigned long sp,
-		     unsigned long stack_top, struct task_struct * p, 
+		     unsigned long stack_top, struct task_struct * p,
 		     struct pt_regs *regs)
 {
   	void (*handler)(int);
@@ -121,8 +121,6 @@ int copy_thread_skas(int nr, unsigned lo
 	return(0);
 }
 
-extern void map_stub_pages(int fd, unsigned long code,
-			   unsigned long data, unsigned long stack);
 int new_mm(unsigned long stack)
 {
 	int fd;
Index: linux-2.6.15-mm/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/signal.c	2006-01-09 11:26:24.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/signal.c	2006-01-09 11:35:10.000000000 -0500
@@ -194,3 +194,8 @@ int set_signals(int enable)
 
 	return(ret);
 }
+
+void os_usr1_signal(int on)
+{
+	change_sig(SIGUSR1, on);
+}
Index: linux-2.6.15-mm/arch/um/os-Linux/skas/Makefile
===================================================================
--- linux-2.6.15-mm.orig/arch/um/os-Linux/skas/Makefile	2006-01-09 11:30:10.000000000 -0500
+++ linux-2.6.15-mm/arch/um/os-Linux/skas/Makefile	2006-01-09 11:35:10.000000000 -0500
@@ -3,8 +3,8 @@
 # Licensed under the GPL
 #
 
-obj-y := mem.o trap.o
+obj-y := mem.o process.o trap.o
 
-USER_OBJS := mem.o trap.o
+USER_OBJS := mem.o process.o trap.o
 
 include arch/um/scripts/Makefile.rules
Index: linux-2.6.15-mm/arch/um/os-Linux/skas/process.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm/arch/um/os-Linux/skas/process.c	2006-01-09 11:39:54.000000000 -0500
@@ -0,0 +1,565 @@
+/*
+ * Copyright (C) 2002- 2004 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include <stdlib.h>
+#include <string.h>
+#include <unistd.h>
+#include <errno.h>
+#include <signal.h>
+#include <setjmp.h>
+#include <sched.h>
+#include "ptrace_user.h"
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <sys/user.h>
+#include <sys/time.h>
+#include <asm/unistd.h>
+#include <asm/types.h>
+#include "user.h"
+#include "sysdep/ptrace.h"
+#include "user_util.h"
+#include "kern_util.h"
+#include "skas.h"
+#include "stub-data.h"
+#include "mm_id.h"
+#include "sysdep/sigcontext.h"
+#include "sysdep/stub.h"
+#include "os.h"
+#include "proc_mm.h"
+#include "skas_ptrace.h"
+#include "chan_user.h"
+#include "registers.h"
+#include "mem.h"
+#include "uml-config.h"
+#include "process.h"
+
+int is_skas_winch(int pid, int fd, void *data)
+{
+	if(pid != os_getpgrp())
+		return(0);
+
+	register_winch_irq(-1, fd, -1, data);
+	return(1);
+}
+
+void wait_stub_done(int pid, int sig, char * fname)
+{
+	int n, status, err;
+
+	do {
+		if ( sig != -1 ) {
+			err = ptrace(PTRACE_CONT, pid, 0, sig);
+			if(err)
+				panic("%s : continue failed, errno = %d\n",
+				      fname, errno);
+		}
+		sig = 0;
+
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+	} while((n >= 0) && WIFSTOPPED(status) &&
+	        ((WSTOPSIG(status) == SIGVTALRM) ||
+		 /* running UML inside a detached screen can cause
+		  * SIGWINCHes
+		  */
+		 (WSTOPSIG(status) == SIGWINCH)));
+
+	if((n < 0) || !WIFSTOPPED(status) ||
+	   (WSTOPSIG(status) != SIGUSR1 && WSTOPSIG(status) != SIGTRAP)){
+		unsigned long regs[HOST_FRAME_SIZE];
+
+		if(ptrace(PTRACE_GETREGS, pid, 0, regs) < 0)
+			printk("Failed to get registers from stub, "
+			       "errno = %d\n", errno);
+		else {
+			int i;
+
+			printk("Stub registers -\n");
+			for(i = 0; i < HOST_FRAME_SIZE; i++)
+				printk("\t%d - %lx\n", i, regs[i]);
+		}
+		panic("%s : failed to wait for SIGUSR1/SIGTRAP, "
+		      "pid = %d, n = %d, errno = %d, status = 0x%x\n",
+		      fname, pid, n, errno, status);
+	}
+}
+
+extern unsigned long current_stub_stack(void);
+
+void get_skas_faultinfo(int pid, struct faultinfo * fi)
+{
+	int err;
+
+	if(ptrace_faultinfo){
+		err = ptrace(PTRACE_FAULTINFO, pid, 0, fi);
+		if(err)
+			panic("get_skas_faultinfo - PTRACE_FAULTINFO failed, "
+			      "errno = %d\n", errno);
+
+		/* Special handling for i386, which has different structs */
+		if (sizeof(struct ptrace_faultinfo) < sizeof(struct faultinfo))
+			memset((char *)fi + sizeof(struct ptrace_faultinfo), 0,
+			       sizeof(struct faultinfo) -
+			       sizeof(struct ptrace_faultinfo));
+	}
+	else {
+		wait_stub_done(pid, SIGSEGV, "get_skas_faultinfo");
+
+		/* faultinfo is prepared by the stub-segv-handler at start of
+		 * the stub stack page. We just have to copy it.
+		 */
+		memcpy(fi, (void *)current_stub_stack(), sizeof(*fi));
+	}
+}
+
+static void handle_segv(int pid, union uml_pt_regs * regs)
+{
+	get_skas_faultinfo(pid, &regs->skas.faultinfo);
+	segv(regs->skas.faultinfo, 0, 1, NULL);
+}
+
+/*To use the same value of using_sysemu as the caller, ask it that value (in local_using_sysemu)*/
+static void handle_trap(int pid, union uml_pt_regs *regs, int local_using_sysemu)
+{
+	int err, status;
+
+	/* Mark this as a syscall */
+	UPT_SYSCALL_NR(regs) = PT_SYSCALL_NR(regs->skas.regs);
+
+	if (!local_using_sysemu)
+	{
+		err = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET,
+			     __NR_getpid);
+		if(err < 0)
+			panic("handle_trap - nullifying syscall failed errno = %d\n",
+			      errno);
+
+		err = ptrace(PTRACE_SYSCALL, pid, 0, 0);
+		if(err < 0)
+			panic("handle_trap - continuing to end of syscall failed, "
+			      "errno = %d\n", errno);
+
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
+		if((err < 0) || !WIFSTOPPED(status) ||
+		   (WSTOPSIG(status) != SIGTRAP + 0x80))
+			panic("handle_trap - failed to wait at end of syscall, "
+			      "errno = %d, status = %d\n", errno, status);
+	}
+
+	handle_syscall(regs);
+}
+
+extern int __syscall_stub_start;
+int stub_code_fd = -1;
+__u64 stub_code_offset;
+
+static int userspace_tramp(void *stack)
+{
+	void *addr;
+
+	ptrace(PTRACE_TRACEME, 0, 0, 0);
+
+	init_new_thread_signals(1);
+	enable_timer();
+
+	if(!proc_mm){
+		/* This has a pte, but it can't be mapped in with the usual
+		 * tlb_flush mechanism because this is part of that mechanism
+		 */
+		addr = mmap64((void *) UML_CONFIG_STUB_CODE, page_size(),
+			      PROT_EXEC, MAP_FIXED | MAP_PRIVATE,
+			      stub_code_fd, stub_code_offset);
+		if(addr == MAP_FAILED){
+			printk("mapping stub code failed, errno = %d\n",
+			       errno);
+			exit(1);
+		}
+
+		if(stack != NULL){
+			int fd;
+			__u64 offset;
+			fd = phys_mapping(to_phys(stack), &offset);
+			addr = mmap((void *) UML_CONFIG_STUB_DATA, page_size(),
+				    PROT_READ | PROT_WRITE,
+				    MAP_FIXED | MAP_SHARED, fd, offset);
+			if(addr == MAP_FAILED){
+				printk("mapping stub stack failed, "
+				       "errno = %d\n", errno);
+				exit(1);
+			}
+		}
+	}
+	if(!ptrace_faultinfo){
+		unsigned long v = UML_CONFIG_STUB_CODE +
+				  (unsigned long) stub_segv_handler -
+				  (unsigned long) &__syscall_stub_start;
+
+		set_sigstack((void *) UML_CONFIG_STUB_DATA, page_size());
+		set_handler(SIGSEGV, (void *) v, SA_ONSTACK,
+			    SIGIO, SIGWINCH, SIGALRM, SIGVTALRM,
+			    SIGUSR1, -1);
+	}
+
+	os_stop_process(os_getpid());
+	return(0);
+}
+
+/* Each element set once, and only accessed by a single processor anyway */
+#undef NR_CPUS
+#define NR_CPUS 1
+int userspace_pid[NR_CPUS];
+
+int start_userspace(unsigned long stub_stack)
+{
+	void *stack;
+	unsigned long sp;
+	int pid, status, n, flags;
+
+	if ( stub_code_fd == -1 )
+		stub_code_fd = phys_mapping(to_phys(&__syscall_stub_start),
+					    &stub_code_offset);
+
+	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if(stack == MAP_FAILED)
+		panic("start_userspace : mmap failed, errno = %d", errno);
+	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
+
+	flags = CLONE_FILES | SIGCHLD;
+	if(proc_mm) flags |= CLONE_VM;
+	pid = clone(userspace_tramp, (void *) sp, flags, (void *) stub_stack);
+	if(pid < 0)
+		panic("start_userspace : clone failed, errno = %d", errno);
+
+	do {
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		if(n < 0)
+			panic("start_userspace : wait failed, errno = %d",
+			      errno);
+	} while(WIFSTOPPED(status) && (WSTOPSIG(status) == SIGVTALRM));
+
+	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP))
+		panic("start_userspace : expected SIGSTOP, got status = %d",
+		      status);
+
+	if (ptrace(PTRACE_OLDSETOPTIONS, pid, NULL, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("start_userspace : PTRACE_OLDSETOPTIONS failed, errno=%d\n",
+		      errno);
+
+	if(munmap(stack, PAGE_SIZE) < 0)
+		panic("start_userspace : munmap failed, errno = %d\n", errno);
+
+	return(pid);
+}
+
+void userspace(union uml_pt_regs *regs)
+{
+	int err, status, op, pid = userspace_pid[0];
+	int local_using_sysemu; /*To prevent races if using_sysemu changes under us.*/
+
+	while(1){
+		restore_registers(pid, regs);
+
+		/* Now we set local_using_sysemu to be used for one loop */
+		local_using_sysemu = get_using_sysemu();
+
+		op = SELECT_PTRACE_OPERATION(local_using_sysemu, singlestepping(NULL));
+
+		err = ptrace(op, pid, 0, 0);
+		if(err)
+			panic("userspace - could not resume userspace process, "
+			      "pid=%d, ptrace operation = %d, errno = %d\n",
+			      op, errno);
+
+		CATCH_EINTR(err = waitpid(pid, &status, WUNTRACED));
+		if(err < 0)
+			panic("userspace - waitpid failed, errno = %d\n",
+			      errno);
+
+		regs->skas.is_user = 1;
+		save_registers(pid, regs);
+		UPT_SYSCALL_NR(regs) = -1; /* Assume: It's not a syscall */
+
+		if(WIFSTOPPED(status)){
+		  	switch(WSTOPSIG(status)){
+			case SIGSEGV:
+				if(PTRACE_FULL_FAULTINFO || !ptrace_faultinfo)
+					user_signal(SIGSEGV, regs, pid);
+				else handle_segv(pid, regs);
+				break;
+			case SIGTRAP + 0x80:
+			        handle_trap(pid, regs, local_using_sysemu);
+				break;
+			case SIGTRAP:
+				relay_signal(SIGTRAP, regs);
+				break;
+			case SIGIO:
+			case SIGVTALRM:
+			case SIGILL:
+			case SIGBUS:
+			case SIGFPE:
+			case SIGWINCH:
+				user_signal(WSTOPSIG(status), regs, pid);
+				break;
+			default:
+			        printk("userspace - child stopped with signal "
+				       "%d\n", WSTOPSIG(status));
+			}
+		    again:
+			pid = userspace_pid[0];
+			interrupt_end();
+
+			/* Avoid -ERESTARTSYS handling in host */
+			if(PT_SYSCALL_NR_OFFSET != PT_SYSCALL_RET_OFFSET)
+				PT_SYSCALL_NR(regs->skas.regs) = -1;
+		}
+	}
+}
+#define INIT_JMP_NEW_THREAD 0
+#define INIT_JMP_REMOVE_SIGSTACK 1
+#define INIT_JMP_CALLBACK 2
+#define INIT_JMP_HALT 3
+#define INIT_JMP_REBOOT 4
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
+				      .timer    = ((struct itimerval)
+					            { { 0, 1000000 / hz() },
+						      { 0, 1000000 / hz() }})});
+	get_safe_registers(regs);
+
+	/* Set parent's instruction pointer to start of clone-stub */
+	regs[REGS_IP_INDEX] = UML_CONFIG_STUB_CODE +
+				(unsigned long) stub_clone_handler -
+				(unsigned long) &__syscall_stub_start;
+	regs[REGS_SP_INDEX] = UML_CONFIG_STUB_DATA + PAGE_SIZE -
+		sizeof(void *);
+#ifdef __SIGNAL_FRAMESIZE
+	regs[REGS_SP_INDEX] -= __SIGNAL_FRAMESIZE;
+#endif
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
+		panic("copy_context_skas0 : PTRACE_OLDSETOPTIONS failed, "
+		      "errno = %d\n", errno);
+
+	return pid;
+}
+
+/*
+ * This is used only, if stub pages are needed, while proc_mm is
+ * availabl. Opening /proc/mm creates a new mm_context, which lacks
+ * the stub-pages. Thus, we map them using /proc/mm-fd
+ */
+void map_stub_pages(int fd, unsigned long code,
+		    unsigned long data, unsigned long stack)
+{
+	struct proc_mm_op mmop;
+	int n;
+
+	mmop = ((struct proc_mm_op) { .op        = MM_MMAP,
+				      .u         =
+				      { .mmap    =
+					{ .addr    = code,
+					  .len     = PAGE_SIZE,
+					  .prot    = PROT_EXEC,
+					  .flags   = MAP_FIXED | MAP_PRIVATE,
+					  .fd      = stub_code_fd,
+					  .offset  = stub_code_offset
+	} } });
+	n = os_write_file(fd, &mmop, sizeof(mmop));
+	if(n != sizeof(mmop))
+		panic("map_stub_pages : /proc/mm map for code failed, "
+		      "err = %d\n", -n);
+
+	if ( stack ) {
+		__u64 map_offset;
+		int map_fd = phys_mapping(to_phys((void *)stack), &map_offset);
+		mmop = ((struct proc_mm_op)
+				{ .op        = MM_MMAP,
+				  .u         =
+				  { .mmap    =
+				    { .addr    = data,
+				      .len     = PAGE_SIZE,
+				      .prot    = PROT_READ | PROT_WRITE,
+				      .flags   = MAP_FIXED | MAP_SHARED,
+				      .fd      = map_fd,
+				      .offset  = map_offset
+		} } });
+		n = os_write_file(fd, &mmop, sizeof(mmop));
+		if(n != sizeof(mmop))
+			panic("map_stub_pages : /proc/mm map for data failed, "
+			      "err = %d\n", -n);
+	}
+}
+
+void new_thread(void *stack, void **switch_buf_ptr, void **fork_buf_ptr,
+		void (*handler)(int))
+{
+	unsigned long flags;
+	sigjmp_buf switch_buf, fork_buf;
+
+	*switch_buf_ptr = &switch_buf;
+	*fork_buf_ptr = &fork_buf;
+
+	/* Somewhat subtle - siglongjmp restores the signal mask before doing
+	 * the longjmp.  This means that when jumping from one stack to another
+	 * when the target stack has interrupts enabled, an interrupt may occur
+	 * on the source stack.  This is bad when starting up a process because
+	 * it's not supposed to get timer ticks until it has been scheduled.
+	 * So, we disable interrupts around the sigsetjmp to ensure that
+	 * they can't happen until we get back here where they are safe.
+	 */
+	flags = get_signals();
+	block_signals();
+	if(sigsetjmp(fork_buf, 1) == 0)
+		new_thread_proc(stack, handler);
+
+	remove_sigstack();
+
+	set_signals(flags);
+}
+
+void thread_wait(void *sw, void *fb)
+{
+	sigjmp_buf buf, **switch_buf = sw, *fork_buf;
+
+	*switch_buf = &buf;
+	fork_buf = fb;
+	if(sigsetjmp(buf, 1) == 0)
+		siglongjmp(*fork_buf, INIT_JMP_REMOVE_SIGSTACK);
+}
+
+void switch_threads(void *me, void *next)
+{
+	sigjmp_buf my_buf, **me_ptr = me, *next_buf = next;
+
+	*me_ptr = &my_buf;
+	if(sigsetjmp(my_buf, 1) == 0)
+		siglongjmp(*next_buf, 1);
+}
+
+static sigjmp_buf initial_jmpbuf;
+
+/* XXX Make these percpu */
+static void (*cb_proc)(void *arg);
+static void *cb_arg;
+static sigjmp_buf *cb_back;
+
+int start_idle_thread(void *stack, void *switch_buf_ptr, void **fork_buf_ptr)
+{
+	sigjmp_buf **switch_buf = switch_buf_ptr;
+	int n;
+
+	set_handler(SIGWINCH, (__sighandler_t) sig_handler,
+		    SA_ONSTACK | SA_RESTART, SIGUSR1, SIGIO, SIGALRM,
+		    SIGVTALRM, -1);
+
+	*fork_buf_ptr = &initial_jmpbuf;
+	n = sigsetjmp(initial_jmpbuf, 1);
+	switch(n){
+	case INIT_JMP_NEW_THREAD:
+		new_thread_proc((void *) stack, new_thread_handler);
+		break;
+	case INIT_JMP_REMOVE_SIGSTACK:
+		remove_sigstack();
+		break;
+	case INIT_JMP_CALLBACK:
+		(*cb_proc)(cb_arg);
+		siglongjmp(*cb_back, 1);
+		break;
+	case INIT_JMP_HALT:
+		kmalloc_ok = 0;
+		return(0);
+	case INIT_JMP_REBOOT:
+		kmalloc_ok = 0;
+		return(1);
+	default:
+		panic("Bad sigsetjmp return in start_idle_thread - %d\n", n);
+	}
+	siglongjmp(**switch_buf, 1);
+}
+
+void initial_thread_cb_skas(void (*proc)(void *), void *arg)
+{
+	sigjmp_buf here;
+
+	cb_proc = proc;
+	cb_arg = arg;
+	cb_back = &here;
+
+	block_signals();
+	if(sigsetjmp(here, 1) == 0)
+		siglongjmp(initial_jmpbuf, INIT_JMP_CALLBACK);
+	unblock_signals();
+
+	cb_proc = NULL;
+	cb_arg = NULL;
+	cb_back = NULL;
+}
+
+void halt_skas(void)
+{
+	block_signals();
+	siglongjmp(initial_jmpbuf, INIT_JMP_HALT);
+}
+
+void reboot_skas(void)
+{
+	block_signals();
+	siglongjmp(initial_jmpbuf, INIT_JMP_REBOOT);
+}
+
+void switch_mm_skas(struct mm_id *mm_idp)
+{
+	int err;
+
+#warning need cpu pid in switch_mm_skas
+	if(proc_mm){
+		err = ptrace(PTRACE_SWITCH_MM, userspace_pid[0], 0,
+			     mm_idp->u.mm_fd);
+		if(err)
+			panic("switch_mm_skas - PTRACE_SWITCH_MM failed, "
+			      "errno = %d\n", errno);
+	}
+	else userspace_pid[0] = mm_idp->u.pid;
+}

