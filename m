Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262724AbVA1SjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262724AbVA1SjE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jan 2005 13:39:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262108AbVA1SgD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jan 2005 13:36:03 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:39415 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262701AbVA1Sea
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jan 2005 13:34:30 -0500
Message-ID: <41FA85A7.4000805@mvista.com>
Date: Fri, 28 Jan 2005 10:34:15 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: Thomas Gleixner <tglx@linutronix.de>, LKML <linux-kernel@vger.kernel.org>,
       Doug Niehaus <niehaus@ittc.ku.edu>,
       Benedikt Spranger <bene@linutronix.de>
Subject: Re: High resolution timers and BH processing on -RT
References: <1106871192.21196.152.camel@tglx.tec.linutronix.de> <20050128044301.GD29751@elte.hu> <1106900411.21196.181.camel@tglx.tec.linutronix.de> <20050128082439.GA3984@elte.hu> <1106901013.21196.194.camel@tglx.tec.linutronix.de> <20050128084725.GB5004@elte.hu>
In-Reply-To: <20050128084725.GB5004@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * Thomas Gleixner <tglx@linutronix.de> wrote:
> 
> 
>>>or is it that we have a 'group' of normal timers expiring, which, if
>>>they happen to occur _just_ prior a HRT event will generate a larger
>>>delay?
>>
>>Yep. The timers expire at random times. So it's likely to have short
>>sequences of timer interrupts going off. This needs reprogramming of
>>the PIT and processing of the expired timers.

If you can use a machine that has a local apic we can leave the PIT out of it. 
Really this is MUCH preferred.  If your box has a LAPIC, make sure it is not 
disabled by your config setup.

Leaving the PIT out of it, the structure is that HRT timers are put in the 
normal timer list and, when they expire, are moved to a HRT list which only 
contains timers that will expire prior to the next jiffie.  This list is managed 
by interrupt, ideally from the LAPIC, or the PIT is need be.  Aside from the PIT 
reprograming (once per HRT timer plus once to get back to the 1/HZ period), 
there can be delays in getting the timer out of the normal timer list.  The main 
thing here is that the list MUST be processed as close to the jiffie edge as 
possible as any timers due shortly after the jiffie edge will be shadowed by 
this regardless of the HRT interrupt.  Of course, it an expired timer is 
presented to the HRT code by the normal timer expire code, it is expired 
immeadiatly.

A quick comment here on the current RT code.  It looks to me like there is a 
race in timer delivery.  It looks like the softirq is "raised" by the PIT 
interrupt code and the jiffie is bumped by the timer thread.  If the softirq 
gets to run prior to the PIT interrupt thread we could end up in the run_timer 
list code with a stale jiffie value and do nothing.  This would delay normal 
timers for a jiffie and HRT timers for some time less than a jiffie, depending 
on when they were really due.

I thing we should move the raising of the timer softirq to the PIT interrupt 
thread after we release the xtime_lock.
> 
> 
> i dont really like the static splitup of 'normal' vs. 'HRT' timers -
> there might in fact be separate priority requirements between HRT timers
> too.

Yes, and high priority tasks might want low res timers...
> 
> i think one possible solution would be to introduce some notion of
> 'timer priority', and to expire each timer priority level in a separate
> timer expiry thread. Priority 0 (lowest) would be expired in ksoftirqd,
> and there would be 3 separate threads for say priorities 1-3. Or
> something like this. Potentially exposed to user-space as well, via new
> APIs. Hm?
> 
> To push this even further: in theory timers could inherit the priority
> of the task that starts them, and they would be expired in that priority
> order - but this probably needs a pretty clever (and most likely
> complex) data-structure ...

A long time ago in another land, I did such a system.  The timer priority was 
taken from the calling task.  At that time (and now, till convinced otherwise) I 
thought it a _good thing_ to expire timers in order, regardless of their 
priority, so all timers pending delivery were delivered at the priority of the 
highest priority timer in the "batch".  The basic idea was that the interrupt 
code pulled expired timers from the timer list and pushed them into the pending 
list.  In the process it found the highest priority timer in the list.  The 
timer delivery thread was then run at that priority.  This thread adjusted its 
priority downward as needed, but in all cases the timers were delivered in 
strict time order.

Since then, as now, the timer delivery usually just _notified_ a task of a 
pending signal, the low priority timers did not really hold up things for long. 
  Once the high priority timer was delivered and the thread either finished or 
dropped its priority, the waiting task (having been wakened by the signal 
delivery) could switch in.

The primary thing needed for this is a simple and quick way to switch a tasks 
priority, both from outside and from the task itself.
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

