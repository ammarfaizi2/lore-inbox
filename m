Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964850AbVI0HjT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964850AbVI0HjT (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Sep 2005 03:39:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964851AbVI0HjT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Sep 2005 03:39:19 -0400
Received: from [85.21.88.2] ([85.21.88.2]:26248 "HELO mail.dev.rtsoft.ru")
	by vger.kernel.org with SMTP id S964850AbVI0HjT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Sep 2005 03:39:19 -0400
Subject: Re: [spi-devel-general] Re: SPI
From: dmitry pervushin <dpervushin@gmail.com>
To: Grant Likely <glikely@gmail.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <528646bc05092609202192332@mail.gmail.com>
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
	 <528646bc05092609202192332@mail.gmail.com>
Content-Type: text/plain
Date: Tue, 27 Sep 2005 11:39:12 +0400
Message-Id: <1127806752.7577.29.camel@diimka.dev.rtsoft.ru>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.1-1mdk 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-09-26 at 10:20 -0600, Grant Likely wrote:
> Would "SPI slave" or "SPI slave device" be better terminology than
> "SPI device"?  That way the terminology matches how SPI hardware docs
> are usually written.  (not a big deal, just thought I'd ask)
The term "SPI slave device" looks correct.. I am correcting the doc :)
> > +       err = spi_bus_populate( the_spi_bus,
> > +                       "Dev1 0 1 2\0" "Dev2 2 1 0\0",
> > +                       extract_name )
> In my mind, this is not ideal.  For example, the MPC5200 has 4 PSC
> ports which can be in SPI mode.  The SPI bus driver should/will not
> know what devices are attached to it.  It should be the responsibility
> of the board setup code to populate the bus.... on the other hand,
> perhaps the bus driver should look to it's platform_device structure
> to find a table of attached devices.  Generic platform_device parsing
> code could be used by all SPI bus drivers.
The spi_bus_populate is not the only way to populate the bus; the bus
driver can discover SPI devices on his own and directly call
spi_device_add, isn't it ?
> > +In this example, function like extract_name would put the '\0' on the
> > +1st space of device's name, so names will become just "Dev1", "Dev2",
> > +and the rest of string will become parameters of device.
> I don't think it's wise to use '\0' as a delimiter.  Sure it makes
> parsing really simple when the string passed in is formed correctly,
> but if someone misses the last '\0' you have no way to know where the
> string ends.  It also makes it difficult support passing a device
> string from the kernel command line.
You're right. Using spi_populate_bus is the simplest way, that may lead
to errors... From the other hand, if we used another char to delimit
device name and its parameters, there would be person who would want
this character in device name... I think that we can add another
approach to populate the bus ? 
> 
> > +4. SPI functions are structures reference
> > +-----------------------------------------
> > +This section describes structures and functions that listed
> > +in include/linux/spi.h
> I would like to see this function and structure reference in the spi.h
> file itself rather than here.  Better chance of it being kept up to
> date that way.
Yes; but I personally prefer to look to the only place instead of
spi.h/spi-core.c. I'll try to keep the things consistent :)

> > +This structure represents the message that SPI device driver sends to the
> > +SPI bus driver to handle.
> Is there any way for the SPI device to constrain the clock rate for a
> transfer?  For example, if the devices maximum speed is lower than the
> bus maximum speed.
Thank you for this comment; the `clock' field is initially intended to
do this. Device driver might set the field to maximum speed, and bus
driver would analyze the field in its xfer function and send the message
on lower speed. Moreover, there is the `set_clock' callback in
spi_bus_driver. If msg specifies its own clock value, the bus driver's
set_clock will be called just before transferring the message.
> Overall, I like.  It looks like it does what I need it to.  If I get a
> chance this week I'll port my SPI drivers to it and try it out on my
> MPC5200 board.
Thank you! If your drivers are going to open source, could you also sent
them to spi mailing list, to prepare the consolidated patch ? I hope if
there is no significant troubles, the current core will go to the
mainstream kernel :)


