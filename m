Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318164AbSGQAUw>; Tue, 16 Jul 2002 20:20:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318165AbSGQAUv>; Tue, 16 Jul 2002 20:20:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25339 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S318164AbSGQAUt>;
	Tue, 16 Jul 2002 20:20:49 -0400
Subject: Re: [patch[ Simple Topology API
From: Michael Hohnbaum <hohnbaum@us.ibm.com>
To: Linus Torvalds <torvalds@transmeta.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@zip.com.au>,
       linux-kernel@vger.kernel.org, Martin Bligh <mjbligh@us.ibm.com>
In-Reply-To: <Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
References: <Pine.LNX.4.44.0207141156540.19060-100000@home.transmeta.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 16 Jul 2002 17:21:41 -0700
Message-Id: <1026865302.1273.50.camel@dyn9-47-17-90.beaverton.ibm.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 2002-07-14 at 12:17, Linus Torvalds wrote:
> 
> [ I've been off-line for a week, so I didn't follow all of the discussion,
>   but here goes anyway ]
> 
> On 13 Jul 2002, Andi Kleen wrote:
> >
> > Current x86-64 NUMA essentially has no 'nodes', just each CPU has
> > local memory that is slightly faster than remote memory. This means
> > the node number would be always identical to the CPU number. As long
> > as the API provides it's ok for me. Just the node concept will not be
> > very useful on that platform. memblk will also be identity mapped to
> > node/cpu.
> 
> The whole "node" concept sounds broken. There is no such thing as a node,
> since even within nodes latencies will easily differ for different CPU's
> if you have local memories for CPU's within a node (which is clearly the
> only sane thing to do).
> 
> If you want to model memory behaviour, you should have memory descriptors
> (in linux parlance, "zone_t") have an array of latencies to each CPU. That
> latency is _not_ a "is this memory local to this CPU" kind of number, that
> simply doesn't make any sense. The fact is, what matters is the number of
> hops. Maybe you want to allow one hop, but not five.

How NUMA binding APIs have been used successfully is for a group of
processes to all decide to "hang out" together in the same vicinity
so that they can optimize access to shared memory.  In existing NUMA
systems, this has been deciding to execute on a subset of the nodes.
In a system with 4 nodes, on NUMAQ machines, the latency is either
local or remote.  Thus if one sets a binding/latency argument such 
that remote accesses are allowed, then all of the nodes are fair game,
otherwise only the local node is used.  So a set of processes decides
to occupy two nodes.  Using strictly a latency argument, there is no
way to specify this.  One could use cpu binding to restrict the 
processes to the two nodes, but not the memory - unless you now 
associate cpus with memory/nodes and are back to maintaining 
topology info.

Another shortcoming of latency based binding is if a process executes
on a node for awhile, then gets moved to another node.  In that case
the best memory allocation depends on several factors.  The first is
to determine where we measure latency from - the node the process is
currently executing or where it had been executing?  From a scheduling
perspective we are playing with the idea of a home node.  If a 
process is dispatched off of the home node should memory allocations
come from the home node or the current node?  If neither has available
memory should latency be considered from home or current?

The other way that memory binding has been used is for a large process,
typically a database, to want control over where it places memory and
data structures.  It is not a latency issue, but rather one of how
the work is distributed across the system.

The memory binding that Matt proposed allows an architecture to 
define what a memory block is, and the application to determine
how it wants to bind to the memory blocks.  It is only intended
for use by applications that are aware of the complexities 
involved, and these will have to be knowledgeable about the 
systems that they are on.  Hopefully, by default, Linux will
do the right things as far as memory placement for processes
that choose to leave it up to the system - which will be the 
majority of apps.  However, the apps that want to specify their
memory placement, want the ability to have explicit control
over the nodes it lands on.  It is not strictly a latency based
decision.

                   Michael
-- 

Michael Hohnbaum                      503-578-5486
hohnbaum@us.ibm.com                   T/L 775-5486

