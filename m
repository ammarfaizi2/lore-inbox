Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264387AbTEGXcw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 19:32:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264199AbTEGXbR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 19:31:17 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:41382 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S264312AbTEGXaa
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 19:30:30 -0400
Date: Thu, 8 May 2003 01:42:34 +0200 (MET DST)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Dave Peterson <dsp@llnl.gov>
cc: <linux-kernel@vger.kernel.org>, <axboe@suse.de>, <davej@suse.de>
Subject: Re: [PATCH] fixes for linked list bugs in block I/O code
In-Reply-To: <200305071622.36352.dsp@llnl.gov>
Message-ID: <Pine.SOL.4.30.0305080133020.5113-100000@mion.elka.pw.edu.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 7 May 2003, Dave Peterson wrote:

> I found a couple of small linked list bugs in __make_request() in
> drivers/block/ll_rw_blk.c.  The bugs exist in both kernels
> 2.4.20 and 2.5.69.  Therefore I have made patches for both
> kernels.  The problem is that when inserting a new buffer_head
> into the linked list of buffer_head structures maintained by
> "struct request", the b_reqnext field is not initialized.
>
> -Dave Peterson
>  dsp@llnl.gov
>
>
> ========== START OF 2.4.20 PATCH FOR drivers/block/ll_rw_blk.c ===========
> --- ll_rw_blk.c.old     Wed May  7 15:54:58 2003
> +++ ll_rw_blk.c.new     Wed May  7 15:58:07 2003
> @@ -973,6 +973,7 @@
>                                 insert_here = &req->queue;
>                                 break;
>                         }
> +                       bh->b_reqnext = req->bhtail->b_reqnext;
>                         req->bhtail->b_reqnext = bh;
>                         req->bhtail = bh;
>                         req->nr_sectors = req->hard_nr_sectors += count;
> @@ -1061,6 +1062,7 @@
>         req->waiting = NULL;
>         req->bh = bh;
>         req->bhtail = bh;
> +       bh->b_reqnext = NULL;
>         req->rq_dev = bh->b_rdev;
>         req->start_time = jiffies;
>         req_new_io(req, 0, count);
> ========== END OF 2.4.20 PATCH FOR drivers/block/ll_rw_blk.c =============
>
>
> ========== START OF 2.5.69 PATCH FOR drivers/block/ll_rw_blk.c ===========
> --- ll_rw_blk.c.old     Wed May  7 15:55:18 2003
> +++ ll_rw_blk.c.new     Wed May  7 16:01:56 2003
> @@ -1721,6 +1721,7 @@
>                                 break;
>                         }
>
> +                       bio->bi_next = req->biotail->bi_next;

This is simply wrong, look at the line below.

>                         req->biotail->bi_next = bio;

req->bio - first bio
req->bio->bi_next - next bio
...
req->biotail - last bio

so req->biotail->bi_next should be NULL

>                         req->biotail = bio;
>                         req->nr_sectors = req->hard_nr_sectors += nr_sectors;
> @@ -1811,6 +1812,7 @@
>         req->buffer = bio_data(bio);    /* see ->buffer comment above */
>         req->waiting = NULL;
>         req->bio = req->biotail = bio;
> +       bio->bi_next = NULL;

No need for that, look at bio_init() in fs/bio.c.

>         req->rq_disk = bio->bi_bdev->bd_disk;
>         req->start_time = jiffies;
>         add_request(q, req, insert_here);
> ========== END OF 2.5.69 PATCH FOR drivers/block/ll_rw_blk.c =============

--
Bartlomiej

