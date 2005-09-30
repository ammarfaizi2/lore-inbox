Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932471AbVI3R7n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932471AbVI3R7n (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Sep 2005 13:59:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVI3R7n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Sep 2005 13:59:43 -0400
Received: from pimout5-ext.prodigy.net ([207.115.63.73]:29585 "EHLO
	pimout5-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S932471AbVI3R7m (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Sep 2005 13:59:42 -0400
X-ORBL: [69.107.75.50]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=qYP7y+WeKsJkP7/WABDIRPTRxHguCBRdWNuQCr5ZoLUY9/tRiEmYdq+sH/iUEJskn
	wbww3np19OJ9SoyNZj53g==
Date: Fri, 30 Sep 2005 10:59:23 -0700
From: David Brownell <david-b@pacbell.net>
To: dpervushin@gmail.com
Subject: Re: [PATCH] SPI
Cc: dpervushin@ru.mvista.com, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050930175923.F3C89E9E25@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Here is the revised SPI-core patch.

Also, in a few days I'll post an update to the first of these patches,
with a smaller SPI core you've seen before:

  http://marc.theaimsgroup.com/?l=linux-kernel&m=112631114922427&w=2
  http://marc.theaimsgroup.com/?l=linux-kernel&m=112631175219099&w=2

Among the folk who've recently posted SPI "framework" patches (you, Mark
Underwood, me), there seems to be some convergence around the I/O model
of a queue of async messages; and even names for some data structures.

That's a useful start ... 


>  drivers/spi/Kconfig    |   33 +++
>  drivers/spi/Makefile   |   14 +
>  include/linux/spi.h    |  232 ++++++++++++++++++++++

Looks familiar.  :)  But another notion for the headers would be

	<linux/spi/spi.h>	... main header
	<linux/spi/CHIP.h>	... platform_data, for CHIP.c driver

Not all chips would need them, but it might be nice to have some place
other than <linux/CHIP.h> for such things.  The platform_data would have
various important data that can't be ... chip variants, initialization
data, and similar stuff that differs between boards is knowable only by
board-specific init code, yet is needed by board-agnostic driver code.

Comments?


> +static int spi_thread(void *context);

You're imposing the same implementation strategy Mark Underwood was.
I believe I persuaded him not to want that, pointing out three other
implementation strategies that can be just as reasonable:

   http://marc.theaimsgroup.com/?l=linux-kernel&m=112684135722116&w=2

It'd be fine if for example your PNX controller driver worked that way
internally.  But other drivers shouldn't be forced to allocate kernel
threads when they don't need them.


> +static int spi_bus_match_name(struct device *dev, struct device_driver *drv)
> +{
> +	return !strcmp(drv->name, SPI_DEV_CHAR) ||
> +	    !strcmp(TO_SPI_DEV(dev)->name, drv->name);
> +}

I don't like seeing special cases like that.  Is there some problem
using the sysfs "bind this driver to that device" mechanism?

Having a wildcard "I'll bind to anything" driver mode would be nice,
so long as any driver was able to use it.


> +struct bus_type spi_bus = {
> +	.name = "spi",
> +	.match = spi_bus_match_name,
> +};

Hmm, this seems to be missing a few important things ... from the last
SPI patch I posted to this list (see the URL right above):

	struct bus_type spi_bus_type = {
		.name           = "spi",
		.dev_attrs      = spi_dev_attrs,
		.match          = spi_match_device,
		.hotplug        = spi_hotplug,
		.suspend        = spi_suspend,
		.resume         = spi_resume,
	};

That supports new-school "modprobe $MODALIAS" hotplugging and .../modalias
style coldplugging, as well as passing PM calls down to the drivers.  (Those
last recently got some tweaking, to work better through sysfs.)  And the
core is STILL only about 2 KB on ARM; significantly less than yours.


> +struct spi_device* spi_device_add(struct device *parent, char *name)

You don't seem to have any ability to record essential board-specific
information that the drivers will need.  I hope you're not planning on
making that stuff clutter up the driver files??  board-specific.c files
seem the better model, with a way to pass that data to the drivers
that need it (using the driver model).

That minimally includes stuff like the IRQ used by that chip, the clock
rate it supports on this board, and the SPI clocking mode (0, 1, 2, 3)
used to get data in and out of the chip.  But there seem to be a few
other things needed too, given the ways SPI chips tweak the protocol.


> +				/*
> +				 * all messages for current selected_device
> +				 * are processed.
> +				 * let's switch to another device
> +				 */

Why are you hard-wiring such an unfair scheduling policy ... and
preventing use of better ones?  I'd use FIFO rather than something
as unfair as that; and FIFO is much simpler to code, too.


> +/*
> + * spi_write
> + * 	receive data from a device on an SPI bus
> + * Parameters:
> + * 	spi_device* dev		the target device
> + *	char* buf		buffer to be sent
> + *	int len			number of bytes to receive
> + * Return:
> + * 	 the number of bytes transferred, or negative error code.
> + */
> +int spi_read(struct spi_device *dev, char *buf, int len)

There's a cut'n'paste error here.  Also, you should be using
standard kerneldoc instead of this stuff.


> +{
> +	int ret;
> +	struct spimsg *msg = spimsg_alloc(dev, SPI_M_RD, len, NULL);
> +
> +	ret = spi_transfer(msg, NULL);
> +	memcpy(buf, spimsg_buffer_rd(msg), len);

I don't really understand why you'd want to make this so expensive
though.  Why not just do the IO directly into the buffer provided
for that purpose?  One controller might require dma bounce buffers;
but don't penalize all others by imposing those same costs.

Also, spimsg_alloc() is huge ... even if you expect the inliner will
remove some of it.  It's doing several dynamic allocations.  I honestly
don't understand why there's a need for even _one_ dynamic allocation
in this "core" code path (much less the memcpy).


> +/*
> + * spi_bus_populate and spi_bus_populate2
> + *
> + * These two functions intended to populate the SPI bus corresponding to
> + * device passed as 1st parameter. The difference is in the way to describe
> + * new SPI slave devices: the spi_bus_populate takes the ASCII string delimited
> + * by '\0', where each section matches one SPI device name _and_ its parameters,
> + * and the spi_bus_populate2 takes the array of structures spi_device_desc.

The place I can see wanting ASCII strings to help is on the kernel command
line, but those strings aren't formatted in a way __setup() could handle.
(Embedded nulls, for starters.)

Also, you don't have any "board specific init" component in this code...


> --- /dev/null
> +++ linux-2.6.10/drivers/spi/spi-dev.c
> @@ -0,0 +1,219 @@
> +/*
> +    spi-dev.c - spi driver, char device interface
> +

Do you have userspace drivers that work with this?  I can see how to use
it with read-only sensors (each read generates a 12bit sample, etc) and
certain write-only devices, I guess.

But it doesn't look like this character device can handle RPC-ish things
like "give me an ADC conversion for line 3" (which commonly maps to a
"write 8 bits, then start reading 12 data bits one half clock after
the last bit is written" ... hard to make that work with separate
read and write transactions, given the half clock rule).

Also, you might have a look at the at91_spidev.c code [1]; it's much
lower overhead for bulk read/write, and uses dma right to the usespace
pages in its spi_read() analogue.  Those kernels also support DataFlash
for the root file system ... that is, the SPI stack is worth looking at
since it's more functional than the one you're proposing.  (For all
that it's pretty much kernel 2.4 code ported to 2.6, and doesn't use
the driver model yet.)


> +  +--------------+                    +---------+
> +  | platform_bus |                    | spi_bus |
> +  +--------------+                    +---------+
> +       |..|                                |
> +       |..|--------+               +---------------+
> +     +------------+| is parent to  |  SPI devices  |
> +     | SPI busses |+-------------> |               |
> +     +------------+                +---------------+
> +           |                               |
> +     +----------------+          +----------------------+
> +     | SPI bus driver |          |    SPI device driver |
> +     +----------------+          +----------------------+

That seems wierd even if I assume "platform_bus" is just an example.
For example there are two rather different "spi bus" notions there,
and it looks like neither one is the physical parent of any SPI device ...


> +3.2 How do the SPI devices gets discovered and probed ?

Better IMO to have tables that get consulted when the SPI master controller
drivers register the parent ... tables that are initialized by the board
specific __init section code, early on.  (Or maybe by __setup commandline
parameters.)

Doing it the way you are prevents you from declaring all the SPI devices in
a single out-of-the-way location like the arch/.../board-specific.c file,
which is normally responsible for declaring devices that are hard-wired on
a given board and can't be probed.


> +	http://spi-devel.sourceforge.net

That seems like potentially a good place for SPI work to cook for a while,
especially if you start merging updates from other folk.


> +       void (*status) (struct spi_msg * msg, int code);

These per-message "status" callbacks are really wierd ... why so complex?

Drivers are inflicted with several different calls per message, and will
need to filter out all except the two different kinds that indicate errors.
None of those calls uses the standard Linux convention for status codes:
zero == success, negative numbers == errno values.

And the callback is even for some reason optional ... just bite the bullet
and insist that a (streamlined) call always be made.  You only need one way
to report transfer completion, it only needs to work asynchronously.


> +static inline struct spi_msg *spimsg_alloc(struct spi_device *device,
> +					   unsigned flags,
> +					   unsigned short len,
> +					   void (*status) (struct spi_msg *,
> +							   int code))
> +{
> +	... 30+ lines including...
> +
> +	msg = kmalloc(sizeof(struct spi_msg), GFP_KERNEL);
> +	memset(msg, 0, sizeof(struct spi_msg));

If these things aren't going to be refcounted, then it'd be easier
to just let them be stack-allocated; they ARE that small.  And if
they've _got_ to be on the heap, then there's a new "kzalloc()" call
you should be looking at ...


> +		msg->devbuf_rd = drv->alloc ?
> +		    drv->alloc(len, GFP_KERNEL) : kmalloc(len, GFP_KERNEL);
> +		msg->databuf_rd = drv->get_buffer ?
> +		    drv->get_buffer(device, msg->devbuf_rd) : msg->devbuf_rd;

Oy.  More dynamic allocation.  (Repeated for write buffers too ...)
See above; don't force such costs on all drivers, few will ever need it.

> +}

That seems like spimsg_alloc is much too long a function to inline.  And
it's easy to imagine cases where the costs of all those allocations will
exceed the cost of actually doing the I/O ...


> +#define SPI_MAJOR	153
> +
> +...
> +
> +#define SPI_DEV_CHAR "spi-char"

Those things are specific to that particular userspace driver support;
they don't belong in APIs that are visible to non-userspace drivers.

- Dave


[1] http://maxim.org.za/AT91RM9200/2.6/
