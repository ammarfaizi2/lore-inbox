Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261546AbUJXRjz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261546AbUJXRjz (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 24 Oct 2004 13:39:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261564AbUJXRjz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 24 Oct 2004 13:39:55 -0400
Received: from smtp-100-sunday.noc.nerim.net ([62.4.17.100]:5132 "EHLO
	mallaury.noc.nerim.net") by vger.kernel.org with ESMTP
	id S261546AbUJXRje (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 24 Oct 2004 13:39:34 -0400
Date: Sun, 24 Oct 2004 19:40:53 +0200
From: Jean Delvare <khali@linux-fr.org>
To: Greg KH <greg@kroah.com>
Cc: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: More on SMBus multiplexing
Message-Id: <20041024194053.36aefdc2.khali@linux-fr.org>
In-Reply-To: <20041024123557.744414cc.khali@linux-fr.org>
References: <20041023200215.38e375a1.khali@linux-fr.org>
	<20041024123557.744414cc.khali@linux-fr.org>
Reply-To: LM Sensors <sensors@stimpy.netroedge.com>,
       LKML <linux-kernel@vger.kernel.org>
X-Mailer: Sylpheed version 0.9.99 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

Would you accept such a patch? This adds Tyan S4882-specific SMBus
multiplexing support, in the form of a separate driver, as per Mark
Hoffman's suggestion.

Changes to the original driver (i2c-amd756) are kept to a minimum:

1* The i2c_adapter structure is exported (some noise due to a struct
name change, I didn't want to export something as vague as
"amd756_adapter").

2* Autoload of the new driver (i2c-amd756-s4882) when needed. This can
go away if you don't like it, but I thought it'd be more convenient for
the end user. BTW, what will happen if the i2c-amd756-s4882 module
doesn't exist? Should I add some #ifdef magic in the i2c-amd756 driver
so that the autoload will not happen if the i2c-amd756-s4882 module was
not selected?

The i2c-amd756-s4882 driver follows Mark Hoffman's suggestion, but in a
simplified way. On load:

1* Remove the physical adapter from the main i2c adapters list. As a
side effect, any client gets kicked off.

2* Register 5 virtual busses using to wrappers pointing to the original
SMBus code. Clients can connect to the new adapters where it makes
sense.

On unload, same thing but the other way around.

This approach has a drawback in the case several client drivers are
already loaded (they will get attached, detached and attached again in a
raw), but I don't think this is really a problem:

1* In most cases bus drivers are loaded before clients anyway.

2* SMBus multiplexing is quite rare, and I don't care if people with
such specific boards experience drawbacks at init time in uncommon
cases.

Advantages of the approach, however, are great. Multiplexing code
belongs to a different driver, which improves maintainability as Mark
pointed out, and means no impact on module size nor performance for
regular users. The whole thing is also almost transparent for userspace
and client drivers, requiring very very little change, if any at all.

Greg, anyone, comments on the approach and code are welcome. If
everyone's OK, we'll go that way for both the 2.6 kernel and lm_sensors
(for 2.4).

Thanks.

diff -ruN linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/Kconfig linux-2.6.9-rc4-bk1/drivers/i2c/busses/Kconfig
--- linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/Kconfig	2004-10-16 19:37:33.000000000 +0200
+++ linux-2.6.9-rc4-bk1/drivers/i2c/busses/Kconfig	2004-10-24 18:46:53.000000000 +0200
@@ -51,6 +51,17 @@
 	  This driver can also be built as a module.  If so, the module
 	  will be called i2c-amd756.
 
+config I2C_AMD756_S4882
+	tristate "SMBus multiplexing on the Tyan S4882"
+	depends on I2C_AMD756 && EXPERIMENTAL
+	default y
+	help
+	  Enabling this option will add specific SMBus support for the Tyan
+	  S4882 motherboard.  On this 4-CPU board, the SMBus is multiplexed
+	  over 8 different channels, where the various memory module EEPROMs
+	  and temperature sensors live.  Saying yes here will give you access
+	  to these in addition to the trunk.
+
 config I2C_AMD8111
 	tristate "AMD 8111"
 	depends on I2C && PCI && EXPERIMENTAL
diff -ruN linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/Makefile linux-2.6.9-rc4-bk1/drivers/i2c/busses/Makefile
--- linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/Makefile	2004-10-12 19:44:25.000000000 +0200
+++ linux-2.6.9-rc4-bk1/drivers/i2c/busses/Makefile	2004-10-23 22:55:45.000000000 +0200
@@ -6,6 +6,7 @@
 obj-$(CONFIG_I2C_ALI1563)	+= i2c-ali1563.o
 obj-$(CONFIG_I2C_ALI15X3)	+= i2c-ali15x3.o
 obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
+obj-$(CONFIG_I2C_AMD756_S4882)	+= i2c-amd756-s4882.o
 obj-$(CONFIG_I2C_AMD8111)	+= i2c-amd8111.o
 obj-$(CONFIG_I2C_ELEKTOR)	+= i2c-elektor.o
 obj-$(CONFIG_I2C_HYDRA)		+= i2c-hydra.o
diff -ruN linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/i2c-amd756-s4882.c linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-amd756-s4882.c
--- linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/i2c-amd756-s4882.c	1970-01-01 01:00:00.000000000 +0100
+++ linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-amd756-s4882.c	2004-10-24 18:42:12.000000000 +0200
@@ -0,0 +1,266 @@
+/*
+ * i2c-amd756-s4882.c - i2c-amd756 extras for the Tyan S4882 motherboard
+ *
+ * Copyright (C) 2004 Jean Delvare <khali@linux-fr.org>
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2 of the License, or
+ * (at your option) any later version.
+ *
+ * This program is distributed in the hope that it will be useful,
+ * but WITHOUT ANY WARRANTY; without even the implied warranty of
+ * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ * GNU General Public License for more details.
+ *
+ * You should have received a copy of the GNU General Public License
+ * along with this program; if not, write to the Free Software
+ * Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+ 
+/*
+ * We select the channels by sending commands to the Philips
+ * PCA9556 chip at I2C address 0x18. The main adapter is used for
+ * the non-multiplexed part of the bus, and 4 virtual adapters
+ * are defined for the multiplexed addresses: 0x50-0x53 (memory
+ * module EEPROM) located on channels 1-4, and 0x4c (LM63)
+ * located on multiplexed channels 0 and 5-7. We define one
+ * virtual adapter per CPU, which corresponds to two multiplexed
+ * channels:
+ *   CPU0: virtual adapter 1, channels 1 and 0
+ *   CPU1: virtual adapter 2, channels 2 and 5
+ *   CPU2: virtual adapter 3, channels 3 and 6
+ *   CPU3: virtual adapter 4, channels 4 and 7
+ */
+
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/kernel.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+
+extern struct i2c_adapter amd756_smbus;
+
+static struct i2c_adapter *s4882_adapter;
+static struct i2c_algorithm *s4882_algo;
+
+/* Wrapper access functions for multiplexed SMBus */
+static struct semaphore amd756_lock;
+
+static s32 amd756_access_virt0(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	int error;
+
+	/* We exclude the multiplexed addresses */
+	if (addr == 0x4c || (addr & 0xfc) == 0x50 || (addr & 0xfc) == 0x30
+	 || addr == 0x18)
+		return -1;
+
+	down(&amd756_lock);
+
+	error = amd756_smbus.algo->smbus_xfer(adap, addr, flags, read_write,
+					      command, size, data);
+
+	up(&amd756_lock);
+
+	return error;
+}
+
+/* We remember the last used channels combination so as to only switch
+   channels when it is really needed. This greatly reduces the SMBus
+   overhead, but also assumes that nobody will be writing to the PCA9556
+   in our back. */
+static u8 last_channels;
+
+static inline s32 amd756_access_channel(struct i2c_adapter * adap, u16 addr,
+					unsigned short flags, char read_write,
+					u8 command, int size,
+					union i2c_smbus_data * data,
+					u8 channels)
+{
+	int error;
+
+	/* We exclude the non-multiplexed addresses */
+	if (addr != 0x4c && (addr & 0xfc) != 0x50 && (addr & 0xfc) != 0x30)
+		return -1;
+
+	down(&amd756_lock);
+
+	if (last_channels != channels) {
+		union i2c_smbus_data mplxdata;
+		mplxdata.byte = channels;
+
+		error = amd756_smbus.algo->smbus_xfer(adap, 0x18, 0,
+						      I2C_SMBUS_WRITE, 0x01,
+						      I2C_SMBUS_BYTE_DATA,
+						      &mplxdata);
+		if (error)
+			goto UNLOCK;
+		last_channels = channels;
+	}
+	error = amd756_smbus.algo->smbus_xfer(adap, addr, flags, read_write,
+					      command, size, data);
+
+UNLOCK:
+	up(&amd756_lock);
+	return error;
+}
+
+static s32 amd756_access_virt1(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	/* CPU0: channels 1 and 0 enabled */
+	return amd756_access_channel(adap, addr, flags, read_write, command,
+				     size, data, 0x03);
+}
+
+static s32 amd756_access_virt2(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	/* CPU1: channels 2 and 5 enabled */
+	return amd756_access_channel(adap, addr, flags, read_write, command,
+				     size, data, 0x24);
+}
+
+static s32 amd756_access_virt3(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	/* CPU2: channels 3 and 6 enabled */
+	return amd756_access_channel(adap, addr, flags, read_write, command,
+				     size, data, 0x48);
+}
+
+static s32 amd756_access_virt4(struct i2c_adapter * adap, u16 addr,
+			       unsigned short flags, char read_write,
+			       u8 command, int size,
+			       union i2c_smbus_data * data)
+{
+	/* CPU3: channels 4 and 7 enabled */
+	return amd756_access_channel(adap, addr, flags, read_write, command,
+				     size, data, 0x90);
+}
+
+static int __init amd756_s4882_init(void)
+{
+	int i, error;
+	union i2c_smbus_data ioconfig;
+
+	if (pci_find_subsys(PCI_VENDOR_ID_AMD, 0x746B, PCI_VENDOR_ID_AMD,
+			    0x36C0, NULL) == NULL)
+		return -ENODEV;
+
+	printk(KERN_INFO "Enabling SMBus multiplexing for Tyan S4882\n");
+
+	init_MUTEX(&amd756_lock);
+
+	/* Unregister physical bus */
+	error = i2c_del_adapter(&amd756_smbus);
+	if (error) {
+		dev_err(&amd756_smbus.dev, "Physical bus removal "
+			"failed\n");
+		goto ERROR0;
+	}
+
+	/* Define the 5 virtual adapters and algorithms structures */
+	if (!(s4882_adapter = kmalloc(5 * sizeof(struct i2c_adapter),
+				      GFP_KERNEL))) {
+		error = -ENOMEM;
+		goto ERROR1;
+	}
+	if (!(s4882_algo = kmalloc(5 * sizeof(struct i2c_algorithm),
+				   GFP_KERNEL))) {
+		error = -ENOMEM;
+		goto ERROR2;
+	}
+
+	/* Fill in the new structures */
+	s4882_algo[0] = *(amd756_smbus.algo);
+	s4882_algo[0].smbus_xfer = amd756_access_virt0;
+	s4882_adapter[0] = amd756_smbus;
+	s4882_adapter[0].algo = s4882_algo;
+	for (i = 1; i < 5; i++) {
+		s4882_algo[i] = *(amd756_smbus.algo);
+		s4882_adapter[i] = amd756_smbus;
+		sprintf(s4882_adapter[i].name,
+			"SMBus 8111 adapter (CPU%d)", i-1);
+		s4882_adapter[i].algo = s4882_algo+i;
+	}
+	s4882_algo[1].smbus_xfer = amd756_access_virt1;
+	s4882_algo[2].smbus_xfer = amd756_access_virt2;
+	s4882_algo[3].smbus_xfer = amd756_access_virt3;
+	s4882_algo[4].smbus_xfer = amd756_access_virt4;
+
+	/* Configure the PCA9556 multiplexer */
+	ioconfig.byte = 0x00; /* All I/O to output mode */
+	error = amd756_smbus.algo->smbus_xfer(&amd756_smbus, 0x18, 0,
+					      I2C_SMBUS_WRITE, 0x03,
+					      I2C_SMBUS_BYTE_DATA, &ioconfig);
+	if (error) {
+		dev_dbg(&amd756_smbus.dev, "PCA9556 configuration failed\n");
+		error = -EIO;
+		goto ERROR3;
+	}
+
+	/* Register virtual adapters */
+	for (i = 0; i < 5; i++) {
+		error = i2c_add_adapter(s4882_adapter+i);
+		if (error) {
+			dev_err(&amd756_smbus.dev,
+			       "Virtual adapter %d registration "
+			       "failed, module not inserted\n", i);
+			for (i--; i >= 0; i--)
+				i2c_del_adapter(s4882_adapter+i);
+			goto ERROR3;
+		}
+	}
+
+	return 0;
+
+ERROR3:
+	kfree(s4882_algo);
+	s4882_algo = NULL;
+ERROR2:
+	kfree(s4882_adapter);
+	s4882_adapter = NULL;
+ERROR1:
+	i2c_del_adapter(&amd756_smbus);
+ERROR0:
+	return error;
+}
+
+static void __exit amd756_s4882_exit(void)
+{
+	if (s4882_adapter) {
+		int i;
+
+		for (i = 0; i < 5; i++)
+			i2c_del_adapter(s4882_adapter+i);
+		kfree(s4882_adapter);
+		s4882_adapter = NULL;
+	}
+	if (s4882_algo) {
+		kfree(s4882_algo);
+		s4882_algo = NULL;
+	}
+
+	/* Restore physical bus */
+	if (i2c_add_adapter(&amd756_smbus))
+		dev_err(&amd756_smbus.dev, "Physical bus restoration "
+			"failed\n");
+}
+
+MODULE_AUTHOR("Jean Delvare <khali@linux-fr.org>");
+MODULE_DESCRIPTION("S4882 SMBus multiplexing");
+MODULE_LICENSE("GPL");
+
+module_init(amd756_s4882_init);
+module_exit(amd756_s4882_exit);
diff -ruN linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/i2c-amd756.c linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-amd756.c
--- linux-2.6.9-rc4-bk1/drivers/i2c/busses.orig/i2c-amd756.c	2004-10-16 21:13:45.000000000 +0200
+++ linux-2.6.9-rc4-bk1/drivers/i2c/busses/i2c-amd756.c	2004-10-24 18:51:52.000000000 +0200
@@ -47,6 +47,7 @@
 #include <linux/ioport.h>
 #include <linux/i2c.h>
 #include <linux/init.h>
+#include <linux/kmod.h>
 #include <asm/io.h>
 
 /* AMD756 SMBus address offsets */
@@ -302,23 +303,24 @@
 	.functionality	= amd756_func,
 };
 
-static struct i2c_adapter amd756_adapter = {
+struct i2c_adapter amd756_smbus = {
 	.owner		= THIS_MODULE,
 	.class          = I2C_CLASS_HWMON,
 	.algo		= &smbus_algorithm,
 	.name		= "unset",
 };
 
-enum chiptype { AMD756, AMD766, AMD768, NFORCE, AMD8111 };
+enum chiptype { AMD756, AMD766, AMD768, NFORCE, AMD8111, S4882 };
 static const char* chipname[] = {
 	"AMD756", "AMD766", "AMD768",
-	"nVidia nForce", "AMD8111",
+	"nVidia nForce", "AMD8111", "AMD8111",
 };
 
 static struct pci_device_id amd756_ids[] = {
 	{PCI_VENDOR_ID_AMD, 0x740B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD756 },
 	{PCI_VENDOR_ID_AMD, 0x7413, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD766 },
 	{PCI_VENDOR_ID_AMD, 0x7443, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD768 },
+	{PCI_VENDOR_ID_AMD, 0x746B, PCI_VENDOR_ID_AMD, 0x36C0, 0, 0, S4882 },
 	{PCI_VENDOR_ID_AMD, 0x746B, PCI_ANY_ID, PCI_ANY_ID, 0, 0, AMD8111 },
 	{PCI_VENDOR_ID_NVIDIA, 0x01B4, PCI_ANY_ID, PCI_ANY_ID, 0, 0, NFORCE },
 	{ 0, }
@@ -330,6 +332,7 @@
 				  const struct pci_device_id *id)
 {
 	int nforce = (id->driver_data == NFORCE);
+	int s4882 = (id->driver_data == S4882);
 	int error;
 	u8 temp;
 	
@@ -374,18 +377,21 @@
 	dev_dbg(&pdev->dev, "AMD756_smba = 0x%X\n", amd756_ioport);
 
 	/* set up the driverfs linkage to our parent device */
-	amd756_adapter.dev.parent = &pdev->dev;
+	amd756_smbus.dev.parent = &pdev->dev;
 
-	sprintf(amd756_adapter.name, "SMBus %s adapter at %04x",
+	sprintf(amd756_smbus.name, "SMBus %s adapter at %04x",
 		chipname[id->driver_data], amd756_ioport);
 
-	error = i2c_add_adapter(&amd756_adapter);
+	error = i2c_add_adapter(&amd756_smbus);
 	if (error) {
 		dev_err(&pdev->dev,
 			"Adapter registration failed, module not inserted\n");
 		goto out_err;
 	}
 
+	if (s4882)
+		request_module("i2c-amd756-s4882");
+
 	return 0;
 
  out_err:
@@ -395,7 +401,7 @@
 
 static void __devexit amd756_remove(struct pci_dev *dev)
 {
-	i2c_del_adapter(&amd756_adapter);
+	i2c_del_adapter(&amd756_smbus);
 	release_region(amd756_ioport, SMB_IOSIZE);
 }
 
@@ -420,5 +426,7 @@
 MODULE_DESCRIPTION("AMD756/766/768/8111 and nVidia nForce SMBus driver");
 MODULE_LICENSE("GPL");
 
+EXPORT_SYMBOL(amd756_smbus);
+
 module_init(amd756_init)
 module_exit(amd756_exit)


-- 
Jean Delvare
http://khali.linux-fr.org/
