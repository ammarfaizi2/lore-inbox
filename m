Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261457AbVFOO24@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261457AbVFOO24 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Jun 2005 10:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261463AbVFOO24
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Jun 2005 10:28:56 -0400
Received: from e31.co.us.ibm.com ([32.97.110.129]:49545 "EHLO
	e31.co.us.ibm.com") by vger.kernel.org with ESMTP id S261457AbVFOO2S
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Jun 2005 10:28:18 -0400
Subject: [PATCH] tpm: Support new National TPMs
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, jens.taprogge@post.rwth-aachen.de,
       tcimpl2005@yahoo.com
Content-Type: text/plain
Date: Wed, 15 Jun 2005 09:28:14 -0500
Message-Id: <1118845694.7037.32.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is work to support new National TPMs that problems were
reported with on Thinkpad T43 and Thinkcentre S51. Thanks to Jens and
Gang for their debugging work on these issues.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN --exclude='*.ko' --exclude='*.o' --exclude='*.mod*' --exclude='.*' --exclude='*~' --exclude='*.orig' linux-2.6.12-rc6/drivers/char/tpm/tpm_atmel.c linux-2.6.12-rc5-mm2/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.12-rc6/drivers/char/tpm/tpm_atmel.c	2005-06-14 08:33:05.000000000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/char/tpm/tpm_atmel.c	2005-06-13 16:45:36.000000000 -0500
@@ -163,24 +161,24 @@ static int __devinit tpm_atml_init(struc
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 
-	lo = tpm_read_index( TPM_ATMEL_BASE_ADDR_LO );
-	hi = tpm_read_index( TPM_ATMEL_BASE_ADDR_HI );
+	lo = tpm_read_index( TPM_ADDR, TPM_ATMEL_BASE_ADDR_LO );
+	hi = tpm_read_index( TPM_ADDR, TPM_ATMEL_BASE_ADDR_HI );
 
 	tpm_atmel.base = (hi<<8)|lo;
 	dev_dbg( &pci_dev->dev, "Operating with base: 0x%x\n", tpm_atmel.base);
 
 	/* verify that it is an Atmel part */
-	if (tpm_read_index(4) != 'A' || tpm_read_index(5) != 'T'
-	    || tpm_read_index(6) != 'M' || tpm_read_index(7) != 'L') {
+	if (tpm_read_index(TPM_ADDR, 4) != 'A' || tpm_read_index(TPM_ADDR, 5) != 'T'
+	    || tpm_read_index(TPM_ADDR, 6) != 'M' || tpm_read_index(TPM_ADDR, 7) != 'L') {
 		rc = -ENODEV;
 		goto out_err;
 	}
 
 	/* query chip for its version number */
-	if ((version[0] = tpm_read_index(0x00)) != 0xFF) {
-		version[1] = tpm_read_index(0x01);
-		version[2] = tpm_read_index(0x02);
-		version[3] = tpm_read_index(0x03);
+	if ((version[0] = tpm_read_index(TPM_ADDR, 0x00)) != 0xFF) {
+		version[1] = tpm_read_index(TPM_ADDR, 0x01);
+		version[2] = tpm_read_index(TPM_ADDR, 0x02);
+		version[3] = tpm_read_index(TPM_ADDR, 0x03);
 	} else {
 		dev_info(&pci_dev->dev, "version query failed\n");
 		rc = -ENODEV;
diff -uprN --exclude='*.ko' --exclude='*.o' --exclude='*.mod*' --exclude='.*' --exclude='*~' --exclude='*.orig' linux-2.6.12-rc6/drivers/char/tpm/tpm.h linux-2.6.12-rc5-mm2/drivers/char/tpm/tpm.h
--- linux-2.6.12-rc6/drivers/char/tpm/tpm.h	2005-06-14 08:33:05.000000000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/char/tpm/tpm.h	2005-06-13 16:45:36.000000000 -0500
@@ -31,8 +31,8 @@ enum tpm_timeout {
 
 /* TPM addresses */
 enum tpm_addr {
+	TPM_SUPERIO_ADDR = 0x2E,
 	TPM_ADDR = 0x4E,
-	TPM_DATA = 0x4F
 };
 
 extern ssize_t tpm_show_pubek(struct device *, struct device_attribute *attr,
@@ -79,16 +79,16 @@ struct tpm_chip {
 	struct list_head list;
 };
 
-static inline int tpm_read_index(int index)
+static inline int tpm_read_index(int base, int index)
 {
-	outb(index, TPM_ADDR);
-	return inb(TPM_DATA) & 0xFF;
+	outb(index, base);
+	return inb(base+1) & 0xFF;
 }
 
-static inline void tpm_write_index(int index, int value)
+static inline void tpm_write_index(int base, int index, int value)
 {
-	outb(index, TPM_ADDR);
-	outb(value & 0xFF, TPM_DATA);
+	outb(index, base);
+	outb(value & 0xFF, base+1);
 }
 
 extern int tpm_register_hardware(struct pci_dev *,
diff -uprN --exclude='*.ko' --exclude='*.o' --exclude='*.mod*' --exclude='.*' --exclude='*~' --exclude='*.orig' linux-2.6.12-rc6/drivers/char/tpm/tpm_nsc.c linux-2.6.12-rc5-mm2/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.12-rc6/drivers/char/tpm/tpm_nsc.c	2005-06-14 08:33:05.000000000 -0500
+++ linux-2.6.12-rc5-mm2/drivers/char/tpm/tpm_nsc.c	2005-06-15 08:56:30.000000000 -0500
@@ -23,7 +23,6 @@
 
 /* National definitions */
 enum tpm_nsc_addr{
-	TPM_NSC_BASE = 0x360,
 	TPM_NSC_IRQ = 0x07,
 	TPM_NSC_BASE0_HI = 0x60,
 	TPM_NSC_BASE0_LO = 0x61,
@@ -56,6 +55,7 @@ enum tpm_nsc_status {
 	NSC_STATUS_RDY = 0x10,	/* ready to receive command */
 	NSC_STATUS_IBR = 0x20	/* ready to receive data */
 };
+
 /* command bits */
 enum tpm_nsc_cmd_mode {
 	NSC_COMMAND_NORMAL = 0x01,	/* normal mode */
@@ -150,7 +149,8 @@ static int tpm_nsc_recv(struct tpm_chip 
 		*p = inb(chip->vendor->base + NSC_DATA);
 	}
 
-	if ((data & NSC_STATUS_F0) == 0) {
+	if ((data & NSC_STATUS_F0) == 0 && 
+	(wait_for_stat(chip, NSC_STATUS_F0, NSC_STATUS_F0, &data) < 0)) {
 		dev_err(&chip->pci_dev->dev, "F0 not set\n");
 		return -EIO;
 	}
@@ -259,85 +258,64 @@ static int __devinit tpm_nsc_init(struct
 {
 	int rc = 0;
 	int lo, hi;
+	int nscAddrBase = TPM_ADDR;
 
-	hi = tpm_read_index(TPM_NSC_BASE0_HI);
-	lo = tpm_read_index(TPM_NSC_BASE0_LO);
-
-	tpm_nsc.base = (hi<<8) | lo;
 
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 
+	/* select PM channel 1 */
+	tpm_write_index(nscAddrBase,NSC_LDN_INDEX, 0x12);
+	
 	/* verify that it is a National part (SID) */
-	if (tpm_read_index(NSC_SID_INDEX) != 0xEF) {
-		rc = -ENODEV;
-		goto out_err;
+	if (tpm_read_index(TPM_ADDR, NSC_SID_INDEX) != 0xEF) {
+		nscAddrBase = (tpm_read_index(TPM_SUPERIO_ADDR, 0x2C)<<8)|
+			(tpm_read_index(TPM_SUPERIO_ADDR, 0x2B)&0xFE);
+		if ( tpm_read_index(nscAddrBase, NSC_SID_INDEX) != 0xF6 ) {
+			rc = -ENODEV;
+			goto out_err;
+		}
 	}
 
+	hi = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_HI);
+	lo = tpm_read_index(nscAddrBase, TPM_NSC_BASE0_LO);
+	tpm_nsc.base = (hi<<8) | lo;
+
 	dev_dbg(&pci_dev->dev, "NSC TPM detected\n");
 	dev_dbg(&pci_dev->dev,
 		"NSC LDN 0x%x, SID 0x%x, SRID 0x%x\n",
-		tpm_read_index(0x07), tpm_read_index(0x20),
-		tpm_read_index(0x27));
+		tpm_read_index(nscAddrBase,0x07), tpm_read_index(nscAddrBase,0x20),
+		tpm_read_index(nscAddrBase,0x27));
 	dev_dbg(&pci_dev->dev,
 		"NSC SIOCF1 0x%x SIOCF5 0x%x SIOCF6 0x%x SIOCF8 0x%x\n",
-		tpm_read_index(0x21), tpm_read_index(0x25),
-		tpm_read_index(0x26), tpm_read_index(0x28));
+		tpm_read_index(nscAddrBase,0x21), tpm_read_index(nscAddrBase,0x25),
+		tpm_read_index(nscAddrBase,0x26), tpm_read_index(nscAddrBase,0x28));
 	dev_dbg(&pci_dev->dev, "NSC IO Base0 0x%x\n",
-		(tpm_read_index(0x60) << 8) | tpm_read_index(0x61));
+		(tpm_read_index(nscAddrBase,0x60) << 8) | tpm_read_index(nscAddrBase,0x61));
 	dev_dbg(&pci_dev->dev, "NSC IO Base1 0x%x\n",
-		(tpm_read_index(0x62) << 8) | tpm_read_index(0x63));
+		(tpm_read_index(nscAddrBase,0x62) << 8) | tpm_read_index(nscAddrBase,0x63));
 	dev_dbg(&pci_dev->dev, "NSC Interrupt number and wakeup 0x%x\n",
-		tpm_read_index(0x70));
+		tpm_read_index(nscAddrBase,0x70));
 	dev_dbg(&pci_dev->dev, "NSC IRQ type select 0x%x\n",
-		tpm_read_index(0x71));
+		tpm_read_index(nscAddrBase,0x71));
 	dev_dbg(&pci_dev->dev,
 		"NSC DMA channel select0 0x%x, select1 0x%x\n",
-		tpm_read_index(0x74), tpm_read_index(0x75));
+		tpm_read_index(nscAddrBase,0x74), tpm_read_index(nscAddrBase,0x75));
 	dev_dbg(&pci_dev->dev,
 		"NSC Config "
 		"0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x 0x%x\n",
-		tpm_read_index(0xF0), tpm_read_index(0xF1),
-		tpm_read_index(0xF2), tpm_read_index(0xF3),
-		tpm_read_index(0xF4), tpm_read_index(0xF5),
-		tpm_read_index(0xF6), tpm_read_index(0xF7),
-		tpm_read_index(0xF8), tpm_read_index(0xF9));
+		tpm_read_index(nscAddrBase,0xF0), tpm_read_index(nscAddrBase,0xF1),
+		tpm_read_index(nscAddrBase,0xF2), tpm_read_index(nscAddrBase,0xF3),
+		tpm_read_index(nscAddrBase,0xF4), tpm_read_index(nscAddrBase,0xF5),
+		tpm_read_index(nscAddrBase,0xF6), tpm_read_index(nscAddrBase,0xF7),
+		tpm_read_index(nscAddrBase,0xF8), tpm_read_index(nscAddrBase,0xF9));
 
 	dev_info(&pci_dev->dev,
-		 "NSC PC21100 TPM revision %d\n",
-		 tpm_read_index(0x27) & 0x1F);
-
-	if (tpm_read_index(NSC_LDC_INDEX) == 0)
-		dev_info(&pci_dev->dev, ": NSC TPM not active\n");
-
-	/* select PM channel 1 */
-	tpm_write_index(NSC_LDN_INDEX, 0x12);
-	tpm_read_index(NSC_LDN_INDEX);
-
-	/* disable the DPM module */
-	tpm_write_index(NSC_LDC_INDEX, 0);
-	tpm_read_index(NSC_LDC_INDEX);
-
-	/* set the data register base addresses */
-	tpm_write_index(NSC_DIO_INDEX, TPM_NSC_BASE >> 8);
-	tpm_write_index(NSC_DIO_INDEX + 1, TPM_NSC_BASE);
-	tpm_read_index(NSC_DIO_INDEX);
-	tpm_read_index(NSC_DIO_INDEX + 1);
-
-	/* set the command register base addresses */
-	tpm_write_index(NSC_CIO_INDEX, (TPM_NSC_BASE + 1) >> 8);
-	tpm_write_index(NSC_CIO_INDEX + 1, (TPM_NSC_BASE + 1));
-	tpm_read_index(NSC_DIO_INDEX);
-	tpm_read_index(NSC_DIO_INDEX + 1);
-
-	/* set the interrupt number to be used for the host interface */
-	tpm_write_index(NSC_IRQ_INDEX, TPM_NSC_IRQ);
-	tpm_write_index(NSC_ITS_INDEX, 0x00);
-	tpm_read_index(NSC_IRQ_INDEX);
+		 "NSC TPM revision %d\n",
+		 tpm_read_index(nscAddrBase, 0x27) & 0x1F);
 
 	/* enable the DPM module */
-	tpm_write_index(NSC_LDC_INDEX, 0x01);
-	tpm_read_index(NSC_LDC_INDEX);
+	tpm_write_index(nscAddrBase, NSC_LDC_INDEX, 0x01);
 
 	if ((rc = tpm_register_hardware(pci_dev, &tpm_nsc)) < 0)
 		goto out_err;
@@ -355,6 +333,9 @@ static struct pci_device_id tpm_pci_tbl[
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801DB_12)},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_82801EB_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_0)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH6_1)},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_ICH7_0)},
 	{PCI_DEVICE(PCI_VENDOR_ID_AMD, PCI_DEVICE_ID_AMD_8111_LPC)},
 	{0,}
 };


