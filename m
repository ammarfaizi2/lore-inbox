Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932708AbWEXLVz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932708AbWEXLVz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 07:21:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932719AbWEXLTs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 07:19:48 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:34689 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S932709AbWEXLTN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 07:19:13 -0400
Message-ID: <348469545.17438@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060524111906.245276338@localhost.localdomain>
References: <20060524111246.420010595@localhost.localdomain>
Date: Wed, 24 May 2006 19:13:04 +0800
From: Wu Fengguang <wfg@mail.ustc.edu.cn>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 18/33] readahead: initial method - guiding sizes
Content-Disposition: inline; filename=readahead-method-initial-sizes.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Introduce three guiding sizes for the initial readahead method.
	- ra_pages0:	   recommended readahead on start-of-file
	- ra_expect_bytes: expected read size on start-of-file
	- ra_thrash_bytes: estimated thrashing threshold

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 block/ll_rw_blk.c           |    4 +---
 include/linux/backing-dev.h |    3 +++
 mm/readahead.c              |    3 +++
 3 files changed, 7 insertions(+), 3 deletions(-)

--- linux-2.6.17-rc4-mm3.orig/include/linux/backing-dev.h
+++ linux-2.6.17-rc4-mm3/include/linux/backing-dev.h
@@ -24,6 +24,9 @@ typedef int (congested_fn)(void *, int);
 
 struct backing_dev_info {
 	unsigned long ra_pages;	/* max readahead in PAGE_CACHE_SIZE units */
+	unsigned long ra_pages0; /* recommended readahead on start of file */
+	unsigned long ra_expect_bytes;	/* expected read size on start of file */
+	unsigned long ra_thrash_bytes;	/* thrashing threshold */
 	unsigned long state;	/* Always use atomic bitops on this */
 	unsigned int capabilities; /* Device capabilities */
 	congested_fn *congested_fn; /* Function pointer if device is md/dm */
--- linux-2.6.17-rc4-mm3.orig/mm/readahead.c
+++ linux-2.6.17-rc4-mm3/mm/readahead.c
@@ -122,6 +122,9 @@ EXPORT_SYMBOL(default_unplug_io_fn);
 
 struct backing_dev_info default_backing_dev_info = {
 	.ra_pages	= PAGES_KB(VM_MAX_READAHEAD),
+	.ra_pages0	= PAGES_KB(128),
+	.ra_expect_bytes = 1024 * VM_MIN_READAHEAD,
+	.ra_thrash_bytes = 1024 * VM_MIN_READAHEAD,
 	.state		= 0,
 	.capabilities	= BDI_CAP_MAP_COPY,
 	.unplug_io_fn	= default_unplug_io_fn,
--- linux-2.6.17-rc4-mm3.orig/block/ll_rw_blk.c
+++ linux-2.6.17-rc4-mm3/block/ll_rw_blk.c
@@ -249,9 +249,6 @@ void blk_queue_make_request(request_queu
 	blk_queue_max_phys_segments(q, MAX_PHYS_SEGMENTS);
 	blk_queue_max_hw_segments(q, MAX_HW_SEGMENTS);
 	q->make_request_fn = mfn;
-	q->backing_dev_info.ra_pages = (VM_MAX_READAHEAD * 1024) / PAGE_CACHE_SIZE;
-	q->backing_dev_info.state = 0;
-	q->backing_dev_info.capabilities = BDI_CAP_MAP_COPY;
 	blk_queue_max_sectors(q, SAFE_MAX_SECTORS);
 	blk_queue_hardsect_size(q, 512);
 	blk_queue_dma_alignment(q, 511);
@@ -1850,6 +1847,7 @@ request_queue_t *blk_alloc_queue_node(gf
 	q->kobj.ktype = &queue_ktype;
 	kobject_init(&q->kobj);
 
+	q->backing_dev_info = default_backing_dev_info;
 	q->backing_dev_info.unplug_io_fn = blk_backing_dev_unplug;
 	q->backing_dev_info.unplug_io_data = q;
 

--
