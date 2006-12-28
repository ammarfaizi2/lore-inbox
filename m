Return-Path: <linux-kernel-owner+w=401wt.eu-S1754820AbWL1LuO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754820AbWL1LuO (ORCPT <rfc822;w@1wt.eu>);
	Thu, 28 Dec 2006 06:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754826AbWL1LuN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Dec 2006 06:50:13 -0500
Received: from nz-out-0506.google.com ([64.233.162.233]:18671 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754820AbWL1LuL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Dec 2006 06:50:11 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LcXUrTbiFgVFt3HTrqcSfP3/BtHIgh971zuVTAPmT60O2ZgC6jpyT0fUTwrAbKogVIepEvkNiBRKeiXUJ538X8IeOylQu8JURK5uqIub+812y9qtAL1crNtn0PvNEoIp3YWk8ShBmB9NviwRLFnWxmbzeyVfICSIbVIP6fK3pDQ=
Message-ID: <b0943d9e0612280350i8d96134yceffe830a22fbfa1@mail.gmail.com>
Date: Thu, 28 Dec 2006 11:50:10 +0000
From: "Catalin Marinas" <catalin.marinas@gmail.com>
To: "Ingo Molnar" <mingo@elte.hu>
Subject: Re: [PATCH 2.6.20-rc1 00/10] Kernel memory leak detector 0.13
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061228094431.GE24765@elte.hu>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061216153346.18200.51408.stgit@localhost.localdomain>
	 <b0943d9e0612161539s50fd6086v9246d6b0ffac949a@mail.gmail.com>
	 <20061217085859.GB2938@elte.hu>
	 <b0943d9e0612171505l6dfe19c6h6391b08f41243b1@mail.gmail.com>
	 <20061218072932.GA5624@elte.hu>
	 <b0943d9e0612270552n4a612103u5a5dafabeaec7ae5@mail.gmail.com>
	 <20061227150815.GA27828@elte.hu> <20061227173013.GA17560@elte.hu>
	 <b0943d9e0612271615r42c7f6abt38f36bbd9c94319f@mail.gmail.com>
	 <20061228094431.GE24765@elte.hu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/12/06, Ingo Molnar <mingo@elte.hu> wrote:
>
> * Catalin Marinas <catalin.marinas@gmail.com> wrote:
>
> > >memleak info is at a negative offset from the allocated pointer. I.e.
> > >that if kmalloc() returns 'ptr', the memleak info could be at
> > >ptr-sizeof(memleak_info). That way you dont have to know the size of the
> > >object beforehand and there's absolutely no need for a global hash of
> > >any sort.
> >
> > It would probably need to be just a pointer embedded in the allocated
> > block. With the current design, the memleak objects have a lifetime
> > longer than the tracked block. This is mainly to avoid long locking
> > during memory scanning and reporting.
>
> this thing has to be /fast/ in the common path. I dont really see the
> point in spreading out allocations like that for small objects.

This might have to be done for the vmalloc case, unless we embed the
memleak object in the vm_struct. A different way would be to vmalloc
an extra page but we waste a bit of memory (at least on ARM, the
vmalloc space is pretty small). The current size of the memleak_object
struct is 160 bytes.

Yet another implementation would be to embed the memleak object in the
slab object (since this is the most common case) and use some kind of
global hash for vmalloc or other allocators (see below for what other
objects kmemleak tracks).

> Access
> to the object has to be refcounted /anyway/ due to scanning. Just move
> that refcounting to the object freeing stage. Keep freed-but-used
> buffers in some sort of per-CPU list that the scanning code flushes
> after it's done. (Also maybe hold the cache_chain_mutex to prevent slab
> caches from being destroyed during scanning.)

I'm a bit worried about locking dependencies between l3->list_lock and
some lock for the freed-but-used lists. I have to investigate this as
I'm not familiar with the internals of the slab allocator.

Also, do you see any issues with using RCU freeing instead of a
freed-but-used list (rcu_data is already per-cpu)?

> > > (it gets a bit more complex for page aligned allocations for the
> > > buddy and for vmalloc - but that could be solved by adding one extra
> > > pointer into struct page. [...]
> >
> > This still leaves the issue of marking objects as not being leaks or
> > being of a different type. This is done by calling memleak_* functions
> > at the allocation point (outside allocator) where only the pointer is
> > known. [...]
>
> i dont see the problem. By having the pointer we have access to the
> memleak descriptor too.

Maybe not directly (i.e. without find_vm_area) in the vmalloc case but
it depends on where we store the memleak_object in this case.

> > [...] In the vmalloc case, it would need to call find_vm_area. This
> > might not be a big problem, only that memory resources are no longer
> > treated in a unified way by kmemleak (and might not be trivial to add
> > support for new allocators).
>
> the pretty horrible locking dependencies in the current one are just as
> bad.

Yes, I agree, and I'll implement a simplified allocator.

> If 'unification' means global locking and bad overhead and leak
> descriptor maintainance complexity then yes, we very much dont want to
> treat them in a unified way. Unless there's some killer counter-argument
> against embedding the memleak descriptor in the object that we allocate
> it is pretty much a must.

I don't have a strong counter-argument, I just try to find solutions
to the difficulties I encountered during the initial implementation.

> btw., you made the argument before that what matters most is the SLAB
> allocator. (when i argued that we might want to extend this to other
> allocators as well) You cant have it both ways :)

I forgot to mention but it needs to track the vmalloc allocations as
well since vmalloc'ed objects can have pointers to slab objects (one
clear example is the loadable modules).

There are also some memory areas that need to be scanned or tracked
(so that we don't get false positives) but are not allocated via slab
or vmalloc (like alloc_large_system_hash or percpu_modalloc). I
currently treat them in a /unified/ way, just by calling
memleak_alloc() on those pointers (as with slab and vmalloc). I can
change the API and add a memleak_add_area or similar and store them in
some internal memleak structure, global or per-CPU (it might not
matter much since these are called quite seldom but I should stop
expressing opinions on scalability :-)).

> > I understand the benefits but I personally favor simplicity over
> > performance, [...]
>
> i think you are trying to clinge to a bad design detail. You spent time
> on it, and that time was still worthwile, believe me. I often change
> design details dozens of times before a patch hits lkml. It doesnt
> matter, really - it's the path you walk that matters. This thing /has/
> to be fast/scalable to be used in distributions.

I don't have an issue with dumping the current design but, as I said,
I need to think about solutions to the problems I encountered in the
past (maybe I should just start re-coding kmemleak and see whether it
works but I try to make the transition as easy as possible since I do
this mainly in my spare time and want to finish it in a reasonable
time).

> > [...] Global structures are indeed a scalability problem but for a
> > reasonable number of CPUs their overhead might not be that big.
>
> lets forget you ever said this, ok? ;-)

Well, most of my Linux experience is on limited resources embedded
systems (ARM only recently joined the multi-CPU world). Enlightening
is welcomed :-)

Thanks for your comments.

-- 
Catalin
