Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbVLUFSW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbVLUFSW (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 21 Dec 2005 00:18:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751111AbVLUFST
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 21 Dec 2005 00:18:19 -0500
Received: from fmr19.intel.com ([134.134.136.18]:25303 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S1751107AbVLUFRj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 21 Dec 2005 00:17:39 -0500
Subject: [RFC][PATCH 1/5] I/OAT DMA support and TCP acceleration
From: Chris Leech <christopher.leech@intel.com>
To: lkml <linux-kernel@vger.kernel.org>, netdev <netdev@vger.kernel.org>
Cc: "Grover, Andrew" <andrew.grover@intel.com>,
       "Ronciak, John" <john.ronciak@intel.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Date: Tue, 20 Dec 2005 21:17:34 -0800
Message-Id: <1135142254.13781.18.camel@cleech-mobl>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-7) 
X-OriginalArrivalTime: 21 Dec 2005 05:17:37.0406 (UTC) FILETIME=[DB7761E0:01C605ED]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DMA memcpy subsystem
Provides an API for offloading memory copies to DMA devices.
Along with client registration and DMA channel allocation, the main APIs are:
	dma_async_memcpy_buf_to_buf()
	dma_async_memcpy_buf_to_pg()
	dma_async_memcpy_pg_to_pg()
	dma_async_memcpy_complete()

---
 drivers/dma/Kconfig         |   34 +++
 drivers/dma/Makefile        |    3 
 drivers/dma/dmaengine.c     |  391 ++++++++++++++++++++++++++++++++++++++++++++
 include/linux/dmaengine.h   |  220 ++++++++++++++++++++++++
 drivers/Kconfig             |    2 
 drivers/Makefile            |    1 
 6 files changed, 651 insertions(+)

--- /dev/null
+++ b/drivers/dma/Kconfig
@@ -0,0 +1,34 @@
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
+comment "DMA Clients"
+
+config NET_DMA
+	bool "Network: TCP receive copy offload"
+	depends on DMA_ENGINE
+	default y
+	---help---
+	  This enables the use of DMA engines in the network stack to
+	  offload receive copy-to-user operations, freeing CPU cycles.
+	  Since this is the main user of the DMA engine, it should be enabled;
+	  say Y here.
+
+comment "DMA Devices"
+
+config INTEL_IOATDMA
+	tristate "Intel I/OAT DMA support"
+	depends on DMA_ENGINE
+	default m
+	---help---
+	  Enable support for the Intel I/OAT DMA engine.
+
+endmenu
--- /dev/null
+++ b/drivers/dma/Makefile
@@ -0,0 +1,3 @@
+obj-y += dmaengine.o
+
+obj-$(CONFIG_INTEL_IOATDMA) += ioatdma.o
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -66,4 +66,6 @@ source "drivers/infiniband/Kconfig"
 
 source "drivers/sn/Kconfig"
 
+source "drivers/dma/Kconfig"
+
 endmenu
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_DMA_ENGINE)	+= dma/
--- /dev/null
+++ b/include/linux/dmaengine.h
@@ -0,0 +1,220 @@
+/*****************************************************************************
+Copyright(c) 2004 - 2005 Intel Corporation. All rights reserved.
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
+
+#include <linux/device.h>
+#include <linux/uio.h>
+#include <linux/skbuff.h>
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
+/**
+ * struct dma_chan - devices supply DMA channels, clients use them
+ * @client: ptr to the client user of this chan, will be NULL when unused
+ * @device: ptr to the dma device who supplies this channel, always !NULL
+ * @cookie: last cookie value returned to client
+ * @chan_id:
+ * @class_dev:
+ * @memcpy_count: transaction count
+ * @bytes_transferred: octet count
+ * @client_node: used to add this to the client chan list
+ * @device_node: used to add this to the device chan list
+ */
+struct dma_chan
+{
+	struct dma_client *client;
+	struct dma_device *device;
+	dma_cookie_t cookie;
+
+	/* sysfs */
+	int chan_id;
+	struct class_device class_dev;
+
+	/* stats */
+	unsigned long memcpy_count;
+	unsigned long bytes_transferred;
+
+	struct list_head client_node;
+	struct list_head device_node;
+};
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
+ * @channels: the list of DMA channels allocated
+ * @global_node: list_head for global dma_client_list
+ */
+struct dma_client {
+	dma_event_callback	event_callback;
+	unsigned int		chan_count;
+	unsigned int		chans_desired;
+
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
+dma_cookie_t dma_async_memcpy_buf_to_buf(struct dma_chan *chan, void *dest,
+		void *src, size_t len);
+dma_cookie_t dma_async_memcpy_buf_to_pg(struct dma_chan *chan,
+		struct page *page, unsigned int offset, void *kdata, size_t len);
+dma_cookie_t dma_async_memcpy_pg_to_pg(struct dma_chan *chan,
+		struct page *dest_pg, unsigned int dest_off,
+		struct page *src_pg, unsigned int src_off, size_t len);
+void dma_async_memcpy_issue_pending(struct dma_chan *);
+enum dma_status dma_async_wait_for_completion(struct dma_chan *chan,
+		dma_cookie_t cookie);
+enum dma_status dma_async_memcpy_complete(struct dma_chan *chan,
+		dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used);
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
+			dma_cookie_t last_complete, dma_cookie_t last_used) {
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
+/* --- net iovec stuff --- */
+
+DECLARE_PER_CPU(struct dma_chan *, net_dma);
+
+struct dma_page_list
+{
+	char *base_address;
+	int nr_pages;
+	struct page **pages;
+};
+
+struct dma_locked_list
+{
+	int nr_iovecs;
+	struct dma_page_list page_list[0];
+};
+
+int dma_lock_iovec_pages(struct iovec *iov, size_t len,
+		struct dma_locked_list **locked_list);
+void dma_unlock_iovec_pages(struct dma_locked_list* locked_list);
+int dma_skb_copy_datagram_iovec(struct dma_chan* chan,
+		const struct sk_buff *skb, int offset, struct iovec *to,
+		size_t len, struct dma_locked_list *locked_list);
+void dma_memcpy_toiovec_wait(struct dma_chan *chan, dma_cookie_t cookie);
+void dma_async_try_early_copy(struct sock *sk, struct sk_buff *skb);
+
+#endif /* DMAENGINE_H */
--- /dev/null
+++ b/drivers/dma/dmaengine.c
@@ -0,0 +1,391 @@
+/*****************************************************************************
+Copyright(c) 2004 - 2005 Intel Corporation. All rights reserved.
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
+
+static LIST_HEAD(dma_device_list);
+static LIST_HEAD(dma_client_list);
+
+/* --- sysfs implementation --- */
+
+static ssize_t show_memcpy_count(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+
+	sprintf(buf, "%lu\n", chan->memcpy_count);
+	return strlen(buf) + 1;
+}
+
+static ssize_t show_bytes_transferred(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+
+	sprintf(buf, "%lu\n", chan->bytes_transferred);
+	return strlen(buf) + 1;
+}
+
+static ssize_t show_in_use(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+
+	sprintf(buf, "%d\n", (chan->client ? 1 : 0));
+	return strlen(buf) + 1;
+}
+
+static struct class_device_attribute dma_class_attrs[] = {
+	__ATTR(memcpy_count, S_IRUGO, show_memcpy_count, NULL),
+	__ATTR(bytes_transferred, S_IRUGO, show_bytes_transferred, NULL),
+	__ATTR(in_use, S_IRUGO, show_in_use, NULL),
+	__ATTR_NULL
+};
+
+static struct class dma_devclass = {
+	.name            = "dma",
+	.class_dev_attrs = dma_class_attrs,
+};
+
+/* --- client and device registration --- */
+
+/**
+ * dma_client_chan_alloc - try to allocate a channel to a client
+ * @client: &dma_client
+ */
+static struct dma_chan * dma_client_chan_alloc(struct dma_client *client)
+{
+	struct dma_device *device;
+	struct dma_chan *chan;
+
+	/* Find a channel, any DMA engine will do */
+	list_for_each_entry(device, &dma_device_list, global_node) {
+		list_for_each_entry(chan, &device->channels, device_node) {
+			if (chan->client)
+				continue;
+
+			if (chan->device->device_alloc_chan_resources(chan) >= 0) {
+				chan->client = client;
+				list_add_tail(&chan->client_node, &client->channels);
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
+static void dma_client_chan_free(struct dma_chan *chan)
+{
+	chan->device->device_free_chan_resources(chan);
+	chan->client = NULL;
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
+
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
+			chan = list_entry(client->channels.next, struct dma_chan, client_node);
+			list_del(&chan->client_node);
+			client->chan_count--;
+			client->event_callback(client, chan, DMA_RESOURCE_REMOVED);
+			dma_client_chan_free(chan);
+		}
+	}
+}
+
+/**
+ * dma_async_client_register - allocate and register a &dma_client
+ * @event_callback: callback for notification of channel addition/removal
+ */
+struct dma_client * dma_async_client_register(dma_event_callback event_callback)
+{
+	struct dma_client *client;
+
+	client = kmalloc(sizeof(*client), GFP_KERNEL);
+	if (!client)
+		return NULL;
+
+	INIT_LIST_HEAD(&client->channels);
+
+	client->chans_desired = 0;
+	client->chan_count = 0;
+	client->event_callback = event_callback;
+
+	list_add_tail(&client->global_node, &dma_client_list);
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
+	struct dma_chan *chan, *_chan;
+
+	if (!client)
+		return;
+
+	list_for_each_entry_safe(chan, _chan, &client->channels, client_node) {
+		dma_client_chan_free(chan);
+	}
+
+	list_del(&client->global_node);
+
+	kfree(client);
+
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
+dma_cookie_t dma_async_memcpy_buf_to_buf(struct dma_chan *chan, void *dest,
+			void *src, size_t len)
+{
+	chan->bytes_transferred += len;
+	chan->memcpy_count++;
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
+dma_cookie_t dma_async_memcpy_buf_to_pg(struct dma_chan *chan,
+			struct page *page, unsigned int offset, void *kdata,
+			size_t len)
+{
+	chan->bytes_transferred += len;
+	chan->memcpy_count++;
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
+dma_cookie_t dma_async_memcpy_pg_to_pg(struct dma_chan *chan,
+			struct page *dest_pg, unsigned int dest_off,
+			struct page *src_pg, unsigned int src_off, size_t len)
+{
+	chan->bytes_transferred += len;
+	chan->memcpy_count++;
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
+void dma_async_memcpy_issue_pending(struct dma_chan *chan)
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
+enum dma_status dma_async_memcpy_complete(struct dma_chan *chan,
+			dma_cookie_t cookie, dma_cookie_t *last,
+			dma_cookie_t *used)
+{
+	return chan->device->device_memcpy_complete(chan, cookie, last, used);
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
+	list_add_tail(&device->global_node, &dma_device_list);
+
+	dma_chans_rebalance();
+
+	device->dev_id = id++;
+
+	/* represent channels in sysfs. Probably want devs too */
+	list_for_each_entry(chan, &device->channels, device_node) {
+		chan->chan_id = chancnt++;
+		chan->class_dev.class = &dma_devclass;
+		chan->class_dev.dev = NULL;
+		snprintf(chan->class_dev.class_id, BUS_ID_SIZE, "dma%dchan%d",
+		         device->dev_id, chan->chan_id);
+
+		class_device_register(&chan->class_dev);
+	}
+
+	return 0;
+}
+
+/**
+ * dma_async_device_unregister -
+ * @device: &dma_device
+ */
+void dma_async_device_unregister(struct dma_device* device)
+{
+	struct dma_chan *chan;
+
+	list_for_each_entry(chan, &device->channels, device_node) {
+		if (chan->client) {
+			list_del(&chan->client_node);
+			chan->client->chan_count--;
+			chan->client->event_callback(chan->client, chan, DMA_RESOURCE_REMOVED);
+			dma_client_chan_free(chan);
+		}
+		class_device_unregister(&chan->class_dev);
+	}
+
+	list_del(&device->global_node);
+
+	dma_chans_rebalance();
+}
+
+/**
+ * dma_async_wait_for_completion - poll and schedule() until complete
+ * @chan:
+ * @cookie:
+ */
+enum dma_status dma_async_wait_for_completion(struct dma_chan *chan,
+			dma_cookie_t cookie)
+{
+	while (dma_async_memcpy_complete(chan, cookie, NULL, NULL) == DMA_IN_PROGRESS)
+		schedule();
+
+	return DMA_SUCCESS;
+}
+
+static int __init dma_bus_init(void)
+{
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
+EXPORT_SYMBOL(dma_async_wait_for_completion);

