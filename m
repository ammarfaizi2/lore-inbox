Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751329AbVJPQfi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751329AbVJPQfi (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 16 Oct 2005 12:35:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751331AbVJPQfi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 16 Oct 2005 12:35:38 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:5784 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S1751329AbVJPQfi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 16 Oct 2005 12:35:38 -0400
Date: Sun, 16 Oct 2005 18:34:58 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: George Anzinger <george@mvista.com>
cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       mingo@elte.hu, Andrew Morton <akpm@osdl.org>, johnstul@us.ibm.com,
       paulmck@us.ibm.com, Christoph Hellwig <hch@infradead.org>,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <434DA06C.7050801@mvista.com>
Message-ID: <Pine.LNX.4.61.0510150143500.1386@scrub.home>
References: <20050928224419.1.patchmail@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0509301825290.3728@scrub.home>  <1128168344.15115.496.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510100213480.3728@scrub.home> <1129016558.1728.285.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 12 Oct 2005, George Anzinger wrote:

> > > > > As far as I understand SUS timer resolution is equal to clock
> > > > > resolution
> > > > > and the timer value/interval is rounded up to the resolution.
> > > > 
> > > > Please check the rationale about clocks and timers. It talks about
> > > > clocks and timer services based on them and their resolutions can be
> > > > different.
> 
> Well, yes and no.  Under timer_settime() it talks about ticks and resolution
> being the inverse of the tick rate.  AND it does imply that timers on a given
> CLOCK will have that clocks resolution as returned by clock_res().  This is
> fine as far as it goes.  In practical systems we almost always have a much
> higher resolution for the clock_gettime() and gettimeofday() than the tick
> rate.  What the standard does not seem to want to do is to admit that a clock
> may have the ability to be read at a better resolution than its tick rate.

The interesting question is what resolution has CLOCK_REALTIME really?
This paragraph in timer_settime() doesn't mention CLOCK_REALTIME and 
AFAICT historically the resolution of e.g. gettimeofday() was really in 
the msec range.

IMO there is a far more interesting in sentence under clock_getres(): "If 
the time argument of clock_settime() is not a multiple of res, then the 
value is truncated to a multiple of res."
This is relatively obvious for hardware clocks, e.g. we could define a 
CLOCK_JIFFIES with a resolution of TICK_NSEC or CLOCK_PIT with a 
resolution of 838 nsec. The conversion from the actual clock value to/from 
timespec automatically takes care of any truncation/rounding.

CLOCK_REALTIME is now a bit special as it doesn't map directly to a 
hardware clock, it also includes adjustments and these are done in nsec 
resolution (actually even fractions of that in the NTP code). In 2.6 we 
don't truncate the value anywhere and maintain it as a nsec value, 
therefore the resolution of CLOCK_REALTIME should really really 1 nsec 
(and 1 usec under 2.4).

OTOH the precision with which the clock can be read is a different matter 
and depends on the hardware clock CLOCK_REALTIME is derived of. It would 
really help if we could agree on something what clock resolution really 
means (especially for CLOCK_REALTIME). For hardware clocks the resolution 
is defined by the conversion factor from clock cycles to timespec, but 
CLOCK_REALTIME is a virtual clock, so is its resolution the precision with 
which the clock can be read or written? clock_getres() specifically 
mentions clock_settime()...

Depending on this is how we define what timer resolution means. Currently 
we convert the timespec value from/into a jiffies value, so I guess the 
resolution is really TICK_NSEC, as it's the resolution at which we 
maintain the timer value. Thomas's patch now changes this and we keep a 
nsec value, but doesn't that mean the resolution of the timer becomes 1 
nsec? It's basically the same question as above, is the timer resolution 
the precision at which we maintain the values, the precision with which 
the timer can be read or the precision with which the timer can be 
programmed?

The spec is not really clear and Thomas refusal to explain his design 
decision is as also not really helpful. :-(
He sets the timer resolution to (NSEC_PER_SEC/HZ) which matches no value 
above and this way he basically creates another virtual timer, which has 
only little to do with the real kernel timer tick.

I'm open to other interpretations and I think it's important to get to 
some agreement, _before_ we start to change interfaces.

bye, Roman
