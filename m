Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965095AbVHZQR4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965095AbVHZQR4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 12:17:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965096AbVHZQR4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 12:17:56 -0400
Received: from atlrel9.hp.com ([156.153.255.214]:65214 "EHLO atlrel9.hp.com")
	by vger.kernel.org with ESMTP id S965095AbVHZQRz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 12:17:55 -0400
Subject: Re: Need better is_better_time_interpolator() algorithm
From: Alex Williamson <alex.williamson@hp.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com>
References: <1124988269.5331.49.camel@tdi>
	 <1124991406.20820.188.camel@cog.beaverton.ibm.com>
	 <1124995405.5331.90.camel@tdi>
	 <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com>
Content-Type: text/plain
Organization: LOSL
Date: Fri, 26 Aug 2005 10:18:09 -0600
Message-Id: <1125073089.5182.30.camel@tdi>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-08-26 at 08:39 -0700, Christoph Lameter wrote:

> I think a priority is something useful for the interpolators. Some of 
> the decisions about which time sources to use also have criteria different 
> from drift/latency/jitter/cpu. F.e. timers may not survive various 
> power-saving configurations. Thus I would think that we need a priority 
> plus some flags.
> 
> Some of the criteria for choosing a time source may be:

Hi Christoph,

   I sent another followup to this thread with a patch containing a
fairly crude algorithm that I think better explains my starting point.
I'm sure the weighting and scaling factors need work, but I think many
of the criteria you describe will favor the right clock.

> 1. If a system boots up with a single cpu then there is no question that 
> the ITC/TSC should be used because of the fast access.

I'm hoping the jitter/cpu and latency calculation will always end up
favoring the cycle counter in the scenario.

> 2. If the BIOS is capable of perfect ITC/TSC synchronization then use 
>    the ITC/TSC. However, this is typically restricted to SMP configs and 
>    there is an issue on IA64 that the PAL can indicate a nodrift 
>    configuration but Linux is not capable of perfects sync on bootup.

If we're setting the jitter flag appropriately, which I think we are,
then the low latency of the ITC and lack of jitter penalty should do the
right thing here.

> 3. If a memory mapped global clock is available then make sure to 
>    first use a distributed timer over a centralized time source because
>    distributed timer have fast local access even under contention. 
>    I.e. use Altix RTC over HPET/Cyclone.
> 
> 4. Use any memory mapped global clock source 

Scaling the latency to the average across a NUMA system will
automatically order these correctly.  They will definitely have higher
latency than the ITC, so should fall about here on the list.  It's easy
to make the Altix RTC have no node association and therefore not
penalize the access latency further.

> 5. Abuse some other system component for time keeping (PIT, i/o devices 
> etc)
> 
> The criteria for drift/latency can only be established after we gone 
> through the above. The low-power stuff adds additional complexity.
> 
> We may need to dynamically change timer interpolators / time sources if 
> the power situation changes. Nothing like that exists today for time 
> interpolators since they are mostly used in server configurations.

   Yes, I don't know how to handle low power situations other than have
a flag on the interpolators and a hook to switch to the best low power
timer when the need arises.  We may need to use the same hook to
re-evaluate the timer when a CPU hotplug occurs.  This way we could
dynamically fall back to case 1 above if most of the CPUs are removed
(and likewise move to an hpet if CPUs are added).

   I was looking into the suggestion to use logarithms to try to
normalize some of the factors such that weighting is more logical.
Hopefully that won't explode the complexity.  Thanks,

	Alex

-- 
Alex Williamson                             HP Linux & Open Source Lab

