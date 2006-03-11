Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932381AbWCKC1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932381AbWCKC1H (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Mar 2006 21:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752303AbWCKC1D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Mar 2006 21:27:03 -0500
Received: from [198.78.49.142] ([198.78.49.142]:62724 "EHLO gitlost.site")
	by vger.kernel.org with ESMTP id S1752297AbWCKC06 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Mar 2006 21:26:58 -0500
From: Chris Leech <christopher.leech@intel.com>
Subject: [PATCH 1/8] [I/OAT] DMA memcpy subsystem
Date: Fri, 10 Mar 2006 18:29:20 -0800
To: linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Message-Id: <20060311022919.3950.43835.stgit@gitlost.site>
In-Reply-To: <20060311022759.3950.58788.stgit@gitlost.site>
References: <20060311022759.3950.58788.stgit@gitlost.site>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Provides an API for offloading memory copies to DMA devices

Signed-off-by: Chris Leech <christopher.leech@intel.com>
---

 drivers/Kconfig           |    2 
 drivers/Makefile          |    1 
 drivers/dma/Kconfig       |   13 ++
 drivers/dma/Makefile      |    1 
 drivers/dma/dmaengine.c   |  360 +++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h |  323 ++++++++++++++++++++++++++++++++++++++++
 6 files changed, 700 insertions(+), 0 deletions(-)

diff --git a/drivers/Kconfig b/drivers/Kconfig
index bddf431..ce7ffa7 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -70,4 +70,6 @@ source "drivers/sn/Kconfig"
 
 source "drivers/edac/Kconfig"
 
+source "drivers/dma/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 5c69b86..516ba5e 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -73,3 +73,4 @@ obj-$(CONFIG_SGI_SN)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
 obj-$(CONFIG_SUPERH)		+= sh/
+obj-$(CONFIG_DMA_ENGINE)	+= dma/
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
new file mode 100644
index 0000000..f9ac4bc
--- /dev/null
+++ b/drivers/dma/Kconfig
@@ -0,0 +1,13 @@
+#
+# DMA engine configuration
+#
+
+menu "DMA Engine support"
+
+config DMA_ENGINE
+	bool "Support for DMA engines"
+	---help---
+	  DMA engines offload copy operations from the CPU to dedicated
+	  hardware, allowing the copies to happen asynchronously.
+
+endmenu
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
new file mode 100644
index 0000000..10b7391
--- /dev/null
+++ b/drivers/dma/Makefile
@@ -0,0 +1 @@
+obj-y += dmaengine.o
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
new file mode 100644
index 0000000..35a63d8
--- /dev/null
+++ b/drivers/dma/dmaengine.c
@@ -0,0 +1,360 @@
+/*****************************************************************************
+Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+
+This program is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 2 of the License, or (at your option)
+any later version.
+
+This program is distributed in the hope that it will be useful, but WITHOUT
+ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc., 59
+Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+
+The full GNU General Public License is included in this distribution in the
+file called LICENSE.
+*****************************************************************************/
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/hardirq.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include <linux/rcupdate.h>
+
+static DEFINE_SPINLOCK(dma_list_lock);
+static LIST_HEAD(dma_device_list);
+static LIST_HEAD(dma_client_list);
+
+/* --- sysfs implementation --- */
+
+static ssize_t show_memcpy_count(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+	unsigned long count = 0;
+	int i;
+
+	for_each_cpu(i)
+		count += per_cpu_ptr(chan->local, i)->memcpy_count;
+
+	return sprintf(buf, "%lu\n", count);
+}
+
+static ssize_t show_bytes_transferred(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+	unsigned long count = 0;
+	int i;
+
+	for_each_cpu(i)
+		count += per_cpu_ptr(chan->local, i)->bytes_transferred;
+
+	return sprintf(buf, "%lu\n", count);
+}
+
+static ssize_t show_in_use(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+
+	return sprintf(buf, "%d\n", (chan->client ? 1 : 0));
+}
+
+static struct class_device_attribute dma_class_attrs[] = {
+	__ATTR(memcpy_count, S_IRUGO, show_memcpy_count, NULL),
+	__ATTR(bytes_transferred, S_IRUGO, show_bytes_transferred, NULL),
+	__ATTR(in_use, S_IRUGO, show_in_use, NULL),
+	__ATTR_NULL
+};
+
+static void dma_async_device_cleanup(struct kref *kref);
+
+static void dma_class_dev_release(struct class_device *cd)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+	kref_put(&chan->device->refcount, dma_async_device_cleanup);
+}
+
+static struct class dma_devclass = {
+	.name            = "dma",
+	.class_dev_attrs = dma_class_attrs,
+	.release = dma_class_dev_release,
+};
+
+/* --- client and device registration --- */
+
+/**
+ * dma_client_chan_alloc - try to allocate a channel to a client
+ * @client: &dma_client
+ *
+ * Called with dma_list_lock held.
+ */
+static struct dma_chan *dma_client_chan_alloc(struct dma_client *client)
+{
+	struct dma_device *device;
+	struct dma_chan *chan;
+	unsigned long flags;
+
+	/* Find a channel, any DMA engine will do */
+	list_for_each_entry(device, &dma_device_list, global_node) {
+		list_for_each_entry(chan, &device->channels, device_node) {
+			if (chan->client)
+				continue;
+
+			if (chan->device->device_alloc_chan_resources(chan) >= 0) {
+				kref_get(&device->refcount);
+				kref_init(&chan->refcount);
+				chan->slow_ref = 0;
+				INIT_RCU_HEAD(&chan->rcu);
+				chan->client = client;
+				spin_lock_irqsave(&client->lock, flags);
+				list_add_tail_rcu(&chan->client_node, &client->channels);
+				spin_unlock_irqrestore(&client->lock, flags);
+				return chan;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+/**
+ * dma_client_chan_free - release a DMA channel
+ * @chan: &dma_chan
+ */
+void dma_async_device_cleanup(struct kref *kref);
+void dma_chan_cleanup(struct kref *kref)
+{
+	struct dma_chan *chan = container_of(kref, struct dma_chan, refcount);
+	chan->device->device_free_chan_resources(chan);
+	chan->client = NULL;
+	kref_put(&chan->device->refcount, dma_async_device_cleanup);
+}
+
+static void dma_chan_free_rcu(struct rcu_head *rcu)
+{
+	struct dma_chan *chan = container_of(rcu, struct dma_chan, rcu);
+	int bias = 0x7FFFFFFF;
+	int i;
+	for_each_cpu(i)
+		bias -= local_read(&per_cpu_ptr(chan->local, i)->refcount);
+	atomic_sub(bias, &chan->refcount.refcount);
+	kref_put(&chan->refcount, dma_chan_cleanup);
+}
+
+static void dma_client_chan_free(struct dma_chan *chan)
+{
+	atomic_add(0x7FFFFFFF, &chan->refcount.refcount);
+	chan->slow_ref = 1;
+	call_rcu(&chan->rcu, dma_chan_free_rcu);
+}
+
+/**
+ * dma_chans_rebalance - reallocate channels to clients
+ *
+ * When the number of DMA channel in the system changes,
+ * channels need to be rebalanced among clients
+ */
+static void dma_chans_rebalance(void)
+{
+	struct dma_client *client;
+	struct dma_chan *chan;
+	unsigned long flags;
+
+	spin_lock(&dma_list_lock);
+	list_for_each_entry(client, &dma_client_list, global_node) {
+
+		while (client->chans_desired > client->chan_count) {
+			chan = dma_client_chan_alloc(client);
+			if (!chan)
+				break;
+
+			client->chan_count++;
+			client->event_callback(client, chan, DMA_RESOURCE_ADDED);
+		}
+
+		while (client->chans_desired < client->chan_count) {
+			spin_lock_irqsave(&client->lock, flags);
+			chan = list_entry(client->channels.next, struct dma_chan, client_node);
+			list_del_rcu(&chan->client_node);
+			spin_unlock_irqrestore(&client->lock, flags);
+			client->chan_count--;
+			client->event_callback(client, chan, DMA_RESOURCE_REMOVED);
+			dma_client_chan_free(chan);
+		}
+	}
+	spin_unlock(&dma_list_lock);
+}
+
+/**
+ * dma_async_client_register - allocate and register a &dma_client
+ * @event_callback: callback for notification of channel addition/removal
+ */
+struct dma_client *dma_async_client_register(dma_event_callback event_callback)
+{
+	struct dma_client *client;
+
+	client = kzalloc(sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return NULL;
+
+	INIT_LIST_HEAD(&client->channels);
+	spin_lock_init(&client->lock);
+
+	client->chans_desired = 0;
+	client->chan_count = 0;
+	client->event_callback = event_callback;
+
+	spin_lock(&dma_list_lock);
+	list_add_tail(&client->global_node, &dma_client_list);
+	spin_unlock(&dma_list_lock);
+
+	return client;
+}
+
+/**
+ * dma_async_client_unregister - unregister a client and free the &dma_client
+ * @client:
+ *
+ * Force frees any allocated DMA channels, frees the &dma_client memory
+ */
+void dma_async_client_unregister(struct dma_client *client)
+{
+	struct dma_chan *chan;
+
+	if (!client)
+		return;
+
+	rcu_read_lock();
+	list_for_each_entry_rcu(chan, &client->channels, client_node) {
+		dma_client_chan_free(chan);
+	}
+	rcu_read_unlock();
+
+	spin_lock(&dma_list_lock);
+	list_del(&client->global_node);
+	spin_unlock(&dma_list_lock);
+
+	kfree(client);
+	dma_chans_rebalance();
+}
+
+/**
+ * dma_async_client_chan_request - request DMA channels
+ * @client: &dma_client
+ * @number: count of DMA channels requested
+ *
+ * Clients call dma_async_client_chan_request() to specify how many
+ * DMA channels they need, 0 to free all currently allocated.
+ * The resulting allocations/frees are indicated to the client via the
+ * event callback.
+ */
+void dma_async_client_chan_request(struct dma_client *client,
+			unsigned int number)
+{
+	client->chans_desired = number;
+	dma_chans_rebalance();
+}
+
+/**
+ * dma_async_device_register -
+ * @device: &dma_device
+ */
+int dma_async_device_register(struct dma_device *device)
+{
+	static int id;
+	int chancnt = 0;
+	struct dma_chan* chan;
+
+	if (!device)
+		return -ENODEV;
+
+	init_completion(&device->done);
+	kref_init(&device->refcount);
+	device->dev_id = id++;
+
+	/* represent channels in sysfs. Probably want devs too */
+	list_for_each_entry(chan, &device->channels, device_node) {
+		chan->local = alloc_percpu(typeof(*chan->local));
+		if (chan->local == NULL)
+			continue;
+
+		chan->chan_id = chancnt++;
+		chan->class_dev.class = &dma_devclass;
+		chan->class_dev.dev = NULL;
+		snprintf(chan->class_dev.class_id, BUS_ID_SIZE, "dma%dchan%d",
+		         device->dev_id, chan->chan_id);
+
+		kref_get(&device->refcount);
+		class_device_register(&chan->class_dev);
+	}
+
+	spin_lock(&dma_list_lock);
+	list_add_tail(&device->global_node, &dma_device_list);
+	spin_unlock(&dma_list_lock);
+
+	dma_chans_rebalance();
+
+	return 0;
+}
+
+/**
+ * dma_async_device_unregister -
+ * @device: &dma_device
+ */
+static void dma_async_device_cleanup(struct kref *kref)
+{
+	struct dma_device *device = container_of(kref, struct dma_device, refcount);
+	complete(&device->done);
+}
+
+void dma_async_device_unregister(struct dma_device* device)
+{
+	struct dma_chan *chan;
+	unsigned long flags;
+
+	spin_lock(&dma_list_lock);
+	list_del(&device->global_node);
+	spin_unlock(&dma_list_lock);
+
+	list_for_each_entry(chan, &device->channels, device_node) {
+		if (chan->client) {
+			spin_lock_irqsave(&chan->client->lock, flags);
+			list_del(&chan->client_node);
+			chan->client->chan_count--;
+			spin_unlock_irqrestore(&chan->client->lock, flags);
+			chan->client->event_callback(chan->client, chan, DMA_RESOURCE_REMOVED);
+			dma_client_chan_free(chan);
+		}
+		class_device_unregister(&chan->class_dev);
+	}
+
+	dma_chans_rebalance();
+
+	kref_put(&device->refcount, dma_async_device_cleanup);
+	wait_for_completion(&device->done);
+}
+
+static int __init dma_bus_init(void)
+{
+	spin_lock_init(&dma_list_lock);
+
+	return class_register(&dma_devclass);
+}
+
+subsys_initcall(dma_bus_init);
+
+EXPORT_SYMBOL(dma_async_client_register);
+EXPORT_SYMBOL(dma_async_client_unregister);
+EXPORT_SYMBOL(dma_async_client_chan_request);
+EXPORT_SYMBOL(dma_async_memcpy_buf_to_buf);
+EXPORT_SYMBOL(dma_async_memcpy_buf_to_pg);
+EXPORT_SYMBOL(dma_async_memcpy_pg_to_pg);
+EXPORT_SYMBOL(dma_async_memcpy_complete);
+EXPORT_SYMBOL(dma_async_memcpy_issue_pending);
+EXPORT_SYMBOL(dma_async_device_register);
+EXPORT_SYMBOL(dma_async_device_unregister);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
new file mode 100644
index 0000000..ac3bff9
--- /dev/null
+++ b/include/linux/dmaengine.h
@@ -0,0 +1,323 @@
+/*****************************************************************************
+Copyright(c) 2004 - 2006 Intel Corporation. All rights reserved.
+
+This program is free software; you can redistribute it and/or modify it
+under the terms of the GNU General Public License as published by the Free
+Software Foundation; either version 2 of the License, or (at your option)
+any later version.
+
+This program is distributed in the hope that it will be useful, but WITHOUT
+ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or
+FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for
+more details.
+
+You should have received a copy of the GNU General Public License along with
+this program; if not, write to the Free Software Foundation, Inc., 59
+Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+
+The full GNU General Public License is included in this distribution in the
+file called LICENSE.
+*****************************************************************************/
+#ifndef DMAENGINE_H
+#define DMAENGINE_H
+#ifdef CONFIG_DMA_ENGINE
+
+#include <linux/device.h>
+#include <linux/uio.h>
+#include <linux/kref.h>
+#include <linux/completion.h>
+#include <linux/rcupdate.h>
+
+/**
+ * enum dma_event - resource PNP/power managment events
+ * @DMA_RESOURCE_SUSPEND: DMA device going into low power state
+ * @DMA_RESOURCE_RESUME: DMA device returning to full power
+ * @DMA_RESOURCE_ADDED: DMA device added to the system
+ * @DMA_RESOURCE_REMOVED: DMA device removed from the system
+ */
+enum dma_event {
+	DMA_RESOURCE_SUSPEND,
+	DMA_RESOURCE_RESUME,
+	DMA_RESOURCE_ADDED,
+	DMA_RESOURCE_REMOVED,
+};
+
+/**
+ * typedef dma_cookie_t
+ *
+ * if dma_cookie_t is >0 it's a DMA request cookie, <0 it's an error code
+ */
+typedef s32 dma_cookie_t;
+
+#define dma_submit_error(cookie) ((cookie) < 0 ? 1 : 0)
+
+/**
+ * enum dma_status - DMA transaction status
+ * @DMA_SUCCESS: transaction completed successfully
+ * @DMA_IN_PROGRESS: transaction not yet processed
+ * @DMA_ERROR: transaction failed
+ */
+enum dma_status {
+	DMA_SUCCESS,
+	DMA_IN_PROGRESS,
+	DMA_ERROR,
+};
+
+struct dma_chan_percpu {
+	local_t refcount;
+	/* stats */
+	unsigned long memcpy_count;
+	unsigned long bytes_transferred;
+};
+
+/**
+ * struct dma_chan - devices supply DMA channels, clients use them
+ * @client: ptr to the client user of this chan, will be NULL when unused
+ * @device: ptr to the dma device who supplies this channel, always !NULL
+ * @cookie: last cookie value returned to client
+ * @chan_id:
+ * @class_dev:
+ * @client_node: used to add this to the client chan list
+ * @device_node: used to add this to the device chan list
+ */
+struct dma_chan {
+	struct dma_client *client;
+	struct dma_device *device;
+	dma_cookie_t cookie;
+
+	/* sysfs */
+	int chan_id;
+	struct class_device class_dev;
+
+	struct kref refcount;
+	int slow_ref;
+	struct rcu_head rcu;
+
+	struct list_head client_node;
+	struct list_head device_node;
+	struct dma_chan_percpu *local;
+};
+
+void dma_chan_cleanup(struct kref *kref);
+
+static inline void dma_chan_get(struct dma_chan *chan)
+{
+	if (unlikely(chan->slow_ref))
+		kref_get(&chan->refcount);
+	else {
+		local_inc(&(per_cpu_ptr(chan->local, get_cpu())->refcount));
+		put_cpu();
+	}
+}
+
+static inline void dma_chan_put(struct dma_chan *chan)
+{
+	if (unlikely(chan->slow_ref))
+		kref_put(&chan->refcount, dma_chan_cleanup);
+	else {
+		local_dec(&(per_cpu_ptr(chan->local, get_cpu())->refcount));
+		put_cpu();
+	}
+}
+
+/*
+ * typedef dma_event_callback - function pointer to a DMA event callback
+ */
+typedef void (*dma_event_callback) (struct dma_client *client,
+		struct dma_chan *chan, enum dma_event event);
+
+/**
+ * struct dma_client - info on the entity making use of DMA services
+ * @event_callback: func ptr to call when something happens
+ * @chan_count: number of chans allocated
+ * @chans_desired: number of chans requested. Can be +/- chan_count
+ * @lock: protects access to the channels list
+ * @channels: the list of DMA channels allocated
+ * @global_node: list_head for global dma_client_list
+ */
+struct dma_client {
+	dma_event_callback	event_callback;
+	unsigned int		chan_count;
+	unsigned int		chans_desired;
+
+	spinlock_t		lock;
+	struct list_head	channels;
+	struct list_head	global_node;
+};
+
+/**
+ * struct dma_device - info on the entity supplying DMA services
+ * @chancnt: how many DMA channels are supported
+ * @channels: the list of struct dma_chan
+ * @global_node: list_head for global dma_device_list
+ * @dev_id:
+ * Other func ptrs: used to make use of this device's capabilities
+ */
+struct dma_device {
+
+	unsigned int chancnt;
+	struct list_head channels;
+	struct list_head global_node;
+
+	struct kref refcount;
+	struct completion done;
+
+	int dev_id;
+
+	int (*device_alloc_chan_resources)(struct dma_chan *chan);
+	void (*device_free_chan_resources)(struct dma_chan *chan);
+	dma_cookie_t (*device_memcpy_buf_to_buf)(struct dma_chan *chan,
+			void *dest, void *src, size_t len);
+	dma_cookie_t (*device_memcpy_buf_to_pg)(struct dma_chan *chan,
+			struct page *page, unsigned int offset, void *kdata,
+			size_t len);
+	dma_cookie_t (*device_memcpy_pg_to_pg)(struct dma_chan *chan,
+			struct page *dest_pg, unsigned int dest_off,
+			struct page *src_pg, unsigned int src_off, size_t len);
+	enum dma_status (*device_memcpy_complete)(struct dma_chan *chan,
+			dma_cookie_t cookie, dma_cookie_t *last,
+			dma_cookie_t *used);
+	void (*device_memcpy_issue_pending)(struct dma_chan *chan);
+};
+
+/* --- public DMA engine API --- */
+
+struct dma_client *dma_async_client_register(dma_event_callback event_callback);
+void dma_async_client_unregister(struct dma_client *client);
+void dma_async_client_chan_request(struct dma_client *client,
+		unsigned int number);
+
+/**
+ * dma_async_memcpy_buf_to_buf - offloaded copy between virtual addresses
+ * @chan: DMA channel to offload copy to
+ * @dest: destination address (virtual)
+ * @src: source address (virtual)
+ * @len: length
+ *
+ * Both @dest and @src must be mappable to a bus address according to the
+ * DMA mapping API rules for streaming mappings.
+ * Both @dest and @src must stay memory resident (kernel memory or locked
+ * user space pages)
+ */
+static inline dma_cookie_t dma_async_memcpy_buf_to_buf(struct dma_chan *chan,
+	void *dest, void *src, size_t len)
+{
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_memcpy_buf_to_buf(chan, dest, src, len);
+}
+
+/**
+ * dma_async_memcpy_buf_to_pg - offloaded copy
+ * @chan: DMA channel to offload copy to
+ * @page: destination page
+ * @offset: offset in page to copy to
+ * @kdata: source address (virtual)
+ * @len: length
+ *
+ * Both @page/@offset and @kdata must be mappable to a bus address according
+ * to the DMA mapping API rules for streaming mappings.
+ * Both @page/@offset and @kdata must stay memory resident (kernel memory or
+ * locked user space pages)
+ */
+static inline dma_cookie_t dma_async_memcpy_buf_to_pg(struct dma_chan *chan,
+	struct page *page, unsigned int offset, void *kdata, size_t len)
+{
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_memcpy_buf_to_pg(chan, page, offset,
+	                                             kdata, len);
+}
+
+/**
+ * dma_async_memcpy_buf_to_pg - offloaded copy
+ * @chan: DMA channel to offload copy to
+ * @dest_page: destination page
+ * @dest_off: offset in page to copy to
+ * @src_page: source page
+ * @src_off: offset in page to copy from
+ * @len: length
+ *
+ * Both @dest_page/@dest_off and @src_page/@src_off must be mappable to a bus
+ * address according to the DMA mapping API rules for streaming mappings.
+ * Both @dest_page/@dest_off and @src_page/@src_off must stay memory resident
+ * (kernel memory or locked user space pages)
+ */
+static inline dma_cookie_t dma_async_memcpy_pg_to_pg(struct dma_chan *chan,
+	struct page *dest_pg, unsigned int dest_off, struct page *src_pg,
+	unsigned int src_off, size_t len)
+{
+	int cpu = get_cpu();
+	per_cpu_ptr(chan->local, cpu)->bytes_transferred += len;
+	per_cpu_ptr(chan->local, cpu)->memcpy_count++;
+	put_cpu();
+
+	return chan->device->device_memcpy_pg_to_pg(chan, dest_pg, dest_off,
+	                                            src_pg, src_off, len);
+}
+
+/**
+ * dma_async_memcpy_issue_pending - flush pending copies to HW
+ * @chan:
+ *
+ * This allows drivers to push copies to HW in batches,
+ * reducing MMIO writes where possible.
+ */
+static inline void dma_async_memcpy_issue_pending(struct dma_chan *chan)
+{
+	return chan->device->device_memcpy_issue_pending(chan);
+}
+
+/**
+ * dma_async_memcpy_complete - poll for transaction completion
+ * @chan: DMA channel
+ * @cookie: transaction identifier to check status of
+ * @last: returns last completed cookie, can be NULL
+ * @used: returns last issued cookie, can be NULL
+ *
+ * If @last and @used are passed in, upon return they reflect the driver
+ * internal state and can be used with dma_async_is_complete() to check
+ * the status of multiple cookies without re-checking hardware state.
+ */
+static inline enum dma_status dma_async_memcpy_complete(struct dma_chan *chan,
+	dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
+{
+	return chan->device->device_memcpy_complete(chan, cookie, last, used);
+}
+
+/**
+ * dma_async_is_complete - test a cookie against chan state
+ * @cookie: transaction identifier to test status of
+ * @last_complete: last know completed transaction
+ * @last_used: last cookie value handed out
+ *
+ * dma_async_is_complete() is used in dma_async_memcpy_complete()
+ * the test logic is seperated for lightweight testing of multiple cookies
+ */
+static inline enum dma_status dma_async_is_complete(dma_cookie_t cookie,
+			dma_cookie_t last_complete, dma_cookie_t last_used)
+{
+	if (last_complete <= last_used) {
+		if ((cookie <= last_complete) || (cookie > last_used))
+			return DMA_SUCCESS;
+	} else {
+		if ((cookie <= last_complete) && (cookie > last_used))
+			return DMA_SUCCESS;
+	}
+	return DMA_IN_PROGRESS;
+}
+
+
+/* --- DMA device --- */
+
+int dma_async_device_register(struct dma_device *device);
+void dma_async_device_unregister(struct dma_device *device);
+
+#endif /* CONFIG_DMA_ENGINE */
+#endif /* DMAENGINE_H */

