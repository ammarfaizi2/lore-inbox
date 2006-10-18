Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751002AbWJRCK1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751002AbWJRCK1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 17 Oct 2006 22:10:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751004AbWJRCK1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 17 Oct 2006 22:10:27 -0400
Received: from gate.crashing.org ([63.228.1.57]:49553 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1750978AbWJRCK0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 17 Oct 2006 22:10:26 -0400
Subject: [PATCH/RFC] Call platform_notify_remove later
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Linux Kernel list <linux-kernel@vger.kernel.org>
Cc: Greg KH <greg@kroah.com>, Andrew Morton <akpm@osdl.org>,
       Deepak Saxena <dsaxena@plexity.net>, len.brown@intel.com
Content-Type: text/plain
Date: Wed, 18 Oct 2006 12:08:55 +1000
Message-Id: <1161137335.23947.10.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.8.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

(CC'ed Deepak and Len, the two only users of that callback I could find
in the tree).

Right now, the driver core calls the platform_notify hook when adding a
device, before attaching to the bus and probing drivers. That is all
good. However, it calls platform_notify_remove on removal of a device
also -before- calling bus_remove_device(), and thus before unhooking
drivers from that device. That strikes me as odd, and even incorrect.

In my case, I want to maintain an arch-wide data structure attached to
every struct device in the system (currently pointed to by firmware_data
though I'd like another field, but that's a separate discussion). I need
that among others, to hold the DMA ops and pointer to the right iommu
for this device since our current code testing for all sorts of known
bus types is just a total mess.

For bus types I have complete control of, like powerpc VIO or EBUS, I
can control creation and destruction of this data structure within the
bus specific code, that's all good. But that's not the case for PCI (or
by extension, any other bus type that supports DMA that we might come up
with and that isn't platform specific).

Thus I want to use those platform_notify and platform_notify_remove
hooks in order to maintain that data structure for those bus types. The
problem is that in the case of removal, my remove call back will be
called before the driver remove, and thus with the driver potentially
still operating, using the DMA ops, etc...

I don't see any reason why this is done that way, so I'm proposing to
just move the call down a bit. I can then cleanup the data structure and
pointers after the driver remove() returns, which is safer.

It's still not perfect. Best would have been a platform_notify_destroy
hook in the actual freeing of the kobject, but there is no common
routine for that, or there is one but it's not used by all bus types.
PCI doesn't use it for example, thus that hook would have to be added
all over the place which I'm not too keen to do right now. Especially
since as far as I can tell, for my need (DMA ops), return from driver
remove() should be just fine.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

(Note: This isn't 2.6.19 material of course, though I'm cooking a pile
of patches relying on that for 2.6.20 so please let me know if I'm on
the wrong track asap :-)

Index: linux-cell/drivers/base/core.c
===================================================================
--- linux-cell.orig/drivers/base/core.c	2006-10-06 13:48:02.000000000 +1000
+++ linux-cell/drivers/base/core.c	2006-10-18 11:53:50.000000000 +1000
@@ -608,12 +608,13 @@ void device_del(struct device * dev)
 	device_remove_groups(dev);
 	device_remove_attrs(dev);
 
+	bus_remove_device(dev);
+
 	/* Notify the platform of the removal, in case they
 	 * need to do anything...
 	 */
 	if (platform_notify_remove)
 		platform_notify_remove(dev);
-	bus_remove_device(dev);
 	device_pm_remove(dev);
 	kobject_uevent(&dev->kobj, KOBJ_REMOVE);
 	kobject_del(&dev->kobj);


