Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262190AbSLARdJ>; Sun, 1 Dec 2002 12:33:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262296AbSLARdJ>; Sun, 1 Dec 2002 12:33:09 -0500
Received: from [195.39.17.254] ([195.39.17.254]:11524 "EHLO Elf.ucw.cz")
	by vger.kernel.org with ESMTP id <S262190AbSLARcc>;
	Sun, 1 Dec 2002 12:32:32 -0500
Date: Sun, 1 Dec 2002 18:36:45 +0100
From: Pavel Machek <pavel@ucw.cz>
To: torvalds@transmeta.com, kernel list <linux-kernel@vger.kernel.org>,
       frodol@dds.nl, phil@netroedge.com, sensors@stimpy.netroedge.com
Subject: i2c-amd766 driver for 2.5.50
Message-ID: <20021201173644.GA16744@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4i
X-Warning: Reading this can be dangerous to your mental health.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This brings amd766 driver along with adm1021 and lm75 to 2.5.50. Does
it look mergeable? If so, please apply,

								Pavel

--- clean.2.5/MAINTAINERS	2002-11-23 19:55:12.000000000 +0100
+++ linux-sensors/MAINTAINERS	2002-12-01 17:57:14.000000000 +0100
@@ -750,6 +750,15 @@
 W:	http://www.tk.uni-linz.ac.at/~simon/private/i2c
 S:	Maintained
 
+SENSORS DRIVERS
+P:      Frodo Looijaard
+M:      frodol@dds.nl
+P:      Philip Edelbrock
+M:      phil@netroedge.com
+L:      sensors@stimpy.netroedge.com
+W:      http://www.lm-sensors.nu/
+S:      Maintained
+
 i386 BOOT CODE
 P:	Riley H. Williams
 M:	Riley@Williams.Name
--- clean.2.5/drivers/Makefile	2002-11-29 21:16:33.000000000 +0100
+++ linux-sensors/drivers/Makefile	2002-12-01 17:57:14.000000000 +0100
@@ -39,6 +39,8 @@
 obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_I2O)		+= message/
 obj-$(CONFIG_I2C)		+= i2c/
+obj-$(CONFIG_I2C_MAINBOARD)	+= i2c/busses/
+obj-$(CONFIG_SENSORS)		+= i2c/chips/
 obj-$(CONFIG_PHONE)		+= telephony/
 obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
--- clean.2.5/drivers/char/mem.c	2002-11-29 21:16:36.000000000 +0100
+++ linux-sensors/drivers/char/mem.c	2002-12-01 17:57:14.000000000 +0100
@@ -27,6 +27,12 @@
 #include <asm/io.h>
 #include <asm/pgalloc.h>
 
+#ifdef CONFIG_I2C_MAINBOARD
+extern void i2c_mainboard_init_all(void);
+#endif
+#ifdef CONFIG_SENSORS
+extern void sensors_init_all(void);
+#endif
 #ifdef CONFIG_I2C
 extern int i2c_init_all(void);
 #endif
@@ -683,6 +689,9 @@
 #ifdef CONFIG_I2C
 	i2c_init_all();
 #endif
+#ifdef CONFIG_I2C_MAINBOARD
+	i2c_mainboard_init_all();
+#endif
 #if defined (CONFIG_FB)
 	fbmem_init();
 #endif
@@ -703,6 +712,10 @@
 #if defined(CONFIG_S390_TAPE) && defined(CONFIG_S390_TAPE_CHAR)
 	tapechar_init();
 #endif
+#ifdef CONFIG_SENSORS
+	sensors_init_all();
+#endif
+
 	return 0;
 }
 
--- clean.2.5/drivers/i2c/Kconfig	2002-11-01 00:37:13.000000000 +0100
+++ linux-sensors/drivers/i2c/Kconfig	2002-12-01 17:57:14.000000000 +0100
@@ -193,5 +193,8 @@
 	  it as a module, say M here and read <file:Documentation/modules.txt>.
 	  The module will be called i2c-proc.o.
 
+	source drivers/i2c/busses/Kconfig
+	source drivers/i2c/chips/Kconfig
+
 endmenu
 
--- clean.2.5/drivers/i2c/busses/Kconfig	2002-12-01 16:59:48.000000000 +0100
+++ linux-sensors/drivers/i2c/busses/Kconfig	2002-12-01 17:57:14.000000000 +0100
@@ -0,0 +1,39 @@
+#
+# Sensor device configuration
+# All depend on EXPERIMENTAL, I2C and I2C_PROC.
+#
+
+menu "I2C Hardware Sensors Mainboard support"
+
+config I2C_MAINBOARD
+	bool "Hardware sensors mainboard support"
+	depends on EXPERIMENTAL && I2C && I2C_PROC
+	help
+	  Many modern mainboards have some kind of I2C interface integrated. This
+	  is often in the form of a SMBus, or System Management Bus, which is
+	  basically the same as I2C but which uses only a subset of the I2C
+	  protocol.
+
+	  You will also want the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at 
+	  http://www.lm-sensors.nu
+
+config I2C_AMD756
+	tristate "  AMD 756/766"
+	depends on I2C_MAINBOARD
+	help
+	  If you say yes to this option, support will be included for the AMD
+	  756/766/768 mainboard I2C interfaces.
+
+	  This can also be built as a module which can be inserted and removed 
+	  while the kernel is running.  If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  The module will be called i2c-amd756.o.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at 
+	  http://www.lm-sensors.nu
+
+endmenu
+
--- clean.2.5/drivers/i2c/busses/Makefile	2002-12-01 16:56:56.000000000 +0100
+++ linux-sensors/drivers/i2c/busses/Makefile	2002-12-01 17:57:14.000000000 +0100
@@ -0,0 +1,10 @@
+#
+# Makefile for the kernel hardware sensors bus drivers.
+#
+
+MOD_LIST_NAME := SENSORS_BUS_MODULES
+
+obj-$(CONFIG_I2C_MAINBOARD)	+= i2c-mainboard.o
+obj-$(CONFIG_I2C_AMD756)	+= i2c-amd756.o
+
+include $(TOPDIR)/Rules.make
--- clean.2.5/drivers/i2c/busses/i2c-amd756.c	2002-12-01 17:33:13.000000000 +0100
+++ linux-sensors/drivers/i2c/busses/i2c-amd756.c	2002-12-01 18:11:05.000000000 +0100
@@ -0,0 +1,536 @@
+/*
+    amd756.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+
+    Copyright (c) 1999-2002 Merlin Hughes <merlin@merlin.org>
+
+    Shamelessly ripped from i2c-piix4.c:
+
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
+    Philip Edelbrock <phil@netroedge.com>
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
+    2002-04-08: Added nForce support. (Csaba Halasz)
+    2002-10-03: Fixed nForce PnP I/O port. (Michael Steil)
+*/
+
+/*
+   Supports AMD756, AMD766, AMD768 and nVidia nForce
+   Note: we assume there can only be one device, with one SMBus interface.
+*/
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/sched.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+
+#ifndef PCI_DEVICE_ID_AMD_756
+#define PCI_DEVICE_ID_AMD_756 0x740B
+#endif
+#ifndef PCI_DEVICE_ID_AMD_766
+#define PCI_DEVICE_ID_AMD_766 0x7413
+#endif
+#ifndef PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS
+#define PCI_DEVICE_ID_NVIDIA_NFORCE_SMBUS 0x01B4
+#endif
+
+struct sd {
+    const unsigned short vendor;
+    const unsigned short device;
+    const unsigned short function;
+    const char* name;
+    int amdsetup:1;
+};
+
+static struct sd supported[] = {
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_756, 3, "AMD756", 1},
+    {PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_766, 3, "AMD766", 1},
+    {PCI_VENDOR_ID_AMD, 0x7443, 3, "AMD768", 1},
+    {PCI_VENDOR_ID_NVIDIA, 0x01B4, 1, "nVidia nForce", 0},
+    {0, 0, 0}
+};
+
+/* AMD756 SMBus address offsets */
+#define SMB_ADDR_OFFSET        0xE0
+#define SMB_IOSIZE             16
+#define SMB_GLOBAL_STATUS      (0x0 + amd756_smba)
+#define SMB_GLOBAL_ENABLE      (0x2 + amd756_smba)
+#define SMB_HOST_ADDRESS       (0x4 + amd756_smba)
+#define SMB_HOST_DATA          (0x6 + amd756_smba)
+#define SMB_HOST_COMMAND       (0x8 + amd756_smba)
+#define SMB_HOST_BLOCK_DATA    (0x9 + amd756_smba)
+#define SMB_HAS_DATA           (0xA + amd756_smba)
+#define SMB_HAS_DEVICE_ADDRESS (0xC + amd756_smba)
+#define SMB_HAS_HOST_ADDRESS   (0xE + amd756_smba)
+#define SMB_SNOOP_ADDRESS      (0xF + amd756_smba)
+
+/* PCI Address Constants */
+
+/* address of I/O space */
+#define SMBBA     0x058		/* mh */
+#define SMBBANFORCE     0x014
+
+/* general configuration */
+#define SMBGCFG   0x041		/* mh */
+
+/* silicon revision code */
+#define SMBREV    0x008
+
+/* Other settings */
+#define MAX_TIMEOUT 500
+
+/* AMD756 constants */
+#define AMD756_QUICK        0x00
+#define AMD756_BYTE         0x01
+#define AMD756_BYTE_DATA    0x02
+#define AMD756_WORD_DATA    0x03
+#define AMD756_PROCESS_CALL 0x04
+#define AMD756_BLOCK_DATA   0x05
+
+/* insmod parameters */
+
+int __init i2c_amd756_init(void);
+void __exit i2c_amd756_exit(void);
+static int amd756_cleanup(void);
+
+static int amd756_setup(void);
+static s32 amd756_access(struct i2c_adapter *adap, u16 addr,
+			 unsigned short flags, char read_write,
+			 u8 command, int size, union i2c_smbus_data *data);
+static void amd756_do_pause(unsigned int amount);
+static void amd756_abort(void);
+static int amd756_transaction(void);
+static void amd756_inc(struct i2c_adapter *adapter);
+static void amd756_dec(struct i2c_adapter *adapter);
+static u32 amd756_func(struct i2c_adapter *adapter);
+
+static struct i2c_algorithm smbus_algorithm = {
+	/* name */ "Non-I2C SMBus adapter",
+	/* id */ I2C_ALGO_SMBUS,
+	/* master_xfer */ NULL,
+	/* smbus_access */ amd756_access,
+	/* slave;_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ amd756_func,
+};
+
+static struct i2c_adapter amd756_adapter = {
+	"unset",
+	I2C_ALGO_SMBUS | I2C_HW_SMBUS_AMD756,
+	&smbus_algorithm,
+	NULL,
+	amd756_inc,
+	amd756_dec,
+	NULL,
+	NULL,
+};
+
+static int __initdata amd756_initialized;
+static struct sd *amd756_sd = NULL;
+static unsigned short amd756_smba = 0;
+
+int amd756_setup(void)
+{
+	unsigned char temp;
+	struct sd *currdev;
+	struct pci_dev *AMD756_dev = NULL;
+
+	if (pci_present() == 0) {
+		return -ENODEV;
+	}
+
+	/* Look for a supported chip */
+	for(currdev = supported; currdev->vendor; ) {
+		AMD756_dev = pci_find_device(currdev->vendor,
+						currdev->device, AMD756_dev);
+		if (AMD756_dev != NULL)	{
+			if (PCI_FUNC(AMD756_dev->devfn) == currdev->function)
+				break;
+		} else {
+		    currdev++;
+		}
+	}
+
+	if (AMD756_dev == NULL) {
+		printk
+		    ("i2c-amd756.o: Error: No AMD756 or compatible device detected!\n");
+		return -ENODEV;
+	}
+	printk(KERN_INFO "i2c-amd756.o: Found %s SMBus controller.\n", currdev->name);
+
+	if (currdev->amdsetup)
+	{
+		pci_read_config_byte(AMD756_dev, SMBGCFG, &temp);
+		if ((temp & 128) == 0) {
+			printk("i2c-amd756.o: Error: SMBus controller I/O not enabled!\n");
+			return -ENODEV;
+		}
+
+		/* Determine the address of the SMBus areas */
+		/* Technically it is a dword but... */
+		pci_read_config_word(AMD756_dev, SMBBA, &amd756_smba);
+		amd756_smba &= 0xff00;
+		amd756_smba += SMB_ADDR_OFFSET;
+	} else {
+		pci_read_config_word(AMD756_dev, SMBBANFORCE, &amd756_smba);
+		amd756_smba &= 0xfffc;
+	}
+	if(amd756_smba == 0) {
+		printk(KERN_ERR "i2c-amd756.o: Error: SMB base address uninitialized\n");
+		return -ENODEV;
+	}
+	if (check_region(amd756_smba, SMB_IOSIZE)) {
+		printk
+		    ("i2c-amd756.o: SMB region 0x%x already in use!\n",
+		     amd756_smba);
+		return -ENODEV;
+	}
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(amd756_smba, SMB_IOSIZE, "amd756-smbus");
+
+#ifdef DEBUG
+	pci_read_config_byte(AMD756_dev, SMBREV, &temp);
+	printk("i2c-amd756.o: SMBREV = 0x%X\n", temp);
+	printk("i2c-amd756.o: AMD756_smba = 0x%X\n", amd756_smba);
+#endif				/* DEBUG */
+
+	/* store struct sd * for future reference */
+        amd756_sd = currdev;
+
+	return 0;
+}
+
+/* 
+  SMBUS event = I/O 28-29 bit 11
+     see E0 for the status bits and enabled in E2
+     
+*/
+
+/* Internally used pause function */
+void amd756_do_pause(unsigned int amount)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+#define GS_ABRT_STS (1 << 0)
+#define GS_COL_STS (1 << 1)
+#define GS_PRERR_STS (1 << 2)
+#define GS_HST_STS (1 << 3)
+#define GS_HCYC_STS (1 << 4)
+#define GS_TO_STS (1 << 5)
+#define GS_SMB_STS (1 << 11)
+
+#define GS_CLEAR_STS (GS_ABRT_STS | GS_COL_STS | GS_PRERR_STS | \
+  GS_HCYC_STS | GS_TO_STS )
+
+#define GE_CYC_TYPE_MASK (7)
+#define GE_HOST_STC (1 << 3)
+#define GE_ABORT (1 << 5)
+
+void amd756_abort(void)
+{
+	printk("i2c-amd756.o: Sending abort.\n");
+	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
+	amd756_do_pause(100);
+	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
+}
+
+int amd756_transaction(void)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+#ifdef DEBUG
+	printk
+	    ("i2c-amd756.o: Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
+	     inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
+	     inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
+#endif
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
+#ifdef DEBUG
+		printk
+		    ("i2c-amd756.o: SMBus busy (%04x). Waiting... \n", temp);
+#endif
+		do {
+			amd756_do_pause(1);
+			temp = inw_p(SMB_GLOBAL_STATUS);
+		} while ((temp & (GS_HST_STS | GS_SMB_STS)) &&
+		         (timeout++ < MAX_TIMEOUT));
+		/* If the SMBus is still busy, we give up */
+		if (timeout >= MAX_TIMEOUT) {
+			printk("i2c-amd756.o: Busy wait timeout! (%04x)\n", temp);
+			amd756_abort();
+			return -1;
+		}
+		timeout = 0;
+	}
+
+	/* start the transaction by setting the start bit */
+	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_HOST_STC, SMB_GLOBAL_ENABLE);
+
+	/* We will always wait for a fraction of a second! */
+	do {
+		amd756_do_pause(1);
+		temp = inw_p(SMB_GLOBAL_STATUS);
+	} while ((temp & GS_HST_STS) && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+		printk("i2c-amd756.o: Completion timeout!\n");
+		amd756_abort ();
+		return -1;
+	}
+
+	if (temp & GS_PRERR_STS) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-amd756.o: SMBus Protocol error (no response)!\n");
+#endif
+	}
+
+	if (temp & GS_COL_STS) {
+		result = -1;
+		printk("i2c-amd756.o: SMBus collision!\n");
+	}
+
+	if (temp & GS_TO_STS) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-amd756.o: SMBus protocol timeout!\n");
+#endif
+	}
+#ifdef DEBUG
+	if (temp & GS_HCYC_STS) {
+		printk("i2c-amd756.o: SMBus protocol success!\n");
+	}
+#endif
+
+	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
+
+#ifdef DEBUG
+	if (((temp = inw_p(SMB_GLOBAL_STATUS)) & GS_CLEAR_STS) != 0x00) {
+		printk
+		    ("i2c-amd756.o: Failed reset at end of transaction (%04x)\n",
+		     temp);
+	}
+	printk
+	    ("i2c-amd756.o: Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
+	     inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
+	     inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
+#endif
+
+	return result;
+}
+
+/* Return -1 on error. */
+s32 amd756_access(struct i2c_adapter * adap, u16 addr,
+		  unsigned short flags, char read_write,
+		  u8 command, int size, union i2c_smbus_data * data)
+{
+	int i, len;
+
+  /** TODO: Should I supporte the 10-bit transfers? */
+	switch (size) {
+	case I2C_SMBUS_PROC_CALL:
+		printk
+		    ("i2c-amd756.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		/* TODO: Well... It is supported, I'm just not sure what to do here... */
+		return -1;
+	case I2C_SMBUS_QUICK:
+		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMB_HOST_ADDRESS);
+		size = AMD756_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMB_HOST_ADDRESS);
+		/* TODO: Why only during write? */
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(command, SMB_HOST_COMMAND);
+		size = AMD756_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMB_HOST_ADDRESS);
+		outb_p(command, SMB_HOST_COMMAND);
+		if (read_write == I2C_SMBUS_WRITE)
+			outw_p(data->byte, SMB_HOST_DATA);
+		size = AMD756_BYTE_DATA;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMB_HOST_ADDRESS);
+		outb_p(command, SMB_HOST_COMMAND);
+		if (read_write == I2C_SMBUS_WRITE)
+			outw_p(data->word, SMB_HOST_DATA);	/* TODO: endian???? */
+		size = AMD756_WORD_DATA;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		outw_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMB_HOST_ADDRESS);
+		outb_p(command, SMB_HOST_COMMAND);
+		if (read_write == I2C_SMBUS_WRITE) {
+			len = data->block[0];
+			if (len < 0)
+				len = 0;
+			if (len > 32)
+				len = 32;
+			outw_p(len, SMB_HOST_DATA);
+			/* i = inw_p(SMBHSTCNT); Reset SMBBLKDAT */
+			for (i = 1; i <= len; i++)
+				outb_p(data->block[i],
+				       SMB_HOST_BLOCK_DATA);
+		}
+		size = AMD756_BLOCK_DATA;
+		break;
+	}
+
+	/* How about enabling interrupts... */
+	outw_p(size & GE_CYC_TYPE_MASK, SMB_GLOBAL_ENABLE);
+
+	if (amd756_transaction())	/* Error in transaction */
+		return -1;
+
+	if ((read_write == I2C_SMBUS_WRITE) || (size == AMD756_QUICK))
+		return 0;
+
+
+	switch (size) {
+	case AMD756_BYTE:
+		data->byte = inw_p(SMB_HOST_DATA);
+		break;
+	case AMD756_BYTE_DATA:
+		data->byte = inw_p(SMB_HOST_DATA);
+		break;
+	case AMD756_WORD_DATA:
+		data->word = inw_p(SMB_HOST_DATA);	/* TODO: endian???? */
+		break;
+	case AMD756_BLOCK_DATA:
+		data->block[0] = inw_p(SMB_HOST_DATA) & 0x3f;
+		if(data->block[0] > 32)
+			data->block[0] = 32;
+		/* i = inw_p(SMBHSTCNT); Reset SMBBLKDAT */
+		for (i = 1; i <= data->block[0]; i++)
+			data->block[i] = inb_p(SMB_HOST_BLOCK_DATA);
+		break;
+	}
+
+	return 0;
+}
+
+void amd756_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void amd756_dec(struct i2c_adapter *adapter)
+{
+
+	MOD_DEC_USE_COUNT;
+}
+
+u32 amd756_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_PROC_CALL;
+}
+
+int __init i2c_amd756_init(void)
+{
+	int res;
+#ifdef DEBUG
+/* PE- It might be good to make this a permanent part of the code! */
+	if (amd756_initialized) {
+		printk
+		    ("i2c-amd756.o: Oops, amd756_init called a second time!\n");
+		return -EBUSY;
+	}
+#endif
+	amd756_initialized = 0;
+	if ((res = amd756_setup())) {
+		printk
+		    ("i2c-amd756.o: AMD756 or compatible device not detected, module not inserted.\n");
+		amd756_cleanup();
+		return res;
+	}
+	amd756_initialized++;
+	sprintf(amd756_adapter.name, "SMBus %s adapter at %04x",
+		amd756_sd->name, amd756_smba);
+	if ((res = i2c_add_adapter(&amd756_adapter))) {
+		printk
+		    ("i2c-amd756.o: Adapter registration failed, module not inserted.\n");
+		amd756_cleanup();
+		return res;
+	}
+	amd756_initialized++;
+	printk("i2c-amd756.o: %s bus detected and initialized\n",
+               amd756_sd->name);
+	return 0;
+}
+
+void __exit i2c_amd756_exit(void)
+{
+	amd756_cleanup();
+}
+
+static int amd756_cleanup(void)
+{
+	int res;
+	if (amd756_initialized >= 2) {
+		if ((res = i2c_del_adapter(&amd756_adapter))) {
+			printk
+			    ("i2c-amd756.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		} else
+			amd756_initialized--;
+	}
+	if (amd756_initialized >= 1) {
+		release_region(amd756_smba, SMB_IOSIZE);
+		amd756_initialized--;
+	}
+			return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
+MODULE_DESCRIPTION("AMD756/766/768/nVidia nForce SMBus driver");
+
+#ifdef MODULE_LICENSE
+MODULE_LICENSE("GPL");
+#endif
+
+#endif				/* MODULE */
+
+module_init(i2c_amd756_init)
+module_exit(i2c_amd756_exit)
--- clean.2.5/drivers/i2c/busses/i2c-mainboard.c	2002-12-01 18:07:27.000000000 +0100
+++ linux-sensors/drivers/i2c/busses/i2c-mainboard.c	2002-12-01 18:08:51.000000000 +0100
@@ -0,0 +1,34 @@
+/*
+    i2c-mainboard.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
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
+/* Not configurable as a module */
+
+#include <linux/init.h>
+
+extern int i2c_amd756_init(void);
+
+int __init i2c_mainboard_init_all(void)
+{
+#ifdef CONFIG_I2C_AMD756
+	i2c_amd756_init();
+#endif
+
+	return 0;
+}
--- clean.2.5/drivers/i2c/chips/Kconfig	2002-12-01 16:59:44.000000000 +0100
+++ linux-sensors/drivers/i2c/chips/Kconfig	2002-12-01 17:57:14.000000000 +0100
@@ -0,0 +1,54 @@
+#
+# Sensor device configuration
+# All depend on EXPERIMENTAL, I2C and I2C_PROC.
+#
+
+menu "I2C Hardware Sensors Chip support"
+
+config SENSORS
+	bool "Hardware sensors chip support"
+	depends on EXPERIMENTAL && I2C && I2C_PROC
+	help
+	  Many modern mainboards have some kind of I2C interface integrated.
+	  This is often in the form of a SMBus, or System Management Bus, which
+	  is basically the same as I2C but which uses only a subset of the I2C
+	  protocol.
+
+	  You will also want the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at 
+	  http://www.lm-sensors.nu
+
+config SENSORS_ADM1021
+	tristate "  Analog Devices ADM1021 and compatibles"
+	depends on SENSORS
+	help
+	  If you say yes here you get support for Analog Devices ADM1021 
+	  and ADM1023 sensor chips and clones: Maxim MAX1617 and MAX1617A,
+	  Genesys Logic GL523SM, National Semi LM84, TI THMC10,
+	  and the XEON processor built-in sensor. This can also 
+	  be built as a module which can be inserted and removed while the 
+	  kernel is running.
+
+	  The module will be called adm1021.o.
+	  
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at 
+	  http://www.lm-sensors.nu
+
+config SENSORS_LM75
+	tristate "  National Semiconductors LM75 and compatibles"
+	depends on SENSORS
+	help
+	  If you say yes here you get support for National Semiconductor LM75
+	  sensor chips and clones: Dallas Semi DS75 and DS1775, TelCon
+	  TCN75, and National Semi LM77. This can also be built as a module
+	  which can be inserted and removed while the kernel is running.
+
+	  The module will be called lm75.o.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at 
+	  http://www.lm-sensors.nu
+
+endmenu
+
--- clean.2.5/drivers/i2c/chips/Makefile	2002-12-01 16:57:14.000000000 +0100
+++ linux-sensors/drivers/i2c/chips/Makefile	2002-12-01 17:57:14.000000000 +0100
@@ -0,0 +1,11 @@
+#
+# Makefile for the kernel hardware sensors chip drivers.
+#
+
+MOD_LIST_NAME := SENSORS_CHIPS_MODULES
+
+obj-$(CONFIG_SENSORS)		+= sensors.o
+obj-$(CONFIG_SENSORS_ADM1021)	+= adm1021.o
+obj-$(CONFIG_SENSORS_LM75)	+= lm75.o
+
+include $(TOPDIR)/Rules.make
--- clean.2.5/drivers/i2c/chips/adm1021.c	2002-12-01 17:33:33.000000000 +0100
+++ linux-sensors/drivers/i2c/chips/adm1021.c	2002-12-01 17:57:14.000000000 +0100
@@ -0,0 +1,646 @@
+/*
+    adm1021.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> and
+    Philip Edelbrock <phil@netroedge.com>
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
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/sensors.h>
+#include <linux/init.h>
+
+MODULE_LICENSE("GPL");
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { 0x18, 0x1a, 0x29, 0x2b,
+	0x4c, 0x4e, SENSORS_I2C_END
+};
+static unsigned int normal_isa[] = { SENSORS_ISA_END };
+static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_8(adm1021, adm1023, max1617, max1617a, thmc10, lm84, gl523sm, mc1066);
+
+/* adm1021 constants specified below */
+
+/* The adm1021 registers */
+/* Read-only */
+#define ADM1021_REG_TEMP 0x00
+#define ADM1021_REG_REMOTE_TEMP 0x01
+#define ADM1021_REG_STATUS 0x02
+#define ADM1021_REG_MAN_ID 0x0FE	/* 0x41 = AMD, 0x49 = TI, 0x4D = Maxim, 0x23 = Genesys , 0x54 = Onsemi*/
+#define ADM1021_REG_DEV_ID 0x0FF	/* ADM1021 = 0x0X, ADM1023 = 0x3X */
+#define ADM1021_REG_DIE_CODE 0x0FF	/* MAX1617A */
+/* These use different addresses for reading/writing */
+#define ADM1021_REG_CONFIG_R 0x03
+#define ADM1021_REG_CONFIG_W 0x09
+#define ADM1021_REG_CONV_RATE_R 0x04
+#define ADM1021_REG_CONV_RATE_W 0x0A
+/* These are for the ADM1023's additional precision on the remote temp sensor */
+#define ADM1021_REG_REM_TEMP_PREC 0x010
+#define ADM1021_REG_REM_OFFSET 0x011
+#define ADM1021_REG_REM_OFFSET_PREC 0x012
+#define ADM1021_REG_REM_TOS_PREC 0x013
+#define ADM1021_REG_REM_THYST_PREC 0x014
+/* limits */
+#define ADM1021_REG_TOS_R 0x05
+#define ADM1021_REG_TOS_W 0x0B
+#define ADM1021_REG_REMOTE_TOS_R 0x07
+#define ADM1021_REG_REMOTE_TOS_W 0x0D
+#define ADM1021_REG_THYST_R 0x06
+#define ADM1021_REG_THYST_W 0x0C
+#define ADM1021_REG_REMOTE_THYST_R 0x08
+#define ADM1021_REG_REMOTE_THYST_W 0x0E
+/* write-only */
+#define ADM1021_REG_ONESHOT 0x0F
+
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+/* Conversions  note: 1021 uses normal integer signed-byte format*/
+#define TEMP_FROM_REG(val) (val > 127 ? val-256 : val)
+#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val < 0 ? val+256 : val),0,255))
+
+/* Initial values */
+
+/* Note: Eventhough I left the low and high limits named os and hyst, 
+they don't quite work like a thermostat the way the LM75 does.  I.e., 
+a lower temp than THYST actuall triggers an alarm instead of 
+clearing it.  Weird, ey?   --Phil  */
+#define adm1021_INIT_TOS 60
+#define adm1021_INIT_THYST 20
+#define adm1021_INIT_REMOTE_TOS 60
+#define adm1021_INIT_REMOTE_THYST 20
+
+/* Each client has this additional data */
+struct adm1021_data {
+	int sysctl_id;
+	enum chips type;
+
+	struct semaphore update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u8 temp, temp_os, temp_hyst;	/* Register values */
+	u8 remote_temp, remote_temp_os, remote_temp_hyst, alarms, die_code;
+        /* Special values for ADM1023 only */
+	u8 remote_temp_prec, remote_temp_os_prec, remote_temp_hyst_prec, 
+	   remote_temp_offset, remote_temp_offset_prec;
+};
+
+int __init sensors_adm1021_init(void);
+void __exit sensors_adm1021_exit(void);
+static int adm1021_cleanup(void);
+
+static int adm1021_attach_adapter(struct i2c_adapter *adapter);
+static int adm1021_detect(struct i2c_adapter *adapter, int address,
+			  unsigned short flags, int kind);
+static void adm1021_init_client(struct i2c_client *client);
+static int adm1021_detach_client(struct i2c_client *client);
+static int adm1021_command(struct i2c_client *client, unsigned int cmd,
+			   void *arg);
+static void adm1021_inc_use(struct i2c_client *client);
+static void adm1021_dec_use(struct i2c_client *client);
+static int adm1021_read_value(struct i2c_client *client, u8 reg);
+static int adm1021_write_value(struct i2c_client *client, u8 reg,
+			       u16 value);
+static void adm1021_temp(struct i2c_client *client, int operation,
+			 int ctl_name, int *nrels_mag, long *results);
+static void adm1021_remote_temp(struct i2c_client *client, int operation,
+				int ctl_name, int *nrels_mag,
+				long *results);
+static void adm1021_alarms(struct i2c_client *client, int operation,
+			   int ctl_name, int *nrels_mag, long *results);
+static void adm1021_die_code(struct i2c_client *client, int operation,
+			     int ctl_name, int *nrels_mag, long *results);
+static void adm1021_update_client(struct i2c_client *client);
+
+/* (amalysh) read only mode, otherwise any limit's writing confuse BIOS */
+static int read_only = 0;
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver adm1021_driver = {
+	/* name */ "ADM1021, MAX1617 sensor driver",
+	/* id */ I2C_DRIVERID_ADM1021,
+	/* flags */ I2C_DF_NOTIFY,
+	/* attach_adapter */ &adm1021_attach_adapter,
+	/* detach_client */ &adm1021_detach_client,
+	/* command */ &adm1021_command,
+	/* inc_use */ &adm1021_inc_use,
+	/* dec_use */ &adm1021_dec_use
+};
+
+/* These files are created for each detected adm1021. This is just a template;
+   though at first sight, you might think we could use a statically
+   allocated list, we need some way to get back to the parent - which
+   is done through one of the 'extra' fields which are initialized
+   when a new copy is allocated. */
+static ctl_table adm1021_dir_table_template[] = {
+	{ADM1021_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1021_temp},
+	{ADM1021_SYSCTL_REMOTE_TEMP, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1021_remote_temp},
+	{ADM1021_SYSCTL_DIE_CODE, "die_code", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1021_die_code},
+	{ADM1021_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1021_alarms},
+	{0}
+};
+
+static ctl_table adm1021_max_dir_table_template[] = {
+	{ADM1021_SYSCTL_TEMP, "temp1", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1021_temp},
+	{ADM1021_SYSCTL_REMOTE_TEMP, "temp2", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1021_remote_temp},
+	{ADM1021_SYSCTL_ALARMS, "alarms", NULL, 0, 0444, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &adm1021_alarms},
+	{0}
+};
+
+/* Used by init/cleanup */
+static int __initdata adm1021_initialized = 0;
+
+/* I choose here for semi-static allocation. Complete dynamic
+   allocation could also be used; the code needed for this would probably
+   take more memory than the datastructure takes now. */
+static int adm1021_id = 0;
+
+int adm1021_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, adm1021_detect);
+}
+
+static int adm1021_detect(struct i2c_adapter *adapter, int address,
+			  unsigned short flags, int kind)
+{
+	int i;
+	struct i2c_client *new_client;
+	struct adm1021_data *data;
+	int err = 0;
+	const char *type_name = "";
+	const char *client_name = "";
+
+	/* Make sure we aren't probing the ISA bus!! This is just a safety check
+	   at this moment; i2c_detect really won't call us. */
+#ifdef DEBUG
+	if (i2c_is_isa_adapter(adapter)) {
+		printk
+		    ("adm1021.o: adm1021_detect called for an ISA bus adapter?!?\n");
+		return 0;
+	}
+#endif
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA))
+		goto ERROR0;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access adm1021_{read,write}_value. */
+
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct adm1021_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR0;
+	}
+
+	data = (struct adm1021_data *) (new_client + 1);
+	new_client->addr = address;
+	new_client->data = data;
+	new_client->adapter = adapter;
+	new_client->driver = &adm1021_driver;
+	new_client->flags = 0;
+
+	/* Now, we do the remaining detection. */
+
+	if (kind < 0) {
+		if (
+		    (adm1021_read_value(new_client, ADM1021_REG_STATUS) &
+		     0x03) != 0x00)
+			goto ERROR1;
+	}
+
+	/* Determine the chip type. */
+
+	if (kind <= 0) {
+		i = adm1021_read_value(new_client, ADM1021_REG_MAN_ID);
+		if (i == 0x41)
+		  if ((adm1021_read_value (new_client, ADM1021_REG_DEV_ID) & 0x0F0) == 0x030)
+			kind = adm1023;
+		  else
+			kind = adm1021;
+		else if (i == 0x49)
+			kind = thmc10;
+		else if (i == 0x23)
+			kind = gl523sm;
+		else if ((i == 0x4d) &&
+			 (adm1021_read_value
+			  (new_client, ADM1021_REG_DEV_ID) == 0x01))
+			kind = max1617a;
+		/* LM84 Mfr ID in a different place */
+		else
+		    if (adm1021_read_value
+			(new_client, ADM1021_REG_CONV_RATE_R) == 0x00)
+			kind = lm84;
+		else if (i == 0x54)
+			kind = mc1066;
+		else
+			kind = max1617;
+	}
+
+	if (kind == max1617) {
+		type_name = "max1617";
+		client_name = "MAX1617 chip";
+	} else if (kind == max1617a) {
+		type_name = "max1617a";
+		client_name = "MAX1617A chip";
+	} else if (kind == adm1021) {
+		type_name = "adm1021";
+		client_name = "ADM1021 chip";
+	} else if (kind == adm1023) {
+		type_name = "adm1023";
+		client_name = "ADM1023 chip";
+	} else if (kind == thmc10) {
+		type_name = "thmc10";
+		client_name = "THMC10 chip";
+	} else if (kind == lm84) {
+		type_name = "lm84";
+		client_name = "LM84 chip";
+	} else if (kind == gl523sm) {
+		type_name = "gl523sm";
+		client_name = "GL523SM chip";
+	} else if (kind == mc1066) {
+		type_name = "mc1066";
+		client_name = "MC1066 chip";
+	} else {
+#ifdef DEBUG
+		printk("adm1021.o: Internal error: unknown kind (%d)?!?",
+		       kind);
+#endif
+		goto ERROR1;
+	}
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strcpy(new_client->name, client_name);
+	data->type = kind;
+
+	new_client->id = adm1021_id++;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto ERROR3;
+
+	/* Register a new directory entry with module sensors */
+	if ((i = i2c_register_entry(new_client,
+					type_name,
+					data->type ==
+					adm1021 ?
+					adm1021_dir_table_template :
+					adm1021_max_dir_table_template,
+					THIS_MODULE)) < 0) {
+		err = i;
+		goto ERROR4;
+	}
+	data->sysctl_id = i;
+
+	/* Initialize the ADM1021 chip */
+	adm1021_init_client(new_client);
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      ERROR4:
+	i2c_detach_client(new_client);
+      ERROR3:
+      ERROR1:
+	kfree(new_client);
+      ERROR0:
+	return err;
+}
+
+void adm1021_init_client(struct i2c_client *client)
+{
+	/* Initialize the adm1021 chip */
+	adm1021_write_value(client, ADM1021_REG_TOS_W,
+			    TEMP_TO_REG(adm1021_INIT_TOS));
+	adm1021_write_value(client, ADM1021_REG_THYST_W,
+			    TEMP_TO_REG(adm1021_INIT_THYST));
+	adm1021_write_value(client, ADM1021_REG_REMOTE_TOS_W,
+			    TEMP_TO_REG(adm1021_INIT_REMOTE_TOS));
+	adm1021_write_value(client, ADM1021_REG_REMOTE_THYST_W,
+			    TEMP_TO_REG(adm1021_INIT_REMOTE_THYST));
+	/* Enable ADC and disable suspend mode */
+	adm1021_write_value(client, ADM1021_REG_CONFIG_W, 0);
+	/* Set Conversion rate to 1/sec (this can be tinkered with) */
+	adm1021_write_value(client, ADM1021_REG_CONV_RATE_W, 0x04);
+}
+
+int adm1021_detach_client(struct i2c_client *client)
+{
+
+	int err;
+
+	i2c_deregister_entry(((struct adm1021_data *) (client->data))->
+				 sysctl_id);
+
+	if ((err = i2c_detach_client(client))) {
+		printk
+		    ("adm1021.o: Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+
+	return 0;
+
+}
+
+
+/* No commands defined yet */
+int adm1021_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	return 0;
+}
+
+void adm1021_inc_use(struct i2c_client *client)
+{
+#ifdef MODULE
+	MOD_INC_USE_COUNT;
+#endif
+}
+
+void adm1021_dec_use(struct i2c_client *client)
+{
+#ifdef MODULE
+	MOD_DEC_USE_COUNT;
+#endif
+}
+
+/* All registers are byte-sized */
+int adm1021_read_value(struct i2c_client *client, u8 reg)
+{
+	return i2c_smbus_read_byte_data(client, reg);
+}
+
+int adm1021_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if (read_only > 0)
+		return 0;
+
+	return i2c_smbus_write_byte_data(client, reg, value);
+}
+
+void adm1021_update_client(struct i2c_client *client)
+{
+	struct adm1021_data *data = client->data;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+
+#ifdef DEBUG
+		printk("Starting adm1021 update\n");
+#endif
+
+		data->temp = adm1021_read_value(client, ADM1021_REG_TEMP);
+		data->temp_os =
+		    adm1021_read_value(client, ADM1021_REG_TOS_R);
+		data->temp_hyst =
+		    adm1021_read_value(client, ADM1021_REG_THYST_R);
+		data->remote_temp =
+		    adm1021_read_value(client, ADM1021_REG_REMOTE_TEMP);
+		data->remote_temp_os =
+		    adm1021_read_value(client, ADM1021_REG_REMOTE_TOS_R);
+		data->remote_temp_hyst =
+		    adm1021_read_value(client, ADM1021_REG_REMOTE_THYST_R);
+		data->alarms =
+		    adm1021_read_value(client, ADM1021_REG_STATUS) & 0xec;
+		if (data->type == adm1021)
+			data->die_code =
+			    adm1021_read_value(client,
+					       ADM1021_REG_DIE_CODE);
+		if (data->type == adm1023) {
+		  data->remote_temp_prec =
+		    adm1021_read_value(client, ADM1021_REG_REM_TEMP_PREC);
+		  data->remote_temp_os_prec =
+		    adm1021_read_value(client, ADM1021_REG_REM_TOS_PREC);
+		  data->remote_temp_hyst_prec =
+		    adm1021_read_value(client, ADM1021_REG_REM_THYST_PREC);
+		  data->remote_temp_offset =
+		    adm1021_read_value(client, ADM1021_REG_REM_OFFSET);
+		  data->remote_temp_offset_prec =
+		    adm1021_read_value(client, ADM1021_REG_REM_OFFSET_PREC);
+		}
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+}
+
+
+void adm1021_temp(struct i2c_client *client, int operation, int ctl_name,
+		  int *nrels_mag, long *results)
+{
+	struct adm1021_data *data = client->data;
+	if (operation == SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation == SENSORS_PROC_REAL_READ) {
+		adm1021_update_client(client);
+		results[0] = TEMP_FROM_REG(data->temp_os);
+		results[1] = TEMP_FROM_REG(data->temp_hyst);
+		results[2] = TEMP_FROM_REG(data->temp);
+		*nrels_mag = 3;
+	} else if (operation == SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >= 1) {
+			data->temp_os = TEMP_TO_REG(results[0]);
+			adm1021_write_value(client, ADM1021_REG_TOS_W,
+					    data->temp_os);
+		}
+		if (*nrels_mag >= 2) {
+			data->temp_hyst = TEMP_TO_REG(results[1]);
+			adm1021_write_value(client, ADM1021_REG_THYST_W,
+					    data->temp_hyst);
+		}
+	}
+}
+
+void adm1021_remote_temp(struct i2c_client *client, int operation,
+			 int ctl_name, int *nrels_mag, long *results)
+{
+int prec=0;
+	struct adm1021_data *data = client->data;
+	if (operation == SENSORS_PROC_REAL_INFO)
+		if (data->type == adm1023) { *nrels_mag = 3; }
+                 else { *nrels_mag = 0; }
+	else if (operation == SENSORS_PROC_REAL_READ) {
+		adm1021_update_client(client);
+		results[0] = TEMP_FROM_REG(data->remote_temp_os);
+		results[1] = TEMP_FROM_REG(data->remote_temp_hyst);
+		results[2] = TEMP_FROM_REG(data->remote_temp);
+		if (data->type == adm1023) {
+		  results[0]=results[0]*1000 + 
+		   ((data->remote_temp_os_prec >> 5) * 125);
+		  results[1]=results[1]*1000 + 
+		   ((data->remote_temp_hyst_prec >> 5) * 125);
+		  results[2]=(TEMP_FROM_REG(data->remote_temp_offset)*1000) + 
+                   ((data->remote_temp_offset_prec >> 5) * 125);
+		  results[3]=TEMP_FROM_REG(data->remote_temp)*1000 + 
+		   ((data->remote_temp_prec >> 5) * 125);
+ 		  *nrels_mag = 4;
+		} else {
+ 		  *nrels_mag = 3;
+		}
+	} else if (operation == SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >= 1) {
+			if (data->type == adm1023) {
+			  prec=((results[0]-((results[0]/1000)*1000))/125)<<5;
+			  adm1021_write_value(client,
+                                            ADM1021_REG_REM_TOS_PREC,
+                                            prec);
+			  results[0]=results[0]/1000;
+			  data->remote_temp_os_prec=prec;
+			}
+			data->remote_temp_os = TEMP_TO_REG(results[0]);
+			adm1021_write_value(client,
+					    ADM1021_REG_REMOTE_TOS_W,
+					    data->remote_temp_os);
+		}
+		if (*nrels_mag >= 2) {
+			if (data->type == adm1023) {
+			  prec=((results[1]-((results[1]/1000)*1000))/125)<<5;
+			  adm1021_write_value(client,
+                                            ADM1021_REG_REM_THYST_PREC,
+                                            prec);
+			  results[1]=results[1]/1000;
+			  data->remote_temp_hyst_prec=prec;
+			}
+			data->remote_temp_hyst = TEMP_TO_REG(results[1]);
+			adm1021_write_value(client,
+					    ADM1021_REG_REMOTE_THYST_W,
+					    data->remote_temp_hyst);
+		}
+		if (*nrels_mag >= 3) {
+			if (data->type == adm1023) {
+			  prec=((results[2]-((results[2]/1000)*1000))/125)<<5;
+			  adm1021_write_value(client,
+                                            ADM1021_REG_REM_OFFSET_PREC,
+                                            prec);
+			  results[2]=results[2]/1000;
+			  data->remote_temp_offset_prec=prec;
+			  data->remote_temp_offset=results[2];
+			  adm1021_write_value(client,
+                                            ADM1021_REG_REM_OFFSET,
+                                            data->remote_temp_offset);
+			}
+		}
+	}
+}
+
+void adm1021_die_code(struct i2c_client *client, int operation,
+		      int ctl_name, int *nrels_mag, long *results)
+{
+	struct adm1021_data *data = client->data;
+	if (operation == SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation == SENSORS_PROC_REAL_READ) {
+		adm1021_update_client(client);
+		results[0] = data->die_code;
+		*nrels_mag = 1;
+	} else if (operation == SENSORS_PROC_REAL_WRITE) {
+		/* Can't write to it */
+	}
+}
+
+void adm1021_alarms(struct i2c_client *client, int operation, int ctl_name,
+		    int *nrels_mag, long *results)
+{
+	struct adm1021_data *data = client->data;
+	if (operation == SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 0;
+	else if (operation == SENSORS_PROC_REAL_READ) {
+		adm1021_update_client(client);
+		results[0] = data->alarms;
+		*nrels_mag = 1;
+	} else if (operation == SENSORS_PROC_REAL_WRITE) {
+		/* Can't write to it */
+	}
+}
+
+int __init sensors_adm1021_init(void)
+{
+	int res;
+
+	printk("adm1021.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	adm1021_initialized = 0;
+	if ((res = i2c_add_driver(&adm1021_driver))) {
+		printk
+		    ("adm1021.o: Driver registration failed, module not inserted.\n");
+		adm1021_cleanup();
+		return res;
+	}
+	adm1021_initialized++;
+	return 0;
+}
+
+void __exit sensors_adm1021_exit(void)
+{
+	adm1021_cleanup();
+}
+
+static int adm1021_cleanup(void)
+{
+	int res;
+
+	if (adm1021_initialized >= 1) {
+		if ((res = i2c_del_driver(&adm1021_driver))) {
+			printk
+			    ("adm1021.o: Driver deregistration failed, module not removed.\n");
+			return res;
+		}
+		adm1021_initialized--;
+	}
+
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_DESCRIPTION("adm1021 driver");
+
+MODULE_PARM(read_only, "i");
+MODULE_PARM_DESC(read_only, "Don't set any values, read only mode");
+
+#endif				/* MODULE */
+
+module_init(sensors_adm1021_init)
+module_exit(sensors_adm1021_exit)
--- clean.2.5/drivers/i2c/chips/lm75.c	2002-12-01 17:33:37.000000000 +0100
+++ linux-sensors/drivers/i2c/chips/lm75.c	2002-12-01 17:57:14.000000000 +0100
@@ -0,0 +1,416 @@
+/*
+    lm75.c - Part of lm_sensors, Linux kernel modules for hardware
+             monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
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
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/slab.h>
+#include <linux/i2c.h>
+#include <linux/sensors.h>
+#include <linux/init.h>
+
+MODULE_LICENSE("GPL");
+
+/* Addresses to scan */
+static unsigned short normal_i2c[] = { SENSORS_I2C_END };
+static unsigned short normal_i2c_range[] = { 0x48, 0x4f, SENSORS_I2C_END };
+static unsigned int normal_isa[] = { SENSORS_ISA_END };
+static unsigned int normal_isa_range[] = { SENSORS_ISA_END };
+
+/* Insmod parameters */
+SENSORS_INSMOD_1(lm75);
+
+/* Many LM75 constants specified below */
+
+/* The LM75 registers */
+#define LM75_REG_TEMP 0x00
+#define LM75_REG_CONF 0x01
+#define LM75_REG_TEMP_HYST 0x02
+#define LM75_REG_TEMP_OS 0x03
+
+/* Conversions. Rounding and limit checking is only done on the TO_REG
+   variants. Note that you should be a bit careful with which arguments
+   these macros are called: arguments may be evaluated more than once.
+   Fixing this is just not worth it. */
+#define TEMP_FROM_REG(val) ((((val & 0x7fff) >> 7) * 5) | ((val & 0x8000)?-256:0))
+#define TEMP_TO_REG(val)   (SENSORS_LIMIT((val<0?(0x200+((val)/5))<<7:(((val) + 2) / 5) << 7),0,0xffff))
+
+/* Initial values */
+#define LM75_INIT_TEMP_OS 600
+#define LM75_INIT_TEMP_HYST 500
+
+/* Each client has this additional data */
+struct lm75_data {
+	int sysctl_id;
+
+	struct semaphore update_lock;
+	char valid;		/* !=0 if following fields are valid */
+	unsigned long last_updated;	/* In jiffies */
+
+	u16 temp, temp_os, temp_hyst;	/* Register values */
+};
+
+int __init sensors_lm75_init(void);
+void __exit sensors_lm75_exit(void);
+static int lm75_cleanup(void);
+
+static int lm75_attach_adapter(struct i2c_adapter *adapter);
+static int lm75_detect(struct i2c_adapter *adapter, int address,
+		       unsigned short flags, int kind);
+static void lm75_init_client(struct i2c_client *client);
+static int lm75_detach_client(struct i2c_client *client);
+static int lm75_command(struct i2c_client *client, unsigned int cmd,
+			void *arg);
+static void lm75_inc_use(struct i2c_client *client);
+static void lm75_dec_use(struct i2c_client *client);
+static u16 swap_bytes(u16 val);
+static int lm75_read_value(struct i2c_client *client, u8 reg);
+static int lm75_write_value(struct i2c_client *client, u8 reg, u16 value);
+static void lm75_temp(struct i2c_client *client, int operation,
+		      int ctl_name, int *nrels_mag, long *results);
+static void lm75_update_client(struct i2c_client *client);
+
+
+/* This is the driver that will be inserted */
+static struct i2c_driver lm75_driver = {
+	/* name */ "LM75 sensor chip driver",
+	/* id */ I2C_DRIVERID_LM75,
+	/* flags */ I2C_DF_NOTIFY,
+	/* attach_adapter */ &lm75_attach_adapter,
+	/* detach_client */ &lm75_detach_client,
+	/* command */ &lm75_command,
+	/* inc_use */ &lm75_inc_use,
+	/* dec_use */ &lm75_dec_use
+};
+
+/* These files are created for each detected LM75. This is just a template;
+   though at first sight, you might think we could use a statically
+   allocated list, we need some way to get back to the parent - which
+   is done through one of the 'extra' fields which are initialized
+   when a new copy is allocated. */
+static ctl_table lm75_dir_table_template[] = {
+	{LM75_SYSCTL_TEMP, "temp", NULL, 0, 0644, NULL, &i2c_proc_real,
+	 &i2c_sysctl_real, NULL, &lm75_temp},
+	{0}
+};
+
+/* Used by init/cleanup */
+static int __initdata lm75_initialized = 0;
+
+static int lm75_id = 0;
+
+int lm75_attach_adapter(struct i2c_adapter *adapter)
+{
+	return i2c_detect(adapter, &addr_data, lm75_detect);
+}
+
+/* This function is called by i2c_detect */
+int lm75_detect(struct i2c_adapter *adapter, int address,
+		unsigned short flags, int kind)
+{
+	int i, cur, conf, hyst, os;
+	struct i2c_client *new_client;
+	struct lm75_data *data;
+	int err = 0;
+	const char *type_name, *client_name;
+
+	/* Make sure we aren't probing the ISA bus!! This is just a safety check
+	   at this moment; i2c_detect really won't call us. */
+#ifdef DEBUG
+	if (i2c_is_isa_adapter(adapter)) {
+		printk
+		    ("lm75.o: lm75_detect called for an ISA bus adapter?!?\n");
+		return 0;
+	}
+#endif
+
+	if (!i2c_check_functionality(adapter, I2C_FUNC_SMBUS_BYTE_DATA |
+				     I2C_FUNC_SMBUS_WORD_DATA))
+		    goto ERROR0;
+
+	/* OK. For now, we presume we have a valid client. We now create the
+	   client structure, even though we cannot fill it completely yet.
+	   But it allows us to access lm75_{read,write}_value. */
+	if (!(new_client = kmalloc(sizeof(struct i2c_client) +
+				   sizeof(struct lm75_data),
+				   GFP_KERNEL))) {
+		err = -ENOMEM;
+		goto ERROR0;
+	}
+
+	data = (struct lm75_data *) (new_client + 1);
+	new_client->addr = address;
+	new_client->data = data;
+	new_client->adapter = adapter;
+	new_client->driver = &lm75_driver;
+	new_client->flags = 0;
+
+	/* Now, we do the remaining detection. It is lousy. */
+	if (kind < 0) {
+		cur = i2c_smbus_read_word_data(new_client, 0);
+		conf = i2c_smbus_read_byte_data(new_client, 1);
+		hyst = i2c_smbus_read_word_data(new_client, 2);
+		os = i2c_smbus_read_word_data(new_client, 3);
+		for (i = 0; i <= 0x1f; i++)
+			if (
+			    (i2c_smbus_read_byte_data
+			     (new_client, i * 8 + 1) != conf)
+			    ||
+			    (i2c_smbus_read_word_data
+			     (new_client, i * 8 + 2) != hyst)
+			    ||
+			    (i2c_smbus_read_word_data
+			     (new_client, i * 8 + 3) != os))
+				goto ERROR1;
+	}
+
+	/* Determine the chip type - only one kind supported! */
+	if (kind <= 0)
+		kind = lm75;
+
+	if (kind == lm75) {
+		type_name = "lm75";
+		client_name = "LM75 chip";
+	} else {
+#ifdef DEBUG
+		printk("lm75.o: Internal error: unknown kind (%d)?!?",
+		       kind);
+#endif
+		goto ERROR1;
+	}
+
+	/* Fill in the remaining client fields and put it into the global list */
+	strcpy(new_client->name, client_name);
+
+	new_client->id = lm75_id++;
+	data->valid = 0;
+	init_MUTEX(&data->update_lock);
+
+	/* Tell the I2C layer a new client has arrived */
+	if ((err = i2c_attach_client(new_client)))
+		goto ERROR3;
+
+	/* Register a new directory entry with module sensors */
+	if ((i = i2c_register_entry(new_client, type_name,
+					lm75_dir_table_template,
+					THIS_MODULE)) < 0) {
+		err = i;
+		goto ERROR4;
+	}
+	data->sysctl_id = i;
+
+	lm75_init_client(new_client);
+	return 0;
+
+/* OK, this is not exactly good programming practice, usually. But it is
+   very code-efficient in this case. */
+
+      ERROR4:
+	i2c_detach_client(new_client);
+      ERROR3:
+      ERROR1:
+	kfree(new_client);
+      ERROR0:
+	return err;
+}
+
+int lm75_detach_client(struct i2c_client *client)
+{
+	int err;
+
+#ifdef MODULE
+	if (MOD_IN_USE)
+		return -EBUSY;
+#endif
+
+
+	i2c_deregister_entry(((struct lm75_data *) (client->data))->
+				 sysctl_id);
+
+	if ((err = i2c_detach_client(client))) {
+		printk
+		    ("lm75.o: Client deregistration failed, client not detached.\n");
+		return err;
+	}
+
+	kfree(client);
+
+	return 0;
+}
+
+
+/* No commands defined yet */
+int lm75_command(struct i2c_client *client, unsigned int cmd, void *arg)
+{
+	return 0;
+}
+
+/* Nothing here yet */
+void lm75_inc_use(struct i2c_client *client)
+{
+#ifdef MODULE
+	MOD_INC_USE_COUNT;
+#endif
+}
+
+/* Nothing here yet */
+void lm75_dec_use(struct i2c_client *client)
+{
+#ifdef MODULE
+	MOD_DEC_USE_COUNT;
+#endif
+}
+
+u16 swap_bytes(u16 val)
+{
+	return (val >> 8) | (val << 8);
+}
+
+/* All registers are word-sized, except for the configuration register.
+   LM75 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+int lm75_read_value(struct i2c_client *client, u8 reg)
+{
+	if (reg == LM75_REG_CONF)
+		return i2c_smbus_read_byte_data(client, reg);
+	else
+		return swap_bytes(i2c_smbus_read_word_data(client, reg));
+}
+
+/* All registers are word-sized, except for the configuration register.
+   LM75 uses a high-byte first convention, which is exactly opposite to
+   the usual practice. */
+int lm75_write_value(struct i2c_client *client, u8 reg, u16 value)
+{
+	if (reg == LM75_REG_CONF)
+		return i2c_smbus_write_byte_data(client, reg, value);
+	else
+		return i2c_smbus_write_word_data(client, reg,
+						 swap_bytes(value));
+}
+
+void lm75_init_client(struct i2c_client *client)
+{
+	/* Initialize the LM75 chip */
+	lm75_write_value(client, LM75_REG_TEMP_OS,
+			 TEMP_TO_REG(LM75_INIT_TEMP_OS));
+	lm75_write_value(client, LM75_REG_TEMP_HYST,
+			 TEMP_TO_REG(LM75_INIT_TEMP_HYST));
+	lm75_write_value(client, LM75_REG_CONF, 0);
+}
+
+void lm75_update_client(struct i2c_client *client)
+{
+	struct lm75_data *data = client->data;
+
+	down(&data->update_lock);
+
+	if ((jiffies - data->last_updated > HZ + HZ / 2) ||
+	    (jiffies < data->last_updated) || !data->valid) {
+
+#ifdef DEBUG
+		printk("Starting lm75 update\n");
+#endif
+
+		data->temp = lm75_read_value(client, LM75_REG_TEMP);
+		data->temp_os = lm75_read_value(client, LM75_REG_TEMP_OS);
+		data->temp_hyst =
+		    lm75_read_value(client, LM75_REG_TEMP_HYST);
+		data->last_updated = jiffies;
+		data->valid = 1;
+	}
+
+	up(&data->update_lock);
+}
+
+
+void lm75_temp(struct i2c_client *client, int operation, int ctl_name,
+	       int *nrels_mag, long *results)
+{
+	struct lm75_data *data = client->data;
+	if (operation == SENSORS_PROC_REAL_INFO)
+		*nrels_mag = 1;
+	else if (operation == SENSORS_PROC_REAL_READ) {
+		lm75_update_client(client);
+		results[0] = TEMP_FROM_REG(data->temp_os);
+		results[1] = TEMP_FROM_REG(data->temp_hyst);
+		results[2] = TEMP_FROM_REG(data->temp);
+		*nrels_mag = 3;
+	} else if (operation == SENSORS_PROC_REAL_WRITE) {
+		if (*nrels_mag >= 1) {
+			data->temp_os = TEMP_TO_REG(results[0]);
+			lm75_write_value(client, LM75_REG_TEMP_OS,
+					 data->temp_os);
+		}
+		if (*nrels_mag >= 2) {
+			data->temp_hyst = TEMP_TO_REG(results[1]);
+			lm75_write_value(client, LM75_REG_TEMP_HYST,
+					 data->temp_hyst);
+		}
+	}
+}
+
+int __init sensors_lm75_init(void)
+{
+	int res;
+
+	printk("lm75.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	lm75_initialized = 0;
+	if ((res = i2c_add_driver(&lm75_driver))) {
+		printk
+		    ("lm75.o: Driver registration failed, module not inserted.\n");
+		lm75_cleanup();
+		return res;
+	}
+	lm75_initialized++;
+	return 0;
+}
+
+void __exit sensors_lm75_exit(void)
+{
+	lm75_cleanup();
+}
+
+static int lm75_cleanup(void)
+{
+	int res;
+
+	if (lm75_initialized >= 1) {
+		if ((res = i2c_del_driver(&lm75_driver))) {
+			printk
+			    ("lm75.o: Driver deregistration failed, module not removed.\n");
+			return res;
+		}
+		lm75_initialized--;
+	}
+
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("LM75 driver");
+
+#endif				/* MODULE */
+
+module_init(sensors_lm75_init);
+module_exit(sensors_lm75_exit);
--- clean.2.5/drivers/i2c/chips/sensors.c	2002-12-01 17:33:45.000000000 +0100
+++ linux-sensors/drivers/i2c/chips/sensors.c	2002-12-01 17:57:14.000000000 +0100
@@ -0,0 +1,37 @@
+/*
+    sensors.c - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl> 
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
+/* Not configurable as a module */
+
+#include <linux/init.h>
+
+extern int sensors_adm1021_init(void);
+extern int sensors_lm75_init(void);
+
+int __init sensors_init_all(void)
+{
+#ifdef CONFIG_SENSORS_ADM1021
+	sensors_adm1021_init();
+#endif
+#ifdef CONFIG_SENSORS_LM75
+	sensors_lm75_init();
+#endif
+	return 0;
+}
--- clean.2.5/drivers/i2c/i2c-core.c	2002-11-23 19:55:19.000000000 +0100
+++ linux-sensors/drivers/i2c/i2c-core.c	2002-12-01 17:57:14.000000000 +0100
@@ -21,7 +21,7 @@
    All SMBus-related things are written by Frodo Looijaard <frodol@dds.nl>
    SMBus 2.0 support by Mark Studebaker <mdsxyz123@yahoo.com>                */
 
-/* $Id: i2c-core.c,v 1.86 2002/09/12 06:47:26 ac9410 Exp $ */
+/* $Id: i2c-core.c,v 1.89 2002/11/03 16:47:16 mds Exp $ */
 
 #include <linux/module.h>
 #include <linux/kernel.h>
@@ -77,7 +77,8 @@
 
 #ifdef CONFIG_PROC_FS
 
-static int i2cproc_init(void);
+int __init i2cproc_init(void);
+void __exit i2cproc_exit(void);
 static int i2cproc_cleanup(void);
 
 static ssize_t i2cproc_bus_read(struct file * file, char * buf,size_t count, 
@@ -622,7 +623,8 @@
 	struct inode * inode = file->f_dentry->d_inode;
 	char *kbuf;
 	struct i2c_client *client;
-	int i,j,k,order_nr,len=0,len_total;
+	int i,j,k,order_nr,len=0;
+	size_t len_total;
 	int order[I2C_CLIENT_MAX];
 #define OUTPUT_LENGTH_PER_LINE 70
 
@@ -1331,15 +1333,15 @@
 		if (read_write == I2C_SMBUS_READ) {
 			msg[1].len = I2C_SMBUS_I2C_BLOCK_MAX;
 		} else {
-			msg[0].len = data->block[0] + 2;
-			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 2) {
+			msg[0].len = data->block[0] + 1;
+			if (msg[0].len > I2C_SMBUS_I2C_BLOCK_MAX + 1) {
 				printk("i2c-core.o: i2c_smbus_xfer_emulated called with "
 				       "invalid block write size (%d)\n",
 				       data->block[0]);
 				return -1;
 			}
-			for (i = 0; i < data->block[0]; i++)
-				msgbuf0[i] = data->block[i+1];
+			for (i = 1; i <= data->block[0]; i++)
+				msgbuf0[i] = data->block[i];
 		}
 		break;
 	default:
@@ -1455,7 +1457,7 @@
 	return 0;
 }
 
-static void __exit i2c_exit(void)
+void __exit i2c_exit(void)
 {
 	i2cproc_cleanup();
 }
--- clean.2.5/drivers/i2c/i2c-dev.c	2002-11-29 21:16:36.000000000 +0100
+++ linux-sensors/drivers/i2c/i2c-dev.c	2002-12-01 17:57:14.000000000 +0100
@@ -28,7 +28,7 @@
 /* The devfs code is contributed by Philipp Matthias Hahn 
    <pmhahn@titan.lahn.de> */
 
-/* $Id: i2c-dev.c,v 1.46 2002/07/06 02:07:39 mds Exp $ */
+/* $Id: i2c-dev.c,v 1.48 2002/10/01 14:10:04 ac9410 Exp $ */
 
 #include <linux/config.h>
 #include <linux/kernel.h>
@@ -50,6 +50,10 @@
 #include <linux/i2c.h>
 #include <linux/i2c-dev.h>
 
+int __init i2c_dev_init(void);
+void __exit i2c_dev_exit(void);
+static int dev_cleanup(void);
+
 /* struct file_operations changed too often in the 2.1 series for nice code */
 
 static ssize_t i2cdev_read (struct file *file, char *buf, size_t count, 
@@ -445,7 +449,7 @@
 	return -1;
 }
 
-static void i2cdev_cleanup(void)
+static int dev_cleanup(void)
 {
 	int res;
 
@@ -467,6 +471,7 @@
 		}
 		i2cdev_initialized --;
 	}
+	return 0;
 }
 
 int __init i2c_dev_init(void)
@@ -488,13 +493,18 @@
 
 	if ((res = i2c_add_driver(&i2cdev_driver))) {
 		printk(KERN_ERR "i2c-dev.o: Driver registration failed, module not inserted.\n");
-		i2cdev_cleanup();
+		dev_cleanup();
 		return res;
 	}
 	i2cdev_initialized ++;
 	return 0;
 }
 
+void __exit i2c_dev_exit(void)
+{
+	dev_cleanup();
+}
+
 EXPORT_NO_SYMBOLS;
 
 MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Simon G. Vogl <simon@tk.uni-linz.ac.at>");
@@ -502,4 +512,4 @@
 MODULE_LICENSE("GPL");
 
 module_init(i2c_dev_init);
-module_exit(i2cdev_cleanup);
+module_exit(i2c_dev_exit);
--- clean.2.5/drivers/i2c/i2c-proc.c	2002-09-30 20:33:46.000000000 +0200
+++ linux-sensors/drivers/i2c/i2c-proc.c	2002-12-01 17:57:14.000000000 +0100
@@ -40,6 +40,10 @@
 #define THIS_MODULE NULL
 #endif
 
+int __init sensors_init(void);
+void __exit i2c_proc_exit(void);
+static int proc_cleanup(void);
+
 static int i2c_create_name(char **name, const char *prefix,
 			       struct i2c_adapter *adapter, int addr);
 static int i2c_parse_reals(int *nrels, void *buffer, int bufsize,
@@ -56,6 +60,7 @@
 
 #define SENSORS_ENTRY_MAX 20
 static struct ctl_table_header *i2c_entries[SENSORS_ENTRY_MAX];
+static unsigned short i2c_inodes[SENSORS_ENTRY_MAX];
 
 static struct i2c_client *i2c_clients[SENSORS_ENTRY_MAX];
 
@@ -186,6 +191,8 @@
 		return id;
 	}
 #endif				/* DEBUG */
+	i2c_inodes[id - 256] =
+	    new_header->ctl_table->child->child->de->low_ino;
 	new_header->ctl_table->child->child->de->owner = controlling_mod;
 
 	return id;
@@ -208,6 +215,49 @@
 	}
 }
 
+/* Monitor access for /proc/sys/dev/sensors; make unloading i2c-proc.o 
+   impossible if some process still uses it or some file in it */
+void i2c_fill_inode(struct inode *inode, int fill)
+{
+	if (fill)
+		MOD_INC_USE_COUNT;
+	else
+		MOD_DEC_USE_COUNT;
+}
+
+/* Monitor access for /proc/sys/dev/sensors/ directories; make unloading
+   the corresponding module impossible if some process still uses it or
+   some file in it */
+void i2c_dir_fill_inode(struct inode *inode, int fill)
+{
+	int i;
+	struct i2c_client *client;
+
+#ifdef DEBUG
+	if (!inode) {
+		printk(KERN_ERR "i2c-proc.o: Warning: inode NULL in fill_inode()\n");
+		return;
+	}
+#endif				/* def DEBUG */
+
+	for (i = 0; i < SENSORS_ENTRY_MAX; i++)
+		if (i2c_clients[i]
+		    && (i2c_inodes[i] == inode->i_ino)) break;
+#ifdef DEBUG
+	if (i == SENSORS_ENTRY_MAX) {
+		printk
+		    (KERN_ERR "i2c-proc.o: Warning: inode (%ld) not found in fill_inode()\n",
+		     inode->i_ino);
+		return;
+	}
+#endif				/* def DEBUG */
+	client = i2c_clients[i];
+	if (fill)
+		client->driver->inc_use(client);
+	else
+		client->driver->dec_use(client);
+}
+
 int i2c_proc_chips(ctl_table * ctl, int write, struct file *filp,
 		       void *buffer, size_t * lenp)
 {
@@ -813,12 +863,18 @@
 	return 0;
 }
 
-static void __exit i2c_cleanup(void)
+void __exit i2c_proc_exit(void)
+{
+	proc_cleanup();
+}
+
+static int proc_cleanup(void)
 {
 	if (i2c_initialized >= 1) {
 		unregister_sysctl_table(i2c_proc_header);
 		i2c_initialized--;
 	}
+	return 0;
 }
 
 EXPORT_SYMBOL(i2c_deregister_entry);
@@ -832,4 +888,4 @@
 MODULE_LICENSE("GPL");
 
 module_init(sensors_init);
-module_exit(i2c_cleanup);
+module_exit(i2c_proc_exit);
--- clean.2.5/include/linux/i2c-proc.h	2002-06-26 20:27:06.000000000 +0200
+++ linux-sensors/include/linux/i2c-proc.h	2002-12-01 17:57:14.000000000 +0100
@@ -348,6 +348,31 @@
                                                  {NULL}}; \
   SENSORS_INSMOD
 
+#define SENSORS_INSMOD_8(chip1,chip2,chip3,chip4,chip5,chip6,chip7,chip8) \
+  enum chips { any_chip, chip1, chip2, chip3, chip4, chip5, chip6, chip7, chip8 }; \
+  SENSORS_MODULE_PARM(force, \
+                      "List of adapter,address pairs to boldly assume " \
+                      "to be present"); \
+  SENSORS_MODULE_PARM_FORCE(chip1); \
+  SENSORS_MODULE_PARM_FORCE(chip2); \
+  SENSORS_MODULE_PARM_FORCE(chip3); \
+  SENSORS_MODULE_PARM_FORCE(chip4); \
+  SENSORS_MODULE_PARM_FORCE(chip5); \
+  SENSORS_MODULE_PARM_FORCE(chip6); \
+  SENSORS_MODULE_PARM_FORCE(chip7); \
+  SENSORS_MODULE_PARM_FORCE(chip8); \
+  static struct i2c_force_data forces[] = {{force,any_chip}, \
+                                                 {force_ ## chip1,chip1}, \
+                                                 {force_ ## chip2,chip2}, \
+                                                 {force_ ## chip3,chip3}, \
+                                                 {force_ ## chip4,chip4}, \
+                                                 {force_ ## chip5,chip5}, \
+                                                 {force_ ## chip6,chip6}, \
+                                                 {force_ ## chip7,chip7}, \
+                                                 {force_ ## chip8,chip8}, \
+                                                 {NULL}}; \
+  SENSORS_INSMOD
+
 typedef int i2c_found_addr_proc(struct i2c_adapter *adapter,
 				    int addr, unsigned short flags,
 				    int kind);
--- clean.2.5/include/linux/sensors.h	2002-12-01 18:13:52.000000000 +0100
+++ linux-sensors/include/linux/sensors.h	2002-12-01 18:13:39.000000000 +0100
@@ -0,0 +1,690 @@
+/*
+    sensors.h - Part of lm_sensors, Linux kernel modules for hardware
+                monitoring
+    Copyright (c) 1998, 1999  Frodo Looijaard <frodol@dds.nl>
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
+#ifndef SENSORS_NSENSORS_H
+#define SENSORS_NSENSORS_H
+
+#define LM_DATE "20020915"
+#define LM_VERSION "2.6.5"
+
+#include <linux/i2c-proc.h>
+
+#define LM78_SYSCTL_IN0 1000	/* Volts * 100 */
+#define LM78_SYSCTL_IN1 1001
+#define LM78_SYSCTL_IN2 1002
+#define LM78_SYSCTL_IN3 1003
+#define LM78_SYSCTL_IN4 1004
+#define LM78_SYSCTL_IN5 1005
+#define LM78_SYSCTL_IN6 1006
+#define LM78_SYSCTL_FAN1 1101	/* Rotations/min */
+#define LM78_SYSCTL_FAN2 1102
+#define LM78_SYSCTL_FAN3 1103
+#define LM78_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
+#define LM78_SYSCTL_VID 1300	/* Volts * 100 */
+#define LM78_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define LM78_SYSCTL_ALARMS 2001	/* bitvector */
+
+#define LM78_ALARM_IN0 0x0001
+#define LM78_ALARM_IN1 0x0002
+#define LM78_ALARM_IN2 0x0004
+#define LM78_ALARM_IN3 0x0008
+#define LM78_ALARM_IN4 0x0100
+#define LM78_ALARM_IN5 0x0200
+#define LM78_ALARM_IN6 0x0400
+#define LM78_ALARM_FAN1 0x0040
+#define LM78_ALARM_FAN2 0x0080
+#define LM78_ALARM_FAN3 0x0800
+#define LM78_ALARM_TEMP 0x0010
+#define LM78_ALARM_BTI 0x0020
+#define LM78_ALARM_CHAS 0x1000
+#define LM78_ALARM_FIFO 0x2000
+#define LM78_ALARM_SMI_IN 0x4000
+
+#define W83781D_SYSCTL_IN0 1000	/* Volts * 100 */
+#define W83781D_SYSCTL_IN1 1001
+#define W83781D_SYSCTL_IN2 1002
+#define W83781D_SYSCTL_IN3 1003
+#define W83781D_SYSCTL_IN4 1004
+#define W83781D_SYSCTL_IN5 1005
+#define W83781D_SYSCTL_IN6 1006
+#define W83781D_SYSCTL_IN7 1007
+#define W83781D_SYSCTL_IN8 1008
+#define W83781D_SYSCTL_FAN1 1101	/* Rotations/min */
+#define W83781D_SYSCTL_FAN2 1102
+#define W83781D_SYSCTL_FAN3 1103
+#define W83781D_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
+#define W83781D_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
+#define W83781D_SYSCTL_TEMP3 1202	/* Degrees Celcius * 10 */
+#define W83781D_SYSCTL_VID 1300		/* Volts * 1000 */
+#define W83781D_SYSCTL_VRM 1301
+#define W83781D_SYSCTL_PWM1 1401
+#define W83781D_SYSCTL_PWM2 1402
+#define W83781D_SYSCTL_PWM3 1403
+#define W83781D_SYSCTL_PWM4 1404
+#define W83781D_SYSCTL_SENS1 1501	/* 1, 2, or Beta (3000-5000) */
+#define W83781D_SYSCTL_SENS2 1502
+#define W83781D_SYSCTL_SENS3 1503
+#define W83781D_SYSCTL_RT1   1601	/* 32-entry table */
+#define W83781D_SYSCTL_RT2   1602	/* 32-entry table */
+#define W83781D_SYSCTL_RT3   1603	/* 32-entry table */
+#define W83781D_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define W83781D_SYSCTL_ALARMS 2001	/* bitvector */
+#define W83781D_SYSCTL_BEEP 2002	/* bitvector */
+
+#define W83781D_ALARM_IN0 0x0001
+#define W83781D_ALARM_IN1 0x0002
+#define W83781D_ALARM_IN2 0x0004
+#define W83781D_ALARM_IN3 0x0008
+#define W83781D_ALARM_IN4 0x0100
+#define W83781D_ALARM_IN5 0x0200
+#define W83781D_ALARM_IN6 0x0400
+#define W83782D_ALARM_IN7 0x10000
+#define W83782D_ALARM_IN8 0x20000
+#define W83781D_ALARM_FAN1 0x0040
+#define W83781D_ALARM_FAN2 0x0080
+#define W83781D_ALARM_FAN3 0x0800
+#define W83781D_ALARM_TEMP1 0x0010
+#define W83781D_ALARM_TEMP23 0x0020	/* 781D only */
+#define W83781D_ALARM_TEMP2 0x0020	/* 782D/783S */
+#define W83781D_ALARM_TEMP3 0x2000	/* 782D only */
+#define W83781D_ALARM_CHAS 0x1000
+
+#define LM75_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
+
+#define ADM1021_SYSCTL_TEMP 1200
+#define ADM1021_SYSCTL_REMOTE_TEMP 1201
+#define ADM1021_SYSCTL_DIE_CODE 1202
+#define ADM1021_SYSCTL_ALARMS 1203
+
+#define ADM1021_ALARM_TEMP_HIGH 0x40
+#define ADM1021_ALARM_TEMP_LOW 0x20
+#define ADM1021_ALARM_RTEMP_HIGH 0x10
+#define ADM1021_ALARM_RTEMP_LOW 0x08
+#define ADM1021_ALARM_RTEMP_NA 0x04
+
+#define GL518_SYSCTL_VDD  1000	/* Volts * 100 */
+#define GL518_SYSCTL_VIN1 1001
+#define GL518_SYSCTL_VIN2 1002
+#define GL518_SYSCTL_VIN3 1003
+#define GL518_SYSCTL_FAN1 1101	/* RPM */
+#define GL518_SYSCTL_FAN2 1102
+#define GL518_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
+#define GL518_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define GL518_SYSCTL_ALARMS 2001	/* bitvector */
+#define GL518_SYSCTL_BEEP 2002	/* bitvector */
+#define GL518_SYSCTL_FAN1OFF 2003
+#define GL518_SYSCTL_ITERATE 2004
+
+#define GL518_ALARM_VDD 0x01
+#define GL518_ALARM_VIN1 0x02
+#define GL518_ALARM_VIN2 0x04
+#define GL518_ALARM_VIN3 0x08
+#define GL518_ALARM_TEMP 0x10
+#define GL518_ALARM_FAN1 0x20
+#define GL518_ALARM_FAN2 0x40
+
+#define GL520_SYSCTL_VDD  1000	/* Volts * 100 */
+#define GL520_SYSCTL_VIN1 1001
+#define GL520_SYSCTL_VIN2 1002
+#define GL520_SYSCTL_VIN3 1003
+#define GL520_SYSCTL_VIN4 1004
+#define GL520_SYSCTL_FAN1 1101	/* RPM */
+#define GL520_SYSCTL_FAN2 1102
+#define GL520_SYSCTL_TEMP1 1200	/* Degrees Celcius * 10 */
+#define GL520_SYSCTL_TEMP2 1201	/* Degrees Celcius * 10 */
+#define GL520_SYSCTL_VID 1300
+#define GL520_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define GL520_SYSCTL_ALARMS 2001	/* bitvector */
+#define GL520_SYSCTL_BEEP 2002	/* bitvector */
+#define GL520_SYSCTL_FAN1OFF 2003
+#define GL520_SYSCTL_CONFIG 2004
+
+#define GL520_ALARM_VDD 0x01
+#define GL520_ALARM_VIN1 0x02
+#define GL520_ALARM_VIN2 0x04
+#define GL520_ALARM_VIN3 0x08
+#define GL520_ALARM_TEMP1 0x10
+#define GL520_ALARM_FAN1 0x20
+#define GL520_ALARM_FAN2 0x40
+#define GL520_ALARM_TEMP2 0x80
+#define GL520_ALARM_VIN4 0x80
+
+#define EEPROM_SYSCTL1 1000
+#define EEPROM_SYSCTL2 1001
+#define EEPROM_SYSCTL3 1002
+#define EEPROM_SYSCTL4 1003
+#define EEPROM_SYSCTL5 1004
+#define EEPROM_SYSCTL6 1005
+#define EEPROM_SYSCTL7 1006
+#define EEPROM_SYSCTL8 1007
+#define EEPROM_SYSCTL9 1008
+#define EEPROM_SYSCTL10 1009
+#define EEPROM_SYSCTL11 1010
+#define EEPROM_SYSCTL12 1011
+#define EEPROM_SYSCTL13 1012
+#define EEPROM_SYSCTL14 1013
+#define EEPROM_SYSCTL15 1014
+#define EEPROM_SYSCTL16 1015
+
+#define LM80_SYSCTL_IN0 1000	/* Volts * 100 */
+#define LM80_SYSCTL_IN1 1001
+#define LM80_SYSCTL_IN2 1002
+#define LM80_SYSCTL_IN3 1003
+#define LM80_SYSCTL_IN4 1004
+#define LM80_SYSCTL_IN5 1005
+#define LM80_SYSCTL_IN6 1006
+#define LM80_SYSCTL_FAN1 1101	/* Rotations/min */
+#define LM80_SYSCTL_FAN2 1102
+#define LM80_SYSCTL_TEMP 1250	/* Degrees Celcius * 100 */
+#define LM80_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define LM80_SYSCTL_ALARMS 2001	/* bitvector */
+
+#define ADM9240_SYSCTL_IN0 1000	/* Volts * 100 */
+#define ADM9240_SYSCTL_IN1 1001
+#define ADM9240_SYSCTL_IN2 1002
+#define ADM9240_SYSCTL_IN3 1003
+#define ADM9240_SYSCTL_IN4 1004
+#define ADM9240_SYSCTL_IN5 1005
+#define ADM9240_SYSCTL_FAN1 1101	/* Rotations/min */
+#define ADM9240_SYSCTL_FAN2 1102
+#define ADM9240_SYSCTL_TEMP 1250	/* Degrees Celcius * 100 */
+#define ADM9240_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define ADM9240_SYSCTL_ALARMS 2001	/* bitvector */
+#define ADM9240_SYSCTL_ANALOG_OUT 2002
+#define ADM9240_SYSCTL_VID 2003
+
+#define ADM9240_ALARM_IN0 0x0001
+#define ADM9240_ALARM_IN1 0x0002
+#define ADM9240_ALARM_IN2 0x0004
+#define ADM9240_ALARM_IN3 0x0008
+#define ADM9240_ALARM_IN4 0x0100
+#define ADM9240_ALARM_IN5 0x0200
+#define ADM9240_ALARM_FAN1 0x0040
+#define ADM9240_ALARM_FAN2 0x0080
+#define ADM9240_ALARM_TEMP 0x0010
+#define ADM9240_ALARM_CHAS 0x1000
+
+#define ADM1024_SYSCTL_IN0 1000	/* Volts * 100 */
+#define ADM1024_SYSCTL_IN1 1001
+#define ADM1024_SYSCTL_IN2 1002
+#define ADM1024_SYSCTL_IN3 1003
+#define ADM1024_SYSCTL_IN4 1004
+#define ADM1024_SYSCTL_IN5 1005
+#define ADM1024_SYSCTL_FAN1 1101	/* Rotations/min */
+#define ADM1024_SYSCTL_FAN2 1102
+#define ADM1024_SYSCTL_TEMP 1250	/* Degrees Celcius * 100 */
+#define ADM1024_SYSCTL_TEMP1 1290	/* Degrees Celcius */
+#define ADM1024_SYSCTL_TEMP2 1295	/* Degrees Celcius */
+#define ADM1024_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define ADM1024_SYSCTL_ALARMS 2001	/* bitvector */
+#define ADM1024_SYSCTL_ANALOG_OUT 2002
+#define ADM1024_SYSCTL_VID 2003
+
+#define ADM1024_ALARM_IN0 0x0001
+#define ADM1024_ALARM_IN1 0x0002
+#define ADM1024_ALARM_IN2 0x0004
+#define ADM1024_ALARM_IN3 0x0008
+#define ADM1024_ALARM_IN4 0x0100
+#define ADM1024_ALARM_IN5 0x0200
+#define ADM1024_ALARM_FAN1 0x0040
+#define ADM1024_ALARM_FAN2 0x0080
+#define ADM1024_ALARM_TEMP 0x0010
+#define ADM1024_ALARM_TEMP1 0x0020
+#define ADM1024_ALARM_TEMP2 0x0001
+#define ADM1024_ALARM_CHAS 0x1000
+
+#define ADM1025_SYSCTL_IN0 1000 /* Volts * 100 */
+#define ADM1025_SYSCTL_IN1 1001
+#define ADM1025_SYSCTL_IN2 1002
+#define ADM1025_SYSCTL_IN3 1003
+#define ADM1025_SYSCTL_IN4 1004
+#define ADM1025_SYSCTL_IN5 1005
+#define ADM1025_SYSCTL_RTEMP 1251
+#define ADM1025_SYSCTL_TEMP 1250        /* Degrees Celcius * 100 */
+#define ADM1025_SYSCTL_ALARMS 2001      /* bitvector */
+#define ADM1025_SYSCTL_ANALOG_OUT 2002
+#define ADM1025_SYSCTL_VID 2003
+#define ADM1025_SYSCTL_VRM 2004
+
+#define ADM1025_ALARM_IN0 0x0001
+#define ADM1025_ALARM_IN1 0x0002
+#define ADM1025_ALARM_IN2 0x0004
+#define ADM1025_ALARM_IN3 0x0008
+#define ADM1025_ALARM_IN4 0x0100
+#define ADM1025_ALARM_IN5 0x0200
+#define ADM1025_ALARM_RTEMP 0x0020
+#define ADM1025_ALARM_TEMP 0x0010
+
+#define LTC1710_SYSCTL_SWITCH_1 1000
+#define LTC1710_SYSCTL_SWITCH_2 1001
+
+#define LM80_ALARM_IN0 0x0001
+#define LM80_ALARM_IN1 0x0002
+#define LM80_ALARM_IN2 0x0004
+#define LM80_ALARM_IN3 0x0008
+#define LM80_ALARM_IN4 0x0010
+#define LM80_ALARM_IN5 0x0020
+#define LM80_ALARM_IN6 0x0040
+#define LM80_ALARM_FAN1 0x0400
+#define LM80_ALARM_FAN2 0x0800
+#define LM80_ALARM_TEMP_HOT 0x0100
+#define LM80_ALARM_TEMP_OS 0x2000
+#define LM80_ALARM_CHAS 0x1000
+#define LM80_ALARM_BTI 0x0200
+#define LM80_ALARM_INT_IN 0x0080
+
+#define MAXI_SYSCTL_FAN1   1101	/* Rotations/min */
+#define MAXI_SYSCTL_FAN2   1102	/* Rotations/min */
+#define MAXI_SYSCTL_FAN3   1103	/* Rotations/min */
+#define MAXI_SYSCTL_FAN4   1104	/* Rotations/min */
+#define MAXI_SYSCTL_TEMP1  1201	/* Degrees Celcius */
+#define MAXI_SYSCTL_TEMP2  1202	/* Degrees Celcius */
+#define MAXI_SYSCTL_TEMP3  1203	/* Degrees Celcius */
+#define MAXI_SYSCTL_TEMP4  1204	/* Degrees Celcius */
+#define MAXI_SYSCTL_TEMP5  1205	/* Degrees Celcius */
+#define MAXI_SYSCTL_TEMP6  1206	/* Degrees Celcius */
+#define MAXI_SYSCTL_PLL    1301	/* MHz */
+#define MAXI_SYSCTL_VID1   1401	/* Volts / 6.337, for nba just Volts */
+#define MAXI_SYSCTL_VID2   1402	/* Volts */
+#define MAXI_SYSCTL_VID3   1403	/* Volts */
+#define MAXI_SYSCTL_VID4   1404	/* Volts */
+#define MAXI_SYSCTL_VID5   1405	/* Volts */
+#define MAXI_SYSCTL_LCD1   1501	/* Line 1 of LCD */
+#define MAXI_SYSCTL_LCD2   1502	/* Line 2 of LCD */
+#define MAXI_SYSCTL_LCD3   1503	/* Line 3 of LCD */
+#define MAXI_SYSCTL_LCD4   1504	/* Line 4 of LCD */
+#define MAXI_SYSCTL_ALARMS 2001	/* Bitvector (see below) */
+
+#define MAXI_ALARM_VID4      0x0001
+#define MAXI_ALARM_TEMP2     0x0002
+#define MAXI_ALARM_VID1      0x0004
+#define MAXI_ALARM_VID2      0x0008
+#define MAXI_ALARM_VID3      0x0010
+#define MAXI_ALARM_PLL       0x0080
+#define MAXI_ALARM_TEMP4     0x0100
+#define MAXI_ALARM_TEMP5     0x0200
+#define MAXI_ALARM_FAN1      0x1000
+#define MAXI_ALARM_FAN2      0x2000
+#define MAXI_ALARM_FAN3      0x4000
+
+#define MAXI_ALARM_FAN       0x0100	/* To be used with  MaxiLife'99 */
+#define MAXI_ALARM_VID       0x0200	/* The MSB specifies which sensor */
+#define MAXI_ALARM_TEMP      0x0400	/* in the alarm group failed, i.e.: */
+#define MAXI_ALARM_VADD      0x0800	/* 0x0402 = TEMP2 failed = CPU2 temp */
+
+#define SIS5595_SYSCTL_IN0 1000	/* Volts * 100 */
+#define SIS5595_SYSCTL_IN1 1001
+#define SIS5595_SYSCTL_IN2 1002
+#define SIS5595_SYSCTL_IN3 1003
+#define SIS5595_SYSCTL_IN4 1004
+#define SIS5595_SYSCTL_FAN1 1101	/* Rotations/min */
+#define SIS5595_SYSCTL_FAN2 1102
+#define SIS5595_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
+#define SIS5595_SYSCTL_FAN_DIV 2000	/* 1, 2, 4 or 8 */
+#define SIS5595_SYSCTL_ALARMS 2001	/* bitvector */
+
+#define SIS5595_ALARM_IN0 0x01
+#define SIS5595_ALARM_IN1 0x02
+#define SIS5595_ALARM_IN2 0x04
+#define SIS5595_ALARM_IN3 0x08
+#define SIS5595_ALARM_BTI 0x20
+#define SIS5595_ALARM_FAN1 0x40
+#define SIS5595_ALARM_FAN2 0x80
+#define SIS5595_ALARM_IN4  0x8000
+#define SIS5595_ALARM_TEMP 0x8000
+
+#define VIA686A_SYSCTL_IN0 1000
+#define VIA686A_SYSCTL_IN1 1001
+#define VIA686A_SYSCTL_IN2 1002
+#define VIA686A_SYSCTL_IN3 1003
+#define VIA686A_SYSCTL_IN4 1004
+#define VIA686A_SYSCTL_FAN1 1101
+#define VIA686A_SYSCTL_FAN2 1102
+#define VIA686A_SYSCTL_TEMP 1200
+#define VIA686A_SYSCTL_TEMP2 1201
+#define VIA686A_SYSCTL_TEMP3 1202
+#define VIA686A_SYSCTL_FAN_DIV 2000
+#define VIA686A_SYSCTL_ALARMS 2001
+
+#define VIA686A_ALARM_IN0 0x01
+#define VIA686A_ALARM_IN1 0x02
+#define VIA686A_ALARM_IN2 0x04
+#define VIA686A_ALARM_IN3 0x08
+#define VIA686A_ALARM_TEMP 0x10
+#define VIA686A_ALARM_FAN1 0x40
+#define VIA686A_ALARM_FAN2 0x80
+#define VIA686A_ALARM_IN4 0x100
+#define VIA686A_ALARM_TEMP2 0x800
+#define VIA686A_ALARM_CHAS 0x1000
+#define VIA686A_ALARM_TEMP3 0x8000
+
+#define ICSPLL_SYSCTL1 1000
+
+#define BT869_SYSCTL_STATUS 1000
+#define BT869_SYSCTL_NTSC   1001
+#define BT869_SYSCTL_HALF   1002
+#define BT869_SYSCTL_RES    1003
+#define BT869_SYSCTL_COLORBARS    1004
+#define BT869_SYSCTL_DEPTH  1005
+#define BT869_SYSCTL_SVIDEO 1006
+
+#define MATORB_SYSCTL_DISP 1000
+
+#define THMC50_SYSCTL_TEMP 1200	/* Degrees Celcius */
+#define THMC50_SYSCTL_REMOTE_TEMP 1201	/* Degrees Celcius */
+#define THMC50_SYSCTL_INTER 1202
+#define THMC50_SYSCTL_INTER_MASK 1203
+#define THMC50_SYSCTL_DIE_CODE 1204
+#define THMC50_SYSCTL_ANALOG_OUT 1205
+
+#define DDCMON_SYSCTL_ID 1010
+#define DDCMON_SYSCTL_SIZE 1011
+#define DDCMON_SYSCTL_SYNC 1012
+#define DDCMON_SYSCTL_TIMINGS 1013
+#define DDCMON_SYSCTL_SERIAL 1014
+
+#define LM87_SYSCTL_IN0        1000 /* Volts * 100 */
+#define LM87_SYSCTL_IN1        1001
+#define LM87_SYSCTL_IN2        1002
+#define LM87_SYSCTL_IN3        1003
+#define LM87_SYSCTL_IN4        1004
+#define LM87_SYSCTL_IN5        1005
+#define LM87_SYSCTL_AIN1       1006
+#define LM87_SYSCTL_AIN2       1007
+#define LM87_SYSCTL_FAN1       1102
+#define LM87_SYSCTL_FAN2       1103
+#define LM87_SYSCTL_TEMP1  1250 /* Degrees Celcius * 100 */
+#define LM87_SYSCTL_TEMP2   1251 /* Degrees Celcius * 100 */
+#define LM87_SYSCTL_TEMP3   1252 /* Degrees Celcius * 100 */
+#define LM87_SYSCTL_FAN_DIV    2000 /* 1, 2, 4 or 8 */
+#define LM87_SYSCTL_ALARMS     2001 /* bitvector */
+#define LM87_SYSCTL_ANALOG_OUT 2002
+#define LM87_SYSCTL_VID        2003
+#define LM87_SYSCTL_VRM        2004
+
+#define LM87_ALARM_IN0          0x0001
+#define LM87_ALARM_IN1          0x0002
+#define LM87_ALARM_IN2          0x0004
+#define LM87_ALARM_IN3          0x0008
+#define LM87_ALARM_TEMP1        0x0010
+#define LM87_ALARM_TEMP2        0x0020
+#define LM87_ALARM_TEMP3        0x0020 /* same?? */
+#define LM87_ALARM_FAN1         0x0040
+#define LM87_ALARM_FAN2         0x0080
+#define LM87_ALARM_IN4          0x0100
+#define LM87_ALARM_IN5          0x0200
+#define LM87_ALARM_RESERVED1    0x0400
+#define LM87_ALARM_RESERVED2    0x0800
+#define LM87_ALARM_CHAS         0x1000
+#define LM87_ALARM_THERM_SIG    0x2000
+#define LM87_ALARM_TEMP2_FAULT  0x4000
+#define LM87_ALARM_TEMP3_FAULT 0x08000
+
+#define PCF8574_SYSCTL_READ     1000
+#define PCF8574_SYSCTL_WRITE    1001
+
+#define MTP008_SYSCTL_IN0	1000	/* Volts * 100 */
+#define MTP008_SYSCTL_IN1	1001
+#define MTP008_SYSCTL_IN2	1002
+#define MTP008_SYSCTL_IN3	1003
+#define MTP008_SYSCTL_IN4	1004
+#define MTP008_SYSCTL_IN5	1005
+#define MTP008_SYSCTL_IN6	1006
+#define MTP008_SYSCTL_FAN1	1101	/* Rotations/min */
+#define MTP008_SYSCTL_FAN2	1102
+#define MTP008_SYSCTL_FAN3	1103
+#define MTP008_SYSCTL_TEMP1	1200	/* Degrees Celcius * 10 */
+#define MTP008_SYSCTL_TEMP2	1201	/* Degrees Celcius * 10 */
+#define MTP008_SYSCTL_TEMP3	1202	/* Degrees Celcius * 10 */
+#define MTP008_SYSCTL_VID	1300	/* Volts * 100 */
+#define MTP008_SYSCTL_PWM1	1401
+#define MTP008_SYSCTL_PWM2	1402
+#define MTP008_SYSCTL_PWM3	1403
+#define MTP008_SYSCTL_SENS1	1501	/* 1, 2, or Beta (3000-5000) */
+#define MTP008_SYSCTL_SENS2	1502
+#define MTP008_SYSCTL_SENS3	1503
+#define MTP008_SYSCTL_FAN_DIV	2000	/* 1, 2, 4 or 8 */
+#define MTP008_SYSCTL_ALARMS	2001	/* bitvector */
+#define MTP008_SYSCTL_BEEP	2002	/* bitvector */
+
+#define MTP008_ALARM_IN0	0x0001
+#define MTP008_ALARM_IN1	0x0002
+#define MTP008_ALARM_IN2	0x0004
+#define MTP008_ALARM_IN3	0x0008
+#define MTP008_ALARM_IN4	0x0100
+#define MTP008_ALARM_IN5	0x0200
+#define MTP008_ALARM_IN6	0x0400
+#define MTP008_ALARM_FAN1	0x0040
+#define MTP008_ALARM_FAN2	0x0080
+#define MTP008_ALARM_FAN3	0x0800
+#define MTP008_ALARM_TEMP1	0x0010
+#define MTP008_ALARM_TEMP2	0x0100
+#define MTP008_ALARM_TEMP3	0x0200
+
+#define DS1621_SYSCTL_TEMP 1200	/* Degrees Celcius * 10 */
+#define DS1621_SYSCTL_ALARMS 2001	/* bitvector */
+#define DS1621_ALARM_TEMP_HIGH 0x40
+#define DS1621_ALARM_TEMP_LOW 0x20
+#define DS1621_SYSCTL_ENABLE 2002
+#define DS1621_SYSCTL_CONTINUOUS 2003
+#define DS1621_SYSCTL_POLARITY 2004
+
+#define IT87_SYSCTL_IN0 1000    /* Volts * 100 */
+#define IT87_SYSCTL_IN1 1001
+#define IT87_SYSCTL_IN2 1002
+#define IT87_SYSCTL_IN3 1003
+#define IT87_SYSCTL_IN4 1004
+#define IT87_SYSCTL_IN5 1005
+#define IT87_SYSCTL_IN6 1006
+#define IT87_SYSCTL_IN7 1007
+#define IT87_SYSCTL_IN8 1008
+#define IT87_SYSCTL_FAN1 1101   /* Rotations/min */
+#define IT87_SYSCTL_FAN2 1102
+#define IT87_SYSCTL_FAN3 1103
+#define IT87_SYSCTL_TEMP1 1200  /* Degrees Celcius * 10 */
+#define IT87_SYSCTL_TEMP2 1201  /* Degrees Celcius * 10 */
+#define IT87_SYSCTL_TEMP3 1202  /* Degrees Celcius * 10 */
+#define IT87_SYSCTL_VID 1300    /* Volts * 100 */
+#define IT87_SYSCTL_FAN_DIV 2000        /* 1, 2, 4 or 8 */
+#define IT87_SYSCTL_ALARMS 2004    /* bitvector */
+
+#define IT87_ALARM_IN0 0x000100
+#define IT87_ALARM_IN1 0x000200
+#define IT87_ALARM_IN2 0x000400
+#define IT87_ALARM_IN3 0x000800
+#define IT87_ALARM_IN4 0x001000
+#define IT87_ALARM_IN5 0x002000
+#define IT87_ALARM_IN6 0x004000
+#define IT87_ALARM_IN7 0x008000
+#define IT87_ALARM_FAN1 0x0001
+#define IT87_ALARM_FAN2 0x0002
+#define IT87_ALARM_FAN3 0x0004
+#define IT87_ALARM_TEMP1 0x00010000
+#define IT87_ALARM_TEMP2 0x00020000
+#define IT87_ALARM_TEMP3 0x00040000
+
+#define FSCPOS_SYSCTL_VOLT0    1000       /* 12 volt supply */
+#define FSCPOS_SYSCTL_VOLT1    1001       /* 5 volt supply */
+#define FSCPOS_SYSCTL_VOLT2    1002       /* batterie voltage*/
+#define FSCPOS_SYSCTL_FAN0     1101       /* state, min, ripple, actual value fan 0 */
+#define FSCPOS_SYSCTL_FAN1     1102       /* state, min, ripple, actual value fan 1 */
+#define FSCPOS_SYSCTL_FAN2     1103       /* state, min, ripple, actual value fan 2 */
+#define FSCPOS_SYSCTL_TEMP0    1201       /* state and value of sensor 0, cpu die */
+#define FSCPOS_SYSCTL_TEMP1    1202       /* state and value of sensor 1, motherboard */
+#define FSCPOS_SYSCTL_TEMP2    1203       /* state and value of sensor 2, chassis */
+#define FSCPOS_SYSCTL_REV     2000        /* Revision */
+#define FSCPOS_SYSCTL_EVENT   2001        /* global event status */
+#define FSCPOS_SYSCTL_CONTROL 2002        /* global control byte */
+#define FSCPOS_SYSCTL_WDOG     2003       /* state, min, ripple, actual value fan 2 */
+
+#define FSCSCY_SYSCTL_VOLT0    1000       /* 12 volt supply */
+#define FSCSCY_SYSCTL_VOLT1    1001       /* 5 volt supply */
+#define FSCSCY_SYSCTL_VOLT2    1002       /* batterie voltage*/
+#define FSCSCY_SYSCTL_FAN0     1101       /* state, min, ripple, actual value fan 0 */
+#define FSCSCY_SYSCTL_FAN1     1102       /* state, min, ripple, actual value fan 1 */
+#define FSCSCY_SYSCTL_FAN2     1103       /* state, min, ripple, actual value fan 2 */
+#define FSCSCY_SYSCTL_FAN3     1104       /* state, min, ripple, actual value fan 3 */
+#define FSCSCY_SYSCTL_FAN4     1105       /* state, min, ripple, actual value fan 4 */
+#define FSCSCY_SYSCTL_FAN5     1106       /* state, min, ripple, actual value fan 5 */
+#define FSCSCY_SYSCTL_TEMP0    1201       /* state and value of sensor 0, cpu die */
+#define FSCSCY_SYSCTL_TEMP1    1202       /* state and value of sensor 1, motherboard */
+#define FSCSCY_SYSCTL_TEMP2    1203       /* state and value of sensor 2, chassis */
+#define FSCSCY_SYSCTL_TEMP3    1204       /* state and value of sensor 3, chassis */
+#define FSCSCY_SYSCTL_REV     2000        /* Revision */
+#define FSCSCY_SYSCTL_EVENT   2001        /* global event status */
+#define FSCSCY_SYSCTL_CONTROL 2002        /* global control byte */
+#define FSCSCY_SYSCTL_WDOG     2003       /* state, min, ripple, actual value fan 2 */
+#define FSCSCY_SYSCTL_PCILOAD  2004       /* PCILoad value */
+#define FSCSCY_SYSCTL_INTRUSION 2005      /* state, control for intrusion sensor */
+
+#define PCF8591_SYSCTL_AIN_CONF 1000      /* Analog input configuration */
+#define PCF8591_SYSCTL_CH0 1001           /* Input channel 1 */
+#define PCF8591_SYSCTL_CH1 1002           /* Input channel 2 */
+#define PCF8591_SYSCTL_CH2 1003           /* Input channel 3 */
+#define PCF8591_SYSCTL_CH3 1004           /* Input channel 4 */
+#define PCF8591_SYSCTL_AOUT_ENABLE 1005   /* Analog output enable flag */
+#define PCF8591_SYSCTL_AOUT 1006          /* Analog output */
+
+#define ARP_SYSCTL1 1000
+#define ARP_SYSCTL2 1001
+#define ARP_SYSCTL3 1002
+#define ARP_SYSCTL4 1003
+#define ARP_SYSCTL5 1004
+#define ARP_SYSCTL6 1005
+#define ARP_SYSCTL7 1006
+#define ARP_SYSCTL8 1007
+
+#define SMSC47M1_SYSCTL_FAN1 1101   /* Rotations/min */
+#define SMSC47M1_SYSCTL_FAN2 1102
+#define SMSC47M1_SYSCTL_PWM1 1401
+#define SMSC47M1_SYSCTL_PWM2 1402
+#define SMSC47M1_SYSCTL_FAN_DIV 2000        /* 1, 2, 4 or 8 */
+#define SMSC47M1_SYSCTL_ALARMS 2004    /* bitvector */
+
+#define SMSC47M1_ALARM_FAN1 0x0001
+#define SMSC47M1_ALARM_FAN2 0x0002
+
+#define VT1211_SYSCTL_IN0 1000
+#define VT1211_SYSCTL_IN1 1001
+#define VT1211_SYSCTL_IN2 1002
+#define VT1211_SYSCTL_IN3 1003
+#define VT1211_SYSCTL_IN4 1004
+#define VT1211_SYSCTL_IN5 1005
+#define VT1211_SYSCTL_IN6 1006
+#define VT1211_SYSCTL_FAN1 1101
+#define VT1211_SYSCTL_FAN2 1102
+#define VT1211_SYSCTL_TEMP 1200
+#define VT1211_SYSCTL_TEMP2 1201
+#define VT1211_SYSCTL_TEMP3 1202
+#define VT1211_SYSCTL_TEMP4 1203
+#define VT1211_SYSCTL_TEMP5 1204
+#define VT1211_SYSCTL_TEMP6 1205
+#define VT1211_SYSCTL_TEMP7 1206
+#define VT1211_SYSCTL_VID	1300
+#define VT1211_SYSCTL_PWM1	1401
+#define VT1211_SYSCTL_PWM2	1402
+#define VT1211_SYSCTL_VRM	1600
+#define VT1211_SYSCTL_UCH	1700
+#define VT1211_SYSCTL_FAN_DIV 2000
+#define VT1211_SYSCTL_ALARMS 2001
+
+#define VT1211_ALARM_IN1 0x01
+#define VT1211_ALARM_IN2 0x02
+#define VT1211_ALARM_IN5 0x04
+#define VT1211_ALARM_IN3 0x08
+#define VT1211_ALARM_TEMP 0x10
+#define VT1211_ALARM_FAN1 0x40
+#define VT1211_ALARM_FAN2 0x80
+#define VT1211_ALARM_IN4 0x100
+#define VT1211_ALARM_IN6 0x200
+#define VT1211_ALARM_TEMP2 0x800
+#define VT1211_ALARM_CHAS 0x1000
+#define VT1211_ALARM_TEMP3 0x8000
+/* duplicates */
+#define VT1211_ALARM_IN0 VT1211_ALARM_TEMP
+#define VT1211_ALARM_TEMP4 VT1211_ALARM_IN1
+#define VT1211_ALARM_TEMP5 VT1211_ALARM_IN2
+#define VT1211_ALARM_TEMP6 VT1211_ALARM_IN3
+#define VT1211_ALARM_TEMP7 VT1211_ALARM_IN4
+
+#define LM92_SYSCTL_ALARMS		2001	/* high, low, critical */
+#define LM92_SYSCTL_TEMP		1200	/* high, low, critical, hysterisis, input */
+
+#define LM92_ALARM_TEMP_HIGH	0x01
+#define LM92_ALARM_TEMP_LOW		0x02
+#define LM92_ALARM_TEMP_CRIT	0x04
+#define LM92_TEMP_HIGH			0x08
+#define LM92_TEMP_LOW			0x10
+#define LM92_TEMP_CRIT			0x20
+#define LM92_TEMP_HYST			0x40
+#define LM92_TEMP_INPUT			0x80
+
+#define VT8231_SYSCTL_IN0 1000
+#define VT8231_SYSCTL_IN1 1001
+#define VT8231_SYSCTL_IN2 1002
+#define VT8231_SYSCTL_IN3 1003
+#define VT8231_SYSCTL_IN4 1004
+#define VT8231_SYSCTL_IN5 1005
+#define VT8231_SYSCTL_IN6 1006
+#define VT8231_SYSCTL_FAN1 1101
+#define VT8231_SYSCTL_FAN2 1102
+#define VT8231_SYSCTL_TEMP 1200
+#define VT8231_SYSCTL_TEMP2 1201
+#define VT8231_SYSCTL_TEMP3 1202
+#define VT8231_SYSCTL_TEMP4 1203
+#define VT8231_SYSCTL_TEMP5 1204
+#define VT8231_SYSCTL_TEMP6 1205
+#define VT8231_SYSCTL_TEMP7 1206
+#define VT8231_SYSCTL_VID	1300
+#define VT8231_SYSCTL_PWM1	1401
+#define VT8231_SYSCTL_PWM2	1402
+#define VT8231_SYSCTL_VRM	1600
+#define VT8231_SYSCTL_UCH	1700
+#define VT8231_SYSCTL_FAN_DIV 2000
+#define VT8231_SYSCTL_ALARMS 2001
+
+#define VT8231_ALARM_IN1 0x01
+#define VT8231_ALARM_IN2 0x02
+#define VT8231_ALARM_IN5 0x04
+#define VT8231_ALARM_IN3 0x08
+#define VT8231_ALARM_TEMP 0x10
+#define VT8231_ALARM_FAN1 0x40
+#define VT8231_ALARM_FAN2 0x80
+#define VT8231_ALARM_IN4 0x100
+#define VT8231_ALARM_IN6 0x200
+#define VT8231_ALARM_TEMP2 0x800
+#define VT8231_ALARM_CHAS 0x1000
+#define VT8231_ALARM_TEMP3 0x8000
+/* duplicates */
+#define VT8231_ALARM_IN0 VT8231_ALARM_TEMP
+#define VT8231_ALARM_TEMP4 VT8231_ALARM_IN1
+#define VT8231_ALARM_TEMP5 VT8231_ALARM_IN2
+#define VT8231_ALARM_TEMP6 VT8231_ALARM_IN3
+#define VT8231_ALARM_TEMP7 VT8231_ALARM_IN4
+
+#define SMARTBATT_SYSCTL_I 1001
+#define SMARTBATT_SYSCTL_V 1002
+#define SMARTBATT_SYSCTL_TEMP 1003
+#define SMARTBATT_SYSCTL_TIME 1004
+#define SMARTBATT_SYSCTL_ALARMS 1005
+#define SMARTBATT_SYSCTL_CHARGE 1006
+
+
+#endif				/* def SENSORS_SENSORS_H */

-- 
Worst form of spam? Adding advertisment signatures ala sourceforge.net.
What goes next? Inserting advertisment *into* email?
