Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262265AbVAUF7k@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262265AbVAUF7k (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 00:59:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262262AbVAUF7k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 00:59:40 -0500
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:43345
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262278AbVAUFus (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 00:50:48 -0500
Date: Fri, 21 Jan 2005 06:50:43 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Nick Piggin <npiggin@novell.com>
Subject: OOM fixes 5/5
Message-ID: <20050121055043.GE12647@dualathlon.random>
References: <20050121054840.GA12647@dualathlon.random> <20050121054916.GB12647@dualathlon.random> <20050121054945.GC12647@dualathlon.random> <20050121055004.GD12647@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050121055004.GD12647@dualathlon.random>
X-AA-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-AA-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
X-Cpushare-GPG-Key: 1024D/4D11C21C 5F99 3C8B 5142 EB62 26C3  2325 8989 B72A 4D11 C21C
X-Cpushare-SSL-SHA1-Cert: 38 12 CD 76 E4 82 94 AF 02 0C 0F FA E1 FF 55 9D 9B 4F A5 9B
X-Cpushare-SSL-MD5-Cert: ED A5 F2 DA 1D 32 75 60 5E 07 6C 91 BF FC B8 85
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrea Arcangeli <andrea@suse.de>
Subject: Convert the unsafe signed (16bit) used_math to a safe and optimal PF_USED_MATH

On Sat, Dec 25, 2004 at 04:24:30AM +0100, Andrea Arcangeli wrote:
> Here it is the first part. This makes memdie a TIF_MEMDIE. It's

And here is the final incremental part converting ->used_math to
PF_USED_MATH.

I might have broken arm, see the very first change in the patch to
asm-offsets.c, rest looks ok at first glance.

If you want used_math to return 0 or 1 (instead of 0 or PF_USED_MATH),
just s/!!// in the below patch and place !! in sched.h::*used_math()
accordingly after applying the patch, it should work just fine. Using !!
only when necessary as the below is optimal.

Signed-off-by: Andrea Arcangeli <andrea@suse.de>

--- mainline-5/arch/arm26/kernel/asm-offsets.c.orig	2003-07-17 01:52:38.000000000 +0200
+++ mainline-5/arch/arm26/kernel/asm-offsets.c	2005-01-21 06:20:01.999885640 +0100
@@ -42,7 +42,6 @@
 
 int main(void)
 {
-  DEFINE(TSK_USED_MATH,		offsetof(struct task_struct, used_math));
   DEFINE(TSK_ACTIVE_MM,		offsetof(struct task_struct, active_mm));
   BLANK();
   DEFINE(VMA_VM_MM,		offsetof(struct vm_area_struct, vm_mm));
--- mainline-5/arch/arm26/kernel/process.c.orig	2005-01-15 20:44:48.000000000 +0100
+++ mainline-5/arch/arm26/kernel/process.c	2005-01-21 06:20:02.013883512 +0100
@@ -271,7 +271,7 @@ void flush_thread(void)
 	memset(&tsk->thread.debug, 0, sizeof(struct debug_info));
 	memset(&thread->fpstate, 0, sizeof(union fp_state));
 
-	current->used_math = 0;
+	clear_used_math();
 }
 
 void release_thread(struct task_struct *dead_task)
@@ -305,7 +305,7 @@ copy_thread(int nr, unsigned long clone_
 int dump_fpu (struct pt_regs *regs, struct user_fp *fp)
 {
 	struct thread_info *thread = current_thread_info();
-	int used_math = current->used_math;
+	int used_math = !!used_math();
 
 	if (used_math)
 		memcpy(fp, &thread->fpstate.soft, sizeof (*fp));
--- mainline-5/arch/arm26/kernel/ptrace.c.orig	2005-01-04 01:13:09.000000000 +0100
+++ mainline-5/arch/arm26/kernel/ptrace.c	2005-01-21 06:20:02.018882752 +0100
@@ -540,7 +540,7 @@ static int ptrace_getfpregs(struct task_
  */
 static int ptrace_setfpregs(struct task_struct *tsk, void *ufp)
 {
-	tsk->used_math = 1;
+	set_stopped_child_used_math(tsk);
 	return copy_from_user(&tsk->thread_info->fpstate, ufp,
 			      sizeof(struct user_fp)) ? -EFAULT : 0;
 }
--- mainline-5/arch/i386/kernel/cpu/common.c.orig	2005-01-15 20:44:49.000000000 +0100
+++ mainline-5/arch/i386/kernel/cpu/common.c	2005-01-21 06:20:02.027881384 +0100
@@ -629,6 +629,6 @@ void __init cpu_init (void)
 	 * Force FPU initialization:
 	 */
 	current_thread_info()->status = 0;
-	current->used_math = 0;
+	clear_used_math();
 	mxcsr_feature_mask_init();
 }
--- mainline-5/arch/i386/kernel/i387.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/i386/kernel/i387.c	2005-01-21 06:20:02.040879408 +0100
@@ -60,7 +60,8 @@ void init_fpu(struct task_struct *tsk)
 		tsk->thread.i387.fsave.twd = 0xffffffffu;
 		tsk->thread.i387.fsave.fos = 0xffff0000u;
 	}
-	tsk->used_math = 1;
+	/* only the device not available exception or ptrace can call init_fpu */
+	set_stopped_child_used_math(tsk);
 }
 
 /*
@@ -331,13 +332,13 @@ static int save_i387_fxsave( struct _fps
 
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
@@ -383,7 +384,7 @@ int restore_i387( struct _fpstate __user
 	} else {
 		err = restore_i387_soft( &current->thread.i387.soft, buf );
 	}
-	current->used_math = 1;
+	set_used_math();
 	return err;
 }
 
@@ -507,7 +508,7 @@ int dump_fpu( struct pt_regs *regs, stru
 	int fpvalid;
 	struct task_struct *tsk = current;
 
-	fpvalid = tsk->used_math;
+	fpvalid = !!used_math();
 	if ( fpvalid ) {
 		unlazy_fpu( tsk );
 		if ( cpu_has_fxsr ) {
@@ -522,7 +523,7 @@ int dump_fpu( struct pt_regs *regs, stru
 
 int dump_task_fpu(struct task_struct *tsk, struct user_i387_struct *fpu)
 {
-	int fpvalid = tsk->used_math;
+	int fpvalid = !!tsk_used_math(tsk);
 
 	if (fpvalid) {
 		if (tsk == current)
@@ -537,7 +538,7 @@ int dump_task_fpu(struct task_struct *ts
 
 int dump_task_extended_fpu(struct task_struct *tsk, struct user_fxsr_struct *fpu)
 {
-	int fpvalid = tsk->used_math && cpu_has_fxsr;
+	int fpvalid = tsk_used_math(tsk) && cpu_has_fxsr;
 
 	if (fpvalid) {
 		if (tsk == current)
--- mainline-5/arch/i386/kernel/process.c.orig	2005-01-15 20:44:49.000000000 +0100
+++ mainline-5/arch/i386/kernel/process.c	2005-01-21 06:20:02.049878040 +0100
@@ -351,7 +351,7 @@ void flush_thread(void)
 	 * Forget coprocessor state..
 	 */
 	clear_fpu(tsk);
-	tsk->used_math = 0;
+	clear_used_math();
 }
 
 void release_thread(struct task_struct *dead_task)
--- mainline-5/arch/i386/kernel/ptrace.c.orig	2005-01-15 20:44:49.000000000 +0100
+++ mainline-5/arch/i386/kernel/ptrace.c	2005-01-21 06:20:02.052877584 +0100
@@ -592,7 +592,7 @@ asmlinkage int sys_ptrace(long request, 
 			break;
 		}
 		ret = 0;
-		if (!child->used_math)
+		if (!tsk_used_math(child))
 			init_fpu(child);
 		get_fpregs((struct user_i387_struct __user *)data, child);
 		break;
@@ -604,7 +604,7 @@ asmlinkage int sys_ptrace(long request, 
 			ret = -EIO;
 			break;
 		}
-		child->used_math = 1;
+		set_stopped_child_used_math(child);
 		set_fpregs(child, (struct user_i387_struct __user *)data);
 		ret = 0;
 		break;
@@ -616,7 +616,7 @@ asmlinkage int sys_ptrace(long request, 
 			ret = -EIO;
 			break;
 		}
-		if (!child->used_math)
+		if (!tsk_used_math(child))
 			init_fpu(child);
 		ret = get_fpxregs((struct user_fxsr_struct __user *)data, child);
 		break;
@@ -628,7 +628,7 @@ asmlinkage int sys_ptrace(long request, 
 			ret = -EIO;
 			break;
 		}
-		child->used_math = 1;
+		set_stopped_child_used_math(child);
 		ret = set_fpxregs(child, (struct user_fxsr_struct __user *)data);
 		break;
 	}
--- mainline-5/arch/i386/kernel/traps.c.orig	2005-01-15 20:44:49.000000000 +0100
+++ mainline-5/arch/i386/kernel/traps.c	2005-01-21 06:20:02.054877280 +0100
@@ -911,7 +911,7 @@ asmlinkage void math_state_restore(struc
 	struct task_struct *tsk = thread->task;
 
 	clts();		/* Allow maths ops (or we recurse) */
-	if (!tsk->used_math)
+	if (!tsk_used_math(tsk))
 		init_fpu(tsk);
 	restore_fpu(tsk);
 	thread->status |= TS_USEDFPU;	/* So we fnsave on switch_to() */
--- mainline-5/arch/i386/math-emu/fpu_entry.c.orig	2004-08-25 02:47:49.000000000 +0200
+++ mainline-5/arch/i386/math-emu/fpu_entry.c	2005-01-21 06:20:02.066875456 +0100
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
--- mainline-5/arch/ia64/ia32/elfcore32.h.orig	2005-01-04 01:13:09.000000000 +0100
+++ mainline-5/arch/ia64/ia32/elfcore32.h	2005-01-21 06:20:02.077873784 +0100
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
--- mainline-5/arch/mips/kernel/irixsig.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/mips/kernel/irixsig.c	2005-01-21 06:20:02.085872568 +0100
@@ -99,7 +99,7 @@ static void setup_irix_frame(struct k_si
 	__put_user((u64) regs->hi, &ctx->hi);
 	__put_user((u64) regs->lo, &ctx->lo);
 	__put_user((u64) regs->cp0_epc, &ctx->pc);
-	__put_user(current->used_math, &ctx->usedfp);
+	__put_user(!!used_math(), &ctx->usedfp);
 	__put_user((u64) regs->cp0_cause, &ctx->cp0_cause);
 	__put_user((u64) regs->cp0_badvaddr, &ctx->cp0_badvaddr);
 
@@ -725,7 +725,7 @@ asmlinkage int irix_getcontext(struct pt
 	__put_user(regs->cp0_epc, &ctx->regs[35]);
 
 	flags = 0x0f;
-	if(!current->used_math) {
+	if(!used_math()) {
 		flags &= ~(0x08);
 	} else {
 		/* XXX wheee... */
--- mainline-5/arch/mips/kernel/process.c.orig	2005-01-04 01:13:10.000000000 +0100
+++ mainline-5/arch/mips/kernel/process.c	2005-01-21 06:20:02.093871352 +0100
@@ -76,7 +76,7 @@ void start_thread(struct pt_regs * regs,
 #endif
 	status |= KU_USER;
 	regs->cp0_status = status;
-	current->used_math = 0;
+	clear_used_math();
 	lose_fpu();
 	regs->cp0_epc = pc;
 	regs->regs[29] = sp;
--- mainline-5/arch/mips/kernel/ptrace.c.orig	2005-01-04 01:13:10.000000000 +0100
+++ mainline-5/arch/mips/kernel/ptrace.c	2005-01-21 06:20:02.094871200 +0100
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
--- mainline-5/arch/mips/kernel/ptrace32.c.orig	2005-01-04 01:13:10.000000000 +0100
+++ mainline-5/arch/mips/kernel/ptrace32.c	2005-01-21 06:20:02.096870896 +0100
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
--- mainline-5/arch/mips/kernel/signal.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/mips/kernel/signal.c	2005-01-21 06:20:02.098870592 +0100
@@ -178,11 +178,11 @@ asmlinkage int restore_sigcontext(struct
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
@@ -323,9 +323,9 @@ inline int setup_sigcontext(struct pt_re
 	err |= __put_user(regs->cp0_cause, &sc->sc_cause);
 	err |= __put_user(regs->cp0_badvaddr, &sc->sc_badvaddr);
 
-	err |= __put_user(current->used_math, &sc->sc_used_math);
+	err |= __put_user(!!used_math(), &sc->sc_used_math);
 
-	if (!current->used_math)
+	if (!used_math())
 		goto out;
 
 	/*
--- mainline-5/arch/mips/kernel/signal32.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/mips/kernel/signal32.c	2005-01-21 06:20:02.099870440 +0100
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
--- mainline-5/arch/mips/kernel/traps.c.orig	2005-01-04 01:13:10.000000000 +0100
+++ mainline-5/arch/mips/kernel/traps.c	2005-01-21 06:20:02.105869528 +0100
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
--- mainline-5/arch/s390/kernel/process.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/s390/kernel/process.c	2005-01-21 06:20:02.120867248 +0100
@@ -215,8 +215,7 @@ void exit_thread(void)
 
 void flush_thread(void)
 {
-
-        current->used_math = 0;
+	clear_used_math();
 	clear_tsk_thread_flag(current, TIF_USEDFPU);
 }
 
--- mainline-5/arch/s390/kernel/setup.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/s390/kernel/setup.c	2005-01-21 06:20:02.129865880 +0100
@@ -96,7 +96,7 @@ void __devinit cpu_init (void)
          * Force FPU initialization:
          */
         clear_thread_flag(TIF_USEDFPU);
-        current->used_math = 0;
+        clear_used_math();
 
 	atomic_inc(&init_mm.mm_count);
 	current->active_mm = &init_mm;
--- mainline-5/arch/sh/kernel/cpu/sh4/fpu.c.orig	2004-02-20 17:26:36.000000000 +0100
+++ mainline-5/arch/sh/kernel/cpu/sh4/fpu.c	2005-01-21 06:20:02.139864360 +0100
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
--- mainline-5/arch/sh/kernel/cpu/init.c.orig	2005-01-04 01:13:11.000000000 +0100
+++ mainline-5/arch/sh/kernel/cpu/init.c	2005-01-21 06:20:02.150862688 +0100
@@ -194,7 +194,7 @@ asmlinkage void __init sh_cpu_init(void)
 	/* FPU initialization */
 	if ((cpu_data->flags & CPU_HAS_FPU)) {
 		clear_thread_flag(TIF_USEDFPU);
-		current->used_math = 0;
+		clear_used_math();
 	}
 
 #ifdef CONFIG_SH_DSP
--- mainline-5/arch/sh/kernel/process.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/sh/kernel/process.c	2005-01-21 06:20:02.159861320 +0100
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
--- mainline-5/arch/sh/kernel/ptrace.c.orig	2005-01-04 01:13:11.000000000 +0100
+++ mainline-5/arch/sh/kernel/ptrace.c	2005-01-21 06:20:02.168859952 +0100
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
--- mainline-5/arch/sh/kernel/signal.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/sh/kernel/signal.c	2005-01-21 06:20:02.170859648 +0100
@@ -162,7 +162,7 @@ static inline int restore_sigcontext_fpu
 	if (!(cpu_data->flags & CPU_HAS_FPU))
 		return 0;
 
-	tsk->used_math = 1;
+	set_used_math();
 	return __copy_from_user(&tsk->thread.fpu.hard, &sc->sc_fpregs[0],
 				sizeof(long)*(16*2+2));
 }
@@ -175,7 +175,7 @@ static inline int save_sigcontext_fpu(st
 	if (!(cpu_data->flags & CPU_HAS_FPU))
 		return 0;
 
-	if (!tsk->used_math) {
+	if (!used_math()) {
 		__put_user(0, &sc->sc_ownedfp);
 		return 0;
 	}
@@ -185,7 +185,7 @@ static inline int save_sigcontext_fpu(st
 	/* This will cause a "finit" to be triggered by the next
 	   attempted FPU operation by the 'current' process.
 	   */
-	tsk->used_math = 0;
+	clear_used_math();
 
 	unlazy_fpu(tsk, regs);
 	return __copy_to_user(&sc->sc_fpregs[0], &tsk->thread.fpu.hard,
@@ -219,7 +219,7 @@ restore_sigcontext(struct pt_regs *regs,
 
 		regs->sr |= SR_FD; /* Release FPU */
 		clear_fpu(tsk, regs);
-		tsk->used_math = 0;
+		clear_used_math();
 		__get_user (owned_fp, &sc->sc_ownedfp);
 		if (owned_fp)
 			err |= restore_sigcontext_fpu(sc);
--- mainline-5/arch/sh64/kernel/fpu.c.orig	2004-08-25 02:47:49.000000000 +0200
+++ mainline-5/arch/sh64/kernel/fpu.c	2005-01-21 06:20:02.182857824 +0100
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
--- mainline-5/arch/sh64/kernel/process.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/sh64/kernel/process.c	2005-01-21 06:20:02.195855848 +0100
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
--- mainline-5/arch/sh64/kernel/ptrace.c.orig	2005-01-04 01:13:11.000000000 +0100
+++ mainline-5/arch/sh64/kernel/ptrace.c	2005-01-21 06:20:02.202854784 +0100
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
--- mainline-5/arch/sh64/kernel/signal.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/sh64/kernel/signal.c	2005-01-21 06:20:02.204854480 +0100
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
--- mainline-5/arch/sparc/kernel/process.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/sparc/kernel/process.c	2005-01-21 06:20:02.219852200 +0100
@@ -599,7 +599,7 @@ void dump_thread(struct pt_regs * regs, 
  */
 int dump_fpu (struct pt_regs * regs, elf_fpregset_t * fpregs)
 {
-	if (current->used_math == 0) {
+	if (used_math()) {
 		memset(fpregs, 0, sizeof(*fpregs));
 		fpregs->pr_q_entrysize = 8;
 		return 1;
--- mainline-5/arch/sparc/kernel/signal.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/sparc/kernel/signal.c	2005-01-21 06:20:02.225851288 +0100
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
--- mainline-5/arch/sparc/kernel/traps.c.orig	2004-08-25 02:47:49.000000000 +0200
+++ mainline-5/arch/sparc/kernel/traps.c	2005-01-21 06:20:02.233850072 +0100
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
--- mainline-5/arch/x86_64/ia32/fpu32.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/x86_64/ia32/fpu32.c	2005-01-21 06:20:02.246848096 +0100
@@ -157,7 +157,7 @@ int restore_i387_ia32(struct task_struct
 				     sizeof(struct i387_fxsave_struct)))
 			return -1;
 		tsk->thread.i387.fxsave.mxcsr &= mxcsr_feature_mask;
-		tsk->used_math = 1;
+		set_stopped_child_used_math(tsk);
 	} 
 	return convert_fxsr_from_user(&tsk->thread.i387.fxsave, buf);
 }  
--- mainline-5/arch/x86_64/ia32/ia32_binfmt.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/x86_64/ia32/ia32_binfmt.c	2005-01-21 06:20:02.255846728 +0100
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
--- mainline-5/arch/x86_64/ia32/ia32_signal.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/x86_64/ia32/ia32_signal.c	2005-01-21 06:20:02.256846576 +0100
@@ -389,7 +389,7 @@ ia32_setup_sigcontext(struct sigcontext_
 	if (tmp < 0)
 	  err = -EFAULT;
 	else { 
-		current->used_math = 0;
+		clear_used_math();
 		stts();
 	  err |= __put_user((u32)(u64)(tmp ? fpstate : NULL), &sc->fpstate);
 	}
--- mainline-5/arch/x86_64/ia32/ptrace32.c.orig	2005-01-04 01:13:11.000000000 +0100
+++ mainline-5/arch/x86_64/ia32/ptrace32.c	2005-01-21 06:20:02.272844144 +0100
@@ -358,7 +358,7 @@ asmlinkage long sys32_ptrace(long reques
 			break;
 		/* no checking to be bug-to-bug compatible with i386 */
 		__copy_from_user(&child->thread.i387.fxsave, u, sizeof(*u));
-		child->used_math = 1;
+		set_stopped_child_used_math(child);
 		child->thread.i387.fxsave.mxcsr &= mxcsr_feature_mask;
 		ret = 0; 
 		break;
--- mainline-5/arch/x86_64/kernel/i387.c.orig	2004-08-25 02:47:33.000000000 +0200
+++ mainline-5/arch/x86_64/kernel/i387.c	2005-01-21 06:20:02.282842624 +0100
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
--- mainline-5/arch/x86_64/kernel/process.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/x86_64/kernel/process.c	2005-01-21 06:20:02.290841408 +0100
@@ -314,7 +314,7 @@ void flush_thread(void)
 	 * Forget coprocessor state..
 	 */
 	clear_fpu(tsk);
-	tsk->used_math = 0;
+	clear_used_math();
 }
 
 void release_thread(struct task_struct *dead_task)
--- mainline-5/arch/x86_64/kernel/ptrace.c.orig	2005-01-04 01:13:11.000000000 +0100
+++ mainline-5/arch/x86_64/kernel/ptrace.c	2005-01-21 06:20:02.302839584 +0100
@@ -480,7 +480,7 @@ asmlinkage long sys_ptrace(long request,
 			ret = -EIO;
 			break;
 		}
-		child->used_math = 1;
+		set_stopped_child_used_math(child);
 		ret = set_fpregs(child, (struct user_i387_struct __user *)data);
 		break;
 	}
--- mainline-5/arch/x86_64/kernel/signal.c.orig	2005-01-20 18:20:09.000000000 +0100
+++ mainline-5/arch/x86_64/kernel/signal.c	2005-01-21 06:20:02.304839280 +0100
@@ -251,7 +251,7 @@ static void setup_rt_frame(int sig, stru
 	int err = 0;
 	struct task_struct *me = current;
 
-	if (me->used_math) {
+	if (used_math()) {
 		fp = get_stack(ka, regs, sizeof(struct _fpstate)); 
 		frame = (void __user *)round_down((unsigned long)fp - sizeof(struct rt_sigframe), 16) - 8;
 
--- mainline-5/arch/x86_64/kernel/traps.c.orig	2005-01-15 20:44:50.000000000 +0100
+++ mainline-5/arch/x86_64/kernel/traps.c	2005-01-21 06:20:02.318837152 +0100
@@ -901,7 +901,7 @@ asmlinkage void math_state_restore(void)
 	struct task_struct *me = current;
 	clts();			/* Allow maths ops (or we recurse) */
 
-	if (!me->used_math)
+	if (!used_math())
 		init_fpu(me);
 	restore_fpu_checking(&me->thread.i387.fxsave);
 	me->thread_info->status |= TS_USEDFPU;
--- mainline-5/arch/m32r/kernel/ptrace.c.orig	2005-01-15 20:44:49.000000000 +0100
+++ mainline-5/arch/m32r/kernel/ptrace.c	2005-01-21 06:20:02.325836088 +0100
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
--- mainline-5/arch/m32r/kernel/setup.c.orig	2005-01-15 20:44:49.000000000 +0100
+++ mainline-5/arch/m32r/kernel/setup.c	2005-01-21 06:20:02.327835784 +0100
@@ -391,7 +391,7 @@ void __init cpu_init (void)
 
 	/* Force FPU initialization */
 	current_thread_info()->status = 0;
-	current->used_math = 0;
+	clear_used_math();
 
 #ifdef CONFIG_MMU
 	/* Set up MMU */
--- mainline-5/include/asm-arm26/constants.h.orig	2003-06-08 18:21:42.000000000 +0200
+++ mainline-5/include/asm-arm26/constants.h	2005-01-21 06:20:02.339833960 +0100
@@ -7,7 +7,6 @@
  *
  */
 
-#define TSK_USED_MATH 788 /* offsetof(struct task_struct, used_math) */
 #define TSK_ACTIVE_MM 96 /* offsetof(struct task_struct, active_mm) */
 
 #define VMA_VM_MM 0 /* offsetof(struct vm_area_struct, vm_mm) */
--- mainline-5/include/asm-x86_64/i387.h.orig	2004-12-04 08:55:04.000000000 +0100
+++ mainline-5/include/asm-x86_64/i387.h	2005-01-21 06:20:02.349832440 +0100
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
--- mainline-5/include/linux/sched.h.orig	2005-01-21 06:17:24.967758152 +0100
+++ mainline-5/include/linux/sched.h	2005-01-21 06:21:42.854553400 +0100
@@ -614,19 +614,7 @@ struct task_struct {
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
 	char comm[TASK_COMM_LEN];
 /* file system info */
 	int link_count, total_link_count;
@@ -695,7 +683,7 @@ struct task_struct {
 #endif
 #ifdef CONFIG_NUMA
   	struct mempolicy *mempolicy;
-  	short il_next;		/* could be shared with used_math */
+	short il_next;
 #endif
 };
 
@@ -737,7 +725,7 @@ do { if (atomic_dec_and_test(&(tsk)->usa
 #define PF_SIGNALED	0x00000400	/* killed by a signal */
 #define PF_MEMALLOC	0x00000800	/* Allocating memory */
 #define PF_FLUSHER	0x00001000	/* responsible for disk writeback */
-
+#define PF_USED_MATH	0x00002000	/* if unset the fpu must be initialized before use */
 #define PF_FREEZE	0x00004000	/* this task is being frozen for suspend now */
 #define PF_NOFREEZE	0x00008000	/* this thread should not be frozen */
 #define PF_FROZEN	0x00010000	/* frozen for system suspend */
@@ -748,6 +736,31 @@ do { if (atomic_dec_and_test(&(tsk)->usa
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
--- mainline-oom/arch/i386/kernel/signal.c.~1~	2005-01-15 20:44:49.000000000 +0100
+++ mainline-oom/arch/i386/kernel/signal.c	2005-01-21 06:27:20.433233640 +0100
@@ -192,9 +192,9 @@ restore_sigcontext(struct pt_regs *regs,
 			err |= restore_i387(buf);
 		} else {
 			struct task_struct *me = current;
-			if (me->used_math) {
+			if (used_math()) {
 				clear_fpu(me);
-				me->used_math = 0;
+				clear_used_math();
 			}
 		}
 	}
--- mainline-oom/arch/x86_64/ia32/ia32_signal.c.~1~	2005-01-21 06:24:51.970803360 +0100
+++ mainline-oom/arch/x86_64/ia32/ia32_signal.c	2005-01-21 06:29:47.208920344 +0100
@@ -263,9 +263,9 @@ ia32_restore_sigcontext(struct pt_regs *
 			err |= restore_i387_ia32(current, buf, 0);
 		} else {
 			struct task_struct *me = current;
-			if (me->used_math) {
+			if (used_math()) {
 				clear_fpu(me);
-				me->used_math = 0;
+				clear_used_math();
 			}
 		}
 	}
--- mainline-oom/arch/x86_64/kernel/signal.c.~1~	2005-01-21 06:24:51.975802600 +0100
+++ mainline-oom/arch/x86_64/kernel/signal.c	2005-01-21 06:29:41.988713936 +0100
@@ -126,9 +126,9 @@ restore_sigcontext(struct pt_regs *regs,
 			err |= restore_i387(buf);
 		} else {
 			struct task_struct *me = current;
-			if (me->used_math) {
+			if (used_math()) {
 				clear_fpu(me);
-				me->used_math = 0;
+				clear_used_math();
 			}
 		}
 	}
