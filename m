Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262242AbVD2DqT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262242AbVD2DqT (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Apr 2005 23:46:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262378AbVD2DqT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Apr 2005 23:46:19 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62113 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262242AbVD2Dpl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Apr 2005 23:45:41 -0400
Date: Thu, 28 Apr 2005 20:45:35 -0700
Message-Id: <200504290345.j3T3jZZr032230@magilla.sf.frob.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
From: Roland McGrath <roland@redhat.com>
To: Linus Torvalds <torvalds@osdl.org>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH] x86_64: handle iret faults better
In-Reply-To: Linus Torvalds's message of  Monday, 25 April 2005 21:06:28 -0700 <Pine.LNX.4.58.0504252102180.18901@ppc970.osdl.org>
X-Fcc: ~/Mail/linus
X-Antipastobozoticataclysm: When George Bush projectile vomits antipasto on the Japanese.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Here is the x86-64 version of the new patch (I just sent the i386 one).
The same comments apply here about the fault.c changes.  I made a
fixup_exception function like i386's, replacing the duplication of its
contents in several places rather than adding new code to all the duplicates.


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

--- linux-2.6/arch/x86_64/kernel/entry.S  (mode:100644 sha1:3233a15cc4e074c00b75569f21c2844ee280b214)
+++ linux-2.6/arch/x86_64/kernel/entry.S  (mode:100644 sha1:85d0b453385807901a446ed0e8f6c5b2d96e0ca5)
@@ -44,6 +44,9 @@
 
 	.code64
 
+/* This marks an __ex_table entry that has an exception_fixup_t handler.  */
+#define SPECIAL_FIXUP(function)	(function - __PAGE_OFFSET)
+
 #ifndef CONFIG_PREEMPT
 #define retint_kernel retint_restore_args
 #endif	
@@ -459,14 +462,7 @@
 	iretq
 
 	.section __ex_table,"a"
-	.quad iret_label,bad_iret	
-	.previous
-	.section .fixup,"ax"
-	/* force a signal here? this matches i386 behaviour */
-	/* running with kernel gs */
-bad_iret:
-	movq $-9999,%rdi	/* better code? */
-	jmp do_exit			
+ 	.quad iret_label,SPECIAL_FIXUP(fixup_iret)
 	.previous	
 	
 	/* edi: workmask, edx: work */	
@@ -509,6 +508,31 @@
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
+	 * signal before we resume at iret_exc.  Now we just need to recover
+	 * the whole frame we were trying to restore, so it can be seen on
+	 * our stack by the debugger.
+	 */
+	.section .fixup,"ax"
+	/* running with kernel gs */
+ENTRY(iret_exc)
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
@@ -819,7 +843,10 @@
 	swapgs
 paranoid_restore:	
 	RESTORE_ALL 8
-	iretq
+1:	iretq
+	.section __ex_table,"a"
+	.quad 1b,SPECIAL_FIXUP(fixup_iret)
+	.previous
 paranoid_userspace:	
 	GET_THREAD_INFO(%rcx)
 	movl threadinfo_flags(%rcx),%ebx
--- linux-2.6/arch/x86_64/kernel/traps.c  (mode:100644 sha1:65a37f52c56ef2c0760f2e3db9dfec9312a74d88)
+++ linux-2.6/arch/x86_64/kernel/traps.c  (mode:100644 sha1:9d199565e3a72768dfd8c352860e3d13306669f2)
@@ -417,6 +417,59 @@
 	do_exit(SIGSEGV);
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
+	 * all back in the new trap frame, but the rip et al show the
+	 * in-kernel state at the iret instruction.  The bad state we tried
+	 * to restore with iret is still on the old stack below.
+	 */
+	struct pt_regs *oregs = container_of((unsigned long *) regs->rsp,
+					     struct pt_regs, rip);
+	struct task_struct *tsk = current;
+
+	if (likely((oregs->cs & 3) == 3)) {
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
+		regs->rip = (unsigned long) &iret_exc;
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
+
 static void do_trap(int trapnr, int signr, char *str, 
 			   struct pt_regs * regs, long error_code, siginfo_t *info)
 {
@@ -455,15 +508,8 @@
 
 
 	/* kernel trap */ 
-	{	     
-		const struct exception_table_entry *fixup;
-		fixup = search_exception_tables(regs->rip);
-		if (fixup) {
-			regs->rip = fixup->fixup;
-		} else	
-			die(str, regs, error_code);
-		return;
-	}
+	if (!fixup_exception(regs, trapnr, signr, error_code, info))
+		die(str, regs, error_code);
 }
 
 #define DO_ERROR(trapnr, signr, str, name) \
@@ -520,7 +566,7 @@
        }
 #endif
 
-	if ((regs->cs & 3)!=0) { 
+	if ((regs->cs & 3) != 0) {
 		struct task_struct *tsk = current;
 
 		if (exception_trace && unhandled_signal(tsk, SIGSEGV))
@@ -536,18 +582,12 @@
 	} 
 
 	/* kernel gp */
-	{
-		const struct exception_table_entry *fixup;
-		fixup = search_exception_tables(regs->rip);
-		if (fixup) {
-			regs->rip = fixup->fixup;
-			return;
-		}
-		if (notify_die(DIE_GPF, "general protection fault", regs,
-					error_code, 13, SIGSEGV) == NOTIFY_STOP)
-			return;
-		die("general protection fault", regs, error_code);
-	}
+	if (fixup_exception(regs, 13, SIGSEGV, error_code, NULL))
+		return;
+	if (notify_die(DIE_GPF, "general protection fault", regs,
+		       error_code, 13, SIGSEGV) == NOTIFY_STOP)
+		return;
+	die("general protection fault", regs, error_code);
 }
 
 static void mem_parity_error(unsigned char reason, struct pt_regs * regs)
@@ -729,12 +769,8 @@
 
 static int kernel_math_error(struct pt_regs *regs, char *str)
 {
-	const struct exception_table_entry *fixup;
-	fixup = search_exception_tables(regs->rip);
-	if (fixup) {
-		regs->rip = fixup->fixup;
+	if (fixup_exception(regs, 16, SIGFPE, 0, NULL))
 		return 1;
-	}
 	notify_die(DIE_GPF, str, regs, 0, 16, SIGFPE);
 	/* Illegal floating point operation in the kernel */
 	die(str, regs, 0);
--- linux-2.6/arch/x86_64/mm/extable.c  (mode:100644 sha1:2d78f9fb403542b72771075502c4c662cc06ca35)
+++ linux-2.6/arch/x86_64/mm/extable.c  (mode:100644 sha1:e8fd080fffb380dd4e60ea08f8b4e086f63563dd)
@@ -33,3 +33,21 @@
         }
         return NULL;
 }
+
+int fixup_exception(struct pt_regs *regs, int trapnr, int signr,
+		    unsigned long error_code, siginfo_t *info)
+{
+	const struct exception_table_entry *fixup;
+
+	fixup = search_exception_tables(regs->rip);
+	if (fixup) {
+		if (fixup_is_special(fixup)) {
+			exception_fixup_t *hook = special_fixup_handler(fixup);
+			return (*hook) (regs, trapnr, signr, error_code, info);
+		}
+		regs->rip = fixup->fixup;
+		return 1;
+	}
+
+	return 0;
+}
--- linux-2.6/arch/x86_64/mm/fault.c  (mode:100644 sha1:e3f90b6abb8d5fabfac28799e8a493f59759eed0)
+++ linux-2.6/arch/x86_64/mm/fault.c  (mode:100644 sha1:92168ed10c1cdb4ca1eee76b1b4b67bb91dfa984)
@@ -298,7 +298,6 @@
 	struct mm_struct *mm;
 	struct vm_area_struct * vma;
 	unsigned long address;
-	const struct exception_table_entry *fixup;
 	int write;
 	siginfo_t info;
 
@@ -456,6 +455,12 @@
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
 		if (is_prefetch(regs, address, error_code))
@@ -483,10 +488,6 @@
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
@@ -494,11 +495,8 @@
 no_context:
 	
 	/* Are we prepared to handle this kernel fault?  */
-	fixup = search_exception_tables(regs->rip);
-	if (fixup) {
-		regs->rip = fixup->fixup;
+	if (fixup_exception(regs, 14, info.si_signo, error_code, &info))
 		return;
-	}
 
 	/* 
 	 * Hall of shame of CPU/BIOS bugs.
@@ -544,11 +542,20 @@
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
@@ -556,10 +563,6 @@
 	tsk->thread.cr2 = address;
 	tsk->thread.error_code = error_code;
 	tsk->thread.trap_no = 14;
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRERR;
-	info.si_addr = (void __user *)address;
 	force_sig_info(SIGBUS, &info, tsk);
 	return;
 }
--- linux-2.6/include/asm-x86_64/uaccess.h  (mode:100644 sha1:48f292752c96bac97900682b98e947651b701d6b)
+++ linux-2.6/include/asm-x86_64/uaccess.h  (mode:100644 sha1:721817e4c48297af0306137b659325425d4bf82f)
@@ -73,6 +73,19 @@
 {
 	unsigned long insn, fixup;
 };
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
 
 #define ARCH_HAS_SEARCH_EXTABLE
 
