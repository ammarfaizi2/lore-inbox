Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263859AbRFLXxh>; Tue, 12 Jun 2001 19:53:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263874AbRFLXx0>; Tue, 12 Jun 2001 19:53:26 -0400
Received: from neon-gw.transmeta.com ([209.10.217.66]:38414 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S263859AbRFLXxI>; Tue, 12 Jun 2001 19:53:08 -0400
Date: Tue, 12 Jun 2001 16:48:31 -0700 (PDT)
From: Patrick Mochel <mochel@transmeta.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Jeff Garzik <jgarzik@mandrakesoft.com>, Jeff Golds <jgolds@resilience.com>,
        linux-kernel@vger.kernel.org
Subject: Re: Problems with arch/i386/kernel/apm.c
In-Reply-To: <E159We4-0000Cc-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.10.10106121639100.13607-100000@nobelium.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 11 Jun 2001, Alan Cox wrote:

> > > needed.  What I am really desiring to know is if there are any devices
> > > that depend on the apm::send_event(APM_NORMAL_RESUME) happening while
> > > interrupts are disabled.
> > 
> > Good spotting...  If any devices depend on what you describe, I would
> > argue that their drivers should handle that not the core apm code...
> 
> The drivers can't handle it at the moment. I've been talking to many people
> about this all hitting this sort of driver problem.
> 
> I think the fix is to keep two classes of power management objects and do
> the following
> 
> 	Call each 'nonirq' suspend function
> 	(aborting if need be)
> 	cli()
> 	Call each irq blocked suspend function
> 	suspend

It shouldn't be necessary to keep two classes of PM objects; instead walk
the device tree twice on suspend.

The first one is an opportunity for the driver to save any device state; a
method to notify the driver that it's going to sleep (as some PPC people
requested); or to do what it needs to with interrupts enabled. 

This also gives the system a graceful way to abort the process should any
of the drivers complain that it absolutely cannot suspend (none of the
devices will actually be powered off at that point).

We then disable interrupts and walk the tree again, actually shutting off
devices. This way, no special cases are made, and no partitioning of the
power management objects is needed.

> resume:
> 	call each irq blocked resume function
> 	sti();
> 	call each nonirq resume

Is this really necessary? We should (note _should_) be able to enable
interrupts, then walk the device tree to resume everything. 

Linus confirmed this assumption, but it may turn out to not be the case.
If that is so, then it will be easy enough to do a two stage walk of the
tree, like in suspend - one to power on the device and reinitialize it,
the next to restore state and continue on once interrupts have been
enabled.


	-pat

