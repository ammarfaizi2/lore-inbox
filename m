Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261512AbVCHTFq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261512AbVCHTFq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 14:05:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVCHTFp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 14:05:45 -0500
Received: from alog0465.analogic.com ([208.224.222.241]:28800 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261512AbVCHTFc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 14:05:32 -0500
Date: Tue, 8 Mar 2005 14:03:21 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Francesco Oppedisano <francesco.oppedisano@gmail.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: about interrupt latency
In-Reply-To: <875fe4a50503081039328ffede@mail.gmail.com>
Message-ID: <Pine.LNX.4.61.0503081345080.12268@chaos.analogic.com>
References: <875fe4a50503081039328ffede@mail.gmail.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 8 Mar 2005, Francesco Oppedisano wrote:

> Hi,
> i'm trying to estimate the interrupt latency (time between hardware
> interrrupt and the start of the ISR) of a linux kernel 2.4.29 and i
> used a simple tecnique: inside the do_timer_interrupt i read the 8259
> counter to obtain the elapsed time.
> By this mean i found a latency of about 6/7 microseconds that is very
> similar to the time measured in some articles but with CPU much slower
> while i expected the latency was shorter on faster CPUs.
> So, my questions are:
> 1)what's the depency between the interrupt latency and the CPU speed?
> 2)what are the factors at the origin of th interrupt latency?
>
> Than u very much
>
> Francesco Oppedisano

You can't measure interrupt latency that way even
though you may get the "correct" answer!

Make a simple module that uses IRQ7, the printer-port
interrupt. Inside your ISR, you toggle one of the
printer-port bits. Program the printer port to
generate the interrupt when its control bit
is triggered.

Now, connect a function generator to toggle the
printer control bit. Also use this transition to
trigger an oscilloscope while looking at its trace
on one channel. Connect the other channel to the
bit that's being toggled in your ISR.

Observe the time between the trigger-trace and
the toggle-trace. That, minus the few nanoseconds
necessary to execute your ISR code, is the
interrupt latency when using that specific interrupt
source. PCI/Bus devices have lower latencies.

The CPU speed seems to have little to do with interrupt
latency now that we have fast CPUs. The limiting action
is the memory speed (front-side bus). You can seldom
count on having your ISR code inside the cache, so it
needs to be fetched. It also takes more cache-flushes
to switch from user-mode to a kernel stack, set up
new segments, etc. That's the reason why you must
MEASURE the latency if it is important. Guessing that
an interrupt occurred when a timer went to zero, then
measuring the residual in that same ISR will give you
the wrong answers, altough in this case, it's probably
close.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
