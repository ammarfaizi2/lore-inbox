Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262303AbTEFC6T (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 May 2003 22:58:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262301AbTEFC5j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 May 2003 22:57:39 -0400
Received: from TYO201.gate.nec.co.jp ([202.32.8.214]:16001 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id S262275AbTEFC5F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 May 2003 22:57:05 -0400
To: Linus Torvalds <torvalds@transmeta.com>
Subject: [PATCH][v850]  Add v850 support for hardware single-step (via ptrace)
Cc: linux-kernel@vger.kernel.org
Reply-To: Miles Bader <miles@gnu.org>
Message-Id: <20030506030924.998113779@mcspd15.ucom.lsi.nec.co.jp>
Date: Tue,  6 May 2003 12:09:24 +0900 (JST)
From: miles@lsi.nec.co.jp (Miles Bader)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/entry.S linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/entry.S
--- linux-2.5.69-uc0/arch/v850/kernel/entry.S	2003-04-21 10:52:40.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/entry.S	2003-05-06 10:40:26.000000000 +0900
@@ -234,25 +235,30 @@
 	sst.w	syscall_num, PTO+PT_CUR_SYSCALL[ep]
 
 
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
@@ -390,33 +408,34 @@
 	ld.w	TI_FLAGS[r18], r19;					      \
 	andi	_TIF_NEED_RESCHED, r19, r0;				      \
 	bnz	3f;			/* Call the scheduler.  */	      \
-	andi	_TIF_SIGPENDING, r19, r0;				      \
-	bnz	4f;			/* Signals to handle, handle them */  \
+5:	andi	_TIF_SIGPENDING, r19, r18;				      \
+	ld.w	TASK_PTRACE[CURRENT_TASK], r19; /* ptrace flags */	      \
+	or	r18, r19;		/* see if either is non-zero */	      \
+	bnz	4f;			/* if so, handle them */	      \
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
 
 
@@ -668,22 +684,50 @@
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
 
 
@@ -725,9 +769,93 @@
 
 
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
diff -ruN -X../cludes linux-2.5.69-uc0/arch/v850/kernel/ptrace.c linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/ptrace.c
--- linux-2.5.69-uc0/arch/v850/kernel/ptrace.c	2002-11-05 11:25:22.000000000 +0900
+++ linux-2.5.69-uc0-v850-20030506/arch/v850/kernel/ptrace.c	2003-05-06 10:40:26.000000000 +0900
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
