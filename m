Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262678AbTIVXtc (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 22 Sep 2003 19:49:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262637AbTIVXsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 22 Sep 2003 19:48:43 -0400
Received: from mail.kroah.org ([65.200.24.183]:12705 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262738AbTIVXbA convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 22 Sep 2003 19:31:00 -0400
Content-Type: text/plain; charset="iso-8859-1"
Message-Id: <10642734202631@kroah.com>
Subject: Re: [PATCH] i2c driver fixes for 2.6.0-test5
In-Reply-To: <10642734202220@kroah.com>
From: Greg KH <greg@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 22 Sep 2003 16:30:20 -0700
Content-Transfer-Encoding: 8BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1315.1.4, 2003/09/15 16:37:19-07:00, greg@kroah.com

[PATCH] I2C: add the i2c-via i2c bus driver

This is based on the lmsensor cvs version of the driver, but is cleaned
it up and ported it to 2.6.


 drivers/i2c/busses/Kconfig   |   17 +++
 drivers/i2c/busses/Makefile  |    1 
 drivers/i2c/busses/i2c-via.c |  183 +++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 201 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Sep 22 16:15:36 2003
+++ b/drivers/i2c/busses/Kconfig	Mon Sep 22 16:15:36 2003
@@ -207,6 +207,23 @@
 	  in the lm_sensors package, which you can download at 
 	  http://www.lm-sensors.nu
 
+config I2C_VIA
+	tristate "  VIA 82C58B"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+
+	  If you say yes to this option, support will be included for the VIA
+          82C586B I2C interface
+
+	  This can also be built as a module which can be inserted and removed
+	  while the kernel is running.  If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  The module will be called i2c-via.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at
+	  http://www.lm-sensors.nu
 
 config I2C_VIAPRO
 	tristate "  VIA 82C596/82C686/823x"
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Sep 22 16:15:36 2003
+++ b/drivers/i2c/busses/Makefile	Mon Sep 22 16:15:36 2003
@@ -13,4 +13,5 @@
 obj-$(CONFIG_I2C_SIS5595)	+= i2c-sis5595.o
 obj-$(CONFIG_I2C_SIS630)	+= i2c-sis630.o
 obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
+obj-$(CONFIG_I2C_VIA)		+= i2c-via.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
diff -Nru a/drivers/i2c/busses/i2c-via.c b/drivers/i2c/busses/i2c-via.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-via.c	Mon Sep 22 16:15:36 2003
@@ -0,0 +1,183 @@
+/*
+    i2c-via.c - Part of lm_sensors,  Linux kernel modules
+                for hardware monitoring
+
+    i2c Support for Via Technologies 82C586B South Bridge
+
+    Copyright (c) 1998, 1999 Kyösti Mälkki <kmalkki@cc.hut.fi>
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
+#define DEBUG
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+
+/* Power management registers */
+#define PM_CFG_REVID	0x08	/* silicon revision code */
+#define PM_CFG_IOBASE0	0x20
+#define PM_CFG_IOBASE1	0x48
+
+#define I2C_DIR		(pm_io_base+0x40)
+#define I2C_OUT		(pm_io_base+0x42)
+#define I2C_IN		(pm_io_base+0x44)
+#define I2C_SCL		0x02	/* clock bit in DIR/OUT/IN register */
+#define I2C_SDA		0x04
+
+/* io-region reservation */
+#define IOSPACE		0x06
+#define IOTEXT		"via-i2c"
+
+static u16 pm_io_base = 0;
+
+/*
+   It does not appear from the datasheet that the GPIO pins are
+   open drain. So a we set a low value by setting the direction to
+   output and a high value by setting the direction to input and
+   relying on the required I2C pullup. The data value is initialized
+   to 0 in via_init() and never changed.
+*/
+static void bit_via_setscl(void *data, int state)
+{
+	outb(state ? inb(I2C_DIR) & ~I2C_SCL : inb(I2C_DIR) | I2C_SCL, I2C_DIR);
+}
+
+static void bit_via_setsda(void *data, int state)
+{
+	outb(state ? inb(I2C_DIR) & ~I2C_SDA : inb(I2C_DIR) | I2C_SDA, I2C_DIR);
+}
+
+static int bit_via_getscl(void *data)
+{
+	return (0 != (inb(I2C_IN) & I2C_SCL));
+}
+
+static int bit_via_getsda(void *data)
+{
+	return (0 != (inb(I2C_IN) & I2C_SDA));
+}
+
+
+static struct i2c_algo_bit_data bit_data = {
+	.setsda		= bit_via_setsda,
+	.setscl		= bit_via_setscl,
+	.getsda		= bit_via_getsda,
+	.getscl		= bit_via_getscl,
+	.udelay		= 5,
+	.mdelay		= 5,
+	.timeout	= HZ
+};
+
+static struct i2c_adapter vt586b_adapter = {
+	.owner		= THIS_MODULE,
+	.name		= "VIA i2c",
+	.algo_data	= &bit_data,
+};
+
+
+static struct pci_device_id vt586b_ids[] __devinitdata = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_VIA, PCI_DEVICE_ID_VIA_82C586_3) },
+	{ 0, }
+};
+
+static int __devinit vt586b_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	u16 base;
+	u8 rev;
+	int res;
+
+	if (pm_io_base) {
+		dev_err(&dev->dev, "i2c-via: Will only support one host\n");
+		return -ENODEV;
+	}
+
+	pci_read_config_byte(dev, PM_CFG_REVID, &rev);
+
+	switch (rev) {
+	case 0x00:
+		base = PM_CFG_IOBASE0;
+		break;
+	case 0x01:
+	case 0x10:
+		base = PM_CFG_IOBASE1;
+		break;
+
+	default:
+		base = PM_CFG_IOBASE1;
+		/* later revision */
+	}
+
+	pci_read_config_word(dev, base, &pm_io_base);
+	pm_io_base &= (0xff << 8);
+
+	if (!request_region(I2C_DIR, IOSPACE, IOTEXT)) {
+		dev_err(&dev->dev, "IO 0x%x-0x%x already in use\n", I2C_DIR, I2C_DIR + IOSPACE);
+		return -ENODEV;
+	}
+
+	outb(inb(I2C_DIR) & ~(I2C_SDA | I2C_SCL), I2C_DIR);
+	outb(inb(I2C_OUT) & ~(I2C_SDA | I2C_SCL), I2C_OUT);
+
+	/* set up the driverfs linkage to our parent device */
+	vt586b_adapter.dev.parent = &dev->dev;
+
+	res = i2c_bit_add_bus(&vt586b_adapter);
+	if ( res < 0 ) {
+		release_region(I2C_DIR, IOSPACE);
+		pm_io_base = 0;
+		return res;
+	}
+	return 0;
+}
+
+static void __devexit vt586b_remove(struct pci_dev *dev)
+{
+	i2c_bit_del_bus(&vt586b_adapter);
+	release_region(I2C_DIR, IOSPACE);
+	pm_io_base = 0;
+}
+
+
+static struct pci_driver vt586b_driver = {
+	.name		= "vt586b smbus",
+	.id_table	= vt586b_ids,
+	.probe		= vt586b_probe,
+	.remove		= __devexit_p(vt586b_remove),
+};
+
+static int __init i2c_vt586b_init(void)
+{
+	printk(KERN_INFO "i2c-via version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	return pci_module_init(&vt586b_driver);
+}
+
+static void __exit i2c_vt586b_exit(void)
+{
+	pci_unregister_driver(&vt586b_driver);
+}
+
+
+MODULE_AUTHOR("Kyösti Mälkki <kmalkki@cc.hut.fi>");
+MODULE_DESCRIPTION("i2c for Via vt82c586b southbridge");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_vt586b_init);
+module_exit(i2c_vt586b_exit);

