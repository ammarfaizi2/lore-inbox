Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750826AbWEVNTE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750826AbWEVNTE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 May 2006 09:19:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWEVNTE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 May 2006 09:19:04 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:31519
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1750826AbWEVNTB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 May 2006 09:19:01 -0400
Message-Id: <4471D691.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Mon, 22 May 2006 15:19:45 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: "Ingo Molnar" <mingo@elte.hu>, <linux-kernel@vger.kernel.org>,
       <discuss@x86-64.org>
Subject: [PATCH 6/6] reliable stack trace support (i386 entry.S
	annotations)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

To increase the usefulness of reliable stack unwinding, this adds CFI
unwind annotations to many low-level i386 routines.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

Index: unwind-2.6.17-rc4/arch/i386/kernel/entry.S
===================================================================
--- unwind-2.6.17-rc4.orig/arch/i386/kernel/entry.S	2006-05-22 15:08:35.000000000 +0200
+++ unwind-2.6.17-rc4/arch/i386/kernel/entry.S	2006-05-22 15:08:38.000000000 +0200
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
    the vsyscall page.  See vsyscall-sysentry.S, which defines the symbol.  */
 
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
+	RING0_INT_FRAME			# can't unwind into user space anyway
 	pushl %eax			# save orig_eax
+	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
 	testl $TF_MASK,EFLAGS(%esp)
@@ -256,10 +341,12 @@ restore_all:
 	movb CS(%esp), %al
 	andl $(VM_MASK | (4 << 8) | 3), %eax
 	cmpl $((4 << 8) | 3), %eax
+	CFI_REMEMBER_STATE
 	je ldt_ss			# returning to user-space with LDT SS
 restore_nocheck:
 	RESTORE_REGS
 	addl $4, %esp
+	CFI_ADJUST_CFA_OFFSET -4
 1:	iret
 .section .fixup,"ax"
 iret_exc:
@@ -273,6 +360,7 @@ iret_exc:
 	.long 1b,iret_exc
 .previous
 
+	CFI_RESTORE_STATE
 ldt_ss:
 	larl OLDSS(%esp), %eax
 	jnz restore_nocheck
@@ -285,11 +373,13 @@ ldt_ss:
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
@@ -297,9 +387,11 @@ ldt_ss:
 	.align 4
 	.long 1b,iret_exc
 .previous
+	CFI_ENDPROC
 
 	# perform work that needs to be done immediately before resumption
 	ALIGN
+	RING0_PTREGS_FRAME		# can't unwind into user space anyway
 work_pending:
 	testb $_TIF_NEED_RESCHED, %cl
 	jz work_notifysig
@@ -329,8 +421,10 @@ work_notifysig:				# deal with pending s
 work_notifysig_v86:
 #ifdef CONFIG_VM86
 	pushl %ecx			# save ti_flags for do_notify_resume
+	CFI_ADJUST_CFA_OFFSET 4
 	call save_v86_state		# %eax contains pt_regs pointer
 	popl %ecx
+	CFI_ADJUST_CFA_OFFSET -4
 	movl %eax, %esp
 	xorl %edx, %edx
 	call do_notify_resume
@@ -363,19 +457,21 @@ syscall_exit_work:
 	movl $1, %edx
 	call do_syscall_trace
 	jmp resume_userspace
+	CFI_ENDPROC
 
-	ALIGN
+	RING0_INT_FRAME			# can't unwind into user space anyway
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
@@ -387,16 +483,21 @@ syscall_badsys:
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
@@ -408,9 +509,14 @@ ENTRY(interrupt)
 
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
@@ -424,60 +530,99 @@ common_interrupt:
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
@@ -487,9 +632,12 @@ ENTRY(device_not_available)
 	jmp ret_from_exception
 device_not_available_emulate:
 	pushl $0			# temporary storage for ORIG_EIP
+	CFI_ADJUST_CFA_OFFSET 4
 	call math_emulate
 	addl $4, %esp
+	CFI_ADJUST_CFA_OFFSET -4
 	jmp ret_from_exception
+	CFI_ENDPROC
 
 /*
  * Debug traps and NMI can happen at the one SYSENTER instruction
@@ -514,16 +662,19 @@ label:						\
 	pushl $sysenter_past_esp
 
 KPROBE_ENTRY(debug)
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
 	.previous .text
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
@@ -534,14 +685,18 @@ debug_stack_correct:
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
@@ -549,16 +704,19 @@ ENTRY(nmi)
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
Index: unwind-2.6.17-rc4/include/asm-i386/dwarf2.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ unwind-2.6.17-rc4/include/asm-i386/dwarf2.h	2006-05-22 15:08:38.000000000 +0200
@@ -0,0 +1,54 @@
+#ifndef _DWARF2_H
+#define _DWARF2_H
+
+#include <linux/config.h>
+
+#ifndef __ASSEMBLY__
+#warning "asm/dwarf2.h should be only included in pure assembly files"
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
+/* Due to the structure of pre-exisiting code, don't use assembler line
+   comment character # to ignore the arguments. Instead, use a dummy macro. */
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


