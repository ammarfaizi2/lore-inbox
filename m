Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264128AbTH1SHC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 28 Aug 2003 14:07:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264131AbTH1SHC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 28 Aug 2003 14:07:02 -0400
Received: from pc1-cwma1-5-cust4.swan.cable.ntl.com ([80.5.120.4]:53414 "EHLO
	dhcp23.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id S264128AbTH1SG7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 28 Aug 2003 14:06:59 -0400
Subject: Re: [RFC] /proc/ide/hdx/settings with ide-default pseudo-driver is
	a 2.6/2.7 show-stopper
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andre Hedrick <andre@linux-ide.org>
In-Reply-To: <200308281747.11359.bzolnier@elka.pw.edu.pl>
References: <200308281646.16203.bzolnier@elka.pw.edu.pl>
	 <1062083581.24982.21.camel@dhcp23.swansea.linux.org.uk>
	 <200308281747.11359.bzolnier@elka.pw.edu.pl>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1062093967.25044.39.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.3 (1.4.3-3) 
Date: 28 Aug 2003 19:06:08 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Iau, 2003-08-28 at 16:47, Bartlomiej Zolnierkiewicz wrote:
> > Its also used to avoid special cases elsewhere.
> 
> /proc/ide/hdX/settings is the source (directly/indirectly)
> for 95% of these special cases.

/proc/ide/foo/identify is another (and tools rely on that working
without ide-cd/ide-disk etc loaded btw) [HP monitoring tools for one]

> Why for hotplug?  We should move all code physically touching
> devices to use request queue (REQ_SPECIAL), then you can simply
> mark device as unplugged when its gone and check this flag inside
> ide_do_request().

Because you need to manipulate drives not attached to a driver
currently. I guess you could go through hoops to avoid it, but the
old IDE driver was just full of bugs that ide_default removed,
and it removed rather more code than it added.

You also need to be able to open the device to talk to the empty
slot about reprobing it, changing the bus state or even figuring
what driver is missing.

> With this scheme you also shouldn't need hwif->unplugged_ops hack.
> You mark all drives belonging to hwif as unplugged and you are happy.

You need the unplugged_ops for controller unplug, I'm more worried about
disk unplug (which I have working now). For controller unplug you either
have to know that ide_unregister does not ever return until the device
is truely idle - including interrupts, proc access currently running
etc. If so then notionally you can handle it without the unplugged ops
although they certainly make it safer.

I don't know what the constraints on PCI hotplug are but I don't believe
anything will run off and reuse the resources after an unplug event,
although your accesses might generate machine checks (non fatal) on IA64
etc.

> Problem is when integrating ide with driverfs.
> Then you need to register/unregister ide-default as driverfs driver
> and now it can "steal" devices, ie. you have cd drive owned by ide-default,
> later you load ide-cdrom driver and your cd drive needs to be unregistered
> from ide-default driver first before it can be registered with ide-cdrom
> driver - you need to add code to do this or device will be "stealed".
> Its not very hard to do but it adds complexity.

My own feeling is that its a lot easier than trying to catch all the 
corner cases ide_default fixed, especially when you do drive level
hotplug. If the IDE code was glorious and elegant, refcounted and with
a clear life cycle of objects I'd agree with you 8)

Alan

