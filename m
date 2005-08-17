Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751298AbVHQVeu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751298AbVHQVeu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 17:34:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751299AbVHQVeu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 17:34:50 -0400
Received: from gate.crashing.org ([63.228.1.57]:38348 "EHLO gate.crashing.org")
	by vger.kernel.org with ESMTP id S1751298AbVHQVet (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 17:34:49 -0400
Subject: [PATCH] ppc64: iommu vmerge fix]
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: Linux Kernel list <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@osdl.org>
Content-Type: text/plain
Date: Thu, 18 Aug 2005 07:32:18 +1000
Message-Id: <1124314339.8849.32.camel@gaston>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Brian King <brking@us.ibm.com>

(Looks quite bad, should probably get in right away)

The patch below fixes a bug in the PPC64 iommu vmerge code
which results in the potential for iommu_unmap_sg to go off
unmapping more than it should. This was found on a test system
which resulted in PCI bus errors due to PCI memory being
unmapped while DMAs were still in progress.

Signed-off-by: Brian King <brking@us.ibm.com>
Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---

 linux-2.6-bjking1/arch/ppc64/kernel/iommu.c |    7 ++++---
 1 files changed, 4 insertions(+), 3 deletions(-)

diff -puN arch/ppc64/kernel/iommu.c~ppc64_iommu_vmerge_fix arch/ppc64/kernel/iommu.c
--- linux-2.6/arch/ppc64/kernel/iommu.c~ppc64_iommu_vmerge_fix	2005-08-17 15:34:50.000000000 -0500
+++ linux-2.6-bjking1/arch/ppc64/kernel/iommu.c	2005-08-17 15:35:19.000000000 -0500
@@ -242,7 +242,7 @@ int iommu_map_sg(struct device *dev, str
 	dma_addr_t dma_next = 0, dma_addr;
 	unsigned long flags;
 	struct scatterlist *s, *outs, *segstart;
-	int outcount;
+	int outcount, incount;
 	unsigned long handle;
 
 	BUG_ON(direction == DMA_NONE);
@@ -252,6 +252,7 @@ int iommu_map_sg(struct device *dev, str
 
 	outs = s = segstart = &sglist[0];
 	outcount = 1;
+	incount = nelems;
 	handle = 0;
 
 	/* Init first segment length for backout at failure */
@@ -338,10 +339,10 @@ int iommu_map_sg(struct device *dev, str
 
 	DBG("mapped %d elements:\n", outcount);
 
-	/* For the sake of iommu_free_sg, we clear out the length in the
+	/* For the sake of iommu_unmap_sg, we clear out the length in the
 	 * next entry of the sglist if we didn't fill the list completely
 	 */
-	if (outcount < nelems) {
+	if (outcount < incount) {
 		outs++;
 		outs->dma_address = DMA_ERROR_CODE;
 		outs->dma_length = 0;
_

