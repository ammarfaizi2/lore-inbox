Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932259AbWIPAdh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259AbWIPAdh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Sep 2006 20:33:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWIPAdh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Sep 2006 20:33:37 -0400
Received: from mga02.intel.com ([134.134.136.20]:138 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S932259AbWIPAdg convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Sep 2006 20:33:36 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,173,1157353200"; 
   d="scan'208"; a="128040206:sNHT648551239"
X-MimeOLE: Produced By Microsoft Exchange V6.5
Content-class: urn:content-classes:message
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Subject: RE: [PATCH 2.6.18-rc6-mm1 0/2] cpufreq: make it harder for cpu to leave "hot" mode
Date: Fri, 15 Sep 2006 17:32:18 -0700
Message-ID: <EB12A50964762B4D8111D55B764A845498940F@scsmsx413.amr.corp.intel.com>
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
Thread-Topic: [PATCH 2.6.18-rc6-mm1 0/2] cpufreq: make it harder for cpu to leave "hot" mode
Thread-Index: AcbXuRP9VISibM0RTPCSX0aWZrrPWABaU0Gw
From: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
To: "Nick Orlov" <bugfixer@list.ru>,
       "linux-kernel" <linux-kernel@vger.kernel.org>
Cc: "shin, jacob" <jacob.shin@amd.com>
X-OriginalArrivalTime: 16 Sep 2006 00:32:18.0974 (UTC) FILETIME=[9134B3E0:01C6D927]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

>-----Original Message-----
>From: Nick Orlov [mailto:bugfixer@list.ru] 
>Sent: Wednesday, September 13, 2006 9:48 PM
>To: linux-kernel
>Cc: Pallipadi, Venkatesh
>Subject: Re: [PATCH 2.6.18-rc6-mm1 0/2] cpufreq: make it 
>harder for cpu to leave "hot" mode
>
>On Tue, Sep 12, 2006 at 4:20:57PM EST, Venkatesh Pallipadi wrote:
>>
>> ondemand governor adjusts the sampling rate depending on frequency
>> transition
>> latency of CPU. Say the frequency transition latency for a 
>CPU is 100uS,
>> it will sample atmost once every 100mS and by that rule performance
>> impact of the transitions alone should not be more than 0.1 %.
>>
>> There will be performance impact however, if it chooses a lower
>> frequency and
>> CPU becomes 100% busy immediately after that.
>
>I think I've found the real bug. When we are slowing down 
>after determining
>the desired frequency we are asking for the closest supported 
>freq _below_.
>(CPUFREQ_RELATION_L vs CPUFREQ_RELATION_H). This is definitely going to
>cause freq jump back and forward in some cases (under steady load).
>
>Am I missing something? Is it a desired behavior?
>

RELATION_L and RELATION_H is somewhat confusing.
RELATION_L stands for lowest frequency which is as high as the requested
value. Which will be next highest value greater than equal to the given
value. So, there should not be a issue here.


>> That will be a issue with
>> any history based speculation. Once can have a workload that 
>will fool
>> the
>> algorithm to take wrong decision every time.
>>
>> Having said that, I am curious to see actual numbers that 
>you are seeing
>> in
>> different cases:
>> - The transition latency for frequency switching on your CPU.
>
>How exactly can I check it (I mean I can printk it, but is it exported
>somewhere already?)
>
>> - Default ondemand sampling rate on your system.
>
>after rmmod/modprobe cpufreq_ondemand it is 1240000
>(I'm assuming it means 1.2 secs, which seems to be unexpectedly long)

It is 1.24 seconds. Sampling rate is calculated from Transition latency
and jiffy rate. Transitions latency on this CPU seems to be 1.24
millisecond.

>> - I guess you have a dual core CPU.
>
>Yep, E6 Amd64x2 3800+ (looks like I am the [un]lucky one 
>who've got the CPU born
>to be Toledo and sold as Manchester :) )
>
>>   Whether they are changing frequencies
>>   correctly at the same time or changing frequency of one 
>CPU is wrongly
>>   affecting the other CPU.
>
>Well, I'm assuming it got things right - cpu1/cpufreq is a symlink to
>cpu0/cpufreq ... cpu0/cpufreq/affected_cpus contains "0 1"
>

Hmm. You have software coordination enabled. In which case resyncing of
sampling from all CPUs at the same time should not affect at all. With
software coordination there is only one CPU doing the utilization check
on both cores and taking both cores into appropriate frequency.

>>   - trans table for the load with and without mm changes for 
>ondemand.
>>
>>> To make long story short - reverting -mm changes for
>>> cpufreq_ondemand.c
>>> helps a _LOT_. I'm not sure if it is something powersave_bias
>>> related or
>>> (most probably) due to alignment of "next do_dbs_timer() fire time"
>>> which
>>> could make "collect stats" window too short and introduce
>>> significant errors.
>>> Have not specifically checked ...
>>
>> The change in mm should not change anything related to sampling
>> interval.
>
>I agree, from looking at the changes - it should not. I just wanted to
>eliminate extra variable from the equation (I'm not using 
>powersave_bias,
>so it was "bullet-proof" to just revert the changes).
>
>I'm a speculating here of-course. I did not run comprehensive tests and
>did not perform complex/long measurements. I just reverted the changes,
>recompiled the kernel and played q4 little bit. It definitely 
>_felt_ less
>sluggish (which is purely subjective thing, same as "responsiveness").
>I took a look at the trans_table and numbers were lower (not by order
>of magnitude, but lower). But since each run is unique it is not
>something which "proves" things 100%.

Yes. It will be nice to have some workload and measure the difference.
As you have narrowed down to this patch, I guess there is something
going wrong with the patch. We just have to figure out why and how.

>> This is a heuristic and this change will make ondemand more
>> conservative
>> in some cases and ondemand will not be able to reduce frequency and
>> hence end up consuming more power.
>
>Totally agree. My objective was to make it to "deliver power" 
>as quickly as
>possible and I was ready to accept increased power consumption 
>as long as
>in "idle" CPU eventually goes into the most power-saving mode. (Isn't
>the primary difference between conservative and ondemand governors btw?
>Warm-up quicker, cool-down somewhat slower...)
>

First, I don't think it will be a major impact if we sample at 12 sec as
opposed to 1.2 sec. As you mentioned 1.2sec is already a lot of time
from CPU perspective and should not be having any jitters as such. My
guess is, with 1.2sec, CPU changes frequency so rarely, possiblity of
seeing issue going by response time is much less.

But, I agree with your logic of frequency going down slowly. Infact this
is a fullcircle for ondemand. Ondemand when it was first added in 2.6.9
had sampling for frequency decrease happening at 1/10 the rate of
sampling for frequency increase. Infact that option called
sampling_down_factor was in ondemand as late as 2.6.14. But, as we saw
we were loosing oppurtunities to save power with this option. And hence
moved to having same sampling frequency for up and down.

Conservative is slightly different in that it conservatively
increases/decreases the frequency one P-state at a time and not across
multiple P-state.

>> If we really have a issue
>> with sampling rate, it is possibly due to wrong transition latency
>> advertised by the driver and we are wasting more time doing
>> transitions than ondemand thinks it is spending.
>>
>> If the sampling rate is indeed high for your system/workload, you
>> should be
>> able to get the same result by just increasing the sampling_rate in
>> sysfs cpufreq/ondemand than having a new tunable.
>
>It is not about "transition rate". It is about the fact that we are
>leaving "full-speed" mode (which is somewhat unexpected under q4 load).
>I was just hoping that by increasing sampling period I'm making "load
>measurements" more reliable... On other side I did not want to affect
>"warm up" paths. I do want CPU to speed-up as quickly as possible when
>needed.
>

I understand. But, that will make ondemand less responsive in conserving
power in environments where CPU is loaded at steady rate say 60% or so
in say 1 second interval. As I said, we did try this option earlier, and
found issue with how much power we can save that way.

>I definitely not an expert in power management and I'm not an 
>experienced
>kernel hacker. I'm merely scratching the surface.

Well.. You will be by the time we resolve this issue ;)

>A lot of things are still not clear for me.
>For example:
>
>1. what are "real-world" latencies for the execution of things 
>scheduled
>   through the work-queue? Can these latencies be as high as 1 sec on
>   ~1GHz CPU for example? Under load?
>
>   if execution can be delayed that much then the "delay -= 
>jiffies % delay;"
>   alignment can potentially make measurement period way too short...
>

Yes. This was what I though was happening in your case. But with 1.24
second sampling I doubt this  is happening.

>2. What if process which produces most of the load migrates to another
>   core in the middle of the sampling period? We will end up with 50%
>   load on each core but it does not mean that we can still handle this
>   load on the frequency twice as low... I'm pretty sure we can find
>   elegant "next best thing" solution. I just have not found feasible
>   one yet. Still thinking.
>

Yes. This is a known issue right now. The only solution for this is to
let the frequency adapt to the load quickly enough or to only change the
frequency when all the cores are totally idle.
Most platforms that ondemand runs on have sampling rate of 100 mS or
less, which is comparable to load balancing when busy and hence we
should not see this issue.

But, if sampling latency is > 1s, we can indeed be seeing this issue. A
simple test is to run kernel make in a single thread with one core and
two cores enabled. You will see a noticable slowdown due to this issue
if frequency is changed so less frequently. 

We need someone familiar with these CPUs who can help us understand this
issue. As you can guess I am not an expert on these CPUs :). Copying
Jacob to see whether he has seen any issues with ondemand.

Thanks,
Venki
