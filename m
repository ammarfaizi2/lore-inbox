Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261330AbTABJqF>; Thu, 2 Jan 2003 04:46:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbTABJqF>; Thu, 2 Jan 2003 04:46:05 -0500
Received: from cmailm4.svr.pol.co.uk ([195.92.193.211]:1809 "EHLO
	cmailm4.svr.pol.co.uk") by vger.kernel.org with ESMTP
	id <S261330AbTABJqE>; Thu, 2 Jan 2003 04:46:04 -0500
Date: Thu, 2 Jan 2003 09:55:01 +0000
To: Kevin Corry <corry@ecn.purdue.edu>
Cc: Joe Thornber <joe@fib011235813.fsnet.co.uk>, dm-devel@sistina.com,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dm.c : Check memory allocations
Message-ID: <20030102095501.GB2677@reti>
References: <20021230105114.GB2703@reti> <200212311622.gBVGMS5R028448@shay.ecn.purdue.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200212311622.gBVGMS5R028448@shay.ecn.purdue.edu>
User-Agent: Mutt/1.4i
From: Joe Thornber <joe@fib011235813.fsnet.co.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 31, 2002 at 11:22:28AM -0500, Kevin Corry wrote:
> > 
> > On Fri, Dec 27, 2002 at 04:55:31PM -0500, Kevin Corry wrote:
> > > Check memory allocations when cloning bio's.
> > 
> > Rejected, clone_bio() cannot fail since it's allocating from a mempool
> > with __GFP_WAIT set.
> > 
> > - Joe
> 
> Hmm. Yep. I must have mistaken GFP_NOIO for GFP_ATOMIC.
> 
> But based on that reasoning, shouldn't the bio_alloc() call
> in split_bvec() always return a valid bio, and hence make the
> checks in split_bvec() and __clone_and_map() unnecessary?

y, I was mistakenly under the impression that bio_alloc could fail
during the allocation of the bvec.  I'll add the following patch.

- Joe


--- diff/drivers/md/dm.c	2002-12-30 11:40:30.000000000 +0000
+++ source/drivers/md/dm.c	2003-01-02 09:51:07.000000000 +0000
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


