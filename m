Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965100AbWIKXSi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965100AbWIKXSi (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:18:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965101AbWIKXSh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:18:37 -0400
Received: from mga09.intel.com ([134.134.136.24]:50343 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S965100AbWIKXSf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:18:35 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="124924459:sNHT72607752"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 11/19] dmaengine: add memset as an asynchronous dma operation
Date: Mon, 11 Sep 2006 16:18:33 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231833.4737.27198.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Changelog:
* make the dmaengine api EXPORT_SYMBOL_GPL
* zero sum support should be standalone, not integrated into xor

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/dmaengine.c   |   15 ++++++++++
 drivers/dma/ioatdma.c     |    5 +++
 include/linux/dmaengine.h |   68 +++++++++++++++++++++++++++++++++++++++++++++
 3 files changed, 88 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index e78ce89..fe62237 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -604,6 +604,17 @@ dma_cookie_t dma_async_do_xor_err(struct
 	return -ENXIO;
 }
 
+/**
+ * dma_async_do_memset_err - default function for dma devices that
+ *      do not support memset
+ */
+dma_cookie_t dma_async_do_memset_err(struct dma_chan *chan,
+                union dmaengine_addr dest, unsigned int dest_off,
+                int val, size_t len, unsigned long flags)
+{
+        return -ENXIO;
+}
+
 static int __init dma_bus_init(void)
 {
 	mutex_init(&dma_list_mutex);
@@ -621,6 +632,9 @@ EXPORT_SYMBOL_GPL(dma_async_memcpy_pg_to
 EXPORT_SYMBOL_GPL(dma_async_memcpy_dma_to_dma);
 EXPORT_SYMBOL_GPL(dma_async_memcpy_pg_to_dma);
 EXPORT_SYMBOL_GPL(dma_async_memcpy_dma_to_pg);
+EXPORT_SYMBOL_GPL(dma_async_memset_buf);
+EXPORT_SYMBOL_GPL(dma_async_memset_page);
+EXPORT_SYMBOL_GPL(dma_async_memset_dma);
 EXPORT_SYMBOL_GPL(dma_async_xor_pgs_to_pg);
 EXPORT_SYMBOL_GPL(dma_async_xor_dma_list_to_dma);
 EXPORT_SYMBOL_GPL(dma_async_operation_complete);
@@ -629,6 +643,7 @@ EXPORT_SYMBOL_GPL(dma_async_device_regis
 EXPORT_SYMBOL_GPL(dma_async_device_unregister);
 EXPORT_SYMBOL_GPL(dma_chan_cleanup);
 EXPORT_SYMBOL_GPL(dma_async_do_xor_err);
+EXPORT_SYMBOL_GPL(dma_async_do_memset_err);
 EXPORT_SYMBOL_GPL(dma_async_chan_init);
 EXPORT_SYMBOL_GPL(dma_async_map_page);
 EXPORT_SYMBOL_GPL(dma_async_map_single);
diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index 0159d14..231247c 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -637,6 +637,10 @@ extern dma_cookie_t dma_async_do_xor_err
 	union dmaengine_addr src, unsigned int src_cnt,
 	unsigned int src_off, size_t len, unsigned long flags);
 
+extern dma_cookie_t dma_async_do_memset_err(struct dma_chan *chan,
+	union dmaengine_addr dest, unsigned int dest_off,
+	int val, size_t size, unsigned long flags);
+
 static dma_addr_t ioat_map_page(struct dma_chan *chan, struct page *page,
 					unsigned long offset, size_t size,
 					int direction)
@@ -748,6 +752,7 @@ #endif
 	device->common.capabilities = DMA_MEMCPY;
 	device->common.device_do_dma_memcpy = do_ioat_dma_memcpy;
 	device->common.device_do_dma_xor = dma_async_do_xor_err;
+	device->common.device_do_dma_memset = dma_async_do_memset_err;
 	device->common.map_page = ioat_map_page;
 	device->common.map_single = ioat_map_single;
 	device->common.unmap_page = ioat_unmap_page;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index cb4cfcf..8d53b08 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -260,6 +260,7 @@ struct dma_chan_client_ref {
  * @device_issue_pending: push appended descriptors to hardware
  * @device_do_dma_memcpy: perform memcpy with a dma engine
  * @device_do_dma_xor: perform block xor with a dma engine
+ * @device_do_dma_memset: perform block fill with a dma engine
  */
 struct dma_device {
 
@@ -284,6 +285,9 @@ struct dma_device {
 			union dmaengine_addr src, unsigned int src_cnt,
 			unsigned int src_off, size_t len,
 			unsigned long flags);
+	dma_cookie_t (*device_do_dma_memset)(struct dma_chan *chan,
+			union dmaengine_addr dest, unsigned int dest_off,
+			int value, size_t len, unsigned long flags);
 	enum dma_status (*device_operation_complete)(struct dma_chan *chan,
 			dma_cookie_t cookie, dma_cookie_t *last,
 			dma_cookie_t *used);
@@ -478,6 +482,70 @@ static inline dma_cookie_t dma_async_mem
 }
 
 /**
+ * dma_async_memset_buf - offloaded memset
+ * @chan: DMA channel to offload memset to
+ * @buf: destination buffer
+ * @val: value to initialize the buffer
+ * @len: length
+ */
+static inline dma_cookie_t dma_async_memset_buf(struct dma_chan *chan,
+	void *buf, int val, size_t len)
+{
+	unsigned long flags = DMA_DEST_BUF;
+	union dmaengine_addr dest_addr = { .buf = buf };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_memset(chan, dest_addr, 0, val,
+						len, flags);
+}
+
+/**
+ * dma_async_memset_page - offloaded memset
+ * @chan: DMA channel to offload memset to
+ * @page: destination page
+ * @offset: offset into the destination
+ * @val: value to initialize the buffer
+ * @len: length
+ */
+static inline dma_cookie_t dma_async_memset_page(struct dma_chan *chan,
+	struct page *page, unsigned int offset, int val, size_t len)
+{
+	unsigned long flags = DMA_DEST_PAGE;
+	union dmaengine_addr dest_addr = { .pg = page };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_memset(chan, dest_addr, offset, val,
+						len, flags);
+}
+
+/**
+ * dma_async_memset_dma - offloaded memset
+ * @chan: DMA channel to offload memset to
+ * @page: destination dma address
+ * @val: value to initialize the buffer
+ * @len: length
+ */
+static inline dma_cookie_t dma_async_memset_dma(struct dma_chan *chan,
+	dma_addr_t dma, int val, size_t len)
+{
+	unsigned long flags = DMA_DEST_DMA;
+	union dmaengine_addr dest_addr = { .dma = dma };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_memset(chan, dest_addr, 0, val,
+						len, flags);
+}
+
+/**
  * dma_async_xor_pgs_to_pg - offloaded xor from pages to page
  * @chan: DMA channel to offload xor to
  * @dest_page: destination page
