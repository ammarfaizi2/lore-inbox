Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750725AbWGKH7F@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750725AbWGKH7F (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 03:59:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750711AbWGKH7E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 03:59:04 -0400
Received: from nz-out-0102.google.com ([64.233.162.204]:59257 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1750719AbWGKH7B (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 03:59:01 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=R98FxtD4pF59wNfH+dExQoZV4uVVdH+Wu+/RwdPxn4pT0Hg1YciIex2h+uCiYDiYjYDOzvORPNqE8PIwz7jNYEYxQpB6WoFkcF92sTnZqtn09iaZ9qusJ1sMHLMmxaZRylpc8l7VFcBKDcNP+yl4KaQmpaPKPvuCuZDv+RBVmWw=
Message-ID: <b0943d9e0607110059v5bb8732en674ad17702aded17@mail.gmail.com>
Date: Tue, 11 Jul 2006 08:59:00 +0100
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Pekka Enberg" <penberg@cs.helsinki.fi>
Subject: Re: [PATCH 03/10] Add the memory allocation/freeing hooks for kmemleak
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <84144f020607102317r60d797eakdf20107e158ec251@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20060710220901.5191.66488.stgit@localhost.localdomain>
	 <20060710220957.5191.54019.stgit@localhost.localdomain>
	 <84144f020607102317r60d797eakdf20107e158ec251@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pekka,

On 11/07/06, Pekka Enberg <penberg@cs.helsinki.fi> wrote:
> On 7/11/06, Catalin Marinas <catalin.marinas@gmail.com> wrote:
> > diff --git a/mm/slab.c b/mm/slab.c
> > index 85c2e03..2752272 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -2967,6 +2967,7 @@ #endif
> >                 STATS_INC_ALLOCMISS(cachep);
> >                 objp = cache_alloc_refill(cachep, flags);
> >         }
> > +       memleak_erase(&ac->entry[ac->avail]);
> >         return objp;
> >  }
>
> Can't we tell the GC not to scan any of the array cache structs? You
> could put that in alloc_arraycache(), I think.

Yes, we can. I'll give it a try before updating the patches.

> > @@ -3209,7 +3211,11 @@ static void __cache_free(struct kmem_cac
> >   */
> >  void *kmem_cache_alloc(struct kmem_cache *cachep, gfp_t flags)
> >  {
> > -       return __cache_alloc(cachep, flags, __builtin_return_address(0));
> > +       void *ptr = __cache_alloc(cachep, flags, __builtin_return_address(0));
> > +
> > +       memleak_alloc(ptr, obj_size(cachep), 1);
>
> Can you move memleak_alloc() call to __cache_alloc() instead to avoid
> duplication?

It might clutter the code because __cache_alloc is used by kmalloc as
well and the exact size information is lost. It would be to
explicitely give the type information to kmemleak in kmalloc and have
memleak_alloc called in __cache_alloc (with slight overhead of calling
kmemleak functions twice). The other option is to pass an extra
argument (guessed typeid) to __cache_alloc but this means adding extra
ifdefs.

Thanks.

-- 
Catalin
