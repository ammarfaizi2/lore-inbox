Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261432AbVF1UhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261432AbVF1UhY (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:37:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261569AbVF1UhA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:37:00 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.141]:49298 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261485AbVF1U3g (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:29:36 -0400
Subject: Re: 2.6.12 breaks 8139cp [PATCH 1 of 2]
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
Date: Tue, 28 Jun 2005 15:29:31 -0500
Message-Id: <1119990572.6403.8.camel@localhost.localdomain>
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

I'll be sending two patches to fix this problem.  The first one just
changes a bunch of #define's to named emums.  The second is the real
fix.  This was the easiest way for me, let me know if this is not ok.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -uprN linux-2.6.12-rc2/drivers/char/tpm/tpm_atmel.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_atmel.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm_atmel.c	2005-04-15 16:31:21.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_atmel.c	2005-04-15 16:26:17.000000000 -0500
@@ -22,17 +22,22 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-#define	TPM_ATML_BASE			0x400
+enum tpm_atmel_addr{
+	TPM_ATML_BASE = 0x400
+};
 
 /* write status bits */
-#define	ATML_STATUS_ABORT		0x01
-#define	ATML_STATUS_LASTBYTE		0x04
-
+enum tpm_atmel_write_status {
+	ATML_STATUS_ABORT = 0x01,
+	ATML_STATUS_LASTBYTE = 0x04
+};
 /* read status bits */
-#define	ATML_STATUS_BUSY		0x01
-#define	ATML_STATUS_DATA_AVAIL		0x02
-#define	ATML_STATUS_REWRITE		0x04
-
+enum tpm_atmel_read_status {
+	ATML_STATUS_BUSY = 0x01,
+	ATML_STATUS_DATA_AVAIL = 0x02,
+	ATML_STATUS_REWRITE = 0x04,
+	ATML_STATUS_READY = 0x08
+};

 static int tpm_atml_recv(struct tpm_chip *chip, u8 * buf, size_t count)
 {
diff -uprN linux-2.6.12-rc2/drivers/char/tpm/tpm.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-15 16:30:55.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.c	2005-04-15 16:28:55.000000000 -0500
@@ -28,19 +28,35 @@
 #include <linux/spinlock.h>
 #include "tpm.h"
 
-#define	TPM_MINOR			224	/* officially assigned */
+enum tpm_const {
+	TPM_MINOR = 224,	/* officially assigned */
+	TPM_BUFSIZE = 2048,
+	TPM_NUM_DEVICES = 256,
+	TPM_NUM_MASK_ENTRIES = TPM_NUM_DEVICES / (8 * sizeof(int))
+};
 
-#define	TPM_BUFSIZE			2048
+  /* PCI configuration addresses */
+enum tpm_pci_config_addr {
+	PCI_GEN_PMCON_1 = 0xA0,
+	PCI_GEN1_DEC = 0xE4,
+	PCI_LPC_EN = 0xE6,
+	PCI_GEN2_DEC = 0xEC
+};
+
+enum tpm_config {
+	TPM_LOCK_REG = 0x0D,
+	TPM_INTERUPT_REG = 0x0A,
+	TPM_BASE_ADDR_LO = 0x08,
+	TPM_BASE_ADDR_HI = 0x09,
+	TPM_UNLOCK_VALUE = 0x55,
+	TPM_LOCK_VALUE = 0xAA,
+	TPM_DISABLE_INTERUPT_VALUE = 0x00
+};
 
-/* PCI configuration addresses */
-#define	PCI_GEN_PMCON_1			0xA0
-#define	PCI_GEN1_DEC			0xE4
-#define	PCI_LPC_EN			0xE6
-#define	PCI_GEN2_DEC			0xEC
 
 static LIST_HEAD(tpm_chip_list);
 static DEFINE_SPINLOCK(driver_lock);
-static int dev_mask[32];
+static int dev_mask[TPM_NUM_MASK_ENTRIES];
 
 static void user_reader_timeout(unsigned long ptr)
 {
@@ -102,17 +118,18 @@ int tpm_lpc_bus_init(struct pci_dev *pci
 			pci_write_config_dword(pci_dev, PCI_GEN_PMCON_1,
 					       tmp);
 		}
-		tpm_write_index(0x0D, 0x55);	/* unlock 4F */
-		tpm_write_index(0x0A, 0x00);	/* int disable */
-		tpm_write_index(0x08, base);	/* base addr lo */
-		tpm_write_index(0x09, (base & 0xFF00) >> 8);	/* base addr hi */
-		tpm_write_index(0x0D, 0xAA);	/* lock 4F */
 		break;
 	case PCI_VENDOR_ID_AMD:
 		/* nothing yet */
 		break;
 	}

+	tpm_write_index(TPM_LOCK_REG, TPM_UNLOCK_VALUE);
+	tpm_write_index(TPM_INTERUPT_REG, TPM_DISABLE_INTERUPT_VALUE);
+	tpm_write_index(TPM_BASE_ADDR_LO, base);
+	tpm_write_index(TPM_BASE_ADDR_HI, (base & 0xFF00) >> 8); 
+	tpm_write_index(TPM_LOCK_REG, TPM_LOCK_VALUE);
+
	return 0;
 }
 
diff -uprN linux-2.6.12-rc2/drivers/char/tpm/tpm_nsc.c linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_nsc.c
--- linux-2.6.12-rc2/drivers/char/tpm/tpm_nsc.c	2005-04-15 16:31:31.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm_nsc.c	2005-04-15 16:26:28.000000000 -0500
@@ -22,34 +22,42 @@
 #include "tpm.h"
 
 /* National definitions */
-#define	TPM_NSC_BASE			0x360
-#define	TPM_NSC_IRQ			0x07
+enum tpm_nsc_addr {
+	TPM_NSC_BASE = 0x360,
+	TPM_NSC_IRQ = 0x07
+};
 
-#define	NSC_LDN_INDEX			0x07
-#define	NSC_SID_INDEX			0x20
-#define	NSC_LDC_INDEX			0x30
-#define	NSC_DIO_INDEX			0x60
-#define	NSC_CIO_INDEX			0x62
-#define	NSC_IRQ_INDEX			0x70
-#define	NSC_ITS_INDEX			0x71
-
-#define	NSC_STATUS			0x01
-#define	NSC_COMMAND			0x01
-#define	NSC_DATA			0x00
+enum tpm_nsc_index {
+	NSC_LDN_INDEX = 0x07,
+	NSC_SID_INDEX = 0x20,
+	NSC_LDC_INDEX = 0x30,
+	NSC_DIO_INDEX = 0x60,
+	NSC_CIO_INDEX = 0x62,
+	NSC_IRQ_INDEX = 0x70,
+	NSC_ITS_INDEX = 0x71
+};
 
-/* status bits */
-#define	NSC_STATUS_OBF			0x01	/* output buffer full */
-#define	NSC_STATUS_IBF			0x02	/* input buffer full */
-#define	NSC_STATUS_F0			0x04	/* F0 */
-#define	NSC_STATUS_A2			0x08	/* A2 */
-#define	NSC_STATUS_RDY			0x10	/* ready to receive command */
-#define	NSC_STATUS_IBR			0x20	/* ready to receive data */
+enum tpm_nsc_status_loc {
+	NSC_STATUS = 0x01,
+	NSC_COMMAND = 0x01,
+	NSC_DATA = 0x00
+};
 
+/* status bits */
+enum tpm_nsc_status{
+	NSC_STATUS_OBF = 0x01,	/* output buffer full */
+	NSC_STATUS_IBF = 0x02,	/* input buffer full */
+	NSC_STATUS_F0 = 0x04,	/* F0 */
+	NSC_STATUS_A2 = 0x08,	/* A2 */
+	NSC_STATUS_RDY = 0x10,	/* ready to receive command */
+	NSC_STATUS_IBR = 0x20	/* ready to receive data */
+};
 /* command bits */
-#define	NSC_COMMAND_NORMAL		0x01	/* normal mode */
-#define	NSC_COMMAND_EOC			0x03
-#define	NSC_COMMAND_CANCEL		0x22
-
+enum tpm_nsc_cmd_mode {
+	NSC_COMMAND_NORMAL = 0x01,	/* normal mode */
+	NSC_COMMAND_EOC = 0x03,
+	NSC_COMMAND_CANCEL = 0x22
+};
 /*
  * Wait for a certain status to appear
  */
+};
diff -uprN linux-2.6.12-rc2/drivers/char/tpm/tpm.h linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.h
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.h     2005-04-15 15:13:29.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/char/tpm/tpm.h       2005-04-15 16:25:18.000000000 -0500
@@ -25,11 +25,16 @@
 #include <linux/fs.h>
 #include <linux/miscdevice.h>
 
-#define TPM_TIMEOUT msecs_to_jiffies(5)
+enum tpm_timeout {
+	TPM_TIMEOUT = 5,	/* msecs */
+};
 
 /* TPM addresses */
-#define	TPM_ADDR			0x4E
-#define	TPM_DATA			0x4F
+enum tpm_addr {
+	TPM_ADDR = 0x4E,
+	TPM_DATA = 0x4F
+};
+
 
 struct tpm_chip;
 
--- linux-2.6.12-rc2/drivers/char/tpm/tpm.c	2005-04-25 18:44:16.000000000 -0500
+++ linux-2.6.12-rc2-tpmdd/drivers/chat/tpm/tpm.c	2005-04-25 18:45:30.000000000 -0500
@@ -566,7 +566,7 @@ void __devexit tpm_remove(struct pci_dev
 
 	pci_disable_device(pci_dev);
 
-	dev_mask[chip->dev_num / 32] &= !(1 << (chip->dev_num % 32));
+	dev_mask[chip->dev_num / TPM_NUM_MASK_ENTRIES ] &= !(1 << (chip->dev_num % TPM_NUM_MASK_ENTRIES));
 
 	kfree(chip);
 
@@ -646,10 +646,11 @@ int tpm_register_hardware(struct pci_dev
 
 	chip->dev_num = -1;
 
-	for (i = 0; i < 32; i++)
-		for (j = 0; j < 8; j++)
+	for (i = 0; i < TPM_NUM_MASK_ENTRIES; i++)
+		for (j = 0; j < 8 * sizeof(int); j++)
 			if ((dev_mask[i] & (1 << j)) == 0) {
-				chip->dev_num = i * 32 + j;
+				chip->dev_num =
+				    i * TPM_NUM_MASK_ENTRIES + j;
 				dev_mask[i] |= 1 << j;
 				goto dev_num_search_complete;
 			}



