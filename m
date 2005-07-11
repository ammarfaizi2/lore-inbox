Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262956AbVGKWXa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262956AbVGKWXa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:23:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262922AbVGKWUs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:20:48 -0400
Received: from mx1.redhat.com ([66.187.233.31]:33259 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262878AbVGKWTJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:19:09 -0400
Date: Mon, 11 Jul 2005 23:19:02 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: [1/4] Fix deadlocks in core
Message-ID: <20050711221902.GC12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some code tidy-ups in preparation for the next patches.
Change dm_table_pre/postsuspend_targets to accept NULL.
Use dm_suspended() throughout.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm.c	2005-07-11 22:52:16.000000000 +0100
+++ source/drivers/md/dm.c	2005-07-11 22:52:10.000000000 +0100
@@ -610,7 +610,7 @@
 	int ret = -ENXIO;
 
 	if (map) {
-		ret = dm_table_flush_all(md->map);
+		ret = dm_table_flush_all(map);
 		dm_table_put(map);
 	}
 
@@ -854,7 +854,7 @@
 	write_unlock(&md->map_lock);
 
 	dm_table_get(t);
-	dm_table_event_callback(md->map, event_callback, md);
+	dm_table_event_callback(t, event_callback, md);
 	dm_table_set_restrictions(t, q);
 	return 0;
 }
@@ -935,7 +935,7 @@
 	struct dm_table *map = dm_get_table(md);
 
 	if (atomic_dec_and_test(&md->holders)) {
-		if (!test_bit(DMF_SUSPENDED, &md->flags) && map) {
+		if (!dm_suspended(md)) {
 			dm_table_presuspend_targets(map);
 			dm_table_postsuspend_targets(map);
 		}
@@ -971,7 +971,7 @@
 	down_write(&md->lock);
 
 	/* device must be suspended */
-	if (!test_bit(DMF_SUSPENDED, &md->flags))
+	if (!dm_suspended(md))
 		goto out;
 
 	__unbind(md);
@@ -988,7 +988,7 @@
  */
 static int __lock_fs(struct mapped_device *md)
 {
-	int error = -ENOMEM;
+	int r = -ENOMEM;
 
 	if (test_and_set_bit(DMF_FS_LOCKED, &md->flags))
 		return 0;
@@ -1003,7 +1003,7 @@
 
 	md->frozen_sb = freeze_bdev(md->frozen_bdev);
 	if (IS_ERR(md->frozen_sb)) {
-		error = PTR_ERR(md->frozen_sb);
+		r = PTR_ERR(md->frozen_sb);
 		goto out_bdput;
 	}
 
@@ -1019,7 +1019,7 @@
 	md->frozen_bdev = NULL;
 out:
 	clear_bit(DMF_FS_LOCKED, &md->flags);
-	return error;
+	return r;
 }
 
 static void __unlock_fs(struct mapped_device *md)
@@ -1045,20 +1045,20 @@
 {
 	struct dm_table *map;
 	DECLARE_WAITQUEUE(wait, current);
-	int error = -EINVAL;
+	int r = -EINVAL;
 
-	/* Flush I/O to the device. */
 	down_read(&md->lock);
 	if (test_bit(DMF_BLOCK_IO, &md->flags))
 		goto out_read_unlock;
 
 	map = dm_get_table(md);
-	if (map)
-		/* This does not get reverted if there's an error later. */
-		dm_table_presuspend_targets(map);
 
-	error = __lock_fs(md);
-	if (error) {
+	/* This does not get reverted if there's an error later. */
+	dm_table_presuspend_targets(map);
+
+	/* Flush I/O to the device. */
+	r = __lock_fs(md);
+	if (r) {
 		dm_table_put(map);
 		goto out_read_unlock;
 	}
@@ -1071,7 +1071,7 @@
 	 * If the flag is already set we know another thread is trying to
 	 * suspend as well, so we leave the fs locked for this thread.
 	 */
-	error = -EINVAL;
+	r = -EINVAL;
 	down_write(&md->lock);
 	if (test_and_set_bit(DMF_BLOCK_IO, &md->flags)) {
 		if (map)
@@ -1106,15 +1106,14 @@
 	remove_wait_queue(&md->wait, &wait);
 
 	/* were we interrupted ? */
-	error = -EINTR;
+	r = -EINTR;
 	if (atomic_read(&md->pending))
 		goto out_unfreeze;
 
 	set_bit(DMF_SUSPENDED, &md->flags);
 
 	map = dm_get_table(md);
-	if (map)
-		dm_table_postsuspend_targets(map);
+	dm_table_postsuspend_targets(map);
 	dm_table_put(map);
 	up_write(&md->lock);
 
@@ -1125,25 +1124,29 @@
 	clear_bit(DMF_BLOCK_IO, &md->flags);
 out_write_unlock:
 	up_write(&md->lock);
-	return error;
+	return r;
 
 out_read_unlock:
 	up_read(&md->lock);
-	return error;
+	return r;
 }
 
 int dm_resume(struct mapped_device *md)
 {
+	int r = -EINVAL;
 	struct bio *def;
-	struct dm_table *map = dm_get_table(md);
+	struct dm_table *map = NULL;
 
 	down_write(&md->lock);
-	if (!map ||
-	    !test_bit(DMF_SUSPENDED, &md->flags) ||
-	    !dm_table_get_size(map)) {
+	if (!dm_suspended(md)) {
 		up_write(&md->lock);
-		dm_table_put(map);
-		return -EINVAL;
+		goto out;
+	}
+
+	map = dm_get_table(md);
+	if (!map || !dm_table_get_size(map)) {
+		up_write(&md->lock);
+		goto out;
 	}
 
 	dm_table_resume_targets(map);
@@ -1155,9 +1158,11 @@
 	up_write(&md->lock);
 	__unlock_fs(md);
 	dm_table_unplug_all(map);
-	dm_table_put(map);
 
-	return 0;
+	r = 0;
+out:
+	dm_table_put(map);
+	return r;
 }
 
 /*-----------------------------------------------------------------
