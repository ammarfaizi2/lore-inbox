Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261706AbVGFDzl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261706AbVGFDzl (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:55:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261628AbVGFDwe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:52:34 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:10393 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262077AbVGFCTd convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:33 -0400
Subject: [PATCH] [34/48] Suspend2 2.1.9.8 for 2.6.12: 610-extent.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <1120616443531@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 611-io.patch-old/kernel/power/suspend2_core/io.c 611-io.patch-new/kernel/power/suspend2_core/io.c
--- 611-io.patch-old/kernel/power/suspend2_core/io.c	1970-01-01 10:00:00.000000000 +1000
+++ 611-io.patch-new/kernel/power/suspend2_core/io.c	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,1006 @@
+/*
+ * kernel/power/io.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains high level IO routines for suspending.
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/version.h>
+#include <linux/utsname.h>
+
+#include "version.h"
+#include "plugins.h"
+#include "pageflags.h"
+#include "io.h"
+#include "ui.h"
+#include "suspend2_common.h"
+#include "suspend.h"
+
+/* attempt_to_parse_resume_device
+ *
+ * Can we suspend, using the current resume2= parameter?
+ */
+void attempt_to_parse_resume_device(void)
+{
+	struct list_head *writer;
+	struct suspend_plugin_ops * this_writer;
+	int result = 0;
+
+	active_writer = NULL;
+	clear_suspend_state(SUSPEND_RESUME_DEVICE_OK);
+	set_suspend_state(SUSPEND_DISABLED);
+	CLEAR_RESULT_STATE(SUSPEND_ABORTED);
+
+	if (!num_writers) {
+		printk(name_suspend "No writers have been registered. Suspending will be disabled.\n");
+		return;
+	}
+	
+	if (!resume2_file[0]) {
+		printk(name_suspend "Resume2 parameter is empty. Suspending will be disabled.\n");
+		return;
+	}
+
+	list_for_each(writer, &suspend_writers) {
+		this_writer = list_entry(writer, struct suspend_plugin_ops,
+				ops.writer.writer_list);
+
+		/* 
+		 * Not sure why you'd want to disable a writer, but
+		 * we should honour the flag if we're providing it
+		 */
+		if (this_writer->disabled) {
+			printk(name_suspend
+					"Writer '%s' is disabled. Ignoring it.\n",
+					this_writer->name);
+			continue;
+		}
+
+		result = this_writer->ops.writer.parse_image_location(
+				resume2_file, (num_writers == 1));
+
+		switch (result) {
+			case -EINVAL:
+				/* 
+				 * For this writer, but not a valid 
+				 * configuration. Error already printed.
+				 */
+
+				return;
+
+			case 0:
+				/*
+				 * For this writer and valid.
+				 */
+
+				active_writer = this_writer;
+
+				set_suspend_state(SUSPEND_RESUME_DEVICE_OK);
+				clear_suspend_state(SUSPEND_DISABLED);
+				printk(name_suspend "Suspending enabled.\n");
+
+				return;
+		}
+	}
+	printk(name_suspend "No matching enabled writer found. Suspending disabled.\n");
+}
+
+/* suspend2_cleanup_finished_io
+ *
+ * Description:	Very simple helper function to save #including all the
+ * 		suspend code in fs/buffer.c and anywhere else we might
+ * 		want to wait on suspend I/O in future.
+ */
+
+void suspend2_cleanup_finished_io(void)
+{
+	active_writer->ops.writer.wait_on_io(0);
+}
+
+/* noresume_reset_plugins
+ *
+ * Description:	When we read the start of an image, plugins (and especially the
+ * 		active writer) might need to reset data structures if we decide
+ * 		to invalidate the image rather than resuming from it.
+ */
+
+static void noresume_reset_plugins(void)
+{
+	struct suspend_plugin_ops * this_filter;
+	
+	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+		if (this_filter->ops.filter.noresume_reset)
+			this_filter->ops.filter.noresume_reset();
+	}
+
+	if (active_writer && active_writer->ops.writer.noresume_reset)
+		active_writer->ops.writer.noresume_reset();
+}
+
+/* fill_suspend_header()
+ * 
+ * Description:	Fill the suspend header structure.
+ * Arguments:	struct suspend_header: Header data structure to be filled.
+ */
+
+static void fill_suspend_header(struct suspend_header *sh)
+{
+	int i;
+	
+	memset((char *)sh, 0, sizeof(*sh));
+
+	sh->version_code = LINUX_VERSION_CODE;
+	sh->num_physpages = num_physpages;
+	sh->orig_mem_free = suspend2_orig_mem_free;
+	strncpy(sh->machine, system_utsname.machine, 65);
+	strncpy(sh->version, system_utsname.version, 65);
+	sh->num_cpus = num_online_cpus();
+	sh->page_size = PAGE_SIZE;
+	sh->pagedir = pagedir1;
+	sh->pageset_2_size = pagedir2.pageset_size;
+	sh->param0 = suspend_result;
+	sh->param1 = suspend_action;
+	sh->param2 = suspend_debug_state;
+	sh->param3 = console_loglevel;
+	for (i = 0; i < 4; i++)
+		sh->io_time[i/2][i%2] =
+		       suspend_io_time[i/2][i%2];
+}
+
+/* write_pageset()
+ *
+ * Description:	Write a pageset to disk.
+ * Arguments:	pagedir:	Pointer to the pagedir to be saved.
+ * 		whichtowrite:	Controls what debugging output is printed.
+ * Returns:	Zero on success or -1 on failure.
+ */
+
+int write_pageset(struct pagedir * pagedir, int whichtowrite)
+{
+	int nextupdate = 0, size, ret = 0, i, base = 0;
+	int barmax = pagedir1.pageset_size + pagedir2.pageset_size;
+	int start_time, end_time, pc, step = 1;
+	long error = 0;
+	struct suspend_plugin_ops * this_plugin, * first_filter = get_next_filter(NULL);
+	dyn_pageflags_t *pageflags;
+	int current_page_index = -1;
+
+	size = pagedir->pageset_size;
+	if (!size)
+		return 0;
+
+	if (whichtowrite == 1) {
+		suspend2_prepare_status(1, 0, "Writing kernel & process data...");
+		base = pagedir2.pageset_size;
+		if (TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
+			pageflags = &pageset1_map;
+		else
+			pageflags = &pageset1_copy_map;
+	} else {
+		suspend2_prepare_status(1, 1, "Writing caches...");
+		pageflags = &pageset2_map;
+		bytes_in = bytes_out = 0;
+	}	
+	
+	start_time = jiffies;
+
+	/* Initialise page transformers */
+	list_for_each_entry(this_plugin, &suspend_filters, ops.filter.filter_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->write_init)
+			if (this_plugin->write_init(whichtowrite)) {
+				SET_RESULT_STATE(SUSPEND_ABORTED);
+				goto write_pageset_free_buffers;
+			}
+	}
+
+	/* Initialise writer */
+	active_writer->write_init(whichtowrite);
+
+	/* Initialise other plugins */
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if ((this_plugin->type == FILTER_PLUGIN) ||
+		    (this_plugin->type == WRITER_PLUGIN))
+			continue;
+		if (this_plugin->write_init)
+			if (this_plugin->write_init(whichtowrite)) {
+				SET_RESULT_STATE(SUSPEND_ABORTED);
+				goto write_pageset_free_buffers;
+			}
+	}
+
+	current_page_index = __get_next_bit_on(*pageflags, -1);
+
+	pc = size / 5;
+
+	/* Write the data */
+	for (i=0; i<size; i++) {
+		int was_mapped = 0;
+		struct page * page = pfn_to_page(current_page_index);
+
+		/* Status update */
+		if ((i+base) >= nextupdate)
+			nextupdate = suspend2_update_status(i + base, barmax, 
+				" %d/%d MB ", MB(base+i+1), MB(barmax));
+
+		if ((i + 1) == pc) {
+			printk("%d%%...", 20 * step);
+			step++;
+			pc = size * step / 5;
+		}
+
+		/* Write */
+		was_mapped = suspend_map_kernel_page(page, 1);
+		ret = first_filter->ops.filter.write_chunk(page);
+		if (!was_mapped)
+			suspend_map_kernel_page(page, 0);
+
+		if (ret) {
+			printk("Write chunk returned %d.\n", ret);
+			abort_suspend("Failed to write a chunk of the "
+					"image.");
+			error = -1;
+			goto write_pageset_free_buffers;
+		}
+
+		/* Interactivity */
+		check_shift_keys(0, NULL);
+
+		if (TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+			abort_suspend("Aborting as requested.");
+			error = -1;
+			goto write_pageset_free_buffers;
+		}
+
+		/* Prepare next */
+		current_page_index = __get_next_bit_on(*pageflags, current_page_index);
+	}
+
+	printk("done.\n");
+
+	suspend2_update_status(base+size, barmax, " %d/%d MB ",
+			MB(base+size), MB(barmax));
+
+write_pageset_free_buffers:
+	
+	/* Cleanup other plugins */
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if ((this_plugin->type == FILTER_PLUGIN) ||
+		    (this_plugin->type == WRITER_PLUGIN))
+			continue;
+		if (this_plugin->write_cleanup)
+			this_plugin->write_cleanup();
+	}
+
+	/* Flush data and cleanup */
+	list_for_each_entry(this_plugin, &suspend_filters, ops.filter.filter_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->write_cleanup)
+			this_plugin->write_cleanup();
+	}
+	active_writer->write_cleanup();
+
+	/* Statistics */
+	end_time = jiffies;
+	
+	if ((end_time - start_time) && (!TEST_RESULT_STATE(SUSPEND_ABORTED))) {
+		suspend_io_time[0][0] += size,
+		suspend_io_time[0][1] += (end_time - start_time);
+	}
+
+	return error;
+}
+
+/* read_pageset()
+ *
+ * Description:	Read a pageset from disk.
+ * Arguments:	pagedir:	Pointer to the pagedir to be saved.
+ * 		whichtowrite:	Controls what debugging output is printed.
+ * 		overwrittenpagesonly: Whether to read the whole pageset or
+ * 		only part.
+ * Returns:	Zero on success or -1 on failure.
+ */
+
+static int read_pageset(struct pagedir * pagedir, int whichtoread,
+		int overwrittenpagesonly)
+{
+	int nextupdate = 0, result = 0, base = 0;
+	int start_time, end_time, finish_at = pagedir->pageset_size;
+	int barmax = pagedir1.pageset_size + pagedir2.pageset_size;
+	int i, pc, step = 1;
+	struct suspend_plugin_ops * this_plugin, * first_filter = get_next_filter(NULL);
+	dyn_pageflags_t *pageflags;
+	int current_page_index;
+
+	if (whichtoread == 1) {
+		suspend2_prepare_status(1, 1, "Reading kernel & process data...");
+		pageflags = &pageset1_copy_map;
+	} else {
+		suspend2_prepare_status(1, 0, "Reading caches...");
+		if (overwrittenpagesonly)
+			barmax = finish_at = min(pageset1_size, pageset2_size);
+		else {
+			base = pagedir1.pageset_size;
+		}
+		pageflags = &pageset2_map;
+	}	
+	
+	start_time=jiffies;
+
+	/* Initialise page transformers */
+	list_for_each_entry(this_plugin, &suspend_filters, ops.filter.filter_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->read_init && 
+				this_plugin->read_init(whichtoread)) {
+			abort_suspend("Failed to initialise a filter.");
+			result = 1;
+			goto read_pageset_free_buffers;
+		}
+	}
+
+	/* Initialise writer */
+	if (active_writer->read_init(whichtoread)) {
+		abort_suspend("Failed to initialise the writer."); 
+		result = 1;
+		goto read_pageset_free_buffers;
+	}
+
+	/* Initialise other plugins */
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if ((this_plugin->type == FILTER_PLUGIN) ||
+		    (this_plugin->type == WRITER_PLUGIN))
+			continue;
+		if (this_plugin->read_init)
+			if (this_plugin->read_init(whichtoread)) {
+				SET_RESULT_STATE(SUSPEND_ABORTED);
+				goto read_pageset_free_buffers;
+			}
+	}
+
+	current_page_index = __get_next_bit_on(*pageflags, -1);
+
+	pc = finish_at / 5;
+
+	/* Read the pages */
+	for (i=0; i< finish_at; i++) {
+		int was_mapped = 0;
+		struct page * page = pfn_to_page(current_page_index);
+
+		/* Status */
+		if ((i+base) >= nextupdate)
+			nextupdate = suspend2_update_status(i+base, barmax,
+				" %d/%d MB ", MB(base+i+1), MB(barmax));
+
+		if ((i + 1) == pc) {
+			printk("%d%%...", 20 * step);
+			step++;
+			pc = finish_at * step / 5;
+		}
+		
+		was_mapped = suspend_map_kernel_page(page, 1);
+		result = first_filter->ops.filter.read_chunk(page, SUSPEND_ASYNC);
+		if (!was_mapped)
+			suspend_map_kernel_page(page, 0);
+
+		if (result) {
+			panic("Failed to read chunk %d/%d of the image. (%d)",
+					i, finish_at, result);
+			goto read_pageset_free_buffers;
+		}
+
+		/* Interactivity*/
+		check_shift_keys(0, NULL);
+
+		/* Prepare next */
+		current_page_index = __get_next_bit_on(*pageflags, current_page_index);
+	}
+
+	printk("done.\n");
+
+	suspend2_update_status(base+finish_at, barmax, " %d/%d MB ",
+			MB(base+finish_at), MB(barmax));
+
+read_pageset_free_buffers:
+
+	/* Cleanup other plugins */
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if ((this_plugin->type == FILTER_PLUGIN) ||
+		    (this_plugin->type == WRITER_PLUGIN))
+			continue;
+		if (this_plugin->read_cleanup)
+			this_plugin->read_cleanup();
+	}
+
+	/* Finish I/O, flush data and cleanup reads. */
+	list_for_each_entry(this_plugin, &suspend_filters, ops.filter.filter_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->read_cleanup &&
+				this_plugin->read_cleanup()) {
+			abort_suspend("Failed to cleanup a filter.");
+			result = 1;
+		}
+	}
+
+	if (active_writer->read_cleanup()) {
+		abort_suspend("Failed to cleanup the writer.");
+		result = 1;
+	}
+
+	/* Statistics */
+	end_time=jiffies;
+	if ((end_time - start_time) && (!TEST_RESULT_STATE(SUSPEND_ABORTED))) {
+		suspend_io_time[1][0] += finish_at,
+		suspend_io_time[1][1] += (end_time - start_time);
+	}
+
+	return result;
+}
+
+/* write_plugin_configs()
+ *
+ * Description:	Store the configuration for each plugin in the image header.
+ * Returns:	Int: Zero on success, Error value otherwise.
+ */
+static int write_plugin_configs(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+	char * buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	int len, index = 1;
+	struct plugin_header plugin_header;
+
+	if (!buffer) {
+		printk("Failed to allocate a buffer for saving "
+				"plugin configuration info.\n");
+		return -ENOMEM;
+	}
+		
+	/* 
+	 * We have to know which data goes with which plugin, so we at
+	 * least write a length of zero for a plugin. Note that we are
+	 * also assuming every plugin's config data takes <= PAGE_SIZE.
+	 */
+
+	/* For each plugin (in registration order) */
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+
+		/* Get the data from the plugin */
+		len = 0;
+		if (this_plugin->save_config_info)
+			len = this_plugin->save_config_info(buffer);
+
+		/* Save the details of the plugin */
+		plugin_header.disabled = this_plugin->disabled;
+		plugin_header.type = this_plugin->type;
+		plugin_header.index = index++;
+		strncpy(plugin_header.name, this_plugin->name, 
+					sizeof(plugin_header.name));
+		active_writer->ops.writer.write_header_chunk(
+				(char *) &plugin_header,
+				sizeof(plugin_header));
+
+		/* Save the size of the data and any data returned */
+		active_writer->ops.writer.write_header_chunk((char *) &len,
+				sizeof(int));
+		if (len)
+			active_writer->ops.writer.write_header_chunk(
+					buffer, len);
+	}
+
+	/* Write a blank header to terminate the list */
+	plugin_header.name[0] = '\0';
+	active_writer->ops.writer.write_header_chunk(
+			(char *) &plugin_header,
+			sizeof(plugin_header));
+
+	free_pages((unsigned long) buffer, 0);
+	return 0;
+}
+
+/* read_plugin_configs()
+ *
+ * Description:	Reload plugin configurations from the image header.
+ * Returns:	Int. Zero on success, error value otherwise.
+ */
+
+static int read_plugin_configs(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+	char * buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	int len, result = 0;
+	struct plugin_header plugin_header;
+
+	if (!buffer) {
+		printk("Failed to allocate a buffer for reloading plugin "
+				"configuration info.\n");
+		return -ENOMEM;
+	}
+		
+	/* All plugins are initially disabled. That way, if we have a plugin
+	 * loaded now that wasn't loaded when we suspended, it won't be used
+	 * in trying to read the data.
+	 */
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list)
+		this_plugin->disabled = 1;
+	
+	/* Get the first plugin header */
+	result = active_writer->ops.writer.read_header_chunk(
+			(char *) &plugin_header, sizeof(plugin_header));
+	if (!result) {
+		printk("Failed to read the next plugin header.\n");
+		free_pages((unsigned long) buffer, 0);
+		return -EINVAL;
+	}
+
+	/* For each plugin (in registration order) */
+	while (plugin_header.name[0]) {
+		
+		/* Find the plugin */
+		this_plugin = find_plugin_given_name(plugin_header.name);
+		
+		if (!this_plugin) {
+			/* 
+			 * Is it used? Only need to worry about filters. The active
+			 * writer must be loaded!
+			 */
+			if ((!plugin_header.disabled) &&
+			    (plugin_header.type == FILTER_PLUGIN)) {
+				suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+					"It looks like we need plugin %s for "
+					"reading the image but it hasn't been "
+					"registered.\n",
+					plugin_header.name);
+				if (!(test_suspend_state(SUSPEND_CONTINUE_REQ))) {
+					active_writer->ops.writer.invalidate_image();
+					result = -EINVAL;
+					noresume_reset_plugins();
+					free_pages((unsigned long) buffer, 0);
+					return -EINVAL;
+				}
+			} else
+				printk("Plugin %s configuration data found, but the plugin "
+					"hasn't registered. Looks like it was disabled, so "
+					"we're ignoring it's data.",
+					plugin_header.name);
+		}
+		
+		/* Get the length of the data (if any) */
+		result = active_writer->ops.writer.read_header_chunk(
+				(char *) &len, sizeof(int));
+		if (!result) {
+			printk("Failed to read the length of the plugin %s's"
+					" configuration data.\n",
+					plugin_header.name);
+			free_pages((unsigned long) buffer, 0);
+			return -EINVAL;
+		}
+
+		/* Read any data and pass to the plugin (if we found one) */
+		if (len) {
+			active_writer->ops.writer.read_header_chunk(buffer, len);
+			if (this_plugin) {
+				if (!this_plugin->save_config_info) {
+					printk("Huh? Plugin %s appears to have a "
+						"save_config_info, but not a "
+						"load_config_info function!\n",
+						this_plugin->name);
+				} else
+					this_plugin->load_config_info(buffer, len);
+			}
+		}
+
+		if (this_plugin) {
+			/* Now move this plugin to the tail of its lists. This will put it
+			 * in order. Any new plugins will end up at the top of the lists.
+			 * They should have been set to disabled when loaded (people will
+			 * normally not edit an initrd to load a new module and then
+			 * suspend without using it!).
+			 */
+
+			suspend_move_plugin_tail(this_plugin);
+
+			/* 
+			 * We apply the disabled state; plugins don't need to save whether they
+			 * were disabled and if they do, we override them anyway.
+			 */
+			this_plugin->disabled = plugin_header.disabled;
+		}
+
+		/* Get the next plugin header */
+		result = active_writer->ops.writer.read_header_chunk(
+				(char *) &plugin_header, sizeof(plugin_header));
+
+		if (!result) {
+			printk("Failed to read the next plugin header.\n");
+			free_pages((unsigned long) buffer, 0);
+			return -EINVAL;
+		}
+
+	}
+
+	free_pages((unsigned long) buffer, 0);
+	return 0;
+}
+
+/* write_image_header()
+ *
+ * Description:	Write the image header after write the image proper.
+ * Returns:	Int. Zero on success or -1 on failure.
+ */
+
+int write_image_header(void)
+{
+	int ret;
+	int total = pagedir1.pageset_size + pagedir2.pageset_size+2;
+	char * header_buffer = NULL;
+
+	/* Now prepare to write the header */
+	if ((ret = active_writer->ops.writer.write_header_init())) {
+		abort_suspend("Active writer's write_header_init"
+				" function failed.");
+		goto write_image_header_abort;
+	}
+
+	/* Get a buffer */
+	header_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	if (!header_buffer) {
+		abort_suspend("Out of memory when trying to get page "
+				"for header!");
+		goto write_image_header_abort;
+	}
+
+	/* Write suspend header */
+	fill_suspend_header((struct suspend_header *) header_buffer);
+	active_writer->ops.writer.write_header_chunk(header_buffer,
+			sizeof(struct suspend_header));
+
+	free_pages((unsigned long) header_buffer, 0);
+
+	/* Write plugin configurations */
+	if ((ret = write_plugin_configs())) {
+		abort_suspend("Failed to write plugin configs.");
+		goto write_image_header_abort;
+	}
+
+	save_dyn_pageflags(pageset1_map);
+
+	if ((ret = active_writer->ops.writer.serialise_extents())) {
+		abort_suspend("Active writer's prepare_save_extents "
+				"function failed.");
+		goto write_image_header_abort;
+	}
+
+	/* Flush data and let writer cleanup */
+	if (active_writer->ops.writer.write_header_cleanup()) {
+		abort_suspend("Failed to cleanup writing header.");
+		goto write_image_header_abort_no_cleanup;
+	}
+
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto write_image_header_abort_no_cleanup;
+
+	suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1, "|\n");
+	suspend2_update_status(total, total, NULL);
+
+	return 0;
+
+write_image_header_abort:
+	active_writer->ops.writer.write_header_cleanup();
+write_image_header_abort_no_cleanup:
+	return -1;
+}
+
+/* sanity_check()
+ *
+ * Description:	Perform a few checks, seeking to ensure that the kernel being
+ * 		booted matches the one suspended. They need to match so we can
+ * 		be _sure_ things will work. It is not absolutely impossible for
+ * 		resuming from a different kernel to work, just not assured.
+ * Arguments:	Struct suspend_header. The header which was saved at suspend
+ * 		time.
+ */
+static int sanity_check(struct suspend_header *sh)
+{
+	if (sh->version_code != LINUX_VERSION_CODE)
+		return suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+				"Incorrect kernel version");
+	
+	if (sh->num_physpages != num_physpages)
+		return suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+				"Incorrect memory size");
+
+	if (strncmp(sh->machine, system_utsname.machine, 65))
+		return suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+				"Incorrect machine type");
+
+	if (strncmp(sh->version, system_utsname.version, 65))
+		return suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+			      "Incorrect version");
+
+	if (sh->num_cpus != num_online_cpus())
+		return suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,  
+				"Incorrect number of cpus");
+
+	if (sh->page_size != PAGE_SIZE)
+		return suspend_early_boot_message(1, SUSPEND_CONTINUE_REQ,
+				"Incorrect PAGE_SIZE");
+
+	return 0;
+}
+
+/* __read_pageset1
+ *
+ * Description:	Test for the existence of an image and attempt to load it.
+ * Returns:	Int. Zero if image found and pageset1 successfully loaded.
+ * 		Error if no image found or loaded.
+ */
+static int __read_pageset1(void)
+{			
+	int i, result = 0;
+	char * header_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	struct suspend_header * suspend_header;
+
+	if (!header_buffer)
+		return -ENOMEM;
+	
+	/* Check for an image */
+	if (!(result = active_writer->ops.writer.image_exists())) {
+		result = -ENODATA;
+		noresume_reset_plugins();
+		goto out;
+	}
+
+	/* Check for noresume command line option */
+	if (test_suspend_state(SUSPEND_NORESUME_SPECIFIED)) {
+		active_writer->ops.writer.invalidate_image();
+		result = -EINVAL;
+		noresume_reset_plugins();
+		goto out;
+	}
+
+#ifdef CONFIG_SOFTWARE_SUSPEND_CHECK_RESUME_SAFE
+	/* Check whether we've got filesystems mounted that make
+	 * resuming unsafe */
+
+	suspend_check_mounts();
+
+	if (!test_suspend_state(SUSPEND_CONTINUE_REQ)) {
+		active_writer->ops.writer.invalidate_image();
+		result = -EINVAL;
+		noresume_reset_plugins();
+		goto out;
+	}
+
+	clear_suspend_state(SUSPEND_CONTINUE_REQ);
+#endif
+
+	/* Check whether we've resumed before */
+	if (test_suspend_state(SUSPEND_RESUMED_BEFORE)) {
+		int resumed_before_default = 0;
+		if (test_suspend_state(SUSPEND_RETRY_RESUME))
+			resumed_before_default = SUSPEND_CONTINUE_REQ;
+		suspend_early_boot_message(1, resumed_before_default, NULL);
+		clear_suspend_state(SUSPEND_RETRY_RESUME);
+		if (!(test_suspend_state(SUSPEND_CONTINUE_REQ))) {
+			active_writer->ops.writer.invalidate_image();
+			result = -EINVAL;
+			noresume_reset_plugins();
+			goto out;
+		}
+	}
+
+	clear_suspend_state(SUSPEND_CONTINUE_REQ);
+
+	/* 
+	 * Prepare the active writer for reading the image header. The
+	 * activate writer might read its own configuration or set up
+	 * a network connection here.
+	 * 
+	 * NB: This call may never return because there might be a signature
+	 * for a different image such that we warn the user and they choose
+	 * to reboot. (If the device ids look erroneous (2.4 vs 2.6) or the
+	 * location of the image might be unavailable if it was stored on a
+	 * network connection.
+	 */
+
+	if ((result = active_writer->ops.writer.read_header_init())) {
+		noresume_reset_plugins();
+		goto out;
+	}
+	
+	/* Read suspend header */
+	if ((result = active_writer->ops.writer.read_header_chunk(
+			header_buffer, sizeof(struct suspend_header))) < 0) {
+		noresume_reset_plugins();
+		goto out;
+	}
+	
+	suspend_header = (struct suspend_header *) header_buffer;
+
+	/*
+	 * NB: This call may also result in a reboot rather than returning.
+	 */
+
+	if (sanity_check(suspend_header)) { /* Is this the same machine? */
+		active_writer->ops.writer.invalidate_image();
+		result = -EINVAL;
+		noresume_reset_plugins();
+		goto out;
+	}
+
+	/*
+	 * ---------------------------------------------------- 
+	 * We have an image and it looks like it will load okay.
+	 * ---------------------------------------------------- 
+	 */
+
+	/* Get metadata from header. Don't override commandline parameters.
+	 *
+	 * We don't need to save the image size limit because it's not used
+	 * during resume and will be restored with the image anyway.
+	 */
+	
+	suspend2_orig_mem_free = suspend_header->orig_mem_free;
+	memcpy((char *) &pagedir1,
+		(char *) &suspend_header->pagedir, sizeof(pagedir1));
+	suspend_result = suspend_header->param0;
+	if (!test_suspend_state(SUSPEND_ACT_USED))
+		suspend_action = suspend_header->param1;
+	if (!test_suspend_state(SUSPEND_DBG_USED))
+		suspend_debug_state = suspend_header->param2;
+	if (!test_suspend_state(SUSPEND_LVL_USED))
+		suspend_default_console_level = suspend_header->param3;
+	clear_suspend_state(SUSPEND_IGNORE_LOGLEVEL);
+	pagedir2.pageset_size = suspend_header->pageset_2_size;
+	for (i = 0; i < 4; i++)
+		suspend_io_time[i/2][i%2] =
+			suspend_header->io_time[i/2][i%2];
+
+	set_suspend_state(SUSPEND_NOW_RESUMING);
+
+	/* Read plugin configurations */
+	if ((result = read_plugin_configs())) {
+		noresume_reset_plugins();
+		pagedir1.pageset_size =
+			pagedir2.pageset_size = 0;
+		goto out;
+	}
+
+	suspend2_prepare_console();
+
+	check_shift_keys(1, "About to read original pageset1 locations.");
+	/* Read original pageset1 locations. These are the addresses we can't use for
+	 * the data to be restored */
+	suspend_allocate_dyn_pageflags(&pageset1_map);
+	load_dyn_pageflags(pageset1_map);
+
+	/* Relocate it so that it's not overwritten while we're using it to
+	 * copy the original contents back */
+	relocate_dyn_pageflags(&pageset1_map);
+	
+	suspend_allocate_dyn_pageflags(&pageset1_copy_map);
+	relocate_dyn_pageflags(&pageset1_copy_map);
+
+	/* Read extent pages */
+	if ((result = active_writer->ops.writer.load_extents())) {
+		noresume_reset_plugins();
+		abort_suspend("Active writer's load_extents "
+				"function failed.");
+		goto out;
+	}
+
+	/* Clean up after reading the header */
+	if ((result = active_writer->ops.writer.read_header_cleanup())) {
+		noresume_reset_plugins();
+		goto out;
+	}
+
+	check_shift_keys(1, "About to read pagedir.");
+
+	/* 
+	 * Get the addresses of pages into which we will load the kernel to
+	 * be copied back
+	 */
+	if (suspend2_get_pageset1_load_addresses()) {
+		result = -ENOMEM;
+		noresume_reset_plugins();
+		goto out;
+	}
+
+	/* Read the original kernel back */
+	check_shift_keys(1, "About to read pageset 1.");
+
+	if (read_pageset(&pagedir1, 1, 0)) {
+		suspend2_prepare_status(1, 1, "Failed to read pageset 1.");
+		result = -EPERM;
+		noresume_reset_plugins();
+		goto out;
+	}
+
+	check_shift_keys(1, "About to restore original kernel.");
+	result = 0;
+
+	if (active_writer->ops.writer.mark_resume_attempted)
+		active_writer->ops.writer.mark_resume_attempted();
+
+out:
+	free_pages((unsigned long) header_buffer, 0);
+	return result;
+}
+
+/* read_pageset1()
+ *
+ * Description:	Attempt to read the header and pageset1 of a suspend image.
+ * 		Handle the outcome, complaining where appropriate.
+ */
+int read_pageset1(void)
+{
+	int error;
+
+	error = __read_pageset1();
+
+	switch (error) {
+		case 0:
+		case -ENODATA:
+		case -EINVAL:	/* non fatal error */
+			return error;
+		case -EIO:
+			printk(KERN_CRIT name_suspend "I/O error\n");
+			break;
+		case -ENOENT:
+			printk(KERN_CRIT name_suspend "No such file or directory\n");
+			break;
+		case -EPERM:
+			printk(KERN_CRIT name_suspend "Sanity check error\n");
+			break;
+		default:
+			printk(KERN_CRIT name_suspend "Error %d resuming\n", error);
+			break;
+	}
+	abort_suspend("Error %d in read_pageset1",error);
+	return error;
+}
+
+/* read_pageset2()
+ *
+ * Description:	Read in part or all of pageset2 of an image, depending upon
+ * 		whether we are suspending and have only overwritten a portion
+ * 		with pageset1 pages, or are resuming and need to read them 
+ * 		all.
+ * Arguments:	Int. Boolean. Read only pages which would have been
+ * 		overwritten by pageset1?
+ * Returns:	Int. Zero if no error, otherwise the error value.
+ */
+int read_pageset2(int overwrittenpagesonly)
+{
+	int result = 0;
+
+	if (!pageset2_size)
+		return 0;
+
+	result = read_pageset(&pagedir2, 2, overwrittenpagesonly);
+
+	suspend2_update_status(100, 100, NULL);
+	check_shift_keys(1, "Pagedir 2 read.");
+
+	return result;
+}
diff -ruNp 611-io.patch-old/kernel/power/suspend2_core/io.h 611-io.patch-new/kernel/power/suspend2_core/io.h
--- 611-io.patch-old/kernel/power/suspend2_core/io.h	1970-01-01 10:00:00.000000000 +1000
+++ 611-io.patch-new/kernel/power/suspend2_core/io.h	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,44 @@
+/*
+ * kernel/power/io.h
+ */
+
+#include "pagedir.h"
+
+/* Non-plugin data saved in our image header */
+struct suspend_header {
+	u32 version_code;
+	unsigned long num_physpages;
+	unsigned long orig_mem_free;
+	char machine[65];
+	char version[65];
+	int num_cpus;
+	int page_size;
+	int pageset_2_size;
+	int param0;
+	int param1;
+	int param2;
+	int param3;
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
+extern int write_pageset(struct pagedir * pagedir, int whichtowrite);
+extern int write_image_header(void);
+extern int read_pageset1(void);
+extern int read_pageset2(int overwrittenpagesonly);
+
+extern void attempt_to_parse_resume_device(void);
+extern dev_t name_to_dev_t(char *line);
+extern __nosavedata unsigned long bytes_in, bytes_out;
+

