Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135363AbREHVeB>; Tue, 8 May 2001 17:34:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135404AbREHVdv>; Tue, 8 May 2001 17:33:51 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:8648 "EHLO
	c0mailgw02.prontomail.com") by vger.kernel.org with ESMTP
	id <S135363AbREHVdp>; Tue, 8 May 2001 17:33:45 -0400
Message-ID: <3AF8661D.F3A08367@mvista.com>
Date: Tue, 08 May 2001 14:33:17 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.72 [en] (X11; I; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <Pine.LNX.3.95.1010508154726.29540A-100000@chaos.analogic.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Richard B. Johnson" wrote:
> 
> To driver wizards:
> 
> I have a driver which needs to wait for some hardware.
> Basically, it needs to have some code added to the run-queue
> so it can get some CPU time even though it's not being called.
> 
> It needs to get some CPU time which can be "turned on" or
> "turned off" as a result of an interrupt or some external
> input from  an ioctl().
> 
> So I thought that the "tasklet" would be ideal. However, the
> scheduler "thinks" that a tasklet is an interrupt, so any
> attempt to sleep in the tasklet results in a kernel panic,
> "ieee scheduling in an interrupt..., BUG sched.c line 688".
> 
> Next, I added code to try queue_task(). This has the same problem.
> 
> Basically the procedure needs to do:
> 
> procedure()
> {
>     if(some_event)
>         schedule_timeout(n);               /* Needs to sleep */
>     else if(something_else)
>         do_something();
>    queue_task(procedure, &tq_immediate);   /* Needs to queue itself again */
> }
> 
> Since I'm running against a time-line, I temporarily  gave the module
> some CPU time through an ioctl(), i.e., a separate task that does nothing
> except repeatably execute ioctl(GIVE_CPU, NULL); This shows that the
> driver actually works. It's a GPIB driver so it needs to get the
> CPU to find out if it's addressed to listen, etc. These events don't
> produce interrupts.
> 
> So, what am I supposed to do to add a piece of driver code to the
> run queue so it gets scheduled occasionally?
> 
> Cheers,
> Dick Johnson

How about something like:

#include <linux/timer.h>

void queue_task(void process_timeout(void), unsigned long timeout,
struct timer_list *timer, unsigned long data)
{
	unsigned long expire = timeout + jiffies;

	init_timer(&timer);
	timer->expires = expire;
	timer->data = data;
	timer->function = process_timeout;

	add_timer(&timer);
}


You will have to define the "struct timer_list timer".  This should
cause the function passed to be called after "timeout" jiffies (1/HZ,
not to be confused with 10 ms).  If you want to stop the timer early do:

	del_timer_sync(&timer);

"data" was not used in you example, but process_timeout will be passed
"data" when it is called.  This routine is called as part of the timer
interrupt, so it must be fast and should not do schedule() calls.  It
could queue a tasklet, however, to relax constraints a bit.

George
