Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265598AbUBIXy6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Feb 2004 18:54:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265374AbUBIXVM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Feb 2004 18:21:12 -0500
Received: from mail.kroah.org ([65.200.24.183]:50619 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S265376AbUBIXTi convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Feb 2004 18:19:38 -0500
Subject: [PATCH] i2c driver fixes for 2.6.3-rc1
In-Reply-To: <20040209231301.GA2393@kroah.com>
X-Mailer: gregkh_patchbomb
Date: Mon, 9 Feb 2004 15:19:34 -0800
Message-Id: <10763687741938@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
Content-Transfer-Encoding: 8BIT
From: Greg KH <greg@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1500.11.1, 2004/01/30 16:40:31-08:00, geert@linux-m68k.org

[PATCH] I2C: add Hydra i2c bus driver

Here's a new version, incorporating these comments, and making a few more
changes:
  - Use struct definition in <asm/hydra.h> instead of #defined offset
  - Remove flushes are register writes, they are no longer needed
  - Use pci_resource_start() instead of dev->resource[].start
  - ioremap() the whole resource instead of the first 256 bytes
  - Check for errors returned by ioremap() and i2c_bit_add_bus()
  - Add resource management
  - Call iounmap() in hydra_remove() instead of in i2c_hydra_exit()
  - Let I2C_HYDRA depend on I2C and select I2C_ALGOBIT instead of depending on
    I2C_ALGOBIT


 drivers/i2c/busses/Kconfig     |   12 ++
 drivers/i2c/busses/Makefile    |    1 
 drivers/i2c/busses/i2c-hydra.c |  186 +++++++++++++++++++++++++++++++++++++++++
 3 files changed, 199 insertions(+)


diff -Nru a/drivers/i2c/busses/Kconfig b/drivers/i2c/busses/Kconfig
--- a/drivers/i2c/busses/Kconfig	Mon Feb  9 15:06:07 2004
+++ b/drivers/i2c/busses/Kconfig	Mon Feb  9 15:06:07 2004
@@ -69,6 +69,18 @@
 	  This support is also available as a module.  If so, the module 
 	  will be called i2c-elv.
 
+config I2C_HYDRA
+	tristate "CHRP Apple Hydra Mac I/O I2C interface"
+	depends on I2C && PCI && PPC_CHRP && EXPERIMENTAL
+	select I2C_ALGOBIT
+	help
+	  This supports the use of the I2C interface in the Apple Hydra Mac
+	  I/O chip on some CHRP machines (e.g. the LongTrail).  Say Y if you
+	  have such a machine.
+
+	  This support is also available as a module.  If so, the module
+	  will be called i2c-hydra.
+
 config I2C_I801
 	tristate "Intel 801"
 	depends on I2C && PCI && EXPERIMENTAL
diff -Nru a/drivers/i2c/busses/Makefile b/drivers/i2c/busses/Makefile
--- a/drivers/i2c/busses/Makefile	Mon Feb  9 15:06:07 2004
+++ b/drivers/i2c/busses/Makefile	Mon Feb  9 15:06:07 2004
@@ -8,6 +8,7 @@
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_ELV)		+= i2c-elv.o
+obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_I810)		+= i2c-i810.o
 obj-$(CONFIG_I2C_IBM_IIC)	+= i2c-ibm_iic.o
diff -Nru a/drivers/i2c/busses/i2c-hydra.c b/drivers/i2c/busses/i2c-hydra.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/drivers/i2c/busses/i2c-hydra.c	Mon Feb  9 15:06:07 2004
@@ -0,0 +1,186 @@
+/*
+    i2c-hydra.c - Part of lm_sensors,  Linux kernel modules
+                  for hardware monitoring
+
+    i2c Support for the Apple `Hydra' Mac I/O
+
+    Copyright (c) 1999-2004 Geert Uytterhoeven <geert@linux-m68k.org>
+
+    Based on i2c Support for Via Technologies 82C586B South Bridge
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
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/init.h>
+#include <asm/io.h>
+#include <asm/hydra.h>
+
+
+#define HYDRA_CPD_PD0	0x00000001	/* CachePD lines */
+#define HYDRA_CPD_PD1	0x00000002
+#define HYDRA_CPD_PD2	0x00000004
+#define HYDRA_CPD_PD3	0x00000008
+
+#define HYDRA_SCLK	HYDRA_CPD_PD0
+#define HYDRA_SDAT	HYDRA_CPD_PD1
+#define HYDRA_SCLK_OE	0x00000010
+#define HYDRA_SDAT_OE	0x00000020
+
+static inline void pdregw(void *data, u32 val)
+{
+	struct Hydra *hydra = (struct Hydra *)data;
+	writel(val, &hydra->CachePD);
+}
+
+static inline u32 pdregr(void *data)
+{
+	struct Hydra *hydra = (struct Hydra *)data;
+	return readl(&hydra->CachePD);
+}
+
+static void hydra_bit_setscl(void *data, int state)
+{
+	u32 val = pdregr(data);
+	if (state)
+		val &= ~HYDRA_SCLK_OE;
+	else {
+		val &= ~HYDRA_SCLK;
+		val |= HYDRA_SCLK_OE;
+	}
+	pdregw(data, val);
+}
+
+static void hydra_bit_setsda(void *data, int state)
+{
+	u32 val = pdregr(data);
+	if (state)
+		val &= ~HYDRA_SDAT_OE;
+	else {
+		val &= ~HYDRA_SDAT;
+		val |= HYDRA_SDAT_OE;
+	}
+	pdregw(data, val);
+}
+
+static int hydra_bit_getscl(void *data)
+{
+	return (pdregr(data) & HYDRA_SCLK) != 0;
+}
+
+static int hydra_bit_getsda(void *data)
+{
+	return (pdregr(data) & HYDRA_SDAT) != 0;
+}
+
+/* ------------------------------------------------------------------------ */
+
+static struct i2c_algo_bit_data hydra_bit_data = {
+	.setsda		= hydra_bit_setsda,
+	.setscl		= hydra_bit_setscl,
+	.getsda		= hydra_bit_getsda,
+	.getscl		= hydra_bit_getscl,
+	.udelay		= 5,
+	.mdelay		= 5,
+	.timeout	= HZ
+};
+
+static struct i2c_adapter hydra_adap = {
+	.owner		= THIS_MODULE,
+	.name		= "Hydra i2c",
+	.id		= I2C_HW_B_HYDRA,
+	.algo_data	= &hydra_bit_data,
+};
+
+static struct pci_device_id hydra_ids[] = {
+	{
+		.vendor		= PCI_VENDOR_ID_APPLE,
+		.device		= PCI_DEVICE_ID_APPLE_HYDRA,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{ 0, }
+};
+
+static int __devinit hydra_probe(struct pci_dev *dev,
+				 const struct pci_device_id *id)
+{
+	unsigned long base = pci_resource_start(dev, 0);
+	int res;
+
+	if (!request_mem_region(base+offsetof(struct Hydra, CachePD), 4,
+				hydra_adap.name))
+		return -EBUSY;
+
+	hydra_bit_data.data = ioremap(base, pci_resource_len(dev, 0));
+	if (hydra_bit_data.data == NULL) {
+		release_mem_region(base+offsetof(struct Hydra, CachePD), 4);
+		return -ENODEV;
+	}
+
+	pdregw(hydra_bit_data.data, 0);		/* clear SCLK_OE and SDAT_OE */
+	hydra_adap.dev.parent = &dev->dev;
+	res = i2c_bit_add_bus(&hydra_adap);
+	if (res < 0) {
+		iounmap(hydra_bit_data.data);
+		release_mem_region(base+offsetof(struct Hydra, CachePD), 4);
+		return res;
+	}
+	return 0;
+}
+
+static void __devexit hydra_remove(struct pci_dev *dev)
+{
+	pdregw(hydra_bit_data.data, 0);		/* clear SCLK_OE and SDAT_OE */
+	i2c_bit_del_bus(&hydra_adap);
+	iounmap(hydra_bit_data.data);
+	release_mem_region(pci_resource_start(dev, 0)+
+			   offsetof(struct Hydra, CachePD), 4);
+}
+
+
+static struct pci_driver hydra_driver = {
+	.name		= "hydra smbus",
+	.id_table	= hydra_ids,
+	.probe		= hydra_probe,
+	.remove		= __devexit_p(hydra_remove),
+};
+
+static int __init i2c_hydra_init(void)
+{
+	return pci_module_init(&hydra_driver);
+}
+
+
+static void __exit i2c_hydra_exit(void)
+{
+	pci_unregister_driver(&hydra_driver);
+}
+
+
+
+MODULE_AUTHOR("Geert Uytterhoeven <geert@linux-m68k.org>");
+MODULE_DESCRIPTION("i2c for Apple Hydra Mac I/O");
+MODULE_LICENSE("GPL");
+
+module_init(i2c_hydra_init);
+module_exit(i2c_hydra_exit);
+

