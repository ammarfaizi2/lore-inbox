Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964839AbWEYDbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964839AbWEYDbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 23:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964838AbWEYDbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 23:31:39 -0400
Received: from e35.co.us.ibm.com ([32.97.110.153]:6882 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S964839AbWEYDbi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 23:31:38 -0400
Date: Wed, 24 May 2006 22:35:50 -0500
From: Jon Mason <jdmason@us.ibm.com>
To: Andi Kleen <ak@suse.de>
Cc: Muli Ben-Yehuda <muli@il.ibm.com>, Muli Ben-Yehuda <mulix@mulix.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>, discuss@x86-64.org,
       Andrew Morton <akpm@osdl.org>
Subject: [PATCH 2/4] x86-64: Calgary IOMMU - move valid_dma_direction into the callers
Message-ID: <20060525033550.GD7720@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>From Andi Kleen's comments on the original Calgary patch, move
valid_dma_direction into the calling functions.

Signed-off-by: Muli Ben-Yehuda <muli@il.ibm.com>
Signed-off-by: Jon Mason <jdmason@us.ibm.com>

diff -r 460b603caa42 include/asm-x86_64/dma-mapping.h
--- a/include/asm-x86_64/dma-mapping.h	Wed May 24 10:58:12 2006 -0500
+++ b/include/asm-x86_64/dma-mapping.h	Wed May 24 11:01:01 2006 -0500
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
 
