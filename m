Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267007AbSLDSND>; Wed, 4 Dec 2002 13:13:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267008AbSLDSND>; Wed, 4 Dec 2002 13:13:03 -0500
Received: from air-2.osdl.org ([65.172.181.6]:416 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267007AbSLDSNA>;
	Wed, 4 Dec 2002 13:13:00 -0500
Date: Wed, 4 Dec 2002 12:04:56 -0600 (CST)
From: Patrick Mochel <mochel@osdl.org>
X-X-Sender: <mochel@localhost.localdomain>
To: James Bottomley <James.Bottomley@steeleye.com>
cc: Greg KH <greg@kroah.com>, <linux-kernel@vger.kernel.org>
Subject: Re: [BKPATCH] bus notifiers for the generic device model 
In-Reply-To: <200212041804.gB4I4g803144@localhost.localdomain>
Message-ID: <Pine.LNX.4.33.0212041156080.924-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 4 Dec 2002, James Bottomley wrote:

> greg@kroah.com said:
> > But doesn't the bus specific core know when drivers are attached, as
> > it was told to register or unregister a specific driver?  So I don't
> > see why this is really needed. 
> 
> The problem is that the bus specific core registration no-longer knows if the 
> probes succeeded or failed (and if they did, what devices were attached), 
> since probing is controlled by the base core.
> 
> What the bus needs to know is when a driver attaches to a specific device (and 
> what device it has attached to).
> 
> Unless you have a better way of getting the attachment information out of the 
> bus after the base probes have executed, a notifier seemed to be the simplest 
> thing.

I believe that the stuff you're allowing the bus to do once the driver has 
been attached, is traditionally triggered by the driver in their probe() 
method once they've found a valid device. Which, in most cases, is a 
perfectly valid place to do it -- drivers have always been considered 
masters of their own destiny, and the things that this patch allows the 
bus to do seems like they should be triggered by the driver, with the bus 
supplying helpers.

The fact that the probe() method is overloaded to setup the device as well 
as verify that it should attach to it is a potential opportunity for 
improvement. There's been talk in the past about splitting it up into 
probe() and start() (or perhaps something better). The first would only 
verify that the device was a valid one to attach to, and the latter would 
actually do the dirty work of setting it up. It would be called in 
drivers/base/bus.c::attach(), like this:

===== drivers/base/bus.c 1.26 vs edited =====
--- 1.26/drivers/base/bus.c	Sun Dec  1 23:22:04 2002
+++ edited/drivers/base/bus.c	Wed Dec  4 12:02:41 2002
@@ -228,6 +228,10 @@
 {
 	pr_debug("bound device '%s' to driver '%s'\n",
 		 dev->bus_id,dev->driver->name);
+
+	if (dev->driver->start)
+		dev->driver->start(dev);
+
 	list_add_tail(&dev->driver_list,&dev->driver->devices);
 	sysfs_create_link(&dev->driver->kobj,&dev->kobj,dev->kobj.name);
 }

I don't recall why the change was never done. Perhaps because of other 
distractions, or it seemed like it would be too much of a PITA to convert 
drivers to a two-step init sequence (though I think it could be done in a 
compatible manner).


	-pat

