Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751182AbWHJBzb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751182AbWHJBzb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Aug 2006 21:55:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751440AbWHJBza
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Aug 2006 21:55:30 -0400
Received: from [198.99.130.12] ([198.99.130.12]:43996 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S1751182AbWHJBza (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Aug 2006 21:55:30 -0400
Message-Id: <200608091815.k79IFW3W005315@ccure.user-mode-linux.org>
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.0.4
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org, user-mode-linux-devel@lists.sourceforge.net
Subject: [PATCH] UML - Stack usage reduction
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Wed, 09 Aug 2006 14:15:30 -0400
From: Jeff Dike <jdike@addtoit.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The KSTK_* macros used an inordinate amount of stack.  In order to
overcome an impedance mismatch between their interface, which just
returns a single register value, and the interface of get_thread_regs,
which took a full pt_regs, the implementation created an on-stack
pt_regs, filled it in, and returned one field.  do_task_stat calls
KSTK_* twice, resulting in two local pt_regs, blowing out the stack.

This patch changes the interface (and name) of get_thread_regs to just
return a single register from a jmp_buf.

The include of archsetjmp.h" in registers.h to get the definition of
jmp_buf exposed a bogus include of <setjmp.h> in start_up.c.
<setjmp.h> shouldn't be used anywhere any more since UML uses the
klibc setjmp/longjmp.

Signed-off-by: Jeff Dike <jdike@addtoit.com>

Index: linux-2.6.17/arch/um/include/registers.h
===================================================================
--- linux-2.6.17.orig/arch/um/include/registers.h	2006-06-17 21:49:35.000000000 -0400
+++ linux-2.6.17/arch/um/include/registers.h	2006-08-09 13:42:06.000000000 -0400
@@ -7,6 +7,7 @@
 #define __REGISTERS_H
 
 #include "sysdep/ptrace.h"
+#include "sysdep/archsetjmp.h"
 
 extern void init_thread_registers(union uml_pt_regs *to);
 extern int save_fp_registers(int pid, unsigned long *fp_regs);
@@ -15,6 +16,6 @@ extern void save_registers(int pid, unio
 extern void restore_registers(int pid, union uml_pt_regs *regs);
 extern void init_registers(int pid);
 extern void get_safe_registers(unsigned long * regs, unsigned long * fp_regs);
-extern void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer);
+extern unsigned long get_thread_reg(int reg, jmp_buf *buf);
 
 #endif
Index: linux-2.6.17/arch/um/os-Linux/sys-i386/registers.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sys-i386/registers.c	2006-08-09 13:36:17.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sys-i386/registers.c	2006-08-09 13:42:06.000000000 -0400
@@ -130,11 +130,14 @@ void get_safe_registers(unsigned long *r
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
-void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+unsigned long get_thread_reg(int reg, jmp_buf *buf)
 {
-	struct __jmp_buf *jmpbuf = buffer;
-
-	UPT_SET(uml_regs, EIP, jmpbuf->__eip);
-	UPT_SET(uml_regs, UESP, jmpbuf->__esp);
-	UPT_SET(uml_regs, EBP, jmpbuf->__ebp);
+	switch(reg){
+	case EIP: return buf[0]->__eip;
+	case UESP: return buf[0]->__esp;
+	case EBP: return buf[0]->__ebp;
+	default:
+		printk("get_thread_regs - unknown register %d\n", reg);
+		return 0;
+	}
 }
Index: linux-2.6.17/arch/um/os-Linux/sys-x86_64/registers.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/sys-x86_64/registers.c	2006-08-09 13:36:17.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/sys-x86_64/registers.c	2006-08-09 13:42:06.000000000 -0400
@@ -78,11 +78,14 @@ void get_safe_registers(unsigned long *r
 		       HOST_FP_SIZE * sizeof(unsigned long));
 }
 
-void get_thread_regs(union uml_pt_regs *uml_regs, void *buffer)
+unsigned long get_thread_reg(int reg, jmp_buf *buf)
 {
-	struct __jmp_buf *jmpbuf = buffer;
-
-	UPT_SET(uml_regs, RIP, jmpbuf->__rip);
-	UPT_SET(uml_regs, RSP, jmpbuf->__rsp);
-	UPT_SET(uml_regs, RBP, jmpbuf->__rbp);
+	switch(reg){
+	case RIP: return buf[0]->__rip;
+	case RSP: return buf[0]->__rsp;
+	case RBP: return buf[0]->__rbp;
+	default:
+		printk("get_thread_regs - unknown register %d\n", reg);
+		return 0;
+	}
 }
Index: linux-2.6.17/include/asm-um/processor-generic.h
===================================================================
--- linux-2.6.17.orig/include/asm-um/processor-generic.h	2006-08-09 13:35:31.000000000 -0400
+++ linux-2.6.17/include/asm-um/processor-generic.h	2006-08-09 13:42:06.000000000 -0400
@@ -138,9 +138,7 @@ extern struct cpuinfo_um cpu_data[];
 
 #ifdef CONFIG_MODE_SKAS
 #define KSTK_REG(tsk, reg) \
-	({ union uml_pt_regs regs; \
-	   get_thread_regs(&regs, tsk->thread.mode.skas.switch_buf); \
-	   UPT_REG(&regs, reg); })
+	get_thread_reg(reg, tsk->thread.mode.skas.switch_buf)
 #else
 #define KSTK_REG(tsk, reg) (0xbadbabe)
 #endif
Index: linux-2.6.17/arch/um/os-Linux/start_up.c
===================================================================
--- linux-2.6.17.orig/arch/um/os-Linux/start_up.c	2006-08-09 13:56:44.000000000 -0400
+++ linux-2.6.17/arch/um/os-Linux/start_up.c	2006-08-09 13:56:54.000000000 -0400
@@ -14,7 +14,6 @@
 #include <sched.h>
 #include <fcntl.h>
 #include <errno.h>
-#include <setjmp.h>
 #include <sys/time.h>
 #include <sys/wait.h>
 #include <sys/mman.h>

