Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263107AbTIVX6B (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:58:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263103AbTIVX5M
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:57:12 -0400
Received: from mail.kroah.org ([65.200.24.183]:24481 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262802AbTIVXbU convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:20 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734212155@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734213007@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:21 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.9, 2003/09/22 11:03:30-07:00, greg@kroah.com

[PATCH] I2C: add the i2c-i810 i2c bus driver

This is based on the lmsensor cvs version of the driver, but is cleaned
it up and ported it to 2.6.


 drivers/i2c/busses/Kconfig    |   15 ++
 drivers/i2c/busses/Makefile   |    1 
 drivers/i2c/busses/i2c-i810.c |  256 ++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 272 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:14:38 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:14:38 2003
@@ -62,6 +62,21 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-i801.
 
+config I2C_I810
+	tristate "Intel 810/815"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for the Intel
+	  810/815 family of mainboard I2C interfaces.  Specifically, the 
+	  following versions of the chipset is supported:
+	    i810AA
+	    i810AB
+	    i810E
+	    i815
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-i810.
+
 config I2C_ISA
 	tristate "ISA Bus support"
 	depends on I2C && ISA && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:14:38 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:14:38 2003
@@ -7,6 +7,7 @@
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
+obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
diff -Nru a/drivers/i2c/busses/i2c-i810.c b/drivers/i2c/busses/i2c-i810.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-i810.c	Mon Sep 22 16:14:38 2003
@@ -0,0 +1,256 @@
+/*
+    i2c-i810.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+    Copyright (c) 1998, 1999, 2000  Frodo Looijaard <frodol@dds.nl>,
+    Philip Edelbrock <phil@netroedge.com>,
+    Ralph Metzler <rjkm@thp.uni-koeln.de>, and
+    Mark D. Studebaker <mdsxyz123@yahoo.com>
+    
+    Based on code written by Ralph Metzler <rjkm@thp.uni-koeln.de> and
+    Simon Vogl
+
+    This program is free software; you can redistribute it and/or modify
+    it under the terms of the GNU General Public License as published by
+    the Free Software Foundation; either version 2 of the License, or
+    (at your option) any later version.
+
+    This program is distributed in the hope that it will be useful,
+    but WITHOUT ANY WARRANTY; without even the implied warranty of
+    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+    GNU General Public License for more details.
+
+    You should have received a copy of the GNU General Public License
+    along with this program; if not, write to the Free Software
+    Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+*/
+/*
+   This interfaces to the I810/I815 to provide access to
+   the DDC Bus and the I2C Bus.
+
+   SUPPORTED DEVICES	PCI ID
+   i810AA		7121           
+   i810AB		7123           
+   i810E		7125           
+   i815			1132           
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+/* GPIO register locations */
+#define I810_IOCONTROL_OFFSET	0x5000
+#define I810_HVSYNC		0x00	/* not used */
+#define I810_GPIOA		0x10
+#define I810_GPIOB		0x14
+
+/* bit locations in the registers */
+#define SCL_DIR_MASK		0x0001
+#define SCL_DIR			0x0002
+#define SCL_VAL_MASK		0x0004
+#define SCL_VAL_OUT		0x0008
+#define SCL_VAL_IN		0x0010
+#define SDA_DIR_MASK		0x0100
+#define SDA_DIR			0x0200
+#define SDA_VAL_MASK		0x0400
+#define SDA_VAL_OUT		0x0800
+#define SDA_VAL_IN		0x1000
+
+/* initialization states */
+#define INIT1			0x1
+#define INIT2			0x2
+#define INIT3			0x4
+
+/* delays */
+#define CYCLE_DELAY		10
+#define TIMEOUT			(HZ / 2)
+
+static void *ioaddr;
+
+/* The i810 GPIO registers have individual masks for each bit
+   so we never have to read before writing. Nice. */
+
+static void bit_i810i2c_setscl(void *data, int val)
+{
+	writel((val ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK,
+	     ioaddr + I810_GPIOB);
+	readl(ioaddr + I810_GPIOB);	/* flush posted write */
+}
+
+static void bit_i810i2c_setsda(void *data, int val)
+{
+ 	writel((val ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK,
+	     ioaddr + I810_GPIOB);
+	readl(ioaddr + I810_GPIOB);	/* flush posted write */
+}
+
+/* The GPIO pins are open drain, so the pins could always remain outputs.
+   However, some chip versions don't latch the inputs unless they
+   are set as inputs.
+   We rely on the i2c-algo-bit routines to set the pins high before
+   reading the input from other chips. Following guidance in the 815
+   prog. ref. guide, we do a "dummy write" of 0 to the register before
+   reading which forces the input value to be latched. We presume this
+   applies to the 810 as well; shouldn't hurt anyway. This is necessary to get
+   i2c_algo_bit bit_test=1 to pass. */
+
+static int bit_i810i2c_getscl(void *data)
+{
+	writel(SCL_DIR_MASK, ioaddr + I810_GPIOB);
+	writel(0, ioaddr + I810_GPIOB);
+	return (0 != (readl(ioaddr + I810_GPIOB) & SCL_VAL_IN));
+}
+
+static int bit_i810i2c_getsda(void *data)
+{
+	writel(SDA_DIR_MASK, ioaddr + I810_GPIOB);
+	writel(0, ioaddr + I810_GPIOB);
+	return (0 != (readl(ioaddr + I810_GPIOB) & SDA_VAL_IN));
+}
+
+static void bit_i810ddc_setscl(void *data, int val)
+{
+	writel((val ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK,
+	     ioaddr + I810_GPIOA);
+	readl(ioaddr + I810_GPIOA);	/* flush posted write */
+}
+
+static void bit_i810ddc_setsda(void *data, int val)
+{
+ 	writel((val ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK,
+	     ioaddr + I810_GPIOA);
+	readl(ioaddr + I810_GPIOA);	/* flush posted write */
+}
+
+static int bit_i810ddc_getscl(void *data)
+{
+	writel(SCL_DIR_MASK, ioaddr + I810_GPIOA);
+	writel(0, ioaddr + I810_GPIOA);
+	return (0 != (readl(ioaddr + I810_GPIOA) & SCL_VAL_IN));
+}
+
+static int bit_i810ddc_getsda(void *data)
+{
+	writel(SDA_DIR_MASK, ioaddr + I810_GPIOA);
+	writel(0, ioaddr + I810_GPIOA);
+	return (0 != (readl(ioaddr + I810_GPIOA) & SDA_VAL_IN));
+}
+
+static int config_i810(struct pci_dev *dev)
+{
+	unsigned long cadr;
+
+	/* map I810 memory */
+	cadr = dev->resource[1].start;
+	cadr += I810_IOCONTROL_OFFSET;
+	cadr &= PCI_BASE_ADDRESS_MEM_MASK;
+	ioaddr = ioremap_nocache(cadr, 0x1000);
+	if (ioaddr) {
+		bit_i810i2c_setscl(NULL, 1);
+		bit_i810i2c_setsda(NULL, 1);
+		bit_i810ddc_setscl(NULL, 1);
+		bit_i810ddc_setsda(NULL, 1);
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static struct i2c_algo_bit_data i810_i2c_bit_data = {
+	.setsda		= bit_i810i2c_setsda,
+	.setscl		= bit_i810i2c_setscl,
+	.getsda		= bit_i810i2c_getsda,
+	.getscl		= bit_i810i2c_getscl,
+	.udelay		= CYCLE_DELAY,
+	.mdelay		= CYCLE_DELAY,
+	.timeout	= TIMEOUT,
+};
+
+static struct i2c_adapter i810_i2c_adapter = {
+	.owner		= THIS_MODULE,
+	.name		= "I810/I815 I2C Adapter",
+	.algo_data	= &i810_i2c_bit_data,
+};
+
+static struct i2c_algo_bit_data i810_ddc_bit_data = {
+	.setsda		= bit_i810ddc_setsda,
+	.setscl		= bit_i810ddc_setscl,
+	.getsda		= bit_i810ddc_getsda,
+	.getscl		= bit_i810ddc_getscl,
+	.udelay		= CYCLE_DELAY,
+	.mdelay		= CYCLE_DELAY,
+	.timeout	= TIMEOUT,
+};
+
+static struct i2c_adapter i810_ddc_adapter = {
+	.owner		= THIS_MODULE,
+	.name		= "I810/I815 DDC Adapter",
+	.algo_data	= &i810_ddc_bit_data,
+};
+
+static struct pci_device_id i810_ids[] __devinitdata = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG1) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810_IG3) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82810E_IG) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82815_CGC) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82845G_IG) },
+	{ 0, },
+};
+
+static int __devinit i810_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	int retval;
+
+	retval = config_i810(dev);
+	if (retval)
+		return retval;
+	dev_info(&dev->dev, "i810/i815 i2c device found.\n");
+
+	/* set up the sysfs linkage to our parent device */
+	i810_i2c_adapter.dev.parent = &dev->dev;
+	i810_ddc_adapter.dev.parent = &dev->dev;
+
+	retval = i2c_bit_add_bus(&i810_i2c_adapter);
+	if (retval)
+		return retval;
+	retval = i2c_bit_add_bus(&i810_ddc_adapter);
+	if (retval)
+		i2c_bit_del_bus(&i810_i2c_adapter);
+	return retval;
+}
+
+static void __devexit i810_remove(struct pci_dev *dev)
+{
+	i2c_bit_del_bus(&i810_ddc_adapter);
+	i2c_bit_del_bus(&i810_i2c_adapter);
+	iounmap(ioaddr);
+}
+
+static struct pci_driver i810_driver = {
+	.name		= "i810 smbus",
+	.id_table	= i810_ids,
+	.probe		= i810_probe,
+	.remove		= __devexit_p(i810_remove),
+};
+
+static int __init i2c_i810_init(void)
+{
+	return pci_module_init(&i810_driver);
+}
+
+static void __exit i2c_i810_exit(void)
+{
+	pci_unregister_driver(&i810_driver);
+}
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
+		"Philip Edelbrock <phil@netroedge.com>, "
+		"Ralph Metzler <rjkm@thp.uni-koeln.de>, "
+		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_DESCRIPTION("I810/I815 I2C/DDC driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_i810_init);
+module_exit(i2c_i810_exit);

