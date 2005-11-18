Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161191AbVKRUer@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161191AbVKRUer (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 15:34:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161192AbVKRUeq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 15:34:46 -0500
Received: from mx1.redhat.com ([66.187.233.31]:21124 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1161191AbVKRUeo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 15:34:44 -0500
Date: Fri, 18 Nov 2005 20:34:28 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: make lock_fs optional
Message-ID: <20051118203428.GU11878@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Devices only needs syncing when creating snapshots,
so make this optional when suspending a device.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.14/drivers/md/dm-ioctl.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm-ioctl.c	2005-11-14 23:10:57.000000000 +0000
+++ linux-2.6.14/drivers/md/dm-ioctl.c	2005-11-14 23:11:24.000000000 +0000
@@ -700,7 +700,7 @@ static int do_suspend(struct dm_ioctl *p
 		return -ENXIO;
 
 	if (!dm_suspended(md))
-		r = dm_suspend(md);
+		r = dm_suspend(md, 1);
 
 	if (!r)
 		r = __dev_status(md, param);
@@ -738,7 +738,7 @@ static int do_resume(struct dm_ioctl *pa
 	if (new_map) {
 		/* Suspend if it isn't already suspended */
 		if (!dm_suspended(md))
-			dm_suspend(md);
+			dm_suspend(md, 1);
 
 		r = dm_swap_table(md, new_map);
 		if (r) {
Index: linux-2.6.14/drivers/md/dm.h
===================================================================
--- linux-2.6.14.orig/drivers/md/dm.h	2005-11-14 23:10:57.000000000 +0000
+++ linux-2.6.14/drivers/md/dm.h	2005-11-14 23:11:24.000000000 +0000
@@ -69,7 +69,7 @@ void dm_put(struct mapped_device *md);
 /*
  * A device can still be used while suspended, but I/O is deferred.
  */
-int dm_suspend(struct mapped_device *md);
+int dm_suspend(struct mapped_device *md, int with_lockfs);
 int dm_resume(struct mapped_device *md);
 
 /*
Index: linux-2.6.14/drivers/md/dm.c
===================================================================
--- linux-2.6.14.orig/drivers/md/dm.c	2005-11-14 23:10:57.000000000 +0000
+++ linux-2.6.14/drivers/md/dm.c	2005-11-14 23:11:24.000000000 +0000
@@ -55,6 +55,7 @@ union map_info *dm_get_mapinfo(struct bi
  */
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
+#define DMF_FROZEN 2
 
 struct mapped_device {
 	struct rw_semaphore io_lock;
@@ -1021,6 +1022,8 @@ static int lock_fs(struct mapped_device 
 		return r;
 	}
 
+	set_bit(DMF_FROZEN, &md->flags);
+
 	/* don't bdput right now, we don't want the bdev
 	 * to go away while it is locked.
 	 */
@@ -1029,8 +1032,12 @@ static int lock_fs(struct mapped_device 
 
 static void unlock_fs(struct mapped_device *md)
 {
+	if (!test_bit(DMF_FROZEN, &md->flags))
+		return;
+
 	thaw_bdev(md->suspended_bdev, md->frozen_sb);
 	md->frozen_sb = NULL;
+	clear_bit(DMF_FROZEN, &md->flags);
 }
 
 /*
@@ -1040,7 +1047,7 @@ static void unlock_fs(struct mapped_devi
  * dm_bind_table, dm_suspend must be called to flush any in
  * flight bios and ensure that any further io gets deferred.
  */
-int dm_suspend(struct mapped_device *md)
+int dm_suspend(struct mapped_device *md, int do_lockfs)
 {
 	struct dm_table *map = NULL;
 	DECLARE_WAITQUEUE(wait, current);
@@ -1064,9 +1071,11 @@ int dm_suspend(struct mapped_device *md)
 	}
 
 	/* Flush I/O to the device. */
-	r = lock_fs(md);
-	if (r)
-		goto out;
+	if (do_lockfs) {
+		r = lock_fs(md);
+		if (r)
+			goto out;
+	}
 
 	/*
 	 * First we set the BLOCK_IO flag so no more ios will be mapped.
