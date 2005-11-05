Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932125AbVKESMX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932125AbVKESMX (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Nov 2005 13:12:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932134AbVKESMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Nov 2005 13:12:23 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:35857 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932125AbVKESMX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Nov 2005 13:12:23 -0500
Date: Sat, 5 Nov 2005 18:12:17 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [DRIVER MODEL] Add platform_driver
Message-ID: <20051105181217.GA14419@flint.arm.linux.org.uk>
Mail-Followup-To: Linux Kernel List <linux-kernel@vger.kernel.org>
References: <20051105181122.GD12228@flint.arm.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051105181122.GD12228@flint.arm.linux.org.uk>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce struct platform_driver.  This allows the platform device
driver methods to be passed a platform_device structure instead of
instead of a plain device structure, and therefore requiring casting
in every platform driver.

We introduce this in such a way that any existing platform drivers
registered directly via driver_register continue to work as before,
thereby allowing a gradual conversion to the new platform_driver
methods.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>

diff -u b/drivers/base/platform.c b/drivers/base/platform.c
--- b/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -20,6 +20,8 @@
 
 #include "base.h"
 
+#define to_platform_driver(drv)	(container_of((drv), struct platform_driver, driver))
+
 struct device platform_bus = {
 	.bus_id		= "platform",
 };
@@ -354,6 +356,77 @@
 	return ERR_PTR(retval);
 }
 
+static int platform_drv_probe(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+
+	return drv->probe(dev);
+}
+
+static int platform_drv_remove(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+
+	return drv->remove(dev);
+}
+
+static void platform_drv_shutdown(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+
+	drv->shutdown(dev);
+}
+
+static int platform_drv_suspend(struct device *_dev, pm_message_t state)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+
+	return drv->suspend(dev, state);
+}
+
+static int platform_drv_resume(struct device *_dev)
+{
+	struct platform_driver *drv = to_platform_driver(_dev->driver);
+	struct platform_device *dev = to_platform_device(_dev);
+
+	return drv->resume(dev);
+}
+
+/**
+ *	platform_driver_register
+ *	@drv: platform driver structure
+ */
+int platform_driver_register(struct platform_driver *drv)
+{
+	drv->driver.bus = &platform_bus_type;
+	if (drv->probe)
+		drv->driver.probe = platform_drv_probe;
+	if (drv->remove)
+		drv->driver.remove = platform_drv_remove;
+	if (drv->shutdown)
+		drv->driver.shutdown = platform_drv_shutdown;
+	if (drv->suspend)
+		drv->driver.suspend = platform_drv_suspend;
+	if (drv->resume)
+		drv->driver.resume = platform_drv_resume;
+	return driver_register(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(platform_driver_register);
+
+/**
+ *	platform_driver_unregister
+ *	@drv: platform driver structure
+ */
+void platform_driver_unregister(struct platform_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(platform_driver_unregister);
+
 
 /**
  *	platform_match - bind platform device to platform driver.
diff -u b/include/linux/platform_device.h b/include/linux/platform_device.h
--- b/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -43,4 +43,19 @@
 extern int platform_device_add(struct platform_device *pdev);
 extern void platform_device_put(struct platform_device *pdev);
 
+struct platform_driver {
+	int (*probe)(struct platform_device *);
+	int (*remove)(struct platform_device *);
+	void (*shutdown)(struct platform_device *);
+	int (*suspend)(struct platform_device *, pm_message_t state);
+	int (*resume)(struct platform_device *);
+	struct device_driver driver;
+};
+
+extern int platform_driver_register(struct platform_driver *);
+extern void platform_driver_unregister(struct platform_driver *);
+
+#define platform_get_drvdata(_dev)	dev_get_drvdata(&(_dev)->dev)
+#define platform_set_drvdata(_dev,data)	dev_set_drvdata(&(_dev)->dev, (data))
+
 #endif /* _PLATFORM_DEVICE_H_ */


-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
