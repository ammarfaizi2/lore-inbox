Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261330AbUKWQ3f@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261330AbUKWQ3f (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Nov 2004 11:29:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbUKWQ3f
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Nov 2004 11:29:35 -0500
Received: from umhlanga.stratnet.net ([12.162.17.40]:28799 "EHLO
	umhlanga.STRATNET.NET") by vger.kernel.org with ESMTP
	id S261330AbUKWQO1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Nov 2004 11:14:27 -0500
Cc: openib-general@openib.org
In-Reply-To: <20041123814.rXLIXw020elfd6Da@topspin.com>
X-Mailer: Roland's Patchbomber
Date: Tue, 23 Nov 2004 08:14:19 -0800
Message-Id: <20041123814.m1N7Tf2QmSCq9s5q@topspin.com>
Mime-Version: 1.0
To: linux-kernel@vger.kernel.org
From: Roland Dreier <roland@topspin.com>
X-SA-Exim-Connect-IP: 127.0.0.1
X-SA-Exim-Mail-From: roland@topspin.com
Subject: [PATCH][RFC/v2][2/21] Add core InfiniBand support
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-SA-Exim-Version: 4.1 (built Tue, 17 Aug 2004 11:06:07 +0200)
X-SA-Exim-Scanned: Yes (on eddore)
X-OriginalArrivalTime: 23 Nov 2004 16:14:26.0193 (UTC) FILETIME=[80975010:01C4D177]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add implementation of core InfiniBand support.  This can be thought of
as a midlayer that provides an abstraction between low-level hardware
drivers and upper level protocols (such as IP-over-InfiniBand).

Signed-off-by: Roland Dreier <roland@topspin.com>


--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/Kconfig	2004-11-23 08:10:16.399144313 -0800
@@ -0,0 +1,11 @@
+menu "InfiniBand support"
+
+config INFINIBAND
+	tristate "InfiniBand support"
+	default n
+	---help---
+	  Core support for InfiniBand (IB).  Make sure to also select
+	  any protocols you wish to use as well as drivers for your
+	  InfiniBand hardware.
+
+endmenu
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/Makefile	2004-11-23 08:10:16.436138859 -0800
@@ -0,0 +1 @@
+obj-$(CONFIG_INFINIBAND)		+= core/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/Makefile	2004-11-23 08:10:16.496130013 -0800
@@ -0,0 +1,13 @@
+EXTRA_CFLAGS += -Idrivers/infiniband/include
+
+obj-$(CONFIG_INFINIBAND) += \
+    ib_core.o
+
+ib_core-objs := \
+    packer.o \
+    ud_header.o \
+    verbs.o \
+    sysfs.o \
+    device.o \
+    fmr_pool.o \
+    cache.o
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/cache.c	2004-11-23 08:10:16.816082837 -0800
@@ -0,0 +1,338 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Topspin Communications.  All rights reserved.
+
+  $Id: cache.c 1257 2004-11-17 23:12:18Z roland $
+*/
+
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/rcupdate.h>
+
+#include "core_priv.h"
+
+struct ib_pkey_cache {
+	struct rcu_head rcu;
+	int             table_len;
+	u16             table[0];
+};
+
+struct ib_gid_cache {
+	struct rcu_head rcu;
+	int             table_len;
+	union ib_gid    table[0];
+};
+
+struct ib_update_work {
+	struct work_struct work;
+	struct ib_device  *device;
+	u8                 port_num;
+};
+
+static inline int start_port(struct ib_device *device)
+{
+	return device->node_type == IB_NODE_SWITCH ? 0 : 1;
+}
+
+static inline int end_port(struct ib_device *device)
+{
+	return device->node_type == IB_NODE_SWITCH ? 0 : device->phys_port_cnt;
+}
+
+static void rcu_free_pkey(struct rcu_head *head)
+{
+	struct ib_pkey_cache *cache =
+		container_of(head, struct ib_pkey_cache, rcu);
+	kfree(cache);
+}
+
+static void rcu_free_gid(struct rcu_head *head)
+{
+	struct ib_gid_cache *cache =
+		container_of(head, struct ib_gid_cache, rcu);
+	kfree(cache);
+}
+
+int ib_cached_gid_get(struct ib_device *device,
+		      u8                port,
+		      int               index,
+		      union ib_gid     *gid)
+{
+	struct ib_gid_cache *cache;
+	int ret = 0;
+
+	if (port < start_port(device) || port > end_port(device))
+		return -EINVAL;
+
+	rcu_read_lock();
+
+	cache = rcu_dereference(device->cache.gid_cache[port - start_port(device)]);
+
+	if (index < 0 || index >= cache->table_len)
+		ret = -EINVAL;
+	else
+		*gid = cache->table[index];
+
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_cached_gid_get);
+
+int ib_cached_pkey_get(struct ib_device *device,
+		       u8                port,
+		       int               index,
+		       u16              *pkey)
+{
+	struct ib_pkey_cache *cache;
+	int ret = 0;
+
+	if (port < start_port(device) || port > end_port(device))
+		return -EINVAL;
+
+	rcu_read_lock();
+
+	cache = rcu_dereference(device->cache.pkey_cache[port - start_port(device)]);
+
+	if (index < 0 || index >= cache->table_len)
+		ret = -EINVAL;
+	else
+		*pkey = cache->table[index];
+
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_cached_pkey_get);
+
+int ib_cached_pkey_find(struct ib_device *device,
+			u8                port,
+			u16               pkey,
+			u16              *index)
+{
+	struct ib_pkey_cache *cache;
+	int i;
+	int ret = -ENOENT;
+
+	if (port < start_port(device) || port > end_port(device))
+		return -EINVAL;
+
+	rcu_read_lock();
+
+	cache = rcu_dereference(device->cache.pkey_cache[port - start_port(device)]);
+
+	*index = -1;
+
+	for (i = 0; i < cache->table_len; ++i)
+		if ((cache->table[i] & 0x7fff) == (pkey & 0x7fff)) {
+			*index = i;
+			ret = 0;
+			break;
+		}
+
+	rcu_read_unlock();
+	return ret;
+}
+EXPORT_SYMBOL(ib_cached_pkey_find);
+
+static void ib_cache_update(struct ib_device *device,
+			    u8                port)
+{
+	struct ib_port_attr       *tprops = NULL;
+	struct ib_pkey_cache      *pkey_cache = NULL, *old_pkey_cache;
+	struct ib_gid_cache       *gid_cache = NULL, *old_gid_cache;
+	int                        i;
+	int                        ret;
+
+	tprops = kmalloc(sizeof *tprops, GFP_KERNEL);
+	if (!tprops)
+		return;
+
+	ret = ib_query_port(device, port, tprops);
+	if (ret) {
+		printk(KERN_WARNING "ib_query_port failed (%d) for %s\n",
+		       ret, device->name);
+		goto err;
+	}
+
+	pkey_cache = kmalloc(sizeof *pkey_cache + tprops->pkey_tbl_len *
+			     sizeof *pkey_cache->table, GFP_KERNEL);
+	if (!pkey_cache)
+		goto err;
+
+	INIT_RCU_HEAD(&pkey_cache->rcu);
+	pkey_cache->table_len = tprops->pkey_tbl_len;
+
+	gid_cache = kmalloc(sizeof *gid_cache + tprops->gid_tbl_len *
+			    sizeof *gid_cache->table, GFP_KERNEL);
+	if (!gid_cache)
+		goto err;
+
+	INIT_RCU_HEAD(&gid_cache->rcu);
+	gid_cache->table_len = tprops->gid_tbl_len;
+
+	for (i = 0; i < pkey_cache->table_len; ++i) {
+		ret = ib_query_pkey(device, port, i, pkey_cache->table + i);
+		if (ret) {
+			printk(KERN_WARNING "ib_query_pkey failed (%d) for %s (index %d)\n",
+			       ret, device->name, i);
+			goto err;
+		}
+	}
+
+	for (i = 0; i < gid_cache->table_len; ++i) {
+		ret = ib_query_gid(device, port, i, gid_cache->table + i);
+		if (ret) {
+			printk(KERN_WARNING "ib_query_gid failed (%d) for %s (index %d)\n",
+			       ret, device->name, i);
+			goto err;
+		}
+	}
+
+	old_pkey_cache = device->cache.pkey_cache[port - start_port(device)];
+	old_gid_cache  = device->cache.gid_cache [port - start_port(device)];
+
+	rcu_assign_pointer(device->cache.pkey_cache[port - start_port(device)],
+			   pkey_cache);
+	rcu_assign_pointer(device->cache.gid_cache [port - start_port(device)],
+			   gid_cache);
+
+	if (old_pkey_cache)
+		call_rcu(&old_pkey_cache->rcu, rcu_free_pkey);
+	if (old_gid_cache)
+		call_rcu(&old_gid_cache->rcu, rcu_free_gid);
+
+	kfree(tprops);
+	return;
+
+err:
+	kfree(pkey_cache);
+	kfree(gid_cache);
+	kfree(tprops);
+}
+
+static void ib_cache_task(void *work_ptr)
+{
+	struct ib_update_work *work = work_ptr;
+
+	ib_cache_update(work->device, work->port_num);
+	kfree(work);
+}
+
+static void ib_cache_event(struct ib_event_handler *handler,
+			   struct ib_event *event)
+{
+	struct ib_update_work *work;
+
+	if (event->event == IB_EVENT_PORT_ERR    ||
+	    event->event == IB_EVENT_PORT_ACTIVE ||
+	    event->event == IB_EVENT_LID_CHANGE  ||
+	    event->event == IB_EVENT_PKEY_CHANGE ||
+	    event->event == IB_EVENT_SM_CHANGE) {
+		work = kmalloc(sizeof *work, GFP_ATOMIC);
+		if (work) {
+			INIT_WORK(&work->work, ib_cache_task, work);
+			work->device   = event->device;
+			work->port_num = event->element.port_num;
+			schedule_work(&work->work);
+		}
+	}
+}
+
+void ib_cache_setup_one(struct ib_device *device)
+{
+	int p;
+
+	device->cache.pkey_cache =
+		kmalloc(sizeof *device->cache.pkey_cache *
+			end_port(device) - start_port(device), GFP_KERNEL);
+	device->cache.gid_cache =
+		kmalloc(sizeof *device->cache.pkey_cache *
+			end_port(device) - start_port(device), GFP_KERNEL);
+
+	if (!device->cache.pkey_cache || !device->cache.gid_cache) {
+		printk(KERN_WARNING "Couldn't allocate cache "
+		       "for %s\n", device->name);
+		goto err;
+	}
+
+	for (p = 0; p <= end_port(device) - start_port(device); ++p) {
+		device->cache.pkey_cache[p] = NULL;
+		device->cache.gid_cache [p] = NULL;
+		ib_cache_update(device, p + start_port(device));
+	}
+
+	INIT_IB_EVENT_HANDLER(&device->cache.event_handler,
+			      device, ib_cache_event);
+	if (ib_register_event_handler(&device->cache.event_handler))
+		goto err_cache;
+
+	return;
+
+err_cache:
+	for (p = 0; p <= end_port(device) - start_port(device); ++p) {
+		kfree(device->cache.pkey_cache[p]);
+		kfree(device->cache.gid_cache[p]);
+	}
+
+err:
+	kfree(device->cache.pkey_cache);
+	kfree(device->cache.gid_cache);
+}
+
+void ib_cache_cleanup_one(struct ib_device *device)
+{
+	int p;
+
+	ib_unregister_event_handler(&device->cache.event_handler);
+	flush_scheduled_work();
+
+	for (p = 0; p <= end_port(device) - start_port(device); ++p) {
+		kfree(device->cache.pkey_cache[p]);
+		kfree(device->cache.gid_cache[p]);
+	}
+
+	kfree(device->cache.pkey_cache);
+	kfree(device->cache.gid_cache);
+}
+
+struct ib_client cache_client = {
+	.name   = "cache",
+	.add    = ib_cache_setup_one,
+	.remove = ib_cache_cleanup_one
+};
+
+int __init ib_cache_setup(void)
+{
+	return ib_register_client(&cache_client);
+}
+
+void __exit ib_cache_cleanup(void)
+{
+	ib_unregister_client(&cache_client);
+}
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/core_priv.h	2004-11-23 08:10:16.845078561 -0800
@@ -0,0 +1,48 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Topspin Communications.  All rights reserved.
+
+  $Id: core_priv.h 1179 2004-11-09 05:04:42Z roland $
+*/
+
+#ifndef _CORE_PRIV_H
+#define _CORE_PRIV_H
+
+#include <linux/list.h>
+#include <linux/spinlock.h>
+
+#include <ib_verbs.h>
+
+int  ib_device_register_sysfs(struct ib_device *device);
+void ib_device_unregister_sysfs(struct ib_device *device);
+
+int  ib_sysfs_setup(void);
+void ib_sysfs_cleanup(void);
+
+int  ib_cache_setup(void);
+void ib_cache_cleanup(void);
+
+#endif /* _CORE_PRIV_H */
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/device.c	2004-11-23 08:10:16.735094778 -0800
@@ -0,0 +1,462 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: device.c 1179 2004-11-09 05:04:42Z roland $
+ */
+
+#include <linux/module.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/init.h>
+
+#include <asm/semaphore.h>
+
+#include "core_priv.h"
+
+MODULE_AUTHOR("Roland Dreier");
+MODULE_DESCRIPTION("core kernel InfiniBand API");
+MODULE_LICENSE("Dual BSD/GPL");
+
+struct ib_client_data {
+	struct list_head  list;
+	struct ib_client *client;
+	void *            data;
+};
+
+static LIST_HEAD(device_list);
+static LIST_HEAD(client_list);
+
+/*
+ * device_sem protects access to both device_list and client_list.
+ * There's no real point to using multiple locks or something fancier
+ * like an rwsem: we always access both lists, and we're always
+ * modifying one list or the other list.  In any case this is not a
+ * hot path so there's no point in trying to optimize.
+ */
+static DECLARE_MUTEX(device_sem);
+
+static int ib_device_check_mandatory(struct ib_device *device)
+{
+#define IB_MANDATORY_FUNC(x) { offsetof(struct ib_device, x), #x }
+	static const struct {
+		size_t offset;
+		char  *name;
+	} mandatory_table[] = {
+		IB_MANDATORY_FUNC(query_device),
+		IB_MANDATORY_FUNC(query_port),
+		IB_MANDATORY_FUNC(query_pkey),
+		IB_MANDATORY_FUNC(query_gid),
+		IB_MANDATORY_FUNC(alloc_pd),
+		IB_MANDATORY_FUNC(dealloc_pd),
+		IB_MANDATORY_FUNC(create_ah),
+		IB_MANDATORY_FUNC(destroy_ah),
+		IB_MANDATORY_FUNC(create_qp),
+		IB_MANDATORY_FUNC(modify_qp),
+		IB_MANDATORY_FUNC(destroy_qp),
+		IB_MANDATORY_FUNC(post_send),
+		IB_MANDATORY_FUNC(post_recv),
+		IB_MANDATORY_FUNC(create_cq),
+		IB_MANDATORY_FUNC(destroy_cq),
+		IB_MANDATORY_FUNC(poll_cq),
+		IB_MANDATORY_FUNC(req_notify_cq),
+		IB_MANDATORY_FUNC(get_dma_mr),
+		IB_MANDATORY_FUNC(dereg_mr)
+	};
+	int i;
+
+	for (i = 0; i < sizeof mandatory_table / sizeof mandatory_table[0]; ++i) {
+		if (!*(void **) ((void *) device + mandatory_table[i].offset)) {
+			printk(KERN_WARNING "Device %s is missing mandatory function %s\n",
+			       device->name, mandatory_table[i].name);
+			return -EINVAL;
+		}
+	}
+
+	return 0;
+}
+
+static struct ib_device *__ib_device_get_by_name(const char *name)
+{
+	struct ib_device *device;
+
+	list_for_each_entry(device, &device_list, core_list)
+		if (!strncmp(name, device->name, IB_DEVICE_NAME_MAX))
+			return device;
+
+	return NULL;
+}
+
+
+static int alloc_name(char *name)
+{
+	long *inuse;
+	char buf[IB_DEVICE_NAME_MAX];
+	struct ib_device *device;
+	int i;
+
+	inuse = (long *) get_zeroed_page(GFP_KERNEL);
+	if (!inuse)
+		return -ENOMEM;
+
+	list_for_each_entry(device, &device_list, core_list) {
+		if (!sscanf(device->name, name, &i))
+			continue;
+		if (i < 0 || i >= PAGE_SIZE * 8)
+			continue;
+		snprintf(buf, sizeof buf, name, i);
+		if (!strncmp(buf, device->name, IB_DEVICE_NAME_MAX))
+			set_bit(i, inuse);
+	}
+
+	i = find_first_zero_bit(inuse, PAGE_SIZE * 8);
+	free_page((unsigned long) inuse);
+	snprintf(buf, sizeof buf, name, i);
+
+	if (__ib_device_get_by_name(buf))
+		return -ENFILE;
+
+	strlcpy(name, buf, IB_DEVICE_NAME_MAX);
+	return 0;
+}
+
+struct ib_device *ib_alloc_device(size_t size)
+{
+	void *dev;
+
+	BUG_ON(size < sizeof (struct ib_device));
+
+	dev = kmalloc(size, GFP_KERNEL);
+	if (!dev)
+		return NULL;
+
+	memset(dev, 0, size);
+
+	return dev;
+}
+EXPORT_SYMBOL(ib_alloc_device);
+
+void ib_dealloc_device(struct ib_device *device)
+{
+	if (device->reg_state == IB_DEV_UNINITIALIZED) {
+		kfree(device);
+		return;
+	}
+
+	BUG_ON(device->reg_state != IB_DEV_UNREGISTERED);
+
+	ib_device_unregister_sysfs(device);
+}
+EXPORT_SYMBOL(ib_dealloc_device);
+
+static int add_client_context(struct ib_device *device, struct ib_client *client)
+{
+	struct ib_client_data *context;
+	unsigned long flags;
+
+	context = kmalloc(sizeof *context, GFP_KERNEL);
+	if (!context) {
+		printk(KERN_WARNING "Couldn't allocate client context for %s/%s\n",
+		       device->name, client->name);
+		return -ENOMEM;
+	}
+
+	context->client = client;
+	context->data   = NULL;
+
+	spin_lock_irqsave(&device->client_data_lock, flags);
+	list_add(&context->list, &device->client_data_list);
+	spin_unlock_irqrestore(&device->client_data_lock, flags);
+
+	return 0;
+}
+
+int ib_register_device(struct ib_device *device)
+{
+	int ret;
+
+	down(&device_sem);
+
+	if (strchr(device->name, '%')) {
+		ret = alloc_name(device->name);
+		if (ret)
+			goto out;
+	}
+
+	if (ib_device_check_mandatory(device)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	INIT_LIST_HEAD(&device->event_handler_list);
+	INIT_LIST_HEAD(&device->client_data_list);
+	spin_lock_init(&device->event_handler_lock);
+	spin_lock_init(&device->client_data_lock);
+
+	ret = ib_device_register_sysfs(device);
+	if (ret) {
+		printk(KERN_WARNING "Couldn't register device %s with driver model\n",
+		       device->name);
+		goto out;
+	}
+
+	list_add_tail(&device->core_list, &device_list);
+
+	device->reg_state = IB_DEV_REGISTERED;
+
+	{
+		struct ib_client *client;
+
+		list_for_each_entry(client, &client_list, list)
+			if (client->add && !add_client_context(device, client))
+				client->add(device);
+	}
+
+ out:
+	up(&device_sem);
+	return ret;
+}
+EXPORT_SYMBOL(ib_register_device);
+
+void ib_unregister_device(struct ib_device *device)
+{
+	struct ib_client *client;
+	struct ib_client_data *context, *tmp;
+	unsigned long flags;
+
+	down(&device_sem);
+
+	list_for_each_entry_reverse(client, &client_list, list)
+		if (client->remove)
+			client->remove(device);
+
+	list_del(&device->core_list);
+
+	up(&device_sem);
+
+	spin_lock_irqsave(&device->client_data_lock, flags);
+	list_for_each_entry_safe(context, tmp, &device->client_data_list, list)
+		kfree(context);
+	spin_unlock_irqrestore(&device->client_data_lock, flags);
+
+	device->reg_state = IB_DEV_UNREGISTERED;
+}
+EXPORT_SYMBOL(ib_unregister_device);
+
+int ib_register_client(struct ib_client *client)
+{
+	struct ib_device *device;
+
+	down(&device_sem);
+
+	list_add_tail(&client->list, &client_list);
+	list_for_each_entry(device, &device_list, core_list)
+		if (client->add && !add_client_context(device, client))
+			client->add(device);
+
+	up(&device_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_register_client);
+
+void ib_unregister_client(struct ib_client *client)
+{
+	struct ib_client_data *context, *tmp;
+	struct ib_device *device;
+	unsigned long flags;
+
+	down(&device_sem);
+
+	list_for_each_entry(device, &device_list, core_list) {
+		if (client->remove)
+			client->remove(device);
+
+		spin_lock_irqsave(&device->client_data_lock, flags);
+		list_for_each_entry_safe(context, tmp, &device->client_data_list, list)
+			if (context->client == client) {
+				list_del(&context->list);
+				kfree(context);
+			}
+		spin_unlock_irqrestore(&device->client_data_lock, flags);
+	}
+	list_del(&client->list);
+
+	up(&device_sem);
+}
+EXPORT_SYMBOL(ib_unregister_client);
+
+void *ib_get_client_data(struct ib_device *device, struct ib_client *client)
+{
+	struct ib_client_data *context;
+	void *ret = NULL;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device->client_data_lock, flags);
+	list_for_each_entry(context, &device->client_data_list, list)
+		if (context->client == client) {
+			ret = context->data;
+			break;
+		}
+	spin_unlock_irqrestore(&device->client_data_lock, flags);
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_get_client_data);
+
+void ib_set_client_data(struct ib_device *device, struct ib_client *client,
+			void *data)
+{
+	struct ib_client_data *context;
+	unsigned long flags;
+
+	spin_lock_irqsave(&device->client_data_lock, flags);
+	list_for_each_entry(context, &device->client_data_list, list)
+		if (context->client == client) {
+			context->data = data;
+			goto out;
+		}
+
+	printk(KERN_WARNING "No client context found for %s/%s\n",
+	       device->name, client->name);
+
+out:
+	spin_unlock_irqrestore(&device->client_data_lock, flags);
+}
+EXPORT_SYMBOL(ib_set_client_data);
+
+int ib_register_event_handler  (struct ib_event_handler *event_handler)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&event_handler->device->event_handler_lock, flags);
+	list_add_tail(&event_handler->list,
+		      &event_handler->device->event_handler_list);
+	spin_unlock_irqrestore(&event_handler->device->event_handler_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_register_event_handler);
+
+int ib_unregister_event_handler(struct ib_event_handler *event_handler)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&event_handler->device->event_handler_lock, flags);
+	list_del(&event_handler->list);
+	spin_unlock_irqrestore(&event_handler->device->event_handler_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_unregister_event_handler);
+
+void ib_dispatch_event(struct ib_event *event)
+{
+	unsigned long flags;
+	struct ib_event_handler *handler;
+
+	spin_lock_irqsave(&event->device->event_handler_lock, flags);
+
+	list_for_each_entry(handler, &event->device->event_handler_list, list)
+		handler->handler(handler, event);
+
+	spin_unlock_irqrestore(&event->device->event_handler_lock, flags);
+}
+EXPORT_SYMBOL(ib_dispatch_event);
+
+int ib_query_device(struct ib_device *device,
+		    struct ib_device_attr *device_attr)
+{
+	return device->query_device(device, device_attr);
+}
+EXPORT_SYMBOL(ib_query_device);
+
+int ib_query_port(struct ib_device *device, 
+		  u8 port_num, 
+		  struct ib_port_attr *port_attr)
+{
+	return device->query_port(device, port_num, port_attr);
+}
+EXPORT_SYMBOL(ib_query_port);
+
+int ib_query_gid(struct ib_device *device,
+		 u8 port_num, int index, union ib_gid *gid)
+{
+	return device->query_gid(device, port_num, index, gid);
+}
+EXPORT_SYMBOL(ib_query_gid);
+
+int ib_query_pkey(struct ib_device *device,
+		  u8 port_num, u16 index, u16 *pkey)
+{
+	return device->query_pkey(device, port_num, index, pkey);
+}
+EXPORT_SYMBOL(ib_query_pkey);
+
+int ib_modify_device(struct ib_device *device,
+		     int device_modify_mask,
+		     struct ib_device_modify *device_modify)
+{
+	return device->modify_device(device, device_modify_mask,
+				     device_modify);
+}
+EXPORT_SYMBOL(ib_modify_device);
+
+int ib_modify_port(struct ib_device *device,
+		   u8 port_num, int port_modify_mask,
+		   struct ib_port_modify *port_modify)
+{
+	return device->modify_port(device, port_num, port_modify_mask,
+				   port_modify);
+}
+EXPORT_SYMBOL(ib_modify_port);
+
+static int __init ib_core_init(void)
+{
+	int ret;
+
+	ret = ib_sysfs_setup();
+	if (ret)
+		printk(KERN_WARNING "Couldn't create InfiniBand device class\n");
+
+	ret = ib_cache_setup();
+	if (ret) {
+		printk(KERN_WARNING "Couldn't set up InfiniBand P_Key/GID cache\n");
+		ib_sysfs_cleanup();
+	}
+
+	return ret;
+}
+
+static void __exit ib_core_cleanup(void)
+{
+	ib_cache_cleanup();
+	ib_sysfs_cleanup();
+}
+
+module_init(ib_core_init);
+module_exit(ib_core_cleanup);
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/fmr_pool.c	2004-11-23 08:10:16.773089176 -0800
@@ -0,0 +1,470 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Topspin Communications.  All rights reserved.
+
+  $Id: fmr_pool.c 1082 2004-10-27 20:32:50Z roland $
+*/
+
+#include <linux/errno.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include <linux/jhash.h>
+#include <linux/kthread.h>
+
+#include <ib_fmr_pool.h>
+
+#include "core_priv.h"
+
+enum {
+	IB_FMR_MAX_REMAPS = 32,
+
+	IB_FMR_HASH_BITS  = 8,
+	IB_FMR_HASH_SIZE  = 1 << IB_FMR_HASH_BITS,
+	IB_FMR_HASH_MASK  = IB_FMR_HASH_SIZE - 1
+};
+
+/*
+  If an FMR is not in use, then the list member will point to either
+  its pool's free_list (if the FMR can be mapped again; that is,
+  remap_count < IB_FMR_MAX_REMAPS) or its pool's dirty_list (if the
+  FMR needs to be unmapped before being remapped).  In either of these
+  cases it is a bug if the ref_count is not 0.  In other words, if
+  ref_count is > 0, then the list member must not be linked into
+  either free_list or dirty_list.
+
+  The cache_node member is used to link the FMR into a cache bucket
+  (if caching is enabled).  This is independent of the reference count
+  of the FMR.  When a valid FMR is released, its ref_count is
+  decremented, and if ref_count reaches 0, the FMR is placed in either
+  free_list or dirty_list as appropriate.  However, it is not removed
+  from the cache and may be "revived" if a call to
+  ib_fmr_register_physical() occurs before the FMR is remapped.  In
+  this case we just increment the ref_count and remove the FMR from
+  free_list/dirty_list.
+
+  Before we remap an FMR from free_list, we remove it from the cache
+  (to prevent another user from obtaining a stale FMR).  When an FMR
+  is released, we add it to the tail of the free list, so that our
+  cache eviction policy is "least recently used."
+
+  All manipulation of ref_count, list and cache_node is protected by
+  pool_lock to maintain consistency.
+*/
+
+struct ib_fmr_pool {
+	spinlock_t                pool_lock;
+
+	int                       pool_size;
+	int                       max_pages;
+	int                       dirty_watermark;
+	int                       dirty_len;
+	struct list_head          free_list;
+	struct list_head          dirty_list;
+	struct hlist_head        *cache_bucket;
+
+	void                     (*flush_function)(struct ib_fmr_pool *pool,
+						   void *              arg);
+	void                     *flush_arg;
+
+	struct task_struct       *thread;
+
+	atomic_t                  req_ser;
+	atomic_t                  flush_ser;
+
+	wait_queue_head_t         force_wait;
+};
+
+static inline u32 ib_fmr_hash(u64 first_page)
+{
+	return jhash_2words((u32) first_page,
+			    (u32) (first_page >> 32),
+			    0);
+}
+
+/* Caller must hold pool_lock */
+static inline struct ib_pool_fmr *ib_fmr_cache_lookup(struct ib_fmr_pool *pool,
+						      u64 *page_list,
+						      int  page_list_len,
+						      u64  io_virtual_address)
+{
+	struct hlist_head *bucket;
+	struct ib_pool_fmr *fmr;
+	struct hlist_node *pos;
+
+	if (!pool->cache_bucket)
+		return NULL;
+
+	bucket = pool->cache_bucket + ib_fmr_hash(*page_list);
+
+	hlist_for_each_entry(fmr, pos, bucket, cache_node)
+		if (io_virtual_address == fmr->io_virtual_address &&
+		    page_list_len      == fmr->page_list_len      &&
+		    !memcmp(page_list, fmr->page_list,
+			    page_list_len * sizeof *page_list))
+			return fmr;
+
+	return NULL;
+}
+
+static void ib_fmr_batch_release(struct ib_fmr_pool *pool)
+{
+	int                 ret;
+	struct ib_pool_fmr *fmr;
+	LIST_HEAD(unmap_list);
+	LIST_HEAD(fmr_list);
+
+	spin_lock_irq(&pool->pool_lock);
+
+	list_for_each_entry(fmr, &pool->dirty_list, list) {
+		hlist_del_init(&fmr->cache_node);
+		fmr->remap_count = 0;
+		list_add_tail(&fmr->fmr->list, &fmr_list);
+
+#ifdef DEBUG
+		if (fmr->ref_count !=0) {
+			printk(KERN_WARNING "Unmapping FMR 0x%08x with ref count %d",
+			       fmr, fmr->ref_count);
+		}
+#endif
+	}
+
+	list_splice(&pool->dirty_list, &unmap_list);
+	INIT_LIST_HEAD(&pool->dirty_list);
+	pool->dirty_len = 0;
+
+	spin_unlock_irq(&pool->pool_lock);
+
+	if (list_empty(&unmap_list)) {
+		return;
+	}
+
+	ret = ib_unmap_fmr(&fmr_list);
+	if (ret)
+		printk(KERN_WARNING "ib_unmap_fmr returned %d", ret);
+
+	spin_lock_irq(&pool->pool_lock);
+	list_splice(&unmap_list, &pool->free_list);
+	spin_unlock_irq(&pool->pool_lock);
+}
+
+static int ib_fmr_cleanup_thread(void *pool_ptr)
+{
+	struct ib_fmr_pool *pool = pool_ptr;
+
+	do {
+		if (pool->dirty_len >= pool->dirty_watermark ||
+		    atomic_read(&pool->flush_ser) - atomic_read(&pool->req_ser) < 0) {
+			ib_fmr_batch_release(pool);
+
+			atomic_inc(&pool->flush_ser);
+			wake_up_interruptible(&pool->force_wait);
+
+			if (pool->flush_function)
+				pool->flush_function(pool, pool->flush_arg);
+		}
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		if (pool->dirty_len < pool->dirty_watermark &&
+		    atomic_read(&pool->flush_ser) - atomic_read(&pool->req_ser) >= 0 &&
+		    !kthread_should_stop())
+			schedule();
+		__set_current_state(TASK_RUNNING);
+	} while (!kthread_should_stop());
+
+	return 0;
+}
+
+int ib_create_fmr_pool(struct ib_pd             *pd,
+		       struct ib_fmr_pool_param *params,
+		       struct ib_fmr_pool      **pool_handle)
+{
+	struct ib_device   *device;
+	struct ib_fmr_pool *pool;
+	int i;
+	int ret;
+
+	if (!params) {
+		return -EINVAL;
+	}
+
+	device = pd->device;
+	if (!device->alloc_fmr    ||
+	    !device->dealloc_fmr  ||
+	    !device->map_phys_fmr ||
+	    !device->unmap_fmr) {
+		printk(KERN_WARNING "Device %s does not support fast memory regions",
+		       device->name);
+		return -ENOSYS;
+	}
+
+	pool = kmalloc(sizeof *pool, GFP_KERNEL);
+	if (!pool) {
+		printk(KERN_WARNING "couldn't allocate pool struct");
+		return -ENOMEM;
+	}
+
+	pool->cache_bucket   = NULL;
+
+	pool->flush_function = params->flush_function;
+	pool->flush_arg      = params->flush_arg;
+
+	INIT_LIST_HEAD(&pool->free_list);
+	INIT_LIST_HEAD(&pool->dirty_list);
+
+	if (params->cache) {
+		pool->cache_bucket =
+			kmalloc(IB_FMR_HASH_SIZE * sizeof *pool->cache_bucket,
+				GFP_KERNEL);
+		if (!pool->cache_bucket) {
+			printk(KERN_WARNING "Failed to allocate cache in pool");
+			ret = -ENOMEM;
+			goto out_free_pool;
+		}
+
+		for (i = 0; i < IB_FMR_HASH_SIZE; ++i)
+			INIT_HLIST_HEAD(pool->cache_bucket + i);
+	}
+
+	pool->pool_size       = 0;
+	pool->max_pages       = params->max_pages_per_fmr;
+	pool->dirty_watermark = params->dirty_watermark;
+	pool->dirty_len       = 0;
+	spin_lock_init(&pool->pool_lock);
+	atomic_set(&pool->req_ser,   0);
+	atomic_set(&pool->flush_ser, 0);
+	init_waitqueue_head(&pool->force_wait);
+
+	pool->thread = kthread_create(ib_fmr_cleanup_thread,
+				      pool,
+				      "ib_fmr(%s)",
+				      device->name);
+	if (IS_ERR(pool->thread)) {
+		printk(KERN_WARNING "couldn't start cleanup thread");
+		ret = PTR_ERR(pool->thread);
+		goto out_free_pool;
+	}
+
+	{
+		struct ib_pool_fmr *fmr;
+		struct ib_fmr_attr attr = {
+			.max_pages = params->max_pages_per_fmr,
+			.max_maps  = IB_FMR_MAX_REMAPS,
+			.page_size = PAGE_SHIFT
+		};
+
+		for (i = 0; i < params->pool_size; ++i) {
+			fmr = kmalloc(sizeof *fmr + params->max_pages_per_fmr * sizeof (u64),
+				      GFP_KERNEL);
+			if (!fmr) {
+				printk(KERN_WARNING "failed to allocate fmr struct for FMR %d", i);
+				goto out_fail;
+			}
+
+			fmr->pool             = pool;
+			fmr->remap_count      = 0;
+			fmr->ref_count        = 0;
+			INIT_HLIST_NODE(&fmr->cache_node);
+
+			fmr->fmr = ib_alloc_fmr(pd, params->access, &attr);
+			if (IS_ERR(fmr->fmr)) {
+				printk(KERN_WARNING "fmr_create failed for FMR %d", i);
+				kfree(fmr);
+				goto out_fail;
+			}
+
+			list_add_tail(&fmr->list, &pool->free_list);
+			++pool->pool_size;
+		}
+	}
+
+	*pool_handle = pool;
+	return 0;
+
+ out_free_pool:
+	kfree(pool->cache_bucket);
+	kfree(pool);
+
+	return ret;
+
+ out_fail:
+	ib_destroy_fmr_pool(pool);
+	*pool_handle = NULL;
+
+	return -ENOMEM;
+}
+EXPORT_SYMBOL(ib_create_fmr_pool);
+
+int ib_destroy_fmr_pool(struct ib_fmr_pool *pool)
+{
+	struct ib_pool_fmr *fmr;
+	struct ib_pool_fmr *tmp;
+	int                 i;
+
+	kthread_stop(pool->thread);
+	ib_fmr_batch_release(pool);
+
+	i = 0;
+	list_for_each_entry_safe(fmr, tmp, &pool->free_list, list) {
+		ib_dealloc_fmr(fmr->fmr);
+		list_del(&fmr->list);
+		kfree(fmr);
+		++i;
+	}
+
+	if (i < pool->pool_size)
+		printk(KERN_WARNING "pool still has %d regions registered",
+		       pool->pool_size - i);
+
+	kfree(pool->cache_bucket);
+	kfree(pool);
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_destroy_fmr_pool);
+
+int ib_flush_fmr_pool(struct ib_fmr_pool *pool)
+{
+	int serial;
+
+	atomic_inc(&pool->req_ser);
+	/* It's OK if someone else bumps req_ser again here -- we'll
+	   just wait a little longer. */
+	serial = atomic_read(&pool->req_ser);
+
+	wake_up_process(pool->thread);
+
+	if (wait_event_interruptible(pool->force_wait,
+				     atomic_read(&pool->flush_ser) -
+				     atomic_read(&pool->req_ser) >= 0))
+		return -EINTR;
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_flush_fmr_pool);
+
+struct ib_pool_fmr *ib_fmr_pool_map_phys(struct ib_fmr_pool *pool_handle,
+					 u64                *page_list,
+					 int                 list_len,
+					 u64                *io_virtual_address)
+{
+	struct ib_fmr_pool *pool = pool_handle;
+	struct ib_pool_fmr *fmr;
+	unsigned long       flags;
+	int                 result;
+
+	if (list_len < 1 || list_len > pool->max_pages)
+		return ERR_PTR(-EINVAL);
+
+	spin_lock_irqsave(&pool->pool_lock, flags);
+	fmr = ib_fmr_cache_lookup(pool,
+				  page_list,
+				  list_len,
+				  *io_virtual_address);
+	if (fmr) {
+		/* found in cache */
+		++fmr->ref_count;
+		if (fmr->ref_count == 1) {
+			list_del(&fmr->list);
+		}
+
+		spin_unlock_irqrestore(&pool->pool_lock, flags);
+
+		return fmr;
+	}
+
+	if (list_empty(&pool->free_list)) {
+		spin_unlock_irqrestore(&pool->pool_lock, flags);
+		return ERR_PTR(-EAGAIN);
+	}
+
+	fmr = list_entry(pool->free_list.next, struct ib_pool_fmr, list);
+	list_del(&fmr->list);
+	hlist_del_init(&fmr->cache_node);
+	spin_unlock_irqrestore(&pool->pool_lock, flags);
+
+	result = ib_map_phys_fmr(fmr->fmr, page_list, list_len,
+				 *io_virtual_address);
+
+	if (result) {
+		spin_lock_irqsave(&pool->pool_lock, flags);
+		list_add(&fmr->list, &pool->free_list);
+		spin_unlock_irqrestore(&pool->pool_lock, flags);
+
+		printk(KERN_WARNING "fmr_map returns %d",
+		       result);
+
+		return ERR_PTR(result);
+	}
+
+	++fmr->remap_count;
+	fmr->ref_count = 1;
+
+	if (pool->cache_bucket) {
+		fmr->io_virtual_address = *io_virtual_address;
+		fmr->page_list_len      = list_len;
+		memcpy(fmr->page_list, page_list, list_len * sizeof(*page_list));
+
+		spin_lock_irqsave(&pool->pool_lock, flags);
+		hlist_add_head(&fmr->cache_node,
+			       pool->cache_bucket + ib_fmr_hash(fmr->page_list[0]));
+		spin_unlock_irqrestore(&pool->pool_lock, flags);
+	}
+
+	return fmr;
+}
+EXPORT_SYMBOL(ib_fmr_pool_map_phys);
+
+int ib_fmr_pool_unmap(struct ib_pool_fmr *fmr)
+{
+	struct ib_fmr_pool *pool;
+	unsigned long flags;
+
+	pool = fmr->pool;
+
+	spin_lock_irqsave(&pool->pool_lock, flags);
+
+	--fmr->ref_count;
+	if (!fmr->ref_count) {
+		if (fmr->remap_count < IB_FMR_MAX_REMAPS) {
+			list_add_tail(&fmr->list, &pool->free_list);
+		} else {
+			list_add_tail(&fmr->list, &pool->dirty_list);
+			++pool->dirty_len;
+			wake_up_process(pool->thread);
+		}
+	}
+
+#ifdef DEBUG
+	if (fmr->ref_count < 0)
+		printk(KERN_WARNING "FMR %p has ref count %d < 0",
+		       fmr, fmr->ref_count);
+#endif
+
+	spin_unlock_irqrestore(&pool->pool_lock, flags);
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_fmr_pool_unmap);
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/packer.c	2004-11-23 08:10:16.560120578 -0800
@@ -0,0 +1,177 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+ *
+ * $Id: packer.c 1027 2004-10-20 03:59:00Z roland $
+ */
+
+#include <ib_pack.h>
+
+static u64 value_read(int offset, int size, void *structure)
+{
+	switch (size) {
+	case 1: return                *(u8  *) (structure + offset);
+	case 2: return be16_to_cpup((__be16 *) (structure + offset));
+	case 4: return be32_to_cpup((__be32 *) (structure + offset));
+	case 8: return be64_to_cpup((__be64 *) (structure + offset));
+	default:
+		printk(KERN_WARNING "Field size %d bits not handled\n", size * 8);
+		return 0;
+	}
+}
+
+void ib_pack(const struct ib_field        *desc,
+	     int                           desc_len,
+	     void                         *structure,
+	     void                         *buf)
+{
+	int i;
+
+	for (i = 0; i < desc_len; ++i) {
+		if (desc[i].size_bits <= 32) {
+			int shift;
+			u32 val;
+			__be32 mask;
+			__be32 *addr;
+
+			shift = 32 - desc[i].offset_bits - desc[i].size_bits;
+			if (desc[i].struct_size_bytes)
+				val = value_read(desc[i].struct_offset_bytes,
+						 desc[i].struct_size_bytes,
+						 structure) << shift;
+			else
+				val = 0;
+
+			mask = cpu_to_be32(((1ull << desc[i].size_bits) - 1) << shift);
+			addr = (__be32 *) buf + desc[i].offset_words;
+			*addr = (*addr & ~mask) | (cpu_to_be32(val) & mask);
+		} else if (desc[i].size_bits <= 64) {
+			int shift;
+			u64 val;
+			__be64 mask;
+			__be64 *addr;
+
+			shift = 64 - desc[i].offset_bits - desc[i].size_bits;
+			if (desc[i].struct_size_bytes)
+				val = value_read(desc[i].struct_offset_bytes,
+						 desc[i].struct_size_bytes,
+						 structure) << shift;
+			else
+				val = 0;
+
+			mask = cpu_to_be64(((1ull << desc[i].size_bits) - 1) << shift);
+			addr = (__be64 *) ((__be32 *) buf + desc[i].offset_words);
+			*addr = (*addr & ~mask) | (cpu_to_be64(val) & mask);
+		} else {
+			if (desc[i].offset_bits % 8 ||
+			    desc[i].size_bits   % 8) {
+				printk(KERN_WARNING "Structure field %s of size %d "
+				       "bits is not byte-aligned\n",
+				       desc[i].field_name, desc[i].size_bits);
+			}
+
+			if (desc[i].struct_size_bytes)
+				memcpy(buf + desc[i].offset_words * 4 + 
+				       desc[i].offset_bits / 8,
+				       structure + desc[i].struct_offset_bytes,
+				       desc[i].size_bits / 8);
+			else
+				memset(buf + desc[i].offset_words * 4 + 
+				       desc[i].offset_bits / 8,
+				       0,
+				       desc[i].size_bits / 8);
+		}
+	}
+}
+EXPORT_SYMBOL(ib_pack);
+
+static void value_write(int offset, int size, u64 val, void *structure)
+{
+	switch (size * 8) {
+	case 8:  *(    u8 *) (structure + offset) = val; break;
+	case 16: *(__be16 *) (structure + offset) = cpu_to_be16(val); break;
+	case 32: *(__be32 *) (structure + offset) = cpu_to_be32(val); break;
+	case 64: *(__be64 *) (structure + offset) = cpu_to_be64(val); break;
+	default:
+		printk(KERN_WARNING "Field size %d bits not handled\n", size * 8);
+	}
+}
+
+void ib_unpack(const struct ib_field        *desc,
+	       int                           desc_len,
+	       void                         *buf,
+	       void                         *structure)
+{
+	int i;
+
+	for (i = 0; i < desc_len; ++i) {
+		if (!desc[i].struct_size_bytes)
+			continue;
+
+		if (desc[i].size_bits <= 32) {
+			int shift;
+			u32  val;
+			u32  mask;
+			__be32 *addr;
+
+			shift = 32 - desc[i].offset_bits - desc[i].size_bits;
+			mask = ((1ull << desc[i].size_bits) - 1) << shift;
+			addr = (__be32 *) buf + desc[i].offset_words;
+			val = (be32_to_cpup(addr) & mask) >> shift;
+			value_write(desc[i].struct_offset_bytes,
+				    desc[i].struct_size_bytes,
+				    val,
+				    structure);
+		} else if (desc[i].size_bits <= 64) {
+			int shift;
+			u64  val;
+			u64  mask;
+			__be64 *addr;
+
+			shift = 64 - desc[i].offset_bits - desc[i].size_bits;
+			mask = ((1ull << desc[i].size_bits) - 1) << shift;
+			addr = (__be64 *) buf + desc[i].offset_words;
+			val = (be64_to_cpup(addr) & mask) >> shift;
+			value_write(desc[i].struct_offset_bytes,
+				    desc[i].struct_size_bytes,
+				    val,
+				    structure);
+		} else {
+			if (desc[i].offset_bits % 8 ||
+			    desc[i].size_bits   % 8) {
+				printk(KERN_WARNING "Structure field %s of size %d "
+				       "bits is not byte-aligned\n",
+				       desc[i].field_name, desc[i].size_bits);
+			}
+
+			memcpy(structure + desc[i].struct_offset_bytes,
+			       buf + desc[i].offset_words * 4 +
+			       desc[i].offset_bits / 8,
+			       desc[i].size_bits / 8);
+		}
+	}
+}
+EXPORT_SYMBOL(ib_unpack);
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/sysfs.c	2004-11-23 08:10:16.690101412 -0800
@@ -0,0 +1,684 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Communications.  All rights reserved.
+ *
+ * $Id: sysfs.c 1257 2004-11-17 23:12:18Z roland $
+ */
+
+#include "core_priv.h"
+
+#include <ib_mad.h>
+
+struct ib_port {
+	struct kobject         kobj;
+	struct ib_device      *ibdev;
+	struct attribute_group gid_group;
+	struct attribute     **gid_attr;
+	struct attribute_group pkey_group;
+	struct attribute     **pkey_attr;
+	u8                     port_num;
+};
+
+struct port_attribute {
+	struct attribute attr;
+	ssize_t (*show)(struct ib_port *, struct port_attribute *, char *buf);
+	ssize_t (*store)(struct ib_port *, struct port_attribute *,
+			 const char *buf, size_t count);
+};
+
+#define PORT_ATTR(_name, _mode, _show, _store) \
+struct port_attribute port_attr_##_name = __ATTR(_name, _mode, _show, _store)
+
+#define PORT_ATTR_RO(_name) \
+struct port_attribute port_attr_##_name = __ATTR_RO(_name)
+
+struct port_table_attribute {
+	struct port_attribute attr;
+	int                   index;
+};
+
+static ssize_t port_attr_show(struct kobject *kobj,
+			      struct attribute *attr, char *buf)
+{
+	struct port_attribute *port_attr =
+		container_of(attr, struct port_attribute, attr);
+	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
+
+	if (!port_attr->show)
+		return 0;
+
+	return port_attr->show(p, port_attr, buf);
+}
+
+static struct sysfs_ops port_sysfs_ops = {
+	.show = port_attr_show
+};
+
+static ssize_t state_show(struct ib_port *p, struct port_attribute *unused,
+			  char *buf)
+{
+	struct ib_port_attr attr;
+	ssize_t ret;
+
+	static const char *state_name[] = {
+		[IB_PORT_NOP]		= "NOP",
+		[IB_PORT_DOWN]		= "DOWN",
+		[IB_PORT_INIT]		= "INIT",
+		[IB_PORT_ARMED]		= "ARMED",
+		[IB_PORT_ACTIVE]	= "ACTIVE",
+		[IB_PORT_ACTIVE_DEFER]	= "ACTIVE_DEFER"
+	};
+
+	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d: %s\n", attr.state,
+		       attr.state >= 0 && attr.state <= ARRAY_SIZE(state_name) ?
+		       state_name[attr.state] : "UNKNOWN");
+}
+
+static ssize_t lid_show(struct ib_port *p, struct port_attribute *unused,
+			char *buf)
+{
+	struct ib_port_attr attr;
+	ssize_t ret;
+
+	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", attr.lid);
+}
+
+static ssize_t lid_mask_count_show(struct ib_port *p,
+				   struct port_attribute *unused,
+				   char *buf)
+{
+	struct ib_port_attr attr;
+	ssize_t ret;
+
+	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", attr.lmc);
+}
+
+static ssize_t sm_lid_show(struct ib_port *p, struct port_attribute *unused,
+			   char *buf)
+{
+	struct ib_port_attr attr;
+	ssize_t ret;
+
+	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%x\n", attr.sm_lid);
+}
+
+static ssize_t sm_sl_show(struct ib_port *p, struct port_attribute *unused,
+			  char *buf)
+{
+	struct ib_port_attr attr;
+	ssize_t ret;
+
+	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%d\n", attr.sm_sl);
+}
+
+static ssize_t cap_mask_show(struct ib_port *p, struct port_attribute *unused,
+			     char *buf)
+{
+	struct ib_port_attr attr;
+	ssize_t ret;
+
+	ret = ib_query_port(p->ibdev, p->port_num, &attr);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%08x\n", attr.port_cap_flags);
+}
+
+static PORT_ATTR_RO(state);
+static PORT_ATTR_RO(lid);
+static PORT_ATTR_RO(lid_mask_count);
+static PORT_ATTR_RO(sm_lid);
+static PORT_ATTR_RO(sm_sl);
+static PORT_ATTR_RO(cap_mask);
+
+static struct attribute *port_default_attrs[] = {
+	&port_attr_state.attr,
+	&port_attr_lid.attr,
+	&port_attr_lid_mask_count.attr,
+	&port_attr_sm_lid.attr,
+	&port_attr_sm_sl.attr,
+	&port_attr_cap_mask.attr,
+	NULL
+};
+
+static ssize_t show_port_gid(struct ib_port *p, struct port_attribute *attr,
+			     char *buf)
+{
+	struct port_table_attribute *tab_attr =
+		container_of(attr, struct port_table_attribute, attr);
+	union ib_gid gid;
+	ssize_t ret;
+
+	ret = ib_query_gid(p->ibdev, p->port_num, tab_attr->index, &gid);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%04x:%04x:%04x:%04x:%04x:%04x:%04x:%04x\n",
+		       be16_to_cpu(((u16 *) gid.raw)[0]),
+		       be16_to_cpu(((u16 *) gid.raw)[1]),
+		       be16_to_cpu(((u16 *) gid.raw)[2]),
+		       be16_to_cpu(((u16 *) gid.raw)[3]),
+		       be16_to_cpu(((u16 *) gid.raw)[4]),
+		       be16_to_cpu(((u16 *) gid.raw)[5]),
+		       be16_to_cpu(((u16 *) gid.raw)[6]),
+		       be16_to_cpu(((u16 *) gid.raw)[7]));
+}
+
+static ssize_t show_port_pkey(struct ib_port *p, struct port_attribute *attr,
+			      char *buf)
+{
+	struct port_table_attribute *tab_attr =
+		container_of(attr, struct port_table_attribute, attr);
+	u16 pkey;
+	ssize_t ret;
+
+	ret = ib_query_pkey(p->ibdev, p->port_num, tab_attr->index, &pkey);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "0x%04x\n", pkey);
+}
+
+#define PORT_PMA_ATTR(_name, _counter, _width, _offset)			\
+struct port_table_attribute port_pma_attr_##_name = {			\
+	.attr  = __ATTR(_name, S_IRUGO, show_pma_counter, NULL),	\
+	.index = (_offset) | ((_width) << 16) | ((_counter) << 24)	\
+}
+
+static ssize_t show_pma_counter(struct ib_port *p, struct port_attribute *attr,
+				char *buf)
+{
+	struct port_table_attribute *tab_attr =
+		container_of(attr, struct port_table_attribute, attr);
+	int offset = tab_attr->index & 0xffff;
+	int width  = (tab_attr->index >> 16) & 0xff;
+	struct ib_mad *in_mad  = NULL;
+	struct ib_mad *out_mad = NULL;
+	ssize_t ret;
+
+	if (!p->ibdev->process_mad)
+		return sprintf(buf, "N/A (no PMA)\n");
+
+	in_mad  = kmalloc(sizeof *in_mad, GFP_KERNEL);
+	out_mad = kmalloc(sizeof *in_mad, GFP_KERNEL);
+	if (!in_mad || !out_mad) {
+		ret = -ENOMEM;
+		goto out;
+	}
+
+	memset(in_mad, 0, sizeof *in_mad);
+	in_mad->mad_hdr.base_version  = 1;
+	in_mad->mad_hdr.mgmt_class    = IB_MGMT_CLASS_PERF_MGMT;
+	in_mad->mad_hdr.class_version = 1;
+	in_mad->mad_hdr.method        = IB_MGMT_METHOD_GET;
+	in_mad->mad_hdr.attr_id       = cpu_to_be16(0x12); /* PortCounters */
+
+	in_mad->data[41] = p->port_num;	/* PortSelect field */
+
+	if ((p->ibdev->process_mad(p->ibdev, IB_MAD_IGNORE_MKEY, p->port_num, 0xffff,
+				   in_mad, out_mad) &
+	     (IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY)) !=
+	    (IB_MAD_RESULT_SUCCESS | IB_MAD_RESULT_REPLY)) {
+		ret = -EINVAL;
+		goto out;
+	}
+
+	switch (width) {
+	case 4:
+		ret = sprintf(buf, "%u\n", (out_mad->data[40 + offset / 8] >>
+					    (offset % 4)) & 0xf);
+		break;
+	case 8:
+		ret = sprintf(buf, "%u\n", out_mad->data[40 + offset / 8]);
+		break;
+	case 16:
+		ret = sprintf(buf, "%u\n",
+			      be16_to_cpup((u16 *)(out_mad->data + 40 + offset / 8)));
+		break;
+	case 32:
+		ret = sprintf(buf, "%u\n",
+			      be32_to_cpup((u32 *)(out_mad->data + 40 + offset / 8)));
+		break;
+	default:
+		ret = 0;
+	}
+
+out:
+	kfree(in_mad);
+	kfree(out_mad);
+
+	return ret;
+}
+
+static PORT_PMA_ATTR(symbol_error		    ,  0, 16,  32);
+static PORT_PMA_ATTR(link_error_recovery	    ,  1,  8,  48);
+static PORT_PMA_ATTR(link_downed		    ,  2,  8,  56);
+static PORT_PMA_ATTR(port_rcv_errors		    ,  3, 16,  64);
+static PORT_PMA_ATTR(port_rcv_remote_physical_errors,  4, 16,  80);
+static PORT_PMA_ATTR(port_rcv_switch_relay_errors   ,  5, 16,  96);
+static PORT_PMA_ATTR(port_xmit_discards		    ,  6, 16, 112);
+static PORT_PMA_ATTR(port_xmit_constraint_errors    ,  7,  8, 128);
+static PORT_PMA_ATTR(port_rcv_constraint_errors	    ,  8,  8, 136);
+static PORT_PMA_ATTR(local_link_integrity_errors    ,  9,  4, 152);
+static PORT_PMA_ATTR(excessive_buffer_overrun_errors, 10,  4, 156);
+static PORT_PMA_ATTR(VL15_dropped		    , 11, 16, 176);
+static PORT_PMA_ATTR(port_xmit_data		    , 12, 32, 192);
+static PORT_PMA_ATTR(port_rcv_data		    , 13, 32, 224);
+static PORT_PMA_ATTR(port_xmit_packets		    , 14, 32, 256);
+static PORT_PMA_ATTR(port_rcv_packets		    , 15, 32, 288);
+
+static struct attribute *pma_attrs[] = {
+	&port_pma_attr_symbol_error.attr.attr,
+	&port_pma_attr_link_error_recovery.attr.attr,
+	&port_pma_attr_link_downed.attr.attr,
+	&port_pma_attr_port_rcv_errors.attr.attr,
+	&port_pma_attr_port_rcv_remote_physical_errors.attr.attr,
+	&port_pma_attr_port_rcv_switch_relay_errors.attr.attr,
+	&port_pma_attr_port_xmit_discards.attr.attr,
+	&port_pma_attr_port_xmit_constraint_errors.attr.attr,
+	&port_pma_attr_port_rcv_constraint_errors.attr.attr,
+	&port_pma_attr_local_link_integrity_errors.attr.attr,
+	&port_pma_attr_excessive_buffer_overrun_errors.attr.attr,
+	&port_pma_attr_VL15_dropped.attr.attr,
+	&port_pma_attr_port_xmit_data.attr.attr,
+	&port_pma_attr_port_rcv_data.attr.attr,
+	&port_pma_attr_port_xmit_packets.attr.attr,
+	&port_pma_attr_port_rcv_packets.attr.attr,
+	NULL
+};
+
+static struct attribute_group pma_group = {
+	.name  = "counters",
+	.attrs  = pma_attrs
+};
+
+static void ib_port_release(struct kobject *kobj)
+{
+	struct ib_port *p = container_of(kobj, struct ib_port, kobj);
+	struct attribute *a;
+	int i;
+
+	for (i = 0; (a = p->gid_attr[i]); ++i) {
+		kfree(a->name);
+		kfree(a);
+	}
+
+	for (i = 0; (a = p->pkey_attr[i]); ++i) {
+		kfree(a->name);
+		kfree(a);
+	}
+
+	kfree(p->gid_attr);
+	kfree(p);
+}
+
+static struct kobj_type port_type = {
+	.release       = ib_port_release,
+	.sysfs_ops     = &port_sysfs_ops,
+	.default_attrs = port_default_attrs
+};
+
+static void ib_device_release(struct class_device *cdev)
+{
+	struct ib_device *dev = container_of(cdev, struct ib_device, class_dev);
+
+	kfree(dev);
+}
+
+static int ib_device_hotplug(struct class_device *cdev, char **envp,
+			     int num_envp, char *buf, int size)
+{
+	struct ib_device *dev = container_of(cdev, struct ib_device, class_dev);
+	int i = 0, len = 0;
+
+	if (add_hotplug_env_var(envp, num_envp, &i, buf, size, &len,
+				"NAME=%s", dev->name))
+		return -ENOMEM;
+
+	/*
+	 * It might be nice to pass the node GUID to hotplug, but
+	 * right now the only way to get it is to query the device
+	 * provider, and this can crash during device removal because
+	 * we are will be running after driver removal has started.
+	 * We could add a node_guid field to struct ib_device, or we
+	 * could just let the hotplug script read the node GUID from
+	 * sysfs when devices are added.
+	 */
+
+	envp[i] = NULL;
+	return 0;
+}
+
+static int alloc_group(struct attribute ***attr,
+		       ssize_t (*show)(struct ib_port *,
+				       struct port_attribute *, char *buf),
+		       int len)
+{
+	struct port_table_attribute ***tab_attr =
+		(struct port_table_attribute ***) attr;
+	int i;
+	int ret;
+
+	*tab_attr = kmalloc((1 + len) * sizeof *tab_attr, GFP_KERNEL);
+	if (!*tab_attr)
+		return -ENOMEM;
+
+	memset(*tab_attr, 0, (1 + len) * sizeof *tab_attr);
+
+	for (i = 0; i < len; ++i) {
+		(*tab_attr)[i] = kmalloc(sizeof *(*tab_attr)[i], GFP_KERNEL);
+		if (!(*tab_attr)[i]) {
+			ret = -ENOMEM;
+			goto err;
+		}
+		memset((*tab_attr)[i], 0, sizeof *(*tab_attr)[i]);
+		(*tab_attr)[i]->attr.attr.name = kmalloc(8, GFP_KERNEL);
+		if (!(*tab_attr)[i]->attr.attr.name) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		if (snprintf((*tab_attr)[i]->attr.attr.name, 8, "%d", i) >= 8) {
+			ret = -ENOMEM;
+			goto err;
+		}
+
+		(*tab_attr)[i]->attr.attr.mode  = S_IRUGO;
+		(*tab_attr)[i]->attr.attr.owner = THIS_MODULE;
+		(*tab_attr)[i]->attr.show       = show;
+		(*tab_attr)[i]->index           = i;
+	}	
+
+	return 0;
+
+err:
+	for (i = 0; i < len; ++i) {
+		if ((*tab_attr)[i])
+			kfree((*tab_attr)[i]->attr.attr.name);
+		kfree((*tab_attr)[i]);
+	}
+
+	kfree(*tab_attr);
+
+	return ret;
+}
+
+static int add_port(struct ib_device *device, int port_num)
+{
+	struct ib_port *p;
+	struct ib_port_attr attr;
+	int i;
+	int ret;
+
+	ret = ib_query_port(device, port_num, &attr);
+	if (ret)
+		return ret;
+
+	p = kmalloc(sizeof *p, GFP_KERNEL);
+	if (!p)
+		return -ENOMEM;
+	memset(p, 0, sizeof *p);
+
+	p->ibdev      = device;
+	p->port_num   = port_num;
+	p->kobj.ktype = &port_type;
+
+	p->kobj.parent = kobject_get(&device->ports_parent);
+	if (!p->kobj.parent) {
+		ret = -EBUSY;
+		goto err;
+	}
+
+	ret = kobject_set_name(&p->kobj, "%d", port_num);
+	if (ret)
+		goto err_put;
+
+	ret = kobject_register(&p->kobj);
+	if (ret)
+		goto err_put;
+
+	ret = sysfs_create_group(&p->kobj, &pma_group);
+	if (ret)
+		goto err_put;
+
+	ret = alloc_group(&p->gid_attr, show_port_gid, attr.gid_tbl_len);
+	if (ret)
+		goto err_remove_pma;
+
+	p->gid_group.name  = "gids";
+	p->gid_group.attrs = p->gid_attr;
+
+	ret = sysfs_create_group(&p->kobj, &p->gid_group);
+	if (ret)
+		goto err_free_gid;
+
+	ret = alloc_group(&p->pkey_attr, show_port_pkey, attr.pkey_tbl_len);
+	if (ret)
+		goto err_remove_gid;
+
+	p->pkey_group.name  = "pkeys";
+	p->pkey_group.attrs = p->pkey_attr;
+
+	ret = sysfs_create_group(&p->kobj, &p->pkey_group);
+	if (ret)
+		goto err_free_pkey;
+
+	list_add_tail(&p->kobj.entry, &device->port_list);
+
+	return 0;
+
+err_free_pkey:
+	for (i = 0; i < attr.pkey_tbl_len; ++i) {
+		kfree(p->pkey_attr[i]->name);
+		kfree(p->pkey_attr[i]);
+	}
+
+	kfree(p->pkey_attr);
+
+err_remove_gid:
+	sysfs_remove_group(&p->kobj, &p->gid_group);
+
+err_free_gid:
+	for (i = 0; i < attr.gid_tbl_len; ++i) {
+		kfree(p->gid_attr[i]->name);
+		kfree(p->gid_attr[i]);
+	}
+
+	kfree(p->gid_attr);
+
+err_remove_pma:
+	sysfs_remove_group(&p->kobj, &pma_group);
+
+err_put:
+	kobject_put(&device->ports_parent);
+
+err:
+	kfree(p);
+	return ret;
+}
+
+static ssize_t show_sys_image_guid(struct class_device *cdev, char *buf)
+{
+	struct ib_device *dev = container_of(cdev, struct ib_device, class_dev);
+	struct ib_device_attr attr;
+	ssize_t ret;
+
+	ret = ib_query_device(dev, &attr);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%04x:%04x:%04x:%04x\n",
+		       be16_to_cpu(((u16 *) &attr.sys_image_guid)[0]),
+		       be16_to_cpu(((u16 *) &attr.sys_image_guid)[1]),
+		       be16_to_cpu(((u16 *) &attr.sys_image_guid)[2]),
+		       be16_to_cpu(((u16 *) &attr.sys_image_guid)[3]));
+}
+
+static ssize_t show_node_guid(struct class_device *cdev, char *buf)
+{
+	struct ib_device *dev = container_of(cdev, struct ib_device, class_dev);
+	struct ib_device_attr attr;
+	ssize_t ret;
+
+	ret = ib_query_device(dev, &attr);
+	if (ret)
+		return ret;
+
+	return sprintf(buf, "%04x:%04x:%04x:%04x\n",
+		       be16_to_cpu(((u16 *) &attr.node_guid)[0]),
+		       be16_to_cpu(((u16 *) &attr.node_guid)[1]),
+		       be16_to_cpu(((u16 *) &attr.node_guid)[2]),
+		       be16_to_cpu(((u16 *) &attr.node_guid)[3]));
+}
+
+static CLASS_DEVICE_ATTR(sys_image_guid, S_IRUGO, show_sys_image_guid, NULL);
+static CLASS_DEVICE_ATTR(node_guid, S_IRUGO, show_node_guid, NULL);
+
+static struct class_device_attribute *ib_class_attributes[] = {
+	&class_device_attr_sys_image_guid,
+	&class_device_attr_node_guid
+};
+
+static struct class ib_class = {
+	.name    = "infiniband",
+	.release = ib_device_release,
+	.hotplug = ib_device_hotplug,
+};
+
+int ib_device_register_sysfs(struct ib_device *device)
+{
+	struct class_device *class_dev = &device->class_dev;
+	int ret;
+	int i;
+
+	class_dev->class      = &ib_class;
+	class_dev->class_data = device;
+	strlcpy(class_dev->class_id, device->name, BUS_ID_SIZE);
+
+	INIT_LIST_HEAD(&device->port_list);
+
+	ret = class_device_register(class_dev);
+	if (ret)
+		goto err;
+
+	for (i = 0; i < ARRAY_SIZE(ib_class_attributes); ++i) {
+		ret = class_device_create_file(class_dev, ib_class_attributes[i]);
+		if (ret)
+			goto err_unregister;
+	}
+
+	device->ports_parent.parent = kobject_get(&class_dev->kobj);
+	if (!device->ports_parent.parent) {
+		ret = -EBUSY;
+		goto err_unregister;
+	}
+	ret = kobject_set_name(&device->ports_parent, "ports");
+	if (ret)
+		goto err_put;
+	ret = kobject_register(&device->ports_parent);
+	if (ret)
+		goto err_put;
+
+	if (device->node_type == IB_NODE_SWITCH) {
+		ret = add_port(device, 0);
+		if (ret)
+			goto err_put;
+	} else {
+		int i;
+
+		for (i = 1; i <= device->phys_port_cnt; ++i) {
+			ret = add_port(device, i);
+			if (ret)
+				goto err_put;
+		}
+	}
+
+	return 0;
+
+err_put:
+	{
+		struct kobject *p, *t;
+		struct ib_port *port;
+
+		list_for_each_entry_safe(p, t, &device->port_list, entry) {
+			list_del(&p->entry);
+			port = container_of(p, struct ib_port, kobj);
+			sysfs_remove_group(p, &pma_group);
+			sysfs_remove_group(p, &port->pkey_group);
+			sysfs_remove_group(p, &port->gid_group);
+			kobject_unregister(p);
+		}
+	}
+
+	kobject_put(&class_dev->kobj);
+
+err_unregister:
+	class_device_unregister(class_dev);
+
+err:
+	return ret;
+}
+
+void ib_device_unregister_sysfs(struct ib_device *device)
+{
+	struct kobject *p, *t;
+	struct ib_port *port;
+
+	list_for_each_entry_safe(p, t, &device->port_list, entry) {
+		list_del(&p->entry);
+		port = container_of(p, struct ib_port, kobj);
+		sysfs_remove_group(p, &pma_group);
+		sysfs_remove_group(p, &port->pkey_group);
+		sysfs_remove_group(p, &port->gid_group);
+		kobject_unregister(p);
+	}
+
+	kobject_unregister(&device->ports_parent);
+	class_device_unregister(&device->class_dev);
+}
+
+int ib_sysfs_setup(void)
+{
+	return class_register(&ib_class);
+}
+
+void ib_sysfs_cleanup(void)
+{
+	class_unregister(&ib_class);
+}
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/ud_header.c	2004-11-23 08:10:16.600114681 -0800
@@ -0,0 +1,333 @@
+/*
+ * This software is available to you under a choice of one of two
+ * licenses.  You may choose to be licensed under the terms of the GNU
+ * General Public License (GPL) Version 2, available at
+ * <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+ * license, available in the LICENSE.TXT file accompanying this
+ * software.  These details are also available at
+ * <http://openib.org/license.html>.
+ *
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+ * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+ * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+ * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+ * BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+ * ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+ * CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+ * SOFTWARE.
+ *
+ * Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+ *
+ * $Id: ud_header.c 1027 2004-10-20 03:59:00Z roland $
+ */
+
+#include <linux/errno.h>
+
+#include <ib_pack.h>
+
+#define STRUCT_FIELD(header, field) \
+	.struct_offset_bytes = offsetof(struct ib_unpacked_ ## header, field),      \
+	.struct_size_bytes   = sizeof ((struct ib_unpacked_ ## header *) 0)->field, \
+	.field_name          = #header ":" #field
+
+static const struct ib_field lrh_table[]  = {
+	{ STRUCT_FIELD(lrh, virtual_lane),
+	  .offset_words = 0,
+	  .offset_bits  = 0,
+	  .size_bits    = 4 },
+	{ STRUCT_FIELD(lrh, link_version),
+	  .offset_words = 0,
+	  .offset_bits  = 4,
+	  .size_bits    = 4 },
+	{ STRUCT_FIELD(lrh, service_level),
+	  .offset_words = 0,
+	  .offset_bits  = 8,
+	  .size_bits    = 4 },
+	{ RESERVED,
+	  .offset_words = 0,
+	  .offset_bits  = 12,
+	  .size_bits    = 2 },
+	{ STRUCT_FIELD(lrh, link_next_header),
+	  .offset_words = 0,
+	  .offset_bits  = 14,
+	  .size_bits    = 2 },
+	{ STRUCT_FIELD(lrh, destination_lid),
+	  .offset_words = 0,
+	  .offset_bits  = 16,
+	  .size_bits    = 16 },
+	{ RESERVED,
+	  .offset_words = 1,
+	  .offset_bits  = 0,
+	  .size_bits    = 5 },
+	{ STRUCT_FIELD(lrh, packet_length),
+	  .offset_words = 1,
+	  .offset_bits  = 5,
+	  .size_bits    = 11 },
+	{ STRUCT_FIELD(lrh, source_lid),
+	  .offset_words = 1,
+	  .offset_bits  = 16,
+	  .size_bits    = 16 }
+};
+
+static const struct ib_field grh_table[]  = {
+	{ STRUCT_FIELD(grh, ip_version),
+	  .offset_words = 0,
+	  .offset_bits  = 0,
+	  .size_bits    = 4 },
+	{ STRUCT_FIELD(grh, traffic_class),
+	  .offset_words = 0,
+	  .offset_bits  = 4,
+	  .size_bits    = 8 },
+	{ STRUCT_FIELD(grh, flow_label),
+	  .offset_words = 0,
+	  .offset_bits  = 12,
+	  .size_bits    = 20 },
+	{ STRUCT_FIELD(grh, payload_length),
+	  .offset_words = 1,
+	  .offset_bits  = 0,
+	  .size_bits    = 16 },
+	{ STRUCT_FIELD(grh, next_header),
+	  .offset_words = 1,
+	  .offset_bits  = 16,
+	  .size_bits    = 8 },
+	{ STRUCT_FIELD(grh, hop_limit),
+	  .offset_words = 1,
+	  .offset_bits  = 24,
+	  .size_bits    = 8 },
+	{ STRUCT_FIELD(grh, source_gid),
+	  .offset_words = 2,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 },
+	{ STRUCT_FIELD(grh, destination_gid),
+	  .offset_words = 6,
+	  .offset_bits  = 0,
+	  .size_bits    = 128 }
+};
+
+static const struct ib_field bth_table[]  = {
+	{ STRUCT_FIELD(bth, opcode),
+	  .offset_words = 0,
+	  .offset_bits  = 0,
+	  .size_bits    = 8 },
+	{ STRUCT_FIELD(bth, solicited_event),
+	  .offset_words = 0,
+	  .offset_bits  = 8,
+	  .size_bits    = 1 },
+	{ STRUCT_FIELD(bth, mig_req),
+	  .offset_words = 0,
+	  .offset_bits  = 9,
+	  .size_bits    = 1 },
+	{ STRUCT_FIELD(bth, pad_count),
+	  .offset_words = 0,
+	  .offset_bits  = 10,
+	  .size_bits    = 2 },
+	{ STRUCT_FIELD(bth, transport_header_version),
+	  .offset_words = 0,
+	  .offset_bits  = 12,
+	  .size_bits    = 4 },
+	{ STRUCT_FIELD(bth, pkey),
+	  .offset_words = 0,
+	  .offset_bits  = 16,
+	  .size_bits    = 16 },
+	{ RESERVED,
+	  .offset_words = 1,
+	  .offset_bits  = 0,
+	  .size_bits    = 8 },
+	{ STRUCT_FIELD(bth, destination_qpn),
+	  .offset_words = 1,
+	  .offset_bits  = 8,
+	  .size_bits    = 24 },
+	{ STRUCT_FIELD(bth, ack_req),
+	  .offset_words = 2,
+	  .offset_bits  = 0,
+	  .size_bits    = 1 },
+	{ RESERVED,
+	  .offset_words = 2,
+	  .offset_bits  = 1,
+	  .size_bits    = 7 },
+	{ STRUCT_FIELD(bth, psn),
+	  .offset_words = 2,
+	  .offset_bits  = 8,
+	  .size_bits    = 24 }
+};
+
+static const struct ib_field deth_table[] = {
+	{ STRUCT_FIELD(deth, qkey),
+	  .offset_words = 0,
+	  .offset_bits  = 0,
+	  .size_bits    = 32 },
+	{ RESERVED,
+	  .offset_words = 1,
+	  .offset_bits  = 0,
+	  .size_bits    = 8 },
+	{ STRUCT_FIELD(deth, source_qpn),
+	  .offset_words = 1,
+	  .offset_bits  = 8,
+	  .size_bits    = 24 }
+};
+
+void ib_ud_header_init(int     		    payload_bytes,
+		       int    		    grh_present,
+		       struct ib_ud_header *header)
+{
+	int header_len;
+
+	memset(header, 0, sizeof *header);
+
+	header_len =
+		IB_LRH_BYTES  +
+		IB_BTH_BYTES  +
+		IB_DETH_BYTES;
+	if (grh_present) {
+		header_len += IB_GRH_BYTES;
+	}
+
+	header->lrh.link_version     = 0;
+	header->lrh.link_next_header =
+		grh_present ? IB_LNH_IBA_GLOBAL : IB_LNH_IBA_LOCAL;
+	header->lrh.packet_length    = (IB_LRH_BYTES     +
+					IB_BTH_BYTES     +
+					IB_DETH_BYTES    +
+					payload_bytes    +
+					4                + /* ICRC     */
+					3) / 4;            /* round up */
+
+	header->grh_present          = grh_present;
+	if (grh_present) {
+		header->lrh.packet_length  += IB_GRH_BYTES / 4;
+
+		header->grh.ip_version      = 6;
+		header->grh.payload_length  =
+			cpu_to_be16((IB_BTH_BYTES     +
+				     IB_DETH_BYTES    +
+				     payload_bytes    +
+				     4                + /* ICRC     */
+				     3) & ~3);          /* round up */
+		header->grh.next_header     = 0x1b;
+	}
+
+	cpu_to_be16s(&header->lrh.packet_length);
+
+	if (header->immediate_present)
+		header->bth.opcode           = IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE;
+	else
+		header->bth.opcode           = IB_OPCODE_UD_SEND_ONLY;
+	header->bth.pad_count                = (4 - payload_bytes) & 3;
+	header->bth.transport_header_version = 0;
+}
+EXPORT_SYMBOL(ib_ud_header_init);
+
+int ib_ud_header_pack(struct ib_ud_header *header,
+		      void                *buf)
+{
+	int len = 0;
+
+	ib_pack(lrh_table, ARRAY_SIZE(lrh_table),
+		&header->lrh, buf);
+	len += IB_LRH_BYTES;
+
+	if (header->grh_present) {
+		ib_pack(grh_table, ARRAY_SIZE(grh_table),
+			&header->grh, buf + len);
+		len += IB_GRH_BYTES;
+	}
+
+	ib_pack(bth_table, ARRAY_SIZE(bth_table),
+		&header->bth, buf + len);
+	len += IB_BTH_BYTES;
+
+	ib_pack(deth_table, ARRAY_SIZE(deth_table),
+		&header->deth, buf + len);
+	len += IB_DETH_BYTES;
+
+	if (header->immediate_present) {
+		memcpy(buf + len, &header->immediate_data, sizeof header->immediate_data);
+		len += sizeof header->immediate_data;
+	}
+
+	return len;
+}
+EXPORT_SYMBOL(ib_ud_header_pack);
+
+int ib_ud_header_unpack(void                *buf,
+			struct ib_ud_header *header)
+{
+	ib_unpack(lrh_table, ARRAY_SIZE(lrh_table),
+		  buf, &header->lrh);
+	buf += IB_LRH_BYTES;
+
+	if (header->lrh.link_version != 0) {
+		printk(KERN_WARNING "Invalid LRH.link_version %d\n",
+		       header->lrh.link_version);
+		return -EINVAL;
+	}
+
+	switch (header->lrh.link_next_header) {
+	case IB_LNH_IBA_LOCAL:
+		header->grh_present = 0;
+		break;
+
+	case IB_LNH_IBA_GLOBAL:
+		header->grh_present = 1;
+		ib_unpack(grh_table, ARRAY_SIZE(grh_table),
+			  buf, &header->grh);
+		buf += IB_GRH_BYTES;
+
+		if (header->grh.ip_version != 6) {
+			printk(KERN_WARNING "Invalid GRH.ip_version %d\n",
+			       header->grh.ip_version);
+			return -EINVAL;
+		}
+		if (header->grh.next_header != 0x1b) {
+			printk(KERN_WARNING "Invalid GRH.next_header 0x%02x\n",
+			       header->grh.next_header);
+			return -EINVAL;
+		}
+		break;
+
+	default:
+		printk(KERN_WARNING "Invalid LRH.link_next_header %d\n",
+		       header->lrh.link_next_header);
+		return -EINVAL;
+	}
+
+	ib_unpack(bth_table, ARRAY_SIZE(bth_table),
+		  buf, &header->bth);
+	buf += IB_BTH_BYTES;
+
+	switch (header->bth.opcode) {
+	case IB_OPCODE_UD_SEND_ONLY:
+		header->immediate_present = 0;
+		break;
+	case IB_OPCODE_UD_SEND_ONLY_WITH_IMMEDIATE:
+		header->immediate_present = 1;
+		break;
+	default:
+		printk(KERN_WARNING "Invalid BTH.opcode 0x%02x\n",
+		       header->bth.opcode);
+		return -EINVAL;
+	}
+
+	if (header->bth.transport_header_version != 0) {
+		printk(KERN_WARNING "Invalid BTH.transport_header_version %d\n",
+		       header->bth.transport_header_version);
+		return -EINVAL;
+	}
+
+	ib_unpack(deth_table, ARRAY_SIZE(deth_table),
+		  buf, &header->deth);
+	buf += IB_DETH_BYTES;
+
+	if (header->immediate_present)
+		memcpy(&header->immediate_data, buf, sizeof header->immediate_data);
+
+	return 0;
+}
+EXPORT_SYMBOL(ib_ud_header_unpack);
+
+/*
+  Local Variables:
+  c-file-style: "linux"
+  indent-tabs-mode: t
+  End:
+*/
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-bk/drivers/infiniband/core/verbs.c	2004-11-23 08:10:16.644108194 -0800
@@ -0,0 +1,420 @@
+/*
+  This software is available to you under a choice of one of two
+  licenses.  You may choose to be licensed under the terms of the GNU
+  General Public License (GPL) Version 2, available at
+  <http://www.fsf.org/copyleft/gpl.html>, or the OpenIB.org BSD
+  license, available in the LICENSE.TXT file accompanying this
+  software.  These details are also available at
+  <http://openib.org/license.html>.
+
+  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
+  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
+  MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
+  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS
+  BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN
+  ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN
+  CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
+  SOFTWARE.
+
+  Copyright (c) 2004 Mellanox Technologies Ltd.  All rights reserved.
+  Copyright (c) 2004 Infinicon Corporation.  All rights reserved.
+  Copyright (c) 2004 Intel Corporation.  All rights reserved.
+  Copyright (c) 2004 Topspin Corporation.  All rights reserved.
+  Copyright (c) 2004 Voltaire Corporation.  All rights reserved.
+*/
+
+#include <linux/errno.h>
+#include <linux/err.h>
+
+#include <ib_verbs.h>
+
+/* Protection domains */
+
+struct ib_pd *ib_alloc_pd(struct ib_device *device)
+{
+	struct ib_pd *pd;
+
+	pd = device->alloc_pd(device);
+
+	if (!IS_ERR(pd)) {
+		pd->device = device;
+		atomic_set(&pd->usecnt, 0);
+	}
+
+	return pd;
+}
+EXPORT_SYMBOL(ib_alloc_pd);
+
+int ib_dealloc_pd(struct ib_pd *pd)
+{
+	if (atomic_read(&pd->usecnt))
+		return -EBUSY;
+
+	return pd->device->dealloc_pd(pd);
+}
+EXPORT_SYMBOL(ib_dealloc_pd);
+
+/* Address handles */
+
+struct ib_ah *ib_create_ah(struct ib_pd *pd, struct ib_ah_attr *ah_attr)
+{
+	struct ib_ah *ah;
+
+	ah = pd->device->create_ah(pd, ah_attr);
+
+	if (!IS_ERR(ah)) {
+		ah->device = pd->device;
+		ah->pd     = pd;
+		atomic_inc(&pd->usecnt);
+	}
+
+	return ah;
+}
+EXPORT_SYMBOL(ib_create_ah);
+
+int ib_modify_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr)
+{
+	return ah->device->modify_ah ?
+		ah->device->modify_ah(ah, ah_attr) :
+		-ENOSYS;
+}
+EXPORT_SYMBOL(ib_modify_ah);
+
+int ib_query_ah(struct ib_ah *ah, struct ib_ah_attr *ah_attr)
+{
+	return ah->device->query_ah ?
+		ah->device->query_ah(ah, ah_attr) :
+		-ENOSYS;
+}
+EXPORT_SYMBOL(ib_query_ah);
+
+int ib_destroy_ah(struct ib_ah *ah)
+{
+	struct ib_pd *pd;
+	int ret;
+
+	pd = ah->pd;
+	ret = ah->device->destroy_ah(ah);
+	if (!ret)
+		atomic_dec(&pd->usecnt);
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_destroy_ah);
+
+/* Queue pairs */
+
+struct ib_qp *ib_create_qp(struct ib_pd *pd,
+			   struct ib_qp_init_attr *qp_init_attr)
+{
+	struct ib_qp *qp;
+
+	qp = pd->device->create_qp(pd, qp_init_attr);
+
+	if (!IS_ERR(qp)) {
+		qp->device     	  = pd->device;
+		qp->pd         	  = pd;
+		qp->send_cq    	  = qp_init_attr->send_cq;
+		qp->recv_cq    	  = qp_init_attr->recv_cq;
+		qp->srq	       	  = qp_init_attr->srq;
+		qp->event_handler = qp_init_attr->event_handler;
+		qp->qp_context    = qp_init_attr->qp_context;
+		atomic_inc(&pd->usecnt);
+		atomic_inc(&qp_init_attr->send_cq->usecnt);
+		atomic_inc(&qp_init_attr->recv_cq->usecnt);
+		if (qp_init_attr->srq)
+			atomic_inc(&qp_init_attr->srq->usecnt);
+	}
+
+	return qp;
+}
+EXPORT_SYMBOL(ib_create_qp);
+
+int ib_modify_qp(struct ib_qp *qp,
+		 struct ib_qp_attr *qp_attr,
+		 int qp_attr_mask)
+{
+	return qp->device->modify_qp(qp, qp_attr, qp_attr_mask);
+}
+EXPORT_SYMBOL(ib_modify_qp);
+
+int ib_query_qp(struct ib_qp *qp,
+		struct ib_qp_attr *qp_attr,
+		int qp_attr_mask,
+		struct ib_qp_init_attr *qp_init_attr)
+{
+	return qp->device->query_qp ? 
+		qp->device->query_qp(qp, qp_attr, qp_attr_mask, qp_init_attr) :
+		-ENOSYS;
+}
+EXPORT_SYMBOL(ib_query_qp);
+
+int ib_destroy_qp(struct ib_qp *qp)
+{
+	struct ib_pd *pd;
+	struct ib_cq *scq, *rcq;
+	struct ib_srq *srq;
+	int ret;
+
+	pd  = qp->pd;
+	scq = qp->send_cq;
+	rcq = qp->recv_cq;
+	srq = qp->srq;
+
+	ret = qp->device->destroy_qp(qp);
+	if (!ret) {
+		atomic_dec(&pd->usecnt);
+		atomic_dec(&scq->usecnt);
+		atomic_dec(&rcq->usecnt);
+		if (srq)
+			atomic_dec(&srq->usecnt);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_destroy_qp);
+
+/* Completion queues */
+
+struct ib_cq *ib_create_cq(struct ib_device *device,
+			   ib_comp_handler comp_handler,
+			   void (*event_handler)(struct ib_event *, void *),
+			   void *cq_context, int cqe)
+{
+	struct ib_cq *cq;
+
+	cq = device->create_cq(device, cqe);
+
+	if (!IS_ERR(cq)) {
+		cq->device        = device;
+		cq->comp_handler  = comp_handler;
+		cq->event_handler = event_handler;
+		cq->cq_context    = cq_context;
+		atomic_set(&cq->usecnt, 0);
+	}
+
+	return cq;
+}
+EXPORT_SYMBOL(ib_create_cq);
+
+int ib_destroy_cq(struct ib_cq *cq)
+{
+	if (atomic_read(&cq->usecnt))
+		return -EBUSY;
+
+	return cq->device->destroy_cq(cq);
+}
+EXPORT_SYMBOL(ib_destroy_cq);
+
+int ib_resize_cq(struct ib_cq *cq,
+                 int           cqe)
+{
+	int ret;
+
+	if (!cq->device->resize_cq)
+		return -ENOSYS;
+
+	ret = cq->device->resize_cq(cq, &cqe);
+	if (!ret)
+		cq->cqe = cqe;
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_resize_cq);
+
+/* Memory regions */
+
+struct ib_mr *ib_get_dma_mr(struct ib_pd *pd, int mr_access_flags)
+{
+	struct ib_mr *mr;
+
+	mr = pd->device->get_dma_mr(pd, mr_access_flags);
+
+	if (!IS_ERR(mr)) {
+		mr->device = pd->device;
+		mr->pd     = pd;
+		atomic_inc(&pd->usecnt);
+		atomic_set(&mr->usecnt, 0);
+	}
+
+	return mr;
+}
+EXPORT_SYMBOL(ib_get_dma_mr);
+
+struct ib_mr *ib_reg_phys_mr(struct ib_pd *pd,
+			     struct ib_phys_buf *phys_buf_array,
+			     int num_phys_buf,
+			     int mr_access_flags,
+			     u64 *iova_start)
+{
+	struct ib_mr *mr;
+
+	mr = pd->device->reg_phys_mr(pd, phys_buf_array, num_phys_buf,
+				     mr_access_flags, iova_start);
+
+	if (!IS_ERR(mr)) {
+		mr->device = pd->device;
+		mr->pd     = pd;
+		atomic_inc(&pd->usecnt);
+		atomic_set(&mr->usecnt, 0);
+	}
+
+	return mr;
+}
+EXPORT_SYMBOL(ib_reg_phys_mr);
+
+int ib_rereg_phys_mr(struct ib_mr *mr,
+		     int mr_rereg_mask,
+		     struct ib_pd *pd,
+		     struct ib_phys_buf *phys_buf_array,
+		     int num_phys_buf,
+		     int mr_access_flags,
+		     u64 *iova_start)
+{
+	struct ib_pd *old_pd;
+	int ret;
+
+	if (!mr->device->rereg_phys_mr)
+		return -ENOSYS;
+
+	if (atomic_read(&mr->usecnt))
+		return -EBUSY;
+
+	old_pd = mr->pd;
+
+	ret = mr->device->rereg_phys_mr(mr, mr_rereg_mask, pd,
+					phys_buf_array, num_phys_buf,
+					mr_access_flags, iova_start);
+
+	if (!ret && (mr_rereg_mask & IB_MR_REREG_PD)) {
+		atomic_dec(&old_pd->usecnt);
+		atomic_inc(&pd->usecnt);
+	}
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_rereg_phys_mr);
+
+int ib_query_mr(struct ib_mr *mr, struct ib_mr_attr *mr_attr)
+{
+	return mr->device->query_mr ?
+		mr->device->query_mr(mr, mr_attr) : -ENOSYS;
+}
+EXPORT_SYMBOL(ib_query_mr);
+
+int ib_dereg_mr(struct ib_mr *mr)
+{
+	struct ib_pd *pd;
+	int ret;
+
+	if (atomic_read(&mr->usecnt))
+		return -EBUSY;
+
+	pd = mr->pd;
+	ret = mr->device->dereg_mr(mr);
+	if (!ret)
+		atomic_dec(&pd->usecnt);
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_dereg_mr);
+
+/* Memory windows */
+
+struct ib_mw *ib_alloc_mw(struct ib_pd *pd)
+{
+	struct ib_mw *mw;
+
+	if (!pd->device->alloc_mw)
+		return ERR_PTR(-ENOSYS);
+
+	mw = pd->device->alloc_mw(pd);
+	if (!IS_ERR(mw)) {
+		mw->device = pd->device;
+		mw->pd     = pd;
+		atomic_inc(&pd->usecnt);
+	}
+
+	return mw;
+}
+EXPORT_SYMBOL(ib_alloc_mw);
+
+int ib_dealloc_mw(struct ib_mw *mw)
+{
+	struct ib_pd *pd;
+	int ret;
+
+	pd = mw->pd;
+	ret = mw->device->dealloc_mw(mw);
+	if (!ret)
+		atomic_dec(&pd->usecnt);
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_dealloc_mw);
+
+/* "Fast" memory regions */
+
+struct ib_fmr *ib_alloc_fmr(struct ib_pd *pd,
+			    int mr_access_flags,
+			    struct ib_fmr_attr *fmr_attr)
+{
+	struct ib_fmr *fmr;
+
+	if (!pd->device->alloc_fmr)
+		return ERR_PTR(-ENOSYS);
+
+	fmr = pd->device->alloc_fmr(pd, mr_access_flags, fmr_attr);
+	if (!IS_ERR(fmr)) {
+		fmr->device = pd->device;
+		fmr->pd     = pd;
+		atomic_inc(&pd->usecnt);
+	}
+
+	return fmr;
+}
+EXPORT_SYMBOL(ib_alloc_fmr);
+
+int ib_unmap_fmr(struct list_head *fmr_list)
+{
+	struct ib_fmr *fmr;
+
+	if (list_empty(fmr_list))
+		return 0;
+
+	fmr = list_entry(fmr_list->next, struct ib_fmr, list);
+	return fmr->device->unmap_fmr(fmr_list);
+}
+EXPORT_SYMBOL(ib_unmap_fmr);
+
+int ib_dealloc_fmr(struct ib_fmr *fmr)
+{
+	struct ib_pd *pd;
+	int ret;
+
+	pd = fmr->pd;
+	ret = fmr->device->dealloc_fmr(fmr);
+	if (!ret)
+		atomic_dec(&pd->usecnt);
+
+	return ret;
+}
+EXPORT_SYMBOL(ib_dealloc_fmr);
+
+/* Multicast groups */
+
+int ib_attach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
+{
+	return qp->device->attach_mcast ?
+		qp->device->attach_mcast(qp, gid, lid) :
+		-ENOSYS;
+}
+EXPORT_SYMBOL(ib_attach_mcast);
+
+int ib_detach_mcast(struct ib_qp *qp, union ib_gid *gid, u16 lid)
+{
+	return qp->device->detach_mcast ?
+		qp->device->detach_mcast(qp, gid, lid) :
+		-ENOSYS;
+}
+EXPORT_SYMBOL(ib_detach_mcast);

