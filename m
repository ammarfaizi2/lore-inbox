Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265348AbUF2Bzf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265348AbUF2Bzf (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Jun 2004 21:55:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265351AbUF2Bzf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Jun 2004 21:55:35 -0400
Received: from mail6.speakeasy.net ([216.254.0.206]:13702 "EHLO
	mail6.speakeasy.net") by vger.kernel.org with ESMTP id S265348AbUF2BzY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Jun 2004 21:55:24 -0400
Date: Mon, 28 Jun 2004 18:55:20 -0700
Message-Id: <200406290155.i5T1tKYY030209@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: Ingo Molnar <mingo@redhat.com>, Andrew Cagney <cagney@redhat.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH] x86 single-step (TF) vs system calls & traps
X-Fcc: ~/Mail/linus
X-Zippy-Says: ..  this must be what it's like to be a COLLEGE GRADUATE!!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Cagney discovered this problem while working on GDB.  I suspect this
bug has always been there, but I've only actually tested current 2.6 kernels.

When you single-step into a trap instruction, you actually don't get a
SIGTRAP until the instruction after the trap instruction has also executed.
I have demonstrated this in three cases: `into' generating a SIGSEGV that
is suppressed via ptrace; an `int $0x80' system call entry; and a
`sysenter' system call entry via the vsyscall entry point.

In https://bugzilla.redhat.com/bugzilla/show_bug.cgi?id=126699 you can find
a working test program and full details on reproducing the problem using
gdb.  I can post all that here if people prefer.  If there were a program
that set the TF bit in the processor flags itself and handled the signals,
I'm sure that would see the same problem, without ptrace being involved.

>From reading the code and the x86 specs on traps, it makes sense why it
happens.  The trap flag causes a single-step trap after the execution of
the instruction that sets the trap flag.  For instructions that generate
their own traps, TF is cleared on the way into the kernel, and it's the
normal iret that is restoring the flag on the way back to user mode.  As
advertised, that executes the next instruction, i.e. whatever the restored
user PC is at, and then traps.  But from the userland perspective, this is
highly unexpected: the user executed one instruction like 'into' or 'int'
or `sysenter', and expects execution to stop after that "instruction" is
done.  To the user, everything the kernel does in response to the trap is
part of the execution of that one instruction.

So, I submit that the sensible behavior in these cases, when TF is set, is
to stop immediately with a simulated single-step trap, before running the
next user instruction.  Below is a patch that implements this on x86, and I
believe it covers all the cases.  I would like some verification from
others on my reading of which cases there are--that is, cases where a
kernel entry is with the saved PC sitting after an instruction that's
already executed to cause that entry.  From the x86 specs, I see only the
following exception of "trap" type: 

#1: some kind of debug traps.  These don't need any help because this is
    the same trap as the single-step trap anyway and the kernel behavior
    (SIGTRAP and its details) are identical already.

#3: int3.  Probably the same story here, but my fix does treat it like `into'.
    Since gdb uses this for its own purposes, you can't demonstrate the
    same anomaly that's easy to see for `into'.

#4: into.  This is a problem case I've demonstrated and that my fix addresses.

Software exceptions like the `int' instruction generates are not classified
the same in that table, but `int $0x80' system call entry behaves the same
way in effect.  My patch handles the system call entry case.

sysenter is not a trap, but the way it and sysexit work seems to have the
same effect.  

Are there any cases of this nature that I have overlooked?

Unfortunately I just don't see a way to address this without inserting into
the trap and system call paths checks for TF being set in the user-mode
flags word.  

The good news is that the fast `sysenter' path does not need any such
check, because of the way `sysenter' interacts with TF: instead the
single-step trap handler that already detects entry in kernel mode via the
`sysenter' case is where the checking happens, so the new overhead is only
in the case where TF was in use.  Something else I would like verification
on is that the `sysenter' entry point is the only case where the
single-step trap will be seen in kernel mode.  My patch assumes this.  I
can't see how else it could come up (except for the KGDB patch, which also
seems to make the same assumption).

I have demonstrated the problem behavior in 32-bit x86 code (see the
bugzilla reference above) both on x86 and on x86-64.  I haven't yet
attacked the x86-64 kernel's 32-bit support to make the same change.

However, in a native 64-bit system call on x86-64, I do not see the same
problem.  This bewilders me.  From the AMD64 docs I have, I would expect
syscall/sysret to behave the same way as we observe sysenter/sysexit doing
in 32-bit mode.  I don't see any difference in the behavior of TF specified
for x86-64 from x86.  Can anyone help me understand what's going on there?


I have only investigated x86 and x86-64 in detail (those are the boxes I
have handy for kernel hacking, and the machines I know well enough off hand
to suggest specific fixes like those below).  Andrew has tested for the
same issue on other architectures, and I believe the same or similar
problem hits powerpc, ia64, and perhaps s390.  I'm not sure if any other
machines have been tested and seen not to have any such isse.


Comments?


Thanks,
Roland


Index: linux-2.6/arch/i386/kernel/entry.S
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/i386/kernel/entry.S,v
retrieving revision 1.86
diff -b -p -u -r1.86 entry.S
--- linux-2.6/arch/i386/kernel/entry.S 23 May 2004 05:03:15 -0000 1.86
+++ linux-2.6/arch/i386/kernel/entry.S 24 Jun 2004 06:53:37 -0000
@@ -255,6 +255,13 @@ sysenter_past_esp:
 	pushl %eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
+	/*
+	 * We don't need to check for TF here as in system_call, below.
+	 * Kernel entry by `sysenter' doesn't clear TF and so we just took
+	 * the single-step trap in kernel mode and set TIF_SINGLESTEP to
+	 * restore TF when we return to user mode.  That will also handle
+	 * simulating the single-step trap as syscall_singlestep arranges.
+	 */
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 
@@ -278,6 +285,9 @@ ENTRY(system_call)
 	pushl %eax			# save orig_eax
 	SAVE_ALL
 	GET_THREAD_INFO(%ebp)
+	testb $(TF_MASK >> 8),EFLAGS+1(%esp)
+	jnz syscall_singlestep
+syscall_check_nr:
 	cmpl $(nr_syscalls), %eax
 	jae syscall_badsys
 					# system call tracing in operation
@@ -370,6 +380,14 @@ syscall_badsys:
 	movl $-ENOSYS,EAX(%esp)
 	jmp resume_userspace
 
+	ALIGN
+syscall_singlestep:
+#ifdef CONFIG_SMP
+	lock
+#endif
+	btsl $TIF_SINGLESTEP_TRAP,TI_flags(%ebp)
+	jmp syscall_check_nr
+
 /*
  * Build the entry stubs and pointer table with
  * some assembler magic.
Index: linux-2.6/arch/i386/kernel/signal.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/i386/kernel/signal.c,v
retrieving revision 1.40
diff -b -p -u -r1.40 signal.c
--- linux-2.6/arch/i386/kernel/signal.c 18 Jun 2004 20:35:31 -0000 1.40
+++ linux-2.6/arch/i386/kernel/signal.c 24 Jun 2004 06:54:51 -0000
@@ -613,10 +613,47 @@ void do_notify_resume(struct pt_regs *re
 	if (thread_info_flags & _TIF_SINGLESTEP) {
 		regs->eflags |= TF_MASK;
 		clear_thread_flag(TIF_SINGLESTEP);
+		/*
+		 * TIF_SINGLESTEP is only ever set for a `sysenter' entry
+		 * to the kernel when TF was set in the user-mode flags.
+		 */
+		thread_info_flags |= _TIF_SINGLESTEP_TRAP;
 	}
 	/* deal with pending signal delivery */
 	if (thread_info_flags & _TIF_SIGPENDING)
 		do_signal(regs,oldset);
 	
+	/*
+	 * Check if we should simulate a single-step trap.
+	 * Note this happens after handling other pending signals,
+	 * including the one that set the flag for us.
+	 */
+	if (thread_info_flags & _TIF_SINGLESTEP_TRAP) {
+		clear_thread_flag(TIF_SINGLESTEP_TRAP);
+		if (regs->eflags & X86_EFLAGS_TF) {
+			/*
+			 * We single-stepped into an instruction that
+			 * caused a trap, leaving the PC past that instruction.
+			 * If we return now with TF set, the next instruction
+			 * will be executed before we get a single-step trap.
+			 * But the user just single-stepped and expects a
+			 * stop after the trapping instruction, not the next.
+			 * So fake a single-step trap.
+			 */
+			siginfo_t info;
+			info.si_signo = SIGTRAP;
+			info.si_errno = 0;
+			info.si_code = TRAP_BRKPT;
+			info.si_addr = (void *)regs->eip;
+			force_sig_info(SIGTRAP, &info, current);
+			/*
+			 * Now handle that signal immediately,
+			 * since on return to assembly code it
+			 * won't check _TIF_WORK_MASK again.
+			 */
+			do_signal(regs,oldset);
+		}
+	}
+
 	clear_thread_flag(TIF_IRET);
 }
Index: linux-2.6/arch/i386/kernel/traps.c
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/arch/i386/kernel/traps.c,v
retrieving revision 1.74
diff -b -p -u -r1.74 traps.c
--- linux-2.6/arch/i386/kernel/traps.c 18 Jun 2004 15:16:11 -0000 1.74
+++ linux-2.6/arch/i386/kernel/traps.c 24 Jun 2004 06:33:13 -0000
@@ -348,7 +348,8 @@ static inline unsigned long get_cr2(void
 }
 
 static inline void do_trap(int trapnr, int signr, char *str, int vm86,
-			   struct pt_regs * regs, long error_code, siginfo_t *info)
+			   struct pt_regs * regs, long error_code,
+			   siginfo_t *info, int flag_if_tf)
 {
 	if (regs->eflags & VM_MASK) {
 		if (vm86)
@@ -367,6 +368,8 @@ static inline void do_trap(int trapnr, i
 			force_sig_info(signr, info, tsk);
 		else
 			force_sig(signr, tsk);
+		if (flag_if_tf && (regs->eflags & X86_EFLAGS_TF))
+			set_thread_flag(flag_if_tf);
 		return;
 	}
 
@@ -386,7 +389,7 @@ static inline void do_trap(int trapnr, i
 #define DO_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
-	do_trap(trapnr, signr, str, 0, regs, error_code, NULL); \
+	do_trap(trapnr, signr, str, 0, regs, error_code, NULL, 0); \
 }
 
 #define DO_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
@@ -397,13 +400,14 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_errno = 0; \
 	info.si_code = sicode; \
 	info.si_addr = (void *)siaddr; \
-	do_trap(trapnr, signr, str, 0, regs, error_code, &info); \
+	do_trap(trapnr, signr, str, 0, regs, error_code, &info, 0); \
 }
 
 #define DO_VM86_ERROR(trapnr, signr, str, name) \
 asmlinkage void do_##name(struct pt_regs * regs, long error_code) \
 { \
-	do_trap(trapnr, signr, str, 1, regs, error_code, NULL); \
+	do_trap(trapnr, signr, str, 1, regs, error_code, NULL, \
+		TIF_SINGLESTEP_TRAP); \
 }
 
 #define DO_VM86_ERROR_INFO(trapnr, signr, str, name, sicode, siaddr) \
@@ -414,7 +418,7 @@ asmlinkage void do_##name(struct pt_regs
 	info.si_errno = 0; \
 	info.si_code = sicode; \
 	info.si_addr = (void *)siaddr; \
-	do_trap(trapnr, signr, str, 1, regs, error_code, &info); \
+	do_trap(trapnr, signr, str, 1, regs, error_code, &info, 0); \
 }
 
 DO_VM86_ERROR_INFO( 0, SIGFPE,  "divide error", divide_error, FPE_INTDIV, regs->eip)
Index: linux-2.6/include/asm-i386/thread_info.h
===================================================================
RCS file: /home/roland/redhat/bkcvs/linux-2.5/include/asm-i386/thread_info.h,v
retrieving revision 1.20
diff -b -p -u -r1.20 thread_info.h
--- linux-2.6/include/asm-i386/thread_info.h 19 May 2004 23:34:45 -0000 1.20
+++ linux-2.6/include/asm-i386/thread_info.h 23 Jun 2004 03:08:57 -0000
@@ -143,6 +143,7 @@ static inline unsigned long current_stac
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_SINGLESTEP		4	/* restore singlestep on return to user mode */
 #define TIF_IRET		5	/* return with iret */
+#define TIF_SINGLESTEP_TRAP	6	/* fake singlestep on return to user */
 #define TIF_SYSCALL_AUDIT	7	/* syscall auditing active */
 #define TIF_POLLING_NRFLAG	16	/* true if poll_idle() is polling TIF_NEED_RESCHED */
 
@@ -152,6 +153,7 @@ static inline unsigned long current_stac
 #define _TIF_NEED_RESCHED	(1<<TIF_NEED_RESCHED)
 #define _TIF_SINGLESTEP		(1<<TIF_SINGLESTEP)
 #define _TIF_IRET		(1<<TIF_IRET)
+#define _TIF_SINGLESTEP_TRAP	(1<<TIF_SINGLESTEP_TRAP)
 #define _TIF_SYSCALL_AUDIT	(1<<TIF_SYSCALL_AUDIT)
 #define _TIF_POLLING_NRFLAG	(1<<TIF_POLLING_NRFLAG)
