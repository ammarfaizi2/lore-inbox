Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261515AbULYO4k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261515AbULYO4k (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 09:56:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261518AbULYO4j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 09:56:39 -0500
Received: from mail-relay-3.tiscali.it ([213.205.33.43]:36253 "EHLO
	mail-relay-3.tiscali.it") by vger.kernel.org with ESMTP
	id S261515AbULYOyI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 09:54:08 -0500
Date: Sat, 25 Dec 2004 15:53:21 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Linus Torvalds <torvalds@osdl.org>
Cc: "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org,
       tglx@linutronix.de, akpm@osdl.org
Subject: VM fixes [->used_math to PF_USED_MATH] [6/4]
Message-ID: <20041225145321.GU13747@dualathlon.random>
References: <20041224174156.GE13747@dualathlon.random> <20041224100147.32ad4268.davem@davemloft.net> <20041224182219.GH13747@dualathlon.random> <Pine.LNX.4.58.0412241533170.2353@ppc970.osdl.org> <20041225022721.GR13747@dualathlon.random> <20041225032430.GT13747@dualathlon.random>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="4Ckj6UjgE2iN1+kY"
Content-Disposition: inline
In-Reply-To: <20041225032430.GT13747@dualathlon.random>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Sat, Dec 25, 2004 at 04:24:30AM +0100, Andrea Arcangeli wrote:
> Here it is the first part. This makes memdie a TIF_MEMDIE. It's

And here is the final incremental part converting ->used_math to
PF_USED_MATH.

All combined patches work for me. I'm not going to apply these last two
(5/4 and 6/4) to the stable suse tree though, I'll apply 5/4 and 6/4
only to the future ones based on 2.6.10+, since the ev4 race on
SMP/PREEMPT is not relevant for the suse tree (those last two patches
are a bit too big to take any risk for a _purerly_theoretical_ race on
ev4 + SMP or ev4 + PREEMPT ;). The PF_MEMDIE was instead a more pratical
race (Wli said he triggered it in practice too) and it was triggering on
all archs, not just on ev4 + SMP or evr + PREEMPT, that's fixed with
[1-4]/4.

The below headers are from the SUSE patch format. I attached the script
I use to generate those just in case somebody can find it useful. It's
quite generic and it avoids to destroy the patch headers every time. If
you use quilt probably you don't need it. mkpatch.py works pretty fast
in combination with patch -p1 -b or alternatively in combination with
emacs autofile save.

Merry Christmas and Happy new Year to everyone, I'll be on vacations
until 2 Jan, so if there's any problem with this stuff we'll talk about
it next year ;). I just attempted to finish it before leaving.

From: Andrea Arcangeli <andrea@suse.de>
Subject: Convert the unsafe signed (16bit) used_math to a safe and optimal PF_USED_MATH

... and declare oomkilladj as an int since it can be changed via /proc.

I might have broken arm, see the very first change in the patch to
asm-offsets.c, rest looks ok at first glance.

If you want used_math to return 0 or 1 (instead of 0 or PF_USED_MATH),
just s/!!// in the below patch and place !! in sched.h::*used_math()
accordingly after applying the patch, it should work just fine. Using !!
only when necessary as the below is optimal.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- x/arch/arm26/kernel/asm-offsets.c.~1~	2003-07-17 01:52:38.000000000 +0200
+++ x/arch/arm26/kernel/asm-offsets.c	2004-12-25 15:18:54.589979544 +0100
@@ -42,7 +42,6 @@
 
 int main(void)
 {
-  DEFINE(TSK_USED_MATH,		offsetof(struct task_struct, used_math));
   DEFINE(TSK_ACTIVE_MM,		offsetof(struct task_struct, active_mm));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
--- x/arch/arm26/kernel/process.c.~1~	2004-08-25 02:47:33.000000000 +0200
+++ x/arch/arm26/kernel/process.c	2004-12-25 15:18:54.591979240 +0100
@@ -296,7 +296,7 @@ void flush_thread(void)
 	memset(&tsk->thread.debug, 0, sizeof(struct debug_info));
 	memset(&thread->fpstate, 0, sizeof(union fp_state));
 
-	current->used_math = 0;
+	clear_used_math();
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -330,7 +330,7 @@ copy_thread(int nr, unsigned long clone_
 int dump_fpu (struct pt_regs *regs, struct user_fp *fp)
 {
 	struct thread_info *thread = current_thread_info();
-	int used_math = current->used_math;
+	int used_math = !!used_math();
 
 	if (used_math)
 		memcpy(fp, &thread->fpstate.soft, sizeof (*fp));
--- x/arch/arm26/kernel/ptrace.c.~1~	2004-12-04 08:56:19.000000000 +0100
+++ x/arch/arm26/kernel/ptrace.c	2004-12-25 15:18:54.592979088 +0100
@@ -540,7 +540,7 @@ static int ptrace_getfpregs(struct task_
  */
 static int ptrace_setfpregs(struct task_struct *tsk, void *ufp)
 {
-	tsk->used_math = 1;
+	set_stopped_child_used_math(tsk);
 	return copy_from_user(&tsk->thread_info->fpstate, ufp,
 			      sizeof(struct user_fp)) ? -EFAULT : 0;
 }
--- x/arch/i386/kernel/cpu/common.c.~1~	2004-12-04 08:54:53.000000000 +0100
+++ x/arch/i386/kernel/cpu/common.c	2004-12-25 15:18:54.593978936 +0100
@@ -580,6 +580,6 @@ void __init cpu_init (void)
 	 * Force FPU initialization:
 	 */
 	current_thread_info()->status = 0;
-	current->used_math = 0;
+	clear_used_math();
 	mxcsr_feature_mask_init();
 }
--- x/arch/i386/kernel/i387.c.~1~	2004-12-04 08:56:19.000000000 +0100
+++ x/arch/i386/kernel/i387.c	2004-12-25 15:18:54.594978784 +0100
@@ -60,7 +60,8 @@ void init_fpu(struct task_struct *tsk)
 		tsk->thread.i387.fsave.twd = 0xffffffffu;
 		tsk->thread.i387.fsave.fos = 0xffff0000u;
 	}
-	tsk->used_math = 1;
+	/* only the device not available exception or ptrace can call init_fpu */
+	set_stopped_child_used_math(tsk);
 }
 
 /*
@@ -330,13 +331,13 @@ static int save_i387_fxsave( struct _fps
 
 int save_i387( struct _fpstate __user *buf )
 {
-	if ( !current->used_math )
+	if ( !used_math() )
 		return 0;
 
 	/* This will cause a "finit" to be triggered by the next
 	 * attempted FPU operation by the 'current' process.
 	 */
-	current->used_math = 0;
+	clear_used_math();
 
 	if ( HAVE_HWFP ) {
 		if ( cpu_has_fxsr ) {
@@ -382,7 +383,7 @@ int restore_i387( struct _fpstate __user
 	} else {
 		err = restore_i387_soft( &current->thread.i387.soft, buf );
 	}
-	current->used_math = 1;
+	set_used_math();
 	return err;
 }
 
@@ -506,7 +507,7 @@ int dump_fpu( struct pt_regs *regs, stru
 	int fpvalid;
 	struct task_struct *tsk = current;
 
-	fpvalid = tsk->used_math;
+	fpvalid = !!used_math();
 	if ( fpvalid ) {
 		unlazy_fpu( tsk );
 		if ( cpu_has_fxsr ) {
@@ -521,7 +522,7 @@ int dump_fpu( struct pt_regs *regs, stru
 
 int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
 {
-	int fpvalid = tsk->used_math;
+	int fpvalid = !!tsk_used_math(tsk);
 
 	if (fpvalid) {
 		if (tsk == current)
@@ -536,7 +537,7 @@ int dump_task_fpu(struct task_struct *ts
 
 int dump_task_extended_fpu(struct task_struct *tsk, struct user_fxsr_struct *fpu)
 {
-	int fpvalid = tsk->used_math && cpu_has_fxsr;
+	int fpvalid = tsk_used_math(tsk) && cpu_has_fxsr;
 
 	if (fpvalid) {
 		if (tsk == current)
--- x/arch/i386/kernel/process.c.~1~	2004-12-04 08:56:19.000000000 +0100
+++ x/arch/i386/kernel/process.c	2004-12-25 15:18:54.596978480 +0100
@@ -333,7 +333,7 @@ void flush_thread(void)
 	 * Forget coprocessor state..
 	 */
 	clear_fpu(tsk);
-	tsk->used_math = 0;
+	clear_used_math();
 }
 
 void release_thread(struct task_struct *dead_task)
--- x/arch/i386/kernel/ptrace.c.~1~	2004-12-04 08:56:19.000000000 +0100
+++ x/arch/i386/kernel/ptrace.c	2004-12-25 15:18:54.597978328 +0100
@@ -491,7 +491,7 @@ asmlinkage int sys_ptrace(long request, 
 			break;
 		}
 		ret = 0;
-		if (!child->used_math)
+		if (!tsk_used_math(child))
 			init_fpu(child);
 		get_fpregs((struct user_i387_struct __user *)data, child);
 		break;
@@ -503,7 +503,7 @@ asmlinkage int sys_ptrace(long request, 
 			ret = -EIO;
 			break;
 		}
-		child->used_math = 1;
+		set_stopped_child_used_math(child);
 		set_fpregs(child, (struct user_i387_struct __user *)data);
 		ret = 0;
 		break;
@@ -515,7 +515,7 @@ asmlinkage int sys_ptrace(long request, 
 			ret = -EIO;
 			break;
 		}
-		if (!child->used_math)
+		if (!tsk_used_math(child))
 			init_fpu(child);
 		ret = get_fpxregs((struct user_fxsr_struct __user *)data, child);
 		break;
@@ -527,7 +527,7 @@ asmlinkage int sys_ptrace(long request, 
 			ret = -EIO;
 			break;
 		}
-		child->used_math = 1;
+		set_stopped_child_used_math(child);
 		ret = set_fpxregs(child, (struct user_fxsr_struct __user *)data);
 		break;
 	}
--- x/arch/i386/kernel/traps.c.~1~	2004-12-04 08:56:19.000000000 +0100
+++ x/arch/i386/kernel/traps.c	2004-12-25 15:18:54.598978176 +0100
@@ -920,7 +920,7 @@ asmlinkage void math_state_restore(struc
 	struct task_struct *tsk = thread->task;
 
 	clts();		/* Allow maths ops (or we recurse) */
-	if (!tsk->used_math)
+	if (!tsk_used_math(tsk))
 		init_fpu(tsk);
 	restore_fpu(tsk);
 	thread->status |= TS_USEDFPU;	/* So we fnsave on switch_to() */
--- x/arch/i386/math-emu/fpu_entry.c.~1~	2004-08-25 02:47:49.000000000 +0200
+++ x/arch/i386/math-emu/fpu_entry.c	2004-12-25 15:18:54.599978024 +0100
@@ -155,10 +155,10 @@ asmlinkage void math_emulate(long arg)
   RE_ENTRANT_CHECK_ON;
 #endif /* RE_ENTRANT_CHECKING */
 
-  if (!current->used_math)
+  if (!used_math())
     {
       finit();
-      current->used_math = 1;
+      set_used_math();
     }
 
   SETUP_DATA_AREA(arg);
--- x/arch/ia64/ia32/elfcore32.h.~1~	2004-12-04 08:56:19.000000000 +0100
+++ x/arch/ia64/ia32/elfcore32.h	2004-12-25 15:18:54.600977872 +0100
@@ -106,7 +106,7 @@ elf_core_copy_task_fpregs(struct task_st
 	struct ia32_user_i387_struct *fpstate = (void*)fpu;
 	mm_segment_t old_fs;
 
-	if (!tsk->used_math)
+	if (!tsk_used_math(tsk))
 		return 0;
 	
 	old_fs = get_fs();
@@ -124,7 +124,7 @@ elf_core_copy_task_xfpregs(struct task_s
 	struct ia32_user_fxsr_struct *fpxstate = (void*) xfpu;
 	mm_segment_t old_fs;
 
-	if (!tsk->used_math)
+	if (!tsk_used_math(tsk))
 		return 0;
 
 	old_fs = get_fs();
--- x/arch/mips/kernel/irixsig.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/mips/kernel/irixsig.c	2004-12-25 15:18:54.601977720 +0100
@@ -100,7 +100,7 @@ static void setup_irix_frame(struct k_si
 	__put_user((u64) regs->hi, &ctx->hi);
 	__put_user((u64) regs->lo, &ctx->lo);
 	__put_user((u64) regs->cp0_epc, &ctx->pc);
-	__put_user(current->used_math, &ctx->usedfp);
+	__put_user(!!used_math(), &ctx->usedfp);
 	__put_user((u64) regs->cp0_cause, &ctx->cp0_cause);
 	__put_user((u64) regs->cp0_badvaddr, &ctx->cp0_badvaddr);
 
@@ -728,7 +728,7 @@ asmlinkage int irix_getcontext(struct pt
 	__put_user(regs->cp0_epc, &ctx->regs[35]);
 
 	flags = 0x0f;
-	if(!current->used_math) {
+	if(!used_math()) {
 		flags &= ~(0x08);
 	} else {
 		/* XXX wheee... */
--- x/arch/mips/kernel/process.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/mips/kernel/process.c	2004-12-25 15:18:54.602977568 +0100
@@ -76,7 +76,7 @@ void start_thread(struct pt_regs * regs,
 #endif
 	status |= KU_USER;
 	regs->cp0_status = status;
-	current->used_math = 0;
+	clear_used_math();
 	lose_fpu();
 	regs->cp0_epc = pc;
 	regs->regs[29] = sp;
--- x/arch/mips/kernel/ptrace.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/mips/kernel/ptrace.c	2004-12-25 15:18:54.603977416 +0100
@@ -119,7 +119,7 @@ asmlinkage int sys_ptrace(long request, 
 			tmp = regs->regs[addr];
 			break;
 		case FPR_BASE ... FPR_BASE + 31:
-			if (child->used_math) {
+			if (tsk_used_math(child)) {
 				fpureg_t *fregs = get_fpu_regs(child);
 
 #ifdef CONFIG_MIPS32
@@ -205,7 +205,7 @@ asmlinkage int sys_ptrace(long request, 
 		case FPR_BASE ... FPR_BASE + 31: {
 			fpureg_t *fregs = get_fpu_regs(child);
 
-			if (!child->used_math) {
+			if (!tsk_used_math(child)) {
 				/* FP not yet used  */
 				memset(&child->thread.fpu.hard, ~0,
 				       sizeof(child->thread.fpu.hard));
--- x/arch/mips/kernel/ptrace32.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/mips/kernel/ptrace32.c	2004-12-25 15:18:54.604977264 +0100
@@ -112,7 +112,7 @@ asmlinkage int sys32_ptrace(int request,
 			tmp = regs->regs[addr];
 			break;
 		case FPR_BASE ... FPR_BASE + 31:
-			if (child->used_math) {
+			if (tsk_used_math(child)) {
 				fpureg_t *fregs = get_fpu_regs(child);
 
 				/*
@@ -193,7 +193,7 @@ asmlinkage int sys32_ptrace(int request,
 		case FPR_BASE ... FPR_BASE + 31: {
 			fpureg_t *fregs = get_fpu_regs(child);
 
-			if (!child->used_math) {
+			if (!tsk_used_math(child)) {
 				/* FP not yet used  */
 				memset(&child->thread.fpu.hard, ~0,
 				       sizeof(child->thread.fpu.hard));
--- x/arch/mips/kernel/signal.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/mips/kernel/signal.c	2004-12-25 15:18:54.605977112 +0100
@@ -179,11 +179,11 @@ asmlinkage int restore_sigcontext(struct
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(current->used_math, &sc->sc_used_math);
+	err |= __get_user(!!used_math(), &sc->sc_used_math);
 
 	preempt_disable();
 
-	if (current->used_math) {
+	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
 		err |= restore_fp_context(sc);
@@ -324,9 +324,9 @@ inline int setup_sigcontext(struct pt_re
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	err |= __put_user(current->used_math, &sc->sc_used_math);
+	err |= __put_user(!!used_math(), &sc->sc_used_math);
 
-	if (!current->used_math)
+	if (!used_math())
 		goto out;
 
 	/*
--- x/arch/mips/kernel/signal32.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/mips/kernel/signal32.c	2004-12-25 15:18:54.606976960 +0100
@@ -361,11 +361,11 @@ static asmlinkage int restore_sigcontext
 	restore_gp_reg(31);
 #undef restore_gp_reg
 
-	err |= __get_user(current->used_math, &sc->sc_used_math);
+	err |= __get_user(!!used_math(), &sc->sc_used_math);
 
 	preempt_disable();
 
-	if (current->used_math) {
+	if (used_math()) {
 		/* restore fpu context if we have used it before */
 		own_fpu();
 		err |= restore_fp_context32(sc);
@@ -552,9 +552,9 @@ static inline int setup_sigcontext32(str
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	err |= __put_user(current->used_math, &sc->sc_used_math);
+	err |= __put_user(!!used_math(), &sc->sc_used_math);
 
-	if (!current->used_math)
+	if (!used_math())
 		goto out;
 
 	/* 
--- x/arch/mips/kernel/traps.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/mips/kernel/traps.c	2004-12-25 15:18:54.608976656 +0100
@@ -655,11 +655,11 @@ asmlinkage void do_cpu(struct pt_regs *r
 		preempt_disable();
 
 		own_fpu();
-		if (current->used_math) {	/* Using the FPU again.  */
+		if (used_math()) {	/* Using the FPU again.  */
 			restore_fp(current);
 		} else {			/* First time FPU user.  */
 			init_fpu();
-			current->used_math = 1;
+			set_used_math();
 		}
 
 		if (!cpu_has_fpu) {
--- x/arch/s390/kernel/process.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/s390/kernel/process.c	2004-12-25 15:18:54.609976504 +0100
@@ -216,8 +216,7 @@ void exit_thread(void)
 
 void flush_thread(void)
 {
-
-        current->used_math = 0;
+	clear_used_math();
 	clear_tsk_thread_flag(current, TIF_USEDFPU);
 }
 
--- x/arch/s390/kernel/setup.c.~1~	2004-12-04 08:54:54.000000000 +0100
+++ x/arch/s390/kernel/setup.c	2004-12-25 15:18:54.610976352 +0100
@@ -96,7 +96,7 @@ void __devinit cpu_init (void)
          * Force FPU initialization:
          */
         clear_thread_flag(TIF_USEDFPU);
-        current->used_math = 0;
+        clear_used_math();
 
         /* Setup active_mm for idle_task  */
         atomic_inc(&init_mm.mm_count);
--- x/arch/sh/kernel/cpu/sh4/fpu.c.~1~	2004-02-20 17:26:36.000000000 +0100
+++ x/arch/sh/kernel/cpu/sh4/fpu.c	2004-12-25 15:18:54.611976200 +0100
@@ -323,13 +323,13 @@ do_fpu_state_restore(unsigned long r4, u
 		return;
 	}
 
-	if (tsk->used_math) {
+	if (used_math()) {
 		/* Using the FPU again.  */
 		restore_fpu(tsk);
 	} else	{
 		/* First time FPU user.  */
 		fpu_init();
-		tsk->used_math = 1;
+		set_used_math();
 	}
 	set_tsk_thread_flag(tsk, TIF_USEDFPU);
 }
--- x/arch/sh/kernel/cpu/init.c.~1~	2004-12-04 08:56:20.000000000 +0100
+++ x/arch/sh/kernel/cpu/init.c	2004-12-25 15:18:54.611976200 +0100
@@ -194,7 +194,7 @@ asmlinkage void __init sh_cpu_init(void)
 	/* FPU initialization */
 	if ((cpu_data->flags & CPU_HAS_FPU)) {
 		clear_thread_flag(TIF_USEDFPU);
-		current->used_math = 0;
+		clear_used_math();
 	}
 
 #ifdef CONFIG_SH_DSP
--- x/arch/sh/kernel/process.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/sh/kernel/process.c	2004-12-25 15:18:54.612976048 +0100
@@ -208,7 +208,7 @@ void flush_thread(void)
 
 	/* Forget lazy FPU state */
 	clear_fpu(tsk, regs);
-	tsk->used_math = 0;
+	clear_used_math();
 #endif
 }
 
@@ -225,7 +225,7 @@ int dump_fpu(struct pt_regs *regs, elf_f
 #if defined(CONFIG_SH_FPU)
 	struct task_struct *tsk = current;
 
-	fpvalid = tsk->used_math;
+	fpvalid = !!tsk_used_math(tsk);
 	if (fpvalid) {
 		unlazy_fpu(tsk, regs);
 		memcpy(fpu, &tsk->thread.fpu.hard, sizeof(*fpu));
@@ -260,7 +260,7 @@ dump_task_fpu (struct task_struct *tsk, 
 	int fpvalid = 0;
 
 #if defined(CONFIG_SH_FPU)
-	fpvalid = tsk->used_math;
+	fpvalid = !!tsk_used_math(tsk);
 	if (fpvalid) {
 		struct pt_regs *regs = (struct pt_regs *)
 					((unsigned long)tsk->thread_info
@@ -286,7 +286,7 @@ int copy_thread(int nr, unsigned long cl
 
 	unlazy_fpu(tsk, regs);
 	p->thread.fpu = tsk->thread.fpu;
-	p->used_math = tsk->used_math;
+	copy_to_stopped_child_used_math(p);
 #endif
 
 	childregs = ((struct pt_regs *)
--- x/arch/sh/kernel/ptrace.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/sh/kernel/ptrace.c	2004-12-25 15:18:54.613975896 +0100
@@ -150,7 +150,7 @@ asmlinkage int sys_ptrace(long request, 
 			tmp = get_stack_long(child, addr);
 		else if (addr >= (long) &dummy->fpu &&
 			 addr < (long) &dummy->u_fpvalid) {
-			if (!child->used_math) {
+			if (!tsk_used_math(child)) {
 				if (addr == (long)&dummy->fpu.fpscr)
 					tmp = FPSCR_INIT;
 				else
@@ -159,7 +159,7 @@ asmlinkage int sys_ptrace(long request, 
 				tmp = ((long *)&child->thread.fpu)
 					[(addr - (long)&dummy->fpu) >> 2];
 		} else if (addr == (long) &dummy->u_fpvalid)
-			tmp = child->used_math;
+			tmp = !!tsk_used_math(child);
 		else
 			tmp = 0;
 		ret = put_user(tmp, (unsigned long *)data);
@@ -185,12 +185,12 @@ asmlinkage int sys_ptrace(long request, 
 			ret = put_stack_long(child, addr, data);
 		else if (addr >= (long) &dummy->fpu &&
 			 addr < (long) &dummy->u_fpvalid) {
-			child->used_math = 1;
+			set_stopped_child_used_math(child);
 			((long *)&child->thread.fpu)
 				[(addr - (long)&dummy->fpu) >> 2] = data;
 			ret = 0;
 		} else if (addr == (long) &dummy->u_fpvalid) {
-			child->used_math = data?1:0;
+			conditional_stopped_child_used_math(data, child);
 			ret = 0;
 		}
 		break;
--- x/arch/sh/kernel/signal.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/sh/kernel/signal.c	2004-12-25 15:18:54.614975744 +0100
@@ -163,7 +163,7 @@ static inline int restore_sigcontext_fpu
 	if (!(cpu_data->flags & CPU_HAS_FPU))
 		return 0;
 
-	tsk->used_math = 1;
+	set_used_math();
 	return __copy_from_user(&tsk->thread.fpu.hard, &sc->sc_fpregs[0],
 				sizeof(long)*(16*2+2));
 }
@@ -176,7 +176,7 @@ static inline int save_sigcontext_fpu(st
 	if (!(cpu_data->flags & CPU_HAS_FPU))
 		return 0;
 
-	if (!tsk->used_math) {
+	if (!used_math()) {
 		__put_user(0, &sc->sc_ownedfp);
 		return 0;
 	}
@@ -186,7 +186,7 @@ static inline int save_sigcontext_fpu(st
 	/* This will cause a "finit" to be triggered by the next
 	   attempted FPU operation by the 'current' process.
 	   */
-	tsk->used_math = 0;
+	clear_used_math();
 
 	unlazy_fpu(tsk, regs);
 	return __copy_to_user(&sc->sc_fpregs[0], &tsk->thread.fpu.hard,
@@ -220,7 +220,7 @@ restore_sigcontext(struct pt_regs *regs,
 
 		regs->sr |= SR_FD; /* Release FPU */
 		clear_fpu(tsk, regs);
-		tsk->used_math = 0;
+		clear_used_math();
 		__get_user (owned_fp, &sc->sc_ownedfp);
 		if (owned_fp)
 			err |= restore_sigcontext_fpu(sc);
--- x/arch/sh64/kernel/fpu.c.~1~	2004-08-25 02:47:49.000000000 +0200
+++ x/arch/sh64/kernel/fpu.c	2004-12-25 15:18:54.615975592 +0100
@@ -158,12 +158,12 @@ do_fpu_state_restore(unsigned long ex, s
 		fpsave(&last_task_used_math->thread.fpu.hard);
         }
         last_task_used_math = current;
-        if (current->used_math) {
+        if (used_math()) {
                 fpload(&current->thread.fpu.hard);
         } else {
 		/* First time FPU user.  */
 		fpload(&init_fpuregs.hard);
-                current->used_math = 1;
+                set_used_math();
         }
 	release_fpu();
 }
--- x/arch/sh64/kernel/process.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/sh64/kernel/process.c	2004-12-25 15:18:54.616975440 +0100
@@ -688,7 +688,7 @@ void flush_thread(void)
 		last_task_used_math = NULL;
 	}
 	/* Force FPU state to be reinitialised after exec */
-	current->used_math = 0;
+	clear_used_math();
 #endif
 
 	/* if we are a kernel thread, about to change to user thread,
@@ -713,7 +713,7 @@ int dump_fpu(struct pt_regs *regs, elf_f
 	int fpvalid;
 	struct task_struct *tsk = current;
 
-	fpvalid = tsk->used_math;
+	fpvalid = !!tsk_used_math(tsk);
 	if (fpvalid) {
 		if (current == last_task_used_math) {
 			grab_fpu();
--- x/arch/sh64/kernel/ptrace.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/sh64/kernel/ptrace.c	2004-12-25 15:18:54.617975288 +0100
@@ -63,7 +63,7 @@ get_fpu_long(struct task_struct *task, u
 	struct pt_regs *regs;
 	regs = (struct pt_regs*)((unsigned char *)task + THREAD_SIZE) - 1;
 
-	if (!task->used_math) {
+	if (!tsk_used_math(task)) {
 		if (addr == offsetof(struct user_fpu_struct, fpscr)) {
 			tmp = FPSCR_INIT;
 		} else {
@@ -105,9 +105,9 @@ put_fpu_long(struct task_struct *task, u
 
 	regs = (struct pt_regs*)((unsigned char *)task + THREAD_SIZE) - 1;
 
-	if (!task->used_math) {
+	if (!tsk_used_math(task)) {
 		fpinit(&task->thread.fpu.hard);
-		task->used_math = 1;
+		set_stopped_child_used_math(task);
 	} else if (last_task_used_math == task) {
 		grab_fpu();
 		fpsave(&task->thread.fpu.hard);
@@ -187,7 +187,7 @@ asmlinkage int sys_ptrace(long request, 
 			 (addr <  offsetof(struct user, u_fpvalid))) {
 			tmp = get_fpu_long(child, addr - offsetof(struct user, fpu));
 		} else if (addr == offsetof(struct user, u_fpvalid)) {
-			tmp = child->used_math;
+			tmp = !!tsk_used_math(child);
 		} else {
 			break;
 		}
--- x/arch/sh64/kernel/signal.c.~1~	2004-12-04 08:54:54.000000000 +0100
+++ x/arch/sh64/kernel/signal.c	2004-12-25 15:18:54.618975136 +0100
@@ -186,7 +186,7 @@ restore_sigcontext_fpu(struct pt_regs *r
 	int fpvalid;
 
 	err |= __get_user (fpvalid, &sc->sc_fpvalid);
-	current->used_math = fpvalid;
+	conditional_used_math(fpvalid);
 	if (! fpvalid)
 		return err;
 
@@ -207,7 +207,7 @@ setup_sigcontext_fpu(struct pt_regs *reg
 	int err = 0;
 	int fpvalid;
 
-	fpvalid = current->used_math;
+	fpvalid = !!used_math();
 	err |= __put_user(fpvalid, &sc->sc_fpvalid);
 	if (! fpvalid)
 		return err;
@@ -222,7 +222,7 @@ setup_sigcontext_fpu(struct pt_regs *reg
 
 	err |= __copy_to_user(&sc->sc_fpregs[0], &current->thread.fpu.hard,
 			      (sizeof(long long) * 32) + (sizeof(int) * 1));
-	current->used_math = 0;
+	clear_used_math();
 
 	return err;
 }
--- x/arch/sparc/kernel/process.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/sparc/kernel/process.c	2004-12-25 15:18:54.619974984 +0100
@@ -602,7 +602,7 @@ void dump_thread(struct pt_regs * regs, 
  */
 int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs)
 {
-	if (current->used_math == 0) {
+	if (used_math()) {
 		memset(fpregs, 0, sizeof(*fpregs));
 		fpregs->pr_q_entrysize = 8;
 		return 1;
--- x/arch/sparc/kernel/signal.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/sparc/kernel/signal.c	2004-12-25 15:18:54.621974680 +0100
@@ -202,7 +202,7 @@ restore_fpu_state(struct pt_regs *regs, 
 		regs->psr &= ~PSR_EF;
 	}
 #endif
-	current->used_math = 1;
+	set_used_math();
 	clear_tsk_thread_flag(current, TIF_USEDFPU);
 
 	if (verify_area(VERIFY_READ, fpu, sizeof(*fpu)))
@@ -584,7 +584,7 @@ save_fpu_state(struct pt_regs *regs, __s
 				      &current->thread.fpqueue[0],
 				      ((sizeof(unsigned long) +
 				      (sizeof(unsigned long *)))*16));
-	current->used_math = 0;
+	clear_used_math();
 	return err;
 }
 
@@ -599,7 +599,7 @@ new_setup_frame(struct k_sigaction *ka, 
 	synchronize_user_stack();
 
 	sigframe_size = NF_ALIGNEDSZ;
-	if (!current->used_math)
+	if (!used_math())
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 
 	sf = (struct new_signal_frame __user *)
@@ -616,7 +616,7 @@ new_setup_frame(struct k_sigaction *ka, 
 	
 	err |= __put_user(0, &sf->extra_size);
 
-	if (current->used_math) {
+	if (used_math()) {
 		err |= save_fpu_state(regs, &sf->fpu_state);
 		err |= __put_user(&sf->fpu_state, &sf->fpu_save);
 	} else {
@@ -677,7 +677,7 @@ new_setup_rt_frame(struct k_sigaction *k
 
 	synchronize_user_stack();
 	sigframe_size = RT_ALIGNEDSZ;
-	if (!current->used_math)
+	if (!used_math())
 		sigframe_size -= sizeof(__siginfo_fpu_t);
 	sf = (struct rt_signal_frame __user *)
 		get_sigframe(&ka->sa, regs, sigframe_size);
@@ -690,7 +690,7 @@ new_setup_rt_frame(struct k_sigaction *k
 	err |= __put_user(regs->npc, &sf->regs.npc);
 	err |= __put_user(regs->y, &sf->regs.y);
 	psr = regs->psr;
-	if (current->used_math)
+	if (used_math())
 		psr |= PSR_EF;
 	err |= __put_user(psr, &sf->regs.psr);
 	err |= __copy_to_user(&sf->regs.u_regs, regs->u_regs, sizeof(regs->u_regs));
--- x/arch/sparc/kernel/traps.c.~1~	2004-08-25 02:47:49.000000000 +0200
+++ x/arch/sparc/kernel/traps.c	2004-12-25 15:18:54.622974528 +0100
@@ -246,17 +246,17 @@ void do_fpd_trap(struct pt_regs *regs, u
 		       &fptask->thread.fpqueue[0], &fptask->thread.fpqdepth);
 	}
 	last_task_used_math = current;
-	if(current->used_math) {
+	if(used_math()) {
 		fpload(&current->thread.float_regs[0], &current->thread.fsr);
 	} else {
 		/* Set initial sane state. */
 		fpload(&init_fregs[0], &init_fsr);
-		current->used_math = 1;
+		set_used_math();
 	}
 #else
-	if(!current->used_math) {
+	if(!used_math()) {
 		fpload(&init_fregs[0], &init_fsr);
-		current->used_math = 1;
+		set_used_math();
 	} else {
 		fpload(&current->thread.float_regs[0], &current->thread.fsr);
 	}
--- x/arch/x86_64/ia32/fpu32.c.~1~	2004-08-25 02:47:33.000000000 +0200
+++ x/arch/x86_64/ia32/fpu32.c	2004-12-25 15:18:54.623974376 +0100
@@ -156,7 +156,7 @@ int restore_i387_ia32(struct task_struct
 				     sizeof(struct i387_fxsave_struct)))
 			return -1;
 		tsk->thread.i387.fxsave.mxcsr &= mxcsr_feature_mask;
-		tsk->used_math = 1;
+		set_stopped_child_used_math(tsk);
 	} 
 	return convert_fxsr_from_user(&tsk->thread.i387.fxsave, buf);
 }  
--- x/arch/x86_64/ia32/ia32_binfmt.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/x86_64/ia32/ia32_binfmt.c	2004-12-25 15:18:54.624974224 +0100
@@ -214,7 +214,7 @@ elf_core_copy_task_fpregs(struct task_st
 	struct _fpstate_ia32 *fpstate = (void*)fpu; 
 	mm_segment_t oldfs = get_fs();
 
-	if (!tsk->used_math) 
+	if (!tsk_used_math(tsk)) 
 		return 0;
 	if (!regs)
 		regs = (struct pt_regs *)tsk->thread.rsp0;
@@ -235,7 +235,7 @@ static inline int 
 elf_core_copy_task_xfpregs(struct task_struct *t, elf_fpxregset_t *xfpu)
 {
 	struct pt_regs *regs = ((struct pt_regs *)(t->thread.rsp0))-1; 
-	if (!t->used_math) 
+	if (!tsk_used_math(t)) 
 		return 0;
 	if (t == current)
 		unlazy_fpu(t); 
--- x/arch/x86_64/ia32/ia32_signal.c.~1~	2004-12-04 08:54:54.000000000 +0100
+++ x/arch/x86_64/ia32/ia32_signal.c	2004-12-25 15:18:54.625974072 +0100
@@ -383,7 +383,7 @@ ia32_setup_sigcontext(struct sigcontext_
 	if (tmp < 0)
 	  err = -EFAULT;
 	else { 
-		current->used_math = 0;
+		clear_used_math();
 		stts();
 	  err |= __put_user((u32)(u64)(tmp ? fpstate : NULL), &sc->fpstate);
 	}
--- x/arch/x86_64/ia32/ptrace32.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/x86_64/ia32/ptrace32.c	2004-12-25 15:18:54.625974072 +0100
@@ -358,7 +358,7 @@ asmlinkage long sys32_ptrace(long reques
 			break;
 		/* no checking to be bug-to-bug compatible with i386 */
 		__copy_from_user(&child->thread.i387.fxsave, u, sizeof(*u));
-		child->used_math = 1;
+		set_stopped_child_used_math(child);
 		child->thread.i387.fxsave.mxcsr &= mxcsr_feature_mask;
 		ret = 0; 
 		break;
--- x/arch/x86_64/kernel/i387.c.~1~	2004-08-25 02:47:33.000000000 +0200
+++ x/arch/x86_64/kernel/i387.c	2004-12-25 15:18:54.626973920 +0100
@@ -57,12 +57,12 @@ void __init fpu_init(void)
 	mxcsr_feature_mask_init();
 	/* clean state in init */
 	current_thread_info()->status = 0;
-	current->used_math = 0;
+	clear_used_math();
 }
 
 void init_fpu(struct task_struct *child)
 {
-	if (child->used_math) { 
+	if (tsk_used_math(child)) { 
 		if (child == current)
 			unlazy_fpu(child);
 		return;
@@ -70,7 +70,8 @@ void init_fpu(struct task_struct *child)
 	memset(&child->thread.i387.fxsave, 0, sizeof(struct i387_fxsave_struct));
 	child->thread.i387.fxsave.cwd = 0x37f;
 	child->thread.i387.fxsave.mxcsr = 0x1f80;
-	child->used_math = 1;
+	/* only the device not available exception or ptrace can call init_fpu */
+	set_stopped_child_used_math(child);
 }
 
 /*
@@ -91,9 +92,9 @@ int save_i387(struct _fpstate __user *bu
 	if ((unsigned long)buf % 16) 
 		printk("save_i387: bad fpstate %p\n",buf); 
 
-	if (!tsk->used_math) 
+	if (!used_math()) 
 		return 0;
-	tsk->used_math = 0; /* trigger finit */ 
+	clear_used_math(); /* trigger finit */ 
 	if (tsk->thread_info->status & TS_USEDFPU) {
 		err = save_i387_checking((struct i387_fxsave_struct __user *)buf);
 		if (err) return err;
@@ -133,7 +134,7 @@ int dump_fpu( struct pt_regs *regs, stru
 {
 	struct task_struct *tsk = current;
 
-	if (!tsk->used_math) 
+	if (!used_math()) 
 		return 0;
 
 	unlazy_fpu(tsk);
@@ -143,7 +144,7 @@ int dump_fpu( struct pt_regs *regs, stru
 
 int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
 {
-	int fpvalid = tsk->used_math;
+	int fpvalid = !!tsk_used_math(tsk);
 
 	if (fpvalid) {
 		if (tsk == current)
--- x/arch/x86_64/kernel/process.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/x86_64/kernel/process.c	2004-12-25 15:18:54.627973768 +0100
@@ -297,7 +297,7 @@ void flush_thread(void)
 	 * Forget coprocessor state..
 	 */
 	clear_fpu(tsk);
-	tsk->used_math = 0;
+	clear_used_math();
 }
 
 void release_thread(struct task_struct *dead_task)
--- x/arch/x86_64/kernel/ptrace.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/x86_64/kernel/ptrace.c	2004-12-25 15:18:54.628973616 +0100
@@ -480,7 +480,7 @@ asmlinkage long sys_ptrace(long request,
 			ret = -EIO;
 			break;
 		}
-		child->used_math = 1;
+		set_stopped_child_used_math(child);
 		ret = set_fpregs(child, (struct user_i387_struct __user *)data);
 		break;
 	}
--- x/arch/x86_64/kernel/signal.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/x86_64/kernel/signal.c	2004-12-25 15:18:54.629973464 +0100
@@ -246,7 +246,7 @@ static void setup_rt_frame(int sig, stru
 	int err = 0;
 	struct task_struct *me = current;
 
-	if (me->used_math) {
+	if (used_math()) {
 		fp = get_stack(ka, regs, sizeof(struct _fpstate)); 
 		frame = (void __user *)round_down((unsigned long)fp - sizeof(struct rt_sigframe), 16) - 8;
 
--- x/arch/x86_64/kernel/traps.c.~1~	2004-12-04 08:56:21.000000000 +0100
+++ x/arch/x86_64/kernel/traps.c	2004-12-25 15:18:54.630973312 +0100
@@ -894,7 +894,7 @@ asmlinkage void math_state_restore(void)
 	struct task_struct *me = current;
 	clts();			/* Allow maths ops (or we recurse) */
 
-	if (!me->used_math)
+	if (!used_math())
 		init_fpu(me);
 	restore_fpu_checking(&me->thread.i387.fxsave);
 	me->thread_info->status |= TS_USEDFPU;
--- x/arch/m32r/kernel/ptrace.c.~1~	2004-12-04 08:56:19.000000000 +0100
+++ x/arch/m32r/kernel/ptrace.c	2004-12-25 15:22:37.271126864 +0100
@@ -130,7 +130,7 @@ static int ptrace_read_user(struct task_
 #ifndef NO_FPU
 		else if (off >= (long)(&dummy->fpu >> 2) &&
 			 off < (long)(&dummy->u_fpvalid >> 2)) {
-			if (!tsk->used_math) {
+			if (!tsk_used_math(tsk)) {
 				if (off == (long)(&dummy->fpu.fpscr >> 2))
 					tmp = FPSCR_INIT;
 				else
@@ -139,7 +139,7 @@ static int ptrace_read_user(struct task_
 				tmp = ((long *)(&tsk->thread.fpu >> 2))
 					[off - (long)&dummy->fpu];
 		} else if (off == (long)(&dummy->u_fpvalid >> 2))
-			tmp = tsk->used_math;
+			tmp = !!tsk_used_math(tsk);
 #endif /* not NO_FPU */
 		else
 			tmp = 0;
@@ -187,12 +187,12 @@ static int ptrace_write_user(struct task
 #ifndef NO_FPU
 		else if (off >= (long)(&dummy->fpu >> 2) &&
 			 off < (long)(&dummy->u_fpvalid >> 2)) {
-			tsk->used_math = 1;
+			set_stopped_child_used_math(tsk);
 			((long *)&tsk->thread.fpu)
 				[off - (long)&dummy->fpu] = data;
 			ret = 0;
 		} else if (off == (long)(&dummy->u_fpvalid >> 2)) {
-			tsk->used_math = data ? 1 : 0;
+			conditional_stopped_child_used_math(data, tsk);
 			ret = 0;
 		}
 #endif /* not NO_FPU */
--- x/arch/m32r/kernel/setup.c.~1~	2004-12-04 08:54:53.000000000 +0100
+++ x/arch/m32r/kernel/setup.c	2004-12-25 15:18:54.632973008 +0100
@@ -389,7 +389,7 @@ void __init cpu_init (void)
 
 	/* Force FPU initialization */
 	current_thread_info()->status = 0;
-	current->used_math = 0;
+	clear_used_math();
 
 #ifdef CONFIG_MMU
 	/* Set up MMU */
--- x/include/asm-arm26/constants.h.~1~	2003-06-08 18:21:42.000000000 +0200
+++ x/include/asm-arm26/constants.h	2004-12-25 15:18:54.633972856 +0100
@@ -7,7 +7,6 @@
  *
  */
 
-#define TSK_USED_MATH 788 /* offsetof(struct task_struct, used_math) */
 #define TSK_ACTIVE_MM 96 /* offsetof(struct task_struct, active_mm) */
 
 #define VMA_VM_MM 0 /* offsetof(struct vm_area_struct, vm_mm) */
--- x/include/asm-x86_64/i387.h.~1~	2004-12-04 08:55:04.000000000 +0100
+++ x/include/asm-x86_64/i387.h	2004-12-25 15:18:54.633972856 +0100
@@ -25,16 +25,6 @@ extern void mxcsr_feature_mask_init(void
 extern void init_fpu(struct task_struct *child);
 extern int save_i387(struct _fpstate __user *buf);
 
-static inline int need_signal_i387(struct task_struct *me) 
-{ 
-	if (!me->used_math)
-		return 0;
-	me->used_math = 0; 
-	if (me->thread_info->status & TS_USEDFPU)
-		return 0;
-	return 1;
-} 
-
 /*
  * FPU lazy state save handling...
  */
--- x/include/linux/sched.h.~1~	2004-12-25 03:59:16.000000000 +0100
+++ x/include/linux/sched.h	2004-12-25 15:18:54.635972552 +0100
@@ -600,19 +600,7 @@ struct task_struct {
 	struct key *process_keyring;	/* keyring private to this process (CLONE_THREAD) */
 	struct key *thread_keyring;	/* keyring private to this thread */
 #endif
-/*
- * Must be changed atomically so it shouldn't be
- * be a shareable bitflag.
- */
-	unsigned char used_math;
-/*
- * OOM kill score adjustment (bit shift).
- * Cannot live together with used_math since
- * used_math and oomkilladj can be changed at the
- * same time, so they would race if they're in the
- * same atomic block.
- */
-	short oomkilladj;
+	int oomkilladj; /* OOM kill score adjustment (bit shift). */
 	char comm[16];
 /* file system info */
 	int link_count, total_link_count;
@@ -674,7 +662,7 @@ struct task_struct {
 	wait_queue_t *io_wait;
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
-  	short il_next;		/* could be shared with used_math */
+  	short il_next;
 #endif
 };
 
@@ -716,7 +704,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SIGNALED	0x00000400	/* killed by a signal */
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
-
+#define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
 #define PF_FREEZE	0x00004000	/* this task should be frozen for suspend */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
@@ -727,6 +715,31 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SYNCWRITE	0x00200000	/* I am doing a sync write */
 #define PF_BORROWED_MM	0x00400000	/* I am a kthread doing use_mm */
 
+/*
+ * Only the _current_ task can read/write to tsk->flags, but other
+ * tasks can access tsk->flags in readonly mode for example
+ * with tsk_used_math (like during threaded core dumping).
+ * There is however an exception to this rule during ptrace
+ * or during fork: the ptracer task is allowed to write to the
+ * child->flags of its traced child (same goes for fork, the parent
+ * can write to the child->flags), because we're guaranteed the
+ * child is not running and in turn not changing child->flags
+ * at the same time the parent does it.
+ */
+#define clear_stopped_child_used_math(child) do { (child)->flags &= ~PF_USED_MATH; } while (0)
+#define set_stopped_child_used_math(child) do { (child)->flags |= PF_USED_MATH; } while (0)
+#define clear_used_math() clear_stopped_child_used_math(current)
+#define set_used_math() set_stopped_child_used_math(current)
+#define conditional_stopped_child_used_math(condition, child) \
+	do { (child)->flags &= ~PF_USED_MATH, (child)->flags |= (condition) ? PF_USED_MATH : 0; } while (0)
+#define conditional_used_math(condition) \
+	conditional_stopped_child_used_math(condition, current)
+#define copy_to_stopped_child_used_math(child) \
+	do { (child)->flags &= ~PF_USED_MATH, (child)->flags |= current->flags & PF_USED_MATH; } while (0)
+/* NOTE: this will return 0 or PF_USED_MATH, it will never return 1 */
+#define tsk_used_math(p) ((p)->flags & PF_USED_MATH)
+#define used_math() tsk_used_math(current)
+
 #ifdef CONFIG_SMP
 extern int set_cpus_allowed(task_t *p, cpumask_t new_mask);
 #else

--4Ckj6UjgE2iN1+kY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="mkpatch.py"

#!/usr/bin/env python

# Copyright (C) 2004 Andrea Arcangeli <andrea@suse.de> SUSE
# $Id: mkpatch.py,v 1.17 2004/12/04 04:22:09 andrea Exp $

# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA

# You can copy or symlink this script into ~/bin and
# your ~/.signedoffby file should contain a string like this:
# "Signed-off-by: Andrea Arcangeli <andrea@suse.de>"

# Usage is intuitive like this:
#	./mkpatch.py # without parameter search the backup in current dir
#	./mkpatch.py dir2 # this search the backups in dir2
#	./mkpatch.py dir1 dir2
#	./mkpatch.py dir2 destination-patchfile
#	./mkpatch.py dir1 dir2 destination-patchfile
#	./mkpatch.py destination-patchfile # this will only parse patchfile

# There are three options: -n, -s, -a (alias respectively to
# --no-signoff, --signoff and --acked). If you're only rediffing
# the patch you can use '-n' to avoid altering the signoff list.
# If you're instead only reviewing the patch you can use '-a'
# to add an Acked-by, instead of a Signed-off-by. You can use
# bash alias with bash 'alias mkpatch.py=mkpatch.py -a' if you
# only review patches, or you can use -n instead if you only
# regenerate patches without even reviewing them. You can always
# force a signoff by using -a or -s. The last option mode overrides
# any previous signoff mode. The default is '-s' (aka '--signoff').

# If you miss the ~/.signedoffby file, '-n' (aka '--no-signoff')
# behaviour will be forced.

import sys, os, re, readline, getopt
from rfc822 import Message

TAGS = (
	'From',
	'Subject',
	'Patch-mainline',
	'References',
	)

DIFF_CMD = 'diff -urNp --exclude CVS --exclude BitKeeper --exclude {arch} --exclude .arch-ids --exclude .svn'
SIGNOFF_FILE = '~/.signedoffby'

class signoff_mode_class(object):
	signedoffby = 'Signed-off-by: '
	ackedby = 'Acked-by: '

	def __init__(self):
		self.mode = 0
		self.my_signoff = None
	def signoff(self):
		self.mode = 0
	def no_signoff(self):
		self.mode = 1
	def acked(self):
		self.mode = 2
	def is_acked(self):
		return self.mode == 2
	def is_signingoff(self):
		return self.mode == 0
	def is_enabled(self):
		return self.is_signingoff() or self.is_acked()
	def change_prefix(self, prefix, signoff):
		if self.my_signoff is None:
			return prefix
		if self.is_signingoff():
			if signoff == self.my_signoff:
				return self.signedoffby
		elif self.is_acked():
			if signoff == self.my_signoff:
				return self.ackedby
		return prefix

class tag_class(object):
	def __init__(self, name):
		self.name = name
		self.regexp = re.compile(name + r': (.*)', re.I)
		self.value = ''

	def parse(self, line, message):
		header = message.isheader(line)
		if header and header.lower() == self.name.lower():
			header = message.getheader(header)
			if header:
				self.value = header
				return len(self.value.split('\n'))

	def ask_value(self):
		self.value = ''
		first = 1
		while 1:
			this_value = raw_input('%s: ' % self.name)
			if not this_value:
				break
			if not first:
				self.value += '\n '
			first = 0
			self.value += this_value

class patch_class(object):
	def __init__(self, patchfile, signoff_mode):
		self.patchfile = patchfile
		try:
			self.message = Message(file(patchfile))
		except IOError:
			self.message = None
		self.signoff_mode = signoff_mode
		self.prepare()
		self.read()

	def prepare(self):
		readline.add_history(os.path.basename(self.patchfile))
		readline.add_history('yes'); readline.add_history('no')

		my_signoff = None
		self.re_signoff = re.compile(self.signoff_mode.signedoffby + r'(.*@.*)', re.I)
		self.re_ackedby = re.compile(self.signoff_mode.ackedby + r'(.*@.*)', re.I)
		try:
			signoff = file(os.path.expanduser(SIGNOFF_FILE)).readline()
		except IOError:
			pass
		else:
			m = self.re_signoff.search(signoff)
			if m:
				my_signoff = m.group(1)
				readline.add_history(my_signoff)

		if not my_signoff:
			self.signoff_mode.no_signoff()
		else:
			self.signoff_mode.my_signoff = my_signoff

		self.tags = []
		for tag in TAGS:
			self.tags.append(tag_class(tag))

		self.signedoffby = self.signoff_mode.signedoffby
		self.ackedby = self.signoff_mode.ackedby

	def parse_metadata(self, line):
		# grab bk metadata and convert into valid header
		m = self.re_signoff.search(line)
		prefix = self.signedoffby
		if not m:
			prefix = self.ackedby
			m = self.re_ackedby.search(line)
		if m:
			this_signoff = m.group(1)
			if this_signoff not in self.signoff:
				self.signoff[this_signoff] = prefix
				self.signoff_order.append(this_signoff)
			return

		if self.message:
			for tag in self.tags:
				ret = tag.parse(line, self.message)
				if ret:
					return ret

	def read(self):
		self.metadata = ''
		self.signoff = {}
		self.signoff_order = []
		self.__payload = ''

		try:
			patch = file(self.patchfile, 'r')
		except IOError:
			pass
		else:
			re_index = re.compile(r'Index: .*')
			re_bk = re.compile(r'=====.*vs.*=====')
			re_diff = re.compile(r'diff .*')
			re_plus = re.compile(r'--- .*')
			re_empty = re.compile(r'^\s*$')

			re_signoff = self.re_signoff
			re_ackedby = self.re_ackedby

			emptylines = ''
			headers = 1
			state = 'is_metadata'
			while 1:
				line = patch.readline()
				if not line:
					break

				if re_diff.match(line) or re_plus.match(line) or \
				       re_index.match(line) or re_bk.match(line):
					state = 'is_payload'
				elif state == 'is_metadata' and (re_signoff.match(line) or
								 re_ackedby.match(line)):
					state = 'is_signoff'

				if state == 'is_metadata':
					if re_empty.search(line):
						emptylines += '\n'
					else:
						nr_lines = self.parse_metadata(line)
						if type(nr_lines) == int:
							for i in xrange(1, nr_lines):
								patch.readline()
						if not headers or not nr_lines:
							if headers:
								emptylines = ''
								headers = 0
							self.metadata += emptylines + line
							emptylines = ''
				elif state == 'is_signoff':
					m = self.re_signoff.match(line)
					prefix = self.signedoffby
					if not m:
						prefix = self.ackedby
						m = self.re_ackedby.match(line)
					if m:
						this_signoff = m.group(1)
						if this_signoff not in self.signoff:
							self.signoff[this_signoff] = prefix
							self.signoff_order.append(this_signoff)
				elif state == 'is_payload':
					self.__payload += line
				else:
					raise 'unknown state'

	def ask_empty_tags(self):
		for tag in self.tags:
			if not tag.value:
				tag.ask_value()

	def get_tags(self):
		ret = ''
		for tag in self.tags:
			if tag.value:
				ret += tag.name + ': ' + tag.value + '\n'
		return ret

	def get_signoff(self):
		ret = ''
		for signoff in self.signoff_order:
			prefix = self.signoff[signoff]
			prefix = self.signoff_mode.change_prefix(prefix, signoff)
			ret += prefix + signoff + '\n'
		my_signoff = self.signoff_mode.my_signoff
		if self.signoff_mode.is_enabled() and \
		       my_signoff and my_signoff not in self.signoff:
			prefix = self.signoff_mode.change_prefix(None, my_signoff)
			ret += prefix + my_signoff + '\n'
		return ret

	def write(self):
		tags = self.get_tags()
		if tags:
			tags += '\n'
		metadata = self.metadata
		if metadata:
			metadata += '\n'
		signoff = self.get_signoff()
		if signoff:
			signoff += '\n'
		payload = self.payload
		try:
			os.unlink(self.patchfile) # handle links
		except OSError:
			pass
		file(self.patchfile, 'w').write(tags + metadata + signoff + payload)

	def get_payload(self):
		return self.__payload

	def set_payload(self, value):
		if value is not None:
			self.__payload = cleanup_patch(value)

	payload = property(get_payload, set_payload)

def cleanup_patch(patch):
	diffline = re.compile(DIFF_CMD + r'.*')
	ret = ''
	for line in re.split('\n', patch):
		if line and not diffline.match(line):
			ret += line + '\n'
	return ret

def replace_diff(diff, patchfile, signoff_mode):
	patch = patch_class(patchfile, signoff_mode)
	patch.payload = diff
	patch.ask_empty_tags()
	patch.write()

def mkpatch(*args):
	# parse opts
	try:
		opts, args = getopt.getopt(args, 'nas', ( 'no-signoff', 'acked', 'signoff', ))
	except getopt.GetoptError:
		raise 'EINVAL'
	signoff_mode = signoff_mode_class()
	for opt, arg in opts:
		if opt in ('-n', '--no-signoff', ):
			signoff_mode.no_signoff()
		elif opt in ('-a', '--acked', ):
			signoff_mode.acked()
		elif opt in ('-s', '--signoff', ):
			signoff_mode.signoff()

	# parse args
	nr_args = len(args)
	def cleanup_path(args):
		return map(os.path.normpath, map(os.path.expanduser, args))
	if nr_args > 3:
		raise 'EINVAL'
	elif nr_args == 0:
		olddir = None
		newdir = '.'
		patchfile = None
	elif nr_args == 1:
		olddir = None
		newdir, = cleanup_path(args)
		patchfile = None
	elif nr_args == 2:
		olddir = None
		newdir, patchfile = cleanup_path(args)
	elif nr_args == 3:
		olddir, newdir, patchfile = cleanup_path(args)

	#print olddir, newdir, patchfile
	if olddir and not os.path.isdir(olddir):
		print >>sys.stderr, 'olddir must be a directory'
		raise 'EINVAL'
	elif not os.path.isdir(newdir):
		if not os.path.isfile(newdir):
			print >>sys.stderr, 'newdir must be a directory or a file'
			raise 'EINVAL'
		olddir, newdir, patchfile = (None, None, newdir, )
	elif patchfile and os.path.isdir(patchfile):
		olddir = newdir
		newdir = patchfile
		patchfile = None
	#print olddir, newdir, patchfile

	diff = None
	if not olddir and newdir:
		# use backup files
		print >>sys.stderr, 'Searching backup files in %s ...' % newdir,
		find = os.popen('find %s -type f \( -name \*~ -or -name \*.orig \) 2>/dev/null' % newdir, 'r')
		files = find.readlines()
		if files:
			print >>sys.stderr, 'done.'
		else:
			print >>sys.stderr, 'none found.'

		diff = ''
		already_diffed = {}
		for backup_f in files:
			new_f = None
			backup_f = backup_f[:-1]
			if backup_f[-5:] == '.orig':
				new_f = backup_f[:-5]
			elif backup_f[-4:] == '.~1~':
				new_f = backup_f[:-4]
			elif backup_f[-1:] == '~':
				new_f = backup_f[:-1]

			if new_f:
				if not os.path.isfile(new_f):
					continue
				if new_f in already_diffed:
					continue
				already_diffed[new_f] = 0
				print >>sys.stderr, 'Diffing %s...' % new_f,
				this_diff = os.popen(DIFF_CMD + ' %s %s' % (backup_f, new_f) + ' 2>/dev/null').read()
				diff += this_diff
				if this_diff:
					print >>sys.stderr, 'done.'
				else:
					print >>sys.stderr, 'unchanged.'
	elif olddir and newdir:
		# use two directories
		print >>sys.stderr, 'Creating diff between %s and %s ...' % (olddir, newdir),
		diff = os.popen(DIFF_CMD + ' %s %s' % (olddir, newdir) + ' 2>/dev/null', 'r').read()
		print >>sys.stderr, 'done.'

	if patchfile:
		replace_diff(diff, patchfile, signoff_mode)
		os.execvp('vi', ('vi', '-c', 'set tw=72', patchfile, ))
	else:
		if diff:
			print cleanup_patch(diff),

if __name__ == '__main__':
	try:
		mkpatch(*sys.argv[1:])
	except 'EINVAL':
		print >>sys.stderr, 'Usage:', sys.argv[0], \
		      '[-a|--acked] [-n|--no-signoff] [-s|--signoff] [olddir] [newdir] [patch]'

--4Ckj6UjgE2iN1+kY--
