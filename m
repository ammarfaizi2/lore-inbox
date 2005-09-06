Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751224AbVIFCJ2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbVIFCJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 22:09:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751254AbVIFCJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 22:09:28 -0400
Received: from ylpvm12-ext.prodigy.net ([207.115.57.43]:27539 "EHLO
	ylpvm12.prodigy.net") by vger.kernel.org with ESMTP
	id S1751224AbVIFCJ2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 22:09:28 -0400
X-ORBL: [69.107.75.50]
Date: Mon, 05 Sep 2005 19:09:22 -0700
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, basicmark@yahoo.com
Subject: Re: SPI redux ... driver model support
Cc: dpervushin@ru.mvista.com, basicmark@yahoo.com
References: <20050902072125.23825.qmail@web30303.mail.mud.yahoo.com>
In-Reply-To: <20050902072125.23825.qmail@web30303.mail.mud.yahoo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <20050906020922.C8911C0006@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > @@ -193,6 +193,34 @@
> >  
> >  #ifdef	CONFIG_OMAP_OSK_MISTRAL
> >  
> > +#include <linux/spi.h>
> > +
> > +struct ads7864_info {		/* FIXME put in standard header */
> > +	u16	pen_irq, busy;		/* GPIO lines */
> > +	u16	x_ohms, y_ohms;
> > +};
> > +
> > +static struct ads7864_info mistral_ts_info = {
> > +	.pen_irq	= OMAP_GPIO_IRQ(4),
> > +	.busy		= /* GPIO */ 6,
> > +	.x_ohms		= 419,
> > +	.y_ohms		= 486,
> > +};
> > +
> > +static const struct spi_board_info mistral_boardinfo[] = {
> > +{
> > +	/* MicroWire CS0 has an ads7846e with touchscreen and
> > +	 * other sensors.  It's currently glued into some OMAP
> > +	 * touchscreen support that ignores the driver model.
> > +	 */
> > +	.driver_name	= "ads7846",
> > +	.platform_data	= &mistral_ts_info,
> > +	.max_speed_hz	= 2000000,
> > +	.bus_num	= 2, 		/* spi2 == microwire */
>
> I did think about doing this but the problem is how do
> you know bus 2 is the bus you think it is?

The numbering is board-specific, but in most cases that can be simplified
to being SOC-specific.  In this case I numbered the SPI-capable controllers
(from 1..7, not included in this patch) and this one came out "2".  The
consistency matters, not the actual (nonzero) numbers.

Hotpluggable SPI controllers are not common, but that's where that sysfs
API to define new devices would really hit the spot.  That would be how the
kernel learns about "struct spi_board_info" structures associated with some
dynamically assigned bus_num.  Likely some convention for dynamically
assigned IDs would help, like "they're all negative".

(What I've seen a bit more often is that expansion cards will be wired
for SPI, so the thing that's vaguely hotplug-ish is that once you know
what card's hooked up, you'll know the SPI devices it has.  Then the
question is how to tell the kernel about them ... same solution, which
again must work without hardware probing.)


>		This would
> work for SPI adapters that are platform devices, but
> what about hot-plug devices like PCI and USB (we are
> thinking of actually making a USB to SPI converter so
> customers can try out some of our SPI devices on a PC

Some of the microcontrollers that talk both USB (slave) and SPI (master)
will even run Linux for you.  :)

- Dave

