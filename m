Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262164AbVBAXEx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262164AbVBAXEx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 18:04:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262162AbVBAXEx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 18:04:53 -0500
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:9653 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S262164AbVBAXEe
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 18:04:34 -0500
Date: Tue, 1 Feb 2005 15:03:57 -0800
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
Message-ID: <20050201230357.GH14274@atomide.com>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201212542.GA3691@openzaurus.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [050201 13:50]:
> Hi!
> 
> > > I used your config advices from second mail, still it does not work as
> > > expected: system gets "too sleepy". Like it takes a nap during boot
> > > after "dyn-tick: Maximum ticks to skip limited to 1339", and key is
> > > needed to make it continue boot. Then cursor stops blinking and
> > > machine is hung at random intervals during use, key is enough to awake
> > > it.
> > 
> > Hmmm, that sounds like the local APIC does not wake up the PIT
> > interrupt properly after sleep. Hitting the keys causes the timer
> > interrupt to get called, and that explains why it keeps running. But
> > the timer ticks are not happening as they should for some reason.
> > This should not happen (tm)...
> 
> :-). Any ideas how to debug it? Previous version of patch seemed to work better...

I don't think it's HPET timer, or CONFIG_SMP. It also looks like your
local APIC timer is working.

If you have a serial console, you can put one letter printks in the
code. Can you check if you ever get to smp_apic_timer_interrupt()?
That's where you should get to after the sleep, and that calls the
PIT timer interrupt to get it going again. I'm thinking that you'll
get to smp_apic_timer_interrupt(), but once therebut function
dyn_tick->interrupt(0, NULL, regs) never gets called.

It's OK to put printks to the timer code here, there's tons of 
output only when the system is busy :)

Also, can you post your .config again? And also please post output
from:

dmesg | grep -i "time\|tick\|apic"

> > I've noticed that the only machine I have with ACPI C2/C3 support
> > does not do anything in the C2/C3 loops, it just spins around and
> > consumes more power than in C1 with hlt!
> > 
> > That's because we currently don't have any code to enable the C2/C3
> > states in the southbridges on many Athlon boards. It's the same
> > problem on my Crusoe laptop ALi 1533 chipset.
> 
> I do not think we should need any chipset-specific code. ACPI
> is expected to solve it... Can you ask on acpi-devel?

Yeah, I've been meaning to, I just subscribed to it yesterday.

Tony
