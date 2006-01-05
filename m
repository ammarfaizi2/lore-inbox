Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932237AbWAEWDG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932237AbWAEWDG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:03:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932238AbWAEWDG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:03:06 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:20393 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932237AbWAEWDD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:03:03 -0500
Message-Id: <200601052253.k05MrmQT010767@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 2/4] UML - Move libc-dependent code from trap_user.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Jan 2006 17:53:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This moves all systemcalls from trap_user.c file under os-Linux dir

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/kern_util.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/kern_util.h	2006-01-04 16:00:20.000000000 -0500
+++ linux-2.6.15/arch/um/include/kern_util.h	2006-01-04 16:52:17.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -10,6 +10,19 @@
 #include "sysdep/ptrace.h"
 #include "sysdep/faultinfo.h"
 
+typedef void (*kern_hndl)(int, union uml_pt_regs *);
+
+struct kern_handlers {
+	kern_hndl relay_signal;
+	kern_hndl winch;
+	kern_hndl bus_handler;
+	kern_hndl page_fault;
+	kern_hndl sigio_handler;
+	kern_hndl timer_handler;
+};
+
+extern struct kern_handlers handlinfo_kern;
+
 extern int ncpus;
 extern char *linux_prog;
 extern char *gdb_init;
@@ -109,6 +122,8 @@ extern void arch_switch(void);
 extern void free_irq(unsigned int, void *);
 extern int um_in_interrupt(void);
 extern int cpu(void);
+extern void segv_handler(int sig, union uml_pt_regs *regs);
+extern void sigio_handler(int sig, union uml_pt_regs *regs);
 
 #endif
 
Index: linux-2.6.15/arch/um/include/os.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/os.h	2006-01-04 16:00:20.000000000 -0500
+++ linux-2.6.15/arch/um/include/os.h	2006-01-04 16:52:17.000000000 -0500
@@ -9,6 +9,8 @@
 #include "uml-config.h"
 #include "asm/types.h"
 #include "../os/include/file.h"
+#include "sysdep/ptrace.h"
+#include "kern_util.h"
 
 #define OS_TYPE_FILE 1 
 #define OS_TYPE_DIR 2 
@@ -229,4 +231,8 @@ extern void unblock_signals(void);
 extern int get_signals(void);
 extern int set_signals(int enable);
 
+/* trap.c */
+extern void os_fill_handlinfo(struct kern_handlers h);
+extern void do_longjmp(void *p, int val);
+
 #endif
Index: linux-2.6.15/arch/um/include/user_util.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/user_util.h	2006-01-04 15:06:44.000000000 -0500
+++ linux-2.6.15/arch/um/include/user_util.h	2006-01-04 16:52:17.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -23,12 +23,7 @@ struct cpu_task {
 
 extern struct cpu_task cpu_tasks[];
 
-struct signal_info {
-	void (*handler)(int, union uml_pt_regs *);
-	int is_irq;
-};
-
-extern struct signal_info sig_info[];
+extern void (*sig_info[])(int, union uml_pt_regs *);
 
 extern unsigned long low_physmem;
 extern unsigned long high_physmem;
@@ -64,7 +59,6 @@ extern void setup_machinename(char *mach
 extern void setup_hostinfo(void);
 extern void do_exec(int old_pid, int new_pid);
 extern void tracer_panic(char *msg, ...);
-extern void do_longjmp(void *p, int val);
 extern int detach(int pid, int sig);
 extern int attach(int pid);
 extern void kill_child_dead(int pid);
Index: linux-2.6.15/arch/um/kernel/skas/trap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/trap_user.c	2006-01-04 16:00:20.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,78 +0,0 @@
-/* 
- * Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
- * Licensed under the GPL
- */
-
-#include <signal.h>
-#include <errno.h>
-#include "user_util.h"
-#include "kern_util.h"
-#include "task.h"
-#include "sigcontext.h"
-#include "skas.h"
-#include "ptrace_user.h"
-#include "sysdep/ptrace.h"
-#include "sysdep/ptrace_user.h"
-#include "os.h"
-
-void sig_handler_common_skas(int sig, void *sc_ptr)
-{
-	struct sigcontext *sc = sc_ptr;
-	struct skas_regs *r;
-	struct signal_info *info;
-	int save_errno = errno;
-	int save_user;
-
-	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
-	 * handler.  This can happen in copy_user, and if SEGV is disabled,
-	 * the process will die.
-	 * XXX Figure out why this is better than SA_NODEFER
-	 */
-	if(sig == SIGSEGV)
-		change_sig(SIGSEGV, 1);
-
-	r = &TASK_REGS(get_current())->skas;
-	save_user = r->is_user;
-	r->is_user = 0;
-        if ( sig == SIGFPE || sig == SIGSEGV ||
-             sig == SIGBUS || sig == SIGILL ||
-             sig == SIGTRAP ) {
-                GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
-        }
-
-	change_sig(SIGUSR1, 1);
-	info = &sig_info[sig];
-	if(!info->is_irq) unblock_signals();
-
-	(*info->handler)(sig, (union uml_pt_regs *) r);
-
-	errno = save_errno;
-	r->is_user = save_user;
-}
-
-extern int ptrace_faultinfo;
-
-void user_signal(int sig, union uml_pt_regs *regs, int pid)
-{
-	struct signal_info *info;
-        int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
-                    (sig == SIGILL) || (sig == SIGTRAP));
-
-	if (segv)
-		get_skas_faultinfo(pid, &regs->skas.faultinfo);
-	info = &sig_info[sig];
-	(*info->handler)(sig, regs);
-
-	unblock_signals();
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
Index: linux-2.6.15/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/trap_kern.c	2006-01-03 17:39:46.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/trap_kern.c	2006-01-04 16:52:17.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2001 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -29,6 +29,7 @@
 #ifdef CONFIG_MODE_SKAS
 #include "skas.h"
 #endif
+#include "os.h"
 
 /* Note this is constrained to return 0, -EFAULT, -EACCESS, -ENOMEM by segv(). */
 int handle_page_fault(unsigned long address, unsigned long ip, 
@@ -125,6 +126,14 @@ out_of_memory:
 	goto out;
 }
 
+struct kern_handlers handlinfo_kern = {
+	.relay_signal = relay_signal,
+	.winch = winch,
+	.bus_handler = relay_signal,
+	.page_fault = segv_handler,
+	.sigio_handler = sigio_handler,
+	.timer_handler = timer_handler
+};
 /*
  * We give a *copy* of the faultinfo in the regs to segv.
  * This must be done, since nesting SEGVs could overwrite
Index: linux-2.6.15/arch/um/kernel/trap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/trap_user.c	2006-01-04 16:00:20.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/trap_user.c	2006-01-04 16:52:17.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -25,20 +25,6 @@
 #include "user_util.h"
 #include "os.h"
 
-void kill_child_dead(int pid)
-{
-	kill(pid, SIGKILL);
-	kill(pid, SIGCONT);
-	do {
-		int n;
-		CATCH_EINTR(n = waitpid(pid, NULL, 0));
-		if (n > 0)
-			kill(pid, SIGCONT);
-		else
-			break;
-	} while(1);
-}
-
 void segv_handler(int sig, union uml_pt_regs *regs)
 {
         struct faultinfo * fi = UPT_FAULTINFO(regs);
@@ -55,43 +41,18 @@ void usr2_handler(int sig, union uml_pt_
 	CHOOSE_MODE(syscall_handler_tt(sig, regs), (void) 0);
 }
 
-struct signal_info sig_info[] = {
-	[ SIGTRAP ] { .handler 		= relay_signal,
-		      .is_irq 		= 0 },
-	[ SIGFPE ] { .handler 		= relay_signal,
-		     .is_irq 		= 0 },
-	[ SIGILL ] { .handler 		= relay_signal,
-		     .is_irq 		= 0 },
-	[ SIGWINCH ] { .handler		= winch,
-		       .is_irq		= 1 },
-	[ SIGBUS ] { .handler 		= bus_handler,
-		     .is_irq 		= 0 },
-	[ SIGSEGV] { .handler 		= segv_handler,
-		     .is_irq 		= 0 },
-	[ SIGIO ] { .handler 		= sigio_handler,
-		    .is_irq 		= 1 },
-	[ SIGVTALRM ] { .handler 	= timer_handler,
-			.is_irq 	= 1 },
-        [ SIGALRM ] { .handler          = timer_handler,
-                      .is_irq           = 1 },
-	[ SIGUSR2 ] { .handler 		= usr2_handler,
-		      .is_irq 		= 0 },
-};
+void (*sig_info[NSIG])(int, union uml_pt_regs *);
 
-void do_longjmp(void *b, int val)
+void os_fill_handlinfo(struct kern_handlers h)
 {
-	sigjmp_buf *buf = b;
-
-	siglongjmp(*buf, val);
+	sig_info[SIGTRAP] = h.relay_signal;
+	sig_info[SIGFPE] = h.relay_signal;
+	sig_info[SIGILL] = h.relay_signal;
+	sig_info[SIGWINCH] = h.winch;
+	sig_info[SIGBUS] = h.bus_handler;
+	sig_info[SIGSEGV] = h.page_fault;
+	sig_info[SIGIO] = h.sigio_handler;
+	sig_info[SIGVTALRM] = h.timer_handler;
+	sig_info[SIGALRM] = h.timer_handler;
+	sig_info[SIGUSR2] = usr2_handler;
 }
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
Index: linux-2.6.15/arch/um/kernel/tt/trap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/tt/trap_user.c	2006-01-04 16:00:21.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/tt/trap_user.c	2006-01-04 16:52:17.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -18,8 +18,8 @@ void sig_handler_common_tt(int sig, void
 {
 	struct sigcontext *sc = sc_ptr;
 	struct tt_regs save_regs, *r;
-	struct signal_info *info;
 	int save_errno = errno, is_user;
+	void (*handler)(int, union uml_pt_regs *);
 
 	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
 	 * handler.  This can happen in copy_user, and if SEGV is disabled,
@@ -40,10 +40,14 @@ void sig_handler_common_tt(int sig, void
 	if(sig != SIGUSR2) 
 		r->syscall = -1;
 
-	info = &sig_info[sig];
-	if(!info->is_irq) unblock_signals();
+	handler = sig_info[sig];
+
+	/* unblock SIGALRM, SIGVTALRM, SIGIO if sig isn't IRQ signal */
+	if (sig != SIGIO && sig != SIGWINCH &&
+	    sig != SIGVTALRM && sig != SIGALRM)
+		unblock_signals();
 
-	(*info->handler)(sig, (union uml_pt_regs *) r);
+	handler(sig, (union uml_pt_regs *) r);
 
 	if(is_user){
 		interrupt_end();
Index: linux-2.6.15/arch/um/kernel/um_arch.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/um_arch.c	2006-01-04 15:06:44.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/um_arch.c	2006-01-04 16:52:17.000000000 -0500
@@ -1,4 +1,4 @@
-/* 
+/*
  * Copyright (C) 2000, 2002 Jeff Dike (jdike@karaya.com)
  * Licensed under the GPL
  */
@@ -363,6 +363,11 @@ int linux_main(int argc, char **argv)
 	uml_start = CHOOSE_MODE_PROC(set_task_sizes_tt, set_task_sizes_skas, 0,
 				     &host_task_size, &task_size);
 
+	/*
+ 	 * Setting up handlers to 'sig_info' struct
+ 	 */
+	os_fill_handlinfo(handlinfo_kern);
+
 	brk_start = (unsigned long) sbrk(0);
 	CHOOSE_MODE_PROC(before_mem_tt, before_mem_skas, brk_start);
 	/* Increase physical memory size for exec-shield users
Index: linux-2.6.15/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/Makefile	2006-01-04 15:03:49.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/Makefile	2006-01-04 16:52:17.000000000 -0500
@@ -4,11 +4,13 @@
 #
 
 obj-y = aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
-	start_up.o time.o tt.o tty.o uaccess.o umid.o user_syms.o drivers/ \
-	sys-$(SUBARCH)/
+	start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o user_syms.o \
+	drivers/ sys-$(SUBARCH)/
+
+obj-$(CONFIG_MODE_SKAS) += skas/
 
 USER_OBJS := aio.o elf_aux.o file.o helper.o main.o mem.o process.o signal.o \
-	start_up.o time.o tt.o tty.o uaccess.o umid.o
+	start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o
 
 elf_aux.o: $(ARCH_DIR)/kernel-offsets.h
 CFLAGS_elf_aux.o += -I$(objtree)/arch/um
Index: linux-2.6.15/arch/um/os-Linux/trap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/arch/um/os-Linux/trap.c	2006-01-04 16:52:17.000000000 -0500
@@ -0,0 +1,17 @@
+/*
+ * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
+ * Licensed under the GPL
+ */
+
+#include <setjmp.h>
+#include <signal.h>
+#include "kern_util.h"
+#include "user_util.h"
+#include "os.h"
+
+void do_longjmp(void *b, int val)
+{
+	sigjmp_buf *buf = b;
+
+	siglongjmp(*buf, val);
+}
Index: linux-2.6.15/arch/um/os-Linux/tt.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/tt.c	2006-01-04 16:00:21.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/tt.c	2006-01-04 16:52:17.000000000 -0500
@@ -49,6 +49,20 @@ int protect_memory(unsigned long addr, u
 	return(0);
 }
 
+void kill_child_dead(int pid)
+{
+	kill(pid, SIGKILL);
+	kill(pid, SIGCONT);
+	do {
+		int n;
+		CATCH_EINTR(n = waitpid(pid, NULL, 0));
+		if (n > 0)
+			kill(pid, SIGCONT);
+		else
+			break;
+	} while(1);
+}
+
 /*
  *-------------------------
  * only for tt mode (will be deleted in future...)
Index: linux-2.6.15/arch/um/os-Linux/skas/Makefile
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/arch/um/os-Linux/skas/Makefile	2006-01-04 16:52:17.000000000 -0500
@@ -0,0 +1,10 @@
+#
+# Copyright (C) 2002 - 2004 Jeff Dike (jdike@addtoit.com)
+# Licensed under the GPL
+#
+
+obj-y := trap.o
+
+USER_OBJS := trap.o
+
+include arch/um/scripts/Makefile.rules
Index: linux-2.6.15/arch/um/os-Linux/skas/trap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15/arch/um/os-Linux/skas/trap.c	2006-01-04 16:52:17.000000000 -0500
@@ -0,0 +1,73 @@
+/*
+ * Copyright (C) 2002 - 2003 Jeff Dike (jdike@addtoit.com)
+ * Licensed under the GPL
+ */
+
+#include <signal.h>
+#include <errno.h>
+#include "user_util.h"
+#include "kern_util.h"
+#include "task.h"
+#include "sigcontext.h"
+#include "skas.h"
+#include "ptrace_user.h"
+#include "sysdep/ptrace.h"
+#include "sysdep/ptrace_user.h"
+#include "os.h"
+
+void sig_handler_common_skas(int sig, void *sc_ptr)
+{
+	struct sigcontext *sc = sc_ptr;
+	struct skas_regs *r;
+	void (*handler)(int, union uml_pt_regs *);
+	int save_errno = errno;
+	int save_user;
+
+	/* This is done because to allow SIGSEGV to be delivered inside a SEGV
+	 * handler.  This can happen in copy_user, and if SEGV is disabled,
+	 * the process will die.
+	 * XXX Figure out why this is better than SA_NODEFER
+	 */
+	if(sig == SIGSEGV)
+		change_sig(SIGSEGV, 1);
+
+	r = &TASK_REGS(get_current())->skas;
+	save_user = r->is_user;
+	r->is_user = 0;
+        if ( sig == SIGFPE || sig == SIGSEGV ||
+             sig == SIGBUS || sig == SIGILL ||
+             sig == SIGTRAP ) {
+                GET_FAULTINFO_FROM_SC(r->faultinfo, sc);
+        }
+
+	change_sig(SIGUSR1, 1);
+
+	handler = sig_info[sig];
+
+	/* unblock SIGALRM, SIGVTALRM, SIGIO if sig isn't IRQ signal */
+	if (sig != SIGIO && sig != SIGWINCH &&
+	    sig != SIGVTALRM && sig != SIGALRM)
+		unblock_signals();
+
+	handler(sig, (union uml_pt_regs *) r);
+
+	errno = save_errno;
+	r->is_user = save_user;
+}
+
+extern int ptrace_faultinfo;
+
+void user_signal(int sig, union uml_pt_regs *regs, int pid)
+{
+	void (*handler)(int, union uml_pt_regs *);
+        int segv = ((sig == SIGFPE) || (sig == SIGSEGV) || (sig == SIGBUS) ||
+                    (sig == SIGILL) || (sig == SIGTRAP));
+
+	if (segv)
+		get_skas_faultinfo(pid, &regs->skas.faultinfo);
+
+	handler = sig_info[sig];
+	handler(sig, (union uml_pt_regs *) regs);
+
+	unblock_signals();
+}
Index: linux-2.6.15/arch/um/kernel/skas/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/skas/Makefile	2005-10-28 12:58:12.000000000 -0400
+++ linux-2.6.15/arch/um/kernel/skas/Makefile	2006-01-04 16:52:17.000000000 -0500
@@ -4,7 +4,7 @@
 #
 
 obj-y := clone.o exec_kern.o mem.o mem_user.o mmu.o process.o process_kern.o \
-	syscall.o tlb.o trap_user.o uaccess.o
+	syscall.o tlb.o uaccess.o
 
 USER_OBJS := process.o clone.o
 

