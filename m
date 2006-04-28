Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030421AbWD1Ozi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030421AbWD1Ozi (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Apr 2006 10:55:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030425AbWD1Ozi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Apr 2006 10:55:38 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:42339
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S1030421AbWD1Ozh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Apr 2006 10:55:37 -0400
Message-Id: <44524940.76E4.0078.0@novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0.1 Beta 
Date: Fri, 28 Apr 2006 16:56:32 +0200
From: "Jan Beulich" <jbeulich@novell.com>
To: <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: add END()/ENDPROC() annotations to entry.S
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Since END()/ENDPROC() are now available, add respective annotations to
i386's entry.S. This should help debugging activities.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/arch/i386/kernel/entry.S
2.6.17-rc3-i386-asm-types-sizes/arch/i386/kernel/entry.S
--- /home/jbeulich/tmp/linux-2.6.17-rc3/arch/i386/kernel/entry.S	2006-04-28 11:47:26.000000000 +0200
+++ 2.6.17-rc3-i386-asm-types-sizes/arch/i386/kernel/entry.S	2006-04-28 12:08:19.000000000 +0200
@@ -129,6 +129,7 @@ ENTRY(ret_from_fork)
 	GET_THREAD_INFO(%ebp)
 	popl %eax
 	jmp syscall_exit
+END(ret_from_fork)
 
 /*
  * Return to user mode is not as complex as all this looks,
@@ -156,6 +157,7 @@ ENTRY(resume_userspace)
 					# int/exception return?
 	jne work_pending
 	jmp restore_all
+END(ret_from_exception)
 
 #ifdef CONFIG_PREEMPT
 ENTRY(resume_kernel)
@@ -170,6 +172,7 @@ need_resched:
 	jz restore_all
 	call preempt_schedule_irq
 	jmp need_resched
+END(resume_kernel)
 #endif
 
 /* SYSENTER_RETURN points to after the "sysenter" instruction in
@@ -219,6 +222,7 @@ sysenter_past_esp:
 	xorl %ebp,%ebp
 	sti
 	sysexit
+ENDPROC(sysenter_entry)
 
 
 	# system call handler stub
@@ -272,6 +276,7 @@ iret_exc:
 	.align 4
 	.long 1b,iret_exc
 .previous
+ENDPROC(system_call)
 
 ldt_ss:
 	larl OLDSS(%esp), %eax
@@ -297,6 +302,7 @@ ldt_ss:
 	.align 4
 	.long 1b,iret_exc
 .previous
+END(ldt_ss)
 
 	# perform work that needs to be done immediately before resumption
 	ALIGN
@@ -336,6 +342,7 @@ work_notifysig_v86:
 	call do_notify_resume
 	jmp resume_userspace
 #endif
+END(work_pending)
 
 	# perform syscall exit tracing
 	ALIGN
@@ -351,6 +358,7 @@ syscall_trace_entry:
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
+END(syscall_trace_entry)
 
 	# perform syscall exit tracing
 	ALIGN
@@ -363,6 +371,7 @@ syscall_exit_work:
 	movl $1, %edx
 	call do_syscall_trace
 	jmp resume_userspace
+END(syscall_exit_work)
 
 	ALIGN
 syscall_fault:
@@ -371,11 +380,13 @@ syscall_fault:
 	GET_THREAD_INFO(%ebp)
 	movl $-EFAULT,EAX(%esp)
 	jmp resume_userspace
+END(syscall_fault)
 
 	ALIGN
 syscall_badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
+END(syscall_badsys)
 
 #define FIXUP_ESPFIX_STACK \
 	movl %esp, %eax; \
@@ -417,6 +428,11 @@ ENTRY(irq_entries_start)
 .text
 vector=vector+1
 .endr
+END(irq_entries_start)
+
+.data
+END(interrupt)
+.text
 
 	ALIGN
 common_interrupt:
@@ -424,6 +440,7 @@ common_interrupt:
 	movl %esp,%eax
 	call do_IRQ
 	jmp ret_from_intr
+ENDPROC(common_interrupt)
 
 #define BUILD_INTERRUPT(name, nr)	\
 ENTRY(name)				\
@@ -431,7 +448,8 @@ ENTRY(name)				\
 	SAVE_ALL			\
 	movl %esp,%eax;			\
 	call smp_/**/name;		\
-	jmp ret_from_intr;
+	jmp ret_from_intr;		\
+ENDPROC(name)
 
 /* The include is where all of the SMP etc. interrupts come from */
 #include "entry_arch.h"
@@ -439,6 +457,7 @@ ENTRY(name)				\
 ENTRY(divide_error)
 	pushl $0			# no error code
 	pushl $do_divide_error
+END(divide_error)
 	ALIGN
 error_code:
 	pushl %ds
@@ -465,16 +484,19 @@ error_code:
 	movl %esp,%eax			# pt_regs pointer
 	call *%edi
 	jmp ret_from_exception
+ENDPROC(error_code)
 
 ENTRY(coprocessor_error)
 	pushl $0
 	pushl $do_coprocessor_error
 	jmp error_code
+END(coprocessor_error)
 
 ENTRY(simd_coprocessor_error)
 	pushl $0
 	pushl $do_simd_coprocessor_error
 	jmp error_code
+END(simd_coprocessor_error)
 
 ENTRY(device_not_available)
 	pushl $-1			# mark this as an int
@@ -490,6 +512,7 @@ device_not_available_emulate:
 	call math_emulate
 	addl $4, %esp
 	jmp ret_from_exception
+END(device_not_available)
 
 /*
  * Debug traps and NMI can happen at the one SYSENTER instruction
@@ -524,6 +547,7 @@ debug_stack_correct:
 	movl %esp,%eax			# pt_regs pointer
 	call do_debug
 	jmp ret_from_exception
+END(debug)
 	.previous .text
 /*
  * NMI is doubly nasty. It can happen _while_ we're handling
@@ -595,6 +619,7 @@ nmi_16bit_stack:
 	.align 4
 	.long 1b,iret_exc
 .previous
+ENDPROC(nmi)
 
 KPROBE_ENTRY(int3)
 	pushl $-1			# mark this as an int
@@ -603,52 +628,63 @@ KPROBE_ENTRY(int3)
 	movl %esp,%eax		# pt_regs pointer
 	call do_int3
 	jmp ret_from_exception
+END(int3)
 	.previous .text
 
 ENTRY(overflow)
 	pushl $0
 	pushl $do_overflow
 	jmp error_code
+END(overflow)
 
 ENTRY(bounds)
 	pushl $0
 	pushl $do_bounds
 	jmp error_code
+END(bounds)
 
 ENTRY(invalid_op)
 	pushl $0
 	pushl $do_invalid_op
 	jmp error_code
+END(invalid_op)
 
 ENTRY(coprocessor_segment_overrun)
 	pushl $0
 	pushl $do_coprocessor_segment_overrun
 	jmp error_code
+END(coprocessor_segment_overrun)
 
 ENTRY(invalid_TSS)
 	pushl $do_invalid_TSS
 	jmp error_code
+END(invalid_TSS)
 
 ENTRY(segment_not_present)
 	pushl $do_segment_not_present
 	jmp error_code
+END(segment_not_present)
 
 ENTRY(stack_segment)
 	pushl $do_stack_segment
 	jmp error_code
+END(stack_segment)
 
 KPROBE_ENTRY(general_protection)
 	pushl $do_general_protection
 	jmp error_code
+END(general_protection)
 	.previous .text
 
 ENTRY(alignment_check)
 	pushl $do_alignment_check
 	jmp error_code
+END(alignment_check)
 
 KPROBE_ENTRY(page_fault)
 	pushl $do_page_fault
 	jmp error_code
+END(page_fault)
 	.previous .text
 
 #ifdef CONFIG_X86_MCE
@@ -656,12 +692,14 @@ ENTRY(machine_check)
 	pushl $0
 	pushl machine_check_vector
 	jmp error_code
+END(machine_check)
 #endif
 
 ENTRY(spurious_interrupt_bug)
 	pushl $0
 	pushl $do_spurious_interrupt_bug
 	jmp error_code
+END(spurious_interrupt_bug)
 
 .section .rodata,"a"
 #include "syscall_table.S"
diff -Npru /home/jbeulich/tmp/linux-2.6.17-rc3/arch/i386/kernel/syscall_table.S
2.6.17-rc3-i386-asm-types-sizes/arch/i386/kernel/syscall_table.S
--- /home/jbeulich/tmp/linux-2.6.17-rc3/arch/i386/kernel/syscall_table.S	2006-04-28 11:47:26.000000000 +0200
+++ 2.6.17-rc3-i386-asm-types-sizes/arch/i386/kernel/syscall_table.S	2006-04-28 12:08:59.000000000 +0200
@@ -315,3 +315,4 @@ ENTRY(sys_call_table)
 	.long sys_splice
 	.long sys_sync_file_range
 	.long sys_tee			/* 315 */
+END(sys_call_table)


