Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261752AbUL3WsD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261752AbUL3WsD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Dec 2004 17:48:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261750AbUL3Wrw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Dec 2004 17:47:52 -0500
Received: from fw.osdl.org ([65.172.181.6]:24491 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261744AbUL3Wqt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Dec 2004 17:46:49 -0500
Date: Thu, 30 Dec 2004 14:46:17 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Jesse Allen <the3dfxdude@gmail.com>
cc: Davide Libenzi <davidel@xmailserver.org>, Mike Hearn <mh@codeweavers.com>,
       Thomas Sailer <sailer@scs.ch>, Eric Pouech <pouech-eric@wanadoo.fr>,
       Daniel Jacobowitz <dan@debian.org>, Roland McGrath <roland@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>, wine-devel <wine-devel@winehq.com>
Subject: Re: ptrace single-stepping change breaks Wine
In-Reply-To: <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
Message-ID: <Pine.LNX.4.58.0412301436330.22893@ppc970.osdl.org>
References: <200411152253.iAFMr8JL030601@magilla.sf.frob.com> 
 <530468570412291343d1478cf@mail.gmail.com>  <Pine.LNX.4.58.0412291622560.2353@ppc970.osdl.org>
  <Pine.LNX.4.58.0412291703400.30636@bigblue.dev.mdolabs.com> 
 <Pine.LNX.4.58.0412291745470.2353@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292050550.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292055540.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412292106400.454@bigblue.dev.mdolabs.com> 
 <Pine.LNX.4.58.0412292256350.22893@ppc970.osdl.org> 
 <Pine.LNX.4.58.0412300953470.2193@bigblue.dev.mdolabs.com>
 <53046857041230112742acccbe@mail.gmail.com> <Pine.LNX.4.58.0412301130540.22893@ppc970.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 30 Dec 2004, Linus Torvalds wrote:
> 
> Working on a patch for this right now, I'll send something out soonish 
> (and I'll test it on my test-case before sending it, so that it at least 
> has some chance of working).

Ok, here's a patch that may or may not make Wine happier. It's a _lot_ 
more careful about TF handling, and in particular it's trying really 
really hard to make sure that a controlling process does not change the 
trap flag as it is modified or used by the process.

This hopefully fixes:

 - single-step over "popf" should work - we won't clear TF after the popf, 
   but instead let the popf results remain. 

   NOTE! I tried to make sure that it does the right thing for segments 
   with non-zero bases, but I never actually tested that code. It's fairly 
   obvious, but it's also fairly likely to have some silly problems. Wine
   may well show effects of this, although I don't know how common 
   non-zero bases are with any kind of half-modern windows binaries.

 - ptrace reporting of "eflags" register after a single-step (we used to 
   report TF as being set because the debugger set it - even though the
   "native state" without debugging had it cleared).

   This also hopefully means that all the conditional TF clearing games
   etc aren't necessary, since arch/i386/kernel/traps.c should now be 
   taking care of hiding the debugger for most cases ("pushf" still 
   remains, and is hard. See comment in ptrace.c part of the patch)

It's a bit more involved than I'd like, since especially the "popf" case 
just is pretty complex, but I'd love to hear whether it works.

NOTE NOTE NOTE! I've tested it, but only on one small test-case, so it 
might be totally broken in many ways. I'd love to have people who are x86 
and ptrace-aware give this a second look, and I'm confident Jesse will 
find that it won't work, but can hopefully try to debug it a bit with 
this..

		Linus

-----
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
+++ edited/arch/i386/kernel/traps.c	2004-12-30 12:36:30 -08:00
@@ -718,8 +718,17 @@
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
===== arch/i386/kernel/ptrace.c 1.28 vs edited =====
--- 1.28/arch/i386/kernel/ptrace.c	2004-11-22 09:44:52 -08:00
+++ edited/arch/i386/kernel/ptrace.c	2004-12-30 14:35:45 -08:00
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
@@ -559,6 +660,8 @@
 __attribute__((regparm(3)))
 void do_syscall_trace(struct pt_regs *regs, int entryexit)
 {
+	struct siginfo info;
+
 	if (unlikely(current->audit_context)) {
 		if (!entryexit)
 			audit_syscall_entry(current, regs->orig_eax,
@@ -573,18 +676,18 @@
 		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
+
+	memset(&info, 0, sizeof(info));
+	info.si_signo = SIGTRAP;
+
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+	info.si_code = SIGTRAP;
+	if ((current->ptrace & PT_TRACESYSGOOD) && !test_thread_flag(TIF_SINGLESTEP))
+		info.si_code = SIGTRAP | 0x80;
+	info.si_pid = current->tgid;
+	info.si_uid = current->uid;
 
-	/*
-	 * this isn't the same as continuing with a signal, but it will do
-	 * for normal use.  strace only continues with a signal if the
-	 * stopping signal is not SIGTRAP.  -brl
-	 */
-	if (current->exit_code) {
-		send_sig(current->exit_code, current, 1);
-		current->exit_code = 0;
-	}
+	/* Send us the fakey SIGTRAP */
+	send_sig_info(SIGTRAP, &info, current);
 }
