Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312891AbSDGBQa>; Sat, 6 Apr 2002 20:16:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312894AbSDGBQ3>; Sat, 6 Apr 2002 20:16:29 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:32268 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id <S312891AbSDGBQ2>;
	Sat, 6 Apr 2002 20:16:28 -0500
Message-ID: <3CAF9DCB.8C86443@zip.com.au>
Date: Sat, 06 Apr 2002 17:15:55 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre5 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Paul Davis <pbd@Op.Net>
CC: linux-kernel@vger.kernel.org
Subject: Re: delayed interrupt processing caused by cswitching/pipe_writes?
In-Reply-To: <200204061954.g36Jsoe11292@op.net>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Davis wrote:
> 

Hi, Paul.

> ...
> But now that JACK splits the
> handling across two threads in different processes, the thing that
> kills us is not the context switch times, not the delay caused by
> cache and/or TLB invalidation, or any of that stuff. instead, its that
> we start delaying the execution of the audio interface interrupt
> handler to the point where our assumptions about handling every
> interrupt on time fall apart.

Conceivably, something somewhere is forgetting to reenable interrupts,
and we're just not noticing because the scheduler and/or return
from syscall just turns them on unconditionally.

There are a couple of things you can try.

First is to just use the kernel profiler.  Do it on uniprocessor
to make life simpler.   If you see a particular function
is showing up prominently then perhaps that's the place
where interrupts are getting turned back on, and that may
point us at the source of the problem.

Note that you'll probably get better retults with a higher
profiling frequency - build the UP kernel with local APIC
support and use `readprofile -M10' to profile at 1000 Hz.

The other approach would be to apply

http://www.zip.com.au/~akpm/linux/timepeg-2.4.19-pre6-1.patch.gz

and enable "Timepeg instrumentation" and "Interrupt latency
instrumentation" in the Kernel Hacking menu.

Compile up http://www.zip.com.au/~akpm/linux/tpt.tar.gz
and run

	sudo ./tpt -s | sort -nr +5 | head -20

then run your workload, then run the above command a second time.
I get:

        slab.c:1323 -> slab.c:1347  572      .66  55.91     5.90   3375.52
       do_IRQ.in:0 -> softirq.c:84  1628   10.72  22.18    11.22  18270.64
          exit.c:396 -> exit.c:430  3       5.50  10.66     7.66     22.98
ll_rw_blk.c:886 -> ll_rw_blk.c:996  54      1.25   8.72     2.15    116.28

which shows that the worst-case interrupt-off times
were between lines 1347 and 1323 of slab.c.

Beware that the timepeg patch increases your kernel
size tremendously - it's probably OK with a uniprocessor
build, but even though I've dropped NR_CPUS to 2, a
large SMP kernel build can simply fail to load.

-
