Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262791AbUCOVRe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Mar 2004 16:17:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262769AbUCOVRd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Mar 2004 16:17:33 -0500
Received: from fw.osdl.org ([65.172.181.6]:35303 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262794AbUCOVQt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Mar 2004 16:16:49 -0500
Date: Mon, 15 Mar 2004 13:18:52 -0800
From: Andrew Morton <akpm@osdl.org>
To: Thomas Schlichter <thomas.schlichter@web.de>
Cc: linux-kernel@vger.kernel.org, Jens Axboe <axboe@suse.de>
Subject: Re: 2.6.4-mm2
Message-Id: <20040315131852.3fd9cd93.akpm@osdl.org>
In-Reply-To: <200403152157.02051.thomas.schlichter@web.de>
References: <20040314172809.31bd72f7.akpm@osdl.org>
	<200403152157.02051.thomas.schlichter@web.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Schlichter <thomas.schlichter@web.de> wrote:
>
> ith 2.6.4-mm2 I get following badness on boot:
> 
> Badness in as_insert_request at drivers/block/as-iosched.c:1513
> Call Trace:
>  [<c022e326>] as_insert_request+0x166/0x190
>  [<c0225af8>] __elv_add_request+0x28/0x60
>  [<c0228b9b>] __make_request+0x47b/0x540
>  [<c0228d75>] generic_make_request+0x115/0x1d0
>  [<c011efd0>] autoremove_wake_function+0x0/0x40
>  [<c0228e80>] submit_bio+0x50/0xf0
>  [<c0162f58>] __bio_add_page+0x88/0x110

Someone got his bitmasks and bitshifts mixed up again ;)


 25-akpm/include/linux/bio.h   |    1 +
 25-akpm/include/linux/fs.h    |    4 ++--
 25-akpm/kernel/power/pmdisk.c |    2 +-
 drivers/md/md.c               |    0 
 4 files changed, 4 insertions(+), 3 deletions(-)

diff -puN drivers/md/md.c~per-backing_dev-unplugging-BIO_RW_SYNC-fix drivers/md/md.c
diff -puN include/linux/bio.h~per-backing_dev-unplugging-BIO_RW_SYNC-fix include/linux/bio.h
--- 25/include/linux/bio.h~per-backing_dev-unplugging-BIO_RW_SYNC-fix	Mon Mar 15 13:13:06 2004
+++ 25-akpm/include/linux/bio.h	Mon Mar 15 13:14:40 2004
@@ -119,6 +119,7 @@ struct bio {
  * bit 1 -- rw-ahead when set
  * bit 2 -- barrier
  * bit 3 -- fail fast, don't want low level driver retries
+ * bit 4 -- synchronous I/O hint: the block layer will unplug immediately
  */
 #define BIO_RW		0
 #define BIO_RW_AHEAD	1
diff -puN include/linux/fs.h~per-backing_dev-unplugging-BIO_RW_SYNC-fix include/linux/fs.h
--- 25/include/linux/fs.h~per-backing_dev-unplugging-BIO_RW_SYNC-fix	Mon Mar 15 13:13:06 2004
+++ 25-akpm/include/linux/fs.h	Mon Mar 15 13:15:11 2004
@@ -83,8 +83,8 @@ extern int leases_enable, dir_notify_ena
 #define WRITE 1
 #define READA 2		/* read-ahead  - don't block if no resources */
 #define SPECIAL 4	/* For non-blockdevice requests in request queue */
-#define READ_SYNC	(READ | BIO_RW_SYNC)
-#define WRITE_SYNC	(WRITE | BIO_RW_SYNC)
+#define READ_SYNC	(READ | (1 << BIO_RW_SYNC))
+#define WRITE_SYNC	(WRITE | (1 << BIO_RW_SYNC))
 
 #define SEL_IN		1
 #define SEL_OUT		2
diff -puN kernel/power/pmdisk.c~per-backing_dev-unplugging-BIO_RW_SYNC-fix kernel/power/pmdisk.c
--- 25/kernel/power/pmdisk.c~per-backing_dev-unplugging-BIO_RW_SYNC-fix	Mon Mar 15 13:13:06 2004
+++ 25-akpm/kernel/power/pmdisk.c	Mon Mar 15 13:15:33 2004
@@ -897,7 +897,7 @@ static int submit(int rw, pgoff_t page_o
 	if (rw == WRITE)
 		bio_set_pages_dirty(bio);
 	start_io();
-	submit_bio(rw|BIO_RW_SYNC,bio);
+	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
 	wait_io();
  Done:
 	bio_put(bio);

_

