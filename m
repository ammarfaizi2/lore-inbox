Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264155AbTH1SjN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:39:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264147AbTH1SjN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:39:13 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:2767 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264155AbTH1SjF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:39:05 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: [RFC] /proc/ide/hdx/settings with ide-default pseudo-driver is a 2.6/2.7 show-stopper
Date: Thu, 28 Aug 2003 20:39:39 +0200
User-Agent: KMail/1.5
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
References: <200308281646.16203.bzolnier@elka.pw.edu.pl> <200308281747.11359.bzolnier@elka.pw.edu.pl> <1062093967.25044.39.camel@dhcp23.swansea.linux.org.uk>
In-Reply-To: <1062093967.25044.39.camel@dhcp23.swansea.linux.org.uk>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308282039.39654.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 28 of August 2003 20:06, Alan Cox wrote:
> On Iau, 2003-08-28 at 16:47, Bartlomiej Zolnierkiewicz wrote:
> > > Its also used to avoid special cases elsewhere.
> >
> > /proc/ide/hdX/settings is the source (directly/indirectly)
> > for 95% of these special cases.
>
> /proc/ide/foo/identify is another (and tools rely on that working
> without ide-cd/ide-disk etc loaded btw) [HP monitoring tools for one]

Eeeh... easy to workaround: no settings -> drive->id doesnt change.
There is minor problem here: no driver -> driver -> no driver.

> > Why for hotplug?  We should move all code physically touching
> > devices to use request queue (REQ_SPECIAL), then you can simply
> > mark device as unplugged when its gone and check this flag inside
> > ide_do_request().
>
> Because you need to manipulate drives not attached to a driver
> currently. I guess you could go through hoops to avoid it, but the
> old IDE driver was just full of bugs that ide_default removed,
> and it removed rather more code than it added.

Heh.. bugs yes, code not :).

> You also need to be able to open the device to talk to the empty

You can't open devices owned by ide-default in 2.6 because ide-default,
probably because it doesnt call add_disk() for them.

> slot about reprobing it, changing the bus state or even figuring
> what driver is missing.

I think scsi does it without default driver.  procfs or sysfs

> > With this scheme you also shouldn't need hwif->unplugged_ops hack.
> > You mark all drives belonging to hwif as unplugged and you are happy.
>
> You need the unplugged_ops for controller unplug, I'm more worried about
> disk unplug (which I have working now). For controller unplug you either

So you can unplug disk in the middle of the transfer,
replug and transfer is continued?

> have to know that ide_unregister does not ever return until the device
> is truely idle - including interrupts, proc access currently running
> etc. If so then notionally you can handle it without the unplugged ops
> although they certainly make it safer.
>
> I don't know what the constraints on PCI hotplug are but I don't believe
> anything will run off and reuse the resources after an unplug event,
> although your accesses might generate machine checks (non fatal) on IA64
> etc.
>
> > Problem is when integrating ide with driverfs.
> > Then you need to register/unregister ide-default as driverfs driver
> > and now it can "steal" devices, ie. you have cd drive owned by
> > ide-default, later you load ide-cdrom driver and your cd drive needs to
> > be unregistered from ide-default driver first before it can be registered
> > with ide-cdrom driver - you need to add code to do this or device will be
> > "stealed". Its not very hard to do but it adds complexity.
>
> My own feeling is that its a lot easier than trying to catch all the
> corner cases ide_default fixed, especially when you do drive level
> hotplug. If the IDE code was glorious and elegant, refcounted and with
> a clear life cycle of objects I'd agree with you 8)

Eeehh... okay I will try "plan b". :-\

--bartlomiej

