Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262813AbTIWAXc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 20:23:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263083AbTIVXyC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:54:02 -0400
Received: from mail.kroah.org ([65.200.24.183]:16801 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262795AbTIVXbK convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:10 -0400
Content-Type: text/plain; charset=US-ASCII
Message-Id: <10642734221409@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734212155@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:22 -0700
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.10, 2003/09/22 11:05:20-07:00, greg@kroah.com

[PATCH] I2C: add the i2c-savage4 i2c bus driver

This is based on the lmsensor cvs version of the driver, but is cleaned
it up and ported it to 2.6.


 drivers/i2c/busses/Kconfig       |   10 +
 drivers/i2c/busses/Makefile      |    1 
 drivers/i2c/busses/i2c-savage4.c |  205 +++++++++++++++++++++++++++++++++++++++
 3 files changed, 216 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:14:28 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:14:28 2003
@@ -113,6 +113,16 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-piix4.
 
+config I2C_SAVAGE4
+	tristate "S3 Savage 4"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for the 
+	  S3 Savage 4 I2C interface.
+
+	  This driver can also be built as a module.  If so, the module
+	  will be called i2c-savage4.
+
 config I2C_SIS5595
 	tristate "SiS 5595"
 	depends on I2C && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:14:28 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:14:28 2003
@@ -11,6 +11,7 @@
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_NFORCE2)	+= i2c-nforce2.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
+obj-$(CONFIG_I2C_SAVAGE4)	+= i2c-savage4.o
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
 obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
diff -Nru a/drivers/i2c/busses/i2c-savage4.c b/drivers/i2c/busses/i2c-savage4.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-savage4.c	Mon Sep 22 16:14:28 2003
@@ -0,0 +1,205 @@
+/*
+    i2c-savage4.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>,
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
+
+/* This interfaces to the I2C bus of the Savage4 to gain access to
+   the BT869 and possibly other I2C devices. The DDC bus is not
+   yet supported because its register is not memory-mapped.
+   However we leave the DDC code here, commented out, to make
+   it easier to add later.
+*/
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/pci.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+/* 3DFX defines */
+#define PCI_CHIP_SAVAGE3D	0x8A20
+#define PCI_CHIP_SAVAGE3D_MV	0x8A21
+#define PCI_CHIP_SAVAGE4	0x8A22
+#define PCI_CHIP_SAVAGE2000	0x9102
+#define PCI_CHIP_PROSAVAGE_PM	0x8A25
+#define PCI_CHIP_PROSAVAGE_KM	0x8A26
+#define PCI_CHIP_SAVAGE_MX_MV	0x8c10
+#define PCI_CHIP_SAVAGE_MX	0x8c11
+#define PCI_CHIP_SAVAGE_IX_MV	0x8c12
+#define PCI_CHIP_SAVAGE_IX	0x8c13
+
+#define REG			0xff20	/* Serial Port 1 Register */
+
+/* bit locations in the register */
+#define DDC_ENAB		0x00040000
+#define DDC_SCL_OUT		0x00080000
+#define DDC_SDA_OUT		0x00100000
+#define DDC_SCL_IN		0x00200000
+#define DDC_SDA_IN		0x00400000
+#define I2C_ENAB		0x00000020
+#define I2C_SCL_OUT		0x00000001
+#define I2C_SDA_OUT		0x00000002
+#define I2C_SCL_IN		0x00000008
+#define I2C_SDA_IN		0x00000010
+
+/* initialization states */
+#define INIT2			0x20
+#define INIT3			0x04
+
+/* delays */
+#define CYCLE_DELAY		10
+#define TIMEOUT			(HZ / 2)
+
+
+static void *ioaddr;
+
+/* The sav GPIO registers don't have individual masks for each bit
+   so we always have to read before writing. */
+
+static void bit_savi2c_setscl(void *data, int val)
+{
+	unsigned int r;
+	r = readl(ioaddr + REG);
+	if(val)
+		r |= I2C_SCL_OUT;
+	else
+		r &= ~I2C_SCL_OUT;
+	writel(r, ioaddr + REG);
+	readl(ioaddr + REG);	/* flush posted write */
+}
+
+static void bit_savi2c_setsda(void *data, int val)
+{
+	unsigned int r;
+	r = readl(ioaddr + REG);
+	if(val)
+		r |= I2C_SDA_OUT;
+	else
+		r &= ~I2C_SDA_OUT;
+	writel(r, ioaddr + REG);
+	readl(ioaddr + REG);	/* flush posted write */
+}
+
+/* The GPIO pins are open drain, so the pins always remain outputs.
+   We rely on the i2c-algo-bit routines to set the pins high before
+   reading the input from other chips. */
+
+static int bit_savi2c_getscl(void *data)
+{
+	return (0 != (readl(ioaddr + REG) & I2C_SCL_IN));
+}
+
+static int bit_savi2c_getsda(void *data)
+{
+	return (0 != (readl(ioaddr + REG) & I2C_SDA_IN));
+}
+
+/* Configures the chip */
+
+static int config_s4(struct pci_dev *dev)
+{
+	unsigned int cadr;
+
+	/* map memory */
+	cadr = dev->resource[0].start;
+	cadr &= PCI_BASE_ADDRESS_MEM_MASK;
+	ioaddr = ioremap_nocache(cadr, 0x0080000);
+	if (ioaddr) {
+		/* writel(0x8160, ioaddr + REG2); */
+		writel(0x00000020, ioaddr + REG);
+		dev_info(&dev->dev, "Using Savage4 at %p\n", ioaddr);
+		return 0;
+	}
+	return -ENODEV;
+}
+
+static struct i2c_algo_bit_data sav_i2c_bit_data = {
+	.setsda		= bit_savi2c_setsda,
+	.setscl		= bit_savi2c_setscl,
+	.getsda		= bit_savi2c_getsda,
+	.getscl		= bit_savi2c_getscl,
+	.udelay		= CYCLE_DELAY,
+	.mdelay		= CYCLE_DELAY,
+	.timeout	= TIMEOUT
+};
+
+static struct i2c_adapter savage4_i2c_adapter = {
+	.owner		= THIS_MODULE,
+	.name		= "I2C Savage4 adapter",
+	.algo_data	= &sav_i2c_bit_data,
+};
+
+static struct pci_device_id savage4_ids[] __devinitdata = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE4) },
+	{ PCI_DEVICE(PCI_VENDOR_ID_S3, PCI_CHIP_SAVAGE2000) },
+	{ 0, }
+};
+
+static int __devinit savage4_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	int retval;
+
+	retval = config_s4(dev);
+	if (retval)
+		return retval;
+
+	/* set up the sysfs linkage to our parent device */
+	savage4_i2c_adapter.dev.parent = &dev->dev;
+
+	return i2c_bit_add_bus(&savage4_i2c_adapter);
+}
+
+static void __devexit savage4_remove(struct pci_dev *dev)
+{
+	i2c_bit_del_bus(&savage4_i2c_adapter);
+	iounmap(ioaddr);
+}
+
+static struct pci_driver savage4_driver = {
+	.name		= "savage4 smbus",
+	.id_table	= savage4_ids,
+	.probe		= savage4_probe,
+	.remove		= __devexit_p(savage4_remove),
+};
+
+static int __init i2c_savage4_init(void)
+{
+	return pci_module_init(&savage4_driver);
+}
+
+static void __exit i2c_savage4_exit(void)
+{
+	pci_unregister_driver(&savage4_driver);
+}
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>, "
+		"Philip Edelbrock <phil@netroedge.com>, "
+		"Ralph Metzler <rjkm@thp.uni-koeln.de>, "
+		"and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_DESCRIPTION("Savage4 I2C/SMBus driver");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_savage4_init);
+module_exit(i2c_savage4_exit);

