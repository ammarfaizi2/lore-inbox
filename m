Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266731AbSLCX6u>; Tue, 3 Dec 2002 18:58:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266735AbSLCX6u>; Tue, 3 Dec 2002 18:58:50 -0500
Received: from cda1.e-mind.com ([195.223.140.107]:11392 "EHLO athlon.random")
	by vger.kernel.org with ESMTP id <S266731AbSLCX6o>;
	Tue, 3 Dec 2002 18:58:44 -0500
Date: Wed, 4 Dec 2002 01:06:18 +0100
From: Andrea Arcangeli <andrea@suse.de>
To: Andrew Morton <akpm@digeo.com>
Cc: "Martin J. Bligh" <mbligh@aracnet.com>, Christoph Hellwig <hch@sgi.com>,
       marcelo@connectiva.com.br.munich.sgi.com, rml@tech9.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] set_cpus_allowed() for 2.4
Message-ID: <20021204000618.GG11730@dualathlon.random>
References: <20021202192652.A25938@sgi.com> <1919608311.1038822649@[10.10.2.3]> <3DEBB4BD.F64B6ADC@digeo.com> <20021202195003.GC28164@dualathlon.random> <3DED18CC.5770EA90@digeo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3DED18CC.5770EA90@digeo.com>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 03, 2002 at 12:49:16PM -0800, Andrew Morton wrote:
> Andrea Arcangeli wrote:
> > 
> > On Mon, Dec 02, 2002 at 11:30:05AM -0800, Andrew Morton wrote:
> > ...
> > > I have observed two problems with the new scheduler, both serious IMO:
> > >
> > > 1) Changed sched_yield() semantics.  sched_yield() has changed
> > >    dramatically, and it can seriously impact existing applications.
> > >    A testcase (this is on 2.5.46, UP, no preempt):
> > >
> > >    make -j3 bzImage
> > >    wait 30 seconds
> > >    ^C
> > >    make clean (OK, it's all in cache)
> > >    start StarOffice 5.2
> > >    make -j3 bzImage
> > >    wait 5 seconds
> > >    now click on the SO5.2 `File' menu.
> > >
> > >    It takes ~15 seconds for the menu to appear, and >30 seconds for
> > >    it to go away.  The application is wholly unusable for the duration
> > >    of the compilation.
> > 
> > please try with my tree.
> 
> It is greatly improved.  It is still not as smooth as the standard 2.4
> scheduler, but I'd characterise it as "a bit jerky" rather than "makes
> me want to punch a hole in the monitor".

;)

Thanks for taking the time of testing it btw.

> 
> The difference is unlikely to be noticed by many.  (But it should be
> _better_ than stock 2.4)

it can't be better in SMP because due its scalability feature we
completely lose track of the global smp and we only can keep track of
the single per-cpu queue. Was it on SMP or UP? I guess on SMP. On UP
sched_yield in my tree should be equivalent to stock 2.4 (modulo RT that
is still broken in sched_yield with the o1 scheduler, I'm fixing this
these days but it doesn't matter for your test). If it was UP then it
was probably some other less agressive dynamic priority effect and not
the sched_yield that made the difference.

> 
> > ...
> > > 2) The interactivity estimator makes inappropriate decisions.
> > >
> > >    Test case:
> > >
> > >    start a kernel compile as above
> > >    grab an xterm and waggle it about a lot.
> > >
> > >    The amount of waggling depends on the video hardware (I think).  One
> > >    of my machines (nVidia NV15) needs a huge amount of vigorous waggling.
> > >    Another machine (voodoo III) just needs a little waggle.
> > >
> > >    When you've waggled enough, the scheduler decides that the X server
> > >    is a `batch' process and schedules it alongside the background
> > >    compilation.  Everything goes silly.  The mouse cursor sticks stationary
> > >    for 0.5-1.0 seconds, then takes great leaps across the screen.  Unusable.
> > >    You have to stop using the machine for five seconds or so, wait for the
> > >    X server to flip back into `interactive' mode.
> > >
> > >    This also affects netscape 4.x mailnews.  Start the kernel compile,
> > >    then select a new (large) folder.  Netscape will consume maybe one
> > >    second CPU doing the initial processing on that folder, which is
> > >    enough for the system to decide it's a "batch" process.  The user
> > >    interface seizes up and you have to wait five seconds for it to be
> > >    treated as an "interactive" process again before you can do anything.
> > >
> > >    It also affects gdb.  Start a kernel compile, then run `gdb vmlinux'.
> > >    The initial processing which gdb does on the executable is enough for it
> > >    to be treated as a batch process and the subsequent interactive session
> > >    is comatose for several seconds.  Same deal.
> > >
> > >    This one needs fixing in 2.5.  Please.  It's very irritating.
> > 
> > can you reproduce with my tree?
> 
> Again, hugely improved over normal O(1) behaviour, but not as responsive
> as the stock 2.4 scheduler.
> 
> With a `make -j1' running:
> 
> - Normal O(1) behaviour in StarOffice 5.2 is 15-30 second delays between
>   actions.
> 
> - With 2.4.20aa1, typing into a text document typically had a 2-3 character
>   delay.
> 
> - With the standard 2.4 scheduler the delay is zero characters.

again, I guess that's SMP and that's quite a pain to fix it to be 100%
equivalent to 2.4 without hurting scalability. sched_yield in my tree is
still fully scalable, in turn it has no knowledge of the global smp, in
turn the global smp is still left to the loadbalancing code only (not in
sched_yield) so userspace could spin and sched_yield for some time in
one cpu until some balancing happens or the other cpu expires the
timeslice of the running task and let the lock holder to run. This
wouldn't happen in stock 2.4, in stock 2.4 the holder would run in the
cpu that run sched_yield.

However in UP my tree should be just fully responsive like mainline 2.4
in terms of sched_yield.

At the moment fixing the brokeness of sched_yield with RT tasks in the
o1 scheduler is an higher prio compared to try to have sched_yield as
smart as mainline 2.4 with SMP. Using load_balance() in sched_yield may
not work well either (it's an off-by one issue and load_balance works
starting from the off-by two), so it would be a quite tedious work to
make sched_yield aware of the whole smp and to pick tasks from other
per-cpu queues if there's nothing left to run in the local cpu.  And the
current sched_yield proved to work just well enough in SMP too for quite
obvious reasons (the main problem is when the lock holder lives in the
same cpu of the sched_yield and that's solved now).

> 
> So StarOffice 5.2 is still a bit uncomfortable to use with 2.4.20aa1.

as said it could be the SMP with sched_yield thing (not an issue on UP),
but it could be also some less aggressive dynamic priority, that's
tunable but it doesn't sound like a showstopper. My first prio is that
the heuristics in the scheduler are sane, makes perfect sense and they
don't fall apart into corner cases, if we dropped some minor heuristic
to catch more interactive threads in the dynamic priority that's not a
showstopper it can be re-added later or it may be only a tuning effort
needed on some variable like
MAX_SLEEP_AVG/MAX_TIMESLICE/PRIO_BONUS_RATIO/INTERACTIVE_DELTA. For
example just increasing PRIO_BONUS_RATIO from 25% to 50% would lead to
more interactive processes getting higher dynamic priority levels.

Overall I don't see any showstopper with openoffice (or staroffice) on
my version of the o1 scheduler.

Andrea
