Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751159AbWI3Ioa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751159AbWI3Ioa (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 30 Sep 2006 04:44:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751161AbWI3IoB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 30 Sep 2006 04:44:01 -0400
Received: from mtagate3.uk.ibm.com ([195.212.29.136]:39715 "EHLO
	mtagate3.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1751160AbWI3Inw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 30 Sep 2006 04:43:52 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 2 of 4] x86-64: Calgary IOMMU: deobfuscate calgary_init
X-Mercurial-Node: e0562474cf16b13d8c3c815fce3159ba7cd0f540
Message-Id: <e0562474cf16b13d8c3c.1159605810@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1159605808@rhun.haifa.ibm.com>
Date: Sat, 30 Sep 2006 11:43:30 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@kudzu.us, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 7 insertions(+), 5 deletions(-)
arch/x86_64/kernel/pci-calgary.c |   12 +++++++-----


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1159604311 -10800
# Node ID e0562474cf16b13d8c3c815fce3159ba7cd0f540
# Parent  28658cf477bc8c6adc5a5335363a4d1428f58273
x86-64: Calgary IOMMU: deobfuscate calgary_init

From: Jon Mason <jdmason@kudzu.us>

calgary_init's for loop does not correspond to the actual device being
checked, which makes its upperbound check for array overflow useless.
Changing this to a do-while loop is the correct way of doing this.
There should be no possibility of spinning forever in this loop, as
pci_get_device states that it will go through all iterations, then
return NULL (thus breaking the loop).

Signed-off-by: Jon Mason <jdmason@kudzu.us>
Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>

diff -r 28658cf477bc -r e0562474cf16 arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Sat Sep 30 11:16:12 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Sat Sep 30 11:18:31 2006 +0300
@@ -817,6 +817,8 @@ static int __init calgary_init_one(struc
 	void __iomem *bbar;
 	int ret;
 
+	BUG_ON(dev->bus->number >= MAX_PHB_BUS_NUM);
+
 	address = locate_register_space(dev);
 	/* map entire 1MB of Calgary config space */
 	bbar = ioremap_nocache(address, 1024 * 1024);
@@ -843,10 +845,10 @@ done:
 
 static int __init calgary_init(void)
 {
-	int i, ret = -ENODEV;
+	int ret = -ENODEV;
 	struct pci_dev *dev = NULL;
 
-	for (i = 0; i < MAX_PHB_BUS_NUM; i++) {
+	do {
 		dev = pci_get_device(PCI_VENDOR_ID_IBM,
 				     PCI_DEVICE_ID_IBM_CALGARY,
 				     dev);
@@ -862,12 +864,12 @@ static int __init calgary_init(void)
 		ret = calgary_init_one(dev);
 		if (ret)
 			goto error;
-	}
+	} while (1);
 
 	return ret;
 
 error:
-	for (i--; i >= 0; i--) {
+	do {
 		dev = pci_find_device_reverse(PCI_VENDOR_ID_IBM,
 					      PCI_DEVICE_ID_IBM_CALGARY,
 					      dev);
@@ -883,7 +885,7 @@ error:
 		calgary_disable_translation(dev);
 		calgary_free_bus(dev);
 		pci_dev_put(dev); /* Undo calgary_init_one()'s pci_dev_get() */
-	}
+	} while (1);
 
 	return ret;
 }
