Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262723AbTCTWgn>; Thu, 20 Mar 2003 17:36:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262722AbTCTWY3>; Thu, 20 Mar 2003 17:24:29 -0500
Received: from 12-231-249-244.client.attbi.com ([12.231.249.244]:40709 "HELO
	kroah.com") by vger.kernel.org with SMTP id <S262704AbTCTWVj>;
	Thu, 20 Mar 2003 17:21:39 -0500
Subject: Re: [PATCH] i2c driver changes for 2.5.65
In-reply-to: <10481995733467@kroah.com>
Content-Transfer-Encoding: 7BIT
To: linux-kernel@vger.kernel.org, sensors@stimpy.netroedge.com
From: Greg KH <greg@kroah.com>
Content-Type: text/plain; charset=US-ASCII
Mime-version: 1.0
Date: Thu, 20 Mar 2003 14:32 -0800
Message-id: <1048199573873@kroah.com>
X-mailer: gregkh_patchbomb
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

ChangeSet 1.1143.1.12, 2003/03/20 11:15:57-08:00, greg@kroah.com

[PATCH] i2c i2c-amd756.c: remove some #ifdefs and fix all printk() to use dev_*().

Also some minor whitespace cleanups.


 drivers/i2c/busses/i2c-amd756.c |  142 +++++++++++++++++++---------------------
 1 files changed, 70 insertions(+), 72 deletions(-)


diff -Nru a/drivers/i2c/busses/i2c-amd756.c b/drivers/i2c/busses/i2c-amd756.c
--- a/drivers/i2c/busses/i2c-amd756.c	Thu Mar 20 12:54:12 2003
+++ b/drivers/i2c/busses/i2c-amd756.c	Thu Mar 20 12:54:12 2003
@@ -35,6 +35,8 @@
    Note: we assume there can only be one device, with one SMBus interface.
 */
 
+/* #define DEBUG 1 */
+
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -46,44 +48,42 @@
 #include <linux/init.h>
 #include <asm/io.h>
 
-#define DRV_NAME	"i2c-amd756"
-
 /* AMD756 SMBus address offsets */
-#define SMB_ADDR_OFFSET        0xE0
-#define SMB_IOSIZE             16
-#define SMB_GLOBAL_STATUS      (0x0 + amd756_ioport)
-#define SMB_GLOBAL_ENABLE      (0x2 + amd756_ioport)
-#define SMB_HOST_ADDRESS       (0x4 + amd756_ioport)
-#define SMB_HOST_DATA          (0x6 + amd756_ioport)
-#define SMB_HOST_COMMAND       (0x8 + amd756_ioport)
-#define SMB_HOST_BLOCK_DATA    (0x9 + amd756_ioport)
-#define SMB_HAS_DATA           (0xA + amd756_ioport)
-#define SMB_HAS_DEVICE_ADDRESS (0xC + amd756_ioport)
-#define SMB_HAS_HOST_ADDRESS   (0xE + amd756_ioport)
-#define SMB_SNOOP_ADDRESS      (0xF + amd756_ioport)
+#define SMB_ADDR_OFFSET		0xE0
+#define SMB_IOSIZE		16
+#define SMB_GLOBAL_STATUS	(0x0 + amd756_ioport)
+#define SMB_GLOBAL_ENABLE	(0x2 + amd756_ioport)
+#define SMB_HOST_ADDRESS	(0x4 + amd756_ioport)
+#define SMB_HOST_DATA		(0x6 + amd756_ioport)
+#define SMB_HOST_COMMAND	(0x8 + amd756_ioport)
+#define SMB_HOST_BLOCK_DATA	(0x9 + amd756_ioport)
+#define SMB_HAS_DATA		(0xA + amd756_ioport)
+#define SMB_HAS_DEVICE_ADDRESS	(0xC + amd756_ioport)
+#define SMB_HAS_HOST_ADDRESS	(0xE + amd756_ioport)
+#define SMB_SNOOP_ADDRESS	(0xF + amd756_ioport)
 
 /* PCI Address Constants */
 
 /* address of I/O space */
-#define SMBBA     0x058		/* mh */
-#define SMBBANFORCE     0x014
+#define SMBBA		0x058		/* mh */
+#define SMBBANFORCE	0x014
 
 /* general configuration */
-#define SMBGCFG   0x041		/* mh */
+#define SMBGCFG		0x041		/* mh */
 
 /* silicon revision code */
-#define SMBREV    0x008
+#define SMBREV		0x008
 
 /* Other settings */
-#define MAX_TIMEOUT 500
+#define MAX_TIMEOUT	500
 
 /* AMD756 constants */
-#define AMD756_QUICK        0x00
-#define AMD756_BYTE         0x01
-#define AMD756_BYTE_DATA    0x02
-#define AMD756_WORD_DATA    0x03
-#define AMD756_PROCESS_CALL 0x04
-#define AMD756_BLOCK_DATA   0x05
+#define AMD756_QUICK		0x00
+#define AMD756_BYTE		0x01
+#define AMD756_BYTE_DATA	0x02
+#define AMD756_WORD_DATA	0x03
+#define AMD756_PROCESS_CALL	0x04
+#define AMD756_BLOCK_DATA	0x05
 
 
 static unsigned short amd756_ioport = 0;
@@ -101,36 +101,36 @@
 	schedule_timeout(amount);
 }
 
-#define GS_ABRT_STS (1 << 0)
-#define GS_COL_STS (1 << 1)
-#define GS_PRERR_STS (1 << 2)
-#define GS_HST_STS (1 << 3)
-#define GS_HCYC_STS (1 << 4)
-#define GS_TO_STS (1 << 5)
-#define GS_SMB_STS (1 << 11)
-
-#define GS_CLEAR_STS (GS_ABRT_STS | GS_COL_STS | GS_PRERR_STS | \
-  GS_HCYC_STS | GS_TO_STS )
-
-#define GE_CYC_TYPE_MASK (7)
-#define GE_HOST_STC (1 << 3)
-#define GE_ABORT (1 << 5)
+#define GS_ABRT_STS	(1 << 0)
+#define GS_COL_STS	(1 << 1)
+#define GS_PRERR_STS	(1 << 2)
+#define GS_HST_STS	(1 << 3)
+#define GS_HCYC_STS	(1 << 4)
+#define GS_TO_STS	(1 << 5)
+#define GS_SMB_STS	(1 << 11)
+
+#define GS_CLEAR_STS	(GS_ABRT_STS | GS_COL_STS | GS_PRERR_STS | \
+			 GS_HCYC_STS | GS_TO_STS )
+
+#define GE_CYC_TYPE_MASK	(7)
+#define GE_HOST_STC		(1 << 3)
+#define GE_ABORT		(1 << 5)
 
 
-static int amd756_transaction(void)
+static int amd756_transaction(struct i2c_adapter *adap)
 {
 	int temp;
 	int result = 0;
 	int timeout = 0;
 
-	pr_debug(DRV_NAME
-	       ": Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
-	       inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
-	       inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
+	dev_dbg(&adap->dev, ": Transaction (pre): GS=%04x, GE=%04x, ADD=%04x, "
+		"DAT=%04x\n", inw_p(SMB_GLOBAL_STATUS),
+		inw_p(SMB_GLOBAL_ENABLE), inw_p(SMB_HOST_ADDRESS),
+		inb_p(SMB_HOST_DATA));
 
 	/* Make sure the SMBus host is ready to start transmitting */
 	if ((temp = inw_p(SMB_GLOBAL_STATUS)) & (GS_HST_STS | GS_SMB_STS)) {
-		pr_debug(DRV_NAME ": SMBus busy (%04x). Waiting... \n", temp);
+		dev_dbg(&adap->dev, ": SMBus busy (%04x). Waiting... \n", temp);
 		do {
 			amd756_do_pause(1);
 			temp = inw_p(SMB_GLOBAL_STATUS);
@@ -138,7 +138,7 @@
 		         (timeout++ < MAX_TIMEOUT));
 		/* If the SMBus is still busy, we give up */
 		if (timeout >= MAX_TIMEOUT) {
-			pr_debug(DRV_NAME ": Busy wait timeout (%04x)\n", temp);
+			dev_dbg(&adap->dev, ": Busy wait timeout (%04x)\n", temp);
 			goto abort;
 		}
 		timeout = 0;
@@ -155,46 +155,46 @@
 
 	/* If the SMBus is still busy, we give up */
 	if (timeout >= MAX_TIMEOUT) {
-		pr_debug(DRV_NAME ": Completion timeout!\n");
+		dev_dbg(&adap->dev, ": Completion timeout!\n");
 		goto abort;
 	}
 
 	if (temp & GS_PRERR_STS) {
 		result = -1;
-		pr_debug(DRV_NAME ": SMBus Protocol error (no response)!\n");
+		dev_dbg(&adap->dev, ": SMBus Protocol error (no response)!\n");
 	}
 
 	if (temp & GS_COL_STS) {
 		result = -1;
-		printk(KERN_WARNING DRV_NAME " SMBus collision!\n");
+		dev_warn(&adap->dev, " SMBus collision!\n");
 	}
 
 	if (temp & GS_TO_STS) {
 		result = -1;
-		pr_debug(DRV_NAME ": SMBus protocol timeout!\n");
+		dev_dbg(&adap->dev, ": SMBus protocol timeout!\n");
 	}
 
 	if (temp & GS_HCYC_STS)
-		pr_debug(DRV_NAME " SMBus protocol success!\n");
+		dev_dbg(&adap->dev, " SMBus protocol success!\n");
 
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
 
 #ifdef DEBUG
 	if (((temp = inw_p(SMB_GLOBAL_STATUS)) & GS_CLEAR_STS) != 0x00) {
-		pr_debug(DRV_NAME
-		         ": Failed reset at end of transaction (%04x)\n", temp);
+		dev_dbg(&adap->dev,
+			": Failed reset at end of transaction (%04x)\n", temp);
 	}
-
-	pr_debug(DRV_NAME
-		 ": Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
-		 inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
-		 inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
 #endif
 
+	dev_dbg(&adap->dev,
+		": Transaction (post): GS=%04x, GE=%04x, ADD=%04x, DAT=%04x\n",
+		inw_p(SMB_GLOBAL_STATUS), inw_p(SMB_GLOBAL_ENABLE),
+		inw_p(SMB_HOST_ADDRESS), inb_p(SMB_HOST_DATA));
+
 	return result;
 
  abort:
-	printk(KERN_WARNING DRV_NAME ": Sending abort.\n");
+	dev_warn(&adap->dev, ": Sending abort.\n");
 	outw_p(inw(SMB_GLOBAL_ENABLE) | GE_ABORT, SMB_GLOBAL_ENABLE);
 	amd756_do_pause(100);
 	outw_p(GS_CLEAR_STS, SMB_GLOBAL_STATUS);
@@ -211,7 +211,7 @@
 	/** TODO: Should I supporte the 10-bit transfers? */
 	switch (size) {
 	case I2C_SMBUS_PROC_CALL:
-		pr_debug(DRV_NAME ": I2C_SMBUS_PROC_CALL not supported!\n");
+		dev_dbg(&adap->dev, ": I2C_SMBUS_PROC_CALL not supported!\n");
 		/* TODO: Well... It is supported, I'm just not sure what to do here... */
 		return -1;
 	case I2C_SMBUS_QUICK:
@@ -266,7 +266,7 @@
 	/* How about enabling interrupts... */
 	outw_p(size & GE_CYC_TYPE_MASK, SMB_GLOBAL_ENABLE);
 
-	if (amd756_transaction())	/* Error in transaction */
+	if (amd756_transaction(adap))	/* Error in transaction */
 		return -1;
 
 	if ((read_write == I2C_SMBUS_WRITE) || (size == AMD756_QUICK))
@@ -334,7 +334,7 @@
 	u8 temp;
 	
 	if (amd756_ioport) {
-		printk(KERN_ERR DRV_NAME ": Only one device supported. "
+		dev_err(&pdev->dev, ": Only one device supported. "
 		       "(you have a strange motherboard, btw..)\n");
 		return -ENODEV;
 	}
@@ -351,8 +351,8 @@
 
 		pci_read_config_byte(pdev, SMBGCFG, &temp);
 		if ((temp & 128) == 0) {
-			printk(KERN_ERR DRV_NAME
-			       ": Error: SMBus controller I/O not enabled!\n");
+			dev_err(&pdev->dev,
+				": Error: SMBus controller I/O not enabled!\n");
 			return -ENODEV;
 		}
 
@@ -364,16 +364,14 @@
 	}
 
 	if (!request_region(amd756_ioport, SMB_IOSIZE, "amd756-smbus")) {
-		printk(KERN_ERR DRV_NAME
-		       ": SMB region 0x%x already in use!\n", amd756_ioport);
+		dev_err(&pdev->dev, ": SMB region 0x%x already in use!\n",
+			amd756_ioport);
 		return -ENODEV;
 	}
 
-#ifdef DEBUG
 	pci_read_config_byte(pdev, SMBREV, &temp);
-	printk(KERN_DEBUG DRV_NAME ": SMBREV = 0x%X\n", temp);
-	printk(KERN_DEBUG DRV_NAME ": AMD756_smba = 0x%X\n", amd756_ioport);
-#endif
+	dev_dbg(&pdev->dev, ": SMBREV = 0x%X\n", temp);
+	dev_dbg(&pdev->dev, ": AMD756_smba = 0x%X\n", amd756_ioport);
 
 	/* set up the driverfs linkage to our parent device */
 	amd756_adapter.dev.parent = &pdev->dev;
@@ -383,8 +381,8 @@
 
 	error = i2c_add_adapter(&amd756_adapter);
 	if (error) {
-		printk(KERN_ERR DRV_NAME
-		       ": Adapter registration failed, module not inserted.\n");
+		dev_err(&pdev->dev,
+			": Adapter registration failed, module not inserted.\n");
 		goto out_err;
 	}
 

