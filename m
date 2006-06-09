Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751442AbWFIIMA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751442AbWFIIMA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 04:12:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751434AbWFIILw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 04:11:52 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:39066 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1751437AbWFIIL1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 04:11:27 -0400
Message-ID: <349840680.23742@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060609081121.002572642@localhost.localdomain>
References: <20060609080801.741901069@localhost.localdomain>
Date: Fri, 09 Jun 2006 16:08:06 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 5/5] readahead: remove size limit on read_ahead_kb
Content-Disposition: inline; filename=readahead-max-kb-sysfs-simplify.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the unnecessary size limit on setting read_ahead_kb.

Also make possible large values harmless. The stock readahead
is protected by always consulting the avaiable memory before
applying this number. Other readahead paths have already did so.

read_ahead_kb used to be guarded by the queue's max_sectors,
which can be too rigid because some devices set max_sectors to
small values like 64kb. That leads to many user complains.

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 block/ll_rw_blk.c |    5 -----
 1 files changed, 5 deletions(-)

--- linux-2.6.17-rc6-mm1.orig/block/ll_rw_blk.c
+++ linux-2.6.17-rc6-mm1/block/ll_rw_blk.c
@@ -3810,12 +3810,7 @@ queue_ra_store(struct request_queue *q, 
 	unsigned long ra_kb;
 	ssize_t ret = queue_var_store(&ra_kb, page, count);
 
-	spin_lock_irq(q->queue_lock);
-	if (ra_kb > (q->max_sectors >> 1))
-		ra_kb = (q->max_sectors >> 1);
-
 	q->backing_dev_info.ra_pages = ra_kb >> (PAGE_CACHE_SHIFT - 10);
-	spin_unlock_irq(q->queue_lock);
 
 	return ret;
 }
--- linux-2.6.17-rc6-mm1.orig/mm/readahead.c
+++ linux-2.6.17-rc6-mm1/mm/readahead.c
@@ -156,7 +156,7 @@ EXPORT_SYMBOL_GPL(file_ra_state_init);
  */
 static inline unsigned long get_max_readahead(struct file_ra_state *ra)
 {
-	return ra->ra_pages;
+	return max_sane_readahead(ra->ra_pages);
 }
 
 static inline unsigned long get_min_readahead(struct file_ra_state *ra)

--
