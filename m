Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268421AbUJTQPQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268421AbUJTQPQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 12:15:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268667AbUJTQEe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 12:04:34 -0400
Received: from chaos.analogic.com ([204.178.40.224]:15744 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S268421AbUJTQAb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 12:00:31 -0400
Date: Wed, 20 Oct 2004 11:59:09 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: George Anzinger <george@mvista.com>
cc: Len Brown <len.brown@intel.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gradual timeofday overhaul
In-Reply-To: <41767FA8.9090104@mvista.com>
Message-ID: <Pine.LNX.4.61.0410201134330.13384@chaos.analogic.com>
References: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de>
 <1098258460.26595.4320.camel@d845pe> <41767FA8.9090104@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 Oct 2004, George Anzinger wrote:

> Len Brown wrote:
>> On Tue, 2004-10-19 at 23:05, Tim Schmielau wrote:
>> 
>>> I think we could do it in the following steps:
>>> 
>>>  1. Sync up jiffies with the monotonic clock,...
>>>  2. Decouple jiffies from the actual interrupt counter...
>>>  3. Increase HZ all the way up to 1e9....
>
> Before we do any of the above, I think we need to stop and ponder just what a 
> "jiffie" is.  Currently it is, by default (or historically) the "basic tick" 
> of the system clock.  On top of this a lot of interpolation code has been 
> "grafted" to allow the system to resolve time to finer levels, i.e. to the 
> nanosecond. But none of this interpolation code actually changes the tick, 
> i.e. the interrupt still happens at the same periodic rate.
>
> As the "basic tick", it is used to do a lot of accounting and scheduling 
> house keeping AND as a driver of the system timers.
>
> So, by this definition, it REQUIRES a system interrupt.
>
> I have built a "tick less" system and have evidence from that that such 
> systems are over load prone.  The faster the context switch rate, the more 
> accounting needs to be done.  On the otherhand, the ticked system has flat 
> accounting overhead WRT load.
>
> Regardless of what definitions we settle on, the system needs an interrupt 
> source to drive the system timers, and, as I indicate above, the accounting 
> and scheduling stuff.  It is a MUST that these interrupts occure at the 
> required times or the system timers will be off.  This is why we have a 
> jiffies value that is "rather odd" in the x86 today.
>
> George
>
>

You need that hardware interrupt for more than time-keeping.
Without a hardware-interrupt, to force a new time-slice,

 	for(;;)
            ;

... would allow a user to grab the CPU forever ...

So, getting rid of the hardware interrupt can't be done.
Also, much effort has gone into obtaining high resolution
timing without any high resolution hardware to back it
up. This means that user's can get numbers like 987,654
microseconds and the last 654 are as valuable as teats
on a bull. With a HZ timer tick, you get 1/HZ resolution
pure and simple. The rest of the "interpolation" is just
guess-work which leads to lots of problems, especially
when one attempts to read a spinning down-count value
from a hardware device accessed off some ports!

If the ix86 CMOS timer was used you could get better
accuracy than present, but accuracy is something one
can accommodate with automatic adjustment of time,
tracable to some appropriate standard.

The top-level schedule-code could contain some flag that
says; "are we in a power-down mode". If so, it could
execute minimal in-cache code, i.e. :

 		for(;;)
                 {
                    hlt();	// Sleep until next tick
 		   if(mode != power_down)
                        schedule();

                 }

The timer-tick ISR or any other ISR wakes us up from halt.
This keeps the system sleeping, not wasting power grabbing
code/data from RAM and grunching some numbers that are
not going to be used.


>> 
>> 
>>> Thoughts?
>> 
>> 
>> Yes, for long periods of idle, I'd like to see the periodic clock tick
>> disabled entirely.  Clock ticks causes the hardware to exit power-saving
>> idle states.
>> 
>> The current design with HZ=1000 gives us 1ms = 1000usec between clock
>> ticks.  But some platforms take nearly that long just to enter/exit low
>> power states; which means that on Linux the hardware pays a long idle
>> state exit latency (performance hit) but gets little or no power savings
>> from the time it resides in that idle state.
>> 
>> thanks,
>> -Len
>> 
>> 
>
> -- 
> George Anzinger   george@mvista.com
> High-res-timers:  http://sourceforge.net/projects/high-res-timers/
>
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

Cheers,
Dick Johnson
Penguin : Linux version 2.6.9 on an i686 machine (5537.79 GrumpyMips).
                  98.36% of all statistics are fiction.
