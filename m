Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030364AbVIIVkF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030364AbVIIVkF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Sep 2005 17:40:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030367AbVIIVkF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Sep 2005 17:40:05 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:1980 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1030364AbVIIVkB (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Sep 2005 17:40:01 -0400
X-ORBL: [69.107.75.50]
Date: Fri, 09 Sep 2005 14:39:36 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: [RFC][PATCH] SPI subsystem
Cc: dpervushin@ru.mvista.com
References: <20050903101341.23080.qmail@web30307.mail.mud.yahoo.com>
In-Reply-To: <20050903101341.23080.qmail@web30307.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050909213936.6BCD2E9DEF@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is a SPI framework which tries to use the driver
> framework provided by the 2.6 kernel which you can
> play around with on any platform, even on your PC :). 

An idea I've used in the refresh of my simpler patch.
More complete examples (often) help.  :)


> This patch only contains a core layer that handles
> un/registering of SPI adapters SPI devices and SPI
> drivers.

It's got more than that:

  - An "algorithm" layer, an I2C leftover that IMO should be removed.

  - A "workqueue/task per driver" assumption.  This is interesting, because
    it might be easier to port existing drivers into this new framework if
    there were always a "free" task context available.  But on the other
    hand ... not all drivers will need or want a workqueue, and those which
    do can always create their own if keventd isn't good enough.

  - Bits and pieces of some sort of procfs API, which I'm guessing you
    haven't finished removing.

And as for that core:

  - The "spi_cs_table" (entry) is very similar to the "spi_board_info" in
    my patch, but it has some stuff I expect to live in platform_data.
    And it's managed quite differently; it's not something early boot
    code would just hand to the SPI core before it vanishes.

  - You set global policy on what "platform_data" should hold.  That makes it
    not be platform-specific data any more!!  All that info should be moved
    someplace else.  (E.g. in my patch, some of it is held by the SPI core.)

  - It has code to wrap "struct device_driver". I'd rather it work more
    like the platform bus -- no wrapper at all!!  That's simpler, and easier
    to understand.  It eliminates public API functions to manage "struct
    spi_driver", as well as that struct itself; and also a bunch of internal
    code that's more or less just mirroring what the driver model does.
    Fewer parallel concepts means smaller and simpler code all around.

  - There's stuff I don't think should be in the device, like a semaphore
    (in addition to the driver model one!) and an "spi_driver" pointer
    (mirroring driver model dev->driver).

  - And there's code to register and unregister a "spi_device".  I've been
    thinking of that as the responsibility of the "SPI core", and that things
    should work like most other bus frameworks on Linux (other than I2C!!).
    That is, few folk (basically just subsystem maintainers) ever need to muck
    with those particular "innards".  (That's the case in the code I sent.)
    For better or worse, such code has proven quite error prone.

The I/O layer stub is less minimal than what I sent, but it's very similar
in structure, names, and roles.  A few things live in different places. 
I see convergence there!

As for I/O fast paths, I was thinking more about "write word then read word"
stuff than bulk transfers, since so many SPI devices seem to use that sort
of protocol convention (including MicroWire hardware).  And the message
structure that's there now is prety bulk-oriented ... I modeled it on one
from a DataFlash driver, not a sensor driver.



> This framework removes all the platform knowledge from
> the SPI adapter and all SPI knowledge (chip selects,
> which adapter, etc) from the SPI driver. 

It does that in a somewhat different way than mine did, and doesn't
really decouple board descriptions (early boot stuff) from the
driver load sequence (late boot, or even managed by userspace).


> This patch still doesn&#8217;t address a couple of
> platform abstraction problems. 
>  
> 1) How to handle SPI devices that require an interrupt
> line.  This isn&#8217;t a problem on embedded systems as most
> of these will have interrupt pins which are connected
> directly to the interrupt controller,

As noted in comments, I expect IRQs to be passed with the similar sorts
of board-specific platform_data, as one more "int" (likely it's a GPIO
number, though the numbers request_irq takes can be useful too).

I considered passing a "struct resource" with the board description data,
but decided against that ... "int" is smaller, cheaper, more obvious.



>	but what about
> PCI cards which will have one interrupt line to the
> interrupt controller and a interrupt status register.
> In this case the adapter will have to take the
> interrupt and workout if it was for it or for the SPI
> device.

Are you implying the standard interrupt framework would NOT work here?
It already handles shared IRQs, whether for PCI or GPIO or whatever.
(Or are you getting at something else?)


>	One idea as to have function pointers for
> registering, enabling and disabling interrupts in the
> adapter structure. The core layer could fill in the
> normal functions if an adapter driver doesn&#8217;t
> fill them in, that way most adapter drivers
> don&#8217;t have to do any extra work. 

The normal thing is just to pass an IRQ number into the driver (maybe
through platform_data) which then gets passed to request_irq() as usual.

The place that falls down is when that IRQ source hasn't been merged
into the platform IRQ framework ... for example, the IRQ is reported
indirectly, through some I2C based GPIO expander.  Those cases are
not usually mainstream.  So I'm happy to leave them as platform-specific
hacks for a very long time, rather than write code that handles the
normal clean request_irq() path AND something less clean.  ;)


> 2) Extra GPO lines used for reset, etc. 
> These could be treated like extra CS lines which can
> be changed in a spi_msg.

Same as with IRQs: just pass them in with the chip's platform_data.

What's problematic is the fact that all GPIO code is platform specific.
What works on PXA250 won't work on x86 or OMAP, and it may not even work
on PXA270.  We'll still have limits to how portable drivers can be.

- Dave

