Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277267AbRJDXoM>; Thu, 4 Oct 2001 19:44:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277268AbRJDXoD>; Thu, 4 Oct 2001 19:44:03 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:12505 "EHLO
	e32.bld.us.ibm.com") by vger.kernel.org with ESMTP
	id <S277267AbRJDXnq>; Thu, 4 Oct 2001 19:43:46 -0400
Date: Thu, 04 Oct 2001 16:39:41 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: landley@trommello.org, Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA & classzones (was Whining about 2.5)
Message-ID: <1486201309.1002213581@mbligh.des.sequent.com>
In-Reply-To: <01100318274901.00728@localhost.localdomain>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'll preface this by saying I know a little about the IBM NUMA-Q 
(aka Sequent) hardware, but not very much about VM (or anyone 
else's NUMA hardware).

>> Classzones used to be a superset of the memory zones, so
>> if you have memory zones A, B and C you'd have classzone
>> Ac consisting of memory zone A, classzone Bc = {A + B}
>> and Cc = {A + B + C}.
> 
> Ah.  Cumulative zones.  A class being a collection of zones, the class-zone 
> patch.  Right.  That makes a lot more sense...
> 
>> This gives obvious problems for NUMA, suppose you have 4
>> nodes with zones 1A, 1B, 1C, 2A, 2B, 2C, 3A, 3B, 3C, 4A,
>> 4B and 4C. 
> 
> Is there really a NUMA machine out there where you can DMA out of another 
> node's 16 bit ISA space?  So far the differences in the zones seem to be 

If I understand your question (and my hardware) correctly, then yes. I think
we (IBM NUMA-Q) can DMA from anywhere to anywhere (using PCI cards, 
not ISA, but we could still use the ISA DMA zone). 

But it probably doesn't make sense to define A,B, and C for each node. For 
a  start, we don't use ISA DMA (and probably no other NUMA box does either). 
If HIGHMEM is the stuff above 900Mb or so (and assuming for a moment
that we have 1Gb per node), then we probably don't need NORMAL+HIGHMEM
for each node either.

0-900Mb = NORMAL (1A)
900-1Gb = HIGHMEM_NODE1 (1B)
1G-2Gb = HIGHMEM_NODE2 (2)
2G-3Gb = HIGHMEM_NODE3 (3)
3Gb-4Gb = HIGHMEM_NODE4 (4)

If we have less than 1Gb per node, then one of the other nodes will have 2 
zones - whichever contains the transition point from NORMAL-> HIGHMEM.
Thus number of zones = number of nodes + 1.
(to my mind, if we're frigging with the zone patterns for NUMA, getting rid of 
DMA zone probably isn't too hard).

If I were allowed to define classzones as a per-processor concept (and I 
don't know enough about VM to know if that's possible), it would seem to
fit nicely. Taking the map above, the classzones for a processor on node 3
would be:

{3} , {1A + 1B + 2+ 3 + 4}

> Especially since, discounting straightforward memory access latency 
> variations, it SEEMS like this is largely a driver question.  Device X can 
> DMA to/from these zones of memory.  The memory isn't different to the 
> processors, it's different to the various DEVICES.  So it's not just a 
> processor question, but an association between processors, memory, and 
> devices.  (Back to the concept of nodes.)  Meaning drivers could be supplying 
> zone lists, which is just going to be LOADS of fun...

If possible, I'd like to avoid making every single driver NUMA aware. Partly
because I'm lazy, but also because I think it can be simpler than this. The
mem subsystem should just be able to allocate something that's as good
as possible for that card, without the driver worrying explicitly about zones
(though it may have to specify if it can do 32/64 bit DMA).

see http://lse.sourceforge.net/numa - there should be some NUMA API
proposals there for explicit stuff.
 
> <uninformed rant>
> 
> I thought a minimalistic approach to numa optimization was to think in terms 
> of nodes, and treat each node as one or more processors with a set of 
> associated "cheap" resources (memory, peripherals, etc).  Multiple tiers of 
> decreasing locality for each node sounds like a lot of effort for a first 
> attempt at NUMA support.  That's where the "hideously difficult to calculate" 
> bits come in.  A problem with could increase exponentially with the number of 
> nodes...

Going back to the memory map above, say that node 1-2 are tightly coupled,
and 3-4 are tighly coupled, but 1-3, 1-4, 2-3, 2-4 are loosely coupled. This gives
us a possible heirarchical NUMA situation. So now the classzones for procs
on node 3 would be:

{3} , {3+4}, {1A + 1B + 2+ 3 + 4}

which would make heirarchical NUMA easy enough.

> I always think of numa as the middle of a continuum.  Zillion-way SMP with 
> enormous L1 caches on each processor starts acting a bit like NUMA (you don't 
> wanna go out of cache and fight the big evil memory bus if you can at all 
> avoid it, and we're already worrying about process locality (processor 
> affinity) to preserve cache state...).  

Kind of, except you can explicitly specify which bits of memory you want to
use, rather than the hardware working it out for you.

> Shared memory beowulf clusters that 
> page fault through the network with a relatively low-latency interconnect 
> like myrinet would act a bit like NUMA too.  

Yes.  

> (Obviously, I haven't played 
> with the monster SGI hardware or the high-end stuff IBM's so proud of.)

There's a 16-way NUMA (4x4) at OSDL (www.osdlab.org) that's running
linux and available for anyone to play with, if you're so inclined. It doesn't
understand very much of it's NUMA-ness, but it works. This is the IBM
NUMA-Q hardware ... I presume that's what you're referring to).

> In a way, swap space on the drives could be considered a 
> performance-delimited physical memory zone.  One the processor can't access 
> directly, which involves the allocation of DRAM bounce buffers.  Between that 
> and actual bounce buffers we ALREADY handle problems a lot like page 
> migration between zones (albeit not in a generic, unified way)...

I don't think it's quite that simple. For swap, you always want to page stuff
back in before using it. For NUMA memory on remote nodes, it may or may
not be worth migrating the page. If we chose to migrate a process between
nodes, we could indeed set up a system where we'd page fault pages in from
the remote node as we used them, or we could just migrate the working set
with the process.

Incidentally, swapping on NUMA will need per-zone swapping even more,
so I don't see how we could do anything sensible for this without a physical
to virtual mem map. But maybe someone knows how.
 
> So I thought the cheap and easy way out is to have each node know what 
> resources it considers "local", what resources are a pain to access (possibly 
> involving a tasklet on annother node), and a way to determine when tasks 
> requiring a lot of access to them might better to be migrated directly to a 
> node where they're significantly cheaper to the point where the cost of 
> migration gets paid back.  This struck me as the 90% "duct tape" solution to 
> NUMA. 

Pretty much. I don't know of any situation when we need a tasklet on another
node - that's a pretty horrible thing to have to do.
 
> So what hardware inherently requires a multi-tier NUMA approach beyond "local 
> stuff" and "everything else"?  (I suppose there's bound to be some linearlly 
> arranged system with a long gradual increase in memory access latency as you 
> go down the row, and of course a node in the middle which has a unique 
> resource everybody's fighting for.  Is this a common setup in NUMA systems?)

The next generation of hardware/chips will have more heirarchical stuff.
The shorter / smaller a bus is, the faster it can go, so we can tightly couple
small sets faster than big sets.

> And then, of course, there's the whole question of 3D accelerated video card 
> texture memory, and trying to stick THAT into a zone. :)  (Eew!  Eew!  Eew!)  
> Yeah, it IS a can of worms, isn't it?

Your big powerful NUMA server is going to be used to play Quake on? ;-)
Same issue for net cards, etc though I guess. 

> But class/zone lists still seem fine for processors.  It's just a question of 
> doing the detective work for memory allocation up front, as it were.  If you 
> can't figure it out up front, how the heck are you supposed to do it 
> efficiently at allocation time?

If I understand what you mean correctly, we should be able to lay out
the topology at boot time, and work out which phys mem locations will
be faster / slower from any given resource (proc, PCI, etc). 

> This 
> chunk of physical memory can be used as DMA buffers for this PCI bridge, 
> which can only be addressed directly by this group of processors anyway 
> because they share the IO-APIC it's wired to...  

Hmmm ... at least in the hardware I'm familiar with, we can access any PCI
bridge or any IO-APIC from any processor. Slower, but functional.

> Um, can bounce buffers permanent page migration to another zone?  (Since we 
> have to allocate the page ANYWAY, might as well leave it there till it's 
> evicted, unless of course we're very likely to evict it again pronto in which 
> case we want to avoid bouncing it back...  

As I understand zones, they're physical, therefore pages don't migrate 
between them. The data might be copied from the bounce buffer to a
page in another zone, but  ... 

Not sure if we're using quite the same terminology. Feel free to correct me.

> Hmmm...  Then under NUMA there 
> would be the "processor X can't access page in new location easily to fill it 
> with new data to DMA out..."  Fun fun fun...)

On the machines I'm used to, there's no problem with "can't access", just
slower or faster.

> Since 2.4 isn't supposed to handle NUMA anyway, I don't see what difference 
> it makes.  Just use ANYTHING that stops the swap storms, lockups, zone 
> starvation, zero order allocation failures, bounce buffer shortages, and 
> other such fun we were having a few versions back.  (Once again, this part 
> now seems to be in the "it works for me"(tm) stage.)
> 
> Then rip it out and start over in 2.5 if there's stuff it can't do.

I'm not convinced that changing directions all the time is the most
efficient way to operate - it would be nice to keep building on work
already done in 2.4 (on whatever subsystem that is) rather than rework
it all, but maybe that'll happen anyway, so ....

Martin.

