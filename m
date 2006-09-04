Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932293AbWIDFYl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932293AbWIDFYl (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Sep 2006 01:24:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932295AbWIDFYl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Sep 2006 01:24:41 -0400
Received: from smtp107.sbc.mail.mud.yahoo.com ([68.142.198.206]:11885 "HELO
	smtp107.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S932293AbWIDFYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Sep 2006 01:24:40 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:Received:From:To:Subject:Date:User-Agent:Cc:References:In-Reply-To:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=EatCF3ck6c4OKYQPyKPtCQsoNMAT1AunXW4l2ioulCy57NaiZSGAkU/9l7H3jmYQVKCwne0ZuYhz/ogxDddpg+Yq0OPKk0YT/QGOtLmV3oCS07zD7zdeZQHQRmUthdTIgtiGGAZnDYW5KNb6IrzZmW8U/8q+Kgcq/R/B3Od/y9Y=  ;
From: David Brownell <david-b@pacbell.net>
To: linux-kernel@vger.kernel.org, Dmitry Torokhov <dtor@insightbb.com>
Subject: Re: [patch/RFC 2.6.18-rc] platform_device_probe(), to conserve memory
Date: Sun, 3 Sep 2006 22:24:27 -0700
User-Agent: KMail/1.7.1
Cc: Russell King <rmk@arm.linux.org.uk>, Greg KH <greg@kroah.com>
References: <200609031823.05560.david-b@pacbell.net>
In-Reply-To: <200609031823.05560.david-b@pacbell.net>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200609032224.28303.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This defines a new platform_driver_probe() method allowing the driver's
probe() method, and its support code+data, to safely live in __init
sections for typical system configurations.

Many system-on-chip processors could benefit from this API to the tune
of saving hundreds to thousands of bytes per driver, which is currently
wasted holding code which can never be called after system startup yet
can not be removed.   It can't be removed because of linkage requirement
that pointers to init section code (like, ideally, probe support) must
not live in sections that persist after that section is removed (like
driver methods) when those pointers would be invalid.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>
---
Updated -- now forces probe failure after the probe() is gone, so that
the /sys/bus/platform/drivers/*/bind attribute can't break anything.
(Maybe that should be used whenever a driver has no probe routine...)

Index: g26/include/linux/platform_device.h
===================================================================
--- g26.orig/include/linux/platform_device.h	2006-09-03 13:02:23.000000000 -0700
+++ g26/include/linux/platform_device.h	2006-09-03 19:39:23.000000000 -0700
@@ -58,6 +58,12 @@ struct platform_driver {
 extern int platform_driver_register(struct platform_driver *);
 extern void platform_driver_unregister(struct platform_driver *);
 
+/* non-hotpluggable platform devices may use this so that probe() and
+ * its support may live in __init sections, conserving runtime memory.
+ */
+extern int platform_driver_probe(struct platform_driver *driver,
+		int (*probe)(struct platform_device *));
+
 #define platform_get_drvdata(_dev)	dev_get_drvdata(&(_dev)->dev)
 #define platform_set_drvdata(_dev,data)	dev_set_drvdata(&(_dev)->dev, (data))
 
Index: g26/drivers/base/platform.c
===================================================================
--- g26.orig/drivers/base/platform.c	2006-09-03 13:02:23.000000000 -0700
+++ g26/drivers/base/platform.c	2006-09-03 19:56:20.000000000 -0700
@@ -388,6 +388,11 @@ static int platform_drv_probe(struct dev
 	return drv->probe(dev);
 }
 
+static int platform_drv_probe_fail(struct device *_dev)
+{
+	return -ENXIO;
+}
+
 static int platform_drv_remove(struct device *_dev)
 {
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
@@ -451,6 +456,52 @@ void platform_driver_unregister(struct p
 }
 EXPORT_SYMBOL_GPL(platform_driver_unregister);
 
+/**
+ * platform_driver_probe - register driver for non-hotpluggable device
+ * @drv: platform driver structure
+ * @probe: the driver probe routine, probably from an __init section
+ *
+ * Use this instead of platform_driver_register() when you know the device
+ * is not hotpluggable and has already been registered, and you want to
+ * remove its run-once probe() infrastructure from memory after the driver
+ * has bound to the device.
+ *
+ * One typical use for this would be with drivers for controllers integrated
+ * into system-on-chip processors, where the controller devices have been
+ * configured as part of board setup.
+ *
+ * Returns zero if the driver registered and bound to a device, else returns
+ * a negative error code and with the driver not registered.
+ */
+int platform_driver_probe(struct platform_driver *drv,
+		int (*probe)(struct platform_device *))
+{
+	int retval;
+
+	/* temporary section violation */
+	drv->probe = probe;
+
+	retval = platform_driver_register(drv);
+	if (retval)
+		return retval;
+
+	/* Fixup that section violation, being paranoid about code scanning
+	 * the list of drivers in order to probe new devices.  Check to see
+	 * if the probe was successful, and make sure any forced probes of
+	 * new devices fail.
+	 */
+	spin_lock(&platform_bus_type.klist_drivers.k_lock);
+	drv->driver.probe = platform_drv_probe_fail;
+	drv->probe = NULL;
+	if (list_empty(&drv->driver.klist_devices.k_list))
+		retval = -ENODEV;
+	spin_unlock(&platform_bus_type.klist_drivers.k_lock);
+
+	if (retval)
+		platform_driver_unregister(drv);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(platform_driver_probe);
 
 /* modalias support enables more hands-off userspace setup:
  * (a) environment variable lets new-style hotplug events work once system is

-- 
VGER BF report: H 1.23077e-10
