Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750944AbVK3E0E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750944AbVK3E0E (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Nov 2005 23:26:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750941AbVK3EZU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Nov 2005 23:25:20 -0500
Received: from kanga.kvack.org ([66.96.29.28]:27624 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1750944AbVK3EZH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Nov 2005 23:25:07 -0500
Date: Tue, 29 Nov 2005 23:22:18 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH 9/9] x86-64 optimize GET_THREAD_INFO users to use r10
Message-ID: <20051130042218.GJ19112@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Now that current in r10 is in place and working, optimize bits of x86-64
specific assembly to not reload/recalculate current where unnecessary.

---

 arch/x86_64/ia32/ia32entry.S |   16 ++++++++--------
 arch/x86_64/kernel/entry.S   |   39 ++++++++++++++-------------------------
 arch/x86_64/lib/copy_user.S  |    6 ++----
 arch/x86_64/lib/getuser.S    |   12 ++++--------
 arch/x86_64/lib/putuser.S    |   12 ++++--------
 5 files changed, 32 insertions(+), 53 deletions(-)

applies-to: d8b8d8a196d1608edcd5ea682f2d1c99e209ebc0
d30adbf231158a79cff30c8786bdb4dbd62d76d6
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index cdb5918..222076a 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -85,13 +85,13 @@ ENTRY(ia32_sysenter_target)
 	CFI_ADJUST_CFA_OFFSET 8
 	cld
 	SAVE_ARGS 0,0,1
+	movq    %gs:pda_pcurrent,%r10
  	/* no need to do an access_ok check here because rbp has been
  	   32bit zero extended */ 
 1:	movl	(%rbp),%r9d
  	.section __ex_table,"a"
  	.quad 1b,ia32_badarg
  	.previous	
-	GET_THREAD_INFO(%r10)
 	testl  $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
 	CFI_REMEMBER_STATE
 	jnz  sysenter_tracesys
@@ -99,10 +99,8 @@ sysenter_do_call:	
 	cmpl	$(IA32_NR_syscalls),%eax
 	jae	ia32_badsys
 	IA32_ARG_FIXUP 1
-	movq    %gs:pda_pcurrent,%r10
 	call	*ia32_sys_call_table(,%rax,8)
 	movq	%rax,RAX-ARGOFFSET(%rsp)
-	GET_THREAD_INFO(%r10)
 	cli
 	testl	$_TIF_ALLWORK_MASK,threadinfo_flags(%r10)
 	jnz	int_ret_from_sys_call
@@ -139,6 +137,7 @@ sysenter_tracesys:
 	.section __ex_table,"a"
 	.quad 1b,ia32_badarg
 	.previous
+	movq    %gs:pda_pcurrent,%r10
 	jmp	sysenter_do_call
 	CFI_ENDPROC
 
@@ -192,7 +191,7 @@ ENTRY(ia32_cstar_target)
 	.section __ex_table,"a"
 	.quad 1b,ia32_badarg
 	.previous	
-	GET_THREAD_INFO(%r10)
+	movq    %gs:pda_pcurrent,%r10
 	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
 	CFI_REMEMBER_STATE
 	jnz   cstar_tracesys
@@ -200,10 +199,8 @@ cstar_do_call:	
 	cmpl $IA32_NR_syscalls,%eax
 	jae  ia32_badsys
 	IA32_ARG_FIXUP 1
-	movq    %gs:pda_pcurrent,%r10
 	call *ia32_sys_call_table(,%rax,8)
 	movq %rax,RAX-ARGOFFSET(%rsp)
-	GET_THREAD_INFO(%r10)
 	cli
 	testl $_TIF_ALLWORK_MASK,threadinfo_flags(%r10)
 	jnz  int_ret_from_sys_call
@@ -234,10 +231,12 @@ cstar_tracesys:	
 	.section __ex_table,"a"
 	.quad 1b,ia32_badarg
 	.previous
+	movq    %gs:pda_pcurrent,%r10
 	jmp cstar_do_call
 				
 ia32_badarg:
 	movq $-EFAULT,%rax
+	movq    %gs:pda_pcurrent,%r10
 	jmp ia32_sysret
 	CFI_ENDPROC
 
@@ -279,14 +278,13 @@ ENTRY(ia32_syscall)
 	/* note the registers are not zero extended to the sf.
 	   this could be a problem. */
 	SAVE_ARGS 0,0,1
-	GET_THREAD_INFO(%r10)
+	movq    %gs:pda_pcurrent,%r10
 	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
 	jnz ia32_tracesys
 ia32_do_syscall:	
 	cmpl $(IA32_NR_syscalls),%eax
 	jae  ia32_badsys
 	IA32_ARG_FIXUP
-	movq    %gs:pda_pcurrent,%r10
 	call *ia32_sys_call_table(,%rax,8) # xxx: rip relative
 ia32_sysret:
 	movq %rax,RAX-ARGOFFSET(%rsp)
@@ -300,6 +298,7 @@ ia32_tracesys:			 
 	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
+	movq    %gs:pda_pcurrent,%r10
 	jmp ia32_do_syscall
 
 ia32_badsys:
@@ -345,6 +344,7 @@ ENTRY(ia32_ptregs_common)
 	movq    %gs:pda_pcurrent,%r10
 	call *%rax
 	RESTORE_REST
+	movq    %gs:pda_pcurrent,%r10
 	jmp  ia32_sysret	/* misbalances the return cache */
 	CFI_ENDPROC
 
diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index b2cec61..5340696 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -136,21 +136,19 @@
 ENTRY(ret_from_fork)
 	CFI_DEFAULT_STACK
 	call schedule_tail
-	GET_THREAD_INFO(%rcx)
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),threadinfo_flags(%rcx)
+	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT),threadinfo_flags(%r10)
 	jnz rff_trace
 rff_action:	
 	RESTORE_REST
 	testl $3,CS-ARGOFFSET(%rsp)	# from kernel_thread?
 	je   int_ret_from_sys_call
-	testl $_TIF_IA32,threadinfo_flags(%rcx)
+	testl $_TIF_IA32,threadinfo_flags(%r10)
 	jnz  int_ret_from_sys_call
 	RESTORE_TOP_OF_STACK %rdi,ARGOFFSET
 	jmp ret_from_sys_call
 rff_trace:
 	movq %rsp,%rdi
 	call syscall_trace_leave
-	GET_THREAD_INFO(%rcx)	
 	jmp rff_action
 	CFI_ENDPROC
 
@@ -194,11 +192,10 @@ ENTRY(system_call)
 	movq  %rax,ORIG_RAX-ARGOFFSET(%rsp) 
 	movq  %rcx,RIP-ARGOFFSET(%rsp)
 	CFI_REL_OFFSET rip,RIP-ARGOFFSET
-	GET_THREAD_INFO(%rcx)
-	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%rcx)
-	CFI_REMEMBER_STATE
 	movq %r10,%rcx
 	movq	%gs:pda_pcurrent,%r10
+	testl $(_TIF_SYSCALL_TRACE|_TIF_SYSCALL_AUDIT|_TIF_SECCOMP),threadinfo_flags(%r10)
+	CFI_REMEMBER_STATE
 	jnz tracesys
 	cmpq $__NR_syscall_max,%rax
 	ja badsys
@@ -213,9 +210,8 @@ ret_from_sys_call:
 	movl $_TIF_ALLWORK_MASK,%edi
 	/* edi:	flagmask */
 sysret_check:		
-	GET_THREAD_INFO(%rcx)
 	cli
-	movl threadinfo_flags(%rcx),%edx
+	movl threadinfo_flags(%r10),%edx
 	andl %edi,%edx
 	CFI_REMEMBER_STATE
 	jnz  sysret_careful 
@@ -271,10 +267,10 @@ tracesys:			 
 	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
-	cmpq $__NR_syscall_max,%rax
-	ja  1f
 	movq %r10,%rcx	/* fixup for C */
 	movq	%gs:pda_pcurrent,%r10
+	cmpq $__NR_syscall_max,%rax
+	ja  1f
 	call *sys_call_table(,%rax,8)
 	movq %rax,RAX-ARGOFFSET(%rsp)
 1:	SAVE_REST
@@ -312,8 +308,7 @@ ENTRY(int_ret_from_sys_call)
 	movl $_TIF_ALLWORK_MASK,%edi
 	/* edi:	mask to check */
 int_with_check:
-	GET_THREAD_INFO(%rcx)
-	movl threadinfo_flags(%rcx),%edx
+	movl threadinfo_flags(%r10),%edx
 	andl %edi,%edx
 	jnz   int_careful
 	jmp   retint_swapgs
@@ -413,8 +408,7 @@ ENTRY(stub_execve)
 	CFI_REGISTER rip, r15
 	FIXUP_TOP_OF_STACK %r11
 	call sys_execve
-	GET_THREAD_INFO(%rcx)
-	bt $TIF_IA32,threadinfo_flags(%rcx)
+	bt $TIF_IA32,threadinfo_flags(%r10)
 	CFI_REMEMBER_STATE
 	jc exec_32bit
 	RESTORE_TOP_OF_STACK %r11
@@ -520,7 +514,6 @@ ret_from_intr:
 #endif
 	leaq ARGOFFSET(%rdi),%rsp /*todo This needs CFI annotation! */
 exit_intr:
-	GET_THREAD_INFO(%rcx)
 	testl $3,CS-ARGOFFSET(%rsp)
 	je retint_kernel
 	
@@ -532,7 +525,7 @@ exit_intr:
 retint_with_reschedule:
 	movl $_TIF_WORK_MASK,%edi
 retint_check:
-	movl threadinfo_flags(%rcx),%edx
+	movl threadinfo_flags(%r10),%edx
 	andl %edi,%edx
 	CFI_REMEMBER_STATE
 	jnz  retint_careful
@@ -566,7 +559,6 @@ retint_careful:
 	call  schedule
 	popq %rdi		
 	CFI_ADJUST_CFA_OFFSET	-8
-	GET_THREAD_INFO(%rcx)
 	cli
 	jmp retint_check
 	
@@ -582,7 +574,6 @@ retint_signal:
 	RESTORE_REST
 	cli
 	movl $_TIF_NEED_RESCHED,%edi
-	GET_THREAD_INFO(%rcx)
 	jmp retint_check
 
 #ifdef CONFIG_PREEMPT
@@ -590,9 +581,9 @@ retint_signal:
 	/* rcx:	 threadinfo. interrupts off. */
 	.p2align
 retint_kernel:	
-	cmpl $0,threadinfo_preempt_count(%rcx)
+	cmpl $0,threadinfo_preempt_count(%r10)
 	jnz  retint_restore_args
-	bt  $TIF_NEED_RESCHED,threadinfo_flags(%rcx)
+	bt  $TIF_NEED_RESCHED,threadinfo_flags(%r10)
 	jnc  retint_restore_args
 	bt   $9,EFLAGS-ARGOFFSET(%rsp)	/* interrupts off? */
 	jnc  retint_restore_args
@@ -751,10 +742,9 @@ error_exit:		
 	movl %ebx,%eax		
 	RESTORE_REST
 	cli
-	GET_THREAD_INFO(%rcx)	
 	testl %eax,%eax
 	jne  retint_kernel
-	movl  threadinfo_flags(%rcx),%edx
+	movl  threadinfo_flags(%r10),%edx
 	movl  $_TIF_WORK_MASK,%edi
 	andl  %edi,%edx
 	jnz  retint_careful
@@ -942,8 +932,7 @@ paranoid_restore:	
 	RESTORE_ALL 8
 	iretq
 paranoid_userspace:	
-	GET_THREAD_INFO(%rcx)
-	movl threadinfo_flags(%rcx),%ebx
+	movl threadinfo_flags(%r10),%ebx
 	andl $_TIF_WORK_MASK,%ebx
 	jz paranoid_swapgs
 	movq %rsp,%rdi			/* &pt_regs */
diff --git a/arch/x86_64/lib/copy_user.S b/arch/x86_64/lib/copy_user.S
index f24497d..f69bdd5 100644
--- a/arch/x86_64/lib/copy_user.S
+++ b/arch/x86_64/lib/copy_user.S
@@ -15,11 +15,10 @@
 	.globl copy_to_user
 	.p2align 4	
 copy_to_user:
-	GET_THREAD_INFO(%rax)
 	movq %rdi,%rcx
 	addq %rdx,%rcx
 	jc  bad_to_user
-	cmpq threadinfo_addr_limit(%rax),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae bad_to_user
 2:	
 	.byte 0xe9	/* 32bit jump */
@@ -43,11 +42,10 @@ copy_to_user:
 	.globl copy_from_user
 	.p2align 4	
 copy_from_user:
-	GET_THREAD_INFO(%rax)
 	movq %rsi,%rcx
 	addq %rdx,%rcx
 	jc  bad_from_user
-	cmpq threadinfo_addr_limit(%rax),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae  bad_from_user
 	/* FALL THROUGH to copy_user_generic */
 	
diff --git a/arch/x86_64/lib/getuser.S b/arch/x86_64/lib/getuser.S
index 3844d5e..f8cbd9f 100644
--- a/arch/x86_64/lib/getuser.S
+++ b/arch/x86_64/lib/getuser.S
@@ -36,8 +36,7 @@
 	.p2align 4
 .globl __get_user_1
 __get_user_1:	
-	GET_THREAD_INFO(%r8)
-	cmpq threadinfo_addr_limit(%r8),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae bad_get_user
 1:	movzb (%rcx),%edx
 	xorl %eax,%eax
@@ -46,10 +45,9 @@ __get_user_1:	
 	.p2align 4
 .globl __get_user_2
 __get_user_2:
-	GET_THREAD_INFO(%r8)
 	addq $1,%rcx
 	jc 20f
-	cmpq threadinfo_addr_limit(%r8),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae 20f
 	decq   %rcx
 2:	movzwl (%rcx),%edx
@@ -61,10 +59,9 @@ __get_user_2:
 	.p2align 4
 .globl __get_user_4
 __get_user_4:
-	GET_THREAD_INFO(%r8)
 	addq $3,%rcx
 	jc 30f
-	cmpq threadinfo_addr_limit(%r8),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae 30f
 	subq $3,%rcx
 3:	movl (%rcx),%edx
@@ -76,10 +73,9 @@ __get_user_4:
 	.p2align 4
 .globl __get_user_8
 __get_user_8:
-	GET_THREAD_INFO(%r8)
 	addq $7,%rcx
 	jc 40f
-	cmpq threadinfo_addr_limit(%r8),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae	40f
 	subq	$7,%rcx
 4:	movq (%rcx),%rdx
diff --git a/arch/x86_64/lib/putuser.S b/arch/x86_64/lib/putuser.S
index 7f55939..4de4e34 100644
--- a/arch/x86_64/lib/putuser.S
+++ b/arch/x86_64/lib/putuser.S
@@ -34,8 +34,7 @@
 	.p2align 4
 .globl __put_user_1
 __put_user_1:
-	GET_THREAD_INFO(%r8)
-	cmpq threadinfo_addr_limit(%r8),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae bad_put_user
 1:	movb %dl,(%rcx)
 	xorl %eax,%eax
@@ -44,10 +43,9 @@ __put_user_1:
 	.p2align 4
 .globl __put_user_2
 __put_user_2:
-	GET_THREAD_INFO(%r8)
 	addq $1,%rcx
 	jc 20f
-	cmpq threadinfo_addr_limit(%r8),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae 20f
 	decq %rcx
 2:	movw %dx,(%rcx)
@@ -59,10 +57,9 @@ __put_user_2:
 	.p2align 4
 .globl __put_user_4
 __put_user_4:
-	GET_THREAD_INFO(%r8)
 	addq $3,%rcx
 	jc 30f
-	cmpq threadinfo_addr_limit(%r8),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae 30f
 	subq $3,%rcx
 3:	movl %edx,(%rcx)
@@ -74,10 +71,9 @@ __put_user_4:
 	.p2align 4
 .globl __put_user_8
 __put_user_8:
-	GET_THREAD_INFO(%r8)
 	addq $7,%rcx
 	jc 40f
-	cmpq threadinfo_addr_limit(%r8),%rcx
+	cmpq threadinfo_addr_limit(%r10),%rcx
 	jae 40f
 	subq $7,%rcx
 4:	movq %rdx,(%rcx)
---
0.99.9.GIT
