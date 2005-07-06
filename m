Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262130AbVGFFdG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262130AbVGFFdG (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 01:33:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbVGFFcF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 01:32:05 -0400
Received: from fsmlabs.com ([168.103.115.128]:5024 "EHLO fsmlabs.com")
	by vger.kernel.org with ESMTP id S261657AbVGFDso (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 23:48:44 -0400
Date: Tue, 5 Jul 2005 21:53:12 -0600 (MDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Nigel Cunningham <nigel@suspend2.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [19/48] Suspend2 2.1.9.8 for 2.6.12: 510-version-specific-mac.patch
In-Reply-To: <11206164411926@foobar.com>
Message-ID: <Pine.LNX.4.61.0507052145470.2149@montezuma.fsmlabs.com>
References: <11206164411926@foobar.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 6 Jul 2005, Nigel Cunningham wrote:

> +	/*
> +	 * eflags
> +	 */
> +	asm volatile ("pushfl ; popl (%0)" : "=m" (suspend2_saved_context.eflags));

To be future proof you probably want to do pushfq/popq

> +
> +	/*
> +	 * control registers 
> +	 */
> +	asm volatile ("movl %%cr0, %0" : "=r" (suspend2_saved_context.cr0));
> +	asm volatile ("movl %%cr2, %0" : "=r" (suspend2_saved_context.cr2));
> +	asm volatile ("movl %%cr3, %0" : "=r" (suspend2_saved_context.cr3));
> +	asm volatile ("movl %%cr4, %0" : "=r" (suspend2_saved_context.cr4));

I guess we don't have to worry about %cr8 for now?

> + * a little clearer, but it needs to be inlined because we won't have a
> + * stack when we get here (so we can't push a return address).
> + */
> +static inline void restore_processor_context(void)
> +{
> +	/*
> +	 * first restore %ds, so we can access our data properly
> +	 */
> +	//asm volatile ("movw %0, %%ds" :: "r" ((u16)__KERNEL_DS));
> +	
> +	__flush_tlb_global(); /* INLINE? */
> +
> +	asm volatile ("movl	$24, %eax");
> +	asm volatile ("movl	%eax, %ds");

Shouldn't that be KERNEL_DS?

> +	asm volatile ("pushl %0 ; popfl" :: "m" (suspend2_saved_context.eflags));

pushq/popfq?

> +	save_and_set_irq_affinity();
> +	
> +	c_loops_per_jiffy_ref[_smp_processor_id()] = current_cpu_data.loops_per_jiffy;
> +#ifndef CONFIG_SMP
> +	cpu_khz_ref = cpu_khz;
> +	c_loops_per_jiffy_ref[_smp_processor_id()] = loops_per_jiffy;
> +#endif
> +	
> +	/* We want to run from swsusp_pg_dir, since swsusp_pg_dir is stored in constant
> +	 * place in memory 
> +	 */
> +
> +        __asm__( "movl %%ecx,%%cr3\n" ::"c"(__pa(swsusp_pg_dir)));

This looks like it depends on the swsusp_pg_dir being in lower 32bit 
address space, shouldn't it be a movq %%rcx?
