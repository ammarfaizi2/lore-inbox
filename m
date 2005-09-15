Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030323AbVIOBUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030323AbVIOBUv (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 21:20:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030324AbVIOBUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 21:20:51 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:31451 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1030323AbVIOBUt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 21:20:49 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:references:in-reply-to:
	mime-version:content-type:content-transfer-encoding:message-id;
	b=AIrOK77/zz4qID64dD81pz7XDGxzTs+cuKEis0IPqe9tbDWcOFAHFR9KlT5MFNtv7
	d6ZSlOzEC+w1l2ic7Hesg==
Date: Wed, 14 Sep 2005 18:20:43 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: SPI redux ... driver model support
Cc: dpervushin@ru.mvista.com
References: <20050911090244.52084.qmail@web30305.mail.mud.yahoo.com>
In-Reply-To: <20050911090244.52084.qmail@web30305.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050915012043.183ACEA56E@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> OK. Perhaps it's time to lay out the arguments so far
> and see where we go from there :).

I'd rather see a bit more feedback from other folk about what they
need and want.  For one example, Dmitry (dpervushin@ru.mvista.com)
posted some SPI code a while back, but we've not heard from him...

Then there are other developers who need or want SPI APIs that are
less chip-specific than linux/arch/arm/mach-pxa/ssp.c (or even
linux/drivers/char/at91_spi.c, interesting since it uses DMA and
handles root-on-DataFlash) and can support development of reusable
drivers for SPI slave devices (Flash, sensors, etc) that aren't
hardwired to a given SOC or board.


> I want to pass a cs table in as platform data because
> it means you don't have to know what bus number the
> adapter is (which you can't easily tell for
> hotplugable devices)

But as you observed earlier, SPI doesn't need to handle
hotplug ... just different common arrangements of boards.

However:  Linux uses bus numbers lots of places, even when
the bus can be hotplugged.  So that argument's not a win.


>	and for most cases I think the
> SPI devices will be hardwire to the adapter. This
> approach of defining a structure to be used in
> platform_data seems to be used by some serial drivers
> so I think it's OK, but your not so sure.
> How else could I do it?

Reread my patches; they ought to even run on x86, though of course
"Real Hardware" is typically embedded.  (The folk who've contacted me
run Linux on SOC boards based on ARM, MIPS, and PPC CPUs.)

The basic model is widely used:  give the operating system tables that
describe the devices that can't be probed.


> You want to pass in SPI devices in a table that gets
> registered with the subsystem and when the adapter
> that they sit on gets registered (known by the bus
> number) all the devices in that table get registered
> in the core.

Actually there can be several such tables; initialization for each board
in the system might declare a few entries.  Those tables are sufficient
to describe the system setup.

That's a difference I'll highlight again:  the tables you're talking about
MUST be grouped by adapter.  Which means that when the hardware groups
them differently ("by board") your API needs to add another solution.
Why have two, when (as in my patch) just one could suffice?


>	I like this solution for registering
> hotplug'ish devices :), although I would prefer to use
> the bus_id then a bus number.

Numbers are just one kind of ID, so I don't see what you're trying to
say here.  The kernel uses numbers to identify other bootable devices;
why would you object to using them here?


>	This solution doesn't
> work very well for hotplug adapters as you don't know
> what bus number they will be given (you would have to
> do some undefined sysfs magic). 

Anyone trying to develop "SPI hotplug" is going to have a wide variety
of problems to solve!  There's not even a standard for SPI connectors,
much less cable quality standards or dynamic device identification.
I refuse to consider such a long list of "maybes" in a design.

The scenario you mentioned was development platforms (contrast to
production hardware...) with 8 bit microcontrollers and SPI, connected
over USB.  I can think of several ways to implement such devices using
the approach I posted.


> So how would you feel about the core supporting both
> cs tables as platform data and SPI device tables?

I'm not a fan of duplication of function, or code managing platform_data
that's not platform-specific code.  (After all, that's why it's called
"platform" data.)


> > > I get a .ko object of 5.1K
> > 
> > ... but the ".text" size is MUCH less [1K]; and what I
> > sent was not built as a ".so", so there's other oddness
> > too.
>
> Sorry, I must be missing something here but isn't a
> ".so" a shared library not a kernel module? Or where
> you only building it as a ".so" to find the text size?

Typo; they're both just dynamic linking.  My point was that if you built
that core (vs a driver) to get a ".ko", you've played some strange games
already -- and broke at least one thing.

Not that size is the top concern, but on the other hand the folk using
SPI do care about it more than the folk who find bugs like "hardware
DMA fails on memory addresses over 2GB".  :)

- Dave


