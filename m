Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292648AbSCDSWZ>; Mon, 4 Mar 2002 13:22:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292654AbSCDSWM>; Mon, 4 Mar 2002 13:22:12 -0500
Received: from penguin.e-mind.com ([195.223.140.120]:16948 "EHLO
	penguin.e-mind.com") by vger.kernel.org with ESMTP
	id <S292652AbSCDSV6>; Mon, 4 Mar 2002 13:21:58 -0500
Date: Mon, 4 Mar 2002 19:19:42 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Cc: Rik van Riel <riel@conectiva.com.br>,
        Daniel Phillips <phillips@bonn-fries.net>,
        Bill Davidsen <davidsen@tmr.com>, Mike Fedyk <mfedyk@matchmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: 2.4.19pre1aa1
Message-ID: <20020304191942.M20606@dualathlon.random>
In-Reply-To: <Pine.LNX.4.44L.0203041116120.2181-100000@imladris.surriel.com> <190330000.1015261149@flay>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <190330000.1015261149@flay>
User-Agent: Mutt/1.3.22.1i
X-GnuPG-Key-URL: http://e-mind.com/~andrea/aa.gnupg.asc
X-PGP-Key-URL: http://e-mind.com/~andrea/aa.asc
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 04, 2002 at 08:59:10AM -0800, Martin J. Bligh wrote:
> > Not stability per se, but you have to admit the VM tends to
> > behave badly when there's a shortage in just one memory zone.
> > I believe NUMA will only make this situation worse.
> 
> rmap would seem to buy us (at least) two major things for NUMA:
> 
> 1) We can balance between zones easier by "swapping out"
> pages to another zone.

Yes, operations like "now migrate and bind this task to a certain
cpu/mem pair" pretty much needs rmap or it will get the same complexity
of swapout, that may be very very slow with lots of vm address space
mapped. But this has nothing to do with the swap_out pass we were
talking about previously.

I just considered those cases (like also supporting pagetable sharing at the
maximum possible levels also across random
mmaps/mremaps/mprotect/mlocks/execve), and this is why I said rmap may
be more useful for mm internals, rather than replacing the swap_out pass
(hmm in this case the migration of the pagecache may be considered more
a vm thing too though).

> 2) We can do local per-node scanning - no need to bounce
> information to and fro across the interconnect just to see what's
> worth swapping out.

the lru lists are global at the moment, so for the normal swapout
activitiy rmap won't allow you to do what you mention above (furthmore
rmap gives you only the pointer to the pte chain, but there's no
guarantee the pte is in the same node as the physical page, even
assuming we'll have per-node inactive/active list, so you'll fall into
the bouncing scenario anyways rmap or not, only the cpu usage will be
lower and as side effect you'll bounce less, but you're not avoiding the
interconnet overhead with the per-node scanning).

Said that I definitely agree the potential pageout/swapout scalability
with rmap may be better on a very huge system with several hundred
gigabytes of ram (despite the accessed bit aging will be less fair
etc..).  So yes, I also of course agree that there will be benefits in
killing the swap_out loop on some currently-corner case hardware, and
maybe long term, if we'll ever need to pageout heavily on a 256G ram
box, it may be the only sane way to do that really no matter if it's
numa or not, (I think on a 256G box it will be only a matter of paging
out the dirty shared mappings and dropping the clean mappings, I don't
see any need to swapout there, but still to do the pageout efficiently
on such kind of machine we'll need rmap).

Also note that on the modern numa (the thing I mostly care about)
in misc load (like a desktop), without special usages (like user
bindings), striping virtual pages and pagecache over all the nodes will
be better than restricting one task to use only the bandwith of one bank
of ram, so decreasing significantly the potential bandwith of the global
machine.  Interconnects are much faster than what ram will ever provide,
it's not the legacy dinousaur numa. I understand old hardware with huge
penalty while crossing the interconnects has different needs though.
They're both called cc-numa but they're completly different beasts. So I
don't worry much about walking on ptes on remote nodes, it may be infact
faster than walking on ptes of the same node, and usually the dinosaurs
have so much ram that they will hardly need to swapout heavily. On
similar lines the alpha cpus (despite I'd put it in the "new numa"
class) doesn't even provide the accessed bit in the pte, you only can
use minor page faults to know that.

The numa point for the new hardware is that if we have N nodes, and
we have apps loading at 100% each node and using 100% of mem bandwith
from each node in a local manner without passing through the
interconnects (like we can do with cpu bindings and migration+bind API)
then the performance will be better than if we stripe globally, and this
is why the OS needs to be aware about numa, to optimize those cases, so
if you've a certain workload you can get the 100% of the performance out
of the hardware, but on a misc load without a dedicated-design for the
machine where it is running on (so if we're not able to use all the 4
nodes fully in a local manner) striping will be better (so you'll get a
2/3 of performance out of the hardware, rather than a 1/4 of performance
of it because you're only using 1/4 of the global bandwith). Same goes
for shm and pagecache, page (or cacheline) striping is better there too.
note: the above numbers I invented them to make the example more clear,
they've no relation to any existing real hardware at all.

> I suspect that the performance of NUMA under memory pressure
> without the rmap stuff will be truly horrific, as we decend into 
> a cache-trashing page transfer war. 

depends on what kind of numa systems I think. I worry more about the
complexity with lots of ram. As said above on a 64bit 512G system
with hundred gigabytes of vm globally mapped at the same time, paging
out hard beacuse of some terabyte mapping marked dirty during page
faults, will quite certainly need rmap to pageout such dirty mappings
efficiently, really no matter if it's cc-numa or not, it's mostly a
complexity problem.

I really don't see it as a 2.4 need :). I never said no-way rmap in 2.5.
It maybe I won't agree on the implementation, but on the design I can
agree: if we'll ever need to get the above workloads fast and pagecache
migration for the numa bindings, we'll definitely need rmap for all kind
of user pages, not just for map shared pages, like we have just now in
2.4 and in all previous kernels (I hope this also answers Daniel's
question, otherwise please ask again). So I appreciate the work done on
rmap, but I currently don't see it as a 2.4 item.

> I can't see any way to fix this without some sort of rmap - any
> other suggestions as to how this might be done?
> 
> Thanks,
> 
> Martin.


Andrea
