Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277320AbRJEGhN>; Fri, 5 Oct 2001 02:37:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277321AbRJEGhG>; Fri, 5 Oct 2001 02:37:06 -0400
Received: from femail20.sdc1.sfba.home.com ([24.0.95.129]:43411 "EHLO
	femail20.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277320AbRJEGgr>; Fri, 5 Oct 2001 02:36:47 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>, landley@trommello.org,
        Rik van Riel <riel@conectiva.com.br>
Subject: Re: NUMA & classzones (was Whining about 2.5)
Date: Thu, 4 Oct 2001 19:55:25 -0400
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <1486201309.1002213581@mbligh.des.sequent.com>
In-Reply-To: <1486201309.1002213581@mbligh.des.sequent.com>
MIME-Version: 1.0
Message-Id: <01100419552504.02393@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 04 October 2001 19:39, Martin J. Bligh wrote:
> I'll preface this by saying I know a little about the IBM NUMA-Q
> (aka Sequent) hardware, but not very much about VM (or anyone
> else's NUMA hardware).

I saw the IBM guys in Austin give a talk on it last year, which A) had more 
handwaving that star wars episode zero, B) had FAR more info about politics 
in the AIX division than about NUMA, C) involved the main presenter letting 
us know he was leaving IBM at the end of the week...

Kind of like getting details about CORBA out of IBM.  And I worked there when 
i was trying to do that.  (I was once in charge of implementing corba 
compliance for a project, and all they could find me to define it at the time 
was a marketing brochure.  Sigh...)

> >> This gives obvious problems for NUMA, suppose you have 4
> >> nodes with zones 1A, 1B, 1C, 2A, 2B, 2C, 3A, 3B, 3C, 4A,
> >> 4B and 4C.
> >
> > Is there really a NUMA machine out there where you can DMA out of another
> > node's 16 bit ISA space?  So far the differences in the zones seem to be
>
> If I understand your question (and my hardware) correctly, then yes. I
> think we (IBM NUMA-Q) can DMA from anywhere to anywhere (using PCI cards,
> not ISA, but we could still use the ISA DMA zone).

Somebody made a NUMA machine with an ISA bus?  Wow.  That's peverse.  I'm 
impressed.  (It was more a "when do we care" question...)

Two points:

1) If you can DMA from anywhere to anywhere, it's one big zone, isn't it?  
Where does the NUMA come in?  (I guess it's more expensive to DMA between 
certain devices/memory pages?  Or are we talking sheer processor access 
latency here, nothing to do with devices at all...?)

2) A processor-centric view of memory zones is not the whole story.  Look at 
the zones we have now.  The difference between the ISA zone, the PCI zone, 
and high memory has nothing to do with the processor*.  It's a question of 
which devices (which bus/bridge really) can talk to which pages.  In current 
UP/SMP systems, the processor can talk to all of them pretty much equally.

* modulo the intel 36 bit extension stuff, which I must admit I haven't 
looked closely at.  Don't have the hardware.  Then again that's sort of the 
traditional numa problem of "some memory is a bit funky for the processor to 
access".  Obviously I'm not saying I/O is the ONLY potential difference 
between memory zones...

So we need zones defined relative not just to processors (or groups of 
processors that have identical access profiles), but also defined relative to 
i/o devices and busses.  Meaning zones may become a driver issue.

This gets us back to the concept of "nodes".  Groups of processors and 
devices that collectively have a similar view of the world, memory-wise.  Is 
this a view of the problem that current NUMA thinking is using, or not?

> But it probably doesn't make sense to define A,B, and C for each node. For
> a  start, we don't use ISA DMA (and probably no other NUMA box does
> either). If HIGHMEM is the stuff above 900Mb or so (and assuming for a
> moment that we have 1Gb per node), then we probably don't need
> NORMAL+HIGHMEM for each node either.
>
> 0-900Mb = NORMAL (1A)
> 900-1Gb = HIGHMEM_NODE1 (1B)
> 1G-2Gb = HIGHMEM_NODE2 (2)
> 2G-3Gb = HIGHMEM_NODE3 (3)
> 3Gb-4Gb = HIGHMEM_NODE4 (4)

By highmem you mean memory our I/O devices can't DMA out of?

Will all the I/O devices in the system share a single pool of buffer memory, 
or will devices be attached to nodes?

(My thinking still turns to making shared memory beowulf clusters act like 
one big system.  The hardware for that will continue to be cheap: rackmount a 
few tyan thunder dual athlon boards.  You can distribute drives for storage 
and swap space (even RAID them if you like), and who says such a cluster has 
to put all external access through a single node?

> If we have less than 1Gb per node, then one of the other nodes will have 2
> zones - whichever contains the transition point from NORMAL-> HIGHMEM.

So "normal" belongs to a specific node, so all devices basically belong to 
that node?

> Thus number of zones = number of nodes + 1.
> (to my mind, if we're frigging with the zone patterns for NUMA, getting rid
> of DMA zone probably isn't too hard).

You still have the problem of doing DMA.  Now this is a seperable problem 
boiling down to either allocation and locking of DMAable buffers the 
processor can directly access, or setting up bounce buffers when the actual 
I/O is kicked off.  (Or doing memory mapped I/O, or PIO.  But all that is 
still a bit like one big black box, I'd think.  And to do it right, you need 
to know which device you're doing I/O to, because I really wouldn't assume 
every I/O device on the system shares the same pool of DMAable memory.  Or 
that we haven't got stuff like graphics cards that have their own RAM we map 
into our address space.  Or, for that matter, that physical memory mapping in 
one node makes anything directly accessable from another node.)

> If I were allowed to define classzones as a per-processor concept (and I
> don't know enough about VM to know if that's possible), it would seem to
> fit nicely. Taking the map above, the classzones for a processor on node 3
> would be:
>
> {3} , {1A + 1B + 2+ 3 + 4}


Not just per processor.  Think about a rackmount shared memory beowulf 
system, page faulting through the network.  With quad-processor boards in 
each 1U, and BLAZINGLY FAST interconnects in the cluster.  Now teach that to 
act like NUMA.

Each 1U has four processors with identical performance (and probably one set 
of page tables if they share a northbridge).  Assembling NUMA systems out of 
closely interconnected SMP systems.

> If possible, I'd like to avoid making every single driver NUMA aware.

It may not be a driver issue.  It may be a bus issue.  If there are two PCI 
busses in the system, do they HAVE to share one set of physical memory 
mappings?  (NUMA sort of implies we have more than one northbridge.  Dontcha 
think we might have more than one southbridge, too?)

> Partly because I'm lazy, but also because I think it can be simpler than
> this. The mem subsystem should just be able to allocate something that's as
> good as possible for that card, without the driver worrying explicitly
> about zones (though it may have to specify if it can do 32/64 bit DMA).

It's not just 32/64 bit DMA.  You're assuming every I/O device in the system 
is talking to exactly the same pool of memory.  The core assumption of NUMA 
is that the processors aren't doing that, so I don't know why the I/O devices 
necessarily should.  (Maybe they do, what do I know.  It would be nice to 
hear from somebody with actual information...)

And if they ARE all talking to one pool of memory, than the whole NUMA 
question becomes a bit easier, actually...  The flood of zones we were so 
worried about (Node 18's processor sending packets through a network card 
living on node 13) can't really happen, can it?

> see http://lse.sourceforge.net/numa - there should be some NUMA API
> proposals there for explicit stuff.

Thanks for the link. :)

> > I always think of numa as the middle of a continuum.  Zillion-way SMP
> > with enormous L1 caches on each processor starts acting a bit like NUMA
> > (you don't wanna go out of cache and fight the big evil memory bus if you
> > can at all avoid it, and we're already worrying about process locality
> > (processor affinity) to preserve cache state...).
>
> Kind of, except you can explicitly specify which bits of memory you want to
> use, rather than the hardware working it out for you.

Ummm...

Is the memory bus somehow physically reconfiguring itself to make some chunk 
of memory lower or higher latency when talking to a given processor?  I'm 
confused...

> > Shared memory beowulf clusters that
> > page fault through the network with a relatively low-latency interconnect
> > like myrinet would act a bit like NUMA too.
>
> Yes.

But that's the bit that CLEARLY works in terms of nodes, and also which has 
devices attached to different nodes, requiring things like remote tasklets to 
access remote devices, and page migration between nodes to do repeated access 
on remote pages.  (Not that this is much different than sending a page back 
and forth between processor caches in SMP.  Hence the continuum I was talking 
about...)

The multiplicative complexity I've heard fears about on this list seems to 
stem from an interaction between "I/O zones" and "processor access zones" 
creating an exponential number of gradations when the two qualities apply to 
the same page.  But in a node setup, you don't have to worry about it.  A 
node has its local memory, and it's local I/O, and it inflicts work on remote 
zones when it needs to deal with their resources.  There may be one big 
shared pool of I/O memory or some such (IBM's NUMA-Q), but in that case it's 
the same for all processors.  Each node has one local pool, one remote pool, 
and can just talk to a remote node when it needs to (about like SMP).

I THOUGHT numa had a gradient, of "local, not as local, not very local at 
all, darn expensive" pages that differed from node to node, which would be a 
major pain to optimize for yes.  (I was thinking motherboard trace length and 
relaying stuff several hops down a bus...)  But I haven't seen it yet.  And 
even so, "not local=remote" seems to cover the majority of the cases without 
exponential complexity...

I am still highly confused.

> > (Obviously, I haven't played
> > with the monster SGI hardware or the high-end stuff IBM's so proud of.)
>
> There's a 16-way NUMA (4x4) at OSDL (www.osdlab.org) that's running
> linux and available for anyone to play with, if you're so inclined. It
> doesn't understand very much of it's NUMA-ness, but it works. This is the
> IBM NUMA-Q hardware ... I presume that's what you're referring to).

That's what I've heard the most about.  I'm also under the impression that 
SGI was working on NUMA stuff up around the origin line, and that sun had 
some monsters in the works as well...

It still seems to me that either clustering or zillion-way SMP is the most 
interesting area of future supercomputing, though.  Sheer price to 
performance.  For stuff that's not very easily seperable into chunks, they've 
got 64 way SMP working in the lab.  For stuff that IS chunkable, thousand box 
clusters are getting common.  If the interconnects between boxes are a 
bottleneck, 10gigE is supposed to be out in late 2003, last I heard, meaning 
gigE will get cheap...  And for just about everything else, there's Moore's 
Law...

Think about big fast-interconnect shared memory clusters.  Resources are 
either local or remote through the network, you don't care too much about 
gradients.  So the "symmetrical" part of SMP applies to decisions between 
nodes.  There's another layer of decisions in that a node may be an SMP box 
in and of itself (probably will), but there's only really two layers to worry 
about, not an exponential amount of complexity where each node has a 
potentially unique relationship with every other node...

People wanting to run straightforward multithreaded programs using shared 
memory and semaphores on big clusters strikes me as an understandable goal, 
and the drive for fast (low latency) interconnects to make that feasible is 
something I can see a good bang for the buck coming out of.  Here's the 
hardware that's widely/easily/cheaply available, here's what programmers want 
to do with it.  I can see that.

The drive to support monster mainframes which are not only 1% of the market 
but which get totally redesigned every three or four years to stay ahead of 
moore's law...  I'm not quite sure what's up there.  How much of the market 
can throw that kind of money to constantly offset massive depreciation?

Is the commodity hardware world going to inherit NUMA (via department level 
shared memory beowulf clusters, or just plain the hardware to do it getting 
cheap enough), or will it remain a niche application?

As I said: master of stupid questions.  The answers are taking a bit more 
time...

> > In a way, swap space on the drives could be considered a
> > performance-delimited physical memory zone.  One the processor can't
> > access directly, which involves the allocation of DRAM bounce buffers. 
> > Between that and actual bounce buffers we ALREADY handle problems a lot
> > like page migration between zones (albeit not in a generic, unified
> > way)...
>
> I don't think it's quite that simple. For swap, you always want to page
> stuff back in before using it. For NUMA memory on remote nodes, it may or
> may not be worth migrating the page.

Bounce buffers.  This is new?  Seems like the same locking issues, even...

> If we chose to migrate a process
> between nodes, we could indeed set up a system where we'd page fault pages
> in from the remote node as we used them, or we could just migrate the
> working set with the process.

Yup.  This is a problem I've heard discussed a lot: deciding when to migrate 
resources.  (Pages, processes, etc.)  It also seems to be a seperate layer of 
the problem, one that isn't too closely tied to the initial allocation 
strategy (although it may feed back into it, but really that seems to be just 
free/alloc and maybe adjusting weighting/ageing whatever.  Am I wrong?)

I.E. migration strategy and allocation strategy aren't necessarily the same 
thing...

> Incidentally, swapping on NUMA will need per-zone swapping even more,
> so I don't see how we could do anything sensible for this without a
> physical to virtual mem map. But maybe someone knows how.

There you got me.  I DO know that you can have multiple virtual mappings for 
each physical page, so it's not as easy as the other way around, but this 
could be why the linked list was invented...

(I believe Rik is working on patches that cover this bit.  Haven't looked at 
them yet.)

> > So I thought the cheap and easy way out is to have each node know what
> > resources it considers "local", what resources are a pain to access
> > (possibly involving a tasklet on annother node), and a way to determine
> > when tasks requiring a lot of access to them might better to be migrated
> > directly to a node where they're significantly cheaper to the point where
> > the cost of migration gets paid back.  This struck me as the 90% "duct
> > tape" solution to NUMA.
>
> Pretty much. I don't know of any situation when we need a tasklet on
> another node - that's a pretty horrible thing to have to do.

Think shared memory beowulf.

My node has a hard drive.  Some other node wants to read and write to my hard 
drive, because it's part of a larger global file system or storage area 
network or some such.

My node has a network card.  There are three different connections to the 
internet, and they're on seperate nodes to avoid single point of failure 
syndrome.

My node has a video capture card.  The cluster as a whole is doing realtime 
video acquisition and streaming for a cable company that saw the light and 
switched over to MP4 with a big storage cluster.  Incoming signals from cable 
(or movies fed into the system for pay per view) get converted to mp4 
(processor intensive, cluster needed to keep up with HDTV, especially 
multiple channels) and saved in the storage area network part, and subscriber 
channels get fetched and fed back out.  (Probably not as video, probably as a 
TCP/IP stream to a set top box.  The REAL beauty of digital video isn't 
trying to do "moves on demand", it's having a cluster stuffed with old 
episodes of Mash, ER, The West Wing, Star Trek, The Incredible Hulk, Dark 
Shadows, and Dr. Who which you can call up and play at will.  Syndicated 
content on demand.  EASY task for a cluster to do.  Doesn't NEED to think 
NUMA, that could be programmed as beowulf.  But we could also be using the 
Mach microkernel on SMP boxes, it makes about as much sense.  Beowulf is 
message passing, microkernels are message passing, CORBA is message 
passing...  Get fast interconnects, message passing becomes less and less of 
a good idea...)

> > So what hardware inherently requires a multi-tier NUMA approach beyond
> > "local stuff" and "everything else"?  (I suppose there's bound to be some
> > linearlly arranged system with a long gradual increase in memory access
> > latency as you go down the row, and of course a node in the middle which
> > has a unique resource everybody's fighting for.  Is this a common setup
> > in NUMA systems?)
>
> The next generation of hardware/chips will have more heirarchical stuff.
> The shorter / smaller a bus is, the faster it can go, so we can tightly
> couple small sets faster than big sets.

Sure.  This is electronics 101, the speed of light is not your friend.  
(Intel fought and lost this battle with the pentium 4's pipeline, more haste 
less speed...)

But the question of how much of a gradient we care about remains.  It's 
either local, or it's not local.

The question is latency, not throughput.  (Rambus did this too, more 
throughput less latency...)  Lots of things use loops in an attempt to get 
fixed latency: stuff wanders by at known intervals so it's easy to fill up 
slots on the bus because you know when your slot will be coming by...

NUMA is also a question of latency.  Gimme high end fiber stuff and I could 
have a multi-gigabit pipe between two machines in different buildings.  
Latency will still make it a less fun to try to page access DRAM through than 
your local memory bus, regardless of relative throughput.

> > And then, of course, there's the whole question of 3D accelerated video
> > card texture memory, and trying to stick THAT into a zone. :)  (Eew! 
> > Eew!  Eew!) Yeah, it IS a can of worms, isn't it?
>
> Your big powerful NUMA server is going to be used to play Quake on? ;-)
> Same issue for net cards, etc though I guess.

Not quake, video capture and streaming.  Big market there, which beowulf 
clusters can address today, but in a fairly clumsy way.  (The sane way to 
program that is to have one node dispatching/accepting frames to other nodes, 
so beowulf isn't so bad.  But message passing is not a way to control 
latency, and latency is your real problem when you want to avoid droppping 
frames.  Buffering helps this, though.  Five seconds of buffer space covers a 
multitude of sins...)

> > But class/zone lists still seem fine for processors.  It's just a
> > question of doing the detective work for memory allocation up front, as
> > it were.  If you can't figure it out up front, how the heck are you
> > supposed to do it efficiently at allocation time?
>
> If I understand what you mean correctly, we should be able to lay out
> the topology at boot time, and work out which phys mem locations will
> be faster / slower from any given resource (proc, PCI, etc).

Ask andrea.  I THINK so, but I'm not the expert.  (And Linus seems to 
disagree, and he tends to have good reasons. :)

> > This
> > chunk of physical memory can be used as DMA buffers for this PCI bridge,
> > which can only be addressed directly by this group of processors anyway
> > because they share the IO-APIC it's wired to...
>
> Hmmm ... at least in the hardware I'm familiar with, we can access any PCI
> bridge or any IO-APIC from any processor. Slower, but functional.

Is the speed difference along a noticeably long gradient, or more "this group 
is fast, the rest is not so fast"?

And do the bridges and IO-APICS cluster with processors into something that 
looks like nodes, or do they overlap in a less well defined way?

> > Um, can bounce buffers permanent page migration to another zone?  (Since
> > we have to allocate the page ANYWAY, might as well leave it there till
> > it's evicted, unless of course we're very likely to evict it again pronto
> > in which case we want to avoid bouncing it back...
>
> As I understand zones, they're physical, therefore pages don't migrate
> between them.

And processors are physical, so tasks don't migrate between them?

> The data might be copied from the bounce buffer to a
> page in another zone, but  ...

Virtual page, physical page...

> Not sure if we're using quite the same terminology. Feel free to correct
> me.

I'm more likely to receive correction.  I'm trying to learn and understand 
the problem...

> > Hmmm...  Then under NUMA there
> > would be the "processor X can't access page in new location easily to
> > fill it with new data to DMA out..."  Fun fun fun...)
>
> On the machines I'm used to, there's no problem with "can't access", just
> slower or faster.

Well, with shared memory beowulf clusters you could have a tasklet on the 
other machine lock the page and spit you a copy of the data, so "can't" 
doesn't work there either.  That's where the word "easily" came in...

But an attempt to DMA into or out of that page from another node would 
involve bounce buffers on the other node...

> > Since 2.4 isn't supposed to handle NUMA anyway, I don't see what
> > difference it makes.  Just use ANYTHING that stops the swap storms,
> > lockups, zone starvation, zero order allocation failures, bounce buffer
> > shortages, and other such fun we were having a few versions back.  (Once
> > again, this part now seems to be in the "it works for me"(tm) stage.)
> >
> > Then rip it out and start over in 2.5 if there's stuff it can't do.
>
> I'm not convinced that changing directions all the time is the most
> efficient way to operate

No comment on the 2.4.0-2.4.10 VM development process will be made by me at 
this time.

> - it would be nice to keep building on work
> already done in 2.4 (on whatever subsystem that is) rather than rework
> it all, but maybe that'll happen anyway, so ....

At one point I thought the purpose of a stable series was to stabilize, 
debug, and tweak what you'd already done, and architectural changes went in 
development series.  (Except for the occasional new driver.)  As I said, I 
tend to be wrong about stuff...

> Martin.

Rob
