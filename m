Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284895AbRLFAQS>; Wed, 5 Dec 2001 19:16:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284894AbRLFAQB>; Wed, 5 Dec 2001 19:16:01 -0500
Received: from femail3.sdc1.sfba.home.com ([24.0.95.83]:59890 "EHLO
	femail3.sdc1.sfba.home.com") by vger.kernel.org with ESMTP
	id <S284879AbRLFAPj>; Wed, 5 Dec 2001 19:15:39 -0500
Content-Type: text/plain; charset=US-ASCII
From: Rob Landley <landley@trommello.org>
To: Larry McVoy <lm@bitmover.com>, "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: SMP/cc Cluster description [was Linux/Pro]
Date: Wed, 5 Dec 2001 09:23:40 -0500
X-Mailer: KMail [version 1.3.1]
Cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        hps@intermeta.de, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.33L.0112042129160.4079-100000@imladris.surriel.com> <2457910296.1007480257@mbligh.des.sequent.com> <20011204163646.M7439@work.bitmover.com>
In-Reply-To: <20011204163646.M7439@work.bitmover.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20011206001537.OPTF485.femail3.sdc1.sfba.home.com@there>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 04 December 2001 07:36 pm, Larry McVoy wrote:

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

This sounds a bit like the shared memory cluster work.  (See last month's big 
thread I had with Martin.  There's URLs on the web but my laptop's offline 
right now.  Google would know.)

If you take a beowulf style cluster, add in shared memory that can page fault 
across the network (just for explicitly shared mappings, like a networked 
shm), and a networkable sempahore implementation, you can program it a lot 
like NUMA without needing special hardware.  (Gigabit ethernet covers a lot 
of sins, and Myrinet's still relatively cheap compared to most 
supercomputers.)  You can even do a cheesy implementation of everything in 
userspace if you're not trying to scale it very far (although that largely 
wastes the point of myrinet, at least).

Some people have even been working on migrating processes from one node to 
another to automatically load balance, although that's a bit fancier than 
I've ever bothered with.  The hard part of it all is management of the 
cluster, and that's something people have been putting a LOT of effort into 
from all directions...

> The basic idea is this: if you consider the usefulness of an SMP versus a
> cluster, the main thing in favor of the SMP is
>
>     all processes/processors can share the same memory at memory speeds.
>     I typically describe this as "all processes can mmap the same data".
>     A cluster loses here, even if it provides DSM over a high speed
>     link, it isn't going to have 200 ns caches misses, it's orders of
>     magnitude slower.  For a lot of MPI apps that doesn't matter, but
>     there are apps for which high performance shared memory is required.
>
> There are other issues like having a big fast bus, load balancing, etc.,
> but the main thing is that you can share data quickly and coherently.

10gig ethernet is supposed to be coming out in 2003, and some people have 
prototypes already.  I'm fairly certain this is faster than the current 
generations of PCI bus.  Of course throughput != latency, but Grace Hopper 
was font of carrying around 11 centimeters of wire in her knitting bag and 
calling it a nanosecond, which is where the big bucks NUMA systems have their 
problems too. :)

> If you don't need that performance/coherency and you can afford to
> replicate the data, a traditional cluster is a *much* cheaper and
> easier answer.

The amount of ram a copy of the OS takes up these days is CHEAP.  A well 
tuned system needs what, an extra 16 megs per node?  (And that includes a lot 
of squishiness for buffers you probably need per-node anyway.)  If you're 
worried about that expense, you're obviously not paying for high-end hardware 
anyway...

I've seen people trying to do spinlocks across a numa system.  Why?  Don't Do 
That Then.  Purely OS internal abstractions don't need to be shared across 
the cluster.  I can share a printer through the network right now by just 
having my app talk to the server handling it, yet people seem to be trying to 
make part of the driver for a device live on the other side of the NUMA 
machine.  Why?  (Because we can!  Doesn't make it a good idea...)

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

SMP is symmetrical.  On a truly SMP machine, there's no point in having 
multiple OS images because they're all equal cost to talk to main memory, so 
they might as well share a kernel image.  (It's read-only, there's no 
contention, they just cache it.  There may be per-CPU data structures, but 
we've got those already.)

SMP is likely to increase as die sizes shrink, because you can put 4 
processors on a chip today on PowerPC.  (This is just an alternative to 
insanely long pipelines that just start increasing latency of a pipeline 
flush.  Pentium 4 already has stages that do nothing more than transport data 
from one side of the chip to the other, that's just nuts.)  Plus more 
execution cores: An athlon currently has 3 cores, as do iTanic and Crusoe.  
Either you decouple them so they execute different stuff, or they run NOPs.  
So either way, you wind up with SMP on one die.  (You can't make chips TOO 
much smaller because it becomes less economical to cut the wafer up that 
small.  Harvesting and connecting the chips at finer granularity increases 
their cost...)

If die sizes shrink another 4 or 5 times before we hit atomic limits, we can 
fit at least 32 processors on a chip.  And then we just start increasing the 
number of layers and make 3D circuitry assuming we can deal with the heat 
problem (which people are working on: heat sinks in the middle of the chip, 
just wire around it).

THIS is why many-way SMP is interesting.  Crusoe and strongarm have the 
northbridge on die which makes this kind of thing easier (getting into shared 
L1 cache is bound to be fun), and then there's having the motherboard do SMP 
as well.  Assuming the motherboards can handle 8-way, dedicated memory 
bandwidth interconnects (like ev6), if each chip has just 8 processors, we're 
talking 64-way SMP for under $10k in a few years, meaning it'll be $2k a 
couple years after that.

There are three main reasons we haven't seen SMP take off in the past 15 
years, despite the fact there were SMP 486 motherboards back in the 80's.  
The first is that nothing microsoft has ever put out could gracefully handle 
it (they didn't even pretend to multitask one CPU until the 90's).  The 
second is that most programmers (outside of Unix and OS/2) didn't know what a 
semaphore was before about 1998, and are just now thinking about breaking 
stuff up so portions of the program can advance asynchronously.  Third was 
that low volume is high cost, so there was a chicken and egg problem on the 
hardware side.

Now the programming's gradually starting to get there, and we've got our 
first SMP athlon boards priced so a hobbyist can save up for one.  I don't 
think it's going to decrease in the future...

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
>
> OK, so start throwing stones at this.  Once we have a memory model that
> works, I'll go through the process model.

If you only worry about explicitly shared memory (a multi-process model vs a 
multi-thread model), you can cheese your way out of this by mounting a 
modified network filesystem in /dev/shm if you don't mind hideously high 
latency and a central point of failure.  (The filesystem has to be able to 
initiate page invalidations on mmaped areas, but I suspect this is a problem 
somebody's already dealt with.  Haven't played with it in a while...)

Rob
