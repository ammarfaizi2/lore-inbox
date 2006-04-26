Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbWDZN2m@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbWDZN2m (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 26 Apr 2006 09:28:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932435AbWDZN2m
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 26 Apr 2006 09:28:42 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:25505 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S932431AbWDZN2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 26 Apr 2006 09:28:41 -0400
Date: Wed, 26 Apr 2006 08:28:03 -0500
From: Dean Nelson <dcn@sgi.com>
To: Jes Sorensen <jes@sgi.com>
Cc: akpm@osdl.org, tony.luck@intel.com, avolkov@varma-el.com,
       linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org,
       paulus@samba.org, holt@sgi.com
Subject: Re: [PATCH] change gen_pool allocator to not touch managed memory
Message-ID: <20060426132803.GA30360@sgi.com>
References: <444D1A7E.mailx85W11DZZU@aqua.americas.sgi.com> <20060424181626.09966912.akpm@osdl.org> <20060425155051.GA19248@sgi.com> <444F3990.5030100@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <444F3990.5030100@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2006 at 11:12:48AM +0200, Jes Sorensen wrote:
> Dean Nelson wrote:
> > -unsigned long gen_pool_alloc(struct gen_pool *poolp, int size)
> > +int gen_pool_add(struct gen_pool *pool, unsigned long addr, size_t size,
> > +		 int nid)
> >  {
> > -	int j, i, s, max_chunk_size;
> > -	unsigned long a, flags;
> > -	struct gen_pool_link *h = poolp->h;
> > +	struct gen_pool_chunk *chunk;
> > +	int nbits = size >> pool->min_alloc_order;
> > +	int nbytes = sizeof(struct gen_pool_chunk) +
> > +				(nbits + BITS_PER_BYTE - 1) / BITS_PER_BYTE;
> > +
> > +	if (nbytes > PAGE_SIZE) {
> > +		chunk = vmalloc_node(nbytes, nid);
> > +	} else {
> > +		chunk = kmalloc_node(nbytes, GFP_KERNEL, nid);
> > +	}
> 
> Any patch that adds vmalloc() calls to code always makes the little
> hairs on the back of my neck stand up. Any chance we could get away with
> alloc_pages_node() for this?

Is it the mapping of the pages that bothers you? If using alloc_pages_node()
is the preferred way, I certainly can make the change. But if I do there is
a greater potential that we may have to return failure to the caller of
gen_pool_add(), that is if we can't get the necessary number of contiguous
pages. Now granted the likelyhood that anyone would require more than a
page for a bitmap is very very small. I'd say the vast majority of callers
will end up using kmalloc_node(). I can go either way, just let me know
whether I should make the change or not.

> >  	ia64_pal_mc_drain();
> > -	status = smp_call_function(uncached_ipi_mc_drain, NULL, 0, 1);
> > -	if (status)
> > -		printk(KERN_WARNING "smp_call_function failed for "
> > -		       "uncached_ipi_mc_drain! (%i)\n", status);
> > +	(void) smp_call_function(uncached_ipi_mc_drain, NULL, 0, 1);
> 
> This thing could in theory fail so having the error check there seems
> the right thing to me. In either case, please don't (void) the function
> return (this is a style issue, I know).

The comment block preceding smp_call_function() says that it returns "0 on
success, else a negative status code". So regardless of whether the current
implementation for a given architecture is always returning 0 is probably
irrelevant since that could change tommorrow. So now I'm thinking I should
restore the check for an error return, something I will do in the next
version of this patch.

> > Index: linux-2.6/arch/ia64/sn/kernel/sn2/cache.c
> > ===================================================================
> > --- linux-2.6.orig/arch/ia64/sn/kernel/sn2/cache.c	2006-04-24 12:25:36.234717101 -0500
> > +++ linux-2.6/arch/ia64/sn/kernel/sn2/cache.c	2006-04-24 12:27:56.012899026 -0500
> 
> This part we should maybe do in a seperate patch? It seems valid on it's
> own?

I thought of this, but if this patch were separated out then the remaining
patch would be dependent on it since the uncached allocator is being
changed to call sn_flush_all_caches() with an uncached address.
It certainly could be done, but is it worth the effort? Let me know
how I should proceed with this.

Thanks,
Dean
