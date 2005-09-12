Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751238AbVILOzI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751238AbVILOzI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 12 Sep 2005 10:55:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751244AbVILOzH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 12 Sep 2005 10:55:07 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:1543 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751238AbVILOzG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 12 Sep 2005 10:55:06 -0400
Date: Mon, 12 Sep 2005 10:48:51 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org
Cc: ak@suse.de
Subject: [patch 2.6.13 6/6] x86_64: implement dma_sync_single_range_for_{cpu,device}
Message-ID: <09122005104851.31248@bilbo.tuxdriver.com>
In-Reply-To: <09122005104851.31184@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement dma_sync_single_range_for_{cpu,device} for x86_64. This
makes use of swiotlb_sync_single_range_for_{cpu,device}.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 include/asm-x86_64/dma-mapping.h |   28 ++++++++++++++++++++++++++++
 1 files changed, 28 insertions(+)

diff --git a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
--- a/include/asm-x86_64/dma-mapping.h
+++ b/include/asm-x86_64/dma-mapping.h
@@ -85,6 +85,34 @@ static inline void dma_sync_single_for_d
 	flush_write_buffers();
 }
 
+static inline void dma_sync_single_range_for_cpu(struct device *hwdev,
+						 dma_addr_t dma_handle,
+						 unsigned long offset,
+						 size_t size, int direction)
+{
+	if (direction == DMA_NONE)
+		out_of_line_bug();
+
+	if (swiotlb)
+		return swiotlb_sync_single_range_for_cpu(hwdev,dma_handle,offset,size,direction);
+
+	flush_write_buffers();
+}
+
+static inline void dma_sync_single_range_for_device(struct device *hwdev,
+						    dma_addr_t dma_handle,
+						    unsigned long offset,
+						    size_t size, int direction)
+{
+        if (direction == DMA_NONE)
+		out_of_line_bug();
+
+	if (swiotlb)
+		return swiotlb_sync_single_range_for_device(hwdev,dma_handle,offset,size,direction);
+
+	flush_write_buffers();
+}
+
 static inline void dma_sync_sg_for_cpu(struct device *hwdev,
 				       struct scatterlist *sg,
 				       int nelems, int direction)
