Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261194AbVEDRHF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261194AbVEDRHF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:07:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbVEDRHF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:07:05 -0400
Received: from mx1.redhat.com ([66.187.233.31]:15770 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261228AbVEDRFL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:05:11 -0400
Date: Wed, 4 May 2005 18:04:58 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] device-mapper: [3/5] Let freeze_bdev return error
Message-ID: <20050504170458.GP10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allow freeze_bdev() to return an error.

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
From: Christoph Hellwig <hch@lst.de>
--- diff/drivers/md/dm.c	2005-04-21 16:07:21.000000000 +0100
+++ source/drivers/md/dm.c	2005-04-21 16:08:10.000000000 +0100
@@ -991,22 +991,38 @@
  */
 static int __lock_fs(struct mapped_device *md)
 {
+	int error = -ENOMEM;
+
 	if (test_and_set_bit(DMF_FS_LOCKED, &md->flags))
 		return 0;
 
 	md->frozen_bdev = bdget_disk(md->disk, 0);
 	if (!md->frozen_bdev) {
 		DMWARN("bdget failed in __lock_fs");
-		return -ENOMEM;
+		goto out;
 	}
 
 	WARN_ON(md->frozen_sb);
+
 	md->frozen_sb = freeze_bdev(md->frozen_bdev);
+	if (IS_ERR(md->frozen_sb)) {
+		error = PTR_ERR(md->frozen_sb);
+		goto out_bdput;
+	}
+
 	/* don't bdput right now, we don't want the bdev
 	 * to go away while it is locked.  We'll bdput
 	 * in __unlock_fs
 	 */
 	return 0;
+
+out_bdput:
+	bdput(md->frozen_bdev);
+	md->frozen_sb = NULL;
+	md->frozen_bdev = NULL;
+out:
+	clear_bit(DMF_FS_LOCKED, &md->flags);
+	return error;
 }
 
 static void __unlock_fs(struct mapped_device *md)
