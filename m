Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262084AbVGFEYT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262084AbVGFEYT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Jul 2005 00:24:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262099AbVGFEYS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Jul 2005 00:24:18 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:12697 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262084AbVGFCTj convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:39 -0400
Subject: [PATCH] [41/48] Suspend2 2.1.9.8 for 2.6.12: 617-proc.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <1120616443979@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 618-core.patch-old/kernel/power/suspend2_core/suspend.c 618-core.patch-new/kernel/power/suspend2_core/suspend.c
--- 618-core.patch-old/kernel/power/suspend2_core/suspend.c	1970-01-01 10:00:00.000000000 +1000
+++ 618-core.patch-new/kernel/power/suspend2_core/suspend.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,1180 @@
+/*
+ * kernel/power/suspend2.c
+ */
+/** \mainpage Software Suspend 2.
+ *
+ * Suspend2 provides support for saving and restoring an image of
+ * system memory to an arbitrary storage device, either on the local computer,
+ * or across some network. The support is entirely OS based, so Suspend2 
+ * works without requiring BIOS, APM or ACPI support. The vast majority of the
+ * code is also architecture independant, so it should be very easy to port
+ * the code to new architectures. Suspend includes support for SMP, 4G HighMem
+ * and preemption. Initramfses and initrds are also supported.
+ *
+ * Suspend2 uses a modular design, in which the method of storing the image is
+ * completely abstracted from the core code, as are transformations on the data
+ * such as compression and/or encryption (multiple 'plugins' can be used to
+ * provide arbitrary combinations of functionality). The user interface is also
+ * modular, so that arbitrarily simple or complex interfaces can be used to
+ * provide anything from debugging information through to eye candy.
+ * 
+ * \section Copyright
+ *
+ * Suspend2 is released under the GPLv2.
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu><BR>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz><BR>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr><BR>
+ * Copyright (C) 2002-2005 Nigel Cunningham <ncunningham@cyclades.com><BR>
+ *
+ * \section Credits
+ * 
+ * Nigel would like to thank the following people for their work:
+ * 
+ * Pavel Machek <pavel@ucw.cz><BR>
+ * Modifications, defectiveness pointing, being with Gabor at the very beginning,
+ * suspend to swap space, stop all tasks. Port to 2.4.18-ac and 2.5.17.
+ *
+ * Steve Doddi <dirk@loth.demon.co.uk><BR> 
+ * Support the possibility of hardware state restoring.
+ *
+ * Raph <grey.havens@earthling.net><BR>
+ * Support for preserving states of network devices and virtual console
+ * (including X and svgatextmode)
+ *
+ * Kurt Garloff <garloff@suse.de><BR>
+ * Straightened the critical function in order to prevent compilers from
+ * playing tricks with local variables.
+ *
+ * Andreas Mohr <a.mohr@mailto.de>
+ *
+ * Alex Badea <vampire@go.ro><BR>
+ * Fixed runaway init
+ *
+ * Jeff Snyder <je4d@pobox.com><BR>
+ * ACPI patch
+ *
+ * Nathan Friess <natmanz@shaw.ca><BR>
+ * Some patches.
+ *
+ * Michael Frank <mhf@linuxmail.org><BR>
+ * Extensive testing and help with improving stability. Nigel was constantly
+ * amazed by the quality and quantity of Michael's help.
+ *
+ * Bernard Blackham <bernard@blackham.com.au><BR>
+ * Web page & Wiki administration, some coding. Another person without whom
+ * Suspend would not be where it is.
+ *
+ * ..and of course the myriads of Suspend2 users who have helped diagnose
+ * and fix bugs, made suggestions on how to improve the code, proofread
+ * documentation, and donated time and money.
+ *
+ * Thanks also to corporate sponsors:
+ *
+ * <B>Cyclades.com.</B> Nigel's employers from Dec 2004, who allow him to work on
+ * Suspend and PM related issues on company time.
+ * 
+ * <B>LinuxFund.org.</B> Sponsored Nigel's work on Suspend for four months Oct 2003
+ * to Jan 2004.
+ *
+ * <B>LAC Linux.</B> Donated P4 hardware that enabled development and ongoing
+ * maintenance of SMP and Highmem support.
+ *
+ * <B>OSDL.</B> Provided access to various hardware configurations, make occasional
+ * small donations to the project.
+ */
+
+#define SUSPEND_MAIN_C
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include <linux/console.h>
+#include <linux/version.h>
+#include <linux/reboot.h>
+#include <linux/mm.h>
+#include <linux/highmem.h>
+#include <asm/uaccess.h>
+#include <asm/param.h>
+
+#include "version.h"
+#include "suspend.h"
+#include "driver_model.h"
+#include "plugins.h"
+#include "proc.h"
+#include "pageflags.h"
+#include "prepare_image.h"
+#include "io.h"
+#include "ui.h"
+#include "version.h"
+#include "suspend2_common.h"
+#include "extent.h"
+#include "power_off.h"
+#include "utility.h"
+#include "smp.h"
+#include "atomic_copy.h"
+ 
+#ifdef  CONFIG_X86
+#include <asm/i387.h> /* for kernel_fpu_end */
+#endif
+
+/* Variables to be preserved over suspend */
+int pageset1_sizelow = 0, pageset2_sizelow = 0, image_size_limit = 0;
+unsigned long suspend2_orig_mem_free = 0;
+
+static dyn_pageflags_t pageset1_check_map;
+static dyn_pageflags_t pageset2_check_map;
+static char * debug_info_buffer;
+static char suspend_core_version[] = SUSPEND_CORE_VERSION;
+
+extern void do_suspend2_lowlevel(int resume);
+extern __nosavedata char resume_commandline[COMMAND_LINE_SIZE];
+
+/* 
+ *---------------------  Variables ---------------------------
+ * 
+ * The following are used by the arch specific low level routines 
+ * and only needed if suspend2 is compiled in. Other variables,
+ * used by the freezer even if suspend2 is not compiled in, are
+ * found in process.c
+ */
+
+/*! How long I/O took. */
+int suspend_io_time[2][2];
+
+/* Compression ratio */
+__nosavedata unsigned long bytes_in = 0, bytes_out = 0;
+
+/*! Pageset metadata. */
+struct pagedir pagedir1 = { 0, 0}, pagedir2 = { 0, 0}; 
+
+/* Suspend2 variables used by built-in routines. */
+
+/*! The number of suspends we have started (some may have been cancelled) */
+unsigned int nr_suspends = 0;
+
+/*! The console log level we default to. */
+int suspend_default_console_level = 0;
+
+/* 
+ * For resume2= kernel option. It's pointless to compile
+ * suspend2 without any writers, but compilation shouldn't
+ * fail if you do.
+ */
+
+unsigned long software_suspend_state = ((1 << SUSPEND_DISABLED) | (1 << SUSPEND_BOOT_TIME) |
+		(1 << SUSPEND_RESUME_NOT_DONE) | (1 << SUSPEND_IGNORE_LOGLEVEL));
+
+mm_segment_t	oldfs;
+
+#ifdef CONFIG_SUSPEND2_DEFAULT_RESUME2
+char resume2_file[256] = CONFIG_SUSPEND2_DEFAULT_RESUME2;
+#else
+char resume2_file[256]
+#endif
+
+/* -------------------------------------------------------------------------- */
+
+static atomic_t actions_running;
+
+/*
+ * Basic clean-up routine.
+ */
+void suspend_finish_anything(int finishing_cycle)
+{
+	if (atomic_dec_and_test(&actions_running)) {
+		suspend2_cleanup_plugins(finishing_cycle);
+		suspend2_put_modules();
+		clear_suspend_state(SUSPEND_RUNNING);
+	}
+
+	set_fs(oldfs);
+}
+
+/*
+ * Basic set-up routine.
+ */
+int suspend_start_anything(int starting_cycle)
+{
+	oldfs = get_fs();
+
+	if (atomic_add_return(1, &actions_running) == 1) {
+       		set_fs(KERNEL_DS);
+
+		set_suspend_state(SUSPEND_RUNNING);
+
+		if (suspend2_get_modules()) {
+			printk("Get modules failed!\n");
+			clear_suspend_state(SUSPEND_RUNNING);
+			set_fs(oldfs);
+			return -EBUSY;
+		}
+
+		if (suspend2_initialise_plugins(starting_cycle)) {
+			printk("Initialise plugins failed!\n");
+			suspend_finish_anything(starting_cycle);
+			return -EBUSY;
+		}
+	}
+
+	return 0;
+}
+
+/* -------------------------------------------------------------------------- */
+
+/*
+ * save_image
+ * Result code (int): Zero on success, non zero on failure.
+ * Functionality    : High level routine which performs the steps necessary
+ *                    to prepare and save the image after preparatory steps
+ *                    have been taken.
+ * Key Assumptions  : Processes frozen, sufficient memory available, drivers
+ *                    suspended.
+ * Called from      : suspend2_suspend_2
+ */
+
+static int save_image(void)
+{
+	int temp_result;
+
+	if (RAM_TO_SUSPEND > max_mapnr) {
+		suspend2_prepare_status(1, 1,
+			"Couldn't get enough free pages, on %ld pages short",
+			 RAM_TO_SUSPEND - max_mapnr);
+		return -1;
+	}
+	
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+		" - Final values: %d and %d.\n",
+		pageset1_size, 
+		pageset2_size);
+
+	check_shift_keys(1, "About to write pagedir2.");
+
+	temp_result = write_pageset(&pagedir2, 2);
+	
+	if (temp_result == -1 || TEST_RESULT_STATE(SUSPEND_ABORTED))
+		return -1;
+
+	check_shift_keys(1, "About to copy pageset 1.");
+
+	suspend2_prepare_status(1, 0, "Doing atomic copy.");
+	
+	do_suspend2_lowlevel(0);
+
+	return 0;
+}
+
+/*
+ * Save the second part of the image.
+ */
+int save_image_part1(void)
+{
+	int temp_result, old_ps1_size = pageset1_size;
+	dyn_pageflags_t temp;
+	
+	/* Quick switch: We want to compare the old stats with the new ones. */
+	temp = pageset1_map;
+	pageset1_map = pageset1_check_map;
+	pageset1_check_map = temp;
+
+	temp = pageset2_map;
+	pageset2_map = pageset2_check_map;
+	pageset2_check_map = temp;
+
+	suspend2_recalculate_stats();
+
+	if ((pageset1_size - old_ps1_size) > EXTRA_PD1_PAGES_ALLOWANCE) {
+		abort_suspend("Pageset1 has grown by %d pages."
+			" Only %d growth is allowed for!\n",
+			pageset1_size - old_ps1_size,
+			EXTRA_PD1_PAGES_ALLOWANCE);
+		return -1;
+	}
+
+	suspend2_map_atomic_copy_pages();
+
+	BUG_ON(!irqs_disabled());
+
+	if (!TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
+		suspend2_copy_pageset1();
+
+	/*
+	 *  ----   FROM HERE ON, NEED TO REREAD PAGESET2 IF ABORTING!!! -----
+	 *  
+	 */
+	
+	suspend2_unmap_atomic_copy_pages();
+
+	/* 
+	 * Other processors have waited for me to make the atomic copy of the 
+	 * kernel
+	 */
+
+	smp_continue();
+	
+#ifdef CONFIG_X86
+	kernel_fpu_end();
+#endif
+
+	preempt_enable_no_resched();
+
+	suspend_drivers_resume(SUSPEND_DRIVERS_IRQS_DISABLED);
+	
+	local_irq_enable();
+
+	suspend_drivers_resume(SUSPEND_DRIVERS_IRQS_ENABLED);
+
+	suspend2_update_status(pageset2_size, pageset1_size + pageset2_size, NULL);
+	
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	check_shift_keys(1, "About to write pageset1.");
+
+	/*
+	 * End of critical section.
+	 */
+	
+	suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+			"-- Writing pageset1\n");
+
+	temp_result = write_pageset(&pagedir1, 1);
+
+	/* We didn't overwrite any memory, so no reread needs to be done. */
+	if (TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
+		return -1;
+
+	if (temp_result == -1 || TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	check_shift_keys(1, "About to write header.");
+
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto abort_reloading_pagedir_two;
+
+	temp_result = write_image_header();
+
+	if (temp_result || (TEST_RESULT_STATE(SUSPEND_ABORTED)))
+		goto abort_reloading_pagedir_two;
+
+	check_shift_keys(1, "About to power down or reboot.");
+
+	return 0;
+
+abort_reloading_pagedir_two:
+	temp_result = read_pageset2(1);
+
+	/* If that failed, we're sunk. Panic! */
+	if (temp_result)
+		panic("Attempt to reload pagedir 2 while aborting "
+				"a suspend failed.");
+
+	return -1;		
+
+}
+
+#define SNPRINTF(a...) 	len += suspend_snprintf(debug_info_buffer + len, \
+		PAGE_SIZE - len - 1, ## a)
+
+static inline int io_MB_per_second(int read_write)
+{
+	if (!suspend_io_time[read_write][1])
+		return 0;
+
+	return MB((unsigned long) suspend_io_time[read_write][0]) * HZ /
+		suspend_io_time[read_write][1];
+}
+
+/* get_debug_info
+ * Functionality:	Store debug info in a buffer.
+ * Called from:		suspend_try_suspend.
+ */
+
+
+static int get_suspend_debug_info(void)
+{
+	int len = 0;
+	if (!debug_info_buffer) {
+		debug_info_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+		if (!debug_info_buffer) {
+			printk("Error! Unable to allocate buffer for"
+					"software suspend debug info.\n");
+			return 0;
+		}
+	}
+
+	SNPRINTF("Please include the following information in bug reports:\n");
+	SNPRINTF("- SUSPEND core   : %s\n", SUSPEND_CORE_VERSION);
+	SNPRINTF("- Kernel Version : %s\n", UTS_RELEASE);
+	SNPRINTF("- Compiler vers. : %d.%d\n", __GNUC__, __GNUC_MINOR__);
+	SNPRINTF("- Attempt number : %d\n", nr_suspends);
+	SNPRINTF("- Pageset sizes  : %d (%d low) and %d (%d low).\n",
+			pagedir1.lastpageset_size, 
+			pageset1_sizelow,
+			pagedir2.lastpageset_size, 
+			pageset2_sizelow);
+	SNPRINTF("- Parameters     : %ld %ld %ld %d %d %ld\n",
+			suspend_result,
+			suspend_action,
+			suspend_debug_state,
+			suspend_default_console_level,
+			image_size_limit,
+			suspend2_powerdown_method);
+	SNPRINTF("- Calculations   : Image size: %lu. "
+			"Ram to suspend: %ld.\n",
+			STORAGE_NEEDED(1), RAM_TO_SUSPEND);
+	SNPRINTF("- Limits         : %lu pages RAM. Initial boot: %lu.\n",
+		max_mapnr, suspend2_orig_mem_free);
+	SNPRINTF("- Overall expected compression percentage: %d.\n",
+			100 - expected_compression_ratio());
+	len+= print_plugin_debug_info(debug_info_buffer + len, 
+			PAGE_SIZE - len - 1);
+#ifdef CONFIG_PM_DEBUG
+	SNPRINTF("- Debugging compiled in.\n");
+#endif
+#ifdef CONFIG_PREEMPT
+	SNPRINTF("- Preemptive kernel.\n");
+#endif
+#ifdef CONFIG_SMP
+	SNPRINTF("- SMP kernel.\n");
+#endif
+#ifdef CONFIG_HIGHMEM
+	SNPRINTF("- Highmem Support.\n");
+#endif
+	SNPRINTF("- Max extents used: %d\n",
+			max_extents_used);
+	if (suspend_io_time[0][1]) {
+		if ((io_MB_per_second(0) < 5) || (io_MB_per_second(1) < 5)) {
+			SNPRINTF("- I/O speed: Write %d KB/s",
+			  (KB((unsigned long) suspend_io_time[0][0]) * HZ /
+			  suspend_io_time[0][1]));
+			if (suspend_io_time[1][1])
+				SNPRINTF(", Read %d KB/s",
+				  (KB((unsigned long) suspend_io_time[1][0]) * HZ /
+				  suspend_io_time[1][1]));
+		} else {
+			SNPRINTF("- I/O speed: Write %d MB/s",
+			 (MB((unsigned long) suspend_io_time[0][0]) * HZ /
+			  suspend_io_time[0][1]));
+			if (suspend_io_time[1][1])
+				SNPRINTF(", Read %d MB/s",
+				 (MB((unsigned long) suspend_io_time[1][0]) * HZ /
+				  suspend_io_time[1][1]));
+		}
+		SNPRINTF(".\n");
+	}
+	else
+		SNPRINTF("- No I/O speed stats available.\n");
+
+	return len;
+}
+
+/*
+ * debuginfo_read_proc
+ * Functionality   : Displays information that may be helpful in debugging
+ *                   software suspend.
+ */
+int debuginfo_read_proc(char * page, char ** start, off_t off, int count,
+		int *eof, void *data)
+{
+	int info_len, copy_len;
+
+	info_len = get_suspend_debug_info();
+
+	copy_len = min(info_len - (int) off, count);
+	if (copy_len < 0)
+		copy_len = 0;
+
+	if (copy_len) {
+		memcpy(page, debug_info_buffer + off, copy_len);
+		*start = page;
+	} 
+
+	if (copy_len + off == info_len)
+		*eof = 1;
+
+	free_pages((unsigned long) debug_info_buffer, 0);
+	debug_info_buffer = NULL;
+	return copy_len;
+}
+
+static int allocate_bitmaps(void)
+{
+	suspend_message(SUSPEND_MEMORY, SUSPEND_VERBOSE, 1,
+			"Allocating in_use_map\n");
+	if (suspend_allocate_dyn_pageflags(&in_use_map))
+		return 1;
+	
+	if (suspend_allocate_dyn_pageflags(&pageset1_map))
+		return 1;
+
+	if (suspend_allocate_dyn_pageflags(&pageset1_copy_map))
+		return 1;
+
+	if (suspend_allocate_dyn_pageflags(&allocd_pages_map))
+		return 1;
+
+	if (suspend_allocate_dyn_pageflags(&pageset2_map))
+		return 1;
+
+#ifdef CONFIG_DEBUG_PAGEALLOC
+	if (suspend_allocate_dyn_pageflags(&unmap_map))
+		return 1;
+
+#endif	
+	
+	if (suspend_allocate_dyn_pageflags(&pageset1_check_map))
+		return 1;
+	
+	if (suspend_allocate_dyn_pageflags(&pageset2_check_map))
+		return 1;
+
+	return 0;
+}
+
+static void free_metadata(void)
+{
+	free_dyn_pageflags(&pageset1_map);
+
+	free_dyn_pageflags(&pageset1_copy_map);
+
+	free_dyn_pageflags(&allocd_pages_map);
+
+	free_dyn_pageflags(&pageset2_map);
+
+	free_dyn_pageflags(&in_use_map);
+
+	free_dyn_pageflags(&pageset1_check_map);
+	free_dyn_pageflags(&pageset2_check_map);
+}
+
+static inline int check_still_keeping_image(void)
+{
+	if (TEST_ACTION_STATE(SUSPEND_KEEP_IMAGE)) {
+		printk("Image already stored: powering down immediately.");
+		suspend_power_down();
+		return 1;	/* Just in case we're using S3 */
+	}
+
+	printk("Invalidating previous image.\n");
+	active_writer->ops.writer.invalidate_image();
+
+	return 0;
+}
+
+static inline int suspend2_init(void)
+{
+	suspend_result = 0;
+
+	printk(name_suspend "Initiating a software suspend cycle.\n");
+
+	max_extents_used = 0;
+	nr_suspends++;
+	clear_suspend_state(SUSPEND_NOW_RESUMING);
+	
+	suspend_io_time[0][0] = suspend_io_time[0][1] = 
+		suspend_io_time[1][0] =
+		suspend_io_time[1][1] = 0;
+
+	suspend2_prepare_console();
+
+	free_metadata();	/* We might have kept it */
+
+	attempt_to_parse_resume_device();
+	
+	if (test_suspend_state(SUSPEND_DISABLED))
+		return 0;
+	
+	if (suspend_drivers_init())
+		return 0;
+
+	if (allocate_bitmaps())
+		return 0;
+	
+	ensure_on_processor_zero();
+
+	return 1;
+}
+
+void inline suspend2_cleanup(void)
+{
+	int i;
+
+	i = get_suspend_debug_info();
+
+	suspend2_free_pagedir_data();
+	
+	thaw_processes(FREEZER_KERNEL_THREADS);
+
+#ifdef CONFIG_SUSPEND2_KEEP_IMAGE
+	if (TEST_ACTION_STATE(SUSPEND_KEEP_IMAGE) &&
+	    !TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+		suspend_message(SUSPEND_ANY_SECTION, SUSPEND_LOW, 1,
+			name_suspend "Not invalidating the image due "
+			"to Keep Image being enabled.\n");
+		SET_RESULT_STATE(SUSPEND_KEPT_IMAGE);
+	} else
+#endif
+		if (active_writer)
+			active_writer->ops.writer.invalidate_image();
+
+	if (!TEST_ACTION_STATE(SUSPEND_KEEP_METADATA))
+		free_metadata();
+
+#ifdef CONFIG_DEBUG_PAGE_ALLOC
+	free_dyn_pageflags(&unmap_map);
+#endif
+
+	if (debug_info_buffer) {
+		/* Printk can only handle 1023 bytes, including
+		 * its level mangling. */
+		for (i = 0; i < 3; i++)
+			printk("%s", debug_info_buffer + (1023 * i));
+		free_pages((unsigned long) debug_info_buffer, 0);
+		debug_info_buffer = NULL;
+	}
+
+	suspend_drivers_cleanup();
+
+	thaw_processes(FREEZER_ALL_THREADS);
+
+	suspend2_cleanup_console();
+
+	return_to_all_processors();
+}
+
+/*
+ * suspend2_main
+ * Functionality   : First level of code for software suspend invocations.
+ *                   Stores and restores load averages (to avoid a spike),
+ *                   allocates bitmaps, freezes processes and eats memory
+ *                   as required before suspending drivers and invoking
+ *                   the 'low level' code to save the state to disk.
+ *                   By the time we return from do_suspend2_lowlevel, we
+ *                   have either failed to save the image or successfully
+ *                   suspended and reloaded the image. The difference can
+ *                   be discerned by checking SUSPEND_ABORTED.
+ * Called From     : 
+ */
+
+void suspend2_main(void)
+{
+	/*
+	 * If kept image and still keeping image and suspending to RAM, we will 
+	 * return 1 after suspending and resuming (provided the power doesn't
+	 * run out.
+	 */
+	if (TEST_RESULT_STATE(SUSPEND_KEPT_IMAGE) && check_still_keeping_image())
+		return;
+
+	if (suspend2_init() && suspend2_prepare_image() && !TEST_RESULT_STATE(SUSPEND_ABORTED) &&
+		!TEST_ACTION_STATE(SUSPEND_FREEZER_TEST))
+	{
+		if (!TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+			suspend2_prepare_status(1, 0, "Starting to save the image..");
+			save_image();
+		}
+	}
+	
+	suspend2_cleanup();
+}
+
+/* image_exists_read
+ * 
+ * Return 0 or 1, depending on whether an image is found.
+ */
+static int image_exists_read(char * page, char ** start, off_t off, int count,
+		int *eof, void *data)
+{
+	int len = 0;
+	
+	attempt_to_parse_resume_device();
+
+	if (!active_writer)
+		len = sprintf(page, "-1\n");
+	else
+		len = sprintf(page, "%d\n", active_writer->ops.writer.image_exists());
+
+	*eof = 1;
+	return len;
+}
+
+/* image_exists_read
+ * 
+ * Return 0 or 1, depending on whether an image is found.
+ */
+static int image_exists_write(struct file *file, const char * buffer,
+		unsigned long count, void * data)
+{
+	if (active_writer && active_writer->ops.writer.image_exists())
+		active_writer->ops.writer.invalidate_image();
+
+	return count;
+}
+
+/*
+ * Core proc entries that aren't built in.
+ *
+ * This array contains entries that are automatically registered at
+ * boot. Plugins and the console code register their own entries separately.
+ */
+extern int toggle_pid;
+void toggle_thread_nofreeze(void);
+
+static struct suspend_proc_data proc_params[] = {
+	{ .filename			= "debug_info",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .data = {
+		  .special = {
+			  .read_proc	= debuginfo_read_proc,
+		  }
+	  }
+	},
+	
+	{ .filename			= "image_exists",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_CUSTOM,
+	  .data = {
+		  .special = {
+			  .read_proc	= image_exists_read,
+			  .write_proc	= image_exists_write,
+		  }
+	  }
+	},
+
+	{ .filename			= "image_size_limit",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &image_size_limit,
+			  .minimum	= -2,
+			  .maximum	= 32767,
+		  }
+	  }
+	},
+
+	{ .filename			= "last_result",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	=  &suspend_result,
+		  }
+	  }
+	},
+	
+	{ .filename			= "reboot",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_REBOOT,
+		  }
+	  }
+	},
+	  
+	{ .filename			= "resume2",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		  .string = {
+			  .variable	= resume2_file,
+			  .max_length	= 255,
+		  }
+	  },
+	  .write_proc			= attempt_to_parse_resume_device,
+	},
+
+	{ .filename			= "resume_commandline",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		  .string = {
+			  .variable	= resume_commandline,
+			  .max_length	= COMMAND_LINE_SIZE,
+		  }
+	  },
+	  .write_proc			= attempt_to_parse_resume_device,
+	},
+
+
+	{ .filename			= "toggle_process_nofreeze",
+	  .permissions			= PROC_WRITEONLY,
+	  .type				= SUSPEND_PROC_DATA_INTEGER,
+	  .data = {
+		  .integer = {
+			  .variable	= &toggle_pid,
+			  .minimum	= 2,
+			  .maximum	= 32767,
+		  }
+	  },
+	  .write_proc			= toggle_thread_nofreeze,
+	},
+
+	{ .filename			= "version",
+	  .permissions			= PROC_READONLY,
+	  .type				= SUSPEND_PROC_DATA_STRING,
+	  .data = {
+		  .string = {
+			  .variable	= suspend_core_version,
+		  }
+	  }
+	},
+
+#ifdef CONFIG_PM_DEBUG
+	{ .filename			= "freezer_test",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_FREEZER_TEST,
+		  }
+	  }
+	},
+
+	{ .filename			= "keep_metadata",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_KEEP_METADATA,
+		  }
+	  }
+	},
+
+	{ .filename			= "test_filter_speed",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_TEST_FILTER_SPEED,
+		  }
+	  }
+	},
+
+	{ .filename			= "slow",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_SLOW,
+		  }
+	  }
+	},
+	
+#endif
+	  
+#if defined(CONFIG_ACPI)
+	{ .filename			= "powerdown_method",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_UL,
+	  .data = {
+		  .ul = {
+			  .variable	= &suspend2_powerdown_method,
+			  .minimum	= 3,
+			  .maximum	= 5,
+		  }
+	  }
+	},
+#endif
+
+#ifdef CONFIG_SUSPEND2_KEEP_IMAGE
+	{ .filename			= "keep_image",
+	  .permissions			= PROC_RW,
+	  .type				= SUSPEND_PROC_DATA_BIT,
+	  .data = {
+		  .bit = {
+			  .bit_vector	= &suspend_action,
+			  .bit		= SUSPEND_KEEP_IMAGE,
+		  }
+	  }
+	},
+#endif
+};
+
+
+/*
+ * Called from init kernel_thread.
+ * We check if we have an image and if so we try to resume.
+ * We also start ksuspendd if configuration looks right.
+ */
+
+int suspend2_resume(void)
+{
+	int read_image_result = 0;
+
+	if (sizeof(swp_entry_t) != sizeof(long)) {
+		printk(KERN_WARNING name_suspend
+			"The size of swp_entry_t != size of long. "
+			"Please report this!\n");
+		return 1;
+	}
+	
+	if (!resume2_file[0])
+		printk(KERN_WARNING name_suspend
+			"You need to use a resume2= command line parameter to "
+			"tell Software Suspend 2 where to look for an image.\n");
+
+	if (!(test_suspend_state(SUSPEND_RESUME_DEVICE_OK)))
+		attempt_to_parse_resume_device();
+
+	if (!(test_suspend_state(SUSPEND_RESUME_DEVICE_OK))) {
+		/* 
+		 * Without a usable storage device we can do nothing - 
+		 * even if noresume is given
+		 */
+
+		if (!num_writers)
+			printk(KERN_ALERT name_suspend
+				"No writers have been registered.\n");
+		else
+			printk(KERN_ALERT name_suspend
+				"Missing or invalid storage location "
+				"(resume2= parameter). Please correct and "
+				"rerun lilo (or equivalent) before "
+				"suspending.\n");
+		return 1;
+	}
+
+	/* We enable the possibility of machine suspend */
+	suspend2_orig_mem_free = real_nr_free_pages();
+
+	suspend_task = current->pid;
+
+	read_image_result = read_pageset1(); /* non fatal error ignored */
+
+	if (test_suspend_state(SUSPEND_NORESUME_SPECIFIED))
+		printk(KERN_WARNING name_suspend "Resuming disabled as requested.\n");
+
+	if (read_image_result) {
+		suspend_task = 0;
+		return 1;
+	}
+
+	suspend_drivers_init();
+
+	suspend_atomic_restore();
+
+	BUG();
+
+	return 0;
+}
+
+extern void request_abort_suspend(void);
+extern void suspend2_schedule_message(int message_number);
+
+static __init int core_load(void)
+{
+	int i, numfiles = sizeof(proc_params) / sizeof(struct suspend_proc_data);
+
+	printk("Software Suspend Core.\n");
+	
+	suspend_initialise_plugin_lists();
+	
+	for (i=0; i< numfiles; i++)
+		suspend_register_procfile(&proc_params[i]);
+
+	return 0;
+}
+
+/* ------------ Functions for kickstarting a suspend or resume ----------- */
+
+static int can_suspend(void)
+{
+	/* 
+	 * Perhaps something has changed such that we can suspend or
+	 * resume when we couldn't before. Check before complaining.
+	 */
+	
+	if (test_suspend_state(SUSPEND_DISABLED))
+		attempt_to_parse_resume_device();
+
+	if (test_suspend_state(SUSPEND_DISABLED)) {
+		printk(name_suspend "Software suspend is disabled.\n"
+			"This may be because you haven't put something along the "
+			"lines of\n\nresume2=swap:/dev/hda1\n\n"
+			"in lilo.conf or equivalent. (Where /dev/hda1 is your "
+			"swap partition).\n");
+		SET_RESULT_STATE(SUSPEND_ABORTED);
+		return 0;
+	}
+	
+	return 1;
+}
+
+/*
+ * Check if we have an image and if so try to resume.
+ */
+
+void __suspend2_try_resume(void)
+{
+	set_suspend_state(SUSPEND_TRYING_TO_RESUME);
+	
+	clear_suspend_state(SUSPEND_RESUME_NOT_DONE);
+
+	suspend2_resume();
+
+	clear_suspend_state(SUSPEND_IGNORE_LOGLEVEL);
+	clear_suspend_state(SUSPEND_TRYING_TO_RESUME);
+}
+
+/* Wrapper for when called from init/do_mounts.c */
+void suspend2_try_resume(void)
+{
+	if (suspend_start_anything(0))
+		return;
+
+	__suspend2_try_resume();
+
+	/* 
+	 * For initramfs, we have to clear the boot time
+	 * flag after trying to resume
+	 */
+	clear_suspend_state(SUSPEND_BOOT_TIME);
+
+	suspend_finish_anything(0);
+}
+
+/*
+ * suspend_check_mounts
+ *
+ * Functionality:	Check that the user doesn't have any mounts that
+ * 			may be corrupted by resuming. Display them if needsbe.
+ * 			On exit, CONTINUE_REQ is set if we can continue resuming.
+ */
+
+void suspend_check_mounts(void)
+{
+	if (!mounts_are_S4_resume_safe()) {
+		char *buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+		get_S4_resume_unsafe_mounts(buffer, PAGE_SIZE);
+		suspend_early_boot_message(1, 0,
+			"You have filesystems mounted that may make resuming unsafe:\n %s", buffer);
+		free_pages((unsigned long) buffer, 0);
+		return;
+	}
+
+	set_suspend_state(SUSPEND_CONTINUE_REQ);
+	return;
+}
+
+/*
+ * __suspend2_try_suspend
+ * Functionality   : Performs the basic checking as to whether suspend is
+ * 		     enabled before invoking the high level routine.
+ * Called From     : proc.c, suspend2_try_suspend.c
+ */
+void __suspend2_try_suspend(void)
+{
+	if (can_suspend())
+		suspend2_main();
+}
+
+/*
+ * suspend2_try_suspend
+ * Functionality   : Wrapper around __suspend2_try_suspend.
+ * Called From     : drivers/acpi/sleep/main.c
+ *                   kernel/reboot.c
+ */
+
+void suspend2_try_suspend(void)
+{
+	if (suspend_start_anything(0))
+		return;
+
+	__suspend2_try_suspend();
+
+	suspend_finish_anything(0);
+}
+
+/* -------------------  Commandline Parameter Handling -----------------
+ *
+ * Resume setup: obtain the storage device.
+ */
+
+static int __init resume_setup(char *str)
+{
+	if (str == NULL)
+		return 1;
+	
+	strncpy(resume2_file, str, 255);
+	return 0;
+}
+
+/*
+ * Allow the user to set the action parameter from lilo, prior to resuming.
+ */
+static int __init suspend_act_setup(char *str)
+{
+	if(str)
+		suspend_action=simple_strtol(str,NULL,0);
+	set_suspend_state(SUSPEND_ACT_USED);
+	return 0;
+}
+
+/*
+ * Allow the user to set the debug parameter from lilo, prior to resuming.
+ */
+/*
+ * Allow the user to specify that we should ignore any image found and
+ * invalidate the image if necesssary. This is equivalent to running
+ * the task queue and a sync and then turning off the power. The same
+ * precautions should be taken: fsck if you're not journalled.
+ */
+static int __init noresume_setup(char *str)
+{
+	set_suspend_state(SUSPEND_NORESUME_SPECIFIED);
+	/* Message printed later */
+	return 0;
+}
+
+static int __init suspend2_retry_resume_setup(char *str)
+{
+	set_suspend_state(SUSPEND_RETRY_RESUME);
+	return 0;
+}
+
+__setup("resume2=", resume_setup);
+__setup("suspend_act=", suspend_act_setup);
+
+#ifdef CONFIG_PM_DEBUG
+
+static int __init suspend_dbg_setup(char *str)
+{
+	if(str)
+		suspend_debug_state=simple_strtol(str,NULL,0);
+	set_suspend_state(SUSPEND_DBG_USED);
+	return 0;
+}
+
+/*
+ * Allow the user to set the debug level parameter from lilo, prior to
+ * resuming.
+ */
+static int __init suspend_lvl_setup(char *str)
+{
+	if(str)
+		console_loglevel =
+		suspend_default_console_level = 
+			simple_strtol(str,NULL,0);
+	set_suspend_state(SUSPEND_LVL_USED);
+	clear_suspend_state(SUSPEND_IGNORE_LOGLEVEL);
+	return 0;
+}
+
+__setup("suspend_dbg=", suspend_dbg_setup);
+__setup("suspend_lvl=", suspend_lvl_setup);
+#endif
+
+__setup("noresume2", noresume_setup);
+__setup("suspend_retry_resume", suspend2_retry_resume_setup);
+
+late_initcall(core_load);
+EXPORT_SYMBOL(software_suspend_state);

