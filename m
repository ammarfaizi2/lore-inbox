Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264916AbUFLUZb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264916AbUFLUZb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 16:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264918AbUFLUZa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 16:25:30 -0400
Received: from zero.aec.at ([193.170.194.10]:20229 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S264916AbUFLUZQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 16:25:16 -0400
To: stian@nixia.no
cc: linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: [PATCH] fix for Re: timer + fpu stuff locks my console race
References: <25iEn-7bv-3@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Date: Sat, 12 Jun 2004 22:25:10 +0200
In-Reply-To: <25iEn-7bv-3@gated-at.bofh.it> (stian@nixia.no's message of
 "Wed, 09 Jun 2004 23:20:07 +0200")
Message-ID: <m3n038o76h.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110003 (No Gnus v0.3) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

stian@nixia.no writes:

> Please keep me in CC as I'm not on the mailinglist. I'm currently on a
> vaccation, so I can't hook my linux-box to the Internet, but I came across
> a race condition in the "old" 2.4.26-rc1 vanilla kernel.
>
> I'm doing some code tests when I came across problems with my program
> locking my console (even X if I'm using a xterm).
>
> I think first of all gcc triggers the problem, so the full report is here:
> http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905
>
> For more details about versions and other information needed, please let
> me know if needed. It triggers at every attempt at my box currently (and
> I'm lacking Internet connection at the time-being on my machine).

Here's a patch. With that patch I've been running the program for some minutes
now without problems. I only tested it on x86-64, but the i386 and x86-64
codes for this are essentially the same.

One difference now is that you'll get always an oops for an unhandled kernel
math error. This may break some code or it may not. We'll see.

Please test.

-Andi

diff -u linux-2.6.7rc3-bk3/include/asm-x86_64/i387.h-o linux-2.6.7rc3-bk3/include/asm-x86_64/i387.h
--- linux-2.6.7rc3-bk3/include/asm-x86_64/i387.h-o	2004-06-11 03:03:15.000000000 +0200
+++ linux-2.6.7rc3-bk3/include/asm-x86_64/i387.h	2004-06-12 21:55:34.000000000 +0200
@@ -46,9 +46,20 @@
 		save_init_fpu(tsk); \
 } while (0)
 
+/* Ignore delayed exceptions from user space */
+static inline void tolerant_fwait(void)
+{ 
+	asm volatile("1: fwait\n"
+		     "2:\n"
+		     "   .section __ex_table,\"a\"\n"
+		     "	.align 8\n"
+		     "	.quad 1b,2b\n"
+		     "	.previous\n");
+} 
+
 #define clear_fpu(tsk) do { \
 	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
-		asm volatile("fwait");				\
+		tolerant_fwait();				\
 		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
 		stts();						\
 	}							\
diff -u linux-2.6.7rc3-bk3/include/asm-i386/i387.h-o linux-2.6.7rc3-bk3/include/asm-i386/i387.h
--- linux-2.6.7rc3-bk3/include/asm-i386/i387.h-o	2004-05-10 09:44:21.000000000 +0200
+++ linux-2.6.7rc3-bk3/include/asm-i386/i387.h	2004-06-12 22:16:04.000000000 +0200
@@ -28,6 +28,17 @@
 extern void kernel_fpu_begin(void);
 #define kernel_fpu_end() do { stts(); preempt_enable(); } while(0)
 
+/* Ignore delayed exceptions from user space */
+static inline void tolerant_fwait(void)
+{ 
+	asm volatile("1: fwait\n"
+		     "2:\n"
+		     "   .section __ex_table,\"a\"\n"
+		     "	.align 4\n"
+		     "	.long 1b,2b\n"
+		     "	.previous\n");
+} 
+
 /*
  * These must be called with preempt disabled
  */
@@ -37,8 +48,9 @@
 		asm volatile( "fxsave %0 ; fnclex"
 			      : "=m" (tsk->thread.i387.fxsave) );
 	} else {
-		asm volatile( "fnsave %0 ; fwait"
+		asm volatile( "fnsave %0"
 			      : "=m" (tsk->thread.i387.fsave) );
+		tolerant_fwait();
 	}
 	tsk->thread_info->status &= ~TS_USEDFPU;
 }
@@ -51,7 +63,7 @@
 #define __clear_fpu( tsk )					\
 do {								\
 	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
-		asm volatile("fwait");				\
+		tolerant_fwait();				\
 		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
 		stts();						\
 	}							\
diff -u linux-2.6.7rc3-bk3/arch/i386/kernel/i8259.c-o linux-2.6.7rc3-bk3/arch/i386/kernel/i8259.c
--- linux-2.6.7rc3-bk3/arch/i386/kernel/i8259.c-o	2004-05-10 09:43:22.000000000 +0200
+++ linux-2.6.7rc3-bk3/arch/i386/kernel/i8259.c	2004-06-12 22:04:37.000000000 +0200
@@ -329,7 +329,7 @@
 #endif
 	if (ignore_fpu_irq || !boot_cpu_data.hard_math)
 		return IRQ_NONE;
-	math_error((void *)regs->eip);
+	math_error(regs);
 	return IRQ_HANDLED;
 }
 
diff -u linux-2.6.7rc3-bk3/arch/i386/kernel/traps.c-o linux-2.6.7rc3-bk3/arch/i386/kernel/traps.c
--- linux-2.6.7rc3-bk3/arch/i386/kernel/traps.c-o	2004-06-11 03:02:34.000000000 +0200
+++ linux-2.6.7rc3-bk3/arch/i386/kernel/traps.c	2004-06-12 22:18:05.000000000 +0200
@@ -660,12 +660,23 @@
  * the correct behaviour even in the presence of the asynchronous
  * IRQ13 behaviour
  */
-void math_error(void *eip)
+void math_error(struct pt_regs *regs)
 {
+	void *eip = (void *)regs->eip;
 	struct task_struct * task;
 	siginfo_t info;
 	unsigned short cwd, swd;
 
+	if ((regs->xcs & 3) == 0) {
+		const struct exception_table_entry *fixup;
+		fixup = search_exception_tables(regs->eip);
+		if (fixup) {
+			regs->eip = fixup->fixup;
+			return;
+		}
+		die("kernel math error", regs, 0);
+	}
+
 	/*
 	 * Save the info for the exception handler and clear the error.
 	 */
@@ -719,15 +730,26 @@
 asmlinkage void do_coprocessor_error(struct pt_regs * regs, long error_code)
 {
 	ignore_fpu_irq = 1;
-	math_error((void *)regs->eip);
+	math_error(regs);
 }
 
-void simd_math_error(void *eip)
+void simd_math_error(struct pt_regs *regs)
 {
+	void *eip = (void *)regs->eip;
 	struct task_struct * task;
 	siginfo_t info;
 	unsigned short mxcsr;
 
+	if ((regs->xcs & 3) == 0) {
+		const struct exception_table_entry *fixup;
+		fixup = search_exception_tables(regs->eip);
+		if (fixup) {
+			regs->eip = fixup->fixup;
+			return;
+		}
+		die("kernel math error", regs, 0);
+	}
+
 	/*
 	 * Save the info for the exception handler and clear the error.
 	 */
@@ -776,7 +798,7 @@
 	if (cpu_has_xmm) {
 		/* Handle SIMD FPU exceptions on PIII+ processors. */
 		ignore_fpu_irq = 1;
-		simd_math_error((void *)regs->eip);
+		simd_math_error(regs);
 	} else {
 		/*
 		 * Handle strange cache flush from user space exception
diff -u linux-2.6.7rc3-bk3/arch/x86_64/kernel/traps.c-o linux-2.6.7rc3-bk3/arch/x86_64/kernel/traps.c
--- linux-2.6.7rc3-bk3/arch/x86_64/kernel/traps.c-o	2004-06-11 03:02:42.000000000 +0200
+++ linux-2.6.7rc3-bk3/arch/x86_64/kernel/traps.c	2004-06-12 22:00:28.000000000 +0200
@@ -686,11 +686,25 @@
  * the correct behaviour even in the presence of the asynchronous
  * IRQ13 behaviour
  */
-void math_error(void *rip)
+asmlinkage void do_coprocessor_error(struct pt_regs * regs)
 {
+	void *rip = (void *)regs->rip;
 	struct task_struct * task;
 	siginfo_t info;
 	unsigned short cwd, swd;
+
+	conditional_sti(regs);
+	if ((regs->cs & 3) == 0) {
+		const struct exception_table_entry *fixup;
+		fixup = search_exception_tables(regs->rip);
+		if (fixup) {
+			regs->rip = fixup->fixup;
+			return;
+		}
+		notify_die(DIE_GPF, "kernel math error", regs, 0, 16, SIGFPE); 
+		die("kernel math error", regs, 0);
+	}
+		
 	/*
 	 * Save the info for the exception handler and clear the error.
 	 */
@@ -740,23 +754,30 @@
 	force_sig_info(SIGFPE, &info, task);
 }
 
-asmlinkage void do_coprocessor_error(struct pt_regs * regs)
-{
-	conditional_sti(regs);
-	math_error((void *)regs->rip);
-}
-
 asmlinkage void bad_intr(void)
 {
 	printk("bad interrupt"); 
 }
 
-static inline void simd_math_error(void *rip)
+asmlinkage void do_simd_coprocessor_error(struct pt_regs * regs)
 {
+	void *rip = (void *)regs->rip;
 	struct task_struct * task;
 	siginfo_t info;
 	unsigned short mxcsr;
 
+	conditional_sti(regs);
+	if ((regs->cs & 3) == 0) {
+		const struct exception_table_entry *fixup;
+		fixup = search_exception_tables(regs->rip);
+		if (fixup) {
+			regs->rip = fixup->fixup;
+			return;
+		}
+		notify_die(DIE_GPF, "kernel simd error", regs, 0, 16, SIGFPE); 
+		die("kernel simd error", regs, 0);
+	}
+
 	/*
 	 * Save the info for the exception handler and clear the error.
 	 */
@@ -799,12 +820,6 @@
 	force_sig_info(SIGFPE, &info, task);
 }
 
-asmlinkage void do_simd_coprocessor_error(struct pt_regs * regs)
-{
-	conditional_sti(regs);
-		simd_math_error((void *)regs->rip);
-}
-
 asmlinkage void do_spurious_interrupt_bug(struct pt_regs * regs)
 {
 }

