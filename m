Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261298AbVFNDrQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261298AbVFNDrQ (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 23:47:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261432AbVFNDrQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 23:47:16 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:3742 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261298AbVFNDrC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 23:47:02 -0400
Date: Mon, 13 Jun 2005 20:46:55 -0700
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: john stultz <johnstul@us.ibm.com>
Cc: lkml <linux-kernel@vger.kernel.org>,
       Tim Schmielau <tim@physik3.uni-rostock.de>,
       George Anzinger <george@mvista.com>, albert@users.sourceforge.net,
       Ulrich Windl <ulrich.windl@rz.uni-regensburg.de>,
       Christoph Lameter <clameter@sgi.com>,
       Dominik Brodowski <linux@dominikbrodowski.de>,
       David Mosberger <davidm@hpl.hp.com>, Andi Kleen <ak@suse.de>,
       paulus@samba.org, schwidefsky@de.ibm.com,
       keith maanthey <kmannth@us.ibm.com>, Chris McDermott <lcm@us.ibm.com>,
       Max Asbock <masbock@us.ibm.com>, mahuja@us.ibm.com,
       Darren Hart <darren@dvhart.com>, "Darrick J. Wong" <djwong@us.ibm.com>,
       Anton Blanchard <anton@samba.org>, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org, kernel-stuff@comcast.net, frank@tuxrocks.com
Subject: [PATCH 0/4] new timeofday-based soft-timer subsystem
Message-ID: <20050614034655.GA4180@us.ibm.com>
References: <1118286702.5754.44.camel@cog.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1118286702.5754.44.camel@cog.beaverton.ibm.com>
X-Operating-System: Linux 2.6.12-rc5 (i686)
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.06.2005 [20:11:42 -0700], john stultz wrote:
> Hey Everyone,
> 	I'm heading out on vacation until Monday, so I'm just re-spinning my
> current tree for testing. If there's no major issues on Monday, I'll re-
> diff against Andrew's tree and re-submit the patches for inclusion.

Here is an update of my soft-timer rework to John's latest patches. I
have made some major changes in this revision. I would still greatly
appreciate any comments.

Changes:

	The timerinterval value of the soft-timer's expires is never
	stored. Instead, we store the nanosecond request in a new member
	of struct timer_list, expires_nsecs. This does make the
	structure 64 bits larger, but also means expires is deprecated
	along with the expires-style interfaces (add_timer(),
	mod_timer()) and thus the long term addition is 32 bits.
	Whenever we need the timerinterval value, we calculate it via
	the shift/and operation, which should be pretty quick.

Notes / Blocking Issues:

	No non-NEWTOD support yet, which means this patch isn't
	appropriate for any mainline inclusion yet. It should be a small
	patch to timeofday.h to emulate do_monotonic_clock() [the only
	soft-timer dependence on the timeofday code] with
	jiffies_to_nsecs(jiffies - INITIAL_JIFFIES). But I ran into some
	build issues with that change; I'll try to get a patch out soon,
	though. I was able to test my patch with this emulation by
	moving do_monotonic_clock() in ppc64, which is where I got the
	ppc64 benchmark numbers below.

	NUMA-Q is definitely broken with my patch, but not NUMA itself.
	Honestly not sure why, but timeofday seems to also be broken on
	NUMA-Q -- it sets up the TSC as the timesource, even though it
	shouldn't be (booting with notsc on NUMA-Qs seems to fix the
	problem for John's patches, at least).

Some design points:

1) The patches are small but do a lot.
a) Renames timer_jiffies to last_timer_time (now that we are not
	jiffies-based).
b) Converts the soft-timer time-vector's/bucket's entries to
	timerinterval (a new unit) width, instead of jiffy width.
c) Defines timerintervals to be the current time as reported by the new
	timeofday-subsystem shifted down by TIMERINTERVAL_BITS bits.
	Thus, various pseudo-'human time' units can be emulated. The
	default value for TIMERINTERVAL_BITS is 19.
d) Uses do_monotonic_clock() (converted to timerintervals) as the basis
	for addition and expiration of timers instead of jiffies.
e) Adds some new helper functions for dealing with nanosecond values.

2) The reason for the re-work? Many people complain about all of the
adding of 1 jiffy here or there to fix bugs. This new systems is
fundamentally human-time oriented and deals with those issues correctly
and, more importantly, sanely :)

The code is reasonably well commented, but does expect readers to
understand the current soft-timer subsystem.

This is still an early working of this patch, so I expect criticism, and
am happy to make changes.

Benchmark differentials follow in this mail [1].

Overview:

1/4: Converts the soft-timer subsystem to use timerinterval as the units
of addition and expiration.

2/4: Converts, as an example, sys_nanosleep() to use the new interfaces
provided by patch 2. Example latency values are also below [2],
demonstrating improvements in the min, max and average latency for
sys_nanosleep() (which uses schedule_timeout_nsecs() internally with my
patch).

Thanks,
Nish

[1] Benchmark Differentials on various machines

x86_64, 4-way 1.7 GHz Opteron, 8GB RAM
			Elapsed	User	System	CPU
2.6.12-rc6		100%	100%	100%	100%
2.6.12-rc6-tod		99.67%	99.77%	99.44%	99.79%
2.6.12-rc6-tod-timer	99.8%	99.97%	99.73%	99.79%

non-numaq big x86, 16-way 1.4 GHz Xeon, 15GB RAM
			Elapsed	User	System	CPU
2.6.12-rc6		100%	100%	100%	100%
2.6.12-rc6-tod		99.95%	99.75%	99.51%	99.76%
2.6.12-rc6-tod-timer	100.88%	100.04%	99.55%	99.11%

small x86, 1-way 2.66 GHz P4, 512MB RAM
			Elapsed	User	System	CPU
2.6.12-rc6		100%	100%	100%	100%
2.6.12-rc6-tod		99.4%	102.87%	95.72%	100%
2.6.12-rc6-tod-timer	99.33%	102.69%	97.33%	100%


ppc64, 8-way 1.2GHz Power4, 12GB RAM
			Elapsed	User	System	CPU
2.6.12-rc6		100%	100%	100%	100%
2.6.12-rc6-tod		95.59%	100.04%	101.28%	104.81%
2.6.12-rc6-tod-timer	97.26%	100.04%	100.58%	102.91%

[2] Latency measured via sys_nanosleep(), 1,000,000 calls

			latencies in us, min/max/avg
Request		stock		tod		tod-timer
1000 us		2017/4004/3001	2011/4024/3001	1020/2531/1771
100 us		1022/3001/2000	1028/2995/2001	111/1619/866
1 us		1021/3004/2000	1032/3000/1997	11/1524/764
