Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315198AbSFOJA1>; Sat, 15 Jun 2002 05:00:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315191AbSFOJA0>; Sat, 15 Jun 2002 05:00:26 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:53188 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id <S315182AbSFOJAZ>;
	Sat, 15 Jun 2002 05:00:25 -0400
Date: Sat, 15 Jun 2002 11:00:15 +0200
From: Jens Axboe <axboe@suse.de>
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: akpm@zip.com.au, linux-kernel@vger.kernel.org
Subject: Re: bio_chain: proposed solution for bio_alloc failure and large IO simplification
Message-ID: <20020615090015.GA5869@suse.de>
In-Reply-To: <200206150852.BAA00805@adam.yggdrasil.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 15 2002, Adam J. Richter wrote:
> Jens Axboe wrote:
> >The I/O path allocations all use GFP_NOIO (or GFP_NOFS), which all have
> >__GFP_WAIT set. So the bio allocations will try normal allocation first,
> >then fall back to the bio pool. If the bio pool is also empty, we will
> >block waiting for entries to be freed there. So there never will be a
> >failure.
> 
> 	I did not realize that allocation with __GFP_WAIT was guaranteed
> to _never_ fail.

See the mempool implementation. Even before bio used mempool, it used
the exact same logic to make sure it never fails. Basically the
heuristic in both cases is:

repeat:
	bio = normal_alloc
	if (bio)
		return bio

	bio = get_from_pool
	if (bio)
		return bio

	if (gfp_mask & __GFP_WAIT)
		start disk i/o
		goto repeat;

> 	Even so, if __GFP_WAIT never fails, then it can deadlock (for
> example, some other device driver has a memory leak).  Under a
> scheme like bio_chain (provided that it is changed not to call a
> memory allocator that can deadlock), the only way you deadlock is
> if there really is deadlock bug in the lower layers that process
> the underlying request.

This whole dead lock debate has been done to death before, I suggest you
find the mempool discussions in the lkml archives from the earlier 2.5
series. Basically we maintain deadlock free allocation although we never
fail allocs by saying that a single bio allocation is short lived (or
at least not held indefinetely). That plus a reserve of XX bios makes
sure that someone will always return a bio to the pool sooner or later
and at least the get_from_pool alloc above will succeed sooner or later
even if vm pressure is ridicilous.

-- 
Jens Axboe

