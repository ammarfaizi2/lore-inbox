Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135218AbRDRQ0a>; Wed, 18 Apr 2001 12:26:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135219AbRDRQ0U>; Wed, 18 Apr 2001 12:26:20 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:31916 "EHLO
	c0mailgw04.prontomail.com") by vger.kernel.org with ESMTP
	id <S135218AbRDRQ0O>; Wed, 18 Apr 2001 12:26:14 -0400
Message-ID: <3ADDC00A.2DFE366F@mvista.com>
Date: Wed, 18 Apr 2001 09:25:46 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule() seems to have changed.
In-Reply-To: <Pine.LNX.3.95.1010418102332.1771A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> It seems that the nature of schedule() has changed in recent
> kernels. I am trying to update my drivers to correspond to
> the latest changes. Here is an example:
> 
> This waits for some hardware (interrupt sets flag), time-out in one
> second. This is in an ioctl(), i.e., user context:
> 
>     set_current_state(TASK_INTERRUPTIBLE);
>     current->policy = SCHED_YIELD;
>     timer = jiffies + HZ;
>     while(time_before(jiffies, timer))
>     {
>         if(flag) break;
>         schedule();
>     }
>     set_current_state(TASK_RUNNING);
> 
> The problem is that schedule() never returns!!! If I use
> schedule_timeout(1), it returns, but the granularity
> of the timeout interval is such that it slows down the
> driver (0.1 ms).
> 
> So, is there something that I'm not doing that is preventing
> schedule() from returning?  It returns on a user-interrupt (^C),
> but otherwise gives control to the kernel forever.
> 
When schedule() is entered with TASK_INTERRUPTIBLE (actually with
current state !=TASK_RUNNING) it takes the task out of the run_list.  It
has been this way for a long time.  The normal way for the task to move
back to the run_list is for wake_up to be called, which, of course (^C)
does.  In your case it would be best if you could get what ever sets
"flag" to call wake_up.

If what you really want to do is to spin in a SCHED_YIELD waiting for
"flag" you need to a.) move the setting of SCHED_YIELD inside the while,
and b.) eliminate the setting of current_state (both of them).

George
