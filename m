Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261690AbTCGSG0>; Fri, 7 Mar 2003 13:06:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261691AbTCGSG0>; Fri, 7 Mar 2003 13:06:26 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:11762 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id <S261690AbTCGSGX>;
	Fri, 7 Mar 2003 13:06:23 -0500
Message-ID: <3E68E1EB.6030304@mvista.com>
Date: Fri, 07 Mar 2003 10:16:11 -0800
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Eric Piel <Eric.Piel@Bull.Net>
CC: davidm@hpl.hp.com, linux-kernel@vger.kernel.org, jim.houston@ccur.com
Subject: Re: POSIX timer syscalls
References: <200303062306.h26N6hrd008442@napali.hpl.hp.com>	<3E67DF8E.9080005@mvista.com>	<15975.62823.5398.712934@napali.hpl.hp.com>	<3E67F844.2090902@mvista.com> <15975.63734.837748.29150@napali.hpl.hp.com> <3E68573A.4020206@mvista.com> <3E688D29.F2E48939@Bull.Net>
In-Reply-To: <3E688D29.F2E48939@Bull.Net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric Piel wrote:
> george anzinger wrote:
> 
>>By the way, I am seeing some reports from the clock_nanosleep test
>>about sleeping too long or too short.  The too long appears to be just
>>not being able to preempt what ever else is running.  The too short
>>(on the x86) is, I believe, due to the fact that more that 1/HZ is
>>clocked on the wall clock each jiffie.
>>
>>Try this:
>>
>>time sleep 60
>>
>>On the x86 it reports less than 60, NOT good.
>>
> 
> I've run the test programs and they pass everything well (with my
> patchs) excepted the nanosleeps which seems to be finished a bit too
> early. My system test is a 2.5.64 patched on a 4xItaniumII.
> 
> My main question is to know if it's a problem even if the difference
> between the wakeup time and the requested time is smaller than the
> resolution of the clock, 976562ns ? I mean, at the resolution of the
> clock we could consider we woke up right at the good time, couldn't we?
> 
> In addition time sleep 60 always gave me time over 1 minute, I guess
> it's a good point. 

This test is rather crude because any latencies in the exec and wait 
calls are also included in the "time".  Larger sleep times cause the 
impact of these latencies to be less important.

The problem is caused by the update wall clock routine adding less 
than 1/HZ for each jiffie.  In the x86 case this was done to more 
closely follow the actual time that the PIT gives with the count that 
results from 1/HZ.  IMHO, the result is NOT standard conforming and 
another way of doing things should be found.  What actually results 
here is that CLOCK_MONOTONIC and CLOCK_REALTIME do not pass time at 
the same rate.

The clock update value is computed by TICK_NSEC() located in 
include/linux/timex.h and gives other than 1/HZ based on the LATCH and 
  CLOCK_TICK_RATE not yielding an exact integer value.

All this said, I don't have a good solution.  The best thing would be 
if we could actually generate the 1/HZ tick with 1 to 2 ppm accuracy. 
  If this is not possible, short of going to a new way of time keeping 
(which is what the high-res-timers do) I don't see a solution.  By 
"good" I mean one that keeps CLOCK_MONOTONIC and CLOCK_REALTIME in 
lock step (excepting clock setting which only CLOCK_REALTIME does). 
Note that I am NOT excepting NTP adjustments.  In other words, a good 
solution would keep CLOCK_MONOTONIC as the standard clock and just 
have a offset to get to CLOCK_REALTIME.  This offset is what clock 
setting would change.

This would, I am afraid, also introduce another problem, i.e. that the 
run_timer_list() must occur very shortly after jiffies is advanced. 
This requires the generation of tick interrupts to by synced to the 
clock.  What I am saying is that it is not enough to calculate jiffies 
in a way that takes care of a higher resolution (i.e. a sub_jiffie 
part) but one must also conspire to make the run_timer_list() occur 
when the sub_jiffie is "small".
> 
> Here is a part of the log of 'do_test':
> 
> Testing behavor with clock seting...
> Retarding the clock
> Clock did not seem to move
>  was:           1046969027s 703359000ns
>  requested:     1046969023s 703359000ns
>  now:           1046969022s 467072000ns
>  diff is -1.236286998sec
> Cool clock_nanosleeptest.c,379:clock_nanosleep(clock, TIMER_ABSTIME,
> &ts, NULL)

This is BAD!  The code only retards the clock by 1 sec so it appears 
that nothing happened here.  Oh, I know, it is saying that clock_set 
failed.  You must run as root to make this work.  Otherwise, well I 
don't know what could be happening.
> 
> Testing signal behavor...
> handler1 entered: signal 31
> expected clock_nanosleeptest.c,227:clock_nanosleep(clock, 0, &ts, &rs):
> Interrupted system call
> Time remaining is 0s 989257306ns
> clock_nanosleeptest.c,245:slept too short!
>  requested:     275s 207032000ns
>  now:           275s 207030632ns
>  diff is -0.000001368sec

This is likely caused by what I discussed above.
> 
> Testing undelivered signal behavor...
> Cool clock_nanosleeptest.c,267:clock_nanosleep(clock, 0, &ts, &rs)
> clock_nanosleeptest.c,283:slept too short!
>  requested:     275s 223633000ns
>  now:           275s 223632698ns
>  diff is -0.000000302sec
> 
> 
>  --Eric
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

