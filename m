Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750859AbWBVWaH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750859AbWBVWaH (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 17:30:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751447AbWBVWaH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 17:30:07 -0500
Received: from smtp.osdl.org ([65.172.181.4]:21476 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1750859AbWBVWaF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 17:30:05 -0500
Date: Wed, 22 Feb 2006 14:32:12 -0800
From: Andrew Morton <akpm@osdl.org>
To: Jan Beulich <jbeulich@novell.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 double fault enhancements
Message-Id: <20060222143212.0eea2ab0.akpm@osdl.org>
In-Reply-To: <200602221159.08969.jbeulich@novell.com>
References: <200602221159.08969.jbeulich@novell.com>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan Beulich <jbeulich@novell.com> wrote:
>
> Make the double fault handler use CPU-specific stacks. Add some
> abstraction to simplify future change of other exception handlers to go
> through task gates. Change the pointer validity checks in the double
> fault handler to account for the fact that both GDT and TSS aren't in
> static kernel space anymore. Add a new notification of the event
> through the die notifier chain, also providing some environmental
> adjustments so that various infrastructural things work independent of
> the fact that the fault and the callbacks are running on other then the
> normal kernel stack.

Why?

> +# ifdef CONFIG_SMP

Please don't bother with the space after the #.  Yes, it's for nesting
level, but if someone later comes along and sticks more ifdefs around this
code, they won't go through and add the extra spaces anyway.

Such problems can be avoided by not adding the ifdefs at all..

> +#ifdef N_EXCEPTION_TSS

Can't we use CONFIG_DOUBLEFAULT throughout?  It's very much clearer.

> +struct tss_struct exception_tss[NR_CPUS][N_EXCEPTION_TSS] __cacheline_aligned = {
> +	[0 ... NR_CPUS-1] = {
> +		[0 ... N_EXCEPTION_TSS-1] = {
> +			.cs       = __KERNEL_CS,
> +			.ss       = __KERNEL_DS,
> +			.ss0      = __KERNEL_DS,
> +			.__cr3    = __pa(swapper_pg_dir),
> +			.io_bitmap_base = INVALID_IO_BITMAP_OFFSET,
> +			.ds       = __USER_DS,
> +			.es       = __USER_DS,
> +			.eflags	  = X86_EFLAGS_SF | 0x2, /* 0x2 bit is always set */
> +		},
> +		[DOUBLEFAULT_TSS].eip = (unsigned long)doublefault_fn
> +	}
> +};
> +#endif

How much more RAM does this patch consume?

> +#define EXCEPTION_STKSZ (PAGE_SIZE << EXCEPTION_STACK_ORDER)

"EXCEPTION_STACK_SIZE", please.

