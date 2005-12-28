Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932467AbVL1EZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932467AbVL1EZq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 23:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932469AbVL1EZq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 23:25:46 -0500
Received: from waste.org ([64.81.244.121]:60331 "EHLO waste.org")
	by vger.kernel.org with ESMTP id S932467AbVL1EZp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 23:25:45 -0500
Date: Tue, 27 Dec 2005 22:22:32 -0600
From: Matt Mackall <mpm@selenic.com>
To: "Bryan O'Sullivan" <bos@pathscale.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, hch@infradead.org
Subject: Re: [PATCH 2 of 3] memcpy32 for x86_64
Message-ID: <20051228042232.GC3356@waste.org>
References: <patchbomb.1135726914@eng-12.pathscale.com> <042b7d9004acd65f6655.1135726916@eng-12.pathscale.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <042b7d9004acd65f6655.1135726916@eng-12.pathscale.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 27, 2005 at 03:41:56PM -0800, Bryan O'Sullivan wrote:
> Introduce an x86_64-specific memcpy32 routine.  The routine is similar
> to memcpy, but is guaranteed to work in units of 32 bits at a time.
> 
> Signed-off-by: Bryan O'Sullivan <bos@pathscale.com>
> 
> diff -r 7b7b442a4d63 -r 042b7d9004ac arch/x86_64/kernel/x8664_ksyms.c
> --- a/arch/x86_64/kernel/x8664_ksyms.c	Tue Dec 27 15:41:48 2005 -0800
> +++ b/arch/x86_64/kernel/x8664_ksyms.c	Tue Dec 27 15:41:48 2005 -0800
> @@ -150,6 +150,8 @@
>  extern void * memcpy(void *,const void *,__kernel_size_t);
>  extern void * __memcpy(void *,const void *,__kernel_size_t);
>  
> +extern void memcpy32(void *,const void *,__kernel_size_t);

It's better to do an include here. Duplicating prototypes in .c files
is frowned upon (despite the fact that it's already done here).

> +
>  EXPORT_SYMBOL(memset);
>  EXPORT_SYMBOL(strlen);
>  EXPORT_SYMBOL(memmove);
> @@ -164,6 +166,8 @@
>  EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(__memcpy);
>  
> +EXPORT_SYMBOL_GPL(memcpy32);
> +

We've been steadily moving towards grouping EXPORTs with function
definitions. Do *_ksyms.c exist solely to provide exports for
functions defined in assembly at this point? If so, perhaps we ought
to come up with a suitable export macro for asm files.

> diff -r 7b7b442a4d63 -r 042b7d9004ac arch/x86_64/lib/memcpy32.S
> --- /dev/null	Thu Jan  1 00:00:00 1970 +0000
> +++ b/arch/x86_64/lib/memcpy32.S	Tue Dec 27 15:41:48 2005 -0800
> @@ -0,0 +1,25 @@
> +/*
> + * Copyright (c) 2003, 2004, 2005 PathScale, Inc.
> + */
> +
> +/*
> + * memcpy32 - Copy a memory block, 32 bits at a time.
> + *
> + * Count is number of dwords; it need not be a qword multiple.
> + * Input:
> + * rdi destination
> + * rsi source
> + * rdx count
> + */
> +
> + 	.globl memcpy32
> +memcpy32:
> +	movl %edx,%ecx
> +	shrl $1,%ecx
> +	andl $1,%edx
> +	rep
> +	movsq
> +	movl %edx,%ecx
> +	rep
> +	movsd
> +	ret

Any reason this needs its own .S file? One wonders if the

        .p2align 4

in memcpy.S is appropriate here too. Splitting rep movsq across two
lines is a little weird to me too, but I see Andi did it too.

-- 
Mathematics is the supreme nostalgia of our time.
