Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262251AbTERW6h (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 18 May 2003 18:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262254AbTERW6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 18 May 2003 18:58:37 -0400
Received: from ppp-217-133-42-200.cust-adsl.tiscali.it ([217.133.42.200]:38074
	"EHLO dualathlon.random") by vger.kernel.org with ESMTP
	id S262251AbTERW6g (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 18 May 2003 18:58:36 -0400
Date: Mon, 19 May 2003 01:11:26 +0200
From: Andrea Arcangeli <andrea@suse.de>
To: Mike Galbraith <efault@gmx.de>
Cc: David Schwartz <davids@webmaster.com>, dak@gnu.org,
       linux-kernel@vger.kernel.org
Subject: Re: Scheduling problem with 2.4?
Message-ID: <20030518231126.GF1429@dualathlon.random>
References: <20030517235048.GB1429@dualathlon.random> <5.2.0.9.2.20030518103757.00ce93e8@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5.2.0.9.2.20030518103757.00ce93e8@pop.gmx.net>
User-Agent: Mutt/1.4i
X-GPG-Key: 1024D/68B9CB43
X-PGP-Key: 1024R/CB4660B9
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 18, 2003 at 10:55:17AM +0200, Mike Galbraith wrote:
> At 05:16 PM 5/17/2003 -0700, David Schwartz wrote:
> 
> >> I see what you mean, but I still don't think it is a problem. If
> >> bandwidth matters you will have to use large writes and reads anyways,
> >> if bandwidth doesn't matter the number of ctx switches doesn't matter
> >> either and latency usually is way more important with small messages.
> >
> >> Andrea
> >
> >        This is the danger of pre-emption based upon dynamic priorities. 
> >You can
> >get cases where two processes each are permitted to make a very small 
> >amount
> >of progress in alternation. This can happen just as well with large writes
> >as small ones, the amount of data is irrelevent, it's the amount of CPU 
> >time
> >that's important, or to put it another way, it's how far a process can get
> >without suffering a context switch.
> >
> >        I suggest that a process be permitted to use up at least some 
> >portion of
> >its timeslice exempt from any pre-emption based solely on dynamic
> >priorities.
> 
> Cool.
> 
> Thank you for the spiffy idea.  I implemented this in my (hack/chop) mm5 
> tree in about 30 seconds, and it works just fine.  Very simple 
> time_after(jiffies, p->last_run + MIN_TIMESLICE) checks in wake_up_cpu() 

If I understand well, what you did is different (in functionalty) from
what I described (and what I described in the last email certainly takes
more than 30 seconds no matter how smart you implement it ;). I mean,
you lose the whole "wakeup" information, yeah that will fix
it too like deleting the need_resched =1 after the check on the
curr->prio enterely, but while it's so simple you you don't only
guarantee the miniumum timeslice, but you let the current task running
even after it expired the minimum timeslice.  That will most certainly
hurt interactivity way too much, I don't think it's an option, unless
you want to trim significantly the timeslice length too. The only reason
we can take these long timeslices are the interactivity hints, we always
had those in linux, all versions. If you start to ignore it, things
should not do too well, even throughput can decrease in a multithread
environment due the slower delivery of events.

Delaying a interprocess message for 1msec (or even 10msec) [i.e. 1/HZ]
may not be noticeable, but delaying it for a whole timeslice will
certainly be noticeable, that's an order of magnitude bigger delay.

Actually besides the way I described yesterday (that would require arch
asm changes) to experiment the "miniumum timeslice guarantee", it could
also be implemented by moving the timeslice-min_timeslice in a
rest_timeslice field if jiffies - last_run  < MIN_TIMESLICE and if
rest_timeslice is zero, and trimming the timeslice down to
min_timeslice. Then the next schedule would put rest_timeslice back in
timeslice. This is on the lines of what you implemented but it also
guaranteees that the higher dyn-prio task will be scheduled after this
min_timeslice (to still provide the ~same interactive behaviour, which
is a must IMHO ;) This will be a bit more difficult of the need_resched
secondary field, but it's probably conceptually cleaner, since it
restricts the algorithm in the scheduler keeping the asm fast paths
small and simple.

> plus the obvious dinky change to schedule(), and it worked 
> instantly.  Hmm.. I wonder if this might help some of the other scheduler 
> (seemingly) bad behavior as well.
> 
> Is there any down-side to not preempting quite as often?  It seems like 
> there should be a bandwidth gain.

it's certainly on the right trick for this issue, in the sense there
will be the wanted bandwidth gain in the 1 byte write case to a pty ;)
(like dropping the need_resched = 1, that even goes down to 5 sec and a
1 liner patch), however I don't think the 30 sec modification alone is
just a generic solution. delaying the reschedule to min_timeslice may be
accpetable instead.

Andrea
