Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317012AbSGNTOx>; Sun, 14 Jul 2002 15:14:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317017AbSGNTOw>; Sun, 14 Jul 2002 15:14:52 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:9736 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317012AbSGNTOu>; Sun, 14 Jul 2002 15:14:50 -0400
Date: Sun, 14 Jul 2002 12:17:25 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andi Kleen <ak@suse.de>
cc: Andrew Morton <akpm@zip.com.au>, <linux-kernel@vger.kernel.org>,
       Michael Hohnbaum <hohnbaum@us.ibm.com>,
       Martin Bligh <mjbligh@us.ibm.com>
Subject: Re: [patch[ Simple Topology API
In-Reply-To: <p73ofdbv1a4.fsf@oldwotan.suse.de>
Message-ID: <Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


[ I've been off-line for a week, so I didn't follow all of the discussion,
  but here goes anyway ]

On 13 Jul 2002, Andi Kleen wrote:
>
> Current x86-64 NUMA essentially has no 'nodes', just each CPU has
> local memory that is slightly faster than remote memory. This means
> the node number would be always identical to the CPU number. As long
> as the API provides it's ok for me. Just the node concept will not be
> very useful on that platform. memblk will also be identity mapped to
> node/cpu.

The whole "node" concept sounds broken. There is no such thing as a node,
since even within nodes latencies will easily differ for different CPU's
if you have local memories for CPU's within a node (which is clearly the
only sane thing to do).

If you want to model memory behaviour, you should have memory descriptors
(in linux parlance, "zone_t") have an array of latencies to each CPU. That
latency is _not_ a "is this memory local to this CPU" kind of number, that
simply doesn't make any sense. The fact is, what matters is the number of
hops. Maybe you want to allow one hop, but not five.

Then, make the memory binding interface a function of just what kind of
latency you allow from a set X of CPU's. Simple, straightforward, and it
has a direct meaning in real life, which makes it unabiguous.

So your "memory affinity" system call really needs just one number: the
acceptable latency. You may also want to have a CPU-set argument, although
I suspect that it's equally correct to just assume that the CPU-set is the
set of CPU's that the process can already run on.

After that, creating a new zone array is nothing more than:

 - give each zone a "latency value", which is simply the minimum of all
   the latencies for that zone from CPU's that are in the CPU set.

 - sort the zone array, lowest latency first.

 - the passed-in latency is the cut-off-point - clear the end of the
   array (with the sanity check that you always accept one zone, even if
   it happens to have a latency higher than the one passed in).

End result: you end up with a priority-sorted array of acceptable zones.
In other words, a zone list. Which iz _exactly_ what you want anyway
(that's what the current "zone_table" is.

And then you associate that zone-list with the process, and use that
zone-list for all process allocations.

Advantages:

 - very direct mapping to what the hardware actually does

 - no complex data structures for topology

 - works for all topologies, the process doesn't even have to know, you
   can trivially encode it all internally in the kernel by just having the
   CPU latency map for each memory zone we know about.

Disadvantages:

 - you cannot create "crazy" memory bindings. You can only say "I don't
   want to allocate from slow memory". You _can_ do crazy things by
   initially using a different CPU binding, then doing the memory
   binding, and then re-doing the CPU binding. So if you _want_ bad memory
   bindings you can create them, but you have to work at it.

 - we have to use some standard latency measure, either purely time-based
   (which changes from machine to machine), or based on some notion of
   "relative to local memory".

My personal suggestion would be the "relative to local memory" thing, and
call that 10 units. So a cross-CPU (but same module) hop might imply a
latency of 15, which a memory access that goes over the backbone between
modules might be a 35. And one that takes two hops might be 55.

So then, for each CPU in a machine, you can _trivially_ create the mapping
from each memory zone to that CPU. And that's all you really care about.

No?

		Linus

