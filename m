Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263002AbTLHUtM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 15:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262321AbTLHUtM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 15:49:12 -0500
Received: from holomorphy.com ([199.26.172.102]:50653 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262328AbTLHUsx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 15:48:53 -0500
Date: Mon, 8 Dec 2003 12:48:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031208204817.GA19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208194930.GA8667@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Dec 2003 05:52:25 -0800, William Lee Irwin III wrote:
>> Explicit load control is in order. 2.4 appears to work better in these
>> instances because it victimizes one process at a time. It vaguely
>> resembles load control with a random demotion policy (mmlist order is

On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> Everybody I talked to seemed to assume that 2.4 does better due to the
> way mapped pages are freed (i.e. swap_out in 2.4). While it is true
> that the new VM as merged in 2.5.27 didn't exactly help with thrashing
> performance, the main factors slowing 2.6 down were merged much later.

What kinds of factors are these? How did you find these factors? When
were these factors introduced?


On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> Have a look at the graph attached to this message to get an idea of
> what I am talking about (x axis is kernel releases after 2.5.0, y axis
> is time to complete each benchmark).

On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> It is important to note that different work loads show different
> thrashing behavior. Some changes in 2.5 improved one thrashing benchmark
> and made another worse. However, 2.4 seems to do better than 2.6 across
> the board, which suggests that some elements are in fact better for
> any types of thrashing.

qsbench I'd pretty much ignore except as a control case, since there's
nothing to do with a single process but let it thrash.


On Mon, 08 Dec 2003 05:52:25 -0800, William Lee Irwin III wrote:
>> Other important aspects of load control beyond the demotion policy are
>> explicit suspension the execution contexts of the process address
>> spaces chosen as its victims, complete eviction of the process address

On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> I implemented suspension during memory shortage for 2.6 and I had some
> code for complete eviction as well. It definitely helped for some
> benchmarks. There's one problem, though: Latency. If a machine is
> thrashing, a sys admin won't appreciate that her shell is suspended
> when she tries to log in to correct the problem. I have some simple
> criteria for selecting a process to suspend, but it's hard to get it
> right every time (kind of like the OOM killer, although with smaller
> damage for bad decisions).

I'd be interested in seeing the specific criteria used, since the
policy can strongly influence performance. Some of the most obvious
policies do worse than random.


On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> For workstations and most servers latency is so important compared to
> throughput that I began to wonder whether implementing suspension was
> actually worth it. After benchmarking 2.4 vs 2.6, though, I suspected
> that there must be plenty of room for improvement _before_ such drastic
> measures are necessary. It makes little sense to add suspension to 2.6
> if performance can be improved _without_ hurting latency. That's why
> I shelved my work on suspension to find out and document when exactly
> performance went down during 2.5.

Ideally, the targets for suspension and complete eviction would be
background tasks that aren't going to demand memory in the near future.
Unfortunately that algorithm appears to require an oracle to implement.
Also, the best criteria as I know of them are somewhat counterintuitive,
so I'd like to be sure they were tried.


On Mon, 08 Dec 2003 05:52:25 -0800, William Lee Irwin III wrote:
>> 2.4 does not do any of this.
>> The effect of not suspending the execution contexts of the demoted
>> process address spaces is that the victimized execution contexts thrash
>> while trying to reload the memory they need to execute. The effect of
>> incomplete demotion is essentially livelock under sufficient stress.
>> Its memory scheduling to what extent it has it is RR and hence fair,
>> but the various caveats above justify "does not do any of this",
>> particularly incomplete demotion.

On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> One thing you can observe with 2.4 is that one process may force another
> process out. Say you have several instances of the same program which
> all have the same working set size (i.e.  requirements, not RSS) and
> a constant rate of memory references in the code. If their current RSS
> differ then some take more major faults and spend more time blocked than
> others. In a thrashing situation, you can see the small RSSs shrink
> to virtually zero, while the largest RSS will grow even further --
> the thrashing processes are stealing each other's pages while the one
> which hardly ever faults keeps its complete working set in RAM. Bad for
> fairness, but can help throughput quite a bit. This effect is harder
> to trigger in 2.6.

There was a study conducted by someone involved with CKRM (included in
some joint paper with the rest of the team) that actually charted out
this property of 2.6 in terms of either faults taken over time or RSS
over time, but compared it to a modified page replacement policy that
actually had it to a greater degree than stock 2.6 instead of 2.4.


On Mon, 08 Dec 2003 05:52:25 -0800, William Lee Irwin III wrote:
>> So I predict that a true load control mechanism and policy would be
>> both an improvement over 2.4 and would correct 2.6 regressions vs. 2.4
>> on underprovisioned machines. For now, we lack an implementation.

On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> I doubt that you can get performance anywhere near 2.4 just by adding
> load control to 2.6 unless you measure throughput and nothing else --
> otherwise latency will kill you. I am convinced the key is not in
> _adding_ stuff, but _fixing_ what we have.

A small problem with that kind of argument is that it's assuming the
existence of some accumulation of small regressions that haven't proven
to exist (or have they?), where the kind of a priori argument I've made
only needs to rely on the properties of the algorithms. But neither can
actually provide a guarantee of results without testing. I suppose one
point in favor of my "grab this tool off the shelf" approach is that
there is quite a bit of history behind the methods and that they are
well-understood.


On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> IMO the question is: How much do we care? Machines with tight memory are
> not necessarily very concerned about paging (e.g. PDAs), and serious
> servers rarely operate under such conditions: Admins tend to add RAM
> when the paging load is significant.

The question is not if we care, but if we care about others. Economies
aren't as kind to all users as they are to us


On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> If you don't care _that_ much about thrashing in Linux, just tell
> people to buy more RAM. Computers are cheap, RAM even more so, 64 bit
> becomes affordable, and heavy paging sucks no matter how good a paging
> mechanism is.

If I took this kind of argument seriously I'd be telling people to go
shopping for new devices every time they run into a driver problem. I'm
actually rather annoyed with hearing this line of reasoning repeated to
many so many times over, and I'd appreciate not hearing it ever again
(offenders, you know who you are).

The issue at hand is improving how the kernel behaves on specific
hardware configurations; the fact other hardware configurations exist
is irrelevant.


On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> If you care enough to spend resources to address the problem, look at
> the major regressions in 2.5 and find out where they were a consequence
> of a deliberate trade-off decision and where it was an oversight which
> can be fixed or mitigated without sacrificing what was gained through
> the respective changes in 2.5. Obviously, performing regular testing
> with thrashing benchmarks would make lasting major regressions like
> those in the 2.5 development series much less likely in the future.

Yes, this does need to be done more regularly. c.f. the min_free_kb
tuning problem Matt Mackall and I identified.


On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> Additional load control mechanisms create new problems (latency,
> increased complexity), so I think they should be a last resort, not
> some method to paper over deficiencies elsewhere in the kernel.

Who could disagree with this without looking ridiculous?

Methods of last resort are not necessarily unavoidable; the OOM killer
is an example of one that isn't avoidable. The issue is less clear cut
here, since the effect is limited to degraded performance on a limited
range of machines. But I would prefer not to send an "FOAD" message to
the users of older hardware or users who can't afford fast hardware.

The assumption methods of last resort create more problems than they
solve appears to be based on the notion that they'll be used for more
than methods of last resort. They're meant to handle the specific cases
where they are beneficial, not infect the common case with behavior
that's only appropriate for underpowered machines or other bogosity.
That is, it should teach the kernel how to behave in the new situation
where we want it to behave well, not change its behavior where it
already behaves well.


-- wli
