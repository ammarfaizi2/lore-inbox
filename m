Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265815AbSKTGSy>; Wed, 20 Nov 2002 01:18:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265816AbSKTGSy>; Wed, 20 Nov 2002 01:18:54 -0500
Received: from mtl.slowbone.net ([213.237.73.175]:1408 "EHLO
	leeloo.slowbone.net") by vger.kernel.org with ESMTP
	id <S265815AbSKTGSx>; Wed, 20 Nov 2002 01:18:53 -0500
Message-ID: <003e01c2905d$b413a5e0$0201a8c0@mtl>
From: =?iso-8859-1?Q?Thorbj=F8rn_Lind?= <mtl@slowbone.net>
To: <linux-kernel@vger.kernel.org>
References: <15835.5488.59408.747895@wombat.chubb.wattle.id.au>
Subject: Re: [patch] 2.5.48-bk, md raid0 fix
Date: Wed, 20 Nov 2002 07:26:04 +0100
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2600.0000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Are you not using power-of-two sized chunks?  If not, use the
Yes

> You could try ... (untested)
> - return (chunk_size - ((block & (chunk_size - 1)) + bio_sz)) << 10;
> + return (chunk_size - (sector_div(block, chunk_size) + bio_sz)) << 10;

No good either.. not many using raid0 I guess :)

... here is what happenes with either of the above.

raid0_mergeable: chunk_size 32768 bi_sector 524288, bi_size 0, bv_len 4096, ret 28672
raid0_mergeable: chunk_size 32768 bi_sector 100401152, bi_size 0, bv_len 4096, ret 28672
raid0_mergeable: chunk_size 32768 bi_sector 96, bi_size 0, bv_len 4096, ret 12288
raid0_mergeable: chunk_size 32768 bi_sector 4216, bi_size 0, bv_len 4096, ret 0
kernel BUG at drivers/block/ll_rw_blk.c:1995!
invalid operand: 0000

Should it really return 0 when we are actually ready to recieve that 4k request? That is.. should it
return how much can be merged or how much it can take after the merge. The first seems to work.
That would be something like:

--- a/drivers/md/raid0.c        2002-11-18 05:29:46.000000000 +0100
+++ b/drivers/md/raid0.c        2002-11-20 07:19:15.000000000 +0100
@@ -173,15 +173,10 @@
 static int raid0_mergeable_bvec(request_queue_t *q, struct bio *bio, struct bio_vec *biovec)
 {
        mddev_t *mddev = q->queuedata;
-       sector_t block;
-       unsigned int chunk_size;
-       unsigned int bio_sz;
+       unsigned int chunk_sects = mddev->chunk_size >> 9;
+       unsigned int max_sectors = chunk_sects - (bio->bi_sector % chunk_sects);

-       chunk_size = mddev->chunk_size >> 10;
-       block = bio->bi_sector >> 1;
-       bio_sz = (bio->bi_size + biovec->bv_len) >> 10;
-
-       return (chunk_size - ((block & (chunk_size - 1)) + bio_sz)) << 10;
+       return (max_sectors - (bio->bi_size >> 9)) << 9;
 }

 static int raid0_run (mddev_t *mddev)



