Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277424AbRJERqa>; Fri, 5 Oct 2001 13:46:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277472AbRJERqW>; Fri, 5 Oct 2001 13:46:22 -0400
Received: from zeus.kernel.org ([204.152.189.113]:57298 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S277424AbRJERqN>;
	Fri, 5 Oct 2001 13:46:13 -0400
Date: Fri, 05 Oct 2001 10:29:54 -0700
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: landley@trommello.org, Rik van Riel <riel@conectiva.com.br>
cc: linux-kernel@vger.kernel.org
Subject: Re: NUMA & classzones (was Whining about 2.5)
Message-ID: <1550414733.1002277794@mbligh.des.sequent.com>
In-Reply-To: <01100419552504.02393@localhost.localdomain>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> I'll preface this by saying I know a little about the IBM NUMA-Q
>> (aka Sequent) hardware, but not very much about VM (or anyone
>> else's NUMA hardware).
> 
> I saw the IBM guys in Austin give a talk on it last year, which A) had more 
> handwaving that star wars episode zero, B) had FAR more info about politics 
> in the AIX division than about NUMA, C) involved the main presenter letting 
> us know he was leaving IBM at the end of the week...

Oops. I disclaim all knowledge. I gave a brief presentation at OLS. The slides
are somewhere .... but they probably don't make much sense without words.
http://lse.sourceforge.net/numa/mtg.2001.07.25/minutes.html under 
"Porting Linux to NUMA-Q".

> Kind of like getting details about CORBA out of IBM.  And I worked there 
> when i was trying to do that.  (I was once in charge of implementing corba 
> compliance for a project, and all they could find me to define it at the time 
> was a marketing brochure.  Sigh...)

IBM is huge - don't tar us all with the same brush ;-) There are good parts
and bad parts ...

>> >> This gives obvious problems for NUMA, suppose you have 4
>> >> nodes with zones 1A, 1B, 1C, 2A, 2B, 2C, 3A, 3B, 3C, 4A,
>> >> 4B and 4C.
>> > 
>> > Is there really a NUMA machine out there where you can DMA out of another
>> > node's 16 bit ISA space?  So far the differences in the zones seem to be
>> 
>> If I understand your question (and my hardware) correctly, then yes. I
>> think we (IBM NUMA-Q) can DMA from anywhere to anywhere (using PCI cards,
>> not ISA, but we could still use the ISA DMA zone).
> 
> Somebody made a NUMA machine with an ISA bus?  Wow.  That's peverse.  I'm 
> impressed.  (It was more a "when do we care" question...)

No, that's not what I said (though we do have some perverse bus in there ;-))
I said we can dma out of the first physical 16Mb of RAM (known as the ISA DMA
zone on any node into any other node (using a PCI card). Or at least that's what 
I meant ;-)

> Two points:
> 
> 1) If you can DMA from anywhere to anywhere, it's one big zone, isn't it?  
> Where does the NUMA come in?  (I guess it's more expensive to DMA between 
> certain devices/memory pages?  Or are we talking sheer processor access 
> latency here, nothing to do with devices at all...?)

It takes about 10 times longer to DMA or read memory from a remote node's
RAM than the local nodes RAM. It's "Non-uniform" in terms of access speed,
not capability. I don't have latency / bandwidth exact ratios to hand, but it's
in the order of 10:1 on our boxes. 

> 2) A processor-centric view of memory zones is not the whole story.  Look at 
> the zones we have now.  The difference between the ISA zone, the PCI zone, 
> and high memory has nothing to do with the processor*.  

True (for the ISA and PCI). I'd say that the difference between NORMAL and
HIGHMEM has everything to do with the processor. Above 4Gb you're talking
about 36 bit stuff, but HIGHMEM is often just stuff from 900Mb or so to 4Gb.

> It's a question of 
> which devices (which bus/bridge really) can talk to which pages.  In current 
> UP/SMP systems, the processor can talk to all of them pretty much equally.

That's true of the NUMA systems I know too (though maybe not all NUMA
systems).

> So we need zones defined relative not just to processors (or groups of 
> processors that have identical access profiles), but also defined relative to 
> i/o devices and busses.  Meaning zones may become a driver issue.
> 
> This gets us back to the concept of "nodes".  Groups of processors and 
> devices that collectively have a similar view of the world, memory-wise.  Is 
> this a view of the problem that current NUMA thinking is using, or not?

More or less. A node may not internally be symmetric - some processors may
be closer to each other than others. I guess we can redefine the definition
of node at that point to be the more tightly coupled groups of processors, 
but those procs may still have uniform access to the same physical memory,
so the definition gets looser.
 
>> But it probably doesn't make sense to define A,B, and C for each node. For
>> a  start, we don't use ISA DMA (and probably no other NUMA box does
>> either). If HIGHMEM is the stuff above 900Mb or so (and assuming for a
>> moment that we have 1Gb per node), then we probably don't need
>> NORMAL+HIGHMEM for each node either.
>> 
>> 0-900Mb = NORMAL (1A)
>> 900-1Gb = HIGHMEM_NODE1 (1B)
>> 1G-2Gb = HIGHMEM_NODE2 (2)
>> 2G-3Gb = HIGHMEM_NODE3 (3)
>> 3Gb-4Gb = HIGHMEM_NODE4 (4)
> 
> By highmem you mean memory our I/O devices can't DMA out of?

No. I mean stuff that's not permanently mapped to virtual memory (as I
understand it, that's anything over about 900Mb, but then I don't understand
it all that well, so ... ;-) )

> Will all the I/O devices in the system share a single pool of buffer memory, 
> or will devices be attached to nodes?
> 
> (My thinking still turns to making shared memory beowulf clusters act like 
> one big system.  The hardware for that will continue to be cheap: rackmount a 
> few tyan thunder dual athlon boards.  You can distribute drives for storage 
> and swap space (even RAID them if you like), and who says such a cluster has 
> to put all external access through a single node?

In the case of the hardware I know about (and the shared mem beowulf clusters),
you can attach I/O devices to any node (we have 2 PCI buses & 2 I/O APICs
per node). OK, so at the moment the released code only uses the buses on
the first node, but I have code to fix that that's in development (it works, but it's
crude).

What's really nice is to multi-drop connect a SAN using fibre-channel cards to
each and every node (normally 2 cards per node for redundancy). A disk access
on any node then gets routed through the local SAN interface, rather than across
the interconnect. Much faster. Outbound net traffic is the same, inbound is harder.

>> If we have less than 1Gb per node, then one of the other nodes will have 2
>> zones - whichever contains the transition point from NORMAL-> HIGHMEM.
> 
> So "normal" belongs to a specific node, so all devices basically belong to 
> that node?

NORMAL = <900Mb. If I have >900Mb of mem in the first mode, then NORMAL
belongs to that node. There's nothing to stop any device DMAing into things
outside the NORMAL (see Jens' patches to reduce bounce bufferness) zone - 
they use physaddrs - with 32bit PCI, that means the first 4Gb, with 64Gb, pretty
much anywhere. Or at least that's how I understand it until somebody tells me
different.

And no, that doesn't mean that all devices belong to that node. Even if you say
I can only DMA into the normal zone, a device on node 3, with no local memory
in the normal zone just DMAs over the interconnect. And, yes, that takes some
hardware support - that's why NUMA boxes ain't cheap ;-)

> You still have the problem of doing DMA.  Now this is a seperable problem 
> boiling down to either allocation and locking of DMAable buffers the 
> processor can directly access, or setting up bounce buffers when the actual 
> I/O is kicked off.  (Or doing memory mapped I/O, or PIO.  But all that is 
> still a bit like one big black box, I'd think.  And to do it right, you need 
> to know which device you're doing I/O to, because I really wouldn't assume 
> every I/O device on the system shares the same pool of DMAable memory.  Or 

Yes it does (for me at least). To access some things, I take the PCI dev pointer,
work out which bus the PCI card is attatched to, do a bus->node map, and that
gives me the answer.

> that we haven't got stuff like graphics cards that have their own RAM we map 
> into our address space.  Or, for that matter, that physical memory mapping in 
> one node makes anything directly accessable from another node.)

For me at least, all memory, whether mem-mapped to a card or not, is accessible 
from everywhere. Port I/O I have to play some funky games for, but that's a
different story.
 
> Not just per processor.  Think about a rackmount shared memory beowulf 
> system, page faulting through the network.  With quad-processor boards in 
> each 1U, and BLAZINGLY FAST interconnects in the cluster.  Now teach that to 
> act like NUMA.

The interconnect would need hardware support for NUMA to do the cache 
coherency and transparent remote memory access.

> Each 1U has four processors with identical performance (and probably one set 
> of page tables if they share a northbridge).  Assembling NUMA systems out of 
> closely interconnected SMP systems.

That's exactly what the NUMA-Q systems are. More or less standard 4-way
Intel boxes, with an interconnect doing something like 10Gb/second with
reasonably low latency. Up to 16 quads = 64 processors. Current code is
limited to 32 procs on Linux.
 
> It may not be a driver issue.  It may be a bus issue.  If there are two PCI 
> busses in the system, do they HAVE to share one set of physical memory 
> mappings?  (NUMA sort of implies we have more than one northbridge.  Dontcha 
> think we might have more than one southbridge, too?)

I fear I don't understand this. Not remembering what north vs south did again
(I did know once) probably isn't helping ;-) But yes, everyone shares the same
physical memory map, at leas on NUMA-Q
 
> It's not just 32/64 bit DMA.  You're assuming every I/O device in the system 
> is talking to exactly the same pool of memory.  The core assumption of NUMA 
> is that the processors aren't doing that, so I don't know why the I/O devices 
> necessarily should.  (Maybe they do, what do I know.  It would be nice to 
> hear from somebody with actual information...)

No, the core assumption of NUMA isn't that everyone's not talking to the same
pool of memory, it's that talking to different parts of the pool isn't done at a
uniform speed.
 
> And if they ARE all talking to one pool of memory, than the whole NUMA 
> question becomes a bit easier, actually...  The flood of zones we were so 
> worried about (Node 18's processor sending packets through a network card 
> living on node 13) can't really happen, can it?

You still want to allocate memory locally for performance reasons, even though
it'll work. My current port to NUMA-Q doesn't do that, and the performance
will probably get a lot better when it does. We still need to split different nodes
memory into different zones (or find another similar solution).
 
>> > I always think of numa as the middle of a continuum.  Zillion-way SMP
>> > with enormous L1 caches on each processor starts acting a bit like NUMA
>> > (you don't wanna go out of cache and fight the big evil memory bus if you
>> > can at all avoid it, and we're already worrying about process locality
>> > (processor affinity) to preserve cache state...).
>> 
>> Kind of, except you can explicitly specify which bits of memory you want to
>> use, rather than the hardware working it out for you.
> 
> Ummm...

I mean if you have a process running on node 1, you can tell it to allocate
memory on node 1 (or you could if the code was there ;-) ). Processes on
node 3 get memory on node 3, etc. In an "enormous L1 cache" the hardware
works out where to put things in the cache, not the OS.

> Is the memory bus somehow physically reconfiguring itself to make some chunk 
> of memory lower or higher latency when talking to a given processor?  I'm 
> confused...

Each node has it's own bank of RAM. If I access the RAM in another node,
I go over the interconnect, which is a damned sight slower than just going
over the local memory bus. The interconnect plugs into the local memory 
bus of each node, and transparently routes requests around to other nodes
for you.

Think of it like a big IP based network. Each node is a LAN, with it's own
subnet. The interconnect is the router connecting the LANs. I can do 100Mbs
over the local LAN, but only 10 Mbps through the router to remote LANs.
 
This email is far too big, and I have to go to a meeting. I'll reply to the rest
of it later ;-)

M.

