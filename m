Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261363AbUCARB5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 12:01:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUCARB5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 12:01:57 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:61946 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261363AbUCARBv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 12:01:51 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Michael Frank" <mhf@linuxmail.org>, "Matt Mackall" <mpm@selenic.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Why no interrupt priorities?
Date: Mon, 1 Mar 2004 10:57:42 -0600
X-Mailer: KMail [version 1.2]
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com> <04022714534500.12104@tabby> <opr34laob64evsfm@smtp.pacific.net.th>
In-Reply-To: <opr34laob64evsfm@smtp.pacific.net.th>
MIME-Version: 1.0
Message-Id: <04030110574200.16878@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 29 February 2004 03:43, Michael Frank wrote:
> On Fri, 27 Feb 2004 14:53:45 -0600, Jesse Pollard <jesse@cats-chateau.net> 
wrote:
> > On Friday 27 February 2004 13:19, Michael Frank wrote:
> >> On Fri, 27 Feb 2004 12:55:55 -0600, Matt Mackall <mpm@selenic.com> wrote:
> >> > On Fri, Feb 27, 2004 at 09:44:44AM -0800, Grover, Andrew wrote:
> >> >> > From: Helge Hafting [mailto:helgehaf@aitel.hist.no]
> >> >> >
> >> >> > Grover, Andrew wrote:
> >> >> > > Is the assumption that hardirq handlers are superfast also
> >> >> >
> >> >> > the reason
> >> >> >
> >> >> > > why Linux calls all handlers on a shared interrupt, even if
> >> >> >
> >> >> > the first
> >> >> >
> >> >> > > handler reports it was for its device?
> >> >> >
> >> >> > No, it is the other way around.  hardirq handlers have to be
> >> >> > superfast because linux usually _have to_ call all the handlers of
> >> >> > a shared irq.
> >> >> >
> >> >> > The fact that one device did indeed have an interrupt for us
> >> >> > doesn't mean
> >> >> > that the others didn't.  So all of them have to be checked to be
> >> >> > safe.
> >> >>
> >> >> If a device later in the handler chain is also interrupting, then the
> >> >> interrupt will immediately trigger again. The irq line will remain
> >> >> asserted until nobody is asserting it.
> >> >>
> >> >> If the LAST guy in the chain is the one with the interrupt, then you
> >> >> basically get today's ISR "call each handler" behavior, but it should
> >> >> be possible to in some cases to get less time spent in do_IRQ.
> >> >
> >> > Let's imagine you have n sources simultaneously interrupting on a
> >> > given descriptor. Check the first, it's happening, acknowledge it,
> >> > exit, notice interrupt still asserted, check the first, nope, check
> >> > the second, yep, exit, etc. By the time we've made it to the nth ISR,
> >> > we've banged on the first one n times, the second n-1 times, etc. In
> >> > other words, early chain termination has an O(n^2) worst case.
> >>
> >> With level triggered you can just walk the chain, exit at the end of the
> >> first cycle and  should the IRQ still be asserted you just incur the
> >> overhead of exit and reentry of the ISR.
> >>
> >> Even with edge, I would not check alwasy from the beginning of the
> >> chain...
> >
> > You should... after all that first entry in the chain has the highest
> > priority
>
> Please also consider that physcial IRQ's are in practice assigned "semi
> randomly".

I think that would be up to the installer.

> In a way IRQ priorities in general purpose computing applications are
> irrelevant :)

I would say that they have a priority, just that the priority isn't being
used.

> Lets say you have a bunch of devices demand service, all have to be
> serviced but is either not significant which gets done first or the
> practival IRQ priorities are "less than optimal":
>
> Keyboard	IRQ1		Well buffered
> NIC1		IRQ10		Buffered
> NIC2		IRQ10		Buffered
> USB		IRQ11		Buffered
> serial port	IRQ3		Small FIFO (assuming '550)
> serial port	IRQ4			"-"
>
> Here, serial ports would would be most critical, however the priorities of
> IRQ3 and IRQ4 are below priorities of IRQ10 and IRQ11...

I don't think these are all using "shared IRQ...". I was my understanding that
each IRQ had its own chain. And the priority of the drivers in that chain
is determined by the order.

> IMO, the best practical approach is to keep efficiency by walking the chain
> only once. If the chain is longer, it may be  worthwhile to check the IRQ
> and exit walking the chain if it is inactive.

That depends entirely on the chain. If there is one or more high speed devices
such that walking the chain is faster that responding to an interrupt, then it
is DEFINITELY worth it to walk the chain.

> Priorities in chains would make sense only in specialized applications
> under controlled circumstances wrt IRQ and linking devices into chain at
> the priority desired.

No necessarily specialized applications - just ones that should/must not
loose data due to starvation. Consider the problems caused by relatively
slow devices such as a mouse. Resyncronization is a real problem, which is
one of the reasons to give it a nonshared IRQ. The same could be said of
a PPP connection over a serial line...

If they did share an interrupt, you make the PPP serial line higher priority
than the mouse... Yet you still don't want to loose mouse syncronization - so
check it anyway. Handling it is still faster than an additional interrupt,
and with less overhead.

Granted, this is more important on slower hardware or basic interactive 
service, but it all contributes to overhead. Properly organized (and used)
chains will reduce the overhead.
