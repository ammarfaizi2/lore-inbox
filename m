Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262360AbTESG6r (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 May 2003 02:58:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262361AbTESG6r
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 May 2003 02:58:47 -0400
Received: from mail.gmx.de ([213.165.64.20]:39017 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262360AbTESG6p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 May 2003 02:58:45 -0400
Message-Id: <5.2.0.9.2.20030519085451.01db6e48@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Mon, 19 May 2003 09:16:02 +0200
To: Andrea Arcangeli <andrea@suse.de>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: Scheduling problem with 2.4?
Cc: David Schwartz <davids@webmaster.com>, dak@gnu.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030518231126.GF1429@dualathlon.random>
References: <5.2.0.9.2.20030518103757.00ce93e8@pop.gmx.net>
 <20030517235048.GB1429@dualathlon.random>
 <5.2.0.9.2.20030518103757.00ce93e8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 01:11 AM 5/19/2003 +0200, Andrea Arcangeli wrote:
>On Sun, May 18, 2003 at 10:55:17AM +0200, Mike Galbraith wrote:
> > At 05:16 PM 5/17/2003 -0700, David Schwartz wrote:
> >
> > >> I see what you mean, but I still don't think it is a problem. If
> > >> bandwidth matters you will have to use large writes and reads anyways,
> > >> if bandwidth doesn't matter the number of ctx switches doesn't matter
> > >> either and latency usually is way more important with small messages.
> > >
> > >> Andrea
> > >
> > >        This is the danger of pre-emption based upon dynamic priorities.
> > >You can
> > >get cases where two processes each are permitted to make a very small
> > >amount
> > >of progress in alternation. This can happen just as well with large writes
> > >as small ones, the amount of data is irrelevent, it's the amount of CPU
> > >time
> > >that's important, or to put it another way, it's how far a process can get
> > >without suffering a context switch.
> > >
> > >        I suggest that a process be permitted to use up at least some
> > >portion of
> > >its timeslice exempt from any pre-emption based solely on dynamic
> > >priorities.
> >
> > Cool.
> >
> > Thank you for the spiffy idea.  I implemented this in my (hack/chop) mm5
> > tree in about 30 seconds, and it works just fine.  Very simple
> > time_after(jiffies, p->last_run + MIN_TIMESLICE) checks in wake_up_cpu()
>
>If I understand well, what you did is different (in functionalty) from
>what I described (and what I described in the last email certainly takes
>more than 30 seconds no matter how smart you implement it ;). I mean,

The p->last_run is a typo, it's effectively current->last_run, with 
last_run also being updated upon task switch so you can see how long he's 
had the cpu.  That can be done much quicker than 30 seconds by someone who 
can type with fingers instead of thumbs ;-)

>you lose the whole "wakeup" information, yeah that will fix
>it too like deleting the need_resched =1 after the check on the
>curr->prio enterely, but while it's so simple you you don't only
>guarantee the miniumum timeslice, but you let the current task running
>even after it expired the minimum timeslice.  That will most certainly
>hurt interactivity way too much, I don't think it's an option, unless
>you want to trim significantly the timeslice length too. The only reason
>we can take these long timeslices are the interactivity hints, we always
>had those in linux, all versions. If you start to ignore it, things
>should not do too well, even throughput can decrease in a multithread
>environment due the slower delivery of events.

Throughput did decrease.  I was thinking that there was likely to be 
another event before my ignoring the preempt could matter much.  As 
mentioned privately, I guaranteed that no task could hold the cpu for more 
than 50ms max, so on the next schedule he'd get the cpu (if prio high 
enough) but the test results weren't encouraging.

>Delaying a interprocess message for 1msec (or even 10msec) [i.e. 1/HZ]
>may not be noticeable, but delaying it for a whole timeslice will
>certainly be noticeable, that's an order of magnitude bigger delay.
>
>Actually besides the way I described yesterday (that would require arch
>asm changes) to experiment the "miniumum timeslice guarantee", it could
>also be implemented by moving the timeslice-min_timeslice in a
>rest_timeslice field if jiffies - last_run  < MIN_TIMESLICE and if
>rest_timeslice is zero, and trimming the timeslice down to
>min_timeslice. Then the next schedule would put rest_timeslice back in
>timeslice. This is on the lines of what you implemented but it also
>guaranteees that the higher dyn-prio task will be scheduled after this
>min_timeslice (to still provide the ~same interactive behaviour, which
>is a must IMHO ;) This will be a bit more difficult of the need_resched
>secondary field, but it's probably conceptually cleaner, since it
>restricts the algorithm in the scheduler keeping the asm fast paths
>small and simple.

I'd really like to try a deferred preempt.  I don't know enough (yet 
anyway;) to not create spectacular explosions with that idea though.  I'll 
go ponder your idea instead.

         -Mike 

