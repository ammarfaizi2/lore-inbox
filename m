Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262768AbUKXRIh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262768AbUKXRIh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 Nov 2004 12:08:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262770AbUKXRHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 Nov 2004 12:07:20 -0500
Received: from pop5-1.us4.outblaze.com ([205.158.62.125]:1941 "HELO
	pop5-1.us4.outblaze.com") by vger.kernel.org with SMTP
	id S262768AbUKXREt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 Nov 2004 12:04:49 -0500
Subject: Suspend 2 merge: 39/51: Plugins support.
From: Nigel Cunningham <ncunningham@linuxmail.org>
Reply-To: ncunningham@linuxmail.org
To: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1101292194.5805.180.camel@desktop.cunninghams>
References: <1101292194.5805.180.camel@desktop.cunninghams>
Content-Type: text/plain
Message-Id: <1101298967.5805.350.camel@desktop.cunninghams>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Thu, 25 Nov 2004 00:01:03 +1100
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

A plugin is an extension to suspend, but not necessarily a module (I'm
trying to avoid confusing the terms). Plugins can make transformations
on pages of memory in the image (compress/encrypt...), write the image
(swapwriter, eg), provide I/O facilities (bootsplash/textmode) or be
'miscellaneous' (blockwriter that does the hard work for the swapwriter,
device mapper plugin that simply ensures enough memory is available for
the device mapper given the async I/O limit set).

This file handles registration & removal of plugins, as well as
invocation of some of the routines.

diff -ruN 829-plugins-old/kernel/power/plugins.c 829-plugins-new/kernel/power/plugins.c
--- 829-plugins-old/kernel/power/plugins.c	1970-01-01 10:00:00.000000000 +1000
+++ 829-plugins-new/kernel/power/plugins.c	2004-11-11 06:41:52.000000000 +1100
@@ -0,0 +1,372 @@
+/*
+ * kernel/power/plugin.c
+ *
+ * Copyright (C) 2004 Nigel Cunningham <ncunningham@linuxmail.org>
+ *
+ */
+
+#include <linux/suspend.h>
+#include <linux/module.h>
+
+#include "suspend.h"
+#include "plugins.h"
+
+struct list_head suspend_filters, suspend_writers, suspend_plugins, suspend_ui;
+int num_filters = 0, num_writers = 0, num_ui = 0, num_plugins = 0;
+struct suspend_plugin_ops * active_writer = NULL;
+struct suspend_plugin_ops * checksum_plugin = NULL;
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
+/* suspend_early_boot_message_plugins
+ *
+ * Call early_boot_message methods for plugins.
+ */
+void suspend_early_boot_message_plugins(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+
+	list_for_each_entry(this_plugin, &suspend_ui, ops.ui.ui_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->ops.ui.early_boot_message_prep)
+			this_plugin->ops.ui.early_boot_message_prep();
+	}
+}
+
+/* suspend_plugin_keypress
+ *
+ * Pass the keycode to plugins until one handles it.
+ */
+void suspend_plugin_keypress(unsigned int keycode)
+{
+	struct suspend_plugin_ops * this_plugin;
+
+	list_for_each_entry(this_plugin, &suspend_ui, ops.ui.ui_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->ops.ui.keypress)
+			if (this_plugin->ops.ui.keypress(keycode))
+				return;
+	}
+}
+
+/* post_kernel_restore_redraw
+ *
+ * Call UI plugins to allow them to redraw the screen after a restoration
+ * of the original kernel
+ */
+
+void suspend_post_restore_redraw(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+
+	list_for_each_entry(this_plugin, &suspend_ui, ops.ui.ui_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->ops.ui.post_kernel_restore_redraw)
+			this_plugin->ops.ui.post_kernel_restore_redraw();
+	}
+}
+
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
+extern int attempt_to_parse_resume_device(void);
+
+int suspend_initialise_plugin_lists(void) {
+	INIT_LIST_HEAD(&suspend_filters);
+	INIT_LIST_HEAD(&suspend_writers);
+	INIT_LIST_HEAD(&suspend_ui);
+	INIT_LIST_HEAD(&suspend_plugins);
+	return 0;
+}
+
+int suspend_register_plugin(struct suspend_plugin_ops * plugin)
+{
+	if (!num_plugins)
+		suspend_initialise_plugin_lists();
+	
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
+			if ((!active_writer) &&
+			    (!(test_suspend_state(SUSPEND_BOOT_TIME))))
+				attempt_to_parse_resume_device();
+			break;
+
+		case UI_PLUGIN:
+			list_add_tail(&plugin->ops.ui.ui_list,
+					&suspend_ui);
+			num_ui++;
+			break;
+
+		case MISC_PLUGIN:
+			break;
+
+		case CHECKSUM_PLUGIN:
+			if (!checksum_plugin)
+				checksum_plugin = plugin;
+			else
+				printk("Checksum plugin already registered!");
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
+			if (active_writer == plugin)
+				attempt_to_parse_resume_device();
+			break;
+		
+		case UI_PLUGIN:
+			list_del(&plugin->ops.ui.ui_list);
+			num_ui--;
+			break;
+		
+		case MISC_PLUGIN:
+			break;
+
+		case CHECKSUM_PLUGIN:
+			if (plugin == checksum_plugin)
+				checksum_plugin = NULL;
+			break;
+		default:
+			printk("Hmmm. Plugin '%s' has an invalid type."
+				" It has been ignored.\n", plugin->name);
+			return;
+	}
+	list_del(&plugin->plugin_list);
+	num_plugins--;
+}
+
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
+		case UI_PLUGIN:
+			if (num_ui > 1)
+				list_move_tail(&plugin->ops.ui.ui_list,
+						&suspend_ui);
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
+int initialise_suspend_plugins(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+	int result;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->initialise) {
+			suspend_message(SUSPEND_MEMORY, SUSPEND_MEDIUM, 1,
+				"Initialising plugin %s.\n",
+				this_plugin->name);
+			if ((result = this_plugin->initialise()))
+				return result;
+		}
+		PRINTFREEMEM("after initialising plugin");
+	}
+
+	return 0;
+}
+
+void cleanup_suspend_plugins(void)
+{
+	struct suspend_plugin_ops * this_plugin;
+	
+	list_for_each_entry(this_plugin, &suspend_plugins, plugin_list) {
+		if (this_plugin->disabled)
+			continue;
+		if (this_plugin->cleanup) {
+			suspend_message(SUSPEND_MEMORY, SUSPEND_MEDIUM, 1,
+				"Cleaning up plugin %s.\n",
+				this_plugin->name);
+			this_plugin->cleanup();
+			PRINTFREEMEM("after cleaning up plugin");
+		}
+	}
+}
+
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
+EXPORT_SYMBOL(get_next_filter);
+EXPORT_SYMBOL(suspend_register_plugin);
+EXPORT_SYMBOL(suspend_unregister_plugin);
+EXPORT_SYMBOL(max_async_ios);
+EXPORT_SYMBOL(active_writer);
+EXPORT_SYMBOL(suspend_filters);
+#ifdef CONFIG_SOFTWARE_SUSPEND_DEBUG
+EXPORT_SYMBOL(suspend_store_free_mem);
+#endif
+EXPORT_SYMBOL(suspend_post_restore_redraw);


