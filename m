Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932262AbWCMSHp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932262AbWCMSHp (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:07:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932256AbWCMSHp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:07:45 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:41484 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932249AbWCMSHe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:07:34 -0500
Date: Mon, 13 Mar 2006 10:07:32 -0800
Message-Id: <200603131807.k2DI7WMn005707@zach-dev.vmware.com>
Subject: [RFC, PATCH 11/24] i386 Vmi segment changes
From: Zachary Amsden <zach@vmware.com>
To: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Virtualization Mailing List <virtualization@lists.osdl.org>,
       Xen-devel <xen-devel@lists.xensource.com>,
       Andrew Morton <akpm@osdl.org>, Zachary Amsden <zach@vmware.com>,
       Dan Hecht <dhecht@vmware.com>, Dan Arai <arai@vmware.com>,
       Anne Holler <anne@vmware.com>, Pratap Subrahmanyam <pratap@vmware.com>,
       Christopher Li <chrisl@vmware.com>, Joshua LeVasseur <jtl@ira.uka.de>,
       Chris Wright <chrisw@osdl.org>, Rik Van Riel <riel@redhat.com>,
       Jyothy Reddy <jreddy@vmware.com>, Jack Lo <jlo@vmware.com>,
       Kip Macy <kmacy@fsmware.com>, Jan Beulich <jbeulich@novell.com>,
       Ky Srinivasan <ksrinivasan@novell.com>,
       Wim Coekaerts <wim.coekaerts@oracle.com>,
       Leendert van Doorn <leendert@watson.ibm.com>,
       Zachary Amsden <zach@vmware.com>
X-OriginalArrivalTime: 13 Mar 2006 18:07:33.0003 (UTC) FILETIME=[000F95B0:01C646C9]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Make the Linux kernel able to run at CPL 0, 1, or 2.  There are a few
limited places where CPL-0 is assumed, and they can be converted very
efficiently into a supervisor CPL check instead of a CPL-0 check.
This step prepares the kernel for running in direct execution under
a hypervisor.

Note the user_mode_vm macro used in ptrace.h is very similar to the
flag mixing of EFLAGS and CS used to test in one branch in entry.S.

To make the COMPARE_SEGMENT_REG macro work, it must contain both the
push and the pop, requiring an additional load of EAX after the
possible stack fixup.  This is because FIXUP_ESPFIX_STACK destroys
%EAX again with a call to C code.

In all, the overhead is couple of instructions, and no extra branches.
Note that I prefer to use the testing of selectors in the form:

  SELECTOR_CLEAR_RPL(sel) == __KERNEL_SEL

Instead of SELECTOR == (%seg), where %seg is the live register value.
This is because moves from segment registers are more costly than a
single ALU instruction, and both cost a temporary register.  Still,
pushing the raw %cs value in the NMI after sysenter debug trap fixup
code instead of __KERNEL_CS | RPL is just as efficient, since fetching
RPL would require a %cs load anyway.

The switch from __KERNEL_DS to __USER_DS at one point is for
convenience, since they are both equivalent for %ds and %es segments;
__KERNEL_DS, contrary to the name, is only useful for the %ss segment.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/include/asm-i386/ptrace.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/ptrace.h	2006-03-08 16:58:49.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/ptrace.h	2006-03-08 17:10:26.000000000 -0800
@@ -60,6 +60,7 @@ struct pt_regs {
 #ifdef __KERNEL__
 
 #include <asm/vm86.h>
+#include <asm/segment.h>
 
 struct task_struct;
 extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
@@ -73,11 +74,11 @@ extern void send_sigtrap(struct task_str
  */
 static inline int user_mode(struct pt_regs *regs)
 {
-	return (regs->xcs & 3) != 0;
+	return (regs->xcs & SEGMENT_RPL_MASK) == 3;
 }
 static inline int user_mode_vm(struct pt_regs *regs)
 {
-	return ((regs->xcs & 3) | (regs->eflags & VM_MASK)) != 0;
+	return (((regs->xcs & SEGMENT_RPL_MASK) | (regs->eflags & VM_MASK)) >= 3);
 }
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
Index: linux-2.6.16-rc5/include/asm-i386/segment.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/segment.h	2006-03-08 16:58:49.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/segment.h	2006-03-08 17:10:26.000000000 -0800
@@ -112,4 +112,9 @@
  */
 #define IDT_ENTRIES 256
 
+#define SEGMENT_RPL_MASK	0x03
+#define SEGMENT_TI_MASK		0x04
+
+#include <mach_segment.h>
+
 #endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_segment.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-vmi/mach_segment.h	2006-03-08 17:10:26.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-vmi/mach_segment.h	2006-03-08 17:10:26.000000000 -0800
@@ -0,0 +1,56 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+
+#ifndef __MACH_SEGMENT_H
+#define __MACH_SEGMENT_H
+
+#if !defined(CONFIG_X86_VMI)
+# error invalid sub-arch include
+#endif
+
+#ifndef __ASSEMBLY__
+static inline unsigned get_kernel_rpl(void)
+{
+	unsigned cs;
+	__asm__ ("movl %%cs,%0" : "=r"(cs):);
+	return cs & SEGMENT_RPL_MASK;
+}
+#endif
+
+#define COMPARE_SEGMENT_STACK(segment, offset)	\
+	pushl %eax;				\
+	mov   offset+4(%esp), %eax;		\
+	andl  $~SEGMENT_RPL_MASK, %eax;		\
+	cmpw  $segment,%ax;			\
+	popl  %eax;
+
+#define COMPARE_SEGMENT_REG(segment, reg)	\
+	pushl %eax;				\
+	mov   reg, %eax;			\
+	andl  $~SEGMENT_RPL_MASK, %eax;		\
+	cmpw  $segment,%ax;			\
+	popl  %eax;
+
+#endif
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_segment.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_segment.h	2006-03-08 17:10:26.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_segment.h	2006-03-09 15:51:42.000000000 -0800
@@ -0,0 +1,39 @@
+/*
+ * Copyright (C) 2005, VMware, Inc.
+ *
+ * All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but
+ * WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY OR FITNESS FOR A PARTICULAR PURPOSE, GOOD TITLE or
+ * NON INFRINGEMENT.  See the GNU General Public License for more
+ * details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ *
+ * Send feedback to zach@vmware.com
+ *
+ */
+
+
+#ifndef __MACH_SEGMENT_H
+#define __MACH_SEGMENT_H
+
+#define get_kernel_rpl()  0
+
+#define COMPARE_SEGMENT_STACK(segment, offset)	\
+	cmpw $segment, offset(%esp);
+
+#define COMPARE_SEGMENT_REG(segment, reg)	\
+	pushl %eax;				\
+	mov   reg, %eax;			\
+	cmpw  $segment,%ax;			\
+	popl  %eax;
+#endif
Index: linux-2.6.16-rc5/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/entry.S	2006-03-08 17:10:25.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/entry.S	2006-03-08 17:10:26.000000000 -0800
@@ -145,9 +145,11 @@ ret_from_exception:
 ret_from_intr:
 	GET_THREAD_INFO(%ebp)
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
+	andl $VM_MASK, %eax
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
-	jz resume_kernel
+	andb $SEGMENT_RPL_MASK, %al
+	cmpl $SEGMENT_RPL_MASK, %eax
+	jb resume_kernel		# returning to kernel or vm86-space
 ENTRY(resume_userspace)
  	CLI				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -382,17 +384,14 @@ syscall_badsys:
 	/* put ESP to the proper location */ \
 	movl %eax, %esp;
 #define UNWIND_ESPFIX_STACK \
-	pushl %eax; \
-	movl %ss, %eax; \
-	/* see if on 16bit stack */ \
-	cmpw $__ESPFIX_SS, %ax; \
+	COMPARE_SEGMENT_REG(__ESPFIX_SS, %ss) \
 	jne 28f; \
-	movl $__KERNEL_DS, %edx; \
+	movl $__USER_DS, %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es; \
 	/* switch to 32bit stack */ \
 	FIXUP_ESPFIX_STACK \
-28:	popl %eax;
+28:;
 
 /*
  * Build the entry stubs and pointer table with
@@ -451,6 +450,7 @@ error_code:
 	pushl %es
 	UNWIND_ESPFIX_STACK
 	popl %ecx
+	movl EAX(%esp), %eax
 	movl ES(%esp), %edi		# get the function address
 	movl ORIG_EAX(%esp), %edx	# get the error code
 	movl %eax, ORIG_EAX(%esp)
@@ -501,12 +501,12 @@ device_not_available_emulate:
  * the instruction that would have done it for sysenter.
  */
 #define FIX_STACK(offset, ok, label)		\
-	cmpw $__KERNEL_CS,4(%esp);		\
+	COMPARE_SEGMENT_STACK(__KERNEL_CS, 4)	\
 	jne ok;					\
 label:						\
 	movl TSS_sysenter_esp0+offset(%esp),%esp;	\
 	pushfl;					\
-	pushl $__KERNEL_CS;			\
+	push  %cs;				\
 	pushl $sysenter_past_esp
 
 KPROBE_ENTRY(debug)
@@ -530,10 +530,7 @@ debug_stack_correct:
  * fault happened on the sysenter path.
  */
 ENTRY(nmi)
-	pushl %eax
-	movl %ss, %eax
-	cmpw $__ESPFIX_SS, %ax
-	popl %eax
+	COMPARE_SEGMENT_REG(__ESPFIX_SS, %ss)
 	je nmi_16bit_stack
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
@@ -560,7 +557,7 @@ nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
 	jmp nmi_stack_correct
 nmi_debug_stack_check:
-	cmpw $__KERNEL_CS,16(%esp)
+	COMPARE_SEGMENT_STACK(__KERNEL_CS, 16)
 	jne nmi_stack_correct
 	cmpl $debug,(%esp)
 	jb nmi_stack_correct
Index: linux-2.6.16-rc5/arch/i386/kernel/process.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/process.c	2006-03-08 16:58:49.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/process.c	2006-03-09 15:52:17.000000000 -0800
@@ -348,7 +348,7 @@ int kernel_thread(int (*fn)(void *), voi
 	regs.xes = __USER_DS;
 	regs.orig_eax = -1;
 	regs.eip = (unsigned long) kernel_thread_helper;
-	regs.xcs = __KERNEL_CS;
+	regs.xcs = __KERNEL_CS | get_kernel_rpl();
 	regs.eflags = X86_EFLAGS_IF | X86_EFLAGS_SF | X86_EFLAGS_PF | 0x2;
 
 	/* Ok, create the new process.. */
Index: linux-2.6.16-rc5/arch/i386/kernel/traps.c
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/traps.c	2006-03-08 17:10:25.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/traps.c	2006-03-08 17:10:26.000000000 -0800
@@ -970,10 +970,10 @@ fastcall void setup_x86_bogus_stack(unsi
 	memcpy((void *)(stack_bot + iret_frame16_off), &regs->eip, 20);
 	/* fill in the switch pointers */
 	switch16_ptr[0] = (regs->esp & 0xffff0000) | iret_frame16_off;
-	switch16_ptr[1] = __ESPFIX_SS;
+	switch16_ptr[1] = __ESPFIX_SS | get_kernel_rpl();
 	switch32_ptr[0] = (unsigned long)stk + sizeof(struct pt_regs) +
 		8 - CPU_16BIT_STACK_SIZE;
-	switch32_ptr[1] = __KERNEL_DS;
+	switch32_ptr[1] = __KERNEL_DS | get_kernel_rpl();
 }
 
 fastcall unsigned char * fixup_x86_bogus_stack(unsigned short sp)
