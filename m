Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752127AbWCCBtJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752127AbWCCBtJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752129AbWCCBsr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:47 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:6612 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1752127AbWCCBsN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:13 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 5/15] EDAC: e752x cleanup
Date: Thu, 2 Mar 2006 17:47:57 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021747.57069.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Add ctl_dev field to "struct e752x_dev_info".  Then we can eliminate
  ugly switch statement from e752x_probe1().

- Remove code from e752x_probe1() that clears initial PCI bus parity
  errors.  The core EDAC module already does this.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/e752x_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/e752x_edac.c	2006-02-27 17:03:40.000000000 -0800
@@ -181,6 +181,7 @@ struct e752x_pvt {
 
 struct e752x_dev_info {
 	u16 err_dev;
+	u16 ctl_dev;
 	const char *ctl_name;
 };
 
@@ -207,12 +208,15 @@ struct e752x_error_info {
 static const struct e752x_dev_info e752x_devs[] = {
 	[E7520] = {
 		   .err_dev = PCI_DEVICE_ID_INTEL_7520_1_ERR,
+		   .ctl_dev = PCI_DEVICE_ID_INTEL_7520_0,
 		   .ctl_name = "E7520"},
 	[E7525] = {
 		   .err_dev = PCI_DEVICE_ID_INTEL_7525_1_ERR,
+		   .ctl_dev = PCI_DEVICE_ID_INTEL_7525_0,
 		   .ctl_name = "E7525"},
 	[E7320] = {
 		   .err_dev = PCI_DEVICE_ID_INTEL_7320_1_ERR,
+		   .ctl_dev = PCI_DEVICE_ID_INTEL_7320_0,
 		   .ctl_name = "E7320"},
 };
 
@@ -742,7 +746,7 @@ static int e752x_probe1(struct pci_dev *
 {
 	int rc = -ENODEV;
 	int index;
-	u16 pci_data, stat;
+	u16 pci_data;
 	u32 stat32;
 	u16 stat16;
 	u8 stat8;
@@ -755,7 +759,6 @@ static int e752x_probe1(struct pci_dev *
 	int drc_ddim;		/* DRAM Data Integrity Mode 0=none,2=edac */
 	u32 dra;
 	unsigned long last_cumul_size;
-	struct pci_dev *pres_dev;
 	struct pci_dev *dev = NULL;
 
 	debugf0("%s(): mci\n", __func__);
@@ -920,33 +923,9 @@ static int e752x_probe1(struct pci_dev *
 		goto fail;
 	}
 
-	/* Walk through the PCI table and clear errors */
-	switch (dev_idx) {
-	case E7520:
-		dev = pci_get_device(PCI_VENDOR_ID_INTEL,
-				      PCI_DEVICE_ID_INTEL_7520_0, NULL);
-		break;
-	case E7525:
-		dev = pci_get_device(PCI_VENDOR_ID_INTEL,
-				      PCI_DEVICE_ID_INTEL_7525_0, NULL);
-		break;
-	case E7320:
-		dev = pci_get_device(PCI_VENDOR_ID_INTEL,
-				      PCI_DEVICE_ID_INTEL_7320_0, NULL);
-		break;
-	}
-
-
+	dev = pci_get_device(PCI_VENDOR_ID_INTEL, e752x_devs[dev_idx].ctl_dev,
+			     NULL);
 	pvt->dev_d0f0 = dev;
-	for (pres_dev = dev;
-	     ((struct pci_dev *) pres_dev->global_list.next != dev);
-	     pres_dev = (struct pci_dev *) pres_dev->global_list.next) {
-		pci_read_config_dword(pres_dev, PCI_COMMAND, &stat32);
-		stat = (u16) (stat32 >> 16);
-		/* clear any error bits */
-		if (stat32 & ((1 << 6) + (1 << 8)))
-			pci_write_config_word(pres_dev, PCI_STATUS, stat);
-	}
 	/* find the error reporting device and clear errors */
 	dev = pvt->dev_d0f1 = pci_dev_get(pvt->bridge_ck);
 	/* Turn off error disable & SMI in case the BIOS turned it on */
