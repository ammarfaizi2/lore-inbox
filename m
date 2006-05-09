Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751600AbWEIIxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751600AbWEIIxb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:53:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751607AbWEIIxB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:53:01 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:15744 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751604AbWEIItZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:25 -0400
Message-Id: <20060509085152.524462000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:11 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 11/35] Add support for Xen to entry.S.
Content-Disposition: inline; filename=i386-entry.S
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- change cli/sti
- change test for user mode return to work for kernel mode in ring1
- check hypervisor saved event mask on return from exception
- add entry points for the hypervisor upcall handlers
- avoid math emulation check when running on Xen
- add nmi handler for running on Xen

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 arch/i386/kernel/entry.S |  137 +++++++++++++++++++++++++++++++++++++++++------
 1 file changed, 120 insertions(+), 17 deletions(-)

--- linus-2.6.orig/arch/i386/kernel/entry.S
+++ linus-2.6/arch/i386/kernel/entry.S
@@ -75,8 +75,38 @@ DF_MASK		= 0x00000400 
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
+#ifndef CONFIG_XEN
+#define DISABLE_INTERRUPTS	cli
+#define ENABLE_INTERRUPTS	sti
+#else
+#include <xen/interface/xen.h>
+
+EVENT_MASK	= 0x2E
+
+/* Offsets into shared_info_t. */
+#define evtchn_upcall_pending		/* 0 */
+#define evtchn_upcall_mask		1
+
+#define sizeof_vcpu_shift		6
+
+#ifdef CONFIG_SMP
+#define GET_VCPU_INFO		movl TI_cpu(%ebp),%esi			; \
+				shl  $sizeof_vcpu_shift,%esi		; \
+				addl HYPERVISOR_shared_info,%esi
+#else
+#define GET_VCPU_INFO		movl HYPERVISOR_shared_info,%esi
+#endif
+
+#define __DISABLE_INTERRUPTS	movb $1,evtchn_upcall_mask(%esi)
+#define DISABLE_INTERRUPTS	GET_VCPU_INFO				; \
+				__DISABLE_INTERRUPTS
+#define ENABLE_INTERRUPTS	GET_VCPU_INFO				; \
+				movb $0,evtchn_upcall_mask(%esi)
+#define __TEST_PENDING		testb $0xFF,evtchn_upcall_pending(%esi)
+#endif
+
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli
+#define preempt_stop		DISABLE_INTERRUPTS
 #else
 #define preempt_stop
 #define resume_kernel		restore_nocheck
@@ -145,10 +175,10 @@ ret_from_intr:
 	GET_THREAD_INFO(%ebp)
 	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
 	movb CS(%esp), %al
-	testl $(VM_MASK | 3), %eax
+	testl $(VM_MASK | USER_MODE_MASK), %eax
 	jz resume_kernel
 ENTRY(resume_userspace)
- 	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -159,7 +189,7 @@ ENTRY(resume_userspace)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cli
+	DISABLE_INTERRUPTS
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_nocheck
 need_resched:
@@ -179,7 +209,7 @@ need_resched:
 ENTRY(sysenter_entry)
 	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
-	sti
+	ENABLE_INTERRUPTS
 	pushl $(__USER_DS)
 	pushl %ebp
 	pushfl
@@ -209,7 +239,7 @@ sysenter_past_esp:
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
-	cli
+	DISABLE_INTERRUPTS
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
@@ -217,7 +247,7 @@ sysenter_past_esp:
 	movl EIP(%esp), %edx
 	movl OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
-	sti
+	ENABLE_INTERRUPTS
 	sysexit
 
 
@@ -240,7 +270,7 @@ syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -248,6 +278,7 @@ syscall_exit:
 	jne syscall_exit_work
 
 restore_all:
+#ifndef CONFIG_XEN
 	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
 	# Warning: OLDSS(%esp) contains the wrong/random values if we
 	# are returning to the kernel.
@@ -258,12 +289,32 @@ restore_all:
 	cmpl $((4 << 8) | 3), %eax
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
+#else
+restore_nocheck:
+	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
+	movb CS(%esp), %al
+	andl $(VM_MASK | 3), %eax
+	cmpl $3, %eax
+	jne hypervisor_iret
+	ENABLE_INTERRUPTS
+	__TEST_PENDING
+	jz restore_regs_and_iret
+	__DISABLE_INTERRUPTS
+	jmp do_hypervisor_callback
+hypervisor_iret:
+	RESTORE_REGS
+	addl $4, %esp
+	jmp  hypercall_page + (__HYPERVISOR_iret * 32)
+#endif
+restore_regs_and_iret:
 	RESTORE_REGS
 	addl $4, %esp
 1:	iret
 .section .fixup,"ax"
 iret_exc:
-	sti
+#ifndef CONFIG_XEN
+	ENABLE_INTERRUPTS
+#endif
 	pushl $0			# no error code
 	pushl $do_iret_error
 	jmp error_code
@@ -273,6 +324,7 @@ iret_exc:
 	.long 1b,iret_exc
 .previous
 
+#ifndef CONFIG_XEN
 ldt_ss:
 	larl OLDSS(%esp), %eax
 	jnz restore_nocheck
@@ -285,7 +337,7 @@ ldt_ss:
 	 * CPUs, which we can try to work around to make
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
-	cli
+	DISABLE_INTERRUPTS
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
 	 * and a switch16 pointer on top of the current frame. */
@@ -297,6 +349,7 @@ ldt_ss:
 	.align 4
 	.long 1b,iret_exc
 .previous
+#endif
 
 	# perform work that needs to be done immediately before resumption
 	ALIGN
@@ -305,7 +358,7 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -357,7 +410,7 @@ syscall_trace_entry:
 syscall_exit_work:
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
-	sti				# could let do_syscall_trace() call
+	ENABLE_INTERRUPTS		# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -377,6 +430,7 @@ syscall_badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
 
+#ifndef CONFIG_XEN
 #define FIXUP_ESPFIX_STACK \
 	movl %esp, %eax; \
 	/* switch to 32bit stack using the pointer on top of 16bit stack */ \
@@ -435,6 +489,9 @@ ENTRY(name)				\
 
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
+#else
+#define UNWIND_ESPFIX_STACK
+#endif
 
 ENTRY(divide_error)
 	pushl $0			# no error code
@@ -466,6 +523,44 @@ error_code:
 	call *%edi
 	jmp ret_from_exception
 
+#ifdef CONFIG_XEN
+ENTRY(hypervisor_callback)
+	pushl %eax
+	SAVE_ALL
+do_hypervisor_callback:
+	push %esp
+	call evtchn_do_upcall
+	add  $4,%esp
+	jmp  ret_from_intr
+
+# Hypervisor uses this for application faults while it executes.
+ENTRY(failsafe_callback)
+1:	popl %ds
+2:	popl %es
+3:	popl %fs
+4:	popl %gs
+	subl $4,%esp
+	SAVE_ALL
+	jmp  ret_from_exception
+.section .fixup,"ax";	\
+6:	movl $0,(%esp);	\
+	jmp 1b;		\
+7:	movl $0,(%esp);	\
+	jmp 2b;		\
+8:	movl $0,(%esp);	\
+	jmp 3b;		\
+9:	movl $0,(%esp);	\
+	jmp 4b;		\
+.previous;		\
+.section __ex_table,"a";\
+	.align 4;	\
+	.long 1b,6b;	\
+	.long 2b,7b;	\
+	.long 3b,8b;	\
+	.long 4b,9b;	\
+.previous
+#endif
+
 ENTRY(coprocessor_error)
 	pushl $0
 	pushl $do_coprocessor_error
@@ -479,17 +574,19 @@ ENTRY(simd_coprocessor_error)
 ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
 	SAVE_ALL
+#ifndef CONFIG_XEN
 	movl %cr0, %eax
 	testl $0x4, %eax		# EM (math emulation bit)
-	jne device_not_available_emulate
-	preempt_stop
-	call math_state_restore
-	jmp ret_from_exception
-device_not_available_emulate:
+	je device_available_emulate
 	pushl $0			# temporary storage for ORIG_EIP
 	call math_emulate
 	addl $4, %esp
 	jmp ret_from_exception
+device_available_emulate:
+#endif
+	preempt_stop
+	call math_state_restore
+	jmp ret_from_exception
 
 /*
  * Debug traps and NMI can happen at the one SYSENTER instruction
@@ -525,6 +622,8 @@ debug_stack_correct:
 	call do_debug
 	jmp ret_from_exception
 	.previous .text
+
+#ifndef CONFIG_XEN
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
  * a debug fault, and the debug fault hasn't yet been able to
@@ -595,6 +694,10 @@ nmi_16bit_stack:
 	.align 4
 	.long 1b,iret_exc
 .previous
+#else
+ENTRY(nmi)
+	jmp restore_all
+#endif
 
 KPROBE_ENTRY(int3)
 	pushl $-1			# mark this as an int

--
