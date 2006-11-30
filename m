Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031320AbWK3UKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031320AbWK3UKZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031318AbWK3UKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:10:25 -0500
Received: from mga09.intel.com ([134.134.136.24]:28681 "EHLO mga09.intel.com")
	by vger.kernel.org with ESMTP id S1031313AbWK3UKR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:10:17 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="21623416:sNHT42914313"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 01/12] dmaengine: add base support for the async_tx api
Date: Thu, 30 Nov 2006 13:10:05 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201005.21313.81153.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

* introduce struct dma_async_tx_descriptor as a common field for all dmaengine
software descriptors
* convert the device_memcpy_* methods into separate prep, set src/dest, and
submit stages
* support capabilities beyond memcpy (xor, memset, xor zero sum, completion
interrupts)
* convert ioatdma to the new semantics

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/dmaengine.c   |   44 ++++++--
 drivers/dma/ioatdma.c     |  256 ++++++++++++++++++++++----------------------
 drivers/dma/ioatdma.h     |    8 +
 include/linux/dmaengine.h |  263 ++++++++++++++++++++++++++++++++++++++-------
 4 files changed, 394 insertions(+), 177 deletions(-)

diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
index 1527804..8d203ad 100644
--- a/drivers/dma/dmaengine.c
+++ b/drivers/dma/dmaengine.c
@@ -210,7 +210,8 @@ static void dma_chans_rebalance(void)
 	mutex_lock(&dma_list_mutex);
 
 	list_for_each_entry(client, &dma_client_list, global_node) {
-		while (client->chans_desired > client->chan_count) {
+		while (client->chans_desired < 0 ||
+			client->chans_desired > client->chan_count) {
 			chan = dma_client_chan_alloc(client);
 			if (!chan)
 				break;
@@ -219,7 +220,8 @@ static void dma_chans_rebalance(void)
 	                                       chan,
 	                                       DMA_RESOURCE_ADDED);
 		}
-		while (client->chans_desired < client->chan_count) {
+		while (client->chans_desired >= 0 &&
+			client->chans_desired < client->chan_count) {
 			spin_lock_irqsave(&client->lock, flags);
 			chan = list_entry(client->channels.next,
 			                  struct dma_chan,
@@ -294,12 +296,12 @@ void dma_async_client_unregister(struct 
  * @number: count of DMA channels requested
  *
  * Clients call dma_async_client_chan_request() to specify how many
- * DMA channels they need, 0 to free all currently allocated.
+ * DMA channels they need, 0 to free all currently allocated. A request
+ * < 0 indicates the client wants to handle all engines in the system.
  * The resulting allocations/frees are indicated to the client via the
  * event callback.
  */
-void dma_async_client_chan_request(struct dma_client *client,
-			unsigned int number)
+void dma_async_client_chan_request(struct dma_client *client, int number)
 {
 	client->chans_desired = number;
 	dma_chans_rebalance();
@@ -318,6 +320,31 @@ int dma_async_device_register(struct dma
 	if (!device)
 		return -ENODEV;
 
+	/* validate device routines */
+	BUG_ON(test_bit(DMA_MEMCPY, &device->capabilities) &&
+		!device->device_prep_dma_memcpy);
+	BUG_ON(test_bit(DMA_XOR, &device->capabilities) &&
+		!device->device_prep_dma_xor);
+	BUG_ON(test_bit(DMA_ZERO_SUM, &device->capabilities) &&
+		!device->device_prep_dma_zero_sum);
+	BUG_ON(test_bit(DMA_MEMSET, &device->capabilities) &&
+		!device->device_prep_dma_memset);
+	BUG_ON(test_bit(DMA_ZERO_SUM, &device->capabilities) &&
+		!device->device_prep_dma_interrupt);
+
+	BUG_ON(!device->device_alloc_chan_resources);
+	BUG_ON(!device->device_free_chan_resources);
+	BUG_ON(!device->device_tx_submit);
+	BUG_ON(!device->device_set_dest);
+	BUG_ON(!device->device_set_src);
+	BUG_ON(!device->device_dependency_added);
+	BUG_ON(!device->device_is_tx_complete);
+	BUG_ON(!device->map_page);
+	BUG_ON(!device->map_single);
+	BUG_ON(!device->unmap_page);
+	BUG_ON(!device->unmap_single);
+	BUG_ON(!device->device_issue_pending);
+
 	init_completion(&device->done);
 	kref_init(&device->refcount);
 	device->dev_id = id++;
@@ -402,11 +429,8 @@ subsys_initcall(dma_bus_init);
 EXPORT_SYMBOL(dma_async_client_register);
 EXPORT_SYMBOL(dma_async_client_unregister);
 EXPORT_SYMBOL(dma_async_client_chan_request);
-EXPORT_SYMBOL(dma_async_memcpy_buf_to_buf);
-EXPORT_SYMBOL(dma_async_memcpy_buf_to_pg);
-EXPORT_SYMBOL(dma_async_memcpy_pg_to_pg);
-EXPORT_SYMBOL(dma_async_memcpy_complete);
-EXPORT_SYMBOL(dma_async_memcpy_issue_pending);
+EXPORT_SYMBOL(dma_async_is_tx_complete);
+EXPORT_SYMBOL(dma_async_issue_pending);
 EXPORT_SYMBOL(dma_async_device_register);
 EXPORT_SYMBOL(dma_async_device_unregister);
 EXPORT_SYMBOL(dma_chan_cleanup);
diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
index 0358419..ff7377d 100644
--- a/drivers/dma/ioatdma.c
+++ b/drivers/dma/ioatdma.c
@@ -31,6 +31,7 @@ #include <linux/interrupt.h>
 #include <linux/dmaengine.h>
 #include <linux/delay.h>
 #include <linux/dma-mapping.h>
+#include <linux/async_tx.h>
 #include "ioatdma.h"
 #include "ioatdma_io.h"
 #include "ioatdma_registers.h"
@@ -39,6 +40,7 @@ #include "ioatdma_hw.h"
 #define to_ioat_chan(chan) container_of(chan, struct ioat_dma_chan, common)
 #define to_ioat_device(dev) container_of(dev, struct ioat_device, common)
 #define to_ioat_desc(lh) container_of(lh, struct ioat_desc_sw, node)
+#define tx_to_ioat_desc(tx) container_of(tx, struct ioat_desc_sw, async_tx)
 
 /* internal functions */
 static int __devinit ioat_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
@@ -99,6 +101,8 @@ static struct ioat_desc_sw *ioat_dma_all
 	}
 
 	memset(desc, 0, sizeof(*desc));
+	dma_async_tx_descriptor_init(&desc_sw->async_tx, &ioat_chan->common);
+	INIT_LIST_HEAD(&desc_sw->group_list);
 	desc_sw->hw = desc;
 	desc_sw->phys = phys;
 
@@ -215,45 +219,25 @@ static void ioat_dma_free_chan_resources
 	ioatdma_chan_write16(ioat_chan, IOAT_CHANCTRL_OFFSET, chanctrl);
 }
 
-/**
- * do_ioat_dma_memcpy - actual function that initiates a IOAT DMA transaction
- * @ioat_chan: IOAT DMA channel handle
- * @dest: DMA destination address
- * @src: DMA source address
- * @len: transaction length in bytes
- */
-
-static dma_cookie_t do_ioat_dma_memcpy(struct ioat_dma_chan *ioat_chan,
-                                       dma_addr_t dest,
-                                       dma_addr_t src,
-                                       size_t len)
+static struct dma_async_tx_descriptor *
+ioat_dma_prep_memcpy(struct dma_chan *chan, size_t len, int int_en)
 {
-	struct ioat_desc_sw *first;
-	struct ioat_desc_sw *prev;
-	struct ioat_desc_sw *new;
-	dma_cookie_t cookie;
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	struct ioat_desc_sw *first, *prev, *new;
 	LIST_HEAD(new_chain);
 	u32 copy;
 	size_t orig_len;
-	dma_addr_t orig_src, orig_dst;
-	unsigned int desc_count = 0;
-	unsigned int append = 0;
-
-	if (!ioat_chan || !dest || !src)
-		return -EFAULT;
+	int desc_count = 0;
 
 	if (!len)
-		return ioat_chan->common.cookie;
+		return NULL;
 
 	orig_len = len;
-	orig_src = src;
-	orig_dst = dest;
 
 	first = NULL;
 	prev = NULL;
 
 	spin_lock_bh(&ioat_chan->desc_lock);
-
 	while (len) {
 		if (!list_empty(&ioat_chan->free_desc)) {
 			new = to_ioat_desc(ioat_chan->free_desc.next);
@@ -270,9 +254,8 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 
 		new->hw->size = copy;
 		new->hw->ctl = 0;
-		new->hw->src_addr = src;
-		new->hw->dst_addr = dest;
-		new->cookie = 0;
+		new->async_tx.cookie = 0;
+		new->async_tx.ack = 1;
 
 		/* chain together the physical address list for the HW */
 		if (!first)
@@ -281,40 +264,83 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 			prev->hw->next = (u64) new->phys;
 
 		prev = new;
-
 		len  -= copy;
-		dest += copy;
-		src  += copy;
-
 		list_add_tail(&new->node, &new_chain);
 		desc_count++;
 	}
+
+	list_splice(&new_chain, &new->group_list);
+
 	new->hw->ctl = IOAT_DMA_DESCRIPTOR_CTL_CP_STS;
 	new->hw->next = 0;
+	new->group_count = desc_count;
+	new->async_tx.ack = 0; /* client is in control of this ack */
+	new->async_tx.cookie = -EBUSY;
+	new->async_tx.type = DMA_MEMCPY;
 
-	/* cookie incr and addition to used_list must be atomic */
+	pci_unmap_len_set(new, src_len, orig_len);
+	pci_unmap_len_set(new, dst_len, orig_len);
+	spin_unlock_bh(&ioat_chan->desc_lock);
+
+	return new ? &new->async_tx : NULL;
+}
+
+static void
+ioat_set_src(dma_addr_t addr, struct dma_async_tx_descriptor *tx, int index)
+{
+	struct ioat_desc_sw *iter, *desc = tx_to_ioat_desc(tx);
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(tx->chan);
+
+	pci_unmap_addr_set(desc, src, addr);
+
+	list_for_each_entry(iter, &desc->group_list, node) {
+		iter->hw->src_addr = addr;
+		addr += ioat_chan->xfercap;
+	}
+
+}
+
+static void
+ioat_set_dest(dma_addr_t addr, struct dma_async_tx_descriptor *tx, int index)
+{
+	struct ioat_desc_sw *iter, *desc = tx_to_ioat_desc(tx);
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(tx->chan);
+
+	pci_unmap_addr_set(desc, dst, addr);
+
+	list_for_each_entry(iter, &desc->group_list, node) {
+		iter->hw->dst_addr = addr;
+		addr += ioat_chan->xfercap;
+	}
+}
+
+static dma_cookie_t
+ioat_tx_submit(struct dma_async_tx_descriptor *tx)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(tx->chan);
+	struct ioat_desc_sw *desc = tx_to_ioat_desc(tx);
+	struct ioat_desc_sw *group_start = list_entry(desc->group_list.next,
+		struct ioat_desc_sw, node);
+	int append = 0;
+	dma_cookie_t cookie;
 
+	spin_lock_bh(&ioat_chan->desc_lock);
+	/* cookie incr and addition to used_list must be atomic */
 	cookie = ioat_chan->common.cookie;
 	cookie++;
 	if (cookie < 0)
 		cookie = 1;
-	ioat_chan->common.cookie = new->cookie = cookie;
-
-	pci_unmap_addr_set(new, src, orig_src);
-	pci_unmap_addr_set(new, dst, orig_dst);
-	pci_unmap_len_set(new, src_len, orig_len);
-	pci_unmap_len_set(new, dst_len, orig_len);
+	ioat_chan->common.cookie = desc->async_tx.cookie = cookie;
 
 	/* write address into NextDescriptor field of last desc in chain */
-	to_ioat_desc(ioat_chan->used_desc.prev)->hw->next = first->phys;
-	list_splice_init(&new_chain, ioat_chan->used_desc.prev);
+	to_ioat_desc(ioat_chan->used_desc.prev)->hw->next = group_start->phys;
+	list_splice_init(&desc->group_list, ioat_chan->used_desc.prev);
 
-	ioat_chan->pending += desc_count;
+	ioat_chan->pending += desc->group_count;
 	if (ioat_chan->pending >= 20) {
 		append = 1;
 		ioat_chan->pending = 0;
 	}
-
 	spin_unlock_bh(&ioat_chan->desc_lock);
 
 	if (append)
@@ -324,86 +350,35 @@ static dma_cookie_t do_ioat_dma_memcpy(s
 	return cookie;
 }
 
-/**
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
+static dma_addr_t ioat_map_page(struct dma_chan *chan, struct page *page,
+					unsigned long offset, size_t size,
+					int direction)
 {
-	dma_addr_t dest_addr;
-	dma_addr_t src_addr;
 	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
-
-	dest_addr = pci_map_single(ioat_chan->device->pdev,
-		dest, len, PCI_DMA_FROMDEVICE);
-	src_addr = pci_map_single(ioat_chan->device->pdev,
-		src, len, PCI_DMA_TODEVICE);
-
-	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
+	return pci_map_page(ioat_chan->device->pdev, page, offset, size,
+			direction);
 }
 
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
+static dma_addr_t ioat_map_single(struct dma_chan *chan, void *cpu_addr,
+					size_t size, int direction)
 {
-	dma_addr_t dest_addr;
-	dma_addr_t src_addr;
 	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
-
-	dest_addr = pci_map_page(ioat_chan->device->pdev,
-		page, offset, len, PCI_DMA_FROMDEVICE);
-	src_addr = pci_map_single(ioat_chan->device->pdev,
-		src, len, PCI_DMA_TODEVICE);
-
-	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
+	return pci_map_single(ioat_chan->device->pdev, cpu_addr, size,
+			direction);
 }
 
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
+static void ioat_unmap_page(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction)
 {
-	dma_addr_t dest_addr;
-	dma_addr_t src_addr;
 	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	pci_unmap_page(ioat_chan->device->pdev, handle, size, direction);
+}
 
-	dest_addr = pci_map_page(ioat_chan->device->pdev,
-		dest_pg, dest_off, len, PCI_DMA_FROMDEVICE);
-	src_addr = pci_map_page(ioat_chan->device->pdev,
-		src_pg, src_off, len, PCI_DMA_TODEVICE);
-
-	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
+static void ioat_unmap_single(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	pci_unmap_single(ioat_chan->device->pdev, handle, size, direction);
 }
 
 /**
@@ -467,8 +442,8 @@ #endif
 		 * exceeding xfercap, perhaps. If so, only the last one will
 		 * have a cookie, and require unmapping.
 		 */
-		if (desc->cookie) {
-			cookie = desc->cookie;
+		if (desc->async_tx.cookie) {
+			cookie = desc->async_tx.cookie;
 
 			/* yes we are unmapping both _page and _single alloc'd
 			   regions with unmap_page. Is this *really* that bad?
@@ -484,13 +459,18 @@ #endif
 		}
 
 		if (desc->phys != phys_complete) {
-			/* a completed entry, but not the last, so cleanup */
-			list_del(&desc->node);
-			list_add_tail(&desc->node, &chan->free_desc);
+			/* a completed entry, but not the last, so cleanup
+			 * if the client is done with the descriptor
+			 */
+			if (desc->async_tx.ack) {
+				list_del(&desc->node);
+				list_add_tail(&desc->node, &chan->free_desc);
+			} else
+				desc->async_tx.cookie = 0;
 		} else {
 			/* last used desc. Do not remove, so we can append from
 			   it, but don't look at it next time, either */
-			desc->cookie = 0;
+			desc->async_tx.cookie = 0;
 
 			/* TODO check status bits? */
 			break;
@@ -506,6 +486,17 @@ #endif
 	spin_unlock(&chan->cleanup_lock);
 }
 
+static void ioat_dma_dependency_added(struct dma_chan *chan)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	spin_lock_bh(&ioat_chan->desc_lock);
+	if (ioat_chan->pending == 0) {
+		spin_unlock_bh(&ioat_chan->desc_lock);
+		ioat_dma_memcpy_cleanup(chan);
+	} else
+		spin_unlock_bh(&ioat_chan->desc_lock);
+}
+
 /**
  * ioat_dma_is_complete - poll the status of a IOAT DMA transaction
  * @chan: IOAT DMA channel handle
@@ -607,6 +598,7 @@ static void ioat_start_null_desc(struct 
 
 	desc->hw->ctl = IOAT_DMA_DESCRIPTOR_NUL;
 	desc->hw->next = 0;
+	desc->async_tx.ack = 1;
 
 	list_add_tail(&desc->node, &ioat_chan->used_desc);
 	spin_unlock_bh(&ioat_chan->desc_lock);
@@ -633,6 +625,8 @@ static int ioat_self_test(struct ioat_de
 	u8 *src;
 	u8 *dest;
 	struct dma_chan *dma_chan;
+	struct dma_async_tx_descriptor *tx;
+	dma_addr_t addr;
 	dma_cookie_t cookie;
 	int err = 0;
 
@@ -658,7 +652,13 @@ static int ioat_self_test(struct ioat_de
 		goto out;
 	}
 
-	cookie = ioat_dma_memcpy_buf_to_buf(dma_chan, dest, src, IOAT_TEST_SIZE);
+	tx = ioat_dma_prep_memcpy(dma_chan, IOAT_TEST_SIZE, 0);
+	async_tx_ack(tx);
+	addr = ioat_map_single(dma_chan, src, IOAT_TEST_SIZE, PCI_DMA_TODEVICE);
+	ioat_set_src(addr, tx, 0);
+	addr = ioat_map_single(dma_chan, dest, IOAT_TEST_SIZE, PCI_DMA_FROMDEVICE);
+	ioat_set_dest(addr, tx, 0);
+	cookie = ioat_tx_submit(tx);
 	ioat_dma_memcpy_issue_pending(dma_chan);
 	msleep(1);
 
@@ -754,13 +754,19 @@ #endif
 	INIT_LIST_HEAD(&device->common.channels);
 	enumerate_dma_channels(device);
 
+	set_bit(DMA_MEMCPY, &device->common.capabilities);
 	device->common.device_alloc_chan_resources = ioat_dma_alloc_chan_resources;
 	device->common.device_free_chan_resources = ioat_dma_free_chan_resources;
-	device->common.device_memcpy_buf_to_buf = ioat_dma_memcpy_buf_to_buf;
-	device->common.device_memcpy_buf_to_pg = ioat_dma_memcpy_buf_to_pg;
-	device->common.device_memcpy_pg_to_pg = ioat_dma_memcpy_pg_to_pg;
-	device->common.device_memcpy_complete = ioat_dma_is_complete;
-	device->common.device_memcpy_issue_pending = ioat_dma_memcpy_issue_pending;
+	device->common.device_prep_dma_memcpy = ioat_dma_prep_memcpy;
+	device->common.device_set_src = ioat_set_src;
+	device->common.device_set_dest = ioat_set_dest;
+	device->common.map_page = ioat_map_page;
+	device->common.map_single = ioat_map_single;
+	device->common.unmap_page = ioat_unmap_page;
+	device->common.unmap_single = ioat_unmap_single;
+	device->common.device_is_tx_complete = ioat_dma_is_complete;
+	device->common.device_issue_pending = ioat_dma_memcpy_issue_pending;
+	device->common.device_dependency_added = ioat_dma_dependency_added;
 	printk(KERN_INFO "Intel(R) I/OAT DMA Engine found, %d channels\n",
 		device->common.chancnt);
 
diff --git a/drivers/dma/ioatdma.h b/drivers/dma/ioatdma.h
index 62b26a9..fed259a 100644
--- a/drivers/dma/ioatdma.h
+++ b/drivers/dma/ioatdma.h
@@ -105,15 +105,20 @@ struct ioat_dma_chan {
 /**
  * struct ioat_desc_sw - wrapper around hardware descriptor
  * @hw: hardware DMA descriptor
+ * @async_tx:
  * @node:
+ * @group_list:
+ * @group_cnt:
  * @cookie:
  * @phys:
  */
 
 struct ioat_desc_sw {
 	struct ioat_dma_descriptor *hw;
+	struct dma_async_tx_descriptor async_tx;
 	struct list_head node;
-	dma_cookie_t cookie;
+	struct list_head group_list;
+	int group_count;
 	dma_addr_t phys;
 	DECLARE_PCI_UNMAP_ADDR(src)
 	DECLARE_PCI_UNMAP_LEN(src_len)
@@ -122,4 +127,3 @@ struct ioat_desc_sw {
 };
 
 #endif /* IOATDMA_H */
-
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index c94d8f1..541da4b 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -21,13 +21,12 @@
 #ifndef DMAENGINE_H
 #define DMAENGINE_H
 
-#ifdef CONFIG_DMA_ENGINE
-
 #include <linux/device.h>
 #include <linux/uio.h>
 #include <linux/kref.h>
 #include <linux/completion.h>
 #include <linux/rcupdate.h>
+#include <linux/dma-mapping.h>
 
 /**
  * enum dma_event - resource PNP/power managment events
@@ -65,6 +64,47 @@ enum dma_status {
 };
 
 /**
+ * enum dma_transaction_type - DMA transaction types/indexes
+ */
+enum dma_transaction_type {
+	DMA_MEMCPY,
+	DMA_XOR,
+	DMA_PQ_XOR,
+	DMA_DUAL_XOR,
+	DMA_PQ_UPDATE,
+	DMA_ZERO_SUM,
+	DMA_PQ_ZERO_SUM,
+	DMA_MEMSET,
+	DMA_MEMCPY_CRC32C,
+	DMA_INTERRUPT,
+};
+
+#define DMA_TX_TYPE_START (DMA_MEMCPY)
+#define DMA_TX_TYPE_END (DMA_INTERRUPT)
+#define dma_async_for_each_tx_type(index) for (\
+	 index = (unsigned long) DMA_TX_TYPE_START;\
+	 index <= (unsigned long) DMA_TX_TYPE_END;\
+	 index++)
+
+#define DMA_CHAN_REQUEST_ALL (-1)
+
+/**
+ * enum dma_capability - DMA transfer/transform capabilities
+ */
+enum dma_capability {
+	DMA_CAP_MEMCPY	      = (1 << DMA_MEMCPY),
+	DMA_CAP_XOR	      = (1 << DMA_XOR),
+	DMA_CAP_PQ_XOR	      = (1 << DMA_PQ_XOR),
+	DMA_CAP_DUAL_XOR      = (1 << DMA_DUAL_XOR),
+	DMA_CAP_PQ_UPDATE     = (1 << DMA_PQ_UPDATE),
+	DMA_CAP_ZERO_SUM      = (1 << DMA_ZERO_SUM),
+	DMA_CAP_PQ_ZERO_SUM   = (1 << DMA_PQ_ZERO_SUM),
+	DMA_CAP_MEMSET	      = (1 << DMA_MEMSET),
+	DMA_CAP_MEMCPY_CRC32C = (1 << DMA_MEMCPY_CRC32C),
+	DMA_CAP_INTERRUPT     = (1 << DMA_INTERRUPT),
+};
+
+/**
  * struct dma_chan_percpu - the per-CPU part of struct dma_chan
  * @refcount: local_t used for open-coded "bigref" counting
  * @memcpy_count: transaction counter
@@ -149,36 +189,79 @@ typedef void (*dma_event_callback) (stru
  */
 struct dma_client {
 	dma_event_callback	event_callback;
-	unsigned int		chan_count;
-	unsigned int		chans_desired;
+	int			chan_count;
+	int			chans_desired;
 
 	spinlock_t		lock;
 	struct list_head	channels;
 	struct list_head	global_node;
 };
 
+typedef void (*dma_async_tx_callback)(void *dma_async_param);
+/**
+ * struct dma_async_tx_descriptor - async transaction descriptor
+ * @ack: the descriptor can not be reused until the client acknowledges
+ *	receipt, i.e. has has a chance to establish any dependency chains
+ * @cookie: tracking cookie for this transaction, set to -EBUSY if
+ *	this tx is sitting on a dependency list
+ * @callback: routine to call after this operation is complete
+ * @callback_param: general parameter to pass to the callback routine
+ * @chan: target channel for this operation
+ * @depend_node: allow this transaction to be executed after another
+ *	transaction has completed
+ * @depend_list: at completion this list of transactions are submitted
+ * @parent: pointer to the next level up in the dependency chain
+ * @lock: protect the dependency list
+ * @type: allows backend implementations to key off the tx_type
+ */
+struct dma_async_tx_descriptor {
+	int ack;
+	dma_cookie_t cookie;
+	dma_async_tx_callback callback;
+	void *callback_param;
+	struct dma_chan *chan;
+	struct list_head depend_node;
+	struct list_head depend_list;
+	struct dma_async_tx_descriptor *parent;
+	spinlock_t lock;
+	enum dma_transaction_type type;
+};
+
 /**
  * struct dma_device - info on the entity supplying DMA services
  * @chancnt: how many DMA channels are supported
  * @channels: the list of struct dma_chan
  * @global_node: list_head for global dma_device_list
+ * @capabilities: one or more dma_capability flags
+ * @max_xor: maximum number of xor sources, 0 if no capability
  * @refcount: reference count
  * @done: IO completion struct
  * @dev_id: unique device ID
  * @device_alloc_chan_resources: allocate resources and return the
  *	number of allocated descriptors
  * @device_free_chan_resources: release DMA channel's resources
- * @device_memcpy_buf_to_buf: memcpy buf pointer to buf pointer
- * @device_memcpy_buf_to_pg: memcpy buf pointer to struct page
- * @device_memcpy_pg_to_pg: memcpy struct page/offset to struct page/offset
- * @device_memcpy_complete: poll the status of an IOAT DMA transaction
- * @device_memcpy_issue_pending: push appended descriptors to hardware
+ * @device_prep_dma_memcpy: prepares a memcpy operation
+ * @device_prep_dma_xor: prepares a xor operation
+ * @device_prep_dma_zero_sum: prepares a zero_sum operation
+ * @device_prep_dma_memset: prepares a memset operation
+ * @device_prep_dma_interrupt: prepares an end of chain interrupt operation
+ * @device_tx_submit: execute an operation
+ * @device_set_dest: set a destination address in a hardware descriptor
+ * @device_set_src: set a source address in a hardware descriptor
+ * @device_dependency_added: async_tx notifies the channel about new deps
+ * @map_page: get a dma address that this device can use
+ * @map_single: get a dma address that this device can use
+ * @unmap_page: undo a dma mapping
+ * @unmap_single: undo a dma mapping
+ * @device_issue_pending: push pending transactions to hardware
  */
 struct dma_device {
 
 	unsigned int chancnt;
 	struct list_head channels;
 	struct list_head global_node;
+	unsigned long capabilities;
+	unsigned int max_xor;
 
 	struct kref refcount;
 	struct completion done;
@@ -187,26 +270,46 @@ struct dma_device {
 
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
-	enum dma_status (*device_memcpy_complete)(struct dma_chan *chan,
+
+	struct dma_async_tx_descriptor *(*device_prep_dma_memcpy)(
+		struct dma_chan *chan, size_t len, int int_en);
+	struct dma_async_tx_descriptor *(*device_prep_dma_xor)(
+		struct dma_chan *chan, unsigned int src_cnt, size_t len,
+		int int_en);
+	struct dma_async_tx_descriptor *(*device_prep_dma_zero_sum)(
+		struct dma_chan *chan, unsigned int src_cnt, size_t len,
+		u32 *result, int int_en);
+	struct dma_async_tx_descriptor *(*device_prep_dma_memset)(
+		struct dma_chan *chan, int value, size_t len, int int_en);
+	struct dma_async_tx_descriptor *(*device_prep_dma_interrupt)(
+		struct dma_chan *chan);
+
+	dma_cookie_t (*device_tx_submit)(struct dma_async_tx_descriptor *tx);
+	void (*device_set_dest)(dma_addr_t addr,
+		struct dma_async_tx_descriptor *tx, int index);
+	void (*device_set_src)(dma_addr_t addr,
+		struct dma_async_tx_descriptor *tx, int index);
+	void (*device_dependency_added)(struct dma_chan *chan);
+	enum dma_status (*device_is_tx_complete)(struct dma_chan *chan,
 			dma_cookie_t cookie, dma_cookie_t *last,
 			dma_cookie_t *used);
-	void (*device_memcpy_issue_pending)(struct dma_chan *chan);
+	dma_addr_t (*map_page)(struct dma_chan *chan, struct page *page,
+				unsigned long offset, size_t size,
+				int direction);
+	dma_addr_t (*map_single)(struct dma_chan *chan, void *cpu_addr,
+				size_t size, int direction);
+	void (*unmap_page)(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction);
+	void (*unmap_single)(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction);
+	void (*device_issue_pending)(struct dma_chan *chan);
 };
 
 /* --- public DMA engine API --- */
 
 struct dma_client *dma_async_client_register(dma_event_callback event_callback);
 void dma_async_client_unregister(struct dma_client *client);
-void dma_async_client_chan_request(struct dma_client *client,
-		unsigned int number);
+void dma_async_client_chan_request(struct dma_client *client, int number);
 
 /**
  * dma_async_memcpy_buf_to_buf - offloaded copy between virtual addresses
@@ -221,14 +324,31 @@ void dma_async_client_chan_request(struc
  * user space pages).
  */
 static inline dma_cookie_t dma_async_memcpy_buf_to_buf(struct dma_chan *chan,
-	void *dest, void *src, size_t len)
+        void *dest, void *src, size_t len)
 {
-	int cpu = get_cpu();
+	struct dma_device *dev = chan->device;
+	struct dma_async_tx_descriptor *tx;
+	dma_addr_t addr;
+	dma_cookie_t cookie;
+	int cpu;
+
+	tx = dev->device_prep_dma_memcpy(chan, len, 0);
+	if (!tx)
+		return -ENOMEM;
+
+	tx->ack = 1;
+	addr = dev->map_single(chan, src, len, DMA_TO_DEVICE);
+	dev->device_set_src(addr, tx, 0);
+	addr = dev->map_single(chan, dest, len, DMA_FROM_DEVICE);
+	dev->device_set_dest(addr, tx, 0);
+	cookie = dev->device_tx_submit(tx);
+
+	cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
 	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_buf_to_buf(chan, dest, src, len);
+	return cookie;
 }
 
 /**
@@ -245,15 +365,31 @@ static inline dma_cookie_t dma_async_mem
  * locked user space pages)
  */
 static inline dma_cookie_t dma_async_memcpy_buf_to_pg(struct dma_chan *chan,
-	struct page *page, unsigned int offset, void *kdata, size_t len)
+        struct page *page, unsigned int offset, void *kdata, size_t len)
 {
-	int cpu = get_cpu();
+	struct dma_device *dev = chan->device;
+	struct dma_async_tx_descriptor *tx;
+	dma_addr_t addr;
+	dma_cookie_t cookie;
+	int cpu;
+
+	tx = dev->device_prep_dma_memcpy(chan, len, 0);
+	if (!tx)
+		return -ENOMEM;
+
+	tx->ack = 1;
+	addr = dev->map_single(chan, kdata, len, DMA_TO_DEVICE);
+	dev->device_set_src(addr, tx, 0);
+	addr = dev->map_page(chan, page, offset, len, DMA_FROM_DEVICE);
+	dev->device_set_dest(addr, tx, 0);
+	cookie = dev->device_tx_submit(tx);
+
+	cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
 	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_buf_to_pg(chan, page, offset,
-	                                             kdata, len);
+	return cookie;
 }
 
 /**
@@ -271,32 +407,60 @@ static inline dma_cookie_t dma_async_mem
  * (kernel memory or locked user space pages).
  */
 static inline dma_cookie_t dma_async_memcpy_pg_to_pg(struct dma_chan *chan,
-	struct page *dest_pg, unsigned int dest_off, struct page *src_pg,
-	unsigned int src_off, size_t len)
+        struct page *dest_pg, unsigned int dest_off, struct page *src_pg,
+        unsigned int src_off, size_t len)
 {
-	int cpu = get_cpu();
+	struct dma_device *dev = chan->device;
+	struct dma_async_tx_descriptor *tx;
+	dma_addr_t addr;
+	dma_cookie_t cookie;
+	int cpu;
+
+	tx = dev->device_prep_dma_memcpy(chan, len, 0);
+	if (!tx)
+		return -ENOMEM;
+
+	tx->ack = 1;
+	addr = dev->map_page(chan, src_pg, src_off, len, DMA_TO_DEVICE);
+	dev->device_set_src(addr, tx, 0);
+	addr = dev->map_page(chan, dest_pg, dest_off, len, DMA_FROM_DEVICE);
+	dev->device_set_dest(addr, tx, 0);
+	cookie = dev->device_tx_submit(tx);
+
+	cpu = get_cpu();
 	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
 	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
 	put_cpu();
 
-	return chan->device->device_memcpy_pg_to_pg(chan, dest_pg, dest_off,
-	                                            src_pg, src_off, len);
+	return cookie;
+}
+
+static inline void
+dma_async_tx_descriptor_init(struct dma_async_tx_descriptor *tx,
+	struct dma_chan *chan)
+{
+	tx->chan = chan;
+	spin_lock_init(&tx->lock);
+	INIT_LIST_HEAD(&tx->depend_node);
+	INIT_LIST_HEAD(&tx->depend_list);
 }
 
 /**
- * dma_async_memcpy_issue_pending - flush pending copies to HW
+ * dma_async_issue_pending - flush pending transactions to HW
  * @chan: target DMA channel
  *
  * This allows drivers to push copies to HW in batches,
  * reducing MMIO writes where possible.
  */
-static inline void dma_async_memcpy_issue_pending(struct dma_chan *chan)
+static inline void dma_async_issue_pending(struct dma_chan *chan)
 {
-	return chan->device->device_memcpy_issue_pending(chan);
+	return chan->device->device_issue_pending(chan);
 }
 
+#define dma_async_memcpy_issue_pending(chan) dma_async_issue_pending(chan)
+
 /**
- * dma_async_memcpy_complete - poll for transaction completion
+ * dma_async_is_tx_complete - poll for transaction completion
  * @chan: DMA channel
  * @cookie: transaction identifier to check status of
  * @last: returns last completed cookie, can be NULL
@@ -306,12 +470,15 @@ static inline void dma_async_memcpy_issu
  * internal state and can be used with dma_async_is_complete() to check
  * the status of multiple cookies without re-checking hardware state.
  */
-static inline enum dma_status dma_async_memcpy_complete(struct dma_chan *chan,
+static inline enum dma_status dma_async_is_tx_complete(struct dma_chan *chan,
 	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
 {
-	return chan->device->device_memcpy_complete(chan, cookie, last, used);
+	return chan->device->device_is_tx_complete(chan, cookie, last, used);
 }
 
+#define dma_async_memcpy_complete(chan, cookie, last, used)\
+	dma_async_is_tx_complete(chan, cookie, last, used)
+
 /**
  * dma_async_is_complete - test a cookie against chan state
  * @cookie: transaction identifier to test status of
@@ -334,6 +501,23 @@ static inline enum dma_status dma_async_
 	return DMA_IN_PROGRESS;
 }
 
+static inline enum dma_status dma_sync_wait(struct dma_chan *chan,
+						dma_cookie_t cookie)
+{
+	enum dma_status status;
+	unsigned long dma_sync_wait_timeout = jiffies + msecs_to_jiffies(5000);
+
+	dma_async_issue_pending(chan);
+	do {
+		status = dma_async_is_tx_complete(chan, cookie, NULL, NULL);
+		if (time_after_eq(jiffies, dma_sync_wait_timeout)) {
+			printk(KERN_ERR "dma_sync_wait_timeout!\n");
+			return DMA_ERROR;
+		}
+	} while (status == DMA_IN_PROGRESS);
+
+	return status;
+}
 
 /* --- DMA device --- */
 
@@ -362,5 +546,4 @@ dma_cookie_t dma_memcpy_pg_to_iovec(stru
 	struct dma_pinned_list *pinned_list, struct page *page,
 	unsigned int offset, size_t len);
 
-#endif /* CONFIG_DMA_ENGINE */
 #endif /* DMAENGINE_H */
