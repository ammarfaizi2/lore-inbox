Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262316AbVAUIjJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262316AbVAUIjJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 03:39:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262318AbVAUIjJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 03:39:09 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:41967 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S262316AbVAUIjD
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 03:39:03 -0500
Message-ID: <41F0BFA4.5030107@mvista.com>
Date: Fri, 21 Jan 2005 00:39:00 -0800
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.2) Gecko/20040308
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ingo Molnar <mingo@elte.hu>
CC: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       john stultz <johnstul@us.ibm.com>
Subject: Re: [PATCH] to fix xtime lock for in the RT kernel patch
References: <41F04573.7070508@mvista.com> <20050121063519.GA19954@elte.hu> <41F0BA56.9000605@mvista.com> <20050121082125.GA28267@elte.hu>
In-Reply-To: <20050121082125.GA28267@elte.hu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote:
> * George Anzinger <george@mvista.com> wrote:
> 
> 
>>>how about the patch below? One of the important benefits of the 
>>>threaded timer IRQ is the ability to make xtime_lock a mutex.
>>
>>The problem is that that removes the
>>	cur_timer->mark_offset();
>>	do_timer(regs);
>>in time. [...]
> 
> 
> i'm not sure i understand what you mean. My change does:
> 
> | @@ -294,6 +313,7 @@ irqreturn_t timer_interrupt(int irq, voi
> |         write_seqlock(&xtime_lock);
> |
> |         cur_timer->mark_offset();
> | +       do_timer(regs);
> |
> |         do_timer_interrupt(irq, NULL, regs);
> 
> so ->mark_offset and do_timer() go together, and happen under
> xtime_lock. What problem is there if we do this?

We are trying to get an accurate picture of when, exactly in time, jiffies 
changes.  We then want to have that marked (mark_offset) with a TCS (or other 
clock) so we can tell how many nanoseconds past that time any given point of 
time is.  This is used by gettimeofday.  So if we wait till the thread gets 
control, we have a lot of variability in when, exactly, the event took place. 
We already have interrupt latency in the mix, but, by moving it to a thread, we 
also add scheduling delays due to other RT threads (the actual intent of making 
it a thread, right).

We can handle (do today) some variability in this area, but, at least for RT 
systems, we would like to get this down to a small a window as possible.  The 
changes I am suggesting are aimed at getting a good a handle on the current time 
as possible.  They say nothing about how accurate we are in expiring a timer, 
for example.
> 
> 	Ingo
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/

