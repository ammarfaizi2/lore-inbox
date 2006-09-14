Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751086AbWINVhQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751086AbWINVhQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 17:37:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751107AbWINVhP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 17:37:15 -0400
Received: from mx1.redhat.com ([66.187.233.31]:60625 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751086AbWINVhO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 17:37:14 -0400
Date: Thu, 14 Sep 2006 22:36:53 +0100
From: Alasdair G Kergon <agk@redhat.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Ishai Rabinovitz <ishai@mellanox.co.il>
Subject: [PATCH 01/25] dm: fix alloc_dev error path
Message-ID: <20060914213653.GI3928@agk.surrey.redhat.com>
Mail-Followup-To: Alasdair G Kergon <agk@redhat.com>,
	Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
	Ishai Rabinovitz <ishai@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ishai Rabinovitz <ishai@mellanox.co.il>

While reading the code I found a bug in the error path in alloc_dev in dm.c

When blk_alloc_queue fails there is no call to free_minor.

This patch fixes the problem.

Signed-off-by: Ishai Rabinovitz <ishai@mellanox.co.il>
Signed-off-by: Alasdair G Kergon <agk@redhat.com>

Index: linux-2.6.18-rc7/drivers/md/dm.c
===================================================================
--- linux-2.6.18-rc7.orig/drivers/md/dm.c	2006-09-14 20:11:38.000000000 +0100
+++ linux-2.6.18-rc7/drivers/md/dm.c	2006-09-14 20:19:42.000000000 +0100
@@ -943,7 +943,7 @@ static struct mapped_device *alloc_dev(i
 
 	md->queue = blk_alloc_queue(GFP_KERNEL);
 	if (!md->queue)
-		goto bad1;
+		goto bad1_free_minor;
 
 	md->queue->queuedata = md;
 	md->queue->backing_dev_info.congested_fn = dm_any_congested;
@@ -993,6 +993,7 @@ static struct mapped_device *alloc_dev(i
 	mempool_destroy(md->io_pool);
  bad2:
 	blk_cleanup_queue(md->queue);
+ bad1_free_minor:
 	free_minor(minor);
  bad1:
 	module_put(THIS_MODULE);
