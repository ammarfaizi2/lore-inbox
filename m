Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUB0NNg (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Feb 2004 08:13:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262857AbUB0NNg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Feb 2004 08:13:36 -0500
Received: from gate.crashing.org ([63.228.1.57]:58810 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S262850AbUB0NN2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Feb 2004 08:13:28 -0500
Subject: Re: [PATCH] ppc64 iommu rewrite part 4/5
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andi Kleen <ak@suse.de>, Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <p73oerk4ree.fsf@verdi.suse.de>
References: <1077884018.22925.371.camel@gaston.suse.lists.linux.kernel>
	 <p73oerk4ree.fsf@verdi.suse.de>
Content-Type: text/plain
Message-Id: <1077887067.22954.1.camel@gaston>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 
Date: Sat, 28 Feb 2004 00:04:28 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-02-27 at 23:51, Andi Kleen wrote:
> Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:
> 
> > +#if !defined(CONFIG_PCI) || PCI_DMA_BUS_IS_PHYS
> 
> Can you make that a run time test? On x86-64 PCI_DMA_BUS_IS_PHYS is 
> defined to a variable.

Sure, here's a revised version:

diff -urN linux-2.5/drivers/ide/ide-probe.c linux-iommu/drivers/ide/ide-probe.c
--- linux-2.5/drivers/ide/ide-probe.c	2004-02-28 00:02:30.971890984 +1100
+++ linux-iommu/drivers/ide/ide-probe.c	2004-02-28 00:02:07.145513144 +1100
@@ -50,6 +50,7 @@
 #include <linux/spinlock.h>
 #include <linux/pci.h>
 #include <linux/kmod.h>
+#include <linux/pci.h>
 
 #include <asm/byteorder.h>
 #include <asm/irq.h>
@@ -904,6 +905,7 @@
 	request_queue_t *q;
 	ide_hwif_t *hwif = HWIF(drive);
 	int max_sectors = 256;
+	int max_sg_entries = PRD_ENTRIES;
 
 	/*
 	 *	Our default set up assumes the normal IDE case,
@@ -926,11 +928,22 @@
 		max_sectors = hwif->rqsize;
 	blk_queue_max_sectors(q, max_sectors);
 
-	/* IDE DMA can do PRD_ENTRIES number of segments. */
-	blk_queue_max_hw_segments(q, PRD_ENTRIES);
+#ifdef CONFIG_PCI
+	/* When we have an IOMMU, we may have a problem where pci_map_sg()
+	 * creates segments that don't completely match our boundary
+	 * requirements and thus need to be broken up again. Because it
+	 * doesn't align properly neither, we may actually have to break up
+	 * to more segments than what was we got in the first place, a max
+	 * worst case is twice as many.
+	 * This will be fixed once we teach pci_map_sg() about our boundary
+	 * requirements, hopefully soon
+	 */
+	if (!PCI_DMA_BUS_IS_PHYS)
+		max_sg_entries >>= 1;
+#endif /* CONFIG_PCI */
 
-	/* This is a driver limit and could be eliminated. */
-	blk_queue_max_phys_segments(q, PRD_ENTRIES);
+	blk_queue_max_hw_segments(q, max_sg_entries);
+	blk_queue_max_phys_segments(q, max_sg_entries);
 
 	/* assign drive and gendisk queue */
 	drive->queue = q;


