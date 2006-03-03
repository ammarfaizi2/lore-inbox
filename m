Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752131AbWCCBtN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752131AbWCCBtN (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752138AbWCCBsk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:40 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:8404 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1752130AbWCCBsP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:15 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 7/15] EDAC: i82875p cleanup
Date: Thu, 2 Mar 2006 17:48:01 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021748.01132.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix i82875p_probe1() so it calls pci_get_device() instead of
  pci_find_device().
- Fix i82875p_probe1() so it cleans up properly on failure.
- Fix i82875p_init() so it cleans up properly on failure.

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82875p_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82875p_edac.c	2006-02-27 17:04:31.000000000 -0800
@@ -289,7 +289,7 @@ static int i82875p_probe1(struct pci_dev
 
 	debugf0("%s()\n", __func__);
 
-	ovrfl_pdev = pci_find_device(PCI_VEND_DEV(INTEL, 82875_6), NULL);
+	ovrfl_pdev = pci_get_device(PCI_VEND_DEV(INTEL, 82875_6), NULL);
 
 	if (!ovrfl_pdev) {
 		/*
@@ -302,26 +302,26 @@ static int i82875p_probe1(struct pci_dev
 		ovrfl_pdev =
 		    pci_scan_single_device(pdev->bus, PCI_DEVFN(6, 0));
 		if (!ovrfl_pdev)
-			goto fail;
+			return -ENODEV;
 	}
 #ifdef CONFIG_PROC_FS
 	if (!ovrfl_pdev->procent && pci_proc_attach_device(ovrfl_pdev)) {
 		i82875p_printk(KERN_ERR,
 			       "%s(): Failed to attach overflow device\n",
 			       __func__);
-		goto fail;
+		return -ENODEV;
 	}
 #endif				/* CONFIG_PROC_FS */
 	if (pci_enable_device(ovrfl_pdev)) {
 		i82875p_printk(KERN_ERR,
 			       "%s(): Failed to enable overflow device\n",
 			       __func__);
-		goto fail;
+		return -ENODEV;
 	}
 
 	if (pci_request_regions(ovrfl_pdev, pci_name(ovrfl_pdev))) {
 #ifdef CORRECT_BIOS
-		goto fail;
+		goto fail0;
 #endif
 	}
 	/* cache is irrelevant for PCI bus reads/writes */
@@ -331,7 +331,7 @@ static int i82875p_probe1(struct pci_dev
 	if (!ovrfl_window) {
 		i82875p_printk(KERN_ERR, "%s(): Failed to ioremap bar6\n",
 			       __func__);
-		goto fail;
+		goto fail1;
 	}
 
 	/* need to find out the number of channels */
@@ -345,7 +345,7 @@ static int i82875p_probe1(struct pci_dev
 
 	if (!mci) {
 		rc = -ENOMEM;
-		goto fail;
+		goto fail2;
 	}
 
 	debugf3("%s(): init mci\n", __func__);
@@ -402,25 +402,26 @@ static int i82875p_probe1(struct pci_dev
 
 	if (edac_mc_add_mc(mci)) {
 		debugf3("%s(): failed edac_mc_add_mc()\n", __func__);
-		goto fail;
+		goto fail3;
 	}
 
 	/* get this far and it's successful */
 	debugf3("%s(): success\n", __func__);
 	return 0;
 
-      fail:
-	if (mci)
-		edac_mc_free(mci);
-
-	if (ovrfl_window)
-		iounmap(ovrfl_window);
-
-	if (ovrfl_pdev) {
-		pci_release_regions(ovrfl_pdev);
-		pci_disable_device(ovrfl_pdev);
-	}
+fail3:
+	edac_mc_free(mci);
+
+fail2:
+	iounmap(ovrfl_window);
 
+fail1:
+	pci_release_regions(ovrfl_pdev);
+
+#ifdef CORRECT_BIOS
+fail0:
+#endif
+	pci_disable_device(ovrfl_pdev);
 	/* NOTE: the ovrfl proc entry and pci_dev are intentionally left */
 	return rc;
 }
@@ -497,24 +498,33 @@ static int __init i82875p_init(void)
 	debugf3("%s()\n", __func__);
 	pci_rc = pci_register_driver(&i82875p_driver);
 	if (pci_rc < 0)
-		return pci_rc;
+		goto fail0;
 	if (mci_pdev == NULL) {
-		i82875p_registered = 0;
 		mci_pdev =
 		    pci_get_device(PCI_VENDOR_ID_INTEL,
 				   PCI_DEVICE_ID_INTEL_82875_0, NULL);
 		if (!mci_pdev) {
 			debugf0("875p pci_get_device fail\n");
-			return -ENODEV;
+			pci_rc = -ENODEV;
+			goto fail1;
 		}
 		pci_rc = i82875p_init_one(mci_pdev, i82875p_pci_tbl);
 		if (pci_rc < 0) {
 			debugf0("875p init fail\n");
-			pci_dev_put(mci_pdev);
-			return -ENODEV;
+			pci_rc = -ENODEV;
+			goto fail1;
 		}
 	}
 	return 0;
+
+fail1:
+	pci_unregister_driver(&i82875p_driver);
+
+fail0:
+	if (mci_pdev != NULL)
+		pci_dev_put(mci_pdev);
+
+	return pci_rc;
 }
 
 
