Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318515AbSGSOF5>; Fri, 19 Jul 2002 10:05:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318523AbSGSOF4>; Fri, 19 Jul 2002 10:05:56 -0400
Received: from sccrmhc01.attbi.com ([204.127.202.61]:33767 "EHLO
	sccrmhc01.attbi.com") by vger.kernel.org with ESMTP
	id <S318515AbSGSODa>; Fri, 19 Jul 2002 10:03:30 -0400
Message-ID: <3D381CE2.4F743196@bellsouth.net>
Date: Fri, 19 Jul 2002 10:06:26 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 3/9] 2.5.6 lm_sensors
Content-Type: multipart/mixed;
 boundary="------------60B104FA1A8CA828FCC8615D"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------60B104FA1A8CA828FCC8615D
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
--------------60B104FA1A8CA828FCC8615D
Content-Type: text/plain; charset=us-ascii;
 name="2.5.26-busses-b-patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="2.5.26-busses-b-patch"

--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-i801.c	2002-05-20 01:53:14.000000000 -0400
@@ -0,0 +1,706 @@
+/*
+    i801.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+    Copyright (c) 1998 - 2001  Frodo Looijaard <frodol@dds.nl>,
+    Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker
+    <mdsxyz123@yahoo.com>
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
+    SUPPORTED DEVICES	PCI ID
+    82801AA		2413           
+    82801AB		2423           
+    82801BA		2443           
+    82801CA/CAM		2483           
+
+    This driver supports several versions of Intel's I/O Controller Hubs (ICH).
+    For SMBus support, they are similar to the PIIX4 and are part
+    of Intel's '810' and other chipsets.
+    See the doc/busses/i2c-i801 file for details.
+*/
+
+/* Note: we assume there can only be one I801, with one SMBus interface */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <linux/init.h>
+#include <linux/i2c.h>
+#include <linux/sensors.h>
+
+MODULE_LICENSE("GPL");
+
+#ifndef PCI_DEVICE_ID_INTEL_82801AA_3
+#define PCI_DEVICE_ID_INTEL_82801AA_3   0x2413
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_82801AB_3
+#define PCI_DEVICE_ID_INTEL_82801AB_3   0x2423
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_82801BA_2
+#define PCI_DEVICE_ID_INTEL_82801BA_2   0x2443
+#endif
+#define PCI_DEVICE_ID_INTEL_82801CA_SMBUS	0x2483
+
+static int supported[] = {PCI_DEVICE_ID_INTEL_82801AA_3,
+                          PCI_DEVICE_ID_INTEL_82801AB_3,
+                          PCI_DEVICE_ID_INTEL_82801BA_2,
+			  PCI_DEVICE_ID_INTEL_82801CA_SMBUS,
+                          0 };
+
+/* I801 SMBus address offsets */
+#define SMBHSTSTS (0 + i801_smba)
+#define SMBHSTCNT (2 + i801_smba)
+#define SMBHSTCMD (3 + i801_smba)
+#define SMBHSTADD (4 + i801_smba)
+#define SMBHSTDAT0 (5 + i801_smba)
+#define SMBHSTDAT1 (6 + i801_smba)
+#define SMBBLKDAT (7 + i801_smba)
+
+/* PCI Address Constants */
+#define SMBBA     0x020
+#define SMBHSTCFG 0x040
+#define SMBREV    0x008
+
+/* Host configuration bits for SMBHSTCFG */
+#define SMBHSTCFG_HST_EN      1
+#define SMBHSTCFG_SMB_SMI_EN  2
+#define SMBHSTCFG_I2C_EN      4
+
+/* Other settings */
+#define MAX_TIMEOUT 500
+#define  ENABLE_INT9 0
+
+/* I801 command constants */
+#define I801_QUICK          0x00
+#define I801_BYTE           0x04
+#define I801_BYTE_DATA      0x08
+#define I801_WORD_DATA      0x0C
+#define I801_BLOCK_DATA     0x14
+#define I801_I2C_BLOCK_DATA 0x18	/* unimplemented */
+#define I801_BLOCK_LAST     0x34
+#define I801_I2C_BLOCK_LAST 0x38	/* unimplemented */
+
+/* insmod parameters */
+
+/* If force is set to anything different from 0, we forcibly enable the
+   I801. DANGEROUS! */
+static int force = 0;
+MODULE_PARM(force, "i");
+MODULE_PARM_DESC(force, "Forcibly enable the I801. DANGEROUS!");
+
+/* If force_addr is set to anything different from 0, we forcibly enable
+   the I801 at the given address. VERY DANGEROUS! */
+static int force_addr = 0;
+MODULE_PARM(force_addr, "i");
+MODULE_PARM_DESC(force_addr,
+		 "Forcibly enable the I801 at the given address. "
+		 "EXTREMELY DANGEROUS!");
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_i801_init(void);
+static int __init i801_cleanup(void);
+static int i801_setup(void);
+static s32 i801_access(struct i2c_adapter *adap, u16 addr,
+		       unsigned short flags, char read_write,
+		       u8 command, int size, union i2c_smbus_data *data);
+static void i801_do_pause(unsigned int amount);
+static int i801_transaction(void);
+static int i801_block_transaction(union i2c_smbus_data *data,
+				  char read_write, int i2c_enable);
+static void i801_inc(struct i2c_adapter *adapter);
+static void i801_dec(struct i2c_adapter *adapter);
+static u32 i801_func(struct i2c_adapter *adapter);
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
+	/* smbus_xfer */ i801_access,
+	/* slave_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ i801_func,
+};
+
+static struct i2c_adapter i801_adapter = {
+	"unset",
+	I2C_ALGO_SMBUS | I2C_HW_SMBUS_I801,
+	&smbus_algorithm,
+	NULL,
+	i801_inc,
+	i801_dec,
+	NULL,
+	NULL,
+};
+
+static int __initdata i801_initialized;
+static unsigned short i801_smba = 0;
+static struct pci_dev *I801_dev = NULL;
+
+
+/* Detect whether a I801 can be found, and initialize it, where necessary.
+   Note the differences between kernels with the old PCI BIOS interface and
+   newer kernels with the real PCI interface. In compat.h some things are
+   defined to make the transition easier. */
+int i801_setup(void)
+{
+	int error_return = 0;
+	int *num = supported;
+	unsigned char temp;
+
+	/* First check whether we can access PCI at all */
+	if (pci_present() == 0) {
+		printk("i2c-i801.o: Error: No PCI-bus found!\n");
+		error_return = -ENODEV;
+		goto END;
+	}
+
+	/* Look for each chip */
+	/* Note: we keep on searching until we have found 'function 3' */
+	I801_dev = NULL;
+	do {
+		if((I801_dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					      *num, I801_dev))) {
+			if(PCI_FUNC(I801_dev->devfn) != 3)
+				continue;
+			break;
+		}
+		num++;
+	} while (*num != 0);
+
+	if (I801_dev == NULL) {
+		printk
+		    ("i2c-i801.o: Error: Can't detect I801, function 3!\n");
+		error_return = -ENODEV;
+		goto END;
+	}
+
+/* Determine the address of the SMBus areas */
+	if (force_addr) {
+		i801_smba = force_addr & 0xfff0;
+		force = 0;
+	} else {
+		pci_read_config_word(I801_dev, SMBBA, &i801_smba);
+		i801_smba &= 0xfff0;
+	}
+
+	if (check_region(i801_smba, 8)) {
+		printk
+		    ("i2c-i801.o: I801_smb region 0x%x already in use!\n",
+		     i801_smba);
+		error_return = -ENODEV;
+		goto END;
+	}
+
+	pci_read_config_byte(I801_dev, SMBHSTCFG, &temp);
+/* If force_addr is set, we program the new address here. Just to make
+   sure, we disable the I801 first. */
+	if (force_addr) {
+		pci_write_config_byte(I801_dev, SMBHSTCFG, temp & 0xfe);
+		pci_write_config_word(I801_dev, SMBBA, i801_smba);
+		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 0x01);
+		printk
+		    ("i2c-i801.o: WARNING: I801 SMBus interface set to new "
+		     "address %04x!\n", i801_smba);
+	} else if ((temp & 1) == 0) {
+		if (force) {
+/* This should never need to be done, but has been noted that
+   many Dell machines have the SMBus interface on the PIIX4
+   disabled!? NOTE: This assumes I/O space and other allocations WERE
+   done by the Bios!  Don't complain if your hardware does weird 
+   things after enabling this. :') Check for Bios updates before
+   resorting to this.  */
+			pci_write_config_byte(I801_dev, SMBHSTCFG,
+					      temp | 1);
+			printk
+			    ("i2c-i801.o: WARNING: I801 SMBus interface has been FORCEFULLY "
+			     "ENABLED!\n");
+		} else {
+			printk
+			    ("SMBUS: Error: Host SMBus controller not enabled!\n");
+			error_return = -ENODEV;
+			goto END;
+		}
+	}
+
+	/* note: we assumed that the BIOS picked SMBus or I2C Bus timing
+	   appropriately (bit 2 in SMBHSTCFG) */
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(i801_smba, 8, "i801-smbus");
+
+#ifdef DEBUG
+	if (temp & 0x02)
+		printk
+		    ("i2c-i801.o: I801 using Interrupt SMI# for SMBus.\n");
+	else
+		printk
+		    ("i2c-i801.o: I801 using PCI Interrupt for SMBus.\n");
+
+	pci_read_config_byte(I801_dev, SMBREV, &temp);
+	printk("i2c-i801.o: SMBREV = 0x%X\n", temp);
+	printk("i2c-i801.o: I801_smba = 0x%X\n", i801_smba);
+#endif				/* DEBUG */
+
+      END:
+	return error_return;
+}
+
+
+/* Internally used pause function */
+void i801_do_pause(unsigned int amount)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+/* Another internally used function */
+int i801_transaction(void)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+#ifdef DEBUG
+	printk
+	    ("i2c-i801.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
+	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
+	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
+#endif
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
+	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
+#ifdef DEBUG
+		printk("i2c-i801.o: SMBus busy (%02x). Resetting... \n",
+		       temp);
+#endif
+		outb_p(temp, SMBHSTSTS);
+		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
+#ifdef DEBUG
+			printk("i2c-i801.o: Failed! (%02x)\n", temp);
+#endif
+			return -1;
+		} else {
+#ifdef DEBUG
+			printk("i2c-i801.o: Successfull!\n");
+#endif
+		}
+	}
+
+	/* start the transaction by setting bit 6 */
+	outb_p(inb(SMBHSTCNT) | 0x040, SMBHSTCNT);
+
+	/* We will always wait for a fraction of a second! */
+	do {
+		i801_do_pause(1);
+		temp = inb_p(SMBHSTSTS);
+	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+#ifdef DEBUG
+		printk("i2c-i801.o: SMBus Timeout!\n");
+		result = -1;
+#endif
+	}
+
+	if (temp & 0x10) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-i801.o: Error: Failed bus transaction\n");
+#endif
+	}
+
+	if (temp & 0x08) {
+		result = -1;
+		printk
+		    ("i2c-i801.o: Bus collision! SMBus may be locked until next hard\n"
+		     "reset. (sorry!)\n");
+		/* Clock stops and slave is stuck in mid-transmission */
+	}
+
+	if (temp & 0x04) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-i801.o: Error: no response!\n");
+#endif
+	}
+
+	if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
+		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
+
+	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
+#ifdef DEBUG
+		printk
+		    ("i2c-i801.o: Failed reset at end of transaction (%02x)\n",
+		     temp);
+#endif
+	}
+#ifdef DEBUG
+	printk
+	    ("i2c-i801.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
+	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
+	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
+#endif
+	return result;
+}
+
+/* All-inclusive block transaction function */
+int i801_block_transaction(union i2c_smbus_data *data, char read_write, 
+                           int i2c_enable)
+{
+	int i, len;
+	int smbcmd;
+	int temp;
+	int result = 0;
+	int timeout = 0;
+        unsigned char hostc, errmask;
+
+        if (i2c_enable) {
+                if (read_write == I2C_SMBUS_WRITE) {
+                        /* set I2C_EN bit in configuration register */
+                        pci_read_config_byte(I801_dev, SMBHSTCFG, &hostc);
+                        pci_write_config_byte(I801_dev, SMBHSTCFG, 
+                                              hostc | SMBHSTCFG_I2C_EN);
+                } else {
+                        printk("i2c-i801.o: "
+                               "I2C_SMBUS_I2C_BLOCK_READ not supported!\n");
+                        return -1;
+                }
+        }
+
+	if (read_write == I2C_SMBUS_WRITE) {
+		len = data->block[0];
+		if (len < 1)
+			len = 1;
+		if (len > 32)
+			len = 32;
+		outb_p(len, SMBHSTDAT0);
+		outb_p(data->block[1], SMBBLKDAT);
+	} else {
+		len = 32;	/* max for reads */
+	}
+
+	for (i = 1; i <= len; i++) {
+		if (i == len && read_write == I2C_SMBUS_READ)
+			smbcmd = I801_BLOCK_LAST;
+		else
+			smbcmd = I801_BLOCK_DATA;
+
+		outb_p((smbcmd & 0x3C) + (ENABLE_INT9 & 1), SMBHSTCNT);
+
+#ifdef DEBUG
+		printk
+		    ("i2c-i801.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, "
+		     "DAT0=%02x, BLKDAT=%02x\n", inb_p(SMBHSTCNT),
+		     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		     inb_p(SMBBLKDAT));
+#endif
+
+		/* Make sure the SMBus host is ready to start transmitting */
+		temp = inb_p(SMBHSTSTS);
+                if (i == 1) {
+                    /* Erronenous conditions before transaction: 
+                     * Byte_Done, Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
+                    errmask=0x9f; 
+                } else {
+                    /* Erronenous conditions during transaction: 
+                     * Failed, Bus_Err, Dev_Err, Intr */
+                    errmask=0x1e; 
+                }
+		if (temp & errmask) {
+#ifdef DEBUG
+			printk
+			    ("i2c-i801.o: SMBus busy (%02x). Resetting... \n",
+			     temp);
+#endif
+			outb_p(temp, SMBHSTSTS);
+			if (((temp = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
+				printk
+				    ("i2c-i801.o: Reset failed! (%02x)\n",
+				     temp);
+				result = -1;
+                                goto END;
+			}
+			if (i != 1) {
+                                result = -1;  /* if die in middle of block transaction, fail */
+                                goto END;
+                        }
+		}
+
+		/* start the transaction by setting bit 6 */
+		if (i==1) outb_p(inb(SMBHSTCNT) | 0x040, SMBHSTCNT);
+
+		/* We will always wait for a fraction of a second! */
+		do {
+			temp = inb_p(SMBHSTSTS);
+			i801_do_pause(1);
+		}
+		    while (
+			   (((i >= len) && (temp & 0x01))
+			    || ((i < len) && !(temp & 0x80)))
+			   && (timeout++ < MAX_TIMEOUT));
+
+		/* If the SMBus is still busy, we give up */
+		if (timeout >= MAX_TIMEOUT) {
+			result = -1;
+#ifdef DEBUG
+			printk("i2c-i801.o: SMBus Timeout!\n");
+#endif
+		}
+
+		if (temp & 0x10) {
+			result = -1;
+#ifdef DEBUG
+			printk
+			    ("i2c-i801.o: Error: Failed bus transaction\n");
+#endif
+		} else if (temp & 0x08) {
+			result = -1;
+			printk
+			    ("i2c-i801.o: Bus collision! SMBus may be locked until next hard"
+			     " reset. (sorry!)\n");
+			/* Clock stops and slave is stuck in mid-transmission */
+		} else if (temp & 0x04) {
+			result = -1;
+#ifdef DEBUG
+			printk("i2c-i801.o: Error: no response!\n");
+#endif
+		}
+
+		if (i == 1 && read_write == I2C_SMBUS_READ) {
+			len = inb_p(SMBHSTDAT0);
+			if (len < 1)
+				len = 1;
+			if (len > 32)
+				len = 32;
+			data->block[0] = len;
+		}
+
+                /* Retrieve/store value in SMBBLKDAT */
+		if (read_write == I2C_SMBUS_READ)
+			data->block[i] = inb_p(SMBBLKDAT);
+		if (read_write == I2C_SMBUS_WRITE && i+1 <= len)
+			outb_p(data->block[i+1], SMBBLKDAT);
+		if ((temp & 0x9e) != 0x00)
+                        outb_p(temp, SMBHSTSTS);  /* signals SMBBLKDAT ready */
+
+		temp = inb_p(SMBHSTSTS);
+		if ((temp = (0x1e & inb_p(SMBHSTSTS))) != 0x00) {
+#ifdef DEBUG
+			printk
+			    ("i2c-i801.o: Failed reset at end of transaction (%02x)\n",
+			     temp);
+#endif
+		}
+#ifdef DEBUG
+		printk
+		    ("i2c-i801.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
+		     "DAT0=%02x, BLKDAT=%02x\n", inb_p(SMBHSTCNT),
+		     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		     inb_p(SMBBLKDAT));
+#endif
+
+		if (result < 0) {
+			goto END;
+                }
+	}
+        result = 0;
+END:
+        if (i2c_enable) {
+                /* restore saved configuration register value */
+		pci_write_config_byte(I801_dev, SMBHSTCFG, hostc);
+        }
+	return result;
+}
+
+/* Return -1 on error. See smbus.h for more information */
+s32 i801_access(struct i2c_adapter * adap, u16 addr, unsigned short flags,
+		char read_write, u8 command, int size,
+		union i2c_smbus_data * data)
+{
+
+	switch (size) {
+	case I2C_SMBUS_PROC_CALL:
+		printk("i2c-i801.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		return -1;
+	case I2C_SMBUS_QUICK:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = I801_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(command, SMBHSTCMD);
+		size = I801_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(data->byte, SMBHSTDAT0);
+		size = I801_BYTE_DATA;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			outb_p(data->word & 0xff, SMBHSTDAT0);
+			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1);
+		}
+		size = I801_WORD_DATA;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+	case I2C_SMBUS_I2C_BLOCK_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		/* Block transactions are very different from piix4 block
+		   and from the other i801 transactions. Handle in the
+		   i801_block_transaction() routine. */
+		return i801_block_transaction(data, read_write, 
+                                              size==I2C_SMBUS_I2C_BLOCK_DATA);
+	}
+
+	/* 'size' is really the transaction type */
+	outb_p((size & 0x3C) + (ENABLE_INT9 & 1), SMBHSTCNT);
+
+	if (i801_transaction())	/* Error in transaction */
+		return -1;
+
+	if ((read_write == I2C_SMBUS_WRITE) || (size == I801_QUICK))
+		return 0;
+
+
+	switch (size) {
+	case I801_BYTE:	/* Result put in SMBHSTDAT0 */
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case I801_BYTE_DATA:
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case I801_WORD_DATA:
+		data->word = inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
+		break;
+	}
+	return 0;
+}
+
+void i801_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void i801_dec(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+u32 i801_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA | I2C_FUNC_SMBUS_WRITE_I2C_BLOCK;
+}
+
+int __init i2c_i801_init(void)
+{
+	int res;
+	printk("i2c-i801.o version %s (%s)\n", LM_VERSION, LM_DATE);
+#ifdef DEBUG
+/* PE- It might be good to make this a permanent part of the code! */
+	if (i801_initialized) {
+		printk
+		    ("i2c-i801.o: Oops, i801_init called a second time!\n");
+		return -EBUSY;
+	}
+#endif
+	i801_initialized = 0;
+	if ((res = i801_setup())) {
+		printk
+		    ("i2c-i801.o: I801 not detected, module not inserted.\n");
+		i801_cleanup();
+		return res;
+	}
+	i801_initialized++;
+	sprintf(i801_adapter.name, "SMBus I801 adapter at %04x",
+		i801_smba);
+	if ((res = i2c_add_adapter(&i801_adapter))) {
+		printk
+		    ("i2c-i801.o: Adapter registration failed, module not inserted.\n");
+		i801_cleanup();
+		return res;
+	}
+	i801_initialized++;
+	printk("i2c-i801.o: I801 bus detected and initialized\n");
+	return 0;
+}
+
+int __init i801_cleanup(void)
+{
+	int res;
+	if (i801_initialized >= 2) {
+		if ((res = i2c_del_adapter(&i801_adapter))) {
+			printk
+			    ("i2c-i801.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		} else
+			i801_initialized--;
+	}
+	if (i801_initialized >= 1) {
+		release_region(i801_smba, 8);
+		i801_initialized--;
+	}
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_DESCRIPTION("I801 SMBus driver");
+
+int init_module(void)
+{
+	return i2c_i801_init();
+}
+
+int cleanup_module(void)
+{
+	return i801_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-i810.c	2002-05-20 01:53:28.000000000 -0400
@@ -0,0 +1,347 @@
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
+/* PCI defines */
+#ifndef PCI_DEVICE_ID_INTEL_82810_IG1
+#define PCI_DEVICE_ID_INTEL_82810_IG1 0x7121
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_82810_IG3
+#define PCI_DEVICE_ID_INTEL_82810_IG3 0x7123
+#endif
+#ifndef PCI_DEVICE_ID_INTEL_82815_2
+#define PCI_DEVICE_ID_INTEL_82815_2   0x1132
+#endif
+
+static int i810_supported[] = {PCI_DEVICE_ID_INTEL_82810_IG1,
+                               PCI_DEVICE_ID_INTEL_82810_IG3,
+                               0x7125,
+                               PCI_DEVICE_ID_INTEL_82815_2,
+                               0 };
+
+/* GPIO register locations */
+#define I810_IOCONTROL_OFFSET 0x5000
+#define I810_HVSYNC	0x00	/* not used */
+#define I810_GPIOA	0x10
+#define I810_GPIOB	0x14
+
+/* bit locations in the registers */
+#define SCL_DIR_MASK	0x0001
+#define SCL_DIR		0x0002
+#define SCL_VAL_MASK	0x0004
+#define SCL_VAL_OUT	0x0008
+#define SCL_VAL_IN	0x0010
+#define SDA_DIR_MASK	0x0100
+#define SDA_DIR		0x0200
+#define SDA_VAL_MASK	0x0400
+#define SDA_VAL_OUT	0x0800
+#define SDA_VAL_IN	0x1000
+
+/* initialization states */
+#define INIT1	0x1
+#define INIT2	0x2
+#define INIT3	0x4
+
+/* delays */
+#define CYCLE_DELAY		10
+#define TIMEOUT			50
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_i810_init(void);
+static int __init i810i2c_cleanup(void);
+static int i810i2c_setup(void);
+static void config_i810(struct pci_dev *dev);
+static void i810_inc(struct i2c_adapter *adapter);
+static void i810_dec(struct i2c_adapter *adapter);
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+static int __initdata i810i2c_initialized;
+static unsigned char *mem;
+
+static inline void outlong(unsigned int dat, int off)
+{
+	*((unsigned int *) (mem + off)) = dat;
+}
+
+static inline unsigned int readlong(int off)
+{
+	return *((unsigned int *) (mem + off));
+}
+
+/* The i810 GPIO registers have individual masks for each bit
+   so we never have to read before writing. Nice. */
+
+static void bit_i810i2c_setscl(void *data, int val)
+{
+	outlong((val ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK,
+	     I810_GPIOB);
+}
+
+static void bit_i810i2c_setsda(void *data, int val)
+{
+ 	outlong((val ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK,
+	     I810_GPIOB);
+}
+
+/* The GPIO pins are open drain, so the pins always remain outputs.
+   We rely on the i2c-algo-bit routines to set the pins high before
+   reading the input from other chips. Following guidance in the 815
+   prog. ref. guide, we do a "dummy write" of 0 to the register before
+   reading which forces the input value to be latched. We presume this
+   applies to the 810 as well. This is necessary to get
+   i2c_algo_bit bit_test=1 to pass. */
+
+static int bit_i810i2c_getscl(void *data)
+{
+	outlong(0, I810_GPIOB);
+	return (0 != (readlong(I810_GPIOB) & SCL_VAL_IN));
+}
+
+static int bit_i810i2c_getsda(void *data)
+{
+	outlong(0, I810_GPIOB);
+	return (0 != (readlong(I810_GPIOB) & SDA_VAL_IN));
+}
+
+static void bit_i810ddc_setscl(void *data, int val)
+{
+	outlong((val ? SCL_VAL_OUT : 0) | SCL_DIR | SCL_DIR_MASK | SCL_VAL_MASK,
+	     I810_GPIOA);
+}
+
+static void bit_i810ddc_setsda(void *data, int val)
+{
+ 	outlong((val ? SDA_VAL_OUT : 0) | SDA_DIR | SDA_DIR_MASK | SDA_VAL_MASK,
+	     I810_GPIOA);
+}
+
+static int bit_i810ddc_getscl(void *data)
+{
+	outlong(0, I810_GPIOA);
+	return (0 != (readlong(I810_GPIOA) & SCL_VAL_IN));
+}
+
+static int bit_i810ddc_getsda(void *data)
+{
+	outlong(0, I810_GPIOA);
+	return (0 != (readlong(I810_GPIOA) & SDA_VAL_IN));
+}
+
+static struct i2c_algo_bit_data i810_i2c_bit_data = {
+	NULL,
+	bit_i810i2c_setsda,
+	bit_i810i2c_setscl,
+	bit_i810i2c_getsda,
+	bit_i810i2c_getscl,
+	CYCLE_DELAY, CYCLE_DELAY, TIMEOUT
+};
+
+static struct i2c_adapter i810_i2c_adapter = {
+	"I810/I815 I2C Adapter",
+	I2C_HW_B_I810,
+	NULL,
+	&i810_i2c_bit_data,
+	i810_inc,
+	i810_dec,
+	NULL,
+	NULL,
+};
+
+static struct i2c_algo_bit_data i810_ddc_bit_data = {
+	NULL,
+	bit_i810ddc_setsda,
+	bit_i810ddc_setscl,
+	bit_i810ddc_getsda,
+	bit_i810ddc_getscl,
+	CYCLE_DELAY, CYCLE_DELAY, TIMEOUT
+};
+
+static struct i2c_adapter i810_ddc_adapter = {
+	"I810/I815 DDC Adapter",
+	I2C_HW_B_I810,
+	NULL,
+	&i810_ddc_bit_data,
+	i810_inc,
+	i810_dec,
+	NULL,
+	NULL,
+};
+
+
+/* Configures the chip */
+void config_i810(struct pci_dev *dev)
+{
+	unsigned long cadr;
+
+	/* map I810 memory */
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13)
+	cadr = dev->resource[1].start;
+#else
+	cadr = dev->base_address[1];
+#endif
+	cadr += I810_IOCONTROL_OFFSET;
+	cadr &= PCI_BASE_ADDRESS_MEM_MASK;
+	mem = ioremap_nocache(cadr, 0x1000);
+	bit_i810i2c_setscl(NULL, 1);
+	bit_i810i2c_setsda(NULL, 1);
+	bit_i810ddc_setscl(NULL, 1);
+	bit_i810ddc_setsda(NULL, 1);
+}
+
+/* Detect whether a supported device can be found,
+   and initialize it */
+static int i810i2c_setup(void)
+{
+	struct pci_dev *dev = NULL;
+	int *num = i810_supported;
+
+	do {
+		if ((dev = pci_find_device(PCI_VENDOR_ID_INTEL,
+					   *num++, dev))) {
+			config_i810(dev);
+			printk("i2c-i810.o: i810/i815 found.\n");
+			return 0;
+		}
+	} while (*num != 0);
+
+	return -ENODEV;
+}
+
+
+void i810_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void i810_dec(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+int __init i2c_i810_init(void)
+{
+	int res;
+	printk("i2c-i810.o version %s (%s)\n", LM_VERSION, LM_DATE);
+
+	i810i2c_initialized = 0;
+	if ((res = i810i2c_setup())) {
+		printk
+		    ("i2c-i810.o: i810/i815 not detected, module not inserted.\n");
+		i810i2c_cleanup();
+		return res;
+	}
+	if ((res = i2c_bit_add_bus(&i810_i2c_adapter))) {
+		printk("i2c-i810.o: I2C adapter registration failed\n");
+	} else {
+		printk("i2c-i810.o: I810/I815 I2C bus initialized\n");
+		i810i2c_initialized |= INIT2;
+	}
+	if ((res = i2c_bit_add_bus(&i810_ddc_adapter))) {
+		printk("i2c-i810.o: DDC adapter registration failed\n");
+	} else {
+		printk("i2c-i810.o: I810/I815 DDC bus initialized\n");
+		i810i2c_initialized |= INIT3;
+	}
+	if(!(i810i2c_initialized & (INIT2 | INIT3))) {
+		printk("i2c-i810.o: Both registrations failed, module not inserted\n");
+		i810i2c_cleanup();
+		return res;
+	}
+	return 0;
+}
+
+int __init i810i2c_cleanup(void)
+{
+	int res;
+
+	iounmap(mem);
+	if (i810i2c_initialized & INIT3) {
+		if ((res = i2c_bit_del_bus(&i810_ddc_adapter))) {
+			printk
+			    ("i2c-i810.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		}
+	}
+	if (i810i2c_initialized & INIT2) {
+		if ((res = i2c_bit_del_bus(&i810_i2c_adapter))) {
+			printk
+			    ("i2c-i810.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		}
+	}
+	i810i2c_initialized = 0;
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>, Ralph Metzler <rjkm@thp.uni-koeln.de>, and Mark D. Studebaker <mdsxyz123@yahoo.com>");
+MODULE_DESCRIPTION("I810/I815 I2C/DDC driver");
+
+
+int init_module(void)
+{
+	return i2c_i810_init();
+}
+
+int cleanup_module(void)
+{
+	return i810i2c_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-isa.c	2002-05-20 01:53:42.000000000 -0400
@@ -0,0 +1,154 @@
+/*
+    i2c-isa.c - Part of lm_sensors, Linux kernel modules for hardware
+            monitoring
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
+/* This implements an i2c algorithm/adapter for ISA bus. Not that this is
+   on first sight very useful; almost no functionality is preserved.
+   Except that it makes writing drivers for chips which can be on both
+   the SMBus and the ISA bus very much easier. See lm78.c for an example
+   of this. */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+MODULE_LICENSE("GPL");
+
+static void isa_inc_use(struct i2c_adapter *adapter);
+static void isa_dec_use(struct i2c_adapter *adapter);
+static u32 isa_func(struct i2c_adapter *adapter);
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_isa_init(void);
+static int __init isa_cleanup(void);
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+/* This is the actual algorithm we define */
+static struct i2c_algorithm isa_algorithm = {
+	/* name */ "ISA bus algorithm",
+	/* id */ I2C_ALGO_ISA,
+	/* master_xfer */ NULL,
+	/* smbus_access */ NULL,
+	/* slave_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ &isa_func,
+};
+
+/* There can only be one... */
+static struct i2c_adapter isa_adapter = {
+	/* name */ "ISA main adapter",
+	/* id */ I2C_ALGO_ISA | I2C_HW_ISA,
+	/* algorithm */ &isa_algorithm,
+	/* algo_data */ NULL,
+	/* inc_use */ &isa_inc_use,
+	/* dec_use */ &isa_dec_use,
+	/* data */ NULL,
+	/* Other fields not initialized */
+};
+
+/* Used in isa_init/cleanup */
+static int __initdata isa_initialized;
+
+void isa_inc_use(struct i2c_adapter *adapter)
+{
+#ifdef MODULE
+	MOD_INC_USE_COUNT;
+#endif
+}
+
+void isa_dec_use(struct i2c_adapter *adapter)
+{
+#ifdef MODULE
+	MOD_DEC_USE_COUNT;
+#endif
+}
+
+/* We can't do a thing... */
+static u32 isa_func(struct i2c_adapter *adapter)
+{
+	return 0;
+}
+
+int __init i2c_isa_init(void)
+{
+	int res;
+	printk("i2c-isa.o version %s (%s)\n", LM_VERSION, LM_DATE);
+#ifdef DEBUG
+	if (isa_initialized) {
+		printk
+		    ("i2c-isa.o: Oops, isa_init called a second time!\n");
+		return -EBUSY;
+	}
+#endif
+	isa_initialized = 0;
+	if ((res = i2c_add_adapter(&isa_adapter))) {
+		printk("i2c-isa.o: Adapter registration failed, "
+		       "module i2c-isa.o is not inserted\n.");
+		isa_cleanup();
+		return res;
+	}
+	isa_initialized++;
+	printk("i2c-isa.o: ISA bus access for i2c modules initialized.\n");
+	return 0;
+}
+
+int __init isa_cleanup(void)
+{
+	int res;
+	if (isa_initialized >= 1) {
+		if ((res = i2c_del_adapter(&isa_adapter))) {
+			printk
+			    ("i2c-isa.o: Adapter deregistration failed, module not removed.\n");
+			return res;
+		} else
+			isa_initialized--;
+	}
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Frodo Looijaard <frodol@dds.nl>");
+MODULE_DESCRIPTION("ISA bus access through i2c");
+
+int init_module(void)
+{
+	return i2c_isa_init();
+}
+
+int cleanup_module(void)
+{
+	return isa_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-keywest.c	2002-05-20 01:54:12.000000000 -0400
@@ -0,0 +1,684 @@
+/*
+    i2c Support for Apple Keywest I2C Bus Controller
+
+    Copyright (c) 2001 Benjamin Herrenschmidt <benh@kernel.crashing.org>
+
+    Original work by
+    
+    Copyright (c) 2000 Philip Edelbrock <phil@stimpy.netroedge.com>
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
+
+    Changes:
+
+    2001/12/13 BenH	New implementation
+    2001/12/15 BenH	Add support for "byte" and "quick"
+                        transfers. Add i2c_xfer routine.
+
+    My understanding of the various modes supported by keywest are:
+
+     - Dumb mode : not implemented, probably direct tweaking of lines
+     - Standard mode : simple i2c transaction of type
+         S Addr R/W A Data A Data ... T
+     - Standard sub mode : combined 8 bit subaddr write with data read
+         S Addr R/W A SubAddr A Data A Data ... T
+     - Combined mode : Subaddress and Data sequences appended with no stop
+         S Addr R/W A SubAddr S Addr R/W A Data A Data ... T
+
+    Currently, this driver uses only Standard mode for i2c xfer, and
+    smbus byte & quick transfers ; and uses StandardSub mode for
+    other smbus transfers instead of combined as we need that for the
+    sound driver to be happy
+*/
+
+#include <linux/module.h>
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/ioport.h>
+#include <linux/pci.h>
+#include <linux/types.h>
+#include <linux/delay.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/mm.h>
+#include <linux/timer.h>
+#include <linux/spinlock.h>
+#include <linux/completion.h>
+#include <linux/sensors.h>
+
+#include <asm/io.h>
+#include <asm/prom.h>
+#include <asm/machdep.h>
+#include <asm/pmac_feature.h>
+
+#include "i2c-keywest.h"
+
+#undef POLLED_MODE
+
+#define DBG(x...) do {\
+	if (debug > 0) \
+		printk(KERN_DEBUG "KW:" x); \
+	} while(0)
+
+
+MODULE_AUTHOR("Benjamin Herrenschmidt <benh@kernel.crashing.org>");
+MODULE_DESCRIPTION("I2C driver for Apple's Keywest");
+MODULE_LICENSE("GPL");
+MODULE_PARM(probe, "i");
+MODULE_PARM(debug, "i");
+EXPORT_NO_SYMBOLS;
+
+int probe = 0;
+int debug = 0;
+
+static struct keywest_iface *ifaces = NULL;
+
+#ifdef POLLED_MODE
+/* This isn't fast, but will go once I implement interrupt with
+ * proper timeout
+ */
+static u8
+wait_interrupt(struct keywest_iface* iface)
+{
+	int i;
+	u8 isr;
+	
+	for (i = 0; i < POLL_TIMEOUT; i++) {
+		isr = read_reg(reg_isr) & KW_I2C_IRQ_MASK;
+		if (isr != 0)
+			return isr;
+		current->state = TASK_UNINTERRUPTIBLE;
+		schedule_timeout(1);
+	}
+	return isr;
+}
+#endif /* POLLED_MODE */
+
+
+static void
+do_stop(struct keywest_iface* iface, int result)
+{
+	write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_STOP);
+	iface->state = state_stop;
+	iface->result = result;
+}
+
+/* Main state machine for standard & standard sub mode */
+static void
+handle_interrupt(struct keywest_iface *iface, u8 isr)
+{
+	int ack;
+	
+	DBG("handle_interrupt(), got: %x, status: %x, state: %d\n",
+		isr, read_reg(reg_status), iface->state);
+	if (isr == 0 && iface->state != state_stop) {
+		do_stop(iface, -1);
+		return;
+	}
+	if (isr & KW_I2C_IRQ_STOP && iface->state != state_stop) {
+		iface->result = -1;
+		iface->state = state_stop;
+	}
+	switch(iface->state) {
+	case state_addr:
+		if (!(isr & KW_I2C_IRQ_ADDR)) {
+			do_stop(iface, -1);
+			break;
+		}
+		ack = read_reg(reg_status);
+		DBG("ack on set address: %x\n", ack);
+		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
+			do_stop(iface, -1);
+			break;
+		}
+		/* Handle rw "quick" mode */
+		if (iface->datalen == 0)
+			do_stop(iface, 0);
+		else if (iface->read_write == I2C_SMBUS_READ) {
+			iface->state = state_read;
+			if (iface->datalen > 1)
+				write_reg(reg_control, read_reg(reg_control)
+					| KW_I2C_CTL_AAK);
+		} else {
+			iface->state = state_write;
+			DBG("write byte: %x\n", *(iface->data));
+			write_reg(reg_data, *(iface->data++));
+			iface->datalen--;
+		}
+		
+		break;
+	case state_read:
+		if (!(isr & KW_I2C_IRQ_DATA)) {
+			do_stop(iface, -1);
+			break;
+		}
+		*(iface->data++) = read_reg(reg_data);
+		DBG("read byte: %x\n", *(iface->data-1));
+		iface->datalen--;
+		if (iface->datalen == 0)
+			iface->state = state_stop;
+		else
+			write_reg(reg_control, 0);
+		break;
+	case state_write:
+		if (!(isr & KW_I2C_IRQ_DATA)) {
+			do_stop(iface, -1);
+			break;
+		}
+		/* Check ack status */
+		ack = read_reg(reg_status);
+		DBG("ack on data write: %x\n", ack);
+		if ((ack & KW_I2C_STAT_LAST_AAK) == 0) {
+			do_stop(iface, -1);
+			break;
+		}
+		if (iface->datalen) {
+			DBG("write byte: %x\n", *(iface->data));
+			write_reg(reg_data, *(iface->data++));
+			iface->datalen--;
+		} else
+			do_stop(iface, 0);
+		break;
+		
+	case state_stop:
+		if (!(isr & KW_I2C_IRQ_STOP) && (++iface->stopretry) < 10)
+			do_stop(iface, -1);
+		else {
+			iface->state = state_idle;
+			write_reg(reg_control, 0x00);
+			write_reg(reg_ier, 0x00);
+#ifndef POLLED_MODE
+			complete(&iface->complete);
+#endif /* POLLED_MODE */			
+		}
+		break;
+	}
+	
+	write_reg(reg_isr, isr);
+}
+
+#ifndef POLLED_MODE
+
+/* Interrupt handler */
+static void
+keywest_irq(int irq, void *dev_id, struct pt_regs *regs)
+{
+	struct keywest_iface *iface = (struct keywest_iface *)dev_id;
+
+	spin_lock(&iface->lock);
+	del_timer(&iface->timeout_timer);
+	handle_interrupt(iface, read_reg(reg_isr));
+	if (iface->state != state_idle) {
+		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
+		add_timer(&iface->timeout_timer);
+	}
+	spin_unlock(&iface->lock);
+}
+
+static void
+keywest_timeout(unsigned long data)
+{
+	struct keywest_iface *iface = (struct keywest_iface *)data;
+
+	DBG("timeout !\n");
+	spin_lock_irq(&iface->lock);
+	handle_interrupt(iface, read_reg(reg_isr));
+	if (iface->state != state_idle) {
+		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
+		add_timer(&iface->timeout_timer);
+	}
+	spin_unlock(&iface->lock);
+}
+
+#endif /* POLLED_MODE */
+
+/*
+ * SMBUS-type transfer entrypoint
+ */
+static s32
+keywest_smbus_xfer(	struct i2c_adapter*	adap,
+			u16			addr,
+			unsigned short		flags,
+			char			read_write,
+			u8			command,
+			int			size,
+			union i2c_smbus_data*	data)
+{
+	struct keywest_chan* chan = (struct keywest_chan*)adap->data;
+	struct keywest_iface* iface = chan->iface;
+	int len;
+	u8* buffer;
+	u16 cur_word;
+	int rc = 0;
+
+	if (iface->state == state_dead)
+		return -1;
+		
+	/* Prepare datas & select mode */
+	iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
+	switch (size) {
+	    case I2C_SMBUS_QUICK:
+	    	len = 0;
+	    	buffer = NULL;
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARD;
+	    	break;
+	    case I2C_SMBUS_BYTE:
+	    	len = 1;
+	    	buffer = &data->byte;
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARD;
+	    	break;
+	    case I2C_SMBUS_BYTE_DATA:
+	    	len = 1;
+	    	buffer = &data->byte;
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+	    	//iface->cur_mode |= KW_I2C_MODE_COMBINED;
+	    	break;
+	    case I2C_SMBUS_WORD_DATA:
+	    	len = 2;
+	    	cur_word = cpu_to_le16(data->word);
+	    	buffer = (u8 *)&cur_word;
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+	    	//iface->cur_mode |= KW_I2C_MODE_COMBINED;
+		break;
+	    case I2C_SMBUS_BLOCK_DATA:
+	    	len = data->block[0];
+	    	buffer = &data->block[1];
+	    	iface->cur_mode |= KW_I2C_MODE_STANDARDSUB;
+	    	//iface->cur_mode |= KW_I2C_MODE_COMBINED;
+		break;
+	    default:
+	    	return -1;
+	}
+
+	/* Original driver had this limitation */
+	if (len > 32)
+		len = 32;
+
+	down(&iface->sem);
+
+	DBG("chan: %d, addr: 0x%x, transfer len: %d, read: %d\n",
+		chan->chan_no, addr, len, read_write == I2C_SMBUS_READ);
+
+	iface->data = buffer;
+	iface->datalen = len;
+	iface->state = state_addr;
+	iface->result = 0;
+	iface->stopretry = 0;
+	iface->read_write = read_write;
+	
+	/* Setup channel & clear pending irqs */
+	write_reg(reg_mode, iface->cur_mode | (chan->chan_no << 4));
+	write_reg(reg_isr, read_reg(reg_isr));
+	write_reg(reg_status, 0);
+
+	/* Set up address and r/w bit */
+	write_reg(reg_addr,
+		(addr << 1) | ((read_write == I2C_SMBUS_READ) ? 0x01 : 0x00));
+
+	/* Set up the sub address */
+	if ((iface->cur_mode & KW_I2C_MODE_MODE_MASK) == KW_I2C_MODE_STANDARDSUB
+	    || (iface->cur_mode & KW_I2C_MODE_MODE_MASK) == KW_I2C_MODE_COMBINED)
+		write_reg(reg_subaddr, command);
+
+	/* Arm timeout */
+	iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
+	add_timer(&iface->timeout_timer);
+
+	/* Start sending address & enable interrupt*/
+	write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
+	write_reg(reg_ier, KW_I2C_IRQ_MASK);
+
+#ifdef POLLED_MODE
+	DBG("using polled mode...\n");
+	/* State machine, to turn into an interrupt handler */
+	while(iface->state != state_idle) {
+		u8 isr = wait_interrupt(iface);
+		handle_interrupt(iface, isr);
+	}
+#else /* POLLED_MODE */
+	DBG("using interrupt mode...\n");
+	wait_for_completion(&iface->complete);	
+#endif /* POLLED_MODE */	
+
+	rc = iface->result;	
+	DBG("transfer done, result: %d\n", rc);
+
+	if (rc == 0 && size == I2C_SMBUS_WORD_DATA && read_write == I2C_SMBUS_READ)
+	    	data->word = le16_to_cpu(cur_word);
+	
+	/* Release sem */
+	up(&iface->sem);
+	
+	return rc;
+}
+
+/*
+ * Generic i2c master transfer entrypoint
+ */
+static int
+keywest_xfer(	struct i2c_adapter *adap,
+		struct i2c_msg msgs[], 
+		int num)
+{
+	struct keywest_chan* chan = (struct keywest_chan*)adap->data;
+	struct keywest_iface* iface = chan->iface;
+	struct i2c_msg *pmsg;
+	int i, completed;
+	int rc = 0;
+
+	down(&iface->sem);
+
+	/* Set adapter to standard mode */
+	iface->cur_mode &= ~KW_I2C_MODE_MODE_MASK;
+	iface->cur_mode |= KW_I2C_MODE_STANDARD;
+
+	completed = 0;
+	for (i = 0; rc >= 0 && i < num;) {
+		u8 addr;
+		
+		pmsg = &msgs[i++];
+		addr = pmsg->addr;
+		if (pmsg->flags & I2C_M_TEN) {
+			printk(KERN_ERR "i2c-keywest: 10 bits addr not supported !\n");
+			rc = -EINVAL;
+			break;
+		}
+		DBG("xfer: chan: %d, doing %s %d bytes to 0x%02x - %d of %d messages\n",
+		     chan->chan_no,
+		     pmsg->flags & I2C_M_RD ? "read" : "write",
+                     pmsg->len, addr, i, num);
+    
+		/* Setup channel & clear pending irqs */
+		write_reg(reg_mode, iface->cur_mode | (chan->chan_no << 4));
+		write_reg(reg_isr, read_reg(reg_isr));
+		write_reg(reg_status, 0);
+		
+		iface->data = pmsg->buf;
+		iface->datalen = pmsg->len;
+		iface->state = state_addr;
+		iface->result = 0;
+		iface->stopretry = 0;
+		if (pmsg->flags & I2C_M_RD)
+			iface->read_write = I2C_SMBUS_READ;
+		else
+			iface->read_write = I2C_SMBUS_WRITE;
+
+		/* Set up address and r/w bit */
+		if (pmsg->flags & I2C_M_REV_DIR_ADDR)
+			addr ^= 1;		
+		write_reg(reg_addr,
+			(addr << 1) |
+			((iface->read_write == I2C_SMBUS_READ) ? 0x01 : 0x00));
+
+		/* Arm timeout */
+		iface->timeout_timer.expires = jiffies + POLL_TIMEOUT;
+		add_timer(&iface->timeout_timer);
+
+		/* Start sending address & enable interrupt*/
+		write_reg(reg_control, read_reg(reg_control) | KW_I2C_CTL_XADDR);
+		write_reg(reg_ier, KW_I2C_IRQ_MASK);
+
+#ifdef POLLED_MODE
+		DBG("using polled mode...\n");
+		/* State machine, to turn into an interrupt handler */
+		while(iface->state != state_idle) {
+			u8 isr = wait_interrupt(iface);
+			handle_interrupt(iface, isr);
+		}
+#else /* POLLED_MODE */88
+		DBG("using interrupt mode...\n");
+		wait_for_completion(&iface->complete);	
+#endif /* POLLED_MODE */	
+
+		rc = iface->result;
+		if (rc == 0)
+			completed++;
+		DBG("transfer done, result: %d\n", rc);
+	}
+
+	/* Release sem */
+	up(&iface->sem);
+
+	return completed;
+}
+
+static u32
+keywest_func(struct i2c_adapter * adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	       I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	       I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+static void
+keywest_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void
+keywest_dec(struct i2c_adapter *adapter)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+/* For now, we only handle combined mode (smbus) */
+static struct i2c_algorithm keywest_algorithm = {
+	name:		"Keywest i2c",
+	id:		I2C_ALGO_SMBUS,
+	smbus_xfer:	keywest_smbus_xfer,
+	master_xfer:	keywest_xfer,
+	functionality:	keywest_func,
+};
+
+
+static int
+create_iface(struct device_node* np)
+{
+	unsigned long steps, *psteps, *prate;
+	unsigned bsteps, tsize, i, nchan, addroffset;
+	struct keywest_iface* iface;
+	int rc;
+
+	psteps = (unsigned long *)get_property(np, "AAPL,address-step", NULL);
+	steps = psteps ? (*psteps) : 0x10;
+
+	/* Hrm... maybe we can be smarter here */
+	for (bsteps = 0; (steps & 0x01) == 0; bsteps++)
+		steps >>= 1;
+
+	if (!strcmp(np->parent->name, "uni-n")) {
+		nchan = 2;
+		addroffset = 3;
+	} else {
+		addroffset = 0;
+		nchan = 1;
+	}
+
+	tsize = sizeof(struct keywest_iface) +
+		(sizeof(struct keywest_chan) + 4) * nchan;
+	iface = (struct keywest_iface *) kmalloc(tsize, GFP_KERNEL);
+	if (iface == NULL) {
+		printk(KERN_ERR "i2c-keywest: can't allocate inteface !\n");
+		return -ENOMEM;
+	}
+	memset(iface, 0, tsize);
+	init_MUTEX(&iface->sem);
+	spin_lock_init(&iface->lock);
+	init_completion(&iface->complete);
+	iface->bsteps = bsteps;
+	iface->chan_count = nchan;
+	iface->state = state_idle;
+	iface->irq = np->intrs[0].line;
+	iface->channels = (struct keywest_chan *)
+		(((unsigned long)(iface + 1) + 3UL) & ~3UL);
+	iface->base = (unsigned long)ioremap(np->addrs[0].address + addroffset,
+						np->addrs[0].size);
+	if (iface->base == 0) {
+		printk(KERN_ERR "i2c-keywest: can't map inteface !\n");
+		kfree(iface);
+		return -ENOMEM;
+	}
+
+	init_timer(&iface->timeout_timer);
+	iface->timeout_timer.function = keywest_timeout;
+	iface->timeout_timer.data = (unsigned long)iface;
+
+	/* Select interface rate */
+	iface->cur_mode = KW_I2C_MODE_100KHZ;
+	prate = (unsigned long *)get_property(np, "AAPL,i2c-rate", NULL);
+	if (prate) switch(*prate) {
+	case 100:
+		iface->cur_mode = KW_I2C_MODE_100KHZ;
+		break;
+	case 50:
+		iface->cur_mode = KW_I2C_MODE_50KHZ;
+		break;
+	case 25:
+		iface->cur_mode = KW_I2C_MODE_25KHZ;
+		break;
+	default:
+		printk(KERN_WARNING "i2c-keywest: unknown rate %ldKhz, using 100KHz\n",
+			*prate);
+	}
+	
+	/* Select standard mode by default */
+	iface->cur_mode |= KW_I2C_MODE_STANDARD;
+	
+	/* Write mode */
+	write_reg(reg_mode, iface->cur_mode);
+	
+	/* Switch interrupts off & clear them*/
+	write_reg(reg_ier, 0x00);
+	write_reg(reg_isr, KW_I2C_IRQ_MASK);
+
+#ifndef POLLED_MODE
+	/* Request chip interrupt */	
+	rc = request_irq(iface->irq, keywest_irq, 0, "keywest i2c", iface);
+	if (rc) {
+		printk(KERN_ERR "i2c-keywest: can't get IRQ %d !\n", iface->irq);
+		iounmap((void *)iface->base);
+		kfree(iface);
+		return -ENODEV;
+	}
+#endif /* POLLED_MODE */
+
+	for (i=0; i<nchan; i++) {
+		struct keywest_chan* chan = &iface->channels[i];
+		u8 addr;
+		
+		sprintf(chan->adapter.name, "%s %d", np->parent->name, i);
+		chan->iface = iface;
+		chan->chan_no = i;
+		chan->adapter.id = I2C_ALGO_SMBUS;
+		chan->adapter.algo = &keywest_algorithm;
+		chan->adapter.algo_data = NULL;
+		chan->adapter.inc_use = keywest_inc;
+		chan->adapter.dec_use = keywest_dec;
+		chan->adapter.client_register = NULL;
+		chan->adapter.client_unregister = NULL;
+		chan->adapter.data = chan;
+
+		rc = i2c_add_adapter(&chan->adapter);
+		if (rc) {
+			printk("i2c-keywest.c: Adapter %s registration failed\n",
+				chan->adapter.name);
+			chan->adapter.data = NULL;
+		}
+		if (probe) {
+			printk("Probe: ");
+			for (addr = 0x00; addr <= 0x7f; addr++) {
+				if (i2c_smbus_xfer(&chan->adapter,addr,
+				    0,0,0,I2C_SMBUS_QUICK,NULL) >= 0)
+					printk("%02x ", addr);
+			}
+			printk("\n");
+		}
+	}
+
+	printk(KERN_INFO "Found KeyWest i2c on \"%s\", %d channel%s, stepping: %d bits\n",
+		np->parent->name, nchan, nchan > 1 ? "s" : "", bsteps);
+		
+	iface->next = ifaces;
+	ifaces = iface;
+	return 0;
+}
+
+static void
+dispose_iface(struct keywest_iface *iface)
+{
+	int i, rc;
+	
+	ifaces = iface->next;
+
+	/* Make sure we stop all activity */
+	down(&iface->sem);
+#ifndef POLLED_MODE
+	spin_lock_irq(&iface->lock);
+	while (iface->state != state_idle) {
+		spin_unlock_irq(&iface->lock);
+		schedule();
+		spin_lock_irq(&iface->lock);
+	}
+#endif /* POLLED_MODE */
+	iface->state = state_dead;
+#ifndef POLLED_MODE
+	spin_unlock_irq(&iface->lock);
+	free_irq(iface->irq, iface);
+#endif /* POLLED_MODE */
+	up(&iface->sem);
+
+	/* Release all channels */
+	for (i=0; i<iface->chan_count; i++) {
+		struct keywest_chan* chan = &iface->channels[i];
+		if (!chan->adapter.data)
+			continue;
+		rc = i2c_del_adapter(&chan->adapter);
+		chan->adapter.data = NULL;
+		/* We aren't that prepared to deal with this... */
+		if (rc)
+			printk("i2c-keywest.c: i2c_del_adapter failed, that's bad !\n");
+	}
+	iounmap((void *)iface->base);
+	kfree(iface);
+}
+
+static int __init
+i2c_keywest_init(void)
+{
+	struct device_node *np;
+	int rc = -ENODEV;
+	
+	np = find_compatible_devices("i2c", "keywest");
+	while (np != 0) {
+		if (np->n_addrs >= 1 && np->n_intrs >= 1)
+			rc = create_iface(np);
+		np = np->next;
+	}
+	if (ifaces)
+		rc = 0;
+	return rc;
+}
+
+static void __exit
+i2c_keywest_cleanup(void)
+{
+	while(ifaces)
+		dispose_iface(ifaces);
+}
+
+module_init(i2c_keywest_init);
+module_exit(i2c_keywest_cleanup);
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-keywest.h	2002-05-19 18:50:16.000000000 -0400
@@ -0,0 +1,111 @@
+#ifndef __I2C_KEYWEST_H__
+#define __I2C_KEYWEST_H__
+
+/* The Tumbler audio equalizer can be really slow sometimes */
+#define POLL_TIMEOUT		(2*HZ)
+
+/* Register indices */
+typedef enum {
+	reg_mode = 0,
+	reg_control,
+	reg_status,
+	reg_isr,
+	reg_ier,
+	reg_addr,
+	reg_subaddr,
+	reg_data
+} reg_t;
+
+
+/* Mode register */
+#define KW_I2C_MODE_100KHZ	0x00
+#define KW_I2C_MODE_50KHZ	0x01
+#define KW_I2C_MODE_25KHZ	0x02
+#define KW_I2C_MODE_DUMB	0x00
+#define KW_I2C_MODE_STANDARD	0x04
+#define KW_I2C_MODE_STANDARDSUB	0x08
+#define KW_I2C_MODE_COMBINED	0x0C
+#define KW_I2C_MODE_MODE_MASK	0x0C
+#define KW_I2C_MODE_CHAN_MASK	0xF0
+
+/* Control register */
+#define KW_I2C_CTL_AAK		0x01
+#define KW_I2C_CTL_XADDR	0x02
+#define KW_I2C_CTL_STOP		0x04
+#define KW_I2C_CTL_START	0x08
+
+/* Status register */
+#define KW_I2C_STAT_BUSY	0x01
+#define KW_I2C_STAT_LAST_AAK	0x02
+#define KW_I2C_STAT_LAST_RW	0x04
+#define KW_I2C_STAT_SDA		0x08
+#define KW_I2C_STAT_SCL		0x10
+
+/* IER & ISR registers */
+#define KW_I2C_IRQ_DATA		0x01
+#define KW_I2C_IRQ_ADDR		0x02
+#define KW_I2C_IRQ_STOP		0x04
+#define KW_I2C_IRQ_START	0x08
+#define KW_I2C_IRQ_MASK		0x0F
+
+/* Physical interface */
+struct keywest_iface
+{
+	unsigned long		base;
+	unsigned		bsteps;
+	int			irq;
+	struct semaphore	sem;
+	spinlock_t		lock;
+	struct keywest_chan*	channels;
+	unsigned		chan_count;
+	u8			cur_mode;
+	char			read_write;
+	u8*			data;
+	unsigned		datalen;
+	int			state;
+	int			result;
+	int			stopretry;
+	struct timer_list	timeout_timer;
+	struct completion	complete;
+	struct keywest_iface*	next;
+};
+
+enum {
+	state_idle,
+	state_addr,
+	state_read,
+	state_write,
+	state_stop,
+	state_dead
+};
+
+/* Channel on an interface */
+struct keywest_chan
+{
+	struct i2c_adapter	adapter;
+	struct keywest_iface*	iface;
+	unsigned		chan_no;
+};
+
+/* Register access */
+
+static inline u8 __read_reg(struct keywest_iface *iface, reg_t reg)
+{
+	return in_8(((volatile u8 *)iface->base)
+		+ (((unsigned)reg) << iface->bsteps));
+}
+
+static inline void __write_reg(struct keywest_iface *iface, reg_t reg, u8 val)
+{
+	out_8(((volatile u8 *)iface->base)
+		+ (((unsigned)reg) << iface->bsteps), val);
+	(void)__read_reg(iface, reg);
+	udelay(10);
+}
+
+#define write_reg(reg, val)	__write_reg(iface, reg, val) 
+#define read_reg(reg)		__read_reg(iface, reg) 
+
+
+
+#endif /* __I2C_KEYWEST_H__ */

--------------60B104FA1A8CA828FCC8615D--

