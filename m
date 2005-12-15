Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161144AbVLOGA1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161144AbVLOGA1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Dec 2005 01:00:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161141AbVLOGA1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Dec 2005 01:00:27 -0500
Received: from smtp112.sbc.mail.re2.yahoo.com ([68.142.229.93]:38748 "HELO
	smtp112.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S1161144AbVLOGA0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Dec 2005 01:00:26 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: LKML <linux-kernel@vger.kernel.org>
Subject: [PATCH] hdaps: convert to the new platform device interface
Date: Thu, 15 Dec 2005 01:00:22 -0500
User-Agent: KMail/1.8.3
Cc: LM Sensors <lm-sensors@lm-sensors.org>, Jean Delvare <khali@linux-fr.org>,
       Robert Love <rml@novell.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512150100.23541.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The following patch converts hdaps driver to the new platform device
interface and allows using driver's "bind" and "unbind" attributes to
dynamically activate and deactivate hdaps support even if driver is
not modular.

The patch is compile-tested only, I do not have the hardware to verify
that ot still runs.

-- 
Dmitry

hdaps: convert to the new platform device interface

Do not use platform_device_register_simple() as it is going away,
extend ->probe() and ->remove() functions so manual binding and
unbinding will work with this driver.

Signed-off-by: Dmitry Torokhov <dtor@mail.ru>
---

 drivers/hwmon/hdaps.c |  198 +++++++++++++++++++++++++++-----------------------
 1 files changed, 107 insertions(+), 91 deletions(-)

Index: work/drivers/hwmon/hdaps.c
===================================================================
--- work.orig/drivers/hwmon/hdaps.c
+++ work/drivers/hwmon/hdaps.c
@@ -36,7 +36,7 @@
 #include <asm/io.h>
 
 #define HDAPS_LOW_PORT		0x1600	/* first port used by hdaps */
-#define HDAPS_NR_PORTS		0x30	/* number of ports: 0x1600 - 0x162f */
+#define HDAPS_HI_PORT		0x162f	/* last port used by hdaps */
 
 #define HDAPS_PORT_STATE	0x1611	/* device state */
 #define HDAPS_PORT_YPOS		0x1612	/* y-axis position */
@@ -62,6 +62,12 @@
 #define HDAPS_INPUT_FUZZ	4	/* input event threshold */
 #define HDAPS_INPUT_FLAT	4
 
+static struct resource __initdata hdaps_iores = {
+	.flags	= IORESOURCE_IO,
+	.start	= HDAPS_LOW_PORT,
+	.end	= HDAPS_HI_PORT,
+};
+
 static struct timer_list hdaps_timer;
 static struct platform_device *pdev;
 static struct input_dev *hdaps_idev;
@@ -284,34 +290,6 @@ out:
 }
 
 
-/* Device model stuff */
-
-static int hdaps_probe(struct platform_device *dev)
-{
-	int ret;
-
-	ret = hdaps_device_init();
-	if (ret)
-		return ret;
-
-	printk(KERN_INFO "hdaps: device successfully initialized.\n");
-	return 0;
-}
-
-static int hdaps_resume(struct platform_device *dev)
-{
-	return hdaps_device_init();
-}
-
-static struct platform_driver hdaps_driver = {
-	.probe = hdaps_probe,
-	.resume = hdaps_resume,
-	.driver	= {
-		.name = "hdaps",
-		.owner = THIS_MODULE,
-	},
-};
-
 /*
  * hdaps_calibrate - Set our "resting" values.  Callers must hold hdaps_sem.
  */
@@ -320,13 +298,13 @@ static void hdaps_calibrate(void)
 	__hdaps_read_pair(HDAPS_PORT_XPOS, HDAPS_PORT_YPOS, &rest_x, &rest_y);
 }
 
-static void hdaps_mousedev_poll(unsigned long unused)
+static void hdaps_inputdev_poll(unsigned long unused)
 {
 	int x, y;
 
 	/* Cannot sleep.  Try nonblockingly.  If we fail, try again later. */
 	if (down_trylock(&hdaps_sem)) {
-		mod_timer(&hdaps_timer,jiffies + HDAPS_POLL_PERIOD);
+		mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
 		return;
 	}
 
@@ -339,7 +317,7 @@ static void hdaps_mousedev_poll(unsigned
 
 	mod_timer(&hdaps_timer, jiffies + HDAPS_POLL_PERIOD);
 
-out:
+ out:
 	up(&hdaps_sem);
 }
 
@@ -473,6 +451,80 @@ static struct attribute_group hdaps_attr
 	.attrs = hdaps_attributes,
 };
 
+/* Device model stuff */
+
+static int __devinit hdaps_probe(struct platform_device *dev)
+{
+	int error;
+
+	/* initial calibrate for the input device */
+	hdaps_calibrate();
+
+	hdaps_idev = input_allocate_device();
+	if (!hdaps_idev)
+		return -ENOMEM;
+
+	/* initialize the input class */
+	hdaps_idev->name = "hdaps";
+	hdaps_idev->phys = "hdaps/input0";
+	hdaps_idev->cdev.dev = &dev->dev;
+	hdaps_idev->evbit[0] = BIT(EV_ABS);
+	input_set_abs_params(hdaps_idev, ABS_X,
+			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
+	input_set_abs_params(hdaps_idev, ABS_Y,
+			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
+
+	error = sysfs_create_group(&pdev->dev.kobj, &hdaps_attribute_group);
+	if (error)
+		goto err_free_input_dev;
+
+	error = hdaps_device_init();
+	if (error)
+		goto err_sysfs_remove_group;
+
+	error = input_register_device(hdaps_idev);
+	if (error)
+		goto err_sysfs_remove_group;
+
+	/* start up our timer for the input device */
+	init_timer(&hdaps_timer);
+	hdaps_timer.function = hdaps_inputdev_poll;
+	hdaps_timer.expires = jiffies + HDAPS_POLL_PERIOD;
+	add_timer(&hdaps_timer);
+
+	return 0;
+
+ err_free_input_dev:
+	input_free_device(hdaps_idev);
+ err_sysfs_remove_group:
+	sysfs_remove_group(&dev->dev.kobj, &hdaps_attribute_group);
+	return error;
+}
+
+static int __devexit hdaps_remove(struct platform_device *dev)
+{
+	del_timer_sync(&hdaps_timer);
+	input_unregister_device(hdaps_idev);
+	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
+
+	return 0;
+}
+
+static int hdaps_resume(struct platform_device *dev)
+{
+	return hdaps_device_init();
+}
+
+static struct platform_driver hdaps_driver = {
+	.driver		= {
+		.name	= "hdaps",
+		.owner	= THIS_MODULE,
+	},
+	.probe		= hdaps_probe,
+	.remove		= __devexit_p(hdaps_remove),
+	.resume		= hdaps_resume,
+};
+
 
 /* Module stuff */
 
@@ -511,7 +563,7 @@ static int hdaps_dmi_match_invert(struct
 
 static int __init hdaps_init(void)
 {
-	int ret;
+	int error;
 
 	/* Note that DMI_MATCH(...,"ThinkPad T42") will match "ThinkPad T42p" */
 	struct dmi_system_id hdaps_whitelist[] = {
@@ -532,79 +584,43 @@ static int __init hdaps_init(void)
 
 	if (!dmi_check_system(hdaps_whitelist)) {
 		printk(KERN_WARNING "hdaps: supported laptop not found!\n");
-		ret = -ENXIO;
-		goto out;
+		return -ENODEV;
 	}
 
-	if (!request_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS, "hdaps")) {
-		ret = -ENXIO;
-		goto out;
+	error = platform_driver_register(&hdaps_driver);
+	if (error)
+		return error;
+
+	pdev = platform_device_alloc("hdaps", -1);
+	if (!pdev) {
+		error = -ENOMEM;
+		goto err_unregister_driver;
 	}
 
-	ret = platform_driver_register(&hdaps_driver);
-	if (ret)
-		goto out_region;
-
-	pdev = platform_device_register_simple("hdaps", -1, NULL, 0);
-	if (IS_ERR(pdev)) {
-		ret = PTR_ERR(pdev);
-		goto out_driver;
-	}
-
-	ret = sysfs_create_group(&pdev->dev.kobj, &hdaps_attribute_group);
-	if (ret)
-		goto out_device;
-
-	hdaps_idev = input_allocate_device();
-	if (!hdaps_idev) {
-		ret = -ENOMEM;
-		goto out_group;
-	}
-
-	/* initial calibrate for the input device */
-	hdaps_calibrate();
-
-	/* initialize the input class */
-	hdaps_idev->name = "hdaps";
-	hdaps_idev->cdev.dev = &pdev->dev;
-	hdaps_idev->evbit[0] = BIT(EV_ABS);
-	input_set_abs_params(hdaps_idev, ABS_X,
-			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
-	input_set_abs_params(hdaps_idev, ABS_Y,
-			-256, 256, HDAPS_INPUT_FUZZ, HDAPS_INPUT_FLAT);
-
-	input_register_device(hdaps_idev);
-
-	/* start up our timer for the input device */
-	init_timer(&hdaps_timer);
-	hdaps_timer.function = hdaps_mousedev_poll;
-	hdaps_timer.expires = jiffies + HDAPS_POLL_PERIOD;
-	add_timer(&hdaps_timer);
+	error = platform_device_add_resources(pdev, &hdaps_iores, 1);
+	if (error)
+		goto err_free_device;
+
+	error = platform_device_add(pdev);
+	if (error)
+		goto err_free_device;
 
 	printk(KERN_INFO "hdaps: driver successfully loaded.\n");
 	return 0;
 
-out_group:
-	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
-out_device:
-	platform_device_unregister(pdev);
-out_driver:
+ err_free_device:
+	platform_device_put(pdev);
+ err_unregister_driver:
 	platform_driver_unregister(&hdaps_driver);
-out_region:
-	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
-out:
-	printk(KERN_WARNING "hdaps: driver init failed (ret=%d)!\n", ret);
-	return ret;
+
+	printk(KERN_WARNING "hdaps: driver init failed (error=%d)!\n", error);
+	return error;
 }
 
 static void __exit hdaps_exit(void)
 {
-	del_timer_sync(&hdaps_timer);
-	input_unregister_device(hdaps_idev);
-	sysfs_remove_group(&pdev->dev.kobj, &hdaps_attribute_group);
 	platform_device_unregister(pdev);
 	platform_driver_unregister(&hdaps_driver);
-	release_region(HDAPS_LOW_PORT, HDAPS_NR_PORTS);
 
 	printk(KERN_INFO "hdaps: driver unloaded.\n");
 }


