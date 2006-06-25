Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWFYNJj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWFYNJj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 25 Jun 2006 09:09:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751257AbWFYNJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 25 Jun 2006 09:09:21 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:19166 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751419AbWFYNJQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 25 Jun 2006 09:09:16 -0400
Message-ID: <351240953.20240@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060625130923.154258797@localhost.localdomain>
References: <20060625130704.464870100@localhost.localdomain>
Date: Sun, 25 Jun 2006 21:07:10 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 6/6] readahead: remove the size limit of max_sectors_kb on read_ahead_kb
Content-Disposition: inline; filename=readahead-size-limited-by-max-sectors-fix.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the corelation between max_sectors_kb and read_ahead_kb.
It's unnecessary to reduce readahead size when setting max_sectors_kb.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


--- linux-2.6.17-mm2.orig/block/ll_rw_blk.c
+++ linux-2.6.17-mm2/block/ll_rw_blk.c
@@ -3851,25 +3851,11 @@ queue_max_sectors_store(struct request_q
 			max_hw_sectors_kb = q->max_hw_sectors >> 1,
 			page_kb = 1 << (PAGE_CACHE_SHIFT - 10);
 	ssize_t ret = queue_var_store(&max_sectors_kb, page, count);
-	int ra_kb;
 
 	if (max_sectors_kb > max_hw_sectors_kb || max_sectors_kb < page_kb)
 		return -EINVAL;
-	/*
-	 * Take the queue lock to update the readahead and max_sectors
-	 * values synchronously:
-	 */
-	spin_lock_irq(q->queue_lock);
-	/*
-	 * Trim readahead window as well, if necessary:
-	 */
-	ra_kb = q->backing_dev_info.ra_pages << (PAGE_CACHE_SHIFT - 10);
-	if (ra_kb > max_sectors_kb)
-		q->backing_dev_info.ra_pages =
-				max_sectors_kb >> (PAGE_CACHE_SHIFT - 10);
 
 	q->max_sectors = max_sectors_kb << 1;
-	spin_unlock_irq(q->queue_lock);
 
 	return ret;
 }

--
