Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277089AbRJDC2h>; Wed, 3 Oct 2001 22:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277090AbRJDC22>; Wed, 3 Oct 2001 22:28:28 -0400
Received: from femail35.sdc1.sfba.home.com ([24.254.60.25]:6599 "EHLO
	femail35.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S277089AbRJDC2O>; Wed, 3 Oct 2001 22:28:14 -0400
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
Reply-To: landley@trommello.org
Organization: Boundaries Unlimited
To: Rik van Riel <riel@conectiva.com.br>
Subject: Re: Whining about 2.5 (was Re: [PATCH] Re: bug? in using generic read/write functions to read/write block devices in 2.4.11-pre2)
Date: Wed, 3 Oct 2001 18:27:49 -0400
X-Mailer: KMail [version 1.2]
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33L.0110032134320.4835-100000@imladris.rielhome.conectiva>
In-Reply-To: <Pine.LNX.4.33L.0110032134320.4835-100000@imladris.rielhome.conectiva>
MIME-Version: 1.0
Message-Id: <01100318274901.00728@localhost.localdomain>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 03 October 2001 20:38, Rik van Riel wrote:
> On Wed, 3 Oct 2001, Rob Landley wrote:
> > (Oh, and what's the deal with "classzones"?  Linus told Andrea
> > classzones were a dumb idea, and we'd regret it when we tried to
> > inflict NUMA architecture on 2.5, but then went with Andrea's VM
> > anyway, which I thought was based on classzones...  Was that ever
> > resolved?  What the problem avoided?  What IS a classzone, anyway?
> > I'd be happy to RTFM, if anybody could tell me where TF the M is
> > hiding...)
>
> Classzones used to be a superset of the memory zones, so
> if you have memory zones A, B and C you'd have classzone
> Ac consisting of memory zone A, classzone Bc = {A + B}
> and Cc = {A + B + C}.

Ah.  Cumulative zones.  A class being a collection of zones, the class-zone 
patch.  Right.  That makes a lot more sense...

> This gives obvious problems for NUMA, suppose you have 4
> nodes with zones 1A, 1B, 1C, 2A, 2B, 2C, 3A, 3B, 3C, 4A,
> 4B and 4C. 

Is there really a NUMA machine out there where you can DMA out of another 
node's 16 bit ISA space?  So far the differences in the zones seem to be 
purely a question of capabilities (what you can use this ram for), not 
performance.  Now I know numa changes that, but I'm wondering how many 
performance-degraded memory zones we're likely to have that still have 
capabilities like "we can DMA straight out of this".  Or better yet, "we WANT 
to DMA straight out of this".  Zones where we wouldn't be better off having 
the capability in question invoked from whichever node is "closest" to that 
resource.  Perhaps some kind of processor-specific tasklet.

So how often does node 1 care about the difference between DMAable and 
non-DMAable memory in node 2?  And more importantly, should the kernel care 
about this difference, or have the function invoked over on the other 
processor?

Especially since, discounting straightforward memory access latency 
variations, it SEEMS like this is largely a driver question.  Device X can 
DMA to/from these zones of memory.  The memory isn't different to the 
processors, it's different to the various DEVICES.  So it's not just a 
processor question, but an association between processors, memory, and 
devices.  (Back to the concept of nodes.)  Meaning drivers could be supplying 
zone lists, which is just going to be LOADS of fun...

<uninformed rant>

I thought a minimalistic approach to numa optimization was to think in terms 
of nodes, and treat each node as one or more processors with a set of 
associated "cheap" resources (memory, peripherals, etc).  Multiple tiers of 
decreasing locality for each node sounds like a lot of effort for a first 
attempt at NUMA support.  That's where the "hideously difficult to calculate" 
bits come in.  A problem with could increase exponentially with the number of 
nodes...

I always think of numa as the middle of a continuum.  Zillion-way SMP with 
enormous L1 caches on each processor starts acting a bit like NUMA (you don't 
wanna go out of cache and fight the big evil memory bus if you can at all 
avoid it, and we're already worrying about process locality (processor 
affinity) to preserve cache state...).  Shared memory beowulf clusters that 
page fault through the network with a relatively low-latency interconnect 
like myrinet would act a bit like NUMA too.  (Obviously, I haven't played 
with the monster SGI hardware or the high-end stuff IBM's so proud of.)

In a way, swap space on the drives could be considered a 
performance-delimited physical memory zone.  One the processor can't access 
directly, which involves the allocation of DRAM bounce buffers.  Between that 
and actual bounce buffers we ALREADY handle problems a lot like page 
migration between zones (albeit not in a generic, unified way)...

So I thought the cheap and easy way out is to have each node know what 
resources it considers "local", what resources are a pain to access (possibly 
involving a tasklet on annother node), and a way to determine when tasks 
requiring a lot of access to them might better to be migrated directly to a 
node where they're significantly cheaper to the point where the cost of 
migration gets paid back.  This struck me as the 90% "duct tape" solution to 
NUMA. 

</uninformed rant>  (Hopefully, anyway...)

Of course there's bound to be something fundamentally wrong with my 
understanding of the situation that invalidates all of the above, and I'd 
appreciate anybody willing to take the time letting me know what it is...

So what hardware inherently requires a multi-tier NUMA approach beyond "local 
stuff" and "everything else"?  (I suppose there's bound to be some linearlly 
arranged system with a long gradual increase in memory access latency as you 
go down the row, and of course a node in the middle which has a unique 
resource everybody's fighting for.  Is this a common setup in NUMA systems?)

And then, of course, there's the whole question of 3D accelerated video card 
texture memory, and trying to stick THAT into a zone. :)  (Eew!  Eew!  Eew!)  
Yeah, it IS a can of worms, isn't it?

But class/zone lists still seem fine for processors.  It's just a question of 
doing the detective work for memory allocation up front, as it were.  If you 
can't figure it out up front, how the heck are you supposed to do it 
efficiently at allocation time?

It's just that a lot of DEVICES (like 128 megabyte video cards, and 
limited-range DMA controllers) need their own class/zone lists, too.  This 
chunk of physical memory can be used as DMA buffers for this PCI bridge, 
which can only be addressed directly by this group of processors anyway 
because they share the IO-APIC it's wired to...  Which involves challenging a 
LOT of assumptions about the global nature of system resources previous 
kernels used to make, I know.  (Memory for DMA needs the specific device in 
question, but we already do that for ISA vs PCI dma...  The user level stuff 
is just hinting to avoid bounce buffers...)

Um, can bounce buffers permanent page migration to another zone?  (Since we 
have to allocate the page ANYWAY, might as well leave it there till it's 
evicted, unless of course we're very likely to evict it again pronto in which 
case we want to avoid bouncing it back...  Hmmm...  Then under NUMA there 
would be the "processor X can't access page in new location easily to fill it 
with new data to DMA out..."  Fun fun fun...)

> Putting together classzones for these isn't
> quite obvious and memory balancing will be complex ;)

And this differs from normal in what way?

It seems like andrea's approach is just changing where work is done.  Moving 
deductive work from allocation time to boot time.  Assembling class/zone 
lists is an init-time problem (boot time or hot-pluggable-hardware swap 
time).  Having zones linked together into lists of "this pool of memory can 
be used for these tasks", possibly as linked lists in order of preference for 
allocations or some such optimization, doesn't strike me as unreasonable.  
(It is ENTIRELY possible I'm wrong about this.  Bordering on "likely", I'll 
admit...)

Making sure that a list arrangement is OPTIMAL is another matter, but 
whatever method gets chosen to do that people are probably going to be 
arguing it for years.  You can't swap to disk perfectly without being able to 
see the future, either...

The balancing issue is going to be fun, but that's true whatever happens.  
You inherently have multiple nodes (collections of processors with clear and 
conflicting preferences about resources) disagreeing with each other about 
allocation decisions during the course of operation.  That's part of the 
reason the "cheap bucket" and "non-cheap bucket" approach always appealed to 
me (for zillion way SMP and shared memory clusters, anyway, where they're 
pretty much the norm anyway).  Of course where cheap buckets overlap, there 
might need to be some variant of weighting to reduce thrashing...  Hmmm.

Wouldn't you need weighting for non-class zones anyway?  Classing zones 
doesn't necessarily make weighting undoable.  The ability to make decisions 
about a class doesn't mean ALL decisions have to be just aboout the class.  
It's just that you quickly know what "world" you're starting with, and can 
narrow down from there.  (I'll have to look more closely at Andrea's 
implementation now that I know what the heck it's supposed to be doing.  Now 
that I THINK I know, anyway...) 

> Of course, nobody knows the exact definitions of classzones
> in the new 2.4 VM since it's completely undocumented; lets

I'd noticed.

> hope Andrea will document his code or we'll see a repeat of
> the development chaos we had with the 2.2 VM...

Or, for that matter, early 2.4 up until the start of the use-once thread.  
For me, anyway.

Since 2.4 isn't supposed to handle NUMA anyway, I don't see what difference 
it makes.  Just use ANYTHING that stops the swap storms, lockups, zone 
starvation, zero order allocation failures, bounce buffer shortages, and 
other such fun we were having a few versions back.  (Once again, this part 
now seems to be in the "it works for me"(tm) stage.)

Then rip it out and start over in 2.5 if there's stuff it can't do.

> cheers,
>
> Rik

thingy,

Rob Landley,
master of stupid questions.
