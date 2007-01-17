Return-Path: <linux-kernel-owner+w=401wt.eu-S1751713AbXAQHrT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751713AbXAQHrT (ORCPT <rfc822;w@1wt.eu>);
	Wed, 17 Jan 2007 02:47:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751728AbXAQHrS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Jan 2007 02:47:18 -0500
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:20702
	"EHLO public.id2-vpn.continvity.gns.novell.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751713AbXAQHrS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Jan 2007 02:47:18 -0500
Message-Id: <45ADE2FC.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 
Date: Wed, 17 Jan 2007 07:49:00 +0000
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: entry.S END/ENDPROC annotations
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Annotate i386/kernel/entry.S with END/ENDPROC to assist disassemblers and
other analysis tools.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

--- linux-2.6.20-rc5/arch/i386/kernel/entry.S	2007-01-15 14:09:19.000000000 +0100
+++ 2.6.20-rc5-i386-entry-end/arch/i386/kernel/entry.S	2007-01-04 14:46:47.000000000 +0100
@@ -227,6 +227,7 @@ ENTRY(ret_from_fork)
 	CFI_ADJUST_CFA_OFFSET -4
 	jmp syscall_exit
 	CFI_ENDPROC
+END(ret_from_fork)
 
 /*
  * Return to user mode is not as complex as all this looks,
@@ -258,6 +259,7 @@ ENTRY(resume_userspace)
 					# int/exception return?
 	jne work_pending
 	jmp restore_all
+END(ret_from_exception)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
@@ -272,6 +274,7 @@ need_resched:
 	jz restore_all
 	call preempt_schedule_irq
 	jmp need_resched
+END(resume_kernel)
 #endif
 	CFI_ENDPROC
 
@@ -355,6 +358,7 @@ sysenter_past_esp:
 	.align 4
 	.long 1b,2b
 .popsection
+ENDPROC(sysenter_entry)
 
 	# system call handler stub
 ENTRY(system_call)
@@ -455,6 +459,7 @@ ldt_ss:
 	CFI_ADJUST_CFA_OFFSET -8
 	jmp restore_nocheck
 	CFI_ENDPROC
+ENDPROC(system_call)
 
 	# perform work that needs to be done immediately before resumption
 	ALIGN
@@ -500,6 +505,7 @@ work_notifysig_v86:
 	xorl %edx, %edx
 	call do_notify_resume
 	jmp resume_userspace_sig
+END(work_pending)
 
 	# perform syscall exit tracing
 	ALIGN
@@ -515,6 +521,7 @@ syscall_trace_entry:
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
+END(syscall_trace_entry)
 
 	# perform syscall exit tracing
 	ALIGN
@@ -528,6 +535,7 @@ syscall_exit_work:
 	movl $1, %edx
 	call do_syscall_trace
 	jmp resume_userspace
+END(syscall_exit_work)
 	CFI_ENDPROC
 
 	RING0_INT_FRAME			# can't unwind into user space anyway
@@ -538,10 +546,12 @@ syscall_fault:
 	GET_THREAD_INFO(%ebp)
 	movl $-EFAULT,PT_EAX(%esp)
 	jmp resume_userspace
+END(syscall_fault)
 
 syscall_badsys:
 	movl $-ENOSYS,PT_EAX(%esp)
 	jmp resume_userspace
+END(syscall_badsys)
 	CFI_ENDPROC
 
 #define FIXUP_ESPFIX_STACK \
@@ -577,9 +587,9 @@ syscall_badsys:
 ENTRY(interrupt)
 .text
 
-vector=0
 ENTRY(irq_entries_start)
 	RING0_INT_FRAME
+vector=0
 .rept NR_IRQS
 	ALIGN
  .if vector
@@ -588,11 +598,16 @@ ENTRY(irq_entries_start)
 1:	pushl $~(vector)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp common_interrupt
-.data
+ .previous
 	.long 1b
-.text
+ .text
 vector=vector+1
 .endr
+END(irq_entries_start)
+
+.previous
+END(interrupt)
+.previous
 
 /*
  * the CPU automatically disables interrupts when executing an IRQ vector,
@@ -605,6 +620,7 @@ common_interrupt:
 	movl %esp,%eax
 	call do_IRQ
 	jmp ret_from_intr
+ENDPROC(common_interrupt)
 	CFI_ENDPROC
 
 #define BUILD_INTERRUPT(name, nr)	\
@@ -617,7 +633,8 @@ ENTRY(name)				\
 	movl %esp,%eax;			\
 	call smp_/**/name;		\
 	jmp ret_from_intr;		\
-	CFI_ENDPROC
+	CFI_ENDPROC;			\
+ENDPROC(name)
 
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
@@ -688,6 +705,7 @@ ENTRY(coprocessor_error)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(coprocessor_error)
 
 ENTRY(simd_coprocessor_error)
 	RING0_INT_FRAME
@@ -697,6 +715,7 @@ ENTRY(simd_coprocessor_error)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(simd_coprocessor_error)
 
 ENTRY(device_not_available)
 	RING0_INT_FRAME
@@ -717,6 +736,7 @@ device_not_available_emulate:
 	CFI_ADJUST_CFA_OFFSET -4
 	jmp ret_from_exception
 	CFI_ENDPROC
+END(device_not_available)
 
 /*
  * Debug traps and NMI can happen at the one SYSENTER instruction
@@ -860,10 +880,12 @@ ENTRY(native_iret)
 	.align 4
 	.long 1b,iret_exc
 .previous
+END(native_iret)
 
 ENTRY(native_irq_enable_sysexit)
 	sti
 	sysexit
+END(native_irq_enable_sysexit)
 #endif
 
 KPROBE_ENTRY(int3)
@@ -886,6 +908,7 @@ ENTRY(overflow)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(overflow)
 
 ENTRY(bounds)
 	RING0_INT_FRAME
@@ -895,6 +918,7 @@ ENTRY(bounds)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(bounds)
 
 ENTRY(invalid_op)
 	RING0_INT_FRAME
@@ -904,6 +928,7 @@ ENTRY(invalid_op)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(invalid_op)
 
 ENTRY(coprocessor_segment_overrun)
 	RING0_INT_FRAME
@@ -913,6 +938,7 @@ ENTRY(coprocessor_segment_overrun)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(coprocessor_segment_overrun)
 
 ENTRY(invalid_TSS)
 	RING0_EC_FRAME
@@ -920,6 +946,7 @@ ENTRY(invalid_TSS)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(invalid_TSS)
 
 ENTRY(segment_not_present)
 	RING0_EC_FRAME
@@ -927,6 +954,7 @@ ENTRY(segment_not_present)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(segment_not_present)
 
 ENTRY(stack_segment)
 	RING0_EC_FRAME
@@ -934,6 +962,7 @@ ENTRY(stack_segment)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(stack_segment)
 
 KPROBE_ENTRY(general_protection)
 	RING0_EC_FRAME
@@ -949,6 +978,7 @@ ENTRY(alignment_check)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(alignment_check)
 
 ENTRY(divide_error)
 	RING0_INT_FRAME
@@ -958,6 +988,7 @@ ENTRY(divide_error)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(divide_error)
 
 #ifdef CONFIG_X86_MCE
 ENTRY(machine_check)
@@ -968,6 +999,7 @@ ENTRY(machine_check)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(machine_check)
 #endif
 
 ENTRY(spurious_interrupt_bug)
@@ -978,6 +1010,7 @@ ENTRY(spurious_interrupt_bug)
 	CFI_ADJUST_CFA_OFFSET 4
 	jmp error_code
 	CFI_ENDPROC
+END(spurious_interrupt_bug)
 
 ENTRY(kernel_thread_helper)
 	pushl $0		# fake return address for unwinder


