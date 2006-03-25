Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751128AbWCYVmK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751128AbWCYVmK (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Mar 2006 16:42:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750869AbWCYVmJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Mar 2006 16:42:09 -0500
Received: from mtagate3.de.ibm.com ([195.212.29.152]:24801 "EHLO
	mtagate3.de.ibm.com") by vger.kernel.org with ESMTP
	id S1751128AbWCYVmI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Mar 2006 16:42:08 -0500
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Subject: [PATCH] x86-64: check for valid DMA data direction in the DMA API
X-Mercurial-Node: 2e00371db0e917d63984e01d04742bdf7ef6df2e
Message-Id: <2e00371db0e917d63984.1143322923@rhun.haifa.ibm.com>
Date: Sat, 25 Mar 2006 23:42:03 +0200
From: Muli Ben-Yehuda <mulix@mulix.org>
To: ak@suse.de
Cc: jdmason@us.ibm.com, mulix@mulix.org, muli@il.ibm.com,
       linux-kernel@vger.kernel.org, discuss@x86-64.org, akpm@osdl.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

# HG changeset patch
# User Muli Ben-Yehuda <mulix@mulix.org>
# Node ID 2e00371db0e917d63984e01d04742bdf7ef6df2e
# Parent  d87c92af50a18516da5b2384b73adaf71b87923e
x86-64: check for valid DMA data direction in the DMA API
 
Check for a valid DMA data direction before calling the specific
dma_ops implementation.

We used to do it in Calgary, Andi requested that it be moved to
generic code.

Signed-off-by: Muli Ben-Yehuda <mulix@mulix.org>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r d87c92af50a1 -r 2e00371db0e9 include/asm-x86_64/dma-mapping.h
--- a/include/asm-x86_64/dma-mapping.h	Sun Mar 26 00:52:23 2006 +0800
+++ b/include/asm-x86_64/dma-mapping.h	Sat Mar 25 22:11:26 2006 +0200
@@ -56,6 +56,13 @@ extern struct dma_mapping_ops* dma_ops;
 extern struct dma_mapping_ops* dma_ops;
 extern int iommu_merge;
 
+static inline int valid_dma_direction(int dma_direction)
+{
+	return ((dma_direction == DMA_BIDIRECTIONAL) ||
+		(dma_direction == DMA_TO_DEVICE) ||
+		(dma_direction == DMA_FROM_DEVICE));
+}
+
 static inline int dma_mapping_error(dma_addr_t dma_addr)
 {
 	if (dma_ops->mapping_error)
@@ -73,6 +80,7 @@ dma_map_single(struct device *hwdev, voi
 dma_map_single(struct device *hwdev, void *ptr, size_t size,
 	       int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	return dma_ops->map_single(hwdev, ptr, size, direction);
 }
 
@@ -80,6 +88,7 @@ dma_unmap_single(struct device *dev, dma
 dma_unmap_single(struct device *dev, dma_addr_t addr,size_t size,
 		 int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	dma_ops->unmap_single(dev, addr, size, direction);
 }
 
@@ -92,6 +101,7 @@ dma_sync_single_for_cpu(struct device *h
 dma_sync_single_for_cpu(struct device *hwdev, dma_addr_t dma_handle,
 			size_t size, int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	if (dma_ops->sync_single_for_cpu)
 		dma_ops->sync_single_for_cpu(hwdev, dma_handle, size,
 					     direction);
@@ -102,6 +112,7 @@ dma_sync_single_for_device(struct device
 dma_sync_single_for_device(struct device *hwdev, dma_addr_t dma_handle,
 			   size_t size, int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	if (dma_ops->sync_single_for_device)
 		dma_ops->sync_single_for_device(hwdev, dma_handle, size,
 						direction);
@@ -112,6 +123,7 @@ dma_sync_single_range_for_cpu(struct dev
 dma_sync_single_range_for_cpu(struct device *hwdev, dma_addr_t dma_handle,
 			      unsigned long offset, size_t size, int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	if (dma_ops->sync_single_range_for_cpu) {
 		dma_ops->sync_single_range_for_cpu(hwdev, dma_handle, offset, size, direction);
 	}
@@ -123,6 +135,7 @@ dma_sync_single_range_for_device(struct 
 dma_sync_single_range_for_device(struct device *hwdev, dma_addr_t dma_handle,
 				 unsigned long offset, size_t size, int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	if (dma_ops->sync_single_range_for_device)
 		dma_ops->sync_single_range_for_device(hwdev, dma_handle,
 						      offset, size, direction);
@@ -134,6 +147,7 @@ dma_sync_sg_for_cpu(struct device *hwdev
 dma_sync_sg_for_cpu(struct device *hwdev, struct scatterlist *sg,
 		    int nelems, int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	if (dma_ops->sync_sg_for_cpu)
 		dma_ops->sync_sg_for_cpu(hwdev, sg, nelems, direction);
 	flush_write_buffers();
@@ -143,6 +157,7 @@ dma_sync_sg_for_device(struct device *hw
 dma_sync_sg_for_device(struct device *hwdev, struct scatterlist *sg,
 		       int nelems, int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	if (dma_ops->sync_sg_for_device) {
 		dma_ops->sync_sg_for_device(hwdev, sg, nelems, direction);
 	}
@@ -153,6 +168,7 @@ static inline int
 static inline int
 dma_map_sg(struct device *hwdev, struct scatterlist *sg, int nents, int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	return dma_ops->map_sg(hwdev, sg, nents, direction);
 }
 
@@ -160,6 +176,7 @@ dma_unmap_sg(struct device *hwdev, struc
 dma_unmap_sg(struct device *hwdev, struct scatterlist *sg, int nents,
 	     int direction)
 {
+	BUG_ON(!valid_dma_direction(direction));
 	dma_ops->unmap_sg(hwdev, sg, nents, direction);
 }
 
