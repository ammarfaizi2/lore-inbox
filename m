Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261743AbTELAxt (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 May 2003 20:53:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261775AbTELAxt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 May 2003 20:53:49 -0400
Received: from charger.oldcity.dca.net ([207.245.82.76]:28290 "EHLO
	charger.oldcity.dca.net") by vger.kernel.org with ESMTP
	id S261743AbTELAxj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 May 2003 20:53:39 -0400
Date: Sun, 11 May 2003 21:06:13 -0400
From: "Mark M. Hoffman" <mhoffman@lightlink.com>
To: LKML <linux-kernel@vger.kernel.org>,
       Sensors <sensors@stimpy.netroedge.com>
Cc: Greg KH <greg@kroah.com>
Subject: [PATCH] Add SiS96x I2C/SMBus driver (vs 2.5.69-bk6)
Message-ID: <20030512010613.GA12130@earth.solarsys.private>
Mail-Followup-To: LKML <linux-kernel@vger.kernel.org>,
	Sensors <sensors@stimpy.netroedge.com>, Greg KH <greg@kroah.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="liOOAslEiF7prFVr"
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

This patch adds support for the SMBus of SiS96x south
bridges.  It is based on i2c-sis645.c from the lm sensors
project, which never made it into an official kernel and
was anyway mis-named.

This driver works on my SiS 645/961 board vs w83781d.

BTW, w83781d does not rmmod cleanly at 2.5.69-bk6.  It
does rmmod cleanly at 2.5.69.  I can provide more info
if needed.

Please CC me w/ comments.

Regards,

-- 
Mark M. Hoffman
mhoffman@lightlink.com


--liOOAslEiF7prFVr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="sis96x-2.5.69-bk6-patch"

--- /dev/null	2003-01-30 05:24:37.000000000 -0500
+++ linux-2.5.69-bk6/drivers/i2c/busses/i2c-sis96x.c	2003-05-11 20:33:20.000000000 -0400
@@ -0,0 +1,376 @@
+/*
+    sis96x.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+
+    Copyright (c) 2003 Mark M. Hoffman <mhoffman@lightlink.com>
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
+/*
+    This module must be considered BETA unless and until
+    the chipset manufacturer releases a datasheet.
+    The register definitions are based on the SiS630.
+
+    This module relies on quirk_sis_96x_smbus (drivers/pci/quirks.c)
+    for just about every machine for which users have reported.
+    If this module isn't detecting your 96x south bridge, have a 
+    look there.
+
+    We assume there can only be one SiS96x with one SMBus interface.
+*/
+
+/* #define DEBUG */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <asm/io.h>
+
+/*
+	HISTORY:
+	2003-05-11	1.0.0 	Updated from lm_sensors project for kernel 2.5
+				(was i2c-sis645.c from lm_sensors 2.7.0)
+*/
+#define SIS96x_VERSION "1.0.0"
+
+/* SiS96x SMBus PCI device ID */
+#define PCI_DEVICE_ID_SI_SMBUS 0x16
+
+/* base address register in PCI config space */
+#define SIS96x_BAR 0x04
+
+/* SiS96x SMBus registers */
+#define SMB_STS      0x00
+#define SMB_EN       0x01
+#define SMB_CNT      0x02
+#define SMB_HOST_CNT 0x03
+#define SMB_ADDR     0x04
+#define SMB_CMD      0x05
+#define SMB_PCOUNT   0x06
+#define SMB_COUNT    0x07
+#define SMB_BYTE     0x08
+#define SMB_DEV_ADDR 0x10
+#define SMB_DB0      0x11
+#define SMB_DB1      0x12
+#define SMB_SAA      0x13
+
+/* register count for request_region */
+#define SMB_IOSIZE 0x20
+
+/* Other settings */
+#define MAX_TIMEOUT 500
+
+/* SiS96x SMBus constants */
+#define SIS96x_QUICK      0x00
+#define SIS96x_BYTE       0x01
+#define SIS96x_BYTE_DATA  0x02
+#define SIS96x_WORD_DATA  0x03
+#define SIS96x_PROC_CALL  0x04
+#define SIS96x_BLOCK_DATA 0x05
+
+static struct i2c_adapter sis96x_adapter;
+static u16 sis96x_smbus_base = 0;
+
+static inline u8 sis96x_read(u8 reg)
+{
+	return inb(sis96x_smbus_base + reg) ;
+}
+
+static inline void sis96x_write(u8 reg, u8 data)
+{
+	outb(data, sis96x_smbus_base + reg) ;
+}
+
+/* Internally used pause function */
+static void sis96x_do_pause(unsigned int amount)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+/* Execute a SMBus transaction.
+   int size is from SIS96x_QUICK to SIS96x_BLOCK_DATA
+ */
+static int sis96x_transaction(int size)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+	dev_dbg(&sis96x_adapter.dev, "SMBus transaction %d\n", size);
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	if (((temp = sis96x_read(SMB_CNT)) & 0x03) != 0x00) {
+
+		dev_dbg(&sis96x_adapter.dev, "SMBus busy (0x%02x). "
+			"Resetting...\n", temp);
+
+		/* kill the transaction */
+		sis96x_write(SMB_HOST_CNT, 0x20);
+
+		/* check it again */
+		if (((temp = sis96x_read(SMB_CNT)) & 0x03) != 0x00) {
+			dev_dbg(&sis96x_adapter.dev, "Failed (0x%02x)\n", temp);
+			return -1;
+		} else {
+			dev_dbg(&sis96x_adapter.dev, "Successful\n");
+		}
+	}
+
+	/* Turn off timeout interrupts, set fast host clock */
+	sis96x_write(SMB_CNT, 0x20);
+
+	/* clear all (sticky) status flags */
+	temp = sis96x_read(SMB_STS);
+	sis96x_write(SMB_STS, temp & 0x1e);
+
+	/* start the transaction by setting bit 4 and size bits */
+	sis96x_write(SMB_HOST_CNT, 0x10 | (size & 0x07));
+
+	/* We will always wait for a fraction of a second! */
+	do {
+		sis96x_do_pause(1);
+		temp = sis96x_read(SMB_STS);
+	} while (!(temp & 0x0e) && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+		dev_dbg(&sis96x_adapter.dev, "SMBus Timeout! (0x%02x)\n", temp);
+		result = -1;
+	}
+
+	/* device error - probably missing ACK */
+	if (temp & 0x02) {
+		dev_dbg(&sis96x_adapter.dev, "Failed bus transaction!\n");
+		result = -1;
+	}
+
+	/* bus collision */
+	if (temp & 0x04) {
+		dev_dbg(&sis96x_adapter.dev, "Bus collision!\n");
+		result = -1;
+	}
+
+	/* Finish up by resetting the bus */
+	sis96x_write(SMB_STS, temp);
+	if ((temp = sis96x_read(SMB_STS))) {
+		dev_dbg(&sis96x_adapter.dev, "Failed reset at "
+			"end of transaction! (0x%02x)\n", temp);
+	}
+
+	return result;
+}
+
+/* Return -1 on error. */
+static s32 sis96x_access(struct i2c_adapter * adap, u16 addr,
+			 unsigned short flags, char read_write,
+			 u8 command, int size, union i2c_smbus_data * data)
+{
+
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+		sis96x_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
+		size = SIS96x_QUICK;
+		break;
+
+	case I2C_SMBUS_BYTE:
+		sis96x_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
+		if (read_write == I2C_SMBUS_WRITE)
+			sis96x_write(SMB_CMD, command);
+		size = SIS96x_BYTE;
+		break;
+
+	case I2C_SMBUS_BYTE_DATA:
+		sis96x_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
+		sis96x_write(SMB_CMD, command);
+		if (read_write == I2C_SMBUS_WRITE)
+			sis96x_write(SMB_BYTE, data->byte);
+		size = SIS96x_BYTE_DATA;
+		break;
+
+	case I2C_SMBUS_PROC_CALL:
+	case I2C_SMBUS_WORD_DATA:
+		sis96x_write(SMB_ADDR, ((addr & 0x7f) << 1) | (read_write & 0x01));
+		sis96x_write(SMB_CMD, command);
+		if (read_write == I2C_SMBUS_WRITE) {
+			sis96x_write(SMB_BYTE, data->word & 0xff);
+			sis96x_write(SMB_BYTE + 1, (data->word & 0xff00) >> 8);
+		}
+		size = (size == I2C_SMBUS_PROC_CALL ? 
+			SIS96x_PROC_CALL : SIS96x_WORD_DATA);
+		break;
+
+	case I2C_SMBUS_BLOCK_DATA:
+		/* TO DO: */
+		dev_info(&adap->dev, "SMBus block not implemented!\n");
+		return -1;
+		break;
+
+	default:
+		dev_info(&adap->dev, "Unsupported I2C size\n");
+		return -1;
+		break;
+	}
+
+	if (sis96x_transaction(size))
+		return -1;
+
+	if ((size != SIS96x_PROC_CALL) &&
+		((read_write == I2C_SMBUS_WRITE) || (size == SIS96x_QUICK)))
+		return 0;
+
+	switch (size) {
+	case SIS96x_BYTE:
+	case SIS96x_BYTE_DATA:
+		data->byte = sis96x_read(SMB_BYTE);
+		break;
+
+	case SIS96x_WORD_DATA:
+	case SIS96x_PROC_CALL:
+		data->word = sis96x_read(SMB_BYTE) +
+				(sis96x_read(SMB_BYTE + 1) << 8);
+		break;
+	}
+	return 0;
+}
+
+static u32 sis96x_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_PROC_CALL;
+}
+
+static struct i2c_algorithm smbus_algorithm = {
+	.name		= "Non-I2C SMBus adapter",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= sis96x_access,
+	.functionality	= sis96x_func,
+};
+
+static struct i2c_adapter sis96x_adapter = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_SIS96X,
+	.class		= I2C_ADAP_CLASS_SMBUS,
+	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	="unset",
+	},
+};
+
+static struct pci_device_id sis96x_ids[] __devinitdata = {
+
+	{
+		.vendor	=	PCI_VENDOR_ID_SI,
+		.device =	PCI_DEVICE_ID_SI_SMBUS,
+		.subvendor =	PCI_ANY_ID,
+		.subdevice =	PCI_ANY_ID,
+	},
+
+	{ 0, }
+};
+
+static int __devinit sis96x_probe(struct pci_dev *dev,
+				const struct pci_device_id *id)
+{
+	u16 ww = 0;
+	int retval;
+
+	if (sis96x_smbus_base) {
+		dev_err(&dev->dev, "Only one device supported.\n");
+		return -EBUSY;
+	}
+
+	pci_read_config_word(dev, PCI_CLASS_DEVICE, &ww);
+	if (PCI_CLASS_SERIAL_SMBUS != ww) {
+		dev_err(&dev->dev, "Unsupported device class 0x%04x!\n", ww);
+		return -ENODEV;
+	}
+
+	sis96x_smbus_base = pci_resource_start(dev, SIS96x_BAR);
+	if (!sis96x_smbus_base) {
+		dev_err(&dev->dev, "SiS96x SMBus base address "
+			"not initialized!\n");
+		return -EINVAL;
+	}
+	dev_info(&dev->dev, "SiS96x SMBus base address: 0x%04x\n",
+			sis96x_smbus_base);
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	if (!request_region(sis96x_smbus_base, SMB_IOSIZE, "sis96x-smbus")) {
+		dev_err(&dev->dev, "SMBus registers 0x%04x-0x%04x "
+			"already in use!\n", sis96x_smbus_base,
+			sis96x_smbus_base + SMB_IOSIZE - 1);
+
+		sis96x_smbus_base = 0;
+		return -EINVAL;
+	}
+
+	/* set up the driverfs linkage to our parent device */
+        sis96x_adapter.dev.parent = &dev->dev;
+
+        snprintf(sis96x_adapter.dev.name, DEVICE_NAME_SIZE,
+                "SiS96x SMBus adapter at 0x%04x", sis96x_smbus_base);
+
+        if ((retval = i2c_add_adapter(&sis96x_adapter))) {
+		dev_err(&dev->dev, "Couldn't register adapter!\n");
+		release_region(sis96x_smbus_base, SMB_IOSIZE);
+		sis96x_smbus_base = 0;
+	}
+
+	return retval;
+}
+
+static void __devexit sis96x_remove(struct pci_dev *dev)
+{
+	if (sis96x_smbus_base) {
+		i2c_del_adapter(&sis96x_adapter);
+		release_region(sis96x_smbus_base, SMB_IOSIZE);
+		sis96x_smbus_base = 0;
+	}
+}
+
+static struct pci_driver sis96x_driver = {
+	.name		= "sis96x smbus",
+	.id_table	= sis96x_ids,
+	.probe		= sis96x_probe,
+	.remove		= __devexit_p(sis96x_remove),
+};
+
+static int __init i2c_sis96x_init(void)
+{
+	printk(KERN_INFO "i2c-sis96x version %s\n", SIS96x_VERSION);
+	return pci_module_init(&sis96x_driver);
+}
+
+static void __exit i2c_sis96x_exit(void)
+{
+	pci_unregister_driver(&sis96x_driver);
+}
+
+MODULE_AUTHOR("Mark M. Hoffman <mhoffman@lightlink.com>");
+MODULE_DESCRIPTION("SiS96x SMBus driver");
+MODULE_LICENSE("GPL");
+
+/* Register initialization functions using helper macros */
+module_init(i2c_sis96x_init);
+module_exit(i2c_sis96x_exit);
+
--- linux-2.5.69-bk6/drivers/i2c/busses/Kconfig.orig	2003-05-04 19:53:40.000000000 -0400
+++ linux-2.5.69-bk6/drivers/i2c/busses/Kconfig	2003-05-11 18:50:47.000000000 -0400
@@ -117,6 +117,31 @@
 	  http://www.lm-sensors.nu
 
 
+config I2C_SIS96X
+	tristate "  SiS 96x"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+	  If you say yes to this option, support will be included for the SiS
+	  96x SMBus (a subset of I2C) interfaces.  Specifically, the following
+	  chipsets are supported:
+	    645/961
+	    645DX/961
+	    645DX/962
+	    648/961
+	    650/961
+	    735
+
+	  This can also be built as a module which can be inserted and removed 
+	  while the kernel is running.  If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  The module will be called i2c-sis96x.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at 
+	  http://www.lm-sensors.nu
+
+
 config I2C_VIAPRO
 	tristate "  VIA 82C596/82C686/823x"
 	depends on I2C && PCI && EXPERIMENTAL
--- linux-2.5.69-bk6/drivers/i2c/busses/Makefile.orig	2003-05-04 19:53:01.000000000 -0400
+++ linux-2.5.69-bk6/drivers/i2c/busses/Makefile	2003-05-11 18:50:47.000000000 -0400
@@ -8,4 +8,5 @@
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
+obj-$(CONFIG_I2C_SIS96X)	+= i2c-sis96x.o
 obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
--- linux-2.5.69-bk6/drivers/pci/quirks.c.orig	2003-05-04 19:52:49.000000000 -0400
+++ linux-2.5.69-bk6/drivers/pci/quirks.c	2003-05-11 18:50:47.000000000 -0400
@@ -647,6 +647,37 @@
 }
 
 /*
+ * SiS 96x south bridge: BIOS typically hides SMBus device...
+ */
+static void __init quirk_sis_96x_smbus(struct pci_dev *dev)
+{
+	u8 val = 0;
+	printk(KERN_INFO "Enabling SiS 96x SMBus.\n");
+	pci_read_config_byte(dev, 0x77, &val);
+	pci_write_config_byte(dev, 0x77, val & ~0x10);
+	pci_read_config_byte(dev, 0x77, &val);
+}
+
+/*
+ * ... This is further complicated by the fact that some SiS96x south
+ * bridges pretend to be 85C503/5513 instead.  In that case see if we
+ * spotted a compatible north bridge to make sure.
+ * (pci_find_device doesn't work yet)
+ */
+static int __devinitdata sis_96x_compatible = 0;
+
+static void __init quirk_sis_503_smbus(struct pci_dev *dev)
+{
+	if (sis_96x_compatible)
+		quirk_sis_96x_smbus(dev);
+}
+
+static void __init quirk_sis_96x_compatible(struct pci_dev *dev)
+{
+	sis_96x_compatible = 1;
+}
+
+/*
  *  The main table of quirks.
  */
 
@@ -679,6 +710,15 @@
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_INTEL, 	PCI_DEVICE_ID_INTEL_82443BX_2, 	quirk_natoma },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_5597,		quirk_nopcipci },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_496,		quirk_nopcipci },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_503,		quirk_sis_503_smbus },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_645,		quirk_sis_96x_compatible },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_646,		quirk_sis_96x_compatible },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_648,		quirk_sis_96x_compatible },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_650,		quirk_sis_96x_compatible },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_651,		quirk_sis_96x_compatible },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_961,		quirk_sis_96x_smbus },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_962,		quirk_sis_96x_smbus },
+	{ PCI_FIXUP_HEADER,	PCI_VENDOR_ID_SI,	PCI_DEVICE_ID_SI_963,		quirk_sis_96x_smbus },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1647, 	quirk_alimagik },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_AL, 	PCI_DEVICE_ID_AL_M1651, 	quirk_alimagik },
 	{ PCI_FIXUP_FINAL,	PCI_VENDOR_ID_VIA,	PCI_DEVICE_ID_VIA_8363_0,	quirk_vialatency },
--- linux-2.5.69-bk6/include/linux/i2c-id.h.orig	2003-05-04 19:53:01.000000000 -0400
+++ linux-2.5.69-bk6/include/linux/i2c-id.h	2003-05-11 18:50:47.000000000 -0400
@@ -245,7 +245,7 @@
 #define I2C_HW_SMBUS_SIS5595	0x06
 #define I2C_HW_SMBUS_ALI1535	0x07
 #define I2C_HW_SMBUS_SIS630	0x08
-#define I2C_HW_SMBUS_SIS645	0x09
+#define I2C_HW_SMBUS_SIS96X	0x09
 #define I2C_HW_SMBUS_AMD8111	0x0a
 #define I2C_HW_SMBUS_SCX200	0x0b
 #define I2C_HW_SMBUS_NFORCE2	0x0c
--- linux-2.5.69-bk6/include/linux/pci_ids.h.orig	2003-05-04 19:53:13.000000000 -0400
+++ linux-2.5.69-bk6/include/linux/pci_ids.h	2003-05-11 18:50:47.000000000 -0400
@@ -569,6 +569,9 @@
 #define PCI_DEVICE_ID_SI_751		0x0751
 #define PCI_DEVICE_ID_SI_752		0x0752
 #define PCI_DEVICE_ID_SI_900		0x0900
+#define PCI_DEVICE_ID_SI_961		0x0961
+#define PCI_DEVICE_ID_SI_962		0x0962
+#define PCI_DEVICE_ID_SI_963		0x0963
 #define PCI_DEVICE_ID_SI_5107		0x5107
 #define PCI_DEVICE_ID_SI_5300		0x5300
 #define PCI_DEVICE_ID_SI_5511		0x5511

--liOOAslEiF7prFVr--
