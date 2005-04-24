Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262207AbVDXAnO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262207AbVDXAnO (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 20:43:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262208AbVDXAnO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 20:43:14 -0400
Received: from mx1.redhat.com ([66.187.233.31]:11231 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262207AbVDXAmx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 20:42:53 -0400
Date: Sat, 23 Apr 2005 17:42:47 -0700
Message-Id: <200504240042.j3O0glFa032645@magilla.sf.frob.com>
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] i386: handle iret faults better
X-Windows: the first fully modular software disaster.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A user process can cause a kernel-mode fault in the iret instruction, by
setting an invalid %cs and such, via ptrace or sigreturn.  The fixup code
now calls do_exit(11), so a process will die with SIGSEGV but never
generate a core dump.  This is vastly more confusing in a multithreaded
program, because do_exit just kills that one thread and so it appears to
mysteriously disappear when it calls sigreturn.  

This patch makes faults in iret produce the normal signals that would
result from the same errors when executing some user-mode instruction.  
It requires some special case hair rather than just better fixup code,
because the full trap details that go into the signal info are not
available to the fixup code.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/i386/kernel/entry.S
+++ linux-2.6/arch/i386/kernel/entry.S
@@ -254,14 +253,23 @@ restore_nocheck:
 	RESTORE_REGS
 	addl $4, %esp
 1:	iret
+	/*
+	 * Traps in iret mean that userland tried to restore a bogus
+	 * cs, eip, ss, esp, or eflags.  Some kinds of bogosity just cause
+	 * a trap after the iret returns, but some will cause a trap in
+	 * iret itself.  We want to treat those as if the restored user
+	 * state is what caused that trap, i.e. produce the appropriate signal.
+	 * Since normal .fixup code doesn't have access to the trap info,
+	 * traps.c has a special case for iret.  It's already generated the
+	 * signal before we resume at iret_exc.  Now we just need to recover
+	 * the whole frame we were trying to restore, so it can be seen on
+	 * our stack by the debugger.
+	 */
 .section .fixup,"ax"
-iret_exc:
-	sti
-	movl $__USER_DS, %edx
-	movl %edx, %ds
-	movl %edx, %es
-	movl $11,%eax
-	call do_exit
+ENTRY(iret_exc)
+	pushl $0			# orig_eax was lost
+	SAVE_ALL
+	jmp ret_from_exception
 .previous
 .section __ex_table,"a"
 	.align 4
--- linux-2.6/arch/i386/kernel/traps.c
+++ linux-2.6/arch/i386/kernel/traps.c
@@ -357,6 +357,46 @@ static inline void die_if_kernel(const c
 		die(str, regs, err);
 }
 
+/*
+ * When we get an exception in the iret instructions in entry.S, whatever
+ * fault it is really belongs to the user state we are restoring.  We want
+ * to turn it into a signal.  To make that signal's info exactly match what
+ * this same kind of fault in a user instruction would show, the fixup
+ * needs to know the trapno and error code.  But those are lost when we get
+ * back to the fixup entrypoint.  So we have a special case for the iret
+ * fixups, and generate the signal here like a normal user trap would.
+ * Then the fixup code restores the pt_regs on the base of the stack to
+ * the bogus user state it was trying to return to, before handling the signal.
+ */
+extern void iret_exc(void);	/* entry.S label for code in .fixup */
+static inline int is_iret(struct pt_regs *regs)
+{
+	return (regs->eip == (unsigned long)&iret_exc);
+}
+
+/*
+ * If the iret was actually trying to return to kernel mode,
+ * that should be an oops.
+ */
+static inline int iret_to_user(struct pt_regs *regs)
+{
+	/*
+	 * The frame being restored was all popped off and restored except
+	 * the last five words that iret pops.  Instead of popping, it
+	 * pushed another trap frame, clobbering the part of the old one
+	 * that we had already restored.  So the restored registers are now
+	 * all back in the new trap frame, but the eip et al show the
+	 * in-kernel state at the iret instruction.  The bad state we tried
+	 * to restore with iret is still on the stack, right below our
+	 * current trap frame.  The current trap frame was for an in-kernel
+	 * trap, and so doesn't include the esp and ss words--so &regs->esp
+	 * is where %esp was before the iret.
+	 */
+	struct pt_regs *oregs = container_of(&regs->esp, struct pt_regs, eip);
+
+	return likely((oregs->xcs & 3) == 3);
+}
+
 static void do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
@@ -381,8 +421,16 @@ static void do_trap(int trapnr, int sign
 	}
 
 	kernel_trap: {
-		if (!fixup_exception(regs))
+		if (!fixup_exception(regs)) {
+		die:
 			die(str, regs, error_code);
+		}
+		else if (is_iret(regs)) {
+			if (!iret_to_user(regs))
+				goto die;
+			local_irq_enable();
+			goto trap_signal;
+		}
 		return;
 	}
 
@@ -490,6 +538,7 @@ fastcall void do_general_protection(stru
 	if (!(regs->xcs & 3))
 		goto gp_in_kernel;
 
+gp_in_user:
 	current->thread.error_code = error_code;
 	current->thread.trap_no = 13;
 	force_sig(SIGSEGV, current);
@@ -502,11 +551,18 @@ gp_in_vm86:
 
 gp_in_kernel:
 	if (!fixup_exception(regs)) {
+	die:
 		if (notify_die(DIE_GPF, "general protection fault", regs,
 				error_code, 13, SIGSEGV) == NOTIFY_STOP)
 			return;
 		die("general protection fault", regs, error_code);
 	}
+	else if (is_iret(regs)) {
+		if (!iret_to_user(regs))
+			goto die;
+		local_irq_enable();
+		goto gp_in_user;
+	}
 }
 
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
