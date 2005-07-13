Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262222AbVGMSr3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262222AbVGMSr3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Jul 2005 14:47:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261545AbVGMSp7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Jul 2005 14:45:59 -0400
Received: from mail.kroah.org ([69.55.234.183]:25315 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S262340AbVGMSo7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Jul 2005 14:44:59 -0400
Date: Wed, 13 Jul 2005 11:43:41 -0700
From: Greg KH <gregkh@suse.de>
To: kjhall@us.ibm.com, bjorn.helgaas@hp.com, tpmdd-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org, stable@kernel.org,
       Justin Forbes <jmforbes@linuxtx.org>,
       Zwane Mwaikambo <zwane@arm.linux.org.uk>,
       "Theodore Ts'o" <tytso@mit.edu>, "Randy.Dunlap" <rdunlap@xenotime.net>,
       Chuck Wolber <chuckw@quantumlinux.com>, torvalds@osdl.org,
       akpm@osdl.org, alan@lxorguk.ukuu.org.uk
Subject: [06/11] tpm breaks 8139cp
Message-ID: <20050713184341.GH9330@kroah.com>
References: <20050713184130.GA9330@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050713184130.GA9330@kroah.com>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

-stable review patch.  If anyone has any objections, please let us know.

------------------

A problem was reported that the tpm driver was interfereing with
networking on the 8139 chipset.  The tpm driver was using a hard coded
the memory address instead of the value the BIOS was putting the chip
at.  This was in the tpm_lpc_bus_init function.  That function can be
replaced with querying the value at Vendor specific locations.  This
patch replaces all calls to tpm_lpc_bus_init and the hardcoding of the
base address with a lookup of the address at the correct vendor
location.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
Signed-off-by: Chris Wright <chrisw@osdl.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@suse.de>
---
 drivers/char/tpm/tpm.c       |   76 -------------------------------------------
 drivers/char/tpm/tpm.h       |    2 -
 drivers/char/tpm/tpm_atmel.c |   16 +++++----
 drivers/char/tpm/tpm_nsc.c   |   16 +++++----
 4 files changed, 20 insertions(+), 90 deletions(-)

--- linux-2.6.12.2.orig/drivers/char/tpm/tpm_atmel.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/drivers/char/tpm/tpm_atmel.c	2005-07-13 10:56:27.000000000 -0700
@@ -22,7 +22,10 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-#define	TPM_ATML_BASE			0x400
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
+};
 
 /* write status bits */
 #define	ATML_STATUS_ABORT		0x01
@@ -127,7 +130,6 @@
 	.cancel = tpm_atml_cancel,
 	.req_complete_mask = ATML_STATUS_BUSY | ATML_STATUS_DATA_AVAIL,
 	.req_complete_val = ATML_STATUS_DATA_AVAIL,
-	.base = TPM_ATML_BASE,
 	.miscdev = { .fops = &atmel_ops, },
 };
 
@@ -136,14 +138,16 @@
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
--- linux-2.6.12.2.orig/drivers/char/tpm/tpm.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/drivers/char/tpm/tpm.c	2005-07-13 10:56:27.000000000 -0700
@@ -32,12 +32,6 @@
 
 #define	TPM_BUFSIZE			2048
 
-/* PCI configuration addresses */
-#define	PCI_GEN_PMCON_1			0xA0
-#define	PCI_GEN1_DEC			0xE4
-#define	PCI_LPC_EN			0xE6
-#define	PCI_GEN2_DEC			0xEC
-
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
 static int dev_mask[32];
@@ -61,72 +55,6 @@
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
@@ -590,10 +518,6 @@
 	if (chip == NULL)
 		return -ENODEV;
 
-	spin_lock(&driver_lock);
-	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
-	spin_unlock(&driver_lock);
-
 	return 0;
 }
 
--- linux-2.6.12.2.orig/drivers/char/tpm/tpm.h	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/drivers/char/tpm/tpm.h	2005-07-13 10:56:27.000000000 -0700
@@ -79,8 +79,6 @@
 }
 
 extern void tpm_time_expired(unsigned long);
-extern int tpm_lpc_bus_init(struct pci_dev *, u16);
-
 extern int tpm_register_hardware(struct pci_dev *,
 				 struct tpm_vendor_specific *);
 extern int tpm_open(struct inode *, struct file *);
--- linux-2.6.12.2.orig/drivers/char/tpm/tpm_nsc.c	2005-06-17 12:48:29.000000000 -0700
+++ linux-2.6.12.2/drivers/char/tpm/tpm_nsc.c	2005-07-13 10:56:27.000000000 -0700
@@ -24,6 +24,10 @@
 /* National definitions */
 #define	TPM_NSC_BASE			0x360
 #define	TPM_NSC_IRQ			0x07
+#define	TPM_NSC_BASE0_HI		0x60
+#define	TPM_NSC_BASE0_LO		0x61
+#define	TPM_NSC_BASE1_HI		0x62
+#define	TPM_NSC_BASE1_LO		0x63
 
 #define	NSC_LDN_INDEX			0x07
 #define	NSC_SID_INDEX			0x20
@@ -234,7 +238,6 @@
 	.cancel = tpm_nsc_cancel,
 	.req_complete_mask = NSC_STATUS_OBF,
 	.req_complete_val = NSC_STATUS_OBF,
-	.base = TPM_NSC_BASE,
 	.miscdev = { .fops = &nsc_ops, },
 	
 };
@@ -243,15 +246,16 @@
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
