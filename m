Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318885AbSICRrk>; Tue, 3 Sep 2002 13:47:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318887AbSICRrk>; Tue, 3 Sep 2002 13:47:40 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:61199 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S318885AbSICRri>; Tue, 3 Sep 2002 13:47:38 -0400
Date: Tue, 3 Sep 2002 11:00:39 -0700 (PDT)
From: Linus Torvalds <torvalds@transmeta.com>
To: Kernel Mailing List <linux-kernel@vger.kernel.org>
cc: Jens Axboe <axboe@suse.de>
Subject: One more bio for for floppy users in 2.5.33..
Message-ID: <Pine.LNX.4.44.0209031054290.1356-100000@home.transmeta.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Ok,
 I found another major bio-related bug that definitely explains why the 
floppy driver generated corruption - any partial request completion would 
be totally messed up by the BIO layer (not the floppy driver).

Any other block device driver that did partial request completion might 
also be impacted.

I'm still looking at the floppy driver itself - some of the request 
completion code is so messed up as to be unreadable, and some of that may 
actually be due to trying to work around the bio problem (unsuccessfully, 
I may add). So this may not actually fix things for you yet, simply 
because the floppy driver itself still does some strange things. 

Jens, oops. We should not update the counts by how much was left
uncompleted, but by how much we successfully completed!

		Linus

----
# The following is the BitKeeper ChangeSet Log
# --------------------------------------------
# 02/09/03	torvalds@home.transmeta.com	1.582
# Major partial request completion boo-boo in the bio layer.
# 
# This was _bad_. Major floppy corruption, and possibly the reason
# for other block device corruption for any driver that generated
# partial results for a block device request.
# --------------------------------------------
#
diff -Nru a/drivers/block/ll_rw_blk.c b/drivers/block/ll_rw_blk.c
--- a/drivers/block/ll_rw_blk.c	Tue Sep  3 10:53:59 2002
+++ b/drivers/block/ll_rw_blk.c	Tue Sep  3 10:53:59 2002
@@ -1992,11 +1992,11 @@
 		 * not a complete bvec done
 		 */
 		if (unlikely(nsect > nr_sectors)) {
-			int residual = (nsect - nr_sectors) << 9;
+			int partial = nr_sectors << 9;
 
-			bio->bi_size -= residual;
-			bio_iovec(bio)->bv_offset += residual;
-			bio_iovec(bio)->bv_len -= residual;
+			bio->bi_size -= partial;
+			bio_iovec(bio)->bv_offset += partial;
+			bio_iovec(bio)->bv_len -= partial;
 			blk_recalc_rq_sectors(req, nr_sectors);
 			blk_recalc_rq_segments(req);
 			return 1;

