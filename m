Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750767AbWCESGA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750767AbWCESGA (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Mar 2006 13:06:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbWCESGA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Mar 2006 13:06:00 -0500
Received: from snapper.surrealistic.net ([67.40.222.186]:747 "EHLO
	snapper.surrealistic.net") by vger.kernel.org with ESMTP
	id S1750767AbWCESF7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Mar 2006 13:05:59 -0500
Date: Sun, 5 Mar 2006 10:05:47 -0800
From: Jim Westfall <jwestfall@surrealistic.net>
To: linux1394-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] ieee1394: speed up of dma_region_sync_for_cpu
Message-ID: <20060305180547.GB1055@surrealistic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

when attempting to find the 'last' part of the dma region continue the 
search from where we left off, instead of starting the search over.

Signed-off-by: Jim Westfall <jwestfall@surrealistic.net>

--- linux-2.6.15.4/drivers/ieee1394/dma.c.orig	2006-03-01 13:37:45.000000000 -0800
+++ linux-2.6.15.4/drivers/ieee1394/dma.c	2006-03-01 14:32:16.000000000 -0800
@@ -137,12 +137,12 @@ void dma_region_free(struct dma_region *
 
 /* find the scatterlist index and remaining offset corresponding to a
    given offset from the beginning of the buffer */
-static inline int dma_region_find(struct dma_region *dma, unsigned long offset, unsigned long *rem)
+static inline int dma_region_find(struct dma_region *dma, unsigned long offset, unsigned int start, unsigned long *rem)
 {
 	int i;
 	unsigned long off = offset;
 
-	for (i = 0; i < dma->n_dma_pages; i++) {
+	for (i = start; i < dma->n_dma_pages; i++) {
 		if (off < sg_dma_len(&dma->sglist[i])) {
 			*rem = off;
 			break;
@@ -160,7 +160,7 @@ dma_addr_t dma_region_offset_to_bus(stru
 {
 	unsigned long rem = 0;
 
-	struct scatterlist *sg = &dma->sglist[dma_region_find(dma, offset, &rem)];
+	struct scatterlist *sg = &dma->sglist[dma_region_find(dma, offset, 0, &rem)];
 	return sg_dma_address(sg) + rem;
 }
 
@@ -172,8 +172,8 @@ void dma_region_sync_for_cpu(struct dma_
 	if (!len)
 		len = 1;
 
-	first = dma_region_find(dma, offset, &rem);
-	last = dma_region_find(dma, offset + len - 1, &rem);
+	first = dma_region_find(dma, offset, 0, &rem);
+	last = dma_region_find(dma, rem + len - 1, first, &rem);
 
 	pci_dma_sync_sg_for_cpu(dma->dev, &dma->sglist[first], last - first + 1, dma->direction);
 }
@@ -186,8 +186,8 @@ void dma_region_sync_for_device(struct d
 	if (!len)
 		len = 1;
 
-	first = dma_region_find(dma, offset, &rem);
-	last = dma_region_find(dma, offset + len - 1, &rem);
+	first = dma_region_find(dma, offset, 0, &rem);
+	last = dma_region_find(dma, rem + len - 1, first, &rem);
 
 	pci_dma_sync_sg_for_device(dma->dev, &dma->sglist[first], last - first + 1, dma->direction);
 }
