Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965121AbWIKXTr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965121AbWIKXTr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Sep 2006 19:19:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965119AbWIKXTl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Sep 2006 19:19:41 -0400
Received: from mga03.intel.com ([143.182.124.21]:29993 "EHLO mga03.intel.com")
	by vger.kernel.org with ESMTP id S965102AbWIKXTC (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Sep 2006 19:19:02 -0400
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,147,1157353200"; 
   d="scan'208"; a="114947255:sNHT446114494"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 16/19] dmaengine: Driver for the Intel IOP 32x, 33x, and 13xx RAID engines
Date: Mon, 11 Sep 2006 16:19:00 -0700
To: neilb@suse.de, linux-raid@vger.kernel.org
Cc: akpm@osdl.org, linux-kernel@vger.kernel.org, christopher.leech@intel.com
Message-Id: <20060911231859.4737.46229.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
References: <1158015632.4241.31.camel@dwillia2-linux.ch.intel.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.10
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

This is a driver for the iop DMA/AAU/ADMA units which are capable of pq_xor,
pq_update, pq_zero_sum, xor, dual_xor, xor_zero_sum, fill, copy+crc, and copy
operations.

Changelog:
* fixed a slot allocation bug in do_iop13xx_adma_xor that caused too few
slots to be requested eventually leading to data corruption
* enabled the slot allocation routine to attempt to free slots before
returning -ENOMEM
* switched the cleanup routine to solely use the software chain and the
status register to determine if a descriptor is complete.  This is
necessary to support other IOP engines that do not have status writeback
capability
* make the driver iop generic
* modified the allocation routines to understand allocating a group of
slots for a single operation
* added a null xor initialization operation for the xor only channel on
iop3xx
* add software emulation of zero sum on iop32x
* support xor operations on buffers larger than the hardware maximum
* add architecture specific raid5-dma support functions

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/dma/Kconfig                 |   27 +
 drivers/dma/Makefile                |    1 
 drivers/dma/iop-adma.c              | 1501 +++++++++++++++++++++++++++++++++++
 include/asm-arm/hardware/iop_adma.h |   98 ++
 4 files changed, 1624 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index fced8c3..3556143 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -7,8 +7,8 @@ menu "DMA Engine support"
 config DMA_ENGINE
 	bool "Support for DMA engines"
 	---help---
-	  DMA engines offload copy operations from the CPU to dedicated
-	  hardware, allowing the copies to happen asynchronously.
+          DMA engines offload block memory operations from the CPU to dedicated
+          hardware, allowing the operations to happen asynchronously.
 
 comment "DMA Clients"
 
@@ -28,9 +28,19 @@ config RAID5_DMA
 	default y
 	---help---
 	  This enables the use of DMA engines in the MD-RAID5 driver to
-	  offload stripe cache operations, freeing CPU cycles.
+	  offload stripe cache operations (i.e. xor, memcpy), freeing CPU cycles.
 	  say Y here
 
+config RAID5_DMA_WAIT_VIA_REQUEUE
+	bool "raid5-dma: Non-blocking channel switching"
+	depends on RAID5_DMA_ARCH_NEEDS_CHAN_SWITCH && RAID5_DMA && BROKEN
+	default n
+	---help---
+	  This enables the raid5-dma driver to continue to operate on incoming
+	  stripes when it determines that the current stripe must wait for a
+	  a hardware channel to finish operations.  This code is a work in
+	  progress, only say Y to debug the implementation, otherwise say N.
+
 comment "DMA Devices"
 
 config INTEL_IOATDMA
@@ -40,4 +50,15 @@ config INTEL_IOATDMA
 	---help---
 	  Enable support for the Intel(R) I/OAT DMA engine.
 
+config INTEL_IOP_ADMA
+        tristate "Intel IOP ADMA support"
+        depends on DMA_ENGINE && (ARCH_IOP32X || ARCH_IOP33X || ARCH_IOP13XX)
+	select RAID5_DMA_ARCH_NEEDS_CHAN_SWITCH if (ARCH_IOP32X || ARCH_IOP33X)
+        default m
+        ---help---
+          Enable support for the Intel(R) IOP Series RAID engines.
+
+config RAID5_DMA_ARCH_NEEDS_CHAN_SWITCH
+	bool
+
 endmenu
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index 4e36d6e..233eae7 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -2,3 +2,4 @@ obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
 obj-$(CONFIG_NET_DMA) += iovlock.o
 obj-$(CONFIG_RAID5_DMA) += raid5-dma.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
+obj-$(CONFIG_INTEL_IOP_ADMA) += iop-adma.o
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
new file mode 100644
index 0000000..51f1c54
--- /dev/null
+++ b/drivers/dma/iop-adma.c
@@ -0,0 +1,1501 @@
+/*
+ * Copyright(c) 2006 Intel Corporation. All rights reserved.
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
+ * This driver supports the asynchrounous DMA copy and RAID engines available
+ * on the Intel Xscale(R) family of I/O Processors (IOP 32x, 33x, 134x)
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/dmaengine.h>
+#include <linux/delay.h>
+#include <linux/dma-mapping.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <asm/arch/adma.h>
+#include <asm/memory.h>
+
+#define to_iop_adma_chan(chan) container_of(chan, struct iop_adma_chan, common)
+#define to_iop_adma_device(dev) container_of(dev, struct iop_adma_device, common)
+#define to_iop_adma_slot(lh) container_of(lh, struct iop_adma_desc_slot, slot_node)
+
+#define IOP_ADMA_DEBUG 0
+#define PRINTK(x...) ((void)(IOP_ADMA_DEBUG && printk(x)))
+
+/* software zero sum implemenation bits for iop32x */
+#ifdef CONFIG_ARCH_IOP32X
+char iop32x_zero_result_buffer[PAGE_SIZE] __attribute__((aligned(256)));
+u32 *iop32x_zero_sum_output;
+#endif
+
+/**
+ * iop_adma_free_slots - flags descriptor slots for reuse
+ * @slot: Slot to free
+ * Caller must hold &iop_chan->lock while calling this function
+ */
+static inline void iop_adma_free_slots(struct iop_adma_desc_slot *slot)
+{
+	int stride = slot->stride;
+	while (stride--) {
+		slot->stride = 0;
+		slot = list_entry(slot->slot_node.next,
+				struct iop_adma_desc_slot,
+				slot_node);
+	}
+}
+
+static void __iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
+{
+	struct iop_adma_desc_slot *iter, *_iter;
+	dma_cookie_t cookie = 0;
+	struct device *dev = &iop_chan->device->pdev->dev;
+	u32 current_desc = iop_chan_get_current_descriptor(iop_chan);
+	int busy = iop_chan_is_busy(iop_chan);
+	int seen_current = 0;
+
+	/* free completed slots from the chain starting with
+	 * the oldest descriptor
+	 */
+	list_for_each_entry_safe(iter, _iter, &iop_chan->chain,
+					chain_node) {
+		PRINTK("%s: [%d] cookie: %d busy: %x next: %x\n",
+			__FUNCTION__, iter->idx, iter->cookie, busy,
+			iop_desc_get_next_desc(iter, iop_chan));
+
+		/* do not advance past the current descriptor loaded into the 
+		 * hardware channel, subsequent descriptors are either in process
+		 * or have not been submitted
+		 */
+		if (seen_current)
+			break;
+
+		/* stop the search if we reach the current descriptor and the
+		 * channel is busy, or if it appears that the current descriptor
+		 * needs to be re-read (i.e. has been appended to)
+		 */
+		if (iter->phys == current_desc) {
+			BUG_ON(seen_current++);
+			if (busy || iop_desc_get_next_desc(iter, iop_chan))
+				break;
+		}
+
+		/* if we are tracking a group of zero-result descriptors add
+		 * the current result to the accumulator
+		 */
+		if (iop_chan->zero_sum_group) {
+			iop_chan->result_accumulator |=
+				iop_desc_get_zero_result(iter);
+			PRINTK("%s: add to zero sum group acc: %d this: %d\n", __FUNCTION__,
+				iop_chan->result_accumulator, iop_desc_get_zero_result(iter));
+		}
+
+		if (iter->cookie) {
+			u32 src_cnt = iter->src_cnt;
+			u32 len = iop_desc_get_byte_count(iter, iop_chan);
+			dma_addr_t addr;
+
+			cookie = iter->cookie;
+			iter->cookie = 0;
+
+			/* the first and last descriptor in a zero sum group
+			 * will have 'xor_check_result' set
+			 */
+			if (iter->xor_check_result) {
+				if (iter->slot_cnt > iter->slots_per_op) {
+					if (!iop_chan->zero_sum_group) {
+						iop_chan->zero_sum_group = 1;
+						iop_chan->result_accumulator |=
+							iop_desc_get_zero_result(iter);
+					}
+					PRINTK("%s: start zero sum group acc: %d this: %d\n", __FUNCTION__,
+						iop_chan->result_accumulator, iop_desc_get_zero_result(iter));
+				} else {
+					if (!iop_chan->zero_sum_group)
+						iop_chan->result_accumulator |=
+							iop_desc_get_zero_result(iter);
+					else
+						iop_chan->zero_sum_group = 0;
+	
+					*iter->xor_check_result = iop_chan->result_accumulator;
+					iop_chan->result_accumulator = 0;
+
+					PRINTK("%s: end zero sum group acc: %d this: %d\n", __FUNCTION__,
+						*iter->xor_check_result, iop_desc_get_zero_result(iter));
+				}
+			}
+
+			/* unmap dma ranges */
+			switch (iter->flags & (DMA_DEST_BUF | DMA_DEST_PAGE |
+				DMA_DEST_DMA)) {
+			case DMA_DEST_BUF:
+				addr = iop_desc_get_dest_addr(iter, iop_chan);
+				dma_unmap_single(dev, addr, len, DMA_FROM_DEVICE);
+				break;
+			case DMA_DEST_PAGE:
+				addr = iop_desc_get_dest_addr(iter, iop_chan);
+				dma_unmap_page(dev, addr, len, DMA_FROM_DEVICE);
+				break;
+			case DMA_DEST_DMA:
+				break;
+			}
+
+			switch (iter->flags & (DMA_SRC_BUF |
+					DMA_SRC_PAGE | DMA_SRC_DMA |
+					DMA_SRC_PAGES | DMA_SRC_DMA_LIST)) {
+			case DMA_SRC_BUF:
+				addr = iop_desc_get_src_addr(iter, iop_chan, 0);
+				dma_unmap_single(dev, addr, len, DMA_TO_DEVICE);
+				break;
+			case DMA_SRC_PAGE:
+				addr = iop_desc_get_src_addr(iter, iop_chan, 0);
+				dma_unmap_page(dev, addr, len, DMA_TO_DEVICE);
+				break;
+			case DMA_SRC_PAGES:
+				while(src_cnt--) {
+					addr = iop_desc_get_src_addr(iter,
+								iop_chan,
+								src_cnt);
+					dma_unmap_page(dev, addr, len,
+						DMA_TO_DEVICE);
+				}
+				break;
+			case DMA_SRC_DMA:
+			case DMA_SRC_DMA_LIST:
+				break;
+			}
+		}
+
+		/* leave the last descriptor in the chain 
+		 * so we can append to it
+		 */
+		if (iter->chain_node.next == &iop_chan->chain)
+			break;
+
+		PRINTK("iop adma%d: cleanup %d stride %d\n",
+		iop_chan->device->id, iter->idx, iter->stride);
+
+		list_del(&iter->chain_node);
+		iop_adma_free_slots(iter);
+	}
+
+	BUG_ON(!seen_current);
+
+	if (cookie) {
+		iop_chan->completed_cookie = cookie;
+
+		PRINTK("iop adma%d: completed cookie %d\n",
+		iop_chan->device->id, cookie);
+	}
+}
+
+static inline void iop_adma_slot_cleanup(struct iop_adma_chan *iop_chan)
+{
+	spin_lock_bh(&iop_chan->lock);
+	__iop_adma_slot_cleanup(iop_chan);
+	spin_unlock_bh(&iop_chan->lock);
+}
+
+static struct iop_adma_desc_slot *
+__iop_adma_alloc_slots(struct iop_adma_chan *iop_chan, int num_slots,
+			int slots_per_op, int recurse)
+{
+	struct iop_adma_desc_slot *iter = NULL, *alloc_start = NULL;
+	int i;
+
+	/* start search from the last allocated descrtiptor
+	 * if a contiguous allocation can not be found start searching
+	 * from the beginning of the list
+	 */
+	for (i = 0; i < 2; i++) {
+		int slots_found = 0;
+		if (i == 0)
+			iter = iop_chan->last_used;
+		else {
+			iter = list_entry(&iop_chan->all_slots,
+				struct iop_adma_desc_slot,
+				slot_node);
+		}
+
+		list_for_each_entry_continue(iter, &iop_chan->all_slots, slot_node) {
+			if (iter->stride) {
+				/* give up after finding the first busy slot
+				 * on the second pass through the list
+				 */
+				if (i == 1)
+					break;
+
+				slots_found = 0;
+				continue;
+			}
+
+			/* start the allocation if the slot is correctly aligned */
+			if (!slots_found++) {
+				if (iop_desc_is_aligned(iter, slots_per_op))
+					alloc_start = iter;
+				else {
+					slots_found = 0;
+					continue;
+				}
+			}
+
+			if (slots_found == num_slots) {
+				iter = alloc_start;
+				while (num_slots) {
+					PRINTK("iop adma%d: allocated [%d] "
+						"(desc %p phys: %#x) stride %d\n",
+						iop_chan->device->id,
+						iter->idx, iter->hw_desc, iter->phys,
+						slots_per_op);
+					iop_chan->last_used = iter;
+					list_add_tail(&iter->chain_node,
+							&iop_chan->chain);
+					iter->slot_cnt = num_slots;
+					iter->slots_per_op = slots_per_op;
+					iter->xor_check_result = NULL;
+					iter->cookie = 0;
+					for (i = 0; i < slots_per_op; i++) {
+						iter->stride = slots_per_op - i;
+						iter = list_entry(iter->slot_node.next,
+								struct iop_adma_desc_slot,
+								slot_node);
+					}
+					num_slots -= slots_per_op;
+				}
+				return alloc_start;
+			}
+		}
+	}
+
+	/* try once to free some slots if the allocation fails */
+	if (recurse) {
+		__iop_adma_slot_cleanup(iop_chan);
+		return __iop_adma_alloc_slots(iop_chan, num_slots, slots_per_op, 0);
+	} else
+		return NULL;
+}
+
+static struct iop_adma_desc_slot *
+iop_adma_alloc_slots(struct iop_adma_chan *iop_chan,
+			int num_slots,
+			int slots_per_op)
+{
+	return __iop_adma_alloc_slots(iop_chan, num_slots, slots_per_op, 1);
+}
+
+static void iop_chan_start_null_memcpy(struct iop_adma_chan *iop_chan);
+static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan);
+
+/* returns the actual number of allocated descriptors */
+static int iop_adma_alloc_chan_resources(struct dma_chan *chan)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	struct iop_adma_desc_slot *slot = NULL;
+	char *hw_desc;
+	int i;
+	int init = iop_chan->slots_allocated ? 0 : 1;
+	struct iop_adma_platform_data *plat_data;
+	
+	plat_data = iop_chan->device->pdev->dev.platform_data;
+
+	spin_lock_bh(&iop_chan->lock);
+	/* Allocate descriptor slots */
+	i = iop_chan->slots_allocated;
+	for (; i < (plat_data->pool_size/IOP_ADMA_SLOT_SIZE); i++) {
+		slot = kmalloc(sizeof(*slot), GFP_KERNEL);
+		if (!slot) {
+			printk(KERN_INFO "IOP ADMA Channel only initialized"
+				" %d descriptor slots", i--);
+			break;
+		}
+		hw_desc = (char *) iop_chan->device->dma_desc_pool_virt;
+		slot->hw_desc = (void *) &hw_desc[i * IOP_ADMA_SLOT_SIZE];
+
+		INIT_LIST_HEAD(&slot->chain_node);
+		INIT_LIST_HEAD(&slot->slot_node);
+		hw_desc = (char *) iop_chan->device->dma_desc_pool;
+		slot->phys = (dma_addr_t) &hw_desc[i * IOP_ADMA_SLOT_SIZE];
+		slot->stride = 0;
+		slot->cookie = 0;
+		slot->xor_check_result = NULL;
+		slot->idx = i;
+		list_add_tail(&slot->slot_node, &iop_chan->all_slots);
+	}
+	if (i && !iop_chan->last_used)
+		iop_chan->last_used = list_entry(iop_chan->all_slots.next,
+					struct iop_adma_desc_slot,
+					slot_node);
+
+	iop_chan->slots_allocated = i;
+	PRINTK("iop adma%d: allocated %d descriptor slots last_used: %p\n",
+		iop_chan->device->id, i, iop_chan->last_used);
+	spin_unlock_bh(&iop_chan->lock);
+
+	/* initialize the channel and the chain with a null operation */
+	if (init) {
+		if (iop_chan->device->common.capabilities & DMA_MEMCPY)
+			iop_chan_start_null_memcpy(iop_chan);
+		else if (iop_chan->device->common.capabilities & DMA_XOR)
+			iop_chan_start_null_xor(iop_chan);
+		else
+			BUG();
+	}
+
+	return (i > 0) ? i : -ENOMEM;
+}
+
+/* chain the descriptors */
+static inline void iop_chan_chain_desc(struct iop_adma_chan *iop_chan,
+					struct iop_adma_desc_slot *desc)
+{
+	struct iop_adma_desc_slot *prev = list_entry(desc->chain_node.prev,
+						struct iop_adma_desc_slot,
+						chain_node);
+	iop_desc_set_next_desc(prev, iop_chan, desc->phys);
+}
+
+static inline void iop_desc_assign_cookie(struct iop_adma_chan *iop_chan,
+					struct iop_adma_desc_slot *desc)
+{
+	dma_cookie_t cookie = iop_chan->common.cookie;
+	cookie++;
+	if (cookie < 0)
+		cookie = 1;
+	iop_chan->common.cookie = desc->cookie = cookie;
+	PRINTK("iop adma%d: %s cookie %d slot %d\n",
+	iop_chan->device->id, __FUNCTION__, cookie, desc->idx);
+}
+
+static inline void iop_adma_check_threshold(struct iop_adma_chan *iop_chan)
+{
+	if (iop_chan->pending >= IOP_ADMA_THRESHOLD) {
+		iop_chan->pending = 0;
+		iop_chan_append(iop_chan);
+	}
+}
+
+static dma_cookie_t do_iop_adma_memcpy(struct dma_chan *chan,
+                                       union dmaengine_addr dest,
+					unsigned int dest_off,
+                                       union dmaengine_addr src,
+					unsigned int src_off,
+                                       size_t len,
+                                       unsigned long flags)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	dma_cookie_t ret = -ENOMEM;
+	struct iop_adma_desc_slot *sw_desc;
+	int slot_cnt, slots_per_op;
+
+	if (!chan || !dest.dma || !src.dma)
+		return -EFAULT;
+	if (!len)
+		return iop_chan->common.cookie;
+
+	PRINTK("iop adma%d: %s len: %u flags: %#lx\n",
+	iop_chan->device->id, __FUNCTION__, len, flags);
+
+	switch (flags & (DMA_SRC_BUF | DMA_SRC_PAGE | DMA_SRC_DMA)) {
+	case DMA_SRC_BUF:
+		src.dma = dma_map_single(&iop_chan->device->pdev->dev,
+			src.buf, len, DMA_TO_DEVICE);
+		break;
+	case DMA_SRC_PAGE:
+		src.dma = dma_map_page(&iop_chan->device->pdev->dev,
+			src.pg, src_off, len, DMA_TO_DEVICE);
+		break;
+	case DMA_SRC_DMA:
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	switch (flags & (DMA_DEST_BUF | DMA_DEST_PAGE | DMA_DEST_DMA)) {
+	case DMA_DEST_BUF:
+		dest.dma = dma_map_single(&iop_chan->device->pdev->dev,
+			dest.buf, len, DMA_FROM_DEVICE);
+		break;
+	case DMA_DEST_PAGE:
+		dest.dma = dma_map_page(&iop_chan->device->pdev->dev,
+			dest.pg, dest_off, len, DMA_FROM_DEVICE);
+		break;
+	case DMA_DEST_DMA:
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	spin_lock_bh(&iop_chan->lock);
+	slot_cnt = iop_chan_memcpy_slot_count(len, &slots_per_op);
+	sw_desc = iop_adma_alloc_slots(iop_chan, slot_cnt, slots_per_op);
+	if (sw_desc) {
+		iop_desc_init_memcpy(sw_desc);
+		iop_desc_set_byte_count(sw_desc, iop_chan, len);
+		iop_desc_set_dest_addr(sw_desc, iop_chan, dest.dma);
+		iop_desc_set_memcpy_src_addr(sw_desc, src.dma, slot_cnt, slots_per_op);
+
+		iop_chan_chain_desc(iop_chan, sw_desc);
+		iop_desc_assign_cookie(iop_chan, sw_desc);
+
+		sw_desc->flags = flags;
+		iop_chan->pending++;
+		ret = sw_desc->cookie;
+	}
+	spin_unlock_bh(&iop_chan->lock);
+
+	iop_adma_check_threshold(iop_chan);
+
+	return ret;
+}
+
+static dma_cookie_t do_iop_adma_memset(struct dma_chan *chan,
+                                       union dmaengine_addr dest,
+					unsigned int dest_off,
+                                       int val,
+                                       size_t len,
+                                       unsigned long flags)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	dma_cookie_t ret = -ENOMEM;
+	struct iop_adma_desc_slot *sw_desc;
+	int slot_cnt, slots_per_op;
+
+	if (!chan || !dest.dma)
+		return -EFAULT;
+	if (!len)
+		return iop_chan->common.cookie;
+
+	PRINTK("iop adma%d: %s len: %u flags: %#lx\n",
+	iop_chan->device->id, __FUNCTION__, len, flags);
+
+	switch (flags & (DMA_DEST_BUF | DMA_DEST_PAGE | DMA_DEST_DMA)) {
+	case DMA_DEST_BUF:
+		dest.dma = dma_map_single(&iop_chan->device->pdev->dev,
+			dest.buf, len, DMA_FROM_DEVICE);
+		break;
+	case DMA_DEST_PAGE:
+		dest.dma = dma_map_page(&iop_chan->device->pdev->dev,
+			dest.pg, dest_off, len, DMA_FROM_DEVICE);
+		break;
+	case DMA_DEST_DMA:
+		break;
+	default:
+		return -EFAULT;
+	}
+
+	spin_lock_bh(&iop_chan->lock);
+	slot_cnt = iop_chan_memset_slot_count(len, &slots_per_op);
+	sw_desc = iop_adma_alloc_slots(iop_chan, slot_cnt, slots_per_op);
+	if (sw_desc) {
+		iop_desc_init_memset(sw_desc);
+		iop_desc_set_byte_count(sw_desc, iop_chan, len);
+		iop_desc_set_block_fill_val(sw_desc, val);
+		iop_desc_set_dest_addr(sw_desc, iop_chan, dest.dma);
+
+		iop_chan_chain_desc(iop_chan, sw_desc);
+		iop_desc_assign_cookie(iop_chan, sw_desc);
+
+		sw_desc->flags = flags;
+		iop_chan->pending++;
+		ret = sw_desc->cookie;
+	}
+	spin_unlock_bh(&iop_chan->lock);
+
+	iop_adma_check_threshold(iop_chan);
+
+	return ret;
+}
+
+/**
+ * do_iop_adma_xor - xor from source pages to a dest page
+ * @chan: common channel handle
+ * @dest: DMAENGINE destination address
+ * @dest_off: offset into the destination page
+ * @src: DMAENGINE source addresses
+ * @src_cnt: number of source pages
+ * @src_off: offset into the source pages
+ * @len: transaction length in bytes
+ * @flags: DMAENGINE address type flags
+ */
+static dma_cookie_t do_iop_adma_xor(struct dma_chan *chan,
+					union dmaengine_addr dest,
+					unsigned int dest_off,
+					union dmaengine_addr src,
+					unsigned int src_cnt,
+					unsigned int src_off,
+					size_t len,
+					unsigned long flags)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	struct device *dev = &iop_chan->device->pdev->dev;
+	struct iop_adma_desc_slot *sw_desc;
+	dma_cookie_t ret = -ENOMEM;
+	int slot_cnt, slots_per_op;
+
+	if (!chan || !dest.dma || !src.dma_list)
+		return -EFAULT;
+
+	if (!len)
+		return iop_chan->common.cookie;
+
+	PRINTK("iop adma%d: %s src_cnt: %d len: %u flags: %lx\n",
+	iop_chan->device->id, __FUNCTION__, src_cnt, len, flags);
+
+	spin_lock_bh(&iop_chan->lock);
+	slot_cnt = iop_chan_xor_slot_count(len, src_cnt, &slots_per_op);
+	sw_desc = iop_adma_alloc_slots(iop_chan, slot_cnt, slots_per_op);
+	if (sw_desc) {
+		#ifdef CONFIG_ARCH_IOP32X
+		if ((flags & DMA_DEST_BUF) &&
+			dest.buf == (void *) iop32x_zero_result_buffer) {
+			PRINTK("%s: iop32x zero sum emulation requested\n",
+				__FUNCTION__);
+			sw_desc->xor_check_result = iop32x_zero_sum_output;
+		}
+		#endif
+
+		iop_desc_init_xor(sw_desc, src_cnt);
+		iop_desc_set_byte_count(sw_desc, iop_chan, len);
+
+		switch (flags & (DMA_DEST_BUF | DMA_DEST_PAGE |
+				DMA_DEST_PAGES | DMA_DEST_DMA |
+				DMA_DEST_DMA_LIST)) {
+		case DMA_DEST_PAGE:
+			dest.dma = dma_map_page(dev, dest.pg, dest_off, len,
+					DMA_FROM_DEVICE);
+			break;
+		case DMA_DEST_BUF:
+			dest.dma = dma_map_single(dev, dest.buf, len,
+					DMA_FROM_DEVICE);
+			break;
+		}
+
+		iop_desc_set_dest_addr(sw_desc, iop_chan, dest.dma);
+
+		switch (flags & (DMA_SRC_BUF | DMA_SRC_PAGE |
+				DMA_SRC_PAGES | DMA_SRC_DMA |
+				DMA_SRC_DMA_LIST)) {
+		case DMA_SRC_PAGES:
+			while (src_cnt--) {
+				dma_addr_t addr = dma_map_page(dev,
+							src.pgs[src_cnt],
+							src_off, len,
+							DMA_TO_DEVICE);
+				iop_desc_set_xor_src_addr(sw_desc,
+							src_cnt,
+							addr,
+							slot_cnt,
+							slots_per_op);
+			}
+			break;
+		case DMA_SRC_DMA_LIST:
+			while (src_cnt--) {
+				iop_desc_set_xor_src_addr(sw_desc,
+							src_cnt,
+							src.dma_list[src_cnt],
+							slot_cnt,
+							slots_per_op);
+			}
+			break;
+		}
+
+		iop_chan_chain_desc(iop_chan, sw_desc);
+		iop_desc_assign_cookie(iop_chan, sw_desc);
+
+		sw_desc->flags = flags;
+		iop_chan->pending++;
+		ret = sw_desc->cookie;
+	}
+	spin_unlock_bh(&iop_chan->lock);
+
+	iop_adma_check_threshold(iop_chan);
+
+	return ret;
+}
+
+/**
+ * do_iop_adma_zero_sum - xor the sources together and report whether
+ *				the sum is zero
+ * @chan: common channel handle
+ * @src: DMAENGINE source addresses
+ * @src_cnt: number of sources
+ * @src_off: offset into the sources
+ * @len: transaction length in bytes
+ * @flags: DMAENGINE address type flags
+ * @result: set to 1 if sum is zero else 0
+ */
+#ifndef CONFIG_ARCH_IOP32X
+static dma_cookie_t do_iop_adma_zero_sum(struct dma_chan *chan,
+					union dmaengine_addr src,
+					unsigned int src_cnt,
+					unsigned int src_off,
+					size_t len,
+					u32 *result,
+					unsigned long flags)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	struct iop_adma_desc_slot *sw_desc;
+	dma_cookie_t ret = -ENOMEM;
+	int slot_cnt, slots_per_op;
+
+	if (!chan || !src.dma_list || !result)
+		return -EFAULT;
+
+	if (!len)
+		return iop_chan->common.cookie;
+
+	PRINTK("iop adma%d: %s src_cnt: %d len: %u flags: %lx\n",
+	iop_chan->device->id, __FUNCTION__, src_cnt, len, flags);
+
+	spin_lock_bh(&iop_chan->lock);
+	slot_cnt = iop_chan_zero_sum_slot_count(len, src_cnt, &slots_per_op);
+	sw_desc = iop_adma_alloc_slots(iop_chan, slot_cnt, slots_per_op);
+	if (sw_desc) {
+		struct device *dev = &iop_chan->device->pdev->dev;
+		iop_chan->pending += iop_desc_init_zero_sum(sw_desc, src_cnt,
+					slot_cnt, slots_per_op);
+
+		switch (flags & (DMA_SRC_BUF | DMA_SRC_PAGE |
+				DMA_SRC_PAGES | DMA_SRC_DMA |
+				DMA_SRC_DMA_LIST)) {
+		case DMA_SRC_PAGES:
+			while (src_cnt--) {
+				dma_addr_t addr = dma_map_page(dev,
+						src.pgs[src_cnt],
+						src_off, len,
+						DMA_TO_DEVICE);
+				iop_desc_set_zero_sum_src_addr(sw_desc,
+						src_cnt,
+						addr,
+						slot_cnt,
+						slots_per_op);
+			}
+			break;
+		case DMA_SRC_DMA_LIST:
+			while (src_cnt--) {
+				iop_desc_set_zero_sum_src_addr(sw_desc,
+						src_cnt,
+						src.dma_list[src_cnt],
+						slot_cnt,
+						slots_per_op);
+			}
+			break;
+		}
+
+		iop_desc_set_zero_sum_byte_count(sw_desc, len, slots_per_op);
+
+		/* assign a cookie to the first descriptor so
+		 * the buffers are unmapped
+		 */
+		iop_desc_assign_cookie(iop_chan, sw_desc);
+		sw_desc->flags = flags;
+
+		/* assign cookie to the last descriptor in the group
+		 * so the xor_check_result is updated. Also, set the
+		 * xor_check_result ptr of the first and last descriptor
+		 * so the cleanup routine can sum the group of results
+		 */
+		if (slot_cnt > slots_per_op) {
+			struct iop_adma_desc_slot *desc;
+			desc = list_entry(iop_chan->chain.prev,
+				struct iop_adma_desc_slot,
+				chain_node);
+			iop_desc_assign_cookie(iop_chan, desc);
+			sw_desc->xor_check_result = result;
+			desc->xor_check_result = result;
+			ret = desc->cookie;
+		} else {
+			sw_desc->xor_check_result = result;
+			ret = sw_desc->cookie;
+		}
+
+		/* add the group to the chain */
+		iop_chan_chain_desc(iop_chan, sw_desc);
+	}
+	spin_unlock_bh(&iop_chan->lock);
+
+	iop_adma_check_threshold(iop_chan);
+
+	return ret;
+}
+#else
+/* iop32x does not support zero sum in hardware, so we simulate 
+ * it in software.  It only supports a PAGE_SIZE length which is
+ * enough to support md raid.
+ */
+static dma_cookie_t do_iop_adma_zero_sum(struct dma_chan *chan,
+					union dmaengine_addr src,
+					unsigned int src_cnt,
+					unsigned int src_off,
+					size_t len,
+					u32 *result,
+					unsigned long flags)
+{
+	static union dmaengine_addr dest_addr = { .buf = iop32x_zero_result_buffer };
+	static dma_cookie_t last_zero_result_cookie = 0;
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	dma_cookie_t ret;
+
+	if (!chan || !src.dma_list || !result)
+		return -EFAULT;
+
+	if (!len)
+		return iop_chan->common.cookie;
+
+	if (len > sizeof(iop32x_zero_result_buffer)) {
+		printk(KERN_ERR "iop32x performs zero sum with a %d byte buffer, %d"
+		  	" bytes is too large\n", sizeof(iop32x_zero_result_buffer),
+		  	len);
+		BUG();
+		return -EFAULT;
+	}
+
+	/* we only have 1 result buffer, it can not be shared */
+	if (last_zero_result_cookie) {
+		PRINTK("%s: waiting for last_zero_result_cookie: %d\n",
+			__FUNCTION__, last_zero_result_cookie);
+		dma_sync_wait(chan, last_zero_result_cookie);
+		last_zero_result_cookie = 0;
+	}
+
+	PRINTK("iop adma%d: %s src_cnt: %d len: %u flags: %lx\n",
+	iop_chan->device->id, __FUNCTION__, src_cnt, len, flags);
+
+	flags |= DMA_DEST_BUF;
+	iop32x_zero_sum_output = result;
+
+	ret = do_iop_adma_xor(chan, dest_addr, 0, src, src_cnt, src_off,
+				len, flags);
+
+	if (ret > 0)
+		last_zero_result_cookie = ret;
+
+	return ret;
+}
+#endif
+
+static void iop_adma_free_chan_resources(struct dma_chan *chan)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	struct iop_adma_desc_slot *iter, *_iter;
+	int in_use_descs = 0;
+
+	iop_adma_slot_cleanup(iop_chan);
+
+	spin_lock_bh(&iop_chan->lock);
+	list_for_each_entry_safe(iter, _iter, &iop_chan->chain,
+					chain_node) {
+		in_use_descs++;
+		list_del(&iter->chain_node);
+	}
+	list_for_each_entry_safe_reverse(iter, _iter, &iop_chan->all_slots, slot_node) {
+		list_del(&iter->slot_node);
+		kfree(iter);
+		iop_chan->slots_allocated--;
+	}
+	iop_chan->last_used = NULL;
+
+	PRINTK("iop adma%d %s slots_allocated %d\n", iop_chan->device->id,
+		__FUNCTION__, iop_chan->slots_allocated);
+	spin_unlock_bh(&iop_chan->lock);
+
+	/* one is ok since we left it on there on purpose */
+	if (in_use_descs > 1)
+		printk(KERN_ERR "IOP: Freeing %d in use descriptors!\n",
+			in_use_descs - 1);
+}
+
+/**
+ * iop_adma_is_complete - poll the status of an ADMA transaction
+ * @chan: ADMA channel handle
+ * @cookie: ADMA transaction identifier
+ */
+static enum dma_status iop_adma_is_complete(struct dma_chan *chan,
+                                            dma_cookie_t cookie,
+                                            dma_cookie_t *done,
+                                            dma_cookie_t *used)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	dma_cookie_t last_used;
+	dma_cookie_t last_complete;
+	enum dma_status ret;
+
+	last_used = chan->cookie;
+	last_complete = iop_chan->completed_cookie;
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
+	iop_adma_slot_cleanup(iop_chan);
+
+	last_used = chan->cookie;
+	last_complete = iop_chan->completed_cookie;
+
+	if (done)
+		*done= last_complete;
+	if (used)
+		*used = last_used;
+
+	return dma_async_is_complete(cookie, last_complete, last_used);
+}
+
+/* to do: can we use these interrupts to implement 'sleep until completed' */
+static irqreturn_t iop_adma_eot_handler(int irq, void *data, struct pt_regs *regs)
+{
+	return IRQ_NONE;
+}
+
+static irqreturn_t iop_adma_eoc_handler(int irq, void *data, struct pt_regs *regs)
+{
+	return IRQ_NONE;
+}
+
+static irqreturn_t iop_adma_err_handler(int irq, void *data, struct pt_regs *regs)
+{
+	return IRQ_NONE;
+}
+
+static void iop_adma_issue_pending(struct dma_chan *chan)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	spin_lock(&iop_chan->lock);
+	if (iop_chan->pending) {
+		iop_chan->pending = 0;
+		iop_chan_append(iop_chan);
+	}
+	spin_unlock(&iop_chan->lock);
+}
+
+/*
+ * Perform a transaction to verify the HW works.
+ */
+#define IOP_ADMA_TEST_SIZE 2000
+
+static int __devinit iop_adma_memcpy_self_test(struct iop_adma_device *device)
+{
+	int i;
+	union dmaengine_addr src;
+	union dmaengine_addr dest;
+	struct dma_chan *dma_chan;
+	dma_cookie_t cookie;
+	int err = 0;
+
+	src.buf = kzalloc(sizeof(u8) * IOP_ADMA_TEST_SIZE, SLAB_KERNEL);
+	if (!src.buf)
+		return -ENOMEM;
+	dest.buf = kzalloc(sizeof(u8) * IOP_ADMA_TEST_SIZE, SLAB_KERNEL);
+	if (!dest.buf) {
+		kfree(src.buf);
+		return -ENOMEM;
+	}
+
+	/* Fill in src buffer */
+	for (i = 0; i < IOP_ADMA_TEST_SIZE; i++)
+		((u8 *) src.buf)[i] = (u8)i;
+
+	memset(dest.buf, 0, IOP_ADMA_TEST_SIZE);
+
+	/* Start copy, using first DMA channel */
+	dma_chan = container_of(device->common.channels.next,
+	                        struct dma_chan,
+	                        device_node);
+	if (iop_adma_alloc_chan_resources(dma_chan) < 1) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	cookie = do_iop_adma_memcpy(dma_chan, dest, 0, src, 0,
+		IOP_ADMA_TEST_SIZE, DMA_SRC_BUF | DMA_DEST_BUF);
+	iop_adma_issue_pending(dma_chan);
+	msleep(1);
+
+	if (iop_adma_is_complete(dma_chan, cookie, NULL, NULL) != DMA_SUCCESS) {
+		printk(KERN_ERR "iop adma%d: Self-test copy timed out, disabling\n",
+			device->id);
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+	consistent_sync(dest.buf, IOP_ADMA_TEST_SIZE, DMA_FROM_DEVICE);
+	if (memcmp(src.buf, dest.buf, IOP_ADMA_TEST_SIZE)) {
+		printk(KERN_ERR "iop adma%d: Self-test copy failed compare, disabling\n",
+			device->id);
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+free_resources:
+	iop_adma_free_chan_resources(dma_chan);
+out:
+	kfree(src.buf);
+	kfree(dest.buf);
+	return err;
+}
+
+#define IOP_ADMA_NUM_SRC_TST 4 /* must be <= 15 */
+static int __devinit iop_adma_xor_zero_sum_self_test(struct iop_adma_device *device)
+{
+	int i, src_idx;
+	struct page *xor_srcs[IOP_ADMA_NUM_SRC_TST];
+	struct page *zero_sum_srcs[IOP_ADMA_NUM_SRC_TST + 1];
+	union dmaengine_addr dest;
+	union dmaengine_addr src;
+	struct dma_chan *dma_chan;
+	dma_cookie_t cookie;
+	u8 cmp_byte = 0;
+	u32 cmp_word;
+	u32 zero_sum_result;
+	int err = 0;
+
+	for (src_idx = 0; src_idx < IOP_ADMA_NUM_SRC_TST; src_idx++) {
+		xor_srcs[src_idx] = alloc_page(GFP_KERNEL);
+		if (!xor_srcs[src_idx])
+			while (src_idx--) {
+				__free_page(xor_srcs[src_idx]);
+				return -ENOMEM;
+			}
+	}
+
+	dest.pg = alloc_page(GFP_KERNEL);
+	if (!dest.pg)
+		while (src_idx--) {
+			__free_page(xor_srcs[src_idx]);
+			return -ENOMEM;
+		}
+
+	/* Fill in src buffers */
+	for (src_idx = 0; src_idx < IOP_ADMA_NUM_SRC_TST; src_idx++) {
+		u8 *ptr = page_address(xor_srcs[src_idx]);
+		for (i = 0; i < PAGE_SIZE; i++)
+			ptr[i] = (1 << src_idx);
+	}
+
+	for (src_idx = 0; src_idx < IOP_ADMA_NUM_SRC_TST; src_idx++)
+		cmp_byte ^= (u8) (1 << src_idx);
+
+	cmp_word = (cmp_byte << 24) | (cmp_byte << 16) | (cmp_byte << 8) | cmp_byte;
+
+	memset(page_address(dest.pg), 0, PAGE_SIZE);
+
+	dma_chan = container_of(device->common.channels.next,
+	                        struct dma_chan,
+	                        device_node);
+	if (iop_adma_alloc_chan_resources(dma_chan) < 1) {
+		err = -ENODEV;
+		goto out;
+	}
+
+	/* test xor */
+	src.pgs = xor_srcs;
+	cookie = do_iop_adma_xor(dma_chan, dest, 0, src,
+		IOP_ADMA_NUM_SRC_TST, 0, PAGE_SIZE, DMA_DEST_PAGE | DMA_SRC_PAGES);
+	iop_adma_issue_pending(dma_chan);
+	msleep(8);
+
+	if (iop_adma_is_complete(dma_chan, cookie, NULL, NULL) != DMA_SUCCESS) {
+		printk(KERN_ERR "iop_adma: Self-test xor timed out, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+	consistent_sync(page_address(dest.pg), PAGE_SIZE, DMA_FROM_DEVICE);
+	for (i = 0; i < (PAGE_SIZE / sizeof(u32)); i++) {
+		u32 *ptr = page_address(dest.pg);
+		if (ptr[i] != cmp_word) {
+			printk(KERN_ERR "iop_adma: Self-test xor failed compare, disabling\n");
+			err = -ENODEV;
+			goto free_resources;
+		}
+	}
+
+	/* zero sum the sources with the destintation page */
+	for (i = 0; i < IOP_ADMA_NUM_SRC_TST; i++)
+		zero_sum_srcs[i] = xor_srcs[i];
+	zero_sum_srcs[i] = dest.pg;
+	src.pgs = zero_sum_srcs;
+
+	zero_sum_result = 1;
+	cookie = do_iop_adma_zero_sum(dma_chan, src, IOP_ADMA_NUM_SRC_TST + 1,
+				0, PAGE_SIZE, &zero_sum_result, DMA_SRC_PAGES);
+	iop_adma_issue_pending(dma_chan);
+	msleep(8);
+
+	if (iop_adma_is_complete(dma_chan, cookie, NULL, NULL) != DMA_SUCCESS) {
+		printk(KERN_ERR "iop_adma: Self-test zero sum timed out, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+	if (zero_sum_result != 0) {
+		printk(KERN_ERR "iop_adma: Self-test zero sum failed compare, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+	/* test memset */
+	cookie = do_iop_adma_memset(dma_chan, dest, 0, 0, PAGE_SIZE, DMA_DEST_PAGE);
+	iop_adma_issue_pending(dma_chan);
+	msleep(8);
+
+	if (iop_adma_is_complete(dma_chan, cookie, NULL, NULL) != DMA_SUCCESS) {
+		printk(KERN_ERR "iop_adma: Self-test memset timed out, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+	consistent_sync(page_address(dest.pg), PAGE_SIZE, DMA_FROM_DEVICE);
+	for (i = 0; i < PAGE_SIZE/sizeof(u32); i++) {
+		u32 *ptr = page_address(dest.pg);
+		if (ptr[i]) {
+			printk(KERN_ERR "iop_adma: Self-test memset failed compare, disabling\n");
+			err = -ENODEV;
+			goto free_resources;
+		}
+	}
+
+	/* test for non-zero parity sum */
+	zero_sum_result = 0;
+	cookie = do_iop_adma_zero_sum(dma_chan, src, IOP_ADMA_NUM_SRC_TST + 1,
+				0, PAGE_SIZE, &zero_sum_result, DMA_SRC_PAGES);
+	iop_adma_issue_pending(dma_chan);
+	msleep(8);
+
+	if (iop_adma_is_complete(dma_chan, cookie, NULL, NULL) != DMA_SUCCESS) {
+		printk(KERN_ERR "iop_adma: Self-test non-zero sum timed out, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+	if (zero_sum_result != 1) {
+		printk(KERN_ERR "iop_adma: Self-test non-zero sum failed compare, disabling\n");
+		err = -ENODEV;
+		goto free_resources;
+	}
+
+free_resources:
+	iop_adma_free_chan_resources(dma_chan);
+out:
+	src_idx = IOP_ADMA_NUM_SRC_TST;
+	while (src_idx--)
+		__free_page(xor_srcs[src_idx]);
+	__free_page(dest.pg);
+	return err;
+}
+
+static int __devexit iop_adma_remove(struct platform_device *dev)
+{
+	struct iop_adma_device *device = platform_get_drvdata(dev);
+	struct dma_chan *chan, *_chan;
+	struct iop_adma_chan *iop_chan;
+	int i;
+	struct iop_adma_platform_data *plat_data = dev->dev.platform_data;
+
+
+	dma_async_device_unregister(&device->common);
+
+	for (i = 0; i < 3; i++) {
+		unsigned int irq;
+		irq = platform_get_irq(dev, i);
+		free_irq(irq, device);
+	}
+
+	dma_free_coherent(&dev->dev, plat_data->pool_size,
+			device->dma_desc_pool_virt, device->dma_desc_pool);
+
+	do {
+		struct resource *res;
+		res = platform_get_resource(dev, IORESOURCE_MEM, 0);
+		release_mem_region(res->start, res->end - res->start);
+	} while (0);
+
+	list_for_each_entry_safe(chan, _chan, &device->common.channels,
+				device_node) {
+		iop_chan = to_iop_adma_chan(chan);
+		list_del(&chan->device_node);
+		kfree(iop_chan);
+	}
+	kfree(device);
+
+	return 0;
+}
+
+static dma_addr_t iop_adma_map_page(struct dma_chan *chan, struct page *page,
+					unsigned long offset, size_t size,
+					int direction)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	return dma_map_page(&iop_chan->device->pdev->dev, page, offset, size,
+			direction);
+}
+
+static dma_addr_t iop_adma_map_single(struct dma_chan *chan, void *cpu_addr,
+					size_t size, int direction)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	return dma_map_single(&iop_chan->device->pdev->dev, cpu_addr, size,
+			direction);
+}
+
+static void iop_adma_unmap_page(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	dma_unmap_page(&iop_chan->device->pdev->dev, handle, size, direction);
+}
+
+static void iop_adma_unmap_single(struct dma_chan *chan, dma_addr_t handle,
+				size_t size, int direction)
+{
+	struct iop_adma_chan *iop_chan = to_iop_adma_chan(chan);
+	dma_unmap_single(&iop_chan->device->pdev->dev, handle, size, direction);
+}
+
+extern dma_cookie_t dma_async_do_memcpy_err(struct dma_chan *chan,
+		union dmaengine_addr dest, unsigned int dest_off,
+		union dmaengine_addr src, unsigned int src_off,
+                size_t len, unsigned long flags);
+
+extern dma_cookie_t dma_async_do_xor_err(struct dma_chan *chan,
+		union dmaengine_addr dest, unsigned int dest_off,
+		union dmaengine_addr src, unsigned int src_cnt,
+		unsigned int src_off, size_t len, unsigned long flags);
+
+extern dma_cookie_t dma_async_do_zero_sum_err(struct dma_chan *chan,
+		union dmaengine_addr src, unsigned int src_cnt,
+		unsigned int src_off, size_t len, u32 *result,
+		unsigned long flags);
+
+extern dma_cookie_t dma_async_do_memset_err(struct dma_chan *chan,
+                union dmaengine_addr dest, unsigned int dest_off,
+                int val, size_t len, unsigned long flags);
+
+static int __devinit iop_adma_probe(struct platform_device *pdev)
+{
+	struct resource *res;
+	int ret=0, irq_eot=0, irq_eoc=0, irq_err=0, irq, i;
+	struct iop_adma_device *adev;
+	struct iop_adma_chan *iop_chan;
+	struct iop_adma_platform_data *plat_data = pdev->dev.platform_data;
+
+	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
+	if (!res)
+		return -ENODEV;
+
+	if (!request_mem_region(res->start, res->end - res->start, pdev->name))
+		return -EBUSY;
+
+	if ((adev = kzalloc(sizeof(*adev), GFP_KERNEL)) == NULL) {
+		ret = -ENOMEM;
+		goto err_adev_alloc;
+	}
+
+	if ((adev->dma_desc_pool_virt = dma_alloc_writecombine(&pdev->dev,
+					plat_data->pool_size,
+					&adev->dma_desc_pool,
+					GFP_KERNEL)) == NULL) {
+		ret = -ENOMEM;
+		goto err_dma_alloc;
+	}
+
+	PRINTK("%s: allocted descriptor pool virt %p phys %p\n",
+	__FUNCTION__, adev->dma_desc_pool_virt, (void *) adev->dma_desc_pool);
+
+	adev->id = plat_data->hw_id;
+	adev->common.capabilities = plat_data->capabilities;
+
+	for (i = 0; i < 3; i++) {
+		irq = platform_get_irq(pdev, i);
+		if (irq < 0)
+			ret = -ENXIO;
+		else {
+			switch (i) {
+			case 0:
+				irq_eot = irq;
+				ret = request_irq(irq, iop_adma_eot_handler,
+					 0, pdev->name, adev);
+				if (ret) {
+					ret = -EIO;
+					goto err_irq0;
+				}
+				break;
+			case 1:
+				irq_eoc = irq;
+				ret = request_irq(irq, iop_adma_eoc_handler,
+					0, pdev->name, adev);
+				if (ret) {
+					ret = -EIO;
+					goto err_irq1;
+				}
+				break;
+			case 2:
+				irq_err = irq;
+				ret = request_irq(irq, iop_adma_err_handler,
+					0, pdev->name, adev);
+				if (ret) {
+					ret = -EIO;
+					goto err_irq2;
+				}
+				break;
+			}
+		}
+	}
+
+	adev->pdev = pdev;
+	platform_set_drvdata(pdev, adev);
+
+	INIT_LIST_HEAD(&adev->common.channels);
+	adev->common.device_alloc_chan_resources = iop_adma_alloc_chan_resources;
+	adev->common.device_free_chan_resources = iop_adma_free_chan_resources;
+	adev->common.device_operation_complete = iop_adma_is_complete;
+	adev->common.device_issue_pending = iop_adma_issue_pending;
+	adev->common.map_page = iop_adma_map_page;
+	adev->common.map_single = iop_adma_map_single;
+	adev->common.unmap_page = iop_adma_unmap_page;
+	adev->common.unmap_single = iop_adma_unmap_single;
+
+	if (adev->common.capabilities & DMA_MEMCPY)
+		adev->common.device_do_dma_memcpy = do_iop_adma_memcpy;
+	else
+		adev->common.device_do_dma_memcpy = dma_async_do_memcpy_err;
+
+	if (adev->common.capabilities & DMA_MEMSET)
+		adev->common.device_do_dma_memset = do_iop_adma_memset;
+	else
+		adev->common.device_do_dma_memset = dma_async_do_memset_err;
+
+	if (adev->common.capabilities & DMA_XOR)
+		adev->common.device_do_dma_xor = do_iop_adma_xor;
+	else
+		adev->common.device_do_dma_xor = dma_async_do_xor_err;
+
+	if (adev->common.capabilities & DMA_ZERO_SUM)
+		adev->common.device_do_dma_zero_sum = do_iop_adma_zero_sum;
+	else
+		adev->common.device_do_dma_zero_sum = dma_async_do_zero_sum_err;
+
+	if ((iop_chan = kzalloc(sizeof(*iop_chan), GFP_KERNEL)) == NULL) {
+		ret = -ENOMEM;
+		goto err_chan_alloc;
+	}
+
+	spin_lock_init(&iop_chan->lock);
+	iop_chan->device = adev;
+	INIT_LIST_HEAD(&iop_chan->chain);
+	INIT_LIST_HEAD(&iop_chan->all_slots);
+	iop_chan->last_used = NULL;
+	dma_async_chan_init(&iop_chan->common, &adev->common);
+
+	if (adev->common.capabilities & DMA_MEMCPY) {
+		ret = iop_adma_memcpy_self_test(adev);
+		PRINTK("iop adma%d: memcpy self test returned %d\n", adev->id, ret);
+		if (ret)
+			goto err_self_test;
+	}
+
+	if (adev->common.capabilities & (DMA_XOR + DMA_ZERO_SUM + DMA_MEMSET)) {
+		ret = iop_adma_xor_zero_sum_self_test(adev);
+		PRINTK("iop adma%d: xor self test returned %d\n", adev->id, ret);
+		if (ret)
+			goto err_self_test;
+	}
+
+	printk(KERN_INFO "Intel(R) IOP ADMA Engine found [%d]: "
+		"( %s%s%s%s%s%s%s%s%s)\n",
+		adev->id,
+		adev->common.capabilities & DMA_PQ_XOR	      ? "pq_xor " : "",
+		adev->common.capabilities & DMA_PQ_UPDATE     ? "pq_update " : "",
+		adev->common.capabilities & DMA_PQ_ZERO_SUM   ? "pq_zero_sum " : "",
+		adev->common.capabilities & DMA_XOR	      ? "xor " : "",
+		adev->common.capabilities & DMA_DUAL_XOR      ? "dual_xor " : "",
+		adev->common.capabilities & DMA_ZERO_SUM      ? "xor_zero_sum " : "",
+		adev->common.capabilities & DMA_MEMSET	      ? "memset " : "",
+		adev->common.capabilities & DMA_MEMCPY_CRC32C ? "memcpy+crc " : "",
+		adev->common.capabilities & DMA_MEMCPY	      ? "memcpy " : "");
+
+	dma_async_device_register(&adev->common);
+	goto out;
+
+err_self_test:
+	kfree(iop_chan);
+err_chan_alloc:
+err_irq2:
+	free_irq(irq_eoc, adev);
+err_irq1:
+	free_irq(irq_eot, adev);
+err_irq0:
+	dma_free_coherent(&adev->pdev->dev, plat_data->pool_size,
+			adev->dma_desc_pool_virt, adev->dma_desc_pool);
+err_dma_alloc:
+	kfree(adev);
+err_adev_alloc:
+	release_mem_region(res->start, res->end - res->start);
+out:
+	return ret;
+}
+
+static void iop_chan_start_null_memcpy(struct iop_adma_chan *iop_chan)
+{
+	struct iop_adma_desc_slot *sw_desc;
+	dma_cookie_t cookie;
+	int slot_cnt, slots_per_op;
+
+	spin_lock_bh(&iop_chan->lock);
+	slot_cnt = iop_chan_memcpy_slot_count(0, &slots_per_op);
+	sw_desc = iop_adma_alloc_slots(iop_chan, slot_cnt, slots_per_op);
+	if (sw_desc) {
+		iop_desc_init_memcpy(sw_desc);
+		iop_desc_set_byte_count(sw_desc, iop_chan, 0);
+		iop_desc_set_dest_addr(sw_desc, iop_chan, 0);
+		iop_desc_set_memcpy_src_addr(sw_desc, 0, slot_cnt, slots_per_op);
+
+		cookie = iop_chan->common.cookie;
+		cookie++;
+		if (cookie <= 1)
+			cookie = 2;
+
+		/* initialize the completed cookie to be less than
+		 * the most recently used cookie
+		 */
+		iop_chan->completed_cookie = cookie - 1;
+		iop_chan->common.cookie = sw_desc->cookie = cookie;
+
+		/* channel should not be busy */
+		BUG_ON(iop_chan_is_busy(iop_chan));
+
+		/* clear any prior error-status bits */
+		iop_chan_clear_status(iop_chan);
+
+		/* disable operation */
+		iop_chan_disable(iop_chan);
+
+		/* set the descriptor address */
+		iop_chan_set_next_descriptor(iop_chan, sw_desc->phys);
+
+		/* run the descriptor */
+		iop_chan_enable(iop_chan);
+	} else
+		printk(KERN_ERR "iop adma%d failed to allocate null descriptor\n",
+			iop_chan->device->id);
+	spin_unlock_bh(&iop_chan->lock);
+}
+
+static void iop_chan_start_null_xor(struct iop_adma_chan *iop_chan)
+{
+	struct iop_adma_desc_slot *sw_desc;
+	dma_cookie_t cookie;
+	int slot_cnt, slots_per_op;
+
+	spin_lock_bh(&iop_chan->lock);
+	slot_cnt = iop_chan_xor_slot_count(0, 2, &slots_per_op);
+	sw_desc = iop_adma_alloc_slots(iop_chan, slot_cnt, slots_per_op);
+	if (sw_desc) {
+		iop_desc_init_null_xor(sw_desc, 2);
+		iop_desc_set_byte_count(sw_desc, iop_chan, 0);
+		iop_desc_set_dest_addr(sw_desc, iop_chan, 0);
+		iop_desc_set_xor_src_addr(sw_desc, 0, 0, slot_cnt, slots_per_op);
+		iop_desc_set_xor_src_addr(sw_desc, 1, 0, slot_cnt, slots_per_op);
+
+		cookie = iop_chan->common.cookie;
+		cookie++;
+		if (cookie <= 1)
+			cookie = 2;
+
+		/* initialize the completed cookie to be less than
+		 * the most recently used cookie
+		 */
+		iop_chan->completed_cookie = cookie - 1;
+		iop_chan->common.cookie = sw_desc->cookie = cookie;
+
+		/* channel should not be busy */
+		BUG_ON(iop_chan_is_busy(iop_chan));
+
+		/* clear any prior error-status bits */
+		iop_chan_clear_status(iop_chan);
+
+		/* disable operation */
+		iop_chan_disable(iop_chan);
+
+		/* set the descriptor address */
+		iop_chan_set_next_descriptor(iop_chan, sw_desc->phys);
+
+		/* run the descriptor */
+		iop_chan_enable(iop_chan);
+	} else
+		printk(KERN_ERR "iop adma%d failed to allocate null descriptor\n",
+			iop_chan->device->id);
+	spin_unlock_bh(&iop_chan->lock);
+}
+
+static struct platform_driver iop_adma_driver = {
+	.probe		= iop_adma_probe,
+	.remove		= iop_adma_remove,
+	.driver		= {
+		.owner	= THIS_MODULE,
+		.name	= "IOP-ADMA",
+	},
+};
+
+static int __init iop_adma_init (void)
+{
+	return platform_driver_register(&iop_adma_driver);
+}
+
+static void __exit iop_adma_exit (void)
+{
+	platform_driver_unregister(&iop_adma_driver);
+	return;
+}
+
+void __arch_raid5_dma_chan_request(struct dma_client *client)
+{
+	iop_raid5_dma_chan_request(client);
+}
+
+struct dma_chan *__arch_raid5_dma_next_channel(struct dma_client *client)
+{
+	return iop_raid5_dma_next_channel(client);
+}
+
+struct dma_chan *__arch_raid5_dma_check_channel(struct dma_chan *chan,
+						dma_cookie_t cookie,
+						struct dma_client *client,
+						unsigned long capabilities)
+{
+	return iop_raid5_dma_check_channel(chan, cookie, client, capabilities);
+}
+
+EXPORT_SYMBOL_GPL(__arch_raid5_dma_chan_request);
+EXPORT_SYMBOL_GPL(__arch_raid5_dma_next_channel);
+EXPORT_SYMBOL_GPL(__arch_raid5_dma_check_channel);
+
+module_init(iop_adma_init);
+module_exit(iop_adma_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("IOP ADMA Engine Driver");
+MODULE_LICENSE("GPL");
diff --git a/include/asm-arm/hardware/iop_adma.h b/include/asm-arm/hardware/iop_adma.h
new file mode 100644
index 0000000..62bbbdf
--- /dev/null
+++ b/include/asm-arm/hardware/iop_adma.h
@@ -0,0 +1,98 @@
+/*
+ * Copyright(c) 2006 Intel Corporation. All rights reserved.
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
+#ifndef IOP_ADMA_H
+#define IOP_ADMA_H
+#include <linux/types.h>
+#include <linux/dmaengine.h>
+
+#define IOP_ADMA_SLOT_SIZE 32
+#define IOP_ADMA_THRESHOLD 20
+
+/**
+ * struct iop_adma_device - internal representation of an ADMA device
+ * @pdev: Platform device
+ * @id: HW ADMA Device selector
+ * @dma_desc_pool: base of DMA descriptor region (DMA address)
+ * @dma_desc_pool_virt: base of DMA descriptor region (CPU address)
+ * @common: embedded struct dma_device
+ */
+struct iop_adma_device {
+	struct platform_device *pdev;
+	int id;
+	dma_addr_t dma_desc_pool;
+	void *dma_desc_pool_virt;
+	struct dma_device common;
+};
+
+/**
+ * struct iop_adma_device - internal representation of an ADMA device
+ * @lock: serializes enqueue/dequeue operations to the slot pool
+ * @device: parent device
+ * @chain: device chain view of the descriptors
+ * @common: common dmaengine channel object members
+ * @all_slots: complete domain of slots usable by the channel
+ * @pending: allows batching of hardware operations
+ * @result_accumulator: allows zero result sums of buffers > the hw maximum
+ * @zero_sum_group: flag to the clean up routine to collect zero sum results
+ * @completed_cookie: identifier for the most recently completed operation
+ * @slots_allocated: records the actual size of the descriptor slot pool
+ */
+struct iop_adma_chan {
+	spinlock_t lock;
+	struct iop_adma_device *device;
+	struct list_head chain;
+	struct dma_chan common;
+	struct list_head all_slots;
+	struct iop_adma_desc_slot *last_used;
+	int pending;
+	u8 result_accumulator;
+	u8 zero_sum_group;
+	dma_cookie_t completed_cookie;
+	int slots_allocated;
+};
+
+struct iop_adma_desc_slot {
+	void *hw_desc;
+	struct list_head slot_node;
+	struct list_head chain_node;
+	dma_cookie_t cookie;
+	dma_addr_t phys;
+	u16 stride;
+	u16 idx;
+	u16 slot_cnt;
+	u8 src_cnt;
+	u8 slots_per_op;
+	unsigned long flags;
+	union {
+		u32 *xor_check_result;
+		u32 *crc32_result;
+	};
+};
+
+struct iop_adma_platform_data {
+        int hw_id;
+        unsigned long capabilities;
+        size_t pool_size;
+};
+
+#define to_iop_sw_desc(addr_hw_desc) container_of(addr_hw_desc, struct iop_adma_desc_slot, hw_desc)
+#define iop_hw_desc_slot_idx(hw_desc, idx) ( (void *) (((unsigned long) hw_desc) + ((idx) << 5)) )
+#endif
