Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbTDHJRx (for <rfc822;willy@w.ods.org>); Tue, 8 Apr 2003 05:17:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261165AbTDHJRT (for <rfc822;linux-kernel-outgoing>); Tue, 8 Apr 2003 05:17:19 -0400
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:44029 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S261246AbTDHJQQ (for <rfc822;linux-kernel@vger.kernel.org>); Tue, 8 Apr 2003 05:16:16 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  v850 entry / ptrace changes
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030408092740.A98463731@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  8 Apr 2003 18:27:40 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

There a bunch of issues bunched together up here as the resulting
patches overlap quite a bit:

(1) Add support for hardware single-stepping via ptrace.

(2) Always call schedule_tail on the v850.  The scheduler apparently now
    requires this.

(3) Add new ptrace defines for v850 to get process address details
    This adds some magic addresses for use with PT_USERPEEK that allow gdb
    to find out where a process is located in memory, so it can correctly
    relocate its symbols to match the running process.  The actual
    implementation in sys_ptrace is currently tangled up with some other
    ptrace changes, so I'll leave that for later.

(4) Rename the (v850-specific) macro PT_SYSCALL to PT_CUR_SYSCALL
    This avoids a conflict with the more generic definition of PT_SYSCALL.

(5) Some misc whitespace cleanups.

diff -ruN -X../cludes linux-2.5.67-moo.orig/arch/v850/kernel/entry.S linux-2.5.67-moo/arch/v850/kernel/entry.S
--- linux-2.5.67-moo.orig/arch/v850/kernel/entry.S	2003-02-25 10:44:59.000000000 +0900
+++ linux-2.5.67-moo/arch/v850/kernel/entry.S	2003-04-08 14:13:38.000000000 +0900
@@ -29,28 +29,28 @@
 #define CSYM	C_SYMBOL_NAME
 
 
-/* The offset of the struct pt_regs in a `state save frame' on the stack.  */
+/* The offset of the struct pt_regs in a state-save-frame on the stack.  */
 #define PTO	STATE_SAVE_PT_OFFSET
 
 
-/* Save argument registers to the struct pt_regs pointed to by EP.  */
+/* Save argument registers to the state-save-frame pointed to by EP.  */
 #define SAVE_ARG_REGS							      \
 	sst.w	r6, PTO+PT_GPR(6)[ep];					      \
 	sst.w	r7, PTO+PT_GPR(7)[ep];					      \
 	sst.w	r8, PTO+PT_GPR(8)[ep];					      \
 	sst.w	r9, PTO+PT_GPR(9)[ep]
-/* Restore argument registers from the struct pt_regs pointed to by EP.  */
+/* Restore argument registers from the state-save-frame pointed to by EP.  */
 #define RESTORE_ARG_REGS						      \
 	sld.w	PTO+PT_GPR(6)[ep], r6;					      \
 	sld.w	PTO+PT_GPR(7)[ep], r7;					      \
 	sld.w	PTO+PT_GPR(8)[ep], r8;					      \
 	sld.w	PTO+PT_GPR(9)[ep], r9
 
-/* Save value return registers to the struct pt_regs pointed to by EP.  */
+/* Save value return registers to the state-save-frame pointed to by EP.  */
 #define SAVE_RVAL_REGS							      \
 	sst.w	r10, PTO+PT_GPR(10)[ep];				      \
 	sst.w	r11, PTO+PT_GPR(11)[ep]
-/* Restore value return registers from the struct pt_regs pointed to by EP.  */
+/* Restore value return registers from the state-save-frame pointed to by EP.  */
 #define RESTORE_RVAL_REGS						      \
 	sld.w	PTO+PT_GPR(10)[ep], r10;				      \
 	sld.w	PTO+PT_GPR(11)[ep], r11
@@ -81,13 +81,13 @@
 	sld.w	PTO+PT_GPR(18)[ep], r18;				      \
 	sld.w	PTO+PT_GPR(19)[ep], r19
 
-/* Save `call clobbered' registers to the struct pt_regs pointed to by EP.  */
+/* Save `call clobbered' registers to the state-save-frame pointed to by EP.  */
 #define SAVE_CALL_CLOBBERED_REGS					      \
 	SAVE_CALL_CLOBBERED_REGS_BEFORE_ARGS;				      \
 	SAVE_ARG_REGS;							      \
 	SAVE_RVAL_REGS;							      \
 	SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL
-/* Restore `call clobbered' registers from the struct pt_regs pointed to
+/* Restore `call clobbered' registers from the state-save-frame pointed to
    by EP.  */
 #define RESTORE_CALL_CLOBBERED_REGS					      \
 	RESTORE_CALL_CLOBBERED_REGS_BEFORE_ARGS;			      \
@@ -96,19 +96,19 @@
 	RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL
 
 /* Save `call clobbered' registers except for the return-value registers
-   to the struct pt_regs pointed to by EP.  */
+   to the state-save-frame pointed to by EP.  */
 #define SAVE_CALL_CLOBBERED_REGS_NO_RVAL				      \
 	SAVE_CALL_CLOBBERED_REGS_BEFORE_ARGS;				      \
 	SAVE_ARG_REGS;							      \
 	SAVE_CALL_CLOBBERED_REGS_AFTER_RVAL
 /* Restore `call clobbered' registers except for the return-value registers
-   from the struct pt_regs pointed to by EP.  */
+   from the state-save-frame pointed to by EP.  */
 #define RESTORE_CALL_CLOBBERED_REGS_NO_RVAL				      \
 	RESTORE_CALL_CLOBBERED_REGS_BEFORE_ARGS;			      \
 	RESTORE_ARG_REGS;						      \
 	RESTORE_CALL_CLOBBERED_REGS_AFTER_RVAL
 
-/* Save `call saved' registers to the struct pt_regs pointed to by EP.  */
+/* Save `call saved' registers to the state-save-frame pointed to by EP.  */
 #define SAVE_CALL_SAVED_REGS						      \
 	sst.w	r2, PTO+PT_GPR(2)[ep];					      \
 	sst.w	r20, PTO+PT_GPR(20)[ep];				      \
@@ -121,7 +121,7 @@
 	sst.w	r27, PTO+PT_GPR(27)[ep];				      \
 	sst.w	r28, PTO+PT_GPR(28)[ep];				      \
 	sst.w	r29, PTO+PT_GPR(29)[ep]
-/* Restore `call saved' registers from the struct pt_regs pointed to by EP.  */
+/* Restore `call saved' registers from the state-save-frame pointed to by EP.  */
 #define RESTORE_CALL_SAVED_REGS						      \
 	sld.w	PTO+PT_GPR(2)[ep], r2;					      \
 	sld.w	PTO+PT_GPR(20)[ep], r20;				      \
@@ -136,12 +136,12 @@
 	sld.w	PTO+PT_GPR(29)[ep], r29
 
 
-/* Save the PC stored in the special register SAVEREG to the struct pt_regs
+/* Save the PC stored in the special register SAVEREG to the state-save-frame
    pointed to by EP.  r19 is clobbered.  */
 #define SAVE_PC(savereg)						      \
 	stsr	SR_ ## savereg, r19;					      \
 	sst.w	r19, PTO+PT_PC[ep]
-/* Restore the PC from the struct pt_regs pointed to by EP, to the special
+/* Restore the PC from the state-save-frame pointed to by EP, to the special
    register SAVEREG.  LP is clobbered (it is used as a scratch register
    because the POP_STATE macro restores it, and this macro is usually used
    inside POP_STATE).  */
@@ -149,11 +149,11 @@
 	sld.w	PTO+PT_PC[ep], lp;					      \
 	ldsr	lp, SR_ ## savereg
 /* Save the PSW register stored in the special register SAVREG to the
-   struct pt_regs pointed to by EP r19 is clobbered.  */
+   state-save-frame pointed to by EP.  r19 is clobbered.  */
 #define SAVE_PSW(savereg)						      \
 	stsr	SR_ ## savereg, r19;					      \
 	sst.w	r19, PTO+PT_PSW[ep]
-/* Restore the PSW register from the struct pt_regs pointed to by EP, to
+/* Restore the PSW register from the state-save-frame pointed to by EP, to
    the special register SAVEREG.  LP is clobbered (it is used as a scratch
    register because the POP_STATE macro restores it, and this macro is
    usually used inside POP_STATE).  */
@@ -161,7 +161,7 @@
 	sld.w	PTO+PT_PSW[ep], lp;					      \
 	ldsr	lp, SR_ ## savereg
 
-/* Save CTPC/CTPSW/CTBP registers to the struct pt_regs pointed to by REG.  
+/* Save CTPC/CTPSW/CTBP registers to the state-save-frame pointed to by REG.
    r19 is clobbered.  */
 #define SAVE_CT_REGS							      \
 	stsr	SR_CTPC, r19;						      \
@@ -170,7 +170,7 @@
 	sst.w	r19, PTO+PT_CTPSW[ep];					      \
 	stsr	SR_CTBP, r19;						      \
 	sst.w	r19, PTO+PT_CTBP[ep]
-/* Restore CTPC/CTPSW/CTBP registers from the struct pt_regs pointed to by EP.
+/* Restore CTPC/CTPSW/CTBP registers from the state-save-frame pointed to by EP.
    LP is clobbered (it is used as a scratch register because the POP_STATE
    macro restores it, and this macro is usually used inside POP_STATE).  */
 #define RESTORE_CT_REGS							      \
@@ -182,10 +182,11 @@
 	ldsr	lp, SR_CTBP
 
 
-/* Push register state, except for the stack pointer, on the stack in the form
-   of a struct pt_regs, in preparation for a system call.  This macro makes
-   sure that `special' registers, system registers; TYPE identifies the set of
-   extra registers to be saved as well.  EP is clobbered.  */
+/* Push register state, except for the stack pointer, on the stack in the
+   form of a state-save-frame (plus some extra padding), in preparation for
+   a system call.  This macro makes sure that the EP, GP, and LP
+   registers are saved, and TYPE identifies the set of extra registers to
+   be saved as well.  Also copies (the new value of) SP to EP.  */
 #define PUSH_STATE(type)						      \
 	addi	-STATE_SAVE_SIZE, sp, sp; /* Make room on the stack.  */      \
 	st.w	ep, PTO+PT_GPR(GPR_EP)[sp];				      \
@@ -193,8 +194,8 @@
 	sst.w	gp, PTO+PT_GPR(GPR_GP)[ep];				      \
 	sst.w	lp, PTO+PT_GPR(GPR_LP)[ep];				      \
 	type ## _STATE_SAVER
-/* Pop a register state, except for the stack pointer, from the struct pt_regs
-   on the stack.  */
+/* Pop a register state pushed by PUSH_STATE, except for the stack pointer,
+   from the the stack.  */
 #define POP_STATE(type)							      \
 	mov	sp, ep;							      \
 	type ## _STATE_RESTORER;					      \
@@ -205,7 +206,7 @@
 
 
 /* Switch to the kernel stack if necessary, and push register state on the
-   stack in the form of a struct pt_regs.  Also load the current task
+   stack in the form of a state-save-frame.  Also load the current task
    pointer if switching from user mode.  The stack-pointer (r3) should have
    already been saved to the memory location SP_SAVE_LOC (the reason for
    this is that the interrupt vectors may be beyond a 22-bit signed offset
@@ -231,28 +232,33 @@
 	st.b	r19, KM;						      \
 	GET_CURRENT_TASK(CURRENT_TASK);	/* Fetch the current task pointer. */ \
 	/* Save away the syscall number.  */				      \
-	sst.w	syscall_num, PTO+PT_SYSCALL[ep]
+	sst.w	syscall_num, PTO+PT_CUR_SYSCALL[ep];
 
 
-/* Save register state not normally saved by PUSH_STATE for TYPE.  */
+/* Save register state not normally saved by PUSH_STATE for TYPE, to the
+   state-save-frame on the stack; also copies SP to EP.  r19 may be trashed. */
 #define SAVE_EXTRA_STATE(type)						      \
-        mov	sp, ep;							      \
+	mov	sp, ep;							      \
 	type ## _EXTRA_STATE_SAVER
-/* Restore register state not normally restored by POP_STATE for TYPE.  */
+/* Restore register state not normally restored by POP_STATE for TYPE,
+   from the state-save-frame on the stack; also copies SP to EP.
+   r19 may be trashed.  */
 #define RESTORE_EXTRA_STATE(type)					      \
-        mov	sp, ep;							      \
+	mov	sp, ep;							      \
 	type ## _EXTRA_STATE_RESTORER
 
-/* Save any call-clobbered registers not normally saved by PUSH_STATE
-   for TYPE.  */
-#define SAVE_EXTRA_STATE_FOR_FUNCALL(type)				      \
-        mov	sp, ep;							      \
-	type ## _FUNCALL_EXTRA_STATE_SAVER
-/* Restore any call-clobbered registers not normally restored by POP_STATE for
-   TYPE.  */
-#define RESTORE_EXTRA_STATE_FOR_FUNCALL(type)				      \
-        mov	sp, ep;							      \
-	type ## _FUNCALL_EXTRA_STATE_RESTORER
+/* Save any call-clobbered registers not normally saved by PUSH_STATE for
+   TYPE, to the state-save-frame on the stack.
+   EP may be trashed, but is not guaranteed to contain a copy of SP
+   (unlike after most SAVE_... macros).  r19 may be trashed.  */
+#define SAVE_EXTRA_STATE_FOR_SCHEDULE(type)				      \
+	type ## _SCHEDULE_EXTRA_STATE_SAVER
+/* Restore any call-clobbered registers not normally restored by
+   POP_STATE for TYPE, to the state-save-frame on the stack.
+   EP may be trashed, but is not guaranteed to contain a copy of SP
+   (unlike after most RESTORE_... macros).  r19 may be trashed.  */
+#define RESTORE_EXTRA_STATE_FOR_SCHEDULE(type)				      \
+	type ## _SCHEDULE_EXTRA_STATE_RESTORER
 
 
 /* These are extra_state_saver/restorer values for a user trap.  Note
@@ -263,36 +269,48 @@
    caller of the syscall function should have saved them.  */
 
 #define TRAP_RET reti
-/* Traps don't save call-clobbered registers (but do still save arg regs).  */
+/* Traps don't save call-clobbered registers (but do still save arg regs).
+   We preserve PSw to keep long-term state, namely interrupt status (for traps
+   from kernel-mode), and the single-step flag (for user traps).  */
 #define TRAP_STATE_SAVER						      \
 	SAVE_ARG_REGS;							      \
-	SAVE_PC(EIPC)
+	SAVE_PC(EIPC);							      \
+	SAVE_PSW(EIPSW)
 /* When traps return, they just leave call-clobbered registers (except for arg
-   regs) with whatever value they have from the kernel.  */
+   regs) with whatever value they have from the kernel.  Traps don't preserve
+   the PSW, but we zero EIPSW to ensure it doesn't contain anything dangerous
+   (in particular, the single-step flag).  */
 #define TRAP_STATE_RESTORER						      \
 	RESTORE_ARG_REGS;						      \
-	RESTORE_PC(EIPC)
+	RESTORE_PC(EIPC);						      \
+	RESTORE_PSW(EIPSW)
 /* Save registers not normally saved by traps.  We need to save r12, even
    though it's nominally call-clobbered, because it's used when restarting
    a system call (the signal-handling path uses SAVE_EXTRA_STATE, and
-   expects r12 to be restored when the trap returns).  Similarly, we must
-   save the PSW, so that it's at least in a known state in the the pt_regs
-   structure.  */
+   expects r12 to be restored when the trap returns).  */
 #define TRAP_EXTRA_STATE_SAVER						      \
 	SAVE_RVAL_REGS;							      \
 	sst.w	r12, PTO+PT_GPR(12)[ep];				      \
 	SAVE_CALL_SAVED_REGS;						      \
-	SAVE_PSW(EIPSW);						      \
 	SAVE_CT_REGS
 #define TRAP_EXTRA_STATE_RESTORER					      \
 	RESTORE_RVAL_REGS;						      \
 	sld.w	PTO+PT_GPR(12)[ep], r12;				      \
 	RESTORE_CALL_SAVED_REGS;					      \
-	RESTORE_PSW(EIPSW);						      \
 	RESTORE_CT_REGS
-#define TRAP_FUNCALL_EXTRA_STATE_SAVER					      \
+/* Save registers prior to calling scheduler (just before trap returns).
+   We have to save the return-value registers to preserve the trap's return
+   value.  Note that ..._SCHEDULE_EXTRA_STATE_SAVER, unlike most ..._SAVER
+   macros, is required to setup EP itself if EP is needed (this is because
+   in many cases, the macro is empty).  */
+#define TRAP_SCHEDULE_EXTRA_STATE_SAVER					      \
+	mov sp, ep;							      \
 	SAVE_RVAL_REGS
-#define TRAP_FUNCALL_EXTRA_STATE_RESTORER				      \
+/* Note that ..._SCHEDULE_EXTRA_STATE_RESTORER, unlike most ..._RESTORER
+   macros, is required to setup EP itself if EP is needed (this is because
+   in many cases, the macro is empty).  */
+#define TRAP_SCHEDULE_EXTRA_STATE_RESTORER				      \
+	mov sp, ep;							      \
 	RESTORE_RVAL_REGS
 
 /* Register saving/restoring for maskable interrupts.  */
@@ -311,8 +329,8 @@
 #define IRQ_EXTRA_STATE_RESTORER					      \
 	RESTORE_CALL_SAVED_REGS;					      \
 	RESTORE_CT_REGS
-#define IRQ_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
-#define IRQ_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
+#define IRQ_SCHEDULE_EXTRA_STATE_SAVER	     /* nothing */
+#define IRQ_SCHEDULE_EXTRA_STATE_RESTORER    /* nothing */
 
 /* Register saving/restoring for non-maskable interrupts.  */
 #define NMI_RET reti
@@ -330,8 +348,8 @@
 #define NMI_EXTRA_STATE_RESTORER					      \
 	RESTORE_CALL_SAVED_REGS;					      \
 	RESTORE_CT_REGS
-#define NMI_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
-#define NMI_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
+#define NMI_SCHEDULE_EXTRA_STATE_SAVER	     /* nothing */
+#define NMI_SCHEDULE_EXTRA_STATE_RESTORER    /* nothing */
 
 /* Register saving/restoring for debug traps.  */
 #define DBTRAP_RET .long 0x014607E0 /* `dbret', but gas doesn't support it. */
@@ -349,8 +367,8 @@
 #define DBTRAP_EXTRA_STATE_RESTORER					      \
 	RESTORE_CALL_SAVED_REGS;					      \
 	RESTORE_CT_REGS
-#define DBTRAP_FUNCALL_EXTRA_STATE_SAVER       /* nothing */
-#define DBTRAP_FUNCALL_EXTRA_STATE_RESTORER    /* nothing */
+#define DBTRAP_SCHEDULE_EXTRA_STATE_SAVER	/* nothing */
+#define DBTRAP_SCHEDULE_EXTRA_STATE_RESTORER	/* nothing */
 
 /* Register saving/restoring for a context switch.  We don't need to save
    too many registers, because context-switching looks like a function call
@@ -372,14 +390,14 @@
 	RESTORE_CT_REGS
 
 
-/* Restore register state from the struct pt_regs on the stack, switch back
+/* Restore register state from the state-save-frame on the stack, switch back
    to the user stack if necessary, and return from the trap/interrupt.
    EXTRA_STATE_RESTORER is a sequence of assembly language statements to
    restore anything not restored by this macro.  Only registers not saved by
    the C compiler are restored (that is, R3(sp), R4(gp), R31(lp), and
    anything restored by EXTRA_STATE_RESTORER).  */
 #define RETURN(type)							      \
-        ld.b	PTO+PT_KERNEL_MODE[sp], r19;				      \
+	ld.b	PTO+PT_KERNEL_MODE[sp], r19;				      \
 	di;				/* Disable interrupts */	      \
 	cmp	r19, r0;		/* See if returning to kernel mode, */\
 	bne	2f;			/* ... if so, skip resched &c.  */    \
@@ -390,33 +408,34 @@
 	ld.w	TI_FLAGS[r18], r19;					      \
 	andi	_TIF_NEED_RESCHED, r19, r0;				      \
 	bnz	3f;			/* Call the scheduler.  */	      \
-	andi	_TIF_SIGPENDING, r19, r0;				      \
+5:	andi	_TIF_SIGPENDING, r19, r18;				      \
+	ld.w	TASK_PTRACE[CURRENT_TASK], r19; /* ptrace flags */	      \
+	or	r18, r19;		/* see if either is non-zero */	      \
 	bnz	4f;			/* Signals to handle, handle them */  \
 									      \
-/* Return to user state.  */					   	      \
+/* Return to user state.  */						      \
 1:	st.b	r0, KM;			/* Now officially in user state. */   \
 									      \
 /* Final return.  The stack-pointer fiddling is not needed when returning     \
    to kernel-mode, but they don't hurt, and this way we can share the	      \
-   (somtimes rather lengthy) POP_STATE macro.  */			      \
+   (sometimes rather lengthy) POP_STATE macro.  */			      \
 2:	POP_STATE(type);						      \
 	st.w	sp, KSP;		/* Save the kernel stack pointer. */  \
-	ld.w    PT_GPR(GPR_SP)-PT_SIZE[sp], sp; /* Restore stack pointer. */  \
+	ld.w	PT_GPR(GPR_SP)-PT_SIZE[sp], sp; /* Restore stack pointer. */  \
 	type ## _RET;			/* Return from the trap/interrupt. */ \
 									      \
 /* Call the scheduler before returning from a syscall/trap. */		      \
-3:	SAVE_EXTRA_STATE_FOR_FUNCALL(type); /* Prepare for funcall. */	      \
-	jarl	CSYM(schedule), lp;	/* Call scheduler */		      \
+3:	SAVE_EXTRA_STATE_FOR_SCHEDULE(type); /* Prepare to call scheduler. */ \
+	jarl	call_scheduler, lp;	/* Call scheduler */		      \
 	di;				/* The scheduler enables interrupts */\
-	RESTORE_EXTRA_STATE_FOR_FUNCALL(type);				      \
+	RESTORE_EXTRA_STATE_FOR_SCHEDULE(type);				      \
 	GET_CURRENT_THREAD(r18);					      \
 	ld.w	TI_FLAGS[r18], r19;					      \
-	andi	_TIF_SIGPENDING, r19, r0;				      \
-	bz	1b;			/* No signals, return.  */	      \
-	/* Signals to handle, fall through to handle them.  */		      \
+	br	5b;			/* Continue with return path. */      \
 									      \
-/* Handle a signal return.  */						      \
-4:      /* Not all registers are saved by the normal trap/interrupt entry     \
+/* Handle a signal or ptraced process return.				      \
+   r18 should be non-zero if there are pending signals.  */		      \
+4:	/* Not all registers are saved by the normal trap/interrupt entry     \
 	   points (for instance, call-saved registers (because the normal     \
 	   C-compiler calling sequence in the kernel makes sure they're	      \
 	   preserved), and call-clobbered registers in the case of	      \
@@ -424,12 +443,9 @@
 	   complete register state.  Here we save anything not saved by	      \
 	   the normal entry sequence, so that it may be safely restored	      \
 	   (in a possibly modified form) after do_signal returns.  */	      \
-        SAVE_EXTRA_STATE(type);		/* Save state not saved by entry. */  \
-	movea	PTO, sp, r6;		/* Arg 1: struct pt_regs *regs */     \
-	mov	r0, r7;			/* Arg 2: sigset_t *oldset */	      \
-	jarl	CSYM(do_signal), lp;	/* Handle any signals */	      \
-	di;				/* sig handling enables interrupts */ \
-        RESTORE_EXTRA_STATE(type);	/* Restore extra regs.  */	      \
+	SAVE_EXTRA_STATE(type);		/* Save state not saved by entry. */  \
+	jarl	handle_signal_or_ptrace_return, lp;			      \
+	RESTORE_EXTRA_STATE(type);	/* Restore extra regs.  */	      \
 	br	1b
 
 
@@ -471,7 +487,7 @@
  *   Return value in r10
  */
 G_ENTRY(trap):
-	SAVE_STATE (TRAP, r12, ENTRY_SP) // Save registers. 
+	SAVE_STATE (TRAP, r12, ENTRY_SP) // Save registers.
 	stsr	SR_ECR, r19		// Find out which trap it was.
 	ei				// Enable interrupts.
 	mov	hilo(ret_from_trap), lp	// where the trap should return
@@ -481,12 +497,12 @@
 	// numbers into the (0-31) << 2 range we want, (3) set the flags.
 	shl	27, r19			// chop off all high bits
 	shr	25, r19			// scale back down and then << 2
-	bnz	2f			// See if not trap 0. 
+	bnz	2f			// See if not trap 0.
 
-	// Trap 0 is a `short' system call, skip general trap table. 
-	MAKE_SYS_CALL			// Jump to the syscall function. 
+	// Trap 0 is a `short' system call, skip general trap table.
+	MAKE_SYS_CALL			// Jump to the syscall function.
 
-2:	// For other traps, use a table lookup. 
+2:	// For other traps, use a table lookup.
 	mov	hilo(CSYM(trap_table)), r18
 	add	r19, r18
 	ld.w	0[r18], r18
@@ -505,16 +521,15 @@
 	RETURN(TRAP)
 END(ret_from_trap)
 
+
 /* This the initial entry point for a new child thread, with an appropriate
    stack in place that makes it look the the child is in the middle of an
    syscall.  This function is actually `returned to' from switch_thread
    (copy_thread makes ret_from_fork the return address in each new thread's
    saved context).  */
 C_ENTRY(ret_from_fork):
-#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT)
 	mov	r10, r6			// switch_thread returns the prev task.
 	jarl	CSYM(schedule_tail), lp	// ...which is schedule_tail's arg
-#endif
 	mov	r0, r10			// Child's fork call should return 0.
 	br	ret_from_trap		// Do normal trap return.
 C_END(ret_from_fork)
@@ -540,7 +555,7 @@
 	mov	hilo(ret_from_long_syscall), lp
 
 	MAKE_SYS_CALL			// Jump to the syscall function.
-END(syscall_long)	
+END(syscall_long)
 
 /* Entry point used to return from a long syscall.  Only needed to restore
    r13/r14 if the general trap mechanism doesnt' do so.  */
@@ -578,8 +593,8 @@
 
 L_ENTRY(sys_clone_wrapper):
 	ld.w	PTO+PT_GPR(GPR_SP)[sp], r19 // parent's stack pointer
-        cmp	r7, r0			// See if child SP arg (arg 1) is 0.
-	cmov	z, r19, r7, r7		// ... and use the parent's if so. 
+	cmp	r7, r0			// See if child SP arg (arg 1) is 0.
+	cmov	z, r19, r7, r7		// ... and use the parent's if so.
 	movea	PTO, sp, r8		// Arg 2: parent context
 	mov	hilo(CSYM(fork_common)), r18// Where the real work gets done
 	br	save_extra_state_tramp	// Save state and go there
@@ -612,10 +627,9 @@
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_sigreturn_wrapper)
 L_ENTRY(sys_rt_sigreturn_wrapper):
-        SAVE_EXTRA_STATE(TRAP)		// Save state not saved by entry.
 	movea	PTO, sp, r6		// add user context as 1st arg
 	mov	hilo(CSYM(sys_rt_sigreturn)), r18	// syscall function
-	jarl	save_extra_state_tramp, lp	// Save state and do it
+	jarl	save_extra_state_tramp, lp	 // Save state and do it
 	br	restore_extra_regs_and_ret_from_trap
 END(sys_rt_sigreturn_wrapper)
 
@@ -639,7 +653,7 @@
  * indirect jump).
  */
 G_ENTRY(irq):
-	SAVE_STATE (IRQ, r0, ENTRY_SP)	// Save registers. 
+	SAVE_STATE (IRQ, r0, ENTRY_SP)	// Save registers.
 
 	stsr	SR_ECR, r6		// Find out which interrupt it was.
 	movea	PTO, sp, r7		// User regs are arg2
@@ -659,7 +673,7 @@
 	RETURN(IRQ)
 END(irq)
 
-	
+
 /*
  * Debug trap / illegal-instruction exception
  *
@@ -670,22 +684,50 @@
  * indirect jump).
  */
 G_ENTRY(dbtrap):
-	SAVE_STATE (DBTRAP, r0, ENTRY_SP)// Save registers. 
+	SAVE_STATE (DBTRAP, r0, ENTRY_SP)// Save registers.
+
+	/* First see if we came from kernel mode; if so, the dbtrap
+	   instruction has a special meaning, to set the DIR (`debug
+	   information register') register.  This is because the DIR register
+	   can _only_ be manipulated/read while in `debug mode,' and debug
+	   mode is only active while we're inside the dbtrap handler.  The
+	   exact functionality is:  { DIR = (DIR | r6) & ~r7; return DIR; }. */
+	ld.b	PTO+PT_KERNEL_MODE[sp], r19
+	cmp	r19, r0
+	bz	1f
+
+	stsr	SR_DIR, r10
+	or	r6, r10
+	not	r7, r7
+	and	r7, r10
+	ldsr	r10, SR_DIR
+	stsr	SR_DIR, r10		// Confirm the value we set
+	st.w	r10, PTO+PT_GPR(10)[sp]	// return it
+	br	3f
+
+1:	ei				// Enable interrupts.
+
+	/* The default signal type we raise.  */
+	mov	SIGTRAP, r6
+
+	/* See if it's a single-step trap.  */
+	stsr	SR_DBPSW, r19
+	andi	0x0800, r19, r19
+	bnz	2f
 
 	/* Look to see if the preceding instruction was is a dbtrap or not,
 	   to decide which signal we should use.  */
 	stsr	SR_DBPC, r19		// PC following trapping insn
 	ld.hu	-2[r19], r19
-	mov	SIGTRAP, r6
 	ori	0xf840, r0, r20		// DBTRAP insn
 	cmp	r19, r20		// Was this trap caused by DBTRAP?
 	cmov	ne, SIGILL, r6, r6	// Choose signal appropriately
 
 	/* Raise the desired signal.  */
-	mov	CURRENT_TASK, r7	// Arg 1: task
-	jarl	CSYM(force_sig), lp	// tail call
+2:	mov	CURRENT_TASK, r7	// Arg 1: task
+	jarl	CSYM(send_sig), lp	// tail call
 
-	RETURN(DBTRAP)
+3:	RETURN(DBTRAP)
 END(dbtrap)
 
 
@@ -727,9 +769,93 @@
 
 
 /*
+ * Invoke the scheduler, called from the trap/irq kernel exit path.
+ *
+ * This basically just calls `schedule', but also arranges for extra
+ * registers to be saved for ptrace'd processes, so ptrace can modify them.
+ */
+L_ENTRY(call_scheduler):
+	ld.w	TASK_PTRACE[CURRENT_TASK], r19	// See if task is ptrace'd
+	cmp	r19, r0
+	bnz	1f			// ... yes, do special stuff
+	jr	CSYM(schedule)		// ... no, just tail-call scheduler
+
+	// Save extra regs for ptrace'd task.  We want to save anything
+	// that would otherwise only be `implicitly' saved by the normal
+	// compiler calling-convention.
+1:	mov	sp, ep			// Setup EP for SAVE_CALL_SAVED_REGS
+	SAVE_CALL_SAVED_REGS		// Save call-saved registers to stack
+	mov	lp, r20			// Save LP in a callee-saved register
+
+	jarl	CSYM(schedule), lp	// Call scheduler
+
+	mov	r20, lp
+	mov	sp, ep			// We can't rely on EP after return
+	RESTORE_CALL_SAVED_REGS		// Restore (possibly modified) regs
+	jmp	[lp]			// Return to the return path
+END(call_scheduler)
+
+
+/*
+ * This is an out-of-line handler for two special cases during the kernel
+ * trap/irq exit sequence:
+ *
+ *  (1) If r18 is non-zero then a signal needs to be handled, which is
+ *	done, and then the caller returned to.
+ *
+ *  (2) If r18 is non-zero then we're returning to a ptraced process, which
+ *	has several special cases -- single-stepping and trap tracing, both
+ *	of which require using the `dbret' instruction to exit the kernel
+ *	instead of the normal `reti' (this is because the CPU not correctly
+ *	single-step after a reti).  In this case, of course, this handler
+ *	never returns to the caller.
+ *
+ * In either case, all registers should have been saved to the current
+ * state-save-frame on the stack, except for callee-saved registers.
+ *
+ * [These two different cases are combined merely to avoid bloating the
+ * macro-inlined code, not because they really make much sense together!]
+ */
+L_ENTRY(handle_signal_or_ptrace_return):
+	cmp	r18, r0			// See if handling a signal
+	bz	1f			// ... nope, go do ptrace return
+
+	// Handle a signal
+	mov	lp, r20			// Save link-pointer
+	mov	r10, r21		// Save return-values (for trap)
+	mov	r11, r22
+
+	movea	PTO, sp, r6		// Arg 1: struct pt_regs *regs
+	mov	r0, r7			// Arg 2: sigset_t *oldset
+	jarl	CSYM(do_signal), lp	// Handle the signal
+	di				// sig handling enables interrupts
+
+	mov	r20, lp			// Restore link-pointer
+	mov	r21, r10		// Restore return-values (for trap)
+	mov	r22, r11
+	ld.w	TASK_PTRACE[CURRENT_TASK], r19  // check ptrace flags too
+	cmp	r19, r0
+	bnz	1f			// ... some set, so look more
+2:	jmp	[lp]			// ... none set, so return normally
+
+	// ptrace return
+1:	ld.w	PTO+PT_PSW[sp], r19	// Look at user-processes's flags
+	andi	0x0800, r19, r19	// See if single-step flag is set
+	bz	2b			// ... nope, return normally
+
+	// Return as if from a dbtrap insn
+	st.b	r0, KM			// Now officially in user state.
+	POP_STATE(DBTRAP)		// Restore regs
+	st.w	sp, KSP			// Save the kernel stack pointer.
+	ld.w	PT_GPR(GPR_SP)-PT_SIZE[sp], sp // Restore user stack pointer.
+	DBTRAP_RET			// Return from the trap/interrupt.
+END(handle_signal_or_ptrace_return)
+
+
+/*
  * This is where we switch between two threads.  The arguments are:
  *   r6 -- pointer to the struct thread for the `current' process
- *   r7 -- pointer to the struct thread for the `new' process.  
+ *   r7 -- pointer to the struct thread for the `new' process.
  * when this function returns, it will return to the new thread.
  */
 C_ENTRY(switch_thread):
@@ -756,8 +882,8 @@
 
 	.align 4
 C_DATA(trap_table):
-	.long bad_trap_wrapper		// trap 0, doesn't use trap table. 
-	.long syscall_long		// trap 1, `long' syscall. 
+	.long bad_trap_wrapper		// trap 0, doesn't use trap table.
+	.long syscall_long		// trap 1, `long' syscall.
 	.long bad_trap_wrapper
 	.long bad_trap_wrapper
 	.long bad_trap_wrapper
@@ -837,7 +963,7 @@
 	.long CSYM(sys_fcntl)		// 55
 	.long CSYM(sys_ni_syscall)	// was: mpx
 	.long CSYM(sys_setpgid)
-	.long CSYM(sys_ni_syscall) 	// was: ulimit
+	.long CSYM(sys_ni_syscall)	// was: ulimit
 	.long CSYM(sys_ni_syscall)
 	.long CSYM(sys_umask)		// 60
 	.long CSYM(sys_chroot)
@@ -877,7 +1003,7 @@
 	.long CSYM(sys_fchown)		// 95
 	.long CSYM(sys_getpriority)
 	.long CSYM(sys_setpriority)
-	.long CSYM(sys_ni_syscall) 	// was: profil
+	.long CSYM(sys_ni_syscall)	// was: profil
 	.long CSYM(sys_statfs)
 	.long CSYM(sys_fstatfs)		// 100
 	.long CSYM(sys_ni_syscall)	// i386: ioperm
@@ -902,7 +1028,7 @@
 	.long sys_clone_wrapper		// 120
 	.long CSYM(sys_setdomainname)
 	.long CSYM(sys_newuname)
-	.long CSYM(sys_ni_syscall)	// i386: modify_ldt, m68k: cacheflush 
+	.long CSYM(sys_ni_syscall)	// i386: modify_ldt, m68k: cacheflush
 	.long CSYM(sys_adjtimex)
 	.long CSYM(sys_ni_syscall)	// 125 - sys_mprotect
 	.long CSYM(sys_sigprocmask)
@@ -939,7 +1065,7 @@
 	.long CSYM(sys_sched_getscheduler)
 	.long CSYM(sys_sched_yield)
 	.long CSYM(sys_sched_get_priority_max)
-	.long CSYM(sys_sched_get_priority_min)  // 160
+	.long CSYM(sys_sched_get_priority_min)	// 160
 	.long CSYM(sys_sched_rr_get_interval)
 	.long CSYM(sys_nanosleep)
 	.long CSYM(sys_ni_syscall)	// sys_mremap
diff -ruN -X../cludes linux-2.5.67-moo.orig/arch/v850/kernel/ptrace.c linux-2.5.67-moo/arch/v850/kernel/ptrace.c
--- linux-2.5.67-moo.orig/arch/v850/kernel/ptrace.c	2002-11-05 11:25:22.000000000 +0900
+++ linux-2.5.67-moo/arch/v850/kernel/ptrace.c	2003-04-08 14:44:53.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * arch/v850/kernel/ptrace.c -- `ptrace' system call
  *
- *  Copyright (C) 2002  NEC Corporation
- *  Copyright (C) 2002  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2002,03  NEC Electronics Corporation
+ *  Copyright (C) 2002,03  Miles Bader <miles@gnu.org>
  *
  * Derived from arch/mips/kernel/ptrace.c:
  *
@@ -29,6 +29,89 @@
 #include <asm/processor.h>
 #include <asm/uaccess.h>
 
+/* Returns the address where the register at REG_OFFS in P is stashed away.  */
+static v850_reg_t *reg_save_addr (unsigned reg_offs, struct task_struct *t)
+{
+	struct pt_regs *regs;
+
+	/* Three basic cases:
+
+	   (1) A register normally saved before calling the scheduler, is
+	       available in the kernel entry pt_regs structure at the top
+	       of the kernel stack.  The kernel trap/irq exit path takes
+	       care to save/restore almost all registers for ptrace'd
+	       processes.
+
+	   (2) A call-clobbered register, where the process P entered the
+	       kernel via [syscall] trap, is not stored anywhere; that's
+	       OK, because such registers are not expected to be preserved
+	       when the trap returns anyway (so we don't actually bother to
+	       test for this case).
+
+	   (3) A few registers not used at all by the kernel, and so
+	       normally never saved except by context-switches, are in the
+	       context switch state.  */
+
+	if (reg_offs == PT_CTPC || reg_offs == PT_CTPSW || reg_offs == PT_CTBP)
+		/* Register saved during context switch.  */
+		regs = thread_saved_regs (t);
+	else
+		/* Register saved during kernel entry (or not available).  */
+		regs = task_regs (t);
+
+	return (v850_reg_t *)((char *)regs + reg_offs);
+}
+
+/* Set the bits SET and clear the bits CLEAR in the v850e DIR
+   (`debug information register').  Returns the new value of DIR.  */
+static inline v850_reg_t set_dir (v850_reg_t set, v850_reg_t clear)
+{
+	register v850_reg_t rval asm ("r10");
+	register v850_reg_t arg0 asm ("r6") = set;
+	register v850_reg_t arg1 asm ("r7") = clear;
+
+	/* The dbtrap handler has exactly this functionality when called
+	   from kernel mode.  0xf840 is a `dbtrap' insn.  */
+	asm (".short 0xf840" : "=r" (rval) : "r" (arg0), "r" (arg1));
+
+	return rval;
+}
+
+/* Makes sure hardware single-stepping is (globally) enabled.
+   Returns true if successful.  */
+static inline int enable_single_stepping (void)
+{
+	static int enabled = 0;	/* Remember whether we already did it.  */
+	if (! enabled) {
+		/* Turn on the SE (`single-step enable') bit, 0x100, in the
+		   DIR (`debug information register').  This may fail if a
+		   processor doesn't support it or something.  We also try
+		   to clear bit 0x40 (`INI'), which is necessary to use the
+		   debug stuff on the v850e2; on the v850e, clearing 0x40
+		   shouldn't cause any problem.  */
+		v850_reg_t dir = set_dir (0x100, 0x40);
+		/* Make sure it really got set.  */
+		if (dir & 0x100)
+			enabled = 1;
+	}
+	return enabled;
+}
+
+/* Try to set CHILD's single-step flag to VAL.  Returns true if successful.  */
+static int set_single_step (struct task_struct *t, int val)
+{
+	v850_reg_t *psw_addr = reg_save_addr(PT_PSW, t);
+	if (val) {
+		/* Make sure single-stepping is enabled.  */
+		if (! enable_single_stepping ())
+			return 0;
+		/* Set T's single-step flag.  */
+		*psw_addr |= 0x800;
+	} else
+		*psw_addr &= ~0x800;
+	return 1;
+}
+
 int sys_ptrace(long request, long pid, long addr, long data)
 {
 	struct task_struct *child;
@@ -36,12 +119,6 @@
 
 	lock_kernel();
 
-#if 0
-	printk("ptrace(r=%d,pid=%d,addr=%08lx,data=%08lx)\n",
-	       (int) request, (int) pid, (unsigned long) addr,
-	       (unsigned long) data);
-#endif
-
 	if (request == PTRACE_TRACEME) {
 		/* are we already being traced? */
 		if (current->ptrace & PT_PTRACED) {
@@ -81,31 +158,15 @@
 		goto out_tsk;
 
 	switch (request) {
-	case PTRACE_PEEKTEXT: /* read word at location addr. */ 
-	case PTRACE_PEEKDATA:{
-		unsigned long tmp;
-		int copied;
+		unsigned long val, copied;
 
-		copied = access_process_vm(child, addr, &tmp, sizeof(tmp), 0);
+	case PTRACE_PEEKTEXT: /* read word at location addr. */
+	case PTRACE_PEEKDATA:
+		copied = access_process_vm(child, addr, &val, sizeof(val), 0);
 		rval = -EIO;
-		if (copied != sizeof(tmp))
+		if (copied != sizeof(val))
 			break;
-		rval = put_user(tmp,(unsigned long *) data);
-
-		goto out;
-		}
-
-	/* Read the word at location addr in the USER area.  */
-	case PTRACE_PEEKUSR: 
-		if (addr >= 0 && addr < PT_SIZE && (addr & 0x3) == 0) {
-			struct pt_regs *regs = task_regs (child);
-			unsigned long val =
-				*(unsigned long *)((char *)regs + addr);
-			rval = put_user (val, (unsigned long *)data);
-		} else {
-			rval = 0;
-			rval = -EIO;			
-		}
+		rval = put_user(val, (unsigned long *)data);
 		goto out;
 
 	case PTRACE_POKETEXT: /* write the word at location addr. */
@@ -117,35 +178,62 @@
 		rval = -EIO;
 		goto out;
 
+	/* Read/write the word at location ADDR in the registers.  */
+	case PTRACE_PEEKUSR:
 	case PTRACE_POKEUSR:
-		if (addr >= 0 && addr < PT_SIZE && (addr & 0x3) == 0) {
-			struct pt_regs *regs = task_regs (child);
-			unsigned long *loc =
-				(unsigned long *)((char *)regs + addr);
-			*loc = data;
-		} else {
-			rval = 0;
-			rval = -EIO;			
-		}
+		rval = 0;
+		if (addr >= PT_SIZE && request == PTRACE_PEEKUSR) {
+			/* Special requests that don't actually correspond
+			   to offsets in struct pt_regs.  */
+			if (addr == PT_TEXT_ADDR)
+				val = child->mm->start_code;
+			else if (addr == PT_DATA_ADDR)
+				val = child->mm->start_data;
+			else if (addr == PT_TEXT_LEN)
+				val = child->mm->end_code
+					- child->mm->start_code;
+			else
+				rval = -EIO;
+		} else if (addr >= 0 && addr < PT_SIZE && (addr & 0x3) == 0) {
+			v850_reg_t *reg_addr = reg_save_addr(addr, child);
+			if (request == PTRACE_PEEKUSR)
+				val = *reg_addr;
+			else
+				*reg_addr = data;
+		} else
+			rval = -EIO;
+
+		if (rval == 0 && request == PTRACE_PEEKUSR)
+			rval = put_user (val, (unsigned long *)data);
 		goto out;
 
-	case PTRACE_SYSCALL: /* continue and stop at next (return from) syscall */
-	case PTRACE_CONT: /* rvaltart after signal. */
+	/* Continue and stop at next (return from) syscall */
+	case PTRACE_SYSCALL:
+	/* Restart after a signal.  */
+	case PTRACE_CONT:
+	/* Execute a single instruction. */
+	case PTRACE_SINGLESTEP:
 		rval = -EIO;
 		if ((unsigned long) data > _NSIG)
 			break;
+
+		/* Turn CHILD's single-step flag on or off.  */
+		if (! set_single_step (child, request == PTRACE_SINGLESTEP))
+			break;
+
 		if (request == PTRACE_SYSCALL)
 			set_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
 		else
 			clear_tsk_thread_flag(child, TIF_SYSCALL_TRACE);
+
 		child->exit_code = data;
 		wake_up_process(child);
 		rval = 0;
 		break;
 
 	/*
-	 * make the child exit.  Best I can do is send it a sigkill. 
-	 * perhaps it should be put in the status that it wants to 
+	 * make the child exit.  Best I can do is send it a sigkill.
+	 * perhaps it should be put in the status that it wants to
 	 * exit.
 	 */
 	case PTRACE_KILL:
@@ -157,6 +245,7 @@
 		break;
 
 	case PTRACE_DETACH: /* detach a process that was attached. */
+		set_single_step (child, 0);  /* Clear single-step flag */
 		rval = ptrace_detach(child, data);
 		break;
 
@@ -181,7 +270,7 @@
 	/* The 0x80 provides a way for the tracing parent to distinguish
 	   between a syscall stop and SIGTRAP delivery */
 	current->exit_code = SIGTRAP | ((current->ptrace & PT_TRACESYSGOOD)
-	                                ? 0x80 : 0);
+					? 0x80 : 0);
 	current->state = TASK_STOPPED;
 	notify_parent(current, SIGCHLD);
 	schedule();
diff -ruN -X../cludes linux-2.5.67-moo.orig/include/asm-v850/ptrace.h linux-2.5.67-moo/include/asm-v850/ptrace.h
--- linux-2.5.67-moo.orig/include/asm-v850/ptrace.h	2002-11-05 11:25:32.000000000 +0900
+++ linux-2.5.67-moo/include/asm-v850/ptrace.h	2003-04-08 10:39:42.000000000 +0900
@@ -1,8 +1,8 @@
 /*
  * include/asm-v850/ptrace.h -- Access to CPU registers
  *
- *  Copyright (C) 2001,02  NEC Corporation
- *  Copyright (C) 2001,02  Miles Bader <miles@gnu.org>
+ *  Copyright (C) 2001,02,03  NEC Corporation
+ *  Copyright (C) 2001,02,03  Miles Bader <miles@gnu.org>
  *
  * This file is subject to the terms and conditions of the GNU General
  * Public License.  See the file COPYING in the main directory of this
@@ -102,10 +102,19 @@
 #define PT_CTBP		((NUM_GPRS + 4) * _PT_REG_SIZE)
 #define PT_KERNEL_MODE	((NUM_GPRS + 5) * _PT_REG_SIZE)
 
-#define PT_SYSCALL	PT_GPR(0)
+/* Where the current syscall number is stashed; obviously only valid in
+   the kernel!  */
+#define PT_CUR_SYSCALL	PT_GPR(0)
 
 /* Size of struct pt_regs, including alignment.  */
 #define PT_SIZE		((NUM_GPRS + 6) * _PT_REG_SIZE)
 
 
+/* These are `magic' values for PTRACE_PEEKUSR that return info about where
+   a process is located in memory.  */
+#define PT_TEXT_ADDR	(PT_SIZE + 1)
+#define PT_TEXT_LEN	(PT_SIZE + 2)
+#define PT_DATA_ADDR	(PT_SIZE + 3)
+
+
 #endif /* __V850_PTRACE_H__ */
