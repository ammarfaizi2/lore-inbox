Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932432AbVJSB1O@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932432AbVJSB1O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Oct 2005 21:27:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932433AbVJSB1O
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Oct 2005 21:27:14 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:49325 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S932432AbVJSB1O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Oct 2005 21:27:14 -0400
Date: Wed, 19 Oct 2005 03:26:14 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: George Anzinger <george@mvista.com>
cc: Thomas Gleixner <tglx@linutronix.de>, Andrew Morton <akpm@osdl.org>,
       Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org,
       johnstul@us.ibm.com, paulmck@us.ibm.com, hch@infradead.org,
       oleg@tv-sign.ru, tim.bird@am.sony.com
Subject: Re: [PATCH]  ktimers subsystem 2.6.14-rc2-kt5
In-Reply-To: <435449DC.8070109@mvista.com>
Message-ID: <Pine.LNX.4.61.0510181823560.1386@scrub.home>
References: <1128168344.15115.496.camel@tglx.tec.linutronix.de> 
 <Pine.LNX.4.61.0510100213480.3728@scrub.home>  <1129016558.1728.285.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510130004330.3728@scrub.home> <434DA06C.7050801@mvista.com>
  <Pine.LNX.4.61.0510150143500.1386@scrub.home>  <1129490809.1728.874.camel@tglx.tec.linutronix.de>
  <Pine.LNX.4.61.0510170021050.1386@scrub.home>  <20051017075917.GA4827@elte.hu>
  <Pine.LNX.4.61.0510171054430.1386@scrub.home>  <20051017094153.GA9091@elte.hu>
 <20051017025657.0d2d09cc.akpm@osdl.org>  <Pine.LNX.4.61.0510171511010.1386@scrub.home>
 <1129582512.19559.136.camel@tglx.tec.linutronix.de>
 <Pine.LNX.4.61.0510180032420.1386@scrub.home> <435449DC.8070109@mvista.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 17 Oct 2005, George Anzinger wrote:

> > Where I think it's possible to separate the timer from the interval
> > functionality to get a simpler timer base implementation.
> 
> They are required fields for the POSIX timer.  I think you are saying that
> they should be there and not in the ktime struct, which is part of the POSIX
> timer struct.  Is that right?

Basically, yes. I would take some simpler steps in creating the new timer 
system. Thomas' patch introduces multiple concepts at once, which are hard 
to digest via a simple review. As it looks right now I have to take the 
patch apart myself and split it into simpler patches.

> > > 2. The rounding to the resolution value is explicitly required by the
> > > standard.
> > 
> > 
> > It doesn't explicitly specify which resolution (see the previous mail).
> > It doesn't explicitly specify how this rounding has to be implemented.
> 
> In the timer_settime() call there is only one possible resolution refered to,
> that of the specified clock.  The standard
> says(http://www.opengroup.org/onlinepubs/009695399/functions/timer_settime.html):
> 
> Time values that are between two consecutive non-negative integer multiples of
> the resolution of the specified timer shall be rounded up to the larger
> multiple of the resolution. Quantization error shall not cause the timer to
> expire earlier than the rounded time value.
> 
> This says a) round to the next resolution, and b) don't allow the resulting
> timer to expire early. The implication is that timers are to expire on
> resolution boundries so we need to round such that the expire happens _after_
> the rounded time.
> 
> Am I missing something here?

In short: rounding errors.

Above says IOW if we have a clock with a freqency f and a resolution with
r=10^9/f, we have to round time t up so that it becomes a integer multiple 
i of r, so that once the counter reaches the value i all timer with upto a
time value of i*r are expired.

If we now simply ignore the resolution fraction, we get a rounded value 
which is quickly far away from the real value (with a worst case of r-1 
nsec). This means an explicit rounding is likely only to make things 
worse and any rounding is better done as part of the conversion from/to 
timespec to/from the counter value according to the above rules and even 
this conversion should be avoided as much as possible to minimize rounding 
errors.

> The assumption, that I think you made, that we can let the hardware do the
> rounding runs contrary to one of the main reasons for resolution, i.e. to
> group timers so that we can reduce the system overhead.  Just because we have
> timer hardware with microsecond resolution is not reason enough to offer it to
> the user as handling an interrupt every micro second is way too much overhead,
> and, in most cases, the user doesn't even want to such a fine resolution.

This just means that we have two values to describe a timer, the clock 
resolution describes the precision with which the timer can be programmed 
and the timer precision which describes the maximum frequency of timer 
expiry. I think both values are of interest to user applications, so my 
current preference is to actually export them both properly instead of 
overloading the clock_getres() interface.

The spec allows both resolutions:

"an implementation (is required) to document the resolution supported for 
timers and nanosleep() if they differ from the supported clock resolution"

This means that unfortunately only one can be determined at runtime via 
standard means, so if we are going to create nonportable interfaces, we 
should do it at least properly.

bye, Roman
