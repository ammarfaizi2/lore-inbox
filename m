Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264696AbUDWDc1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264696AbUDWDc1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Apr 2004 23:32:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264711AbUDWDc1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Apr 2004 23:32:27 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:23545 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S264696AbUDWDcZ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Apr 2004 23:32:25 -0400
Message-ID: <40888E43.9080106@mvista.com>
Date: Thu, 22 Apr 2004 20:32:19 -0700
From: George Anzinger <george@mvista.com>
Reply-To: ganzinger@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
CC: Arjan van de Ven <arjanv@redhat.com>, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
References: <OF8486E763.A98E66AA-ONC1256E7E.00452A1A-C1256E7E.0045F93D@de.ibm.com>
In-Reply-To: <OF8486E763.A98E66AA-ONC1256E7E.00452A1A-C1256E7E.0045F93D@de.ibm.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Martin Schwidefsky wrote:
> 
> 
> 
>>xtime is easy, that's interpolated anyway afaics. Jiffies would either
> 
> just
> 
>>jump some, which code needs to deal with anyway given that preempt can do
>>the same, or would become an approximated thing as well based on the
> 
> other
> 
>>time keeping sources in the system.
> 
> 
> Unluckily no. xtime is not easy because the network stack uses this for
> time stamps at several locations. Living in the past and time stamps for
> network packets don't go together, do they?
> 
> 
>>calculating the load can be a real timer for sure (which would cause an irq
>>at that time), cpu limits we can do at the end of timeslice (and set the
>>timeslice such that the limits won't be exceeded).

Here is where this thing falls down.  Some time ago I put together a tick less 
system (which is what this amounts to).  The patch is still on sourceforge (see 
the HRT URL in my signature).  The problem is this:

On context switch the scheduler needs to figure the minimum time to the next 
event for the new task.  This would be the minimum of the remaining slice, 
profile timer, virtual time, and the cpu limit timer (at least).  It would then 
do an add_timer for this time.  On the next context switch it would, most 
likely, cancel the timer (most code does not run to the end of its slice which 
is the most likely limit).  The computation to find the minimum time, with a bit 
of hand waving, could be shortened to eliminate a few of the timers. On switch 
out, all the tasks timers would need to be updated with the actual time the task 
used.  The problem is that all this work is in the VERY lean and mean context 
switch path.  In my tests a context switching could easily occur often enough 
that the savings from not doing the tick interrupts was over whelmed by the 
added context switch over head with a medium cpu load.  And it is down hill from 
here.  I.e. the tick less system incurres accounting overhead in  direct 
proportion to the number of context switches, while the ticking system has a 
fixed accounting overhead.  AND the cross over point (where the tick less system 
overhead is more that the ticked system overhead) occurs with a medium load.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

