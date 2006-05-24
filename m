Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932515AbWEXASl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932515AbWEXASl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 May 2006 20:18:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932514AbWEXASI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 May 2006 20:18:08 -0400
Received: from [63.64.152.142] ([63.64.152.142]:2822 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S932117AbWEXAPP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 May 2006 20:15:15 -0400
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 2/9] [I/OAT] Driver for the Intel(R) I/OAT DMA engine
Date: Tue, 23 May 2006 17:20:13 -0700
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060524002013.19403.57410.stgit@gitlost.site>
In-Reply-To: <20060524001653.19403.31396.stgit@gitlost.site>
References: <20060524001653.19403.31396.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adds a new ioatdma driver

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 drivers/dma/Kconfig             |    9 
 drivers/dma/Makefile            |    1 
 drivers/dma/ioatdma.c           |  839 +++++++++++++++++++++++++++++++++++++++
 drivers/dma/ioatdma.h           |  126 ++++++
 drivers/dma/ioatdma_hw.h        |   52 ++
 drivers/dma/ioatdma_io.h        |  118 +++++
 drivers/dma/ioatdma_registers.h |  126 ++++++
 7 files changed, 1271 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index f9ac4bc..0f15e76 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -10,4 +10,13 @@ config DMA_ENGINE
 	  DMA engines offload copy operations from the CPU to dedicated
 	  hardware, allowing the copies to happen asynchronously.
 
+comment "DMA Devices"
+
+config INTEL_IOATDMA
+	tristate "Intel I/OAT DMA support"
+	depends on DMA_ENGINE && PCI
+	default m
+	---help---
+	  Enable support for the Intel(R) I/OAT DMA engine.
+
 endmenu
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 10b7391..c8a5f56 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -1 +1,2 @@
 obj-y += dmaengine.o
+obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
diff --git a/drivers/dma/ioatdma.c b/drivers/dma/ioatdma.c
new file mode 100644
index 0000000..11d48b9
--- /dev/null
+++ b/drivers/dma/ioatdma.c
@@ -0,0 +1,839 @@
+/*
+ * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+
+/*
+ * This driver supports an Intel I/OAT DMA engine, which does asynchronous
+ * copy operations.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/interrupt.h>
+#include <linux/dmaengine.h>
+#include <linux/delay.h>
+#include "ioatdma.h"
+#include "ioatdma_io.h"
+#include "ioatdma_registers.h"
+#include "ioatdma_hw.h"
+
+#define to_ioat_chan(chan) container_of(chan, struct ioat_dma_chan, common)
+#define to_ioat_device(dev) container_of(dev, struct ioat_device, common)
+#define to_ioat_desc(lh) container_of(lh, struct ioat_desc_sw, node)
+
+/* internal functions */
+static int __devinit ioat_probe(struct pci_dev *pdev, const struct pci_device_id *ent);
+static void __devexit ioat_remove(struct pci_dev *pdev);
+
+static int enumerate_dma_channels(struct ioat_device *device)
+{
+	u8 xfercap_scale;
+	u32 xfercap;
+	int i;
+	struct ioat_dma_chan *ioat_chan;
+
+	device->common.chancnt = ioatdma_read8(device, IOAT_CHANCNT_OFFSET);
+	xfercap_scale = ioatdma_read8(device, IOAT_XFERCAP_OFFSET);
+	xfercap = (xfercap_scale == 0 ? -1 : (1UL << xfercap_scale));
+
+	for (i = 0; i < device->common.chancnt; i++) {
+		ioat_chan = kzalloc(sizeof(*ioat_chan), GFP_KERNEL);
+		if (!ioat_chan) {
+			device->common.chancnt = i;
+			break;
+		}
+
+		ioat_chan->device = device;
+		ioat_chan->reg_base = device->reg_base + (0x80 * (i + 1));
+		ioat_chan->xfercap = xfercap;
+		spin_lock_init(&ioat_chan->cleanup_lock);
+		spin_lock_init(&ioat_chan->desc_lock);
+		INIT_LIST_HEAD(&ioat_chan->free_desc);
+		INIT_LIST_HEAD(&ioat_chan->used_desc);
+		/* This should be made common somewhere in dmaengine.c */
+		ioat_chan->common.device = &device->common;
+		ioat_chan->common.client = NULL;
+		list_add_tail(&ioat_chan->common.device_node,
+		              &device->common.channels);
+	}
+	return device->common.chancnt;
+}
+
+static struct ioat_desc_sw *ioat_dma_alloc_descriptor(
+	struct ioat_dma_chan *ioat_chan,
+	int flags)
+{
+	struct ioat_dma_descriptor *desc;
+	struct ioat_desc_sw *desc_sw;
+	struct ioat_device *ioat_device;
+	dma_addr_t phys;
+
+	ioat_device = to_ioat_device(ioat_chan->common.device);
+	desc = pci_pool_alloc(ioat_device->dma_pool, flags, &phys);
+	if (unlikely(!desc))
+		return NULL;
+
+	desc_sw = kzalloc(sizeof(*desc_sw), flags);
+	if (unlikely(!desc_sw)) {
+		pci_pool_free(ioat_device->dma_pool, desc, phys);
+		return NULL;
+	}
+
+	memset(desc, 0, sizeof(*desc));
+	desc_sw->hw = desc;
+	desc_sw->phys = phys;
+
+	return desc_sw;
+}
+
+#define INITIAL_IOAT_DESC_COUNT 128
+
+static void ioat_start_null_desc(struct ioat_dma_chan *ioat_chan);
+
+/* returns the actual number of allocated descriptors */
+static int ioat_dma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	struct ioat_desc_sw *desc = NULL;
+	u16 chanctrl;
+	u32 chanerr;
+	int i;
+	LIST_HEAD(tmp_list);
+
+	/*
+	 * In-use bit automatically set by reading chanctrl
+	 * If 0, we got it, if 1, someone else did
+	 */
+	chanctrl = ioatdma_chan_read16(ioat_chan, IOAT_CHANCTRL_OFFSET);
+	if (chanctrl & IOAT_CHANCTRL_CHANNEL_IN_USE)
+		return -EBUSY;
+
+        /* Setup register to interrupt and write completion status on error */
+	chanctrl = IOAT_CHANCTRL_CHANNEL_IN_USE |
+		IOAT_CHANCTRL_ERR_INT_EN |
+		IOAT_CHANCTRL_ANY_ERR_ABORT_EN |
+		IOAT_CHANCTRL_ERR_COMPLETION_EN;
+        ioatdma_chan_write16(ioat_chan, IOAT_CHANCTRL_OFFSET, chanctrl);
+
+	chanerr = ioatdma_chan_read32(ioat_chan, IOAT_CHANERR_OFFSET);
+	if (chanerr) {
+		printk("IOAT: CHANERR = %x, clearing\n", chanerr);
+		ioatdma_chan_write32(ioat_chan, IOAT_CHANERR_OFFSET, chanerr);
+	}
+
+	/* Allocate descriptors */
+	for (i = 0; i < INITIAL_IOAT_DESC_COUNT; i++) {
+		desc = ioat_dma_alloc_descriptor(ioat_chan, GFP_KERNEL);
+		if (!desc) {
+			printk(KERN_ERR "IOAT: Only %d initial descriptors\n", i);
+			break;
+		}
+		list_add_tail(&desc->node, &tmp_list);
+	}
+	spin_lock_bh(&ioat_chan->desc_lock);
+	list_splice(&tmp_list, &ioat_chan->free_desc);
+	spin_unlock_bh(&ioat_chan->desc_lock);
+
+	/* allocate a completion writeback area */
+	/* doing 2 32bit writes to mmio since 1 64b write doesn't work */
+	ioat_chan->completion_virt =
+		pci_pool_alloc(ioat_chan->device->completion_pool,
+		               GFP_KERNEL,
+		               &ioat_chan->completion_addr);
+	memset(ioat_chan->completion_virt, 0,
+	       sizeof(*ioat_chan->completion_virt));
+	ioatdma_chan_write32(ioat_chan, IOAT_CHANCMP_OFFSET_LOW,
+	               ((u64) ioat_chan->completion_addr) & 0x00000000FFFFFFFF);
+	ioatdma_chan_write32(ioat_chan, IOAT_CHANCMP_OFFSET_HIGH,
+	               ((u64) ioat_chan->completion_addr) >> 32);
+
+	ioat_start_null_desc(ioat_chan);
+	return i;
+}
+
+static void ioat_dma_memcpy_cleanup(struct ioat_dma_chan *ioat_chan);
+
+static void ioat_dma_free_chan_resources(struct dma_chan *chan)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	struct ioat_device *ioat_device = to_ioat_device(chan->device);
+	struct ioat_desc_sw *desc, *_desc;
+	u16 chanctrl;
+	int in_use_descs = 0;
+
+	ioat_dma_memcpy_cleanup(ioat_chan);
+
+	ioatdma_chan_write8(ioat_chan, IOAT_CHANCMD_OFFSET, IOAT_CHANCMD_RESET);
+
+	spin_lock_bh(&ioat_chan->desc_lock);
+	list_for_each_entry_safe(desc, _desc, &ioat_chan->used_desc, node) {
+		in_use_descs++;
+		list_del(&desc->node);
+		pci_pool_free(ioat_device->dma_pool, desc->hw, desc->phys);
+		kfree(desc);
+	}
+	list_for_each_entry_safe(desc, _desc, &ioat_chan->free_desc, node) {
+		list_del(&desc->node);
+		pci_pool_free(ioat_device->dma_pool, desc->hw, desc->phys);
+		kfree(desc);
+	}
+	spin_unlock_bh(&ioat_chan->desc_lock);
+
+	pci_pool_free(ioat_device->completion_pool,
+	              ioat_chan->completion_virt,
+	              ioat_chan->completion_addr);
+
+	/* one is ok since we left it on there on purpose */
+	if (in_use_descs > 1)
+		printk(KERN_ERR "IOAT: Freeing %d in use descriptors!\n",
+			in_use_descs - 1);
+
+	ioat_chan->last_completion = ioat_chan->completion_addr = 0;
+
+	/* Tell hw the chan is free */
+	chanctrl = ioatdma_chan_read16(ioat_chan, IOAT_CHANCTRL_OFFSET);
+	chanctrl &= ~IOAT_CHANCTRL_CHANNEL_IN_USE;
+	ioatdma_chan_write16(ioat_chan, IOAT_CHANCTRL_OFFSET, chanctrl);
+}
+
+/**
+ * do_ioat_dma_memcpy - actual function that initiates a IOAT DMA transaction
+ * @chan: IOAT DMA channel handle
+ * @dest: DMA destination address
+ * @src: DMA source address
+ * @len: transaction length in bytes
+ */
+
+static dma_cookie_t do_ioat_dma_memcpy(struct ioat_dma_chan *ioat_chan,
+                                       dma_addr_t dest,
+                                       dma_addr_t src,
+                                       size_t len)
+{
+	struct ioat_desc_sw *first;
+	struct ioat_desc_sw *prev;
+	struct ioat_desc_sw *new;
+	dma_cookie_t cookie;
+	LIST_HEAD(new_chain);
+	u32 copy;
+	size_t orig_len;
+	dma_addr_t orig_src, orig_dst;
+	unsigned int desc_count = 0;
+	unsigned int append = 0;
+
+	if (!ioat_chan || !dest || !src)
+		return -EFAULT;
+
+	if (!len)
+		return ioat_chan->common.cookie;
+
+	orig_len = len;
+	orig_src = src;
+	orig_dst = dest;
+
+	first = NULL;
+	prev = NULL;
+
+	spin_lock_bh(&ioat_chan->desc_lock);
+
+	while (len) {
+		if (!list_empty(&ioat_chan->free_desc)) {
+			new = to_ioat_desc(ioat_chan->free_desc.next);
+			list_del(&new->node);
+		} else {
+			/* try to get another desc */
+			new = ioat_dma_alloc_descriptor(ioat_chan, GFP_ATOMIC);
+			/* will this ever happen? */
+			/* TODO add upper limit on these */
+			BUG_ON(!new);
+		}
+
+		copy = min((u32) len, ioat_chan->xfercap);
+
+		new->hw->size = copy;
+		new->hw->ctl = 0;
+		new->hw->src_addr = src;
+		new->hw->dst_addr = dest;
+		new->cookie = 0;
+
+		/* chain together the physical address list for the HW */
+		if (!first)
+			first = new;
+		else
+			prev->hw->next = (u64) new->phys;
+
+		prev = new;
+
+		len  -= copy;
+		dest += copy;
+		src  += copy;
+
+		list_add_tail(&new->node, &new_chain);
+		desc_count++;
+	}
+	new->hw->ctl = IOAT_DMA_DESCRIPTOR_CTL_CP_STS;
+	new->hw->next = 0;
+
+	/* cookie incr and addition to used_list must be atomic */
+
+	cookie = ioat_chan->common.cookie;
+	cookie++;
+	if (cookie < 0)
+		cookie = 1;
+	ioat_chan->common.cookie = new->cookie = cookie;
+
+	pci_unmap_addr_set(new, src, orig_src);
+	pci_unmap_addr_set(new, dst, orig_dst);
+	pci_unmap_len_set(new, src_len, orig_len);
+	pci_unmap_len_set(new, dst_len, orig_len);
+
+	/* write address into NextDescriptor field of last desc in chain */
+	to_ioat_desc(ioat_chan->used_desc.prev)->hw->next = first->phys;
+	list_splice_init(&new_chain, ioat_chan->used_desc.prev);
+
+	ioat_chan->pending += desc_count;
+	if (ioat_chan->pending >= 20) {
+		append = 1;
+		ioat_chan->pending = 0;
+	}
+
+	spin_unlock_bh(&ioat_chan->desc_lock);
+
+	if (append)
+		ioatdma_chan_write8(ioat_chan,
+		                    IOAT_CHANCMD_OFFSET,
+		                    IOAT_CHANCMD_APPEND);
+	return cookie;
+}
+
+/**
+ * ioat_dma_memcpy_buf_to_buf - wrapper that takes src & dest bufs
+ * @chan: IOAT DMA channel handle
+ * @dest: DMA destination address
+ * @src: DMA source address
+ * @len: transaction length in bytes
+ */
+
+static dma_cookie_t ioat_dma_memcpy_buf_to_buf(struct dma_chan *chan,
+                                               void *dest,
+                                               void *src,
+                                               size_t len)
+{
+	dma_addr_t dest_addr;
+	dma_addr_t src_addr;
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+
+	dest_addr = pci_map_single(ioat_chan->device->pdev,
+		dest, len, PCI_DMA_FROMDEVICE);
+	src_addr = pci_map_single(ioat_chan->device->pdev,
+		src, len, PCI_DMA_TODEVICE);
+
+	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
+}
+
+/**
+ * ioat_dma_memcpy_buf_to_pg - wrapper, copying from a buf to a page
+ * @chan: IOAT DMA channel handle
+ * @page: pointer to the page to copy to
+ * @offset: offset into that page
+ * @src: DMA source address
+ * @len: transaction length in bytes
+ */
+
+static dma_cookie_t ioat_dma_memcpy_buf_to_pg(struct dma_chan *chan,
+                                              struct page *page,
+                                              unsigned int offset,
+                                              void *src,
+                                              size_t len)
+{
+	dma_addr_t dest_addr;
+	dma_addr_t src_addr;
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+
+	dest_addr = pci_map_page(ioat_chan->device->pdev,
+		page, offset, len, PCI_DMA_FROMDEVICE);
+	src_addr = pci_map_single(ioat_chan->device->pdev,
+		src, len, PCI_DMA_TODEVICE);
+
+	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
+}
+
+/**
+ * ioat_dma_memcpy_pg_to_pg - wrapper, copying between two pages
+ * @chan: IOAT DMA channel handle
+ * @dest_pg: pointer to the page to copy to
+ * @dest_off: offset into that page
+ * @src_pg: pointer to the page to copy from
+ * @src_off: offset into that page
+ * @len: transaction length in bytes. This is guaranteed to not make a copy
+ *	 across a page boundary.
+ */
+
+static dma_cookie_t ioat_dma_memcpy_pg_to_pg(struct dma_chan *chan,
+                                             struct page *dest_pg,
+                                             unsigned int dest_off,
+                                             struct page *src_pg,
+                                             unsigned int src_off,
+                                             size_t len)
+{
+	dma_addr_t dest_addr;
+	dma_addr_t src_addr;
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+
+	dest_addr = pci_map_page(ioat_chan->device->pdev,
+		dest_pg, dest_off, len, PCI_DMA_FROMDEVICE);
+	src_addr = pci_map_page(ioat_chan->device->pdev,
+		src_pg, src_off, len, PCI_DMA_TODEVICE);
+
+	return do_ioat_dma_memcpy(ioat_chan, dest_addr, src_addr, len);
+}
+
+/**
+ * ioat_dma_memcpy_issue_pending - push potentially unrecognoized appended descriptors to hw
+ * @chan: DMA channel handle
+ */
+
+static void ioat_dma_memcpy_issue_pending(struct dma_chan *chan)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+
+	if (ioat_chan->pending != 0) {
+		ioat_chan->pending = 0;
+		ioatdma_chan_write8(ioat_chan,
+		                    IOAT_CHANCMD_OFFSET,
+		                    IOAT_CHANCMD_APPEND);
+	}
+}
+
+static void ioat_dma_memcpy_cleanup(struct ioat_dma_chan *chan)
+{
+	unsigned long phys_complete;
+	struct ioat_desc_sw *desc, *_desc;
+	dma_cookie_t cookie = 0;
+
+	prefetch(chan->completion_virt);
+
+	if (!spin_trylock(&chan->cleanup_lock))
+		return;
+
+	/* The completion writeback can happen at any time,
+	   so reads by the driver need to be atomic operations
+	   The descriptor physical addresses are limited to 32-bits
+	   when the CPU can only do a 32-bit mov */
+
+#if (BITS_PER_LONG == 64)
+	phys_complete =
+	chan->completion_virt->full & IOAT_CHANSTS_COMPLETED_DESCRIPTOR_ADDR;
+#else
+	phys_complete = chan->completion_virt->low & IOAT_LOW_COMPLETION_MASK;
+#endif
+
+	if ((chan->completion_virt->full & IOAT_CHANSTS_DMA_TRANSFER_STATUS) ==
+		IOAT_CHANSTS_DMA_TRANSFER_STATUS_HALTED) {
+		printk("IOAT: Channel halted, chanerr = %x\n",
+			ioatdma_chan_read32(chan, IOAT_CHANERR_OFFSET));
+
+		/* TODO do something to salvage the situation */
+	}
+
+	if (phys_complete == chan->last_completion) {
+		spin_unlock(&chan->cleanup_lock);
+		return;
+	}
+
+	spin_lock_bh(&chan->desc_lock);
+	list_for_each_entry_safe(desc, _desc, &chan->used_desc, node) {
+
+		/*
+		 * Incoming DMA requests may use multiple descriptors, due to
+		 * exceeding xfercap, perhaps. If so, only the last one will
+		 * have a cookie, and require unmapping.
+		 */
+		if (desc->cookie) {
+			cookie = desc->cookie;
+
+			/* yes we are unmapping both _page and _single alloc'd
+			   regions with unmap_page. Is this *really* that bad?
+			*/
+			pci_unmap_page(chan->device->pdev,
+					pci_unmap_addr(desc, dst),
+					pci_unmap_len(desc, dst_len),
+					PCI_DMA_FROMDEVICE);
+			pci_unmap_page(chan->device->pdev,
+					pci_unmap_addr(desc, src),
+					pci_unmap_len(desc, src_len),
+					PCI_DMA_TODEVICE);
+		}
+
+		if (desc->phys != phys_complete) {
+			/* a completed entry, but not the last, so cleanup */
+			list_del(&desc->node);
+			list_add_tail(&desc->node, &chan->free_desc);
+		} else {
+			/* last used desc. Do not remove, so we can append from
+			   it, but don't look at it next time, either */
+			desc->cookie = 0;
+
+			/* TODO check status bits? */
+			break;
+		}
+	}
+
+	spin_unlock_bh(&chan->desc_lock);
+
+	chan->last_completion = phys_complete;
+	if (cookie != 0)
+		chan->completed_cookie = cookie;
+
+	spin_unlock(&chan->cleanup_lock);
+}
+
+/**
+ * ioat_dma_is_complete - poll the status of a IOAT DMA transaction
+ * @chan: IOAT DMA channel handle
+ * @cookie: DMA transaction identifier
+ */
+
+static enum dma_status ioat_dma_is_complete(struct dma_chan *chan,
+                                            dma_cookie_t cookie,
+                                            dma_cookie_t *done,
+                                            dma_cookie_t *used)
+{
+	struct ioat_dma_chan *ioat_chan = to_ioat_chan(chan);
+	dma_cookie_t last_used;
+	dma_cookie_t last_complete;
+	enum dma_status ret;
+
+	last_used = chan->cookie;
+	last_complete = ioat_chan->completed_cookie;
+
+	if (done)
+		*done= last_complete;
+	if (used)
+		*used = last_used;
+
+	ret = dma_async_is_complete(cookie, last_complete, last_used);
+	if (ret == DMA_SUCCESS)
+		return ret;
+
+	ioat_dma_memcpy_cleanup(ioat_chan);
+
+	last_used = chan->cookie;
+	last_complete = ioat_chan->completed_cookie;
+
+	if (done)
+		*done= last_complete;
+	if (used)
+		*used = last_used;
+
+	return dma_async_is_complete(cookie, last_complete, last_used);
+}
+
+/* PCI API */
+
+static struct pci_device_id ioat_pci_tbl[] = {
+	{ PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IOAT) },
+	{ 0, }
+};
+
+static struct pci_driver ioat_pci_drv = {
+	.name 	= "ioatdma",
+	.id_table = ioat_pci_tbl,
+	.probe	= ioat_probe,
+	.remove	= __devexit_p(ioat_remove),
+};
+
+static irqreturn_t ioat_do_interrupt(int irq, void *data, struct pt_regs *regs)
+{
+	struct ioat_device *instance = data;
+	unsigned long attnstatus;
+	u8 intrctrl;
+
+	intrctrl = ioatdma_read8(instance, IOAT_INTRCTRL_OFFSET);
+
+	if (!(intrctrl & IOAT_INTRCTRL_MASTER_INT_EN))
+		return IRQ_NONE;
+
+	if (!(intrctrl & IOAT_INTRCTRL_INT_STATUS)) {
+		ioatdma_write8(instance, IOAT_INTRCTRL_OFFSET, intrctrl);
+		return IRQ_NONE;
+	}
+
+	attnstatus = ioatdma_read32(instance, IOAT_ATTNSTATUS_OFFSET);
+
+	printk(KERN_ERR "ioatdma error: interrupt! status %lx\n", attnstatus);
+
+	ioatdma_write8(instance, IOAT_INTRCTRL_OFFSET, intrctrl);
+	return IRQ_HANDLED;
+}
+
+static void ioat_start_null_desc(struct ioat_dma_chan *ioat_chan)
+{
+	struct ioat_desc_sw *desc;
+
+	spin_lock_bh(&ioat_chan->desc_lock);
+
+	if (!list_empty(&ioat_chan->free_desc)) {
+		desc = to_ioat_desc(ioat_chan->free_desc.next);
+		list_del(&desc->node);
+	} else {
+		/* try to get another desc */
+		spin_unlock_bh(&ioat_chan->desc_lock);
+		desc = ioat_dma_alloc_descriptor(ioat_chan, GFP_KERNEL);
+		spin_lock_bh(&ioat_chan->desc_lock);
+		/* will this ever happen? */
+		BUG_ON(!desc);
+	}
+
+	desc->hw->ctl = IOAT_DMA_DESCRIPTOR_NUL;
+	desc->hw->next = 0;
+
+	list_add_tail(&desc->node, &ioat_chan->used_desc);
+	spin_unlock_bh(&ioat_chan->desc_lock);
+
+#if (BITS_PER_LONG == 64)
+	ioatdma_chan_write64(ioat_chan, IOAT_CHAINADDR_OFFSET, desc->phys);
+#else
+	ioatdma_chan_write32(ioat_chan,
+	                     IOAT_CHAINADDR_OFFSET_LOW,
+	                     (u32) desc->phys);
+	ioatdma_chan_write32(ioat_chan, IOAT_CHAINADDR_OFFSET_HIGH, 0);
+#endif
+	ioatdma_chan_write8(ioat_chan, IOAT_CHANCMD_OFFSET, IOAT_CHANCMD_START);
+}
+
+/*
+ * Perform a IOAT transaction to verify the HW works.
+ */
+#define IOAT_TEST_SIZE 2000
+
+static int ioat_self_test(struct ioat_device *device)
+{
+	int i;
+	u8 *src;
+	u8 *dest;
+	struct dma_chan *dma_chan;
+	dma_cookie_t cookie;
+	int err = 0;
+
+	src = kzalloc(sizeof(u8) * IOAT_TEST_SIZE, SLAB_KERNEL);
+	if (!src)
+		return -ENOMEM;
+	dest = kzalloc(sizeof(u8) * IOAT_TEST_SIZE, SLAB_KERNEL);
+	if (!dest) {
+		kfree(src);
+		return -ENOMEM;
+	}
+
+	/* Fill in src buffer */
+	for (i = 0; i < IOAT_TEST_SIZE; i++)
+		src[i] = (u8)i;
+
+	/* Start copy, using first DMA channel */
+	dma_chan = container_of(device->common.channels.next,
+	                        struct dma_chan,
+	                        device_node);
+	if (ioat_dma_alloc_chan_resources(dma_chan) < 1) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	cookie = ioat_dma_memcpy_buf_to_buf(dma_chan, dest, src, IOAT_TEST_SIZE);
+	ioat_dma_memcpy_issue_pending(dma_chan);
+	msleep(1);
+
+	if (ioat_dma_is_complete(dma_chan, cookie, NULL, NULL) != DMA_SUCCESS) {
+		printk(KERN_ERR "ioatdma: Self-test copy timed out, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
+	if (memcmp(src, dest, IOAT_TEST_SIZE)) {
+		printk(KERN_ERR "ioatdma: Self-test copy failed compare, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+free_resources:
+	ioat_dma_free_chan_resources(dma_chan);
+out:
+	kfree(src);
+	kfree(dest);
+	return err;
+}
+
+static int __devinit ioat_probe(struct pci_dev *pdev,
+                                const struct pci_device_id *ent)
+{
+	int err;
+	unsigned long mmio_start, mmio_len;
+	void *reg_base;
+	struct ioat_device *device;
+
+	err = pci_enable_device(pdev);
+	if (err)
+		goto err_enable_device;
+
+	err = pci_set_dma_mask(pdev, DMA_64BIT_MASK);
+	if (err)
+		err = pci_set_dma_mask(pdev, DMA_32BIT_MASK);
+	if (err)
+		goto err_set_dma_mask;
+
+	err = pci_request_regions(pdev, ioat_pci_drv.name);
+	if (err)
+		goto err_request_regions;
+
+	mmio_start = pci_resource_start(pdev, 0);
+	mmio_len = pci_resource_len(pdev, 0);
+
+	reg_base = ioremap(mmio_start, mmio_len);
+	if (!reg_base) {
+		err = -ENOMEM;
+		goto err_ioremap;
+	}
+
+	device = kzalloc(sizeof(*device), GFP_KERNEL);
+	if (!device) {
+		err = -ENOMEM;
+		goto err_kzalloc;
+	}
+
+	/* DMA coherent memory pool for DMA descriptor allocations */
+	device->dma_pool = pci_pool_create("dma_desc_pool", pdev,
+		sizeof(struct ioat_dma_descriptor), 64, 0);
+	if (!device->dma_pool) {
+		err = -ENOMEM;
+		goto err_dma_pool;
+	}
+
+	device->completion_pool = pci_pool_create("completion_pool", pdev, sizeof(u64), SMP_CACHE_BYTES, SMP_CACHE_BYTES);
+	if (!device->completion_pool) {
+		err = -ENOMEM;
+		goto err_completion_pool;
+	}
+
+	device->pdev = pdev;
+	pci_set_drvdata(pdev, device);
+#ifdef CONFIG_PCI_MSI
+	if (pci_enable_msi(pdev) == 0) {
+		device->msi = 1;
+	} else {
+		device->msi = 0;
+	}
+#endif
+	err = request_irq(pdev->irq, &ioat_do_interrupt, SA_SHIRQ, "ioat",
+		device);
+	if (err)
+		goto err_irq;
+
+	device->reg_base = reg_base;
+
+	ioatdma_write8(device, IOAT_INTRCTRL_OFFSET, IOAT_INTRCTRL_MASTER_INT_EN);
+	pci_set_master(pdev);
+
+	INIT_LIST_HEAD(&device->common.channels);
+	enumerate_dma_channels(device);
+
+	device->common.device_alloc_chan_resources = ioat_dma_alloc_chan_resources;
+	device->common.device_free_chan_resources = ioat_dma_free_chan_resources;
+	device->common.device_memcpy_buf_to_buf = ioat_dma_memcpy_buf_to_buf;
+	device->common.device_memcpy_buf_to_pg = ioat_dma_memcpy_buf_to_pg;
+	device->common.device_memcpy_pg_to_pg = ioat_dma_memcpy_pg_to_pg;
+	device->common.device_memcpy_complete = ioat_dma_is_complete;
+	device->common.device_memcpy_issue_pending = ioat_dma_memcpy_issue_pending;
+	printk(KERN_INFO "Intel(R) I/OAT DMA Engine found, %d channels\n",
+		device->common.chancnt);
+
+	err = ioat_self_test(device);
+	if (err)
+		goto err_self_test;
+
+	dma_async_device_register(&device->common);
+
+	return 0;
+
+err_self_test:
+err_irq:
+	pci_pool_destroy(device->completion_pool);
+err_completion_pool:
+	pci_pool_destroy(device->dma_pool);
+err_dma_pool:
+	kfree(device);
+err_kzalloc:
+	iounmap(reg_base);
+err_ioremap:
+	pci_release_regions(pdev);
+err_request_regions:
+err_set_dma_mask:
+	pci_disable_device(pdev);
+err_enable_device:
+	return err;
+}
+
+static void __devexit ioat_remove(struct pci_dev *pdev)
+{
+	struct ioat_device *device;
+	struct dma_chan *chan, *_chan;
+	struct ioat_dma_chan *ioat_chan;
+
+	device = pci_get_drvdata(pdev);
+	dma_async_device_unregister(&device->common);
+
+	free_irq(device->pdev->irq, device);
+#ifdef CONFIG_PCI_MSI
+	if (device->msi)
+		pci_disable_msi(device->pdev);
+#endif
+	pci_pool_destroy(device->dma_pool);
+	pci_pool_destroy(device->completion_pool);
+	iounmap(device->reg_base);
+	pci_release_regions(pdev);
+	pci_disable_device(pdev);
+	list_for_each_entry_safe(chan, _chan, &device->common.channels, device_node) {
+		ioat_chan = to_ioat_chan(chan);
+		list_del(&chan->device_node);
+		kfree(ioat_chan);
+	}
+	kfree(device);
+}
+
+/* MODULE API */
+MODULE_VERSION("1.7");
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Intel Corporation");
+
+static int __init ioat_init_module(void)
+{
+	/* it's currently unsafe to unload this module */
+	/* if forced, worst case is that rmmod hangs */
+	if (THIS_MODULE != NULL)
+		THIS_MODULE->unsafe = 1;
+
+	return pci_module_init(&ioat_pci_drv);
+}
+
+module_init(ioat_init_module);
+
+static void __exit ioat_exit_module(void)
+{
+	pci_unregister_driver(&ioat_pci_drv);
+}
+
+module_exit(ioat_exit_module);
diff --git a/drivers/dma/ioatdma.h b/drivers/dma/ioatdma.h
new file mode 100644
index 0000000..312353d
--- /dev/null
+++ b/drivers/dma/ioatdma.h
@@ -0,0 +1,126 @@
+/*
+ * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+#ifndef IOATDMA_H
+#define IOATDMA_H
+
+#include <linux/dmaengine.h>
+#include "ioatdma_hw.h"
+#include <linux/init.h>
+#include <linux/dmapool.h>
+#include <linux/cache.h>
+
+#define PCI_DEVICE_ID_INTEL_IOAT	0x1a38
+
+#define IOAT_LOW_COMPLETION_MASK	0xffffffc0
+
+extern struct list_head dma_device_list;
+extern struct list_head dma_client_list;
+
+/**
+ * struct ioat_device - internal representation of a IOAT device
+ * @pdev: PCI-Express device
+ * @reg_base: MMIO register space base address
+ * @dma_pool: for allocating DMA descriptors
+ * @common: embedded struct dma_device
+ * @msi: Message Signaled Interrupt number
+ */
+
+struct ioat_device {
+	struct pci_dev *pdev;
+	void *reg_base;
+	struct pci_pool *dma_pool;
+	struct pci_pool *completion_pool;
+
+	struct dma_device common;
+	u8 msi;
+};
+
+/**
+ * struct ioat_dma_chan - internal representation of a DMA channel
+ * @device:
+ * @reg_base:
+ * @sw_in_use:
+ * @completion:
+ * @completion_low:
+ * @completion_high:
+ * @completed_cookie: last cookie seen completed on cleanup
+ * @cookie: value of last cookie given to client
+ * @last_completion:
+ * @xfercap:
+ * @desc_lock:
+ * @free_desc:
+ * @used_desc:
+ * @resource:
+ * @device_node:
+ */
+
+struct ioat_dma_chan {
+
+	void *reg_base;
+
+	dma_cookie_t completed_cookie;
+	unsigned long last_completion;
+
+	u32 xfercap;	/* XFERCAP register value expanded out */
+
+	spinlock_t cleanup_lock;
+	spinlock_t desc_lock;
+	struct list_head free_desc;
+	struct list_head used_desc;
+
+	int pending;
+
+	struct ioat_device *device;
+	struct dma_chan common;
+
+	dma_addr_t completion_addr;
+	union {
+		u64 full; /* HW completion writeback */
+		struct {
+			u32 low;
+			u32 high;
+		};
+	} *completion_virt;
+};
+
+/* wrapper around hardware descriptor format + additional software fields */
+
+/**
+ * struct ioat_desc_sw - wrapper around hardware descriptor
+ * @hw: hardware DMA descriptor
+ * @node:
+ * @cookie:
+ * @phys:
+ */
+
+struct ioat_desc_sw {
+	struct ioat_dma_descriptor *hw;
+	struct list_head node;
+	dma_cookie_t cookie;
+	dma_addr_t phys;
+	DECLARE_PCI_UNMAP_ADDR(src)
+	DECLARE_PCI_UNMAP_LEN(src_len)
+	DECLARE_PCI_UNMAP_ADDR(dst)
+	DECLARE_PCI_UNMAP_LEN(dst_len)
+};
+
+#endif /* IOATDMA_H */
+
diff --git a/drivers/dma/ioatdma_hw.h b/drivers/dma/ioatdma_hw.h
new file mode 100644
index 0000000..4d7a128
--- /dev/null
+++ b/drivers/dma/ioatdma_hw.h
@@ -0,0 +1,52 @@
+/*
+ * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+#ifndef _IOAT_HW_H_
+#define _IOAT_HW_H_
+
+/* PCI Configuration Space Values */
+#define IOAT_PCI_VID			0x8086
+#define IOAT_PCI_DID			0x1A38
+#define IOAT_PCI_RID			0x00
+#define IOAT_PCI_SVID			0x8086
+#define IOAT_PCI_SID			0x8086
+#define IOAT_VER			0x12	/* Version 1.2 */
+
+struct ioat_dma_descriptor {
+	uint32_t	size;
+	uint32_t	ctl;
+	uint64_t	src_addr;
+	uint64_t	dst_addr;
+	uint64_t	next;
+	uint64_t	rsv1;
+	uint64_t	rsv2;
+	uint64_t	user1;
+	uint64_t	user2;
+};
+
+#define IOAT_DMA_DESCRIPTOR_CTL_INT_GN	0x00000001
+#define IOAT_DMA_DESCRIPTOR_CTL_SRC_SN	0x00000002
+#define IOAT_DMA_DESCRIPTOR_CTL_DST_SN	0x00000004
+#define IOAT_DMA_DESCRIPTOR_CTL_CP_STS	0x00000008
+#define IOAT_DMA_DESCRIPTOR_CTL_FRAME	0x00000010
+#define IOAT_DMA_DESCRIPTOR_NUL		0x00000020
+#define IOAT_DMA_DESCRIPTOR_OPCODE	0xFF000000
+
+#endif
diff --git a/drivers/dma/ioatdma_io.h b/drivers/dma/ioatdma_io.h
new file mode 100644
index 0000000..c0b4bf6
--- /dev/null
+++ b/drivers/dma/ioatdma_io.h
@@ -0,0 +1,118 @@
+/*
+ * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+#ifndef IOATDMA_IO_H
+#define IOATDMA_IO_H
+
+#include <asm/io.h>
+
+/*
+ * device and per-channel MMIO register read and write functions
+ * this is a lot of anoying inline functions, but it's typesafe
+ */
+
+static inline u8 ioatdma_read8(struct ioat_device *device,
+                               unsigned int offset)
+{
+	return readb(device->reg_base + offset);
+}
+
+static inline u16 ioatdma_read16(struct ioat_device *device,
+                                 unsigned int offset)
+{
+	return readw(device->reg_base + offset);
+}
+
+static inline u32 ioatdma_read32(struct ioat_device *device,
+                                 unsigned int offset)
+{
+	return readl(device->reg_base + offset);
+}
+
+static inline void ioatdma_write8(struct ioat_device *device,
+                                  unsigned int offset, u8 value)
+{
+	writeb(value, device->reg_base + offset);
+}
+
+static inline void ioatdma_write16(struct ioat_device *device,
+                                   unsigned int offset, u16 value)
+{
+	writew(value, device->reg_base + offset);
+}
+
+static inline void ioatdma_write32(struct ioat_device *device,
+                                   unsigned int offset, u32 value)
+{
+	writel(value, device->reg_base + offset);
+}
+
+static inline u8 ioatdma_chan_read8(struct ioat_dma_chan *chan,
+                                    unsigned int offset)
+{
+	return readb(chan->reg_base + offset);
+}
+
+static inline u16 ioatdma_chan_read16(struct ioat_dma_chan *chan,
+                                      unsigned int offset)
+{
+	return readw(chan->reg_base + offset);
+}
+
+static inline u32 ioatdma_chan_read32(struct ioat_dma_chan *chan,
+                                      unsigned int offset)
+{
+	return readl(chan->reg_base + offset);
+}
+
+static inline void ioatdma_chan_write8(struct ioat_dma_chan *chan,
+                                       unsigned int offset, u8 value)
+{
+	writeb(value, chan->reg_base + offset);
+}
+
+static inline void ioatdma_chan_write16(struct ioat_dma_chan *chan,
+                                        unsigned int offset, u16 value)
+{
+	writew(value, chan->reg_base + offset);
+}
+
+static inline void ioatdma_chan_write32(struct ioat_dma_chan *chan,
+                                        unsigned int offset, u32 value)
+{
+	writel(value, chan->reg_base + offset);
+}
+
+#if (BITS_PER_LONG == 64)
+static inline u64 ioatdma_chan_read64(struct ioat_dma_chan *chan,
+                                      unsigned int offset)
+{
+	return readq(chan->reg_base + offset);
+}
+
+static inline void ioatdma_chan_write64(struct ioat_dma_chan *chan,
+                                        unsigned int offset, u64 value)
+{
+	writeq(value, chan->reg_base + offset);
+}
+#endif
+
+#endif /* IOATDMA_IO_H */
+
diff --git a/drivers/dma/ioatdma_registers.h b/drivers/dma/ioatdma_registers.h
new file mode 100644
index 0000000..41a21ab
--- /dev/null
+++ b/drivers/dma/ioatdma_registers.h
@@ -0,0 +1,126 @@
+/*
+ * Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+ *
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the Free
+ * Software Foundation; either version 2 of the License, or (at your option)
+ * any later version.
+ *
+ * This program is distributed in the hope that it will be useful, but WITHOUT
+ * ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+ * FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+ * more details.
+ *
+ * You should have received a copy of the GNU General Public License along with
+ * this program; if not, write to the Free Software Foundation, Inc., 59
+ * Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+ *
+ * The full GNU General Public License is included in this distribution in the
+ * file called COPYING.
+ */
+#ifndef _IOAT_REGISTERS_H_
+#define _IOAT_REGISTERS_H_
+
+
+/* MMIO Device Registers */
+#define IOAT_CHANCNT_OFFSET			0x00	/*  8-bit */
+
+#define IOAT_XFERCAP_OFFSET			0x01	/*  8-bit */
+#define IOAT_XFERCAP_4KB			12
+#define IOAT_XFERCAP_8KB			13
+#define IOAT_XFERCAP_16KB			14
+#define IOAT_XFERCAP_32KB			15
+#define IOAT_XFERCAP_32GB			0
+
+#define IOAT_GENCTRL_OFFSET			0x02	/*  8-bit */
+#define IOAT_GENCTRL_DEBUG_EN			0x01
+
+#define IOAT_INTRCTRL_OFFSET			0x03	/*  8-bit */
+#define IOAT_INTRCTRL_MASTER_INT_EN		0x01	/* Master Interrupt Enable */
+#define IOAT_INTRCTRL_INT_STATUS		0x02	/* ATTNSTATUS -or- Channel Int */
+#define IOAT_INTRCTRL_INT			0x04	/* INT_STATUS -and- MASTER_INT_EN */
+
+#define IOAT_ATTNSTATUS_OFFSET			0x04	/* Each bit is a channel */
+
+#define IOAT_VER_OFFSET				0x08	/*  8-bit */
+#define IOAT_VER_MAJOR_MASK			0xF0
+#define IOAT_VER_MINOR_MASK			0x0F
+#define GET_IOAT_VER_MAJOR(x)			((x) & IOAT_VER_MAJOR_MASK)
+#define GET_IOAT_VER_MINOR(x)			((x) & IOAT_VER_MINOR_MASK)
+
+#define IOAT_PERPORTOFFSET_OFFSET		0x0A	/* 16-bit */
+
+#define IOAT_INTRDELAY_OFFSET			0x0C	/* 16-bit */
+#define IOAT_INTRDELAY_INT_DELAY_MASK		0x3FFF	/* Interrupt Delay Time */
+#define IOAT_INTRDELAY_COALESE_SUPPORT		0x8000	/* Interrupt Coalesing Supported */
+
+#define IOAT_DEVICE_STATUS_OFFSET		0x0E	/* 16-bit */
+#define IOAT_DEVICE_STATUS_DEGRADED_MODE	0x0001
+
+
+#define IOAT_CHANNEL_MMIO_SIZE			0x80	/* Each Channel MMIO space is this size */
+
+/* DMA Channel Registers */
+#define IOAT_CHANCTRL_OFFSET			0x00	/* 16-bit Channel Control Register */
+#define IOAT_CHANCTRL_CHANNEL_PRIORITY_MASK	0xF000
+#define IOAT_CHANCTRL_CHANNEL_IN_USE		0x0100
+#define IOAT_CHANCTRL_DESCRIPTOR_ADDR_SNOOP_CONTROL	0x0020
+#define IOAT_CHANCTRL_ERR_INT_EN		0x0010
+#define IOAT_CHANCTRL_ANY_ERR_ABORT_EN		0x0008
+#define IOAT_CHANCTRL_ERR_COMPLETION_EN		0x0004
+#define IOAT_CHANCTRL_INT_DISABLE		0x0001
+
+#define IOAT_DMA_COMP_OFFSET			0x02	/* 16-bit DMA channel compatability */
+#define IOAT_DMA_COMP_V1			0x0001	/* Compatability with DMA version 1 */
+
+#define IOAT_CHANSTS_OFFSET			0x04	/* 64-bit Channel Status Register */
+#define IOAT_CHANSTS_OFFSET_LOW			0x04
+#define IOAT_CHANSTS_OFFSET_HIGH		0x08
+#define IOAT_CHANSTS_COMPLETED_DESCRIPTOR_ADDR	0xFFFFFFFFFFFFFFC0
+#define IOAT_CHANSTS_SOFT_ERR			0x0000000000000010
+#define IOAT_CHANSTS_DMA_TRANSFER_STATUS	0x0000000000000007
+#define IOAT_CHANSTS_DMA_TRANSFER_STATUS_ACTIVE	0x0
+#define IOAT_CHANSTS_DMA_TRANSFER_STATUS_DONE	0x1
+#define IOAT_CHANSTS_DMA_TRANSFER_STATUS_SUSPENDED	0x2
+#define IOAT_CHANSTS_DMA_TRANSFER_STATUS_HALTED	0x3
+
+#define IOAT_CHAINADDR_OFFSET			0x0C	/* 64-bit Descriptor Chain Address Register */
+#define IOAT_CHAINADDR_OFFSET_LOW		0x0C
+#define IOAT_CHAINADDR_OFFSET_HIGH		0x10
+
+#define IOAT_CHANCMD_OFFSET			0x14	/*  8-bit DMA Channel Command Register */
+#define IOAT_CHANCMD_RESET			0x20
+#define IOAT_CHANCMD_RESUME			0x10
+#define IOAT_CHANCMD_ABORT			0x08
+#define IOAT_CHANCMD_SUSPEND			0x04
+#define IOAT_CHANCMD_APPEND			0x02
+#define IOAT_CHANCMD_START			0x01
+
+#define IOAT_CHANCMP_OFFSET			0x18	/* 64-bit Channel Completion Address Register */
+#define IOAT_CHANCMP_OFFSET_LOW			0x18
+#define IOAT_CHANCMP_OFFSET_HIGH		0x1C
+
+#define IOAT_CDAR_OFFSET			0x20	/* 64-bit Current Descriptor Address Register */
+#define IOAT_CDAR_OFFSET_LOW			0x20
+#define IOAT_CDAR_OFFSET_HIGH			0x24
+
+#define IOAT_CHANERR_OFFSET			0x28	/* 32-bit Channel Error Register */
+#define IOAT_CHANERR_DMA_TRANSFER_SRC_ADDR_ERR	0x0001
+#define IOAT_CHANERR_DMA_TRANSFER_DEST_ADDR_ERR	0x0002
+#define IOAT_CHANERR_NEXT_DESCRIPTOR_ADDR_ERR	0x0004
+#define IOAT_CHANERR_NEXT_DESCRIPTOR_ALIGNMENT_ERR	0x0008
+#define IOAT_CHANERR_CHAIN_ADDR_VALUE_ERR	0x0010
+#define IOAT_CHANERR_CHANCMD_ERR		0x0020
+#define IOAT_CHANERR_CHIPSET_UNCORRECTABLE_DATA_INTEGRITY_ERR	0x0040
+#define IOAT_CHANERR_DMA_UNCORRECTABLE_DATA_INTEGRITY_ERR	0x0080
+#define IOAT_CHANERR_READ_DATA_ERR		0x0100
+#define IOAT_CHANERR_WRITE_DATA_ERR		0x0200
+#define IOAT_CHANERR_DESCRIPTOR_CONTROL_ERR	0x0400
+#define IOAT_CHANERR_DESCRIPTOR_LENGTH_ERR	0x0800
+#define IOAT_CHANERR_COMPLETION_ADDR_ERR	0x1000
+#define IOAT_CHANERR_INT_CONFIGURATION_ERR	0x2000
+#define IOAT_CHANERR_SOFT_ERR			0x4000
+
+#define IOAT_CHANERR_MASK_OFFSET		0x2C	/* 32-bit Channel Error Register */
+
+#endif /* _IOAT_REGISTERS_H_ */

