Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261416AbUFJOqg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261416AbUFJOqg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Jun 2004 10:46:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261426AbUFJOqg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Jun 2004 10:46:36 -0400
Received: from cantor.suse.de ([195.135.220.2]:37316 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261416AbUFJOp0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Jun 2004 10:45:26 -0400
Subject: [PATCH 1/2 without line wrapping] add BH_Eopnotsupp for testing
	async barrier failures
From: Chris Mason <mason@suse.com>
To: akpm@osdl.org, linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086878758.10973.317.camel@watt.suse.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 10 Jun 2004 10:45:58 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In order for filesystems to detect asynchronous ordered write failures
for buffers sent via submit_bh, they need a bit they can test for in
the buffer head.  This adds BH_Eopnotsupp and the related buffer operations

end_buffer_write_sync is changed to avoid a printk for BH_Eoptnotsupp
related failures, since the FS is responsible for a retry.

sync_dirty_buffer is changed to test for BH_Eopnotsupp and return
-EOPNOTSUPP to the caller

Some of this came from Jens Axboe

Index: linux.rc3/fs/buffer.c
===================================================================
--- linux.rc3.orig/fs/buffer.c	2004-06-10 09:53:17.000000000 -0400
+++ linux.rc3/fs/buffer.c	2004-06-10 10:21:29.000000000 -0400
@@ -213,7 +213,7 @@ void end_buffer_write_sync(struct buffer
 	if (uptodate) {
 		set_buffer_uptodate(bh);
 	} else {
-		if (printk_ratelimit()) {
+		if (!buffer_eopnotsupp(bh) && printk_ratelimit()) {
 			buffer_io_error(bh);
 			printk(KERN_WARNING "lost page write due to "
 					"I/O error on %s\n",
@@ -2753,8 +2753,10 @@ static int end_bio_bh_io_sync(struct bio
 	if (bio->bi_size)
 		return 1;
 
-	if (err == -EOPNOTSUPP)
+	if (err == -EOPNOTSUPP) {
 		set_bit(BIO_EOPNOTSUPP, &bio->bi_flags);
+		set_bit(BH_Eopnotsupp, &bh->b_state);
+	}
 
 	bh->b_end_io(bh, test_bit(BIO_UPTODATE, &bio->bi_flags));
 	bio_put(bio);
@@ -2879,6 +2881,10 @@ int sync_dirty_buffer(struct buffer_head
 		bh->b_end_io = end_buffer_write_sync;
 		ret = submit_bh(WRITE, bh);
 		wait_on_buffer(bh);
+		if (buffer_eopnotsupp(bh)) {
+			clear_buffer_eopnotsupp(bh);
+			ret = -EOPNOTSUPP;
+		}
 		if (!ret && !buffer_uptodate(bh))
 			ret = -EIO;
 	} else {
Index: linux.rc3/include/linux/buffer_head.h
===================================================================
--- linux.rc3.orig/include/linux/buffer_head.h	2004-06-10 09:53:17.000000000 -0400
+++ linux.rc3/include/linux/buffer_head.h	2004-06-10 09:56:39.000000000 -0400
@@ -27,6 +27,7 @@ enum bh_state_bits {
 	BH_Boundary,	/* Block is followed by a discontiguity */
 	BH_Write_EIO,	/* I/O error on write */
 	BH_Ordered,	/* ordered write */
+	BH_Eopnotsupp,	/* operation not supported (barrier) */
 
 	BH_PrivateStart,/* not a state bit, but the first bit available
 			 * for private allocation by other entities
@@ -113,6 +114,7 @@ BUFFER_FNS(Delay, delay)
 BUFFER_FNS(Boundary, boundary)
 BUFFER_FNS(Write_EIO, write_io_error)
 BUFFER_FNS(Ordered, ordered)
+BUFFER_FNS(Eopnotsupp, eopnotsupp)
 
 #define bh_offset(bh)		((unsigned long)(bh)->b_data & ~PAGE_MASK)
 #define touch_buffer(bh)	mark_page_accessed(bh->b_page)


