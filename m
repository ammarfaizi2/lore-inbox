Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965756AbWCTQFh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965756AbWCTQFh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Mar 2006 11:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965185AbWCTQFg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Mar 2006 11:05:36 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.144]:27033 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S965749AbWCTQFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Mar 2006 11:05:32 -0500
Date: Mon, 20 Mar 2006 21:35:00 +0530
From: Balbir Singh <balbir@in.ibm.com>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] slab: introduce kmem_cache_zalloc allocator
Message-ID: <20060320160500.GA25415@in.ibm.com>
Reply-To: balbir@in.ibm.com
References: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0603201506140.19005@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<snip>

>  /**
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
> +
> +/**
>   * kmem_ptr_validate - check if an untrusted pointer might
>   *	be a slab entry.
>   * @cachep: the cache we're checking against
> diff --git a/mm/slob.c b/mm/slob.c
> index a1f42bd..9bcc7e2 100644
> --- a/mm/slob.c
> +++ b/mm/slob.c
> @@ -294,6 +294,16 @@ void *kmem_cache_alloc(struct kmem_cache
>  }
>  EXPORT_SYMBOL(kmem_cache_alloc);
>  
> +void *kmem_cache_zalloc(struct kmem_cache *c, gfp_t flags)
> +{
> +	void *ret = kmem_cache_alloc(c, flags);
> +	if (ret)
> +		memset(ret, 0, c->size);
> +
> +	return ret;
> +}
> +EXPORT_SYMBOL(kmem_cache_zalloc);
> +
>  void kmem_cache_free(struct kmem_cache *c, void *b)
>  {
>  	if (c->dtor)

Could we please create a more generic variation of this patch -- may be a
function called kmem_cache_alloc_set(). The function would not only
memset the data to 0, but instead to any specified pattern passed as
an argument.

This could be used to poison allocated memory. Passing 0 would make
this equivalent to kmem_cache_zalloc(). Basically, instead of doing

mem = __cache_alloc(...)
memset(mem, 0, size)

I would prefer if we could have

mem = __cache_alloc(...)
memset(mem, X, size)

Balbir
