Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318390AbSGaWSA>; Wed, 31 Jul 2002 18:18:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318401AbSGaWSA>; Wed, 31 Jul 2002 18:18:00 -0400
Received: from dsl-213-023-021-098.arcor-ip.net ([213.23.21.98]:21161 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318390AbSGaWR6>;
	Wed, 31 Jul 2002 18:17:58 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: Andrew Morton <akpm@zip.com.au>
Subject: Rmap setup/teardown suckage
Date: Thu, 1 Aug 2002 00:22:36 +0200
X-Mailer: KMail [version 1.3.2]
Cc: lkml <linux-kernel@vger.kernel.org>, Rik van Riel <riel@conectiva.com.br>
References: <3D439E09.3348E8D6@zip.com.au> <3D459ECE.C5BD53DE@zip.com.au> <E17ZIQH-0004Wo-00@starship>
In-Reply-To: <E17ZIQH-0004Wo-00@starship>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17a1rY-0002rl-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 July 2002 23:51, Daniel Phillips wrote:
> On Monday 29 July 2002 22:00, Andrew Morton wrote:
> > > The idea I'm playing with now is to address an array of locks based on
> > > something like:
> > > 
> > >         spin_lock(pte_chain_locks + ((page->index >> 4) & 0xff));
> > > 
> > > so that 16 consecutive filemap pages use the same lock and there is a limited
> > > total number of locks to keep cache pressure down.  Since we are creating the
> > > vast majority of the pte chain nodes while walking across page tables, this
> > > should give nice locality.
> > 
> > Something like that could help.
>
> [...]
> 
> > > For this to work, anon pages will need to have something in page->index.
> > > This isn't too much of a challenge.  A reasonable value to put in there is
> > > the creator's virtual address, shifted right, and perhaps mangled a little to
> > > reduce contention.
> > 
> > Well you want the likely-to-be-temporally-adjacent anon pages to
> > use the same lock.  So maybe
> > 
> > 	page->index = some_global_int++;
> 
> Yes, that's better.
> 
> > Except ->index gets stomped on when the page gets added to swapcache.
> > Which means that the address of its lock will change.  I can't immediately
> > think of a fix for that.
> 
> We'd have to hold the lock while changing the page->index.  Pte_chain_lock
> would additionally have to check the page->index after acquiring the lock
> and, if changed, drop it and take the new one.  I don't think the overhead 
> for this check is significant.
> 
> Add_to_page_cache would want new flavor that shortens up the pte chain lock 
> hold time, but it looks like it should have a swap-specific variant anyway.

Here's a status report on this:

  - I replicated your results using Rik's rmap12h patch for 2.4.19-pre7.
    The overhead of rmap setup/teardown is a little higher even than the
    minimal rmap patch in 2.5.recent, around 20% bottom line cost for this
    (slightly unrealistic) test.  Rik seems to take the pte_chain_locks
    more often than necessary, a likely explanation for the higher overhead
    vs 2.4.27

  - I'm not doing this in 2.5 because dac960 is broken, and that's what my
    only dual processor machine has.  I'll return to messing with that
    pretty soon (and Jens has offered help) but right now I'm focussed on
    this setup/teardown slowness question.

  - I've implemented the locking strategy described above and it is
    apparently stable.  It seems to reduce the overhead a percent or
    two.  On x86 it still isn't a solution, though it may well be quite
    nice for ppc, judging from earlier results you mentioned.  I'll
    continue to fiddle with anon page assignments to page->index and see 
    if I can get another couple of percent.  It's possible that putting 
    the spinlocks in separate cachelines may help as well.

  - It's clear that I need to move on to batching up the pte chain creates
    to get the kind of improvement we want.

I settled on a variant of the pte_chain_lock interface, and since I had to
update every use of it I adopted a more sensible name as well:

   spinlock_t *lock_rmap(struct page *page);

   void unlock_rmap(spinlock_t *lock);

(The functions formerly known as pte_chain_lock and pte_chain_unlock.)  The
former acquires a lock indexed via page->index and returns it; the latter
is just spin_unlock.  This interface is more efficient than looking up the
lock twice, and also accomodates my wrapper for resetting page->index, which
can't use page->index for the unlock, since it just changed:

static inline void set_page_index(struct page *page, unsigned long index)
{
	spinlock_t *lock = lock_rmap(page);
	page->index = index;
	unlock_rmap(lock);
}

Lock_rmap loops to handle the possibility of page->index changing while
waiting on the lock:

static inline spinlock_t *lock_rmap(struct page *page)
{
	unsigned long index = page->index;
	while (1) {
		spinlock_t *lock = rmap_locks + (index & (num_rmap_locks - 1));
		spin_lock(lock);
		if (index == page->index)
			return lock;
		spin_unlock(lock);
	}	
}

The normal case is nearly as efficient as a raw spin_lock.  I  probably have
to invalidate page->index for non-cache-coherent architectures.  I'll worry
about that detail more if I get somewhere with the optimization on i386.

No doubt there are cases where the set_page_index doesn't have to be covered
by the rmap lock but I didn't spend time hunting for them - they're different
in 2.5 and this overhead doesn't seem to move the needle anyway.

I think this much is fairly solid.  Now I'll see if I can take advantage of
this infrastructure by batching up the setup/teardown in copy_page_range,
which is apparently the main cause of the suckage.

-- 
Daniel
