Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310287AbSCGKuZ>; Thu, 7 Mar 2002 05:50:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310284AbSCGKuQ>; Thu, 7 Mar 2002 05:50:16 -0500
Received: from holomorphy.com ([216.36.33.161]:14220 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S310285AbSCGKuK>;
	Thu, 7 Mar 2002 05:50:10 -0500
Date: Thu, 7 Mar 2002 02:49:42 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrea Arcangeli <andrea@suse.de>
Cc: linux-kernel@vger.kernel.org, riel@surriel.com, hch@infradead.org,
        phillips@bonn-fries.net
Subject: Re: 2.4.19pre2aa1
Message-ID: <20020307104942.GC786@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andrea Arcangeli <andrea@suse.de>, linux-kernel@vger.kernel.org,
	riel@surriel.com, hch@infradead.org, phillips@bonn-fries.net
In-Reply-To: <20020307092119.A25470@dualathlon.random>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Description: brief message
Content-Disposition: inline
In-Reply-To: <20020307092119.A25470@dualathlon.random>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
> 	Changed the wait_table stuff, first of all have it per-node (no point
> 	of per-zone),

Yes there is. It's called locality of reference. Zones exhibit distinct
usage patterns and affinities; hence, they should have distinct tables.
It is unwise to allow pressure on one zone (i.e. many waiters there) to
interfere with (by creating collisions) efficient wakeups for other zones.


On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
>	then let it scale more with the ram in the machine (the
> 	amount of ram used for the wait table is ridicolously small and it
> 	mostly depends on the amount of the I/O, not on the amount of ram, so
> 	set up a low limit instead of an high limit).

The wait_table does not need to scale with the RAM on the machine
	It needs to scale with the number of waiters.

4096 threads blocked on I/O is already approaching or exceeding the
scalability limits of other core kernel subsystems.


On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
>                                                      The hashfn I wasn't
> 	very confortable with.

I am less than impressed by this unscientific rationale.


On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
>                               This one is the same of pagemap.h, and it's
> 	not that huge on the 64bit archs.  If something it had to be a mul.

It was a mul. It was explicitly commented that the mul was expanded to a
shift/add implementation to accommodate 64-bit architectures, and the
motivation for the particular constant to multiply by was documented in
several posts of mine. It didn't "have to be", it was, and was commented.

This is not mere idle speculation and unfounded micro-optimization.
This is a direct consequence of reports of poor performance due to the
cost of multiplication on several 64-bit architectures, which was
resolved by the expansion of the multiplication to shifts and adds
(the multiplier was designed from inception to support expansion to shifts
and adds; it was discovered the compiler could not do this automatically).

And for Pete's sake that pagemap hash function is ridiculously dirty code;
please, regardless of whether you insist on being inefficient for the
sake of some sort of vendetta, or deny the facts upon which the prior
implementation was based, or just refuse to cooperate until the bitter
end, please, please, clean that hash up instead of copying and pasting it.


On Thu, Mar 07, 2002 at 09:21:19AM +0100, Andrea Arcangeli wrote:
> 	This hashfn ensures to be contigous on the cacheline for physically
> 	consecutive pages, and once the pages are randomized they just provide
> 	enough randomization, we just need to protect against the bootup when
> 	it's more likely the pages are physically consecutive.

Is this some kind of joke? You honestly believe some kind of homebrew
strategy to create collisions is remotely worthwhile? Do you realize
even for one instant that the cost of collisions here is *not* just a
list traversal, but also the spurious wakeup of blocked threads? You've
gone off the deep end in an attempt to be contrary; this is even more
than demonstrably inefficient, it's so blatant inspection reveals it.

Designing your hash function to create collisions is voodoo, pure and
simple. "Just enough randomization" is also voodoo. The pagemap.h hash
was one of the specific hash functions in the kernel producing
measurably horrific hash table distributions on large memory machines,
and my efforts to find a better hash function for it contributed
directly to the design of the hash functions presented in the hashed
waitqueue code. The (rather long) lengths I've gone to to prevent
collisions are justified by the low impact on the implementation (the
choice of multiplier) and the extremely high cost of collisions in this
scheme, which comes from the wake-all semantics of the hash table buckets.

This reversion to a demonstrably poor hashing scheme in the face of
very high collision penalties is laughable.


Bill
