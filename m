Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030855AbWI0VJn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030855AbWI0VJn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 17:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030857AbWI0VJn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 17:09:43 -0400
Received: from rrcs-24-153-218-104.sw.biz.rr.com ([24.153.218.104]:21897 "EHLO
	dell3.ogc.int") by vger.kernel.org with ESMTP id S1030855AbWI0VJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 17:09:42 -0400
Subject: Re: [PATCH 2.6.18 ] LIB Add gen_pool_destroy().
From: Steve Wise <swise@opengridcomputing.com>
To: Dean Nelson <dcn@sgi.com>
Cc: jes@trained-monkey.org, avolkov@varma-el.com, rdunlap@xenotime.net,
       linux-kernel@vger.kernel.org
In-Reply-To: <20060927195156.GA3283@sgi.com>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int>
	 <20060927195156.GA3283@sgi.com>
Content-Type: text/plain
Date: Wed, 27 Sep 2006 16:09:40 -0500
Message-Id: <1159391380.10663.62.camel@stevo-desktop>
Mime-Version: 1.0
X-Mailer: Evolution 2.4.0 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dean,

Looks like it works fine.

Any chance of getting this into 2.6.18 I wonder?


Steve.



On Wed, 2006-09-27 at 14:51 -0500, Dean Nelson wrote:
> Modules using the genpool allocator need to be able to destroy the data
> structure when unloading.
> 
> Signed-off-by: Steve Wise <swise@opengridcomputing.com>
> Signed-off-by: Dean Nelson <dcn@sgi.com>
> 
> ---
> 
> Hi Steve,
> 
> I agree that the ability to destroy the allocated structures is
> necessary. Thanks for doing the work. I do think it appropriate
> to ensure that there are no outstanding allocations (to avoid use
> after free issues) and have added that check in this new patch.
> This patch has not been tested, though it does compile. I don't
> have the time today. I hope you don't mind testing it? :-)
> 
> It also looks like I need to straighten out the kernel-doc
> aspects of this file. I'll tackle that as a separate patch.
> 
> Thanks,
> Dean
> 
> 
>  include/linux/genalloc.h |    1 +
>  lib/genalloc.c           |   29 +++++++++++++++++++++++++++++
>  2 files changed, 30 insertions(+)
> 
> 
> Index: linux-2.6/lib/genalloc.c
> ===================================================================
> --- linux-2.6.orig/lib/genalloc.c	2006-09-27 13:42:35.000000000 -0500
> +++ linux-2.6/lib/genalloc.c	2006-09-27 14:31:56.816523882 -0500
> @@ -71,6 +71,35 @@
>  
> 
>  /*
> + * Destroy a memory pool.
> + *
> + * @pool: pool to destroy
> + */
> +void gen_pool_destroy(struct gen_pool *pool)
> +{
> +	struct list_head *_chunk, *_next_chunk;
> +	struct gen_pool_chunk *chunk;
> +	int order = pool->min_alloc_order;
> +	int bit, end_bit;
> +
> +
> +	write_lock(&pool->lock);
> +	list_for_each_safe(_chunk, _next_chunk, &pool->chunks) {
> +		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
> +
> +		end_bit = (chunk->end_addr - chunk->start_addr) >> order;
> +		bit = find_next_bit(chunk->bits, end_bit, 0);
> +		BUG_ON(bit < end_bit);
> +
> +		kfree(chunk);
> +	}
> +	kfree(pool);
> +	return;
> +}
> +EXPORT_SYMBOL(gen_pool_destroy);
> +
> +
> +/*
>   * Allocate the requested number of bytes from the specified pool.
>   * Uses a first-fit algorithm.
>   *
> Index: linux-2.6/include/linux/genalloc.h
> ===================================================================
> --- linux-2.6.orig/include/linux/genalloc.h	2006-09-27 13:42:34.000000000 -0500
> +++ linux-2.6/include/linux/genalloc.h	2006-09-27 14:18:31.807816652 -0500
> @@ -31,5 +31,6 @@
>  
>  extern struct gen_pool *gen_pool_create(int, int);
>  extern int gen_pool_add(struct gen_pool *, unsigned long, size_t, int);
> +extern void gen_pool_destroy(struct gen_pool *);
>  extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
>  extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

