Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265107AbUGIRRv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265107AbUGIRRv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jul 2004 13:17:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265110AbUGIRRv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jul 2004 13:17:51 -0400
Received: from mtagate1.de.ibm.com ([195.212.29.150]:36745 "EHLO
	mtagate1.de.ibm.com") by vger.kernel.org with ESMTP id S265107AbUGIRRb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jul 2004 13:17:31 -0400
Date: Fri, 9 Jul 2004 19:17:22 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] s390: signals & exceptions.
Message-ID: <20040709171722.GA3546@mschwid3.boeblingen.de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6+20040523i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] s390: signals & exceptions.

From: Martin Schwidefsky <schwidefsky@de.ibm.com>
From: Ulrich Weigand <uweigand@de.ibm.com>

s390 core changes:
 - Add signo between signal frame and the signal return instruction on the
   user stack for backtrace over signal handlers.
 - Add hfp floating point exceptions.
 - Use a single function for region, segment and page translation exceptions.
 - Discard SIGTRAP for single stepped instructions if the trapping instruction
   is repeated (normal memory faults) or if another signal is delivered anyway.

Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>

diffstat:
 arch/s390/kernel/compat_signal.c |    5 ++
 arch/s390/kernel/entry.S         |   38 +++++++-----------
 arch/s390/kernel/entry64.S       |   23 ++++-------
 arch/s390/kernel/signal.c        |    5 ++
 arch/s390/kernel/traps.c         |   79 ++++++++++++++++++++++-----------------
 arch/s390/mm/fault.c             |   40 +++++++++----------
 include/asm-s390/thread_info.h   |    2 
 7 files changed, 101 insertions(+), 91 deletions(-)

diff -urN linux-2.6/arch/s390/kernel/compat_signal.c linux-2.6-s390/arch/s390/kernel/compat_signal.c
--- linux-2.6/arch/s390/kernel/compat_signal.c	Wed Jun 16 07:20:03 2004
+++ linux-2.6-s390/arch/s390/kernel/compat_signal.c	Fri Jul  9 18:58:54 2004
@@ -40,6 +40,7 @@
 	__u8 callee_used_stack[__SIGNAL_FRAMESIZE32];
 	struct sigcontext32 sc;
 	_sigregs32 sregs;
+	int signo;
 	__u8 retcode[S390_SYSCALL_SIZE];
 } sigframe32;
 
@@ -497,6 +498,10 @@
 	   To avoid breaking binary compatibility, they are passed as args. */
 	regs->gprs[4] = current->thread.trap_no;
 	regs->gprs[5] = current->thread.prot_addr;
+
+	/* Place signal number on stack to allow backtrace from handler.  */
+	if (__put_user(regs->gprs[2], (int __user *) &frame->signo))
+		goto give_sigsegv;
 	return;
 
 give_sigsegv:
diff -urN linux-2.6/arch/s390/kernel/entry.S linux-2.6-s390/arch/s390/kernel/entry.S
--- linux-2.6/arch/s390/kernel/entry.S	Wed Jun 16 07:19:01 2004
+++ linux-2.6-s390/arch/s390/kernel/entry.S	Fri Jul  9 18:58:54 2004
@@ -70,7 +70,7 @@
         .macro  CLEANUP_SAVE_ALL_BASE psworg,savearea,sync
 	l	%r1,SP_PSW+4(%r15)
 	cli	1(%r1),0xcf
-	jne	0f
+	bne	BASED(0f)
 	mvc	\savearea(16),SP_R12(%r15)
 0:	st	%r13,SP_R13(%r15)
 	.endm
@@ -140,9 +140,9 @@
 	.macro	CLEANUP_RESTORE_ALL
 	l	%r1,SP_PSW+4(%r15)
 	cli	0(%r1),0x82
-	jne	0f
+	bne	BASED(0f)
 	mvc	SP_PSW(8,%r15),__LC_RETURN_PSW
-	j	1f
+	b	BASED(1f)
 0:	l	%r1,SP_R15(%r15)
 	mvc	SP_PSW(8,%r15),SP_PSW(%r1)
 	mvc	SP_R0(64,%r15),SP_R0(%r1)
@@ -157,9 +157,9 @@
         tm      SP_PSW+1(%r15),0x01      # test problem state bit
 	bnz	BASED(0f)		 # from user -> not critical
 	clc	SP_PSW+4(4,%r15),BASED(.Lcritical_end)
-	jnl	0f
+	bnl	BASED(0f)
 	clc	SP_PSW+4(4,%r15),BASED(.Lcritical_start)
-	jl	0f
+	bl	BASED(0f)
 	l	%r1,BASED(.Lcleanup_critical)
 	basr	%r14,%r1
 0:
@@ -291,6 +291,7 @@
 # _TIF_SIGPENDING is set, call do_signal
 #
 sysc_sigpending:     
+	ni	__TI_flags+3(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
         la      %r2,SP_PTREGS(%r15)    # load pt_regs
         sr      %r3,%r3                # clear *oldset
         l       %r1,BASED(.Ldo_signal)
@@ -311,7 +312,7 @@
 	b	BASED(sysc_do_restart) # restart svc
 
 #
-# _TIF_SINGLE_STEP is set, call do_debugger_trap
+# _TIF_SINGLE_STEP is set, call do_single_step
 #
 sysc_singlestep:
 	ni	__TI_flags+3(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
@@ -319,7 +320,7 @@
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	l	%r1,BASED(.Lhandle_per)	# load adr. of per handler
 	la	%r14,BASED(sysc_return)	# load adr. of system return
-	br	%r1			# branch to do_debugger_trap
+	br	%r1			# branch to do_single_step
 
 __critical_end:
 
@@ -460,8 +461,9 @@
 	SAVE_ALL __LC_PGM_OLD_PSW,__LC_SAVE_AREA,1
         l       %r3,__LC_PGM_ILC         # load program interruption code
 	la	%r8,0x7f
-        l       %r7,BASED(.Ljump_table)
 	nr	%r8,%r3
+pgm_do_call:
+        l       %r7,BASED(.Ljump_table)
         sll     %r8,2
 	GET_THREAD_INFO
         l       %r7,0(%r8,%r7)		 # load address of handler routine
@@ -492,20 +494,12 @@
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(4,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
-	la	%r4,0x7f
+	oi	__TI_flags+3(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
 	l	%r3,__LC_PGM_ILC	 # load program interruption code
-        nr      %r4,%r3                  # clear per-event-bit and ilc
-        be      BASED(pgm_per_only)      # only per or per+check ?
-        l       %r1,BASED(.Ljump_table)
-        sll     %r4,2
-        l       %r1,0(%r4,%r1)		 # load address of handler routine
-        la      %r2,SP_PTREGS(%r15)	 # address of register-save area
-	basr    %r14,%r1		 # branch to interrupt-handler
-pgm_per_only:
-	la      %r2,SP_PTREGS(15)	 # address of register-save area
-        l       %r1,BASED(.Lhandle_per)  # load adr. of per handler
-        la      %r14,BASED(sysc_return)  # load adr. of system return
-        br      %r1			 # branch to do_debugger_trap
+	la	%r8,0x7f
+	nr	%r8,%r3                  # clear per-event-bit and ilc
+	be	BASED(sysc_return)       # only per or per+check ?
+	b	BASED(pgm_do_call)
 
 #
 # it was a single stepped SVC that is causing all the trouble
@@ -745,7 +739,7 @@
 .Ldo_extint:   .long  do_extint
 .Ldo_signal:   .long  do_signal
 .Ldo_softirq:  .long  do_softirq
-.Lhandle_per:  .long  do_debugger_trap
+.Lhandle_per:  .long  do_single_step
 .Ljump_table:  .long  pgm_check_table
 .Lschedule:    .long  schedule
 .Lclone:       .long  sys_clone
diff -urN linux-2.6/arch/s390/kernel/entry64.S linux-2.6-s390/arch/s390/kernel/entry64.S
--- linux-2.6/arch/s390/kernel/entry64.S	Fri Jul  9 18:58:41 2004
+++ linux-2.6-s390/arch/s390/kernel/entry64.S	Fri Jul  9 18:58:54 2004
@@ -282,6 +282,7 @@
 # _TIF_SIGPENDING is set, call do_signal
 #
 sysc_sigpending:     
+	ni	__TI_flags+7(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
         la      %r2,SP_PTREGS(%r15) # load pt_regs
         sgr     %r3,%r3           # clear *oldset
 	brasl	%r14,do_signal    # call do_signal
@@ -301,7 +302,7 @@
 	j	sysc_do_restart        # restart svc
 
 #
-# _TIF_SINGLE_STEP is set, call do_debugger_trap
+# _TIF_SINGLE_STEP is set, call do_single_step
 #
 sysc_singlestep:
 	ni	__TI_flags+7(%r9),255-_TIF_SINGLE_STEP # clear TIF_SINGLE_STEP
@@ -309,7 +310,7 @@
 	sth	%r0,SP_TRAP(%r15)	# set trap indication to pgm check
 	la	%r2,SP_PTREGS(%r15)	# address of register-save area
 	larl	%r14,sysc_return	# load adr. of system return
-	jg	do_debugger_trap	# branch to do_debugger_trap
+	jg	do_single_step		# branch to do_sigtrap
 
 
 __critical_end:
@@ -497,6 +498,7 @@
 	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
 	lghi	%r8,0x7f
 	ngr	%r8,%r3
+pgm_do_call:
         sll     %r8,3
 	GET_THREAD_INFO
         larl    %r1,pgm_check_table
@@ -527,19 +529,12 @@
 	mvc	__THREAD_per+__PER_atmid(2,%r1),__LC_PER_ATMID
 	mvc	__THREAD_per+__PER_address(8,%r1),__LC_PER_ADDRESS
 	mvc	__THREAD_per+__PER_access_id(1,%r1),__LC_PER_ACCESS_ID
-	lghi    %r4,0x7f
+	oi	__TI_flags+7(%r9),_TIF_SINGLE_STEP # set TIF_SINGLE_STEP
 	lgf     %r3,__LC_PGM_ILC	 # load program interruption code
-        nr      %r4,%r3			 # clear per-event-bit and ilc
-        je      pgm_per_only		 # only per of per+check ?
-        sll     %r4,3
-        larl    %r1,pgm_check_table
-        lg      %r1,0(%r4,%r1)		 # load address of handler routine
-        la      %r2,SP_PTREGS(%r15)	 # address of register-save area
-        basr    %r14,%r1		 # branch to interrupt-handler
-pgm_per_only:
-        la      %r2,SP_PTREGS(15)	 # address of register-save area
-        larl    %r14,sysc_return	 # load adr. of system return
-        jg      do_debugger_trap
+	lghi	%r8,0x7f
+	ngr	%r8,%r3			 # clear per-event-bit and ilc
+	je	sysc_return
+	j	pgm_do_call
 
 #
 # it was a single stepped SVC that is causing all the trouble
diff -urN linux-2.6/arch/s390/kernel/signal.c linux-2.6-s390/arch/s390/kernel/signal.c
--- linux-2.6/arch/s390/kernel/signal.c	Wed Jun 16 07:19:44 2004
+++ linux-2.6-s390/arch/s390/kernel/signal.c	Fri Jul  9 18:58:54 2004
@@ -39,6 +39,7 @@
 	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
 	struct sigcontext sc;
 	_sigregs sregs;
+	int signo;
 	__u8 retcode[S390_SYSCALL_SIZE];
 } sigframe;
 
@@ -350,6 +351,10 @@
 	   To avoid breaking binary compatibility, they are passed as args. */
 	regs->gprs[4] = current->thread.trap_no;
 	regs->gprs[5] = current->thread.prot_addr;
+
+	/* Place signal number on stack to allow backtrace from handler.  */
+	if (__put_user(regs->gprs[2], (int __user *) &frame->signo))
+		goto give_sigsegv;
 	return;
 
 give_sigsegv:
diff -urN linux-2.6/arch/s390/kernel/traps.c linux-2.6-s390/arch/s390/kernel/traps.c
--- linux-2.6/arch/s390/kernel/traps.c	Fri Jul  9 18:58:41 2004
+++ linux-2.6-s390/arch/s390/kernel/traps.c	Fri Jul  9 18:58:54 2004
@@ -54,9 +54,7 @@
 #endif
 
 extern pgm_check_handler_t do_protection_exception;
-extern pgm_check_handler_t do_segment_exception;
-extern pgm_check_handler_t do_region_exception;
-extern pgm_check_handler_t do_page_exception;
+extern pgm_check_handler_t do_dat_exception;
 extern pgm_check_handler_t do_pseudo_page_fault;
 #ifdef CONFIG_PFAULT
 extern int pfault_init(void);
@@ -300,14 +298,10 @@
 	return (void *)((regs->psw.addr-S390_lowcore.pgm_ilc) & PSW_ADDR_INSN);
 }
 
-int do_debugger_trap(struct pt_regs *regs)
+void do_single_step(struct pt_regs *regs)
 {
-	if ((regs->psw.mask & PSW_MASK_PSTATE) &&
-	    (current->ptrace & PT_PTRACED)) {
-		force_sig(SIGTRAP,current);
-		return 0;
-	}
-	return 1;
+	if ((current->ptrace & PT_PTRACED) != 0)
+		force_sig(SIGTRAP, current);
 }
 
 #define DO_ERROR(signr, str, name) \
@@ -329,12 +323,24 @@
 
 DO_ERROR(SIGSEGV, "Unknown program exception", default_trap_handler)
 
-DO_ERROR_INFO(SIGBUS, "addressing exception", addressing_exception,
-	      BUS_ADRERR, get_check_address(regs))
+DO_ERROR_INFO(SIGILL, "addressing exception", addressing_exception,
+	      ILL_ILLADR, get_check_address(regs))
 DO_ERROR_INFO(SIGILL,  "execute exception", execute_exception,
 	      ILL_ILLOPN, get_check_address(regs))
 DO_ERROR_INFO(SIGFPE,  "fixpoint divide exception", divide_exception,
 	      FPE_INTDIV, get_check_address(regs))
+DO_ERROR_INFO(SIGFPE,  "fixpoint overflow exception", overflow_exception,
+	      FPE_INTOVF, get_check_address(regs))
+DO_ERROR_INFO(SIGFPE,  "HFP overflow exception", hfp_overflow_exception,
+	      FPE_FLTOVF, get_check_address(regs))
+DO_ERROR_INFO(SIGFPE,  "HFP underflow exception", hfp_underflow_exception,
+	      FPE_FLTUND, get_check_address(regs))
+DO_ERROR_INFO(SIGFPE,  "HFP significance exception", hfp_significance_exception,
+	      FPE_FLTRES, get_check_address(regs))
+DO_ERROR_INFO(SIGFPE,  "HFP divide exception", hfp_divide_exception,
+	      FPE_FLTDIV, get_check_address(regs))
+DO_ERROR_INFO(SIGFPE,  "HFP square root exception", hfp_sqrt_exception,
+	      FPE_FLTINV, get_check_address(regs))
 DO_ERROR_INFO(SIGILL,  "operand exception", operand_exception,
 	      ILL_ILLOPN, get_check_address(regs))
 DO_ERROR_INFO(SIGILL,  "privileged operation", privileged_op,
@@ -388,19 +394,15 @@
 	if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
 
-	if (regs->psw.mask & PSW_MASK_PSTATE)
-		get_user(*((__u16 *) opcode), (__u16 __user *)location);
-	else
-		*((__u16 *)opcode)=*((__u16 *)location);
-	if (*((__u16 *)opcode)==S390_BREAKPOINT_U16)
-        {
-		if(do_debugger_trap(regs))
-			signal = SIGILL;
-	}
+	if (regs->psw.mask & PSW_MASK_PSTATE) {
+		get_user(*((__u16 *) opcode), (__u16 __user *) location);
+		if (*((__u16 *) opcode) == S390_BREAKPOINT_U16) {
+			if (current->ptrace & PT_PTRACED)
+				force_sig(SIGTRAP, current);
+			else
+				signal = SIGILL;
 #ifdef CONFIG_MATHEMU
-        else if (regs->psw.mask & PSW_MASK_PSTATE)
-	{
-		if (opcode[0] == 0xb3) {
+		} else if (opcode[0] == 0xb3) {
 			get_user(*((__u16 *) (opcode+2)), location+1);
 			signal = math_emu_b3(opcode, regs);
                 } else if (opcode[0] == 0xed) {
@@ -416,12 +418,12 @@
 		} else if (*((__u16 *) opcode) == 0xb29d) {
 			get_user(*((__u16 *) (opcode+2)), location+1);
 			signal = math_emu_lfpc(opcode, regs);
+#endif
 		} else
 			signal = SIGILL;
-        }
-#endif 
-	else
+	} else
 		signal = SIGILL;
+
         if (signal == SIGFPE)
 		do_fp_trap(regs, location,
                            current->thread.fp_regs.fpc, interruption_code);
@@ -445,9 +447,9 @@
 	 * We got all needed information from the lowcore and can
 	 * now safely switch on interrupts.
 	 */
-	if (regs->psw.mask & PSW_MASK_PSTATE)
+        if (regs->psw.mask & PSW_MASK_PSTATE)
 		local_irq_enable();
-		
+
         if (regs->psw.mask & PSW_MASK_PSTATE) {
 		get_user(*((__u16 *) opcode), location);
 		switch (opcode[0]) {
@@ -479,6 +481,7 @@
                 }
         } else
 		signal = SIGILL;
+
         if (signal == SIGFPE)
 		do_fp_trap(regs, location,
                            current->thread.fp_regs.fpc, interruption_code);
@@ -605,19 +608,29 @@
         pgm_check_table[5] = &addressing_exception;
         pgm_check_table[6] = &specification_exception;
         pgm_check_table[7] = &data_exception;
+        pgm_check_table[8] = &overflow_exception;
         pgm_check_table[9] = &divide_exception;
-        pgm_check_table[0x10] = &do_segment_exception;
-        pgm_check_table[0x11] = &do_page_exception;
+        pgm_check_table[0x0A] = &overflow_exception;
+        pgm_check_table[0x0B] = &divide_exception;
+        pgm_check_table[0x0C] = &hfp_overflow_exception;
+        pgm_check_table[0x0D] = &hfp_underflow_exception;
+        pgm_check_table[0x0E] = &hfp_significance_exception;
+        pgm_check_table[0x0F] = &hfp_divide_exception;
+        pgm_check_table[0x10] = &do_dat_exception;
+        pgm_check_table[0x11] = &do_dat_exception;
         pgm_check_table[0x12] = &translation_exception;
         pgm_check_table[0x13] = &special_op_exception;
 #ifndef CONFIG_ARCH_S390X
  	pgm_check_table[0x14] = &do_pseudo_page_fault;
 #else /* CONFIG_ARCH_S390X */
-        pgm_check_table[0x38] = &addressing_exception;
-        pgm_check_table[0x3B] = &do_region_exception;
+        pgm_check_table[0x38] = &do_dat_exception;
+	pgm_check_table[0x39] = &do_dat_exception;
+	pgm_check_table[0x3A] = &do_dat_exception;
+        pgm_check_table[0x3B] = &do_dat_exception;
 #endif /* CONFIG_ARCH_S390X */
         pgm_check_table[0x15] = &operand_exception;
         pgm_check_table[0x1C] = &privileged_op;
+        pgm_check_table[0x1D] = &hfp_sqrt_exception;
 	pgm_check_table[0x40] = &do_monitor_call;
 
 	if (MACHINE_IS_VM) {
diff -urN linux-2.6/arch/s390/mm/fault.c linux-2.6-s390/arch/s390/mm/fault.c
--- linux-2.6/arch/s390/mm/fault.c	Wed Jun 16 07:19:44 2004
+++ linux-2.6-s390/arch/s390/mm/fault.c	Fri Jul  9 18:58:54 2004
@@ -159,7 +159,8 @@
  *   11       Page translation     ->  Not present       (nullification)
  *   3b       Region third trans.  ->  Not present       (nullification)
  */
-extern inline void do_exception(struct pt_regs *regs, unsigned long error_code)
+extern inline void
+do_exception(struct pt_regs *regs, unsigned long error_code, int is_protection)
 {
         struct task_struct *tsk;
         struct mm_struct *mm;
@@ -177,7 +178,7 @@
 	 * as a special case because the translation exception code 
 	 * field is not guaranteed to contain valid data in this case.
 	 */
-	if (error_code == 4 && !(S390_lowcore.trans_exc_code & 4)) {
+	if (is_protection && !(S390_lowcore.trans_exc_code & 4)) {
 
 		/* Low-address protection hit in kernel mode means 
 		   NULL pointer write access in kernel mode.  */
@@ -232,7 +233,7 @@
  */
 good_area:
 	si_code = SEGV_ACCERR;
-	if (error_code != 4) {
+	if (!is_protection) {
 		/* page not present, check vm flags */
 		if (!(vma->vm_flags & (VM_READ | VM_EXEC | VM_WRITE)))
 			goto bad_area;
@@ -247,7 +248,7 @@
 	 * make sure we exit gracefully rather than endlessly redo
 	 * the fault.
 	 */
-	switch (handle_mm_fault(mm, vma, address, error_code == 4)) {
+	switch (handle_mm_fault(mm, vma, address, is_protection)) {
 	case VM_FAULT_MINOR:
 		tsk->min_flt++;
 		break;
@@ -263,6 +264,11 @@
 	}
 
         up_read(&mm->mmap_sem);
+	/*
+	 * The instruction that caused the program check will
+	 * be repeated. Don't signal single step via SIGTRAP.
+	 */
+	clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
         return;
 
 /*
@@ -337,28 +343,15 @@
 void do_protection_exception(struct pt_regs *regs, unsigned long error_code)
 {
 	regs->psw.addr -= (error_code >> 16);
-	do_exception(regs, 4);
-}
-
-void do_segment_exception(struct pt_regs *regs, unsigned long error_code)
-{
-	do_exception(regs, 0x10);
+	do_exception(regs, 4, 1);
 }
 
-void do_page_exception(struct pt_regs *regs, unsigned long error_code)
-{
-	do_exception(regs, 0x11);
-}
-
-#ifdef CONFIG_ARCH_S390X
-
-void
-do_region_exception(struct pt_regs *regs, unsigned long error_code)
+void do_dat_exception(struct pt_regs *regs, unsigned long error_code)
 {
-	do_exception(regs, 0x3b);
+	do_exception(regs, error_code & 0xff, 0);
 }
 
-#else /* CONFIG_ARCH_S390X */
+#ifndef CONFIG_ARCH_S390X
 
 typedef struct _pseudo_wait_t {
        struct _pseudo_wait_t *next;
@@ -456,6 +449,11 @@
                 wait_struct.next = pseudo_lock_queue;
                 pseudo_lock_queue = &wait_struct;
                 spin_unlock(&pseudo_wait_spinlock);
+		/*
+		 * The instruction that caused the program check will
+		 * be repeated. Don't signal single step via SIGTRAP.
+		 */
+		clear_tsk_thread_flag(current, TIF_SINGLE_STEP);
                 /* go to sleep */
                 wait_event(wait_struct.queue, wait_struct.resolved);
         }
diff -urN linux-2.6/include/asm-s390/thread_info.h linux-2.6-s390/include/asm-s390/thread_info.h
--- linux-2.6/include/asm-s390/thread_info.h	Wed Jun 16 07:19:42 2004
+++ linux-2.6-s390/include/asm-s390/thread_info.h	Fri Jul  9 18:58:54 2004
@@ -85,7 +85,7 @@
 #define TIF_NEED_RESCHED	3	/* rescheduling necessary */
 #define TIF_RESTART_SVC		4	/* restart svc with new svc number */
 #define TIF_SYSCALL_AUDIT	5	/* syscall auditing active */
-#define TIF_SINGLE_STEP		6	/* single stepped svc */
+#define TIF_SINGLE_STEP		6	/* deliver sigtrap on return to user */
 #define TIF_USEDFPU		16	/* FPU was used by this task this quantum (SMP) */
 #define TIF_POLLING_NRFLAG	17	/* true if poll_idle() is polling 
 					   TIF_NEED_RESCHED */
