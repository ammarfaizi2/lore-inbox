Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964983AbWI0PuP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964983AbWI0PuP (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 11:50:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964991AbWI0PuO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 11:50:14 -0400
Received: from xenotime.net ([66.160.160.81]:33969 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S964988AbWI0PuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 11:50:11 -0400
Date: Wed, 27 Sep 2006 08:51:23 -0700
From: Randy Dunlap <rdunlap@xenotime.net>
To: Steve Wise <swise@opengridcomputing.com>
Cc: linux-kernel@vger.kernel.org, dcn@sgi.com, jes@trained-monkey.org,
       avolkov@varma-el.com
Subject: Re: [PATCH 2.6.18 ] LIB Add gen_pool_destroy().
Message-Id: <20060927085123.99749d2c.rdunlap@xenotime.net>
In-Reply-To: <20060927153545.28235.76214.stgit@dell3.ogc.int>
References: <20060927153545.28235.76214.stgit@dell3.ogc.int>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.9 (GTK+ 2.8.10; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Sep 2006 10:35:45 -0500 Steve Wise wrote:

> Modules using the genpool allocator need to be able to destroy the data
> structure when unloading.
> 
> Signed-off-by: Steve Wise <swise@opengridcomputing.com>
> ---
> 
>  include/linux/genalloc.h |    1 +
>  lib/genalloc.c           |   22 ++++++++++++++++++++++
>  2 files changed, 23 insertions(+), 0 deletions(-)
> 
> diff --git a/include/linux/genalloc.h b/include/linux/genalloc.h
> index 690c428..ca2b119 100644
> --- a/include/linux/genalloc.h
> +++ b/include/linux/genalloc.h
> @@ -30,6 +30,7 @@ struct gen_pool_chunk {
>  };
>  
>  extern struct gen_pool *gen_pool_create(int, int);
> +extern void gen_pool_destroy(struct gen_pool *);
>  extern int gen_pool_add(struct gen_pool *, unsigned long, size_t, int);
>  extern unsigned long gen_pool_alloc(struct gen_pool *, size_t);
>  extern void gen_pool_free(struct gen_pool *, unsigned long, size_t);
> diff --git a/lib/genalloc.c b/lib/genalloc.c
> index 71338b4..c8afa10 100644
> --- a/lib/genalloc.c
> +++ b/lib/genalloc.c
> @@ -36,6 +36,28 @@ EXPORT_SYMBOL(gen_pool_create);
>  
>  
>  /*
> + * Destroy a memory pool.  Assumes the user deals with releasing the
> + * actual memory managed by the pool.  
> + *
> + * @pool: pool to destroy.
> + *
> + */

Please use kernel-doc for exported kernel interfaces.
See Documentation/kernel-doc-nano-HOWTO.txt for info,
and/or see some file like kernel/printk.c for examples.

> +void gen_pool_destroy(struct gen_pool *pool)
> +{
> +	struct list_head *_chunk, *next;
> +	struct gen_pool_chunk *chunk;
> +
> +	list_for_each_safe(_chunk, next, &pool->chunks) {
> +		chunk = list_entry(_chunk, struct gen_pool_chunk, next_chunk);
> +		kfree(chunk);
> +	}
> +	kfree(pool);
> +	return;
> +}
> +EXPORT_SYMBOL(gen_pool_destroy);
> +
> +
> +/*
>   * Add a new chunk of memory to the specified pool.
>   *
>   * @pool: pool to add new memory chunk to
> -

argh.  more.  (not part of your patch)

---
~Randy
