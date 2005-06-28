Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261569AbVF1UhZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261569AbVF1UhZ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:37:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261495AbVF1UfY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:35:24 -0400
Received: from e5.ny.us.ibm.com ([32.97.182.145]:21411 "EHLO e5.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261432AbVF1Ua7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:30:59 -0400
Subject: Re: 2.6.12 breaks 8139cp [PATCH 2 of 2]
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20050628172300.GE9153@shell0.pdx.osdl.net>
References: <42B9D21F.7040908@drzeus.cx>
	 <200506221534.03716.bjorn.helgaas@hp.com> <42BA69AC.5090202@drzeus.cx>
	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>
	 <42C0EE1A.9050809@drzeus.cx> <42C1434F.2010003@drzeus.cx>
	 <1119967788.6382.7.camel@localhost.localdomain>
	 <42C16162.2070208@drzeus.cx>
	 <1119971339.6382.18.camel@localhost.localdomain>
	 <20050628172300.GE9153@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 15:30:54 -0500
Message-Id: <1119990655.6403.11.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-06-28 at 10:23 -0700, Chris Wright wrote:
> * Kylene Jo Hall (kjhall@us.ibm.com) wrote:
> > 
> > > You wouldn't happen to have just your patches available?
> > 
> > Here is the tpm portion of -mm patch
> 
> Can you narrow this down to a fix that's reasonable for -stable?
> 
I'll be sending two patches to fix this problem.  The first one just
changes a bunch of #define's to named emums.  The second is the real
fix.  This was the easiest way for me, let me know if this is not ok.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---

 drivers/char/tpm/tpm.c       |   90 -------------------------------------------
 drivers/char/tpm/tpm.h       |    2 
 drivers/char/tpm/tpm_atmel.c |   16 ++++---
 drivers/char/tpm/tpm_nsc.c   |   22 ++++++----
 4 files changed, 22 insertions(+), 108 deletions(-)

diff -puN drivers/char/tpm/tpm_atmel.c~tpm-replace-odd-LPC-init-function drivers/char/tpm/tpm_atmel.c
--- 25/drivers/char/tpm/tpm_atmel.c~tpm-replace-odd-LPC-init-function	2005-06-23 21:26:00.000000000 -0700
+++ 25-akpm/drivers/char/tpm/tpm_atmel.c	2005-06-23 21:26:00.000000000 -0700
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
@@ -148,5 +149,4 @@ static struct tpm_vendor_specific tpm_at
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
-	.base = TPM_ATML_BASE,
 	.miscdev = { .fops = &atmel_ops, },
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
diff -puN drivers/char/tpm/tpm.c~tpm-replace-odd-LPC-init-function drivers/char/tpm/tpm.c
--- 25/drivers/char/tpm/tpm.c~tpm-replace-odd-LPC-init-function	2005-06-23 21:26:00.000000000 -0700
+++ 25-akpm/drivers/char/tpm/tpm.c	2005-06-23 21:52:40.000000000 -0700
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
@@ -77,73 +77,6 @@ void tpm_time_expired(unsigned long ptr)
 EXPORT_SYMBOL_GPL(tpm_time_expired);
 
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
@@ -586,10 +500,6 @@ int tpm_pm_resume(struct pci_dev *pci_de
 	if (chip == NULL)
 		return -ENODEV;
 
-	spin_lock(&driver_lock);
-	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
-	spin_unlock(&driver_lock);
-
 	return 0;
 }
 
diff -puN drivers/char/tpm/tpm.h~tpm-replace-odd-LPC-init-function drivers/char/tpm/tpm.h
--- 25/drivers/char/tpm/tpm.h~tpm-replace-odd-LPC-init-function	2005-06-23 21:26:00.000000000 -0700
+++ 25-akpm/drivers/char/tpm/tpm.h	2005-06-23 21:26:00.000000000 -0700
@@ -91,9 +91,7 @@ static inline void tpm_write_index(int i
 	outb(value & 0xFF, TPM_DATA);
 }

 extern void tpm_time_expired(unsigned long);
-extern int tpm_lpc_bus_init(struct pci_dev *, u16);
-
 extern int tpm_register_hardware(struct pci_dev *,
 				 struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);
diff -puN drivers/char/tpm/tpm_nsc.c~tpm-replace-odd-LPC-init-function drivers/char/tpm/tpm_nsc.c
--- 25/drivers/char/tpm/tpm_nsc.c~tpm-replace-odd-LPC-init-function	2005-06-23 21:26:00.000000000 -0700
+++ 25-akpm/drivers/char/tpm/tpm_nsc.c	2005-06-23 21:26:00.000000000 -0700
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
@@ -246,5 +250,4 @@ static struct tpm_vendor_specific tpm_ns
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
-	.base = TPM_NSC_BASE,
 	.miscdev = { .fops = &nsc_ops, },
 };
@@ -255,15 +258,16 @@ static int __devinit tpm_nsc_init(struct
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
_



