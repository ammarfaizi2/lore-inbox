Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030411AbWILUUi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030411AbWILUUi (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 16:20:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030412AbWILUUi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 16:20:38 -0400
Received: from mga07.intel.com ([143.182.124.22]:14350 "EHLO
	azsmga101.ch.intel.com") by vger.kernel.org with ESMTP
	id S1030411AbWILUUh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 16:20:37 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,155,1157353200"; 
   d="scan'208"; a="115418627:sNHT65623306"
Date: Tue, 12 Sep 2006 13:05:00 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: linux-kernel <linux-kernel@vger.kernel.org>, cpufreq@lists.linux.org.uk,
       Andrew Morton <akpm@osdl.org>, Dave Jones <davej@codemonkey.org.uk>
Cc: alexey.y.starikovskiy@intel.com, Len Brown <len.brown@intel.com>
Subject: Re: [PATCH 2.6.18-rc6-mm1 0/2] cpufreq: make it harder for cpu to leave "hot" mode
Message-ID: <20060912130500.A15552@unix-os.sc.intel.com>
References: <20060912032924.GA3677@nickolas.homeunix.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20060912032924.GA3677@nickolas.homeunix.com>; from bugfixer@list.ru on Mon, Sep 11, 2006 at 11:29:24PM -0400
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 11, 2006 at 11:29:24PM -0400, Nick Orlov wrote:
> Andrew,
> 
> I was playing with ondemand cpufreq governor (gotta save on electricity
> bills one day :) ) and I've noticed that gameplay become somewhat sluggish.
> Especially noticeble in something cpu-power demanding, like quake4.
> Quick look at stats/trans_table confirmed that CPU goes out of "hot" mode
> way too often.
> 

ondemand governor adjusts the sampling rate depending on frequency transition
latency of CPU. Say the frequency transition latency for a CPU is 100uS,
it will sample atmost once every 100mS and by that rule performance
impact of the transitions alone should not be more than 0.1 %.

There will be performance impact however, if it chooses a lower frequency and
CPU becomes 100% busy immediately after that. That will be a issue with
any history based speculation. Once can have a workload that will fool the
algorithm to take wrong decision every time.

Having said that, I am curious to see actual numbers that you are seeing in
different cases:
- The transition latency for frequency switching on your CPU.
- Default ondemand sampling rate on your system.
- Different frequencies supported on your system.
- I guess you have a dual core CPU. Whether they are changing frequencies 
correctly at the same time or changing frequency of one CPU is wrongly 
affecting the other CPU.
- trans table for the load with and without mm changes for ondemand.

> To make long story short - reverting -mm changes for cpufreq_ondemand.c
> helps a _LOT_.  I'm not sure if it is something powersave_bias related or
> (most probably) due to alignment of "next do_dbs_timer() fire time" which
> could make "collect stats" window too short and introduce significant errors.
> Have not specifically checked ...

The change in mm should not change anything related to sampling interval. If
it is indeed doing something like that, then it will be a bug. Can you please
check sampling_rate (under sys cpufreq/ondemand) with and without mm changes.
That will tell how frequently kernel is checking the stats.

> 
> After thinking about the issue for a while I come up with the following tweaks:
> First of all I made hysteresis little bit wider (20% instead of 10).

This is a heuristic and this change will make ondemand more conservative
in some cases and ondemand will not be able to reduce frequency and
hence end up consuming more power.

If this is really needed, then it sould be a tunable to ondemand rather than a
new absolute value. As this is only changing the next frequency to be one that
keeps CPU 60% busy than 70% busy, and these two frequencies must be close
to each other anyway, I dont think this can cause performance degradation
due to wrong/low freq.

> Another idea was to increase "sampling period" once cpu is in "hot" mode.
> 
> Second part also have benefits of reducing the load on already overloaded cpu.
> Plus it's damn trivial. To simplify further testing I have exposed
> "sampling_rate_hot" parameter through sysfs. Setting it to sampling_rate * 10
> works for me very well. Now I do not have to switch governor to "performance"
> during game sessions.
> 

Again, I dont think frequent checking in ondemand is a bad thing as
it allows ondemand to be aggressive and save as much power and also
have quick response time for increased load. If we really have a issue
with sampling rate, it is possibly due to wrong transition latency
advertised by the driver and we are wasting more time doing
transitions than ondemand thinks it is spending.

If the sampling rate is indeed high for your system/workload, you should be
able to get the same result by just increasing the sampling_rate in 
sysfs cpufreq/ondemand than having a new tunable.

Thanks,
Venki
