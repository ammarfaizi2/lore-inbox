Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262205AbVF1Wp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262205AbVF1Wp4 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 18:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261523AbVF1WOx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 18:14:53 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:10159 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261491AbVF1WLF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 18:11:05 -0400
Subject: Re: 2.6.12 breaks 8139cp [PATCH 1 of 2]
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>,
       Bjorn Helgaas <bjorn.helgaas@hp.com>,
       LKML <linux-kernel@vger.kernel.org>, jgarzik@pobox.com,
       tpmdd-devel@lists.sourceforge.net
In-Reply-To: <20050628203408.GA9046@shell0.pdx.osdl.net>
References: <42BA69AC.5090202@drzeus.cx>
	 <200506231143.34769.bjorn.helgaas@hp.com> <42BB3428.6030708@drzeus.cx>
	 <42C0EE1A.9050809@drzeus.cx> <42C1434F.2010003@drzeus.cx>
	 <1119967788.6382.7.camel@localhost.localdomain>
	 <42C16162.2070208@drzeus.cx>
	 <1119971339.6382.18.camel@localhost.localdomain>
	 <20050628172300.GE9153@shell0.pdx.osdl.net>
	 <1119990572.6403.8.camel@localhost.localdomain>
	 <20050628203408.GA9046@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Tue, 28 Jun 2005 17:10:59 -0500
Message-Id: <1119996659.6403.14.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > > Here is the tpm portion of -mm patch
> > > 
> > > Can you narrow this down to a fix that's reasonable for -stable?
> > 
> > I'll be sending two patches to fix this problem.  The first one just
> > changes a bunch of #define's to named emums.  The second is the real
> > fix.  This was the easiest way for me, let me know if this is not ok.
> 
> Just the real fix is the best for -stable, please.

Here is the patch that should fix the problem.  Pierre can you remove
the first patch I sent and test this one?

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
@@ -22,6 +22,8 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-#define	TPM_ATML_BASE			0x400
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
 
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
@@ -35,10 +35,4 @@ 
 #define	TPM_BUFSIZE			2048
 
-/* PCI configuration addresses */
-#define	PCI_GEN_PMCON_1			0xA0
-#define	PCI_GEN1_DEC			0xE4
-#define	PCI_LPC_EN			0xE6
-#define	PCI_GEN2_DEC			0xEC
-
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
@@ -61,72 +61,6 @@ void tpm_time_expired(unsigned long ptr)
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
-		tpm_write_index(0x0D, 0x55);	/* unlock 4F */
-		tpm_write_index(0x0A, 0x00);	/* int disable */
-		tpm_write_index(0x08, base);	/* base addr lo */
-		tpm_write_index(0x09, (base & 0xFF00) >> 8);	/* base addr hi */
-		tpm_write_index(0x0D, 0xAA);	/* lock 4F */
-		break;
-	case PCI_VENDOR_ID_AMD:
-		/* nothing yet */
-		break;
-	}
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
@@ -22,6 +22,10 @@
 /* National definitions */
 #define 	TPM_NSC_BASE			0x360
 #define	TPM_NSC_IRQ			0x07
+#define	TPM_NSC_BASE0_HI		0x60
+#define	TPM_NSC_BASE0_LO		0x61
+#define	TPM_NSC_BASE1_HI		0x62
+#define	TPM_NSC_BASE1_LO		0x63

 #define	NSC_LDN_INDEX			0x07
 #define	NSC_SID_INDEX			0x20
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





