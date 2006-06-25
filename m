Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752325AbWFXPRz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752325AbWFXPRz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 11:17:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752300AbWFXPRf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 11:17:35 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:63686 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1752312AbWFXPR3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 11:17:29 -0400
Message-ID: <351162246.28395@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625071730.446923099@localhost.localdomain>
References: <20060625071036.241325936@localhost.localdomain>
Date: Sun, 25 Jun 2006 15:10:42 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Fengguang Wu <wfg@mail.ustc.edu.cn>
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
