Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267334AbUIJJbN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267334AbUIJJbN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Sep 2004 05:31:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267338AbUIJJbM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Sep 2004 05:31:12 -0400
Received: from checkpoint-out.gate.uni-erlangen.de ([131.188.28.69]:41926 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S267334AbUIJJa7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Sep 2004 05:30:59 -0400
Date: Fri, 10 Sep 2004 10:54:05 +0200
From: Pavel Machek <pavel@ucw.cz>
To: kernel list <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@zip.com.au>,
       Patrick Mochel <mochel@digitalimplant.org>
Subject: swsusp: clean up reading
Message-ID: <20040910085405.GC12751@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

This removes one-line functions so that code is readable again. Test
is added so that we do not ignore I/O errors. It also turns
io_schedule() into yield() as suggested by Andrea. Please apply,

								Pavel


--- clean-mm/kernel/power/swsusp.c	2004-09-07 21:12:33.000000000 +0200
+++ linux-mm/kernel/power/swsusp.c	2004-09-09 08:56:20.000000000 +0200
@@ -994,24 +978,14 @@
 
 static atomic_t io_done = ATOMIC_INIT(0);
 
-static void start_io(void)
-{
-	atomic_set(&io_done,1);
-}
-
 static int end_io(struct bio * bio, unsigned int num, int err)
 {
-	atomic_set(&io_done,0);
+	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
+		panic("I/O error reading memory image");
+	atomic_set(&io_done, 0);
 	return 0;
 }
 
-static void wait_io(void)
-{
-	while(atomic_read(&io_done))
-		io_schedule();
-}
-
-
 static struct block_device * resume_bdev;
 
 /**
@@ -1046,9 +1020,12 @@
 
 	if (rw == WRITE)
 		bio_set_pages_dirty(bio);
-	start_io();
+
+	atomic_set(&io_done, 1);
 	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
-	wait_io();
+	while (atomic_read(&io_done))
+		yield();
+
  Done:
 	bio_put(bio);
 	return error;
