Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965081AbVHZPkJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965081AbVHZPkJ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Aug 2005 11:40:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965083AbVHZPkJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Aug 2005 11:40:09 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23260 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965081AbVHZPkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Aug 2005 11:40:08 -0400
Date: Fri, 26 Aug 2005 08:39:49 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Alex Williamson <alex.williamson@hp.com>
cc: john stultz <johnstul@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: Need better is_better_time_interpolator() algorithm
In-Reply-To: <1124995405.5331.90.camel@tdi>
Message-ID: <Pine.LNX.4.62.0508260827330.14463@schroedinger.engr.sgi.com>
References: <1124988269.5331.49.camel@tdi>  <1124991406.20820.188.camel@cog.beaverton.ibm.com>
 <1124995405.5331.90.camel@tdi>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 Aug 2005, Alex Williamson wrote:

>    I don't know that it's that uncommon.  Simply having one non-arch
> specific timer is enough to need to decided whether it's better than a
> generic timer.  I assume pretty much every arch has a cycle timer.  For
> smaller boxes, this might be the preferred timer given it's latency even
> if something like an hpet exists (mmio access are expensive).  How do
> you hard code a value that can account for that?  I agree, we could
> easily go too far and produce some bloated algorithm, but maybe it's
> simply a weighted product of a few variables.

I think a priority is something useful for the interpolators. Some of 
the decisions about which time sources to use also have criteria different 
from drift/latency/jitter/cpu. F.e. timers may not survive various 
power-saving configurations. Thus I would think that we need a priority 
plus some flags.

Some of the criteria for choosing a time source may be:

1. If a system boots up with a single cpu then there is no question that 
the ITC/TSC should be used because of the fast access.

2. If the BIOS is capable of perfect ITC/TSC synchronization then use 
   the ITC/TSC. However, this is typically restricted to SMP configs and 
   there is an issue on IA64 that the PAL can indicate a nodrift 
   configuration but Linux is not capable of perfects sync on bootup.

3. If a memory mapped global clock is available then make sure to 
   first use a distributed timer over a centralized time source because
   distributed timer have fast local access even under contention. 
   I.e. use Altix RTC over HPET/Cyclone.

4. Use any memory mapped global clock source 

5. Abuse some other system component for time keeping (PIT, i/o devices 
etc)

The criteria for drift/latency can only be established after we gone 
through the above. The low-power stuff adds additional complexity.

We may need to dynamically change timer interpolators / time sources if 
the power situation changes. Nothing like that exists today for time 
interpolators since they are mostly used in server configurations.

