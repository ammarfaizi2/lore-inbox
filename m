Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264305AbUENX4a@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264305AbUENX4a (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 May 2004 19:56:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264656AbUENXxV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 May 2004 19:53:21 -0400
Received: from mail.kroah.org ([65.200.24.183]:17381 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S264560AbUENX3u convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 May 2004 19:29:50 -0400
Subject: Re: [PATCH] I2C update for 2.6.6
In-Reply-To: <10845773561456@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Fri, 14 May 2004 16:29:17 -0700
Message-Id: <10845773572660@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 7BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1587.15.5, 2004/05/01 22:35:09-07:00, dsaxena@plexity.net

[PATCH] I2C: Update IXP4xx I2C bus driver

The 2.6 IXP4xx code has been cleaned up to change all references to
IXP42x/IXP425 with IXP4xx. The following patch updates the I2C bits.
Before applying, you need to 'bk move i2c-ixp42x.c ixp-4xx.c".


 drivers/i2c/busses/Kconfig      |   10 +--
 drivers/i2c/busses/Makefile     |    2 
 drivers/i2c/busses/i2c-ixp4xx.c |  109 ++++++++++++++++++++--------------------
 3 files changed, 63 insertions(+), 58 deletions(-)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Fri May 14 16:21:06 2004
+++ b/drivers/i2c/busses/Kconfig	Fri May 14 16:21:06 2004
@@ -145,16 +145,16 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-ite.
 
-config I2C_IXP42X
-	tristate "IXP42x GPIO-Based I2C Interface"
-	depends on I2C && ARCH_IXP425
+config I2C_IXP4XX
+	tristate "IXP4xx GPIO-Based I2C Interface"
+	depends on I2C && ARCH_IXP4XX
 	select I2C_ALGOBIT
 	help
-	  Say Y here if you have an Intel IXP42x(420,421,422,425) based 
+	  Say Y here if you have an Intel IXP4xx(420,421,422,425) based 
 	  system and are using GPIO lines for an I2C bus.
 
 	  This support is also available as a module. If so, the module
-	  will be called i2c-ixp42x.
+	  will be called i2c-ixp4xx.
 
 config I2C_KEYWEST
 	tristate "Powermac Keywest I2C interface"
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Fri May 14 16:21:06 2004
+++ b/drivers/i2c/busses/Makefile	Fri May 14 16:21:06 2004
@@ -15,7 +15,7 @@
 obj-$(CONFIG_I2C_IOP3XX)	+= i2c-iop3xx.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_ITE)		+= i2c-ite.o
-obj-$(CONFIG_I2C_IXP42X)	+= i2c-ixp42x.o
+obj-$(CONFIG_I2C_IXP4XX)	+= i2c-ixp4xx.o
 obj-$(CONFIG_I2C_KEYWEST)	+= i2c-keywest.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PARPORT)	+= i2c-parport.o
diff -Nru a/drivers/i2c/busses/i2c-ixp4xx.c b/drivers/i2c/busses/i2c-ixp4xx.c
--- a/drivers/i2c/busses/i2c-ixp4xx.c	Fri May 14 16:21:06 2004
+++ b/drivers/i2c/busses/i2c-ixp4xx.c	Fri May 14 16:21:06 2004
@@ -1,7 +1,7 @@
 /*
- * drivers/i2c/i2c-adap-ixp42x.c
+ * drivers/i2c/i2c-adap-ixp4xx.c
  *
- * Intel's IXP42x XScale NPU chipsets (IXP420, 421, 422, 425) do not have
+ * Intel's IXP4xx XScale NPU chipsets (IXP420, 421, 422, 425) do not have
  * an on board I2C controller but provide 16 GPIO pins that are often
  * used to create an I2C bus. This driver provides an i2c_adapter 
  * interface that plugs in under algo_bit and drives the GPIO pins
@@ -16,79 +16,84 @@
  * warranty of any kind, whether express or implied.
  *
  * NOTE: Since different platforms will use different GPIO pins for
- *       I2C, this driver uses an IXP42x-specific platform_data
+ *       I2C, this driver uses an IXP4xx-specific platform_data
  *       pointer to pass the GPIO numbers to the driver. This 
- *       allows us to support all the different IXP42x platforms
+ *       allows us to support all the different IXP4xx platforms
  *       w/o having to put #ifdefs in this driver.
  *
- *       See arch/arm/mach-ixp42x/ixdp425.c for an example of building a 
- *       device list and filling in the ixp42x_i2c_pins data structure 
+ *       See arch/arm/mach-ixp4xx/ixdp425.c for an example of building a 
+ *       device list and filling in the ixp4xx_i2c_pins data structure 
  *       that is passed as the platform_data to this driver.
  */
 
 #include <linux/config.h>
+#ifdef CONFIG_I2C_DEBUG_BUS
+#define DEBUG	1
+#endif
+
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/device.h>
 #include <linux/module.h>
 #include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
 
-#include <asm/hardware.h>	/* Pick up IXP42x-specific bits */
+#include <asm/hardware.h>	/* Pick up IXP4xx-specific bits */
 
-static inline int ixp42x_scl_pin(void *data)
+static inline int ixp4xx_scl_pin(void *data)
 {
-	return ((struct ixp42x_i2c_pins*)data)->scl_pin;
+	return ((struct ixp4xx_i2c_pins*)data)->scl_pin;
 }
 
-static inline int ixp42x_sda_pin(void *data)
+static inline int ixp4xx_sda_pin(void *data)
 {
-	return ((struct ixp42x_i2c_pins*)data)->sda_pin;
+	return ((struct ixp4xx_i2c_pins*)data)->sda_pin;
 }
 
-static void ixp42x_bit_setscl(void *data, int val)
+static void ixp4xx_bit_setscl(void *data, int val)
 {
-	gpio_line_set(ixp42x_scl_pin(data), 0);
-	gpio_line_config(ixp42x_scl_pin(data),
-		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
+	gpio_line_set(ixp4xx_scl_pin(data), 0);
+	gpio_line_config(ixp4xx_scl_pin(data),
+		val ? IXP4XX_GPIO_IN : IXP4XX_GPIO_OUT );
 }
 
-static void ixp42x_bit_setsda(void *data, int val)
+static void ixp4xx_bit_setsda(void *data, int val)
 {
-	gpio_line_set(ixp42x_sda_pin(data), 0);
-	gpio_line_config(ixp42x_sda_pin(data),
-		val ? IXP425_GPIO_IN : IXP425_GPIO_OUT );
+	gpio_line_set(ixp4xx_sda_pin(data), 0);
+	gpio_line_config(ixp4xx_sda_pin(data),
+		val ? IXP4XX_GPIO_IN : IXP4XX_GPIO_OUT );
 }
 
-static int ixp42x_bit_getscl(void *data)
+static int ixp4xx_bit_getscl(void *data)
 {
 	int scl;
 
-	gpio_line_config(ixp42x_scl_pin(data), IXP425_GPIO_IN );
-	gpio_line_get(ixp42x_scl_pin(data), &scl);
+	gpio_line_config(ixp4xx_scl_pin(data), IXP4XX_GPIO_IN );
+	gpio_line_get(ixp4xx_scl_pin(data), &scl);
 
 	return scl;
 }	
 
-static int ixp42x_bit_getsda(void *data)
+static int ixp4xx_bit_getsda(void *data)
 {
 	int sda;
 
-	gpio_line_config(ixp42x_sda_pin(data), IXP425_GPIO_IN );
-	gpio_line_get(ixp42x_sda_pin(data), &sda);
+	gpio_line_config(ixp4xx_sda_pin(data), IXP4XX_GPIO_IN );
+	gpio_line_get(ixp4xx_sda_pin(data), &sda);
 
 	return sda;
 }	
 
-struct ixp42x_i2c_data {
-	struct ixp42x_i2c_pins *gpio_pins;
+struct ixp4xx_i2c_data {
+	struct ixp4xx_i2c_pins *gpio_pins;
 	struct i2c_adapter adapter;
 	struct i2c_algo_bit_data algo_data;
 };
 
-static int ixp42x_i2c_remove(struct device *dev)
+static int ixp4xx_i2c_remove(struct device *dev)
 {
 	struct platform_device *plat_dev = to_platform_device(dev);
-	struct ixp42x_i2c_data *drv_data = dev_get_drvdata(&plat_dev->dev);
+	struct ixp4xx_i2c_data *drv_data = dev_get_drvdata(&plat_dev->dev);
 
 	dev_set_drvdata(&plat_dev->dev, NULL);
 
@@ -99,18 +104,18 @@
 	return 0;
 }
 
-static int ixp42x_i2c_probe(struct device *dev)
+static int ixp4xx_i2c_probe(struct device *dev)
 {
 	int err;
 	struct platform_device *plat_dev = to_platform_device(dev);
-	struct ixp42x_i2c_pins *gpio = plat_dev->dev.platform_data;
-	struct ixp42x_i2c_data *drv_data = 
-		kmalloc(sizeof(struct ixp42x_i2c_data), GFP_KERNEL);
+	struct ixp4xx_i2c_pins *gpio = plat_dev->dev.platform_data;
+	struct ixp4xx_i2c_data *drv_data = 
+		kmalloc(sizeof(struct ixp4xx_i2c_data), GFP_KERNEL);
 
 	if(!drv_data)
 		return -ENOMEM;
 
-	memzero(drv_data, sizeof(struct ixp42x_i2c_data));
+	memzero(drv_data, sizeof(struct ixp4xx_i2c_data));
 	drv_data->gpio_pins = gpio;
 
 	/*
@@ -120,21 +125,21 @@
 	 * algo_data->data. 
 	 */
 	drv_data->algo_data.data = gpio;
-	drv_data->algo_data.setsda = ixp42x_bit_setsda;
-	drv_data->algo_data.setscl = ixp42x_bit_setscl;
-	drv_data->algo_data.getsda = ixp42x_bit_getsda;
-	drv_data->algo_data.getscl = ixp42x_bit_getscl;
+	drv_data->algo_data.setsda = ixp4xx_bit_setsda;
+	drv_data->algo_data.setscl = ixp4xx_bit_setscl;
+	drv_data->algo_data.getsda = ixp4xx_bit_getsda;
+	drv_data->algo_data.getscl = ixp4xx_bit_getscl;
 	drv_data->algo_data.udelay = 10;
 	drv_data->algo_data.mdelay = 10;
 	drv_data->algo_data.timeout = 100;
 
-	drv_data->adapter.id = I2C_HW_B_IXP425,
+	drv_data->adapter.id = I2C_HW_B_IXP4XX,
 	drv_data->adapter.algo_data = &drv_data->algo_data,
 
 	drv_data->adapter.dev.parent = &plat_dev->dev;
 
-	gpio_line_config(gpio->scl_pin, IXP425_GPIO_IN);
-	gpio_line_config(gpio->sda_pin, IXP425_GPIO_IN);
+	gpio_line_config(gpio->scl_pin, IXP4XX_GPIO_IN);
+	gpio_line_config(gpio->sda_pin, IXP4XX_GPIO_IN);
 	gpio_line_set(gpio->scl_pin, 0);
 	gpio_line_set(gpio->sda_pin, 0);
 
@@ -150,27 +155,27 @@
 	return 0;
 }
 
-static struct device_driver ixp42x_i2c_driver = {
-	.name		= "IXP42X-I2C",
+static struct device_driver ixp4xx_i2c_driver = {
+	.name		= "IXP4XX-I2C",
 	.bus		= &platform_bus_type,
-	.probe		= ixp42x_i2c_probe,
-	.remove		= ixp42x_i2c_remove,
+	.probe		= ixp4xx_i2c_probe,
+	.remove		= ixp4xx_i2c_remove,
 };
 
-static int __init ixp42x_i2c_init(void)
+static int __init ixp4xx_i2c_init(void)
 {
-	return driver_register(&ixp42x_i2c_driver);
+	return driver_register(&ixp4xx_i2c_driver);
 }
 
-static void __exit ixp42x_i2c_exit(void)
+static void __exit ixp4xx_i2c_exit(void)
 {
-	driver_unregister(&ixp42x_i2c_driver);
+	driver_unregister(&ixp4xx_i2c_driver);
 }
 
-module_init(ixp42x_i2c_init);
-module_exit(ixp42x_i2c_exit);
+module_init(ixp4xx_i2c_init);
+module_exit(ixp4xx_i2c_exit);
 
-MODULE_DESCRIPTION("GPIO-based I2C driver for IXP42x systems");
+MODULE_DESCRIPTION("GPIO-based I2C adapter for IXP4xx systems");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Deepak Saxena <dsaxena@plexity.net>");
 

