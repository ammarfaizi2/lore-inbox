Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262152AbVELWSD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262152AbVELWSD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 May 2005 18:18:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262154AbVELWSD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 May 2005 18:18:03 -0400
Received: from e2.ny.us.ibm.com ([32.97.182.142]:24985 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262152AbVELWRb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 May 2005 18:17:31 -0400
Date: Thu, 12 May 2005 17:17:19 -0500 (CDT)
From: Kylene Hall <kjhall@us.ibm.com>
X-X-Sender: kjhall@localhost.localdomain
To: akpm@osdl.org
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] tpm: replace odd LPC init function
Message-ID: <Pine.LNX.4.62.0505111720550.28226@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Realized the tpm_lpc_init function isn't really necessary.  Replaced it 
with vendor specific logic to find out the address the BIOS mapped the TPM 
to.  This patch removes the tpm_lpc_init function, enums associated with 
it and calls to it.  The patch also implements the replacement 
functionality.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.12-rc3/drivers/char/tpm/tpm_atmel.c kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.12-rc3/drivers/char/tpm/tpm_atmel.c	2005-05-09 14:15:55.000000000 -0500
+++ kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm_atmel.c	2005-05-12 14:07:41.000000000 -0500
@@ -22,8 +22,9 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-enum tpm_atmel_addr{
-	TPM_ATML_BASE = 0x400
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
 };
 
 /* write status bits */
@@ -148,7 +149,6 @@ static struct tpm_vendor_specific tpm_at
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
 	.req_canceled = ATML_STATUS_READY,
-	.base = TPM_ATML_BASE,
 	.attr_group = &atmel_attr_grp,
 	.miscdev.fops = &atmel_ops,
 };
@@ -158,14 +158,16 @@ static int __devinit tpm_atml_init(struc
 {
 	u8 version[4];
 	int rc = 0;
+	int lo, hi;
 
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 
-	if (tpm_lpc_bus_init(pci_dev, TPM_ATML_BASE)) {
-		rc = -ENODEV;
-		goto out_err;
-	}
+	lo = tpm_read_index( TPM_ATMEL_BASE_ADDR_LO );
+	hi = tpm_read_index( TPM_ATMEL_BASE_ADDR_HI );
+	
+	tpm_atmel.base = (hi<<8)|lo; 
+	dev_dbg( &pci_dev->dev, "Operating with base: 0x%x\n", tpm_atmel.base);
 
 	/* verify that it is an Atmel part */
 	if (tpm_read_index(4) != 'A' || tpm_read_index(5) != 'T'
diff -uprN linux-2.6.12-rc3/drivers/char/tpm/tpm.c kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc3/drivers/char/tpm/tpm.c	2005-05-09 14:15:55.000000000 -0500
+++ kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm.c	2005-05-12 14:07:41.000000000 -0500
@@ -35,25 +35,6 @@ enum tpm_const {
 	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(int))
 };
 
-  /* PCI configuration addresses */
-enum tpm_pci_config_addr {
-	PCI_GEN_PMCON_1 = 0xA0,
-	PCI_GEN1_DEC = 0xE4,
-	PCI_LPC_EN = 0xE6,
-	PCI_GEN2_DEC = 0xEC
-};
-
-enum tpm_config {
-	TPM_LOCK_REG = 0x0D,
-	TPM_INTERUPT_REG = 0x0A,
-	TPM_BASE_ADDR_LO = 0x08,
-	TPM_BASE_ADDR_HI = 0x09,
-	TPM_UNLOCK_VALUE = 0x55,
-	TPM_LOCK_VALUE = 0xAA,
-	TPM_DISABLE_INTERUPT_VALUE = 0x00
-};
-
-
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
 static int dev_mask[TPM_NUM_MASK_ENTRIES];
@@ -585,10 +520,6 @@ int tpm_pm_resume(struct pci_dev *pci_de
 	if (chip == NULL)
 		return -ENODEV;
 
-	spin_lock(&driver_lock);
-	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
-	spin_unlock(&driver_lock);
-
 	return 0;
 }
 
diff -uprN linux-2.6.12-rc3/drivers/char/tpm/tpm.h kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm.h
--- linux-2.6.12-rc3/drivers/char/tpm/tpm.h	2005-05-09 14:15:55.000000000 -0500
+++ kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm.h	2005-05-12 14:07:41.000000000 -0500
@@ -88,8 +88,6 @@ static inline void tpm_write_index(int i
 	outb(value & 0xFF, TPM_DATA);
 }
 
-extern int tpm_lpc_bus_init(struct pci_dev *, u16);
-
 extern int tpm_register_hardware(struct pci_dev *,
 				 struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);
diff -uprN linux-2.6.12-rc3/drivers/char/tpm/tpm_nsc.c kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.12-rc3/drivers/char/tpm/tpm_nsc.c	2005-05-09 14:15:55.000000000 -0500
+++ kernel/linux-2.6.12-rc3-tpmdd/drivers/char/tpm/tpm_nsc.c	2005-05-12 14:07:41.000000000 -0500
@@ -22,9 +22,13 @@
 #include "tpm.h"
 
 /* National definitions */
-enum tpm_nsc_addr {
+enum tpm_nsc_addr{
 	TPM_NSC_BASE = 0x360,
-	TPM_NSC_IRQ = 0x07
+	TPM_NSC_IRQ = 0x07,
+	TPM_NSC_BASE0_HI = 0x60,
+	TPM_NSC_BASE0_LO = 0x61,
+	TPM_NSC_BASE1_HI = 0x62,
+	TPM_NSC_BASE1_LO = 0x63
 };
 
 enum tpm_nsc_index {
@@ -44,7 +48,7 @@ enum tpm_nsc_status_loc {
 };
 
 /* status bits */
-enum tpm_nsc_status{
+enum tpm_nsc_status {
 	NSC_STATUS_OBF = 0x01,	/* output buffer full */
 	NSC_STATUS_IBF = 0x02,	/* input buffer full */
 	NSC_STATUS_F0 = 0x04,	/* F0 */
@@ -246,7 +250,6 @@ static struct tpm_vendor_specific tpm_ns
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
 	.req_canceled = NSC_STATUS_RDY,
-	.base = TPM_NSC_BASE,
 	.attr_group = &nsc_attr_grp,
 	.miscdev.fops = &nsc_ops,
 
@@ -256,15 +259,16 @@ static int __devinit tpm_nsc_init(struct
 				  const struct pci_device_id *pci_id)
 {
 	int rc = 0;
+	int lo, hi;
+
+	hi = tpm_read_index(TPM_NSC_BASE0_HI);
+	lo = tpm_read_index(TPM_NSC_BASE0_LO);
+
+	tpm_nsc.base = (hi<<8) | lo;
 
 	if (pci_enable_device(pci_dev))
 		return -EIO;
 
-	if (tpm_lpc_bus_init(pci_dev, TPM_NSC_BASE)) {
-		rc = -ENODEV;
-		goto out_err;
-	}
-
 	/* verify that it is a National part (SID) */
 	if (tpm_read_index(NSC_SID_INDEX) != 0xEF) {
 		rc = -ENODEV;
