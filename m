Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263662AbUCPJZJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 16 Mar 2004 04:25:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263702AbUCPJZJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 16 Mar 2004 04:25:09 -0500
Received: from gate.crashing.org ([63.228.1.57]:28894 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S263662AbUCPJZB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 16 Mar 2004 04:25:01 -0500
Subject: [PATCH] g5: Fix iommu vs. pci_device_to_OF_node
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>,
       Dan Burcaw <dburcaw@terrasoftsolutions.com>
Content-Type: text/plain
Message-Id: <1079419564.1966.235.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Tue, 16 Mar 2004 17:46:04 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi !

The g5 iommu code would fill the "iommu_table" member of whatever
device node was pointed to by pcidev->sysdata during boot. However,
the ppc64 kernel fills that with a pointer to the PHB node which is
later replaced "lazily" with a pointer to the real node when calling
pci_device_to_OF_node(). In this case, we were thus "losign" the
iommu_table pointer. Typical symptom: loss of the SATA when looking
at it's /proc entry.

This fixes it by forcing the update to the final sysdata pointer
when filling up the iommu_table pointers. The "lazy" thing is useless
on pmac anyway.

Please apply,
Ben.

===== arch/ppc64/kernel/pmac_iommu.c 1.1 vs edited =====
--- 1.1/arch/ppc64/kernel/pmac_iommu.c	Sat Feb 28 09:44:57 2004
+++ edited/arch/ppc64/kernel/pmac_iommu.c	Tue Mar 16 17:45:10 2004
@@ -289,8 +289,11 @@
 	 * things simple. Setup all PCI devices to point to this table
 	 */
 	while ((dev = pci_find_device(PCI_ANY_ID, PCI_ANY_ID, dev)) != NULL) {
-		dn = PCI_GET_DN(dev);
-
+		/* We must use pci_device_to_OF_node() to make sure that
+		 * we get the real "final" pointer to the device in the
+		 * pci_dev sysdata and not the temporary PHB one
+		 */
+		struct device_node *dn = pci_device_to_OF_node(dev);
 		if (dn)
 			dn->iommu_table = &iommu_table_pmac;
 	}


