Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750756AbVHHLTl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750756AbVHHLTl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 07:19:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbVHHLTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 07:19:41 -0400
Received: from mailfe06.swip.net ([212.247.154.161]:21225 "EHLO swip.net")
	by vger.kernel.org with ESMTP id S1750756AbVHHLTl (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 07:19:41 -0400
X-T2-Posting-ID: jLUmkBjoqvly7NM6d2gdCg==
Date: Mon, 8 Aug 2005 13:19:36 +0200
From: Alexander Nyberg <alexn@telia.com>
To: Karsten Wiese <annabellesgarden@yahoo.de>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] CHECK_IRQ_PER_CPU() to avoid dead code in __do_IRQ()
Message-ID: <20050808111936.GA1393@localhost.localdomain>
References: <200508081250.05673.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200508081250.05673.annabellesgarden@yahoo.de>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> IRQ_PER_CPU is not used by all architectures.
> This patch introduces the macros
> ARCH_HAS_IRQ_PER_CPU and CHECK_IRQ_PER_CPU() to avoid the generation of
> dead code in __do_IRQ().
> 
> ARCH_HAS_IRQ_PER_CPU is defined by architectures using
> IRQ_PER_CPU in their
>         include/asm_ARCH/irq.h
> file.
> 
> Through grepping the tree I found the following
> architectures currently use IRQ_PER_CPU:
> 
>         cris, ia64, ppc, ppc64 and parisc. 
> 

There are many places where one could replace run-time tests with 
#ifdef's but it makes reading more difficult (and in longer terms
maintainence). Have you benchmarked any workload that benefits 
from this?

> 
> diff -upr linux-2.6.13-rc6/include/asm-cris/irq.h linux-2.6.13/include/asm-cris/irq.h
> --- linux-2.6.13-rc6/include/asm-cris/irq.h	2005-08-08 11:46:10.000000000 +0200
> +++ linux-2.6.13/include/asm-cris/irq.h	2005-08-08 11:41:12.000000000 +0200
> @@ -1,6 +1,11 @@
>  #ifndef _ASM_IRQ_H
>  #define _ASM_IRQ_H
>  
> +/*
> + * IRQ line status macro IRQ_PER_CPU is used
> + */
> +#define ARCH_HAS_IRQ_PER_CPU
> +
>  #include <asm/arch/irq.h>
>  
>  extern __inline__ int irq_canonicalize(int irq)
> diff -upr linux-2.6.13-rc6/include/asm-ia64/irq.h linux-2.6.13/include/asm-ia64/irq.h
> --- linux-2.6.13-rc6/include/asm-ia64/irq.h	2005-03-02 08:38:33.000000000 +0100
> +++ linux-2.6.13/include/asm-ia64/irq.h	2005-08-06 18:06:53.000000000 +0200
> @@ -14,6 +14,11 @@
>  #define NR_IRQS		256
>  #define NR_IRQ_VECTORS	NR_IRQS
>  
> +/*
> + * IRQ line status macro IRQ_PER_CPU is used
> + */
> +#define ARCH_HAS_IRQ_PER_CPU
> +
>  static __inline__ int
>  irq_canonicalize (int irq)
>  {
> diff -upr linux-2.6.13-rc6/include/asm-parisc/irq.h linux-2.6.13/include/asm-parisc/irq.h
> --- linux-2.6.13-rc6/include/asm-parisc/irq.h	2005-08-08 11:45:26.000000000 +0200
> +++ linux-2.6.13/include/asm-parisc/irq.h	2005-08-06 18:05:22.000000000 +0200
> @@ -26,6 +26,11 @@
>  
>  #define NR_IRQS		(CPU_IRQ_MAX + 1)
>  
> +/*
> + * IRQ line status macro IRQ_PER_CPU is used
> + */
> +#define ARCH_HAS_IRQ_PER_CPU
> +
>  static __inline__ int irq_canonicalize(int irq)
>  {
>  	return (irq == 2) ? 9 : irq;
> diff -upr linux-2.6.13-rc6/include/asm-ppc/irq.h linux-2.6.13/include/asm-ppc/irq.h
> --- linux-2.6.13-rc6/include/asm-ppc/irq.h	2005-08-08 11:46:10.000000000 +0200
> +++ linux-2.6.13/include/asm-ppc/irq.h	2005-08-08 11:41:14.000000000 +0200
> @@ -19,6 +19,11 @@
>  #define IRQ_POLARITY_POSITIVE	0x2	/* high level or low->high edge */
>  #define IRQ_POLARITY_NEGATIVE	0x0	/* low level or high->low edge */
>  
> +/*
> + * IRQ line status macro IRQ_PER_CPU is used
> + */
> +#define ARCH_HAS_IRQ_PER_CPU
> +
>  #if defined(CONFIG_40x)
>  #include <asm/ibm4xx.h>
>  
> diff -upr linux-2.6.13-rc6/include/asm-ppc64/irq.h linux-2.6.13/include/asm-ppc64/irq.h
> --- linux-2.6.13-rc6/include/asm-ppc64/irq.h	2005-03-02 08:38:33.000000000 +0100
> +++ linux-2.6.13/include/asm-ppc64/irq.h	2005-08-06 18:06:58.000000000 +0200
> @@ -33,6 +33,11 @@
>  #define IRQ_POLARITY_POSITIVE	0x2	/* high level or low->high edge */
>  #define IRQ_POLARITY_NEGATIVE	0x0	/* low level or high->low edge */
>  
> +/*
> + * IRQ line status macro IRQ_PER_CPU is used
> + */
> +#define ARCH_HAS_IRQ_PER_CPU
> +
>  #define get_irq_desc(irq) (&irq_desc[(irq)])
>  
>  /* Define a way to iterate across irqs. */
> diff -upr linux-2.6.13-rc6/include/linux/irq.h linux-2.6.13/include/linux/irq.h
> --- linux-2.6.13-rc6/include/linux/irq.h	2005-08-08 11:46:10.000000000 +0200
> +++ linux-2.6.13/include/linux/irq.h	2005-08-08 11:55:11.000000000 +0200
> @@ -32,7 +32,12 @@
>  #define IRQ_WAITING	32	/* IRQ not yet seen - for autodetection */
>  #define IRQ_LEVEL	64	/* IRQ level triggered */
>  #define IRQ_MASKED	128	/* IRQ masked - shouldn't be seen again */
> -#define IRQ_PER_CPU	256	/* IRQ is per CPU */
> +#if defined(ARCH_HAS_IRQ_PER_CPU)
> +# define IRQ_PER_CPU	256	/* IRQ is per CPU */
> +# define CHECK_IRQ_PER_CPU(var) ((var) & IRQ_PER_CPU)
> +#else
> +# define CHECK_IRQ_PER_CPU(var) 0
> +#endif
>  
>  /*
>   * Interrupt controller descriptor. This is all we need
> diff -upr linux-2.6.13-rc6/kernel/irq/handle.c linux-2.6.13/kernel/irq/handle.c
> --- linux-2.6.13-rc6/kernel/irq/handle.c	2005-08-08 11:46:11.000000000 +0200
> +++ linux-2.6.13/kernel/irq/handle.c	2005-08-08 11:53:00.000000000 +0200
> @@ -111,7 +111,7 @@ fastcall unsigned int __do_IRQ(unsigned 
>  	unsigned int status;
>  
>  	kstat_this_cpu.irqs[irq]++;
> -	if (desc->status & IRQ_PER_CPU) {
> +	if (CHECK_IRQ_PER_CPU(desc->status)) {
>  		irqreturn_t action_ret;
>  
>  		/*
