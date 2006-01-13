Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161283AbWAMPZZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161283AbWAMPZZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Jan 2006 10:25:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161385AbWAMPY4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Jan 2006 10:24:56 -0500
Received: from zproxy.gmail.com ([64.233.162.196]:18597 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S1161283AbWAMPYZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Jan 2006 10:24:25 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:cc:subject:in-reply-to:x-mailer:date:message-id:mime-version:content-type:reply-to:to:content-transfer-encoding:from;
        b=QvOXkkm94+V3T4jI1iA6p3ffIb7zWeISwWYDXcS8kmAf43eLQRZnDR7Lai8aYv5j1E1Nwbki39AiV4sP2LnqW/A7ZGFas7OC8co9t8IlQQQVvPO6wBH5DvsfY/ST0n7WcRKOcpBtMaP9B4tspgMTt4I/QiRL9xYQSaEvJgrCtQ8=
Cc: Tejun Heo <htejun@gmail.com>
Subject: [PATCH 2/8] block: implement blk kmap helpers
In-Reply-To: <11371658562541-git-send-email-htejun@gmail.com>
X-Mailer: git-send-email
Date: Sat, 14 Jan 2006 00:24:16 +0900
Message-Id: <11371658561196-git-send-email-htejun@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Tejun Heo <htejun@gmail.com>
To: axboe@suse.de, bzolnier@gmail.com, rmk@arm.linux.org.uk,
       james.steward@dynamicratings.com, jgarzik@pobox.com,
       James.Bottomley@SteelEye.com, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Tejun Heo <htejun@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

When block requests are handled via DMA dma mapping functions take
care of cache coherency.  Unfortunately, cache coherencly was left
unhandled until now for block PIOs, resulting in data corruption
issues on architectures with aliasing caches.

All block PIO operations use kmap/unmap to access target memory area
and the mapping/unmapping points are the perfect places for cache
flushing.  kmap/unmap are to PIO'ing cpus what dma_map/unmap are to
DMAing devices.

This patch implements blk kmap helpers which additionally take
@direction argument and deal with cache coherency.

Signed-off-by: Tejun Heo <htejun@gmail.com>

---

 include/linux/blkdev.h |   38 ++++++++++++++++++++++++++++++++++++++
 1 files changed, 38 insertions(+), 0 deletions(-)

fdaeda6742b70451ddbb860b440d2533c6591fda
diff --git a/include/linux/blkdev.h b/include/linux/blkdev.h
index 02a585f..1040029 100644
--- a/include/linux/blkdev.h
+++ b/include/linux/blkdev.h
@@ -17,6 +17,10 @@
 
 #include <asm/scatterlist.h>
 
+/* for PIO kmap helpers */
+#include <linux/highmem.h>
+#include <linux/dma-mapping.h>
+
 struct request_queue;
 typedef struct request_queue request_queue_t;
 struct elevator_queue;
@@ -812,6 +816,40 @@ static inline void put_dev_sector(Sector
 	page_cache_release(p.v);
 }
 
+/*
+ * PIO kmap helpers.
+ *
+ * Block PIO requires cache flushes on architectures with aliasing
+ * caches.  If a driver wants to perform PIO on a user-mappable page
+ * (page cache page), it MUST use one of the following kmap/unmap
+ * helpers unless it handles cache coherency itself.
+ */
+static inline void * blk_kmap_atomic(struct page *page, enum km_type type,
+				     enum dma_data_direction dir)
+{
+	return kmap_atomic(page, type);
+}
+
+static inline void blk_kunmap_atomic(void *addr, enum km_type type,
+				     enum dma_data_direction dir)
+{
+	if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
+		flush_dcache_page(kmap_atomic_to_page(addr));
+	kunmap_atomic(addr, type);
+}
+
+static inline void * blk_kmap(struct page *page, enum dma_data_direction dir)
+{
+	return kmap(page);
+}
+
+static inline void blk_kunmap(struct page *page, enum dma_data_direction dir)
+{
+	if (dir == DMA_BIDIRECTIONAL || dir == DMA_FROM_DEVICE)
+		flush_dcache_page(page);
+	kunmap(page);
+}
+
 struct work_struct;
 int kblockd_schedule_work(struct work_struct *work);
 void kblockd_flush(void);
-- 
1.0.6


