Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265111AbTL2Tc6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Dec 2003 14:32:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265112AbTL2Tc6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Dec 2003 14:32:58 -0500
Received: from obsidian.spiritone.com ([216.99.193.137]:59563 "EHLO
	obsidian.spiritone.com") by vger.kernel.org with ESMTP
	id S265111AbTL2Tc4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Dec 2003 14:32:56 -0500
Date: Mon, 29 Dec 2003 11:32:00 -0800
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: John Hawkes <hawkes@google.engr.sgi.com>, Andrew Morton <akpm@osdl.org>
cc: lse-tech@lists.sourceforge.net, mingo@elte.hu,
       linux-kernel@vger.kernel.org, johnstul@us.ibm.com
Subject: Re: [Lse-tech] Re: [RFC][PATCH] 2.6.0-test11 sched_clock() broken for "drifty ITC"
Message-ID: <30410000.1072726318@[10.10.2.4]>
In-Reply-To: <200312291851.KAA25312@google.engr.sgi.com>
References: <200312182044.hBIKiCLY5477429@babylon.engr.sgi.com> <200312291851.KAA25312@google.engr.sgi.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> Could you please finalise it, cook up the ia64 and numaq implementations
>> and send it over?
> 
> I believe the "ia64 implementation" stands as-is, since it uses the low-
> overhead ITC.
> 
> I'm not familiar with NUMAQ issues, but perhaps this timer_tsc.c change
> would be appropriate?  It allows i386 CONFIG_NUMA platforms to potentially
> use the TSC for sched_clock() timings, given that sched_clock() no longer
> requires that the TSC be synchronized across all CPUs.  It does, however,
> require that "use_tsc" be properly initialized for i386 CONFIG_NUMA.  Is
> that a valid assumption?

I don't think there's anything special about use_tsc for NUMA-Q - it's
set to 1 AFAICS. I had a patch to force notsc on about 6 months or so
ago, but it made the machine crash hard in strange ways I never bothered
debugging. 

Is there any harm in dropping the first part of your patch, ie.

> diff -X /home/hawkes/Patches/ignore.dirs -Naur linux-2.6.0/arch/i386/kernel/timers/timer_tsc.c linux-2.6.0-schedclock2/arch/i386/kernel/timers/timer_tsc.c
> --- linux-2.6.0/arch/i386/kernel/timers/timer_tsc.c	Mon Nov 24 12:18:20 2003
> +++ linux-2.6.0-schedclock2/arch/i386/kernel/timers/timer_tsc.c	Sat Dec 13 11:33:04 2003
> @@ -138,9 +138,7 @@
>  	 * In the NUMA case we dont use the TSC as they are not
>  	 * synchronized across all CPUs.
>  	 */
> -#ifndef CONFIG_NUMA
>  	if (!use_tsc)
> -#endif
>  		return (unsigned long long)jiffies * (1000000000 / HZ);
>  
>  	/* Read the Time Stamp Counter */

and leaving the rest of it? the CONFIG_NUMA affects both NUMA-Q and Summit,
BTW, which uses the cyclone timer, so it gets even more complex ;-)

M.
