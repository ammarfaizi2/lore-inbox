Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261428AbUBYQcE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 11:32:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261387AbUBYQar
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 11:30:47 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:20470 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S261428AbUBYQ2s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 11:28:48 -0500
Message-ID: <403CCD3A.7080200@mvista.com>
Date: Wed, 25 Feb 2004 08:28:42 -0800
From: George Anzinger <george@mvista.com>
Organization: MontaVista Software
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20030225
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sourceforge.net>
CC: David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
References: <403C014F.2040504@blue-labs.org>	 <1077674048.10393.369.camel@cube>  <403C2E56.2060503@blue-labs.org> <1077679677.10393.431.camel@cube>
In-Reply-To: <1077679677.10393.431.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> On Wed, 2004-02-25 at 00:10, David Ford wrote:
> 
> 
>>I can see if a process long in the past would have a different time set 
>>on it, but shouldn't the entry in /proc coincide with the system clock 
>>that date is accessing?  Or how many different "clocks" does the kernel 
>>have going?
> 
> 
> There are way too many clocks, none of which are good.
> 
> 
>>Actually, it seems that there is a -significant- time difference in this 
>>phantom clock now, I suspended my notebook to bring it home from the 
>>station, and now this time difference is greater than 9 minutes.  I 
>>suspect it's roughly 46 seconds plus the amount of time that my notebook 
>>was suspended.  Yes, I'm running ntpd.
>>
>>root     16894  0.0  0.0  1544  484 pts/3    S    Feb24   0:00 grep grep ps
>>Wed Feb 25 00:09:09 EST 2004
> 
> 
> OK, this is pointing right at the problem.
> 
> Linux does not record process start times at all.
> Instead, it records the number of clock ticks
> from boot until the process starts.
> 
> Either the boot time or current time is real.
> The other may be computed from the uptime, which
> may be measured in clock ticks.

In 2.6.* boot time is captured at boot.  This is then adjusted when ever the 
clock is set.  Up time is the difference between the saved boot time and the 
current wall clock time.
> 
> The clock doesn't tick when your laptop sleeps.

I would guess that the clock adjustment made when the sleep ends is not 
adjusting the boot time as it should.  That code should set the clock by calling 
do_settimeofday() which will do the right thing.

As to small drifts of ~170 PPM, they are caused by code (ps I would guess) that 
assumes that jiffies is exactly 1/HZ whereas it is NOT in the 2.6.* kernel.  The 
size of the jiffie that the kernel uses is returned by:

struct timespec tv;
:
:
clock_res(CLOCK_REALTIME, &tv);

This will be in nanoseconds (and must be as that is what the wall clock is in).
George

> I seem to recall recent changes to the way the
> boot time in /proc/stat gets reported. In any
> case, a sleeping laptop suggests some interesting
> questions about process run times.

> 
> Here's another one to make you scream: Linux does
> not supply real %CPU data.
> 
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

