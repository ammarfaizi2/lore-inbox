Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292942AbSCDW1o>; Mon, 4 Mar 2002 17:27:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292943AbSCDW1f>; Mon, 4 Mar 2002 17:27:35 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:32084 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292942AbSCDW1V>; Mon, 4 Mar 2002 17:27:21 -0500
Date: Mon, 4 Mar 2002 23:25:44 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020304232544.P20606@dualathlon.random>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com> <190330000.1015261149@flay> <20020304191942.M20606@dualathlon.random> <204440000.1015268171@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <204440000.1015268171@flay>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 10:56:11AM -0800, Martin J. Bligh wrote:
> >> 1) We can balance between zones easier by "swapping out"
> >> pages to another zone.
> > 
> > Yes, operations like "now migrate and bind this task to a certain
> > cpu/mem pair" pretty much needs rmap or it will get the same complexity
> > of swapout, that may be very very slow with lots of vm address space
> > mapped. But this has nothing to do with the swap_out pass we were
> > talking about previously.
> 
> If we're out of memory on one node, and have free memory on another,
> during the swap-out pass it would be quicker to transfer the page to
> another node, ie "swap out the page to another zone" rather than swap
> it out to disk. This is what I mean by the above comment (though you're

I think unless we're sure we need to split the system in parts and so
there's some explicit cpu binding (like in the example I made above), it
doesn't worth to do migrations just because one zone is low on memory,
the migration has a cost and without bindings the scheduler is free to
reschedule the task away in the next timeslice anyways, and then it's
better to keep it there for cpu cache locality reasons. So I believe
it's better to make sure to use all available ram in all nodes instead
of doing migrations when the local node is low on mem. But this again
depends on the kind of numa system, I'm considering the new numas, not
the old ones with the huge penality on the remote memory.

> right, it helps with the more esoteric case of deliberate page migration too),
> though I probably phrased it badly enough to make it incomprehensible ;-)
> 
> I guess could this help with non-NUMA architectures too - if ZONE_NORMAL
> is full, and ZONE_HIGHMEM has free pages, it would be nice to be able
> to scan ZONE_NORMAL, and transfer pages to ZONE_HIGHMEM. In
> reality, I suspect this won't be so useful, as there shouldn't be HIGHEM
> capable page data sitting in ZONE_NORMAL unless ZONE_HIGHMEM
> had been full at some point in the past? And I'm not sure if we keep a bit

Exactly, this is what the per-zone point-of-view watermarks just do in
my tree, and this is why even if we're not able to migrate all the
highmem capable pages from lowmem to highmem (like anon memory when
there's no swap, or mlocked memory) we still don't run into inbalances.

btw, to migrate anon memory without swap, we wouldn't really be forced
to use rmap, we could just use anonymous swapcache and then we could
migrate the swapcache atomically with the pagecache_lock acquired, just
like we would do with rmap. but I think the main problem of migration is
"when" should we trigger it. Currently we don't need to answer this
question and the watermarks make sure we've enough lowmem resources not
to madantory need migration. When I did the watermarks fix, I also
consdiered the migration through anon swap cache, but it wasn't black
and white thing, the watermarks are better solution for 2.4 at least I
think :).

> to say where the page could have been allocated from or not ?
> 
> M.
> 
> PS. The rest of your email re: striping twisted my brain out of shape - I'll
> have to think about it some more.


Andrea
