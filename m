Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263291AbTBIGFg>; Sun, 9 Feb 2003 01:05:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266986AbTBIGFg>; Sun, 9 Feb 2003 01:05:36 -0500
Received: from bjl1.jlokier.co.uk ([81.29.64.88]:24529 "EHLO
	bjl1.jlokier.co.uk") by vger.kernel.org with ESMTP
	id <S263291AbTBIGFd>; Sun, 9 Feb 2003 01:05:33 -0500
Date: Sun, 9 Feb 2003 06:15:07 +0000
From: Jamie Lokier <jamie@shareable.org>
To: Andi Kleen <ak@suse.de>
Cc: Pavel Machek <pavel@suse.cz>, Kevin Lawton <kevinlawton2001@yahoo.com>,
       linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: [PATCH] Optimisation and CONFIG_PREEMPT fix of reloading of debug registers
Message-ID: <20030209061506.GA10597@bjl1.jlokier.co.uk>
References: <20030203235140.10443.qmail@web80304.mail.yahoo.com.suse.lists.linux.kernel> <p7365s0ri9c.fsf@oldwotan.suse.de> <20030207163301.GH345@elf.ucw.cz> <20030208172204.GA24577@wotan.suse.de> <20030208193149.GA9720@bjl1.jlokier.co.uk> <20030209005618.GA12369@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030209005618.GA12369@wotan.suse.de>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> > 	- However, DR6 bit B0 is now set.
> 
> You cannot detect it. Linux offers no way to read DR6 from user space
> as far as I can see. The only way to handle break points is to catch
> the signals caused by the debug exceptions.
> 
> Yo access debug registers you need to use ptrace from another process.
> ptrace only ever returns cached values in tsk->thread, but the register is 
> never stored in there.

To be precise, DR6 is stored in tsk->thread, in do_debug, but only
when DR7 is non-zero.  So there is no information leak.

> So in fact __switch_to could drop the loaddebug(next, 6) because it is 
> useless.

If you remove it, observable behaviour will change.  The bits set in
DR6 are cumulative over multiple debug traps.  Without the
loaddebug(next, 6), that accumulation is lost.  GDB won't mind because
it always uses the value of DR6 immediately after a debug trap and
before resuming a thread, but some other program could use the value
differently.

If you go ahead and remove the loaddebug(next, 6), it would make sense
to also clear DR6 in do_debug after reading it, so that programs see a
consistent value in debugreg[6] - i.e. only the bits set from the last
debug trap.

Also, it is essential that DR6 is cleared _somewhere_ before switching
to a task which has DR7 set, because otherwise you have the following
rather subtle hole:

    - Exploit program forks, parent attaches to child and stops child.
    - Parent sets DR3 in child to probe address, and DR7 to enable
      desired kind of breakpoint or watchpoint.  Also clears DR6.
    - Parent wakes up child and waits for child to stop.

          => Child schedules and DR3+DR6+DR7 are all loaded.

    - Child sends itself SIGSTOP, which wakes up parent.
    - Parent clears DR7 in child, wakes up child and waits for it to stop.

          => Child schedules, debug registers remain loaded
             although no task has debugreg[7] set.

    - Child interacts with subject process (e.g. "sshd") and sleeps
      for long enough to ensure subject process gets a chance to run.

          => sshd process triggers debug trap, clears DR7 but not DR6.

    - Child finished sleeping and sends itself SIGSTOP, which wakes parent.
    - Parent sets DR7 in child, wakes up child and waits for it to trap.

          => debugreg[7] has a non-zero value in the child
          => DR6 maintains its value from the sshd process trap
             (This is all assuming you removed the loaddebug(next, 6))

    - Child executes "int $1", which calls do_debug in the kernel.
    - Kernel notes that "condition & DR_TRAP0" is set (from DR6),
      and current->thread.debugreg[7] is non-zero (recently set by parent).
    - So kernel stores current value of DR6 in child's debugreg[6].
    - Parent is woken by the child's SIGTRAP, and reads child's debugreg[6].

          => Parent has read DR6 from the sshd process trap.
          => Potentially bad information leakage.

The outcome of these stories is:

    1. Yes you can remove loaddebug(next, 6) from switch_to.
    2. But then you _must_ unconditionally clear DR6 immediately after
       reading it in do_debug().
    3. DR6 must be clear when initialising each CPU.  Fortunately this
       is already done in cpu_init().
    4. If you change the line which saves DR6 into debugreg[6] to use
       "|=" instead of "=", you will even be able to preserve the currently
       observable behaviour of accumulating bits in debugreg[6] over
       multiple debug traps.
    5. I hope there is no SMP race condition where it is possible for
       ptrace(PTRACE_POKEUSER, ...) to succeed on a running process,
       even briefly.  That would trick the logic in do_debug() into
       revealing DR6 (with or without changes 1..4.)

Oh, and:

    6. If CONFIG_PREEMPT is enabled, and the kernel is preempted
       just after the attacked process hits the debug condition,
       but before do_debug() has a chance to run, changes 1..4
       introduce an information leak.  So the debug trap must be
       changed to an interrupt gate.

Point 6 is a bug in the current kernel.  DR6 could be read from the
wrong CPU if preempted.  It is exactly the same problem as reading
%cr2 in the page fault handler.

Patch is attached.  Untested.  Enjoy :)

-- Jamie

diff -urN --exclude='*.o' --exclude='.??*' --exclude=asm --exclude='vmlinux*' --exclude=System.map --exclude=bzImage orig-2.5.59/arch/i386/kernel/process.c dr6-2.5.59/arch/i386/kernel/process.c
--- orig-2.5.59/arch/i386/kernel/process.c	2003-02-09 05:49:12.000000000 +0000
+++ dr6-2.5.59/arch/i386/kernel/process.c	2003-02-09 06:03:44.000000000 +0000
@@ -467,8 +467,7 @@
 		loaddebug(next, 1);
 		loaddebug(next, 2);
 		loaddebug(next, 3);
-		/* no 4 and 5 */
-		loaddebug(next, 6);
+		/* No 4 and 5, and 6 always contains zero (see do_debug()). */
 		loaddebug(next, 7);
 	}
 
diff -urN --exclude='*.o' --exclude='.??*' --exclude=asm --exclude='vmlinux*' --exclude=System.map --exclude=bzImage orig-2.5.59/arch/i386/kernel/traps.c dr6-2.5.59/arch/i386/kernel/traps.c
--- orig-2.5.59/arch/i386/kernel/traps.c	2003-02-09 05:49:56.000000000 +0000
+++ dr6-2.5.59/arch/i386/kernel/traps.c	2003-02-09 06:10:21.000000000 +0000
@@ -514,6 +514,14 @@
 
 	__asm__ __volatile__("movl %%db6,%0" : "=r" (condition));
 
+	/* Unconditionally clear DR6 to prevent information leaks
+	   due to lazy DR7 setting. */
+	__asm__ __volatile__("movl %0,%%db6" : /* no output */ : "r" (0));
+
+	/* It's safe to allow irq's after DR6 has been saved */
+	if (regs->eflags & X86_EFLAGS_IF)
+		local_irq_enable();
+
 	/* Mask out spurious debug traps due to lazy DR7 setting */
 	if (condition & (DR_TRAP0|DR_TRAP1|DR_TRAP2|DR_TRAP3)) {
 		if (!tsk->thread.debugreg[7])
@@ -523,8 +531,9 @@
 	if (regs->eflags & VM_MASK)
 		goto debug_vm86;
 
-	/* Save debug status register where ptrace can see it */
-	tsk->thread.debugreg[6] = condition;
+	/* Save debug status register where ptrace can see it.  Bits are
+	   ORed into the stored DR6, just like the CPU does with real DR6. */
+	tsk->thread.debugreg[6] |= condition;
 
 	/* Mask out spurious TF errors due to lazy TF clearing */
 	if (condition & DR_STEP) {
@@ -831,7 +840,7 @@
 #endif
 
 	set_trap_gate(0,&divide_error);
-	set_trap_gate(1,&debug);
+	set_intr_gate(1,&debug);
 	set_intr_gate(2,&nmi);
 	set_system_gate(3,&int3);	/* int3-5 can be called from all */
 	set_system_gate(4,&overflow);
