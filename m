Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262114AbVDLS6G@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262114AbVDLS6G (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 14:58:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262530AbVDLStp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 14:49:45 -0400
Received: from fire.osdl.org ([65.172.181.4]:8394 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S262230AbVDLKcw (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 06:32:52 -0400
Message-Id: <200504121032.j3CAWmwu005684@shell0.pdx.osdl.net>
Subject: [patch 136/198] Direct IO async short read fix
To: torvalds@osdl.org
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org, daniel@osdl.org
From: akpm@osdl.org
Date: Tue, 12 Apr 2005 03:32:42 -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: Daniel McNeil <daniel@osdl.org>

The direct I/O code is mapping the read request to the file system block.  If
the file size was not on a block boundary, the result would show the the read
reading past EOF.  This was only happening for the AIO case.  The non-AIO case
truncates the result to match file size (in direct_io_worker).  This patch
does the same thing for the AIO case, it truncates the result to match the
file size if the read reads past EOF.

When I/O completes the result can be truncated to match the file size
without using i_size_read(), thus the aio result now matches the number of
bytes read to the end of file.

Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 25-akpm/fs/direct-io.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff -puN fs/direct-io.c~direct-io-async-short-read-fix fs/direct-io.c
--- 25/fs/direct-io.c~direct-io-async-short-read-fix	2005-04-12 03:21:36.288620192 -0700
+++ 25-akpm/fs/direct-io.c	2005-04-12 03:21:36.292619584 -0700
@@ -66,6 +66,7 @@ struct dio {
 	struct bio *bio;		/* bio under assembly */
 	struct inode *inode;
 	int rw;
+	loff_t i_size;			/* i_size when submitted */
 	int lock_type;			/* doesn't change */
 	unsigned blkbits;		/* doesn't change */
 	unsigned blkfactor;		/* When we're using an alignment which
@@ -230,17 +231,29 @@ static void finished_one_bio(struct dio 
 	spin_lock_irqsave(&dio->bio_lock, flags);
 	if (dio->bio_count == 1) {
 		if (dio->is_async) {
+			ssize_t transferred;
+			loff_t offset;
+
 			/*
 			 * Last reference to the dio is going away.
 			 * Drop spinlock and complete the DIO.
 			 */
 			spin_unlock_irqrestore(&dio->bio_lock, flags);
-			dio_complete(dio, dio->block_in_file << dio->blkbits,
-					dio->result);
+
+			/* Check for short read case */
+			transferred = dio->result;
+			offset = dio->iocb->ki_pos;
+
+			if ((dio->rw == READ) &&
+			    ((offset + transferred) > dio->i_size))
+				transferred = dio->i_size - offset;
+
+			dio_complete(dio, offset, transferred);
+
 			/* Complete AIO later if falling back to buffered i/o */
 			if (dio->result == dio->size ||
 				((dio->rw == READ) && dio->result)) {
-				aio_complete(dio->iocb, dio->result, 0);
+				aio_complete(dio->iocb, transferred, 0);
 				kfree(dio);
 				return;
 			} else {
@@ -951,6 +964,7 @@ direct_io_worker(int rw, struct kiocb *i
 	dio->page_errors = 0;
 	dio->result = 0;
 	dio->iocb = iocb;
+	dio->i_size = i_size_read(inode);
 
 	/*
 	 * BIO completion state.
_
