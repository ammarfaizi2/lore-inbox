Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932156AbVH3SAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932156AbVH3SAn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 14:00:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932242AbVH3SAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 14:00:43 -0400
Received: from ra.tuxdriver.com ([24.172.12.4]:6411 "EHLO ra.tuxdriver.com")
	by vger.kernel.org with ESMTP id S932156AbVH3SAm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 14:00:42 -0400
Date: Tue, 30 Aug 2005 14:00:31 -0400
From: "John W. Linville" <linville@tuxdriver.com>
To: linux-kernel@vger.kernel.org
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org
Subject: [patch 2.6.13] x86_64: implement dma_sync_single_range_for_{cpu,device}
Message-ID: <20050830180031.GD18998@tuxdriver.com>
Mail-Followup-To: linux-kernel@vger.kernel.org, Andi Kleen <ak@suse.de>,
	discuss@x86-64.org
References: <20050829200916.GI3716@tuxdriver.com> <200508292254.53476.ak@suse.de> <20050829214828.GA6314@tuxdriver.com> <200508300314.35177.ak@suse.de> <20050830175436.GB18998@tuxdriver.com> <20050830175803.GC18998@tuxdriver.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050830175803.GC18998@tuxdriver.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Implement dma_sync_single_range_for_{cpu,device} on x86_64.

Signed-off-by: John W. Linville <linville@tuxdriver.com>
---
Makes use of swiotlb_sync_single_range_for_{cpu,device} implemented
in preceding patch.

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
-- 
John W. Linville
linville@tuxdriver.com
