Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264546AbUFNWeS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264546AbUFNWeS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 18:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264560AbUFNWeS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 18:34:18 -0400
Received: from smtp.andrew.cmu.edu ([128.2.10.81]:40597 "EHLO
	smtp.andrew.cmu.edu") by vger.kernel.org with ESMTP id S264546AbUFNWd7
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 18:33:59 -0400
Date: Mon, 14 Jun 2004 18:33:32 -0400 (EDT)
From: "Nathaniel W. Filardo" <nwf@andrew.cmu.edu>
To: Andi Kleen <ak@muc.de>
cc: stian@nixia.no, linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: [PATCH] fix for Re: timer + fpu stuff locks my console race
In-Reply-To: <m3n038o76h.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58-035.0406141829330.3002@unix49.andrew.cmu.edu>
References: <25iEn-7bv-3@gated-at.bofh.it> <m3n038o76h.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Using this patch (against 2.6.5-WOLK3.0), the system doen't crash (the
program is given SIGSEGV), but it seems to also kill anything else using
the FPU.  Including gkrellm2 with the GkrellWeather plugin.

Can anybody confirm this or is it just a strange "feature" of my system?

--nwf;

On Sat, 12 Jun 2004, Andi Kleen wrote:

> stian@nixia.no writes:
>
> > Please keep me in CC as I'm not on the mailinglist. I'm currently on a
> > vaccation, so I can't hook my linux-box to the Internet, but I came across
> > a race condition in the "old" 2.4.26-rc1 vanilla kernel.
> >
> > I'm doing some code tests when I came across problems with my program
> > locking my console (even X if I'm using a xterm).
> >
> > I think first of all gcc triggers the problem, so the full report is here:
> > http://gcc.gnu.org/bugzilla/show_bug.cgi?id=15905
> >
> > For more details about versions and other information needed, please let
> > me know if needed. It triggers at every attempt at my box currently (and
> > I'm lacking Internet connection at the time-being on my machine).
>
> Here's a patch. With that patch I've been running the program for some minutes
> now without problems. I only tested it on x86-64, but the i386 and x86-64
> codes for this are essentially the same.
>
> One difference now is that you'll get always an oops for an unhandled kernel
> math error. This may break some code or it may not. We'll see.
>
> Please test.
>
> -Andi
>
> diff -u linux-2.6.7rc3-bk3/include/asm-x86_64/i387.h-o linux-2.6.7rc3-bk3/include/asm-x86_64/i387.h
> --- linux-2.6.7rc3-bk3/include/asm-x86_64/i387.h-o	2004-06-11 03:03:15.000000000 +0200
> +++ linux-2.6.7rc3-bk3/include/asm-x86_64/i387.h	2004-06-12 21:55:34.000000000 +0200
> @@ -46,9 +46,20 @@
>  		save_init_fpu(tsk); \
>  } while (0)
>
> +/* Ignore delayed exceptions from user space */
> +static inline void tolerant_fwait(void)
> +{
> +	asm volatile("1: fwait\n"
> +		     "2:\n"
> +		     "   .section __ex_table,\"a\"\n"
> +		     "	.align 8\n"
> +		     "	.quad 1b,2b\n"
> +		     "	.previous\n");
> +}
> +
>  #define clear_fpu(tsk) do { \
>  	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
> -		asm volatile("fwait");				\
> +		tolerant_fwait();				\
>  		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
>  		stts();						\
>  	}							\
> diff -u linux-2.6.7rc3-bk3/include/asm-i386/i387.h-o linux-2.6.7rc3-bk3/include/asm-i386/i387.h
> --- linux-2.6.7rc3-bk3/include/asm-i386/i387.h-o	2004-05-10 09:44:21.000000000 +0200
> +++ linux-2.6.7rc3-bk3/include/asm-i386/i387.h	2004-06-12 22:16:04.000000000 +0200
> @@ -28,6 +28,17 @@
>  extern void kernel_fpu_begin(void);
>  #define kernel_fpu_end() do { stts(); preempt_enable(); } while(0)
>
> +/* Ignore delayed exceptions from user space */
> +static inline void tolerant_fwait(void)
> +{
> +	asm volatile("1: fwait\n"
> +		     "2:\n"
> +		     "   .section __ex_table,\"a\"\n"
> +		     "	.align 4\n"
> +		     "	.long 1b,2b\n"
> +		     "	.previous\n");
> +}
> +
>  /*
>   * These must be called with preempt disabled
>   */
> @@ -37,8 +48,9 @@
>  		asm volatile( "fxsave %0 ; fnclex"
>  			      : "=m" (tsk->thread.i387.fxsave) );
>  	} else {
> -		asm volatile( "fnsave %0 ; fwait"
> +		asm volatile( "fnsave %0"
>  			      : "=m" (tsk->thread.i387.fsave) );
> +		tolerant_fwait();
>  	}
>  	tsk->thread_info->status &= ~TS_USEDFPU;
>  }
> @@ -51,7 +63,7 @@
>  #define __clear_fpu( tsk )					\
>  do {								\
>  	if ((tsk)->thread_info->status & TS_USEDFPU) {		\
> -		asm volatile("fwait");				\
> +		tolerant_fwait();				\
>  		(tsk)->thread_info->status &= ~TS_USEDFPU;	\
>  		stts();						\
>  	}							\
> diff -u linux-2.6.7rc3-bk3/arch/i386/kernel/i8259.c-o linux-2.6.7rc3-bk3/arch/i386/kernel/i8259.c
> --- linux-2.6.7rc3-bk3/arch/i386/kernel/i8259.c-o	2004-05-10 09:43:22.000000000 +0200
> +++ linux-2.6.7rc3-bk3/arch/i386/kernel/i8259.c	2004-06-12 22:04:37.000000000 +0200
> @@ -329,7 +329,7 @@
>  #endif
>  	if (ignore_fpu_irq || !boot_cpu_data.hard_math)
>  		return IRQ_NONE;
> -	math_error((void *)regs->eip);
> +	math_error(regs);
>  	return IRQ_HANDLED;
>  }
>
> diff -u linux-2.6.7rc3-bk3/arch/i386/kernel/traps.c-o linux-2.6.7rc3-bk3/arch/i386/kernel/traps.c
> --- linux-2.6.7rc3-bk3/arch/i386/kernel/traps.c-o	2004-06-11 03:02:34.000000000 +0200
> +++ linux-2.6.7rc3-bk3/arch/i386/kernel/traps.c	2004-06-12 22:18:05.000000000 +0200
> @@ -660,12 +660,23 @@
>   * the correct behaviour even in the presence of the asynchronous
>   * IRQ13 behaviour
>   */
> -void math_error(void *eip)
> +void math_error(struct pt_regs *regs)
>  {
> +	void *eip = (void *)regs->eip;
>  	struct task_struct * task;
>  	siginfo_t info;
>  	unsigned short cwd, swd;
>
> +	if ((regs->xcs & 3) == 0) {
> +		const struct exception_table_entry *fixup;
> +		fixup = search_exception_tables(regs->eip);
> +		if (fixup) {
> +			regs->eip = fixup->fixup;
> +			return;
> +		}
> +		die("kernel math error", regs, 0);
> +	}
> +
>  	/*
>  	 * Save the info for the exception handler and clear the error.
>  	 */
> @@ -719,15 +730,26 @@
>  asmlinkage void do_coprocessor_error(struct pt_regs * regs, long error_code)
>  {
>  	ignore_fpu_irq = 1;
> -	math_error((void *)regs->eip);
> +	math_error(regs);
>  }
>
> -void simd_math_error(void *eip)
> +void simd_math_error(struct pt_regs *regs)
>  {
> +	void *eip = (void *)regs->eip;
>  	struct task_struct * task;
>  	siginfo_t info;
>  	unsigned short mxcsr;
>
> +	if ((regs->xcs & 3) == 0) {
> +		const struct exception_table_entry *fixup;
> +		fixup = search_exception_tables(regs->eip);
> +		if (fixup) {
> +			regs->eip = fixup->fixup;
> +			return;
> +		}
> +		die("kernel math error", regs, 0);
> +	}
> +
>  	/*
>  	 * Save the info for the exception handler and clear the error.
>  	 */
> @@ -776,7 +798,7 @@
>  	if (cpu_has_xmm) {
>  		/* Handle SIMD FPU exceptions on PIII+ processors. */
>  		ignore_fpu_irq = 1;
> -		simd_math_error((void *)regs->eip);
> +		simd_math_error(regs);
>  	} else {
>  		/*
>  		 * Handle strange cache flush from user space exception
> diff -u linux-2.6.7rc3-bk3/arch/x86_64/kernel/traps.c-o linux-2.6.7rc3-bk3/arch/x86_64/kernel/traps.c
> --- linux-2.6.7rc3-bk3/arch/x86_64/kernel/traps.c-o	2004-06-11 03:02:42.000000000 +0200
> +++ linux-2.6.7rc3-bk3/arch/x86_64/kernel/traps.c	2004-06-12 22:00:28.000000000 +0200
> @@ -686,11 +686,25 @@
>   * the correct behaviour even in the presence of the asynchronous
>   * IRQ13 behaviour
>   */
> -void math_error(void *rip)
> +asmlinkage void do_coprocessor_error(struct pt_regs * regs)
>  {
> +	void *rip = (void *)regs->rip;
>  	struct task_struct * task;
>  	siginfo_t info;
>  	unsigned short cwd, swd;
> +
> +	conditional_sti(regs);
> +	if ((regs->cs & 3) == 0) {
> +		const struct exception_table_entry *fixup;
> +		fixup = search_exception_tables(regs->rip);
> +		if (fixup) {
> +			regs->rip = fixup->fixup;
> +			return;
> +		}
> +		notify_die(DIE_GPF, "kernel math error", regs, 0, 16, SIGFPE);
> +		die("kernel math error", regs, 0);
> +	}
> +
>  	/*
>  	 * Save the info for the exception handler and clear the error.
>  	 */
> @@ -740,23 +754,30 @@
>  	force_sig_info(SIGFPE, &info, task);
>  }
>
> -asmlinkage void do_coprocessor_error(struct pt_regs * regs)
> -{
> -	conditional_sti(regs);
> -	math_error((void *)regs->rip);
> -}
> -
>  asmlinkage void bad_intr(void)
>  {
>  	printk("bad interrupt");
>  }
>
> -static inline void simd_math_error(void *rip)
> +asmlinkage void do_simd_coprocessor_error(struct pt_regs * regs)
>  {
> +	void *rip = (void *)regs->rip;
>  	struct task_struct * task;
>  	siginfo_t info;
>  	unsigned short mxcsr;
>
> +	conditional_sti(regs);
> +	if ((regs->cs & 3) == 0) {
> +		const struct exception_table_entry *fixup;
> +		fixup = search_exception_tables(regs->rip);
> +		if (fixup) {
> +			regs->rip = fixup->fixup;
> +			return;
> +		}
> +		notify_die(DIE_GPF, "kernel simd error", regs, 0, 16, SIGFPE);
> +		die("kernel simd error", regs, 0);
> +	}
> +
>  	/*
>  	 * Save the info for the exception handler and clear the error.
>  	 */
> @@ -799,12 +820,6 @@
>  	force_sig_info(SIGFPE, &info, task);
>  }
>
> -asmlinkage void do_simd_coprocessor_error(struct pt_regs * regs)
> -{
> -	conditional_sti(regs);
> -		simd_math_error((void *)regs->rip);
> -}
> -
>  asmlinkage void do_spurious_interrupt_bug(struct pt_regs * regs)
>  {
>  }
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>
>
