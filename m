Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262078AbVDLKN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262078AbVDLKN2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 06:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262096AbVDLKN1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 06:13:27 -0400
Received: from pentafluge.infradead.org ([213.146.154.40]:7855 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262078AbVDLKNN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:13:13 -0400
Date: Tue, 12 Apr 2005 11:13:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Jes Sorensen <jes@trained-monkey.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] genalloc for 2.6.12-rc-mm3
Message-ID: <20050412101311.GA2358@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Jes Sorensen <jes@trained-monkey.org>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
References: <16987.39669.285075.730484@jaguar.mkp.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=unknown-8bit
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16987.39669.285075.730484@jaguar.mkp.net>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 12, 2005 at 05:55:01AM -0400, Jes Sorensen wrote:
> Hi Andrew,
> 
> This patch provides the generic allocator needed for the ia64 mspec
> driver. Any chance you could add it to the mm tree?
> 
> Thanks,
> Jes
> 
> Generic allocator that can  be used by device driver to manage special
> memory etc. in particular it's used to manage uncached memory on ia64
> for the mspec driver. The allocator is based on the allocator from the
> sym53c8xx_2 driver.

So maybe as an example that your driver is usefull and not just additional
bloat you could convert sym53c8xx_2 (and ncr53c8xxx) to use it?

> +/*
> + *  Memory pool of a given kind.
> + *  Ideally, we want to use:
> + *  1) 1 pool for memory we donnot need to involve in DMA.
> + *  2) The same pool for controllers that require same DMA 
> + *     constraints and features.
> + *     The OS specific m_pool_id_t thing and the gen_pool_match() 
> + *     method are expected to tell the driver about.
> + */

these comments don't make any sense.

> +unsigned long gen_pool_alloc(struct gen_pool *poolp, int size);
> +void gen_pool_free(struct gen_pool *mp, unsigned long ptr, int size);
> +struct gen_pool *alloc_gen_pool(int nr_chunks, int max_chunk_shift,
> +				unsigned long (*fp)(struct gen_pool *),
> +				unsigned long data);

shouldn't there be a way to release the pool again?  Also we usuælly
call these _create/_destroy

> +#ifdef CONFIG_GENERIC_ALLOCATOR
> +	gen_pool_init();
> +#endif

please avoid hardcoded initcalls.

> +config GENERIC_ALLOCATOR
> +	boolean

	bool

> +#include <linux/config.h>

not needed.

> +#include <linux/module.h>
> +#include <linux/stddef.h>
> +#include <linux/kernel.h>
> +#include <linux/string.h>
> +#include <linux/slab.h>
> +#include <linux/init.h>
> +#include <linux/mm.h>
> +#include <linux/spinlock.h>
> +#include <linux/genalloc.h>
> +
> +#include <asm/page.h>
> +#include <asm/pal.h>
> +
> +

> +	/*
> +	 * This is really an arbitrary limit, +10 is enough for
> +	 * IA64_GRANULE_SHIFT.
> +	 */

What's IA64_GRANULE_SHIFT and why do we care?

> +#if DEBUG
> +	printk(KERN_DEBUG "gen_pool_alloc: s %02x, i %i, h %p\n", s, i, h);
> +#endif

please avoid ifdefs in the middle of the code.  if you think keeping this
trivial debug code in is so valueable add a helper that gets defined away
for the non-debug case.

> +int __init gen_pool_init(void)
> +{
> +	printk(KERN_INFO "Generic memory pool allocator v1.0\n");
> +	return 0;
> +}

no need to print a init message for a set of trivial library function

