Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262249AbVAEFgR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262249AbVAEFgR (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 5 Jan 2005 00:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262253AbVAEFgR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 5 Jan 2005 00:36:17 -0500
Received: from ozlabs.org ([203.10.76.45]:32199 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S262249AbVAEFet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 5 Jan 2005 00:34:49 -0500
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16859.31857.871514.779890@cargo.ozlabs.ibm.com>
Date: Wed, 5 Jan 2005 16:34:41 +1100
From: Paul Mackerras <paulus@samba.org>
To: akpm@osdl.org
Cc: Jake Moilanen <moilanen@austin.ibm.com>, anton@samba.org,
       linux-kernel@vger.kernel.org
Subject: [PATCH] PPC64 (1/3) Clean up trap handling
X-Mailer: VM 7.19 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is from Jake Moilanen <moilanen@austin.ibm.com>.

Clean-up of traps.c.  Moved the machine dependent calls to a ppc_md call,
and moved the pSeries specific code to ras.c.

I also changed the naming convention to more closely follow the Linux
standards.

Signed-off-by: Jake Moilanen <moilanen@austin.ibm.com>
Signed-off-by: Paul Mackerras <paulus@samba.org>

diff -urN base-2.6/arch/ppc64/kernel/head.S test/arch/ppc64/kernel/head.S
--- base-2.6/arch/ppc64/kernel/head.S	2005-01-05 14:30:33.307477064 +1100
+++ test/arch/ppc64/kernel/head.S	2005-01-05 15:53:26.007523296 +1100
@@ -738,7 +738,7 @@
 
 /*** Common interrupt handlers ***/
 
-	STD_EXCEPTION_COMMON(0x100, SystemReset, .SystemResetException)
+	STD_EXCEPTION_COMMON(0x100, SystemReset, .system_reset_exception)
 
 	/*
 	 * Machine check is different because we use a different
@@ -751,20 +751,20 @@
 	DISABLE_INTS
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
-	bl	.MachineCheckException
+	bl	.machine_check_exception
 	b	.ret_from_except
 
 	STD_EXCEPTION_COMMON_LITE(0x900, Decrementer, .timer_interrupt)
-	STD_EXCEPTION_COMMON(0xa00, Trap_0a, .UnknownException)
-	STD_EXCEPTION_COMMON(0xb00, Trap_0b, .UnknownException)
-	STD_EXCEPTION_COMMON(0xd00, SingleStep, .SingleStepException)
-	STD_EXCEPTION_COMMON(0xe00, Trap_0e, .UnknownException)
-	STD_EXCEPTION_COMMON(0xf00, PerformanceMonitor, .PerformanceMonitorException)
-	STD_EXCEPTION_COMMON(0x1300, InstructionBreakpoint, .InstructionBreakpointException)
+	STD_EXCEPTION_COMMON(0xa00, Trap_0a, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xb00, Trap_0b, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xd00, SingleStep, .single_step_exception)
+	STD_EXCEPTION_COMMON(0xe00, Trap_0e, .unknown_exception)
+	STD_EXCEPTION_COMMON(0xf00, PerformanceMonitor, .performance_monitor_exception)
+	STD_EXCEPTION_COMMON(0x1300, InstructionBreakpoint, .instruction_breakpoint_exception)
 #ifdef CONFIG_ALTIVEC
-	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .AltivecAssistException)
+	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .altivec_assist_exception)
 #else
-	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .UnknownException)
+	STD_EXCEPTION_COMMON(0x1700, AltivecAssist, .unknown_exception)
 #endif
 
 /*
@@ -901,7 +901,7 @@
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ENABLE_INTS
-	bl	.AlignmentException
+	bl	.alignment_exception
 	b	.ret_from_except
 
 	.align	7
@@ -911,7 +911,7 @@
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ENABLE_INTS
-	bl	.ProgramCheckException
+	bl	.program_check_exception
 	b	.ret_from_except
 
 	.align	7
@@ -922,7 +922,7 @@
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ENABLE_INTS
-	bl	.KernelFPUnavailableException
+	bl	.kernel_fp_unavailable_exception
 	BUG_OPCODE
 
 	.align	7
@@ -935,7 +935,7 @@
 	bl	.save_nvgprs
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	ENABLE_INTS
-	bl	.AltivecUnavailableException
+	bl	.altivec_unavailable_exception
 	b	.ret_from_except
 
 /*
diff -urN base-2.6/arch/ppc64/kernel/pSeries_setup.c test/arch/ppc64/kernel/pSeries_setup.c
--- base-2.6/arch/ppc64/kernel/pSeries_setup.c	2005-01-05 14:31:28.374490024 +1100
+++ test/arch/ppc64/kernel/pSeries_setup.c	2005-01-05 15:57:41.099472328 +1100
@@ -80,7 +80,8 @@
 extern void pSeries_get_rtc_time(struct rtc_time *rtc_time);
 extern int  pSeries_set_rtc_time(struct rtc_time *rtc_time);
 extern void find_udbg_vterm(void);
-extern void SystemReset_FWNMI(void), MachineCheck_FWNMI(void);	/* from head.S */
+extern void system_reset_fwnmi(void);	/* from head.S */
+extern void machine_check_fwnmi(void);	/* from head.S */
 extern void generic_find_legacy_serial_ports(u64 *physport,
 		unsigned int *default_speed);
 
@@ -93,6 +94,9 @@
 extern unsigned long ppc_proc_freq;
 extern unsigned long ppc_tb_freq;
 
+extern void pSeries_system_reset_exception(struct pt_regs *regs);
+extern int pSeries_machine_check_exception(struct pt_regs *regs);
+
 static volatile void __iomem * chrp_int_ack_special;
 struct mpic *pSeries_mpic;
 
@@ -119,8 +123,8 @@
 	if (ibm_nmi_register == RTAS_UNKNOWN_SERVICE)
 		return;
 	ret = rtas_call(ibm_nmi_register, 2, 1, NULL,
-			__pa((unsigned long)SystemReset_FWNMI),
-			__pa((unsigned long)MachineCheck_FWNMI));
+			__pa((unsigned long)system_reset_fwnmi),
+			__pa((unsigned long)machine_check_fwnmi));
 	if (ret == 0)
 		fwnmi_active = 1;
 }
@@ -612,4 +616,6 @@
 	.calibrate_decr		= pSeries_calibrate_decr,
 	.progress		= pSeries_progress,
 	.check_legacy_ioport	= pSeries_check_legacy_ioport,
+	.system_reset_exception = pSeries_system_reset_exception,
+	.machine_check_exception = pSeries_machine_check_exception,
 };
diff -urN base-2.6/arch/ppc64/kernel/ras.c test/arch/ppc64/kernel/ras.c
--- base-2.6/arch/ppc64/kernel/ras.c	2004-10-21 07:17:18.000000000 +1000
+++ test/arch/ppc64/kernel/ras.c	2005-01-05 15:53:25.987526336 +1100
@@ -55,6 +55,9 @@
 static unsigned char ras_log_buf[RTAS_ERROR_LOG_MAX];
 static spinlock_t ras_log_buf_lock = SPIN_LOCK_UNLOCKED;
 
+/* This is true if we are using the firmware NMI handler (typically LPAR) */
+extern int fwnmi_active;
+
 static int ras_get_sensor_state_token;
 static int ras_check_exception_token;
 
@@ -234,3 +237,104 @@
 	spin_unlock(&ras_log_buf_lock);
 	return IRQ_HANDLED;
 }
+
+/* Get the error information for errors coming through the
+ * FWNMI vectors.  The pt_regs' r3 will be updated to reflect
+ * the actual r3 if possible, and a ptr to the error log entry
+ * will be returned if found.
+ */
+static struct rtas_error_log *fwnmi_get_errinfo(struct pt_regs *regs)
+{
+	unsigned long errdata = regs->gpr[3];
+	struct rtas_error_log *errhdr = NULL;
+	unsigned long *savep;
+
+	if ((errdata >= 0x7000 && errdata < 0x7fff0) ||
+	    (errdata >= rtas.base && errdata < rtas.base + rtas.size - 16)) {
+		savep = __va(errdata);
+		regs->gpr[3] = savep[0];	/* restore original r3 */
+		errhdr = (struct rtas_error_log *)(savep + 1);
+	} else {
+		printk("FWNMI: corrupt r3\n");
+	}
+	return errhdr;
+}
+
+/* Call this when done with the data returned by FWNMI_get_errinfo.
+ * It will release the saved data area for other CPUs in the
+ * partition to receive FWNMI errors.
+ */
+static void fwnmi_release_errinfo(void)
+{
+	int ret = rtas_call(rtas_token("ibm,nmi-interlock"), 0, 1, NULL);
+	if (ret != 0)
+		printk("FWNMI: nmi-interlock failed: %d\n", ret);
+}
+
+void pSeries_system_reset_exception(struct pt_regs *regs)
+{
+	if (fwnmi_active) {
+		struct rtas_error_log *errhdr = fwnmi_get_errinfo(regs);
+		if (errhdr) {
+			/* XXX Should look at FWNMI information */
+		}
+		fwnmi_release_errinfo();
+	}
+}
+
+/* 
+ * See if we can recover from a machine check exception.
+ * This is only called on power4 (or above) and only via
+ * the Firmware Non-Maskable Interrupts (fwnmi) handler
+ * which provides the error analysis for us.
+ *
+ * Return 1 if corrected (or delivered a signal).
+ * Return 0 if there is nothing we can do.
+ */
+static int recover_mce(struct pt_regs *regs, struct rtas_error_log err)
+{
+	if (err.disposition == RTAS_DISP_FULLY_RECOVERED) {
+		/* Platform corrected itself */
+		return 1;
+	} else if ((regs->msr & MSR_RI) &&
+		   user_mode(regs) &&
+		   err.severity == RTAS_SEVERITY_ERROR_SYNC &&
+		   err.disposition == RTAS_DISP_NOT_RECOVERED &&
+		   err.target == RTAS_TARGET_MEMORY &&
+		   err.type == RTAS_TYPE_ECC_UNCORR &&
+		   !(current->pid == 0 || current->pid == 1)) {
+		/* Kill off a user process with an ECC error */
+		printk(KERN_ERR "MCE: uncorrectable ecc error for pid %d\n",
+		       current->pid);
+		/* XXX something better for ECC error? */
+		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
+		return 1;
+	}
+	return 0;
+}
+
+/*
+ * Handle a machine check.
+ *
+ * Note that on Power 4 and beyond Firmware Non-Maskable Interrupts (fwnmi)
+ * should be present.  If so the handler which called us tells us if the
+ * error was recovered (never true if RI=0).
+ *
+ * On hardware prior to Power 4 these exceptions were asynchronous which
+ * means we can't tell exactly where it occurred and so we can't recover.
+ */
+int pSeries_machine_check_exception(struct pt_regs *regs)
+{
+	struct rtas_error_log err, *errp;
+
+	if (fwnmi_active) {
+		errp = fwnmi_get_errinfo(regs);
+		if (errp)
+			err = *errp;
+		fwnmi_release_errinfo();	/* frees errp */
+		if (errp && recover_mce(regs, err))
+			return 1;
+	}
+
+	return 0;
+}
diff -urN base-2.6/arch/ppc64/kernel/traps.c test/arch/ppc64/kernel/traps.c
--- base-2.6/arch/ppc64/kernel/traps.c	2005-01-05 14:29:58.372460472 +1100
+++ test/arch/ppc64/kernel/traps.c	2005-01-05 15:56:27.861559056 +1100
@@ -39,11 +39,7 @@
 #include <asm/ppcdebug.h>
 #include <asm/rtas.h>
 #include <asm/systemcfg.h>
-
-#ifdef CONFIG_PPC_PSERIES
-/* This is true if we are using the firmware NMI handler (typically LPAR) */
-extern int fwnmi_active;
-#endif
+#include <asm/machdep.h>
 
 #ifdef CONFIG_DEBUGGER
 int (*__debugger)(struct pt_regs *regs);
@@ -149,8 +145,7 @@
 	return 0;
 }
 
-static void
-_exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
+void _exception(int signr, struct pt_regs *regs, int code, unsigned long addr)
 {
 	siginfo_t info;
 
@@ -166,53 +161,11 @@
 	force_sig_info(signr, &info, current);
 }
 
-#ifdef CONFIG_PPC_PSERIES
-/* Get the error information for errors coming through the
- * FWNMI vectors.  The pt_regs' r3 will be updated to reflect
- * the actual r3 if possible, and a ptr to the error log entry
- * will be returned if found.
- */
-static struct rtas_error_log *FWNMI_get_errinfo(struct pt_regs *regs)
-{
-	unsigned long errdata = regs->gpr[3];
-	struct rtas_error_log *errhdr = NULL;
-	unsigned long *savep;
-
-	if ((errdata >= 0x7000 && errdata < 0x7fff0) ||
-	    (errdata >= rtas.base && errdata < rtas.base + rtas.size - 16)) {
-		savep = __va(errdata);
-		regs->gpr[3] = savep[0];	/* restore original r3 */
-		errhdr = (struct rtas_error_log *)(savep + 1);
-	} else {
-		printk("FWNMI: corrupt r3\n");
-	}
-	return errhdr;
-}
-
-/* Call this when done with the data returned by FWNMI_get_errinfo.
- * It will release the saved data area for other CPUs in the
- * partition to receive FWNMI errors.
- */
-static void FWNMI_release_errinfo(void)
-{
-	int ret = rtas_call(rtas_token("ibm,nmi-interlock"), 0, 1, NULL);
-	if (ret != 0)
-		printk("FWNMI: nmi-interlock failed: %d\n", ret);
-}
-#endif
-
-void
-SystemResetException(struct pt_regs *regs)
+void system_reset_exception(struct pt_regs *regs)
 {
-#ifdef CONFIG_PPC_PSERIES
-	if (fwnmi_active) {
-		struct rtas_error_log *errhdr = FWNMI_get_errinfo(regs);
-		if (errhdr) {
-			/* XXX Should look at FWNMI information */
-		}
-		FWNMI_release_errinfo();
-	}
-#endif
+	/* See if any machine dependent calls */
+	if (ppc_md.system_reset_exception) 
+		ppc_md.system_reset_exception(regs);
 
 	die("System Reset", regs, 0);
 
@@ -223,64 +176,16 @@
 	/* What should we do here? We could issue a shutdown or hard reset. */
 }
 
-#ifdef CONFIG_PPC_PSERIES
-/* 
- * See if we can recover from a machine check exception.
- * This is only called on power4 (or above) and only via
- * the Firmware Non-Maskable Interrupts (fwnmi) handler
- * which provides the error analysis for us.
- *
- * Return 1 if corrected (or delivered a signal).
- * Return 0 if there is nothing we can do.
- */
-static int recover_mce(struct pt_regs *regs, struct rtas_error_log err)
+void machine_check_exception(struct pt_regs *regs)
 {
-	if (err.disposition == RTAS_DISP_FULLY_RECOVERED) {
-		/* Platform corrected itself */
-		return 1;
-	} else if ((regs->msr & MSR_RI) &&
-		   user_mode(regs) &&
-		   err.severity == RTAS_SEVERITY_ERROR_SYNC &&
-		   err.disposition == RTAS_DISP_NOT_RECOVERED &&
-		   err.target == RTAS_TARGET_MEMORY &&
-		   err.type == RTAS_TYPE_ECC_UNCORR &&
-		   !(current->pid == 0 || current->pid == 1)) {
-		/* Kill off a user process with an ECC error */
-		printk(KERN_ERR "MCE: uncorrectable ecc error for pid %d\n",
-		       current->pid);
-		/* XXX something better for ECC error? */
-		_exception(SIGBUS, regs, BUS_ADRERR, regs->nip);
-		return 1;
-	}
-	return 0;
-}
-#endif
+	int recover = 0;
+	
+	/* See if any machine dependent calls */
+	if (ppc_md.machine_check_exception)
+		recover = ppc_md.machine_check_exception(regs);
 
-/*
- * Handle a machine check.
- *
- * Note that on Power 4 and beyond Firmware Non-Maskable Interrupts (fwnmi)
- * should be present.  If so the handler which called us tells us if the
- * error was recovered (never true if RI=0).
- *
- * On hardware prior to Power 4 these exceptions were asynchronous which
- * means we can't tell exactly where it occurred and so we can't recover.
- */
-void
-MachineCheckException(struct pt_regs *regs)
-{
-#ifdef CONFIG_PPC_PSERIES
-	struct rtas_error_log err, *errp;
-
-	if (fwnmi_active) {
-		errp = FWNMI_get_errinfo(regs);
-		if (errp)
-			err = *errp;
-		FWNMI_release_errinfo();	/* frees errp */
-		if (errp && recover_mce(regs, err))
-			return;
-	}
-#endif
+	if (recover)
+		return;
 
 	if (debugger_fault_handler(regs))
 		return;
@@ -291,8 +196,7 @@
 		panic("Unrecoverable Machine check");
 }
 
-void
-UnknownException(struct pt_regs *regs)
+void unknown_exception(struct pt_regs *regs)
 {
 	printk("Bad trap at PC: %lx, SR: %lx, vector=%lx\n",
 	       regs->nip, regs->msr, regs->trap);
@@ -300,8 +204,7 @@
 	_exception(SIGTRAP, regs, 0, 0);
 }
 
-void
-InstructionBreakpointException(struct pt_regs *regs)
+void instruction_breakpoint_exception(struct pt_regs *regs)
 {
 	if (notify_die(DIE_IABR_MATCH, "iabr_match", regs, 5,
 					5, SIGTRAP) == NOTIFY_STOP)
@@ -311,8 +214,7 @@
 	_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
 }
 
-void
-SingleStepException(struct pt_regs *regs)
+void single_step_exception(struct pt_regs *regs)
 {
 	regs->msr &= ~MSR_SE;  /* Turn off 'trace' bit */
 
@@ -334,7 +236,7 @@
 static inline void emulate_single_step(struct pt_regs *regs)
 {
 	if (regs->msr & MSR_SE)
-		SingleStepException(regs);
+		single_step_exception(regs);
 }
 
 static void parse_fpe(struct pt_regs *regs)
@@ -478,8 +380,7 @@
 	return 0;
 }
 
-void
-ProgramCheckException(struct pt_regs *regs)
+void program_check_exception(struct pt_regs *regs)
 {
 	if (regs->msr & 0x100000) {
 		/* IEEE FP exception */
@@ -523,14 +424,14 @@
 	}
 }
 
-void KernelFPUnavailableException(struct pt_regs *regs)
+void kernel_fp_unavailable_exception(struct pt_regs *regs)
 {
 	printk(KERN_EMERG "Unrecoverable FP Unavailable Exception "
 			  "%lx at %lx\n", regs->trap, regs->nip);
 	die("Unrecoverable FP Unavailable Exception", regs, SIGABRT);
 }
 
-void AltivecUnavailableException(struct pt_regs *regs)
+void altivec_unavailable_exception(struct pt_regs *regs)
 {
 #ifndef CONFIG_ALTIVEC
 	if (user_mode(regs)) {
@@ -561,14 +462,12 @@
 
 EXPORT_SYMBOL(perf_irq);
 
-void
-PerformanceMonitorException(struct pt_regs *regs)
+void performance_monitor_exception(struct pt_regs *regs)
 {
 	perf_irq(regs);
 }
 
-void
-AlignmentException(struct pt_regs *regs)
+void alignment_exception(struct pt_regs *regs)
 {
 	int fixed;
 
@@ -596,8 +495,7 @@
 }
 
 #ifdef CONFIG_ALTIVEC
-void
-AltivecAssistException(struct pt_regs *regs)
+void altivec_assist_exception(struct pt_regs *regs)
 {
 	int err;
 	siginfo_t info;
diff -urN base-2.6/include/asm-ppc64/machdep.h test/include/asm-ppc64/machdep.h
--- base-2.6/include/asm-ppc64/machdep.h	2004-10-28 06:58:36.000000000 +1000
+++ test/include/asm-ppc64/machdep.h	2005-01-05 15:53:26.013522384 +1100
@@ -110,6 +110,10 @@
 	ssize_t		(*nvram_size)(void);		
 	int		(*nvram_sync)(void);
 
+	/* Exception handlers */
+	void		(*system_reset_exception)(struct pt_regs *regs);
+	int 		(*machine_check_exception)(struct pt_regs *regs);
+
 	/* Motherboard/chipset features. This is a kind of general purpose
 	 * hook used to control some machine specific features (like reset
 	 * lines, chip power control, etc...).

