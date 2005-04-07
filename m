Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262389AbVDGC2M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262389AbVDGC2M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Apr 2005 22:28:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262393AbVDGC2M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Apr 2005 22:28:12 -0400
Received: from ms-smtp-03.nyroc.rr.com ([24.24.2.57]:43496 "EHLO
	ms-smtp-03.nyroc.rr.com") by vger.kernel.org with ESMTP
	id S262389AbVDGC1v (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Apr 2005 22:27:51 -0400
Subject: Re: scheduler/SCHED_FIFO behaviour
From: Steven Rostedt <rostedt@goodmis.org>
To: Arun Srinivas <getarunsri@hotmail.com>
Cc: LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <BAY10-F593A133679EB2005D70E1FD93E0@phx.gbl>
References: <BAY10-F593A133679EB2005D70E1FD93E0@phx.gbl>
Content-Type: text/plain
Organization: Kihon Technologies
Date: Wed, 06 Apr 2005 22:27:44 -0400
Message-Id: <1112840864.22577.38.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-04-07 at 07:11 +0530, Arun Srinivas wrote:
> I am not sure if my question was clear enough or I couldnt interpret you 
> answer correctly.(If it was the case I apologise for that).
> 
> My question is, as I said I am measuring the schedule time difference 
> between my 2 of my SCHED_FIFO process in schedule() .But, I get only one set 
> of readings (i.e., schedule() is being called once which implies my process 
> is being scheduled only once and run till completion)
> 
> Also, as I said my interrupts are being processed during this time.I 
> inspected /proc/interrupts for this.So, my question was if interrupts heve 
> been processed several times the 2 SCHED_FIFO process which has been 
> interrupted must have been resecheduled several times and for this upon 
> returning from the interrupt handler the schedule() function must have been 
> called  several times to schedule the 2 process which were running.But, as I 
> said I get only one reading??
> 
> >From your reply, I come to understand that when an interrupt interrupts my 
> user process.....it runs straight way ....but upon return from the interrupt 
> handler does it not call schedule() to again resume my interrupted process? 

Exactly! Even going back to a user process, if that process is the
highest priority process than it does not need to call schedule.
Actually the only time it would call schedule, is if the interrupt
called wake_up_process, or did something that needed the need_resched
for the running task set.  Even if wake_up_process was called, if the
process was not higher in priority than the running process, then it
would not preempt it.

So...

1) Task running in user land.
2) interrupt goes off, switch to kernel mode.
3) execute interrupt service routine.
4) ISR calls wake_up_process (most likely on ksoftirqd)
5) ksoftirqd not as high a priority as running process (don't set
need_resched)
6) return from interrupt. need_resched not set. 
7) go back to user process running in user land.

There, is that clear. schedule is never called. Set ksoftirqd higher in
priority than your tasks, and you might start seeing scheduling. But
sometimes the functions needed to execute are done on return from
interrupt and not though ksoftirqd, so you still might not see a
schedule. But I'm sure you will.

-- Steve


