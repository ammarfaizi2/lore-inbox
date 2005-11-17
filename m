Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964905AbVKQUSj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964905AbVKQUSj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Nov 2005 15:18:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964909AbVKQUSK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Nov 2005 15:18:10 -0500
Received: from lakshmi.addtoit.com ([198.99.130.6]:57870 "EHLO
	lakshmi.solana.com") by vger.kernel.org with ESMTP id S964905AbVKQUSG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Nov 2005 15:18:06 -0500
Message-Id: <200511172110.jAHLASIB010204@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH 3/4] UML - Properly invoke x86_64 system calls
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 17 Nov 2005 16:10:28 -0500
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes stub_segv use the stub_syscall macros.  This was
needed anyway, but the bug that prompted this was the discovery that
gcc was storing stuff in RCX, which is trashed across a system
call.  This is exactly the sort of problem that the new macros fix.
There is a stub_syscall0 for getpid.
stub_segv was changed to be a libc file, and that caused some
include changes.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.15/arch/um/include/sysdep-i386/stub.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/sysdep-i386/stub.h	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/include/sysdep-i386/stub.h	2005-11-17 14:59:55.000000000 -0500
@@ -16,6 +16,15 @@
 #define STUB_MMAP_NR __NR_mmap2
 #define MMAP_OFFSET(o) ((o) >> PAGE_SHIFT)
 
+static inline long stub_syscall0(long syscall)
+{
+	long ret;
+
+	__asm__ volatile ("int $0x80" : "=a" (ret) : "0" (syscall));
+
+	return ret;
+}
+
 static inline long stub_syscall1(long syscall, long arg1)
 {
 	long ret;
Index: linux-2.6.15/arch/um/include/sysdep-x86_64/stub.h
===================================================================
--- linux-2.6.15.orig/arch/um/include/sysdep-x86_64/stub.h	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/include/sysdep-x86_64/stub.h	2005-11-17 14:59:55.000000000 -0500
@@ -6,7 +6,6 @@
 #ifndef __SYSDEP_STUB_H
 #define __SYSDEP_STUB_H
 
-#include <asm/ptrace.h>
 #include <asm/unistd.h>
 #include <sysdep/ptrace_user.h>
 
@@ -20,6 +19,17 @@
 #define __syscall_clobber "r11","rcx","memory"
 #define __syscall "syscall"
 
+static inline long stub_syscall0(long syscall)
+{
+	long ret;
+
+	__asm__ volatile (__syscall
+		: "=a" (ret)
+		: "0" (syscall) : __syscall_clobber );
+
+	return ret;
+}
+
 static inline long stub_syscall2(long syscall, long arg1, long arg2)
 {
 	long ret;
Index: linux-2.6.15/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/sys-i386/Makefile	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/sys-i386/Makefile	2005-11-17 14:59:55.000000000 -0500
@@ -5,7 +5,7 @@
 obj-$(CONFIG_HIGHMEM) += highmem.o
 obj-$(CONFIG_MODULES) += module.o
 
-USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o
+USER_OBJS := bugs.o ptrace_user.o sigcontext.o fault.o stub_segv.o
 
 SYMLINKS = bitops.c semaphore.c highmem.c module.c
 
Index: linux-2.6.15/arch/um/sys-i386/stub_segv.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-i386/stub_segv.c	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/sys-i386/stub_segv.c	2005-11-17 14:59:55.000000000 -0500
@@ -3,9 +3,11 @@
  * Licensed under the GPL
  */
 
-#include <asm/signal.h>
+#include <signal.h>
+#include <sys/select.h> /* The only way I can see to get sigset_t */
 #include <asm/unistd.h>
 #include "uml-config.h"
+#include "sysdep/stub.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
 
@@ -13,13 +15,14 @@
 stub_segv_handler(int sig)
 {
 	struct sigcontext *sc = (struct sigcontext *) (&sig + 1);
+	int pid;
 
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      sc);
 
-	__asm__("movl %0, %%eax ; int $0x80": : "g" (__NR_getpid));
-	__asm__("movl %%eax, %%ebx ; movl %0, %%eax ; movl %1, %%ecx ;"
-		"int $0x80": : "g" (__NR_kill), "g" (SIGUSR1));
+	pid = stub_syscall0(__NR_getpid);
+	stub_syscall2(__NR_kill, pid, SIGUSR1);
+
 	/* Load pointer to sigcontext into esp, since we need to leave
 	 * the stack in its original form when we do the sigreturn here, by
 	 * hand.
Index: linux-2.6.15/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.15.orig/arch/um/sys-x86_64/Makefile	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/sys-x86_64/Makefile	2005-11-17 14:59:55.000000000 -0500
@@ -12,7 +12,7 @@
 obj-y := ksyms.o
 obj-$(CONFIG_MODULES) += module.o um_module.o
 
-USER_OBJS := ptrace_user.o sigcontext.o
+USER_OBJS := ptrace_user.o sigcontext.o stub_segv.o
 
 SYMLINKS = bitops.c csum-copy.S csum-partial.c csum-wrappers.c ldt.c memcpy.S \
 	thunk.S module.c
Index: linux-2.6.15/arch/um/sys-x86_64/stub_segv.c
===================================================================
--- linux-2.6.15.orig/arch/um/sys-x86_64/stub_segv.c	2005-11-17 14:59:30.000000000 -0500
+++ linux-2.6.15/arch/um/sys-x86_64/stub_segv.c	2005-11-17 15:12:23.000000000 -0500
@@ -3,14 +3,14 @@
  * Licensed under the GPL
  */
 
-#include <asm/signal.h>
+#include <stddef.h>
+#include <signal.h>
 #include <linux/compiler.h>
 #include <asm/unistd.h>
-#include <asm/ucontext.h>
 #include "uml-config.h"
 #include "sysdep/sigcontext.h"
 #include "sysdep/faultinfo.h"
-#include <stddef.h>
+#include "sysdep/stub.h"
 
 /* Copied from sys-x86_64/signal.c - Can't find an equivalent definition
  * in the libc headers anywhere.
@@ -31,21 +31,21 @@
 stub_segv_handler(int sig)
 {
 	struct ucontext *uc;
+        int pid;
 
 	__asm__("movq %%rdx, %0" : "=g" (uc) :);
 	GET_FAULTINFO_FROM_SC(*((struct faultinfo *) UML_CONFIG_STUB_DATA),
 			      &uc->uc_mcontext);
 
-	__asm__("movq %0, %%rax ; syscall": : "g" (__NR_getpid));	
-	__asm__("movq %%rax, %%rdi ; movq %0, %%rax ; movq %1, %%rsi ;"
-		"syscall": : "g" (__NR_kill), "g" (SIGUSR1) : 
-		"%rdi", "%rax", "%rsi");
+	pid = stub_syscall0(__NR_getpid);
+	stub_syscall2(__NR_kill, pid, SIGUSR1);
+
 	/* sys_sigreturn expects that the stack pointer will be 8 bytes into
 	 * the signal frame.  So, we use the ucontext pointer, which we know
 	 * already, to get the signal frame pointer, and add 8 to that.
 	 */
-	__asm__("movq %0, %%rsp": : 
+	__asm__("movq %0, %%rsp; movq %1, %%rax ; syscall": : 
 		"g" ((unsigned long) container_of(uc, struct rt_sigframe, 
-						  uc) + 8));
-	__asm__("movq %0, %%rax ; syscall" : : "g" (__NR_rt_sigreturn));
+						  uc) + 8),
+                "g" (__NR_rt_sigreturn));
 }

