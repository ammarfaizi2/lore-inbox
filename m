Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161165AbWI1OwZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161165AbWI1OwZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Sep 2006 10:52:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161166AbWI1OwZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Sep 2006 10:52:25 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:44198 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1161165AbWI1OwY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Sep 2006 10:52:24 -0400
Date: Thu, 28 Sep 2006 09:51:42 -0500
From: Robin Holt <holt@sgi.com>
To: Dean Nelson <dcn@sgi.com>
Cc: torvalds@osdl.org, linux-kernel@vger.kernel.org,
       swise@opengridcomputing.com, rdunlap@xenotime.net,
       jes@trained-monkey.org, avolkov@varma-el.com
Subject: Re: [PATCH] add gen_pool_destroy()
Message-ID: <20060928145142.GA6715@lnx-holt.americas.sgi.com>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int> <20060927195156.GA3283@sgi.com> <1159391380.10663.62.camel@stevo-desktop> <20060928131614.GA3232@sgi.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060928131614.GA3232@sgi.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nack this.

Dean, you changed the list_for_each to list_for_each_safe where it was
not needed.  I think you only needed to change that in the remove path.
IIRC, list_for_each_safe is intended for walking a list where you unlink
the entry as part of your operation.  Keep it for the gen_pool_destroy
function since you are using kfree on those objects and somebody else
could reuse them (sort of a list delete), but do not change them for
the other case.  The list_for_each does an explicit prefetch which will
improve performance in many cases.

Thanks,
Robin


On Thu, Sep 28, 2006 at 08:16:14AM -0500, Dean Nelson wrote:
> Modules using the genpool allocator need to be able to kfree() the memory
> used for the genpool data structures when unloading.
> 
> Signed-off-by: Steve Wise <swise@opengridcomputing.com>
> Signed-off-by: Dean Nelson <dcn@sgi.com>
> 
> ---
> 
> Hi Linus,
> 
> Would you please accept this patch against the genpool allocator?
> 
> There is still an issue with the block comments not being up to
> kernel-doc standards that plagues the entire file, which I will
> remedy in a followup patch.
> 
> Thanks,
> Dean
> 
>  include/linux/genalloc.h |    1 +
>  lib/genalloc.c           |   37 +++++++++++++++++++++++++++++++++----
>  2 files changed, 34 insertions(+), 4 deletions(-)
> 
> 
> Index: linux-2.6/lib/genalloc.c
> ===================================================================
> --- linux-2.6.orig/lib/genalloc.c	2006-09-27 13:42:35.000000000 -0500
> +++ linux-2.6/lib/genalloc.c	2006-09-28 07:49:05.948568928 -0500
> @@ -71,6 +71,35 @@
>  
>  
>  /*
> + * Destroy a memory pool. Verifies that there are no outstanding allocations.
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
> @@ -79,7 +108,7 @@
>   */
>  unsigned long gen_pool_alloc(struct gen_pool *pool, size_t size)
>  {
> -	struct list_head *_chunk;
> +	struct list_head *_chunk, *_next_chunk;
>  	struct gen_pool_chunk *chunk;
>  	unsigned long addr, flags;
>  	int order = pool->min_alloc_order;
> @@ -91,7 +120,7 @@
>  	nbits = (size + (1UL << order) - 1) >> order;
>  
>  	read_lock(&pool->lock);
> -	list_for_each(_chunk, &pool->chunks) {
> +	list_for_each_safe(_chunk, _next_chunk, &pool->chunks) {
>  		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
>  
>  		end_bit = (chunk->end_addr - chunk->start_addr) >> order;
> @@ -137,7 +166,7 @@
>   */
>  void gen_pool_free(struct gen_pool *pool, unsigned long addr, size_t size)
>  {
> -	struct list_head *_chunk;
> +	struct list_head *_chunk, *_next_chunk;
>  	struct gen_pool_chunk *chunk;
>  	unsigned long flags;
>  	int order = pool->min_alloc_order;
> @@ -146,7 +175,7 @@
>  	nbits = (size + (1UL << order) - 1) >> order;
>  
>  	read_lock(&pool->lock);
> -	list_for_each(_chunk, &pool->chunks) {
> +	list_for_each_safe(_chunk, _next_chunk, &pool->chunks) {
>  		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
>  
>  		if (addr >= chunk->start_addr && addr < chunk->end_addr) {
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
