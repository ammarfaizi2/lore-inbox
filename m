Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932327AbVHHXHP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932327AbVHHXHP (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 19:07:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932344AbVHHXHP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 19:07:15 -0400
Received: from ylpvm15-ext.prodigy.net ([207.115.57.46]:58060 "EHLO
	ylpvm15.prodigy.net") by vger.kernel.org with ESMTP id S932327AbVHHXHO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 19:07:14 -0400
X-ORBL: [69.107.32.110]
DomainKey-Signature: a=rsa-sha1; s=sbc01; d=pacbell.net; c=nofws; q=dns;
	h=received:date:from:to:subject:cc:mime-version:
	content-type:content-transfer-encoding:message-id;
	b=CkRe8mQyl1oZh5dJxUcL7L+gdGpq4UewvIQw8GJzzqzkaX3dbrWg4g5dyYGd3MeeY
	n9xQkLtalXQxtf3q9MoZQ==
Date: Mon, 08 Aug 2005 16:07:07 -0700
From: david-b@pacbell.net
To: "dmitry pervushin" <dpervushin@ru.mvista.com>
Subject: Re: [PATCH] spi
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050808230707.C5E9DC1661@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well I like this a bit better, but it's still in transition from
the old I2C style stuff over to a newer driver model based one.
(As other folk have noted, with the "bus" v. "adapter" confusion.)

  - Can you make the SPI messages work with an async API?
    It suffices to have a callback and a "void *" for the
    caller's data.  Those callbacks should be able to start
    the next stage of a device protocol request ... e.g. the
    first one issues some command bytes, and its completion
    callback starts the data transfer.  (It's easy to build
    synchronous models over async ones; but not the other way.)

    (I see Mark Underwood commented that he was working with
    one like that.)

  - The basic thing that bothers me is that, like original I2C,
    the roles and responsibilities here don't correspond in any
    consistent way to the driver model.  For new code like SPI,
    there's no excuse for that to happen.

  - It should probably also not assume Linux can only act in
    the "master" role.  SPI controllers are simple, and often
    can implement slave roles just as well.  (This is one of
    several technical details that bother me...)


One thing I've been looking for in your posts about SPI is an
example of how to configure a system using it.  Some examples
come quickly to mind (all Linux-based boards):

  * System 1 has one SPI bus with two chipselects wired.
    CS0 is for a DataFlash chip on the motherboard; while
    CS3 is a MMC/SD/SPI socket (cards can be added/removed)
    that's primarily used for DataFlash cards.

  * System 2 uses SPI to talk to to a multi function chip,
    with sensors for battery, temperature, and touchscreen
    (and others not used) as well as stereo audio over what's
    esentially an I2S channel.  Plus an MMC/SD/SPI socket,
    not yet used in SPI mode (it'd use the MMC controller in
    SPI mode, not yet implemented or required).

  * System 3 uses SPI to talk to an AVR based microcontroller,
    using application-specific protocols to collect sensor
    data and to issue (robotics) commands.  (AVR is an 8-bit
    microcontroller.  In this case its firmware is open, but
    clearly not running under Linux.  In other cases, there's
    no reason both sides can't run Linux.)

Given that those SPI devices can't usefully be probed, and that
things like some CAN drivers will cheerfully bind to a DataFlash
device, how do you see systems like those getting configured?
Lots of board-specific logic in the SPI bus and device drivers?
(I'd hope to avoid that, though it clearly works!)


Anyway, more detailed comments below.  I'm afraid I jumped
right to the end of your post, where you had the highest level
overview I could find:  the <linux/spi.h> header.  Next time
it might be quicker to just review that part.  :)

I recently came across a FAQ entry that read "SPI is actually a
lot simpler than for example I2C".  True; but I don't think it
looks that way yet in this API!

- Dave



(A) One thing that should still change is the division of
responsibility between "device" and "message".


> +struct spi_msg {
> +	unsigned char addr;	/* slave address        */

You mean which chip select to use?  That's clearly a device
attribute, not a message attribute.  And it sort of assumes
that Linux isn't being the SPI slave this time, too ... :)

Devices on SPI don't have addresses; it's just three wires,
clock, shift in, shift out.  Some controllers don't even
support the notion of multiple chipselects ... unless of
course you throw external gates to switch those lines.
Regardless, the device only sees "selected" or not.


> +	unsigned char flags;
> +#define SPI_M_RD	0x01
> +#define SPI_M_WR	0x02	/**< Write mode flag */

OK, that's per-message.  A single bit would suffice though,
unless you aim to say what to do with the bits flowing in
the other direction?  In which case it's problem that you
only provided a single buffer, below!  And NULL for one
buffer or the other would remove the need for that bit.

SPI the techonlogy is not always half duplex; unlike this API,
or all the Linux SPI code I've seen.  :)


> +#define SPI_M_CSREL	0x04	/**< CS release level at end of the frame  */
> +#define SPI_M_CS	0x08	/**< CS active level at begining of frame (default low ) */

And this seems safely per-message too, since device protocols can
involve requests can be built up out of many messages.  Though
they do assume Linux is being the master...


> +#define SPI_M_CPOL	0x10	/**< Clock polarity */
> +#define SPI_M_CPHA	0x20	/**< Clock Phase */

Aren't those statically known, according to what each of the
chips requires?   Mode 0, Mode 3, and so on.  And that'd seem
to be where variants in the SPI family would all show up...  for
example, the PXA 25x processors have one "NSSP" controller to
handle SPI, SSP, PSP, and Microwire protocols.  MCBSP on OMAP is
even more flexible.


> +#define SPI_M_NOADDR	0x80

What's a "NOADDR"?


> +
> +	unsigned short len;	/* msg length           */
> +	unsigned char *buf;	/* pointer to msg data  */

What kind of memory does this use?  I'll guess it's kernel DMA-ready
memory.  In which case it'd be a good idea to let the drivers provide
pre-mapped memory ... include a dma_addr_t and a flag to let the
bus driver know it doesn't need to map/unmap "buf" this time.

> +	unsigned long clock;

The SPI clock rate should be per-device too.  If it's SPI flash that
takes only 3 MHz max, vs one that handles 20 MHz, that won't change
per-request.  Devices could have a "change speed' request if that's
important, though I happen not to have come across any device drivers
that need that.

On the assumption that the SPI stack shouldn't conflict unduly
with the MMC/SD stack -- since all MMC and SD cards can be
accessed as SPI devices!! -- it's worth pointing out that the MMC
driver framework has a separate call to set i/o characteristics
including the clock speed.

And of course, when Linux is the SPI slave, it just takes whatever
clock the master gives it.

> +};
> 


(B) Similarly the division of responsibility between driver and bus
seems pretty wierd.  Example:

> +struct spi_ops {
> +	int (*open) (struct spi_driver *);
> +	int (*command) (struct spi_driver *, int cmd, void *arg);
> +	void (*close) (struct spi_driver *);
> +};

Odd, all other kernel device driver operations take a DEVICE as
the parameter, not the driver.  And they won't generally have open
or close methods; those would be file_operations notions.  SPI as
a hardware protocol doesn't have a session notion, either...


> +
> +#define SPI_ID_ANY "* ANY *"

How's this supposed to work?  What does it mean?

No driver can possibly look at every SPI device and
safely interrogate its capabilities, so the most
obvious meaning wouldn't seem workable... even just
for a master-mode SPI stack.


> +
> +struct spi_driver {
> +	struct spi_ops *ops;
> +	struct module *owner;
> +	struct device_driver driver;
> +	unsigned int minor;
> +	char *(*supported_ids)[];
> +};
> 

OK, that looks a bit odd.  First, the bit about how the driver ops
don't actually say what device they refer to (above) ... and there's
no typesafe way to even pass a device in!!  Second, "module *owner"
is part of the standard "struct device_driver"; not needed.  Third,
"minor".  It'd be a lot more clear if you just showed me a kernel
driver API without also including userspace API sketches.  :)

Also, it's not clear what the namespace of those IDs should be.
I'd have expected "all device names", as with platform_bus.


(C) And again for busses.

> +struct spi_bus
> +{
> +	struct bus_type the_bus;

Erm, there should be one of those for all the different SPI busses
in the system.  There should one global instance "spi_bus_type" at
/sys/bus/spi that is shared by all of them.


> +	struct platform_device platform_device;

Erm, this seems wrong.  It should be a "struct device *" to fit
the normal model -- where hardware-specific code registers the
devices, which would be a platform_device on most SOC chips -- and
there can be a struct "device" or "class_device" for each logical
SPI bus (I'd go for "class_device" only).


> +	struct list_head bus_list;
> +	struct semaphore lock;

Bus_list?  Part of the bus_type.  I think it no longer needs
a widely scoped semaphore either ...

> +	int (*xfer)( struct spi_bus* this, struct spi_device* device,
>		struct spi_msg msgs[], int num, int flags );

I suppose this can work -- it does for i2c -- but I'd still be
happier seeing this take one async request at a time.  That way the
entire set of protocol interactions can be delegated to async
processing provided by the device driver ... rather than expecting
some mid-layer to handle all possible protocols, synchronously.

> +	int (*chip_cs)( int op, void* context );

What's this for?  Surely any chipselects would be handled by the
driver as part of figuring out which device the transfer goes to...
assuming this driver is taking the "master" role on that specific
SPI link!

> +	struct resource *rsrc;

Well, clearly you aren't using platform_device above to take
advantage of the _counted_ resources it provides.  :(


> +};
> +


> +extern int spi_write(struct spi_device *dev, int addr, const char *buf, int len);
> +extern int spi_read(struct spi_device *dev, int addr, char *buf, int len);

Odd because they assume SPI devices don't know their own addresses,
and that they matter even for Linux running as an SPI slave. :)

And because there's no inlined async fast-pathed version that just
calls the bus adapter code directly with an (async) request.


(D) The device struct looks pretty wierd ...

> +struct spi_device {
> +
> +	void* bus_data;
> +	void* drv_data;

Per-bus data will be held in dev->parent->driver_data.
Per-device data will be held in dev->driver_data.

These aren't needed.

> +	struct semaphore lock;

Doesn't dev->sem suffice?

> +	void (*select)( int op, struct spi_device* this );

Isn't it going to be implicitly activated by making a request to it?
Though, I'm not sure what it'd mean to "select" from an SPI slave.

> +	void *(*alloc) (size_t, int);
> +	void (*free) (const void *);

Why?  There's no explanation ... and clearly it's not to provide
DMA-safe memory, since these don't pass DMA addresses.

> +	unsigned long (*copy_from_user) (void *to, const void *from_user,
> +					 unsigned long len);
> +	unsigned long (*copy_to_user) (void *to_user, const void *from,
> +				       unsigned long len);

These don't belong here at all.  If a driver talking to this
device needs to copy to/from userspace, there are several
ways to do that.  One is to call copy_to_user() and friends;
another is to pin the pages and get their DMA addresses, then
unpin them when the transfer finishes.  (I'd expect the former
would be the normal situation!)

> +	struct device dev;
> +};
> +
> +struct spidev_driver_data {
> +	unsigned int minor;
> +	void *private_data;
> +};
> +
> 

Sorry, I doubt that particular driver data is what I'd want to
be storing in my SPI device driver's dev->driver_data!
