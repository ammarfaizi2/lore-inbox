Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932411AbWCUKkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932411AbWCUKkS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Mar 2006 05:40:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932410AbWCUKkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Mar 2006 05:40:18 -0500
Received: from smtp.osdl.org ([65.172.181.4]:27322 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932411AbWCUKkR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Mar 2006 05:40:17 -0500
Date: Tue, 21 Mar 2006 02:36:54 -0800
From: Andrew Morton <akpm@osdl.org>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: linux-kernel@vger.kernel.org, Manfred Spraul <manfred@colorfullife.com>
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
Message-Id: <20060321023654.389dc572.akpm@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pekka J Enberg <penberg@cs.Helsinki.FI> wrote:
>
> From: Pekka Enberg <penberg@cs.helsinki.fi>
> 
> This patch introduces a memory-zeroing variant of kmem_cache_alloc. The
> allocator already exits in XFS and there are potential users for it so
> this patch makes the allocator available for the general public.
> 

hmm.

> + * kmem_cache_alloc - Allocate an object. The memory is set to zero.
> + * @cache: The cache to allocate from.
> + * @flags: See kmalloc().
> + *
> + * Allocate an object from this cache and set the allocated memory to zero.
> + * The flags are only relevant if the cache has no available objects.
> + */
> +void *kmem_cache_zalloc(struct kmem_cache *cache, gfp_t flags)
> +{
> +	void *ret = __cache_alloc(cache, flags, __builtin_return_address(0));
> +	if (ret)
> +		memset(ret, 0, obj_size(cache));
> +	return ret;
> +}
> +EXPORT_SYMBOL(kmem_cache_zalloc);

The way this is supposed to work in slab is that the owner of the cache
provides a constructor which zeroes out newly-allocated storage and the
owner of the cache is supposed to free objects in a constructed (ie:
zeroed) state.

I've always felt that this was an odd design.  Because

a) All that cache-warmth which we get from the constructor's zeroing can
   be lost by the time we get around to using an individual object and

b) The object may be cache-cold by the time we free it, and we'll take
   cache misses just putting it back into a constructed state for
   kmem_cache_free().  And we'll lose that cache warmth by the time we use
   this object again.

So from that POV I think (in my simple way) that this is a good patch.  But
IIRC, Manfred has reasons why it might not be?
