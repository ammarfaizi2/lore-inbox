Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289174AbSAGLQK>; Mon, 7 Jan 2002 06:16:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289176AbSAGLQB>; Mon, 7 Jan 2002 06:16:01 -0500
Received: from mx2.elte.hu ([157.181.151.9]:2461 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S289174AbSAGLPw>;
	Mon, 7 Jan 2002 06:15:52 -0500
Date: Mon, 7 Jan 2002 14:13:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>
Subject: Re: [patch] mqo1 changes ...
In-Reply-To: <Pine.LNX.4.40.0201061121450.7219-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201071222480.5091-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 6 Jan 2002, Davide Libenzi wrote:

> > thanks, we can certainly do something like this, i've added a variation of
> > this to -C1. One thing your patch misses: we need to update the event
> > counter when we remove RT tasks as well.
>
> Other solution, differentiate between waiting an running.

yes, but i dont think we should overcomplicate this.

> You've two queue that are touched, the RT one and the 'prev' one. I'm
> using it in BMQS ( the bottom line logic is the same ) and it works
> great.

we also need to lock the local CPU queue - which must be done in an
ordered fashion. The local queue must be locked because other CPUs might
want to look at rq->curr and rq->nr_running from their load balancer and
migration code. We do not want to update that from outside of the local
lock, that could lead to problems on CPUs that have more relaxed
instruction ordering - eg. we do not want another CPU to dereference
rq->curr that might not be valid anymore after the RT switch.

so yes, it can be done, but it must be done carefully, and unless you have
additional safeguards your code is buggy.

> Can you give me the software you used to test the interactive feel ?

mainly entering a few simple (and some less simple) commands in an
otherwise idle shell and looking at the delay of command completion, while
the system is under various loads. Generally i simply tried to use the
system in various ways under load, and tried to identify any source of
interactiveness slowdowns.

> > so if you'd like to replace it then please do not do it casually, trace
> > the difference under a number of important workloads - i have done so.
>
> No Ingo, you're wrong. That logic gives you the same thing with much
> less complexity. [...]

no. Davide, at this point it becomes hard to argue with you in a
constructive fashion. You have not tested my estimator, in fact in
previous mails you bashed it as broken without understanding it, later in
this mail you show that you still dont understand it, and still you claim
it gives the same end result? I gave you lots of hints how to interpret my
code and asked you to read the code. I also tried to follow a perhaps more
scientific approach, by comparing and benchmarking both solutions, and
will compare them for you in this email as well:

> counter = counter >> 1 + TASK_TIMESLICE

> [...] if you do not use you time you get a bonus. [...]

in overload situations i saw this logic fail badly. The basic problem with
recalc-driven or switch-driven interactivity detection is that during an
overload every process is in essence 'intearactive' to this estimator
method, it cannot make a distrinction between true CPU hogs that are
causing the load and processes that are interactive in behavior.

Recalculations happen very infrequently in such situations (think tens of
processes running or more). Driving the interactiveness-discovery code by
such a variable-frequency 'clock' has proven to be a mistake - it in
essence 'freezes in' the interactiveness detection mechanism exactly when
it's needed the most, which is bad.

my solution drives the interactiveness discovery via the system clock, and
what matter is the amount of time spent on the runqueue in the last 4
seconds, in average. This is black and white mechanism, no load condition
will fail it. The recalculation driven method uses a 'clock' that 'slows
down' if there is load. I use a clock that is constant and can in fact be
made faster or slower independently of other scheduler characteristics.
Try making recalculations happen faster without impacting the rest of the
scheduler ...

*this* i consider a way superior interactivity detection method over any
other solution that might be simple but whose efficiency depends on the
actual load situations and is deeply anchored into the scheduler itself.

what i did was to detach 'interactivity detection' from the scheduler -
which made both parts happier as a result. (the scheduler did not have to
maintain a ->array_switches counter anymore, and the interactivity
detection code got all freedom it needed to do its job well.)

And before anyone gets the impression from your post that my method is
expensive, i'd like to point out a core piece of code you forgot to quote:

        if (p->run_timestamp == jiffies)
                goto enqueue;

ie. we do not call into the load estimator in the overwhelming majority of
cases.

(Right now the 'scheduler clock' is tied to the system clock, for
simplicity. In the future, if we make HZ bigger and estimator overhead
shows up *anywhere* on the radar, the frequency of the scheduler clock can
be scaled down to eg. 100 Hz reduce the estimator overhead, if needed - a
100 Hz sampling frequency per CPU is more than enough to detect
interactivity. Other improvements are possible to the method as well, and
i'd be happy to discuss other internals like the choice of 4 seconds and 4
history slot entries, but the principle is sound and robust.)

> Ingo, this is _exactly_ the logic behind BVT schedulers,

yes, what you propose is the logic behind Borrowed Virtual Time
schedulers, but it fails to detect true interactive tasks under load. A
fancy name does not mean that it cannot suck :-) My goal was not to
implement something from the papers, my goal was to fix a hard problem in
a maintainable fashion.

yes, my solution is more complex than BVT schedulers because i'm in
essence calculating an integral of 'past load' over time, which is not a
simple task in theory. I think i have succeeded in making it correct and
lightweight though, both in terms of cache footprint and in terms of
algorithmic/maintainance overhead. My solution is also a direct and
practical result of trying to improve interactivity during actual load
situations.

> Ingo, did you realize that 'delta' is always zero here ?

like i explained it in the previous mail, delta is not always zero. With a
printk("delta: %ld.\n", delta); line put into the 'if (delta)' deactivate
branch, and if a CPU-using process is started then a 1-per-second trickle
of printk messages pops up soon:

 EXT3-fs: mounted filesystem with ordered data mode.
 delta: 1.
 delta: 1.
 delta: 1.

regarding your problems booting the kernel, other people are having
success running the -C1 patch while previous patches would crash on their
systems. I suspect you have tried -C1 already?

	Ingo

