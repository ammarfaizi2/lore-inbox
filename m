Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964920AbVJDTP0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964920AbVJDTP0 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 Oct 2005 15:15:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964935AbVJDTP0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 Oct 2005 15:15:26 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:3573 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S964920AbVJDTPY
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 Oct 2005 15:15:24 -0400
Message-ID: <4342D490.5020409@mvista.com>
Date: Tue, 04 Oct 2005 12:14:24 -0700
From: George Anzinger <george@mvista.com>
Reply-To: george@mvista.com
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050323 Fedora/1.7.6-1.3.2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Rune Torgersen <runet@innovsys.com>
Cc: Paul Mackerras <paulus@samba.org>, Marc <marvin24@gmx.de>,
       linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: clock skew on B/W G3
References: <DCEAAC0833DD314AB0B58112AD99B93B859479@ismail.innsys.innovsys.com>
In-Reply-To: <DCEAAC0833DD314AB0B58112AD99B93B859479@ismail.innsys.innovsys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rune Torgersen wrote:
>  
> 
> 
>>-----Original Message-----
>>From: Paul Mackerras [mailto:paulus@samba.org] 
>>Sent: Tuesday, October 04, 2005 07:49
>>Subject: RE: clock skew on B/W G3
>>
>>I do not believe CLOCK_TICK_RATE affects timekeeping at all on ppc or
>>ppc64 machines, but I could be wrong.  Can you show us where and how
>>CLOCK_TICK_RATE affects things?
> 
> 
> I looked very closely at htis thing earlier this summer because of an
> embedded board that drifted quite severly (15sec a day) with a very
> accureate BITS clock as clock source.
> 
> Here goes:
> In arch/ppc/kernel/time.c
> timer_interrupt() gets called every decrementer timeout (about every
> 1/CONFIG_HZ seconds, accuracy depends on how easily your decrementer
> cliock can be divided by CONFIG_HZ)
> this calls do_timer() to do the timer increment.
> 
> do_timer is in kernel/timer.c and calls update_times().
> update_times() calls update_wall_time() which in turns calls
> update_wall_time_one_tick()
> 
> update_wall_time_one_tick()uses tick_nsec to increment xtime.
> 
> tick_nsec is defined as: (kernel/timer.c:561)
> unsigned long tick_nsec = TICK_NSEC;
> 
> TICK_NSEC is defined as: (include/linux/jiffies.h:64)
> #define TICK_NSEC (SH_DIV (1000000UL * 1000, ACTHZ, 8))
> 
> ACTHZ is defined as: (include/linux/jiffies.h:61)
> #define ACTHZ (SH_DIV (CLOCK_TICK_RATE, LATCH, 8))
> 
> LATCH is defined as: (include/linux/jiffies.h:46)
> #define LATCH  ((CLOCK_TICK_RATE + HZ/2) / HZ)
> 
> which means that tick_nsec depends on CLOCK_TICK_RATE to get its value.
> 
> defined as:
> #define CLOCK_TICK_RATE	1193180 /* Underlying HZ */

But this is defined in include/asm/???.h  so you should be able to set something more to your liking 
(or rather to your archs liking).  It is true that it SHOULD be defined as it is used to define 
TICK_NSEC which is used to define the jiffies<-->timeval/timespec conversions which would be VERY 
slow it it were a variable.

George
-- 

> 
> this clock is completely wrong for most/all ppc. 
> It happens to generate a tick_nsec of 999848 which is close enough to
> 1000000 that most people does not notice.
> (tick_nsec is number of nsec per timer tick)
> 
> When HZ is 250, TICK_NSEC becomes 4000250.
> While this might not completely explain a 20% change in clock sped, it
> it clearly not acurate either.
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
HRT (High-res-timers):  http://sourceforge.net/projects/high-res-timers/
