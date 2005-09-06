Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750835AbVIFUKL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750835AbVIFUKL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Sep 2005 16:10:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750855AbVIFUKL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Sep 2005 16:10:11 -0400
Received: from web30312.mail.mud.yahoo.com ([68.142.201.230]:51289 "HELO
	web30312.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1750835AbVIFUKK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Sep 2005 16:10:10 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=maFlBBbmOWCneqzNKqkimAvp5A6TxFOmjaZ47voIGAar+AOA2x/yrlQQjGrXJSmDnXjBzcymFLf3P8TwF6aJxQ6FTziXphdUNGHX30ryS7GITucKam0gkj4zVr6gPZ6b8OFXolYqJM39k0gEg2T+VAcRWEJGgEY9DmDcR6+cdH8=  ;
Message-ID: <20050906201001.68988.qmail@web30312.mail.mud.yahoo.com>
Date: Tue, 6 Sep 2005 21:10:01 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI redux ... driver model support
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050906160043.9BDFAD480C@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > > > I did think about doing this but the problem
> is how do
> > > > you know bus 2 is the bus you think it is?
> > > 
> > > The numbering is board-specific, but in most
> cases
> > > that can be simplified to being SOC-specific. 
> ...
> > > 
> > > Hotpluggable SPI controllers are not common, but
> > > that's where that sysfs API to define new
> devices
> > > would really hit the spot. ...
> > > 
> > > (What I've seen a bit more often is that
> expansion
> > > cards will be wired for SPI, so the thing that's
> > > vaguely hotplug-ish is that once you know what
> > > card's hooked up, you'll know the SPI devices it
> > > has.  Then the question is how to tell the
> kernel
> > > about them ...  same solution, which again must
> work
> > > without hardware probing.)
> >
> > This is why I decided to pass the cs table as
> platform
> > data when an adapter is registered. This way you
> don't
> > have to try to find out an adapters bus number as
> the
> > adapter has the cs table in it, but because it was
> > passed in as platform data it still abstracts that
> > from the adapter driver. Simple, yet effective :)
> 
> Except that it doesn't work in that primary case,
> where the SPI devices
> are physically decoupled from any given SPI (master)
> controller.
> One expansion card uses CS1 for a touchscreen;
> another uses CS3 for
> SPI flash ... the same "cs table" can't handle both
> configurations.
> It's got to be segmented, with devices separated
> from controllers.

With my subsystem that would look like:

static const struct spi_cs_table
platform_spi1_cs_table[] = {
 {
  .name  = "touchscreen",
  .cs_no  = 1,
  .platform_data = NULL,
  .flags  = SPI_CS_IDLE_HIGH,
  .cs_data = 0,
 },
 {
  .name  = "flash",
  .cs_no  = 3,
  .platform_data = NULL,
  .flags  = SPI_CS_IDLE_HIGH,
  .cs_data = 0,
 },
};

As far as I can see most SPI devices have fixed
wirering to an adapter as SPI is not really a hotplug
bus.
The subsystem does allow you to add extra devices that
aren't in the cs table if you want by calling
spi_device_register in which case you have to setup
the spi_device with the correct information.

> 
> Plus, that depends on standardizing platform_data
> between platforms.
> That's really not the model for platform_data!  And
> "struct clk" is
> ARM-only for now, too ... 

The struct clk should have been removed, I missed it
on that tidy up.
Why not pass platform data through the platform_data
pointer? I have now provided an extra field now which
lets you pass in any other platform data. 

> 
> 
> > Have you looked at the patch which I sent?
> >
>
http://www.ussg.iu.edu/hypermail/linux/kernel/0509.0/0817.html
> >
> > I would appreciate any comments on this approach.
> 
> Yes, I plan to follow up to that with comments.  As
> with Dmitry's
> proposal, it's modeled closely on I2C, and is in
> consequence larger
> than needed for what it does.

I hope not, I spent a long time learning about the
features of the 2.6 driver model. I'm happy to trim
down any fat.

> 
> One reason I posted this driver-model-only patch was
> to highlight how
> minimal an SPI core can be if it reuses the driver
> model core.  I'm
> not a fan of much "mid-layer" infrastructure in
> driver stacks.
> 

This is what my SPI core tries to do. I would like to
make at 'as small as possible and no smaller'

Mark

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


Send instant messages to your online friends http://uk.messenger.yahoo.com 
