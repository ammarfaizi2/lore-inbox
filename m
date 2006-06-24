Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933322AbWFXIXZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933322AbWFXIXZ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 24 Jun 2006 04:23:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933321AbWFXIXM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 24 Jun 2006 04:23:12 -0400
Received: from smtp.ustc.edu.cn ([202.38.64.16]:41174 "HELO ustc.edu.cn")
	by vger.kernel.org with SMTP id S1752205AbWFXIXF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 24 Jun 2006 04:23:05 -0400
Message-ID: <351137382.24594@ustc.edu.cn>
X-EYOUMAIL-SMTPAUTH: wfg@mail.ustc.edu.cn
Message-Id: <20060624082311.501730089@localhost.localdomain>
References: <20060624082006.574472632@localhost.localdomain>
Date: Sat, 24 Jun 2006 16:20:10 +0800
From: Fengguang Wu <wfg@mail.ustc.edu.cn>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>,
       Nick Piggin <nickpiggin@yahoo.com.au>, Lubos Lunak <l.lunak@suse.cz>,
       Wu Fengguang <wfg@mail.ustc.edu.cn>
Subject: [PATCH 4/7] iosched: submit READA requests on possible readahead code path
Content-Disposition: inline; filename=iosched-submit-reada-on-possible-readahead-path.patch
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Change the request type from READ to READA in possible readahead code paths.

- call mpage_bio_submit(READA) in mpage_readpages()
- call submit_bio(READA) in swap_readpage()

Signed-off-by: Wu Fengguang <wfg@mail.ustc.edu.cn>
---


 fs/mpage.c |   12 ++++++------
 1 files changed, 6 insertions(+), 6 deletions(-)

--- linux-2.6.17-mm1.orig/fs/mpage.c
+++ linux-2.6.17-mm1/fs/mpage.c
@@ -302,7 +302,7 @@ do_mpage_readpage(struct bio *bio, struc
 	 * This page will go to BIO.  Do we need to send this BIO off first?
 	 */
 	if (bio && (*last_block_in_bio != blocks[0] - 1))
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(READA, bio);
 
 alloc_new:
 	if (bio == NULL) {
@@ -315,12 +315,12 @@ alloc_new:
 
 	length = first_hole << blkbits;
 	if (bio_add_page(bio, page, length, 0) < length) {
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(READA, bio);
 		goto alloc_new;
 	}
 
 	if (buffer_boundary(map_bh) || (first_hole != blocks_per_page))
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(READA, bio);
 	else
 		*last_block_in_bio = blocks[blocks_per_page - 1];
 out:
@@ -328,7 +328,7 @@ out:
 
 confused:
 	if (bio)
-		bio = mpage_bio_submit(READ, bio);
+		bio = mpage_bio_submit(READA, bio);
 	if (!PageUptodate(page))
 	        block_read_full_page(page, get_block);
 	else
@@ -418,7 +418,7 @@ mpage_readpages(struct address_space *ma
 	pagevec_lru_add(&lru_pvec);
 	BUG_ON(!list_empty(pages));
 	if (bio)
-		mpage_bio_submit(READ, bio);
+		mpage_bio_submit(READA, bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpages);
@@ -437,7 +437,7 @@ int mpage_readpage(struct page *page, ge
 	bio = do_mpage_readpage(bio, page, 1, &last_block_in_bio,
 			&map_bh, &first_logical_block, get_block);
 	if (bio)
-		mpage_bio_submit(READ, bio);
+		mpage_bio_submit(READA, bio);
 	return 0;
 }
 EXPORT_SYMBOL(mpage_readpage);
--- linux-2.6.17-mm1.orig/mm/page_io.c
+++ linux-2.6.17-mm1/mm/page_io.c
@@ -124,7 +124,7 @@ int swap_readpage(struct file *file, str
 		goto out;
 	}
 	inc_page_state(pswpin);
-	submit_bio(READ, bio);
+	submit_bio(READA, bio);
 out:
 	return ret;
 }

--
