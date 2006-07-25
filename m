Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964797AbWGYQ52@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964797AbWGYQ52 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Jul 2006 12:57:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932483AbWGYQ5B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Jul 2006 12:57:01 -0400
Received: from mtagate6.uk.ibm.com ([195.212.29.139]:29727 "EHLO
	mtagate6.uk.ibm.com") by vger.kernel.org with ESMTP id S932479AbWGYQ46
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Jul 2006 12:56:58 -0400
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH 4 of 7] [x86-64] Calgary IOMMU: fix error path memleak in
	calgary_free_tar
X-Mercurial-Node: 7b1cdbc92f2c618cb59feaf472c8b76df875743d
Message-Id: <7b1cdbc92f2c618cb59f.1153846594@rhun.haifa.ibm.com>
In-Reply-To: <patchbomb.1153846590@rhun.haifa.ibm.com>
Date: Tue, 25 Jul 2006 19:56:34 +0300
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: ak@suse.de
Cc: jdmason@us.ibm.com, linux-kernel@vger.kernel.org, discuss@x86-64.org,
       muli@il.ibm.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

1 files changed, 10 insertions(+), 2 deletions(-)
arch/x86_64/kernel/pci-calgary.c |   12 ++++++++++--


# HG changeset patch
# User Muli Ben-Yehuda <muli@il.ibm.com>
# Date 1153737408 -10800
# Node ID 7b1cdbc92f2c618cb59feaf472c8b76df875743d
# Parent  4b8fbf25700873a70eff09264e52e9f6c6330c18
[x86-64] Calgary IOMMU: fix error path memleak in calgary_free_tar

We were freeing the iommu_table and leaking the bitmap pages. Also
rename it to calgary_free_bus, which is more accurate.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 4b8fbf257008 -r 7b1cdbc92f2c arch/x86_64/kernel/pci-calgary.c
--- a/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:30:03 2006 +0300
+++ b/arch/x86_64/kernel/pci-calgary.c	Mon Jul 24 13:36:48 2006 +0300
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
 
