Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750806AbWCaFpM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750806AbWCaFpM (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Mar 2006 00:45:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750909AbWCaFpM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Mar 2006 00:45:12 -0500
Received: from mail.kroah.org ([69.55.234.183]:61920 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1750806AbWCaFpK (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Mar 2006 00:45:10 -0500
Date: Thu, 30 Mar 2006 14:26:26 -0800
From: Greg KH <greg@kroah.com>
To: Alan Stern <stern@rowland.harvard.edu>
Cc: David Brownell <david-b@pacbell.net>, Russell King <rmk@arm.linux.org.uk>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Handling devices that don't have a bus
Message-ID: <20060330222626.GA18633@kroah.com>
References: <Pine.LNX.4.44L0.0603301520330.4652-100000@iolanthe.rowland.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44L0.0603301520330.4652-100000@iolanthe.rowland.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 03:45:50PM -0500, Alan Stern wrote:
> Greg et al.:
> 
> I recently tried running the dummy_hcd driver for the first time in a 
> while, and it crashed when the gadget driver was unloaded.  It turns out 
> this was because the gadget's embedded struct device is registered without 
> a bus, which triggers an oops when the device's driver is unbound.  The 
> oops could be fixed by doing this:

Why not make the dummy gadget a platform device?  That should keep this
from happening, right?

> Index: usb-2.6/drivers/base/dd.c
> ===================================================================
> --- usb-2.6.orig/drivers/base/dd.c
> +++ usb-2.6/drivers/base/dd.c
> @@ -209,7 +209,7 @@ static void __device_release_driver(stru
>  		sysfs_remove_link(&dev->kobj, "driver");
>  		klist_remove(&dev->knode_driver);
>  
> -		if (dev->bus->remove)
> +		if (dev->bus && dev->bus->remove)
>  			dev->bus->remove(dev);
>  		else if (drv->remove)
>  			drv->remove(dev);
> 
> but I'm not so sure this is the right approach.  (Russell wrote the line 
> that this would change; that's why I have CC'ed him.)  Is the current 
> policy that every device is supposed to belong to a bus?
> 
> If gadgets were registered on a bus, you would expect it to be the bus of
> their parent USB device controllers.  As it happens, most of the UDC
> drivers don't register their gadgets in sysfs at all.  dummy_hcd and
> net2280 are exceptions.  Presumably this same oops would affect net2280
> but I haven't tried it.
> 
> Part of the problem here is that most of the USB controllers are platform
> devices and so belong on the platform bus.  That's true of dummy_hcd.  
> But struct usb_gadget contains an embedded struct device, not an embedded
> struct platform_device... so the gadget _can't_ be registered on its 
> parent's bus.

ah, ick :(

> I suppose David could change things so that usb_gadget does contain a
> platform_device.  But then what about the net2280, which is a PCI device
> rather than a platform device?  Would it want to register its child on the
> platform bus?
> 
> What's the right thing to do here?

I think your patch is the right thing.  Care to resend it with a proper
Signed-off-by: line so I can apply it?

thanks,

greg k-h
