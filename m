Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSG2Bx1>; Sun, 28 Jul 2002 21:53:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316051AbSG2Bx1>; Sun, 28 Jul 2002 21:53:27 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22291 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S316047AbSG2BxZ>;
	Sun, 28 Jul 2002 21:53:25 -0400
Message-ID: <3D44A2DF.F751B564@zip.com.au>
Date: Sun, 28 Jul 2002 19:05:19 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc3-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrea Arcangeli <andrea@suse.de>
CC: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 2.5] Introduce 64-bit versions of 
 PAGE_{CACHE_,}{MASK,ALIGN}
References: <5.1.0.14.2.20020728193528.04336a80@pop.cus.cam.ac.uk> <Pine.LNX.4.44.0207281622350.8208-100000@home.transmeta.com> <3D448808.CF8D18BA@zip.com.au> <20020729004942.GL1201@dualathlon.random>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrea Arcangeli wrote:
> 
> On Sun, Jul 28, 2002 at 05:10:48PM -0700, Andrew Morton wrote:
> > Linus Torvalds wrote:
> > >
> > > ...
> > > Dream on. It's good, and it's not getting removed. The "struct page" is
> > > size-critical, and also correctness-critical (see above on gcc issues).
> > >
> >
> > Plan B is to remove page->index.
> >
> > - Replace ->mapping with a pointer to the page's radix tree
> >   slot.   Use address masking to go from page.radix_tree_slot
> >   to the radix tree node.
> 
> that's not immediate anymore, you've to walk the tree backwards, like
> you do for the lookups.

No, it's contant-time.   page.radix_tree_slot points to the page's
slot in its radix-tree_node.  As long as the radix_tree_nodes are
laid out in memory with a stable alignment, you can go from
page.radix_tree_slot to the radix_tree_node pointer with just some
masking, maybe a modulus.

But yes, all of this is a straight speed/space tradeoff.  Probably
some of it should be ifdeffed.

> I recall you are benchmarking radix tree with dbench.  You've to
> benchmark the worst case not dbench with small files. with small files
> even the rbtree was nicer than the hashtable. The right benchmark is:
> 
>         truncate(800GByte)
>         write(1G)
>         lseek(800Gbyte)
>         fsync()
>         addr = mmap(1G)
>         benchmark_start()
>         mlock(1G)
>         benchmark_stop()
> 
> instead of mlock you can also do read(1G) as you prefer, but the
> overhead of the copy-user would be certainly more significant than the
> overhead of filling the ptes, so an mlock or *even* a page fault should
> be lighter to allow us to better benchmark the pagecache performance.
> 
> The nocopy hack from Lincol would be fine too, then you could read the
> whole thing with one syscall and no pagetable overhead.
> 
> (of course you need >1G of ram to avoid to hit the disk during the read,
> probably the read pass should be read 1 byte, lseek to the next 1byte,
> and you also need the hashtable allocated with the bootmem allocator)

Yes, there are space concerns with the radix tree, and nobody has
tried to really make it fall over yet.

The situation improved when I halved the ratnode size, but a node
is still 1/15th of a page, and the math is fairly easy to do.

Lame fix is to make the nodes even smaller.  Another speed/space
tradeoff.

> Nobody did that yet AFIK, so it's not a surprise nobody found any
> regression with the radix tree (yet). I expect walking 6/7 cacheline
> steps every time is going to be a significant hit

The cost of the tree walk doesn't worry me much - generally we
walk the tree with good locality of reference, so most everything is
in cache anyway.

> (even worse if you
> need to do that every time to derive the index with the gang method).

You don't need to do that.

> Of
> course if you work with small files you'll never walk more than a few
> steps and the regression doesn't showup, that was true with the rbtree
> too two/three years ago.
> 
> The other major problems of radix trees are the GFP_ATOMIC allocations
> that can lead at the very least to I/O failures, the mempool usage seems
> just a band-aid to hide those failures but it works by pure luck it
> seems.

I'm not particularly concerned about that.   There are two scenarios
in which we allocate ratnodes:

1: Adding pages to swap.  Here, failure is OK.  As long as we add
   just a single page to swapcache before running out of ratnodes,
   the system won't deadlock.  The mempool helps here.

2: Adding pagecache pages.  Here, the ratnode allocation occurs just
   a few hundred instructions after we're performed a GFP_HIGHUSER
   allocation.  For the page itself.  So we know that there are
   tons of pages available.   The only way this can fail is if someone
   comes in and allocates a few megabytes of GFP_ATOMIC memory
   at interrupt time in that few-hundred instruction window.
   _and_ if the ratnode mempool is exhausted as well.

   Good luck setting up a testcase which does this ;)
 
> On the same GFP_ATOMIC lines we can find in rmap.c:
> 
> static void alloc_new_pte_chains()
> {
>         struct pte_chain * pte_chain = (void *) get_zeroed_page(GFP_ATOMIC);
>         int i = PAGE_SIZE / sizeof(struct pte_chain);
> 
>         if (pte_chain) {
>                 inc_page_state(nr_pte_chain_pages);
>                 for (; i-- > 0; pte_chain++)
>                         pte_chain_push(pte_chain);
>         } else {
>                 /* Yeah yeah, I'll fix the pte_chain allocation ... */
>                 panic("Fix pte_chain allocation, you lazy bastard!\n");
> 
> how will you fix the pte_chain allocation to avoid deadlocks? please
> elaborate. none of the callers can handle a failure there, no surprise
> there is a panic there.

I think that code's in redhat kernels, actually.  So it's presumably
not occurring on a daily basis.   But no, it cannot be allowed
to live.  It was replaced with a slab in the patches I sent yesterday,
and Bill is cooking something up for the OOM handling there.

> > - The only thing we now need page.list for is tracking dirty pages.
> >   Implement a 64-bit dirtiness bitmap in radix_tree_node, propagate
> >   that up the radix tree so we can efficiently traverse dirty pages
> >   in a mapping.  This also allows writeback to always write in ascending
> >   index order.  Remove page->list.  8 bytes saved.
> >
> 
> page->list is needed for the freelist, but ok you could now share
> freelist and lru since they're mutually exclusive. This seems a nice
> idea for the ordering in particular, but again the "find" algorithm will
> be slower and walking a tree in order is even a recursive operation that
> will require either sane programming and a recursive algorithm that will
> overflow the stack with a big radix tree at offset 200T on a 64bit arch,
> or dynamic allocations and overcomplex code.

No walk for the page_index(page) function.

No recursion either.  Note how the current radix tree code uses a
fixed-size (28 byte) local structure for maintaining the path
down the tree.

> > - Remove ->virtual, do page_address() via a hash.  4(ish) bytes saved.
> 
> note you still have to handle the collisions, it's not like the
> waitqueue hash were you avoid handling the collisions by doing a
> wake-all. You should handle the collision with kmalloc dyn-alloc
> but you have no failure path there.

yes.  But we really need to get all the fastpath kmaps using
kmap_atomic anyway.

> In short none of these things cames for free, it's not like the page
> based writeback that removes overhead. They're not obvious optimizations
> to my eyes, but yes you could theoretically shrunk the struct page that
> way, but I'm pretty much fine to pay with ram if the other option is to
> run slower.

It's the 32G highmem systems which would be prepared to spend the CPU
cycles to get the ZONE_NORMAL savings.  But we'd need appropriate
conditionals so that 64-bit machines didn't need to pay for the 
ia32 highmem silliness.

Then again, Andi says that sizeof(struct page) is a problem for
x86-64.

> The keeping track of dirty pages into a tree and to walk the tree in
> ascendent order to flush those dirty pages may actually pay off, in
> userspace with a recursive stack, but in kernel even only the fact we
> cannot handle a kmalloc failure during dirty flushing is a showstopper
> for those algorithms that means OOM deadlock, you cannot just avoid to
> flush dirty pages and try again, everybody may be trying to flush dirty
> pages to make progress. In userspace that just means "task dies with
> -ENOMEM or sigkill from kernel, plug some more ram or add some more swap
> and try again", but for an operative system the thing is different.

No recursion needed, no allocations needed.

It would have to be coded with some delicacy, yes.  For example,
page_index(page) may only be valid when calculated inside
mapping->page_lock.  Depends how it's done.

But I don't see any showstoppers here.

-
