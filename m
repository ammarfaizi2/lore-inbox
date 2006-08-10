Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932395AbWHJUER@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932395AbWHJUER (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Aug 2006 16:04:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932631AbWHJTgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Aug 2006 15:36:39 -0400
Received: from ns.suse.de ([195.135.220.2]:53136 "EHLO mx1.suse.de")
	by vger.kernel.org with ESMTP id S932630AbWHJTge (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Aug 2006 15:36:34 -0400
From: Andi Kleen <ak@suse.de>
References: <20060810 935.775038000@suse.de>
In-Reply-To: <20060810 935.775038000@suse.de>
Subject: [PATCH for review] [77/145] x86_64:  Calgary IOMMU: fix error path memleak in calgary_free_tar
Message-Id: <20060810193633.B44D513C0B@wotan.suse.de>
Date: Thu, 10 Aug 2006 21:36:33 +0200 (CEST)
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

r

From: Muli Ben-Yehuda <muli@il.ibm.com>

We were freeing the iommu_table and leaking the bitmap pages. Also
rename it to calgary_free_bus, which is more accurate.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>

---
 arch/x86_64/kernel/pci-calgary.c |   12 ++++++++++--
 1 files changed, 10 insertions(+), 2 deletions(-)

Index: linux/arch/x86_64/kernel/pci-calgary.c
===================================================================
--- linux.orig/arch/x86_64/kernel/pci-calgary.c
+++ linux/arch/x86_64/kernel/pci-calgary.c
@@ -658,11 +658,12 @@ static int __init calgary_setup_tar(stru
 	return 0;
 }
 
-static void __init calgary_free_tar(struct pci_dev *dev)
+static void __init calgary_free_bus(struct pci_dev *dev)
 {
 	u64 val64;
 	struct iommu_table *tbl = dev->sysdata;
 	void __iomem *target;
+	unsigned int bitmapsz;
 
 	target = calgary_reg(tbl->bbar, tar_offset(dev->bus->number));
 	val64 = be64_to_cpu(readq(target));
@@ -670,8 +671,15 @@ static void __init calgary_free_tar(stru
 	writeq(cpu_to_be64(val64), target);
 	readq(target); /* flush */
 
+	bitmapsz = tbl->it_size / BITS_PER_BYTE;
+	free_pages((unsigned long)tbl->it_map, get_order(bitmapsz));
+	tbl->it_map = NULL;
+
 	kfree(tbl);
 	dev->sysdata = NULL;
+
+	/* Can't free bootmem allocated memory after system is up :-( */
+	bus_info[dev->bus->number].tce_space = NULL;
 }
 
 static void calgary_watchdog(unsigned long data)
@@ -853,7 +861,7 @@ error:
 		if (!bus_info[dev->bus->number].tce_space && !translate_empty_slots)
 			continue;
 		calgary_disable_translation(dev);
-		calgary_free_tar(dev);
+		calgary_free_bus(dev);
 		pci_dev_put(dev);
 	}
 
