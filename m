Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262836AbTH1Pr4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 11:47:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264048AbTH1Pr4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 11:47:56 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:45531 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S262836AbTH1Pry
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 11:47:54 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] /proc/ide/hdx/settings with ide-default pseudo-driver is a 2.6/2.7 show-stopper
Date: Thu, 28 Aug 2003 17:47:11 +0200
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
References: <200308281646.16203.bzolnier@elka.pw.edu.pl> <1062083581.24982.21.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062083581.24982.21.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308281747.11359.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 of August 2003 17:13, Alan Cox wrote:
> On Iau, 2003-08-28 at 15:46, Bartlomiej Zolnierkiewicz wrote:
> > Some background first: we need ide-default driver (set as a device driver
> > for all driver-less ide devices) mainly because we allow changing devices
> > settings through /proc/ide/hdX/settings and some of them (current_speed,
> > pio_mode) are processed via request queue (we are currently preallocating
> > gendisk and queue structs for all possible ide devices).  The next
> > problem is that ide-default doesn't register itself with ide and
> > driverfs. If it does it will "steal" devices meaned to be used by other
> > drivers.
>
> Its also used to avoid special cases elsewhere.

/proc/ide/hdX/settings is the source (directly/indirectly)
for 95% of these special cases.

> > If we want dynamic hwifs/devices, moving gendisks/queues allocation
> > to device drivers and ide integration with driverfs we need to:
> >
> > (a) kill /proc/ide/hdX/settings for driver-less devices and kill
> > ide-default
>
> ide_default avoids a ton of driver specific special case code outside
> of /proc/ide/foo/settings too. It isnt that simple, and I added it

It is simple.  No settings - you dont hit these places.

> originally to fix hundreds of weird little bugs and races. You also need
> it for handling hotplug of devices.

Why for hotplug?  We should move all code physically touching
devices to use request queue (REQ_SPECIAL), then you can simply
mark device as unplugged when its gone and check this flag inside
ide_do_request().

When its plugged again its reprobed (you dont need driver for this)
and if its the same device you just clear unplugged flag.

Does it make sense?

With this scheme you also shouldn't need hwif->unplugged_ops hack.
You mark all drives belonging to hwif as unplugged and you are happy.

> I don't however think it needs to be any brighter than it is now. Driver
> ordering isnt important, Linus was pretty emphatic that he a) didn't

Ordering is important when converting ide drivers to driverfs.
Then i will need to register ide-default with driverfs and it will
be "stealing" devices.

> care and b) wouldnt take patches to do any kind of rigid ordering when I
> asked him (and for hotplug its pretty obvious why)
>
> As far as I can see you either
>
> 1. Set up the queues and /proc when you create a hwif
>
> or
>
> 2. Provide a generic function for each driver to call that does this
> and/or undoes it. Since each driver needs the same code (default
> included).

2. is a proper solution and its not a problem.

Problem is when integrating ide with driverfs.
Then you need to register/unregister ide-default as driverfs driver
and now it can "steal" devices, ie. you have cd drive owned by ide-default,
later you load ide-cdrom driver and your cd drive needs to be unregistered
from ide-default driver first before it can be registered with ide-cdrom
driver - you need to add code to do this or device will be "stealed".
Its not very hard to do but it adds complexity.

--bartlomiej

