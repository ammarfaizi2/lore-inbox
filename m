Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262397AbTKRNXX (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Nov 2003 08:23:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262564AbTKRNXX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Nov 2003 08:23:23 -0500
Received: from chaos.analogic.com ([204.178.40.224]:7299 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S262397AbTKRNXT
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Nov 2003 08:23:19 -0500
Date: Tue, 18 Nov 2003 08:24:45 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] jiffies overflow & timers.
In-Reply-To: <3FB9EC19.80107@softhome.net>
Message-ID: <Pine.LNX.4.53.0311180802090.30076@chaos>
References: <3FB91527.50007@softhome.net> <Pine.LNX.4.53.0311171347540.24608@chaos>
 <3FB9373D.6010300@softhome.net> <Pine.LNX.4.53.0311171624100.27657@chaos>
 <3FB9EC19.80107@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 18 Nov 2003, Ihar 'Philips' Filipau wrote:

> Richard B. Johnson wrote:
> >>Richard B. Johnson wrote:
> >>
> >>>Use jiffies as other modules use it:
> >>>
> >>>        tim = jiffies + TIMEOUT_IN_HZ;
> >>>        while(time_before(jiffies, tim))
> >>>        {
> >>>            if(what_im_waiting_for())
> >>>                break;
> >>>            current->policy |= SCHED_YIELD;
> >>>            schedule();
> >>>        }
> >>>//
> >>>// Note that somebody could have taken the CPU for many seconds
> >>>// causing a 'timeout', therefore, you need to add one more check
> >>>// after loop-termination:
> >>>//
> >>>            if(what_im_waiting_for())
> >>>                good();
> >>>            else
> >>>                timed_out();
> >>>
> >>>Overflow is handled up to one complete wrap of jiffies + TIMEOUT. It's
> >>>only the second wrap that will fail and if you are waiting several
> >>>months for something to happen in your code, the code is broken.
> >>>
>
>
>    time_before(a,b) == (((long)a - (long)b) < 0)
>
>    Can you explain me this games with signs there?
>    Or this code expected to work reliably for timeouts < (ULONG_MAX/2)?
>    time_before/time_after - do implicit conversion to signed types,
> while jiffies/friends are all unsigned. If one day gcc will be fixed -
> and it will truncate data here as I expect it to do - this will not work
> at all. Or this is a feature of 2-complement archs?
>    (ldd2 again is silent on this topic - and I'm totally confused...)
>

There are no games here. The macro does explicit conversion (for the
comparison only) so that the comparison operation will work correctly.
It will work correctly if your time-outs are less than about 1.5 months
(ULONG_MAX/2)-1. If you have time-outs exceeding that, you should rethink
your line of work.

It has nothing to do with 2s-compliment and everything to do with
signed integer comparison. In 32-bit land, 0xffffffff is -1. When
I add a number, say 10 to that, causing overflow, the number is
0x00000009. When comparing, -1 is still less than +9 so the fact
that some wrap occurred is not of consequence.

If gcc fails to work this way, then gcc is broken. It is unlikely
that somebody will break gcc to make this not work since it would
make arithmetic of signed integers wrong.
        -1 +         -1 =         -2
0xffffffff + 0xffffffff = 0xfffffffe   -> a large wrap occurred
here!

>
> >
> > schedule() is the kernel procedure that gives the CPU to somebody
> > while your code is waiting for something to happen. You cannot
> > call that in an interrupt or when a lock is held.
> >
>
>    It is state machine, it is event driven - there is nothing that can
> yield CPU to someone else, because in first place it does not take CPU ;-)))
>    Right now it is run from tasklet - so ksoftirqd context.
>

If you are looping in a tasklet, waiting for something to happen, you
are "locked up" until the event which may never happen. If for some
"bad hardware that they won't fix" reason, you must loop, then you
need to create a kernel thread. If the hardware is good and you
decided to write a driver this way, then you need to re-think
what you are doing.

[SNIPPED rest...]


Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


