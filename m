Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318512AbSGSOFC>; Fri, 19 Jul 2002 10:05:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318523AbSGSOFB>; Fri, 19 Jul 2002 10:05:01 -0400
Received: from sccrmhc02.attbi.com ([204.127.202.62]:14785 "EHLO
	sccrmhc02.attbi.com") by vger.kernel.org with ESMTP
	id <S318512AbSGSODO>; Fri, 19 Jul 2002 10:03:14 -0400
Message-ID: <3D381CD1.6A0B9909@bellsouth.net>
Date: Fri, 19 Jul 2002 10:06:09 -0400
From: Albert Cranford <ac9410@bellsouth.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-rc2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: [patch 2/9] 2.5.6 lm_sensors
Content-Type: multipart/mixed;
 boundary="------------F719D3046F0AADF220F310D3"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------F719D3046F0AADF220F310D3
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
--------------F719D3046F0AADF220F310D3
Content-Type: text/plain; charset=iso-8859-1;
 name="2.5.26-busses-a-patch"
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="2.5.26-busses-a-patch"

--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-ali1535.c	2002-05-20 01:51:45.000000000 -0400
@@ -0,0 +1,687 @@
+/*
+    i2c-ali1535.c - Part of lm_sensors, Linux kernel modules for hardware
+                    monitoring
+    Copyright (c) 2000  Frodo Looijaard <frodol@dds.nl>, 
+                        Philip Edelbrock <phil@netroedge.com>, 
+                        Mark D. Studebaker <mdsxyz123@yahoo.com>,
+                        Dan Eaton <dan.eaton@rocketlogix.com> and 
+                        Stephen Rousset<stephen.rousset@rocketlogix.com> 
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
+    This is the driver for the SMB Host controller on
+    Acer Labs Inc. (ALI) M1535 South Bridge.
+
+    The M1535 is a South bridge for portable systems.
+    It is very similar to the M15x3 South bridges also produced
+    by Acer Labs Inc.  Some of the registers within the part
+    have moved and some have been redefined slightly. Additionally,
+    the sequencing of the SMBus transactions has been modified
+    to be more consistent with the sequencing recommended by
+    the manufacturer and observed through testing.  These
+    changes are reflected in this driver and can be identified
+    by comparing this driver to the i2c-ali15x3 driver.
+    For an overview of these chips see http://www.acerlabs.com
+
+    The SMB controller is part of the 7101 device, which is an
+    ACPI-compliant Power Management Unit (PMU).
+
+    The whole 7101 device has to be enabled for the SMB to work.
+    You can't just enable the SMB alone.
+    The SMB and the ACPI have separate I/O spaces.
+    We make sure that the SMB is enabled. We leave the ACPI alone.
+
+    This driver controls the SMB Host only.
+
+    This driver does not use interrupts.
+*/
+
+
+/* Note: we assume there can only be one ALI1535, with one SMBus interface */
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <asm/semaphore.h>
+#include <linux/kernel.h>
+#include <linux/stddef.h>
+#include <linux/ioport.h>
+#include <linux/i2c.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+MODULE_LICENSE("GPL");
+
+#ifndef DECLARE_MUTEX
+#define DECLARE_MUTEX(name)  struct semaphore name = MUTEX
+#endif /* def DECLARE_MUTEX */
+
+/* ALI1535 SMBus address offsets */
+#define SMBHSTSTS (0 + ali1535_smba)
+#define SMBHSTTYP (1 + ali1535_smba)
+#define SMBHSTPORT (2 + ali1535_smba)
+#define SMBHSTCMD (7 + ali1535_smba)
+#define SMBHSTADD (3 + ali1535_smba)
+#define SMBHSTDAT0 (4 + ali1535_smba)
+#define SMBHSTDAT1 (5 + ali1535_smba)
+#define SMBBLKDAT (6 + ali1535_smba)
+
+/* PCI Address Constants */
+#define SMBCOM    0x004
+#define SMBREV    0x008
+#define SMBCFG    0x0D1
+#define SMBBA     0x0E2
+#define SMBHSTCFG 0x0F0
+#define SMBCLK    0x0F2
+
+/* Other settings */
+#define MAX_TIMEOUT 500		/* times 1/100 sec */
+#define ALI1535_SMB_IOSIZE 32
+
+/* 
+*/
+#define ALI1535_SMB_DEFAULTBASE 0x8040
+
+/* ALI1535 address lock bits */
+#define ALI1535_LOCK	0x06 < dwe >
+
+/* ALI1535 command constants */
+#define ALI1535_QUICK      0x00
+#define ALI1535_BYTE       0x10
+#define ALI1535_BYTE_DATA  0x20
+#define ALI1535_WORD_DATA  0x30
+#define ALI1535_BLOCK_DATA 0x40
+#define ALI1535_I2C_READ   0x60
+
+#define	ALI1535_DEV10B_EN	0x80	/* Enable 10-bit addressing in */
+                                        /*  I2C read                   */
+#define	ALI1535_T_OUT		0x08	/* Time-out Command (write)    */
+#define	ALI1535_A_HIGH_BIT9	0x08	/* Bit 9 of 10-bit address in  */
+                                        /* Alert-Response-Address      */
+                                        /* (read)                      */
+#define	ALI1535_KILL		0x04	/* Kill Command (write)        */
+#define	ALI1535_A_HIGH_BIT8	0x04	/* Bit 8 of 10-bit address in  */
+                                        /*  Alert-Response-Address     */
+                                        /*  (read)                     */
+
+#define	ALI1535_D_HI_MASK	0x03	/* Mask for isolating bits 9-8 */
+                                        /*  of 10-bit address in I2C   */ 
+                                        /*  Read Command               */
+
+/* ALI1535 status register bits */
+#define ALI1535_STS_IDLE	0x04
+#define ALI1535_STS_BUSY	0x08	/* host busy */
+#define ALI1535_STS_DONE	0x10	/* transaction complete */
+#define ALI1535_STS_DEV		0x20	/* device error */
+#define ALI1535_STS_BUSERR	0x40	/* bus error    */
+#define ALI1535_STS_FAIL	0x80    /* failed bus transaction */
+#define ALI1535_STS_ERR		0xE0	/* all the bad error bits */
+
+#define ALI1535_BLOCK_CLR	0x04	/* reset block data index */
+
+/* ALI1535 device address register bits */
+#define	ALI1535_RD_ADDR		0x01	/* Read/Write Bit in Device    */
+                                        /*  Address field              */
+                                        /*  -> Write = 0               */
+                                        /*  -> Read  = 1               */
+#define	ALI1535_SMBIO_EN	0x04	/* SMB I/O Space enable        */
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_ali1535_init(void);
+static int __init ali1535_cleanup(void);
+static int ali1535_setup(void);
+static s32 ali1535_access(struct i2c_adapter *adap, u16 addr,
+			  unsigned short flags, char read_write,
+			  u8 command, int size,
+			  union i2c_smbus_data *data);
+static void ali1535_do_pause(unsigned int amount);
+static int ali1535_transaction(void);
+static void ali1535_inc(struct i2c_adapter *adapter);
+static void ali1535_dec(struct i2c_adapter *adapter);
+static u32 ali1535_func(struct i2c_adapter *adapter);
+
+#ifdef MODULE
+extern int init_module(void);
+extern int cleanup_module(void);
+#endif				/* MODULE */
+
+static struct i2c_algorithm smbus_algorithm = {
+	/* name */ "Non-i2c SMBus adapter",
+	/* id */ I2C_ALGO_SMBUS,
+	/* master_xfer */ NULL, 
+	/* smbus_access */ ali1535_access,
+	/* slave_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ ali1535_func,
+};
+
+static struct i2c_adapter ali1535_adapter = {
+	"unset",
+	I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI1535,
+	&smbus_algorithm,
+	NULL,
+	ali1535_inc,
+	ali1535_dec,
+	NULL,
+	NULL,
+};
+
+static int __initdata ali1535_initialized;
+static unsigned short ali1535_smba = 0;
+DECLARE_MUTEX(i2c_ali1535_sem);
+
+
+/* Detect whether a ALI1535 can be found, and initialize it, where necessary.
+   Note the differences between kernels with the old PCI BIOS interface and
+   newer kernels with the real PCI interface. In compat.h some things are
+   defined to make the transition easier. */
+int ali1535_setup(void)
+{
+	int error_return = 0;
+	unsigned char temp;
+
+	struct pci_dev *ALI1535_dev;
+
+	/* First check whether we can access PCI at all */
+	if (pci_present() == 0) {
+		printk("i2c-ali1535.o: Error: No PCI-bus found!\n");
+		error_return = -ENODEV;
+		goto END;
+	}
+
+	/* Look for the ALI1535, M7101 device */
+	ALI1535_dev = NULL;
+	ALI1535_dev = pci_find_device(PCI_VENDOR_ID_AL,
+				      PCI_DEVICE_ID_AL_M7101, 
+				      ALI1535_dev); 
+
+	if (ALI1535_dev == NULL) {
+		printk("i2c-ali1535.o: Error: Can't detect ali1535!\n");
+		error_return = -ENODEV;
+		goto END;
+	}
+
+/* Check the following things:
+	- SMB I/O address is initialized
+	- Device is enabled
+	- We can use the addresses
+*/
+
+/* Determine the address of the SMBus area */
+	pci_read_config_word(ALI1535_dev, SMBBA, &ali1535_smba);
+	ali1535_smba &= (0xffff & ~(ALI1535_SMB_IOSIZE - 1));
+	if (ali1535_smba == 0) {
+		printk
+		    ("i2c-ali1535.o: ALI1535_smb region uninitialized - upgrade BIOS?\n");
+		error_return = -ENODEV;
+	}
+
+	if (error_return == -ENODEV)
+		goto END;
+
+	if (check_region(ali1535_smba, ALI1535_SMB_IOSIZE)) {
+		printk
+		    ("i2c-ali1535.o: ALI1535_smb region 0x%x already in use!\n",
+		     ali1535_smba);
+		error_return = -ENODEV;
+	}
+
+	if (error_return == -ENODEV)
+		goto END;
+
+	/* check if whole device is enabled */
+	pci_read_config_byte(ALI1535_dev, SMBCFG, &temp);
+	if ((temp & ALI1535_SMBIO_EN) == 0) {
+		printk
+		    ("i2c-ali1535.o: SMB device not enabled - upgrade BIOS?\n");
+		error_return = -ENODEV;
+		goto END;
+	}
+
+/* Is SMB Host controller enabled? */
+	pci_read_config_byte(ALI1535_dev, SMBHSTCFG, &temp);
+	if ((temp & 1) == 0) {
+		printk
+		    ("i2c-ali1535.o: SMBus controller not enabled - upgrade BIOS?\n");
+		error_return = -ENODEV;
+		goto END;
+	}
+
+/* set SMB clock to 74KHz as recommended in data sheet */
+	pci_write_config_byte(ALI1535_dev, SMBCLK, 0x20);
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(ali1535_smba, ALI1535_SMB_IOSIZE, "ali1535-smb");
+
+#ifdef DEBUG
+/*
+  The interrupt routing for SMB is set up in register 0x77 in the
+  1533 ISA Bridge device, NOT in the 7101 device.
+  Don't bother with finding the 1533 device and reading the register.
+  if ((....... & 0x0F) == 1)
+     printk("i2c-ali1535.o: ALI1535 using Interrupt 9 for SMBus.\n");
+*/
+	pci_read_config_byte(ALI1535_dev, SMBREV, &temp);
+	printk("i2c-ali1535.o: SMBREV = 0x%X\n", temp);
+	printk("i2c-ali1535.o: ALI1535_smba = 0x%X\n", ali1535_smba);
+#endif				/* DEBUG */
+
+      END:
+	return error_return;
+}
+
+
+/* Internally used pause function */
+void ali1535_do_pause(unsigned int amount)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+/* Another internally used function */
+int ali1535_transaction(void)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+#ifdef DEBUG
+	printk
+	    ("i2c-ali1535.o: Transaction (pre): STS=%02x, TYP=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
+	     "DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTTYP),
+	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+	     inb_p(SMBHSTDAT1));
+#endif
+
+	/* get status */
+	temp = inb_p(SMBHSTSTS);
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	/* Check the busy bit first */
+	if (temp & ALI1535_STS_BUSY) {
+/*
+   If the host controller is still busy, it may have timed out in the previous transaction,
+   resulting in a "SMBus Timeout" printk.
+   I've tried the following to reset a stuck busy bit.
+	1. Reset the controller with an KILL command.
+	   (this doesn't seem to clear the controller if an external device is hung)
+	2. Reset the controller and the other SMBus devices with a T_OUT command.
+	   (this clears the host busy bit if an external device is hung,
+	   but it comes back upon a new access to a device)
+	3. Disable and reenable the controller in SMBHSTCFG
+   Worst case, nothing seems to work except power reset.
+*/
+/* Abort - reset the host controller */
+/*
+#ifdef DEBUG
+    printk("i2c-ali1535.o: Resetting host controller to clear busy condition\n",temp);
+#endif
+    outb_p(ALI1535_KILL, SMBHSTTYP);
+    temp = inb_p(SMBHSTSTS);
+    if (temp & ALI1535_STS_BUSY) {
+*/
+
+/*
+   Try resetting entire SMB bus, including other devices -
+   This may not work either - it clears the BUSY bit but
+   then the BUSY bit may come back on when you try and use the chip again.
+   If that's the case you are stuck.
+*/
+		printk
+		    ("i2c-ali1535.o: Resetting entire SMB Bus to clear busy condition (%02x)\n",
+		     temp);
+		outb_p(ALI1535_T_OUT, SMBHSTTYP);
+		temp = inb_p(SMBHSTSTS);
+	}
+/*
+  }
+*/
+
+	/* now check the error bits and the busy bit */
+	if (temp & (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
+		/* do a clear-on-write */
+		outb_p(0xFF, SMBHSTSTS);
+		if ((temp = inb_p(SMBHSTSTS)) &
+		    (ALI1535_STS_ERR | ALI1535_STS_BUSY)) {
+			/* this is probably going to be correctable only by a power reset
+			   as one of the bits now appears to be stuck */
+			/* This may be a bus or device with electrical problems. */
+			printk
+			    ("i2c-ali1535.o: SMBus reset failed! (0x%02x) - controller or device on bus is probably hung\n",
+			     temp);
+			return -1;
+		}
+	} else {
+		/* check and clear done bit */
+		if (temp & ALI1535_STS_DONE) {
+			outb_p(temp, SMBHSTSTS);
+		}
+	}
+
+	/* start the transaction by writing anything to the start register */
+	outb_p(0xFF, SMBHSTPORT);
+
+	/* We will always wait for a fraction of a second! */
+	timeout = 0;
+	do {
+		ali1535_do_pause(1);
+		temp = inb_p(SMBHSTSTS);
+	} while (((temp & ALI1535_STS_BUSY) && !(temp & ALI1535_STS_IDLE))
+		 && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+		result = -1;
+		printk("i2c-ali1535.o: SMBus Timeout!\n");
+	}
+
+	if (temp & ALI1535_STS_FAIL) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-ali1535.o: Error: Failed bus transaction\n");
+#endif
+	}
+
+/*
+  Unfortunately the ALI SMB controller maps "no response" and "bus collision"
+  into a single bit. No reponse is the usual case so don't do a printk.
+  This means that bus collisions go unreported.
+*/
+	if (temp & ALI1535_STS_BUSERR) {
+		result = -1;
+#ifdef DEBUG
+		printk
+		    ("i2c-ali1535.o: Error: no response or bus collision ADD=%02x\n",
+		     inb_p(SMBHSTADD));
+#endif
+	}
+
+/* haven't ever seen this */
+	if (temp & ALI1535_STS_DEV) {
+		result = -1;
+		printk("i2c-ali1535.o: Error: device error\n");
+	}
+
+/* 
+   check to see if the "command complete" indication is set
+ */
+	if (!(temp & ALI1535_STS_DONE)) {
+		result = -1;
+		printk("i2c-ali1535.o: Error: command never completed\n");
+	}
+#ifdef DEBUG
+	printk
+	    ("i2c-ali1535.o: Transaction (post): STS=%02x, TYP=%02x, CMD=%02x, ADD=%02x, "
+	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTTYP),
+	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+	     inb_p(SMBHSTDAT1));
+#endif
+
+/* 
+    take consequent actions for error conditions
+ */
+        if (!(temp & ALI1535_STS_DONE)) {
+	  /* issue "kill" to reset host controller */
+	  outb_p(ALI1535_KILL,SMBHSTTYP);
+	  outb_p(0xFF,SMBHSTSTS);
+	}	  
+	else if (temp & ALI1535_STS_ERR) {
+	  /* issue "timeout" to reset all devices on bus */
+	  outb_p(ALI1535_T_OUT,SMBHSTTYP);
+	  outb_p(0xFF,SMBHSTSTS);
+	}
+        
+	return result;
+}
+
+/* Return -1 on error. See smbus.h for more information */
+s32 ali1535_access(struct i2c_adapter * adap, u16 addr,
+		   unsigned short flags, char read_write, u8 command,
+		   int size, union i2c_smbus_data * data)
+{
+	int i, len;
+	int temp;
+	int timeout;
+	s32 result = 0;
+
+	down(&i2c_ali1535_sem);
+/* make sure SMBus is idle */
+	temp = inb_p(SMBHSTSTS);
+	for (timeout = 0;
+	     (timeout < MAX_TIMEOUT) && !(temp & ALI1535_STS_IDLE);
+	     timeout++) {
+		ali1535_do_pause(1);
+		temp = inb_p(SMBHSTSTS);
+	}
+	if (timeout >= MAX_TIMEOUT) {
+		printk("i2c-ali1535.o: Idle wait Timeout! STS=0x%02x\n",
+		       temp);
+	}
+
+/* clear status register (clear-on-write) */
+	outb_p(0xFF, SMBHSTSTS);
+
+	switch (size) {
+	case I2C_SMBUS_PROC_CALL:
+		printk
+		    ("i2c-ali1535.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		result = -1;
+		goto EXIT;
+	case I2C_SMBUS_QUICK:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = ALI1535_QUICK;
+                outb_p(size, SMBHSTTYP);	/* output command */
+                break;
+	case I2C_SMBUS_BYTE:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = ALI1535_BYTE;
+                outb_p(size, SMBHSTTYP);	/* output command */
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(command, SMBHSTCMD);
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = ALI1535_BYTE_DATA;
+                outb_p(size, SMBHSTTYP);	/* output command */
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(data->byte, SMBHSTDAT0);
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = ALI1535_WORD_DATA;
+                outb_p(size, SMBHSTTYP);	/* output command */
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			outb_p(data->word & 0xff, SMBHSTDAT0);
+			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1);
+		}
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = ALI1535_BLOCK_DATA;
+                outb_p(size, SMBHSTTYP);	/* output command */
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			len = data->block[0];
+			if (len < 0) {
+				len = 0;
+				data->block[0] = len;
+			}
+			if (len > 32) {
+				len = 32;
+				data->block[0] = len;
+			}
+			outb_p(len, SMBHSTDAT0);
+			outb_p(inb_p(SMBHSTTYP) | ALI1535_BLOCK_CLR, SMBHSTTYP);	/* Reset SMBBLKDAT */
+			for (i = 1; i <= len; i++)
+				outb_p(data->block[i], SMBBLKDAT);
+		}
+		break;
+	}
+
+	if (ali1535_transaction())	/* Error in transaction */
+	  {
+		result = -1;
+		goto EXIT;
+          }
+
+	if ((read_write == I2C_SMBUS_WRITE) || (size == ALI1535_QUICK))
+	  {
+		result = 0;
+		goto EXIT;
+          }
+
+	switch (size) {
+	case ALI1535_BYTE:	/* Result put in SMBHSTDAT0 */
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case ALI1535_BYTE_DATA:
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case ALI1535_WORD_DATA:
+		data->word = inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
+		break;
+	case ALI1535_BLOCK_DATA:
+		len = inb_p(SMBHSTDAT0);
+		if (len > 32)
+			len = 32;
+		data->block[0] = len;
+		outb_p(inb_p(SMBHSTTYP) | ALI1535_BLOCK_CLR, SMBHSTTYP);	/* Reset SMBBLKDAT */
+		for (i = 1; i <= data->block[0]; i++) {
+			data->block[i] = inb_p(SMBBLKDAT);
+#ifdef DEBUG
+			printk
+			    ("i2c-ali1535.o: Blk: len=%d, i=%d, data=%02x\n",
+			     len, i, data->block[i]);
+#endif	/* DEBUG */
+		}
+		break;
+	}
+EXIT:
+	up(&i2c_ali1535_sem);
+	return result;
+}
+
+void ali1535_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void ali1535_dec(struct i2c_adapter *adapter)
+{
+
+	MOD_DEC_USE_COUNT;
+}
+
+u32 ali1535_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+int __init i2c_ali1535_init(void)
+{
+	int res;
+	printk("i2c-ali1535.o version %s (%s)\n", LM_VERSION, LM_DATE);
+#ifdef DEBUG
+/* PE- It might be good to make this a permanent part of the code! */
+	if (ali1535_initialized) {
+		printk
+		    ("i2c-ali1535.o: Oops, ali1535_init called a second time!\n");
+		return -EBUSY;
+	}
+#endif
+	ali1535_initialized = 0;
+	if ((res = ali1535_setup())) {
+		printk
+		    ("i2c-ali1535.o: ALI1535 not detected, module not inserted.\n");
+		ali1535_cleanup();
+		return res;
+	}
+	ali1535_initialized++;
+	sprintf(ali1535_adapter.name, "SMBus ALI1535 adapter at %04x",
+		ali1535_smba);
+	if ((res = i2c_add_adapter(&ali1535_adapter))) {
+		printk
+		    ("i2c-ali1535.o: Adapter registration failed, module not inserted.\n");
+		ali1535_cleanup();
+		return res;
+	}
+	ali1535_initialized++;
+	printk
+	    ("i2c-ali1535.o: ALI1535 SMBus Controller detected and initialized\n");
+	return 0;
+}
+
+int __init ali1535_cleanup(void)
+{
+	int res;
+	if (ali1535_initialized >= 2) {
+		if ((res = i2c_del_adapter(&ali1535_adapter))) {
+			printk
+			    ("i2c-ali1535.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		} else
+			ali1535_initialized--;
+	}
+	if (ali1535_initialized >= 1) {
+		release_region(ali1535_smba, ALI1535_SMB_IOSIZE);
+		ali1535_initialized--;
+	}
+	return 0;
+}
+
+#ifdef RLX
+EXPORT_SYMBOL(ali1535_smba);
+EXPORT_SYMBOL(ali1535_access);
+EXPORT_SYMBOL(i2c_ali1535_sem);
+#else
+EXPORT_NO_SYMBOLS;
+#endif
+
+#ifdef MODULE
+
+MODULE_AUTHOR
+    ("Frodo Looijaard <frodol@dds.nl>, Philip Edelbrock <phil@netroedge.com>,\n"
+      "Mark D. Studebaker <mdsxyz123@yahoo.com> and Dan Eaton <dan.eaton@rocketlogix.com>");
+MODULE_DESCRIPTION("ALI1535 SMBus driver");
+
+int init_module(void)
+{
+	return i2c_ali1535_init();
+}
+
+int cleanup_module(void)
+{
+	return ali1535_cleanup();
+}
+
+#endif				/* MODULE */
+
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-ali15x3.c	2002-05-20 01:52:13.000000000 -0400
@@ -0,0 +1,646 @@
+/*
+    ali15x3.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+    Copyright (c) 1999  Frodo Looijaard <frodol@dds.nl> and
+    Philip Edelbrock <phil@netroedge.com> and
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
+    This is the driver for the SMB Host controller on
+    Acer Labs Inc. (ALI) M1541 and M1543C South Bridges.
+
+    The M1543C is a South bridge for desktop systems.
+    The M1533 is a South bridge for portable systems.
+    They are part of the following ALI chipsets:
+       "Aladdin Pro 2": Includes the M1621 Slot 1 North bridge
+       with AGP and 100MHz CPU Front Side bus
+       "Aladdin V": Includes the M1541 Socket 7 North bridge
+       with AGP and 100MHz CPU Front Side bus
+       "Aladdin IV": Includes the M1541 Socket 7 North bridge
+       with host bus up to 83.3 MHz.
+    For an overview of these chips see http://www.acerlabs.com
+
+    The M1533/M1543C devices appear as FOUR separate devices
+    on the PCI bus. An output of lspci will show something similar
+    to the following:
+
+	00:02.0 USB Controller: Acer Laboratories Inc. M5237
+	00:03.0 Bridge: Acer Laboratories Inc. M7101
+	00:07.0 ISA bridge: Acer Laboratories Inc. M1533
+	00:0f.0 IDE interface: Acer Laboratories Inc. M5229
+
+    The SMB controller is part of the 7101 device, which is an
+    ACPI-compliant Power Management Unit (PMU).
+
+    The whole 7101 device has to be enabled for the SMB to work.
+    You can't just enable the SMB alone.
+    The SMB and the ACPI have separate I/O spaces.
+    We make sure that the SMB is enabled. We leave the ACPI alone.
+
+    This driver controls the SMB Host only.
+    The SMB Slave controller on the M15X3 is not enabled.
+
+    This driver does not use interrupts.
+*/
+
+/* Note: we assume there can only be one ALI15X3, with one SMBus interface */
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
+/* ALI15X3 SMBus address offsets */
+#define SMBHSTSTS (0 + ali15x3_smba)
+#define SMBHSTCNT (1 + ali15x3_smba)
+#define SMBHSTSTART (2 + ali15x3_smba)
+#define SMBHSTCMD (7 + ali15x3_smba)
+#define SMBHSTADD (3 + ali15x3_smba)
+#define SMBHSTDAT0 (4 + ali15x3_smba)
+#define SMBHSTDAT1 (5 + ali15x3_smba)
+#define SMBBLKDAT (6 + ali15x3_smba)
+
+/* PCI Address Constants */
+#define SMBCOM    0x004
+#define SMBBA     0x014
+#define SMBATPC   0x05B		/* used to unlock xxxBA registers */
+#define SMBHSTCFG 0x0E0
+#define SMBSLVC   0x0E1
+#define SMBCLK    0x0E2
+#define SMBREV    0x008
+
+/* Other settings */
+#define MAX_TIMEOUT 200		/* times 1/100 sec */
+#define ALI15X3_SMB_IOSIZE 32
+
+/* this is what the Award 1004 BIOS sets them to on a ASUS P5A MB.
+   We don't use these here. If the bases aren't set to some value we
+   tell user to upgrade BIOS and we fail.
+*/
+#define ALI15X3_SMB_DEFAULTBASE 0xE800
+
+/* ALI15X3 address lock bits */
+#define ALI15X3_LOCK	0x06
+
+/* ALI15X3 command constants */
+#define ALI15X3_ABORT      0x02
+#define ALI15X3_T_OUT      0x04
+#define ALI15X3_QUICK      0x00
+#define ALI15X3_BYTE       0x10
+#define ALI15X3_BYTE_DATA  0x20
+#define ALI15X3_WORD_DATA  0x30
+#define ALI15X3_BLOCK_DATA 0x40
+#define ALI15X3_BLOCK_CLR  0x80
+
+/* ALI15X3 status register bits */
+#define ALI15X3_STS_IDLE	0x04
+#define ALI15X3_STS_BUSY	0x08
+#define ALI15X3_STS_DONE	0x10
+#define ALI15X3_STS_DEV		0x20	/* device error */
+#define ALI15X3_STS_COLL	0x40	/* collision or no response */
+#define ALI15X3_STS_TERM	0x80	/* terminated by abort */
+#define ALI15X3_STS_ERR		0xE0	/* all the bad error bits */
+
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
+int __init i2c_ali15x3_init(void);
+static int __init ali15x3_cleanup(void);
+static int ali15x3_setup(void);
+static s32 ali15x3_access(struct i2c_adapter *adap, u16 addr,
+			  unsigned short flags, char read_write,
+			  u8 command, int size,
+			  union i2c_smbus_data *data);
+static void ali15x3_do_pause(unsigned int amount);
+static int ali15x3_transaction(void);
+static void ali15x3_inc(struct i2c_adapter *adapter);
+static void ali15x3_dec(struct i2c_adapter *adapter);
+static u32 ali15x3_func(struct i2c_adapter *adapter);
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
+	/* smbus_access */ ali15x3_access,
+	/* slave_send */ NULL,
+	/* slave_rcv */ NULL,
+	/* algo_control */ NULL,
+	/* functionality */ ali15x3_func,
+};
+
+static struct i2c_adapter ali15x3_adapter = {
+	"unset",
+	I2C_ALGO_SMBUS | I2C_HW_SMBUS_ALI15X3,
+	&smbus_algorithm,
+	NULL,
+	ali15x3_inc,
+	ali15x3_dec,
+	NULL,
+	NULL,
+};
+
+static int __initdata ali15x3_initialized;
+static unsigned short ali15x3_smba = 0;
+static int locked=0;
+
+/* Detect whether a ALI15X3 can be found, and initialize it, where necessary.
+   Note the differences between kernels with the old PCI BIOS interface and
+   newer kernels with the real PCI interface. In compat.h some things are
+   defined to make the transition easier. */
+int ali15x3_setup(void)
+{
+	u16 a;
+	unsigned char temp;
+
+	struct pci_dev *ALI15X3_dev;
+
+	/* First check whether we can access PCI at all */
+	if (pci_present() == 0) {
+		printk("i2c-ali15x3.o: Error: No PCI-bus found!\n");
+		return -ENODEV;
+	}
+
+	/* Look for the ALI15X3, M7101 device */
+	ALI15X3_dev = NULL;
+	ALI15X3_dev = pci_find_device(PCI_VENDOR_ID_AL,
+				      PCI_DEVICE_ID_AL_M7101, ALI15X3_dev);
+	if (ALI15X3_dev == NULL) {
+		printk("i2c-ali15x3.o: Error: Can't detect ali15x3!\n");
+		return -ENODEV;
+	}
+
+/* Check the following things:
+	- SMB I/O address is initialized
+	- Device is enabled
+	- We can use the addresses
+*/
+
+/* Unlock the register.
+   The data sheet says that the address registers are read-only
+   if the lock bits are 1, but in fact the address registers
+   are zero unless you clear the lock bits.
+*/
+	pci_read_config_byte(ALI15X3_dev, SMBATPC, &temp);
+	if (temp & ALI15X3_LOCK) {
+		temp &= ~ALI15X3_LOCK;
+		pci_write_config_byte(ALI15X3_dev, SMBATPC, temp);
+	}
+
+/* Determine the address of the SMBus area */
+	pci_read_config_word(ALI15X3_dev, SMBBA, &ali15x3_smba);
+	ali15x3_smba &= (0xffff & ~(ALI15X3_SMB_IOSIZE - 1));
+	if (ali15x3_smba == 0 && force_addr == 0) {
+		printk
+		    ("i2c-ali15x3.o: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+		return -ENODEV;
+	}
+
+	if(force_addr)
+		ali15x3_smba = force_addr & ~(ALI15X3_SMB_IOSIZE - 1);
+
+	if (check_region(ali15x3_smba, ALI15X3_SMB_IOSIZE)) {
+		printk
+		    ("i2c-ali15x3.o: ALI15X3_smb region 0x%x already in use!\n",
+		     ali15x3_smba);
+		return -ENODEV;
+	}
+
+	if(force_addr) {
+		printk("i2c-ali15x3.o: forcing ISA address 0x%04X\n", ali15x3_smba);
+		if (PCIBIOS_SUCCESSFUL !=
+		    pci_write_config_word(ALI15X3_dev, SMBBA, ali15x3_smba))
+			return -ENODEV;
+		if (PCIBIOS_SUCCESSFUL !=
+		    pci_read_config_word(ALI15X3_dev, SMBBA, &a))
+			return -ENODEV;
+		if ((a & ~(ALI15X3_SMB_IOSIZE - 1)) != ali15x3_smba) {
+			/* make sure it works */
+			printk("i2c-ali15x3.o: force address failed - not supported?\n");
+			return -ENODEV;
+		}
+	}
+/* check if whole device is enabled */
+	pci_read_config_byte(ALI15X3_dev, SMBCOM, &temp);
+	if ((temp & 1) == 0) {
+		printk("i2c-ali15x3: enabling SMBus device\n");
+		pci_write_config_byte(ALI15X3_dev, SMBCOM, temp | 0x01);
+	}
+
+/* Is SMB Host controller enabled? */
+	pci_read_config_byte(ALI15X3_dev, SMBHSTCFG, &temp);
+	if ((temp & 1) == 0) {
+		printk("i2c-ali15x3: enabling SMBus controller\n");
+		pci_write_config_byte(ALI15X3_dev, SMBHSTCFG, temp | 0x01);
+	}
+
+/* set SMB clock to 74KHz as recommended in data sheet */
+	pci_write_config_byte(ALI15X3_dev, SMBCLK, 0x20);
+
+	/* Everything is happy, let's grab the memory and set things up. */
+	request_region(ali15x3_smba, ALI15X3_SMB_IOSIZE, "ali15x3-smb");
+
+#ifdef DEBUG
+/*
+  The interrupt routing for SMB is set up in register 0x77 in the
+  1533 ISA Bridge device, NOT in the 7101 device.
+  Don't bother with finding the 1533 device and reading the register.
+  if ((....... & 0x0F) == 1)
+     printk("i2c-ali15x3.o: ALI15X3 using Interrupt 9 for SMBus.\n");
+*/
+	pci_read_config_byte(ALI15X3_dev, SMBREV, &temp);
+	printk("i2c-ali15x3.o: SMBREV = 0x%X\n", temp);
+	printk("i2c-ali15x3.o: ALI15X3_smba = 0x%X\n", ali15x3_smba);
+#endif				/* DEBUG */
+
+	return 0;
+}
+
+
+/* Internally used pause function */
+void ali15x3_do_pause(unsigned int amount)
+{
+	current->state = TASK_INTERRUPTIBLE;
+	schedule_timeout(amount);
+}
+
+/* Another internally used function */
+int ali15x3_transaction(void)
+{
+	int temp;
+	int result = 0;
+	int timeout = 0;
+
+#ifdef DEBUG
+	printk
+	    ("i2c-ali15x3.o: Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
+	     "DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
+	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+	     inb_p(SMBHSTDAT1));
+#endif
+
+	/* get status */
+	temp = inb_p(SMBHSTSTS);
+
+	/* Make sure the SMBus host is ready to start transmitting */
+	/* Check the busy bit first */
+	if (temp & ALI15X3_STS_BUSY) {
+/*
+   If the host controller is still busy, it may have timed out in the previous transaction,
+   resulting in a "SMBus Timeout" printk.
+   I've tried the following to reset a stuck busy bit.
+	1. Reset the controller with an ABORT command.
+	   (this doesn't seem to clear the controller if an external device is hung)
+	2. Reset the controller and the other SMBus devices with a T_OUT command.
+	   (this clears the host busy bit if an external device is hung,
+	   but it comes back upon a new access to a device)
+	3. Disable and reenable the controller in SMBHSTCFG
+   Worst case, nothing seems to work except power reset.
+*/
+/* Abort - reset the host controller */
+/*
+#ifdef DEBUG
+    printk("i2c-ali15x3.o: Resetting host controller to clear busy condition\n",temp);
+#endif
+    outb_p(ALI15X3_ABORT, SMBHSTCNT);
+    temp = inb_p(SMBHSTSTS);
+    if (temp & ALI15X3_STS_BUSY) {
+*/
+
+/*
+   Try resetting entire SMB bus, including other devices -
+   This may not work either - it clears the BUSY bit but
+   then the BUSY bit may come back on when you try and use the chip again.
+   If that's the case you are stuck.
+*/
+		printk
+		    ("i2c-ali15x3.o: Resetting entire SMB Bus to clear busy condition (%02x)\n",
+		     temp);
+		outb_p(ALI15X3_T_OUT, SMBHSTCNT);
+		temp = inb_p(SMBHSTSTS);
+	}
+/*
+  }
+*/
+
+	/* now check the error bits and the busy bit */
+	if (temp & (ALI15X3_STS_ERR | ALI15X3_STS_BUSY)) {
+		/* do a clear-on-write */
+		outb_p(0xFF, SMBHSTSTS);
+		if ((temp = inb_p(SMBHSTSTS)) &
+		    (ALI15X3_STS_ERR | ALI15X3_STS_BUSY)) {
+			/* this is probably going to be correctable only by a power reset
+			   as one of the bits now appears to be stuck */
+			/* This may be a bus or device with electrical problems. */
+			printk
+			    ("i2c-ali15x3.o: SMBus reset failed! (0x%02x) - controller or device on bus is probably hung\n",
+			     temp);
+			return -1;
+		}
+	} else {
+		/* check and clear done bit */
+		if (temp & ALI15X3_STS_DONE) {
+			outb_p(temp, SMBHSTSTS);
+		}
+	}
+
+	/* start the transaction by writing anything to the start register */
+	outb_p(0xFF, SMBHSTSTART);
+
+	/* We will always wait for a fraction of a second! */
+	timeout = 0;
+	do {
+		ali15x3_do_pause(1);
+		temp = inb_p(SMBHSTSTS);
+	} while ((!(temp & (ALI15X3_STS_ERR | ALI15X3_STS_DONE)))
+		 && (timeout++ < MAX_TIMEOUT));
+
+	/* If the SMBus is still busy, we give up */
+	if (timeout >= MAX_TIMEOUT) {
+		result = -1;
+		printk("i2c-ali15x3.o: SMBus Timeout!\n");
+	}
+
+	if (temp & ALI15X3_STS_TERM) {
+		result = -1;
+#ifdef DEBUG
+		printk("i2c-ali15x3.o: Error: Failed bus transaction\n");
+#endif
+	}
+
+/*
+  Unfortunately the ALI SMB controller maps "no response" and "bus collision"
+  into a single bit. No reponse is the usual case so don't
+  do a printk.
+  This means that bus collisions go unreported.
+*/
+	if (temp & ALI15X3_STS_COLL) {
+		result = -1;
+#ifdef DEBUG
+		printk
+		    ("i2c-ali15x3.o: Error: no response or bus collision ADD=%02x\n",
+		     inb_p(SMBHSTADD));
+#endif
+	}
+
+/* haven't ever seen this */
+	if (temp & ALI15X3_STS_DEV) {
+		result = -1;
+		printk("i2c-ali15x3.o: Error: device error\n");
+	}
+#ifdef DEBUG
+	printk
+	    ("i2c-ali15x3.o: Transaction (post): STS=%02x, CNT=%02x, CMD=%02x, ADD=%02x, "
+	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
+	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+	     inb_p(SMBHSTDAT1));
+#endif
+	return result;
+}
+
+/* Return -1 on error. See smbus.h for more information */
+s32 ali15x3_access(struct i2c_adapter * adap, u16 addr,
+		   unsigned short flags, char read_write, u8 command,
+		   int size, union i2c_smbus_data * data)
+{
+	int i, len;
+	int temp;
+	int timeout;
+
+/* clear all the bits (clear-on-write) */
+	outb_p(0xFF, SMBHSTSTS);
+/* make sure SMBus is idle */
+	temp = inb_p(SMBHSTSTS);
+	for (timeout = 0;
+	     (timeout < MAX_TIMEOUT) && !(temp & ALI15X3_STS_IDLE);
+	     timeout++) {
+		ali15x3_do_pause(1);
+		temp = inb_p(SMBHSTSTS);
+	}
+	if (timeout >= MAX_TIMEOUT) {
+		printk("i2c-ali15x3.o: Idle wait Timeout! STS=0x%02x\n",
+		       temp);
+	}
+
+	switch (size) {
+	case I2C_SMBUS_PROC_CALL:
+		printk
+		    ("i2c-ali15x3.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		return -1;
+	case I2C_SMBUS_QUICK:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		size = ALI15X3_QUICK;
+		break;
+	case I2C_SMBUS_BYTE:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(command, SMBHSTCMD);
+		size = ALI15X3_BYTE;
+		break;
+	case I2C_SMBUS_BYTE_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE)
+			outb_p(data->byte, SMBHSTDAT0);
+		size = ALI15X3_BYTE_DATA;
+		break;
+	case I2C_SMBUS_WORD_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			outb_p(data->word & 0xff, SMBHSTDAT0);
+			outb_p((data->word & 0xff00) >> 8, SMBHSTDAT1);
+		}
+		size = ALI15X3_WORD_DATA;
+		break;
+	case I2C_SMBUS_BLOCK_DATA:
+		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
+		       SMBHSTADD);
+		outb_p(command, SMBHSTCMD);
+		if (read_write == I2C_SMBUS_WRITE) {
+			len = data->block[0];
+			if (len < 0) {
+				len = 0;
+				data->block[0] = len;
+			}
+			if (len > 32) {
+				len = 32;
+				data->block[0] = len;
+			}
+			outb_p(len, SMBHSTDAT0);
+			outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);	/* Reset SMBBLKDAT */
+			for (i = 1; i <= len; i++)
+				outb_p(data->block[i], SMBBLKDAT);
+		}
+		size = ALI15X3_BLOCK_DATA;
+		break;
+	}
+
+	outb_p(size, SMBHSTCNT);	/* output command */
+
+	if (ali15x3_transaction())	/* Error in transaction */
+		return -1;
+
+	if ((read_write == I2C_SMBUS_WRITE) || (size == ALI15X3_QUICK))
+		return 0;
+
+
+	switch (size) {
+	case ALI15X3_BYTE:	/* Result put in SMBHSTDAT0 */
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case ALI15X3_BYTE_DATA:
+		data->byte = inb_p(SMBHSTDAT0);
+		break;
+	case ALI15X3_WORD_DATA:
+		data->word = inb_p(SMBHSTDAT0) + (inb_p(SMBHSTDAT1) << 8);
+		break;
+	case ALI15X3_BLOCK_DATA:
+		len = inb_p(SMBHSTDAT0);
+		if (len > 32)
+			len = 32;
+		data->block[0] = len;
+		outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);	/* Reset SMBBLKDAT */
+		for (i = 1; i <= data->block[0]; i++) {
+			data->block[i] = inb_p(SMBBLKDAT);
+#ifdef DEBUG
+			printk
+			    ("i2c-ali15x3.o: Blk: len=%d, i=%d, data=%02x\n",
+			     len, i, data->block[i]);
+#endif	/* DEBUG */
+		}
+		break;
+	}
+	return 0;
+}
+
+void ali15x3_inc(struct i2c_adapter *adapter)
+{
+	MOD_INC_USE_COUNT;
+}
+
+void ali15x3_dec(struct i2c_adapter *adapter)
+{
+
+	MOD_DEC_USE_COUNT;
+}
+
+u32 ali15x3_func(struct i2c_adapter *adapter)
+{
+	return I2C_FUNC_SMBUS_QUICK | I2C_FUNC_SMBUS_BYTE |
+	    I2C_FUNC_SMBUS_BYTE_DATA | I2C_FUNC_SMBUS_WORD_DATA |
+	    I2C_FUNC_SMBUS_BLOCK_DATA;
+}
+
+int __init i2c_ali15x3_init(void)
+{
+	int res;
+	printk("i2c-ali15x3.o version %s (%s)\n", LM_VERSION, LM_DATE);
+#ifdef DEBUG
+/* PE- It might be good to make this a permanent part of the code! */
+	if (ali15x3_initialized) {
+		printk
+		    ("i2c-ali15x3.o: Oops, ali15x3_init called a second time!\n");
+		return -EBUSY;
+	}
+#endif
+	ali15x3_initialized = 0;
+	if ((res = ali15x3_setup())) {
+		printk
+		    ("i2c-ali15x3.o: ALI15X3 not detected, module not inserted.\n");
+		ali15x3_cleanup();
+		return res;
+	}
+	ali15x3_initialized++;
+	sprintf(ali15x3_adapter.name, "SMBus ALI15X3 adapter at %04x",
+		ali15x3_smba);
+	if ((res = i2c_add_adapter(&ali15x3_adapter))) {
+		printk
+		    ("i2c-ali15x3.o: Adapter registration failed, module not inserted.\n");
+		ali15x3_cleanup();
+		return res;
+	}
+	ali15x3_initialized++;
+	printk
+	    ("i2c-ali15x3.o: ALI15X3 SMBus Controller detected and initialized\n");
+	return 0;
+}
+
+int __init ali15x3_cleanup(void)
+{
+	int res;
+	if (ali15x3_initialized >= 2) {
+		if ((res = i2c_del_adapter(&ali15x3_adapter))) {
+			printk
+			    ("i2c-ali15x3.o: i2c_del_adapter failed, module not removed\n");
+			return res;
+		} else
+			ali15x3_initialized--;
+	}
+	if (ali15x3_initialized >= 1) {
+		release_region(ali15x3_smba, ALI15X3_SMB_IOSIZE);
+		ali15x3_initialized--;
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
+MODULE_DESCRIPTION("ALI15X3 SMBus driver");
+
+int init_module(void)
+{
+	return i2c_ali15x3_init();
+}
+
+int cleanup_module(void)
+{
+	return ali15x3_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-amd756.c	2002-05-20 01:52:33.000000000 -0400
@@ -0,0 +1,505 @@
+/*
+    amd756.c - Part of lm_sensors, Linux kernel modules for hardware
+              monitoring
+
+    Copyright (c) 1999 Merlin Hughes <merlin@merlin.org>
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
+   Supports AMD756, AMD766, and AMD768.
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
+MODULE_LICENSE("GPL");
+
+#ifndef PCI_DEVICE_ID_AMD_756
+#define PCI_DEVICE_ID_AMD_756 0x740B
+#endif
+#ifndef PCI_DEVICE_ID_AMD_766
+#define PCI_DEVICE_ID_AMD_766 0x7413
+#endif
+
+static int supported[] = {PCI_DEVICE_ID_AMD_756,
+                          PCI_DEVICE_ID_AMD_766,
+			  0x7443, /* AMD768 */
+                          0 };
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
+
+/* general configuration */
+#define SMBGCFG   0x041		/* mh */
+
+/* silicon revision code */
+#define SMBREV    0x008
+
+/* Other settings */
+#define MAX_TIMEOUT 100
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
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_amd756_init(void);
+static int __init amd756_cleanup(void);
+static int amd756_setup(void);
+static s32 amd756_access(struct i2c_adapter *adap, u16 addr,
+			 unsigned short flags, char read_write,
+			 u8 command, int size, union i2c_smbus_data *data);
+static void amd756_do_pause(unsigned int amount);
+static int amd756_transaction(void);
+static void amd756_inc(struct i2c_adapter *adapter);
+static void amd756_dec(struct i2c_adapter *adapter);
+static u32 amd756_func(struct i2c_adapter *adapter);
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
+static unsigned short amd756_smba = 0;
+
+/* Detect whether a AMD756 can be found, and initialize it, where necessary.
+   Note the differences between kernels with the old PCI BIOS interface and
+   newer kernels with the real PCI interface. In compat.h some things are
+   defined to make the transition easier. */
+int amd756_setup(void)
+{
+	unsigned char temp;
+	int *num = supported;
+	struct pci_dev *AMD756_dev = NULL;
+
+	if (pci_present() == 0) {
+		printk("i2c-amd756.o: Error: No PCI-bus found!\n");
+		return(-ENODEV);
+	}
+
+	/* Look for the AMD756, function 3 */
+	/* Note: we keep on searching until we have found 'function 3' */
+	do {
+		if((AMD756_dev = pci_find_device(PCI_VENDOR_ID_AMD,
+					      *num, AMD756_dev))) {
+			if(PCI_FUNC(AMD756_dev->devfn) != 3)
+				continue;
+			break;
+		}
+		num++;
+	} while (*num != 0);
+
+	if (AMD756_dev == NULL) {
+		printk
+		    ("i2c-amd756.o: Error: Can't detect AMD756, function 3!\n");
+		return(-ENODEV);
+	}
+
+
+	pci_read_config_byte(AMD756_dev, SMBGCFG, &temp);
+	if ((temp & 128) == 0) {
+		printk
+		  ("i2c-amd756.o: Error: SMBus controller I/O not enabled!\n");
+		return(-ENODEV);
+	}
+
+	/* Determine the address of the SMBus areas */
+	/* Technically it is a dword but... */
+	pci_read_config_word(AMD756_dev, SMBBA, &amd756_smba);
+	amd756_smba &= 0xff00;
+	amd756_smba += SMB_ADDR_OFFSET;
+
+	if (check_region(amd756_smba, SMB_IOSIZE)) {
+		printk
+		    ("i2c-amd756.o: SMB region 0x%x already in use!\n",
+		     amd756_smba);
+		return(-ENODEV);
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
+			printk("i2c-amd756.o: Busy wait timeout! (%04x)\n",
+			       temp);
+			return(-1);
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
+		return(-1);
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
+		/* TODO: Clear Collision Status with a 1 */
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
+/* Return -1 on error. See smbus.h for more information */
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
+		data->block[0] = inw_p(SMB_HOST_DATA & 63);
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
+	printk("i2c-amd756.o version %s (%s)\n", LM_VERSION, LM_DATE);
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
+		    ("i2c-amd756.o: AMD756/766 not detected, module not inserted.\n");
+		amd756_cleanup();
+		return res;
+	}
+	amd756_initialized++;
+	sprintf(amd756_adapter.name, "SMBus AMD7X6 adapter at %04x",
+		amd756_smba);
+	if ((res = i2c_add_adapter(&amd756_adapter))) {
+		printk
+		    ("i2c-amd756.o: Adapter registration failed, module not inserted.\n");
+		amd756_cleanup();
+		return res;
+	}
+	amd756_initialized++;
+	printk("i2c-amd756.o: AMD756/766 bus detected and initialized\n");
+	return 0;
+}
+
+int __init amd756_cleanup(void)
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
+	return 0;
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+
+MODULE_AUTHOR("Merlin Hughes <merlin@merlin.org>");
+MODULE_DESCRIPTION("AMD756/766 SMBus driver");
+
+int init_module(void)
+{
+	return i2c_amd756_init();
+}
+
+int cleanup_module(void)
+{
+	return amd756_cleanup();
+}
+
+#endif				/* MODULE */
--- /dev/null	1994-07-17 19:46:18.000000000 -0400
+++ linux/drivers/i2c/busses/i2c-hydra.c	2002-05-20 01:53:01.000000000 -0400
@@ -0,0 +1,205 @@
+/*
+    i2c-hydra.c - Part of lm_sensors,  Linux kernel modules
+                  for hardware monitoring
+
+    i2c Support for the Apple `Hydra' Mac I/O
+
+    Copyright (c) 1999 Geert Uytterhoeven <geert@linux-m68k.org>
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
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <asm/io.h>
+#include <asm/system.h>
+#include <linux/types.h>
+#include <linux/i2c.h>
+#include <linux/i2c-algo-bit.h>
+#include <linux/init.h>
+#include <linux/sensors.h>
+
+MODULE_LICENSE("GPL");
+
+/* PCI device */
+#define VENDOR		PCI_VENDOR_ID_APPLE
+#define DEVICE		PCI_DEVICE_ID_APPLE_HYDRA
+
+#define HYDRA_CACHE_PD	0x00000030
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
+static unsigned long hydra_base;
+
+static inline void pdregw(u32 val)
+{
+	writel(val, hydra_base + HYDRA_CACHE_PD);
+}
+
+static inline u32 pdregr(void)
+{
+	u32 val = readl(hydra_base + HYDRA_CACHE_PD);
+	return val;
+}
+
+static void bit_hydra_setscl(void *data, int state)
+{
+	u32 val = pdregr();
+	if (state)
+		val &= ~HYDRA_SCLK_OE;
+	else {
+		val &= ~HYDRA_SCLK;
+		val |= HYDRA_SCLK_OE;
+	}
+	pdregw(val);
+}
+
+static void bit_hydra_setsda(void *data, int state)
+{
+	u32 val = pdregr();
+	if (state)
+		val &= ~HYDRA_SDAT_OE;
+	else {
+		val &= ~HYDRA_SDAT;
+		val |= HYDRA_SDAT_OE;
+	}
+	pdregw(val);
+}
+
+static int bit_hydra_getscl(void *data)
+{
+	return (pdregr() & HYDRA_SCLK) != 0;
+}
+
+static int bit_hydra_getsda(void *data)
+{
+	return (pdregr() & HYDRA_SDAT) != 0;
+}
+
+static void bit_hydra_inc(struct i2c_adapter *adap)
+{
+	MOD_INC_USE_COUNT;
+}
+
+static void bit_hydra_dec(struct i2c_adapter *adap)
+{
+	MOD_DEC_USE_COUNT;
+}
+
+/* ------------------------------------------------------------------------ */
+
+static struct i2c_algo_bit_data bit_hydra_data = {
+	NULL,
+	bit_hydra_setsda,
+	bit_hydra_setscl,
+	bit_hydra_getsda,
+	bit_hydra_getscl,
+	5, 5, 100,		/*waits, timeout */
+};
+
+static struct i2c_adapter bit_hydra_ops = {
+	"Hydra i2c",
+	I2C_HW_B_HYDRA,
+	NULL,
+	&bit_hydra_data,
+	bit_hydra_inc,
+	bit_hydra_dec,
+	NULL,
+	NULL,
+};
+
+
+static int find_hydra(void)
+{
+	struct pci_dev *dev;
+	unsigned int base_addr;
+
+	if (!pci_present())
+		return -ENODEV;
+
+	dev = pci_find_device(VENDOR, DEVICE, NULL);
+	if (!dev) {
+		printk("Hydra not found\n");
+		return -ENODEV;
+	}
+
+#if LINUX_VERSION_CODE >= KERNEL_VERSION(2,3,13)
+	base_addr = dev->resource[0].start;
+#else
+	base_addr = dev->base_address[0];
+#endif
+	hydra_base = (unsigned long) ioremap(base_addr, 0x100);
+
+	return 0;
+}
+
+#ifdef MODULE
+static
+#else
+extern
+#endif
+int __init i2c_hydra_init(void)
+{
+	if (find_hydra() < 0) {
+		printk("Error while reading PCI configuration\n");
+		return -ENODEV;
+	}
+
+	pdregw(0);		/* clear SCLK_OE and SDAT_OE */
+
+	if (i2c_bit_add_bus(&bit_hydra_ops) == 0) {
+		printk("Hydra i2c: Module succesfully loaded\n");
+		return 0;
+	} else {
+		iounmap((void *) hydra_base);
+		printk
+		    ("Hydra i2c: Algo-bit error, couldn't register bus\n");
+		return -ENODEV;
+	}
+}
+
+EXPORT_NO_SYMBOLS;
+
+#ifdef MODULE
+MODULE_AUTHOR("Geert Uytterhoeven <geert@linux-m68k.org>");
+MODULE_DESCRIPTION("i2c for Apple Hydra Mac I/O");
+
+int init_module(void)
+{
+	return i2c_hydra_init();
+}
+
+void cleanup_module(void)
+{
+	i2c_bit_del_bus(&bit_hydra_ops);
+	if (hydra_base) {
+		pdregw(0);	/* clear SCLK_OE and SDAT_OE */
+		iounmap((void *) hydra_base);
+	}
+}
+#endif

--------------F719D3046F0AADF220F310D3--

