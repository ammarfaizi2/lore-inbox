Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261527AbUBYSX6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Feb 2004 13:23:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261520AbUBYSX6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Feb 2004 13:23:58 -0500
Received: from rwcrmhc11.comcast.net ([204.127.198.35]:10912 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S261527AbUBYSVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Feb 2004 13:21:44 -0500
Subject: Re: /proc or ps tools bug?  2.6.3, time is off
From: Albert Cahalan <albert@users.sf.net>
To: George Anzinger <george@mvista.com>
Cc: Albert Cahalan <albert@users.sourceforge.net>,
       David Ford <david+powerix@blue-labs.org>,
       linux-kernel mailing list <linux-kernel@vger.kernel.org>
In-Reply-To: <403CCD3A.7080200@mvista.com>
References: <403C014F.2040504@blue-labs.org>
	 <1077674048.10393.369.camel@cube>  <403C2E56.2060503@blue-labs.org>
	 <1077679677.10393.431.camel@cube>  <403CCD3A.7080200@mvista.com>
Content-Type: text/plain
Organization: 
Message-Id: <1077725042.8084.482.camel@cube>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4 
Date: 25 Feb 2004 11:04:02 -0500
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-02-25 at 11:28, George Anzinger wrote:
> Albert Cahalan wrote:
>> On Wed, 2004-02-25 at 00:10, David Ford wrote:

>> Actually, it seems that there is a -significant- time difference in this 
>>> phantom clock now, I suspended my notebook to bring it home from the 
>>> station, and now this time difference is greater than 9 minutes.  I 
>>> suspect it's roughly 46 seconds plus the amount of time that my notebook 
>>> was suspended.  Yes, I'm running ntpd.
>>>
>>> root     16894  0.0  0.0  1544  484 pts/3    S    Feb24   0:00 grep grep ps
>>> Wed Feb 25 00:09:09 EST 2004
>>
>> OK, this is pointing right at the problem.
>>
>> Linux does not record process start times at all.
>> Instead, it records the number of clock ticks
>> from boot until the process starts.
>>
>> Either the boot time or current time is real.
>> The other may be computed from the uptime, which
>> may be measured in clock ticks.
>
> In 2.6.* boot time is captured at boot.  This is then adjusted when ever the 
> clock is set.  Up time is the difference between the saved boot time and the 
> current wall clock time.
>
>> The clock doesn't tick when your laptop sleeps.
>
> I would guess that the clock adjustment made when the sleep ends is not 
> adjusting the boot time as it should.  That code should set the clock by calling 
> do_settimeofday() which will do the right thing.

I don't think so. The problem might be fixable by advancing
jiffies, crediting the extra ticks to idle time.
Consider the current situation as I know it, in jiffies:

00000 boot
10000 process 42 starts
20000 go to sleep
20000 wake (same jiffies, different time)
30000 process 51 starts
40000 ps examines the state of the system

Process 42 was started 10 seconds after boot. (10000 jiffies)
Process 51 appears to be started 30 seconds after boot. (30000 jiffies + ???) 

Now we want to compute:

1. real-world date and time for process start
2. length of process lifetime (real-world or not?)

What works for process 42 won't work for process 51,
because they are on different sides of a hidden gap.

Another way to fix the problem is to move the boot time.
It's kind of sick, but so are the alternatives.

> As to small drifts of ~170 PPM, they are caused by code (ps I would guess) that 
> assumes that jiffies is exactly 1/HZ whereas it is NOT in the 2.6.* kernel.  The 
> size of the jiffie that the kernel uses is returned by:
>
> struct timespec tv;
> :
> :
> clock_res(CLOCK_REALTIME, &tv);
>
> This will be in nanoseconds (and must be as that is what the wall clock is in).

This is NOT sane. Remeber that procps doesn't get to see HZ.
Only USER_HZ is available, as the AT_CLKTCK ELF note.

I think the way to fix this is to skip or add a tick
every now and then, so that the long-term HZ is exact.

Another way is to simply choose between pure old-style
tick-based timekeeping and pure new-style cycle-based
(TSC or ACPI) timekeeping. Systems with uncooperative
hardware have to use the old-style time keeping. This
should simply the code greatly.



