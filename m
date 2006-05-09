Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751427AbWEIGYr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751427AbWEIGYr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 02:24:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751428AbWEIGYr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 02:24:47 -0400
Received: from dbl.q-ag.de ([213.172.117.3]:16104 "EHLO dbl.q-ag.de")
	by vger.kernel.org with ESMTP id S1751427AbWEIGYq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 02:24:46 -0400
Message-ID: <44603543.8070205@colorfullife.com>
Date: Tue, 09 May 2006 08:22:59 +0200
From: Manfred Spraul <manfred@colorfullife.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; fr-FR; rv:1.7.12) Gecko/20060212 Fedora/1.7.12-5
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Lameter <clameter@sgi.com>
CC: Pekka Enberg <penberg@cs.helsinki.fi>, Linus Torvalds <torvalds@osdl.org>,
       Daniel Hokka Zakrisson <daniel@hozac.com>, linux-kernel@vger.kernel.org,
       =?ISO-8859-1?Q?Bj=F6rn_Steinbrink?= <B.Steinbrink@gmx.de>,
       greg@kroah.com, matthew@wil.cx, akpm@osdl.org
Subject: Re: [PATCH] fs: fcntl_setlease defies lease_init assumptions
References: <445E80DD.9090507@hozac.com>  <Pine.LNX.4.64.0605072030280.3718@g5.osdl.org>  <84144f020605080131r58ce2a93w6c7ba784a266bbeb@mail.gmail.com>  <84144f020605080134q7e16f37fl385359c634ece8ca@mail.gmail.com>  <Pine.LNX.4.64.0605080807430.3718@g5.osdl.org>  <1147104412.22096.8.camel@localhost>  <Pine.LNX.4.64.0605080913240.3718@g5.osdl.org> <1147116991.11282.3.camel@localhost> <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
In-Reply-To: <Pine.LNX.4.64.0605082031580.23431@schroedinger.engr.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Lameter wrote:

>On Mon, 8 May 2006, Pekka Enberg wrote:
>
>  
>
>>>I think it sounds like it's worth it, but I'm not going to really push it.
>>>      
>>>
>>Sounds good to me. Andrew?
>>    
>>
>
>virt_to_page is not cheap on NUMA.
>
>  
>
I know. But it was a design assumption when I wrote the slab allocator.
Acutally, it's not cheap on non-NUMA either. And the PageCompound() 
check adds an additional branch.

Probably the allocator should be rewritten, without relying on 
virt_to_page().
Any proposals how kfree and kmem_cache_free could locate the cachep 
pointer? That's the performance critical part.

Right's now it's
<<<
   page = vir_to_page(objp)
   if (unlikely(PageCompound(page)))
           page = (struct page *)page_private(page);
   cachep = (struct kmem_cache *)page->lru.next;
 >>>

What about:
- switch from power of two kmalloc caches to slighly smaller caches.
- change the kmalloc(PAGE_SIZE) users to get_free_page(). 
get_free_page() is now fast, too.
- use cachep= *((struct kmem_cache **)(objp & 0xfff))

The result would be a few small restrictions: all objects must start in 
the first page of a slab (there are no exceptions on my 2.6.16 system), 
and PAGE_SIZE'd caches are very expensive. Replacing the names_cache 
with get_free_page is trivial. That leaves the pgd cache.

--
    Manfred


