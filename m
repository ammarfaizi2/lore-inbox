Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261181AbVDDI7g@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261181AbVDDI7g (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 04:59:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261186AbVDDI7g
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 04:59:36 -0400
Received: from gate.corvil.net ([213.94.219.177]:17677 "EHLO corvil.com")
	by vger.kernel.org with ESMTP id S261181AbVDDI7d (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 04:59:33 -0400
Message-ID: <425101EA.7080001@draigBrady.com>
Date: Mon, 04 Apr 2005 09:59:22 +0100
From: P@draigBrady.com
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040124
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jonathan Lundell <linux@lundell-bros.com>
CC: LKML <linux-kernel@vger.kernel.org>
Subject: Re: x86 TSC time warp puzzle
References: <p06230505be73a5c345c7@[10.2.3.6]>
In-Reply-To: <p06230505be73a5c345c7@[10.2.3.6]>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jonathan Lundell wrote:
> Well, not actually a time warp, though it feels like one.
> 
> I'm doing some real-time bit-twiddling in a driver, using the TSC to 
> measure out delays on the order of hundreds of nanoseconds. Because I 
> want an upper limit on the delay, I disable interrupts around it.
> 
> The logic is something like:
> 
>     local_irq_save
>     out(set a bit)
>     t0 = TSC
>     wait while (t = (TSC - t0)) < delay_time
>     out(clear the bit)
>     local_irq_restore
> 
>  From time to time, when I exit the delay, t is *much* bigger than 
> delay_time. If delay_time is, say, 300ns, t is usually no more than 
> 325ns. But every so often, t can be 2000, or 10000, or even much higher.
> 
> The value of t seems to depend on the CPU involved, The worst case is 
> with an Intel 915GV chipset, where t approaches 500 microseconds (!).

Probably not the same thing, but on 2.4 I was noticing
large TSC jumps, the magnitude of which was dependent on CPU speed.
They were always around 1.26ms on my 3.4GHz dual HT xeon system.
That's (2^32)/(3.4*10^9) which suggested it was a 32 bit overflow
somewhere, which pointed me at:
http://lxr.linux.no/source/arch/i386/kernel/time.c?v=2.4.28#L96
This implied the TSCs were drifting relative to each other
(even between logical CPUs on 1 package).
I worked around the problem by setting the IRQ affinity
for my ethernet IRQs (the source of the do_gettimeofday()s)
to a particular logical CPU rather than a physical CPU and also
tied the timer interrupt to CPU0.
I guess I could also maintain a last_tsc_low for each CPU also?

Pádraig.
