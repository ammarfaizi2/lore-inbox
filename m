Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1031321AbWK3UKU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031321AbWK3UKU (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 30 Nov 2006 15:10:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1031318AbWK3UKU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 30 Nov 2006 15:10:20 -0500
Received: from mga02.intel.com ([134.134.136.20]:40101 "EHLO mga02.intel.com")
	by vger.kernel.org with ESMTP id S1031295AbWK3UKO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 30 Nov 2006 15:10:14 -0500
X-ExtLoop1: 1
X-IronPort-AV: i="4.09,481,1157353200"; 
   d="scan'208"; a="168614663:sNHT435216327"
From: Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 02/12] dmaengine: add the async_tx api
Date: Thu, 30 Nov 2006 13:10:10 -0700
To: neilb@suse.de, jeff@garzik.org, christopher.leech@intel.com, akpm@osdl.org
Cc: linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org, olof@lixom.net
Message-Id: <20061130201010.21313.53627.stgit@dwillia2-linux.ch.intel.com>
In-Reply-To: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
References: <e9c3a7c20611301155p4069c642j276d7705b0f81447@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=fixed
Content-Transfer-Encoding: 8bit
User-Agent: StGIT/0.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dan Williams <dan.j.williams@intel.com>

async_tx is an api to describe a series of bulk memory
transfers/transforms.  When possible these transactions are carried out by
asynchrounous dma engines.  The api handles inter-transaction dependencies
and hides dma channel management from the client.  When a dma engine is not
present the transaction is carried out via synchronous software routines.

Xor operations are handled by async_tx, to this end xor.c is moved into
drivers/dma and is changed to take an explicit destination address and
a series of sources to match the hardware engine implementation.

When CONFIG_DMA_ENGINE is not set the asynchrounous path is compiled away.

Signed-off-by: Dan Williams <dan.j.williams@intel.com>
---

 drivers/Makefile         |    3 
 drivers/dma/Kconfig      |   16 +
 drivers/dma/Makefile     |    1 
 drivers/dma/async_tx.c   |  921 ++++++++++++++++++++++++++++++++++++++++++++++
 drivers/dma/xor.c        |  153 ++++++++
 drivers/md/Kconfig       |    2 
 drivers/md/Makefile      |    6 
 drivers/md/raid5.c       |   18 -
 drivers/md/xor.c         |  154 --------
 include/linux/async_tx.h |  181 +++++++++
 include/linux/raid/xor.h |    5 
 11 files changed, 1287 insertions(+), 173 deletions(-)

diff --git a/drivers/Makefile b/drivers/Makefile
index 4ac14da..8b2460d 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -60,7 +60,6 @@ obj-$(CONFIG_I2C)		+= i2c/
 obj-$(CONFIG_W1)		+= w1/
 obj-$(CONFIG_HWMON)		+= hwmon/
 obj-$(CONFIG_PHONE)		+= telephony/
-obj-$(CONFIG_MD)		+= md/
 obj-$(CONFIG_BT)		+= bluetooth/
 obj-$(CONFIG_ISDN)		+= isdn/
 obj-$(CONFIG_EDAC)		+= edac/
@@ -77,3 +76,5 @@ obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
 obj-$(CONFIG_GENERIC_TIME)	+= clocksource/
 obj-$(CONFIG_DMA_ENGINE)	+= dma/
+obj-$(CONFIG_ASYNC_TX_DMA)	+= dma/
+obj-$(CONFIG_MD)                += md/
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
index 30d021d..c82ed5f 100644
--- a/drivers/dma/Kconfig
+++ b/drivers/dma/Kconfig
@@ -7,8 +7,8 @@ menu "DMA Engine support"
 config DMA_ENGINE
 	bool "Support for DMA engines"
 	---help---
-	  DMA engines offload copy operations from the CPU to dedicated
-	  hardware, allowing the copies to happen asynchronously.
+          DMA engines offload bulk memory operations from the CPU to dedicated
+          hardware, allowing the operations to happen asynchronously.
 
 comment "DMA Clients"
 
@@ -22,6 +22,17 @@ config NET_DMA
 	  Since this is the main user of the DMA engine, it should be enabled;
 	  say Y here.
 
+config ASYNC_TX_DMA
+	tristate "Asynchronous Bulk Memory Transfers/Transforms API"
+	default y
+	---help---
+	  This enables the async_tx management layer for dma engines.
+	  Subsystems coded to this API will use offload engines for bulk
+	  memory operations where present.  Software implementations are
+	  called when a dma engine is not present or fails to allocate
+	  memory to carry out the transaction.
+	  Current subsystems ported to async_tx: MD_RAID4,5
+
 comment "DMA Devices"
 
 config INTEL_IOATDMA
@@ -30,5 +41,4 @@ config INTEL_IOATDMA
 	default m
 	---help---
 	  Enable support for the Intel(R) I/OAT DMA engine.
-
 endmenu
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
index bdcfdbd..6a99341 100644
--- a/drivers/dma/Makefile
+++ b/drivers/dma/Makefile
@@ -1,3 +1,4 @@
 obj-$(CONFIG_DMA_ENGINE) += dmaengine.o
 obj-$(CONFIG_NET_DMA) += iovlock.o
 obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
+obj-$(CONFIG_ASYNC_TX_DMA) += async_tx.o xor.o
diff --git a/drivers/dma/async_tx.c b/drivers/dma/async_tx.c
new file mode 100644
index 0000000..00f72c0
--- /dev/null
+++ b/drivers/dma/async_tx.c
@@ -0,0 +1,921 @@
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
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/dma-mapping.h>
+#include <linux/raid/xor.h>
+#include <linux/async_tx.h>
+
+#define ASYNC_TX_DEBUG 0
+#define PRINTK(x...) ((void)(ASYNC_TX_DEBUG && printk(x)))
+
+#ifdef CONFIG_DMA_ENGINE
+static struct dma_client *async_api_client;
+static struct async_channel_entry async_channel_directory[] = {
+	[DMA_MEMCPY] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_MEMCPY].list), },
+	[DMA_XOR] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_XOR].list), },
+	[DMA_PQ_XOR] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_PQ_XOR].list), },
+	[DMA_DUAL_XOR] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_DUAL_XOR].list), },
+	[DMA_PQ_UPDATE] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_PQ_UPDATE].list), },
+	[DMA_ZERO_SUM] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_ZERO_SUM].list), },
+	[DMA_PQ_ZERO_SUM] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_PQ_ZERO_SUM].list), },
+	[DMA_MEMSET] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_MEMSET].list), },
+	[DMA_MEMCPY_CRC32C] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_MEMCPY_CRC32C].list), },
+	[DMA_INTERRUPT] = { .list =
+		LIST_HEAD_INIT(async_channel_directory[DMA_INTERRUPT].list), },
+};
+
+struct async_channel_entry async_tx_master_list = {
+	.list = LIST_HEAD_INIT(async_tx_master_list.list),
+};
+EXPORT_SYMBOL_GPL(async_tx_master_list);
+
+static void
+free_dma_chan_ref(struct rcu_head *rcu)
+{
+	struct dma_chan_ref *ref;
+	ref = container_of(rcu, struct dma_chan_ref, rcu);
+	dma_chan_put(ref->chan);
+	kfree(ref);
+}
+
+static inline void
+init_dma_chan_ref(struct dma_chan_ref *ref, struct dma_chan *chan)
+{
+	INIT_LIST_HEAD(&ref->async_node);
+	INIT_RCU_HEAD(&ref->rcu);
+	ref->chan = chan;
+}
+
+static void
+dma_channel_add_remove(struct dma_client *client,
+	struct dma_chan *chan, enum dma_event event)
+{
+	unsigned long i, flags;
+	struct dma_chan_ref *master_ref, *ref;
+	struct async_channel_entry *channel_entry;
+
+	switch (event) {
+	case DMA_RESOURCE_ADDED:
+		PRINTK("async_tx: dma resource added (capabilities: %#lx)\n",
+			chan->device->capabilities);
+		/* add the channel to the generic management list */
+		master_ref = kmalloc(sizeof(*master_ref), GFP_KERNEL);
+		if (master_ref) {
+			/* keep a reference until async_tx is unloaded */
+			dma_chan_get(chan);
+			init_dma_chan_ref(master_ref, chan);
+			spin_lock_irqsave(&async_tx_master_list.lock, flags);
+			list_add_tail_rcu(&master_ref->async_node,
+				&async_tx_master_list.list);
+			spin_unlock_irqrestore(&async_tx_master_list.lock,
+				flags);
+		} else {
+			printk(KERN_WARNING "async_tx: unable to create"
+				" new master entry in response to"
+				" a DMA_RESOURCE_ADDED event"
+				" (-ENOMEM)\n");
+			return;
+		}
+
+		/* add an entry for each capability of this channel */
+		dma_async_for_each_tx_type(i) {
+			if (test_bit(i, &chan->device->capabilities))
+				ref = kmalloc(sizeof(*ref), GFP_KERNEL);
+			else
+				continue;
+
+			if (ref) {
+				channel_entry = &async_channel_directory[i];
+				init_dma_chan_ref(ref, chan);
+				spin_lock_irqsave(&channel_entry->lock, flags);
+				atomic_inc(&channel_entry->version);
+				list_add_tail_rcu(&ref->async_node,
+					&channel_entry->list);
+				spin_unlock_irqrestore(&channel_entry->lock,
+					flags);
+			} else {
+				printk(KERN_WARNING "async_tx: unable to create"
+					" new op-specific entry in response to"
+					" a DMA_RESOURCE_ADDED event"
+					" (-ENOMEM)\n");
+				return;
+			}
+		}
+		break;
+	case DMA_RESOURCE_REMOVED:
+		PRINTK("async_tx: dma resource removed (capabilities: %#lx)\n",
+			chan->device->capabilities);
+		dma_async_for_each_tx_type(i) {
+			if (!test_bit(i, &chan->device->capabilities))
+				continue;
+
+			channel_entry = &async_channel_directory[i];
+
+			spin_lock_irqsave(&channel_entry->lock, flags);
+			list_for_each_entry_rcu(ref, &channel_entry->list,
+				async_node) {
+				if (ref->chan == chan) {
+					atomic_inc(&channel_entry->version);
+					list_del_rcu(&ref->async_node);
+					call_rcu(&ref->rcu, free_dma_chan_ref);
+					break;
+				}
+			}
+			spin_unlock_irqrestore(&channel_entry->lock, flags);
+		}
+		break;
+	case DMA_RESOURCE_SUSPEND:
+	case DMA_RESOURCE_RESUME:
+		printk(KERN_WARNING "async_tx: does not support dma channel"
+			" suspend/resume\n");
+		break;
+	default:
+		BUG();
+	}
+}
+
+static int __init
+async_tx_init(void)
+{
+	unsigned long i;
+	struct async_channel_entry *channel_entry;
+	int cpu;
+
+	spin_lock_init(&async_tx_master_list.lock);
+
+	dma_async_for_each_tx_type(i) {
+		channel_entry = &async_channel_directory[i];
+		spin_lock_init(&channel_entry->lock);
+		channel_entry->local_iter = alloc_percpu(struct async_iter_percpu);
+		if (!channel_entry->local_iter) {
+			i++;
+			goto err;
+		}
+
+		atomic_set(&channel_entry->version, 0);
+
+		for_each_possible_cpu(cpu) {
+			struct async_iter_percpu *local_iter =
+				channel_entry->local_iter;
+			per_cpu_ptr(local_iter, cpu)->iter = &channel_entry->list;
+			per_cpu_ptr(local_iter, cpu)->local_version = 0;
+		}
+	}
+
+	async_api_client = dma_async_client_register(dma_channel_add_remove);
+
+	if (!async_api_client)
+		goto err;
+
+	dma_async_client_chan_request(async_api_client, DMA_CHAN_REQUEST_ALL);
+
+	printk("async_tx: api initialized (async)\n");
+
+	return 0;
+err:
+	printk("async_tx: initialization failure\n");
+
+	while (--i >= 0)
+		free_percpu(async_channel_directory[i].local_iter);
+
+	return 1;
+}
+
+static void __exit async_tx_exit(void)
+{
+	unsigned long i, flags;
+	struct async_channel_entry *channel_entry;
+	struct dma_chan_ref *ref;
+
+	if (async_api_client)
+		dma_async_client_unregister(async_api_client);
+
+	dma_async_for_each_tx_type(i) {
+		channel_entry = &async_channel_directory[i];
+		if (channel_entry->local_iter)
+			free_percpu(channel_entry->local_iter);
+
+		/* free all the per operation channel references */
+		spin_lock_irqsave(&channel_entry->lock, flags);
+		list_for_each_entry_rcu(ref, &channel_entry->list, async_node) {
+			list_del_rcu(&ref->async_node);
+			call_rcu(&ref->rcu, free_dma_chan_ref);
+		}
+		spin_unlock_irqrestore(&channel_entry->lock, flags);
+	}
+
+	/* free all the channels on the master list */
+	spin_lock_irqsave(&async_tx_master_list.lock, flags);
+	list_for_each_entry_rcu(ref, &async_tx_master_list.list, async_node) {
+		dma_chan_put(ref->chan); /* permit backing devices to go away */
+		list_del_rcu(&ref->async_node);
+		call_rcu(&ref->rcu, free_dma_chan_ref);
+	}
+	spin_unlock_irqrestore(&async_tx_master_list.lock, flags);
+}
+
+/**
+ * async_tx_find_channel - find a channel to carry out the operation or let
+ *	the transaction execute synchronously
+ * @depend_tx: transaction dependency
+ * @tx_type: transaction type
+ */
+static struct dma_chan *
+async_tx_find_channel(struct dma_async_tx_descriptor *depend_tx,
+	enum dma_transaction_type tx_type)
+{
+	/* see if we can keep the chain on one channel */
+	if (depend_tx &&
+		test_bit(tx_type, &depend_tx->chan->device->capabilities))
+		return depend_tx->chan;
+	else {
+		int cpu;
+		struct async_channel_entry *channel_entry =
+			&async_channel_directory[tx_type];
+		struct async_iter_percpu *local_iter;
+		struct list_head *iter;
+		struct dma_chan *chan;
+
+		rcu_read_lock();
+		if (list_empty(&channel_entry->list)) {
+			rcu_read_unlock();
+			return NULL;
+		}
+
+		cpu = get_cpu();
+		local_iter = per_cpu_ptr(channel_entry->local_iter, cpu);
+		put_cpu();
+
+		/* ensure the percpu place holder is pointing to a
+		 * valid list entry and get the next channel in the
+		 * round robin
+		 */
+		if (unlikely(local_iter->local_version !=
+			atomic_read(&channel_entry->version))) {
+			local_iter->local_version =
+				atomic_read(&channel_entry->version);
+			iter = channel_entry->list.next;
+		} else {
+			iter = local_iter->iter->next;
+			/* wrap around detect */
+			if (iter == &channel_entry->list)
+				iter = iter->next;
+		}
+
+		/* if we are still pointing to the head then the list
+		 * recently became empty
+		 */
+		if (iter == &channel_entry->list)
+			chan = NULL;
+		else {
+			local_iter->iter = iter;
+			chan = list_entry(iter, struct dma_chan_ref, async_node)->chan;
+		}
+		rcu_read_unlock();
+
+		return chan;
+	}
+}
+#else
+static int __init async_tx_init(void)
+{
+	printk("async_tx: api initialized (sync-only)\n");
+	return 0;
+}
+
+static void __exit async_tx_exit(void)
+{
+	do { } while (0);
+}
+
+static inline struct dma_chan *
+async_tx_find_channel(struct dma_async_tx_descriptor *depend_tx,
+	enum dma_transaction_type tx_type)
+{
+	return NULL;
+}
+#endif
+
+#define to_iop_adma_chan(chan) container_of(chan, struct iop_adma_chan, common)
+#define tx_to_iop_adma_slot(tx) container_of(tx, struct iop_adma_desc_slot, async_tx)
+
+static inline void
+async_tx_submit(struct dma_chan *chan, struct dma_async_tx_descriptor *tx,
+	enum async_tx_flags flags, struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	tx->callback = callback;
+	tx->callback_param = callback_param;
+
+	/* set this new tx to run after depend_tx if:
+	 * 1/ a dependency exists (depend_tx is !NULL)
+	 * 2/ the tx can not be submitted to the current channel
+	 */
+	if (depend_tx && depend_tx->chan != chan) {
+		/* if ack is already set then we cannot be sure
+		 * we are referring to the correct operation
+		 */
+		BUG_ON(depend_tx->ack);
+
+		tx->parent = depend_tx;
+		spin_lock_bh(&depend_tx->lock);
+		list_add_tail(&tx->depend_node, &depend_tx->depend_list);
+		if (depend_tx->cookie == 0) {
+			struct dma_chan *dep_chan = depend_tx->chan;
+			struct dma_device *dep_dev = dep_chan->device;
+			dep_dev->device_dependency_added(dep_chan);
+		}
+		spin_unlock_bh(&depend_tx->lock);
+	} else {
+		tx->parent = NULL;
+		chan->device->device_tx_submit(tx);
+	}
+
+	if (flags & ASYNC_TX_ACK)
+		async_tx_ack(tx);
+
+	if (depend_tx && (flags & ASYNC_TX_DEP_ACK))
+		async_tx_ack(depend_tx);
+}
+
+/**
+ * sync_epilog - actions to take if an operation is run synchronously
+ * @flags: async_tx flags
+ * @depend_tx: transaction depends on depend_tx
+ * @callback: function to call when the transaction completes
+ * @callback_param: parameter to pass to the callback routine
+ */
+static inline void
+sync_epilog(unsigned long flags, struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	if (callback)
+		callback(callback_param);
+
+	if (depend_tx && (flags & ASYNC_TX_DEP_ACK))
+		async_tx_ack(depend_tx);
+}
+
+static inline void
+do_async_xor(struct dma_async_tx_descriptor *tx, struct dma_device *device,
+	struct dma_chan *chan, struct page *dest, struct page **src_list,
+	unsigned int offset, unsigned int src_cnt, size_t len,
+	enum async_tx_flags flags, struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	dma_addr_t dma_addr;
+	enum dma_data_direction dir;
+	int i;
+
+	PRINTK("%s: len: %u\n", __FUNCTION__, len);
+
+	dir = (flags & ASYNC_TX_ASSUME_COHERENT) ?
+		DMA_NONE : DMA_FROM_DEVICE;
+
+	dma_addr = device->map_page(chan, dest, offset, len, dir);
+     	device->device_set_dest(dma_addr, tx, 0);
+
+	dir = (flags & ASYNC_TX_ASSUME_COHERENT) ?
+		DMA_NONE : DMA_TO_DEVICE;
+
+	for (i = 0; i < src_cnt; i++) {
+		dma_addr = device->map_page(chan, src_list[i],
+			offset, len, dir);
+	     	device->device_set_src(dma_addr, tx, i);
+	}
+
+	async_tx_submit(chan, tx, flags, depend_tx, callback,
+		callback_param);
+}
+
+static inline void
+do_sync_xor(struct page *dest, struct page **src_list, unsigned int offset,
+	unsigned int src_cnt, size_t len, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	void *_dest;
+	int start_idx, i;
+
+	printk("%s: len: %u\n", __FUNCTION__, len);
+
+	/* reuse the 'src_list' array to convert to buffer pointers */
+	if (flags & ASYNC_TX_XOR_DROP_DST)
+		start_idx = 1;
+	else
+		start_idx = 0;
+
+	for (i = start_idx; i < src_cnt; i++)
+		src_list[i] = (struct page *)
+			(page_address(src_list[i]) + offset);
+
+	/* set destination address */
+	_dest = page_address(dest) + offset;
+
+	if (flags & ASYNC_TX_XOR_ZERO_DST)
+		memset(_dest, 0, len);
+
+	xor_block(src_cnt - start_idx, len, _dest,
+		(void **) &src_list[start_idx]);
+
+	sync_epilog(flags, depend_tx, callback, callback_param);
+}
+
+/**
+ * async_xor - attempt to xor a set of blocks with a dma engine.
+ *	xor_block always uses the dest as a source so the ASYNC_TX_XOR_ZERO_DST
+ *	flag must be set to not include dest data in the calculation.  The
+ *	assumption with dma eninges is that they only use the destination
+ *	buffer as a source when it is explicity specified in the source list.
+ * @dest: destination page
+ * @src_list: array of source pages (if the dest is also a source it must be
+ *	at index zero).  The contents of this array may be overwritten.
+ * @offset: offset in pages to start transaction
+ * @src_cnt: number of source pages
+ * @len: length in bytes
+ * @flags: ASYNC_TX_XOR_ZERO_DST, ASYNC_TX_XOR_DROP_DEST,
+ 	ASYNC_TX_ASSUME_COHERENT, ASYNC_TX_ACK, ASYNC_TX_DEP_ACK
+ * @depend_tx: xor depends on the result of this transaction.
+ * @callback: function to call when the xor completes
+ * @callback_param: parameter to pass to the callback routine
+ */
+struct dma_async_tx_descriptor *
+async_xor(struct page *dest, struct page **src_list, unsigned int offset,
+	unsigned int src_cnt, size_t len, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_chan *chan = async_tx_find_channel(depend_tx, DMA_XOR);
+	struct dma_device *device = chan ? chan->device : NULL;
+	struct dma_async_tx_descriptor *tx = NULL;
+	dma_async_tx_callback _callback;
+	void *_callback_param;
+	unsigned long local_flags;
+	int xor_src_cnt;
+	int i = 0, src_off = 0, int_en;
+
+	BUG_ON(src_cnt <= 1);
+
+	while (src_cnt) {
+		local_flags = flags;
+		if (device) { /* run the xor asynchronously */
+			xor_src_cnt = min(src_cnt, device->max_xor);
+			/* if we are submitting additional xors
+			 * only set the callback on the last transaction
+			 */
+			if (src_cnt > xor_src_cnt) {
+				local_flags &= ~(ASYNC_TX_ACK | ASYNC_TX_INT_EN);
+				_callback = NULL;
+				_callback_param = NULL;
+			} else {
+				_callback = callback;
+				_callback_param = callback_param;
+			}
+
+			int_en = (local_flags & ASYNC_TX_INT_EN) ? 1 : 0;
+
+			tx = device->device_prep_dma_xor(
+				chan, xor_src_cnt, len, int_en);
+
+			if (tx) {
+				do_async_xor(tx, device, chan, dest,
+				&src_list[src_off], offset, xor_src_cnt, len,
+				local_flags, depend_tx, _callback,
+				_callback_param);
+			} else /* fall through */
+				goto xor_sync;
+		} else { /* run the xor synchronously */
+xor_sync:
+			/* process up to 'max_xor_blocks' sources */
+			xor_src_cnt = min(src_cnt, (unsigned int) MAX_XOR_BLOCKS);
+
+			/* if we are submitting additional xors
+			 * only set the callback on the last transaction
+			 */
+			if (src_cnt > xor_src_cnt) {
+				local_flags &= ~(ASYNC_TX_ACK | ASYNC_TX_INT_EN);
+				_callback = NULL;
+				_callback_param = NULL;
+			} else {
+				_callback = callback;
+				_callback_param = callback_param;
+			}
+
+			/* wait for any prerequisite operations */
+			if (depend_tx) {
+				/* if ack is already set then we cannot be sure
+				 * we are referring to the correct operation
+				 */
+				BUG_ON(depend_tx->ack);
+				if (dma_wait_for_async_tx(depend_tx) == DMA_ERROR)
+					panic("%s: DMA_ERROR waiting for depend_tx\n",
+						__FUNCTION__);
+			}
+
+			do_sync_xor(dest, &src_list[src_off], offset, src_cnt,
+				len, local_flags, depend_tx, _callback,
+				_callback_param);
+		}
+
+		/* the previous tx is hidden from the client,
+		 * so ack it
+		 */
+		if (i && depend_tx)
+			async_tx_ack(depend_tx);
+
+		depend_tx = tx;
+
+		if (src_cnt > xor_src_cnt) {
+			/* drop completed sources */
+			src_cnt -= xor_src_cnt;
+
+			/* unconditionally preserve the destination */
+			flags &= ~ASYNC_TX_XOR_ZERO_DST;
+
+			/* use the intermediate result a source */
+			src_off = xor_src_cnt - 1;
+			src_list[src_off] = dest;
+			src_cnt++;
+			flags |= ASYNC_TX_XOR_DROP_DST;
+		} else
+			src_cnt = 0;
+		i++;
+	}
+
+	return tx;
+}
+
+static int page_is_zero(struct page *p, size_t len)
+{
+	char *a = page_address(p);
+	return ((*(u32*)a) == 0 &&
+		memcmp(a, a+4, len-4)==0);
+}
+
+/**
+ * async_xor_zero_sum - attempt a xor parity check with a dma engine.
+ * @dest: destination page used if the xor is performed synchronously
+ * @src_list: array of source pages.  The dest page must be listed as a source
+ * 	at index zero.  The contents of this array may be overwritten.
+ * @offset: offset in pages to start transaction
+ * @src_cnt: number of source pages
+ * @len: length in bytes
+ * @result: 0 if sum == 0 else non-zero
+ * @flags: ASYNC_TX_ASSUME_COHERENT, ASYNC_TX_ACK
+ * @depend_tx: xor depends on the result of this transaction.
+ * @callback: function to call when the xor completes
+ * @callback_param: parameter to pass to the callback routine
+ */
+struct dma_async_tx_descriptor *
+async_xor_zero_sum(struct page *dest, struct page **src_list,
+	unsigned int offset, unsigned int src_cnt, size_t len,
+	u32 *result, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_chan *chan = async_tx_find_channel(depend_tx, DMA_ZERO_SUM);
+	struct dma_device *device = chan ? chan->device : NULL;
+	int int_en = (flags & ASYNC_TX_INT_EN) ? 1 : 0;
+	struct dma_async_tx_descriptor *tx = device ?
+		device->device_prep_dma_zero_sum(chan, src_cnt, len, result,
+			int_en) : NULL;
+	int i;
+
+	if (tx) {
+		dma_addr_t dma_addr;
+		enum dma_data_direction dir;
+
+		PRINTK("%s: (async) len: %u\n", __FUNCTION__, len);
+
+		dir = (flags & ASYNC_TX_ASSUME_COHERENT) ?
+			DMA_NONE : DMA_TO_DEVICE;
+
+		for (i = 0; i < src_cnt; i++) {
+			dma_addr = device->map_page(chan, src_list[i],
+				offset, len, dir);
+		     	device->device_set_src(dma_addr, tx, i);
+		}
+
+		async_tx_submit(chan, tx, flags, depend_tx, callback,
+			callback_param);
+	} else {
+		unsigned long xor_flags = flags;
+
+		PRINTK("%s: (sync) len: %u\n", __FUNCTION__, len);
+
+		xor_flags |= ASYNC_TX_XOR_DROP_DST;
+		xor_flags &= ~ASYNC_TX_ACK;
+
+		tx = async_xor(dest, src_list, offset, src_cnt, len, xor_flags,
+			depend_tx, NULL, NULL);
+
+		if (tx) {
+			if (dma_wait_for_async_tx(tx) == DMA_ERROR)
+				panic("%s: DMA_ERROR waiting for tx\n",
+					__FUNCTION__);
+			async_tx_ack(tx);
+		}
+
+		*result = page_is_zero(dest, len) ? 0 : 1;
+
+		tx = NULL;
+
+		sync_epilog(flags, depend_tx, callback, callback_param);
+	}
+
+	return tx;
+}
+
+/**
+ * async_memcpy - attempt to copy memory with a dma engine.
+ * @dest: destination page
+ * @src: src page
+ * @offset: offset in pages to start transaction
+ * @len: length in bytes
+ * @flags: ASYNC_TX_ASSUME_COHERENT, ASYNC_TX_ACK, ASYNC_TX_DEP_ACK,
+ *	ASYNC_TX_KMAP_SRC, ASYNC_TX_KMAP_DST
+ * @depend_tx: memcpy depends on the result of this transaction
+ * @callback: function to call when the memcpy completes
+ * @callback_param: parameter to pass to the callback routine
+ */
+struct dma_async_tx_descriptor *
+async_memcpy(struct page *dest, struct page *src, unsigned int dest_offset,
+	unsigned int src_offset, size_t len, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_chan *chan = async_tx_find_channel(depend_tx, DMA_MEMCPY);
+	struct dma_device *device = chan ? chan->device : NULL;
+	int int_en = (flags & ASYNC_TX_INT_EN) ? 1 : 0;
+	struct dma_async_tx_descriptor *tx = device ?
+		device->device_prep_dma_memcpy(chan, len,
+		int_en) : NULL;
+
+	if (tx) { /* run the memcpy asynchronously */
+		dma_addr_t dma_addr;
+		enum dma_data_direction dir;
+
+		PRINTK("%s: (async) len: %u\n", __FUNCTION__, len);
+
+		dir = (flags & ASYNC_TX_ASSUME_COHERENT) ?
+			DMA_NONE : DMA_FROM_DEVICE;
+
+		dma_addr = device->map_page(chan, dest, dest_offset, len, dir);
+	     	device->device_set_dest(dma_addr, tx, 0);
+
+		dir = (flags & ASYNC_TX_ASSUME_COHERENT) ?
+			DMA_NONE : DMA_TO_DEVICE;
+
+		dma_addr = device->map_page(chan, src, src_offset, len, dir);
+	     	device->device_set_src(dma_addr, tx, 0);
+
+		async_tx_submit(chan, tx, flags, depend_tx, callback,
+			callback_param);
+	} else { /* run the memcpy synchronously */
+		void *dest_buf, *src_buf;
+		PRINTK("%s: (sync) len: %u\n", __FUNCTION__, len);
+
+		/* wait for any prerequisite operations */
+		if (depend_tx) {
+			/* if ack is already set then we cannot be sure
+			 * we are referring to the correct operation
+			 */
+			BUG_ON(depend_tx->ack);
+			if (dma_wait_for_async_tx(depend_tx) == DMA_ERROR)
+				panic("%s: DMA_ERROR waiting for depend_tx\n",
+					__FUNCTION__);
+		}
+
+		if (flags & ASYNC_TX_KMAP_DST)
+			dest_buf = kmap_atomic(dest, KM_USER0) + dest_offset;
+		else
+			dest_buf = page_address(dest) + dest_offset;
+
+		if (flags & ASYNC_TX_KMAP_SRC)
+			src_buf = kmap_atomic(src, KM_USER0) + src_offset;
+		else
+			src_buf = page_address(src) + src_offset;
+
+		memcpy(dest_buf, src_buf, len);
+
+		if (flags & ASYNC_TX_KMAP_DST)
+			kunmap_atomic(dest_buf, KM_USER0);
+
+		if (flags & ASYNC_TX_KMAP_SRC)
+			kunmap_atomic(src_buf, KM_USER0);
+
+		sync_epilog(flags, depend_tx, callback, callback_param);
+	}
+
+	return tx;
+}
+
+/**
+ * async_memset - attempt to fill memory with a dma engine.
+ * @dest: destination page
+ * @val: fill value
+ * @offset: offset in pages to start transaction
+ * @len: length in bytes
+ * @flags: ASYNC_TX_ASSUME_COHERENT, ASYNC_TX_ACK
+ * @depend_tx: memset depends on the result of this transaction
+ * @callback: function to call when the memcpy completes
+ * @callback_param: parameter to pass to the callback routine
+ */
+struct dma_async_tx_descriptor *
+async_memset(struct page *dest, int val, unsigned int offset,
+	size_t len, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_chan *chan = async_tx_find_channel(depend_tx, DMA_MEMSET);
+	struct dma_device *device = chan ? chan->device : NULL;
+	int int_en = (flags & ASYNC_TX_INT_EN) ? 1 : 0;
+	struct dma_async_tx_descriptor *tx = device ?
+		device->device_prep_dma_memset(chan, val, len,
+			int_en) : NULL;
+
+	if (tx) { /* run the memset asynchronously */
+		dma_addr_t dma_addr;
+		enum dma_data_direction dir;
+
+		PRINTK("%s: (async) len: %u\n", __FUNCTION__, len);
+		dir = (flags & ASYNC_TX_ASSUME_COHERENT) ?
+			DMA_NONE : DMA_FROM_DEVICE;
+
+		dma_addr = device->map_page(chan, dest, offset, len, dir);
+	     	device->device_set_dest(dma_addr, tx, 0);
+
+		async_tx_submit(chan, tx, flags, depend_tx, callback,
+			callback_param);
+	} else { /* run the memset synchronously */
+		void *dest_buf;
+		PRINTK("%s: (sync) len: %u\n", __FUNCTION__, len);
+
+		dest_buf = (void *) (((char *) page_address(dest)) + offset);
+
+		/* wait for any prerequisite operations */
+		if (depend_tx) {
+			/* if ack is already set then we cannot be sure
+			 * we are referring to the correct operation
+			 */
+			BUG_ON(depend_tx->ack);
+			if (dma_wait_for_async_tx(depend_tx) == DMA_ERROR)
+				panic("%s: DMA_ERROR waiting for depend_tx\n",
+					__FUNCTION__);
+		}
+
+		memset(dest_buf, val, len);
+
+		sync_epilog(flags, depend_tx, callback, callback_param);
+	}
+
+	return tx;
+}
+
+/**
+ * async_interrupt - cause an interrupt to asynchrounously flush pending
+ *	completion callbacks, or schedule new callback.  Note: this rouine
+ *	assumes that all dma channels have the DMA_INTERRUPT capability
+ * @flags: ASYNC_TX_DEP_ACK
+ * @depend_tx: interrupt depends the result of this transaction
+ * @callback: function to call after the interrupt fires
+ * @callback_param: parameter to pass to the callback routine
+ */
+struct dma_async_tx_descriptor *
+async_interrupt(enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	struct dma_chan *chan = async_tx_find_channel(depend_tx, DMA_INTERRUPT);
+	struct dma_device *device = chan ? chan->device : NULL;
+	struct dma_async_tx_descriptor *tx = device ?
+		device->device_prep_dma_interrupt(chan) : NULL;
+
+	if (tx) {
+		PRINTK("%s: (async)\n", __FUNCTION__);
+
+		async_tx_submit(chan, tx, flags, depend_tx, callback,
+			callback_param);
+	} else {
+		PRINTK("%s: (sync)\n", __FUNCTION__);
+
+		/* wait for any prerequisite operations */
+		if (depend_tx) {
+			/* if ack is already set then we cannot be sure
+			 * we are referring to the correct operation
+			 */
+			BUG_ON(depend_tx->ack);
+			if (dma_wait_for_async_tx(depend_tx) == DMA_ERROR)
+				panic("%s: DMA_ERROR waiting for depend_tx\n",
+					__FUNCTION__);
+		}
+
+		sync_epilog(flags, depend_tx, callback, callback_param);
+	}
+
+	return tx;
+}
+
+/**
+ * async_interrupt_cond - same as async_interrupt except that this will only be
+ *	if next_op must be run on a different channel.  Note: this rouine
+ *	assumes that all dma channels have the DMA_INTERRUPT capability
+ * @next_op: the next operation type to be submitted
+ * @flags: ASYNC_TX_DEP_ACK
+ * @depend_tx: interrupt depends the result of this transaction
+ * @callback: function to call after the interrupt fires
+ * @callback_param: parameter to pass to the callback routine
+ */
+struct dma_async_tx_descriptor *
+async_interrupt_cond(enum dma_transaction_type next_op,
+	enum async_tx_flags flags, struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param)
+{
+	int chan_switch = depend_tx ?
+		!test_bit(next_op, &depend_tx->chan->device->capabilities) : 0;
+	struct dma_chan *chan = chan_switch ? depend_tx->chan : NULL;
+	struct dma_device *device = chan ? chan->device : NULL;
+	struct dma_async_tx_descriptor *tx = device ?
+		device->device_prep_dma_interrupt(chan) : NULL;
+
+	if (!chan_switch) {
+		/* forward the callback */
+		if ((flags & ASYNC_TX_DEP_ACK) && callback) {
+			if (depend_tx) {
+				BUG_ON(depend_tx->callback);
+				depend_tx->callback = callback;
+				depend_tx->callback_param = callback_param;
+			} else
+				callback(callback_param);
+		}
+		return depend_tx;
+	} else if (tx) {
+		PRINTK("%s: (async)\n", __FUNCTION__);
+
+		async_tx_submit(chan, tx, flags, depend_tx, callback,
+			callback_param);
+	} else {
+		PRINTK("%s: (sync)\n", __FUNCTION__);
+
+		/* wait for any prerequisite operations */
+		if (depend_tx) {
+			/* if ack is already set then we cannot be sure
+			 * we are referring to the correct operation
+			 */
+			BUG_ON(depend_tx->ack);
+			if (dma_wait_for_async_tx(depend_tx) == DMA_ERROR)
+				panic("%s: DMA_ERROR waiting for depend_tx\n",
+					__FUNCTION__);
+		}
+
+		sync_epilog(flags, depend_tx, callback, callback_param);
+	}
+
+	return tx;
+}
+
+module_init(async_tx_init);
+module_exit(async_tx_exit);
+
+MODULE_AUTHOR("Intel Corporation");
+MODULE_DESCRIPTION("Asynchronous Bulk Memory Transactions API");
+MODULE_LICENSE("GPL");
+
+EXPORT_SYMBOL_GPL(async_interrupt);
+EXPORT_SYMBOL_GPL(async_interrupt_cond);
+EXPORT_SYMBOL_GPL(async_memcpy);
+EXPORT_SYMBOL_GPL(async_memset);
+EXPORT_SYMBOL_GPL(async_xor);
+EXPORT_SYMBOL_GPL(async_xor_zero_sum);
+EXPORT_SYMBOL_GPL(async_tx_issue_pending_all);
+EXPORT_SYMBOL_GPL(async_tx_ack);
+EXPORT_SYMBOL_GPL(dma_wait_for_async_tx);
+EXPORT_SYMBOL_GPL(async_tx_run_dependencies);
diff --git a/drivers/dma/xor.c b/drivers/dma/xor.c
new file mode 100644
index 0000000..6eb3416
--- /dev/null
+++ b/drivers/dma/xor.c
@@ -0,0 +1,153 @@
+/*
+ * xor.c : Multiple Devices driver for Linux
+ *
+ * Copyright (C) 1996, 1997, 1998, 1999, 2000,
+ * Ingo Molnar, Matti Aarnio, Jakub Jelinek, Richard Henderson.
+ *
+ * Dispatch optimized RAID-5 checksumming functions.
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License as published by
+ * the Free Software Foundation; either version 2, or (at your option)
+ * any later version.
+ *
+ * You should have received a copy of the GNU General Public License
+ * (for example /usr/src/linux/COPYING); if not, write to the Free
+ * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
+ */
+
+#define BH_TRACE 0
+#include <linux/module.h>
+#include <linux/raid/md.h>
+#include <linux/raid/xor.h>
+#include <asm/xor.h>
+
+/* The xor routines to use.  */
+static struct xor_block_template *active_template;
+
+void
+xor_block(unsigned int src_count, unsigned int bytes, void *dest, void **srcs)
+{
+	unsigned long *p1, *p2, *p3, *p4;
+
+	p1 = (unsigned long *) srcs[0];
+	if (src_count == 1) {
+		active_template->do_2(bytes, dest, p1);
+		return;
+	}
+
+	p2 = (unsigned long *) srcs[1];
+	if (src_count == 2) {
+		active_template->do_3(bytes, dest, p1, p2);
+		return;
+	}
+
+	p3 = (unsigned long *) srcs[2];
+	if (src_count == 3) {
+		active_template->do_4(bytes, dest, p1, p2, p3);
+		return;
+	}
+
+	p4 = (unsigned long *) srcs[3];
+	active_template->do_5(bytes, dest, p1, p2, p3, p4);
+}
+
+/* Set of all registered templates.  */
+static struct xor_block_template *template_list;
+
+#define BENCH_SIZE (PAGE_SIZE)
+
+static void
+do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
+{
+	int speed;
+	unsigned long now;
+	int i, count, max;
+
+	tmpl->next = template_list;
+	template_list = tmpl;
+
+	/*
+	 * Count the number of XORs done during a whole jiffy, and use
+	 * this to calculate the speed of checksumming.  We use a 2-page
+	 * allocation to have guaranteed color L1-cache layout.
+	 */
+	max = 0;
+	for (i = 0; i < 5; i++) {
+		now = jiffies;
+		count = 0;
+		while (jiffies == now) {
+			mb();
+			tmpl->do_2(BENCH_SIZE, b1, b2);
+			mb();
+			count++;
+			mb();
+		}
+		if (count > max)
+			max = count;
+	}
+
+	speed = max * (HZ * BENCH_SIZE / 1024);
+	tmpl->speed = speed;
+
+	printk("   %-10s: %5d.%03d MB/sec\n", tmpl->name,
+	       speed / 1000, speed % 1000);
+}
+
+static int
+calibrate_xor_block(void)
+{
+	void *b1, *b2;
+	struct xor_block_template *f, *fastest;
+
+	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
+	if (! b1) {
+		printk("xor: Yikes!  No memory available.\n");
+		return -ENOMEM;
+	}
+	b2 = b1 + 2*PAGE_SIZE + BENCH_SIZE;
+
+	/*
+	 * If this arch/cpu has a short-circuited selection, don't loop through all
+	 * the possible functions, just test the best one
+	 */
+
+	fastest = NULL;
+
+#ifdef XOR_SELECT_TEMPLATE
+		fastest = XOR_SELECT_TEMPLATE(fastest);
+#endif
+
+#define xor_speed(templ)	do_xor_speed((templ), b1, b2)
+
+	if (fastest) {
+		printk(KERN_INFO "xor: automatically using best checksumming function: %s\n",
+			fastest->name);
+		xor_speed(fastest);
+	} else {
+		printk(KERN_INFO "xor: measuring software checksumming speed\n");
+		XOR_TRY_TEMPLATES;
+		fastest = template_list;
+		for (f = fastest; f; f = f->next)
+			if (f->speed > fastest->speed)
+				fastest = f;
+	}
+
+	printk("xor: using function: %s (%d.%03d MB/sec)\n",
+	       fastest->name, fastest->speed / 1000, fastest->speed % 1000);
+
+#undef xor_speed
+
+	free_pages((unsigned long)b1, 2);
+
+	active_template = fastest;
+	return 0;
+}
+
+static __exit void xor_exit(void) { }
+
+EXPORT_SYMBOL(xor_block);
+MODULE_LICENSE("GPL");
+
+module_init(calibrate_xor_block);
+module_exit(xor_exit);
diff --git a/drivers/md/Kconfig b/drivers/md/Kconfig
index c92c152..545ca98 100644
--- a/drivers/md/Kconfig
+++ b/drivers/md/Kconfig
@@ -108,7 +108,7 @@ config MD_RAID10
 
 config MD_RAID456
 	tristate "RAID-4/RAID-5/RAID-6 mode"
-	depends on BLK_DEV_MD
+	depends on BLK_DEV_MD && ASYNC_TX_DMA
 	---help---
 	  A RAID-5 set of N drives with a capacity of C MB per drive provides
 	  the capacity of C * (N - 1) MB, and protects against a failure
diff --git a/drivers/md/Makefile b/drivers/md/Makefile
index 34957a6..23c3049 100644
--- a/drivers/md/Makefile
+++ b/drivers/md/Makefile
@@ -17,15 +17,15 @@ raid456-objs	:= raid5.o raid6algos.o rai
 hostprogs-y	:= mktables
 
 # Note: link order is important.  All raid personalities
-# and xor.o must come before md.o, as they each initialise 
-# themselves, and md.o may use the personalities when it 
+# must come before md.o, as they each initialise
+# themselves, and md.o may use the personalities when it
 # auto-initialised.
 
 obj-$(CONFIG_MD_LINEAR)		+= linear.o
 obj-$(CONFIG_MD_RAID0)		+= raid0.o
 obj-$(CONFIG_MD_RAID1)		+= raid1.o
 obj-$(CONFIG_MD_RAID10)		+= raid10.o
-obj-$(CONFIG_MD_RAID456)	+= raid456.o xor.o
+obj-$(CONFIG_MD_RAID456)	+= raid456.o
 obj-$(CONFIG_MD_MULTIPATH)	+= multipath.o
 obj-$(CONFIG_MD_FAULTY)		+= faulty.o
 obj-$(CONFIG_BLK_DEV_MD)	+= md-mod.o
diff --git a/drivers/md/raid5.c b/drivers/md/raid5.c
index 69c3e20..0c8ada5 100644
--- a/drivers/md/raid5.c
+++ b/drivers/md/raid5.c
@@ -948,11 +948,11 @@ static void copy_data(int frombio, struc
 	}
 }
 
-#define check_xor() 	do { 						\
-			   if (count == MAX_XOR_BLOCKS) {		\
-				xor_block(count, STRIPE_SIZE, ptr);	\
-				count = 1;				\
-			   }						\
+#define check_xor()	do {						       \
+		     	   if (count == MAX_XOR_BLOCKS) {		       \
+				xor_block(count, STRIPE_SIZE, ptr[0], &ptr[1]);\
+				count = 1;				       \
+			   }						       \
 			} while(0)
 
 
@@ -981,7 +981,7 @@ static void compute_block(struct stripe_
 		check_xor();
 	}
 	if (count != 1)
-		xor_block(count, STRIPE_SIZE, ptr);
+		xor_block(count, STRIPE_SIZE, ptr[0], &ptr[1]);
 	set_bit(R5_UPTODATE, &sh->dev[dd_idx].flags);
 }
 
@@ -1036,7 +1036,7 @@ static void compute_parity5(struct strip
 		break;
 	}
 	if (count>1) {
-		xor_block(count, STRIPE_SIZE, ptr);
+		xor_block(count, STRIPE_SIZE, ptr[0], &ptr[1]);
 		count = 1;
 	}
 	
@@ -1070,7 +1070,7 @@ static void compute_parity5(struct strip
 			}
 	}
 	if (count != 1)
-		xor_block(count, STRIPE_SIZE, ptr);
+		xor_block(count, STRIPE_SIZE, ptr[0], &ptr[1]);
 	
 	if (method != CHECK_PARITY) {
 		set_bit(R5_UPTODATE, &sh->dev[pd_idx].flags);
@@ -1193,7 +1193,7 @@ static void compute_block_1(struct strip
 			check_xor();
 		}
 		if (count != 1)
-			xor_block(count, STRIPE_SIZE, ptr);
+			xor_block(count, STRIPE_SIZE, ptr[0], &ptr[1]);
 		if (!nozero) set_bit(R5_UPTODATE, &sh->dev[dd_idx].flags);
 		else clear_bit(R5_UPTODATE, &sh->dev[dd_idx].flags);
 	}
diff --git a/drivers/md/xor.c b/drivers/md/xor.c
deleted file mode 100644
index 324897c..0000000
--- a/drivers/md/xor.c
+++ /dev/null
@@ -1,154 +0,0 @@
-/*
- * xor.c : Multiple Devices driver for Linux
- *
- * Copyright (C) 1996, 1997, 1998, 1999, 2000,
- * Ingo Molnar, Matti Aarnio, Jakub Jelinek, Richard Henderson.
- *
- * Dispatch optimized RAID-5 checksumming functions.
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License as published by
- * the Free Software Foundation; either version 2, or (at your option)
- * any later version.
- *
- * You should have received a copy of the GNU General Public License
- * (for example /usr/src/linux/COPYING); if not, write to the Free
- * Software Foundation, Inc., 675 Mass Ave, Cambridge, MA 02139, USA.
- */
-
-#define BH_TRACE 0
-#include <linux/module.h>
-#include <linux/raid/md.h>
-#include <linux/raid/xor.h>
-#include <asm/xor.h>
-
-/* The xor routines to use.  */
-static struct xor_block_template *active_template;
-
-void
-xor_block(unsigned int count, unsigned int bytes, void **ptr)
-{
-	unsigned long *p0, *p1, *p2, *p3, *p4;
-
-	p0 = (unsigned long *) ptr[0];
-	p1 = (unsigned long *) ptr[1];
-	if (count == 2) {
-		active_template->do_2(bytes, p0, p1);
-		return;
-	}
-
-	p2 = (unsigned long *) ptr[2];
-	if (count == 3) {
-		active_template->do_3(bytes, p0, p1, p2);
-		return;
-	}
-
-	p3 = (unsigned long *) ptr[3];
-	if (count == 4) {
-		active_template->do_4(bytes, p0, p1, p2, p3);
-		return;
-	}
-
-	p4 = (unsigned long *) ptr[4];
-	active_template->do_5(bytes, p0, p1, p2, p3, p4);
-}
-
-/* Set of all registered templates.  */
-static struct xor_block_template *template_list;
-
-#define BENCH_SIZE (PAGE_SIZE)
-
-static void
-do_xor_speed(struct xor_block_template *tmpl, void *b1, void *b2)
-{
-	int speed;
-	unsigned long now;
-	int i, count, max;
-
-	tmpl->next = template_list;
-	template_list = tmpl;
-
-	/*
-	 * Count the number of XORs done during a whole jiffy, and use
-	 * this to calculate the speed of checksumming.  We use a 2-page
-	 * allocation to have guaranteed color L1-cache layout.
-	 */
-	max = 0;
-	for (i = 0; i < 5; i++) {
-		now = jiffies;
-		count = 0;
-		while (jiffies == now) {
-			mb();
-			tmpl->do_2(BENCH_SIZE, b1, b2);
-			mb();
-			count++;
-			mb();
-		}
-		if (count > max)
-			max = count;
-	}
-
-	speed = max * (HZ * BENCH_SIZE / 1024);
-	tmpl->speed = speed;
-
-	printk("   %-10s: %5d.%03d MB/sec\n", tmpl->name,
-	       speed / 1000, speed % 1000);
-}
-
-static int
-calibrate_xor_block(void)
-{
-	void *b1, *b2;
-	struct xor_block_template *f, *fastest;
-
-	b1 = (void *) __get_free_pages(GFP_KERNEL, 2);
-	if (! b1) {
-		printk("raid5: Yikes!  No memory available.\n");
-		return -ENOMEM;
-	}
-	b2 = b1 + 2*PAGE_SIZE + BENCH_SIZE;
-
-	/*
-	 * If this arch/cpu has a short-circuited selection, don't loop through all
-	 * the possible functions, just test the best one
-	 */
-
-	fastest = NULL;
-
-#ifdef XOR_SELECT_TEMPLATE
-		fastest = XOR_SELECT_TEMPLATE(fastest);
-#endif
-
-#define xor_speed(templ)	do_xor_speed((templ), b1, b2)
-
-	if (fastest) {
-		printk(KERN_INFO "raid5: automatically using best checksumming function: %s\n",
-			fastest->name);
-		xor_speed(fastest);
-	} else {
-		printk(KERN_INFO "raid5: measuring checksumming speed\n");
-		XOR_TRY_TEMPLATES;
-		fastest = template_list;
-		for (f = fastest; f; f = f->next)
-			if (f->speed > fastest->speed)
-				fastest = f;
-	}
-
-	printk("raid5: using function: %s (%d.%03d MB/sec)\n",
-	       fastest->name, fastest->speed / 1000, fastest->speed % 1000);
-
-#undef xor_speed
-
-	free_pages((unsigned long)b1, 2);
-
-	active_template = fastest;
-	return 0;
-}
-
-static __exit void xor_exit(void) { }
-
-EXPORT_SYMBOL(xor_block);
-MODULE_LICENSE("GPL");
-
-module_init(calibrate_xor_block);
-module_exit(xor_exit);
diff --git a/include/linux/async_tx.h b/include/linux/async_tx.h
new file mode 100644
index 0000000..f2b4384
--- /dev/null
+++ b/include/linux/async_tx.h
@@ -0,0 +1,181 @@
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
+#include <linux/dmaengine.h>
+#include <linux/spinlock.h>
+#include <linux/interrupt.h>
+
+struct dma_chan_ref {
+	struct dma_chan *chan;
+	struct list_head async_node;
+	struct rcu_head rcu;
+};
+
+struct async_iter_percpu {
+	struct list_head *iter;
+	unsigned long local_version;
+};
+
+struct async_channel_entry {
+	struct list_head list;
+	spinlock_t lock;
+	struct async_iter_percpu *local_iter;
+	atomic_t version;
+};
+
+/**
+ * async_tx_flags - modifiers for the async_* calls
+ * @ASYNC_TX_XOR_ZERO_DST: for synchronous xor: zero the destination
+ *	asynchronous assumes a pre-zeroed destination
+ * @ASYNC_TX_XOR_ZERO_DST: for synchronous xor: drop source index zero (dest)
+ *	the dest is an implicit source to the synchronous routine
+ * @ASYNC_TX_ASSUME_COHERENT: skip cache maintenance operations
+ * @ASYNC_TX_ACK: immediately ack the descriptor, preclude setting up a
+ *	dependency chain
+ * @ASYNC_TX_DEP_ACK: ack the dependency
+ * @ASYNC_TX_INT_EN: have the dma engine trigger an interrupt on completion
+ * @ASYNC_TX_KMAP_SRC: take an atomic mapping (KM_USER0) on the source page(s)
+ *	if the transaction is to be performed synchronously
+ * @ASYNC_TX_KMAP_DST: take an atomic mapping (KM_USER0) on the dest page(s)
+ *	if the transaction is to be performed synchronously
+ */
+enum async_tx_flags {
+	ASYNC_TX_XOR_ZERO_DST	 = (1 << 0),
+	ASYNC_TX_XOR_DROP_DST	 = (1 << 1),
+	ASYNC_TX_ASSUME_COHERENT = (1 << 2),
+	ASYNC_TX_ACK		 = (1 << 3),
+	ASYNC_TX_DEP_ACK	 = (1 << 4),
+	ASYNC_TX_INT_EN		 = (1 << 5),
+	ASYNC_TX_KMAP_SRC	 = (1 << 6),
+	ASYNC_TX_KMAP_DST	 = (1 << 7),
+};
+
+#ifdef CONFIG_DMA_ENGINE
+static inline enum dma_status
+dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx)
+{
+	enum dma_status status;
+	struct dma_async_tx_descriptor *iter;
+
+	if (!tx)
+		return DMA_SUCCESS;
+
+	/* poll through the dependency chain, return when tx is complete */
+	do {
+		iter = tx;
+		while (iter->cookie == -EBUSY)
+			iter = iter->parent;
+
+		status = dma_sync_wait(iter->chan, iter->cookie);
+	} while (status == DMA_IN_PROGRESS || (iter != tx));
+
+	return status;
+}
+
+extern struct async_channel_entry async_tx_master_list;
+static inline void async_tx_issue_pending_all(void)
+{
+	struct dma_chan_ref *ref;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(ref, &async_tx_master_list.list, async_node)
+		ref->chan->device->device_issue_pending(ref->chan);
+	rcu_read_unlock();
+}
+
+static inline void
+async_tx_run_dependencies(struct dma_async_tx_descriptor *tx,
+	struct dma_chan *host_chan)
+{
+	struct dma_async_tx_descriptor *dep_tx, *_dep_tx;
+	struct dma_device *dev;
+	struct dma_chan *chan;
+
+	list_for_each_entry_safe(dep_tx, _dep_tx, &tx->depend_list,
+		depend_node) {
+		chan = dep_tx->chan;
+		dev = chan->device;
+		/* we can't depend on ourselves */
+		BUG_ON(chan == host_chan);
+		list_del(&dep_tx->depend_node);
+		dev->device_tx_submit(dep_tx);
+
+		/* we need to poke the engine as client code does not
+		 * know about dependency submission events
+		 */
+		dev->device_issue_pending(chan);
+	}
+}
+#else
+static inline void
+async_tx_run_dependencies(struct dma_async_tx_descriptor *tx,
+	struct dma_chan *host_chan)
+{
+	do { } while (0);
+}
+
+static inline enum dma_status
+dma_wait_for_async_tx(struct dma_async_tx_descriptor *tx)
+{
+	return DMA_SUCCESS;
+}
+
+static inline void async_tx_issue_pending_all(void)
+{
+	do { } while (0);
+}
+#endif
+
+static inline void
+async_tx_ack(struct dma_async_tx_descriptor *tx)
+{
+	tx->ack = 1;
+}
+
+struct dma_async_tx_descriptor *
+async_xor(struct page *dest, struct page **src_list, unsigned int offset,
+	unsigned int src_cnt, size_t len, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param);
+struct dma_async_tx_descriptor *
+async_xor_zero_sum(struct page *dest, struct page **src_list,
+	unsigned int offset, unsigned int src_cnt, size_t len,
+	u32 *result, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param);
+struct dma_async_tx_descriptor *
+async_memcpy(struct page *dest, struct page *src, unsigned int dest_offset,
+	unsigned int src_offset, size_t len, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param);
+struct dma_async_tx_descriptor *
+async_memset(struct page *dest, int val, unsigned int offset,
+	size_t len, enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param);
+struct dma_async_tx_descriptor *
+async_interrupt(enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param);
+struct dma_async_tx_descriptor *
+async_interrupt_cond(enum dma_transaction_type next_op,
+	enum async_tx_flags flags,
+	struct dma_async_tx_descriptor *depend_tx,
+	dma_async_tx_callback callback, void *callback_param);
diff --git a/include/linux/raid/xor.h b/include/linux/raid/xor.h
index f0d67cb..d151f16 100644
--- a/include/linux/raid/xor.h
+++ b/include/linux/raid/xor.h
@@ -3,9 +3,10 @@ #define _XOR_H
 
 #include <linux/raid/md.h>
 
-#define MAX_XOR_BLOCKS 5
+#define MAX_XOR_BLOCKS 4
 
-extern void xor_block(unsigned int count, unsigned int bytes, void **ptr);
+extern void xor_block(unsigned int count, unsigned int bytes,
+	void *dest, void **srcs);
 
 struct xor_block_template {
         struct xor_block_template *next;
