Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286590AbSAFAwa>; Sat, 5 Jan 2002 19:52:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286603AbSAFAwV>; Sat, 5 Jan 2002 19:52:21 -0500
Received: from mx2.elte.hu ([157.181.151.9]:40339 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S286590AbSAFAwK>;
	Sat, 5 Jan 2002 19:52:10 -0500
Date: Sun, 6 Jan 2002 03:49:26 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: lkml <linux-kernel@vger.kernel.org>,
        Linus Torvalds <torvalds@transmeta.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [announce] [patch] ultra-scalable O(1) SMP and UP scheduler
In-Reply-To: <Pine.LNX.4.40.0201051242080.1607-100000@blue1.dev.mcafeelabs.com>
Message-ID: <Pine.LNX.4.33.0201060227500.2889-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sat, 5 Jan 2002, Davide Libenzi wrote:

> In even _high_realistic_ workloads on these servers the scheduler
> impact is never more than 5-15% and by simply splitting the queue/lock
> you get a 30 up to 60 time fold ( see picture ), that makes the
> scheduler impact to go down to 0.2-0.3%. Why do you need to
> overoptimize for a 0.2% ?

the chat simulator simulates Lotus workload pretty well. There are lots of
other workloads that create similar situations. Davide, i honestly think
that you are sticking your head into the sand if you say that many
processes on the runqueue do not happen or do not matter. I used to say
exactly what you say now, and i've seen enough bad scheduling behavior to
have started this O(1) project.

> > In fact it's the cr3 switch (movl %0, %%cr3) that accounts for about 30%
> > of the context switch cost. On x86. On other architectures it's often
> > much, much cheaper.
>
> TLB flushes are expensive everywhere, [...]

you dont know what you are talking about. Most modern CPUs dont need a TLB
flush on context switch, they have tagged caches. And yes, some day we
might even see x86-compatible CPUs that have sane internals.

> and you know exactly this and if you used a cycle counter to analyze
> the scheduler instead of silly benchmarks you would probably know more
> about what inside a context switch does matter.

How do you explain this then:

2.5.2-pre9 vanilla:

 [mingo@a l]$ while true; do ./lat_ctx -s 0 2 2>&1 | grep ^2; done
 2 1.64
 2 1.62

2.5.2-pre9 -B1 O(1) scheduler patch:

 [mingo@a l]$ while true; do ./lat_ctx -s 0 2 2>&1 | grep ^2; done
 2 1.57
 2 1.55

ie. UP, 2-task context switch times became slightly faster. By your
argument it should be significantly slower or worse.

with 10 CPU-intensive tasks running the background, 2.5.2-pre9 + B1 O(1)
patch:

 [root@a l]# nice -n -100 ./lat_ctx -s 0 2
 2 1.57

(ie. the very same context-switch performance - not unexpected from an
O(1) scheduler). While the vanilla scheduler:

 [root@a l]# nice -n -100 ./lat_ctx -s 0 2
 2 2.20

ie. 33% slower already. With 50 background tasks, it's:

 [root@a l]# nice -n -100 ./lat_ctx -s 0 2
 2 17.49

ie. it's more than 10 times slower already. And the O(1) still goes steady
1.57 microseconds.

this is called an exponential breakdown in system characteristics.

If you say that i do not care about and count every cycle spent in the
scheduler then you do not know me.

> Ingo your RT code sucks [.. 10 more lines of patch-bashing snipped ..]

please answer the technical issues i raised. I've taken a quick peek at
your patch, and you do not appear to solve the IPI asynchronity problem i
raised. Ie. your scheduler might end up running the wrong RT tasks on the
wrong CPUs.

> I'm sorry but you set p->run_timestamp to jiffies when the task is run
> and you make curr_sample = j / HZ when it stops running. If you divide
> by HZ you'll obtain seconds. [...]
[...]
> Now, if you divide by HZ, what do you obtain ?
[...]
> delta will be ~97% always zero, and the remaining 3% one ( because of
> HZ scale crossing ). Now this is not my code but do you understand
> your code ? Do you understand why it's broken ?

i obtain a 'history slot index' to the history array via dividing by HZ.
The real statistics is jiffies-accurate, of course. The 'load history' of
the process is stored in a 4-entry (can be redefined) history array, which
is cycled around so that we have a history. The code in essence does an
integral of load over time, and for that one has to use some sort of
memory buffer.

I'd again like to ask you to read and understand the code, not bash it
mindlessly.

> > (in my current codebase i've changed the load-balancer to be called with a
> > maximum frequency of 100 - eg. if HZ is set to 1000 then we still call the
> > load balancer only 100 times a second.)
>
> Wow, only 100 times, it's pretty good. You're travelling between the
> CPU data only 100 times per second probably trashing the running
> process cache image, but overall it's pretty good code.

Davide, please. If you take a look at the code then you'll notice that the
prime target for load-balancing are expired processes, ie. processes which
wont run on that CPU for some time. And if you had bothered to try my
patch then you'd have seen that CPU-bound tasks do not get misbalanced.
The other reason to call the load balancer rather frequently is to
distribute CPU-bound tasks between CPUs fairly.

but this shouldnt matter in your world too much, since long runqueues do
not exist or matter, right? ;-)

> And please do not say me to measure something like this. [...]

i for one will keep measuring things, the proof of the pudding is eating.

> Adding a multi level priority is no more than 10 minutes of code
> inside BMQS but i thought it was useless and i did not code it. Even a
> dual queue + FIFO pickups :
>
> http://www.xmailserver.org/linux-patches/mss-2.html#dualqueue

what i do is something pretty different. The dual array i use is to gather
tasks that have expired timeslices. The goal is to distribute timeslices
fairly, ie. a task that has an expired timeslice cannot run until all
tasks expire their timeslices in the active array. All tasks of all
priorities.

just for the record, i had this idea years ago (in '96 or '97) but never
implemented it past some very embryonic state (which i sent to DaveM and
Linus [perhaps Alan too] as a matter of fact - back then i called it the
'matrix scheduler'), until i faced the chat simulator workload recently.
That workload the current scheduler (or simple multiqueue schedulers)
mishandles badly. Please give me the URL that points to a patch that does
the same thing to solve the fair timeslice distribution problem.

> [...] You know what makes me angry ? It's not that you can sell this
> stuff to guys that knows how things works in a kernel, i'm getting
> angry because i think about guys actually reading your words and that
> really think that using an O(1) scheduler can change their
> life/system-problems. And they're going to spend their time trying
> this stuff. [...]

Will the O(1) patch matter for systems that have a 0-length runqueue most
of the time? Not the least. [the SMP affinity improvements might help
though, but similar things are done in other patches as well.] But this
scheduler was the first one i ever saw producing a sane results for the
chat simulator, and while my patch might not be merged into the mainline,
it will always be an option for those 'hopeless' workloads, or university
servers where hundreds of CPU-bound tasks are executing on the same poor
overloaded box.

	Ingo

