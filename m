Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318152AbSIAWwS>; Sun, 1 Sep 2002 18:52:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318153AbSIAWwS>; Sun, 1 Sep 2002 18:52:18 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:1040 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S318152AbSIAWwR>;
	Sun, 1 Sep 2002 18:52:17 -0400
Message-ID: <3D729DD3.AE3681C9@zip.com.au>
Date: Sun, 01 Sep 2002 16:08:03 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.5.33 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Daniel Phillips <phillips@arcor.de>
CC: Christian Ehrhardt <ehrhardt@mathematik.uni-ulm.de>,
       Linus Torvalds <torvalds@transmeta.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC] [PATCH] Include LRU in page count
References: <3D644C70.6D100EA5@zip.com.au> <20020901212943Z16578-4014+1360@humbolt.nl.linux.org> <3D729020.4DFDAC2B@zip.com.au> <E17ld5N-0004cg-00@starship>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:
> 
> On Monday 02 September 2002 00:09, Andrew Morton wrote:
> > Daniel Phillips wrote:
> > >
> > > ...
> > > I'm looking at your spinlock_irq now and thinking the _irq part could
> > > possibly be avoided.  Can you please remind me of the motivation for this -
> > > was it originally intended to address the same race we've been working on
> > > here?
> >
> > scalability, mainly.  If the CPU holding the lock takes an interrupt,
> > all the other CPUs get to spin until the handler completes.  I measured
> > a 30% reducton in contention from this.
> >
> > Not a generally justifiable trick, but this is a heavily-used lock.
> > All the new games in refill_inactive() are there to minimise the
> > interrupt-off time.
> 
> Ick.  I hope you really chopped the lock hold time into itty-bitty pieces.

Max hold is around 7,000 cycles.

> Note that I changed the spin_lock in page_cache_release to a trylock, maybe
> it's worth checking out the effect on contention.  With a little head
> scratching we might be able to get rid of the spin_lock in lru_cache_add as
> well.  That leaves (I think) just the two big scan loops.  I've always felt
> it's silly to run more than one of either at the same time anyway.

No way.  Take a look at http://samba.org/~anton/linux/2.5.30/

That's 8-way power4, the workload is "dd from 7 disks
dd if=/dev/sd* of=/dev/null bs=1024k".

The CPU load in this situation was dominated by the VM.  The LRU list and page
reclaim.  Spending more CPU in lru_cache_add() than in copy_to_user() is
pretty gross.

I think it's under control now - I expect we're OK up to eight or sixteen
CPUs per node, but I'm still not happy with the level of testing.  Most people
who have enough hardware to test this tend to have so much RAM that their
tests don't hit page reclaim.

slablru will probably change the picture too.  There's a weird effect with
the traditional try_to_free_pages() code.  The first thing it does is to run
kmem_cache_shrink().  Which takes a sempahore, fruitlessly fiddles with the
slab and then runs page reclaim.

On the 4-way I measured 25% contention on the spinlock inside that semaphore.
What is happening is that the combination of the sleeping lock and the slab
operations effectively serialises entry into page reclaim.

slablru removes that little turnstile on entry to try_to_free_pages(), and we
will now see a lot more concurrency in shrink_foo().

My approach was to keep the existing design and warm it up, rather than to
redesign.  Is it "good enough" now?   Dunno - nobody has run the tests
with slablru.  But it's probably too late for a redesign (such as per-cpu LRU,
per-mapping lru, etc).

It would be great to make presence on the LRU contribute to page->count, because
that would permit the removal of a ton of page_cache_get/release operations inside
the LRU lock, perhaps doubling throughput in there.   Guess I should get off my
lazy butt and see what you've done (will you for heaven's sake go and buy an IDE
disk and compile up a 2.5 kernel? :))
