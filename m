Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264886AbUFMBPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264886AbUFMBPm (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Jun 2004 21:15:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264965AbUFMBPm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Jun 2004 21:15:42 -0400
Received: from gizmo05ps.bigpond.com ([144.140.71.40]:36562 "HELO
	gizmo05ps.bigpond.com") by vger.kernel.org with SMTP
	id S264886AbUFMBPi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Jun 2004 21:15:38 -0400
Message-ID: <40CBAAB6.5050007@bigpond.net.au>
Date: Sun, 13 Jun 2004 11:15:34 +1000
From: Peter Williams <pwil3058@bigpond.net.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624 Netscape/7.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Shane Shrybman <shrybman@aei.ca>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][2.6.7-rc3] Single Priority Array CPU Scheduler
References: <1086961198.2787.19.camel@mars> <40CA49DD.5040500@bigpond.net.au> <1087051846.2444.4.camel@mars>
In-Reply-To: <1087051846.2444.4.camel@mars>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Shane Shrybman wrote:
> On Fri, 2004-06-11 at 20:10, Peter Williams wrote:
> 
>>Shane Shrybman wrote:
>>
>>>Hi Peter,
>>>
>>>I just started to try out your SPA scheduler patch and found that it is
>>>noticeably sluggish when resizing a mozilla window on the desktop. I
>>>have a profile of 2.6.7-rc3-spa and 2.6.7-rc2-mm2 and put them up at:
>>>http://zeke.yi.org/linux/spa/ . There is also vmstat output there but it
>>>doesn't look too helpful to me.
>>>
> 
> [..snip..]
> 
>>Thanks for the feedback, I'll add your test to those I perform myself.
>>
> 
> 
> Sure, no problem. Hope it helps.
> 
> 
>>Some of the control variables for this scheduler have rather arbitrary 
>>values at the moment and are likely to be non optimal.  I'm in the 
>>process of making some of these variables modifiable at run time via 
>>/proc/sys to enable experimentation with different settings.  Hopefully, 
>>this will enable settings that improve interactive performance to be 
>>established.

A patch which adds control of the SPA scheduler via /proc/sys/kernel is 
available at:

<http://users.bigpond.net.au/Peter-Williams/patch-2_6_7_rc3-SPA_CNTL-v0.1>

This adds the directory /proc/sys/kernel/cpusched to the /proc directory 
if SYSCTL is configured into the kernel.  This directory contains 6 
files that allow read/write (root only for write) to 6 unsigned integer 
parameters that control the scheduler as follows:

time_slice -- (in msecs) controls the amount of CPU time that CPU bound 
tasks get before they are booted off the CPU, have their bonuses 
reassessed, are put back on the run queue and rescheduled.  This has a 
default value of 100 (which is the average time slice dealt out by the 
original O(1) scheduler) and a maximum allowable value of 1000 (i.e. 1 
second) and a minimum of 1.  Making this smaller MAY help interactive 
response but COULD increase the context switching rate.  Making this 
larger MAY improve overall system throughput and reduce context 
switching rate but MAY make interactive responsiveness worse.

base_promotion_interval -- (in msecs) controls the rate at which the 
promotion mechanism promotes runnable tasks.  This has a default value 
of 55 and a maximum of UINT_MAX and a minimum of 1.  The primary effect 
of changing this parameter is to alter the "severity" (i.e. how much 
more CPU access a lower "nice" will give a task) of "nice" values.  The 
default value is such that if there are two CPU bound tasks (hard 
spinners) running (and time_slice has its default value of 100) and one 
of them has a "nice" value one less than the other then that task will 
get one and a half times as much CPU access as the other.

max_ai_bonus  -- determines the maximum interactive bonus that a task 
can receive.  This has a default value of 10 and a maximum value of 10. 
  Setting this value to zero effectively turns off the interactive bonus.

max_tpt_bonus  -- determines the maximum throughput bonus that a task 
can receive.  This has a default value of 5 and a maximum value of 9 (to 
keep the maximum number of priority slots <= 160 (or 5 * 32)). Setting 
this value to zero effectively turns off the interactive bonus.

ia_threshold  -- is the sleepiness (i.e. A_s / (A_s + A_c) where A_s is 
the average sleep duration per scheduling cycle and A_c is the average 
CPU consumption per scheduling cycle) threshold (in thousandths) above 
which the task will be considered interactive and have its interactive 
bonus increased asymptotically towards the maximum.  This is assessed at 
the end of each scheduling cycle and is only used to determine whether 
an increase in the bonus is warranted.  This has a default value of 900 
and a minimum and maximum of 0 and 1000 respectively.

cpu_hog_threshold  -- is the idleness (i.e.. (A_s + A_d) / (A_s + A_d + 
A_c) where A_c and A_s are as before and A_d is average time spent on 
the run queue per cycle waiting for CPU access) threshold (in 
thousandths) below which a task will be considered a CPU hog and start 
to lose interactive bonus points (if it has any).  This is assessed at 
the end of each scheduling cycle and at the end of each time slice (if 
the task uses an entire slice) and is only used to decrease the task's 
interactive bonus.  This has a default value of 500 and a minimum and 
maximum of 0 and 1000 respectively.

I suspect that it is this last parameter that is the cause of the 
phenomena that you reported as the activity you described probably 
caused the X servers idleness to become smaller than 500 causing it to 
lose some of its interactive bonus.  Could you apply this patch and try 
decreasing the value of this parameter to see if your problem goes away? 
  A clue as to how small to make it can be obtained by observing the CPU 
usage rate reported by top for the X server when you are stirring it up. 
  If the reported usage is y% then a threshold of slightly smaller than 
(1000 - y * 10) should work.

Thanks
Peter
PS I will probably change the semantics of cpu_hog_threshold in the next 
version to use CPU usage rate (the opposite of idleness) as the measure 
and reverse the test (i.e. if usage rate is greater than the threshold 
the task loses some of its interactive bonus). Its value (A_c / (A_c + 
A_s + A_d) NB this is different to the complement of sleepiness) is 
slightly cheaper to calculate and I also think it's a more natural way 
of thinking about the issue.
-- 
Peter Williams                                   pwil3058@bigpond.net.au

"Learning, n. The kind of ignorance distinguishing the studious."
  -- Ambrose Bierce

