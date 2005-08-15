Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932192AbVHOIGx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932192AbVHOIGx (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 04:06:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932206AbVHOIGx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 04:06:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:60388 "HELO
	port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with SMTP
	id S932192AbVHOIGw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 04:06:52 -0400
From: Denis Vlasenko <vda@ilport.com.ua>
To: Adrian Bunk <bunk@stusta.de>, Pekka J Enberg <penberg@cs.Helsinki.FI>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [-mm patch] make kcalloc() a static inline
Date: Mon, 15 Aug 2005 11:06:05 +0300
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20050808223842.GM4006@stusta.de>
In-Reply-To: <20050808223842.GM4006@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="koi8-r"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508151106.05973.vda@ilport.com.ua>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 09 August 2005 01:38, Adrian Bunk wrote:
> kcalloc() doesn't do much more than calling kzalloc(), and gcc has 
> better optimizing opportunities when it's inlined.
> 
> The result of this patch with a fulll kernel compile (roughly equivalent 
> to "make allyesconfig") shows a minimal size improvement:
> 
>     text           data     bss     dec             hex filename
> 25864955        5891214 2012840 33769009        2034631 vmlinux-before
> 25864635        5891206 2012840 33768681        20344e9 vmlinux-staticinline
> 
> 
> Signed-off-by: Adrian Bunk <bunk@stusta.de>
> 
> ---
> 
>  include/linux/slab.h |   15 ++++++++++++++-
>  mm/slab.c            |   14 --------------
>  2 files changed, 14 insertions(+), 15 deletions(-)
> 
> --- linux-2.6.13-rc5-mm1-full/include/linux/slab.h.old	2005-08-08 12:28:32.000000000 +0200
> +++ linux-2.6.13-rc5-mm1-full/include/linux/slab.h	2005-08-08 12:29:59.000000000 +0200
> @@ -103,8 +103,21 @@
>  	return __kmalloc(size, flags);
>  }
>  
> -extern void *kcalloc(size_t, size_t, unsigned int __nocast);
>  extern void *kzalloc(size_t, unsigned int __nocast);
> +
> +/**
> + * kcalloc - allocate memory for an array. The memory is set to zero.
> + * @n: number of elements.
> + * @size: element size.
> + * @flags: the type of memory to allocate.
> + */
> +static inline void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
> +{
> +	if (n != 0 && size > INT_MAX / n)
> +		return NULL;
> +	return kzalloc(n * size, flags);
> +}
> +
>  extern void kfree(const void *);
>  extern unsigned int ksize(const void *);
>  
> --- linux-2.6.13-rc5-mm1-full/mm/slab.c.old	2005-08-08 12:29:26.000000000 +0200
> +++ linux-2.6.13-rc5-mm1-full/mm/slab.c	2005-08-08 12:29:53.000000000 +0200
> @@ -3028,20 +3028,6 @@
>  EXPORT_SYMBOL(kzalloc);
>  
>  /**
> - * kcalloc - allocate memory for an array. The memory is set to zero.
> - * @n: number of elements.
> - * @size: element size.
> - * @flags: the type of memory to allocate.
> - */
> -void *kcalloc(size_t n, size_t size, unsigned int __nocast flags)
> -{
> -	if (n != 0 && size > INT_MAX / n)
> -		return NULL;
> -	return kzalloc(n * size, flags);
> -}
> -EXPORT_SYMBOL(kcalloc);
> -
> -/**
>   * kfree - free previously allocated memory
>   * @objp: pointer returned by kmalloc.
>   *

Can you conditionalize it on __builtin_constant_p(n) ?
Otherwise with variable n you have 3 oprations in inlined
code, one of them a division.

I bet you'll save even more space with such change.
--
vda

