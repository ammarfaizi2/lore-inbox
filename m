Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136401AbREINE0>; Wed, 9 May 2001 09:04:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136400AbREINER>; Wed, 9 May 2001 09:04:17 -0400
Received: from chaos.analogic.com ([204.178.40.224]:49793 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S136401AbREINEG>; Wed, 9 May 2001 09:04:06 -0400
Date: Wed, 9 May 2001 09:04:01 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: george anzinger <george@mvista.com>
cc: Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: 
In-Reply-To: <3AF8661D.F3A08367@mvista.com>
Message-ID: <Pine.LNX.3.95.1010509085529.8159A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 May 2001, george anzinger wrote:

> "Richard B. Johnson" wrote:
> > 
> > To driver wizards:
> > 
> > I have a driver which needs to wait for some hardware.
> > Basically, it needs to have some code added to the run-queue
> > so it can get some CPU time even though it's not being called.
> > 
[SNIPPED...]

> How about something like:
> 
> #include <linux/timer.h>
> 
> void queue_task(void process_timeout(void), unsigned long timeout,
> struct timer_list *timer, unsigned long data)
> {
> 	unsigned long expire = timeout + jiffies;
> 
> 	init_timer(&timer);
> 	timer->expires = expire;
> 	timer->data = data;
> 	timer->function = process_timeout;
> 
> 	add_timer(&timer);
> }
> 
> 
> You will have to define the "struct timer_list timer".  This should
> cause the function passed to be called after "timeout" jiffies (1/HZ,
> not to be confused with 10 ms).  If you want to stop the timer early do:
> 
> 	del_timer_sync(&timer);
> 
> "data" was not used in you example, but process_timeout will be passed
> "data" when it is called.  This routine is called as part of the timer
> interrupt, so it must be fast and should not do schedule() calls.  It
> could queue a tasklet, however, to relax constraints a bit.
> 
> George

This is all very nice. This is basically what the 'tasklet' does.
The problem is that I have in my code something like this:


/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *  This waits for an event-flag to be TRUE. It takes a pointer to
 *  that flag, plus the number of timer-ticks to wait. If it times-
 *  out, it returns -ETIME. Otherwise it returns 0.
 */
static int waitfor(volatile int *event, int mask, int ticks)
{
    unsigned long timer;
    int stat;
    DEB(printk("%s waitfor\n", info->dev));
    stat = -ETIME;
    timer = jiffies + (unsigned long) ticks;
    while(!!time_before(jiffies, timer))
    {
        if(!!(*event & mask))
        {
            stat = 0;
            break;
        }
        schedule();
    }
    return stat; 
}
/*-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=*/
/*
 *  This waits for a bit in a port to be TRUE. It takes the OFFSET of
 *  that port, plus the number of timer-ticks to wait. If it times-
 *  out, it returns -ETIME. Otherwise it returns 0.
 */
static int waitport(int offset, int mask, int ticks)
{
    unsigned long timer;
    int stat;
    DEB(printk("%s waitport\n", info->dev));
    stat = -ETIME;
    timer = jiffies + (unsigned long) ticks;
    while(!!time_before(jiffies, timer))
    {
        if(!!(READ_TNT(offset) & mask))
        {
            stat = 0;
            break;
        }
        schedule();
    }
    return stat; 
}


Both of these procedures schedule() while waiting for something to
happen. The wait can be very long (1 second) so I don't want to
just spin eating CPU cycles. I have to give the CPU to somebody.





Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

"Memory is like gasoline. You use it up when you are running. Of
course you get it all back when you reboot..."; Actual explanation
obtained from the Micro$oft help desk.


