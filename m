Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264537AbUAARc2 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 Jan 2004 12:32:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264539AbUAARc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 Jan 2004 12:32:28 -0500
Received: from websrv.werbeagentur-aufwind.de ([213.239.197.241]:13991 "EHLO
	mail.werbeagentur-aufwind.de") by vger.kernel.org with ESMTP
	id S264537AbUAARcS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 Jan 2004 12:32:18 -0500
Date: Thu, 1 Jan 2004 18:32:14 +0100
From: Christophe Saout <christophe@saout.de>
To: Linux-Kernel Mailing List <linux-kernel@vger.kernel.org>
Cc: Jens Axboe <axboe@suse.de>, Andrew Morton <akpm@osdl.org>
Subject: [RFC][PATCH] Move bv_offset/bv_len update after bio_endio in __end_that_request_first
Message-ID: <20040101173214.GA4496@leto.cs.pocnet.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Can we move the update of bio_index(bio)->bv_offset and bv_len after the
bio_endio call in __end_that_request_first please (if a bvec is partially
completed)?

The bi_idx is currently also updated after the bio_endio call.

Currently the bi_end_io function cannot exactly determine whether a bvec
was completed or not.

Think of the following situation:

bv_offset is 0 and bv_len is 4096, now the driver completes 2048 bytes of
that bvec.

At the moment bv_offset and bv_len are set to 2048 first. The bi_end_io
function can't distinguish between this situation and the situation where
bv_offset and bv_len were 2048 before and that bvec was completed (because
bi_idx is incremented afterwards).

This shouldn't break any user since most users are waiting for the whole
bio to complete with if (bio->bi_size > 0) return 1;.

I need this because I want to release buffers as soon as possible. The
incoming bio can get split by my driver due to problems allocating buffers.
If the partial bio returns and can't release its buffers immediately the
whole thing might deadlock.

That's why I need to know exactly how many and which  bvecs were completed
in my bi_end_io function.

Or do you think it is safer to count backwards using bi_vcnt and bi_size?


diff -Nur linux-2.6.0.orig/drivers/block/ll_rw_blk.c linux-2.6.0/drivers/block/ll_rw_blk.c
--- linux-2.6.0.orig/drivers/block/ll_rw_blk.c	2003-11-24 02:31:11.000000000 +0100
+++ linux-2.6.0/drivers/block/ll_rw_blk.c	2004-01-01 14:27:34.222352384 +0100
@@ -2494,8 +2494,6 @@
 			 * not a complete bvec done
 			 */
 			if (unlikely(nbytes > nr_bytes)) {
-				bio_iovec_idx(bio, idx)->bv_offset += nr_bytes;
-				bio_iovec_idx(bio, idx)->bv_len -= nr_bytes;
 				bio_nbytes += nr_bytes;
 				total_bytes += nr_bytes;
 				break;
@@ -2531,7 +2529,9 @@
 	 */
 	if (bio_nbytes) {
 		bio_endio(bio, bio_nbytes, error);
-		req->bio->bi_idx += next_idx;
+		bio->bi_idx += next_idx;
+		bio_iovec(bio)->bv_offset += nr_bytes;
+		bio_iovec(bio)->bv_len -= nr_bytes;
 	}
 
 	blk_recalc_rq_sectors(req, total_bytes >> 9);

