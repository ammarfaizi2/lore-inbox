Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272457AbTHJHGw (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 03:06:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272459AbTHJHGw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 03:06:52 -0400
Received: from mail.gmx.de ([213.165.64.20]:36826 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S272457AbTHJHGt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 03:06:49 -0400
Message-Id: <5.2.1.1.2.20030810084805.01a0dfa8@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.1
Date: Sun, 10 Aug 2003 09:11:00 +0200
To: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy 
  ...
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200308100405.52858.roger.larsson@skelleftea.mail.telia.com
 >
References: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
 <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com>
 <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 04:05 AM 8/10/2003 +0200, Roger Larsson wrote:
>On Saturday 09 August 2003 19.47, Mike Galbraith wrote:
> > At 03:05 PM 8/9/2003 +0100, Daniel Phillips wrote:
> > >Hi Davide,
> > >
> > >On Sunday 13 July 2003 22:51, Davide Libenzi wrote:
> > > > This should (hopefully) avoid other tasks starvation exploits :
> > > >
> > > > http://www.xmailserver.org/linux-patches/softrr.html
> > >
> > >    "We will define a new scheduler policy SCHED_SOFTRR that will make the
> > >    target task to run with realtime priority while, at the same time, we
> > > will enforce a bound for the CPU time the process itself will consume."
> > >
> > >This needs to be a global bound, not per-task, otherwise realtime tasks
> > > can starve the system, as others have noted.
> > >
> > >But the patch has a much bigger problem: there is no way a SOFTRR task can
> > > be realtime as long as higher priority non-realtime tasks can preempt it.
> > >  The new dynamic priority adjustment makes it certain that we will
> > > regularly see normal tasks with priority elevated above so-called
> > > realtime tasks.  Even without dynamic priority adjustment, any higher
> > > priority system task can unwttingly make a mockery of realtime schedules.
> >
> > Not so.  Dynamic priority adjustment will not put a SCHED_OTHER task above
> > SCHED_RR, SCHED_FIFO or SCHED_SOFTRR, so they won't preempt.  Try
> > this.  Make a SCHED_FIFO task loop, then try to change vt's.  You won't
> > ever get there from here unless you have made 'events' a higher priority
> > realtime task than your SCHED_FIFO cpu hog.  (not equal, must be higher
> > because SCHED_FIFO can't be requeued via timeslice expiration... since it
> > doesn't have one)
> >
> > I do see ~problems with this idea though...
> >
> > 1.  SCHED_SOFTRR tasks can disturb (root) SCHED_RR/SCHED_FIFO tasks as is.
> > SCHED_SOFTRR should probably be a separate band, above SCHED_OTHER, but
> > below realtime queues.
> >
>
>I would prefere to have it as a sub range "min real RT" <SOFT_RR range < mean
>real RT. Using SOFTRR time slice that is inverse proportional with the level
>might also be beneficial.

Yes, if there are more than one running, you reduce scheduler latency.  It 
seems to me that it would also be useful to include short term cpu history 
into priority scaling, such that if a task starts consuming it's slice, it 
would be quickly detected, and that task would only be able to dork up 
others latency requirements for a slice or two before being demoted.

> > 2.   It's not useful for video (I see no difference between realtime
> > component of video vs audio), and if the cpu restriction were opened up
> > enough to become useful, you'd end up with ~pure SCHED_RR, which you can no
> > way allow Joe User access to.  As a SCHED_LOWLATENCY, it seems like it
> > might be useful, but I wonder how useful.
>
>Why shouldn't it be useful with video, is a frame processing burst longer 
>than
>a time slice? The rule for when to and how to revert a SCHED_SOFTRR can be
>changed.

Everything I've seen says "you need at least a 300Mhz cpu to decode".  My 
little cpu is 500Mhz, so I'd have to make more than half of my total 
computational power available for SCHED_SOFTRR tasks for video decode in 
realtime to work.  Even on my single user box, I wouldn't want to have to 
fight for cpu because some random developer decided to use 
SCHED_SOFTRR.  If I make that much cpu available, someone will try to use 
it.  Personally, I think you should need authorization for even tiny 
amounts of cpu at this priority.

         -Mike 

