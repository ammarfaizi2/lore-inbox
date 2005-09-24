Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751401AbVIXEPu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751401AbVIXEPu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Sep 2005 00:15:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751402AbVIXEPu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Sep 2005 00:15:50 -0400
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:31908 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S1751401AbVIXEPt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Sep 2005 00:15:49 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jesper Juhl <jesper.juhl@gmail.com>
Subject: Re: [RFC][PATCH] inline a few tiny functions in init/initramfs.c
Date: Sat, 24 Sep 2005 14:15:43 +1000
User-Agent: KMail/1.8.2
Cc: "linux-kernel" <linux-kernel@vger.kernel.org>
References: <200509240126.26575.jesper.juhl@gmail.com>
In-Reply-To: <200509240126.26575.jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200509241415.43773.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 24 Sep 2005 09:26, Jesper Juhl wrote:
> A few functions in init/initramfs.c are so simple that I don't see why
> *any* point in them having to bear the cost of a function call.
> Wouldn't something like the patch below make sense ?

> -static void __init *malloc(size_t size)
> +static inline void __init *malloc(size_t size)
>  {
>  	return kmalloc(size, GFP_KERNEL);

maybe it looks like it would, but kmalloc looks like this:

85 static inline void *kmalloc(size_t size, int flags)
86 {
87         if (__builtin_constant_p(size)) {
88                 int i = 0;
89 #define CACHE(x) \
90                 if (size <= x) \
91                         goto found; \
92                 else \
93                         i++;
94 #include "kmalloc_sizes.h"
95 #undef CACHE
96                 {
97                         extern void __you_cannot_kmalloc_that_much(void);
98                         __you_cannot_kmalloc_that_much();
99                 }
100 found:
101                 return kmem_cache_alloc((flags & GFP_DMA) ?
102                         malloc_sizes[i].cs_dmacachep :
103                         malloc_sizes[i].cs_cachep, flags);
104         }
105         return __kmalloc(size, flags);
106 }

which is not a one liner to inline at all

> -static void __init free(void *where)
> +static inline void __init free(void *where)
>  {
>  	kfree(where);

kfree ok since it's a void function of its own

>  static __initdata char *header_buf, *symlink_buf, *name_buf;
>
> -static int __init do_start(void)
> +static inline int __init do_start(void)
>  {
>  	read_into(header_buf, 110, GotHeader);

read_into ok as well.

Cheers,
Con
