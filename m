Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283479AbRK3Cr6>; Thu, 29 Nov 2001 21:47:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283478AbRK3Crj>; Thu, 29 Nov 2001 21:47:39 -0500
Received: from mta11.srv.hcvlny.cv.net ([167.206.5.46]:19599 "EHLO
	mta11.srv.hcvlny.cv.net") by vger.kernel.org with ESMTP
	id <S283477AbRK3Crb>; Thu, 29 Nov 2001 21:47:31 -0500
Date: Thu, 29 Nov 2001 21:47:04 -0500
From: Alex Valys <avalys@optonline.net>
Subject: PATCH:  Fixes occurences of bio_size in ide_floppy.c
To: linux-kernel@vger.kernel.org
Message-id: <0GNL003AFEF7RO@mta2.srv.hcvlny.cv.net>
MIME-version: 1.0
X-Mailer: KMail [version 1.3.2]
Content-type: text/plain; charset=iso-8859-1
Content-transfer-encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Haven't noticed this posted yet...

--- drivers/ide/ide-floppy.c.orig       Thu Nov 29 21:05:56 2001
+++ drivers/ide/ide-floppy.c    Thu Nov 29 21:11:44 2001
@@ -711,7 +711,7 @@
        int count;

        while (bcount) {
-               if (pc->b_count == bio_size(bio)) {
+               if (pc->b_count == bio->bi_size) {
                        rq->sector += rq->current_nr_sectors;
                        rq->nr_sectors -= rq->current_nr_sectors;
                        idefloppy_end_request (1, HWGROUP(drive));
@@ -723,7 +723,8 @@
                        idefloppy_discard_data (drive, bcount);
                        return;
                }
-               count = IDEFLOPPY_MIN (bio_size(bio) - pc->b_count, bcount);
+               count = IDEFLOPPY_MIN (bio->bi_size - pc->b_count,
+bcount);
                atapi_input_bytes (drive, bio_data(bio) + pc->b_count, count);
                bcount -= count; pc->b_count += count;
        }
@@ -742,7 +743,7 @@
                        idefloppy_end_request (1, HWGROUP(drive));
                        if ((bio = rq->bio) != NULL) {
                                pc->b_data = bio_data(bio);
-                               pc->b_count = bio_size(bio);
+                               pc->b_count = bio->bi_size;
                        }
                }
                if (bio == NULL) {
@@ -1210,7 +1211,7 @@
        pc->callback = &idefloppy_rw_callback;
        pc->rq = rq;
        pc->b_data = rq->buffer;
-       pc->b_count = rq->cmd == READ ? 0 : bio_size(rq->bio);
+       pc->b_count = rq->cmd == READ ? 0 : rq->bio->bi_size;
        if (rq->cmd == WRITE)
                set_bit (PC_WRITING, &pc->flags);
        pc->buffer = NULL;
