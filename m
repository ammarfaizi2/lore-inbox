Return-Path: <linux-kernel-owner+willy=40w.ods.org-S271151AbUJVAc0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271151AbUJVAc0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Oct 2004 20:32:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271150AbUJVAYD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Oct 2004 20:24:03 -0400
Received: from gw02.applegatebroadband.net ([207.55.227.2]:11509 "EHLO
	data.mvista.com") by vger.kernel.org with ESMTP id S271136AbUJVAVt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Oct 2004 20:21:49 -0400
Message-ID: <41785287.7080503@mvista.com>
Date: Thu, 21 Oct 2004 17:21:27 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
CC: root@chaos.analogic.com, "Brown, Len" <len.brown@intel.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>
Subject: Re: gradual timeofday overhaul
References: <F989B1573A3A644BAB3920FBECA4D25A011F96DC@orsmsx407>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A011F96DC@orsmsx407>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Perez-Gonzalez, Inaky wrote:
>>From: George Anzinger [mailto:george@mvista.com]
>>
>>Perez-Gonzalez, Inaky wrote:
>>
>>
>>>But you can also schedule, before switching to the new task,
>>>a local interrupt on the running processor to mark the end
>>>of the timeslice. When you enter the scheduler, you just need
>>>to remove that; devil is in the details, but it should be possible
>>>to do in a way that doesn't take too much overhead.
>>
>>Well, that is part of the accounting overhead the increases with context switch
>>rate.  You also need to include the time it takes to figure out which of the
>>time limits is closes (run time limit, profile time, slice time, etc).  Then,
> 
> 
> I know these are specific examples, but:
> 
> - profile time is a periodic thingie, so if you have it, forget about
>   having a tickless system. Periodic interrupt for this guy, get it 
>   out of the equation.

Not really.  It is only active if the task is running.  At the very least the 
scheduler needs to check to see if it is on and, if so, set up a timer for it.
> 
> - slice time vs runtime limit. I don't remember what is the granularity of
>   the runtime limit, but it could be expressed in slice terms. If not,
>   we are talking (along with any other times) of min() operations, which
>   are just a few cycles each [granted, they add up].

The main issue here is accumulating the run time which is accounting work that 
needs to happen on context switch (out in this case).
> 
> 
>>you also need to remove the timer when switching away.  No, it is not a lot, but
>>it is way more than the nothing we do when we can turn it all over to the
>>periodic tick.  The choice is load sensitive overhead vs flat overhead.
> 
> 
> This is just talking out of my ass, but I guess that for each invocation
> they will have more or less the same overhead in execution time, let's
> say T. For the periodic tick, the total overhead (in a second) is T*HZ;
> with tickless, it'd be T*number_of_context_switches_per_second, right?
> 
> Now, the ugly case would be if number_of_context_swiches_per_second > HZ.
> In HZ = 100, this could be happening, but in HZ=1000, in a single CPU
> ...well, that would be TOO weird [of course, a real-time app with a 
> 1ms period would do that, but it'd require at least an HZ of 10000 to
> work more or less ok and we'd be below the watermark].

???  Better look again.  Context switches can and do happen as often as 10 or so 
micro seconds (depends a lot on the cpu speed).  I admit this is with code that 
is just trying to measure the context switch time, but, often the system will 
change it mind just that fast.
> 
> So in most cases, and given the assumptions, we'd end up winning,
> beause number_of_context..., even if variable, is going to be bound
> on the upper side by HZ.
> 
> Well, you know way more than I do about this, so here is the question:
> what is the error in that line of reasoning? 

The expected number of context switches.  In some real world apps it gets rather 
high.  The cross over of your two curves _might_ be of interest to some (it is 
rather low by my measurements, done with the tickless patch that is still on 
sourceforge).  On the other hand, where I come from, a system which has 
increasing overhead with load is one that is going to overload.  We are always 
better off if we can figure a way to have fixed overhead.

As for the idle system ticks, I think the VST stuff we are working on is the 
right answer.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

