Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752240AbWAEWCY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752240AbWAEWCY (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:02:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752239AbWAEWCB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:02:01 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:16297 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1752235AbWAEWBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:01:53 -0500
Message-Id: <200601052253.k05MrkBA010762@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 1/4] UML - Move libc-dependent code from signal_user.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Jan 2006 17:53:45 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from signal_user.c file under os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/kern_util.h	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/include/kern_util.h	2006-01-04 16:00:20.000000000 -0500
@@ -51,8 +51,6 @@ extern void timer_handler(int sig, union
 extern int set_signals(int enable);
 extern void force_sigbus(void);
 extern int pid_to_processor_id(int pid);
-extern void block_signals(void);
-extern void unblock_signals(void);
 extern void deliver_signals(void *t);
 extern int next_syscall_index(int max);
 extern int next_trap_index(int max);
Index: linux-2.6.15/arch/um/include/os.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/os.h	2006-01-04 15:06:44.000000000 -0500
+++ linux-2.6.15/arch/um/include/os.h	2006-01-04 16:00:20.000000000 -0500
@@ -219,4 +219,14 @@ extern int umid_file_name(char *name, ch
 extern int set_umid(char *name);
 extern char *get_umid(void);
 
+/* signal.c */
+extern void set_sigstack(void *sig_stack, int size);
+extern void remove_sigstack(void);
+extern void set_handler(int sig, void (*handler)(int), int flags, ...);
+extern int change_sig(int signal, int on);
+extern void block_signals(void);
+extern void unblock_signals(void);
+extern int get_signals(void);
+extern int set_signals(int enable);
+
 #endif
Index: linux-2.6.15/arch/um/include/signal_user.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/signal_user.h	2005-08-28 19:41:01.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,28 +0,0 @@
-/* 
- * Copyright (C) 2001 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#ifndef __SIGNAL_USER_H__
-#define __SIGNAL_USER_H__
-
-extern int signal_stack_size;
-
-extern int change_sig(int signal, int on);
-extern void set_sigstack(void *stack, int size);
-extern void set_handler(int sig, void (*handler)(int), int flags, ...);
-extern int set_signals(int enable);
-extern int get_signals(void);
-
-#endif
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.15/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/Makefile	2006-01-04 15:03:49.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/Makefile	2006-01-04 16:00:20.000000000 -0500
@@ -9,7 +9,7 @@ clean-files :=
 obj-y = config.o exec_kern.o exitcode.o \
 	init_task.o irq.o irq_user.o ksyms.o mem.o physmem.o \
 	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
-	signal_kern.o signal_user.o smp.o syscall_kern.o sysrq.o time.o \
+	signal_kern.o smp.o syscall_kern.o sysrq.o time.o \
 	time_kern.o tlb.o trap_kern.o trap_user.o uaccess.o um_arch.o umid.o \
 	user_util.o
 
Index: linux-2.6.15/arch/um/kernel/irq_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/irq_user.c	2006-01-04 13:55:56.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/irq_user.c	2006-01-04 16:00:20.000000000 -0500
@@ -15,7 +15,6 @@
 #include "kern_util.h"
 #include "user.h"
 #include "process.h"
-#include "signal_user.h"
 #include "sigio.h"
 #include "irq_user.h"
 #include "os.h"
Index: linux-2.6.15/arch/um/kernel/process_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/process_kern.c	2006-01-04 15:03:49.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/process_kern.c	2006-01-04 16:00:20.000000000 -0500
@@ -36,7 +36,6 @@
 #include "kern_util.h"
 #include "kern.h"
 #include "signal_kern.h"
-#include "signal_user.h"
 #include "init.h"
 #include "irq_user.h"
 #include "mem_user.h"
Index: linux-2.6.15/arch/um/kernel/signal_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/signal_kern.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/signal_kern.c	2006-01-04 16:00:20.000000000 -0500
@@ -22,7 +22,6 @@
 #include "asm/ucontext.h"
 #include "kern_util.h"
 #include "signal_kern.h"
-#include "signal_user.h"
 #include "kern.h"
 #include "frame_kern.h"
 #include "sigcontext.h"
Index: linux-2.6.15/arch/um/kernel/signal_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/signal_user.c	2005-08-28 19:41:01.000000000 -0400
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,157 +0,0 @@
-/* 
- * Copyright (C) 2000 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdio.h>
-#include <unistd.h>
-#include <stdlib.h>
-#include <signal.h>
-#include <errno.h>
-#include <stdarg.h>
-#include <string.h>
-#include <sys/mman.h>
-#include "user_util.h"
-#include "kern_util.h"
-#include "user.h"
-#include "signal_user.h"
-#include "signal_kern.h"
-#include "sysdep/sigcontext.h"
-#include "sigcontext.h"
-
-void set_sigstack(void *sig_stack, int size)
-{
-	stack_t stack = ((stack_t) { .ss_flags	= 0,
-				     .ss_sp	= (__ptr_t) sig_stack,
-				     .ss_size 	= size - sizeof(void *) });
-
-	if(sigaltstack(&stack, NULL) != 0)
-		panic("enabling signal stack failed, errno = %d\n", errno);
-}
-
-void set_handler(int sig, void (*handler)(int), int flags, ...)
-{
-	struct sigaction action;
-	va_list ap;
-	int mask;
-
-	va_start(ap, flags);
-	action.sa_handler = handler;
-	sigemptyset(&action.sa_mask);
-	while((mask = va_arg(ap, int)) != -1){
-		sigaddset(&action.sa_mask, mask);
-	}
-	va_end(ap);
-	action.sa_flags = flags;
-	action.sa_restorer = NULL;
-	if(sigaction(sig, &action, NULL) < 0)
-		panic("sigaction failed");
-}
-
-int change_sig(int signal, int on)
-{
-	sigset_t sigset, old;
-
-	sigemptyset(&sigset);
-	sigaddset(&sigset, signal);
-	sigprocmask(on ? SIG_UNBLOCK : SIG_BLOCK, &sigset, &old);
-	return(!sigismember(&old, signal));
-}
-
-/* Both here and in set/get_signal we don't touch SIGPROF, because we must not
- * disable profiling; it's safe because the profiling code does not interact
- * with the kernel code at all.*/
-
-static void change_signals(int type)
-{
-	sigset_t mask;
-
-	sigemptyset(&mask);
-	sigaddset(&mask, SIGVTALRM);
-	sigaddset(&mask, SIGALRM);
-	sigaddset(&mask, SIGIO);
-	if(sigprocmask(type, &mask, NULL) < 0)
-		panic("Failed to change signal mask - errno = %d", errno);
-}
-
-void block_signals(void)
-{
-	change_signals(SIG_BLOCK);
-}
-
-void unblock_signals(void)
-{
-	change_signals(SIG_UNBLOCK);
-}
-
-/* These are the asynchronous signals.  SIGVTALRM and SIGARLM are handled
- * together under SIGVTALRM_BIT.  SIGPROF is excluded because we want to
- * be able to profile all of UML, not just the non-critical sections.  If
- * profiling is not thread-safe, then that is not my problem.  We can disable
- * profiling when SMP is enabled in that case.
- */
-#define SIGIO_BIT 0
-#define SIGVTALRM_BIT 1
-
-static int enable_mask(sigset_t *mask)
-{
-	int sigs;
-
-	sigs = sigismember(mask, SIGIO) ? 0 : 1 << SIGIO_BIT;
-	sigs |= sigismember(mask, SIGVTALRM) ? 0 : 1 << SIGVTALRM_BIT;
-	sigs |= sigismember(mask, SIGALRM) ? 0 : 1 << SIGVTALRM_BIT;
-	return(sigs);
-}
-
-int get_signals(void)
-{
-	sigset_t mask;
-	
-	if(sigprocmask(SIG_SETMASK, NULL, &mask) < 0)
-		panic("Failed to get signal mask");
-	return(enable_mask(&mask));
-}
-
-int set_signals(int enable)
-{
-	sigset_t mask;
-	int ret;
-
-	sigemptyset(&mask);
-	if(enable & (1 << SIGIO_BIT)) 
-		sigaddset(&mask, SIGIO);
-	if(enable & (1 << SIGVTALRM_BIT)){
-		sigaddset(&mask, SIGVTALRM);
-		sigaddset(&mask, SIGALRM);
-	}
-
-	/* This is safe - sigprocmask is guaranteed to copy locally the
-	 * value of new_set, do his work and then, at the end, write to
-	 * old_set.
-	 */
-	if(sigprocmask(SIG_UNBLOCK, &mask, &mask) < 0)
-		panic("Failed to enable signals");
-	ret = enable_mask(&mask);
-	sigemptyset(&mask);
-	if((enable & (1 << SIGIO_BIT)) == 0) 
-		sigaddset(&mask, SIGIO);
-	if((enable & (1 << SIGVTALRM_BIT)) == 0){
-		sigaddset(&mask, SIGVTALRM);
-		sigaddset(&mask, SIGALRM);
-	}
-	if(sigprocmask(SIG_BLOCK, &mask, NULL) < 0)
-		panic("Failed to block signals");
-
-	return(ret);
-}
-
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
- */
Index: linux-2.6.15/arch/um/kernel/skas/include/skas.h
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/include/skas.h	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/include/skas.h	2006-01-04 16:00:20.000000000 -0500
@@ -22,7 +22,6 @@ extern int start_idle_thread(void *stack
 extern int user_thread(unsigned long stack, int flags);
 extern void userspace(union uml_pt_regs *regs);
 extern void new_thread_proc(void *stack, void (*handler)(int sig));
-extern void remove_sigstack(void);
 extern void new_thread_handler(int sig);
 extern void handle_syscall(union uml_pt_regs *regs);
 extern int map(struct mm_id * mm_idp, unsigned long virt,
Index: linux-2.6.15/arch/um/kernel/skas/process.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/process.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/process.c	2006-01-04 16:00:20.000000000 -0500
@@ -31,7 +31,6 @@
 #include "proc_mm.h"
 #include "skas_ptrace.h"
 #include "chan_user.h"
-#include "signal_user.h"
 #include "registers.h"
 #include "mem.h"
 #include "uml-config.h"
@@ -514,16 +513,6 @@ int start_idle_thread(void *stack, void 
 	siglongjmp(**switch_buf, 1);
 }
 
-void remove_sigstack(void)
-{
-	stack_t stack = ((stack_t) { .ss_flags	= SS_DISABLE,
-				     .ss_sp	= NULL,
-				     .ss_size	= 0 });
-
-	if(sigaltstack(&stack, NULL) != 0)
-		panic("disabling signal stack failed, errno = %d\n", errno);
-}
-
 void initial_thread_cb_skas(void (*proc)(void *), void *arg)
 {
 	sigjmp_buf here;
Index: linux-2.6.15/arch/um/kernel/skas/process_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/process_kern.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/skas/process_kern.c	2006-01-04 16:00:20.000000000 -0500
@@ -14,7 +14,6 @@
 #include "asm/atomic.h"
 #include "kern_util.h"
 #include "time_user.h"
-#include "signal_user.h"
 #include "skas.h"
 #include "os.h"
 #include "user_util.h"
Index: linux-2.6.15/arch/um/kernel/skas/trap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/trap_user.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/skas/trap_user.c	2006-01-04 16:00:20.000000000 -0500
@@ -5,7 +5,6 @@
 
 #include <signal.h>
 #include <errno.h>
-#include "signal_user.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "task.h"
@@ -14,6 +13,7 @@
 #include "ptrace_user.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/ptrace_user.h"
+#include "os.h"
 
 void sig_handler_common_skas(int sig, void *sc_ptr)
 {
Index: linux-2.6.15/arch/um/kernel/time.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/time.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/time.c	2006-01-04 16:00:20.000000000 -0500
@@ -14,9 +14,9 @@
 #include "kern_util.h"
 #include "user.h"
 #include "process.h"
-#include "signal_user.h"
 #include "time_user.h"
 #include "kern_constants.h"
+#include "os.h"
 
 /* XXX This really needs to be declared and initialized in a kernel file since
  * it's in <linux/time.h>
Index: linux-2.6.15/arch/um/kernel/trap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/trap_user.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/trap_user.c	2006-01-04 16:00:20.000000000 -0500
@@ -17,7 +17,6 @@
 #include "sigcontext.h"
 #include "sysdep/sigcontext.h"
 #include "irq_user.h"
-#include "signal_user.h"
 #include "time_user.h"
 #include "task.h"
 #include "mode.h"
Index: linux-2.6.15/arch/um/kernel/tt/exec_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/tt/exec_kern.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/tt/exec_kern.c	2006-01-04 16:00:21.000000000 -0500
@@ -14,7 +14,6 @@
 #include "kern_util.h"
 #include "irq_user.h"
 #include "time_user.h"
-#include "signal_user.h"
 #include "mem_user.h"
 #include "os.h"
 #include "tlb.h"
Index: linux-2.6.15/arch/um/kernel/tt/process_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/tt/process_kern.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/tt/process_kern.c	2006-01-04 16:00:21.000000000 -0500
@@ -13,7 +13,6 @@
 #include "asm/ptrace.h"
 #include "asm/tlbflush.h"
 #include "irq_user.h"
-#include "signal_user.h"
 #include "kern_util.h"
 #include "user_util.h"
 #include "os.h"
Index: linux-2.6.15/arch/um/kernel/tt/tracer.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/tt/tracer.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/tt/tracer.c	2006-01-04 16:00:21.000000000 -0500
@@ -19,7 +19,6 @@
 #include "sigcontext.h"
 #include "sysdep/sigcontext.h"
 #include "os.h"
-#include "signal_user.h"
 #include "user_util.h"
 #include "mem_user.h"
 #include "process.h"
Index: linux-2.6.15/arch/um/kernel/tt/trap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/tt/trap_user.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/tt/trap_user.c	2006-01-04 16:00:21.000000000 -0500
@@ -8,11 +8,11 @@
 #include <signal.h>
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
-#include "signal_user.h"
 #include "user_util.h"
 #include "kern_util.h"
 #include "task.h"
 #include "tt.h"
+#include "os.h"
 
 void sig_handler_common_tt(int sig, void *sc_ptr)
 {
Index: linux-2.6.15/arch/um/os-Linux/main.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/main.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/main.c	2006-01-04 16:00:21.000000000 -0500
@@ -16,7 +16,6 @@
 #include "user_util.h"
 #include "kern_util.h"
 #include "mem_user.h"
-#include "signal_user.h"
 #include "time_user.h"
 #include "irq_user.h"
 #include "user.h"
Index: linux-2.6.15/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/process.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/os-Linux/process.c	2006-01-04 16:00:21.000000000 -0500
@@ -15,7 +15,6 @@
 #include "os.h"
 #include "user.h"
 #include "user_util.h"
-#include "signal_user.h"
 #include "process.h"
 #include "irq_user.h"
 #include "kern_util.h"
Index: linux-2.6.15/arch/um/os-Linux/signal.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/signal.c	2005-08-28 19:41:01.000000000 -0400
+++ linux-2.6.15/arch/um/os-Linux/signal.c	2006-01-04 16:00:56.000000000 -0500
@@ -4,9 +4,22 @@
  */
 
 #include <signal.h>
+#include <stdio.h>
+#include <unistd.h>
+#include <stdlib.h>
+#include <errno.h>
+#include <stdarg.h>
+#include <string.h>
+#include <sys/mman.h>
+#include "user_util.h"
+#include "kern_util.h"
+#include "user.h"
+#include "signal_kern.h"
+#include "sysdep/sigcontext.h"
+#include "sysdep/signal.h"
+#include "sigcontext.h"
 #include "time_user.h"
 #include "mode.h"
-#include "sysdep/signal.h"
 
 void sig_handler(ARCH_SIGHDLR_PARAM)
 {
@@ -36,13 +49,138 @@ void alarm_handler(ARCH_SIGHDLR_PARAM)
 		switch_timers(1);
 }
 
-/*
- * Overrides for Emacs so that we follow Linus's tabbing style.
- * Emacs will notice this stuff at the end of the file and automatically
- * adjust the settings for this buffer only.  This must remain at the end
- * of the file.
- * ---------------------------------------------------------------------------
- * Local variables:
- * c-file-style: "linux"
- * End:
+void set_sigstack(void *sig_stack, int size)
+{
+	stack_t stack = ((stack_t) { .ss_flags	= 0,
+				     .ss_sp	= (__ptr_t) sig_stack,
+				     .ss_size 	= size - sizeof(void *) });
+
+	if(sigaltstack(&stack, NULL) != 0)
+		panic("enabling signal stack failed, errno = %d\n", errno);
+}
+
+void remove_sigstack(void)
+{
+	stack_t stack = ((stack_t) { .ss_flags	= SS_DISABLE,
+				     .ss_sp	= NULL,
+				     .ss_size	= 0 });
+
+	if(sigaltstack(&stack, NULL) != 0)
+		panic("disabling signal stack failed, errno = %d\n", errno);
+}
+
+void set_handler(int sig, void (*handler)(int), int flags, ...)
+{
+	struct sigaction action;
+	va_list ap;
+	int mask;
+
+	va_start(ap, flags);
+	action.sa_handler = handler;
+	sigemptyset(&action.sa_mask);
+	while((mask = va_arg(ap, int)) != -1){
+		sigaddset(&action.sa_mask, mask);
+	}
+	va_end(ap);
+	action.sa_flags = flags;
+	action.sa_restorer = NULL;
+	if(sigaction(sig, &action, NULL) < 0)
+		panic("sigaction failed");
+}
+
+int change_sig(int signal, int on)
+{
+	sigset_t sigset, old;
+
+	sigemptyset(&sigset);
+	sigaddset(&sigset, signal);
+	sigprocmask(on ? SIG_UNBLOCK : SIG_BLOCK, &sigset, &old);
+	return(!sigismember(&old, signal));
+}
+
+/* Both here and in set/get_signal we don't touch SIGPROF, because we must not
+ * disable profiling; it's safe because the profiling code does not interact
+ * with the kernel code at all.*/
+
+static void change_signals(int type)
+{
+	sigset_t mask;
+
+	sigemptyset(&mask);
+	sigaddset(&mask, SIGVTALRM);
+	sigaddset(&mask, SIGALRM);
+	sigaddset(&mask, SIGIO);
+	if(sigprocmask(type, &mask, NULL) < 0)
+		panic("Failed to change signal mask - errno = %d", errno);
+}
+
+void block_signals(void)
+{
+	change_signals(SIG_BLOCK);
+}
+
+void unblock_signals(void)
+{
+	change_signals(SIG_UNBLOCK);
+}
+
+/* These are the asynchronous signals.  SIGVTALRM and SIGARLM are handled
+ * together under SIGVTALRM_BIT.  SIGPROF is excluded because we want to
+ * be able to profile all of UML, not just the non-critical sections.  If
+ * profiling is not thread-safe, then that is not my problem.  We can disable
+ * profiling when SMP is enabled in that case.
  */
+#define SIGIO_BIT 0
+#define SIGVTALRM_BIT 1
+
+static int enable_mask(sigset_t *mask)
+{
+	int sigs;
+
+	sigs = sigismember(mask, SIGIO) ? 0 : 1 << SIGIO_BIT;
+	sigs |= sigismember(mask, SIGVTALRM) ? 0 : 1 << SIGVTALRM_BIT;
+	sigs |= sigismember(mask, SIGALRM) ? 0 : 1 << SIGVTALRM_BIT;
+	return(sigs);
+}
+
+int get_signals(void)
+{
+	sigset_t mask;
+
+	if(sigprocmask(SIG_SETMASK, NULL, &mask) < 0)
+		panic("Failed to get signal mask");
+	return(enable_mask(&mask));
+}
+
+int set_signals(int enable)
+{
+	sigset_t mask;
+	int ret;
+
+	sigemptyset(&mask);
+	if(enable & (1 << SIGIO_BIT))
+		sigaddset(&mask, SIGIO);
+	if(enable & (1 << SIGVTALRM_BIT)){
+		sigaddset(&mask, SIGVTALRM);
+		sigaddset(&mask, SIGALRM);
+	}
+
+	/* This is safe - sigprocmask is guaranteed to copy locally the
+	 * value of new_set, do his work and then, at the end, write to
+	 * old_set.
+	 */
+	if(sigprocmask(SIG_UNBLOCK, &mask, &mask) < 0)
+		panic("Failed to enable signals");
+	ret = enable_mask(&mask);
+	sigemptyset(&mask);
+	if((enable & (1 << SIGIO_BIT)) == 0)
+		sigaddset(&mask, SIGIO);
+	if((enable & (1 << SIGVTALRM_BIT)) == 0){
+		sigaddset(&mask, SIGVTALRM);
+		sigaddset(&mask, SIGALRM);
+	}
+	if(sigprocmask(SIG_BLOCK, &mask, NULL) < 0)
+		panic("Failed to block signals");
+
+	return(ret);
+}
Index: linux-2.6.15/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/start_up.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/start_up.c	2006-01-04 16:00:21.000000000 -0500
@@ -24,7 +24,6 @@
 #include "kern_util.h"
 #include "user.h"
 #include "signal_kern.h"
-#include "signal_user.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
 #include "irq_user.h"
Index: linux-2.6.15/arch/um/os-Linux/tt.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/tt.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/os-Linux/tt.c	2006-01-04 16:00:21.000000000 -0500
@@ -23,7 +23,6 @@
 #include "kern_util.h"
 #include "user.h"
 #include "signal_kern.h"
-#include "signal_user.h"
 #include "sysdep/ptrace.h"
 #include "sysdep/sigcontext.h"
 #include "irq_user.h"
Index: linux-2.6.15/arch/um/sys-i386/signal.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-i386/signal.c	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/sys-i386/signal.c	2006-01-04 16:00:21.000000000 -0500
@@ -10,7 +10,6 @@
 #include "asm/uaccess.h"
 #include "asm/unistd.h"
 #include "frame_kern.h"
-#include "signal_user.h"
 #include "sigcontext.h"
 #include "registers.h"
 #include "mode.h"

