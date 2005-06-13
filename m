Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261226AbVFMTf7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261226AbVFMTf7 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 15:35:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVFMTf7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 15:35:59 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:39613 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S261226AbVFMTf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 15:35:27 -0400
X-ORBL: [67.117.73.34]
Date: Mon, 13 Jun 2005 12:35:03 -0700
From: Tony Lindgren <tony@atomide.com>
To: Andi Kleen <ak@muc.de>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
Message-ID: <20050613193503.GJ8020@atomide.com>
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <20050613170941.GA1043@in.ibm.com> <m1k6kyb0px.fsf@muc.de> <20050613183716.GH8020@atomide.com> <20050613185109.GA86745@muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613185109.GA86745@muc.de>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Andi Kleen <ak@muc.de> [050613 11:51]:
> On Mon, Jun 13, 2005 at 11:37:16AM -0700, Tony Lindgren wrote:
> > * Andi Kleen <ak@muc.de> [050613 10:57]:
> > > Srivatsa Vaddagiri <vatsa@in.ibm.com> writes:
> > > >
> > > > 2. reprogram_apic_timer seems to reprogram the count-down
> > > >    APIC timer (APIC_TMICT) with an integral number of apic_timer_val.
> > > >    How accurate will this be? Shouldnt this take into account
> > > >    that we may not be reprogramming the timer on exactly "jiffy"
> > > >    boundary?
> > > 
> > > All PIT based reprogramming schemes will lose time.
> > 
> > Not true if the timesource is different from interrupt source.
> > 
> > Consider PM timer for timesource, and PIT for interrupt source. Reprogamming
> > PIT should not affect PM timer. Time is always updated from PM timer.
> 
> PM timer is not really suitable for this because it overflows
> too quickly (several times a second). 

It's longer than PIT overflow, which means it can be used.

> Also you still lose time in timers (e.g. your internal timers slowly drift)
> unless you regularly sync with the time source, but that has other
> drawbacks.
> 
> > >
> > > Actually there is a small reason - RCU currently does not get 
> > > updated by a fully idle CPU and can stall other CPUs. But that is in 
> > > practice not too big an issue yet because so many subsystems
> > > cause ticks now and then, so the CPUs tend to wake up often
> > > enough to not stall the rest of the system too badly.
> > 
> > I guess it should be safe to reprogram timer even if other CPUs are not
> > idle, assuming the busy CPUs reprogramming timer will also wake up the idle
> > CPUs.
> > 
> > There's one thing that should be considered though; Reprogamming
> > timers should be avoided if the system is busy as it causes
> > performance issues. Especially reprogramming PIT.
> 
> Just forget about reprogramming with PIT. IMHO that should
> be never used in production. The right way for this 
> is HPET.

PIT + PM timer / TSC is already working quite nicely. Of course it does not
allow long sleeps, but it still helps in bringing down the HZ to about 35HZ.

> The main issue with HPET is that many BIOS even though the chipsets
> have it don't set up the HPET table because Windows doesn't use
> it right now. However that can be avoided with some chipset
> specific code.

I don't have any x86 HPET hardware right now. But it sounds like it should
allow multisecond skipping of ticks.

Regards,

Tony
