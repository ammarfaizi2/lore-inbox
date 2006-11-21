Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030565AbWKUAVe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030565AbWKUAVe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Nov 2006 19:21:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966889AbWKUAVe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Nov 2006 19:21:34 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:61315 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S966888AbWKUAVd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Nov 2006 19:21:33 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Date: Tue, 21 Nov 2006 01:21:19 +0100 (CET)
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: Re: deadlock in "modprobe -r ohci1394" shortly after "modprobe
 ohci1394"
To: Alan Stern <stern@rowland.harvard.edu>
cc: linux1394-devel@lists.sourceforge.net, Greg Kroah-Hartman <gregkh@suse.de>,
       linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@insightbb.com>
In-Reply-To: <Pine.LNX.4.44L0.0611201626390.7916-100000@iolanthe.rowland.org>
Message-ID: <tkrat.c6b0c0fdc1b83378@s5r6.in-berlin.de>
References: <456213F2.8070805@s5r6.in-berlin.de>
 <Pine.LNX.4.44L0.0611201626390.7916-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; CHARSET=us-ascii
Content-Disposition: INLINE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 20 Nov, Alan Stern wrote:
>> > Is the problem caused by the fact that some of these struct device's 
>> > aren't bound to a driver?  Remember, bus_rescan_devices() will skip over 
>> > anything that already has a driver.  Could you solve your problem by 
>> > adding a do_nothing driver that would bind to these otherwise unused 
>> > devices?

There are three minor problems with this approach:
 - some ballast in system memory for the dummy driver struct
 - the dummy driver is visible in sysfs
 - the (root) user can unbind the driver which will recreate the
   preconditions for the deadlock

Nevertheless, here is the patch. I find it ugly, maybe even more so than
my previous up(&dev->parent->sem) hack, but it works as you said.


From: Stefan Richter <stefanr@s5r6.in-berlin.de>
Subject: ieee1394: nodemgr: fix deadlock in shutdown

If "modprobe ohci1394" was quickly followed by "modprobe -r ohci1394",
say with 1 second pause in between, the modprobe -r got stuck in
uninterruptible sleep in kthread_stop.  At the same time the knodemgrd
slept uninterruptibly in bus_rescan_devices_helper.

This was a regression since Linux 2.6.16,
	commit bf74ad5bc41727d5f2f1c6bedb2c1fac394de731
	"Hold the device's parent's lock during probe and remove"

The fix (or rather workaround) adds a dummy driver to the hpsb_host
device.  Now bus_rescan_devices_helper won't scan it anymore.  This
doesn't hurt since we have no drivers which will bind to these devices
and it is unlikely that there will ever be such a driver.

Signed-off-by: Stefan Richter <stefanr@s5r6.in-berlin.de>
---
 drivers/ieee1394/nodemgr.c |   19 ++++++++++++++++---
 1 files changed, 16 insertions(+), 3 deletions(-)

Index: linux-2.6.19-rc4/drivers/ieee1394/nodemgr.c
===================================================================
--- linux-2.6.19-rc4.orig/drivers/ieee1394/nodemgr.c	2006-11-21 00:09:25.000000000 +0100
+++ linux-2.6.19-rc4/drivers/ieee1394/nodemgr.c	2006-11-21 01:00:28.000000000 +0100
@@ -259,9 +259,19 @@ static struct device nodemgr_dev_templat
 	.release	= nodemgr_release_ne,
 };
 
+/* The dummy driver prevents the host devices from being scanned. We have no
+ * useful drivers for them yet, and there is a deadlock possible if the driver
+ * core scans the host device while the host's low-level driver, i.e. the host's
+ * parent device, is being removed. */
+static struct device_driver nodemgr_dev_dummy_driver = {
+	.bus		= &ieee1394_bus_type,
+	.name		= "none",
+};
+
 struct device nodemgr_dev_template_host = {
 	.bus		= &ieee1394_bus_type,
 	.release	= nodemgr_release_host,
+	.driver		= &nodemgr_dev_dummy_driver,
 };
 
 
@@ -703,12 +713,15 @@ static int nodemgr_bus_match(struct devi
 	if (dev->platform_data != &nodemgr_ud_platform_data)
 		return 0;
 
-	ud = container_of(dev, struct unit_directory, device);
-	driver = container_of(drv, struct hpsb_protocol_driver, driver);
+	/* The dummy driver is not wrapped in a hpsb_protocol_driver */
+	if (drv == &nodemgr_dev_dummy_driver)
+		return 0;
 
+	ud = container_of(dev, struct unit_directory, device);
 	if (ud->ne->in_limbo || ud->ignore_driver)
 		return 0;
 
+	driver = container_of(drv, struct hpsb_protocol_driver, driver);
         for (id = driver->id_table; id->match_flags != 0; id++) {
                 if ((id->match_flags & IEEE1394_MATCH_VENDOR_ID) &&
                     id->vendor_id != ud->vendor_id)
@@ -1899,7 +1912,7 @@ int init_ieee1394_nodemgr(void)
 		class_unregister(&nodemgr_ne_class);
 		return error;
 	}
-
+	error = driver_register(&nodemgr_dev_dummy_driver);
 	hpsb_register_highlevel(&nodemgr_highlevel);
 	return 0;
 }



-- 
Stefan Richter
-=====-=-==- =-== =-=-=
http://arcgraph.de/sr/

