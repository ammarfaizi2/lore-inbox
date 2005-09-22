Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751391AbVIVHsQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751391AbVIVHsQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Sep 2005 03:48:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbVIVHsP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Sep 2005 03:48:15 -0400
Received: from mail.kroah.org ([69.55.234.183]:35506 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1751391AbVIVHsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Sep 2005 03:48:15 -0400
Date: Thu, 22 Sep 2005 00:47:24 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, linux-usb-devel@lists.sourceforge.net,
       daniel.ritz@gmx.ch, stern@rowland.harvard.edu
Subject: [patch 02/18] Driver Core: add helper device_is_registered()
Message-ID: <20050922074724.GC15053@kroah.com>
References: <20050922003901.814147000@echidna.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="driver-device_is_registered.patch"
In-Reply-To: <20050922074643.GA15053@kroah.com>
User-Agent: Mutt/1.5.10i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Ritz <daniel.ritz@gmx.ch>

[PATCH] driver core: add helper device_is_registered()

add the helper and use it instead of open coding the klist_node_attached() check
(which is a layering violation IMHO)

idea by Alan Stern.

Signed-off-by: Daniel Ritz <daniel.ritz@gmx.ch>
Cc: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/s390/cio/ccwgroup.c |    2 +-
 drivers/usb/core/message.c  |    2 +-
 drivers/usb/core/usb.c      |    6 +++---
 include/linux/device.h      |    5 +++++
 4 files changed, 10 insertions(+), 5 deletions(-)

--- scsi-2.6.orig/drivers/s390/cio/ccwgroup.c	2005-09-21 17:37:54.000000000 -0700
+++ scsi-2.6/drivers/s390/cio/ccwgroup.c	2005-09-21 17:37:59.000000000 -0700
@@ -437,7 +437,7 @@
 	if (cdev->dev.driver_data) {
 		gdev = (struct ccwgroup_device *)cdev->dev.driver_data;
 		if (get_device(&gdev->dev)) {
-			if (klist_node_attached(&gdev->dev.knode_bus))
+			if (device_is_registered(&gdev->dev))
 				return gdev;
 			put_device(&gdev->dev);
 		}
--- scsi-2.6.orig/drivers/usb/core/message.c	2005-09-21 17:37:54.000000000 -0700
+++ scsi-2.6/drivers/usb/core/message.c	2005-09-21 17:37:59.000000000 -0700
@@ -987,7 +987,7 @@
 
 			/* remove this interface if it has been registered */
 			interface = dev->actconfig->interface[i];
-			if (!klist_node_attached(&interface->dev.knode_bus))
+			if (!device_is_registered(&interface->dev))
 				continue;
 			dev_dbg (&dev->dev, "unregistering interface %s\n",
 				interface->dev.bus_id);
--- scsi-2.6.orig/drivers/usb/core/usb.c	2005-09-21 17:37:54.000000000 -0700
+++ scsi-2.6/drivers/usb/core/usb.c	2005-09-21 17:37:59.000000000 -0700
@@ -303,7 +303,7 @@
 	/* if interface was already added, bind now; else let
 	 * the future device_add() bind it, bypassing probe()
 	 */
-	if (klist_node_attached(&dev->knode_bus))
+	if (device_is_registered(dev))
 		device_bind_driver(dev);
 
 	return 0;
@@ -336,8 +336,8 @@
 	if (iface->condition != USB_INTERFACE_BOUND)
 		return;
 
-	/* release only after device_add() */
-	if (klist_node_attached(&dev->knode_bus)) {
+	/* don't release if the interface hasn't been added yet */
+	if (device_is_registered(dev)) {
 		iface->condition = USB_INTERFACE_UNBINDING;
 		device_release_driver(dev);
 	}
--- scsi-2.6.orig/include/linux/device.h	2005-09-21 17:37:54.000000000 -0700
+++ scsi-2.6/include/linux/device.h	2005-09-21 17:38:29.000000000 -0700
@@ -317,6 +317,11 @@
 	dev->driver_data = data;
 }
 
+static inline int device_is_registered(struct device *dev)
+{
+	return klist_node_attached(&dev->knode_bus);
+}
+
 /*
  * High level routines for use by the bus drivers
  */

--
