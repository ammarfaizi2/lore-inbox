Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262571AbUKXONE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262571AbUKXONE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 09:13:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262709AbUKXOMi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 09:12:38 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:40087 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262706AbUKXNbF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 08:31:05 -0500
Subject: Suspend 2 merge: 36/51: Highlevel I/O routines.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101298276.5805.334.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:00:33 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Highlevel routines for doing I/O. These routines are designed to know
nothing about how and where the data is actually saved. Here, we just
focus on asking our writer to write data for us and get it back from
storage.

diff -ruN 826-io-old/kernel/power/io.c 826-io-new/kernel/power/io.c
--- 826-io-old/kernel/power/io.c	1970-01-01 10:00:00.000000000 +1000
+++ 826-io-new/kernel/power/io.c	2004-11-13 19:28:57.000000000 +1100
@@ -0,0 +1,1095 @@
+/*
+ * kernel/power/io.c
+ *
+ * Copyright (C) 1998-2001 Gabor Kuti <seasons@fornax.hu>
+ * Copyright (C) 1998,2001,2002 Pavel Machek <pavel@suse.cz>
+ * Copyright (C) 2002-2003 Florent Chabaud <fchabaud@free.fr>
+ * Copyright (C) 2002-2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ * This file is released under the GPLv2.
+ *
+ * It contains high level IO routines for suspend.
+ *
+ */
+
+#define SUSPEND_IO_C
+
+#include <linux/suspend.h>
+#include <linux/version.h>
+#include <linux/mm.h>
+#include <linux/utsname.h>
+
+#include "suspend.h"
+#include "plugins.h"
+
+/* Variables saved in the suspend header */
+extern unsigned long orig_mem_free;
+extern int suspend_act_used;
+extern int suspend_lvl_used;
+extern int suspend_dbg_used;
+extern volatile int suspend_io_time[2][2];
+
+extern struct pagedir __nosavedata pagedir_resume;
+extern struct range * unused_ranges;
+extern int suspend2_prepare_console(void);
+
+/* Routines we call when reloading the original kernel */
+extern void warmup_collision_cache(void);
+extern int get_pageset1_load_addresses(void);
+
+extern void get_next_pbe(struct pbe2 * pbe);
+extern void get_first_pbe(struct pbe2 * pbe, struct pagedir * pagedir);
+
+static void noresume_reset_plugins(void);
+
+/* cleanup_finished_suspend_io
+ *
+ * Description:	Very simple helper function to save #including all the
+ * 		suspend code in fs/buffer.c and anywhere else we might
+ * 		want to wait on suspend I/O in future.
+ */
+
+void cleanup_finished_suspend_io(void)
+{
+	active_writer->ops.writer.wait_on_io(0);
+}
+
+/* fill_suspend_header()
+ * 
+ * Description:	Fill the suspend header structure.
+ * Arguments:	struct suspend_header: Header data structure to be filled.
+ */
+
+static __inline__ void fill_suspend_header(struct suspend_header *sh)
+{
+	int i;
+	
+	memset((char *)sh, 0, sizeof(*sh));
+
+	sh->version_code = LINUX_VERSION_CODE;
+	sh->num_physpages = num_physpages;
+	sh->orig_mem_free = orig_mem_free;
+	strncpy(sh->machine, system_utsname.machine, 65);
+	strncpy(sh->version, system_utsname.version, 65);
+	sh->num_cpus = num_online_cpus();
+	sh->page_size = PAGE_SIZE;
+	sh->pagedir = pagedir1;
+	sh->pagedir.origranges.first = pagedir1.origranges.first;
+	sh->pagedir.destranges.first = pagedir1.destranges.first;
+	sh->pagedir.allocdranges.first = pagedir1.allocdranges.first;
+	sh->unused_ranges = unused_ranges;
+	sh->num_range_pages = num_range_pages;
+	sh->pageset_2_size = pagedir2.pageset_size;
+	sh->param0 = suspend_result;
+	sh->param1 = suspend_action;
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+	sh->param2 = suspend_debug_state;
+#endif
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
+	int start_time, end_time;
+	long error = 0;
+	struct pbe2 pbe;
+	unsigned int origfree = real_nr_free_pages();
+	struct suspend_plugin_ops * this_filter, * first_filter = get_next_filter(NULL);
+
+	PRINTFREEMEM("at start of write pageset");
+
+	size = pagedir->pageset_size;
+	if (!size)
+		return 0;
+
+	if (whichtowrite == 1) {
+		prepare_status(1, 0, "Writing kernel & process data...");
+		base = pagedir2.pageset_size;
+	} else {
+		prepare_status(1, 1, "Writing caches...");
+	}	
+	
+	start_time = jiffies;
+
+	/* Initialise page transformers */
+	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+		if (this_filter->disabled)
+			continue;
+		if (this_filter->ops.filter.write_init)
+			this_filter->ops.filter.write_init(whichtowrite);
+	}
+
+	PRINTFREEMEM("after initialising page transformers");
+
+	/* Initialise writer */
+	active_writer->ops.filter.write_init(whichtowrite);
+	PRINTFREEMEM("after initialising writer");
+
+	get_first_pbe(&pbe, pagedir);
+
+	/* Write the data */
+	for (i=0; i<size; i++) {
+		int was_mapped = 0;
+		/* Status update */
+		if (!(i&0x1FF)) 
+			suspend_message(SUSPEND_IO, SUSPEND_LOW, 1, ".");
+		if (((i+base) >= nextupdate) || 
+				(!(i%(1 << (20 - PAGE_SHIFT)))))
+			nextupdate = update_status(i + base, barmax, 
+				" %d/%d MB ", MB(base+i+1), MB(barmax));
+		if ((i == (size - 5)) &&
+			TEST_ACTION_STATE(SUSPEND_PAUSE_NEAR_PAGESET_END))
+			check_shift_keys(1, "Five more pages to write.");
+		suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1,
+				"Submitting page %d/%d.\n", i, size);
+
+		/* Write */
+		was_mapped = suspend_map_kernel_page(pbe.address, 1);
+		if (TEST_ACTION_STATE(SUSPEND_TEST_FILTER_SPEED))
+			ret = first_filter->ops.filter.write_chunk(pbe.origaddress);
+		else
+			ret = first_filter->ops.filter.write_chunk(pbe.address);
+		if (!was_mapped)
+			suspend_map_kernel_page(pbe.address, 0);
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
+		get_next_pbe(&pbe);
+	}
+
+	update_status(base+size, barmax, " %d/%d MB ",
+			MB(base+size), MB(barmax));
+	suspend_message(SUSPEND_IO, SUSPEND_LOW, 1, "|\n");
+	PRINTFREEMEM("after writing data");
+
+write_pageset_free_buffers:
+	
+	/* Flush data and cleanup */
+	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+		if (this_filter->disabled)
+			continue;
+		if (this_filter->ops.filter.write_cleanup)
+			this_filter->ops.filter.write_cleanup();
+	}
+	PRINTFREEMEM("after cleaning up transformers");
+	active_writer->ops.writer.write_cleanup();
+	PRINTFREEMEM("after cleaning up writer");
+
+	/* Statistics */
+	end_time = jiffies;
+	
+	if ((end_time - start_time) && (!TEST_RESULT_STATE(SUSPEND_ABORTED))) {
+		suspend_message(SUSPEND_IO, SUSPEND_LOW, 1,
+			"Time to write data: %d pages in %d jiffies => "
+			"MB written per second: %lu.\n", 
+			size,
+			(end_time - start_time), 
+			(MB((unsigned long) size) * HZ / (end_time - start_time)));
+		suspend_io_time[0][0] += size,
+		suspend_io_time[0][1] += (end_time - start_time);
+	}
+
+	PRINTFREEMEM("at end of write pageset");
+
+	/* Sanity checking */
+	if (real_nr_free_pages() != origfree) {
+		abort_suspend("Number of free pages at start and end of write "
+			"pageset don't match! (%d != %d)",
+			origfree, real_nr_free_pages());
+	}
+
+	suspend_store_free_mem(SUSPEND_FREE_IO, 0);
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
+int read_pageset(struct pagedir * pagedir, int whichtoread,
+		int overwrittenpagesonly)
+{
+	int nextupdate = 0, result = 0, base = 0;
+	int start_time, end_time, finish_at = pagedir->pageset_size;
+	int barmax = pagedir1.pageset_size + pagedir2.pageset_size;
+	int i;
+	struct pbe2 pbe;
+	struct suspend_plugin_ops * this_filter, * first_filter = get_next_filter(NULL);
+
+	PRINTFREEMEM("at start of read pageset");
+
+	if (whichtoread == 1) {
+		prepare_status(1, 1, "Reading kernel & process data...");
+	} else {
+		prepare_status(1, 0, "Reading caches...");
+		if (overwrittenpagesonly)
+			barmax = finish_at = min(pageset1_size, pageset2_size);
+		else {
+			base = pagedir1.pageset_size;
+		}
+	}	
+	
+	start_time=jiffies;
+
+	/* Initialise page transformers */
+	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+		if (this_filter->disabled)
+			continue;
+		if (this_filter->ops.filter.read_init && 
+				this_filter->ops.filter.read_init(whichtoread)) {
+			abort_suspend("Failed to initialise a filter.");
+			result = 1;
+			goto read_pageset_free_buffers;
+		}
+	}
+
+	/* Initialise writer */
+	if (active_writer->ops.writer.read_init(whichtoread)) {
+		abort_suspend("Failed to initialise the writer."); 
+		result = 1;
+		goto read_pageset_free_buffers;
+	}
+
+	get_first_pbe(&pbe, pagedir);
+
+	suspend_message(SUSPEND_IO, SUSPEND_LOW, 1,
+		"Attempting to read %d pages.\n", finish_at);
+
+	/* Read the pages */
+	for (i=0; i< finish_at; i++) {
+		int was_mapped = 0;
+		/* Status */
+		if (!(i&0x1FF)) 
+			suspend_message(SUSPEND_IO, SUSPEND_LOW, 1, ".");
+		if (((i+base) >= nextupdate) ||
+				(!(i%(1 << (20 - PAGE_SHIFT)))))
+			nextupdate = update_status(i+base, barmax,
+				" %d/%d MB ", MB(base+i+1), MB(barmax));
+		if ((i == (finish_at - 5)) &&
+			TEST_ACTION_STATE(SUSPEND_PAUSE_NEAR_PAGESET_END))
+			check_shift_keys(1, "Five more pages to read.");
+		suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1,
+				"Submitting page %d/%d.\n", i, finish_at);
+
+		was_mapped = suspend_map_kernel_page(pbe.address, 1);
+		result = first_filter->ops.filter.read_chunk(pbe.address, SUSPEND_ASYNC);
+		if (!was_mapped)
+			suspend_map_kernel_page(pbe.address, 0);
+
+		if (result) {
+			panic("Failed to read chunk %d/%d of the image.",
+					i, finish_at);
+			goto read_pageset_free_buffers;
+		}
+
+		/* Interactivity*/
+		check_shift_keys(0, NULL);
+
+		/* Prepare next */
+		get_next_pbe(&pbe);
+	}
+
+	update_status(base+finish_at, barmax, " %d/%d MB ",
+			MB(base+finish_at), MB(barmax));
+	suspend_message(SUSPEND_IO, SUSPEND_LOW, 1, "|\n");
+
+read_pageset_free_buffers:
+
+	/* Finish I/O, flush data and cleanup reads. */
+	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+		if (this_filter->disabled)
+			continue;
+		if (this_filter->ops.filter.read_cleanup &&
+				this_filter->ops.filter.read_cleanup()) {
+			abort_suspend("Failed to cleanup a filter.");
+			result = 1;
+		}
+	}
+
+	if (active_writer->ops.writer.read_cleanup()) {
+		abort_suspend("Failed to cleanup the writer.");
+		result = 1;
+	}
+
+	/* Statistics */
+	end_time=jiffies;
+	if ((end_time - start_time) && (!TEST_RESULT_STATE(SUSPEND_ABORTED))) {
+		suspend_message(SUSPEND_IO, SUSPEND_LOW, 1,
+			"Time to read data: %d pages in %d jiffies => "
+			"MB read per second: %lu.\n",
+			finish_at,
+			(end_time - start_time), 
+			(MB((unsigned long) finish_at) * HZ / 
+			 	(end_time - start_time)));
+		suspend_io_time[1][0] += finish_at,
+		suspend_io_time[1][1] += (end_time - start_time);
+	}
+
+	PRINTFREEMEM("at end of read pageset");
+
+	suspend_store_free_mem(SUSPEND_FREE_IO, 1);
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
+			if ((!plugin_header.disabled) && (plugin_header.type == FILTER_PLUGIN)) {
+				suspend_early_boot_message(1, "It looks like we need plugin %s for reading the image "
+						"but it hasn't been registered.\n",
+						plugin_header.name);
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
+	int i, nextupdate = 0, ret;
+	int total = pagedir1.pageset_size+pagedir2.pageset_size+2;
+	int progress = total-1;
+	char * header_buffer = NULL;
+
+	/* First, relativise all range information */
+	if (get_rangepages_list())
+		return -1;
+
+	if (unused_ranges)
+		unused_ranges = RANGE_RELATIVE(unused_ranges);
+	
+	relativise_chain(&pagedir1.origranges);
+	relativise_chain(&pagedir1.destranges);
+	relativise_chain(&pagedir1.allocdranges);
+
+	if ((ret = active_writer->ops.writer.prepare_save_ranges())) {
+		abort_suspend("Active writer's prepare_save_ranges "
+				"function failed.");
+		goto write_image_header_abort1;
+	}
+
+	relativise_ranges();
+
+	/* Now prepare to write the header */
+	if ((ret = active_writer->ops.writer.write_header_init())) {
+		abort_suspend("Active writer's write_header_init"
+				" function failed.");
+		goto write_image_header_abort2;
+	}
+
+	/* Get a buffer */
+	header_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	if (!header_buffer) {
+		abort_suspend("Out of memory when trying to get page "
+				"for header!");
+		goto write_image_header_abort3;
+	}
+
+	/* Write the meta data */
+	fill_suspend_header((struct suspend_header *) header_buffer);
+	active_writer->ops.writer.write_header_chunk(header_buffer,
+			sizeof(struct suspend_header));
+
+	/* Write plugin configurations */
+	if ((ret = write_plugin_configs())) {
+		abort_suspend("Failed to write plugin configs.");
+		goto write_image_header_abort3;
+	}
+
+	/* Write range pages */
+	suspend_message(SUSPEND_HEADER, SUSPEND_LOW, 1,
+		name_suspend "Writing %d range pages.\n",
+		num_range_pages);
+
+	for (i=1; i<=num_range_pages; i++) {
+		unsigned long * this_range_page = get_rangepages_list_entry(i);
+		/* Status update */
+		suspend_message(SUSPEND_HEADER, SUSPEND_VERBOSE, 1, "%d/%d: %p.\n",
+			i, num_range_pages, this_range_page);
+
+		if (i >= nextupdate)
+			nextupdate = update_status(progress + i, total, NULL);
+
+		/* Check for aborting/pausing */
+		check_shift_keys(0, NULL);
+
+		if (TEST_RESULT_STATE(SUSPEND_ABORTED)) {
+			abort_suspend("Aborting as requested.");
+			goto write_image_header_abort3;
+		}
+		
+		/* Write one range page */
+		active_writer->ops.writer.write_header_chunk(
+				(char *) this_range_page, PAGE_SIZE);
+		
+		if (ret) {
+			abort_suspend("Failed writing a page. "
+					"Error number was %d.", ret);
+			goto write_image_header_abort3;
+		}
+	}
+
+	update_status(total - 1, total, NULL);
+
+	/* Flush data and let writer cleanup */
+	if (active_writer->ops.writer.write_header_cleanup()) {
+		abort_suspend("Failed to cleanup writing header.");
+		goto write_image_header_abort2;
+	}
+
+	if (TEST_RESULT_STATE(SUSPEND_ABORTED))
+		goto write_image_header_abort2;
+
+	suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1, "|\n");
+	update_status(total, total, NULL);
+
+	MDELAY(1000);
+	free_pages((unsigned long) header_buffer, 0);
+
+	return 0;
+
+	/* 
+	 * Aborting. We need to...
+	 * - let the writer cleanup (if necessary)
+	 * - revert ranges to absolute values
+	 */
+write_image_header_abort3:
+	active_writer->ops.writer.write_header_cleanup();
+	
+write_image_header_abort2:
+	absolutise_ranges();
+
+	put_rangepages_list();
+
+	if (active_writer->ops.writer.post_load_ranges)
+		active_writer->ops.writer.post_load_ranges();
+
+write_image_header_abort1:
+	if (get_rangepages_list())
+		panic("Unable to allocate rangepageslist.");
+
+	absolutise_chain(&pagedir1.origranges);
+	absolutise_chain(&pagedir1.destranges);
+	absolutise_chain(&pagedir1.allocdranges);
+
+	put_rangepages_list();
+
+	free_pages((unsigned long) header_buffer, 0);
+	return -1;
+}
+
+extern int suspend_early_boot_message(int can_erase_image, char *reason, ...);
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
+		return suspend_early_boot_message(1, "Incorrect kernel version");
+	
+	if (sh->num_physpages != num_physpages)
+		return suspend_early_boot_message(1, "Incorrect memory size");
+
+	if (strncmp(sh->machine, system_utsname.machine, 65))
+		return suspend_early_boot_message(1, "Incorrect machine type");
+
+	if (strncmp(sh->version, system_utsname.version, 65))
+		return suspend_early_boot_message(1, "Incorrect version");
+
+	if (sh->num_cpus != num_online_cpus())
+		return suspend_early_boot_message(1, "Incorrect number of cpus");
+
+	if (sh->page_size != PAGE_SIZE)
+		return suspend_early_boot_message(1, "Incorrect PAGE_SIZE");
+
+	return 0;
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
+	struct suspend_plugin_ops * this_plugin;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->ops.filter.noresume_reset)
+			this_plugin->ops.filter.noresume_reset();
+	}
+}
+
+/* __read_primary_suspend_image
+ *
+ * Description:	Test for the existence of an image and attempt to load it.
+ * Returns:	Int. Zero if image found and pageset1 successfully loaded.
+ * 		Error if no image found or loaded.
+ */
+static int __read_primary_suspend_image(void)
+{			
+	int i, result = 0;
+	char * header_buffer = (char *) get_zeroed_page(GFP_ATOMIC);
+	struct suspend_header * suspend_header;
+	struct range * last_range_page = NULL;
+
+	if (!header_buffer)
+		return -ENOMEM;
+	
+	set_suspend_state(SUSPEND_RUNNING);
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
+	/* Check whether we've resumed before */
+	if (test_suspend_state(SUSPEND_RESUMED_BEFORE)) {
+		suspend_early_boot_message(1, NULL);
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
+	orig_mem_free = suspend_header->orig_mem_free;
+	memcpy((char *) &pagedir_resume,
+		(char *) &suspend_header->pagedir, sizeof(pagedir_resume));
+	unused_ranges = suspend_header->unused_ranges;
+	num_range_pages = suspend_header->num_range_pages;
+	suspend_result = suspend_header->param0;
+	if (!suspend_act_used)
+		suspend_action = suspend_header->param1;
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+	if (!suspend_dbg_used)
+		suspend_debug_state = suspend_header->param2;
+#endif
+	if (!suspend_lvl_used)
+		suspend_default_console_level = console_loglevel = suspend_header->param3;
+	clear_suspend_state(SUSPEND_IGNORE_LOGLEVEL);
+	pagedir1.pageset_size = pagedir_resume.pageset_size;
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
+		num_range_pages = pagedir1.pageset_size =
+			pagedir2.pageset_size = 0;
+		unused_ranges = NULL;
+		goto out;
+	}
+
+	suspend2_prepare_console();
+
+	/* Read range pages */
+	check_shift_keys(1, "About to read pagedir.");
+
+	for (i=0; i < num_range_pages; i++) {
+		/* Get a page into which we will load the data */
+		struct range * this_range_page = 
+			(struct range *) get_zeroed_page(GFP_ATOMIC);
+		if (!this_range_page) {
+			abort_suspend("Unable to allocate a pagedir.");
+			result = -ENOMEM;
+			noresume_reset_plugins();
+			goto outfreeingrangepages;
+		}
+
+		/* Link to previous page */
+		if (i == 0)
+			first_range_page = this_range_page;
+		else
+			*RANGEPAGELINK(last_range_page) =
+				(i | (unsigned long) this_range_page);
+
+		/* Read this page */
+		if ((result = active_writer->ops.writer.read_header_chunk(
+				(char *) this_range_page, PAGE_SIZE)) < 0) {
+			printk("Active writer's read_header_chunk routine "
+					"returned %d.\n", result);
+			free_page((unsigned long) this_range_page);
+			noresume_reset_plugins();
+			goto outfreeingrangepages;
+		}
+		
+		last_range_page = this_range_page;
+	}
+	
+	/* Set the last page's link to its index */
+	*RANGEPAGELINK(last_range_page) = i;
+
+	/* Clean up after reading the header */
+	if ((result = active_writer->ops.writer.read_header_cleanup())) {
+		noresume_reset_plugins();
+		goto outfreeingrangepages;
+	}
+
+	/* Okay.
+	 *
+	 * Now we need to move the range pages to a place such that they won't
+	 * get overwritten while being used when copying the original kernel
+	 * back. To achieve this, we need to absolutise them where they are
+	 * now, prepare a bitmap of pages that collide and then relativise the
+	 * range pages again. Having done that, we can relocate the range
+	 * pages so that they don't collide with the image being restored,
+	 * and absolutise them in that location.
+	 */
+	
+	if (get_rangepages_list()) {
+		result = -ENOMEM;
+		noresume_reset_plugins();
+		goto outfreeingrangepages;
+	}
+	
+	/* Absolutise ranges so they can be used for building the map of
+	 * pages that will be overwritten. */
+	absolutise_ranges();
+	absolutise_chain(&pagedir_resume.origranges);
+
+	/* Mark the pages used by the current and original kernels */
+ 	warmup_collision_cache();
+
+	/* Prepare to move the pages so they don't conflict */
+	relativise_chain(&pagedir_resume.origranges);
+	relativise_ranges();
+ 
+	/* Relocate the pages */
+	relocate_rangepages();
+
+	/* Make sure the rangepages list is correct */
+	put_rangepages_list();
+	get_rangepages_list();
+
+	/* Absolutise in final place */
+	absolutise_ranges();
+	
+	/* Done.
+	 *
+	 * Now we can absolutise all the pointers to the range chains.
+	 */
+
+	set_chain_names(&pagedir_resume);
+	
+	absolutise_chain(&pagedir_resume.origranges);
+	
+	/*
+	 * We don't want the original destination ranges (the locations where
+	 * the atomic copy of pageset1 was stored at suspend time); we release
+	 * the chain's elements before getting new ones. (The kernel running
+	 * right now could be using pages that were free when we suspended).
+	 */
+
+	absolutise_chain(&pagedir_resume.destranges);
+	
+	absolutise_chain(&pagedir_resume.allocdranges);
+
+	if (unused_ranges)
+		unused_ranges = RANGE_ABSOLUTE(unused_ranges);
+	
+	put_rangepages_list();
+
+	/* 
+	 * The active writer should be using chains to record where it stored
+	 * the data. Give it a chance to absolutise them.
+	 */
+	if (active_writer->ops.writer.post_load_ranges)
+		active_writer->ops.writer.post_load_ranges();
+
+	/* 
+	 * Get the addresses of pages into which we will load the kernel to
+	 * be copied back
+	 */
+	put_range_chain(&pagedir_resume.destranges);
+
+	if (get_pageset1_load_addresses()) {
+		result = -ENOMEM;
+		noresume_reset_plugins();
+		goto outfreeingrangepages;
+	}
+
+	/* Read the original kernel back */
+	check_shift_keys(1, "About to read pageset 1.");
+
+	if (read_pageset(&pagedir_resume, 1, 0)) {
+		prepare_status(1, 1, "Failed to read pageset 1.");
+		result = -EPERM;
+		noresume_reset_plugins();
+		goto outfreeingrangepages;
+	}
+
+	PRINTFREEMEM("after loading image.");
+	check_shift_keys(1, "About to restore original kernel.");
+	result = 0;
+
+	if (active_writer->ops.writer.mark_resume_attempted)
+		active_writer->ops.writer.mark_resume_attempted();
+
+out:
+	free_pages((unsigned long) header_buffer, 0);
+	return result;
+outfreeingrangepages:
+	//FIXME Test i post loop and reset memory structures.
+	{
+		int j;
+		struct range * this_range_page = first_range_page;
+		struct range * next_range_page;
+		for (j = 0; j < i; j++) {
+			next_range_page = (struct range *) 
+				(((unsigned long)
+				  *RANGEPAGELINK(this_range_page)) & PAGE_MASK);
+			free_page((unsigned long) this_range_page);
+			this_range_page = next_range_page;
+		}
+	}
+	goto out;
+}
+
+/* read_primary_suspend_image()
+ *
+ * Description:	Attempt to read the header and pageset1 of a suspend image.
+ * 		Handle the outcome, complaining where appropriate.
+ */
+int read_primary_suspend_image(void)
+{
+	int error;
+
+	error = __read_primary_suspend_image();
+
+	switch (error) {
+		case 0:
+		case -ENODATA:
+		case -EINVAL:	/* non fatal error */
+			MDELAY(1000);
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
+	abort_suspend("Error %d in read_primary_suspend_image",error);
+	return error;
+}
+
+/* read_secondary_pagedir()
+ *
+ * Description:	Read in part or all of pageset2 of an image, depending upon
+ * 		whether we are suspending and have only overwritten a portion
+ * 		with pageset1 pages, or are resuming and need to read them 
+ * 		all.
+ * Arguments:	Int. Boolean. Read only pages which would have been
+ * 		overwritten by pageset1?
+ * Returns:	Int. Zero if no error, otherwise the error value.
+ */
+int read_secondary_pagedir(int overwrittenpagesonly)
+{
+	int result = 0;
+
+	if (!pageset2_size)
+		return 0;
+
+	suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1,
+		      "Beginning of read_secondary_pagedir: ");
+
+	result = read_pageset(&pagedir2, 2, overwrittenpagesonly);
+
+	update_status(100, 100, NULL);
+	check_shift_keys(1, "Pagedir 2 read.");
+
+	suspend_message(SUSPEND_IO, SUSPEND_VERBOSE, 1, "\n");
+	return result;
+}


