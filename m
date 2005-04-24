Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262210AbVDXAvk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262210AbVDXAvk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 20:51:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262211AbVDXAvk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 20:51:40 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15329 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262210AbVDXAup (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 20:50:45 -0400
Date: Sat, 23 Apr 2005 17:50:37 -0700
Message-Id: <200504240050.j3O0obqR032684@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       Andi Kleen <ak@suse.de>
X-Fcc: ~/Mail/linus
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] x86_64: handle iret faults better
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is the x86_64 variant of the i386 fix I just submitted.  I think
iret can only produce these faults when returning to user mode in a
32-bit process.  The failure mode is even more mysterious on x86_64,
because it exits with -9999&0x7f instead of 11 (SIGSEGV), so it says
"Unknown signal 113 (core dumped)" when it exits without actually
trying to dump a core file.


Thanks,
Roland


Signed-off-by: Roland McGrath <roland@redhat.com>

--- linux-2.6/arch/x86_64/kernel/entry.S
+++ linux-2.6/arch/x86_64/kernel/entry.S
@@ -471,14 +470,6 @@ iret_label:	
 	.section __ex_table,"a"
 	.quad iret_label,bad_iret	
 	.previous
-	.section .fixup,"ax"
-	/* force a signal here? this matches i386 behaviour */
-	/* running with kernel gs */
-bad_iret:
-	movq $-9999,%rdi	/* better code? */
-	jmp do_exit			
-	.previous	
-	
 	/* edi: workmask, edx: work */	
 retint_careful:
 	bt    $TIF_NEED_RESCHED,%edx
@@ -522,6 +513,31 @@ retint_kernel:	
 #endif	
 	CFI_ENDPROC
 	
+	/*
+	 * Traps in iret mean that userland tried to restore a bogus
+	 * cs, eip, ss, esp, or eflags.  Some kinds of bogosity just cause
+	 * a trap after the iret returns, but some will cause a trap in
+	 * iret itself.  We want to treat those as if the restored user
+	 * state is what caused that trap, i.e. produce the appropriate signal.
+	 * Since normal .fixup code doesn't have access to the trap info,
+	 * traps.c has a special case for iret.  It's already generated the
+	 * signal before we resume at bad_iret.  Now we just need to recover
+	 * the whole frame we were trying to restore, so it can be seen on
+	 * our stack by the debugger.
+	 */
+	.section .fixup,"ax"
+	/* running with kernel gs */
+ENTRY(bad_iret)
+	CFI_STARTPROC	simple
+	CFI_DEF_CFA	rsp,(SS+8-RIP)
+	CFI_REL_OFFSET	rip,0
+	CFI_REL_OFFSET	rsp,(RSP-RIP)
+	SAVE_ARGS 8
+	jmp exit_intr
+	CFI_ENDPROC
+	.previous
+
+	    
 /*
  * APIC interrupts.
  */		
@@ -826,7 +842,10 @@ paranoid_swapgs:	
 	swapgs
 paranoid_restore:	
 	RESTORE_ALL 8
-	iretq
+1:	iretq
+	.section __ex_table,"a"
+	.quad 1b,bad_iret
+	.previous
 paranoid_userspace:	
 	cli
 	GET_THREAD_INFO(%rcx)
--- linux-2.6/arch/x86_64/kernel/traps.c
+++ linux-2.6/arch/x86_64/kernel/traps.c
@@ -404,6 +404,44 @@ void die_nmi(char *str, struct pt_regs *
 	do_exit(SIGSEGV);
 }
 
+
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
+extern void bad_iret(void);	/* entry.S label for code in .fixup */
+static inline int is_iret(struct pt_regs *regs)
+{
+	return (regs->rip == (unsigned long)&bad_iret);
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
+	 * all back in the new trap frame, but the rip et al show the
+	 * in-kernel state at the iret instruction.  The bad state we tried
+	 * to restore with iret is still on the old stack below.
+	 */
+	struct pt_regs *oregs = container_of((unsigned long *) regs->rsp,
+					     struct pt_regs, rip);
+
+	return likely((oregs->cs & 3) == 3);
+}
 static void do_trap(int trapnr, int signr, char *str, 
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
@@ -423,7 +461,9 @@ static void do_trap(int trapnr, int sign
 #endif
 
 	if ((regs->cs & 3)  != 0) { 
-		struct task_struct *tsk = current;
+		struct task_struct *tsk;
+	user_trap:
+		tsk = current;
 
 		if (exception_trace && unhandled_signal(tsk, signr))
 			printk(KERN_INFO
@@ -447,7 +487,13 @@ static void do_trap(int trapnr, int sign
 		fixup = search_exception_tables(regs->rip);
 		if (fixup) {
 			regs->rip = fixup->fixup;
-		} else	
-			die(str, regs, error_code);
+			if (!is_iret(regs))
+				return;
+			if (iret_to_user(regs)) {
+				local_irq_enable();
+				goto user_trap;
+			}
+		}
+		die(str, regs, error_code);
 		return;
 	}
@@ -523,8 +569,10 @@ asmlinkage void do_general_protection(st
        }
 #endif
 
-	if ((regs->cs & 3)!=0) { 
-		struct task_struct *tsk = current;
+	if ((regs->cs & 3) != 0) {
+		struct task_struct *tsk;
+	user_gp:
+		tsk = current;
 
 		if (exception_trace && unhandled_signal(tsk, SIGSEGV))
 			printk(KERN_INFO
@@ -544,7 +592,12 @@ asmlinkage void do_general_protection(st
 		fixup = search_exception_tables(regs->rip);
 		if (fixup) {
 			regs->rip = fixup->fixup;
-			return;
+			if (!is_iret(regs))
+				return;
+			if (iret_to_user(regs)) {
+				local_irq_enable();
+				goto user_gp;
+			}
 		}
 		if (notify_die(DIE_GPF, "general protection fault", regs,
 					error_code, 13, SIGSEGV) == NOTIFY_STOP)
