Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267509AbUIWW4v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267509AbUIWW4v (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Sep 2004 18:56:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267466AbUIWW4s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Sep 2004 18:56:48 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:50863 "EHLO
	e35.co.us.ibm.com") by vger.kernel.org with ESMTP id S267511AbUIWW1q
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Sep 2004 18:27:46 -0400
Date: Thu, 23 Sep 2004 15:28:41 -0700
From: Hanna Linder <hannal@us.ibm.com>
To: linux-kernel@vger.kernel.org, kernel-janitors@lists.osdl.org
cc: greg@kroah.com, hannal@us.ibm.com, hpa@zytor.com, davej@codemonkey.org.uk
Subject: [PATCH 2.6.9-rc2-mm2] Change irq.c driver to use new pci_dev_present
Message-ID: <2800000.1095978521@w-hlinder.beaverton.ibm.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


This code previously used the pci_get_device function only to find out if the
device was present, it did not use the pci_dev* that was returned. That was
what the new pci_dev_present function was created for.  I was able to compile
and boot this code to show it did not break anything.

Please consider for inclusion.

Hanna Linder
IBM Linux Technology Center

Signed-off-by: Hanna Linder <hannal@us.ibm.com>
---
diff -Nrup linux-2.6.9-rc2-mm2cln/arch/i386/pci/irq.c linux-2.6.9-rc2-mm2patch2/arch/i386/pci/irq.c
--- linux-2.6.9-rc2-mm2cln/arch/i386/pci/irq.c	2004-09-23 11:48:52.000000000 -0700
+++ linux-2.6.9-rc2-mm2patch2/arch/i386/pci/irq.c	2004-09-23 14:20:41.376755760 -0700
@@ -455,18 +455,15 @@ static int pirq_bios_set(struct pci_dev 
 
 static __init int intel_router_probe(struct irq_router *r, struct pci_dev *router, u16 device)
 {
-	struct pci_dev *dev1, *dev2;
-
+	int ret1, ret2 = -1;
+	
 	/* 440GX has a proprietary PIRQ router -- don't use it */
-	dev1 = pci_get_device(PCI_VENDOR_ID_INTEL,
+	ret1 = pci_dev_present(PCI_VENDOR_ID_INTEL,
 				PCI_DEVICE_ID_INTEL_82443GX_0, NULL);
-	dev2 = pci_get_device(PCI_VENDOR_ID_INTEL,
+	ret2 = pci_dev_present(PCI_VENDOR_ID_INTEL,
 				PCI_DEVICE_ID_INTEL_82443GX_2, NULL);
-	if ((dev1 != NULL) || (dev2 != NULL)) {
-		pci_dev_put(dev1);
-		pci_dev_put(dev2);
+	if (ret1 || ret2) 
 		return 0;
-	}
 
 	switch(device)
 	{



