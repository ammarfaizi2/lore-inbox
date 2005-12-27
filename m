Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751100AbVL0RJV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751100AbVL0RJV (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 12:09:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932352AbVL0RJV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 12:09:21 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:64699 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S1751125AbVL0RIz convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 12:08:55 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Andrew Morton <akpm@osdl.org>
Subject: [PATCH -mm 3/3] swsusp: save image header first
Date: Tue, 27 Dec 2005 18:07:24 +0100
User-Agent: KMail/1.9
Cc: Pavel Machek <pavel@suse.cz>, LKML <linux-kernel@vger.kernel.org>
References: <200512271747.43374.rjw@sisk.pl>
In-Reply-To: <200512271747.43374.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-2"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200512271807.25267.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch makes the swsusp_info structure become the header of the image
in the literal sense (ie. it is saved to the swap and read before any other
image data with the help of the swsusp's swap map structure, so generally
it is treated in the same way as the rest of the image).

The main thing it does is to make swsusp_header contain the offset of the
swap map used to track the image data pages rather than the offset
of swsusp_info.  Simultaneously, swsusp_info becomes the first image page
written to the swap.

The other changes are generally consequences of the above
with a few exceptions (there's some consolidation in the image reading
part as a few functions turn into trivial wrappers around something
else).


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>
Acked-by: Pavel Machek <pavel@suse.cz>

 kernel/power/power.h  |    1 
 kernel/power/swsusp.c |  190 +++++++++++++++++---------------------------------
 2 files changed, 65 insertions(+), 126 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2005-12-21 15:43:16.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2005-12-21 18:12:52.000000000 +0100
@@ -93,7 +93,7 @@
 
 static struct swsusp_header {
 	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
-	swp_entry_t swsusp_info;
+	swp_entry_t image;
 	char	orig_sig[10];
 	char	sig[10];
 } __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
@@ -106,7 +106,7 @@
 
 static unsigned short root_swap = 0xffff;
 
-static int mark_swapfiles(swp_entry_t prev)
+static int mark_swapfiles(swp_entry_t start)
 {
 	int error;
 
@@ -117,7 +117,7 @@
 	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
 		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
 		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
-		swsusp_header.swsusp_info = prev;
+		swsusp_header.image = start;
 		error = rw_swap_page_sync(WRITE,
 					  swp_entry(root_swap, 0),
 					  virt_to_page((unsigned long)
@@ -423,22 +423,7 @@
 	swsusp_info.cpus = num_online_cpus();
 	swsusp_info.image_pages = nr_pages;
 	swsusp_info.pages = nr_pages +
-		((nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT);
-}
-
-static int close_swap(void)
-{
-	swp_entry_t entry;
-	int error;
-
-	dump_info();
-	error = write_page((unsigned long)&swsusp_info, &entry);
-	if (!error) {
-		printk( "S" );
-		error = mark_swapfiles(entry);
-		printk( "|\n" );
-	}
-	return error;
+		((nr_pages * sizeof(long) + PAGE_SIZE - 1) >> PAGE_SHIFT) + 1;
 }
 
 /**
@@ -522,6 +507,7 @@
 {
 	struct swap_map_page *swap_map;
 	struct swap_map_handle handle;
+	swp_entry_t start;
 	int error;
 
 	if ((error = swsusp_swap_check())) {
@@ -539,18 +525,23 @@
 		return -ENOMEM;
 	init_swap_map_handle(&handle, swap_map);
 
-	error = save_image_metadata(pblist, &handle);
+	error = swap_map_write_page(&handle, (unsigned long)&swsusp_info);
+	if (!error)
+		error = save_image_metadata(pblist, &handle);
 	if (!error)
 		error = save_image_data(pblist, &handle, nr_pages);
 	if (error)
 		goto Free_image_entries;
 
 	swap_map = reverse_swap_map(swap_map);
-	error = save_swap_map(swap_map, &swsusp_info.start);
+	error = save_swap_map(swap_map, &start);
 	if (error)
 		goto Free_map_entries;
 
-	error = close_swap();
+	dump_info();
+	printk( "S" );
+	error = mark_swapfiles(start);
+	printk( "|\n" );
 	if (error)
 		goto Free_map_entries;
 
@@ -840,70 +831,28 @@
 	return error;
 }
 
-/*
- * Sanity check if this image makes sense with this kernel/swap context
- * I really don't think that it's foolproof but more than nothing..
- */
-
-static const char *sanity_check(void)
+static int check_header(void)
 {
+	char *reason = NULL;
+
 	dump_info();
 	if (swsusp_info.version_code != LINUX_VERSION_CODE)
-		return "kernel version";
+		reason = "kernel version";
 	if (swsusp_info.num_physpages != num_physpages)
-		return "memory size";
+		reason = "memory size";
 	if (strcmp(swsusp_info.uts.sysname,system_utsname.sysname))
-		return "system type";
+		reason = "system type";
 	if (strcmp(swsusp_info.uts.release,system_utsname.release))
-		return "kernel release";
+		reason = "kernel release";
 	if (strcmp(swsusp_info.uts.version,system_utsname.version))
-		return "version";
+		reason = "version";
 	if (strcmp(swsusp_info.uts.machine,system_utsname.machine))
-		return "machine";
-#if 0
-	/* We can't use number of online CPUs when we use hotplug to remove them ;-))) */
-	if (swsusp_info.cpus != num_possible_cpus())
-		return "number of cpus";
-#endif
-	return NULL;
-}
-
-static int check_header(void)
-{
-	const char *reason = NULL;
-	int error;
-
-	if ((error = bio_read_page(swp_offset(swsusp_header.swsusp_info), &swsusp_info)))
-		return error;
-
- 	/* Is this same machine? */
-	if ((reason = sanity_check())) {
-		printk(KERN_ERR "swsusp: Resume mismatch: %s\n",reason);
+		reason = "machine";
+	if (reason) {
+		printk(KERN_ERR "swsusp: Resume mismatch: %s\n", reason);
 		return -EPERM;
 	}
-	return error;
-}
-
-static int check_sig(void)
-{
-	int error;
-
-	memset(&swsusp_header, 0, sizeof(swsusp_header));
-	if ((error = bio_read_page(0, &swsusp_header)))
-		return error;
-	if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
-		memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
-
-		/*
-		 * Reset swap signature now.
-		 */
-		error = bio_write_page(0, &swsusp_header);
-	} else {
-		return -EINVAL;
-	}
-	if (!error)
-		pr_debug("swsusp: Signature found, resuming\n");
-	return error;
+	return 0;
 }
 
 /**
@@ -989,33 +938,29 @@
 	return error;
 }
 
-static int check_suspend_image(void)
-{
-	int error = 0;
-
-	if ((error = check_sig()))
-		return error;
-
-	if ((error = check_header()))
-		return error;
-
-	return 0;
-}
-
-static int read_suspend_image(struct pbe **pblist_ptr)
+int swsusp_read(struct pbe **pblist_ptr)
 {
-	int error = 0;
+	int error;
 	struct pbe *p, *pblist;
 	struct swap_map_handle handle;
-	unsigned int nr_pages = swsusp_info.image_pages;
+	unsigned int nr_pages;
 
+	if (IS_ERR(resume_bdev)) {
+		pr_debug("swsusp: block device not initialised\n");
+		return PTR_ERR(resume_bdev);
+	}
+
+	error = get_swap_map_reader(&handle, swsusp_header.image);
+	if (!error)
+		error = swap_map_read_page(&handle, &swsusp_info);
+	if (!error)
+		error = check_header();
+	if (error)
+		return error;
+	nr_pages = swsusp_info.image_pages;
 	p = alloc_pagedir(nr_pages, GFP_ATOMIC, 0);
 	if (!p)
 		return -ENOMEM;
-	error = get_swap_map_reader(&handle, swsusp_info.start);
-	if (error)
-		/* The PBE list at p will be released by swsusp_free() */
-		return error;
 	error = load_image_metadata(p, &handle);
 	if (!error) {
 		mark_unsafe_pages(p);
@@ -1037,11 +982,18 @@
 			*pblist_ptr = pblist;
 	}
 	release_swap_map_reader(&handle);
+
+	blkdev_put(resume_bdev);
+
+	if (!error)
+		pr_debug("swsusp: Reading resume file was successful\n");
+	else
+		pr_debug("swsusp: Error %d resuming\n", error);
 	return error;
 }
 
 /**
- *      swsusp_check - Check for saved image in swap
+ *      swsusp_check - Check for swsusp signature in the resume device
  */
 
 int swsusp_check(void)
@@ -1051,39 +1003,27 @@
 	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
 	if (!IS_ERR(resume_bdev)) {
 		set_blocksize(resume_bdev, PAGE_SIZE);
-		error = check_suspend_image();
+		memset(&swsusp_header, 0, sizeof(swsusp_header));
+		if ((error = bio_read_page(0, &swsusp_header)))
+			return error;
+		if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
+			memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
+			/* Reset swap signature now */
+			error = bio_write_page(0, &swsusp_header);
+		} else {
+			return -EINVAL;
+		}
 		if (error)
-		    blkdev_put(resume_bdev);
-	} else
+			blkdev_put(resume_bdev);
+		else
+			pr_debug("swsusp: Signature found, resuming\n");
+	} else {
 		error = PTR_ERR(resume_bdev);
-
-	if (!error)
-		pr_debug("swsusp: resume file found\n");
-	else
-		pr_debug("swsusp: Error %d check for resume file\n", error);
-	return error;
-}
-
-/**
- *	swsusp_read - Read saved image from swap.
- */
-
-int swsusp_read(struct pbe **pblist_ptr)
-{
-	int error;
-
-	if (IS_ERR(resume_bdev)) {
-		pr_debug("swsusp: block device not initialised\n");
-		return PTR_ERR(resume_bdev);
 	}
 
-	error = read_suspend_image(pblist_ptr);
-	blkdev_put(resume_bdev);
+	if (error)
+		pr_debug("swsusp: Error %d check for resume file\n", error);
 
-	if (!error)
-		pr_debug("swsusp: Reading resume file was successful\n");
-	else
-		pr_debug("swsusp: Error %d resuming\n", error);
 	return error;
 }
 
Index: linux-2.6.15-rc5-mm3/kernel/power/power.h
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/power.h	2005-12-21 15:43:16.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/power.h	2005-12-21 17:08:09.000000000 +0100
@@ -16,7 +16,6 @@
 	int			cpus;
 	unsigned long		image_pages;
 	unsigned long		pages;
-	swp_entry_t		start;
 } __attribute__((aligned(PAGE_SIZE)));
 
 
