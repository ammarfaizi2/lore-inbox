Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262680AbVAQDkE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262680AbVAQDkE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Jan 2005 22:40:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262678AbVAQDh0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Jan 2005 22:37:26 -0500
Received: from pool-151-203-218-166.bos.east.verizon.net ([151.203.218.166]:17156
	"EHLO ccure.user-mode-linux.org") by vger.kernel.org with ESMTP
	id S262673AbVAQDdo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Jan 2005 22:33:44 -0500
Message-Id: <200501170556.j0H5uCkY006062@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.4 06/23/2000 with nmh-1.1-RC1
To: akpm@osdl.org, Blaisorblade <blaisorblade@yahoo.it>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH 5/10] UML - compile fixes
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 17 Jan 2005 00:56:12 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This fixes some warnings, and changes the system call table so that it will
compile in -linus, where the vperf system calls are not yet merged.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: 2.6.10/arch/um/include/sysdep-i386/ptrace_user.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-i386/ptrace_user.h	2005-01-16 20:37:44.000000000 -0500
+++ 2.6.10/arch/um/include/sysdep-i386/ptrace_user.h	2005-01-16 20:59:20.000000000 -0500
@@ -6,6 +6,7 @@
 #ifndef __SYSDEP_I386_PTRACE_USER_H__
 #define __SYSDEP_I386_PTRACE_USER_H__
 
+#include <linux/ptrace.h>
 #include <asm/ptrace.h>
 
 #define PT_OFFSET(r) ((r) * sizeof(long))
Index: 2.6.10/arch/um/include/sysdep-i386/syscalls.h
===================================================================
--- 2.6.10.orig/arch/um/include/sysdep-i386/syscalls.h	2005-01-16 20:37:24.000000000 -0500
+++ 2.6.10/arch/um/include/sysdep-i386/syscalls.h	2005-01-16 20:59:20.000000000 -0500
@@ -15,6 +15,11 @@
 extern syscall_handler_t sys_rt_sigaction;
 
 extern syscall_handler_t old_mmap_i386;
+extern syscall_handler_t sys_vperfctr_open;
+extern syscall_handler_t sys_vperfctr_control;
+extern syscall_handler_t sys_vperfctr_unlink;
+extern syscall_handler_t sys_vperfctr_iresume;
+extern syscall_handler_t sys_vperfctr_read;
 
 #define EXECUTE_SYSCALL(syscall, regs) \
 	((long (*)(struct syscall_args)) (*sys_call_table[syscall]))(SYSCALL_ARGS(&regs->regs))
@@ -105,11 +110,25 @@
 	[ 251 ] = (syscall_handler_t *) sys_ni_syscall, \
         [ __NR_remap_file_pages ] = (syscall_handler_t *) sys_remap_file_pages, \
 	[ __NR_utimes ] = (syscall_handler_t *) sys_utimes, \
-	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall,
+	[ __NR_vserver ] = (syscall_handler_t *) sys_ni_syscall, \
+	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load, \
+	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key, \
+	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key, \
+	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl, \
+	VPERF
+
+#ifdef __NR_vperfctr_open
+#define VPERF \
+	[ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open, \
+	[ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control, \
+	[ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink, \
+	[ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume, \
+	[ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,
+#else
+#define VPERF
+#endif
         
-/* 222 doesn't yet have a name in include/asm-i386/unistd.h */
-
-#define LAST_ARCH_SYSCALL __NR_vserver
+#define LAST_ARCH_SYSCALL __NR_vperfctr_read
 
 /*
  * Overrides for Emacs so that we follow Linus's tabbing style.
Index: 2.6.10/arch/um/kernel/sys_call_table.c
===================================================================
--- 2.6.10.orig/arch/um/kernel/sys_call_table.c	2005-01-16 20:37:24.000000000 -0500
+++ 2.6.10/arch/um/kernel/sys_call_table.c	2005-01-16 20:59:20.000000000 -0500
@@ -20,11 +20,7 @@
 #define NFSSERVCTL sys_ni_syscall
 #endif
 
-#if 0
-#define LAST_GENERIC_SYSCALL __NR_vperfctr_read
-#else
-#define LAST_GENERIC_SYSCALL __NR_keyctl
-#endif
+#define LAST_GENERIC_SYSCALL __NR_waitid
 
 #if LAST_GENERIC_SYSCALL > LAST_ARCH_SYSCALL
 #define LAST_SYSCALL LAST_GENERIC_SYSCALL
@@ -56,17 +52,8 @@
 extern syscall_handler_t sys_mbind;
 extern syscall_handler_t sys_get_mempolicy;
 extern syscall_handler_t sys_set_mempolicy;
-extern syscall_handler_t sys_sys_kexec_load;
 extern syscall_handler_t sys_sys_setaltroot;
 
-#if 0
-extern syscall_handler_t sys_vperfctr_open;
-extern syscall_handler_t sys_vperfctr_control;
-extern syscall_handler_t sys_vperfctr_unlink;
-extern syscall_handler_t sys_vperfctr_iresume;
-extern syscall_handler_t sys_vperfctr_read;
-#endif
-
 syscall_handler_t *sys_call_table[] = {
 	[ __NR_restart_syscall ] = (syscall_handler_t *) sys_restart_syscall,
 	[ __NR_exit ] = (syscall_handler_t *) sys_exit,
@@ -280,25 +267,10 @@
 	[ __NR_mq_timedreceive ] = (syscall_handler_t *) sys_mq_timedreceive,
 	[ __NR_mq_notify ] = (syscall_handler_t *) sys_mq_notify,
 	[ __NR_mq_getsetattr ] = (syscall_handler_t *) sys_mq_getsetattr,
-#if 0
-	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_kexec_load,
-#endif
-	[ __NR_sys_kexec_load ] = (syscall_handler_t *) sys_ni_syscall,
 	[ __NR_waitid ] = (syscall_handler_t *) sys_waitid,
 #if 0
 	[ __NR_sys_setaltroot ] = (syscall_handler_t *) sys_sys_setaltroot,
 #endif
-	[ __NR_add_key ] = (syscall_handler_t *) sys_add_key,
-	[ __NR_request_key ] = (syscall_handler_t *) sys_request_key,
-	[ __NR_keyctl ] = (syscall_handler_t *) sys_keyctl,
-	/* These syscalls are still in -mm only*/
-#if 0
-	[ __NR_vperfctr_open ] = (syscall_handler_t *) sys_vperfctr_open,
-	[ __NR_vperfctr_control ] = (syscall_handler_t *) sys_vperfctr_control,
-	[ __NR_vperfctr_unlink ] = (syscall_handler_t *) sys_vperfctr_unlink,
-	[ __NR_vperfctr_iresume ] = (syscall_handler_t *) sys_vperfctr_iresume,
-	[ __NR_vperfctr_read ] = (syscall_handler_t *) sys_vperfctr_read,
-#endif
 
 	ARCH_SYSCALLS
 	[ LAST_SYSCALL + 1 ... NR_syscalls ] = 

