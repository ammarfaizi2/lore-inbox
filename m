Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289769AbSA2R1h>; Tue, 29 Jan 2002 12:27:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289775AbSA2R12>; Tue, 29 Jan 2002 12:27:28 -0500
Received: from helen.CS.Berkeley.EDU ([128.32.131.251]:38284 "EHLO
	helen.CS.Berkeley.EDU") by vger.kernel.org with ESMTP
	id <S289769AbSA2R1S>; Tue, 29 Jan 2002 12:27:18 -0500
Date: Tue, 29 Jan 2002 09:27:01 -0800
From: Josh MacDonald <jmacd@CS.Berkeley.EDU>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org, reiserfs-list@namesys.com,
        reiserfs-dev@namesys.com
Subject: Re: Note describing poor dcache utilization under high memory pressure
Message-ID: <20020129092701.C8740@helen.CS.Berkeley.EDU>
In-Reply-To: <20020128091338.D6578@helen.CS.Berkeley.EDU> <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.33.0201280930130.1557-100000@penguin.transmeta.com>; from torvalds@transmeta.com on Mon, Jan 28, 2002 at 09:39:25AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Linus Torvalds (torvalds@transmeta.com):
>
> On Mon, 28 Jan 2002, Josh MacDonald wrote:
> >
> > So, it would seem that the dcache and kmem_slab_cache memory allocator
> > could benefit from a way to shrink the dcache in a less random way.
> > Any thoughts?
>
> The way I want to solve this problem generically is to basically get rid
> of the special-purpose memory shrinkers, and have everything done with one
> unified interface, namely the physical-page-based "writeout()" routine. We
> do that for the page cache, and there's nothing that says that we couldn't
> do the same for all other caches, including very much the slab allocator.
>
> Thus any slab user that wants to, could just register their own per-page
> memory pressure logic. The dcache "reference" bit would go away, to be
> replaced by a per-page reference bit (that part could be done already, of
> course, and might help a bit on its own).
>
> Basically, the more different "pools" of memory we have, the harder it
> gets to balance them. Clearly, the optimal number of pools from a
> balancing standpoint is just a single, direct physical pool.
>
> Right now we have several pools - we have the pure physical LRU, we have
> the virtual mapping (where scanning is directly tied to the physical LRU,
> but where the separate pool still _does_ pose some problems), and we have
> separate balancing for inodes, dentries and quota. And there's no question
> that it hurts us under memory pressure.
>
> (There's a related question, which is whether other caches might also
> benefit from being able to grow more - right now there are some caches
> that are of a limited size partly because they have no good way of
> shrinking back on demand).

Using a physical-page-based "writeout()" routine seems like a nice way
to unify the application of memory pressure to various caches, but it
does not address the issue of fragmentation within a cache slab.  You
could have a situation in which a number of hot dcache entries are
occupying some number of pages, such that dcache pages are always more
recently used than other pages in the system.  Would the VM ever tell
the dcache to writeout() in that case?

It seems that the current special-purpose memory "shrinkers" approach
has some advantages in this regard: when memory pressure is applied
every cache attempts to free some resources.  Do you envision the
unified interface approach applying pressure to pages of every kind of
cache under memory pressure?

Even so, the physical-page writeout() approach results in a less
effective cache under memory pressure.  Suppose the VM chooses some
number of least-recently-used physical pages belonging to the dcache
and tells the slab allocator to release those pages.  Assume that the
dcache entries are not currently in use and that the dcache is in fact
able to release them.  Some of the dcache entries being tossed from
memory could instead replace less-recently-used objects on more
recently-used physical pages.  In other words, the dcache would
benefit from relocating its more frequently used entries onto the same
physical pages under memory pressure.

Unless the cache ejects entries based on the object access and not
physical page access, the situation will never improve.  Pages with
hot dcache entries will never clean-out the inactive entries on the
same page.  For this reason, I don't think it makes sense to eliminate
the object-based aging of cache entries altogether.

Perhaps a combination of the approaches would work best.  When the VM
system begins forcing the dcache to writeout(), the dcache could both
release some of its pages by ejecting all the entries (as above) and
in addition it could run something like prune_dcache(), thus creating
free space in the hotter set of physical pages so that over a period
of prolonged memory pressure, the hotter dcache entries would
eventually become located on the same pages.

A solution that relocates dcache entries to reduce total page
consumption, however, makes the most effective use of cache space.

-josh

-- 
PRCS version control system    http://sourceforge.net/projects/prcs
Xdelta storage & transport     http://sourceforge.net/projects/xdelta
Need a concurrent skip list?   http://sourceforge.net/projects/skiplist
