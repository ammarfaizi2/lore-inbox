Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751536AbWDAQq2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751536AbWDAQq2 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 1 Apr 2006 11:46:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751549AbWDAQq2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 1 Apr 2006 11:46:28 -0500
Received: from mx1.rowland.org ([192.131.102.7]:33297 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751536AbWDAQq2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 1 Apr 2006 11:46:28 -0500
Date: Sat, 1 Apr 2006 11:46:26 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Greg KH <greg@kroah.com>, David Brownell <david-b@pacbell.net>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: Handling devices that don't have a bus
In-Reply-To: <20060401094736.GB2636@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.44L0.0604011128020.17557-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 Apr 2006, Russell King wrote:

> On Thu, Mar 30, 2006 at 03:45:50PM -0500, Alan Stern wrote:
> > I recently tried running the dummy_hcd driver for the first time in a 
> > while, and it crashed when the gadget driver was unloaded.  It turns out 
> > this was because the gadget's embedded struct device is registered without 
> > a bus, which triggers an oops when the device's driver is unbound.  The 
> > oops could be fixed by doing this:
> 
> Can you provide the oops itself please?

No, I don't have it any more.  But I can tell you exactly where the oops 
occurred.  In __device_release_driver() (in drivers/base/dd.c), this line 
you added:

		if (dev->bus->remove)

crashed because dev->bus was NULL.  My patch changes the line to:

		if (dev->bus && dev->bus->remove)

Any objection to that?

> > Part of the problem here is that most of the USB controllers are platform
> > devices and so belong on the platform bus.
> 
> You're making a connection where no such connection exists.  Devices
> are only part of the platform bus if they explicitly want to be (in
> much the same way that devices are only part of the PCI bus if they
> explicitly set dev->bus to be the PCI bus.)

I think you have misunderstood my point.  Yes, devices are part of the
platform bus only if they explicitly want to be.  My point was that even
though they _do_ want to be on the platform bus, in this situation they
_can't_ because they are forced to register a struct device, not a struct
platform_device.  The choice is not up to the driver; it is determined by
the USB Gadget framework.  (See the definition of struct usb_gadget in 
include/linux/usb_gadget.h -- there's an embedded struct device, not an 
embedded struct platform_device.)

> > But struct usb_gadget contains an embedded struct device, not an embedded
> > struct platform_device... so the gadget _can't_ be registered on its 
> > parent's bus.
> 
> From what I can see, the embedded device does not belong to any bus at
> all since dev->bus is NULL.  Hence, I don't think it's the embedded
> struct device which is causing the problem here.
> 
> It would be good to see the entire oops to see what's going on.

Yes, the device did not belong to any bus.  Hence the unguarded reference
to dev->bus->remove caused the oops.  If it's legal for devices not to
belong to a bus, then my patch should be applied to guard the reference.  
If it's not legal then the Gadget framework needs to be changed.

Alan Stern


