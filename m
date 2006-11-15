Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966552AbWKOHxo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966552AbWKOHxo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Nov 2006 02:53:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966439AbWKOHvB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Nov 2006 02:51:01 -0500
Received: from smtp.ustc.edu.cn ([202.38.64.16]:16078 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S966400AbWKOHul (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Nov 2006 02:50:41 -0500
Message-ID: <363577026.23099@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20061115075029.519507130@localhost.localdomain>
References: <20061115075007.832957580@localhost.localdomain>
Date: Wed, 15 Nov 2006 15:50:23 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 16/28] readahead: initial method - guiding sizes
Content-Disposition: inline; filename=readahead-initial-method-guiding-sizes.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce three guiding sizes for the initial readahead method.
	- ra_pages0:	   min readahead on start-of-file
	- ra_thrash_bytes: estimated thrashing threshold

ra_thrash_bytes defaults to large value:
	- most systems don't have the danger of thrashing
	- it increases slowly and drops rapidly

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
Signed-off-by: Andrew Morton <akpm@osdl.org>
--- linux-2.6.19-rc5-mm2.orig/include/linux/backing-dev.h
+++ linux-2.6.19-rc5-mm2/include/linux/backing-dev.h
@@ -26,6 +26,8 @@ typedef int (congested_fn)(void *, int);
 
 struct backing_dev_info {
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
+	unsigned long ra_pages0; /* min readahead on start of file */
+	unsigned long ra_thrash_bytes;	/* estimated thrashing threshold */
 	unsigned long state;	/* Always use atomic bitops on this */
 	unsigned int capabilities; /* Device capabilities */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
--- linux-2.6.19-rc5-mm2.orig/mm/readahead.c
+++ linux-2.6.19-rc5-mm2/mm/readahead.c
@@ -32,6 +32,9 @@
  * Adaptive read-ahead parameters.
  */
 
+/* Default initial read-ahead size. */
+#define INITIAL_RA_PAGES  DIV_ROUND_UP(64*1024, PAGE_CACHE_SIZE)
+
 /* In laptop mode, poll delayed look-ahead on every ## pages read. */
 #define LAPTOP_POLL_INTERVAL 16
 
@@ -114,6 +117,8 @@ EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
 	.ra_pages	= MAX_RA_PAGES,
+	.ra_pages0	= INITIAL_RA_PAGES,
+	.ra_thrash_bytes = MAX_RA_PAGES * PAGE_CACHE_SIZE,
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
--- linux-2.6.19-rc5-mm2.orig/block/ll_rw_blk.c
+++ linux-2.6.19-rc5-mm2/block/ll_rw_blk.c
@@ -214,9 +214,6 @@ void blk_queue_make_request(request_queu
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
 	q->make_request_fn = mfn;
-	q->backing_dev_info.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
-	q->backing_dev_info.state = 0;
-	q->backing_dev_info.capabilities = BDI_CAP_MAP_COPY;
 	blk_queue_max_sectors(q, SAFE_MAX_SECTORS);
 	blk_queue_hardsect_size(q, 512);
 	blk_queue_dma_alignment(q, 511);
@@ -1848,6 +1845,7 @@ request_queue_t *blk_alloc_queue_node(gf
 	q->kobj.ktype = &queue_ktype;
 	kobject_init(&q->kobj);
 
+	q->backing_dev_info = default_backing_dev_info;
 	q->backing_dev_info.unplug_io_fn = blk_backing_dev_unplug;
 	q->backing_dev_info.unplug_io_data = q;
 

--
