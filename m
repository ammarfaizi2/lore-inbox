Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318516AbSGSOHa>; Fri, 19 Jul 2002 10:07:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318526AbSGSOH3>; Fri, 19 Jul 2002 10:07:29 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:58818 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318516AbSGSODr>; Fri, 19 Jul 2002 10:03:47 -0400
Message-ID: <3D381CF2.ED8490CA@bellsouth.net>
Date: Fri, 19 Jul 2002 10:06:42 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 4/9] 2.5.6 lm_sensors
Content-Type: multipart/mixed;
 boundary="------------A50607A6F44730B5BA5DA7B9"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------A50607A6F44730B5BA5DA7B9
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit

Hello Linus,
The i2c & lm_sensors group would like to submit these 9
patches from our stable 2.6.3 package.

This group of patches adds hardware sensor for boards and
chips.  They are considered stable and have been in use
since March 2002.

Over the next weeks we will be updating the kernel with our
beta release 2.6.4 and documentation patches.
Thanks,
Albert
-- 
Albert Cranford Deerfield Beach FL USA
ac9410@bellsouth.net
--------------A50607A6F44730B5BA5DA7B9
Content-Type: text/plain; charset=iso-8859-1;
 name="2.5.26-busses-c-patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="2.5.26-busses-c-patch"

--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-piix4.c	2002-05-20 01:54:37.000000000 -0400
@@ -0,0 +1,569 @@
+/*
+    piix4.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
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
+   Supports:
+	Intel PIIX4, 440MX
+	Serverworks OSB4, CSB5
+	SMSC Victory66
+
+   Note: we assume there can only be one device, with one SMBus interface.
+*/
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+/* Note: We assume all devices are identical
+         to the Intel PIIX4; we only mention it during detection.   */
+
+#ifndef PCI_DEVICE_ID_SERVERWORKS_OSB4
+#define PCI_DEVICE_ID_SERVERWORKS_OSB4 0x0200
+#endif
+
+#ifndef PCI_DEVICE_ID_SERVERWORKS_CSB5
+#define PCI_DEVICE_ID_SERVERWORKS_CSB5 0x0201
+#endif
+
+#ifndef PCI_VENDOR_ID_SERVERWORKS
+#define PCI_VENDOR_ID_SERVERWORKS 0x01166
+#endif
+
+#ifndef PCI_DEVICE_ID_INTEL_82443MX_3
+#define PCI_DEVICE_ID_INTEL_82443MX_3	0x719b
+#endif
+
+#ifndef PCI_VENDOR_ID_EFAR
+#define PCI_VENDOR_ID_EFAR		0x1055
+#endif
+
+#ifndef PCI_DEVICE_ID_EFAR_SLC90E66_3
+#define PCI_DEVICE_ID_EFAR_SLC90E66_3	0x9463
+#endif
+
+struct sd {
+	const unsigned short mfr;
+	const unsigned short dev;
+	const unsigned char fn;
+	const char *name;
+};
+
+static struct sd supported[] = {
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82371AB_3, 3, "PIIX4"},
+	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_OSB4, 0, "OSB4"},
+	{PCI_VENDOR_ID_SERVERWORKS, PCI_DEVICE_ID_SERVERWORKS_CSB5, 0, "CSB5"},
+	{PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82443MX_3, 3, "440MX"},
+	{PCI_VENDOR_ID_EFAR, PCI_DEVICE_ID_EFAR_SLC90E66_3, 0, "Victory66"},
+	{0, 0, 0, NULL}
+};
+
+/* PIIX4 SMBus address offsets */
+#define SMBHSTSTS (0 + piix4_smba)
+#define SMBHSLVSTS (1 + piix4_smba)
+#define SMBHSTCNT (2 + piix4_smba)
+#define SMBHSTCMD (3 + piix4_smba)
+#define SMBHSTADD (4 + piix4_smba)
+#define SMBHSTDAT0 (5 + piix4_smba)
+#define SMBHSTDAT1 (6 + piix4_smba)
+#define SMBBLKDAT (7 + piix4_smba)
+#define SMBSLVCNT (8 + piix4_smba)
+#define SMBSHDWCMD (9 + piix4_smba)
+#define SMBSLVEVT (0xA + piix4_smba)
+#define SMBSLVDAT (0xC + piix4_smba)
+
+/* PCI Address Constants */
+#define SMBBA     0x090
+#define SMBHSTCFG 0x0D2
+#define SMBSLVC   0x0D3
+#define SMBSHDW1  0x0D4
+#define SMBSHDW2  0x0D5
+#define SMBREV    0x0D6
+
+/* Other settings */
+#define MAX_TIMEOUT 500
+#define  ENABLE_INT9 0
+
+/* PIIX4 constants */
+#define PIIX4_QUICK      0x00
+#define PIIX4_BYTE       0x04
+#define PIIX4_BYTE_DATA  0x08
+#define PIIX4_WORD_DATA  0x0C
+#define PIIX4_BLOCK_DATA 0x14
+
+/* insmod parameters */
+
+/* If force is set to anything different from 0, we forcibly enable the
+   PIIX4. DANGEROUS! */
+static int force = 0;
+MODULE_PARM(force, "i");
+MODULE_PARM_DESC(force, "Forcibly enable the PIIX4. DANGEROUS!");
+
+/* If force_addr is set to anything different from 0, we forcibly enable
+   the PIIX4 at the given address. VERY DANGEROUS! */
+static int force_addr = 0;
+MODULE_PARM(force_addr, "i");
+MODULE_PARM_DESC(force_addr,
+		 "Forcibly enable the PIIX4 at the given address. "
+		 "EXTREMELY DANGEROUS!");
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_piix4_init(void);
+static int __init piix4_cleanup(void);
+static int piix4_setup(void);
+static s32 piix4_access(struct i2c_adapter *adap, u16 addr,
+			unsigned short flags, char read_write,
+			u8 command, int size, union i2c_smbus_data *data);
+static void piix4_do_pause(unsigned int amount);
+static int piix4_transaction(void);
+static void piix4_inc(struct i2c_adapter *adapter);
+static void piix4_dec(struct i2c_adapter *adapter);
+static u32 piix4_func(struct i2c_adapter *adapter);
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+static struct i2c_algorithm smbus_algorithm = {
+	/* name */ "Non-I2C SMBus adapter",
+	/* id */ I2C_ALGO_SMBUS,
+	/* master_xfer */ NULL,
+	/* smbus_access */ piix4_access,
+	/* slave_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ piix4_func,
+};
+
+static struct i2c_adapter piix4_adapter = {
+	"unset",
+	I2C_ALGO_SMBUS | I2C_HW_SMBUS_PIIX4,
+	&smbus_algorithm,
+	NULL,
+	piix4_inc,
+	piix4_dec,
+	NULL,
+	NULL,
+};
+
+static int __initdata piix4_initialized;
+static unsigned short piix4_smba = 0;
+
+/* Detect whether a PIIX4 can be found, and initialize it, where necessary.
+   Note the differences between kernels with the old PCI BIOS interface and
+   newer kernels with the real PCI interface. In compat.h some things are
+   defined to make the transition easier. */
+int piix4_setup(void)
+{
+	int error_return = 0;
+	unsigned char temp;
+	struct sd *num = supported;
+	struct pci_dev *PIIX4_dev = NULL;
+
+	if (pci_present() == 0) {
+		error_return = -ENODEV;
+		goto END;
+	}
+
+	/* Look for a supported device/function */
+	do {
+		if((PIIX4_dev = pci_find_device(num->mfr, num->dev,
+					        PIIX4_dev))) {
+			if(PCI_FUNC(PIIX4_dev->devfn) != num->fn)
+				continue;
+			break;
+		}
+		PIIX4_dev = NULL;
+		num++;
+	} while (num->mfr);
+
+	if (PIIX4_dev == NULL) {
+		printk
+		  (KERN_ERR "i2c-piix4.o: Error: Can't detect PIIX4 or compatible device!\n");
+		 error_return = -ENODEV;
+		 goto END;
+	}
+	printk(KERN_INFO "i2c-piix4.o: Found %s device\n", num->name);
+
+
+/* Determine the address of the SMBus areas */
+	if (force_addr) {
+		piix4_smba = force_addr & 0xfff0;
+		force = 0;
+	} else {
+		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
+		piix4_smba &= 0xfff0;
+		if(piix4_smba == 0) {
+			printk(KERN_ERR "i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+			return -ENODEV;
+		}
+	}
+
+	if (check_region(piix4_smba, 8)) {
+		printk
+		    (KERN_ERR "i2c-piix4.o: SMB region 0x%x already in use!\n",
+		     piix4_smba);
+		error_return = -ENODEV;
+		goto END;
+	}
+
+	pci_read_config_byte(PIIX4_dev, SMBHSTCFG, &temp);
+/* If force_addr is set, we program the new address here. Just to make
+   sure, we disable the PIIX4 first. */
+	if (force_addr) {
+		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp & 0xfe);
+		pci_write_config_word(PIIX4_dev, SMBBA, piix4_smba);
+		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp | 0x01);
+		printk
+		    (KERN_INFO "i2c-piix4.o: WARNING: SMBus interface set to new "
+		     "address %04x!\n", piix4_smba);
+	} else if ((temp & 1) == 0) {
+		if (force) {
+/* This should never need to be done, but has been noted that
+   many Dell machines have the SMBus interface on the PIIX4
+   disabled!? NOTE: This assumes I/O space and other allocations WERE
+   done by the Bios!  Don't complain if your hardware does weird 
+   things after enabling this. :') Check for Bios updates before
+   resorting to this.  */
+			pci_write_config_byte(PIIX4_dev, SMBHSTCFG,
+					      temp | 1);
+			printk
+			    (KERN_NOTICE "i2c-piix4.o: WARNING: SMBus interface has been FORCEFULLY "
+			     "ENABLED!\n");
+		} else {
+			printk
+			    (KERN_ERR "i2c-piix4.o: Host SMBus controller not enabled!\n");
+			error_return = -ENODEV;
+			goto END;
+		}
+	}
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(piix4_smba, 8, "piix4-smbus");
+
+#ifdef DEBUG
+	if ((temp & 0x0E) == 8)
+		printk
+		    (KERN_DEBUG "i2c-piix4.o: Using Interrupt 9 for SMBus.\n");
+	else if ((temp & 0x0E) == 0)
+		printk
+		    (KERN_DEBUG "i2c-piix4.o: Using Interrupt SMI# for SMBus.\n");
+	else
+		printk
+		    (KERN_ERR "i2c-piix4.o: Illegal Interrupt configuration (or code out "
+		     "of date)!\n");
+
+	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
+	printk(KERN_DEBUG "i2c-piix4.o: SMBREV = 0x%X\n", temp);
+	printk(KERN_DEBUG "i2c-piix4.o: SMBA = 0x%X\n", piix4_smba);
+#endif				/* DEBUG */
+
+      END:
+	return error_return;
+}
+
+
+/* Internally used pause function */
+void piix4_do_pause(unsigned int amount)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+/* Another internally used function */
+int piix4_transaction(void)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+#ifdef DEBUG
+	printk
+	    (KERN_DEBUG "i2c-piix4.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
+	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
+	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
+#endif
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+#ifdef DEBUG
+		printk(KERN_DEBUG "i2c-piix4.o: SMBus busy (%02x). Resetting... \n",
+		       temp);
+#endif
+		outb_p(temp, SMBHSTSTS);
+		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+#ifdef DEBUG
+			printk(KERN_ERR "i2c-piix4.o: Failed! (%02x)\n", temp);
+#endif
+			return -1;
+		} else {
+#ifdef DEBUG
+			printk(KERN_DEBUG "i2c-piix4.o: Successfull!\n");
+#endif
+		}
+	}
+
+	/* start the transaction by setting bit 6 */
+	outb_p(inb(SMBHSTCNT) | 0x040, SMBHSTCNT);
+
+	/* We will always wait for a fraction of a second! (See PIIX4 docs errata) */
+	do {
+		piix4_do_pause(1);
+		temp = inb_p(SMBHSTSTS);
+	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
+
+#ifdef DEBUG
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+		printk(KERN_ERR "i2c-piix4.o: SMBus Timeout!\n");
+		result = -1;
+	}
+#endif
+
+	if (temp & 0x10) {
+		result = -1;
+#ifdef DEBUG
+		printk(KERN_ERR "i2c-piix4.o: Error: Failed bus transaction\n");
+#endif
+	}
+
+	if (temp & 0x08) {
+		result = -1;
+		printk
+		    (KERN_ERR "i2c-piix4.o: Bus collision! SMBus may be locked until next hard\n"
+		     "reset. (sorry!)\n");
+		/* Clock stops and slave is stuck in mid-transmission */
+	}
+
+	if (temp & 0x04) {
+		result = -1;
+#ifdef DEBUG
+		printk(KERN_ERR "i2c-piix4.o: Error: no response!\n");
+#endif
+	}
+
+	if (inb_p(SMBHSTSTS) != 0x00)
+		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
+
+#ifdef DEBUG
+	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+		printk
+		    (KERN_ERR "i2c-piix4.o: Failed reset at end of transaction (%02x)\n",
+		     temp);
+	}
+	printk
+	    (KERN_DEBUG "i2c-piix4.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
+	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
+	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
+#endif
+	return result;
+}
+
+/* Return -1 on error. See smbus.h for more information */
+s32 piix4_access(struct i2c_adapter * adap, u16 addr,
+		 unsigned short flags, char read_write,
+		 u8 command, int size, union i2c_smbus_data * data)
+{
+	int i, len;
+
+	switch (size) {
+	case I2C_SMBUS_PROC_CALL:
+		printk
+		    (KERN_ERR "i2c-piix4.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		return -1;
+	case I2C_SMBUS_QUICK:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = PIIX4_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(command, SMBHSTCMD);
+		size = PIIX4_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(data->byte, SMBHSTDAT0);
+		size = PIIX4_BYTE_DATA;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			outb_p(data->word & 0xff, SMBHSTDAT0);
+			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1);
+		}
+		size = PIIX4_WORD_DATA;
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
+		size = PIIX4_BLOCK_DATA;
+		break;
+	}
+
+	outb_p((size & 0x1C) + (ENABLE_INT9 & 1), SMBHSTCNT);
+
+	if (piix4_transaction())	/* Error in transaction */
+		return -1;
+
+	if ((read_write == I2C_SMBUS_WRITE) || (size == PIIX4_QUICK))
+		return 0;
+
+
+	switch (size) {
+	case PIIX4_BYTE:	/* Where is the result put? I assume here it is in
+				   SMBHSTDAT0 but it might just as well be in the
+				   SMBHSTCMD. No clue in the docs */
+
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case PIIX4_BYTE_DATA:
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case PIIX4_WORD_DATA:
+		data->word = inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
+		break;
+	case PIIX4_BLOCK_DATA:
+		data->block[0] = inb_p(SMBHSTDAT0);
+		i = inb_p(SMBHSTCNT);	/* Reset SMBBLKDAT */
+		for (i = 1; i <= data->block[0]; i++)
+			data->block[i] = inb_p(SMBBLKDAT);
+		break;
+	}
+	return 0;
+}
+
+void piix4_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void piix4_dec(struct i2c_adapter *adapter)
+{
+
+	MOD_DEC_USE_COUNT;
+}
+
+u32 piix4_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+int __init i2c_piix4_init(void)
+{
+	int res;
+	printk("i2c-piix4.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	if (piix4_initialized) {
+		printk
+		    (KERN_ERR "i2c-piix4.o: Oops, piix4_init called a second time!\n");
+		return -EBUSY;
+	}
+	piix4_initialized = 0;
+	if ((res = piix4_setup())) {
+		printk
+		    (KERN_ERR "i2c-piix4.o: Device not detected, module not inserted.\n");
+		piix4_cleanup();
+		return res;
+	}
+	piix4_initialized++;
+	sprintf(piix4_adapter.name, "SMBus PIIX4 adapter at %04x",
+		piix4_smba);
+	if ((res = i2c_add_adapter(&piix4_adapter))) {
+		printk
+		    (KERN_ERR "i2c-piix4.o: Adapter registration failed, module not inserted.\n");
+		piix4_cleanup();
+		return res;
+	}
+	piix4_initialized++;
+	printk(KERN_ERR "i2c-piix4.o: SMBus detected and initialized\n");
+	return 0;
+}
+
+int __init piix4_cleanup(void)
+{
+	int res;
+	if (piix4_initialized >= 2) {
+		if ((res = i2c_del_adapter(&piix4_adapter))) {
+			printk
+			    (KERN_ERR "i2c-piix4.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		} else
+			piix4_initialized--;
+	}
+	if (piix4_initialized >= 1) {
+		release_region(piix4_smba, 8);
+		piix4_initialized--;
+	}
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_DESCRIPTION("PIIX4 SMBus driver");
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+	return i2c_piix4_init();
+}
+
+int cleanup_module(void)
+{
+	return piix4_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-sis5595.c	2002-05-20 01:54:54.000000000 -0400
@@ -0,0 +1,548 @@
+/*
+    sis5595.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
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
+/* Note: we assume there can only be one SIS5595 with one SMBus interface */
+
+/*
+   Note: all have mfr. ID 0x1039.
+   SUPPORTED		PCI ID		
+	5595		0008
+
+   Note: these chips contain a 0008 device which is incompatible with the
+         5595. We recognize these by the presence of the listed
+         "blacklist" PCI ID and refuse to load.
+
+   NOT SUPPORTED	PCI ID		BLACKLIST PCI ID	
+	 540		0008		0540
+	 550		0008		0550
+	5513		0008		5511
+	5581		0008		5597
+	5582		0008		5597
+	5597		0008		5597
+	5598		0008		5597/5598
+	 630		0008		0630
+	 645		0008		0645
+	 730		0008		0730
+	 735		0008		0735
+*/
+
+/* TO DO: 
+ * Add Block Transfers (ugly, but supported by the adapter)
+ * Add adapter resets
+ */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+MODULE_LICENSE("GPL");
+
+#ifndef PCI_DEVICE_ID_SI_540
+#define PCI_DEVICE_ID_SI_540		0x0540
+#endif
+#ifndef PCI_DEVICE_ID_SI_550
+#define PCI_DEVICE_ID_SI_550		0x0550
+#endif
+#ifndef PCI_DEVICE_ID_SI_630
+#define PCI_DEVICE_ID_SI_630		0x0630
+#endif
+#ifndef PCI_DEVICE_ID_SI_730
+#define PCI_DEVICE_ID_SI_730		0x0730
+#endif
+#ifndef PCI_DEVICE_ID_SI_5598
+#define PCI_DEVICE_ID_SI_5598		0x5598
+#endif
+
+static int blacklist[] = {
+			PCI_DEVICE_ID_SI_540,
+			PCI_DEVICE_ID_SI_550,
+			PCI_DEVICE_ID_SI_630,
+			PCI_DEVICE_ID_SI_730,
+			PCI_DEVICE_ID_SI_5511, /* 5513 chip has the 0008 device but
+						  that ID shows up in other chips so we
+						  use the 5511 ID for recognition */
+			PCI_DEVICE_ID_SI_5597,
+			PCI_DEVICE_ID_SI_5598,
+			0x645,
+			0x735,
+                          0 };
+
+/* Length of ISA address segment */
+#define SIS5595_EXTENT 8
+/* SIS5595 SMBus registers */
+#define SMB_STS_LO 0x00
+#define SMB_STS_HI 0x01
+#define SMB_CTL_LO 0x02
+#define SMB_CTL_HI 0x03
+#define SMB_ADDR   0x04
+#define SMB_CMD    0x05
+#define SMB_PCNT   0x06
+#define SMB_CNT    0x07
+#define SMB_BYTE   0x08
+#define SMB_DEV    0x10
+#define SMB_DB0    0x11
+#define SMB_DB1    0x12
+#define SMB_HAA    0x13
+
+/* PCI Address Constants */
+#define SMB_INDEX  0x38
+#define SMB_DAT    0x39
+#define SIS5595_ENABLE_REG 0x40
+#define ACPI_BASE  0x90
+
+/* Other settings */
+#define MAX_TIMEOUT 500
+
+/* SIS5595 constants */
+#define SIS5595_QUICK      0x00
+#define SIS5595_BYTE       0x02
+#define SIS5595_BYTE_DATA  0x04
+#define SIS5595_WORD_DATA  0x06
+#define SIS5595_PROC_CALL  0x08
+#define SIS5595_BLOCK_DATA 0x0A
+
+/* insmod parameters */
+
+/* If force_addr is set to anything different from 0, we forcibly enable
+   the device at the given address. */
+static int force_addr = 0;
+MODULE_PARM(force_addr, "i");
+MODULE_PARM_DESC(force_addr,
+		 "Initialize the base address of the i2c controller");
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_sis5595_init(void);
+static int __init sis5595_cleanup(void);
+static int sis5595_setup(void);
+static s32 sis5595_access(struct i2c_adapter *adap, u16 addr,
+			  unsigned short flags, char read_write,
+			  u8 command, int size,
+			  union i2c_smbus_data *data);
+static void sis5595_do_pause(unsigned int amount);
+static int sis5595_transaction(void);
+static void sis5595_inc(struct i2c_adapter *adapter);
+static void sis5595_dec(struct i2c_adapter *adapter);
+static u32 sis5595_func(struct i2c_adapter *adapter);
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+static struct i2c_algorithm smbus_algorithm = {
+	/* name */ "Non-I2C SMBus adapter",
+	/* id */ I2C_ALGO_SMBUS,
+	/* master_xfer */ NULL,
+	/* smbus_access */ sis5595_access,
+	/* slave_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ sis5595_func,
+};
+
+static struct i2c_adapter sis5595_adapter = {
+	"unset",
+	I2C_ALGO_SMBUS | I2C_HW_SMBUS_SIS5595,
+	&smbus_algorithm,
+	NULL,
+	sis5595_inc,
+	sis5595_dec,
+	NULL,
+	NULL,
+};
+
+static int __initdata sis5595_initialized;
+static unsigned short sis5595_base = 0;
+
+static u8 sis5595_read(u8 reg)
+{
+	outb(reg, sis5595_base + SMB_INDEX);
+	return inb(sis5595_base + SMB_DAT);
+}
+
+static void sis5595_write(u8 reg, u8 data)
+{
+	outb(reg, sis5595_base + SMB_INDEX);
+	outb(data, sis5595_base + SMB_DAT);
+}
+
+
+/* Detect whether a SIS5595 can be found, and initialize it, where necessary.
+   Note the differences between kernels with the old PCI BIOS interface and
+   newer kernels with the real PCI interface. In compat.h some things are
+   defined to make the transition easier. */
+int sis5595_setup(void)
+{
+	u16 a;
+	u8 val;
+	struct pci_dev *SIS5595_dev;
+	int *i;
+
+	/* First check whether we can access PCI at all */
+	if (pci_present() == 0) {
+		printk("i2c-sis5595.o: Error: No PCI-bus found!\n");
+		return -ENODEV;
+	}
+
+	/* Look for the SIS5595 */
+	SIS5595_dev = NULL;
+	if (!(SIS5595_dev = pci_find_device(PCI_VENDOR_ID_SI,
+					    PCI_DEVICE_ID_SI_503,
+					    SIS5595_dev))) {
+		printk("i2c-sis5595.o: Error: Can't detect SIS5595!\n");
+		return -ENODEV;
+	}
+
+	/* Look for imposters */
+	for(i = blacklist; *i != 0; i++) {
+		if (pci_find_device(PCI_VENDOR_ID_SI, *i, NULL)) {
+			printk("i2c-sis5595.o: Error: Looked for SIS5595 but found unsupported device %.4X\n", *i);
+			return -ENODEV;
+		}
+	}
+
+/* Determine the address of the SMBus areas */
+	pci_read_config_word(SIS5595_dev, ACPI_BASE, &sis5595_base);
+	if(sis5595_base == 0 && force_addr == 0) {
+		printk("i2c-sis5595.o: ACPI base address uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+		return -ENODEV;
+	}
+
+	if(force_addr)
+		sis5595_base = force_addr & ~(SIS5595_EXTENT - 1);
+#ifdef DEBUG
+	printk("ACPI Base address: %04x\n", sis5595_base);
+#endif
+	/* NB: We grab just the two SMBus registers here, but this may still
+	 * interfere with ACPI :-(  */
+	if (check_region(sis5595_base + SMB_INDEX, 2)) {
+		printk
+		    ("i2c-sis5595.o: SMBus registers 0x%04x-0x%04x already in use!\n",
+		     sis5595_base + SMB_INDEX,
+		     sis5595_base + SMB_INDEX + 1);
+		return -ENODEV;
+	}
+
+	if(force_addr) {
+		printk("i2c-sis5595.o: forcing ISA address 0x%04X\n", sis5595_base);
+		if (PCIBIOS_SUCCESSFUL !=
+		    pci_write_config_word(SIS5595_dev, ACPI_BASE, sis5595_base))
+			return -ENODEV;
+		if (PCIBIOS_SUCCESSFUL !=
+		    pci_read_config_word(SIS5595_dev, ACPI_BASE, &a))
+			return -ENODEV;
+		if ((a & ~(SIS5595_EXTENT - 1)) != sis5595_base) {
+			/* doesn't work for some chips! */
+			printk("i2c-sis5595.o: force address failed - not supported?\n");
+			return -ENODEV;
+		}
+	}
+
+	if (PCIBIOS_SUCCESSFUL !=
+	    pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val))
+		return -ENODEV;
+	if((val & 0x80) == 0) {
+		printk("sis5595.o: enabling ACPI\n");
+		if (PCIBIOS_SUCCESSFUL !=
+		    pci_write_config_byte(SIS5595_dev, SIS5595_ENABLE_REG,
+		                      val | 0x80))
+			return -ENODEV;
+		if (PCIBIOS_SUCCESSFUL !=
+		    pci_read_config_byte(SIS5595_dev, SIS5595_ENABLE_REG, &val))
+			return -ENODEV;
+		if((val & 0x80) == 0) {	/* doesn't work for some chips? */
+			printk("sis5595.o: ACPI enable failed - not supported?\n");
+			return -ENODEV;
+		}
+	}
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(sis5595_base + SMB_INDEX, 2, "sis5595-smbus");
+	return(0);
+}
+
+
+/* Internally used pause function */
+void sis5595_do_pause(unsigned int amount)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+/* Another internally used function */
+int sis5595_transaction(void)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	if (
+	    (temp =
+	     sis5595_read(SMB_STS_LO) + (sis5595_read(SMB_STS_HI) << 8)) !=
+	    0x00) {
+#ifdef DEBUG
+		printk("i2c-sis5595.o: SMBus busy (%04x). Resetting... \n",
+		       temp);
+#endif
+		sis5595_write(SMB_STS_LO, temp & 0xff);
+		sis5595_write(SMB_STS_HI, temp >> 8);
+		if (
+		    (temp =
+		     sis5595_read(SMB_STS_LO) +
+		     (sis5595_read(SMB_STS_HI) << 8)) != 0x00) {
+#ifdef DEBUG
+			printk("i2c-sis5595.o: Failed! (%02x)\n", temp);
+#endif
+			return -1;
+		} else {
+#ifdef DEBUG
+			printk("i2c-sis5595.o: Successfull!\n");
+#endif
+		}
+	}
+
+	/* start the transaction by setting bit 4 */
+	sis5595_write(SMB_CTL_LO, sis5595_read(SMB_CTL_LO) | 0x10);
+
+	/* We will always wait for a fraction of a second! */
+	do {
+		sis5595_do_pause(1);
+		temp = sis5595_read(SMB_STS_LO);
+	} while (!(temp & 0x40) && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+#ifdef DEBUG
+		printk("i2c-sis5595.o: SMBus Timeout!\n");
+#endif
+		result = -1;
+	}
+
+	if (temp & 0x10) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-sis5595.o: Error: Failed bus transaction\n");
+#endif
+	}
+
+	if (temp & 0x20) {
+		result = -1;
+		printk
+		    ("i2c-sis5595.o: Bus collision! SMBus may be locked until next hard\n"
+		     "reset (or not...)\n");
+		/* Clock stops and slave is stuck in mid-transmission */
+	}
+
+	if (
+	    (temp =
+	     sis5595_read(SMB_STS_LO) + (sis5595_read(SMB_STS_HI) << 8)) !=
+	    0x00) {
+		sis5595_write(SMB_STS_LO, temp & 0xff);
+		sis5595_write(SMB_STS_HI, temp >> 8);
+	}
+
+	if (
+	    (temp =
+	     sis5595_read(SMB_STS_LO) + (sis5595_read(SMB_STS_HI) << 8)) !=
+	    0x00) {
+
+#ifdef DEBUG
+		printk
+		    ("i2c-sis5595.o: Failed reset at end of transaction (%02x)\n",
+		     temp);
+#endif
+	}
+	return result;
+}
+
+/* Return -1 on error. See smbus.h for more information */
+s32 sis5595_access(struct i2c_adapter * adap, u16 addr,
+		   unsigned short flags, char read_write,
+		   u8 command, int size, union i2c_smbus_data * data)
+{
+	switch (size) {
+	case I2C_SMBUS_QUICK:
+		sis5595_write(SMB_ADDR,
+			      ((addr & 0x7f) << 1) | (read_write & 0x01));
+		size = SIS5595_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		sis5595_write(SMB_ADDR,
+			      ((addr & 0x7f) << 1) | (read_write & 0x01));
+		if (read_write == I2C_SMBUS_WRITE)
+			sis5595_write(SMB_CMD, command);
+		size = SIS5595_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		sis5595_write(SMB_ADDR,
+			      ((addr & 0x7f) << 1) | (read_write & 0x01));
+		sis5595_write(SMB_CMD, command);
+		if (read_write == I2C_SMBUS_WRITE)
+			sis5595_write(SMB_BYTE, data->byte);
+		size = SIS5595_BYTE_DATA;
+		break;
+	case I2C_SMBUS_PROC_CALL:
+	case I2C_SMBUS_WORD_DATA:
+		sis5595_write(SMB_ADDR,
+			      ((addr & 0x7f) << 1) | (read_write & 0x01));
+		sis5595_write(SMB_CMD, command);
+		if (read_write == I2C_SMBUS_WRITE) {
+			sis5595_write(SMB_BYTE, data->word & 0xff);
+			sis5595_write(SMB_BYTE + 1,
+				      (data->word & 0xff00) >> 8);
+		}
+		size =
+		    (size ==
+		     I2C_SMBUS_PROC_CALL) ? SIS5595_PROC_CALL :
+		    SIS5595_WORD_DATA;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		printk("sis5595.o: Block data not yet implemented!\n");
+		return -1;
+		break;
+	}
+
+	sis5595_write(SMB_CTL_LO, ((size & 0x0E)));
+
+	if (sis5595_transaction())	/* Error in transaction */
+		return -1;
+
+	if ((size != SIS5595_PROC_CALL) &&
+	    ((read_write == I2C_SMBUS_WRITE) || (size == SIS5595_QUICK)))
+		return 0;
+
+
+	switch (size) {
+	case SIS5595_BYTE:	/* Where is the result put? I assume here it is in
+				   SMB_DATA but it might just as well be in the
+				   SMB_CMD. No clue in the docs */
+	case SIS5595_BYTE_DATA:
+		data->byte = sis5595_read(SMB_BYTE);
+		break;
+	case SIS5595_WORD_DATA:
+	case SIS5595_PROC_CALL:
+		data->word =
+		    sis5595_read(SMB_BYTE) +
+		    (sis5595_read(SMB_BYTE + 1) << 8);
+		break;
+	}
+	return 0;
+}
+
+void sis5595_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void sis5595_dec(struct i2c_adapter *adapter)
+{
+
+	MOD_DEC_USE_COUNT;
+}
+
+u32 sis5595_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_PROC_CALL;
+}
+
+int __init i2c_sis5595_init(void)
+{
+	int res;
+	printk("i2c-sis5595.o version %s (%s)\n", LM_VERSION, LM_DATE);
+#ifdef DEBUG
+/* PE- It might be good to make this a permanent part of the code! */
+	if (sis5595_initialized) {
+		printk
+		    ("i2c-sis5595.o: Oops, sis5595_init called a second time!\n");
+		return -EBUSY;
+	}
+#endif
+	sis5595_initialized = 0;
+	if ((res = sis5595_setup())) {
+		printk
+		    ("i2c-sis5595.o: SIS5595 not detected, module not inserted.\n");
+		sis5595_cleanup();
+		return res;
+	}
+	sis5595_initialized++;
+	sprintf(sis5595_adapter.name, "SMBus SIS5595 adapter at %04x",
+		sis5595_base + SMB_INDEX);
+	if ((res = i2c_add_adapter(&sis5595_adapter))) {
+		printk
+		    ("i2c-sis5595.o: Adapter registration failed, module not inserted.\n");
+		sis5595_cleanup();
+		return res;
+	}
+	sis5595_initialized++;
+	printk("i2c-sis5595.o: SIS5595 bus detected and initialized\n");
+	return 0;
+}
+
+int __init sis5595_cleanup(void)
+{
+	int res;
+	if (sis5595_initialized >= 2) {
+		if ((res = i2c_del_adapter(&sis5595_adapter))) {
+			printk
+			    ("i2c-sis5595.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		} else
+			sis5595_initialized--;
+	}
+	if (sis5595_initialized >= 1) {
+		release_region(sis5595_base + SMB_INDEX, 2);
+		sis5595_initialized--;
+	}
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("SIS5595 SMBus driver");
+
+int init_module(void)
+{
+	return i2c_sis5595_init();
+}
+
+int cleanup_module(void)
+{
+	return sis5595_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-tsunami.c	2002-05-20 01:55:11.000000000 -0400
@@ -0,0 +1,198 @@
+/*
+    i2c-tsunami.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+    Copyright (c) 2001  Oleg Vdovikin <vdovikin@jscc.ru>
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
+/* This interfaces to the I2C bus of the Tsunami/Typhoon 21272 chipsets 
+   to gain access to the on-board I2C devices. 
+
+   For more information refer to Compaq's 
+	"Tsunami/Typhoon 21272 Chipset Hardware Reference Manual"
+	Order Number: DS-0025-TE
+*/ 
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <asm/io.h>
+#include <asm/hwrpb.h>
+#include <asm/core_tsunami.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+MODULE_LICENSE("GPL");
+
+/* Memory Presence Detect Register (MPD-RW) bits 
+   with except of reserved RAZ bits */
+
+#define MPD_DR	0x8	/* Data receive - RO */
+#define MPD_CKR	0x4	/* Clock receive - RO */
+#define MPD_DS	0x2	/* Data send - Must be a 1 to receive - WO */
+#define MPD_CKS	0x1	/* Clock send - WO */
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_tsunami_init(void);
+static int __init i2c_tsunami_cleanup(void);
+static void i2c_tsunami_inc(struct i2c_adapter *adapter);
+static void i2c_tsunami_dec(struct i2c_adapter *adapter);
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+extern inline void writempd(unsigned long value)
+{
+	TSUNAMI_cchip->mpd.csr = value;
+	mb();
+}
+
+extern inline unsigned long readmpd(void)
+{
+	return TSUNAMI_cchip->mpd.csr;
+}
+
+static void bit_tsunami_setscl(void *data, int val)
+{
+	/* read currently setted bits to modify them */
+	unsigned long bits = readmpd() >> 2; /* assume output == input */
+
+	if (val)
+		bits |= MPD_CKS;
+	else
+		bits &= ~MPD_CKS;
+
+	writempd(bits);
+}
+
+static void bit_tsunami_setsda(void *data, int val)
+{
+	/* read currently setted bits to modify them */
+	unsigned long bits = readmpd() >> 2; /* assume output == input */
+
+	if (val)
+		bits |= MPD_DS;
+	else
+		bits &= ~MPD_DS;
+
+	writempd(bits);
+}
+
+/* The MPD pins are open drain, so the pins always remain outputs.
+   We rely on the i2c-algo-bit routines to set the pins high before
+   reading the input from other chips. */
+
+static int bit_tsunami_getscl(void *data)
+{
+	return (0 != (readmpd() & MPD_CKR));
+}
+
+static int bit_tsunami_getsda(void *data)
+{
+	return (0 != (readmpd() & MPD_DR));
+}
+
+static struct i2c_algo_bit_data tsunami_i2c_bit_data = {
+	NULL,
+	bit_tsunami_setsda,
+	bit_tsunami_setscl,
+	bit_tsunami_getsda,
+	bit_tsunami_getscl,
+	10, 10, 50	/* delays/timeout */
+};
+
+static struct i2c_adapter tsunami_i2c_adapter = {
+	"I2C Tsunami/Typhoon adapter",
+	I2C_HW_B_TSUNA,
+	NULL,
+	&tsunami_i2c_bit_data,
+	i2c_tsunami_inc,
+	i2c_tsunami_dec,
+	NULL,
+	NULL,
+};
+
+void i2c_tsunami_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void i2c_tsunami_dec(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+int __init i2c_tsunami_init(void)
+{
+	int res;
+	printk("i2c-tsunami.o version %s (%s)\n", LM_VERSION, LM_DATE);
+
+	if (hwrpb->sys_type != ST_DEC_TSUNAMI) {
+		printk("i2c-tsunami.o: not Tsunami based system (%d), module not inserted.\n", hwrpb->sys_type);
+		return -ENXIO;
+	} else {
+		printk("i2c-tsunami.o: using Cchip MPD at 0x%lx.\n", &TSUNAMI_cchip->mpd);
+	}
+	
+	if ((res = i2c_bit_add_bus(&tsunami_i2c_adapter))) {
+		printk("i2c-tsunami.o: I2C adapter registration failed\n");
+	} else {
+		printk("i2c-tsunami.o: I2C bus initialized\n");
+	}
+
+	return res;
+}
+
+int __init i2c_tsunami_cleanup(void)
+{
+	int res;
+
+	if ((res = i2c_bit_del_bus(&tsunami_i2c_adapter))) {
+		printk("i2c-tsunami.o: i2c_bit_del_bus failed, module not removed\n");
+		return res;
+	}
+
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Oleg I. Vdovikin <vdovikin@jscc.ru>");
+MODULE_DESCRIPTION("Tsunami I2C/SMBus driver");
+
+int init_module(void)
+{
+	return i2c_tsunami_init();
+}
+
+int cleanup_module(void)
+{
+	return i2c_tsunami_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-via.c	2002-05-20 01:55:24.000000000 -0400
@@ -0,0 +1,223 @@
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
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+MODULE_LICENSE("GPL");
+
+/* PCI device */
+#define VENDOR		PCI_VENDOR_ID_VIA
+#define DEVICE		PCI_DEVICE_ID_VIA_82C586_3
+
+/* Power management registers */
+
+#define PM_CFG_REVID    0x08	/* silicon revision code */
+#define PM_CFG_IOBASE0  0x20
+#define PM_CFG_IOBASE1  0x48
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
+/* ----- global defines -----------------------------------------------	*/
+#define DEB(x) x		/* silicon revision, io addresses       */
+#define DEB2(x) x		/* line status                          */
+#define DEBE(x)			/*                                      */
+
+/* ----- local functions ----------------------------------------------	*/
+
+static u16 pm_io_base;
+
+/*
+   It does not appear from the datasheet that the GPIO pins are
+   open drain. So a we set a low value by setting the direction to
+   output and a high value by setting the direction to input and
+   relying on the required I2C pullup. The data value is initialized
+   to 0 in i2c_via_init() and never changed.
+*/
+
+static void bit_via_setscl(void *data, int state)
+{
+	outb(state ? inb(I2C_DIR) & ~I2C_SCL : inb(I2C_DIR) | I2C_SCL,
+	     I2C_DIR);
+}
+
+static void bit_via_setsda(void *data, int state)
+{
+	outb(state ? inb(I2C_DIR) & ~I2C_SDA : inb(I2C_DIR) | I2C_SDA,
+	     I2C_DIR);
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
+static void bit_via_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void bit_via_dec(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+/* ------------------------------------------------------------------------ */
+
+static struct i2c_algo_bit_data bit_data = {
+	NULL,
+	bit_via_setsda,
+	bit_via_setscl,
+	bit_via_getsda,
+	bit_via_getscl,
+	5, 5, 100,		/*waits, timeout */
+};
+
+static struct i2c_adapter bit_via_ops = {
+	"VIA i2c",
+	I2C_HW_B_VIA,
+	NULL,
+	&bit_data,
+	bit_via_inc,
+	bit_via_dec,
+	NULL,
+	NULL,
+};
+
+
+/* When exactly was the new pci interface introduced? */
+static int find_via(void)
+{
+	struct pci_dev *s_bridge;
+	u16 base;
+	u8 rev;
+
+	if (!pci_present())
+		return -ENODEV;
+
+	s_bridge = pci_find_device(VENDOR, DEVICE, NULL);
+
+	if (!s_bridge) {
+		printk("i2c-via.o: vt82c586b not found\n");
+		return -ENODEV;
+	}
+
+	if (PCIBIOS_SUCCESSFUL !=
+	    pci_read_config_byte(s_bridge, PM_CFG_REVID, &rev))
+		return -ENODEV;
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
+	if (PCIBIOS_SUCCESSFUL !=
+	    pci_read_config_word(s_bridge, base, &pm_io_base))
+		    return -ENODEV;
+
+	pm_io_base &= (0xff << 8);
+	return 0;
+}
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_via_init(void)
+{
+	printk("i2c-via.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	if (find_via() < 0) {
+		printk("i2c-via.o: Error while reading PCI configuration\n");
+		return -ENODEV;
+	}
+
+	if (check_region(I2C_DIR, IOSPACE) < 0) {
+		printk("i2c-via.o: IO 0x%x-0x%x already in use\n",
+		       I2C_DIR, I2C_DIR + IOSPACE);
+		return -EBUSY;
+	} else {
+		request_region(I2C_DIR, IOSPACE, IOTEXT);
+		outb(inb(I2C_DIR) & ~(I2C_SDA | I2C_SCL), I2C_DIR);
+		outb(inb(I2C_OUT) & ~(I2C_SDA | I2C_SCL), I2C_OUT);
+	}
+
+	if (i2c_bit_add_bus(&bit_via_ops) == 0) {
+		printk("i2c-via.o: Module succesfully loaded\n");
+		return 0;
+	} else {
+		release_region(I2C_DIR, IOSPACE);
+		printk
+		    ("i2c-via.o: Algo-bit error, couldn't register bus\n");
+		return -ENODEV;
+	}
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+MODULE_AUTHOR("Kyösti Mälkki <kmalkki@cc.hut.fi>");
+MODULE_DESCRIPTION("i2c for Via vt82c586b southbridge");
+
+int init_module(void)
+{
+	return i2c_via_init();
+}
+
+void cleanup_module(void)
+{
+	i2c_bit_del_bus(&bit_via_ops);
+	release_region(I2C_DIR, IOSPACE);
+}
+#endif
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-viapro.c	2002-05-20 01:55:42.000000000 -0400
@@ -0,0 +1,566 @@
+/*
+    i2c-viapro.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+    Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>, 
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
+	8233
+   Note: we assume there can only be one device, with one SMBus interface.
+*/
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+#ifndef PCI_DEVICE_ID_VIA_82C596_3
+#define PCI_DEVICE_ID_VIA_82C596_3 	0x3050
+#endif
+#ifndef PCI_DEVICE_ID_VIA_82C596B_3
+#define PCI_DEVICE_ID_VIA_82C596B_3	0x3051
+#endif
+#ifndef PCI_DEVICE_ID_VIA_82C686_4
+#define PCI_DEVICE_ID_VIA_82C686_4 	0x3057
+#endif
+#ifndef PCI_DEVICE_ID_VIA_8233_0
+#define PCI_DEVICE_ID_VIA_8233_0	0x3074
+#endif
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
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_vt596_init(void);
+static int __init vt596_cleanup(void);
+static int vt596_setup(void);
+static s32 vt596_access(struct i2c_adapter *adap, u16 addr,
+			unsigned short flags, char read_write,
+			u8 command, int size, union i2c_smbus_data *data);
+static void vt596_do_pause(unsigned int amount);
+static int vt596_transaction(void);
+static void vt596_inc(struct i2c_adapter *adapter);
+static void vt596_dec(struct i2c_adapter *adapter);
+static u32 vt596_func(struct i2c_adapter *adapter);
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+static struct i2c_algorithm smbus_algorithm = {
+	/* name */ "Non-I2C SMBus adapter",
+	/* id */ I2C_ALGO_SMBUS,
+	/* master_xfer */ NULL,
+	/* smbus_access */ vt596_access,
+	/* slave_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ vt596_func,
+};
+
+static struct i2c_adapter vt596_adapter = {
+	"unset",
+	I2C_ALGO_SMBUS | I2C_HW_SMBUS_VIA2,
+	&smbus_algorithm,
+	NULL,
+	vt596_inc,
+	vt596_dec,
+	NULL,
+	NULL,
+};
+
+static int __initdata vt596_initialized;
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
+	printk("i2c-viapro.o: Found Via %s device\n", num->name);
+
+/* Determine the address of the SMBus areas */
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
+			        printk("i2c-viapro.o: Cannot configure SMBus "
+				       "I/O Base address\n");
+			        return(-ENODEV);
+			}
+		}
+		vt596_smba &= 0xfff0;
+		if(vt596_smba == 0) {
+			printk(KERN_ERR "i2c-viapro.o: SMBus base address"
+			   "uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+			return -ENODEV;
+		}
+	}
+
+	if (check_region(vt596_smba, 8)) {
+		printk("i2c-viapro.o: SMBus region 0x%x already in use!\n",
+		        vt596_smba);
+		return(-ENODEV);
+	}
+
+	pci_read_config_byte(VT596_dev, SMBHSTCFG, &temp);
+/* If force_addr is set, we program the new address here. Just to make
+   sure, we disable the VT596 first. */
+	if (force_addr) {
+		pci_write_config_byte(VT596_dev, SMBHSTCFG, temp & 0xfe);
+		pci_write_config_word(VT596_dev, num->base, vt596_smba);
+		pci_write_config_byte(VT596_dev, SMBHSTCFG, temp | 0x01);
+		printk
+		    ("i2c-viapro.o: WARNING: SMBus interface set to new "
+		     "address 0x%04x!\n", vt596_smba);
+	} else if ((temp & 1) == 0) {
+		if (force) {
+/* NOTE: This assumes I/O space and other allocations WERE
+   done by the Bios!  Don't complain if your hardware does weird 
+   things after enabling this. :') Check for Bios updates before
+   resorting to this.  */
+			pci_write_config_byte(VT596_dev, SMBHSTCFG,
+					      temp | 1);
+			printk
+			    ("i2c-viapro.o: enabling SMBus device\n");
+		} else {
+			printk
+			    ("SMBUS: Error: Host SMBus controller not enabled! - "
+			     "upgrade BIOS or use force=1\n");
+			return(-ENODEV);
+		}
+	}
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(vt596_smba, 8, "viapro-smbus");
+
+#ifdef DEBUG
+	if ((temp & 0x0E) == 8)
+		printk("i2c-viapro.o: using Interrupt 9 for SMBus.\n");
+	else if ((temp & 0x0E) == 0)
+		printk("i2c-viapro.o: using Interrupt SMI# for SMBus.\n");
+	else
+		printk
+		    ("i2c-viapro.o: Illegal Interrupt configuration (or code out "
+		     "of date)!\n");
+
+	pci_read_config_byte(VT596_dev, SMBREV, &temp);
+	printk("i2c-viapro.o: SMBREV = 0x%X\n", temp);
+	printk("i2c-viapro.o: VT596_smba = 0x%X\n", vt596_smba);
+#endif				/* DEBUG */
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
+#ifdef DEBUG
+	printk
+	    ("i2c-viapro.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
+	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
+	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
+#endif
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+#ifdef DEBUG
+		printk("i2c-viapro.o: SMBus busy (0x%02x). Resetting... \n",
+		       temp);
+#endif
+		outb_p(temp, SMBHSTSTS);
+		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+#ifdef DEBUG
+			printk("i2c-viapro.o: Failed! (0x%02x)\n", temp);
+#endif
+			return -1;
+		} else {
+#ifdef DEBUG
+			printk("i2c-viapro.o: Successfull!\n");
+#endif
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
+#ifdef DEBUG
+		printk("i2c-viapro.o: SMBus Timeout!\n");
+		result = -1;
+#endif
+	}
+
+	if (temp & 0x10) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-viapro.o: Error: Failed bus transaction\n");
+#endif
+	}
+
+	if (temp & 0x08) {
+		result = -1;
+		printk
+		    ("i2c-viapro.o: Bus collision! SMBus may be locked until next hard\n"
+		     "reset. (sorry!)\n");
+		/* Clock stops and slave is stuck in mid-transmission */
+	}
+
+	if (temp & 0x04) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-viapro.o: Error: no response!\n");
+#endif
+	}
+
+	if (inb_p(SMBHSTSTS) != 0x00)
+		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
+
+	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+#ifdef DEBUG
+		printk
+		    ("i2c-viapro.o: Failed reset at end of transaction (%02x)\n",
+		     temp);
+#endif
+	}
+#ifdef DEBUG
+	printk
+	    ("i2c-viapro.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
+	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
+	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
+#endif
+	return result;
+}
+
+/* Return -1 on error. See smbus.h for more information */
+s32 vt596_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
+		 char read_write,
+		 u8 command, int size, union i2c_smbus_data * data)
+{
+	int i, len;
+
+	switch (size) {
+	case I2C_SMBUS_PROC_CALL:
+		printk
+		    ("i2c-viapro.o: I2C_SMBUS_PROC_CALL not supported!\n");
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
+	case VT596_BYTE:	/* Where is the result put? I assume here it is in
+				   SMBHSTDAT0 but it might just as well be in the
+				   SMBHSTCMD. No clue in the docs */
+
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
+void vt596_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void vt596_dec(struct i2c_adapter *adapter)
+{
+
+	MOD_DEC_USE_COUNT;
+}
+
+u32 vt596_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+int __init i2c_vt596_init(void)
+{
+	int res;
+	printk("i2c-viapro.o version %s (%s)\n", LM_VERSION, LM_DATE);
+#ifdef DEBUG
+/* PE- It might be good to make this a permanent part of the code! */
+	if (vt596_initialized) {
+		printk
+		    ("i2c-viapro.o: Oops, vt596_init called a second time!\n");
+		return -EBUSY;
+	}
+#endif
+	vt596_initialized = 0;
+	if ((res = vt596_setup())) {
+		printk
+		    ("i2c-viapro.o: Can't detect vt82c596 or compatible device, module not inserted.\n");
+		vt596_cleanup();
+		return res;
+	}
+	vt596_initialized++;
+	sprintf(vt596_adapter.name, "SMBus Via Pro adapter at %04x",
+		vt596_smba);
+	if ((res = i2c_add_adapter(&vt596_adapter))) {
+		printk
+		    ("i2c-viapro.o: Adapter registration failed, module not inserted.\n");
+		vt596_cleanup();
+		return res;
+	}
+	vt596_initialized++;
+	printk("i2c-viapro.o: Via Pro SMBus detected and initialized\n");
+	return 0;
+}
+
+int __init vt596_cleanup(void)
+{
+	int res;
+	if (vt596_initialized >= 2) {
+		if ((res = i2c_del_adapter(&vt596_adapter))) {
+			printk
+			    ("i2c-viapro.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		} else
+			vt596_initialized--;
+	}
+	if (vt596_initialized >= 1) {
+		release_region(vt596_smba, 8);
+		vt596_initialized--;
+	}
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl> and Philip Edelbrock <phil@netroedge.com>");
+MODULE_DESCRIPTION("vt82c596 SMBus driver");
+
+MODULE_LICENSE("GPL");
+
+int init_module(void)
+{
+	return i2c_vt596_init();
+}
+
+int cleanup_module(void)
+{
+	return vt596_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-voodoo3.c	2002-05-20 01:56:01.000000000 -0400
@@ -0,0 +1,359 @@
+/*
+    voodoo3.c - Part of lm_sensors, Linux kernel modules for hardware
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
+/* This interfaces to the I2C bus of the Voodoo3 to gain access to
+    the BT869 and possibly other I2C devices. */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+MODULE_LICENSE("GPL");
+
+/* 3DFX defines */
+#ifndef PCI_DEVICE_ID_3DFX_VOODOO3
+#define PCI_DEVICE_ID_3DFX_VOODOO3 0x05
+#endif
+#ifndef PCI_DEVICE_ID_3DFX_BANSHEE
+#define PCI_DEVICE_ID_3DFX_BANSHEE 0x03
+#endif
+
+/* the only registers we use */
+#define REG	0x78
+#define REG2 	0x70
+
+/* bit locations in the register */
+#define DDC_ENAB	0x00040000
+#define DDC_SCL_OUT	0x00080000
+#define DDC_SDA_OUT	0x00100000
+#define DDC_SCL_IN	0x00200000
+#define DDC_SDA_IN	0x00400000
+#define I2C_ENAB	0x00800000
+#define I2C_SCL_OUT	0x01000000
+#define I2C_SDA_OUT	0x02000000
+#define I2C_SCL_IN	0x04000000
+#define I2C_SDA_IN	0x08000000
+
+/* initialization states */
+#define INIT2	0x2
+#define INIT3	0x4
+
+/* delays */
+#define CYCLE_DELAY	10
+#define TIMEOUT		50
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_voodoo3_init(void);
+static int __init voodoo3_cleanup(void);
+static int voodoo3_setup(void);
+static void config_v3(struct pci_dev *dev);
+static void voodoo3_inc(struct i2c_adapter *adapter);
+static void voodoo3_dec(struct i2c_adapter *adapter);
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+
+static int __initdata voodoo3_initialized;
+static unsigned char *mem;
+
+extern inline void outlong(unsigned int dat)
+{
+	*((unsigned int *) (mem + REG)) = dat;
+}
+
+extern inline unsigned int readlong(void)
+{
+	return *((unsigned int *) (mem + REG));
+}
+
+/* The voo GPIO registers don't have individual masks for each bit
+   so we always have to read before writing. */
+
+static void bit_vooi2c_setscl(void *data, int val)
+{
+	unsigned int r;
+	r = readlong();
+	if(val)
+		r |= I2C_SCL_OUT;
+	else
+		r &= ~I2C_SCL_OUT;
+	outlong(r);
+}
+
+static void bit_vooi2c_setsda(void *data, int val)
+{
+	unsigned int r;
+	r = readlong();
+	if(val)
+		r |= I2C_SDA_OUT;
+	else
+		r &= ~I2C_SDA_OUT;
+	outlong(r);
+}
+
+/* The GPIO pins are open drain, so the pins always remain outputs.
+   We rely on the i2c-algo-bit routines to set the pins high before
+   reading the input from other chips. */
+
+static int bit_vooi2c_getscl(void *data)
+{
+	return (0 != (readlong() & I2C_SCL_IN));
+}
+
+static int bit_vooi2c_getsda(void *data)
+{
+	return (0 != (readlong() & I2C_SDA_IN));
+}
+
+static void bit_vooddc_setscl(void *data, int val)
+{
+	unsigned int r;
+	r = readlong();
+	if(val)
+		r |= DDC_SCL_OUT;
+	else
+		r &= ~DDC_SCL_OUT;
+	outlong(r);
+}
+
+static void bit_vooddc_setsda(void *data, int val)
+{
+	unsigned int r;
+	r = readlong();
+	if(val)
+		r |= DDC_SDA_OUT;
+	else
+		r &= ~DDC_SDA_OUT;
+	outlong(r);
+}
+
+static int bit_vooddc_getscl(void *data)
+{
+	return (0 != (readlong() & DDC_SCL_IN));
+}
+
+static int bit_vooddc_getsda(void *data)
+{
+	return (0 != (readlong() & DDC_SDA_IN));
+}
+
+static struct i2c_algo_bit_data voo_i2c_bit_data = {
+	NULL,
+	bit_vooi2c_setsda,
+	bit_vooi2c_setscl,
+	bit_vooi2c_getsda,
+	bit_vooi2c_getscl,
+	CYCLE_DELAY, CYCLE_DELAY, TIMEOUT
+};
+
+static struct i2c_adapter voodoo3_i2c_adapter = {
+	"I2C Voodoo3/Banshee adapter",
+	I2C_HW_B_VOO,
+	NULL,
+	&voo_i2c_bit_data,
+	voodoo3_inc,
+	voodoo3_dec,
+	NULL,
+	NULL,
+};
+
+static struct i2c_algo_bit_data voo_ddc_bit_data = {
+	NULL,
+	bit_vooddc_setsda,
+	bit_vooddc_setscl,
+	bit_vooddc_getsda,
+	bit_vooddc_getscl,
+	CYCLE_DELAY, CYCLE_DELAY, TIMEOUT
+};
+
+static struct i2c_adapter voodoo3_ddc_adapter = {
+	"DDC Voodoo3/Banshee adapter",
+	I2C_HW_B_VOO,
+	NULL,
+	&voo_ddc_bit_data,
+	voodoo3_inc,
+	voodoo3_dec,
+	NULL,
+	NULL,
+};
+
+/* Configures the chip */
+
+void config_v3(struct pci_dev *dev)
+{
+	unsigned int cadr;
+
+	/* map Voodoo3 memory */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13)
+	cadr = dev->resource[0].start;
+#else
+	cadr = dev->base_address[0];
+#endif
+	cadr &= PCI_BASE_ADDRESS_MEM_MASK;
+	mem = ioremap_nocache(cadr, 0x1000);
+
+	*((unsigned int *) (mem + REG2)) = 0x8160;
+	*((unsigned int *) (mem + REG)) = 0xcffc0020;
+	printk("i2c-voodoo3: Using Banshee/Voodoo3 at 0x%p\n", mem);
+}
+
+/* Detect whether a Voodoo3 or a Banshee can be found,
+   and initialize it. */
+static int voodoo3_setup(void)
+{
+	struct pci_dev *dev;
+	int v3_num;
+
+	v3_num = 0;
+
+	dev = NULL;
+	do {
+		if ((dev = pci_find_device(PCI_VENDOR_ID_3DFX,
+					   PCI_DEVICE_ID_3DFX_VOODOO3,
+					   dev))) {
+			if (!v3_num)
+				config_v3(dev);
+			v3_num++;
+		}
+	} while (dev);
+
+	dev = NULL;
+	do {
+		if ((dev = pci_find_device(PCI_VENDOR_ID_3DFX,
+					   PCI_DEVICE_ID_3DFX_BANSHEE,
+					   dev))) {
+			if (!v3_num)
+				config_v3(dev);
+			v3_num++;
+		}
+	} while (dev);
+
+	if (v3_num > 0) {
+		printk("i2c-voodoo3: %d Banshee/Voodoo3 found.\n", v3_num);
+		if (v3_num > 1)
+			printk("i2c-voodoo3: warning: only 1 supported.\n");
+		return 0;
+	} else {
+		printk("i2c-voodoo3: No Voodoo3 found.\n");
+		return -ENODEV;
+	}
+}
+
+void voodoo3_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void voodoo3_dec(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+int __init i2c_voodoo3_init(void)
+{
+	int res;
+	printk("i2c-voodoo3.o version %s (%s)\n", LM_VERSION, LM_DATE);
+	voodoo3_initialized = 0;
+	if ((res = voodoo3_setup())) {
+		printk
+		    ("i2c-voodoo3.o: Voodoo3 not detected, module not inserted.\n");
+		voodoo3_cleanup();
+		return res;
+	}
+	if ((res = i2c_bit_add_bus(&voodoo3_i2c_adapter))) {
+		printk("i2c-voodoo3.o: I2C adapter registration failed\n");
+	} else {
+		printk("i2c-voodoo3.o: I2C bus initialized\n");
+		voodoo3_initialized |= INIT2;
+	}
+	if ((res = i2c_bit_add_bus(&voodoo3_ddc_adapter))) {
+		printk("i2c-voodoo3.o: DDC adapter registration failed\n");
+	} else {
+		printk("i2c-voodoo3.o: DDC bus initialized\n");
+		voodoo3_initialized |= INIT3;
+	}
+	if(!(voodoo3_initialized & (INIT2 | INIT3))) {
+		printk("i2c-voodoo3.o: Both registrations failed, module not inserted\n");
+		voodoo3_cleanup();
+		return res;
+	}
+	return 0;
+}
+
+int __init voodoo3_cleanup(void)
+{
+	int res;
+
+	iounmap(mem);
+	if (voodoo3_initialized & INIT3) {
+		if ((res = i2c_bit_del_bus(&voodoo3_ddc_adapter))) {
+			printk
+			    ("i2c-voodoo3.o: i2c_bit_del_bus failed, module not removed\n");
+			return res;
+		}
+	}
+	if (voodoo3_initialized & INIT2) {
+		if ((res = i2c_bit_del_bus(&voodoo3_i2c_adapter))) {
+			printk
+			    ("i2c-voodoo3.o: i2c_bit_del_bus failed, module not removed\n");
+			return res;
+		}
+	}
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, Ralph Metzler <rjkm@thp.uni-koeln.de>, and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_DESCRIPTION("Voodoo3 I2C/SMBus driver");
+
+
+int init_module(void)
+{
+	return i2c_voodoo3_init();
+}
+
+int cleanup_module(void)
+{
+	return voodoo3_cleanup();
+}
+
+#endif				/* MODULE */

--------------A50607A6F44730B5BA5DA7B9--

