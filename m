Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750891AbWIUA7M@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750891AbWIUA7M (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 20 Sep 2006 20:59:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750899AbWIUA7L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 20 Sep 2006 20:59:11 -0400
Received: from tinc.cathedrallabs.org ([72.9.252.66]:3013 "EHLO
	tinc.cathedrallabs.org") by vger.kernel.org with ESMTP
	id S1750891AbWIUA7K (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 20 Sep 2006 20:59:10 -0400
Date: Wed, 20 Sep 2006 21:56:47 -0300
From: Aristeu Sergio Rozanski Filho <aris@cathedrallabs.org>
To: Michael Hanselmann <linux-kernel@hansmi.ch>
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ams: check return values from device_create_file()
Message-ID: <20060921005647.GC16002@cathedrallabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
X-Spam-Pyzor-Results: Reported 0 times.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch changes ams driver in order to check device_create_file()
return values and simplifies ams_sensor_attach().
Andrew, I've been using this driver for a while (not with -mm, but
applying individual patches on latest -linus daily) and never had
problems.

Signed-off-by: Aristeu S. Rozanski F. <aris@cathedrallabs.org>

--- mm.orig/drivers/hwmon/ams/ams-core.c	2006-09-20 21:04:57.000000000 -0300
+++ mm/drivers/hwmon/ams/ams-core.c	2006-09-20 21:12:46.000000000 -0300
@@ -163,28 +163,37 @@
 	result = pmf_register_irq_client(ams_info.of_node,
 			"accel-int-2",
 			&ams_shock_client);
-	if (result < 0) {
-		pmf_unregister_irq_client(&ams_freefall_client);
-		return -ENODEV;
-	}
+	if (result < 0)
+		goto release_freefall;
 
 	/* Create device */
 	ams_info.of_dev = of_platform_device_create(ams_info.of_node, "ams", NULL);
-	if (!ams_info.of_dev) {
-		pmf_unregister_irq_client(&ams_shock_client);
-		pmf_unregister_irq_client(&ams_freefall_client);
-		return -ENODEV;
-	}
+	if (!ams_info.of_dev)
+		goto release_shock;
 
 	/* Create attributes */
-	device_create_file(&ams_info.of_dev->dev, &dev_attr_current);
+	result = device_create_file(&ams_info.of_dev->dev, &dev_attr_current);
+	if (result)
+		goto release_of;
 
 	ams_info.vflag = !!(ams_info.get_vendor() & 0x10);
 
 	/* Init mouse device */
-	ams_mouse_init();
-
-	return 0;
+	result = ams_mouse_init();
+	if (result)
+		goto release_device_file;
+
+out:
+	return result;
+release_device_file:
+	device_remove_file(&ams_info.of_dev->dev, &dev_attr_current);
+release_of:
+	of_device_unregister(ams_info.of_dev);
+release_shock:
+	pmf_unregister_irq_client(&ams_freefall_client);
+release_freefall:
+	pmf_unregister_irq_client(&ams_freefall_client);
+	goto out;
 }
 
 int __init ams_init(void)
--- mm.orig/drivers/hwmon/ams/ams-mouse.c	2006-09-20 21:07:26.000000000 -0300
+++ mm/drivers/hwmon/ams/ams-mouse.c	2006-09-20 21:08:50.000000000 -0300
@@ -127,12 +127,15 @@
 	ams_mouse_show_mouse, ams_mouse_store_mouse);
 
 /* Call with ams_info.lock held! */
-void ams_mouse_init()
+int ams_mouse_init(void)
 {
-	device_create_file(&ams_info.of_dev->dev, &dev_attr_mouse);
+	int result;
 
-	if (mouse)
+	result = device_create_file(&ams_info.of_dev->dev, &dev_attr_mouse);
+
+	if (!result && mouse)
 		ams_mouse_enable();
+	return result;
 }
 
 /* Call with ams_info.lock held! */
