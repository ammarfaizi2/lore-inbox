Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129855AbQLWHlA>; Sat, 23 Dec 2000 02:41:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129998AbQLWHkv>; Sat, 23 Dec 2000 02:40:51 -0500
Received: from www.wen-online.de ([212.223.88.39]:42258 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S129855AbQLWHkf>;
	Sat, 23 Dec 2000 02:40:35 -0500
Date: Sat, 23 Dec 2000 08:09:57 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
To: Linus Torvalds <torvalds@transmeta.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [patchlet] move kstat.pgpgin/out into submit_bh()
Message-ID: <Pine.Linu.4.10.10012230757470.1434-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Merry Xmas All,

read/write-page() I/O isn't visible in kstat.

--- linux-2.4.0-test13-pre4/drivers/block/ll_rw_blk.c.org	Sat Dec 23 07:08:28 2000
+++ linux-2.4.0-test13-pre4/drivers/block/ll_rw_blk.c	Sat Dec 23 07:28:38 2000
@@ -964,6 +964,14 @@
 	bh->b_rsector = bh->b_blocknr * (bh->b_size>>9);
 
 	generic_make_request(rw, bh);
+
+	switch (rw) {
+		case WRITE:
+			kstat.pgpgout++;
+			break;
+		default:
+			kstat.pgpgin++;
+	}
 }
 
 /*
@@ -1057,7 +1065,6 @@
 				/* Hmmph! Nothing to write */
 				goto end_io;
 			__mark_buffer_clean(bh);
-			kstat.pgpgout++;
 			break;
 
 		case READA:
@@ -1065,7 +1072,6 @@
 			if (buffer_uptodate(bh))
 				/* Hmmph! Already have it */
 				goto end_io;
-			kstat.pgpgin++;
 			break;
 		default:
 			BUG();

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
