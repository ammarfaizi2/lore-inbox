Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265770AbSKKQa1>; Mon, 11 Nov 2002 11:30:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265783AbSKKQa0>; Mon, 11 Nov 2002 11:30:26 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:28644 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S265770AbSKKQa0>; Mon, 11 Nov 2002 11:30:26 -0500
Date: Mon, 11 Nov 2002 16:38:13 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Linus Torvalds <torvalds@transmeta.com>
cc: Christoph Hellwig <hch@lst.de>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] loop sendfile retval
Message-ID: <Pine.LNX.4.44.0211111626160.9968-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Buffer I/O error on device loop: its use of sendfile is (trivially)
broken - retval is usually count done, only an error when negative.
Nearby spinlocking clearly bogus, delete instead of remarking on it.

Hugh

--- 2.5.47/drivers/block/loop.c	Mon Nov 11 12:34:14 2002
+++ linux/drivers/block/loop.c	Mon Nov 11 15:44:33 2002
@@ -304,21 +304,16 @@
 {
 	struct lo_read_data cookie;
 	struct file *file;
-	int error;
+	int retval;
 
 	cookie.lo = lo;
 	cookie.data = kmap(bvec->bv_page) + bvec->bv_offset;
 	cookie.bsize = bsize;
-
-	/* umm, what does this lock actually try to protect? */
-	spin_lock_irq(&lo->lo_lock);
 	file = lo->lo_backing_file;
-	spin_unlock_irq(&lo->lo_lock);
-
-	error = file->f_op->sendfile(file, &pos, bvec->bv_len,
+	retval = file->f_op->sendfile(file, &pos, bvec->bv_len,
 			lo_read_actor, &cookie);
 	kunmap(bvec->bv_page);
-	return error;
+	return (retval < 0)? retval: 0;
 }
 
 static int

