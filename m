Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262128AbTLIA3P (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 19:29:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262131AbTLIA3P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 19:29:15 -0500
Received: from mail1.bluewin.ch ([195.186.1.74]:36993 "EHLO mail1.bluewin.ch")
	by vger.kernel.org with ESMTP id S262128AbTLIA26 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 19:28:58 -0500
Date: Tue, 9 Dec 2003 01:27:45 +0100
From: Roger Luethi <rl@hellgate.ch>
To: William Lee Irwin III <wli@holomorphy.com>,
       Con Kolivas <kernel@kolivas.org>,
       Chris Vine <chris@cvine.freeserve.co.uk>,
       Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
       "Martin J. Bligh" <mbligh@aracnet.com>
Subject: Re: 2.6.0-test9 - poor swap performance on low end machines
Message-ID: <20031209002745.GB8667@k3.hellgate.ch>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Con Kolivas <kernel@kolivas.org>,
	Chris Vine <chris@cvine.freeserve.co.uk>,
	Rik van Riel <riel@redhat.com>, linux-kernel@vger.kernel.org,
	"Martin J. Bligh" <mbligh@aracnet.com>
References: <Pine.LNX.4.44.0310302256110.22312-100000@chimarrao.boston.redhat.com> <200311031148.40242.kernel@kolivas.org> <200311032113.14462.chris@cvine.freeserve.co.uk> <200311041355.08731.kernel@kolivas.org> <20031208135225.GT19856@holomorphy.com> <20031208194930.GA8667@k3.hellgate.ch> <20031208204817.GA19856@holomorphy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031208204817.GA19856@holomorphy.com>
X-Operating-System: Linux 2.6.0-test11 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 08 Dec 2003 12:48:17 -0800, William Lee Irwin III wrote:
> On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> > Everybody I talked to seemed to assume that 2.4 does better due to the
> > way mapped pages are freed (i.e. swap_out in 2.4). While it is true
> > that the new VM as merged in 2.5.27 didn't exactly help with thrashing
> > performance, the main factors slowing 2.6 down were merged much later.
> 
> What kinds of factors are these? How did you find these factors? When
> were these factors introduced?

The relevant changes are all over the place, factors other than the
pageout mechanism affect thrashing. I haven't identified all of them,
though. I work on it occasionally.

When I realized what had happened in 2.5 (took a while), I went for a
tedious, systematic approach. It started with benchmarks: 3 benchmarks
x some 85 kernels x 10 runs each. The graph you saw in my previous
message represents a few hundred hours worth of benchmarking (required
because variance in thrashing benchmarks is pretty bad). The real stuff
is quite detailed but too large to post on the list.

I scanned the resulting data for significant performance changes. For
some of them, I used the Changelog and -- if necessary -- a binary
search to nail down the patch set that caused the regression.

The next step would be to find out whether the regression was "necessary"
or not. Problem is, ten or twenty kernel releases later, you can't easily
revert a patch and it's not always obvious which regression was fixed by
the occasional performance improvement in a graph.

So what it boils down to quite often is this: Figure out what the
patch intended to do, find out if it's still slowing down recent test
kernels, then try to achieve the same without causing the regression in
2.6.0-test11. I didn't have much time to spend on this so far, and the
original patch authors would be much more qualified to do this anyway.

> qsbench I'd pretty much ignore except as a control case, since there's
> nothing to do with a single process but let it thrash.

I like to keep qsbench around for a number of reasons: It's the benchmark
where 2.6 looks best (i.e. less bad). I can't rule out that somewhere
somebody has a real work load of that type. And it is an interesting
contrast to the real world compile benchmarks I care about.

> > right every time (kind of like the OOM killer, although with smaller
> > damage for bad decisions).
> 
> I'd be interested in seeing the specific criteria used, since the
> policy can strongly influence performance. Some of the most obvious
> policies do worse than random.

Define "performance". My goal was to improve both responsiveness and
throughput of the system under extreme memory pressure. That also
meant that I wasn't interested in better throughput if latency got
even worse.

I used a modified version of badness in oom_kill. I didn't put too
much effort into it, but I could explain the reasoning behind the
changes. I had a bunch of batch processes thrashing and I wanted to see
them selected and not the sshd or the login shell. It worked reasonably
well for me.

/*
 * Resident memory size of the process is the basis for the badness.
 */
points = p->mm->rss;

/*
 * CPU time is in seconds and run time is in minutes. There is no
 * particular reason for this other than that it turned out to work
 * very well in practice.
 */
cpu_time = (p->utime + p->stime) >> (SHIFT_HZ + 3);
run_time = (get_jiffies_64() - p->start_time) >> (SHIFT_HZ + 10);

points *= int_sqrt(cpu_time);
points *= int_sqrt(int_sqrt(run_time));

/*
 * Niced processes are most likely less important.
 */
if (task_nice(p) > 0)
        points *= 4;

/*
 * Keep interactive processes around.
 */
if (task_interactive(p))
        points /= 4;

/*
 * Superuser processes are usually more important, so we make it
 * less likely that we kill those.
 */
if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_ADMIN) ||
                        p->uid == 0 || p->euid == 0)
        points /= 2;

/*
 * We don't want to kill a process with direct hardware access.
 * Not only could that mess up the hardware, but usually users
 * tend to only have this flag set on applications they think
 * of as important.
 */
if (cap_t(p->cap_effective) & CAP_TO_MASK(CAP_SYS_RAWIO))
        points /= 2;

> Ideally, the targets for suspension and complete eviction would be
> background tasks that aren't going to demand memory in the near future.

You lost me there. If I knew of a background task that it was about to
demand more memory in the near future when memory is very tight anyway,
that would be the first process I'd suspend and evict before it gets
a chance to make matters worse.

So what are some potential criteria?

- process owner: sshd runs often as root. You don't want to stun that.
  OTOH, a sys admin will usually log in as a normal user before su'ing
  to root. So stunning non-root processes isn't a clear winner, either.

- process size: I favored stunning processes with large RSS because
  for my scenario that described the culprits quite well and left the
  interactive stuff alone.

- interactivity: Avoiding to stun tasks the scheduler considers
  interactive was a no-brainer.

- nice value: A niced process tends to be a batch process. Stun.

- time: OOM kill doesn't want to take down long running processes
  because of the work that is lost. For stunning, I don't care.
  In fact, they are probably batch processes, so stun them.

- fault frequency, I/O requests: When the paging disk is the bottleneck,
  it might be sensible to stun a process that produces lots of faults
  or does a lot of disk I/O. If there is an easy way to get that data
  then I missed it.

There are certainly more, but that's what I can think of off the top
of my head. I did note your reference to Carr's thesis (which I'm not
familiar with), but like most papers I've seen on the subject it seems
to focus on throughput. That's special-casing for batch processing or
transaction systems, however; on a general-purpose computer, throughput
means nothing if latency goes down the tube.

> Unfortunately that algorithm appears to require an oracle to implement.

Ah, we've all seen these optimal solutions for classic CS problems
where the only gotcha is that you need omniscience.

> Also, the best criteria as I know of them are somewhat counterintuitive,
> so I'd like to be sure they were tried.

Again, best for what?

> On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> > I doubt that you can get performance anywhere near 2.4 just by adding
> > load control to 2.6 unless you measure throughput and nothing else --
> > otherwise latency will kill you. I am convinced the key is not in
> > _adding_ stuff, but _fixing_ what we have.
> 
> A small problem with that kind of argument is that it's assuming the
> existence of some accumulation of small regressions that haven't proven
> to exist (or have they?), where the kind of a priori argument I've made

Heh. Did you look at the graph in my previous message? Yes, there are
several, independant regressions. What we don't know is which ones were
unavoidable. For instance, the regression in 2.5.27 is quite possibly a
necessary consequence of the new pageout mechanism and the benefits in
upward scalability may well outweigh the costs for the low-end user.

If we accept the notion that we don't care about what we can't measure
(remember the interactivity debates?) and since nobody tested regularly
for thrashing behavior, it seems quite likely that at least some of
the regressions can be fixed, maybe at a slight cost in performance
elsewhere, maybe not even that.

There should be plenty of room for improvement: We are not talking 10%
or 20%, but factors of 3 and more.

> actually provide a guarantee of results without testing. I suppose one
> point in favor of my "grab this tool off the shelf" approach is that
> there is quite a bit of history behind the methods and that they are
> well-understood.

I know I sound like a broken record, but I have one problem with
the off-the-shelf solutions I've found so far: They try to maximize
throughput. They don't care about latency. I do.

> On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> > IMO the question is: How much do we care? Machines with tight memory are
> > not necessarily very concerned about paging (e.g. PDAs), and serious
> > servers rarely operate under such conditions: Admins tend to add RAM
> > when the paging load is significant.
> 
> The question is not if we care, but if we care about others. Economies
> aren't as kind to all users as they are to us

Right. But kernel hackers tend to work for companies that don't make
their money by helping those who don't have any. And before you call
me a cynic, look at the resources that go into making Linux capable of
running on the top 0.something percent of machines and compare that to
the interest with which this and similar threads have been received. I
made my observation based on experience, not personal preference.

That said, it is a fact that thrashing is not the hot issue it was
35 years ago, although the hardware (growing access gap RAM/disk)
and usage patterns (latency matters a lot more, load is unpredictable
and exogenous for the kernel) should have made the problem worse. The
classic solutions are pretty much unworkable today and in most cases
there is one economic solution which is indeed to throw more RAM at it.

> > If you don't care _that_ much about thrashing in Linux, just tell
> > people to buy more RAM. Computers are cheap, RAM even more so, 64 bit
> > becomes affordable, and heavy paging sucks no matter how good a paging
> > mechanism is.
> 
> If I took this kind of argument seriously I'd be telling people to go
> shopping for new devices every time they run into a driver problem. I'm

No. Bad example. For starters, new devices are more likely to have driver
problems, so your advice would be dubious even if they had the money :-P.

The argument I hear for the regressions is that 2.6 is more scalable
on high-end machines now and we just made a trade-off. It has happened
before. Linux 1.x didn't have the hardware requirements of 2.4.

The point I was trying to make with regard to thrashing was that
I suspect it was written off as an inevitable trade-off too early.
I believe that some of the regressions can be fixed without losing the
gains in upward scalability _if_ we find the resources to do it.

Quite frankly, playing with the suspension code was a lot more fun than
investigating regressions in other people's work. But I hated the idea
that Linux fails so miserably now where it used to do so well. At the
very least I wanted to be sure that it was forced collateral damage
and not just an oversight or bad tuning. Clearly, I do care.

> The issue at hand is improving how the kernel behaves on specific
> hardware configurations; the fact other hardware configurations exist
> is irrelevant.

Why do you make me remind you that we live in a world with resource
constraints? What _is_ relevant is where the resources to do the work
come from, which is a non-trivial problem if the work is to benefit
people who don't have the money to buy more RAM. Just saying that it's
unacceptable to screw over those with low-end hardware won't help anybody
:-). If you are volunteering to help out, though, more power to you.

> > the respective changes in 2.5. Obviously, performing regular testing
> > with thrashing benchmarks would make lasting major regressions like
> > those in the 2.5 development series much less likely in the future.
> 
> Yes, this does need to be done more regularly. c.f. the min_free_kb
> tuning problem Matt Mackall and I identified.

Well, tuning problems always make me want to try genetic algorithms.
Regression testing would be much easier. Just run all benchmarks for
every new kernel. Update chart. Done. ... It's scriptable even.

> On Mon, Dec 08, 2003 at 08:49:30PM +0100, Roger Luethi wrote:
> > Additional load control mechanisms create new problems (latency,
> > increased complexity), so I think they should be a last resort, not
> > some method to paper over deficiencies elsewhere in the kernel.
> 
> Who could disagree with this without looking ridiculous?

Heh. It was carefully worded that way <g>. Seriously, though, it's not
as ridiculous as it may seem. The problems we need to address are not
even on the map for the classic papers I have seen on the subject. They
suggest working sets or some sort of abstract load control, but 2.6
has problems that are very specific to that kernel and its mechanisms.
There's no elegant, proven standard algorithm to solve those problems
for us.

> Methods of last resort are not necessarily unavoidable; the OOM killer
> is an example of one that isn't avoidable. The issue is less clear cut

That's debatable. Funny that you should take that example.

> range of machines. But I would prefer not to send an "FOAD" message to
> the users of older hardware or users who can't afford fast hardware.

Agreed.

> The assumption methods of last resort create more problems than they
> solve appears to be based on the notion that they'll be used for more
> than methods of last resort. They're meant to handle the specific cases

No. My beef with load control is that once it's there people will say
"See? Performance is back!" and whatever incentive there was to fix the
real problems is gone. Which I could accept if it wasn't for the fact
that a load control solution is always inferior to other improvements
because of the massive latency increase.

> where they are beneficial, not infect the common case with behavior
> that's only appropriate for underpowered machines or other bogosity.
> That is, it should teach the kernel how to behave in the new situation
> where we want it to behave well, not change its behavior where it
> already behaves well.

Alright. One more thing: Thrashing is not a clear cut system state. You
don't want to change behavior when it was doing well, so you need to
be cautious about your trigger. Which means it will often not fire
for border cases, that is light thrashing. I didn't do a survey, but
I suspect that light thrashing (where there's just not quite enough
memory) is much more common than the heavy variant. Now guess what?
The 2.6 performance for light thrashing is absolutely abysmal. In fact
2.6 will happily spend a lot of time in I/O wait in a situation where
2.4 will cruise through the task without a hitch.

I'm all for adding load control to deal with heavy thrashing that can't
be handled any other way. But I am firmly opposed to pretending that
it is a solution for the common case.

Roger
