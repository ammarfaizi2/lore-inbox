Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261710AbVEBTI4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261710AbVEBTI4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 15:08:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261712AbVEBTI4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 15:08:56 -0400
Received: from ns.suse.de ([195.135.220.2]:21379 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261710AbVEBTIw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 15:08:52 -0400
Date: Mon, 2 May 2005 21:08:50 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Asit K Mallick <asit.k.mallick@intel.com>
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050502190850.GN7342@wotan.suse.de>
References: <20050429172605.A23722@unix-os.sc.intel.com> <20050502163821.GE7342@wotan.suse.de> <20050502101631.A4875@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502101631.A4875@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I thought about it more and i really dislike the broadcast timer
more and more. Zwanes point on creating a lot of contention
on irq0 datastructures is also a very good one.

> Fully agree with you on the mess part :(. Few other options that we had 
> thought about earlier:
> - Have some sort of callbacks while entering/exiting C3, and hand manipulate 
>   Local APIC timer counter to account for the time spent in C3 state. This is
>   less intrusive change (affects only the system that has C3), but code starts 
>   getting ugly once we have time spent in C3 exceed a jiffy and spans across
>   multiple jiffies. And we have to have some execute some code to handle all
>   the lost local APIC timer idle ticks (for the statistics part) and can 
>   increase C3 wakeup latency higher.

It is a bit messy agreed, but no timer tick in idle has to do this
anyways. And we need to communicate with the ACPI idle code even
because we need to shorten delays artificially in lower sleep
modi (e.g. in C1 you dont want to sleep for longer than a ms 
before waking up and switching into C2) 

So given that we need this anyways (and I have it partly coded up
already) I think that is the way to go. The no tick code has 
to query the backing time in this case anyways (or rather use the TSC 
instead which is local - and I hope is still accurate even after C3) 
and fix the timer up. So the infrastructure is there already
and the APIC problem can be handled in the same way.

BTW can you confirm that the APIC timer frequency is stable
over cpufreq changes on your x86-64 CPUs, or does this need
to be handled too? 

The only drawback is that these systems will pretty much need
no timer tick in idle then to be reliable - i had hoped
to keep it an experimental option at the beginning; but I guess
we can accelerate it a bit.

So I would propose to go with this variant.

What do you think?


> - Other simpler solution is to remove idle from cpu_usage_stat and use 
>   (overall time - other accounted time) instead. This doesn't really solve
>   the problem, but it is a workaround for all the code that depends on 
>   proper idle statistics.

What code is that exactly?

In no idle tick I just do the same thing as s390 and accumulate any lost ticks
up in a loop. However I have not done much measurements how affected
the CPU time statistics are.

But when the choice is between better power saving and slightly
less accurate statistics I will prefer better power saving any day - and
the people who really need good statistics are always free to turn
off the power saving, but I doubt that will happen often as long
as the statistics are "good enough". e.g. we can be factor 10 worse
and not be worse than 2.4 with HZ=100. That is a lot of play ground.

-Andi

