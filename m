Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261930AbTLHTvB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 14:51:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261936AbTLHTvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 14:51:01 -0500
Received: from mail6.bluewin.ch ([195.186.4.229]:25999 "EHLO mail6.bluewin.ch")
	by vger.kernel.org with ESMTP id S261930AbTLHTug (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 14:50:36 -0500
Date: Mon, 8 Dec 2003 20:49:30 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031208194930.GA8667@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="dc+cDN39EJAMEtIO"
Content-Disposition: inline
In-Reply-To: <20031208135225.GT19856@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--dc+cDN39EJAMEtIO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've been looking at this during the past few months. I will sketch
out a few of my findinds below. I can follow up with some details and
actual data if necessary.

On Mon, 08 Dec 2003 05:52:25 -0800, William Lee Irwin III wrote:
> Explicit load control is in order. 2.4 appears to work better in these
> instances because it victimizes one process at a time. It vaguely
> resembles load control with a random demotion policy (mmlist order is

Everybody I talked to seemed to assume that 2.4 does better due to the
way mapped pages are freed (i.e. swap_out in 2.4). While it is true
that the new VM as merged in 2.5.27 didn't exactly help with thrashing
performance, the main factors slowing 2.6 down were merged much later.

Have a look at the graph attached to this message to get an idea of
what I am talking about (x axis is kernel releases after 2.5.0, y axis
is time to complete each benchmark).

It is important to note that different work loads show different
thrashing behavior. Some changes in 2.5 improved one thrashing benchmark
and made another worse. However, 2.4 seems to do better than 2.6 across
the board, which suggests that some elements are in fact better for
any types of thrashing.

> Other important aspects of load control beyond the demotion policy are
> explicit suspension the execution contexts of the process address
> spaces chosen as its victims, complete eviction of the process address

I implemented suspension during memory shortage for 2.6 and I had some
code for complete eviction as well. It definitely helped for some
benchmarks. There's one problem, though: Latency. If a machine is
thrashing, a sys admin won't appreciate that her shell is suspended
when she tries to log in to correct the problem. I have some simple
criteria for selecting a process to suspend, but it's hard to get it
right every time (kind of like the OOM killer, although with smaller
damage for bad decisions).

For workstations and most servers latency is so important compared to
throughput that I began to wonder whether implementing suspension was
actually worth it. After benchmarking 2.4 vs 2.6, though, I suspected
that there must be plenty of room for improvement _before_ such drastic
measures are necessary. It makes little sense to add suspension to 2.6
if performance can be improved _without_ hurting latency. That's why
I shelved my work on suspension to find out and document when exactly
performance went down during 2.5.

> 2.4 does not do any of this.
> 
> The effect of not suspending the execution contexts of the demoted
> process address spaces is that the victimized execution contexts thrash
> while trying to reload the memory they need to execute. The effect of
> incomplete demotion is essentially livelock under sufficient stress.
> Its memory scheduling to what extent it has it is RR and hence fair,
> but the various caveats above justify "does not do any of this",
> particularly incomplete demotion.

One thing you can observe with 2.4 is that one process may force another
process out. Say you have several instances of the same program which
all have the same working set size (i.e.  requirements, not RSS) and
a constant rate of memory references in the code. If their current RSS
differ then some take more major faults and spend more time blocked than
others. In a thrashing situation, you can see the small RSSs shrink
to virtually zero, while the largest RSS will grow even further --
the thrashing processes are stealing each other's pages while the one
which hardly ever faults keeps its complete working set in RAM. Bad for
fairness, but can help throughput quite a bit. This effect is harder
to trigger in 2.6.

> So I predict that a true load control mechanism and policy would be
> both an improvement over 2.4 and would correct 2.6 regressions vs. 2.4
> on underprovisioned machines. For now, we lack an implementation.

I doubt that you can get performance anywhere near 2.4 just by adding
load control to 2.6 unless you measure throughput and nothing else --
otherwise latency will kill you. I am convinced the key is not in
_adding_ stuff, but _fixing_ what we have.

IMO the question is: How much do we care? Machines with tight memory are
not necessarily very concerned about paging (e.g. PDAs), and serious
servers rarely operate under such conditions: Admins tend to add RAM
when the paging load is significant.

If you don't care _that_ much about thrashing in Linux, just tell
people to buy more RAM. Computers are cheap, RAM even more so, 64 bit
becomes affordable, and heavy paging sucks no matter how good a paging
mechanism is.

If you care enough to spend resources to address the problem, look at
the major regressions in 2.5 and find out where they were a consequence
of a deliberate trade-off decision and where it was an oversight which
can be fixed or mitigated without sacrificing what was gained through
the respective changes in 2.5. Obviously, performing regular testing
with thrashing benchmarks would make lasting major regressions like
those in the 2.5 development series much less likely in the future.

Additional load control mechanisms create new problems (latency,
increased complexity), so I think they should be a last resort, not
some method to paper over deficiencies elsewhere in the kernel.

Roger

--dc+cDN39EJAMEtIO
Content-Type: image/png
Content-Disposition: attachment; filename="plot.png"
Content-Transfer-Encoding: base64

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

--dc+cDN39EJAMEtIO--
