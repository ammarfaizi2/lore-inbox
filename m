Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262850AbUFBNal@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262850AbUFBNal (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Jun 2004 09:30:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262634AbUFBN3l
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Jun 2004 09:29:41 -0400
Received: from may.priocom.com ([213.156.65.50]:19595 "EHLO may.priocom.com")
	by vger.kernel.org with ESMTP id S262756AbUFBN2E (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Jun 2004 09:28:04 -0400
Subject: [PATCH] 2.6.6 buffer.c: bio_alloc() check
From: Yury Umanets <torque@ukrpost.net>
To: akpm@osdl.org
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Message-Id: <1086182887.2898.89.camel@firefly.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Wed, 02 Jun 2004 16:28:08 +0300
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

[PATCH] 2.6.6 buffer.c: adds bio_alloc() check and error handling in
fs/buffer.c.

Signed-off-by: Yury Umanets <torque@ukrpost.net>

 buffer.c |   25 +++++++++++++++++++++++++
 1 files changed, 25 insertions(+)

diff -rupN ./linux-2.6.6/fs/buffer.c ./linux-2.6.6-modified/fs/buffer.c
--- ./linux-2.6.6/fs/buffer.c	Mon May 10 05:32:38 2004
+++ ./linux-2.6.6-modified/fs/buffer.c	Wed Jun  2 15:21:47 2004
@@ -2712,6 +2712,31 @@ void submit_bh(int rw, struct buffer_hea
 	 * submit_bio -> generic_make_request may further map this bio around
 	 */
 	bio = bio_alloc(GFP_NOIO, 1);
+	if (bio == NULL) {
+		char b[BDEVNAME_SIZE];
+                
+		printk(KERN_ERR "BIO allocation failed for buffer on device "
+			"%s, logical block %Lu\n", bdevname(bh->b_bdev, b), 
+			(unsigned long long)bh->b_blocknr);
+                
+		/* 
+		 * this is needed here as some of submit_bh() callers have to
+		 * wait until buffer is unlocked (that is IO is finished on it)
+		 * and check its state.
+		 */
+		if (rw == WRITE)
+			set_buffer_write_io_error(bh);
+		clear_buffer_uptodate(bh);
+		SetPageError(bh->b_page);
+                
+		/* 
+		 * making all future wait_on_buffer() callers do not wait
+		 * this buffer as it is errorneous. 
+		 */
+		if (buffer_locked(bh))
+			unlock_buffer(bh);
+		return;
+        }
 
 	bio->bi_sector = bh->b_blocknr * (bh->b_size >> 9);
 	bio->bi_bdev = bh->b_bdev;


-- 
umka

