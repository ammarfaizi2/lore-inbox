Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263375AbVBCW6e@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263375AbVBCW6e (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Feb 2005 17:58:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263178AbVBCWyE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Feb 2005 17:54:04 -0500
Received: from ylpvm43-ext.prodigy.net ([207.115.57.74]:46778 "EHLO
	ylpvm43.prodigy.net") by vger.kernel.org with ESMTP id S261706AbVBCWtX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Feb 2005 17:49:23 -0500
Date: Thu, 3 Feb 2005 08:43:31 -0800
From: Tony Lindgren <tony@atomide.com>
To: Pavel Machek <pavel@suse.cz>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
       Arjan van de Ven <arjan@infradead.org>,
       Martin Schwidefsky <schwidefsky@de.ibm.com>,
       Andrea Arcangeli <andrea@suse.de>, George Anzinger <george@mvista.com>,
       Thomas Gleixner <tglx@linutronix.de>, john stultz <johnstul@us.ibm.com>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       Lee Revell <rlrevell@joe-job.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Dynamic tick, version 050127-1
Message-ID: <20050203164331.GE14325@atomide.com>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz> <20050203030359.GL13984@atomide.com> <20050203105647.GA1369@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050203105647.GA1369@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [050203 02:57]:
> Hi!
> 
> > > > > > > I used your config advices from second mail, still it does not work as
> > > > > > > expected: system gets "too sleepy". Like it takes a nap during boot
> > > > > > > after "dyn-tick: Maximum ticks to skip limited to 1339", and key is
> > > > > > > needed to make it continue boot. Then cursor stops blinking and
> > > > > > > machine is hung at random intervals during use, key is enough to awake
> > > > > > > it.
> > > > > > 
> > > > > > Hmmm, that sounds like the local APIC does not wake up the PIT
> > > > > > interrupt properly after sleep. Hitting the keys causes the timer
> > > > > > interrupt to get called, and that explains why it keeps running. But
> > > > > > the timer ticks are not happening as they should for some reason.
> > > > > > This should not happen (tm)...
> > > > > 
> > > > > :-). Any ideas how to debug it? Previous version of patch seemed to work better...
> > > > 
> > > > I don't think it's HPET timer, or CONFIG_SMP. It also looks like your
> > > > local APIC timer is working.
> > > 
> > > I turned off CONFIG_PREEMPT, but nothing changed :-(.
> > 
> > What about reprogramming the timers in time.c after the sleep? Do
> > you to dyn_tick->skip = 1; part in dyn_tick_timer_interrupt?
> 
> Yes, when I enabled debugging, dbg_dyn_tick_irq() was reached and
> produced lot of noise to syslog. After I done nothing for a while,
> machine would just sit there and wait, not doing anything. When it was
> hung, dbg_dyn_timer_tick was not reached.

OK. Function dbg_dyn_timer_tick only printks if the sleep was less
than expected and the system woke to a non-timer interrupt. But when
idling, it should still printk something occasionally.

> > It could also be that the reprogamming of PIT timer does not work on
> > your machine. I chopped off the udelays there... Can you try
> > something like this:
> 
> I added the udelays, but behaviour did not change.

Yeah, and if the first patch was working better, that means the PIT
interrupts work. I'll do another version of the patch where PIT
interrupts work again without local APIC needed, let's see what
happens with that.

Tony
