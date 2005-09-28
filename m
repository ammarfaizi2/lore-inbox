Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVI1VyB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVI1VyB (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Sep 2005 17:54:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751068AbVI1VyA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Sep 2005 17:54:00 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:35077 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751048AbVI1Vxh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Sep 2005 17:53:37 -0400
Date: Wed, 28 Sep 2005 17:50:50 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org, discuss@x86-64.org
Cc: ak@suse.de
Subject: [patch 2.6.14-rc2 6/6] x86_64: implement dma_sync_single_range_for_{cpu,device}
Message-ID: <09282005175050.10472@bilbo.tuxdriver.com>
In-Reply-To: <09282005175050.10409@bilbo.tuxdriver.com>
User-Agent: PatchPost/0.1
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Re-implement dma_sync_single_range_for_{cpu,device} for x86_64 using
swiotlb_sync_single_range_for_{cpu,device}.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---

 include/asm-x86_64/dma-mapping.h |   31 +++++++++++++++++++++++++++----
 1 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/include/asm-x86_64/dma-mapping.h b/include/asm-x86_64/dma-mapping.h
--- a/include/asm-x86_64/dma-mapping.h
+++ b/include/asm-x86_64/dma-mapping.h
@@ -85,10 +85,33 @@ static inline void dma_sync_single_for_d
 	flush_write_buffers();
 }
 
-#define dma_sync_single_range_for_cpu(dev, dma_handle, offset, size, dir)       \
-        dma_sync_single_for_cpu(dev, dma_handle, size, dir)
-#define dma_sync_single_range_for_device(dev, dma_handle, offset, size, dir)    \
-        dma_sync_single_for_device(dev, dma_handle, size, dir)
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
 
 static inline void dma_sync_sg_for_cpu(struct device *hwdev,
 				       struct scatterlist *sg,
