Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262976AbTFDGzv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jun 2003 02:55:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262984AbTFDGzu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jun 2003 02:55:50 -0400
Received: from mail.gmx.de ([213.165.64.20]:16596 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S262976AbTFDGzt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jun 2003 02:55:49 -0400
Message-Id: <5.2.0.9.2.20030604074452.00ce0380@pop.gmx.net>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Wed, 04 Jun 2003 09:13:43 +0200
To: Bill Davidsen <davidsen@tmr.com>
From: Mike Galbraith <efault@gmx.de>
Subject: Re: [Linux-ia64] Re: web page on O(1) scheduler
Cc: Olivier Galibert <galibert@pobox.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.3.96.1030603234616.16495B-100000@gatekeeper.tmr.c
 om>
References: <5.2.0.9.2.20030529062657.01fcaa50@pop.gmx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At 11:52 PM 6/3/2003 -0400, Bill Davidsen wrote:
>On Thu, 29 May 2003, Mike Galbraith wrote:
>
> > That would still suck rocks for mutex usage... as it must with any
> > implementation of sched_yield() in the presence of peer threads who are 
> not
> > playing with the mutex.  Actually, using sched_yield() makes no sense what
> > so ever to me, other than what Arjan said.  It refers to yielding your
> > turn, but from userland "your turn" has no determinate meaning.  There is
> > exactly one case where it has a useable value, and that is  when you're 
> the
> > _only_ runnable thread... at which time it means precisely zero. (blech)
>
>No, it works usefully without threads at all, with processes sharing a
>spinlock in shared memory. If the lock is closed process does a
>sched_yeild() to allow whoever has the lock to run. Yes to all comments
>WRT order of running, if you care you don't do this, clearly. But in the
>case where a process forks to a feeder and consumer it's faster than
>semaphores, signal, etc.

It can only be faster when there is no other source of competition for the 
cpu.  If there is no other competition, the current implementation won't 
hurt, because you'll switch arrays at very high speed... the queue rotation 
will be that which I described earlier.

There's only one real difference between going to sleep and waiting for a 
signal and your description of a proper yield.  Both place you at the end 
of your queue.  One immediately, the other upon wakeup.  How much "other 
stuff" is in the system determines task throughput in both cases.

>All that's needed is to put the yeild process on the end of the
>appropriate run queue and reschedule. Doing anything else results in bad
>performance and no gain to anything else.

And if either party has expired it's timeslice, who is the active task 
yielding to?  Why do you insist that those who have expired their slice 
should not be considered eligible players?  Now, let's throw a real 
monkey-wrench into the works...

What happens with your version of sched_yield() if one of your producer 
consumer pair is SCHED_RR, or worse - SCHED_FIFO [no timeslice, "turn" 
means until it blocks whether that be voluntary or not], and sched_yield() 
is the only way it can get rid of the cpu (ie it's a high priority pure cpu 
burner)?  If all you do is rotate the active queue and reschedule, you have 
just guaranteed that sched_yield() will have zero meaning.  The same exact 
thing (but less exaggerated) will happen if producer and consumer are not 
at the same dynamic priority.  You can call schedule() all you want if 
you're the highest priority runnable task... you get to keep the cpu 
whether you really want it or not.  I still say that sched_yield() makes 
zero sense for this usage.  There is only one guaranteed way to give up the 
cpu, and that is to sleep.

Using sched_yield() as a mutex is exactly the same as using a party line 
for private conversation.

         -Mike 

