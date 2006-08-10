Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751498AbWHJUEy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbWHJUEy (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751189AbWHJUEk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 16:04:40 -0400
Received: from ns2.suse.de ([195.135.220.15]:55019 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S932632AbWHJTgg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:36 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [78/145] x86_64: Calgary IOMMU: fix reference counting of Calgary PCI devices
Message-Id: <20060810193634.C446413C16@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:34 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

The pci_get_device() API decrements the reference count on the 'from'
parameter when it continues searching. Therefore, take a ref count on
Calgary bus when we initialize them in either translated or
non-translated mode.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -786,6 +786,7 @@ static inline unsigned int __init locate
 
 static int __init calgary_init_one_nontraslated(struct pci_dev *dev)
 {
+	pci_dev_get(dev);
 	dev->sysdata = NULL;
 	dev->bus->self = dev;
 
@@ -810,6 +811,7 @@ static int __init calgary_init_one(struc
 	if (ret)
 		goto iounmap;
 
+	pci_dev_get(dev);
 	dev->bus->self = dev;
 	calgary_enable_translation(dev);
 
@@ -836,10 +838,9 @@ static int __init calgary_init(void)
 			calgary_init_one_nontraslated(dev);
 			continue;
 		}
-		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots) {
-			pci_dev_put(dev);
+		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots)
 			continue;
-		}
+
 		ret = calgary_init_one(dev);
 		if (ret)
 			goto error;
@@ -860,9 +861,10 @@ error:
 		}
 		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots)
 			continue;
+
 		calgary_disable_translation(dev);
 		calgary_free_bus(dev);
-		pci_dev_put(dev);
+		pci_dev_put(dev); /* Undo calgary_init_one()'s pci_dev_get() */
 	}
 
 	return ret;
