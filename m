Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269411AbUI3SpR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269411AbUI3SpR (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Sep 2004 14:45:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269386AbUI3SpR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Sep 2004 14:45:17 -0400
Received: from mail.kroah.org ([69.55.234.183]:42135 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S269414AbUI3SnQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Sep 2004 14:43:16 -0400
Date: Thu, 30 Sep 2004 11:42:48 -0700
From: Greg KH <greg@kroah.com>
To: davej@codemonkey.org.uk, ak@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] fix improper use of pci_module_init() in drivers/char/agp/amd64-agp.c
Message-ID: <20040930184248.GA17546@kroah.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In going through the tree and auditing the usage of pci_module_init(), I
noticed that the amd64-agp driver was assuming that the return value of
this function could be greater than 0 (which is what could happen in 2.2
and 2.4 kernels.)  As this is no longer true, I think the following
patch is correct.

I can add this to my bk-pci tree if you wish, otherwise feel free to
send it upwards.

thanks,

greg k-h

-----

AGP: Fix up pci_module_init() usage in amd64-agp.c

pci_module_init() can not return a positive number in the 2.6 kernel, so
this code path was never getting run, so might as well just delete it.


Signed-off-by: Greg Kroah-Hartman <greg@kroah.com>

--- a/drivers/char/agp/amd64-agp.c	2004-08-24 07:55:13 -07:00
+++ b/drivers/char/agp/amd64-agp.c	2004-09-30 11:37:35 -07:00
@@ -624,39 +624,9 @@
 /* Not static due to IOMMU code calling it early. */
 int __init agp_amd64_init(void)
 {
-	int err = 0;
 	if (agp_off)
 		return -EINVAL;
-	if (pci_module_init(&agp_amd64_pci_driver) > 0) {
-		struct pci_dev *dev;
-		if (!agp_try_unsupported && !agp_try_unsupported_boot) {
-			printk(KERN_INFO PFX "No supported AGP bridge found.\n");
-#ifdef MODULE
-			printk(KERN_INFO PFX "You can try agp_try_unsupported=1\n");
-#else
-			printk(KERN_INFO PFX "You can boot with agp=try_unsupported\n");
-#endif
-			return -ENODEV;
-		}
-
-		/* First check that we have at least one AMD64 NB */
-		if (!pci_find_device(PCI_VENDOR_ID_AMD, 0x1103, NULL))
-			return -ENODEV;
-
-		/* Look for any AGP bridge */
-		dev = NULL;
-		err = -ENODEV;
-		while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev))) {
-			if (!pci_find_capability(dev, PCI_CAP_ID_AGP))
-				continue;
-			/* Only one bridge supported right now */
-			if (agp_amd64_probe(dev, NULL) == 0) {
-				err = 0;
-				break;
-			}
-		}
-	}
-	return err;
+	return pci_register_driver(&agp_amd64_pci_driver);
 }
 
 static void __exit agp_amd64_cleanup(void)
