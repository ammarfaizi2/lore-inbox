Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261585AbVECOUW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261585AbVECOUW (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 May 2005 10:20:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261667AbVECOUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 May 2005 10:20:14 -0400
Received: from ns.suse.de ([195.135.220.2]:35477 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261589AbVECORx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 May 2005 10:17:53 -0400
Date: Tue, 3 May 2005 16:17:47 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>,
       Linus Torvalds <torvalds@osdl.org>, mingo@elte.hu,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Asit K Mallick <asit.k.mallick@intel.com>
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050503141747.GU7342@wotan.suse.de>
References: <20050429172605.A23722@unix-os.sc.intel.com> <20050502163821.GE7342@wotan.suse.de> <20050502101631.A4875@unix-os.sc.intel.com> <20050502190850.GN7342@wotan.suse.de> <20050502132737.A7309@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050502132737.A7309@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 02, 2005 at 01:27:37PM -0700, Venkatesh Pallipadi wrote:
> On Mon, May 02, 2005 at 09:08:50PM +0200, Andi Kleen wrote:
> > I thought about it more and i really dislike the broadcast timer
> > more and more. Zwanes point on creating a lot of contention
> > on irq0 datastructures is also a very good one.
> > 
> 
> Actually, as IRQ0 will become PER_CPU din broadcast, there are no irq0 lock 
> contention. Only contention that can be there is in scheduler idle balancing,
> which should not be an issue as the CPU is idle anyway.
> 
> > > Fully agree with you on the mess part :(. Few other options that we had 
> > > thought about earlier:
> > > - Have some sort of callbacks while entering/exiting C3, and hand manipulate 
> > >   Local APIC timer counter to account for the time spent in C3 state. This is
> > >   less intrusive change (affects only the system that has C3), but code starts 
> > >   getting ugly once we have time spent in C3 exceed a jiffy and spans across
> > >   multiple jiffies. And we have to have some execute some code to handle all
> > >   the lost local APIC timer idle ticks (for the statistics part) and can 
> > >   increase C3 wakeup latency higher.
> > 
> > It is a bit messy agreed, but no timer tick in idle has to do this
> > anyways. And we need to communicate with the ACPI idle code even
> > because we need to shorten delays artificially in lower sleep
> > modi (e.g. in C1 you dont want to sleep for longer than a ms 
> > before waking up and switching into C2) 
> > 
> > So given that we need this anyways (and I have it partly coded up
> > already) I think that is the way to go. The no tick code has 
> > to query the backing time in this case anyways (or rather use the TSC 
> > instead which is local - and I hope is still accurate even after C3) 
> 
> Unfortunately no :(. TSC will also stop in C3. Myself and John are working on
> another patch to fix TSC based gettimeofday() to handle this (atleast in UP 
> case) It is almost impossible in SMP, as TSCs can go out of sync with C3 on SMP.
> 
> So, ACPI PM timer or HPET seem to be the only option for backing time.

Ok, that is ok too, just slower. May need some heuristics to not do
it that often in this case, but I guess C3 is long enough that
adding the additional overhead for HPET/PM is not that bad.
> 
> cpufreq_ondemand governor depends on the idle statistics. And due to the 
> wrong idle statistics, the governor will keep the CPU frequency at maximum,
> loosing all the power advantages of cpufreq. So, question is not a simple 
> power savings against accurate atatistics. Accurate statistics is related
> to power savings as well...

I guess it just needs to know how long the machine is idle. That is 
relatively easy to do anyways by just accumulating a counter when
the timer is fixed up.

-Andi
