Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVA0RMO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVA0RMO (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 12:12:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262663AbVA0RMN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 12:12:13 -0500
Received: from relay.2ka.mipt.ru ([194.85.82.65]:57010 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S262671AbVA0RKu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 12:10:50 -0500
Date: Thu, 27 Jan 2005 20:33:10 +0300
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: dtor_core@ameritech.net
Cc: dmitry.torokhov@gmail.com, Christoph Hellwig <hch@infradead.org>,
       Andrew Morton <akpm@osdl.org>, greg@kroah.com,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc2-mm1
Message-ID: <20050127203310.11dedefc@zanzibar.2ka.mipt.ru>
In-Reply-To: <d120d50005012612226401eed2@mail.gmail.com>
References: <20050124021516.5d1ee686.akpm@osdl.org>
	<1106751547.5257.162.camel@uganda>
	<d120d5000501260726714e8251@mail.gmail.com>
	<1106754848.5257.189.camel@uganda>
	<d120d500050126082515bd68f9@mail.gmail.com>
	<1106757974.5257.229.camel@uganda>
	<d120d50005012608556ab05a96@mail.gmail.com>
	<1106761176.5257.246.camel@uganda>
	<d120d5000501261026700e37c0@mail.gmail.com>
	<20050126230712.1dd63589@zanzibar.2ka.mipt.ru>
	<d120d50005012612226401eed2@mail.gmail.com>
Reply-To: johnpol@2ka.mipt.ru
Organization: MIPT
X-Mailer: Sylpheed-Claws 0.9.12b (GTK+ 1.2.10; i386-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Jan 2005 15:22:52 -0500
Dmitry Torokhov <dmitry.torokhov@gmail.com> wrote:

> On Wed, 26 Jan 2005 23:07:12 +0300, Evgeniy Polyakov
> <johnpol@2ka.mipt.ru> wrote:
> > 
> > Chip driver provides access methods to the attached logical devices.
> > It probes and activates them, if appropriate module is loaded.
> > 
> > Your example again is not suitable for superio case.
> > 
> > With superio you have several identical logical devices, access to which
> > is absolutely standard in second level(logic befind access),
> > but in first one(physicall access) it can differ.
> > 
> > So here is the real example of superio usage:
> > 
> >     userspace
> >        |
> >    superio core
> >      ......
> > 
> >       GPIO
> >  |----|  |--|
> > pc87366     sc1100
> >  |----| |---|
> >       WDT
> > 
> > Logical device GPIO is accessed by read/write methods, which only have
> > pin number(it is not how this methods are exactly implemeted though)
> > as parameter.
> > 
> > For example userspace accesses GPIO at sc1100 - it will be translated
> > into read methods called from appropriate superio chip with appropriate
> > parameters.
> > 
> > When we have multiple GPIO logical devices(each in it's own superio chip)
> > it is more convenient to use just the same object.
> 
> I take an exception to that. I think useroace is not concerned with
> topology and ownership of logical devices, the data is more important.
> I.e. you need to know that some pin respons to CPU temperature but you
> don't really care that it connected to it87 as opposed to some other
> chip. Therefore I think that ldev should translate to exactly the same
> underlying object. Consider the picture below:
> 
>         GPIO0     GPIO1   GPIO2 GPIO3
>           |         |       |     |
>        pc87266   sc1100     blah123
>           |         |
>          WDT0      WDT1
> 
> This will allow:
> - map every hardware piece (not entire chip, separate functions) to a
> device file to userspace can use standard read/write/select/poll if
> choses so.
> - easily represent them in sysfs and also allow userspace access to
> individual bits through sysfs attributes.
> - will not give headaches with poer management when half of device is
> powered down and half is active.
> - provided that there are alternative interfaces outlined above
> superio can be decoupled from the connector.

With presented design we already have above links.
Each superio chip has a list of chain objects, each of which points to
the connected logical device.
Logical device usage must be done using provided logical device methods
(like read/write/control).
>From that point of view noone even knows, that above GPIO0 and GPIO1 
(on the picture) are actually the same object(if they are not clones,
but if they are, then picture becomes 100% real).

> I wonder if it should be called "gpio" bus as opposed to superio
> because only chips are "super", the bus consists of very simple
> devices and drivers.

I can not agree that it is a bus.
Bus abstraction can be _only_ applied to hierarchy in the only one
superio chip.

> > I did not understand you from the beginning...
> 
> We are getting there I believe ;) 
> 
> -- 
> Dmitry


	Evgeniy Polyakov

Only failure makes us experts. -- Theo de Raadt
