Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262714AbVBCDFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262714AbVBCDFk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Feb 2005 22:05:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262817AbVBCDFj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Feb 2005 22:05:39 -0500
Received: from ylpvm29-ext.prodigy.net ([207.115.57.60]:62119 "EHLO
	ylpvm29.prodigy.net") by vger.kernel.org with ESMTP id S262714AbVBCDFV
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Feb 2005 22:05:21 -0500
Date: Wed, 2 Feb 2005 19:04:00 -0800
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
Message-ID: <20050203030359.GL13984@atomide.com>
References: <20050127212902.GF15274@atomide.com> <20050201110006.GA1338@elf.ucw.cz> <20050201204008.GD14274@atomide.com> <20050201212542.GA3691@openzaurus.ucw.cz> <20050201230357.GH14274@atomide.com> <20050202141105.GA1316@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="d6Gm4EdcadzBjdND"
Content-Disposition: inline
In-Reply-To: <20050202141105.GA1316@elf.ucw.cz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

* Pavel Machek <pavel@suse.cz> [050202 06:13]:
> 
> Hi!
> 
> > > > > I used your config advices from second mail, still it does not work as
> > > > > expected: system gets "too sleepy". Like it takes a nap during boot
> > > > > after "dyn-tick: Maximum ticks to skip limited to 1339", and key is
> > > > > needed to make it continue boot. Then cursor stops blinking and
> > > > > machine is hung at random intervals during use, key is enough to awake
> > > > > it.
> > > > 
> > > > Hmmm, that sounds like the local APIC does not wake up the PIT
> > > > interrupt properly after sleep. Hitting the keys causes the timer
> > > > interrupt to get called, and that explains why it keeps running. But
> > > > the timer ticks are not happening as they should for some reason.
> > > > This should not happen (tm)...
> > > 
> > > :-). Any ideas how to debug it? Previous version of patch seemed to work better...
> > 
> > I don't think it's HPET timer, or CONFIG_SMP. It also looks like your
> > local APIC timer is working.
> 
> I turned off CONFIG_PREEMPT, but nothing changed :-(.

What about reprogramming the timers in time.c after the sleep? Do
you to dyn_tick->skip = 1; part in dyn_tick_timer_interrupt?

It could also be that the reprogamming of PIT timer does not work on
your machine. I chopped off the udelays there... Can you try
something like this:

--d6Gm4EdcadzBjdND
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename=patch-pit-udelay

--- a/arch/i386/kernel/time.c	2005-01-27 12:58:04 -08:00
+++ b/arch/i368/kernel/time.c	2005-02-02 19:01:31 -08:00
@@ -479,8 +480,11 @@
 
 	spin_lock_irqsave(&i8253_lock, flags);
 	outb_p(0x34, PIT_MODE);		/* binary, mode 2, LSB/MSB, ch 0 */
+	udelay(10);
 	outb_p(skip & 0xff, PIT_CH0);	/* LSB */
+	udelay(10);
 	outb(skip >> 8, PIT_CH0);	/* MSB */
+	udelay(10);
 	spin_unlock_irqrestore(&i8253_lock, flags);
 }
 

--d6Gm4EdcadzBjdND--
