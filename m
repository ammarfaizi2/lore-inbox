Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274863AbRJFBpE>; Fri, 5 Oct 2001 21:45:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274850AbRJFBoz>; Fri, 5 Oct 2001 21:44:55 -0400
Received: from rj.sgi.com ([204.94.215.100]:55459 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S274842AbRJFBoi>;
	Fri, 5 Oct 2001 21:44:38 -0400
Date: Fri, 5 Oct 2001 18:44:02 -0700
From: Jesse Barnes <jbarnes@sgi.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA & classzones (was Whining about 2.5)
In-Reply-To: <01100419552504.02393@localhost.localdomain>
Message-ID: <Pine.SGI.4.21.0110051807510.999395-100000@spamtin.engr.sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: unlisted-recipients:; (no To-header on input)@localhost.localdomain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are some long messages... I'll do my best to reply w/respect to SGI
boxes.  Maybe it's time I got it together and put one of our NUMA machines
on the 'net.  A little background first though, for those that aren't
familiar with our NUMA arch.  All this info should be available at
http://techpubs.sgi.com I think, but I'll briefly go over it here.

Our newest systems are made of 'bricks'.  There are a few different types
of brick: c, r, i, p, d, etc.  C-bricks are simply a collection of 0-4
cpus and some amount of memory.  R-bricks are simply a collection of
NUMAlink ports.  I-bricks have a few PCI busses and a couple of disks.  
P-bricks have a bunch of PCI busses, and D-bricks have a bunch of disks.  
Each brick has at least one IO port, C-bricks also have a NUMAlink port
that can be connected to other C-bricks or R-bricks.  So remote memory
accesses have to go out a NUMAlink to an R-brick and in through another
NUMAlink on another C-brick on all but the smallest systems.  P, and I
bricks are connected directly to C-bricks, while D-bricks are connected
via fibrechannel to SCSI cards on either P or I bricks.

On Thu, 4 Oct 2001, Rob Landley wrote:
> Somebody made a NUMA machine with an ISA bus?  Wow.  That's peverse.  I'm 
> impressed.  (It was more a "when do we care" question...)

I certainly hope not!!  It's bad enough that people have Pentium NUMA
machines; I don't envy the people that had to bring those up.
 
> Two points:
> 
> 1) If you can DMA from anywhere to anywhere, it's one big zone, isn't it?  
> Where does the NUMA come in?  (I guess it's more expensive to DMA between 
> certain devices/memory pages?  Or are we talking sheer processor access 
> latency here, nothing to do with devices at all...?)

On SGI, yes.  We've got both MIPS and IPF (formerly known as IA64) NUMA
machines.  Since both are 64 bit, things are much easier than with say, a
Pentium.  PCI cards that are 64 bit DMA capable can read/write any memory
location on the machine.  32 bit cards can as well, with the help of our
PCI bridge.  Ideally though, you'd like to DMA to/from devices that are
directly connected to the memory on their associated C-brick, otherwise
you've got to hop over other nodes to get to your memory (=higher latency,
possible bandwidth contention).  I hope this answers your question.
 
> 2) A processor-centric view of memory zones is not the whole story.  Look at 
> the zones we have now.  The difference between the ISA zone, the PCI zone, 
> and high memory has nothing to do with the processor*.  It's a question of 
> which devices (which bus/bridge really) can talk to which pages.  In current 
> UP/SMP systems, the processor can talk to all of them pretty much equally.

You can think of all the NUMA systems I know of that way as well, but you
get higher performance if you're careful about which pages you talk to.
 
> So we need zones defined relative not just to processors (or groups of 
> processors that have identical access profiles), but also defined relative to 
> i/o devices and busses.  Meaning zones may become a driver issue.
> 
> This gets us back to the concept of "nodes".  Groups of processors and 
> devices that collectively have a similar view of the world, memory-wise.  Is 
> this a view of the problem that current NUMA thinking is using, or not?

Yup.  We have pg_data_t for just that purpose, although it currently only
has information about memory, not total system topology (i.e. I/O devices,
CPUs, etc.).
 
> > But it probably doesn't make sense to define A,B, and C for each node. For
> > a  start, we don't use ISA DMA (and probably no other NUMA box does
> > either). If HIGHMEM is the stuff above 900Mb or so (and assuming for a
> > moment that we have 1Gb per node), then we probably don't need
> > NORMAL+HIGHMEM for each node either.
> >
> > 0-900Mb = NORMAL (1A)
> > 900-1Gb = HIGHMEM_NODE1 (1B)
> > 1G-2Gb = HIGHMEM_NODE2 (2)
> > 2G-3Gb = HIGHMEM_NODE3 (3)
> > 3Gb-4Gb = HIGHMEM_NODE4 (4)
> 
> By highmem you mean memory our I/O devices can't DMA out of?

On the NUMA-Q platform, probably (but I'm not sure since I've never
worked on one).
 
> Will all the I/O devices in the system share a single pool of buffer memory, 
> or will devices be attached to nodes?

Both.  At least for us.
 
> Not just per processor.  Think about a rackmount shared memory beowulf 
> system, page faulting through the network.  With quad-processor boards in 
> each 1U, and BLAZINGLY FAST interconnects in the cluster.  Now teach that to 
> act like NUMA.

Sounds familiar.  It's much easier when your memory controllers are aware
of this fact though...
 
> It's not just 32/64 bit DMA.  You're assuming every I/O device in the system 
> is talking to exactly the same pool of memory.  The core assumption of NUMA 
> is that the processors aren't doing that, so I don't know why the I/O devices 
> necessarily should.  (Maybe they do, what do I know.  It would be nice to 
> hear from somebody with actual information...)

I think the core assumption is exactly the opposite, but you're correct if
you're talking about simple clusters.
 
> And if they ARE all talking to one pool of memory, than the whole NUMA 
> question becomes a bit easier, actually...  The flood of zones we were so 
> worried about (Node 18's processor sending packets through a network card 
> living on node 13) can't really happen, can it?

I guess it depends on the machine.  On our machine, you could do that, but
it looks like the IBM machine would need bounce buffers for such
things.  You might also need bounce buffers for 32 bit PCI cards for some
machines, since they might only be able to DMA to/from the first 4 GB of
memory.
 
> I THOUGHT numa had a gradient, of "local, not as local, not very local at 
> all, darn expensive" pages that differed from node to node, which would be a

That's pretty much right.  But for most things it's not *too* bad to
optimize for, until you get into *huge* machines (e.g. 1024p, lots of
memory).

> major pain to optimize for yes.  (I was thinking motherboard trace length and 
> relaying stuff several hops down a bus...)  But I haven't seen it yet.  And 
> even so, "not local=remote" seems to cover the majority of the cases without 
> exponential complexity...

Yeah, luckily, you can assume local==remote and things will work, albeit
slowly (ask Ralf about forgetting to turn on CONFIG_NUMA on one of our
MIPS machines).
 
> That's what I've heard the most about.  I'm also under the impression that 
> SGI was working on NUMA stuff up around the origin line, and that sun had 
> some monsters in the works as well...

AFAIK, Sun just has SMP machines, but they might have a NUMA one in the
pipe.  And yes, we've had NUMA stuff for awhile, and recently got a 1024p
system running.  There were some weird bottlenecks exposed by that one.
 
> People wanting to run straightforward multithreaded programs using shared 
> memory and semaphores on big clusters strikes me as an understandable goal, 
> and the drive for fast (low latency) interconnects to make that feasible is 
> something I can see a good bang for the buck coming out of.  Here's the 
> hardware that's widely/easily/cheaply available, here's what programmers want 
> to do with it.  I can see that.
> 
> The drive to support monster mainframes which are not only 1% of the market 
> but which get totally redesigned every three or four years to stay ahead of 
> moore's law...  I'm not quite sure what's up there.  How much of the market 
> can throw that kind of money to constantly offset massive depreciation?
> 
> Is the commodity hardware world going to inherit NUMA (via department level 
> shared memory beowulf clusters, or just plain the hardware to do it getting 
> cheap enough), or will it remain a niche application?

Maybe?

> > Incidentally, swapping on NUMA will need per-zone swapping even more,
> > so I don't see how we could do anything sensible for this without a
> > physical to virtual mem map. But maybe someone knows how.

I know Kanoj was talking about this awhile back; don't know if he ever
came up with any code though...
 
> The question is latency, not throughput.  (Rambus did this too, more 

Bingo!  Latency is absolutely key to NUMA.  If you have really bad
latency, you've basically got a cluster.  The programming model is greatly
simplified though, as you mentioned above (i.e. shared mem multithreading
vs. MPI).

> Is the speed difference along a noticeably long gradient, or more "this group 
> is fast, the rest is not so fast"?

Depends on the machine.  I think IBM's machines have something like a 10:1
ratio of remote vs. local memory access latency, while SGI's latest have
something like 1.5:1.  That's per-hop though, so big machines can be
pretty non-uniform.
 
I hope I've at least refrained from muddying the NUMA waters further with
my ramblings.  I'll keep an eye on subjects with 'NUMA' or 'zone' though,
just so I can be more informed about these things.

Jesse

