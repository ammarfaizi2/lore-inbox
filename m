Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267561AbUJTPSg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267561AbUJTPSg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Oct 2004 11:18:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266663AbUJTPO0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Oct 2004 11:14:26 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:28138 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S268279AbUJTPJk
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Oct 2004 11:09:40 -0400
Message-ID: <41767FA8.9090104@mvista.com>
Date: Wed, 20 Oct 2004 08:09:28 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Len Brown <len.brown@intel.com>
CC: Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gradual timeofday overhaul
References: <Pine.LNX.4.53.0410200441210.11067@gockel.physik3.uni-rostock.de> <1098258460.26595.4320.camel@d845pe>
In-Reply-To: <1098258460.26595.4320.camel@d845pe>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Len Brown wrote:
> On Tue, 2004-10-19 at 23:05, Tim Schmielau wrote:
> 
>>I think we could do it in the following steps:
>>
>>  1. Sync up jiffies with the monotonic clock,...
>>  2. Decouple jiffies from the actual interrupt counter...
>>  3. Increase HZ all the way up to 1e9....

Before we do any of the above, I think we need to stop and ponder just what a 
"jiffie" is.  Currently it is, by default (or historically) the "basic tick" of 
the system clock.  On top of this a lot of interpolation code has been "grafted" 
to allow the system to resolve time to finer levels, i.e. to the nanosecond. 
But none of this interpolation code actually changes the tick, i.e. the 
interrupt still happens at the same periodic rate.

As the "basic tick", it is used to do a lot of accounting and scheduling house 
keeping AND as a driver of the system timers.

So, by this definition, it REQUIRES a system interrupt.

I have built a "tick less" system and have evidence from that that such systems 
are over load prone.  The faster the context switch rate, the more accounting 
needs to be done.  On the otherhand, the ticked system has flat accounting 
overhead WRT load.

Regardless of what definitions we settle on, the system needs an interrupt 
source to drive the system timers, and, as I indicate above, the accounting and 
scheduling stuff.  It is a MUST that these interrupts occure at the required 
times or the system timers will be off.  This is why we have a jiffies value 
that is "rather odd" in the x86 today.

George


> 
> 
>>Thoughts?
> 
> 
> Yes, for long periods of idle, I'd like to see the periodic clock tick
> disabled entirely.  Clock ticks causes the hardware to exit power-saving
> idle states.
> 
> The current design with HZ=1000 gives us 1ms = 1000usec between clock
> ticks.  But some platforms take nearly that long just to enter/exit low
> power states; which means that on Linux the hardware pays a long idle
> state exit latency (performance hit) but gets little or no power savings
> from the time it resides in that idle state.
> 
> thanks,
> -Len
> 
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

