Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267167AbSKTBVq>; Tue, 19 Nov 2002 20:21:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267276AbSKTBVq>; Tue, 19 Nov 2002 20:21:46 -0500
Received: from mtl.slowbone.net ([213.237.73.175]:24449 "EHLO
	leeloo.slowbone.net") by vger.kernel.org with ESMTP
	id <S267167AbSKTBVp>; Tue, 19 Nov 2002 20:21:45 -0500
Message-ID: <3DDAE54F.4010808@slowbone.net>
Date: Wed, 20 Nov 2002 02:28:47 +0100
From: =?ISO-8859-1?Q?Thorbj=F8rn_Lind?= <mtl@slowbone.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: [patch] 2.5.48-bk, md raid0 fix
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the 'BUG at drivers/block/ll_rw_blk.c:19xx' when using raid0 md devices since 2.5.45...

/tul

--- a/drivers/md/raid0.c	2002-11-18 05:29:46.000000000 +0100
+++ b/drivers/md/raid0.c	2002-11-20 01:12:08.000000000 +0100
@@ -173,15 +173,14 @@
  static int raid0_mergeable_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *biovec)
  {
  	mddev_t *mddev = q->queuedata;
-	sector_t block;
-	unsigned int chunk_size;
-	unsigned int bio_sz;
-
-	chunk_size = mddev->chunk_size >> 10;
-	block = bio->bi_sector >> 1;
-	bio_sz = (bio->bi_size + biovec->bv_len) >> 10;
-
-	return (chunk_size - ((block & (chunk_size - 1)) + bio_sz)) << 10;
+	unsigned int max_size;
+
+	max_size = mddev->chunk_size - ((bio->bi_sector % (mddev->chunk_size >> 9)) << 9);
+
+	if(biovec->bv_len <= (max_size - bio->bi_size))
+	    return biovec->bv_len;
+
+	return max_size - bio->bi_size;
  }

  static int raid0_run (mddev_t *mddev)

