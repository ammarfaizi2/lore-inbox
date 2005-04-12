Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262099AbVDLKQB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262099AbVDLKQB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:16:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbVDLKQB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:16:01 -0400
Received: from fire.osdl.org ([65.172.181.4]:19140 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262099AbVDLKPM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:15:12 -0400
Date: Tue, 12 Apr 2005 03:15:02 -0700
From: Andrew Morton <akpm@osdl.org>
To: jes@trained-monkey.org (Jes Sorensen)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] genalloc for 2.6.12-rc-mm3
Message-Id: <20050412031502.3b5d39fc.akpm@osdl.org>
In-Reply-To: <16987.39669.285075.730484@jaguar.mkp.net>
References: <16987.39669.285075.730484@jaguar.mkp.net>
X-Mailer: Sylpheed version 1.0.0 (GTK+ 1.2.10; i386-vine-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

jes@trained-monkey.org (Jes Sorensen) wrote:
>
> Hi Andrew,
> 
> This patch provides the generic allocator needed for the ia64 mspec
> driver. Any chance you could add it to the mm tree?

spose so.  Glad it's Kconfigurable.

> +#ifdef CONFIG_GENERIC_ALLOCATOR
> +	gen_pool_init();
> +#endif

Suggest you put a !CONFIG_GENERIC_ALLOCATOR stub in genpool.h, remove these
ifdefs.

> +# Generic allocator support is selected if needed
> +#
> +config GENERIC_ALLOCATOR
> +	boolean

This will be turned on by some later patch, yes?

So will this code even be compiled in -mm?  I guess allyesconfig will
enable it.


> +
> +struct gen_pool *alloc_gen_pool(int nr_chunks, int max_chunk_shift,
> +				unsigned long (*fp)(struct gen_pool *),
> +				unsigned long data)

Some API kerneldocs would be useful.

> +	/*
> +	 * This is really an arbitrary limit, +10 is enough for
> +	 * IA64_GRANULE_SHIFT.
> +	 */
> +	if ((max_chunk_shift > (PAGE_SHIFT + 10)) || 
> +	    ((max_chunk_shift < ALLOC_MIN_SHIFT) && max_chunk_shift))
> +		return NULL;

Does this ia64ism restrict the usefulness of genalloc in any way, or is the
comment stale?

> + *  Simple power of two buddy-like generic allocator.
> + *  Provides naturally aligned memory chunks.
> + */
> +unsigned long gen_pool_alloc(struct gen_pool *poolp, int size)
> +{
> +	int j, i, s, max_chunk_size;
> +	unsigned long a, flags;
> +	struct gen_pool_link *h = poolp->h;
> +
> +	max_chunk_size = 1 << poolp->max_chunk_shift;
> +
> +	if (size > max_chunk_size)
> +		return 0;
> +
> +	i = 0;
> +	s = (1 << ALLOC_MIN_SHIFT);
> +	while (size > s) {
> +		s <<= 1;
> +		i++;
> +	}

roundup_pow_of_two()?

> +#if DEBUG
> +	printk(KERN_DEBUG "gen_pool_alloc: s %02x, i %i, h %p\n", s, i, h);
> +#endif

dprintk?

> +	j = i;
> +
> +	spin_lock_irqsave(&poolp->lock, flags);
> +	while (!h[j].next) {
> +		if (s == max_chunk_size) {
> +			struct gen_pool_link *ptr;
> +			spin_unlock_irqrestore(&poolp->lock, flags);
> +			ptr = (struct gen_pool_link *)poolp->get_new_chunk(poolp);

mabe get_new_chunk() should return void*, avoid the casting?

> +#if DEBUG
> +			printk(KERN_DEBUG "gen_pool_alloc() splitting i %i j %i %x a %02lx\n", i, j, s, a);
> +#endif

You once sent me a rude email for putting a line >80 cols into acenic.c

> +		return;
> +
> +	i = 0;
> +	while (size > s) {
> +		s <<= 1;
> +		i++;
> +	}

roundup_pow_of_two()?

> +		while (q->next && q->next != (struct gen_pool_link *)b) {
> +			q = q->next;
> +		}

braces?

> +int __init gen_pool_init(void)
> +{
> +	printk(KERN_INFO "Generic memory pool allocator v1.0\n");
> +	return 0;

Do we need the printk?

> +
> +EXPORT_SYMBOL(alloc_gen_pool);
> +EXPORT_SYMBOL(gen_pool_alloc);
> +EXPORT_SYMBOL(gen_pool_free);

Current style is usually to put the exports at the line after the
function's closing brace.  I prefer that personally - it's easier to
locate.

