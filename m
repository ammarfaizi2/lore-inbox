Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262428AbUB0MZl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 07:25:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261813AbUB0MZl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 07:25:41 -0500
Received: from gate.crashing.org ([63.228.1.57]:48314 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262614AbUB0MWb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 07:22:31 -0500
Subject: [PATCH] ppc64 iommu rewrite part 4/5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1077884018.22925.371.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Fri, 27 Feb 2004 23:13:38 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fix drivers/ide when using an IOMMU

# This is a BitKeeper generated diff -Nru style patch.
#
# ChangeSet
#   2004/02/27 22:28:18+11:00 benh@kernel.crashing.org 
#   Make IDE advertise only 128 entries of SG table on archs with an IOMMU.
#   The current IOMMU implementations of pci_map_sg() may produce segments
#   that don't match the boundary requirements of IDE, thus causing the
#   driver to break them up. The BIO is supposed to account for that,
#   however, it cannot account for a pci_map_sg producing a segment of
#   the requested size, but with incorrect alignement, thus we may still
#   try to break up the list in more entries than is supported by the HW.
#   A similar fix already went in libata. The "real" long term fix will be
#   to move the boundary requirements to struct device so that pci_map_sg()
#   can respect them when producing the sglist. In the meantime, this
#   band-aid works around the problem.
# 
# drivers/ide/ide-probe.c
#   2004/02/27 22:28:06+11:00 benh@kernel.crashing.org +16 -1
#   Make IDE advertise only 128 entries of SG table on archs with an IOMMU.
#   The current IOMMU implementations of pci_map_sg() may produce segments
#   that don't match the boundary requirements of IDE, thus causing the
#   driver to break them up. The BIO is supposed to account for that,
#   however, it cannot account for a pci_map_sg producing a segment of
#   the requested size, but with incorrect alignement, thus we may still
#   try to break up the list in more entries than is supported by the HW.
#   A similar fix already went in libata. The "real" long term fix will be
#   to move the boundary requirements to struct device so that pci_map_sg()
#   can respect them when producing the sglist. In the meantime, this
#   band-aid works around the problem.
# 
diff -Nru a/drivers/ide/ide-probe.c b/drivers/ide/ide-probe.c
--- a/drivers/ide/ide-probe.c	Fri Feb 27 22:44:36 2004
+++ b/drivers/ide/ide-probe.c	Fri Feb 27 22:44:36 2004
@@ -50,6 +50,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/kmod.h>
+#include <linux/pci.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -926,11 +927,25 @@
 		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
 
-	/* IDE DMA can do PRD_ENTRIES number of segments. */
+#if !defined(CONFIG_PCI) || PCI_DMA_BUS_IS_PHYS
+	/* IDE DMA can do PRD_ENTRIES number of segments. */	
 	blk_queue_max_hw_segments(q, PRD_ENTRIES);
 
 	/* This is a driver limit and could be eliminated. */
 	blk_queue_max_phys_segments(q, PRD_ENTRIES);
+#else
+	/* When we have an IOMMU, we may have a problem where pci_map_sg()
+	 * creates segments that don't completely match our boundary
+	 * requirements and thus need to be broken up again. Because it
+	 * doesn't align properly neither, we may actually have to break up
+	 * to more segments than what was we got in the first place, a max
+	 * worst case is twice as many.
+	 * This will be fixed once we teach pci_map_sg() about our boundary
+	 * requirements, hopefully soon
+	 */
+	blk_queue_max_hw_segments(q, PRD_ENTRIES / 2);
+	blk_queue_max_phys_segments(q, PRD_ENTRIES / 2);
+#endif
 
 	/* assign drive and gendisk queue */
 	drive->queue = q;


