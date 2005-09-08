Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932622AbVIHPve@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932622AbVIHPve (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Sep 2005 11:51:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932653AbVIHPve
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Sep 2005 11:51:34 -0400
Received: from public.id2-vpn.continvity.gns.novell.com ([195.33.99.129]:57193
	"EHLO emea1-mh.id2.novell.com") by vger.kernel.org with ESMTP
	id S932622AbVIHPvc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Sep 2005 11:51:32 -0400
Message-Id: <43207A6302000078000244F4@emea1-mh.id2.novell.com>
X-Mailer: Novell GroupWise Internet Agent 7.0 
Date: Thu, 08 Sep 2005 17:52:35 +0200
From: "Jan Beulich" <JBeulich@novell.com>
To: "Andreas Kleen" <ak@suse.de>
Cc: <linux-kernel@vger.kernel.org>, <discuss@x86-64.org>
Subject: [PATCH] x86-64 CFI annotation fixes and additions
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=__Part06246853.1__="
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a MIME message. If you are reading this text, you may want to 
consider changing to a mail reader or gateway that understands how to 
properly handle MIME multipart messages.

--=__Part06246853.1__=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

(Note: Patch also attached because the inline version is certain to get
line wrapped.)

Being the foundation for reliable stack unwinding, this fixes CFI
unwind
annotations in many low-level x86_64 routines, plus a config option
(available to all architectures, and also present in the previously
sent
patch adding such annotations to i386 code) to enable them separatly
rather than only along with adding full debug information.

Signed-off-by: Jan Beulich <jbeulich@novell.com>

diff -Npru 2.6.13/arch/x86_64/ia32/ia32entry.S
2.6.13-x86_64-cfi/arch/x86_64/ia32/ia32entry.S
--- 2.6.13/arch/x86_64/ia32/ia32entry.S	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-x86_64-cfi/arch/x86_64/ia32/ia32entry.S	2005-09-01
16:48:24.000000000 +0200
@@ -55,20 +55,34 @@
  * with the int 0x80 path.
  */ 	
 ENTRY(ia32_sysenter_target)
-	CFI_STARTPROC
+	CFI_STARTPROC	simple
+	CFI_DEF_CFA	rsp,0
+	CFI_REGISTER	rsp,rbp
 	swapgs
 	movq	%gs:pda_kernelstack, %rsp
 	addq	$(PDA_STACKOFFSET),%rsp	
 	sti	
  	movl	%ebp,%ebp		/* zero extension */
 	pushq	$__USER32_DS
+	CFI_ADJUST_CFA_OFFSET 8
+	/*CFI_REL_OFFSET ss,0*/
 	pushq	%rbp
+	CFI_ADJUST_CFA_OFFSET 8
+	CFI_REL_OFFSET rsp,0
 	pushfq
+	CFI_ADJUST_CFA_OFFSET 8
+	/*CFI_REL_OFFSET rflags,0*/
 	movl	$VSYSCALL32_SYSEXIT, %r10d
+	CFI_REGISTER rip,r10
 	pushq	$__USER32_CS
+	CFI_ADJUST_CFA_OFFSET 8
+	/*CFI_REL_OFFSET cs,0*/
 	movl	%eax, %eax
 	pushq	%r10
+	CFI_ADJUST_CFA_OFFSET 8
+	CFI_REL_OFFSET rip,0
 	pushq	%rax
+	CFI_ADJUST_CFA_OFFSET 8
 	cld
 	SAVE_ARGS 0,0,1
  	/* no need to do an access_ok check here because rbp has been
@@ -79,6 +93,7 @@ ENTRY(ia32_sysenter_target)
  	.previous	
 	GET_THREAD_INFO(%r10)
 	testl 
$(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
+	CFI_REMEMBER_STATE
 	jnz  sysenter_tracesys
 sysenter_do_call:	
 	cmpl	$(IA32_NR_syscalls),%eax
@@ -94,14 +109,20 @@ sysenter_do_call:	
 	andl  $~0x200,EFLAGS-R11(%rsp) 
 	RESTORE_ARGS 1,24,1,1,1,1
 	popfq
+	CFI_ADJUST_CFA_OFFSET -8
+	/*CFI_RESTORE rflags*/
 	popq	%rcx				/* User %esp */
+	CFI_ADJUST_CFA_OFFSET -8
+	CFI_REGISTER rsp,rcx
 	movl	$VSYSCALL32_SYSEXIT,%edx	/* User %eip */
+	CFI_REGISTER rip,rdx
 	swapgs
 	sti		/* sti only takes effect after the next
instruction */
 	/* sysexit */
 	.byte	0xf, 0x35
 
 sysenter_tracesys:
+	CFI_RESTORE_STATE
 	SAVE_REST
 	CLEAR_RREGS
 	movq	$-ENOSYS,RAX(%rsp)	/* really needed? */
@@ -140,21 +161,28 @@ sysenter_tracesys:
  * with the int 0x80 path.	
  */ 	
 ENTRY(ia32_cstar_target)
-	CFI_STARTPROC
+	CFI_STARTPROC	simple
+	CFI_DEF_CFA	rsp,0
+	CFI_REGISTER	rip,rcx
+	/*CFI_REGISTER	rflags,r11*/
 	swapgs
 	movl	%esp,%r8d
+	CFI_REGISTER	rsp,r8
 	movq	%gs:pda_kernelstack,%rsp
 	sti
 	SAVE_ARGS 8,1,1
 	movl 	%eax,%eax	/* zero extension */
 	movq	%rax,ORIG_RAX-ARGOFFSET(%rsp)
 	movq	%rcx,RIP-ARGOFFSET(%rsp)
+	CFI_REL_OFFSET rip,RIP-ARGOFFSET
 	movq	%rbp,RCX-ARGOFFSET(%rsp) /* this lies slightly to ptrace
*/
 	movl	%ebp,%ecx
 	movq	$__USER32_CS,CS-ARGOFFSET(%rsp)
 	movq	$__USER32_DS,SS-ARGOFFSET(%rsp)
 	movq	%r11,EFLAGS-ARGOFFSET(%rsp)
+	/*CFI_REL_OFFSET rflags,EFLAGS-ARGOFFSET*/
 	movq	%r8,RSP-ARGOFFSET(%rsp)	
+	CFI_REL_OFFSET rsp,RSP-ARGOFFSET
 	/* no need to do an access_ok check here because r8 has been
 	   32bit zero extended */ 
 	/* hardware stack frame is complete now */	
@@ -164,6 +192,7 @@ ENTRY(ia32_cstar_target)
 	.previous	
 	GET_THREAD_INFO(%r10)
 	testl
$(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
+	CFI_REMEMBER_STATE
 	jnz   cstar_tracesys
 cstar_do_call:	
 	cmpl $IA32_NR_syscalls,%eax
@@ -177,12 +206,16 @@ cstar_do_call:	
 	jnz  int_ret_from_sys_call
 	RESTORE_ARGS 1,-ARG_SKIP,1,1,1
 	movl RIP-ARGOFFSET(%rsp),%ecx
+	CFI_REGISTER rip,rcx
 	movl EFLAGS-ARGOFFSET(%rsp),%r11d	
+	/*CFI_REGISTER rflags,r11*/
 	movl RSP-ARGOFFSET(%rsp),%esp
+	CFI_RESTORE rsp
 	swapgs
 	sysretl
 	
 cstar_tracesys:	
+	CFI_RESTORE_STATE
 	SAVE_REST
 	CLEAR_RREGS
 	movq $-ENOSYS,RAX(%rsp)	/* really needed? */
@@ -226,11 +259,18 @@ ia32_badarg:
  */ 				
 
 ENTRY(ia32_syscall)
-	CFI_STARTPROC
+	CFI_STARTPROC	simple
+	CFI_DEF_CFA	rsp,SS+8-RIP
+	/*CFI_REL_OFFSET	ss,SS-RIP*/
+	CFI_REL_OFFSET	rsp,RSP-RIP
+	/*CFI_REL_OFFSET	rflags,EFLAGS-RIP*/
+	/*CFI_REL_OFFSET	cs,CS-RIP*/
+	CFI_REL_OFFSET	rip,RIP-RIP
 	swapgs	
 	sti
 	movl %eax,%eax
 	pushq %rax
+	CFI_ADJUST_CFA_OFFSET 8
 	cld
 	/* note the registers are not zero extended to the sf.
 	   this could be a problem. */
@@ -278,6 +318,8 @@ quiet_ni_syscall:
 	jmp  ia32_ptregs_common	
 	.endm
 
+	CFI_STARTPROC
+
 	PTREGSCALL stub32_rt_sigreturn, sys32_rt_sigreturn, %rdi
 	PTREGSCALL stub32_sigreturn, sys32_sigreturn, %rdi
 	PTREGSCALL stub32_sigaltstack, sys32_sigaltstack, %rdx
@@ -290,8 +332,9 @@ quiet_ni_syscall:
 	PTREGSCALL stub32_rt_sigsuspend, sys_rt_sigsuspend, %rdx
 
 ENTRY(ia32_ptregs_common)
-	CFI_STARTPROC
 	popq %r11
+	CFI_ADJUST_CFA_OFFSET -8
+	CFI_REGISTER rip, r11
 	SAVE_REST
 	call *%rax
 	RESTORE_REST
diff -Npru 2.6.13/arch/x86_64/kernel/entry.S
2.6.13-x86_64-cfi/arch/x86_64/kernel/entry.S
--- 2.6.13/arch/x86_64/kernel/entry.S	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-cfi/arch/x86_64/kernel/entry.S	2005-09-07
15:03:16.000000000 +0200
@@ -79,16 +79,19 @@
 	xorl %eax, %eax
 	pushq %rax /* ss */
 	CFI_ADJUST_CFA_OFFSET	8
+	/*CFI_REL_OFFSET	ss,0*/
 	pushq %rax /* rsp */
 	CFI_ADJUST_CFA_OFFSET	8
-	CFI_OFFSET	rip,0
+	CFI_REL_OFFSET	rsp,0
 	pushq $(1<<9) /* eflags - interrupts on */
 	CFI_ADJUST_CFA_OFFSET	8
+	/*CFI_REL_OFFSET	rflags,0*/
 	pushq $__KERNEL_CS /* cs */
 	CFI_ADJUST_CFA_OFFSET	8
+	/*CFI_REL_OFFSET	cs,0*/
 	pushq \child_rip /* rip */
 	CFI_ADJUST_CFA_OFFSET	8
-	CFI_OFFSET	rip,0
+	CFI_REL_OFFSET	rip,0
 	pushq	%rax /* orig rax */
 	CFI_ADJUST_CFA_OFFSET	8
 	.endm
@@ -98,32 +101,39 @@
 	CFI_ADJUST_CFA_OFFSET	-(6*8)
 	.endm
 
-	.macro	CFI_DEFAULT_STACK
-	CFI_ADJUST_CFA_OFFSET  (SS)
-	CFI_OFFSET	r15,R15-SS
-	CFI_OFFSET	r14,R14-SS
-	CFI_OFFSET	r13,R13-SS
-	CFI_OFFSET	r12,R12-SS
-	CFI_OFFSET	rbp,RBP-SS
-	CFI_OFFSET	rbx,RBX-SS
-	CFI_OFFSET	r11,R11-SS
-	CFI_OFFSET	r10,R10-SS
-	CFI_OFFSET	r9,R9-SS
-	CFI_OFFSET	r8,R8-SS
-	CFI_OFFSET	rax,RAX-SS
-	CFI_OFFSET	rcx,RCX-SS
-	CFI_OFFSET	rdx,RDX-SS
-	CFI_OFFSET	rsi,RSI-SS
-	CFI_OFFSET	rdi,RDI-SS
-	CFI_OFFSET	rsp,RSP-SS
-	CFI_OFFSET	rip,RIP-SS
+	.macro	CFI_DEFAULT_STACK start=1
+	.if \start
+	CFI_STARTPROC	simple
+	CFI_DEF_CFA	rsp,SS+8
+	.else
+	CFI_DEF_CFA_OFFSET SS+8
+	.endif
+	CFI_REL_OFFSET	r15,R15
+	CFI_REL_OFFSET	r14,R14
+	CFI_REL_OFFSET	r13,R13
+	CFI_REL_OFFSET	r12,R12
+	CFI_REL_OFFSET	rbp,RBP
+	CFI_REL_OFFSET	rbx,RBX
+	CFI_REL_OFFSET	r11,R11
+	CFI_REL_OFFSET	r10,R10
+	CFI_REL_OFFSET	r9,R9
+	CFI_REL_OFFSET	r8,R8
+	CFI_REL_OFFSET	rax,RAX
+	CFI_REL_OFFSET	rcx,RCX
+	CFI_REL_OFFSET	rdx,RDX
+	CFI_REL_OFFSET	rsi,RSI
+	CFI_REL_OFFSET	rdi,RDI
+	CFI_REL_OFFSET	rip,RIP
+	/*CFI_REL_OFFSET	cs,CS*/
+	/*CFI_REL_OFFSET	rflags,EFLAGS*/
+	CFI_REL_OFFSET	rsp,RSP
+	/*CFI_REL_OFFSET	ss,SS*/
 	.endm
 /*
  * A newly forked process directly context switches into this.
  */ 	
 /* rdi:	prev */	
 ENTRY(ret_from_fork)
-	CFI_STARTPROC
 	CFI_DEFAULT_STACK
 	call schedule_tail
 	GET_THREAD_INFO(%rcx)
@@ -172,16 +182,21 @@ rff_trace:
  */ 			 		
 
 ENTRY(system_call)
-	CFI_STARTPROC
+	CFI_STARTPROC	simple
+	CFI_DEF_CFA	rsp,0
+	CFI_REGISTER	rip,rcx
+	/*CFI_REGISTER	rflags,r11*/
 	swapgs
 	movq	%rsp,%gs:pda_oldrsp 
 	movq	%gs:pda_kernelstack,%rsp
 	sti					
 	SAVE_ARGS 8,1
 	movq  %rax,ORIG_RAX-ARGOFFSET(%rsp) 
-	movq  %rcx,RIP-ARGOFFSET(%rsp)  
+	movq  %rcx,RIP-ARGOFFSET(%rsp)
+	CFI_REL_OFFSET rip,RIP-ARGOFFSET
 	GET_THREAD_INFO(%rcx)
 	testl
$(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%rcx)
+	CFI_REMEMBER_STATE
 	jnz tracesys
 	cmpq $__NR_syscall_max,%rax
 	ja badsys
@@ -201,9 +216,12 @@ sysret_check:		
 	cli
 	movl threadinfo_flags(%rcx),%edx
 	andl %edi,%edx
+	CFI_REMEMBER_STATE
 	jnz  sysret_careful 
 	movq RIP-ARGOFFSET(%rsp),%rcx
+	CFI_REGISTER	rip,rcx
 	RESTORE_ARGS 0,-ARG_SKIP,1
+	/*CFI_REGISTER	rflags,r11*/
 	movq	%gs:pda_oldrsp,%rsp
 	swapgs
 	sysretq
@@ -211,12 +229,15 @@ sysret_check:		
 	/* Handle reschedules */
 	/* edx:	work, edi: workmask */	
 sysret_careful:
+	CFI_RESTORE_STATE
 	bt $TIF_NEED_RESCHED,%edx
 	jnc sysret_signal
 	sti
 	pushq %rdi
+	CFI_ADJUST_CFA_OFFSET 8
 	call schedule
 	popq  %rdi
+	CFI_ADJUST_CFA_OFFSET -8
 	jmp sysret_check
 
 	/* Handle a signal */ 
@@ -234,8 +255,13 @@ sysret_signal:
 1:	movl $_TIF_NEED_RESCHED,%edi
 	jmp sysret_check
 	
+badsys:
+	movq $-ENOSYS,RAX-ARGOFFSET(%rsp)
+	jmp ret_from_sys_call
+
 	/* Do syscall tracing */
 tracesys:			 
+	CFI_RESTORE_STATE
 	SAVE_REST
 	movq $-ENOSYS,RAX(%rsp)
 	FIXUP_TOP_OF_STACK %rdi
@@ -254,16 +280,29 @@ tracesys:			 
 	RESTORE_TOP_OF_STACK %rbx
 	RESTORE_REST
 	jmp ret_from_sys_call
+	CFI_ENDPROC
 		
-badsys:
-	movq $-ENOSYS,RAX-ARGOFFSET(%rsp)	
-	jmp ret_from_sys_call
-
 /* 
  * Syscall return path ending with IRET.
  * Has correct top of stack, but partial stack frame.
  */ 	
-ENTRY(int_ret_from_sys_call)	
+ENTRY(int_ret_from_sys_call)
+	CFI_STARTPROC	simple
+	CFI_DEF_CFA	rsp,SS+8-ARGOFFSET
+	/*CFI_REL_OFFSET	ss,SS-ARGOFFSET*/
+	CFI_REL_OFFSET	rsp,RSP-ARGOFFSET
+	/*CFI_REL_OFFSET	rflags,EFLAGS-ARGOFFSET*/
+	/*CFI_REL_OFFSET	cs,CS-ARGOFFSET*/
+	CFI_REL_OFFSET	rip,RIP-ARGOFFSET
+	CFI_REL_OFFSET	rdx,RDX-ARGOFFSET
+	CFI_REL_OFFSET	rcx,RCX-ARGOFFSET
+	CFI_REL_OFFSET	rax,RAX-ARGOFFSET
+	CFI_REL_OFFSET	rdi,RDI-ARGOFFSET
+	CFI_REL_OFFSET	rsi,RSI-ARGOFFSET
+	CFI_REL_OFFSET	r8,R8-ARGOFFSET
+	CFI_REL_OFFSET	r9,R9-ARGOFFSET
+	CFI_REL_OFFSET	r10,R10-ARGOFFSET
+	CFI_REL_OFFSET	r11,R11-ARGOFFSET
 	cli
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_restore_args
@@ -284,8 +323,10 @@ int_careful:
 	jnc  int_very_careful
 	sti
 	pushq %rdi
+	CFI_ADJUST_CFA_OFFSET 8
 	call schedule
 	popq %rdi
+	CFI_ADJUST_CFA_OFFSET -8
 	cli
 	jmp int_with_check
 
@@ -297,9 +338,11 @@ int_very_careful:
 	testl
$(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edx
 	jz int_signal
 	pushq %rdi
+	CFI_ADJUST_CFA_OFFSET 8
 	leaq 8(%rsp),%rdi	# &ptregs -> arg1	
 	call syscall_trace_leave
 	popq %rdi
+	CFI_ADJUST_CFA_OFFSET -8
 	andl
$~(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SINGLESTEP),%edi
 	cli
 	jmp int_restore_rest
@@ -329,6 +372,8 @@ int_restore_rest:
 	jmp	ptregscall_common
 	.endm
 
+	CFI_STARTPROC
+
 	PTREGSCALL stub_clone, sys_clone, %r8
 	PTREGSCALL stub_fork, sys_fork, %rdi
 	PTREGSCALL stub_vfork, sys_vfork, %rdi
@@ -337,40 +382,49 @@ int_restore_rest:
 	PTREGSCALL stub_iopl, sys_iopl, %rsi
 
 ENTRY(ptregscall_common)
-	CFI_STARTPROC
 	popq %r11
-	CFI_ADJUST_CFA_OFFSET	-8
+	CFI_ADJUST_CFA_OFFSET -8
+	CFI_REGISTER rip, r11
 	SAVE_REST
 	movq %r11, %r15
+	CFI_REGISTER rip, r15
 	FIXUP_TOP_OF_STACK %r11
 	call *%rax
 	RESTORE_TOP_OF_STACK %r11
 	movq %r15, %r11
+	CFI_REGISTER rip, r11
 	RESTORE_REST
 	pushq %r11
-	CFI_ADJUST_CFA_OFFSET	8
+	CFI_ADJUST_CFA_OFFSET 8
+	CFI_REL_OFFSET rip, 0
 	ret
 	CFI_ENDPROC
 	
 ENTRY(stub_execve)
 	CFI_STARTPROC
 	popq %r11
-	CFI_ADJUST_CFA_OFFSET	-8
+	CFI_ADJUST_CFA_OFFSET -8
+	CFI_REGISTER rip, r11
 	SAVE_REST
 	movq %r11, %r15
+	CFI_REGISTER rip, r15
 	FIXUP_TOP_OF_STACK %r11
 	call sys_execve
 	GET_THREAD_INFO(%rcx)
 	bt $TIF_IA32,threadinfo_flags(%rcx)
+	CFI_REMEMBER_STATE
 	jc exec_32bit
 	RESTORE_TOP_OF_STACK %r11
 	movq %r15, %r11
+	CFI_REGISTER rip, r11
 	RESTORE_REST
-	push %r11
+	pushq %r11
+	CFI_ADJUST_CFA_OFFSET 8
+	CFI_REL_OFFSET rip, 0
 	ret
 
 exec_32bit:
-	CFI_ADJUST_CFA_OFFSET	REST_SKIP
+	CFI_RESTORE_STATE
 	movq %rax,RAX(%rsp)
 	RESTORE_REST
 	jmp int_ret_from_sys_call
@@ -382,7 +436,8 @@ exec_32bit:
  */                
 ENTRY(stub_rt_sigreturn)
 	CFI_STARTPROC
-	addq $8, %rsp		
+	addq $8, %rsp
+	CFI_ADJUST_CFA_OFFSET	-8
 	SAVE_REST
 	movq %rsp,%rdi
 	FIXUP_TOP_OF_STACK %r11
@@ -392,6 +447,25 @@ ENTRY(stub_rt_sigreturn)
 	jmp int_ret_from_sys_call
 	CFI_ENDPROC
 
+/*
+ * initial frame state for interrupts and exceptions
+ */
+	.macro _frame ref
+	CFI_STARTPROC simple
+	CFI_DEF_CFA rsp,SS+8-\ref
+	/*CFI_REL_OFFSET ss,SS-\ref*/
+	CFI_REL_OFFSET rsp,RSP-\ref
+	/*CFI_REL_OFFSET rflags,EFLAGS-\ref*/
+	/*CFI_REL_OFFSET cs,CS-\ref*/
+	CFI_REL_OFFSET rip,RIP-\ref
+	.endm
+
+/* initial frame state for interrupts (and exceptions without error
code) */
+#define INTR_FRAME _frame RIP
+/* initial frame state for exceptions with error code (and interrupts
with
+   vector already pushed) */
+#define XCPT_FRAME _frame ORIG_RAX
+
 /* 
  * Interrupt entry/exit.
  *
@@ -402,10 +476,6 @@ ENTRY(stub_rt_sigreturn)
 
 /* 0(%rsp): interrupt number */ 
 	.macro interrupt func
-	CFI_STARTPROC	simple
-	CFI_DEF_CFA	rsp,(SS-RDI)
-	CFI_REL_OFFSET	rsp,(RSP-ORIG_RAX)
-	CFI_REL_OFFSET	rip,(RIP-ORIG_RAX)
 	cld
 #ifdef CONFIG_DEBUG_INFO
 	SAVE_ALL	
@@ -425,23 +495,27 @@ ENTRY(stub_rt_sigreturn)
 	swapgs	
 1:	incl	%gs:pda_irqcount	# RED-PEN should check preempt
count
 	movq %gs:pda_irqstackptr,%rax
-	cmoveq
%rax,%rsp							
+	cmoveq %rax,%rsp /*todo This needs CFI annotation! */
 	pushq %rdi			# save old stack	
+	CFI_ADJUST_CFA_OFFSET	8
 	call \func
 	.endm
 
 ENTRY(common_interrupt)
+	XCPT_FRAME
 	interrupt do_IRQ
 	/* 0(%rsp): oldrsp-ARGOFFSET */
-ret_from_intr:		
+ret_from_intr:
 	popq  %rdi
+	CFI_ADJUST_CFA_OFFSET	-8
 	cli	
 	decl %gs:pda_irqcount
 #ifdef CONFIG_DEBUG_INFO
 	movq RBP(%rdi),%rbp
+	CFI_DEF_CFA_REGISTER	rsp
 #endif
-	leaq ARGOFFSET(%rdi),%rsp
-exit_intr:	 	
+	leaq ARGOFFSET(%rdi),%rsp /*todo This needs CFI annotation! */
+exit_intr:
 	GET_THREAD_INFO(%rcx)
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_kernel
@@ -453,9 +527,10 @@ exit_intr:	 	
 	 */		
 retint_with_reschedule:
 	movl $_TIF_WORK_MASK,%edi
-retint_check:			
+retint_check:
 	movl threadinfo_flags(%rcx),%edx
 	andl %edi,%edx
+	CFI_REMEMBER_STATE
 	jnz  retint_careful
 retint_swapgs:	 	
 	swapgs 
@@ -476,14 +551,17 @@ bad_iret:
 	jmp do_exit			
 	.previous	
 	
-	/* edi: workmask, edx: work */	
+	/* edi: workmask, edx: work */
 retint_careful:
+	CFI_RESTORE_STATE
 	bt    $TIF_NEED_RESCHED,%edx
 	jnc   retint_signal
 	sti
 	pushq %rdi
+	CFI_ADJUST_CFA_OFFSET	8
 	call  schedule
 	popq %rdi		
+	CFI_ADJUST_CFA_OFFSET	-8
 	GET_THREAD_INFO(%rcx)
 	cli
 	jmp retint_check
@@ -523,7 +601,9 @@ retint_kernel:	
  * APIC interrupts.
  */		
 	.macro apicinterrupt num,func
+	INTR_FRAME
 	pushq $\num-256
+	CFI_ADJUST_CFA_OFFSET 8
 	interrupt \func
 	jmp ret_from_intr
 	CFI_ENDPROC
@@ -558,16 +638,23 @@ ENTRY(spurious_interrupt)
  * Exception entry points.
  */ 		
 	.macro zeroentry sym
+	INTR_FRAME
 	pushq $0	/* push error code/oldrax */ 
+	CFI_ADJUST_CFA_OFFSET 8
 	pushq %rax	/* push real oldrax to the rdi slot */ 
+	CFI_ADJUST_CFA_OFFSET 8
 	leaq  \sym(%rip),%rax
 	jmp error_entry
+	CFI_ENDPROC
 	.endm	
 
 	.macro errorentry sym
+	XCPT_FRAME
 	pushq %rax
+	CFI_ADJUST_CFA_OFFSET 8
 	leaq  \sym(%rip),%rax
 	jmp error_entry
+	CFI_ENDPROC
 	.endm
 
 	/* error code is on the stack already */
@@ -594,10 +681,7 @@ ENTRY(spurious_interrupt)
  * and the exception handler in %rax.	
  */ 		  				
 ENTRY(error_entry)
-	CFI_STARTPROC	simple
-	CFI_DEF_CFA	rsp,(SS-RDI)
-	CFI_REL_OFFSET	rsp,(RSP-RDI)
-	CFI_REL_OFFSET	rip,(RIP-RDI)
+	_frame RDI
 	/* rdi slot contains rax, oldrax contains error code */
 	cld	
 	subq  $14*8,%rsp
@@ -679,7 +763,9 @@ error_kernelspace:
        /* Reload gs selector with exception handling */
        /* edi:  new selector */ 
 ENTRY(load_gs_index)
+	CFI_STARTPROC
 	pushf
+	CFI_ADJUST_CFA_OFFSET 8
 	cli
         swapgs
 gs_change:     
@@ -687,7 +773,9 @@ gs_change:     
 2:	mfence		/* workaround */
 	swapgs
         popf
+	CFI_ADJUST_CFA_OFFSET -8
         ret
+	CFI_ENDPROC
        
         .section __ex_table,"a"
         .align 8
@@ -798,7 +886,7 @@ ENTRY(device_not_available)
 
 	/* runs on exception stack */
 ENTRY(debug)
-	CFI_STARTPROC
+	INTR_FRAME
 	pushq $0
 	CFI_ADJUST_CFA_OFFSET 8		
 	paranoidentry do_debug
@@ -807,9 +895,9 @@ ENTRY(debug)
 
 	/* runs on exception stack */	
 ENTRY(nmi)
-	CFI_STARTPROC
+	INTR_FRAME
 	pushq $-1
-	CFI_ADJUST_CFA_OFFSET 8		
+	CFI_ADJUST_CFA_OFFSET 8
 	paranoidentry do_nmi
 	/*
  	 * "Paranoid" exit path from exception stack.
@@ -874,7 +962,7 @@ ENTRY(reserved)
 
 	/* runs on exception stack */
 ENTRY(double_fault)
-	CFI_STARTPROC
+	XCPT_FRAME
 	paranoidentry do_double_fault
 	jmp paranoid_exit
 	CFI_ENDPROC
@@ -887,7 +975,7 @@ ENTRY(segment_not_present)
 
 	/* runs on exception stack */
 ENTRY(stack_segment)
-	CFI_STARTPROC
+	XCPT_FRAME
 	paranoidentry do_stack_segment
 	jmp paranoid_exit
 	CFI_ENDPROC
@@ -907,7 +995,7 @@ ENTRY(spurious_interrupt_bug)
 #ifdef CONFIG_X86_MCE
 	/* runs on exception stack */
 ENTRY(machine_check)
-	CFI_STARTPROC
+	INTR_FRAME
 	pushq $0
 	CFI_ADJUST_CFA_OFFSET 8	
 	paranoidentry do_machine_check
@@ -919,14 +1007,19 @@ ENTRY(call_debug)
        zeroentry do_call_debug
 
 ENTRY(call_softirq)
+	CFI_STARTPROC
 	movq %gs:pda_irqstackptr,%rax
 	pushq %r15
+	CFI_ADJUST_CFA_OFFSET 8
 	movq %rsp,%r15
+	CFI_DEF_CFA_REGISTER	r15
 	incl %gs:pda_irqcount
 	cmove %rax,%rsp
 	call __do_softirq
 	movq %r15,%rsp
+	CFI_DEF_CFA_REGISTER	rsp
 	decl %gs:pda_irqcount
 	popq %r15
+	CFI_ADJUST_CFA_OFFSET -8
 	ret
-
+	CFI_ENDPROC
diff -Npru 2.6.13/arch/x86_64/kernel/vmlinux.lds.S
2.6.13-x86_64-cfi/arch/x86_64/kernel/vmlinux.lds.S
--- 2.6.13/arch/x86_64/kernel/vmlinux.lds.S	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-x86_64-cfi/arch/x86_64/kernel/vmlinux.lds.S	2005-09-05
16:19:25.000000000 +0200
@@ -188,7 +188,7 @@ SECTIONS
   /* Sections to be discarded */
   /DISCARD/ : {
 	*(.exitcall.exit)
-#ifndef CONFIG_DEBUG_INFO
+#ifndef CONFIG_UNWIND_INFO
 	*(.eh_frame)
 #endif
 	}
diff -Npru 2.6.13/arch/x86_64/Makefile
2.6.13-x86_64-cfi/arch/x86_64/Makefile
--- 2.6.13/arch/x86_64/Makefile	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-cfi/arch/x86_64/Makefile	2005-09-01
11:32:11.000000000 +0200
@@ -38,8 +38,10 @@ CFLAGS += -pipe
 # actually it makes the kernel smaller too.
 CFLAGS += -fno-reorder-blocks	
 CFLAGS += -Wno-sign-compare
-ifneq ($(CONFIG_DEBUG_INFO),y)
+ifneq ($(CONFIG_UNWIND_INFO),y)
 CFLAGS += -fno-asynchronous-unwind-tables
+endif
+ifneq ($(CONFIG_DEBUG_INFO),y)
 # -fweb shrinks the kernel a bit, but the difference is very small
 # it also messes up debugging, so don't use it for now.
 #CFLAGS += $(call cc-option,-fweb)
diff -Npru 2.6.13/include/asm-x86_64/calling.h
2.6.13-x86_64-cfi/include/asm-x86_64/calling.h
--- 2.6.13/include/asm-x86_64/calling.h	2005-08-29
01:41:01.000000000 +0200
+++ 2.6.13-x86_64-cfi/include/asm-x86_64/calling.h	2005-03-18
14:15:52.000000000 +0100
@@ -65,27 +65,36 @@
 	.if \skipr11
 	.else
 	movq (%rsp),%r11
+	CFI_RESTORE r11
 	.endif
 	.if \skipr8910
 	.else
 	movq 1*8(%rsp),%r10
+	CFI_RESTORE r10
 	movq 2*8(%rsp),%r9
+	CFI_RESTORE r9
 	movq 3*8(%rsp),%r8
+	CFI_RESTORE r8
 	.endif
 	.if \skiprax
 	.else
 	movq 4*8(%rsp),%rax
+	CFI_RESTORE rax
 	.endif
 	.if \skiprcx
 	.else
 	movq 5*8(%rsp),%rcx
+	CFI_RESTORE rcx
 	.endif
 	.if \skiprdx
 	.else
 	movq 6*8(%rsp),%rdx
+	CFI_RESTORE rdx
 	.endif
 	movq 7*8(%rsp),%rsi
+	CFI_RESTORE rsi
 	movq 8*8(%rsp),%rdi
+	CFI_RESTORE rdi
 	.if ARG_SKIP+\addskip > 0
 	addq $ARG_SKIP+\addskip,%rsp
 	CFI_ADJUST_CFA_OFFSET	-(ARG_SKIP+\addskip)
@@ -124,11 +133,17 @@
 
 	.macro RESTORE_REST
 	movq (%rsp),%r15
+	CFI_RESTORE r15
 	movq 1*8(%rsp),%r14
+	CFI_RESTORE r14
 	movq 2*8(%rsp),%r13
+	CFI_RESTORE r13
 	movq 3*8(%rsp),%r12
+	CFI_RESTORE r12
 	movq 4*8(%rsp),%rbp
+	CFI_RESTORE rbp
 	movq 5*8(%rsp),%rbx
+	CFI_RESTORE rbx
 	addq $REST_SKIP,%rsp
 	CFI_ADJUST_CFA_OFFSET	-(REST_SKIP)
 	.endm
@@ -146,11 +161,3 @@
 	.macro icebp
 	.byte 0xf1
 	.endm
-
-#ifdef CONFIG_FRAME_POINTER
-#define ENTER enter
-#define LEAVE leave
-#else
-#define ENTER
-#define LEAVE
-#endif
diff -Npru 2.6.13/include/asm-x86_64/dwarf2.h
2.6.13-x86_64-cfi/include/asm-x86_64/dwarf2.h
--- 2.6.13/include/asm-x86_64/dwarf2.h	2005-08-29 01:41:01.000000000
+0200
+++ 2.6.13-x86_64-cfi/include/asm-x86_64/dwarf2.h	2005-03-16
12:24:42.000000000 +0100
@@ -14,7 +14,7 @@
    away for older version. 
  */
 
-#ifdef CONFIG_DEBUG_INFO
+#ifdef CONFIG_UNWIND_INFO
 
 #define CFI_STARTPROC .cfi_startproc
 #define CFI_ENDPROC .cfi_endproc
@@ -24,6 +24,10 @@
 #define CFI_ADJUST_CFA_OFFSET .cfi_adjust_cfa_offset
 #define CFI_OFFSET .cfi_offset
 #define CFI_REL_OFFSET .cfi_rel_offset
+#define CFI_REGISTER .cfi_register
+#define CFI_RESTORE .cfi_restore
+#define CFI_REMEMBER_STATE .cfi_remember_state
+#define CFI_RESTORE_STATE .cfi_restore_state
 
 #else
 
@@ -36,6 +40,10 @@
 #define CFI_ADJUST_CFA_OFFSET	#
 #define CFI_OFFSET	#
 #define CFI_REL_OFFSET	#
+#define CFI_REGISTER	#
+#define CFI_RESTORE	#
+#define CFI_REMEMBER_STATE	#
+#define CFI_RESTORE_STATE	#
 
 #endif
 
diff -Npru 2.6.13/lib/Kconfig.debug
2.6.13-x86_64-cfi/lib/Kconfig.debug
--- 2.6.13/lib/Kconfig.debug	2005-08-29 01:41:01.000000000 +0200
+++ 2.6.13-x86_64-cfi/lib/Kconfig.debug	2005-09-07
13:26:58.000000000 +0200
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


--=__Part06246853.1__=
Content-Type: application/octet-stream; name="linux-2.6.13-x86_64-cfi.patch"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="linux-2.6.13-x86_64-cfi.patch"

KE5vdGU6IFBhdGNoIGFsc28gYXR0YWNoZWQgYmVjYXVzZSB0aGUgaW5saW5lIHZlcnNpb24gaXMg
Y2VydGFpbiB0byBnZXQKbGluZSB3cmFwcGVkLikKCkJlaW5nIHRoZSBmb3VuZGF0aW9uIGZvciBy
ZWxpYWJsZSBzdGFjayB1bndpbmRpbmcsIHRoaXMgZml4ZXMgQ0ZJIHVud2luZAphbm5vdGF0aW9u
cyBpbiBtYW55IGxvdy1sZXZlbCB4ODZfNjQgcm91dGluZXMsIHBsdXMgYSBjb25maWcgb3B0aW9u
CihhdmFpbGFibGUgdG8gYWxsIGFyY2hpdGVjdHVyZXMsIGFuZCBhbHNvIHByZXNlbnQgaW4gdGhl
IHByZXZpb3VzbHkgc2VudApwYXRjaCBhZGRpbmcgc3VjaCBhbm5vdGF0aW9ucyB0byBpMzg2IGNv
ZGUpIHRvIGVuYWJsZSB0aGVtIHNlcGFyYXRseQpyYXRoZXIgdGhhbiBvbmx5IGFsb25nIHdpdGgg
YWRkaW5nIGZ1bGwgZGVidWcgaW5mb3JtYXRpb24uCgpTaWduZWQtb2ZmLWJ5OiBKYW4gQmV1bGlj
aCA8amJldWxpY2hAbm92ZWxsLmNvbT4KCmRpZmYgLU5wcnUgMi42LjEzL2FyY2gveDg2XzY0L2lh
MzIvaWEzMmVudHJ5LlMgMi42LjEzLXg4Nl82NC1jZmkvYXJjaC94ODZfNjQvaWEzMi9pYTMyZW50
cnkuUwotLS0gMi42LjEzL2FyY2gveDg2XzY0L2lhMzIvaWEzMmVudHJ5LlMJMjAwNS0wOC0yOSAw
MTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy14ODZfNjQtY2ZpL2FyY2gveDg2XzY0
L2lhMzIvaWEzMmVudHJ5LlMJMjAwNS0wOS0wMSAxNjo0ODoyNC4wMDAwMDAwMDAgKzAyMDAKQEAg
LTU1LDIwICs1NSwzNCBAQAogICogd2l0aCB0aGUgaW50IDB4ODAgcGF0aC4KICAqLyAJCiBFTlRS
WShpYTMyX3N5c2VudGVyX3RhcmdldCkKLQlDRklfU1RBUlRQUk9DCisJQ0ZJX1NUQVJUUFJPQwlz
aW1wbGUKKwlDRklfREVGX0NGQQlyc3AsMAorCUNGSV9SRUdJU1RFUglyc3AscmJwCiAJc3dhcGdz
CiAJbW92cQklZ3M6cGRhX2tlcm5lbHN0YWNrLCAlcnNwCiAJYWRkcQkkKFBEQV9TVEFDS09GRlNF
VCksJXJzcAkKIAlzdGkJCiAgCW1vdmwJJWVicCwlZWJwCQkvKiB6ZXJvIGV4dGVuc2lvbiAqLwog
CXB1c2hxCSRfX1VTRVIzMl9EUworCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA4CisJLypDRklfUkVM
X09GRlNFVCBzcywwKi8KIAlwdXNocQklcmJwCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDgKKwlD
RklfUkVMX09GRlNFVCByc3AsMAogCXB1c2hmcQorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA4CisJ
LypDRklfUkVMX09GRlNFVCByZmxhZ3MsMCovCiAJbW92bAkkVlNZU0NBTEwzMl9TWVNFWElULCAl
cjEwZAorCUNGSV9SRUdJU1RFUiByaXAscjEwCiAJcHVzaHEJJF9fVVNFUjMyX0NTCisJQ0ZJX0FE
SlVTVF9DRkFfT0ZGU0VUIDgKKwkvKkNGSV9SRUxfT0ZGU0VUIGNzLDAqLwogCW1vdmwJJWVheCwg
JWVheAogCXB1c2hxCSVyMTAKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgOAorCUNGSV9SRUxfT0ZG
U0VUIHJpcCwwCiAJcHVzaHEJJXJheAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA4CiAJY2xkCiAJ
U0FWRV9BUkdTIDAsMCwxCiAgCS8qIG5vIG5lZWQgdG8gZG8gYW4gYWNjZXNzX29rIGNoZWNrIGhl
cmUgYmVjYXVzZSByYnAgaGFzIGJlZW4KQEAgLTc5LDYgKzkzLDcgQEAgRU5UUlkoaWEzMl9zeXNl
bnRlcl90YXJnZXQpCiAgCS5wcmV2aW91cwkKIAlHRVRfVEhSRUFEX0lORk8oJXIxMCkKIAl0ZXN0
bCAgJChfVElGX1NZU0NBTExfVFJBQ0V8X1RJRl9TWVNDQUxMX0FVRElUfF9USUZfU0VDQ09NUCks
dGhyZWFkaW5mb19mbGFncyglcjEwKQorCUNGSV9SRU1FTUJFUl9TVEFURQogCWpueiAgc3lzZW50
ZXJfdHJhY2VzeXMKIHN5c2VudGVyX2RvX2NhbGw6CQogCWNtcGwJJChJQTMyX05SX3N5c2NhbGxz
KSwlZWF4CkBAIC05NCwxNCArMTA5LDIwIEBAIHN5c2VudGVyX2RvX2NhbGw6CQogCWFuZGwgICR+
MHgyMDAsRUZMQUdTLVIxMSglcnNwKSAKIAlSRVNUT1JFX0FSR1MgMSwyNCwxLDEsMSwxCiAJcG9w
ZnEKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgLTgKKwkvKkNGSV9SRVNUT1JFIHJmbGFncyovCiAJ
cG9wcQklcmN4CQkJCS8qIFVzZXIgJWVzcCAqLworCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtOAor
CUNGSV9SRUdJU1RFUiByc3AscmN4CiAJbW92bAkkVlNZU0NBTEwzMl9TWVNFWElULCVlZHgJLyog
VXNlciAlZWlwICovCisJQ0ZJX1JFR0lTVEVSIHJpcCxyZHgKIAlzd2FwZ3MKIAlzdGkJCS8qIHN0
aSBvbmx5IHRha2VzIGVmZmVjdCBhZnRlciB0aGUgbmV4dCBpbnN0cnVjdGlvbiAqLwogCS8qIHN5
c2V4aXQgKi8KIAkuYnl0ZQkweGYsIDB4MzUKIAogc3lzZW50ZXJfdHJhY2VzeXM6CisJQ0ZJX1JF
U1RPUkVfU1RBVEUKIAlTQVZFX1JFU1QKIAlDTEVBUl9SUkVHUwogCW1vdnEJJC1FTk9TWVMsUkFY
KCVyc3ApCS8qIHJlYWxseSBuZWVkZWQ/ICovCkBAIC0xNDAsMjEgKzE2MSwyOCBAQCBzeXNlbnRl
cl90cmFjZXN5czoKICAqIHdpdGggdGhlIGludCAweDgwIHBhdGguCQogICovIAkKIEVOVFJZKGlh
MzJfY3N0YXJfdGFyZ2V0KQotCUNGSV9TVEFSVFBST0MKKwlDRklfU1RBUlRQUk9DCXNpbXBsZQor
CUNGSV9ERUZfQ0ZBCXJzcCwwCisJQ0ZJX1JFR0lTVEVSCXJpcCxyY3gKKwkvKkNGSV9SRUdJU1RF
UglyZmxhZ3MscjExKi8KIAlzd2FwZ3MKIAltb3ZsCSVlc3AsJXI4ZAorCUNGSV9SRUdJU1RFUgly
c3AscjgKIAltb3ZxCSVnczpwZGFfa2VybmVsc3RhY2ssJXJzcAogCXN0aQogCVNBVkVfQVJHUyA4
LDEsMQogCW1vdmwgCSVlYXgsJWVheAkvKiB6ZXJvIGV4dGVuc2lvbiAqLwogCW1vdnEJJXJheCxP
UklHX1JBWC1BUkdPRkZTRVQoJXJzcCkKIAltb3ZxCSVyY3gsUklQLUFSR09GRlNFVCglcnNwKQor
CUNGSV9SRUxfT0ZGU0VUIHJpcCxSSVAtQVJHT0ZGU0VUCiAJbW92cQklcmJwLFJDWC1BUkdPRkZT
RVQoJXJzcCkgLyogdGhpcyBsaWVzIHNsaWdodGx5IHRvIHB0cmFjZSAqLwogCW1vdmwJJWVicCwl
ZWN4CiAJbW92cQkkX19VU0VSMzJfQ1MsQ1MtQVJHT0ZGU0VUKCVyc3ApCiAJbW92cQkkX19VU0VS
MzJfRFMsU1MtQVJHT0ZGU0VUKCVyc3ApCiAJbW92cQklcjExLEVGTEFHUy1BUkdPRkZTRVQoJXJz
cCkKKwkvKkNGSV9SRUxfT0ZGU0VUIHJmbGFncyxFRkxBR1MtQVJHT0ZGU0VUKi8KIAltb3ZxCSVy
OCxSU1AtQVJHT0ZGU0VUKCVyc3ApCQorCUNGSV9SRUxfT0ZGU0VUIHJzcCxSU1AtQVJHT0ZGU0VU
CiAJLyogbm8gbmVlZCB0byBkbyBhbiBhY2Nlc3Nfb2sgY2hlY2sgaGVyZSBiZWNhdXNlIHI4IGhh
cyBiZWVuCiAJICAgMzJiaXQgemVybyBleHRlbmRlZCAqLyAKIAkvKiBoYXJkd2FyZSBzdGFjayBm
cmFtZSBpcyBjb21wbGV0ZSBub3cgKi8JCkBAIC0xNjQsNiArMTkyLDcgQEAgRU5UUlkoaWEzMl9j
c3Rhcl90YXJnZXQpCiAJLnByZXZpb3VzCQogCUdFVF9USFJFQURfSU5GTyglcjEwKQogCXRlc3Rs
ICQoX1RJRl9TWVNDQUxMX1RSQUNFfF9USUZfU1lTQ0FMTF9BVURJVHxfVElGX1NFQ0NPTVApLHRo
cmVhZGluZm9fZmxhZ3MoJXIxMCkKKwlDRklfUkVNRU1CRVJfU1RBVEUKIAlqbnogICBjc3Rhcl90
cmFjZXN5cwogY3N0YXJfZG9fY2FsbDoJCiAJY21wbCAkSUEzMl9OUl9zeXNjYWxscywlZWF4CkBA
IC0xNzcsMTIgKzIwNiwxNiBAQCBjc3Rhcl9kb19jYWxsOgkKIAlqbnogIGludF9yZXRfZnJvbV9z
eXNfY2FsbAogCVJFU1RPUkVfQVJHUyAxLC1BUkdfU0tJUCwxLDEsMQogCW1vdmwgUklQLUFSR09G
RlNFVCglcnNwKSwlZWN4CisJQ0ZJX1JFR0lTVEVSIHJpcCxyY3gKIAltb3ZsIEVGTEFHUy1BUkdP
RkZTRVQoJXJzcCksJXIxMWQJCisJLypDRklfUkVHSVNURVIgcmZsYWdzLHIxMSovCiAJbW92bCBS
U1AtQVJHT0ZGU0VUKCVyc3ApLCVlc3AKKwlDRklfUkVTVE9SRSByc3AKIAlzd2FwZ3MKIAlzeXNy
ZXRsCiAJCiBjc3Rhcl90cmFjZXN5czoJCisJQ0ZJX1JFU1RPUkVfU1RBVEUKIAlTQVZFX1JFU1QK
IAlDTEVBUl9SUkVHUwogCW1vdnEgJC1FTk9TWVMsUkFYKCVyc3ApCS8qIHJlYWxseSBuZWVkZWQ/
ICovCkBAIC0yMjYsMTEgKzI1OSwxOCBAQCBpYTMyX2JhZGFyZzoKICAqLyAJCQkJCiAKIEVOVFJZ
KGlhMzJfc3lzY2FsbCkKLQlDRklfU1RBUlRQUk9DCisJQ0ZJX1NUQVJUUFJPQwlzaW1wbGUKKwlD
RklfREVGX0NGQQlyc3AsU1MrOC1SSVAKKwkvKkNGSV9SRUxfT0ZGU0VUCXNzLFNTLVJJUCovCisJ
Q0ZJX1JFTF9PRkZTRVQJcnNwLFJTUC1SSVAKKwkvKkNGSV9SRUxfT0ZGU0VUCXJmbGFncyxFRkxB
R1MtUklQKi8KKwkvKkNGSV9SRUxfT0ZGU0VUCWNzLENTLVJJUCovCisJQ0ZJX1JFTF9PRkZTRVQJ
cmlwLFJJUC1SSVAKIAlzd2FwZ3MJCiAJc3RpCiAJbW92bCAlZWF4LCVlYXgKIAlwdXNocSAlcmF4
CisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDgKIAljbGQKIAkvKiBub3RlIHRoZSByZWdpc3RlcnMg
YXJlIG5vdCB6ZXJvIGV4dGVuZGVkIHRvIHRoZSBzZi4KIAkgICB0aGlzIGNvdWxkIGJlIGEgcHJv
YmxlbS4gKi8KQEAgLTI3OCw2ICszMTgsOCBAQCBxdWlldF9uaV9zeXNjYWxsOgogCWptcCAgaWEz
Ml9wdHJlZ3NfY29tbW9uCQogCS5lbmRtCiAKKwlDRklfU1RBUlRQUk9DCisKIAlQVFJFR1NDQUxM
IHN0dWIzMl9ydF9zaWdyZXR1cm4sIHN5czMyX3J0X3NpZ3JldHVybiwgJXJkaQogCVBUUkVHU0NB
TEwgc3R1YjMyX3NpZ3JldHVybiwgc3lzMzJfc2lncmV0dXJuLCAlcmRpCiAJUFRSRUdTQ0FMTCBz
dHViMzJfc2lnYWx0c3RhY2ssIHN5czMyX3NpZ2FsdHN0YWNrLCAlcmR4CkBAIC0yOTAsOCArMzMy
LDkgQEAgcXVpZXRfbmlfc3lzY2FsbDoKIAlQVFJFR1NDQUxMIHN0dWIzMl9ydF9zaWdzdXNwZW5k
LCBzeXNfcnRfc2lnc3VzcGVuZCwgJXJkeAogCiBFTlRSWShpYTMyX3B0cmVnc19jb21tb24pCi0J
Q0ZJX1NUQVJUUFJPQwogCXBvcHEgJXIxMQorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtOAorCUNG
SV9SRUdJU1RFUiByaXAsIHIxMQogCVNBVkVfUkVTVAogCWNhbGwgKiVyYXgKIAlSRVNUT1JFX1JF
U1QKZGlmZiAtTnBydSAyLjYuMTMvYXJjaC94ODZfNjQva2VybmVsL2VudHJ5LlMgMi42LjEzLXg4
Nl82NC1jZmkvYXJjaC94ODZfNjQva2VybmVsL2VudHJ5LlMKLS0tIDIuNi4xMy9hcmNoL3g4Nl82
NC9rZXJuZWwvZW50cnkuUwkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCArMDIwMAorKysg
Mi42LjEzLXg4Nl82NC1jZmkvYXJjaC94ODZfNjQva2VybmVsL2VudHJ5LlMJMjAwNS0wOS0wNyAx
NTowMzoxNi4wMDAwMDAwMDAgKzAyMDAKQEAgLTc5LDE2ICs3OSwxOSBAQAogCXhvcmwgJWVheCwg
JWVheAogCXB1c2hxICVyYXggLyogc3MgKi8KIAlDRklfQURKVVNUX0NGQV9PRkZTRVQJOAorCS8q
Q0ZJX1JFTF9PRkZTRVQJc3MsMCovCiAJcHVzaHEgJXJheCAvKiByc3AgKi8KIAlDRklfQURKVVNU
X0NGQV9PRkZTRVQJOAotCUNGSV9PRkZTRVQJcmlwLDAKKwlDRklfUkVMX09GRlNFVAlyc3AsMAog
CXB1c2hxICQoMTw8OSkgLyogZWZsYWdzIC0gaW50ZXJydXB0cyBvbiAqLwogCUNGSV9BREpVU1Rf
Q0ZBX09GRlNFVAk4CisJLypDRklfUkVMX09GRlNFVAlyZmxhZ3MsMCovCiAJcHVzaHEgJF9fS0VS
TkVMX0NTIC8qIGNzICovCiAJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUCTgKKwkvKkNGSV9SRUxfT0ZG
U0VUCWNzLDAqLwogCXB1c2hxIFxjaGlsZF9yaXAgLyogcmlwICovCiAJQ0ZJX0FESlVTVF9DRkFf
T0ZGU0VUCTgKLQlDRklfT0ZGU0VUCXJpcCwwCisJQ0ZJX1JFTF9PRkZTRVQJcmlwLDAKIAlwdXNo
cQklcmF4IC8qIG9yaWcgcmF4ICovCiAJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUCTgKIAkuZW5kbQpA
QCAtOTgsMzIgKzEwMSwzOSBAQAogCUNGSV9BREpVU1RfQ0ZBX09GRlNFVAktKDYqOCkKIAkuZW5k
bQogCi0JLm1hY3JvCUNGSV9ERUZBVUxUX1NUQUNLCi0JQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUICAo
U1MpCi0JQ0ZJX09GRlNFVAlyMTUsUjE1LVNTCi0JQ0ZJX09GRlNFVAlyMTQsUjE0LVNTCi0JQ0ZJ
X09GRlNFVAlyMTMsUjEzLVNTCi0JQ0ZJX09GRlNFVAlyMTIsUjEyLVNTCi0JQ0ZJX09GRlNFVAly
YnAsUkJQLVNTCi0JQ0ZJX09GRlNFVAlyYngsUkJYLVNTCi0JQ0ZJX09GRlNFVAlyMTEsUjExLVNT
Ci0JQ0ZJX09GRlNFVAlyMTAsUjEwLVNTCi0JQ0ZJX09GRlNFVAlyOSxSOS1TUwotCUNGSV9PRkZT
RVQJcjgsUjgtU1MKLQlDRklfT0ZGU0VUCXJheCxSQVgtU1MKLQlDRklfT0ZGU0VUCXJjeCxSQ1gt
U1MKLQlDRklfT0ZGU0VUCXJkeCxSRFgtU1MKLQlDRklfT0ZGU0VUCXJzaSxSU0ktU1MKLQlDRklf
T0ZGU0VUCXJkaSxSREktU1MKLQlDRklfT0ZGU0VUCXJzcCxSU1AtU1MKLQlDRklfT0ZGU0VUCXJp
cCxSSVAtU1MKKwkubWFjcm8JQ0ZJX0RFRkFVTFRfU1RBQ0sgc3RhcnQ9MQorCS5pZiBcc3RhcnQK
KwlDRklfU1RBUlRQUk9DCXNpbXBsZQorCUNGSV9ERUZfQ0ZBCXJzcCxTUys4CisJLmVsc2UKKwlD
RklfREVGX0NGQV9PRkZTRVQgU1MrOAorCS5lbmRpZgorCUNGSV9SRUxfT0ZGU0VUCXIxNSxSMTUK
KwlDRklfUkVMX09GRlNFVAlyMTQsUjE0CisJQ0ZJX1JFTF9PRkZTRVQJcjEzLFIxMworCUNGSV9S
RUxfT0ZGU0VUCXIxMixSMTIKKwlDRklfUkVMX09GRlNFVAlyYnAsUkJQCisJQ0ZJX1JFTF9PRkZT
RVQJcmJ4LFJCWAorCUNGSV9SRUxfT0ZGU0VUCXIxMSxSMTEKKwlDRklfUkVMX09GRlNFVAlyMTAs
UjEwCisJQ0ZJX1JFTF9PRkZTRVQJcjksUjkKKwlDRklfUkVMX09GRlNFVAlyOCxSOAorCUNGSV9S
RUxfT0ZGU0VUCXJheCxSQVgKKwlDRklfUkVMX09GRlNFVAlyY3gsUkNYCisJQ0ZJX1JFTF9PRkZT
RVQJcmR4LFJEWAorCUNGSV9SRUxfT0ZGU0VUCXJzaSxSU0kKKwlDRklfUkVMX09GRlNFVAlyZGks
UkRJCisJQ0ZJX1JFTF9PRkZTRVQJcmlwLFJJUAorCS8qQ0ZJX1JFTF9PRkZTRVQJY3MsQ1MqLwor
CS8qQ0ZJX1JFTF9PRkZTRVQJcmZsYWdzLEVGTEFHUyovCisJQ0ZJX1JFTF9PRkZTRVQJcnNwLFJT
UAorCS8qQ0ZJX1JFTF9PRkZTRVQJc3MsU1MqLwogCS5lbmRtCiAvKgogICogQSBuZXdseSBmb3Jr
ZWQgcHJvY2VzcyBkaXJlY3RseSBjb250ZXh0IHN3aXRjaGVzIGludG8gdGhpcy4KICAqLyAJCiAv
KiByZGk6CXByZXYgKi8JCiBFTlRSWShyZXRfZnJvbV9mb3JrKQotCUNGSV9TVEFSVFBST0MKIAlD
RklfREVGQVVMVF9TVEFDSwogCWNhbGwgc2NoZWR1bGVfdGFpbAogCUdFVF9USFJFQURfSU5GTygl
cmN4KQpAQCAtMTcyLDE2ICsxODIsMjEgQEAgcmZmX3RyYWNlOgogICovIAkJCSAJCQogCiBFTlRS
WShzeXN0ZW1fY2FsbCkKLQlDRklfU1RBUlRQUk9DCisJQ0ZJX1NUQVJUUFJPQwlzaW1wbGUKKwlD
RklfREVGX0NGQQlyc3AsMAorCUNGSV9SRUdJU1RFUglyaXAscmN4CisJLypDRklfUkVHSVNURVIJ
cmZsYWdzLHIxMSovCiAJc3dhcGdzCiAJbW92cQklcnNwLCVnczpwZGFfb2xkcnNwIAogCW1vdnEJ
JWdzOnBkYV9rZXJuZWxzdGFjaywlcnNwCiAJc3RpCQkJCQkKIAlTQVZFX0FSR1MgOCwxCiAJbW92
cSAgJXJheCxPUklHX1JBWC1BUkdPRkZTRVQoJXJzcCkgCi0JbW92cSAgJXJjeCxSSVAtQVJHT0ZG
U0VUKCVyc3ApICAKKwltb3ZxICAlcmN4LFJJUC1BUkdPRkZTRVQoJXJzcCkKKwlDRklfUkVMX09G
RlNFVCByaXAsUklQLUFSR09GRlNFVAogCUdFVF9USFJFQURfSU5GTyglcmN4KQogCXRlc3RsICQo
X1RJRl9TWVNDQUxMX1RSQUNFfF9USUZfU1lTQ0FMTF9BVURJVHxfVElGX1NFQ0NPTVApLHRocmVh
ZGluZm9fZmxhZ3MoJXJjeCkKKwlDRklfUkVNRU1CRVJfU1RBVEUKIAlqbnogdHJhY2VzeXMKIAlj
bXBxICRfX05SX3N5c2NhbGxfbWF4LCVyYXgKIAlqYSBiYWRzeXMKQEAgLTIwMSw5ICsyMTYsMTIg
QEAgc3lzcmV0X2NoZWNrOgkJCiAJY2xpCiAJbW92bCB0aHJlYWRpbmZvX2ZsYWdzKCVyY3gpLCVl
ZHgKIAlhbmRsICVlZGksJWVkeAorCUNGSV9SRU1FTUJFUl9TVEFURQogCWpueiAgc3lzcmV0X2Nh
cmVmdWwgCiAJbW92cSBSSVAtQVJHT0ZGU0VUKCVyc3ApLCVyY3gKKwlDRklfUkVHSVNURVIJcmlw
LHJjeAogCVJFU1RPUkVfQVJHUyAwLC1BUkdfU0tJUCwxCisJLypDRklfUkVHSVNURVIJcmZsYWdz
LHIxMSovCiAJbW92cQklZ3M6cGRhX29sZHJzcCwlcnNwCiAJc3dhcGdzCiAJc3lzcmV0cQpAQCAt
MjExLDEyICsyMjksMTUgQEAgc3lzcmV0X2NoZWNrOgkJCiAJLyogSGFuZGxlIHJlc2NoZWR1bGVz
ICovCiAJLyogZWR4Ogl3b3JrLCBlZGk6IHdvcmttYXNrICovCQogc3lzcmV0X2NhcmVmdWw6CisJ
Q0ZJX1JFU1RPUkVfU1RBVEUKIAlidCAkVElGX05FRURfUkVTQ0hFRCwlZWR4CiAJam5jIHN5c3Jl
dF9zaWduYWwKIAlzdGkKIAlwdXNocSAlcmRpCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDgKIAlj
YWxsIHNjaGVkdWxlCiAJcG9wcSAgJXJkaQorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtOAogCWpt
cCBzeXNyZXRfY2hlY2sKIAogCS8qIEhhbmRsZSBhIHNpZ25hbCAqLyAKQEAgLTIzNCw4ICsyNTUs
MTMgQEAgc3lzcmV0X3NpZ25hbDoKIDE6CW1vdmwgJF9USUZfTkVFRF9SRVNDSEVELCVlZGkKIAlq
bXAgc3lzcmV0X2NoZWNrCiAJCitiYWRzeXM6CisJbW92cSAkLUVOT1NZUyxSQVgtQVJHT0ZGU0VU
KCVyc3ApCisJam1wIHJldF9mcm9tX3N5c19jYWxsCisKIAkvKiBEbyBzeXNjYWxsIHRyYWNpbmcg
Ki8KIHRyYWNlc3lzOgkJCSAKKwlDRklfUkVTVE9SRV9TVEFURQogCVNBVkVfUkVTVAogCW1vdnEg
JC1FTk9TWVMsUkFYKCVyc3ApCiAJRklYVVBfVE9QX09GX1NUQUNLICVyZGkKQEAgLTI1NCwxNiAr
MjgwLDI5IEBAIHRyYWNlc3lzOgkJCSAKIAlSRVNUT1JFX1RPUF9PRl9TVEFDSyAlcmJ4CiAJUkVT
VE9SRV9SRVNUCiAJam1wIHJldF9mcm9tX3N5c19jYWxsCisJQ0ZJX0VORFBST0MKIAkJCi1iYWRz
eXM6Ci0JbW92cSAkLUVOT1NZUyxSQVgtQVJHT0ZGU0VUKCVyc3ApCQotCWptcCByZXRfZnJvbV9z
eXNfY2FsbAotCiAvKiAKICAqIFN5c2NhbGwgcmV0dXJuIHBhdGggZW5kaW5nIHdpdGggSVJFVC4K
ICAqIEhhcyBjb3JyZWN0IHRvcCBvZiBzdGFjaywgYnV0IHBhcnRpYWwgc3RhY2sgZnJhbWUuCiAg
Ki8gCQotRU5UUlkoaW50X3JldF9mcm9tX3N5c19jYWxsKQkKK0VOVFJZKGludF9yZXRfZnJvbV9z
eXNfY2FsbCkKKwlDRklfU1RBUlRQUk9DCXNpbXBsZQorCUNGSV9ERUZfQ0ZBCXJzcCxTUys4LUFS
R09GRlNFVAorCS8qQ0ZJX1JFTF9PRkZTRVQJc3MsU1MtQVJHT0ZGU0VUKi8KKwlDRklfUkVMX09G
RlNFVAlyc3AsUlNQLUFSR09GRlNFVAorCS8qQ0ZJX1JFTF9PRkZTRVQJcmZsYWdzLEVGTEFHUy1B
UkdPRkZTRVQqLworCS8qQ0ZJX1JFTF9PRkZTRVQJY3MsQ1MtQVJHT0ZGU0VUKi8KKwlDRklfUkVM
X09GRlNFVAlyaXAsUklQLUFSR09GRlNFVAorCUNGSV9SRUxfT0ZGU0VUCXJkeCxSRFgtQVJHT0ZG
U0VUCisJQ0ZJX1JFTF9PRkZTRVQJcmN4LFJDWC1BUkdPRkZTRVQKKwlDRklfUkVMX09GRlNFVAly
YXgsUkFYLUFSR09GRlNFVAorCUNGSV9SRUxfT0ZGU0VUCXJkaSxSREktQVJHT0ZGU0VUCisJQ0ZJ
X1JFTF9PRkZTRVQJcnNpLFJTSS1BUkdPRkZTRVQKKwlDRklfUkVMX09GRlNFVAlyOCxSOC1BUkdP
RkZTRVQKKwlDRklfUkVMX09GRlNFVAlyOSxSOS1BUkdPRkZTRVQKKwlDRklfUkVMX09GRlNFVAly
MTAsUjEwLUFSR09GRlNFVAorCUNGSV9SRUxfT0ZGU0VUCXIxMSxSMTEtQVJHT0ZGU0VUCiAJY2xp
CiAJdGVzdGwgJDMsQ1MtQVJHT0ZGU0VUKCVyc3ApCiAJamUgcmV0aW50X3Jlc3RvcmVfYXJncwpA
QCAtMjg0LDggKzMyMywxMCBAQCBpbnRfY2FyZWZ1bDoKIAlqbmMgIGludF92ZXJ5X2NhcmVmdWwK
IAlzdGkKIAlwdXNocSAlcmRpCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDgKIAljYWxsIHNjaGVk
dWxlCiAJcG9wcSAlcmRpCisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIC04CiAJY2xpCiAJam1wIGlu
dF93aXRoX2NoZWNrCiAKQEAgLTI5Nyw5ICszMzgsMTEgQEAgaW50X3ZlcnlfY2FyZWZ1bDoKIAl0
ZXN0bCAkKF9USUZfU1lTQ0FMTF9UUkFDRXxfVElGX1NZU0NBTExfQVVESVR8X1RJRl9TSU5HTEVT
VEVQKSwlZWR4CiAJanogaW50X3NpZ25hbAogCXB1c2hxICVyZGkKKwlDRklfQURKVVNUX0NGQV9P
RkZTRVQgOAogCWxlYXEgOCglcnNwKSwlcmRpCSMgJnB0cmVncyAtPiBhcmcxCQogCWNhbGwgc3lz
Y2FsbF90cmFjZV9sZWF2ZQogCXBvcHEgJXJkaQorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtOAog
CWFuZGwgJH4oX1RJRl9TWVNDQUxMX1RSQUNFfF9USUZfU1lTQ0FMTF9BVURJVHxfVElGX1NJTkdM
RVNURVApLCVlZGkKIAljbGkKIAlqbXAgaW50X3Jlc3RvcmVfcmVzdApAQCAtMzI5LDYgKzM3Miw4
IEBAIGludF9yZXN0b3JlX3Jlc3Q6CiAJam1wCXB0cmVnc2NhbGxfY29tbW9uCiAJLmVuZG0KIAor
CUNGSV9TVEFSVFBST0MKKwogCVBUUkVHU0NBTEwgc3R1Yl9jbG9uZSwgc3lzX2Nsb25lLCAlcjgK
IAlQVFJFR1NDQUxMIHN0dWJfZm9yaywgc3lzX2ZvcmssICVyZGkKIAlQVFJFR1NDQUxMIHN0dWJf
dmZvcmssIHN5c192Zm9yaywgJXJkaQpAQCAtMzM3LDQwICszODIsNDkgQEAgaW50X3Jlc3RvcmVf
cmVzdDoKIAlQVFJFR1NDQUxMIHN0dWJfaW9wbCwgc3lzX2lvcGwsICVyc2kKIAogRU5UUlkocHRy
ZWdzY2FsbF9jb21tb24pCi0JQ0ZJX1NUQVJUUFJPQwogCXBvcHEgJXIxMQotCUNGSV9BREpVU1Rf
Q0ZBX09GRlNFVAktOAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCAtOAorCUNGSV9SRUdJU1RFUiBy
aXAsIHIxMQogCVNBVkVfUkVTVAogCW1vdnEgJXIxMSwgJXIxNQorCUNGSV9SRUdJU1RFUiByaXAs
IHIxNQogCUZJWFVQX1RPUF9PRl9TVEFDSyAlcjExCiAJY2FsbCAqJXJheAogCVJFU1RPUkVfVE9Q
X09GX1NUQUNLICVyMTEKIAltb3ZxICVyMTUsICVyMTEKKwlDRklfUkVHSVNURVIgcmlwLCByMTEK
IAlSRVNUT1JFX1JFU1QKIAlwdXNocSAlcjExCi0JQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUCTgKKwlD
RklfQURKVVNUX0NGQV9PRkZTRVQgOAorCUNGSV9SRUxfT0ZGU0VUIHJpcCwgMAogCXJldAogCUNG
SV9FTkRQUk9DCiAJCiBFTlRSWShzdHViX2V4ZWN2ZSkKIAlDRklfU1RBUlRQUk9DCiAJcG9wcSAl
cjExCi0JQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUCS04CisJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIC04
CisJQ0ZJX1JFR0lTVEVSIHJpcCwgcjExCiAJU0FWRV9SRVNUCiAJbW92cSAlcjExLCAlcjE1CisJ
Q0ZJX1JFR0lTVEVSIHJpcCwgcjE1CiAJRklYVVBfVE9QX09GX1NUQUNLICVyMTEKIAljYWxsIHN5
c19leGVjdmUKIAlHRVRfVEhSRUFEX0lORk8oJXJjeCkKIAlidCAkVElGX0lBMzIsdGhyZWFkaW5m
b19mbGFncyglcmN4KQorCUNGSV9SRU1FTUJFUl9TVEFURQogCWpjIGV4ZWNfMzJiaXQKIAlSRVNU
T1JFX1RPUF9PRl9TVEFDSyAlcjExCiAJbW92cSAlcjE1LCAlcjExCisJQ0ZJX1JFR0lTVEVSIHJp
cCwgcjExCiAJUkVTVE9SRV9SRVNUCi0JcHVzaCAlcjExCisJcHVzaHEgJXIxMQorCUNGSV9BREpV
U1RfQ0ZBX09GRlNFVCA4CisJQ0ZJX1JFTF9PRkZTRVQgcmlwLCAwCiAJcmV0CiAKIGV4ZWNfMzJi
aXQ6Ci0JQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUCVJFU1RfU0tJUAorCUNGSV9SRVNUT1JFX1NUQVRF
CiAJbW92cSAlcmF4LFJBWCglcnNwKQogCVJFU1RPUkVfUkVTVAogCWptcCBpbnRfcmV0X2Zyb21f
c3lzX2NhbGwKQEAgLTM4Miw3ICs0MzYsOCBAQCBleGVjXzMyYml0OgogICovICAgICAgICAgICAg
ICAgIAogRU5UUlkoc3R1Yl9ydF9zaWdyZXR1cm4pCiAJQ0ZJX1NUQVJUUFJPQwotCWFkZHEgJDgs
ICVyc3AJCQorCWFkZHEgJDgsICVyc3AKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQJLTgKIAlTQVZF
X1JFU1QKIAltb3ZxICVyc3AsJXJkaQogCUZJWFVQX1RPUF9PRl9TVEFDSyAlcjExCkBAIC0zOTIs
NiArNDQ3LDI1IEBAIEVOVFJZKHN0dWJfcnRfc2lncmV0dXJuKQogCWptcCBpbnRfcmV0X2Zyb21f
c3lzX2NhbGwKIAlDRklfRU5EUFJPQwogCisvKgorICogaW5pdGlhbCBmcmFtZSBzdGF0ZSBmb3Ig
aW50ZXJydXB0cyBhbmQgZXhjZXB0aW9ucworICovCisJLm1hY3JvIF9mcmFtZSByZWYKKwlDRklf
U1RBUlRQUk9DIHNpbXBsZQorCUNGSV9ERUZfQ0ZBIHJzcCxTUys4LVxyZWYKKwkvKkNGSV9SRUxf
T0ZGU0VUIHNzLFNTLVxyZWYqLworCUNGSV9SRUxfT0ZGU0VUIHJzcCxSU1AtXHJlZgorCS8qQ0ZJ
X1JFTF9PRkZTRVQgcmZsYWdzLEVGTEFHUy1ccmVmKi8KKwkvKkNGSV9SRUxfT0ZGU0VUIGNzLENT
LVxyZWYqLworCUNGSV9SRUxfT0ZGU0VUIHJpcCxSSVAtXHJlZgorCS5lbmRtCisKKy8qIGluaXRp
YWwgZnJhbWUgc3RhdGUgZm9yIGludGVycnVwdHMgKGFuZCBleGNlcHRpb25zIHdpdGhvdXQgZXJy
b3IgY29kZSkgKi8KKyNkZWZpbmUgSU5UUl9GUkFNRSBfZnJhbWUgUklQCisvKiBpbml0aWFsIGZy
YW1lIHN0YXRlIGZvciBleGNlcHRpb25zIHdpdGggZXJyb3IgY29kZSAoYW5kIGludGVycnVwdHMg
d2l0aAorICAgdmVjdG9yIGFscmVhZHkgcHVzaGVkKSAqLworI2RlZmluZSBYQ1BUX0ZSQU1FIF9m
cmFtZSBPUklHX1JBWAorCiAvKiAKICAqIEludGVycnVwdCBlbnRyeS9leGl0LgogICoKQEAgLTQw
MiwxMCArNDc2LDYgQEAgRU5UUlkoc3R1Yl9ydF9zaWdyZXR1cm4pCiAKIC8qIDAoJXJzcCk6IGlu
dGVycnVwdCBudW1iZXIgKi8gCiAJLm1hY3JvIGludGVycnVwdCBmdW5jCi0JQ0ZJX1NUQVJUUFJP
QwlzaW1wbGUKLQlDRklfREVGX0NGQQlyc3AsKFNTLVJESSkKLQlDRklfUkVMX09GRlNFVAlyc3As
KFJTUC1PUklHX1JBWCkKLQlDRklfUkVMX09GRlNFVAlyaXAsKFJJUC1PUklHX1JBWCkKIAljbGQK
ICNpZmRlZiBDT05GSUdfREVCVUdfSU5GTwogCVNBVkVfQUxMCQpAQCAtNDI1LDIzICs0OTUsMjcg
QEAgRU5UUlkoc3R1Yl9ydF9zaWdyZXR1cm4pCiAJc3dhcGdzCQogMToJaW5jbAklZ3M6cGRhX2ly
cWNvdW50CSMgUkVELVBFTiBzaG91bGQgY2hlY2sgcHJlZW1wdCBjb3VudAogCW1vdnEgJWdzOnBk
YV9pcnFzdGFja3B0ciwlcmF4Ci0JY21vdmVxICVyYXgsJXJzcAkJCQkJCQkKKwljbW92ZXEgJXJh
eCwlcnNwIC8qdG9kbyBUaGlzIG5lZWRzIENGSSBhbm5vdGF0aW9uISAqLwogCXB1c2hxICVyZGkJ
CQkjIHNhdmUgb2xkIHN0YWNrCQorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVAk4CiAJY2FsbCBcZnVu
YwogCS5lbmRtCiAKIEVOVFJZKGNvbW1vbl9pbnRlcnJ1cHQpCisJWENQVF9GUkFNRQogCWludGVy
cnVwdCBkb19JUlEKIAkvKiAwKCVyc3ApOiBvbGRyc3AtQVJHT0ZGU0VUICovCi1yZXRfZnJvbV9p
bnRyOgkJCityZXRfZnJvbV9pbnRyOgogCXBvcHEgICVyZGkKKwlDRklfQURKVVNUX0NGQV9PRkZT
RVQJLTgKIAljbGkJCiAJZGVjbCAlZ3M6cGRhX2lycWNvdW50CiAjaWZkZWYgQ09ORklHX0RFQlVH
X0lORk8KIAltb3ZxIFJCUCglcmRpKSwlcmJwCisJQ0ZJX0RFRl9DRkFfUkVHSVNURVIJcnNwCiAj
ZW5kaWYKLQlsZWFxIEFSR09GRlNFVCglcmRpKSwlcnNwCi1leGl0X2ludHI6CSAJCisJbGVhcSBB
UkdPRkZTRVQoJXJkaSksJXJzcCAvKnRvZG8gVGhpcyBuZWVkcyBDRkkgYW5ub3RhdGlvbiEgKi8K
K2V4aXRfaW50cjoKIAlHRVRfVEhSRUFEX0lORk8oJXJjeCkKIAl0ZXN0bCAkMyxDUy1BUkdPRkZT
RVQoJXJzcCkKIAlqZSByZXRpbnRfa2VybmVsCkBAIC00NTMsOSArNTI3LDEwIEBAIGV4aXRfaW50
cjoJIAkKIAkgKi8JCQogcmV0aW50X3dpdGhfcmVzY2hlZHVsZToKIAltb3ZsICRfVElGX1dPUktf
TUFTSywlZWRpCi1yZXRpbnRfY2hlY2s6CQkJCityZXRpbnRfY2hlY2s6CiAJbW92bCB0aHJlYWRp
bmZvX2ZsYWdzKCVyY3gpLCVlZHgKIAlhbmRsICVlZGksJWVkeAorCUNGSV9SRU1FTUJFUl9TVEFU
RQogCWpueiAgcmV0aW50X2NhcmVmdWwKIHJldGludF9zd2FwZ3M6CSAJCiAJc3dhcGdzIApAQCAt
NDc2LDE0ICs1NTEsMTcgQEAgYmFkX2lyZXQ6CiAJam1wIGRvX2V4aXQJCQkKIAkucHJldmlvdXMJ
CiAJCi0JLyogZWRpOiB3b3JrbWFzaywgZWR4OiB3b3JrICovCQorCS8qIGVkaTogd29ya21hc2ss
IGVkeDogd29yayAqLwogcmV0aW50X2NhcmVmdWw6CisJQ0ZJX1JFU1RPUkVfU1RBVEUKIAlidCAg
ICAkVElGX05FRURfUkVTQ0hFRCwlZWR4CiAJam5jICAgcmV0aW50X3NpZ25hbAogCXN0aQogCXB1
c2hxICVyZGkKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQJOAogCWNhbGwgIHNjaGVkdWxlCiAJcG9w
cSAlcmRpCQkKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQJLTgKIAlHRVRfVEhSRUFEX0lORk8oJXJj
eCkKIAljbGkKIAlqbXAgcmV0aW50X2NoZWNrCkBAIC01MjMsNyArNjAxLDkgQEAgcmV0aW50X2tl
cm5lbDoJCiAgKiBBUElDIGludGVycnVwdHMuCiAgKi8JCQogCS5tYWNybyBhcGljaW50ZXJydXB0
IG51bSxmdW5jCisJSU5UUl9GUkFNRQogCXB1c2hxICRcbnVtLTI1NgorCUNGSV9BREpVU1RfQ0ZB
X09GRlNFVCA4CiAJaW50ZXJydXB0IFxmdW5jCiAJam1wIHJldF9mcm9tX2ludHIKIAlDRklfRU5E
UFJPQwpAQCAtNTU4LDE2ICs2MzgsMjMgQEAgRU5UUlkoc3B1cmlvdXNfaW50ZXJydXB0KQogICog
RXhjZXB0aW9uIGVudHJ5IHBvaW50cy4KICAqLyAJCQogCS5tYWNybyB6ZXJvZW50cnkgc3ltCisJ
SU5UUl9GUkFNRQogCXB1c2hxICQwCS8qIHB1c2ggZXJyb3IgY29kZS9vbGRyYXggKi8gCisJQ0ZJ
X0FESlVTVF9DRkFfT0ZGU0VUIDgKIAlwdXNocSAlcmF4CS8qIHB1c2ggcmVhbCBvbGRyYXggdG8g
dGhlIHJkaSBzbG90ICovIAorCUNGSV9BREpVU1RfQ0ZBX09GRlNFVCA4CiAJbGVhcSAgXHN5bSgl
cmlwKSwlcmF4CiAJam1wIGVycm9yX2VudHJ5CisJQ0ZJX0VORFBST0MKIAkuZW5kbQkKIAogCS5t
YWNybyBlcnJvcmVudHJ5IHN5bQorCVhDUFRfRlJBTUUKIAlwdXNocSAlcmF4CisJQ0ZJX0FESlVT
VF9DRkFfT0ZGU0VUIDgKIAlsZWFxICBcc3ltKCVyaXApLCVyYXgKIAlqbXAgZXJyb3JfZW50cnkK
KwlDRklfRU5EUFJPQwogCS5lbmRtCiAKIAkvKiBlcnJvciBjb2RlIGlzIG9uIHRoZSBzdGFjayBh
bHJlYWR5ICovCkBAIC01OTQsMTAgKzY4MSw3IEBAIEVOVFJZKHNwdXJpb3VzX2ludGVycnVwdCkK
ICAqIGFuZCB0aGUgZXhjZXB0aW9uIGhhbmRsZXIgaW4gJXJheC4JCiAgKi8gCQkgIAkJCQkKIEVO
VFJZKGVycm9yX2VudHJ5KQotCUNGSV9TVEFSVFBST0MJc2ltcGxlCi0JQ0ZJX0RFRl9DRkEJcnNw
LChTUy1SREkpCi0JQ0ZJX1JFTF9PRkZTRVQJcnNwLChSU1AtUkRJKQotCUNGSV9SRUxfT0ZGU0VU
CXJpcCwoUklQLVJESSkKKwlfZnJhbWUgUkRJCiAJLyogcmRpIHNsb3QgY29udGFpbnMgcmF4LCBv
bGRyYXggY29udGFpbnMgZXJyb3IgY29kZSAqLwogCWNsZAkKIAlzdWJxICAkMTQqOCwlcnNwCkBA
IC02NzksNyArNzYzLDkgQEAgZXJyb3Jfa2VybmVsc3BhY2U6CiAgICAgICAgLyogUmVsb2FkIGdz
IHNlbGVjdG9yIHdpdGggZXhjZXB0aW9uIGhhbmRsaW5nICovCiAgICAgICAgLyogZWRpOiAgbmV3
IHNlbGVjdG9yICovIAogRU5UUlkobG9hZF9nc19pbmRleCkKKwlDRklfU1RBUlRQUk9DCiAJcHVz
aGYKKwlDRklfQURKVVNUX0NGQV9PRkZTRVQgOAogCWNsaQogICAgICAgICBzd2FwZ3MKIGdzX2No
YW5nZTogICAgIApAQCAtNjg3LDcgKzc3Myw5IEBAIGdzX2NoYW5nZTogICAgIAogMjoJbWZlbmNl
CQkvKiB3b3JrYXJvdW5kICovCiAJc3dhcGdzCiAgICAgICAgIHBvcGYKKwlDRklfQURKVVNUX0NG
QV9PRkZTRVQgLTgKICAgICAgICAgcmV0CisJQ0ZJX0VORFBST0MKICAgICAgICAKICAgICAgICAg
LnNlY3Rpb24gX19leF90YWJsZSwiYSIKICAgICAgICAgLmFsaWduIDgKQEAgLTc5OCw3ICs4ODYs
NyBAQCBFTlRSWShkZXZpY2Vfbm90X2F2YWlsYWJsZSkKIAogCS8qIHJ1bnMgb24gZXhjZXB0aW9u
IHN0YWNrICovCiBFTlRSWShkZWJ1ZykKLQlDRklfU1RBUlRQUk9DCisJSU5UUl9GUkFNRQogCXB1
c2hxICQwCiAJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDgJCQogCXBhcmFub2lkZW50cnkgZG9fZGVi
dWcKQEAgLTgwNyw5ICs4OTUsOSBAQCBFTlRSWShkZWJ1ZykKIAogCS8qIHJ1bnMgb24gZXhjZXB0
aW9uIHN0YWNrICovCQogRU5UUlkobm1pKQotCUNGSV9TVEFSVFBST0MKKwlJTlRSX0ZSQU1FCiAJ
cHVzaHEgJC0xCi0JQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDgJCQorCUNGSV9BREpVU1RfQ0ZBX09G
RlNFVCA4CiAJcGFyYW5vaWRlbnRyeSBkb19ubWkKIAkvKgogIAkgKiAiUGFyYW5vaWQiIGV4aXQg
cGF0aCBmcm9tIGV4Y2VwdGlvbiBzdGFjay4KQEAgLTg3NCw3ICs5NjIsNyBAQCBFTlRSWShyZXNl
cnZlZCkKIAogCS8qIHJ1bnMgb24gZXhjZXB0aW9uIHN0YWNrICovCiBFTlRSWShkb3VibGVfZmF1
bHQpCi0JQ0ZJX1NUQVJUUFJPQworCVhDUFRfRlJBTUUKIAlwYXJhbm9pZGVudHJ5IGRvX2RvdWJs
ZV9mYXVsdAogCWptcCBwYXJhbm9pZF9leGl0CiAJQ0ZJX0VORFBST0MKQEAgLTg4Nyw3ICs5NzUs
NyBAQCBFTlRSWShzZWdtZW50X25vdF9wcmVzZW50KQogCiAJLyogcnVucyBvbiBleGNlcHRpb24g
c3RhY2sgKi8KIEVOVFJZKHN0YWNrX3NlZ21lbnQpCi0JQ0ZJX1NUQVJUUFJPQworCVhDUFRfRlJB
TUUKIAlwYXJhbm9pZGVudHJ5IGRvX3N0YWNrX3NlZ21lbnQKIAlqbXAgcGFyYW5vaWRfZXhpdAog
CUNGSV9FTkRQUk9DCkBAIC05MDcsNyArOTk1LDcgQEAgRU5UUlkoc3B1cmlvdXNfaW50ZXJydXB0
X2J1ZykKICNpZmRlZiBDT05GSUdfWDg2X01DRQogCS8qIHJ1bnMgb24gZXhjZXB0aW9uIHN0YWNr
ICovCiBFTlRSWShtYWNoaW5lX2NoZWNrKQotCUNGSV9TVEFSVFBST0MKKwlJTlRSX0ZSQU1FCiAJ
cHVzaHEgJDAKIAlDRklfQURKVVNUX0NGQV9PRkZTRVQgOAkKIAlwYXJhbm9pZGVudHJ5IGRvX21h
Y2hpbmVfY2hlY2sKQEAgLTkxOSwxNCArMTAwNywxOSBAQCBFTlRSWShjYWxsX2RlYnVnKQogICAg
ICAgIHplcm9lbnRyeSBkb19jYWxsX2RlYnVnCiAKIEVOVFJZKGNhbGxfc29mdGlycSkKKwlDRklf
U1RBUlRQUk9DCiAJbW92cSAlZ3M6cGRhX2lycXN0YWNrcHRyLCVyYXgKIAlwdXNocSAlcjE1CisJ
Q0ZJX0FESlVTVF9DRkFfT0ZGU0VUIDgKIAltb3ZxICVyc3AsJXIxNQorCUNGSV9ERUZfQ0ZBX1JF
R0lTVEVSCXIxNQogCWluY2wgJWdzOnBkYV9pcnFjb3VudAogCWNtb3ZlICVyYXgsJXJzcAogCWNh
bGwgX19kb19zb2Z0aXJxCiAJbW92cSAlcjE1LCVyc3AKKwlDRklfREVGX0NGQV9SRUdJU1RFUgly
c3AKIAlkZWNsICVnczpwZGFfaXJxY291bnQKIAlwb3BxICVyMTUKKwlDRklfQURKVVNUX0NGQV9P
RkZTRVQgLTgKIAlyZXQKLQorCUNGSV9FTkRQUk9DCmRpZmYgLU5wcnUgMi42LjEzL2FyY2gveDg2
XzY0L2tlcm5lbC92bWxpbnV4Lmxkcy5TIDIuNi4xMy14ODZfNjQtY2ZpL2FyY2gveDg2XzY0L2tl
cm5lbC92bWxpbnV4Lmxkcy5TCi0tLSAyLjYuMTMvYXJjaC94ODZfNjQva2VybmVsL3ZtbGludXgu
bGRzLlMJMjAwNS0wOC0yOSAwMTo0MTowMS4wMDAwMDAwMDAgKzAyMDAKKysrIDIuNi4xMy14ODZf
NjQtY2ZpL2FyY2gveDg2XzY0L2tlcm5lbC92bWxpbnV4Lmxkcy5TCTIwMDUtMDktMDUgMTY6MTk6
MjUuMDAwMDAwMDAwICswMjAwCkBAIC0xODgsNyArMTg4LDcgQEAgU0VDVElPTlMKICAgLyogU2Vj
dGlvbnMgdG8gYmUgZGlzY2FyZGVkICovCiAgIC9ESVNDQVJELyA6IHsKIAkqKC5leGl0Y2FsbC5l
eGl0KQotI2lmbmRlZiBDT05GSUdfREVCVUdfSU5GTworI2lmbmRlZiBDT05GSUdfVU5XSU5EX0lO
Rk8KIAkqKC5laF9mcmFtZSkKICNlbmRpZgogCX0KZGlmZiAtTnBydSAyLjYuMTMvYXJjaC94ODZf
NjQvTWFrZWZpbGUgMi42LjEzLXg4Nl82NC1jZmkvYXJjaC94ODZfNjQvTWFrZWZpbGUKLS0tIDIu
Ni4xMy9hcmNoL3g4Nl82NC9NYWtlZmlsZQkyMDA1LTA4LTI5IDAxOjQxOjAxLjAwMDAwMDAwMCAr
MDIwMAorKysgMi42LjEzLXg4Nl82NC1jZmkvYXJjaC94ODZfNjQvTWFrZWZpbGUJMjAwNS0wOS0w
MSAxMTozMjoxMS4wMDAwMDAwMDAgKzAyMDAKQEAgLTM4LDggKzM4LDEwIEBAIENGTEFHUyArPSAt
cGlwZQogIyBhY3R1YWxseSBpdCBtYWtlcyB0aGUga2VybmVsIHNtYWxsZXIgdG9vLgogQ0ZMQUdT
ICs9IC1mbm8tcmVvcmRlci1ibG9ja3MJCiBDRkxBR1MgKz0gLVduby1zaWduLWNvbXBhcmUKLWlm
bmVxICgkKENPTkZJR19ERUJVR19JTkZPKSx5KQoraWZuZXEgKCQoQ09ORklHX1VOV0lORF9JTkZP
KSx5KQogQ0ZMQUdTICs9IC1mbm8tYXN5bmNocm9ub3VzLXVud2luZC10YWJsZXMKK2VuZGlmCitp
Zm5lcSAoJChDT05GSUdfREVCVUdfSU5GTykseSkKICMgLWZ3ZWIgc2hyaW5rcyB0aGUga2VybmVs
IGEgYml0LCBidXQgdGhlIGRpZmZlcmVuY2UgaXMgdmVyeSBzbWFsbAogIyBpdCBhbHNvIG1lc3Nl
cyB1cCBkZWJ1Z2dpbmcsIHNvIGRvbid0IHVzZSBpdCBmb3Igbm93LgogI0NGTEFHUyArPSAkKGNh
bGwgY2Mtb3B0aW9uLC1md2ViKQpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2FzbS14ODZfNjQv
Y2FsbGluZy5oIDIuNi4xMy14ODZfNjQtY2ZpL2luY2x1ZGUvYXNtLXg4Nl82NC9jYWxsaW5nLmgK
LS0tIDIuNi4xMy9pbmNsdWRlL2FzbS14ODZfNjQvY2FsbGluZy5oCTIwMDUtMDgtMjkgMDE6NDE6
MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMteDg2XzY0LWNmaS9pbmNsdWRlL2FzbS14ODZf
NjQvY2FsbGluZy5oCTIwMDUtMDMtMTggMTQ6MTU6NTIuMDAwMDAwMDAwICswMTAwCkBAIC02NSwy
NyArNjUsMzYgQEAKIAkuaWYgXHNraXByMTEKIAkuZWxzZQogCW1vdnEgKCVyc3ApLCVyMTEKKwlD
RklfUkVTVE9SRSByMTEKIAkuZW5kaWYKIAkuaWYgXHNraXByODkxMAogCS5lbHNlCiAJbW92cSAx
KjgoJXJzcCksJXIxMAorCUNGSV9SRVNUT1JFIHIxMAogCW1vdnEgMio4KCVyc3ApLCVyOQorCUNG
SV9SRVNUT1JFIHI5CiAJbW92cSAzKjgoJXJzcCksJXI4CisJQ0ZJX1JFU1RPUkUgcjgKIAkuZW5k
aWYKIAkuaWYgXHNraXByYXgKIAkuZWxzZQogCW1vdnEgNCo4KCVyc3ApLCVyYXgKKwlDRklfUkVT
VE9SRSByYXgKIAkuZW5kaWYKIAkuaWYgXHNraXByY3gKIAkuZWxzZQogCW1vdnEgNSo4KCVyc3Ap
LCVyY3gKKwlDRklfUkVTVE9SRSByY3gKIAkuZW5kaWYKIAkuaWYgXHNraXByZHgKIAkuZWxzZQog
CW1vdnEgNio4KCVyc3ApLCVyZHgKKwlDRklfUkVTVE9SRSByZHgKIAkuZW5kaWYKIAltb3ZxIDcq
OCglcnNwKSwlcnNpCisJQ0ZJX1JFU1RPUkUgcnNpCiAJbW92cSA4KjgoJXJzcCksJXJkaQorCUNG
SV9SRVNUT1JFIHJkaQogCS5pZiBBUkdfU0tJUCtcYWRkc2tpcCA+IDAKIAlhZGRxICRBUkdfU0tJ
UCtcYWRkc2tpcCwlcnNwCiAJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUCS0oQVJHX1NLSVArXGFkZHNr
aXApCkBAIC0xMjQsMTEgKzEzMywxNyBAQAogCiAJLm1hY3JvIFJFU1RPUkVfUkVTVAogCW1vdnEg
KCVyc3ApLCVyMTUKKwlDRklfUkVTVE9SRSByMTUKIAltb3ZxIDEqOCglcnNwKSwlcjE0CisJQ0ZJ
X1JFU1RPUkUgcjE0CiAJbW92cSAyKjgoJXJzcCksJXIxMworCUNGSV9SRVNUT1JFIHIxMwogCW1v
dnEgMyo4KCVyc3ApLCVyMTIKKwlDRklfUkVTVE9SRSByMTIKIAltb3ZxIDQqOCglcnNwKSwlcmJw
CisJQ0ZJX1JFU1RPUkUgcmJwCiAJbW92cSA1KjgoJXJzcCksJXJieAorCUNGSV9SRVNUT1JFIHJi
eAogCWFkZHEgJFJFU1RfU0tJUCwlcnNwCiAJQ0ZJX0FESlVTVF9DRkFfT0ZGU0VUCS0oUkVTVF9T
S0lQKQogCS5lbmRtCkBAIC0xNDYsMTEgKzE2MSwzIEBACiAJLm1hY3JvIGljZWJwCiAJLmJ5dGUg
MHhmMQogCS5lbmRtCi0KLSNpZmRlZiBDT05GSUdfRlJBTUVfUE9JTlRFUgotI2RlZmluZSBFTlRF
UiBlbnRlcgotI2RlZmluZSBMRUFWRSBsZWF2ZQotI2Vsc2UKLSNkZWZpbmUgRU5URVIKLSNkZWZp
bmUgTEVBVkUKLSNlbmRpZgpkaWZmIC1OcHJ1IDIuNi4xMy9pbmNsdWRlL2FzbS14ODZfNjQvZHdh
cmYyLmggMi42LjEzLXg4Nl82NC1jZmkvaW5jbHVkZS9hc20teDg2XzY0L2R3YXJmMi5oCi0tLSAy
LjYuMTMvaW5jbHVkZS9hc20teDg2XzY0L2R3YXJmMi5oCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAw
MDAwMDAwICswMjAwCisrKyAyLjYuMTMteDg2XzY0LWNmaS9pbmNsdWRlL2FzbS14ODZfNjQvZHdh
cmYyLmgJMjAwNS0wMy0xNiAxMjoyNDo0Mi4wMDAwMDAwMDAgKzAxMDAKQEAgLTE0LDcgKzE0LDcg
QEAKICAgIGF3YXkgZm9yIG9sZGVyIHZlcnNpb24uIAogICovCiAKLSNpZmRlZiBDT05GSUdfREVC
VUdfSU5GTworI2lmZGVmIENPTkZJR19VTldJTkRfSU5GTwogCiAjZGVmaW5lIENGSV9TVEFSVFBS
T0MgLmNmaV9zdGFydHByb2MKICNkZWZpbmUgQ0ZJX0VORFBST0MgLmNmaV9lbmRwcm9jCkBAIC0y
NCw2ICsyNCwxMCBAQAogI2RlZmluZSBDRklfQURKVVNUX0NGQV9PRkZTRVQgLmNmaV9hZGp1c3Rf
Y2ZhX29mZnNldAogI2RlZmluZSBDRklfT0ZGU0VUIC5jZmlfb2Zmc2V0CiAjZGVmaW5lIENGSV9S
RUxfT0ZGU0VUIC5jZmlfcmVsX29mZnNldAorI2RlZmluZSBDRklfUkVHSVNURVIgLmNmaV9yZWdp
c3RlcgorI2RlZmluZSBDRklfUkVTVE9SRSAuY2ZpX3Jlc3RvcmUKKyNkZWZpbmUgQ0ZJX1JFTUVN
QkVSX1NUQVRFIC5jZmlfcmVtZW1iZXJfc3RhdGUKKyNkZWZpbmUgQ0ZJX1JFU1RPUkVfU1RBVEUg
LmNmaV9yZXN0b3JlX3N0YXRlCiAKICNlbHNlCiAKQEAgLTM2LDYgKzQwLDEwIEBACiAjZGVmaW5l
IENGSV9BREpVU1RfQ0ZBX09GRlNFVAkjCiAjZGVmaW5lIENGSV9PRkZTRVQJIwogI2RlZmluZSBD
RklfUkVMX09GRlNFVAkjCisjZGVmaW5lIENGSV9SRUdJU1RFUgkjCisjZGVmaW5lIENGSV9SRVNU
T1JFCSMKKyNkZWZpbmUgQ0ZJX1JFTUVNQkVSX1NUQVRFCSMKKyNkZWZpbmUgQ0ZJX1JFU1RPUkVf
U1RBVEUJIwogCiAjZW5kaWYKIApkaWZmIC1OcHJ1IDIuNi4xMy9saWIvS2NvbmZpZy5kZWJ1ZyAy
LjYuMTMteDg2XzY0LWNmaS9saWIvS2NvbmZpZy5kZWJ1ZwotLS0gMi42LjEzL2xpYi9LY29uZmln
LmRlYnVnCTIwMDUtMDgtMjkgMDE6NDE6MDEuMDAwMDAwMDAwICswMjAwCisrKyAyLjYuMTMteDg2
XzY0LWNmaS9saWIvS2NvbmZpZy5kZWJ1ZwkyMDA1LTA5LTA3IDEzOjI2OjU4LjAwMDAwMDAwMCAr
MDIwMApAQCAtMTU5LDMgKzE1OSwxMiBAQCBjb25maWcgRlJBTUVfUE9JTlRFUgogCSAgSWYgeW91
IGRvbid0IGRlYnVnIHRoZSBrZXJuZWwsIHlvdSBjYW4gc2F5IE4sIGJ1dCB3ZSBtYXkgbm90IGJl
IGFibGUKIAkgIHRvIHNvbHZlIHByb2JsZW1zIHdpdGhvdXQgZnJhbWUgcG9pbnRlcnMuCiAKK2Nv
bmZpZyBVTldJTkRfSU5GTworCWJvb2wgIkNvbXBpbGUgdGhlIGtlcm5lbCB3aXRoIGZyYW1lIHVu
d2luZCBpbmZvcm1hdGlvbiIgaWYgIUlBNjQKKwlkZWZhdWx0IERFQlVHX0tFUk5FTCAmJiAhSUE2
NAorCWhlbHAKKwkgIElmIHlvdSBzYXkgWSBoZXJlIHRoZSByZXN1bHRpbmcga2VybmVsIGltYWdl
IHdpbGwgYmUgc2xpZ2h0bHkgbGFyZ2VyCisJICBidXQgbm90IHNsb3dlciwgYW5kIGl0IHdpbGwg
Z2l2ZSB2ZXJ5IHVzZWZ1bCBkZWJ1Z2dpbmcgaW5mb3JtYXRpb24uCisJICBJZiB5b3UgZG9uJ3Qg
ZGVidWcgdGhlIGtlcm5lbCwgeW91IGNhbiBzYXkgTiwgYnV0IHdlIG1heSBub3QgYmUgYWJsZQor
CSAgdG8gc29sdmUgcHJvYmxlbXMgd2l0aG91dCBmcmFtZSB1bndpbmQgaW5mb3JtYXRpb24gb3Ig
ZnJhbWUgcG9pbnRlcnMuCisK

--=__Part06246853.1__=--
