Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbTLIEFl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 23:05:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262765AbTLIEFl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 23:05:41 -0500
Received: from holomorphy.com ([199.26.172.102]:31454 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262758AbTLIEFc (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 23:05:32 -0500
Date: Mon, 8 Dec 2003 20:05:01 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031209040501.GE19856@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	rl@hellgate.ch, Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com> <20031209002745.GB8667@k3.hellgate.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031209002745.GB8667@k3.hellgate.ch>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> What kinds of factors are these? How did you find these factors? When
>> were these factors introduced?

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> The relevant changes are all over the place, factors other than the
> pageout mechanism affect thrashing. I haven't identified all of them,
> though. I work on it occasionally.
> When I realized what had happened in 2.5 (took a while), I went for a
> tedious, systematic approach. It started with benchmarks: 3 benchmarks
> x some 85 kernels x 10 runs each. The graph you saw in my previous
> message represents a few hundred hours worth of benchmarking (required
> because variance in thrashing benchmarks is pretty bad). The real stuff
> is quite detailed but too large to post on the list.

Okay, I'm interested in getting my hands on this however you can get it
to me.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> qsbench I'd pretty much ignore except as a control case, since there's
>> nothing to do with a single process but let it thrash.

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> I like to keep qsbench around for a number of reasons: It's the benchmark
> where 2.6 looks best (i.e. less bad). I can't rule out that somewhere
> somebody has a real work load of that type. And it is an interesting
> contrast to the real world compile benchmarks I care about.

I won't debate that; however, as far as load control goes, there's
nothing to do.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> I'd be interested in seeing the specific criteria used, since the
>> policy can strongly influence performance. Some of the most obvious
>> policies do worse than random.

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> Define "performance". My goal was to improve both responsiveness and
> throughput of the system under extreme memory pressure. That also
> meant that I wasn't interested in better throughput if latency got
> even worse.

It was defined in two different ways: cpu utilization (inverse of iowait)
and multiprogramming level (how many tasks it could avoid suspending).


On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> So what are some potential criteria?
> - process owner: sshd runs often as root. You don't want to stun that.
>   OTOH, a sys admin will usually log in as a normal user before su'ing
>   to root. So stunning non-root processes isn't a clear winner, either.

That's a method I haven't even heard of. I'd be wary of this; there are
a lot of daemons that might as well be swapped as they almost never run
and aren't latency-sensitive when they do.


On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> - process size: I favored stunning processes with large RSS because
>   for my scenario that described the culprits quite well and left the
>   interactive stuff alone.

Demoting the largest task is one that does worse than random.


On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> - interactivity: Avoiding to stun tasks the scheduler considers
>   interactive was a no-brainer.

An odd result was that since the ancient kernels didn't have threads,
their mm's had unique timeslices etc. Largest remaining quantum is one
of the three equivalent "empirically best" policies.


On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> - nice value: A niced process tends to be a batch process. Stun.
> - time: OOM kill doesn't want to take down long running processes
>   because of the work that is lost. For stunning, I don't care.
>   In fact, they are probably batch processes, so stun them.

These sound unusual, but innocuous.


On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> - fault frequency, I/O requests: When the paging disk is the bottleneck,
>   it might be sensible to stun a process that produces lots of faults
>   or does a lot of disk I/O. If there is an easy way to get that data
>   then I missed it.

Like the PFF bits for WS?


On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> There are certainly more, but that's what I can think of off the top
> of my head. I did note your reference to Carr's thesis (which I'm not
> familiar with), but like most papers I've seen on the subject it seems
> to focus on throughput. That's special-casing for batch processing or
> transaction systems, however; on a general-purpose computer, throughput
> means nothing if latency goes down the tube.

Multiprogramming level and cpu utilization seemed to be more oriented
toward concurrency than either throughput or latency. What exactly that's
worth I'm not entirely sure.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> Also, the best criteria as I know of them are somewhat counterintuitive,
>> so I'd like to be sure they were tried.

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> Again, best for what?

Cpu utilization, a.k.a. minimizing iowait.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> A small problem with that kind of argument is that it's assuming the
>> existence of some accumulation of small regressions that haven't proven
>> to exist (or have they?), where the kind of a priori argument I've made

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> Heh. Did you look at the graph in my previous message? Yes, there are
> several, independant regressions. What we don't know is which ones were
> unavoidable. For instance, the regression in 2.5.27 is quite possibly a
> necessary consequence of the new pageout mechanism and the benefits in
> upward scalability may well outweigh the costs for the low-end user.

I don't see other kernels to compare it to. I guess you can use earlier
versions of itself.


On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> If we accept the notion that we don't care about what we can't measure
> (remember the interactivity debates?) and since nobody tested regularly
> for thrashing behavior, it seems quite likely that at least some of
> the regressions can be fixed, maybe at a slight cost in performance
> elsewhere, maybe not even that.
> There should be plenty of room for improvement: We are not talking 10%
> or 20%, but factors of 3 and more.

They should probably get cleaned up. Where are your benchmarks?


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>>                          ...                             I suppose one
>> point in favor of my "grab this tool off the shelf" approach is that
>> there is quite a bit of history behind the methods and that they are
>> well-understood.

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> I know I sound like a broken record, but I have one problem with
> the off-the-shelf solutions I've found so far: They try to maximize
> throughput. They don't care about latency. I do.

I have a vague notion we're thinking of different cases. What kinds of
overcommitment levels are you thinking of?


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> The question is not if we care, but if we care about others. Economies
>> aren't as kind to all users as they are to us

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> Right. But kernel hackers tend to work for companies that don't make
> their money by helping those who don't have any. And before you call
> me a cynic, look at the resources that go into making Linux capable of
> running on the top 0.something percent of machines and compare that to
> the interest with which this and similar threads have been received. I
> made my observation based on experience, not personal preference.
> That said, it is a fact that thrashing is not the hot issue it was
> 35 years ago, although the hardware (growing access gap RAM/disk)
> and usage patterns (latency matters a lot more, load is unpredictable
> and exogenous for the kernel) should have made the problem worse. The
> classic solutions are pretty much unworkable today and in most cases
> there is one economic solution which is indeed to throw more RAM at it.

Top 0.001%? For expanded range, both endpoints matter. My notion of
scalability is running like greased lightning (compared to other OS's)
on everything from some ancient toaster with a 0.1MHz cpu and 256KB RAM
to a 16384x/16PB superdupercomputer.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> If I took this kind of argument seriously I'd be telling people to go
>> shopping for new devices every time they run into a driver problem. I'm

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> No. Bad example. For starters, new devices are more likely to have driver
> problems, so your advice would be dubious even if they had the money :-P.
> The argument I hear for the regressions is that 2.6 is more scalable
> on high-end machines now and we just made a trade-off. It has happened
> before. Linux 1.x didn't have the hardware requirements of 2.4.

No! No! NO!!!

(a) buying a G3 will not make my sun3 boot Linux
(b) buying an SS1 will not make my Decstation 5000/200's PMAD-AA
	driver work
(c) buying another multia will not make my multia stop deadlocking
	while swapping over NFS

No matter how many pieces of hardware you buy, the original one still
isn't driven correctly by the software. Hardware *NEVER* fixes software.


On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> The point I was trying to make with regard to thrashing was that
> I suspect it was written off as an inevitable trade-off too early.
> I believe that some of the regressions can be fixed without losing the
> gains in upward scalability _if_ we find the resources to do it.
> Quite frankly, playing with the suspension code was a lot more fun than
> investigating regressions in other people's work. But I hated the idea
> that Linux fails so miserably now where it used to do so well. At the
> very least I wanted to be sure that it was forced collateral damage
> and not just an oversight or bad tuning. Clearly, I do care.

They should get cleaned up; start sending data over.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> The issue at hand is improving how the kernel behaves on specific
>> hardware configurations; the fact other hardware configurations exist
>> is irrelevant.

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> Why do you make me remind you that we live in a world with resource
> constraints? What _is_ relevant is where the resources to do the work
> come from, which is a non-trivial problem if the work is to benefit
> people who don't have the money to buy more RAM. Just saying that it's
> unacceptable to screw over those with low-end hardware won't help anybody
> :-). If you are volunteering to help out, though, more power to you.

It's unlikely I'll have any trouble coughing up code.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> Yes, this does need to be done more regularly. c.f. the min_free_kb
>> tuning problem Matt Mackall and I identified.

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> Well, tuning problems always make me want to try genetic algorithms.
> Regression testing would be much easier. Just run all benchmarks for
> every new kernel. Update chart. Done. ... It's scriptable even.

This was a bit easier than that; the boot-time default was 1MB regardless
of the size of RAM; akpm picked some scaling algorithm out of a hat and
it pretty much got solved as it shrank with memory.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> Who could disagree with this without looking ridiculous?

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> Heh. It was carefully worded that way <g>. Seriously, though, it's not
> as ridiculous as it may seem. The problems we need to address are not
> even on the map for the classic papers I have seen on the subject. They
> suggest working sets or some sort of abstract load control, but 2.6
> has problems that are very specific to that kernel and its mechanisms.
> There's no elegant, proven standard algorithm to solve those problems
> for us.

WS had its own load control bundled with it. AIUI most replacement
algorithms need a load control tailored to them (some seem to do okay
with an arbitrary choice), so there's some synthesis involved.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> Methods of last resort are not necessarily unavoidable; the OOM killer
>> is an example of one that isn't avoidable. The issue is less clear cut

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> That's debatable. Funny that you should take that example.

Not really. e.g. -aa's OOM killer just uses a trivial policy that shoots
the requesting task. Eliminating it entirely is theoretically possible
with ridiculous amounts of accounting, but I'm relatively certain it's
infeasible to implement.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> The assumption methods of last resort create more problems than they
>> solve appears to be based on the notion that they'll be used for more
>> than methods of last resort. They're meant to handle the specific cases

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> No. My beef with load control is that once it's there people will say
> "See? Performance is back!" and whatever incentive there was to fix the
> real problems is gone. Which I could accept if it wasn't for the fact
> that a load control solution is always inferior to other improvements
> because of the massive latency increase.

I think we have vastly different levels of overcommitment in mind.


On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
>> where they are beneficial, not infect the common case with behavior
>> that's only appropriate for underpowered machines or other bogosity.
>> That is, it should teach the kernel how to behave in the new situation
>> where we want it to behave well, not change its behavior where it
>> already behaves well.

On Tue, Dec 09, 2003 at 01:27:45AM +0100, Roger Luethi wrote:
> Alright. One more thing: Thrashing is not a clear cut system state. You
> don't want to change behavior when it was doing well, so you need to
> be cautious about your trigger. Which means it will often not fire
> for border cases, that is light thrashing. I didn't do a survey, but
> I suspect that light thrashing (where there's just not quite enough
> memory) is much more common than the heavy variant. Now guess what?
> The 2.6 performance for light thrashing is absolutely abysmal. In fact
> 2.6 will happily spend a lot of time in I/O wait in a situation where
> 2.4 will cruise through the task without a hitch.
> I'm all for adding load control to deal with heavy thrashing that can't
> be handled any other way. But I am firmly opposed to pretending that
> it is a solution for the common case.

The common case is pretty much zero or slim overcommitment these days.
The case I have in mind is pretty much 10x RAM committed. (Sum of WSS's,
not non-overcommit-related.)


-- wli
