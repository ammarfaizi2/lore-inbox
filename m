Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbTJWPLy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Oct 2003 11:11:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263628AbTJWPLy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Oct 2003 11:11:54 -0400
Received: from [192.58.206.9] ([192.58.206.9]:64137 "EHLO crl-mail.crl.dec.com")
	by vger.kernel.org with ESMTP id S263626AbTJWPLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Oct 2003 11:11:51 -0400
Message-ID: <3F97EF84.2060901@hp.com>
Date: Thu, 23 Oct 2003 11:11:00 -0400
From: Jamey Hicks <jamey.hicks@hp.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030630
X-Accept-Language: en-us, en, es
MIME-Version: 1.0
To: mochel@osdl.org
CC: linux-kernel@vger.kernel.org
Subject: PATCH: rename legacy bus to platform bus
X-Enigmail-Version: 0.76.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: multipart/mixed;
 boundary="------------040505080003010305080305"
X-HPLC-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-MailScanner-SpamCheck: not spam (whitelisted), SpamAssassin (score=-4.9,
	required 5, BAYES_00 -4.90)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------040505080003010305080305
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit


Many of us, especially in the embedded computing world, think that 
"legacy bus" is a misnomer.  It's not going away.  What do root PCI 
buses connect to?  At the root of the device tree there is a bus.  This 
patch changes the name from legacy bus to platform bus.  I'm hoping this 
change can be made even this late in the development cycle.  It is a 
pretty small patch but I think that naming is very important.

-Jamey Hicks




--------------040505080003010305080305
Content-Type: text/plain;
 name="platform-bus.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="platform-bus.patch"

--- linux-2.6.0-test8-rmk1/drivers/base/platform.c	2003-09-27 20:50:09.000000000 -0400
+++ kernel26/drivers/base/platform.c	2003-10-23 10:50:03.226877352 -0400
@@ -14,8 +14,8 @@
 #include <linux/module.h>
 #include <linux/init.h>
 
-struct device legacy_bus = {
-	.bus_id		= "legacy",
+struct device platform_bus = {
+	.bus_id		= "platform",
 };
 
 /**
@@ -29,7 +29,7 @@
 		return -EINVAL;
 
 	if (!pdev->dev.parent)
-		pdev->dev.parent = &legacy_bus;
+		pdev->dev.parent = &platform_bus;
 
 	pdev->dev.bus = &platform_bus_type;
 	
@@ -105,12 +105,12 @@
 
 int __init platform_bus_init(void)
 {
-	device_register(&legacy_bus);
+	device_register(&platform_bus);
 	return bus_register(&platform_bus_type);
 }
 
-EXPORT_SYMBOL(legacy_bus);
+EXPORT_SYMBOL(platform_bus);
 EXPORT_SYMBOL(platform_bus_type);
 EXPORT_SYMBOL(platform_device_register);
 EXPORT_SYMBOL(platform_device_unregister);
--- linux-2.6.0-test8-rmk1/drivers/i2c/i2c-core.c	2003-09-27 20:50:10.000000000 -0400
+++ kernel26/drivers/i2c/i2c-core.c	2003-10-23 10:51:52.070330632 -0400
@@ -136,11 +136,11 @@
 
 	/* Add the adapter to the driver core.
 	 * If the parent pointer is not set up,
-	 * we add this adapter to the legacy bus.
+	 * we add this adapter to the platform bus.
 	 */
 	if (adap->dev.parent == NULL)
-		adap->dev.parent = &legacy_bus;
+		adap->dev.parent = &platform_bus;
 	sprintf(adap->dev.bus_id, "i2c-%d", adap->nr);
 	adap->dev.driver = &i2c_adapter_driver;
 	adap->dev.release = &i2c_adapter_dev_release;
--- linux-2.6.0-test8-rmk1/drivers/i2c/i2c-dev.c	2003-10-19 23:23:05.000000000 -0400
+++ kernel26/drivers/i2c/i2c-dev.c	2003-10-23 10:52:08.964762288 -0400
@@ -447,8 +447,8 @@
 
 	/* register this i2c device with the driver core */
 	i2c_dev->adap = adap;
-	if (adap->dev.parent == &legacy_bus)
+	if (adap->dev.parent == &platform_bus)
 		i2c_dev->class_dev.dev = &adap->dev;
 	else
 		i2c_dev->class_dev.dev = adap->dev.parent;
--- linux-2.6.0-test8-rmk1/drivers/scsi/hosts.c	2003-09-27 20:50:07.000000000 -0400
+++ kernel26/drivers/scsi/hosts.c	2003-10-23 10:52:20.152061560 -0400
@@ -111,8 +111,8 @@
 	}
 
 	if (!shost->shost_gendev.parent)
-		shost->shost_gendev.parent = dev ? dev : &legacy_bus;
+		shost->shost_gendev.parent = dev ? dev : &platform_bus;
 
 	error = device_add(&shost->shost_gendev);
 	if (error)
--- linux-2.6.0-test8-rmk1/include/linux/device.h	2003-10-19 23:23:11.000000000 -0400
+++ kernel26/include/linux/device.h	2003-10-23 10:56:56.250088280 -0400
@@ -372,7 +372,7 @@
 extern void platform_device_unregister(struct platform_device *);
 
 extern struct bus_type platform_bus_type;
-extern struct device legacy_bus;
+extern struct device platform_bus;
 
 /* drivers/base/power.c */
 extern void device_shutdown(void);

--------------040505080003010305080305--

