Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261584AbTDKTVi (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 15:21:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbTDKTVh (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 15:21:37 -0400
Received: from mail-7.tiscali.it ([195.130.225.153]:18937 "EHLO
	mail-7.tiscali.it") by vger.kernel.org with ESMTP id S261609AbTDKTVS (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 15:21:18 -0400
Date: Fri, 11 Apr 2003 21:32:16 +0200
From: Kronos <kronos@kronoz.cjb.net>
To: Greg KH <greg@kroah.com>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] Add i2c-viapro.c
Message-ID: <20030411193216.GA9505@dreamland.darkstar.lan>
Reply-To: kronos@kronoz.cjb.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,
the following patch  (against 2.5.67) adds support for the  SMBus bus on
VIA  motherboard based  of 82C596,  82C686 and  823x. It is  needed, for
example, for the eeprom driver and for w83781d. I've tested it on a 8233
chipset.  Comments and feedback are welcome.


diff -urN -X dontdiff linux-2.5.vanilla/drivers/i2c/busses/Kconfig linux-2.5.i2c/drivers/i2c/busses/Kconfig
--- linux-2.5.vanilla/drivers/i2c/busses/Kconfig	Tue Apr  8 12:55:29 2003
+++ linux-2.5.i2c/drivers/i2c/busses/Kconfig	Thu Apr 10 20:46:39 2003
@@ -116,5 +116,31 @@
 	  in the lm_sensors package, which you can download at 
 	  http://www.lm-sensors.nu
 
+
+config I2C_VIAPRO
+	tristate "  VIA 82C596/82C686/823x"
+	depends on I2C && PCI && EXPERIMENTAL
+	help
+
+	  If you say yes to this option, support will be included for the VIA
+	  82C596/82C686/823x I2C interfaces.  Specifically, the following 
+	  chipsets are supported:
+	  82C596A/B
+	  82C686A/B
+	  8231
+	  8233
+	  8233A
+	  8235
+
+	  This can also be built as a module which can be inserted and removed
+	  while the kernel is running.  If you want to compile it as a module,
+	  say M here and read <file:Documentation/modules.txt>.
+
+	  The module will be called i2c-viapro.
+
+	  You will also need the latest user-space utilties: you can find them
+	  in the lm_sensors package, which you can download at
+	  http://www.lm-sensors.nu
+
 endmenu
 
diff -urN -X dontdiff linux-2.5.vanilla/drivers/i2c/busses/Makefile linux-2.5.i2c/drivers/i2c/busses/Makefile
--- linux-2.5.vanilla/drivers/i2c/busses/Makefile	Tue Mar 25 18:15:33 2003
+++ linux-2.5.i2c/drivers/i2c/busses/Makefile	Thu Apr 10 20:37:38 2003
@@ -8,3 +8,4 @@
 obj-$(CONFIG_I2C_I801)		+= i2c-i801.o
 obj-$(CONFIG_I2C_ISA)		+= i2c-isa.o
 obj-$(CONFIG_I2C_PIIX4)		+= i2c-piix4.o
+obj-$(CONFIG_I2C_VIAPRO)	+= i2c-viapro.o
diff -urN -X dontdiff linux-2.5.vanilla/drivers/i2c/busses/i2c-viapro.c linux-2.5.i2c/drivers/i2c/busses/i2c-viapro.c
--- linux-2.5.vanilla/drivers/i2c/busses/i2c-viapro.c	Thu Jan  1 01:00:00 1970
+++ linux-2.5.i2c/drivers/i2c/busses/i2c-viapro.c	Fri Apr 11 21:07:49 2003
@@ -0,0 +1,536 @@
+/*
+    i2c-viapro.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+    Copyright (c) 1998 - 2002  Frodo Looijaard <frodol@dds.nl>, 
+    Philip Edelbrock <phil@netroedge.com>, Kyösti Mälkki <kmalkki@cc.hut.fi>,
+    Mark D. Studebaker <mdsxyz123@yahoo.com>
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
+   Supports Via devices:
+	82C596A/B (0x3050)
+	82C596B (0x3051)
+	82C686A/B
+	8231
+	8233
+	8233A (0x3147 and 0x3177)
+	8235
+   Note: we assume there can only be one device, with one SMBus interface.
+*/
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
+#define SMBBA1	    0x90
+#define SMBBA2      0x80
+#define SMBBA3      0xD0
+
+struct sd {
+	const unsigned short dev;
+	const unsigned char base;
+	const unsigned char hstcfg;
+	const char *name;
+};
+
+static struct sd supported[] = {
+	{PCI_DEVICE_ID_VIA_82C596_3, SMBBA1, 0xD2, "VT82C596A/B"},
+	{PCI_DEVICE_ID_VIA_82C596B_3, SMBBA1, 0xD2, "VT82C596B"},
+	{PCI_DEVICE_ID_VIA_82C686_4, SMBBA1, 0xD2, "VT82C686A/B"},
+	{PCI_DEVICE_ID_VIA_8233_0, SMBBA3, 0xD2, "VT8233"},
+	{0x3147, SMBBA3, 0xD2, "VT8233A"},
+	{0x3177, SMBBA3, 0xD2, "VT8233A/8235"},
+	{0x8235, SMBBA1, 0xD2, "VT8231"},
+	{0, 0, 0, NULL}
+};
+
+static struct sd *num = supported;
+
+/* SMBus address offsets */
+#define SMBHSTSTS (0 + vt596_smba)
+#define SMBHSLVSTS (1 + vt596_smba)
+#define SMBHSTCNT (2 + vt596_smba)
+#define SMBHSTCMD (3 + vt596_smba)
+#define SMBHSTADD (4 + vt596_smba)
+#define SMBHSTDAT0 (5 + vt596_smba)
+#define SMBHSTDAT1 (6 + vt596_smba)
+#define SMBBLKDAT (7 + vt596_smba)
+#define SMBSLVCNT (8 + vt596_smba)
+#define SMBSHDWCMD (9 + vt596_smba)
+#define SMBSLVEVT (0xA + vt596_smba)
+#define SMBSLVDAT (0xC + vt596_smba)
+
+/* PCI Address Constants */
+
+/* SMBus data in configuration space can be found in two places,
+   We try to select the better one*/
+
+static unsigned short smb_cf_hstcfg;
+
+#define SMBHSTCFG   (smb_cf_hstcfg)
+#define SMBSLVC     (SMBHSTCFG+1)
+#define SMBSHDW1    (SMBHSTCFG+2)
+#define SMBSHDW2    (SMBHSTCFG+3)
+#define SMBREV      (SMBHSTCFG+4)
+
+/* Other settings */
+#define MAX_TIMEOUT 500
+#define  ENABLE_INT9 0
+
+/* VT82C596 constants */
+#define VT596_QUICK      0x00
+#define VT596_BYTE       0x04
+#define VT596_BYTE_DATA  0x08
+#define VT596_WORD_DATA  0x0C
+#define VT596_BLOCK_DATA 0x14
+
+/* insmod parameters */
+
+/* If force is set to anything different from 0, we forcibly enable the
+   VT596. DANGEROUS! */
+static int force = 0;
+MODULE_PARM(force, "i");
+MODULE_PARM_DESC(force, "Forcibly enable the SMBus. DANGEROUS!");
+
+/* If force_addr is set to anything different from 0, we forcibly enable
+   the VT596 at the given address. VERY DANGEROUS! */
+static int force_addr = 0;
+MODULE_PARM(force_addr, "i");
+MODULE_PARM_DESC(force_addr,
+		 "Forcibly enable the SMBus at the given address. "
+		 "EXTREMELY DANGEROUS!");
+
+
+
+
+
+static void vt596_do_pause(unsigned int amount);
+static int vt596_transaction(void);
+
+
+
+static unsigned short vt596_smba = 0;
+
+
+/* Detect whether a compatible device can be found, and initialize it. */
+int vt596_setup(void)
+{
+	unsigned char temp;
+
+	struct pci_dev *VT596_dev = NULL;
+
+	/* First check whether we can access PCI at all */
+	if (pci_present() == 0)
+		return(-ENODEV);
+
+	/* Look for a supported device/function */
+	do {
+		if((VT596_dev = pci_find_device(PCI_VENDOR_ID_VIA, num->dev,
+					        VT596_dev)))
+			break;
+	} while ((++num)->dev);
+
+	if (VT596_dev == NULL)
+		return(-ENODEV);
+	dev_info("Found Via %s device\n", num->name);
+
+	/* Determine the address of the SMBus areas */
+	smb_cf_hstcfg = num->hstcfg;
+	if (force_addr) {
+		vt596_smba = force_addr & 0xfff0;
+		force = 0;
+	} else {
+		if ((pci_read_config_word(VT596_dev, num->base, &vt596_smba))
+		    || !(vt596_smba & 0x1)) {
+			/* try 2nd address and config reg. for 596 */
+			if((num->dev == PCI_DEVICE_ID_VIA_82C596_3) &&
+			   (!pci_read_config_word(VT596_dev, SMBBA2, &vt596_smba)) &&
+			   (vt596_smba & 0x1)) {
+				smb_cf_hstcfg = 0x84;
+			} else {
+			        /* no matches at all */
+			        dev_err(&VT596_dev->dev, "Cannot configure "
+					"SMBus I/O Base address\n");
+			        return(-ENODEV);
+			}
+		}
+		vt596_smba &= 0xfff0;
+		if(vt596_smba == 0) {
+			dev_err(&VT596_dev->dev, "SMBus base address "
+				"uninitialized - upgrade BIOS or use "
+				"force_addr=0xaddr\n");
+			return -ENODEV;
+		}
+	}
+
+	if (!request_region(vt596_smba, 8, "viapro-smbus")) {
+		dev_err(&VT596_dev->dev, "SMBus region 0x%x already in use!\n",
+		        vt596_smba);
+		return(-ENODEV);
+	}
+
+	pci_read_config_byte(VT596_dev, SMBHSTCFG, &temp);
+	/* If force_addr is set, we program the new address here. Just to make
+	   sure, we disable the VT596 first. */
+	if (force_addr) {
+		pci_write_config_byte(VT596_dev, SMBHSTCFG, temp & 0xfe);
+		pci_write_config_word(VT596_dev, num->base, vt596_smba);
+		pci_write_config_byte(VT596_dev, SMBHSTCFG, temp | 0x01);
+		dev_warn(&VT596_dev->dev, "WARNING: SMBus interface set to new "
+		     "address 0x%04x!\n", vt596_smba);
+	} else if ((temp & 1) == 0) {
+		if (force) {
+			/* NOTE: This assumes I/O space and other allocations 
+			 * WERE done by the Bios!  Don't complain if your 
+			 * hardware does weird things after enabling this. 
+			 * :') Check for Bios updates before resorting to 
+			 * this.
+			 */
+			pci_write_config_byte(VT596_dev, SMBHSTCFG,
+					      temp | 1);
+			dev_info(&VT596_dev->dev, "Enabling SMBus device\n");
+		} else {
+			dev_err(&VT596_dev->dev, "SMBUS: Error: Host SMBus "
+				"controller not enabled! - upgrade BIOS or "
+				"use force=1\n");
+			return(-ENODEV);
+		}
+	}
+
+#ifdef DEBUG
+	if ((temp & 0x0E) == 8)
+		dev_info(&VT596_dev->dev, "using Interrupt 9 for SMBus.\n");
+	else if ((temp & 0x0E) == 0)
+		dev_info(&VT596_dev->dev, "using Interrupt SMI# for SMBus.\n");
+	else
+		dev_warn(&VT596_dev->dev, "Illegal Interrupt configuration "
+			"(or code out of date)!\n");
+
+	pci_read_config_byte(VT596_dev, SMBREV, &temp);
+	dev_info(&VT596_dev->dev, "SMBREV = 0x%X\n", temp);
+	dev_info(&VT596_dev->dev, "VT596_smba = 0x%X\n", vt596_smba);
+#endif	/* DEBUG */
+
+	return(0);
+}
+
+
+/* Internally used pause function */
+void vt596_do_pause(unsigned int amount)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+/* Another internally used function */
+int vt596_transaction(void)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+	dev_dbg(&VT596_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), 
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), 
+		inb_p(SMBHSTDAT1));
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+		dev_dbg(&VT596_dev->dev, "SMBus busy (0x%02x). "
+				"Resetting...\n", temp);
+		
+		outb_p(temp, SMBHSTSTS);
+		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+			dev_dbg(&VT596_dev->dev, "Failed! (0x%02x)\n", temp);
+			
+			return -1;
+		} else {
+			dev_dbg(&VT596_dev->dev, "Successfull!\n");
+		}
+	}
+
+	/* start the transaction by setting bit 6 */
+	outb_p(inb(SMBHSTCNT) | 0x040, SMBHSTCNT);
+
+	/* We will always wait for a fraction of a second! 
+	   I don't know if VIA needs this, Intel did  */
+	do {
+		vt596_do_pause(1);
+		temp = inb_p(SMBHSTSTS);
+	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+		result = -1;
+		dev_dbg(&VT596_dev->dev, "SMBus Timeout!\n");
+	}
+
+	if (temp & 0x10) {
+		result = -1;
+		dev_dbg(&VT596_dev->dev, "Error: Failed bus transaction\n");
+	}
+
+	if (temp & 0x08) {
+		result = -1;
+		dev_info(&VT596_dev->dev, "Bus collision! SMBus may be "
+			"locked until next hard\nreset. (sorry!)\n");
+		/* Clock stops and slave is stuck in mid-transmission */
+	}
+
+	if (temp & 0x04) {
+		result = -1;
+		dev_dbg(&VT596_dev->dev, "Error: no response!\n");
+	}
+
+	if (inb_p(SMBHSTSTS) != 0x00)
+		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
+
+	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+		dev_dbg(&VT596_dev->dev, "Failed reset at end of transaction "
+			"(%02x)\n", temp);
+	}
+	dev_dbg(&VT596_dev->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), 
+		inb_p(SMBHSTDAT1));
+	
+	return result;
+}
+
+/* Return -1 on error. */
+s32 vt596_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
+		 char read_write,
+		 u8 command, int size, union i2c_smbus_data * data)
+{
+	int i, len;
+
+	switch (size) {
+	case I2C_SMBUS_PROC_CALL:
+		dev_info(&VT596_dev->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
+		return -1;
+	case I2C_SMBUS_QUICK:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = VT596_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(command, SMBHSTCMD);
+		size = VT596_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(data->byte, SMBHSTDAT0);
+		size = VT596_BYTE_DATA;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			outb_p(data->word & 0xff, SMBHSTDAT0);
+			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1);
+		}
+		size = VT596_WORD_DATA;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			len = data->block[0];
+			if (len < 0)
+				len = 0;
+			if (len > 32)
+				len = 32;
+			outb_p(len, SMBHSTDAT0);
+			i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
+			for (i = 1; i <= len; i++)
+				outb_p(data->block[i], SMBBLKDAT);
+		}
+		size = VT596_BLOCK_DATA;
+		break;
+	}
+
+	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);
+
+	if (vt596_transaction())	/* Error in transaction */
+		return -1;
+
+	if ((read_write == I2C_SMBUS_WRITE) || (size == VT596_QUICK))
+		return 0;
+
+
+	switch (size) {
+	case VT596_BYTE:
+		/* Where is the result put? I assume here it is in
+		 * SMBHSTDAT0 but it might just as well be in the
+		 * SMBHSTCMD. No clue in the docs 
+		 */
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case VT596_BYTE_DATA:
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case VT596_WORD_DATA:
+		data->word = inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
+		break;
+	case VT596_BLOCK_DATA:
+		data->block[0] = inb_p(SMBHSTDAT0);
+		i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
+		for (i = 1; i <= data->block[0]; i++)
+			data->block[i] = inb_p(SMBBLKDAT);
+		break;
+	}
+	return 0;
+}
+
+
+u32 vt596_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+
+static struct i2c_algorithm smbus_algorithm = {
+	.name		= "Non-I2C SMBus adapter",
+	.id		= I2C_ALGO_SMBUS,
+	.smbus_xfer	= vt596_access,
+	.functionality	= vt596_func,
+};
+
+static struct i2c_adapter vt596_adapter = {
+	.owner		= THIS_MODULE,
+	.id		= I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
+	.algo		= &smbus_algorithm,
+	.dev		= {
+		.name	= "unset",
+	},
+};
+
+
+static struct pci_device_id vt596_ids[] __devinitdata = {
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_82C596_3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device		= PCI_DEVICE_ID_VIA_82C596B_3,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_82C686_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8233_0,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8233A,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8235,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{
+		.vendor		= PCI_VENDOR_ID_VIA,
+		.device 	= PCI_DEVICE_ID_VIA_8231_4,
+		.subvendor	= PCI_ANY_ID,
+		.subdevice	= PCI_ANY_ID,
+	},
+	{ 0, }
+};
+
+static int __devinit vt596_probe(struct pci_dev *dev, const struct pci_device_id *id)
+{
+	int retval;
+
+	retval = vt596_setup();
+	if (retval)
+		return retval;
+
+	vt596_adapter.dev.parent = &dev->dev;
+
+	snprintf(vt596_adapter.dev.name, DEVICE_NAME_SIZE,
+			"SMBus Via Pro adapter at %04x", vt596_smba);
+	
+	retval = i2c_add_adapter(&vt596_adapter);
+
+	return retval;
+}
+
+static void __devexit vt596_remove(struct pci_dev *dev)
+{
+	i2c_del_adapter(&vt596_adapter);
+}
+
+static struct pci_driver vt596_driver = {
+	.name		= "vt596 smbus",
+	.id_table	= vt596_ids,
+	.probe		= vt596_probe,
+	.remove		= __devexit_p(vt596_remove),
+};
+
+static int __init i2c_vt596_init(void)
+{
+	dev_info(&VT596_dev->dev, "version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	return pci_module_init(&vt596_driver);
+}
+
+
+static void __exit i2c_vt596_exit(void)
+{
+	pci_unregister_driver(&vt596_driver);
+	release_region(vt596_smba, 8);
+}
+
+
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_DESCRIPTION("vt82c596 SMBus driver");
+
+MODULE_LICENSE("GPL");
+
+module_init(i2c_vt596_init);
+module_exit(i2c_vt596_exit);


Luca
-- 
Reply-To: kronos@kronoz.cjb.net
Home: http://kronoz.cjb.net
Windows NT: Designed for the Internet. The Internet: Designed for Unix.
