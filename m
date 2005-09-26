Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751659AbVIZQUo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751659AbVIZQUo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Sep 2005 12:20:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751661AbVIZQUo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Sep 2005 12:20:44 -0400
Received: from qproxy.gmail.com ([72.14.204.204]:17459 "EHLO qproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1751658AbVIZQUn convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Sep 2005 12:20:43 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=DpY7v7mgqYU5Eh71LDV1nt1jSBXht34e5MIM1dIbU0jJqwmR6vKoTjNopH44o/rOEV46/SX7rJa1ck7n4pQcwD8FRjmBqRw03xwgNLWb6IuTJeg/kGJNddxetEHnl1/W5dv/9RULnN+X7Ih111n4FxFIVTCxm4wNpW/PHAzYn/0=
Message-ID: <528646bc05092609202192332@mail.gmail.com>
Date: Mon, 26 Sep 2005 10:20:42 -0600
From: Grant Likely <glikely@gmail.com>
Reply-To: Grant Likely <glikely@gmail.com>
To: dmitry pervushin <dpervushin@gmail.com>
Subject: Re: SPI
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       spi-devel-general@lists.sourceforge.net
In-Reply-To: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <1127733134.7577.0.camel@diimka.dev.rtsoft.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

resend; sorry.  Forgot to cc: the list.

On 9/26/05, dmitry pervushin <dpervushin@gmail.com> wrote:
> Hello guys,
>
> I am attaching the next incarnation of SPI core; feel free to comment it.

===================================================================
> --- /dev/null
> +++ linux-2.6.10/Documentation/spi.txt
> @@ -0,0 +1,351 @@
> +Documentation/spi.txt

> +3.1 The SPI outline
> +
> +The SPI infrastructure deals with several levels of abstraction. They are
> +"SPI bus", "SPI bus driver", "SPI device" and "SPI device driver". The
Would "SPI slave" or "SPI slave device" be better terminology than
"SPI device"?  That way the terminology matches how SPI hardware docs
are usually written.  (not a big deal, just thought I'd ask)

> +"SPI bus" is hardware device, which usually called "SPI adapter", and has
> +"SPI devices" connected. From the Linux' point of view, the "SPI bus" is
> +structure of type platform_device, and "SPI device" is structure of type
> +spi_device. The "SPI bus driver" is the driver which controls the whole
> +SPI bus (and, particularly, creates and destroys "SPI devices" on the bus),
> +and "SPI device driver" is driver that controls the only device on the SPI
> +bus, controlled by "SPI bus driver". "SPI device driver" can indirectly
> +call "SPI bus driver" to send/receive messages using API provided by SPI
> +core, and provide its own interface to the kernel and/or userland.
> +So, the device stack looks as follows:
> +
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
Helpful diagram.  :)

> +
> +3.2 How do the SPI devices gets discovered and probed ?
> +
> +In general, the SPI bus driver cannot effective discover devices
> +on its bus. Fortunately, the devices on SPI bus usually implemented
> +onboard, so the following method has been chosen: the SPI bus driver
> +calls the function named spi_bus_populate and passed the `topology
> +string' to it. The function will parse the string and call the callback
> +for each device, just before registering it. This allows bus driver
> +to determine parameters like CS# for each device, retrieve them from
> +string and store somewhere like spi_device->platform_data. An example:
> +       err = spi_bus_populate( the_spi_bus,
> +                       "Dev1 0 1 2\0" "Dev2 2 1 0\0",
> +                       extract_name )
In my mind, this is not ideal.  For example, the MPC5200 has 4 PSC
ports which can be in SPI mode.  The SPI bus driver should/will not
know what devices are attached to it.  It should be the responsibility
of the board setup code to populate the bus.... on the other hand,
perhaps the bus driver should look to it's platform_device structure
to find a table of attached devices.  Generic platform_device parsing
code could be used by all SPI bus drivers.

Along the same lines, an SPI bus driver may not know the board
specific way SS lines are driven.  If GPIO is used as SS lines then
each SPI bus will need a different SS routine.  However, it looks like
this is not an issue for your infrastructure.  The individual SPI bus
driver can be handed a SS callback by the board setup code for each
SPI bus.

> +In this example, function like extract_name would put the '\0' on the
> +1st space of device's name, so names will become just "Dev1", "Dev2",
> +and the rest of string will become parameters of device.
I don't think it's wise to use '\0' as a delimiter.  Sure it makes
parsing really simple when the string passed in is formed correctly,
but if someone misses the last '\0' you have no way to know where the
string ends.  It also makes it difficult support passing a device
string from the kernel command line.

> +4. SPI functions are structures reference
> +-----------------------------------------
> +This section describes structures and functions that listed
> +in include/linux/spi.h
I would like to see this function and structure reference in the spi.h
file itself rather than here.  Better chance of it being kept up to
date that way.

> +
> +i. struct spi_msg
> +~~~~~~~~~~~~~~~~~
> +
> +struct spi_msg {
> +        unsigned char flags;
> +        unsigned short len;
> +        unsigned long clock;
> +        struct spi_device* device;
> +        void          *context;
> +        struct list_head link;
> +        void (*status)( struct spi_msg* msg, int code );
> +        void *devbuf_rd, *devbuf_wr;
> +        u8 *databuf_rd, *databuf_wr;
> +};
> +This structure represents the message that SPI device driver sends to the
> +SPI bus driver to handle.
Is there any way for the SPI device to constrain the clock rate for a
transfer?  For example, if the devices maximum speed is lower than the
bus maximum speed.

I looked over the code and I didn't notice anything obviously
incorrect.  I greatly appreciate the large block of documentation.

Overall, I like.  It looks like it does what I need it to.  If I get a
chance this week I'll port my SPI drivers to it and try it out on my
MPC5200 board.

Thanks!
g.
