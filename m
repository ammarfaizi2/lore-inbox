Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751213AbWIAGsq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751213AbWIAGsq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Sep 2006 02:48:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751230AbWIAGsq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Sep 2006 02:48:46 -0400
Received: from gw.goop.org ([64.81.55.164]:63429 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751213AbWIAGsp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Sep 2006 02:48:45 -0400
Message-Id: <20060901064822.240326224@goop.org>
References: <20060901064718.918494029@goop.org>
User-Agent: quilt/0.45-1
Date: Thu, 31 Aug 2006 23:47:19 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: linux-kernel@vger.kernel.org
Cc: Chuck Ebbert <76306.1226@compuserve.com>, Zachary Amsden <zach@vmware.com>,
       Jan Beulich <jbeulich@novell.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, Keith Owens <kaos@ocs.com.au>
Subject: [PATCH 1/8] Use asm-offsets for the offsets of registers into the pt_regs struct, rather than having hard-coded constants.
Content-Disposition: inline; filename=pt_regs-asm-offsets.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I left the constants in the comments of entry.S because they're useful
for reference; the code in entry.S is very dependent on the layout of
pt_regs, even when using asm-offsets.

Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Cc: Keith Owens <kaos@ocs.com.au>

[ This is identical to the previously posted version of the patch. ]

---
 arch/i386/kernel/asm-offsets.c |   17 +++++
 arch/i386/kernel/entry.S       |  118 +++++++++++++++++-----------------------
 2 files changed, 68 insertions(+), 67 deletions(-)


===================================================================
--- a/arch/i386/kernel/asm-offsets.c
+++ b/arch/i386/kernel/asm-offsets.c
@@ -58,6 +58,23 @@ void foo(void)
 	OFFSET(TI_sysenter_return, thread_info, sysenter_return);
 	BLANK();
 
+	OFFSET(PT_EBX, pt_regs, ebx);
+	OFFSET(PT_ECX, pt_regs, ecx);
+	OFFSET(PT_EDX, pt_regs, edx);
+	OFFSET(PT_ESI, pt_regs, esi);
+	OFFSET(PT_EDI, pt_regs, edi);
+	OFFSET(PT_EBP, pt_regs, ebp);
+	OFFSET(PT_EAX, pt_regs, eax);
+	OFFSET(PT_DS,  pt_regs, xds);
+	OFFSET(PT_ES,  pt_regs, xes);
+	OFFSET(PT_ORIG_EAX, pt_regs, orig_eax);
+	OFFSET(PT_EIP, pt_regs, eip);
+	OFFSET(PT_CS,  pt_regs, xcs);
+	OFFSET(PT_EFLAGS, pt_regs, eflags);
+	OFFSET(PT_OLDESP, pt_regs, esp);
+	OFFSET(PT_OLDSS,  pt_regs, xss);
+	BLANK();
+
 	OFFSET(EXEC_DOMAIN_handler, exec_domain, handler);
 	OFFSET(RT_SIGFRAME_sigcontext, rt_sigframe, uc.uc_mcontext);
 	BLANK();
===================================================================
--- a/arch/i386/kernel/entry.S
+++ b/arch/i386/kernel/entry.S
@@ -53,22 +53,6 @@
 
 #define nr_syscalls ((syscall_table_size)/4)
 
-EBX		= 0x00
-ECX		= 0x04
-EDX		= 0x08
-ESI		= 0x0C
-EDI		= 0x10
-EBP		= 0x14
-EAX		= 0x18
-DS		= 0x1C
-ES		= 0x20
-ORIG_EAX	= 0x24
-EIP		= 0x28
-CS		= 0x2C
-EFLAGS		= 0x30
-OLDESP		= 0x34
-OLDSS		= 0x38
-
 CF_MASK		= 0x00000001
 TF_MASK		= 0x00000100
 IF_MASK		= 0x00000200
@@ -92,7 +76,7 @@ VM_MASK		= 0x00020000
 
 .macro TRACE_IRQS_IRET
 #ifdef CONFIG_TRACE_IRQFLAGS
-	testl $IF_MASK,EFLAGS(%esp)     # interrupts off?
+	testl $IF_MASK,PT_EFLAGS(%esp)     # interrupts off?
 	jz 1f
 	TRACE_IRQS_ON
 1:
@@ -195,18 +179,18 @@ 4:	movl $0,(%esp);	\
 
 #define RING0_PTREGS_FRAME \
 	CFI_STARTPROC simple;\
-	CFI_DEF_CFA esp, OLDESP-EBX;\
-	/*CFI_OFFSET cs, CS-OLDESP;*/\
-	CFI_OFFSET eip, EIP-OLDESP;\
-	/*CFI_OFFSET es, ES-OLDESP;*/\
-	/*CFI_OFFSET ds, DS-OLDESP;*/\
-	CFI_OFFSET eax, EAX-OLDESP;\
-	CFI_OFFSET ebp, EBP-OLDESP;\
-	CFI_OFFSET edi, EDI-OLDESP;\
-	CFI_OFFSET esi, ESI-OLDESP;\
-	CFI_OFFSET edx, EDX-OLDESP;\
-	CFI_OFFSET ecx, ECX-OLDESP;\
-	CFI_OFFSET ebx, EBX-OLDESP
+	CFI_DEF_CFA esp, PT_OLDESP-PT_EBX;\
+	/*CFI_OFFSET cs, PT_CS-PT_OLDESP;*/\
+	CFI_OFFSET eip, PT_EIP-PT_OLDESP;\
+	/*CFI_OFFSET es, PT_ES-PT_OLDESP;*/\
+	/*CFI_OFFSET ds, PT_DS-PT_OLDESP;*/\
+	CFI_OFFSET eax, PT_EAX-PT_OLDESP;\
+	CFI_OFFSET ebp, PT_EBP-PT_OLDESP;\
+	CFI_OFFSET edi, PT_EDI-PT_OLDESP;\
+	CFI_OFFSET esi, PT_ESI-PT_OLDESP;\
+	CFI_OFFSET edx, PT_EDX-PT_OLDESP;\
+	CFI_OFFSET ecx, PT_ECX-PT_OLDESP;\
+	CFI_OFFSET ebx, PT_EBX-PT_OLDESP
 
 ENTRY(ret_from_fork)
 	CFI_STARTPROC
@@ -234,8 +218,8 @@ ret_from_intr:
 ret_from_intr:
 	GET_THREAD_INFO(%ebp)
 check_userspace:
-	movl EFLAGS(%esp), %eax		# mix EFLAGS and CS
-	movb CS(%esp), %al
+	movl PT_EFLAGS(%esp), %eax	# mix EFLAGS and CS
+	movb PT_CS(%esp), %al
 	andl $(VM_MASK | SEGMENT_RPL_MASK), %eax
 	cmpl $USER_RPL, %eax
 	jb resume_kernel		# not returning to v8086 or userspace
@@ -258,7 +242,7 @@ need_resched:
 	movl TI_flags(%ebp), %ecx	# need_resched set ?
 	testb $_TIF_NEED_RESCHED, %cl
 	jz restore_all
-	testl $IF_MASK,EFLAGS(%esp)     # interrupts off (exception path) ?
+	testl $IF_MASK,PT_EFLAGS(%esp)	# interrupts off (exception path) ?
 	jz restore_all
 	call preempt_schedule_irq
 	jmp need_resched
@@ -323,15 +307,15 @@ 1:	movl (%ebp),%ebp
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 	call *sys_call_table(,%eax,4)
-	movl %eax,EAX(%esp)
+	movl %eax,PT_EAX(%esp)
 	DISABLE_INTERRUPTS
 	TRACE_IRQS_OFF
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
 /* if something modifies registers it must also disable sysexit */
-	movl EIP(%esp), %edx
-	movl OLDESP(%esp), %ecx
+	movl PT_EIP(%esp), %edx
+	movl PT_OLDESP(%esp), %ecx
 	xorl %ebp,%ebp
 	TRACE_IRQS_ON
 	ENABLE_INTERRUPTS_SYSEXIT
@@ -345,7 +329,7 @@ ENTRY(system_call)
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
-	testl $TF_MASK,EFLAGS(%esp)
+	testl $TF_MASK,PT_EFLAGS(%esp)
 	jz no_singlestep
 	orl $_TIF_SINGLESTEP,TI_flags(%ebp)
 no_singlestep:
@@ -357,7 +341,7 @@ no_singlestep:
 	jae syscall_badsys
 syscall_call:
 	call *sys_call_table(,%eax,4)
-	movl %eax,EAX(%esp)		# store the return value
+	movl %eax,PT_EAX(%esp)		# store the return value
 syscall_exit:
 	DISABLE_INTERRUPTS		# make sure we don't miss an interrupt
 					# setting need_resched or sigpending
@@ -368,12 +352,12 @@ syscall_exit:
 	jne syscall_exit_work
 
 restore_all:
-	movl EFLAGS(%esp), %eax		# mix EFLAGS, SS and CS
-	# Warning: OLDSS(%esp) contains the wrong/random values if we
+	movl PT_EFLAGS(%esp), %eax	# mix EFLAGS, SS and CS
+	# Warning: PT_OLDSS(%esp) contains the wrong/random values if we
 	# are returning to the kernel.
 	# See comments in process.c:copy_thread() for details.
-	movb OLDSS(%esp), %ah
-	movb CS(%esp), %al
+	movb PT_OLDSS(%esp), %ah
+	movb PT_CS(%esp), %al
 	andl $(VM_MASK | (SEGMENT_TI_MASK << 8) | SEGMENT_RPL_MASK), %eax
 	cmpl $((SEGMENT_LDT << 8) | USER_RPL), %eax
 	CFI_REMEMBER_STATE
@@ -400,7 +384,7 @@ iret_exc:
 
 	CFI_RESTORE_STATE
 ldt_ss:
-	larl OLDSS(%esp), %eax
+	larl PT_OLDSS(%esp), %eax
 	jnz restore_nocheck
 	testl $0x00400000, %eax		# returning to 32bit stack?
 	jnz restore_nocheck		# allright, normal return
@@ -450,7 +434,7 @@ work_resched:
 
 work_notifysig:				# deal with pending signals and
 					# notify-resume requests
-	testl $VM_MASK, EFLAGS(%esp)
+	testl $VM_MASK, PT_EFLAGS(%esp)
 	movl %esp, %eax
 	jne work_notifysig_v86		# returning to kernel-space or
 					# vm86-space
@@ -475,14 +459,14 @@ work_notifysig_v86:
 	# perform syscall exit tracing
 	ALIGN
 syscall_trace_entry:
-	movl $-ENOSYS,EAX(%esp)
+	movl $-ENOSYS,PT_EAX(%esp)
 	movl %esp, %eax
 	xorl %edx,%edx
 	call do_syscall_trace
 	cmpl $0, %eax
 	jne resume_userspace		# ret != 0 -> running under PTRACE_SYSEMU,
 					# so must skip actual syscall
-	movl ORIG_EAX(%esp), %eax
+	movl PT_ORIG_EAX(%esp), %eax
 	cmpl $(nr_syscalls), %eax
 	jnae syscall_call
 	jmp syscall_exit
@@ -507,11 +491,11 @@ syscall_fault:
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
-	movl $-EFAULT,EAX(%esp)
+	movl $-EFAULT,PT_EAX(%esp)
 	jmp resume_userspace
 
 syscall_badsys:
-	movl $-ENOSYS,EAX(%esp)
+	movl $-ENOSYS,PT_EAX(%esp)
 	jmp resume_userspace
 	CFI_ENDPROC
 
@@ -634,10 +618,10 @@ error_code:
 	popl %ecx
 	CFI_ADJUST_CFA_OFFSET -4
 	/*CFI_REGISTER es, ecx*/
-	movl ES(%esp), %edi		# get the function address
-	movl ORIG_EAX(%esp), %edx	# get the error code
-	movl %eax, ORIG_EAX(%esp)
-	movl %ecx, ES(%esp)
+	movl PT_ES(%esp), %edi		# get the function address
+	movl PT_ORIG_EAX(%esp), %edx	# get the error code
+	movl %eax, PT_ORIG_EAX(%esp)
+	movl %ecx, PT_ES(%esp)
 	/*CFI_REL_OFFSET es, ES*/
 	movl $(__USER_DS), %ecx
 	movl %ecx, %ds
@@ -928,26 +912,26 @@ ENTRY(arch_unwind_init_running)
 	movl	4(%esp), %edx
 	movl	(%esp), %ecx
 	leal	4(%esp), %eax
-	movl	%ebx, EBX(%edx)
+	movl	%ebx, PT_EBX(%edx)
 	xorl	%ebx, %ebx
-	movl	%ebx, ECX(%edx)
-	movl	%ebx, EDX(%edx)
-	movl	%esi, ESI(%edx)
-	movl	%edi, EDI(%edx)
-	movl	%ebp, EBP(%edx)
-	movl	%ebx, EAX(%edx)
-	movl	$__USER_DS, DS(%edx)
-	movl	$__USER_DS, ES(%edx)
-	movl	%ebx, ORIG_EAX(%edx)
-	movl	%ecx, EIP(%edx)
+	movl	%ebx, PT_ECX(%edx)
+	movl	%ebx, PT_EDX(%edx)
+	movl	%esi, PT_ESI(%edx)
+	movl	%edi, PT_EDI(%edx)
+	movl	%ebp, PT_EBP(%edx)
+	movl	%ebx, PT_EAX(%edx)
+	movl	$__USER_DS, PT_DS(%edx)
+	movl	$__USER_DS, PT_ES(%edx)
+	movl	%ebx, PT_ORIG_EAX(%edx)
+	movl	%ecx, PT_EIP(%edx)
 	movl	12(%esp), %ecx
-	movl	$__KERNEL_CS, CS(%edx)
-	movl	%ebx, EFLAGS(%edx)
-	movl	%eax, OLDESP(%edx)
+	movl	$__KERNEL_CS, PT_CS(%edx)
+	movl	%ebx, PT_EFLAGS(%edx)
+	movl	%eax, PT_OLDESP(%edx)
 	movl	8(%esp), %eax
 	movl	%ecx, 8(%esp)
-	movl	EBX(%edx), %ebx
-	movl	$__KERNEL_DS, OLDSS(%edx)
+	movl	PT_EBX(%edx), %ebx
+	movl	$__KERNEL_DS, PT_OLDSS(%edx)
 	jmpl	*%eax
 	CFI_ENDPROC
 ENDPROC(arch_unwind_init_running)

--

