Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964788AbVIFKFb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964788AbVIFKFb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 06:05:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964789AbVIFKFb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 06:05:31 -0400
Received: from web30307.mail.mud.yahoo.com ([68.142.200.100]:31641 "HELO
	web30307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S964788AbVIFKFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 06:05:30 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=V0bGFHqYw/VmWG/oFzrig9b2bFDSWMcwRhCLY76jK7aB1vro3zJsFvVsWQnrVSt2fcEyExsQMgu1kakX2+O4xI+SAVEKe6sdhXq/+rBkkxFebRhi6ZSA/x4oM/Ig7XXlnf32VSobVIxPgwIpasTdhJGjvLD7cNF3Edy/U2EvxRI=  ;
Message-ID: <20050906100513.25072.qmail@web30307.mail.mud.yahoo.com>
Date: Tue, 6 Sep 2005 11:05:13 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI redux ... driver model support
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com, basicmark@yahoo.com
In-Reply-To: <20050906020922.C8911C0006@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > > @@ -193,6 +193,34 @@
> > >  
> > >  #ifdef	CONFIG_OMAP_OSK_MISTRAL
> > >  
> > > +#include <linux/spi.h>
> > > +
> > > +struct ads7864_info {		/* FIXME put in standard
> header */
> > > +	u16	pen_irq, busy;		/* GPIO lines */
> > > +	u16	x_ohms, y_ohms;
> > > +};
> > > +
> > > +static struct ads7864_info mistral_ts_info = {
> > > +	.pen_irq	= OMAP_GPIO_IRQ(4),
> > > +	.busy		= /* GPIO */ 6,
> > > +	.x_ohms		= 419,
> > > +	.y_ohms		= 486,
> > > +};
> > > +
> > > +static const struct spi_board_info
> mistral_boardinfo[] = {
> > > +{
> > > +	/* MicroWire CS0 has an ads7846e with
> touchscreen and
> > > +	 * other sensors.  It's currently glued into
> some OMAP
> > > +	 * touchscreen support that ignores the driver
> model.
> > > +	 */
> > > +	.driver_name	= "ads7846",
> > > +	.platform_data	= &mistral_ts_info,
> > > +	.max_speed_hz	= 2000000,
> > > +	.bus_num	= 2, 		/* spi2 == microwire */
> >
> > I did think about doing this but the problem is
> how do
> > you know bus 2 is the bus you think it is?
> 
> The numbering is board-specific, but in most cases
> that can be simplified
> to being SOC-specific.  In this case I numbered the
> SPI-capable controllers
> (from 1..7, not included in this patch) and this one
> came out "2".  The
> consistency matters, not the actual (nonzero)
> numbers.
> 
> Hotpluggable SPI controllers are not common, but
> that's where that sysfs
> API to define new devices would really hit the spot.
>  That would be how the
> kernel learns about "struct spi_board_info"
> structures associated with some
> dynamically assigned bus_num.  Likely some
> convention for dynamically
> assigned IDs would help, like "they're all
> negative".
> 
> (What I've seen a bit more often is that expansion
> cards will be wired
> for SPI, so the thing that's vaguely hotplug-ish is
> that once you know
> what card's hooked up, you'll know the SPI devices
> it has.  Then the
> question is how to tell the kernel about them ...
> same solution, which
> again must work without hardware probing.)
> 

This is why I decided to pass the cs table as platform
data when an adapter is registered. This way you don't
have to try to find out an adapters bus number as the
adapter has the cs table in it, but because it was
passed in as platform data it still abstracts that
from the adapter driver. Simple, yet effective :)

Have you looked at the patch which I sent?
http://www.ussg.iu.edu/hypermail/linux/kernel/0509.0/0817.html

I would appreciate any comments on this approach.

> 
> >		This would
> > work for SPI adapters that are platform devices,
> but
> > what about hot-plug devices like PCI and USB (we
> are
> > thinking of actually making a USB to SPI converter
> so
> > customers can try out some of our SPI devices on a
> PC
> 
> Some of the microcontrollers that talk both USB
> (slave) and SPI (master)
> will even run Linux for you.  :)

Yes, but not on a 8051 bassed Cypress USB chip ;)

> 
> - Dave
> 
> -
> To unsubscribe from this list: send the line
> "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at 
> http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
> 



	
	
		
___________________________________________________________ 
Yahoo! Messenger - NEW crystal clear PC to PC calling worldwide with voicemail http://uk.messenger.yahoo.com
