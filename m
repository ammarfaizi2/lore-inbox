Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267785AbTAHJyC>; Wed, 8 Jan 2003 04:54:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267794AbTAHJxO>; Wed, 8 Jan 2003 04:53:14 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:57351 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267785AbTAHJwa>; Wed, 8 Jan 2003 04:52:30 -0500
Date: Wed, 8 Jan 2003 10:00:42 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Linux Mailing List <linux-kernel@vger.kernel.org>
Subject: [PATCH 10/10] dm: Remove redundant error checking
Message-ID: <20030108100042.GK2063@reti>
References: <20030108095221.GA2063@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030108095221.GA2063@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

bio_alloc() shouldn't fail if GFP_NOIO is used, and the bvec count is
sensible.  So remove redundant error checking.
--- diff/drivers/md/dm.c	2003-01-02 11:10:22.000000000 +0000
+++ source/drivers/md/dm.c	2003-01-02 11:27:23.000000000 +0000
@@ -347,18 +347,15 @@
 	struct bio_vec *bv = bio->bi_io_vec + idx;
 
 	clone = bio_alloc(GFP_NOIO, 1);
+	memcpy(clone->bi_io_vec, bv, sizeof(*bv));
 
-	if (clone) {
-		memcpy(clone->bi_io_vec, bv, sizeof(*bv));
-
-		clone->bi_sector = sector;
-		clone->bi_bdev = bio->bi_bdev;
-		clone->bi_rw = bio->bi_rw;
-		clone->bi_vcnt = 1;
-		clone->bi_size = to_bytes(len);
-		clone->bi_io_vec->bv_offset = offset;
-		clone->bi_io_vec->bv_len = clone->bi_size;
-	}
+	clone->bi_sector = sector;
+	clone->bi_bdev = bio->bi_bdev;
+	clone->bi_rw = bio->bi_rw;
+	clone->bi_vcnt = 1;
+	clone->bi_size = to_bytes(len);
+	clone->bi_io_vec->bv_offset = offset;
+	clone->bi_io_vec->bv_len = clone->bi_size;
 
 	return clone;
 }
@@ -432,11 +429,6 @@
 
 		clone = split_bvec(bio, ci->sector, ci->idx,
 				   bv->bv_offset, max);
-		if (!clone) {
-			dec_pending(ci->io, -ENOMEM);
-			return;
-		}
-
 		__map_bio(ti, clone, ci->io);
 
 		ci->sector += max;
@@ -446,11 +438,6 @@
 		len = to_sector(bv->bv_len) - max;
 		clone = split_bvec(bio, ci->sector, ci->idx,
 				   bv->bv_offset + to_bytes(max), len);
-		if (!clone) {
-			dec_pending(ci->io, -ENOMEM);
-			return;
-		}
-
 		__map_bio(ti, clone, ci->io);
 
 		ci->sector += len;
