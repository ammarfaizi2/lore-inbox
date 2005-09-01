Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030506AbVIAWxz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030506AbVIAWxz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Sep 2005 18:53:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030466AbVIAWxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Sep 2005 18:53:49 -0400
Received: from lakshmi.addtoit.com ([198.99.130.6]:40208 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S1030496AbVIAWxc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Sep 2005 18:53:32 -0400
Message-Id: <200509012217.j81MHBBW011552@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <gennady.v.sharapov@intel.com>
Subject: [PATCH 7/12] UML - Move libc-dependent startup and signal code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 01 Sep 2005 18:17:11 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gennady Sharapov <gennady.v.sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from process.c file under os-Linux dir
and join process.c and process_kern.c files.

Signed-off-by: Gennady Sharapov <gennady.v.sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: test/arch/um/include/os.h
===================================================================
--- test.orig/arch/um/include/os.h	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/include/os.h	2005-09-01 16:09:41.000000000 -0400
@@ -153,6 +153,11 @@
 extern int os_file_mode(char *file, struct openflags *mode_out);
 extern int os_lock_file(int fd, int excl);
 
+/* start_up.c */
+extern void os_early_checks(void);
+extern int can_do_skas(void);
+
+/* process.c */
 extern unsigned long os_process_pc(int pid);
 extern int os_process_parent(int pid);
 extern void os_stop_process(int pid);
@@ -161,6 +166,9 @@
 extern void os_usr1_process(int pid);
 extern int os_getpid(void);
 extern int os_getpgrp(void);
+extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
+extern void init_new_thread_signals(int altstack);
+extern int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr);
 
 extern int os_map_memory(void *virt, int fd, unsigned long long off,
 			 unsigned long len, int r, int w, int x);
@@ -170,6 +178,13 @@
 extern void os_flush_stdout(void);
 extern unsigned long long os_usecs(void);
 
+/* tt.c 
+ * for tt mode only (will be deleted in future...)
+ */
+extern void forward_pending_sigio(int target);
+extern int start_fork_tramp(void *arg, unsigned long temp_stack, 
+			    int clone_flags, int (*tramp)(void *));
+
 #endif
 
 /*
Index: test/arch/um/include/user_util.h
===================================================================
--- test.orig/arch/um/include/user_util.h	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/include/user_util.h	2005-09-01 16:09:41.000000000 -0400
@@ -54,8 +54,6 @@
 extern void task_protections(unsigned long address);
 extern int wait_for_stop(int pid, int sig, int cont_type, void *relay);
 extern void *add_signal_handler(int sig, void (*handler)(int));
-extern int start_fork_tramp(void *arg, unsigned long temp_stack, 
-			    int clone_flags, int (*tramp)(void *));
 extern int linux_main(int argc, char **argv);
 extern void set_cmdline(char *cmd);
 extern void input_cb(void (*proc)(void *), void *arg, int arg_len);
@@ -64,8 +62,6 @@
 extern int switcheroo(int fd, int prot, void *from, void *to, int size);
 extern void setup_machinename(char *machine_out);
 extern void setup_hostinfo(void);
-extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
-extern void init_new_thread_signals(int altstack);
 extern void do_exec(int old_pid, int new_pid);
 extern void tracer_panic(char *msg, ...);
 extern char *get_umid(int only_if_set);
@@ -74,16 +70,12 @@
 extern int attach(int pid);
 extern void kill_child_dead(int pid);
 extern int cont(int pid);
-extern void check_ptrace(void);
 extern void check_sigio(void);
-extern int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr);
 extern void write_sigio_workaround(void);
 extern void arch_check_bugs(void);
 extern int cpu_feature(char *what, char *buf, int len);
 extern int arch_handle_signal(int sig, union uml_pt_regs *regs);
 extern int arch_fixup(unsigned long address, void *sc_ptr);
-extern void forward_pending_sigio(int target);
-extern int can_do_skas(void);
 extern void arch_init_thread(void);
 extern int setjmp_wrapper(void (*proc)(void *, void *), ...);
 extern int raw(int fd);
Index: test/arch/um/kernel/Makefile
===================================================================
--- test.orig/arch/um/kernel/Makefile	2005-09-01 16:04:19.000000000 -0400
+++ test/arch/um/kernel/Makefile	2005-09-01 16:09:41.000000000 -0400
@@ -8,11 +8,10 @@
 
 obj-y = config.o exec_kern.o exitcode.o \
 	helper.o init_task.o irq.o irq_user.o ksyms.o main.o mem.o mem_user.o \
-	physmem.o process.o process_kern.o ptrace.o reboot.o resource.o \
-	sigio_user.o sigio_kern.o signal_kern.o signal_user.o smp.o \
-	syscall_kern.o sysrq.o tempfile.o time.o time_kern.o \
-	tlb.o trap_kern.o trap_user.o uaccess_user.o um_arch.o umid.o \
-	user_util.o
+	physmem.o process_kern.o ptrace.o reboot.o resource.o sigio_user.o \
+	sigio_kern.o signal_kern.o signal_user.o smp.o syscall_kern.o sysrq.o \
+	tempfile.o time.o time_kern.o tlb.o trap_kern.o trap_user.o \
+	uaccess_user.o um_arch.o umid.o user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
 obj-$(CONFIG_GPROF)	+= gprof_syms.o
@@ -25,8 +24,8 @@
 
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
-USER_OBJS := $(user-objs-y) config.o helper.o main.o process.o tempfile.o \
-	time.o tty_log.o umid.o user_util.o
+USER_OBJS := $(user-objs-y) config.o helper.o main.o tempfile.o time.o \
+	tty_log.o umid.o user_util.o
 
 include arch/um/scripts/Makefile.rules
 
Index: test/arch/um/kernel/process.c
===================================================================
--- test.orig/arch/um/kernel/process.c	2005-09-01 16:02:46.000000000 -0400
+++ test/arch/um/kernel/process.c	2005-09-01 07:45:10.520901648 -0400
@@ -1,439 +0,0 @@
-/* 
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <signal.h>
-#include <sched.h>
-#include <errno.h>
-#include <stdarg.h>
-#include <stdlib.h>
-#include <setjmp.h>
-#include <sys/time.h>
-#include <sys/wait.h>
-#include <sys/mman.h>
-#include <asm/unistd.h>
-#include <asm/page.h>
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "process.h"
-#include "signal_kern.h"
-#include "signal_user.h"
-#include "sysdep/ptrace.h"
-#include "sysdep/sigcontext.h"
-#include "irq_user.h"
-#include "ptrace_user.h"
-#include "time_user.h"
-#include "init.h"
-#include "os.h"
-#include "uml-config.h"
-#include "choose-mode.h"
-#include "mode.h"
-#include "tempfile.h"
-#ifdef UML_CONFIG_MODE_SKAS
-#include "skas.h"
-#include "skas_ptrace.h"
-#include "registers.h"
-#endif
-
-void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))
-{
-	int flags = 0, pages;
-
-	if(sig_stack != NULL){
-		pages = (1 << UML_CONFIG_KERNEL_STACK_ORDER);
-		set_sigstack(sig_stack, pages * page_size());
-		flags = SA_ONSTACK;
-	}
-	if(usr1_handler) set_handler(SIGUSR1, usr1_handler, flags, -1);
-}
-
-void init_new_thread_signals(int altstack)
-{
-	int flags = altstack ? SA_ONSTACK : 0;
-
-	set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags,
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGTRAP, (__sighandler_t) sig_handler, flags, 
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGFPE, (__sighandler_t) sig_handler, flags, 
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGILL, (__sighandler_t) sig_handler, flags, 
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGBUS, (__sighandler_t) sig_handler, flags, 
-		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	set_handler(SIGUSR2, (__sighandler_t) sig_handler, 
-		    flags, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
-	signal(SIGHUP, SIG_IGN);
-
-	init_irq_signals(altstack);
-}
-
-struct tramp {
-	int (*tramp)(void *);
-	void *tramp_data;
-	unsigned long temp_stack;
-	int flags;
-	int pid;
-};
-
-/* See above for why sigkill is here */
-
-int sigkill = SIGKILL;
-
-int outer_tramp(void *arg)
-{
-	struct tramp *t;
-	int sig = sigkill;
-
-	t = arg;
-	t->pid = clone(t->tramp, (void *) t->temp_stack + page_size()/2,
-		       t->flags, t->tramp_data);
-	if(t->pid > 0) wait_for_stop(t->pid, SIGSTOP, PTRACE_CONT, NULL);
-	kill(os_getpid(), sig);
-	_exit(0);
-}
-
-int start_fork_tramp(void *thread_arg, unsigned long temp_stack, 
-		     int clone_flags, int (*tramp)(void *))
-{
-	struct tramp arg;
-	unsigned long sp;
-	int new_pid, status, err;
-
-	/* The trampoline will run on the temporary stack */
-	sp = stack_sp(temp_stack);
-
-	clone_flags |= CLONE_FILES | SIGCHLD;
-
-	arg.tramp = tramp;
-	arg.tramp_data = thread_arg;
-	arg.temp_stack = temp_stack;
-	arg.flags = clone_flags;
-
-	/* Start the process and wait for it to kill itself */
-	new_pid = clone(outer_tramp, (void *) sp, clone_flags, &arg);
-	if(new_pid < 0)
-		return(new_pid);
-
-	CATCH_EINTR(err = waitpid(new_pid, &status, 0));
-	if(err < 0)
-		panic("Waiting for outer trampoline failed - errno = %d",
-		      errno);
-
-	if(!WIFSIGNALED(status) || (WTERMSIG(status) != SIGKILL))
-		panic("outer trampoline didn't exit with SIGKILL, "
-		      "status = %d", status);
-
-	return(arg.pid);
-}
-
-static int ptrace_child(void *arg)
-{
-	int ret;
-	int pid = os_getpid(), ppid = getppid();
-	int sc_result;
-
-	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
-		perror("ptrace");
-		os_kill_process(pid, 0);
-	}
-	os_stop_process(pid);
-
-	/*This syscall will be intercepted by the parent. Don't call more than
-	 * once, please.*/
-	sc_result = os_getpid();
-
-	if (sc_result == pid)
-		ret = 1; /*Nothing modified by the parent, we are running
-			   normally.*/
-	else if (sc_result == ppid)
-		ret = 0; /*Expected in check_ptrace and check_sysemu when they
-			   succeed in modifying the stack frame*/
-	else
-		ret = 2; /*Serious trouble! This could be caused by a bug in
-			   host 2.6 SKAS3/2.6 patch before release -V6, together
-			   with a bug in the UML code itself.*/
-	_exit(ret);
-}
-
-static int start_ptraced_child(void **stack_out)
-{
-	void *stack;
-	unsigned long sp;
-	int pid, n, status;
-	
-	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
-		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
-	if(stack == MAP_FAILED)
-		panic("check_ptrace : mmap failed, errno = %d", errno);
-	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
-	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
-	if(pid < 0)
-		panic("check_ptrace : clone failed, errno = %d", errno);
-	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
-	if(n < 0)
-		panic("check_ptrace : wait failed, errno = %d", errno);
-	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP))
-		panic("check_ptrace : expected SIGSTOP, got status = %d",
-		      status);
-
-	*stack_out = stack;
-	return(pid);
-}
-
-/* When testing for SYSEMU support, if it is one of the broken versions, we must
- * just avoid using sysemu, not panic, but only if SYSEMU features are broken.
- * So only for SYSEMU features we test mustpanic, while normal host features
- * must work anyway!*/
-static int stop_ptraced_child(int pid, void *stack, int exitcode, int mustpanic)
-{
-	int status, n, ret = 0;
-
-	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
-		panic("check_ptrace : ptrace failed, errno = %d", errno);
-	CATCH_EINTR(n = waitpid(pid, &status, 0));
-	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
-		int exit_with = WEXITSTATUS(status);
-		if (exit_with == 2)
-			printk("check_ptrace : child exited with status 2. "
-			       "Serious trouble happening! Try updating your "
-			       "host skas patch!\nDisabling SYSEMU support.");
-		printk("check_ptrace : child exited with exitcode %d, while "
-		      "expecting %d; status 0x%x", exit_with,
-		      exitcode, status);
-		if (mustpanic)
-			panic("\n");
-		else
-			printk("\n");
-		ret = -1;
-	}
-
-	if(munmap(stack, PAGE_SIZE) < 0)
-		panic("check_ptrace : munmap failed, errno = %d", errno);
-	return ret;
-}
-
-static int force_sysemu_disabled = 0;
-
-int ptrace_faultinfo = 1;
-int proc_mm = 1;
-
-static int __init skas0_cmd_param(char *str, int* add)
-{
-	ptrace_faultinfo = proc_mm = 0;
-	return 0;
-}
-
-static int __init nosysemu_cmd_param(char *str, int* add)
-{
-	force_sysemu_disabled = 1;
-	return 0;
-}
-
-__uml_setup("skas0", skas0_cmd_param,
-		"skas0\n"
-		"    Disables SKAS3 usage, so that SKAS0 is used, unless you \n"
-		"    specify mode=tt.\n\n");
-
-__uml_setup("nosysemu", nosysemu_cmd_param,
-		"nosysemu\n"
-		"    Turns off syscall emulation patch for ptrace (SYSEMU) on.\n"
-		"    SYSEMU is a performance-patch introduced by Laurent Vivier. It changes\n"
-		"    behaviour of ptrace() and helps reducing host context switch rate.\n"
-		"    To make it working, you need a kernel patch for your host, too.\n"
-		"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further information.\n\n");
-
-static void __init check_sysemu(void)
-{
-	void *stack;
-	int pid, syscall, n, status, count=0;
-
-	printk("Checking syscall emulation patch for ptrace...");
-	sysemu_supported = 0;
-	pid = start_ptraced_child(&stack);
-
-	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
-		goto fail;
-
-	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
-	if (n < 0)
-		panic("check_sysemu : wait failed, errno = %d", errno);
-	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-		panic("check_sysemu : expected SIGTRAP, "
-		      "got status = %d", status);
-
-	n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
-		   os_getpid());
-	if(n < 0)
-		panic("check_sysemu : failed to modify system "
-		      "call return, errno = %d", errno);
-
-	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
-		goto fail_stopped;
-
-	sysemu_supported = 1;
-	printk("OK\n");
-	set_using_sysemu(!force_sysemu_disabled);
-
-	printk("Checking advanced syscall emulation patch for ptrace...");
-	pid = start_ptraced_child(&stack);
-	while(1){
-		count++;
-		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
-			goto fail;
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
-		if(n < 0)
-			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
-			panic("check_ptrace : expected (SIGTRAP|SYSCALL_TRAP), "
-			      "got status = %d", status);
-
-		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
-				 0);
-		if(syscall == __NR_getpid){
-			if (!count)
-				panic("check_ptrace : SYSEMU_SINGLESTEP doesn't singlestep");
-			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
-				   os_getpid());
-			if(n < 0)
-				panic("check_sysemu : failed to modify system "
-				      "call return, errno = %d", errno);
-			break;
-		}
-	}
-	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
-		goto fail_stopped;
-
-	sysemu_supported = 2;
-	printk("OK\n");
-
-	if ( !force_sysemu_disabled )
-		set_using_sysemu(sysemu_supported);
-	return;
-
-fail:
-	stop_ptraced_child(pid, stack, 1, 0);
-fail_stopped:
-	printk("missing\n");
-}
-
-void __init check_ptrace(void)
-{
-	void *stack;
-	int pid, syscall, n, status;
-
-	printk("Checking that ptrace can change system call numbers...");
-	pid = start_ptraced_child(&stack);
-
-	if (ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
-		panic("check_ptrace: PTRACE_SETOPTIONS failed, errno = %d", errno);
-
-	while(1){
-		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
-			panic("check_ptrace : ptrace failed, errno = %d", 
-			      errno);
-		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
-		if(n < 0)
-			panic("check_ptrace : wait failed, errno = %d", errno);
-		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP + 0x80))
-			panic("check_ptrace : expected SIGTRAP + 0x80, "
-			      "got status = %d", status);
-		
-		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
-				 0);
-		if(syscall == __NR_getpid){
-			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET,
-				   __NR_getppid);
-			if(n < 0)
-				panic("check_ptrace : failed to modify system "
-				      "call, errno = %d", errno);
-			break;
-		}
-	}
-	stop_ptraced_child(pid, stack, 0, 1);
-	printk("OK\n");
-	check_sysemu();
-}
-
-int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
-{
-	sigjmp_buf buf;
-	int n;
-
-	*jmp_ptr = &buf;
-	n = sigsetjmp(buf, 1);
-	if(n != 0)
-		return(n);
-	(*fn)(arg);
-	return(0);
-}
-
-void forward_pending_sigio(int target)
-{
-	sigset_t sigs;
-
-	if(sigpending(&sigs)) 
-		panic("forward_pending_sigio : sigpending failed");
-	if(sigismember(&sigs, SIGIO))
-		kill(target, SIGIO);
-}
-
-extern void *__syscall_stub_start, __syscall_stub_end;
-
-#ifdef UML_CONFIG_MODE_SKAS
-
-static inline void check_skas3_ptrace_support(void)
-{
-	struct ptrace_faultinfo fi;
-	void *stack;
-	int pid, n;
-
-	printf("Checking for the skas3 patch in the host...");
-	pid = start_ptraced_child(&stack);
-
-	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
-	if (n < 0) {
-		ptrace_faultinfo = 0;
-		if(errno == EIO)
-			printf("not found\n");
-		else {
-			perror("not found");
-		}
-	}
-	else {
-		if (!ptrace_faultinfo)
-			printf("found but disabled on command line\n");
-		else
-			printf("found\n");
-	}
-
-	init_registers(pid);
-	stop_ptraced_child(pid, stack, 1, 1);
-}
-
-int can_do_skas(void)
-{
-	printf("Checking for /proc/mm...");
-	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
-		proc_mm = 0;
-		printf("not found\n");
-	} else {
-		if (!proc_mm)
-			printf("found but disabled on command line\n");
-		else
-			printf("found\n");
-	}
-
-	check_skas3_ptrace_support();
-	return 1;
-}
-#else
-int can_do_skas(void)
-{
-	return(0);
-}
-#endif
Index: test/arch/um/kernel/um_arch.c
===================================================================
--- test.orig/arch/um/kernel/um_arch.c	2005-09-01 16:03:16.000000000 -0400
+++ test/arch/um/kernel/um_arch.c	2005-09-01 16:09:41.000000000 -0400
@@ -333,6 +333,7 @@
 	if(have_root == 0)
 		add_arg(DEFAULT_COMMAND_LINE);
 
+	os_early_checks();
 	mode_tt = force_tt ? 1 : !can_do_skas();
 #ifndef CONFIG_MODE_TT
 	if (mode_tt) {
@@ -470,7 +471,6 @@
 void __init check_bugs(void)
 {
 	arch_check_bugs();
-	check_ptrace();
 	check_sigio();
 	check_devanon();
 }
Index: test/arch/um/os-Linux/Makefile
===================================================================
--- test.orig/arch/um/os-Linux/Makefile	2005-09-01 16:04:47.000000000 -0400
+++ test/arch/um/os-Linux/Makefile	2005-09-01 16:09:41.000000000 -0400
@@ -3,10 +3,11 @@
 # Licensed under the GPL
 #
 
-obj-y = aio.o elf_aux.o file.o process.o signal.o time.o tty.o user_syms.o \
-	drivers/ sys-$(SUBARCH)/
+obj-y = aio.o elf_aux.o file.o process.o signal.o start_up.o time.o tt.o \
+	tty.o user_syms.o drivers/ sys-$(SUBARCH)/
 
-USER_OBJS := aio.o elf_aux.o file.o process.o signal.o time.o tty.o
+USER_OBJS := aio.o elf_aux.o file.o process.o signal.o start_up.o time.o tt.o \
+	tty.o
 
 CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
 
Index: test/arch/um/os-Linux/process.c
===================================================================
--- test.orig/arch/um/os-Linux/process.c	2005-06-17 15:48:29.000000000 -0400
+++ test/arch/um/os-Linux/process.c	2005-09-01 16:09:41.000000000 -0400
@@ -3,10 +3,10 @@
  * Licensed under the GPL
  */
 
-#include <unistd.h>
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>
+#include <setjmp.h>
 #include <linux/unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
@@ -14,6 +14,10 @@
 #include "os.h"
 #include "user.h"
 #include "user_util.h"
+#include "signal_user.h"
+#include "process.h"
+#include "irq_user.h"
+#include "kern_util.h"
 
 #define ARBITRARY_ADDR -1
 #define FAILURE_PID    -1
@@ -114,8 +118,10 @@
 	kill(pid, SIGUSR1);
 }
 
-/*Don't use the glibc version, which caches the result in TLS. It misses some
- * syscalls, and also breaks with clone(), which does not unshare the TLS.*/
+/* Don't use the glibc version, which caches the result in TLS. It misses some
+ * syscalls, and also breaks with clone(), which does not unshare the TLS.
+ */
+
 inline _syscall0(pid_t, getpid)
 
 int os_getpid(void)
@@ -164,6 +170,52 @@
         return(0);
 }
 
+void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int))
+{
+	int flags = 0, pages;
+
+	if(sig_stack != NULL){
+		pages = (1 << UML_CONFIG_KERNEL_STACK_ORDER);
+		set_sigstack(sig_stack, pages * page_size());
+		flags = SA_ONSTACK;
+	}
+	if(usr1_handler) set_handler(SIGUSR1, usr1_handler, flags, -1);
+}
+
+void init_new_thread_signals(int altstack)
+{
+	int flags = altstack ? SA_ONSTACK : 0;
+
+	set_handler(SIGSEGV, (__sighandler_t) sig_handler, flags,
+		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+	set_handler(SIGTRAP, (__sighandler_t) sig_handler, flags, 
+		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+	set_handler(SIGFPE, (__sighandler_t) sig_handler, flags, 
+		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+	set_handler(SIGILL, (__sighandler_t) sig_handler, flags, 
+		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+	set_handler(SIGBUS, (__sighandler_t) sig_handler, flags, 
+		    SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+	set_handler(SIGUSR2, (__sighandler_t) sig_handler, 
+		    flags, SIGUSR1, SIGIO, SIGWINCH, SIGALRM, SIGVTALRM, -1);
+	signal(SIGHUP, SIG_IGN);
+
+	init_irq_signals(altstack);
+}
+
+int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr)
+{
+       sigjmp_buf buf;
+       int n;
+
+       *jmp_ptr = &buf;
+       n = sigsetjmp(buf, 1);
+       if(n != 0)
+               return(n);
+       (*fn)(arg);
+       return(0);
+}
+
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
  * Emacs will notice this stuff at the end of the file and automatically
Index: test/arch/um/os-Linux/start_up.c
===================================================================
--- test.orig/arch/um/os-Linux/start_up.c	2005-09-01 07:45:10.520901648 -0400
+++ test/arch/um/os-Linux/start_up.c	2005-09-01 16:32:52.000000000 -0400
@@ -0,0 +1,329 @@
+/* 
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sched.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <sys/time.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <asm/unistd.h>
+#include <asm/page.h>
+#include "user_util.h"
+#include "kern_util.h"
+#include "user.h"
+#include "signal_kern.h"
+#include "signal_user.h"
+#include "sysdep/ptrace.h"
+#include "sysdep/sigcontext.h"
+#include "irq_user.h"
+#include "ptrace_user.h"
+#include "time_user.h"
+#include "init.h"
+#include "os.h"
+#include "uml-config.h"
+#include "choose-mode.h"
+#include "mode.h"
+#include "tempfile.h"
+#ifdef UML_CONFIG_MODE_SKAS
+#include "skas.h"
+#include "skas_ptrace.h"
+#include "registers.h"
+#endif
+
+static int ptrace_child(void *arg)
+{
+	int ret;
+	int pid = os_getpid(), ppid = getppid();
+	int sc_result;
+
+	if(ptrace(PTRACE_TRACEME, 0, 0, 0) < 0){
+		perror("ptrace");
+		os_kill_process(pid, 0);
+	}
+	os_stop_process(pid);
+
+	/*This syscall will be intercepted by the parent. Don't call more than
+	 * once, please.*/
+	sc_result = os_getpid();
+
+	if (sc_result == pid)
+		ret = 1; /*Nothing modified by the parent, we are running
+			   normally.*/
+	else if (sc_result == ppid)
+		ret = 0; /*Expected in check_ptrace and check_sysemu when they
+			   succeed in modifying the stack frame*/
+	else
+		ret = 2; /*Serious trouble! This could be caused by a bug in
+			   host 2.6 SKAS3/2.6 patch before release -V6, together
+			   with a bug in the UML code itself.*/
+	_exit(ret);
+}
+
+static int start_ptraced_child(void **stack_out)
+{
+	void *stack;
+	unsigned long sp;
+	int pid, n, status;
+	
+	stack = mmap(NULL, PAGE_SIZE, PROT_READ | PROT_WRITE | PROT_EXEC,
+		     MAP_PRIVATE | MAP_ANONYMOUS, -1, 0);
+	if(stack == MAP_FAILED)
+		panic("check_ptrace : mmap failed, errno = %d", errno);
+	sp = (unsigned long) stack + PAGE_SIZE - sizeof(void *);
+	pid = clone(ptrace_child, (void *) sp, SIGCHLD, NULL);
+	if(pid < 0)
+		panic("start_ptraced_child : clone failed, errno = %d", errno);
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+	if(n < 0)
+		panic("check_ptrace : clone failed, errno = %d", errno);
+	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGSTOP))
+		panic("check_ptrace : expected SIGSTOP, got status = %d",
+		      status);
+
+	*stack_out = stack;
+	return(pid);
+}
+
+/* When testing for SYSEMU support, if it is one of the broken versions, we 
+ * must just avoid using sysemu, not panic, but only if SYSEMU features are 
+ * broken.
+ * So only for SYSEMU features we test mustpanic, while normal host features
+ * must work anyway!
+ */
+static int stop_ptraced_child(int pid, void *stack, int exitcode, 
+			      int mustpanic)
+{
+	int status, n, ret = 0;
+
+	if(ptrace(PTRACE_CONT, pid, 0, 0) < 0)
+		panic("check_ptrace : ptrace failed, errno = %d", errno);
+	CATCH_EINTR(n = waitpid(pid, &status, 0));
+	if(!WIFEXITED(status) || (WEXITSTATUS(status) != exitcode)) {
+		int exit_with = WEXITSTATUS(status);
+		if (exit_with == 2)
+			printk("check_ptrace : child exited with status 2. "
+			       "Serious trouble happening! Try updating your "
+			       "host skas patch!\nDisabling SYSEMU support.");
+		printk("check_ptrace : child exited with exitcode %d, while "
+		      "expecting %d; status 0x%x", exit_with,
+		      exitcode, status);
+		if (mustpanic)
+			panic("\n");
+		else
+			printk("\n");
+		ret = -1;
+	}
+
+	if(munmap(stack, PAGE_SIZE) < 0)
+		panic("check_ptrace : munmap failed, errno = %d", errno);
+	return ret;
+}
+
+int ptrace_faultinfo = 1;
+int proc_mm = 1;
+
+static int __init skas0_cmd_param(char *str, int* add)
+{
+	ptrace_faultinfo = proc_mm = 0;
+	return 0;
+}
+
+__uml_setup("skas0", skas0_cmd_param,
+		"skas0\n"
+		"    Disables SKAS3 usage, so that SKAS0 is used, unless \n"
+	        "    you specify mode=tt.\n\n");
+
+static int force_sysemu_disabled = 0;
+
+static int __init nosysemu_cmd_param(char *str, int* add)
+{
+	force_sysemu_disabled = 1;
+	return 0;
+}
+
+__uml_setup("nosysemu", nosysemu_cmd_param,
+"nosysemu\n"
+"    Turns off syscall emulation patch for ptrace (SYSEMU) on.\n"
+"    SYSEMU is a performance-patch introduced by Laurent Vivier. It changes\n"
+"    behaviour of ptrace() and helps reducing host context switch rate.\n"
+"    To make it working, you need a kernel patch for your host, too.\n"
+"    See http://perso.wanadoo.fr/laurent.vivier/UML/ for further \n"
+"    information.\n\n");
+
+static void __init check_sysemu(void)
+{
+	void *stack;
+	int pid, syscall, n, status, count=0;
+
+	printk("Checking syscall emulation patch for ptrace...");
+	sysemu_supported = 0;
+	pid = start_ptraced_child(&stack);
+
+	if(ptrace(PTRACE_SYSEMU, pid, 0, 0) < 0)
+		goto fail;
+
+	CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+	if (n < 0)
+		panic("check_sysemu : wait failed, errno = %d", errno);
+	if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+		panic("check_sysemu : expected SIGTRAP, "
+		      "got status = %d", status);
+
+	n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
+		   os_getpid());
+	if(n < 0)
+		panic("check_sysemu : failed to modify system "
+		      "call return, errno = %d", errno);
+
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+		goto fail_stopped;
+
+	sysemu_supported = 1;
+	printk("OK\n");
+	set_using_sysemu(!force_sysemu_disabled);
+
+	printk("Checking advanced syscall emulation patch for ptrace...");
+	pid = start_ptraced_child(&stack);
+	while(1){
+		count++;
+		if(ptrace(PTRACE_SYSEMU_SINGLESTEP, pid, 0, 0) < 0)
+			goto fail;
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		if(n < 0)
+			panic("check_ptrace : wait failed, errno = %d", errno);
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP))
+			panic("check_ptrace : expected (SIGTRAP|SYSCALL_TRAP), "
+			      "got status = %d", status);
+
+		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
+				 0);
+		if(syscall == __NR_getpid){
+			if (!count)
+				panic("check_ptrace : SYSEMU_SINGLESTEP doesn't singlestep");
+			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_RET_OFFSET,
+				   os_getpid());
+			if(n < 0)
+				panic("check_sysemu : failed to modify system "
+				      "call return, errno = %d", errno);
+			break;
+		}
+	}
+	if (stop_ptraced_child(pid, stack, 0, 0) < 0)
+		goto fail_stopped;
+
+	sysemu_supported = 2;
+	printk("OK\n");
+
+	if ( !force_sysemu_disabled )
+		set_using_sysemu(sysemu_supported);
+	return;
+
+fail:
+	stop_ptraced_child(pid, stack, 1, 0);
+fail_stopped:
+	printk("missing\n");
+}
+
+static void __init check_ptrace(void)
+{
+	void *stack;
+	int pid, syscall, n, status;
+
+	printk("Checking that ptrace can change system call numbers...");
+	pid = start_ptraced_child(&stack);
+
+	if(ptrace(PTRACE_OLDSETOPTIONS, pid, 0, (void *)PTRACE_O_TRACESYSGOOD) < 0)
+		panic("check_ptrace: PTRACE_OLDSETOPTIONS failed, errno = %d", errno);
+
+	while(1){
+		if(ptrace(PTRACE_SYSCALL, pid, 0, 0) < 0)
+			panic("check_ptrace : ptrace failed, errno = %d", 
+			      errno);
+		CATCH_EINTR(n = waitpid(pid, &status, WUNTRACED));
+		if(n < 0)
+			panic("check_ptrace : wait failed, errno = %d", errno);
+		if(!WIFSTOPPED(status) || (WSTOPSIG(status) != SIGTRAP + 0x80))
+			panic("check_ptrace : expected SIGTRAP + 0x80, "
+			      "got status = %d", status);
+		
+		syscall = ptrace(PTRACE_PEEKUSR, pid, PT_SYSCALL_NR_OFFSET,
+				 0);
+		if(syscall == __NR_getpid){
+			n = ptrace(PTRACE_POKEUSR, pid, PT_SYSCALL_NR_OFFSET,
+				   __NR_getppid);
+			if(n < 0)
+				panic("check_ptrace : failed to modify system "
+				      "call, errno = %d", errno);
+			break;
+		}
+	}
+	stop_ptraced_child(pid, stack, 0, 1);
+	printk("OK\n");
+	check_sysemu();
+}
+
+void os_early_checks(void)
+{
+	check_ptrace();
+}
+
+#ifdef UML_CONFIG_MODE_SKAS
+static inline void check_skas3_ptrace_support(void)
+{
+	struct ptrace_faultinfo fi;
+	void *stack;
+	int pid, n;
+
+	printf("Checking for the skas3 patch in the host...");
+	pid = start_ptraced_child(&stack);
+
+	n = ptrace(PTRACE_FAULTINFO, pid, 0, &fi);
+	if (n < 0) {
+		ptrace_faultinfo = 0;
+		if(errno == EIO)
+			printf("not found\n");
+		else
+			perror("not found");
+	} 
+	else {
+		if (!ptrace_faultinfo)
+			printf("found but disabled on command line\n");
+		else
+			printf("found\n");
+	}
+
+	init_registers(pid);
+	stop_ptraced_child(pid, stack, 1, 1);
+}
+
+int can_do_skas(void)
+{
+	printf("Checking for /proc/mm...");
+	if (os_access("/proc/mm", OS_ACC_W_OK) < 0) {
+ 		proc_mm = 0;
+		printf("not found\n");
+	} 
+	else {
+		if (!proc_mm)
+			printf("found but disabled on command line\n");
+		else
+			printf("found\n");
+	}
+
+	check_skas3_ptrace_support();
+	return 1;
+}
+#else
+int can_do_skas(void)
+{
+	return(0);
+}
+#endif
Index: test/arch/um/os-Linux/tt.c
===================================================================
--- test.orig/arch/um/os-Linux/tt.c	2005-09-01 07:45:10.520901648 -0400
+++ test/arch/um/os-Linux/tt.c	2005-09-01 16:09:41.000000000 -0400
@@ -0,0 +1,113 @@
+/* 
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <stdio.h>
+#include <unistd.h>
+#include <signal.h>
+#include <sched.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <stdlib.h>
+#include <setjmp.h>
+#include <sys/time.h>
+#include <sys/ptrace.h>
+#include <linux/ptrace.h>
+#include <sys/wait.h>
+#include <sys/mman.h>
+#include <asm/ptrace.h>
+#include <asm/unistd.h>
+#include <asm/page.h>
+#include "user_util.h"
+#include "kern_util.h"
+#include "user.h"
+#include "signal_kern.h"
+#include "signal_user.h"
+#include "sysdep/ptrace.h"
+#include "sysdep/sigcontext.h"
+#include "irq_user.h"
+#include "ptrace_user.h"
+#include "time_user.h"
+#include "init.h"
+#include "os.h"
+#include "uml-config.h"
+#include "choose-mode.h"
+#include "mode.h"
+#include "tempfile.h"
+
+/*
+ *-------------------------
+ * only for tt mode (will be deleted in future...)
+ *-------------------------
+ */
+
+struct tramp {
+	int (*tramp)(void *);
+	void *tramp_data;
+	unsigned long temp_stack;
+	int flags;
+	int pid;
+};
+
+/* See above for why sigkill is here */
+
+int sigkill = SIGKILL;
+
+int outer_tramp(void *arg)
+{
+	struct tramp *t;
+	int sig = sigkill;
+
+	t = arg;
+	t->pid = clone(t->tramp, (void *) t->temp_stack + page_size()/2,
+		       t->flags, t->tramp_data);
+	if(t->pid > 0) wait_for_stop(t->pid, SIGSTOP, PTRACE_CONT, NULL);
+	kill(os_getpid(), sig);
+	_exit(0);
+}
+
+int start_fork_tramp(void *thread_arg, unsigned long temp_stack, 
+		     int clone_flags, int (*tramp)(void *))
+{
+	struct tramp arg;
+	unsigned long sp;
+	int new_pid, status, err;
+
+	/* The trampoline will run on the temporary stack */
+	sp = stack_sp(temp_stack);
+
+	clone_flags |= CLONE_FILES | SIGCHLD;
+
+	arg.tramp = tramp;
+	arg.tramp_data = thread_arg;
+	arg.temp_stack = temp_stack;
+	arg.flags = clone_flags;
+
+	/* Start the process and wait for it to kill itself */
+	new_pid = clone(outer_tramp, (void *) sp, clone_flags, &arg);
+	if(new_pid < 0)
+		return(new_pid);
+
+	CATCH_EINTR(err = waitpid(new_pid, &status, 0));
+	if(err < 0)
+		panic("Waiting for outer trampoline failed - errno = %d",
+		      errno);
+
+	if(!WIFSIGNALED(status) || (WTERMSIG(status) != SIGKILL))
+		panic("outer trampoline didn't exit with SIGKILL, "
+		      "status = %d", status);
+
+	return(arg.pid);
+}
+
+void forward_pending_sigio(int target)
+{
+	sigset_t sigs;
+
+	if(sigpending(&sigs)) 
+		panic("forward_pending_sigio : sigpending failed");
+	if(sigismember(&sigs, SIGIO))
+		kill(target, SIGIO);
+}
+

