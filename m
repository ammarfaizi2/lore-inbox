Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261830AbTCZSCF>; Wed, 26 Mar 2003 13:02:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261831AbTCZSCF>; Wed, 26 Mar 2003 13:02:05 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:52217 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261830AbTCZSCC>;
	Wed, 26 Mar 2003 13:02:02 -0500
Message-ID: <3E81ED81.7080905@mvista.com>
Date: Wed, 26 Mar 2003 10:12:17 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: root@chaos.analogic.com
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, Fionn Behrens <fionn@unix-ag.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: System time warping around real time problem - please help
References: <1048609931.1601.49.camel@rtfm>  <Pine.LNX.4.53.0303251152080.29361@chaos> <1048627013.2348.39.camel@rtfm>  <3E80D4CC.4000202@mvista.com>  <1048632934.1355.12.camel@rtfm>  <1048637613.29944.17.camel@irongate.swansea.linux.org.uk>  <3E811055.5040202@mvista.com> <1048689492.31839.13.camel@irongate.swansea.linux.org.uk> <3E81D183.6040708@mvista.com> <Pine.LNX.4.53.0303261136040.1500@chaos>
In-Reply-To: <Pine.LNX.4.53.0303261136040.1500@chaos>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Richard B. Johnson wrote:
> On Wed, 26 Mar 2003, george anzinger wrote:
> 
> 
>>Alan Cox wrote:
>>
>>>On Wed, 2003-03-26 at 02:28, george anzinger wrote:
>>>
>>>
>>>>Stands for Time Stamp Counter.  It is a special cpu register that
>>>>basically counts cpu cycles.  Some times (incorrectly me thinks) it is
>>>>affected by power management code which slows the cpu by changing the
>>>>cpu frequency.
>>>
>>>
>>>Not incorrectly. It counts cpu clocks, its designed for profiling and
>>>the like. There is no guarantee in any Intel MP standard that the clocks
>>>are synched up.
>>
>>
>>I seem to recall a different notion of correctness from Andy Grover...
>>  but memory may deceive :(
>>
>>
>>As for sync, I would think it is a mother board issue.
>>
>>But as you say, Intel should put in a usable counter.  The HPET seems
>>like it has the capabilities, however, I suspect that it is a slow
>>read.  Any idea how many cycles it takes to do a memory mapped I/O access?
>>--
> 
> 
> It depends how the read is made. A direct read of non-cached RAM
> like this:
> 
> 		movl	(MY_IODEV), %eax
> 
> ... takes 4 CPU clocks if the device doesn't insert any wait-states.
> With fast CPUs, such is in possible. You are I/O bound by the front-side
> bus speed. A good guess of the time to read is 4/(bus MHz) because
> there are 4 bus-cycles for a read or write.
> 
> If the 'C' compiler decides to do indexed addressing, where the
> address gets calculated, the read times are greater. For instance,
> 
> 		movl	(%ebx), %eax
> 
> ... takes 8 clocks even ignoring the fact that the virtual address
> needs to be put into register ebx. If the address is on certain
> boundaries (not necessarily the same for different CPUs), the
> reads can be slower.
> 
> Slow reads don't really hurt. 

gettimeofday() is small enough that a couple of extra cycles DOES show 
up.  And, as cpus get faster and faster WRT the front-side bus, this 
can easily be the majority of the time it takes to do gettimeofday().

> In fact, they make sure that subsequent
> reads will always return positive time. It's just a bias in the
> time that affects everybody the same way. What hurts is trying to
> synchronize to some external clock. In my opinion, this is not
> the correct way to get the time. `rdtsc` returns a long long
> in two registers. This should be saved as "reference time"
> every time the system clock is set. Setting the system clock
> means saving (only) the time_t object, in seconds, at the
> time one saves the rdtsc time. This time_t object is never
> changed otherwise. The PIT only generates interrupts. It is
> not used for time. When somebody needs the time, it is calculated
> from the present `rdtsc`, the saved long long value, and the
> time_t time at which that value was saved. This guarantees
> that all time is positive and no CPU cycles are wasted trying
> to read anything.
> 
> The number of CPU cycles per second are calculated once upon
> startup just as they are now. If you shut-down, or slow the
> CPU for power-saving, you just recalculate the CPU cycles
> and reset the time from CMOS. Any time, when the machine is
> in 'slow' mode is still correct.

I did something close to this in the high-res-timers patch.  There are 
several problems WRT TSC:

First, and the reason this thread started, there are SMP boxes with pm 
code that causes the TSC to run at different speeds on the various cpus.

Second, I am lead to believe that there are boxes that adjust the cpu 
speed with out telling software about it.

Third, there are boxes that just don't have TSCs, (yeah, I know they 
are old...).

Because of all of this, I have a configure option to use the ACPI pm 
counter.  The down side of this is a) it is slow (an I/O instruction) 
and b.) the resolution is much less than the TSC.
> 
> time_t  set_time;
> long long cpu_cycles_sec;
> long long rd_tsc_at_set_time;
> 
> To read time:
> 
> current_time = ((rdtsc() - rd_tsc_at_set_time)/ cpu_cycles_sec) +
>                set_time;
> 
> To set time:
> 
> set_time = get_time_from_CMOS();
> rd_tsc_at_set_time = rdtsc();
> 
> ... That's all you need.

In my code, since the time needs to be "fresh" each tick, I keep a 
counter up to date each tick.  This allows me to speed up the code by 
only reading the low half of the TSC, and at the same time, avoid some 
64-bit math.

The other thing this way of doing things needs is code to discipline 
the interrupt source (the PIT in this case) so that the interrupts 
come "reasonably" close to the 1/Hz boundary.  Without this the timers 
have too much jitter.



-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

