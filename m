Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267455AbTBDUAc>; Tue, 4 Feb 2003 15:00:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267457AbTBDUAb>; Tue, 4 Feb 2003 15:00:31 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:59540 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S267455AbTBDUAb>; Tue, 4 Feb 2003 15:00:31 -0500
Date: Tue, 4 Feb 2003 20:11:36 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel@vger.kernel.org
Subject: [PATCH] loopy loop loop
Message-ID: <Pine.LNX.4.44.0302042005410.6681-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The loop driver's loop over elements of bi_io_vec is in lo_send and
lo_receive: iterating that same transfer bi_vcnt times at the level
above is, er, excessive.  (And no need to increment bi_idx here.)

Hugh

--- 2.5.59/drivers/block/loop.c	Tue Dec 10 05:49:02 2002
+++ linux/drivers/block/loop.c	Tue Feb  4 19:44:01 2003
@@ -350,15 +350,10 @@
 	int ret;
 
 	pos = ((loff_t) bio->bi_sector << 9) + lo->lo_offset;
-
-	do {
-		if (bio_rw(bio) == WRITE)
-			ret = lo_send(lo, bio, lo->lo_blocksize, pos);
-		else
-			ret = lo_receive(lo, bio, lo->lo_blocksize, pos);
-
-	} while (++bio->bi_idx < bio->bi_vcnt);
-
+	if (bio_rw(bio) == WRITE)
+		ret = lo_send(lo, bio, lo->lo_blocksize, pos);
+	else
+		ret = lo_receive(lo, bio, lo->lo_blocksize, pos);
 	return ret;
 }
 

