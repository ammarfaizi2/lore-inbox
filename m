Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262692AbTCTWY1>; Thu, 20 Mar 2003 17:24:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbTCTWXr>; Thu, 20 Mar 2003 17:23:47 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:37637 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262692AbTCTWVi>;
	Thu, 20 Mar 2003 17:21:38 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995712956@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995723512@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.9, 2003/03/20 11:14:58-08:00, greg@kroah.com

[PATCH] i2c i2c-ali15x3.c: remove #ifdefs and fix all printk() to use dev_*().


 drivers/i2c/busses/i2c-ali15x3.c |  115 +++++++++++++++------------------------
 1 files changed, 45 insertions(+), 70 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-ali15x3.c b/drivers/i2c/busses/i2c-ali15x3.c
--- a/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 20 12:55:22 2003
+++ b/drivers/i2c/busses/i2c-ali15x3.c	Thu Mar 20 12:55:22 2003
@@ -60,6 +60,8 @@
 
 /* Note: we assume there can only be one ALI15X3, with one SMBus interface */
 
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/kernel.h>
@@ -131,7 +133,6 @@
 
 
 static void ali15x3_do_pause(unsigned int amount);
-static int ali15x3_transaction(void);
 
 static unsigned short ali15x3_smba = 0;
 
@@ -161,8 +162,8 @@
 	pci_read_config_word(ALI15X3_dev, SMBBA, &ali15x3_smba);
 	ali15x3_smba &= (0xffff & ~(ALI15X3_SMB_IOSIZE - 1));
 	if (ali15x3_smba == 0 && force_addr == 0) {
-		printk
-		    ("i2c-ali15x3.o: ALI15X3_smb region uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+		dev_err(&ALI15X3_dev->dev, "ALI15X3_smb region uninitialized "
+			"- upgrade BIOS or use force_addr=0xaddr\n");
 		return -ENODEV;
 	}
 
@@ -170,14 +171,15 @@
 		ali15x3_smba = force_addr & ~(ALI15X3_SMB_IOSIZE - 1);
 
 	if (check_region(ali15x3_smba, ALI15X3_SMB_IOSIZE)) {
-		printk
-		    ("i2c-ali15x3.o: ALI15X3_smb region 0x%x already in use!\n",
-		     ali15x3_smba);
+		dev_err(&ALI15X3_dev->dev,
+			"ALI15X3_smb region 0x%x already in use!\n",
+			ali15x3_smba);
 		return -ENODEV;
 	}
 
 	if(force_addr) {
-		printk("i2c-ali15x3.o: forcing ISA address 0x%04X\n", ali15x3_smba);
+		dev_info(&ALI15X3_dev->dev, "forcing ISA address 0x%04X\n",
+			ali15x3_smba);
 		if (PCIBIOS_SUCCESSFUL !=
 		    pci_write_config_word(ALI15X3_dev, SMBBA, ali15x3_smba))
 			return -ENODEV;
@@ -186,21 +188,22 @@
 			return -ENODEV;
 		if ((a & ~(ALI15X3_SMB_IOSIZE - 1)) != ali15x3_smba) {
 			/* make sure it works */
-			printk("i2c-ali15x3.o: force address failed - not supported?\n");
+			dev_err(&ALI15X3_dev->dev,
+				"force address failed - not supported?\n");
 			return -ENODEV;
 		}
 	}
 /* check if whole device is enabled */
 	pci_read_config_byte(ALI15X3_dev, SMBCOM, &temp);
 	if ((temp & 1) == 0) {
-		printk("i2c-ali15x3: enabling SMBus device\n");
+		dev_info(&ALI15X3_dev->dev, "enabling SMBus device\n");
 		pci_write_config_byte(ALI15X3_dev, SMBCOM, temp | 0x01);
 	}
 
 /* Is SMB Host controller enabled? */
 	pci_read_config_byte(ALI15X3_dev, SMBHSTCFG, &temp);
 	if ((temp & 1) == 0) {
-		printk("i2c-ali15x3: enabling SMBus controller\n");
+		dev_info(&ALI15X3_dev->dev, "enabling SMBus controller\n");
 		pci_write_config_byte(ALI15X3_dev, SMBHSTCFG, temp | 0x01);
 	}
 
@@ -210,18 +213,16 @@
 	/* Everything is happy, let's grab the memory and set things up. */
 	request_region(ali15x3_smba, ALI15X3_SMB_IOSIZE, "ali15x3-smb");
 
-#ifdef DEBUG
 /*
   The interrupt routing for SMB is set up in register 0x77 in the
   1533 ISA Bridge device, NOT in the 7101 device.
   Don't bother with finding the 1533 device and reading the register.
-  if ((....... & 0x0F) == 1)
-     printk("i2c-ali15x3.o: ALI15X3 using Interrupt 9 for SMBus.\n");
+	if ((....... & 0x0F) == 1)
+		dev_dbg(&ALI15X3_dev->dev, "ALI15X3 using Interrupt 9 for SMBus.\n");
 */
 	pci_read_config_byte(ALI15X3_dev, SMBREV, &temp);
-	printk("i2c-ali15x3.o: SMBREV = 0x%X\n", temp);
-	printk("i2c-ali15x3.o: ALI15X3_smba = 0x%X\n", ali15x3_smba);
-#endif				/* DEBUG */
+	dev_dbg(&ALI15X3_dev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&ALI15X3_dev->dev, "iALI15X3_smba = 0x%X\n", ali15x3_smba);
 
 	return 0;
 }
@@ -235,19 +236,16 @@
 }
 
 /* Another internally used function */
-int ali15x3_transaction(void)
+static int ali15x3_transaction(struct i2c_adapter *adap)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
-	printk
-	    ("i2c-ali15x3.o: Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
-	     "DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
-	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-	     inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&adap->dev, "Transaction (pre): STS=%02x, CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS),
+		inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
+		inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
 
 	/* get status */
 	temp = inb_p(SMBHSTSTS);
@@ -257,7 +255,7 @@
 	if (temp & ALI15X3_STS_BUSY) {
 /*
    If the host controller is still busy, it may have timed out in the previous transaction,
-   resulting in a "SMBus Timeout" printk.
+   resulting in a "SMBus Timeout" Dev.
    I've tried the following to reset a stuck busy bit.
 	1. Reset the controller with an ABORT command.
 	   (this doesn't seem to clear the controller if an external device is hung)
@@ -269,23 +267,13 @@
 */
 /* Abort - reset the host controller */
 /*
-#ifdef DEBUG
-    printk("i2c-ali15x3.o: Resetting host controller to clear busy condition\n",temp);
-#endif
-    outb_p(ALI15X3_ABORT, SMBHSTCNT);
-    temp = inb_p(SMBHSTSTS);
-    if (temp & ALI15X3_STS_BUSY) {
-*/
-
-/*
    Try resetting entire SMB bus, including other devices -
    This may not work either - it clears the BUSY bit but
    then the BUSY bit may come back on when you try and use the chip again.
    If that's the case you are stuck.
 */
-		printk
-		    ("i2c-ali15x3.o: Resetting entire SMB Bus to clear busy condition (%02x)\n",
-		     temp);
+		dev_info(&adap->dev, "Resetting entire SMB Bus to "
+			"clear busy condition (%02x)\n", temp);
 		outb_p(ALI15X3_T_OUT, SMBHSTCNT);
 		temp = inb_p(SMBHSTSTS);
 	}
@@ -302,9 +290,9 @@
 			/* this is probably going to be correctable only by a power reset
 			   as one of the bits now appears to be stuck */
 			/* This may be a bus or device with electrical problems. */
-			printk
-			    ("i2c-ali15x3.o: SMBus reset failed! (0x%02x) - controller or device on bus is probably hung\n",
-			     temp);
+			dev_err(&adap->dev, "SMBus reset failed! (0x%02x) - "
+				"controller or device on bus is probably hung\n",
+				temp);
 			return -1;
 		}
 	} else {
@@ -328,14 +316,12 @@
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
 		result = -1;
-		printk("i2c-ali15x3.o: SMBus Timeout!\n");
+		dev_err(&adap->dev, "SMBus Timeout!\n");
 	}
 
 	if (temp & ALI15X3_STS_TERM) {
 		result = -1;
-#ifdef DEBUG
-		printk("i2c-ali15x3.o: Error: Failed bus transaction\n");
-#endif
+		dev_dbg(&adap->dev, "Error: Failed bus transaction\n");
 	}
 
 /*
@@ -346,25 +332,20 @@
 */
 	if (temp & ALI15X3_STS_COLL) {
 		result = -1;
-#ifdef DEBUG
-		printk
-		    ("i2c-ali15x3.o: Error: no response or bus collision ADD=%02x\n",
-		     inb_p(SMBHSTADD));
-#endif
+		dev_dbg(&adap->dev,
+			"Error: no response or bus collision ADD=%02x\n",
+			inb_p(SMBHSTADD));
 	}
 
 /* haven't ever seen this */
 	if (temp & ALI15X3_STS_DEV) {
 		result = -1;
-		printk("i2c-ali15x3.o: Error: device error\n");
+		dev_err(&adap->dev, "Error: device error\n");
 	}
-#ifdef DEBUG
-	printk
-	    ("i2c-ali15x3.o: Transaction (post): STS=%02x, CNT=%02x, CMD=%02x, ADD=%02x, "
-	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS), inb_p(SMBHSTCNT),
-	     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-	     inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&adap->dev, "Transaction (post): STS=%02x, CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTSTS),
+		inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
+		inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
 	return result;
 }
 
@@ -388,14 +369,12 @@
 		temp = inb_p(SMBHSTSTS);
 	}
 	if (timeout >= MAX_TIMEOUT) {
-		printk("i2c-ali15x3.o: Idle wait Timeout! STS=0x%02x\n",
-		       temp);
+		dev_err(&adap->dev, "Idle wait Timeout! STS=0x%02x\n", temp);
 	}
 
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		printk
-		    ("i2c-ali15x3.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 		return -1;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -452,7 +431,7 @@
 
 	outb_p(size, SMBHSTCNT);	/* output command */
 
-	if (ali15x3_transaction())	/* Error in transaction */
+	if (ali15x3_transaction(adap))	/* Error in transaction */
 		return -1;
 
 	if ((read_write == I2C_SMBUS_WRITE) || (size == ALI15X3_QUICK))
@@ -477,11 +456,8 @@
 		outb_p(inb_p(SMBHSTCNT) | ALI15X3_BLOCK_CLR, SMBHSTCNT);	/* Reset SMBBLKDAT */
 		for (i = 1; i <= data->block[0]; i++) {
 			data->block[i] = inb_p(SMBBLKDAT);
-#ifdef DEBUG
-			printk
-			    ("i2c-ali15x3.o: Blk: len=%d, i=%d, data=%02x\n",
-			     len, i, data->block[i]);
-#endif	/* DEBUG */
+			dev_dbg(&adap->dev, "Blk: len=%d, i=%d, data=%02x\n",
+				len, i, data->block[i]);
 		}
 		break;
 	}
@@ -525,9 +501,8 @@
 static int __devinit ali15x3_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	if (ali15x3_setup(dev)) {
-		printk
-		    ("i2c-ali15x3.o: ALI15X3 not detected, module not inserted.\n");
-
+		dev_err(&dev->dev,
+			"ALI15X3 not detected, module not inserted.\n");
 		return -ENODEV;
 	}
 

