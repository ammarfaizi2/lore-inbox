Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261535AbVDECRJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261535AbVDECRJ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 22:17:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261540AbVDECRJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 22:17:09 -0400
Received: from omc3-s17.bay6.hotmail.com ([65.54.249.91]:25166 "EHLO
	omc3-s17.bay6.hotmail.com") by vger.kernel.org with ESMTP
	id S261535AbVDECQ6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 22:16:58 -0400
Message-ID: <BAY10-F20EDF8B5558E2E8945A4DAD93C0@phx.gbl>
X-Originating-IP: [146.229.160.228]
X-Originating-Email: [getarunsri@hotmail.com]
In-Reply-To: <1112656624.5147.34.camel@localhost.localdomain>
From: "Arun Srinivas" <getarunsri@hotmail.com>
To: rostedt@goodmis.org
Cc: juhl-lkml@dif.dk, linux-kernel@vger.kernel.org
Subject: Re: scheduler/SCHED_FIFO behaviour
Date: Tue, 05 Apr 2005 07:46:57 +0530
Mime-Version: 1.0
Content-Type: text/plain; format=flowed
X-OriginalArrivalTime: 05 Apr 2005 02:16:57.0625 (UTC) FILETIME=[8B0D1090:01C53985]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ok.My program runs for 30 sec. approx. I did
#!/bin/sh
cat /proc/interrupts
run_test
cat /proc/interrupts

and I see there is quite some difference in the numbers.....meaning 
interrupts have been processed by the respective processor when my 
SCHED_FIFO processes have been running on both the cpu's.

But, then I am not sure why I am getting only 1 reading for the timediff. of 
schedule between my 2 processes.I do the following in my schedule() in 
sched.c:
( I make the kernel know the pid's of my 2 process...lets say pid1 and pid2)

/* in function schedule() in sched.c*/
schedule()
{
   need _resched:
                                /* after now=sched_clock(); I insert my code 
here*/
                              if(current->pid=pid1)
                                 {
                                    time1=now;
                                  }
                               elseif (current->pid=pid2)
                                 {
                                    time2=now;
                                 }
                                 /*after i get the 2 values for time1 and 
time2*/
                                 timediff= time1-time2;                // or 
time2 - time1 which ever is greater*/
                                 printk(KERN_ERR "%llu",timediff);
}

So, what I want from the above code is whenever process1 or process2 is 
being scheduled measure the time and print the timedifference. But, when I 
run my 2 processes as SCHED_FIFO processes i get only one set of 
readings....indicating they have been scheduled only once and run till 
completion.

But, as we saw above if interrupts have been processed they must have been 
scheduled several times(i.e., schedule() called several times). Is my 
measurement procedure not correct?

please help.
thanks
arun


>From: Steven Rostedt <rostedt@goodmis.org>
>To: Arun Srinivas <getarunsri@hotmail.com>
>CC: juhl-lkml@dif.dk, LKML <linux-kernel@vger.kernel.org>
>Subject: Re: scheduler/SCHED_FIFO behaviour
>Date: Mon, 04 Apr 2005 19:17:04 -0400
>
>On Tue, 2005-04-05 at 04:36 +0530, Arun Srinivas wrote:
> > I am scheduling 2 SCHED_FIFO processes and set them affinity( process A 
>runs
> > on processor 1 and process B runs on processor 2), on a HT processor.(I 
>did
> > this cause I wanted to run them together).Now, in schedule() I measure 
>the
> > timedifference between when they are scheduled. I found that when I
> > introduce these 2 processes as SCHED_FIFO they are
> >
> > 1)scheduled only once and run till completion ( they running time is 
>around
> > 2 mins.)
>
>If they are the highest priority task, and running as FIFO this is the
>proper behavior.
>
> > 2)entire system appears frozen....no mouse/key presses detected until 
>the
> > processes exit.
> >
>
>If X is not at a higher priority than the test you are running, it will
>never get a chance to run.
>
> > >From what I observed does it mean that even the OS / interrupt handler 
>does
> > not occur during the entire period of time these real time processes 
>run??
> > (as I said the processes run in minutes).
>
>The interrupts do get processed. Now the bottom halves and tasklets may
>be starved if they are set at a lower priority than your test (ie. the
>ksoftirqd thread). But most likely they are processed too.
>
> > How can I verify that?
> >
>
>#!/bin/sh
>cat /proc/interrupts
>run_test
>cat /proc/interrupts
>
>If the run_test takes 2 minutes, you should see a large difference in
>the two outputs.
>
>-- Steve
>
> > Thanks
> > Arun
>
>

_________________________________________________________________
The MSN Survey! 
http://www.cross-tab.com/surveys/run/test.asp?sid=2026&respid=1 Help us help 
you better!

