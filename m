Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292963AbSCDXDN>; Mon, 4 Mar 2002 18:03:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292967AbSCDXDD>; Mon, 4 Mar 2002 18:03:03 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:3674 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292963AbSCDXCw>; Mon, 4 Mar 2002 18:02:52 -0500
Date: Tue, 5 Mar 2002 00:01:02 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020305000102.S20606@dualathlon.random>
In-Reply-To: <20020304191942.M20606@dualathlon.random> <Pine.LNX.4.44L.0203041732520.1413-100000@duckman.distro.conectiva>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203041732520.1413-100000@duckman.distro.conectiva>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 06:36:47PM -0300, Rik van Riel wrote:
> On Mon, 4 Mar 2002, Andrea Arcangeli wrote:
> 
> > > 2) We can do local per-node scanning - no need to bounce
> > > information to and fro across the interconnect just to see what's
> > > worth swapping out.
> >
> > the lru lists are global at the moment, so for the normal swapout
> > activitiy rmap won't allow you to do what you mention above
> 
> Actually, the lru lists are per zone and have been for a while.

They're not in my tree and for very good reasons, Ben did such mistake
the first time at some point during 2.3. You've a big downside with the
per-zone information, all normal machines (like with 64M of ram or 2G of
ram) where theorical O(N) complexity is perfectly fine for lowmem
dma/normal allocations, will get hurted very much by the per-node lrus.
You're the one saying that the system load is very low and that it's
better to do more accurate page replacement decisions.

I think they may be worthwhile on a hundred gigabyte machine only, but
the whole point is that in such a box you'll have only one zone anyways
and so per-zone in such case will match per-node :).

So I think they should be at least per-node in 2.5 to make 99% of
userbase happy.  And again, it depends on what kind numa if they've to
be global or per-node, so it would be probably much better to have them
per-node or global depending on a compile-time configuration #define.

> The thing which was lacking up to now is a pagecache_lru_lock
> per zone, because this clashes with truncate().  Arjan came up
> with a creative solution to fix this problem and I'll integrate
> it into -rmap soon...

making it a per-lru spinlock is natural scalability optimization, but
anyways pagemap_lru_lock isn't a very critical spinlock.  before
worrying about pagemal_lru_lock I'd worry about the pagecache_lock I
think (even the pagecache_lock doesn't matter much on most usages). Of
course it also depends on the workload, but the important workloads will
hit the pagecache_lock first.

> > (furthmore rmap gives you only the pointer to the pte chain, but there's
> > no guarantee the pte is in the same node as the physical page, even
> > assuming we'll have per-node inactive/active list, so you'll fall into
> > the bouncing scenario anyways rmap or not, only the cpu usage will be
> > lower and as side effect you'll bounce less, but you're not avoiding the
> > interconnet overhead with the per-node scanning).
> 
> Well, if we need to free memory from node A, we will need to
> do that anyway. If we don't scan the page tables from node B,
> maybe we'll never be able to free memory from node A.
> 
> The only thing -rmap does is make sure we only scan the page
> tables belonging to the physical pages in node A, instead of
> having to scan the page tables of all processes in all nodes.

Correct. And as said this is a scalability optimization, the more ptes
you'll have, the more you want to skip the ones belonging to pages in
node B, or you may end wasting too much system time on 512G system etc...

> I'd appreciate it if you could look at the implementation and
> look for areas to optimise. However, note that I don't believe

I didn't had time to look too much into that yet (I had only a short
review so far), but I will certainly do that in some more time, looking
at it with a 2.5 long term prospective. I didn't liked too much that you
resurrected some of the old code that I don't think pays off. I would
preferred if you had rmap on top of my vm patch without reintroducing
the older logics. I still don't see the need of inactive_dirty and the
fact you dropped classzone and put the unreliable "plenty stuff" that
reintroduces design bugs that will lead kswapd go crazy again. But ok, I
don't worry too much about that, the rmap bits that maintains the
additional information are orthogonal with the other changes and that's
the interesting part of the patch after all.

Andrea
