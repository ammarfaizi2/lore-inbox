Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966486AbWKUVui@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966486AbWKUVui (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Nov 2006 16:50:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966478AbWKUVui
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Nov 2006 16:50:38 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:37056 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S966486AbWKUVug (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Nov 2006 16:50:36 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 21 Nov 2006 22:50:02 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: [PATCH] ieee1394: nodemgr: fix deadlock in shutdown
To: linux1394-devel@lists.sourceforge.net
cc: Alan Stern <stern@rowland.harvard.edu>,
       Greg Kroah-Hartman <gregkh@suse.de>, linux-kernel@vger.kernel.org,
       Dmitry Torokhov <dtor@insightbb.com>
In-Reply-To: <4562B35C.7090807@s5r6.in-berlin.de>
Message-ID: <tkrat.fb60b517d907f89e@s5r6.in-berlin.de>
References: <Pine.LNX.4.44L0.0611201942270.30952-100000@netrider.rowland.org>
 <4562B35C.7090807@s5r6.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

If "modprobe ohci1394" was quickly followed by "modprobe -r ohci1394",
say with 1 second pause in between, the modprobe -r got stuck in
uninterruptible sleep in kthread_stop.  At the same time the knodemgrd
slept uninterruptibly in bus_rescan_devices_helper.  That's because
driver_detach took the semaphore of the PCI device and
bus_rescan_devices_helper wanted to take the semaphore of the FireWire
host device's parent, which is the same semaphore. This was a regression
since Linux 2.6.16, commit bf74ad5bc41727d5f2f1c6bedb2c1fac394de731,
"Hold the device's parent's lock during probe and remove".

The fix (or workaround) adds a dummy driver to the hpsb_host device. Now
bus_rescan_devices_helper won't scan the host device anymore.  This
doesn't hurt since we have no drivers which will bind to these devices
and it is unlikely that there will ever be such a driver.  The dummy
driver is befittingly presented as a representation of ieee1394 itself.

Fixes: http://bugzilla.kernel.org/show_bug.cgi?id=6706

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---

There is now a /sys/bus/ieee1394/drivers/ieee1394, whose "bind" and
"unbind" attributes are not welcome.  Is there a way to disable them?


 drivers/ieee1394/nodemgr.c |   21 ++++++++++++++++++---
 1 files changed, 18 insertions(+), 3 deletions(-)

Index: linux/drivers/ieee1394/nodemgr.c
===================================================================
--- linux.orig/drivers/ieee1394/nodemgr.c	2006-11-21 00:09:25.000000000 +0100
+++ linux/drivers/ieee1394/nodemgr.c	2006-11-21 22:32:09.000000000 +0100
@@ -14,6 +14,7 @@
 #include <linux/slab.h>
 #include <linux/delay.h>
 #include <linux/kthread.h>
+#include <linux/module.h>
 #include <linux/moduleparam.h>
 #include <asm/atomic.h>
 
@@ -259,9 +260,20 @@ static struct device nodemgr_dev_templat
 	.release	= nodemgr_release_ne,
 };
 
+/* This dummy driver prevents the host devices from being scanned. We have no
+ * useful drivers for them yet, and there would be a deadlock possible if the
+ * driver core scans the host device while the host's low-level driver (i.e.
+ * the host's parent device) is being removed. */
+static struct device_driver nodemgr_mid_layer_driver = {
+	.bus		= &ieee1394_bus_type,
+	.name		= "ieee1394",
+	.owner		= THIS_MODULE,
+};
+
 struct device nodemgr_dev_template_host = {
 	.bus		= &ieee1394_bus_type,
 	.release	= nodemgr_release_host,
+	.driver		= &nodemgr_mid_layer_driver,
 };
 
 
@@ -704,11 +716,14 @@ static int nodemgr_bus_match(struct devi
 		return 0;
 
 	ud = container_of(dev, struct unit_directory, device);
-	driver = container_of(drv, struct hpsb_protocol_driver, driver);
-
 	if (ud->ne->in_limbo || ud->ignore_driver)
 		return 0;
 
+	/* We only match drivers of type hpsb_protocol_driver */
+	if (drv == &nodemgr_mid_layer_driver)
+		return 0;
+
+	driver = container_of(drv, struct hpsb_protocol_driver, driver);
         for (id = driver->id_table; id->match_flags != 0; id++) {
                 if ((id->match_flags & IEEE1394_MATCH_VENDOR_ID) &&
                     id->vendor_id != ud->vendor_id)
@@ -1899,7 +1914,7 @@ int init_ieee1394_nodemgr(void)
 		class_unregister(&nodemgr_ne_class);
 		return error;
 	}
-
+	error = driver_register(&nodemgr_mid_layer_driver);
 	hpsb_register_highlevel(&nodemgr_highlevel);
 	return 0;
 }



