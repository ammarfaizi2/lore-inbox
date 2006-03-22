Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750980AbWCVGsS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750980AbWCVGsS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Mar 2006 01:48:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750961AbWCVGsG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Mar 2006 01:48:06 -0500
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:5763 "EHLO
	sorel.sous-sol.org") by vger.kernel.org with ESMTP id S1750875AbWCVGhf
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Mar 2006 01:37:35 -0500
Message-Id: <20060322063749.275209000@sorel.sous-sol.org>
References: <20060322063040.960068000@sorel.sous-sol.org>
Date: Tue, 21 Mar 2006 22:30:51 -0800
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: xen-devel@lists.xensource.com, virtualization@lists.osdl.org,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 11/35] Add support for Xen to entry.S.
Content-Disposition: inline; filename=10-i386-entry.S
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
 arch/i386/kernel/entry.S |  228 +++++++++++++++++++++++++++++++++++++++++++----
 1 files changed, 211 insertions(+), 17 deletions(-)

--- xen-subarch-2.6.orig/arch/i386/kernel/entry.S
+++ xen-subarch-2.6/arch/i386/kernel/entry.S
@@ -75,8 +75,42 @@ DF_MASK		= 0x00000400 
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
+/* Pseudo-eflags. */
+NMI_MASK	= 0x80000000
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
+#define __ENABLE_INTERRUPTS	movb $0,evtchn_upcall_mask(%esi)
+#define DISABLE_INTERRUPTS	GET_VCPU_INFO				; \
+				__DISABLE_INTERRUPTS
+#define ENABLE_INTERRUPTS	GET_VCPU_INFO				; \
+				__ENABLE_INTERRUPTS
+#define __TEST_PENDING		testb $0xFF,evtchn_upcall_pending(%esi)
+#endif
+
 #ifdef CONFIG_PREEMPT
-#define preempt_stop		cli
+#define preempt_stop		DISABLE_INTERRUPTS
 #else
 #define preempt_stop
 #define resume_kernel		restore_nocheck
@@ -145,10 +179,10 @@ ret_from_intr:
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
@@ -159,7 +193,7 @@ ENTRY(resume_userspace)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
-	cli
+	DISABLE_INTERRUPTS
 	cmpl $0,TI_preempt_count(%ebp)	# non-zero preempt_count ?
 	jnz restore_nocheck
 need_resched:
@@ -179,7 +213,7 @@ need_resched:
 ENTRY(sysenter_entry)
 	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
-	sti
+	ENABLE_INTERRUPTS
 	pushl $(__USER_DS)
 	pushl %ebp
 	pushfl
@@ -209,7 +243,7 @@ sysenter_past_esp:
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)
-	cli
+	DISABLE_INTERRUPTS
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
@@ -217,7 +251,7 @@ sysenter_past_esp:
 	movl EIP(%esp), %edx
 	movl OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
-	sti
+	ENABLE_INTERRUPTS
 	sysexit
 
 
@@ -236,7 +270,7 @@ syscall_call:
 	call *sys_call_table(,%eax,4)
 	movl %eax,EAX(%esp)		# store the return value
 syscall_exit:
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -244,6 +278,7 @@ syscall_exit:
 	jne syscall_exit_work
 
 restore_all:
+#ifndef CONFIG_XEN
 	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
 	# Warning: OLDSS(%esp) contains the wrong/random values if we
 	# are returning to the kernel.
@@ -254,12 +289,25 @@ restore_all:
 	cmpl $((4 << 8) | 3), %eax
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
+#else
+restore_nocheck:
+	testl $(VM_MASK|NMI_MASK), EFLAGS(%esp)
+	jnz hypervisor_iret
+	movb EVENT_MASK(%esp), %al
+	notb %al			# %al == ~saved_mask
+	GET_VCPU_INFO
+	andb evtchn_upcall_mask(%esi),%al
+	andb $1,%al			# %al == mask & ~saved_mask
+	jnz restore_all_enable_events	#     != 0 => reenable event delivery
+#endif
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
@@ -269,6 +317,7 @@ iret_exc:
 	.long 1b,iret_exc
 .previous
 
+#ifndef CONFIG_XEN
 ldt_ss:
 	larl OLDSS(%esp), %eax
 	jnz restore_nocheck
@@ -281,7 +330,7 @@ ldt_ss:
 	 * CPUs, which we can try to work around to make
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
-	cli
+	DISABLE_INTERRUPTS
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
 	 * and a switch16 pointer on top of the current frame. */
@@ -293,6 +342,13 @@ ldt_ss:
 	.align 4
 	.long 1b,iret_exc
 .previous
+#else
+hypervisor_iret:
+	andl $~NMI_MASK, EFLAGS(%esp)
+	RESTORE_REGS
+	addl $4, %esp
+	jmp  hypercall_page + (__HYPERVISOR_iret * 32)
+#endif
 
 	# perform work that needs to be done immediately before resumption
 	ALIGN
@@ -301,7 +357,7 @@ work_pending:
 	jz work_notifysig
 work_resched:
 	call schedule
-	cli				# make sure we don't miss an interrupt
+	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
 					# between sampling and the iret
 	movl TI_flags(%ebp), %ecx
@@ -353,7 +409,7 @@ syscall_trace_entry:
 syscall_exit_work:
 	testb $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP), %cl
 	jz work_pending
-	sti				# could let do_syscall_trace() call
+	ENABLE_INTERRUPTS		# could let do_syscall_trace() call
 					# schedule() instead
 	movl %esp, %eax
 	movl $1, %edx
@@ -373,6 +429,7 @@ syscall_badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
 
+#ifndef CONFIG_XEN
 #define FIXUP_ESPFIX_STACK \
 	movl %esp, %eax; \
 	/* switch to 32bit stack using the pointer on top of 16bit stack */ \
@@ -431,6 +488,9 @@ ENTRY(name)				\
 
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
+#else
+#define UNWIND_ESPFIX_STACK
+#endif
 
 ENTRY(divide_error)
 	pushl $0			# no error code
@@ -462,6 +522,126 @@ error_code:
 	call *%edi
 	jmp ret_from_exception
 
+#ifdef CONFIG_XEN
+# A note on the "critical region" in our callback handler.
+# We want to avoid stacking callback handlers due to events occurring
+# during handling of the last event. To do this, we keep events disabled
+# until we've done all processing. HOWEVER, we must enable events before
+# popping the stack frame (can't be done atomically) and so it would still
+# be possible to get enough handler activations to overflow the stack.
+# Although unlikely, bugs of that kind are hard to track down, so we'd
+# like to avoid the possibility.
+# So, on entry to the handler we detect whether we interrupted an
+# existing activation in its critical region -- if so, we pop the current
+# activation and restart the handler using the previous one.
+ENTRY(hypervisor_callback)
+	pushl %eax
+	SAVE_ALL
+	movl EIP(%esp),%eax
+	cmpl $scrit,%eax
+	jb   11f
+	cmpl $ecrit,%eax
+	jb   critical_region_fixup
+11:	push %esp
+	call evtchn_do_upcall
+	add  $4,%esp
+	jmp  ret_from_intr
+
+        ALIGN
+restore_all_enable_events:
+	__ENABLE_INTERRUPTS
+scrit:	/**** START OF CRITICAL REGION ****/
+	__TEST_PENDING
+	jnz  14f			# process more events if necessary...
+	RESTORE_REGS
+	addl $4, %esp
+1:	iret
+.section .fixup,"ax"
+2:	pushl $0
+	pushl $do_iret_error
+	jmp error_code
+.previous
+.section __ex_table,"a"
+	.align 4
+	.long 1b,2b
+.previous
+14:	__DISABLE_INTERRUPTS
+	jmp  11b
+ecrit:  /**** END OF CRITICAL REGION ****/
+# [How we do the fixup]. We want to merge the current stack frame with the
+# just-interrupted frame. How we do this depends on where in the critical
+# region the interrupted handler was executing, and so how many saved
+# registers are in each frame. We do this quickly using the lookup table
+# 'critical_fixup_table'. For each byte offset in the critical region, it
+# provides the number of bytes which have already been popped from the
+# interrupted stack frame.
+critical_region_fixup:
+	addl $critical_fixup_table-scrit,%eax
+	movzbl (%eax),%eax		# %eax contains num bytes popped
+	cmpb $0xff,%al                  # 0xff => vcpu_info critical region
+	jne  15f
+	GET_THREAD_INFO(%ebp)
+        xorl %eax,%eax
+15:	mov  %esp,%esi
+	add  %eax,%esi			# %esi points at end of src region
+	mov  %esp,%edi
+	add  $0x34,%edi			# %edi points at end of dst region
+	mov  %eax,%ecx
+	shr  $2,%ecx			# convert words to bytes
+	je   17f			# skip loop if nothing to copy
+16:	subl $4,%esi			# pre-decrementing copy loop
+	subl $4,%edi
+	movl (%esi),%eax
+	movl %eax,(%edi)
+	loop 16b
+17:	movl %edi,%esp			# final %edi is top of merged stack
+	jmp  11b
+
+critical_fixup_table:
+	.byte 0xff,0xff,0xff		# testb $0xff,(%esi) = __TEST_PENDING
+	.byte 0xff,0xff			# jnz  14f
+	.byte 0x00			# pop  %ebx
+	.byte 0x04			# pop  %ecx
+	.byte 0x08			# pop  %edx
+	.byte 0x0c			# pop  %esi
+	.byte 0x10			# pop  %edi
+	.byte 0x14			# pop  %ebp
+	.byte 0x18			# pop  %eax
+	.byte 0x1c			# pop  %ds
+	.byte 0x20			# pop  %es
+	.byte 0x24,0x24,0x24		# add  $4,%esp
+	.byte 0x28			# iret
+	.byte 0xff,0xff,0xff,0xff	# movb $1,1(%esi)
+	.byte 0x00,0x00			# jmp  11b
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
@@ -475,17 +655,19 @@ ENTRY(simd_coprocessor_error)
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
@@ -521,6 +703,8 @@ debug_stack_correct:
 	call do_debug
 	jmp ret_from_exception
 	.previous .text
+
+#ifndef CONFIG_XEN
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
  * a debug fault, and the debug fault hasn't yet been able to
@@ -591,6 +775,16 @@ nmi_16bit_stack:
 	.align 4
 	.long 1b,iret_exc
 .previous
+#else
+ENTRY(nmi)
+	pushl %eax
+	SAVE_ALL
+	xorl %edx,%edx		# zero error code
+	movl %esp,%eax		# pt_regs pointer
+	call do_nmi
+	orl  $NMI_MASK, EFLAGS(%esp)
+	jmp restore_all
+#endif
 
 KPROBE_ENTRY(int3)
 	pushl $-1			# mark this as an int

--
