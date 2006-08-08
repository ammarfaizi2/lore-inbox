Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030246AbWHHTeG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030246AbWHHTeG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 15:34:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030240AbWHHTeF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 15:34:05 -0400
Received: from [213.46.243.16] ([213.46.243.16]:26492 "EHLO
	amsfep17-int.chello.nl") by vger.kernel.org with ESMTP
	id S1030246AbWHHTeD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 15:34:03 -0400
From: Peter Zijlstra <a.p.zijlstra@chello.nl>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Cc: Daniel Phillips <phillips@google.com>,
       Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Tue, 08 Aug 2006 21:33:25 +0200
Message-Id: <20060808193325.1396.58813.sendpatchset@lappy>
Subject: [RFC][PATCH 0/9] Network receive deadlock prevention for NBD
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Daniel Phillips <phillips@google.com>

Recently, Peter Zijlstra and I have been busily collaborating on a
solution to the memory deadlock problem described here:

   http://lwn.net/Articles/144273/
   "Kernel Summit 2005: Convergence of network and storage paths"

We believe that an approach very much like today's patch set is
necessary for NBD, iSCSI, AoE or the like ever to work reliably. 
We further believe that a properly working version of at least one of
these subsystems is critical to the viability of Linux as a modern
storage platform.

Today's patch set builds on a patch I posted a while back:

   http://lwn.net/Articles/146061/
   "Net vm deadlock fix (preliminary)"

Peter Zijlstra got the ball rolling again by posting this patch:

   http://lkml.org/lkml/2006/7/7/164

Which I gently flamed:

   http://lkml.org/lkml/2006/7/7/245
   
Peter turned out to be right. Any elevator other than NOOP is wrong for
NBD on the client side.  It turns out that something in the elevator
itself deadlocks under heavy load.  This is a bug: io_sched waits
forever under certain conditions.  Maybe it is another memory deadlock,
who knows.  It is for sure a bug for another day, in a piece of machinery
that we have now discarded as far as the NBD client is concerned.

However, the mere possibility that Peter's deadlock might be in the
network receive path was enough to motivate us to get down to work and
close that subtle hole.  To be sure, the network receive path deadlock
is not so much a deadlock as a severe performance bug.  When it bites,
valuable packets will be lost just when the system is least able to
afford the loss.  Under rare circumstances a true deadlock will occur.

Our immediate objective is to prevent that rare deadlock and to go
further: we also prevent the performance bug in all but the most exotic
of circumstances.  And we go further yet by attemping to keep unrelated
traffic flowing more or less smoothly on the same socket as the block IO
traffic, even under conditions of heavy memory stress.

Peter will be doing the heavy lifting on this patch from here on, so I
suppose we can call this a changing of the hats.

The problem:

Sometimes our Linux VMM needs to allocate memory in order to free
memory, for example when writing dirty file pages to disk or writing
process pages to swap.  In the case of dirty file pages we may need to
read in some file metadata in order to know where to write a given page.
We avoid deadlock in this case by providing the filesystem access to a
special "memalloc" reserve of pages whenever it is doing work on behalf
of the VMM.  This is implemented via a PF_MEMALLOC process flag to
tell alloc_pages that it may satisfy a memory allocation request by
dipping into the memalloc reserve if it must.  A PF_MEMALLOC
process is thus able to complete its work without recursing into
the memory-freeing code and risking deadlock.  This simple strategy
has served us well for years.

A difficulty that has arisen in recent years is that sometimes code
involved in writing out pages needs to rely on some other process than
itself to help it do its work.  Such a "memhelper" process does not
automatically inherit the PF_MEMALLOC process flag because it is
not called directly, and ends up competing for the same memory as any
other process.  There is clear and present danger that such a process
may block forever waiting for memory to be freed, a deadlock.  Clearly
we must either get rid of such processes entirely by refactoring code,
or where that is impossible, we must provide access to a special memory
reserve in order to avoid falling into the deep black pit of vm
recursion.  This is not particularly hard.  We just need to:

   a) Run such a process in PF_MEMALLOC mode

and

   b) Throttle the activity of the process so that it never exceeds
   some pre-calculated threshold of memory usage, and thus does not
   exhaust the memalloc reserve.

Other solutions such as mempool (similarly combined with throttling) are
certainly possible, but the memalloc solution is particularly simple and
obviously correct.

Unfortunately, a particularly nasty form of memory deadlock arises from
the fact that receive side of the network stack is also a sort of
separate process.  If we operate a block device remotely over the
network as many of us do these days, we must provide reserve memory to
the network receive path in order to avoid deadlock.  But we cannot
provide such reserve memory willy nilly to every network packet
arriving, otherwise the reserve may be exhausted just as essential
memory-freeing protocol traffic shows up.  This is the dread network
memory deadlock that has plagued such subsystems as the network block
device since time immemorial.

Our solution:

Today we consider only the network receive aspect of the memory deadlock
problem, because it is by far the most difficult manifestation and
because a solution to just this aspect is all that stands in the way of
a reliable network block device.

We observe that the crux of the problem is not knowing whether to
provide reserve memory to an incoming packet or not.  We therefore
provide reserve memory to every incoming IP packet up to the point where
we can decode the IP header and learn whether the packet belongs to a
socket known to be carrying block IO traffic.  If this short-hop reserve
memory has fallen below some threshold then we will drop incoming
network traffic that is not involved in network block IO.  We never
drop block IO traffic unless there is a bug in the throttling scheme
such that the memory reserve becomes completely depleted,
which would prevent the network interface's dma buffer ring from
being replenished.

Following rule (b) above, we throttle all network block IO traffic to
avoid overloading our device-level reserve.  Then we set the reserve to
be higher than the sum of maximum possible unidentified packets and the
amount of in-flight block IO permitted by our throttling scheme.

The interval over which unclassified packets exist is actually quite
small: it exists only from the device packet receive interrupt to where
the owning socket is identified in ip_local_deliver_finish.  Just to be
safe, we allow a hundred or so packets to be in flight over this small
interval. If by some collosal accident we actually exceeded that number
then we would not deadlock, we would just risk dropping a packet.  We
still have some large number of block IO packets happily in flight, and
that must be so or we could not have exhausted the reserve.  Thus, the
VMM continues to make forward progress, moreover it continues to
progress at nearly its full throughput.

We believe that a suitable choice of reserve size and throttling limit
for any given configuration will permit completely reliable remote block
IO operation even with unrelated traffic sharing the network interface.
Further refinements to this work can be expected to focus on the
following aspects:

  1) Calculate reserve sizes and throttling limits accurately
     and automatically in response to configuration changes,

  2) Incorporate possible additional memory consumers such as
     netfilter into the scheme.

  3) Place a tight bound on the amount of traffic that can be
     in flight between the receive interrupt and protocol
     identification, thus allowing reserve requirements to be
     lowered.

  4) Change the skb memory resource accounting from per skb to
     per page for greater accuracy.

How it works

(Heavy reading ahead, please skip this if you do not intend to analyze
the code.)  Let us just jump in right the middle of things: a network
interface such as e1000 DMAs its latest packet to one of the sk_bufs in
its receive ring then generates a receive interrupt.  At the end of the
interrupt the driver attempts to refill the sk_buf ring using an atomic
allocation of a new sk_buf.  Nothing bad happens if such a refill
attempt fails once, but if there are many failures in a row then the
interface will eventually hit the wall and run out of buffers, forcing
incoming packets to be dropped and severely degrading the performance of
such protocols as TCP.

We have changed the sk_buf allocation api slightly to allow the
allocator to act more intelligently.  It first tries to allocate an
sk_buf normally, then if that fails it takes special action by redoing
the allocation from the PF_MEMALLOC emergency memory reserve.  We
introduce a new GPF_MEMALLOC flag to allow the emergency allocation from
an interrupt.  Under these severe conditions we take care to perform
each sk_buf allocation as a full page, not from the slab, which avoids
some nasty fragmentation issues.  This is arguably a little wasteful,
however in the grand scheme of things it is just a minor blip.

We place a bound on the number of such emergency sk_bufs that can be in
flight.  This bound is set to be larger than the sum of the maximum
block IO traffic on the interface and the maximum number of packets
that can possibly have been received at the interface but not yet
classified as to protocol or socket.  The latter is a somewhat hard to
pin down quantity, but we know from the code structure that it cannot be
very large.  So we make the emergency pool way, way bigger than we think
this could ever be.

Each sk_buf, emergency-allocated or otherwise, proceeds up through
the protocol layers, now in a soft irq work queue rather than a true
interrupt.  On SMP machines there can be some queuing behaviour here,
so more than one packet can be in flight on this section of the packet
receive path simultaneously.  It probably will not be more than a
handful, so we allow for something like 20 or 50 in this state.

As soon as the sk_buf hits the protocol decode handler, suddenly we are
able to tell which protocol is involved, and which socket.  We then
check to see how deep the interface is into its reserve and drop (or, in
a future version, optionally hold) non-block IO traffic at this point.
Actually, we have such a generous reserve and such a nice way of getting
at it that we may never drop any packets here either.

Having pushed the sk_buf onto some socket's incoming queue, the soft
irq has done its work.  Now, an emergency sk_buf may continue to live an
aribitrarily long time, since the NBD driver may be delayed an
arbitrarily long time for one reason or another.  But this is OK because
we have throttled the virtual block device to some maximum amount of IO
that can possibly be in flight, and made sure that the limit is high
enough to ensure that not only are we making forward progress, but we
are making forward progress as fast as the remote disk and network can
handle it.  This is exactly what we want in a low memory situation.

Eventually, the NBD client pulls the sk_buf off the incoming queue,
copies the data somewhere, and deallocates the sk_buf.  In the case of
an emergency sk_buf, this ensures that the share of the PF_MEMALLOC
reserve dedicated to a particular NBD device will never be exceeded. 
Then the birds come out and angel choirs sing (sometimes).

Some implementation details:

Departing somewhat from recent kernel fashion trends, we have built this
patch set around the traditional memalloc reserve and not the newer,
fancier mempool api.  This is because the memalloc approach is
considerably more lightweight and just as obviously correct.  It works
because we are able to express all our resource requirements in units of
zero order pages, precisely what the memalloc reserve provides us.  We
think that less is more.

Arguably, when coding mistakes are made mempool will make the problem
obvious more quickly than the global memalloc reserve, which gives no
clue of which user went over its limit.  This is most probably a reason
to write some fancy resource leak detection tools, not to throw out the
memalloc idea.

I did make a special effort to eliminate one of the problems with the
traditional memalloc reserve: how big should it be?  We now make it
resizable, and make it the responsibility of whichever module uses the
functionality to expand the global reserve and shrink it as necessary. 
For example, the global reserve may be increased when we initialize a
network block device and reduced by the same amount if the device is
destroyed. Or it might be increased in some module's init function and
reduced on exit.

I introduced a new allocation flag, GFP_MEMALLOC, which is the same as
GFP_ATOMIC but provides access to memalloc reserves for an atomic
user like an interrupt just as PF_MEMALLOC does for a task in normal
context.

Other implementation details are apparent from the code, and if they
are not then we will happily amend the patches with comments and answer
questions here.

The spectre of IP fragmentation has been raised.  Because the reserve
safety factor is so large, we do not think that anything special needs
to be done to handle fragmentation under this scheme, however we are
open to suggestions and further analysis.

Credits

I would like to thank the following gentlemen for aiding this work in
one way or another:

  Peter Zijlstra, who had the good grace to pick up and improve an
     existing patch instead of reinventing his own as is traditional.

  Rik van Riel, for inciting the two of us to finish the patch, and also
     for providing a very nice wiki page discussing the problem.

  Jon Corbet, for keeping score and explaining my earlier work better
     than I ever could.

  Joseph Dries, who realized exactly why this work is important and
     enouraged me to complete it.

  Andrew Morton, Ted Ts'o and Peter Anvin for listening patiently to
     my early ramblings about how I would solve this problem, which
     were sometimes way off the mark.

  Google Inc, for giving me one of the best hacking jobs in the world
     and for not being evil.

Further Reading

Memory deadlock thread from kernel-summit-discuss

   http://thread.gmane.org/gmane.linux.network/24165
   A Fascinating discussion of the problem prior to the 2005 kernel
   summit.

Netdev threads

Early versions of the patch and an embarrassing mistake I made as I
learned about the network packet delivery path.

   http://marc.theaimsgroup.com/?l=linux-netdev&m=112305260502201&w=2
   http://marc.theaimsgroup.com/?l=linux-netdev&m=112331377806222&w=2
   http://marc.theaimsgroup.com/?l=linux-netdev&m=112336517131046&w=2
   http://marc.theaimsgroup.com/?l=linux-netdev&m=112349600610884&w=2
   http://marc.theaimsgroup.com/?l=linux-netdev&m=112355867312022&w=2
   http://marc.theaimsgroup.com/?l=linux-netdev&m=112379949818293&w=2

Jon Corbet's writeup of the original patch

   "Toward more robust network-based block I/O"
   http://lwn.net/Articles/146689/

Rik van Riel's network memory deadlock wiki

   http://linux-mm.org/NetworkStorageDeadlock
