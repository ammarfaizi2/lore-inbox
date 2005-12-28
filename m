Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932423AbVL1Alp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932423AbVL1Alp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 19:41:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932425AbVL1Alk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 19:41:40 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:33981 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S932423AbVL1AlR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 19:41:17 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Linux PM <linux-pm@osdl.org>
Subject: [RFC/RFT][PATCH -mm 3/4] swsusp: separate swap-writing and reading code
Date: Wed, 28 Dec 2005 01:28:45 +0100
User-Agent: KMail/1.9
Cc: LKML <linux-kernel@vger.kernel.org>, Pavel Machek <pavel@suse.cz>
References: <200512280108.47253.rjw@sisk.pl>
In-Reply-To: <200512280108.47253.rjw@sisk.pl>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512280128.45902.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

This patch moves the in-kernel swap-swap-writing and reading code to
a separate file.


Signed-off-by: Rafael J. Wysocki <rjw@sisk.pl>

 kernel/power/Makefile |    2 
 kernel/power/swap.c   |  641 ++++++++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c |  629 -------------------------------------------------
 3 files changed, 644 insertions(+), 628 deletions(-)

Index: linux-2.6.15-rc5-mm3/kernel/power/Makefile
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/Makefile	2005-12-27 22:33:08.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/Makefile	2005-12-27 23:39:20.000000000 +0100
@@ -5,7 +5,7 @@ endif
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o user.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o user.o swap.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
Index: linux-2.6.15-rc5-mm3/kernel/power/swap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-rc5-mm3/kernel/power/swap.c	2005-12-27 23:44:45.000000000 +0100
@@ -0,0 +1,641 @@
+/*
+ * linux/kernel/power/swap.c
+ *
+ * This file provides functions for reading the suspend image from
+ * and writing it to a swap partition.
+ *
+ * Copyright (C) 1998,2001-2005 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2005 Rafael J. Wysocki <rjw@sisk.pl>
+ *
+ * This file is released under the GPLv2.
+ *
+ */
+
+#include <linux/module.h>
+#include <linux/smp_lock.h>
+#include <linux/file.h>
+#include <linux/utsname.h>
+#include <linux/version.h>
+#include <linux/delay.h>
+#include <linux/bitops.h>
+#include <linux/genhd.h>
+#include <linux/device.h>
+#include <linux/buffer_head.h>
+#include <linux/bio.h>
+#include <linux/swap.h>
+#include <linux/swapops.h>
+#include <linux/pm.h>
+
+#include "power.h"
+
+extern int swsusp_get_swap_index(void);
+extern unsigned int swsusp_available_swap(unsigned int swap);
+
+extern char resume_file[];
+
+#define SWSUSP_SIG	"S1SUSPEND"
+
+static struct swsusp_header {
+	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
+	swp_entry_t image;
+	char	orig_sig[10];
+	char	sig[10];
+} __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
+
+/*
+ * Saving part...
+ */
+
+static unsigned short root_swap = 0xffff;
+
+static int mark_swapfiles(swp_entry_t start)
+{
+	int error;
+
+	rw_swap_page_sync(READ,
+			  swp_entry(root_swap, 0),
+			  virt_to_page((unsigned long)&swsusp_header));
+	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
+	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
+		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
+		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
+		swsusp_header.image = start;
+		error = rw_swap_page_sync(WRITE,
+					  swp_entry(root_swap, 0),
+					  virt_to_page((unsigned long)
+						       &swsusp_header));
+	} else {
+		pr_debug("swsusp: Partition is not swap space.\n");
+		error = -ENODEV;
+	}
+	return error;
+}
+
+static int swsusp_swap_check(void) /* This is called before saving image */
+{
+	int res = swsusp_get_swap_index();
+
+	if (res >= 0) {
+		root_swap = res;
+		return 0;
+	}
+	return res;
+}
+
+/**
+ *	write_page - Write one page to a fresh swap location.
+ *	@buf:	Address we're writing.
+ *	@loc:	Place to store the entry we used.
+ */
+
+static int write_page(void *buf, swp_entry_t *loc)
+{
+	swp_entry_t entry;
+	int error = -ENOSPC;
+
+	entry = get_swap_page_of_type(root_swap);
+	if (swp_offset(entry)) {
+		error = rw_swap_page_sync(WRITE, entry, virt_to_page(buf));
+		if (!error)
+			*loc = entry;
+		else
+			swap_free(entry);
+	}
+	return error;
+}
+
+/**
+ *	Swap map-handling functions
+ *
+ *	The swap map is a data structure used for keeping track of each page
+ *	written to the swap.  It consists of many swap_map_page structures
+ *	that contain each an array of MAP_PAGE_SIZE swap entries.
+ *	These structures are linked together with the help of either the
+ *	.next (in memory) or the .next_swap (in swap) member.
+ *
+ *	The swap map is created during suspend.  At that time we need to keep
+ *	it in memory, because we have to free all of the allocated swap
+ *	entries if an error occurs.  The memory needed is preallocated
+ *	so that we know in advance if there's enough of it.
+ *
+ *	The first swap_map_page structure is filled with the swap entries that
+ *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
+ *	so on.  After the all of the data pages have been written, the order
+ *	of the swap_map_page structures in the map is reversed so that they
+ *	can be read from swap in the original order.  This causes the data
+ *	pages to be loaded in exactly the same order in which they have been
+ *	saved.
+ *
+ *	During resume we only need to use one swap_map_page structure
+ *	at a time, which means that we only need to use two memory pages for
+ *	reading the image - one for reading the swap_map_page structures
+ *	and the second for reading the data pages from swap.
+ */
+
+#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(swp_entry_t) - sizeof(void *)) \
+			/ sizeof(swp_entry_t))
+
+struct swap_map_page {
+	swp_entry_t		entries[MAP_PAGE_SIZE];
+	swp_entry_t		next_swap;
+	struct swap_map_page	*next;
+};
+
+static inline void free_swap_map(struct swap_map_page *swap_map)
+{
+	struct swap_map_page *swp;
+
+	while (swap_map) {
+		swp = swap_map->next;
+		free_page((unsigned long)swap_map);
+		swap_map = swp;
+	}
+}
+
+static struct swap_map_page *alloc_swap_map(unsigned int nr_pages)
+{
+	struct swap_map_page *swap_map, *swp;
+	unsigned n = 0;
+
+	if (!nr_pages)
+		return NULL;
+
+	pr_debug("alloc_swap_map(): nr_pages = %d\n", nr_pages);
+	swap_map = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
+	swp = swap_map;
+	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
+		swp->next = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
+		swp = swp->next;
+		if (!swp) {
+			free_swap_map(swap_map);
+			return NULL;
+		}
+	}
+	return swap_map;
+}
+
+/**
+ *	reverse_swap_map - reverse the order of pages in the swap map
+ *	@swap_map
+ */
+
+static inline struct swap_map_page *reverse_swap_map(struct swap_map_page *swap_map)
+{
+	struct swap_map_page *prev, *next;
+
+	prev = NULL;
+	while (swap_map) {
+		next = swap_map->next;
+		swap_map->next = prev;
+		prev = swap_map;
+		swap_map = next;
+	}
+	return prev;
+}
+
+/**
+ *	free_swap_map_entries - free the swap entries allocated to store
+ *	the swap map @swap_map (this is only called in case of an error)
+ */
+static inline void free_swap_map_entries(struct swap_map_page *swap_map)
+{
+	while (swap_map) {
+		if (swap_map->next_swap.val)
+			swap_free(swap_map->next_swap);
+		swap_map = swap_map->next;
+	}
+}
+
+/**
+ *	save_swap_map - save the swap map used for tracing the data pages
+ *	stored in the swap
+ */
+
+static int save_swap_map(struct swap_map_page *swap_map, swp_entry_t *start)
+{
+	swp_entry_t entry = (swp_entry_t){0};
+	int error;
+
+	while (swap_map) {
+		swap_map->next_swap = entry;
+		if ((error = write_page(swap_map, &entry)))
+			return error;
+		swap_map = swap_map->next;
+	}
+	*start = entry;
+	return 0;
+}
+
+/**
+ *	free_image_entries - free the swap entries allocated to store
+ *	the image data pages (this is only called in case of an error)
+ */
+
+static inline void free_image_entries(struct swap_map_page *swp)
+{
+	unsigned k;
+
+	while (swp) {
+		for (k = 0; k < MAP_PAGE_SIZE; k++)
+			if (swp->entries[k].val)
+				swap_free(swp->entries[k]);
+		swp = swp->next;
+	}
+}
+
+/**
+ *	The swap_map_handle structure is used for handling the swap map in
+ *	a file-alike way
+ */
+
+struct swap_map_handle {
+	struct swap_map_page *cur;
+	unsigned int k;
+};
+
+static inline void init_swap_map_handle(struct swap_map_handle *handle,
+                                        struct swap_map_page *map)
+{
+	handle->cur = map;
+	handle->k = 0;
+}
+
+static inline int swap_map_write_page(struct swap_map_handle *handle, void *buf)
+{
+	int error;
+
+	error = write_page(buf, handle->cur->entries + handle->k);
+	if (error)
+		return error;
+	if (++handle->k >= MAP_PAGE_SIZE) {
+		handle->cur = handle->cur->next;
+		handle->k = 0;
+	}
+	return 0;
+}
+
+/**
+ *	save_image - save the suspend image data
+ */
+
+static int save_image(struct swap_map_handle *handle,
+                      struct snapshot_handle *snapshot,
+                      unsigned int nr_pages)
+{
+	unsigned int m;
+	int ret;
+	int error = 0;
+
+	printk("Saving image data pages (%u pages) ...     ", nr_pages);
+	m = nr_pages / 100;
+	if (!m)
+		m = 1;
+	nr_pages = 0;
+	do {
+		ret = snapshot_read_next(snapshot, PAGE_SIZE);
+		if (ret > 0) {
+			error = swap_map_write_page(handle, data_of(*snapshot));
+			if (error)
+				break;
+			if (!(nr_pages % m))
+				printk("\b\b\b\b%3d%%", nr_pages / m);
+			nr_pages++;
+		}
+	} while (ret > 0);
+	if (!error)
+		printk("\b\b\b\bdone\n");
+	return error;
+}
+
+/**
+ *	enough_swap - Make sure we have enough swap to save the image.
+ *
+ *	Returns TRUE or FALSE after checking the total amount of swap
+ *	space avaiable from the resume partition.
+ */
+
+static int enough_swap(unsigned int nr_pages)
+{
+	unsigned int free_swap = swsusp_available_swap(root_swap);
+
+	pr_debug("swsusp: free swap pages: %u\n", free_swap);
+	return free_swap > (nr_pages + PAGES_FOR_IO +
+		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
+}
+
+/**
+ *	swsusp_write - Write entire image and metadata.
+ *
+ *	It is important _NOT_ to umount filesystems at this point. We want
+ *	them synced (in case something goes wrong) but we DO not want to mark
+ *	filesystem clean: it is not. (And it does not matter, if we resume
+ *	correctly, we'll mark system clean, anyway.)
+ */
+
+int swsusp_write(void)
+{
+	struct swap_map_page *swap_map;
+	struct swap_map_handle handle;
+	struct snapshot_handle snapshot;
+	struct swsusp_info *header;
+	unsigned int nr_pages;
+	swp_entry_t start;
+	int error;
+
+	if ((error = swsusp_swap_check())) {
+		printk(KERN_ERR "swsusp: Cannot find swap device, try swapon -a.\n");
+		return error;
+	}
+	memset(&snapshot, 0, sizeof(struct snapshot_handle));
+	error = snapshot_read_next(&snapshot, PAGE_SIZE);
+	if (error < PAGE_SIZE)
+		return error < 0 ? error : -EFAULT;
+	header = (struct swsusp_info *)data_of(snapshot);
+	nr_pages = header->image_pages;
+	if (!enough_swap(nr_pages)) {
+		printk(KERN_ERR "swsusp: Not enough free swap\n");
+		return -ENOSPC;
+	}
+	swap_map = alloc_swap_map(header->pages);
+	if (!swap_map)
+		return -ENOMEM;
+	init_swap_map_handle(&handle, swap_map);
+
+	error = swap_map_write_page(&handle, header);
+	if (!error)
+		error = save_image(&handle, &snapshot, nr_pages);
+	if (error)
+		goto Free_image_entries;
+
+	swap_map = reverse_swap_map(swap_map);
+	error = save_swap_map(swap_map, &start);
+	if (error)
+		goto Free_map_entries;
+
+	printk( "S" );
+	error = mark_swapfiles(start);
+	printk( "|\n" );
+	if (error)
+		goto Free_map_entries;
+
+Free_swap_map:
+	free_swap_map(swap_map);
+	return error;
+
+Free_map_entries:
+	free_swap_map_entries(swap_map);
+Free_image_entries:
+	free_image_entries(swap_map);
+	goto Free_swap_map;
+}
+
+/*
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
+static int end_io(struct bio *bio, unsigned int num, int err)
+{
+	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
+		panic("I/O error reading memory image");
+	atomic_set(&io_done, 0);
+	return 0;
+}
+
+static struct block_device *resume_bdev;
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
+static int submit(int rw, pgoff_t page_off, void *page)
+{
+	int error = 0;
+	struct bio *bio;
+
+	bio = bio_alloc(GFP_ATOMIC, 1);
+	if (!bio)
+		return -ENOMEM;
+	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
+	bio_get(bio);
+	bio->bi_bdev = resume_bdev;
+	bio->bi_end_io = end_io;
+
+	if (bio_add_page(bio, virt_to_page(page), PAGE_SIZE, 0) < PAGE_SIZE) {
+		printk("swsusp: ERROR: adding page to bio at %ld\n",page_off);
+		error = -EFAULT;
+		goto Done;
+	}
+
+	if (rw == WRITE)
+		bio_set_pages_dirty(bio);
+
+	atomic_set(&io_done, 1);
+	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
+	while (atomic_read(&io_done))
+		yield();
+
+ Done:
+	bio_put(bio);
+	return error;
+}
+
+static int bio_read_page(pgoff_t page_off, void *page)
+{
+	return submit(READ, page_off, page);
+}
+
+static int bio_write_page(pgoff_t page_off, void *page)
+{
+	return submit(WRITE, page_off, page);
+}
+
+/**
+ *	The following functions allow us to read data using a swap map
+ *	in a file-alike way
+ */
+
+static inline void release_swap_map_reader(struct swap_map_handle *handle)
+{
+	if (handle->cur)
+		free_page((unsigned long)handle->cur);
+	handle->cur = NULL;
+}
+
+static inline int get_swap_map_reader(struct swap_map_handle *handle,
+                                      swp_entry_t start)
+{
+	int error;
+
+	if (!swp_offset(start))
+		return -EINVAL;
+	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
+	if (!handle->cur)
+		return -ENOMEM;
+	error = bio_read_page(swp_offset(start), handle->cur);
+	if (error) {
+		release_swap_map_reader(handle);
+		return error;
+	}
+	handle->k = 0;
+	return 0;
+}
+
+static inline int swap_map_read_page(struct swap_map_handle *handle, void *buf)
+{
+	unsigned long offset;
+	int error;
+
+	if (!handle->cur)
+		return -EINVAL;
+	offset = swp_offset(handle->cur->entries[handle->k]);
+	if (!offset)
+		return -EFAULT;
+	error = bio_read_page(offset, buf);
+	if (error)
+		return error;
+	if (++handle->k >= MAP_PAGE_SIZE) {
+		handle->k = 0;
+		offset = swp_offset(handle->cur->next_swap);
+		if (!offset)
+			release_swap_map_reader(handle);
+		else
+			error = bio_read_page(offset, handle->cur);
+	}
+	return error;
+}
+
+/**
+ *	load_image - load the image using the swap map handle
+ *	@handle and the snapshot handle @snapshot
+ *	(assume there are @nr_pages pages to load)
+ */
+
+static int load_image(struct swap_map_handle *handle,
+                      struct snapshot_handle *snapshot,
+                      unsigned int nr_pages)
+{
+	unsigned int m;
+	int ret;
+	int error = 0;
+
+	printk("Loading image data pages (%u pages) ...     ", nr_pages);
+	m = nr_pages / 100;
+	if (!m)
+		m = 1;
+	nr_pages = 0;
+	do {
+		ret = snapshot_write_next(snapshot, PAGE_SIZE);
+		if (ret > 0) {
+			error = swap_map_read_page(handle, data_of(*snapshot));
+			if (error)
+				break;
+			if (!(nr_pages % m))
+				printk("\b\b\b\b%3d%%", nr_pages / m);
+			nr_pages++;
+		}
+	} while (ret > 0);
+	if (!error)
+		printk("\b\b\b\bdone\n");
+	if (!snapshot_image_ready(snapshot))
+		error = -ENODATA;
+	return error;
+}
+
+int swsusp_read(void)
+{
+	int error;
+	struct swap_map_handle handle;
+	struct snapshot_handle snapshot;
+	struct swsusp_info *header;
+	unsigned int nr_pages;
+
+	if (IS_ERR(resume_bdev)) {
+		pr_debug("swsusp: block device not initialised\n");
+		return PTR_ERR(resume_bdev);
+	}
+
+	memset(&snapshot, 0, sizeof(struct snapshot_handle));
+	error = snapshot_write_next(&snapshot, PAGE_SIZE);
+	if (error < PAGE_SIZE)
+		return error < 0 ? error : -EFAULT;
+	header = (struct swsusp_info *)data_of(snapshot);
+	error = get_swap_map_reader(&handle, swsusp_header.image);
+	if (!error)
+		error = swap_map_read_page(&handle, header);
+	if (!error) {
+		nr_pages = header->image_pages;
+		error = load_image(&handle, &snapshot, nr_pages);
+	}
+	release_swap_map_reader(&handle);
+
+	blkdev_put(resume_bdev);
+
+	if (!error)
+		pr_debug("swsusp: Reading resume file was successful\n");
+	else
+		pr_debug("swsusp: Error %d resuming\n", error);
+	return error;
+}
+
+/**
+ *      swsusp_check - Check for swsusp signature in the resume device
+ */
+
+int swsusp_check(void)
+{
+	int error;
+
+	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
+	if (!IS_ERR(resume_bdev)) {
+		set_blocksize(resume_bdev, PAGE_SIZE);
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
+		if (error)
+			blkdev_put(resume_bdev);
+		else
+			pr_debug("swsusp: Signature found, resuming\n");
+	} else {
+		error = PTR_ERR(resume_bdev);
+	}
+
+	if (error)
+		pr_debug("swsusp: Error %d check for resume file\n", error);
+
+	return error;
+}
+
+/**
+ *	swsusp_close - close swap device.
+ */
+
+void swsusp_close(void)
+{
+	if (IS_ERR(resume_bdev)) {
+		pr_debug("swsusp: block device not initialised\n");
+		return;
+	}
+
+	blkdev_put(resume_bdev);
+}
Index: linux-2.6.15-rc5-mm3/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-rc5-mm3.orig/kernel/power/swsusp.c	2005-12-27 21:53:03.000000000 +0100
+++ linux-2.6.15-rc5-mm3/kernel/power/swsusp.c	2005-12-27 23:42:40.000000000 +0100
@@ -38,34 +38,17 @@
  * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
  */
 
-#include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/suspend.h>
-#include <linux/smp_lock.h>
-#include <linux/file.h>
-#include <linux/utsname.h>
-#include <linux/version.h>
-#include <linux/delay.h>
-#include <linux/bitops.h>
 #include <linux/spinlock.h>
-#include <linux/genhd.h>
 #include <linux/kernel.h>
 #include <linux/major.h>
 #include <linux/swap.h>
 #include <linux/pm.h>
-#include <linux/device.h>
-#include <linux/buffer_head.h>
 #include <linux/swapops.h>
 #include <linux/bootmem.h>
 #include <linux/syscalls.h>
 #include <linux/highmem.h>
-#include <linux/bio.h>
-
-#include <asm/uaccess.h>
-#include <asm/mmu_context.h>
-#include <asm/pgtable.h>
-#include <asm/tlbflush.h>
-#include <asm/io.h>
 
 #include "power.h"
 
@@ -89,47 +72,7 @@ static int restore_highmem(void) { retur
 static unsigned int count_highmem_pages(void) { return 0; }
 #endif
 
-extern char resume_file[];
-
-#define SWSUSP_SIG	"S1SUSPEND"
-
-static struct swsusp_header {
-	char reserved[PAGE_SIZE - 20 - sizeof(swp_entry_t)];
-	swp_entry_t image;
-	char	orig_sig[10];
-	char	sig[10];
-} __attribute__((packed, aligned(PAGE_SIZE))) swsusp_header;
-
-/*
- * Saving part...
- */
-
-static unsigned short root_swap = 0xffff;
-
-static int mark_swapfiles(swp_entry_t start)
-{
-	int error;
-
-	rw_swap_page_sync(READ,
-			  swp_entry(root_swap, 0),
-			  virt_to_page((unsigned long)&swsusp_header));
-	if (!memcmp("SWAP-SPACE",swsusp_header.sig, 10) ||
-	    !memcmp("SWAPSPACE2",swsusp_header.sig, 10)) {
-		memcpy(swsusp_header.orig_sig,swsusp_header.sig, 10);
-		memcpy(swsusp_header.sig,SWSUSP_SIG, 10);
-		swsusp_header.image = start;
-		error = rw_swap_page_sync(WRITE,
-					  swp_entry(root_swap, 0),
-					  virt_to_page((unsigned long)
-						       &swsusp_header));
-	} else {
-		pr_debug("swsusp: Partition is not swap space.\n");
-		error = -ENODEV;
-	}
-	return error;
-}
-
-/*
+/**
  * Check whether the swap device is the specified resume
  * device, irrespective of whether they are specified by
  * identical names.
@@ -140,6 +83,7 @@ static int mark_swapfiles(swp_entry_t st
  * devfs, since the resume code can only recognize the form /dev/hda4,
  * but the suspend code would see the long name.)
  */
+
 static inline int is_resume_device(const struct swap_info_struct *swap_info)
 {
 	struct file *file = swap_info->swap_file;
@@ -168,242 +112,6 @@ int swsusp_get_swap_index(void)
 	return -ENODEV;
 }
 
-static int swsusp_swap_check(void) /* This is called before saving image */
-{
-	int res = swsusp_get_swap_index();
-
-	if (res >= 0) {
-		root_swap = res;
-		return 0;
-	}
-	return res;
-}
-
-/**
- *	write_page - Write one page to a fresh swap location.
- *	@buf:	Address we're writing.
- *	@loc:	Place to store the entry we used.
- */
-
-static int write_page(void *buf, swp_entry_t *loc)
-{
-	swp_entry_t entry;
-	int error = -ENOSPC;
-
-	entry = get_swap_page_of_type(root_swap);
-	if (swp_offset(entry)) {
-		error = rw_swap_page_sync(WRITE, entry, virt_to_page(buf));
-		if (!error)
-			*loc = entry;
-		else
-			swap_free(entry);
-	}
-	return error;
-}
-
-/**
- *	Swap map-handling functions
- *
- *	The swap map is a data structure used for keeping track of each page
- *	written to the swap.  It consists of many swap_map_page structures
- *	that contain each an array of MAP_PAGE_SIZE swap entries.
- *	These structures are linked together with the help of either the
- *	.next (in memory) or the .next_swap (in swap) member.
- *
- *	The swap map is created during suspend.  At that time we need to keep
- *	it in memory, because we have to free all of the allocated swap
- *	entries if an error occurs.  The memory needed is preallocated
- *	so that we know in advance if there's enough of it.
- *
- *	The first swap_map_page structure is filled with the swap entries that
- *	correspond to the first MAP_PAGE_SIZE data pages written to swap and
- *	so on.  After the all of the data pages have been written, the order
- *	of the swap_map_page structures in the map is reversed so that they
- *	can be read from swap in the original order.  This causes the data
- *	pages to be loaded in exactly the same order in which they have been
- *	saved.
- *
- *	During resume we only need to use one swap_map_page structure
- *	at a time, which means that we only need to use two memory pages for
- *	reading the image - one for reading the swap_map_page structures
- *	and the second for reading the data pages from swap.
- */
-
-#define MAP_PAGE_SIZE	((PAGE_SIZE - sizeof(swp_entry_t) - sizeof(void *)) \
-			/ sizeof(swp_entry_t))
-
-struct swap_map_page {
-	swp_entry_t		entries[MAP_PAGE_SIZE];
-	swp_entry_t		next_swap;
-	struct swap_map_page	*next;
-};
-
-static inline void free_swap_map(struct swap_map_page *swap_map)
-{
-	struct swap_map_page *swp;
-
-	while (swap_map) {
-		swp = swap_map->next;
-		free_page((unsigned long)swap_map);
-		swap_map = swp;
-	}
-}
-
-static struct swap_map_page *alloc_swap_map(unsigned int nr_pages)
-{
-	struct swap_map_page *swap_map, *swp;
-	unsigned n = 0;
-
-	if (!nr_pages)
-		return NULL;
-
-	pr_debug("alloc_swap_map(): nr_pages = %d\n", nr_pages);
-	swap_map = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
-	swp = swap_map;
-	for (n = MAP_PAGE_SIZE; n < nr_pages; n += MAP_PAGE_SIZE) {
-		swp->next = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
-		swp = swp->next;
-		if (!swp) {
-			free_swap_map(swap_map);
-			return NULL;
-		}
-	}
-	return swap_map;
-}
-
-/**
- *	reverse_swap_map - reverse the order of pages in the swap map
- *	@swap_map
- */
-
-static inline struct swap_map_page *reverse_swap_map(struct swap_map_page *swap_map)
-{
-	struct swap_map_page *prev, *next;
-
-	prev = NULL;
-	while (swap_map) {
-		next = swap_map->next;
-		swap_map->next = prev;
-		prev = swap_map;
-		swap_map = next;
-	}
-	return prev;
-}
-
-/**
- *	free_swap_map_entries - free the swap entries allocated to store
- *	the swap map @swap_map (this is only called in case of an error)
- */
-static inline void free_swap_map_entries(struct swap_map_page *swap_map)
-{
-	while (swap_map) {
-		if (swap_map->next_swap.val)
-			swap_free(swap_map->next_swap);
-		swap_map = swap_map->next;
-	}
-}
-
-/**
- *	save_swap_map - save the swap map used for tracing the data pages
- *	stored in the swap
- */
-
-static int save_swap_map(struct swap_map_page *swap_map, swp_entry_t *start)
-{
-	swp_entry_t entry = (swp_entry_t){0};
-	int error;
-
-	while (swap_map) {
-		swap_map->next_swap = entry;
-		if ((error = write_page(swap_map, &entry)))
-			return error;
-		swap_map = swap_map->next;
-	}
-	*start = entry;
-	return 0;
-}
-
-/**
- *	free_image_entries - free the swap entries allocated to store
- *	the image data pages (this is only called in case of an error)
- */
-
-static inline void free_image_entries(struct swap_map_page *swp)
-{
-	unsigned k;
-
-	while (swp) {
-		for (k = 0; k < MAP_PAGE_SIZE; k++)
-			if (swp->entries[k].val)
-				swap_free(swp->entries[k]);
-		swp = swp->next;
-	}
-}
-
-/**
- *	The swap_map_handle structure is used for handling the swap map in
- *	a file-alike way
- */
-
-struct swap_map_handle {
-	struct swap_map_page *cur;
-	unsigned int k;
-};
-
-static inline void init_swap_map_handle(struct swap_map_handle *handle,
-                                        struct swap_map_page *map)
-{
-	handle->cur = map;
-	handle->k = 0;
-}
-
-static inline int swap_map_write_page(struct swap_map_handle *handle, void *buf)
-{
-	int error;
-
-	error = write_page(buf, handle->cur->entries + handle->k);
-	if (error)
-		return error;
-	if (++handle->k >= MAP_PAGE_SIZE) {
-		handle->cur = handle->cur->next;
-		handle->k = 0;
-	}
-	return 0;
-}
-
-/**
- *	save_image - save the suspend image data
- */
-
-static int save_image(struct swap_map_handle *handle,
-                      struct snapshot_handle *snapshot,
-                      unsigned int nr_pages)
-{
-	unsigned int m;
-	int ret;
-	int error = 0;
-
-	printk("Saving image data pages (%u pages) ...     ", nr_pages);
-	m = nr_pages / 100;
-	if (!m)
-		m = 1;
-	nr_pages = 0;
-	do {
-		ret = snapshot_read_next(snapshot, PAGE_SIZE);
-		if (ret > 0) {
-			error = swap_map_write_page(handle, data_of(*snapshot));
-			if (error)
-				break;
-			if (!(nr_pages % m))
-				printk("\b\b\b\b%3d%%", nr_pages / m);
-			nr_pages++;
-		}
-	} while (ret > 0);
-	if (!error)
-		printk("\b\b\b\bdone\n");
-	return error;
-}
-
 /**
  *	swsusp_available_swap - check the total amount of swap
  *	space avaiable from given swap partition/file
@@ -424,88 +132,6 @@ unsigned int swsusp_available_swap(unsig
 }
 
 /**
- *	enough_swap - Make sure we have enough swap to save the image.
- *
- *	Returns TRUE or FALSE after checking the total amount of swap
- *	space avaiable from the resume partition.
- */
-
-static int enough_swap(unsigned int nr_pages)
-{
-	unsigned int free_swap = swsusp_available_swap(root_swap);
-
-	pr_debug("swsusp: free swap pages: %u\n", free_swap);
-	return free_swap > (nr_pages + PAGES_FOR_IO +
-		(nr_pages + PBES_PER_PAGE - 1) / PBES_PER_PAGE);
-}
-
-/**
- *	swsusp_write - Write entire image and metadata.
- *
- *	It is important _NOT_ to umount filesystems at this point. We want
- *	them synced (in case something goes wrong) but we DO not want to mark
- *	filesystem clean: it is not. (And it does not matter, if we resume
- *	correctly, we'll mark system clean, anyway.)
- */
-
-int swsusp_write(void)
-{
-	struct swap_map_page *swap_map;
-	struct swap_map_handle handle;
-	struct snapshot_handle snapshot;
-	struct swsusp_info *header;
-	unsigned int nr_pages;
-	swp_entry_t start;
-	int error;
-
-	if ((error = swsusp_swap_check())) {
-		printk(KERN_ERR "swsusp: Cannot find swap device, try swapon -a.\n");
-		return error;
-	}
-	memset(&snapshot, 0, sizeof(struct snapshot_handle));
-	error = snapshot_read_next(&snapshot, PAGE_SIZE);
-	if (error < PAGE_SIZE)
-		return error < 0 ? error : -EFAULT;
-	header = (struct swsusp_info *)data_of(snapshot);
-	nr_pages = header->image_pages;
-	if (!enough_swap(nr_pages)) {
-		printk(KERN_ERR "swsusp: Not enough free swap\n");
-		return -ENOSPC;
-	}
-	swap_map = alloc_swap_map(header->pages);
-	if (!swap_map)
-		return -ENOMEM;
-	init_swap_map_handle(&handle, swap_map);
-
-	error = swap_map_write_page(&handle, header);
-	if (!error)
-		error = save_image(&handle, &snapshot, nr_pages);
-	if (error)
-		goto Free_image_entries;
-
-	swap_map = reverse_swap_map(swap_map);
-	error = save_swap_map(swap_map, &start);
-	if (error)
-		goto Free_map_entries;
-
-	printk( "S" );
-	error = mark_swapfiles(start);
-	printk( "|\n" );
-	if (error)
-		goto Free_map_entries;
-
-Free_swap_map:
-	free_swap_map(swap_map);
-	return error;
-
-Free_map_entries:
-	free_swap_map_entries(swap_map);
-Free_image_entries:
-	free_image_entries(swap_map);
-	goto Free_swap_map;
-}
-
-/**
  *	swsusp_shrink_memory -  Try to free as much memory as needed
  *
  *	... but do not OOM-kill anyone
@@ -611,254 +237,3 @@ int swsusp_resume(void)
 	local_irq_enable();
 	return error;
 }
-
-/*
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
-static int end_io(struct bio *bio, unsigned int num, int err)
-{
-	if (!test_bit(BIO_UPTODATE, &bio->bi_flags))
-		panic("I/O error reading memory image");
-	atomic_set(&io_done, 0);
-	return 0;
-}
-
-static struct block_device *resume_bdev;
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
-static int submit(int rw, pgoff_t page_off, void *page)
-{
-	int error = 0;
-	struct bio *bio;
-
-	bio = bio_alloc(GFP_ATOMIC, 1);
-	if (!bio)
-		return -ENOMEM;
-	bio->bi_sector = page_off * (PAGE_SIZE >> 9);
-	bio_get(bio);
-	bio->bi_bdev = resume_bdev;
-	bio->bi_end_io = end_io;
-
-	if (bio_add_page(bio, virt_to_page(page), PAGE_SIZE, 0) < PAGE_SIZE) {
-		printk("swsusp: ERROR: adding page to bio at %ld\n",page_off);
-		error = -EFAULT;
-		goto Done;
-	}
-
-	if (rw == WRITE)
-		bio_set_pages_dirty(bio);
-
-	atomic_set(&io_done, 1);
-	submit_bio(rw | (1 << BIO_RW_SYNC), bio);
-	while (atomic_read(&io_done))
-		yield();
-
- Done:
-	bio_put(bio);
-	return error;
-}
-
-static int bio_read_page(pgoff_t page_off, void *page)
-{
-	return submit(READ, page_off, page);
-}
-
-static int bio_write_page(pgoff_t page_off, void *page)
-{
-	return submit(WRITE, page_off, page);
-}
-
-/**
- *	The following functions allow us to read data using a swap map
- *	in a file-alike way
- */
-
-static inline void release_swap_map_reader(struct swap_map_handle *handle)
-{
-	if (handle->cur)
-		free_page((unsigned long)handle->cur);
-	handle->cur = NULL;
-}
-
-static inline int get_swap_map_reader(struct swap_map_handle *handle,
-                                      swp_entry_t start)
-{
-	int error;
-
-	if (!swp_offset(start))
-		return -EINVAL;
-	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_ATOMIC);
-	if (!handle->cur)
-		return -ENOMEM;
-	error = bio_read_page(swp_offset(start), handle->cur);
-	if (error) {
-		release_swap_map_reader(handle);
-		return error;
-	}
-	handle->k = 0;
-	return 0;
-}
-
-static inline int swap_map_read_page(struct swap_map_handle *handle, void *buf)
-{
-	unsigned long offset;
-	int error;
-
-	if (!handle->cur)
-		return -EINVAL;
-	offset = swp_offset(handle->cur->entries[handle->k]);
-	if (!offset)
-		return -EFAULT;
-	error = bio_read_page(offset, buf);
-	if (error)
-		return error;
-	if (++handle->k >= MAP_PAGE_SIZE) {
-		handle->k = 0;
-		offset = swp_offset(handle->cur->next_swap);
-		if (!offset)
-			release_swap_map_reader(handle);
-		else
-			error = bio_read_page(offset, handle->cur);
-	}
-	return error;
-}
-
-/**
- *	load_image - load the image using the swap map handle
- *	@handle and the snapshot handle @snapshot
- *	(assume there are @nr_pages pages to load)
- */
-
-static int load_image(struct swap_map_handle *handle,
-                      struct snapshot_handle *snapshot,
-                      unsigned int nr_pages)
-{
-	unsigned int m;
-	int ret;
-	int error = 0;
-
-	printk("Loading image data pages (%u pages) ...     ", nr_pages);
-	m = nr_pages / 100;
-	if (!m)
-		m = 1;
-	nr_pages = 0;
-	do {
-		ret = snapshot_write_next(snapshot, PAGE_SIZE);
-		if (ret > 0) {
-			error = swap_map_read_page(handle, data_of(*snapshot));
-			if (error)
-				break;
-			if (!(nr_pages % m))
-				printk("\b\b\b\b%3d%%", nr_pages / m);
-			nr_pages++;
-		}
-	} while (ret > 0);
-	if (!error)
-		printk("\b\b\b\bdone\n");
-	if (!snapshot_image_ready(snapshot))
-		error = -ENODATA;
-	return error;
-}
-
-int swsusp_read(void)
-{
-	int error;
-	struct swap_map_handle handle;
-	struct snapshot_handle snapshot;
-	struct swsusp_info *header;
-	unsigned int nr_pages;
-
-	if (IS_ERR(resume_bdev)) {
-		pr_debug("swsusp: block device not initialised\n");
-		return PTR_ERR(resume_bdev);
-	}
-
-	memset(&snapshot, 0, sizeof(struct snapshot_handle));
-	error = snapshot_write_next(&snapshot, PAGE_SIZE);
-	if (error < PAGE_SIZE)
-		return error < 0 ? error : -EFAULT;
-	header = (struct swsusp_info *)data_of(snapshot);
-	error = get_swap_map_reader(&handle, swsusp_header.image);
-	if (!error)
-		error = swap_map_read_page(&handle, header);
-	if (!error) {
-		nr_pages = header->image_pages;
-		error = load_image(&handle, &snapshot, nr_pages);
-	}
-	release_swap_map_reader(&handle);
-
-	blkdev_put(resume_bdev);
-
-	if (!error)
-		pr_debug("swsusp: Reading resume file was successful\n");
-	else
-		pr_debug("swsusp: Error %d resuming\n", error);
-	return error;
-}
-
-/**
- *      swsusp_check - Check for swsusp signature in the resume device
- */
-
-int swsusp_check(void)
-{
-	int error;
-
-	resume_bdev = open_by_devnum(swsusp_resume_device, FMODE_READ);
-	if (!IS_ERR(resume_bdev)) {
-		set_blocksize(resume_bdev, PAGE_SIZE);
-		memset(&swsusp_header, 0, sizeof(swsusp_header));
-		if ((error = bio_read_page(0, &swsusp_header)))
-			return error;
-		if (!memcmp(SWSUSP_SIG, swsusp_header.sig, 10)) {
-			memcpy(swsusp_header.sig, swsusp_header.orig_sig, 10);
-			/* Reset swap signature now */
-			error = bio_write_page(0, &swsusp_header);
-		} else {
-			return -EINVAL;
-		}
-		if (error)
-			blkdev_put(resume_bdev);
-		else
-			pr_debug("swsusp: Signature found, resuming\n");
-	} else {
-		error = PTR_ERR(resume_bdev);
-	}
-
-	if (error)
-		pr_debug("swsusp: Error %d check for resume file\n", error);
-
-	return error;
-}
-
-/**
- *	swsusp_close - close swap device.
- */
-
-void swsusp_close(void)
-{
-	if (IS_ERR(resume_bdev)) {
-		pr_debug("swsusp: block device not initialised\n");
-		return;
-	}
-
-	blkdev_put(resume_bdev);
-}

