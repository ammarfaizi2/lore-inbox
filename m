Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161216AbWG1SQn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161216AbWG1SQn (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 28 Jul 2006 14:16:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161214AbWG1SQg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 28 Jul 2006 14:16:36 -0400
Received: from mga08.intel.com ([134.134.136.24]:51506 "EHLO
	orsmga102-1.jf.intel.com") by vger.kernel.org with ESMTP
	id S1161213AbWG1SQd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 28 Jul 2006 14:16:33 -0400
X-IronPort-AV: i="4.07,193,1151910000"; 
   d="scan'208"; a="97841334:sNHT66778194"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH rev2 3/4] dmaengine: expose per channel dma mapping characteristics to clients
Date: Fri, 28 Jul 2006 11:16:29 -0700
To: davem@davemloft.net, linux-kernel@vger.kernel.org
Cc: neilb@suse.de, galak@kernel.crashing.org, christopher.leech@intel.com,
       alan@lxorguk.ukuu.org.uk, dan.j.williams@intel.com
Message-Id: <20060728181629.5948.78653.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <20060728181618.5948.27138.stgit@dwillia2-linux.ch.intel.com>
References: <20060728181618.5948.27138.stgit@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

Allow a client to ensure that the dma channel it has selected can
dma to the specified buffer or page address.  Also allow the client to
pre-map address ranges to be passed to the operations API.

version 2: make the dmaengine api EXPORT_SYMBOL_GPL

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/dmaengine.c   |    4 ++++
 drivers/dma/ioatdma.c     |   35 +++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 73 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 2aaf21c..ff01e3a 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -631,3 +631,7 @@ EXPORT_SYMBOL_GPL(dma_async_device_unreg
 EXPORT_SYMBOL_GPL(dma_chan_cleanup);
 EXPORT_SYMBOL_GPL(dma_async_do_xor_err);
 EXPORT_SYMBOL_GPL(dma_async_chan_init);
+EXPORT_SYMBOL_GPL(dma_async_map_page);
+EXPORT_SYMBOL_GPL(dma_async_map_single);
+EXPORT_SYMBOL_GPL(dma_async_unmap_page);
+EXPORT_SYMBOL_GPL(dma_async_unmap_single);
diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index 511e8c1..c7bae96 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -638,6 +638,37 @@ extern dma_cookie_t dma_async_do_xor_err
 	unsigned int src_off, size_t len, u32 *result,
 	unsigned long flags);
 
+static dma_addr_t ioat_map_page(struct dma_chan *chan, struct page *page,
+					unsigned long offset, size_t size,
+					int direction)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	return pci_map_page(ioat_chan->device->pdev, page, offset, size,
+			direction);
+}
+
+static dma_addr_t ioat_map_single(struct dma_chan *chan, void *cpu_addr,
+					size_t size, int direction)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	return pci_map_single(ioat_chan->device->pdev, cpu_addr, size,
+			direction);
+}
+
+static void ioat_unmap_page(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	pci_unmap_page(ioat_chan->device->pdev, handle, size, direction);
+}
+
+static void ioat_unmap_single(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	pci_unmap_single(ioat_chan->device->pdev, handle, size,	direction);
+}
+
 static int __devinit ioat_probe(struct pci_dev *pdev,
                                 const struct pci_device_id *ent)
 {
@@ -718,6 +749,10 @@ #endif
 	device->common.capabilities = DMA_MEMCPY;
 	device->common.device_do_dma_memcpy = do_ioat_dma_memcpy;
 	device->common.device_do_dma_xor = dma_async_do_xor_err;
+	device->common.map_page = ioat_map_page;
+	device->common.map_single = ioat_map_single;
+	device->common.unmap_page = ioat_unmap_page;
+	device->common.unmap_single = ioat_unmap_single;
 	printk(KERN_INFO "Intel(R) I/OAT DMA Engine found, %d channels\n",
 		device->common.chancnt);
 
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index d325919..33699be 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -287,6 +287,15 @@ struct dma_device {
 	enum dma_status (*device_operation_complete)(struct dma_chan *chan,
 			dma_cookie_t cookie, dma_cookie_t *last,
 			dma_cookie_t *used);
+	dma_addr_t (*map_page)(struct dma_chan *chan, struct page *page,
+				unsigned long offset, size_t size,
+				int direction);
+	dma_addr_t (*map_single)(struct dma_chan *chan, void *cpu_addr,
+				size_t size, int direction);
+	void (*unmap_page)(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction);
+	void (*unmap_single)(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction);
 	void (*device_issue_pending)(struct dma_chan *chan);
 };
 
@@ -595,6 +604,31 @@ static inline enum dma_status dma_async_
 	return DMA_IN_PROGRESS;
 }
 
+static inline dma_addr_t dma_async_map_page(struct dma_chan *chan,
+			struct page *page, unsigned long offset, size_t size,
+			int direction)
+{
+	return chan->device->map_page(chan, page, offset, size, direction);
+}
+
+static inline dma_addr_t dma_async_map_single(struct dma_chan *chan,
+			void *cpu_addr,	size_t size, int direction)
+{
+	return chan->device->map_single(chan, cpu_addr, size, direction);
+}
+
+static inline void dma_async_unmap_page(struct dma_chan *chan,
+			dma_addr_t handle, size_t size, int direction)
+{
+	chan->device->unmap_page(chan, handle, size, direction);
+}
+
+static inline void dma_async_unmap_single(struct dma_chan *chan,
+			dma_addr_t handle, size_t size, int direction)
+{
+	chan->device->unmap_single(chan, handle, size, direction);
+}
+
 /* --- DMA device --- */
 
 int dma_async_device_register(struct dma_device *device);
