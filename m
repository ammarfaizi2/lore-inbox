Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030306AbVIIT1n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030306AbVIIT1n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 15:27:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030305AbVIIT1m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 15:27:42 -0400
Received: from liaag1ae.mx.compuserve.com ([149.174.40.31]:47825 "EHLO
	liaag1ae.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1030306AbVIIT1m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 15:27:42 -0400
Date: Fri, 9 Sep 2005 15:25:54 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH] fix i386 double fault handler
To: Jan Beulich <JBeulich@novell.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200509091527_MC3-1-A9A7-F514@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <43215CC502000078000247E8@emea1-mh.id2.novell.com>

On Fri, 09 Sep 2005 at 09:58:29 +0200, Jan Beulich wrote:

> Make the double fault handler use CPU-specific stacks, add some
> abstraction to simplify future change of other exception handlers
> to go through task gates. Change the pointer validity checks in
> the double fault handler to account for the fact that both GDT
> and TSS aren't in static kernel space anymore.

 This is really nice.  Some comments, though:

> --- 2.6.13/arch/i386/kernel/cpu/common.c	2005-08-29 01:41:01.000000000 +0200
> +++ 2.6.13-i386-double-fault/arch/i386/kernel/cpu/common.c	2005-09-08 15:00:54.000000000 +0200
> @@ -4,6 +4,7 @@
>  #include <linux/smp.h>
>  #include <linux/module.h>
>  #include <linux/percpu.h>
> +#include <linux/bootmem.h>
>  #include <asm/semaphore.h>
>  #include <asm/processor.h>
>  #include <asm/i387.h>
> @@ -571,6 +572,7 @@ void __init early_cpu_init(void)
>  void __devinit cpu_init(void)
>  {
>  	int cpu = smp_processor_id();
> +	unsigned i;
>  	struct tss_struct * t = &per_cpu(init_tss, cpu);
>  	struct thread_struct *thread = &current->thread;
>  	__u32 stk16_off = (__u32)&per_cpu(cpu_16bit_stack, cpu);
> @@ -635,8 +637,57 @@ void __devinit cpu_init(void)
>  	load_TR_desc();
>  	load_LDT(&init_mm.context);
>  
> -	/* Set up doublefault TSS pointer in the GDT */
> -	__set_tss_desc(cpu, GDT_ENTRY_DOUBLEFAULT_TSS, &doublefault_tss);
> +#if EXCEPTION_STACK_ORDER > THREAD_ORDER
> +# error Assertion failed: EXCEPTION_STACK_ORDER <= THREAD_ORDER
> +#endif
> +	for (i = 0; i < N_EXCEPTION_TSS; ++i) {
> +		unsigned long stack;
> +
> +		/* Set up exception handling TSS */
> +		exception_tss[cpu][i].esp2 = cpu;
> +		exception_tss[cpu][i].esi = (unsigned long)&exception_tss[cpu][i];
> +
> +		/* Set up exception handling stacks */
> +#ifdef CONFIG_SMP
> +		if (cpu) {
> +			stack = __get_free_pages(GFP_ATOMIC, THREAD_ORDER);
> +			if (!stack)
> +				panic("Cannot allocate exception stack %u %d\n",
> +				      i,
> +				      cpu);

  Indent gone wild?

> +		}
> +		else
> +#endif
> +			stack = (unsigned long)__alloc_bootmem(EXCEPTION_STKSZ,
> +			                                       THREAD_SIZE,
> +			                                       __pa(MAX_DMA_ADDRESS));
> +		stack += EXCEPTION_STKSZ;
> +		exception_tss[cpu][i].esp = exception_tss[cpu][i].esp0 = stack;

  Please don't cascade assignments like that.  It's much more obvious
when it's like this:

		exception_tss[cpu][i].esp = stack;
		exception_tss[cpu][i].esp0 = stack;

> +#ifdef CONFIG_SMP
> +		if (cpu) {
> +			unsigned j;
> +
> +			for (j = EXCEPTION_STACK_ORDER; j < THREAD_ORDER; ++j) {
> +				/* set_page_refs sets the page count only for the first
> +				   page, but since we split the larger-order page here,
> +				   we need to adjust the page count before freeing the
> +				   pieces. */
> +				struct page * page = virt_to_page((void *)stack);
> +
> +				BUG_ON(page_count(page));
> +				set_page_count(page, 1);
> +				free_pages(stack, j);
> +				stack += (PAGE_SIZE << j);
> +			}
> +		}
> +		else
> +#endif
> +		if (EXCEPTION_STACK_ORDER > THREAD_ORDER)
> +			free_bootmem(stack, THREAD_SIZE - EXCEPTION_STKSZ);

  This comparison should be "if (EXCEPTION_STACK_ORDER < THREAD_ORDER)"

> +
> +		/* Set up exception handling TSS pointer in the GDT */
> +		__set_tss_desc(cpu, GDT_ENTRY_EXCEPTION_TSS + i, &exception_tss[cpu][i]);
> +	}
>  
>  	/* Clear %fs and %gs. */
>  	asm volatile ("xorl %eax, %eax; movl %eax, %fs; movl %eax, %gs");


> --- 2.6.13/arch/i386/kernel/head.S	2005-08-29 01:41:01.000000000 +0200
> +++ 2.6.13-i386-double-fault/arch/i386/kernel/head.S	2005-09-01 13:06:01.000000000 +0200
> @@ -475,9 +475,9 @@ ENTRY(boot_gdt_table)
>  	.quad 0x00cf92000000ffff	/* kernel 4GB data at 0x00000000 */
>  
>  /*
> - * The Global Descriptor Table contains 28 quadwords, per-CPU.
> + * The Global Descriptor Table contains at least 31 quadwords, per-CPU.
>   */
> -	.align PAGE_SIZE_asm
> +	.align L1_CACHE_BYTES
>  ENTRY(cpu_gdt_table)
>  	.quad 0x0000000000000000	/* NULL descriptor */
>  	.quad 0x0000000000000000	/* 0x0b reserved */
> @@ -515,9 +515,5 @@ ENTRY(cpu_gdt_table)
>  	.quad 0x0040920000000000	/* 0xc8 APM DS    data */
>  
>  	.quad 0x0000920000000000	/* 0xd0 - ESPFIX 16-bit SS */
> -	.quad 0x0000000000000000	/* 0xd8 - unused */
> -	.quad 0x0000000000000000	/* 0xe0 - unused */
> -	.quad 0x0000000000000000	/* 0xe8 - unused */
> -	.quad 0x0000000000000000	/* 0xf0 - unused */

  Could you leave these in?  They make it easier to see they're available.

> -	.quad 0x0000000000000000	/* 0xf8 - GDT entry 31: double-fault TSS */
> -
> +	/* remaining entries run-time initialized */

  A better comment would help here.

> +	.fill GDT_ENTRIES - (. - cpu_gdt_table) / 8, 8, 0
__
Chuck
Subliminal URL: www.sluggy.com/daily.php?date=050905
