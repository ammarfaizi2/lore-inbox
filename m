Return-Path: <linux-kernel-owner+willy=40w.ods.org-S966119AbWKJVti@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966119AbWKJVti (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 16:49:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S966120AbWKJVti
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 16:49:38 -0500
Received: from rgminet01.oracle.com ([148.87.113.118]:42225 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S966119AbWKJVth (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 16:49:37 -0500
Date: Fri, 10 Nov 2006 16:49:38 -0500
From: Chris Mason <chris.mason@oracle.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, dgc@sgi.com
Subject: Re: [PATCH] avoid too many boundaries in DIO
Message-ID: <20061110214938.GT10889@think.oraclecorp.com>
References: <20061110014854.GS10889@think.oraclecorp.com> <20061109225618.1bdc634f.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20061109225618.1bdc634f.akpm@osdl.org>
User-Agent: Mutt/1.5.12-2006-07-14
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 09, 2006 at 10:56:18PM -0800, Andrew Morton wrote:
> > This patch just clears the boundary bit after using it once.  It is 10%
> > faster for a streaming DIO write w/blocksize of 512k on my sata drive.
> > 
> 
> Thanks.
> 
> But that's two large performance regressions (so far) from the multi-block
> get_block() feature.  And that was allegedly a performance optimisation! 
> Who's testing this stuff?

Well, I've been wearing the sata-drive-writeback-cache cape of shame
since Dave found the regression while testing my stuff, so I can't
really point fingers.  On some drives the regression didn't show up, but
it should be there on any beefy storage.

> Is that actually correct?  If ->get_block() returned a
> buffer_boundary() buffer then what we want to do is to push down all
> the thus-far-queued BIOs once we've submitted _all_ of the BIOs
> represented by map_bh.  I think that if we require more than one BIO
> to cover map_bh.b_size then we'll do the submission after the first
> BIO has been sent instead of after the final one has been sent?
> 
I realized the same thing this morning, but it took a while to figure
out why honoring the boundary on the last block was 5% slower than my
first patch.  It turns out that we consistently send down the boundary
bio too soon.

Testing of this has been very light, but I wanted to get it out for
review.  I'll test more over the weekend.

-chris

From: Chris Mason <chris.mason@oracle.com>
Subject: avoid too many boundaries in DIO

Dave Chinner found a 10% performance regression with ext3 when using DIO
to fill holes instead of buffered IO.  On large IOs, the ext3 get_block
routine will send more than a page worth of blocks back to DIO via a
single buffer_head with a large b_size value.

The DIO code iterates through this massive block and tests for a
boundary buffer over and over again.  For every block size unit spanned
by the big map_bh, the boundary bit is tested and a bio may be forced
down to the block layer.

This patch changes things to only submit the boundary bio for the
last block in the big map_bh.

The DIO code had a number of places that would honor dio->boundary
too early, sending the bio down before actually adding the boundary
block to it.  Those are also fixed.

Signed-off-by: Chris Mason <chris.mason@oracle.com>

diff -r 18a9e9f5c707 fs/direct-io.c
--- a/fs/direct-io.c	Thu Oct 19 08:30:00 2006 +0700
+++ b/fs/direct-io.c	Fri Nov 10 16:33:04 2006 -0500
@@ -572,7 +571,6 @@ static int dio_new_bio(struct dio *dio, 
 	nr_pages = min(dio->pages_in_io, bio_get_nr_vecs(dio->map_bh.b_bdev));
 	BUG_ON(nr_pages <= 0);
 	ret = dio_bio_alloc(dio, dio->map_bh.b_bdev, sector, nr_pages);
-	dio->boundary = 0;
 out:
 	return ret;
 }
@@ -626,12 +624,6 @@ static int dio_send_cur_page(struct dio 
 		 */
 		if (dio->final_block_in_bio != dio->cur_page_block)
 			dio_bio_submit(dio);
-		/*
-		 * Submit now if the underlying fs is about to perform a
-		 * metadata read
-		 */
-		if (dio->boundary)
-			dio_bio_submit(dio);
 	}
 
 	if (dio->bio == NULL) {
@@ -648,6 +640,12 @@ static int dio_send_cur_page(struct dio 
 			BUG_ON(ret != 0);
 		}
 	}
+	/*
+	 * Submit now if the underlying fs is about to perform a
+	 * metadata read
+	 */
+	if (dio->boundary)
+		dio_bio_submit(dio);
 out:
 	return ret;
 }
@@ -674,6 +672,10 @@ submit_page_section(struct dio *dio, str
 		unsigned offset, unsigned len, sector_t blocknr)
 {
 	int ret = 0;
+	int boundary = dio->boundary;
+
+	/* don't let dio_send_cur_page do the boundary too soon */
+	dio->boundary = 0;
 
 	/*
 	 * Can we just grow the current page's presence in the dio?
@@ -683,17 +683,7 @@ submit_page_section(struct dio *dio, str
 		(dio->cur_page_block +
 			(dio->cur_page_len >> dio->blkbits) == blocknr)) {
 		dio->cur_page_len += len;
-
-		/*
-		 * If dio->boundary then we want to schedule the IO now to
-		 * avoid metadata seeks.
-		 */
-		if (dio->boundary) {
-			ret = dio_send_cur_page(dio);
-			page_cache_release(dio->cur_page);
-			dio->cur_page = NULL;
-		}
-		goto out;
+		goto out_send;
 	}
 
 	/*
@@ -712,6 +702,18 @@ submit_page_section(struct dio *dio, str
 	dio->cur_page_offset = offset;
 	dio->cur_page_len = len;
 	dio->cur_page_block = blocknr;
+
+out_send:
+	/*
+	 * If dio->boundary then we want to schedule the IO now to
+	 * avoid metadata seeks.
+	 */
+	if (boundary) {
+		dio->boundary = 1;
+		ret = dio_send_cur_page(dio);
+		page_cache_release(dio->cur_page);
+		dio->cur_page = NULL;
+	}
 out:
 	return ret;
 }
@@ -917,7 +919,16 @@ do_holes:
 			this_chunk_bytes = this_chunk_blocks << blkbits;
 			BUG_ON(this_chunk_bytes == 0);
 
-			dio->boundary = buffer_boundary(map_bh);
+			/*
+			 * get_block may return more than one page worth
+			 * of blocks.  Make sure only the last io we
+			 * send down for this region is a boundary
+			 */
+			if (dio->blocks_available == this_chunk_blocks)
+				dio->boundary = buffer_boundary(map_bh);
+			else
+				dio->boundary = 0;
+
 			ret = submit_page_section(dio, page, offset_in_page,
 				this_chunk_bytes, dio->next_block_for_io);
 			if (ret) {
