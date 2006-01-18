Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751311AbWARBvd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751311AbWARBvd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Jan 2006 20:51:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751327AbWARBvd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Jan 2006 20:51:33 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:12451 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751311AbWARBvc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Jan 2006 20:51:32 -0500
Date: Tue, 17 Jan 2006 20:51:11 -0500
From: Vivek Goyal <vgoyal@in.ibm.com>
To: Fernando Luis Vazquez Cao <fernando@intellilink.co.jp>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, ak@suse.de,
       linux-kernel@vger.kernel.org, fastboot@lists.osdl.org
Subject: Re: [PATCH 5/5] stack overflow safe kdump (2.6.15-i386) - private nmi stack
Message-ID: <20060118015111.GD23143@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1137417926.2256.89.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1137417926.2256.89.camel@localhost.localdomain>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2006 at 10:25:26PM +0900, Fernando Luis Vazquez Cao wrote:
> Use a private NMI stack.
> 
> ---
> diff -urNp linux-2.6.15/arch/i386/kernel/irq.c
> linux-2.6.15-sov/arch/i386/kernel/irq.c
> --- linux-2.6.15/arch/i386/kernel/irq.c	2006-01-03 12:21:10.000000000
> +0900
> +++ linux-2.6.15-sov/arch/i386/kernel/irq.c	2006-01-16
> 22:04:07.000000000 +0900
> @@ -37,11 +37,6 @@ void ack_bad_irq(unsigned int irq)
>  /*
>   * per-CPU IRQ handling contexts (thread information and stack)
>   */
> -union irq_ctx {
> -	struct thread_info      tinfo;
> -	u32                     stack[THREAD_SIZE/sizeof(u32)];
> -};
> -
>  static union irq_ctx *hardirq_ctx[NR_CPUS];
>  static union irq_ctx *softirq_ctx[NR_CPUS];
>  #endif
> @@ -154,6 +149,8 @@ void irq_ctx_init(int cpu)
>  
>  	printk("CPU %u irqstacks, hard=%p soft=%p\n",
>  		cpu,hardirq_ctx[cpu],softirq_ctx[cpu]);
> +
> +	nmi_ctx_init(cpu);
>  }
>  
>  void irq_ctx_exit(int cpu)
> diff -urNp linux-2.6.15/arch/i386/kernel/traps.c
> linux-2.6.15-sov/arch/i386/kernel/traps.c
> --- linux-2.6.15/arch/i386/kernel/traps.c	2006-01-16 22:00:54.000000000
> +0900
> +++ linux-2.6.15-sov/arch/i386/kernel/traps.c	2006-01-16
> 22:05:51.000000000 +0900
> @@ -643,6 +643,13 @@ static int dummy_nmi_callback(struct pt_
>   
>  static nmi_callback_t nmi_callback = dummy_nmi_callback;
>  
> +#ifdef CONFIG_4KSTACKS
> +/*

Does not work for 8K stacks. Also we are switching the stack all the
time for NMI. I am not sure if that is really required (performance?).

Can't it be made to work both for 4K and 8K stack. And switch to reserved
stack on NMI, only if crash has happened.

> + * per-CPU NMI handling contexts (thread information and stack)
> + */
> +static union irq_ctx *nmi_ctx[NR_CPUS];
> +#endif /* CONFIG_4KSTACKS */
> +
>  static fastcall unsigned int __do_nmi(struct pt_regs * regs, long
> error_code)
>  {
>  	int cpu;
> @@ -657,7 +664,43 @@ static fastcall unsigned int __do_nmi(st
>  	return 0;
>  }
>  
> +#ifdef CONFIG_4KSTACKS
> +#define _do_nmi(regs, error_code, nmih)					\
> +{									\
> +	union irq_ctx *curctx, *nmictx;					\
> +	u32 *isp;							\
> +									\
> +	curctx = (union irq_ctx *) current_thread_info();		\
> +	nmictx = nmi_ctx[safe_smp_processor_id()];			\
> +									\
> +	/*								\
> +	 * This is where we switch to the NMI stack.			\
> +	 */								\
> +	if (curctx != nmictx) {						\
> +		int arg1, arg2, ebx;					\
> +									\
> +		/* build the stack frame on the IRQ stack */		\
> +		isp = (u32*) ((char *)nmictx + sizeof(*nmictx)); 	\
> +		if (!virt_addr_valid(curctx))				\
> +			nmictx->tinfo.task = NULL;			\
> +		else							\
> +			nmictx->tinfo.task = curctx->tinfo.task;	\
> +		nmictx->tinfo.previous_esp = current_stack_pointer;	\
> +									\
> +		asm volatile (						\
> +			"	xchgl	%%ebx,%%esp	\n"		\
> +			"	call	"#nmih"		\n"		\
> +			"	movl	%%ebx,%%esp	\n"		\
> +			: "=a" (arg1), "=d" (arg2), "=b" (ebx)		\
> +			:  "0" (regs),  "1" (error_code), "2" (isp)	\
> +			: "memory", "cc", "ecx"				\
> +		);							\
> +	} else								\
> +		nmih(regs, error_code);					\
> +}
> +#else /* CONFIG_4KSTACKS */
>  #define _do_nmi(regs, error_code, nmih) nmih(regs, error_code);
> +#endif /* CONFIG_4KSTACKS */
>  
>  fastcall void do_nmi(struct pt_regs * regs, long error_code)
>  {
> @@ -696,6 +739,46 @@ void set_crash_nmi_callback(nmi_callback
>  }
>  EXPORT_SYMBOL_GPL(set_crash_nmi_callback);
>  
> +#ifdef CONFIG_4KSTACKS
> +
> +/*
> + * These should really be __section__(".bss.page_aligned") as well, but
> + * gcc's 3.0 and earlier don't handle that correctly.
> + * NOTE: support for gcc 3.0 and earlier will eventually be dropped
> + */
> +
> +static char nmi_stack[NR_CPUS * THREAD_SIZE]
> +		__attribute__((__aligned__(THREAD_SIZE)));
> +
> +/*
> + * Allocate per-cpu stacks for NMI processing
> + */
> +void nmi_ctx_init(int cpu)
> +{
> +	union irq_ctx *irqctx;
> +
> +	if (nmi_ctx[cpu])
> +		return;
> +
> +	irqctx = (union irq_ctx*) &nmi_stack[cpu*THREAD_SIZE];
> +	irqctx->tinfo.task		= NULL;
> +	irqctx->tinfo.exec_domain	= NULL;
> +	irqctx->tinfo.cpu		= cpu;
> +	irqctx->tinfo.preempt_count	= HARDIRQ_OFFSET;
> +	irqctx->tinfo.addr_limit	= MAKE_MM_SEG(0);
> +
> +	nmi_ctx[cpu] = irqctx;
> +
> +	printk("CPU %u nmistack=%p\n", cpu, nmi_ctx[cpu]);
> +}
> +
> +void nmi_ctx_exit(int cpu)
> +{
> +	nmi_ctx[cpu] = NULL;
> +}
> +
> +#endif /* CONFIG_4KSTACKS */
> +
>  #ifdef CONFIG_KPROBES
>  fastcall void __kprobes do_int3(struct pt_regs *regs, long error_code)
>  {
> diff -urNp linux-2.6.15/include/asm-i386/irq.h
> linux-2.6.15-sov/include/asm-i386/irq.h
> --- linux-2.6.15/include/asm-i386/irq.h	2006-01-03 12:21:10.000000000
> +0900
> +++ linux-2.6.15-sov/include/asm-i386/irq.h	2006-01-16
> 22:04:07.000000000 +0900
> @@ -28,12 +28,21 @@ extern void release_vm86_irqs(struct tas
>  #endif
>  
>  #ifdef CONFIG_4KSTACKS
> -  extern void irq_ctx_init(int cpu);
> -  extern void irq_ctx_exit(int cpu);
> +union irq_ctx {
> +	struct thread_info	tinfo;
> +	u32			stack[THREAD_SIZE/sizeof(u32)];
> +};
> +
> +extern void irq_ctx_init(int cpu);
> +extern void irq_ctx_exit(int cpu);
> +extern void nmi_ctx_init(int cpu);
> +extern void nmi_ctx_exit(int cpu);
>  # define __ARCH_HAS_DO_SOFTIRQ
>  #else
>  # define irq_ctx_init(cpu) do { } while (0)
>  # define irq_ctx_exit(cpu) do { } while (0)
> +# define nmi_ctx_init(cpu) do { } while (0)
> +# define nmi_ctx_exit(cpu) do { } while (0)
>  #endif
>  
>  #ifdef CONFIG_IRQBALANCE
> 
> 
