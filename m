Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266701AbSLPKJQ>; Mon, 16 Dec 2002 05:09:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266665AbSLPKHw>; Mon, 16 Dec 2002 05:07:52 -0500
Received: from cmailg2.svr.pol.co.uk ([195.92.195.172]:21004 "EHLO
	cmailg2.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S266701AbSLPKHf>; Mon, 16 Dec 2002 05:07:35 -0500
Date: Mon, 16 Dec 2002 10:15:39 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: 14/19
Message-ID: <20021216101539.GO7407@reti>
References: <20021211121749.GA20782@reti> <Pine.LNX.4.44.0212151649180.2445-100000@home.transmeta.com> <20021216100457.GA7407@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021216100457.GA7407@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some fields in the duplicated bio weren't being set up properly in
__split_page(). [Kevin Corry]
--- diff/drivers/md/dm.c	2002-12-16 09:41:21.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-16 09:41:25.000000000 +0000
@@ -337,7 +337,7 @@
 {
 	struct dm_target *ti = dm_table_find_target(ci->md->map, ci->sector);
 	struct bio *clone, *bio = ci->bio;
-	struct bio_vec *bv = bio->bi_io_vec + (bio->bi_vcnt - 1);
+	struct bio_vec *bv = bio->bi_io_vec + ci->idx;
 
 	DMWARN("splitting page");
 
@@ -349,11 +349,13 @@
 
 	clone->bi_sector = ci->sector;
 	clone->bi_bdev = bio->bi_bdev;
-	clone->bi_flags = bio->bi_flags | (1 << BIO_SEG_VALID);
 	clone->bi_rw = bio->bi_rw;
+	clone->bi_vcnt = 1;
 	clone->bi_size = len << SECTOR_SHIFT;
 	clone->bi_end_io = clone_endio;
 	clone->bi_private = ci->io;
+	clone->bi_io_vec->bv_offset = bv->bv_len - clone->bi_size;
+	clone->bi_io_vec->bv_len = clone->bi_size;
 
 	ci->sector += len;
 	ci->sector_count -= len;
