Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752237AbWAEWB5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752237AbWAEWB5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 17:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752241AbWAEWB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 17:01:57 -0500
Received: from saraswathi.solana.com ([198.99.130.12]:16041 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751167AbWAEWBx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 17:01:53 -0500
Message-Id: <200601052253.k05MrmPj010772@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Subject: [PATCH 3/4] UML - Merge trap_user.c and trap_kern.c
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 05 Jan 2006 17:53:48 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Gennady Sharapov <Gennady.V.Sharapov@intel.com>

The serial UML OS-abstraction layer patch (um/kernel dir).

This joins trap_user.c and trap_kernel.c files.

Signed-off-by: Gennady Sharapov <Gennady.V.Sharapov@intel.com>
Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/kernel/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/Makefile	2006-01-04 16:00:20.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/Makefile	2006-01-04 16:52:33.000000000 -0500
@@ -10,7 +10,7 @@ obj-y = config.o exec_kern.o exitcode.o 
 	init_task.o irq.o irq_user.o ksyms.o mem.o physmem.o \
 	process_kern.o ptrace.o reboot.o resource.o sigio_user.o sigio_kern.o \
 	signal_kern.o smp.o syscall_kern.o sysrq.o time.o \
-	time_kern.o tlb.o trap_kern.o trap_user.o uaccess.o um_arch.o umid.o \
+	time_kern.o tlb.o trap_kern.o uaccess.o um_arch.o umid.o \
 	user_util.o
 
 obj-$(CONFIG_BLK_DEV_INITRD) += initrd.o
Index: linux-2.6.15/arch/um/kernel/trap_kern.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/trap_kern.c	2006-01-04 16:52:17.000000000 -0500
+++ linux-2.6.15/arch/um/kernel/trap_kern.c	2006-01-04 16:52:33.000000000 -0500
@@ -26,6 +26,9 @@
 #include "mconsole_kern.h"
 #include "mem.h"
 #include "mem_kern.h"
+#include "sysdep/sigcontext.h"
+#include "sysdep/ptrace.h"
+#include "os.h"
 #ifdef CONFIG_MODE_SKAS
 #include "skas.h"
 #endif
@@ -126,6 +129,17 @@ out_of_memory:
 	goto out;
 }
 
+void segv_handler(int sig, union uml_pt_regs *regs)
+{
+	struct faultinfo * fi = UPT_FAULTINFO(regs);
+
+	if(UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)){
+		bad_segv(*fi, UPT_IP(regs));
+		return;
+	}
+	segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
+}
+
 struct kern_handlers handlinfo_kern = {
 	.relay_signal = relay_signal,
 	.winch = winch,
Index: linux-2.6.15/arch/um/kernel/trap_user.c
===================================================================
--- linux-2.6.15.orig/arch/um/kernel/trap_user.c	2006-01-04 16:52:17.000000000 -0500
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,58 +0,0 @@
-/*
- * Copyright (C) 2000, 2001, 2002 Jeff Dike (jdike@karaya.com)
- * Licensed under the GPL
- */
-
-#include <stdlib.h>
-#include <errno.h>
-#include <setjmp.h>
-#include <signal.h>
-#include <sys/time.h>
-#include <sys/wait.h>
-#include <asm/page.h>
-#include <asm/unistd.h>
-#include <asm/ptrace.h>
-#include "init.h"
-#include "sysdep/ptrace.h"
-#include "sigcontext.h"
-#include "sysdep/sigcontext.h"
-#include "irq_user.h"
-#include "time_user.h"
-#include "task.h"
-#include "mode.h"
-#include "choose-mode.h"
-#include "kern_util.h"
-#include "user_util.h"
-#include "os.h"
-
-void segv_handler(int sig, union uml_pt_regs *regs)
-{
-        struct faultinfo * fi = UPT_FAULTINFO(regs);
-
-        if(UPT_IS_USER(regs) && !SEGV_IS_FIXABLE(fi)){
-                bad_segv(*fi, UPT_IP(regs));
-		return;
-	}
-        segv(*fi, UPT_IP(regs), UPT_IS_USER(regs), regs);
-}
-
-void usr2_handler(int sig, union uml_pt_regs *regs)
-{
-	CHOOSE_MODE(syscall_handler_tt(sig, regs), (void) 0);
-}
-
-void (*sig_info[NSIG])(int, union uml_pt_regs *);
-
-void os_fill_handlinfo(struct kern_handlers h)
-{
-	sig_info[SIGTRAP] = h.relay_signal;
-	sig_info[SIGFPE] = h.relay_signal;
-	sig_info[SIGILL] = h.relay_signal;
-	sig_info[SIGWINCH] = h.winch;
-	sig_info[SIGBUS] = h.bus_handler;
-	sig_info[SIGSEGV] = h.page_fault;
-	sig_info[SIGIO] = h.sigio_handler;
-	sig_info[SIGVTALRM] = h.timer_handler;
-	sig_info[SIGALRM] = h.timer_handler;
-	sig_info[SIGUSR2] = usr2_handler;
-}
Index: linux-2.6.15/arch/um/os-Linux/trap.c
===================================================================
--- linux-2.6.15.orig/arch/um/os-Linux/trap.c	2006-01-04 16:52:17.000000000 -0500
+++ linux-2.6.15/arch/um/os-Linux/trap.c	2006-01-04 16:52:33.000000000 -0500
@@ -3,11 +3,34 @@
  * Licensed under the GPL
  */
 
-#include <setjmp.h>
+#include <stdlib.h>
 #include <signal.h>
+#include <setjmp.h>
 #include "kern_util.h"
 #include "user_util.h"
 #include "os.h"
+#include "mode.h"
+
+void usr2_handler(int sig, union uml_pt_regs *regs)
+{
+	CHOOSE_MODE(syscall_handler_tt(sig, regs), (void) 0);
+}
+
+void (*sig_info[NSIG])(int, union uml_pt_regs *);
+
+void os_fill_handlinfo(struct kern_handlers h)
+{
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
+}
 
 void do_longjmp(void *b, int val)
 {

