Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751320AbWINEsX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751320AbWINEsX (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 00:48:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751326AbWINEsX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 00:48:23 -0400
Received: from mta9.srv.hcvlny.cv.net ([167.206.4.204]:58717 "EHLO
	mta9.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id S1751320AbWINEsW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 00:48:22 -0400
Date: Thu, 14 Sep 2006 00:48:20 -0400
From: Nick Orlov <bugfixer@list.ru>
Subject: Re: [PATCH 2.6.18-rc6-mm1 0/2] cpufreq: make it harder for cpu to
 leave "hot" mode
In-reply-to: <20060912032924.GA3677@nickolas.homeunix.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Mail-followup-to: linux-kernel <linux-kernel@vger.kernel.org>,
 Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Message-id: <20060914044820.GA6017@nickolas.homeunix.com>
MIME-version: 1.0
Content-type: text/plain; charset=koi8-r
Content-transfer-encoding: 7BIT
Content-disposition: inline
References: <20060912032924.GA3677@nickolas.homeunix.com>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 12, 2006 at 4:20:57PM EST, Venkatesh Pallipadi wrote:
>
>On Mon, Sep 11, 2006 at 11:29:24PM -0400, Nick Orlov wrote:
>>
>> I was playing with ondemand cpufreq governor (gotta save on
>> electricity
>> bills one day :) ) and I've noticed that gameplay become somewhat
>> sluggish.
>> Especially noticeable in something cpu-power demanding, like quake4.
>> Quick look at stats/trans_table confirmed that CPU goes out of "hot"
>> mode
>> way too often.
>>
>
> ondemand governor adjusts the sampling rate depending on frequency
> transition
> latency of CPU. Say the frequency transition latency for a CPU is 100uS,
> it will sample atmost once every 100mS and by that rule performance
> impact of the transitions alone should not be more than 0.1 %.
>
> There will be performance impact however, if it chooses a lower
> frequency and
> CPU becomes 100% busy immediately after that.

I think I've found the real bug. When we are slowing down after determining
the desired frequency we are asking for the closest supported freq _below_.
(CPUFREQ_RELATION_L vs CPUFREQ_RELATION_H). This is definitely going to
cause freq jump back and forward in some cases (under steady load).

Imagine the following: CPU supports 1.0GHz, 1.8GHz and 2.0GHz (my case).
Let's say load corresponds to 50% when CPU is "hot" (running at 2.0GHz)
Let's say we start at 1.0GHz. Load is 100% so we go to 2.0GHz
immediately.

Now load is 50%, so we are trying to slow-down. Desired freq is ~1.4GHz.
And instead of selecting 1.8 and stay there we select 1.0. Load is 100%
and we are at the stage 1 again...

Am I missing something? Is it a desired behavior?


> That will be a issue with
> any history based speculation. Once can have a workload that will fool
> the
> algorithm to take wrong decision every time.
>
> Having said that, I am curious to see actual numbers that you are seeing
> in
> different cases:
> - The transition latency for frequency switching on your CPU.

How exactly can I check it (I mean I can printk it, but is it exported
somewhere already?)

> - Default ondemand sampling rate on your system.

after rmmod/modprobe cpufreq_ondemand it is 1240000
(I'm assuming it means 1.2 secs, which seems to be unexpectedly long)

> - Different frequencies supported on your system.

1.0, 1.8, 2.0 GHz

> - I guess you have a dual core CPU.

Yep, E6 Amd64x2 3800+ (looks like I am the [un]lucky one who've got the CPU born
to be Toledo and sold as Manchester :) )

>   Whether they are changing frequencies
>   correctly at the same time or changing frequency of one CPU is wrongly
>   affecting the other CPU.

Well, I'm assuming it got things right - cpu1/cpufreq is a symlink to
cpu0/cpufreq ... cpu0/cpufreq/affected_cpus contains "0 1"

>   - trans table for the load with and without mm changes for ondemand.
>
>> To make long story short - reverting -mm changes for
>> cpufreq_ondemand.c
>> helps a _LOT_. I'm not sure if it is something powersave_bias
>> related or
>> (most probably) due to alignment of "next do_dbs_timer() fire time"
>> which
>> could make "collect stats" window too short and introduce
>> significant errors.
>> Have not specifically checked ...
>
> The change in mm should not change anything related to sampling
> interval.

I agree, from looking at the changes - it should not. I just wanted to
eliminate extra variable from the equation (I'm not using powersave_bias,
so it was "bullet-proof" to just revert the changes).

I'm a speculating here of-course. I did not run comprehensive tests and
did not perform complex/long measurements. I just reverted the changes,
recompiled the kernel and played q4 little bit. It definitely _felt_ less
sluggish (which is purely subjective thing, same as "responsiveness").
I took a look at the trans_table and numbers were lower (not by order
of magnitude, but lower). But since each run is unique it is not
something which "proves" things 100%.

> If it is indeed doing something like that, then it will be a bug. Can you
> please
> check sampling_rate (under sys cpufreq/ondemand) with and without mm
> changes.

I do not see how it can be affected by mm changes (I have reverted
cpufreq_ondemand.c changes only), but if you are still interested I will
reboot and check the value.

> That will tell how frequently kernel is checking the stats.
>
>>
>> After thinking about the issue for a while I come up with the
>> following tweaks:
>> First of all I made hysteresis little bit wider (20% instead of 10).
>
> This is a heuristic and this change will make ondemand more
> conservative
> in some cases and ondemand will not be able to reduce frequency and
> hence end up consuming more power.

Totally agree. My objective was to make it to "deliver power" as quickly as
possible and I was ready to accept increased power consumption as long as
in "idle" CPU eventually goes into the most power-saving mode. (Isn't
the primary difference between conservative and ondemand governors btw?
Warm-up quicker, cool-down somewhat slower...)

>
> If this is really needed, then it should be a tunable to ondemand
> rather than a
> new absolute value. As this is only changing the next frequency to be
> one that
> keeps CPU 60% busy than 70% busy, and these two frequencies must be
> close
> to each other anyway, I don't think this can cause performance
> degradation
> due to wrong/low freq.
>
>> Another idea was to increase "sampling period" once cpu is in "hot"
>> mode.
>>
>> Second part also have benefits of reducing the load on already
>> overloaded cpu.
>> Plus it's damn trivial. To simplify further testing I have exposed
>> "sampling_rate_hot" parameter through sysfs. Setting it to
>> sampling_rate * 10
>> works for me very well. Now I do not have to switch governor to
>> "performance"
>> during game sessions.
>>
>
> Again, I dont think frequent checking in ondemand is a bad thing as
> it allows ondemand to be aggressive and save as much power and also
> have quick response time for increased load.

Point was that we are "hot" already. So the only way out is to slow-down.
Which (IMHO) can wait...

> If we really have a issue
> with sampling rate, it is possibly due to wrong transition latency
> advertised by the driver and we are wasting more time doing
> transitions than ondemand thinks it is spending.
>
> If the sampling rate is indeed high for your system/workload, you
> should be
> able to get the same result by just increasing the sampling_rate in
> sysfs cpufreq/ondemand than having a new tunable.

It is not about "transition rate". It is about the fact that we are
leaving "full-speed" mode (which is somewhat unexpected under q4 load).
I was just hoping that by increasing sampling period I'm making "load
measurements" more reliable... On other side I did not want to affect
"warm up" paths. I do want CPU to speed-up as quickly as possible when
needed.

I definitely not an expert in power management and I'm not an experienced
kernel hacker. I'm merely scratching the surface.
A lot of things are still not clear for me.
For example:

1. what are "real-world" latencies for the execution of things scheduled
   through the work-queue? Can these latencies be as high as 1 sec on
   ~1GHz CPU for example? Under load?

   if execution can be delayed that much then the "delay -= jiffies % delay;"
   alignment can potentially make measurement period way too short...

2. What if process which produces most of the load migrates to another
   core in the middle of the sampling period? We will end up with 50%
   load on each core but it does not mean that we can still handle this
   load on the frequency twice as low... I'm pretty sure we can find
   elegant "next best thing" solution. I just have not found feasible
   one yet. Still thinking.

Thank you,
	Nick Orlov.

P.S. Could you please CC me (I'm not subscribed to the list)

--
With best wishes,
        Nick Orlov.
