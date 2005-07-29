Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262677AbVG2TUX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262677AbVG2TUX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 15:20:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVG2TTc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 15:19:32 -0400
Received: from mail.kroah.org ([69.55.234.183]:39343 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262763AbVG2TRt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 15:17:49 -0400
Date: Fri, 29 Jul 2005 12:17:16 -0700
From: Greg KH <gregkh@suse.de>
To: Linus Torvalds <torvalds@osdl.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, stern@rowland.harvard.edu
Subject: [patch 22/29] USB: Usbcore: Don't try to delete unregistered interfaces
Message-ID: <20050729191716.GX5095@kroah.com>
References: <20050729184950.014589000@press.kroah.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline; filename="usb-dont-delete-unregistered-interfaces.patch"
In-Reply-To: <20050729191255.GA5095@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Alan Stern <stern@rowland.harvard.edu>

This patch handles a rarely-encountered failure mode in usbcore.  It's
legal for device_add to fail (although now it happens even more rarely
than before since failure to bind a driver is no longer fatal).  So when
we destroy the interfaces in a configuration, we shouldn't try to delete
ones which weren't successfully registered.  Also, failure to register an
interface shouldn't be fatal either -- I think; you may disagree about
this part of the patch.

Signed-off-by: Alan Stern <stern@rowland.harvard.edu>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

---
 drivers/usb/core/message.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

--- gregkh-2.6.orig/drivers/usb/core/message.c	2005-07-29 11:29:48.000000000 -0700
+++ gregkh-2.6/drivers/usb/core/message.c	2005-07-29 11:36:29.000000000 -0700
@@ -985,8 +985,10 @@
 		for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
 			struct usb_interface	*interface;
 
-			/* remove this interface */
+			/* remove this interface if it has been registered */
 			interface = dev->actconfig->interface[i];
+			if (!klist_node_attached(&interface->dev.knode_bus))
+				continue;
 			dev_dbg (&dev->dev, "unregistering interface %s\n",
 				interface->dev.bus_id);
 			usb_remove_sysfs_intf_files(interface);
@@ -1439,7 +1441,7 @@
 		}
 	}
 
-	return ret;
+	return 0;
 }
 
 // synchronous request completion model

--
