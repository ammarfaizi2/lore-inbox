Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261207AbVFMSy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261207AbVFMSy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 14:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261216AbVFMSy4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 14:54:56 -0400
Received: from colin.muc.de ([193.149.48.1]:12562 "EHLO mail.muc.de")
	by vger.kernel.org with ESMTP id S261207AbVFMSvO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 14:51:14 -0400
Date: 13 Jun 2005 20:51:09 +0200
Date: Mon, 13 Jun 2005 20:51:09 +0200
From: Andi Kleen <ak@muc.de>
To: Tony Lindgren <tony@atomide.com>
Cc: vatsa@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick for x86 version 050609-2
Message-ID: <20050613185109.GA86745@muc.de>
References: <88056F38E9E48644A0F562A38C64FB6004EBD10C@scsmsx403.amr.corp.intel.com> <20050609014033.GA30827@atomide.com> <20050610043018.GE18103@atomide.com> <20050613170941.GA1043@in.ibm.com> <m1k6kyb0px.fsf@muc.de> <20050613183716.GH8020@atomide.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050613183716.GH8020@atomide.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 13, 2005 at 11:37:16AM -0700, Tony Lindgren wrote:
> * Andi Kleen <ak@muc.de> [050613 10:57]:
> > Srivatsa Vaddagiri <vatsa@in.ibm.com> writes:
> > >
> > > 2. reprogram_apic_timer seems to reprogram the count-down
> > >    APIC timer (APIC_TMICT) with an integral number of apic_timer_val.
> > >    How accurate will this be? Shouldnt this take into account
> > >    that we may not be reprogramming the timer on exactly "jiffy"
> > >    boundary?
> > 
> > All PIT based reprogramming schemes will lose time.
> 
> Not true if the timesource is different from interrupt source.
> 
> Consider PM timer for timesource, and PIT for interrupt source. Reprogamming
> PIT should not affect PM timer. Time is always updated from PM timer.

PM timer is not really suitable for this because it overflows
too quickly (several times a second). 

Also you still lose time in timers (e.g. your internal timers slowly drift)
unless you regularly sync with the time source, but that has other
drawbacks.

> >
> > Actually there is a small reason - RCU currently does not get 
> > updated by a fully idle CPU and can stall other CPUs. But that is in 
> > practice not too big an issue yet because so many subsystems
> > cause ticks now and then, so the CPUs tend to wake up often
> > enough to not stall the rest of the system too badly.
> 
> I guess it should be safe to reprogram timer even if other CPUs are not
> idle, assuming the busy CPUs reprogramming timer will also wake up the idle
> CPUs.
> 
> There's one thing that should be considered though; Reprogamming
> timers should be avoided if the system is busy as it causes
> performance issues. Especially reprogramming PIT.

Just forget about reprogramming with PIT. IMHO that should
be never used in production. The right way for this 
is HPET.

The main issue with HPET is that many BIOS even though the chipsets
have it don't set up the HPET table because Windows doesn't use
it right now. However that can be avoided with some chipset
specific code.

-Andi
