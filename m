Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932099AbWCMSFt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932099AbWCMSFt (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Mar 2006 13:05:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932220AbWCMSFt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Mar 2006 13:05:49 -0500
Received: from mailout1.vmware.com ([65.113.40.130]:21516 "EHLO
	mailout1.vmware.com") by vger.kernel.org with ESMTP id S932099AbWCMSFP
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Mar 2006 13:05:15 -0500
Date: Mon, 13 Mar 2006 10:05:11 -0800
Message-Id: <200603131805.k2DI5BVv005686@zach-dev.vmware.com>
Subject: [RFC, PATCH 8/24] i386 Vmi syscall assembly
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
X-OriginalArrivalTime: 13 Mar 2006 18:05:11.0336 (UTC) FILETIME=[AB9EEA80:01C646C8]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Illustration of how VMI inlines are used to greatly limit the impact of code
change in low level assembler code.  Spinlocks, system calls, and the fault
handling paths are affected by adding some padding bytes to convert the native
instructions into a hook point for the hypervisor to insert shim code.

These changes are sufficient to glue the Linux low level entry points to
hypervisor event injection by emulating the native processor exception
frame interface.

N.B. Sti; Sysexit is a required abstraction, as the STI instruction implies
holdoff of interrupts, which is destroyed by any NOP padding.

There is a race condition is present in all virtualization solutions in which
the guest kernel may issue a raw IRET instruction, as the IRET instruction is
not properly virtualizable on non-hardware assisted Intel platforms.  This is
because the interrupt flag, which indicates whether an IRQ may be delivered, is
not changed by the instruction when running without I/O privilege level  Thus,
there is no way to atomically change both the interrupt flag and the kernel
stack pointer.  Properly dealing with this race condition is much easier if the
window in which the race exists is confined to a well defined region, such as a
single region of code published at a fixed address by the hypervisor.  Having a
hook point for IRET makes this possible without imposing an obtuse requirement
and alternative event injection path into the native kernel.

Currently, there is no hypervisor support for the IRET instructions which land
on a 16-bit stack.  There are many possible solutions to this problem, and the
choice is not critical to the operation of most normal userspace code, so
fixing this problem has been deferred.

Signed-off-by: Zachary Amsden <zach@vmware.com>

Index: linux-2.6.16-rc5/arch/i386/kernel/entry.S
===================================================================
--- linux-2.6.16-rc5.orig/arch/i386/kernel/entry.S	2006-03-08 11:38:51.000000000 -0800
+++ linux-2.6.16-rc5/arch/i386/kernel/entry.S	2006-03-08 11:40:12.000000000 -0800
@@ -48,6 +48,7 @@
 #include <asm/smp.h>
 #include <asm/page.h>
 #include <asm/desc.h>
+#include <mach_asm.h>
 #include "irq_vectors.h"
 
 #define nr_syscalls ((syscall_table_size)/4)
@@ -76,7 +77,7 @@ NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli
+#define preempt_stop		CLI
 #else
 #define preempt_stop
 #define resume_kernel		restore_nocheck
@@ -148,7 +149,7 @@ ret_from_intr:
 	testl $(VM_MASK | 3), %eax
 	jz resume_kernel
 ENTRY(resume_userspace)
- 	cli				# make sure we don't miss an interrupt
+ 	CLI				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -159,7 +160,7 @@ ENTRY(resume_userspace)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cli
+	CLI
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_nocheck
 need_resched:
@@ -179,7 +180,7 @@ need_resched:
 ENTRY(sysenter_entry)
 	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
-	sti
+	STI
 	pushl $(__USER_DS)
 	pushl %ebp
 	pushfl
@@ -209,7 +210,7 @@ sysenter_past_esp:
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
-	cli
+	CLI
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
@@ -217,8 +218,7 @@ sysenter_past_esp:
 	movl EIP(%esp), %edx
 	movl OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
-	sti
-	sysexit
+	STI_SYSEXIT
 
 
 	# system call handler stub
@@ -236,7 +236,7 @@ syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
-	cli				# make sure we don't miss an interrupt
+	CLI				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -256,14 +256,14 @@ restore_all:
 restore_nocheck:
 	RESTORE_REGS
 	addl $4, %esp
-1:	iret
-.section .fixup,"ax"
+1:	IRET
+.pushsection .fixup,"ax"
 iret_exc:
-	sti
+	STI
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
-.previous
+.popsection
 .section __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
@@ -281,14 +281,14 @@ ldt_ss:
 	 * CPUs, which we can try to work around to make
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
-	cli
+	CLI
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
 	 * and a switch16 pointer on top of the current frame. */
 	call setup_x86_bogus_stack
 	RESTORE_REGS
 	lss 20+4(%esp), %esp	# switch to 16bit stack
-1:	iret
+1:	IRET
 .section __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
@@ -301,7 +301,7 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
-	cli				# make sure we don't miss an interrupt
+	CLI				# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -353,7 +353,7 @@ syscall_trace_entry:
 syscall_exit_work:
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
-	sti				# could let do_syscall_trace() call
+	STI				# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -475,7 +475,7 @@ ENTRY(simd_coprocessor_error)
 ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
-	movl %cr0, %eax
+	GET_CR0
 	testl $0x4, %eax		# EM (math emulation bit)
 	jne device_not_available_emulate
 	preempt_stop
@@ -586,7 +586,7 @@ nmi_16bit_stack:
 	call do_nmi
 	RESTORE_REGS
 	lss 12+4(%esp), %esp		# back to 16bit stack
-1:	iret
+1:	IRET
 .section __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
Index: linux-2.6.16-rc5/include/asm-i386/spinlock.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/spinlock.h	2006-03-08 11:38:51.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/spinlock.h	2006-03-08 11:40:12.000000000 -0800
@@ -6,6 +6,7 @@
 #include <asm/page.h>
 #include <linux/config.h>
 #include <linux/compiler.h>
+#include <mach_asm.h>
 
 /*
  * Your basic SMP spinlocks, allowing only a single CPU anywhere
@@ -39,12 +40,12 @@
 	"2:\t" \
 	"testl $0x200, %1\n\t" \
 	"jz 3f\n\t" \
-	"sti\n\t" \
+	STI_STRING "\n\t"\
 	"3:\t" \
 	"rep;nop\n\t" \
 	"cmpb $0, %0\n\t" \
 	"jle 3b\n\t" \
-	"cli\n\t" \
+	CLI_STRING "\n\t"\
 	"jmp 1b\n" \
 	"4:\n\t"
 
Index: linux-2.6.16-rc5/include/asm-i386/mach-default/mach_asm.h
===================================================================
--- linux-2.6.16-rc5.orig/include/asm-i386/mach-default/mach_asm.h	2006-03-08 11:40:12.000000000 -0800
+++ linux-2.6.16-rc5/include/asm-i386/mach-default/mach_asm.h	2006-03-08 11:40:12.000000000 -0800
@@ -0,0 +1,16 @@
+#ifndef __MACH_ASM_H
+#define __MACH_ASM_H
+
+#define IRET		iret 
+#define CLI		cli
+#define STI		sti
+#define STI_SYSEXIT	sti; sysexit
+#define GET_CR0		mov %cr0, %eax
+#define WRMSR		wrmsr
+#define RDMSR		rdmsr
+#define CPUID		cpuid
+
+#define CLI_STRING	"cli"
+#define STI_STRING	"sti"
+
+#endif /* __MACH_ASM_H */
