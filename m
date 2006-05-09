Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWEIItq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWEIItq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 04:49:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751546AbWEIItf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 04:49:35 -0400
Received: from 216-99-217-87.dsl.aracnet.com ([216.99.217.87]:53379 "EHLO
	sous-sol.org") by vger.kernel.org with ESMTP id S1751579AbWEIItF
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 04:49:05 -0400
Message-Id: <20060509085201.799981000@sous-sol.org>
References: <20060509084945.373541000@sous-sol.org>
Date: Tue, 09 May 2006 00:00:35 -0700
From: Chris Wright <chrisw@sous-sol.org>
To: linux-kernel@vger.kernel.org
Cc: virtualization@lists.osdl.org, xen-devel@lists.xensource.com,
       Ian Pratt <ian.pratt@xensource.com>,
       Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Subject: [RFC PATCH 35/35] Add Xen virtual block device driver.
Content-Disposition: inline; filename=blkfront
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The block device frontend driver allows the kernel to access block
devices exported exported by a virtual machine containing a physical
block device driver.

Signed-off-by: Ian Pratt <ian.pratt@xensource.com>
Signed-off-by: Christian Limpach <Christian.Limpach@cl.cam.ac.uk>
Signed-off-by: Chris Wright <chrisw@sous-sol.org>
---
 drivers/block/Kconfig           |    2 
 drivers/xen/Kconfig.blk         |   14 
 drivers/xen/Makefile            |    1 
 drivers/xen/blkfront/Makefile   |    5 
 drivers/xen/blkfront/blkfront.c |  813 ++++++++++++++++++++++++++++++++++++++++
 drivers/xen/blkfront/block.h    |  156 +++++++
 drivers/xen/blkfront/vbd.c      |  216 ++++++++++
 7 files changed, 1207 insertions(+)

--- linus-2.6.orig/drivers/block/Kconfig
+++ linus-2.6/drivers/block/Kconfig
@@ -449,6 +449,8 @@ config CDROM_PKTCDVD_WCACHE
 
 source "drivers/s390/block/Kconfig"
 
+source "drivers/xen/Kconfig.blk"
+
 config ATA_OVER_ETH
 	tristate "ATA over Ethernet support"
 	depends on NET
--- linus-2.6.orig/drivers/xen/Makefile
+++ linus-2.6/drivers/xen/Makefile
@@ -6,5 +6,6 @@ obj-y	+= core/
 obj-y	+= console/
 obj-y	+= xenbus/
 
+obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	+= blkfront/
 obj-$(CONFIG_XEN_NETDEV_FRONTEND)	+= netfront/
 
--- /dev/null
+++ linus-2.6/drivers/xen/Kconfig.blk
@@ -0,0 +1,14 @@
+menu "Xen block device drivers"
+        depends on XEN
+
+config XEN_BLKDEV_FRONTEND
+	tristate "Block device frontend driver"
+	depends on XEN
+	default y
+	help
+	  The block device frontend driver allows the kernel to access block
+	  devices exported from a device driver virtual machine. Unless you
+	  are building a dedicated device driver virtual machine, then you
+	  almost certainly want to say Y here.
+
+endmenu
--- /dev/null
+++ linus-2.6/drivers/xen/blkfront/Makefile
@@ -0,0 +1,5 @@
+
+obj-$(CONFIG_XEN_BLKDEV_FRONTEND)	:= xenblk.o
+
+xenblk-objs := blkfront.o vbd.o
+
--- /dev/null
+++ linus-2.6/drivers/xen/blkfront/blkfront.c
@@ -0,0 +1,813 @@
+/******************************************************************************
+ * blkfront.c
+ * 
+ * XenLinux virtual block device driver.
+ * 
+ * Copyright (c) 2003-2004, Keir Fraser & Steve Hand
+ * Modifications by Mark A. Williamson are (c) Intel Research Cambridge
+ * Copyright (c) 2004, Christian Limpach
+ * Copyright (c) 2004, Andrew Warfield
+ * Copyright (c) 2005, Christopher Clark
+ * Copyright (c) 2005, XenSource Ltd
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
+#include <linux/version.h>
+#include "block.h"
+#include <linux/cdrom.h>
+#include <linux/sched.h>
+#include <linux/interrupt.h>
+#include <scsi/scsi.h>
+#include <xen/evtchn.h>
+#include <xen/xenbus.h>
+#include <xen/interface/grant_table.h>
+#include <xen/gnttab.h>
+#include <asm/hypervisor.h>
+
+#define BLKIF_STATE_DISCONNECTED 0
+#define BLKIF_STATE_CONNECTED    1
+#define BLKIF_STATE_SUSPENDED    2
+
+#define MAXIMUM_OUTSTANDING_BLOCK_REQS \
+    (BLKIF_MAX_SEGMENTS_PER_REQUEST * BLK_RING_SIZE)
+#define GRANT_INVALID_REF	0
+
+static void connect(struct blkfront_info *);
+static void blkfront_closing(struct xenbus_device *);
+static int blkfront_remove(struct xenbus_device *);
+static int talk_to_backend(struct xenbus_device *, struct blkfront_info *);
+static int setup_blkring(struct xenbus_device *, struct blkfront_info *);
+
+static void kick_pending_request_queues(struct blkfront_info *);
+
+static irqreturn_t blkif_int(int irq, void *dev_id, struct pt_regs *ptregs);
+static void blkif_restart_queue(void *arg);
+static void blkif_recover(struct blkfront_info *);
+static void blkif_completion(struct blk_shadow *);
+static void blkif_free(struct blkfront_info *, int);
+
+
+/**
+ * Entry point to this code when a new device is created.  Allocate the basic
+ * structures and the ring buffer for communication with the backend, and
+ * inform the backend of the appropriate details for those.  Switch to
+ * Initialised state.
+ */
+static int blkfront_probe(struct xenbus_device *dev,
+			  const struct xenbus_device_id *id)
+{
+	int err, vdevice, i;
+	struct blkfront_info *info;
+
+	/* FIXME: Use dynamic device id if this is not set. */
+	err = xenbus_scanf(XBT_NULL, dev->nodename,
+			   "virtual-device", "%i", &vdevice);
+	if (err != 1) {
+		xenbus_dev_fatal(dev, err, "reading virtual-device");
+		return err;
+	}
+
+	info = kzalloc(sizeof(*info), GFP_KERNEL);
+	if (!info) {
+		xenbus_dev_fatal(dev, -ENOMEM, "allocating info structure");
+		return -ENOMEM;
+	}
+
+	info->xbdev = dev;
+	info->vdevice = vdevice;
+	info->connected = BLKIF_STATE_DISCONNECTED;
+	INIT_WORK(&info->work, blkif_restart_queue, (void *)info);
+
+	for (i = 0; i < BLK_RING_SIZE; i++)
+		info->shadow[i].req.id = i+1;
+	info->shadow[BLK_RING_SIZE-1].req.id = 0x0fffffff;
+
+	/* Front end dir is a number, which is used as the id. */
+	info->handle = simple_strtoul(strrchr(dev->nodename,'/')+1, NULL, 0);
+	dev->data = info;
+
+	err = talk_to_backend(dev, info);
+	if (err) {
+		kfree(info);
+		dev->data = NULL;
+		return err;
+	}
+
+	return 0;
+}
+
+
+/**
+ * We are reconnecting to the backend, due to a suspend/resume, or a backend
+ * driver restart.  We tear down our blkif structure and recreate it, but
+ * leave the device-layer structures intact so that this is transparent to the
+ * rest of the kernel.
+ */
+static int blkfront_resume(struct xenbus_device *dev)
+{
+	struct blkfront_info *info = dev->data;
+	int err;
+
+	DPRINTK("blkfront_resume: %s\n", dev->nodename);
+
+	blkif_free(info, 1);
+
+	err = talk_to_backend(dev, info);
+	if (!err)
+		blkif_recover(info);
+
+	return err;
+}
+
+
+/* Common code used when first setting up, and when resuming. */
+static int talk_to_backend(struct xenbus_device *dev,
+			   struct blkfront_info *info)
+{
+	const char *message = NULL;
+	xenbus_transaction_t xbt;
+	int err;
+
+	/* Create shared ring, alloc event channel. */
+	err = setup_blkring(dev, info);
+	if (err)
+		goto out;
+
+again:
+	err = xenbus_transaction_start(&xbt);
+	if (err) {
+		xenbus_dev_fatal(dev, err, "starting transaction");
+		goto destroy_blkring;
+	}
+
+	err = xenbus_printf(xbt, dev->nodename,
+			    "ring-ref","%u", info->ring_ref);
+	if (err) {
+		message = "writing ring-ref";
+		goto abort_transaction;
+	}
+	err = xenbus_printf(xbt, dev->nodename,
+			    "event-channel", "%u", info->evtchn);
+	if (err) {
+		message = "writing event-channel";
+		goto abort_transaction;
+	}
+
+	err = xenbus_switch_state(dev, xbt, XenbusStateInitialised);
+	if (err)
+		goto abort_transaction;
+
+	err = xenbus_transaction_end(xbt, 0);
+	if (err) {
+		if (err == -EAGAIN)
+			goto again;
+		xenbus_dev_fatal(dev, err, "completing transaction");
+		goto destroy_blkring;
+	}
+
+	return 0;
+
+ abort_transaction:
+	xenbus_transaction_end(xbt, 1);
+	if (message)
+		xenbus_dev_fatal(dev, err, "%s", message);
+ destroy_blkring:
+	blkif_free(info, 0);
+ out:
+	return err;
+}
+
+
+static int setup_blkring(struct xenbus_device *dev,
+			 struct blkfront_info *info)
+{
+	struct blkif_sring *sring;
+	int err;
+
+	info->ring_ref = GRANT_INVALID_REF;
+
+	sring = (struct blkif_sring *)__get_free_page(GFP_KERNEL);
+	if (!sring) {
+		xenbus_dev_fatal(dev, -ENOMEM, "allocating shared ring");
+		return -ENOMEM;
+	}
+	SHARED_RING_INIT(sring);
+	FRONT_RING_INIT(&info->ring, sring, PAGE_SIZE);
+
+	err = xenbus_grant_ring(dev, virt_to_mfn(info->ring.sring));
+	if (err < 0) {
+		free_page((unsigned long)sring);
+		info->ring.sring = NULL;
+		goto fail;
+	}
+	info->ring_ref = err;
+
+	err = xenbus_alloc_evtchn(dev, &info->evtchn);
+	if (err)
+		goto fail;
+
+	err = bind_evtchn_to_irqhandler(
+		info->evtchn, blkif_int, SA_SAMPLE_RANDOM, "blkif", info);
+	if (err <= 0) {
+		xenbus_dev_fatal(dev, err,
+				 "bind_evtchn_to_irqhandler failed");
+		goto fail;
+	}
+	info->irq = err;
+
+	return 0;
+fail:
+	blkif_free(info, 0);
+	return err;
+}
+
+
+/**
+ * Callback received when the backend's state changes.
+ */
+static void backend_changed(struct xenbus_device *dev,
+			    XenbusState backend_state)
+{
+	struct blkfront_info *info = dev->data;
+	struct block_device *bd;
+
+	DPRINTK("blkfront:backend_changed.\n");
+
+	switch (backend_state) {
+	case XenbusStateUnknown:
+	case XenbusStateInitialising:
+	case XenbusStateInitWait:
+	case XenbusStateInitialised:
+	case XenbusStateClosed:
+		break;
+
+	case XenbusStateConnected:
+		connect(info);
+		break;
+
+	case XenbusStateClosing:
+		bd = bdget(info->dev);
+		if (bd == NULL)
+			xenbus_dev_fatal(dev, -ENODEV, "bdget failed");
+
+		mutex_lock(&bd->bd_mutex);
+		if (info->users > 0)
+			xenbus_dev_error(dev, -EBUSY,
+					 "Device in use; refusing to close");
+		else
+			blkfront_closing(dev);
+		mutex_unlock(&bd->bd_mutex);
+		bdput(bd);
+		break;
+	}
+}
+
+
+/* ** Connection ** */
+
+
+/*
+ * Invoked when the backend is finally 'ready' (and has told produced
+ * the details about the physical device - #sectors, size, etc).
+ */
+static void connect(struct blkfront_info *info)
+{
+	unsigned long sectors, sector_size;
+	unsigned int binfo;
+	int err;
+
+	if ((info->connected == BLKIF_STATE_CONNECTED) ||
+	    (info->connected == BLKIF_STATE_SUSPENDED) )
+		return;
+
+	DPRINTK("blkfront.c:connect:%s.\n", info->xbdev->otherend);
+
+	err = xenbus_gather(XBT_NULL, info->xbdev->otherend,
+			    "sectors", "%lu", &sectors,
+			    "info", "%u", &binfo,
+			    "sector-size", "%lu", &sector_size,
+			    NULL);
+	if (err) {
+		xenbus_dev_fatal(info->xbdev, err,
+				 "reading backend fields at %s",
+				 info->xbdev->otherend);
+		return;
+	}
+
+	err = xlvbd_add(sectors, info->vdevice, binfo, sector_size, info);
+	if (err) {
+		xenbus_dev_fatal(info->xbdev, err, "xlvbd_add at %s",
+		                 info->xbdev->otherend);
+		return;
+	}
+
+	(void)xenbus_switch_state(info->xbdev, XBT_NULL, XenbusStateConnected);
+
+	/* Kick pending requests. */
+	spin_lock_irq(&blkif_io_lock);
+	info->connected = BLKIF_STATE_CONNECTED;
+	kick_pending_request_queues(info);
+	spin_unlock_irq(&blkif_io_lock);
+
+	add_disk(info->gd);
+}
+
+/**
+ * Handle the change of state of the backend to Closing.  We must delete our
+ * device-layer structures now, to ensure that writes are flushed through to
+ * the backend.  Once is this done, we can switch to Closed in
+ * acknowledgement.
+ */
+static void blkfront_closing(struct xenbus_device *dev)
+{
+	struct blkfront_info *info = dev->data;
+
+	DPRINTK("blkfront_closing: %s removed\n", dev->nodename);
+
+	xlvbd_del(info);
+
+	xenbus_switch_state(dev, XBT_NULL, XenbusStateClosed);
+}
+
+
+static int blkfront_remove(struct xenbus_device *dev)
+{
+	struct blkfront_info *info = dev->data;
+
+	DPRINTK("blkfront_remove: %s removed\n", dev->nodename);
+
+	blkif_free(info, 0);
+
+	kfree(info);
+
+	return 0;
+}
+
+
+static inline int GET_ID_FROM_FREELIST(
+	struct blkfront_info *info)
+{
+	unsigned long free = info->shadow_free;
+	BUG_ON(free > BLK_RING_SIZE);
+	info->shadow_free = info->shadow[free].req.id;
+	info->shadow[free].req.id = 0x0fffffee; /* debug */
+	return free;
+}
+
+static inline void ADD_ID_TO_FREELIST(
+	struct blkfront_info *info, unsigned long id)
+{
+	info->shadow[id].req.id  = info->shadow_free;
+	info->shadow[id].request = 0;
+	info->shadow_free = id;
+}
+
+static inline void flush_requests(struct blkfront_info *info)
+{
+	int notify;
+
+	RING_PUSH_REQUESTS_AND_CHECK_NOTIFY(&info->ring, notify);
+
+	if (notify)
+		notify_remote_via_irq(info->irq);
+}
+
+static void kick_pending_request_queues(struct blkfront_info *info)
+{
+	if (!RING_FULL(&info->ring)) {
+		/* Re-enable calldowns. */
+		blk_start_queue(info->rq);
+		/* Kick things off immediately. */
+		do_blkif_request(info->rq);
+	}
+}
+
+static void blkif_restart_queue(void *arg)
+{
+	struct blkfront_info *info = (struct blkfront_info *)arg;
+	spin_lock_irq(&blkif_io_lock);
+	kick_pending_request_queues(info);
+	spin_unlock_irq(&blkif_io_lock);
+}
+
+static void blkif_restart_queue_callback(void *arg)
+{
+	struct blkfront_info *info = (struct blkfront_info *)arg;
+	schedule_work(&info->work);
+}
+
+int blkif_open(struct inode *inode, struct file *filep)
+{
+	struct blkfront_info *info = inode->i_bdev->bd_disk->private_data;
+	info->users++;
+	return 0;
+}
+
+
+int blkif_release(struct inode *inode, struct file *filep)
+{
+	struct blkfront_info *info = inode->i_bdev->bd_disk->private_data;
+	info->users--;
+	if (info->users == 0) {
+		/* Check whether we have been instructed to close.  We will
+		   have ignored this request initially, as the device was
+		   still mounted. */
+		struct xenbus_device * dev = info->xbdev;
+		XenbusState state = xenbus_read_driver_state(dev->otherend);
+
+		if (state == XenbusStateClosing)
+			blkfront_closing(dev);
+	}
+	return 0;
+}
+
+
+int blkif_ioctl(struct inode *inode, struct file *filep,
+                unsigned command, unsigned long argument)
+{
+	int i;
+
+	DPRINTK_IOCTL("command: 0x%x, argument: 0x%lx, dev: 0x%04x\n",
+		      command, (long)argument, inode->i_rdev);
+
+	switch (command) {
+	case HDIO_GETGEO:
+		/* return ENOSYS to use defaults */
+		return -ENOSYS;
+
+	case CDROMMULTISESSION:
+		DPRINTK("FIXME: support multisession CDs later\n");
+		for (i = 0; i < sizeof(struct cdrom_multisession); i++)
+			if (put_user(0, (char __user *)(argument + i)))
+				return -EFAULT;
+		return 0;
+
+	default:
+		/*printk(KERN_ALERT "ioctl %08x not supported by Xen blkdev\n",
+		  command);*/
+		return -EINVAL; /* same return as native Linux */
+	}
+
+	return 0;
+}
+
+/*
+ * blkif_queue_request
+ *
+ * request block io
+ *
+ * id: for guest use only.
+ * operation: BLKIF_OP_{READ,WRITE,PROBE}
+ * buffer: buffer to read/write into. this should be a
+ *   virtual address in the guest os.
+ */
+static int blkif_queue_request(struct request *req)
+{
+	struct blkfront_info *info = req->rq_disk->private_data;
+	unsigned long buffer_mfn;
+	struct blkif_request *ring_req;
+	struct bio *bio;
+	struct bio_vec *bvec;
+	int idx;
+	unsigned long id;
+	unsigned int fsect, lsect;
+	int ref;
+	grant_ref_t gref_head;
+
+	if (unlikely(info->connected != BLKIF_STATE_CONNECTED))
+		return 1;
+
+	if (gnttab_alloc_grant_references(
+		BLKIF_MAX_SEGMENTS_PER_REQUEST, &gref_head) < 0) {
+		gnttab_request_free_callback(
+			&info->callback,
+			blkif_restart_queue_callback,
+			info,
+			BLKIF_MAX_SEGMENTS_PER_REQUEST);
+		return 1;
+	}
+
+	/* Fill out a communications ring structure. */
+	ring_req = RING_GET_REQUEST(&info->ring, info->ring.req_prod_pvt);
+	id = GET_ID_FROM_FREELIST(info);
+	info->shadow[id].request = (unsigned long)req;
+
+	ring_req->id = id;
+	ring_req->operation = rq_data_dir(req) ?
+		BLKIF_OP_WRITE : BLKIF_OP_READ;
+	ring_req->sector_number = (blkif_sector_t)req->sector;
+	ring_req->handle = info->handle;
+
+	ring_req->nr_segments = 0;
+	rq_for_each_bio (bio, req) {
+		bio_for_each_segment (bvec, bio, idx) {
+			BUG_ON(ring_req->nr_segments
+			       == BLKIF_MAX_SEGMENTS_PER_REQUEST);
+			buffer_mfn = page_to_phys(bvec->bv_page) >> PAGE_SHIFT;
+			fsect = bvec->bv_offset >> 9;
+			lsect = fsect + (bvec->bv_len >> 9) - 1;
+			/* install a grant reference. */
+			ref = gnttab_claim_grant_reference(&gref_head);
+			BUG_ON(ref == -ENOSPC);
+
+			gnttab_grant_foreign_access_ref(
+				ref,
+				info->xbdev->otherend_id,
+				buffer_mfn,
+				rq_data_dir(req) );
+
+			info->shadow[id].frame[ring_req->nr_segments] =
+				mfn_to_pfn(buffer_mfn);
+
+			ring_req->seg[ring_req->nr_segments] =
+				(struct blkif_request_segment) {
+					.gref       = ref,
+					.first_sect = fsect,
+					.last_sect  = lsect };
+
+			ring_req->nr_segments++;
+		}
+	}
+
+	info->ring.req_prod_pvt++;
+
+	/* Keep a private copy so we can reissue requests when recovering. */
+	info->shadow[id].req = *ring_req;
+
+	gnttab_free_grant_references(gref_head);
+
+	return 0;
+}
+
+/*
+ * do_blkif_request
+ *  read a block; request is in a request queue
+ */
+void do_blkif_request(request_queue_t *rq)
+{
+	struct blkfront_info *info = NULL;
+	struct request *req;
+	int queued;
+
+	DPRINTK("Entered do_blkif_request\n");
+
+	queued = 0;
+
+	while ((req = elv_next_request(rq)) != NULL) {
+		info = req->rq_disk->private_data;
+		if (!blk_fs_request(req)) {
+			end_request(req, 0);
+			continue;
+		}
+
+		if (RING_FULL(&info->ring))
+			goto wait;
+
+		DPRINTK("do_blk_req %p: cmd %p, sec %lx, "
+			"(%u/%li) buffer:%p [%s]\n",
+			req, req->cmd, req->sector, req->current_nr_sectors,
+			req->nr_sectors, req->buffer,
+			rq_data_dir(req) ? "write" : "read");
+
+
+		blkdev_dequeue_request(req);
+		if (blkif_queue_request(req)) {
+			blk_requeue_request(rq, req);
+		wait:
+			/* Avoid pointless unplugs. */
+			blk_stop_queue(rq);
+			break;
+		}
+
+		queued++;
+	}
+
+	if (queued != 0)
+		flush_requests(info);
+}
+
+
+static irqreturn_t blkif_int(int irq, void *dev_id, struct pt_regs *ptregs)
+{
+	struct request *req;
+	struct blkif_response *bret;
+	RING_IDX i, rp;
+	unsigned long flags;
+	struct blkfront_info *info = (struct blkfront_info *)dev_id;
+
+	spin_lock_irqsave(&blkif_io_lock, flags);
+
+	if (unlikely(info->connected != BLKIF_STATE_CONNECTED)) {
+		spin_unlock_irqrestore(&blkif_io_lock, flags);
+		return IRQ_HANDLED;
+	}
+
+ again:
+	rp = info->ring.sring->rsp_prod;
+	rmb(); /* Ensure we see queued responses up to 'rp'. */
+
+	for (i = info->ring.rsp_cons; i != rp; i++) {
+		unsigned long id;
+		int ret;
+
+		bret = RING_GET_RESPONSE(&info->ring, i);
+		id   = bret->id;
+		req  = (struct request *)info->shadow[id].request;
+
+		blkif_completion(&info->shadow[id]);
+
+		ADD_ID_TO_FREELIST(info, id);
+
+		switch (bret->operation) {
+		case BLKIF_OP_READ:
+		case BLKIF_OP_WRITE:
+			if (unlikely(bret->status != BLKIF_RSP_OKAY))
+				DPRINTK("Bad return from blkdev data "
+					"request: %x\n", bret->status);
+
+			ret = end_that_request_first(
+				req, (bret->status == BLKIF_RSP_OKAY),
+				req->hard_nr_sectors);
+			BUG_ON(ret);
+			end_that_request_last(
+				req, (bret->status == BLKIF_RSP_OKAY));
+			break;
+		default:
+			BUG();
+		}
+	}
+
+	info->ring.rsp_cons = i;
+
+	if (i != info->ring.req_prod_pvt) {
+		int more_to_do;
+		RING_FINAL_CHECK_FOR_RESPONSES(&info->ring, more_to_do);
+		if (more_to_do)
+			goto again;
+	} else
+		info->ring.sring->rsp_event = i + 1;
+
+	kick_pending_request_queues(info);
+
+	spin_unlock_irqrestore(&blkif_io_lock, flags);
+
+	return IRQ_HANDLED;
+}
+
+static void blkif_free(struct blkfront_info *info, int suspend)
+{
+	/* Prevent new requests being issued until we fix things up. */
+	spin_lock_irq(&blkif_io_lock);
+	info->connected = suspend ?
+		BLKIF_STATE_SUSPENDED : BLKIF_STATE_DISCONNECTED;
+	spin_unlock_irq(&blkif_io_lock);
+
+	/* Free resources associated with old device channel. */
+	if (info->ring_ref != GRANT_INVALID_REF) {
+		gnttab_end_foreign_access(info->ring_ref, 0,
+					  (unsigned long)info->ring.sring);
+		info->ring_ref = GRANT_INVALID_REF;
+		info->ring.sring = NULL;
+	}
+	if (info->irq)
+		unbind_from_irqhandler(info->irq, info);
+	info->evtchn = info->irq = 0;
+
+}
+
+static void blkif_completion(struct blk_shadow *s)
+{
+	int i;
+	for (i = 0; i < s->req.nr_segments; i++)
+		gnttab_end_foreign_access(s->req.seg[i].gref, 0, 0UL);
+}
+
+static void blkif_recover(struct blkfront_info *info)
+{
+	int i;
+	struct blkif_request *req;
+	struct blk_shadow *copy;
+	int j;
+
+	/* Stage 1: Make a safe copy of the shadow state. */
+	copy = kmalloc(sizeof(info->shadow), GFP_KERNEL | __GFP_NOFAIL);
+	memcpy(copy, info->shadow, sizeof(info->shadow));
+
+	/* Stage 2: Set up free list. */
+	memset(&info->shadow, 0, sizeof(info->shadow));
+	for (i = 0; i < BLK_RING_SIZE; i++)
+		info->shadow[i].req.id = i+1;
+	info->shadow_free = info->ring.req_prod_pvt;
+	info->shadow[BLK_RING_SIZE-1].req.id = 0x0fffffff;
+
+	/* Stage 3: Find pending requests and requeue them. */
+	for (i = 0; i < BLK_RING_SIZE; i++) {
+		/* Not in use? */
+		if (copy[i].request == 0)
+			continue;
+
+		/* Grab a request slot and copy shadow state into it. */
+		req = RING_GET_REQUEST(
+			&info->ring, info->ring.req_prod_pvt);
+		*req = copy[i].req;
+
+		/* We get a new request id, and must reset the shadow state. */
+		req->id = GET_ID_FROM_FREELIST(info);
+		memcpy(&info->shadow[req->id], &copy[i], sizeof(copy[i]));
+
+		/* Rewrite any grant references invalidated by susp/resume. */
+		for (j = 0; j < req->nr_segments; j++)
+			gnttab_grant_foreign_access_ref(
+				req->seg[j].gref,
+				info->xbdev->otherend_id,
+				pfn_to_mfn(info->shadow[req->id].frame[j]),
+				rq_data_dir(
+					(struct request *)
+					info->shadow[req->id].request));
+		info->shadow[req->id].req = *req;
+
+		info->ring.req_prod_pvt++;
+	}
+
+	kfree(copy);
+
+	(void)xenbus_switch_state(info->xbdev, XBT_NULL, XenbusStateConnected);
+
+	/* Now safe for us to use the shared ring */
+	spin_lock_irq(&blkif_io_lock);
+	info->connected = BLKIF_STATE_CONNECTED;
+	spin_unlock_irq(&blkif_io_lock);
+
+	/* Send off requeued requests */
+	flush_requests(info);
+
+	/* Kick any other new requests queued since we resumed */
+	spin_lock_irq(&blkif_io_lock);
+	kick_pending_request_queues(info);
+	spin_unlock_irq(&blkif_io_lock);
+}
+
+
+/* ** Driver Registration ** */
+
+
+static struct xenbus_device_id blkfront_ids[] = {
+	{ "vbd" },
+	{ "" }
+};
+
+
+static struct xenbus_driver blkfront = {
+	.name = "vbd",
+	.owner = THIS_MODULE,
+	.ids = blkfront_ids,
+	.probe = blkfront_probe,
+	.remove = blkfront_remove,
+	.resume = blkfront_resume,
+	.otherend_changed = backend_changed,
+};
+
+
+static int __init xlblk_init(void)
+{
+	if (xen_init() < 0)
+		return -ENODEV;
+
+	if (xlvbd_alloc_major() < 0)
+		return -ENODEV;
+
+	return xenbus_register_frontend(&blkfront);
+}
+module_init(xlblk_init);
+
+
+static void xlblk_exit(void)
+{
+	return xenbus_unregister_driver(&blkfront);
+}
+module_exit(xlblk_exit);
+
+MODULE_LICENSE("Dual BSD/GPL");
--- /dev/null
+++ linus-2.6/drivers/xen/blkfront/block.h
@@ -0,0 +1,156 @@
+/******************************************************************************
+ * block.h
+ * 
+ * Shared definitions between all levels of XenLinux Virtual block devices.
+ * 
+ * Copyright (c) 2003-2004, Keir Fraser & Steve Hand
+ * Modifications by Mark A. Williamson are (c) Intel Research Cambridge
+ * Copyright (c) 2004-2005, Christian Limpach
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
+#ifndef __XEN_DRIVERS_BLOCK_H__
+#define __XEN_DRIVERS_BLOCK_H__
+
+#include <linux/config.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/slab.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/fs.h>
+#include <linux/hdreg.h>
+#include <linux/blkdev.h>
+#include <linux/major.h>
+#include <linux/devfs_fs_kernel.h>
+#include <asm/hypervisor.h>
+#include <xen/xenbus.h>
+#include <xen/gnttab.h>
+#include <xen/interface/xen.h>
+#include <xen/interface/io/blkif.h>
+#include <xen/interface/io/ring.h>
+#include <asm/io.h>
+#include <asm/atomic.h>
+#include <asm/uaccess.h>
+
+#if 1
+#define IPRINTK(fmt, args...) \
+    printk(KERN_INFO "xen_blk: " fmt, ##args)
+#else
+#define IPRINTK(fmt, args...) ((void)0)
+#endif
+
+#if 1
+#define WPRINTK(fmt, args...) \
+    printk(KERN_WARNING "xen_blk: " fmt, ##args)
+#else
+#define WPRINTK(fmt, args...) ((void)0)
+#endif
+
+#define DPRINTK(_f, _a...) pr_debug(_f, ## _a)
+
+#if 0
+#define DPRINTK_IOCTL(_f, _a...) printk(KERN_ALERT _f, ## _a)
+#else
+#define DPRINTK_IOCTL(_f, _a...) ((void)0)
+#endif
+
+struct xlbd_type_info
+{
+	int partn_shift;
+	int disks_per_major;
+	char *devname;
+	char *diskname;
+};
+
+struct xlbd_major_info
+{
+	int major;
+	int index;
+	int usage;
+	struct xlbd_type_info *type;
+};
+
+struct blk_shadow {
+	struct blkif_request req;
+	unsigned long request;
+	unsigned long frame[BLKIF_MAX_SEGMENTS_PER_REQUEST];
+};
+
+#define BLK_RING_SIZE __RING_SIZE((struct blkif_sring *)0, PAGE_SIZE)
+
+/*
+ * We have one of these per vbd, whether ide, scsi or 'other'.  They
+ * hang in private_data off the gendisk structure. We may end up
+ * putting all kinds of interesting stuff here :-)
+ */
+struct blkfront_info
+{
+	struct xenbus_device *xbdev;
+	dev_t dev;
+ 	struct gendisk *gd;
+	int vdevice;
+	blkif_vdev_t handle;
+	int connected;
+	int ring_ref;
+	struct blkif_front_ring ring;
+	unsigned int evtchn, irq;
+	struct xlbd_major_info *mi;
+	request_queue_t *rq;
+	struct work_struct work;
+	struct gnttab_free_callback callback;
+	struct blk_shadow shadow[BLK_RING_SIZE];
+	unsigned long shadow_free;
+
+	/**
+	 * The number of people holding this device open.  We won't allow a
+	 * hot-unplug unless this is 0.
+	 */
+	int users;
+};
+
+extern spinlock_t blkif_io_lock;
+
+extern int blkif_open(struct inode *inode, struct file *filep);
+extern int blkif_release(struct inode *inode, struct file *filep);
+extern int blkif_ioctl(struct inode *inode, struct file *filep,
+                       unsigned command, unsigned long argument);
+extern int blkif_check(dev_t dev);
+extern int blkif_revalidate(dev_t dev);
+extern void do_blkif_request (request_queue_t *rq);
+
+/* Virtual block device subsystem. */
+int xlvbd_alloc_major(void);
+/* Note that xlvbd_add doesn't call add_disk for you: you're expected
+   to call add_disk on info->gd once the disk is properly connected
+   up. */
+int xlvbd_add(blkif_sector_t capacity, int device,
+	      u16 vdisk_info, u16 sector_size, struct blkfront_info *info);
+void xlvbd_del(struct blkfront_info *info);
+
+#endif /* __XEN_DRIVERS_BLOCK_H__ */
--- /dev/null
+++ linus-2.6/drivers/xen/blkfront/vbd.c
@@ -0,0 +1,216 @@
+/******************************************************************************
+ * vbd.c
+ * 
+ * XenLinux virtual block device driver (xvd).
+ * 
+ * Copyright (c) 2003-2004, Keir Fraser & Steve Hand
+ * Modifications by Mark A. Williamson are (c) Intel Research Cambridge
+ * Copyright (c) 2004-2005, Christian Limpach
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
+#include "block.h"
+#include <linux/blkdev.h>
+#include <linux/list.h>
+
+#define BLKIF_MAJOR(dev) ((dev)>>8)
+#define BLKIF_MINOR(dev) ((dev) & 0xff)
+
+static struct xlbd_type_info xvd_type_info = {
+	.partn_shift = 4,
+	.disks_per_major = 16,
+	.devname = "xvd",
+	.diskname = "xvd"
+};
+
+static struct xlbd_major_info xvd_major_info = {
+	.major = 201,
+	.type = &xvd_type_info
+};
+
+/* Information about our VBDs. */
+#define MAX_VBDS 64
+static LIST_HEAD(vbds_list);
+
+static struct block_device_operations xlvbd_block_fops =
+{
+	.owner = THIS_MODULE,
+	.open = blkif_open,
+	.release = blkif_release,
+	.ioctl  = blkif_ioctl,
+};
+
+spinlock_t blkif_io_lock = SPIN_LOCK_UNLOCKED;
+
+int
+xlvbd_alloc_major(void)
+{
+	printk("Registering block device major %i\n", xvd_major_info.major);
+	if (register_blkdev(xvd_major_info.major,
+			    xvd_major_info.type->devname)) {
+		WPRINTK("can't get major %d with name %s\n",
+			xvd_major_info.major, xvd_major_info.type->devname);
+		return -1;
+	}
+
+	devfs_mk_dir(xvd_major_info.type->devname);
+	return 0;
+}
+
+static int
+xlvbd_init_blk_queue(struct gendisk *gd, u16 sector_size)
+{
+	request_queue_t *rq;
+
+	rq = blk_init_queue(do_blkif_request, &blkif_io_lock);
+	if (rq == NULL)
+		return -1;
+
+	elevator_init(rq, "noop");
+
+	/* Hard sector size and max sectors impersonate the equiv. hardware. */
+	blk_queue_hardsect_size(rq, sector_size);
+	blk_queue_max_sectors(rq, 512);
+
+	/* Each segment in a request is up to an aligned page in size. */
+	blk_queue_segment_boundary(rq, PAGE_SIZE - 1);
+	blk_queue_max_segment_size(rq, PAGE_SIZE);
+
+	/* Ensure a merged request will fit in a single I/O ring slot. */
+	blk_queue_max_phys_segments(rq, BLKIF_MAX_SEGMENTS_PER_REQUEST);
+	blk_queue_max_hw_segments(rq, BLKIF_MAX_SEGMENTS_PER_REQUEST);
+
+	/* Make sure buffer addresses are sector-aligned. */
+	blk_queue_dma_alignment(rq, 511);
+
+	gd->queue = rq;
+
+	return 0;
+}
+
+static int
+xlvbd_alloc_gendisk(int minor, blkif_sector_t capacity, int vdevice,
+		    u16 vdisk_info, u16 sector_size,
+		    struct blkfront_info *info)
+{
+	struct gendisk *gd;
+	struct xlbd_major_info *mi;
+	int nr_minors = 1;
+	int err = -ENODEV;
+
+	BUG_ON(info->gd != NULL);
+	BUG_ON(info->mi != NULL);
+	BUG_ON(info->rq != NULL);
+
+	mi = &xvd_major_info;
+	info->mi = mi;
+
+	if ((minor & ((1 << mi->type->partn_shift) - 1)) == 0)
+		nr_minors = 1 << mi->type->partn_shift;
+
+	gd = alloc_disk(nr_minors);
+	if (gd == NULL)
+		goto out;
+
+	if (nr_minors > 1)
+		sprintf(gd->disk_name, "%s%c", mi->type->diskname,
+			'a' + mi->index * mi->type->disks_per_major +
+			(minor >> mi->type->partn_shift));
+	else
+		sprintf(gd->disk_name, "%s%c%d", mi->type->diskname,
+			'a' + mi->index * mi->type->disks_per_major +
+			(minor >> mi->type->partn_shift),
+			minor & ((1 << mi->type->partn_shift) - 1));
+
+	gd->major = mi->major;
+	gd->first_minor = minor;
+	gd->fops = &xlvbd_block_fops;
+	gd->private_data = info;
+	gd->driverfs_dev = &(info->xbdev->dev);
+	set_capacity(gd, capacity);
+
+	if (xlvbd_init_blk_queue(gd, sector_size)) {
+		del_gendisk(gd);
+		goto out;
+	}
+
+	info->rq = gd->queue;
+
+	if (vdisk_info & VDISK_READONLY)
+		set_disk_ro(gd, 1);
+
+	if (vdisk_info & VDISK_REMOVABLE)
+		gd->flags |= GENHD_FL_REMOVABLE;
+
+	if (vdisk_info & VDISK_CDROM)
+		gd->flags |= GENHD_FL_CD;
+
+	info->gd = gd;
+
+	return 0;
+
+ out:
+	info->mi = NULL;
+	return err;
+}
+
+int
+xlvbd_add(blkif_sector_t capacity, int vdevice, u16 vdisk_info,
+	  u16 sector_size, struct blkfront_info *info)
+{
+	struct block_device *bd;
+	int err = 0;
+
+	info->dev = MKDEV(BLKIF_MAJOR(vdevice), BLKIF_MINOR(vdevice));
+
+	bd = bdget(info->dev);
+	if (bd == NULL)
+		return -ENODEV;
+
+	err = xlvbd_alloc_gendisk(BLKIF_MINOR(vdevice), capacity, vdevice,
+				  vdisk_info, sector_size, info);
+
+	bdput(bd);
+	return err;
+}
+
+void
+xlvbd_del(struct blkfront_info *info)
+{
+	if (info->mi == NULL)
+		return;
+
+	BUG_ON(info->gd == NULL);
+	del_gendisk(info->gd);
+	put_disk(info->gd);
+	info->gd = NULL;
+
+	info->mi = NULL;
+
+	BUG_ON(info->rq == NULL);
+	blk_cleanup_queue(info->rq);
+	info->rq = NULL;
+}

--
