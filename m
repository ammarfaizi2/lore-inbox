Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261191AbVCaIco@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261191AbVCaIco (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Mar 2005 03:32:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261174AbVCaIco
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Mar 2005 03:32:44 -0500
Received: from mail.kroah.org ([69.55.234.183]:58529 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261192AbVCaI21 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Mar 2005 03:28:27 -0500
Date: Thu, 31 Mar 2005 00:28:14 -0800
From: Greg KH <gregkh@suse.de>
To: Patrick Mochel <mochel@digitalimplant.org>, Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: syslog loves the new driver core code
Message-ID: <20050331082814.GA26668@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew pointed out to me that the new driver core code spewes a lot of
stuff in the syslog for every device it tries to match up with a driver
(if you look closely, it seems that the if check in __device_attach()
will never not trigger...)

Everything still seems to work properly, but it's good if we don't alarm
people with messages that are incorrect and unneeded. :)

So, here's a patch that seems to work for me.  It stops trying to loop
through drivers or devices once it finds a match, and it only tells the
syslog when we have a real error.

Look acceptable to you?

thanks,

greg k-h

-----------
Driver core: Fix up the driver and device iterators to be quieter

Also stops looping over the lists when a match is found.

Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>

--- 1.4/drivers/base/dd.c	2005-03-25 09:52:38 -08:00
+++ edited/drivers/base/dd.c	2005-03-31 00:22:50 -08:00
@@ -91,20 +91,23 @@ static int __device_attach(struct device
 	int error;
 
 	error = driver_probe_device(drv, dev);
-
-	if (error == -ENODEV && error == -ENXIO) {
-		/* Driver matched, but didn't support device 
-		 * or device not found.
-		 * Not an error; keep going.
-		 */
-		error = 0;
-	} else {
-		/* driver matched but the probe failed */
-		printk(KERN_WARNING
-		       "%s: probe of %s failed with error %d\n",
-		       drv->name, dev->bus_id, error);
+	if (error) {
+		if ((error == -ENODEV) || (error == -ENXIO)) {
+			/* Driver matched, but didn't support device 
+			 * or device not found.
+			 * Not an error; keep going.
+			 */
+			error = 0;
+		} else {
+			/* driver matched but the probe failed */
+			printk(KERN_WARNING
+			       "%s: probe of %s failed with error %d\n",
+			       drv->name, dev->bus_id, error);
+		}
+		return error;
 	}
-	return 0;
+	/* stop looking, this device is attached */
+	return 1;
 }
 
 
@@ -142,7 +145,10 @@ static int __driver_attach(struct device
 				       drv->name, dev->bus_id, error);
 			} else
 				error = 0;
+			return error;
 		}
+		/* stop looking, this driver is attached */
+		return 1;
 	}
 	return 0;
 }
