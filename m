Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965367AbWI0GEF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965367AbWI0GEF (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 27 Sep 2006 02:04:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965366AbWI0GDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 27 Sep 2006 02:03:49 -0400
Received: from ogre.sisk.pl ([217.79.144.158]:50917 "EHLO ogre.sisk.pl")
	by vger.kernel.org with ESMTP id S965368AbWI0GDg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 27 Sep 2006 02:03:36 -0400
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 2/5] swsusp: Rearrange swap-handling code
Date: Wed, 27 Sep 2006 07:26:20 +0200
User-Agent: KMail/1.9.1
Cc: Pavel Machek <pavel@ucw.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200609270720.28131.rjw@sisk.pl>
In-Reply-To: <200609270720.28131.rjw@sisk.pl>
MIME-Version: 1.0
Content-Disposition: inline
Message-Id: <200609270726.20641.rjw@sisk.pl>
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Rearrange the code in kernel/power/swap.c so that the next patch is more
readable.

[This patch only moves the existing code.]

Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@ucw.cz>
---
 kernel/power/swap.c |  219 ++++++++++++++++++++++++++--------------------------
 1 file changed, 111 insertions(+), 108 deletions(-)

Index: linux-2.6.18-mm1/kernel/power/swap.c
===================================================================
--- linux-2.6.18-mm1.orig/kernel/power/swap.c
+++ linux-2.6.18-mm1/kernel/power/swap.c
@@ -41,10 +41,120 @@ static struct swsusp_header {
 } __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
 
 /*
- * Saving part...
+ * General things
  */
 
 static unsigned short root_swap = 0xffff;
+static struct block_device *resume_bdev;
+
+/**
+ *	submit - submit BIO request.
+ *	@rw:	READ or WRITE.
+ *	@off	physical offset of page.
+ *	@page:	page we're reading or writing.
+ *	@bio_chain: list of pending biod (for async reading)
+ *
+ *	Straight from the textbook - allocate and initialize the bio.
+ *	If we're reading, make sure the page is marked as dirty.
+ *	Then submit it and, if @bio_chain == NULL, wait.
+ */
+static int submit(int rw, pgoff_t page_off, struct page *page,
+			struct bio **bio_chain)
+{
+	struct bio *bio;
+
+	bio = bio_alloc(GFP_ATOMIC, 1);
+	if (!bio)
+		return -ENOMEM;
+	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
+	bio->bi_bdev = resume_bdev;
+	bio->bi_end_io = end_swap_bio_read;
+
+	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
+		printk("swsusp: ERROR: adding page to bio at %ld\n", page_off);
+		bio_put(bio);
+		return -EFAULT;
+	}
+
+	lock_page(page);
+	bio_get(bio);
+
+	if (bio_chain == NULL) {
+		submit_bio(rw | (1 << BIO_RW_SYNC), bio);
+		wait_on_page_locked(page);
+		if (rw == READ)
+			bio_set_pages_dirty(bio);
+		bio_put(bio);
+	} else {
+		get_page(page);
+		bio->bi_private = *bio_chain;
+		*bio_chain = bio;
+		submit_bio(rw | (1 << BIO_RW_SYNC), bio);
+	}
+	return 0;
+}
+
+static int bio_read_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
+{
+	return submit(READ, page_off, virt_to_page(addr), bio_chain);
+}
+
+static int bio_write_page(pgoff_t page_off, void *addr)
+{
+	return submit(WRITE, page_off, virt_to_page(addr), NULL);
+}
+
+static int wait_on_bio_chain(struct bio **bio_chain)
+{
+	struct bio *bio;
+	struct bio *next_bio;
+	int ret = 0;
+
+	if (bio_chain == NULL)
+		return 0;
+
+	bio = *bio_chain;
+	if (bio == NULL)
+		return 0;
+	while (bio) {
+		struct page *page;
+
+		next_bio = bio->bi_private;
+		page = bio->bi_io_vec[0].bv_page;
+		wait_on_page_locked(page);
+		if (!PageUptodate(page) || PageError(page))
+			ret = -EIO;
+		put_page(page);
+		bio_put(bio);
+		bio = next_bio;
+	}
+	*bio_chain = NULL;
+	return ret;
+}
+
+static void show_speed(struct timeval *start, struct timeval *stop,
+			unsigned nr_pages, char *msg)
+{
+	s64 elapsed_centisecs64;
+	int centisecs;
+	int k;
+	int kps;
+
+	elapsed_centisecs64 = timeval_to_ns(stop) - timeval_to_ns(start);
+	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
+	centisecs = elapsed_centisecs64;
+	if (centisecs == 0)
+		centisecs = 1;	/* avoid div-by-zero */
+	k = nr_pages * (PAGE_SIZE / 1024);
+	kps = (k * 100) / centisecs;
+	printk("%s %d kbytes in %d.%02d seconds (%d.%02d MB/s)\n", msg, k,
+			centisecs / 100, centisecs % 100,
+			kps / 1000, (kps % 1000) / 10);
+}
+
+/*
+ * Saving part
+ */
 
 static int mark_swapfiles(swp_entry_t start)
 {
@@ -166,26 +276,6 @@ static void release_swap_writer(struct s
 	handle->bitmap = NULL;
 }
 
-static void show_speed(struct timeval *start, struct timeval *stop,
-			unsigned nr_pages, char *msg)
-{
-	s64 elapsed_centisecs64;
-	int centisecs;
-	int k;
-	int kps;
-
-	elapsed_centisecs64 = timeval_to_ns(stop) - timeval_to_ns(start);
-	do_div(elapsed_centisecs64, NSEC_PER_SEC / 100);
-	centisecs = elapsed_centisecs64;
-	if (centisecs == 0)
-		centisecs = 1;	/* avoid div-by-zero */
-	k = nr_pages * (PAGE_SIZE / 1024);
-	kps = (k * 100) / centisecs;
-	printk("%s %d kbytes in %d.%02d seconds (%d.%02d MB/s)\n", msg, k,
-			centisecs / 100, centisecs % 100,
-			kps / 1000, (kps % 1000) / 10);
-}
-
 static int get_swap_writer(struct swap_map_handle *handle)
 {
 	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
@@ -205,34 +295,6 @@ static int get_swap_writer(struct swap_m
 	return 0;
 }
 
-static int wait_on_bio_chain(struct bio **bio_chain)
-{
-	struct bio *bio;
-	struct bio *next_bio;
-	int ret = 0;
-
-	if (bio_chain == NULL)
-		return 0;
-
-	bio = *bio_chain;
-	if (bio == NULL)
-		return 0;
-	while (bio) {
-		struct page *page;
-
-		next_bio = bio->bi_private;
-		page = bio->bi_io_vec[0].bv_page;
-		wait_on_page_locked(page);
-		if (!PageUptodate(page) || PageError(page))
-			ret = -EIO;
-		put_page(page);
-		bio_put(bio);
-		bio = next_bio;
-	}
-	*bio_chain = NULL;
-	return ret;
-}
-
 static int swap_write_page(struct swap_map_handle *handle, void *buf,
 				struct bio **bio_chain)
 {
@@ -384,65 +446,6 @@ int swsusp_write(void)
 	return error;
 }
 
-static struct block_device *resume_bdev;
-
-/**
- *	submit - submit BIO request.
- *	@rw:	READ or WRITE.
- *	@off	physical offset of page.
- *	@page:	page we're reading or writing.
- *	@bio_chain: list of pending biod (for async reading)
- *
- *	Straight from the textbook - allocate and initialize the bio.
- *	If we're reading, make sure the page is marked as dirty.
- *	Then submit it and, if @bio_chain == NULL, wait.
- */
-static int submit(int rw, pgoff_t page_off, struct page *page,
-			struct bio **bio_chain)
-{
-	struct bio *bio;
-
-	bio = bio_alloc(GFP_ATOMIC, 1);
-	if (!bio)
-		return -ENOMEM;
-	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
-	bio->bi_bdev = resume_bdev;
-	bio->bi_end_io = end_swap_bio_read;
-
-	if (bio_add_page(bio, page, PAGE_SIZE, 0) < PAGE_SIZE) {
-		printk("swsusp: ERROR: adding page to bio at %ld\n", page_off);
-		bio_put(bio);
-		return -EFAULT;
-	}
-
-	lock_page(page);
-	bio_get(bio);
-
-	if (bio_chain == NULL) {
-		submit_bio(rw | (1 << BIO_RW_SYNC), bio);
-		wait_on_page_locked(page);
-		if (rw == READ)
-			bio_set_pages_dirty(bio);
-		bio_put(bio);
-	} else {
-		get_page(page);
-		bio->bi_private = *bio_chain;
-		*bio_chain = bio;
-		submit_bio(rw | (1 << BIO_RW_SYNC), bio);
-	}
-	return 0;
-}
-
-static int bio_read_page(pgoff_t page_off, void *addr, struct bio **bio_chain)
-{
-	return submit(READ, page_off, virt_to_page(addr), bio_chain);
-}
-
-static int bio_write_page(pgoff_t page_off, void *addr)
-{
-	return submit(WRITE, page_off, virt_to_page(addr), NULL);
-}
-
 /**
  *	The following functions allow us to read data using a swap map
  *	in a file-alike way

