Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965053AbWEJWxW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965053AbWEJWxW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 10 May 2006 18:53:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965054AbWEJWxW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 10 May 2006 18:53:22 -0400
Received: from smtp.osdl.org ([65.172.181.4]:9360 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S965053AbWEJWxV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 10 May 2006 18:53:21 -0400
Date: Wed, 10 May 2006 15:50:26 -0700
From: Andrew Morton <akpm@osdl.org>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: penberg@cs.Helsinki.FI, clameter@sgi.com, haveblue@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] add slab_is_available() routine for boot code
Message-Id: <20060510155026.173c57a1.akpm@osdl.org>
In-Reply-To: <20060510205543.GI3198@w-mikek2.ibm.com>
References: <20060510205543.GI3198@w-mikek2.ibm.com>
X-Mailer: Sylpheed version 1.0.4 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Kravetz <kravetz@us.ibm.com> wrote:
>
> slab_is_available() indicates slab based allocators are available
> for use.  SPARSEMEM code needs to know this as it can be called
> at various times during the boot process.
> 
> Signed-off-by: Mike Kravetz <kravetz@us.ibm.com>
> 
> diff -Naupr linux-2.6.17-rc3-mm1/include/linux/slab.h linux-2.6.17-rc3-mm1.work3/include/linux/slab.h
> --- linux-2.6.17-rc3-mm1/include/linux/slab.h	2006-05-03 22:19:15.000000000 +0000
> +++ linux-2.6.17-rc3-mm1.work3/include/linux/slab.h	2006-05-10 19:15:20.000000000 +0000
> @@ -150,6 +150,7 @@ static inline void *kcalloc(size_t n, si
>  
>  extern void kfree(const void *);
>  extern unsigned int ksize(const void *);
> +extern int slab_is_available(void);
>  
>  #ifdef CONFIG_NUMA
>  extern void *kmem_cache_alloc_node(kmem_cache_t *, gfp_t flags, int node);
> diff -Naupr linux-2.6.17-rc3-mm1/mm/slab.c linux-2.6.17-rc3-mm1.work3/mm/slab.c
> --- linux-2.6.17-rc3-mm1/mm/slab.c	2006-05-03 22:19:16.000000000 +0000
> +++ linux-2.6.17-rc3-mm1.work3/mm/slab.c	2006-05-10 21:43:08.000000000 +0000
> @@ -694,6 +694,14 @@ static enum {
>  	FULL
>  } g_cpucache_up;
>  
> +/*
> + * used by boot code to determine if it can use slab based allocator
> + */
> +int slab_is_available(void)
> +{
> +	return g_cpucache_up == FULL;
> +}

Even I can understand this ;)

>  static DEFINE_PER_CPU(struct work_struct, reap_work);
>  
>  static void free_block(struct kmem_cache *cachep, void **objpp, int len,
> diff -Naupr linux-2.6.17-rc3-mm1/mm/sparse.c linux-2.6.17-rc3-mm1.work3/mm/sparse.c
> --- linux-2.6.17-rc3-mm1/mm/sparse.c	2006-05-03 22:19:16.000000000 +0000
> +++ linux-2.6.17-rc3-mm1.work3/mm/sparse.c	2006-05-10 19:15:56.000000000 +0000
> @@ -32,7 +32,7 @@ static struct mem_section *sparse_index_
>  	unsigned long array_size = SECTIONS_PER_ROOT *
>  				   sizeof(struct mem_section);
>  
> -	if (system_state == SYSTEM_RUNNING)
> +	if (slab_is_available())
>  		section = kmalloc_node(array_size, GFP_KERNEL, nid);
>  	else
>  		section = alloc_bootmem_node(NODE_DATA(nid), array_size);

Is this a needed-for-2.6.17 fix?
