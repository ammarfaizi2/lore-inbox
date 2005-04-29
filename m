Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262377AbVD2DlL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262377AbVD2DlL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 23:41:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVD2DlL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 23:41:11 -0400
Received: from mx1.redhat.com ([66.187.233.31]:23712 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262377AbVD2DkV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 23:40:21 -0400
Date: Thu, 28 Apr 2005 20:40:12 -0700
Message-Id: <200504290340.j3T3eCcO032218@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
X-Fcc: ~/Mail/linus
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] i386: handle iret faults better
In-Reply-To: Linus Torvalds's message of  Monday, 25 April 2005 21:06:28 -0700 <Pine.LNX.4.58.0504252102180.18901@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I was never very happy with the special-case check for iret_exc either.
But for the first crack, I went for the fix that didn't touch other
infrastructure code.

The fault.c changes here are really not necessary for the bug fix at all,
it will never be used there.  But to make it a clean infrastructure
upgrade, I made every caller of fixup_exception consistently pass in the
complete info it uses for signals in the user-mode case.


A user process can cause a kernel-mode fault in the iret instruction, by
setting an invalid %cs and such, via ptrace or sigreturn.  The fixup code
now calls do_exit(11), so a process will die with SIGSEGV but never
generate a core dump.  This is vastly more confusing in a multithreaded
program, because do_exit just kills that one thread and so it appears to
mysteriously disappear when it calls sigreturn.

This patch makes faults in iret produce the normal signals that would
result from the same errors when executing some user-mode instruction.
To accomplish this, I've extended the exception_table mechanism to support
"special fixups".  Instead of a PC location to jump to, these have a
function called in the trap handler context and passed the full trap details.

Signed-off-by: Roland McGrath <roland@redhat.com>

---
commit 66b1fbcee2c94a5fd9d199e48a25d5f6382f6f05
tree cb5e97a950137e15a400501ab3aa95fe539d0a45
parent f6bbd250c19529f6efebc6c8bd7d3495b98e5eca
author Roland McGrath <roland@redhat.com> 1114589292 -0700
committer Roland McGrath <roland@redhat.com> 1114589292 -0700

Index: arch/i386/kernel/entry.S
===================================================================
--- 23cf0cf93e225498eea50480a44b038be19b333d/arch/i386/kernel/entry.S  (mode:100644 sha1:3c73dc865ead3ad2323098a3b78b0fc8042e7489)
+++ cb5e97a950137e15a400501ab3aa95fe539d0a45/arch/i386/kernel/entry.S  (mode:100644 sha1:d8e602ca337b434e48f2014048f7ecdef221198f)
@@ -75,6 +75,9 @@
 NT_MASK		= 0x00004000
 VM_MASK		= 0x00020000
 
+/* This marks an __ex_table entry that has an exception_fixup_t handler.  */
+#define SPECIAL_FIXUP(function)	(function - __PAGE_OFFSET)
+
 #ifdef CONFIG_PREEMPT
 #define preempt_stop		cli
 #else
@@ -257,18 +260,27 @@
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
-	.long 1b,iret_exc
+	.long 1b,SPECIAL_FIXUP(fixup_iret)
 .previous
 
 ldt_ss:
@@ -293,7 +305,7 @@
 1:	iret
 .section __ex_table,"a"
 	.align 4
-	.long 1b,iret_exc
+	.long 1b,SPECIAL_FIXUP(fixup_iret)
 .previous
 
 	# perform work that needs to be done immediately before resumption
@@ -589,7 +601,7 @@
 1:	iret
 .section __ex_table,"a"
 	.align 4
-	.long 1b,iret_exc
+	.long 1b,SPECIAL_FIXUP(fixup_iret)
 .previous
 
 ENTRY(int3)
Index: arch/i386/kernel/traps.c
===================================================================
--- 23cf0cf93e225498eea50480a44b038be19b333d/arch/i386/kernel/traps.c  (mode:100644 sha1:6c0e383915b6a0d9fc516a04f328020d18b575b5)
+++ cb5e97a950137e15a400501ab3aa95fe539d0a45/arch/i386/kernel/traps.c  (mode:100644 sha1:12b09606ace52f8d8525b6e4f1d2987ab8873308)
@@ -357,6 +357,60 @@
 		die(str, regs, err);
 }
 
+/*
+ * When we get an exception in the iret instructions in entry.S, whatever
+ * fault it is really belongs to the user state we are restoring.  We want
+ * to turn it into a signal.  To make that signal's info exactly match what
+ * this same kind of fault in a user instruction would show, the fixup
+ * needs to know the trapno and error code.  So, we use this special fixup
+ * hook for the iret instructions.  If the iret was returning to user mode,
+ * we force a signal like the same exception in user mode would have.  Then
+ * the fixup code at iret_exc (entry.S) restores the pt_regs on the base of
+ * the stack to the bogus user state it was trying to return to, before
+ * handling the signal.
+ */
+int fixup_iret(struct pt_regs *regs, int trapnr, int signr,
+	       unsigned long error_code, siginfo_t *info)
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
+	struct task_struct *tsk = current;
+
+	if (likely((oregs->xcs & 3) == 3)) {
+		/*
+		 * The iret was trying to return to user mode.
+		 * Turn this into a signal like do_trap would normally do.
+		 */
+		extern void iret_exc(void);
+		local_irq_enable();
+		tsk->thread.error_code = error_code;
+		tsk->thread.trap_no = trapnr;
+		if (info)
+			force_sig_info(signr, info, tsk);
+		else
+			force_sig(signr, tsk);
+		regs->eip = (unsigned long) &iret_exc;
+		return 1;
+	}
+
+	/*
+	 * The iret was actually trying to return to kernel mode,
+	 * so in fact we didn't handle this exception.
+	 */
+	return 0;
+}
+
 static void do_trap(int trapnr, int signr, char *str, int vm86,
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
@@ -381,7 +435,7 @@
 	}
 
 	kernel_trap: {
-		if (!fixup_exception(regs))
+		if (!fixup_exception(regs, trapnr, signr, error_code, info))
 			die(str, regs, error_code);
 		return;
 	}
@@ -501,7 +555,7 @@
 	return;
 
 gp_in_kernel:
-	if (!fixup_exception(regs)) {
+	if (!fixup_exception(regs, 13, SIGSEGV, error_code, NULL)) {
 		if (notify_die(DIE_GPF, "general protection fault", regs,
 				error_code, 13, SIGSEGV) == NOTIFY_STOP)
 			return;
Index: arch/i386/mm/extable.c
===================================================================
--- 23cf0cf93e225498eea50480a44b038be19b333d/arch/i386/mm/extable.c  (mode:100644 sha1:f706449319c4577e5d944561b295d199449bcc02)
+++ cb5e97a950137e15a400501ab3aa95fe539d0a45/arch/i386/mm/extable.c  (mode:100644 sha1:14eec19b079d5afcee76547b4e9a7e33ec384cff)
@@ -7,7 +7,8 @@
 #include <linux/spinlock.h>
 #include <asm/uaccess.h>
 
-int fixup_exception(struct pt_regs *regs)
+int fixup_exception(struct pt_regs *regs, int trapnr, int signr,
+		    unsigned long error_code, siginfo_t *info)
 {
 	const struct exception_table_entry *fixup;
 
@@ -28,6 +29,10 @@
 
 	fixup = search_exception_tables(regs->eip);
 	if (fixup) {
+		if (fixup_is_special(fixup)) {
+			exception_fixup_t *hook = special_fixup_handler(fixup);
+			return (*hook) (regs, trapnr, signr, error_code, info);
+		}
 		regs->eip = fixup->fixup;
 		return 1;
 	}
Index: arch/i386/mm/fault.c
===================================================================
--- 23cf0cf93e225498eea50480a44b038be19b333d/arch/i386/mm/fault.c  (mode:100644 sha1:a509237c4815ed6f8443e85b973dda2a0f2c0688)
+++ cb5e97a950137e15a400501ab3aa95fe539d0a45/arch/i386/mm/fault.c  (mode:100644 sha1:be670e7a9593e5a349408262400d6e31296db92d)
@@ -374,6 +374,12 @@
 	up_read(&mm->mmap_sem);
 
 bad_area_nosemaphore:
+	/* Set up info passed to force_sig_info or to fixup_exception.  */
+	info.si_signo = SIGSEGV;
+	info.si_errno = 0;
+	/* info.si_code has been set above */
+	info.si_addr = (void __user *)address;
+
 	/* User mode accesses just cause a SIGSEGV */
 	if (error_code & 4) {
 		/* 
@@ -387,10 +393,6 @@
 		/* Kernel addresses are always protection faults */
 		tsk->thread.error_code = error_code | (address >= TASK_SIZE);
 		tsk->thread.trap_no = 14;
-		info.si_signo = SIGSEGV;
-		info.si_errno = 0;
-		/* info.si_code has been set above */
-		info.si_addr = (void __user *)address;
 		force_sig_info(SIGSEGV, &info, tsk);
 		return;
 	}
@@ -413,7 +415,7 @@
 
 no_context:
 	/* Are we prepared to handle this kernel fault?  */
-	if (fixup_exception(regs))
+	if (fixup_exception(regs, 14, info.si_signo, error_code, &info))
 		return;
 
 	/* 
@@ -481,11 +483,20 @@
 	printk("VM: killing process %s\n", tsk->comm);
 	if (error_code & 4)
 		do_exit(SIGKILL);
+	info.si_signo = SIGKILL;
+	info.si_errno = 0;
+	info.si_addr = (void __user *)address;
 	goto no_context;
 
 do_sigbus:
 	up_read(&mm->mmap_sem);
 
+	/* Set up info passed to force_sig_info or to fixup_exception.  */
+	info.si_signo = SIGBUS;
+	info.si_errno = 0;
+	info.si_code = BUS_ADRERR;
+	info.si_addr = (void __user *)address;
+
 	/* Kernel mode? Handle exceptions or die */
 	if (!(error_code & 4))
 		goto no_context;
@@ -497,14 +508,15 @@
 	tsk->thread.cr2 = address;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = 14;
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *)address;
 	force_sig_info(SIGBUS, &info, tsk);
 	return;
 
 vmalloc_fault:
+	/* Set up info passed to fixup_exception.  */
+	info.si_signo = SIGSEGV;
+	info.si_errno = 0;
+	/* info.si_code has been set above */
+	info.si_addr = (void __user *)address;
 	{
 		/*
 		 * Synchronize this task's top level page-table
Index: include/asm-i386/uaccess.h
===================================================================
--- 23cf0cf93e225498eea50480a44b038be19b333d/include/asm-i386/uaccess.h  (mode:100644 sha1:886867aea947094185fcac17610acc67f9310caf)
+++ cb5e97a950137e15a400501ab3aa95fe539d0a45/include/asm-i386/uaccess.h  (mode:100644 sha1:50cd8556e8825a5c6f42ec4dc062e952c27317d3)
@@ -124,8 +124,19 @@
 {
 	unsigned long insn, fixup;
 };
-
-extern int fixup_exception(struct pt_regs *regs);
+static inline int fixup_is_special(const struct exception_table_entry *entry)
+{
+	return unlikely(entry->fixup < PAGE_OFFSET);
+}
+struct siginfo;
+typedef int exception_fixup_t(struct pt_regs *regs, int trapnr, int signr,
+			      unsigned long err, struct siginfo *info);
+static inline exception_fixup_t *
+special_fixup_handler(const struct exception_table_entry *entry)
+{
+	return (exception_fixup_t *) (entry->fixup + PAGE_OFFSET);
+}
+extern exception_fixup_t fixup_exception;
 
 /*
  * These are the main single-value transfer routines.  They automatically
