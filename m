Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262278AbVHCNFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262278AbVHCNFq (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Aug 2005 09:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262283AbVHCNFq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Aug 2005 09:05:46 -0400
Received: from ns.suse.de ([195.135.220.2]:51869 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S262278AbVHCNFg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Aug 2005 09:05:36 -0400
Date: Wed, 3 Aug 2005 15:05:31 +0200
From: Andi Kleen <ak@suse.de>
To: Tom Rini <trini@kernel.crashing.org>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, ak@suse.de,
       amitkale@linsyssoft.com
Subject: Re: [patch 07/15] Basic x86_64 support
Message-ID: <20050803130531.GR10895@wotan.suse.de>
References: <resend.6.2972005.trini@kernel.crashing.org> <1.2972005.trini@kernel.crashing.org> <resend.7.2972005.trini@kernel.crashing.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <resend.7.2972005.trini@kernel.crashing.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Only reading the changes outside kgdb.c....

> +
> +#ifdef CONFIG_KGDB
> +	/*
> +	 * Has KGDB been told to break as soon as possible?
> +	 */
> +	if (kgdb_initialized == -1)
> +		tasklet_schedule(&kgdb_tasklet_breakpoint);

That doesn't make much sense here. tasklet will only run when interrupts
are enabled, and that is much later. You could move it to there.

> diff -puN include/asm-x86_64/hw_irq.h~x86_64-lite include/asm-x86_64/hw_irq.h
> --- linux-2.6.13-rc3/include/asm-x86_64/hw_irq.h~x86_64-lite	2005-07-29 13:19:10.000000000 -0700
> +++ linux-2.6.13-rc3-trini/include/asm-x86_64/hw_irq.h	2005-07-29 13:19:10.000000000 -0700
> @@ -55,6 +55,7 @@ struct hw_interrupt_type;
>  #define TASK_MIGRATION_VECTOR	0xfb
>  #define CALL_FUNCTION_VECTOR	0xfa
>  #define KDB_VECTOR	0xf9
> +#define KGDB_VECTOR	0xf8

I already allocated these vectors for something else.


>  #define THERMAL_APIC_VECTOR	0xf0
>  
> diff -puN include/asm-x86_64/ipi.h~x86_64-lite include/asm-x86_64/ipi.h
> --- linux-2.6.13-rc3/include/asm-x86_64/ipi.h~x86_64-lite	2005-07-29 13:19:10.000000000 -0700
> +++ linux-2.6.13-rc3-trini/include/asm-x86_64/ipi.h	2005-07-29 13:19:10.000000000 -0700
> @@ -62,6 +62,12 @@ static inline void __send_IPI_shortcut(u
>  	 * No need to touch the target chip field
>  	 */
>  	cfg = __prepare_ICR(shortcut, vector, dest);
> +        if (vector == KGDB_VECTOR) {
> +                 /*
> +                  * KGDB IPI is to be delivered as a NMI
> +                  */
> +                 cfg = (cfg&~APIC_VECTOR_MASK)|APIC_DM_NMI;
> +         }

No way adding another ugly special case like this. I wanted
to rip out the KDB version for a long time.


If anything pass a flag.

>  	,"rcx","rbx","rdx","r8","r9","r10","r11","r12","r13","r14","r15"
>  
>  #define switch_to(prev,next,last) \
> -	asm volatile(SAVE_CONTEXT						    \
> +       asm volatile(".globl __switch_to_begin\n\t"				    \
> +		     "__switch_to_begin:\n\t"					  \
> +		     SAVE_CONTEXT						  \

Why is this needed?

-Andi
