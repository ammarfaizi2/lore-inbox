Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262859AbUCPACM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 19:02:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262890AbUCPACL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 19:02:11 -0500
Received: from mail.kroah.org ([65.200.24.183]:64430 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262859AbUCPABt convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 19:01:49 -0500
Subject: Re: [PATCH] i2c driver fixes for 2.6.4
In-Reply-To: <10793913904022@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 15 Mar 2004 14:56:31 -0800
Message-Id: <10793913902844@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1557.61.6, 2004/02/17 15:00:40-08:00, dsaxena@plexity.net

[PATCH] I2C:  Support for IXP42x GPIO-based I2C

Following is an updated patch to add support for using the GPIO lines
on an Intel IXP42x SOC for I2C.  Changes since last patch include:

- Cleanups as per Jean Delvare's comments

- Rename functions as 42x instead of 425

- Change the comments at the top of the file to better reflect the
  purpose of this driver.

This code has been tested with the eeprom client driver and worked
w/o any problems.


 drivers/i2c/busses/Kconfig      |   11 ++
 drivers/i2c/busses/Makefile     |    1 
 drivers/i2c/busses/i2c-ixp42x.c |  180 ++++++++++++++++++++++++++++++++++++++++
 3 files changed, 192 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Mar 15 14:37:32 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Mar 15 14:37:32 2004
@@ -144,6 +144,17 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-ite.
 
+config I2C_IXP42X
+	tristate "IXP42x GPIO-Based I2C Interface"
+	depends on I2C && ARCH_IXP425
+	select I2C_ALGOBIT
+	help
+	  Say Y here if you have an Intel IXP42x(420,421,422,425) based 
+	  system and are using GPIO lines for an I2C bus.
+
+	  This support is also available as a module. If so, the module
+	  will be called i2c-ixp42x.
+
 config I2C_KEYWEST
 	tristate "Powermac Keywest I2C interface"
 	depends on I2C && PPC_PMAC
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Mar 15 14:37:32 2004
+++ b/drivers/i2c/busses/Makefile	Mon Mar 15 14:37:32 2004
@@ -15,6 +15,7 @@
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
+obj-$(CONFIG_I2C_IXP42X)	+= i2c-ixp42x.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PHILIPSPAR)	+= i2c-philips-par.o
diff -Nru a/drivers/i2c/busses/i2c-ixp42x.c b/drivers/i2c/busses/i2c-ixp42x.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-ixp42x.c	Mon Mar 15 14:37:32 2004
@@ -0,0 +1,180 @@
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
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
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

