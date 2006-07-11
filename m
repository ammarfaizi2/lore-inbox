Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751027AbWGKLEG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751027AbWGKLEG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 11 Jul 2006 07:04:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751029AbWGKLEG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 11 Jul 2006 07:04:06 -0400
Received: from www.osadl.org ([213.239.205.134]:34012 "EHLO mail.tglx.de")
	by vger.kernel.org with ESMTP id S1751027AbWGKLEE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 11 Jul 2006 07:04:04 -0400
Subject: Re: [BUG] APM resume breakage from 2.6.18-rc1 clocksource changes
From: Thomas Gleixner <tglx@linutronix.de>
Reply-To: tglx@linutronix.de
To: Roman Zippel <zippel@linux-m68k.org>
Cc: john stultz <johnstul@us.ibm.com>, Pavel Machek <pavel@ucw.cz>,
       Mikael Pettersson <mikpe@it.uu.se>, linux-kernel@vger.kernel.org,
       Ingo Molnar <mingo@elte.hu>
In-Reply-To: <Pine.LNX.4.64.0607111120310.12900@scrub.home>
References: <200607092352.k69NqZuJ029196@harpo.it.uu.se>
	 <1152554328.5320.6.camel@localhost.localdomain>
	 <20060710180839.GA16503@elf.ucw.cz>
	 <Pine.LNX.4.64.0607110035300.17704@scrub.home>
	 <1152571816.9062.29.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607110054180.12900@scrub.home>
	 <1152605229.32107.88.camel@localhost.localdomain>
	 <Pine.LNX.4.64.0607111120310.12900@scrub.home>
Content-Type: text/plain
Date: Tue, 11 Jul 2006 13:07:05 +0200
Message-Id: <1152616025.32107.151.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.6.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Roman,

On Tue, 2006-07-11 at 11:29 +0200, Roman Zippel wrote:
> > It is not illusionary at all and we have to find a way to handle this.
> > 
> > Forcing time keeping to be bound on some interrupt handling is the wrong
> > design and in the way of tickless systems.
> 
> So what is the correct design?
> Especially for tickless system it's vital for precise timekeeping that the 
> timekeeping code knows what the timer interrupt code does.

Err. Why needs the time keeping code to know what the next timer event
will be ? The time keeping code must not care at all about it. And there
is nothing vital at all.

Time keeping code reads from a given source and does the necessary
adjustments when NTP is active. There is no relation to an interrupt
event at all. At the very end it boils down to a linear equation which
is recalculated at the synchronization points.

The timer interrupt itself is not a synchronization point.

At any synchronization point you store the current time as seen by the
time keeping code for reference and calculate the deviation from the
reference time line. Until the next synchronization point you apply the
recalculated correction to the readout and it does not matter at all
whether there are 0, 10 or 1000 timer interrupts between those points
and whether the delta between those interrupts is constant or not.

> > When there is a system where the time source is bound to an interrupt
> > event then the handling code for that time source has to cope with the
> > problem instead of enforcing this not generally valid scenario on
> > everything. We can of course add helpers into the generic part of the
> > time keeping code to make this easier.
> 
> I'm not sure I'm following, could you please illustrate with an example?

An example is time keeping via a periodic interrupt which does not allow
to readout intermediate values. Thats the only case where you want that
the increment of the internal time is as close as possible to the point
where the event happens. This is a property of this particular time
source not of the general time keeping code. If its necessary to have
some infrastructure for such cases in the generic code, I'm not
opposing. 

I'm just opposing the general tight coupling of the time keeping to
timer interrupts.

Vs. the original problem of resume ordering. It simply has to be
structured in a way that the essential fixups are done _before_ anything
uses the values. If this is not the case then we have to fix this
problem instead of proposing that time keeping has to be coupled to
timer interrupts.

> > The majority of machines has stand alone time sources and there is no
> > need to enforce artificial interrupt relations on them.
> 
> What do you mean with "artificial interrupt relations"?

Binding the time source to an interrupt event. There is no need to do so
at all when you have a continous clock source like TSC, pm_timer, PPC
incrementer, ... 

Why should the time keeping code care when the next interrupt goes off ?

> > Please accept that the "tick" is not the holy grail of Linux. We have
> > already way too much historic tick ballast all over the place, so we
> > really want to avoid that when we design replacement functionality.
> 
> What do you mean with the "holy grail" of "tick"?

Well, I have the feeling - maybe I misunderstand you - that your idea of
time keeping is affixed around the tight coupling of time keeping and
timer interrupt which is the tick in the current implementation.

	tglx


