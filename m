Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264585AbUENXnW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264585AbUENXnW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:43:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264569AbUENXmR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:42:17 -0400
Received: from mail.kroah.org ([65.200.24.183]:32997 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264585AbUENXaI convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:30:08 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773561979@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:16 -0700
Message-Id: <10845773561233@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.2, 2004/05/01 22:32:34-07:00, greg@kroah.com

I2C: rename i2c-ip4xx.c driver


 drivers/i2c/busses/i2c-ixp42x.c |  176 ----------------------------------------
 drivers/i2c/busses/i2c-ixp4xx.c |  176 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 176 insertions(+), 176 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ixp42x.c b/drivers/i2c/busses/i2c-ixp42x.c
--- a/drivers/i2c/busses/i2c-ixp42x.c	Fri May 14 16:21:22 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,176 +0,0 @@
-/*
- * drivers/i2c/i2c-adap-ixp42x.c
- *
- * Intel's IXP42x XScale NPU chipsets (IXP420, 421, 422, 425) do not have
- * an on board I2C controller but provide 16 GPIO pins that are often
- * used to create an I2C bus. This driver provides an i2c_adapter 
- * interface that plugs in under algo_bit and drives the GPIO pins
- * as instructed by the alogorithm driver.
- *
- * Author: Deepak Saxena <dsaxena@plexity.net>
- *
- * Copyright (c) 2003-2004 MontaVista Software Inc.
- *
- * This file is licensed under the terms of the GNU General Public 
- * License version 2. This program is licensed "as is" without any 
- * warranty of any kind, whether express or implied.
- *
- * NOTE: Since different platforms will use different GPIO pins for
- *       I2C, this driver uses an IXP42x-specific platform_data
- *       pointer to pass the GPIO numbers to the driver. This 
- *       allows us to support all the different IXP42x platforms
- *       w/o having to put #ifdefs in this driver.
- *
- *       See arch/arm/mach-ixp42x/ixdp425.c for an example of building a 
- *       device list and filling in the ixp42x_i2c_pins data structure 
- *       that is passed as the platform_data to this driver.
- */
-
-#include <linux/config.h>
-#include <linux/kernel.h>
-#include <linux/init.h>
-#include <linux/device.h>
-#include <linux/module.h>
-#include <linux/i2c.h>
-
-#include <asm/hardware.h>	/* Pick up IXP42x-specific bits */
-
-static inline int ixp42x_scl_pin(void *data)
-{
-	return ((struct ixp42x_i2c_pins*)data)->scl_pin;
-}
-
-static inline int ixp42x_sda_pin(void *data)
-{
-	return ((struct ixp42x_i2c_pins*)data)->sda_pin;
-}
-
-static void ixp42x_bit_setscl(void *data, int val)
-{
-	gpio_line_set(ixp42x_scl_pin(data), 0);
-	gpio_line_config(ixp42x_scl_pin(data),
-		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
-}
-
-static void ixp42x_bit_setsda(void *data, int val)
-{
-	gpio_line_set(ixp42x_sda_pin(data), 0);
-	gpio_line_config(ixp42x_sda_pin(data),
-		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
-}
-
-static int ixp42x_bit_getscl(void *data)
-{
-	int scl;
-
-	gpio_line_config(ixp42x_scl_pin(data), IXP425_GPIO_IN );
-	gpio_line_get(ixp42x_scl_pin(data), &scl);
-
-	return scl;
-}	
-
-static int ixp42x_bit_getsda(void *data)
-{
-	int sda;
-
-	gpio_line_config(ixp42x_sda_pin(data), IXP425_GPIO_IN );
-	gpio_line_get(ixp42x_sda_pin(data), &sda);
-
-	return sda;
-}	
-
-struct ixp42x_i2c_data {
-	struct ixp42x_i2c_pins *gpio_pins;
-	struct i2c_adapter adapter;
-	struct i2c_algo_bit_data algo_data;
-};
-
-static int ixp42x_i2c_remove(struct device *dev)
-{
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct ixp42x_i2c_data *drv_data = dev_get_drvdata(&plat_dev->dev);
-
-	dev_set_drvdata(&plat_dev->dev, NULL);
-
-	i2c_bit_del_bus(&drv_data->adapter);
-
-	kfree(drv_data);
-
-	return 0;
-}
-
-static int ixp42x_i2c_probe(struct device *dev)
-{
-	int err;
-	struct platform_device *plat_dev = to_platform_device(dev);
-	struct ixp42x_i2c_pins *gpio = plat_dev->dev.platform_data;
-	struct ixp42x_i2c_data *drv_data = 
-		kmalloc(sizeof(struct ixp42x_i2c_data), GFP_KERNEL);
-
-	if(!drv_data)
-		return -ENOMEM;
-
-	memzero(drv_data, sizeof(struct ixp42x_i2c_data));
-	drv_data->gpio_pins = gpio;
-
-	/*
-	 * We could make a lot of these structures static, but
-	 * certain platforms may have multiple GPIO-based I2C
-	 * buses for various device domains, so we need per-device
-	 * algo_data->data. 
-	 */
-	drv_data->algo_data.data = gpio;
-	drv_data->algo_data.setsda = ixp42x_bit_setsda;
-	drv_data->algo_data.setscl = ixp42x_bit_setscl;
-	drv_data->algo_data.getsda = ixp42x_bit_getsda;
-	drv_data->algo_data.getscl = ixp42x_bit_getscl;
-	drv_data->algo_data.udelay = 10;
-	drv_data->algo_data.mdelay = 10;
-	drv_data->algo_data.timeout = 100;
-
-	drv_data->adapter.id = I2C_HW_B_IXP425,
-	drv_data->adapter.algo_data = &drv_data->algo_data,
-
-	drv_data->adapter.dev.parent = &plat_dev->dev;
-
-	gpio_line_config(gpio->scl_pin, IXP425_GPIO_IN);
-	gpio_line_config(gpio->sda_pin, IXP425_GPIO_IN);
-	gpio_line_set(gpio->scl_pin, 0);
-	gpio_line_set(gpio->sda_pin, 0);
-
-	if ((err = i2c_bit_add_bus(&drv_data->adapter) != 0)) {
-		printk(KERN_ERR "ERROR: Could not install %s\n", dev->bus_id);
-
-		kfree(drv_data);
-		return err;
-	}
-
-	dev_set_drvdata(&plat_dev->dev, drv_data);
-
-	return 0;
-}
-
-static struct device_driver ixp42x_i2c_driver = {
-	.name		= "IXP42X-I2C",
-	.bus		= &platform_bus_type,
-	.probe		= ixp42x_i2c_probe,
-	.remove		= ixp42x_i2c_remove,
-};
-
-static int __init ixp42x_i2c_init(void)
-{
-	return driver_register(&ixp42x_i2c_driver);
-}
-
-static void __exit ixp42x_i2c_exit(void)
-{
-	driver_unregister(&ixp42x_i2c_driver);
-}
-
-module_init(ixp42x_i2c_init);
-module_exit(ixp42x_i2c_exit);
-
-MODULE_DESCRIPTION("GPIO-based I2C driver for IXP42x systems");
-MODULE_LICENSE("GPL");
-MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
-
diff -Nru a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-ixp4xx.c	Fri May 14 16:21:22 2004
@@ -0,0 +1,176 @@
+/*
+ * drivers/i2c/i2c-adap-ixp42x.c
+ *
+ * Intel's IXP42x XScale NPU chipsets (IXP420, 421, 422, 425) do not have
+ * an on board I2C controller but provide 16 GPIO pins that are often
+ * used to create an I2C bus. This driver provides an i2c_adapter 
+ * interface that plugs in under algo_bit and drives the GPIO pins
+ * as instructed by the alogorithm driver.
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ *
+ * Copyright (c) 2003-2004 MontaVista Software Inc.
+ *
+ * This file is licensed under the terms of the GNU General Public 
+ * License version 2. This program is licensed "as is" without any 
+ * warranty of any kind, whether express or implied.
+ *
+ * NOTE: Since different platforms will use different GPIO pins for
+ *       I2C, this driver uses an IXP42x-specific platform_data
+ *       pointer to pass the GPIO numbers to the driver. This 
+ *       allows us to support all the different IXP42x platforms
+ *       w/o having to put #ifdefs in this driver.
+ *
+ *       See arch/arm/mach-ixp42x/ixdp425.c for an example of building a 
+ *       device list and filling in the ixp42x_i2c_pins data structure 
+ *       that is passed as the platform_data to this driver.
+ */
+
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/i2c.h>
+
+#include <asm/hardware.h>	/* Pick up IXP42x-specific bits */
+
+static inline int ixp42x_scl_pin(void *data)
+{
+	return ((struct ixp42x_i2c_pins*)data)->scl_pin;
+}
+
+static inline int ixp42x_sda_pin(void *data)
+{
+	return ((struct ixp42x_i2c_pins*)data)->sda_pin;
+}
+
+static void ixp42x_bit_setscl(void *data, int val)
+{
+	gpio_line_set(ixp42x_scl_pin(data), 0);
+	gpio_line_config(ixp42x_scl_pin(data),
+		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
+}
+
+static void ixp42x_bit_setsda(void *data, int val)
+{
+	gpio_line_set(ixp42x_sda_pin(data), 0);
+	gpio_line_config(ixp42x_sda_pin(data),
+		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
+}
+
+static int ixp42x_bit_getscl(void *data)
+{
+	int scl;
+
+	gpio_line_config(ixp42x_scl_pin(data), IXP425_GPIO_IN );
+	gpio_line_get(ixp42x_scl_pin(data), &scl);
+
+	return scl;
+}	
+
+static int ixp42x_bit_getsda(void *data)
+{
+	int sda;
+
+	gpio_line_config(ixp42x_sda_pin(data), IXP425_GPIO_IN );
+	gpio_line_get(ixp42x_sda_pin(data), &sda);
+
+	return sda;
+}	
+
+struct ixp42x_i2c_data {
+	struct ixp42x_i2c_pins *gpio_pins;
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data algo_data;
+};
+
+static int ixp42x_i2c_remove(struct device *dev)
+{
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct ixp42x_i2c_data *drv_data = dev_get_drvdata(&plat_dev->dev);
+
+	dev_set_drvdata(&plat_dev->dev, NULL);
+
+	i2c_bit_del_bus(&drv_data->adapter);
+
+	kfree(drv_data);
+
+	return 0;
+}
+
+static int ixp42x_i2c_probe(struct device *dev)
+{
+	int err;
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct ixp42x_i2c_pins *gpio = plat_dev->dev.platform_data;
+	struct ixp42x_i2c_data *drv_data = 
+		kmalloc(sizeof(struct ixp42x_i2c_data), GFP_KERNEL);
+
+	if(!drv_data)
+		return -ENOMEM;
+
+	memzero(drv_data, sizeof(struct ixp42x_i2c_data));
+	drv_data->gpio_pins = gpio;
+
+	/*
+	 * We could make a lot of these structures static, but
+	 * certain platforms may have multiple GPIO-based I2C
+	 * buses for various device domains, so we need per-device
+	 * algo_data->data. 
+	 */
+	drv_data->algo_data.data = gpio;
+	drv_data->algo_data.setsda = ixp42x_bit_setsda;
+	drv_data->algo_data.setscl = ixp42x_bit_setscl;
+	drv_data->algo_data.getsda = ixp42x_bit_getsda;
+	drv_data->algo_data.getscl = ixp42x_bit_getscl;
+	drv_data->algo_data.udelay = 10;
+	drv_data->algo_data.mdelay = 10;
+	drv_data->algo_data.timeout = 100;
+
+	drv_data->adapter.id = I2C_HW_B_IXP425,
+	drv_data->adapter.algo_data = &drv_data->algo_data,
+
+	drv_data->adapter.dev.parent = &plat_dev->dev;
+
+	gpio_line_config(gpio->scl_pin, IXP425_GPIO_IN);
+	gpio_line_config(gpio->sda_pin, IXP425_GPIO_IN);
+	gpio_line_set(gpio->scl_pin, 0);
+	gpio_line_set(gpio->sda_pin, 0);
+
+	if ((err = i2c_bit_add_bus(&drv_data->adapter) != 0)) {
+		printk(KERN_ERR "ERROR: Could not install %s\n", dev->bus_id);
+
+		kfree(drv_data);
+		return err;
+	}
+
+	dev_set_drvdata(&plat_dev->dev, drv_data);
+
+	return 0;
+}
+
+static struct device_driver ixp42x_i2c_driver = {
+	.name		= "IXP42X-I2C",
+	.bus		= &platform_bus_type,
+	.probe		= ixp42x_i2c_probe,
+	.remove		= ixp42x_i2c_remove,
+};
+
+static int __init ixp42x_i2c_init(void)
+{
+	return driver_register(&ixp42x_i2c_driver);
+}
+
+static void __exit ixp42x_i2c_exit(void)
+{
+	driver_unregister(&ixp42x_i2c_driver);
+}
+
+module_init(ixp42x_i2c_init);
+module_exit(ixp42x_i2c_exit);
+
+MODULE_DESCRIPTION("GPIO-based I2C driver for IXP42x systems");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
+

