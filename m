Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261440AbVEBQpy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261440AbVEBQpy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 May 2005 12:45:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261517AbVEBQnd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 May 2005 12:43:33 -0400
Received: from mx1.suse.de ([195.135.220.2]:58549 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S261483AbVEBQi1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 May 2005 12:38:27 -0400
Date: Mon, 2 May 2005 18:38:21 +0200
From: Andi Kleen <ak@suse.de>
To: Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>
Cc: Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>,
       mingo@elte.hu, linux-kernel <linux-kernel@vger.kernel.org>,
       Rajesh Shah <rajesh.shah@intel.com>, John Stultz <johnstul@us.ibm.com>,
       Andi Kleen <ak@suse.de>, Asit K Mallick <asit.k.mallick@intel.com>
Subject: Re: [RFC][PATCH] i386 x86-64 Eliminate Local APIC timer interrupt
Message-ID: <20050502163821.GE7342@wotan.suse.de>
References: <20050429172605.A23722@unix-os.sc.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050429172605.A23722@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 29, 2005 at 05:26:05PM -0700, Venkatesh Pallipadi wrote:
> 
> Background: 
> Local APIC timer stops functioning when CPU is in C3 state. As a
> result the local APIC timer interrupt will fire at uncertain times, depending
> on how long we spend in C3 state. And this has two side effects
> * Idle balancing will not happen as we expect it to.
> * Kernel statistics for idle time will not be proper (as we get less LAPIC
>   interrupts when we are idle). This can result in confusing other parts of
>   kernel (like ondemand cpufreq governor) which depends on this idle stats.

This is absolutely incompatible to no timer tick in IDLE - at least
my implementation that allows to keep all CPUs indepently in idle,
not require all CPUs to be idle to turn off the timers.

I had hoped that the hardware was clever enough to keep the
APIC timers working on SMP systems.

This is very unfortunate :-(( It means you will always 
waste a lot of power on a partially idle system, because
you cannot keep individual CPUs sleeping for a longer time.

I ran into the problem on AMD systems with C2 state - in 
my initial implementation there was only the APIC timer for
any time keeping because it is cheaper to reprogram and
there are a lot of chipsets which miss HPET - and on the
BP only the APIC timer was ticking at all, which did not 
work very well. This was avoided by using
PIT/HPET on the BP again. But on SMP systems there is not
much choice on the APs.



> it simplifies things and will have other advantages:
> * Should help dynamick tick as one has to change only global timer interrupt 
>   freq with varying jiffies.

Huh? On contrary it completely kills really SMP aware dynamic tick
implementations.

I would really prefer to find some other way to solve this

Perhaps if we have enough timer sources in HPET we can use the 3-4
HPET timers on different CPUs. That would work on upto 4 socket
systems (sibling/dual core can be ignored I guess because for
power management purposes they dont really exist) 

This would be a problem for the few applications that use HPET
from user space for application timers, but I  think power saving
is more important than them or they can disable dynamic tick.

It is a big mess. I begin to envy the PPC guys who
actually have usable per CPU timers.

-Andi


