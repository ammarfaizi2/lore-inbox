Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262647AbUKXNQZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262647AbUKXNQZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 08:16:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262685AbUKXNOl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 08:14:41 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:5525 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262647AbUKXND4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:03:56 -0500
Subject: Suspend 2 merge: 34/51: Includes
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101297843.5805.324.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:00:06 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

These are the include changes files for suspend2.

I seek to keep this swsusp compatible, but it might be a little out of sync with Pavel's changes.

diff -ruN 822-includes-old/include/asm-i386/suspend.h 822-includes-new/include/asm-i386/suspend.h
--- 822-includes-old/include/asm-i386/suspend.h	2004-11-24 09:53:09.000000000 +1100
+++ 822-includes-new/include/asm-i386/suspend.h	2004-11-24 18:51:50.270377720 +1100
@@ -3,6 +3,7 @@
  * Based on code
  * Copyright 2001 Patrick Mochel <mochel@osdl.org>
  */
+#include <linux/errno.h>
 #include <asm/desc.h>
 #include <asm/i387.h>
 
diff -ruN 822-includes-old/include/linux/suspend.h 822-includes-new/include/linux/suspend.h
--- 822-includes-old/include/linux/suspend.h	2004-11-03 21:52:41.000000000 +1100
+++ 822-includes-new/include/linux/suspend.h	2004-11-24 18:51:50.298373464 +1100
@@ -4,58 +4,125 @@
 #ifdef CONFIG_X86
 #include <asm/suspend.h>
 #endif
-#include <linux/swap.h>
-#include <linux/notifier.h>
-#include <linux/config.h>
-#include <linux/init.h>
-#include <linux/pm.h>
-
-#ifdef CONFIG_PM
-/* page backup entry */
-typedef struct pbe {
-	unsigned long address;		/* address of the copy */
-	unsigned long orig_address;	/* original address of page */
-	swp_entry_t swap_address;	
-	swp_entry_t dummy;		/* we need scratch space at 
-					 * end of page (see link, diskpage)
-					 */
-} suspend_pagedir_t;
-
-#define SWAP_FILENAME_MAXLENGTH	32
-
-
-#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
-   
-/* mm/vmscan.c */
-extern int shrink_mem(void);
-
-/* mm/page_alloc.c */
-extern void drain_local_pages(void);
 
-/* kernel/power/swsusp.c */
-extern int software_suspend(void);
+#include <linux/kernel.h>
+extern char __nosave_begin, __nosave_end;
 
-#else	/* CONFIG_SOFTWARE_SUSPEND */
-static inline int software_suspend(void)
-{
-	printk("Warning: fake suspend called\n");
-	return -EPERM;
-}
-#endif	/* CONFIG_SOFTWARE_SUSPEND */
+#ifdef CONFIG_PM
 
+#include <linux/init.h>
 
-#ifdef CONFIG_PM
-extern void refrigerator(unsigned long);
-extern int freeze_processes(void);
-extern void thaw_processes(void);
+/* For swsusp */
+#include <linux/swap.h>
 
-extern int pm_prepare_console(void);
-extern void pm_restore_console(void);
+#define SUSPEND_CORE_VERSION "2.1.5.7"
+#ifndef KERNEL_POWER_SWSUSP_C
+#define name_suspend "Software Suspend " SUSPEND_CORE_VERSION ": "
+#endif
 
+extern unsigned long suspend_action;
+extern unsigned long suspend_result;
+extern unsigned long suspend_debug_state;
+
+#define TEST_RESULT_STATE(bit) (test_bit(bit, &suspend_result))
+#define SET_RESULT_STATE(bit) (test_and_set_bit(bit, &suspend_result))
+#define CLEAR_RESULT_STATE(bit) (test_and_clear_bit(bit, &suspend_result))
+
+#define TEST_ACTION_STATE(bit) (test_bit(bit, &suspend_action))
+#define SET_ACTION_STATE(bit) (test_and_set_bit(bit, &suspend_action))
+#define CLEAR_ACTION_STATE(bit) (test_and_clear_bit(bit, &suspend_action))
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+#define TEST_DEBUG_STATE(bit) (test_bit(bit, &suspend_debug_state))
+#define SET_DEBUG_STATE(bit) (test_and_set_bit(bit, &suspend_debug_state))
+#define CLEAR_DEBUG_STATE(bit) (test_and_clear_bit(bit, &suspend_debug_state))
 #else
-static inline void refrigerator(unsigned long flag) {}
-#endif	/* CONFIG_PM */
+#define TEST_DEBUG_STATE(bit) (0)
+#define SET_DEBUG_STATE(bit) (0)
+#define CLEAR_DEBUG_STATE(bit) (0)
+#endif
 
+/* first status register - this is suspend's return code. */
+#define SUSPEND_ABORTED			0
+#define SUSPEND_ABORT_REQUESTED		1
+#define SUSPEND_NOSTORAGE_AVAILABLE	2
+#define SUSPEND_INSUFFICIENT_STORAGE	3
+#define SUSPEND_FREEZING_FAILED		4
+#define SUSPEND_UNEXPECTED_ALLOC	5
+#define SUSPEND_KEPT_IMAGE		6
+#define SUSPEND_WOULD_EAT_MEMORY	7
+#define SUSPEND_UNABLE_TO_FREE_ENOUGH_MEMORY 8
+
+/* second status register */
+#define SUSPEND_REBOOT		0
+#define SUSPEND_PAUSE		2
+#define SUSPEND_SLOW		3
+#define SUSPEND_NOPAGESET2	7
+#define SUSPEND_LOGALL		8
+/* Set to disable compression when compiled in */
+#define SUSPEND_NO_COMPRESSION	9
+//#define SUSPEND_ENABLE_KDB	10
+#define SUSPEND_CAN_CANCEL	11
+#define SUSPEND_KEEP_IMAGE	13
+#define SUSPEND_FREEZER_TEST	14
+#define SUSPEND_FREEZER_TEST_SHOWALL 15
+#define SUSPEND_SINGLESTEP	16
+#define SUSPEND_PAUSE_NEAR_PAGESET_END 17
+#define SUSPEND_USE_ACPI_S4	18
+#define SUSPEND_KEEP_METADATA	19
+#define SUSPEND_TEST_FILTER_SPEED	20
+#define SUSPEND_FREEZE_TIMERS	21
+#define SUSPEND_DISABLE_SYSDEV_SUPPORT 22
+
+/* debug sections  - if debugging compiled in */
+#define SUSPEND_ANY_SECTION	0
+#define SUSPEND_FREEZER		1
+#define SUSPEND_EAT_MEMORY 	2
+#define SUSPEND_PAGESETS	3
+#define SUSPEND_IO		4
+#define SUSPEND_BMAP		5
+#define SUSPEND_HEADER		6
+#define SUSPEND_WRITER		9
+#define SUSPEND_MEMORY		10
+#define SUSPEND_RANGES		11
+#define SUSPEND_SPINLOCKS	12
+#define SUSPEND_MEM_POOL	13
+#define SUSPEND_RANGE_PARANOIA	14
+#define SUSPEND_NOSAVE		15
+#define SUSPEND_INTEGRITY	16
+/* debugging levels. */
+#define SUSPEND_STATUS		0
+#define SUSPEND_ERROR		2
+#define SUSPEND_LOW	 	3
+#define SUSPEND_MEDIUM	 	4
+#define SUSPEND_HIGH	  	5
+#define SUSPEND_VERBOSE		6
+
+extern void __suspend_message(unsigned long section, unsigned long level, int log_normally,
+		const char *fmt, ...);
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+extern int suspend_memory_pool_level(int only_lowmem);
+extern int real_nr_free_pages(void);
+#define suspend_message(sn, lev, log, fmt, a...) \
+do { \
+	if (TEST_DEBUG_STATE(sn)) \
+		suspend2_core_ops->suspend_message(sn, lev, log, fmt, ##a); \
+} while(0)
+#define PRINTFREEMEM(desn) \
+	suspend_message(SUSPEND_MEMORY, SUSPEND_HIGH, 1, \
+		"Free memory %s: %d+%d.\n", desn, \
+		real_nr_free_pages() + suspend_amount_grabbed, \
+		suspend_memory_pool_level(0));
+#else /* CONFIG_SOFTWARE_SUSPEND_DEBUG */
+#define PRINTFREEMEM(desn) do { } while(0)
+#define suspend_message(sn, lev, log, fmt, a...) \
+do { \
+	if (lev == 0) \
+		suspend2_core_ops->suspend_message(sn, lev, log, fmt, ##a); \
+} while(0)
+#endif /* CONFIG_SOFTWARE_SUSPEND_DEBUG */
+  
 #ifdef CONFIG_SMP
 extern void disable_nonboot_cpus(void);
 extern void enable_nonboot_cpus(void);
@@ -64,10 +131,140 @@
 static inline void enable_nonboot_cpus(void) {}
 #endif
 
-void save_processor_state(void);
-void restore_processor_state(void);
-struct saved_context;
-void __save_processor_state(struct saved_context *ctxt);
-void __restore_processor_state(struct saved_context *ctxt);
+extern int software_suspend(void);
+	
+/* Suspend 2 */
+
+#define SUSPEND_DISABLED		0
+#define SUSPEND_RUNNING			1
+#define SUSPEND_RESUME_DEVICE_OK	2
+#define SUSPEND_NORESUME_SPECIFIED	3
+#define SUSPEND_COMMANDLINE_ERROR 	4
+#define SUSPEND_IGNORE_IMAGE		5
+#define SUSPEND_SANITY_CHECK_PROMPT	6
+#define SUSPEND_FREEZER_ON		7
+#define SUSPEND_DISABLE_SYNCING		8
+#define SUSPEND_BLOCK_PAGE_ALLOCATIONS	9
+#define SUSPEND_USE_MEMORY_POOL		10
+#define SUSPEND_STAGE2_CONTINUE		11
+#define SUSPEND_FREEZE_SMP		12
+#define SUSPEND_PAGESET2_NOT_LOADED	13
+#define SUSPEND_CONTINUE_REQ		14
+#define SUSPEND_RESUMED_BEFORE		15
+#define SUSPEND_RUNNING_INITRD		16
+#define SUSPEND_RESUME_NOT_DONE		17
+#define SUSPEND_BOOT_TIME		18
+#define SUSPEND_NOW_RESUMING		19
+#define SUSPEND_SLAB_ALLOC_FALLBACK	20
+#define SUSPEND_IGNORE_LOGLEVEL		21
+#define SUSPEND_TIMER_FREEZER_ON	22
+
+extern unsigned long software_suspend_state;
+#define test_suspend_state(bit) \
+	(test_bit(bit, &software_suspend_state))
+
+#define clear_suspend_state(bit) \
+	(clear_bit(bit, &software_suspend_state))
+
+#define set_suspend_state(bit) \
+	(set_bit(bit, &software_suspend_state))
+
+#define get_suspend_state() 		(software_suspend_state)
+#define restore_suspend_state(saved_state) \
+	do { software_suspend_state = saved_state; } while(0)
+	
+/* kernel/suspend.c */
+extern void suspend_try_suspend(void);
+extern unsigned int suspend_task;
+
+/* Kernel threads are type 3 */
+#define FREEZER_ALL_THREADS 0
+#define FREEZER_KERNEL_THREADS 3
+
+extern int freeze_processes(int no_progress);
+extern void thaw_processes(int which_threads);
+
+extern int pm_prepare_console(void);
+extern void pm_restore_console(void);
+
+#define SUSPEND_KEY_KEYBOARD 1
+#define SUSPEND_KEY_SERIAL 2
+
+struct page;
+
+struct suspend2_core_ops {
+	/* Entry points for suspending & resuming */
+	void (* do_suspend) (void);
+	int (* do_resume) (void);
+
+	/* Pre and post lowlevel routines */
+	void (* suspend1) (void);
+	void (* suspend2) (void);
+	void (* resume1) (void);
+	void (* resume2) (void);
+	
+	void (* free_pool_pages) (struct page *page, unsigned int order);
+	struct page * (* get_pool_pages) (unsigned int gfp_mask, unsigned int order);
+
+	unsigned long (* get_grabbed_pages) (int order);
+	void (* cleanup_finished_io) (void);
+
+	void (* suspend_message) (unsigned long, unsigned long, int, const char *, ...);
+	unsigned long (* update_status) (unsigned long value, unsigned long maximum,
+		const char *fmt, ...);
+	void (*prepare_status) (int printalways, int clearbar, const char *fmt, ...);
+	void (* schedule_message) (int message_number);
+	void (* early_boot_plugins) (void);
+	int (* keypress) (unsigned int keycode);
+
+	void (* verify_checksums) (void);
+};
+extern volatile struct suspend2_core_ops * suspend2_core_ops;
+#ifdef CONFIG_SOFTWARE_SUSPEND2
+extern void software_suspend_try_resume(void);
+extern void suspend_handle_keypress(unsigned int keycode, int source);
+#else
+#define software_suspend_try_resume()	do { } while(0)
+#define suspend_handle_keypress(a, b) do { } while(0)
+#endif
+
+#define suspend2_free_pool_pages(page, order)	suspend2_core_ops->free_pool_pages(page, order)
+#define suspend2_get_pool_pages(mask, order)	suspend2_core_ops->get_pool_pages(mask, order)
+#define suspend2_get_grabbed_pages(order)	suspend2_core_ops->get_grabbed_pages(order)
+#define suspend2_cleanup_finished_io()		suspend2_core_ops->cleanup_finished_io()
+#define suspend2_verify_checksums()		suspend2_core_ops->verify_checksums()
+
+#else /* CONFIG_PM off */
+
+#define suspend_try_suspend()		do { } while(0)
+#define suspend_task			(0)
+#define software_suspend_state		(0)
+#define test_suspend_state(bit) 	(0)
+#define clear_suspend_state(bit)	do { } while (0)
+#define set_suspend_state(bit)		do { } while(0)
+#define get_suspend_state() 		(0)
+#define restore_suspend_state(saved_state) do { } while(0)
+#define software_suspend_try_resume()	do { } while(0)
+
+static inline int suspend_bug(void)
+{
+	BUG();
+	return 0;
+}
+
+#define suspend2_free_pool_pages(page, order) suspend_bug()
+#define suspend2_get_pool_pages(mask, order) (struct page *) suspend_bug()
+#define suspend2_get_grabbed_pages(order) (struct page *) suspend_bug()
+#define suspend2_cleanup_finished_io()	do { BUG(); } while(0)
+#define suspend2_verify_checksums() do { BUG(); } while(0)
+
+static inline int software_suspend(void)
+{
+	printk("Warning: fake suspend called\n");
+	return -EPERM;
+}
+#define software_resume()		do { } while(0)
+#define suspend_handle_keypress(a, b) do { } while(0)
+#endif
 
 #endif /* _LINUX_SWSUSP_H */
diff -ruN 822-includes-old/kernel/power/block_io.h 822-includes-new/kernel/power/block_io.h
--- 822-includes-old/kernel/power/block_io.h	1970-01-01 10:00:00.000000000 +1000
+++ 822-includes-new/kernel/power/block_io.h	2004-11-24 18:51:50.301373008 +1100
@@ -0,0 +1,52 @@
+/*
+ * block_io.h
+ *
+ * Copyright 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * Distributed under GPLv2.
+ *
+ * This file contains declarations for functions exported from
+ * block_io.c, which contains low level io functions.
+ */
+
+/* 8192 4k pages = 32MB */
+#define MAX_READAHEAD (int) (8192)
+
+/* Forward Declarations */
+
+struct submit_params {
+	swp_entry_t swap_address;
+	struct page * page;
+	struct block_device * dev;
+	long blocks[PAGE_SIZE/512];
+	int blocks_used;
+	int readahead_index;
+	struct submit_params * next;
+};
+
+
+extern int max_async_ios;
+#define REAL_MAX_ASYNC ((max_async_ios ? max_async_ios : 128))
+
+/* 
+ * Our exported interface so the swapwriter and NFS writer don't
+ * need these functions built in.
+ */
+struct suspend_bio_ops {
+	int (*set_block_size) (struct block_device * bdev, int size);
+	int (*get_block_size) (struct block_device * bdev);
+	int (*submit_io) (int rw, 
+		struct submit_params * submit_info, int syncio);
+	int (*bdev_page_io) (int rw, struct block_device * bdev, long pos,
+			struct page * page);
+	void (*wait_on_readahead) (int readahead_index);
+	void (*check_io_stats) (void);
+	void (*reset_io_stats) (void);
+	void (*finish_all_io) (void);
+	int (*prepare_readahead) (int index);
+	void (*cleanup_readahead) (int index);
+	struct page ** readahead_pages;
+	int (*readahead_ready) (int readahead_index);
+};
+
+extern struct suspend_bio_ops suspend_bio_ops;
diff -ruN 822-includes-old/kernel/power/pageflags.h 822-includes-new/kernel/power/pageflags.h
--- 822-includes-old/kernel/power/pageflags.h	1970-01-01 10:00:00.000000000 +1000
+++ 822-includes-new/kernel/power/pageflags.h	2004-11-24 18:51:50.304372552 +1100
@@ -0,0 +1,80 @@
+/*
+ * kernel/power/pageflags.h
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * Suspend2 needs a few pageflags while working that aren't otherwise
+ * used. To save the struct page pageflags, we dynamically allocate
+ * a bitmap and use that. These are the only non order-0 allocations
+ * we do.
+ */
+extern unsigned long * in_use_map;
+extern unsigned long * pageset2_map;
+extern unsigned long * checksum_map;
+#ifdef CONFIG_DEBUG_PAGEALLOC
+extern unsigned long * unmap_map;
+#endif
+
+#define PAGENUMBER(page) (page-mem_map)
+#define PAGEINDEX(page) ((PAGENUMBER(page))/(8*sizeof(unsigned long)))
+#define PAGEBIT(page) ((int) ((PAGENUMBER(page))%(8 * sizeof(unsigned long))))
+
+/* 
+ * freepagesmap is used in two ways: 
+ * - During suspend, to tag pages which are not used (to speed up 
+ *   count_data_pages);
+ * - During resume, to tag pages which are in pagedir1. This does not tag 
+ *   pagedir2 pages, so !== first use.
+ */
+#define PageInUse(page) \
+	test_bit(PAGEBIT(page), &in_use_map[PAGEINDEX(page)])
+#define SetPageInUse(page) \
+	set_bit(PAGEBIT(page), &in_use_map[PAGEINDEX(page)])
+#define ClearPageInUse(page) \
+	clear_bit(PAGEBIT(page), &in_use_map[PAGEINDEX(page)])
+
+#define PagePageset2(page) \
+	(pageset2_map ? \
+		test_bit(PAGEBIT(page), &pageset2_map[PAGEINDEX(page)]) : \
+		0)
+			
+#define SetPagePageset2(page) \
+	set_bit(PAGEBIT(page), &pageset2_map[PAGEINDEX(page)])
+#define TestAndSetPagePageset2(page) \
+	test_and_set_bit(PAGEBIT(page), &pageset2_map[PAGEINDEX(page)])
+#define TestAndClearPagePageset2(page) \
+	test_and_clear_bit(PAGEBIT(page), &pageset2_map[PAGEINDEX(page)])
+#define ClearPagePageset2(page)	\
+do { \
+	if (pageset2_map) \
+		clear_bit(PAGEBIT(page), &pageset2_map[PAGEINDEX(page)]); \
+} while(0)
+
+#define PageChecksumIgnore(page) \
+	(checksum_map ? \
+		test_bit(PAGEBIT(page), &checksum_map[PAGEINDEX(page)]) : \
+		0)
+
+#define SetPageChecksumIgnore(page) \
+do { \
+	if (checksum_map) \
+		set_bit(PAGEBIT(page), &checksum_map[PAGEINDEX(page)]); \
+} while(0)
+
+#define ClearPageChecksumIgnore(page) \
+do { \
+	if (checksum_map) \
+		clear_bit(PAGEBIT(page), &checksum_map[PAGEINDEX(page)]); \
+} while(0)
+
+
+#define SetPageUnmap(page) \
+	set_bit(PAGEBIT(page), &unmap_map[PAGEINDEX(page)])
+#define PageUnmap(page) \
+	test_bit(PAGEBIT(page), &unmap_map[PAGEINDEX(page)])
+
+extern int allocate_local_pageflags(unsigned long ** pagemap, int setnosave);
+extern int free_local_pageflags(unsigned long ** pagemap);
+extern void clear_map(unsigned long * pagemap);
diff -ruN 822-includes-old/kernel/power/plugins.h 822-includes-new/kernel/power/plugins.h
--- 822-includes-old/kernel/power/plugins.h	1970-01-01 10:00:00.000000000 +1000
+++ 822-includes-new/kernel/power/plugins.h	2004-11-24 18:51:50.305372400 +1100
@@ -0,0 +1,205 @@
+/*
+ * kernel/power/plugin.h
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations for plugins. Plugins are additions to
+ * suspend2 that provide facilities such as image compression or
+ * encryption, backends for storage of the image and user interfaces.
+ *
+ */
+
+/* This is the maximum size we store in the image header for a plugin name */
+#define SUSPEND_MAX_PLUGIN_NAME_LENGTH 30
+
+struct plugin_header {
+	char name[SUSPEND_MAX_PLUGIN_NAME_LENGTH];
+	int disabled;
+	int type;
+	int index;
+	int data_length;
+	unsigned long magic;
+};
+
+extern unsigned long memory_for_plugins(void);
+extern int num_plugins;
+
+#define FILTER_PLUGIN 1
+#define WRITER_PLUGIN 2
+#define UI_PLUGIN 3
+#define MISC_PLUGIN 4 // Block writer, eg.
+#define CHECKSUM_PLUGIN 5
+
+#define SUSPEND_ASYNC 0
+#define SUSPEND_SYNC  1
+
+#define SUSPEND_COMMON_IO_OPS \
+	/* Writing the image proper */ \
+	int (*write_init) (int stream_number); \
+	int (*write_chunk) (struct page * buffer_page); \
+	int (*write_cleanup) (void); \
+\
+	/* Reading the image proper */ \
+	int (*read_init) (int stream_number); \
+	int (*read_chunk) (struct page * buffer_page, int sync); \
+	int (*read_cleanup) (void); \
+\
+	/* Reset plugin if image exists but reading aborted */ \
+	void (*noresume_reset) (void);
+
+struct suspend_filter_ops {
+	SUSPEND_COMMON_IO_OPS
+	int (*expected_compression) (void);
+	struct list_head filter_list;
+};
+
+struct suspend_writer_ops {
+	
+	SUSPEND_COMMON_IO_OPS
+
+	/* Calls for allocating storage */
+
+	long (*storage_available) (void); // Maximum size of image we can save
+					  // (incl. space already allocated).
+	
+	unsigned long (*storage_allocated) (void);
+					// Amount of storage already allocated
+	int (*release_storage) (void);
+	
+	/* 
+	 * Header space is allocated separately. Note that allocation
+	 * of space for the header might result in allocated space 
+	 * being stolen from the main pool if there is no unallocated
+	 * space. We have to be able to allocate enough space for
+	 * the header. We can eat memory to ensure there is enough
+	 * for the main pool.
+	 */
+	long (*allocate_header_space) (unsigned long space_requested);
+	int (*allocate_storage) (unsigned long space_requested);
+	
+	/* Read and write the metadata */	
+	int (*write_header_init) (void);
+	int (*write_header_chunk) (char * buffer_start, int buffer_size);
+	int (*write_header_cleanup) (void);
+
+	int (*read_header_init) (void);
+	int (*read_header_chunk) (char * buffer_start, int buffer_size);
+	int (*read_header_cleanup) (void);
+
+	/* Prepare metadata to be saved (relativise/absolutise ranges) */
+	int (*prepare_save_ranges) (void);
+	int (*post_load_ranges) (void);
+	
+	/* Attempt to parse an image location */
+	int (*parse_image_location) (char * buffer, int only_writer);
+
+	/* Determine whether image exists that we can restore */
+	int (*image_exists) (void);
+	
+	/* Mark the image as having tried to resume */
+	void (*mark_resume_attempted) (void);
+
+	/* Destroy image if one exists */
+	int (*invalidate_image) (void);
+	
+	/* Wait on I/O */
+	int (*wait_on_io) (int flush_all);
+
+	struct list_head writer_list;
+};
+
+struct suspend_ui_ops {
+	void (*early_boot_message_prep) (void);
+	void (*prepare) (void);
+	void (*message) (
+		unsigned long type, unsigned long level,
+		int normally_logged,
+		const char *format, va_list args);
+	void (*log_level_change) (void);
+	unsigned long (*update_progress) (
+		unsigned long value, unsigned long maximum,
+		const char *fmt, va_list args);
+	void (*cleanup) (void);
+	int (*keypress) (unsigned int key);
+	void (*post_kernel_restore_redraw) (void);
+
+	struct list_head ui_list;
+};
+
+struct suspend_checksum_ops {
+	void (*calculate_checksums) (void);
+	void (*check_checksums) (void);
+	void (*print_differences) (void);
+	int (*allocate_pages) (void);
+};
+
+struct suspend_plugin_ops {
+	/* Functions common to all plugins */
+	int type;
+	char * name;
+	int disabled;
+	struct list_head plugin_list;
+	unsigned long (*memory_needed) (void);
+	unsigned long (*storage_needed) (void);
+	int (*print_debug_info) (char * buffer, int size);
+	int (*save_config_info) (char * buffer);
+	void (*load_config_info) (char * buffer, int len);
+	
+	/* Initialise & cleanup - general routines called
+	 * at the start and end of a cycle. */
+	int (*initialise) (void);
+	void (*cleanup) (void);
+
+	/* Set list of devices not to be suspended/resumed */
+	void (*dpm_set_devices) (void);
+
+	union {
+		struct suspend_filter_ops filter;
+		struct suspend_writer_ops writer;
+		struct suspend_ui_ops ui;
+		struct suspend_checksum_ops checksum;
+	} ops;
+};
+
+extern struct suspend_plugin_ops * active_writer;
+extern struct list_head suspend_filters, suspend_writers, suspend_plugins, suspend_ui;
+extern struct suspend_plugin_ops * checksum_plugin;
+extern void prepare_console_plugins(void);
+extern void cleanup_console_plugins(void);
+extern struct suspend_plugin_ops * find_plugin_given_name(char * name);
+extern struct suspend_plugin_ops * get_next_filter(struct suspend_plugin_ops *);
+extern int suspend_register_plugin(struct suspend_plugin_ops * plugin);
+extern void suspend_move_plugin_tail(struct suspend_plugin_ops * plugin);
+
+extern int initialise_suspend_plugins(void);
+extern void cleanup_suspend_plugins(void);
+extern unsigned long header_storage_for_plugins(void);
+extern unsigned long memory_for_plugins(void);
+extern int print_plugin_debug_info(char * buffer, int buffer_size);
+extern int suspend_register_plugin(struct suspend_plugin_ops * plugin);
+extern void suspend_unregister_plugin(struct suspend_plugin_ops * plugin);
+extern int initialise_suspend_plugins(void);
+extern void cleanup_suspend_plugins(void);
+extern void suspend_post_restore_redraw(void);
+
+static inline void suspend_checksum_calculate_checksums(void)
+{
+	if (checksum_plugin)
+		checksum_plugin->ops.checksum.calculate_checksums();
+}
+
+static inline void suspend_checksum_print_differences(void)
+{
+	if (checksum_plugin)
+		checksum_plugin->ops.checksum.print_differences();
+}
+
+static inline int suspend_allocate_checksum_pages(void)
+{
+	if (checksum_plugin)
+		return checksum_plugin->ops.checksum.allocate_pages();
+	else
+		return 0;
+}
diff -ruN 822-includes-old/kernel/power/power.h 822-includes-new/kernel/power/power.h
--- 822-includes-old/kernel/power/power.h	2004-11-24 18:52:16.759350784 +1100
+++ 822-includes-new/kernel/power/power.h	2004-11-24 18:51:50.306372248 +1100
@@ -1,6 +1,8 @@
 #include <linux/suspend.h>
 #include <linux/utsname.h>
 
+#include "suspend.h"
+
 /* With SUSPEND_CONSOLE defined, it suspend looks *really* cool, but
    we probably do not take enough locks for switching consoles, etc,
    so bad things might happen.
diff -ruN 822-includes-old/kernel/power/proc.h 822-includes-new/kernel/power/proc.h
--- 822-includes-old/kernel/power/proc.h	1970-01-01 10:00:00.000000000 +1000
+++ 822-includes-new/kernel/power/proc.h	2004-11-24 18:51:50.307372096 +1100
@@ -0,0 +1,64 @@
+/*
+ * kernel/power/proc.h
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It provides declarations for suspend to use in managing
+ * /proc/software_suspend. When we switch to kobjects,
+ * this will become redundant.
+ *
+ */
+
+struct suspend_proc_data {
+	char * filename;
+	int permissions;
+	int type;
+	union {
+		struct {
+			unsigned long * bit_vector;
+			int bit;
+		} bit;
+		struct {
+			int * variable;
+			int minimum;
+			int maximum;
+		} integer;
+		struct {
+			unsigned long * variable;
+			unsigned long minimum;
+			unsigned long maximum;
+		} ul;
+		struct {
+			char * variable;
+			int max_length;
+		} string;
+		struct {
+			void * read_proc;
+			void * write_proc;
+			void * data;
+		} special;
+	} data;
+	
+	/* Side effects routines. Used, eg, for reparsing the
+	 * resume2 entry when it changes */
+	int (* read_proc) (void);
+	int (* write_proc) (void); 
+	struct list_head proc_data_list;
+};
+
+#define SUSPEND_PROC_DATA_CUSTOM	0
+#define SUSPEND_PROC_DATA_BIT		1
+#define SUSPEND_PROC_DATA_INTEGER	2
+#define SUSPEND_PROC_DATA_UL		3
+#define SUSPEND_PROC_DATA_STRING	4
+
+#define PROC_WRITEONLY 0200
+#define PROC_READONLY 0400
+#define PROC_RW 0600
+
+struct proc_dir_entry * suspend_register_procfile(
+		struct suspend_proc_data * suspend_proc_data);
+void suspend_unregister_procfile(struct suspend_proc_data * suspend_proc_data);
+
diff -ruN 822-includes-old/kernel/power/range.h 822-includes-new/kernel/power/range.h
--- 822-includes-old/kernel/power/range.h	1970-01-01 10:00:00.000000000 +1000
+++ 822-includes-new/kernel/power/range.h	2004-11-24 18:51:50.308371944 +1100
@@ -0,0 +1,105 @@
+/*
+ * kernel/power/range.h
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations related to ranges. Ranges (otherwise
+ * known as an extent, I'm told), is suspend's method of storing
+ * all of the metadata for the image. See range.c for more info.
+ *
+ */
+
+struct rangechain {
+	struct range * first;
+	struct range * last;
+	int size; /* size of the range ie sum (max-min+1) */
+	int allocs;
+	int frees;
+	int debug;
+	int timesusedoptimisation;
+	char * name;
+	struct range * lastaccessed, *prevtolastaccessed, *prevtoprev;
+};
+
+/*
+ * We rely on ranges not fitting evenly into a page.
+ * The last four bytes are used to store the number
+ * of the page, to make saving & reloading pages simpler.
+ */
+struct range {
+	unsigned long minimum;
+	unsigned long maximum;
+	struct range * next;
+};
+
+
+#define RANGES_PER_PAGE (PAGE_SIZE / (sizeof(struct range)))
+#define RANGEPAGELINK(x) ((unsigned long *) \
+		((((unsigned long) x) & PAGE_MASK) + PAGE_SIZE - \
+		 sizeof(unsigned long)))
+
+#define range_for_each(rangechain, rangepointer, value) \
+if ((rangechain)->first) \
+	for ((rangepointer) = (rangechain)->first, (value) = \
+			(rangepointer)->minimum; \
+	     ((rangepointer) && ((rangepointer)->next || (value) <= \
+				 (rangepointer)->maximum)); \
+	     (((value) == (rangepointer)->maximum) ? \
+		((rangepointer) = (rangepointer)->next, (value) = \
+		 ((rangepointer) ? (rangepointer)->minimum : 0)) : \
+			(value)++))
+
+/*
+ * When using compression and expected_compression > 0,
+ * we allocate fewer swap entries, so GET_RANGE_NEXT can
+ * validly run out of data to return.
+ */
+#define GET_RANGE_NEXT(currentrange, currentval) \
+{ \
+	if (currentrange) { \
+		if ((currentval) == (currentrange)->maximum) { \
+			if ((currentrange)->next) { \
+				(currentrange) = (currentrange)->next; \
+				(currentval) = (currentrange)->minimum; \
+			} else { \
+				(currentrange) = NULL; \
+				(currentval) = 0; \
+			} \
+		} else \
+			currentval++; \
+	} \
+}
+
+extern int max_ranges_used;
+extern int num_range_pages;
+int add_to_range_chain(struct rangechain * chain, unsigned long value);
+void put_range_chain(struct rangechain * chain);
+void print_chain(int debuglevel, struct rangechain * chain, int printasswap);
+int free_ranges(void);
+int append_to_range_chain(int chain, unsigned long min, unsigned long max);
+void relativise_ranges(void);
+void relativise_chain(struct rangechain * chain);
+void absolutise_ranges(void);
+void absolutise_chain(struct rangechain * chain);
+int get_rangepages_list(void);
+void put_rangepages_list(void);
+unsigned long * get_rangepages_list_entry(int index);
+int relocate_rangepages(void);
+
+extern struct range * first_range_page, * last_range_page;
+
+#define RANGE_RELATIVE(x) (struct range *) ((((unsigned long) x) & \
+			(PAGE_SIZE - 1)) | \
+		((*RANGEPAGELINK(x) & (PAGE_SIZE - 1)) << PAGE_SHIFT))
+#define RANGE_ABSOLUTE(entry) (struct range *) \
+	((((unsigned long) (entry)) & (PAGE_SIZE - 1)) | \
+	 (unsigned long) get_rangepages_list_entry(((unsigned long) (entry)) >> PAGE_SHIFT))
+
+/* swap_entry_to_range_val & range_val_to_swap_entry: 
+ * We are putting offset in the low bits so consecutive swap entries
+ * make consecutive range values */
+#define swap_entry_to_range_val(swp_entry) (swp_entry.val)
+#define range_val_to_swap_entry(val) (swp_entry_t) { (val) }
+
diff -ruN 822-includes-old/kernel/power/smp.c 822-includes-new/kernel/power/smp.c
--- 822-includes-old/kernel/power/smp.c	2004-11-03 21:55:01.000000000 +1100
+++ 822-includes-new/kernel/power/smp.c	2004-11-24 18:51:50.315370880 +1100
@@ -15,6 +15,7 @@
 #include <linux/module.h>
 #include <asm/atomic.h>
 #include <asm/tlbflush.h>
+#include "suspend.h"
 
 static atomic_t cpu_counter, freeze;
 
diff -ruN 822-includes-old/kernel/power/suspend.h 822-includes-new/kernel/power/suspend.h
--- 822-includes-old/kernel/power/suspend.h	1970-01-01 10:00:00.000000000 +1000
+++ 822-includes-new/kernel/power/suspend.h	2004-11-24 18:51:50.316370728 +1100
@@ -0,0 +1,298 @@
+/*
+ * kernel/power/suspend2.h
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains declarations used throughout swsusp and suspend2.
+ *
+ */
+#ifndef KERNEL_POWER_SUSPEND_H
+#define KERNEL_POWER_SUSPEND_H
+
+#include <linux/delay.h>
+#include "range.h"
+
+/* ---------------------------- swsusp only ----------------------------- */
+
+typedef struct pbe {
+	unsigned long address;		/* address of the copy */
+	unsigned long orig_address;	/* original address of page */
+	swp_entry_t swap_address;	
+	swp_entry_t dummy;		/* we need scratch space at 
+					 * end of page (see link, diskpage)
+					 */
+} suspend_pagedir_t;
+
+#define SUSPEND_PD_PAGES(x)     (((x)*sizeof(struct pbe))/PAGE_SIZE+1)
+   
+/* mm/page_alloc.c */
+extern void drain_local_pages(void);
+
+void save_processor_state(void);
+void restore_processor_state(void);
+struct saved_context;
+void __save_processor_state(struct saved_context *ctxt);
+void __restore_processor_state(struct saved_context *ctxt);
+
+/* ---------------------------- Suspend2 -------------------------------- */
+
+/* Page Backup Entry.
+ *
+ * This is an abstraction which contains the data for one
+ * page of the image. (The data is really stored in ranges).
+ */
+
+struct pbe2 {
+	struct page * origaddress;	/* Original address of page */
+	struct page * address;		/* Address of copy of page */
+	struct range * currentorigrange;
+	struct range * currentdestrange;
+
+	struct pagedir * pagedir;
+};
+
+/* Pagedir
+ *
+ * Contains the metadata for a set of pages saved in the image.
+ */
+struct pagedir {
+	int pagedir_num;
+	int pageset_size;
+	int lastpageset_size;
+	struct rangechain origranges;
+	struct rangechain destranges;
+	struct rangechain allocdranges;
+};
+
+/* Function for setting the chain names for a pagedir (used
+ * for debugging */
+void set_chain_names(struct pagedir * p);
+
+#define pageset1_size (pagedir1.pageset_size)
+#define pageset2_size (pagedir2.pageset_size)
+
+/* Pagedir_nosave is pagedir1, loaded back in at the beginning
+ * of resuming and relocated so we can do our atomic restoration
+ * of the original kernel.
+ * Pagedir1 is the metadata for pageset 1 pages. Ditto for pageset 2.
+ */
+extern suspend_pagedir_t *pagedir_nosave __nosavedata;
+extern struct pagedir pagedir1, pagedir2;
+
+/* Non-plugin data saved in our image header */
+struct suspend_header {
+	u32 version_code;
+	unsigned long num_physpages;
+	char machine[65];
+	char version[65];
+	int num_cpus;
+	int page_size;
+	unsigned long orig_mem_free;
+	int num_range_pages;
+	struct range * unused_ranges;
+	int pageset_2_size;
+	int param0;
+	int param1;
+	int param2;
+	int param3;
+	int param4;
+	int progress0;
+	int progress1;
+	int progress2;
+	int progress3;
+	int io_time[2][2];
+	
+	/* Implementation specific variables */
+#ifdef KERNEL_POWER_SWSUSP_C
+	suspend_pagedir_t *suspend_pagedir;
+	unsigned int num_pbes;
+#else
+	struct pagedir pagedir;
+#endif
+};
+
+/* Suspend memory pool functions */
+struct page * get_suspend_pool_pages(unsigned int gfp_mask, unsigned int order);
+void free_suspend_pool_pages(struct page *page, unsigned int order);
+
+extern void schedule_suspend_message(int message_number);
+extern int suspend_min_free;
+
+extern void suspend_restore_avenrun(void);
+extern void suspend_save_avenrun(void);
+
+extern unsigned long get_highstart_pfn(void);
+
+#define SWAP_FILENAME_MAXLENGTH	32
+
+extern int suspend_default_console_level;
+extern int max_async_ios;
+extern int image_size_limit;
+
+struct pageset_sizes_result {
+	int size1; /* Can't be unsigned - breaks MAX function */
+	int size1low;
+	int size2;
+	int size2low;
+	int needmorespace;
+};
+
+#define MB(x) ((x) >> (20 - PAGE_SHIFT))
+
+extern int suspend_amount_grabbed;
+
+/*
+ * XXX: We try to keep some more pages free so that I/O operations succeed
+ * without paging. Might this be more?
+ */
+#ifdef CONFIG_HIGHMEM
+#define MIN_FREE_RAM (get_highstart_pfn() >> 7)
+#else
+#define MIN_FREE_RAM (max_mapnr >> 7)
+#endif
+
+extern void prepare_status(int printalways, int clearbar, const char *fmt, ...);
+extern void abort_suspend(const char *fmt, ...);
+
+extern int suspend_snprintf(char * buffer, int buffer_size,
+		const char *fmt, ...);
+
+/* ------ prepare_image.c ------ */
+extern unsigned long get_grabbed_pages(int order);
+
+/* ------ io.c ------ */
+int suspend_early_boot_message(int can_erase_image, char *reason, ...);
+
+/* ------ console.c ------ */
+void check_shift_keys(int pause, char * message);
+unsigned long update_status(unsigned long value, unsigned long maximum,
+		const char *fmt, ...);
+
+extern int expected_compression_ratio(void);
+
+#define MAIN_STORAGE_NEEDED(USE_ECR) \
+	((pageset1_size + pageset2_size) * \
+	 (USE_ECR ? expected_compression_ratio() : 100) / 100)
+
+#define HEADER_BYTES_NEEDED \
+	((num_range_pages << PAGE_SHIFT) + \
+	 sizeof(struct suspend_header) + \
+	 sizeof(struct plugin_header) + \
+	 (int) header_storage_for_plugins() + \
+	 num_plugins * \
+	 	(sizeof(struct plugin_header) + sizeof(int)))
+	
+#define HEADER_STORAGE_NEEDED ((HEADER_BYTES_NEEDED + (int) PAGE_SIZE - 1) >> PAGE_SHIFT)
+
+#define STORAGE_NEEDED(USE_ECR) \
+	(MAIN_STORAGE_NEEDED(USE_ECR) + HEADER_STORAGE_NEEDED)
+
+#define RAM_TO_SUSPEND (1 + max((pageset1_size - pageset2_sizelow), 0) + \
+		MIN_FREE_RAM + memory_for_plugins())
+
+#ifndef KERNEL_POWER_SWSUSP_C
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+#define cond_show_pcp_lists() \
+do { \
+	if (TEST_DEBUG_STATE(SUSPEND_FREEZER)) \
+		show_pcp_lists(); \
+} while(0)
+
+#define MDELAY(a) do { if (TEST_ACTION_STATE(SUSPEND_SLOW)) mdelay(a); } \
+	while (0)
+#define MAX_FREEMEM_SLOTS 25
+enum {
+	SUSPEND_FREE_BASE,
+	SUSPEND_FREE_CONSOLE_ALLOC,
+	SUSPEND_FREE_DRAIN_PCP,
+	SUSPEND_FREE_IN_USE_MAP,
+	SUSPEND_FREE_PS2_MAP,
+	SUSPEND_FREE_CHECKSUM_MAP,
+	SUSPEND_FREE_UNMAP_MAP,
+	SUSPEND_FREE_RELOAD_PAGES,
+	SUSPEND_FREE_INIT_PLUGINS,
+	SUSPEND_FREE_MEM_POOL,
+	SUSPEND_FREE_FREEZER,
+	SUSPEND_FREE_EAT_MEMORY,
+	SUSPEND_FREE_SYNC,
+	SUSPEND_FREE_GRABBED_MEMORY,
+	SUSPEND_FREE_RANGE_PAGES,
+	SUSPEND_FREE_EXTRA_PD1,
+	SUSPEND_FREE_WRITER_STORAGE,
+	SUSPEND_FREE_HEADER_STORAGE,
+	SUSPEND_FREE_CHECKSUM_PAGES,
+	SUSPEND_FREE_KSTAT,
+	SUSPEND_FREE_DEBUG_INFO,
+	SUSPEND_FREE_INVALIDATE_IMAGE,
+	SUSPEND_FREE_IO,
+	SUSPEND_FREE_IO_INFO,
+	SUSPEND_FREE_START_ONE
+};
+extern void suspend_store_free_mem(int slot, int side);
+extern int suspend_free_mem_values[MAX_FREEMEM_SLOTS][2];
+#else
+#define suspend_store_free_mem(a, b) do { } while(0)
+#define MDELAY(a) do { } while (0)
+#define cond_show_pcp_lists() do { } while(0)
+#endif
+#endif /* Not swsusp */
+
+extern int expected_compression_ratio(void);
+int print_module_list_to_buffer(char * buffer, int size);
+
+extern unsigned int nr_suspends;
+extern char resume2_file[];
+
+extern int suspend_wait_for_keypress(void);
+
+#ifdef CONFIG_SMP
+extern void smp_suspend(void);
+extern void smp_continue(void);
+#else
+#define smp_suspend() do { } while(0)
+#define smp_continue() do { } while(0)
+#endif
+
+/* For user interface */
+#include <linux/syscalls.h>
+extern asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf, 
+	size_t count);
+
+#ifdef CONFIG_BOOTSPLASH
+#include <linux/console.h>
+#include <linux/fb.h>
+#include "../../drivers/video/console/fbcon.h"
+static inline struct splash_data * get_splash_data(int consolenr)
+{
+	BUG_ON(consolenr >= MAX_NR_CONSOLES);
+
+	if (vc_cons[consolenr].d)
+		return vc_cons[consolenr].d->vc_splash_data;
+	
+	return NULL;
+}
+#endif
+
+extern asmlinkage ssize_t sys_write(unsigned int fd, const char __user * buf, size_t count);
+
+extern struct pm_ops * pm_ops;
+extern dev_t name_to_dev_t(char *line);
+extern char _text[], _etext[], _edata[], __bss_start[], _end[];
+extern void signal_wake_up(struct task_struct *t, int resume);
+
+extern struct partial_device_tree * suspend_device_tree;
+
+/* Returns whether it was already in the requested state */
+extern int suspend_map_kernel_page(struct page * page, int enable);
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+extern void suspend_map_atomic_copy_pages(void);
+extern void suspend_unmap_atomic_copy_pages(void);
+#else
+#define suspend_map_atomic_copy_pages() do { } while(0)
+#define suspend_unmap_atomic_copy_pages() do { } while(0)
+#endif
+
+#endif
diff -ruN 822-includes-old/kernel/power/swsusp.c 822-includes-new/kernel/power/swsusp.c
--- 822-includes-old/kernel/power/swsusp.c	2004-11-24 18:52:16.550382552 +1100
+++ 822-includes-new/kernel/power/swsusp.c	2004-11-24 18:51:50.318370424 +1100
@@ -36,6 +36,8 @@
  * For TODOs,FIXMEs also look in Documentation/power/swsusp.txt
  */
 
+#define KERNEL_POWER_SWSUSP_C
+
 #include <linux/module.h>
 #include <linux/mm.h>
 #include <linux/suspend.h>
@@ -51,9 +53,7 @@
 #include <linux/keyboard.h>
 #include <linux/spinlock.h>
 #include <linux/genhd.h>
-#include <linux/kernel.h>
 #include <linux/major.h>
-#include <linux/swap.h>
 #include <linux/pm.h>
 #include <linux/device.h>
 #include <linux/buffer_head.h>
@@ -70,9 +70,7 @@
 #include <asm/io.h>
 
 #include "power.h"
-
-/* References to section boundaries */
-extern char __nosave_begin, __nosave_end;
+#include "suspend.h"
 
 extern int is_head_of_free_region(struct page *);
 


