Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263703AbTKQS7d (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Nov 2003 13:59:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263715AbTKQS7d
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Nov 2003 13:59:33 -0500
Received: from chaos.analogic.com ([204.178.40.224]:24194 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S263703AbTKQS7a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Nov 2003 13:59:30 -0500
Date: Mon, 17 Nov 2003 14:01:56 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Ihar 'Philips' Filipau" <filia@softhome.net>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [Q] jiffies overflow & timers.
In-Reply-To: <3FB91527.50007@softhome.net>
Message-ID: <Pine.LNX.4.53.0311171347540.24608@chaos>
References: <3FB91527.50007@softhome.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Nov 2003, Ihar 'Philips' Filipau wrote:

> Hello!
>
[SNIPPED...]

Use jiffies as other modules use it:

        tim = jiffies + TIMEOUT_IN_HZ;
        while(time_before(jiffies, tim))
        {
            if(what_im_waiting_for())
                break;
            current->policy |= SCHED_YIELD;
            schedule();
        }
//
// Note that somebody could have taken the CPU for many seconds
// causing a 'timeout', therefore, you need to add one more check
// after loop-termination:
//
            if(what_im_waiting_for())
                good();
            else
                timed_out();

Overflow is handled up to one complete wrap of jiffies + TIMEOUT. It's
only the second wrap that will fail and if you are waiting several
months for something to happen in your code, the code is broken.

>
>     My module has to maintain list of timers. I cannot reuse directly
> struct timer_list - since it uses jiffies and jiffies do wrap on overflow.
>

If you need a list of timers, you grab the current jiffies plus
the current test value. After that, you use the time_before() macro
to test them.

>
>    So my question - how to detect that jiffies had overflown?
>

You don't. Correct code will not require it. Correct code uses
jiffies as a relative value, not an absolute one. If you need
an absolute time value, you need to use sys_gettimeofday(), but
you should never use this for a time-out, only some time-stamp
because not all bits are exercised.

>    Is the following code is sufficient?
>    (Assuming that I will not try to set timer longer than (~0UL/(HZ))
> seconds)
>

See above for code that uses jiffies.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.22 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


