Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263202AbVHFPJs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263202AbVHFPJs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Aug 2005 11:09:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263203AbVHFPJs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Aug 2005 11:09:48 -0400
Received: from emailhub.stusta.mhn.de ([141.84.69.5]:34828 "HELO
	mailout.stusta.mhn.de") by vger.kernel.org with SMTP
	id S263202AbVHFPJr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Aug 2005 11:09:47 -0400
Date: Sat, 6 Aug 2005 17:09:40 +0200
From: Adrian Bunk <bunk@stusta.de>
To: Pekka J Enberg <penberg@cs.Helsinki.FI>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       pmarques@grupopie.com
Subject: Re: [PATCH] kernel: use kcalloc instead kmalloc/memset
Message-ID: <20050806150940.GT4029@stusta.de>
References: <1123219747.20398.1.camel@localhost> <20050804223842.2b3abeee.akpm@osdl.org> <Pine.LNX.4.58.0508050925370.27151@sbz-30.cs.Helsinki.FI> <20050804233634.1406e92a.akpm@osdl.org> <Pine.LNX.4.58.0508050946070.27679@sbz-30.cs.Helsinki.FI>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0508050946070.27679@sbz-30.cs.Helsinki.FI>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 05, 2005 at 09:52:32AM +0300, Pekka J Enberg wrote:
>...
> --- 2.6.orig/mm/slab.c
> +++ 2.6/mm/slab.c
> @@ -2555,6 +2555,20 @@ void kmem_cache_free(kmem_cache_t *cache
>  EXPORT_SYMBOL(kmem_cache_free);
>  
>  /**
> + * kzalloc - allocate memory. The memory is set to zero.
> + * @size: how many bytes of memory are required.
> + * @flags: the type of memory to allocate.
> + */
> +void *kzalloc(size_t size, unsigned int __nocast flags)
> +{
> +	void *ret = kmalloc(size, flags);
> +	if (ret)
> +		memset(ret, 0, size);
> +	return ret;
> +}
> +EXPORT_SYMBOL(kzalloc);
> +
> +/**
>   * kcalloc - allocate memory for an array. The memory is set to zero.
>   * @n: number of elements.
>   * @size: element size.
> @@ -2567,10 +2581,7 @@ void *kcalloc(size_t n, size_t size, uns
>  	if (n != 0 && size > INT_MAX / n)
>  		return ret;
>  
> -	ret = kmalloc(n * size, flags);
> -	if (ret)
> -		memset(ret, 0, n * size);
> -	return ret;
> +	return kzalloc(n * size, flags);
>  }
>  EXPORT_SYMBOL(kcalloc);


Looking at how few is left from kcalloc, can't we make it a
"static inline" function in slab.h?

This would optimize nicely for all of the users where the first or even 
the first two parameters are constant at compile-time and shouldn't do 
much harm for the other users.

As a side effect, the difference between kcalloc(1, ...) and kzalloc() 
would become a coding style question without any effect on the generated 
code.

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

