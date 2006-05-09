Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751594AbWEII7G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751594AbWEII7G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:59:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751500AbWEII6k
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:58:40 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:59267 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751594AbWEIItK
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:10 -0400
Message-Id: <20060509085200.826853000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:33 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 33/35] Add the Xenbus sysfs and virtual device hotplug driver.
Content-Disposition: inline; filename=xenbus
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This communicates with the machine control software via a registry
residing in a controlling virtual machine. This allows dynamic
creation, destruction and modification of virtual device
configurations (network devices, block devices and CPUS, to name some
examples).

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/xen/Makefile               |    1 
 drivers/xen/xenbus/Makefile        |    7 
 drivers/xen/xenbus/xenbus_client.c |  395 +++++++++++++
 drivers/xen/xenbus/xenbus_comms.c  |  208 +++++++
 drivers/xen/xenbus/xenbus_comms.h  |   43 +
 drivers/xen/xenbus/xenbus_probe.c  | 1065 +++++++++++++++++++++++++++++++++++++
 drivers/xen/xenbus/xenbus_xs.c     |  829 ++++++++++++++++++++++++++++
 include/xen/xenbus.h               |  291 ++++++++++
 8 files changed, 2839 insertions(+)

--- linus-2.6.orig/drivers/xen/Makefile
+++ linus-2.6/drivers/xen/Makefile
@@ -3,4 +3,5 @@ obj-y	+= util.o
 
 obj-y	+= core/
 obj-y	+= console/
+obj-y	+= xenbus/
 
--- /dev/null
+++ linus-2.6/drivers/xen/xenbus/Makefile
@@ -0,0 +1,7 @@
+obj-y	+= xenbus.o
+
+xenbus-objs =
+xenbus-objs += xenbus_client.o
+xenbus-objs += xenbus_comms.o
+xenbus-objs += xenbus_xs.o
+xenbus-objs += xenbus_probe.o
--- /dev/null
+++ linus-2.6/drivers/xen/xenbus/xenbus_client.c
@@ -0,0 +1,395 @@
+/******************************************************************************
+ * Client-facing interface for the Xenbus driver.  In other words, the
+ * interface between the Xenbus and the device-specific code, be it the
+ * frontend or the backend of that driver.
+ *
+ * Copyright (C) 2005 XenSource Ltd
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <xen/evtchn.h>
+#include <xen/gnttab.h>
+#include <xen/xenbus.h>
+#include <xen/driver_util.h>
+
+/* xenbus_probe.c */
+extern char *kasprintf(const char *fmt, ...);
+
+#define DPRINTK(fmt, args...) \
+    pr_debug("xenbus_client (%s:%d) " fmt ".\n", __FUNCTION__, __LINE__, ##args)
+
+int xenbus_watch_path(struct xenbus_device *dev, const char *path,
+		      struct xenbus_watch *watch,
+		      void (*callback)(struct xenbus_watch *,
+				       const char **, unsigned int))
+{
+	int err;
+
+	watch->node = path;
+	watch->callback = callback;
+
+	err = register_xenbus_watch(watch);
+
+	if (err) {
+		watch->node = NULL;
+		watch->callback = NULL;
+		xenbus_dev_fatal(dev, err, "adding watch on %s", path);
+	}
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_watch_path);
+
+
+int xenbus_watch_path2(struct xenbus_device *dev, const char *path,
+		       const char *path2, struct xenbus_watch *watch,
+		       void (*callback)(struct xenbus_watch *,
+					const char **, unsigned int))
+{
+	int err;
+	char *state = kasprintf("%s/%s", path, path2);
+	if (!state) {
+		xenbus_dev_fatal(dev, -ENOMEM, "allocating path for watch");
+		return -ENOMEM;
+	}
+	err = xenbus_watch_path(dev, state, watch, callback);
+
+	if (err)
+		kfree(state);
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_watch_path2);
+
+
+int xenbus_switch_state(struct xenbus_device *dev,
+			xenbus_transaction_t xbt,
+			XenbusState state)
+{
+	/* We check whether the state is currently set to the given value, and
+	   if not, then the state is set.  We don't want to unconditionally
+	   write the given state, because we don't want to fire watches
+	   unnecessarily.  Furthermore, if the node has gone, we don't write
+	   to it, as the device will be tearing down, and we don't want to
+	   resurrect that directory.
+	 */
+
+	int current_state;
+	int err;
+
+	if (state == dev->state)
+		return 0;
+
+	err = xenbus_scanf(xbt, dev->nodename, "state", "%d",
+			       &current_state);
+	if (err != 1)
+		return 0;
+
+	err = xenbus_printf(xbt, dev->nodename, "state", "%d", state);
+	if (err) {
+		if (state != XenbusStateClosing) /* Avoid looping */
+			xenbus_dev_fatal(dev, err, "writing new state");
+		return err;
+	}
+
+	dev->state = state;
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xenbus_switch_state);
+
+
+/**
+ * Return the path to the error node for the given device, or NULL on failure.
+ * If the value returned is non-NULL, then it is the caller's to kfree.
+ */
+static char *error_path(struct xenbus_device *dev)
+{
+	return kasprintf("error/%s", dev->nodename);
+}
+
+
+void _dev_error(struct xenbus_device *dev, int err, const char *fmt,
+		va_list ap)
+{
+	int ret;
+	unsigned int len;
+	char *printf_buffer = NULL, *path_buffer = NULL;
+
+#define PRINTF_BUFFER_SIZE 4096
+	printf_buffer = kmalloc(PRINTF_BUFFER_SIZE, GFP_KERNEL);
+	if (printf_buffer == NULL)
+		goto fail;
+
+	len = sprintf(printf_buffer, "%i ", -err);
+	ret = vsnprintf(printf_buffer+len, PRINTF_BUFFER_SIZE-len, fmt, ap);
+
+	BUG_ON(len + ret > PRINTF_BUFFER_SIZE-1);
+
+	dev_err(&dev->dev, "%s\n", printf_buffer);
+
+	path_buffer = error_path(dev);
+
+	if (path_buffer == NULL) {
+		printk("xenbus: failed to write error node for %s (%s)\n",
+		       dev->nodename, printf_buffer);
+		goto fail;
+	}
+
+	if (xenbus_write(XBT_NULL, path_buffer, "error", printf_buffer) != 0) {
+		printk("xenbus: failed to write error node for %s (%s)\n",
+		       dev->nodename, printf_buffer);
+		goto fail;
+	}
+
+fail:
+	kfree(printf_buffer);
+	kfree(path_buffer);
+}
+
+
+void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt,
+		      ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	_dev_error(dev, err, fmt, ap);
+	va_end(ap);
+}
+EXPORT_SYMBOL_GPL(xenbus_dev_error);
+
+
+void xenbus_dev_fatal(struct xenbus_device *dev, int err, const char *fmt,
+		      ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	_dev_error(dev, err, fmt, ap);
+	va_end(ap);
+
+	xenbus_switch_state(dev, XBT_NULL, XenbusStateClosing);
+}
+EXPORT_SYMBOL_GPL(xenbus_dev_fatal);
+
+
+int xenbus_grant_ring(struct xenbus_device *dev, unsigned long ring_mfn)
+{
+	int err = gnttab_grant_foreign_access(dev->otherend_id, ring_mfn, 0);
+	if (err < 0)
+		xenbus_dev_fatal(dev, err, "granting access to ring page");
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_grant_ring);
+
+
+int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port)
+{
+	struct evtchn_op op = {
+		.cmd = EVTCHNOP_alloc_unbound,
+		.u.alloc_unbound.dom = DOMID_SELF,
+		.u.alloc_unbound.remote_dom = dev->otherend_id
+	};
+	int err = HYPERVISOR_event_channel_op(&op);
+	if (err)
+		xenbus_dev_fatal(dev, err, "allocating event channel");
+	else
+		*port = op.u.alloc_unbound.port;
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_alloc_evtchn);
+
+
+int xenbus_bind_evtchn(struct xenbus_device *dev, int remote_port, int *port)
+{
+	struct evtchn_op op = {
+		.cmd = EVTCHNOP_bind_interdomain,
+		.u.bind_interdomain.remote_dom = dev->otherend_id,
+		.u.bind_interdomain.remote_port = remote_port,
+	};
+	int err = HYPERVISOR_event_channel_op(&op);
+	if (err)
+		xenbus_dev_fatal(dev, err,
+				 "binding to event channel %d from domain %d",
+				 remote_port, dev->otherend_id);
+	else
+		*port = op.u.bind_interdomain.local_port;
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_bind_evtchn);
+
+
+int xenbus_free_evtchn(struct xenbus_device *dev, int port)
+{
+	struct evtchn_op op = {
+		.cmd = EVTCHNOP_close,
+		.u.close.port = port,
+	};
+	int err = HYPERVISOR_event_channel_op(&op);
+	if (err)
+		xenbus_dev_error(dev, err, "freeing event channel %d", port);
+	return err;
+}
+
+
+/* Based on Rusty Russell's skeleton driver's map_page */
+int xenbus_map_ring_valloc(struct xenbus_device *dev, int gnt_ref, void **vaddr)
+{
+	struct gnttab_map_grant_ref op = {
+		.flags = GNTMAP_host_map,
+		.ref   = gnt_ref,
+		.dom   = dev->otherend_id,
+	};
+	struct vm_struct *area;
+
+	*vaddr = NULL;
+
+	area = alloc_vm_area(PAGE_SIZE);
+	if (!area)
+		return -ENOMEM;
+
+	op.host_addr = (unsigned long)area->addr;
+
+	lock_vm_area(area);
+	BUG_ON(HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref, &op, 1));
+	unlock_vm_area(area);
+
+	if (op.status != GNTST_okay) {
+		free_vm_area(area);
+		xenbus_dev_fatal(dev, op.status,
+				 "mapping in shared page %d from domain %d",
+				 gnt_ref, dev->otherend_id);
+		return op.status;
+	}
+
+	/* Stuff the handle in an unused field */
+	area->phys_addr = (unsigned long)op.handle;
+
+	*vaddr = area->addr;
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xenbus_map_ring_valloc);
+
+
+int xenbus_map_ring(struct xenbus_device *dev, int gnt_ref,
+		    grant_handle_t *handle, void *vaddr)
+{
+	struct gnttab_map_grant_ref op = {
+		.host_addr = (unsigned long)vaddr,
+		.flags     = GNTMAP_host_map,
+		.ref       = gnt_ref,
+		.dom       = dev->otherend_id,
+	};
+
+	BUG_ON(HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref, &op, 1));
+
+	if (op.status != GNTST_okay) {
+		xenbus_dev_fatal(dev, op.status,
+				 "mapping in shared page %d from domain %d",
+				 gnt_ref, dev->otherend_id);
+	} else
+		*handle = op.handle;
+
+	return op.status;
+}
+EXPORT_SYMBOL_GPL(xenbus_map_ring);
+
+
+/* Based on Rusty Russell's skeleton driver's unmap_page */
+int xenbus_unmap_ring_vfree(struct xenbus_device *dev, void *vaddr)
+{
+	struct vm_struct *area;
+	struct gnttab_unmap_grant_ref op = {
+		.host_addr = (unsigned long)vaddr,
+	};
+
+	/* It'd be nice if linux/vmalloc.h provided a find_vm_area(void *addr)
+	 * method so that we don't have to muck with vmalloc internals here.
+	 * We could force the user to hang on to their struct vm_struct from
+	 * xenbus_map_ring_valloc, but these 6 lines considerably simplify
+	 * this API.
+	 */
+	read_lock(&vmlist_lock);
+	for (area = vmlist; area != NULL; area = area->next) {
+		if (area->addr == vaddr)
+			break;
+	}
+	read_unlock(&vmlist_lock);
+
+	if (!area) {
+		xenbus_dev_error(dev, -ENOENT,
+				 "can't find mapped virtual address %p", vaddr);
+		return GNTST_bad_virt_addr;
+	}
+
+	op.handle = (grant_handle_t)area->phys_addr;
+
+	lock_vm_area(area);
+	BUG_ON(HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, &op, 1));
+	unlock_vm_area(area);
+
+	if (op.status == GNTST_okay)
+		free_vm_area(area);
+	else
+		xenbus_dev_error(dev, op.status,
+				 "unmapping page at handle %d error %d",
+				 (int16_t)area->phys_addr, op.status);
+
+	return op.status;
+}
+EXPORT_SYMBOL_GPL(xenbus_unmap_ring_vfree);
+
+
+int xenbus_unmap_ring(struct xenbus_device *dev,
+		      grant_handle_t handle, void *vaddr)
+{
+	struct gnttab_unmap_grant_ref op = {
+		.host_addr = (unsigned long)vaddr,
+		.handle    = handle,
+	};
+
+	BUG_ON(HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, &op, 1));
+
+	if (op.status != GNTST_okay)
+		xenbus_dev_error(dev, op.status,
+				 "unmapping page at handle %d error %d",
+				 handle, op.status);
+
+	return op.status;
+}
+EXPORT_SYMBOL_GPL(xenbus_unmap_ring);
+
+
+XenbusState xenbus_read_driver_state(const char *path)
+{
+	XenbusState result;
+	int err = xenbus_gather(XBT_NULL, path, "state", "%d", &result, NULL);
+	if (err)
+		result = XenbusStateClosed;
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(xenbus_read_driver_state);
--- /dev/null
+++ linus-2.6/drivers/xen/xenbus/xenbus_comms.c
@@ -0,0 +1,208 @@
+/******************************************************************************
+ * xenbus_comms.c
+ *
+ * Low level code to talks to Xen Store: ringbuffer and event channel.
+ *
+ * Copyright (C) 2005 Rusty Russell, IBM Corporation
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <asm/hypervisor.h>
+#include <xen/evtchn.h>
+#include <linux/wait.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <xen/xenbus.h>
+#include "xenbus_comms.h"
+
+static int xenbus_irq;
+
+extern void xenbus_probe(void *);
+extern int xenstored_ready;
+static DECLARE_WORK(probe_work, xenbus_probe, NULL);
+
+DECLARE_WAIT_QUEUE_HEAD(xb_waitq);
+
+static inline struct xenstore_domain_interface *xenstore_domain_interface(void)
+{
+	return mfn_to_virt(xen_start_info->store_mfn);
+}
+
+static irqreturn_t wake_waiting(int irq, void *unused, struct pt_regs *regs)
+{
+	if (unlikely(xenstored_ready == 0)) {
+		xenstored_ready = 1;
+		schedule_work(&probe_work);
+	}
+
+	wake_up(&xb_waitq);
+	return IRQ_HANDLED;
+}
+
+static int check_indexes(XENSTORE_RING_IDX cons, XENSTORE_RING_IDX prod)
+{
+	return ((prod - cons) <= XENSTORE_RING_SIZE);
+}
+
+static void *get_output_chunk(XENSTORE_RING_IDX cons,
+			      XENSTORE_RING_IDX prod,
+			      char *buf, uint32_t *len)
+{
+	*len = XENSTORE_RING_SIZE - MASK_XENSTORE_IDX(prod);
+	if ((XENSTORE_RING_SIZE - (prod - cons)) < *len)
+		*len = XENSTORE_RING_SIZE - (prod - cons);
+	return buf + MASK_XENSTORE_IDX(prod);
+}
+
+static const void *get_input_chunk(XENSTORE_RING_IDX cons,
+				   XENSTORE_RING_IDX prod,
+				   const char *buf, uint32_t *len)
+{
+	*len = XENSTORE_RING_SIZE - MASK_XENSTORE_IDX(cons);
+	if ((prod - cons) < *len)
+		*len = prod - cons;
+	return buf + MASK_XENSTORE_IDX(cons);
+}
+
+int xb_write(const void *data, unsigned len)
+{
+	struct xenstore_domain_interface *intf = xenstore_domain_interface();
+	XENSTORE_RING_IDX cons, prod;
+	int rc;
+
+	while (len != 0) {
+		void *dst;
+		unsigned int avail;
+
+		rc = wait_event_interruptible(
+			xb_waitq,
+			(intf->req_prod - intf->req_cons) !=
+			XENSTORE_RING_SIZE);
+		if (rc < 0)
+			return rc;
+
+		/* Read indexes, then verify. */
+		cons = intf->req_cons;
+		prod = intf->req_prod;
+		mb();
+		if (!check_indexes(cons, prod)) {
+			intf->req_cons = intf->req_prod = 0;
+			return -EIO;
+		}
+
+		dst = get_output_chunk(cons, prod, intf->req, &avail);
+		if (avail == 0)
+			continue;
+		if (avail > len)
+			avail = len;
+
+		memcpy(dst, data, avail);
+		data += avail;
+		len -= avail;
+
+		/* Other side must not see new header until data is there. */
+		wmb();
+		intf->req_prod += avail;
+
+		/* This implies mb() before other side sees interrupt. */
+		notify_remote_via_evtchn(xen_start_info->store_evtchn);
+	}
+
+	return 0;
+}
+
+int xb_read(void *data, unsigned len)
+{
+	struct xenstore_domain_interface *intf = xenstore_domain_interface();
+	XENSTORE_RING_IDX cons, prod;
+	int rc;
+
+	while (len != 0) {
+		unsigned int avail;
+		const char *src;
+
+		rc = wait_event_interruptible(
+			xb_waitq,
+			intf->rsp_cons != intf->rsp_prod);
+		if (rc < 0)
+			return rc;
+
+		/* Read indexes, then verify. */
+		cons = intf->rsp_cons;
+		prod = intf->rsp_prod;
+		mb();
+		if (!check_indexes(cons, prod)) {
+			intf->rsp_cons = intf->rsp_prod = 0;
+			return -EIO;
+		}
+
+		src = get_input_chunk(cons, prod, intf->rsp, &avail);
+		if (avail == 0)
+			continue;
+		if (avail > len)
+			avail = len;
+
+		/* We must read header before we read data. */
+		rmb();
+
+		memcpy(data, src, avail);
+		data += avail;
+		len -= avail;
+
+		/* Other side must not see free space until we've copied out */
+		mb();
+		intf->rsp_cons += avail;
+
+		pr_debug("Finished read of %i bytes (%i to go)\n", avail, len);
+
+		/* Implies mb(): they will see new header. */
+		notify_remote_via_evtchn(xen_start_info->store_evtchn);
+	}
+
+	return 0;
+}
+
+/* Set up interrupt handler off store event channel. */
+int xb_init_comms(void)
+{
+	int err;
+
+	if (xenbus_irq)
+		unbind_from_irqhandler(xenbus_irq, &xb_waitq);
+
+	err = bind_evtchn_to_irqhandler(
+		xen_start_info->store_evtchn, wake_waiting,
+		0, "xenbus", &xb_waitq);
+	if (err <= 0) {
+		printk(KERN_ERR "XENBUS request irq failed %i\n", err);
+		return err;
+	}
+
+	xenbus_irq = err;
+
+	return 0;
+}
--- /dev/null
+++ linus-2.6/drivers/xen/xenbus/xenbus_comms.h
@@ -0,0 +1,43 @@
+/*
+ * Private include for xenbus communications.
+ * 
+ * Copyright (C) 2005 Rusty Russell, IBM Corporation
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#ifndef _XENBUS_COMMS_H
+#define _XENBUS_COMMS_H
+
+int xs_init(void);
+int xb_init_comms(void);
+
+/* Low level routines. */
+int xb_write(const void *data, unsigned len);
+int xb_read(void *data, unsigned len);
+int xs_input_avail(void);
+extern wait_queue_head_t xb_waitq;
+
+#endif /* _XENBUS_COMMS_H */
--- /dev/null
+++ linus-2.6/drivers/xen/xenbus/xenbus_probe.c
@@ -0,0 +1,1065 @@
+/******************************************************************************
+ * Talks to Xen Store to figure out what devices we have.
+ *
+ * Copyright (C) 2005 Rusty Russell, IBM Corporation
+ * Copyright (C) 2005 Mike Wray, Hewlett-Packard
+ * Copyright (C) 2005 XenSource Ltd
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#define DPRINTK(fmt, args...) \
+    pr_debug("xenbus_probe (%s:%d) " fmt ".\n", __FUNCTION__, __LINE__, ##args)
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/fcntl.h>
+#include <linux/mm.h>
+#include <linux/notifier.h>
+#include <linux/kthread.h>
+
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/hypervisor.h>
+#include <xen/xenbus.h>
+#ifdef XEN_XENBUS_PROC_INTERFACE
+#include <xen/xen_proc.h>
+#endif
+#include <xen/evtchn.h>
+
+#include "xenbus_comms.h"
+
+extern struct mutex xenwatch_mutex;
+
+static BLOCKING_NOTIFIER_HEAD(xenstore_chain);
+
+/* If something in array of ids matches this device, return it. */
+static const struct xenbus_device_id *
+match_device(const struct xenbus_device_id *arr, struct xenbus_device *dev)
+{
+	for (; *arr->devicetype != '\0'; arr++) {
+		if (!strcmp(arr->devicetype, dev->devicetype))
+			return arr;
+	}
+	return NULL;
+}
+
+static int xenbus_match(struct device *_dev, struct device_driver *_drv)
+{
+	struct xenbus_driver *drv = to_xenbus_driver(_drv);
+
+	if (!drv->ids)
+		return 0;
+
+	return match_device(drv->ids, to_xenbus_device(_dev)) != NULL;
+}
+
+struct xen_bus_type
+{
+	char *root;
+	unsigned int levels;
+	int (*get_bus_id)(char bus_id[BUS_ID_SIZE], const char *nodename);
+	int (*probe)(const char *type, const char *dir);
+	struct bus_type bus;
+	struct device dev;
+};
+
+
+/* device/<type>/<id> => <type>-<id> */
+static int frontend_bus_id(char bus_id[BUS_ID_SIZE], const char *nodename)
+{
+	nodename = strchr(nodename, '/');
+	if (!nodename || strlen(nodename + 1) >= BUS_ID_SIZE) {
+		printk(KERN_WARNING "XENBUS: bad frontend %s\n", nodename);
+		return -EINVAL;
+	}
+
+	strlcpy(bus_id, nodename + 1, BUS_ID_SIZE);
+	if (!strchr(bus_id, '/')) {
+		printk(KERN_WARNING "XENBUS: bus_id %s no slash\n", bus_id);
+		return -EINVAL;
+	}
+	*strchr(bus_id, '/') = '-';
+	return 0;
+}
+
+
+static void free_otherend_details(struct xenbus_device *dev)
+{
+	kfree(dev->otherend);
+	dev->otherend = NULL;
+}
+
+
+static void free_otherend_watch(struct xenbus_device *dev)
+{
+	if (dev->otherend_watch.node) {
+		unregister_xenbus_watch(&dev->otherend_watch);
+		kfree(dev->otherend_watch.node);
+		dev->otherend_watch.node = NULL;
+	}
+}
+
+
+static int read_otherend_details(struct xenbus_device *xendev,
+				 char *id_node, char *path_node)
+{
+	int err = xenbus_gather(XBT_NULL, xendev->nodename,
+				id_node, "%i", &xendev->otherend_id,
+				path_node, NULL, &xendev->otherend,
+				NULL);
+	if (err) {
+		xenbus_dev_fatal(xendev, err,
+				 "reading other end details from %s",
+				 xendev->nodename);
+		return err;
+	}
+	if (strlen(xendev->otherend) == 0 ||
+	    !xenbus_exists(XBT_NULL, xendev->otherend, "")) {
+		xenbus_dev_fatal(xendev, -ENOENT, "missing other end from %s",
+				 xendev->nodename);
+		free_otherend_details(xendev);
+		return -ENOENT;
+	}
+
+	return 0;
+}
+
+
+static int read_backend_details(struct xenbus_device *xendev)
+{
+	return read_otherend_details(xendev, "backend-id", "backend");
+}
+
+
+static int read_frontend_details(struct xenbus_device *xendev)
+{
+	return read_otherend_details(xendev, "frontend-id", "frontend");
+}
+
+
+/* Bus type for frontend drivers. */
+static int xenbus_probe_frontend(const char *type, const char *name);
+static struct xen_bus_type xenbus_frontend = {
+	.root = "device",
+	.levels = 2, 		/* device/type/<id> */
+	.get_bus_id = frontend_bus_id,
+	.probe = xenbus_probe_frontend,
+	.bus = {
+		.name  = "xen",
+		.match = xenbus_match,
+	},
+	.dev = {
+		.bus_id = "xen",
+	},
+};
+
+/* backend/<type>/<fe-uuid>/<id> => <type>-<fe-domid>-<id> */
+static int backend_bus_id(char bus_id[BUS_ID_SIZE], const char *nodename)
+{
+	int domid, err;
+	const char *devid, *type, *frontend;
+	unsigned int typelen;
+
+	type = strchr(nodename, '/');
+	if (!type)
+		return -EINVAL;
+	type++;
+	typelen = strcspn(type, "/");
+	if (!typelen || type[typelen] != '/')
+		return -EINVAL;
+
+	devid = strrchr(nodename, '/') + 1;
+
+	err = xenbus_gather(XBT_NULL, nodename, "frontend-id", "%i", &domid,
+			    "frontend", NULL, &frontend,
+			    NULL);
+	if (err)
+		return err;
+	if (strlen(frontend) == 0)
+		err = -ERANGE;
+	if (!err && !xenbus_exists(XBT_NULL, frontend, ""))
+		err = -ENOENT;
+
+	kfree(frontend);
+
+	if (err)
+		return err;
+
+	if (snprintf(bus_id, BUS_ID_SIZE,
+		     "%.*s-%i-%s", typelen, type, domid, devid) >= BUS_ID_SIZE)
+		return -ENOSPC;
+	return 0;
+}
+
+static int xenbus_uevent_backend(struct device *dev, char **envp,
+				 int num_envp, char *buffer, int buffer_size);
+static int xenbus_probe_backend(const char *type, const char *domid);
+static struct xen_bus_type xenbus_backend = {
+	.root = "backend",
+	.levels = 3, 		/* backend/type/<frontend>/<id> */
+	.get_bus_id = backend_bus_id,
+	.probe = xenbus_probe_backend,
+	.bus = {
+		.name  = "xen-backend",
+		.match = xenbus_match,
+		.uevent = xenbus_uevent_backend,
+	},
+	.dev = {
+		.bus_id = "xen-backend",
+	},
+};
+
+static int xenbus_uevent_backend(struct device *dev, char **envp,
+				 int num_envp, char *buffer, int buffer_size)
+{
+	struct xenbus_device *xdev;
+	struct xenbus_driver *drv;
+	int i = 0;
+	int length = 0;
+
+	DPRINTK("");
+
+	if (dev == NULL)
+		return -ENODEV;
+
+	xdev = to_xenbus_device(dev);
+	if (xdev == NULL)
+		return -ENODEV;
+
+	/* stuff we want to pass to /sbin/hotplug */
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "XENBUS_TYPE=%s", xdev->devicetype);
+
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "XENBUS_PATH=%s", xdev->nodename);
+
+	add_uevent_var(envp, num_envp, &i, buffer, buffer_size, &length,
+		       "XENBUS_BASE_PATH=%s", xenbus_backend.root);
+
+	/* terminate, set to next free slot, shrink available space */
+	envp[i] = NULL;
+	envp = &envp[i];
+	num_envp -= i;
+	buffer = &buffer[length];
+	buffer_size -= length;
+
+	if (dev->driver) {
+		drv = to_xenbus_driver(dev->driver);
+		if (drv && drv->uevent)
+			return drv->uevent(xdev, envp, num_envp, buffer,
+					   buffer_size);
+	}
+
+	return 0;
+}
+
+static void otherend_changed(struct xenbus_watch *watch,
+			     const char **vec, unsigned int len)
+{
+	struct xenbus_device *dev =
+		container_of(watch, struct xenbus_device, otherend_watch);
+	struct xenbus_driver *drv = to_xenbus_driver(dev->dev.driver);
+	XenbusState state;
+
+	/* Protect us against watches firing on old details when the otherend
+	   details change, say immediately after a resume. */
+	if (!dev->otherend ||
+	    strncmp(dev->otherend, vec[XS_WATCH_PATH],
+		    strlen(dev->otherend))) {
+		DPRINTK("Ignoring watch at %s", vec[XS_WATCH_PATH]);
+		return;
+	}
+
+	state = xenbus_read_driver_state(dev->otherend);
+
+	DPRINTK("state is %d, %s, %s",
+		state, dev->otherend_watch.node, vec[XS_WATCH_PATH]);
+	if (drv->otherend_changed)
+		drv->otherend_changed(dev, state);
+}
+
+
+static int talk_to_otherend(struct xenbus_device *dev)
+{
+	struct xenbus_driver *drv = to_xenbus_driver(dev->dev.driver);
+
+	free_otherend_watch(dev);
+	free_otherend_details(dev);
+
+	return drv->read_otherend_details(dev);
+}
+
+
+static int watch_otherend(struct xenbus_device *dev)
+{
+	return xenbus_watch_path2(dev, dev->otherend, "state",
+				  &dev->otherend_watch, otherend_changed);
+}
+
+
+static int xenbus_dev_probe(struct device *_dev)
+{
+	struct xenbus_device *dev = to_xenbus_device(_dev);
+	struct xenbus_driver *drv = to_xenbus_driver(_dev->driver);
+	const struct xenbus_device_id *id;
+	int err;
+
+	DPRINTK("");
+
+	if (!drv->probe) {
+		err = -ENODEV;
+		goto fail;
+	}
+
+	id = match_device(drv->ids, dev);
+	if (!id) {
+		err = -ENODEV;
+		goto fail;
+	}
+
+	err = talk_to_otherend(dev);
+	if (err) {
+		printk(KERN_WARNING
+		       "xenbus_probe: talk_to_otherend on %s failed.\n",
+		       dev->nodename);
+		return err;
+	}
+
+	err = drv->probe(dev, id);
+	if (err)
+		goto fail;
+
+	err = watch_otherend(dev);
+	if (err) {
+		printk(KERN_WARNING
+		       "xenbus_probe: watch_otherend on %s failed.\n",
+		       dev->nodename);
+		return err;
+	}
+
+	return 0;
+fail:
+	xenbus_dev_error(dev, err, "xenbus_dev_probe on %s", dev->nodename);
+	xenbus_switch_state(dev, XBT_NULL, XenbusStateClosed);
+	return -ENODEV;
+}
+
+static int xenbus_dev_remove(struct device *_dev)
+{
+	struct xenbus_device *dev = to_xenbus_device(_dev);
+	struct xenbus_driver *drv = to_xenbus_driver(_dev->driver);
+
+	DPRINTK("");
+
+	free_otherend_watch(dev);
+	free_otherend_details(dev);
+
+	if (drv->remove)
+		drv->remove(dev);
+
+	xenbus_switch_state(dev, XBT_NULL, XenbusStateClosed);
+	return 0;
+}
+
+static int xenbus_register_driver_common(struct xenbus_driver *drv,
+					 struct xen_bus_type *bus)
+{
+	int ret;
+
+	drv->driver.name = drv->name;
+	drv->driver.bus = &bus->bus;
+	drv->driver.owner = drv->owner;
+	drv->driver.probe = xenbus_dev_probe;
+	drv->driver.remove = xenbus_dev_remove;
+
+	mutex_lock(&xenwatch_mutex);
+	ret = driver_register(&drv->driver);
+	mutex_unlock(&xenwatch_mutex);
+	return ret;
+}
+
+int xenbus_register_frontend(struct xenbus_driver *drv)
+{
+	drv->read_otherend_details = read_backend_details;
+
+	return xenbus_register_driver_common(drv, &xenbus_frontend);
+}
+EXPORT_SYMBOL_GPL(xenbus_register_frontend);
+
+int xenbus_register_backend(struct xenbus_driver *drv)
+{
+	drv->read_otherend_details = read_frontend_details;
+
+	return xenbus_register_driver_common(drv, &xenbus_backend);
+}
+EXPORT_SYMBOL_GPL(xenbus_register_backend);
+
+void xenbus_unregister_driver(struct xenbus_driver *drv)
+{
+	driver_unregister(&drv->driver);
+}
+EXPORT_SYMBOL_GPL(xenbus_unregister_driver);
+
+struct xb_find_info
+{
+	struct xenbus_device *dev;
+	const char *nodename;
+};
+
+static int cmp_dev(struct device *dev, void *data)
+{
+	struct xenbus_device *xendev = to_xenbus_device(dev);
+	struct xb_find_info *info = data;
+
+	if (!strcmp(xendev->nodename, info->nodename)) {
+		info->dev = xendev;
+		get_device(dev);
+		return 1;
+	}
+	return 0;
+}
+
+struct xenbus_device *xenbus_device_find(const char *nodename,
+					 struct bus_type *bus)
+{
+	struct xb_find_info info = { .dev = NULL, .nodename = nodename };
+
+	bus_for_each_dev(bus, NULL, &info, cmp_dev);
+	return info.dev;
+}
+
+static int cleanup_dev(struct device *dev, void *data)
+{
+	struct xenbus_device *xendev = to_xenbus_device(dev);
+	struct xb_find_info *info = data;
+	int len = strlen(info->nodename);
+
+	DPRINTK("%s", info->nodename);
+
+	/* Match the info->nodename path, or any subdirectory of that path. */
+	if (strncmp(xendev->nodename, info->nodename, len))
+		return 0;
+
+	/* If the node name is longer, ensure it really is a subdirectory. */
+	if ((strlen(xendev->nodename) > len) && (xendev->nodename[len] != '/'))
+		return 0;
+
+	info->dev = xendev;
+	get_device(dev);
+	return 1;
+}
+
+static void xenbus_cleanup_devices(const char *path, struct bus_type *bus)
+{
+	struct xb_find_info info = { .nodename = path };
+
+	do {
+		info.dev = NULL;
+		bus_for_each_dev(bus, NULL, &info, cleanup_dev);
+		if (info.dev) {
+			device_unregister(&info.dev->dev);
+			put_device(&info.dev->dev);
+		}
+	} while (info.dev);
+}
+
+static void xenbus_dev_release(struct device *dev)
+{
+	if (dev)
+		kfree(to_xenbus_device(dev));
+}
+
+/* Simplified asprintf. */
+char *kasprintf(const char *fmt, ...)
+{
+	va_list ap;
+	unsigned int len;
+	char *p, dummy[1];
+
+	va_start(ap, fmt);
+	/* FIXME: vsnprintf has a bug, NULL should work */
+	len = vsnprintf(dummy, 0, fmt, ap);
+	va_end(ap);
+
+	p = kmalloc(len + 1, GFP_KERNEL);
+	if (!p)
+		return NULL;
+	va_start(ap, fmt);
+	vsprintf(p, fmt, ap);
+	va_end(ap);
+	return p;
+}
+
+static ssize_t xendev_show_nodename(struct device *dev,
+				    struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", to_xenbus_device(dev)->nodename);
+}
+DEVICE_ATTR(nodename, S_IRUSR | S_IRGRP | S_IROTH, xendev_show_nodename, NULL);
+
+static ssize_t xendev_show_devtype(struct device *dev,
+				   struct device_attribute *attr, char *buf)
+{
+	return sprintf(buf, "%s\n", to_xenbus_device(dev)->devicetype);
+}
+DEVICE_ATTR(devtype, S_IRUSR | S_IRGRP | S_IROTH, xendev_show_devtype, NULL);
+
+
+static int xenbus_probe_node(struct xen_bus_type *bus,
+			     const char *type,
+			     const char *nodename)
+{
+	int err;
+	struct xenbus_device *xendev;
+	size_t stringlen;
+	char *tmpstring;
+
+	XenbusState state = xenbus_read_driver_state(nodename);
+
+	if (state != XenbusStateInitialising) {
+		/* Device is not new, so ignore it.  This can happen if a
+		   device is going away after switching to Closed.  */
+		return 0;
+	}
+
+	stringlen = strlen(nodename) + 1 + strlen(type) + 1;
+	xendev = kzalloc(sizeof(*xendev) + stringlen, GFP_KERNEL);
+	if (!xendev)
+		return -ENOMEM;
+
+	/* Copy the strings into the extra space. */
+
+	tmpstring = (char *)(xendev + 1);
+	strcpy(tmpstring, nodename);
+	xendev->nodename = tmpstring;
+
+	tmpstring += strlen(tmpstring) + 1;
+	strcpy(tmpstring, type);
+	xendev->devicetype = tmpstring;
+
+	xendev->dev.parent = &bus->dev;
+	xendev->dev.bus = &bus->bus;
+	xendev->dev.release = xenbus_dev_release;
+
+	err = bus->get_bus_id(xendev->dev.bus_id, xendev->nodename);
+	if (err)
+		goto fail;
+
+	/* Register with generic device framework. */
+	err = device_register(&xendev->dev);
+	if (err)
+		goto fail;
+
+	device_create_file(&xendev->dev, &dev_attr_nodename);
+	device_create_file(&xendev->dev, &dev_attr_devtype);
+
+	return 0;
+fail:
+	kfree(xendev);
+	return err;
+}
+
+/* device/<typename>/<name> */
+static int xenbus_probe_frontend(const char *type, const char *name)
+{
+	char *nodename;
+	int err;
+
+	nodename = kasprintf("%s/%s/%s", xenbus_frontend.root, type, name);
+	if (!nodename)
+		return -ENOMEM;
+
+	DPRINTK("%s", nodename);
+
+	err = xenbus_probe_node(&xenbus_frontend, type, nodename);
+	kfree(nodename);
+	return err;
+}
+
+/* backend/<typename>/<frontend-uuid>/<name> */
+static int xenbus_probe_backend_unit(const char *dir,
+				     const char *type,
+				     const char *name)
+{
+	char *nodename;
+	int err;
+
+	nodename = kasprintf("%s/%s", dir, name);
+	if (!nodename)
+		return -ENOMEM;
+
+	DPRINTK("%s\n", nodename);
+
+	err = xenbus_probe_node(&xenbus_backend, type, nodename);
+	kfree(nodename);
+	return err;
+}
+
+/* backend/<typename>/<frontend-domid> */
+static int xenbus_probe_backend(const char *type, const char *domid)
+{
+	char *nodename;
+	int err = 0;
+	char **dir;
+	unsigned int i, dir_n = 0;
+
+	DPRINTK("");
+
+	nodename = kasprintf("%s/%s/%s", xenbus_backend.root, type, domid);
+	if (!nodename)
+		return -ENOMEM;
+
+	dir = xenbus_directory(XBT_NULL, nodename, "", &dir_n);
+	if (IS_ERR(dir)) {
+		kfree(nodename);
+		return PTR_ERR(dir);
+	}
+
+	for (i = 0; i < dir_n; i++) {
+		err = xenbus_probe_backend_unit(nodename, type, dir[i]);
+		if (err)
+			break;
+	}
+	kfree(dir);
+	kfree(nodename);
+	return err;
+}
+
+static int xenbus_probe_device_type(struct xen_bus_type *bus, const char *type)
+{
+	int err = 0;
+	char **dir;
+	unsigned int dir_n = 0;
+	int i;
+
+	dir = xenbus_directory(XBT_NULL, bus->root, type, &dir_n);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	for (i = 0; i < dir_n; i++) {
+		err = bus->probe(type, dir[i]);
+		if (err)
+			break;
+	}
+	kfree(dir);
+	return err;
+}
+
+static int xenbus_probe_devices(struct xen_bus_type *bus)
+{
+	int err = 0;
+	char **dir;
+	unsigned int i, dir_n;
+
+	dir = xenbus_directory(XBT_NULL, bus->root, "", &dir_n);
+	if (IS_ERR(dir))
+		return PTR_ERR(dir);
+
+	for (i = 0; i < dir_n; i++) {
+		err = xenbus_probe_device_type(bus, dir[i]);
+		if (err)
+			break;
+	}
+	kfree(dir);
+	return err;
+}
+
+static unsigned int char_count(const char *str, char c)
+{
+	unsigned int i, ret = 0;
+
+	for (i = 0; str[i]; i++)
+		if (str[i] == c)
+			ret++;
+	return ret;
+}
+
+static int strsep_len(const char *str, char c, unsigned int len)
+{
+	unsigned int i;
+
+	for (i = 0; str[i]; i++)
+		if (str[i] == c) {
+			if (len == 0)
+				return i;
+			len--;
+		}
+	return (len == 0) ? i : -ERANGE;
+}
+
+static void dev_changed(const char *node, struct xen_bus_type *bus)
+{
+	int exists, rootlen;
+	struct xenbus_device *dev;
+	char type[BUS_ID_SIZE];
+	const char *p, *root;
+
+	if (char_count(node, '/') < 2)
+ 		return;
+
+	exists = xenbus_exists(XBT_NULL, node, "");
+	if (!exists) {
+		xenbus_cleanup_devices(node, &bus->bus);
+		return;
+	}
+
+	/* backend/<type>/... or device/<type>/... */
+	p = strchr(node, '/') + 1;
+	snprintf(type, BUS_ID_SIZE, "%.*s", (int)strcspn(p, "/"), p);
+	type[BUS_ID_SIZE-1] = '\0';
+
+	rootlen = strsep_len(node, '/', bus->levels);
+	if (rootlen < 0)
+		return;
+	root = kasprintf("%.*s", rootlen, node);
+	if (!root)
+		return;
+
+	dev = xenbus_device_find(root, &bus->bus);
+	if (!dev)
+		xenbus_probe_node(bus, type, root);
+	else
+		put_device(&dev->dev);
+
+	kfree(root);
+}
+
+static void frontend_changed(struct xenbus_watch *watch,
+			     const char **vec, unsigned int len)
+{
+	DPRINTK("");
+
+	dev_changed(vec[XS_WATCH_PATH], &xenbus_frontend);
+}
+
+static void backend_changed(struct xenbus_watch *watch,
+			    const char **vec, unsigned int len)
+{
+	DPRINTK("");
+
+	dev_changed(vec[XS_WATCH_PATH], &xenbus_backend);
+}
+
+/* We watch for devices appearing and vanishing. */
+static struct xenbus_watch fe_watch = {
+	.node = "device",
+	.callback = frontend_changed,
+};
+
+static struct xenbus_watch be_watch = {
+	.node = "backend",
+	.callback = backend_changed,
+};
+
+static int suspend_dev(struct device *dev, void *data)
+{
+	int err = 0;
+	struct xenbus_driver *drv;
+	struct xenbus_device *xdev;
+
+	DPRINTK("");
+
+	if (dev->driver == NULL)
+		return 0;
+	drv = to_xenbus_driver(dev->driver);
+	xdev = container_of(dev, struct xenbus_device, dev);
+	if (drv->suspend)
+		err = drv->suspend(xdev);
+	if (err)
+		printk(KERN_WARNING
+		       "xenbus: suspend %s failed: %i\n", dev->bus_id, err);
+	return 0;
+}
+
+static int resume_dev(struct device *dev, void *data)
+{
+	int err;
+	struct xenbus_driver *drv;
+	struct xenbus_device *xdev;
+
+	DPRINTK("");
+
+	if (dev->driver == NULL)
+		return 0;
+	drv = to_xenbus_driver(dev->driver);
+	xdev = container_of(dev, struct xenbus_device, dev);
+
+	err = talk_to_otherend(xdev);
+	if (err) {
+		printk(KERN_WARNING
+		       "xenbus: resume (talk_to_otherend) %s failed: %i\n",
+		       dev->bus_id, err);
+		return err;
+	}
+
+	err = watch_otherend(xdev);
+	if (err) {
+		printk(KERN_WARNING
+		       "xenbus_probe: resume (watch_otherend) %s failed: "
+		       "%d.\n", dev->bus_id, err);
+		return err;
+	}
+
+	if (drv->resume)
+		err = drv->resume(xdev);
+	if (err)
+		printk(KERN_WARNING
+		       "xenbus: resume %s failed: %i\n", dev->bus_id, err);
+	return err;
+}
+
+void xenbus_suspend(void)
+{
+	DPRINTK("");
+
+	bus_for_each_dev(&xenbus_frontend.bus, NULL, NULL, suspend_dev);
+	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL, suspend_dev);
+	xs_suspend();
+}
+EXPORT_SYMBOL_GPL(xenbus_suspend);
+
+void xenbus_resume(void)
+{
+	xb_init_comms();
+	xs_resume();
+	bus_for_each_dev(&xenbus_frontend.bus, NULL, NULL, resume_dev);
+	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL, resume_dev);
+}
+EXPORT_SYMBOL_GPL(xenbus_resume);
+
+
+/* A flag to determine if xenstored is 'ready' (i.e. has started) */
+int xenstored_ready = 0;
+
+
+int register_xenstore_notifier(struct notifier_block *nb)
+{
+	int ret = 0;
+
+	if (xenstored_ready > 0)
+		ret = nb->notifier_call(nb, 0, NULL);
+	else
+		blocking_notifier_chain_register(&xenstore_chain, nb);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(register_xenstore_notifier);
+
+void unregister_xenstore_notifier(struct notifier_block *nb)
+{
+	blocking_notifier_chain_unregister(&xenstore_chain, nb);
+}
+EXPORT_SYMBOL_GPL(unregister_xenstore_notifier);
+
+
+static int all_devices_ready_(struct device *dev, void *data)
+{
+	struct xenbus_device *xendev = to_xenbus_device(dev);
+	int *result = data;
+
+	if (xendev->state != XenbusStateConnected) {
+		result = 0;
+		return 1;
+	}
+
+	return 0;
+}
+
+
+static int all_devices_ready(void)
+{
+	int ready = 1;
+	bus_for_each_dev(&xenbus_frontend.bus, NULL, &ready,
+			 all_devices_ready_);
+	return ready;
+}
+
+
+void xenbus_probe(void *unused)
+{
+	int i;
+
+	BUG_ON((xenstored_ready <= 0));
+
+	/* Enumerate devices in xenstore. */
+	xenbus_probe_devices(&xenbus_frontend);
+	xenbus_probe_devices(&xenbus_backend);
+
+	/* Watch for changes. */
+	register_xenbus_watch(&fe_watch);
+	register_xenbus_watch(&be_watch);
+
+	/* Notify others that xenstore is up */
+	blocking_notifier_call_chain(&xenstore_chain, 0, NULL);
+
+	/* On a 10 second timeout, waiting for all devices currently
+	   configured.  We need to do this to guarantee that the filesystems
+	   and / or network devices needed for boot are available, before we
+	   can allow the boot to proceed.
+
+	   A possible improvement here would be to have the tools add a
+	   per-device flag to the store entry, indicating whether it is needed
+	   at boot time.  This would allow people who knew what they were
+	   doing to accelerate their boot slightly, but of course needs tools
+	   or manual intervention to set up those flags correctly.
+	 */
+	for (i = 0; i < 10 * HZ; i++) {
+		if (all_devices_ready())
+			return;
+
+		set_current_state(TASK_INTERRUPTIBLE);
+		schedule_timeout(1);
+	}
+
+	printk(KERN_WARNING
+	       "XENBUS: Timeout connecting to devices!\n");
+}
+
+
+#ifdef XEN_XENBUS_PROC_INTERFACE
+static struct file_operations xsd_kva_fops;
+static struct proc_dir_entry *xsd_kva_intf;
+static struct proc_dir_entry *xsd_port_intf;
+
+static int xsd_kva_mmap(struct file *file, struct vm_area_struct *vma)
+{
+	size_t size = vma->vm_end - vma->vm_start;
+
+	if ((size > PAGE_SIZE) || (vma->vm_pgoff != 0))
+		return -EINVAL;
+
+	if (remap_pfn_range(vma, vma->vm_start,
+			    mfn_to_pfn(xen_start_info->store_mfn),
+			    size, vma->vm_page_prot))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int xsd_kva_read(char *page, char **start, off_t off,
+                        int count, int *eof, void *data)
+{
+	int len;
+
+	len  = sprintf(page, "0x%p", mfn_to_virt(xen_start_info->store_mfn));
+	*eof = 1;
+	return len;
+}
+
+static int xsd_port_read(char *page, char **start, off_t off,
+			 int count, int *eof, void *data)
+{
+	int len;
+
+	len  = sprintf(page, "%d", xen_start_info->store_evtchn);
+	*eof = 1;
+	return len;
+}
+#endif
+
+
+static int __init xenbus_probe_init(void)
+{
+	int err = 0, dom0;
+
+	DPRINTK("");
+
+	if (xen_init() < 0) {
+		DPRINTK("failed");
+		return -ENODEV;
+	}
+
+	/* Register ourselves with the kernel bus & device subsystems */
+	bus_register(&xenbus_frontend.bus);
+	bus_register(&xenbus_backend.bus);
+	device_register(&xenbus_frontend.dev);
+	device_register(&xenbus_backend.dev);
+
+	/*
+	 * Domain0 doesn't have a store_evtchn or store_mfn yet.
+	 */
+	dom0 = (xen_start_info->store_evtchn == 0);
+
+#ifdef XEN_XENBUS_PROC_INTERFACE
+	if (dom0) {
+
+		unsigned long page;
+		evtchn_op_t op = { 0 };
+		int ret;
+
+
+		/* Allocate page. */
+		page = get_zeroed_page(GFP_KERNEL);
+		if (!page)
+			return -ENOMEM;
+
+		xen_start_info->store_mfn =
+			pfn_to_mfn(virt_to_phys((void *)page) >>
+				   PAGE_SHIFT);
+
+		/* Next allocate a local port which xenstored can bind to */
+		op.cmd = EVTCHNOP_alloc_unbound;
+		op.u.alloc_unbound.dom        = DOMID_SELF;
+		op.u.alloc_unbound.remote_dom = 0;
+
+		ret = HYPERVISOR_event_channel_op(&op);
+		BUG_ON(ret);
+		xen_start_info->store_evtchn = op.u.alloc_unbound.port;
+
+		/* And finally publish the above info in /proc/xen */
+		xsd_kva_intf = create_xen_proc_entry("xsd_kva", 0600);
+		if (xsd_kva_intf) {
+			memcpy(&xsd_kva_fops, xsd_kva_intf->proc_fops,
+			       sizeof(xsd_kva_fops));
+			xsd_kva_fops.mmap = xsd_kva_mmap;
+			xsd_kva_intf->proc_fops = &xsd_kva_fops;
+			xsd_kva_intf->read_proc = xsd_kva_read;
+		}
+		xsd_port_intf = create_xen_proc_entry("xsd_port", 0400);
+		if (xsd_port_intf)
+			xsd_port_intf->read_proc = xsd_port_read;
+	} else
+#endif
+		xenstored_ready = 1;
+
+	/* Initialize the interface to xenstore. */
+	err = xs_init();
+	if (err) {
+		printk(KERN_WARNING
+		       "XENBUS: Error initializing xenstore comms: %i\n", err);
+		return err;
+	}
+
+	if (!dom0)
+		xenbus_probe(NULL);
+
+	return 0;
+}
+
+postcore_initcall(xenbus_probe_init);
--- /dev/null
+++ linus-2.6/drivers/xen/xenbus/xenbus_xs.c
@@ -0,0 +1,829 @@
+/******************************************************************************
+ * xenbus_xs.c
+ *
+ * This is the kernel equivalent of the "xs" library.  We don't need everything
+ * and we use xenbus_comms for communication.
+ *
+ * Copyright (C) 2005 Rusty Russell, IBM Corporation
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#include <linux/unistd.h>
+#include <linux/errno.h>
+#include <linux/types.h>
+#include <linux/uio.h>
+#include <linux/kernel.h>
+#include <linux/string.h>
+#include <linux/err.h>
+#include <linux/slab.h>
+#include <linux/fcntl.h>
+#include <linux/kthread.h>
+#include <linux/rwsem.h>
+#include <xen/xenbus.h>
+#include "xenbus_comms.h"
+
+/* xenbus_probe.c */
+extern char *kasprintf(const char *fmt, ...);
+
+struct xs_stored_msg {
+	struct list_head list;
+
+	struct xsd_sockmsg hdr;
+
+	union {
+		/* Queued replies. */
+		struct {
+			char *body;
+		} reply;
+
+		/* Queued watch events. */
+		struct {
+			struct xenbus_watch *handle;
+			char **vec;
+			unsigned int vec_size;
+		} watch;
+	} u;
+};
+
+struct xs_handle {
+	/* A list of replies. Currently only one will ever be outstanding. */
+	struct list_head reply_list;
+	spinlock_t reply_lock;
+	wait_queue_head_t reply_waitq;
+
+	/* One request at a time. */
+	struct mutex request_mutex;
+
+	/* Protect transactions against save/restore. */
+	struct rw_semaphore suspend_mutex;
+};
+
+static struct xs_handle xs_state;
+
+/* List of registered watches, and a lock to protect it. */
+static LIST_HEAD(watches);
+static DEFINE_SPINLOCK(watches_lock);
+
+/* List of pending watch callback events, and a lock to protect it. */
+static LIST_HEAD(watch_events);
+static DEFINE_SPINLOCK(watch_events_lock);
+
+/*
+ * Details of the xenwatch callback kernel thread. The thread waits on the
+ * watch_events_waitq for work to do (queued on watch_events list). When it
+ * wakes up it acquires the xenwatch_mutex before reading the list and
+ * carrying out work.
+ */
+static pid_t xenwatch_pid;
+/* static */ DEFINE_MUTEX(xenwatch_mutex);
+static DECLARE_WAIT_QUEUE_HEAD(watch_events_waitq);
+
+static int get_error(const char *errorstring)
+{
+	unsigned int i;
+
+	for (i = 0; strcmp(errorstring, xsd_errors[i].errstring) != 0; i++) {
+		if (i == ARRAY_SIZE(xsd_errors) - 1) {
+			printk(KERN_WARNING
+			       "XENBUS xen store gave: unknown error %s",
+			       errorstring);
+			return EINVAL;
+		}
+	}
+	return xsd_errors[i].errnum;
+}
+
+static void *read_reply(enum xsd_sockmsg_type *type, unsigned int *len)
+{
+	struct xs_stored_msg *msg;
+	char *body;
+
+	spin_lock(&xs_state.reply_lock);
+
+	while (list_empty(&xs_state.reply_list)) {
+		spin_unlock(&xs_state.reply_lock);
+		/* XXX FIXME: Avoid synchronous wait for response here. */
+		wait_event(xs_state.reply_waitq,
+			   !list_empty(&xs_state.reply_list));
+		spin_lock(&xs_state.reply_lock);
+	}
+
+	msg = list_entry(xs_state.reply_list.next,
+			 struct xs_stored_msg, list);
+	list_del(&msg->list);
+
+	spin_unlock(&xs_state.reply_lock);
+
+	*type = msg->hdr.type;
+	if (len)
+		*len = msg->hdr.len;
+	body = msg->u.reply.body;
+
+	kfree(msg);
+
+	return body;
+}
+
+/* Emergency write. */
+void xenbus_debug_write(const char *str, unsigned int count)
+{
+	struct xsd_sockmsg msg = { 0 };
+
+	msg.type = XS_DEBUG;
+	msg.len = sizeof("print") + count + 1;
+
+	mutex_lock(&xs_state.request_mutex);
+	xb_write(&msg, sizeof(msg));
+	xb_write("print", sizeof("print"));
+	xb_write(str, count);
+	xb_write("", 1);
+	mutex_unlock(&xs_state.request_mutex);
+}
+
+void *xenbus_dev_request_and_reply(struct xsd_sockmsg *msg)
+{
+	void *ret;
+	struct xsd_sockmsg req_msg = *msg;
+	int err;
+
+	if (req_msg.type == XS_TRANSACTION_START)
+		down_read(&xs_state.suspend_mutex);
+
+	mutex_lock(&xs_state.request_mutex);
+
+	err = xb_write(msg, sizeof(*msg) + msg->len);
+	if (err) {
+		msg->type = XS_ERROR;
+		ret = ERR_PTR(err);
+	} else
+		ret = read_reply(&msg->type, &msg->len);
+
+	mutex_unlock(&xs_state.request_mutex);
+
+	if ((msg->type == XS_TRANSACTION_END) ||
+	    ((req_msg.type == XS_TRANSACTION_START) &&
+	     (msg->type == XS_ERROR)))
+		up_read(&xs_state.suspend_mutex);
+
+	return ret;
+}
+
+/* Send message to xs, get kmalloc'ed reply.  ERR_PTR() on error. */
+static void *xs_talkv(xenbus_transaction_t t,
+		      enum xsd_sockmsg_type type,
+		      const struct kvec *iovec,
+		      unsigned int num_vecs,
+		      unsigned int *len)
+{
+	struct xsd_sockmsg msg;
+	void *ret = NULL;
+	unsigned int i;
+	int err;
+
+	msg.tx_id = t;
+	msg.req_id = 0;
+	msg.type = type;
+	msg.len = 0;
+	for (i = 0; i < num_vecs; i++)
+		msg.len += iovec[i].iov_len;
+
+	mutex_lock(&xs_state.request_mutex);
+
+	err = xb_write(&msg, sizeof(msg));
+	if (err) {
+		mutex_unlock(&xs_state.request_mutex);
+		return ERR_PTR(err);
+	}
+
+	for (i = 0; i < num_vecs; i++) {
+		err = xb_write(iovec[i].iov_base, iovec[i].iov_len);;
+		if (err) {
+			mutex_unlock(&xs_state.request_mutex);
+			return ERR_PTR(err);
+		}
+	}
+
+	ret = read_reply(&msg.type, len);
+
+	mutex_unlock(&xs_state.request_mutex);
+
+	if (IS_ERR(ret))
+		return ret;
+
+	if (msg.type == XS_ERROR) {
+		err = get_error(ret);
+		kfree(ret);
+		return ERR_PTR(-err);
+	}
+
+	if (msg.type != type) {
+		if (printk_ratelimit())
+			printk(KERN_WARNING
+			       "XENBUS unexpected type [%d], expected [%d]\n",
+			       msg.type, type);
+		kfree(ret);
+		return ERR_PTR(-EINVAL);
+	}
+	return ret;
+}
+
+/* Simplified version of xs_talkv: single message. */
+static void *xs_single(xenbus_transaction_t t,
+		       enum xsd_sockmsg_type type,
+		       const char *string,
+		       unsigned int *len)
+{
+	struct kvec iovec;
+
+	iovec.iov_base = (void *)string;
+	iovec.iov_len = strlen(string) + 1;
+	return xs_talkv(t, type, &iovec, 1, len);
+}
+
+/* Many commands only need an ack, don't care what it says. */
+static int xs_error(char *reply)
+{
+	if (IS_ERR(reply))
+		return PTR_ERR(reply);
+	kfree(reply);
+	return 0;
+}
+
+static unsigned int count_strings(const char *strings, unsigned int len)
+{
+	unsigned int num;
+	const char *p;
+
+	for (p = strings, num = 0; p < strings + len; p += strlen(p) + 1)
+		num++;
+
+	return num;
+}
+
+/* Return the path to dir with /name appended. Buffer must be kfree()'ed. */
+static char *join(const char *dir, const char *name)
+{
+	char *buffer;
+
+	if (strlen(name) == 0)
+		buffer = kasprintf("%s", dir);
+	else
+		buffer = kasprintf("%s/%s", dir, name);
+	return (!buffer) ? ERR_PTR(-ENOMEM) : buffer;
+}
+
+static char **split(char *strings, unsigned int len, unsigned int *num)
+{
+	char *p, **ret;
+
+	/* Count the strings. */
+	*num = count_strings(strings, len);
+
+	/* Transfer to one big alloc for easy freeing. */
+	ret = kmalloc(*num * sizeof(char *) + len, GFP_KERNEL);
+	if (!ret) {
+		kfree(strings);
+		return ERR_PTR(-ENOMEM);
+	}
+	memcpy(&ret[*num], strings, len);
+	kfree(strings);
+
+	strings = (char *)&ret[*num];
+	for (p = strings, *num = 0; p < strings + len; p += strlen(p) + 1)
+		ret[(*num)++] = p;
+
+	return ret;
+}
+
+char **xenbus_directory(xenbus_transaction_t t,
+			const char *dir, const char *node, unsigned int *num)
+{
+	char *strings, *path;
+	unsigned int len;
+
+	path = join(dir, node);
+	if (IS_ERR(path))
+		return (char **)path;
+
+	strings = xs_single(t, XS_DIRECTORY, path, &len);
+	kfree(path);
+	if (IS_ERR(strings))
+		return (char **)strings;
+
+	return split(strings, len, num);
+}
+EXPORT_SYMBOL_GPL(xenbus_directory);
+
+/* Check if a path exists. Return 1 if it does. */
+int xenbus_exists(xenbus_transaction_t t,
+		  const char *dir, const char *node)
+{
+	char **d;
+	int dir_n;
+
+	d = xenbus_directory(t, dir, node, &dir_n);
+	if (IS_ERR(d))
+		return 0;
+	kfree(d);
+	return 1;
+}
+EXPORT_SYMBOL_GPL(xenbus_exists);
+
+/* Get the value of a single file.
+ * Returns a kmalloced value: call free() on it after use.
+ * len indicates length in bytes.
+ */
+void *xenbus_read(xenbus_transaction_t t,
+		  const char *dir, const char *node, unsigned int *len)
+{
+	char *path;
+	void *ret;
+
+	path = join(dir, node);
+	if (IS_ERR(path))
+		return (void *)path;
+
+	ret = xs_single(t, XS_READ, path, len);
+	kfree(path);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xenbus_read);
+
+/* Write the value of a single file.
+ * Returns -err on failure.
+ */
+int xenbus_write(xenbus_transaction_t t,
+		 const char *dir, const char *node, const char *string)
+{
+	const char *path;
+	struct kvec iovec[2];
+	int ret;
+
+	path = join(dir, node);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	iovec[0].iov_base = (void *)path;
+	iovec[0].iov_len = strlen(path) + 1;
+	iovec[1].iov_base = (void *)string;
+	iovec[1].iov_len = strlen(string);
+
+	ret = xs_error(xs_talkv(t, XS_WRITE, iovec, ARRAY_SIZE(iovec), NULL));
+	kfree(path);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xenbus_write);
+
+/* Create a new directory. */
+int xenbus_mkdir(xenbus_transaction_t t,
+		 const char *dir, const char *node)
+{
+	char *path;
+	int ret;
+
+	path = join(dir, node);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	ret = xs_error(xs_single(t, XS_MKDIR, path, NULL));
+	kfree(path);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xenbus_mkdir);
+
+/* Destroy a file or directory (directories must be empty). */
+int xenbus_rm(xenbus_transaction_t t, const char *dir, const char *node)
+{
+	char *path;
+	int ret;
+
+	path = join(dir, node);
+	if (IS_ERR(path))
+		return PTR_ERR(path);
+
+	ret = xs_error(xs_single(t, XS_RM, path, NULL));
+	kfree(path);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xenbus_rm);
+
+/* Start a transaction: changes by others will not be seen during this
+ * transaction, and changes will not be visible to others until end.
+ */
+int xenbus_transaction_start(xenbus_transaction_t *t)
+{
+	char *id_str;
+
+	down_read(&xs_state.suspend_mutex);
+
+	id_str = xs_single(XBT_NULL, XS_TRANSACTION_START, "", NULL);
+	if (IS_ERR(id_str)) {
+		up_read(&xs_state.suspend_mutex);
+		return PTR_ERR(id_str);
+	}
+
+	*t = simple_strtoul(id_str, NULL, 0);
+	kfree(id_str);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xenbus_transaction_start);
+
+/* End a transaction.
+ * If abandon is true, transaction is discarded instead of committed.
+ */
+int xenbus_transaction_end(xenbus_transaction_t t, int abort)
+{
+	char abortstr[2];
+	int err;
+
+	if (abort)
+		strcpy(abortstr, "F");
+	else
+		strcpy(abortstr, "T");
+
+	err = xs_error(xs_single(t, XS_TRANSACTION_END, abortstr, NULL));
+
+	up_read(&xs_state.suspend_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_transaction_end);
+
+/* Single read and scanf: returns -errno or num scanned. */
+int xenbus_scanf(xenbus_transaction_t t,
+		 const char *dir, const char *node, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+	char *val;
+
+	val = xenbus_read(t, dir, node, NULL);
+	if (IS_ERR(val))
+		return PTR_ERR(val);
+
+	va_start(ap, fmt);
+	ret = vsscanf(val, fmt, ap);
+	va_end(ap);
+	kfree(val);
+	/* Distinctive errno. */
+	if (ret == 0)
+		return -ERANGE;
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xenbus_scanf);
+
+/* Single printf and write: returns -errno or 0. */
+int xenbus_printf(xenbus_transaction_t t,
+		  const char *dir, const char *node, const char *fmt, ...)
+{
+	va_list ap;
+	int ret;
+#define PRINTF_BUFFER_SIZE 4096
+	char *printf_buffer;
+
+	printf_buffer = kmalloc(PRINTF_BUFFER_SIZE, GFP_KERNEL);
+	if (printf_buffer == NULL)
+		return -ENOMEM;
+
+	va_start(ap, fmt);
+	ret = vsnprintf(printf_buffer, PRINTF_BUFFER_SIZE, fmt, ap);
+	va_end(ap);
+
+	BUG_ON(ret > PRINTF_BUFFER_SIZE-1);
+	ret = xenbus_write(t, dir, node, printf_buffer);
+
+	kfree(printf_buffer);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xenbus_printf);
+
+/* Takes tuples of names, scanf-style args, and void **, NULL terminated. */
+int xenbus_gather(xenbus_transaction_t t, const char *dir, ...)
+{
+	va_list ap;
+	const char *name;
+	int ret = 0;
+
+	va_start(ap, dir);
+	while (ret == 0 && (name = va_arg(ap, char *)) != NULL) {
+		const char *fmt = va_arg(ap, char *);
+		void *result = va_arg(ap, void *);
+		char *p;
+
+		p = xenbus_read(t, dir, name, NULL);
+		if (IS_ERR(p)) {
+			ret = PTR_ERR(p);
+			break;
+		}
+		if (fmt) {
+			if (sscanf(p, fmt, result) == 0)
+				ret = -EINVAL;
+			kfree(p);
+		} else
+			*(char **)result = p;
+	}
+	va_end(ap);
+	return ret;
+}
+EXPORT_SYMBOL_GPL(xenbus_gather);
+
+static int xs_watch(const char *path, const char *token)
+{
+	struct kvec iov[2];
+
+	iov[0].iov_base = (void *)path;
+	iov[0].iov_len = strlen(path) + 1;
+	iov[1].iov_base = (void *)token;
+	iov[1].iov_len = strlen(token) + 1;
+
+	return xs_error(xs_talkv(XBT_NULL, XS_WATCH, iov,
+				 ARRAY_SIZE(iov), NULL));
+}
+
+static int xs_unwatch(const char *path, const char *token)
+{
+	struct kvec iov[2];
+
+	iov[0].iov_base = (char *)path;
+	iov[0].iov_len = strlen(path) + 1;
+	iov[1].iov_base = (char *)token;
+	iov[1].iov_len = strlen(token) + 1;
+
+	return xs_error(xs_talkv(XBT_NULL, XS_UNWATCH, iov,
+				 ARRAY_SIZE(iov), NULL));
+}
+
+static struct xenbus_watch *find_watch(const char *token)
+{
+	struct xenbus_watch *i, *cmp;
+
+	cmp = (void *)simple_strtoul(token, NULL, 16);
+
+	list_for_each_entry(i, &watches, list)
+		if (i == cmp)
+			return i;
+
+	return NULL;
+}
+
+/* Register callback to watch this node. */
+int register_xenbus_watch(struct xenbus_watch *watch)
+{
+	/* Pointer in ascii is the token. */
+	char token[sizeof(watch) * 2 + 1];
+	int err;
+
+	sprintf(token, "%lX", (long)watch);
+
+	down_read(&xs_state.suspend_mutex);
+
+	spin_lock(&watches_lock);
+	BUG_ON(find_watch(token));
+	list_add(&watch->list, &watches);
+	spin_unlock(&watches_lock);
+
+	err = xs_watch(watch->node, token);
+
+	/* Ignore errors due to multiple registration. */
+	if ((err != 0) && (err != -EEXIST)) {
+		spin_lock(&watches_lock);
+		list_del(&watch->list);
+		spin_unlock(&watches_lock);
+	}
+
+	up_read(&xs_state.suspend_mutex);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(register_xenbus_watch);
+
+void unregister_xenbus_watch(struct xenbus_watch *watch)
+{
+	struct xs_stored_msg *msg, *tmp;
+	char token[sizeof(watch) * 2 + 1];
+	int err;
+
+	sprintf(token, "%lX", (long)watch);
+
+	down_read(&xs_state.suspend_mutex);
+
+	spin_lock(&watches_lock);
+	BUG_ON(!find_watch(token));
+	list_del(&watch->list);
+	spin_unlock(&watches_lock);
+
+	err = xs_unwatch(watch->node, token);
+	if (err)
+		printk(KERN_WARNING
+		       "XENBUS Failed to release watch %s: %i\n",
+		       watch->node, err);
+
+	up_read(&xs_state.suspend_mutex);
+
+	/* Cancel pending watch events. */
+	spin_lock(&watch_events_lock);
+	list_for_each_entry_safe(msg, tmp, &watch_events, list) {
+		if (msg->u.watch.handle != watch)
+			continue;
+		list_del(&msg->list);
+		kfree(msg->u.watch.vec);
+		kfree(msg);
+	}
+	spin_unlock(&watch_events_lock);
+
+	/* Flush any currently-executing callback, unless we are it. :-) */
+	if (current->pid != xenwatch_pid) {
+		mutex_lock(&xenwatch_mutex);
+		mutex_unlock(&xenwatch_mutex);
+	}
+}
+EXPORT_SYMBOL_GPL(unregister_xenbus_watch);
+
+void xs_suspend(void)
+{
+	down_write(&xs_state.suspend_mutex);
+	mutex_lock(&xs_state.request_mutex);
+}
+
+void xs_resume(void)
+{
+	struct xenbus_watch *watch;
+	char token[sizeof(watch) * 2 + 1];
+
+	mutex_unlock(&xs_state.request_mutex);
+
+	/* No need for watches_lock: the suspend_mutex is sufficient. */
+	list_for_each_entry(watch, &watches, list) {
+		sprintf(token, "%lX", (long)watch);
+		xs_watch(watch->node, token);
+	}
+
+	up_write(&xs_state.suspend_mutex);
+}
+
+static int xenwatch_thread(void *unused)
+{
+	struct list_head *ent;
+	struct xs_stored_msg *msg;
+
+	for (;;) {
+		wait_event_interruptible(watch_events_waitq,
+					 !list_empty(&watch_events));
+
+		if (kthread_should_stop())
+			break;
+
+		mutex_lock(&xenwatch_mutex);
+
+		spin_lock(&watch_events_lock);
+		ent = watch_events.next;
+		if (ent != &watch_events)
+			list_del(ent);
+		spin_unlock(&watch_events_lock);
+
+		if (ent != &watch_events) {
+			msg = list_entry(ent, struct xs_stored_msg, list);
+			msg->u.watch.handle->callback(
+				msg->u.watch.handle,
+				(const char **)msg->u.watch.vec,
+				msg->u.watch.vec_size);
+			kfree(msg->u.watch.vec);
+			kfree(msg);
+		}
+
+		mutex_unlock(&xenwatch_mutex);
+	}
+
+	return 0;
+}
+
+static int process_msg(void)
+{
+	struct xs_stored_msg *msg;
+	char *body;
+	int err;
+
+	msg = kmalloc(sizeof(*msg), GFP_KERNEL);
+	if (msg == NULL)
+		return -ENOMEM;
+
+	err = xb_read(&msg->hdr, sizeof(msg->hdr));
+	if (err) {
+		kfree(msg);
+		return err;
+	}
+
+	body = kmalloc(msg->hdr.len + 1, GFP_KERNEL);
+	if (body == NULL) {
+		kfree(msg);
+		return -ENOMEM;
+	}
+
+	err = xb_read(body, msg->hdr.len);
+	if (err) {
+		kfree(body);
+		kfree(msg);
+		return err;
+	}
+	body[msg->hdr.len] = '\0';
+
+	if (msg->hdr.type == XS_WATCH_EVENT) {
+		msg->u.watch.vec = split(body, msg->hdr.len,
+					 &msg->u.watch.vec_size);
+		if (IS_ERR(msg->u.watch.vec)) {
+			kfree(msg);
+			return PTR_ERR(msg->u.watch.vec);
+		}
+
+		spin_lock(&watches_lock);
+		msg->u.watch.handle = find_watch(
+			msg->u.watch.vec[XS_WATCH_TOKEN]);
+		if (msg->u.watch.handle != NULL) {
+			spin_lock(&watch_events_lock);
+			list_add_tail(&msg->list, &watch_events);
+			wake_up(&watch_events_waitq);
+			spin_unlock(&watch_events_lock);
+		} else {
+			kfree(msg->u.watch.vec);
+			kfree(msg);
+		}
+		spin_unlock(&watches_lock);
+	} else {
+		msg->u.reply.body = body;
+		spin_lock(&xs_state.reply_lock);
+		list_add_tail(&msg->list, &xs_state.reply_list);
+		spin_unlock(&xs_state.reply_lock);
+		wake_up(&xs_state.reply_waitq);
+	}
+
+	return 0;
+}
+
+static int xenbus_thread(void *unused)
+{
+	int err;
+
+	for (;;) {
+		err = process_msg();
+		if (err)
+			printk(KERN_WARNING "XENBUS error %d while reading "
+			       "message\n", err);
+		if (kthread_should_stop())
+			break;
+	}
+
+	return 0;
+}
+
+int xs_init(void)
+{
+	int err;
+	struct task_struct *task;
+
+	INIT_LIST_HEAD(&xs_state.reply_list);
+	spin_lock_init(&xs_state.reply_lock);
+	init_waitqueue_head(&xs_state.reply_waitq);
+
+	mutex_init(&xs_state.request_mutex);
+	init_rwsem(&xs_state.suspend_mutex);
+
+	/* Initialize the shared memory rings to talk to xenstored */
+	err = xb_init_comms();
+	if (err)
+		return err;
+
+	task = kthread_run(xenwatch_thread, NULL, "xenwatch");
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+	xenwatch_pid = task->pid;
+
+	task = kthread_run(xenbus_thread, NULL, "xenbus");
+	if (IS_ERR(task))
+		return PTR_ERR(task);
+
+	return 0;
+}
--- /dev/null
+++ linus-2.6/include/xen/xenbus.h
@@ -0,0 +1,291 @@
+/******************************************************************************
+ * xenbus.h
+ *
+ * Talks to Xen Store to figure out what devices we have.
+ *
+ * Copyright (C) 2005 Rusty Russell, IBM Corporation
+ * Copyright (C) 2005 XenSource Ltd.
+ * 
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License version 2
+ * as published by the Free Software Foundation; or, when distributed
+ * separately from the Linux kernel or incorporated into other
+ * software packages, subject to the following license:
+ * 
+ * Permission is hereby granted, free of charge, to any person obtaining a copy
+ * of this source file (the "Software"), to deal in the Software without
+ * restriction, including without limitation the rights to use, copy, modify,
+ * merge, publish, distribute, sublicense, and/or sell copies of the Software,
+ * and to permit persons to whom the Software is furnished to do so, subject to
+ * the following conditions:
+ * 
+ * The above copyright notice and this permission notice shall be included in
+ * all copies or substantial portions of the Software.
+ * 
+ * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
+ * IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
+ * FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
+ * AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
+ * LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
+ * FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS
+ * IN THE SOFTWARE.
+ */
+
+#ifndef _XEN_XENBUS_H
+#define _XEN_XENBUS_H
+
+#include <linux/device.h>
+#include <linux/notifier.h>
+#include <linux/mutex.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/grant_table.h>
+#include <xen/interface/io/xenbus.h>
+#include <xen/interface/io/xs_wire.h>
+
+#define XBT_NULL 0
+
+/* Register callback to watch this node. */
+struct xenbus_watch
+{
+	struct list_head list;
+
+	/* Path being watched. */
+	const char *node;
+
+	/* Callback (executed in a process context with no locks held). */
+	void (*callback)(struct xenbus_watch *,
+			 const char **vec, unsigned int len);
+};
+
+
+/* A xenbus device. */
+struct xenbus_device {
+	const char *devicetype;
+	const char *nodename;
+	const char *otherend;
+	int otherend_id;
+	struct xenbus_watch otherend_watch;
+	struct device dev;
+	XenbusState state;
+	void *data;
+};
+
+static inline struct xenbus_device *to_xenbus_device(struct device *dev)
+{
+	return container_of(dev, struct xenbus_device, dev);
+}
+
+struct xenbus_device_id
+{
+	/* .../device/<device_type>/<identifier> */
+	char devicetype[32]; 	/* General class of device. */
+};
+
+/* A xenbus driver. */
+struct xenbus_driver {
+	char *name;
+	struct module *owner;
+	const struct xenbus_device_id *ids;
+	int (*probe)(struct xenbus_device *dev,
+		     const struct xenbus_device_id *id);
+	void (*otherend_changed)(struct xenbus_device *dev,
+				 XenbusState backend_state);
+	int (*remove)(struct xenbus_device *dev);
+	int (*suspend)(struct xenbus_device *dev);
+	int (*resume)(struct xenbus_device *dev);
+	int (*uevent)(struct xenbus_device *, char **, int, char *, int);
+	struct device_driver driver;
+	int (*read_otherend_details)(struct xenbus_device *dev);
+};
+
+static inline struct xenbus_driver *to_xenbus_driver(struct device_driver *drv)
+{
+	return container_of(drv, struct xenbus_driver, driver);
+}
+
+int xenbus_register_frontend(struct xenbus_driver *drv);
+int xenbus_register_backend(struct xenbus_driver *drv);
+void xenbus_unregister_driver(struct xenbus_driver *drv);
+
+typedef u32 xenbus_transaction_t;
+
+char **xenbus_directory(xenbus_transaction_t t,
+			const char *dir, const char *node, unsigned int *num);
+void *xenbus_read(xenbus_transaction_t t,
+		  const char *dir, const char *node, unsigned int *len);
+int xenbus_write(xenbus_transaction_t t,
+		 const char *dir, const char *node, const char *string);
+int xenbus_mkdir(xenbus_transaction_t t,
+		 const char *dir, const char *node);
+int xenbus_exists(xenbus_transaction_t t,
+		  const char *dir, const char *node);
+int xenbus_rm(xenbus_transaction_t t, const char *dir, const char *node);
+int xenbus_transaction_start(xenbus_transaction_t *t);
+int xenbus_transaction_end(xenbus_transaction_t t, int abort);
+
+/* Single read and scanf: returns -errno or num scanned if > 0. */
+int xenbus_scanf(xenbus_transaction_t t,
+		 const char *dir, const char *node, const char *fmt, ...)
+	__attribute__((format(scanf, 4, 5)));
+
+/* Single printf and write: returns -errno or 0. */
+int xenbus_printf(xenbus_transaction_t t,
+		  const char *dir, const char *node, const char *fmt, ...)
+	__attribute__((format(printf, 4, 5)));
+
+/* Generic read function: NULL-terminated triples of name,
+ * sprintf-style type string, and pointer. Returns 0 or errno.*/
+int xenbus_gather(xenbus_transaction_t t, const char *dir, ...);
+
+/* notifer routines for when the xenstore comes up */
+int register_xenstore_notifier(struct notifier_block *nb);
+void unregister_xenstore_notifier(struct notifier_block *nb);
+
+int register_xenbus_watch(struct xenbus_watch *watch);
+void unregister_xenbus_watch(struct xenbus_watch *watch);
+void xs_suspend(void);
+void xs_resume(void);
+
+/* Used by xenbus_dev to borrow kernel's store connection. */
+void *xenbus_dev_request_and_reply(struct xsd_sockmsg *msg);
+
+/* Called from xen core code. */
+void xenbus_suspend(void);
+void xenbus_resume(void);
+
+#define XENBUS_IS_ERR_READ(str) ({			\
+	if (!IS_ERR(str) && strlen(str) == 0) {		\
+		kfree(str);				\
+		str = ERR_PTR(-ERANGE);			\
+	}						\
+	IS_ERR(str);					\
+})
+
+#define XENBUS_EXIST_ERR(err) ((err) == -ENOENT || (err) == -ERANGE)
+
+
+/**
+ * Register a watch on the given path, using the given xenbus_watch structure
+ * for storage, and the given callback function as the callback.  Return 0 on
+ * success, or -errno on error.  On success, the given path will be saved as
+ * watch->node, and remains the caller's to free.  On error, watch->node will
+ * be NULL, the device will switch to XenbusStateClosing, and the error will
+ * be saved in the store.
+ */
+int xenbus_watch_path(struct xenbus_device *dev, const char *path,
+		      struct xenbus_watch *watch,
+		      void (*callback)(struct xenbus_watch *,
+				       const char **, unsigned int));
+
+
+/**
+ * Register a watch on the given path/path2, using the given xenbus_watch
+ * structure for storage, and the given callback function as the callback.
+ * Return 0 on success, or -errno on error.  On success, the watched path
+ * (path/path2) will be saved as watch->node, and becomes the caller's to
+ * kfree().  On error, watch->node will be NULL, so the caller has nothing to
+ * free, the device will switch to XenbusStateClosing, and the error will be
+ * saved in the store.
+ */
+int xenbus_watch_path2(struct xenbus_device *dev, const char *path,
+		       const char *path2, struct xenbus_watch *watch,
+		       void (*callback)(struct xenbus_watch *,
+					const char **, unsigned int));
+
+
+/**
+ * Advertise in the store a change of the given driver to the given new_state.
+ * Perform the change inside the given transaction xbt.  xbt may be NULL, in
+ * which case this is performed inside its own transaction.  Return 0 on
+ * success, or -errno on error.  On error, the device will switch to
+ * XenbusStateClosing, and the error will be saved in the store.
+ */
+int xenbus_switch_state(struct xenbus_device *dev,
+			xenbus_transaction_t xbt,
+			XenbusState new_state);
+
+
+/**
+ * Grant access to the given ring_mfn to the peer of the given device.  Return
+ * 0 on success, or -errno on error.  On error, the device will switch to
+ * XenbusStateClosing, and the error will be saved in the store.
+ */
+int xenbus_grant_ring(struct xenbus_device *dev, unsigned long ring_mfn);
+
+
+/**
+ * Map a page of memory into this domain from another domain's grant table.
+ * xenbus_map_ring_valloc allocates a page of virtual address space, maps the
+ * page to that address, and sets *vaddr to that address.
+ * xenbus_map_ring does not allocate the virtual address space (you must do
+ * this yourself!). It only maps in the page to the specified address.
+ * Returns 0 on success, and GNTST_* (see xen/include/interface/grant_table.h)
+ * or -ENOMEM on error. If an error is returned, device will switch to
+ * XenbusStateClosing and the error message will be saved in XenStore.
+ */
+int xenbus_map_ring_valloc(struct xenbus_device *dev,
+			   int gnt_ref, void **vaddr);
+int xenbus_map_ring(struct xenbus_device *dev, int gnt_ref,
+			   grant_handle_t *handle, void *vaddr);
+
+
+/**
+ * Unmap a page of memory in this domain that was imported from another domain.
+ * Use xenbus_unmap_ring_vfree if you mapped in your memory with
+ * xenbus_map_ring_valloc (it will free the virtual address space).
+ * Returns 0 on success and returns GNTST_* on error
+ * (see xen/include/interface/grant_table.h).
+ */
+int xenbus_unmap_ring_vfree(struct xenbus_device *dev, void *vaddr);
+int xenbus_unmap_ring(struct xenbus_device *dev,
+		      grant_handle_t handle, void *vaddr);
+
+
+/**
+ * Allocate an event channel for the given xenbus_device, assigning the newly
+ * created local port to *port.  Return 0 on success, or -errno on error.  On
+ * error, the device will switch to XenbusStateClosing, and the error will be
+ * saved in the store.
+ */
+int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port);
+
+
+/**
+ * Bind to an existing interdomain event channel in another domain. Returns 0
+ * on success and stores the local port in *port. On error, returns -errno,
+ * switches the device to XenbusStateClosing, and saves the error in XenStore.
+ */
+int xenbus_bind_evtchn(struct xenbus_device *dev, int remote_port, int *port);
+
+
+/**
+ * Free an existing event channel. Returns 0 on success or -errno on error.
+ */
+int xenbus_free_evtchn(struct xenbus_device *dev, int port);
+
+
+/**
+ * Return the state of the driver rooted at the given store path, or
+ * XenbusStateClosed if no state can be read.
+ */
+XenbusState xenbus_read_driver_state(const char *path);
+
+
+/***
+ * Report the given negative errno into the store, along with the given
+ * formatted message.
+ */
+void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt,
+		      ...);
+
+
+/***
+ * Equivalent to xenbus_dev_error(dev, err, fmt, args), followed by
+ * xenbus_switch_state(dev, NULL, XenbusStateClosing) to schedule an orderly
+ * closedown of this driver and its peer.
+ */
+void xenbus_dev_fatal(struct xenbus_device *dev, int err, const char *fmt,
+		      ...);
+
+
+#endif /* _XEN_XENBUS_H */

--
