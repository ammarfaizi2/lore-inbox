Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1162342AbWLAXZq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1162342AbWLAXZq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 1 Dec 2006 18:25:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1162279AbWLAXZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 1 Dec 2006 18:25:09 -0500
Received: from mx2.suse.de ([195.135.220.15]:61421 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1162237AbWLAXYL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 1 Dec 2006 18:24:11 -0500
From: Greg KH <greg@kroah.com>
To: linux-kernel@vger.kernel.org
Cc: David Brownell <david-b@pacbell.net>,
       David Brownell <dbrownell@users.sourceforge.net>,
       Greg Kroah-Hartman <gregkh@suse.de>
Subject: [PATCH 34/36] Driver core: platform_driver_probe(), can save codespace
Date: Fri,  1 Dec 2006 15:22:04 -0800
Message-Id: <1165015439206-git-send-email-greg@kroah.com>
X-Mailer: git-send-email 1.4.4.1
In-Reply-To: <11650154353407-git-send-email-greg@kroah.com>
References: <20061201231620.GA7560@kroah.com> <11650153262399-git-send-email-greg@kroah.com> <11650153293531-git-send-email-greg@kroah.com> <1165015333344-git-send-email-greg@kroah.com> <11650153362310-git-send-email-greg@kroah.com> <11650153392022-git-send-email-greg@kroah.com> <11650153432284-git-send-email-greg@kroah.com> <11650153463092-git-send-email-greg@kroah.com> <1165015349830-git-send-email-greg@kroah.com> <11650153522862-git-send-email-greg@kroah.com> <116501535622-git-send-email-greg@kroah.com> <11650153591876-git-send-email-greg@kroah.com> <11650153631070-git-send-email-greg@kroah.com> <1165015366759-git-send-email-greg@kroah.com> <11650153704007-git-send-email-greg@kroah.com> <11650153733277-git-send-email-greg@kroah.com> <11650153763330-git-send-email-greg@kroah.com> <11650153792132-git-send-email-greg@kroah.com> <11650153833896-git-send-email-greg@kroah.com> <11650153861854-git-send-email-greg@kroah.com> <11650153891878-git-send-email-greg@kroah.com> <11650153
 922117-git-send-email-greg@kroah.com> <11650153961479-git-send-email-greg@kroah.com> <11650154001320-git-send-email-greg@kroah.com> <11650154032080-git-send-email-greg@kroah.com> <11650154071138-git-send-email-greg@kroah.com> <11650154123942-git-send-email-greg@kroah.com> <1165015415131-git-send-email-greg@kroah.com> <11650154181661-git-send-email-greg@kroah.com> <11650154221716-git-send-email-greg@kroah.com> <11650154251022-git-send-email-greg@kroah.com> <11650154282911-git-send-email-greg@kroah.com> <11650154311175-git-send-email-greg@kroah.com> <11650154353407-git-send-email-greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Brownell <david-b@pacbell.net>

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
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/base/platform.c         |   48 +++++++++++++++++++++++++++++++++++++++
 include/linux/platform_device.h |    6 +++++
 2 files changed, 54 insertions(+), 0 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 940ce41..d1df4a0 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
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
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index 29cd6de..20f47b8 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
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
 
-- 
1.4.4.1

