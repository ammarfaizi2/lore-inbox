Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932208AbVIGSiz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932208AbVIGSiz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 Sep 2005 14:38:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932211AbVIGSiz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 Sep 2005 14:38:55 -0400
Received: from web30307.mail.mud.yahoo.com ([68.142.200.100]:35193 "HELO
	web30307.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932208AbVIGSiy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 Sep 2005 14:38:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=yahoo.com;
  h=Message-ID:Received:Date:From:Subject:To:Cc:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding;
  b=G5fEXOTYVynDoOM437jwJkbtvksQ/WSBNKFG9kiBJ4E1J6PJR2c59I01AxlzzMGRjax6EbARHyI6U51OY61te3cSDEmUUUa7HhWSfyxPOMYMpLsog9Tr2RfNfaP1cLwIVuBjVDQM3MEGjkqDIim/8NLvjzEO7lX+wARgPOaC3Hk=  ;
Message-ID: <20050907183843.14745.qmail@web30307.mail.mud.yahoo.com>
Date: Wed, 7 Sep 2005 19:38:43 +0100 (BST)
From: Mark Underwood <basicmark@yahoo.com>
Subject: Re: SPI redux ... driver model support
To: David Brownell <david-b@pacbell.net>, linux-kernel@vger.kernel.org
Cc: dpervushin@ru.mvista.com
In-Reply-To: <20050906215325.813B1BF3C8@adsl-69-107-32-110.dsl.pltn13.pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--- David Brownell <david-b@pacbell.net> wrote:

> > With my subsystem that would look like:
> >
> > static const struct spi_cs_table
> > platform_spi1_cs_table[] = {
> >  {
> >   .name  = "touchscreen",
> >   .cs_no  = 1,
> >   .platform_data = NULL,
> >   .flags  = SPI_CS_IDLE_HIGH,
> >   .cs_data = 0,
> >  },
> >  {
> >   .name  = "flash",
> >   .cs_no  = 3,
> >   .platform_data = NULL,
> >   .flags  = SPI_CS_IDLE_HIGH,
> >   .cs_data = 0,
> >  },
> > };
> 
> The problem scenario was that only one configuration
> is valid at a time ... it would have been clearer if
> both the add-on boards used CS1, so that device
> would
> be either ads7864 _or_ at25640a, but not both.
> 
> 
> 
> > As far as I can see most SPI devices have fixed
> > wirering to an adapter as SPI is not really a
> hotplug
> > bus.
> 
> That wiring can be through an expansion connector
> though, which
> is what I meant when I wrote that it's "vaguely
> hotplug-ish".
> Example, the mainboard could have some SPI devices
> hard-wired,
> on CS0 and CS2, while each different plugin board
> might add very
> different devices on CS1 and/or CS3.
> 
> In any case, you were the one who also wanted to
> ship sample USB
> peripherals that acted as adapters to various SPI
> chips... so that
> bus adapters would really need to hotplug! :)
>

I see several posabiltiys of how SPI devices could be
connected to an adapter.

1) All SPI devices are hardwired to the adapter. I
think this would be the most common. In this case you
would register a cs table as part of the platform data
of the SPI adapter like in the example platform in my
patch. Note: this is even the case with a PCI or usb
based device as it is the adapter that is hotpluged
and not the SPI devices on that device.

2) Some SPI devices are hardwired and some are
removable. In this case these the hardwired ones would
be put in the cs table and the other SPI devices would
be registered by calling spi_device_register. I would
add a call in my core layer to which you could pass
the bus_id and it would pass back the adapters pointer
to put in the spi_device structure.

3) All SPI devices are removable. An empty cs table
would be used and SPI devices would be registered by
calling spi_device_register.
 
> 
> > The subsystem does allow you to add extra devices
> that
> > aren't in the cs table if you want by calling
> > spi_device_register in which case you have to
> setup
> > the spi_device with the correct information.
> 
> Right, but as I had explained, the scenario is that
> the
> SPI devices are on some easily-swapped add-on card.
> That's a common physical arrangement for small
> embeddable
> boards, because it takes so few wires per device.
> 
> Swapping those SPI connectors shouldn't involve
> changing
> the declaration of the controller on the mainboard
> ...

Your not when you use spi_device_register /
spi_device_unregister. You can register an adapter
with an empty cs table if you don't have any hardwired
SPI devices. When you plug a card in you use
spi_device_register to add that device to the system
and when you remove the card you call
spi_device_unregister. You can then do the same for a
different card and at no time have you changed the
declaration of the controller.

> 
> 
> > > One reason I posted this driver-model-only patch
> was
> > > to highlight how
> > > minimal an SPI core can be if it reuses the
> driver
> > > model core.  I'm
> > > not a fan of much "mid-layer" infrastructure in
> > > driver stacks.
> > > 
> >
> > This is what my SPI core tries to do. I would like
> to
> > make at 'as small as possible and no smaller'
> 
> I'll post a refresh of my patch that seems to me to
> be
> a much better match for those goals.  The refresh
> includes
> some tweaks based on what you sent, but it's still
> just
> one KByte of overhead in the target ROM.  :)

OK. I will post an updated version of my SPI subsystem
within the next few days with the transfer stuff added
and maybe the interrupt and GPO abstraction as well.

I haven't seen any replies to my SPI patch :( did you
reply to it?

Mark

> 
> - Dave
> 
> 



		
___________________________________________________________ 
To help you stay safe and secure online, we've developed the all new Yahoo! Security Centre. http://uk.security.yahoo.com
