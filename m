Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbTHJPnp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 10 Aug 2003 11:43:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269900AbTHJPno
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 10 Aug 2003 11:43:44 -0400
Received: from mail-in-04.arcor-online.net ([151.189.21.44]:43720 "EHLO
	mail-in-04.arcor-online.net") by vger.kernel.org with ESMTP
	id S269747AbTHJPnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 10 Aug 2003 11:43:42 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mike Galbraith <efault@gmx.de>
Subject: Re: [patch] SCHED_SOFTRR starve-free linux scheduling policy   ...
Date: Sun, 10 Aug 2003 16:46:34 +0100
User-Agent: KMail/1.5.3
Cc: Davide Libenzi <davidel@xmailserver.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <5.2.1.1.2.20030809183021.0197ae00@pop.gmx.net> <5.2.1.1.2.20030810080748.019cb090@pop.gmx.net>
In-Reply-To: <5.2.1.1.2.20030810080748.019cb090@pop.gmx.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308101646.34830.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 10 August 2003 07:41, Mike Galbraith wrote:
> At 01:41 AM 8/10/2003 +0100, Daniel Phillips wrote:
> >On Saturday 09 August 2003 18:47, Mike Galbraith wrote:
> > > > But the patch has a much bigger problem: there is no way a SOFTRR task 
> > > > can be realtime as long as higher priority non-realtime tasks can preempt
> > > > it. The new dynamic priority adjustment makes it certain that we will
> > > > regularly see normal tasks with priority elevated above so-called
> > > > realtime tasks.  Even without dynamic priority adjustment, any higher
> > > > priority system task can unwttingly make a mockery of realtime
> > > > schedules.
> > >
> > > Not so.
> >
> >Yes so.  A SCHED_NORMAL task with priority n can execute even when a
> >SCHED_FIFO/RR/SOFTRR task of priority n-1 is ready.  In the case of FIFO
> > and RR we don't care because they're already unusable by normal users but
> > in the case of SOFTRR it defeats the intended realtime gaurantee.
>
> No, _not_ so.  How is the SCHED_NORMAL (didn't that used to be called
> SCHED_OTHER?)

That was just me learning the (funky) terminology.

> task ever going to receive the cpu when a realtime task is
> runnable given that 1. task selection is done via sched_find_first_bit(),
> and 2. realtime queues reside at the top of the array?

OK, got it.  I'd overlooked the strict separation into realtime and
timesliced bands somehow.

> > > Dynamic priority adjustment will not put a SCHED_OTHER task above
> > > SCHED_RR, SCHED_FIFO or SCHED_SOFTRR, so they won't preempt.
> >
> >Are you sure?  I suppose that depends on the particular flavor of dynamic
> >priority adjustment.  The last I saw, dynamic priority can adjust the task
> >priority by 5 up or down.  If I'm wrong, please show me why and hopefully
> >point at specific code.
>
> See the definition of rt_task() in sched.c, and the comments in sched.h
> beginning at line 266.

OK, I believe you now, and this is good, as my fear of high-priority
SCHED_OTHER tasks getting in the way of SOFTRR tasks was bogus. So lets
go back and look at your two concerns:

> 1.  SCHED_SOFTRR tasks can disturb (root) SCHED_RR/SCHED_FIFO tasks as is.
> SCHED_SOFTRR should probably be a separate band, above SCHED_OTHER, but
> below realtime queues.

Nobody promises that root's SCHED_RR/FIFO tasks can get any particular share
of the cpu, only that they will get some CPU provided that all higher-priority
tasks play nicely.  Normal users can take advantage of this hospitality by
taking up to a certain, administer-configured share of the CPU for their own
dark purposes.  Everything is roses and cherries, we haven't broken any rules,
and there's no DoS here.  (Assuming we change the realtime CPU bound to be
global instead of task-local.)

> 2.   It's not useful for video (I see no difference between realtime
> component of video vs audio), and if the cpu restriction were opened up
> enough to become useful, you'd end up with ~pure SCHED_RR, which you can no
> way allow Joe User access to.  As a SCHED_LOWLATENCY, it seems like it
> might be useful, but I wonder how useful.

It's perfectly usable for video, though the administrator may have to
configure a considerably larger share of the cpu for SOFTRR in that case,
especially if a software codec is being used.  I don't see any reason why
the administrator of a single-user system could not make 95% of it available
for realtime media.  The remaining 5% will still be more than a 486 (probably)
which is enough to take care of all the things that the system absolutely
needs to take care of.

That said, I'm only interested in audio at the moment.  If everything works
out, it will be a non-change to use it for video as well.

Regards,

Daniel

