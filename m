Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262100AbUC1HNL (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 02:13:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262101AbUC1HNL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 02:13:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:19408 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262100AbUC1HNG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 02:13:06 -0500
Date: Sat, 27 Mar 2004 23:12:47 -0800
From: Greg KH <greg@kroah.com>
To: torvalds@osdl.org
Cc: Andrew Morton <akpm@osdl.org>, stern@rowland.harvard.edu,
       linux-usb-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] USB: Eliminate wait following interface unregistration
Message-ID: <20040328071247.GA6773@kroah.com>
References: <Pine.LNX.4.44L0.0403272249300.4020-100000@netrider.rowland.org> <20040328061935.GA6605@kroah.com> <20040327223848.23d38d2a.akpm@osdl.org> <20040328064405.GA6451@kroah.com> <20040328065327.GA6717@kroah.com> <20040327230634.5642c6ad.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040327230634.5642c6ad.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch from Alan Stern <stern@rowland.harvard.edu> fixes a
bug in the current USB code that causes khubd to hang when a device is
removed from the system, thereby preventing any future USB device
changes (like adding or removing other devices) from happening.

Both Andrew and I can easily duplicate this bug against the current -bk
tree.

It's not a perfect fix, but it works for now, and I will spend the next
week working on restructuring the code so this is handled properly.

thanks,

greg k-h

--- 1.73/drivers/usb/core/message.c	Wed Mar 17 14:16:47 2004
+++ edited/drivers/usb/core/message.c	Wed Mar 24 10:17:04 2004
@@ -794,9 +794,6 @@
 
 static void release_interface(struct device *dev)
 {
-	struct usb_interface *interface = to_usb_interface(dev);
-
-	complete(interface->released);
 }
 
 /*
@@ -828,16 +825,12 @@
 	if (dev->actconfig) {
 		for (i = 0; i < dev->actconfig->desc.bNumInterfaces; i++) {
 			struct usb_interface	*interface;
-			struct completion	intf_completion;
 
 			/* remove this interface */
 			interface = dev->actconfig->interface[i];
 			dev_dbg (&dev->dev, "unregistering interface %s\n",
 				interface->dev.bus_id);
-			init_completion (&intf_completion);
-			interface->released = &intf_completion;
 			device_unregister (&interface->dev);
-			wait_for_completion (&intf_completion);
 		}
 		dev->actconfig = 0;
 		if (dev->state == USB_STATE_CONFIGURED)


