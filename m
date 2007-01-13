Return-Path: <linux-kernel-owner+w=401wt.eu-S1422831AbXAMXNH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422831AbXAMXNH (ORCPT <rfc822;w@1wt.eu>);
	Sat, 13 Jan 2007 18:13:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422828AbXAMXMe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 13 Jan 2007 18:12:34 -0500
Received: from gw.goop.org ([64.81.55.164]:59916 "EHLO mail.goop.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1422797AbXAMXMC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 13 Jan 2007 18:12:02 -0500
Message-Id: <20070113014649.154623814@goop.org>
References: <20070113014539.408244126@goop.org>
User-Agent: quilt/0.46-1
Date: Fri, 12 Jan 2007 17:45:58 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, virtualization@lists.osdl.org,
       xen-devel@lists.xensource.com, Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>,
       Chris Wright <chrisw@sous-sol.org>
Subject: [patch 19/20] XEN-paravirt: Add the Xenbus sysfs and virtual device hotplug driver.
Content-Disposition: inline; filename=xenbus.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This communicates with the machine control software via a registry
residing in a controlling virtual machine. This allows dynamic
creation, destruction and modification of virtual device
configurations (network devices, block devices and CPUS, to name some
examples).

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Jeremy Fitzhardinge <jeremy@xensource.com>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/xen/Makefile               |    1
 drivers/xen/xenbus/Makefile        |    7
 drivers/xen/xenbus/xenbus_client.c |  528 ++++++++++++++++++++
 drivers/xen/xenbus/xenbus_comms.c  |  222 ++++++++
 drivers/xen/xenbus/xenbus_comms.h  |   43 +
 drivers/xen/xenbus/xenbus_probe.c  |  954 +++++++++++++++++++++++++++++++++++++
 drivers/xen/xenbus/xenbus_xs.c     |  828 ++++++++++++++++++++++++++++++++
 include/xen/xenbus.h               |  199 +++++++
 8 files changed, 2782 insertions(+)

===================================================================
--- a/arch/i386/paravirt-xen/Kconfig
+++ b/arch/i386/paravirt-xen/Kconfig
@@ -8,3 +8,8 @@ config XEN
 	default y
 	help
 	  This is the Linux Xen port.
+
+config XEN_BACKEND
+	bool
+	depends XEN
+	default n
===================================================================
--- a/arch/i386/paravirt-xen/events.h
+++ b/arch/i386/paravirt-xen/events.h
@@ -2,6 +2,8 @@
 #define _XEN_EVENTS_H
 
 #include <linux/irq.h>
+
+#include <asm/hypercall.h>
 
 int bind_evtchn_to_irqhandler(unsigned int evtchn,
 			      irqreturn_t (*handler)(int, void *),
===================================================================
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -2,3 +2,4 @@ obj-y	+= util.o
 
 obj-y	+= core/
 obj-y	+= console/
+obj-y	+= xenbus/
===================================================================
--- /dev/null
+++ b/drivers/xen/xenbus/Makefile
@@ -0,0 +1,9 @@
+obj-y	+= xenbus.o
+
+xenbus-objs =
+xenbus-objs += xenbus_client.o
+xenbus-objs += xenbus_comms.o
+xenbus-objs += xenbus_xs.o
+xenbus-objs += xenbus_probe.o
+
+obj-$(CONFIG_XEN_BACKEND) += xenbus_probe_backend.o
===================================================================
--- /dev/null
+++ b/drivers/xen/xenbus/xenbus_client.c
@@ -0,0 +1,565 @@
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
+#include <linux/types.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/event_channel.h>
+#include "../../../arch/i386/paravirt-xen/events.h"
+#include <xen/grant_table.h>
+#include <xen/xenbus.h>
+#include <xen/driver_util.h>
+
+char *xenbus_strstate(enum xenbus_state state)
+{
+	static char *name[] = {
+		[ XenbusStateUnknown      ] = "Unknown",
+		[ XenbusStateInitialising ] = "Initialising",
+		[ XenbusStateInitWait     ] = "InitWait",
+		[ XenbusStateInitialised  ] = "Initialised",
+		[ XenbusStateConnected    ] = "Connected",
+		[ XenbusStateClosing      ] = "Closing",
+		[ XenbusStateClosed	  ] = "Closed",
+	};
+	return (state < ARRAY_SIZE(name)) ? name[state] : "INVALID";
+}
+
+/**
+ * xenbus_watch_path - register a watch
+ * @dev: xenbus device
+ * @path: path to watch
+ * @watch: watch to register
+ * @callback: callback to register
+ *
+ * Register a @watch on the given path, using the given xenbus_watch structure
+ * for storage, and the given @callback function as the callback.  Return 0 on
+ * success, or -errno on error.  On success, the given @path will be saved as
+ * @watch->node, and remains the caller's to free.  On error, @watch->node will
+ * be NULL, the device will switch to %XenbusStateClosing, and the error will
+ * be saved in the store.
+ */
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
+/**
+ * xenbus_watch_path2 - register a watch on path/path2
+ * @dev: xenbus device
+ * @path: first half of path to watch
+ * @path2: second half of path to watch
+ * @watch: watch to register
+ * @callback: callback to register
+ *
+ * Register a watch on the given @path/@path2, using the given xenbus_watch
+ * structure for storage, and the given @callback function as the callback.
+ * Return 0 on success, or -errno on error.  On success, the watched path
+ * (@path/@path2) will be saved as @watch->node, and becomes the caller's to
+ * kfree().  On error, watch->node will be NULL, so the caller has nothing to
+ * free, the device will switch to %XenbusStateClosing, and the error will be
+ * saved in the store.
+ */
+int xenbus_watch_path2(struct xenbus_device *dev, const char *path,
+		       const char *path2, struct xenbus_watch *watch,
+		       void (*callback)(struct xenbus_watch *,
+					const char **, unsigned int))
+{
+	int err;
+	char *state = kasprintf(GFP_KERNEL, "%s/%s", path, path2);
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
+/**
+ * xenbus_switch_state
+ * @dev: xenbus device
+ * @xbt: transaction handle
+ * @state: new state
+ *
+ * Advertise in the store a change of the given driver to the given new_state.
+ * Return 0 on success, or -errno on error.  On error, the device will switch
+ * to XenbusStateClosing, and the error will be saved in the store.
+ */
+int xenbus_switch_state(struct xenbus_device *dev, enum xenbus_state state)
+{
+	/* We check whether the state is currently set to the given value, and
+	   if not, then the state is set.  We don't want to unconditionally
+	   write the given state, because we don't want to fire watches
+	   unnecessarily.  Furthermore, if the node has gone, we don't write
+	   to it, as the device will be tearing down, and we don't want to
+	   resurrect that directory.
+
+	   Note that, because of this cached value of our state, this function
+	   will not work inside a Xenstore transaction (something it was
+	   trying to in the past) because dev->state would not get reset if
+	   the transaction was aborted.
+
+	 */
+
+	int current_state;
+	int err;
+
+	if (state == dev->state)
+		return 0;
+
+	err = xenbus_scanf(XBT_NIL, dev->nodename, "state", "%d",
+			   &current_state);
+	if (err != 1)
+		return 0;
+
+	err = xenbus_printf(XBT_NIL, dev->nodename, "state", "%d", state);
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
+int xenbus_frontend_closed(struct xenbus_device *dev)
+{
+	xenbus_switch_state(dev, XenbusStateClosed);
+	complete(&dev->down);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xenbus_frontend_closed);
+
+/**
+ * Return the path to the error node for the given device, or NULL on failure.
+ * If the value returned is non-NULL, then it is the caller's to kfree.
+ */
+static char *error_path(struct xenbus_device *dev)
+{
+	return kasprintf(GFP_KERNEL, "error/%s", dev->nodename);
+}
+
+
+static void xenbus_va_dev_error(struct xenbus_device *dev, int err,
+				const char *fmt, va_list ap)
+{
+	int ret;
+	unsigned int len;
+	char *printf_buffer = NULL;
+	char *path_buffer = NULL;
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
+		dev_err(&dev->dev, "failed to write error node for %s (%s)\n",
+		       dev->nodename, printf_buffer);
+		goto fail;
+	}
+
+	if (xenbus_write(XBT_NIL, path_buffer, "error", printf_buffer) != 0) {
+		dev_err(&dev->dev, "failed to write error node for %s (%s)\n",
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
+/**
+ * xenbus_dev_error
+ * @dev: xenbus device
+ * @err: error to report
+ * @fmt: error message format
+ *
+ * Report the given negative errno into the store, along with the given
+ * formatted message.
+ */
+void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	xenbus_va_dev_error(dev, err, fmt, ap);
+	va_end(ap);
+}
+EXPORT_SYMBOL_GPL(xenbus_dev_error);
+
+/**
+ * xenbus_dev_fatal
+ * @dev: xenbus device
+ * @err: error to report
+ * @fmt: error message format
+ *
+ * Equivalent to xenbus_dev_error(dev, err, fmt, args), followed by
+ * xenbus_switch_state(dev, NULL, XenbusStateClosing) to schedule an orderly
+ * closedown of this driver and its peer.
+ */
+
+void xenbus_dev_fatal(struct xenbus_device *dev, int err, const char *fmt, ...)
+{
+	va_list ap;
+
+	va_start(ap, fmt);
+	xenbus_va_dev_error(dev, err, fmt, ap);
+	va_end(ap);
+
+	xenbus_switch_state(dev, XenbusStateClosing);
+}
+EXPORT_SYMBOL_GPL(xenbus_dev_fatal);
+
+/**
+ * xenbus_grant_ring
+ * @dev: xenbus device
+ * @ring_mfn: mfn of ring to grant
+
+ * Grant access to the given @ring_mfn to the peer of the given device.  Return
+ * 0 on success, or -errno on error.  On error, the device will switch to
+ * XenbusStateClosing, and the error will be saved in the store.
+ */
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
+/**
+ * Allocate an event channel for the given xenbus_device, assigning the newly
+ * created local port to *port.  Return 0 on success, or -errno on error.  On
+ * error, the device will switch to XenbusStateClosing, and the error will be
+ * saved in the store.
+ */
+int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port)
+{
+	struct evtchn_alloc_unbound alloc_unbound;
+	int err;
+
+	alloc_unbound.dom = DOMID_SELF;
+	alloc_unbound.remote_dom = dev->otherend_id;
+
+	err = HYPERVISOR_event_channel_op(EVTCHNOP_alloc_unbound,
+					  &alloc_unbound);
+	if (err)
+		xenbus_dev_fatal(dev, err, "allocating event channel");
+	else
+		*port = alloc_unbound.port;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_alloc_evtchn);
+
+
+/**
+ * Bind to an existing interdomain event channel in another domain. Returns 0
+ * on success and stores the local port in *port. On error, returns -errno,
+ * switches the device to XenbusStateClosing, and saves the error in XenStore.
+ */
+int xenbus_bind_evtchn(struct xenbus_device *dev, int remote_port, int *port)
+{
+	struct evtchn_bind_interdomain bind_interdomain;
+	int err;
+
+	bind_interdomain.remote_dom = dev->otherend_id;
+	bind_interdomain.remote_port = remote_port;
+
+	err = HYPERVISOR_event_channel_op(EVTCHNOP_bind_interdomain,
+					  &bind_interdomain);
+	if (err)
+		xenbus_dev_fatal(dev, err,
+				 "binding to event channel %d from domain %d",
+				 remote_port, dev->otherend_id);
+	else
+		*port = bind_interdomain.local_port;
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_bind_evtchn);
+
+
+/**
+ * Free an existing event channel. Returns 0 on success or -errno on error.
+ */
+int xenbus_free_evtchn(struct xenbus_device *dev, int port)
+{
+	struct evtchn_close close;
+	int err;
+
+	close.port = port;
+
+	err = HYPERVISOR_event_channel_op(EVTCHNOP_close, &close);
+	if (err)
+		xenbus_dev_error(dev, err, "freeing event channel %d", port);
+
+	return err;
+}
+EXPORT_SYMBOL_GPL(xenbus_free_evtchn);
+
+
+/**
+ * xenbus_map_ring_valloc
+ * @dev: xenbus device
+ * @gnt_ref: grant reference
+ * @vaddr: pointer to address to be filled out by mapping
+ *
+ * Based on Rusty Russell's skeleton driver's map_page.
+ * Map a page of memory into this domain from another domain's grant table.
+ * xenbus_map_ring_valloc allocates a page of virtual address space, maps the
+ * page to that address, and sets *vaddr to that address.
+ * Returns 0 on success, and GNTST_* (see xen/include/interface/grant_table.h)
+ * or -ENOMEM on error. If an error is returned, device will switch to
+ * XenbusStateClosing and the error message will be saved in XenStore.
+ */
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
+	if (HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref, &op, 1))
+		BUG();
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
+/**
+ * xenbus_map_ring
+ * @dev: xenbus device
+ * @gnt_ref: grant reference
+ * @handle: pointer to grant handle to be filled
+ * @vaddr: address to be mapped to
+ *
+ * Map a page of memory into this domain from another domain's grant table.
+ * xenbus_map_ring does not allocate the virtual address space (you must do
+ * this yourself!). It only maps in the page to the specified address.
+ * Returns 0 on success, and GNTST_* (see xen/include/interface/grant_table.h)
+ * or -ENOMEM on error. If an error is returned, device will switch to
+ * XenbusStateClosing and the error message will be saved in XenStore.
+ */
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
+	if (HYPERVISOR_grant_table_op(GNTTABOP_map_grant_ref, &op, 1))
+		BUG();
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
+/**
+ * xenbus_unmap_ring_vfree
+ * @dev: xenbus device
+ * @vaddr: addr to unmap
+ *
+ * Based on Rusty Russell's skeleton driver's unmap_page.
+ * Unmap a page of memory in this domain that was imported from another domain.
+ * Use xenbus_unmap_ring_vfree if you mapped in your memory with
+ * xenbus_map_ring_valloc (it will free the virtual address space).
+ * Returns 0 on success and returns GNTST_* on error
+ * (see xen/include/interface/grant_table.h).
+ */
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
+	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, &op, 1))
+		BUG();
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
+/**
+ * xenbus_unmap_ring
+ * @dev: xenbus device
+ * @handle: grant handle
+ * @vaddr: addr to unmap
+ *
+ * Unmap a page of memory in this domain that was imported from another domain.
+ * Returns 0 on success and returns GNTST_* on error
+ * (see xen/include/interface/grant_table.h).
+ */
+int xenbus_unmap_ring(struct xenbus_device *dev,
+		      grant_handle_t handle, void *vaddr)
+{
+	struct gnttab_unmap_grant_ref op = {
+		.host_addr = (unsigned long)vaddr,
+		.handle    = handle,
+	};
+
+	if (HYPERVISOR_grant_table_op(GNTTABOP_unmap_grant_ref, &op, 1))
+		BUG();
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
+/**
+ * xenbus_read_driver_state
+ * @path: path for driver
+ *
+ * Return the state of the driver rooted at the given store path, or
+ * XenbusStateUnknown if no state can be read.
+ */
+enum xenbus_state xenbus_read_driver_state(const char *path)
+{
+	enum xenbus_state result;
+	int err = xenbus_gather(XBT_NIL, path, "state", "%d", &result, NULL);
+	if (err)
+		result = XenbusStateUnknown;
+
+	return result;
+}
+EXPORT_SYMBOL_GPL(xenbus_read_driver_state);
===================================================================
--- /dev/null
+++ b/drivers/xen/xenbus/xenbus_comms.c
@@ -0,0 +1,218 @@
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
+#include <linux/wait.h>
+#include <linux/interrupt.h>
+#include <linux/sched.h>
+#include <linux/err.h>
+#include <xen/xenbus.h>
+#include <asm/hypervisor.h>
+#include "../../../arch/i386/paravirt-xen/events.h"
+#include "../../../arch/i386/paravirt-xen/xen-page.h"
+#include "xenbus_comms.h"
+
+static int xenbus_irq;
+
+static DECLARE_WORK(probe_work, xenbus_probe);
+
+static DECLARE_WAIT_QUEUE_HEAD(xb_waitq);
+
+static irqreturn_t wake_waiting(int irq, void *unused)
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
+/**
+ * xb_write - low level write
+ * @data: buffer to send
+ * @len: length of buffer
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int xb_write(const void *data, unsigned len)
+{
+	struct xenstore_domain_interface *intf = xen_store_interface;
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
+		notify_remote_via_evtchn(xen_store_evtchn);
+	}
+
+	return 0;
+}
+
+/**
+ * xb_read - low level read
+ * @data: buffer to fill
+ * @len: length of buffer
+ *
+ * Returns 0 on success, error otherwise.
+ */
+int xb_read(void *data, unsigned len)
+{
+	struct xenstore_domain_interface *intf = xen_store_interface;
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
+		notify_remote_via_evtchn(xen_store_evtchn);
+	}
+
+	return 0;
+}
+
+/**
+ * xb_init_comms - Set up interrupt handler off store event channel.
+ */
+int xb_init_comms(void)
+{
+	int err;
+
+	if (xenbus_irq)
+		unbind_from_irqhandler(xenbus_irq, &xb_waitq);
+
+	err = bind_evtchn_to_irqhandler(
+		xen_store_evtchn, wake_waiting,
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
===================================================================
--- /dev/null
+++ b/drivers/xen/xenbus/xenbus_comms.h
@@ -0,0 +1,44 @@
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
+extern struct xenstore_domain_interface *xen_store_interface;
+extern int xen_store_evtchn;
+
+#endif /* _XENBUS_COMMS_H */
===================================================================
--- /dev/null
+++ b/drivers/xen/xenbus/xenbus_probe.c
@@ -0,0 +1,891 @@
+/******************************************************************************
+ * Talks to Xen Store to figure out what devices we have.
+ *
+ * Copyright (C) 2005 Rusty Russell, IBM Corporation
+ * Copyright (C) 2005 Mike Wray, Hewlett-Packard
+ * Copyright (C) 2005, 2006 XenSource Ltd
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
+#define DPRINTK(fmt, args...)				\
+	pr_debug("xenbus_probe (%s:%d) " fmt ".\n",	\
+		 __FUNCTION__, __LINE__, ##args)
+
+#include <linux/kernel.h>
+#include <linux/err.h>
+#include <linux/string.h>
+#include <linux/ctype.h>
+#include <linux/fcntl.h>
+#include <linux/mm.h>
+#include <linux/notifier.h>
+#include <linux/kthread.h>
+#include <linux/mutex.h>
+
+#include <asm/io.h>
+#include <asm/page.h>
+#include <asm/pgtable.h>
+#include <asm/hypervisor.h>
+#include <xen/xenbus.h>
+
+#include "xenbus_comms.h"
+#include "xenbus_probe.h"
+#include "../../../arch/i386/paravirt-xen/events.h"
+#include "../../../arch/i386/paravirt-xen/xen-page.h"
+
+int xen_store_evtchn;
+struct xenstore_domain_interface *xen_store_interface;
+static unsigned long xen_store_mfn;
+
+static BLOCKING_NOTIFIER_HEAD(xenstore_chain);
+
+static void wait_for_devices(struct xenbus_driver *xendrv);
+
+static int xenbus_probe_frontend(const char *type, const char *name);
+
+static void xenbus_dev_shutdown(struct device *_dev);
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
+int xenbus_match(struct device *_dev, struct device_driver *_drv)
+{
+	struct xenbus_driver *drv = to_xenbus_driver(_drv);
+
+	if (!drv->ids)
+		return 0;
+
+	return match_device(drv->ids, to_xenbus_device(_dev)) != NULL;
+}
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
+int read_otherend_details(struct xenbus_device *xendev,
+				 char *id_node, char *path_node)
+{
+	int err = xenbus_gather(XBT_NIL, xendev->nodename,
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
+	    !xenbus_exists(XBT_NIL, xendev->otherend, "")) {
+		xenbus_dev_fatal(xendev, -ENOENT,
+				 "unable to read other end from %s.  "
+				 "missing or inaccessible.",
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
+/* Bus type for frontend drivers. */
+static struct xen_bus_type xenbus_frontend = {
+	.root = "device",
+	.levels = 2, 		/* device/type/<id> */
+	.get_bus_id = frontend_bus_id,
+	.probe = xenbus_probe_frontend,
+	.bus = {
+		.name     = "xen",
+		.match    = xenbus_match,
+		.probe    = xenbus_dev_probe,
+		.remove   = xenbus_dev_remove,
+		.shutdown = xenbus_dev_shutdown,
+	},
+};
+
+static void otherend_changed(struct xenbus_watch *watch,
+			     const char **vec, unsigned int len)
+{
+	struct xenbus_device *dev =
+		container_of(watch, struct xenbus_device, otherend_watch);
+	struct xenbus_driver *drv = to_xenbus_driver(dev->dev.driver);
+	enum xenbus_state state;
+
+	/* Protect us against watches firing on old details when the otherend
+	   details change, say immediately after a resume. */
+	if (!dev->otherend ||
+	    strncmp(dev->otherend, vec[XS_WATCH_PATH],
+		    strlen(dev->otherend))) {
+		dev_dbg(&dev->dev, "Ignoring watch at %s", vec[XS_WATCH_PATH]);
+		return;
+	}
+
+	state = xenbus_read_driver_state(dev->otherend);
+
+	dev_dbg(&dev->dev, "state is %d, (%s), %s, %s",
+		state, xenbus_strstate(state), dev->otherend_watch.node,
+		vec[XS_WATCH_PATH]);
+
+	/*
+	 * Ignore xenbus transitions during shutdown. This prevents us doing
+	 * work that can fail e.g., when the rootfs is gone.
+	 */
+	if (system_state > SYSTEM_RUNNING) {
+		struct xen_bus_type *bus = bus;
+		bus = container_of(dev->dev.bus, struct xen_bus_type, bus);
+		/* If we're frontend, drive the state machine to Closed. */
+		/* This should cause the backend to release our resources. */
+		if ((bus == &xenbus_frontend) && (state == XenbusStateClosing))
+			xenbus_frontend_closed(dev);
+		return;
+	}
+
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
+int xenbus_dev_probe(struct device *_dev)
+{
+	struct xenbus_device *dev = to_xenbus_device(_dev);
+	struct xenbus_driver *drv = to_xenbus_driver(_dev->driver);
+	const struct xenbus_device_id *id;
+	int err;
+
+	DPRINTK("%s", dev->nodename);
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
+		dev_warn(&dev->dev, "talk_to_otherend on %s failed.\n",
+			 dev->nodename);
+		return err;
+	}
+
+	err = drv->probe(dev, id);
+	if (err)
+		goto fail;
+
+	err = watch_otherend(dev);
+	if (err) {
+		dev_warn(&dev->dev, "watch_otherend on %s failed.\n",
+		       dev->nodename);
+		return err;
+	}
+
+	return 0;
+fail:
+	xenbus_dev_error(dev, err, "xenbus_dev_probe on %s", dev->nodename);
+	xenbus_switch_state(dev, XenbusStateClosed);
+	return -ENODEV;
+}
+
+int xenbus_dev_remove(struct device *_dev)
+{
+	struct xenbus_device *dev = to_xenbus_device(_dev);
+	struct xenbus_driver *drv = to_xenbus_driver(_dev->driver);
+
+	DPRINTK("%s", dev->nodename);
+
+	free_otherend_watch(dev);
+	free_otherend_details(dev);
+
+	if (drv->remove)
+		drv->remove(dev);
+
+	xenbus_switch_state(dev, XenbusStateClosed);
+	return 0;
+}
+
+static void xenbus_dev_shutdown(struct device *_dev)
+{
+	struct xenbus_device *dev = to_xenbus_device(_dev);
+	unsigned long timeout = 5*HZ;
+
+	DPRINTK("%s", dev->nodename);
+
+	get_device(&dev->dev);
+	if (dev->state != XenbusStateConnected) {
+		printk("%s: %s: %s != Connected, skipping\n", __FUNCTION__,
+		       dev->nodename, xenbus_strstate(dev->state));
+		goto out;
+	}
+	xenbus_switch_state(dev, XenbusStateClosing);
+	timeout = wait_for_completion_timeout(&dev->down, timeout);
+	if (!timeout)
+		printk("%s: %s timeout closing device\n", __FUNCTION__, dev->nodename);
+ out:
+	put_device(&dev->dev);
+}
+
+int xenbus_register_driver_common(struct xenbus_driver *drv,
+				  struct xen_bus_type *bus)
+{
+	drv->driver.name = drv->name;
+	drv->driver.bus = &bus->bus;
+	drv->driver.owner = drv->owner;
+
+	return driver_register(&drv->driver);
+}
+
+int xenbus_register_frontend(struct xenbus_driver *drv)
+{
+	int ret;
+
+	drv->read_otherend_details = read_backend_details;
+
+	ret = xenbus_register_driver_common(drv, &xenbus_frontend);
+	if (ret)
+		return ret;
+
+	/* If this driver is loaded as a module wait for devices to attach. */
+	wait_for_devices(drv);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xenbus_register_frontend);
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
+int xenbus_probe_node(struct xen_bus_type *bus,
+		      const char *type,
+		      const char *nodename)
+{
+	int err;
+	struct xenbus_device *xendev;
+	size_t stringlen;
+	char *tmpstring;
+
+	enum xenbus_state state = xenbus_read_driver_state(nodename);
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
+	xendev->state = XenbusStateInitialising;
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
+	init_completion(&xendev->down);
+
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
+	nodename = kasprintf(GFP_KERNEL, "%s/%s/%s", xenbus_frontend.root, type, name);
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
+static int xenbus_probe_device_type(struct xen_bus_type *bus, const char *type)
+{
+	int err = 0;
+	char **dir;
+	unsigned int dir_n = 0;
+	int i;
+
+	dir = xenbus_directory(XBT_NIL, bus->root, type, &dir_n);
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
+int xenbus_probe_devices(struct xen_bus_type *bus)
+{
+	int err = 0;
+	char **dir;
+	unsigned int i, dir_n;
+
+	dir = xenbus_directory(XBT_NIL, bus->root, "", &dir_n);
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
+void dev_changed(const char *node, struct xen_bus_type *bus)
+{
+	int exists, rootlen;
+	struct xenbus_device *dev;
+	char type[BUS_ID_SIZE];
+	const char *p, *root;
+
+	if (char_count(node, '/') < 2)
+ 		return;
+
+	exists = xenbus_exists(XBT_NIL, node, "");
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
+	root = kasprintf(GFP_KERNEL, "%.*s", rootlen, node);
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
+/* We watch for devices appearing and vanishing. */
+static struct xenbus_watch fe_watch = {
+	.node = "device",
+	.callback = frontend_changed,
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
+
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
+	xdev->state = XenbusStateInitialising;
+
+	if (drv->resume) {
+		err = drv->resume(xdev);
+		if (err) { 
+			printk(KERN_WARNING
+			       "xenbus: resume %s failed: %i\n", 
+			       dev->bus_id, err);
+			return err;
+		}
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
+	return 0;
+}
+
+void xenbus_suspend(void)
+{
+	DPRINTK("");
+
+	bus_for_each_dev(&xenbus_frontend.bus, NULL, NULL, suspend_dev);
+	xenbus_backend_suspend(suspend_dev);
+	xs_suspend();
+}
+EXPORT_SYMBOL_GPL(xenbus_suspend);
+
+void xenbus_resume(void)
+{
+	xb_init_comms();
+	xs_resume();
+	bus_for_each_dev(&xenbus_frontend.bus, NULL, NULL, resume_dev);
+	xenbus_backend_resume(resume_dev);
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
+void xenbus_probe(struct work_struct *unused)
+{
+	BUG_ON((xenstored_ready <= 0));
+
+	/* Enumerate devices in xenstore and watch for changes. */
+	xenbus_probe_devices(&xenbus_frontend);
+	register_xenbus_watch(&fe_watch);
+	xenbus_backend_probe_and_watch();
+
+	/* Notify others that xenstore is up */
+	blocking_notifier_call_chain(&xenstore_chain, 0, NULL);
+}
+
+static int __init xenbus_probe_init(void)
+{
+	int err = 0;
+
+	DPRINTK("");
+
+	err = -ENODEV;
+	if (!is_running_on_xen())
+		goto out_error;
+
+	/* Register ourselves with the kernel bus subsystem */
+	err = bus_register(&xenbus_frontend.bus);
+	if (err)
+		goto out_error;
+
+	err = xenbus_backend_bus_register();
+	if (err)
+		goto out_unreg_front;
+
+	/*
+	 * Domain0 doesn't have a store_evtchn or store_mfn yet.
+	 */
+	if (is_initial_xendomain()) {
+		/* dom0 not yet supported */
+	} else {
+		xenstored_ready = 1;
+		xen_store_evtchn = xen_start_info->store_evtchn;
+		xen_store_mfn = xen_start_info->store_mfn;
+	}
+	xen_store_interface = mfn_to_virt(xen_store_mfn);
+
+	/* Initialize the interface to xenstore. */
+	err = xs_init();
+	if (err) {
+		printk(KERN_WARNING
+		       "XENBUS: Error initializing xenstore comms: %i\n", err);
+		goto out_unreg_back;
+	}
+
+	if (!is_initial_xendomain())
+		xenbus_probe(NULL);
+
+	return 0;
+
+  out_unreg_back:
+	xenbus_backend_bus_unregister();
+
+  out_unreg_front:
+	bus_unregister(&xenbus_frontend.bus);
+
+  out_error:
+	return err;
+}
+
+postcore_initcall(xenbus_probe_init);
+
+MODULE_LICENSE("Dual BSD/GPL");
+
+static int is_disconnected_device(struct device *dev, void *data)
+{
+	struct xenbus_device *xendev = to_xenbus_device(dev);
+	struct device_driver *drv = data;
+
+	/*
+	 * A device with no driver will never connect. We care only about
+	 * devices which should currently be in the process of connecting.
+	 */
+	if (!dev->driver)
+		return 0;
+
+	/* Is this search limited to a particular driver? */
+	if (drv && (dev->driver != drv))
+		return 0;
+
+	return (xendev->state != XenbusStateConnected);
+}
+
+static int exists_disconnected_device(struct device_driver *drv)
+{
+	return bus_for_each_dev(&xenbus_frontend.bus, NULL, drv,
+				is_disconnected_device);
+}
+
+static int print_device_status(struct device *dev, void *data)
+{
+	struct xenbus_device *xendev = to_xenbus_device(dev);
+	struct device_driver *drv = data;
+
+	/* Is this operation limited to a particular driver? */
+	if (drv && (dev->driver != drv))
+		return 0;
+
+	if (!dev->driver) {
+		/* Information only: is this too noisy? */
+		printk(KERN_INFO "XENBUS: Device with no driver: %s\n",
+		       xendev->nodename);
+	} else if (xendev->state != XenbusStateConnected) {
+		printk(KERN_WARNING "XENBUS: Timeout connecting "
+		       "to device: %s (state %d)\n",
+		       xendev->nodename, xendev->state);
+	}
+
+	return 0;
+}
+
+/* We only wait for device setup after most initcalls have run. */
+static int ready_to_wait_for_devices;
+
+/*
+ * On a 10 second timeout, wait for all devices currently configured.  We need
+ * to do this to guarantee that the filesystems and / or network devices
+ * needed for boot are available, before we can allow the boot to proceed.
+ *
+ * This needs to be on a late_initcall, to happen after the frontend device
+ * drivers have been initialised, but before the root fs is mounted.
+ *
+ * A possible improvement here would be to have the tools add a per-device
+ * flag to the store entry, indicating whether it is needed at boot time.
+ * This would allow people who knew what they were doing to accelerate their
+ * boot slightly, but of course needs tools or manual intervention to set up
+ * those flags correctly.
+ */
+static void wait_for_devices(struct xenbus_driver *xendrv)
+{
+	unsigned long timeout = jiffies + 10*HZ;
+	struct device_driver *drv = xendrv ? &xendrv->driver : NULL;
+
+	if (!ready_to_wait_for_devices || !is_running_on_xen())
+		return;
+
+	while (exists_disconnected_device(drv)) {
+		if (time_after(jiffies, timeout))
+			break;
+		schedule_timeout_interruptible(HZ/10);
+	}
+
+	bus_for_each_dev(&xenbus_frontend.bus, NULL, drv,
+			 print_device_status);
+}
+
+#ifndef MODULE
+static int __init boot_wait_for_devices(void)
+{
+	ready_to_wait_for_devices = 1;
+	wait_for_devices(NULL);
+	return 0;
+}
+
+late_initcall(boot_wait_for_devices);
+#endif
===================================================================
--- /dev/null
+++ b/drivers/xen/xenbus/xenbus_probe.h
@@ -0,0 +1,72 @@
+/******************************************************************************
+ * xenbus_probe.h
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
+#ifndef _XENBUS_PROBE_H
+#define _XENBUS_PROBE_H
+
+#ifdef CONFIG_XEN_BACKEND
+extern void xenbus_backend_suspend(int (*fn)(struct device *, void *));
+extern void xenbus_backend_resume(int (*fn)(struct device *, void *));
+extern void xenbus_backend_probe_and_watch(void);
+extern int xenbus_backend_bus_register(void);
+extern void xenbus_backend_bus_unregister(void);
+#else
+static inline void xenbus_backend_suspend(int (*fn)(struct device *, void *)) {}
+static inline void xenbus_backend_resume(int (*fn)(struct device *, void *)) {}
+static inline void xenbus_backend_probe_and_watch(void) {}
+static inline int xenbus_backend_bus_register(void) {return 0;}
+static inline void xenbus_backend_bus_unregister(void) {}
+#endif
+
+struct xen_bus_type
+{
+	char *root;
+	unsigned int levels;
+	int (*get_bus_id)(char bus_id[BUS_ID_SIZE], const char *nodename);
+	int (*probe)(const char *type, const char *dir);
+	struct bus_type bus;
+};
+
+extern int xenbus_match(struct device *_dev, struct device_driver *_drv);
+extern int xenbus_dev_probe(struct device *_dev);
+extern int xenbus_dev_remove(struct device *_dev);
+extern int xenbus_register_driver_common(struct xenbus_driver *drv,
+					 struct xen_bus_type *bus);
+extern int xenbus_probe_node(struct xen_bus_type *bus,
+			     const char *type,
+			     const char *nodename);
+extern int xenbus_probe_devices(struct xen_bus_type *bus);
+
+extern void dev_changed(const char *node, struct xen_bus_type *bus);
+
+#endif
===================================================================
--- /dev/null
+++ b/drivers/xen/xenbus/xenbus_probe_backend.c
@@ -0,0 +1,269 @@
+/******************************************************************************
+ * Talks to Xen Store to figure out what devices we have (backend half).
+ *
+ * Copyright (C) 2005 Rusty Russell, IBM Corporation
+ * Copyright (C) 2005 Mike Wray, Hewlett-Packard
+ * Copyright (C) 2005, 2006 XenSource Ltd
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
+#define DPRINTK(fmt, args...)				\
+	pr_debug("xenbus_probe (%s:%d) " fmt ".\n",	\
+		 __FUNCTION__, __LINE__, ##args)
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
+//#include <asm/maddr.h>
+#include <asm/pgtable.h>
+#include <asm/hypervisor.h>
+#include <xen/xenbus.h>
+//#include <xen/xen_proc.h>
+//#include <xen/evtchn.h>
+#include <xen/features.h>
+//#include <xen/hvm.h>
+
+#include "xenbus_comms.h"
+#include "xenbus_probe.h"
+
+#ifdef HAVE_XEN_PLATFORM_COMPAT_H
+#include <xen/platform-compat.h>
+#endif
+
+static int xenbus_uevent_backend(struct device *dev, char **envp,
+				 int num_envp, char *buffer, int buffer_size);
+static int xenbus_probe_backend(const char *type, const char *domid);
+
+extern int read_otherend_details(struct xenbus_device *xendev,
+				 char *id_node, char *path_node);
+
+static int read_frontend_details(struct xenbus_device *xendev)
+{
+	return read_otherend_details(xendev, "frontend-id", "frontend");
+}
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
+	err = xenbus_gather(XBT_NIL, nodename, "frontend-id", "%i", &domid,
+			    "frontend", NULL, &frontend,
+			    NULL);
+	if (err)
+		return err;
+	if (strlen(frontend) == 0)
+		err = -ERANGE;
+	if (!err && !xenbus_exists(XBT_NIL, frontend, ""))
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
+static struct xen_bus_type xenbus_backend = {
+	.root = "backend",
+	.levels = 3, 		/* backend/type/<frontend>/<id> */
+	.get_bus_id = backend_bus_id,
+	.probe = xenbus_probe_backend,
+	.bus = {
+		.name     = "xen-backend",
+		.match    = xenbus_match,
+		.probe    = xenbus_dev_probe,
+		.remove   = xenbus_dev_remove,
+//		.shutdown = xenbus_dev_shutdown,
+		.uevent   = xenbus_uevent_backend,
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
+int xenbus_register_backend(struct xenbus_driver *drv)
+{
+	drv->read_otherend_details = read_frontend_details;
+
+	return xenbus_register_driver_common(drv, &xenbus_backend);
+}
+EXPORT_SYMBOL_GPL(xenbus_register_backend);
+
+/* backend/<typename>/<frontend-uuid>/<name> */
+static int xenbus_probe_backend_unit(const char *dir,
+				     const char *type,
+				     const char *name)
+{
+	char *nodename;
+	int err;
+
+	nodename = kasprintf(GFP_KERNEL, "%s/%s", dir, name);
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
+	nodename = kasprintf(GFP_KERNEL, "%s/%s/%s", xenbus_backend.root, type, domid);
+	if (!nodename)
+		return -ENOMEM;
+
+	dir = xenbus_directory(XBT_NIL, nodename, "", &dir_n);
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
+static void backend_changed(struct xenbus_watch *watch,
+			    const char **vec, unsigned int len)
+{
+	DPRINTK("");
+
+	dev_changed(vec[XS_WATCH_PATH], &xenbus_backend);
+}
+
+static struct xenbus_watch be_watch = {
+	.node = "backend",
+	.callback = backend_changed,
+};
+
+void xenbus_backend_suspend(int (*fn)(struct device *, void *))
+{
+	DPRINTK("");
+	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL, fn);
+}
+
+void xenbus_backend_resume(int (*fn)(struct device *, void *))
+{
+	DPRINTK("");
+	bus_for_each_dev(&xenbus_backend.bus, NULL, NULL, fn);
+}
+
+void xenbus_backend_probe_and_watch(void)
+{
+	xenbus_probe_devices(&xenbus_backend);
+	register_xenbus_watch(&be_watch);
+}
+
+int xenbus_backend_bus_register(void)
+{
+	return bus_register(&xenbus_backend.bus);
+}
+
+void xenbus_backend_bus_unregister(void)
+{
+	bus_unregister(&xenbus_backend.bus);
+}
===================================================================
--- /dev/null
+++ b/drivers/xen/xenbus/xenbus_xs.c
@@ -0,0 +1,840 @@
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
+#include <linux/module.h>
+#include <linux/mutex.h>
+#include <xen/xenbus.h>
+#include "xenbus_comms.h"
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
+static DEFINE_MUTEX(xenwatch_mutex);
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
+static void *xs_talkv(struct xenbus_transaction t,
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
+	msg.tx_id = t.id;
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
+static void *xs_single(struct xenbus_transaction t,
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
+		buffer = kasprintf(GFP_KERNEL, "%s", dir);
+	else
+		buffer = kasprintf(GFP_KERNEL, "%s/%s", dir, name);
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
+char **xenbus_directory(struct xenbus_transaction t,
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
+int xenbus_exists(struct xenbus_transaction t,
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
+void *xenbus_read(struct xenbus_transaction t,
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
+int xenbus_write(struct xenbus_transaction t,
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
+int xenbus_mkdir(struct xenbus_transaction t,
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
+int xenbus_rm(struct xenbus_transaction t, const char *dir, const char *node)
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
+int xenbus_transaction_start(struct xenbus_transaction *t)
+{
+	char *id_str;
+
+	down_read(&xs_state.suspend_mutex);
+
+	id_str = xs_single(XBT_NIL, XS_TRANSACTION_START, "", NULL);
+	if (IS_ERR(id_str)) {
+		up_read(&xs_state.suspend_mutex);
+		return PTR_ERR(id_str);
+	}
+
+	t->id = simple_strtoul(id_str, NULL, 0);
+	kfree(id_str);
+	return 0;
+}
+EXPORT_SYMBOL_GPL(xenbus_transaction_start);
+
+/* End a transaction.
+ * If abandon is true, transaction is discarded instead of committed.
+ */
+int xenbus_transaction_end(struct xenbus_transaction t, int abort)
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
+int xenbus_scanf(struct xenbus_transaction t,
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
+int xenbus_printf(struct xenbus_transaction t,
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
+int xenbus_gather(struct xenbus_transaction t, const char *dir, ...)
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
+	return xs_error(xs_talkv(XBT_NIL, XS_WATCH, iov,
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
+	return xs_error(xs_talkv(XBT_NIL, XS_UNWATCH, iov,
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
+	/* Make sure there are no callbacks running currently (unless
+	   its us) */
+	if (current->pid != xenwatch_pid)
+		mutex_lock(&xenwatch_mutex);
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
+	if (current->pid != xenwatch_pid)
+		mutex_unlock(&xenwatch_mutex);
+}
+EXPORT_SYMBOL_GPL(unregister_xenbus_watch);
+
+void xs_suspend(void)
+{
+	struct xenbus_watch *watch;
+	char token[sizeof(watch) * 2 + 1];
+
+	down_write(&xs_state.suspend_mutex);
+
+	/* No need for watches_lock: the suspend_mutex is sufficient. */
+	list_for_each_entry(watch, &watches, list) {
+		sprintf(token, "%lX", (long)watch);
+		xs_unwatch(watch->node, token);
+	}
+
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
===================================================================
--- /dev/null
+++ b/include/xen/xenbus.h
@@ -0,0 +1,208 @@
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
+#include <linux/completion.h>
+#include <linux/init.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/grant_table.h>
+#include <xen/interface/io/xenbus.h>
+#include <xen/interface/io/xs_wire.h>
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
+	enum xenbus_state state;
+	struct completion down;
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
+				 enum xenbus_state backend_state);
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
+struct xenbus_transaction
+{
+	u32 id;
+};
+
+/* Nil transaction ID. */
+#define XBT_NIL ((struct xenbus_transaction) { 0 })
+
+int __init xenbus_dev_init(void);
+
+char **xenbus_directory(struct xenbus_transaction t,
+			const char *dir, const char *node, unsigned int *num);
+void *xenbus_read(struct xenbus_transaction t,
+		  const char *dir, const char *node, unsigned int *len);
+int xenbus_write(struct xenbus_transaction t,
+		 const char *dir, const char *node, const char *string);
+int xenbus_mkdir(struct xenbus_transaction t,
+		 const char *dir, const char *node);
+int xenbus_exists(struct xenbus_transaction t,
+		  const char *dir, const char *node);
+int xenbus_rm(struct xenbus_transaction t, const char *dir, const char *node);
+int xenbus_transaction_start(struct xenbus_transaction *t);
+int xenbus_transaction_end(struct xenbus_transaction t, int abort);
+
+/* Single read and scanf: returns -errno or num scanned if > 0. */
+int xenbus_scanf(struct xenbus_transaction t,
+		 const char *dir, const char *node, const char *fmt, ...)
+	__attribute__((format(scanf, 4, 5)));
+
+/* Single printf and write: returns -errno or 0. */
+int xenbus_printf(struct xenbus_transaction t,
+		  const char *dir, const char *node, const char *fmt, ...)
+	__attribute__((format(printf, 4, 5)));
+
+/* Generic read function: NULL-terminated triples of name,
+ * sprintf-style type string, and pointer. Returns 0 or errno.*/
+int xenbus_gather(struct xenbus_transaction t, const char *dir, ...);
+
+/* notifer routines for when the xenstore comes up */
+extern int xenstored_ready;
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
+void xenbus_probe(struct work_struct *);
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
+int xenbus_watch_path(struct xenbus_device *dev, const char *path,
+		      struct xenbus_watch *watch,
+		      void (*callback)(struct xenbus_watch *,
+				       const char **, unsigned int));
+int xenbus_watch_path2(struct xenbus_device *dev, const char *path,
+		       const char *path2, struct xenbus_watch *watch,
+		       void (*callback)(struct xenbus_watch *,
+					const char **, unsigned int));
+int xenbus_switch_state(struct xenbus_device *dev, enum xenbus_state new_state);
+int xenbus_grant_ring(struct xenbus_device *dev, unsigned long ring_mfn);
+int xenbus_map_ring_valloc(struct xenbus_device *dev,
+			   int gnt_ref, void **vaddr);
+int xenbus_map_ring(struct xenbus_device *dev, int gnt_ref,
+			   grant_handle_t *handle, void *vaddr);
+
+int xenbus_unmap_ring_vfree(struct xenbus_device *dev, void *vaddr);
+int xenbus_unmap_ring(struct xenbus_device *dev,
+		      grant_handle_t handle, void *vaddr);
+
+int xenbus_alloc_evtchn(struct xenbus_device *dev, int *port);
+int xenbus_bind_evtchn(struct xenbus_device *dev, int remote_port, int *port);
+int xenbus_free_evtchn(struct xenbus_device *dev, int port);
+
+enum xenbus_state xenbus_read_driver_state(const char *path);
+
+void xenbus_dev_error(struct xenbus_device *dev, int err, const char *fmt, ...);
+void xenbus_dev_fatal(struct xenbus_device *dev, int err, const char *fmt, ...);
+
+char *xenbus_strstate(enum xenbus_state state);
+int xenbus_dev_is_online(struct xenbus_device *dev);
+int xenbus_frontend_closed(struct xenbus_device *dev);
+
+#endif /* _XEN_XENBUS_H */

-- 

