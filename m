Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261682AbUCBP2k (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 2 Mar 2004 10:28:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261673AbUCBP2j
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Mar 2004 10:28:39 -0500
Received: from 34.mufa.noln.chcgil24.dsl.att.net ([12.100.181.34]:24306 "EHLO
	tabby.cats.internal") by vger.kernel.org with ESMTP id S261682AbUCBP0Y
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Mar 2004 10:26:24 -0500
Content-Type: text/plain;
  charset="CP 1252"
From: Jesse Pollard <jesse@cats-chateau.net>
To: "Michael Frank" <mhf@linuxmail.org>, "Matt Mackall" <mpm@selenic.com>,
       "Grover, Andrew" <andrew.grover@intel.com>
Subject: Re: Why no interrupt priorities?
Date: Tue, 2 Mar 2004 09:25:38 -0600
X-Mailer: KMail [version 1.2]
Cc: "Helge Hafting" <helgehaf@aitel.hist.no>, linux-kernel@vger.kernel.org
References: <F760B14C9561B941B89469F59BA3A8470255F02D@orsmsx401.jf.intel.com> <04030110574200.16878@tabby> <opr361tas74evsfm@smtp.pacific.net.th>
In-Reply-To: <opr361tas74evsfm@smtp.pacific.net.th>
MIME-Version: 1.0
Message-Id: <04030209253800.18618@tabby>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 01 March 2004 11:35, Michael Frank wrote:
> On Mon, 1 Mar 2004 10:57:42 -0600, Jesse Pollard <jesse@cats-chateau.net> 
wrote:
> > On Sunday 29 February 2004 03:43, Michael Frank wrote:
> >> On Fri, 27 Feb 2004 14:53:45 -0600, Jesse Pollard
> >> <jesse@cats-chateau.net>
> >
> > wrote:
[snip]
> >> >
> >> > You should... after all that first entry in the chain has the highest
> >> > priority
> >>
> >> Please also consider that physcial IRQ's are in practice assigned "semi
> >> randomly".
> >
> > I think that would be up to the installer.
>
> How?

Usually (at least in my boxes, anyway) the IRQ tends to be associated with the
PCI slot number. suitable ordering of the interfaces in the slots was what I 
was thinking of. But then, I don't overload the IRQs either.

>
> >> In a way IRQ priorities in general purpose computing applications are
> >> irrelevant :)
> >
> > I would say that they have a priority, just that the priority isn't being
> > used.
>
> Not usable in 2 dimensions - A) the IRQ can't be controlled, B) the
> location in the chain can't be contrlolled.

The location in the chain should be controled - even if it is nothing
other than a driver based priority number used to insert in the chain
at the appropriate location.

> >> Lets say you have a bunch of devices demand service, all have to be
> >> serviced but is either not significant which gets done first or the
> >> practival IRQ priorities are "less than optimal":
> >>
> >> Keyboard	IRQ1		Well buffered
> >>
> >> NIC1		IRQ10		Buffered
> >> NIC2		IRQ10		Buffered
> >> USB		IRQ11		Buffered
>
>     MOUSE          IRQ12       ?
>
> >> serial port	IRQ3		Small FIFO (assuming '550)
> >> serial port	IRQ4			"-"
> >>
> >> Here, serial ports would would be most critical, however the priorities
> >> of IRQ3 and IRQ4 are below priorities of IRQ10 and IRQ11...
> >
> > I don't think these are all using "shared IRQ...". I was my understanding
> > that each IRQ had its own chain. And the priority of the drivers in that
> > chain is determined by the order.
>
> The NICs's are both shared on IRQ10.
>
[snip]
> >
> > If they did share an interrupt, you make the PPP serial line higher
> > priority than the mouse... Yet you still don't want to loose mouse
> > syncronization - so check it anyway. Handling it is still faster than an
> > additional interrupt, and with less overhead.
>
> Right, the mouse is important too. A major practical system level issue
> is shown in above example:  The PPP serial line could be easily starved by
> those 2 NIC's+USB+Mouse with higher priority.
>
> Baudrate 115,200 / 11bit is about 10000 chars/s peak. Given a FIFO size
> of 16 + 1 RxHR (best case), after 1ms-1.5ms characters get lost.
>
> A fix would require reprogram PIC IRQ priorities here to make IRQ3 and IRQ4
> higher priority than what comes in from the cascaded controller (via IRQ2).
>
> Obviously more APIC's abound but there still is need for a facility to
> manage priorities, and this (primary priority) is more significant than
> what happens within a chain.

Yes.

>
> > Granted, this is more important on slower hardware or basic interactive
> > service, but it all contributes to overhead. Properly organized (and
> > used) chains will reduce the overhead.
>
> More control over physical IRQ priority would be an initial step helping
> with non-shared legacy hardware and device with small buffers.
>
> More modern hardware like USB is using large buffers, DMA and is less
> critical.
>
> And perhaps a config-bit per chain to tell it whether to rescan from
> scratch would be useful to address the concerns mentioned, _and_ then there
> should be a facility to link a interrupt into a specific location in a
> chain.

A round-robin IRQ scheduler would also help those at the same priority. Again,
software implementation sucks (I used to do embeded systems).

It really looks like the old arch is being pushed way beyond what is 
reasonable. It is really time for vectored interrupts to resurface (re: the 
old PDP 11 style, allowing each interrupt to have it's own software priority,
AND interrupt routine... which also happens to be where "spl" started from :-)

It really looks like the PCI can't handle more than about 3 interrupt sources
at a time, in spite of the APIC/cascade faking it to look like more.

The busyist box I have (a server) has two SCSI controllers and two IDE (one 
IRQ each, and the IDE is used only for primary boot, and backup), and an 
ethernet. The PS2 mouse and keyboard don't get used (much). The second 
busyist has three ethernet connections (1 from DSL, 1 from wireless, 1 from
the internal net - it is a firewall) and an IDE boot. Again, the
keyboard/mouse are not used.
