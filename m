Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbVBYRPX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbVBYRPX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Feb 2005 12:15:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262757AbVBYRPX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Feb 2005 12:15:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:32435 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262755AbVBYRNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Feb 2005 12:13:16 -0500
Subject: Re: [PATCH] Fix panic in 2.6 with bounced bio and dm
From: Mark Haverkamp <markh@osdl.org>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1109351021.5014.10.camel@markh1.pdx.osdl.net>
References: <1109351021.5014.10.camel@markh1.pdx.osdl.net>
Content-Type: text/plain
Date: Fri, 25 Feb 2005 09:13:12 -0800
Message-Id: <1109351592.5014.13.camel@markh1.pdx.osdl.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-02-25 at 09:03 -0800, Mark Haverkamp wrote:
> Last September a fix was checked in for a memory leak problem in
> bounce_end_io causing the entire bio to be checked.  This ended up
> causing some dm cloned bios that had bounce buffers to free NULL pages
> because their bi_idx can be non-zero.   This patch skips NULL pages in
> the bio's bio_vec.  I'm not sure if this is the most optimal fix but I
> think that it is safe since bvec_alloc memsets the bio_vec to zero.
> 
> Mark.

I forgot a signed-off-by

Signed-off-by Mark Haverkamp <markh@osdl.org>


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

