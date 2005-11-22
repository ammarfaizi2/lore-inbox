Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965002AbVKVQyj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965002AbVKVQyj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 11:54:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965006AbVKVQyj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 11:54:39 -0500
Received: from kanga.kvack.org ([66.96.29.28]:52387 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S965002AbVKVQyi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 11:54:38 -0500
Date: Tue, 22 Nov 2005 11:52:04 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: rfc/rft: use r10 as current on x86-64
Message-ID: <20051122165204.GG1127@kvack.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Andi et al,

The patch below converts x86-64 to use r10 as the current pointer instead 
of gs:pcurrent.  This results in a ~34KB savings in the code segment of 
the kernel.  I've tested this with running a few regular applications, 
plus a few 32 bit binaries.  If this patch is interesting, it probably 
makes sense to merge the thread info structure into the task_struct so 
that the assembly bits for syscall entry can be cleaned up.  Comments?

		-ben
-- 
"Time is what keeps everything from happening all at once." -- John Wheeler
Don't Email: <dont@kvack.org>.


diff --git a/arch/x86_64/Makefile b/arch/x86_64/Makefile
index a9cd42e..e547830 100644
--- a/arch/x86_64/Makefile
+++ b/arch/x86_64/Makefile
@@ -31,6 +31,7 @@ cflags-$(CONFIG_MK8) += $(call cc-option
 cflags-$(CONFIG_MPSC) += $(call cc-option,-march=nocona)
 CFLAGS += $(cflags-y)
 
+CFLAGS += -ffixed-r10
 CFLAGS += -mno-red-zone
 CFLAGS += -mcmodel=kernel
 CFLAGS += -pipe
diff --git a/arch/x86_64/ia32/ia32entry.S b/arch/x86_64/ia32/ia32entry.S
index e0eb0c7..cdb5918 100644
--- a/arch/x86_64/ia32/ia32entry.S
+++ b/arch/x86_64/ia32/ia32entry.S
@@ -99,6 +99,7 @@ sysenter_do_call:	
 	cmpl	$(IA32_NR_syscalls),%eax
 	jae	ia32_badsys
 	IA32_ARG_FIXUP 1
+	movq    %gs:pda_pcurrent,%r10
 	call	*ia32_sys_call_table(,%rax,8)
 	movq	%rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
@@ -127,6 +128,7 @@ sysenter_tracesys:
 	CLEAR_RREGS
 	movq	$-ENOSYS,RAX(%rsp)	/* really needed? */
 	movq	%rsp,%rdi        /* &pt_regs -> arg1 */
+	movq    %gs:pda_pcurrent,%r10
 	call	syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
@@ -198,6 +200,7 @@ cstar_do_call:	
 	cmpl $IA32_NR_syscalls,%eax
 	jae  ia32_badsys
 	IA32_ARG_FIXUP 1
+	movq    %gs:pda_pcurrent,%r10
 	call *ia32_sys_call_table(,%rax,8)
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
@@ -220,6 +223,7 @@ cstar_tracesys:	
 	CLEAR_RREGS
 	movq $-ENOSYS,RAX(%rsp)	/* really needed? */
 	movq %rsp,%rdi        /* &pt_regs -> arg1 */
+	movq    %gs:pda_pcurrent,%r10
 	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
@@ -282,6 +286,7 @@ ia32_do_syscall:	
 	cmpl $(IA32_NR_syscalls),%eax
 	jae  ia32_badsys
 	IA32_ARG_FIXUP
+	movq    %gs:pda_pcurrent,%r10
 	call *ia32_sys_call_table(,%rax,8) # xxx: rip relative
 ia32_sysret:
 	movq %rax,RAX-ARGOFFSET(%rsp)
@@ -291,6 +296,7 @@ ia32_tracesys:			 
 	SAVE_REST
 	movq $-ENOSYS,RAX(%rsp)	/* really needed? */
 	movq %rsp,%rdi        /* &pt_regs -> arg1 */
+	movq    %gs:pda_pcurrent,%r10
 	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
@@ -336,6 +342,7 @@ ENTRY(ia32_ptregs_common)
 	CFI_ADJUST_CFA_OFFSET -8
 	CFI_REGISTER rip, r11
 	SAVE_REST
+	movq    %gs:pda_pcurrent,%r10
 	call *%rax
 	RESTORE_REST
 	jmp  ia32_sysret	/* misbalances the return cache */
diff --git a/arch/x86_64/kernel/entry.S b/arch/x86_64/kernel/entry.S
index 9ff4204..53a829c 100644
--- a/arch/x86_64/kernel/entry.S
+++ b/arch/x86_64/kernel/entry.S
@@ -201,6 +201,7 @@ ENTRY(system_call)
 	cmpq $__NR_syscall_max,%rax
 	ja badsys
 	movq %r10,%rcx
+	movq	%gs:pda_pcurrent,%r10
 	call *sys_call_table(,%rax,8)  # XXX:	 rip relative
 	movq %rax,RAX-ARGOFFSET(%rsp)
 /*
@@ -235,6 +236,7 @@ sysret_careful:
 	sti
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
+	movq	%gs:pda_pcurrent,%r10
 	call schedule
 	popq  %rdi
 	CFI_ADJUST_CFA_OFFSET -8
@@ -266,12 +268,14 @@ tracesys:			 
 	movq $-ENOSYS,RAX(%rsp)
 	FIXUP_TOP_OF_STACK %rdi
 	movq %rsp,%rdi
+	movq	%gs:pda_pcurrent,%r10
 	call syscall_trace_enter
 	LOAD_ARGS ARGOFFSET  /* reload args from stack in case ptrace changed it */
 	RESTORE_REST
 	cmpq $__NR_syscall_max,%rax
 	ja  1f
 	movq %r10,%rcx	/* fixup for C */
+	movq	%gs:pda_pcurrent,%r10
 	call *sys_call_table(,%rax,8)
 	movq %rax,RAX-ARGOFFSET(%rsp)
 1:	SAVE_REST
@@ -324,6 +328,7 @@ int_careful:
 	sti
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET 8
+	movq	%gs:pda_pcurrent,%r10
 	call schedule
 	popq %rdi
 	CFI_ADJUST_CFA_OFFSET -8
@@ -409,6 +414,7 @@ ENTRY(stub_execve)
 	movq %r11, %r15
 	CFI_REGISTER rip, r15
 	FIXUP_TOP_OF_STACK %r11
+	movq	%gs:pda_pcurrent,%r10
 	call sys_execve
 	GET_THREAD_INFO(%rcx)
 	bt $TIF_IA32,threadinfo_flags(%rcx)
@@ -441,6 +447,7 @@ ENTRY(stub_rt_sigreturn)
 	SAVE_REST
 	movq %rsp,%rdi
 	FIXUP_TOP_OF_STACK %r11
+	movq	%gs:pda_pcurrent,%r10
 	call sys_rt_sigreturn
 	movq %rax,RAX(%rsp) # fixme, this could be done at the higher layer
 	RESTORE_REST
@@ -498,6 +505,7 @@ ENTRY(stub_rt_sigreturn)
 	cmoveq %rax,%rsp /*todo This needs CFI annotation! */
 	pushq %rdi			# save old stack	
 	CFI_ADJUST_CFA_OFFSET	8
+	movq	%gs:pda_pcurrent,%r10
 	call \func
 	.endm
 
@@ -559,6 +567,7 @@ retint_careful:
 	sti
 	pushq %rdi
 	CFI_ADJUST_CFA_OFFSET	8
+	movq	%gs:pda_pcurrent,%r10
 	call  schedule
 	popq %rdi		
 	CFI_ADJUST_CFA_OFFSET	-8
@@ -574,6 +583,7 @@ retint_signal:
 	movq $-1,ORIG_RAX(%rsp) 			
 	xorl %esi,%esi		# oldset
 	movq %rsp,%rdi		# &pt_regs
+	movq	%gs:pda_pcurrent,%r10
 	call do_notify_resume
 	RESTORE_REST
 	cli
@@ -592,6 +602,7 @@ retint_kernel:	
 	jnc  retint_restore_args
 	bt   $9,EFLAGS-ARGOFFSET(%rsp)	/* interrupts off? */
 	jnc  retint_restore_args
+	movq	%gs:pda_pcurrent,%r10
 	call preempt_schedule_irq
 	jmp exit_intr
 #endif	
@@ -682,6 +693,7 @@ ENTRY(spurious_interrupt)
 	testl %edx,%edx
 	js    1f
 	swapgs
+	movq	%gs:pda_pcurrent,%r10
 	xorl  %ebx,%ebx
 1:	movq %rsp,%rdi
 	movq ORIG_RAX(%rsp),%rsi
@@ -734,6 +746,7 @@ ENTRY(error_entry)
 	je  error_kernelspace
 error_swapgs:	
 	swapgs
+	movq	%gs:pda_pcurrent,%r10
 error_sti:	
 	movq %rdi,RDI(%rsp) 	
 	movq %rsp,%rdi
@@ -876,6 +889,7 @@ ENTRY(execve)
 	CFI_STARTPROC
 	FAKE_STACK_FRAME $0
 	SAVE_ALL	
+	movq %gs:pda_pcurrent,%r10
 	call sys_execve
 	movq %rax, RAX(%rsp)	
 	RESTORE_REST
@@ -953,6 +967,7 @@ paranoid_userspace:	
 	jmp paranoid_userspace
 paranoid_schedule:
 	sti
+	movq	%gs:pda_pcurrent,%r10
 	call schedule
 	cli
 	jmp paranoid_userspace
diff --git a/arch/x86_64/kernel/process.c b/arch/x86_64/kernel/process.c
index 5afd63e..340bce2 100644
--- a/arch/x86_64/kernel/process.c
+++ b/arch/x86_64/kernel/process.c
@@ -435,8 +435,10 @@ int copy_thread(int nr, unsigned long cl
 
 	childregs->rax = 0;
 	childregs->rsp = rsp;
-	if (rsp == ~0UL)
+	if (rsp == ~0UL) {
+		childregs->r10 = (long)p;
 		childregs->rsp = (unsigned long)childregs;
+	}
 
 	p->thread.rsp = (unsigned long) childregs;
 	p->thread.rsp0 = (unsigned long) (childregs+1);
@@ -568,6 +570,7 @@ __switch_to(struct task_struct *prev_p, 
 	prev->userrsp = read_pda(oldrsp); 
 	write_pda(oldrsp, next->userrsp); 
 	write_pda(pcurrent, next_p); 
+	current = next_p;
 	write_pda(kernelstack,
 	    (unsigned long)next_p->thread_info + THREAD_SIZE - PDA_STACKOFFSET);
 
diff --git a/arch/x86_64/kernel/setup64.c b/arch/x86_64/kernel/setup64.c
index 06dc354..3af8688 100644
--- a/arch/x86_64/kernel/setup64.c
+++ b/arch/x86_64/kernel/setup64.c
@@ -132,16 +132,16 @@ void pda_init(int cpu)
 
 	if (cpu == 0) {
 		/* others are initialized in smpboot.c */
-		pda->pcurrent = &init_task;
+		current = pda->pcurrent = &init_task;
 		pda->irqstackptr = boot_cpu_stack; 
 	} else {
+		current = pda->pcurrent;
 		pda->irqstackptr = (char *)
 			__get_free_pages(GFP_ATOMIC, IRQSTACK_ORDER);
 		if (!pda->irqstackptr)
 			panic("cannot allocate irqstack for cpu %d", cpu); 
 	}
 
-
 	pda->irqstackptr += IRQSTACKSIZE-64;
 } 
 
diff --git a/arch/x86_64/kernel/traps.c b/arch/x86_64/kernel/traps.c
index bf337f4..a6008ae 100644
--- a/arch/x86_64/kernel/traps.c
+++ b/arch/x86_64/kernel/traps.c
@@ -277,6 +277,7 @@ void show_registers(struct pt_regs *regs
 	const int cpu = safe_smp_processor_id(); 
 	struct task_struct *cur = cpu_pda[cpu].pcurrent; 
 
+	current = cur;
 		rsp = regs->rsp;
 
 	printk("CPU %d ", cpu);
diff --git a/arch/x86_64/lib/copy_user.S b/arch/x86_64/lib/copy_user.S
index dfa358b..f24497d 100644
--- a/arch/x86_64/lib/copy_user.S
+++ b/arch/x86_64/lib/copy_user.S
@@ -95,6 +95,7 @@ copy_user_generic:	
 	.previous
 .Lcug:	
 	pushq %rbx
+	pushq %r12
 	xorl %eax,%eax		/*zero for the exception handler */
 
 #ifdef FIX_ALIGNMENT
@@ -117,20 +118,20 @@ copy_user_generic:	
 .Ls1:	movq (%rsi),%r11
 .Ls2:	movq 1*8(%rsi),%r8
 .Ls3:	movq 2*8(%rsi),%r9
-.Ls4:	movq 3*8(%rsi),%r10
+.Ls4:	movq 3*8(%rsi),%r12
 .Ld1:	movq %r11,(%rdi)
 .Ld2:	movq %r8,1*8(%rdi)
 .Ld3:	movq %r9,2*8(%rdi)
-.Ld4:	movq %r10,3*8(%rdi)
+.Ld4:	movq %r12,3*8(%rdi)
 		
 .Ls5:	movq 4*8(%rsi),%r11
 .Ls6:	movq 5*8(%rsi),%r8
 .Ls7:	movq 6*8(%rsi),%r9
-.Ls8:	movq 7*8(%rsi),%r10
+.Ls8:	movq 7*8(%rsi),%r12
 .Ld5:	movq %r11,4*8(%rdi)
 .Ld6:	movq %r8,5*8(%rdi)
 .Ld7:	movq %r9,6*8(%rdi)
-.Ld8:	movq %r10,7*8(%rdi)
+.Ld8:	movq %r12,7*8(%rdi)
 	
 	decq %rdx
 
@@ -169,6 +170,7 @@ copy_user_generic:	
 	jnz .Lloop_1
 			
 .Lende:
+	popq %r12
 	popq %rbx
 	ret	
 
diff --git a/arch/x86_64/lib/csum-copy.S b/arch/x86_64/lib/csum-copy.S
index 72fd55e..8e0ee5f 100644
--- a/arch/x86_64/lib/csum-copy.S
+++ b/arch/x86_64/lib/csum-copy.S
@@ -84,7 +84,7 @@ csum_partial_copy_generic:
 	/* main loop. clear in 64 byte blocks */
 	/* r9: zero, r8: temp2, rbx: temp1, rax: sum, rcx: saved length */
 	/* r11:	temp3, rdx: temp4, r12 loopcnt */
-	/* r10:	temp5, rbp: temp6, r14 temp7, r13 temp8 */
+	/* r15:	temp5, rbp: temp6, r14 temp7, r13 temp8 */
 	.p2align 4
 .Lloop:
 	source
@@ -97,7 +97,7 @@ csum_partial_copy_generic:
 	movq  24(%rdi),%rdx
 
 	source
-	movq  32(%rdi),%r10
+	movq  32(%rdi),%r15
 	source
 	movq  40(%rdi),%rbp
 	source
@@ -112,7 +112,7 @@ csum_partial_copy_generic:
 	adcq  %r8,%rax
 	adcq  %r11,%rax
 	adcq  %rdx,%rax
-	adcq  %r10,%rax
+	adcq  %r15,%rax
 	adcq  %rbp,%rax
 	adcq  %r14,%rax
 	adcq  %r13,%rax
@@ -129,7 +129,7 @@ csum_partial_copy_generic:
 	movq %rdx,24(%rsi)
 
 	dest
-	movq %r10,32(%rsi)
+	movq %r15,32(%rsi)
 	dest
 	movq %rbp,40(%rsi)
 	dest
@@ -149,7 +149,7 @@ csum_partial_copy_generic:
 	/* do last upto 56 bytes */
 .Lhandle_tail:
 	/* ecx:	count */
-	movl %ecx,%r10d
+	movl %ecx,%r15d
 	andl $63,%ecx
 	shrl $3,%ecx
 	jz 	 .Lfold
@@ -176,7 +176,7 @@ csum_partial_copy_generic:
 
 	/* do last upto 6 bytes */	
 .Lhandle_7:
-	movl %r10d,%ecx
+	movl %r15d,%ecx
 	andl $7,%ecx
 	shrl $1,%ecx
 	jz   .Lhandle_1
@@ -198,7 +198,7 @@ csum_partial_copy_generic:
 	
 	/* handle last odd byte */
 .Lhandle_1:
-	testl $1,%r10d
+	testl $1,%r15d
 	jz    .Lende
 	xorl  %ebx,%ebx
 	source
diff --git a/include/asm-x86_64/current.h b/include/asm-x86_64/current.h
index bc8adec..6675f2d 100644
--- a/include/asm-x86_64/current.h
+++ b/include/asm-x86_64/current.h
@@ -6,13 +6,7 @@ struct task_struct;
 
 #include <asm/pda.h>
 
-static inline struct task_struct *get_current(void) 
-{ 
-	struct task_struct *t = read_pda(pcurrent); 
-	return t;
-} 
-
-#define current get_current()
+register struct task_struct *current __asm__("%r10");
 
 #else
 
