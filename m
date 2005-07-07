Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261838AbVGGUDo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261838AbVGGUDo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 16:03:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262289AbVGGUCG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 16:02:06 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:60804 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S262074AbVGGUBm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 16:01:42 -0400
Subject: Re: 2.6.12 breaks 8139cp [PATCH 1 of 2]
From: Kylene Jo Hall <kjhall@us.ibm.com>
To: Chris Wright <chrisw@osdl.org>
Cc: Bjorn Helgaas <bjorn.helgaas@hp.com>, LKML <linux-kernel@vger.kernel.org>,
       jgarzik@pobox.com, tpmdd-devel@lists.sourceforge.net,
       Pierre Ossman <drzeus-list@drzeus.cx>
In-Reply-To: <20050705153512.GJ9046@shell0.pdx.osdl.net>
References: <42C1434F.2010003@drzeus.cx>
	 <1119967788.6382.7.camel@localhost.localdomain>
	 <42C16162.2070208@drzeus.cx>
	 <1119971339.6382.18.camel@localhost.localdomain>
	 <20050628172300.GE9153@shell0.pdx.osdl.net>
	 <1119990572.6403.8.camel@localhost.localdomain>
	 <20050628203408.GA9046@shell0.pdx.osdl.net>
	 <1119996659.6403.14.camel@localhost.localdomain>
	 <42C25A3A.1070206@drzeus.cx>
	 <1120055548.7079.1.camel@localhost.localdomain>
	 <20050705153512.GJ9046@shell0.pdx.osdl.net>
Content-Type: text/plain
Date: Thu, 07 Jul 2005 15:01:35 -0500
Message-Id: <1120766495.5474.21.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-07-05 at 08:35 -0700, Chris Wright wrote:
> * Kylene Jo Hall (kjhall@us.ibm.com) wrote:
> > On Wed, 2005-06-29 at 10:22 +0200, Pierre Ossman wrote:
> > > Kylene Jo Hall wrote:
> > > 
> > > >
> > > >Here is the patch that should fix the problem.  Pierre can you remove
> > > >the first patch I sent and test this one?
> > > >
> > > Apart from an improperly closed enum the patch worked fine. Great work!
> > > 
> > > Rgds
> > > Pierre
> > 
> > Please accept this patch.  The enum closing Pierre mentioned has been
> > fixed.  This patch fixes the 8309 networking problem.
> 
> Kylene, is there any way you can narrow this down to the core, critical
> fix?  Something on the order of 10's of lines rather than 100's?  Also,
> a better patch description would be great (what's broken, what fixes
> it).

The patch below is the smallest I can make this.
> 
> thanks!
> -chris
> 

A problem was reported that the tpm driver was interfereing with
networking on the 8139 chipset.  The tpm driver was using a hard coded
the memory address instead of the value the BIOS was putting the chip
at.  This was in the tpm_lpc_bus_init function.  That function can be
replaced with querying the value at Vendor specific locations.  This
patch replaces all calls to tpm_lpc_bus_init and the hardcoding of the
base address with a lookup of the address at the correct vendor
location.

Signed-off-by: Kylene Hall <kjhall@us.ibm.com>
---
diff -puN drivers/char/tpm/tpm_atmel.c~tpm-replace-odd-LPC-init-function drivers/char/tpm/tpm_atmel.c
--- 25/drivers/char/tpm/tpm_atmel.c~tpm-replace-odd-LPC-init-function	2005-06-23 21:26:00.000000000 -0700
+++ 25-akpm/drivers/char/tpm/tpm_atmel.c	2005-06-23 21:26:00.000000000 -0700
@@ -22,6 +22,9 @@
 #include "tpm.h"
 
 /* Atmel definitions */
-#define	TPM_ATML_BASE			0x400
+enum tpm_atmel_addr {
+	TPM_ATMEL_BASE_ADDR_LO = 0x08,
+	TPM_ATMEL_BASE_ADDR_HI = 0x09
+};
 
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
@@ -586,10 +500,6 @@ int tpm_pm_resume(struct pci_dev *pci_de
 	if (chip == NULL)
 		return -ENODEV;
 
-	spin_lock(&driver_lock);
-	tpm_lpc_bus_init(pci_dev, chip->vendor->base);
-	spin_unlock(&driver_lock);
-
 	return 0;
 }
 
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



