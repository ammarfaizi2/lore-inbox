Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964800AbWHWKJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964800AbWHWKJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Aug 2006 06:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964810AbWHWKJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Aug 2006 06:09:28 -0400
Received: from cantor2.suse.de ([195.135.220.15]:40921 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964800AbWHWKJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Aug 2006 06:09:27 -0400
To: Stephane Eranian <eranian@frankl.hpl.hp.com>
Cc: eranian@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/18] 2.6.17.9 perfmon2 patch for review: modified x86_64 files
References: <200608230806.k7N8689P000540@frankl.hpl.hp.com>
From: Andi Kleen <ak@suse.de>
Date: 23 Aug 2006 12:09:25 +0200
In-Reply-To: <200608230806.k7N8689P000540@frankl.hpl.hp.com>
Message-ID: <p73k64z7oh6.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian <eranian@frankl.hpl.hp.com> writes:

In general this stuff would be much easier to review if you
really split it into logical pieces: this means not modified/new,
but one patch doing one thing. Then the hooks could be reviewed
together with the code.

> @@ -934,6 +935,7 @@ void setup_threshold_lvt(unsigned long l
>  void smp_local_timer_interrupt(struct pt_regs *regs)
>  {
>  	profile_tick(CPU_PROFILING, regs);
> + 	pfm_handle_switch_timeout();

It is still unclear why you can't use an ordinary add_timer() ?

>  #include <asm/atomic.h>
> @@ -589,6 +590,8 @@ void __init init_IRQ(void)
>  	/* IPI vectors for APIC spurious and error interrupts */
>  	set_intr_gate(SPURIOUS_APIC_VECTOR, spurious_interrupt);
>  	set_intr_gate(ERROR_APIC_VECTOR, error_interrupt);
> +
> + 	pfm_vector_init();

I think I would prefer those to be expanded here so it's all in one place.

>  		put_cpu();
>  	}
> +	pfm_exit_thread(me);
>  }
>  
>  void flush_thread(void)
> @@ -462,6 +464,8 @@ int copy_thread(int nr, unsigned long cl
>  	asm("mov %%es,%0" : "=m" (p->thread.es));
>  	asm("mov %%ds,%0" : "=m" (p->thread.ds));
>  
> +	pfm_copy_thread(p);
> +

AFAIK there was some work in -mm* for generic notifiers for exit/copy hooks. Can those
be used?


>  	if (unlikely(test_tsk_thread_flag(me, TIF_IO_BITMAP))) {
>  		p->thread.io_bitmap_ptr = kmalloc(IO_BITMAP_BYTES, GFP_KERNEL);
>  		if (!p->thread.io_bitmap_ptr) {
> @@ -532,6 +536,10 @@ static noinline void __switch_to_xtra(st
>  		 */
>  		memset(tss->io_bitmap, 0xff, prev->io_bitmap_max);
>  	}
> +
> +	if (test_tsk_thread_flag(next_p, TIF_PERFMON)
> +	    || test_tsk_thread_flag(prev_p, TIF_PERFMON))
> +		pfm_ctxsw(prev_p, next_p);
>  }
>  
>  /*
> @@ -620,13 +628,12 @@ __switch_to(struct task_struct *prev_p, 
>  	unlazy_fpu(prev_p);
>  	write_pda(kernelstack,
>  		  task_stack_page(next_p) + THREAD_SIZE - PDA_STACKOFFSET);
> -
> -	/*
> -	 * Now maybe reload the debug registers and handle I/O bitmaps
> -	 */
> -	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW))
> -	    || test_tsk_thread_flag(prev_p, TIF_IO_BITMAP))
> -		__switch_to_xtra(prev_p, next_p, tss);
> +  	/*
> + 	 * Now maybe reload the debug registers and handle I/O bitmaps
> +  	 */
> + 	if (unlikely((task_thread_info(next_p)->flags & _TIF_WORK_CTXSW)
> + 	    || (task_thread_info(prev_p)->flags & _TIF_WORK_CTXSW)))
> + 		__switch_to_xtra(prev_p, next_p, tss);


This should be a separate patch for once (creating _TIF_WORK_CTXSW)

>  
>  	return prev_p;
>  }
> diff -urp linux-2.6.17.9.base/arch/x86_64/kernel/signal.c linux-2.6.17.9/arch/x86_64/kernel/signal.c
> --- linux-2.6.17.9.base/arch/x86_64/kernel/signal.c	2006-08-18 09:26:24.000000000 -0700
> +++ linux-2.6.17.9/arch/x86_64/kernel/signal.c	2006-08-21 03:37:46.000000000 -0700
> @@ -24,6 +24,7 @@
>  #include <linux/stddef.h>
>  #include <linux/personality.h>
>  #include <linux/compiler.h>
> +#include <linux/perfmon.h>
>  #include <asm/ucontext.h>
>  #include <asm/uaccess.h>
>  #include <asm/i387.h>
> @@ -493,6 +494,8 @@ void do_notify_resume(struct pt_regs *re
>  		clear_thread_flag(TIF_SINGLESTEP);
>  	}
>  
> +	pfm_handle_work(current);

At least the if () should be expanded, and most likely it wants
merging with other flags too similar to the context switch (if (any work) { check which work })
In separate patches again please.


> +
>  	/* deal with pending signal delivery */
>  	if (thread_info_flags & _TIF_SIGPENDING)
>  		do_signal(regs,oldset);
> Only in linux-2.6.17.9/arch/x86_64: perfmon
> diff -urp linux-2.6.17.9.base/include/asm-x86_64/hw_irq.h linux-2.6.17.9/include/asm-x86_64/hw_irq.h
> --- linux-2.6.17.9.base/include/asm-x86_64/hw_irq.h	2006-08-18 09:26:24.000000000 -0700
> +++ linux-2.6.17.9/include/asm-x86_64/hw_irq.h	2006-08-21 03:37:46.000000000 -0700
> @@ -67,6 +67,7 @@ struct hw_interrupt_type;
>   * sources per level' errata.
>   */
>  #define LOCAL_TIMER_VECTOR	0xef
> +#define LOCAL_PERFMON_VECTOR	0xee
>  
>  /*
>   * First APIC vector available to drivers: (vectors 0x30-0xee)
> @@ -74,7 +75,7 @@ struct hw_interrupt_type;
>   * levels. (0x80 is the syscall vector)
>   */
>  #define FIRST_DEVICE_VECTOR	0x31
> -#define FIRST_SYSTEM_VECTOR	0xef   /* duplicated in irq.h */
> +#define FIRST_SYSTEM_VECTOR	0xee   /* duplicated in irq.h */

We still had one up free iirc so there is no need to move the system vectors.

-Andi
