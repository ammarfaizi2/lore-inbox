Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261545AbULYRyh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261545AbULYRyh (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Dec 2004 12:54:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261548AbULYRyg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Dec 2004 12:54:36 -0500
Received: from gprs212-19.eurotel.cz ([160.218.212.19]:55936 "EHLO amd.ucw.cz")
	by vger.kernel.org with ESMTP id S261545AbULYRyd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Dec 2004 12:54:33 -0500
Date: Sat, 25 Dec 2004 18:36:54 +0100
From: Pavel Machek <pavel@ucw.cz>
To: Andrew Morton <akpm@zip.com.au>,
       kernel list <linux-kernel@vger.kernel.org>
Subject: swsusp: kill one-line helpers, handle read errors
Message-ID: <20041225173654.GA10153@elf.ucw.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

swsusp contains few one-line helpers that only make
reading/understanding code more difficult. Also warn the user when
something goes wrong, instead of waking machine with corrupt
data. Please apply,
                                                                Pavel

Signed-off-by: Pavel Machek <pavel@suse.cz>

--- clean-cvs/kernel/power/swsusp.c	2004-12-14 20:43:42.000000000 +0100
+++ linux-cvs/kernel/power/swsusp.c	2004-12-14 20:48:31.000000000 +0100
@@ -1003,24 +984,14 @@
 
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
@@ -1055,9 +1026,12 @@
 
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

-- 
People were complaining that M$ turns users into beta-testers...
...jr ghea gurz vagb qrirybcref, naq gurl frrz gb yvxr vg gung jnl!
