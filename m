Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265976AbTLIPNC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 Dec 2003 10:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265977AbTLIPNC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 Dec 2003 10:13:02 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:29928 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S265976AbTLIPMm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 Dec 2003 10:12:42 -0500
Date: Tue, 9 Dec 2003 16:11:03 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031209151103.GA4837@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch> <20031209040501.GE19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209040501.GE19856@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Dec 2003 20:05:01 -0800, William Lee Irwin III wrote:
> > because variance in thrashing benchmarks is pretty bad). The real stuff
> > is quite detailed but too large to post on the list.
> 
> Okay, I'm interested in getting my hands on this however you can get it
> to me.

http://hellgate.ch/bench/thrash.tar.gz

The tar contains one postscript plot file and three data files:
{kbuild,efax,qsbench}.dat. Numbers are execution times in seconds. The
first column is the average of each row, and the values of each row
are sorted in ascending order. Other than that, it's the raw data.

The kernels were not tested in order, so it's definitely not the hardware
that's been deteriorating over time.

I repeated some tests that looked like mistakes: In 2.5.32, for instance,
it seems odd that both kbuild and qsbench are slower but efax isn't. I
believe the data is accurate, but I can do reruns upon request.

A fourth file, plot.ps, contains the graphs I use right now: You can
see how both average execution time and variance have grown from 2.5.0
and 2.6.0-test11. The graph is precise enough to determine the kernel
release that caused a regression.

The more fine-grained work is not complete and I'm not sure it ever
will be. Some _preliminary_ results (i.e. take with a grain of salt):

The regression for kbuild in 2.5.48 was caused by a patch titled "better
inode reclaim balancing". In 2.5.49, "strengthen the `incremental
min' logic in the page". In 2.6.0-test3 (aka 2.6.78), it's a subtle
interaction between "fix kswapd throttling" and "decaying average of
zone pressure" -- IIRC reverting the former gains nothing unless you
also revert the latter. I'd have to dig through my notes.

> On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> > Define "performance". My goal was to improve both responsiveness and
> > throughput of the system under extreme memory pressure. That also
> > meant that I wasn't interested in better throughput if latency got
> > even worse.
> 
> It was defined in two different ways: cpu utilization (inverse of iowait)
> and multiprogramming level (how many tasks it could avoid suspending).

Yeah, that's the classic. It _is_ throughput. Unless you have task
priorities (i.e. eye candy or SETI@home competing for cycles), CPU
utilization is an excellent approximation for throughput. And the
benefit of maintaining a high level of multiprogramming is that you
have a better chance to have a runnable process at any time, meaning
better CPU utilization meaning higher throughput.

The classic strategies based on these criteria work for transaction and
batch systems. They are all but useless, though, for a workstation and
even most modern servers, due to assumptions that are incorrect today
(remember all the degrees of freedom a scheduler had 30 years ago)
and additional factors that only became crucial in the past few decades
(latency again).

> > - process size: I favored stunning processes with large RSS because
> >   for my scenario that described the culprits quite well and left the
> >   interactive stuff alone.
> 
> Demoting the largest task is one that does worse than random.

We only know that to be true for irrelevant optimization criteria.

> > - fault frequency, I/O requests: When the paging disk is the bottleneck,
> >   it might be sensible to stun a process that produces lots of faults
> >   or does a lot of disk I/O. If there is an easy way to get that data
> >   then I missed it.
> 
> Like the PFF bits for WS?

Yup. PFF doesn't cover all disk I/O, though. Suspending a process that
is I/O bound even with a low PFF improves thrashing performance as well,
because disk I/O is the bottleneck.

> > Heh. Did you look at the graph in my previous message? Yes, there are
> > several, independant regressions. What we don't know is which ones were
> > unavoidable. For instance, the regression in 2.5.27 is quite possibly a
> > necessary consequence of the new pageout mechanism and the benefits in
> > upward scalability may well outweigh the costs for the low-end user.
> 
> I don't see other kernels to compare it to. I guess you can use earlier
> versions of itself.

You don't need anything to compare it to. You can investigate the
performance regression and determine whether it was a logical consequence
of the intended change in behavior.

Suppose you found that the problem in 2.5.27 is that shared pages are
unmapped too quickly -- that would be easy to fix without affecting
the benefits of the new VM. I think the more likely candidates for
improvements are later in 2.5, though.

> Top 0.001%? For expanded range, both endpoints matter. My notion of
> scalability is running like greased lightning (compared to other OS's)
> on everything from some ancient toaster with a 0.1MHz cpu and 256KB RAM
> to a 16384x/16PB superdupercomputer.

Well, that's nice. I agree. IIRC, though, each major release had more
demanding minimum requirements (in terms of RAM). The range covered
has been growing only because upward scalability grew faster. I can't
help but notice that some of your statements sound a lot like wishful
thinking.

> > No. Bad example. For starters, new devices are more likely to have driver
> > problems, so your advice would be dubious even if they had the money :-P.
> > The argument I hear for the regressions is that 2.6 is more scalable
> > on high-end machines now and we just made a trade-off. It has happened
> > before. Linux 1.x didn't have the hardware requirements of 2.4.
> 
> No! No! NO!!!
> 
> (a) buying a G3 will not make my sun3 boot Linux
> (b) buying an SS1 will not make my Decstation 5000/200's PMAD-AA
> 	driver work
> (c) buying another multia will not make my multia stop deadlocking
> 	while swapping over NFS
> 
> No matter how many pieces of hardware you buy, the original one still
> isn't driven correctly by the software. Hardware *NEVER* fixes software.

Look, I became the maintainer of via-rhine because nobody else wanted to
fix the driver for a very common, but barely documented piece of
cheap hardware. People were just told to buy another cheap card. That's
the reality of Linux.

Don't forget what we are talking about, though. Once you are seriously
tight on memory, you can only mitigate the damage in software, the only
solution is to add more RAM. Thrashing is not a bug like a broken driver.
I am currently writing a paper on the subject, and the gist of it will
likely be that we should try to prevent thrashing from happening as
long as possible (with good page replacement, I/O scheduling, etc.),
but when it's inevitable we're pretty much done for. Load control may
or may not be worth adding, but it only helps in some special cases
and does not seem clearly beneficial in general-purpose systems.

> This was a bit easier than that; the boot-time default was 1MB regardless
> of the size of RAM; akpm picked some scaling algorithm out of a hat and
> it pretty much got solved as it shrank with memory.

With all due respect for akpm's hat, sometimes I wish we had some good
heuristics for this stuff.

> > 2.6 will happily spend a lot of time in I/O wait in a situation where
> > 2.4 will cruise through the task without a hitch.
> >
> > I'm all for adding load control to deal with heavy thrashing that can't
> > be handled any other way. But I am firmly opposed to pretending that
> > it is a solution for the common case.
> 
> The common case is pretty much zero or slim overcommitment these days.
> The case I have in mind is pretty much 10x RAM committed. (Sum of WSS's,
> not non-overcommit-related.)

So you want to help people who for some reason _have_ to run several
_batch_ jobs _concurrently_ (otherwise load control is ineffective)
on a low-end machine to result in a 10x overcommit system? Why don't
we buy those two or three guys a DIMM each?

I'm afraid you have a solution in search of a problem. Nobody runs a
10x overcommit system. And if they did, they would find it doesn't work
well with 2.4, either, so no one will complain about a regression. What
does happen, though, is that people go close to the limit of what
their low-end hardware supports, which will work perfectly with 2.4
and collapse with 2.6.

The real problem, the one many people will hit, the one the very
complaint that started this thread was about, is light and medium
overcommit. And load control is not the answer to that.

Roger
