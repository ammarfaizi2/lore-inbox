Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133046AbRDRQpL>; Wed, 18 Apr 2001 12:45:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132960AbRDRQpD>; Wed, 18 Apr 2001 12:45:03 -0400
Received: from chaos.analogic.com ([204.178.40.224]:4868 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S133027AbRDRQo7>; Wed, 18 Apr 2001 12:44:59 -0400
Date: Wed, 18 Apr 2001 12:44:36 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: george anzinger <george@mvista.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule() seems to have changed.
In-Reply-To: <3ADDC00A.2DFE366F@mvista.com>
Message-ID: <Pine.LNX.3.95.1010418124358.927A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 18 Apr 2001, george anzinger wrote:

> "Richard B. Johnson" wrote:
> > 
> > It seems that the nature of schedule() has changed in recent
> > kernels. I am trying to update my drivers to correspond to
> > the latest changes. Here is an example:
> > 
> > This waits for some hardware (interrupt sets flag), time-out in one
> > second. This is in an ioctl(), i.e., user context:
> > 
> >     set_current_state(TASK_INTERRUPTIBLE);
> >     current->policy = SCHED_YIELD;
> >     timer = jiffies + HZ;
> >     while(time_before(jiffies, timer))
> >     {
> >         if(flag) break;
> >         schedule();
> >     }
> >     set_current_state(TASK_RUNNING);
> > 
> > The problem is that schedule() never returns!!! If I use
> > schedule_timeout(1), it returns, but the granularity
> > of the timeout interval is such that it slows down the
> > driver (0.1 ms).
> > 
> > So, is there something that I'm not doing that is preventing
> > schedule() from returning?  It returns on a user-interrupt (^C),
> > but otherwise gives control to the kernel forever.
> > 
> When schedule() is entered with TASK_INTERRUPTIBLE (actually with
> current state !=TASK_RUNNING) it takes the task out of the run_list.  It
> has been this way for a long time.  The normal way for the task to move
> back to the run_list is for wake_up to be called, which, of course (^C)
> does.  In your case it would be best if you could get what ever sets
> "flag" to call wake_up.
> 
> If what you really want to do is to spin in a SCHED_YIELD waiting for
> "flag" you need to a.) move the setting of SCHED_YIELD inside the while,
> and b.) eliminate the setting of current_state (both of them).
> 
> George

Okay. Thanks. That works
 

Cheers,
Dick Johnson

Penguin : Linux version 2.2.4 on an i686 machine (400.59 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


