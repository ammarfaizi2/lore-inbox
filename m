Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751102AbVLTPor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751102AbVLTPor (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Dec 2005 10:44:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751103AbVLTPoq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Dec 2005 10:44:46 -0500
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:36012 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S1751102AbVLTPop (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Dec 2005 10:44:45 -0500
Subject: [PATCH RT 00/02] SLOB optimizations
From: Steven Rostedt <rostedt@goodmis.org>
To: Ingo Molnar <mingo@elte.hu>
Cc: Andrew Morton <akpm@osdl.org>, Matt Mackall <mpm@selenic.com>,
       john stultz <johnstul@us.ibm.com>,
       Gunter Ohrner <G.Ohrner@post.rwth-aachen.de>,
       linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
References: <dnu8ku$ie4$1@sea.gmane.org>
	 <1134790400.13138.160.camel@localhost.localdomain>
	 <1134860251.13138.193.camel@localhost.localdomain>
	 <20051220133230.GC24408@elte.hu>
	 <Pine.LNX.4.58.0512200836120.21313@gandalf.stny.rr.com>
	 <20051220135725.GA29392@elte.hu>
	 <Pine.LNX.4.58.0512200900490.21767@gandalf.stny.rr.com>
Content-Type: text/plain
Date: Tue, 20 Dec 2005 10:44:20 -0500
Message-Id: <1135093460.13138.302.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(Andrew, I'm CC'ing you and Matt to see if you would like this in -mm)

OK Ingo, here it is.

The old SLOB did the old K&R memory allocations.

It had a global link list "slobfree".  When it needed memory it would
search this list linearly to find the first spot that fit and then
return it.  It was broken up into SLOB_UNITS which was the number of
bytes to hold slob_t.

Since the sizes of the allocations would greatly fluctuate, the chances
for fragmentation was very high.  This would also cause the looking for
free locations to increase, since the number of free blocks would also
increase due to the fragmentation.

It also had one global spinlock for ALL allocations.  This would
obviously kill SMP performance.

For large blocks greater than PAGE_SIZE it would just use the buddy
system.  This I didn't change, in fact, I made it use the buddy system
for blocks greater than PAGE_SIZE >> 1, but I'll explain that below.

The problem that this system had, was it made another global link list
to hold all of these large blocks, which means it needed another global
spinlock to manage this list.

When any block was freed via kfree, it would first search all the big
blocks to see if it was a large allocation, and if not, then it would
search the slobfree list to find where it goes.  Both taking two global
spinlocks!


Here's what I've done to solve this.

First things first, the first patch was to get rid of the bigblock list.
I'm simple used the method of SLAB to use the lru list field of the
corresponding page to store the pointer to the bigblock descriptor which
has the information to free it. This got rid of the bigblock link list
and global spinlock.

The next patch was the big improvement, with the largest changes.  I
took advantage of how the kmem_cache usage that SLAB also takes
advantage of.  I created a memory pool like the global one, but for
every cache with a size less then PAGE_SIZE >> 1.

[ Note: I picked PAGE_SIZE >> 1, since it didn't seem to make much
difference when there were greater, since it would use a full page for
just one allocation.  I can play with this more, but it still seems to
be a waste ].

I used lru.next of the page that the pages are allocated for, for the
bigblock descriptors (as described above), and now I use lru.prev to
point to the cache that the items belong to in the pool.  So I removed
the need for the descriptor being held in the pool.

I also created the general caches like SLAB for kmalloc and kfree, for
sizes 32 through PAGE_SIZE >> 1.  All greater allocations will use the
backend buddy system.

Tests:
=====

To test this, I used what showed the problem the greatest.  Doing a make
install over NFS.  So on my 733MHz UP machine, I ran "time make install"
on the -rt kernel with the old SLAB, as well as -rt kernel with the
default (old) SLOB, and then with the SLOB with these patches (three
tests each).  Here's the results:

rt with slab:

run 1:
  real    0m27.327s
  user    0m15.151s
  sys     0m3.149s

run 2:
  real    0m26.952s
  user    0m15.171s
  sys     0m3.178s

run 3:
  real    0m27.269s
  user    0m15.175s
  sys     0m3.226s

rt with slob (plain):

run 1:
  real    1m26.845s
  user    0m16.173s
  sys     0m29.558s

run 2:
  real    1m27.895s
  user    0m16.532s
  sys     0m30.460s

run 3:
  real    1m25.645s
  user    0m16.468s
  sys     0m30.973s

rt with slob (new):

run 1:
  real    0m28.740s
  user    0m15.364s
  sys     0m3.866s

run 2:
  real    0m27.782s
  user    0m15.409s
  sys     0m3.885s

run 3:
  real    0m27.576s
  user    0m15.193s
  sys     0m3.933s


So I have improved the speed of SLOB to almost that of SLAB!

TODO:  IMPORTANT!!!

1) I haven't cleaned up the kmem_cache_destroy yet, so every time that
happens, there's a memory leak.

2) I need to test on SMP.

-- Steve


