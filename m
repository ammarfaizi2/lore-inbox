Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261481AbVEDRDm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261481AbVEDRDm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:03:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261315AbVEDRDl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:03:41 -0400
Received: from mx1.redhat.com ([66.187.233.31]:1177 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261918AbVEDRDQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:03:16 -0400
Date: Wed, 4 May 2005 18:02:56 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] device-mapper: [1/5] Store bdev while frozen
Message-ID: <20050504170256.GN10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Store the struct block_device while device is frozen, saving us one 
call to bdget_disk().

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
From: Christoph Hellwig <hch@lst.de>
--- diff/drivers/md/dm.c	2005-04-04 17:39:06.000000000 +0100
+++ source/drivers/md/dm.c	2005-04-21 16:06:40.000000000 +0100
@@ -97,6 +97,7 @@
 	 * freeze/thaw support require holding onto a super block
 	 */
 	struct super_block *frozen_sb;
+	struct block_device *frozen_bdev;
 };
 
 #define MIN_IOS 256
@@ -990,19 +991,17 @@
  */
 static int __lock_fs(struct mapped_device *md)
 {
-	struct block_device *bdev;
-
 	if (test_and_set_bit(DMF_FS_LOCKED, &md->flags))
 		return 0;
 
-	bdev = bdget_disk(md->disk, 0);
-	if (!bdev) {
+	md->frozen_bdev = bdget_disk(md->disk, 0);
+	if (!md->frozen_bdev) {
 		DMWARN("bdget failed in __lock_fs");
 		return -ENOMEM;
 	}
 
 	WARN_ON(md->frozen_sb);
-	md->frozen_sb = freeze_bdev(bdev);
+	md->frozen_sb = freeze_bdev(md->frozen_bdev);
 	/* don't bdput right now, we don't want the bdev
 	 * to go away while it is locked.  We'll bdput
 	 * in __unlock_fs
@@ -1012,21 +1011,15 @@
 
 static int __unlock_fs(struct mapped_device *md)
 {
-	struct block_device *bdev;
-
 	if (!test_and_clear_bit(DMF_FS_LOCKED, &md->flags))
 		return 0;
 
-	bdev = bdget_disk(md->disk, 0);
-	if (!bdev) {
-		DMWARN("bdget failed in __unlock_fs");
-		return -ENOMEM;
-	}
+	thaw_bdev(md->frozen_bdev, md->frozen_sb);
+	bdput(md->frozen_bdev);
 
-	thaw_bdev(bdev, md->frozen_sb);
 	md->frozen_sb = NULL;
-	bdput(bdev);
-	bdput(bdev);
+	md->frozen_bdev = NULL;
+
 	return 0;
 }
 
