Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750831AbVJCE5E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750831AbVJCE5E (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 00:57:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750834AbVJCE5E
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 00:57:04 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:45472 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP
	id S1750831AbVJCE5C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 00:57:02 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=ayNJEUT4GOWz7dSpQalVX9tZwVpDGxTy64g5dv5htRcQbOYrMCYl9b0yYUKD+Glkr
	IBBhig4ZE/6HYHabakktA==
Date: Sun, 02 Oct 2005 21:56:58 -0700
From: David Brownell <david-b@pacbell.net>
To: dmitry pervushin <dpervushin@gmail.com>
Subject: Re: [PATCH] SPI
Cc: linux-kernel@vger.kernel.org, dpervushin@ru.mvista.com
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20051003045658.3D592EA568@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

> > around the I/O model of a queue of async messages; and even 
> > names for some data structures.
> 
> It seems we are talking about similar things, aren't we ?

Sometimes, yes.  :)


> > 	<linux/spi/spi.h>	... main header
> > 	<linux/spi/CHIP.h>	... platform_data, for CHIP.c driver
> > 
> > Not all chips would need them, but it might be nice to have 
> > some place other than <linux/CHIP.h> for such things.  The 
> > platform_data would have various important data that can't be 
> > ... chip variants, initialization data, and similar stuff 
> > that differs between boards is knowable only by 
> > board-specific init code, yet is needed by board-agnostic driver code.
> 
> I would prefer not to have subdirectory spi in include/linux. Take a look to
> pci, for example. I guess that chip data are spi-bus specific, and should
> not be exported to world.

You misunderstand.  Consider something like a touchscreen driver, where
different boards may use the same controller (accessed using SPI) but
with different touchscreens and wiring.

That driver may need to know about those differences, much like it needs
to know about using a different IRQ number or clock rate.  Details like
"X plate resistance is 430 ohms" are not bus-specific, neither are
details like rise time (if any) for the reference voltage which affect
timings for some requests.  (Real world examples!)

Those are the sort of thing that board-specific.c files publish.
They have to be exported from arch/.../mach-.../board-specific.c into
somewhere in drivers/.../*.c; that's not really different from "exported
to world".


> > that way internally.  But other drivers shouldn't be forced 
> > to allocate kernel threads when they don't need them.
> 
> Really :) ? I'd like to have the worker thread for bus (and all devices on
> the bus) instead of several workqueues (one per each device on bus, right ?)

That is: you want to force each SPI Master Controller driver to allocate
a kernel thread (one per workqueue).  And I'm saying I'd rather not; the
API would be much more flexible without imposing that particular style.


> > Hmm, this seems to be missing a few important things ... from 
> > the last SPI patch I posted to this list (see the URL right above):
> > 
> > 	struct bus_type spi_bus_type = {
> > 		.name           = "spi",
> > 		.dev_attrs      = spi_dev_attrs,
> > 		.match          = spi_match_device,
> > 		.hotplug        = spi_hotplug,
> > 		.suspend        = spi_suspend,
> > 		.resume         = spi_resume,
> > 	};
> > 
> > That supports new-school "modprobe $MODALIAS" hotplugging and 
> > .../modalias style coldplugging, as well as passing PM calls 
> > down to the drivers.  (Those last recently got some tweaking, 
> > to work better through sysfs.)  And the core is STILL only 
> > about 2 KB on ARM; significantly less than yours.
> 
> Are you counting bytes on your sources ? Or bytes in object files ? As for
> spi_bus_type, I agree. Hotplu/suspend/resume have to be included.

Object code in the ".text" segment of whatever "core" code everyone
would need to keep in-memory.  The other numbers don't much matter.

You should be able to snarf the next version of suspend/resume code
pretty directly.

The hotplug stuff will require your init model to accumulate enough
description about each SPI device to identify the driver that should
be bound to it.  The last patch you posted didn't seem to have any
support for such things.



> > You don't seem to have any ability to record essential 
> > board-specific information that the drivers will need.  I 
> > hope you're not planning on making that stuff clutter up the 
> > driver files??  board-specific.c files seem the better model, 
> > with a way to pass that data to the drivers that need it 
> > (using the driver model).
> > 
> > ...
> 
> This is responsibility of bus driver. The driver for device on the SPI bus
> might request the hardware info from the bus driver, which is referenced via
> spi_device->device->parent.

Sounds like you're just shifting clutter from one driver to another.
I'd rather see it in _neither_ driver.  :)

What you're talking about would normally be spi_device->dev.platform_data;
I hope we can agree on that much.  Getting it there is a separate issue.
It's something I see as a basic role of the "SPI core", using information
from a board-specific.c file.


> > Why are you hard-wiring such an unfair scheduling policy ... 
> > and preventing use of better ones?  I'd use FIFO rather than 
> > something as unfair as that; and FIFO is much simpler to code, too.
> 
> OK, the policy is hardcoded and seems to be not the only available. This can
> be solved by adding a function to pull out the message that is "next by
> current". Does this sound reasonable ? 

My preference is different:  all queue management policies should be 
the responsibility of that controller driver.  You're assuming that
it's the core's responsibility (it would call that function).

   http://marc.theaimsgroup.com/?l=linux-kernel&m=112684135722116&w=2


> > I don't really understand why you'd want to make this so 
> > expensive though.  Why not just do the IO directly into the 
> > buffer provided for that purpose?  One controller might 
> > require dma bounce buffers; but don't penalize all others by 
> > imposing those same costs.
> 
> Drivers might want to allocate theyr own buffers, for example, using
> dma_alloc_coherent. Such drivers also need to store the dma handle
> somewhere. Drivers might use pre-allocated buffers. 

The simple solution is to just have the driver provide both CPU and DMA
pointers for each buffer ... which implies using the spi_message level
API, not the CPU-pointer-only single buffer spi_read()/spi_write() calls
I was referring to.

A PIO controller driver would use the CPU pointer; a DMA one would use
the dma_addr_t.  The DMA pointers may have come from DMA mapping calls,
or from dma_alloc_coherent().  Each of those cases can be implemented
without that needless memcpy().  Only drivers on hardware that really
needs bounce buffers should pay those costs.


> > > +		msg->devbuf_rd = drv->alloc ?
> > > +		    drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
> > > +		msg->databuf_rd = drv->get_buffer ?
> > > +		    drv->get_buffer(device, msg->devbuf_rd) : msg->devbuf_rd;
> > 
> > Oy.  More dynamic allocation.  (Repeated for write buffers 
> > too ...) See above; don't force such costs on all drivers, 
> > few will ever need it.
> 
> That's not necessarily allocation. That depends on driver that uses
> spimsg_alloc, and possibly provides callback for allocating
> buffers/accessing them

Still, it's dynamic ... and it's quite indirect, since it's too early.
Simpler to have the driver stuff the right pointers into that "msg" in
its next steps. The driver has lots of relevant task context (say, in
stack frames) that's hidden from those alloc() or get_buffer() calls.

Plus it's still allocating something that's _always_ used as a bounce
buffer, even for drivers that doesn't need it.  Maybe they're PIO, or
maybe normal DMA mappings work ... no matter, most hardware doesn't
need bounce buffers.

- Dave


