Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263057AbTKCUwr (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Nov 2003 15:52:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263122AbTKCUwr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Nov 2003 15:52:47 -0500
Received: from arnor.apana.org.au ([203.14.152.115]:60681 "EHLO
	arnor.me.apana.org.au") by vger.kernel.org with ESMTP
	id S263057AbTKCUwp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Nov 2003 15:52:45 -0500
Date: Tue, 4 Nov 2003 07:52:34 +1100
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BIO] Bounce queue in bio_add_page
Message-ID: <20031103205234.GA17570@gondor.apana.org.au>
References: <20031101044619.GA15628@gondor.apana.org.au> <20031101100543.GA16682@gondor.apana.org.au> <20031103122500.GA6963@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
In-Reply-To: <20031103122500.GA6963@suse.de>
User-Agent: Mutt/1.5.4i
From: Herbert Xu <herbert@gondor.apana.org.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Nov 03, 2003 at 01:25:00PM +0100, Jens Axboe wrote:
> 
> I think the best fix would be to simply not allow more than one page
> that needs to be bounced to a bio. The problem is that the whole bio and

Here is an alternative solution, what if we simply disregarded high
pages when doing the recount?  Something like this,
-- 
Debian GNU/Linux 3.0 is out! ( http://www.debian.org/ )
Email:  Herbert Xu ~{PmV>HI~} <herbert@gondor.apana.org.au>
Home Page: http://gondor.apana.org.au/~herbert/
PGP Key: http://gondor.apana.org.au/~herbert/pubkey.txt

--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename=p

Index: kernel-source-2.5/drivers/block/ll_rw_blk.c
===================================================================
RCS file: /home/gondolin/herbert/src/CVS/debian/kernel-source-2.5/drivers/block/ll_rw_blk.c,v
retrieving revision 1.9
diff -u -r1.9 ll_rw_blk.c
--- kernel-source-2.5/drivers/block/ll_rw_blk.c	11 Oct 2003 06:29:20 -0000	1.9
+++ kernel-source-2.5/drivers/block/ll_rw_blk.c	3 Nov 2003 20:48:53 -0000
@@ -816,6 +816,7 @@
 {
 	struct bio_vec *bv, *bvprv = NULL;
 	int i, nr_phys_segs, nr_hw_segs, seg_size, cluster;
+	int high, highprv = 1;
 
 	if (unlikely(!bio->bi_io_vec))
 		return;
@@ -823,7 +824,10 @@
 	cluster = q->queue_flags & (1 << QUEUE_FLAG_CLUSTER);
 	seg_size = nr_phys_segs = nr_hw_segs = 0;
 	bio_for_each_segment(bv, bio, i) {
-		if (bvprv && cluster) {
+		high = page_to_pfn(bv->bv_page) >= q->bounce_pfn;
+		if (high || highprv)
+			goto new_hw_segment;
+		if (cluster) {
 			if (seg_size + bv->bv_len > q->max_segment_size)
 				goto new_segment;
 			if (!BIOVEC_PHYS_MERGEABLE(bvprv, bv))
@@ -836,12 +840,15 @@
 			continue;
 		}
 new_segment:
-		if (!bvprv || !BIOVEC_VIRT_MERGEABLE(bvprv, bv))
+		if (!BIOVEC_VIRT_MERGEABLE(bvprv, bv)) {
+new_hw_segment:
 			nr_hw_segs++;
+		}
 
 		nr_phys_segs++;
 		bvprv = bv;
 		seg_size = bv->bv_len;
+		highprv = high;
 	}
 
 	bio->bi_phys_segments = nr_phys_segs;

--C7zPtVaVf+AK4Oqc--
