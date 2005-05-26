Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261673AbVEZSLV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261673AbVEZSLV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 May 2005 14:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261675AbVEZSLV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 May 2005 14:11:21 -0400
Received: from alog0415.analogic.com ([208.224.222.191]:14565 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261673AbVEZSLE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 May 2005 14:11:04 -0400
Date: Thu, 26 May 2005 14:10:07 -0400 (EDT)
From: "Richard B. Johnson" <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Olivier Croquette <ocroquette@free.fr>
cc: LKML <linux-kernel@vger.kernel.org>, george@mvista.com
Subject: Re: 2.6.11 timeval_to_jiffies() wrong for ms resolution timers
In-Reply-To: <4296019B.8070006@free.fr>
Message-ID: <Pine.LNX.4.61.0505261350480.7195@chaos.analogic.com>
References: <21FFE0795C0F654FAD783094A9AE1DFC07AFE7C1@cof110avexu4.global.avaya.com>
 <4294D9C6.3060501@mvista.com> <4296019B.8070006@free.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 26 May 2005, Olivier Croquette wrote:

>
>
> George Anzinger wrote:
>> If you really want millisecond accuracy, you may
>> need to consider another platform....
>
> Are some platform known for the precision of their timers?
>
> Could hardware help? (like a PCI timer card)
>

You can make hardware timers with picosecond resolution. The problem
is that the only way to use that kind of resolution is to program
some hardware to do something when the previously-set time is up.

A CPU (any CPU) takes a variable amount of time to branch when
a hardware interrupt occurs. The time to branch from what it's
doing to some software to handle the interrupt depends upon what
it is doing and even how long it has been doing what it's doing.
This is because modern CPUs have caches both for the instruction
fetching and for data.

This variable amount of time is called jitter. It may be several
tens of microseconds with ix86 machines and even greater with
some other CPUs like the PPC. CPUs that run in a flat mode with
no instruction cache such as some DSPs have jitter that is much
lower (TMS320C30 comes to mind).

The time for a sleeping (waiting) task to get the CPU is much
greater than the jitter. Once in the ISR, some wake-up call
is "scheduled" and the interrupt returns. A CPU hog may have
been using the CPU when the interrupt occurred. It will continue
to use the CPU until its time-slot (quantum) has expired. This
could be a whole millisecond if HZ is 1000, 10 milliseconds if
100. It's only then that your sleeping task gets awakened
by the interrupting event.

So, accurate waking up is not guaranteed on any multi-user,
multitasking system because you don't know what a user has
been doing with the CPU. On a dedicated machine, one can
have tasks that are most always sleeping or waiting for
I/O so, the latency can come way down. However, signaling
a task, based upon some time will never be very accurate
anywhere.

For accurate events, you need to make hardware that contains
a time-base and an event-counter. Software sets the event-counter.
When the event-counter equals the time-base, the hardware
does something. That, it can do accurately.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.11.9 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
