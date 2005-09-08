Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932654AbVIHPJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932654AbVIHPJZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932670AbVIHPJY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:09:24 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:30562
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932654AbVIHPJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:09:22 -0400
Message-Id: <432070850200007800024465@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:10:29 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386 CFI annotations
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part2A084475.0__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part2A084475.0__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

As a foundation for reliable stack unwinding, this adds CFI unwind
annotations to many low-level i386 routines, plus a config option
(available to all architectures) to enable them as well as the
compiler
producing similar information for all C sources.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/i386/kernel/entry.S
2.6.13-i386-cfi/arch/i386/kernel/entry.S
--- 2.6.13/arch/i386/kernel/entry.S	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-i386-cfi/arch/i386/kernel/entry.S	2005-09-07
16:21:51.000000000 +0200
@@ -48,6 +48,7 @@
 #include <asm/smp.h>
 #include <asm/page.h>
 #include <asm/desc.h>
+#include <asm/dwarf2.h>
 #include "irq_vectors.h"
 
 #define nr_syscalls ((syscall_table_size)/4)
@@ -85,31 +86,67 @@ VM_MASK		= 0x00020000
 #define SAVE_ALL \
 	cld; \
 	pushl %es; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	/*CFI_REL_OFFSET es, 0;*/\
 	pushl %ds; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	/*CFI_REL_OFFSET ds, 0;*/\
 	pushl %eax; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_REL_OFFSET eax, 0;\
 	pushl %ebp; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_REL_OFFSET ebp, 0;\
 	pushl %edi; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_REL_OFFSET edi, 0;\
 	pushl %esi; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_REL_OFFSET esi, 0;\
 	pushl %edx; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_REL_OFFSET edx, 0;\
 	pushl %ecx; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_REL_OFFSET ecx, 0;\
 	pushl %ebx; \
+	CFI_ADJUST_CFA_OFFSET 4;\
+	CFI_REL_OFFSET ebx, 0;\
 	movl $(__USER_DS), %edx; \
 	movl %edx, %ds; \
 	movl %edx, %es;
 
 #define RESTORE_INT_REGS \
 	popl %ebx;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	CFI_RESTORE ebx;\
 	popl %ecx;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	CFI_RESTORE ecx;\
 	popl %edx;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	CFI_RESTORE edx;\
 	popl %esi;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	CFI_RESTORE esi;\
 	popl %edi;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	CFI_RESTORE edi;\
 	popl %ebp;	\
-	popl %eax
+	CFI_ADJUST_CFA_OFFSET -4;\
+	CFI_RESTORE ebp;\
+	popl %eax;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	CFI_RESTORE eax
 
 #define RESTORE_REGS	\
 	RESTORE_INT_REGS; \
 1:	popl %ds;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	/*CFI_RESTORE ds;*/\
 2:	popl %es;	\
+	CFI_ADJUST_CFA_OFFSET -4;\
+	/*CFI_RESTORE es;*/\
 .section .fixup,"ax";	\
 3:	movl $0,(%esp);	\
 	jmp 1b;		\
@@ -122,13 +159,43 @@ VM_MASK		= 0x00020000
 	.long 2b,4b;	\
 .previous
 
+#define RING0_INT_FRAME \
+	CFI_STARTPROC simple;\
+	CFI_DEF_CFA esp, 3*4;\
+	/*CFI_OFFSET cs, -2*4;*/\
+	CFI_OFFSET eip, -3*4
+
+#define RING0_EC_FRAME \
+	CFI_STARTPROC simple;\
+	CFI_DEF_CFA esp, 4*4;\
+	/*CFI_OFFSET cs, -2*4;*/\
+	CFI_OFFSET eip, -3*4
+
+#define RING0_PTREGS_FRAME \
+	CFI_STARTPROC simple;\
+	CFI_DEF_CFA esp, OLDESP-EBX;\
+	/*CFI_OFFSET cs, CS-OLDESP;*/\
+	CFI_OFFSET eip, EIP-OLDESP;\
+	/*CFI_OFFSET es, ES-OLDESP;*/\
+	/*CFI_OFFSET ds, DS-OLDESP;*/\
+	CFI_OFFSET eax, EAX-OLDESP;\
+	CFI_OFFSET ebp, EBP-OLDESP;\
+	CFI_OFFSET edi, EDI-OLDESP;\
+	CFI_OFFSET esi, ESI-OLDESP;\
+	CFI_OFFSET edx, EDX-OLDESP;\
+	CFI_OFFSET ecx, ECX-OLDESP;\
+	CFI_OFFSET ebx, EBX-OLDESP
 
 ENTRY(ret_from_fork)
+	CFI_STARTPROC
 	pushl %eax
+	CFI_ADJUST_CFA_OFFSET -4
 	call schedule_tail
 	GET_THREAD_INFO(%ebp)
 	popl %eax
+	CFI_ADJUST_CFA_OFFSET -4
 	jmp syscall_exit
+	CFI_ENDPROC
 
 /*
  * Return to user mode is not as complex as all this looks,
@@ -139,6 +206,7 @@ ENTRY(ret_from_fork)
 
 	# userspace resumption stub bypassing syscall exit tracing
 	ALIGN
+	RING0_PTREGS_FRAME
 ret_from_exception:
 	preempt_stop
 ret_from_intr:
@@ -171,20 +239,33 @@ need_resched:
 	call preempt_schedule_irq
 	jmp need_resched
 #endif
+	CFI_ENDPROC
 
 /* SYSENTER_RETURN points to after the "sysenter" instruction in
    the vsyscall page.  See vsyscall-sysentry.S, which defines the
symbol.  */
 
 	# sysenter call handler stub
 ENTRY(sysenter_entry)
+	CFI_STARTPROC simple
+	CFI_DEF_CFA esp, 0
+	CFI_REGISTER esp, ebp
 	movl TSS_sysenter_esp0(%esp),%esp
 sysenter_past_esp:
 	sti
 	pushl $(__USER_DS)
+	CFI_ADJUST_CFA_OFFSET 4
+	/*CFI_REL_OFFSET ss, 0*/
 	pushl %ebp
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET esp, 0
 	pushfl
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $(__USER_CS)
+	CFI_ADJUST_CFA_OFFSET 4
+	/*CFI_REL_OFFSET cs, 0*/
 	pushl $SYSENTER_RETURN
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET eip, 0
 
 /*
  * Load the potential sixth argument from user stack.
@@ -199,6 +280,7 @@ sysenter_past_esp:
 .previous
 
 	pushl %eax
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
 
@@ -219,11 +301,14 @@ sysenter_past_esp:
 	xorl %ebp,%ebp
 	sti
 	sysexit
+	CFI_ENDPROC
 
 
 	# system call handler stub
 ENTRY(system_call)
+	RING0_INT_FRAME			# can't unwind into user space
anyway
 	pushl %eax			# save orig_eax
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
 					# system call tracing in
operation
@@ -252,10 +337,12 @@ restore_all:
 	movb CS(%esp), %al
 	andl $(VM_MASK | (4 << 8) | 3), %eax
 	cmpl $((4 << 8) | 3), %eax
+	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with
LDT SS
 restore_nocheck:
 	RESTORE_REGS
 	addl $4, %esp
+	CFI_ADJUST_CFA_OFFSET -4
 1:	iret
 .section .fixup,"ax"
 iret_exc:
@@ -269,6 +356,7 @@ iret_exc:
 	.long 1b,iret_exc
 .previous
 
+	CFI_RESTORE_STATE
 ldt_ss:
 	larl OLDSS(%esp), %eax
 	jnz restore_nocheck
@@ -281,11 +369,13 @@ ldt_ss:
 	 * CPUs, which we can try to work around to make
 	 * dosemu and wine happy. */
 	subl $8, %esp		# reserve space for switch16 pointer
+	CFI_ADJUST_CFA_OFFSET 8
 	cli
 	movl %esp, %eax
 	/* Set up the 16bit stack frame with switch32 pointer on top,
 	 * and a switch16 pointer on top of the current frame. */
 	call setup_x86_bogus_stack
+	CFI_ADJUST_CFA_OFFSET -8	# frame has moved
 	RESTORE_REGS
 	lss 20+4(%esp), %esp	# switch to 16bit stack
 1:	iret
@@ -293,9 +383,11 @@ ldt_ss:
 	.align 4
 	.long 1b,iret_exc
 .previous
+	CFI_ENDPROC
 
 	# perform work that needs to be done immediately before
resumption
 	ALIGN
+	RING0_PTREGS_FRAME		# can't unwind into user space
anyway
 work_pending:
 	testb $_TIF_NEED_RESCHED, %cl
 	jz work_notifysig
@@ -324,8 +416,10 @@ work_notifysig:				# deal
with pending s
 	ALIGN
 work_notifysig_v86:
 	pushl %ecx			# save ti_flags for
do_notify_resume
+	CFI_ADJUST_CFA_OFFSET 4
 	call save_v86_state		# %eax contains pt_regs pointer
 	popl %ecx
+	CFI_ADJUST_CFA_OFFSET -4
 	movl %eax, %esp
 	xorl %edx, %edx
 	call do_notify_resume
@@ -354,19 +448,21 @@ syscall_exit_work:
 	movl $1, %edx
 	call do_syscall_trace
 	jmp resume_userspace
+	CFI_ENDPROC
 
-	ALIGN
+	RING0_INT_FRAME			# can't unwind into user space
anyway
 syscall_fault:
 	pushl %eax			# save orig_eax
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
 	movl $-EFAULT,EAX(%esp)
 	jmp resume_userspace
 
-	ALIGN
 syscall_badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
+	CFI_ENDPROC
 
 #define FIXUP_ESPFIX_STACK \
 	movl %esp, %eax; \
@@ -378,16 +474,21 @@ syscall_badsys:
 	movl %eax, %esp;
 #define UNWIND_ESPFIX_STACK \
 	pushl %eax; \
+	CFI_ADJUST_CFA_OFFSET 4; \
 	movl %ss, %eax; \
 	/* see if on 16bit stack */ \
 	cmpw $__ESPFIX_SS, %ax; \
-	jne 28f; \
-	movl $__KERNEL_DS, %edx; \
-	movl %edx, %ds; \
-	movl %edx, %es; \
+	je 28f; \
+27:	popl %eax; \
+	CFI_ADJUST_CFA_OFFSET -4; \
+.section .fixup,"ax"; \
+28:	movl $__KERNEL_DS, %eax; \
+	movl %eax, %ds; \
+	movl %eax, %es; \
 	/* switch to 32bit stack */ \
-	FIXUP_ESPFIX_STACK \
-28:	popl %eax;
+	FIXUP_ESPFIX_STACK; \
+	jmp 27b; \
+.previous
 
 /*
  * Build the entry stubs and pointer table with
@@ -399,9 +500,14 @@ ENTRY(interrupt)
 
 vector=0
 ENTRY(irq_entries_start)
+	RING0_INT_FRAME
 .rept NR_IRQS
 	ALIGN
+ .if vector
+	CFI_ADJUST_CFA_OFFSET -4
+ .endif
 1:	pushl $vector-256
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp common_interrupt
 .data
 	.long 1b
@@ -415,60 +521,99 @@ common_interrupt:
 	movl %esp,%eax
 	call do_IRQ
 	jmp ret_from_intr
+	CFI_ENDPROC
 
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
+	RING0_INT_FRAME;		\
 	pushl $nr-256;			\
-	SAVE_ALL			\
+	CFI_ADJUST_CFA_OFFSET 4;	\
+	SAVE_ALL;			\
 	movl %esp,%eax;			\
 	call smp_/**/name;		\
-	jmp ret_from_intr;
+	jmp ret_from_intr;	\
+	CFI_ENDPROC
 
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
 
 ENTRY(divide_error)
+	RING0_INT_FRAME
 	pushl $0			# no error code
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $do_divide_error
+	CFI_ADJUST_CFA_OFFSET 4
 	ALIGN
 error_code:
 	pushl %ds
+	CFI_ADJUST_CFA_OFFSET 4
+	/*CFI_REL_OFFSET ds, 0*/
 	pushl %eax
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET eax, 0
 	xorl %eax, %eax
 	pushl %ebp
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ebp, 0
 	pushl %edi
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET edi, 0
 	pushl %esi
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET esi, 0
 	pushl %edx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET edx, 0
 	decl %eax			# eax = -1
 	pushl %ecx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ecx, 0
 	pushl %ebx
+	CFI_ADJUST_CFA_OFFSET 4
+	CFI_REL_OFFSET ebx, 0
 	cld
 	pushl %es
+	CFI_ADJUST_CFA_OFFSET 4
+	/*CFI_REL_OFFSET es, 0*/
 	UNWIND_ESPFIX_STACK
 	popl %ecx
+	CFI_ADJUST_CFA_OFFSET -4
+	/*CFI_REGISTER es, ecx*/
 	movl ES(%esp), %edi		# get the function address
 	movl ORIG_EAX(%esp), %edx	# get the error code
 	movl %eax, ORIG_EAX(%esp)
 	movl %ecx, ES(%esp)
+	/*CFI_REL_OFFSET es, ES*/
 	movl $(__USER_DS), %ecx
 	movl %ecx, %ds
 	movl %ecx, %es
 	movl %esp,%eax			# pt_regs pointer
 	call *%edi
 	jmp ret_from_exception
+	CFI_ENDPROC
 
 ENTRY(coprocessor_error)
+	RING0_INT_FRAME
 	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $do_coprocessor_error
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(simd_coprocessor_error)
+	RING0_INT_FRAME
 	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $do_simd_coprocessor_error
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(device_not_available)
+	RING0_INT_FRAME
 	pushl $-1			# mark this as an int
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	movl %cr0, %eax
 	testl $0x4, %eax		# EM (math emulation bit)
@@ -478,9 +623,12 @@ ENTRY(device_not_available)
 	jmp ret_from_exception
 device_not_available_emulate:
 	pushl $0			# temporary storage for
ORIG_EIP
+	CFI_ADJUST_CFA_OFFSET 4
 	call math_emulate
 	addl $4, %esp
+	CFI_ADJUST_CFA_OFFSET -4
 	jmp ret_from_exception
+	CFI_ENDPROC
 
 /*
  * Debug traps and NMI can happen at the one SYSENTER instruction
@@ -505,16 +653,19 @@
label:						\
 	pushl $sysenter_past_esp
 
 ENTRY(debug)
+	RING0_INT_FRAME
 	cmpl $sysenter_entry,(%esp)
 	jne debug_stack_correct
 	FIX_STACK(12, debug_stack_correct, debug_esp_fix_insn)
 debug_stack_correct:
 	pushl $-1			# mark this as an int
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	xorl %edx,%edx			# error code 0
 	movl %esp,%eax			# pt_regs pointer
 	call do_debug
 	jmp ret_from_exception
+	CFI_ENDPROC
 
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
@@ -525,14 +676,18 @@ debug_stack_correct:
  * fault happened on the sysenter path.
  */
 ENTRY(nmi)
+	RING0_INT_FRAME
 	pushl %eax
+	CFI_ADJUST_CFA_OFFSET 4
 	movl %ss, %eax
 	cmpw $__ESPFIX_SS, %ax
 	popl %eax
+	CFI_ADJUST_CFA_OFFSET -4
 	je nmi_16bit_stack
 	cmpl $sysenter_entry,(%esp)
 	je nmi_stack_fixup
 	pushl %eax
+	CFI_ADJUST_CFA_OFFSET 4
 	movl %esp,%eax
 	/* Do not access memory above the end of our stack page,
 	 * it might not exist.
@@ -540,16 +695,19 @@ ENTRY(nmi)
 	andl $(THREAD_SIZE-1),%eax
 	cmpl $(THREAD_SIZE-20),%eax
 	popl %eax
+	CFI_ADJUST_CFA_OFFSET -4
 	jae nmi_stack_correct
 	cmpl $sysenter_entry,12(%esp)
 	je nmi_debug_stack_check
 nmi_stack_correct:
 	pushl %eax
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_nmi
 	jmp restore_all
+	CFI_ENDPROC
 
 nmi_stack_fixup:
 	FIX_STACK(12,nmi_stack_correct, 1)
@@ -566,91 +724,143 @@ nmi_debug_stack_fixup:
 	jmp nmi_stack_correct
 
 nmi_16bit_stack:
+	RING0_INT_FRAME
 	/* create the pointer to lss back */
 	pushl %ss
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl %esp
+	CFI_ADJUST_CFA_OFFSET 4
 	movzwl %sp, %esp
 	addw $4, (%esp)
 	/* copy the iret frame of 12 bytes */
 	.rept 3
 	pushl 16(%esp)
+	CFI_ADJUST_CFA_OFFSET 4
 	.endr
 	pushl %eax
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	FIXUP_ESPFIX_STACK		# %eax == %esp
+	CFI_ADJUST_CFA_OFFSET -20	# the frame has now moved
 	xorl %edx,%edx			# zero error code
 	call do_nmi
 	RESTORE_REGS
 	lss 12+4(%esp), %esp		# back to 16bit stack
 1:	iret
+	CFI_ENDPROC
 .section __ex_table,"a"
 	.align 4
 	.long 1b,iret_exc
 .previous
 
 ENTRY(int3)
+	RING0_INT_FRAME
 	pushl $-1			# mark this as an int
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	xorl %edx,%edx		# zero error code
 	movl %esp,%eax		# pt_regs pointer
 	call do_int3
 	jmp ret_from_exception
+	CFI_ENDPROC
 
 ENTRY(overflow)
+	RING0_INT_FRAME
 	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $do_overflow
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(bounds)
+	RING0_INT_FRAME
 	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $do_bounds
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(invalid_op)
+	RING0_INT_FRAME
 	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $do_invalid_op
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(coprocessor_segment_overrun)
+	RING0_INT_FRAME
 	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $do_coprocessor_segment_overrun
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(invalid_TSS)
+	RING0_EC_FRAME
 	pushl $do_invalid_TSS
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(segment_not_present)
+	RING0_EC_FRAME
 	pushl $do_segment_not_present
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(stack_segment)
+	RING0_EC_FRAME
 	pushl $do_stack_segment
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(general_protection)
+	RING0_EC_FRAME
 	pushl $do_general_protection
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(alignment_check)
+	RING0_EC_FRAME
 	pushl $do_alignment_check
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 ENTRY(page_fault)
+	RING0_EC_FRAME
 	pushl $do_page_fault
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 #ifdef CONFIG_X86_MCE
 ENTRY(machine_check)
+	RING0_INT_FRAME
 	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl machine_check_vector
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 #endif
 
 ENTRY(spurious_interrupt_bug)
+	RING0_INT_FRAME
 	pushl $0
+	CFI_ADJUST_CFA_OFFSET 4
 	pushl $do_spurious_interrupt_bug
+	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
+	CFI_ENDPROC
 
 #include "syscall_table.S"
 
diff -Npru 2.6.13/include/asm-i386/dwarf2.h
2.6.13-i386-cfi/include/asm-i386/dwarf2.h
--- 2.6.13/include/asm-i386/dwarf2.h	1970-01-01 01:00:00.000000000
+0100
+++ 2.6.13-i386-cfi/include/asm-i386/dwarf2.h	2005-06-30
14:43:06.000000000 +0200
@@ -0,0 +1,54 @@
+#ifndef _DWARF2_H
+#define _DWARF2_H
+
+#include <linux/config.h>
+
+#ifndef __ASSEMBLY__
+#warning "asm/dwarf2.h should be only included in pure assembly
files"
+#endif
+
+/*
+   Macros for dwarf2 CFI unwind table entries.
+   See "as.info" for details on these pseudo ops. Unfortunately
+   they are only supported in very new binutils, so define them
+   away for older version.
+ */
+
+#ifdef CONFIG_UNWIND_INFO
+
+#define CFI_STARTPROC .cfi_startproc
+#define CFI_ENDPROC .cfi_endproc
+#define CFI_DEF_CFA .cfi_def_cfa
+#define CFI_DEF_CFA_REGISTER .cfi_def_cfa_register
+#define CFI_DEF_CFA_OFFSET .cfi_def_cfa_offset
+#define CFI_ADJUST_CFA_OFFSET .cfi_adjust_cfa_offset
+#define CFI_OFFSET .cfi_offset
+#define CFI_REL_OFFSET .cfi_rel_offset
+#define CFI_REGISTER .cfi_register
+#define CFI_RESTORE .cfi_restore
+#define CFI_REMEMBER_STATE .cfi_remember_state
+#define CFI_RESTORE_STATE .cfi_restore_state
+
+#else
+
+/* Due to the structure of pre-exisiting code, don't use assembler
line
+   comment character # to ignore the arguments. Instead, use a dummy
macro. */
+.macro ignore a=0, b=0, c=0, d=0
+.endm
+
+#define CFI_STARTPROC	ignore
+#define CFI_ENDPROC	ignore
+#define CFI_DEF_CFA	ignore
+#define CFI_DEF_CFA_REGISTER	ignore
+#define CFI_DEF_CFA_OFFSET	ignore
+#define CFI_ADJUST_CFA_OFFSET	ignore
+#define CFI_OFFSET	ignore
+#define CFI_REL_OFFSET	ignore
+#define CFI_REGISTER	ignore
+#define CFI_RESTORE	ignore
+#define CFI_REMEMBER_STATE ignore
+#define CFI_RESTORE_STATE ignore
+
+#endif
+
+#endif
diff -Npru 2.6.13/lib/Kconfig.debug 2.6.13-i386-cfi/lib/Kconfig.debug
--- 2.6.13/lib/Kconfig.debug	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-i386-cfi/lib/Kconfig.debug	2005-09-07 13:26:18.000000000
+0200
@@ -159,3 +159,12 @@ config FRAME_POINTER
 	  If you don't debug the kernel, you can say N, but we may not
be able
 	  to solve problems without frame pointers.
 
+config UNWIND_INFO
+	bool "Compile the kernel with frame unwind information" if
!IA64
+	default DEBUG_KERNEL && !IA64
+	help
+	  If you say Y here the resulting kernel image will be slightly
larger
+	  but not slower, and it will give very useful debugging
information.
+	  If you don't debug the kernel, you can say N, but we may not
be able
+	  to solve problems without frame unwind information or frame
pointers.
+
diff -Npru 2.6.13/Makefile 2.6.13-i386-cfi/Makefile
--- 2.6.13/Makefile	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-i386-cfi/Makefile	2005-09-07 13:25:54.000000000 +0200
@@ -517,6 +517,10 @@ CFLAGS		+= $(call
add-align,CONFIG_CC_AL
 CFLAGS		+= $(call
add-align,CONFIG_CC_ALIGN_LOOPS,-loops)
 CFLAGS		+= $(call
add-align,CONFIG_CC_ALIGN_JUMPS,-jumps)
 
+ifdef CONFIG_UNWIND_INFO
+CFLAGS		+= -fasynchronous-unwind-tables
+endif
+
 ifdef CONFIG_FRAME_POINTER
 CFLAGS		+= -fno-omit-frame-pointer $(call
cc-option,-fno-optimize-sibling-calls,)
 else


--=__Part2A084475.0__=
Content-Type: application/octet-stream; name="linux-2.6.13-i386-cfi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-i386-cfi.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkFzIGEgZm91bmRhdGlvbiBmb3IgcmVsaWFi
bGUgc3RhY2sgdW53aW5kaW5nLCB0aGlzIGFkZHMgQ0ZJIHVud2luZAphbm5vdGF0aW9ucyB0byBt
YW55IGxvdy1sZXZlbCBpMzg2IHJvdXRpbmVzLCBwbHVzIGEgY29uZmlnIG9wdGlvbgooYXZhaWxh
YmxlIHRvIGFsbCBhcmNoaXRlY3R1cmVzKSB0byBlbmFibGUgdGhlbSBhcyB3ZWxsIGFzIHRoZSBj
b21waWxlcgpwcm9kdWNpbmcgc2ltaWxhciBpbmZvcm1hdGlvbiBmb3IgYWxsIEMgc291cmNlcy4K
ClNpZ25lZC1vZmYtYnk6IEphbiBCZXVsaWNoIDxqYmV1bGljaEBub3ZlbGwuY29tPgoKZGlmZiAt
TnBydSAyLjYuMTMvYXJjaC9pMzg2L2tlcm5lbC9lbnRyeS5TIDIuNi4xMy1pMzg2LWNmaS9hcmNo
L2kzODYva2VybmVsL2VudHJ5LlMKLS0tIDIuNi4xMy9hcmNoL2kzODYva2VybmVsL2VudHJ5LlMJ
MjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy1pMzg2LWNmaS9h
cmNoL2kzODYva2VybmVsL2VudHJ5LlMJMjAwNS0wOS0wNyAxNjoyMTo1MS4wMDAwMDAwMDAgKzAy
MDAKQEAgLTQ4LDYgKzQ4LDcgQEAKICNpbmNsdWRlIDxhc20vc21wLmg+CiAjaW5jbHVkZSA8YXNt
L3BhZ2UuaD4KICNpbmNsdWRlIDxhc20vZGVzYy5oPgorI2luY2x1ZGUgPGFzbS9kd2FyZjIuaD4K
ICNpbmNsdWRlICJpcnFfdmVjdG9ycy5oIgogCiAjZGVmaW5lIG5yX3N5c2NhbGxzICgoc3lzY2Fs
bF90YWJsZV9zaXplKS80KQpAQCAtODUsMzEgKzg2LDY3IEBAIFZNX01BU0sJCT0gMHgwMDAyMDAw
MAogI2RlZmluZSBTQVZFX0FMTCBcCiAJY2xkOyBcCiAJcHVzaGwgJWVzOyBcCisJQ0ZJX0FESlVT
VF9DRkFfT0ZGU0VUIDQ7XAorCS8qQ0ZJX1JFTF9PRkZTRVQgZXMsIDA7Ki9cCiAJcHVzaGwgJWRz
OyBcCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQ7XAorCS8qQ0ZJX1JFTF9PRkZTRVQgZHMsIDA7
Ki9cCiAJcHVzaGwgJWVheDsgXAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0O1wKKwlDRklfUkVM
X09GRlNFVCBlYXgsIDA7XAogCXB1c2hsICVlYnA7IFwKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQg
NDtcCisJQ0ZJX1JFTF9PRkZTRVQgZWJwLCAwO1wKIAlwdXNobCAlZWRpOyBcCisJQ0ZJX0FESlVT
VF9DRkFfT0ZGU0VUIDQ7XAorCUNGSV9SRUxfT0ZGU0VUIGVkaSwgMDtcCiAJcHVzaGwgJWVzaTsg
XAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0O1wKKwlDRklfUkVMX09GRlNFVCBlc2ksIDA7XAog
CXB1c2hsICVlZHg7IFwKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNDtcCisJQ0ZJX1JFTF9PRkZT
RVQgZWR4LCAwO1wKIAlwdXNobCAlZWN4OyBcCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQ7XAor
CUNGSV9SRUxfT0ZGU0VUIGVjeCwgMDtcCiAJcHVzaGwgJWVieDsgXAorCUNGSV9BREpVU1RfQ0ZB
X09GRlNFVCA0O1wKKwlDRklfUkVMX09GRlNFVCBlYngsIDA7XAogCW1vdmwgJChfX1VTRVJfRFMp
LCAlZWR4OyBcCiAJbW92bCAlZWR4LCAlZHM7IFwKIAltb3ZsICVlZHgsICVlczsKIAogI2RlZmlu
ZSBSRVNUT1JFX0lOVF9SRUdTIFwKIAlwb3BsICVlYng7CVwKKwlDRklfQURKVVNUX0NGQV9PRkZT
RVQgLTQ7XAorCUNGSV9SRVNUT1JFIGVieDtcCiAJcG9wbCAlZWN4OwlcCisJQ0ZJX0FESlVTVF9D
RkFfT0ZGU0VUIC00O1wKKwlDRklfUkVTVE9SRSBlY3g7XAogCXBvcGwgJWVkeDsJXAorCUNGSV9B
REpVU1RfQ0ZBX09GRlNFVCAtNDtcCisJQ0ZJX1JFU1RPUkUgZWR4O1wKIAlwb3BsICVlc2k7CVwK
KwlDRklfQURKVVNUX0NGQV9PRkZTRVQgLTQ7XAorCUNGSV9SRVNUT1JFIGVzaTtcCiAJcG9wbCAl
ZWRpOwlcCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIC00O1wKKwlDRklfUkVTVE9SRSBlZGk7XAog
CXBvcGwgJWVicDsJXAotCXBvcGwgJWVheAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtNDtcCisJ
Q0ZJX1JFU1RPUkUgZWJwO1wKKwlwb3BsICVlYXg7CVwKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQg
LTQ7XAorCUNGSV9SRVNUT1JFIGVheAogCiAjZGVmaW5lIFJFU1RPUkVfUkVHUwlcCiAJUkVTVE9S
RV9JTlRfUkVHUzsgXAogMToJcG9wbCAlZHM7CVwKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgLTQ7
XAorCS8qQ0ZJX1JFU1RPUkUgZHM7Ki9cCiAyOglwb3BsICVlczsJXAorCUNGSV9BREpVU1RfQ0ZB
X09GRlNFVCAtNDtcCisJLypDRklfUkVTVE9SRSBlczsqL1wKIC5zZWN0aW9uIC5maXh1cCwiYXgi
OwlcCiAzOgltb3ZsICQwLCglZXNwKTsJXAogCWptcCAxYjsJCVwKQEAgLTEyMiwxMyArMTU5LDQz
IEBAIFZNX01BU0sJCT0gMHgwMDAyMDAwMAogCS5sb25nIDJiLDRiOwlcCiAucHJldmlvdXMKIAor
I2RlZmluZSBSSU5HMF9JTlRfRlJBTUUgXAorCUNGSV9TVEFSVFBST0Mgc2ltcGxlO1wKKwlDRklf
REVGX0NGQSBlc3AsIDMqNDtcCisJLypDRklfT0ZGU0VUIGNzLCAtMio0OyovXAorCUNGSV9PRkZT
RVQgZWlwLCAtMyo0CisKKyNkZWZpbmUgUklORzBfRUNfRlJBTUUgXAorCUNGSV9TVEFSVFBST0Mg
c2ltcGxlO1wKKwlDRklfREVGX0NGQSBlc3AsIDQqNDtcCisJLypDRklfT0ZGU0VUIGNzLCAtMio0
OyovXAorCUNGSV9PRkZTRVQgZWlwLCAtMyo0CisKKyNkZWZpbmUgUklORzBfUFRSRUdTX0ZSQU1F
IFwKKwlDRklfU1RBUlRQUk9DIHNpbXBsZTtcCisJQ0ZJX0RFRl9DRkEgZXNwLCBPTERFU1AtRUJY
O1wKKwkvKkNGSV9PRkZTRVQgY3MsIENTLU9MREVTUDsqL1wKKwlDRklfT0ZGU0VUIGVpcCwgRUlQ
LU9MREVTUDtcCisJLypDRklfT0ZGU0VUIGVzLCBFUy1PTERFU1A7Ki9cCisJLypDRklfT0ZGU0VU
IGRzLCBEUy1PTERFU1A7Ki9cCisJQ0ZJX09GRlNFVCBlYXgsIEVBWC1PTERFU1A7XAorCUNGSV9P
RkZTRVQgZWJwLCBFQlAtT0xERVNQO1wKKwlDRklfT0ZGU0VUIGVkaSwgRURJLU9MREVTUDtcCisJ
Q0ZJX09GRlNFVCBlc2ksIEVTSS1PTERFU1A7XAorCUNGSV9PRkZTRVQgZWR4LCBFRFgtT0xERVNQ
O1wKKwlDRklfT0ZGU0VUIGVjeCwgRUNYLU9MREVTUDtcCisJQ0ZJX09GRlNFVCBlYngsIEVCWC1P
TERFU1AKIAogRU5UUlkocmV0X2Zyb21fZm9yaykKKwlDRklfU1RBUlRQUk9DCiAJcHVzaGwgJWVh
eAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtNAogCWNhbGwgc2NoZWR1bGVfdGFpbAogCUdFVF9U
SFJFQURfSU5GTyglZWJwKQogCXBvcGwgJWVheAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtNAog
CWptcCBzeXNjYWxsX2V4aXQKKwlDRklfRU5EUFJPQwogCiAvKgogICogUmV0dXJuIHRvIHVzZXIg
bW9kZSBpcyBub3QgYXMgY29tcGxleCBhcyBhbGwgdGhpcyBsb29rcywKQEAgLTEzOSw2ICsyMDYs
NyBAQCBFTlRSWShyZXRfZnJvbV9mb3JrKQogCiAJIyB1c2Vyc3BhY2UgcmVzdW1wdGlvbiBzdHVi
IGJ5cGFzc2luZyBzeXNjYWxsIGV4aXQgdHJhY2luZwogCUFMSUdOCisJUklORzBfUFRSRUdTX0ZS
QU1FCiByZXRfZnJvbV9leGNlcHRpb246CiAJcHJlZW1wdF9zdG9wCiByZXRfZnJvbV9pbnRyOgpA
QCAtMTcxLDIwICsyMzksMzMgQEAgbmVlZF9yZXNjaGVkOgogCWNhbGwgcHJlZW1wdF9zY2hlZHVs
ZV9pcnEKIAlqbXAgbmVlZF9yZXNjaGVkCiAjZW5kaWYKKwlDRklfRU5EUFJPQwogCiAvKiBTWVNF
TlRFUl9SRVRVUk4gcG9pbnRzIHRvIGFmdGVyIHRoZSAic3lzZW50ZXIiIGluc3RydWN0aW9uIGlu
CiAgICB0aGUgdnN5c2NhbGwgcGFnZS4gIFNlZSB2c3lzY2FsbC1zeXNlbnRyeS5TLCB3aGljaCBk
ZWZpbmVzIHRoZSBzeW1ib2wuICAqLwogCiAJIyBzeXNlbnRlciBjYWxsIGhhbmRsZXIgc3R1Ygog
RU5UUlkoc3lzZW50ZXJfZW50cnkpCisJQ0ZJX1NUQVJUUFJPQyBzaW1wbGUKKwlDRklfREVGX0NG
QSBlc3AsIDAKKwlDRklfUkVHSVNURVIgZXNwLCBlYnAKIAltb3ZsIFRTU19zeXNlbnRlcl9lc3Aw
KCVlc3ApLCVlc3AKIHN5c2VudGVyX3Bhc3RfZXNwOgogCXN0aQogCXB1c2hsICQoX19VU0VSX0RT
KQorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CisJLypDRklfUkVMX09GRlNFVCBzcywgMCovCiAJ
cHVzaGwgJWVicAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CisJQ0ZJX1JFTF9PRkZTRVQgZXNw
LCAwCiAJcHVzaGZsCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQKIAlwdXNobCAkKF9fVVNFUl9D
UykKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAorCS8qQ0ZJX1JFTF9PRkZTRVQgY3MsIDAqLwog
CXB1c2hsICRTWVNFTlRFUl9SRVRVUk4KKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAorCUNGSV9S
RUxfT0ZGU0VUIGVpcCwgMAogCiAvKgogICogTG9hZCB0aGUgcG90ZW50aWFsIHNpeHRoIGFyZ3Vt
ZW50IGZyb20gdXNlciBzdGFjay4KQEAgLTE5OSw2ICsyODAsNyBAQCBzeXNlbnRlcl9wYXN0X2Vz
cDoKIC5wcmV2aW91cwogCiAJcHVzaGwgJWVheAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CiAJ
U0FWRV9BTEwKIAlHRVRfVEhSRUFEX0lORk8oJWVicCkKIApAQCAtMjE5LDExICszMDEsMTQgQEAg
c3lzZW50ZXJfcGFzdF9lc3A6CiAJeG9ybCAlZWJwLCVlYnAKIAlzdGkKIAlzeXNleGl0CisJQ0ZJ
X0VORFBST0MKIAogCiAJIyBzeXN0ZW0gY2FsbCBoYW5kbGVyIHN0dWIKIEVOVFJZKHN5c3RlbV9j
YWxsKQorCVJJTkcwX0lOVF9GUkFNRQkJCSMgY2FuJ3QgdW53aW5kIGludG8gdXNlciBzcGFjZSBh
bnl3YXkKIAlwdXNobCAlZWF4CQkJIyBzYXZlIG9yaWdfZWF4CisJQ0ZJX0FESlVTVF9DRkFfT0ZG
U0VUIDQKIAlTQVZFX0FMTAogCUdFVF9USFJFQURfSU5GTyglZWJwKQogCQkJCQkjIHN5c3RlbSBj
YWxsIHRyYWNpbmcgaW4gb3BlcmF0aW9uCkBAIC0yNTIsMTAgKzMzNywxMiBAQCByZXN0b3JlX2Fs
bDoKIAltb3ZiIENTKCVlc3ApLCAlYWwKIAlhbmRsICQoVk1fTUFTSyB8ICg0IDw8IDgpIHwgMyks
ICVlYXgKIAljbXBsICQoKDQgPDwgOCkgfCAzKSwgJWVheAorCUNGSV9SRU1FTUJFUl9TVEFURQog
CWplIGxkdF9zcwkJCSMgcmV0dXJuaW5nIHRvIHVzZXItc3BhY2Ugd2l0aCBMRFQgU1MKIHJlc3Rv
cmVfbm9jaGVjazoKIAlSRVNUT1JFX1JFR1MKIAlhZGRsICQ0LCAlZXNwCisJQ0ZJX0FESlVTVF9D
RkFfT0ZGU0VUIC00CiAxOglpcmV0CiAuc2VjdGlvbiAuZml4dXAsImF4IgogaXJldF9leGM6CkBA
IC0yNjksNiArMzU2LDcgQEAgaXJldF9leGM6CiAJLmxvbmcgMWIsaXJldF9leGMKIC5wcmV2aW91
cwogCisJQ0ZJX1JFU1RPUkVfU1RBVEUKIGxkdF9zczoKIAlsYXJsIE9MRFNTKCVlc3ApLCAlZWF4
CiAJam56IHJlc3RvcmVfbm9jaGVjawpAQCAtMjgxLDExICszNjksMTMgQEAgbGR0X3NzOgogCSAq
IENQVXMsIHdoaWNoIHdlIGNhbiB0cnkgdG8gd29yayBhcm91bmQgdG8gbWFrZQogCSAqIGRvc2Vt
dSBhbmQgd2luZSBoYXBweS4gKi8KIAlzdWJsICQ4LCAlZXNwCQkjIHJlc2VydmUgc3BhY2UgZm9y
IHN3aXRjaDE2IHBvaW50ZXIKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgOAogCWNsaQogCW1vdmwg
JWVzcCwgJWVheAogCS8qIFNldCB1cCB0aGUgMTZiaXQgc3RhY2sgZnJhbWUgd2l0aCBzd2l0Y2gz
MiBwb2ludGVyIG9uIHRvcCwKIAkgKiBhbmQgYSBzd2l0Y2gxNiBwb2ludGVyIG9uIHRvcCBvZiB0
aGUgY3VycmVudCBmcmFtZS4gKi8KIAljYWxsIHNldHVwX3g4Nl9ib2d1c19zdGFjaworCUNGSV9B
REpVU1RfQ0ZBX09GRlNFVCAtOAkjIGZyYW1lIGhhcyBtb3ZlZAogCVJFU1RPUkVfUkVHUwogCWxz
cyAyMCs0KCVlc3ApLCAlZXNwCSMgc3dpdGNoIHRvIDE2Yml0IHN0YWNrCiAxOglpcmV0CkBAIC0y
OTMsOSArMzgzLDExIEBAIGxkdF9zczoKIAkuYWxpZ24gNAogCS5sb25nIDFiLGlyZXRfZXhjCiAu
cHJldmlvdXMKKwlDRklfRU5EUFJPQwogCiAJIyBwZXJmb3JtIHdvcmsgdGhhdCBuZWVkcyB0byBi
ZSBkb25lIGltbWVkaWF0ZWx5IGJlZm9yZSByZXN1bXB0aW9uCiAJQUxJR04KKwlSSU5HMF9QVFJF
R1NfRlJBTUUJCSMgY2FuJ3QgdW53aW5kIGludG8gdXNlciBzcGFjZSBhbnl3YXkKIHdvcmtfcGVu
ZGluZzoKIAl0ZXN0YiAkX1RJRl9ORUVEX1JFU0NIRUQsICVjbAogCWp6IHdvcmtfbm90aWZ5c2ln
CkBAIC0zMjQsOCArNDE2LDEwIEBAIHdvcmtfbm90aWZ5c2lnOgkJCQkjIGRlYWwgd2l0aCBwZW5k
aW5nIHMKIAlBTElHTgogd29ya19ub3RpZnlzaWdfdjg2OgogCXB1c2hsICVlY3gJCQkjIHNhdmUg
dGlfZmxhZ3MgZm9yIGRvX25vdGlmeV9yZXN1bWUKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAog
CWNhbGwgc2F2ZV92ODZfc3RhdGUJCSMgJWVheCBjb250YWlucyBwdF9yZWdzIHBvaW50ZXIKIAlw
b3BsICVlY3gKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgLTQKIAltb3ZsICVlYXgsICVlc3AKIAl4
b3JsICVlZHgsICVlZHgKIAljYWxsIGRvX25vdGlmeV9yZXN1bWUKQEAgLTM1NCwxOSArNDQ4LDIx
IEBAIHN5c2NhbGxfZXhpdF93b3JrOgogCW1vdmwgJDEsICVlZHgKIAljYWxsIGRvX3N5c2NhbGxf
dHJhY2UKIAlqbXAgcmVzdW1lX3VzZXJzcGFjZQorCUNGSV9FTkRQUk9DCiAKLQlBTElHTgorCVJJ
TkcwX0lOVF9GUkFNRQkJCSMgY2FuJ3QgdW53aW5kIGludG8gdXNlciBzcGFjZSBhbnl3YXkKIHN5
c2NhbGxfZmF1bHQ6CiAJcHVzaGwgJWVheAkJCSMgc2F2ZSBvcmlnX2VheAorCUNGSV9BREpVU1Rf
Q0ZBX09GRlNFVCA0CiAJU0FWRV9BTEwKIAlHRVRfVEhSRUFEX0lORk8oJWVicCkKIAltb3ZsICQt
RUZBVUxULEVBWCglZXNwKQogCWptcCByZXN1bWVfdXNlcnNwYWNlCiAKLQlBTElHTgogc3lzY2Fs
bF9iYWRzeXM6CiAJbW92bCAkLUVOT1NZUyxFQVgoJWVzcCkKIAlqbXAgcmVzdW1lX3VzZXJzcGFj
ZQorCUNGSV9FTkRQUk9DCiAKICNkZWZpbmUgRklYVVBfRVNQRklYX1NUQUNLIFwKIAltb3ZsICVl
c3AsICVlYXg7IFwKQEAgLTM3OCwxNiArNDc0LDIxIEBAIHN5c2NhbGxfYmFkc3lzOgogCW1vdmwg
JWVheCwgJWVzcDsKICNkZWZpbmUgVU5XSU5EX0VTUEZJWF9TVEFDSyBcCiAJcHVzaGwgJWVheDsg
XAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0OyBcCiAJbW92bCAlc3MsICVlYXg7IFwKIAkvKiBz
ZWUgaWYgb24gMTZiaXQgc3RhY2sgKi8gXAogCWNtcHcgJF9fRVNQRklYX1NTLCAlYXg7IFwKLQlq
bmUgMjhmOyBcCi0JbW92bCAkX19LRVJORUxfRFMsICVlZHg7IFwKLQltb3ZsICVlZHgsICVkczsg
XAotCW1vdmwgJWVkeCwgJWVzOyBcCisJamUgMjhmOyBcCisyNzoJcG9wbCAlZWF4OyBcCisJQ0ZJ
X0FESlVTVF9DRkFfT0ZGU0VUIC00OyBcCisuc2VjdGlvbiAuZml4dXAsImF4IjsgXAorMjg6CW1v
dmwgJF9fS0VSTkVMX0RTLCAlZWF4OyBcCisJbW92bCAlZWF4LCAlZHM7IFwKKwltb3ZsICVlYXgs
ICVlczsgXAogCS8qIHN3aXRjaCB0byAzMmJpdCBzdGFjayAqLyBcCi0JRklYVVBfRVNQRklYX1NU
QUNLIFwKLTI4Oglwb3BsICVlYXg7CisJRklYVVBfRVNQRklYX1NUQUNLOyBcCisJam1wIDI3Yjsg
XAorLnByZXZpb3VzCiAKIC8qCiAgKiBCdWlsZCB0aGUgZW50cnkgc3R1YnMgYW5kIHBvaW50ZXIg
dGFibGUgd2l0aApAQCAtMzk5LDkgKzUwMCwxNCBAQCBFTlRSWShpbnRlcnJ1cHQpCiAKIHZlY3Rv
cj0wCiBFTlRSWShpcnFfZW50cmllc19zdGFydCkKKwlSSU5HMF9JTlRfRlJBTUUKIC5yZXB0IE5S
X0lSUVMKIAlBTElHTgorIC5pZiB2ZWN0b3IKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgLTQKKyAu
ZW5kaWYKIDE6CXB1c2hsICR2ZWN0b3ItMjU2CisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQKIAlq
bXAgY29tbW9uX2ludGVycnVwdAogLmRhdGEKIAkubG9uZyAxYgpAQCAtNDE1LDYwICs1MjEsOTkg
QEAgY29tbW9uX2ludGVycnVwdDoKIAltb3ZsICVlc3AsJWVheAogCWNhbGwgZG9fSVJRCiAJam1w
IHJldF9mcm9tX2ludHIKKwlDRklfRU5EUFJPQwogCiAjZGVmaW5lIEJVSUxEX0lOVEVSUlVQVChu
YW1lLCBucikJXAogRU5UUlkobmFtZSkJCQkJXAorCVJJTkcwX0lOVF9GUkFNRTsJCVwKIAlwdXNo
bCAkbnItMjU2OwkJCVwKLQlTQVZFX0FMTAkJCVwKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNDsJ
XAorCVNBVkVfQUxMOwkJCVwKIAltb3ZsICVlc3AsJWVheDsJCQlcCiAJY2FsbCBzbXBfLyoqL25h
bWU7CQlcCi0Jam1wIHJldF9mcm9tX2ludHI7CisJam1wIHJldF9mcm9tX2ludHI7CVwKKwlDRklf
RU5EUFJPQwogCiAvKiBUaGUgaW5jbHVkZSBpcyB3aGVyZSBhbGwgb2YgdGhlIFNNUCBldGMuIGlu
dGVycnVwdHMgY29tZSBmcm9tICovCiAjaW5jbHVkZSAiZW50cnlfYXJjaC5oIgogCiBFTlRSWShk
aXZpZGVfZXJyb3IpCisJUklORzBfSU5UX0ZSQU1FCiAJcHVzaGwgJDAJCQkjIG5vIGVycm9yIGNv
ZGUKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAogCXB1c2hsICRkb19kaXZpZGVfZXJyb3IKKwlD
RklfQURKVVNUX0NGQV9PRkZTRVQgNAogCUFMSUdOCiBlcnJvcl9jb2RlOgogCXB1c2hsICVkcwor
CUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CisJLypDRklfUkVMX09GRlNFVCBkcywgMCovCiAJcHVz
aGwgJWVheAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CisJQ0ZJX1JFTF9PRkZTRVQgZWF4LCAw
CiAJeG9ybCAlZWF4LCAlZWF4CiAJcHVzaGwgJWVicAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0
CisJQ0ZJX1JFTF9PRkZTRVQgZWJwLCAwCiAJcHVzaGwgJWVkaQorCUNGSV9BREpVU1RfQ0ZBX09G
RlNFVCA0CisJQ0ZJX1JFTF9PRkZTRVQgZWRpLCAwCiAJcHVzaGwgJWVzaQorCUNGSV9BREpVU1Rf
Q0ZBX09GRlNFVCA0CisJQ0ZJX1JFTF9PRkZTRVQgZXNpLCAwCiAJcHVzaGwgJWVkeAorCUNGSV9B
REpVU1RfQ0ZBX09GRlNFVCA0CisJQ0ZJX1JFTF9PRkZTRVQgZWR4LCAwCiAJZGVjbCAlZWF4CQkJ
IyBlYXggPSAtMQogCXB1c2hsICVlY3gKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAorCUNGSV9S
RUxfT0ZGU0VUIGVjeCwgMAogCXB1c2hsICVlYngKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAor
CUNGSV9SRUxfT0ZGU0VUIGVieCwgMAogCWNsZAogCXB1c2hsICVlcworCUNGSV9BREpVU1RfQ0ZB
X09GRlNFVCA0CisJLypDRklfUkVMX09GRlNFVCBlcywgMCovCiAJVU5XSU5EX0VTUEZJWF9TVEFD
SwogCXBvcGwgJWVjeAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtNAorCS8qQ0ZJX1JFR0lTVEVS
IGVzLCBlY3gqLwogCW1vdmwgRVMoJWVzcCksICVlZGkJCSMgZ2V0IHRoZSBmdW5jdGlvbiBhZGRy
ZXNzCiAJbW92bCBPUklHX0VBWCglZXNwKSwgJWVkeAkjIGdldCB0aGUgZXJyb3IgY29kZQogCW1v
dmwgJWVheCwgT1JJR19FQVgoJWVzcCkKIAltb3ZsICVlY3gsIEVTKCVlc3ApCisJLypDRklfUkVM
X09GRlNFVCBlcywgRVMqLwogCW1vdmwgJChfX1VTRVJfRFMpLCAlZWN4CiAJbW92bCAlZWN4LCAl
ZHMKIAltb3ZsICVlY3gsICVlcwogCW1vdmwgJWVzcCwlZWF4CQkJIyBwdF9yZWdzIHBvaW50ZXIK
IAljYWxsIColZWRpCiAJam1wIHJldF9mcm9tX2V4Y2VwdGlvbgorCUNGSV9FTkRQUk9DCiAKIEVO
VFJZKGNvcHJvY2Vzc29yX2Vycm9yKQorCVJJTkcwX0lOVF9GUkFNRQogCXB1c2hsICQwCisJQ0ZJ
X0FESlVTVF9DRkFfT0ZGU0VUIDQKIAlwdXNobCAkZG9fY29wcm9jZXNzb3JfZXJyb3IKKwlDRklf
QURKVVNUX0NGQV9PRkZTRVQgNAogCWptcCBlcnJvcl9jb2RlCisJQ0ZJX0VORFBST0MKIAogRU5U
Ulkoc2ltZF9jb3Byb2Nlc3Nvcl9lcnJvcikKKwlSSU5HMF9JTlRfRlJBTUUKIAlwdXNobCAkMAor
CUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CiAJcHVzaGwgJGRvX3NpbWRfY29wcm9jZXNzb3JfZXJy
b3IKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAogCWptcCBlcnJvcl9jb2RlCisJQ0ZJX0VORFBS
T0MKIAogRU5UUlkoZGV2aWNlX25vdF9hdmFpbGFibGUpCisJUklORzBfSU5UX0ZSQU1FCiAJcHVz
aGwgJC0xCQkJIyBtYXJrIHRoaXMgYXMgYW4gaW50CisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQK
IAlTQVZFX0FMTAogCW1vdmwgJWNyMCwgJWVheAogCXRlc3RsICQweDQsICVlYXgJCSMgRU0gKG1h
dGggZW11bGF0aW9uIGJpdCkKQEAgLTQ3OCw5ICs2MjMsMTIgQEAgRU5UUlkoZGV2aWNlX25vdF9h
dmFpbGFibGUpCiAJam1wIHJldF9mcm9tX2V4Y2VwdGlvbgogZGV2aWNlX25vdF9hdmFpbGFibGVf
ZW11bGF0ZToKIAlwdXNobCAkMAkJCSMgdGVtcG9yYXJ5IHN0b3JhZ2UgZm9yIE9SSUdfRUlQCisJ
Q0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQKIAljYWxsIG1hdGhfZW11bGF0ZQogCWFkZGwgJDQsICVl
c3AKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgLTQKIAlqbXAgcmV0X2Zyb21fZXhjZXB0aW9uCisJ
Q0ZJX0VORFBST0MKIAogLyoKICAqIERlYnVnIHRyYXBzIGFuZCBOTUkgY2FuIGhhcHBlbiBhdCB0
aGUgb25lIFNZU0VOVEVSIGluc3RydWN0aW9uCkBAIC01MDUsMTYgKzY1MywxOSBAQCBsYWJlbDoJ
CQkJCQlcCiAJcHVzaGwgJHN5c2VudGVyX3Bhc3RfZXNwCiAKIEVOVFJZKGRlYnVnKQorCVJJTkcw
X0lOVF9GUkFNRQogCWNtcGwgJHN5c2VudGVyX2VudHJ5LCglZXNwKQogCWpuZSBkZWJ1Z19zdGFj
a19jb3JyZWN0CiAJRklYX1NUQUNLKDEyLCBkZWJ1Z19zdGFja19jb3JyZWN0LCBkZWJ1Z19lc3Bf
Zml4X2luc24pCiBkZWJ1Z19zdGFja19jb3JyZWN0OgogCXB1c2hsICQtMQkJCSMgbWFyayB0aGlz
IGFzIGFuIGludAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CiAJU0FWRV9BTEwKIAl4b3JsICVl
ZHgsJWVkeAkJCSMgZXJyb3IgY29kZSAwCiAJbW92bCAlZXNwLCVlYXgJCQkjIHB0X3JlZ3MgcG9p
bnRlcgogCWNhbGwgZG9fZGVidWcKIAlqbXAgcmV0X2Zyb21fZXhjZXB0aW9uCisJQ0ZJX0VORFBS
T0MKIAogLyoKICAqIE5NSSBpcyBkb3VibHkgbmFzdHkuIEl0IGNhbiBoYXBwZW4gX3doaWxlXyB3
ZSdyZSBoYW5kbGluZwpAQCAtNTI1LDE0ICs2NzYsMTggQEAgZGVidWdfc3RhY2tfY29ycmVjdDoK
ICAqIGZhdWx0IGhhcHBlbmVkIG9uIHRoZSBzeXNlbnRlciBwYXRoLgogICovCiBFTlRSWShubWkp
CisJUklORzBfSU5UX0ZSQU1FCiAJcHVzaGwgJWVheAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0
CiAJbW92bCAlc3MsICVlYXgKIAljbXB3ICRfX0VTUEZJWF9TUywgJWF4CiAJcG9wbCAlZWF4CisJ
Q0ZJX0FESlVTVF9DRkFfT0ZGU0VUIC00CiAJamUgbm1pXzE2Yml0X3N0YWNrCiAJY21wbCAkc3lz
ZW50ZXJfZW50cnksKCVlc3ApCiAJamUgbm1pX3N0YWNrX2ZpeHVwCiAJcHVzaGwgJWVheAorCUNG
SV9BREpVU1RfQ0ZBX09GRlNFVCA0CiAJbW92bCAlZXNwLCVlYXgKIAkvKiBEbyBub3QgYWNjZXNz
IG1lbW9yeSBhYm92ZSB0aGUgZW5kIG9mIG91ciBzdGFjayBwYWdlLAogCSAqIGl0IG1pZ2h0IG5v
dCBleGlzdC4KQEAgLTU0MCwxNiArNjk1LDE5IEBAIEVOVFJZKG5taSkKIAlhbmRsICQoVEhSRUFE
X1NJWkUtMSksJWVheAogCWNtcGwgJChUSFJFQURfU0laRS0yMCksJWVheAogCXBvcGwgJWVheAor
CUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtNAogCWphZSBubWlfc3RhY2tfY29ycmVjdAogCWNtcGwg
JHN5c2VudGVyX2VudHJ5LDEyKCVlc3ApCiAJamUgbm1pX2RlYnVnX3N0YWNrX2NoZWNrCiBubWlf
c3RhY2tfY29ycmVjdDoKIAlwdXNobCAlZWF4CisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQKIAlT
QVZFX0FMTAogCXhvcmwgJWVkeCwlZWR4CQkjIHplcm8gZXJyb3IgY29kZQogCW1vdmwgJWVzcCwl
ZWF4CQkjIHB0X3JlZ3MgcG9pbnRlcgogCWNhbGwgZG9fbm1pCiAJam1wIHJlc3RvcmVfYWxsCisJ
Q0ZJX0VORFBST0MKIAogbm1pX3N0YWNrX2ZpeHVwOgogCUZJWF9TVEFDSygxMixubWlfc3RhY2tf
Y29ycmVjdCwgMSkKQEAgLTU2Niw5MSArNzI0LDE0MyBAQCBubWlfZGVidWdfc3RhY2tfZml4dXA6
CiAJam1wIG5taV9zdGFja19jb3JyZWN0CiAKIG5taV8xNmJpdF9zdGFjazoKKwlSSU5HMF9JTlRf
RlJBTUUKIAkvKiBjcmVhdGUgdGhlIHBvaW50ZXIgdG8gbHNzIGJhY2sgKi8KIAlwdXNobCAlc3MK
KwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAogCXB1c2hsICVlc3AKKwlDRklfQURKVVNUX0NGQV9P
RkZTRVQgNAogCW1vdnp3bCAlc3AsICVlc3AKIAlhZGR3ICQ0LCAoJWVzcCkKIAkvKiBjb3B5IHRo
ZSBpcmV0IGZyYW1lIG9mIDEyIGJ5dGVzICovCiAJLnJlcHQgMwogCXB1c2hsIDE2KCVlc3ApCisJ
Q0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQKIAkuZW5kcgogCXB1c2hsICVlYXgKKwlDRklfQURKVVNU
X0NGQV9PRkZTRVQgNAogCVNBVkVfQUxMCiAJRklYVVBfRVNQRklYX1NUQUNLCQkjICVlYXggPT0g
JWVzcAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtMjAJIyB0aGUgZnJhbWUgaGFzIG5vdyBtb3Zl
ZAogCXhvcmwgJWVkeCwlZWR4CQkJIyB6ZXJvIGVycm9yIGNvZGUKIAljYWxsIGRvX25taQogCVJF
U1RPUkVfUkVHUwogCWxzcyAxMis0KCVlc3ApLCAlZXNwCQkjIGJhY2sgdG8gMTZiaXQgc3RhY2sK
IDE6CWlyZXQKKwlDRklfRU5EUFJPQwogLnNlY3Rpb24gX19leF90YWJsZSwiYSIKIAkuYWxpZ24g
NAogCS5sb25nIDFiLGlyZXRfZXhjCiAucHJldmlvdXMKIAogRU5UUlkoaW50MykKKwlSSU5HMF9J
TlRfRlJBTUUKIAlwdXNobCAkLTEJCQkjIG1hcmsgdGhpcyBhcyBhbiBpbnQKKwlDRklfQURKVVNU
X0NGQV9PRkZTRVQgNAogCVNBVkVfQUxMCiAJeG9ybCAlZWR4LCVlZHgJCSMgemVybyBlcnJvciBj
b2RlCiAJbW92bCAlZXNwLCVlYXgJCSMgcHRfcmVncyBwb2ludGVyCiAJY2FsbCBkb19pbnQzCiAJ
am1wIHJldF9mcm9tX2V4Y2VwdGlvbgorCUNGSV9FTkRQUk9DCiAKIEVOVFJZKG92ZXJmbG93KQor
CVJJTkcwX0lOVF9GUkFNRQogCXB1c2hsICQwCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQKIAlw
dXNobCAkZG9fb3ZlcmZsb3cKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAogCWptcCBlcnJvcl9j
b2RlCisJQ0ZJX0VORFBST0MKIAogRU5UUlkoYm91bmRzKQorCVJJTkcwX0lOVF9GUkFNRQogCXB1
c2hsICQwCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDQKIAlwdXNobCAkZG9fYm91bmRzCisJQ0ZJ
X0FESlVTVF9DRkFfT0ZGU0VUIDQKIAlqbXAgZXJyb3JfY29kZQorCUNGSV9FTkRQUk9DCiAKIEVO
VFJZKGludmFsaWRfb3ApCisJUklORzBfSU5UX0ZSQU1FCiAJcHVzaGwgJDAKKwlDRklfQURKVVNU
X0NGQV9PRkZTRVQgNAogCXB1c2hsICRkb19pbnZhbGlkX29wCisJQ0ZJX0FESlVTVF9DRkFfT0ZG
U0VUIDQKIAlqbXAgZXJyb3JfY29kZQorCUNGSV9FTkRQUk9DCiAKIEVOVFJZKGNvcHJvY2Vzc29y
X3NlZ21lbnRfb3ZlcnJ1bikKKwlSSU5HMF9JTlRfRlJBTUUKIAlwdXNobCAkMAorCUNGSV9BREpV
U1RfQ0ZBX09GRlNFVCA0CiAJcHVzaGwgJGRvX2NvcHJvY2Vzc29yX3NlZ21lbnRfb3ZlcnJ1bgor
CUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CiAJam1wIGVycm9yX2NvZGUKKwlDRklfRU5EUFJPQwog
CiBFTlRSWShpbnZhbGlkX1RTUykKKwlSSU5HMF9FQ19GUkFNRQogCXB1c2hsICRkb19pbnZhbGlk
X1RTUworCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CiAJam1wIGVycm9yX2NvZGUKKwlDRklfRU5E
UFJPQwogCiBFTlRSWShzZWdtZW50X25vdF9wcmVzZW50KQorCVJJTkcwX0VDX0ZSQU1FCiAJcHVz
aGwgJGRvX3NlZ21lbnRfbm90X3ByZXNlbnQKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAogCWpt
cCBlcnJvcl9jb2RlCisJQ0ZJX0VORFBST0MKIAogRU5UUlkoc3RhY2tfc2VnbWVudCkKKwlSSU5H
MF9FQ19GUkFNRQogCXB1c2hsICRkb19zdGFja19zZWdtZW50CisJQ0ZJX0FESlVTVF9DRkFfT0ZG
U0VUIDQKIAlqbXAgZXJyb3JfY29kZQorCUNGSV9FTkRQUk9DCiAKIEVOVFJZKGdlbmVyYWxfcHJv
dGVjdGlvbikKKwlSSU5HMF9FQ19GUkFNRQogCXB1c2hsICRkb19nZW5lcmFsX3Byb3RlY3Rpb24K
KwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAogCWptcCBlcnJvcl9jb2RlCisJQ0ZJX0VORFBST0MK
IAogRU5UUlkoYWxpZ25tZW50X2NoZWNrKQorCVJJTkcwX0VDX0ZSQU1FCiAJcHVzaGwgJGRvX2Fs
aWdubWVudF9jaGVjaworCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA0CiAJam1wIGVycm9yX2NvZGUK
KwlDRklfRU5EUFJPQwogCiBFTlRSWShwYWdlX2ZhdWx0KQorCVJJTkcwX0VDX0ZSQU1FCiAJcHVz
aGwgJGRvX3BhZ2VfZmF1bHQKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgNAogCWptcCBlcnJvcl9j
b2RlCisJQ0ZJX0VORFBST0MKIAogI2lmZGVmIENPTkZJR19YODZfTUNFCiBFTlRSWShtYWNoaW5l
X2NoZWNrKQorCVJJTkcwX0lOVF9GUkFNRQogCXB1c2hsICQwCisJQ0ZJX0FESlVTVF9DRkFfT0ZG
U0VUIDQKIAlwdXNobCBtYWNoaW5lX2NoZWNrX3ZlY3RvcgorCUNGSV9BREpVU1RfQ0ZBX09GRlNF
VCA0CiAJam1wIGVycm9yX2NvZGUKKwlDRklfRU5EUFJPQwogI2VuZGlmCiAKIEVOVFJZKHNwdXJp
b3VzX2ludGVycnVwdF9idWcpCisJUklORzBfSU5UX0ZSQU1FCiAJcHVzaGwgJDAKKwlDRklfQURK
VVNUX0NGQV9PRkZTRVQgNAogCXB1c2hsICRkb19zcHVyaW91c19pbnRlcnJ1cHRfYnVnCisJQ0ZJ
X0FESlVTVF9DRkFfT0ZGU0VUIDQKIAlqbXAgZXJyb3JfY29kZQorCUNGSV9FTkRQUk9DCiAKICNp
bmNsdWRlICJzeXNjYWxsX3RhYmxlLlMiCiAKZGlmZiAtTnBydSAyLjYuMTMvaW5jbHVkZS9hc20t
aTM4Ni9kd2FyZjIuaCAyLjYuMTMtaTM4Ni1jZmkvaW5jbHVkZS9hc20taTM4Ni9kd2FyZjIuaAot
LS0gMi42LjEzL2luY2x1ZGUvYXNtLWkzODYvZHdhcmYyLmgJMTk3MC0wMS0wMSAwMTowMDowMC4w
MDAwMDAwMDAgKzAxMDAKKysrIDIuNi4xMy1pMzg2LWNmaS9pbmNsdWRlL2FzbS1pMzg2L2R3YXJm
Mi5oCTIwMDUtMDYtMzAgMTQ6NDM6MDYuMDAwMDAwMDAwICswMjAwCkBAIC0wLDAgKzEsNTQgQEAK
KyNpZm5kZWYgX0RXQVJGMl9ICisjZGVmaW5lIF9EV0FSRjJfSAorCisjaW5jbHVkZSA8bGludXgv
Y29uZmlnLmg+CisKKyNpZm5kZWYgX19BU1NFTUJMWV9fCisjd2FybmluZyAiYXNtL2R3YXJmMi5o
IHNob3VsZCBiZSBvbmx5IGluY2x1ZGVkIGluIHB1cmUgYXNzZW1ibHkgZmlsZXMiCisjZW5kaWYK
KworLyoKKyAgIE1hY3JvcyBmb3IgZHdhcmYyIENGSSB1bndpbmQgdGFibGUgZW50cmllcy4KKyAg
IFNlZSAiYXMuaW5mbyIgZm9yIGRldGFpbHMgb24gdGhlc2UgcHNldWRvIG9wcy4gVW5mb3J0dW5h
dGVseQorICAgdGhleSBhcmUgb25seSBzdXBwb3J0ZWQgaW4gdmVyeSBuZXcgYmludXRpbHMsIHNv
IGRlZmluZSB0aGVtCisgICBhd2F5IGZvciBvbGRlciB2ZXJzaW9uLgorICovCisKKyNpZmRlZiBD
T05GSUdfVU5XSU5EX0lORk8KKworI2RlZmluZSBDRklfU1RBUlRQUk9DIC5jZmlfc3RhcnRwcm9j
CisjZGVmaW5lIENGSV9FTkRQUk9DIC5jZmlfZW5kcHJvYworI2RlZmluZSBDRklfREVGX0NGQSAu
Y2ZpX2RlZl9jZmEKKyNkZWZpbmUgQ0ZJX0RFRl9DRkFfUkVHSVNURVIgLmNmaV9kZWZfY2ZhX3Jl
Z2lzdGVyCisjZGVmaW5lIENGSV9ERUZfQ0ZBX09GRlNFVCAuY2ZpX2RlZl9jZmFfb2Zmc2V0Cisj
ZGVmaW5lIENGSV9BREpVU1RfQ0ZBX09GRlNFVCAuY2ZpX2FkanVzdF9jZmFfb2Zmc2V0CisjZGVm
aW5lIENGSV9PRkZTRVQgLmNmaV9vZmZzZXQKKyNkZWZpbmUgQ0ZJX1JFTF9PRkZTRVQgLmNmaV9y
ZWxfb2Zmc2V0CisjZGVmaW5lIENGSV9SRUdJU1RFUiAuY2ZpX3JlZ2lzdGVyCisjZGVmaW5lIENG
SV9SRVNUT1JFIC5jZmlfcmVzdG9yZQorI2RlZmluZSBDRklfUkVNRU1CRVJfU1RBVEUgLmNmaV9y
ZW1lbWJlcl9zdGF0ZQorI2RlZmluZSBDRklfUkVTVE9SRV9TVEFURSAuY2ZpX3Jlc3RvcmVfc3Rh
dGUKKworI2Vsc2UKKworLyogRHVlIHRvIHRoZSBzdHJ1Y3R1cmUgb2YgcHJlLWV4aXNpdGluZyBj
b2RlLCBkb24ndCB1c2UgYXNzZW1ibGVyIGxpbmUKKyAgIGNvbW1lbnQgY2hhcmFjdGVyICMgdG8g
aWdub3JlIHRoZSBhcmd1bWVudHMuIEluc3RlYWQsIHVzZSBhIGR1bW15IG1hY3JvLiAqLworLm1h
Y3JvIGlnbm9yZSBhPTAsIGI9MCwgYz0wLCBkPTAKKy5lbmRtCisKKyNkZWZpbmUgQ0ZJX1NUQVJU
UFJPQwlpZ25vcmUKKyNkZWZpbmUgQ0ZJX0VORFBST0MJaWdub3JlCisjZGVmaW5lIENGSV9ERUZf
Q0ZBCWlnbm9yZQorI2RlZmluZSBDRklfREVGX0NGQV9SRUdJU1RFUglpZ25vcmUKKyNkZWZpbmUg
Q0ZJX0RFRl9DRkFfT0ZGU0VUCWlnbm9yZQorI2RlZmluZSBDRklfQURKVVNUX0NGQV9PRkZTRVQJ
aWdub3JlCisjZGVmaW5lIENGSV9PRkZTRVQJaWdub3JlCisjZGVmaW5lIENGSV9SRUxfT0ZGU0VU
CWlnbm9yZQorI2RlZmluZSBDRklfUkVHSVNURVIJaWdub3JlCisjZGVmaW5lIENGSV9SRVNUT1JF
CWlnbm9yZQorI2RlZmluZSBDRklfUkVNRU1CRVJfU1RBVEUgaWdub3JlCisjZGVmaW5lIENGSV9S
RVNUT1JFX1NUQVRFIGlnbm9yZQorCisjZW5kaWYKKworI2VuZGlmCmRpZmYgLU5wcnUgMi42LjEz
L2xpYi9LY29uZmlnLmRlYnVnIDIuNi4xMy1pMzg2LWNmaS9saWIvS2NvbmZpZy5kZWJ1ZwotLS0g
Mi42LjEzL2xpYi9LY29uZmlnLmRlYnVnCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICsw
MjAwCisrKyAyLjYuMTMtaTM4Ni1jZmkvbGliL0tjb25maWcuZGVidWcJMjAwNS0wOS0wNyAxMzoy
NjoxOC4wMDAwMDAwMDAgKzAyMDAKQEAgLTE1OSwzICsxNTksMTIgQEAgY29uZmlnIEZSQU1FX1BP
SU5URVIKIAkgIElmIHlvdSBkb24ndCBkZWJ1ZyB0aGUga2VybmVsLCB5b3UgY2FuIHNheSBOLCBi
dXQgd2UgbWF5IG5vdCBiZSBhYmxlCiAJICB0byBzb2x2ZSBwcm9ibGVtcyB3aXRob3V0IGZyYW1l
IHBvaW50ZXJzLgogCitjb25maWcgVU5XSU5EX0lORk8KKwlib29sICJDb21waWxlIHRoZSBrZXJu
ZWwgd2l0aCBmcmFtZSB1bndpbmQgaW5mb3JtYXRpb24iIGlmICFJQTY0CisJZGVmYXVsdCBERUJV
R19LRVJORUwgJiYgIUlBNjQKKwloZWxwCisJICBJZiB5b3Ugc2F5IFkgaGVyZSB0aGUgcmVzdWx0
aW5nIGtlcm5lbCBpbWFnZSB3aWxsIGJlIHNsaWdodGx5IGxhcmdlcgorCSAgYnV0IG5vdCBzbG93
ZXIsIGFuZCBpdCB3aWxsIGdpdmUgdmVyeSB1c2VmdWwgZGVidWdnaW5nIGluZm9ybWF0aW9uLgor
CSAgSWYgeW91IGRvbid0IGRlYnVnIHRoZSBrZXJuZWwsIHlvdSBjYW4gc2F5IE4sIGJ1dCB3ZSBt
YXkgbm90IGJlIGFibGUKKwkgIHRvIHNvbHZlIHByb2JsZW1zIHdpdGhvdXQgZnJhbWUgdW53aW5k
IGluZm9ybWF0aW9uIG9yIGZyYW1lIHBvaW50ZXJzLgorCmRpZmYgLU5wcnUgMi42LjEzL01ha2Vm
aWxlIDIuNi4xMy1pMzg2LWNmaS9NYWtlZmlsZQotLS0gMi42LjEzL01ha2VmaWxlCTIwMDUtMDgt
MjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMtaTM4Ni1jZmkvTWFrZWZpbGUJ
MjAwNS0wOS0wNyAxMzoyNTo1NC4wMDAwMDAwMDAgKzAyMDAKQEAgLTUxNyw2ICs1MTcsMTAgQEAg
Q0ZMQUdTCQkrPSAkKGNhbGwgYWRkLWFsaWduLENPTkZJR19DQ19BTAogQ0ZMQUdTCQkrPSAkKGNh
bGwgYWRkLWFsaWduLENPTkZJR19DQ19BTElHTl9MT09QUywtbG9vcHMpCiBDRkxBR1MJCSs9ICQo
Y2FsbCBhZGQtYWxpZ24sQ09ORklHX0NDX0FMSUdOX0pVTVBTLC1qdW1wcykKIAoraWZkZWYgQ09O
RklHX1VOV0lORF9JTkZPCitDRkxBR1MJCSs9IC1mYXN5bmNocm9ub3VzLXVud2luZC10YWJsZXMK
K2VuZGlmCisKIGlmZGVmIENPTkZJR19GUkFNRV9QT0lOVEVSCiBDRkxBR1MJCSs9IC1mbm8tb21p
dC1mcmFtZS1wb2ludGVyICQoY2FsbCBjYy1vcHRpb24sLWZuby1vcHRpbWl6ZS1zaWJsaW5nLWNh
bGxzLCkKIGVsc2UK

--=__Part2A084475.0__=--
