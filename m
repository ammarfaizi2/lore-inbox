Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262070AbVGFEc2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbVGFEc2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:32:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261593AbVGFEc2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:32:28 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:12953 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262085AbVGFCTk convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:40 -0400
Subject: [PATCH] [45/48] Suspend2 2.1.9.8 for 2.6.12: 621-swsusp-tidy.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:44 +1000
Message-Id: <11206164441379@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 622-swapwriter.patch-old/kernel/power/suspend_swap.c 622-swapwriter.patch-new/kernel/power/suspend_swap.c
--- 622-swapwriter.patch-old/kernel/power/suspend_swap.c	1970-01-01 10:00:00.000000000 +1000
+++ 622-swapwriter.patch-new/kernel/power/suspend_swap.c	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,1713 @@
+/*
+ * Swapwriter.c
+ *
+ * Copyright 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * Distributed under GPLv2.
+ * 
+ * This file encapsulates functions for usage of swap space as a
+ * backing store.
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/blkdev.h>
+#include <linux/swapops.h>
+
+#include "suspend2_core/suspend.h"
+#include "suspend2_core/suspend2_common.h"
+#include "suspend2_core/version.h"
+#include "suspend2_core/proc.h"
+#include "suspend2_core/plugins.h"
+#include "suspend2_core/io.h"
+#include "suspend2_core/ui.h"
+#include "suspend2_core/extent.h"
+#include "suspend2_core/utility.h"
+
+#include "block_io.h"
+
+static struct suspend_plugin_ops swapwriterops;
+
+#define SIGNATURE_VER 6
+#define BYTES_PER_HEADER_PAGE (PAGE_SIZE - sizeof(swp_entry_t))
+
+/* --- Struct of pages stored on disk */
+
+struct swaplink {
+	char dummy[BYTES_PER_HEADER_PAGE];
+	swp_entry_t next;
+};
+
+union diskpage {
+	union swap_header swh;	/* swh.magic is the only member used */
+	struct swaplink link;
+	struct suspend_header sh;
+};
+
+union p_diskpage {
+	union diskpage *pointer;
+	char *ptr;
+        unsigned long address;
+};
+
+// Higher Level
+static int readahead_index = 0, readahead_submit_index = 0;
+static int readahead_allocs = 0, readahead_frees = 0;
+
+static char * swapwriter_buffer = NULL;
+static int swapwriter_buffer_posn = 0;
+static unsigned long * header_link = NULL;
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
+ * Pagedir2 swap comes before pagedir1 swap (save order), and the first swap
+ * entry for pagedir1 to use is set when pagedir2 is written (when we know how
+ * much swap it used). Since this first entry is almost certainly not at the
+ * start of a extent, the firstoffset variable below tells us where to start in
+ * the extent. All of this means we don't have to worry about getting different
+ * compression ratios for the kernel and cache (when compressing the image).
+ * We can simply allocate one pool of swap (size determined using expected
+ * compression ratio) and use it without worrying whether one pageset
+ * compresses better and the other worse (this is what happens). As long as the
+ * user gets the expected compression right, it will work.
+ */
+
+struct {
+	/* Extent chains for swap & blocks */
+	struct extentchain swapextents;
+	struct extentchain block_chain[MAX_SWAPFILES];
+	
+	/* Location of start of pagedir 1 */
+	struct extent * pd1start_block_extent;
+	int pd1start_chain;
+	int pd1start_extent_number;
+	unsigned long pd1start_block_offset;
+
+	/* Devices used for swap */
+	dev_t swapdevs[MAX_SWAPFILES];
+	char blocksizes[MAX_SWAPFILES];
+
+} header_data;
+
+static dev_t header_device = 0;
+static struct block_device * header_block_device = NULL;
+static int headerblocksize = PAGE_SIZE;
+static int headerblock;
+
+/* For swapfile automatically swapon/off'd. */
+static char swapfilename[256] = "";
+extern asmlinkage long sys_swapon(const char * specialfile, int swap_flags);
+extern asmlinkage long sys_swapoff(const char * specialfile);
+static int suspend_swapon_status = 0;
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
+ * remember the last swap entry used at the end of writing pageset2, and
+ * get that location when saving or reloading pageset1.*/
+static int current_stream = 0;
+
+/* Pointer to current swap entry being loaded/saved. */
+static struct extent * currentblockextent = NULL;
+static unsigned long currentblockoffset = 0;
+static int currentblockchain = 0;
+static int currentblocksperpage = 0;
+
+/* Header Page Information */
+static int header_pages_allocated = 0;
+static struct submit_params * first_header_submit_info = NULL,
+ * last_header_submit_info = NULL, * current_header_submit_info = NULL;
+
+/*
+ * ---------------------------------------------------------------
+ *
+ *     User Specified Parameters
+ *
+ * ---------------------------------------------------------------
+ */
+
+static int resume_firstblock = 0;
+static int resume_firstblocksize = PAGE_SIZE;
+static dev_t resume_device = 0;
+static struct block_device * resume_block_device = NULL;
+
+struct sysinfo swapinfo;
+static int swapwriter_invalidate_image(void);
+
+static void cleanup_opened_devices(int including_swapdevices)
+{
+	int i;
+
+	/* Cleanup our open_by_devnums.
+	 *
+	 * Other swap devices, opened when reading pageset1, are
+	 * either cleaned up by noresume_reset
+	 */
+
+	if (header_block_device && header_block_device != resume_block_device)
+		blkdev_put(header_block_device);
+
+	if (resume_block_device)
+		blkdev_put(resume_block_device);
+
+	/* When reading pageset1 header */
+	if (including_swapdevices) {
+		for (i = 0; i < MAX_SWAPFILES; i++) {
+			struct block_device * this_dev = swap_info[i].bdev;
+			if (this_dev && this_dev != resume_block_device &&
+					this_dev != header_block_device) {
+				blkdev_put(swap_info[i].bdev);
+				swap_info[i].bdev = NULL;
+			}
+		}
+	}
+	
+	header_block_device = resume_block_device = NULL;
+}
+/* Must be silent - might be called from cat /proc/suspend/debug_info
+ * Returns 0 if was off, -EBUSY if was on, error value otherwise.
+ */
+static int enable_swapfile(void)
+{
+	int activateswapresult = -EINVAL;
+
+	if (suspend_swapon_status)
+		return 0;
+
+	if (swapfilename[0]) {
+		/* Attempt to swap on with maximum priority */
+		activateswapresult = sys_swapon(swapfilename, 0xFFFF);
+		if ((activateswapresult) && (activateswapresult != -EBUSY))
+			printk(name_suspend
+				"The swapfile/partition specified by "
+				"/proc/suspend/swapfile (%s) could not"
+				" be turned on (error %d). Attempting "
+				"to continue.\n",
+				swapfilename, activateswapresult);
+		if (!activateswapresult)
+			suspend_swapon_status = 1;
+	}
+	return activateswapresult;
+}
+
+/* Returns 0 if was on, -EINVAL if was off, error value otherwise */
+static int disable_swapfile(void)
+{
+	int result = -EINVAL;
+	
+	if (!suspend_swapon_status)
+		return 0;
+
+	if (swapfilename[0]) {
+		result = sys_swapoff(swapfilename);
+		if (result == -EINVAL)
+	 		return 0;	/* Wasn't on */
+		if (!result)
+			suspend_swapon_status = 0;
+	}
+
+	return result;
+}
+
+static int manage_swapfile(int enable)
+{
+	static int result;
+
+	if (enable)
+		result = enable_swapfile();
+	else
+		result = disable_swapfile();
+
+	return result;
+}
+
+static void get_header_params(struct submit_params * headerpage)
+{
+	swp_entry_t entry = headerpage->swap_address;
+	int swapfilenum = swp_type(entry);
+	unsigned long offset = swp_offset(entry);
+	struct swap_info_struct * sis = get_swap_info_struct(swapfilenum);
+	sector_t sector = map_swap_page(sis, offset);
+
+	headerpage->dev = sis->bdev,
+	headerpage->block[0] = sector;
+	//headerpage->blocks_used = 1;
+	headerpage->readahead_index = -1;
+}
+
+static inline int get_blocks_per_page(int chain)
+{
+	int result = PAGE_SIZE /
+		suspend_bio_ops.get_block_size(swap_info[chain].bdev);
+	return result;
+}
+
+static int try_to_parse_header_device(void)
+{
+	header_block_device = open_by_devnum(header_device, FMODE_READ);
+
+	if (IS_ERR(header_block_device) || (!header_block_device)) {
+		if (suspend_early_boot_message(1,SUSPEND_CONTINUE_REQ,  
+				"Failed to get access to the "
+				"resume header device.\nYou could be "
+				"booting with a 2.6 kernel when you "
+				"suspended a 2.4 kernel."))
+			swapwriter_invalidate_image();
+		return -EINVAL;
+	}
+
+	if (set_blocksize(header_block_device, PAGE_SIZE) < 0) {
+		if (suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+			"Failed to set the blocksize for a swap device."))
+				do { } while(0);
+		swapwriter_invalidate_image();
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int try_to_open_resume_device(void)
+{
+	resume_block_device = open_by_devnum(resume_device, FMODE_READ);
+
+	if (IS_ERR(resume_block_device) || (!resume_block_device))
+		return 1;
+
+	return 0;
+}
+
+static int try_to_parse_resume_device(char * commandline)
+{
+	struct kstat stat;
+	int error;
+
+	resume_device = name_to_dev_t(commandline);
+
+	if (!resume_device) {
+		error = vfs_stat(commandline, &stat);
+		if (!error)
+			resume_device = stat.rdev;
+	}
+
+	if (!resume_device) {
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
+	if (try_to_open_resume_device()) {
+		suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+			"Failed to get access to \"%s\", where"
+			" the swap header should be found.",
+			commandline);
+		return 1;
+	}
+
+	return 0;
+}
+
+static void open_other_swap_device(int i, dev_t thisdevice)
+{
+	if ((swap_info[i].bdev = open_by_devnum(thisdevice, FMODE_READ)))
+		set_blocksize(swap_info[i].bdev, PAGE_SIZE);
+}
+
+static inline char * get_path_for_swapfile(int which, char * path_page)
+{
+	return d_path(	swap_info[which].swap_file->f_dentry,
+			swap_info[which].swap_file->f_vfsmnt,
+			path_page,
+			PAGE_SIZE);
+}
+
+/* 
+ * If we have read part of the image, we might have filled header_data with
+ * data that should be zeroed out.
+ */
+static void swapwriter_noresume_reset(void)
+{
+	memset((char *) &header_data, 0, sizeof(header_data));
+	cleanup_opened_devices(1);
+}
+
+static int parse_signature(char * header, int restore)
+{
+	int type = -1;
+	
+	if (!memcmp("SWAP-SPACE",header,10))
+		return 0;
+	else if (!memcmp("SWAPSPACE2",header,10))
+		return 1;
+
+	else if (!memcmp("pmdisk", header,6))
+		type = 2;
+	
+	else if (!memcmp("S1SUSP",header,6))
+		type = 4;
+	else if (!memcmp("S2SUSP",header,6))
+		type = 5;
+	
+	else if (!memcmp("z",header,1))
+		type = 12;
+	else if (!memcmp("Z",header,1))
+		type = 13;
+	
+	/* 
+	 * Put bdev of suspend header in last byte of swap header
+	 * (unsigned short)
+	 */
+	if (type > 11) {
+		dev_t * header_ptr = (dev_t *) &header[1];
+		unsigned char * headerblocksize_ptr =
+			(unsigned char *) &header[5];
+		unsigned long * headerblock_ptr = (unsigned long *) &header[6];
+		header_device = *header_ptr;
+		/* 
+		 * We are now using the highest bit of the char to indicate
+		 * whether we have attempted to resume from this image before.
+		 */
+		clear_suspend_state(SUSPEND_RESUMED_BEFORE);
+		if (((int) *headerblocksize_ptr) & 0x80)
+			set_suspend_state(SUSPEND_RESUMED_BEFORE);
+		headerblocksize = 512 * (((int) *headerblocksize_ptr) & 0xf);
+		headerblock = *headerblock_ptr;
+	}
+
+	if ((restore) && (type > 5)) {
+		/* We only reset our own signatures */
+		if (type & 1)
+			memcpy(header,"SWAPSPACE2",10);
+		else
+			memcpy(header,"SWAP-SPACE",10);
+	}
+
+	return type;
+}
+
+/*
+ * prepare_signature
+ */
+
+static int prepare_signature(struct submit_params * header_page_info,
+		char * current_header)
+{
+	int current_type = parse_signature(current_header, 0);
+	dev_t * header_ptr = (dev_t *) (&current_header[1]);
+	unsigned char * headerblocksize_ptr =
+		(unsigned char *) (&current_header[5]);
+	unsigned long * headerblock_ptr =
+		(unsigned long *) (&current_header[6]);
+
+	if ((current_type > 1) && (current_type < 6))
+		return 1;
+
+	if (current_type & 1)
+		current_header[0] = 'Z';
+	else
+		current_header[0] = 'z';
+	*header_ptr = header_page_info->dev->bd_dev;
+	*headerblocksize_ptr =
+		(unsigned char) (header_page_info->dev->bd_block_size >> 9);
+	/* prev is the first/last swap page of the resume area */
+	*headerblock_ptr = (unsigned long) header_page_info->block[0]; 
+	return 0;
+}
+
+extern int signature_check(char * header, int fix);
+
+static int free_swap_pages_for_header(void)
+{
+	if (!first_header_submit_info)
+		return 1;
+
+	while (first_header_submit_info) {
+		struct submit_params * next = first_header_submit_info->next;
+		if (first_header_submit_info->swap_address.val)
+			swap_free(first_header_submit_info->swap_address);
+		kfree(first_header_submit_info);
+		first_header_submit_info = next;
+	}
+	
+	first_header_submit_info = last_header_submit_info = NULL;
+	header_pages_allocated = 0;
+	return 0;
+}
+
+static void get_main_pool_phys_params(void)
+{
+	struct extent * extentpointer = NULL;
+	unsigned long address;
+	int i;
+	int extent_min = -1, extent_max = -1;
+	int last_chain = -1;
+
+	for (i = 0; i < MAX_SWAPFILES; i++)
+		if (header_data.block_chain[i].first)
+			put_extent_chain(&header_data.block_chain[i]);
+
+	extent_for_each(&header_data.swapextents, extentpointer, address) {
+		swp_entry_t swap_address = extent_val_to_swap_entry(address);
+		int swapfilenum = swp_type(swap_address);
+		unsigned long offset = swp_offset(swap_address);
+		struct swap_info_struct * sis = get_swap_info_struct(swapfilenum);
+		sector_t new_sector = map_swap_page(sis, offset);
+
+		if ((new_sector == extent_max + 1) &&
+		    (last_chain == swapfilenum))
+			extent_max++;
+		else {
+			if (extent_min > 0)
+				append_extent_to_extent_chain(
+					&header_data.block_chain[last_chain],
+					extent_min, extent_max);
+			extent_min = extent_max = new_sector;
+			last_chain = swapfilenum;
+		}
+	}
+	if (extent_min > -1)
+		append_extent_to_extent_chain(
+			&header_data.block_chain[last_chain],
+			extent_min, extent_max);
+}
+
+static int swapwriter_storage_allocated(void)
+{
+	int result;
+	result = header_data.swapextents.size + header_pages_allocated;
+	return result;
+}
+
+static int swapwriter_storage_available(void)
+{
+	int result;
+	si_swapinfo(&swapinfo);
+	result = swapinfo.freeswap + swapwriter_storage_allocated();
+	return result;
+}
+
+static int swapwriter_initialise(int starting_cycle)
+{
+	if (starting_cycle)
+		manage_swapfile(1);
+
+	if (!resume_block_device && try_to_open_resume_device())
+		return 1;
+	
+	return 0;
+}
+
+static void swapwriter_cleanup(int ending_cycle)
+{
+	if (ending_cycle)
+		manage_swapfile(0);
+	
+	cleanup_opened_devices(0);
+}
+
+static int swapwriter_release_storage(void)
+{
+	int i = 0;
+
+	if ((TEST_ACTION_STATE(SUSPEND_KEEP_IMAGE)) && test_suspend_state(SUSPEND_NOW_RESUMING))
+		return 0;
+
+	free_swap_pages_for_header();
+	
+	if (header_data.swapextents.first) {
+		/* Free swap entries */
+		struct extent * extentpointer;
+		unsigned long extentvalue;
+		swp_entry_t entry;
+		extent_for_each(&header_data.swapextents, extentpointer, 
+				extentvalue) {
+			entry = extent_val_to_swap_entry(extentvalue);
+			swap_free(entry);
+		}
+		put_extent_chain(&header_data.swapextents);
+		
+		for (i = 0; i < MAX_SWAPFILES; i++)
+			if (header_data.block_chain[i].first)
+				put_extent_chain(&header_data.block_chain[i]);
+	}
+	
+	return 0;
+}
+
+static int swapwriter_allocate_header_space(int space_really_requested)
+{
+	/* space_requested was going to be in bytes... not yet */
+	int i;
+	int ret = 0;
+	long space_requested;
+
+	/* 
+	 * Up to here in the process, we haven't taken account of the fact
+	 * that we need an extra four bytes per 4092 bytes written for link
+	 * to the next page on which the header will be written. We factor
+	 * that in here.
+	 */
+	space_requested = ((long) space_really_requested) << PAGE_SHIFT;
+	space_requested = ((space_really_requested + 4091) / 4092);
+	space_requested = (space_requested * 4 + 4091) / 4092;
+	space_requested += space_really_requested;
+	
+	for (i=(header_pages_allocated+1); i<=space_requested; i++) {
+		struct submit_params * new_submit_param;
+		
+		/* Get a submit structure */
+		new_submit_param = kmalloc(sizeof(struct submit_params), GFP_ATOMIC);
+		
+		if (!new_submit_param) {
+			header_pages_allocated = i - 1;
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
+		/* Get swap entry */
+		new_submit_param->swap_address = get_swap_page();
+		
+		if ((!new_submit_param->swap_address.val) &&
+			       (header_data.swapextents.first)) {
+			/*
+			 *  Steal one from pageset swap chain. If, as a result,
+			 *  it is too small, more swap will be allocated or
+			 *  memory eaten.
+			 */
+
+			new_submit_param->swap_address =
+				extent_val_to_swap_entry(
+					header_data.swapextents.first->minimum);
+			if (header_data.swapextents.first->minimum <
+					header_data.swapextents.first->maximum)
+				header_data.swapextents.first->minimum++;
+			else {
+				struct extent * oldfirst =
+					header_data.swapextents.first;
+				header_data.swapextents.first = oldfirst->next;
+				header_data.swapextents.frees++;
+				if (header_data.swapextents.last == oldfirst)
+					header_data.swapextents.last = NULL;
+				put_extent(oldfirst);
+			}
+			
+			header_data.swapextents.size--;
+
+			/*
+			 * Recalculate block chains for main pool.
+			 * We don't assume blocks are at start of a chain and
+			 * don't know how many blocks per swap entry.
+			 */
+			get_main_pool_phys_params();
+		}
+		if (!new_submit_param->swap_address.val) {
+			free_swap_pages_for_header();
+			printk("Unable to allocate swap page for header.\n");
+			ret = -ENOMEM;
+			goto out;
+		}
+		
+		get_header_params(new_submit_param);
+	}
+	header_pages_allocated = space_requested;
+out:
+	return ret;
+}
+
+static int swapwriter_allocate_storage(int space_requested)
+{
+	int i, result = 0;
+	int pages_to_get = space_requested - header_data.swapextents.size;
+	int extent_min = -1, extent_max = -1;
+	
+	if (pages_to_get < 1)
+		return 0;
+
+	for(i=0; i < pages_to_get; i++) {
+		swp_entry_t entry;
+		int new_value;
+
+		entry = get_swap_page();
+		if (!entry.val) {
+			result = -ENOSPC;
+			goto out;
+		}
+		
+		new_value = swap_entry_to_extent_val(entry);
+		if (new_value == extent_max + 1)
+			extent_max++;
+		else {
+			if (extent_min > -1)
+				append_extent_to_extent_chain(
+					&header_data.swapextents,
+					extent_min, extent_max);
+			extent_min = extent_max = new_value;
+		}
+	}
+
+	if (extent_min > -1)
+		append_extent_to_extent_chain(
+			&header_data.swapextents,
+		       extent_min, extent_max);
+
+out:
+	get_main_pool_phys_params();
+	return result;
+}
+
+static int swapwriter_write_header_chunk(char * buffer, int buffer_size)
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
+	while (bytes_left) {
+		char * source_start = buffer + buffer_size - bytes_left;
+		char * dest_start = swapwriter_buffer + swapwriter_buffer_posn;
+		int dest_capacity = BYTES_PER_HEADER_PAGE - swapwriter_buffer_posn;
+		swp_entry_t next_header_page;
+		if (bytes_left <= dest_capacity) {
+			memcpy(dest_start, source_start, bytes_left);
+			swapwriter_buffer_posn += bytes_left;
+			return 0;
+		}
+	
+		/* A page is full */
+		memcpy(dest_start, source_start, dest_capacity);
+		bytes_left -= dest_capacity;
+
+		BUG_ON(!current_header_submit_info);
+
+		if (!current_header_submit_info->next)
+			*header_link = 0;
+		else {
+			next_header_page =
+				swp_entry(swp_type(
+				current_header_submit_info->next->swap_address),
+				current_header_submit_info->next->block[0]);
+
+			*header_link = next_header_page.val;
+		}
+
+		current_header_submit_info->page =
+			virt_to_page(swapwriter_buffer);
+		check_shift_keys(0, NULL);
+		suspend_bio_ops.submit_io(WRITE, current_header_submit_info, 0);
+
+		swapwriter_buffer_posn = 0;
+		current_header_submit_info = current_header_submit_info->next;
+	}
+
+	return 0;
+}
+
+static int swapwriter_write_header_init(void)
+{
+	int i;
+	struct extent * extent;
+
+	for (i = 0; i < MAX_SWAPFILES; i++)
+		if (swap_info[i].swap_file) {
+			header_data.swapdevs[i] = swap_info[i].bdev->bd_dev;
+			header_data.blocksizes[i] =
+				block_size(swap_info[i].bdev);
+		}
+
+	swapwriter_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	header_link =
+		(unsigned long *) (swapwriter_buffer + BYTES_PER_HEADER_PAGE);
+
+	current_header_submit_info = first_header_submit_info;
+	
+	header_data.pd1start_extent_number = 1;
+	extent = header_data.block_chain[header_data.pd1start_chain].first;
+
+	while (extent != header_data.pd1start_block_extent) {
+		header_data.pd1start_extent_number++;
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
+	return swapwriter_write_header_chunk((char *) &header_data, 
+			sizeof(header_data));
+}
+
+static int swapwriter_write_header_cleanup(void)
+{
+	/* Write any unsaved data */
+	if (swapwriter_buffer_posn) {
+		*header_link = 0;
+
+		current_header_submit_info->page =
+			virt_to_page(swapwriter_buffer);
+		suspend_bio_ops.submit_io(WRITE, 
+				current_header_submit_info, 0);
+	}
+
+	/* Adjust swap header */
+	suspend_bio_ops.bdev_page_io(READ, resume_block_device, resume_firstblock,
+			virt_to_page(swapwriter_buffer));
+
+	prepare_signature(first_header_submit_info,
+		((union swap_header *) swapwriter_buffer)->magic.magic);
+		
+	suspend_bio_ops.bdev_page_io(WRITE, resume_block_device, resume_firstblock,
+			virt_to_page(swapwriter_buffer));
+
+	free_pages((unsigned long) swapwriter_buffer, 0);
+	swapwriter_buffer = NULL;
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
+ * 4. If continuing, read the swapwriter configuration section
+ *    of the header and set up block device info so we can read
+ *    the rest of the header & image.
+ *
+ * Returns:
+ * May not return if user choose to reboot at a warning.
+ * -EINVAL if cannot resume at this time. Booting should continue
+ * normally.
+ */
+
+static int swapwriter_read_header_init(void)
+{
+	int i;
+	
+	BUG_ON(!resume_block_device);
+
+	swapwriter_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+
+	if (!header_device) {
+		printk("read_header_init called when we haven't "
+				"verified there is an image!\n");
+		return -EINVAL;
+	}
+
+	/* 
+	 * If the header is not on the resume_device, get the resume device first.
+	 */
+	if (header_device != resume_device) {
+		int result = try_to_parse_header_device();
+
+		if (result)
+			return result;
+	} else
+		header_block_device = resume_block_device;
+
+	/* Read swapwriter configuration */
+	suspend_bio_ops.bdev_page_io(READ, header_block_device, headerblock,
+			virt_to_page((unsigned long) swapwriter_buffer));
+	
+	memcpy(&header_data, swapwriter_buffer, sizeof(header_data));
+	
+	/* Restore device info */
+	for (i = 0; i < MAX_SWAPFILES; i++) {
+		dev_t thisdevice = header_data.swapdevs[i];
+		
+		swap_info[i].bdev = NULL;
+
+		if (!thisdevice)
+			continue;
+
+		if (thisdevice == resume_device) {
+			swap_info[i].bdev = resume_block_device;
+			/* Mark as used so the device doesn't get suspended. */
+			swap_info[i].swap_file = (struct file *) 0xffffff;
+			continue;
+		}
+
+		if (thisdevice == header_device) {
+			swap_info[i].bdev = header_block_device;
+			/* Mark as used so the device doesn't get suspended. */
+			swap_info[i].swap_file = (struct file *) 0xffffff;
+			continue;
+		}
+
+		open_other_swap_device(i, thisdevice);
+		swap_info[i].swap_file = (struct file *) 0xffffff;
+	}
+
+	swapwriter_buffer_posn = sizeof(header_data);
+
+	return 0;
+}
+
+static int swapwriter_read_header_chunk(char * buffer, int buffer_size)
+{
+	int bytes_left = buffer_size, ret = 0;
+	
+	check_shift_keys(0, "");
+
+	/* Read a chunk of the header */
+	while ((bytes_left) && (!ret)) {
+		swp_entry_t next =
+		   ((union p_diskpage) swapwriter_buffer).pointer->link.next;
+		struct block_device * dev = swap_info[swp_type(next)].bdev;
+		int pos = swp_offset(next);
+		char * dest_start = buffer + buffer_size - bytes_left;
+		char * source_start =
+			swapwriter_buffer + swapwriter_buffer_posn;
+		int source_capacity =
+			BYTES_PER_HEADER_PAGE - swapwriter_buffer_posn;
+
+		if (bytes_left <= source_capacity) {
+			memcpy(dest_start, source_start, bytes_left);
+			swapwriter_buffer_posn += bytes_left;
+			return buffer_size;
+		}
+
+		/* Next to read the next page */
+		memcpy(dest_start, source_start, source_capacity);
+		bytes_left -= source_capacity;
+
+		suspend_bio_ops.bdev_page_io(READ, dev, pos, virt_to_page(swapwriter_buffer));
+
+		swapwriter_buffer_posn = 0;
+	}
+
+	return buffer_size - bytes_left;
+}
+
+static int swapwriter_read_header_cleanup(void)
+{
+	free_pages((unsigned long) swapwriter_buffer, 0);
+	return 0;
+}
+
+static int swapwriter_serialise_extents(void)
+{
+	int i;
+
+	serialise_extent_chain(&header_data.swapextents);
+	
+	for (i = 0; i < MAX_SWAPFILES; i++)
+		serialise_extent_chain(&header_data.block_chain[i]);
+	
+	return 0;
+}
+
+static int swapwriter_load_extents(void)
+{
+	int i;
+	struct extent * extent;
+	
+	load_extent_chain(&header_data.swapextents);
+
+	for (i = 0; i < MAX_SWAPFILES; i++)
+		load_extent_chain(&header_data.block_chain[i]);
+
+	extent = header_data.block_chain[header_data.pd1start_chain].first;
+
+	i = 1;
+	while (i < header_data.pd1start_extent_number) {
+		extent = extent->next;
+		i++;
+	}
+
+	header_data.pd1start_block_extent = extent;
+
+	return 0;
+}
+
+static int swapwriter_write_init(int stream_number)
+{
+	current_stream = stream_number;
+
+	if (current_stream == 1) {
+		currentblockextent = header_data.pd1start_block_extent;
+		currentblockoffset = header_data.pd1start_block_offset;
+		currentblockchain = header_data.pd1start_chain;
+	} else
+		for (currentblockchain = 0; currentblockchain < MAX_SWAPFILES;
+				currentblockchain++)
+			if (header_data.block_chain[currentblockchain].first) {
+				currentblockextent =
+					header_data.
+					 block_chain[currentblockchain].first;
+				currentblockoffset = currentblockextent->minimum;
+				break;
+			}
+
+	BUG_ON(!currentblockextent);
+
+	currentblocksperpage = get_blocks_per_page(currentblockchain);
+
+	suspend_bio_ops.reset_io_stats();
+
+	return 0;
+}
+
+static int swapwriter_write_chunk(struct page * buffer_page)
+{
+	int i;
+	struct submit_params submit_params;
+
+	if (TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
+		return 0;
+		
+	if (currentblockchain == MAX_SWAPFILES) {
+		printk("Error! We have run out of blocks for writing data.\n");
+		return -ENOSPC;
+	}
+	
+	if (!currentblockextent) {
+		do {
+			currentblockchain++;
+		} while ((currentblockchain < MAX_SWAPFILES) &&
+		   (!header_data.block_chain[currentblockchain].first));
+
+		/* We can validly not have a new blockextent. We
+		 * might be compressing data and the user was
+		 * too optimistic in setting the compression
+		 * ratio or we're just copying the pageset. */
+
+		if (currentblockchain == MAX_SWAPFILES) {
+			printk("Argh. Ran out of block chains.\n");
+			return -ENOSPC;
+		}
+				
+		currentblockextent = 
+		 header_data.block_chain[currentblockchain].first;
+		currentblockoffset = currentblockextent->minimum;
+		currentblocksperpage = get_blocks_per_page(currentblockchain);
+	}
+
+	submit_params.readahead_index = -1;
+	submit_params.page = buffer_page;
+	submit_params.dev = swap_info[currentblockchain].bdev;
+		
+	/* Get the blocks */
+	submit_params.block[0] = currentblockoffset;
+	for (i = 0; i < currentblocksperpage; i++)
+		GET_EXTENT_NEXT(currentblockextent, currentblockoffset);
+
+	suspend_bio_ops.submit_io(WRITE, &submit_params, 0);
+
+	check_shift_keys(0, NULL);
+
+	return 0;
+}
+
+static int swapwriter_write_cleanup(void)
+{
+	if (current_stream == 2) {
+		header_data.pd1start_block_extent = currentblockextent;
+		header_data.pd1start_block_offset = currentblockoffset;
+		header_data.pd1start_chain = currentblockchain;
+	}
+	
+	suspend_bio_ops.finish_all_io();
+	
+	suspend_bio_ops.check_io_stats();
+
+	return 0;
+}
+
+static int swapwriter_read_init(int stream_number)
+{
+	current_stream = stream_number;
+
+	if (current_stream == 1) {
+		currentblockextent = header_data.pd1start_block_extent;
+		currentblockoffset = header_data.pd1start_block_offset;
+		currentblockchain = header_data.pd1start_chain;
+	} else {
+		currentblockextent = NULL;
+		currentblockoffset = 0;
+		currentblockchain = 0;
+		for (currentblockchain = 0; currentblockchain < MAX_SWAPFILES;
+			       currentblockchain++)
+			if (header_data.block_chain[currentblockchain].first) {
+				currentblockextent =
+					header_data.block_chain[currentblockchain].first;
+				currentblockoffset = currentblockextent->minimum;
+				break;
+			}
+
+		BUG_ON(!currentblockextent);
+	}
+	
+	currentblocksperpage = get_blocks_per_page(currentblockchain);
+
+	suspend_bio_ops.reset_io_stats();
+
+	readahead_index = readahead_submit_index = -1;
+	readahead_allocs = readahead_frees = 0;
+
+	return 0;
+}
+
+static int swapwriter_begin_read_chunk(struct page * page, 
+		int readahead_index, int sync)
+{
+	int i;
+	struct submit_params submit_params;
+
+	if (currentblockchain == MAX_SWAPFILES) {
+		/* Readahead might ask us to read too many blocks */
+		printk("Currentblockchain == MAX_SWAPFILES. Begin_read_chunk returning -ENODATA.\n");
+		return -ENODATA;
+	}
+
+	if (!currentblockextent) {
+		do {
+			currentblockchain++;
+		} while ((currentblockchain < MAX_SWAPFILES) &&
+			 (!header_data.block_chain[currentblockchain].first));
+
+		/* We can validly not have a new blockextent. We
+		 * might have allocated exactly the right amount
+		 * of swap for the image and be reading the last
+		 * block now.
+		 */
+
+		/* Readahead might ask us to read too many blocks */
+		if (currentblockchain == MAX_SWAPFILES)
+			return -ENODATA;
+
+		currentblockextent =
+		  header_data.block_chain[currentblockchain].first;
+		currentblockoffset = currentblockextent->minimum;
+		currentblocksperpage = get_blocks_per_page(currentblockchain);
+	}
+	
+	submit_params.readahead_index = readahead_index;
+	submit_params.page = page;
+	submit_params.dev = swap_info[currentblockchain].bdev;
+		
+	/* Get the blocks. There is no chance that they span chains. */
+	submit_params.block[0] = currentblockoffset;
+	for (i = 0; i < currentblocksperpage; i++)
+		GET_EXTENT_NEXT(currentblockextent, currentblockoffset);
+
+	if ((i = suspend_bio_ops.submit_io(READ, &submit_params, sync)))
+		return -EPERM;
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
+static int swapwriter_read_chunk(struct page * buffer_page, int sync)
+{
+	static int last_result;
+	unsigned long * virt;
+
+	/* If we only use readahead when reading synchronously. */
+	if (sync == SUSPEND_ASYNC)
+		return swapwriter_begin_read_chunk(buffer_page, -1, sync);
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
+			return -EIO;
+		goto wait;
+	}
+	
+	do {
+		if (suspend_bio_ops.prepare_readahead(readahead_submit_index))
+			break;
+
+		readahead_allocs++;
+
+		last_result = swapwriter_begin_read_chunk(
+			suspend_bio_ops.readahead_pages[readahead_submit_index], 
+			readahead_submit_index, SUSPEND_ASYNC);
+		if (last_result) {
+			suspend_bio_ops.cleanup_readahead(readahead_submit_index);
+			readahead_frees++;
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
+
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
+static int swapwriter_read_cleanup(void)
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
+
+	return 0;
+}
+
+/* swapwriter_invalidate_image
+ * 
+ */
+static int swapwriter_invalidate_image(void)
+{
+	union p_diskpage cur;
+	int result = 0;
+	char newsig[11];
+	
+	cur.address = get_zeroed_page(GFP_ATOMIC);
+	if (!cur.address) {
+		printk("Unable to allocate a page for restoring the swap signature.\n");
+		return -ENOMEM;
+	}
+
+	/*
+	 * If nr_suspends == 0, we must be booting, so no swap pages
+	 * will be recorded as used yet.
+	 */
+
+	if (nr_suspends > 0)
+		swapwriter_release_storage();
+
+	/* 
+	 * We don't do a sanity check here: we want to restore the swap 
+	 * whatever version of kernel made the suspend image.
+	 * 
+	 * We need to write swap, but swap may not be enabled so
+	 * we write the device directly
+	 */
+	
+	suspend_bio_ops.bdev_page_io(READ, resume_block_device,
+			resume_firstblock, virt_to_page(cur.pointer));
+
+	result = parse_signature(cur.pointer->swh.magic.magic, 1);
+		
+	if (result < 4)
+		goto out;
+
+	strncpy(newsig, cur.pointer->swh.magic.magic, 10);
+	newsig[10] = 0;
+
+	suspend_bio_ops.bdev_page_io(WRITE, resume_block_device, resume_firstblock,
+			virt_to_page(cur.pointer));
+
+	if (!nr_suspends)
+		printk(KERN_WARNING name_suspend "Image invalidated.\n");
+out:
+	suspend_bio_ops.finish_all_io();
+	free_pages(cur.address, 0);
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
+static unsigned long swapwriter_memory_needed(void)
+{
+	return 1;
+}
+
+/* Print debug info
+ *
+ * Description:
+ */
+
+static int swapwriter_print_debug_stats(char * buffer, int size)
+{
+	int len = 0;
+	struct sysinfo sysinfo;
+	
+	if (active_writer != &swapwriterops) {
+		len = suspend_snprintf(buffer, size, "- Swapwriter inactive.\n");
+		return len;
+	}
+
+	len = suspend_snprintf(buffer, size, "- Swapwriter active.\n");
+	if (swapfilename[0])
+		len+= suspend_snprintf(buffer+len, size-len,
+			"  Attempting to automatically swapon: %s.\n", swapfilename);
+
+	si_swapinfo(&sysinfo);
+	
+	len+= suspend_snprintf(buffer+len, size-len, "  Swap available for image: %ld pages.\n",
+			sysinfo.freeswap + swapwriter_storage_allocated());
+
+	return len;
+}
+
+/*
+ * Storage needed
+ *
+ * Returns amount of space in the swap header required
+ * for the swapwriter's data. This ignores the links between
+ * pages, which we factor in when allocating the space.
+ *
+ * We ensure the space is allocated, but actually save the
+ * data from write_header_init and therefore don't also define a
+ * save_config_info routine.
+ */
+static unsigned long swapwriter_storage_needed(void)
+{
+	return sizeof(header_data);
+}
+
+/*
+ * Image_exists
+ *
+ */
+
+static int swapwriter_image_exists(void)
+{
+	int signature_found;
+	union p_diskpage diskpage;
+	
+	if (!resume_device) {
+		printk("Not even trying to read header "
+				"because resume_device is not set.\n");
+		return 0;
+	}
+	
+	if (!resume_block_device && !try_to_open_resume_device())
+		return 0;
+
+	diskpage.address = get_zeroed_page(GFP_ATOMIC);
+
+	suspend_bio_ops.bdev_page_io(READ, resume_block_device,
+			resume_firstblock, virt_to_page(diskpage.ptr));
+	suspend_bio_ops.finish_all_io();
+
+	signature_found = parse_signature(diskpage.pointer->swh.magic.magic, 0);
+	free_pages(diskpage.address, 0);
+
+	if (signature_found < 2) {
+		return 0;	/* Normal swap space */
+	} else if (signature_found == -1) {
+		printk(KERN_ERR name_suspend
+			"Unable to find a signature. Could you have moved "
+			"a swap file?\n");
+		return 0;
+	} else if (signature_found < 6) {
+		if ((!(test_suspend_state(SUSPEND_NORESUME_SPECIFIED)))
+				&& suspend_early_boot_message(1,
+				SUSPEND_CONTINUE_REQ,
+				"Detected the signature of an alternate "
+				"implementation.\n"))
+			set_suspend_state(SUSPEND_NORESUME_SPECIFIED);
+		return 0;
+	} else if ((signature_found >> 1) != SIGNATURE_VER) {
+		if ((!(test_suspend_state(SUSPEND_NORESUME_SPECIFIED))) &&
+			suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+			 "Found a different style suspend image signature."))
+			set_suspend_state(SUSPEND_NORESUME_SPECIFIED);
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
+static void swapwriter_mark_resume_attempted(void)
+{
+	union p_diskpage diskpage;
+	int signature_found;
+	
+	if (!resume_device) {
+		printk("Not even trying to record attempt at resuming"
+				" because resume_device is not set.\n");
+		return;
+	}
+	
+	diskpage.address = get_zeroed_page(GFP_ATOMIC);
+
+	/* FIXME: Make sure bdev_page_io handles wrong parameters */
+	suspend_bio_ops.bdev_page_io(READ, resume_block_device, resume_firstblock, virt_to_page(diskpage.ptr));
+	signature_found = parse_signature(diskpage.pointer->swh.magic.magic, 0);
+
+	switch (signature_found) {
+		case 12:
+		case 13:
+			diskpage.pointer->swh.magic.magic[5] |= 0x80;
+			break;
+	}
+	
+	suspend_bio_ops.bdev_page_io(WRITE, resume_block_device, resume_firstblock,
+			virt_to_page(diskpage.ptr));
+	suspend_bio_ops.finish_all_io();
+	free_pages(diskpage.address, 0);
+	
+	cleanup_opened_devices(1);
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
+ * location given. Failure will result in swapwriter refusing to
+ * save an image, and a reboot with correct parameters will be
+ * necessary.
+ */
+
+static int swapwriter_parse_image_location(char * commandline, int only_writer)
+{
+	char *thischar, *devstart = NULL, *colon = NULL, *at_symbol = NULL;
+	union p_diskpage diskpage;
+	int signature_found, result = -EINVAL, temp_result;
+
+	if (strncmp(commandline, "swap:", 5)) {
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
+		resume_firstblock = (int) simple_strtoul(colon + 1, NULL, 0);
+	else
+		resume_firstblock = 0;
+
+	if (at_symbol) {
+		resume_firstblocksize = (int) simple_strtoul(at_symbol + 1, NULL, 0);
+		if (resume_firstblocksize & 0x1FF)
+			printk("Swapwriter: Blocksizes are usually a multiple of 512. Don't expect this to work!\n");
+	} else
+		resume_firstblocksize = 4096;
+	
+	temp_result = try_to_parse_resume_device(devstart);
+
+	if (colon)
+		*colon = ':';
+	if (at_symbol)
+		*at_symbol = '@';
+
+	if (temp_result)
+		return -EINVAL;
+
+	diskpage.address = get_zeroed_page(GFP_ATOMIC);
+	if (!diskpage.address) {
+		printk(KERN_ERR name_suspend "Swapwriter: Failed to allocate a diskpage for I/O.\n");
+		return -ENOMEM;
+	}
+
+	if ((suspend_bio_ops.get_block_size(resume_block_device) 
+				!= resume_firstblocksize) &&
+	     (suspend_bio_ops.set_block_size(resume_block_device, resume_firstblocksize)
+	    			 == -EINVAL)) {
+		printk(KERN_ERR name_suspend "Swapwriter: Failed to set requested block size.\n");
+		goto invalid;
+	}
+
+	temp_result = suspend_bio_ops.bdev_page_io(READ, resume_block_device, resume_firstblock, virt_to_page(diskpage.ptr));
+	suspend_bio_ops.finish_all_io();
+	
+	if (temp_result) {
+		printk(KERN_ERR name_suspend "Swapwriter: Failed to submit I/O.\n");
+		goto invalid;
+	}
+	
+	signature_found = parse_signature(diskpage.pointer->swh.magic.magic, 0);
+
+	if (signature_found != -1) {
+		printk(KERN_ERR name_suspend "Swapwriter: Signature found.\n");
+		result = 0;
+	} else
+		printk(KERN_ERR name_suspend "Swapwriter: No swap signature found at specified location.\n");
+invalid:
+	free_page((unsigned long) diskpage.address);
+	return result;
+
+}
+
+static int header_locations_read_proc(char * page, char ** start, off_t off, int count,
+		int *eof, void *data)
+{
+	int i, printedpartitionsmessage = 0, len = 0, haveswap = 0, device_block_size;
+	struct inode *swapf = 0;
+	int zone;
+	char * path_page = (char *) __get_free_page(GFP_KERNEL);
+	char * path;
+	int path_len;
+	
+	*eof = 1;
+	if (!page)
+		return 0;
+
+	for (i = 0; i < MAX_SWAPFILES; i++) {
+		if (!swap_info[i].swap_file)
+			continue;
+		
+		if (S_ISBLK(swap_info[i].swap_file->f_dentry->d_inode->i_mode)) {
+			haveswap = 1;
+			if (!printedpartitionsmessage) {
+				len += sprintf(page + len, 
+					"For swap partitions, simply use the format: resume2=swap:/dev/hda1.\n");
+				printedpartitionsmessage = 1;
+			}
+		} else {
+			path_len = 0;
+			
+			path = get_path_for_swapfile(i, path_page);
+			path_len = sprintf(path_page, "%-31s ", path);
+			
+			haveswap = 1;
+			swapf = swap_info[i].swap_file->f_dentry->d_inode;
+			device_block_size = block_size(swap_info[i].bdev);
+			if (!(zone = bmap(swapf,0))) {
+				len+= sprintf(page + len, 
+					"Swapfile %-31s has been corrupted. Reuse mkswap on it and try again.\n",
+					path_page);
+			} else {
+				len+= sprintf(page + len, "For swapfile `%s`, use resume2=swap:/dev/<partition name>:0x%x@%d.\n",
+						path_page,
+						zone, device_block_size);
+			}
+
+		}
+	}
+	
+	if (!haveswap)
+		len = sprintf(page, "You need to turn on swap partitions before examining this file.\n");
+
+	free_pages((unsigned long) path_page, 0);
+	return len;
+}
+
+static struct suspend_proc_data swapwriter_proc_data[] = {
+	{
+	 .filename			= "swapfilename",
+	 .permissions			= PROC_RW,
+	 .type				= SUSPEND_PROC_DATA_STRING,
+	 .data = {
+		.string = {
+			.variable	= swapfilename,
+			.max_length	= 255,
+		}
+	 }
+	},
+
+	{
+	 .filename			= "headerlocations",
+	 .permissions			= PROC_READONLY,
+	 .type				= SUSPEND_PROC_DATA_CUSTOM,
+	 .data = {
+		 .special = {
+			.read_proc 	= header_locations_read_proc,
+		}
+	 }
+	},
+
+	{ .filename			= "disable_swapwriter",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		.integer = {
+			.variable	= &swapwriterops.disabled,
+			.minimum	= 0,
+			.maximum	= 1,
+		}
+	  },
+	  .write_proc			= attempt_to_parse_resume_device,
+	}
+};
+
+static struct suspend_plugin_ops swapwriterops = {
+	.type					= WRITER_PLUGIN,
+	.name					= "Swap Writer",
+	.module					= THIS_MODULE,
+	.memory_needed				= swapwriter_memory_needed,
+	.print_debug_info			= swapwriter_print_debug_stats,
+	.storage_needed				= swapwriter_storage_needed,
+	.initialise				= swapwriter_initialise,
+	.cleanup				= swapwriter_cleanup,
+
+	.write_init				= swapwriter_write_init,
+	.write_cleanup				= swapwriter_write_cleanup,
+	.read_init				= swapwriter_read_init,
+	.read_cleanup				= swapwriter_read_cleanup,
+
+	.ops = {
+		.writer = {
+		 .write_chunk		= swapwriter_write_chunk,
+		 .read_chunk		= swapwriter_read_chunk,
+		 .noresume_reset	= swapwriter_noresume_reset,
+		 .storage_available 	= swapwriter_storage_available,
+		 .storage_allocated	= swapwriter_storage_allocated,
+		 .release_storage	= swapwriter_release_storage,
+		 .allocate_header_space	= swapwriter_allocate_header_space,
+		 .allocate_storage	= swapwriter_allocate_storage,
+		 .image_exists		= swapwriter_image_exists,
+		 .mark_resume_attempted	= swapwriter_mark_resume_attempted,
+		 .write_header_init	= swapwriter_write_header_init,
+		 .write_header_chunk	= swapwriter_write_header_chunk,
+		 .write_header_cleanup	= swapwriter_write_header_cleanup,
+		 .read_header_init	= swapwriter_read_header_init,
+		 .read_header_chunk	= swapwriter_read_header_chunk,
+		 .read_header_cleanup	= swapwriter_read_header_cleanup,
+		 .serialise_extents	= swapwriter_serialise_extents,
+		 .load_extents		= swapwriter_load_extents,
+		 .invalidate_image	= swapwriter_invalidate_image,
+		 .parse_image_location	= swapwriter_parse_image_location,
+		}
+	}
+};
+
+/* ---- Registration ---- */
+static __init int swapwriter_load(void)
+{
+	int result;
+	int i, numfiles = sizeof(swapwriter_proc_data) / sizeof(struct suspend_proc_data);
+	
+	printk("Software Suspend Swap Writer loading.\n");
+	if (!(result = suspend_register_plugin(&swapwriterops))) {
+
+		for (i=0; i< numfiles; i++)
+			suspend_register_procfile(&swapwriter_proc_data[i]);
+	} else
+		printk("Software Suspend Swap Writer unable to register!\n");
+	return result;
+}
+
+#ifdef MODULE
+static __exit void swapwriter_unload(void)
+{
+	int i, numfiles = sizeof(swapwriter_proc_data) / sizeof(struct suspend_proc_data);
+
+	printk("Software Suspend Swap Writer unloading.\n");
+
+	for (i=0; i< numfiles; i++)
+		suspend_unregister_procfile(&swapwriter_proc_data[i]);
+	suspend_unregister_plugin(&swapwriterops);
+}
+
+module_init(swapwriter_load);
+module_exit(swapwriter_unload);
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Nigel Cunningham");
+MODULE_DESCRIPTION("Suspend2 swap writer");
+#else
+late_initcall(swapwriter_load);
+#endif

