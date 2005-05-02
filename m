Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261615AbVEBSlh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261615AbVEBSlh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 14:41:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261631AbVEBSlh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 14:41:37 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:35469 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261615AbVEBSld (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 14:41:33 -0400
Message-ID: <42767476.5050201@us.ibm.com>
Date: Mon, 02 May 2005 11:41:58 -0700
From: Darren Hart <dvhltc@us.ibm.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050404)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Nishanth Aravamudan <nacc@us.ibm.com>
CC: john stultz <johnstul@us.ibm.com>, lkml <linux-kernel@vger.kernel.org>,
       albert@users.sourceforge.net, paulus@samba.org, schwidefsky@de.ibm.com,
       mahuja@us.ibm.com, donf@us.ibm.com, mpm@selenic.com,
       benh@kernel.crashing.org
Subject: Re: [RFC][PATCH] new timeofday-based soft-timer subsystem
References: <1114814747.28231.2.camel@cog.beaverton.ibm.com> <20050429233546.GB2664@us.ibm.com>
In-Reply-To: <20050429233546.GB2664@us.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nishanth Aravamudan wrote:
 > * john stultz <johnstul@us.ibm.com> [2005-0429 15:45:47 -0700]:
 >
 >
 >>All,
 >>        This patch implements the architecture independent portion of
 >>the time of day subsystem. For a brief description on the rework, see
 >>here: http://lwn.net/Articles/120850/ (Many thanks to the LWN team for
 >>that clear writeup!)
 >
 >
 > I have been working closely with John to re-work the soft-timer subsytem
 > to use the new timeofday() subsystem. The following patch attempts to
 > being this process. I would greatly appreciate any comments.
 >
 >

Also working closely with John and Nish, I have been taking advantage of 
the new human-time soft-timer subsystem and the NO_IDLE_HZ code to 
dynamically schedule interrupts as needed.  The idea is to have 
interrupt source drivers (PIT, Local APIC, HPET, ppc decrementers, etc) 
similar to the time sources in John's timeofday patches.

Because the resolution of the soft-timer sybsystem is configurable via 
TIMER_INTERVAL_BITS, and the timeofday code is now free of the periodic 
system tick, we can move the soft-timers to a dynamically scheduled 
interrupt system.  We can achieve both sub-millisecond timer resolution 
and NO_IDLE_HZ simply by adjusting TIMER_INTERVAL_BITS and scheduling 
the next timer interrupt appropriately whenever a soft-timer is added or 
removed.

In general at the end of set_timer_nsecs(), we see when the next timer 
is due to expire and pass that value (in absolute nanoseconds) to 
schedule_next_timer_interrupt().  Each interrupt source driver is then 
free to reprogram the hard-timer to the "best" interval.  For something 
like the local APIC, that may be exactly when the next timer needs to go 
off.  For the PIT, it may do nothing at all and just fire periodically.

I have a prototype using the PIT, which just demonstrates that the 
system will still run this way.  Obviously other timers will perform 
much better since the PIT is so slow to program.

I feel that this is a clean approach to two soft-timer issues: 
resolution and NO_IDLE_HZ.  It integrates well with the patches from 
John and Nish and is a direct approach to these issues, rather than an 
attempt to add support on top of a jiffies based soft-timer subsystem.

I'd appreciate any feedback people have to offer.  Particularly those 
that have been working on alternative approaches to things like high 
resolution timers and NO_IDLE_HZ.

Thanks,


-- 
Darren Hart
IBM Linux Technology Center
Linux Kernel Team
Phone: 503 578 3185
   T/L: 775 3185
