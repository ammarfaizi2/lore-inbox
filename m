Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262744AbVBYREC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262744AbVBYREC (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:04:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262750AbVBYREC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:04:02 -0500
Received: from fire.osdl.org ([65.172.181.4]:63664 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262744AbVBYRDs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:03:48 -0500
Subject: [PATCH] Fix panic in 2.6 with bounced bio and dm
From: Mark Haverkamp <markh@osdl.org>
To: Jens Axboe <axboe@suse.de>, linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 09:03:41 -0800
Message-Id: <1109351021.5014.10.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Last September a fix was checked in for a memory leak problem in
bounce_end_io causing the entire bio to be checked.  This ended up
causing some dm cloned bios that had bounce buffers to free NULL pages
because their bi_idx can be non-zero.   This patch skips NULL pages in
the bio's bio_vec.  I'm not sure if this is the most optimal fix but I
think that it is safe since bvec_alloc memsets the bio_vec to zero.

Mark.

===== mm/highmem.c 1.55 vs edited =====
--- 1.55/mm/highmem.c	2005-01-07 21:44:13 -08:00
+++ edited/mm/highmem.c	2005-02-25 07:54:21 -08:00
@@ -319,7 +319,7 @@
 	 */
 	__bio_for_each_segment(bvec, bio, i, 0) {
 		org_vec = bio_orig->bi_io_vec + i;
-		if (bvec->bv_page == org_vec->bv_page)
+		if (!bvec->bv_page || bvec->bv_page == org_vec->bv_page)
 			continue;
 
 		mempool_free(bvec->bv_page, pool);	

-- 
Mark Haverkamp <markh@osdl.org>

