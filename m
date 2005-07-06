Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261639AbVGFDbE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261639AbVGFDbE (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Jul 2005 23:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbVGFD2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Jul 2005 23:28:37 -0400
Received: from b3162.static.pacific.net.au ([203.143.238.98]:10137 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262072AbVGFCT3 convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Jul 2005 22:19:29 -0400
Subject: [PATCH] [37/48] Suspend2 2.1.9.8 for 2.6.12: 613-pageflags.patch
In-Reply-To: <11206164393426@foobar.com>
X-Mailer: gregkh_patchbomb
Date: Wed, 6 Jul 2005 12:20:43 +1000
Message-Id: <11206164434190@foobar.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Reply-To: Nigel Cunningham <nigel@suspend2.net>
To: linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7BIT
From: Nigel Cunningham <nigel@suspend2.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

diff -ruNp 614-plugins.patch-old/kernel/power/suspend2_core/plugins.c 614-plugins.patch-new/kernel/power/suspend2_core/plugins.c
--- 614-plugins.patch-old/kernel/power/suspend2_core/plugins.c	1970-01-01 10:00:00.000000000 +1000
+++ 614-plugins.patch-new/kernel/power/suspend2_core/plugins.c	2005-07-04 23:14:19.000000000 +1000
@@ -0,0 +1,341 @@
+/*
+ * kernel/power/plugins.c
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+#include "suspend.h"
+#include "plugins.h"
+
+struct list_head suspend_filters, suspend_writers, suspend_plugins;
+struct suspend_plugin_ops * active_writer = NULL;
+static int num_filters = 0, num_ui = 0;
+int num_writers = 0, num_plugins = 0;
+
+/*
+ * header_storage_for_plugins
+ *
+ * Returns the amount of space needed to store configuration
+ * data needed by the plugins prior to copying back the original
+ * kernel. We can exclude data for pageset2 because it will be
+ * available anyway once the kernel is copied back.
+ */
+unsigned long header_storage_for_plugins(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+	unsigned long bytes = 0;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->storage_needed)
+			bytes += this_plugin->storage_needed();
+	}
+
+	return bytes;
+}
+
+/*
+ * expected_compression_ratio
+ *
+ * Returns the expected ratio between the amount of memory
+ * to be saved and the amount of space required on the
+ * storage device.
+ */
+int expected_compression_ratio(void)
+{
+	struct suspend_plugin_ops * this_filter;
+	unsigned long ratio = 100;
+	
+	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+		if (this_filter->disabled)
+			continue;
+		if (this_filter->ops.filter.expected_compression)
+			ratio = ratio * this_filter->ops.filter.expected_compression() / 100;
+	}
+
+	return (int) ratio;
+}
+
+/*
+ * memory_for_plugins
+ *
+ * Returns the amount of memory requested by plugins for
+ * doing their work during the cycle.
+ */
+
+unsigned long memory_for_plugins(void)
+{
+	unsigned long bytes = 0;
+	struct suspend_plugin_ops * this_plugin;
+
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->memory_needed)
+			bytes += this_plugin->memory_needed();
+	}
+
+	return ((bytes + PAGE_SIZE - 1) >> PAGE_SHIFT);
+}
+
+/* find_plugin_given_name
+ * Functionality :	Return a plugin (if found), given a pointer
+ * 			to its name
+ */
+
+struct suspend_plugin_ops * find_plugin_given_name(char * name)
+{
+	struct suspend_plugin_ops * this_plugin, * found_plugin = NULL;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (!strcmp(name, this_plugin->name)) {
+			found_plugin = this_plugin;
+			break;
+		}			
+	}
+
+	return found_plugin;
+}
+
+/*
+ * print_plugin_debug_info
+ * Functionality   : Get debugging info from plugins into a buffer.
+ */
+int print_plugin_debug_info(char * buffer, int buffer_size)
+{
+	struct suspend_plugin_ops *this_plugin;
+	int len = 0;
+
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->print_debug_info) {
+			int result;
+			result = this_plugin->print_debug_info(buffer + len, 
+					buffer_size - len);
+			len += result;
+		}
+	}
+
+	return len;
+}
+
+/*
+ * suspend_register_plugin
+ *
+ * Register a plugin.
+ */
+int suspend_register_plugin(struct suspend_plugin_ops * plugin)
+{
+	if (find_plugin_given_name(plugin->name))
+		return -EBUSY;
+
+	switch (plugin->type) {
+		case FILTER_PLUGIN:
+			list_add_tail(&plugin->ops.filter.filter_list,
+					&suspend_filters);
+			num_filters++;
+			break;
+
+		case WRITER_PLUGIN:
+			list_add_tail(&plugin->ops.writer.writer_list,
+					&suspend_writers);
+			num_writers++;
+			break;
+
+		case MISC_PLUGIN:
+			break;
+
+		default:
+			printk("Hmmm. Plugin '%s' has an invalid type."
+				" It has been ignored.\n", plugin->name);
+			return -EINVAL;
+	}
+	list_add_tail(&plugin->plugin_list, &suspend_plugins);
+	num_plugins++;
+
+	return 0;	
+}
+
+/*
+ * suspend_unregister_plugin
+ *
+ * Remove a plugin.
+ */
+void suspend_unregister_plugin(struct suspend_plugin_ops * plugin)
+{
+	switch (plugin->type) {
+		case FILTER_PLUGIN:
+			list_del(&plugin->ops.filter.filter_list);
+			num_filters--;
+			break;
+
+		case WRITER_PLUGIN:
+			list_del(&plugin->ops.writer.writer_list);
+			num_writers--;
+			if (active_writer == plugin) {
+				active_writer = NULL;
+				set_suspend_state(SUSPEND_DISABLED);
+			}
+			break;
+		
+		case MISC_PLUGIN:
+			break;
+
+		default:
+			printk("Hmmm. Plugin '%s' has an invalid type."
+				" It has been ignored.\n", plugin->name);
+			return;
+	}
+	list_del(&plugin->plugin_list);
+	num_plugins--;
+}
+
+/*
+ * suspend_move_plugin_tail
+ *
+ * Rearrange plugins when reloading the config.
+ */
+void suspend_move_plugin_tail(struct suspend_plugin_ops * plugin)
+{
+	switch (plugin->type) {
+		case FILTER_PLUGIN:
+			if (num_filters > 1)
+				list_move_tail(&plugin->ops.filter.filter_list,
+						&suspend_filters);
+			break;
+
+		case WRITER_PLUGIN:
+			if (num_writers > 1)
+				list_move_tail(&plugin->ops.writer.writer_list,
+						&suspend_writers);
+			break;
+		
+		case MISC_PLUGIN:
+			break;
+		default:
+			printk("Hmmm. Plugin '%s' has an invalid type."
+				" It has been ignored.\n", plugin->name);
+			return;
+	}
+	if ((num_filters + num_writers + num_ui) > 1)
+		list_move_tail(&plugin->plugin_list, &suspend_plugins);
+}
+
+/*
+ * suspend2_initialise_plugins
+ *
+ * Get ready to do some work!
+ */
+int suspend2_initialise_plugins(int starting_cycle)
+{
+	struct suspend_plugin_ops * this_plugin;
+	int result;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->type == WRITER_PLUGIN && 
+				this_plugin != active_writer)
+			continue;
+		if (this_plugin->initialise) {
+			suspend_message(SUSPEND_MEMORY, SUSPEND_MEDIUM, 1,
+				"Initialising plugin %s.\n",
+				this_plugin->name);
+			if ((result = this_plugin->initialise(starting_cycle))) {
+				printk("%s didn't initialise okay.\n",
+						this_plugin->name);
+				return result;
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* 
+ * suspend2_cleanup_plugins
+ *
+ * Tell plugins the work is done.
+ */
+void suspend2_cleanup_plugins(int finishing_cycle)
+{
+	struct suspend_plugin_ops * this_plugin;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->type == WRITER_PLUGIN && 
+				this_plugin != active_writer)
+			continue;
+		if (this_plugin->cleanup) {
+			suspend_message(SUSPEND_MEMORY, SUSPEND_MEDIUM, 1,
+				"Cleaning up plugin %s.\n",
+				this_plugin->name);
+			this_plugin->cleanup(finishing_cycle);
+		}
+	}
+}
+
+/*
+ * get_next_filter
+ *
+ * Get the next filter in the pipeline.
+ */
+struct suspend_plugin_ops * 
+get_next_filter(struct suspend_plugin_ops * filter_sought)
+{
+	struct suspend_plugin_ops * last_filter = NULL, *this_filter = NULL;
+
+	list_for_each_entry(this_filter, &suspend_filters, ops.filter.filter_list) {
+		if (this_filter->disabled)
+			continue;
+		if ((last_filter == filter_sought) || (!filter_sought))
+			return this_filter;
+		last_filter = this_filter;
+	}
+
+	return active_writer;
+}
+
+/* suspend2_get_modules
+ * 
+ * Take a reference to modules so they can't go away under us.
+ */
+
+int suspend2_get_modules(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (!try_module_get(this_plugin->module)) {
+			/* Failed! Reverse gets and return error */
+			struct suspend_plugin_ops * this_plugin2;
+			list_for_each_entry(this_plugin2, &suspend_plugins, plugin_list) {
+				if (this_plugin == this_plugin2)
+					return -EINVAL;
+				module_put(this_plugin2->module);
+			}
+		}
+	}
+
+	return 0;
+}
+
+/* suspend2_put_modules
+ *
+ * Release our references to modules we used.
+ */
+
+void suspend2_put_modules(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		module_put(this_plugin->module);
+	}
+}
diff -ruNp 614-plugins.patch-old/kernel/power/suspend2_core/plugins.h 614-plugins.patch-new/kernel/power/suspend2_core/plugins.h
--- 614-plugins.patch-old/kernel/power/suspend2_core/plugins.h	1970-01-01 10:00:00.000000000 +1000
+++ 614-plugins.patch-new/kernel/power/suspend2_core/plugins.h	2005-07-05 23:48:59.000000000 +1000
@@ -0,0 +1,172 @@
+/*
+ * kernel/power/plugin.h
+ *
+ * Copyright (C) 2004-2005 Nigel Cunningham <nigel@suspend2.net>
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
+/* Per-plugin metadata */
+struct plugin_header {
+	char name[SUSPEND_MAX_PLUGIN_NAME_LENGTH];
+	int disabled;
+	int type;
+	int index;
+	int data_length;
+	unsigned long signature;
+};
+
+extern int num_plugins, num_writers;
+
+#define FILTER_PLUGIN 1
+#define WRITER_PLUGIN 2
+#define MISC_PLUGIN 4 // Block writer, eg.
+#define CHECKSUM_PLUGIN 5
+
+#define SUSPEND_ASYNC 0
+#define SUSPEND_SYNC  1
+
+#define SUSPEND_COMMON_IO_OPS \
+	/* Writing the image proper */ \
+	int (*write_chunk) (struct page * buffer_page); \
+\
+	/* Reading the image proper */ \
+	int (*read_chunk) (struct page * buffer_page, int sync); \
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
+	int (*storage_available) (void); // Maximum size of image we can save
+					  // (incl. space already allocated).
+	
+	int (*storage_allocated) (void);
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
+	int (*allocate_header_space) (int space_requested);
+	int (*allocate_storage) (int space_requested);
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
+	/* Prepare metadata to be saved (relativise/absolutise extents) */
+	int (*serialise_extents) (void);
+	int (*load_extents) (void);
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
+struct suspend_plugin_ops {
+	/* Functions common to all plugins */
+	int type;
+	char * name;
+	struct module * module;
+	int disabled;
+	struct list_head plugin_list;
+
+	/* Bytes! */
+	unsigned long (*memory_needed) (void);
+	unsigned long (*storage_needed) (void);
+
+	int (*print_debug_info) (char * buffer, int size);
+	int (*save_config_info) (char * buffer);
+	void (*load_config_info) (char * buffer, int len);
+	
+	/* Initialise & cleanup - general routines called
+	 * at the start and end of a cycle. */
+	int (*initialise) (int starting_cycle);
+	void (*cleanup) (int finishing_cycle);
+
+	int (*write_init) (int stream_number);
+	int (*write_cleanup) (void);
+
+	int (*read_init) (int stream_number);
+	int (*read_cleanup) (void);
+
+	union {
+		struct suspend_filter_ops filter;
+		struct suspend_writer_ops writer;
+	} ops;
+};
+
+extern struct suspend_plugin_ops * active_writer;
+extern struct list_head suspend_filters, suspend_writers, suspend_plugins;
+
+extern void prepare_console_plugins(void);
+extern void cleanup_console_plugins(void);
+
+extern struct suspend_plugin_ops * find_plugin_given_name(char * name);
+extern struct suspend_plugin_ops * get_next_filter(struct suspend_plugin_ops *);
+
+extern int suspend_register_plugin(struct suspend_plugin_ops * plugin);
+extern void suspend_move_plugin_tail(struct suspend_plugin_ops * plugin);
+
+extern unsigned long header_storage_for_plugins(void);
+extern unsigned long memory_for_plugins(void);
+
+extern int print_plugin_debug_info(char * buffer, int buffer_size);
+extern int suspend_register_plugin(struct suspend_plugin_ops * plugin);
+extern void suspend_unregister_plugin(struct suspend_plugin_ops * plugin);
+
+extern int suspend2_initialise_plugins(int starting_cycle);
+extern void suspend2_cleanup_plugins(int finishing_cycle);
+
+int suspend2_get_modules(void);
+void suspend2_put_modules(void);
+
+static inline void suspend_initialise_plugin_lists(void) {
+	INIT_LIST_HEAD(&suspend_filters);
+	INIT_LIST_HEAD(&suspend_writers);
+	INIT_LIST_HEAD(&suspend_plugins);
+}
+
+extern int expected_compression_ratio(void);

