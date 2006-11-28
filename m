Return-Path: <linux-kernel-owner+willy=40w.ods.org-S936053AbWK1T0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936053AbWK1T0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Nov 2006 14:26:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S936054AbWK1T0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Nov 2006 14:26:18 -0500
Received: from e31.co.us.ibm.com ([32.97.110.149]:20190 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S936053AbWK1T0Q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Nov 2006 14:26:16 -0500
Subject: Re: [PATCH 1/6] ext2 balloc: fix _with_rsv freeze
From: Mingming Cao <cmm@us.ibm.com>
Reply-To: cmm@us.ibm.com
To: Hugh Dickins <hugh@veritas.com>
Cc: Andrew Morton <akpm@osdl.org>, Mel Gorman <mel@skynet.ie>,
       "Martin J. Bligh" <mbligh@mbligh.org>, linux-kernel@vger.kernel.org,
       "linux-ext4@vger.kernel.org" <linux-ext4@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.64.0611281739140.29701@blonde.wat.veritas.com>
References: <20061114014125.dd315fff.akpm@osdl.org>
	 <20061114184919.GA16020@skynet.ie>
	 <Pine.LNX.4.64.0611141858210.11956@blonde.wat.veritas.com>
	 <20061114113120.d4c22b02.akpm@osdl.org>
	 <Pine.LNX.4.64.0611142111380.19259@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611151404260.11929@blonde.wat.veritas.com>
	 <20061115214534.72e6f2e8.akpm@osdl.org> <455C0B6F.7000201@us.ibm.com>
	 <20061115232228.afaf42f2.akpm@osdl.org>
	 <1163666960.4310.40.camel@localhost.localdomain>
	 <20061116011351.1401a00f.akpm@osdl.org>
	 <1163708116.3737.12.camel@dyn9047017103.beaverton.ibm.com>
	 <20061116132724.1882b122.akpm@osdl.org>
	 <Pine.LNX.4.64.0611201544510.16530@blonde.wat.veritas.com>
	 <1164073652.20900.34.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611210508270.22957@blonde.wat.veritas.com>
	 <1164156193.3804.48.camel@dyn9047017103.beaverton.ibm.com>
	 <Pine.LNX.4.64.0611281659190.29701@blonde.wat.veritas.com>
	 <Pine.LNX.4.64.0611281739140.29701@blonde.wat.veritas.com>
Content-Type: text/plain
Organization: IBM LTC
Date: Tue, 28 Nov 2006 11:26:07 -0800
Message-Id: <1164741967.3769.27.camel@dyn9047017103.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2006-11-28 at 17:40 +0000, Hugh Dickins wrote:
> After several days of testing ext2 with reservations, it got caught inside
> ext2_try_to_allocate_with_rsv: alloc_new_reservation repeatedly succeeding
> on the window [12cff,12d0e], ext2_try_to_allocate repeatedly failing to
> find the free block guaranteed to be included (unless there's contention).
> 

Hmm, I suspect there is other issue: alloc_new_reservation should not
repeatedly allocating the same window, if ext2_try_to_allocate
repeatedly fails to find a free block in that window.
find_next_reservable_window() takes my_rsv (the old window that he
thinks there is no free block) as a guide to find a window "after" the
end block of my_rsv, so how could this happen?


> Fix the range to find_next_usable_block's memscan: the scan from "here"
> (0xcfe) up to (but excluding) "maxblocks" (0xd0e) needs to scan 3 bytes
> not 2 (the relevant bytes of bitmap in this case being f7 df ff - none
> 00, but the premature cutoff implying that the last was found 00).
> 

alloc_new_reservation() reserved a window with free block, when come to
the time to claim it, it scans the window again. So it seems that the
range of the the scan is too small:

        p = ((char *)bh->b_data) + (here >> 3);
        r = memscan(p, 0, (maxblocks - here + 7) >> 3);
        next = (r - ((char *)bh->b_data)) << 3;

		--------------------->   next is -1
        if (next < maxblocks && next >= here)
                return next;

		----------------------> falls to false branch

        here = bitmap_search_next_usable_block(here, bh, maxblocks);
        return here;

So we failed to find a free byte in the range.  That's seems fine to me.
It's only a nice thing to have -- try to allocate a block in a place
where it's neighbors are all free also. If it fails, it will search the
window bit by bit. So I don't understand why it is not being recovered
by bitmap_search_next_usable_block(), which test the bitmap bit by bit? 

> Is this a problem for mainline ext2?  No, because the "size" in its memscan
> is always EXT2_BLOCKS_PER_GROUP(sb), which mkfs.ext2 requires to be a
> multiple of 8.  Is this a problem for ext3 or ext4?  No, because they have
> an additional extN_test_allocatable test which rescues them from the error.
> 
Hmm, if the error is it prematurely think there is no free block in the
range (bitmap on disk), then even in ext3/4, it will not bother checking
the jbd copy of the bitmap. I am not sure this is the cause that ext3/4
may not has the problem.

> But the bigger question is, why does the my_rsv case come here to
> find_next_usable_block at all? 

Because grp_goal is -1?

>  Doesn't its 64-bit boundary limit, and its
> memscan, blithely ignore what the reservation prepared?

I agree with you that the double check is urgly. But it's necessary:( If
there to prevent contention: other file make steal that free block we
reserved for this file, in the case filesystem is full of reservation...

>   It's messy too,
> the complement of the memscan being that "i < 7" loop over in
> ext2_try_to_allocate.  I think this ought to be cleaned up,
> in ext2+reservations and ext3 and ext4.
> 
The "i<7" loop there is for non reservation case. Since
find_next_usable_block() could find a free byte, it's trying to avoid
filesystem holes by shifting the start of the free block for at most 7
times.


Thanks!

Mingming
>  fs/ext2/balloc.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> --- 2.6.19-rc6-mm2/fs/ext2/balloc.c	2006-11-24 08:18:02.000000000 +0000
> +++ linux/fs/ext2/balloc.c	2006-11-27 19:28:41.000000000 +0000
> @@ -570,7 +570,7 @@ find_next_usable_block(int start, struct
>  		here = 0;
> 
>  	p = ((char *)bh->b_data) + (here >> 3);
> -	r = memscan(p, 0, (maxblocks - here + 7) >> 3);
> +	r = memscan(p, 0, ((maxblocks + 7) >> 3) - (here >> 3));
>  	next = (r - ((char *)bh->b_data)) << 3;
> 
>  	if (next < maxblocks && next >= here)
> -
> To unsubscribe from this list: send the line "unsubscribe linux-ext4" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

