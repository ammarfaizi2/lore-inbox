Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275451AbTHJCDi (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Aug 2003 22:03:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275457AbTHJCDi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Aug 2003 22:03:38 -0400
Received: from maile.telia.com ([194.22.190.16]:28891 "EHLO maile.telia.com")
	by vger.kernel.org with ESMTP id S275451AbTHJCD1 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Aug 2003 22:03:27 -0400
X-Original-Recipient: <linux-kernel@vger.kernel.org>
From: Roger Larsson <roger.larsson@skelleftea.mail.telia.com>
To: linux-kernel@vger.kernel.org
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy  ...
Date: Sun, 10 Aug 2003 04:05:52 +0200
User-Agent: KMail/1.5.9
References: <Pine.LNX.4.55.0307131442470.15022@bigblue.dev.mcafeelabs.com> <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Message-Id: <200308100405.52858.roger.larsson@skelleftea.mail.telia.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 09 August 2003 19.47, Mike Galbraith wrote:
> At 03:05 PM 8/9/2003 +0100, Daniel Phillips wrote:
> >Hi Davide,
> >
> >On Sunday 13 July 2003 22:51, Davide Libenzi wrote:
> > > This should (hopefully) avoid other tasks starvation exploits :
> > >
> > > http://www.xmailserver.org/linux-patches/softrr.html
> >
> >    "We will define a new scheduler policy SCHED_SOFTRR that will make the
> >    target task to run with realtime priority while, at the same time, we
> > will enforce a bound for the CPU time the process itself will consume."
> >
> >This needs to be a global bound, not per-task, otherwise realtime tasks
> > can starve the system, as others have noted.
> >
> >But the patch has a much bigger problem: there is no way a SOFTRR task can
> > be realtime as long as higher priority non-realtime tasks can preempt it.
> >  The new dynamic priority adjustment makes it certain that we will
> > regularly see normal tasks with priority elevated above so-called
> > realtime tasks.  Even without dynamic priority adjustment, any higher
> > priority system task can unwttingly make a mockery of realtime schedules.
>
> Not so.  Dynamic priority adjustment will not put a SCHED_OTHER task above
> SCHED_RR, SCHED_FIFO or SCHED_SOFTRR, so they won't preempt.  Try
> this.  Make a SCHED_FIFO task loop, then try to change vt's.  You won't
> ever get there from here unless you have made 'events' a higher priority
> realtime task than your SCHED_FIFO cpu hog.  (not equal, must be higher
> because SCHED_FIFO can't be requeued via timeslice expiration... since it
> doesn't have one)
>
> I do see ~problems with this idea though...
>
> 1.  SCHED_SOFTRR tasks can disturb (root) SCHED_RR/SCHED_FIFO tasks as is.
> SCHED_SOFTRR should probably be a separate band, above SCHED_OTHER, but
> below realtime queues.
>

I would prefere to have it as a sub range "min real RT" <SOFT_RR range < mean 
real RT. Using SOFTRR time slice that is inverse proportional with the level 
might also be beneficial.

> 2.   It's not useful for video (I see no difference between realtime
> component of video vs audio), and if the cpu restriction were opened up
> enough to become useful, you'd end up with ~pure SCHED_RR, which you can no
> way allow Joe User access to.  As a SCHED_LOWLATENCY, it seems like it
> might be useful, but I wonder how useful.

Why shouldn't it be useful with video, is a frame processing burst longer than 
a time slice? The rule for when to and how to revert a SCHED_SOFTRR can be 
changed.

*	SCHED_FIFO requests from non root should also be treated as SCHED_SOFTRR

/Rogerl

-- 
Roger Larsson
Skellefteå
Sweden
