Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267387AbUHWTIu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267387AbUHWTIu (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Aug 2004 15:08:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267385AbUHWTG1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Aug 2004 15:06:27 -0400
Received: from mail.kroah.org ([69.55.234.183]:8644 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S267287AbUHWSg6 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Aug 2004 14:36:58 -0400
X-Fake: the user-agent is fake
Subject: Re: [PATCH] PCI and I2C fixes for 2.6.8
User-Agent: Mutt/1.5.6i
In-Reply-To: <10932860833383@kroah.com>
Date: Mon, 23 Aug 2004 11:34:43 -0700
Message-Id: <10932860831280@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1807.54.4, 2004/08/02 16:09:44-07:00, dsaxena@plexity.net

[PATCH] I2C: Add Intel IXP2000 GPIO-based I2C adapter

Following patch adds support for using GPIO pins on Intel's IXP2000
Network Processor as a bit-bang I2C adapter. IXP2000 support will
be coming in via ARM updates once all the various drivers have been
merged upstream.

Signed-off-by: Deepak Saxena <dsaxena@plexity.net>
Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>


 drivers/i2c/busses/Kconfig       |   11 ++
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-ixp2000.c |  171 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 183 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	2004-08-23 11:07:25 -07:00
+++ b/drivers/i2c/busses/Kconfig	2004-08-23 11:07:25 -07:00
@@ -164,6 +164,17 @@
 	  This support is also available as a module. If so, the module
 	  will be called i2c-ixp4xx.
 
+config I2C_IXP2000
+	tristate "IXP2000 GPIO-Based I2C Interface"
+	depends on I2C && ARCH_IXP2000
+	select I2C_ALGOBIT
+	help
+	  Say Y here if you have an Intel IXP2000(2400, 2800, 2850) based 
+	  system and are using GPIO lines for an I2C bus.
+
+	  This support is also available as a module. If so, the module
+	  will be called i2c-ixp2000.
+
 config I2C_KEYWEST
 	tristate "Powermac Keywest I2C interface"
 	depends on I2C && PPC_PMAC
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	2004-08-23 11:07:25 -07:00
+++ b/drivers/i2c/busses/Makefile	2004-08-23 11:07:25 -07:00
@@ -16,6 +16,7 @@
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
 obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
+obj-$(CONFIG_I2C_IXP2000)	+= i2c-ixp2000.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
diff -Nru a/drivers/i2c/busses/i2c-ixp2000.c b/drivers/i2c/busses/i2c-ixp2000.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/i2c/busses/i2c-ixp2000.c	2004-08-23 11:07:25 -07:00
@@ -0,0 +1,171 @@
+/*
+ * drivers/i2c/busses/i2c-ixp2000.c
+ *
+ * I2C adapter for IXP2000 systems using GPIOs for I2C bus
+ *
+ * Author: Deepak Saxena <dsaxena@plexity.net>
+ * Based on IXDP2400 code by: Naeem M. Afzal <naeem.m.afzal@intel.com>
+ * Made generic by: Jeff Daly <jeffrey.daly@intel.com>
+ *
+ * Copyright (c) 2003-2004 MontaVista Software Inc.
+ *
+ * This file is licensed under  the terms of the GNU General Public 
+ * License version 2. This program is licensed "as is" without any 
+ * warranty of any kind, whether express or implied.
+ *
+ * From Jeff Daly:
+ *
+ * I2C adapter driver for Intel IXDP2xxx platforms. This should work for any
+ * IXP2000 platform if it uses the HW GPIO in the same manner.  Basically, 
+ * SDA and SCL GPIOs have external pullups.  Setting the respective GPIO to 
+ * an input will make the signal a '1' via the pullup.  Setting them to 
+ * outputs will pull them down. 
+ *
+ * The GPIOs are open drain signals and are used as configuration strap inputs
+ * during power-up so there's generally a buffer on the board that needs to be 
+ * 'enabled' to drive the GPIOs.
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
+#include <linux/i2c-algo-bit.h>
+
+#include <asm/hardware.h>	/* Pick up IXP42000-specific bits */
+
+static inline int ixp2000_scl_pin(void *data)
+{
+	return ((struct ixp2000_i2c_pins*)data)->scl_pin;
+}
+
+static inline int ixp2000_sda_pin(void *data)
+{
+	return ((struct ixp2000_i2c_pins*)data)->sda_pin;
+}
+
+
+static void ixp2000_bit_setscl(void *data, int val)
+{
+	int i = 5000;
+
+	if (val) {
+		gpio_line_config(ixp2000_scl_pin(data), GPIO_IN);
+		while(!gpio_line_get(ixp2000_scl_pin(data)) && i--);
+	} else {
+		gpio_line_config(ixp2000_scl_pin(data), GPIO_OUT);
+	}
+}
+
+static void ixp2000_bit_setsda(void *data, int val)
+{
+	if (val) {
+		gpio_line_config(ixp2000_sda_pin(data), GPIO_IN);
+	} else {
+		gpio_line_config(ixp2000_sda_pin(data), GPIO_OUT);
+	}
+}
+
+static int ixp2000_bit_getscl(void *data)
+{
+	return gpio_line_get(ixp2000_scl_pin(data));
+}
+
+static int ixp2000_bit_getsda(void *data)
+{
+	return gpio_line_get(ixp2000_sda_pin(data));
+}
+
+struct ixp2000_i2c_data {
+	struct ixp2000_i2c_pins *gpio_pins;
+	struct i2c_adapter adapter;
+	struct i2c_algo_bit_data algo_data;
+};
+
+static int ixp2000_i2c_remove(struct device *dev)
+{
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct ixp2000_i2c_data *drv_data = dev_get_drvdata(&plat_dev->dev);
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
+static int ixp2000_i2c_probe(struct device *dev)
+{
+	int err;
+	struct platform_device *plat_dev = to_platform_device(dev);
+	struct ixp2000_i2c_pins *gpio = plat_dev->dev.platform_data;
+	struct ixp2000_i2c_data *drv_data = 
+		kmalloc(sizeof(struct ixp2000_i2c_data), GFP_KERNEL);
+
+	if (!drv_data)
+		return -ENOMEM;
+	memzero(drv_data, sizeof(*drv_data));
+	drv_data->gpio_pins = gpio;
+
+	drv_data->algo_data.data = gpio;
+	drv_data->algo_data.setsda = ixp2000_bit_setsda;
+	drv_data->algo_data.setscl = ixp2000_bit_setscl;
+	drv_data->algo_data.getsda = ixp2000_bit_getsda;
+	drv_data->algo_data.getscl = ixp2000_bit_getscl;
+	drv_data->algo_data.udelay = 6;
+	drv_data->algo_data.mdelay = 6;
+	drv_data->algo_data.timeout = 100;
+
+	drv_data->adapter.id = I2C_HW_B_IXP2000,
+	drv_data->adapter.algo_data = &drv_data->algo_data,
+
+	drv_data->adapter.dev.parent = &plat_dev->dev;
+
+	gpio_line_config(gpio->sda_pin, GPIO_IN);
+	gpio_line_config(gpio->scl_pin, GPIO_IN);
+	gpio_line_set(gpio->scl_pin, 0);
+	gpio_line_set(gpio->sda_pin, 0);
+
+	if ((err = i2c_bit_add_bus(&drv_data->adapter)) != 0) {
+		dev_err(dev, "Could not install, error %d\n", err);
+		kfree(drv_data);
+		return err;
+	} 
+
+	dev_set_drvdata(&plat_dev->dev, drv_data);
+
+	return 0;
+}
+
+static struct device_driver ixp2000_i2c_driver = {
+	.name		= "IXP2000-I2C",
+	.bus		= &platform_bus_type,
+	.probe		= ixp2000_i2c_probe,
+	.remove		= ixp2000_i2c_remove,
+};
+
+static int __init ixp2000_i2c_init(void)
+{
+	return driver_register(&ixp2000_i2c_driver);
+}
+
+static void __exit ixp2000_i2c_exit(void)
+{
+	driver_unregister(&ixp2000_i2c_driver);
+}
+
+module_init(ixp2000_i2c_init);
+module_exit(ixp2000_i2c_exit);
+
+MODULE_AUTHOR ("Deepak Saxena <dsaxena@plexity.net>");
+MODULE_DESCRIPTION("IXP2000 GPIO-based I2C bus driver");
+MODULE_LICENSE("GPL");
+

