Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261239AbVEDRIb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261239AbVEDRIb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261228AbVEDRIa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:08:30 -0400
Received: from mx1.redhat.com ([66.187.233.31]:26267 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S261177AbVEDRHH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:07:07 -0400
Date: Wed, 4 May 2005 18:06:56 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Christoph Hellwig <hch@lst.de>
Subject: [PATCH] device-mapper: [4/5] Handle __lock_fs error
Message-ID: <20050504170656.GQ10195@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Christoph Hellwig <hch@lst.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Handle error from __lock_fs()

Signed-Off-By: Alasdair G Kergon <agk@redhat.com>
From: Christoph Hellwig <hch@lst.de>
--- diff/drivers/md/dm.c	2005-04-21 16:08:10.000000000 +0100
+++ source/drivers/md/dm.c	2005-04-21 16:08:19.000000000 +0100
@@ -1048,6 +1048,7 @@
 {
 	struct dm_table *map;
 	DECLARE_WAITQUEUE(wait, current);
+	int error;
 
 	/* Flush I/O to the device. */
 	down_read(&md->lock);
@@ -1056,25 +1057,29 @@
 		return -EINVAL;
 	}
 
+	error = __lock_fs(md);
+	if (error) {
+		up_read(&md->lock);
+		return error;
+	}
+
 	map = dm_get_table(md);
 	if (map)
 		dm_table_presuspend_targets(map);
-	__lock_fs(md);
 
 	up_read(&md->lock);
 
 	/*
-	 * First we set the BLOCK_IO flag so no more ios will be
-	 * mapped.
+	 * First we set the BLOCK_IO flag so no more ios will be mapped.
+	 *
+	 * If the flag is already set we know another thread is trying to
+	 * suspend as well, so we leave the fs locked for this thread.
 	 */
 	down_write(&md->lock);
 	if (test_bit(DMF_BLOCK_IO, &md->flags)) {
-		/*
-		 * If we get here we know another thread is
-		 * trying to suspend as well, so we leave the fs
-		 * locked for this thread.
-		 */
 		up_write(&md->lock);
+		if (map)
+			dm_table_put(map);
 		return -EINVAL;
 	}
 
@@ -1107,6 +1112,7 @@
 
 	/* were we interrupted ? */
 	if (atomic_read(&md->pending)) {
+		/* FIXME Undo the presuspend_targets */
 		__unlock_fs(md);
 		clear_bit(DMF_BLOCK_IO, &md->flags);
 		up_write(&md->lock);
