Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751454AbWIYSg4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751454AbWIYSg4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Sep 2006 14:36:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751449AbWIYSgi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Sep 2006 14:36:38 -0400
Received: from [198.99.130.12] ([198.99.130.12]:54164 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751454AbWIYSgG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Sep 2006 14:36:06 -0400
Message-Id: <200609251834.k8PIYiP2005052@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 7/8] UML - Mark some tt-mode code
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 25 Sep 2006 14:34:44 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark a symbol and file as being tt-mode only.  This shrinks the
binary slightly when tt mode support is compiled out and makes it
easier to identity stuff when tt mode is removed.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-mm/arch/um/kernel/ksyms.c
===================================================================
--- linux-2.6.18-mm.orig/arch/um/kernel/ksyms.c	2006-09-22 09:16:01.000000000 -0400
+++ linux-2.6.18-mm/arch/um/kernel/ksyms.c	2006-09-22 09:51:13.000000000 -0400
@@ -20,7 +20,6 @@
 #include "mem_user.h"
 #include "os.h"
 
-EXPORT_SYMBOL(stop);
 EXPORT_SYMBOL(uml_physmem);
 EXPORT_SYMBOL(set_signals);
 EXPORT_SYMBOL(get_signals);
@@ -40,6 +39,7 @@ EXPORT_SYMBOL(handle_page_fault);
 EXPORT_SYMBOL(find_iomem);
 
 #ifdef CONFIG_MODE_TT
+EXPORT_SYMBOL(stop);
 EXPORT_SYMBOL(strncpy_from_user_tt);
 EXPORT_SYMBOL(copy_from_user_tt);
 EXPORT_SYMBOL(copy_to_user_tt);
Index: linux-2.6.18-mm/arch/um/os-Linux/Makefile
===================================================================
--- linux-2.6.18-mm.orig/arch/um/os-Linux/Makefile	2006-09-22 09:16:01.000000000 -0400
+++ linux-2.6.18-mm/arch/um/os-Linux/Makefile	2006-09-22 09:51:13.000000000 -0400
@@ -4,15 +4,19 @@
 #
 
 obj-y = aio.o elf_aux.o file.o helper.o irq.o main.o mem.o process.o sigio.o \
-	signal.o start_up.o time.o trap.o tt.o tty.o uaccess.o umid.o tls.o \
+	signal.o start_up.o time.o trap.o tty.o uaccess.o umid.o tls.o \
 	user_syms.o util.o drivers/ sys-$(SUBARCH)/
 
 obj-$(CONFIG_MODE_SKAS) += skas/
+
+obj-$(CONFIG_MODE_TT) += tt.o
+user-objs-$(CONFIG_MODE_TT) += tt.o
+
 obj-$(CONFIG_TTY_LOG) += tty_log.o
 user-objs-$(CONFIG_TTY_LOG) += tty_log.o
 
 USER_OBJS := $(user-objs-y) aio.o elf_aux.o file.o helper.o irq.o main.o mem.o \
-	process.o sigio.o signal.o start_up.o time.o trap.o tt.o tty.o tls.o \
+	process.o sigio.o signal.o start_up.o time.o trap.o tty.o tls.o \
 	uaccess.o umid.o util.o
 
 CFLAGS_user_syms.o += -DSUBARCH_$(SUBARCH)
Index: linux-2.6.18-mm/arch/um/include/os.h
===================================================================
--- linux-2.6.18-mm.orig/arch/um/include/os.h	2006-09-22 09:16:05.000000000 -0400
+++ linux-2.6.18-mm/arch/um/include/os.h	2006-09-22 09:51:13.000000000 -0400
@@ -198,7 +198,9 @@ extern long os_ptrace_ldt(long pid, long
 extern int os_getpid(void);
 extern int os_getpgrp(void);
 
+#ifdef UML_CONFIG_MODE_TT
 extern void init_new_thread_stack(void *sig_stack, void (*usr1_handler)(int));
+#endif
 extern void init_new_thread_signals(void);
 extern int run_kernel_thread(int (*fn)(void *), void *arg, void **jmp_ptr);
 
@@ -216,7 +218,6 @@ extern void os_flush_stdout(void);
  */
 extern void forward_ipi(int fd, int pid);
 extern void kill_child_dead(int pid);
-extern void stop(void);
 extern int wait_for_stop(int pid, int sig, int cont_type, void *relay);
 extern int protect_memory(unsigned long addr, unsigned long len,
 			  int r, int w, int x, int must_succeed);

