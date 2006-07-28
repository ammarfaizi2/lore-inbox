Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161212AbWG1SQe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161212AbWG1SQe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:16:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161214AbWG1SQe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:16:34 -0400
Received: from mga01.intel.com ([192.55.52.88]:53796 "EHLO
	fmsmga101-1.fm.intel.com") by vger.kernel.org with ESMTP
	id S1161212AbWG1SQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:16:33 -0400
X-IronPort-AV: i="4.07,193,1151910000"; 
   d="scan'208"; a="106710760:sNHT201159868"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH rev2 2/4] dmaengine: reduce backend address permutations
Date: Fri, 28 Jul 2006 11:16:24 -0700
To: davem@davemloft.net, linux-kernel@vger.kernel.org
Cc: neilb@suse.de, galak@kernel.crashing.org, christopher.leech@intel.com,
       alan@lxorguk.ukuu.org.uk, dan.j.williams@intel.com
Message-Id: <20060728181624.5948.48250.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060728181618.5948.27138.stgit@dwillia2-linux.ch.intel.com>
References: <20060728181618.5948.27138.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Change the backend dma driver API to accept a 'union dmaengine_addr'.  The
intent is to be able to support a wide range of frontend address type
permutations without needing an equal number of function type permutations
on the backend.

version 2: make the dmaengine api EXPORT_SYMBOL_GPL

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/dmaengine.c   |   16 +++-
 drivers/dma/ioatdma.c     |  187 +++++++++++++++++--------------------------
 include/linux/dmaengine.h |  195 +++++++++++++++++++++++++++++++++++++++------
 3 files changed, 253 insertions(+), 145 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index a9403df..2aaf21c 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -593,12 +593,14 @@ void dma_async_device_unregister(struct 
 }
 
 /**
- * dma_async_xor_pgs_to_pg_err - default function for dma devices that
+ * dma_async_do_xor_err - default function for dma devices that
  *	do not support xor
  */
-dma_cookie_t dma_async_xor_pgs_to_pg_err(struct dma_chan *chan,
-	struct page *dest_pg, unsigned int dest_off, struct page *src_pgs,
-	unsigned int src_cnt, unsigned int src_off, size_t len, u32 *result)
+dma_cookie_t dma_async_do_xor_err(struct dma_chan *chan,
+		union dmaengine_addr dest, unsigned int dest_off,
+		union dmaengine_addr src, unsigned int src_cnt,
+		unsigned int src_off, size_t len, u32 *result,
+		unsigned long flags)
 {
 	return -ENXIO;
 }
@@ -617,11 +619,15 @@ EXPORT_SYMBOL_GPL(dma_async_client_chan_
 EXPORT_SYMBOL_GPL(dma_async_memcpy_buf_to_buf);
 EXPORT_SYMBOL_GPL(dma_async_memcpy_buf_to_pg);
 EXPORT_SYMBOL_GPL(dma_async_memcpy_pg_to_pg);
+EXPORT_SYMBOL_GPL(dma_async_memcpy_dma_to_dma);
+EXPORT_SYMBOL_GPL(dma_async_memcpy_pg_to_dma);
+EXPORT_SYMBOL_GPL(dma_async_memcpy_dma_to_pg);
 EXPORT_SYMBOL_GPL(dma_async_xor_pgs_to_pg);
+EXPORT_SYMBOL_GPL(dma_async_xor_dma_list_to_dma);
 EXPORT_SYMBOL_GPL(dma_async_operation_complete);
 EXPORT_SYMBOL_GPL(dma_async_issue_pending);
 EXPORT_SYMBOL_GPL(dma_async_device_register);
 EXPORT_SYMBOL_GPL(dma_async_device_unregister);
 EXPORT_SYMBOL_GPL(dma_chan_cleanup);
-EXPORT_SYMBOL_GPL(dma_async_xor_pgs_to_pg_err);
+EXPORT_SYMBOL_GPL(dma_async_do_xor_err);
 EXPORT_SYMBOL_GPL(dma_async_chan_init);
diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index 415de03..511e8c1 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -213,20 +213,25 @@ static void ioat_dma_free_chan_resources
 
 /**
  * do_ioat_dma_memcpy - actual function that initiates a IOAT DMA transaction
- * @ioat_chan: IOAT DMA channel handle
- * @dest: DMA destination address
- * @src: DMA source address
+ * @chan: IOAT DMA channel handle
+ * @dest: DMAENGINE destination address
+ * @dest_off: Page offset
+ * @src: DMAENGINE source address
+ * @src_off: Page offset
  * @len: transaction length in bytes
  */
 
-static dma_cookie_t do_ioat_dma_memcpy(struct ioat_dma_chan *ioat_chan,
-                                       dma_addr_t dest,
-                                       dma_addr_t src,
-                                       size_t len)
+static dma_cookie_t do_ioat_dma_memcpy(struct dma_chan *dma_chan,
+                                       union dmaengine_addr dest,
+					unsigned int dest_off,
+                                       union dmaengine_addr src,
+					unsigned int src_off,
+                                       size_t len,
+                                       unsigned long flags)
 {
 	struct ioat_desc_sw *first;
 	struct ioat_desc_sw *prev;
-	struct ioat_desc_sw *new;
+	struct ioat_desc_sw *new = 0;
 	dma_cookie_t cookie;
 	LIST_HEAD(new_chain);
 	u32 copy;
@@ -234,16 +239,47 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 	dma_addr_t orig_src, orig_dst;
 	unsigned int desc_count = 0;
 	unsigned int append = 0;
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(dma_chan);
 
-	if (!ioat_chan || !dest || !src)
+	if (!dma_chan || !dest.dma || !src.dma)
 		return -EFAULT;
 
 	if (!len)
 		return ioat_chan->common.cookie;
 
+	switch (flags & (DMA_SRC_BUF | DMA_SRC_PAGE | DMA_SRC_DMA)) {
+	case DMA_SRC_BUF:
+		src.dma = pci_map_single(ioat_chan->device->pdev,
+			src.buf, len, PCI_DMA_TODEVICE);
+		break;
+	case DMA_SRC_PAGE:
+		src.dma = pci_map_page(ioat_chan->device->pdev,
+			src.pg, src_off, len, PCI_DMA_TODEVICE);
+		break;
+	case DMA_SRC_DMA:
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	switch (flags & (DMA_DEST_BUF | DMA_DEST_PAGE | DMA_DEST_DMA)) {
+	case DMA_DEST_BUF:
+		dest.dma = pci_map_single(ioat_chan->device->pdev,
+			dest.buf, len, PCI_DMA_FROMDEVICE);
+		break;
+	case DMA_DEST_PAGE:
+		dest.dma = pci_map_page(ioat_chan->device->pdev,
+			dest.pg, dest_off, len, PCI_DMA_FROMDEVICE);
+		break;
+	case DMA_DEST_DMA:
+		break;
+	default:
+		return -EFAULT;
+	}
+
 	orig_len = len;
-	orig_src = src;
-	orig_dst = dest;
+	orig_src = src.dma;
+	orig_dst = dest.dma;
 
 	first = NULL;
 	prev = NULL;
@@ -266,8 +302,8 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 
 		new->hw->size = copy;
 		new->hw->ctl = 0;
-		new->hw->src_addr = src;
-		new->hw->dst_addr = dest;
+		new->hw->src_addr = src.dma;
+		new->hw->dst_addr = dest.dma;
 		new->cookie = 0;
 
 		/* chain together the physical address list for the HW */
@@ -279,8 +315,8 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 		prev = new;
 
 		len  -= copy;
-		dest += copy;
-		src  += copy;
+		dest.dma += copy;
+		src.dma  += copy;
 
 		list_add_tail(&new->node, &new_chain);
 		desc_count++;
@@ -321,89 +357,7 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 }
 
 /**
- * ioat_dma_memcpy_buf_to_buf - wrapper that takes src & dest bufs
- * @chan: IOAT DMA channel handle
- * @dest: DMA destination address
- * @src: DMA source address
- * @len: transaction length in bytes
- */
-
-static dma_cookie_t ioat_dma_memcpy_buf_to_buf(struct dma_chan *chan,
-                                               void *dest,
-                                               void *src,
-                                               size_t len)
-{
-	dma_addr_t dest_addr;
-	dma_addr_t src_addr;
-	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
-
-	dest_addr = pci_map_single(ioat_chan->device->pdev,
-		dest, len, PCI_DMA_FROMDEVICE);
-	src_addr = pci_map_single(ioat_chan->device->pdev,
-		src, len, PCI_DMA_TODEVICE);
-
-	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
-}
-
-/**
- * ioat_dma_memcpy_buf_to_pg - wrapper, copying from a buf to a page
- * @chan: IOAT DMA channel handle
- * @page: pointer to the page to copy to
- * @offset: offset into that page
- * @src: DMA source address
- * @len: transaction length in bytes
- */
-
-static dma_cookie_t ioat_dma_memcpy_buf_to_pg(struct dma_chan *chan,
-                                              struct page *page,
-                                              unsigned int offset,
-                                              void *src,
-                                              size_t len)
-{
-	dma_addr_t dest_addr;
-	dma_addr_t src_addr;
-	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
-
-	dest_addr = pci_map_page(ioat_chan->device->pdev,
-		page, offset, len, PCI_DMA_FROMDEVICE);
-	src_addr = pci_map_single(ioat_chan->device->pdev,
-		src, len, PCI_DMA_TODEVICE);
-
-	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
-}
-
-/**
- * ioat_dma_memcpy_pg_to_pg - wrapper, copying between two pages
- * @chan: IOAT DMA channel handle
- * @dest_pg: pointer to the page to copy to
- * @dest_off: offset into that page
- * @src_pg: pointer to the page to copy from
- * @src_off: offset into that page
- * @len: transaction length in bytes. This is guaranteed not to make a copy
- *	 across a page boundary.
- */
-
-static dma_cookie_t ioat_dma_memcpy_pg_to_pg(struct dma_chan *chan,
-                                             struct page *dest_pg,
-                                             unsigned int dest_off,
-                                             struct page *src_pg,
-                                             unsigned int src_off,
-                                             size_t len)
-{
-	dma_addr_t dest_addr;
-	dma_addr_t src_addr;
-	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
-
-	dest_addr = pci_map_page(ioat_chan->device->pdev,
-		dest_pg, dest_off, len, PCI_DMA_FROMDEVICE);
-	src_addr = pci_map_page(ioat_chan->device->pdev,
-		src_pg, src_off, len, PCI_DMA_TODEVICE);
-
-	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
-}
-
-/**
- * ioat_dma_memcpy_issue_pending - push potentially unrecognized appended descriptors to hw
+ * ioat_dma_memcpy_issue_pending - push potentially unrecognoized appended descriptors to hw
  * @chan: DMA channel handle
  */
 
@@ -626,24 +580,24 @@ #define IOAT_TEST_SIZE 2000
 static int ioat_self_test(struct ioat_device *device)
 {
 	int i;
-	u8 *src;
-	u8 *dest;
+	union dmaengine_addr src;
+	union dmaengine_addr dest;
 	struct dma_chan *dma_chan;
 	dma_cookie_t cookie;
 	int err = 0;
 
-	src = kzalloc(sizeof(u8) * IOAT_TEST_SIZE, SLAB_KERNEL);
-	if (!src)
+	src.buf = kzalloc(sizeof(u8) * IOAT_TEST_SIZE, SLAB_KERNEL);
+	if (!src.buf)
 		return -ENOMEM;
-	dest = kzalloc(sizeof(u8) * IOAT_TEST_SIZE, SLAB_KERNEL);
-	if (!dest) {
-		kfree(src);
+	dest.buf = kzalloc(sizeof(u8) * IOAT_TEST_SIZE, SLAB_KERNEL);
+	if (!dest.buf) {
+		kfree(src.buf);
 		return -ENOMEM;
 	}
 
 	/* Fill in src buffer */
 	for (i = 0; i < IOAT_TEST_SIZE; i++)
-		src[i] = (u8)i;
+		((u8 *) src.buf)[i] = (u8)i;
 
 	/* Start copy, using first DMA channel */
 	dma_chan = container_of(device->common.channels.next,
@@ -654,7 +608,8 @@ static int ioat_self_test(struct ioat_de
 		goto out;
 	}
 
-	cookie = ioat_dma_memcpy_buf_to_buf(dma_chan, dest, src, IOAT_TEST_SIZE);
+	cookie = do_ioat_dma_memcpy(dma_chan, dest, 0, src, 0,
+		IOAT_TEST_SIZE, DMA_SRC_BUF | DMA_DEST_BUF);
 	ioat_dma_memcpy_issue_pending(dma_chan);
 	msleep(1);
 
@@ -663,7 +618,7 @@ static int ioat_self_test(struct ioat_de
 		err = -ENODEV;
 		goto free_resources;
 	}
-	if (memcmp(src, dest, IOAT_TEST_SIZE)) {
+	if (memcmp(src.buf, dest.buf, IOAT_TEST_SIZE)) {
 		printk(KERN_ERR "ioatdma: Self-test copy failed compare, disabling\n");
 		err = -ENODEV;
 		goto free_resources;
@@ -672,11 +627,17 @@ static int ioat_self_test(struct ioat_de
 free_resources:
 	ioat_dma_free_chan_resources(dma_chan);
 out:
-	kfree(src);
-	kfree(dest);
+	kfree(src.buf);
+	kfree(dest.buf);
 	return err;
 }
 
+extern dma_cookie_t dma_async_do_xor_err(struct dma_chan *chan,
+	union dmaengine_addr dest, unsigned int dest_off,
+	union dmaengine_addr src, unsigned int src_cnt,
+	unsigned int src_off, size_t len, u32 *result,
+	unsigned long flags);
+
 static int __devinit ioat_probe(struct pci_dev *pdev,
                                 const struct pci_device_id *ent)
 {
@@ -752,13 +713,11 @@ #endif
 
 	device->common.device_alloc_chan_resources = ioat_dma_alloc_chan_resources;
 	device->common.device_free_chan_resources = ioat_dma_free_chan_resources;
-	device->common.device_memcpy_buf_to_buf = ioat_dma_memcpy_buf_to_buf;
-	device->common.device_memcpy_buf_to_pg = ioat_dma_memcpy_buf_to_pg;
-	device->common.device_memcpy_pg_to_pg = ioat_dma_memcpy_pg_to_pg;
 	device->common.device_operation_complete = ioat_dma_is_complete;
-	device->common.device_xor_pgs_to_pg = dma_async_xor_pgs_to_pg_err;
 	device->common.device_issue_pending = ioat_dma_memcpy_issue_pending;
 	device->common.capabilities = DMA_MEMCPY;
+	device->common.device_do_dma_memcpy = do_ioat_dma_memcpy;
+	device->common.device_do_dma_xor = dma_async_do_xor_err;
 	printk(KERN_INFO "Intel(R) I/OAT DMA Engine found, %d channels\n",
 		device->common.chancnt);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index e754022..d325919 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -86,6 +86,32 @@ enum dma_capabilities {
 };
 
 /**
+ * union dmaengine_addr - Private address types
+ * -passing a dma address to the hardware engine
+ *  implies skipping the dma_map* operation
+ */
+union dmaengine_addr {
+	void *buf;
+	struct page *pg;
+	struct page **pgs;
+	dma_addr_t dma;
+	dma_addr_t *dma_list;
+};
+
+enum dmaengine_flags {
+	DMA_SRC_BUF		= 0x1,
+	DMA_SRC_PAGE		= 0x2,
+	DMA_SRC_PAGES		= 0x4,
+	DMA_SRC_DMA		= 0x8,
+	DMA_SRC_DMA_LIST	= 0x10,
+	DMA_DEST_BUF		= 0x20,
+	DMA_DEST_PAGE		= 0x40,
+	DMA_DEST_PAGES		= 0x80,
+	DMA_DEST_DMA		= 0x100,
+	DMA_DEST_DMA_LIST	= 0x200,
+};
+
+/**
  * struct dma_chan_percpu - the per-CPU part of struct dma_chan
  * @refcount: local_t used for open-coded "bigref" counting
  * @memcpy_count: transaction counter
@@ -230,11 +256,10 @@ struct dma_chan_client_ref {
  * @device_alloc_chan_resources: allocate resources and return the
  *	number of allocated descriptors
  * @device_free_chan_resources: release DMA channel's resources
- * @device_memcpy_buf_to_buf: memcpy buf pointer to buf pointer
- * @device_memcpy_buf_to_pg: memcpy buf pointer to struct page
- * @device_memcpy_pg_to_pg: memcpy struct page/offset to struct page/offset
  * @device_memcpy_complete: poll the status of an IOAT DMA transaction
- * @device_memcpy_issue_pending: push appended descriptors to hardware
+ * @device_issue_pending: push appended descriptors to hardware
+ * @device_do_dma_memcpy: perform memcpy with a dma engine
+ * @device_do_dma_xor: perform block xor with a dma engine
  */
 struct dma_device {
 
@@ -250,18 +275,15 @@ struct dma_device {
 
 	int (*device_alloc_chan_resources)(struct dma_chan *chan);
 	void (*device_free_chan_resources)(struct dma_chan *chan);
-	dma_cookie_t (*device_memcpy_buf_to_buf)(struct dma_chan *chan,
-			void *dest, void *src, size_t len);
-	dma_cookie_t (*device_memcpy_buf_to_pg)(struct dma_chan *chan,
-			struct page *page, unsigned int offset, void *kdata,
-			size_t len);
-	dma_cookie_t (*device_memcpy_pg_to_pg)(struct dma_chan *chan,
-			struct page *dest_pg, unsigned int dest_off,
-			struct page *src_pg, unsigned int src_off, size_t len);
-	dma_cookie_t (*device_xor_pgs_to_pg)(struct dma_chan *chan,
-			struct page *dest_pg, unsigned int dest_off,
-			struct page **src_pgs, unsigned int src_cnt,
-			unsigned int src_off, size_t len, u32 *result);
+	dma_cookie_t (*device_do_dma_memcpy)(struct dma_chan *chan,
+			union dmaengine_addr dest, unsigned int dest_off,
+			union dmaengine_addr src, unsigned int src_off,
+                       size_t len, unsigned long flags);
+	dma_cookie_t (*device_do_dma_xor)(struct dma_chan *chan,
+			union dmaengine_addr dest, unsigned int dest_off,
+			union dmaengine_addr src, unsigned int src_cnt,
+			unsigned int src_off, size_t len, u32 *result,
+			unsigned long flags);
 	enum dma_status (*device_operation_complete)(struct dma_chan *chan,
 			dma_cookie_t cookie, dma_cookie_t *last,
 			dma_cookie_t *used);
@@ -275,9 +297,6 @@ void dma_async_client_unregister(struct 
 int dma_async_client_chan_request(struct dma_client *client,
 		unsigned int number, unsigned int mask);
 void dma_async_chan_init(struct dma_chan *chan, struct dma_device *device);
-dma_cookie_t dma_async_xor_pgs_to_pg_err(struct dma_chan *chan,
-	struct page *dest_pg, unsigned int dest_off, struct page *src_pgs,
-	unsigned int src_cnt, unsigned int src_off, size_t len, u32 *result);
 
 /**
  * dma_async_memcpy_buf_to_buf - offloaded copy between virtual addresses
@@ -294,12 +313,16 @@ dma_cookie_t dma_async_xor_pgs_to_pg_err
 static inline dma_cookie_t dma_async_memcpy_buf_to_buf(struct dma_chan *chan,
 	void *dest, void *src, size_t len)
 {
+	unsigned long flags = DMA_DEST_BUF | DMA_SRC_BUF;
+	union dmaengine_addr dest_addr = { .buf = dest };
+	union dmaengine_addr src_addr = { .buf = src };
 	int cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
 	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_buf_to_buf(chan, dest, src, len);
+	return chan->device->device_do_dma_memcpy(chan, dest_addr, 0,
+						src_addr, 0, len, flags);
 }
 
 /**
@@ -318,13 +341,16 @@ static inline dma_cookie_t dma_async_mem
 static inline dma_cookie_t dma_async_memcpy_buf_to_pg(struct dma_chan *chan,
 	struct page *page, unsigned int offset, void *kdata, size_t len)
 {
+	unsigned long flags = DMA_DEST_PAGE | DMA_SRC_BUF;
+	union dmaengine_addr dest_addr = { .pg = page };
+	union dmaengine_addr src_addr = { .buf = kdata };
 	int cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
 	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_buf_to_pg(chan, page, offset,
-	                                             kdata, len);
+	return chan->device->device_do_dma_memcpy(chan, dest_addr, offset,
+						src_addr, 0, len, flags);
 }
 
 /**
@@ -345,13 +371,101 @@ static inline dma_cookie_t dma_async_mem
 	struct page *dest_pg, unsigned int dest_off, struct page *src_pg,
 	unsigned int src_off, size_t len)
 {
+	unsigned long flags = DMA_DEST_PAGE | DMA_SRC_PAGE;
+	union dmaengine_addr dest_addr = { .pg = dest_pg };
+	union dmaengine_addr src_addr = { .pg = src_pg };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_memcpy(chan, dest_addr, dest_off,
+						src_addr, src_off, len, flags);
+}
+
+/**
+ * dma_async_memcpy_dma_to_dma - offloaded copy from dma to dma
+ * @chan: DMA channel to offload copy to
+ * @dest: destination already mapped and consistent
+ * @src: source already mapped and consistent
+ * @len: length
+ *
+ * Both @dest_page/@dest_off and @src_page/@src_off must be mappable to a bus
+ * address according to the DMA mapping API rules for streaming mappings.
+ * Both @dest_page/@dest_off and @src_page/@src_off must stay memory resident
+ * (kernel memory or locked user space pages)
+ */
+static inline dma_cookie_t dma_async_memcpy_dma_to_dma(struct dma_chan *chan,
+	dma_addr_t dest, dma_addr_t src, size_t len)
+{
+	unsigned long flags = DMA_DEST_DMA | DMA_SRC_DMA;
+	union dmaengine_addr dest_addr = { .dma = dest };
+	union dmaengine_addr src_addr = { .dma = src };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_memcpy(chan, dest_addr, 0,
+						src_addr, 0, len, flags);
+}
+
+/**
+ * dma_async_memcpy_pg_to_dma - offloaded copy from page to dma
+ * @chan: DMA channel to offload copy to
+ * @dest: destination already mapped and consistent
+ * @src_pg: source page
+ * @src_off: offset in page to copy from
+ * @len: length
+ *
+ * Both @dest_page/@dest_off and @src_page/@src_off must be mappable to a bus
+ * address according to the DMA mapping API rules for streaming mappings.
+ * Both @dest_page/@dest_off and @src_page/@src_off must stay memory resident
+ * (kernel memory or locked user space pages)
+ */
+static inline dma_cookie_t dma_async_memcpy_pg_to_dma(struct dma_chan *chan,
+	dma_addr_t dest, struct page *src_pg,
+	unsigned int src_off, size_t len)
+{
+	unsigned long flags = DMA_DEST_DMA | DMA_SRC_PAGE;
+	union dmaengine_addr dest_addr = { .dma = dest };
+	union dmaengine_addr src_addr = { .pg = src_pg };
 	int cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
 	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_pg_to_pg(chan, dest_pg, dest_off,
-	                                            src_pg, src_off, len);
+	return chan->device->device_do_dma_memcpy(chan, dest_addr, 0,
+						src_addr, src_off, len, flags);
+}
+
+/**
+ * dma_async_memcpy_dma_to_pg - offloaded copy	from dma to page
+ * @chan: DMA channel to offload copy to
+ * @dest_page: destination page
+ * @dest_off: offset in page to copy to
+ * @src: source already mapped and consistent
+ * @len: length
+ *
+ * Both @dest_page/@dest_off and @src_page/@src_off must be mappable to a bus
+ * address according to the DMA mapping API rules for streaming mappings.
+ * Both @dest_page/@dest_off and @src_page/@src_off must stay memory resident
+ * (kernel memory or locked user space pages)
+ */
+static inline dma_cookie_t dma_async_memcpy_dma_to_pg(struct dma_chan *chan,
+	struct page *dest_pg, unsigned int dest_off, dma_addr_t src,
+	size_t len)
+{
+	unsigned long flags = DMA_DEST_PAGE | DMA_SRC_DMA;
+	union dmaengine_addr dest_addr = { .pg = dest_pg };
+	union dmaengine_addr src_addr = { .dma = src };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_memcpy(chan, dest_addr, dest_off,
+						src_addr, 0, len, flags);
 }
 
 /**
@@ -374,13 +488,42 @@ static inline dma_cookie_t dma_async_xor
 	struct page *dest_pg, unsigned int dest_off, struct page **src_pgs,
 	unsigned int src_cnt, unsigned int src_off, size_t len, u32 *result)
 {
+	unsigned long flags = DMA_DEST_PAGE | DMA_SRC_PAGES;
+	union dmaengine_addr dest_addr = { .pg = dest_pg };
+	union dmaengine_addr src_addr = { .pgs = src_pgs };
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_xor += len * src_cnt;
+	per_cpu_ptr(chan->local, cpu)->xor_count++;
+	put_cpu();
+
+	return chan->device->device_do_dma_xor(chan, dest_addr, dest_off,
+		src_addr, src_cnt, src_off, len, result, flags);
+}
+
+/**
+ * dma_async_xor_dma_list_to_dma - offloaded xor of dma blocks
+ * @chan: DMA channel to offload xor to
+ * @dest: destination already mapped and consistent
+ * @src_list: array of sources already mapped and consistent
+ * @src_cnt: number of sources
+ * @len: length
+ * @result: optionally returns whether the xor resulted
+ *	in a zero sum
+ */
+static inline dma_cookie_t dma_async_xor_dma_list_to_dma(struct dma_chan *chan,
+	dma_addr_t dest, dma_addr_t *src_list, unsigned int src_cnt,
+	size_t len, u32 *result)
+{
+	unsigned long flags = DMA_DEST_DMA | DMA_SRC_DMA_LIST;
+	union dmaengine_addr dest_addr = { .dma = dest };
+	union dmaengine_addr src_addr = { .dma_list = src_list };
 	int cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_xor += len * src_cnt;
 	per_cpu_ptr(chan->local, cpu)->xor_count++;
 	put_cpu();
 
-	return chan->device->device_xor_pgs_to_pg(chan, dest_pg, dest_off,
-		src_pgs, src_cnt, src_off, len, result);
+	return chan->device->device_do_dma_xor(chan, dest_addr, 0,
+		src_addr, src_cnt, 0, len, result, flags);
 }
 
 /**
