Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268100AbUJJDz3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268100AbUJJDz3 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 9 Oct 2004 23:55:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268101AbUJJDz3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 9 Oct 2004 23:55:29 -0400
Received: from [61.48.52.223] ([61.48.52.223]:20966 "EHLO freya.yggdrasil.com")
	by vger.kernel.org with ESMTP id S268100AbUJJDzZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 9 Oct 2004 23:55:25 -0400
Date: Sun, 10 Oct 2004 11:50:04 -0700
From: "Adam J. Richter" <adam@yggdrasil.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org, dm-crypt@saout.de
Subject: [PATCH?] make __bio_add_page check q->max_hw_sectors
Message-ID: <20041010115004.A5282@freya>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	On an dm-crypt partiton on an IDE disk, 2.6.9-rc3 and
2.6.9-rc3-bk9 repeatedly generate the following error, which
does not occur in 2.6.9-rc1:

	bio too big for device dm-0 (256 > 255)

	The stack trace looked something like this:

submit_bio
mpage_bio_submit
mpage_readpages
readpages
do_page_cache_readahead
filemap_nopage
do_no_page
handle_mm_fault

	Around 2.6.9-rc3, a new field q->max_hw_sectors was
added to struct request_queue.  I was able to make this
problem disappear by the following patch, which adds a
check of this new field to __bio_add_page.  (I've edited
this patch to hide other differences in my fs/bio.c, so
it may be necessary to apply it by hand if patch fails.)

	I do not understand the intended difference between
the new max_hw_sectors field and max_sectors, so it is unclear
to me if it is a bug that my dm-crypt request_queue has
q->max_hw_sectors < q->max_sectors.  If q->max_hw_sectors
is supposed to be guaranteed to be greater than or equal
to q->max_sectors, then the real bug is elsewhere and my
patch is unnecessary.

	I am cc'ing the dm-crypt mailing list, since I
suspect that dm-crypt users who are running on a disk
partition (as opposed to a file via a loop device) and who
upgrade to 2.6.9-rc3 or later are effected and I think the
bug could result in file system corruption.  However, I've
only observed this problem in a harmless readahead situation.

-- 
                    __     ______________ 
Adam J. Richter        \ /
adam@yggdrasil.com      | g g d r a s i l


Index: linux/fs/bio.c
===================================================================
RCS file: /usr/src.repository/repository/linux/fs/bio.c,v
retrieving revision 1.19
diff -u -1 -8 -r1.19 bio.c
--- linux/fs/bio.c	2004/10/09 18:16:58	1.19
+++ linux/fs/bio.c	2004/10/10 18:18:36
@@ -289,36 +289,39 @@
 static int __bio_add_page(request_queue_t *q, struct bio *bio, struct page
 			  *page, unsigned int len, unsigned int offset)
 {
 	int retried_segments = 0;
 	struct bio_vec *bvec;
 
 	/*
 	 * cloned bio must not modify vec list
 	 */
 	if (unlikely(bio_flagged(bio, BIO_CLONED)))
 		return 0;
 
 	if (bio->bi_vcnt >= bio->bi_max_vecs)
 		return 0;
 
 	if (((bio->bi_size + len) >> 9) > q->max_sectors)
 		return 0;
 
+	if (((bio->bi_size + len) >> 9) > q->max_hw_sectors)
+		return 0;
+
 	/*
 	 * we might lose a segment or two here, but rather that than
 	 * make this too complex.
 	 */
 
 	while (bio->bi_phys_segments >= q->max_phys_segments
 	       || bio->bi_hw_segments >= q->max_hw_segments
 	       || BIOVEC_VIRT_OVERSIZE(bio->bi_size)) {
 
 		if (retried_segments)
 			return 0;
 
 		retried_segments = 1;
 		blk_recount_segments(q, bio);
 	}
 
 	/*
 	 * setup the new entry, we might clear it again later if we
