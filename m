Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261761AbVEBU2U@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261761AbVEBU2U (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 16:28:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbVEBU2U
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 16:28:20 -0400
Received: from fmr22.intel.com ([143.183.121.14]:46266 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S261763AbVEBU14 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 16:27:56 -0400
Date: Mon, 2 May 2005 13:27:37 -0700
From: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
To: Andi Kleen <ak@suse.de>
Cc: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Asit K Mallick <asit.k.mallick@intel.com>
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050502132737.A7309@unix-os.sc.intel.com>
References: <20050429172605.A23722@unix-os.sc.intel.com> <20050502163821.GE7342@wotan.suse.de> <20050502101631.A4875@unix-os.sc.intel.com> <20050502190850.GN7342@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20050502190850.GN7342@wotan.suse.de>; from ak@suse.de on Mon, May 02, 2005 at 09:08:50PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 09:08:50PM +0200, Andi Kleen wrote:
> I thought about it more and i really dislike the broadcast timer
> more and more. Zwanes point on creating a lot of contention
> on irq0 datastructures is also a very good one.
> 

Actually, as IRQ0 will become PER_CPU din broadcast, there are no irq0 lock 
contention. Only contention that can be there is in scheduler idle balancing,
which should not be an issue as the CPU is idle anyway.

> > Fully agree with you on the mess part :(. Few other options that we had 
> > thought about earlier:
> > - Have some sort of callbacks while entering/exiting C3, and hand manipulate 
> >   Local APIC timer counter to account for the time spent in C3 state. This is
> >   less intrusive change (affects only the system that has C3), but code starts 
> >   getting ugly once we have time spent in C3 exceed a jiffy and spans across
> >   multiple jiffies. And we have to have some execute some code to handle all
> >   the lost local APIC timer idle ticks (for the statistics part) and can 
> >   increase C3 wakeup latency higher.
> 
> It is a bit messy agreed, but no timer tick in idle has to do this
> anyways. And we need to communicate with the ACPI idle code even
> because we need to shorten delays artificially in lower sleep
> modi (e.g. in C1 you dont want to sleep for longer than a ms 
> before waking up and switching into C2) 
> 
> So given that we need this anyways (and I have it partly coded up
> already) I think that is the way to go. The no tick code has 
> to query the backing time in this case anyways (or rather use the TSC 
> instead which is local - and I hope is still accurate even after C3) 

Unfortunately no :(. TSC will also stop in C3. Myself and John are working on
another patch to fix TSC based gettimeofday() to handle this (atleast in UP 
case) It is almost impossible in SMP, as TSCs can go out of sync with C3 on SMP.

So, ACPI PM timer or HPET seem to be the only option for backing time.

> and fix the timer up. So the infrastructure is there already
> and the APIC problem can be handled in the same way.
>
> BTW can you confirm that the APIC timer frequency is stable
> over cpufreq changes on your x86-64 CPUs, or does this need
> to be handled too? 

I haven't seen any issues with cpufreq on APIC timer, as APIC timers run 
based on FSB.

> 
> The only drawback is that these systems will pretty much need
> no timer tick in idle then to be reliable - i had hoped
> to keep it an experimental option at the beginning; but I guess
> we can accelerate it a bit.
> 
> So I would propose to go with this variant.
> 
> What do you think?
> 

OK. I have some code that I had prototyped to fixup local APIC counts in 
presence of C3s. I guess we can work together and solve this one faster. 
I will send you the patch in a separate mail.


> > - Other simpler solution is to remove idle from cpu_usage_stat and use 
> >   (overall time - other accounted time) instead. This doesn't really solve
> >   the problem, but it is a workaround for all the code that depends on 
> >   proper idle statistics.
> 
> What code is that exactly?
> 
> In no idle tick I just do the same thing as s390 and accumulate any lost ticks
> up in a loop. However I have not done much measurements how affected
> the CPU time statistics are.
> 
> But when the choice is between better power saving and slightly
> less accurate statistics I will prefer better power saving any day - and
> the people who really need good statistics are always free to turn
> off the power saving, but I doubt that will happen often as long
> as the statistics are "good enough". e.g. we can be factor 10 worse
> and not be worse than 2.4 with HZ=100. That is a lot of play ground.


cpufreq_ondemand governor depends on the idle statistics. And due to the 
wrong idle statistics, the governor will keep the CPU frequency at maximum,
loosing all the power advantages of cpufreq. So, question is not a simple 
power savings against accurate atatistics. Accurate statistics is related
to power savings as well...

Thanks,
Venki



