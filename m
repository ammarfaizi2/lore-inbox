Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262098AbVBAUlq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262098AbVBAUlq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 1 Feb 2005 15:41:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262116AbVBAUlq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 1 Feb 2005 15:41:46 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:63913 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262098AbVBAUln
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 1 Feb 2005 15:41:43 -0500
Date: Tue, 1 Feb 2005 12:40:09 -0800
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
Message-ID: <20050201204008.GD14274@atomide.com>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050201110006.GA1338@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Pavel Machek <pavel@suse.cz> [050201 03:03]:
> Hi!
> 
> > Thanks for all the comments, here's an updated version of the dynamic
> > tick patch.
> > 
> > I've fixed couple of things:
> > 
> > - Dyn-tick now supports local APIC timer. This allows longer sleep time
> >   inbetween ticks, over 1000 ticks compared to 54 ticks with PIT timer.
> >   It seems to stop timers on SMP too, but I've only briefly played with
> >   it on SMP.
> 
> I used your config advices from second mail, still it does not work as
> expected: system gets "too sleepy". Like it takes a nap during boot
> after "dyn-tick: Maximum ticks to skip limited to 1339", and key is
> needed to make it continue boot. Then cursor stops blinking and
> machine is hung at random intervals during use, key is enough to awake
> it.

Hmmm, that sounds like the local APIC does not wake up the PIT
interrupt properly after sleep. Hitting the keys causes the timer
interrupt to get called, and that explains why it keeps running. But
the timer ticks are not happening as they should for some reason.
This should not happen (tm)...

I've noticed that the only machine I have with ACPI C2/C3 support
does not do anything in the C2/C3 loops, it just spins around and
consumes more power than in C1 with hlt!

That's because we currently don't have any code to enable the C2/C3
states in the southbridges on many Athlon boards. It's the same
problem on my Crusoe laptop ALi 1533 chipset.

I think we should have some ACPI code that scans the southbridges,
and sets them up with C2/C3 enable functions that can be
enabled/disabled via /sys.

Does anybody happen to have documentation for the ALi 1533, 1535
or M7101 chipset, BTW? I'd like to know how to enable the C2/C3
on it.

Tony
