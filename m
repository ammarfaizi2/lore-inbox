Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751832AbWBXDcn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbWBXDcn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 22:32:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751833AbWBXDcn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 22:32:43 -0500
Received: from mx1.rowland.org ([192.131.102.7]:269 "HELO mx1.rowland.org")
	by vger.kernel.org with SMTP id S1751832AbWBXDcn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 22:32:43 -0500
Date: Thu, 23 Feb 2006 22:32:42 -0500 (EST)
From: Alan Stern <stern@rowland.harvard.edu>
X-X-Sender: stern@netrider.rowland.org
To: Greg KH <greg@kroah.com>
cc: James Bottomley <James.Bottomley@SteelEye.com>,
       Kernel development list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] driver core: better reference counting for klists
In-Reply-To: <20060224014204.GB25787@kroah.com>
Message-ID: <Pine.LNX.4.44L0.0602232230440.19776-100000@netrider.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Feb 2006, Greg KH wrote:

> On Thu, Feb 23, 2006 at 10:38:13AM -0500, Alan Stern wrote:
> > On Wed, 22 Feb 2006, Greg KH wrote:
> > 
> > > > Index: usb-2.6/drivers/base/dd.c
> > > > ===================================================================
> > > > --- usb-2.6.orig/drivers/base/dd.c
> > > > +++ usb-2.6/drivers/base/dd.c
> > > > @@ -72,6 +72,8 @@ int driver_probe_device(struct device_dr
> > > >  {
> > > >     int ret = 0;
> > > >     
> > > > +   if (!device_is_registered(dev))
> > > > +           return -ENODEV;
> > > >     if (drv->bus->match && !drv->bus->match(dev, drv))
> > > >             goto Done;
> > > >     
> > > > Index: usb-2.6/drivers/base/bus.c
> > > > ===================================================================
> > > > --- usb-2.6.orig/drivers/base/bus.c
> > > > +++ usb-2.6/drivers/base/bus.c
> > > > @@ -367,6 +367,7 @@ int bus_add_device(struct device * dev)
> > > >  
> > > >  	if (bus) {
> > > >  		pr_debug("bus %s: add device %s\n", bus->name, dev->bus_id);
> > > > +		dev->is_registered = 1;
> > > >  		device_attach(dev);
> > > >  		klist_add_tail(&dev->knode_bus, &bus->klist_devices);
> > > >  		error = device_add_attrs(bus, dev);
> > > > @@ -393,7 +394,8 @@ void bus_remove_device(struct device * d
> > > >  		sysfs_remove_link(&dev->kobj, "bus");
> > > >  		sysfs_remove_link(&dev->bus->devices.kobj, dev->bus_id);
> > > >  		device_remove_attrs(dev->bus, dev);
> > > > -		klist_remove(&dev->knode_bus);
> > > > +		klist_del(&dev->knode_bus);
> > > > +		dev->is_registered = 0;
> > > 
> > > Don't we have a race between these two lines?  How is that protected?

> The last 2 ones above, doing a klist_del() and then after that setting
> is_registered to 0.

I don't understand the question.  The two lines are part of the same 
routine and they run in the same thread, so how can one race the other?

Alan Stern

