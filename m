Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262687AbTCTWXE>; Thu, 20 Mar 2003 17:23:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262706AbTCTWWm>; Thu, 20 Mar 2003 17:22:42 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:32517 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262687AbTCTWVa>;
	Thu, 20 Mar 2003 17:21:30 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995651628@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <10481995653857@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.6, 2003/03/18 17:12:28-08:00, greg@kroah.com

[PATCH] i2c i2c-piix4: remove #ifdefs and fix all printk() to use dev_*().


 drivers/i2c/busses/i2c-piix4.c |  120 ++++++++++++++++-------------------------
 1 files changed, 49 insertions(+), 71 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-piix4.c b/drivers/i2c/busses/i2c-piix4.c
--- a/drivers/i2c/busses/i2c-piix4.c	Thu Mar 20 12:56:30 2003
+++ b/drivers/i2c/busses/i2c-piix4.c	Thu Mar 20 12:56:30 2003
@@ -28,6 +28,8 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
+/* #define DEBUG 1 */
+
 #include <linux/module.h>
 #include <linux/config.h>
 #include <linux/pci.h>
@@ -102,6 +104,7 @@
 
 
 static unsigned short piix4_smba = 0;
+static struct i2c_adapter piix4_adapter;
 
 /*
  * Get DMI information.
@@ -125,15 +128,14 @@
 	if (PCI_FUNC(PIIX4_dev->devfn) != id->driver_data)
 		return -ENODEV;
 
-	printk(KERN_INFO "i2c-piix4.o: Found %s device\n", PIIX4_dev->dev.name);
+	dev_info(&PIIX4_dev->dev, "Found %s device\n", PIIX4_dev->dev.name);
 
 	if(ibm_dmi_probe()) {
-		printk
-		  (KERN_ERR "i2c-piix4.o: IBM Laptop detected; this module may corrupt\n");
-		printk
-		  (KERN_ERR "             your serial eeprom! Refusing to load module!\n");
-		 error_return = -EPERM;
-		 goto END;
+		dev_err(&PIIX4_dev->dev, "IBM Laptop detected; this module "
+			"may corrupt your serial eeprom! Refusing to load "
+			"module!\n");
+		error_return = -EPERM;
+		goto END;
 	}
 
 /* Determine the address of the SMBus areas */
@@ -144,15 +146,16 @@
 		pci_read_config_word(PIIX4_dev, SMBBA, &piix4_smba);
 		piix4_smba &= 0xfff0;
 		if(piix4_smba == 0) {
-			printk(KERN_ERR "i2c-piix4.o: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+			dev_err(&PIIX4_dev->dev, "SMB base address "
+				"uninitialized - upgrade BIOS or use "
+				"force_addr=0xaddr\n");
 			return -ENODEV;
 		}
 	}
 
 	if (!request_region(piix4_smba, 8, "piix4-smbus")) {
-		printk
-		    (KERN_ERR "i2c-piix4.o: SMB region 0x%x already in use!\n",
-		     piix4_smba);
+		dev_err(&PIIX4_dev->dev, "SMB region 0x%x already in use!\n",
+			piix4_smba);
 		error_return = -ENODEV;
 		goto END;
 	}
@@ -164,9 +167,8 @@
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp & 0xfe);
 		pci_write_config_word(PIIX4_dev, SMBBA, piix4_smba);
 		pci_write_config_byte(PIIX4_dev, SMBHSTCFG, temp | 0x01);
-		printk
-		    (KERN_INFO "i2c-piix4.o: WARNING: SMBus interface set to new "
-		     "address %04x!\n", piix4_smba);
+		dev_info(&PIIX4_dev->dev, "WARNING: SMBus interface set to "
+			"new address %04x!\n", piix4_smba);
 	} else if ((temp & 1) == 0) {
 		if (force) {
 /* This should never need to be done, but has been noted that
@@ -177,33 +179,28 @@
    resorting to this.  */
 			pci_write_config_byte(PIIX4_dev, SMBHSTCFG,
 					      temp | 1);
-			printk
-			    (KERN_NOTICE "i2c-piix4.o: WARNING: SMBus interface has been FORCEFULLY "
-			     "ENABLED!\n");
+			dev_printk(KERN_NOTICE, &PIIX4_dev->dev,
+				"WARNING: SMBus interface has been "
+				"FORCEFULLY ENABLED!\n");
 		} else {
-			printk
-			    (KERN_ERR "i2c-piix4.o: Host SMBus controller not enabled!\n");
+			dev_err(&PIIX4_dev->dev,
+				"Host SMBus controller not enabled!\n");
 			error_return = -ENODEV;
 			goto END;
 		}
 	}
 
-#ifdef DEBUG
 	if ((temp & 0x0E) == 8)
-		printk
-		    (KERN_DEBUG "i2c-piix4.o: Using Interrupt 9 for SMBus.\n");
+		dev_dbg(&PIIX4_dev->dev, "Using Interrupt 9 for SMBus.\n");
 	else if ((temp & 0x0E) == 0)
-		printk
-		    (KERN_DEBUG "i2c-piix4.o: Using Interrupt SMI# for SMBus.\n");
+		dev_dbg(&PIIX4_dev->dev, "Using Interrupt SMI# for SMBus.\n");
 	else
-		printk
-		    (KERN_ERR "i2c-piix4.o: Illegal Interrupt configuration (or code out "
-		     "of date)!\n");
+		dev_err(&PIIX4_dev->dev, "Illegal Interrupt configuration "
+			"(or code out of date)!\n");
 
 	pci_read_config_byte(PIIX4_dev, SMBREV, &temp);
-	printk(KERN_DEBUG "i2c-piix4.o: SMBREV = 0x%X\n", temp);
-	printk(KERN_DEBUG "i2c-piix4.o: SMBA = 0x%X\n", piix4_smba);
-#endif				/* DEBUG */
+	dev_dbg(&PIIX4_dev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&PIIX4_dev->dev, "SMBA = 0x%X\n", piix4_smba);
 
       END:
 	return error_return;
@@ -224,29 +221,21 @@
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
-	printk
-	    (KERN_DEBUG "i2c-piix4.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
-	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&piix4_adapter.dev, "Transaction (pre): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-piix4.o: SMBus busy (%02x). Resetting... \n",
-		       temp);
-#endif
+		dev_dbg(&piix4_adapter.dev, "SMBus busy (%02x). "
+			"Resetting... \n", temp);
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-#ifdef DEBUG
-			printk(KERN_ERR "i2c-piix4.o: Failed! (%02x)\n", temp);
-#endif
+			dev_err(&piix4_adapter.dev, "Failed! (%02x)\n", temp);
 			return -1;
 		} else {
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-piix4.o: Successfull!\n");
-#endif
+			dev_dbg(&piix4_adapter.dev, "Successfull!\n");
 		}
 	}
 
@@ -259,50 +248,40 @@
 		temp = inb_p(SMBHSTSTS);
 	} while ((temp & 0x01) && (timeout++ < MAX_TIMEOUT));
 
-#ifdef DEBUG
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		printk(KERN_ERR "i2c-piix4.o: SMBus Timeout!\n");
+		dev_err(&piix4_adapter.dev, "SMBus Timeout!\n");
 		result = -1;
 	}
-#endif
 
 	if (temp & 0x10) {
 		result = -1;
-#ifdef DEBUG
-		printk(KERN_ERR "i2c-piix4.o: Error: Failed bus transaction\n");
-#endif
+		dev_err(&piix4_adapter.dev, "Error: Failed bus transaction\n");
 	}
 
 	if (temp & 0x08) {
 		result = -1;
-		printk
-		    (KERN_ERR "i2c-piix4.o: Bus collision! SMBus may be locked until next hard\n"
-		     "reset. (sorry!)\n");
+		dev_dbg(&piix4_adapter.dev, "Bus collision! SMBus may be "
+			"locked until next hard reset. (sorry!)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
 	}
 
 	if (temp & 0x04) {
 		result = -1;
-#ifdef DEBUG
-		printk(KERN_ERR "i2c-piix4.o: Error: no response!\n");
-#endif
+		dev_err(&piix4_adapter.dev, "Error: no response!\n");
 	}
 
 	if (inb_p(SMBHSTSTS) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
-#ifdef DEBUG
 	if ((temp = inb_p(SMBHSTSTS)) != 0x00) {
-		printk
-		    (KERN_ERR "i2c-piix4.o: Failed reset at end of transaction (%02x)\n",
-		     temp);
-	}
-	printk
-	    (KERN_DEBUG "i2c-piix4.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
-	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+		dev_err(&piix4_adapter.dev, "Failed reset at end of "
+			"transaction (%02x)\n", temp);
+	}
+	dev_dbg(&piix4_adapter.dev, "Transaction (post): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 	return result;
 }
 
@@ -315,8 +294,7 @@
 
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		printk
-		    (KERN_ERR "i2c-piix4.o: I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_err(&adap->dev, "I2C_SMBUS_PROC_CALL not supported!\n");
 		return -1;
 	case I2C_SMBUS_QUICK:
 		outb_p(((addr & 0x7f) << 1) | (read_write & 0x01),
@@ -496,7 +474,7 @@
 
 static int __init i2c_piix4_init(void)
 {
-	printk("i2c-piix4.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c-piix4 version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&piix4_driver);
 }
 

