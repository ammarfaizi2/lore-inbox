Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284593AbRLETKQ>; Wed, 5 Dec 2001 14:10:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284595AbRLETKE>; Wed, 5 Dec 2001 14:10:04 -0500
Received: from e21.nc.us.ibm.com ([32.97.136.227]:6841 "EHLO e21.nc.us.ibm.com")
	by vger.kernel.org with ESMTP id <S284587AbRLETJH>;
	Wed, 5 Dec 2001 14:09:07 -0500
Date: Wed, 05 Dec 2001 11:05:29 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Larry McVoy <lm@bitmover.com>
cc: Rik van Riel <riel@conectiva.com.br>,
        Lars Brinkhoff <lars.spam@nocrew.org>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, hps@intermeta.de,
        linux-kernel@vger.kernel.org
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Message-ID: <2527982215.1007550329@mbligh.des.sequent.com>
In-Reply-To: <20011204163646.M7439@work.bitmover.com>
X-Mailer: Mulberry/2.0.8 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> > There seems to be a little misunderstanding here; from what
>> > I gathered when talking to Larry, the idea behind ccClusters
>> > is that they provide a single system image in a NUMA box, but
>> > with separated operating system kernels.
> 
> Right except NUMA is orthogonal, ccClusters work fine on a regular SMP 
> box.

Can you clarify exactly what hardware you need for ccClusters? I've heard
from some people that you need some hardware support to do remote
memory accesses, but you seem to be saying you don't ?

If I give you 16 SMP systems, each with 4 processors and a gigabit
ethernet card, and connect those ethers through a switch, would that
be sufficient hardware?
 
>> OK, then I've partially misunderstood this ... can people provide some 
>> more reference material? Please email to me, and I'll collate the results
>> back to the list (should save some traffic).
> 
> I'll try and type in a small explanation, I apologize in advance for the
> bervity, I'm under a lot of pressure on the BK front these days...
> 
> The most recent set of slides are here:
> 
>     http://www.bitmover.com/ml/slide01.html
> 
> A couple of useful papers are at
> 
>     http://www.bitmover.com/llnl/smp.pdf
>     http://www.bitmover.com/llnl/labs.pdf
> 
> The first explains why I think fine grained multi threading is a mistake
> and the second is a paper I wrote to try and get LLNL to push for what
> I called SMP clusters (which are not a cluster of SMPs, they are a 
> cluster of operating system instances on a single SMP).

OK, I went and read those, and I think I now understand the general 
concept of what you're advocating. Before we get into too many low-level
technical discussions, if we can step back for a second and take the
50,000 ft view ....

(I've said "we" quite a bit below, where maybe I should sometimes say "I". 
I think my views are very roughly representative of *some* other NUMA people, 
but I have no right whatsoever to claim that, and I'm not really that sure of it 
either. Lots of things below shamelessly stolen from people who've been kind
enough to explain such concepts to me in the past).

I think what you're trying to get to is actually quite similar to where we're
trying to get to, you're just going up the mountain from the other side than
the point we chose to start at. I'll leave aside the discussion for the moment
of which face is easier to scale, I just want to point out that we're actually
going to more or less the same place.

We're both trying to present a single system image to the application 
by coupling a bunch of SMP systems together. To take an example of
a NUMA architecture (the one I know reasonably well) the Sequent / IBM 
NUMA-Q hardware architecture is basically a bunch of 4 way PCs with a big 
fat  interconnect slung down the back of them (I'm sure I'll get hung, drawn
and quartered by marketing for that. They're *really* nice PCs. The interconnect
is *very* quick. And there's some really nice cache coherency hardware, etc.
But basically they're just 4 way SMPs + interconnect). 

(I'm going to call each of the SMP units a node) You might choose to to do some 
of the memory transfers between nodes in software - we chose to do it in
hardware. You might choose to have distinct physical memory maps, we chose
to have a unified one. That's more of a detail - the concept's still the same.

We started out with the concept of a single OS image from a single instance of
the kernel (like a really big SMP box), and we break things down as need be. 
As I understand what you're advocating, you want to start out with multiple
instances of the kernel and build them back into one single OS image.

If you'll forgive me being rather woolly and simplistic for the minute (and don't
try to analyse this analogy to death), imagine the OS as two layers:

1) an upper layer doing things like system calls, etc. that provide a user level API
2) a lower layer doing things like page cache, disk IO, etc.

As I understand this, both of us will have the upper layer as a single instance
across the whole system. We'll start with a single instance of the lower layer,
you'll start with multiple instances. You'll presumably have to glue some bits
of that lower layer together, we'll presumably break some apart.

>From what I've read of your documents, you seem to think the only way we
can make a single OS instance scale is by introducing billions of fine-grained 
locks. I'm sure that's not *exactly* what you meant, but that's kind of how it 
comes across. Yes, there will defintely need to be some splitting up of locks.
But there are lots of other tools in the toolbox. Some things we might well do
are introduce a per-node page cache, maybe a per node dcache / inode
cache. One example we've already is have a scheduler that can be set up
with a seperate runqueue per node. And we'll replicate a copy of kernel
text to every node - processes on that node will use a local copy of the
kernel text. 

By the time we've split up a bunch of subsystems to work on a per-node
basis (with some global interactions between them) like this, it starts to look
a lot more like what you're doing with ccClusters.

Let's take an example of a bunch of statistics counters (say 200) that 
start off with a single lock covering all of them. We could break up the 
lock into 200 locks, one for each stats counter, or we could break up 
the counters into one counter per CPU with atomic update with no locking.
If you want to know the result of the counters, you read all of them and
add them together. No locking at all. In the case of many writes and few
reads, this would work much better. There are many ways to crack a nut
(or a lock).

I don't think fine-grained locking necessarily makes things slower. Done
badly, it certainly could. It could easily make things more complex, especially
if done badly. It will probably make things a little more complex, even if done
well. Personally, I believe that we can keep that managable, especially if
we're careful to actually document stuff. This means, for instance, things 
like Rick Lindsley's locking document, and actually putting some comments
against data structures saying what they're locked by! (Each is one index
into the x-map). We should avoid getting too carried away, and creating
*too* many locks - that is a danger, I agree with you there.

> The basic idea is this: if you consider the usefulness of an SMP versus a
> cluster, the main thing in favor of the SMP is
> 
>     all processes/processors can share the same memory at memory speeds.
>     I typically describe this as "all processes can mmap the same data".
>     A cluster loses here, even if it provides DSM over a high speed
>     link, it isn't going to have 200 ns caches misses, it's orders of
>     magnitude slower.  For a lot of MPI apps that doesn't matter, but
>     there are apps for which high performance shared memory is required.

I think a far more valid / interesting comparison would be NUMA vs
ccClusters rather than SMP - they're much more comparible. I don't
think anyone's advocating a 128 way SMP system (or at least I'm not).

> There are other issues like having a big fast bus, load balancing, etc.,
> but the main thing is that you can share data quickly and coherently.
> If you don't need that performance/coherency and you can afford to 
> replicate the data, a traditional cluster is a *much* cheaper and 
> easier answer.  Many problems, such as web server farms, are better
> done on Beowulf style clusters than an SMP, they will actually scale
> better.

Absolutely. For for some problems, the Beowulf style approach is much
cheaper and easier.
 
> OK, so suppose we focus on the SMP problem space.  It's a requirement
> that all the processes on all the processors need to be able to access
> memory coherently.  DSM and/or MPI isn't an answer for this problem 
> space.
> 
> The traditional way to use an SMP is to take a single OS image and 
> "thread" it such that all the CPUs can be in the OS at the same time.
> Pretty much all the data structures need to get a lock and each CPU
> takes the lock before it uses the data structure.  The limit of the
> ratio of locks to cache lines is 1:1, i.e., each cache line will need
> a lock in order to get 100% of the scaling on the system (yes, I know
> this isn't quite true but it is close and you get the idea).
> 
> Go read the "smp.pdf" paper for my reasons on why this is a bad approach,
> I'll assume for now you are willing to agree that it is for the purposes
> of discussion.
> 
> If we want to get the most use out of big SMP boxes but we also want to
> do the least amount of "damage" in the form of threading complexity in
> the source base.  This is a "have your cake and eat it too" goal, one
> that I think is eminently reachable.
> 
> So how I propose we do this is by booting multiple Linux images on
> a single box.  Each OS image owns part of the machine, 1-4 CPUs, 0 or
> more devices such as disk, ethernet, etc., part of memory.  In addition,
> all OS images share, as a page cache, part of main memory, typically
> the bulk of main memory.
> 
> The first thing to understand that the *only* way to share data is in
> memory, in the globally shared page cache.  You do not share devices,
> devices are proxied.  So if I want data from your disk or file system,
> I ask you to put it in memory and then I mmap it.  In fact, you really
> only share files and you only share them via mmap (yeah, read and write
> as well but that's the uninteresting case).
> 
> This sharing gets complex because now we have more than one OS image
> which is managing the same set of pages.  One could argue that the 
> code complexity is just as bad as a fine grained multi threaded OS
> image but that's simply incorrect.  I would hide almost 100% of this
> code in a file system, with some generic changes (as few as possible)
> in the VM system.  There are some changes in the process layer as well,
> but we'll talk about them later.
> 
> If you're sitting here thinking about all the complexity involved in
> sharing pages, it is really helpful to think about this in the following
> way (note you would not actually implement it like this in the long
> run but you could start this way):
> 
> Imagine that for any given file system there is one server OS image and N
> client os images.  Imagine that for each client, there is a proxy process
> running on behalf of the client on the server.  Sort of like NFS biods.
> Each time the client OS wants to do an mmap() it asks the proxy to do
> the mmap().  There are some corner cases but if you think about it, by
> having the proxies do the mmaps, we *know* that all the server OS data
> structures are correct.  As far as the server is concerned, the remote
> OS clients are no different than the local proxy process.  This is from
> the correctness point of view, not the performance point of view.
> 
> OK, so we've handled setting up the page tables, but we haven't handled
> page faults or pageouts.  Let's punt on pageouts for the time being,
> we can come back to that.  Let's figure out a pagefault path that will
> give correct, albeit slow, behaviour.  Suppose that when the client faults
> on a page, the client side file system sends a pagefault message to the
> proxy, the proxy faults in the page, calls a new vtop() system call to
> get the physical page, and passes that page descriptor back to the client
> side.  The client side loads up the TLB & page tables and away we go.
> Whoops, no we don't, because the remote OS could page out the page and
> the client OS will get the wrong data (think about a TLB shootdown that
> _didn't_ happen when it should have; bad bad bad).  Again, thinking 
> just from the correctness point of view, suppose the proxy mlock()ed
> the page into memory.  Now we know it is OK to load it up and use it.
> This is why I said skip pageout for now, we're not going to do them 
> to start with anyway.

That doesn't seem a million miles away from creating yourself a local memory
buffer, and then setting up the DMA engine of an interface card on a remote 
node to transfer you the data into that local buffer. Not exactly the same, 
but the concept's not all that dissimilar.

Martin.
