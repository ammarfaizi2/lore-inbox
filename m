Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262449AbTIVXkD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:40:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbTIVXi7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:38:59 -0400
Received: from mail.kroah.org ([65.200.24.183]:4513 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262449AbTIVXak convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:30:40 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734242958@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <1064273423404@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:24 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.15, 2003/09/22 13:06:04-07:00, greg@kroah.com

[PATCH] I2C: clean up i2c-prosavage.c driver

Remove direct memory accesses and link up device in the proper place in the
sysfs tree.


 drivers/i2c/busses/i2c-prosavage.c |   54 ++++++++++++-------------------------
 1 files changed, 18 insertions(+), 36 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-prosavage.c b/drivers/i2c/busses/i2c-prosavage.c
--- a/drivers/i2c/busses/i2c-prosavage.c	Mon Sep 22 16:13:38 2003
+++ b/drivers/i2c/busses/i2c-prosavage.c	Mon Sep 22 16:13:38 2003
@@ -60,21 +60,14 @@
 #include <linux/i2c.h>
 #include <linux/i2c-algo-bit.h>
 
-#include <asm/io.h>
-
 
 /*
  * driver configuration
  */
-#define	DRIVER_ID	"i2c-prosavage"
-#define	DRIVER_VERSION	"20030621"
-
-#define ADAPTER_NAME(x) (x).name
-
 #define MAX_BUSSES	2
 
 struct s_i2c_bus {
-	u8	*mmvga;
+	void	*mmvga;
 	int	i2c_reg;
 	int	adap_ok;
 	struct i2c_adapter		adap;
@@ -82,7 +75,7 @@
 };
 
 struct s_i2c_chip {
-	u8	*mmio;
+	void	*mmio;
 	struct s_i2c_bus	i2c_bus[MAX_BUSSES];
 };
 
@@ -102,9 +95,6 @@
 /* 
  * S3/VIA 8365/8375 registers
  */
-#ifndef PCI_VENDOR_ID_S3
-#define PCI_VENDOR_ID_S3		0x5333
-#endif
 #ifndef PCI_DEVICE_ID_S3_SAVAGE4
 #define PCI_DEVICE_ID_S3_SAVAGE4	0x8a25
 #endif
@@ -126,9 +116,9 @@
 #define I2C_SCL_IN	0x04
 #define I2C_SDA_IN	0x08
 
-#define SET_CR_IX(p, val)	*((p)->mmvga + VGA_CR_IX) = (u8)(val)
-#define SET_CR_DATA(p, val)	*((p)->mmvga + VGA_CR_DATA) = (u8)(val)
-#define GET_CR_DATA(p)		*((p)->mmvga + VGA_CR_DATA)
+#define SET_CR_IX(p, val)	writeb((val), (p)->mmvga + VGA_CR_IX)
+#define SET_CR_DATA(p, val)	writeb((val), (p)->mmvga + VGA_CR_DATA)
+#define GET_CR_DATA(p)		readb((p)->mmvga + VGA_CR_DATA)
 
 
 /*
@@ -190,12 +180,13 @@
 /*
  * adapter initialisation
  */
-static int i2c_register_bus(struct s_i2c_bus *p, u8 *mmvga, u32 i2c_reg)
+static int i2c_register_bus(struct pci_dev *dev, struct s_i2c_bus *p, u8 *mmvga, u32 i2c_reg)
 {
 	int ret;
 	p->adap.owner	  = THIS_MODULE;
 	p->adap.id	  = I2C_HW_B_S3VIA;
 	p->adap.algo_data = &p->algo;
+	p->adap.dev.parent = &dev->dev;
 	p->algo.setsda	  = bit_s3via_setsda;
 	p->algo.setscl	  = bit_s3via_setscl;
 	p->algo.getsda	  = bit_s3via_getsda;
@@ -236,8 +227,8 @@
 
 		ret = i2c_bit_del_bus(&chip->i2c_bus[i].adap);
 	        if (ret) {
-			printk(DRIVER_ID ": %s not removed\n",
-				ADAPTER_NAME(chip->i2c_bus[i].adap));
+			dev_err(&dev->dev, ": %s not removed\n",
+				chip->i2c_bus[i].adap.name);
 		}
 	}
 	if (chip->mmio) {
@@ -270,7 +261,7 @@
 	chip->mmio = ioremap_nocache(base, len);
 
 	if (chip->mmio == NULL) {
-		printk (DRIVER_ID ": ioremap failed\n");
+		dev_err(&dev->dev, "ioremap failed\n");
 		prosavage_remove(dev);
 		return -ENODEV;
 	}
@@ -286,10 +277,10 @@
 	 * i2c bus registration
 	 */
 	bus = &chip->i2c_bus[0];
-	snprintf(ADAPTER_NAME(bus->adap), sizeof(ADAPTER_NAME(bus->adap)),
+	snprintf(bus->adap.name, sizeof(bus->adap.name),
 		"ProSavage I2C bus at %02x:%02x.%x",
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	ret = i2c_register_bus(bus, chip->mmio + 0x8000, CR_SERIAL1);
+	ret = i2c_register_bus(dev, bus, chip->mmio + 0x8000, CR_SERIAL1);
 	if (ret) {
 		goto err_adap;
 	}
@@ -297,16 +288,16 @@
 	 * ddc bus registration
 	 */
 	bus = &chip->i2c_bus[1];
-	snprintf(ADAPTER_NAME(bus->adap), sizeof(ADAPTER_NAME(bus->adap)),
+	snprintf(bus->adap.name, sizeof(bus->adap.name),
 		"ProSavage DDC bus at %02x:%02x.%x",
 		dev->bus->number, PCI_SLOT(dev->devfn), PCI_FUNC(dev->devfn));
-	ret = i2c_register_bus(bus, chip->mmio + 0x8000, CR_SERIAL2);
+	ret = i2c_register_bus(dev, bus, chip->mmio + 0x8000, CR_SERIAL2);
 	if (ret) {
 		goto err_adap;
 	}
 	return 0;
 err_adap:
-	printk (DRIVER_ID ": %s failed\n", ADAPTER_NAME(bus->adap));
+	dev_err(&dev->dev, ": %s failed\n", bus->adap.name);
 	prosavage_remove(dev);
 	return ret;
 }
@@ -316,17 +307,9 @@
  * Data for PCI driver interface
  */
 static struct pci_device_id prosavage_pci_tbl[] = {
-   {
-	.vendor		=	PCI_VENDOR_ID_S3,
-	.device		=	PCI_DEVICE_ID_S3_SAVAGE4,
-	.subvendor	=	PCI_ANY_ID,
-	.subdevice	=	PCI_ANY_ID,
-   },{
-	.vendor		=	PCI_VENDOR_ID_S3,
-	.device		=	PCI_DEVICE_ID_S3_PROSAVAGE8,
-	.subvendor	=	PCI_ANY_ID,
-	.subdevice	=	PCI_ANY_ID,
-   },{ 0, }
+	{ PCI_DEVICE(PCI_VENDOR_ID_S3, PCI_DEVICE_ID_S3_SAVAGE4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_S3, PCI_DEVICE_ID_S3_PROSAVAGE8) },
+	{ 0, },
 };
 
 static struct pci_driver prosavage_driver = {
@@ -338,7 +321,6 @@
 
 static int __init i2c_prosavage_init(void)
 {
-	printk(DRIVER_ID " version %s (%s)\n", I2C_VERSION, DRIVER_VERSION);
 	return pci_module_init(&prosavage_driver);
 }
 

