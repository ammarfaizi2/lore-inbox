Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262080AbVGFERs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262080AbVGFERs (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:17:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262124AbVGFERs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:17:48 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:11929 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262080AbVGFCTi convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:38 -0400
Subject: [PATCH] [47/48] Suspend2 2.1.9.8 for 2.6.12: 623-generic-block-io.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:44 +1000
Message-Id: <1120616444110@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 624-filewriter.patch-old/kernel/power/suspend_file.c 624-filewriter.patch-new/kernel/power/suspend_file.c
--- 624-filewriter.patch-old/kernel/power/suspend_file.c	1970-01-01 10:00:00.000000000 +1000
+++ 624-filewriter.patch-new/kernel/power/suspend_file.c	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,1616 @@
+/*
+ * Filewriter.c
+ *
+ * Copyright 2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * This file encapsulates functions for usage of a simple file as a
+ * backing store. It is based upon the swapwriter, and shares the
+ * same basic working. Here, though, we have nothing to do with
+ * swapspace, and only one device to worry about.
+ *
+ * The user can just
+ *
+ * echo Suspend2 > /path/to/my_file
+ *
+ * and
+ *
+ * echo /path/to/my_file > /proc/software_suspend/filewriter_target
+ *
+ * then put what they find in /proc/software_suspend/resume2
+ * as their resume2= parameter in lilo.conf (and rerun lilo if using it).
+ *
+ * Having done this, they're ready to suspend and resume.
+ *
+ * TODO:
+ * - File resizing.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/file.h>
+#include <linux/stat.h>
+#include <linux/mount.h>
+#include <linux/statfs.h>
+
+#include "suspend2_core/suspend.h"
+#include "suspend2_core/suspend2_common.h"
+#include "suspend2_core/version.h"
+#include "suspend2_core/proc.h"
+#include "suspend2_core/plugins.h"
+#include "suspend2_core/ui.h"
+#include "suspend2_core/extent.h"
+#include "suspend2_core/utility.h"
+#include "suspend2_core/io.h"
+
+#include "block_io.h"
+
+/*
+ *		General Declarations.
+ */
+
+static struct suspend_proc_data filewriter_proc_data[];
+static struct suspend_plugin_ops filewriterops;
+
+/*
+ *		External Declarations
+ */
+
+extern asmlinkage long sys_open(const char __user * filename, int flags, int mode);
+extern asmlinkage long sys_close(unsigned int fd);
+
+/*
+ *		Forward Declarations
+ */
+
+static int filewriter_invalidate_image(void);
+static int filewriter_storage_available(void);
+
+/*
+ *		Details of our target.
+ */
+
+char filewriter_target[256];
+static struct inode * target_inode;
+static int target_fd = -1;
+static struct block_device * target_bdev;
+static int used_devt = 0;
+static dev_t target_dev_t = 0;
+static int target_firstblock = 0;
+static int target_blocksize = PAGE_SIZE;
+static int target_storage_available = 0;
+static unsigned int target_blkbits;
+#define target_blockshift (PAGE_SHIFT - target_blkbits)
+#define target_blocksperpage (1 << target_blockshift)
+
+static int target_type = -1;
+
+/*
+static char * description[7] = {
+	"Socket",
+	"Link",
+	"Regular file",
+	"Block device",
+	"Directory",
+	"Character device",
+	"Fifo",
+};
+*/
+
+static char HaveImage[] = "HaveImage\n";
+static char NoImage[] =   "Suspend2\n";
+static const int resumed_before_byte = sizeof(HaveImage) + 1;
+#define sig_size resumed_before_byte
+
+/* Header_pages must be big enough for signature */
+static int header_pages, main_pages;
+
+static unsigned long * header_link = NULL;
+#define BYTES_PER_HEADER_PAGE (PAGE_SIZE - sizeof(sector_t))
+
+#define target_is_normal_file() (S_ISREG(target_inode->i_mode))
+
+/*
+ *		Readahead Variables
+ */
+
+// Higher Level
+static int readahead_index = 0, readahead_submit_index = 0;
+static int readahead_allocs = 0, readahead_frees = 0;
+
+static char * filewriter_buffer = NULL;
+static int filewriter_buffer_posn = 0;
+static int filewriter_page_index = 0;
+
+/*
+ * ---------------------------------------------------------------
+ *
+ *     Internal Data Structures
+ *
+ * ---------------------------------------------------------------
+ */
+
+/* header_data contains data that is needed to reload pagedir1, and
+ * is therefore saved in the suspend header.
+ *
+ * Pagedir2 data gets stored before pagedir1 (save order), and the first
+ * page for pagedir1 to use is set when pagedir2 is written (when we know how
+ * much storage it used). Since this first entry is almost certainly not at the
+ * start of a extent, the firstoffset variable below tells us where to start in
+ * the extent. All of this means we don't have to worry about getting different
+ * compression ratios for the kernel and cache (when compressing the image).
+ * We can simply allocate one pool of storage (size determined using expected
+ * compression ratio) and use it without worrying whether one pageset
+ * compresses better and the other worse (this is what happens). As long as the
+ * user gets the expected compression right, it will work.
+ */
+
+static struct {
+	/* Location of start of pagedir 1 */
+	struct extent * pd1start_block_extent;
+	int pd1start_extent_number;
+	unsigned long pd1start_block_offset;
+
+} filewriter_header_data;
+
+/* Extent chain for blocks */
+static struct extentchain block_chain;
+
+/*
+ * ---------------------------------------------------------------
+ *
+ *     Current state.
+ *
+ * ---------------------------------------------------------------
+ */
+
+/* Which pagedir are we saving/reloading? Needed so we can know whether to
+ * remember the last block used at the end of writing pageset2, and
+ * get that location when saving or reloading pageset1.*/
+static int current_stream = 0;
+
+/* Pointer to current entry being loaded/saved. */
+static struct extent * currentblockextent = NULL;
+static unsigned long currentblockoffset = 0;
+
+/* Header Page Information */
+static struct submit_params * first_header_submit_info = NULL,
+ * last_header_submit_info = NULL, * current_header_submit_info = NULL;
+
+/*
+ *		Helpers.
+ */
+
+/* 
+ * Return the type of target we have, an index into the descriptions
+ * above.
+ */
+static int get_target_type(struct inode * inode)
+{
+	switch (inode->i_mode & S_IFMT) {
+		case S_IFSOCK:
+			target_type = 0;
+			break;
+		case S_IFLNK:
+			target_type = 1;
+			break;
+		case S_IFREG:
+			target_type = 2;
+			break;
+		case S_IFBLK:
+			target_type = 3;
+			break;
+		case S_IFDIR:
+			target_type = 4;
+			break;
+		case S_IFCHR:
+			target_type = 5;
+			break;
+		case S_IFIFO:
+			target_type = 6;
+			break;
+	}
+	return target_type;
+}
+	
+#define target_is_usable (!(target_type == 1 || target_type == 4))
+#define target_num_sectors (target_inode->i_size >> target_blkbits)
+
+static int size_ignoring_sparseness(void)
+{
+	int mappable = 0, i;
+	
+	if (target_is_normal_file()) {
+		int extent_min = -1, extent_max = -1;
+
+		for (i = 0; i <= target_num_sectors; i++) {
+			sector_t new_sector = bmap(target_inode, i);
+			if (!new_sector) {
+				if (i == extent_max + 1)
+					extent_max++;
+				else
+					extent_min = extent_max = i;
+			} else
+				mappable++;
+		}
+	
+		return mappable >> (PAGE_SHIFT - target_blkbits);
+	} else
+		return filewriter_storage_available();
+}
+
+static void get_main_pool_phys_params(void)
+{
+	int i;
+	
+	if (block_chain.first)
+		put_extent_chain(&block_chain);
+
+	if (target_is_normal_file()) {
+		int header_sectors = (header_pages << target_blockshift);
+		int extent_min = -1, extent_max = -1, real_sector = 0;
+
+
+		for (i = 0; i <= target_num_sectors; i++) {
+			sector_t new_sector =
+				bmap(target_inode, header_sectors + i);
+			
+			/* 
+			 * I'd love to be able to fill in holes and resize 
+			 * files, but not yet...
+			 */
+
+			if (!new_sector)
+				continue;
+			
+			real_sector++;
+
+			if (real_sector < header_sectors)
+				continue;
+
+			if (new_sector == extent_max + 1)
+				extent_max++;
+			else {
+				if (extent_min > -1)
+					append_extent_to_extent_chain(
+						&block_chain,
+						extent_min, extent_max);
+				extent_min = extent_max = new_sector;
+			}
+		}
+		if (extent_min > -1)
+			append_extent_to_extent_chain(&block_chain,
+				       extent_min, extent_max);
+	} else
+		if (target_storage_available > 0) {
+			unsigned long new_start =
+			 last_header_submit_info ?
+			 last_header_submit_info->block[target_blocksperpage -1]
+				+ 1: 0;
+
+			append_extent_to_extent_chain(&block_chain,
+			 new_start, new_start +
+			 (min(main_pages, target_storage_available) << 
+			  		target_blockshift) - 1);
+		}
+}
+
+static void get_target_info(void)
+{
+	if (target_bdev) {
+		/* 
+		 * Don't replace the inode if we got the bdev from opening
+		 * a file.
+		 */
+		if (!target_inode)
+			target_inode = target_bdev->bd_inode;
+		target_type = get_target_type(target_inode);
+		target_blkbits = target_bdev->bd_inode->i_blkbits;
+		target_storage_available = size_ignoring_sparseness();
+	} else {
+		target_type = -1;
+		target_inode = NULL;
+		target_blkbits = 0;
+		target_storage_available = 0;
+	}	
+}
+
+static int set_target_blocksize(void)
+{
+	if ((suspend_bio_ops.get_block_size(target_bdev) 
+					!= target_blocksize) &&
+	    (suspend_bio_ops.set_block_size(target_bdev, target_blocksize)
+	    			 == -EINVAL)) {
+		printk(KERN_ERR name_suspend "Filewriter: Failed to set the blocksize.\n");
+		return 1;
+	}
+
+	return 0;
+		
+}
+
+static int try_to_open_target_device(void)
+{
+	if (!target_dev_t)
+		return 1;
+
+	if (!target_bdev) {
+		target_bdev = open_by_devnum(target_dev_t, FMODE_READ);
+
+		if (IS_ERR(target_bdev)) {
+			target_bdev = NULL;
+			return 1;
+		}
+		used_devt = 1;
+
+		if (set_target_blocksize()) {
+			blkdev_put(target_bdev);
+			target_bdev = NULL;
+			return 1;
+		}
+	}
+
+	get_target_info();
+
+	return 0;
+}
+
+static int try_to_parse_target_dev_t(char * commandline)
+{
+	struct kstat stat;
+	int error;
+
+	target_dev_t = name_to_dev_t(commandline);
+
+	if (!target_dev_t) {
+		error = vfs_stat(commandline, &stat);
+		if (!error)
+			target_dev_t = stat.rdev;
+	}
+
+	if (!target_dev_t) {
+		if (test_suspend_state(SUSPEND_TRYING_TO_RESUME))
+			suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+				"Failed to translate \"%s\" into a device id.\n",
+				commandline);
+		else
+			printk(name_suspend "Can't translate \"%s\" into a device id yet.\n",
+					commandline);
+		return 1;
+	}
+	
+	try_to_open_target_device();
+
+	if (IS_ERR(target_bdev)) {
+		printk("Open by devnum returned %p given %x.\n",
+				target_bdev, target_dev_t);
+		target_bdev = NULL;
+		if (test_suspend_state(SUSPEND_BOOT_TIME))
+			suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+				"Failed to get access to the device on which"
+				" Software Suspend's header should be found.");
+		else
+			printk("Failed to get access to the device on which "
+				"Software Suspend's header should be found.\n");
+		return 1;
+	}
+
+	return 0;
+}
+
+static void filewriter_noresume_reset(void)
+{
+ 	/* 
+	 * If we have read part of the image, we might have filled header_data with
+	 * data that should be zeroed out.
+	 */
+
+	memset((char *) &filewriter_header_data, 0, sizeof(filewriter_header_data));
+}
+
+/*
+ *
+ */
+
+int parse_signature(char * header, int restore)
+{
+	int have_image = !memcmp(HaveImage, header, sizeof(HaveImage) - 1);
+	int non_image_header = !memcmp(NoImage, header, sizeof(NoImage) - 1);
+
+	if (!have_image && !non_image_header)
+		return -1;
+
+	if (non_image_header)
+		return 0;
+	
+	clear_suspend_state(SUSPEND_RESUMED_BEFORE);
+
+	if (header[resumed_before_byte] & 1)
+		set_suspend_state(SUSPEND_RESUMED_BEFORE);
+
+	/* Invalidate Image */
+	if (restore)
+		strcpy(header, NoImage);
+
+	return 1;
+}
+
+/*
+ * prepare_signature
+ */
+
+static int prepare_signature(struct submit_params * header_page_info,
+		char * current_header)
+{
+	/* 
+	 * Explicitly put the \0 that clears the 'tried to resume from
+	 * this image before' flag.
+	 */
+	strncpy(current_header, HaveImage, sizeof(HaveImage));
+	current_header[resumed_before_byte] = 0;
+	return 0;
+}
+
+static void free_header_data(void)
+{
+	if (!first_header_submit_info)
+		return;
+
+	while (first_header_submit_info) {
+		struct submit_params * next = first_header_submit_info->next;
+		kfree(first_header_submit_info);
+		first_header_submit_info = next;
+	}
+	
+	suspend_message(SUSPEND_WRITER, SUSPEND_LOW, 1,
+			" Freed swap pages in free_header_data.\n");
+	first_header_submit_info = last_header_submit_info = NULL;
+	return;
+}
+
+static int filewriter_storage_available(void)
+{
+	int result = 0;
+
+	if (!target_inode)
+		return 0;
+
+	switch (target_type) {
+		case 0:
+		case 5:
+		case 6: /* Socket, Char, Fifi */
+			return -1;
+		case 2: /* Regular file: current size - holes + free space on part */
+			result = target_storage_available;
+			break;
+		case 3: /* Block device */
+			if (target_bdev->bd_disk) {
+				if (target_bdev->bd_part)
+					result = (unsigned long)target_bdev->bd_part->nr_sects >> (PAGE_SHIFT - 9);
+				else
+					result = (unsigned long)target_bdev->bd_disk->capacity >> (PAGE_SHIFT - 9);
+			} else {
+				printk("bdev->bd_disk null.\n");
+				return 0;
+			}
+	}
+
+	return result;
+}
+
+static int filewriter_storage_allocated(void)
+{
+	int result;
+
+	if (!target_inode)
+		return 0;
+
+	if (target_is_normal_file()) {
+		result = (int) target_storage_available;
+	} else
+		result = header_pages + main_pages;
+
+	return result;
+}
+
+static int filewriter_initialise(int starting_cycle)
+{
+	if (!starting_cycle)
+		return 0;
+
+	target_fd = sys_open(filewriter_target, O_RDWR, 0);
+
+	if (target_fd < 0) {
+		printk("Open file %s returned %d.\n", filewriter_target, target_fd);
+		return target_fd;
+	}
+
+	target_inode = current->files->fd[target_fd]->f_dentry->d_inode;
+	BUG_ON(target_bdev);
+	target_bdev = target_inode->i_bdev ? target_inode->i_bdev : target_inode->i_sb->s_bdev;
+	set_target_blocksize();
+	get_target_info();
+
+	return 0;
+}
+
+static void filewriter_cleanup(int finishing_cycle)
+{
+	if (target_bdev) {
+		if (used_devt) {
+			blkdev_put(target_bdev);
+			used_devt = 0;
+		}
+		target_bdev = NULL;
+		get_target_info();
+	}
+
+	if (!finishing_cycle)
+		return;
+
+	if (target_fd >= 0)
+		sys_close(target_fd);
+
+	target_fd = -1;
+}
+
+static int filewriter_release_storage(void)
+{
+	if ((TEST_ACTION_STATE(SUSPEND_KEEP_IMAGE)) && test_suspend_state(SUSPEND_NOW_RESUMING))
+		return 0;
+
+	/* Free metadata */
+	free_header_data();
+
+	put_extent_chain(&block_chain);
+
+	header_pages = main_pages = 0;
+	return 0;
+}
+
+static int filewriter_allocate_header_space(int space_requested)
+{
+	int i, j, pages_to_get;
+	int ret = 0;
+
+	/* We only steal pages from the main pool. If it doesn't have any yet... */
+	
+	if (!block_chain.first)
+		return 0;
+
+	pages_to_get = space_requested - header_pages;
+
+	if (pages_to_get < 1)
+		return 0;
+
+	for (i= header_pages; i < space_requested; i++) {
+		struct submit_params * new_submit_param;
+
+		/* Get a submit structure */
+		new_submit_param = kmalloc(sizeof(struct submit_params), GFP_ATOMIC);
+		
+		if (!new_submit_param) {
+			printk("Failed to kmalloc a struct submit param.\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+
+		memset(new_submit_param, 0, sizeof(struct submit_params));
+
+		if (last_header_submit_info) {
+			last_header_submit_info->next = new_submit_param;
+			last_header_submit_info = new_submit_param;
+		} else
+			last_header_submit_info = first_header_submit_info =
+				new_submit_param;
+
+		for (j = 0; j < target_blocksperpage; j++) {
+			unsigned long newvalue;
+
+			/*
+			 *  Steal one from main extent chain. If, as a result,
+			 *  it is too small, more storage will be allocated or
+			 *  memory eaten.
+			 */
+
+			if (block_chain.first->minimum <
+					block_chain.first->maximum) {
+				newvalue = block_chain.first->minimum;
+				block_chain.first->minimum++;
+			} else {
+				struct extent * oldfirst =
+					block_chain.first;
+				block_chain.first = oldfirst->next;
+				block_chain.frees++;
+				if (block_chain.last == oldfirst)
+					block_chain.last = NULL;
+				newvalue = oldfirst->minimum;
+				put_extent(oldfirst);
+			}
+			
+			block_chain.size--;
+
+			new_submit_param->block[j] = newvalue;
+		}
+
+		new_submit_param->dev = target_bdev;
+		new_submit_param->readahead_index = -1;
+
+		header_pages++;
+
+		suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+			" Got header page %d/%d. Dev is %x. Block is %lu. "
+			"Target block size is %d.\n",
+			i, space_requested,
+			new_submit_param->dev,
+			new_submit_param->block[0],
+			new_submit_param->dev->bd_block_size);
+
+		if (!block_chain.size)
+			break;
+	}
+out:
+	return ret;
+}
+
+static int filewriter_allocate_storage(int space_requested)
+{
+	int result = 0;
+	int blocks_to_get = (space_requested << target_blockshift) - block_chain.size;
+	
+	/* Only release_storage reduces the size */
+	if (blocks_to_get < 1)
+		return 0;
+
+	main_pages = space_requested;
+
+	get_main_pool_phys_params();
+
+	suspend_message(SUSPEND_WRITER, SUSPEND_MEDIUM, 0,
+		"Finished with block_chain.size == %d.\n",
+		block_chain.size);
+
+	if (block_chain.size < ((header_pages + main_pages) << target_blockshift))
+		result = -ENOSPC;
+
+	return result;
+}
+
+static int filewriter_write_header_chunk(char * buffer, int buffer_size);
+static int filewriter_write_header_init(void)
+{
+	char new_sig[sig_size];
+	struct extent * extent;
+	
+	filewriter_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	header_link =
+		(unsigned long *) (filewriter_buffer + BYTES_PER_HEADER_PAGE);
+	filewriter_page_index = 1;
+	filewriter_buffer_posn = 0;
+
+	current_header_submit_info = first_header_submit_info;
+	
+	/* We change it once the whole header is written */
+	strcpy(new_sig, NoImage);
+	filewriter_write_header_chunk(new_sig, sig_size);
+
+	/* Must calculate extent number before writing the header! */
+	filewriter_header_data.pd1start_extent_number = 1;
+	extent = block_chain.first;
+
+	while (extent != filewriter_header_data.pd1start_block_extent) {
+		filewriter_header_data.pd1start_extent_number++;
+		extent = extent->next;
+	}
+
+	/* Info needed to bootstrap goes at the start of the header.
+	 * First we save the 'header_data' struct, including the number
+	 * of header pages. Then we save the structs containing data needed
+	 * for reading the header pages back.
+	 * Note that even if header pages take more than one page, when we
+	 * read back the info, we will have restored the location of the
+	 * next header page by the time we go to use it.
+	 */
+	filewriter_write_header_chunk((char *) &filewriter_header_data, 
+			sizeof(filewriter_header_data));
+
+	return 0;
+}
+
+static int filewriter_write_header_chunk(char * buffer, int buffer_size)
+{
+	int bytes_left = buffer_size;
+	
+	/* 
+	 * We buffer the writes until a page is full and to use the last
+	 * sizeof(swp_entry_t) bytes for links between pages. This is 
+	 * totally transparent to the caller.
+	 *
+	 * Note also that buffer_size can be > PAGE_SIZE.
+	 */
+
+	suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 0,
+		"\nStart of write_header_chunk loop with %d bytes to store.\n",
+		buffer_size);
+
+	while (bytes_left) {
+		char * source_start = buffer + buffer_size - bytes_left;
+		char * dest_start = filewriter_buffer + filewriter_buffer_posn;
+		int dest_capacity = BYTES_PER_HEADER_PAGE - filewriter_buffer_posn;
+		sector_t next_header_page;
+		if (bytes_left <= dest_capacity) {
+			memcpy(dest_start, source_start, bytes_left);
+			filewriter_buffer_posn += bytes_left;
+			return 0;
+		}
+	
+		/* A page is full */
+		memcpy(dest_start, source_start, dest_capacity);
+		bytes_left -= dest_capacity;
+
+		BUG_ON(!current_header_submit_info);
+
+		if (!current_header_submit_info->next) {
+			*header_link = 0;
+		} else {
+			next_header_page =
+				current_header_submit_info->next->block[0];
+
+			*header_link = next_header_page;
+		}
+
+		suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 0,
+			"Writing header page %d. "
+			"Dev is %x. Block is %lu. Blocksperpage is %d. Bd_block_size is %d.\n",
+			filewriter_page_index,
+			current_header_submit_info->dev->bd_dev,
+			current_header_submit_info->block[0],
+			target_blocksperpage,
+			current_header_submit_info->dev->bd_block_size);
+		
+		current_header_submit_info->page =
+			virt_to_page(filewriter_buffer);
+		check_shift_keys(0, NULL);
+		suspend_bio_ops.submit_io(WRITE, current_header_submit_info, 0);
+
+		filewriter_buffer_posn = 0;
+		filewriter_page_index++;
+		current_header_submit_info = current_header_submit_info->next;
+	}
+
+	return 0;
+}
+
+static int filewriter_write_header_cleanup(void)
+{
+	/* Write any unsaved data */
+	if (filewriter_buffer_posn) {
+		*header_link = 0;
+
+		suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 0,
+			"Writing header page %d. "
+			"Dev is %x. Block is %lu. Blocksperpage is %d.\n",
+			filewriter_page_index,
+			current_header_submit_info->dev->bd_dev,
+			current_header_submit_info->block[0],
+			target_blocksperpage);
+		
+		current_header_submit_info->page =
+			virt_to_page(filewriter_buffer);
+		suspend_bio_ops.submit_io(WRITE, 
+				current_header_submit_info, 0);
+	}
+
+	suspend_bio_ops.finish_all_io();
+
+	/* Adjust image header */
+	suspend_bio_ops.bdev_page_io(READ, target_bdev, target_firstblock,
+			virt_to_page(filewriter_buffer));
+
+	prepare_signature(first_header_submit_info, filewriter_buffer);
+		
+	suspend_bio_ops.bdev_page_io(WRITE, target_bdev, target_firstblock,
+			virt_to_page(filewriter_buffer));
+
+	free_pages((unsigned long) filewriter_buffer, 0);
+	filewriter_buffer = NULL;
+	header_link = NULL;
+	
+	suspend_bio_ops.finish_all_io();
+
+	return 0;
+}
+
+/* ------------------------- HEADER READING ------------------------- */
+
+/*
+ * read_header_init()
+ * 
+ * Description:
+ * 1. Attempt to read the device specified with resume2=.
+ * 2. Check the contents of the swap header for our signature.
+ * 3. Warn, ignore, reset and/or continue as appropriate.
+ * 4. If continuing, read the filewriter configuration section
+ *    of the header and set up block device info so we can read
+ *    the rest of the header & image.
+ *
+ * Returns:
+ * May not return if user choose to reboot at a warning.
+ * -EINVAL if cannot resume at this time. Booting should continue
+ * normally.
+ */
+
+static int filewriter_read_header_init(void)
+{
+	filewriter_page_index = 1;
+
+	filewriter_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	filewriter_buffer_posn = sig_size;
+
+	/* Read filewriter configuration */
+	suspend_bio_ops.bdev_page_io(READ, target_bdev, target_firstblock,
+			virt_to_page((unsigned long) filewriter_buffer));
+	
+	suspend_message(SUSPEND_WRITER, SUSPEND_HIGH, 0,
+		"Retrieving %d bytes from %x:%x to page %d, %p-%p.\n",
+		target_bdev->bd_dev, target_firstblock,
+		sizeof(filewriter_header_data),
+		filewriter_page_index,
+		filewriter_buffer, filewriter_buffer + sizeof(filewriter_header_data) - 1);
+	memcpy(&filewriter_header_data,
+			filewriter_buffer + filewriter_buffer_posn,
+			sizeof(filewriter_header_data));
+	
+	filewriter_buffer_posn += sizeof(filewriter_header_data);
+
+	return 0;
+}
+
+static int filewriter_read_header_chunk(char * buffer, int buffer_size)
+{
+	int bytes_left = buffer_size, ret = 0;
+	
+	/* Read a chunk of the header */
+	while ((bytes_left) && (!ret)) {
+		sector_t next =
+		   *((sector_t *) (filewriter_buffer + BYTES_PER_HEADER_PAGE));
+		char * dest_start = buffer + buffer_size - bytes_left;
+		char * source_start =
+			filewriter_buffer + filewriter_buffer_posn;
+		int source_capacity =
+			BYTES_PER_HEADER_PAGE - filewriter_buffer_posn;
+
+		if (bytes_left <= source_capacity) {
+			memcpy(dest_start, source_start, bytes_left);
+			filewriter_buffer_posn += bytes_left;
+			return buffer_size;
+		}
+
+		/* Next to read the next page */
+		memcpy(dest_start, source_start, source_capacity);
+		bytes_left -= source_capacity;
+
+		filewriter_page_index++;
+
+		suspend_bio_ops.bdev_page_io(READ, target_bdev,
+				next, virt_to_page(filewriter_buffer));
+
+		filewriter_buffer_posn = 0;
+	}
+
+	return buffer_size - bytes_left;
+}
+
+static int filewriter_read_header_cleanup(void)
+{
+	free_pages((unsigned long) filewriter_buffer, 0);
+	return 0;
+}
+
+static int filewriter_serialise_extents(void)
+{
+	serialise_extent_chain(&block_chain);
+	return 0;
+}
+
+static int filewriter_load_extents(void)
+{
+	int i = 1;
+	struct extent * extent;
+	
+	load_extent_chain(&block_chain);
+
+	extent = block_chain.first;
+
+	while (i < filewriter_header_data.pd1start_extent_number) {
+		extent = extent->next;
+		i++;
+	}
+
+	filewriter_header_data.pd1start_block_extent = extent;
+
+	return 0;
+}
+
+static int filewriter_write_init(int stream_number)
+{
+	if (stream_number == 1) {
+		currentblockextent = filewriter_header_data.pd1start_block_extent;
+		currentblockoffset = filewriter_header_data.pd1start_block_offset;
+	} else {
+		currentblockextent = block_chain.first;
+		currentblockoffset = currentblockextent->minimum;
+	}
+
+	BUG_ON(!currentblockextent);
+
+	filewriter_page_index = 1;
+	current_stream = stream_number;
+
+	suspend_bio_ops.reset_io_stats();
+
+	return 0;
+}
+
+static int filewriter_write_chunk(struct page * buffer_page)
+{
+	int i;
+	struct submit_params submit_params;
+
+	BUG_ON(!currentblockextent);
+	submit_params.readahead_index = -1;
+	submit_params.page = buffer_page;
+	submit_params.dev = target_bdev;
+		
+	/* Get the blocks */
+	for (i = 0; i < target_blocksperpage; i++) {
+		submit_params.block[i] = currentblockoffset;
+		GET_EXTENT_NEXT(currentblockextent, currentblockoffset);
+	}
+
+	if(!submit_params.block[0])
+		return -EIO;
+
+	if (TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
+		return 0;
+		
+	suspend_bio_ops.submit_io(WRITE, &submit_params, 0);
+
+	filewriter_page_index++;
+
+	return 0;
+}
+
+static int filewriter_write_cleanup(void)
+{
+	if (current_stream == 2) {
+		filewriter_header_data.pd1start_block_extent = currentblockextent;
+		filewriter_header_data.pd1start_block_offset = currentblockoffset;
+	}
+	
+	suspend_bio_ops.finish_all_io();
+	
+	suspend_bio_ops.check_io_stats();
+
+	return 0;
+}
+
+static int filewriter_read_init(int stream_number)
+{
+	if (stream_number == 1) {
+		currentblockextent = filewriter_header_data.pd1start_block_extent;
+		currentblockoffset = filewriter_header_data.pd1start_block_offset;
+	} else {
+		currentblockextent = NULL;
+		currentblockoffset = 0;
+		currentblockextent =
+			block_chain.first;
+		currentblockoffset = currentblockextent->minimum;
+	}
+
+	BUG_ON(!currentblockextent);
+
+	filewriter_page_index = 1;
+
+	suspend_bio_ops.reset_io_stats();
+
+	readahead_index = readahead_submit_index = -1;
+	readahead_allocs = readahead_frees = 0;
+
+	return 0;
+}
+
+static int filewriter_begin_read_chunk(struct page * page, 
+		int readahead_index, int sync)
+{
+	int i;
+	struct submit_params submit_params;
+
+	BUG_ON(!currentblockextent);
+	
+	submit_params.readahead_index = readahead_index;
+	submit_params.page = page;
+	submit_params.dev = target_bdev;
+		
+	/* Get the blocks. There is no chance that they span chains. */
+	for (i = 0; i < target_blocksperpage; i++) {
+		submit_params.block[i] = currentblockoffset;
+		GET_EXTENT_NEXT(currentblockextent, currentblockoffset);
+	}
+
+	if ((i = suspend_bio_ops.submit_io(READ, &submit_params, sync)))
+		return -EPERM;
+
+	filewriter_page_index++;
+
+	check_shift_keys(0, NULL);
+
+	return 0;
+}
+
+/* Note that we ignore the sync parameter. We are implementing
+ * read ahead, and will always wait until our readhead buffer has
+ * been read before returning.
+ */
+
+static int filewriter_read_chunk(struct page * buffer_page, int sync)
+{
+	static int last_result;
+	unsigned long * virt;
+
+	if (sync == SUSPEND_ASYNC)
+		return filewriter_begin_read_chunk(buffer_page, -1, sync);
+
+	/* Start new readahead while we wait for our page */
+	if (readahead_index == -1) {
+		last_result = 0;
+		readahead_index = readahead_submit_index = 0;
+	}
+
+	/* Start a new readahead? */
+	if (last_result) {
+		/* We failed to submit a read, and have cleaned up
+		 * all the readahead previously submitted */
+		if (readahead_submit_index == readahead_index)
+			return -EPERM;
+		goto wait;
+	}
+	
+	do {
+		if (suspend_bio_ops.prepare_readahead(readahead_submit_index))
+			break;
+
+		readahead_allocs++;
+
+		last_result = filewriter_begin_read_chunk(
+			suspend_bio_ops.readahead_pages[readahead_submit_index], 
+			readahead_submit_index, SUSPEND_ASYNC);
+		if (last_result) {
+			printk("Begin read chunk for page %d returned %d.\n",
+				readahead_submit_index, last_result);
+			suspend_bio_ops.cleanup_readahead(readahead_submit_index);
+			break;
+		}
+
+		readahead_submit_index++;
+
+		if (readahead_submit_index == MAX_READAHEAD)
+			readahead_submit_index = 0;
+
+	} while((!last_result) && (readahead_submit_index != readahead_index) &&
+			(!suspend_bio_ops.readahead_ready(readahead_index)));
+
+wait:
+	suspend_bio_ops.wait_on_readahead(readahead_index);
+
+	virt = kmap_atomic(buffer_page, KM_USER1);
+	memcpy(virt, page_address(suspend_bio_ops.readahead_pages[readahead_index]),
+			PAGE_SIZE);
+	kunmap_atomic(virt, KM_USER1);
+
+	suspend_bio_ops.cleanup_readahead(readahead_index);
+
+	readahead_frees++;
+
+	readahead_index++;
+	if (readahead_index == MAX_READAHEAD)
+		readahead_index = 0;
+
+	return 0;
+}
+
+static int filewriter_read_cleanup(void)
+{
+	suspend_bio_ops.finish_all_io();
+	while (readahead_index != readahead_submit_index) {
+		suspend_bio_ops.cleanup_readahead(readahead_index);
+		readahead_frees++;
+		readahead_index++;
+		if (readahead_index == MAX_READAHEAD)
+			readahead_index = 0;
+	}
+	suspend_bio_ops.check_io_stats();
+	BUG_ON(readahead_allocs != readahead_frees);
+	return 0;
+}
+
+/* filewriter_invalidate_image
+ * 
+ */
+static int filewriter_invalidate_image(void)
+{
+	char * cur;
+	int result = 0;
+	
+	cur = (char *) get_zeroed_page(GFP_ATOMIC);
+	if (!cur) {
+		printk("Unable to allocate a page for restoring the image signature.\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * If nr_suspends == 0, we must be booting, so no swap pages
+	 * will be recorded as used yet.
+	 */
+
+	if (nr_suspends > 0)
+		filewriter_release_storage();
+
+	/* 
+	 * We don't do a sanity check here: we want to restore the swap 
+	 * whatever version of kernel made the suspend image.
+	 * 
+	 * We need to write swap, but swap may not be enabled so
+	 * we write the device directly
+	 */
+	
+	suspend_bio_ops.bdev_page_io(READ, target_bdev,
+			target_firstblock, virt_to_page(cur));
+
+	result = parse_signature(cur, 1);
+		
+	if (result == -1)
+		goto out;
+
+	strcpy(cur, NoImage);
+	cur[resumed_before_byte] = 0;
+
+	suspend_bio_ops.bdev_page_io(WRITE, target_bdev, target_firstblock,
+			virt_to_page(cur));
+
+	if (!nr_suspends)
+		printk(KERN_WARNING name_suspend "Image invalidated.\n");
+out:
+	suspend_bio_ops.finish_all_io();
+	free_pages((unsigned long) cur, 0);
+	return 0;
+}
+
+/*
+ * workspace_size
+ *
+ * Description:
+ * Returns the number of bytes of RAM needed for this
+ * code to do its work. (Used when calculating whether
+ * we have enough memory to be able to suspend & resume).
+ *
+ */
+static unsigned long filewriter_memory_needed(void)
+{
+	return 0;
+}
+
+/* Print debug info
+ *
+ * Description:
+ */
+
+static int filewriter_print_debug_stats(char * buffer, int size)
+{
+	int len = 0;
+	struct sysinfo sysinfo;
+	
+	if (active_writer != &filewriterops) {
+		len = suspend_snprintf(buffer, size, "- Filewriter inactive.\n");
+		return len;
+	}
+
+	len = suspend_snprintf(buffer, size, "- Filewriter active.\n");
+
+	si_swapinfo(&sysinfo);
+	
+	len+= suspend_snprintf(buffer+len, size-len, "  Storage available for image: %ld pages.\n",
+			sysinfo.freeswap + filewriter_storage_allocated());
+
+	return len;
+	return 0;
+}
+
+/*
+ * Storage needed
+ *
+ * Returns amount of space in the image header required
+ * for the filewriter's data.
+ *
+ * We ensure the space is allocated, but actually save the
+ * data from write_header_init and therefore don't also define a
+ * save_config_info routine.
+ */
+static unsigned long filewriter_storage_needed(void)
+{
+	return strlen(filewriter_target) + 1;
+}
+
+/*
+ * Image_exists
+ *
+ */
+
+static int filewriter_image_exists(void)
+{
+	int signature_found;
+	char * diskpage;
+	
+	if (try_to_open_target_device())
+		return 0;
+
+	diskpage = (char *) get_zeroed_page(GFP_ATOMIC);
+
+	/* FIXME: Make sure bdev_page_io handles wrong parameters */
+	suspend_bio_ops.bdev_page_io(READ, target_bdev,
+			target_firstblock, virt_to_page(diskpage));
+	suspend_bio_ops.finish_all_io();
+	signature_found = parse_signature(diskpage, 0);
+	free_pages((unsigned long) diskpage, 0);
+
+	if (!signature_found) {
+		return 0;	/* non fatal error */
+	} else if (signature_found == -1) {
+		printk(KERN_ERR name_suspend
+			"Unable to find a signature. Could you have moved "
+			"the file?\n");
+		return 0;
+	}
+
+	return 1;
+}
+
+/*
+ * Mark resume attempted.
+ *
+ * Record that we tried to resume from this image.
+ */
+
+static void filewriter_mark_resume_attempted(void)
+{
+	char * diskpage;
+	int signature_found;
+	
+	if (!target_dev_t) {
+		printk("Not even trying to record attempt at resuming"
+				" because target_dev_t is not set.\n");
+		return;
+	}
+	
+	diskpage = (char *) get_zeroed_page(GFP_ATOMIC);
+
+	/* FIXME: Make sure bdev_page_io handles wrong parameters */
+	suspend_bio_ops.bdev_page_io(READ, target_bdev, target_firstblock, virt_to_page(diskpage));
+	signature_found = parse_signature(diskpage, 0);
+
+	switch (signature_found) {
+		case 1:
+			diskpage[resumed_before_byte] |= 1;
+			break;
+	}
+	
+	suspend_bio_ops.bdev_page_io(WRITE, target_bdev, target_firstblock,
+			virt_to_page(diskpage));
+	suspend_bio_ops.finish_all_io();
+	free_pages((unsigned long) diskpage, 0);
+	return;
+}
+
+/*
+ * Parse Image Location
+ *
+ * Attempt to parse a resume2= parameter.
+ * Swap Writer accepts:
+ * resume2=swap:DEVNAME[:FIRSTBLOCK][@BLOCKSIZE]
+ *
+ * Where:
+ * DEVNAME is convertable to a dev_t by name_to_dev_t
+ * FIRSTBLOCK is the location of the first block in the swap file
+ * (specifying for a swap partition is nonsensical but not prohibited).
+ * BLOCKSIZE is the logical blocksize >= 512 & <= PAGE_SIZE, 
+ * mod 512 == 0 of the device.
+ * Data is validated by attempting to read a swap header from the
+ * location given. Failure will result in filewriter refusing to
+ * save an image, and a reboot with correct parameters will be
+ * necessary.
+ */
+
+static int filewriter_parse_image_location(char * commandline, int only_writer)
+{
+	char *thischar, *devstart = NULL, *colon = NULL, *at_symbol = NULL;
+	char * diskpage = NULL;
+	int signature_found, result = -EINVAL, temp_result;
+
+	if (strncmp(commandline, "file:", 5)) {
+		if (!only_writer)
+			return 1;
+	} else
+		commandline += 5;
+
+	devstart = thischar = commandline;
+	while ((*thischar != ':') && (*thischar != '@') &&
+		((thischar - commandline) < 250) && (*thischar))
+		thischar++;
+
+	if (*thischar == ':') {
+		colon = thischar;
+		*colon = 0;
+		thischar++;
+	}
+
+	while ((*thischar != '@') && ((thischar - commandline) < 250) && (*thischar))
+		thischar++;
+
+	if (*thischar == '@') {
+		at_symbol = thischar;
+		*at_symbol = 0;
+	}
+	
+	if (colon)
+		target_firstblock = (int) simple_strtoul(colon + 1, NULL, 0);
+	else
+		target_firstblock = 0;
+
+	if (at_symbol) {
+		target_blocksize = (int) simple_strtoul(at_symbol + 1, NULL, 0);
+		if (target_blocksize & 0x1FF)
+			printk("Filewriter: Blocksizes are usually a multiple of 512. Don't expect this to work!\n");
+	} else
+		target_blocksize = 4096;
+	
+	temp_result = try_to_parse_target_dev_t(devstart);
+
+	if (colon)
+		*colon = ':';
+	if (at_symbol)
+		*at_symbol = '@';
+
+	if (temp_result)
+		goto out;
+
+	diskpage = (char *) get_zeroed_page(GFP_ATOMIC);
+	temp_result = suspend_bio_ops.bdev_page_io(READ, target_bdev, target_firstblock, virt_to_page(diskpage));
+
+	suspend_bio_ops.finish_all_io();
+	
+	if (temp_result) {
+		printk(KERN_ERR name_suspend "Filewriter: Failed to submit I/O.\n");
+		goto out;
+	}
+
+	signature_found = parse_signature(diskpage, 0);
+
+	if (signature_found != -1) {
+		printk(KERN_ERR name_suspend "Filewriter: File signature found.\n");
+		result = 0;
+	} else
+		printk(KERN_ERR name_suspend "Filewriter: Sorry. No signature found at specified location.\n");
+
+out:
+	if (diskpage)
+		free_page((unsigned long) diskpage);
+	return result;
+}
+
+static void set_filewriter_target(int test_it)
+{
+	char * buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	char * buffer2 = (char *) get_zeroed_page(GFP_ATOMIC);
+	int offset = 0, fd;
+	int sector;
+
+	if(target_bdev)
+		filewriter_cleanup(0);
+
+	fd = sys_open(filewriter_target, O_RDONLY, 0);
+
+	if (fd < 0) {
+		printk("Filewriter: Unable to open %s.\n", filewriter_target);
+		goto cleanup1;
+	}
+
+	*resume2_file = 0;
+	
+	target_inode = current->files->fd[fd]->f_dentry->d_inode;
+	target_type = get_target_type(target_inode);
+	
+	if (!target_is_usable) {
+		printk("Filewriter: %s is a link or directory. You can't suspend to them!\n",
+				filewriter_target);
+		goto cleanup2;
+	}
+
+	target_bdev = target_inode->i_bdev ? target_inode->i_bdev : target_inode->i_sb->s_bdev;
+	sector = bmap(target_inode, 0);
+
+	if (target_bdev && sector) {
+
+		target_blkbits = target_bdev->bd_inode->i_blkbits;
+
+		suspend_bio_ops.bdev_page_io(READ, target_bdev, sector,
+			virt_to_page(buffer));
+
+		bdevname(target_bdev, buffer2);
+		offset += snprintf(buffer + offset, PAGE_SIZE - offset, 
+				"/dev/%s", buffer2);
+		
+		if (sector)
+			offset += snprintf(buffer + offset, PAGE_SIZE - offset,
+				":0x%x", sector);
+
+		if (target_inode->i_sb->s_blocksize != PAGE_SIZE)
+			offset += snprintf(buffer + offset, PAGE_SIZE - offset,
+				"@%lu", target_inode->i_sb->s_blocksize);
+		
+	} else
+		offset += snprintf(buffer + offset, PAGE_SIZE - offset,
+				"%s is not a valid target.", filewriter_target);
+			
+	sprintf(resume2_file, "file:%s", buffer);
+
+cleanup2:
+	if (test_it)
+		sys_close(fd);
+
+cleanup1:
+	free_pages((unsigned long) buffer, 0);
+	free_pages((unsigned long) buffer2, 0);
+}
+
+/* filewriter_save_config_info
+ *
+ * Description:	Save the target's name, not for resume time, but for all_settings.
+ * Arguments:	Buffer:		Pointer to a buffer of size PAGE_SIZE.
+ * Returns:	Number of bytes used for saving our data.
+ */
+
+static int filewriter_save_config_info(char * buffer)
+{
+	strcpy(buffer, filewriter_target);
+	return strlen(filewriter_target) + 1;
+}
+
+/* filewriter_load_config_info
+ *
+ * Description:	Reload target's name.
+ * Arguments:	Buffer:		Pointer to the start of the data.
+ *		Size:		Number of bytes that were saved.
+ */
+
+static void filewriter_load_config_info(char * buffer, int size)
+{
+	strcpy(filewriter_target, buffer);
+}
+
+static void test_filewriter_target(void)
+{
+	set_filewriter_target(1);
+}
+
+extern void attempt_to_parse_resume_device(void);
+
+static struct suspend_proc_data filewriter_proc_data[] = {
+
+	{
+	 .filename			= "filewriter_target",
+	 .permissions			= PROC_RW,
+	 .type				= SUSPEND_PROC_DATA_STRING,
+	 .data = {
+		 .string = {
+			 .variable	= filewriter_target,
+			 .max_length	= 256,
+		 }
+	 },
+	 .write_proc			= test_filewriter_target,
+	},
+
+	{ .filename			= "disable_filewriter",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &filewriterops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	  },
+	  .write_proc			= attempt_to_parse_resume_device,
+	}
+};
+
+static struct suspend_plugin_ops filewriterops = {
+	.type					= WRITER_PLUGIN,
+	.name					= "File Writer",
+	.module					= THIS_MODULE,
+	.memory_needed				= filewriter_memory_needed,
+	.print_debug_info			= filewriter_print_debug_stats,
+	.save_config_info			= filewriter_save_config_info,
+	.load_config_info			= filewriter_load_config_info,
+	.storage_needed				= filewriter_storage_needed,
+	.initialise				= filewriter_initialise,
+	.cleanup				= filewriter_cleanup,
+
+	.write_init				= filewriter_write_init,
+	.write_cleanup				= filewriter_write_cleanup,
+	.read_init				= filewriter_read_init,
+	.read_cleanup				= filewriter_read_cleanup,
+
+	.ops = {
+		.writer = {
+		 .write_chunk		= filewriter_write_chunk,
+		 .read_chunk		= filewriter_read_chunk,
+		 .noresume_reset	= filewriter_noresume_reset,
+		 .storage_available 	= filewriter_storage_available,
+		 .storage_allocated	= filewriter_storage_allocated,
+		 .release_storage	= filewriter_release_storage,
+		 .allocate_header_space	= filewriter_allocate_header_space,
+		 .allocate_storage	= filewriter_allocate_storage,
+		 .image_exists		= filewriter_image_exists,
+		 .mark_resume_attempted	= filewriter_mark_resume_attempted,
+		 .write_header_init	= filewriter_write_header_init,
+		 .write_header_chunk	= filewriter_write_header_chunk,
+		 .write_header_cleanup	= filewriter_write_header_cleanup,
+		 .read_header_init	= filewriter_read_header_init,
+		 .read_header_chunk	= filewriter_read_header_chunk,
+		 .read_header_cleanup	= filewriter_read_header_cleanup,
+		 .serialise_extents	= filewriter_serialise_extents,
+		 .load_extents		= filewriter_load_extents,
+		 .invalidate_image	= filewriter_invalidate_image,
+		 .parse_image_location	= filewriter_parse_image_location,
+		}
+	}
+};
+
+/* ---- Registration ---- */
+static __init int filewriter_load(void)
+{
+	int result;
+	int i, numfiles = sizeof(filewriter_proc_data) / sizeof(struct suspend_proc_data);
+	
+	printk("Software Suspend FileWriter loading.\n");
+
+	if (!(result = suspend_register_plugin(&filewriterops))) {
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&filewriter_proc_data[i]);
+	} else
+		printk("Software Suspend FileWriter unable to register!\n");
+	return result;
+}
+
+#ifdef MODULE
+static __exit void filewriter_unload(void)
+{
+	int i, numfiles = sizeof(filewriter_proc_data) / sizeof(struct suspend_proc_data);
+
+	printk("Software Suspend FileWriter unloading.\n");
+
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&filewriter_proc_data[i]);
+	suspend_unregister_plugin(&filewriterops);
+}
+
+module_init(filewriter_load);
+module_exit(filewriter_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 filewriter");
+#else
+late_initcall(filewriter_load);
+#endif

