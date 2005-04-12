Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262353AbVDLN1e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262353AbVDLN1e (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 09:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262457AbVDLNYt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 09:24:49 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:14745 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S262353AbVDLNUn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 09:20:43 -0400
To: Christoph Hellwig <hch@infradead.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [patch] genalloc for 2.6.12-rc-mm3
References: <16987.39669.285075.730484@jaguar.mkp.net>
	<20050412101311.GA2358@infradead.org>
From: Jes Sorensen <jes@wildopensource.com>
Date: 12 Apr 2005 09:20:20 -0400
In-Reply-To: <20050412101311.GA2358@infradead.org>
Message-ID: <yq0ekdg1697.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=latin-iso8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Christoph" == Christoph Hellwig <hch@infradead.org> writes:

Christoph> On Tue, Apr 12, 2005 at 05:55:01AM -0400, Jes Sorensen
Christoph> wrote:
>> Generic allocator that can be used by device driver to manage
>> special memory etc. in particular it's used to manage uncached
>> memory on ia64 for the mspec driver. The allocator is based on the
>> allocator from the sym53c8xx_2 driver.

Thanks for the comments, I'm working my way through them. I'll post a
patch in response to Andrew's comments with all the changes.

Christoph> So maybe as an example that your driver is usefull and not
Christoph> just additional bloat you could convert sym53c8xx_2 (and
Christoph> ncr53c8xxx) to use it?

I know Matthew has been making a lot of changes to the sym2 driver and
I don't really want to get in his way at the moment.

>> +/* + * Memory pool of a given kind.  + * Ideally, we want to use:
>> + * 1) 1 pool for memory we donnot need to involve in DMA.  + * 2)
>> The same pool for controllers that require same DMA + * constraints
>> and features.  + * The OS specific m_pool_id_t thing and the
>> gen_pool_match() + * method are expected to tell the driver about.
>> + */

Christoph> these comments don't make any sense.

They're now gone ;)

>> +unsigned long gen_pool_alloc(struct gen_pool *poolp, int size);
>> +void gen_pool_free(struct gen_pool *mp, unsigned long ptr, int
>> size); +struct gen_pool *alloc_gen_pool(int nr_chunks, int
>> max_chunk_shift, + unsigned long (*fp)(struct gen_pool *), +
>> unsigned long data);

Christoph> shouldn't there be a way to release the pool again?  Also
Christoph> we usuælly call these _create/_destroy

Changed it to _create. Doing a _destroy doesn't make all that much
sense, in most cases the memory in use wouldn't come from the kmalloc
pool but either be device special memory or memory converted from
cached to uncached on ia64 which isn't trivial to take back and
forth. It could be done but the practical use for it would be very
limited imho.

>> +#ifdef CONFIG_GENERIC_ALLOCATOR + gen_pool_init(); +#endif

Christoph> please avoid hardcoded initcalls.

It has to be done prior to potential users.

>> +#include <linux/config.h>

Christoph> not needed.

Gone

>> +#include <linux/module.h> +#include <linux/stddef.h> +#include
>> <linux/kernel.h> +#include <linux/string.h> +#include
>> <linux/slab.h> +#include <linux/init.h> +#include <linux/mm.h>
>> +#include <linux/spinlock.h> +#include <linux/genalloc.h> +
>> +#include <asm/page.h> +#include <asm/pal.h> + +

>> + /* + * This is really an arbitrary limit, +10 is enough for + *
>> IA64_GRANULE_SHIFT.  + */

Christoph> What's IA64_GRANULE_SHIFT and why do we care?

IT's just an arbitrary upper limit of what the allocator allows,
ie. 16MB chunks. I added a better comment.

>> +#if DEBUG + printk(KERN_DEBUG "gen_pool_alloc: s %02x, i %i, h
>> %p\n", s, i, h); +#endif

Christoph> please avoid ifdefs in the middle of the code.  if you
Christoph> think keeping this trivial debug code in is so valueable
Christoph> add a helper that gets defined away for the non-debug case.

Gone

>> +int __init gen_pool_init(void) +{ + printk(KERN_INFO "Generic
>> memory pool allocator v1.0\n"); + return 0; +}

Christoph> no need to print a init message for a set of trivial
Christoph> library function

Gone, I put it in initially for debugging.

Cheers,
Jes

