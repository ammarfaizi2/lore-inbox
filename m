Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932123AbWGKVHG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123AbWGKVHG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 17:07:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWGKVHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 17:07:05 -0400
Received: from xenotime.net ([66.160.160.81]:56019 "HELO xenotime.net")
	by vger.kernel.org with SMTP id S932123AbWGKVHE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 17:07:04 -0400
Date: Tue, 11 Jul 2006 14:09:51 -0700
From: "Randy.Dunlap" <rdunlap@xenotime.net>
To: "Bryan O'Sullivan" <bos@serpentine.com>
Cc: linux-kernel@vger.kernel.org, davem@davemloft.net, arjan@infradead.org
Subject: Re: [PATCH] Add memcpy_cachebypass, a copy routine that tries to
 keep cache pressure down
Message-Id: <20060711140951.f22847d8.rdunlap@xenotime.net>
In-Reply-To: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
References: <da0cd816c4cb37c4376b.1152651055@localhost.localdomain>
Organization: YPO4
X-Mailer: Sylpheed version 2.2.6 (GTK+ 2.8.3; x86_64-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 11 Jul 2006 13:50:55 -0700 Bryan O'Sullivan wrote:

> diff -r c5610179c494 -r da0cd816c4cb include/linux/string.h
> --- a/include/linux/string.h	Tue Jul 11 13:40:19 2006 -0700
> +++ b/include/linux/string.h	Tue Jul 11 13:41:40 2006 -0700
> @@ -85,6 +85,7 @@ extern void * memset(void *,int,__kernel
>  #ifndef __HAVE_ARCH_MEMCPY
>  extern void * memcpy(void *,const void *,__kernel_size_t);
>  #endif
> +extern void * memcpy_cachebypass(void *,const void *,__kernel_size_t);

space after commas, please.

>  #ifndef __HAVE_ARCH_MEMMOVE
>  extern void * memmove(void *,const void *,__kernel_size_t);
>  #endif
> diff -r c5610179c494 -r da0cd816c4cb lib/string.c
> --- a/lib/string.c	Tue Jul 11 13:40:19 2006 -0700
> +++ b/lib/string.c	Tue Jul 11 13:41:40 2006 -0700
> @@ -509,6 +509,38 @@ EXPORT_SYMBOL(memcpy);
>  EXPORT_SYMBOL(memcpy);
>  #endif
>  
> +void *memcpy_cachebypass(void *dest, const void *src, size_t count)
> +	__attribute__((weak));
> +
> +/**
> + * memcpy_cachebypass - Copy one area of memory to another, if possible
> + * bypassing the CPU's cache when loading the copied-from data

Currently kernel-doc function description is limited to one line.
If you can't shorten it, just omit it completely and make it the first
paragraph after the parameters.

> + * @dest: Where to copy to
> + * @src: Where to copy from (bypassing the CPU's cache, if possible)
> + * @count: The size of the area.
> + *
> + * This memcpy-compatible routine is intended for use when the CPU
> + * only reads the source data once.  It is useful when, for example, a
> + * hardware device writes to a memory region, and the CPU needs to
> + * copy this data somewhere else before working on it.  In such a
> + * case, caching the source addresses only serves to evict possibly
> + * useful data that will probably have to be reloaded.
> + *
> + * An arch-specific implementation should not attempt to bypass the
> + * cache when storing to the destination, as copied data is usually
> + * accessed almost immediately after a copy finishes.
> + *
> + * This routine does not *guarantee* that the source addresses won't
> + * be cached; a user of this code must not rely on this behaviour for
> + * correctness.  It should only be used in cases where it provides a
> + * measurable performance improvement.
> + */
> +void *memcpy_cachebypass(void *dest, const void *src, size_t count)
> +{
> +	return memcpy(dest, src, count);
> +}
> +EXPORT_SYMBOL_GPL(memcpy_cachebypass);
> +
>  #ifndef __HAVE_ARCH_MEMMOVE
>  /**
>   * memmove - Copy one area of memory to another

---
~Randy
