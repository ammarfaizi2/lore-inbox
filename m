Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286938AbSABLZF>; Wed, 2 Jan 2002 06:25:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286944AbSABLY4>; Wed, 2 Jan 2002 06:24:56 -0500
Received: from fep03.swip.net ([130.244.199.131]:39315 "EHLO
	fep03-svc.swip.net") by vger.kernel.org with ESMTP
	id <S286938AbSABLYo>; Wed, 2 Jan 2002 06:24:44 -0500
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] kernel BUG at scsi_merge.c:83
In-Reply-To: <m2zo3xr0qu.fsf@pengo.localdomain> <20020102083223.J16092@suse.de>
From: Peter Osterlund <petero2@telia.com>
Date: 02 Jan 2002 12:23:37 +0100
In-Reply-To: <20020102083223.J16092@suse.de>
Message-ID: <m21yh93sjq.fsf@pengo.localdomain>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe <axboe@suse.de> writes:

> On Wed, Jan 02 2002, Peter Osterlund wrote:
> > Hi!
> > 
> > While doing some stress testing on the 2.5.2-pre5 kernel, I am hitting
> > a kernel BUG at scsi_merge.c:83, followed by a kernel panic. The
> > problem is that scsi_alloc_sgtable fails because the request contains
> > too many physical segments. I think this patch is the correct fix:
> 
> Correct, ll_rw_blk default is ok now. I missed this when killing
> scsi_malloc/scsi_dma, thanks.

It turns out this is still not enough to fix the problem for me,
because ll_new_hw_segment is still allowing nr_phys_segments to become
too large. Is the following patch the correct way to deal with this
problem, or is that case supposed to be prevented by some other means?
At least, this patch prevents the kernel panic during my stress test.

--- linux-2.5.2-pre5/drivers/block/ll_rw_blk.c	Mon Dec 31 14:56:37 2001
+++ linux-2.5-packet/drivers/block/ll_rw_blk.c	Wed Jan  2 11:44:21 2002
@@ -530,6 +530,7 @@
 				    struct bio *bio)
 {
 	int nr_hw_segs = bio_hw_segments(q, bio);
+	int nr_phys_segs;
 
 	if (req->nr_hw_segments + nr_hw_segs > q->max_hw_segments) {
 		req->flags |= REQ_NOMERGE;
@@ -537,12 +538,19 @@
 		return 0;
 	}
 
+	nr_phys_segs = bio_phys_segments(q, bio);
+	if (req->nr_phys_segments + nr_phys_segs > q->max_phys_segments) {
+		req->flags |= REQ_NOMERGE;
+		q->last_merge = NULL;
+		return 0;
+	}
+
 	/*
 	 * This will form the start of a new hw segment.  Bump both
 	 * counters.
 	 */
 	req->nr_hw_segments += nr_hw_segs;
-	req->nr_phys_segments += bio_phys_segments(q, bio);
+	req->nr_phys_segments += nr_phys_segs;
 	return 1;
 }
 
-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
