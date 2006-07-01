Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWGAHa3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWGAHa3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Jul 2006 03:30:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964840AbWGAHa3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Jul 2006 03:30:29 -0400
Received: from mx3.mail.elte.hu ([157.181.1.138]:7112 "EHLO mx3.mail.elte.hu")
	by vger.kernel.org with ESMTP id S964839AbWGAHa2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Jul 2006 03:30:28 -0400
Date: Sat, 1 Jul 2006 09:25:46 +0200
From: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org, davej@redhat.com,
       tglx@linutronix.de, drepper@redhat.com
Subject: Re: [patch] pi-futex: futex_wake() lockup fix
Message-ID: <20060701072545.GA24283@elte.hu>
References: <20060701070746.GA22457@elte.hu> <20060701002305.7b6b78a4.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060701002305.7b6b78a4.akpm@osdl.org>
User-Agent: Mutt/1.4.2.1i
X-ELTE-SpamScore: 0.1
X-ELTE-SpamLevel: 
X-ELTE-SpamCheck: no
X-ELTE-SpamVersion: ELTE 2.0 
X-ELTE-SpamCheck-Details: score=0.1 required=5.9 tests=AWL,BAYES_50 autolearn=no SpamAssassin version=3.0.3
	0.0 BAYES_50               BODY: Bayesian spam probability is 40 to 60%
	[score: 0.5012]
	0.1 AWL                    AWL: From: address is in the auto white-list
X-ELTE-VirusStatus: clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


* Andrew Morton <akpm@osdl.org> wrote:

> >  		if (match_futex (&this->key, &key)) {
> > -			if (this->pi_state)
> > -				return -EINVAL;
> > +			if (this->pi_state) {
> > +				ret = -EINVAL;
> > +				break;
> > +			}
> >  			wake_futex(this);
> >  			if (++ret >= nr_wake)
> >  				break;
> 
> Well that was rather a howler.

yeah :-| This bug was introduced relatively late, as part of another 
bugfix.

> How did the lock validator help in identifying this?

i've got an extension for it that moans if we exit a syscall with held 
locks. (i dont want to risk the current queue with it, it's below - just 
for review)

(but it's not a strict lockdep thing - it should probably be done as 
part of DEBUG_LOCK_ALLOC, not LOCKDEP)

anyway, this is for later - it just shows that we can certainly do a 
number of nice things with lockdep's lock-stack. [as DEBUG_LOCK_ALLOC 
itself already demonstrates]

	Ingo

NOT-YET-Signed-off-by: Ingo Molnar <mingo@elte.hu>
---
 arch/i386/kernel/entry.S     |   15 ++++++++++++
 arch/x86_64/ia32/ia32entry.S |    6 +++++
 arch/x86_64/kernel/entry.S   |    4 +++
 include/asm-x86_64/calling.h |   50 +++++++++++++++++++++++++++++++++++++++++++
 kernel/lockdep.c             |   20 +++++++++++++++++
 lib/Kconfig.debug            |    4 +++
 6 files changed, 99 insertions(+)

Index: linux/arch/i386/kernel/entry.S
===================================================================
--- linux.orig/arch/i386/kernel/entry.S
+++ linux/arch/i386/kernel/entry.S
@@ -308,6 +308,11 @@ sysenter_past_esp:
 	pushl %eax
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
+#ifdef CONFIG_SYSCALL_TRACE
+	pushl %edx; pushl %ecx; pushl %ebx; pushl %eax
+	call sys_call
+	popl %eax; popl %ebx; popl %ecx; popl %edx
+#endif
 	GET_THREAD_INFO(%ebp)
 
 	/* Note, _TIF_SECCOMP is bit number 8, and so it needs testw and not testb */
@@ -322,6 +327,11 @@ sysenter_past_esp:
 	movl TI_flags(%ebp), %ecx
 	testw $_TIF_ALLWORK_MASK, %cx
 	jne syscall_exit_work
+#ifdef CONFIG_SYSCALL_TRACE
+	pushl %eax
+	call sys_ret
+	popl %eax
+#endif
 /* if something modifies registers it must also disable sysexit */
 	movl EIP(%esp), %edx
 	movl OLDESP(%esp), %ecx
@@ -338,6 +348,11 @@ ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	CFI_ADJUST_CFA_OFFSET 4
 	SAVE_ALL
+#ifdef CONFIG_SYSCALL_TRACE
+	pushl %edx; pushl %ecx; pushl %ebx; pushl %eax
+	call sys_call
+	popl %eax; popl %ebx; popl %ecx; popl %edx
+#endif
 	GET_THREAD_INFO(%ebp)
 	testl $TF_MASK,EFLAGS(%esp)
 	jz no_singlestep
Index: linux/arch/x86_64/ia32/ia32entry.S
===================================================================
--- linux.orig/arch/x86_64/ia32/ia32entry.S
+++ linux/arch/x86_64/ia32/ia32entry.S
@@ -119,7 +119,9 @@ sysenter_do_call:	
 	cmpl	$(IA32_NR_syscalls-1),%eax
 	ja	ia32_badsys
 	IA32_ARG_FIXUP 1
+	TRACE_SYS_IA32_CALL
 	call	*ia32_sys_call_table(,%rax,8)
+	TRACE_SYS_RET
 	movq	%rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
 	cli
@@ -227,7 +229,9 @@ cstar_do_call:	
 	cmpl $IA32_NR_syscalls-1,%eax
 	ja  ia32_badsys
 	IA32_ARG_FIXUP 1
+	TRACE_SYS_IA32_CALL
 	call *ia32_sys_call_table(,%rax,8)
+	TRACE_SYS_RET
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	GET_THREAD_INFO(%r10)
 	cli
@@ -320,8 +324,10 @@ ia32_do_syscall:	
 	cmpl $(IA32_NR_syscalls-1),%eax
 	ja  ia32_badsys
 	IA32_ARG_FIXUP
+	TRACE_SYS_IA32_CALL
 	call *ia32_sys_call_table(,%rax,8) # xxx: rip relative
 ia32_sysret:
+	TRACE_SYS_RET
 	movq %rax,RAX-ARGOFFSET(%rsp)
 	jmp int_ret_from_sys_call 
 
Index: linux/arch/x86_64/kernel/entry.S
===================================================================
--- linux.orig/arch/x86_64/kernel/entry.S
+++ linux/arch/x86_64/kernel/entry.S
@@ -222,7 +222,9 @@ ENTRY(system_call)
 	cmpq $__NR_syscall_max,%rax
 	ja badsys
 	movq %r10,%rcx
+	TRACE_SYS_CALL
 	call *sys_call_table(,%rax,8)  # XXX:	 rip relative
+	TRACE_SYS_RET
 	movq %rax,RAX-ARGOFFSET(%rsp)
 /*
  * Syscall return path ending with SYSRET (fast path)
@@ -304,7 +306,9 @@ tracesys:			 
 	cmpq $__NR_syscall_max,%rax
 	ja  1f
 	movq %r10,%rcx	/* fixup for C */
+	TRACE_SYS_CALL
 	call *sys_call_table(,%rax,8)
+	TRACE_SYS_RET
 1:	movq %rax,RAX-ARGOFFSET(%rsp)
 	/* Use IRET because user could have changed frame */
 	jmp int_ret_from_sys_call
Index: linux/include/asm-x86_64/calling.h
===================================================================
--- linux.orig/include/asm-x86_64/calling.h
+++ linux/include/asm-x86_64/calling.h
@@ -160,3 +160,53 @@
 	.macro icebp
 	.byte 0xf1
 	.endm
+
+/*
+ * syscall-tracing helpers:
+ */
+
+	.macro TRACE_SYS_CALL
+
+#ifdef CONFIG_SYSCALL_TRACE
+	SAVE_ARGS
+
+	mov     %rdx, %rcx
+	mov     %rsi, %rdx
+	mov     %rdi, %rsi
+	mov     %rax, %rdi
+
+	call sys_call
+
+	RESTORE_ARGS
+#endif
+	.endm
+
+
+	.macro TRACE_SYS_IA32_CALL
+
+#ifdef CONFIG_SYSCALL_TRACE
+	SAVE_ARGS
+
+	mov     %rdx, %rcx
+	mov     %rsi, %rdx
+	mov     %rdi, %rsi
+	mov     %rax, %rdi
+
+	call sys_ia32_call
+
+	RESTORE_ARGS
+#endif
+	.endm
+
+	.macro TRACE_SYS_RET
+
+#ifdef CONFIG_SYSCALL_TRACE
+	SAVE_ARGS
+
+	mov     %rax, %rdi
+
+	call sys_ret
+
+	RESTORE_ARGS
+#endif
+	.endm
Index: linux/kernel/lockdep.c
===================================================================
--- linux.orig/kernel/lockdep.c
+++ linux/kernel/lockdep.c
@@ -2701,3 +2701,23 @@ void debug_show_held_locks(struct task_s
 
 EXPORT_SYMBOL_GPL(debug_show_held_locks);
 
+void
+sys_call(unsigned long nr, unsigned long p1, unsigned long p2, unsigned long p3)
+{
+	DEBUG_LOCKS_WARN_ON(current->lockdep_depth);
+}
+
+#if defined(CONFIG_COMPAT) && defined(CONFIG_X86)
+
+void sys_ia32_call(unsigned long nr, unsigned long p1, unsigned long p2,
+		   unsigned long p3)
+{
+	DEBUG_LOCKS_WARN_ON(current->lockdep_depth);
+}
+
+#endif
+
+void sys_ret(unsigned long ret)
+{
+	DEBUG_LOCKS_WARN_ON(current->lockdep_depth);
+}
Index: linux/lib/Kconfig.debug
===================================================================
--- linux.orig/lib/Kconfig.debug
+++ linux/lib/Kconfig.debug
@@ -251,6 +251,10 @@ config LOCKDEP
 	select FRAME_POINTER
 	select KALLSYMS
 	select KALLSYMS_ALL
+	select SYSCALL_TRACE
+
+config SYSCALL_TRACE
+	bool
 
 config DEBUG_LOCKDEP
 	bool "Lock dependency engine debugging"
