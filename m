Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262195AbTKTVgo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Nov 2003 16:36:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262458AbTKTVgo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Nov 2003 16:36:44 -0500
Received: from fw.osdl.org ([65.172.181.6]:24200 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262195AbTKTVgm (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Nov 2003 16:36:42 -0500
Subject: [PATCH] dm and bounce buffer panic on 2.6
From: Mark Haverkamp <markh@osdl.org>
To: linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Message-Id: <1069364201.22620.62.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.4 
Date: Thu, 20 Nov 2003 13:36:41 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

About three weeks ago markw at osdl posted a mail about a panic that he
was seeing:
  
http://marc.theaimsgroup.com/?l=linux-kernel&m=106737176716474&w=2

I believe what is happening, is that the dm __clone_and_map function is
generating bio structures  with the bi_idx field non-zero. When
__blk_queue_bounce creates a new bio with bounce pages, it sets the
bi_idx field to 0 rather than the bi_idx of the original.  This causes
trouble since bv_page pointers will be dereferenced later that are
zero.  The following uses the original bio structure's bi_idx in the new
bio structure and in copy_to_high_bio_irq and bounce_end_io.

This has cleared up the panic when using the volume.

===== highmem.c 1.46 vs edited =====
--- 1.46/mm/highmem.c	Tue Oct  7 19:53:43 2003
+++ edited/highmem.c	Thu Nov 20 11:10:19 2003
@@ -285,7 +285,7 @@
 	struct bio_vec *tovec, *fromvec;
 	int i;
 
-	__bio_for_each_segment(tovec, to, i, 0) {
+	bio_for_each_segment(tovec, to, i) {
 		fromvec = from->bi_io_vec + i;
 
 		/*
@@ -314,7 +314,7 @@
 	/*
 	 * free up bounce indirect pages used
 	 */
-	__bio_for_each_segment(bvec, bio, i, 0) {
+	bio_for_each_segment(bvec, bio, i) {
 		org_vec = bio_orig->bi_io_vec + i;
 		if (bvec->bv_page == org_vec->bv_page)
 			continue;
@@ -437,7 +437,7 @@
 	bio->bi_rw = (*bio_orig)->bi_rw;
 
 	bio->bi_vcnt = (*bio_orig)->bi_vcnt;
-	bio->bi_idx = 0;
+	bio->bi_idx = (*bio_orig)->bi_idx;
 	bio->bi_size = (*bio_orig)->bi_size;
 
 	if (pool == page_pool) {

-- 
Mark Haverkamp <markh@osdl.org>

