Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964858AbWAFXjX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964858AbWAFXjX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 6 Jan 2006 18:39:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965028AbWAFXjX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 6 Jan 2006 18:39:23 -0500
Received: from anf141.internetdsl.tpnet.pl ([83.17.87.141]:49545 "EHLO
	anf141.internetdsl.tpnet.pl") by vger.kernel.org with ESMTP
	id S964858AbWAFXjW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 6 Jan 2006 18:39:22 -0500
From: "Rafael J. Wysocki" <rjw@sisk.pl>
To: Pavel Machek <pavel@ucw.cz>
Subject: Re: [RFC/RFT][PATCH -mm 0/5] swsusp: userland interface (rev. 2)
Date: Sat, 7 Jan 2006 00:41:22 +0100
User-Agent: KMail/1.9
Cc: Linux PM <linux-pm@osdl.org>, LKML <linux-kernel@vger.kernel.org>
References: <200601042340.42118.rjw@sisk.pl> <200601062217.09012.rjw@sisk.pl> <20060106224430.GC12428@elf.ucw.cz>
In-Reply-To: <20060106224430.GC12428@elf.ucw.cz>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200601070041.22497.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Friday, 6 January 2006 23:44, Pavel Machek wrote:
> > > > This is the second "preview release" of the swsusp userland interface patches.
> > > > They have changed quite a bit since the previous post, as I tried to make the
> > > > interface more robust against some potential user space bugs (or outright
> > > > attempts to abuse it).
> > > 
> > > Works for me, thanks.
> > > 
> > > Perhaps it is time to get 1/4 and 3/4 into -mm? You get my signed-off
> > > on them...
> > 
> > OK, I'll prepare them in a while.
> 
> Thanks.

I had to remake the 3/4 a bit, as it depended on some changes to power.h
and swsusp.c done in the 2/4.  Nothing particularly invasive, basically some
definitions go to power.h and some function headers change, but please
have a look if the patch is still OK (appended).

> > > 2/4 needs to allocate official major/minor. 1/13 would be nice :-).
> > 
> > Well, you said you liked the patch with a misc device (ie. major = 10).
> > 
> > Actually the code is somewhat simpler in that case so I'd prefer it.
> > 
> > Now, if we used a misc device, which minor would be suitable?  231?
> 
> If code is simpler, lets stick with misc. You have to obtain minor by
> mailing device@lanana.org, see Doc*/devices.txt.

OK, I'll try.

> > > 4/4... I'm not sure. It would be nice to make swsusp.c disappear. It
> > > is really wrong name. That means we need to only delete from it for a
> > > while...
> > 
> > Anyway I think it would be nice to move the code that does not really belong
> > to the snapshot and is used by both the user interface and disk.c/swap.c to
> > a separate file.  I have no preference as far as the name of the file is
> > concerned, though.
> 
> Ok, lets keep it as it is. We can always rename file in future. [I
> don't quite understand your reasons for movement, through. Highmem is
> part of snapshot we need to make; it is saved in a very different way
> than rest of memory, but that is implementation detail...]

I'm seeing this a bit differently.  In my view highmem is handled very much
like devices: save_highmem() turns it "off", restore_highmem() turns it "on"
back again, they are even called next to device_power_up/down().

Besides, the highmem-related code is only invoked from
swsusp_suspend/resume() and swsusp_shrink_memory(), so in swsusp.c it
can be made static or even static inline (eg. save_highmem() is called only
once, and so is count_highmem_pages()).

Greetings,
Rafael


 kernel/power/Makefile |    2 
 kernel/power/power.h  |   35 ++
 kernel/power/swap.c   |  556 ++++++++++++++++++++++++++++++++++++++++++++++
 kernel/power/swsusp.c |  596 ++------------------------------------------------
 4 files changed, 617 insertions(+), 572 deletions(-)

Index: linux-2.6.15-mm1/kernel/power/Makefile
===================================================================
--- linux-2.6.15-mm1.orig/kernel/power/Makefile	2006-01-06 23:23:05.000000000 +0100
+++ linux-2.6.15-mm1/kernel/power/Makefile	2006-01-06 23:27:19.000000000 +0100
@@ -5,7 +5,7 @@ endif
 
 obj-y				:= main.o process.o console.o
 obj-$(CONFIG_PM_LEGACY)		+= pm.o
-obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o
+obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o disk.o snapshot.o swap.o
 
 obj-$(CONFIG_SUSPEND_SMP)	+= smp.o
 
Index: linux-2.6.15-mm1/kernel/power/power.h
===================================================================
--- linux-2.6.15-mm1.orig/kernel/power/power.h	2006-01-06 23:24:18.000000000 +0100
+++ linux-2.6.15-mm1/kernel/power/power.h	2006-01-06 23:29:36.000000000 +0100
@@ -53,8 +53,8 @@ extern struct pbe *pagedir_nosave;
 
 /* Preferred image size in MB (default 500) */
 extern unsigned int image_size;
-
 extern int in_suspend;
+extern dev_t swsusp_resume_device;
 
 extern asmlinkage int swsusp_arch_suspend(void);
 extern asmlinkage int swsusp_arch_resume(void);
@@ -77,3 +77,36 @@ struct snapshot_handle {
 extern int snapshot_read_next(struct snapshot_handle *handle, size_t count);
 extern int snapshot_write_next(struct snapshot_handle *handle, size_t count);
 int snapshot_image_loaded(struct snapshot_handle *handle);
+
+/**
+ *	The bitmap is used for tracing allocated swap pages
+ *
+ *	The entire bitmap consists of a number of bitmap_page
+ *	structures linked with the help of the .next member.
+ *	Thus each page can be allocated individually, so we only
+ *	need to make 0-order memory allocations to create
+ *	the bitmap.
+ */
+
+#define BITMAP_PAGE_SIZE	(PAGE_SIZE - sizeof(void *))
+#define BITMAP_PAGE_CHUNKS	(BITMAP_PAGE_SIZE / sizeof(long))
+#define BITS_PER_CHUNK		(sizeof(long) * 8)
+#define BITMAP_PAGE_BITS	(BITMAP_PAGE_CHUNKS * BITS_PER_CHUNK)
+
+struct bitmap_page {
+	unsigned long		chunks[BITMAP_PAGE_CHUNKS];
+	struct bitmap_page	*next;
+};
+
+extern void free_bitmap(struct bitmap_page *bitmap);
+extern struct bitmap_page *alloc_bitmap(unsigned int nr_bits);
+extern unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap);
+extern void free_all_swap_pages(int swap, struct bitmap_page *bitmap);
+
+extern int swsusp_get_swap_index_of(dev_t device);
+extern int swsusp_get_swap_index(void);
+extern unsigned int swsusp_total_swap(unsigned int swap);
+extern unsigned int swsusp_available_swap(unsigned int swap);
+extern int swsusp_shrink_memory(void);
+extern int swsusp_suspend(void);
+extern int swsusp_resume(void);
Index: linux-2.6.15-mm1/kernel/power/swap.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-2.6.15-mm1/kernel/power/swap.c	2006-01-06 23:27:19.000000000 +0100
@@ -0,0 +1,556 @@
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
+/**
+ *	mark_swapfiles - change the signature of the resume partition
+ *	and store the swap address of given entry in the partition's
+ *	header (the entry should point to the first image page in the
+ *	swap)
+ */
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
+/**
+ *	swsusp_swap_check - check if the resume partition is available
+ */
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
+ *	write_page - Write one page to given swap location.
+ *	@buf:		Address we're writing.
+ *	@offset:	Offset of the swap page we're writing to.
+ */
+
+static int write_page(void *buf, unsigned long offset)
+{
+	swp_entry_t entry;
+	int error = -ENOSPC;
+
+	if (offset) {
+		entry = swp_entry(root_swap, offset);
+		error = rw_swap_page_sync(WRITE, entry, virt_to_page(buf));
+	}
+	return error;
+}
+
+/*
+ *	The swap map is a data structure used for keeping track of each page
+ *	written to a swap partition.  It consists of many swap_map_page
+ *	structures that contain each an array of MAP_PAGE_SIZE swap entries.
+ *	These structures are stored on the swap and linked together with the
+ *	help of the .next_swap member.
+ *
+ *	The swap map is created during suspend.  The swap map pages are
+ *	allocated and populated one at a time, so we only need one memory
+ *	page to set up the entire structure.
+ *
+ *	During resume we also only need to use one swap_map_page structure
+ *	at a time.
+ */
+
+#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(long) - 1)
+
+struct swap_map_page {
+	unsigned long		entries[MAP_PAGE_ENTRIES];
+	unsigned long		next_swap;
+};
+
+/**
+ *	The swap_map_handle structure is used for handling swap in
+ *	a file-alike way
+ */
+
+struct swap_map_handle {
+	struct swap_map_page *cur;
+	unsigned long cur_swap;
+	struct bitmap_page *bitmap;
+	unsigned int k;
+};
+
+static inline void release_swap_writer(struct swap_map_handle *handle)
+{
+	if (handle->cur)
+		free_page((unsigned long)handle->cur);
+	handle->cur = NULL;
+	if (handle->bitmap)
+		free_bitmap(handle->bitmap);
+	handle->bitmap = NULL;
+}
+
+static inline int get_swap_writer(struct swap_map_handle *handle)
+{
+	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
+	if (!handle->cur)
+		return -ENOMEM;
+	handle->bitmap = alloc_bitmap(swsusp_total_swap(root_swap));
+	if (!handle->bitmap) {
+		release_swap_writer(handle);
+		return -ENOMEM;
+	}
+	handle->cur_swap = alloc_swap_page(root_swap, handle->bitmap);
+	if (!handle->cur_swap) {
+		release_swap_writer(handle);
+		return -ENOSPC;
+	}
+	handle->k = 0;
+	return 0;
+}
+
+static inline int swap_write_page(struct swap_map_handle *handle, void *buf)
+{
+	int error;
+	unsigned long offset;
+
+	if (!handle->cur)
+		return -EINVAL;
+	offset = alloc_swap_page(root_swap, handle->bitmap);
+	error = write_page(buf, offset);
+	if (error)
+		return error;
+	handle->cur->entries[handle->k++] = offset;
+	if (handle->k >= MAP_PAGE_ENTRIES) {
+		offset = alloc_swap_page(root_swap, handle->bitmap);
+		if (!offset)
+			return -ENOSPC;
+		handle->cur->next_swap = offset;
+		error = write_page(handle->cur, handle->cur_swap);
+		if (error)
+			return error;
+		memset(handle->cur, 0, PAGE_SIZE);
+		handle->cur_swap = offset;
+		handle->k = 0;
+	}
+	return 0;
+}
+
+static inline int flush_swap_writer(struct swap_map_handle *handle)
+{
+	if (handle->cur && handle->cur_swap)
+		return write_page(handle->cur, handle->cur_swap);
+	else
+		return -EINVAL;
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
+			error = swap_write_page(handle, data_of(*snapshot));
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
+	struct swap_map_handle handle;
+	struct snapshot_handle snapshot;
+	struct swsusp_info *header;
+	unsigned long start;
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
+	if (!enough_swap(header->pages)) {
+		printk(KERN_ERR "swsusp: Not enough free swap\n");
+		return -ENOSPC;
+	}
+	error = get_swap_writer(&handle);
+	if (!error) {
+		start = handle.cur_swap;
+		error = swap_write_page(&handle, header);
+	}
+	if (!error)
+		error = save_image(&handle, &snapshot, header->pages - 1);
+	if (!error) {
+		flush_swap_writer(&handle);
+		printk("S");
+		error = mark_swapfiles(swp_entry(root_swap, start));
+		printk("|\n");
+	}
+	if (error)
+		free_all_swap_pages(root_swap, handle.bitmap);
+	release_swap_writer(&handle);
+	return error;
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
+static inline void release_swap_reader(struct swap_map_handle *handle)
+{
+	if (handle->cur)
+		free_page((unsigned long)handle->cur);
+	handle->cur = NULL;
+}
+
+static inline int get_swap_reader(struct swap_map_handle *handle,
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
+		release_swap_reader(handle);
+		return error;
+	}
+	handle->k = 0;
+	return 0;
+}
+
+static inline int swap_read_page(struct swap_map_handle *handle, void *buf)
+{
+	unsigned long offset;
+	int error;
+
+	if (!handle->cur)
+		return -EINVAL;
+	offset = handle->cur->entries[handle->k];
+	if (!offset)
+		return -EFAULT;
+	error = bio_read_page(offset, buf);
+	if (error)
+		return error;
+	if (++handle->k >= MAP_PAGE_ENTRIES) {
+		handle->k = 0;
+		offset = handle->cur->next_swap;
+		if (!offset)
+			release_swap_reader(handle);
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
+			error = swap_read_page(handle, data_of(*snapshot));
+			if (error)
+				break;
+			if (!(nr_pages % m))
+				printk("\b\b\b\b%3d%%", nr_pages / m);
+			nr_pages++;
+		}
+	} while (ret > 0);
+	if (!error)
+		printk("\b\b\b\bdone\n");
+	if (!snapshot_image_loaded(snapshot))
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
+	error = get_swap_reader(&handle, swsusp_header.image);
+	if (!error)
+		error = swap_read_page(&handle, header);
+	if (!error) {
+		nr_pages = header->image_pages;
+		error = load_image(&handle, &snapshot, nr_pages);
+	}
+	release_swap_reader(&handle);
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
Index: linux-2.6.15-mm1/kernel/power/swsusp.c
===================================================================
--- linux-2.6.15-mm1.orig/kernel/power/swsusp.c	2006-01-06 23:24:18.000000000 +0100
+++ linux-2.6.15-mm1/kernel/power/swsusp.c	2006-01-06 23:27:19.000000000 +0100
@@ -31,41 +31,24 @@
  * Fixed runaway init
  *
  * Rafael J. Wysocki <rjw@sisk.pl>
- * Added the swap map data structure and reworked the handling of swap
+ * Reworked the handling of swap and added the user interface
  *
  * More state savers are welcome. Especially for the scsi layer...
  *
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
 
@@ -89,82 +72,42 @@ static int restore_highmem(void) { retur
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
 /**
- * Check whether the swap device is the specified resume
- * device, irrespective of whether they are specified by
- * identical names.
+ *	is_device - check whether the specified device is a swap device,
+ *	irrespective of whether they are specified by identical names.
  *
- * (Thus, device inode aliasing is allowed.  You can say /dev/hda4
- * instead of /dev/ide/host0/bus0/target0/lun0/part4 [eg. for devfs]
- * and they'll be considered the same device.  This was *necessary* for
- * devfs, since the resume code could only recognize the form /dev/hda4,
- * but the suspend code would see the long name.)
+ *	(Thus, device inode aliasing is allowed.  You can say /dev/hda4
+ *	instead of /dev/ide/host0/bus0/target0/lun0/part4 [eg. for devfs]
+ *	and they'll be considered the same device.  This was *necessary* for
+ *	devfs, since the resume code could only recognize the form /dev/hda4,
+ *	but the suspend code would see the long name.)
  */
 
-static inline int is_resume_device(const struct swap_info_struct *swap_info)
+static inline int is_device(const struct swap_info_struct *swap_info,
+                            dev_t device)
 {
 	struct file *file = swap_info->swap_file;
 	struct inode *inode = file->f_dentry->d_inode;
 
 	return S_ISBLK(inode->i_mode) &&
-		swsusp_resume_device == MKDEV(imajor(inode), iminor(inode));
+		device == MKDEV(imajor(inode), iminor(inode));
 }
 
 /**
- *	swsusp_get_swap_index - find the index of the resume device
+ *	swsusp_get_swap_index_of - find the index of the given device
  */
 
-int swsusp_get_swap_index(void)
+int swsusp_get_swap_index_of(dev_t device)
 {
 	int i;
 
-	if (!swsusp_resume_device)
-		return -ENODEV;
+	if (!device)
+		return -EINVAL;
 	spin_lock(&swap_lock);
 	for (i = 0; i < MAX_SWAPFILES; i++) {
 		if (!(swap_info[i].flags & SWP_WRITEOK))
 			continue;
-		if (is_resume_device(swap_info + i)) {
+		if (is_device(swap_info + i, device)) {
 			spin_unlock(&swap_lock);
 			return i;
 		}
@@ -173,46 +116,24 @@ int swsusp_get_swap_index(void)
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
 /**
- *	The bitmap is used for tracing allocated swap pages
- *
- *	The entire bitmap consists of a number of bitmap_page
- *	structures linked with the help of the .next member.
- *	Thus each page can be allocated individually, so we only
- *	need to make 0-order memory allocations to create
- *	the bitmap.
+ *	swsusp_get_swap_index - find the index of the resume device
  */
 
-#define BITMAP_PAGE_SIZE	(PAGE_SIZE - sizeof(void *))
-#define BITMAP_PAGE_CHUNKS	(BITMAP_PAGE_SIZE / sizeof(long))
-#define BITS_PER_CHUNK		(sizeof(long) * 8)
-#define BITMAP_PAGE_BITS	(BITMAP_PAGE_CHUNKS * BITS_PER_CHUNK)
-
-struct bitmap_page {
-	unsigned long		chunks[BITMAP_PAGE_CHUNKS];
-	struct bitmap_page	*next;
-};
+int swsusp_get_swap_index(void)
+{
+	return swsusp_get_swap_index_of(swsusp_resume_device);
+}
 
 /**
  *	The following functions are used for tracing the allocated
  *	swap pages, so that they can be freed in case of an error.
  *
  *	The functions operate on a linked bitmap structure defined
- *	above
+ *	in power.h
  */
 
-static void free_bitmap(struct bitmap_page *bitmap)
+void free_bitmap(struct bitmap_page *bitmap)
 {
 	struct bitmap_page *bp;
 
@@ -223,7 +144,7 @@ static void free_bitmap(struct bitmap_pa
 	}
 }
 
-static struct bitmap_page *alloc_bitmap(unsigned int nr_bits)
+struct bitmap_page *alloc_bitmap(unsigned int nr_bits)
 {
 	struct bitmap_page *bitmap, *bp;
 	unsigned int n;
@@ -266,7 +187,7 @@ static inline int bitmap_set(struct bitm
 	return 0;
 }
 
-static unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap)
+unsigned long alloc_swap_page(int swap, struct bitmap_page *bitmap)
 {
 	unsigned long offset;
 
@@ -280,7 +201,7 @@ static unsigned long alloc_swap_page(int
 	return offset;
 }
 
-static void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
+void free_all_swap_pages(int swap, struct bitmap_page *bitmap)
 {
 	unsigned int bit, n;
 	unsigned long test;
@@ -298,24 +219,6 @@ static void free_all_swap_pages(int swap
 }
 
 /**
- *	write_page - Write one page to given swap location.
- *	@buf:		Address we're writing.
- *	@offset:	Offset of the swap page we're writing to.
- */
-
-static int write_page(void *buf, unsigned long offset)
-{
-	swp_entry_t entry;
-	int error = -ENOSPC;
-
-	if (offset) {
-		entry = swp_entry(root_swap, offset);
-		error = rw_swap_page_sync(WRITE, entry, virt_to_page(buf));
-	}
-	return error;
-}
-
-/**
  *	swsusp_total_swap - check the total amount of swap
  *	space in the resume partition/file
  */
@@ -333,137 +236,6 @@ unsigned int swsusp_total_swap(unsigned 
 	return n;
 }
 
-/*
- *	The swap map is a data structure used for keeping track of each page
- *	written to a swap partition.  It consists of many swap_map_page
- *	structures that contain each an array of MAP_PAGE_SIZE swap entries.
- *	These structures are stored on the swap and linked together with the
- *	help of the .next_swap member.
- *
- *	The swap map is created during suspend.  The swap map pages are
- *	allocated and populated one at a time, so we only need one memory
- *	page to set up the entire structure.
- *
- *	During resume we also only need to use one swap_map_page structure
- *	at a time.
- */
-
-#define MAP_PAGE_ENTRIES	(PAGE_SIZE / sizeof(long) - 1)
-
-struct swap_map_page {
-	unsigned long		entries[MAP_PAGE_ENTRIES];
-	unsigned long		next_swap;
-};
-
-/**
- *	The swap_map_handle structure is used for handling swap in
- *	a file-alike way
- */
-
-struct swap_map_handle {
-	struct swap_map_page *cur;
-	unsigned long cur_swap;
-	struct bitmap_page *bitmap;
-	unsigned int k;
-};
-
-static inline void release_swap_writer(struct swap_map_handle *handle)
-{
-	if (handle->cur)
-		free_page((unsigned long)handle->cur);
-	handle->cur = NULL;
-	if (handle->bitmap)
-		free_bitmap(handle->bitmap);
-	handle->bitmap = NULL;
-}
-
-static inline int get_swap_writer(struct swap_map_handle *handle)
-{
-	handle->cur = (struct swap_map_page *)get_zeroed_page(GFP_KERNEL);
-	if (!handle->cur)
-		return -ENOMEM;
-	handle->bitmap = alloc_bitmap(swsusp_total_swap(root_swap));
-	if (!handle->bitmap) {
-		release_swap_writer(handle);
-		return -ENOMEM;
-	}
-	handle->cur_swap = alloc_swap_page(root_swap, handle->bitmap);
-	if (!handle->cur_swap) {
-		release_swap_writer(handle);
-		return -ENOSPC;
-	}
-	handle->k = 0;
-	return 0;
-}
-
-static inline int swap_write_page(struct swap_map_handle *handle, void *buf)
-{
-	int error;
-	unsigned long offset;
-
-	if (!handle->cur)
-		return -EINVAL;
-	offset = alloc_swap_page(root_swap, handle->bitmap);
-	error = write_page(buf, offset);
-	if (error)
-		return error;
-	handle->cur->entries[handle->k++] = offset;
-	if (handle->k >= MAP_PAGE_ENTRIES) {
-		offset = alloc_swap_page(root_swap, handle->bitmap);
-		if (!offset)
-			return -ENOSPC;
-		handle->cur->next_swap = offset;
-		error = write_page(handle->cur, handle->cur_swap);
-		if (error)
-			return error;
-		memset(handle->cur, 0, PAGE_SIZE);
-		handle->cur_swap = offset;
-		handle->k = 0;
-	}
-	return 0;
-}
-
-static inline int flush_swap_writer(struct swap_map_handle *handle)
-{
-	if (handle->cur && handle->cur_swap)
-		return write_page(handle->cur, handle->cur_swap);
-	else
-		return -EINVAL;
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
-			error = swap_write_page(handle, data_of(*snapshot));
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
@@ -484,71 +256,6 @@ unsigned int swsusp_available_swap(unsig
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
-	struct swap_map_handle handle;
-	struct snapshot_handle snapshot;
-	struct swsusp_info *header;
-	unsigned long start;
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
-	if (!enough_swap(header->pages)) {
-		printk(KERN_ERR "swsusp: Not enough free swap\n");
-		return -ENOSPC;
-	}
-	error = get_swap_writer(&handle);
-	if (!error) {
-		start = handle.cur_swap;
-		error = swap_write_page(&handle, header);
-	}
-	if (!error)
-		error = save_image(&handle, &snapshot, header->pages - 1);
-	if (!error) {
-		flush_swap_writer(&handle);
-		printk("S");
-		error = mark_swapfiles(swp_entry(root_swap, start));
-		printk("|\n");
-	}
-	if (error)
-		free_all_swap_pages(root_swap, handle.bitmap);
-	release_swap_writer(&handle);
-	return error;
-}
-
-/**
  *	swsusp_shrink_memory -  Try to free as much memory as needed
  *
  *	... but do not OOM-kill anyone
@@ -654,254 +361,3 @@ int swsusp_resume(void)
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
-static inline void release_swap_reader(struct swap_map_handle *handle)
-{
-	if (handle->cur)
-		free_page((unsigned long)handle->cur);
-	handle->cur = NULL;
-}
-
-static inline int get_swap_reader(struct swap_map_handle *handle,
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
-		release_swap_reader(handle);
-		return error;
-	}
-	handle->k = 0;
-	return 0;
-}
-
-static inline int swap_read_page(struct swap_map_handle *handle, void *buf)
-{
-	unsigned long offset;
-	int error;
-
-	if (!handle->cur)
-		return -EINVAL;
-	offset = handle->cur->entries[handle->k];
-	if (!offset)
-		return -EFAULT;
-	error = bio_read_page(offset, buf);
-	if (error)
-		return error;
-	if (++handle->k >= MAP_PAGE_ENTRIES) {
-		handle->k = 0;
-		offset = handle->cur->next_swap;
-		if (!offset)
-			release_swap_reader(handle);
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
-			error = swap_read_page(handle, data_of(*snapshot));
-			if (error)
-				break;
-			if (!(nr_pages % m))
-				printk("\b\b\b\b%3d%%", nr_pages / m);
-			nr_pages++;
-		}
-	} while (ret > 0);
-	if (!error)
-		printk("\b\b\b\bdone\n");
-	if (!snapshot_image_loaded(snapshot))
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
-	error = get_swap_reader(&handle, swsusp_header.image);
-	if (!error)
-		error = swap_read_page(&handle, header);
-	if (!error) {
-		nr_pages = header->image_pages;
-		error = load_image(&handle, &snapshot, nr_pages);
-	}
-	release_swap_reader(&handle);
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
