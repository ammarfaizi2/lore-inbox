Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317991AbSGPW2N>; Tue, 16 Jul 2002 18:28:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318143AbSGPW2M>; Tue, 16 Jul 2002 18:28:12 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.102]:52931 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S317991AbSGPW2K>;
	Tue, 16 Jul 2002 18:28:10 -0400
Message-ID: <3D349E50.3020903@us.ibm.com>
Date: Tue, 16 Jul 2002 15:29:36 -0700
From: Matthew Dobson <colpatch@us.ibm.com>
Reply-To: colpatch@us.ibm.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.0) Gecko/20020607
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
CC: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [patch[ Simple Topology API
References: <p73ofdbv1a4.fsf@oldwotan.suse.de> <Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> [ I've been off-line for a week, so I didn't follow all of the discussion,
>   but here goes anyway ]
> 
> On 13 Jul 2002, Andi Kleen wrote:
> 
>>Current x86-64 NUMA essentially has no 'nodes', just each CPU has
>>local memory that is slightly faster than remote memory. This means
>>the node number would be always identical to the CPU number. As long
>>as the API provides it's ok for me. Just the node concept will not be
>>very useful on that platform. memblk will also be identity mapped to
>>node/cpu.
> 
> 
> The whole "node" concept sounds broken. There is no such thing as a node,
> since even within nodes latencies will easily differ for different CPU's
> if you have local memories for CPU's within a node (which is clearly the
> only sane thing to do).
If you're saying local memories for *each* CPU within a node, then no, that is 
not the only sane thing to do.  There are some architectures that do, and some 
that do not.  The Hammer architecture, to the best of my knowledge, has memory 
hanging off of each CPU, however, NUMA-Q, the main one I work with, has local 
memory for each group of 4 CPUs.  If you're speaking only of node-local memory, 
ie: memory local to all the CPUs on the 'node', then all local CPUs should have 
the same latency to that memory.

> If you want to model memory behaviour, you should have memory descriptors
> (in linux parlance, "zone_t") have an array of latencies to each CPU. That
> latency is _not_ a "is this memory local to this CPU" kind of number, that
> simply doesn't make any sense. The fact is, what matters is the number of
> hops. Maybe you want to allow one hop, but not five.
> 
> Then, make the memory binding interface a function of just what kind of
> latency you allow from a set X of CPU's. Simple, straightforward, and it
> has a direct meaning in real life, which makes it unabiguous.
I mostly agree with you here, except I really do believe that we should use the 
node abstraction.  It adds little overhead, but buys us a good bit.  Nodes, 
according to the API, are defined on a per-arch basis, allowing for us to 
sanely define nodes on our NUMA-Q hardware (node==4cpus), AMD people to sanely 
define nodes on there hardware (node==cpu), and others to define nodes to 
whatever they want.  We will avoid redundant data in many cases, and in the 
simplest case, this defaults to your node==cpu behavior anyway.  If we do use 
CPU-Mem latencies, the NUMA-Q platform (and I'm sure others) would only be able 
to distinguish between local and remote CPUs, not individual remote CPUs.

> So your "memory affinity" system call really needs just one number: the
> acceptable latency. You may also want to have a CPU-set argument, although
> I suspect that it's equally correct to just assume that the CPU-set is the
> set of CPU's that the process can already run on.
> 
> After that, creating a new zone array is nothing more than:
> 
>  - give each zone a "latency value", which is simply the minimum of all
>    the latencies for that zone from CPU's that are in the CPU set.
> 
>  - sort the zone array, lowest latency first.
> 
>  - the passed-in latency is the cut-off-point - clear the end of the
>    array (with the sanity check that you always accept one zone, even if
>    it happens to have a latency higher than the one passed in).
> 
> End result: you end up with a priority-sorted array of acceptable zones.
> In other words, a zone list. Which iz _exactly_ what you want anyway
> (that's what the current "zone_table" is.
> 
> And then you associate that zone-list with the process, and use that
> zone-list for all process allocations.
It seems as though you'd be throwing out some useful data.  For example, 
imagine you have a 2 quad NUMAQ system.  Each quad contains 4 CPUs and a block 
of memory.  Now if use all of the CPUs as our CPU set, zone 0 (memory block on 
quad 0) will have a latency of 1 (b/c it is one hop from the first 4 cpus), as 
will zone 1 (memory block on quad 1), b/c it is one hop from the second 4 cpus. 
  Now it would appear that since these zones both have the same latency, they 
would be eqally good choices.  This isn't true, since if the process is on CPU 
0-3, it should allocate on zone 0, and vice versa for CPUs 4-7.  Latency 
shouldn't be the ONLY way to make decisions.

> Advantages:
> 
>  - very direct mapping to what the hardware actually does
For some architectures, but for some it isn't.

>  - no complex data structures for topology
Agreed.

>  - works for all topologies, the process doesn't even have to know, you
>    can trivially encode it all internally in the kernel by just having the
>    CPU latency map for each memory zone we know about.
True, but the point of this is API is to allow for processes that *DO* want to 
know to make intelligent decisions!  Those that don't care, can still go on, 
blissfully unaware they are on a NUMA system.

> Disadvantages:
> 
>  - you cannot create "crazy" memory bindings. You can only say "I don't
>    want to allocate from slow memory". You _can_ do crazy things by
>    initially using a different CPU binding, then doing the memory
>    binding, and then re-doing the CPU binding. So if you _want_ bad memory
>    bindings you can create them, but you have to work at it.
Why limit the process?  The overhead is so small to allow processes to do 
anything they want, why not allow them?

>  - we have to use some standard latency measure, either purely time-based
>    (which changes from machine to machine), or based on some notion of
>    "relative to local memory".
 >
> My personal suggestion would be the "relative to local memory" thing, and
> call that 10 units. So a cross-CPU (but same module) hop might imply a
> latency of 15, which a memory access that goes over the backbone between
> modules might be a 35. And one that takes two hops might be 55.
Absolutely true.  I think that the "relative to local memory" is a great 
measuring stick.  It is pretty much platform agnostic, assuming every platform 
has some concept of "local" memory.

I basically think that we should give processes that care the ability to do 
just about anything they want, no matter how crazy...  Most processes will 
never even attempt to look at their default bindings, never mind change them. 
Plus, were making mechanism decisions that will (hopefully) be around for some 
time.  I'm sure people will come up with things we can't even imagine, so the 
more powerful the API the better.

<prepares to stop, drop, and roll>

-Matt


> So then, for each CPU in a machine, you can _trivially_ create the mapping
> from each memory zone to that CPU. And that's all you really care about.
> 
> No?
> 
> 		Linus
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 


