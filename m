Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261840AbULaFtY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261840AbULaFtY (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Dec 2004 00:49:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261841AbULaFtY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Dec 2004 00:49:24 -0500
Received: from fw.osdl.org ([65.172.181.6]:21125 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261840AbULaFsY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Dec 2004 00:48:24 -0500
Date: Thu, 30 Dec 2004 21:47:42 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Daniel Jacobowitz <dan@debian.org>
cc: Jesse Allen <the3dfxdude@gmail.com>,
       Davide Libenzi <davidel@xmailserver.org>,
       Mike Hearn <mh@codeweavers.com>, Thomas Sailer <sailer@scs.ch>,
       Eric Pouech <pouech-eric@wanadoo.fr>,
       Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <20041231053618.GA25850@nevyn.them.org>
Message-ID: <Pine.LNX.4.58.0412302141320.2280@ppc970.osdl.org>
References: <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com>
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
 <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org> <20041230230046.GA14843@nevyn.them.org>
 <Pine.LNX.4.58.0412301513200.22893@ppc970.osdl.org> <20041231053618.GA25850@nevyn.them.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Fri, 31 Dec 2004, Daniel Jacobowitz wrote:
> 
> Well, you put SIGTRAP|0x80 in si_code.  Coincidentally, 0x80 is
> SI_KERNEL.  So testing for SI_KERNEL | 0x80 is probably OK in the
> signal path, since most of its other arbitrary values would be either
> negative or not include SI_KERNEL.

Somebody would need to validate that no user can fool the kernel into 
doing something stupid...

That said, I think I solved the problem a different way: the 
TIF_SINGLESTEP code really fundamentally doesn't want to have _any_ of 
that SIGTRAP | 0x80 nonsense in its path, it actually wants to look like a 
debug trap - which sets si_code to TRAP_BRKPT. Which makes more sense 
anyway.

So I looked at just sharing the code with the debug trap handler, and the
result is appended. strace works, as does all the TF tests I've thrown at
it, and the code actually looks better anyway (the old do_debug code looks
like it got the EIP wrong in VM86 mode, for example, this just cleans 
that up too). Just use a common "send_sigtrap()" routine.

Does this look saner?

		Linus

----
===== include/asm-i386/ptrace.h 1.7 vs edited =====
--- 1.7/include/asm-i386/ptrace.h	2004-09-03 16:55:27 -07:00
+++ edited/include/asm-i386/ptrace.h	2004-12-30 21:27:39 -08:00
@@ -55,6 +55,7 @@
 #define PTRACE_SET_THREAD_AREA    26
 
 #ifdef __KERNEL__
+extern void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code);
 #define user_mode(regs) ((VM_MASK & (regs)->eflags) || (3 & (regs)->xcs))
 #define instruction_pointer(regs) ((regs)->eip)
 #if defined(CONFIG_SMP) && defined(CONFIG_FRAME_POINTER)
===== arch/i386/kernel/signal.c 1.49 vs edited =====
--- 1.49/arch/i386/kernel/signal.c	2004-11-22 09:47:16 -08:00
+++ edited/arch/i386/kernel/signal.c	2004-12-30 11:40:35 -08:00
@@ -270,7 +270,6 @@
 		 struct pt_regs *regs, unsigned long mask)
 {
 	int tmp, err = 0;
-	unsigned long eflags;
 
 	tmp = 0;
 	__asm__("movl %%gs,%0" : "=r"(tmp): "0"(tmp));
@@ -292,16 +291,7 @@
 	err |= __put_user(current->thread.error_code, &sc->err);
 	err |= __put_user(regs->eip, &sc->eip);
 	err |= __put_user(regs->xcs, (unsigned int __user *)&sc->cs);
-
-	/*
-	 * Iff TF was set because the program is being single-stepped by a
-	 * debugger, don't save that information on the signal stack.. We
-	 * don't want debugging to change state.
-	 */
-	eflags = regs->eflags;
-	if (current->ptrace & PT_DTRACE)
-		eflags &= ~TF_MASK;
-	err |= __put_user(eflags, &sc->eflags);
+	err |= __put_user(regs->eflags, &sc->eflags);
 	err |= __put_user(regs->esp, &sc->esp_at_signal);
 	err |= __put_user(regs->xss, (unsigned int __user *)&sc->ss);
 
@@ -424,11 +414,9 @@
 	 * The tracer may want to single-step inside the
 	 * handler too.
 	 */
-	if (regs->eflags & TF_MASK) {
-		regs->eflags &= ~TF_MASK;
-		if (current->ptrace & PT_DTRACE)
-			ptrace_notify(SIGTRAP);
-	}
+	regs->eflags &= ~TF_MASK;
+	if (test_thread_flag(TIF_SINGLESTEP))
+		ptrace_notify(SIGTRAP);
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
@@ -519,11 +507,9 @@
 	 * The tracer may want to single-step inside the
 	 * handler too.
 	 */
-	if (regs->eflags & TF_MASK) {
-		regs->eflags &= ~TF_MASK;
-		if (current->ptrace & PT_DTRACE)
-			ptrace_notify(SIGTRAP);
-	}
+	regs->eflags &= ~TF_MASK;
+	if (test_thread_flag(TIF_SINGLESTEP))
+		ptrace_notify(SIGTRAP);
 
 #if DEBUG_SIG
 	printk("SIG deliver (%s:%d): sp=%p pc=%p ra=%p\n",
===== arch/i386/kernel/traps.c 1.92 vs edited =====
--- 1.92/arch/i386/kernel/traps.c	2004-12-28 11:07:48 -08:00
+++ edited/arch/i386/kernel/traps.c	2004-12-30 21:26:14 -08:00
@@ -718,23 +718,21 @@
 		 */
 		if ((regs->xcs & 3) == 0)
 			goto clear_TF_reenable;
-		if ((tsk->ptrace & (PT_DTRACE|PT_PTRACED)) == PT_DTRACE)
-			goto clear_TF;
+
+		/*
+		 * Was the TF flag set by a debugger? If so, clear it now,
+		 * so that register information is correct.
+		 */
+		if (tsk->ptrace & PT_DTRACE) {
+			regs->eflags &= ~TF_MASK;
+			tsk->ptrace &= ~PT_DTRACE;
+			if (!tsk->ptrace & PT_DTRACE)
+				goto clear_TF;
+		}
 	}
 
 	/* Ok, finally something we can handle */
-	tsk->thread.trap_no = 1;
-	tsk->thread.error_code = error_code;
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = TRAP_BRKPT;
-	
-	/* If this is a kernel mode trap, save the user PC on entry to 
-	 * the kernel, that's what the debugger can make sense of.
-	 */
-	info.si_addr = ((regs->xcs & 3) == 0) ? (void __user *)tsk->thread.eip
-	                                      : (void __user *)regs->eip;
-	force_sig_info(SIGTRAP, &info, tsk);
+	send_sigtrap(tsk, regs, error_code);
 
 	/* Disable additional traps. They'll be re-enabled when
 	 * the signal is delivered.
===== arch/i386/kernel/ptrace.c 1.28 vs edited =====
--- 1.28/arch/i386/kernel/ptrace.c	2004-11-22 09:44:52 -08:00
+++ edited/arch/i386/kernel/ptrace.c	2004-12-30 21:26:16 -08:00
@@ -42,6 +42,12 @@
  */
 #define EFL_OFFSET ((EFL-2)*4-sizeof(struct pt_regs))
 
+static inline struct pt_regs *get_child_regs(struct task_struct *task)
+{
+	void *stack_top = (void *)task->thread.esp0;
+	return stack_top - sizeof(struct pt_regs);
+}
+
 /*
  * this routine will get a word off of the processes privileged stack. 
  * the offset is how far from the base addr as stored in the TSS.  
@@ -138,24 +144,119 @@
 	return retval;
 }
 
+#define LDT_SEGMENT 4
+
+static unsigned long convert_eip_to_linear(struct task_struct *child, struct pt_regs *regs)
+{
+	unsigned long addr, seg;
+
+	addr = regs->eip;
+	seg = regs->xcs & 0xffff;
+	if (regs->eflags & VM_MASK) {
+		addr = (addr & 0xffff) + (seg << 4);
+		return addr;
+	}
+
+	/*
+	 * We'll assume that the code segments in the GDT
+	 * are all zero-based. That is largely true: the
+	 * TLS segments are used for data, and the PNPBIOS
+	 * and APM bios ones we just ignore here.
+	 */
+	if (seg & LDT_SEGMENT) {
+		u32 *desc;
+		unsigned long base;
+
+		down(&child->mm->context.sem);
+		desc = child->mm->context.ldt + (seg & ~7);
+		base = (desc[0] >> 16) | ((desc[1] & 0xff) << 16) | (desc[1] & 0xff000000);
+
+		/* 16-bit code segment? */
+		if (!((desc[1] >> 22) & 1))
+			addr &= 0xffff;
+		addr += base;
+		up(&child->mm->context.sem);
+	}
+	return addr;
+}
+
+static inline int is_at_popf(struct task_struct *child, struct pt_regs *regs)
+{
+	int i, copied;
+	unsigned char opcode[16];
+	unsigned long addr = convert_eip_to_linear(child, regs);
+
+	copied = access_process_vm(child, addr, opcode, sizeof(opcode), 0);
+	for (i = 0; i < copied; i++) {
+		switch (opcode[i]) {
+		/* popf */
+		case 0x9d:
+			return 1;
+		/* opcode and address size prefixes */
+		case 0x66: case 0x67:
+			continue;
+		/* irrelevant prefixes (segment overrides and repeats) */
+		case 0x26: case 0x2e:
+		case 0x36: case 0x3e:
+		case 0x64: case 0x65:
+		case 0xf0: case 0xf2: case 0xf3:
+			continue;
+
+		/*
+		 * pushf: NOTE! We should probably not let
+		 * the user see the TF bit being set. But
+		 * it's more pain than it's worth to avoid
+		 * it, and a debugger could emulate this
+		 * all in user space if it _really_ cares.
+		 */
+		case 0x9c:
+		default:
+			return 0;
+		}
+	}
+	return 0;
+}
+
 static void set_singlestep(struct task_struct *child)
 {
-	long eflags;
+	struct pt_regs *regs = get_child_regs(child);
 
+	/*
+	 * Always set TIF_SINGLESTEP - this guarantees that 
+	 * we single-step system calls etc..  This will also
+	 * cause us to set TF when returning to user mode.
+	 */
 	set_tsk_thread_flag(child, TIF_SINGLESTEP);
-	eflags = get_stack_long(child, EFL_OFFSET);
-	put_stack_long(child, EFL_OFFSET, eflags | TRAP_FLAG);
+
+	/*
+	 * If TF was already set, don't do anything else
+	 */
+	if (regs->eflags & TRAP_FLAG)
+		return;
+
+	/* Set TF on the kernel stack.. */
+	regs->eflags |= TRAP_FLAG;
+
+	/*
+	 * ..but if TF is changed by the instruction we will trace,
+	 * don't mark it as being "us" that set it, so that we
+	 * won't clear it by hand later.
+	 */
+	if (is_at_popf(child, regs))
+		return;
+
 	child->ptrace |= PT_DTRACE;
 }
 
 static void clear_singlestep(struct task_struct *child)
 {
-	if (child->ptrace & PT_DTRACE) {
-		long eflags;
+	/* Always clear TIF_SINGLESTEP... */
+	clear_tsk_thread_flag(child, TIF_SINGLESTEP);
 
-		clear_tsk_thread_flag(child, TIF_SINGLESTEP);
-		eflags = get_stack_long(child, EFL_OFFSET);
-		put_stack_long(child, EFL_OFFSET, eflags & ~TRAP_FLAG);
+	/* But touch TF only if it was set by us.. */
+	if (child->ptrace & PT_DTRACE) {
+		struct pt_regs *regs = get_child_regs(child);
+		regs->eflags &= ~TRAP_FLAG;
 		child->ptrace &= ~PT_DTRACE;
 	}
 }
@@ -553,6 +654,29 @@
 	return ret;
 }
 
+void send_sigtrap(struct task_struct *tsk, struct pt_regs *regs, int error_code)
+{
+	struct siginfo info;
+
+	tsk->thread.trap_no = 1;
+	tsk->thread.error_code = error_code;
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = SIGTRAP;
+	info.si_code = TRAP_BRKPT;
+
+	/*
+	 * If this is a kernel mode trap, save the user PC on entry to
+	 * the kernel, that's what the debugger can make sense of.
+	 */
+	info.si_addr = user_mode(regs) ?
+			(void __user *) regs->eip :
+			(void __user *)tsk->thread.eip;
+
+	/* Send us the fakey SIGTRAP */
+	force_sig_info(SIGTRAP, &info, tsk);
+}
+
 /* notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
@@ -568,15 +692,16 @@
 			audit_syscall_exit(current, regs->eax);
 	}
 
-	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !test_thread_flag(TIF_SINGLESTEP))
-		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
-	/* the 0x80 provides a way for the tracing parent to distinguish
-	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+
+	/* Fake a debug trap */
+	if (test_thread_flag(TIF_SINGLESTEP))
+		send_sigtrap(current, regs, 0);
+
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+		return;
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));
 
 	/*
 	 * this isn't the same as continuing with a signal, but it will do
