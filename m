Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262574AbUGQXH0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262574AbUGQXH0 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jul 2004 19:07:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264045AbUGQXEh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jul 2004 19:04:37 -0400
Received: from digitalimplant.org ([64.62.235.95]:38121 "HELO
	digitalimplant.org") by vger.kernel.org with SMTP id S262574AbUGQWf1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jul 2004 18:35:27 -0400
Date: Sat, 17 Jul 2004 15:35:22 -0700 (PDT)
From: Patrick Mochel <mochel@digitalimplant.org>
X-X-Sender: mochel@monsoon.he.net
To: linux-kernel@vger.kernel.org
cc: pavel@ucw.cz
Subject: [12/25] Merge pmdisk and swsusp
Message-ID: <Pine.LNX.4.50.0407171529530.22290-100000@monsoon.he.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


ChangeSet 1.1854, 2004/07/17 11:45:01-07:00, mochel@digitalimplant.org

[Power Mgmt] Consolidate pmdisk and swsusp early swap access.

- Move bio helpers to swsusp.
- Convert swsusp to use them, rathen buffer_heads.
- Expose and fix up calls in pmdisk.
- Clean up swsusp::read_suspend_image() a bit.


 kernel/power/pmdisk.c |   97 ++--------------------------
 kernel/power/swsusp.c |  171 ++++++++++++++++++++++++++++----------------------
 2 files changed, 105 insertions(+), 163 deletions(-)


diff -Nru a/kernel/power/pmdisk.c b/kernel/power/pmdisk.c
--- a/kernel/power/pmdisk.c	2004-07-17 14:51:13 -07:00
+++ b/kernel/power/pmdisk.c	2004-07-17 14:51:13 -07:00
@@ -279,90 +279,9 @@

 /* More restore stuff */

-static struct block_device * resume_bdev;
-
-
-/**
- *	Using bio to read from swap.
- *	This code requires a bit more work than just using buffer heads
- *	but, it is the recommended way for 2.5/2.6.
- *	The following are to signal the beginning and end of I/O. Bios
- *	finish asynchronously, while we want them to happen synchronously.
- *	A simple atomic_t, and a wait loop take care of this problem.
- */
-
-static atomic_t io_done = ATOMIC_INIT(0);
-
-static void start_io(void)
-{
-	atomic_set(&io_done,1);
-}
-
-static int end_io(struct bio * bio, unsigned int num, int err)
-{
-	atomic_set(&io_done,0);
-	return 0;
-}
-
-static void wait_io(void)
-{
-	while(atomic_read(&io_done))
-		io_schedule();
-}
-
-
-/**
- *	submit - submit BIO request.
- *	@rw:	READ or WRITE.
- *	@off	physical offset of page.
- *	@page:	page we're reading or writing.
- *
- *	Straight from the textbook - allocate and initialize the bio.
- *	If we're writing, make sure the page is marked as dirty.
- *	Then submit it and wait.
- */
-
-static int submit(int rw, pgoff_t page_off, void * page)
-{
-	int error = 0;
-	struct bio * bio;
-
-	bio = bio_alloc(GFP_ATOMIC,1);
-	if (!bio)
-		return -ENOMEM;
-	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
-	bio_get(bio);
-	bio->bi_bdev = resume_bdev;
-	bio->bi_end_io = end_io;
-
-	if (bio_add_page(bio, virt_to_page(page), PAGE_SIZE, 0) < PAGE_SIZE) {
-		printk("pmdisk: ERROR: adding page to bio at %ld\n",page_off);
-		error = -EFAULT;
-		goto Done;
-	}
-
-	if (rw == WRITE)
-		bio_set_pages_dirty(bio);
-	start_io();
-	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
-	wait_io();
- Done:
-	bio_put(bio);
-	return error;
-}
-
-static int
-read_page(pgoff_t page_off, void * page)
-{
-	return submit(READ,page_off,page);
-}
-
-static int
-write_page(pgoff_t page_off, void * page)
-{
-	return submit(WRITE,page_off,page);
-}
-
+extern struct block_device * resume_bdev;
+extern int bio_read_page(pgoff_t page_off, void * page);
+extern int bio_write_page(pgoff_t page_off, void * page);

 extern dev_t __init name_to_dev_t(const char *line);

@@ -372,7 +291,7 @@
 	int error;

 	memset(&pmdisk_header,0,sizeof(pmdisk_header));
-	if ((error = read_page(0,&pmdisk_header)))
+	if ((error = bio_read_page(0,&pmdisk_header)))
 		return error;
 	if (!memcmp(PMDISK_SIG,pmdisk_header.sig,10)) {
 		memcpy(pmdisk_header.sig,pmdisk_header.orig_sig,10);
@@ -380,7 +299,7 @@
 		/*
 		 * Reset swap signature now.
 		 */
-		error = write_page(0,&pmdisk_header);
+		error = bio_write_page(0,&pmdisk_header);
 	} else {
 		pr_debug(KERN_ERR "pmdisk: Invalid partition type.\n");
 		return -EINVAL;
@@ -424,7 +343,7 @@

 	init_header();

-	if ((error = read_page(swp_offset(pmdisk_header.pmdisk_info),
+	if ((error = bio_read_page(swp_offset(pmdisk_header.pmdisk_info),
 			       &pmdisk_info)))
 		return error;

@@ -456,7 +375,7 @@
 	for (i = 0; i < n && !error; i++, addr += PAGE_SIZE) {
 		unsigned long offset = swp_offset(pmdisk_info.pagedir[i]);
 		if (offset)
-			error = read_page(offset, (void *)addr);
+			error = bio_read_page(offset, (void *)addr);
 		else
 			error = -EFAULT;
 	}
@@ -483,7 +402,7 @@
 	for(i = 0, p = pagedir_nosave; i < nr_copy_pages && !error; i++, p++) {
 		if (!(i%100))
 			printk( "." );
-		error = read_page(swp_offset(p->swap_address),
+		error = bio_read_page(swp_offset(p->swap_address),
 				  (void *)p->address);
 	}
 	printk(" %d done.\n",i);
diff -Nru a/kernel/power/swsusp.c b/kernel/power/swsusp.c
--- a/kernel/power/swsusp.c	2004-07-17 14:51:13 -07:00
+++ b/kernel/power/swsusp.c	2004-07-17 14:51:13 -07:00
@@ -62,6 +62,7 @@
 #include <linux/syscalls.h>
 #include <linux/console.h>
 #include <linux/highmem.h>
+#include <linux/bio.h>

 #include <asm/uaccess.h>
 #include <asm/mmu_context.h>
@@ -1114,55 +1115,107 @@
 	return 0;
 }

-static int bdev_read_page(struct block_device *bdev, long pos, void *buf)
+
+/**
+ *	Using bio to read from swap.
+ *	This code requires a bit more work than just using buffer heads
+ *	but, it is the recommended way for 2.5/2.6.
+ *	The following are to signal the beginning and end of I/O. Bios
+ *	finish asynchronously, while we want them to happen synchronously.
+ *	A simple atomic_t, and a wait loop take care of this problem.
+ */
+
+static atomic_t io_done = ATOMIC_INIT(0);
+
+static void start_io(void)
 {
-	struct buffer_head *bh;
-	BUG_ON (pos%PAGE_SIZE);
-	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
-	if (!bh || (!bh->b_data)) {
-		return -1;
-	}
-	memcpy(buf, bh->b_data, PAGE_SIZE);	/* FIXME: may need kmap() */
-	BUG_ON(!buffer_uptodate(bh));
-	brelse(bh);
-	return 0;
-}
+	atomic_set(&io_done,1);
+}

-static int bdev_write_page(struct block_device *bdev, long pos, void *buf)
+static int end_io(struct bio * bio, unsigned int num, int err)
 {
-#if 0
-	struct buffer_head *bh;
-	BUG_ON (pos%PAGE_SIZE);
-	bh = __bread(bdev, pos/PAGE_SIZE, PAGE_SIZE);
-	if (!bh || (!bh->b_data)) {
-		return -1;
-	}
-	memcpy(bh->b_data, buf, PAGE_SIZE);	/* FIXME: may need kmap() */
-	BUG_ON(!buffer_uptodate(bh));
-	generic_make_request(WRITE, bh);
-	if (!buffer_uptodate(bh))
-		printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unsuccessful...\n", name_resume, resume_file);
-	wait_on_buffer(bh);
-	brelse(bh);
-	return 0;
-#endif
-	printk(KERN_CRIT "%sWarning %s: Fixing swap signatures unimplemented...\n", name_resume, resume_file);
+	atomic_set(&io_done,0);
 	return 0;
 }

+static void wait_io(void)
+{
+	while(atomic_read(&io_done))
+		io_schedule();
+}
+
+
+struct block_device * resume_bdev;
+
+/**
+ *	submit - submit BIO request.
+ *	@rw:	READ or WRITE.
+ *	@off	physical offset of page.
+ *	@page:	page we're reading or writing.
+ *
+ *	Straight from the textbook - allocate and initialize the bio.
+ *	If we're writing, make sure the page is marked as dirty.
+ *	Then submit it and wait.
+ */
+
+static int submit(int rw, pgoff_t page_off, void * page)
+{
+	int error = 0;
+	struct bio * bio;
+
+	bio = bio_alloc(GFP_ATOMIC,1);
+	if (!bio)
+		return -ENOMEM;
+	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
+	bio_get(bio);
+	bio->bi_bdev = resume_bdev;
+	bio->bi_end_io = end_io;
+
+	if (bio_add_page(bio, virt_to_page(page), PAGE_SIZE, 0) < PAGE_SIZE) {
+		printk("pmdisk: ERROR: adding page to bio at %ld\n",page_off);
+		error = -EFAULT;
+		goto Done;
+	}
+
+	if (rw == WRITE)
+		bio_set_pages_dirty(bio);
+	start_io();
+	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
+	wait_io();
+ Done:
+	bio_put(bio);
+	return error;
+}
+
+int bio_read_page(pgoff_t page_off, void * page)
+{
+	return submit(READ,page_off,page);
+}
+
+int bio_write_page(pgoff_t page_off, void * page)
+{
+	return submit(WRITE,page_off,page);
+}
+
+
 extern dev_t __init name_to_dev_t(const char *line);

-static int __init __read_suspend_image(struct block_device *bdev, union diskpage *cur, int noresume)
+static int __init __read_suspend_image(int noresume)
 {
+	union diskpage *cur;
 	swp_entry_t next;
 	int i, nr_pgdir_pages;

+	cur = (union diskpage *)get_zeroed_page(GFP_ATOMIC);
+	if (!cur)
+		return -ENOMEM;
+
 #define PREPARENEXT \
 	{	next = cur->link.next; \
 		next.val = swp_offset(next) * PAGE_SIZE; \
         }

-	if (bdev_read_page(bdev, 0, cur)) return -EIO;
+	if (bio_read_page(0, cur)) return -EIO;

 	if ((!memcmp("SWAP-SPACE",cur->swh.magic.magic,10)) ||
 	    (!memcmp("SWAPSPACE2",cur->swh.magic.magic,10))) {
@@ -1188,13 +1241,13 @@
 		   We need to write swap, but swap is *not* enabled so
 		   we must write the device directly */
 		printk("%s: Fixing swap signatures %s...\n", name_resume, resume_file);
-		bdev_write_page(bdev, 0, cur);
+		bio_write_page(0, cur);
 	}

 	printk( "%sSignature found, resuming\n", name_resume );
 	MDELAY(1000);

-	if (bdev_read_page(bdev, next.val, cur)) return -EIO;
+	if (bio_read_page(next.val, cur)) return -EIO;
 	if (sanity_check(&cur->sh)) 	/* Is this same machine? */
 		return -EPERM;
 	PREPARENEXT;
@@ -1214,7 +1267,7 @@
 	for (i=nr_pgdir_pages-1; i>=0; i--) {
 		BUG_ON (!next.val);
 		cur = (union diskpage *)((char *) pagedir_nosave)+i;
-		if (bdev_read_page(bdev, next.val, cur)) return -EIO;
+		if (bio_read_page(next.val, cur)) return -EIO;
 		PREPARENEXT;
 	}
 	BUG_ON (next.val);
@@ -1229,7 +1282,7 @@
 			printk( "." );
 		/* You do not need to check for overlaps...
 		   ... check_pagedir already did this work */
-		if (bdev_read_page(bdev, swp_offset(swap_address) * PAGE_SIZE, (char *)((pagedir_nosave+i)->address)))
+		if (bio_read_page(swp_offset(swap_address) * PAGE_SIZE, (char *)((pagedir_nosave+i)->address)))
 			return -EIO;
 	}
 	printk( "|\n" );
@@ -1238,48 +1291,18 @@

 static int __init read_suspend_image(const char * specialfile, int noresume)
 {
-	union diskpage *cur;
-	unsigned long scratch_page = 0;
 	int error;
 	char b[BDEVNAME_SIZE];

 	resume_device = name_to_dev_t(specialfile);
-	scratch_page = get_zeroed_page(GFP_ATOMIC);
-	cur = (void *) scratch_page;
-	if (cur) {
-		struct block_device *bdev;
-		printk("Resuming from device %s\n",
-				__bdevname(resume_device, b));
-		bdev = open_by_devnum(resume_device, FMODE_READ);
-		if (IS_ERR(bdev)) {
-			error = PTR_ERR(bdev);
-		} else {
-			set_blocksize(bdev, PAGE_SIZE);
-			error = __read_suspend_image(bdev, cur, noresume);
-			blkdev_put(bdev);
-		}
-	} else error = -ENOMEM;
-
-	if (scratch_page)
-		free_page(scratch_page);
-	switch (error) {
-		case 0:
-			PRINTK("Reading resume file was successful\n");
-			break;
-		case -EINVAL:
-			break;
-		case -EIO:
-			printk( "%sI/O error\n", name_resume);
-			break;
-		case -ENOENT:
-			printk( "%s%s: No such file or directory\n", name_resume, specialfile);
-			break;
-		case -ENOMEM:
-			printk( "%sNot enough memory\n", name_resume);
-			break;
-		default:
-			printk( "%sError %d resuming\n", name_resume, error );
-	}
+	printk("Resuming from device %s\n", __bdevname(resume_device, b));
+	resume_bdev = open_by_devnum(resume_device, FMODE_READ);
+	if (!IS_ERR(resume_bdev)) {
+		set_blocksize(resume_bdev, PAGE_SIZE);
+		error = __read_suspend_image(noresume);
+		blkdev_put(resume_bdev);
+	} else
+		error = PTR_ERR(resume_bdev);
 	MDELAY(1000);
 	return error;
 }
