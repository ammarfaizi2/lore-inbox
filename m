Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267727AbTBRGJt>; Tue, 18 Feb 2003 01:09:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267717AbTBRGIT>; Tue, 18 Feb 2003 01:08:19 -0500
Received: from TYO202.gate.nec.co.jp ([202.32.8.202]:51438 "EHLO
	TYO202.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267680AbTBRGFX>; Tue, 18 Feb 2003 01:05:23 -0500
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH]  v850 kernel entry fixes and cleanup
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030218061508.EE08D37C7@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue, 18 Feb 2003 15:15:08 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1) Preserve the v850 system-call-number register when handling a signal;
   otherwise system calls will not be correctly restarted afterwards
2) Correctly handle illegal insn exceptions, which need a special
   instruction to return (not reti), and save PC/PSW to a different place
2) Remove some unnecessary register saving in the trap handler
3) Consolidate various places that use the register save/restore macros
4) Eliminate some unused compile-time configuration stuff
5) A bit of whitespace and other syntactic cleanup

diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/kernel/bug.c linux-2.5.62-uc0/arch/v850/kernel/bug.c
--- linux-2.5.62-uc0.orig/arch/v850/kernel/bug.c	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/kernel/bug.c	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/bug.c -- Bug reporting functions
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -40,12 +40,6 @@
 	return -ENOSYS;
 }
 
-int debug_trap (struct pt_regs *regs)
-{
-	printk (KERN_CRIT "debug trap at 0x%08lx!\n", regs->pc);
-	return -ENOSYS;
-}
-
 #ifdef CONFIG_RESET_GUARD
 void unexpected_reset (unsigned long ret_addr, unsigned long kmode,
 		       struct task_struct *task, unsigned long sp)
diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/kernel/entry.S linux-2.5.62-uc0/arch/v850/kernel/entry.S
--- linux-2.5.62-uc0.orig/arch/v850/kernel/entry.S	2002-12-24 15:01:07.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/kernel/entry.S	2003-02-18 11:41:09.000000000 +0900
@@ -2,8 +2,8 @@
  * arch/v850/kernel/entry.S -- Low-level system-call handling, trap handlers,
  *	and context-switching
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -38,27 +38,27 @@
 	sst.w	r6, PTO+PT_GPR(6)[ep];					      \
 	sst.w	r7, PTO+PT_GPR(7)[ep];					      \
 	sst.w	r8, PTO+PT_GPR(8)[ep];					      \
-	sst.w	r9, PTO+PT_GPR(9)[ep];
+	sst.w	r9, PTO+PT_GPR(9)[ep]
 /* Restore argument registers from the struct pt_regs pointed to by EP.  */
 #define RESTORE_ARG_REGS						      \
 	sld.w	PTO+PT_GPR(6)[ep], r6;					      \
 	sld.w	PTO+PT_GPR(7)[ep], r7;					      \
 	sld.w	PTO+PT_GPR(8)[ep], r8;					      \
-	sld.w	PTO+PT_GPR(9)[ep], r9;
+	sld.w	PTO+PT_GPR(9)[ep], r9
 
 /* Save value return registers to the struct pt_regs pointed to by EP.  */
 #define SAVE_RVAL_REGS							      \
 	sst.w	r10, PTO+PT_GPR(10)[ep];				      \
-	sst.w	r11, PTO+PT_GPR(11)[ep];
+	sst.w	r11, PTO+PT_GPR(11)[ep]
 /* Restore value return registers from the struct pt_regs pointed to by EP.  */
 #define RESTORE_RVAL_REGS						      \
 	sld.w	PTO+PT_GPR(10)[ep], r10;				      \
-	sld.w	PTO+PT_GPR(11)[ep], r11;
+	sld.w	PTO+PT_GPR(11)[ep], r11
 
 
 #define SAVE_CALL_CLOBBERED_REGS_BEFORE_ARGS				      \
 	sst.w	r1, PTO+PT_GPR(1)[ep];					      \
-	sst.w	r5, PTO+PT_GPR(5)[ep];
+	sst.w	r5, PTO+PT_GPR(5)[ep]
 #define SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL				      \
 	sst.w	r12, PTO+PT_GPR(12)[ep];				      \
 	sst.w	r13, PTO+PT_GPR(13)[ep];				      \
@@ -67,10 +67,10 @@
 	sst.w	r16, PTO+PT_GPR(16)[ep];				      \
 	sst.w	r17, PTO+PT_GPR(17)[ep];				      \
 	sst.w	r18, PTO+PT_GPR(18)[ep];				      \
-	sst.w	r19, PTO+PT_GPR(19)[ep];
+	sst.w	r19, PTO+PT_GPR(19)[ep]
 #define RESTORE_CALL_CLOBBERED_REGS_BEFORE_ARGS				      \
 	sld.w	PTO+PT_GPR(1)[ep], r1;					      \
-	sld.w	PTO+PT_GPR(5)[ep], r5;
+	sld.w	PTO+PT_GPR(5)[ep], r5
 #define RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL				      \
 	sld.w	PTO+PT_GPR(12)[ep], r12;				      \
 	sld.w	PTO+PT_GPR(13)[ep], r13;				      \
@@ -79,40 +79,34 @@
 	sld.w	PTO+PT_GPR(16)[ep], r16;				      \
 	sld.w	PTO+PT_GPR(17)[ep], r17;				      \
 	sld.w	PTO+PT_GPR(18)[ep], r18;				      \
-	sld.w	PTO+PT_GPR(19)[ep], r19;
+	sld.w	PTO+PT_GPR(19)[ep], r19
 
 /* Save `call clobbered' registers to the struct pt_regs pointed to by EP.  */
 #define SAVE_CALL_CLOBBERED_REGS					      \
 	SAVE_CALL_CLOBBERED_REGS_BEFORE_ARGS;				      \
 	SAVE_ARG_REGS;							      \
 	SAVE_RVAL_REGS;							      \
-	SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL;
+	SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL
 /* Restore `call clobbered' registers from the struct pt_regs pointed to
    by EP.  */
 #define RESTORE_CALL_CLOBBERED_REGS					      \
 	RESTORE_CALL_CLOBBERED_REGS_BEFORE_ARGS;			      \
 	RESTORE_ARG_REGS;						      \
 	RESTORE_RVAL_REGS;						      \
-	RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL;
+	RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL
 
 /* Save `call clobbered' registers except for the return-value registers
    to the struct pt_regs pointed to by EP.  */
 #define SAVE_CALL_CLOBBERED_REGS_NO_RVAL				      \
 	SAVE_CALL_CLOBBERED_REGS_BEFORE_ARGS;				      \
 	SAVE_ARG_REGS;							      \
-	SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL;
+	SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL
 /* Restore `call clobbered' registers except for the return-value registers
    from the struct pt_regs pointed to by EP.  */
 #define RESTORE_CALL_CLOBBERED_REGS_NO_RVAL				      \
 	RESTORE_CALL_CLOBBERED_REGS_BEFORE_ARGS;			      \
 	RESTORE_ARG_REGS;						      \
-	RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL;
-
-/* Zero `call clobbered' registers except for the return-value registers.  */
-#define ZERO_CALL_CLOBBERED_REGS_NO_RVAL				      \
-	mov	r0, r1;   mov	r0, r5;					      \
-	mov	r0, r12;  mov	r0, r13;  mov	r0, r14;  mov	r0, r15;      \
-	mov	r0, r16;  mov	r0, r17;  mov	r0, r18;  mov	r0, r19;
+	RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL
 
 /* Save `call saved' registers to the struct pt_regs pointed to by EP.  */
 #define SAVE_CALL_SAVED_REGS						      \
@@ -126,7 +120,7 @@
 	sst.w	r26, PTO+PT_GPR(26)[ep];				      \
 	sst.w	r27, PTO+PT_GPR(27)[ep];				      \
 	sst.w	r28, PTO+PT_GPR(28)[ep];				      \
-	sst.w	r29, PTO+PT_GPR(29)[ep];
+	sst.w	r29, PTO+PT_GPR(29)[ep]
 /* Restore `call saved' registers from the struct pt_regs pointed to by EP.  */
 #define RESTORE_CALL_SAVED_REGS						      \
 	sld.w	PTO+PT_GPR(2)[ep], r2;					      \
@@ -139,68 +133,53 @@
 	sld.w	PTO+PT_GPR(26)[ep], r26;				      \
 	sld.w	PTO+PT_GPR(27)[ep], r27;				      \
 	sld.w	PTO+PT_GPR(28)[ep], r28;				      \
-	sld.w	PTO+PT_GPR(29)[ep], r29;
+	sld.w	PTO+PT_GPR(29)[ep], r29
+
 
+/* Save the PC stored in the special register SAVEREG to the struct pt_regs
+   pointed to by EP.  r19 is clobbered.  */
+#define SAVE_PC(savereg)						      \
+	stsr	SR_ ## savereg, r19;					      \
+	sst.w	r19, PTO+PT_PC[ep]
+/* Restore the PC from the struct pt_regs pointed to by EP, to the special
+   register SAVEREG.  LP is clobbered (it is used as a scratch register
+   because the POP_STATE macro restores it, and this macro is usually used
+   inside POP_STATE).  */
+#define RESTORE_PC(savereg)						      \
+	sld.w	PTO+PT_PC[ep], lp;					      \
+	ldsr	lp, SR_ ## savereg
+/* Save the PSW register stored in the special register SAVREG to the
+   struct pt_regs pointed to by EP r19 is clobbered.  */
+#define SAVE_PSW(savereg)						      \
+	stsr	SR_ ## savereg, r19;					      \
+	sst.w	r19, PTO+PT_PSW[ep]
+/* Restore the PSW register from the struct pt_regs pointed to by EP, to
+   the special register SAVEREG.  LP is clobbered (it is used as a scratch
+   register because the POP_STATE macro restores it, and this macro is
+   usually used inside POP_STATE).  */
+#define RESTORE_PSW(savereg)						      \
+	sld.w	PTO+PT_PSW[ep], lp;					      \
+	ldsr	lp, SR_ ## savereg
 
-/* Save system registers to the struct pt_regs pointed to by REG.  
+/* Save CTPC/CTPSW/CTBP registers to the struct pt_regs pointed to by REG.  
    r19 is clobbered.  */
-#define SAVE_SYS_REGS							      \
-	stsr	SR_EIPC, r19;	/* user's PC, before interrupt */	      \
-	sst.w	r19, PTO+PT_PC[ep];					      \
-	stsr	SR_EIPSW, r19;	/* & PSW (XXX save this?) */		      \
-	sst.w	r19, PTO+PT_PSW[ep];					      \
-	stsr	SR_CTPC, r19;	/* (XXX maybe not used in kernel?) */	      \
+#define SAVE_CT_REGS							      \
+	stsr	SR_CTPC, r19;						      \
 	sst.w	r19, PTO+PT_CTPC[ep];					      \
-	stsr	SR_CTPSW, r19;	/* " */					      \
+	stsr	SR_CTPSW, r19;						      \
 	sst.w	r19, PTO+PT_CTPSW[ep];					      \
-	stsr	SR_CTBP, r19;	/* " */					      \
-	sst.w	r19, PTO+PT_CTBP[ep];
-/* Restore system registers from the struct pt_regs pointed to by EP.  
+	stsr	SR_CTBP, r19;						      \
+	sst.w	r19, PTO+PT_CTBP[ep]
+/* Restore CTPC/CTPSW/CTBP registers from the struct pt_regs pointed to by EP.
    LP is clobbered (it is used as a scratch register because the POP_STATE
    macro restores it, and this macro is usually used inside POP_STATE).  */
-#define RESTORE_SYS_REGS						      \
-	sld.w	PTO+PT_PC[ep], lp;					      \
-	ldsr	lp, SR_EIPC;	/* user's PC, before interrupt */	      \
-	sld.w	PTO+PT_PSW[ep], lp;					      \
-	ldsr	lp, SR_EIPSW;	/* & PSW (XXX save this?) */		      \
+#define RESTORE_CT_REGS							      \
 	sld.w	PTO+PT_CTPC[ep], lp;					      \
-	ldsr	lp, SR_CTPC;	/* (XXX maybe not used in kernel?) */	      \
+	ldsr	lp, SR_CTPC;						      \
 	sld.w	PTO+PT_CTPSW[ep], lp;					      \
-	ldsr	lp, SR_CTPSW;	/* " */					      \
+	ldsr	lp, SR_CTPSW;						      \
 	sld.w	PTO+PT_CTBP[ep], lp;					      \
-	ldsr	lp, SR_CTBP;	/* " */
-
-
-/* Save system registers to the struct pt_regs pointed to by REG.  This is a
-   NMI-specific version, because NMIs save the PC/PSW in a different place
-   than other interrupt requests.  r19 is clobbered.  */
-#define SAVE_SYS_REGS_FOR_NMI						      \
-	stsr	SR_FEPC, r19;	/* user's PC, before NMI */		      \
-	sst.w	r19, PTO+PT_PC[ep];					      \
-	stsr	SR_FEPSW, r19;	/* & PSW (XXX save this?) */		      \
-	sst.w	r19, PTO+PT_PSW[ep];					      \
-	stsr	SR_CTPC, r19;	/* (XXX maybe not used in kernel?) */	      \
-	sst.w	r19, PTO+PT_CTPC[ep];					      \
-	stsr	SR_CTPSW, r19;	/* " */					      \
-	sst.w	r19, PTO+PT_CTPSW[ep];					      \
-	stsr	SR_CTBP, r19;	/* " */					      \
-	sst.w	r19, PTO+PT_CTBP[ep];
-/* Restore system registers from the struct pt_regs pointed to by EP.  This is
-   a NMI-specific version, because NMIs save the PC/PSW in a different place
-   than other interrupt requests.  LP is clobbered (it is used as a scratch
-   register because the POP_STATE macro restores it, and this macro is usually
-   used inside POP_STATE).  */
-#define RESTORE_SYS_REGS_FOR_NMI					      \
-	ldsr	lp, SR_FEPC;	/* user's PC, before NMI */		      \
-	sld.w	PTO+PT_PC[ep], lp;					      \
-	ldsr	lp, SR_FEPSW;	/* & PSW (XXX save this?) */		      \
-	sld.w	PTO+PT_PSW[ep], lp;					      \
-	ldsr	lp, SR_CTPC;	/* (XXX maybe not used in kernel?) */	      \
-	sld.w	PTO+PT_CTPC[ep], lp;					      \
-	ldsr	lp, SR_CTPSW;	/* " */					      \
-	sld.w	PTO+PT_CTPSW[ep], lp;					      \
-	ldsr	lp, SR_CTBP;	/* " */					      \
-	sld.w	PTO+PT_CTBP[ep], lp;
+	ldsr	lp, SR_CTBP
 
 
 /* Push register state, except for the stack pointer, on the stack in the form
@@ -213,7 +192,7 @@
 	mov	sp, ep;							      \
 	sst.w	gp, PTO+PT_GPR(GPR_GP)[ep];				      \
 	sst.w	lp, PTO+PT_GPR(GPR_LP)[ep];				      \
-	type ## _STATE_SAVER;
+	type ## _STATE_SAVER
 /* Pop a register state, except for the stack pointer, from the struct pt_regs
    on the stack.  */
 #define POP_STATE(type)							      \
@@ -222,161 +201,175 @@
 	sld.w	PTO+PT_GPR(GPR_GP)[ep], gp;				      \
 	sld.w	PTO+PT_GPR(GPR_LP)[ep], lp;				      \
 	sld.w	PTO+PT_GPR(GPR_EP)[ep], ep;				      \
-	addi	STATE_SAVE_SIZE, sp, sp; /* Clean up our stack space.  */
+	addi	STATE_SAVE_SIZE, sp, sp /* Clean up our stack space.  */
 
 
-/* Switch to the kernel stack if necessary, and push register state on
-   the stack in the form of a struct pt_regs.  Also load the current
-   task pointer if switching from user mode.  The stack-pointer (r3)
-   should have already been saved to the memory location SP_SAVE_LOC
-   (the reason for this is that the interrupt vectors may be beyond a
-   22-bit signed offset jump from the actual interrupt handler, and this
-   allows them to save the stack-pointer and use that register to do an
-   indirect jump).  This macro makes sure that `special' registers,
-   system registers, and the stack pointer are saved; TYPE identifies
-   the set of extra registers to be saved as well.  SYSCALL_NUM is the
-   register in which the system-call number this state is for is stored
-   (r0 if this isn't a system call).  Interrupts should already be
-   disabled when calling this.  */
+/* Switch to the kernel stack if necessary, and push register state on the
+   stack in the form of a struct pt_regs.  Also load the current task
+   pointer if switching from user mode.  The stack-pointer (r3) should have
+   already been saved to the memory location SP_SAVE_LOC (the reason for
+   this is that the interrupt vectors may be beyond a 22-bit signed offset
+   jump from the actual interrupt handler, and this allows them to save the
+   stack-pointer and use that register to do an indirect jump).  This macro
+   makes sure that `special' registers, system registers, and the stack
+   pointer are saved; TYPE identifies the set of extra registers to be
+   saved as well.  SYSCALL_NUM is the register in which the system-call
+   number this state is for is stored (r0 if this isn't a system call).
+   Interrupts should already be disabled when calling this.  */
 #define SAVE_STATE(type, syscall_num, sp_save_loc)			      \
-        tst1	0, KM;			/* See if already in kernel mode.  */ \
+	tst1	0, KM;			/* See if already in kernel mode.  */ \
 	bz	1f;							      \
-        /* Kernel-mode state save.  */					      \
-	ld.w	sp_save_loc, sp;	/* Reload kernel stack-pointer.  */   \
-	st.w	sp, (PT_GPR(GPR_SP)-PT_SIZE)[sp]; /* Save original SP. */     \
-        PUSH_STATE(type);						      \
-	mov	1, r19;			/* Was in kernel-mode.  */	      \
-        sst.w	r19, PTO+PT_KERNEL_MODE[ep]; /* [ep is set by PUSH_STATE] */  \
-        br	2f;							      \
-1:      /* User-mode state save.  */					      \
-        ld.w    KSP, sp;		/* Switch to kernel stack.  */	      \
-        PUSH_STATE(type);						      \
-        sst.w	r0, PTO+PT_KERNEL_MODE[ep]; /* Was in user-mode.  */	      \
-        ld.w    sp_save_loc, r19;				              \
-	sst.w	r19, PTO+PT_GPR(GPR_SP)[ep]; /* Store user SP.  */	      \
-	mov	1, r19;							      \
-	st.b	r19, KM;		/* Now we're in kernel-mode.  */      \
+	ld.w	sp_save_loc, sp;	/* ... yes, use saved SP.  */	      \
+	br	2f;							      \
+1:	ld.w	KSP, sp;		/* ... no, switch to kernel stack. */ \
+2:	PUSH_STATE(type);						      \
+	ld.b	KM, r19;		/* Remember old kernel-mode.  */      \
+	sst.w	r19, PTO+PT_KERNEL_MODE[ep];				      \
+	ld.w	sp_save_loc, r19;	/* Remember old SP.  */		      \
+	sst.w	r19, PTO+PT_GPR(GPR_SP)[ep];				      \
+	mov	1, r19;			/* Now definitely in kernel-mode. */  \
+	st.b	r19, KM;						      \
 	GET_CURRENT_TASK(CURRENT_TASK);	/* Fetch the current task pointer. */ \
-2:      /* Save away the syscall number.  */				      \
-        sst.w	syscall_num, PTO+PT_SYSCALL[ep]
+	/* Save away the syscall number.  */				      \
+	sst.w	syscall_num, PTO+PT_SYSCALL[ep]
 
 
 /* Save register state not normally saved by PUSH_STATE for TYPE.  */
 #define SAVE_EXTRA_STATE(type)						      \
         mov	sp, ep;							      \
-	type ## _EXTRA_STATE_SAVER;
+	type ## _EXTRA_STATE_SAVER
 /* Restore register state not normally restored by POP_STATE for TYPE.  */
 #define RESTORE_EXTRA_STATE(type)					      \
         mov	sp, ep;							      \
-	type ## _EXTRA_STATE_RESTORER;
+	type ## _EXTRA_STATE_RESTORER
 
 /* Save any call-clobbered registers not normally saved by PUSH_STATE
    for TYPE.  */
 #define SAVE_EXTRA_STATE_FOR_FUNCALL(type)				      \
         mov	sp, ep;							      \
-	type ## _FUNCALL_EXTRA_STATE_SAVER;
+	type ## _FUNCALL_EXTRA_STATE_SAVER
 /* Restore any call-clobbered registers not normally restored by POP_STATE for
    TYPE.  */
 #define RESTORE_EXTRA_STATE_FOR_FUNCALL(type)				      \
         mov	sp, ep;							      \
-	type ## _FUNCALL_EXTRA_STATE_RESTORER;
+	type ## _FUNCALL_EXTRA_STATE_RESTORER
 
 
-/* These are extra_state_saver/restorer values for a user trap.  Note that we
-   save the argument registers so that restarted syscalls will function
-   properly (otherwise it wouldn't be necessary), and we must _not_ restore
-   the return-value registers (so that traps can return a value!), but there
-   are various options for what happens to other call-clobbered registers,
-   selected by preprocessor conditionals.  */
-
-#if TRAPS_PRESERVE_CALL_CLOBBERED_REGS
-   
-/* Traps save/restore all call-clobbered registers (except for rval regs).  */
-#define TRAP_STATE_SAVER						      \
-     SAVE_CALL_CLOBBERED_REGS_NO_RVAL;					      \
-     SAVE_SYS_REGS
-#define TRAP_STATE_RESTORER						      \
-     RESTORE_CALL_CLOBBERED_REGS_NO_RVAL;				      \
-     RESTORE_SYS_REGS
-
-#else /* !TRAPS_PRESERVE_CALL_CLOBBERED_REGS */
+/* These are extra_state_saver/restorer values for a user trap.  Note
+   that we save the argument registers so that restarted syscalls will
+   function properly (otherwise it wouldn't be necessary), and we must
+   _not_ restore the return-value registers (so that traps can return a
+   value!), but call-clobbered registers are not saved at all, as the
+   caller of the syscall function should have saved them.  */
 
+#define TRAP_RET reti
 /* Traps don't save call-clobbered registers (but do still save arg regs).  */
 #define TRAP_STATE_SAVER						      \
-     SAVE_ARG_REGS;							      \
-     SAVE_SYS_REGS
-
-#if TRAPS_ZERO_CALL_CLOBBERED_REGS
-   
-/* Traps zero call-clobbered registers (except for arg/rval regs) before
-   returning from a system call, to avoid any internal values from leaking out
-   of the kernel.  */
-#define TRAP_STATE_RESTORER						      \
-     ZERO_CALL_CLOBBERED_REGS_NO_ARGS_NO_RVAL;				      \
-     RESTORE_ARG_REGS;							      \
-     RESTORE_SYS_REGS
-
-#else /* !TRAPS_ZERO_CALL_CLOBBERED_REGS */
-   
+	SAVE_ARG_REGS;							      \
+	SAVE_PC(EIPC)
 /* When traps return, they just leave call-clobbered registers (except for arg
    regs) with whatever value they have from the kernel.  */
 #define TRAP_STATE_RESTORER						      \
-     RESTORE_ARG_REGS;							      \
-     RESTORE_SYS_REGS
-
-#endif /* TRAPS_ZERO_CALL_CLOBBERED_REGS */
-#endif /* TRAPS_PRESERVE_CALL_CLOBBERED_REGS */
-
-/* Save registers not normally saved by traps.  */
+	RESTORE_ARG_REGS;						      \
+	RESTORE_PC(EIPC)
+/* Save registers not normally saved by traps.  We need to save r12, even
+   though it's nominally call-clobbered, because it's used when restarting
+   a system call (the signal-handling path uses SAVE_EXTRA_STATE, and
+   expects r12 to be restored when the trap returns).  Similarly, we must
+   save the PSW, so that it's at least in a known state in the the pt_regs
+   structure.  */
 #define TRAP_EXTRA_STATE_SAVER						      \
-   SAVE_RVAL_REGS;							      \
-   SAVE_CALL_SAVED_REGS
+	SAVE_RVAL_REGS;							      \
+	sst.w	r12, PTO+PT_GPR(12)[ep];				      \
+	SAVE_CALL_SAVED_REGS;						      \
+	SAVE_PSW(EIPSW);						      \
+	SAVE_CT_REGS
 #define TRAP_EXTRA_STATE_RESTORER					      \
-   RESTORE_RVAL_REGS;							      \
-   RESTORE_CALL_SAVED_REGS
+	RESTORE_RVAL_REGS;						      \
+	sld.w	PTO+PT_GPR(12)[ep], r12;				      \
+	RESTORE_CALL_SAVED_REGS;					      \
+	RESTORE_PSW(EIPSW);						      \
+	RESTORE_CT_REGS
 #define TRAP_FUNCALL_EXTRA_STATE_SAVER					      \
-   SAVE_RVAL_REGS
+	SAVE_RVAL_REGS
 #define TRAP_FUNCALL_EXTRA_STATE_RESTORER				      \
-   RESTORE_RVAL_REGS
-
+	RESTORE_RVAL_REGS
 
 /* Register saving/restoring for maskable interrupts.  */
+#define IRQ_RET reti
 #define IRQ_STATE_SAVER							      \
-   SAVE_CALL_CLOBBERED_REGS;						      \
-   SAVE_SYS_REGS
+	SAVE_CALL_CLOBBERED_REGS;					      \
+	SAVE_PC(EIPC);							      \
+	SAVE_PSW(EIPSW)
 #define IRQ_STATE_RESTORER						      \
-   RESTORE_CALL_CLOBBERED_REGS;						      \
-   RESTORE_SYS_REGS
+	RESTORE_CALL_CLOBBERED_REGS;					      \
+	RESTORE_PC(EIPC);						      \
+	RESTORE_PSW(EIPSW)
 #define IRQ_EXTRA_STATE_SAVER						      \
-   SAVE_CALL_SAVED_REGS
+	SAVE_CALL_SAVED_REGS;						      \
+	SAVE_CT_REGS
 #define IRQ_EXTRA_STATE_RESTORER					      \
-   RESTORE_CALL_SAVED_REGS
+	RESTORE_CALL_SAVED_REGS;					      \
+	RESTORE_CT_REGS
 #define IRQ_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
 #define IRQ_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
 
 /* Register saving/restoring for non-maskable interrupts.  */
+#define NMI_RET reti
 #define NMI_STATE_SAVER							      \
-   SAVE_CALL_CLOBBERED_REGS;						      \
-   SAVE_SYS_REGS_FOR_NMI
+	SAVE_CALL_CLOBBERED_REGS;					      \
+	SAVE_PC(FEPC);							      \
+	SAVE_PSW(FEPSW);
 #define NMI_STATE_RESTORER						      \
-   RESTORE_CALL_CLOBBERED_REGS;						      \
-   RESTORE_SYS_REGS_FOR_NMI
+	RESTORE_CALL_CLOBBERED_REGS;					      \
+	RESTORE_PC(FEPC);						      \
+	RESTORE_PSW(FEPSW);
 #define NMI_EXTRA_STATE_SAVER						      \
-   SAVE_CALL_SAVED_REGS
+	SAVE_CALL_SAVED_REGS;						      \
+	SAVE_CT_REGS
 #define NMI_EXTRA_STATE_RESTORER					      \
-   RESTORE_CALL_SAVED_REGS
+	RESTORE_CALL_SAVED_REGS;					      \
+	RESTORE_CT_REGS
 #define NMI_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
 #define NMI_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
-   
-/* Register saving/restoring for a context switch.  We don't need to save too
-   many registers, because context-switching looks like a function call (via
-   the function `switch_thread'), so callers will save any call-clobbered
-   registers themselves.  The stack pointer and return value are handled by
-   switch_thread itself.  */
+
+/* Register saving/restoring for debug traps.  */
+#define DBTRAP_RET .long 0x014607E0 /* `dbret', but gas doesn't support it. */
+#define DBTRAP_STATE_SAVER						      \
+	SAVE_CALL_CLOBBERED_REGS;					      \
+	SAVE_PC(DBPC);							      \
+	SAVE_PSW(DBPSW)
+#define DBTRAP_STATE_RESTORER						      \
+	RESTORE_CALL_CLOBBERED_REGS;					      \
+	RESTORE_PC(DBPC);						      \
+	RESTORE_PSW(DBPSW)
+#define DBTRAP_EXTRA_STATE_SAVER					      \
+	SAVE_CALL_SAVED_REGS;						      \
+	SAVE_CT_REGS
+#define DBTRAP_EXTRA_STATE_RESTORER					      \
+	RESTORE_CALL_SAVED_REGS;					      \
+	RESTORE_CT_REGS
+#define DBTRAP_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
+#define DBTRAP_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
+
+/* Register saving/restoring for a context switch.  We don't need to save
+   too many registers, because context-switching looks like a function call
+   (via the function `switch_thread'), so callers will save any
+   call-clobbered registers themselves.  We do need to save the CT regs, as
+   they're normally not saved during kernel entry (the kernel doesn't use
+   them).  We save PSW so that interrupt-status state will correctly follow
+   each thread (mostly NMI vs. normal-IRQ/trap), though for the most part
+   it doesn't matter since threads are always in almost exactly the same
+   processor state during a context switch.  The stack pointer and return
+   value are handled by switch_thread itself.  */
 #define SWITCH_STATE_SAVER						      \
-   SAVE_CALL_SAVED_REGS
+	SAVE_CALL_SAVED_REGS;						      \
+	SAVE_PSW(PSW);							      \
+	SAVE_CT_REGS
 #define SWITCH_STATE_RESTORER						      \
-   RESTORE_CALL_SAVED_REGS
+	RESTORE_CALL_SAVED_REGS;					      \
+	RESTORE_PSW(PSW);						      \
+	RESTORE_CT_REGS
 
 
 /* Restore register state from the struct pt_regs on the stack, switch back
@@ -400,24 +393,27 @@
 	andi	_TIF_SIGPENDING, r19, r0;				      \
 	bnz	4f;			/* Signals to handle, handle them */  \
 									      \
-/* Finally, return to user state.  */					      \
+/* Return to user state.  */					   	      \
 1:	st.b	r0, KM;			/* Now officially in user state. */   \
-	POP_STATE(type);						      \
-	st.w	sp, KSP;		/* Save the kernel stack pointer. */  \
-	ld.w    PT_GPR(GPR_SP)-PT_SIZE[sp], sp;				      \
-					/* Restore user stack pointer. */     \
-	reti;								      \
 									      \
-/* Return to kernel state.  */						      \
+/* Final return.  The stack-pointer fiddling is not needed when returning     \
+   to kernel-mode, but they don't hurt, and this way we can share the	      \
+   (somtimes rather lengthy) POP_STATE macro.  */			      \
 2:	POP_STATE(type);						      \
-	reti;								      \
+	st.w	sp, KSP;		/* Save the kernel stack pointer. */  \
+	ld.w    PT_GPR(GPR_SP)-PT_SIZE[sp], sp; /* Restore stack pointer. */  \
+	type ## _RET;			/* Return from the trap/interrupt. */ \
 									      \
 /* Call the scheduler before returning from a syscall/trap. */		      \
 3:	SAVE_EXTRA_STATE_FOR_FUNCALL(type); /* Prepare for funcall. */	      \
 	jarl	CSYM(schedule), lp;	/* Call scheduler */		      \
 	di;				/* The scheduler enables interrupts */\
 	RESTORE_EXTRA_STATE_FOR_FUNCALL(type);				      \
-	br	1b;							      \
+	GET_CURRENT_THREAD(r18);					      \
+	ld.w	TI_FLAGS[r18], r19;					      \
+	andi	_TIF_SIGPENDING, r19, r0;				      \
+	bz	1b;			/* No signals, return.  */	      \
+	/* Signals to handle, fall through to handle them.  */		      \
 									      \
 /* Handle a signal return.  */						      \
 4:      /* Not all registers are saved by the normal trap/interrupt entry     \
@@ -428,13 +424,13 @@
 	   complete register state.  Here we save anything not saved by	      \
 	   the normal entry sequence, so that it may be safely restored	      \
 	   (in a possibly modified form) after do_signal returns.  */	      \
-        SAVE_EXTRA_STATE(type)		/* Save state not saved by entry. */  \
+        SAVE_EXTRA_STATE(type);		/* Save state not saved by entry. */  \
 	movea	PTO, sp, r6;		/* Arg 1: struct pt_regs *regs */     \
 	mov	r0, r7;			/* Arg 2: sigset_t *oldset */	      \
 	jarl	CSYM(do_signal), lp;	/* Handle any signals */	      \
 	di;				/* sig handling enables interrupts */ \
         RESTORE_EXTRA_STATE(type);	/* Restore extra regs.  */	      \
-	br	1b;
+	br	1b
 
 
 /* Jump to the appropriate function for the system call number in r12
@@ -454,7 +450,7 @@
 	jmp	[r12];							      \
 	/* The syscall number is invalid, return an error.  */		      \
 1:	addi	-ENOSYS, r0, r10;					      \
-	jmp	[lp];
+	jmp	[lp]
 
 
 	.text
@@ -469,7 +465,7 @@
  * beyond a 22-bit signed offset jump from the actual interrupt handler, and
  * this allows them to save the stack-pointer and use that register to do an
  * indirect jump).
- *	
+ *
  * Syscall protocol:
  *   Syscall number in r12, args in r6-r9
  *   Return value in r10
@@ -537,18 +533,15 @@
 	st.w	r13, 16[sp]		// arg 5
 	st.w	r14, 20[sp]		// arg 6
 
-#if !TRAPS_PRESERVE_CALL_CLOBBERED_REGS
 	// Make sure r13 and r14 are preserved, in case we have to restart a
 	// system call because of a signal (ep has already been set by caller).
 	st.w	r13, PTO+PT_GPR(13)[sp]
 	st.w	r14, PTO+PT_GPR(13)[sp]
 	mov	hilo(ret_from_long_syscall), lp
-#endif /* !TRAPS_PRESERVE_CALL_CLOBBERED_REGS */
 
 	MAKE_SYS_CALL			// Jump to the syscall function.
 END(syscall_long)	
 
-#if !TRAPS_PRESERVE_CALL_CLOBBERED_REGS
 /* Entry point used to return from a long syscall.  Only needed to restore
    r13/r14 if the general trap mechanism doesnt' do so.  */
 L_ENTRY(ret_from_long_syscall):
@@ -556,7 +549,6 @@
 	ld.w	PTO+PT_GPR(13)[sp], r14
 	br	ret_from_trap		// The rest is the same as other traps
 END(ret_from_long_syscall)
-#endif /* !TRAPS_PRESERVE_CALL_CLOBBERED_REGS */
 
 
 /* These syscalls need access to the struct pt_regs on the stack, so we
@@ -564,14 +556,11 @@
 
 L_ENTRY(sys_fork_wrapper):
 #ifdef CONFIG_MMU
-	// Save state not saved by entry.  This is actually slight overkill;
-	// it's actually only necessary to save any state restored by
-	// switch_thread that's not saved by the trap entry.
-	SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	addi	SIGCHLD, r0, r6		// Arg 0: flags
 	ld.w	PTO+PT_GPR(GPR_SP)[sp], r7 // Arg 1: child SP (use parent's)
 	movea	PTO, sp, r8		// Arg 2: parent context
-	jr	CSYM(fork_common)	// Do real work (tail-call).
+	mov	hilo(CSYM(fork_common)), r18// Where the real work gets done
+	br	save_extra_state_tramp	// Save state and go there
 #else
 	// fork almost works, enough to trick you into looking elsewhere :-(
 	addi	-EINVAL, r0, r10
@@ -580,60 +569,66 @@
 END(sys_fork_wrapper)
 
 L_ENTRY(sys_vfork_wrapper):
-	// Save state not saved by entry.  This is actually slight overkill;
-	// it's actually only necessary to save any state restored by
-	// switch_thread that's not saved by the trap entry.
-	SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	addi	CLONE_VFORK | CLONE_VM | SIGCHLD, r0, r6 // Arg 0: flags
 	ld.w	PTO+PT_GPR(GPR_SP)[sp], r7 // Arg 1: child SP (use parent's)
 	movea	PTO, sp, r8		// Arg 2: parent context
-	jr	CSYM(fork_common)	// Do real work (tail-call).
+	mov	hilo(CSYM(fork_common)), r18// Where the real work gets done
+	br	save_extra_state_tramp	// Save state and go there
 END(sys_vfork_wrapper)
 
 L_ENTRY(sys_clone_wrapper):
-	// Save state not saved by entry.  This is actually slight overkill;
-	// it's actually only necessary to save any state restored by
-	// switch_thread that's not saved by the trap entry.
-	SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	ld.w	PTO+PT_GPR(GPR_SP)[sp], r19 // parent's stack pointer
         cmp	r7, r0			// See if child SP arg (arg 1) is 0.
 	cmov	z, r19, r7, r7		// ... and use the parent's if so. 
 	movea	PTO, sp, r8		// Arg 2: parent context
-	jr	CSYM(fork_common)	// Do real work (tail-call).
+	mov	hilo(CSYM(fork_common)), r18// Where the real work gets done
+	br	save_extra_state_tramp	// Save state and go there
 END(sys_clone_wrapper)
 
+
 L_ENTRY(sys_execve_wrapper):
 	movea	PTO, sp, r9		// add user context as 4th arg
 	jr	CSYM(sys_execve)	// Do real work (tail-call).
 END(sys_execve_wrapper)
 
+
 L_ENTRY(sys_sigsuspend_wrapper):
-        SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	movea	PTO, sp, r7		// add user context as 2nd arg
-	jarl	CSYM(sys_sigsuspend), lp// Do real work.
+	mov	hilo(CSYM(sys_sigsuspend)), r18	// syscall function
+	jarl	save_extra_state_tramp, lp	// Save state and do it
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_sigsuspend_wrapper)
 L_ENTRY(sys_rt_sigsuspend_wrapper):
-        SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	movea	PTO, sp, r8		// add user context as 3rd arg
-	jarl	CSYM(sys_rt_sigsuspend), lp	// Do real work.
+	mov	hilo(CSYM(sys_rt_sigsuspend)), r18	// syscall function
+	jarl	save_extra_state_tramp, lp	// Save state and do it
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_rt_sigsuspend_wrapper)
 
 L_ENTRY(sys_sigreturn_wrapper):
-        SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	movea	PTO, sp, r6		// add user context as 1st arg
-	jarl	CSYM(sys_sigreturn), lp	// Do real work.
+	mov	hilo(CSYM(sys_sigreturn)), r18	// syscall function
+	jarl	save_extra_state_tramp, lp	// Save state and do it
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_sigreturn_wrapper)
 L_ENTRY(sys_rt_sigreturn_wrapper):
         SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	movea	PTO, sp, r6		// add user context as 1st arg
-	jarl	CSYM(sys_rt_sigreturn), lp	// Do real work.
+	mov	hilo(CSYM(sys_rt_sigreturn)), r18	// syscall function
+	jarl	save_extra_state_tramp, lp	// Save state and do it
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_rt_sigreturn_wrapper)
 
 
+/* Save any state not saved by SAVE_STATE(TRAP), and jump to r18.
+   It's main purpose is to share the rather lengthy code sequence that
+   SAVE_STATE expands into among the above wrapper functions.  */
+L_ENTRY(save_extra_state_tramp):
+	SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
+	jmp	[r18]			// Do the work the caller wants
+END(save_extra_state_tramp)
+
+
 /*
  * Hardware maskable interrupts.
  *
@@ -658,37 +653,40 @@
 	shr	20, r6			// shift back, and remove lower nibble
 	add	-8, r6			// remove bias for irqs
 
-	// If the IRQ index is negative, it's actually one of the exception
-	// traps below 0x80 (currently, the illegal instruction trap, and
-	// the `debug trap').  Handle these separately.
-	bn	exception
-
 	// Call the high-level interrupt handling code.
 	jarl	CSYM(handle_irq), lp
-	// fall through
 
-/* Entry point used to return from an interrupt (also used by exception
-   handlers, below).  */
-ret_from_irq:
 	RETURN(IRQ)
+END(irq)
 
-exception:
-	mov	hilo(ret_from_irq), lp	// where the handler should return
 	
-	cmp	-2, r6
-	bne	1f
-	// illegal instruction exception
-	addi	SIGILL, r0, r6		// Arg 0: signal number
-	mov	CURRENT_TASK, r7	// Arg 1: task
-	jr	CSYM(force_sig)		// tail call
+/*
+ * Debug trap / illegal-instruction exception
+ *
+ * The stack-pointer (r3) should have already been saved to the memory
+ * location ENTRY_SP (the reason for this is that the interrupt vectors may be
+ * beyond a 22-bit signed offset jump from the actual interrupt handler, and
+ * this allows them to save the stack-pointer and use that register to do an
+ * indirect jump).
+ */
+G_ENTRY(dbtrap):
+	SAVE_STATE (DBTRAP, r0, ENTRY_SP)// Save registers. 
 
-1:	cmp	-1, r6
-	bne	bad_trap_wrapper
-	// `dbtrap' exception
-	movea	PTO, sp, r6		// Arg 0: user regs
-	jr	CSYM(debug_trap)	// tail call
+	/* Look to see if the preceding instruction was is a dbtrap or not,
+	   to decide which signal we should use.  */
+	stsr	SR_DBPC, r19		// PC following trapping insn
+	ld.hu	-2[r19], r19
+	mov	SIGTRAP, r6
+	ori	0xf840, r0, r20		// DBTRAP insn
+	cmp	r19, r20		// Was this trap caused by DBTRAP?
+	cmov	ne, SIGILL, r6, r6	// Choose signal appropriately
 
-END(irq)
+	/* Raise the desired signal.  */
+	mov	CURRENT_TASK, r7	// Arg 1: task
+	jarl	CSYM(force_sig), lp	// tail call
+
+	RETURN(DBTRAP)
+END(dbtrap)
 
 
 /*
@@ -711,7 +709,7 @@
 	   Call the generic IRQ handler, with two arguments, the IRQ number,
 	   and a pointer to the user registers, to handle the specifics.
 	   (we subtract one because the first NMI has code 1).  */
-	addi	FIRST_NMI - 1, r6, r6;
+	addi	FIRST_NMI - 1, r6, r6
 	jarl	CSYM(handle_irq), lp
 
 	RETURN(NMI)
diff -ruN -X../cludes linux-2.5.62-uc0.orig/arch/v850/kernel/intv.S linux-2.5.62-uc0/arch/v850/kernel/intv.S
--- linux-2.5.62-uc0.orig/arch/v850/kernel/intv.S	2002-11-28 10:24:54.000000000 +0900
+++ linux-2.5.62-uc0/arch/v850/kernel/intv.S	2003-02-18 11:41:09.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/intv.S -- Interrupt vectors
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Electronics Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -40,22 +40,19 @@
 	/* Generic interrupt vectors.  */
 	.section	.intv.common, "ax"
 	.balign	0x10
-	JUMP_TO_HANDLER (nmi, NMI_ENTRY_SP)	// NMI0
+	JUMP_TO_HANDLER (nmi, NMI_ENTRY_SP)	// 0x10 - NMI0
 	.balign	0x10
-	JUMP_TO_HANDLER (nmi, NMI_ENTRY_SP)	// NMI1
+	JUMP_TO_HANDLER (nmi, NMI_ENTRY_SP)	// 0x20 - NMI1
 	.balign	0x10
-	JUMP_TO_HANDLER (nmi, NMI_ENTRY_SP)	// NMI2
+	JUMP_TO_HANDLER (nmi, NMI_ENTRY_SP)	// 0x30 - NMI2
 	
 	.balign	0x10
-	JUMP_TO_HANDLER (trap, ENTRY_SP)	// TRAP0n
+	JUMP_TO_HANDLER (trap, ENTRY_SP)	// 0x40 - TRAP0n
 	.balign	0x10
-	JUMP_TO_HANDLER (trap, ENTRY_SP)	// TRAP1n
+	JUMP_TO_HANDLER (trap, ENTRY_SP)	// 0x50 - TRAP1n
 
 	.balign	0x10
-	JUMP_TO_HANDLER (irq, ENTRY_SP)		// illegal insn trap
-
-	.balign	0x10
-	JUMP_TO_HANDLER (irq, ENTRY_SP)		// DBTRAP insn
+	JUMP_TO_HANDLER (dbtrap, ENTRY_SP)	// 0x60 - Illegal op / DBTRAP insn
 
 
 	/* Hardware interrupt vectors.  */
