Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262558AbTCISDx>; Sun, 9 Mar 2003 13:03:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262559AbTCISDx>; Sun, 9 Mar 2003 13:03:53 -0500
Received: from blowme.phunnypharm.org ([65.207.35.140]:54022 "EHLO
	blowme.phunnypharm.org") by vger.kernel.org with ESMTP
	id <S262558AbTCISDu>; Sun, 9 Mar 2003 13:03:50 -0500
Date: Sun, 9 Mar 2003 13:14:13 -0500
From: Ben Collins <bcollins@debian.org>
To: Patrick Mochel <mochel@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [RFC] [PATCH] Device removal callback
Message-ID: <20030309181413.GA492@phunnypharm.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I found myself needing this in a bad way while converting linux1394 to
use the new device model.

The ieee1394 stack has a tree like model, similar to USB. We have hosts,
that have nodes as children, and each node has unit directories which
describe functionality the node supports. Each one of these is
represented by a device now, which is parented accordingly.

Now, I wanted to remove all the internal handling we had for the
functionality that is now handled by the device model. All the lists,
the callbacks, probing, binding, etc. However, I couldn't do this
because there is no way for removing one device and having all of it's
children subsequently removed aswell. While a device keeps a list of its
children, nothing made sure that list was empty before it was removed.

That meant I would have to re-add a lot of the same house-keeping that
the device model promised me I could remove. Linked lists and more
callbacks.

I tried making device_unregister() in turn go down the list of children
and call device_unregister() before calling device_del() on itself. But
some core internals didn't like that, and loading a new pci device
caused it to crap up.

So I added a new callback to the device stucture called remove. This
callback is done when device_del is about to remove a device from the
tree. I've used this internally to make sure I can walk the list of
children myself, and also do some other cleanups.

It did this on a per-device context as opposed to a per-class or
per-bus, because some devices may need special callbacks. Consider a
psuedo or emulated device that is created outside the bus's normal
context (e.g. an emulated sbp2 device attached via userspace to the
local firewire node, using raw1394's kernel/userspace interface).

Also, I did consider the release callback, but that's run just a little
too late in the game for this purpose.

So, here's my simple patch. I'd really like this to be applied to the
proper kernel. I really can't see how the driver model is working
without walking children on unregister, but this atleast allows you to
handle it yourself.


--- linux-2.5.64.orig/drivers/base/core.c	2003-03-05 08:49:39.000000000 -0500
+++ linux-2.5.64/drivers/base/core.c	2003-03-09 11:32:43.000000000 -0500
@@ -266,6 +266,11 @@
 {
 	struct device * parent = dev->parent;
 
+	/* Let the device know it needs to leave us, possibly
+	 * deconfiguring itself or some such. */
+	if (dev->remove)
+		dev->remove(dev);
+
 	if (parent) {
 		down(&device_sem);
 		list_del_init(&dev->node);
--- linux-2.5.64.orig/include/linux/device.h	2003-03-05 08:49:52.000000000 -0500
+++ linux-2.5.64/include/linux/device.h	2003-03-09 09:04:18.000000000 -0500
@@ -254,6 +254,7 @@
 	u64		*dma_mask;	/* dma mask (if dma'able device) */
 
 	void	(*release)(struct device * dev);
+	void	(*remove)(struct device * dev);
 };
 
 static inline struct device *
