Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965195AbVI1AHv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965195AbVI1AHv (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 20:07:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751165AbVI1AHv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 20:07:51 -0400
Received: from zproxy.gmail.com ([64.233.162.207]:59407 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751137AbVI1AHv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 20:07:51 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=nOG3LwnmbGPz2GYbrrWR0Xjqb+u1u7BIt1vvl5qaDwvXAFFH2ZUSqprulx0UhUEcPy9xDMSjE97BAFIaMPeNIuuyXIaQ8tN8OIjtVWTFvYUdqA8sHTozP7dSXP7yx00Br/2coFRAngaFcYJXIM3LAoE3n5a+PKeqHjasLOSNwYA=
Message-ID: <9a87484905092717074e85657e@mail.gmail.com>
Date: Wed, 28 Sep 2005 02:07:48 +0200
From: Jesper Juhl <jesper.juhl@gmail.com>
Reply-To: Jesper Juhl <jesper.juhl@gmail.com>
To: Nick Piggin <nickpiggin@yahoo.com.au>
Subject: Re: [RFC][PATCH] inline a few tiny functions in init/initramfs.c
Cc: Con Kolivas <kernel@kolivas.org>,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <4334DB96.3040904@yahoo.com.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <200509240126.26575.jesper.juhl@gmail.com>
	 <200509241415.43773.kernel@kolivas.org>
	 <4334DB96.3040904@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/24/05, Nick Piggin <nickpiggin@yahoo.com.au> wrote:
> Con Kolivas wrote:
>
> >On Sat, 24 Sep 2005 09:26, Jesper Juhl wrote:
> >
> >>A few functions in init/initramfs.c are so simple that I don't see why
> >>*any* point in them having to bear the cost of a function call.
> >>Wouldn't something like the patch below make sense ?
> >>
> >
> >>-static void __init *malloc(size_t size)
> >>+static inline void __init *malloc(size_t size)
> >> {
> >>      return kmalloc(size, GFP_KERNEL);
> >>
> >
> >maybe it looks like it would, but kmalloc looks like this:
> >
> >85 static inline void *kmalloc(size_t size, int flags)
> >86 {
> >87         if (__builtin_constant_p(size)) {
> >88                 int i = 0;
> >89 #define CACHE(x) \
> >90                 if (size <= x) \
> >91                         goto found; \
> >92                 else \
> >93                         i++;
> >94 #include "kmalloc_sizes.h"
> >95 #undef CACHE
> >96                 {
> >97                         extern void __you_cannot_kmalloc_that_much(void);
> >98                         __you_cannot_kmalloc_that_much();
> >99                 }
> >100 found:
> >101                 return kmem_cache_alloc((flags & GFP_DMA) ?
> >102                         malloc_sizes[i].cs_dmacachep :
> >103                         malloc_sizes[i].cs_cachep, flags);
> >104         }
> >105         return __kmalloc(size, flags);
> >106 }
> >
> >which is not a one liner to inline at all
> >
> >
>
> Actually, this is even better, because the inline 'malloc' should be
> able to propogate the builtin_constantness of 'size' while an out of
> line version cannot.
>
> IMO the best policy is not to second guess the API implementor's
> choice of inline / noinline. That is - if kmalloc was too big to
> inline then it should be fixed in kmalloc or another interface
> introduced.
>

Ok, so it seems that there's agreement that the other two inlines in
the patch makes sense, but the malloc() is not clear cut.

Since this is in initramfs after all it doesn't make that big a
difference overall, so I'll just send in a patch that inlines the
other two functions but leaves malloc() alone.

Thank you both, Nick, Con, for commenting.


--
Jesper Juhl <jesper.juhl@gmail.com>
Don't top-post  http://www.catb.org/~esr/jargon/html/T/top-post.html
Plain text mails only, please      http://www.expita.com/nomime.html
