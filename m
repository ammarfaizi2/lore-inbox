Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265154AbUHMMtm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265154AbUHMMtm (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265161AbUHMMtm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 08:49:42 -0400
Received: from ozlabs.org ([203.10.76.45]:28373 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S265154AbUHMMsn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 08:48:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16668.46948.915425.816720@cargo.ozlabs.ibm.com>
Date: Fri, 13 Aug 2004 22:43:16 +1000
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: anton@samba.org, benh@kernel.crashing.org, trini@kernel.crashing.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC Emulate obsolete instructions
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds emulation in the illegal instruction handler for a
couple of old instructions that are no longer implemented in the
PPC970 and later chips.  This patch adds the code for both ppc32 and
ppc64, and cleans up the ppc64 traps.c a bit, along the lines of the
ppc32 code.  It also makes sure that the ppc64 code generates a
SIGTRAP after emulating an instruction if single-stepping is enabled.

Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN linux-2.5/arch/ppc/kernel/traps.c g5-ppc64/arch/ppc/kernel/traps.c
--- linux-2.5/arch/ppc/kernel/traps.c	2004-07-28 01:06:00.000000000 +1000
+++ g5-ppc64/arch/ppc/kernel/traps.c	2004-08-02 16:02:15.907793416 +1000
@@ -357,7 +357,7 @@
 
 /* Illegal instruction emulation support.  Originally written to
  * provide the PVR to user applications using the mfspr rd, PVR.
- * Return non-zero if we can't emulate, or EFAULT if the associated
+ * Return non-zero if we can't emulate, or -EFAULT if the associated
  * memory access caused an access fault.  Return zero on success.
  *
  * There are a couple of ways to do this, either "decode" the instruction
@@ -368,16 +368,19 @@
 #define INST_MFSPR_PVR		0x7c1f42a6
 #define INST_MFSPR_PVR_MASK	0xfc1fffff
 
+#define INST_DCBA		0x7c0005ec
+#define INST_DCBA_MASK		0x7c0007fe
+
+#define INST_MCRXR		0x7c000400
+#define INST_MCRXR_MASK		0x7c0007fe
+
 static int emulate_instruction(struct pt_regs *regs)
 {
 	u32 instword;
 	u32 rd;
-	int retval;
-
-	retval = -EINVAL;
 
 	if (!user_mode(regs))
-		return retval;
+		return -EINVAL;
 	CHECK_FULL_REGS(regs);
 
 	if (get_user(instword, (u32 __user *)(regs->nip)))
@@ -388,10 +391,24 @@
 	if ((instword & INST_MFSPR_PVR_MASK) == INST_MFSPR_PVR) {
 		rd = (instword >> 21) & 0x1f;
 		regs->gpr[rd] = mfspr(PVR);
-		retval = 0;
-		regs->nip += 4;
+		return 0;
 	}
-	return retval;
+
+	/* Emulating the dcba insn is just a no-op.  */
+	if ((instword & INST_DCBA_MASK) == INST_DCBA)
+		return 0;
+
+	/* Emulate the mcrxr insn.  */
+	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
+		int shift = (instword >> 21) & 0x1c;
+		unsigned long msk = 0xf0000000UL >> shift;
+
+		regs->ccr = (regs->ccr & ~msk) | ((regs->xer >> shift) & msk);
+		regs->xer &= ~0xf0000000UL;
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 /*
@@ -528,17 +545,23 @@
 		return;
 	}
 
-	if (reason & REASON_PRIVILEGED) {
-		/* Try to emulate it if we should. */
-		if (emulate_instruction(regs) == 0) {
+	/* Try to emulate it if we should. */
+	if (reason & (REASON_ILLEGAL | REASON_PRIVILEGED)) {
+		switch (emulate_instruction(regs)) {
+		case 0:
+			regs->nip += 4;
 			emulate_single_step(regs);
 			return;
+		case -EFAULT:
+			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+			return;
 		}
-		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
-		return;
 	}
 
-	_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+	if (reason & REASON_PRIVILEGED)
+		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
+	else
+		_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
 }
 
 void SingleStepException(struct pt_regs *regs)
diff -urN linux-2.5/arch/ppc64/kernel/traps.c g5-ppc64/arch/ppc64/kernel/traps.c
--- linux-2.5/arch/ppc64/kernel/traps.c	2004-07-17 08:44:01.000000000 +1000
+++ g5-ppc64/arch/ppc64/kernel/traps.c	2004-08-02 15:49:15.763791552 +1000
@@ -134,14 +134,20 @@
 }
 
 static void
-_exception(int signr, siginfo_t *info, struct pt_regs *regs)
+_exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
+	siginfo_t info;
+
 	if (!user_mode(regs)) {
 		if (die("Exception in kernel mode", regs, signr))
 			return;
 	}
 
-	force_sig_info(signr, info, current);
+	memset(&info, 0, sizeof(info));
+	info.si_signo = signr;
+	info.si_code = code;
+	info.si_addr = (void __user *) addr;
+	force_sig_info(signr, &info, current);
 }
 
 #ifdef CONFIG_PPC_PSERIES
@@ -213,8 +219,6 @@
  */
 static int recover_mce(struct pt_regs *regs, struct rtas_error_log err)
 {
-	siginfo_t info;
-
 	if (err.disposition == DISP_FULLY_RECOVERED) {
 		/* Platform corrected itself */
 		return 1;
@@ -226,14 +230,10 @@
 		   err.type == TYPE_ECC_UNCORR &&
 		   !(current->pid == 0 || current->pid == 1)) {
 		/* Kill off a user process with an ECC error */
-		info.si_signo = SIGBUS;
-		info.si_errno = 0;
-		/* XXX something better for ECC error? */
-		info.si_code = BUS_ADRERR;
-		info.si_addr = (void __user *)regs->nip;
 		printk(KERN_ERR "MCE: uncorrectable ecc error for pid %d\n",
 		       current->pid);
-		_exception(SIGBUS, &info, regs);
+		/* XXX something better for ECC error? */
+		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
 		return 1;
 	}
 	return 0;
@@ -278,35 +278,46 @@
 void
 UnknownException(struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
 	       regs->nip, regs->msr, regs->trap);
 
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = 0;
-	info.si_addr = NULL;
-	_exception(SIGTRAP, &info, regs);	
+	_exception(SIGTRAP, regs, 0, 0);	
 }
 
 void
 InstructionBreakpointException(struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	if (debugger_iabr_match(regs))
 		return;
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = TRAP_BRKPT;
-	info.si_addr = (void __user *)regs->nip;
-	_exception(SIGTRAP, &info, regs);
+	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
+}
+
+void
+SingleStepException(struct pt_regs *regs)
+{
+	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
+
+	if (debugger_sstep(regs))
+		return;
+
+	_exception(SIGTRAP, regs, TRAP_TRACE, regs->nip);
+}
+
+/*
+ * After we have successfully emulated an instruction, we have to
+ * check if the instruction was being single-stepped, and if so,
+ * pretend we got a single-step exception.  This was pointed out
+ * by Kumar Gala.  -- paulus
+ */
+static inline void emulate_single_step(struct pt_regs *regs)
+{
+	if (regs->msr & MSR_SE)
+		SingleStepException(regs);
 }
 
 static void parse_fpe(struct pt_regs *regs)
 {
-	siginfo_t info;
+	int code = 0;
 	unsigned long fpscr;
 
 	flush_fp_to_thread(current);
@@ -315,31 +326,84 @@
 
 	/* Invalid operation */
 	if ((fpscr & FPSCR_VE) && (fpscr & FPSCR_VX))
-		info.si_code = FPE_FLTINV;
+		code = FPE_FLTINV;
 
 	/* Overflow */
 	else if ((fpscr & FPSCR_OE) && (fpscr & FPSCR_OX))
-		info.si_code = FPE_FLTOVF;
+		code = FPE_FLTOVF;
 
 	/* Underflow */
 	else if ((fpscr & FPSCR_UE) && (fpscr & FPSCR_UX))
-		info.si_code = FPE_FLTUND;
+		code = FPE_FLTUND;
 
 	/* Divide by zero */
 	else if ((fpscr & FPSCR_ZE) && (fpscr & FPSCR_ZX))
-		info.si_code = FPE_FLTDIV;
+		code = FPE_FLTDIV;
 
 	/* Inexact result */
 	else if ((fpscr & FPSCR_XE) && (fpscr & FPSCR_XX))
-		info.si_code = FPE_FLTRES;
+		code = FPE_FLTRES;
+
+	_exception(SIGFPE, regs, code, regs->nip);
+}
+
+/*
+ * Illegal instruction emulation support.  Return non-zero if we can't
+ * emulate, or -EFAULT if the associated memory access caused an access
+ * fault.  Return zero on success.
+ */
+
+#define INST_DCBA		0x7c0005ec
+#define INST_DCBA_MASK		0x7c0007fe
+
+#define INST_MCRXR		0x7c000400
+#define INST_MCRXR_MASK		0x7c0007fe
+
+static int emulate_instruction(struct pt_regs *regs)
+{
+	unsigned int instword;
+
+	if (!user_mode(regs))
+		return -EINVAL;
+
+	CHECK_FULL_REGS(regs);
+
+	if (get_user(instword, (unsigned int __user *)(regs->nip)))
+		return -EFAULT;
 
-	else
-		info.si_code = 0;
+	/* Emulating the dcba insn is just a no-op.  */
+	if ((instword & INST_DCBA_MASK) == INST_DCBA) {
+		static int warned;
 
-	info.si_signo = SIGFPE;
-	info.si_errno = 0;
-	info.si_addr = (void __user *)regs->nip;
-	_exception(SIGFPE, &info, regs);
+		if (!warned) {
+			printk(KERN_WARNING
+			       "process %d (%s) uses obsolete 'dcba' insn\n",
+			       current->pid, current->comm);
+			warned = 1;
+		}
+		return 0;
+	}
+
+	/* Emulate the mcrxr insn.  */
+	if ((instword & INST_MCRXR_MASK) == INST_MCRXR) {
+		static int warned;
+		unsigned int shift;
+
+		if (!warned) {
+			printk(KERN_WARNING
+			       "process %d (%s) uses obsolete 'mcrxr' insn\n",
+			       current->pid, current->comm);
+			warned = 1;
+		}
+
+		shift = (instword >> 21) & 0x1c;
+		regs->ccr &= ~(0xf0000000 >> shift);
+		regs->ccr |= (regs->xer & 0xf0000000) >> shift;
+		regs->xer &= ~0xf0000000;
+		return 0;
+	}
+
+	return -EINVAL;
 }
 
 /*
@@ -395,20 +459,14 @@
 void
 ProgramCheckException(struct pt_regs *regs)
 {
-	siginfo_t info;
-
 	if (regs->msr & 0x100000) {
 		/* IEEE FP exception */
-
 		parse_fpe(regs);
+
 	} else if (regs->msr & 0x40000) {
 		/* Privileged instruction */
+		_exception(SIGILL, regs, ILL_PRVOPC, regs->nip);
 
-		info.si_signo = SIGILL;
-		info.si_errno = 0;
-		info.si_code = ILL_PRVOPC;
-		info.si_addr = (void __user *)regs->nip;
-		_exception(SIGILL, &info, regs);
 	} else if (regs->msr & 0x20000) {
 		/* trap exception */
 
@@ -419,19 +477,24 @@
 			regs->nip += 4;
 			return;
 		}
-		info.si_signo = SIGTRAP;
-		info.si_errno = 0;
-		info.si_code = TRAP_BRKPT;
-		info.si_addr = (void __user *)regs->nip;
-		_exception(SIGTRAP, &info, regs);
+		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
+
 	} else {
-		/* Illegal instruction */
+		/* Illegal instruction; try to emulate it.  */
+		switch (emulate_instruction(regs)) {
+		case 0:
+			regs->nip += 4;
+			emulate_single_step(regs);
+			break;
 
-		info.si_signo = SIGILL;
-		info.si_errno = 0;
-		info.si_code = ILL_ILLTRP;
-		info.si_addr = (void __user *)regs->nip;
-		_exception(SIGILL, &info, regs);
+		case -EFAULT:
+			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->nip);
+			break;
+
+		default:
+			_exception(SIGILL, regs, ILL_ILLOPC, regs->nip);
+			break;
+		}
 	}
 }
 
@@ -448,13 +511,7 @@
 	if (user_mode(regs)) {
 		/* A user program has executed an altivec instruction,
 		   but this kernel doesn't support altivec. */
-		siginfo_t info;
-
-		memset(&info, 0, sizeof(info));
-		info.si_signo = SIGILL;
-		info.si_code = ILL_ILLOPC;
-		info.si_addr = (void *) regs->nip;
-		_exception(SIGILL, &info, regs);
+		_exception(SIGILL, &info, regs, ILL_ILLOPC, regs->nip);
 		return;
 	}
 #endif
@@ -463,35 +520,6 @@
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
 }
 
-void
-SingleStepException(struct pt_regs *regs)
-{
-	siginfo_t info;
-
-	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
-
-	if (debugger_sstep(regs))
-		return;
-
-	info.si_signo = SIGTRAP;
-	info.si_errno = 0;
-	info.si_code = TRAP_TRACE;
-	info.si_addr = (void __user *)regs->nip;
-	_exception(SIGTRAP, &info, regs);	
-}
-
-/*
- * After we have successfully emulated an instruction, we have to
- * check if the instruction was being single-stepped, and if so,
- * pretend we got a single-step exception.  This was pointed out
- * by Kumar Gala.  -- paulus
- */
-static inline void emulate_single_step(struct pt_regs *regs)
-{
-	if (regs->msr & MSR_SE)
-		SingleStepException(regs);
-}
-
 static void dummy_perf(struct pt_regs *regs)
 {
 }
@@ -508,7 +536,6 @@
 AlignmentException(struct pt_regs *regs)
 {
 	int fixed;
-	siginfo_t info;
 
 	fixed = fix_alignment(regs);
 
@@ -521,11 +548,7 @@
 	/* Operand address was bad */	
 	if (fixed == -EFAULT) {
 		if (user_mode(regs)) {
-			info.si_signo = SIGSEGV;
-			info.si_errno = 0;
-			info.si_code = SEGV_MAPERR;
-			info.si_addr = (void __user *)regs->dar;
-			force_sig_info(SIGSEGV, &info, current);
+			_exception(SIGSEGV, regs, SEGV_MAPERR, regs->dar);
 		} else {
 			/* Search exception table */
 			bad_page_fault(regs, regs->dar, SIGSEGV);
@@ -534,11 +557,7 @@
 		return;
 	}
 
-	info.si_signo = SIGBUS;
-	info.si_errno = 0;
-	info.si_code = BUS_ADRALN;
-	info.si_addr = (void __user *)regs->nip;
-	_exception(SIGBUS, &info, regs);	
+	_exception(SIGBUS, regs, BUS_ADRALN, regs->nip);
 }
 
 #ifdef CONFIG_ALTIVEC
