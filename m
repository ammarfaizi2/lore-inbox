Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261505AbVEACGS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261505AbVEACGS (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Apr 2005 22:06:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261510AbVEACGS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Apr 2005 22:06:18 -0400
Received: from bay10-f43.bay10.hotmail.com ([64.4.37.43]:17293 "EHLO
	hotmail.com") by vger.kernel.org with ESMTP id S261505AbVEACGI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Apr 2005 22:06:08 -0400
Message-ID: <BAY10-F433C0F72A446C39BA90258D9260@phx.gbl>
X-Originating-IP: [146.229.139.228]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <1112840864.22577.38.camel@localhost.localdomain>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: rostedt@goodmis.org
Cc: linux-kernel@vger.kernel.org
Subject: Re: scheduler/SCHED_FIFO behaviour
Date: Sun, 01 May 2005 07:36:05 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 01 May 2005 02:06:05.0797 (UTC) FILETIME=[55458150:01C54DF2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


hi

  I spkoe to you some days ago regarding scheduling two processes together 
on a HT.As I told you before I run them as SCHED_FIFO processes.I understood 
the theory you told me in your previous reply as to why both of SCHED_FIFO 
processes get scheduled only once and then run till completion.

But, sometimes a see a occasional reschedulei.e., the 2 processes get 
scheduled one more time after they are scheduled for the 1st time. I ran my 
code 100 times and observed this behavior 8 out of  100 times. What could be 
the reason?
(As I said i want my 2 processes to run together without any reschedule 
after they are scheduled for the first time).

Thanks
Arun
>From: Steven Rostedt <rostedt@goodmis.org>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: LKML <linux-kernel@vger.kernel.org>
>Subject: Re: scheduler/SCHED_FIFO behaviour
>Date: Wed, 06 Apr 2005 22:27:44 -0400
>
>On Thu, 2005-04-07 at 07:11 +0530, Arun Srinivas wrote:
> > I am not sure if my question was clear enough or I couldnt interpret you
> > answer correctly.(If it was the case I apologise for that).
> >
> > My question is, as I said I am measuring the schedule time difference
> > between my 2 of my SCHED_FIFO process in schedule() .But, I get only one 
>set
> > of readings (i.e., schedule() is being called once which implies my 
>process
> > is being scheduled only once and run till completion)
> >
> > Also, as I said my interrupts are being processed during this time.I
> > inspected /proc/interrupts for this.So, my question was if interrupts 
>heve
> > been processed several times the 2 SCHED_FIFO process which has been
> > interrupted must have been resecheduled several times and for this upon
> > returning from the interrupt handler the schedule() function must have 
>been
> > called  several times to schedule the 2 process which were running.But, 
>as I
> > said I get only one reading??
> >
> > >From your reply, I come to understand that when an interrupt interrupts 
>my
> > user process.....it runs straight way ....but upon return from the 
>interrupt
> > handler does it not call schedule() to again resume my interrupted 
>process?
>
>Exactly! Even going back to a user process, if that process is the
>highest priority process than it does not need to call schedule.
>Actually the only time it would call schedule, is if the interrupt
>called wake_up_process, or did something that needed the need_resched
>for the running task set.  Even if wake_up_process was called, if the
>process was not higher in priority than the running process, then it
>would not preempt it.
>
>So...
>
>1) Task running in user land.
>2) interrupt goes off, switch to kernel mode.
>3) execute interrupt service routine.
>4) ISR calls wake_up_process (most likely on ksoftirqd)
>5) ksoftirqd not as high a priority as running process (don't set
>need_resched)
>6) return from interrupt. need_resched not set.
>7) go back to user process running in user land.
>
>There, is that clear. schedule is never called. Set ksoftirqd higher in
>priority than your tasks, and you might start seeing scheduling. But
>sometimes the functions needed to execute are done on return from
>interrupt and not though ksoftirqd, so you still might not see a
>schedule. But I'm sure you will.
>
>-- Steve
>
>

_________________________________________________________________
Trailblazer Narain Karthikeyan http://server1.msn.co.in/sp05/tataracing/ 
Will he be rookie of the year?

