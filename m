Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267131AbSLKMNC>; Wed, 11 Dec 2002 07:13:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267132AbSLKMNC>; Wed, 11 Dec 2002 07:13:02 -0500
Received: from cmailg4.svr.pol.co.uk ([195.92.195.174]:38156 "EHLO
	cmailg4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S267131AbSLKMM6>; Wed, 11 Dec 2002 07:12:58 -0500
Date: Wed, 11 Dec 2002 12:20:37 +0000
To: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Cc: Kevin Corry <corryk@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       lvm-devel@sistina.com
Subject: Re: [PATCH] dm.c  -  device-mapper I/O path fixes
Message-ID: <20021211122037.GD20782@reti>
References: <02121016034706.02220@boiler> <20021211121749.GA20782@reti>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20021211121749.GA20782@reti>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Some fields in the duplicated bio weren't being set up properly in
__split_page(). [Kevin Corry]

--- diff/drivers/md/dm.c	2002-12-11 12:00:39.000000000 +0000
+++ source/drivers/md/dm.c	2002-12-11 12:00:44.000000000 +0000
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
