Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751494AbVH2UJk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751494AbVH2UJk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 29 Aug 2005 16:09:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751497AbVH2UJk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 29 Aug 2005 16:09:40 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:29446 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S1751494AbVH2UJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 29 Aug 2005 16:09:39 -0400
Date: Mon, 29 Aug 2005 16:09:18 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: ak@suse.de, discuss@x86-64.org
Subject: [patch 2.6.13] x86_64: implement dma_sync_single_range_for_{cpu,device}
Message-ID: <20050829200916.GI3716@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, ak@suse.de,
	discuss@x86-64.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement dma_sync_single_range_for_{cpu,device}, based on curent
implementations of dma_sync_single_for_{cpu,device}.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
It is hard to use this API if common platforms do not implement it. :-)
Hopefully I did not miss something obvious?

This is a naive implementation, so flame away...

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
+		return swiotlb_sync_single_for_cpu(hwdev,dma_handle+offset,size,direction);
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
+		return swiotlb_sync_single_for_device(hwdev,dma_handle+offset,size,direction);
+
+	flush_write_buffers();
+}
+
 static inline void dma_sync_sg_for_cpu(struct device *hwdev,
 				       struct scatterlist *sg,
 				       int nelems, int direction)
-- 
John W. Linville
linville@tuxdriver.com
