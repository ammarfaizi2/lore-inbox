Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261415AbUCAUGR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Mar 2004 15:06:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261417AbUCAUGR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Mar 2004 15:06:17 -0500
Received: from e4.ny.us.ibm.com ([32.97.182.104]:21229 "EHLO e4.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S261415AbUCAUGN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Mar 2004 15:06:13 -0500
From: Kevin Corry <kevcorry@us.ibm.com>
To: DevMapper <dm-devel@redhat.com>, LKML <linux-kernel@vger.kernel.org>
Subject: 2.6.4-rc1-mm1: queue-congestion-dm-implementation patch
Date: Mon, 1 Mar 2004 14:00:50 -0600
User-Agent: KMail/1.6
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200403011400.51008.kevcorry@us.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The queue-congestion-dm-implementation patch in 2.6.4-rc1-mm1 (included below) 
allows a DM device to query the lower-level device(s) during the 
queue-congestion APIs. However, it must wait on an internal semaphore 
(md->lock) before passing the call down to the lower-level devices. The 
problem is that the higher-level caller is holding a spinlock at the same 
time. Here is one such stack-trace I have been seeing:

Debug: sleeping function called from invalid context at include/linux/
rwsem.h:43
in_atomic():1, irqs_disabled():0
Call Trace:
 [<c012456b>] __might_sleep+0xab/0xd0
 [<c03a0771>] dm_any_congested+0x21/0x60
 [<c0192a82>] sync_sb_inodes+0x2d2/0x2f0
 [<c0192b4c>] writeback_inodes+0xac/0x1d0
 [<c014c68b>] wb_kupdate+0xdb/0x170
 [<c014cf49>] __pdflush+0x1b9/0x380
 [<c014d121>] pdflush+0x11/0x20
 [<c014c5b0>] wb_kupdate+0x0/0x170
 [<c013f6b6>] kthread+0xb6/0xc0
 [<c014d110>] pdflush+0x0/0x20
 [<c013f600>] kthread+0x0/0xc0
 [<c01070cd>] kernel_thread_helper+0x5/0x18

I'm not sure how to fix this (or how serious a problem it is)...I'm just 
throwing this out there for discussion.

-- 
Kevin Corry
kevcorry@us.ibm.com
http://evms.sourceforge.net/




--- diff/drivers/md/dm-table.c	2004-03-01 14:36:06.000000000 +0000
+++ source/drivers/md/dm-table.c	2004-03-01 15:42:16.000000000 +0000
@@ -862,6 +862,20 @@ void dm_table_resume_targets(struct dm_t
 	}
 }
 
+int dm_table_any_congested(struct dm_table *t, int bdi_bits)
+{
+	struct list_head *d, *devices;
+	int r = 0;
+
+	devices = dm_table_get_devices(t);
+	for (d = devices->next; d != devices; d = d->next) {
+		struct dm_dev *dd = list_entry(d, struct dm_dev, list);
+		request_queue_t *q = bdev_get_queue(dd->bdev);
+		r |= bdi_congested(&q->backing_dev_info, bdi_bits);
+	}
+
+	return r;
+}
 
 EXPORT_SYMBOL(dm_vcalloc);
 EXPORT_SYMBOL(dm_get_device);
--- diff/drivers/md/dm.c	2004-03-01 14:36:06.000000000 +0000
+++ source/drivers/md/dm.c	2004-03-01 15:42:16.000000000 +0000
@@ -489,6 +489,18 @@ static int dm_request(request_queue_t *q
 	return 0;
 }
 
+static int dm_any_congested(void *congested_data, int bdi_bits)
+{
+	int r;
+	struct mapped_device *md = congested_data;
+
+	down_read(&md->lock);
+	r = dm_table_any_congested(md->map, bdi_bits);
+	up_read(&md->lock);
+
+	return r;
+}
+
 /*-----------------------------------------------------------------
  * A bitset is used to keep track of allocated minor numbers.
  *---------------------------------------------------------------*/
@@ -567,6 +579,8 @@ static struct mapped_device *alloc_dev(u
 		goto bad1;
 
 	md->queue->queuedata = md;
+	md->queue->backing_dev_info.congested_fn = dm_any_congested;
+	md->queue->backing_dev_info.congested_data = md;
 	blk_queue_make_request(md->queue, dm_request);
 
 	md->io_pool = mempool_create(MIN_IOS, mempool_alloc_slab,
--- diff/drivers/md/dm.h	2004-03-01 14:36:06.000000000 +0000
+++ source/drivers/md/dm.h	2004-03-01 15:42:16.000000000 +0000
@@ -115,6 +115,7 @@ struct list_head *dm_table_get_devices(s
 int dm_table_get_mode(struct dm_table *t);
 void dm_table_suspend_targets(struct dm_table *t);
 void dm_table_resume_targets(struct dm_table *t);
+int dm_table_any_congested(struct dm_table *t, int bdi_bits);
 
 /*-----------------------------------------------------------------
  * A registry of target types.
