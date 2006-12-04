Return-Path: <linux-kernel-owner+willy=40w.ods.org-S937176AbWLDTuU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S937176AbWLDTuU (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Dec 2006 14:50:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S937351AbWLDTuT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Dec 2006 14:50:19 -0500
Received: from smtp.osdl.org ([65.172.181.25]:33736 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S937176AbWLDTuQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Dec 2006 14:50:16 -0500
Date: Mon, 4 Dec 2006 11:49:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Eric Dumazet <dada1@cosmosbay.com>
Cc: Christoph Lameter <clameter@sgi.com>, David Miller <davem@davemloft.net>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] SLAB : use a multiply instead of a divide in
 obj_to_index()
Message-Id: <20061204114954.165107b6.akpm@osdl.org>
In-Reply-To: <200612041918.29682.dada1@cosmosbay.com>
References: <4564C28B.30604@redhat.com>
	<200612041741.51846.dada1@cosmosbay.com>
	<Pine.LNX.4.64.0612040852250.31485@schroedinger.engr.sgi.com>
	<200612041918.29682.dada1@cosmosbay.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Dec 2006 19:18:29 +0100
Eric Dumazet <dada1@cosmosbay.com> wrote:

> On Monday 04 December 2006 17:55, Christoph Lameter wrote:
> > Could you generalize the reciprocal thingy so that the division
> > can be used from other parts of the kernel as well? It would be useful to
> > separately get some cycle counts on a regular division compared with your
> > division. If that shows benefit then we may think about using it in the
> > kernel. I am a bit surprised that this is still an issue on modern cpus.
> 
> OK I added a new include file, I am not sure it is the best way...
> 
> Well, AFAIK this particular divide is the only one that hurts performance on 
> my machines.
> 
> Do you have in mind another spot in kernel where we could use this reciprocal 
> divide as well ?
> 
> Yes divide complexity is still an issue with modern CPUS : 
> elapsed time for 10^9 loops on Pentium M 1.6 Ghz
> 24 s for the version using divides
> 3.8 s for the version using multiplies
> 
> [PATCH] SLAB : use a multiply instead of a divide in obj_to_index()
> 
> When some objects are allocated by one CPU but freed by another CPU we can 
> consume lot of cycles doing divides in obj_to_index().
> 
> (Typical load on a dual processor machine where network interrupts are handled 
> by one particular CPU (allocating skbufs), and the other CPU is running the 
> application (consuming and freeing skbufs))
> 
> Here on one production server (dual-core AMD Opteron 285), I noticed this 
> divide took 1.20 % of CPU_CLK_UNHALTED events in kernel. But Opteron are 
> quite modern cpus and the divide is much more expensive on oldest 
> architectures :

Yes, I've seen that divide hurting too.

I suspect it was with unusual everything-in-cache workloads, but whatever.

> On a 200 MHz sparcv9 machine, the division takes 64 cycles instead of 1 cycle 
> for a multiply.
> 
> Doing some math, we can use a reciprocal multiplication instead of a divide.
> 
> If we want to compute V = (A / B) __(A and B being u32 quantities)
> we can instead use :
> 
> V = ((u64)A * RECIPROCAL(B)) >> 32 ;
> 
> where RECIPROCAL(B) is precalculated to ((1LL << 32) + (B - 1)) / B
> 
> Note :
> 
> I wrote pure C code for clarity. gcc output for i386 is not optimal but 
> acceptable :
> 
> mull __ 0x14(%ebx)
> mov __ __%edx,%eax // part of the >> 32
> xor __ __ %edx,%edx // useless 
> mov __ __%eax,(%esp) // could be avoided
> mov __ __%edx,0x4(%esp) // useless
> mov __ __(%esp),%ebx
> 
> Signed-off-by: Eric Dumazet <dada1@cosmosbay.com>
> 

--- linux-2.6.19/include/linux/reciprocal_div.h	1970-01-01 01:00:00.000000000 +0100
> +++ linux-2.6.19-ed/include/linux/reciprocal_div.h	2006-12-04 19:01:44.000000000 +0100
> @@ -0,0 +1,30 @@
> +#ifndef _LINUX_RECIPROCAL_DIV_H
> +#define _LINUX_RECIPROCAL_DIV_H
> +
> +/*
> + * Define the reciprocal value of B so that
> + * ((u32)A / (u32)B) can be replaced by :
> + * (((u64)A * RECIPROCAL_VALUE(B)) >> 32)
> + * If RECIPROCAL_VALUE(B) is precalculated, we change a divide by a multiply

"to a multiply".


> + */
> +#define RECIPROCAL_VALUE(B) (u32)(((1LL << 32) + ((B) - 1))/ (B))

Does this have to be a macro?

I worry that people might try to throw random types at this code and it'll
fail.  Are you prepared to support s8, u8, s16, u16, s32, u32, s64 and u64?
I think not, so perhaps we should be documenting what we _do_ accept, and
adding typecheck() calls in there somewhere to enforce that. (In which case
it would need to be a macro).


> +static inline u32 reciprocal_value(unsigned int k)
> +{
> +	if (__builtin_constant_p(k))
> +		return RECIPROCAL_VALUE(k);
> +	else {
> +		u64 val = (1LL << 32) + (k - 1);
> +		do_div(val, k);
> +		return (u32)val;
> +	}
> +}

We should clearly document that this function is for once-off setup
operations - we'd hate for people to call this with any frequency.

It should be uninlined if poss, too.

> +/*
> + * We want to avoid an expensive divide : (A / B)
> + * If B is known in advance, its reciprocal R can be precalculated/stored.
> + * then  (A / B)  =  (u32)(((u64)(A) * (R)) >> 32)
> + */
> +#define RECIPROCAL_DIVIDE(A, R) (u32)(((u64)(A) * (R)) >> 32)

And again, depending upon our decision regarding what types this code will
support, this perhaps should become an inlined C function.

> +#endif
> --- linux-2.6.19/mm/slab.c	2006-12-04 11:50:19.000000000 +0100
> +++ linux-2.6.19-ed/mm/slab.c	2006-12-04 19:03:42.000000000 +0100
> @@ -107,6 +107,7 @@
>  #include	<linux/mempolicy.h>
>  #include	<linux/mutex.h>
>  #include	<linux/rtmutex.h>
> +#include	<linux/reciprocal_div.h>
>  
>  #include	<asm/uaccess.h>
>  #include	<asm/cacheflush.h>
> @@ -385,6 +386,7 @@ struct kmem_cache {
>  	unsigned int shared;
>  
>  	unsigned int buffer_size;
> +	unsigned int reciprocal_buffer_size;

If we decide to support only u32 for this operation, this should become
u32, for clarity.

>  /* 3) touched by every alloc & free from the backend */
>  	struct kmem_list3 *nodelists[MAX_NUMNODES];
>  
> @@ -626,10 +628,17 @@ static inline void *index_to_obj(struct 
>  	return slab->s_mem + cache->buffer_size * idx;
>  }
>  
> -static inline unsigned int obj_to_index(struct kmem_cache *cache,
> -					struct slab *slab, void *obj)
> +/*
> + * We want to avoid an expensive divide : (offset / cache->buffer_size)
> + *   Using the fact that buffer_size is a constant for a particular cache,
> + *   we can replace (offset / cache->buffer_size) by
> + *   RECIPROCAL_DIVIDE(offset, cache->reciprocal_buffer_size)
> + */
> +static inline unsigned int obj_to_index(const struct kmem_cache *cache,
> +					const struct slab *slab, void *obj)
>  {
> -	return (unsigned)(obj - slab->s_mem) / cache->buffer_size;
> +	unsigned int offset = (obj - slab->s_mem);
> +	return RECIPROCAL_DIVIDE(offset, cache->reciprocal_buffer_size);
>  }
>  
>  /*
> @@ -1400,6 +1409,8 @@ void __init kmem_cache_init(void)
>  
>  	cache_cache.buffer_size = ALIGN(cache_cache.buffer_size,
>  					cache_line_size());
> +	cache_cache.reciprocal_buffer_size =
> +		reciprocal_value(cache_cache.buffer_size);
>  
>  	for (order = 0; order < MAX_ORDER; order++) {
>  		cache_estimate(order, cache_cache.buffer_size,
> @@ -2297,6 +2308,7 @@ kmem_cache_create (const char *name, siz
>  	if (flags & SLAB_CACHE_DMA)
>  		cachep->gfpflags |= GFP_DMA;
>  	cachep->buffer_size = size;
> +	cachep->reciprocal_buffer_size = reciprocal_value(size);
>  
>  	if (flags & CFLGS_OFF_SLAB) {
>  		cachep->slabp_cache = kmem_find_general_cachep(slab_size, 0u);
> 
> 
> 
