Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318009AbSG2ApU>; Sun, 28 Jul 2002 20:45:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318016AbSG2ApU>; Sun, 28 Jul 2002 20:45:20 -0400
Received: from [195.223.140.120] ([195.223.140.120]:60453 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S318009AbSG2ApQ>; Sun, 28 Jul 2002 20:45:16 -0400
Date: Mon, 29 Jul 2002 02:49:42 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@zip.com.au>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of PAGE_{CACHE_,}{MASK,ALIGN}
Message-ID: <20020729004942.GL1201@dualathlon.random>
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3D448808.CF8D18BA@zip.com.au>
User-Agent: Mutt/1.3.27i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> Linus Torvalds wrote:
> > 
> > ...
> > Dream on. It's good, and it's not getting removed. The "struct page" is
> > size-critical, and also correctness-critical (see above on gcc issues).
> > 
> 
> Plan B is to remove page->index.
> 
> - Replace ->mapping with a pointer to the page's radix tree
>   slot.   Use address masking to go from page.radix_tree_slot
>   to the radix tree node.

that's not immediate anymore, you've to walk the tree backwards, like
you do for the lookups.

I recall you are benchmarking radix tree with dbench.  You've to
benchmark the worst case not dbench with small files. with small files
even the rbtree was nicer than the hashtable. The right benchmark is:

	truncate(800GByte)
	write(1G)
	lseek(800Gbyte)
	fsync()
	addr = mmap(1G)
	benchmark_start()
	mlock(1G)
	benchmark_stop()

instead of mlock you can also do read(1G) as you prefer, but the
overhead of the copy-user would be certainly more significant than the
overhead of filling the ptes, so an mlock or *even* a page fault should
be lighter to allow us to better benchmark the pagecache performance.

The nocopy hack from Lincol would be fine too, then you could read the
whole thing with one syscall and no pagetable overhead.

(of course you need >1G of ram to avoid to hit the disk during the read,
probably the read pass should be read 1 byte, lseek to the next 1byte,
and you also need the hashtable allocated with the bootmem allocator)

Nobody did that yet AFIK, so it's not a surprise nobody found any
regression with the radix tree (yet). I expect walking 6/7 cacheline
steps every time is going to be a significant hit (even worse if you
need to do that every time to derive the index with the gang method). Of
course if you work with small files you'll never walk more than a few
steps and the regression doesn't showup, that was true with the rbtree
too two/three years ago.

The other major problems of radix trees are the GFP_ATOMIC allocations
that can lead at the very least to I/O failures, the mempool usage seems
just a band-aid to hide those failures but it works by pure luck it
seems.

On the same GFP_ATOMIC lines we can find in rmap.c:

static void alloc_new_pte_chains()
{
	struct pte_chain * pte_chain = (void *) get_zeroed_page(GFP_ATOMIC);
	int i = PAGE_SIZE / sizeof(struct pte_chain);

	if (pte_chain) {
		inc_page_state(nr_pte_chain_pages);
		for (; i-- > 0; pte_chain++)
			pte_chain_push(pte_chain);
	} else {
		/* Yeah yeah, I'll fix the pte_chain allocation ... */
		panic("Fix pte_chain allocation, you lazy bastard!\n");

how will you fix the pte_chain allocation to avoid deadlocks? please
elaborate. none of the callers can handle a failure there, no surprise
there is a panic there.

> - The only thing we now need page.list for is tracking dirty pages.
>   Implement a 64-bit dirtiness bitmap in radix_tree_node, propagate
>   that up the radix tree so we can efficiently traverse dirty pages
>   in a mapping.  This also allows writeback to always write in ascending
>   index order.  Remove page->list.  8 bytes saved.
> 

page->list is needed for the freelist, but ok you could now share
freelist and lru since they're mutually exclusive. This seems a nice
idea for the ordering in particular, but again the "find" algorithm will
be slower and walking a tree in order is even a recursive operation that
will require either sane programming and a recursive algorithm that will
overflow the stack with a big radix tree at offset 200T on a 64bit arch,
or dynamic allocations and overcomplex code.

> - Remove ->virtual, do page_address() via a hash.  4(ish) bytes saved.

note you still have to handle the collisions, it's not like the
waitqueue hash were you avoid handling the collisions by doing a
wake-all. You should handle the collision with kmalloc dyn-alloc
but you have no failure path there.

In short none of these things cames for free, it's not like the page
based writeback that removes overhead. They're not obvious optimizations
to my eyes, but yes you could theoretically shrunk the struct page that
way, but I'm pretty much fine to pay with ram if the other option is to
run slower.

The keeping track of dirty pages into a tree and to walk the tree in
ascendent order to flush those dirty pages may actually pay off, in
userspace with a recursive stack, but in kernel even only the fact we
cannot handle a kmalloc failure during dirty flushing is a showstopper
for those algorithms that means OOM deadlock, you cannot just avoid to
flush dirty pages and try again, everybody may be trying to flush dirty
pages to make progress. In userspace that just means "task dies with
-ENOMEM or sigkill from kernel, plug some more ram or add some more swap
and try again", but for an operative system the thing is different.

Andrea
