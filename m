Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268086AbTCFP3a>; Thu, 6 Mar 2003 10:29:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268099AbTCFP3a>; Thu, 6 Mar 2003 10:29:30 -0500
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:21005 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S268086AbTCFP31>; Thu, 6 Mar 2003 10:29:27 -0500
Date: Thu, 6 Mar 2003 07:37:31 -0800 (PST)
From: Linus Torvalds <torvalds@transmeta.com>
To: Andrew Morton <akpm@digeo.com>
cc: rml@tech9.net, <mingo@elte.hu>, <linux-kernel@vger.kernel.org>
Subject: Re: [patch] "HT scheduler", sched-2.5.63-B3
In-Reply-To: <20030305234553.715f975e.akpm@digeo.com>
Message-ID: <Pine.LNX.4.44.0303060710350.7206-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 5 Mar 2003, Andrew Morton wrote:
> 
> But it is a heuristic, and it will inevitably make mistakes.  The problem
> which I am observing is that the cost of those mistakes is very high.

The problem I used to see quite clearly is that X gets turned into a
non-interactive task, because with a complex X desktop X can easily use
5-15% of CPU even when everything is perfectly normal. That's simply
because it ends up having to _do_ a lot: anti-aliased text, shifting
logos, xdaliclock in the corner, blinking cursors, annoying moving
advertising on web-sites, small animations in the task-bar etc.

And the current heuristic SUCKS for this. And it's quite fundamental: the
heuristic is _wrong_. The heuristic breaks down _completely_ when there
are ten CPU hogs that peg the CPU, and now the one process that wants 10% 
of the CPU suddenly doesn't sleep any more, since it ends up needing all 
the timeslices it could get.

At this point the current heurstic totally breaks down, and doesn't have 
any way out. The _only_ part of Ingo's patch that may help is the fact 
that he made the maximum timeslice be smaller, but realize that since X 
is now considered to be a background task, that doesn't help very much 
_either_, since it's going to be scheduled round-robin with those other 
ten background tasks, and changing the max timeslice from 300 to 200ms 
only means that the pauses will be "only" two seconds instead of being 
three seconds.

See? 

I told Ingo about it half a year ago, and he ignored it then, saying it 
can't be solved. Re-nicing X doesn't really help: it only hides the 
problem because it means that X won't be scheduled round-robin with the 
background load any more, but because it makes X more important than user 
processes it then has other fundamental flaws.

So with "nice -10", when X gets busy, it gets _too_ busy and locks out
other processes - it fixes the interactivity, but it causes latency
problems because X is still considered a _background_ job, so it gets a 
200ms timeslice at high priority and guess what? That kind of sucks for 
regular programs that want low latency.

> Let me redescribe the problem:
> 
> - Dual 850MHz PIII, 900M of RAM.
> - Start a `make -j3 vmlinux', everything in pagecache
> - Start using X applications.  Moving a window about is the usual trigger.

Yeah. Guess what? Moving a window makes X suddenly use a lot more CPU (try 
turning off acceleration if you _really_ want to see it), so you see the 
fundamental problem with less load. Add some load (and some X eye-candy) 
and you will see it much easier. 

And read the above description of what happens, and realize that it is 
_fundamental_.

And guess what my 5-liner patch tries to address? The one that you didn't
bother testing.. The one that actually tries to tackle the problem head-on 
instead of hiding it. 

> Interestingly, this does not happen if the background load is a bunch of
> busywaits.  It seems to need the fork&exit load of a compilation to trigger.

It happened with busy-waits too last time I checked (which is about halfa
year ago), it's just that a normal busy-wait tends to _do_ a lot less than
doign a fork()/wait()/busy-child. When the load on the CPU becomes
"constrained" (ie when the CPU idle time goes down to zero) of a
fork/wait/busy-child, suddenly that isn't a load unit of "1" any more, 
since the fork/wait/exit actually takes time.

Which means that you may need 6 busy-wait tasks to get the same kind of 
real load that you get with just 3 fork/wait/exit things.

> Robert was able to reproduce this, and noticed that the scheduler had niced
> the X server down as far as it would go.

Right. It's totally starved for CPU, so it never sleeps, so it gets turned 
into non-interactive, so it gets round-robined-with-the-background-tasks.

> I'm a pretty pathological case, because I was driving two 1600x1200x24
> displays with a crufty old AGP voodoo3 and a $2 PCI nvidia.  Am now using a
> presumably less crufty radeon and the problem persists.

I saw the problem on this 4-CPU machine with my old graphics card, which 
was something perfectly moderns (ATI Radeon 7000). I can still trigger it 
even with my current Radeon 8500, but I need to basically make the build 
be "make -j15" ot something like that to trigger it, at which point I'm 
not sure it's relevant any more..

And yes, I think my five-liner makes a difference to me, but since I need
to push the machine so far "off" a reasonable load to trigger it, I don't
think my machine is a good test.

A good test is a fairly slow graphics card, with some stuff happening all 
the time on the screen (ie xdaliclock or a noisy web-site). And then 
seeing what moving a window does when doing a compile.

The window moving itself is not helped by my patch, but my patch _should_
mean that the _users_ of X (which are less starved for CPU than X is,
since they don't actually have to do the heavy lifting) will be giving X
"life points" as X wakes them up.

And that's the whole point of the patch. Any synchronous wake-up that 
wakes up an interactive task is a _good_ thing. Not just for the 
interactive task itself, but also for the thing that causes it to wake up. 
It makes X itself more interactive - it still goes into "background mode" 
for short stretches, but it seems to need more pushing, and it seems 
to come out of its funk faster.

Note the "seems". This is why I'd like others to test it - since it's very 
much a perception issue.

		Linus

