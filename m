Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261924AbUKPGHo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261924AbUKPGHo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Nov 2004 01:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261919AbUKPGHo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Nov 2004 01:07:44 -0500
Received: from smtp810.mail.sc5.yahoo.com ([66.163.170.80]:64593 "HELO
	smtp810.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261924AbUKPGGv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Nov 2004 01:06:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: ambx1@neo.rr.com (Adam Belay)
Subject: Re: [PATCH] PNP support for i8042 driver
Date: Tue, 16 Nov 2004 01:06:46 -0500
User-Agent: KMail/1.6.2
Cc: linux-kernel@vger.kernel.org, matthieu castet <castet.matthieu@free.fr>,
       bjorn.helgaas@hp.com, vojtech@suse.cz,
       "Brown, Len" <len.brown@intel.com>, greg@kroah.com
References: <41960AE9.8090409@free.fr> <200411140148.02811.dtor_core@ameritech.net> <20041116053741.GD29574@neo.rr.com>
In-Reply-To: <20041116053741.GD29574@neo.rr.com>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200411160106.46673.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 16 November 2004 12:37 am, Adam Belay wrote:
> On Sun, Nov 14, 2004 at 01:48:00AM -0500, Dmitry Torokhov wrote:
> > On Saturday 13 November 2004 08:23 am, matthieu castet wrote:
> > > Hi,
> > > this patch add PNP support for the i8042 driver in 2.6.10-rc1-mm5. Acpi 
> > > is try before the pnp driver so if you don't disable ACPI or apply 
> > > others pnpacpi patches, it won't change anything.
> > > 
> > > Please review it and apply if possible
> > > 
> > > thanks,
> > > 
> > > Matthieu CASTET
> > > 
> > > Signed-Off-By: Matthieu Castet <castet.matthieu@free.fr>
> > > 
> > 
> > Hi,
> > 
> > Do we really need to keep those drivers loaded - i8042 will not
> > be hotplugged and ports are reserved anyway. We are only interested
> > in presence of the keyboard and mouse ports. Can we unregister
> > the drivers (both ACPI and PNP) right after registering and mark
> > all that stuff as __init/__initdata as in the patch below?
> > I also adjusted init logic so ACPI/PNP can be enabled/disabled
> > independently of each other.
> > 
> > -- 
> > Dmitry
> 
> As a general convention, I think we do.  This should apply to every bus and
> driver.  Every hardware component should have a driver bound to it.
> Otherwise, we can't take full advantage of sysfs.  We really need a driver to
> link the physical device to logical "class" abstractions . Futhermore, as we
> extend the functionality of the driver core (ex. manual binding and unbinding)
> _init will cause many headaches.  Also, unloading the driver is not good for
> power management.  This case may not apply to every device, but in most cases
> we need to have a driver loaded before suspending a piece of hardware, as only
> that driver can be sure of how to handle the device correctly.
> 
> It may not always be the most efficient solution for legacy hardware, but, at
> least, if we require legacy drivers to behave like any other driver, then we
> can ensure a minimum level of functionalily and flexability.  This set of
> standards will help ensure that legacy hardware can coexist nicely with more
> modern solutions.  That's really one of the main advantages of a layered
> design like the driver model.
> 

Adam,

I agree with your point that every device in the system should have a
driver attached. And i8042 does have one bound to it. It is i8042 platform
driver that does power management and ensures proper integration into driver
model.

There is no need to keep secondary "drivers" around, their sole purpose is
to provide information about avalilable resources. It would be ok if the
code was shared among several devices on a bus but for most (all?) legacy
devices it has to be programmed explicitely and will not be reused.

Also i8042 should not rely on either ACPI or PNP simply because the driver/
chip works on boxes other than x86/ia64 so we can't make ACPI or PNP drivers
"main" ones. 

As far as binding/rebinding goes I guess sysdevs and platform devices will
just disable this functionality.

--
Dmitry
