Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750866AbWFXCoF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750866AbWFXCoF (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 23 Jun 2006 22:44:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750900AbWFXCne
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 23 Jun 2006 22:43:34 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:665 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1750866AbWFXCm4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 23 Jun 2006 22:42:56 -0400
Message-ID: <351116973.29400@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060624024259.383733317@localhost.localdomain>
References: <20060624020358.719251923@localhost.localdomain>
Date: Sat, 24 Jun 2006 10:04:04 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 6/7] iosched: run elv_kick_page() on sync read
Content-Disposition: inline; filename=iosched-kick-page-on-sync-read.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Call elv_kick_page() to notify the elevator of a pending read.

Requests of priority IOPRIO_CLASS_IDLE are ignored.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-rc5-mm3.orig/block/ll_rw_blk.c
+++ linux-2.6.17-rc5-mm3/block/ll_rw_blk.c
@@ -1619,6 +1619,9 @@ static void blk_backing_dev_unplug(struc
 {
 	request_queue_t *q = bdi->unplug_io_data;
 
+	if (IOPRIO_PRIO_CLASS(current->ioprio) != IOPRIO_CLASS_IDLE)
+		elv_kick_page(q, page);
+
 	/*
 	 * devices don't necessarily have an ->unplug_fn defined
 	 */
--- linux-2.6.17-rc5-mm3.orig/fs/buffer.c
+++ linux-2.6.17-rc5-mm3/fs/buffer.c
@@ -63,8 +63,9 @@ static int sync_buffer(void *word)
 
 	smp_mb();
 	bd = bh->b_bdev;
-	if (bd)
-		blk_run_address_space(bd->bd_inode->i_mapping);
+	if (bd && bd->bd_inode && bd->bd_inode->i_mapping)
+		blk_run_backing_dev(bd->bd_inode->i_mapping->backing_dev_info,
+					bh->b_page);
 	io_schedule();
 	return 0;
 }

--
