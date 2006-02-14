Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422788AbWBNUVR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422788AbWBNUVR (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 14 Feb 2006 15:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422786AbWBNUVR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 14 Feb 2006 15:21:17 -0500
Received: from [195.23.16.24] ([195.23.16.24]:27812 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S1422783AbWBNUVQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 14 Feb 2006 15:21:16 -0500
Message-ID: <43F23BB4.8070703@grupopie.com>
Date: Tue, 14 Feb 2006 20:21:08 +0000
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
CC: Linus Torvalds <torvalds@osdl.org>
Subject: Trap flag handling change in 2.6.10-bk5 broke Kylix debugger
Content-Type: multipart/mixed;
 boundary="------------040406040201040507040703"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040406040201040507040703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


I know this is ancient news, but the debugger still doesn't work with 
recent kernels (2.6.16-rc3) and I was trying to find out why. Basically, 
the debugger launches a couple of processes that are running all the 
time using 100% cpu time between them. The program that the debugger is 
supposed to be debugging never sees the light of day.

Note: maybe it is Kylix's fault that it is hanging like this. It seems 
to be using LinuxThreads (which is not a very good sign) and by being 
closed source it makes it very hard to find out exactly what's 
happening. The conclusion of this thread might very well be: "the kernel 
is doing the right thing, the Kylix debugger is wrong and it should be 
fixed". This would be fine by me, I just want to be sure this is the 
"official" stance before I give up on this :)

Anyway, by bisecting the kernel versions, I found out that the version 
where the debugger stops working is 2.6.10-bk5. Digging into the patch, 
I was able to isolate even further.

If I apply all the bk4-bk5 patch *except* the patch attached to this 
email, the debugger still works.

Going even further, a 2.6.10-bk5 kernel without this single change runs 
the debugger just fine:

> @@ -718,23 +717,21 @@
>  		 */
>  		if ((regs->xcs & 3) == 0)
>  			goto clear_TF_reenable;
> -		if ((tsk->ptrace & (PT_DTRACE|PT_PTRACED)) == PT_DTRACE)
> -			goto clear_TF;
> +
> +		/*
> +		 * Was the TF flag set by a debugger? If so, clear it now,
> +		 * so that register information is correct.
> +		 */
> +		if (tsk->ptrace & PT_DTRACE) {
> +			regs->eflags &= ~TF_MASK;
> +			tsk->ptrace &= ~PT_DTRACE;
> +			if (!tsk->ptrace & PT_DTRACE)
> +				goto clear_TF;
> +		}
>  	}
>  
>  	/* Ok, finally something we can handle */

I CC'd Linus Torvalds because, from the ChangeLog, he was the one who 
wrote this code, so maybe he can shed some light here.

Anyway, using the awesome magical power of blind "hand patching", I 
tried to revert this from the 2.6.16-rc3 kernel, but my powers have let 
me down this time :(

Alas, the current kernel is very different from the 2.6.10 version and I 
don't understand this code enough to be able to modify it. (I did try it 
anyway, without success: the debugger still hung).

Now, the next step would be to try to progress through the kernel 
versions in smaller steps, testing the debugger along the way, to see 
where it breaks again, and repeat until I reach 2.6.18 (that is probably 
where the kernel will be by the time I finish this process :) ).

Before I start moving in that direction is there someone who can give me 
an hint about what might be happening and suggest patches to test, etc.?

TIA,

-- 
Paulo Marques - www.grupopie.com

Pointy-Haired Boss: I don't see anything that could stand in our way.
            Dilbert: Sanity? Reality? The laws of physics?

--------------040406040201040507040703
Content-Type: text/plain;
 name="TF_patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="TF_patch"

## Automatically generated incremental diff
## From:   linux-2.6.10-bk4
## To:     linux-2.6.10-bk5
## Robot:  $Id: make-incremental-diff,v 1.12 2004/01/06 07:19:36 hpa Exp $

diff -urN linux-2.6.10-bk4/arch/i386/kernel/ptrace.c linux-2.6.10-bk5/arch/i386/kernel/ptrace.c
--- linux-2.6.10-bk4/arch/i386/kernel/ptrace.c	2004-12-24 13:34:29.000000000 -0800
+++ linux-2.6.10-bk5/arch/i386/kernel/ptrace.c	2005-01-02 04:55:14.135194305 -0800
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
@@ -553,6 +654,24 @@
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
+	/* User-mode eip? */
+	info.si_addr = user_mode(regs) ? (void __user *) regs->eip : NULL;
+
+	/* Send us the fakey SIGTRAP */
+	force_sig_info(SIGTRAP, &info, tsk);
+}
+
 /* notification of system call entry/exit
  * - triggered by current->work.syscall_trace
  */
@@ -568,15 +687,19 @@
 			audit_syscall_exit(current, regs->eax);
 	}

-	if (!test_thread_flag(TIF_SYSCALL_TRACE) &&
-	    !test_thread_flag(TIF_SINGLESTEP))
-		return;
 	if (!(current->ptrace & PT_PTRACED))
 		return;
+
+	/* Fake a debug trap */
+	if (test_thread_flag(TIF_SINGLESTEP))
+		send_sigtrap(current, regs, 0);
+
+	if (!test_thread_flag(TIF_SYSCALL_TRACE))
+		return;
+
 	/* the 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
-	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) &&
-				 !test_thread_flag(TIF_SINGLESTEP) ? 0x80 : 0));
+	ptrace_notify(SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD) ? 0x80 : 0));

 	/*
 	 * this isn't the same as continuing with a signal, but it will do
diff -urN linux-2.6.10-bk4/arch/i386/kernel/signal.c linux-2.6.10-bk5/arch/i386/kernel/signal.c
--- linux-2.6.10-bk4/arch/i386/kernel/signal.c	2004-12-24 13:34:44.000000000 -0800
+++ linux-2.6.10-bk5/arch/i386/kernel/signal.c	2005-01-02 04:55:14.137194398 -0800
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
diff -urN linux-2.6.10-bk4/arch/i386/kernel/traps.c linux-2.6.10-bk5/arch/i386/kernel/traps.c
--- linux-2.6.10-bk4/arch/i386/kernel/traps.c	2005-01-02 04:54:41.578671459 -0800
+++ linux-2.6.10-bk5/arch/i386/kernel/traps.c	2005-01-02 04:55:14.190196877 -0800
@@ -682,7 +682,6 @@
 {
 	unsigned int condition;
 	struct task_struct *tsk = current;
-	siginfo_t info;

 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));

@@ -718,23 +717,21 @@
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

--------------040406040201040507040703--
