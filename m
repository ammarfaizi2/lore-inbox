Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261315AbVEDRLU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261315AbVEDRLU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:11:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEDRJa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:09:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:4764 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261209AbVEDRIU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:08:20 -0400
Date: Wed, 4 May 2005 18:08:04 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] device-mapper: [5/5] Tidy dm_suspend
Message-ID: <20050504170804.GR10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tidy dm_suspend.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
From: Christoph Hellwig <hch@lst.de>
--- diff/drivers/md/dm.c	2005-04-21 16:08:19.000000000 +0100
+++ source/drivers/md/dm.c	2005-04-21 16:09:16.000000000 +0100
@@ -1048,20 +1048,16 @@
 {
 	struct dm_table *map;
 	DECLARE_WAITQUEUE(wait, current);
-	int error;
+	int error = -EINVAL;
 
 	/* Flush I/O to the device. */
 	down_read(&md->lock);
-	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
-		up_read(&md->lock);
-		return -EINVAL;
-	}
+	if (test_bit(DMF_BLOCK_IO, &md->flags))
+		goto out_read_unlock;
 
 	error = __lock_fs(md);
-	if (error) {
-		up_read(&md->lock);
-		return error;
-	}
+	if (error)
+		goto out_read_unlock;
 
 	map = dm_get_table(md);
 	if (map)
@@ -1075,15 +1071,14 @@
 	 * If the flag is already set we know another thread is trying to
 	 * suspend as well, so we leave the fs locked for this thread.
 	 */
+	error = -EINVAL;
 	down_write(&md->lock);
-	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
-		up_write(&md->lock);
+	if (test_and_set_bit(DMF_BLOCK_IO, &md->flags)) {
 		if (map)
 			dm_table_put(map);
-		return -EINVAL;
+		goto out_write_unlock;
 	}
 
-	set_bit(DMF_BLOCK_IO, &md->flags);
 	add_wait_queue(&md->wait, &wait);
 	up_write(&md->lock);
 
@@ -1111,13 +1106,9 @@
 	remove_wait_queue(&md->wait, &wait);
 
 	/* were we interrupted ? */
-	if (atomic_read(&md->pending)) {
-		/* FIXME Undo the presuspend_targets */
-		__unlock_fs(md);
-		clear_bit(DMF_BLOCK_IO, &md->flags);
-		up_write(&md->lock);
-		return -EINTR;
-	}
+	error = -EINTR;
+	if (atomic_read(&md->pending))
+		goto out_unfreeze;
 
 	set_bit(DMF_SUSPENDED, &md->flags);
 
@@ -1128,6 +1119,18 @@
 	up_write(&md->lock);
 
 	return 0;
+
+out_unfreeze:
+	/* FIXME Undo dm_table_presuspend_targets */
+	__unlock_fs(md);
+	clear_bit(DMF_BLOCK_IO, &md->flags);
+out_write_unlock:
+	up_write(&md->lock);
+	return error;
+
+out_read_unlock:
+	up_read(&md->lock);
+	return error;
 }
 
 int dm_resume(struct mapped_device *md)
