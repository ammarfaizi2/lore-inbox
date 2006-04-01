Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750929AbWDAJii@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750929AbWDAJii (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 04:38:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750925AbWDAJih
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 04:38:37 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:39946 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1750830AbWDAJih (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 04:38:37 -0500
Date: Sat, 1 Apr 2006 10:38:26 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Greg KH <greg@kroah.com>
Cc: Alan Stern <stern@rowland.harvard.edu>,
       David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Handling devices that don't have a bus
Message-ID: <20060401093826.GA2636@flint.arm.linux.org.uk>
Mail-Followup-To: Greg KH <greg@kroah.com>,
	Alan Stern <stern@rowland.harvard.edu>,
	David Brownell <david-b@pacbell.net>,
	Kernel development list <linux-kernel@vger.kernel.org>
References: <Pine.LNX.4.44L0.0603301520330.4652-100000@iolanthe.rowland.org> <20060330222626.GA18633@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060330222626.GA18633@kroah.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2006 at 02:26:26PM -0800, Greg KH wrote:
> On Thu, Mar 30, 2006 at 03:45:50PM -0500, Alan Stern wrote:
> > Greg et al.:
> > 
> > I recently tried running the dummy_hcd driver for the first time in a 
> > while, and it crashed when the gadget driver was unloaded.  It turns out 
> > this was because the gadget's embedded struct device is registered without 
> > a bus, which triggers an oops when the device's driver is unbound.  The 
> > oops could be fixed by doing this:
> 
> Why not make the dummy gadget a platform device?  That should keep this
> from happening, right?
> 
> > Index: usb-2.6/drivers/base/dd.c
> > ===================================================================
> > --- usb-2.6.orig/drivers/base/dd.c
> > +++ usb-2.6/drivers/base/dd.c
> > @@ -209,7 +209,7 @@ static void __device_release_driver(stru
> >  		sysfs_remove_link(&dev->kobj, "driver");
> >  		klist_remove(&dev->knode_driver);
> >  
> > -		if (dev->bus->remove)
> > +		if (dev->bus && dev->bus->remove)
> >  			dev->bus->remove(dev);
> >  		else if (drv->remove)
> >  			drv->remove(dev);
> > 
> > but I'm not so sure this is the right approach.  (Russell wrote the line 
> > that this would change; that's why I have CC'ed him.)  Is the current 
> > policy that every device is supposed to belong to a bus?

If a device belongs to a bus, dev->bus will be non-NULL.  I don't see
what "every device is supposed to belong to a bus" fits with the problem.

> > Part of the problem here is that most of the USB controllers are platform
> > devices and so belong on the platform bus.  That's true of dummy_hcd.  
> > But struct usb_gadget contains an embedded struct device, not an embedded
> > struct platform_device... so the gadget _can't_ be registered on its 
> > parent's bus.
> 
> ah, ick :(

If the device's dev->bus is NULL, we don't register it on the parents
bus, but we do register it in the device tree as a child of the parent
device.

I think there's confusion here.

> I think your patch is the right thing.  Care to resend it with a proper
> Signed-off-by: line so I can apply it?

First lets sort out the confusion before applying any patches.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
