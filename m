Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751322AbWG1DG0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751322AbWG1DG0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 23:06:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751324AbWG1DG0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 23:06:26 -0400
Received: from saraswathi.solana.com ([198.99.130.12]:51178 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751322AbWG1DGZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 23:06:25 -0400
Message-Id: <200607280305.k6S35pYx007926@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net,
       hpa@zytor.com, Ulrich Drepper <drepper@gmail.com>
Subject: [PATCH 2/7] UML - Use klibc setjmp/longjmp
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 27 Jul 2006 23:05:51 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an implementation of setjmp and longjmp to UML,
allowing access to the inside of a jmpbuf without needing the access
macros formerly provided by libc.

The implementation is stolen from klibc.  I copy the relevant files
into arch/um.  I have another patch which avoids the copying, but
requires klibc be in the tree.

setjmp and longjmp users required some tweaking.  Includes of
<setjmp.h> were removed and includes of the UML longjmp.h were added
where necessary.  There are also replacements of siglongjmp with
UML_LONGJMP which I somehow missed earlier.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.18-rc2-mm1/arch/um/include/sysdep-i386/archsetjmp.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/arch/um/include/sysdep-i386/archsetjmp.h	2006-07-27 15:41:30.000000000 -0400
@@ -0,0 +1,19 @@
+/*
+ * arch/i386/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned int __ebx;
+	unsigned int __esp;
+	unsigned int __ebp;
+	unsigned int __esi;
+	unsigned int __edi;
+	unsigned int __eip;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
Index: linux-2.6.18-rc2-mm1/arch/um/include/sysdep-x86_64/archsetjmp.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/arch/um/include/sysdep-x86_64/archsetjmp.h	2006-07-27 15:41:30.000000000 -0400
@@ -0,0 +1,21 @@
+/*
+ * arch/x86_64/include/klibc/archsetjmp.h
+ */
+
+#ifndef _KLIBC_ARCHSETJMP_H
+#define _KLIBC_ARCHSETJMP_H
+
+struct __jmp_buf {
+	unsigned long __rbx;
+	unsigned long __rsp;
+	unsigned long __rbp;
+	unsigned long __r12;
+	unsigned long __r13;
+	unsigned long __r14;
+	unsigned long __r15;
+	unsigned long __rip;
+};
+
+typedef struct __jmp_buf jmp_buf[1];
+
+#endif				/* _SETJMP_H */
Index: linux-2.6.18-rc2-mm1/arch/um/sys-i386/Makefile
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/sys-i386/Makefile	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/sys-i386/Makefile	2006-07-27 15:41:30.000000000 -0400
@@ -1,5 +1,5 @@
 obj-y = bugs.o checksum.o delay.o fault.o ksyms.o ldt.o ptrace.o \
-	ptrace_user.o signal.o sigcontext.o syscalls.o sysrq.o \
+	ptrace_user.o setjmp.o signal.o sigcontext.o syscalls.o sysrq.o \
 	sys_call_table.o tls.o
 
 obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
Index: linux-2.6.18-rc2-mm1/arch/um/sys-i386/setjmp.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/arch/um/sys-i386/setjmp.S	2006-07-27 15:41:30.000000000 -0400
@@ -0,0 +1,58 @@
+#
+# arch/i386/setjmp.S
+#
+# setjmp/longjmp for the i386 architecture
+#
+
+#
+# The jmp_buf is assumed to contain the following, in order:
+#	%ebx
+#	%esp
+#	%ebp
+#	%esi
+#	%edi
+#	<return address>
+#
+
+	.text
+	.align 4
+	.globl setjmp
+	.type setjmp, @function
+setjmp:
+#ifdef _REGPARM
+	movl %eax,%edx
+#else
+	movl 4(%esp),%edx
+#endif
+	popl %ecx			# Return address, and adjust the stack
+	xorl %eax,%eax			# Return value
+	movl %ebx,(%edx)
+	movl %esp,4(%edx)		# Post-return %esp!
+	pushl %ecx			# Make the call/return stack happy
+	movl %ebp,8(%edx)
+	movl %esi,12(%edx)
+	movl %edi,16(%edx)
+	movl %ecx,20(%edx)		# Return address
+	ret
+
+	.size setjmp,.-setjmp
+
+	.text
+	.align 4
+	.globl longjmp
+	.type longjmp, @function
+longjmp:
+#ifdef _REGPARM
+	xchgl %eax,%edx
+#else
+	movl 4(%esp),%edx		# jmp_ptr address
+	movl 8(%esp),%eax		# Return value
+#endif
+	movl (%edx),%ebx
+	movl 4(%edx),%esp
+	movl 8(%edx),%ebp
+	movl 12(%edx),%esi
+	movl 16(%edx),%edi
+	jmp *20(%edx)
+
+	.size longjmp,.-longjmp
Index: linux-2.6.18-rc2-mm1/arch/um/sys-x86_64/Makefile
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/sys-x86_64/Makefile	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/sys-x86_64/Makefile	2006-07-27 15:41:30.000000000 -0400
@@ -5,8 +5,8 @@
 #
 
 obj-y = bugs.o delay.o fault.o ldt.o mem.o ptrace.o ptrace_user.o \
-	sigcontext.o signal.o syscalls.o syscall_table.o sysrq.o ksyms.o \
-	tls.o
+	setjmp.o sigcontext.o signal.o syscalls.o syscall_table.o sysrq.o \
+	ksyms.o tls.o
 
 obj-$(CONFIG_MODE_SKAS) += stub.o stub_segv.o
 obj-$(CONFIG_MODULES) += um_module.o
Index: linux-2.6.18-rc2-mm1/arch/um/sys-x86_64/setjmp.S
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.18-rc2-mm1/arch/um/sys-x86_64/setjmp.S	2006-07-27 15:41:30.000000000 -0400
@@ -0,0 +1,54 @@
+#
+# arch/x86_64/setjmp.S
+#
+# setjmp/longjmp for the x86-64 architecture
+#
+
+#
+# The jmp_buf is assumed to contain the following, in order:
+#	%rbx
+#	%rsp (post-return)
+#	%rbp
+#	%r12
+#	%r13
+#	%r14
+#	%r15
+#	<return address>
+#
+
+	.text
+	.align 4
+	.globl setjmp
+	.type setjmp, @function
+setjmp:
+	pop  %rsi			# Return address, and adjust the stack
+	xorl %eax,%eax			# Return value
+	movq %rbx,(%rdi)
+	movq %rsp,8(%rdi)		# Post-return %rsp!
+	push %rsi			# Make the call/return stack happy
+	movq %rbp,16(%rdi)
+	movq %r12,24(%rdi)
+	movq %r13,32(%rdi)
+	movq %r14,40(%rdi)
+	movq %r15,48(%rdi)
+	movq %rsi,56(%rdi)		# Return address
+	ret
+
+	.size setjmp,.-setjmp
+
+	.text
+	.align 4
+	.globl longjmp
+	.type longjmp, @function
+longjmp:
+	movl %esi,%eax			# Return value (int)
+	movq (%rdi),%rbx
+	movq 8(%rdi),%rsp
+	movq 16(%rdi),%rbp
+	movq 24(%rdi),%r12
+	movq 32(%rdi),%r13
+	movq 40(%rdi),%r14
+	movq 48(%rdi),%r15
+	jmp *56(%rdi)
+
+	.size longjmp,.-longjmp
Index: linux-2.6.18-rc2-mm1/arch/um/include/longjmp.h
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/include/longjmp.h	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/include/longjmp.h	2006-07-27 15:48:54.000000000 -0400
@@ -1,9 +1,12 @@
 #ifndef __UML_LONGJMP_H
 #define __UML_LONGJMP_H
 
-#include <setjmp.h>
+#include "sysdep/archsetjmp.h"
 #include "os.h"
 
+extern int setjmp(jmp_buf);
+extern void longjmp(jmp_buf, int);
+
 #define UML_LONGJMP(buf, val) do { \
 	longjmp(*buf, val);	\
 } while(0)
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/process.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/process.c	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/process.c	2006-07-27 15:41:30.000000000 -0400
@@ -7,7 +7,6 @@
 #include <stdio.h>
 #include <errno.h>
 #include <signal.h>
-#include <setjmp.h>
 #include <linux/unistd.h>
 #include <sys/mman.h>
 #include <sys/wait.h>
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/skas/process.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/skas/process.c	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/skas/process.c	2006-07-27 15:49:53.000000000 -0400
@@ -8,7 +8,6 @@
 #include <unistd.h>
 #include <errno.h>
 #include <signal.h>
-#include <setjmp.h>
 #include <sched.h>
 #include "ptrace_user.h"
 #include <sys/wait.h>
@@ -470,7 +469,7 @@ void thread_wait(void *sw, void *fb)
 	*switch_buf = &buf;
 	fork_buf = fb;
 	if(UML_SETJMP(&buf) == 0)
-		siglongjmp(*fork_buf, INIT_JMP_REMOVE_SIGSTACK);
+		UML_LONGJMP(fork_buf, INIT_JMP_REMOVE_SIGSTACK);
 }
 
 void switch_threads(void *me, void *next)
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/sys-i386/registers.c	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-i386/registers.c	2006-07-27 15:41:30.000000000 -0400
@@ -5,12 +5,12 @@
 
 #include <errno.h>
 #include <string.h>
-#include <setjmp.h>
 #include "sysdep/ptrace_user.h"
 #include "sysdep/ptrace.h"
 #include "uml-config.h"
 #include "skas_ptregs.h"
 #include "registers.h"
+#include "longjmp.h"
 #include "user.h"
 
 /* These are set once at boot time and not changed thereafter */
@@ -132,9 +132,9 @@ void get_safe_registers(unsigned long *r
 
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
-	struct __jmp_buf_tag *jmpbuf = buffer;
+	struct __jmp_buf *jmpbuf = buffer;
 
-	UPT_SET(uml_regs, EIP, jmpbuf->__jmpbuf[JB_PC]);
-	UPT_SET(uml_regs, UESP, jmpbuf->__jmpbuf[JB_SP]);
-	UPT_SET(uml_regs, EBP, jmpbuf->__jmpbuf[JB_BP]);
+	UPT_SET(uml_regs, EIP, jmpbuf->__eip);
+	UPT_SET(uml_regs, UESP, jmpbuf->__esp);
+	UPT_SET(uml_regs, EBP, jmpbuf->__ebp);
 }
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/sys-x86_64/registers.c	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/sys-x86_64/registers.c	2006-07-27 15:41:30.000000000 -0400
@@ -5,11 +5,11 @@
 
 #include <errno.h>
 #include <string.h>
-#include <setjmp.h>
 #include "ptrace_user.h"
 #include "uml-config.h"
 #include "skas_ptregs.h"
 #include "registers.h"
+#include "longjmp.h"
 #include "user.h"
 
 /* These are set once at boot time and not changed thereafter */
@@ -80,9 +80,9 @@ void get_safe_registers(unsigned long *r
 
 void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
 {
-	struct __jmp_buf_tag *jmpbuf = buffer;
+	struct __jmp_buf *jmpbuf = buffer;
 
-	UPT_SET(uml_regs, RIP, jmpbuf->__jmpbuf[JB_PC]);
-	UPT_SET(uml_regs, RSP, jmpbuf->__jmpbuf[JB_RSP]);
-	UPT_SET(uml_regs, RBP, jmpbuf->__jmpbuf[JB_RBP]);
+	UPT_SET(uml_regs, RIP, jmpbuf->__rip);
+	UPT_SET(uml_regs, RSP, jmpbuf->__rsp);
+	UPT_SET(uml_regs, RBP, jmpbuf->__rbp);
 }
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/trap.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/trap.c	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/trap.c	2006-07-27 15:41:30.000000000 -0400
@@ -5,7 +5,6 @@
 
 #include <stdlib.h>
 #include <signal.h>
-#include <setjmp.h>
 #include "kern_util.h"
 #include "user_util.h"
 #include "os.h"
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/uaccess.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/uaccess.c	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/uaccess.c	2006-07-27 15:41:30.000000000 -0400
@@ -4,8 +4,7 @@
  * Licensed under the GPL
  */
 
-#include <setjmp.h>
-#include <string.h>
+#include <stddef.h>
 #include "longjmp.h"
 
 unsigned long __do_user_copy(void *to, const void *from, int n,
Index: linux-2.6.18-rc2-mm1/arch/um/os-Linux/util.c
===================================================================
--- linux-2.6.18-rc2-mm1.orig/arch/um/os-Linux/util.c	2006-07-27 15:41:28.000000000 -0400
+++ linux-2.6.18-rc2-mm1/arch/um/os-Linux/util.c	2006-07-27 15:42:24.000000000 -0400
@@ -7,7 +7,6 @@
 #include <stdlib.h>
 #include <unistd.h>
 #include <limits.h>
-#include <setjmp.h>
 #include <sys/mman.h>
 #include <sys/stat.h>
 #include <sys/utsname.h>
@@ -107,11 +106,11 @@ int setjmp_wrapper(void (*proc)(void *, 
 	jmp_buf buf;
 	int n;
 
-	n = sigsetjmp(buf, 1);
+	n = UML_SETJMP(&buf);
 	if(n == 0){
 		va_start(args, proc);
 		(*proc)(&buf, &args);
 	}
 	va_end(args);
-	return(n);
+	return n;
 }

