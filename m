Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288917AbSAES1O>; Sat, 5 Jan 2002 13:27:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288918AbSAES1F>; Sat, 5 Jan 2002 13:27:05 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40593 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S288917AbSAES0s>;
	Sat, 5 Jan 2002 13:26:48 -0500
Date: Sat, 5 Jan 2002 21:24:08 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.40.0201041857490.937-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201051232020.2542-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Fri, 4 Jan 2002, Davide Libenzi wrote:

> [...] but do you remember 4 years ago when i posted the priority queue
> patch what you did say ? You said, just in case you do not remember,
> that the load average over a single CPU even for high loaded servers
> is typically lower than 5.

yep, this might have been the case 4 years ago :) But i'd not be ashamed
to change my opinion even if i had said it just a few months ago.

Today we have things like the slashdot effect that will break down
otherwise healthy and well-sized systems. People have started working
around things by designing servers that run only a limited number of
processes, but the fact is, why should we restrict application maker's
choice of design, especially if they are often interested in robustness
more than in the last bit of performance. There are a fair number of
real-world application servers that start to suffer under Linux if put
under realistic load.

> Yes, 70% of the cost of a context switch is switch-mm, and this
> measured with a cycle counter. [...]

two-process context switch times under the O(1) scheduler did not get
slower.

> Take a look at this if you do not believe :

In fact it's the cr3 switch (movl %0, %%cr3) that accounts for about 30%
of the context switch cost. On x86. On other architectures it's often
much, much cheaper.

> More, you removed the MM affinity test that, i agree that is not
> always successful, but even if it's able to correctly predict 50% of
> the reschedules, [...]

you must be living on a different planet if you say that the p->mm test in
goodness() matters in 50% of the reschedules. In my traces it was more
like 1% of the cases or less, so i removed it as insignificant factor
causing significant complexity. Please quote the specific workload/test i
should try, where you think the mm test matters.

> Lets come at the code. Have you ever tried to measure the context
> switch times for standard tasks when there's an RT tasks running ?

the current RT scheduling scheme was a conscious choice. *If* a RT task is
running (which just doesnt happen in 99.999% of the time) then scalability
becomes much less important, and scheduling latency is the only and
commanding factor.

> You basically broadcast IPIs with all other CPUs falling down to get
> the whole lock set. [...]

oh yes. *If* a RT task becomes runnable then i *want* all other CPUs drop
all the work they have as soon as possible and go try to run that
over-important RT task. It doesnt matter whether it's SMP-affine, and it
doesnt matter whether it's scalable. RT is about latency of action,
nothing else. RT is about a robot arm having to stop in 100 msecs or the
product gets physically damaged.

this method of 'global RT tasks' has the following practical advantage: it
reduces the statistical scheduling latency of RT tasks better than any
other solution, because the scheduler *cannot* know in advance which CPU
will be able to get the RT task first. Think about it, what if the CPU,
that appears to be the least busy for the scheduler, happens to be
spinning within some critical section? The best method is to let every CPU
go into the scheduler as fast as possible, and let the fastest one win.

George Anzinger @ Montavista has suggested the following extension to this
concept: besides having such global RT tasks, for some RT usages it makes
sense to have per-CPU 'affine' RT tasks. I think that makes alot of sense
as well, because if you care more about scalability than latencies, then
you can still flag your process to be 'CPU affine RT task', which wont be
included in the global queue, and thus you wont see the global locking
overhead and 'CPUs racing to run RT tasks'. I have reserved some priority
bitspace for such purposes.

> static inline void update_sleep_avg_deactivate(task_t *p)
> {
>     unsigned int idx;
>     unsigned long j = jiffies, last_sample = p->run_timestamp / HZ,
>         curr_sample = j / HZ, delta = curr_sample - last_sample;
>
>     if (delta) {
[...]

> If you scale down to seconds with /HZ, delta will be 99.99% of cases
> zero. How much do you think a task will run 1-3 seconds ?!?

i have to say that you apparently do not understand the code. Please check
it out again, it does not do what you think it does. The code measures the
portion of time the task spends in the runqueue. Eg. a fully CPU-bound
task spends 100% of its time on the runqueue. A task that is sleeping
spends 0% of its time on the runqueue. A task that does some real work and
goes on and off the runqueue will have a 'runqueue percentage value'
somewhere between the two. The load estimator in the O(1) scheduler
measures this value based on a 4-entry, 4 seconds 'runqueue history'. The
scheduler uses this percentage value to decide whether a task is
'interactive' or a 'CPU hog'. But you do not have to take my word for it,
check out the code and prove me wrong.

> You basically shortened the schedule() path by adding more code on the
> wakeup() path. This :

would you mind proving this claim with hard numbers? I *have* put up hard
numbers, but i dont see measurements in your post. I was very careful
about not making wakeup() more expensive at the expense of schedule(). The
load estimator was written and tuned carefully, and eg. on UP, switching
just 2 tasks (lat_ctx -s 0 2), the O(1) scheduler is as fast as the
2.5.2-pre6/pre7 scheduler. It also brings additional benefits of improved
interactiveness detection, which i'd be willing to pay the price for even
if it made scheduling slightly more expensive. (which it doesnt.)

> with a runqueue balance done at every timer tick.

please prove that this has any measurable performance impact. Right now
the load-balancer is a bit over-eager trying to balance work - in the -A2
patch i've relaxed this a bit.

if you check out the code then you'll see that the load-balancer has been
designed to be scalable and SMP-friendly as well: ie. it does not lock
other runqueues while it checks the statistics, so it does not create
interlocking traffic. It only goes and locks other runqueues *if* it finds
an imbalance. Ie., under this design, it's perfectly OK to run the load
balancer 100 times a second, because there wont be much overhead unless
there is heavy runqueue activity.

(in my current codebase i've changed the load-balancer to be called with a
maximum frequency of 100 - eg. if HZ is set to 1000 then we still call the
load balancer only 100 times a second.)

> Another thing that i'd like to let you note is that with the current
> 2.5.2-preX scheduler the recalculation loop is no more a problem
> because it's done only for running tasks and the lock switch between
> task_list and runqueue has been removed. [...]

all the comparisons i did and descriptions i made were based on the
current 2.5.2-pre6/pre7 scheduler. The benchmarks i did were against
2.5.2-pre6 that has the latest code. But to make the comparison more fair,
i'd like to ask you to compare your multiqueue scheduler patch against the
O(1) scheduler, and post your results here.

and yes, the goodness() loop does matter very much. I have fixed this, and
unless you can point out practical disadvantages i dont understand your
point.

fact is, scheduler design does matter when things are turning for the
worse, when your website gets a sudden spike of hits and you still want to
use the system's resources to handle (and thus decrease) the load and not
waste it on things like goodness loops which will only make the situation
worse. There is no system that cannot be overloaded, but there is a big
difference between handling overloads gracefully and trying to cope with
load spikes or falling flat on our face spending 90% of our time in the
scheduler. This is why i think it's a good idea to have an O(1)
scheduler.

	Ingo

