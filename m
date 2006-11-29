Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1758260AbWK2AmL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758260AbWK2AmL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 19:42:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758248AbWK2AmL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 19:42:11 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:24769 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1758238AbWK2AmJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 19:42:09 -0500
Subject: Re: [PATCH 1/6] ext2 balloc: fix _with_rsv freeze
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611281940170.4516@blonde.wat.veritas.com>
References: <1164741967.3769.27.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611281940170.4516@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 28 Nov 2006 16:42:06 -0800
Message-Id: <1164760926.6538.79.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 20:07 +0000, Hugh Dickins wrote:
> On Tue, 28 Nov 2006, Mingming Cao wrote:
> > On Tue, 2006-11-28 at 17:40 +0000, Hugh Dickins wrote:
> > > After several days of testing ext2 with reservations, it got caught inside
> > > ext2_try_to_allocate_with_rsv: alloc_new_reservation repeatedly succeeding
> > > on the window [12cff,12d0e], ext2_try_to_allocate repeatedly failing to
> > > find the free block guaranteed to be included (unless there's contention).
> > >
> >
> > Hmm, I suspect there is other issue: alloc_new_reservation should not
> > repeatedly allocating the same window, if ext2_try_to_allocate
> > repeatedly fails to find a free block in that window.
> > find_next_reservable_window() takes my_rsv (the old window that he
> > thinks there is no free block) as a guide to find a window "after" the
> > end block of my_rsv, so how could this happen?
> 
> Hmmm.  I haven't studied that part of the code, but what you say sounds
> sensible: that would leave more to be explained, yes.  I guess it would
> happen if all the rest of the bitmap were either allocated or reserved,

But bitmap_search_next_usable_block() will fail in the case the rest of
bitmap were allocated, and find_next_reservable_space() will fail in the
case the rest of group were all reserved. alloc_new_reservation() should
not create a new window in this case. 

> but I don't believe that was the case here: I have noted that the map
> was all 00s from offset 0x1ae onwards, plenty unallocated; I've not
> recorded the following reservations, but it seems unlikely they covered
> the remaining free area (and still covered it even when the remaining
> tasks got to the point of just waiting for this one).
> 
> >
> > > Fix the range to find_next_usable_block's memscan: the scan from "here"
> > > (0xcfe) up to (but excluding) "maxblocks" (0xd0e) needs to scan 3 bytes
> > > not 2 (the relevant bytes of bitmap in this case being f7 df ff - none
> > > 00, but the premature cutoff implying that the last was found 00).
> > >
> >
> > alloc_new_reservation() reserved a window with free block, when come to
> > the time to claim it, it scans the window again. So it seems that the
> > range of the the scan is too small:
> 
> The range of the scan is 1 byte too small in this case, yes.
> 
> >
> >         p = ((char *)bh->b_data) + (here >> 3);
> >         r = memscan(p, 0, (maxblocks - here + 7) >> 3);
> >         next = (r - ((char *)bh->b_data)) << 3;
> >
> > 		--------------------->   next is -1
> 
> I don't understand you: next was not -1, it was 0xd08.
> 
> >         if (next < maxblocks && next >= here)
> >                 return next;
> >
> > 		----------------------> falls to false branch
> 
> No, it passed the "next < maxblocks && next >= here" test
> (maxblocks being 0xd0e and here being 0xcfe), so returned
> pointing to an allocated block - then the caller finds it
> cannot set the bit.
> 

Apologies for the confusion. I thought ext2_try_to_allocate() failed
because we could not find a free block in the reserved window (i.e.,
find_next_usable_block() failed)

It seems in this case, find_next_usable_block() incorrectly returns a
bit it *thinks* free, but ext2_try_to_allocate() fails to claim it as
it's being marked as used.


So yes, Acked this fix. Thanks.

> >
> >         here = bitmap_search_next_usable_block(here, bh, maxblocks);
> >         return here;
> >
> > So we failed to find a free byte in the range.  That's seems fine to me.
> > It's only a nice thing to have -- try to allocate a block in a place
> > where it's neighbors are all free also. If it fails, it will search the
> > window bit by bit. So I don't understand why it is not being recovered
> > by bitmap_search_next_usable_block(), which test the bitmap bit by bit?
> 
> It already returned, it doesn't reach that line.
> 
Yep.

> >
> > > Is this a problem for mainline ext2?  No, because the "size" in its memscan
> > > is always EXT2_BLOCKS_PER_GROUP(sb), which mkfs.ext2 requires to be a
> > > multiple of 8.  Is this a problem for ext3 or ext4?  No, because they have
> > > an additional extN_test_allocatable test which rescues them from the error.
> > >
> > Hmm, if the error is it prematurely think there is no free block in the
> > range (bitmap on disk), then even in ext3/4, it will not bother checking
> > the jbd copy of the bitmap. I am not sure this is the cause that ext3/4
> > may not has the problem.
> 
> In the ext3/4 case, it indeed won't bother to check the jbd copy
> (having found this bitmap bit set), it'll fall through to the
> bitmap_search_next_usable_block you indicated above,
> and that should do the right thing, finding the first
> free bit in the area originally reserved.
> 
Make sense.  
> >
> > > But the bigger question is, why does the my_rsv case come here to
> > > find_next_usable_block at all?
> >
> > Because grp_goal is -1?
> 
> Well, yes, but my point is that we've got a reservation, and we're
> hoping to allocate from it (even though we've given up on the "goal"),
> but find_next_usable_block is not respecting it at all - liable to be
> allocating out of others' reservations instead.
> 
Okay got your points. I think you are right.:) Well, right now the
window is just a (start,end) pair which pointing to a range that nobody
has reserved, that doesn't include the information about which block is
free even though we did scan the bitmap making sure there is a free
block.  So when alloc_new_reservation() successfully create a new
window, so we still relies on find_next_usable() to check for which free
block to use.

It does seem redundant in the reservation case. We could adjust the new
created window start block to the first free block returned from
bitmap_search_next_usable_block(), so that the information of first free
block in the window got passed to ext2_try_to_allocate().

> >
> > >  Doesn't its 64-bit boundary limit, and its
> > > memscan, blithely ignore what the reservation prepared?
> >
> > I agree with you that the double check is urgly. But it's necessary:( If
> > there to prevent contention: other file make steal that free block we
> > reserved for this file, in the case filesystem is full of reservation...
> 
> I agree it's necessary to recheck the allocation; I disagree that the
> 64-bit boundary limit and memscan are appropriate when my_rsv is set.
> 

Okay, I understand your points now:) Quite reasonable. I have the
similar doubts when I first touch this code when implement reservation
code.  it's all about allocation policy.  Looking at the
ext2_try_to_allocate(), it's the core of ext2/3 block allocation
strategy:

1) if there are some free block near by the goal block(64 bit boundary
limit), then take that block (locality)

2) otherwise, try to place a new block in a contiguous chunk of free
block(memscan for a free byte), so file could be less fragmented

3) otherwise, any free block in the given range of bitmap will work.

The same policy applies to both reservation and non reservation: goal
guided first, then searching for free chunk. the In the following
example, reservation window is (16,39), goal is block 32, blocks 17,
24-31, and 33 are free.  Which block should it allocate?
            
|------------------------------------------------|
|1 0 1 1 1 1 1 1 0 0 0 0 0 0 0 0 1 0 1 1 1 1 1 1 |
|------------------------------------------------|
16              24               32              40         

In the current code with 64bit boundary limit, it will try to satisfy
locality so block #33 will be allocated. If we skip the 64bit boundary
limit and and memscan, it will go directly pick up block #17, seems less
optimized.

> >
> > >   It's messy too,
> > > the complement of the memscan being that "i < 7" loop over in
> > > ext2_try_to_allocate.  I think this ought to be cleaned up,
> > > in ext2+reservations and ext3 and ext4.
> > >
> > The "i<7" loop there is for non reservation case. Since
> > find_next_usable_block() could find a free byte, it's trying to avoid
> > filesystem holes by shifting the start of the free block for at most 7
> > times.
> 
> Yes, the "i<7" loop rightly has a !my_rsv check; my point it that it's
> the "other end" of the memscan, which was operating 8-bits at a time,
> which lacks any my_rsv check (doesn't even know my_rsv at that level).
> 

To me memscan still make sense for reservation case. In above example,
if block #33 is also allocated, since there is no free block nearby
(right side) the goal block, it probably better to allocate block #24,
so that the next allocation will be contiguous if application is doing
sequential allocation.


Mingming

