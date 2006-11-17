Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1755620AbWKQJgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755620AbWKQJgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Nov 2006 04:36:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755615AbWKQJgt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Nov 2006 04:36:49 -0500
Received: from smtp112.sbc.mail.mud.yahoo.com ([68.142.198.211]:56704 "HELO
	smtp112.sbc.mail.mud.yahoo.com") by vger.kernel.org with SMTP
	id S1755619AbWKQJgW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Nov 2006 04:36:22 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=s1024; d=pacbell.net;
  h=Received:X-YMail-OSG:From:To:Subject:Date:User-Agent:MIME-Version:Content-Type:Content-Transfer-Encoding:Content-Disposition:Message-Id;
  b=Y6lMrgvWF2FQVU3DfXHq5gy/oEQ2vQaq2AZ82pzBKVSGUAOTA547u1zS8Xn3rtoLiAlPsqsaLNP7+US6cTx5VcC1B9yZVLoPqDy8lJiEnAzC7SWYln6lIveKI1WtbHBdoN5vA5aXDAb0sBQrPP5ytNRfxLdDEk0LtcVISB+HYC8=  ;
X-YMail-OSG: 5xGKZcgVM1ncnndXKkEICoCnAQvGXaiwJDZ3tPjfHhikx_LYtrUA8UFp0aL9ESUNd_g0DvRPhvTAFGky59xZXeznBpLWn8kxQE1H3MGE6xZLGcYv0B6gc.tvBRM_IfBcHLPuEL41CfnMGxg8j9ca2T8Hmpfc4o__Fao-
From: David Brownell <david-b@pacbell.net>
To: Greg KH <greg@kroah.com>, Linux Kernel list <linux-kernel@vger.kernel.org>
Subject: [patch 2.6.19-rc6] platform_driver_probe(), can save codespace
Date: Thu, 16 Nov 2006 23:28:47 -0800
User-Agent: KMail/1.7.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200611162328.47987.david-b@pacbell.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This defines a new platform_driver_probe() method allowing the driver's
probe() method, and its support code+data, to safely live in __init
sections for typical system configurations.

Many system-on-chip processors could benefit from this API, to the tune
of recovering hundreds to thousands of bytes per driver.  That's memory
which is currently wasted holding code which can never be called after
system startup, yet can not be removed.   It can't be removed because of
the linkage requirement that pointers to init section code (like, ideally,
probe support) must not live in other sections (like driver method tables)
after those pointers would be invalid.

Signed-off-by: David Brownell <dbrownell@users.sourceforge.net>

Index: g26/include/linux/platform_device.h
===================================================================
--- g26.orig/include/linux/platform_device.h	2006-11-16 18:19:43.000000000 -0800
+++ g26/include/linux/platform_device.h	2006-11-16 18:51:02.000000000 -0800
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
--- g26.orig/drivers/base/platform.c	2006-11-16 18:19:43.000000000 -0800
+++ g26/drivers/base/platform.c	2006-11-16 23:23:53.000000000 -0800
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
@@ -451,6 +456,49 @@ void platform_driver_unregister(struct p
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
+	int retval, code;
+
+	/* temporary section violation during probe() */
+	drv->probe = probe;
+	retval = code = platform_driver_register(drv);
+
+	/* Fixup that section violation, being paranoid about code scanning
+	 * the list of drivers in order to probe new devices.  Check to see
+	 * if the probe was successful, and make sure any forced probes of
+	 * new devices fail.
+	 */
+	spin_lock(&platform_bus_type.klist_drivers.k_lock);
+	drv->probe = NULL;
+	if (code == 0 && list_empty(&drv->driver.klist_devices.k_list))
+		retval = -ENODEV;
+	drv->driver.probe = platform_drv_probe_fail;
+	spin_unlock(&platform_bus_type.klist_drivers.k_lock);
+
+	if (code != retval)
+		platform_driver_unregister(drv);
+	return retval;
+}
+EXPORT_SYMBOL_GPL(platform_driver_probe);
 
 /* modalias support enables more hands-off userspace setup:
  * (a) environment variable lets new-style hotplug events work once system is
