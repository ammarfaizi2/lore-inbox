Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261531AbUKGDTo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261531AbUKGDTo (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 6 Nov 2004 22:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261533AbUKGDTn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 6 Nov 2004 22:19:43 -0500
Received: from mail-relay-2.tiscali.it ([213.205.33.42]:7860 "EHLO
	mail-relay-2.tiscali.it") by vger.kernel.org with ESMTP
	id S261531AbUKGDTh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 6 Nov 2004 22:19:37 -0500
Date: Sun, 7 Nov 2004 02:16:38 +0100
From: Andrea Arcangeli <andrea@novell.com>
To: Nikita Danilov <nikita@clusterfs.com>
Cc: Nick Piggin <piggin@cyberone.com.au>, Jesse Barnes <jbarnes@sgi.com>,
       Marcelo Tosatti <marcelo.tosatti@cyclades.com>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org
Subject: Re: [PATCH] Remove OOM killer from try_to_free_pages / all_unreclaimable braindamage
Message-ID: <20041107011638.GJ3851@dualathlon.random>
References: <20041105200118.GA20321@logos.cnet> <200411051532.51150.jbarnes@sgi.com> <20041106012018.GT8229@dualathlon.random> <418C2861.6030501@cyberone.com.au> <20041106015051.GU8229@dualathlon.random> <16780.46945.925271.26168@thebsh.namesys.com> <20041106153209.GC3851@dualathlon.random> <16781.436.710721.667909@gargle.gargle.HOWL> <20041106174444.GF3851@dualathlon.random> <16781.9482.821680.375843@gargle.gargle.HOWL>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16781.9482.821680.375843@gargle.gargle.HOWL>
X-GPG-Key: 1024D/68B9CB43 13D9 8355 295F 4823 7C49  C012 DFA1 686E 68B9 CB43
X-PGP-Key: 1024R/CB4660B9 CC A0 71 81 F4 A0 63 AC  C0 4B 81 1D 8C 15 C8 E5
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 06, 2004 at 10:24:58PM +0300, Nikita Danilov wrote:
> This means breaking all layering and passing mempool pointer all the way
> down to the lowest layer allocators (like bio and drivers). The only

bio and drivers already have their own mempools.  the blkdev layer is
guaranteed to succeed and it can only try GFP_NOIO allocations (if those
fails it'll fallback in the reserved mempool).

> practical way to do this, is to put mempool pointer into current
> task_struct. At which point it's no different from having per-thread
> list of pages that __alloc_pages() looks into before falling back to
> per-cpu page-sets and buddy. _Except_ in the latter case, reservation is
> handled transparently in __alloc_pages() and code shouldn't be adjusted
> to check for mempool in zillion of places.

that's sure reasonable to avoid changing lots of code.

> I think you are confusing "file system" and "ext2". I definitely know
> from experience that with some file system types, system can be oommed
> without any significant user-level allocation activity. Now, one can say
> that either such file-systems are broken, or Linux MM lacks support for
> features (like reservation) they need.

the latter is true, I agree.

>  > that's the PF_MEMALLOC path. A reservation already exists, or it would
>  > never work since 2.2. PF_MEMALLOC and the min/2 watermark are meant to
>  > allow writepage to allocate ram. however the amount reserved is limited,
> 
> low-mem watermark is mostly useless in the face of direct reclaim, when
> unbounded number of threads enter try_to_free_pages() and call
> ->writepage() simultaneously.

agreed.

>  > so it's not perfect. The only way to make it perfect I believe is to
>  > reserve the stuff inside the fs with mempools as described above.
> 
> I don't see what advantages mempools have over page reservation handled
> directly by page allocator, like in
> 
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.9-rc4/2.6.9-rc4-mm1/broken-out/reiser4-perthread-pages.patch

guess what, that patch is running in my kernel right now. However I
believe this approch is very wasteful. I agree it'll work right, but
you're wasting loads of ram and you're as well less efficient.

The efficient fix for your problem, is to have a global pool, protected
by a global semaphore (definitely not per-thread), so that when you hit
oom (and when you hit true oom the last thing you can care about is
paralleism or the scalability on such a global semaphore), the VM will
trasparently take the semaphore and start using the pool. This will
still require you to mark the start and end of your critical section
like this:

reiserf4_writepage()
{
	enable_reserved_pages_pool();

	find_or_create_page()
	journal something
	getblk
	biowhatever

	disable_reserved_pages_pool();
}

disable_reserved_pages_pool has to check a per-thread flag that the VM
will set if it has used the reserved pool and taken the semaphore, but
by that time the I/O can be guaranteed to complete and the memory will
be guaranteed to be unlocked eventually when the bio I/O completes. So
you can freely alloc_pages to refill the pool inside
disable_reserved_pages_pool and then drop the semaphore.
enable_reserved_pages_pool is only needed to set a per-thread flag to
tell the VM it's allowed to fallback in the global pool by blocking in
the global semaphore if the box is oom (instead of returning NULL).

in disable_reserved_pages_pool you'll also have to clear the pre-thread
flag before calling alloc_pages again to avoid deadlock on the semaphore
if another oom condition happens of course.

then you need an create_reserved_pages_pool(nr_pages) while you mount the
fs, and destroy_unreserve_pages_pool(nr_pages) when you unmont it. where
many different users (i.e. different fs) will be allowed to reserve a
different size for the global pool. They all will share the same pool,
you've only need to track each user nr_pages to know which is the max
reservation you need.

That's still enterely transparent, it'll work in the thread context
thanks to the global semaphore, but it'll avoid the waste of ram where
every different task has to pin the ram into the task before starting
the writepage I/O.

I mean, I understand the only point of the perthread-pages patch is
deadlock avoidance during OOM. So you definitely don't need a per-thread
reservation, the global pool methods I described above should be more
than enough and they'll save ram and make your system faster as well.

I agree PF_MEMALLOC has nothing to do with this.
