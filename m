Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292378AbSB0P1i>; Wed, 27 Feb 2002 10:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292578AbSB0P1a>; Wed, 27 Feb 2002 10:27:30 -0500
Received: from chaos.analogic.com ([204.178.40.224]:27276 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S292579AbSB0P1P>; Wed, 27 Feb 2002 10:27:15 -0500
Date: Wed, 27 Feb 2002 10:29:18 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Nigel Gamble <nigel@nrg.org>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>,
        Linux kernel <linux-kernel@vger.kernel.org>
Subject: Re: schedule()
In-Reply-To: <Pine.LNX.4.40.0202261638230.20308-100000@cosmic.nrg.org>
Message-ID: <Pine.LNX.3.95.1020227095255.12981B-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 26 Feb 2002, Nigel Gamble wrote:
[SNIPPED]
> On Tue, 26 Feb 2002, Jeff Garzik wrote:
> > "Richard B. Johnson" wrote:
[SNIPPED]
> >
> > Call yield() or better yet, schedule_timeout()
> 
> Yes, please use schedule_timeout() if at all possible, or make sure that
> the loop will only ever execute for a few 100us at most.
>

This can't be guaranteed. Many machine-to-machine communications
links need to continually retry (forever) without hurting the
operation of anything else. Yes, there are a few wasted CPU cycles,
but everything needs to run until the "plug that got kicked out"
is discovered and plugged back in (days, perhaps).

Its almost like; "There is no such thing as a fatal hardware error...".
Software needs to report that things are not right and also needs
to report when things got fixed. A bad chip is merely an exception
that needs to be worked around in software.

So, I don't have anything that loops forever when something is
broken. However, it will retry forever until it's fixed.
 
> One thing to bear in mind is that using yield() will waste CPU time if
> the code is ever called by a real-time process (unless it is a SCHED_RR
> process with other runnable SCHED_RR processes at the same priority),
> because there will be no other process that the scheduler is allowed to
> run, so the RT process will just be chosen to run again, with no delay.
> 

Yeah. I looked at the code and it doesn't schedule directly in 2.4.1.
It just says "reschedule later on after I'm preempted". I don't think
my code wants to spin to the next HZ before it gives up the CPU. It
already knows that the hardware is not ready and has volunteered to
give up the CPU now. After the next HZ, the hardware would be ready.
The driver(s) count on the fact that most everybody sleeps (is I/O bound)
most of the while so it will probably be getting the CPU back in less
than a HZ most of the time.

> We really need high resolution timers, so that schedule_timeout() can be
> used for delays of less than one jiffy.
> 

Maybe, but we really need a sleep_on_proc(procedure, timeout) where
procedure is a pointer to a procedure that returns 0 for okay, and
takes a pointer-to-void (so the caller can pass whatever parameters it
needs).

/*
 *  Returns 0 if the procedure returned 0.
 *  Returns -1 if it timed out.
 */ 
int sleep_on_proc(int(*procedure)(void *), size_t timeout);

The kernel can decide how to handle the scheduling and the drivers
are not affected by such changes.


Driver code would do something like:

int my_spinner(void *inf)
{
    FOO *foo = (FOO *) inf;     /* Get my parameters */
    if(readl(foo->status) & READY)
         return 0;
    return -1;
}
 
To use this, the kernel sleeper would be called as:

    if(sleep_on_proc(my_spinner(inf), TIMEOUT))
        fail_thing();
    else
        good_thing();


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (797.90 BogoMips).

        111,111,111 * 111,111,111 = 12,345,678,987,654,321

