Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262143AbVGKWor@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262143AbVGKWor (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 18:44:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262141AbVGKWmz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 18:42:55 -0400
Received: from mx1.redhat.com ([66.187.233.31]:63212 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S262756AbVGKWWx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 18:22:53 -0400
Date: Mon, 11 Jul 2005 23:22:47 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: [PATCH] device-mapper: [3/4] Fix deadlocks in core
Message-ID: <20050711222247.GE12355@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is an attempt to fix deadlocks discovered in the core dm.

The problems boil down to md->lock having to be held in too many
places, so I've split it into two: md->suspend_lock and md->io_lock.

suspend_lock is now held throughout dm_suspended() as well as
dm_resume() and dm_swap_table() so that these functions cannot
run concurrently: there's no requirement for that and it added
complexity.

DMF_FS_LOCKED becomes redundant: DMF_SUSPENDED provides adequate
protection.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>

--- diff/drivers/md/dm.c	2005-07-11 22:57:58.000000000 +0100
+++ source/drivers/md/dm.c	2005-07-11 23:03:21.000000000 +0100
@@ -55,10 +55,10 @@
  */
 #define DMF_BLOCK_IO 0
 #define DMF_SUSPENDED 1
-#define DMF_FS_LOCKED 2
 
 struct mapped_device {
-	struct rw_semaphore lock;
+	struct rw_semaphore io_lock;
+	struct semaphore suspend_lock;
 	rwlock_t map_lock;
 	atomic_t holders;
 
@@ -248,16 +248,16 @@
  */
 static int queue_io(struct mapped_device *md, struct bio *bio)
 {
-	down_write(&md->lock);
+	down_write(&md->io_lock);
 
 	if (!test_bit(DMF_BLOCK_IO, &md->flags)) {
-		up_write(&md->lock);
+		up_write(&md->io_lock);
 		return 1;
 	}
 
 	bio_list_add(&md->deferred, bio);
 
-	up_write(&md->lock);
+	up_write(&md->io_lock);
 	return 0;		/* deferred successfully */
 }
 
@@ -568,14 +568,14 @@
 	int r;
 	struct mapped_device *md = q->queuedata;
 
-	down_read(&md->lock);
+	down_read(&md->io_lock);
 
 	/*
 	 * If we're suspended we have to queue
 	 * this io for later.
 	 */
 	while (test_bit(DMF_BLOCK_IO, &md->flags)) {
-		up_read(&md->lock);
+		up_read(&md->io_lock);
 
 		if (bio_rw(bio) == READA) {
 			bio_io_error(bio, bio->bi_size);
@@ -594,11 +594,11 @@
 		 * We're in a while loop, because someone could suspend
 		 * before we get to the following read lock.
 		 */
-		down_read(&md->lock);
+		down_read(&md->io_lock);
 	}
 
 	__split_bio(md, bio);
-	up_read(&md->lock);
+	up_read(&md->io_lock);
 	return 0;
 }
 
@@ -747,7 +747,8 @@
 		goto bad1;
 
 	memset(md, 0, sizeof(*md));
-	init_rwsem(&md->lock);
+	init_rwsem(&md->io_lock);
+	init_MUTEX(&md->suspend_lock);
 	rwlock_init(&md->map_lock);
 	atomic_set(&md->holders, 1);
 	atomic_set(&md->event_nr, 0);
@@ -844,13 +845,14 @@
 	if (size == 0)
 		return 0;
 
+	dm_table_get(t);
+	dm_table_event_callback(t, event_callback, md);
+
 	write_lock(&md->map_lock);
 	md->map = t;
+	dm_table_set_restrictions(t, q);
 	write_unlock(&md->map_lock);
 
-	dm_table_get(t);
-	dm_table_event_callback(t, event_callback, md);
-	dm_table_set_restrictions(t, q);
 	return 0;
 }
 
@@ -963,7 +965,7 @@
 {
 	int r = -EINVAL;
 
-	down_write(&md->lock);
+	down(&md->suspend_lock);
 
 	/* device must be suspended */
 	if (!dm_suspended(md))
@@ -973,7 +975,7 @@
 	r = __bind(md, table);
 
 out:
-	up_write(&md->lock);
+	up(&md->suspend_lock);
 	return r;
 }
 
@@ -981,16 +983,13 @@
  * Functions to lock and unlock any filesystem running on the
  * device.
  */
-static int __lock_fs(struct mapped_device *md)
+static int lock_fs(struct mapped_device *md)
 {
 	int r = -ENOMEM;
 
-	if (test_and_set_bit(DMF_FS_LOCKED, &md->flags))
-		return 0;
-
 	md->frozen_bdev = bdget_disk(md->disk, 0);
 	if (!md->frozen_bdev) {
-		DMWARN("bdget failed in __lock_fs");
+		DMWARN("bdget failed in lock_fs");
 		goto out;
 	}
 
@@ -1004,7 +1003,7 @@
 
 	/* don't bdput right now, we don't want the bdev
 	 * to go away while it is locked.  We'll bdput
-	 * in __unlock_fs
+	 * in unlock_fs
 	 */
 	return 0;
 
@@ -1013,15 +1012,11 @@
 	md->frozen_sb = NULL;
 	md->frozen_bdev = NULL;
 out:
-	clear_bit(DMF_FS_LOCKED, &md->flags);
 	return r;
 }
 
-static void __unlock_fs(struct mapped_device *md)
+static void unlock_fs(struct mapped_device *md)
 {
-	if (!test_and_clear_bit(DMF_FS_LOCKED, &md->flags))
-		return;
-
 	thaw_bdev(md->frozen_bdev, md->frozen_sb);
 	bdput(md->frozen_bdev);
 
@@ -1038,13 +1033,14 @@
  */
 int dm_suspend(struct mapped_device *md)
 {
-	struct dm_table *map;
+	struct dm_table *map = NULL;
 	DECLARE_WAITQUEUE(wait, current);
 	int r = -EINVAL;
 
-	down_read(&md->lock);
-	if (test_bit(DMF_BLOCK_IO, &md->flags))
-		goto out_read_unlock;
+	down(&md->suspend_lock);
+
+	if (dm_suspended(md))
+		goto out;
 
 	map = dm_get_table(md);
 
@@ -1052,36 +1048,22 @@
 	dm_table_presuspend_targets(map);
 
 	/* Flush I/O to the device. */
-	r = __lock_fs(md);
-	if (r) {
-		dm_table_put(map);
-		goto out_read_unlock;
-	}
-
-	up_read(&md->lock);
+	r = lock_fs(md);
+	if (r)
+		goto out;
 
 	/*
 	 * First we set the BLOCK_IO flag so no more ios will be mapped.
-	 *
-	 * If the flag is already set we know another thread is trying to
-	 * suspend as well, so we leave the fs locked for this thread.
 	 */
-	r = -EINVAL;
-	down_write(&md->lock);
-	if (test_and_set_bit(DMF_BLOCK_IO, &md->flags)) {
-		if (map)
-			dm_table_put(map);
-		goto out_write_unlock;
-	}
+	down_write(&md->io_lock);
+	set_bit(DMF_BLOCK_IO, &md->flags);
 
 	add_wait_queue(&md->wait, &wait);
-	up_write(&md->lock);
+	up_write(&md->io_lock);
 
 	/* unplug */
-	if (map) {
+	if (map)
 		dm_table_unplug_all(map);
-		dm_table_put(map);
-	}
 
 	/*
 	 * Then we wait for the already mapped ios to
@@ -1097,32 +1079,28 @@
 	}
 	set_current_state(TASK_RUNNING);
 
-	down_write(&md->lock);
+	down_write(&md->io_lock);
 	remove_wait_queue(&md->wait, &wait);
 
 	/* were we interrupted ? */
 	r = -EINTR;
-	if (atomic_read(&md->pending))
-		goto out_unfreeze;
-
-	set_bit(DMF_SUSPENDED, &md->flags);
+	if (atomic_read(&md->pending)) {
+		up_write(&md->io_lock);
+		unlock_fs(md);
+		clear_bit(DMF_BLOCK_IO, &md->flags);
+		goto out;
+	}
+	up_write(&md->io_lock);
 
-	map = dm_get_table(md);
 	dm_table_postsuspend_targets(map);
-	dm_table_put(map);
-	up_write(&md->lock);
 
-	return 0;
+	set_bit(DMF_SUSPENDED, &md->flags);
 
-out_unfreeze:
-	__unlock_fs(md);
-	clear_bit(DMF_BLOCK_IO, &md->flags);
-out_write_unlock:
-	up_write(&md->lock);
-	return r;
+	r = 0;
 
-out_read_unlock:
-	up_read(&md->lock);
+out:
+	dm_table_put(map);
+	up(&md->suspend_lock);
 	return r;
 }
 
@@ -1132,31 +1110,35 @@
 	struct bio *def;
 	struct dm_table *map = NULL;
 
-	down_write(&md->lock);
-	if (!dm_suspended(md)) {
-		up_write(&md->lock);
+	down(&md->suspend_lock);
+	if (!dm_suspended(md))
 		goto out;
-	}
 
 	map = dm_get_table(md);
-	if (!map || !dm_table_get_size(map)) {
-		up_write(&md->lock);
+	if (!map || !dm_table_get_size(map))
 		goto out;
-	}
 
 	dm_table_resume_targets(map);
-	clear_bit(DMF_SUSPENDED, &md->flags);
+
+	down_write(&md->io_lock);
 	clear_bit(DMF_BLOCK_IO, &md->flags);
 
 	def = bio_list_get(&md->deferred);
 	__flush_deferred_io(md, def);
-	up_write(&md->lock);
-	__unlock_fs(md);
+	up_write(&md->io_lock);
+
+	unlock_fs(md);
+
+	clear_bit(DMF_SUSPENDED, &md->flags);
+
 	dm_table_unplug_all(map);
 
 	r = 0;
+
 out:
 	dm_table_put(map);
+	up(&md->suspend_lock);
+
 	return r;
 }
 
