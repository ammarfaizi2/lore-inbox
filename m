Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310412AbSCGREA>; Thu, 7 Mar 2002 12:04:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310403AbSCGRDv>; Thu, 7 Mar 2002 12:03:51 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:17480 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S310153AbSCGRDj>; Thu, 7 Mar 2002 12:03:39 -0500
Date: Thu, 7 Mar 2002 18:03:00 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: William Lee Irwin III <wli@holomorphy.com>, linux-kernel@vger.kernel.org,
        riel@surriel.com, hch@infradead.org, phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020307180300.B25470@dualathlon.random>
In-Reply-To: <20020307092119.A25470@dualathlon.random> <20020307104942.GC786@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020307104942.GC786@holomorphy.com>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 02:49:42AM -0800, William Lee Irwin III wrote:
> On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
> > 	Changed the wait_table stuff, first of all have it per-node (no point
> > 	of per-zone),
> 
> Yes there is. It's called locality of reference. Zones exhibit distinct
> usage patterns and affinities; hence, they should have distinct tables.

there is no different usage pattern, the pages you're waiting on are all
in the pagecache, that spreads across the whole ram of the machine on
any arch. That's just wasted ram. I didn't made it global for the
numa locality in memory of the local node (so it uses the whole bandwith
better and with reads there's more chances the cpu issuing the wait is
on the local node too).

> It is unwise to allow pressure on one zone (i.e. many waiters there) to
> interfere with (by creating collisions) efficient wakeups for other zones.
> 
> 
> On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
> >	then let it scale more with the ram in the machine (the
> > 	amount of ram used for the wait table is ridicolously small and it
> > 	mostly depends on the amount of the I/O, not on the amount of ram, so
> > 	set up a low limit instead of an high limit).
> 
> The wait_table does not need to scale with the RAM on the machine
> 	It needs to scale with the number of waiters.

16G machines tends to have much more cpu and waiters than a 32mbyte
machines. With a 32mbyte machine you'll run out of kernel stack first :)

> 4096 threads blocked on I/O is already approaching or exceeding the
> scalability limits of other core kernel subsystems.

It's not only a matter of 4096 limit, the ram wastage is so ridicolously
low, that we definitely want to decrease the probability of collisions,
since 16k for those 16G boxes is nothing, also knowing we'll more likely
have several thousand of threads blocking on I/O in those machines
(no-async IO in 2.4). Furthmore we don't know if some future arch is
able to deliver more cpu/bus/ram performance and scale better so I
wouldn't put such limit given the so little ram utilization on a huge
box.

> On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
> >                                                      The hashfn I wasn't
> > 	very confortable with.
> 
> I am less than impressed by this unscientific rationale.
> 
> 
> On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
> >                               This one is the same of pagemap.h, and it's
> > 	not that huge on the 64bit archs.  If something it had to be a mul.
> 
> It was a mul. It was explicitly commented that the mul was expanded to a
> shift/add implementation to accommodate 64-bit architectures, and the
> motivation for the particular constant to multiply by was documented in
> several posts of mine. It didn't "have to be", it was, and was commented.
> 
> This is not mere idle speculation and unfounded micro-optimization.
> This is a direct consequence of reports of poor performance due to the
> cost of multiplication on several 64-bit architectures, which was

I think that happened to be true 10 years ago. I don't know of any
recent machine where some dozen of incremental shifts is faster than a
single plain mul. Am I wrong?

> resolved by the expansion of the multiplication to shifts and adds
> (the multiplier was designed from inception to support expansion to shifts
> and adds; it was discovered the compiler could not do this automatically).
> 
> And for Pete's sake that pagemap hash function is ridiculously dirty code;

the pagemap.h ensures that following indexes will fall into the same
hash cacheline. That is an important property. The sizeof(struct inode)
trickery also allows the compiler not to divided the inode pointer for
the size of the inode, but it allows it to optimize it to a right shift,
Linus is be so kind to explain it to me years ago when I really couldn't
see the point of such trickery. A shift is faster than a div (note:
this have nothing to do with the dozen of shifts and the mul).

> please, regardless of whether you insist on being inefficient for the
> sake of some sort of vendetta, or deny the facts upon which the prior

What vendetta sorry :) ? If I change something is because I feel it's
faster/cleaner done that way, I will never change anything unless I've
a technical argument for that.

> implementation was based, or just refuse to cooperate until the bitter
> end, please, please, clean that hash up instead of copying and pasting it.
> 
> 
> On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
> > 	This hashfn ensures to be contigous on the cacheline for physically
> > 	consecutive pages, and once the pages are randomized they just provide
> > 	enough randomization, we just need to protect against the bootup when
> > 	it's more likely the pages are physically consecutive.
> 
> Is this some kind of joke? You honestly believe some kind of homebrew
> strategy to create collisions is remotely worthwhile? Do you realize
> even for one instant that the cost of collisions here is *not* just a
> list traversal, but also the spurious wakeup of blocked threads? You've

I know what happens during collisiosn, do you really think I designed my
hashfn to make more collisions than yours?

> gone off the deep end in an attempt to be contrary; this is even more
> than demonstrably inefficient, it's so blatant inspection reveals it.

Please proof it in practice.

I repeat: the page during production are truly random, so neither my nor
your hashfn can make any difference, they cannot predict the future. So
IMHO you're totally wrong.

I think you're confused sometime there's a relationship between the hash
input, here there's no relationship at all, except at the very early
boot stage (or because somebody freed some multipage previously) where
pages could have an higher probability to be physically consecutive, and
my hashfn infact takes care of distributing well such case, unlike
yours. A mul cannot predict the future.

so please, go ahead, change my code to use your hashfn, monitor the
number of collisions with my hashfn and yours, and if you can measure
that my hashfn will generate a 50% more collisions than yours (you know,
some random variations are very possible since it's totally random, 50%
is a random number, it depends on the standard deviation of the
collisions) I will be glad to apologise for my mistake and to revert to
your version immediatly. All I'm asking is for a real world measurement,
in particular on the long run, just run cerberus for 10 hours or
something like that, and measure the max and mean population at regular
intervals with a tasklet or something like that. Take it as a
"comparison", just to see the difference. If your hashfn is so much
better you will have no worry to show the 50% improvement in real life.
I will also try to do it locally here if time permits, so if you write a
patch please pass it over so we don't duplicate efforts.

For the other points I think you shouldn't really complain (both at
runtime and in code style as well, please see how clean it is with the
wait_table_t thing), I made a definitive improvement to your code, the
only not obvious part is the hashfn but I really cannot see yours
beating mine because of the total random input, infact it could be the
other way around due the fact if something there's the probability the
pages are physically consecutive and I take care of that fine.

Take my changes as a suggestion to try it out, definitely not a
vendetta. Instead of just endlessy sprading words on l-k, I did the
changes in practice instead, so now it is very very easy to make the
comparison.

Don't be offended if I changed your code. I very much appreciate your
and Rik's changes they're good, I only meant to improve them.

If my mistake about the hashfn is so huge, I hope it will be compensated
by the other two improvements at least :).

thanks,

Andrea
