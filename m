Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289146AbSAGI4D>; Mon, 7 Jan 2002 03:56:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289152AbSAGIzz>; Mon, 7 Jan 2002 03:55:55 -0500
Received: from ns1.yggdrasil.com ([209.249.10.20]:6041 "EHLO ns1.yggdrasil.com")
	by vger.kernel.org with ESMTP id <S289147AbSAGIzr>;
	Mon, 7 Jan 2002 03:55:47 -0500
Date: Mon, 7 Jan 2002 00:55:46 -0800
From: "Adam J. Richter" <adam@yggdrasil.com>
To: axboe@suse.de
Cc: linux-kernel@vger.kernel.org
Subject: Patch?: linux-2.5.2-pre9/drivers/block/ll_rw_blk.c blk_rq_map_sg simplification
Message-ID: <20020107005546.A2459@baldur.yggdrasil.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="lrZ03NoBR/3+SXJZ"
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Jens,

	The following patch removes gotos from blk_rq_map_sg, making
it more readable and five lines shorter.  I think the compiler should
generate the same code.  I have not tested this other than to
verify that it compiles.

	If it works and looks good to you, I would appreciate it if
you would forward it to Linus for integration.  (I am also cc'ing this to
linux-kernel in case anyone spots a mistake on my part.)

	Also, if there is some other way by which you would like
me to submit future bio patches (if any), please let me know.

-- 
Adam J. Richter     __     ______________   4880 Stevens Creek Blvd, Suite 104
adam@yggdrasil.com     \ /                  San Jose, California 95129-1034
+1 408 261-6630         | g g d r a s i l   United States of America
fax +1 408 261-6631      "Free Software For The Rest Of Us."

--lrZ03NoBR/3+SXJZ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="ll.diff"

--- linux-2.5.2-pre8/drivers/block/ll_rw_blk.c	Sat Jan  5 15:33:53 2002
+++ linux/drivers/block/ll_rw_blk.c	Mon Jan  7 00:28:17 2002
@@ -474,18 +474,13 @@
 		bio_for_each_segment(bvec, bio, i) {
 			int nbytes = bvec->bv_len;
 
-			if (bvprv && cluster) {
-				if (sg[nsegs - 1].length + nbytes > q->max_segment_size)
-					goto new_segment;
-
-				if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec))
-					goto new_segment;
-				if (!BIOVEC_SEG_BOUNDARY(q, bvprv, bvec))
-					goto new_segment;
-
+			if (bvprv && cluster &&
+			    (sg[nsegs - 1].length + nbytes <=
+			     q->max_segment_size) &&
+			    BIOVEC_PHYS_MERGEABLE(bvprv, bvec) &&
+			    BIOVEC_SEG_BOUNDARY(q, bvprv, bvec)) {
 				sg[nsegs - 1].length += nbytes;
 			} else {
-new_segment:
 				memset(&sg[nsegs],0,sizeof(struct scatterlist));
 				sg[nsegs].page = bvec->bv_page;
 				sg[nsegs].length = nbytes;

--lrZ03NoBR/3+SXJZ--
