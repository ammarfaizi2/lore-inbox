Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262679AbTCTWVu>; Thu, 20 Mar 2003 17:21:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262703AbTCTWVt>; Thu, 20 Mar 2003 17:21:49 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:26629 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262679AbTCTWV1>;
	Thu, 20 Mar 2003 17:21:27 -0500
Subject: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <20030320223046.GA4959@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
X-mailer: gregkh_patchbomb
Message-id: <10481995574110@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.1, 2003/03/18 14:27:40-08:00, greg@kroah.com

[PATCH] i2c i2c-i801.c: remove #ifdefs and fix all printk() to use dev_*().


 drivers/i2c/busses/i2c-i801.c |  157 +++++++++++++++---------------------------
 1 files changed, 58 insertions(+), 99 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-i801.c b/drivers/i2c/busses/i2c-i801.c
--- a/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:58:22 2003
+++ b/drivers/i2c/busses/i2c-i801.c	Thu Mar 20 12:58:22 2003
@@ -152,15 +152,15 @@
 		pci_read_config_word(I801_dev, SMBBA, &i801_smba);
 		i801_smba &= 0xfff0;
 		if(i801_smba == 0) {
-			printk(KERN_ERR "i2c-i801.o: SMB base address uninitialized - upgrade BIOS or use force_addr=0xaddr\n");
+			dev_err(&dev->dev, "SMB base address uninitialized"
+				"- upgrade BIOS or use force_addr=0xaddr\n");
 			return -ENODEV;
 		}
 	}
 
 	if (check_region(i801_smba, (isich4 ? 16 : 8))) {
-		printk
-		    (KERN_ERR "i2c-i801.o: I801_smb region 0x%x already in use!\n",
-		     i801_smba);
+		dev_err(&dev->dev, "I801_smb region 0x%x already in use!\n",
+			i801_smba);
 		error_return = -ENODEV;
 		goto END;
 	}
@@ -174,28 +174,23 @@
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp & 0xfe);
 		pci_write_config_word(I801_dev, SMBBA, i801_smba);
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 0x01);
-		printk
-		    (KERN_WARNING "i2c-i801.o: WARNING: I801 SMBus interface set to new "
-		     "address %04x!\n", i801_smba);
+		dev_warn(&dev->dev, "WARNING: I801 SMBus interface set to "
+			"new address %04x!\n", i801_smba);
 	} else if ((temp & 1) == 0) {
 		pci_write_config_byte(I801_dev, SMBHSTCFG, temp | 1);
-		printk(KERN_WARNING "i2c-i801.o: enabling SMBus device\n");
+		dev_warn(&dev->dev, "enabling SMBus device\n");
 	}
 
 	request_region(i801_smba, (isich4 ? 16 : 8), "i801-smbus");
 
-#ifdef DEBUG
 	if (temp & 0x02)
-		printk
-		    (KERN_DEBUG "i2c-i801.o: I801 using Interrupt SMI# for SMBus.\n");
+		dev_dbg(&dev->dev, "I801 using Interrupt SMI# for SMBus.\n");
 	else
-		printk
-		    (KERN_DEBUG "i2c-i801.o: I801 using PCI Interrupt for SMBus.\n");
+		dev_dbg(&dev->dev, "I801 using PCI Interrupt for SMBus.\n");
 
 	pci_read_config_byte(I801_dev, SMBREV, &temp);
-	printk(KERN_DEBUG "i2c-i801.o: SMBREV = 0x%X\n", temp);
-	printk(KERN_DEBUG "i2c-i801.o: I801_smba = 0x%X\n", i801_smba);
-#endif				/* DEBUG */
+	dev_dbg(&dev->dev, "SMBREV = 0x%X\n", temp);
+	dev_dbg(&dev->dev, "I801_smba = 0x%X\n", i801_smba);
 
       END:
 	return error_return;
@@ -214,30 +209,22 @@
 	int result = 0;
 	int timeout = 0;
 
-#ifdef DEBUG
-	printk
-	    (KERN_DEBUG "i2c-i801.o: Transaction (pre): CNT=%02x, CMD=%02x, ADD=%02x, DAT0=%02x, "
-	     "DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&I801_dev->dev, "Transaction (pre): CNT=%02x, CMD=%02x,"
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	/* 0x1f = Failed, Bus_Err, Dev_Err, Intr, Host_Busy */
 	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-i801.o: SMBus busy (%02x). Resetting... \n",
-		       temp);
-#endif
+		dev_dbg(&I801_dev->dev, "SMBus busy (%02x). Resetting... \n",
+			temp);
 		outb_p(temp, SMBHSTSTS);
 		if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-i801.o: Failed! (%02x)\n", temp);
-#endif
+			dev_dbg(&I801_dev->dev, "Failed! (%02x)\n", temp);
 			return -1;
 		} else {
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-i801.o: Successfull!\n");
-#endif
+			dev_dbg(&I801_dev->dev, "Successfull!\n");
 		}
 	}
 
@@ -251,50 +238,38 @@
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-i801.o: SMBus Timeout!\n");
+		dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
 		result = -1;
-#endif
 	}
 
 	if (temp & 0x10) {
 		result = -1;
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-i801.o: Error: Failed bus transaction\n");
-#endif
+		dev_dbg(&I801_dev->dev, "Error: Failed bus transaction\n");
 	}
 
 	if (temp & 0x08) {
 		result = -1;
-		printk
-		    (KERN_ERR "i2c-i801.o: Bus collision! SMBus may be locked until next hard\n"
-		     "reset. (sorry!)\n");
+		dev_err(&I801_dev->dev, "Bus collision! SMBus may be locked "
+			"until next hard reset. (sorry!)\n");
 		/* Clock stops and slave is stuck in mid-transmission */
 	}
 
 	if (temp & 0x04) {
 		result = -1;
-#ifdef DEBUG
-		printk(KERN_DEBUG "i2c-i801.o: Error: no response!\n");
-#endif
+		dev_dbg(&I801_dev->dev, "Error: no response!\n");
 	}
 
 	if ((inb_p(SMBHSTSTS) & 0x1f) != 0x00)
 		outb_p(inb(SMBHSTSTS), SMBHSTSTS);
 
 	if ((temp = (0x1f & inb_p(SMBHSTSTS))) != 0x00) {
-#ifdef DEBUG
-		printk
-		    (KERN_DEBUG "i2c-i801.o: Failed reset at end of transaction (%02x)\n",
-		     temp);
-#endif
+		dev_dbg(&I801_dev->dev, "Failed reset at end of transaction"
+			"(%02x)\n", temp);
 	}
-#ifdef DEBUG
-	printk
-	    (KERN_DEBUG "i2c-i801.o: Transaction (post): CNT=%02x, CMD=%02x, ADD=%02x, "
-	     "DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT), inb_p(SMBHSTCMD),
-	     inb_p(SMBHSTADD), inb_p(SMBHSTDAT0), inb_p(SMBHSTDAT1));
-#endif
+	dev_dbg(&I801_dev->dev, "Transaction (post): CNT=%02x, CMD=%02x, "
+		"ADD=%02x, DAT0=%02x, DAT1=%02x\n", inb_p(SMBHSTCNT),
+		inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
+		inb_p(SMBHSTDAT1));
 	return result;
 }
 
@@ -316,8 +291,8 @@
                         pci_write_config_byte(I801_dev, SMBHSTCFG, 
                                               hostc | SMBHSTCFG_I2C_EN);
                 } else {
-                        printk("i2c-i801.o: "
-                               "I2C_SMBUS_I2C_BLOCK_READ not supported!\n");
+                        dev_err(&I801_dev->dev,
+				"I2C_SMBUS_I2C_BLOCK_READ not supported!\n");
                         return -1;
                 }
         }
@@ -349,13 +324,10 @@
 #endif
 		outb_p(smbcmd | ENABLE_INT9, SMBHSTCNT);
 
-#ifdef DEBUG
-		printk
-		    (KERN_DEBUG "i2c-i801.o: Block (pre %d): CNT=%02x, CMD=%02x, ADD=%02x, "
-		     "DAT0=%02x, BLKDAT=%02x\n", i, inb_p(SMBHSTCNT),
-		     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-		     inb_p(SMBBLKDAT));
-#endif
+		dev_dbg(&I801_dev->dev, "Block (pre %d): CNT=%02x, CMD=%02x, "
+			"ADD=%02x, DAT0=%02x, BLKDAT=%02x\n", i,
+			inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
+			inb_p(SMBHSTDAT0), inb_p(SMBBLKDAT));
 
 		/* Make sure the SMBus host is ready to start transmitting */
 		temp = inb_p(SMBHSTSTS);
@@ -369,16 +341,12 @@
                     errmask=0x1e; 
                 }
 		if (temp & errmask) {
-#ifdef DEBUG
-			printk
-			    (KERN_DEBUG "i2c-i801.o: SMBus busy (%02x). Resetting... \n",
-			     temp);
-#endif
+			dev_dbg(&I801_dev->dev, "SMBus busy (%02x). "
+				"Resetting... \n", temp);
 			outb_p(temp, SMBHSTSTS);
 			if (((temp = inb_p(SMBHSTSTS)) & errmask) != 0x00) {
-				printk
-				    (KERN_ERR "i2c-i801.o: Reset failed! (%02x)\n",
-				     temp);
+				dev_err(&I801_dev->dev,
+					"Reset failed! (%02x)\n", temp);
 				result = -1;
                                 goto END;
 			}
@@ -410,25 +378,19 @@
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
 			result = -1;
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-i801.o: SMBus Timeout!\n");
-#endif
+			dev_dbg(&I801_dev->dev, "SMBus Timeout!\n");
 		}
 
 		if (temp & 0x10) {
 			result = -1;
-#ifdef DEBUG
-			printk
-			    (KERN_DEBUG "i2c-i801.o: Error: Failed bus transaction\n");
-#endif
+			dev_dbg(&I801_dev->dev,
+				"Error: Failed bus transaction\n");
 		} else if (temp & 0x08) {
 			result = -1;
-			printk(KERN_ERR "i2c-i801.o: Bus collision!\n");
+			dev_err(&I801_dev->dev, "Bus collision!\n");
 		} else if (temp & 0x04) {
 			result = -1;
-#ifdef DEBUG
-			printk(KERN_DEBUG "i2c-i801.o: Error: no response!\n");
-#endif
+			dev_dbg(&I801_dev->dev, "Error: no response!\n");
 		}
 
 		if (i == 1 && read_write == I2C_SMBUS_READ) {
@@ -448,18 +410,15 @@
 		if ((temp & 0x9e) != 0x00)
 			outb_p(temp, SMBHSTSTS);  /* signals SMBBLKDAT ready */
 
-#ifdef DEBUG
 		if ((temp = (0x1e & inb_p(SMBHSTSTS))) != 0x00) {
-			printk
-			    (KERN_DEBUG "i2c-i801.o: Bad status (%02x) at end of transaction\n",
-			     temp);
-		}
-		printk
-		    (KERN_DEBUG "i2c-i801.o: Block (post %d): CNT=%02x, CMD=%02x, ADD=%02x, "
-		     "DAT0=%02x, BLKDAT=%02x\n", i, inb_p(SMBHSTCNT),
-		     inb_p(SMBHSTCMD), inb_p(SMBHSTADD), inb_p(SMBHSTDAT0),
-		     inb_p(SMBBLKDAT));
-#endif
+			dev_dbg(&I801_dev->dev,
+				"Bad status (%02x) at end of transaction\n",
+				temp);
+		}
+		dev_dbg(&I801_dev->dev, "Block (post %d): CNT=%02x, CMD=%02x, "
+			"ADD=%02x, DAT0=%02x, BLKDAT=%02x\n", i,
+			inb_p(SMBHSTCNT), inb_p(SMBHSTCMD), inb_p(SMBHSTADD),
+			inb_p(SMBHSTDAT0), inb_p(SMBBLKDAT));
 
 		if (result < 0)
 			goto END;
@@ -476,7 +435,7 @@
 			   && (timeout++ < MAX_TIMEOUT));
 
 		if (timeout >= MAX_TIMEOUT) {
-			printk(KERN_DEBUG "i2c-i801.o: PEC Timeout!\n");
+			dev_dbg(&I801_dev->dev, "PEC Timeout!\n");
 		}
 #if 0 /* now using HW PEC */
 		if(read_write == I2C_SMBUS_READ) {
@@ -554,7 +513,7 @@
 		break;
 	case I2C_SMBUS_PROC_CALL:
 	default:
-		printk(KERN_ERR "i2c-i801.o: Unsupported transaction %d\n", size);
+		dev_err(&I801_dev->dev, "Unsupported transaction %d\n", size);
 		return -1;
 	}
 
@@ -667,8 +626,8 @@
 {
 
 	if (i801_setup(dev)) {
-		printk
-		    (KERN_WARNING "i2c-i801.o: I801 not detected, module not inserted.\n");
+		dev_warn(&dev->dev,
+			"I801 not detected, module not inserted.\n");
 		return -ENODEV;
 	}
 
@@ -694,7 +653,7 @@
 
 static int __init i2c_i801_init(void)
 {
-	printk(KERN_INFO "i2c-i801.o version %s (%s)\n", I2C_VERSION, I2C_DATE);
+	printk(KERN_INFO "i2c-i801 version %s (%s)\n", I2C_VERSION, I2C_DATE);
 	return pci_module_init(&i801_driver);
 }
 

