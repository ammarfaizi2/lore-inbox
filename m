Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293596AbSCKEMA>; Sun, 10 Mar 2002 23:12:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293599AbSCKELv>; Sun, 10 Mar 2002 23:11:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16196 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S293596AbSCKELj>; Sun, 10 Mar 2002 23:11:39 -0500
Date: Mon, 11 Mar 2002 05:12:48 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Rik van Riel <riel@conectiva.com.br>
Cc: "Martin J. Bligh" <fletch@aracnet.com>, lse-tech@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
Subject: Re: 23 second kernel compile (aka which patches help scalibility on NUMA)
Message-ID: <20020311051248.Q8949@dualathlon.random>
In-Reply-To: <20020311031425.N8949@dualathlon.random> <Pine.LNX.4.44L.0203102319440.2181-100000@imladris.surriel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L.0203102319440.2181-100000@imladris.surriel.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 10, 2002 at 11:23:47PM -0300, Rik van Riel wrote:
> On Mon, 11 Mar 2002, Andrea Arcangeli wrote:
> > On Fri, Mar 08, 2002 at 09:47:04PM -0800, Martin J. Bligh wrote:
> > > Big locks left:
> > >
> > > pagemap_lru_lock
> > > 20.2% 57.1%  5.4us(  86us)  111us(  16ms)(14.7%)   1014988 42.9% 57.1%    0%
> >
> > I think this is only due the lru_cache_add executed by the anonymous
> > pagefaults. Pagecache should stay in the lru constantly if you're
> > running in hot pagecache as I guess. For a workload like this one
> > keeping anon pages out of the lru would be an obvious win.
> 
> ... but only if you're really dealing with anonymous pages,

That's what the workload does, yes. The rest will stay in pagecache
persistent because there's enough ram. my comments only wanted to
explain _where_ the collisons happens and why we are adding anon pages
to the lru even before converting them to pagecache, I'm not saying we
need to change that part.

> > It's a tradeoff. Just like the additional memory/cpu and locking
> > overhead that rmap requires will slowdown page faults even more than
> > what you see now, with the only object to get a nicer pagout behaviour
> > (modulo the ram-binding "migration" stuff where rmap is mandatory to do
> > it instantly and not over time).
> 
> Rmap will also make it possible to have the lru lock per
> zone (or per node), which should give rather nice behaviour
> for large SMP and NUMA systems ... even if the workload
> isn't made up of anonymous pages ;)

I don't see the relation with rmap, rmap only makes possible the
immediate migration with strong numa memory bindings and it decreases
the complexity of the pageout load, but it has nothing to do with the
lru lock per-node, that's an orthogonal problem.

> Btw, what is the "ram binding migration stuff" you are
> talking about and why would rmap not be able to do it in
> a nice way ?

Actually I was trying to say you _need_ rmap to do the ram binding
migration stuff on numa :), not the other way around. Without full rmap
we can only trivially provide weak bindings, but not strong-migration
bindings. Since we just have the rmap information for all the file
mappings, only anonymous memory and shm isn't covered by the rmap
information in 2.[45] mainline, so we could as well break the COW while
migrating the pages instead of collecting the rmap stuff for anon pages
too, and shm could be associated with an internal file).

But I think the main point is how much more efficient it is the direct
chain to the pte rather than having to walk the pgd/pmd every time (even
if it would be an O(1) operation too for every mapping in the list).

Andrea
