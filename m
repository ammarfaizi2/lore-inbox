Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261556AbTCKTyK>; Tue, 11 Mar 2003 14:54:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261559AbTCKTyJ>; Tue, 11 Mar 2003 14:54:09 -0500
Received: from pop.gmx.net ([213.165.64.20]:4303 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id <S261556AbTCKTyA>;
	Tue, 11 Mar 2003 14:54:00 -0500
Message-Id: <5.2.0.9.2.20030311201831.00cd5718@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Tue, 11 Mar 2003 21:09:16 +0100
To: jim.houston@attbi.com
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [PATCH] self tuning scheduler
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3E6E3386.FFFECD86@attbi.com>
References: <5.2.0.9.2.20030311095954.01f9a008@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 02:05 PM 3/11/2003 -0500, Jim Houston wrote:
>Mike Galbraith wrote:
> >
> > Greetings,
> >
> > I took your patch out for a test-drive, and it appears to have starvation
> > problems with irman's process load (dang thing seems to be HELL on 
> schedulers).
> >
> > Irman starts a load (defaults to 9 tasks passing data in a pipe ring), and
> > forks a child which pingpongs one character back and forth to the parent
> > for 1000000 iterations, measuring response time for each iteration and
> > computing statistics.  With an iteration % 1000 printf() in the evaluation
> > routine, I see it start off nice and fast, then begins to get starved for
> > up to 30 seconds.  It jerks around for a bit, then slows down to a ~stable
> > 1 sec/iteration after approximately 300000 iterations.  The whole test
> > takes ~2minutes with 2.5.64-virgin.  (I'm not patient enough to wait for
> > the rest of the .5million iterations left on this burn before reporting:)
> >
> > It also shows a serious throughput loss with make -j30 bzImage on this box
> > (I think you expect that though from what I read).  With stock, it takes
> > ~8m30s... this scheduler adds a full minute.
> >
> > The window wave test with a make -j5 bzImage running (fits easily in ram)
> > is pretty ragged.
> >
> > Ending on a more positive note, vmstat output from the parallel build looks
> > quite nice.
> >
> >         -Mike
>
>Hi Mike,
>
>Thanks for taking the time to test my changes.

(dang, wouldn't ya know I'd get a reply _after_  grumbling for ~wasting 6 
hrs thinking;)

You're quite welcome.

>I found an irman rpm which is 2001 vintage and a broken link at:
>         http://people.redhat.com/bmatthews/irman/
>So I'm not sure if I'm duplicating your test. If you could send me a
>tar ball with the source for the irman you are running, it would help.

Con put up a 0.5 tarball, and I grabbed that... likely the same.

>When I run the version of irman I have, it runs to completion, maybe a
>bit slower than it should.  I have some ideas why my scheduler does
>badly on this test.

It runs to completion here too, but takes a _really_ long time.  I also 
have some ideas why it runs so badly with your scheduler and Ingo's.  It's 
basically a BAD test case IMHO.  It is however a very effective DOS as 
things stand.  (nothing more)

>When I start a new process, I pick an initial priority for the new
>process based on the average priority at which the system has been
>running.  From this I back calculate a run_avg value. If this guess
>is bad, the new process may have an unfair advantage with respect to
>its parent.  I have been thinking of ways to fix this.  One idea is
>to use a shorter half-life value for processes which are recently started.

That's not what I _think_ I see.  What I see is a steady degradation (same 
with Ingo scheduler, but Ingo's degrades to livelock).  IMVHO, the 100000:1 
work ratio (same work, data is 100000:1... that's the only difference) just 
skews the priority calculations in favor of the background load.

>This test is an example where basing the child priority on the parent
>makes sense.  Perhaps I should use the parent priority if it is
>lower than the rq->prio_avg value.

(hmmMMM.  will ruminate)

>I guess it was wishful thinking when I titled this self tuning.
>If your interested you could adjust the run_avg_halflife and/or
>prio_avg_halflife to a smaller values.

(interested!... hard problem)

>   It may also be a sampling problem where the period of the ping-pong
>exchange is a fraction of the HZ tick, and one process is charged more
>than its share of the cpu.

(hmm.  I saw 1 sec/1000 iterations or a long while, then it degraded to 5 
secs/1000 iterations)

>On the make -j30 kernel make, I intentionally reduce the timeslice
>as the process priority increases.  This should reduce jitter for
>interactive processes. As more processes try to share the cpu they
>all get higher priority and the smaller time slice.  If there are
>only 1-2 compute bound processes they would get 0.5 second time
>slices.

This hurts that kind of load badly.  ;) this load is kind of a religious 
issue with me.  This load is very generic... it just divides a known volume 
of work into 30 sub-units such that the VM has something to deal with... in 
a known-to-be-doable size... it does _not_ saturate my box.  Ingo's 
scheduler throttles it in such a way that total system throughput remains 
constant.  I've thought long and hard about this, and can't assert that 
anything bad is being done to the load by the scheduling decisions made by 
Ingo.  OTOH, shortening timeslice simply because there are N consumers is 
guaranteed to damage throughput for compute bound loads like this.

>  I'm also curious about the hardware you are testing on.

Cheezy little UP P3/500/128Mb box.

         -Mike 

