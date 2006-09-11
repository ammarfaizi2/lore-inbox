Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965109AbWIKXWY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965109AbWIKXWY (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:22:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965128AbWIKXV7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:21:59 -0400
Received: from mga01.intel.com ([192.55.52.88]:34107 "EHLO mga01.intel.com")
	by vger.kernel.org with ESMTP id S965109AbWIKXSt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:49 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="128869385:sNHT454346627"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 13/19] dmaengine: add support for dma xor zero sum operations
Date: Mon, 11 Sep 2006 16:18:44 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231844.4737.55349.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/dmaengine.c   |   15 ++++++++++++
 drivers/dma/ioatdma.c     |    6 +++++
 include/linux/dmaengine.h |   56 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 77 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 33ad690..190c612 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -617,6 +617,18 @@ dma_cookie_t dma_async_do_xor_err(struct
 }
 
 /**
+ * dma_async_do_zero_sum_err - default function for dma devices that
+ *	do not support xor zero sum
+ */
+dma_cookie_t dma_async_do_zero_sum_err(struct dma_chan *chan,
+		union dmaengine_addr src, unsigned int src_cnt,
+		unsigned int src_off, size_t len, u32 *result,
+		unsigned long flags)
+{
+	return -ENXIO;
+}
+
+/**
  * dma_async_do_memset_err - default function for dma devices that
  *      do not support memset
  */
@@ -649,6 +661,8 @@ EXPORT_SYMBOL_GPL(dma_async_memset_page)
 EXPORT_SYMBOL_GPL(dma_async_memset_dma);
 EXPORT_SYMBOL_GPL(dma_async_xor_pgs_to_pg);
 EXPORT_SYMBOL_GPL(dma_async_xor_dma_list_to_dma);
+EXPORT_SYMBOL_GPL(dma_async_zero_sum_pgs);
+EXPORT_SYMBOL_GPL(dma_async_zero_sum_dma_list);
 EXPORT_SYMBOL_GPL(dma_async_operation_complete);
 EXPORT_SYMBOL_GPL(dma_async_issue_pending);
 EXPORT_SYMBOL_GPL(dma_async_device_register);
@@ -656,6 +670,7 @@ EXPORT_SYMBOL_GPL(dma_async_device_unreg
 EXPORT_SYMBOL_GPL(dma_chan_cleanup);
 EXPORT_SYMBOL_GPL(dma_async_do_memcpy_err);
 EXPORT_SYMBOL_GPL(dma_async_do_xor_err);
+EXPORT_SYMBOL_GPL(dma_async_do_zero_sum_err);
 EXPORT_SYMBOL_GPL(dma_async_do_memset_err);
 EXPORT_SYMBOL_GPL(dma_async_chan_init);
 EXPORT_SYMBOL_GPL(dma_async_map_page);
diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index 231247c..4e90b02 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -637,6 +637,11 @@ extern dma_cookie_t dma_async_do_xor_err
 	union dmaengine_addr src, unsigned int src_cnt,
 	unsigned int src_off, size_t len, unsigned long flags);
 
+extern dma_cookie_t dma_async_do_zero_sum_err(struct dma_chan *chan,
+        union dmaengine_addr src, unsigned int src_cnt,
+        unsigned int src_off, size_t len, u32 *result, 
+	unsigned long flags);
+
 extern dma_cookie_t dma_async_do_memset_err(struct dma_chan *chan,
 	union dmaengine_addr dest, unsigned int dest_off,
 	int val, size_t size, unsigned long flags);
@@ -752,6 +757,7 @@ #endif
 	device->common.capabilities = DMA_MEMCPY;
 	device->common.device_do_dma_memcpy = do_ioat_dma_memcpy;
 	device->common.device_do_dma_xor = dma_async_do_xor_err;
+	device->common.device_do_dma_zero_sum = dma_async_do_zero_sum_err;
 	device->common.device_do_dma_memset = dma_async_do_memset_err;
 	device->common.map_page = ioat_map_page;
 	device->common.map_single = ioat_map_single;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 8d53b08..9fd6cbd 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -260,6 +260,7 @@ struct dma_chan_client_ref {
  * @device_issue_pending: push appended descriptors to hardware
  * @device_do_dma_memcpy: perform memcpy with a dma engine
  * @device_do_dma_xor: perform block xor with a dma engine
+ * @device_do_dma_zero_sum: perform block xor zero sum with a dma engine
  * @device_do_dma_memset: perform block fill with a dma engine
  */
 struct dma_device {
@@ -285,6 +286,10 @@ struct dma_device {
 			union dmaengine_addr src, unsigned int src_cnt,
 			unsigned int src_off, size_t len,
 			unsigned long flags);
+	dma_cookie_t (*device_do_dma_zero_sum)(struct dma_chan *chan,
+			union dmaengine_addr src, unsigned int src_cnt,
+			unsigned int src_off, size_t len, u32 *result,
+			unsigned long flags);
 	dma_cookie_t (*device_do_dma_memset)(struct dma_chan *chan,
 			union dmaengine_addr dest, unsigned int dest_off,
 			int value, size_t len, unsigned long flags);
@@ -601,6 +606,57 @@ static inline dma_cookie_t dma_async_xor
 }
 
 /**
+ * dma_async_zero_sum_pgs - offloaded xor zero sum from a list of pages
+ * @chan: DMA channel to offload zero sum to
+ * @src_pgs: array of source pages
+ * @src_cnt: number of source pages
+ * @src_off: offset in pages to xor from
+ * @len: length
+ * @result: set to 1 if sum is zero else 0
+ *
+ * Both @dest_page/@dest_off and @src_page/@src_off must be mappable to a bus
+ * address according to the DMA mapping API rules for streaming mappings.
+ * Both @dest_page/@dest_off and @src_page/@src_off must stay memory resident
+ * (kernel memory or locked user space pages)
+ */
+static inline dma_cookie_t dma_async_zero_sum_pgs(struct dma_chan *chan,
+	struct page **src_pgs, unsigned int src_cnt, unsigned int src_off,
+	size_t len, u32 *result)
+{
+	unsigned long flags = DMA_DEST_PAGE | DMA_SRC_PAGES;
+	union dmaengine_addr src_addr = { .pgs = src_pgs };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_xor += len * src_cnt;
+	per_cpu_ptr(chan->local, cpu)->xor_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_zero_sum(chan,
+		src_addr, src_cnt, src_off, len, result, flags);
+}
+
+/**
+ * dma_async_zero_sum_dma_list - offloaded xor zero sum from a dma list
+ * @chan: DMA channel to offload zero sum to
+ * @src_list: array of sources already mapped and consistent
+ * @src_cnt: number of sources
+ * @len: length
+ * @result: set to 1 if sum is zero else 0
+ */
+static inline dma_cookie_t dma_async_zero_sum_dma_list(struct dma_chan *chan,
+	dma_addr_t *src_list, unsigned int src_cnt, size_t len, u32 *result)
+{
+	unsigned long flags = DMA_DEST_DMA | DMA_SRC_DMA_LIST;
+	union dmaengine_addr src_addr = { .dma_list = src_list };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_xor += len * src_cnt;
+	per_cpu_ptr(chan->local, cpu)->xor_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_zero_sum(chan,
+		src_addr, src_cnt, 0, len, result, flags);
+}
+
+/**
  * dma_async_issue_pending - flush pending copies to HW
  * @chan: target DMA channel
  *
