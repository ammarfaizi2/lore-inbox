Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932369AbVKWU1H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932369AbVKWU1H (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Nov 2005 15:27:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932363AbVKWU04
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Nov 2005 15:26:56 -0500
Received: from fmr19.intel.com ([134.134.136.18]:43199 "EHLO
	orsfmr004.jf.intel.com") by vger.kernel.org with ESMTP
	id S932346AbVKWU0n (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Nov 2005 15:26:43 -0500
Date: Wed, 23 Nov 2005 12:26:42 -0800 (PST)
From: Andrew Grover <andrew.grover@intel.com>
X-X-Sender: agrover@isotope.jf.intel.com
To: netdev@vger.kernel.org, <linux-kernel@vger.kernel.org>
cc: john.ronciak@intel.com, <christopher.leech@intel.com>
Subject: [RFC] [PATCH 1/3] ioat: DMA subsystem
Message-ID: <Pine.LNX.4.44.0511231207410.32487-100000@isotope.jf.intel.com>
ReplyTo: "Andrew Grover" <andrew.grover@intel.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


diff --git a/drivers/Kconfig b/drivers/Kconfig
index 48f446d..fbe5116 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -66,4 +66,6 @@ source "drivers/infiniband/Kconfig"
 
 source "drivers/sn/Kconfig"
 
+source "drivers/dma/Kconfig"
+
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index 1a109a6..4bd0ab6 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -67,3 +67,4 @@ obj-$(CONFIG_INFINIBAND)	+= infiniband/
 obj-$(CONFIG_SGI_IOC4)		+= sn/
 obj-y				+= firmware/
 obj-$(CONFIG_CRYPTO)		+= crypto/
+obj-$(CONFIG_DMA_ENGINE)	+= dma/
diff --git a/drivers/dma/Kconfig b/drivers/dma/Kconfig
new file mode 100644
index 0000000..dde603d
--- /dev/null
+++ b/drivers/dma/Kconfig
@@ -0,0 +1,40 @@
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
+config NET_DMA
+	bool "Use DMA engines in the network stack"
+	depends on DMA_ENGINE
+	---help---
+	  Say Y to enable the use of DMA engines in the network stack to
+	  offload receive copy-to-user operations, freeing CPU cycles.
+
+config NET_DMA_EARLY
+	bool "Do early DMA copies"
+	depends on NET_DMA
+	---help---
+	  Enabling this will cause the network stack to start DMA copies
+	  earlier. This can improve throughput, but this is also a more
+	  invasive change, and can be unstable.
+
+#
+# 
+#
+
+config DMA_TESTCLIENT
+	tristate "DMA test client"
+	depends on DMA_ENGINE
+	---help---
+	  The CB test client driver performs a DMA-assisted memcpy on module
+	  load, and prints the result when unloaded. It is pretty simple, but
+	  maybe someday this will grow up into an actually useful test client.
+
+endmenu
diff --git a/drivers/dma/Makefile b/drivers/dma/Makefile
new file mode 100644
index 0000000..abb83be
--- /dev/null
+++ b/drivers/dma/Makefile
@@ -0,0 +1,5 @@
+-include $(PWD)/config
+
+obj-y += dmaengine.o
+
+obj-$(CONFIG_DMA_TESTCLIENT) += testclient.o
diff --git a/drivers/dma/cb_list.h b/drivers/dma/cb_list.h
new file mode 100644
index 0000000..f2cc2d7
--- /dev/null
+++ b/drivers/dma/cb_list.h
@@ -0,0 +1,12 @@
+/* Extra macros that build on <linux/list.h> */
+#ifndef CB_LIST_H
+#define CB_LIST_H
+
+#include <linux/list.h>
+
+/* Provide some safty to list_add, which I find easy to swap the arguments to */
+
+#define list_add_entry(pos, head, member)      list_add(&pos->member, head)
+#define list_add_entry_tail(pos, head, member) list_add_tail(&pos->member, head)
+
+#endif /* CB_LIST_H */
diff --git a/drivers/dma/dmaengine.c b/drivers/dma/dmaengine.c
new file mode 100644
index 0000000..fe240c8
--- /dev/null
+++ b/drivers/dma/dmaengine.c
@@ -0,0 +1,394 @@
+/*******************************************************************************
+
+  
+  Copyright(c) 2004 - 2005 Intel Corporation. All rights reserved.
+  
+  This program is free software; you can redistribute it and/or modify it 
+  under the terms of the GNU General Public License as published by the Free 
+  Software Foundation; either version 2 of the License, or (at your option) 
+  any later version.
+  
+  This program is distributed in the hope that it will be useful, but WITHOUT 
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for 
+  more details.
+  
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc., 59 
+  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+  
+  The full GNU General Public License is included in this distribution in the
+  file called LICENSE.
+  
+*******************************************************************************/
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/device.h>
+#include <linux/dmaengine.h>
+#include <linux/hardirq.h>
+#include <linux/spinlock.h>
+#include <linux/percpu.h>
+#include "cb_list.h"
+
+static LIST_HEAD(dma_device_list);
+static LIST_HEAD(dma_client_list);
+
+DEFINE_PER_CPU(struct completion, kick_dma_poll);
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
+static ssize_t show_min_hw_copy_size(struct class_device *cd, char *buf)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+
+	sprintf(buf, "%d\n", chan->min_copy_size);
+	return strlen(buf) + 1;
+}
+
+static ssize_t store_min_hw_copy_size(struct class_device *cd, const char *buf, size_t count)
+{
+	struct dma_chan *chan = container_of(cd, struct dma_chan, class_dev);
+
+	chan->min_copy_size = simple_strtoul(buf, NULL, 0);
+
+	return count;
+}
+
+static struct class_device_attribute dma_class_attrs[] = {
+	__ATTR(memcpy_count, S_IRUGO, show_memcpy_count, NULL),
+	__ATTR(bytes_transferred, S_IRUGO, show_bytes_transferred, NULL),
+	__ATTR(in_use, S_IRUGO, show_in_use, NULL),
+	__ATTR(min_copy_size, S_IRUGO | S_IWUSR, show_min_hw_copy_size, store_min_hw_copy_size),
+	__ATTR_NULL
+};
+
+static void
+dma_class_release(struct class_device *cd)
+{
+	/* do something */
+}
+
+static struct class dma_devclass = {
+	.name		= "dma",
+	.release	= dma_class_release,
+	.class_dev_attrs = dma_class_attrs,
+};
+
+/* --- client and device registration --- */
+
+static struct dma_chan *
+dma_client_chan_alloc(struct dma_client *client)
+{
+	struct dma_device *device;
+	struct dma_chan *chan;
+
+	BUG_ON(!client);
+
+	/* Find a channel, any DMA engine will do */
+	list_for_each_entry(device, &dma_device_list, global_node) {
+		list_for_each_entry(chan, &device->channels, device_node) {
+			if (chan->client)
+				continue;
+
+			if (chan->device->device_alloc_chan_resources(chan) >= 0) {
+				chan->client = client;
+				list_add_entry_tail(chan, &client->channels, client_node);
+				return chan;
+			}
+		}
+	}
+
+	return NULL;
+}
+
+static void
+dma_client_chan_free(struct dma_chan *chan)
+{
+	BUG_ON(!chan);
+
+	chan->device->device_free_chan_resources(chan);
+	chan->client = NULL;
+}
+
+static void
+dma_chans_rebalance(void)
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
+struct dma_client *
+dma_async_client_register(dma_event_callback event_callback)
+{
+	struct dma_client *client;
+
+	BUG_ON(!event_callback);
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
+	list_add_entry_tail(client, &dma_client_list, global_node);
+
+	return client;
+}
+
+void
+dma_async_client_unregister(struct dma_client *client)
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
+void
+dma_async_client_chan_request(struct dma_client *client, unsigned int number)
+{
+	BUG_ON(!client);
+
+	client->chans_desired = number;
+
+	dma_chans_rebalance();
+}
+
+dma_cookie_t
+dma_async_memcpy_buf_to_buf(
+	struct dma_chan *chan,
+	void *dest,
+	void *src,
+	size_t len)
+{
+	chan->bytes_transferred += len;
+	chan->memcpy_count++;
+
+	return chan->device->device_memcpy_buf_to_buf(chan, dest, src, len);
+}
+
+dma_cookie_t
+dma_async_memcpy_buf_to_pg(
+	struct dma_chan *chan,
+	struct page *page,
+	unsigned int offset,
+	void *kdata,
+	size_t len)
+{
+	chan->bytes_transferred += len;
+	chan->memcpy_count++;
+
+	return chan->device->device_memcpy_buf_to_pg(chan, page, offset, kdata, len);
+}
+
+dma_cookie_t
+dma_async_memcpy_pg_to_pg(
+	struct dma_chan *chan,
+	struct page *dest_pg,
+	unsigned int dest_off,
+	struct page *src_pg,
+	unsigned int src_off,
+	size_t len)
+{
+	chan->bytes_transferred += len;
+	chan->memcpy_count++;
+
+	return chan->device->device_memcpy_pg_to_pg(chan, dest_pg, dest_off,
+		src_pg, src_off, len);
+}
+
+void
+dma_async_memcpy_issue_pending(struct dma_chan *chan)
+{
+	return chan->device->device_memcpy_issue_pending(chan);
+}
+
+enum dma_status_t
+dma_async_memcpy_complete(struct dma_chan *chan, dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used)
+{
+	return chan->device->device_memcpy_complete(chan, cookie, last, used);
+}
+
+int
+dma_async_device_register(struct dma_device *device)
+{
+	static int id;
+	int chancnt = 0;
+	struct dma_chan* chan;
+
+	if (!device)
+		return -ENODEV;
+
+	list_add_entry_tail(device, &dma_device_list, global_node);
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
+			device->dev_id, chan->chan_id);
+
+		chan->min_copy_size = DMA_DEFAULT_MIN_COPY_SIZE;
+		class_device_register(&chan->class_dev);
+	}
+
+	return 0;
+}
+
+void
+dma_async_device_unregister(struct dma_device* device)
+{
+	struct dma_chan *chan;
+
+	BUG_ON(!device);
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
+static struct workqueue_struct *dma_wait_wq;
+static LIST_HEAD(dma_poll_list);
+
+enum dma_status_t
+dma_async_wait_for_completion(struct dma_chan *chan, dma_cookie_t cookie)
+{
+	while (dma_async_memcpy_complete(chan, cookie, NULL, NULL) == DMA_IN_PROGRESS)
+		schedule();
+
+	return DMA_SUCCESS;
+}
+
+#if 0
+static void
+dma_poll(void *data)
+{
+	struct dma_completion *comp = data;
+
+	comp->status = dma_memcpy_complete(comp->chan, comp->cookie);
+	while (comp->status == DMA_IN_PROGRESS) {
+		comp->chan->device->device_arm_interrupt(comp->chan);
+		wait_for_completion(&__get_cpu_var(kick_dma_poll));
+		comp->status = dma_memcpy_complete(comp->chan, comp->cookie);
+	}
+	complete(&comp->comp);
+}
+
+enum dma_status_t
+dma_wait_for_completion(struct dma_chan *chan, dma_cookie_t cookie)
+{
+	enum dma_status_t status;
+	DECLARE_DMA_COMPLETION(comp, chan, cookie);
+	DECLARE_WORK(dma_wait_work, dma_poll, &comp);
+
+	BUG_ON(in_interrupt());
+
+	status = dma_memcpy_complete(chan, cookie);
+	if (status != DMA_IN_PROGRESS)
+		return status;
+
+	queue_work(dma_wait_wq, &dma_wait_work);
+	wait_for_completion(&comp.comp);
+	return comp.status;
+}
+#endif
+
+static int __init dma_bus_init(void)
+{
+	int cpu;
+
+	dma_wait_wq = create_workqueue("dmapoll");
+	for_each_online_cpu(cpu) {
+		init_completion(&per_cpu(kick_dma_poll, cpu));
+	}
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
+EXPORT_PER_CPU_SYMBOL(kick_dma_poll);
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
new file mode 100644
index 0000000..7b4f58b
--- /dev/null
+++ b/include/linux/dmaengine.h
@@ -0,0 +1,268 @@
+/*******************************************************************************
+
+  
+  Copyright(c) 2004 - 2005 Intel Corporation. All rights reserved.
+  
+  This program is free software; you can redistribute it and/or modify it 
+  under the terms of the GNU General Public License as published by the Free 
+  Software Foundation; either version 2 of the License, or (at your option) 
+  any later version.
+  
+  This program is distributed in the hope that it will be useful, but WITHOUT 
+  ANY WARRANTY; without even the implied warranty of MERCHANTABILITY or 
+  FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License for 
+  more details.
+  
+  You should have received a copy of the GNU General Public License along with
+  this program; if not, write to the Free Software Foundation, Inc., 59 
+  Temple Place - Suite 330, Boston, MA  02111-1307, USA.
+  
+  The full GNU General Public License is included in this distribution in the
+  file called LICENSE.
+  
+*******************************************************************************/
+
+
+#ifndef DMAENGINE_H
+#define DMAENGINE_H
+
+#include <linux/device.h>
+#include <linux/uio.h>
+#include <linux/skbuff.h>
+
+DECLARE_PER_CPU(struct completion, kick_dma_poll);
+
+#define DMA_DEFAULT_MIN_COPY_SIZE 16
+
+/**
+ * enum dma_event_t - resource PNP/power managment events
+ * @DMA_RESOURCE_SUSPEND: DMA device going into low power state
+ * @DMA_RESOURCE_RESUME: DMA device returning to full power
+ * @DMA_RESOURCE_ADDED: DMA device added to the system
+ * @DMA_RESOURCE_REMOVED: DMA device removed from the system
+ */
+enum dma_event_t {
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
+/*#define dma_submit_error(cookie) ((cookie) < 0 ? 1 : 0)*/
+
+/**
+ * enum dma_status_t - DMA transaction status
+ * @DMA_SUCCESS: transaction completed successfully
+ * @DMA_IN_PROGRESS: transaction not yet processed
+ * @DMA_ERROR: transaction failed
+ */
+enum dma_status_t {
+	DMA_SUCCESS,
+	DMA_IN_PROGRESS,
+	DMA_ERROR,
+};
+
+/**
+ * struct dma_chan - devices supply DMA channels, clients use them
+ * @client: ptr to the client user of this chan, will be NULL when unused
+ * @device: ptr to the dma device who supplies this channel, always !NULL
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
+	unsigned int min_copy_size;
+
+	struct list_head client_node;
+	struct list_head device_node;
+
+	cpumask_t cpumask;
+};
+
+/*
+ * typedef dma_event_callback - function pointer to a DMA event callback
+ */
+typedef void (*dma_event_callback) (struct dma_client *client, struct dma_chan *chan, enum dma_event_t event);
+
+/**
+ * struct dma_client - info on the entity making use of DMA services
+ * @event_callback: func ptr to call when something happens
+ * @chan_count: number of chans allocated
+ * @chans_desired: number of chans requested. Can be +- chan_count
+ * @port: upstream DMA port from the client's PCI device
+ * @channels: the list of DMA channels allocated
+ * @global_node: list_head for global dma_client_list
+ */
+struct dma_client {
+	dma_event_callback	event_callback;
+	unsigned int		chan_count;
+	unsigned int		chans_desired;
+
+	/* TODO keep some stats */
+	struct list_head	channels;
+	struct list_head	global_node;
+};
+
+/**
+ * struct dma_device - info on the entity supplying DMA services
+ * @chancnt: how many DMA channels are supported
+ * @channels: the list of struct dma_chan
+ * @global_node: list_head for global dma_device_list
+ * Other func ptrs: used to make use of this device's capabilities
+ */
+struct dma_device {
+
+	unsigned int chancnt;
+	struct list_head channels;
+	struct list_head global_node;
+
+	int dev_id;
+	/*struct class_device class_dev;*/
+
+	int (*device_alloc_chan_resources)(struct dma_chan *chan);
+	void (*device_free_chan_resources)(struct dma_chan *chan);
+	dma_cookie_t (*device_memcpy_buf_to_buf)(struct dma_chan *chan, void *dest,
+		void *src, size_t len);
+	dma_cookie_t (*device_memcpy_buf_to_pg)(struct dma_chan *chan, struct page *page,
+		unsigned int offset, void *kdata, size_t len);
+	dma_cookie_t (*device_memcpy_pg_to_pg)(struct dma_chan *chan, struct page *dest_pg,
+		unsigned int dest_off, struct page *src_pg, unsigned int src_off,
+		size_t len);
+	void (*device_arm_interrupt)(struct dma_chan *chan);
+	enum dma_status_t (*device_memcpy_complete)(struct dma_chan *chan, dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used);
+	void (*device_memcpy_issue_pending)(struct dma_chan *chan);
+};
+
+/* --- public DMA engine API --- */
+
+struct dma_client *
+dma_async_client_register(dma_event_callback event_callback);
+
+void
+dma_async_client_unregister(struct dma_client *client);
+
+void
+dma_async_client_chan_request(struct dma_client *client, unsigned int number);
+
+dma_cookie_t
+dma_async_memcpy_buf_to_buf(
+	struct dma_chan *chan,
+	void *dest,
+	void *src,
+	size_t len);
+
+dma_cookie_t
+dma_async_memcpy_buf_to_pg(
+	struct dma_chan *chan,
+	struct page *page,
+	unsigned int offset,
+	void *kdata,
+	size_t len);
+
+dma_cookie_t
+dma_async_memcpy_pg_to_pg(
+	struct dma_chan *chan,
+	struct page *dest_pg,
+	unsigned int dest_off,
+	struct page *src_pg,
+	unsigned int src_off,
+	size_t len);
+
+void dma_async_memcpy_issue_pending(struct dma_chan *);
+
+enum dma_status_t
+dma_async_wait_for_completion(struct dma_chan *chan, dma_cookie_t cookie);
+
+static inline enum dma_status_t
+dma_async_is_complete(
+	dma_cookie_t cookie,
+	dma_cookie_t last_complete,
+	dma_cookie_t last_used) {
+	
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
+enum dma_status_t
+dma_async_memcpy_complete(struct dma_chan *chan, dma_cookie_t cookie, dma_cookie_t *last, dma_cookie_t *used);
+
+u32
+dma_async_get_errors(struct dma_chan *chan, dma_cookie_t cookie);
+
+/* --- DMA device --- */
+
+int dma_async_device_register(
+	struct dma_device *device);
+
+void dma_async_device_unregister(
+	struct dma_device *device);
+
+/* --- DMA completion --- */
+
+struct dma_completion
+{
+	struct dma_chan *chan;
+	dma_cookie_t cookie;
+	enum dma_status_t status;
+	struct completion comp;
+};
+
+#define DMA_COMPLETION_INITIALIZER(name, chan, cookie) \
+{	.chan = chan, \
+	.cookie = cookie, \
+	.status = DMA_IN_PROGRESS, \
+	.comp = COMPLETION_INITIALIZER((name).comp)	}
+
+#define DECLARE_DMA_COMPLETION(name, chan, cookie) \
+struct dma_completion name = DMA_COMPLETION_INITIALIZER(name, chan, cookie)
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
+int dma_lock_iovec_pages(struct iovec *iov, size_t len, struct dma_locked_list **locked_list);
+void dma_unlock_iovec_pages(struct dma_locked_list* locked_list);
+int
+dma_skb_copy_datagram_iovec(struct dma_chan* chan, const struct sk_buff *skb, int offset,
+			    struct iovec *to, size_t len, struct dma_locked_list *locked_list);
+void dma_memcpy_toiovec_wait(struct dma_chan *chan, dma_cookie_t cookie);
+void dma_async_try_early_copy(struct sock *sk, struct sk_buff *skb);
+
+#endif /* DMAENGINE_H */






