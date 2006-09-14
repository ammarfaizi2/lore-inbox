Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751171AbWINVmw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751171AbWINVmw (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751182AbWINVmw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:42:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:2261 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751173AbWINVmu (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:42:50 -0400
Date: Thu, 14 Sep 2006 22:42:46 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Mark McLoughlin <markmc@redhat.com>
Subject: [PATCH 09/25] dm snapshot: add workqueue
Message-ID: <20060914214246.GQ3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Mark McLoughlin <markmc@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Add a workqueue so that I/O can be queued up to be flushed from a
separate thread (e.g. if local interrupts are disabled).

A new per-snapshot spinlock pe_lock is introduced to protect
queued_bios.

Signed-off-by: Alasdair G Kergon <agk@redhat.com>
Signed-off-by: Mark McLoughlin <markmc@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm-snap.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.c	2006-09-14 20:40:46.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.c	2006-09-14 20:44:39.000000000 +0100
@@ -39,6 +39,9 @@
  */
 #define SNAPSHOT_PAGES 256
 
+struct workqueue_struct *ksnapd;
+static void flush_queued_bios(void *data);
+
 struct pending_exception {
 	struct exception e;
 
@@ -488,6 +491,7 @@ static int snapshot_ctr(struct dm_target
 	s->active = 0;
 	s->last_percent = 0;
 	init_rwsem(&s->lock);
+	spin_lock_init(&s->pe_lock);
 	s->table = ti->table;
 
 	/* Allocate hash table for COW data */
@@ -523,6 +527,9 @@ static int snapshot_ctr(struct dm_target
 		goto bad6;
 	}
 
+	bio_list_init(&s->queued_bios);
+	INIT_WORK(&s->queued_bios_work, flush_queued_bios, s);
+
 	/* Add snapshot to the list of snapshots for this origin */
 	/* Exceptions aren't triggered till snapshot_resume() is called */
 	if (register_snapshot(s)) {
@@ -561,6 +568,8 @@ static void snapshot_dtr(struct dm_targe
 {
 	struct dm_snapshot *s = (struct dm_snapshot *) ti->private;
 
+	flush_workqueue(ksnapd);
+
 	/* Prevent further origin writes from using this snapshot. */
 	/* After this returns there can be no new kcopyd jobs. */
 	unregister_snapshot(s);
@@ -594,6 +603,19 @@ static void flush_bios(struct bio *bio)
 	}
 }
 
+static void flush_queued_bios(void *data)
+{
+	struct dm_snapshot *s = (struct dm_snapshot *) data;
+	struct bio *queued_bios;
+	unsigned long flags;
+
+	spin_lock_irqsave(&s->pe_lock, flags);
+	queued_bios = bio_list_get(&s->queued_bios);
+	spin_unlock_irqrestore(&s->pe_lock, flags);
+
+	flush_bios(queued_bios);
+}
+
 /*
  * Error a list of buffers.
  */
@@ -1240,8 +1262,17 @@ static int __init dm_snapshot_init(void)
 		goto bad5;
 	}
 
+	ksnapd = create_singlethread_workqueue("ksnapd");
+	if (!ksnapd) {
+		DMERR("Failed to create ksnapd workqueue.");
+		r = -ENOMEM;
+		goto bad6;
+	}
+
 	return 0;
 
+      bad6:
+	mempool_destroy(pending_pool);
       bad5:
 	kmem_cache_destroy(pending_cache);
       bad4:
@@ -1259,6 +1290,8 @@ static void __exit dm_snapshot_exit(void
 {
 	int r;
 
+	destroy_workqueue(ksnapd);
+
 	r = dm_unregister_target(&snapshot_target);
 	if (r)
 		DMERR("snapshot unregister failed %d", r);
Index: linux-2.6.18-rc7/drivers/md/dm-snap.h
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm-snap.h	2006-09-14 20:38:48.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm-snap.h	2006-09-14 20:44:39.000000000 +0100
@@ -10,7 +10,9 @@
 #define DM_SNAPSHOT_H
 
 #include "dm.h"
+#include "dm-bio-list.h"
 #include <linux/blkdev.h>
+#include <linux/workqueue.h>
 
 struct exception_table {
 	uint32_t hash_mask;
@@ -112,10 +114,20 @@ struct dm_snapshot {
 	struct exception_table pending;
 	struct exception_table complete;
 
+	/*
+	 * pe_lock protects all pending_exception operations and access
+	 * as well as the snapshot_bios list.
+	 */
+	spinlock_t pe_lock;
+
 	/* The on disk metadata handler */
 	struct exception_store store;
 
 	struct kcopyd_client *kcopyd_client;
+
+	/* Queue of snapshot writes for ksnapd to flush */
+	struct bio_list queued_bios;
+	struct work_struct queued_bios_work;
 };
 
 /*
