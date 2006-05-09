Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751755AbWEIK0Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751755AbWEIK0Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 06:26:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751757AbWEIK0Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 06:26:16 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:26023 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP
	id S1751755AbWEIK0P (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 06:26:15 -0400
Date: Tue, 9 May 2006 13:26:06 +0300 (EEST)
From: Pekka J Enberg <penberg@cs.Helsinki.FI>
To: Manfred Spraul <manfred@colorfullife.com>
cc: Christoph Lameter <clameter@sgi.com>, Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       "=?ISO-8859-1?Q?Bj=F6rn_Steinbrink?=" <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
In-Reply-To: <44603543.8070205@colorfullife.com>
Message-ID: <Pine.LNX.4.58.0605091316010.27821@sbz-30.cs.Helsinki.FI>
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>
  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com> 
 <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com> 
 <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>
  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost>
 <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
 <44603543.8070205@colorfullife.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006, Manfred Spraul wrote:
> Probably the allocator should be rewritten, without relying on virt_to_page().
> Any proposals how kfree and kmem_cache_free could locate the cachep pointer?
> That's the performance critical part.
> 
> Right's now it's
> <<<
>   page = vir_to_page(objp)
>   if (unlikely(PageCompound(page)))
>           page = (struct page *)page_private(page);
>   cachep = (struct kmem_cache *)page->lru.next;
> >>>
> 
> What about:
> - switch from power of two kmalloc caches to slighly smaller caches.
> - change the kmalloc(PAGE_SIZE) users to get_free_page(). get_free_page() is
> now fast, too.
> - use cachep= *((struct kmem_cache **)(objp & 0xfff))

I think you mean

static inline struct kmem_cache *slab_get_cache(const void *obj)
{
        struct kmem_cache **p = (void *)((unsigned long) obj & ~(PAGE_SIZE-1));
        return *p;
}

On Tue, 9 May 2006, Manfred Spraul wrote:
> The result would be a few small restrictions: all objects must start in the
> first page of a slab (there are no exceptions on my 2.6.16 system), and
> PAGE_SIZE'd caches are very expensive. Replacing the names_cache with
> get_free_page is trivial. That leaves the pgd cache.

Your plan makes sense for slabs that have slab management structures 
embedded within. We already have enough free space there for one pointer 
due to 

    colour_off += cachep->slab_size;

in the alloc_slabmgmt() function, I think. Are you planning to kill 
external slab management allocation completely by switching to 
get_free_pages() for those cases? I'd much rather make the switch to page 
allocator under the hood so kmalloc(PAGE_SIZE*n) would still work because 
it's much nicer API.

				Pekka
