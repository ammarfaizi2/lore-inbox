Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751373AbVH3Xwb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751373AbVH3Xwb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Aug 2005 19:52:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751427AbVH3Xwb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Aug 2005 19:52:31 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:29343 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751373AbVH3Xwa (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Aug 2005 19:52:30 -0400
Date: Wed, 31 Aug 2005 09:43:59 +1000
From: Nathan Scott <nathans@sgi.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] blk queue io tracing support
Message-ID: <20050830234359.GE780@frodo>
References: <20050823123235.GG16461@suse.de> <20050824010346.GA1021@frodo> <20050824070809.GA27956@suse.de> <20050824171931.H4209301@wobbly.melbourne.sgi.com> <20050824072501.GA27992@suse.de> <20050824092838.GB28272@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050824092838.GB28272@suse.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jens,

On Wed, Aug 24, 2005 at 11:28:39AM +0200, Jens Axboe wrote:
> Patch attached is against 2.6.13-rc6-mm2. Still a good idea to apply the
> relayfs read update from the previous mail [*] as well.

There's a small memory leak there on one of the start-tracing
error paths (relay_open failure)... this should plug it up.

cheers.

-- 
Nathan


Index: 2.6.x-xfs/drivers/block/blktrace.c
===================================================================
--- 2.6.x-xfs.orig/drivers/block/blktrace.c
+++ 2.6.x-xfs/drivers/block/blktrace.c
@@ -73,9 +73,9 @@ int blk_start_trace(struct block_device 
 {
 	request_queue_t *q = bdev_get_queue(bdev);
 	struct blk_user_trace_setup buts;
-	struct blk_trace *bt;
+	struct blk_trace *bt = NULL;
 	char b[BDEVNAME_SIZE];
-	int ret = 0;
+	int ret;
 
 	if (!q)
 		return -ENXIO;
@@ -116,9 +116,14 @@ int blk_start_trace(struct block_device 
 	spin_lock_irq(q->queue_lock);
 	q->blk_trace = bt;
 	spin_unlock_irq(q->queue_lock);
-	ret = 0;
+
+	up(&bdev->bd_sem);
+	return 0;
+
 err:
 	up(&bdev->bd_sem);
+	if (bt)
+		kfree(bt);
 	return ret;
 }
 
