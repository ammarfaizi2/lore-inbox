Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261632AbVEWN5n@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261632AbVEWN5n (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 09:57:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261652AbVEWN5n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 09:57:43 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:5539 "EHLO e32.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S261632AbVEWN50 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 09:57:26 -0400
Subject: [PATCH] tpm: replace odd LPC init function
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Ron Forrester <rjf@signacert.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org
In-Reply-To: <428E63BA.8070008@signacert.com>
References: <428E63BA.8070008@signacert.com>
Content-Type: text/plain
Date: Mon, 23 May 2005 08:51:36 -0500
Message-Id: <1116856297.24582.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Realized the tpm_lpc_init function isn't really necessary.  Replaced it
with vendor specific logic to find out the address the BIOS mapped the
TPM to.  This patch removes the tpm_lpc_init function, enums associated
with it and calls to it.  The patch also implements the replacement
functionality.

I think this patch has been lost in the shuffle so I am resubmitting.
It really is needed as it can steal i/o address from other things and
break them.

Thanks,
Kylie

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN --exclude=CVS --exclude='*.orig' linux-2.6.12-rc4/drivers/char/tpm/tpm_atmel.c /home/kylie/tcg/tpmdd/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.12-rc4/drivers/char/tpm/tpm_atmel.c	2005-05-16 11:18:26.000000000 -0500
+++ /home/kylie/tcg/tpmdd/drivers/char/tpm/tpm_atmel.c	2005-05-12 11:18:17.000000000 -0500
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
diff -uprN --exclude=CVS --exclude='*.orig' linux-2.6.12-rc4/drivers/char/tpm/tpm.c /home/kylie/tcg/tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc4/drivers/char/tpm/tpm.c	2005-05-16 11:18:26.000000000 -0500
+++ /home/kylie/tcg/tpmdd/drivers/char/tpm/tpm.c	2005-05-13 14:28:50.000000000 -0500
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
@@ -69,73 +50,6 @@ static void user_reader_timeout(unsigned
 }
 
 /*
- * Initialize the LPC bus and enable the TPM ports
- */
-int tpm_lpc_bus_init(struct pci_dev *pci_dev, u16 base)
-{
-	u32 lpcenable, tmp;
-	int is_lpcm = 0;
-
-	switch (pci_dev->vendor) {
-	case PCI_VENDOR_ID_INTEL:
-		switch (pci_dev->device) {
-		case PCI_DEVICE_ID_INTEL_82801CA_12:
-		case PCI_DEVICE_ID_INTEL_82801DB_12:
-			is_lpcm = 1;
-			break;
-		}
-		/* init ICH (enable LPC) */
-		pci_read_config_dword(pci_dev, PCI_GEN1_DEC, &lpcenable);
-		lpcenable |= 0x20000000;
-		pci_write_config_dword(pci_dev, PCI_GEN1_DEC, lpcenable);
-
-		if (is_lpcm) {
-			pci_read_config_dword(pci_dev, PCI_GEN1_DEC,
-					      &lpcenable);
-			if ((lpcenable & 0x20000000) == 0) {
-				dev_err(&pci_dev->dev,
-					"cannot enable LPC\n");
-				return -ENODEV;
-			}
-		}
-
-		/* initialize TPM registers */
-		pci_read_config_dword(pci_dev, PCI_GEN2_DEC, &tmp);
-
-		if (!is_lpcm)
-			tmp = (tmp & 0xFFFF0000) | (base & 0xFFF0);
-		else
-			tmp =
-			    (tmp & 0xFFFF0000) | (base & 0xFFF0) |
-			    0x00000001;
-
-		pci_write_config_dword(pci_dev, PCI_GEN2_DEC, tmp);
-
-		if (is_lpcm) {
-			pci_read_config_dword(pci_dev, PCI_GEN_PMCON_1,
-					      &tmp);
-			tmp |= 0x00000004;	/* enable CLKRUN */
-			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
-					       tmp);
-		}
-		break;
-	case PCI_VENDOR_ID_AMD:
-		/* nothing yet */
-		break;
-	}
-
-	tpm_write_index(TPM_LOCK_REG, TPM_UNLOCK_VALUE);
-	tpm_write_index(TPM_INTERUPT_REG, TPM_DISABLE_INTERUPT_VALUE);
-	tpm_write_index(TPM_BASE_ADDR_LO, base);
-	tpm_write_index(TPM_BASE_ADDR_HI, (base & 0xFF00) >> 8);
-	tpm_write_index(TPM_LOCK_REG, TPM_LOCK_VALUE);
-
-	return 0;
-}
-
-EXPORT_SYMBOL_GPL(tpm_lpc_bus_init);
-
-/*
  * Internal kernel interface to transmit TPM commands
  */
 static ssize_t tpm_transmit(struct tpm_chip *chip, const char *buf,
@@ -611,10 +526,6 @@ int tpm_pm_resume(struct pci_dev *pci_de
 	if (chip == NULL)
 		return -ENODEV;
 
-	spin_lock(&driver_lock);
-	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
-	spin_unlock(&driver_lock);
-
 	return 0;
 }
 
diff -uprN --exclude=CVS --exclude='*.orig' linux-2.6.12-rc4/drivers/char/tpm/tpm.h /home/kylie/tcg/tpmdd/drivers/char/tpm/tpm.h
--- linux-2.6.12-rc4/drivers/char/tpm/tpm.h	2005-05-16 11:18:26.000000000 -0500
+++ /home/kylie/tcg/tpmdd/drivers/char/tpm/tpm.h	2005-05-12 13:20:58.000000000 -0500
@@ -88,8 +88,6 @@ static inline void tpm_write_index(int i
 	outb(value & 0xFF, TPM_DATA);
 }
 
-extern int tpm_lpc_bus_init(struct pci_dev *, u16);
-
 extern int tpm_register_hardware(struct pci_dev *,
 				 struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);
diff -uprN --exclude=CVS --exclude='*.orig' linux-2.6.12-rc4/drivers/char/tpm/tpm_nsc.c /home/kylie/tcg/tpmdd/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.12-rc4/drivers/char/tpm/tpm_nsc.c	2005-05-16 11:18:26.000000000 -0500
+++ /home/kylie/tcg/tpmdd/drivers/char/tpm/tpm_nsc.c	2005-05-12 11:05:16.000000000 -0500
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

On Fri, 2005-05-20 at 15:24 -0700, Ron Forrester wrote:
> Hello Kylene, I am trying to track down the patch of May 16th referenced in
> the following post:
> 
> 	http://lkml.org/lkml/2005/5/20/55
> 
> Specifically, "the patch I submitted on May 16 to remove the unnecessary lpc
> initialization stuff".
> 
> I looked through the patches of May 16th and could not find it -- it maybe
> that I simply missed it, or, more likely, that I don't know what I am doing
> :-) Can you help?
> 
> Thanks much,
> Ron Forrester
> 
> 

