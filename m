Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269374AbUIIInZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269374AbUIIInZ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 04:43:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269376AbUIIInZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 04:43:25 -0400
Received: from ns.virtualhost.dk ([195.184.98.160]:51635 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S269374AbUIIInV (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 04:43:21 -0400
Date: Thu, 9 Sep 2004 10:42:04 +0200
From: Jens Axboe <axboe@suse.de>
To: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH] fix leak with bounced bio's
Message-ID: <20040909084204.GO1737@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This might fix the last leak of memory reported with cd writing, the
current highmem bounce code will leak n-1 pages for any n page bio where
n > 1. CD writing typically uses 16 pages bios, so it is affected.

===== mm/highmem.c 1.51 vs edited =====
--- 1.51/mm/highmem.c	2004-07-29 06:58:32 +02:00
+++ edited/mm/highmem.c	2004-09-08 21:18:57 +02:00
@@ -284,7 +284,7 @@
 	struct bio_vec *tovec, *fromvec;
 	int i;
 
-	bio_for_each_segment(tovec, to, i) {
+	__bio_for_each_segment(tovec, to, i, 0) {
 		fromvec = from->bi_io_vec + i;
 
 		/*
@@ -316,7 +316,7 @@
 	/*
 	 * free up bounce indirect pages used
 	 */
-	bio_for_each_segment(bvec, bio, i) {
+	__bio_for_each_segment(bvec, bio, i, 0) {
 		org_vec = bio_orig->bi_io_vec + i;
 		if (bvec->bv_page == org_vec->bv_page)
 			continue;

-- 
Jens Axboe

