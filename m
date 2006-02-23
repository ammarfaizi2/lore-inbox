Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWBWPiS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWBWPiS (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 10:38:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751430AbWBWPiS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 10:38:18 -0500
Received: from iolanthe.rowland.org ([192.131.102.54]:52111 "HELO
	iolanthe.rowland.org") by vger.kernel.org with SMTP
	id S1751447AbWBWPiS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 10:38:18 -0500
Date: Thu, 23 Feb 2006 10:38:13 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@iolanthe.rowland.org
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: better reference counting for klists
In-Reply-To: <20060223050525.GA8046@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0602231019530.5204-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Feb 2006, Greg KH wrote:

> > Index: usb-2.6/drivers/base/dd.c
> > ===================================================================
> > --- usb-2.6.orig/drivers/base/dd.c
> > +++ usb-2.6/drivers/base/dd.c
> > @@ -72,6 +72,8 @@ int driver_probe_device(struct device_dr
> >  {
> >     int ret = 0;
> >     
> > +   if (!device_is_registered(dev))
> > +           return -ENODEV;
> >     if (drv->bus->match && !drv->bus->match(dev, drv))
> >             goto Done;
> >     
> > Index: usb-2.6/drivers/base/bus.c
> > ===================================================================
> > --- usb-2.6.orig/drivers/base/bus.c
> > +++ usb-2.6/drivers/base/bus.c
> > @@ -367,6 +367,7 @@ int bus_add_device(struct device * dev)
> >  
> >  	if (bus) {
> >  		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
> > +		dev->is_registered = 1;
> >  		device_attach(dev);
> >  		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
> >  		error = device_add_attrs(bus, dev);
> > @@ -393,7 +394,8 @@ void bus_remove_device(struct device * d
> >  		sysfs_remove_link(&dev->kobj, "bus");
> >  		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
> >  		device_remove_attrs(dev->bus, dev);
> > -		klist_remove(&dev->knode_bus);
> > +		klist_del(&dev->knode_bus);
> > +		dev->is_registered = 0;
> 
> Don't we have a race between these two lines?  How is that protected?

Are you referring to the two lines that set dev->is_registered?  There is 
no direct protection.  However, one line is in bus_add_device() and the 
other is in bus_remove_device(); I've been assuming that any code 
responsible for adding and removing devices is serialized.  That is, it 
won't ever try to remove a device before that device has been completely 
added.

If that assumption isn't true, there are undoubtedly many other similar 
problems throughout the driver core.  Like the calls to sysfs_create_link 
in bus_add_device and sysfs_remove_link in bus_remove_device.

Or maybe you're referring to the device_is_registered() test in 
driver_probe_device().  That's synchronized with the call to 
device_release_driver() in bus_remove_device(), just below the portion you 
quoted, because both routines hold dev->sem.  So even if the probe routine 
fails to see that the device has been unregistered, we are guaranteed that 
device_release_driver will unbind the device.

If you're referring to two other lines, which lines are they?

Alan Stern

