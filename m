Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752136AbWCCBtM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752136AbWCCBtM (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Mar 2006 20:49:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752131AbWCCBsn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Mar 2006 20:48:43 -0500
Received: from smtp-3.llnl.gov ([128.115.41.83]:7380 "EHLO smtp-3.llnl.gov")
	by vger.kernel.org with ESMTP id S1752128AbWCCBsO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Mar 2006 20:48:14 -0500
From: Dave Peterson <dsp@llnl.gov>
To: alan@lxorguk.ukuu.org.uk, akpm@osdl.org
Subject: [PATCH 6/15] EDAC: i82860 cleanup
Date: Thu, 2 Mar 2006 17:47:59 -0800
User-Agent: KMail/1.5.3
Cc: linux-kernel@vger.kernel.org, bluesmoke-devel@lists.sourceforge.net
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200603021747.59252.dsp@llnl.gov>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

- Fix i82860_init() so it cleans up properly on failure.
- Fix i82860_exit() so it cleans up properly.
- Fix typo in comment (i.e. www.redhat.com.com).

Signed-Off-By: David S. Peterson <dsp@llnl.gov> <dave_peterson@pobox.com>
---

Index: linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c
===================================================================
--- linux-2.6.16-rc5-edac.orig/drivers/edac/i82860_edac.c	2006-02-27 16:58:41.000000000 -0800
+++ linux-2.6.16-rc5-edac/drivers/edac/i82860_edac.c	2006-02-27 17:04:14.000000000 -0800
@@ -62,8 +62,6 @@ static const struct i82860_dev_info i828
 static struct pci_dev *mci_pdev = NULL;	/* init dev: in case that AGP code
 					   has already registered driver */
 
-static int i82860_registered = 1;
-
 static void i82860_get_error_info (struct mem_ctl_info *mci,
 		struct i82860_error_info *info)
 {
@@ -265,24 +263,33 @@ static int __init i82860_init(void)
 
 	debugf3("%s()\n", __func__);
 	if ((pci_rc = pci_register_driver(&i82860_driver)) < 0)
-		return pci_rc;
+		goto fail0;
 
 	if (!mci_pdev) {
-		i82860_registered = 0;
 		mci_pdev = pci_get_device(PCI_VENDOR_ID_INTEL,
 					  PCI_DEVICE_ID_INTEL_82860_0, NULL);
 		if (mci_pdev == NULL) {
 			debugf0("860 pci_get_device fail\n");
-			return -ENODEV;
+			pci_rc = -ENODEV;
+			goto fail1;
 		}
 		pci_rc = i82860_init_one(mci_pdev, i82860_pci_tbl);
 		if (pci_rc < 0) {
 			debugf0("860 init fail\n");
-			pci_dev_put(mci_pdev);
-			return -ENODEV;
+			pci_rc = -ENODEV;
+			goto fail1;
 		}
 	}
 	return 0;
+
+fail1:
+	pci_unregister_driver(&i82860_driver);
+
+fail0:
+	if (mci_pdev != NULL)
+		pci_dev_put(mci_pdev);
+
+	return pci_rc;
 }
 
 static void __exit i82860_exit(void)
@@ -290,10 +297,9 @@ static void __exit i82860_exit(void)
 	debugf3("%s()\n", __func__);
 
 	pci_unregister_driver(&i82860_driver);
-	if (!i82860_registered) {
-		i82860_remove_one(mci_pdev);
+
+	if (mci_pdev != NULL)
 		pci_dev_put(mci_pdev);
-	}
 }
 
 module_init(i82860_init);
@@ -301,5 +307,5 @@ module_exit(i82860_exit);
 
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR
-    ("Red Hat Inc. (http://www.redhat.com.com) Ben Woodard <woodard@redhat.com>");
+    ("Red Hat Inc. (http://www.redhat.com) Ben Woodard <woodard@redhat.com>");
 MODULE_DESCRIPTION("ECC support for Intel 82860 memory hub controllers");
