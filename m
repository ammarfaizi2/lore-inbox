Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292915AbSCDVh2>; Mon, 4 Mar 2002 16:37:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292916AbSCDVhJ>; Mon, 4 Mar 2002 16:37:09 -0500
Received: from perninha.conectiva.com.br ([200.250.58.156]:12548 "HELO
	perninha.conectiva.com.br") by vger.kernel.org with SMTP
	id <S292915AbSCDVhC>; Mon, 4 Mar 2002 16:37:02 -0500
Date: Mon, 4 Mar 2002 18:36:47 -0300 (BRT)
From: Rik van Riel <riel@conectiva.com.br>
X-X-Sender: riel@duckman.distro.conectiva
To: Andrea Arcangeli <andrea@suse.de>
Cc: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19pre1aa1
In-Reply-To: <20020304191942.M20606@dualathlon.random>
Message-ID: <Pine.LNX.4.44L.0203041732520.1413-100000@duckman.distro.conectiva>
X-spambait: aardvark@kernelnewbies.org
X-spammeplease: aardvark@nl.linux.org
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 4 Mar 2002, Andrea Arcangeli wrote:

> > 2) We can do local per-node scanning - no need to bounce
> > information to and fro across the interconnect just to see what's
> > worth swapping out.
>
> the lru lists are global at the moment, so for the normal swapout
> activitiy rmap won't allow you to do what you mention above

Actually, the lru lists are per zone and have been for a while.

The thing which was lacking up to now is a pagecache_lru_lock
per zone, because this clashes with truncate().  Arjan came up
with a creative solution to fix this problem and I'll integrate
it into -rmap soon...

> (furthmore rmap gives you only the pointer to the pte chain, but there's
> no guarantee the pte is in the same node as the physical page, even
> assuming we'll have per-node inactive/active list, so you'll fall into
> the bouncing scenario anyways rmap or not, only the cpu usage will be
> lower and as side effect you'll bounce less, but you're not avoiding the
> interconnet overhead with the per-node scanning).

Well, if we need to free memory from node A, we will need to
do that anyway. If we don't scan the page tables from node B,
maybe we'll never be able to free memory from node A.

The only thing -rmap does is make sure we only scan the page
tables belonging to the physical pages in node A, instead of
having to scan the page tables of all processes in all nodes.

> Also note that on the modern numa (the thing I mostly care about) in
> misc load (like a desktop), without special usages (like user bindings),
> striping virtual pages and pagecache over all the nodes will be better
> than restricting one task to use only the bandwith of one bank of ram,
> so decreasing significantly the potential bandwith of the global
> machine.

This is an interesting point and suggests we want to start
the zone fallback chains from different places for each CPU,
this both balances the allocation and can avoid the CPUs
looking at "each other's" zone and bouncing cachelines around.


> depends on what kind of numa systems I think. I worry more about the
> complexity with lots of ram. As said above on a 64bit 512G system
> with hundred gigabytes of vm globally mapped at the same time, paging
> out hard beacuse of some terabyte mapping marked dirty during page
> faults, will quite certainly need rmap to pageout such dirty mappings
> efficiently, really no matter if it's cc-numa or not, it's mostly a
> complexity problem.

Indeed.

> I really don't see it as a 2.4 need :). I never said no-way rmap in 2.5.
> It maybe I won't agree on the implementation,

I'd appreciate it if you could look at the implementation and
look for areas to optimise. However, note that I don't believe
-rmap is already at the stage where optimisation is appropriate.

Or rather, now is the time for macro optimisations, not for
micro optimisations.

regards,

Rik
-- 
Will hack the VM for food.

http://www.surriel.com/		http://distro.conectiva.com/

